Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E3EC41535
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Dec 2023 17:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2087E10E0C7;
	Sat, 16 Dec 2023 17:46:52 +0000 (UTC)
X-Greylist: delayed 591 seconds by postgrey-1.36 at gabe;
 Sat, 16 Dec 2023 17:46:50 UTC
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A888610E0C7
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Dec 2023 17:46:50 +0000 (UTC)
Received: from tux.applied-asynchrony.com (p5ddd7509.dip0.t-ipconnect.de
 [93.221.117.9])
 by mail.itouring.de (Postfix) with ESMTPSA id E4B83103703
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Dec 2023 18:36:57 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
 by tux.applied-asynchrony.com (Postfix) with ESMTP id 580A1F01600
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Dec 2023 18:36:57 +0100 (CET)
To: amd-gfx@lists.freedesktop.org
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: Regression in 6.6: trying to set DPMS mode kills radeon (r600)
Organization: Applied Asynchrony, Inc.
Message-ID: <c31dc9e8-b969-c736-709c-382c032f4979@applied-asynchrony.com>
Date: Sat, 16 Dec 2023 18:36:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Hi,

since the last regression in 6.6.x was so popular I thought I'd post another
one. :)

The good news first: the symptoms described below do *not* reproduce with
6.7-rc5-git as of today (c8e97fc6b4c0), and there's an acceptable workaround
for 6.6.x as well.

The affected machine is an older SandyBridge dektop with a fanless
r600 Redwood GPU, using the radeon driver. "Recently" - some time
after the last few 6.6.x stable updates - it started to die with GPU
lockups. I first blamed this on standby/resume - because why not? - but
this turned out to be wrong; the real culprit is DPMS.

I use xfce-power-manager as "screensaver" to turn off the display after
inacitvity. This can be configured in two ways: "suspend" and "poweroff".
I've been using "poweroff" since forever without problems, until now.

The symptom is that everything works fine until the screensaver kicks in
and tries to turn the monitor off, which sends the radeon driver and the GPU
into a complete tailspin.

Here is the GPU during boot - all good:

Dec 12 12:47:54 ragnarok kernel: [drm] radeon kernel modesetting enabled.
Dec 12 12:47:54 ragnarok kernel: Console: switching to colour dummy device 80x25
Dec 12 12:47:54 ragnarok kernel: radeon 0000:01:00.0: vgaarb: deactivate vga console
Dec 12 12:47:54 ragnarok kernel: [drm] initializing kernel modesetting (REDWOOD 0x1002:0x68DA 0x1043:0x0376 0x00).
Dec 12 12:47:54 ragnarok kernel: ATOM BIOS: 68DA.12.19.0.3.AS01
Dec 12 12:47:54 ragnarok kernel: radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
Dec 12 12:47:54 ragnarok kernel: radeon 0000:01:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
Dec 12 12:47:54 ragnarok kernel: [drm] Detected VRAM RAM=1024M, BAR=256M
Dec 12 12:47:54 ragnarok kernel: [drm] RAM width 128bits DDR
Dec 12 12:47:54 ragnarok kernel: [drm] radeon: 1024M of VRAM memory ready
Dec 12 12:47:54 ragnarok kernel: [drm] radeon: 1024M of GTT memory ready.
Dec 12 12:47:54 ragnarok kernel: [drm] Loading REDWOOD Microcode
Dec 12 12:47:54 ragnarok kernel: [drm] Internal thermal controller without fan control
Dec 12 12:47:54 ragnarok kernel: [drm] radeon: dpm initialized
Dec 12 12:47:54 ragnarok kernel: [drm] GART: num cpu pages 262144, num gpu pages 262144
Dec 12 12:47:54 ragnarok kernel: [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
Dec 12 12:47:54 ragnarok kernel: [drm] PCIE GART of 1024M enabled (table at 0x000000000014C000).
Dec 12 12:47:54 ragnarok kernel: radeon 0000:01:00.0: WB enabled
Dec 12 12:47:54 ragnarok kernel: radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00
Dec 12 12:47:54 ragnarok kernel: radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c
Dec 12 12:47:54 ragnarok kernel: radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x000000000005c418
Dec 12 12:47:54 ragnarok kernel: radeon 0000:01:00.0: radeon: MSI limited to 32-bit
Dec 12 12:47:54 ragnarok kernel: radeon 0000:01:00.0: radeon: using MSI.
Dec 12 12:47:54 ragnarok kernel: [drm] radeon: irq initialized.
Dec 12 12:47:54 ragnarok kernel: [drm] ring test on 0 succeeded in 1 usecs
Dec 12 12:47:54 ragnarok kernel: [drm] ring test on 3 succeeded in 2 usecs
Dec 12 12:47:54 ragnarok kernel: [drm] ring test on 5 succeeded in 1 usecs
Dec 12 12:47:54 ragnarok kernel: [drm] UVD initialized successfully.
Dec 12 12:47:54 ragnarok kernel: [drm] ib test on ring 0 succeeded in 0 usecs
Dec 12 12:47:54 ragnarok kernel: [drm] ib test on ring 3 succeeded in 0 usecs
Dec 12 12:47:55 ragnarok kernel: [drm] ib test on ring 5 succeeded
Dec 12 12:47:55 ragnarok kernel: [drm] Radeon Display Connectors
Dec 12 12:47:55 ragnarok kernel: [drm] Connector 0:
Dec 12 12:47:55 ragnarok kernel: [drm]   HDMI-A-1
Dec 12 12:47:55 ragnarok kernel: [drm]   HPD2
Dec 12 12:47:55 ragnarok kernel: [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x645c 0x645c
Dec 12 12:47:55 ragnarok kernel: [drm]   Encoders:
Dec 12 12:47:55 ragnarok kernel: [drm]     DFP1: INTERNAL_UNIPHY2
Dec 12 12:47:55 ragnarok kernel: [drm] Connector 1:
Dec 12 12:47:55 ragnarok kernel: [drm]   DVI-I-1
Dec 12 12:47:55 ragnarok kernel: [drm]   HPD1
Dec 12 12:47:55 ragnarok kernel: [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
Dec 12 12:47:55 ragnarok kernel: [drm]   Encoders:
Dec 12 12:47:55 ragnarok kernel: [drm]     DFP2: INTERNAL_UNIPHY1
Dec 12 12:47:55 ragnarok kernel: [drm]     CRT1: INTERNAL_KLDSCP_DAC1
Dec 12 12:47:55 ragnarok kernel: [drm] Connector 2:
Dec 12 12:47:55 ragnarok kernel: [drm]   VGA-1
Dec 12 12:47:55 ragnarok kernel: [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478 0x647c 0x647c
Dec 12 12:47:55 ragnarok kernel: [drm]   Encoders:
Dec 12 12:47:55 ragnarok kernel: [drm]     CRT2: INTERNAL_KLDSCP_DAC2
Dec 12 12:47:55 ragnarok kernel: [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
Dec 12 12:47:55 ragnarok kernel: [drm] fb mappable at 0xE034D000
Dec 12 12:47:55 ragnarok kernel: [drm] vram apper at 0xE0000000
Dec 12 12:47:55 ragnarok kernel: [drm] size 9216000
Dec 12 12:47:55 ragnarok kernel: [drm] fb depth is 24
Dec 12 12:47:55 ragnarok kernel: [drm]    pitch is 7680
Dec 12 12:47:55 ragnarok kernel: fbcon: radeondrmfb (fb0) is primary device
Dec 12 12:47:55 ragnarok kernel: Console: switching to colour frame buffer device 240x75
Dec 12 12:47:55 ragnarok kernel: radeon 0000:01:00.0: [drm] fb0: radeondrmfb frame buffer device

Eventually the screensaver tries to switch off the monitor via DPMS "poweroff" method and
this greatly upsets the GPU:

Dec 12 20:39:59 ragnarok kernel: radeon 0000:01:00.0: ring 0 stalled for more than 10140msec
Dec 12 20:39:59 ragnarok kernel: radeon 0000:01:00.0: GPU lockup (current fence id 0x0000000000000002 last fence id 0x0000000000000003 on ring 0)

The above repeats many times until:

Dec 12 20:40:18 ragnarok kernel: radeon 0000:01:00.0: GPU lockup (current fence id 0x0000000000000002 last fence id 0x0000000000000003 on ring 0)
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0: Saved 55 dwords of commands on ring 0.
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0: GPU softreset: 0x00000008
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   GRBM_STATUS               = 0xA0003828
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   GRBM_STATUS_SE0           = 0x00000007
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   GRBM_STATUS_SE1           = 0x00000007
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   SRBM_STATUS               = 0x200000C0
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   SRBM_STATUS2              = 0x00000000
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   R_008674_CP_STALLED_STAT1 = 0x00000000
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   R_008678_CP_STALLED_STAT2 = 0x00010100
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   R_00867C_CP_BUSY_STAT     = 0x00020180
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   R_008680_CP_STAT          = 0x80038042
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   R_00D034_DMA_STATUS_REG   = 0x44C83D57
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0: GRBM_SOFT_RESET=0x00004001
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0: SRBM_SOFT_RESET=0x00000100
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   GRBM_STATUS               = 0x00003828
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   GRBM_STATUS_SE0           = 0x00000007
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   GRBM_STATUS_SE1           = 0x00000007
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   SRBM_STATUS               = 0x200000C0
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   SRBM_STATUS2              = 0x00000000
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   R_008674_CP_STALLED_STAT1 = 0x00000000
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   R_008678_CP_STALLED_STAT2 = 0x00000000
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   R_00867C_CP_BUSY_STAT     = 0x00000000
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   R_008680_CP_STAT          = 0x00000000
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0:   R_00D034_DMA_STATUS_REG   = 0x44C83D57
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0: GPU reset succeeded, trying to resume
Dec 12 20:40:19 ragnarok kernel: [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
Dec 12 20:40:19 ragnarok kernel: [drm] PCIE GART of 1024M enabled (table at 0x000000000014C000).
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0: WB enabled
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c
Dec 12 20:40:19 ragnarok kernel: radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x000000000005c418
Dec 12 20:40:19 ragnarok kernel: debugfs: File 'radeon_ring_gfx' in directory '0' already present!
Dec 12 20:40:19 ragnarok kernel: debugfs: File 'radeon_ring_dma1' in directory '0' already present!
Dec 12 20:40:19 ragnarok kernel: [drm:r600_ring_test [radeon]] *ERROR* radeon: ring 0 test failed (scratch(0x8504)=0xCAFEDEAD)
Dec 12 20:40:19 ragnarok kernel: [drm:evergreen_resume [radeon]] *ERROR* evergreen startup failed on resume
Dec 12 20:40:29 ragnarok kernel: radeon 0000:01:00.0: ring 0 stalled for more than 10077msec
Dec 12 20:40:29 ragnarok kernel: radeon 0000:01:00.0: GPU lockup (current fence id 0x0000000000000002 last fence id 0x0000000000000003 on ring 0)

..at which point I have to poweroff the entire machine to reset the GPU; a simple
reboot does not help.

It took me a while to find the culprit (the DPMS poweroff method), and for now
my workaround is to switch xfce-power-manager to use the "suspend" method instead.
This has been working reliably for several days now, with many system suspend/resume
and display suspend/wakeup cycles.

I *think* this started to happen with 6.6.5, which had a lot of drm-amd-display
patches (see[1]), so before I start bisecting and whatnot I was wondering if anybody
has any suggestions what might be the cause here. I can gladly test additional
patches or reverts. Even if 6.7-rc seems to be OK again I still think it's worthwile
to fix this in 6.6 since it's an LTS kernel.

Thanks for reading!
Holger

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.6?id=3601ed703d11a9140852b279482666d6f53e1c06
