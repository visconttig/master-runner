#NoEnv
#SingleInstance Force
SendMode Input
DetectHiddenWindows On

; === USER SETTINGS ===
targetFolder := "C:\Users\visco\OneDrive\Desktop\html-projects"  ; Change this to your scripts folder
excludeSubDirs := ["legacy", "reference", "testing", "utilities"]  ; Subfolders to exclude (case-insensitive)
enableLogging := true
logFile := A_ScriptDir "\ahk-launch-log.txt"

; === WAIT FOR SYSTEM TO STABILIZE ===
Sleep, 3000

; === LOGGING FUNCTION ===
Log(msg) {
    global enableLogging, logFile
    if enableLogging
        FileAppend, %msg%`n, %logFile%
}

; === RECURSIVELY LAUNCH AHK FILES ===
Loop, Files, %targetFolder%\*.ahk, R
{
    fullPath := A_LoopFileFullPath
    relPath := SubStr(fullPath, StrLen(targetFolder) + 2) ; Relative path inside target folder
    
    ; Convert the relative path to lowercase for case-insensitive comparison
    StringLower, relPathLower, relPath

    ; Skip self or any script inside excluded subdirectories (case-insensitive)
    skip := false
    for index, excludeSubDir in excludeSubDirs {
        ; Convert excludeSubDir to lowercase
        StringLower, excludeSubDirLower, excludeSubDir

        ; Check if any of the excluded folder names appears in the relative path
        ; The folder name must be followed by a backslash, indicating it's a directory
        if (InStr(relPathLower, excludeSubDirLower . "\")) {
            skip := true
            break
        }
    }

    ; Skip the script itself (ensure we don’t launch the running master-runner)
    if (fullPath = A_ScriptFullPath or skip or InStr(fullPath, "master-runner.ahk"))
        continue ; Skip self and excluded subdirectories

    ; === TERMINATE EXISTING INSTANCES OF THE SCRIPT ===
    WinClose, %A_LoopFileName% ahk_class AutoHotkey

    if (ErrorLevel) {
        ; Terminate any running instance of the script
        Process, Close, %ErrorLevel%
        Log("Terminated: " . fullPath)
    }

    ; === RUN THE SCRIPT ===
    Run, %fullPath%
    Log("Launched: " . fullPath)
}

TrayTip, AHK Launcher, Scripts launched from:`n%targetFolder%, 4
