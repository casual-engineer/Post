REM disable sleep

powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg /change hibernate-timeout-ac 0
powercfg /change hibernate-timeout-dc 0

REM disable fast start up

powercfg /hibernate off

REM disable Wsearch service

net stop Wsearch
sc config Wsearch start= disabled

REM disable UAC

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorUser /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f

REM disable transparency

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul

REM adjust windows for best performance

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarTransparency /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewWatermark /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul

taskkill /f /im explorer.exe
start explorer.exe

REM rename computer to inspiron

wmic computersystem where name="%COMPUTERNAME%" call rename name="inspiron"

REM enable view file extensions

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul

REM disable recently viewed items

powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowFrequent' -Value 0"
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowRecent' -Value 0"

@echo off
cls

echo Disabling Windows 10 privacy settings...

REM Disable telemetry data collection
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f

REM Disable app access to location
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f

REM Disable advertising ID
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f

REM Disable Cortana
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "AllowCortana" /t REG_DWORD /d 0 /f

REM Disable web search in Start menu
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f

REM Disable tailored experiences and diagnostics
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f

REM Disable speech recognition
reg add "HKCU\SOFTWARE\Microsoft\Input\TIP\{DFFACDC5-679F-4156-8947-C5C76BC0B67F}" /v "EnableDesktopModeAutoInvoke" /t REG_DWORD /d 0 /f

REM Disable automatic handwriting learning
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v "LastHRUnsupervisedTraining" /t REG_DWORD /d 0 /f

REM disables background apps
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f

REM enable dark mode

@echo off

REM Check if dark mode is currently enabled
reg query HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme | findstr "0x1"
if %errorlevel% == 0 (
    REM Dark mode is enabled, switch to light mode
    reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 1 /f
    echo Dark mode is now disabled.
) else (
    REM Dark mode is disabled, switch to dark mode
    reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
    echo Dark mode is now enabled.
)

REM Refresh the explorer to apply changes immediately
taskkill /f /im explorer.exe
start explorer.exe

REM remove Windows metro apps

powershell -Command "Get-AppxPackage *3DViewer* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *Cortana* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *FeedbackHub* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *GetHelp* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *ZuneMusic* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *WindowsMaps* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *Microsoft.Payments* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *Microsoft.SolitaireCollection* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *MixedRealityPortal* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *ZuneVideo* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *Microsoft.Office.Desktop* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *MSPaint* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *People* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *SkypeApp* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *SoundRecorder* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *XboxApp* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *Microsoft.XboxGamingOverlay* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *Microsoft.XboxGameSpeechWindow* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *Microsoft.XboxIdentityProvider* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *Microsoft.XboxLive* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"

REM disables unnecessary services

sc stop DiagTrack
sc config DiagTrack start= disabled

sc stop DusmSvc
sc config DusmSvc start= disabled

sc stop lfsvc
sc config lfsvc start= disabled

sc stop themes
sc config themes start= disabled
