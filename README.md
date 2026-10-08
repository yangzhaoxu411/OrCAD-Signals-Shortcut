# OrCAD Signals 快捷键工具（Alt+S 一键查网络）

在 OrCAD Capture 中查看某个网络（Net）的跨页分布，默认操作是：选中线 → 右键 → 点 Signals，步骤繁琐且没有快捷键。本工具用 AutoHotkey 把这一系列操作压缩成一个快捷键：**鼠标悬停在导线上按 `Alt+S`，直接弹出 Signals 面板**。

## 效果

按下 `Alt+S` 后自动完成：

1. 在鼠标位置右键（让 Capture 把该线设为当前对象，菜单会闪一下）；
2. `Esc` 关闭右键菜单；
3. 直接向 Capture 主窗口发送 Signals 内部命令，右侧弹出 Signals 导航面板，显示该网络在所有原理图页的分布，双击即可跳转。

## 适用版本

- ✅ 已实测：**OrCAD Capture 17.2**（17.4 同源，理论上通用）
- ⚠️ 16.6 及更早版本：本身带 Macro 菜单，可优先考虑宏方案；本脚本的命令 ID 也可能不同，需按下文"版本适配"修改
- ⚠️ OrCAD X（23.x+）：原生支持自定义快捷键（Edit → Preferences → Shortcuts），建议优先用原生功能

## 安装使用（2 分钟）

### 1. 安装 AutoHotkey v1.1

到官网下载并安装 **AutoHotkey 1.1**（注意是 1.1 版，不是 v2）：

https://www.autohotkey.com/download/1.1/

> 无需管理员权限的安装方式：下载安装包后，也可以选择解压/安装到用户目录。

### 2. 下载脚本

下载本仓库的 `OrCADSignals.ahk`，放到任意固定目录（例如 `C:\Tools\`）。

### 3. 运行

双击 `OrCADSignals.ahk`，系统托盘出现绿色 **H** 图标即生效。

### 4.（可选）开机自启动

1. 按 `Win + R`，输入 `shell:startup` 回车，打开启动文件夹；
2. 把 `OrCADSignals.ahk` 的快捷方式复制进去。

## 使用方法

1. 在 OrCAD Capture 原理图页面中，把**鼠标悬停在任意导线上**（无需先点选）；
2. 按 **`Alt + S`**；
3. 右侧弹出 Signals 面板，显示该网络在每页的分布，双击条目跳转并高亮。

连续查不同网络：直接把鼠标移到另一根线上再按 `Alt+S` 即可，无需其他操作。

## 自定义

用记事本打开 `OrCADSignals.ahk` 即可修改，改完后右键托盘 H 图标 → **Reload Script** 生效。

| 想改什么 | 改哪里 |
|---|---|
| 换快捷键 | 把 `!s` 改成其他组合：`!` = Alt，`^` = Ctrl，`+` = Shift，例如 `^!s` 表示 Ctrl+Alt+S |
| 右键菜单闪烁太久/太快 | 调整两处 `Sleep` 的毫秒数 |

## 版本适配（命令 ID 不同怎么办）

脚本里的 `14844` 是 Signals 命令在 17.2/17.4 中的内部 ID。如果按 `Alt+S` 后右键菜单闪了但 Signals 面板没弹出，在你的版本上这样查 ID：

1. 打开文件：`<Cadence安装目录>\share\orResources\OrCAD_Capture\XML\ENU\OrCAD_Capture.xml`
2. 搜索 `ID_FOLLOW_SIGNAL`，找到它下方的 `<id>数字</id>`
3. 用该数字替换脚本中 `PostMessage, 0x111, 14844, ...` 里的 `14844`

## 原理说明

本工具不模拟菜单点击（17.2/17.4 的右键菜单项没有键盘加速键，模拟不稳定），而是：

- 通过一次"右键 + Esc"让 Capture 建立当前对象上下文（这是 Signals 命令正确识别目标网络的关键，单纯左键选中会导致命令沿用上一次的结果）；
- 然后向 Capture 主窗口直接投递 `WM_COMMAND` 消息（命令 ID 14844，即菜单定义中的 `ID_FOLLOW_SIGNAL`），等效于点击菜单里的 Signals，但绕过了菜单交互，稳定可靠。

## 卸载

1. 右键托盘绿色 H 图标 → **Exit**；
2. 删除 `OrCADSignals.ahk` 及启动文件夹里的快捷方式（如有）；
3. 卸载 AutoHotkey（可选）。

## License

MIT
