Dim objShell, scriptPath, arg
Set objShell = CreateObject("Wscript.Shell")

scriptPath = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) & "\RenameFromTender.ps1"
arg = ""

If WScript.Arguments.Count > 0 Then
    arg = """" & WScript.Arguments(0) & """"
End If

objShell.Run "powershell.exe -NoProfile -NoLogo -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & scriptPath & """ " & arg, 0, False
