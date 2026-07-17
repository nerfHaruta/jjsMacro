global chars := Map("0x000000", "yuki", "0xABE3FF", "todo", "0xAB0000", "yuji", "0x629FAA", "nanami") ;character array
chars.Default := "none" ;no character
global charID := chars.Default

setChar()

setChar() ;set character
{
    global charID
    charID := chars[PixelGetColor(1000, 990)]
    SoundPlay A_Desktop "\scripts\jjsSounds\" charID ".wav"
    Sleep 3000
    
}

checkChar(charRead) {
    return charRead = charID
}

z:: setChar()

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
    swap(280,100) 
    while GetKeyState("XButton2", "P") {
        swap(280,100)  
    }
}

XButton1::
{
   swap(500,105) 
    while GetKeyState("XButton1", "P") {
        swap(500,105)  
    }
}

swap(swapTime, swapSpeed){
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

#HotIf checkChar("yuji")
; + auto black flash
