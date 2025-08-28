#!z::Run "https://www.autohotkey.com"  ; Win+Alt+Z

^!n::  ; Ctrl+Alt+N
{
    if WinExist("Untitled - Notepad")
        WinActivate
    else
        Run "Notepad"
}

MsgBox "Hello, world!"

; Ctrl+Alt+Up    = Volume Up
; ^!Up::SoundSetVolume "+5"

; Ctrl+Alt+Down  = Volume Down
; ^!Down::SoundSetVolume "-5"

; Ctrl+Alt+M     = Toggle Mute
; ^!m::SoundSetMute -1



; ### Requires AutoHotkey v2.0 ###

; ============================
; Volume Control with OSD
; ============================

; Ctrl+Alt+Up    = Volume Up
^!Up:: ChangeVolume("+2")

; Ctrl+Alt+Down  = Volume Down
^!Down:: ChangeVolume("-2")

; Ctrl+Alt+M     = Toggle Mute
^!m:: ToggleMute()


; ============================
; Functions
; ============================

ChangeVolume(step) {
    SoundSetVolume(step, , ) ; relative adjustment
    ShowOSD()
}

ToggleMute() {
    SoundSetMute(-1)
    ShowOSD()
}

ShowOSD() {
    vol := SoundGetVolume()
    mute := SoundGetMute()

    static osd := Gui("+AlwaysOnTop -Caption +ToolWindow", "Volume OSD")
    static bar := osd.AddProgress("w200 h20 cGreen vBar Range0-100")
    static txt := osd.AddText("Center w200 vText")

    ; Update GUI
    if (mute) {
        bar.Value := 0
        txt.Value := "Muted"
    } else {
        bar.Value := vol
        txt.Value := Round(vol) "%"
    }

    ; Position: bottom center
    sw := A_ScreenWidth
    sh := A_ScreenHeight
    osd.Show("x" (sw//2 - 100) "y" (sh - 200))

    SetTimer(() => osd.Hide(), -1000) ; hide after 1 second
}
