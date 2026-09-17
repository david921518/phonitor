# Windows 11 主机通过 USB 与 iPhone 直连

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

## iPhone 系统信息

```shell
iOS 版本: 26.6.2
型号名称: iPhone SE
型号: MXCH2LL/A 
```

---

## 准备工作

| 项目 | 说明 |
| :--- | :--- |
| **PC 端** | 安装 **Sunshine**（开源串流服务端） |
| **iPhone 端** | 安装 **Moonlight**（App Store 免费下载） |
| **连接方式** | Lightning 数据线（USB 有线） |
| **iPhone 要求** | iOS 12 及以上 |

---

## 第一步：PC 端安装 Sunshine

1. 访问 Sunshine 的 GitHub 发布页，下载 `sunshine-windows-portable.zip` 便携版。
2. 解压后直接运行 `sunshine.exe`，会弹出一个命令行窗口，**不要关闭**。
3. 在浏览器中访问 `https://localhost:47990`，首次访问需创建用户名和密码，登录后进入后台。
4. （可选）在 **Configuration → General** 中将语言改为简体中文，保存后 Sunshine 会自动重启。

> **注意**：账号密码建议单独记录，Sunshine 的登录弹窗不会记住密码。

---

## 第二步：建立 USB 连接（Lightning 有线隧道）

通过 `usbmuxd` 建立 TCP 隧道。

### 1. 确保 usbmuxd 服务运行

在 Windows 上安装 **iTunes**（或独立的 Apple Mobile Device Support），它会自动在后台运行 `usbmuxd` 服务。

### 2. 用 iproxy 建立端口转发

`iproxy` 是 `libimobiledevice` 工具集中的端口转发工具。你需要将 Sunshine 使用的端口逐一转发：

```cmd
iproxy 47984 47984
iproxy 47989 47989
iproxy 48010 48010
```

可以下载安装 [libimobiledevice-windows 最新安装包](https://github.com/jrjr/libimobiledevice-windows/releases) 获取 iproxy.exe

> **端口说明**：Sunshine 默认以 **47989** 为基准端口，核心端口包括 TCP **47984、47989、48010** 以及 Web UI 的 **47990**。保持这些 `iproxy` 窗口运行，隧道才会持续有效。

### 3. 首次连接时信任电脑

iPhone 上会弹出“信任此电脑”的提示，点击**信任**并输入密码。

---

## 第三步：iPhone 端 Moonlight 连接

### 1. 安装 Moonlight

在 App Store 搜索 “Moonlight Game Streaming” 安装。

### 2. 手动添加主机

由于使用了 USB 隧道，Moonlight 的自动发现可能失效。点击右上角 **“+”**，选择 **“Add Host Manually”**，输入 IP 地址：

```shell
127.0.0.1
```

### 3. 配对

Moonlight 会显示一个 **4 位 PIN 码**。在 PC 的 Sunshine 后台 → **PIN** 选项卡中输入该 PIN，点击 Send 完成配对。

### 4. 开始串流

配对成功后，点击设备图标，选择 **“Desktop”**，即可开始串流。此时 iPad 上显示的就是 PC 主屏幕的完整镜像画面。

---

## 第四步：Moonlight 端优化设置

进入 Moonlight 设置，针对 iPhone SE2 建议如下：

| 设置项 | 推荐值 | 说明 |
| :--- | :--- | :--- |
| **分辨率** | 1280×720 | iPhone SE2 原生为 720P 负载更低 |
| **帧率** | 60 FPS | 手机性能有限，稳定 60 帧优先 |
| **码率** | 15–25 Mbps | USB 有线带宽充足，可适当提高 |
| **On-Screen Control** | 关闭 | 镜像模式下不需要虚拟手柄遮挡画面 |

## 常见问题排查

| 问题 | 解决方法 |
| :--- | :--- |
| **Moonlight 搜索不到主机** | USB 隧道下自动发现失效，必须手动添加 `127.0.0.1`，并确保所有 `iproxy` 窗口正常运行 |
| **配对失败** | 检查 iPhone 是否已点击“信任此电脑”；确认 `iproxy` 转发的端口与 Sunshine 实际使用端口一致 |
| **画面卡顿** | 降低 Moonlight 中的码率或分辨率；检查 USB 线缆质量；确认 iPhone 后台没有其他高负载应用 |

---

## 总结
