#SingleInstance Force
DetectHiddenWindows On
SetBatchLines, -1

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
