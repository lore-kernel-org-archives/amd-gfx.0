Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632D8C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 21:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F6710E461;
	Mon, 23 Jun 2025 21:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dfodf55o";
	dkim-atps=neutral
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E324210E461
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 21:38:22 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-32b561a861fso38814131fa.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 14:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750714700; x=1751319500; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Pagpv8GMF/N9RHuAN4Rg6HJY4HhVU4OBYM8fmNSI6u4=;
 b=dfodf55oGSfW5d0sHwpvRTctW9wTxvYSgQ951eOww3P2ef6PKzCi8dyIGVSmFnsiXt
 oE5nlUzOX8N9ABzhqK/3I8T4PA2MAbQ8JODNs7kqQDI4CUDQB+TCSEw7PCHKi6ZdnOEt
 Up4qqiW/yXEfbtTjzRpyZ2PvYHnbEheo3h0kqji7OBfUmAhSt6wsJsDKJqbEYynwOC6f
 ayZSuCJoOK4uXP2o9j9bWTq0BMJRFHC7hZRtSpiblermFnFauqg7hTPVRdqQqZHEFxqS
 YcBknjncpuI8IJ7at+fNbOI5nr3hlN3dtzCSJe8hlyTVyP5LvaTsXC+p65gVVSJSsWI7
 gzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750714700; x=1751319500;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pagpv8GMF/N9RHuAN4Rg6HJY4HhVU4OBYM8fmNSI6u4=;
 b=cZI62diViuK3seh3lEicIARcvqGl8XuPDCv/m6enxCmFDeecFZzgIO2/hU0GIMYryF
 b9iSFKx3Lf6aC4AOiDJUyALlv+ant6hkARwMWmZBtPNfcqgV/BNgtTTp6vhJ+2MC5O9C
 hqJA4T6bVFCjgybh70a00/wgjsCjckNZxSFULAyCoFW5N0nzhxESUlPp1c7IzICrzGvg
 OwYfrIX714L37pmxc0ymwhMGR2LpZW3ezep43CQpSK3UnR0XTg8pzyJSeijh+p0ECXXq
 NFIqD2iNtuWmYHQSApQ8yPOO1nbEoPkfq8oEvf4GsCtiEPIfAXMOksmTaPLmR+/P3wHo
 S2yQ==
X-Gm-Message-State: AOJu0YyYDp+Su8PRLcN6kpP3eyNHB4eiaZNcuaOaezywW+stnVxTmglk
 k7ZVnv/w/J0L8Cc9zPqAb5zeNWtjQMZdIo+8Cd8fCkm+UBH9opb1ReEbMfY1obqPnYCowC//bSZ
 jYI9aB3iDqq+J6/1Hr8jJMH4/lR5NO5+yuIrD
X-Gm-Gg: ASbGncux7rkgTflLVi9NP/rxeqqpdySd/8OIc1eWTECuOK3pLs+DjtX/UlanGc7typT
 o6aPwFUrnS3Lu07QlGToqjGzMFvNxyEYqjgQXt9/TcXalktgkVvFSJsZdPnhUhHpZw0x4IDjs7z
 1jakGp789y0VWsDo4BKSyyWun+BaDDIXuoZeMb37Od
X-Google-Smtp-Source: AGHT+IHmneCz6eZNIbpjPElyM9P5gzbcaWpZrnyA8FSkXPAI077QKS1XsMJly3S659XZ6vzENOb3SpS7AmmbEvzYGmE=
X-Received: by 2002:a2e:3217:0:b0:32b:56b3:d35e with SMTP id
 38308e7fff4ca-32b9942186amr29295011fa.20.1750714700011; Mon, 23 Jun 2025
 14:38:20 -0700 (PDT)
MIME-Version: 1.0
From: Andre Costa <andre.ocosta@gmail.com>
Date: Mon, 23 Jun 2025 18:38:08 -0300
X-Gm-Features: AX0GCFvb6vwC-kvsZrrOD1z1nKLwtAWseQpLFt47Fj_YTPPcHnymzkeSlslJC-w
Message-ID: <CAMBDoMMvOLV9JqvCB0aek9Ubs7qQ1o1-ceAn7Gd55bojeN6_yw@mail.gmail.com>
Subject: Weird bug: AMD Radeon iGPU fails to initialize when booting laptop on
 battery
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000cc2079063844078a"
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

--000000000000cc2079063844078a
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm coming here hoping someone could shed some light on this weird problem
I have.

My setup is:

   - Acer Nitro AN515-44 (V1.04) laptop
   - AMD Radeon Vega Series / Radeon Vega Mobile Series iGPU
   - NVIDIA GeForce GTX 1650 Mobile dGPU
   - Fedora 42

If I boot the laptop on battery (unplugged from the charger) internal
display either fails to initialize completely (remains blank) or isn't
properly recognized and is set to fixed 60Hz instead of its 144Hz.

The fixed 60Hz refresh rate happens when I boot on battery with kernel
6.14.11-300 and Nvidia open source driver. I have filed a bug report
<https://bugzilla.redhat.com/show_bug.cgi?id=2372819> on Fedora's kernel
bugzilla, there are a couple of (hopefully useful) log snippets there, like
this:

[    8.311152] amdgpu 0000:05:00.0: enabling device (0006 -> 0007)
[    8.311219] [drm] initializing kernel modesetting (RENOIR
0x1002:0x1636 0x1025:0x1455 0xC6).
[    8.311536] [drm] register mmio base: 0xD1500000
[    8.311539] [drm] register mmio size: 524288
[    8.311550] workqueue: Failed to create a rescuer kthread for wq
"amdgpu-reset-dev": -EINTR
[    8.311557] [drm:amdgpu_reset_create_reset_domain [amdgpu]] *ERROR*
Failed to allocate wq for amdgpu_reset_domain!
[    8.312266] amdgpu 0000:05:00.0: amdgpu: Fatal error during GPU init
[    8.312272] amdgpu 0000:05:00.0: amdgpu: amdgpu: finishing device.
[    8.312351] amdgpu 0000:05:00.0: probe with driver amdgpu failed
with error -12

I have just tried booting with rawhide 6.16.0rc2 kernel from Fedora
Rawhide, and it completely failed to initialize the display (log is also
attached there). Here's a snippet:

jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: vgaarb: deactivate vga console
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: Trusted Memory Zone
(TMZ) feature enabled
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: MODE2 reset
jun 23 17:51:46 kernel: [drm] vm size is 262144 GB, 4 levels, block size is
9-bit, fragment size is 9-bit
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: VRAM: 512M
0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: GART: 1024M
0x0000000000000000 - 0x000000003FFFFFFF
jun 23 17:51:46 kernel: [drm] Detected VRAM RAM=512M, BAR=512M
jun 23 17:51:46 kernel: [drm] RAM width 128bits DDR4
jun 23 17:51:46 kernel: [drm] amdgpu: 512M of VRAM memory ready
jun 23 17:51:46 kernel: [drm] amdgpu: 15723M of GTT memory ready.
jun 23 17:51:46 kernel: [drm] GART: num cpu pages 262144, num gpu pages
262144
jun 23 17:51:46 kernel: [drm] PCIE GART of 1024M enabled.
jun 23 17:51:46 kernel: [drm] PTB located at 0x000000F41FC00000
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: [drm] Loading DMUB
firmware via PSP: version=0x0101002B
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: Found VCN firmware
Version ENC: 1.24 DEC: 8 VEP: 0 Revision: 3
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: reserve 0x400000 from
0xf41f800000 for PSP TMR
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: RAS: optional ras ta
ucode is not available
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: RAP: optional rap ta
ucode is not available
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: psp gfx command
LOAD_TA(0x1) failed and response status is (0x7)
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: psp gfx command
INVOKE_CMD(0x3) failed and response status is (0x4)
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: Secure display:
Generic Failure.
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: SECUREDISPLAY: query
securedisplay TA failed. ret 0x0
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: SMU is initialized
successfully!
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: [drm] Display Core
v3.2.334 initialized on DCN 2.1
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: [drm] DP-HDMI FRL PCON
supported
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: [drm] DMUB hardware
initialized: version=0x0101002B
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: [drm] *ERROR* amdgpu:
failed to initialize sw for display support.
jun 23 17:51:46 kernel: [drm:amdgpu_device_ip_init [amdgpu]] *ERROR*
hw_init of IP block <dm> failed -22
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: amdgpu_device_ip_init
failed
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: Fatal error during GPU
init
jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: amdgpu: finishing
device.
jun 23 17:51:46 kernel: BUG: kernel NULL pointer dereference, address:
00000000000005b8
jun 23 17:51:46 kernel: #PF: supervisor read access in kernel mode
jun 23 17:51:46 kernel: #PF: error_code(0x0000) - not-present page
jun 23 17:51:46 kernel: PGD 0 P4D 0
jun 23 17:51:46 kernel: Oops: Oops: 0000 [#1] SMP NOPTI
jun 23 17:51:46 kernel: CPU: 3 UID: 0 PID: 384 Comm: (udev-worker) Not
tainted 6.16.0-0.rc2.24.fc43.x86_64 #1 PREEMPT(lazy)
jun 23 17:51:46 kernel: Hardware name: Acer Nitro AN515-44/Stonic_RNS, BIOS
V1.04 02/04/2021
jun 23 17:51:46 kernel: RIP:
0010:dc_resource_is_dsc_encoding_supported+0x9/0x30 [amdgpu]
jun 23 17:51:46 kernel: Code: e9 95 77 06 00 66 66 2e 0f 1f 84 00 00 00 00
00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44
00 00 <48> 8b 87 b8 05 00 00 48 85 c0 74 14 48 8b 80 b8 04 00 00 8b 40 24
jun 23 17:51:46 kernel: RSP: 0018:ffffca408083b630 EFLAGS: 00010246
jun 23 17:51:46 kernel: RAX: 0000000000000000 RBX: ffff895b22280010 RCX:
0000000000000000
jun 23 17:51:46 kernel: RDX: ffff895b22280010 RSI: ffff895b20250a00 RDI:
0000000000000000
jun 23 17:51:46 kernel: RBP: ffff895b042beb80 R08: 0000000000000000 R09:
0000000000000000
jun 23 17:51:46 kernel: R10: ffffca408083b7a0 R11: 0000000000000000 R12:
0000000000000000
jun 23 17:51:46 kernel: R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000000
jun 23 17:51:46 kernel: FS:  00007ff2d298d040(0000)
GS:ffff896264dff000(0000) knlGS:0000000000000000
jun 23 17:51:46 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
jun 23 17:51:46 kernel: CR2: 00000000000005b8 CR3: 0000000103a5f000 CR4:
0000000000350ef0
jun 23 17:51:46 kernel: Call Trace:
jun 23 17:51:46 kernel:  <TASK>
jun 23 17:51:46 kernel:  amdgpu_dm_atomic_check+0xf5/0x1510 [amdgpu]
jun 23 17:51:46 kernel:  drm_atomic_check_only+0x190/0x3f0

Booting with the charger plugged properly initializes the internal display
every time. It doesn't make much sense to me, but it's 100% reproducible
here.

Any tips on how to workaround this will be most welcome.

Regards,
Andre

--000000000000cc2079063844078a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I&#39;m coming here hopi=
ng someone could shed some light on this weird problem I have.</div><div><b=
r></div><div>My setup is:</div><div><ul><li>Acer Nitro AN515-44 (V1.04) lap=
top</li><li>AMD Radeon Vega Series / Radeon Vega Mobile Series iGPU</li><li=
>NVIDIA GeForce GTX 1650 Mobile dGPU</li><li>Fedora 42</li></ul><div>If I b=
oot the laptop on battery (unplugged from the charger) internal display eit=
her fails to initialize completely (remains blank) or isn&#39;t properly re=
cognized and is set to fixed 60Hz instead of its 144Hz.</div><div><br></div=
><div>The fixed 60Hz refresh rate happens when I boot on battery with kerne=
l 6.14.11-300 and Nvidia open source driver. I have filed a <a href=3D"http=
s://bugzilla.redhat.com/show_bug.cgi?id=3D2372819">bug report</a> on Fedora=
&#39;s kernel bugzilla, there are a couple of (hopefully useful) log snippe=
ts there, like this:</div><div><br></div><div><pre class=3D"gmail-bz_commen=
t_text" id=3D"gmail-comment_text_0">[    8.311152] amdgpu 0000:05:00.0: ena=
bling device (0006 -&gt; 0007)
[    8.311219] [drm] initializing kernel modesetting (RENOIR 0x1002:0x1636 =
0x1025:0x1455 0xC6).
[    8.311536] [drm] register mmio base: 0xD1500000
[    8.311539] [drm] register mmio size: 524288
[    8.311550] workqueue: Failed to create a rescuer kthread for wq &quot;a=
mdgpu-reset-dev&quot;: -EINTR
[    8.311557] [drm:amdgpu_reset_create_reset_domain [amdgpu]] *ERROR* Fail=
ed to allocate wq for amdgpu_reset_domain!
[    8.312266] amdgpu 0000:05:00.0: amdgpu: Fatal error during GPU init
[    8.312272] amdgpu 0000:05:00.0: amdgpu: amdgpu: finishing device.
[    8.312351] amdgpu 0000:05:00.0: probe with driver amdgpu failed with er=
ror -12
</pre>I have just tried booting with rawhide 6.16.0rc2 kernel from Fedora R=
awhide, and it completely failed to initialize the display (log is also att=
ached there). Here&#39;s a snippet:</div><div><br></div><div><span style=3D=
"font-family:monospace">jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: vgaarb=
: deactivate vga console<br>jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: am=
dgpu: Trusted Memory Zone (TMZ) feature enabled<br>jun 23 17:51:46 kernel: =
amdgpu 0000:05:00.0: amdgpu: MODE2 reset<br>jun 23 17:51:46 kernel: [drm] v=
m size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit<=
br>jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: VRAM: 512M 0x000000=
F400000000 - 0x000000F41FFFFFFF (512M used)<br>jun 23 17:51:46 kernel: amdg=
pu 0000:05:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFF=
F<br>jun 23 17:51:46 kernel: [drm] Detected VRAM RAM=3D512M, BAR=3D512M<br>=
jun 23 17:51:46 kernel: [drm] RAM width 128bits DDR4<br>jun 23 17:51:46 ker=
nel: [drm] amdgpu: 512M of VRAM memory ready<br>jun 23 17:51:46 kernel: [dr=
m] amdgpu: 15723M of GTT memory ready.<br>jun 23 17:51:46 kernel: [drm] GAR=
T: num cpu pages 262144, num gpu pages 262144<br>jun 23 17:51:46 kernel: [d=
rm] PCIE GART of 1024M enabled.<br>jun 23 17:51:46 kernel: [drm] PTB locate=
d at 0x000000F41FC00000<br>jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amd=
gpu: [drm] Loading DMUB firmware via PSP: version=3D0x0101002B<br>jun 23 17=
:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: Found VCN firmware Version ENC:=
 1.24 DEC: 8 VEP: 0 Revision: 3<br>jun 23 17:51:46 kernel: amdgpu 0000:05:0=
0.0: amdgpu: reserve 0x400000 from 0xf41f800000 for PSP TMR<br>jun 23 17:51=
:46 kernel: amdgpu 0000:05:00.0: amdgpu: RAS: optional ras ta ucode is not =
available<br>jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: RAP: opti=
onal rap ta ucode is not available<br>jun 23 17:51:46 kernel: amdgpu 0000:0=
5:00.0: amdgpu: psp gfx command LOAD_TA(0x1) failed and response status is =
(0x7)<br>jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: psp gfx comma=
nd INVOKE_CMD(0x3) failed and response status is (0x4)<br>jun 23 17:51:46 k=
ernel: amdgpu 0000:05:00.0: amdgpu: Secure display: Generic Failure.<br>jun=
 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: SECUREDISPLAY: query secu=
redisplay TA failed. ret 0x0<br>jun 23 17:51:46 kernel: amdgpu 0000:05:00.0=
: amdgpu: SMU is initialized successfully!<br>jun 23 17:51:46 kernel: amdgp=
u 0000:05:00.0: amdgpu: [drm] Display Core v3.2.334 initialized on DCN 2.1<=
br>jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: [drm] DP-HDMI FRL P=
CON supported<br>jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: [drm]=
 DMUB hardware initialized: version=3D0x0101002B<br>jun 23 17:51:46 kernel:=
 amdgpu 0000:05:00.0: amdgpu: [drm] *ERROR* amdgpu: failed to initialize sw=
 for display support.<br>jun 23 17:51:46 kernel: [drm:amdgpu_device_ip_init=
 [amdgpu]] *ERROR* hw_init of IP block &lt;dm&gt; failed -22<br>jun 23 17:5=
1:46 kernel: amdgpu 0000:05:00.0: amdgpu: amdgpu_device_ip_init failed<br>j=
un 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: Fatal error during GPU =
init<br>jun 23 17:51:46 kernel: amdgpu 0000:05:00.0: amdgpu: amdgpu: finish=
ing device.<br>jun 23 17:51:46 kernel: BUG: kernel NULL pointer dereference=
, address: 00000000000005b8<br>jun 23 17:51:46 kernel: #PF: supervisor read=
 access in kernel mode<br>jun 23 17:51:46 kernel: #PF: error_code(0x0000) -=
 not-present page<br>jun 23 17:51:46 kernel: PGD 0 P4D 0 <br>jun 23 17:51:4=
6 kernel: Oops: Oops: 0000 [#1] SMP NOPTI<br>jun 23 17:51:46 kernel: CPU: 3=
 UID: 0 PID: 384 Comm: (udev-worker) Not tainted 6.16.0-0.rc2.24.fc43.x86_6=
4 #1 PREEMPT(lazy) <br>jun 23 17:51:46 kernel: Hardware name: Acer Nitro AN=
515-44/Stonic_RNS, BIOS V1.04 02/04/2021<br>jun 23 17:51:46 kernel: RIP: 00=
10:dc_resource_is_dsc_encoding_supported+0x9/0x30 [amdgpu]<br>jun 23 17:51:=
46 kernel: Code: e9 95 77 06 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 &lt;48&=
gt; 8b 87 b8 05 00 00 48 85 c0 74 14 48 8b 80 b8 04 00 00 8b 40 24<br>jun 2=
3 17:51:46 kernel: RSP: 0018:ffffca408083b630 EFLAGS: 00010246<br>jun 23 17=
:51:46 kernel: RAX: 0000000000000000 RBX: ffff895b22280010 RCX: 00000000000=
00000<br>jun 23 17:51:46 kernel: RDX: ffff895b22280010 RSI: ffff895b20250a0=
0 RDI: 0000000000000000<br>jun 23 17:51:46 kernel: RBP: ffff895b042beb80 R0=
8: 0000000000000000 R09: 0000000000000000<br>jun 23 17:51:46 kernel: R10: f=
fffca408083b7a0 R11: 0000000000000000 R12: 0000000000000000<br>jun 23 17:51=
:46 kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000000=
00<br>jun 23 17:51:46 kernel: FS: =C2=A000007ff2d298d040(0000) GS:ffff89626=
4dff000(0000) knlGS:0000000000000000<br>jun 23 17:51:46 kernel: CS: =C2=A00=
010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>jun 23 17:51:46 kernel: CR2:=
 00000000000005b8 CR3: 0000000103a5f000 CR4: 0000000000350ef0<br>jun 23 17:=
51:46 kernel: Call Trace:<br>jun 23 17:51:46 kernel: =C2=A0&lt;TASK&gt;<br>=
jun 23 17:51:46 kernel: =C2=A0amdgpu_dm_atomic_check+0xf5/0x1510 [amdgpu]<b=
r>jun 23 17:51:46 kernel: =C2=A0drm_atomic_check_only+0x190/0x3f0<br></span=
><br></div><div>Booting with the charger plugged properly initializes the i=
nternal display every time. It doesn&#39;t make much sense to me, but it&#3=
9;s 100% reproducible here.</div><div><br></div><div>Any tips on how to wor=
karound this will be most welcome.</div><div><br></div><div>Regards,</div><=
div>Andre</div><div><br></div></div></div>

--000000000000cc2079063844078a--
