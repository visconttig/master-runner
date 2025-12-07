#SingleInstance Force
DetectHiddenWindows On
SetBatchLines, -1

; ====================================================================================================
; 🚨🚨🚨  D O   N O T   R E N A M E   O R   M O V E   T H I S   F O L D E R  🚨🚨🚨
; ====================================================================================================
;
; ⚠️  HEY FUTURE ME, READ THIS BEFORE YOU BREAK THE UNIVERSE AGAIN:
;
; This script **kills EVERY AutoHotkey.exe process** on sight.
; It is supposed to run ONCE at system startup, BEFORE the Master Runner.
; 
; The only thing protecting the world from an infinite AHK extinction loop is:
;
;     → The folder name:  ---safe boot script---
;     → Which is EXCLUDED in master-runner’s `excludeSubDirs`
;
; IF YOU:
;   • rename this folder ❌
;   • delete the “---safe boot script---” exclusion ❌
;   • move this file into another folder ❌
;   • let the Master Runner “discover” this script ❌
;
; THEN THIS WILL HAPPEN TO YOU AGAIN:
;
;   → Every AHK script will auto-launch
;   → This script will kill them ALL
;   → Master Runner will launch them again
;   → This script kills them again
;   → Infinite AHK genocide loop 💀♻️💀♻️💀♻️
;   → You will age 10 years in 5 minutes
;
; SO PLEASE.
; LEAVE IT IN THIS FOLDER.
; DO NOT RENAME IT.
; DO NOT LET MASTER RUNNER TOUCH IT.
;
; ====================================================================================================

; Kill all AHK processes
Loop
{
    Process, Exist, AutoHotkey.exe
    if (ErrorLevel = 0)
        break
    Process, Close, AutoHotkey.exe
    Sleep, 150
}

; Wipe Startup entries from both folders
FileDelete, %A_Startup%\*.lnk
FileDelete, %A_StartMenuCommon%\Programs\Startup\*.lnk

; Clear any old logs
FileDelete, %A_ScriptDir%\ahk-launch-log.txt

MsgBox, 64, AHK Safe Boot, Clean slate ready.
ExitApp
