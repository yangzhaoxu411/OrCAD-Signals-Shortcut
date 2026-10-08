; OrCAD Signals 快捷键脚本 (AutoHotkey v1.1)
; 用法：在 OrCAD Capture 中把鼠标悬停在导线上，按 Alt+S
; 动作：右键建立对象上下文 → Esc 关闭菜单 → 向主窗口发送 Signals 命令 (id=14844)
;
; 适配说明：命令 id=14844 来自 OrCAD Capture 17.2/17.4 的菜单定义。
; 其他版本请打开 <安装目录>\share\orResources\OrCAD_Capture\XML\ENU\OrCAD_Capture.xml
; 搜索 ID_FOLLOW_SIGNAL，用其 <id> 值替换下方 PostMessage 中的 14844。
#SingleInstance Force
SetTitleMatchMode, 2
#IfWinActive ahk_exe Capture.exe

!s::
    WinGet, hwnd, ID, OrCAD Capture ahk_exe Capture.exe
    Click, Right
    Sleep, 200
    Send, {Esc}
    Sleep, 150
    PostMessage, 0x111, 14844, 0, , ahk_id %hwnd%
return

#IfWinActive
