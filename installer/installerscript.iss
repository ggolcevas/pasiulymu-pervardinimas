; Inno Setup skriptas skirtas įdiegti įrankį aktyvaus vartotojo paskyroje
; - Įkopijuoja failą RenameFromTender.ps1 į %LocalAppData%\TenderRenamer
; - Sukuria HKCU kontekstinį meniu, pririšta prie tender.xml failo
; - Administratoriaus teisių nereikalauja (PrivilegesRequired=lowest)

#define AppName        "Pasiūlymo failų pervardintojas"
#define AppVersion     "1.0.0"
#define Publisher      "Gediminas Golcevas"
#define InstallDirName "{localappdata}\TenderRenamer"   ; įdiegia aktyviam vartotojui

[Setup]
AppId={{5A1C3A9B-7C5F-4740-95B6-FA6D9F3D2CE3}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#Publisher}
DefaultDirName={#InstallDirName}
DisableDirPage=yes
DisableProgramGroupPage=yes
OutputBaseFilename=TenderRenamer-Setup
Compression=lzma
SolidCompression=yes
PrivilegesRequired=none
ShowLanguageDialog=no
;PrivilegesRequiredOverridesAllowed=dialog
UninstallDisplayIcon={sys}\WindowsPowerShell\v1.0\powershell.exe
WizardStyle=modern

[Languages]
Name: "lt"; MessagesFile: "compiler:Languages\Lithuanian.isl"


[Files]
; Patalpinkite RenameFromTender.ps1 failą prie šio .iss failo prieš kompiliuodami
Source: "RenameFromTender.ps1"; DestDir: "{app}"; Flags: ignoreversion

[Registry]
Root: HKCU; Subkey: "Software\Classes\SystemFileAssociations\.xml\shell\Pervardintojas"; \
    ValueType: string; ValueName: "MUIVerb"; ValueData: "Pasiūlymo failų pervadinimas"; \
    Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\Classes\SystemFileAssociations\.xml\shell\Pervardintojas"; \
    ValueType: string; ValueName: "Icon"; ValueData: "powershell.exe"
; Kontekstinis meniu matomas tik prie failo pavadinto tender.xml
Root: HKCU; Subkey: "Software\Classes\SystemFileAssociations\.xml\shell\Pervardintojas"; \
    ValueType: string; ValueName: "AppliesTo"; ValueData: "System.FileName:=""tender.xml"""

Root: HKCU; Subkey: "Software\Classes\SystemFileAssociations\.xml\shell\Pervardintojas\command"; \
    ValueType: string; ValueName: ""; \
    ValueData: """{sys}\WindowsPowerShell\v1.0\powershell.exe"" -NoProfile -NoLogo -ExecutionPolicy Bypass -File ""{app}\RenameFromTender.ps1"" ""%1"""; \
    Flags: uninsdeletekey

