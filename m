Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A38FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 11:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 325BC10E66E;
	Tue, 28 Apr 2026 11:37:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=xwax.org header.i=@xwax.org header.b="s1F6ilM0";
	dkim-atps=neutral
X-Greylist: delayed 2671 seconds by postgrey-1.36 at gabe;
 Tue, 28 Apr 2026 11:37:33 UTC
Received: from disco.pogo.org.uk (disco.pogo.org.uk [93.93.128.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BFA210E66E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 11:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xwax.org;
 s=swing; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Cc:
 Reply-To:In-Reply-To:References:Content-Transfer-Encoding:Content-ID:
 Content-Description; bh=DlDopI+ygQu0E70M/ZjOva5igy+Loxq8RWt6Q+BYRmA=; b=s1F6i
 lM0i8uPog5bcjWK4kfdlXA+Ju8zw79Vv+rWz0JT4r4F4jkIwgP3R+jtBS6KN+h1IeoA8j3eYuuaaw
 BSpFC70tNG3K7aW/Fx5ty5NKTiTTVhAO1ermcOdyUh2b5HjuWTidGw04i5JDz7RqVWa6gF0KeNsgi
 Q5GIZRDDrF+k=;
Received: from cpc93786-hari17-2-0-cust786.20-2.cable.virginm.net
 ([82.36.99.19] helo=tamla)
 by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2 (FreeBSD)) (envelope-from <mark@xwax.org>)
 id 1wHg3n-00000000Pfq-3QTD for amd-gfx@lists.freedesktop.org;
 Tue, 28 Apr 2026 11:52:59 +0100
Received: from localhost (tamla.pogo.org.uk [local])
 by tamla.pogo.org.uk (OpenSMTPD) with ESMTPA id 3ff335aa
 for <amd-gfx@lists.freedesktop.org>;
 Tue, 28 Apr 2026 11:52:59 +0100 (BST)
Date: Tue, 28 Apr 2026 11:52:59 +0100 (BST)
From: Mark Hills <mark@xwax.org>
To: amd-gfx@lists.freedesktop.org
Subject: Radeon Pro WX7100 regression since v6.19, no display
Message-ID: <832b0927-fff2-90b3-538c-8e1890f3f42c@xwax.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The last kernel I have been able to use is v6.19.3, because shortly after 
I lose functionality of my Radeon Pro WX7100.

Normally around the point udevd is run, I see a switch from "BIOS"-style 
console to some kind of framebuffer one, followed by launching Xorg.

With later kernels, around the time of udevd the displays (LG DualUp, 
DisplayPort) freeze and swich to "no signal". The host is alive to SSH.

I can boot the last 'good' kernel (v6.19.3) and today (v7.0.1), with the 
diff shown below.

There doesn't seem to be an obvious or visible error to investigate, 
mostly:

* No longer any information printed about connected displays

* The bad kernel is printing initialisation "successful" messages in a
  slow loop, which I presume is Xorg re-starting

* The missing "fb0: amdgpudrmfb frame buffer device" which is
  presumably by Xorg complains about no /dev/fb0

I hope this is a credible bug report and perhaps clear what's going on to 
those who understand how the parts (drm,amdgpu,fb,fbcon,modesetting) fit 
together.

At this stage a "bisect" would be quite involved, but not ruled out.

System is i5-6500, losely based on Slackware-current, I run my own kernel 
and rc scripts, with no initrd.

Thanks

-- 
Mark


$ diff -up <(grep -E '(amdgpu|drm|fb|fbcon)' dmesg.good) <(grep -E '(amdgpu|drm|fb|fbcon)' dmesg.bad)
--- /dev/fd/63	2026-04-28 11:18:51.152662564 +0100
+++ /dev/fd/62	2026-04-28 11:18:51.152662564 +0100
@@ -1,77 +1,75 @@
+Command line: root=/dev/sda2 fbcon=rotate_all:1 BOOT_IMAGE=vmlinuz 
+Kernel command line: root=/dev/sda2 fbcon=rotate_all:1 BOOT_IMAGE=vmlinuz 
+Unknown kernel command line parameters "fbcon=rotate_all:1", will be passed to user space.
 pci 0000:00:1c.4:   bridge window [mem 0xefb00000-0xefbfffff]
 pci 0000:0b:00.0: BAR 0 [mem 0xefb00000-0xefb03fff 64bit]
 pci 0000:00:1c.4:   bridge window [mem 0xefb00000-0xefbfffff]
 pci_bus 0000:0b: resource 1 [mem 0xefb00000-0xefbfffff]
+    fbcon=rotate_all:1
 ACPI: bus type drm_connector registered
-[drm] amdgpu kernel modesetting enabled.
-[drm] initializing kernel modesetting (POLARIS10 0x1002:0x67C4 0x1002:0x0B0D 0x00).
-[drm] register mmio base: 0xEFE00000
-[drm] register mmio size: 262144
-amdgpu 0000:01:00.0: amdgpu: detected ip block number 0 <vi_common>
-amdgpu 0000:01:00.0: amdgpu: detected ip block number 1 <gmc_v8_0>
-amdgpu 0000:01:00.0: amdgpu: detected ip block number 2 <tonga_ih>
-amdgpu 0000:01:00.0: amdgpu: detected ip block number 3 <gfx_v8_0>
-amdgpu 0000:01:00.0: amdgpu: detected ip block number 4 <sdma_v3_0>
-amdgpu 0000:01:00.0: amdgpu: detected ip block number 5 <powerplay>
-amdgpu 0000:01:00.0: amdgpu: detected ip block number 6 <dce_v11_0>
-amdgpu 0000:01:00.0: amdgpu: detected ip block number 7 <uvd_v6_0>
-amdgpu 0000:01:00.0: amdgpu: detected ip block number 8 <vce_v3_0>
+amdgpu 0000:01:00.0: initializing kernel modesetting (POLARIS10 0x1002:0x67C4 0x1002:0x0B0D 0x00).
+amdgpu 0000:01:00.0: register mmio base: 0xEFE00000
+amdgpu 0000:01:00.0: register mmio size: 262144
+amdgpu 0000:01:00.0: detected ip block number 0 <common_v1_0_0> (vi_common)
+amdgpu 0000:01:00.0: detected ip block number 1 <gmc_v8_1_0> (gmc_v8_0)
+amdgpu 0000:01:00.0: detected ip block number 2 <ih_v3_0_0> (tonga_ih)
+amdgpu 0000:01:00.0: detected ip block number 3 <gfx_v8_0_0> (gfx_v8_0)
+amdgpu 0000:01:00.0: detected ip block number 4 <sdma_v3_1_0> (sdma_v3_0)
+amdgpu 0000:01:00.0: detected ip block number 5 <smu_v1_0_0> (powerplay)
+amdgpu 0000:01:00.0: detected ip block number 6 <uvd_v6_3_0> (uvd_v6_0)
+amdgpu 0000:01:00.0: detected ip block number 7 <vce_v3_4_0> (vce_v3_0)
 amdgpu 0000:01:00.0: No more image in the PCI ROM
-amdgpu 0000:01:00.0: amdgpu: Fetched VBIOS from ROM BAR
-amdgpu: ATOM BIOS: 113-C9540101-103
-[drm] UVD is enabled in VM mode
-[drm] UVD ENC is enabled in VM mode
-[drm] VCE enabled in VM mode
+amdgpu 0000:01:00.0: Fetched VBIOS from ROM BAR
+amdgpu 0000:01:00.0: [drm] ATOM BIOS: 113-C9540101-103
+amdgpu 0000:01:00.0: [drm] UVD is enabled in VM mode
+amdgpu 0000:01:00.0: [drm] UVD ENC is enabled in VM mode
+amdgpu 0000:01:00.0: Found VCE firmware Version: 53.26 Binary ID: 3
+amdgpu 0000:01:00.0: [drm] VCE enabled in VM mode
 amdgpu 0000:01:00.0: vgaarb: deactivate vga console
-amdgpu 0000:01:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
-[drm] vm size is 128 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
-[drm] System can't access extended configuration space, please check!!
-amdgpu 0000:01:00.0: BAR 2 [mem 0xe0000000-0xe01fffff 64bit pref]: releasing
-amdgpu 0000:01:00.0: BAR 0 [mem 0xd0000000-0xdfffffff 64bit pref]: releasing
-amdgpu 0000:01:00.0: BAR 0 [mem 0xd0000000-0xdfffffff 64bit pref]: assigned
-amdgpu 0000:01:00.0: BAR 2 [mem 0xe0000000-0xe01fffff 64bit pref]: assigned
-amdgpu 0000:01:00.0: amdgpu: VRAM: 8192M 0x000000F400000000 - 0x000000F5FFFFFFFF (8192M used)
-amdgpu 0000:01:00.0: amdgpu: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
-[drm] Detected VRAM RAM=8192M, BAR=256M
-[drm] RAM width 256bits GDDR5
-[drm] amdgpu: 8192M of VRAM memory ready
-[drm] amdgpu: 20047M of GTT memory ready.
-[drm] GART: num cpu pages 65536, num gpu pages 65536
-[drm] PCIE GART of 256M enabled (table at 0x000000F400900000).
-[drm] Chained IB support enabled!
+amdgpu 0000:01:00.0: Trusted Memory Zone (TMZ) feature not supported
+amdgpu 0000:01:00.0: vm size is 128 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
+amdgpu 0000:01:00.0: System can't access extended configuration space, please check!!
+amdgpu 0000:01:00.0: VRAM: 8192M 0x000000F400000000 - 0x000000F5FFFFFFFF (8192M used)
+amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
+amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=8192M, BAR=256M
+amdgpu 0000:01:00.0: [drm] RAM width 256bits GDDR5
+amdgpu 0000:01:00.0:  8192M of VRAM memory ready
+amdgpu 0000:01:00.0:  20047M of GTT memory ready.
+amdgpu 0000:01:00.0: [drm] GART: num cpu pages 65536, num gpu pages 65536
+amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F400900000).
+amdgpu 0000:01:00.0: [drm] Chained IB support enabled!
 amdgpu: hwmgr_sw_init smu backed is polaris10_smu
-[drm] AMDGPU Display Connectors
-[drm] Connector 0:
-[drm]   DP-1
-[drm]   HPD6
-[drm]   DDC: 0x4868 0x4868 0x4869 0x4869 0x486a 0x486a 0x486b 0x486b
-[drm]   Encoders:
-[drm]     DFP1: INTERNAL_UNIPHY2
-[drm] Connector 1:
-[drm]   DP-2
-[drm]   HPD4
-[drm]   DDC: 0x4870 0x4870 0x4871 0x4871 0x4872 0x4872 0x4873 0x4873
-[drm]   Encoders:
-[drm]     DFP2: INTERNAL_UNIPHY2
-[drm] Connector 2:
-[drm]   DP-3
-[drm]   HPD1
-[drm]   DDC: 0x486c 0x486c 0x486d 0x486d 0x486e 0x486e 0x486f 0x486f
-[drm]   Encoders:
-[drm]     DFP3: INTERNAL_UNIPHY1
-[drm] Connector 3:
-[drm]   DP-4
-[drm]   HPD3
-[drm]   DDC: 0x4874 0x4874 0x4875 0x4875 0x4876 0x4876 0x4877 0x4877
-[drm]   Encoders:
-[drm]     DFP4: INTERNAL_UNIPHY
-[drm] Found UVD firmware Version: 1.130 Family ID: 16
-[drm] Found VCE firmware Version: 53.26 Binary ID: 3
-[drm] UVD and UVD ENC initialized successfully.
-[drm] VCE initialized successfully.
-amdgpu 0000:01:00.0: amdgpu: SE 4, SH per SE 1, CU per SH 9, active_cu_number 36
-amdgpu 0000:01:00.0: amdgpu: Using BACO for runtime pm
+amdgpu 0000:01:00.0: [drm] Found UVD firmware Version: 1.130 Family ID: 16
+amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
+amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
+amdgpu 0000:01:00.0: SE 4, SH per SE 1, CU per SH 9, active_cu_number 36
+amdgpu 0000:01:00.0: Using BACO for runtime pm
 [drm] Initialized amdgpu 3.64.0 for 0000:01:00.0 on minor 0
-fbcon: amdgpudrmfb (fb0) is primary device
-amdgpu 0000:01:00.0: [drm] fb0: amdgpudrmfb frame buffer device
 EXT4-fs (dm-9): mounted filesystem 21691fb4-85ac-422e-b598-3443874357d4 r/w with ordered data mode. Quota mode: disabled.
+amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F400900000).
+amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
+amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
+amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F400900000).
+amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
+amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
+amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F400900000).
+amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
+amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
+amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F400900000).
+amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
+amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
+amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F400900000).
+amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
+amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
+amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F400900000).
+amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
+amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
+amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F400900000).
+amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
+amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
+amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F400900000).
+amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
+amdgpu 0000:01:00.0: [drm] VCE initialized successfully.
+amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F400900000).
+amdgpu 0000:01:00.0: [drm] UVD and UVD ENC initialized successfully.
+amdgpu 0000:01:00.0: [drm] VCE initialized successfully.


$ grep -E '(amdgpu|EE|modeset)' /var/log/Xorg.0.log
[  1537.962] Current Operating System: Linux stax 7.0.2-mh #187 SMP PREEMPT Tue Apr 28 10:05:44 BST 2026 x86_64
        (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[  1537.963] (EE) dbus-core: error connecting to system bus: org.freedesktop.DBus.Error.NoServer (Failed to connect to socket /var/run/dbus/system_bus_socket: Connection refused)
[  1537.965] (==) Matched modesetting as autoconfigured driver 1
[  1537.966] (II) LoadModule: "amdgpu"
[  1537.966] (WW) Warning, couldn't open module amdgpu
[  1537.966] (EE) Failed to load module "amdgpu" (module does not exist, 0)
[  1537.966] (II) LoadModule: "modesetting"
[  1537.966] (II) Loading /usr/lib64/xorg/modules/drivers/modesetting_drv.so
[  1537.966] (II) Module modesetting: vendor="X.Org Foundation"
[  1537.966] (II) modesetting: Driver for Modesetting Kernel Drivers: kms
[  1537.966] (II) modeset(0): using drv /dev/dri/card0
[  1537.967] (EE) open /dev/fb0: No such file or directory
[  1537.967] (II) modeset(0): Using 24bpp hw front buffer with 32bpp shadow
[  1537.967] (II) modeset(0): Creating default Display subsection in Screen section
[  1537.967] (==) modeset(0): Depth 24, (==) framebuffer bpp 32
[  1537.967] (==) modeset(0): RGB weight 888
[  1537.967] (==) modeset(0): Default visual is TrueColor
[  1537.967] (**) modeset(0): Cannot use glamor with 24bpp packed fb
[  1537.967] (II) modeset(0): ShadowFB: preferred YES, enabled FORCE
[  1537.967] (II) modeset(0): Double-buffered shadow updates: off
[  1537.967] (WW) modeset(0): TearFree requires Glamor acceleration
[  1537.967] (WW) modeset(0): No outputs definitely connected, trying again...
[  1537.967] (WW) modeset(0): Unable to find connected outputs - setting 1024x768 initial framebuffer
[  1537.967] (==) modeset(0): Using gamma correction (1.0, 1.0, 1.0)
[  1537.967] (EE) modeset(0): No modes.
[  1537.967] (II) UnloadModule: "modesetting"
[  1537.967] (EE) Screen(s) found, but none have a usable configuration.
[  1537.967] (EE)
[  1537.967] (EE) no screens found(EE)
[  1537.967] (EE)
[  1537.967] (EE) Please also check the log file at "/var/log/Xorg.0.log" for additional information.
[  1537.967] (EE)
[  1537.967] (EE) Server terminated with error (1). Closing log file.


stax$ lsmod | grep -E '(amdgpu|fb|drm)'
amdgpu               5550080  0
drm_ttm_helper         16384  1 amdgpu
syscopyarea            12288  1 drm_ttm_helper
ttm                    77824  2 amdgpu,drm_ttm_helper
sysfillrect            12288  1 drm_ttm_helper
sysimgblt              12288  1 drm_ttm_helper
fb_sys_fops            12288  1 drm_ttm_helper
drm_client_lib         16384  1 amdgpu
amdxcp                 12288  1 amdgpu
drm_exec               12288  1 amdgpu
gpu_sched              49152  1 amdgpu
drm_buddy              16384  1 amdgpu
drm_suballoc_helper    16384  1 amdgpu
drm_display_helper    155648  1 amdgpu
drm_kms_helper        151552  4 drm_display_helper,amdgpu,drm_ttm_helper,drm_client_lib
drm                   524288  12 gpu_sched,drm_kms_helper,drm_exec,drm_suballoc_helper,drm_display_helper,drm_buddy,amdgpu,drm_ttm_helper,drm_client_lib,ttm,amdxcp
drm_panel_orientation_quirks    32768  1 drm
i2c_algo_bit           12288  1 amdgpu
fb                    114688  2 drm_kms_helper,drm_ttm_helper
video                  69632  1 amdgpu
font                   16384  1 fb
backlight              16384  4 video,drm_display_helper,amdgpu,drm
i2c_core               81920  6 i2c_algo_bit,drm_display_helper,i2c_smbus,amdgpu,i2c_i801,drm


$ zcat /proc/config.gz | grep -iE '(amdgpu|drm|fb)' | grep -v 'not set'
CONFIG_DRM=m
# DRM debugging options
# end of DRM debugging options
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_CLIENT=y
CONFIG_DRM_CLIENT_LIB=m
CONFIG_DRM_CLIENT_SELECTION=m
CONFIG_DRM_CLIENT_SETUP=y
# Supported DRM clients
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_CLIENT_DEFAULT_FBDEV=y
CONFIG_DRM_CLIENT_DEFAULT="fbdev"
# end of Supported DRM clients
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_DSC_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_TTM=m
CONFIG_DRM_EXEC=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_SUBALLOC_HELPER=m
CONFIG_DRM_SCHED=m
CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS=m
CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y
CONFIG_DRM_PANEL=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_FB=m
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_CORE=m
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
CONFIG_FB_SYSMEM_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_IOMEM_FOPS=m
CONFIG_FB_IOMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS_DEFERRED=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_CRYPTO_LIB_AESCFB=m

