; OrCAD Signals 快捷键脚本 (AutoHotkey v1.1)
; 用法：在 OrCAD Capture 原理图绘制界面中，把鼠标悬停在导线上，按 ` (反引号键，数字1左边)
; 动作：左键选中线 → 右键建立对象上下文 → 投递 Signals 命令 (id=14844) → Esc 关闭菜单
;
; 说明：Signals 命令只认"右键建立的对象上下文"，单纯左键选中会查到上一个网络；
; 三处延时各 100ms（总约 300ms）为实测稳定值，不建议再调低（调低会出现查到旧网络的问题）。
; 命令 id=14844 来自 OrCAD Capture 17.2/17.4 的菜单定义。
; 其他版本请打开 <安装目录>\share\orResources\OrCAD_Capture\XML\ENU\OrCAD_Capture.xml
; 搜索 ID_FOLLOW_SIGNAL，用其 <id> 值替换下方 PostMessage 中的 14844。
;
; 热键说明：默认 SC029（反引号 ` 键）。若想改为其他键：
;   s::    单键 S
;   !s::   Alt+S（! = Alt，^ = Ctrl，+ = Shift）
#SingleInstance Force
SetTitleMatchMode, 2
#IfWinActive ahk_exe Capture.exe

SC029::
    WinGet, hwnd, ID, OrCAD Capture ahk_exe Capture.exe
    Click, Left
    Sleep, 100
    Click, Right
    Sleep, 100
    PostMessage, 0x111, 14844, 0, , ahk_id %hwnd%
    Sleep, 100
    Send, {Esc}
return

#IfWinActive
