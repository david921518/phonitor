# Windows 11 主机与 iPad WiFi 版连接

---

## Windows 主机系统信息

### 设备信息

```shell
处理器: Intel(R) Core(TM) i5-8265U CPU @ 1.60GHz (1.80 GHz)
机带 RAM: 16.0 GB (15.9 GB 可用)
图形卡: NVIDIA GeForce MX250 (2 GB)
       Intel(R) UHD Graphics 620 (128 MB)
系统类型: 64 位操作系统, 基于 x64 的处理器
笔和触控: 没有可用于此显示器的笔或触控输入
```

### Windows 信息

```shell
版本: Windows 11 专业版
版本号: 25H2
操作系统版本: 26200.9457
功能包: Windows 功能体验包 1000.26100.360.0
```

---

## iPad 系统信息

```shell
软件版本: 15.8.8
型号名称: iPad Air 2
型号: MH1J2LL/A 
```

---

## Windows 11 主机开启 “移动热点” 与 iPad 通过 WiFi 连接

通过 Windows 11 的“移动热点”功能，让 iPad 通过 Wi-Fi 连接到 PC，是使用 Moonlight/Sunshine 进行串流最直接、稳定的方式。

### 准备工作

* **Windows 11 PC**：确保已安装 **Sunshine** 服务端（[下载地址](https://github.com/LizardByte/Sunshine/releases)）。
* **iPad Air 2 (A1566)**：从 App Store 下载 **Moonlight Game Streaming**。
* **网络环境(可选)**：确保 PC 本身已连接到互联网（通过以太网或 Wi-Fi），因为移动热点需要共享这个连接。

### 第一步：在 Windows 11 上开启移动热点

1. **打开设置**：按 `Win + I` 快捷键，或点击开始菜单选择“设置”。
2. **进入网络设置**：在左侧菜单点击“**网络和 Internet**”，然后在右侧找到并点击“**移动热点**”。
3. **配置热点**：
    * 在“**共享我的以下 Internet 连接**”下拉菜单中，选择你当前正在上网的连接（例如“以太网”或“WLAN”）。
    * 点击“**编辑**”按钮，设置一个**网络名称（SSID）**和**密码**（至少 8 位）。建议将“网络频段”设为“**任何可用频率**”或“**5 GHz**”以获得更好的速度。
4. **开启热点**：将“**移动热点**”开关拨到“**开**”的状态。

### 第二步：iPad 连接 PC 热点

1. 在 iPad 上打开“**设置**” > “**无线局域网**”。
2. 在 Wi-Fi 列表中找到你刚才设置的**网络名称（SSID）**。
3. 点击该网络，输入你设置的**密码**，然后点击“加入”。
4. 连接成功后，iPad 的状态栏会显示 Wi-Fi 图标。

### 第三步：配置 Sunshine 并获取 PC 的 IP 地址

1. **获取 PC 的 IP 地址**：在 PC 上打开“命令提示符”，输入 `ipconfig` 并回车。在输出结果中，找到“**无线局域网适配器 本地连接* X**”或类似名称的适配器，记下其 **IPv4 地址**（通常为 `192.168.137.1`）。这是 iPad 连接热点后，PC 在该网络中的地址。
2. **配置 Sunshine**：
    * 确保 Sunshine 正在运行（系统托盘有图标）。
    * 在浏览器中访问 Sunshine 的 Web 管理界面：`https://localhost:47990`。首次访问需创建管理员账号和密码。
    * 登录后，在“**Configuration**” > “**Audio/Video**”中，可以调整串流的分辨率、帧率等参数。对于 iPad Air 2，建议从 **1080p / 60 FPS** 开始，并根据实际流畅度调整。

### 第四步：在 iPad 上使用 Moonlight 配对并串流

1. 打开 iPad 上的 **Moonlight** 应用。
2. **添加主机**：如果 PC 未自动出现，点击右上角的“**+**”号，选择“**Add Host Manually**”。在“Host”栏输入上一步记录的 **PC 的 IPv4 地址**（例如 `192.168.137.1`），点击“OK”。
3. **配对**：点击刚刚添加的 PC 图标，Moonlight 会显示一个 **4 位 PIN 码**。
4. **在 Sunshine 中确认**：
    * 回到 PC 上的 Sunshine Web 管理界面。
    * 点击顶部菜单的“**PIN**”标签。
    * 输入 Moonlight 显示的 4 位 PIN 码，然后点击“**Send**”。
5. **开始串流**：配对成功后，Moonlight 中会显示可用的应用列表（如“**Desktop**”）。点击它即可开始在 iPad 上镜像/串流 PC 屏幕。

### 故障排除

* **iPad 搜索不到 PC**：确保 PC 的防火墙允许 Sunshine 通过。可以在 Windows 防火墙中为 Sunshine 程序添加入站规则，或暂时关闭防火墙测试。
* **连接卡顿或不稳定**：尝试在 Moonlight 的设置中**降低分辨率或码率**。同时，确保 PC 的移动热点频段设置为 **5 GHz**，以获得更稳定的连接。
* **画面延迟高**：在 Sunshine 的 Web 界面中，检查“**Encoder**”设置，优先选择硬件编码器（如 **NVENC**、**AMD AMF** 或 **Intel QuickSync**），这能显著降低编码延迟。
* **热点自动关闭**：Windows 11 的移动热点在无设备连接时会自动关闭。可以在“移动热点”设置中关闭“**节能**”选项来防止此情况。

---

## 总结
