From: Paul Menzel <pmenzel+amd-gfx-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
Subject: [4.17-rc4+ regression] X server does not start anymore with
 segmentation fault in `r600_dri.so`
Date: Sun, 13 May 2018 11:01:16 +0200
Message-ID: <2118de0e-74cb-d10e-3ce2-166396d8336d@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------7160286BF7C1EB505ED6DF70"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: de-DE
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------7160286BF7C1EB505ED6DF70
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux AMD folks,


There is a regression introduced by a commit after Linux 4.17-rc4 
causing the X.Org X server start to fail with the Radeon module loaded 
on Debian Sid/unstable. The same Linux kernel build works with the 
modesetting driver on the same system (no module *radeon* loaded) and 
with i915 and the modesetting driver on a different system with Debian 
9.4 (Stretch/stable).

> [    16.263] xf86EnableIOPorts: failed to set IOPL for I/O (Operation not permitted)
> […]
> [    16.765] (EE) 0: /usr/lib/xorg/Xorg (xorg_backtrace+0x50) [0x5b4e60]
> [    16.766] (EE) 1: /usr/lib/xorg/Xorg (0x40d000+0x1abd92) [0x5b8d92]
> [    16.766] (EE) 2: linux-gate.so.1 (__kernel_rt_sigreturn+0x0) [0xb7f2ad5c]
> [    16.766] (EE) 3: /lib/i386-linux-gnu/libc.so.6 (0xb78a0000+0x140099) [0xb79e0099]
> [    16.766] (EE) 4: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x6698fd) [0xb69628fd]
> [    16.766] (EE) 5: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x43a7a8) [0xb67337a8]
> [    16.766] (EE) 6: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x66eab3) [0xb6967ab3]
> [    16.766] (EE) 7: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x66ee41) [0xb6967e41]
> [    16.767] (EE) 8: /usr/lib/i386-linux-gnu/dri/r600_dri.so (radeon_drm_winsys_create+0x902) [0xb6ab7942]
> [    16.767] (EE) 9: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x32e73) [0xb632be73]
> [    16.767] (EE) 10: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x50093e) [0xb67f993e]
> [    16.767] (EE) 11: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x3bcba3) [0xb66b5ba3]
> [    16.767] (EE) 12: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x3b7ef8) [0xb66b0ef8]
> [    16.767] (EE) 13: /usr/lib/i386-linux-gnu/libgbm.so.1 (0xb7236000+0x3ef5) [0xb7239ef5]
> [    16.767] (EE) 14: /usr/lib/i386-linux-gnu/libgbm.so.1 (0xb7236000+0x4230) [0xb723a230]
> [    16.767] (EE) 15: /usr/lib/i386-linux-gnu/libgbm.so.1 (gbm_create_device+0x58) [0xb7237cd8]
> [    16.768] (EE) 16: /usr/lib/xorg/modules/libglamoregl.so (glamor_egl_init+0x84) [0xb725ab04]
> [    16.768] (EE) 17: /usr/lib/xorg/modules/drivers/radeon_drv.so (0xb72e2000+0x52fef) [0xb7334fef]
> [    16.768] (EE) 18: /usr/lib/xorg/modules/drivers/radeon_drv.so (0xb72e2000+0x44b14) [0xb7326b14]
> [    16.768] (EE) 19: /usr/lib/xorg/Xorg (InitOutput+0xab7) [0x48e677]
> [    16.768] (EE) 20: /usr/lib/xorg/Xorg (0x40d000+0x3db81) [0x44ab81]
> [    16.768] (EE) 21: /usr/lib/xorg/Xorg (0x40d000+0x2723a) [0x43423a]
> [    16.769] (EE) 22: /lib/i386-linux-gnu/libc.so.6 (__libc_start_main+0xf1) [0xb78b8e81]
> [    16.769] (EE) 23: /usr/lib/xorg/Xorg (0x40d000+0x27278) [0x434278]

There is no error message in Linux.


Kind regards,

Paul

--------------7160286BF7C1EB505ED6DF70
Content-Type: text/x-log;
 name="Xorg.0.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Xorg.0.log"

[    16.002] 
X.Org X Server 1.19.6
Release Date: 2017-12-20
[    16.003] X Protocol Version 11, Revision 0
[    16.003] Build Operating System: Linux 4.9.0-5-amd64 i686 Debian
[    16.003] Current Operating System: Linux kodi 4.17.0-rc4+ #28 SMP Sat May 12 04:56:48 UTC 2018 i686
[    16.004] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.17.0-rc4+ root=UUID=128529e0-b8bb-4c7d-956d-ddf699036c8c ro noisapnp cryptomgr.notests quiet initcall_debug init=/lib/systemd/systemd-bootchart memory_corruption_check=1 memory_corruption_check_size=512k memory_corruption_check_period=5 iomem=relaxed apparmor=0
[    16.005] Build Date: 26 January 2018  05:11:03PM
[    16.005] xorg-server 2:1.19.6-1 (https://www.debian.org/support) 
[    16.005] Current version of pixman: 0.34.0
[    16.006] 	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
[    16.006] Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[    16.007] (==) Log file: "/home/kodi/.local/share/xorg/Xorg.0.log", Time: Sat May 12 07:16:14 2018
[    16.027] (==) Using system config directory "/usr/share/X11/xorg.conf.d"
[    16.031] (==) No Layout section.  Using the first Screen section.
[    16.032] (==) No screen section available. Using defaults.
[    16.032] (**) |-->Screen "Default Screen Section" (0)
[    16.032] (**) |   |-->Monitor "<default monitor>"
[    16.033] (==) No monitor specified for screen "Default Screen Section".
	Using a default monitor configuration.
[    16.034] (==) Automatically adding devices
[    16.034] (==) Automatically enabling devices
[    16.034] (==) Automatically adding GPU devices
[    16.034] (==) Max clients allowed: 256, resource mask: 0x1fffff
[    16.042] (WW) The directory "/usr/share/fonts/X11/cyrillic" does not exist.
[    16.043] 	Entry deleted from font path.
[    16.043] (WW) The directory "/usr/share/fonts/X11/100dpi/" does not exist.
[    16.043] 	Entry deleted from font path.
[    16.043] (WW) The directory "/usr/share/fonts/X11/75dpi/" does not exist.
[    16.043] 	Entry deleted from font path.
[    16.043] (WW) The directory "/usr/share/fonts/X11/Type1" does not exist.
[    16.043] 	Entry deleted from font path.
[    16.043] (WW) The directory "/usr/share/fonts/X11/100dpi" does not exist.
[    16.043] 	Entry deleted from font path.
[    16.043] (WW) The directory "/usr/share/fonts/X11/75dpi" does not exist.
[    16.043] 	Entry deleted from font path.
[    16.043] (==) FontPath set to:
	/usr/share/fonts/X11/misc,
	built-ins
[    16.043] (==) ModulePath set to "/usr/lib/xorg/modules"
[    16.043] (II) The server relies on udev to provide the list of input devices.
	If no devices become available, reconfigure udev or disable AutoAddDevices.
[    16.043] (II) Loader magic: 0x680720
[    16.043] (II) Module ABI versions:
[    16.043] 	X.Org ANSI C Emulation: 0.4
[    16.044] 	X.Org Video Driver: 23.0
[    16.044] 	X.Org XInput driver : 24.1
[    16.044] 	X.Org Server Extension : 10.0
[    16.047] (++) using VT number 1

[    16.055] (II) systemd-logind: took control of session /org/freedesktop/login1/session/_31
[    16.058] (II) xfree86: Adding drm device (/dev/dri/card0)
[    16.062] (II) systemd-logind: got fd for /dev/dri/card0 226:0 fd 11 paused 0
[    16.081] (--) PCI:*(0:0:1:0) 1002:9802:1002:9802 rev 0, Mem @ 0xe0000000/268435456, 0xf0100000/262144, I/O @ 0x00002000/256, BIOS @ 0x????????/131072
[    16.082] (II) LoadModule: "glx"
[    16.096] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[    16.118] (II) Module glx: vendor="X.Org Foundation"
[    16.118] 	compiled for 1.19.6, module version = 1.0.0
[    16.118] 	ABI class: X.Org Server Extension, version 10.0
[    16.118] (II) Applying OutputClass "Radeon" to /dev/dri/card0
[    16.118] 	loading driver: radeon
[    16.118] (==) Matched radeon as autoconfigured driver 0
[    16.118] (==) Matched ati as autoconfigured driver 1
[    16.119] (==) Matched ati as autoconfigured driver 2
[    16.119] (==) Matched modesetting as autoconfigured driver 3
[    16.119] (==) Matched fbdev as autoconfigured driver 4
[    16.119] (==) Matched vesa as autoconfigured driver 5
[    16.119] (==) Assigned the driver to the xf86ConfigLayout
[    16.119] (II) LoadModule: "radeon"
[    16.121] (II) Loading /usr/lib/xorg/modules/drivers/radeon_drv.so
[    16.129] (II) Module radeon: vendor="X.Org Foundation"
[    16.129] 	compiled for 1.19.6, module version = 18.0.1
[    16.129] 	Module class: X.Org Video Driver
[    16.129] 	ABI class: X.Org Video Driver, version 23.0
[    16.129] (II) LoadModule: "ati"
[    16.130] (II) Loading /usr/lib/xorg/modules/drivers/ati_drv.so
[    16.132] (II) Module ati: vendor="X.Org Foundation"
[    16.132] 	compiled for 1.19.6, module version = 18.0.1
[    16.132] 	Module class: X.Org Video Driver
[    16.132] 	ABI class: X.Org Video Driver, version 23.0
[    16.238] (II) LoadModule: "modesetting"
[    16.239] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.so
[    16.241] (II) Module modesetting: vendor="X.Org Foundation"
[    16.241] 	compiled for 1.19.6, module version = 1.19.6
[    16.241] 	Module class: X.Org Video Driver
[    16.241] 	ABI class: X.Org Video Driver, version 23.0
[    16.241] (II) LoadModule: "fbdev"
[    16.242] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
[    16.244] (II) Module fbdev: vendor="X.Org Foundation"
[    16.244] 	compiled for 1.19.0, module version = 0.4.4
[    16.244] 	Module class: X.Org Video Driver
[    16.244] 	ABI class: X.Org Video Driver, version 23.0
[    16.244] (II) LoadModule: "vesa"
[    16.245] (II) Loading /usr/lib/xorg/modules/drivers/vesa_drv.so
[    16.247] (II) Module vesa: vendor="X.Org Foundation"
[    16.247] 	compiled for 1.19.0, module version = 2.3.4
[    16.247] 	Module class: X.Org Video Driver
[    16.247] 	ABI class: X.Org Video Driver, version 23.0
[    16.247] (II) RADEON: Driver for ATI/AMD Radeon chipsets:
	ATI Radeon Mobility X600 (M24), ATI FireMV 2400,
	ATI Radeon Mobility X300 (M24), ATI FireGL M24 GL,
	ATI Radeon X600 (RV380), ATI FireGL V3200 (RV380),
	ATI Radeon IGP320 (A3), ATI Radeon IGP330/340/350 (A4),
	ATI Radeon 9500, ATI Radeon 9600TX, ATI FireGL Z1, ATI Radeon 9800SE,
	ATI Radeon 9800, ATI FireGL X2, ATI Radeon 9600, ATI Radeon 9600SE,
	ATI Radeon 9600XT, ATI FireGL T2, ATI Radeon 9650, ATI FireGL RV360,
	ATI Radeon 7000 IGP (A4+), ATI Radeon 8500 AIW,
	ATI Radeon IGP320M (U1), ATI Radeon IGP330M/340M/350M (U2),
	ATI Radeon Mobility 7000 IGP, ATI Radeon 9000/PRO, ATI Radeon 9000,
	ATI Radeon X800 (R420), ATI Radeon X800PRO (R420),
	ATI Radeon X800SE (R420), ATI FireGL X3 (R420),
	ATI Radeon Mobility 9800 (M18), ATI Radeon X800 SE (R420),
	ATI Radeon X800XT (R420), ATI Radeon X800 VE (R420),
	ATI Radeon X850 (R480), ATI Radeon X850 XT (R480),
	ATI Radeon X850 SE (R480), ATI Radeon X850 PRO (R480),
	ATI Radeon X850 XT PE (R480), ATI Radeon Mobility M7,
	ATI Mobility FireGL 7800 M7, ATI Radeon Mobility M6,
	ATI FireGL Mobility 9000 (M9), ATI Radeon Mobility 9000 (M9),
	ATI Radeon 9700 Pro, ATI Radeon 9700/9500Pro, ATI FireGL X1,
	ATI Radeon 9800PRO, ATI Radeon 9800XT,
	ATI Radeon Mobility 9600/9700 (M10/M11),
	ATI Radeon Mobility 9600 (M10), ATI Radeon Mobility 9600 (M11),
	ATI FireGL Mobility T2 (M10), ATI FireGL Mobility T2e (M11),
	ATI Radeon, ATI FireGL 8700/8800, ATI Radeon 8500, ATI Radeon 9100,
	ATI Radeon 7500, ATI Radeon VE/7000, ATI ES1000,
	ATI Radeon Mobility X300 (M22), ATI Radeon Mobility X600 SE (M24C),
	ATI FireGL M22 GL, ATI Radeon X800 (R423), ATI Radeon X800PRO (R423),
	ATI Radeon X800LE (R423), ATI Radeon X800SE (R423),
	ATI Radeon X800 XTP (R430), ATI Radeon X800 XL (R430),
	ATI Radeon X800 SE (R430), ATI Radeon X800 (R430),
	ATI FireGL V7100 (R423), ATI FireGL V5100 (R423),
	ATI FireGL unknown (R423), ATI Mobility FireGL V5000 (M26),
	ATI Mobility Radeon X700 XL (M26), ATI Mobility Radeon X700 (M26),
	ATI Radeon X550XTX, ATI Radeon 9100 IGP (A5),
	ATI Radeon Mobility 9100 IGP (U3), ATI Radeon XPRESS 200,
	ATI Radeon XPRESS 200M, ATI Radeon 9250, ATI Radeon 9200,
	ATI Radeon 9200SE, ATI FireMV 2200, ATI Radeon X300 (RV370),
	ATI Radeon X600 (RV370), ATI Radeon X550 (RV370),
	ATI FireGL V3100 (RV370), ATI FireMV 2200 PCIE (RV370),
	ATI Radeon Mobility 9200 (M9+), ATI Mobility Radeon X800 XT (M28),
	ATI Mobility FireGL V5100 (M28), ATI Mobility Radeon X800 (M28),
	ATI Radeon X850, ATI unknown Radeon / FireGL (R480),
	ATI Radeon X800XT (R423), ATI FireGL V5000 (RV410),
	ATI Radeon X700 XT (RV410), ATI Radeon X700 PRO (RV410),
	ATI Radeon X700 SE (RV410), ATI Radeon X700 (RV410),
	ATI Radeon X1800, ATI Mobility Radeon X1800 XT,
	ATI Mobility Radeon X1800, ATI Mobility FireGL V7200,
	ATI FireGL V7200, ATI FireGL V5300, ATI Mobility FireGL V7100,
	ATI FireGL V7300, ATI FireGL V7350, ATI Radeon X1600, ATI RV505,
	ATI Radeon X1300/X1550, ATI Radeon X1550, ATI M54-GL,
	ATI Mobility Radeon X1400, ATI Radeon X1550 64-bit,
	ATI Mobility Radeon X1300, ATI Radeon X1300, ATI FireGL V3300,
	ATI FireGL V3350, ATI Mobility Radeon X1450,
	ATI Mobility Radeon X2300, ATI Mobility Radeon X1350,
	ATI FireMV 2250, ATI Radeon X1650, ATI Mobility FireGL V5200,
	ATI Mobility Radeon X1600, ATI Radeon X1300 XT/X1600 Pro,
	ATI FireGL V3400, ATI Mobility FireGL V5250,
	ATI Mobility Radeon X1700, ATI Mobility Radeon X1700 XT,
	ATI FireGL V5200, ATI Radeon X2300HD, ATI Mobility Radeon HD 2300,
	ATI Radeon X1950, ATI Radeon X1900, ATI AMD Stream Processor,
	ATI RV560, ATI Mobility Radeon X1900, ATI Radeon X1950 GT, ATI RV570,
	ATI FireGL V7400, ATI Radeon 9100 PRO IGP,
	ATI Radeon Mobility 9200 IGP, ATI Radeon X1200, ATI RS740,
	ATI RS740M, ATI Radeon HD 2900 XT, ATI Radeon HD 2900 Pro,
	ATI Radeon HD 2900 GT, ATI FireGL V8650, ATI FireGL V8600,
	ATI FireGL V7600, ATI Radeon 4800 Series, ATI Radeon HD 4870 x2,
	ATI Radeon HD 4850 x2, ATI FirePro V8750 (FireGL),
	ATI FirePro V7760 (FireGL), ATI Mobility RADEON HD 4850,
	ATI Mobility RADEON HD 4850 X2, ATI FirePro RV770,
	AMD FireStream 9270, AMD FireStream 9250, ATI FirePro V8700 (FireGL),
	ATI Mobility RADEON HD 4870, ATI Mobility RADEON M98,
	ATI FirePro M7750, ATI M98, ATI Mobility Radeon HD 4650,
	ATI Radeon RV730 (AGP), ATI Mobility Radeon HD 4670,
	ATI FirePro M5750, ATI RV730XT [Radeon HD 4670], ATI RADEON E4600,
	ATI Radeon HD 4600 Series, ATI RV730 PRO [Radeon HD 4650],
	ATI FirePro V7750 (FireGL), ATI FirePro V5700 (FireGL),
	ATI FirePro V3750 (FireGL), ATI Mobility Radeon HD 4830,
	ATI Mobility Radeon HD 4850, ATI FirePro M7740, ATI RV740,
	ATI Radeon HD 4770, ATI Radeon HD 4700 Series, ATI RV610,
	ATI Radeon HD 2400 XT, ATI Radeon HD 2400 Pro,
	ATI Radeon HD 2400 PRO AGP, ATI FireGL V4000, ATI Radeon HD 2350,
	ATI Mobility Radeon HD 2400 XT, ATI Mobility Radeon HD 2400,
	ATI RADEON E2400, ATI FireMV 2260, ATI RV670, ATI Radeon HD3870,
	ATI Mobility Radeon HD 3850, ATI Radeon HD3850,
	ATI Mobility Radeon HD 3850 X2, ATI Mobility Radeon HD 3870,
	ATI Mobility Radeon HD 3870 X2, ATI Radeon HD3870 X2,
	ATI FireGL V7700, ATI Radeon HD3690, AMD Firestream 9170,
	ATI Radeon HD 4550, ATI Radeon RV710, ATI Radeon HD 4350,
	ATI Mobility Radeon 4300 Series, ATI Mobility Radeon 4500 Series,
	ATI FirePro RG220, ATI Mobility Radeon 4330, ATI RV630,
	ATI Mobility Radeon HD 2600, ATI Mobility Radeon HD 2600 XT,
	ATI Radeon HD 2600 XT AGP, ATI Radeon HD 2600 Pro AGP,
	ATI Radeon HD 2600 XT, ATI Radeon HD 2600 Pro, ATI Gemini RV630,
	ATI Gemini Mobility Radeon HD 2600 XT, ATI FireGL V5600,
	ATI FireGL V3600, ATI Radeon HD 2600 LE,
	ATI Mobility FireGL Graphics Processor, ATI Radeon HD 3470,
	ATI Mobility Radeon HD 3430, ATI Mobility Radeon HD 3400 Series,
	ATI Radeon HD 3450, ATI Radeon HD 3430, ATI FirePro V3700,
	ATI FireMV 2450, ATI Radeon HD 3600 Series, ATI Radeon HD 3650 AGP,
	ATI Radeon HD 3600 PRO, ATI Radeon HD 3600 XT,
	ATI Mobility Radeon HD 3650, ATI Mobility Radeon HD 3670,
	ATI Mobility FireGL V5700, ATI Mobility FireGL V5725,
	ATI Radeon HD 3200 Graphics, ATI Radeon 3100 Graphics,
	ATI Radeon HD 3300 Graphics, ATI Radeon 3000 Graphics, SUMO, SUMO2,
	ATI Radeon HD 4200, ATI Radeon 4100, ATI Mobility Radeon HD 4200,
	ATI Mobility Radeon 4100, ATI Radeon HD 4290, ATI Radeon HD 4250,
	AMD Radeon HD 6310 Graphics, AMD Radeon HD 6250 Graphics,
	AMD Radeon HD 6300 Series Graphics,
	AMD Radeon HD 6200 Series Graphics, PALM, CYPRESS,
	ATI FirePro (FireGL) Graphics Adapter, AMD Firestream 9370,
	AMD Firestream 9350, ATI Radeon HD 5800 Series,
	ATI Radeon HD 5900 Series, ATI Mobility Radeon HD 5800 Series,
	ATI Radeon HD 5700 Series, ATI Radeon HD 6700 Series,
	ATI Mobility Radeon HD 5000 Series, ATI Mobility Radeon HD 5570,
	ATI Radeon HD 5670, ATI Radeon HD 5570, ATI Radeon HD 5500 Series,
	REDWOOD, ATI Mobility Radeon Graphics, CEDAR, ATI FirePro 2270,
	ATI Radeon HD 5450, CAYMAN, AMD Radeon HD 6900 Series,
	AMD Radeon HD 6900M Series, Mobility Radeon HD 6000 Series, BARTS,
	AMD Radeon HD 6800 Series, AMD Radeon HD 6700 Series, TURKS, CAICOS,
	ARUBA, TAHITI, PITCAIRN, VERDE, OLAND, HAINAN, BONAIRE, KABINI,
	MULLINS, KAVERI, HAWAII
[    16.263] (II) modesetting: Driver for Modesetting Kernel Drivers: kms
[    16.263] (II) FBDEV: driver for framebuffer: fbdev
[    16.263] (II) VESA: driver for VESA chipsets: vesa
[    16.263] xf86EnableIOPorts: failed to set IOPL for I/O (Operation not permitted)
[    16.265] (II) [KMS] Kernel modesetting enabled.
[    16.266] (WW) Falling back to old probe method for modesetting
[    16.266] (WW) Falling back to old probe method for fbdev
[    16.266] (II) Loading sub module "fbdevhw"
[    16.266] (II) LoadModule: "fbdevhw"
[    16.266] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    16.268] (II) Module fbdevhw: vendor="X.Org Foundation"
[    16.268] 	compiled for 1.19.6, module version = 0.0.2
[    16.268] 	ABI class: X.Org Video Driver, version 23.0
[    16.268] (WW) Falling back to old probe method for vesa
[    16.269] (WW) VGA arbiter: cannot open kernel arbiter, no multi-card support
[    16.269] (II) RADEON(0): Creating default Display subsection in Screen section
	"Default Screen Section" for depth/fbbpp 24/32
[    16.269] (==) RADEON(0): Depth 24, (--) framebuffer bpp 32
[    16.269] (II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
[    16.269] (==) RADEON(0): Default visual is TrueColor
[    16.269] (==) RADEON(0): RGB weight 888
[    16.269] (II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
[    16.269] (--) RADEON(0): Chipset: "AMD Radeon HD 6310 Graphics" (ChipID = 0x9802)
[    16.269] (II) Loading sub module "fb"
[    16.269] (II) LoadModule: "fb"
[    16.270] (II) Loading /usr/lib/xorg/modules/libfb.so
[    16.272] (II) Module fb: vendor="X.Org Foundation"
[    16.273] 	compiled for 1.19.6, module version = 1.0.0
[    16.273] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    16.273] (II) Loading sub module "dri2"
[    16.273] (II) LoadModule: "dri2"
[    16.273] (II) Module "dri2" already built-in
[    16.274] (II) Loading sub module "glamoregl"
[    16.274] (II) LoadModule: "glamoregl"
[    16.274] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[    16.305] (II) Module glamoregl: vendor="X.Org Foundation"
[    16.305] 	compiled for 1.19.6, module version = 1.0.0
[    16.305] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    16.305] (II) glamor: OpenGL accelerated X.org driver based.
[    16.754] (EE) 
[    16.754] (EE) Backtrace:
[    16.765] (EE) 0: /usr/lib/xorg/Xorg (xorg_backtrace+0x50) [0x5b4e60]
[    16.766] (EE) 1: /usr/lib/xorg/Xorg (0x40d000+0x1abd92) [0x5b8d92]
[    16.766] (EE) 2: linux-gate.so.1 (__kernel_rt_sigreturn+0x0) [0xb7f2ad5c]
[    16.766] (EE) 3: /lib/i386-linux-gnu/libc.so.6 (0xb78a0000+0x140099) [0xb79e0099]
[    16.766] (EE) 4: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x6698fd) [0xb69628fd]
[    16.766] (EE) 5: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x43a7a8) [0xb67337a8]
[    16.766] (EE) 6: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x66eab3) [0xb6967ab3]
[    16.766] (EE) 7: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x66ee41) [0xb6967e41]
[    16.767] (EE) 8: /usr/lib/i386-linux-gnu/dri/r600_dri.so (radeon_drm_winsys_create+0x902) [0xb6ab7942]
[    16.767] (EE) 9: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x32e73) [0xb632be73]
[    16.767] (EE) 10: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x50093e) [0xb67f993e]
[    16.767] (EE) 11: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x3bcba3) [0xb66b5ba3]
[    16.767] (EE) 12: /usr/lib/i386-linux-gnu/dri/r600_dri.so (0xb62f9000+0x3b7ef8) [0xb66b0ef8]
[    16.767] (EE) 13: /usr/lib/i386-linux-gnu/libgbm.so.1 (0xb7236000+0x3ef5) [0xb7239ef5]
[    16.767] (EE) 14: /usr/lib/i386-linux-gnu/libgbm.so.1 (0xb7236000+0x4230) [0xb723a230]
[    16.767] (EE) 15: /usr/lib/i386-linux-gnu/libgbm.so.1 (gbm_create_device+0x58) [0xb7237cd8]
[    16.768] (EE) 16: /usr/lib/xorg/modules/libglamoregl.so (glamor_egl_init+0x84) [0xb725ab04]
[    16.768] (EE) 17: /usr/lib/xorg/modules/drivers/radeon_drv.so (0xb72e2000+0x52fef) [0xb7334fef]
[    16.768] (EE) 18: /usr/lib/xorg/modules/drivers/radeon_drv.so (0xb72e2000+0x44b14) [0xb7326b14]
[    16.768] (EE) 19: /usr/lib/xorg/Xorg (InitOutput+0xab7) [0x48e677]
[    16.768] (EE) 20: /usr/lib/xorg/Xorg (0x40d000+0x3db81) [0x44ab81]
[    16.768] (EE) 21: /usr/lib/xorg/Xorg (0x40d000+0x2723a) [0x43423a]
[    16.769] (EE) 22: /lib/i386-linux-gnu/libc.so.6 (__libc_start_main+0xf1) [0xb78b8e81]
[    16.769] (EE) 23: /usr/lib/xorg/Xorg (0x40d000+0x27278) [0x434278]
[    16.769] (EE) 
[    16.769] (EE) Segmentation fault at address 0x0
[    16.769] (EE) 
Fatal server error:
[    16.769] (EE) Caught signal 11 (Segmentation fault). Server aborting
[    16.769] (EE) 
[    16.769] (EE) 
Please consult the The X.Org Foundation support 
	 at http://wiki.x.org
 for help. 
[    16.769] (EE) Please also check the log file at "/home/kodi/.local/share/xorg/Xorg.0.log" for additional information.
[    16.770] (EE) 
[    16.800] (EE) Server terminated with error (1). Closing log file.

--------------7160286BF7C1EB505ED6DF70
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------7160286BF7C1EB505ED6DF70--
