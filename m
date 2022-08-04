Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C89C25B08
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 07:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8472AB40DD;
	Fri,  5 Aug 2022 07:24:05 +0000 (UTC)
X-Greylist: delayed 591 seconds by postgrey-1.36 at gabe;
 Thu, 04 Aug 2022 08:16:32 UTC
Received: from iam.tj (soggy.cloud [IPv6:2a01:7e00:e000:151::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 898FF90F24
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Aug 2022 08:16:32 +0000 (UTC)
Received: from [IPV6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1] (unknown
 [IPv6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by iam.tj (Postfix) with ESMTPSA id C7889340AC;
 Thu,  4 Aug 2022 09:06:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=iam.tj; s=2019;
 t=1659600398; bh=VzsRo3+z7veSF122LVMiewYXQiqbCabCIHKkZH9k5as=;
 h=Date:To:Cc:From:Subject:From;
 b=jyJPvBKBtQnZE8pzY83S4DTf1yQu8VU+0sgRYnWGyOMrht9UAOd8f6xcXK+g+nU5u
 umcwMu/f6SPnbaahW1VhSiVtwg3X6nSg+0/4D18tn+n4AVzkqLzPwR5WKQdNdsI8pH
 Bk9pntNsJuzwkTFqk3mJVLnFW5wuO87NbEEv9jUrCBbl4LD2y9dUKvMVODn4uW4CTs
 CkMDZbFAJtYlJ9A8lXaXxESyk/P2O3rhLssnClDA2JqHZSGqAkZfbR1GAApPqed3nu
 MUho/xmEgb3mJ/xv72okLfvKWK/ajVIL7dTMNuJASvzgxMdozgxRAgIbw5UQrHEcf6
 gdx++KRalsN/Q==
Message-ID: <8b51c338-d3a1-207d-3b79-4a4d36da0f17@iam.tj>
Date: Thu, 4 Aug 2022 09:06:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-GB
To: amd-gfx@lists.freedesktop.org
From: Tj <linux@iam.tj>
Subject: [drm:radeon_cs_ioctl [radeon]] *ERROR* Failed to parse relocation -12!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 05 Aug 2022 07:24:03 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Debian 11 Bullseye amd64 with local builds of the kernel (mainline 
RCs, and stable tree) and at least since v5.16 through to v5.19, this 
error consistently occurs when using VLC (vlc/stable,stable-security,now 
3.0.17.4-0+deb11u1 amd64) to play videos - although other players which 
likely use a different mechanism are fine which is what I've been doing 
but finally got fed up with it!

Is there any debugging I can do to help resolve it?

I suspect it's related to VA-API.

Whilst VLC is 'playing' a video, in this case H264 mp4, it reports, 
whilst displaying black screen (audio OK):

$ vlc 
 
               [1417/1417]
VLC media player 3.0.17.4 Vetinari (revision 3.0.13-8-g41878ff4f2) 
 

[000055c1b20c8b40] main libvlc: Running vlc with the default interface. 
Use 'cvlc' to use vlc without interface. 

[000055c1b2157750] main playlist: playlist is empty 
 

uint DBusMenuExporterDBus::GetLayout(int, int, const QStringList&, 
DBusMenuLayoutItem&): Condition failed: menu 

uint DBusMenuExporterDBus::GetLayout(int, int, const QStringList&, 
DBusMenuLayoutItem&): Condition failed: menu 

[00007fc9a0003af0] gl gl: Initialized libplacebo v2.72.0 (API v72) 
 

libva info: VA-API version 1.14.0 
 

libva info: Trying to open 
/usr/lib/x86_64-linux-gnu/dri/radeonsi_drv_video.so 
 

libva info: Found init function __vaDriverInit_1_10 
 

libva info: va_openDriver() returns 0 
 

[00007fc9acc476c0] avcodec decoder: Using Mesa Gallium driver 20.3.5 for 
AMD VERDE (DRM 2.50.0, 5.19.0-soggy-00004-g2f18a25d4d5d, LLVM 11.0.1) 
for hardware decoding
radeon: Not enough memory for command submission. 

radeon: Not enough memory for command submission. 

radeon: Not enough memory for command submission. 

radeon: Not enough memory for command submission.
...

Whilst at the same time the kernel log is flooded with:

Aug 04 08:35:51 sunny kernel: [drm:radeon_cs_ioctl [radeon]] *ERROR* 
Failed to parse relocation -12!
Aug 04 08:35:51 sunny kernel: [drm:radeon_cs_ioctl [radeon]] *ERROR* 
Failed to parse relocation -12!
Aug 04 08:35:51 sunny kernel: [drm:radeon_cs_ioctl [radeon]] *ERROR* 
Failed to parse relocation -12!
Aug 04 08:35:51 sunny kernel: [drm:radeon_cs_ioctl [radeon]] *ERROR* 
Failed to parse relocation -12!
...

System specs:

Vendor ID:                       AuthenticAMD
CPU family:                      23
Model:                           1
Model name:                      AMD Ryzen 7 1800X Eight-Core Processor
Stepping:                        1
Frequency boost:                 enabled

$ uname -r
5.19.0-soggy-00004-g2f18a25d4d5d

$ $ git l -n 5
2f18a25d4d5d 2022-08-04 01:43:39 +0100 U Tj cfg80211: suppress regdom 
warning when phy not ready
651ab6014c19 2022-08-04 01:33:48 +0100 N Tj ath: add module_param 
country_default for regulatory domain control
10edb4635de7 2022-08-04 01:32:17 +0100 N Tj firmware: report each loaded 
firmware file
30927ad0b6a4 2022-08-04 01:31:47 +0100 N Tj package: debian: make debug 
symbol .deb optional
3d7cb6b04c3f 2022-07-31 14:03:01 -0700 N Linus Torvalds Linux 5.19

$ journalctl -k
...
Aug 03 22:44:13 sunny kernel: efi: EFI v2.70 by American Megatrends
Aug 03 22:44:13 sunny kernel: efi: ACPI=0xca39b000 ACPI 2.0=0xca39b014 
TPMFinalLog=0xcaa33000 SMBIOS=0xcb7fb000 SMBIOS 3.0=0xcb7fa000 
MEMATTR=0xc657d018 ESRT=0xc823dd18
Aug 03 22:44:13 sunny kernel: SMBIOS 3.3.0 present.
Aug 03 22:44:13 sunny kernel: DMI: ZOOSTORM 7200-5372A/PRIME X370-PRO, 
BIOS 6026 03/16/2022
...
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: vgaarb: deactivate 
vga console
Aug 03 22:44:14 sunny kernel: [drm] initializing kernel modesetting 
(VERDE 0x1002:0x682C 0x1028:0x2B1E 0x00).
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: vram limit (0) must 
be a power of 2
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: No more image in the 
PCI ROM
Aug 03 22:44:14 sunny kernel: ATOM BIOS: C755
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: VRAM: 2048M 
0x0000000000000000 - 0x000000007FFFFFFF (2048M used)
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: GTT: 2048M 
0x0000000080000000 - 0x00000000FFFFFFFF
Aug 03 22:44:14 sunny kernel: [drm] Detected VRAM RAM=2048M, BAR=256M
Aug 03 22:44:14 sunny kernel: [drm] RAM width 128bits DDR
Aug 03 22:44:14 sunny kernel: [drm] radeon: 2048M of VRAM memory ready
Aug 03 22:44:14 sunny kernel: [drm] radeon: 2048M of GTT memory ready.
Aug 03 22:44:14 sunny kernel: [drm] Loading verde Microcode
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: Firmware loaded: 
radeon/verde_pfp.bin
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: Firmware loaded: 
radeon/verde_me.bin
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: Firmware loaded: 
radeon/verde_ce.bin
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: Firmware loaded: 
radeon/verde_rlc.bin
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: Firmware loaded: 
radeon/verde_mc.bin
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: Firmware loaded: 
radeon/verde_smc.bin
Aug 03 22:44:14 sunny kernel: [drm] Internal thermal controller with fan 
control
Aug 03 22:44:14 sunny kernel: [drm] radeon: dpm initialized
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: Firmware loaded: 
radeon/TAHITI_uvd.bin
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: Firmware loaded: 
radeon/TAHITI_vce.bin
Aug 03 22:44:14 sunny kernel: [drm] Found VCE firmware/feedback version 
50.0.1 / 17!
Aug 03 22:44:14 sunny kernel: [drm] GART: num cpu pages 524288, num gpu 
pages 524288
Aug 03 22:44:14 sunny kernel: [drm] PCIE gen 3 link speeds already enabled
Aug 03 22:44:14 sunny kernel: [drm] PCIE GART of 2048M enabled (table at 
0x00000000001D6000).
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: WB enabled
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: fence driver on ring 
0 use gpu addr 0x0000000080000c00
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: fence driver on ring 
1 use gpu addr 0x0000000080000c04
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: fence driver on ring 
2 use gpu addr 0x0000000080000c08
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: fence driver on ring 
3 use gpu addr 0x0000000080000c0c
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: fence driver on ring 
4 use gpu addr 0x0000000080000c10
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: fence driver on ring 
5 use gpu addr 0x0000000000075a18
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: fence driver on ring 
6 use gpu addr 0x0000000080000c18
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: fence driver on ring 
7 use gpu addr 0x0000000080000c1c
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: radeon: MSI limited 
to 32-bit
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: radeon: using MSI.
Aug 03 22:44:14 sunny kernel: [drm] radeon: irq initialized.
...
Aug 03 22:44:14 sunny kernel: [drm] ring test on 0 succeeded in 1 usecs
Aug 03 22:44:14 sunny kernel: [drm] ring test on 1 succeeded in 1 usecs
Aug 03 22:44:14 sunny kernel: [drm] ring test on 2 succeeded in 1 usecs
Aug 03 22:44:14 sunny kernel: [drm] ring test on 3 succeeded in 7 usecs
Aug 03 22:44:14 sunny kernel: [drm] ring test on 4 succeeded in 3 usecs
...
Aug 03 22:44:14 sunny kernel: [drm] ring test on 5 succeeded in 2 usecs
...
Aug 03 22:44:14 sunny kernel: [drm] ring test on 6 succeeded in 17 usecs
Aug 03 22:44:14 sunny kernel: [drm] ring test on 7 succeeded in 3 usecs
Aug 03 22:44:14 sunny kernel: [drm] VCE initialized successfully.
Aug 03 22:44:14 sunny kernel: [drm] ib test on ring 0 succeeded in 0 usecs
Aug 03 22:44:14 sunny kernel: [drm] ib test on ring 1 succeeded in 0 usecs
Aug 03 22:44:14 sunny kernel: [drm] ib test on ring 2 succeeded in 0 usecs
Aug 03 22:44:14 sunny kernel: [drm] ib test on ring 3 succeeded in 0 usecs
Aug 03 22:44:14 sunny kernel: [drm] ib test on ring 4 succeeded in 0 usecs
...
Aug 03 22:44:14 sunny kernel: [drm] ib test on ring 5 succeeded
Aug 03 22:44:14 sunny kernel: [drm] ib test on ring 6 succeeded
Aug 03 22:44:14 sunny kernel: [drm] ib test on ring 7 succeeded
Aug 03 22:44:14 sunny kernel: [drm] Radeon Display Connectors
Aug 03 22:44:14 sunny kernel: [drm] Connector 0:
Aug 03 22:44:14 sunny kernel: [drm]   DP-1
Aug 03 22:44:14 sunny kernel: [drm]   HPD4
Aug 03 22:44:14 sunny kernel: [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 
0x6548 0x6548 0x654c 0x654c
Aug 03 22:44:14 sunny kernel: [drm]   Encoders:
Aug 03 22:44:14 sunny kernel: [drm]     DFP1: INTERNAL_UNIPHY2
Aug 03 22:44:14 sunny kernel: [drm] Connector 1:
Aug 03 22:44:14 sunny kernel: [drm]   DP-2
Aug 03 22:44:14 sunny kernel: [drm]   HPD5
Aug 03 22:44:14 sunny kernel: [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 
0x6538 0x6538 0x653c 0x653c
Aug 03 22:44:14 sunny kernel: [drm]   Encoders:
Aug 03 22:44:14 sunny kernel: [drm]     DFP2: INTERNAL_UNIPHY1
Aug 03 22:44:14 sunny kernel: [drm] Connector 2:
Aug 03 22:44:14 sunny kernel: [drm]   DP-3
Aug 03 22:44:14 sunny kernel: [drm]   HPD1
Aug 03 22:44:14 sunny kernel: [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 
0x6568 0x6568 0x656c 0x656c
Aug 03 22:44:14 sunny kernel: [drm]   Encoders:
Aug 03 22:44:14 sunny kernel: [drm]     DFP3: INTERNAL_UNIPHY1
Aug 03 22:44:14 sunny kernel: [drm] Connector 3:
Aug 03 22:44:14 sunny kernel: [drm]   DP-4
Aug 03 22:44:14 sunny kernel: [drm]   HPD2
Aug 03 22:44:14 sunny kernel: [drm]   DDC: 0x6580 0x6580 0x6584 0x6584 
0x6588 0x6588 0x658c 0x658c
Aug 03 22:44:14 sunny kernel: [drm]   Encoders:
Aug 03 22:44:14 sunny kernel: [drm]     DFP4: INTERNAL_UNIPHY
Aug 03 22:44:14 sunny kernel: [drm] fb mappable at 0xE05E9000
Aug 03 22:44:14 sunny kernel: [drm] vram apper at 0xE0000000
Aug 03 22:44:14 sunny kernel: [drm] size 9216000
Aug 03 22:44:14 sunny kernel: [drm] fb depth is 24
Aug 03 22:44:14 sunny kernel: [drm]    pitch is 7680
Aug 03 22:44:14 sunny kernel: fbcon: radeondrmfb (fb0) is primary device
Aug 03 22:44:14 sunny kernel: Console: switching to colour frame buffer 
device 170x48
Aug 03 22:44:14 sunny kernel: radeon 0000:0a:00.0: [drm] fb0: 
radeondrmfb frame buffer device
Aug 03 22:44:14 sunny kernel: [drm] Initialized radeon 2.50.0 20080528 
for 0000:0a:00.0 on minor 0
Aug 03 22:44:14 sunny kernel: AMD-Vi: AMD IOMMUv2 loaded and initialized
Aug 03 22:44:14 sunny kernel: [drm] amdgpu kernel modesetting enabled.
Aug 03 22:44:14 sunny kernel: amdgpu: Ignoring ACPI CRAT on non-APU system
Aug 03 22:44:14 sunny kernel: amdgpu: Virtual CRAT table created for CPU
Aug 03 22:44:14 sunny kernel: amdgpu: Topology: Add CPU node


