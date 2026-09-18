#Requires AutoHotkey v2.0

charID := "none"
chars := ["yuki", "todo", "yuji", "nanami", "mahoraga"]

guido := Gui("","")
guido.BackColor := "Black"
charText := guido.Add("Text", "cWhite r2 x+20 y10", "current char: " charID)

charSelect := guido.AddDropDownList("x15 y+5", chars)

submit := guido.Add("Button", " cWhite x50 y+10", "Submit")
submit.onEvent("Click", (*) => saveChar())
guido.Show("w150")

saveChar() {
    global charID := charSelect.Text
    if(charID = ""){
        charID := "none"
    }
    charText.Text := "current char: " charID
    SoundPlay A_Desktop "\scripts\jjsSounds\" charID ".wav"
    Sleep(200)
    guido.Hide()
}

checkChar(charRead) {
    return charRead = charID
}

z:: {
    if WinExist("ahk_id " guido.Hwnd)
        guido.Hide()
    else
        guido.Show()
}

#z::
{
    MsgBox PixelGetColor(1000, 990)
}

#x::
{
    MouseGetPos &mouseX, &mouseY
    MsgBox PixelGetColor(mouseX, mouseY)
}

#SuspendExempt True
PgUp:: ;suspend
{
    if (A_IsSuspended) {
        SoundPlay A_Desktop "\scripts\soundBank\on.wav"
    } else {
        SoundPlay A_Desktop "\scripts\soundBank\off.wav"
    }
    Sleep 100
    Suspend -1
}

End:: { ;close program
    loop 3 {
        SoundPlay A_Desktop "\scripts\soundBank\off.wav"
        Sleep 260
    }
    ExitApp()
}

PgDn:: ;reload program
{
    SoundPlay A_Desktop "\scripts\soundBank\restart.wav"
    Sleep 500
    Reload
}
#SuspendExempt False

; + directional side dash function for no char

#HotIf checkChar("none")
/*
XButton2::{
    sideDash
}
*/
#HotIf checkChar("yuki")
XButton2:: {
    Send "1"
    Sleep 1100
    Send "1"
    Sleep 100
}
XButton1::
{
    Send "{1 down}"
    Sleep 700
    Send "{1 up}"
    Sleep 1800
    Send "1"
    Sleep 100
}

#HotIf checkChar("todo")
XButton2::
{
    swap(280, 100)
    while GetKeyState("XButton2", "P") {
        swap(280, 100)
    }
}

XButton1::
{
    swap(550, 70)
    while GetKeyState("XButton1", "P") {
        swap(550, 70)
    }
}

swap(swapTime, swapSpeed) {
    Sleep swapSpeed
    Send "r"
    Sleep swapTime
    Send "{Blind}{Click}"
    Sleep swapSpeed
}

#HotIf checkChar("nanami")
R::
ratioMacro(ThisHotkey) {
    static rCount := 0
    if rCount > 0 {
        rCount += 1
        return
    }
    rCount := 1
    send "r"
    SetTimer ratio, -450

    ratio() {
        if rCount = 1 {
            Send "r"
        }
        else if rCount >= 2 {
            Sleep 150
            Send "r"
        }
        rCount := 0
    }
}
Sleep 300

#HotIf checkChar("mahoraga")
3::
{
    Send "{3 down}"
    Sleep 800
    Send "{3 up}"
}

#HotIf checkChar("yuji")
; + auto black flash
