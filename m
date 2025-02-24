Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9484AC021BE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D731A10E3AF;
	Mon, 24 Feb 2025 13:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=tkos.co.il header.i=@tkos.co.il header.b="ZHWCA1ab";
	dkim-atps=neutral
X-Greylist: delayed 365 seconds by postgrey-1.36 at gabe;
 Mon, 24 Feb 2025 06:02:56 UTC
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F47710E12A
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 06:02:56 +0000 (UTC)
Received: from localhost (unknown [10.0.8.3])
 by mail.tkos.co.il (Postfix) with ESMTP id 637DC440A74
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 07:51:10 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
 s=default; t=1740376270;
 bh=BZH6xRTAt7CogIylWzQLTwC2PRzqi9bNx9ouvnw/VNI=;
 h=From:To:Subject:Date:From;
 b=ZHWCA1ab0HJ9o5LEhOlfrOh9Jtih493NkCSkCgLCae0djXVM/HvpuP1F79791G1kv
 mXK/UC53jwbhaWwSLwPKlhVzOzU5X0/DZ5b48AtrgjOz3rxrJCe2xJMuSWxcjLWNsH
 x//qfVdvi6WCrbOaSDH6XnKeZav+eJ+iqlVJy0loEbsBadIvJZLsWuaL15ajSewzsL
 14Zj6mtudbTp+elsV4ct08D3yVI+5JvX/M/tscALQya8TL5pbWJCrkozq2a56UTLsa
 yh7ep5caKrflRgiPdav0ZwiJsDJXZeDR7DfNI5VaETSB8MBGUbnXERX6SEQYL9BiFh
 PpAVGfLXfzKkw==
From: Baruch Siach <baruch@tkos.co.il>
To: amd-gfx@lists.freedesktop.org
Subject: [drm:amdgpu_ring_test_helper] *ERROR* ring kiq_0.2.1.0 test failed
 (-110)
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 24 Feb 2025 07:56:46 +0200
Message-ID: <87seo3ga1t.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 24 Feb 2025 13:51:38 +0000
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

Hi amd-gfx list,

I see this failure on probe when trying to bring up amdgpu on a new arm64
platform.  Kernel is v6.14-rc4, and aldebaran firmware is latest
(linux-firmware commit 4f47e84d06f9).

Tested with these kernel command line parameters:

amdgpu.vm_size=1 amdgpu.msi=1 amdgpu.gartsize=32 amdgpu.vramlimit=32 amdgpu.gttsize=32

I guess the "CP firmware version" warning is bogus. IP version for GC_HWIP is
9.4.2.

Any idea?

Relevant log snippets follows:

[    1.792949] pci 0000:05:00.0: [1002:740f] type 00 class 0x038000 PCIe Endpoint
[    1.800652] pci 0000:05:00.0: BAR 0 [mem 0x00000000-0xfffffffff 64bit pref]
[    1.807629] pci 0000:05:00.0: BAR 2 [mem 0x00000000-0x001fffff 64bit pref]
[    1.814506] pci 0000:05:00.0: BAR 4 [io  0x0000-0x00ff]
[    1.819729] pci 0000:05:00.0: BAR 5 [mem 0x00000000-0x0007ffff]
[    1.825647] pci 0000:05:00.0: ROM [mem 0x00000000-0x0001ffff pref]
[    1.833297] pci 0000:05:00.0: PME# supported from D1 D2 D3hot D3cold
[    1.840118] pci 0000:05:00.0: 126.024 Gb/s available PCIe bandwidth, limited by 16.0 GT/s PCIe x8 link at 0000:02:00.0 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    1.857150] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
...
[    2.615336] pci 0000:05:00.0: BAR 0 [mem 0x1000000000-0x1fffffffff 64bit pref]: assigned
[    2.623529] pci 0000:05:00.0: BAR 2 [mem 0x2000000000-0x20001fffff 64bit pref]: assigned
[    2.631720] pci 0000:05:00.0: BAR 5 [mem 0x5d000000-0x5d07ffff]: assigned
[    2.638544] pci 0000:05:00.0: ROM [mem 0x5d080000-0x5d09ffff pref]: assigned
[    2.645583] pci 0000:05:00.0: BAR 4 [io  size 0x0100]: can't assign; no space
[    2.652707] pci 0000:05:00.0: BAR 4 [io  size 0x0100]: failed to assign
...
[    3.153154] amdgpu 0000:05:00.0: enabling device (0000 -> 0002)
[    3.159112] [drm] initializing kernel modesetting (ALDEBARAN 0x1002:0x740F 0x1002:0x0C34 0x02).
[    3.167817] [drm] register mmio base: 0x5D000000
[    3.172425] [drm] register mmio size: 524288
[    3.176775] amdgpu 0000:05:00.0: amdgpu: detected ip block number 0 <soc15_common>
[    3.184341] amdgpu 0000:05:00.0: amdgpu: detected ip block number 1 <gmc_v9_0>
[    3.191558] amdgpu 0000:05:00.0: amdgpu: detected ip block number 2 <vega20_ih>
[    3.198858] amdgpu 0000:05:00.0: amdgpu: detected ip block number 3 <psp>
[    3.205639] amdgpu 0000:05:00.0: amdgpu: detected ip block number 4 <smu>
[    3.212421] amdgpu 0000:05:00.0: amdgpu: detected ip block number 5 <gfx_v9_0>
[    3.219635] amdgpu 0000:05:00.0: amdgpu: detected ip block number 6 <sdma_v4_0>
[    3.226935] amdgpu 0000:05:00.0: amdgpu: detected ip block number 7 <vcn_v2_6>
[    3.234149] amdgpu 0000:05:00.0: amdgpu: detected ip block number 8 <jpeg_v2_6>
[    3.247351] amdgpu 0000:05:00.0: amdgpu: Fetched VBIOS from ROM BAR
[    3.253626] amdgpu: ATOM BIOS: 113-D67301V-073
[    3.259731] [drm] CP firmware version too old, please update!
[    3.260400] amdgpu 0000:05:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
[    3.274294] amdgpu 0000:05:00.0: amdgpu: PCIE atomic ops is not supported
[    3.281115] amdgpu 0000:05:00.0: amdgpu: MEM ECC is active.
[    3.286679] amdgpu 0000:05:00.0: amdgpu: SRAM ECC is active.
[    3.292351] amdgpu 0000:05:00.0: amdgpu: RAS INFO: ras initialized successfully, hardware ability[7ff7f] ras_mask[7ff7f]
[    3.303232] [drm] vm size is 1 GB, 2 levels, block size is 9-bit, fragment size is 9-bit
[    3.311338] amdgpu 0000:05:00.0: amdgpu: VRAM: 65520M 0x0000020000000000 - 0x0000020FFEFFFFFF (32M used)
[    3.320811] amdgpu 0000:05:00.0: amdgpu: GART: 32M 0x0000000000000000 - 0x0000000001FFFFFF
[    3.329070] [drm] Detected VRAM RAM=65520M, BAR=65536M
[    3.334199] [drm] RAM width 4096bits HBM
[    3.338251] [drm] amdgpu: 32M of VRAM memory ready
[    3.343039] [drm] amdgpu: 32M of GTT memory ready.
[    3.347861] [drm] GART: num cpu pages 8192, num gpu pages 8192
[    3.353779] [drm] PCIE GART of 32M enabled.
[    3.357955] [drm] PTB located at 0x0000020001FF0000
[    3.365901] [drm] Found VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revision: 28
[    3.432199] amdgpu 0000:05:00.0: amdgpu: reserve 0x800000 from 0x20001000000 for PSP TMR
[    3.504497] amdgpu 0000:05:00.0: amdgpu: smu driver if version = 0x00000008, smu fw if version = 0x00000009, smu fw program = 0, smu fw version = 0x00443f00 (68.63.0)
[    3.519356] amdgpu 0000:05:00.0: amdgpu: SMU driver if version not matched
[    3.526265] amdgpu 0000:05:00.0: amdgpu: use vbios provided pptable
[    3.532523] amdgpu 0000:05:00.0: amdgpu: smc_dpm_info table revision(format.content): 4.10
[    3.560964] amdgpu 0000:05:00.0: amdgpu: SMU is initialized successfully!
[    3.568167] [drm] kiq ring mec 2 pipe 1 q 0
[    3.785160] amdgpu 0000:05:00.0: [drm:amdgpu_ring_test_helper] *ERROR* ring kiq_0.2.1.0 test failed (-110)
[    3.794825] [drm:amdgpu_gfx_enable_kcq] *ERROR* KCQ enable failed
[    3.800929] [drm:amdgpu_device_init] *ERROR* hw_init of IP block <gfx_v9_0> failed -110
[    3.808929] amdgpu 0000:05:00.0: amdgpu: amdgpu_device_ip_init failed
[    3.815361] amdgpu 0000:05:00.0: amdgpu: Fatal error during GPU init
[    3.821705] amdgpu 0000:05:00.0: amdgpu: amdgpu: finishing device.

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
