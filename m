Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D7CC47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 18:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954D410FD71;
	Fri, 26 Jan 2024 18:45:52 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9BC10FD6E
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 18:45:51 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-3bdb42da0e0so767968b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 10:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=umich.edu; s=google-2016-06-03; t=1706294689; x=1706899489;
 darn=lists.freedesktop.org; 
 h=user-agent:content-disposition:mime-version:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4ozLnDVxNZMw6Pt3xCW6o9Tsyp6uQYro7hxnlkFyqEo=;
 b=BHtuqNzT0BJ9Wc1PKVULBV8YP2MWhaJ6Etl8hvGXsdEkaDrrohCH9Sk3lForD0wRPn
 ALCElhKZA300Y2MoQJjhsyqvnPxBZ6YNSRN3XEXvbR2mwiIZT3w9Kev05Kb3jSa+e1jx
 QMRhuobEhlPLdb8+lYEJekv0jlnuCsi/k9qNx+PURBknjK/s5Z4Bwwd7aZjYyZimwtPF
 RkJ3AZyrmnpYCMLlwUmMrHZ1NY3lC44rCoS+HMmBJV7nNNqhNnDTeJ1r64vcAC1j4jso
 o8vfw3mP0pCWOh7fJoYtGEN0mw4oWiw5xMIxd8XaloT05XU5kEYRQiAL7ZJ6CANMEbMN
 JPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706294689; x=1706899489;
 h=user-agent:content-disposition:mime-version:message-id:subject:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ozLnDVxNZMw6Pt3xCW6o9Tsyp6uQYro7hxnlkFyqEo=;
 b=TAKY+kxB+2e1PzbQIilbrDstEzUGE7WK+bIVSGBbkdeS061o6rUYJFlsQljsTP23Ku
 SLraRsnjbcMP2yLl+EjO6Xez3MKgNcSoh2keRmkloPTggcTs/0FieHCSyWcRJUGC2a4/
 8FIulkKHUzyWLxtNE5tFqyiRj5/PwKkCg3aBSbEI9HbqCn8HVrXayG6OmiAKPdXgRRPg
 vSlyxx/dgmen1M3BUyOdwq6XhIsAMv1CaJAKSU5ZRenMNQXicU5IMIK3D76eDKL3Tbm7
 ijRANiWIW1K88czh+6gdU1Hzh/HGBIAh683NuqXQ6sH8a2APpPLPVCav+hsg+fYgFQDd
 B6WA==
X-Gm-Message-State: AOJu0YysStaey2Mz9wpdbDC3+0G07pLAMXTBdV11T39KPsyaPAtthNdc
 bGkBqzMLOijhbFYCfWtL8CV+966AWj81VIzjN9jcjtOFO213b1g4o/KbB06xfAmMTQjcOGCRjJs
 3HdOMyF2ut8KtY1WHT8otLauCJsLTCQ53qeWBVkWQgWDIQN/o4lZhGARNeDSt1NNYK5Mjz0UjZG
 7F8yvwl21ooPB5RWzx5WsKw1LazmkWSWcDhyie
X-Google-Smtp-Source: AGHT+IHA9pbOPZcNTvbelSVq+zxJmG6PLZrUbSJ2x2gNaNFH1DAlhz0HFFzNhIjIG5pbbwu2HqF0rA==
X-Received: by 2002:a05:6870:648c:b0:210:cac2:4419 with SMTP id
 cz12-20020a056870648c00b00210cac24419mr95282oab.38.1706294689375; 
 Fri, 26 Jan 2024 10:44:49 -0800 (PST)
Received: from localhost (162-232-88-33.lightspeed.livnmi.sbcglobal.net.
 [162.232.88.33]) by smtp.gmail.com with ESMTPSA id
 ci13-20020a056871c48d00b0021499bd351bsm460864oac.19.2024.01.26.10.44.48
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jan 2024 10:44:49 -0800 (PST)
Date: Fri, 26 Jan 2024 13:44:47 -0500
From: William Bulley <web@umich.edu>
To: amd-gfx@lists.freedesktop.org
Subject: Have WX 3200 Radeon graphics card -- cannot get X11 session to work
Message-ID: <20240126184447.GC660@dell4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
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

I am running FreeBSD 14.0-STABLE from January 4th.  I have read the
handbook and followed the instructions there.  I have these drivers:

unix# ls -al /usr/local/lib/xorg/modules/drivers
total 476
drwxr-xr-x  2 root wheel      8 Jan 21 14:18 .
drwxr-xr-x  5 root wheel     13 Jan 21 14:18 ..
-rwxr-xr-x  1 root wheel 146216 Jan  6 11:41 amdgpu_drv.so
-rwxr-xr-x  1 root wheel   7344 Jan 11 13:18 ati_drv.so
-rwxr-xr-x  1 root wheel 112320 Jan 21 14:18 modesetting_drv.so
-rwxr-xr-x  1 root wheel 501696 Jan 11 13:18 radeon_drv.so
-rwxr-xr-x  1 root wheel  19800 Jan  6 11:41 scfb_drv.so
-rwxr-xr-x  1 root wheel  27392 Jan  6 11:41 vesa_drv.so

I have these modules:

unix# cd /boot/modules
unix# ls -al *amdgpu*
-r--r--r--  1 root wheel 8581752 Jan 22 15:14 amdgpu.ko
<<plus hundreds of other amdgpu*.ko modules>>
unix# ls -al *kms*
-r--r--r--  1 root wheel 3013512 Jan 22 15:14 i915kms.ko
-r--r--r--  1 root wheel 2394600 Jan 22 15:14 radeonkms.ko

I have followed the instructions in the handbook Chapter 5.1
but have never gotten an x11 session to appear.  Whenever I
run startx as a non-root user, the error message is always
"(EE) no screens found".

The WX 3200 (RS780?) is a newer card, so I put this line in
my /etc/rc,conf file:

   kld_list+="amdgpu"

During the booting of the O/S these 90 lines appear in my
/var/log/messages file:

Jan 26 10:35:20 msi1 kernel: [drm] amdgpu kernel modesetting enabled.
Jan 26 10:35:20 msi1 kernel: drmn0: <drmn> on vgapci0
Jan 26 10:35:20 msi1 kernel: vgapci0: child drmn0 requested pci_enable_io
Jan 26 10:35:20 msi1 kernel: vgapci0: child drmn0 requested pci_enable_io
Jan 26 10:35:20 msi1 kernel: [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6981 0x1002:0x0B0D 0x10).
Jan 26 10:35:20 msi1 kernel: drmn0: Trusted Memory Zone (TMZ) feature not supported
Jan 26 10:35:20 msi1 kernel: [drm] register mmio base: 0xFCC00000
Jan 26 10:35:20 msi1 kernel: [drm] register mmio size: 262144
Jan 26 10:35:20 msi1 kernel: [drm] add ip block number 0 <vi_common>
Jan 26 10:35:20 msi1 kernel: [drm] add ip block number 1 <gmc_v8_0>
Jan 26 10:35:20 msi1 kernel: [drm] add ip block number 2 <tonga_ih>
Jan 26 10:35:20 msi1 kernel: [drm] add ip block number 3 <gfx_v8_0>
Jan 26 10:35:20 msi1 kernel: [drm] add ip block number 4 <sdma_v3_0>
Jan 26 10:35:20 msi1 kernel: [drm] add ip block number 5 <powerplay>
Jan 26 10:35:20 msi1 kernel: [drm] add ip block number 6 <dm>
Jan 26 10:35:20 msi1 kernel: [drm] add ip block number 7 <uvd_v6_0>
Jan 26 10:35:20 msi1 kernel: [drm] add ip block number 8 <vce_v3_0>
Jan 26 10:35:20 msi1 kernel: drmn0: Fetched VBIOS from VFCT
Jan 26 10:35:20 msi1 kernel: amdgpu: ATOM BIOS: 113-D0155100-101
Jan 26 10:35:20 msi1 kernel: [drm] UVD is enabled in VM mode
Jan 26 10:35:20 msi1 kernel: [drm] UVD ENC is enabled in VM mode
Jan 26 10:35:20 msi1 kernel: [drm] VCE enabled in VM mode
Jan 26 10:35:20 msi1 kernel: [drm] vm size is 256 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image 'amdgpu/polaris12_k_mc.bin'
Jan 26 10:35:20 msi1 kernel: drmn0: VRAM: 4096M 0x000000F400000000 - 0x000000F4FFFFFFFF (4096M used)
Jan 26 10:35:20 msi1 kernel: drmn0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
Jan 26 10:35:20 msi1 kernel: [drm] Detected VRAM RAM=4096M, BAR=4096M
Jan 26 10:35:20 msi1 kernel: [drm] RAM width 128bits GDDR5
Jan 26 10:35:20 msi1 kernel: [drm] amdgpu: 4096M of VRAM memory ready
Jan 26 10:35:20 msi1 kernel: [drm] amdgpu: 4096M of GTT memory ready.
Jan 26 10:35:20 msi1 kernel: [drm] GART: num cpu pages 65536, num gpu pages 65536
Jan 26 10:35:20 msi1 kernel: [drm] PCIE GART of 256M enabled (table at 0x000000F400300000).
Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image 'amdgpu/polaris12_pfp_2.bin'
Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image 'amdgpu/polaris12_me_2.bin'
Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image 'amdgpu/polaris12_ce_2.bin'
Jan 26 10:35:20 msi1 kernel: [drm] Chained IB support enabled!
Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image 'amdgpu/polaris12_rlc.bin'
Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image 'amdgpu/polaris12_mec_2.bin'
Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image 'amdgpu/polaris12_mec2_2.bin'
Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image 'amdgpu/polaris12_sdma.bin'
Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image 'amdgpu/polaris12_sdma1.bin'
Jan 26 10:35:20 msi1 kernel: amdgpu: hwmgr_sw_init smu backed is polaris10_smu
Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image 'amdgpu/polaris12_uvd.bin'
Jan 26 10:35:20 msi1 kernel: [drm] Found UVD firmware Version: 1.130 Family ID: 16
Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image 'amdgpu/polaris12_vce.bin'
Jan 26 10:35:20 msi1 kernel: [drm] Found VCE firmware Version: 53.26 Binary ID: 3
Jan 26 10:35:20 msi1 kernel: drmn0: successfully loaded firmware image 'amdgpu/polaris12_k_smc.bin'
Jan 26 10:35:20 msi1 kernel: [drm] Display Core initialized with v3.2.149!
Jan 26 10:35:20 msi1 kernel: lkpi_iic0: <LinuxKPI I2C> on drmn0
Jan 26 10:35:20 msi1 kernel: iicbus0: <Philips I2C bus> on lkpi_iic0
Jan 26 10:35:20 msi1 kernel: iic0: <I2C generic I/O> on iicbus0
Jan 26 10:35:20 msi1 kernel: lkpi_iic1: <LinuxKPI I2C> on drmn0
Jan 26 10:35:20 msi1 kernel: iicbus1: <Philips I2C bus> on lkpi_iic1
Jan 26 10:35:20 msi1 kernel: iic1: <I2C generic I/O> on iicbus1
Jan 26 10:35:20 msi1 kernel: lkpi_iic2: <LinuxKPI I2C> on drmn0
Jan 26 10:35:20 msi1 kernel: iicbus2: <Philips I2C bus> on lkpi_iic2
Jan 26 10:35:20 msi1 kernel: iic2: <I2C generic I/O> on iicbus2
Jan 26 10:35:20 msi1 kernel: lkpi_iic3: <LinuxKPI I2C> on drmn0
Jan 26 10:35:20 msi1 kernel: iicbus3: <Philips I2C bus> on lkpi_iic3
Jan 26 10:35:20 msi1 kernel: iic3: <I2C generic I/O> on iicbus3
Jan 26 10:35:20 msi1 kernel: [drm] UVD and UVD ENC initialized successfully.
Jan 26 10:35:20 msi1 kernel: [drm] VCE initialized successfully.
Jan 26 10:35:20 msi1 kernel: drmn0: SE 2, SH per SE 1, CU per SH 5, active_cu_number 10
Jan 26 10:35:20 msi1 kernel: [drm] fb mappable at 0x7E00830000
Jan 26 10:35:20 msi1 kernel: [drm] vram apper at 0x7E00000000
Jan 26 10:35:20 msi1 kernel: [drm] size 19906560
Jan 26 10:35:20 msi1 kernel: [drm] fb depth is 24
Jan 26 10:35:20 msi1 kernel: [drm]    pitch is 13824
Jan 26 10:35:20 msi1 kernel: VT: Replacing driver "efifb" with new "fb".
Jan 26 10:35:20 msi1 kernel: start FB_INFO:
Jan 26 10:35:20 msi1 kernel: type=11 height=1440 width=3440 depth=32
Jan 26 10:35:20 msi1 kernel: pbase=0x7e00830000 vbase=0xfffffe01ca830000
Jan 26 10:35:20 msi1 kernel: name=drmn0 flags=0x0 stride=13824 bpp=32
Jan 26 10:35:20 msi1 kernel: end FB_INFO
Jan 26 10:35:20 msi1 kernel: vgapci0: child drmn0 requested pci_get_powerstate
Jan 26 10:35:20 msi1 kernel: drmn0: Using BACO for runtime pm
Jan 26 10:35:20 msi1 kernel: sysctl_warn_reuse: can't re-use a leaf (hw.dri.debug)!
Jan 26 10:35:20 msi1 kernel: lkpi_iic4: <LinuxKPI I2C> on drm1
Jan 26 10:35:20 msi1 kernel: iicbus4: <Philips I2C bus> on lkpi_iic4
Jan 26 10:35:20 msi1 kernel: iic4: <I2C generic I/O> on iicbus4
Jan 26 10:35:20 msi1 kernel: lkpi_iic5: <LinuxKPI I2C> on drm2
Jan 26 10:35:20 msi1 kernel: iicbus5: <Philips I2C bus> on lkpi_iic5
Jan 26 10:35:20 msi1 kernel: iic5: <I2C generic I/O> on iicbus5
Jan 26 10:35:20 msi1 kernel: lkpi_iic6: <LinuxKPI I2C> on drm3
Jan 26 10:35:20 msi1 kernel: iicbus6: <Philips I2C bus> on lkpi_iic6
Jan 26 10:35:20 msi1 kernel: iic6: <I2C generic I/O> on iicbus6
Jan 26 10:35:20 msi1 kernel: lkpi_iic7: <LinuxKPI I2C> on drm4
Jan 26 10:35:20 msi1 kernel: iicbus7: <Philips I2C bus> on lkpi_iic7
Jan 26 10:35:20 msi1 kernel: iic7: <I2C generic I/O> on iicbus7
Jan 26 10:35:20 msi1 kernel: [drm] Initialized amdgpu 3.42.0 20150101 for drmn0 on minor 0

And finally the contents of my /var/log/Xorg.0.log file:

[    37.721] 
X.Org X Server 1.21.1.11
X Protocol Version 11, Revision 0
[    37.721] Current Operating System: FreeBSD unix 14.0-STABLE FreeBSD 14.0-STABLE #0 stable/14-n266191-8247b328ef0e: Thu Jan  4 06:38:16 UTC 2024     root@releng1.nyi.freebsd.org:/usr/obj/usr/src/amd64.amd64/sys/GENERIC amd64
[    37.721]  
[    37.721] Current version of pixman: 0.42.2
[    37.722] 	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
[    37.722] Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[    37.722] (==) Log file: "/var/log/Xorg.0.log", Time: Fri Jan 26 12:16:25 2024
[    37.722] (==) Using config directory: "/usr/local/etc/X11/xorg.conf.d"
[    37.722] (==) No Layout section.  Using the first Screen section.
[    37.722] (**) |-->Screen "Screen0" (0)
[    37.722] (**) |   |-->Monitor "Monitor0"
[    37.723] (**) |   |-->Device "Device0"
[    37.723] (==) Automatically adding devices
[    37.723] (==) Automatically enabling devices
[    37.723] (==) Automatically adding GPU devices
[    37.723] (==) Automatically binding GPU devices
[    37.723] (==) Max clients allowed: 256, resource mask: 0x1fffff
[    37.725] (==) FontPath set to:
	/usr/local/share/fonts/misc/,
	/usr/local/share/fonts/TTF/,
	/usr/local/share/fonts/OTF/,
	/usr/local/share/fonts/Type1/,
	/usr/local/share/fonts/100dpi/,
	/usr/local/share/fonts/75dpi/,
	catalogue:/usr/local/etc/X11/fontpath.d
[    37.725] (==) ModulePath set to "/usr/local/lib/xorg/modules"
[    37.725] (II) The server relies on udev to provide the list of input devices.
	If no devices become available, reconfigure udev or disable AutoAddDevices.
[    37.725] (II) Module ABI versions:
[    37.725] 	X.Org ANSI C Emulation: 0.4
[    37.725] 	X.Org Video Driver: 25.2
[    37.725] 	X.Org XInput driver : 24.4
[    37.725] 	X.Org Server Extension : 10.0
[    37.727] (--) PCI:*(41@0:0:0) 1002:6981:1002:0b0d rev 16, Mem @ 0x7e00000000/4294967296, 0x7f00000000/2097152, 0xfcc00000/262144, I/O @ 0x0000e000/256, BIOS @ 0x????????/65536
[    37.727] (II) LoadModule: "glx"
[    37.727] (II) Loading /usr/local/lib/xorg/modules/extensions/libglx.so
[    37.730] (II) Module glx: vendor="X.Org Foundation"
[    37.730] 	compiled for 1.21.1.11, module version = 1.0.0
[    37.730] 	ABI class: X.Org Server Extension, version 10.0
[    37.730] (II) LoadModule: "amdgpu"
[    37.730] (II) Loading /usr/local/lib/xorg/modules/drivers/amdgpu_drv.so
[    37.732] (II) Module amdgpu: vendor="X.Org Foundation"
[    37.732] 	compiled for 1.21.1.10, module version = 22.0.0
[    37.732] 	Module class: X.Org Video Driver
[    37.732] 	ABI class: X.Org Video Driver, version 25.2
[    37.732] (II) AMDGPU: Driver for AMD Radeon:
	All GPUs supported by the amdgpu kernel driver
[    37.732] (--) Using syscons driver with X support (version 2.0)
[    37.732] (--) using VT number 9

[    37.732] (II) AMDGPU(0): [KMS] Kernel modesetting enabled.
[    37.732] (EE) AMDGPU(0): [drm] Failed to open DRM device for pci:0000:29:00.0: No such file or directory
[    37.732] (WW) VGA arbiter: cannot open kernel arbiter, no multi-card support
[    37.732] (EE) Screen 0 deleted because of no matching config section.
[    37.732] (II) UnloadModule: "amdgpu"
[    37.732] (EE) Device(s) detected, but none match those in the config file.
[    37.732] (EE) 
Fatal server error:
[    37.732] (EE) no screens found(EE) 
[    37.732] (EE) 
Please consult the The X.Org Foundation support 
	 at http://wiki.x.org
 for help. 
[    37.732] (EE) Please also check the log file at "/var/log/Xorg.0.log" for additional information.
[    37.732] (EE) 
[    37.732] (EE) Server terminated with error (1). Closing log file.

I have nothing in my /etc/X11 directory, nor anything in my
/usr/local/etc/X11/xorg.conf.d directory.  Can anyone help
explain what I am doing wrong, or what I need to do to get
a working x11 session on my 3440 x 1440 resolution monitor?

-- 
William Bulley
E-MAIL: web@umich.edu
<web@umich.edu>
