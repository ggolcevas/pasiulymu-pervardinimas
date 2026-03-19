param([Parameter(Mandatory=$true, Position=0)][string]$XmlPath)
$ErrorActionPreference = 'Continue'

# --- Unikodo apdorojimas (PowerShell 5.1) ---
try {
  [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding($false)
  [Console]::InputEncoding  = New-Object System.Text.UTF8Encoding($false)
  $OutputEncoding           = New-Object System.Text.UTF8Encoding($false)
} catch {}
# (Nebūtinas, rūšiavimas ir formatavimas suderinamas su naudojama lokale)
try {
  [System.Threading.Thread]::CurrentThread.CurrentCulture   = 'lt-LT'
  [System.Threading.Thread]::CurrentThread.CurrentUICulture = 'lt-LT'
} catch {}

# --- loginimo nustatymai ---
$logDir = Join-Path $env:TEMP 'TenderRenamer'
New-Item -ItemType Directory -Path $logDir -Force | Out-Null
$early  = Join-Path $logDir ("{0:yyyyMMdd-HHmmss}-early.log" -f (Get-Date))
$sideLog = $null

function Log([string]$m){
  $ts = Get-Date -Format 'yyyy-MM-dd HH:mm:ss.fff'
  Write-Host "$ts  $m"
}

function Finalize-And-Pause {
#   try { Stop-Transcript | Out-Null } catch {}
#   try {
#     if ($sideLog -and (Test-Path -LiteralPath $sideLog)) { Start-Process notepad.exe $sideLog }
#     else { Start-Process notepad.exe $early }
#   } catch {}
   Read-Host "Paspauskite Enter"
   exit
}

# --- Pradedam ---
Log "==== Pradedamas pervardinimas ===="
Log "Arg      = $XmlPath"
Log "PWD      = $(Get-Location)"
Log "PS       = $($PSVersionTable.PSVersion)  Host=$($Host.Name)"

# Gaunam kelią, bet juo nepasitikim :)
$resolved = $null
try { $resolved = (Resolve-Path -LiteralPath $XmlPath -ErrorAction Stop).Path; Log "XML failo kelias = $resolved" }
catch { Log "Nepavyko rasti kelio: $($_.Exception.Message)" }
$xml = if ($resolved) { $resolved } else { $XmlPath }

# Sukuriamas log'as prie XMLo
# try { $sideLog = "$xml.rename.log" } catch { $sideLog = $null }
# try { Start-Transcript -Path $early -Append | Out-Null } catch {}
# if ($sideLog) { try { Start-Transcript -Path $sideLog -Append | Out-Null } catch {} }

# Pagalbininkai
function Sanitize([string]$n){
  $bad = [IO.Path]::GetInvalidFileNameChars() -join ''
  ($n -replace ("[{0}]" -f [Regex]::Escape($bad)), '_').Trim()
}
function Unique([string]$d,[string]$b,[string]$e){
  $i = 0
  $cand = Join-Path $d ($b+$e)
  while (Test-Path -LiteralPath $cand) { $i++; $cand = Join-Path $d ("{0} ({1}){2}" -f $b,$i,$e) }
  $cand
}

# Tikrinam ar yra XML
if (-not (Test-Path -LiteralPath $xml)) {
  Log "Klaida, nerastas XML: $xml"
  Finalize-And-Pause
}

# Randam FILES/files katalogą
$xmlDir  = Split-Path -Parent $xml
$filesDir = $null
foreach ($n in 'FILES','files') {
  $p = Join-Path $xmlDir $n
  if (Test-Path -LiteralPath $p -PathType Container) { $filesDir = $p; break }
}
if (-not $filesDir) {
  Log "Klaida: Nerastas 'FILES' arba 'files' katalogas prie pasirinkto XML failo: $xml"
  Finalize-And-Pause
}
Log "Naudojamas kelias: $filesDir"

# Užkraunam XML
# --- XML užkrovimas aptinkant enkodavimą ---
[xml]$doc = $null
try {
  $fs = [System.IO.File]::Open($xml, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
  try {
    $doc = New-Object System.Xml.XmlDocument
    $doc.Load($fs)   # XmlDocument aptinka reikiamą enkodavimą
  } finally {
    $fs.Dispose()
  }
  Log "XML sėkmingai apdorotas."
} catch {
  Log "Klaida apdorojant XML: $($_.Exception.Message)"
  Finalize-And-Pause
}

# Pasirenkam mazgus: //relevantDocuments[@documentId]
try { $nodes = $doc.SelectNodes("//relevantDocuments[@documentId]") }
catch { Log "Klaida XPath: $($_.Exception.Message)"; Finalize-And-Pause }

if (-not $nodes -or $nodes.Count -eq 0) {
  Log "Klaida: Nerasta jokių elemento <relevantDocuments documentId='...'> mazgų."
  Finalize-And-Pause
}
Log "Rasta mazgų: $($nodes.Count)"

# Failai reikalingame kataloge
$files = Get-ChildItem -LiteralPath $filesDir -File -ErrorAction SilentlyContinue
Log "Failų kataloge: $($files.Count)"

# Pervardinimo ciklas
$renamed = 0

foreach ($n in $nodes) {
  # Su PowerShell 5.1 suderinamas atributų/teksto paėmimas
  $guid = ''
  try { $guid = $n.GetAttribute('documentId') } catch {}
  if ($null -eq $guid) { $guid = '' }
  $guid = $guid.Trim()

  $fname = ''
  try {
    $fnNode = $n.SelectSingleNode('./fileName')
    if ($fnNode -ne $null) { $fname = [string]$fnNode.InnerText }
  } catch {}
  if ($null -eq $fname) { $fname = '' }
  $fname = $fname.Trim()

  Log "----"
  Log "GUID = $guid"
  Log "Pavadinimas = $fname"

  if ([string]::IsNullOrWhiteSpace($guid) -or [string]::IsNullOrWhiteSpace($fname)) {
    Log "Praleidžiam: nerastas guid arba failo pavadinimas"
    continue
  }

  # Ieškom pagal GUID
  $src = $files | Where-Object { $_.BaseName -ieq $guid } | Select-Object -First 1
  if (-not $src) {
    $re = "(?i)^{0}\." -f [Regex]::Escape($guid)
    $src = $files | Where-Object { $_.Name -match $re } | Select-Object -First 1
  }
  if (-not $src) { Log "Kataloge $filesDir nerastas failas atitinkantis GUID"; continue }
  Log ("Pirminis pavadinimas = {0}" -f $src.Name)

  # Sugeneruojam pavadinimą
  $ext  = [IO.Path]::GetExtension($fname)
  if (-not $ext) { $ext = $src.Extension }
  $base = [IO.Path]::GetFileNameWithoutExtension($fname)
  if (-not $base) { $base = $guid }
  $base = Sanitize $base

  $target = Unique $filesDir $base $ext
  $tname  = Split-Path -Leaf $target
  Log ("Tikslinis pavadinimas = {0}" -f $tname)

  try {
    Rename-Item -LiteralPath $src.FullName -NewName $tname -ErrorAction Stop
    Log ("Pervardinta: {0} -> {1}" -f $src.Name,$tname)
    $renamed++
  } catch {
    Log ("Klaida pervardinant: {0}" -f $_.Exception.Message)
  }
}

Log "Apibendrinimas: pervardinta $renamed failų."

