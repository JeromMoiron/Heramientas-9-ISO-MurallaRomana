Set objShell = CreateObject("WScript.Shell")

' Ejecutar comando auditpol /set
objShell.Run "auditpol /set /subcategory:""Inicio de sesi�n"" /success:enable /failure:enable", 0, True

' Ejecutar comando auditpol /get
objShell.Run "auditpol /get /subcategory:""Inicio de sesi�n""", 1, True
