Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB54CA5FFF
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 07:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E8010EBD7;
	Mon,  5 Oct 2026 07:28:18 +0000 (UTC)
Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD5B10F9E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:57 +0000 (UTC)
Received: from localhorst ([127.0.0.1]) by mail.sig21.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <js@sig21.net>) id 1xCj0x-0008WR-0M ;
 Fri, 02 Oct 2026 21:33:54 +0200
Received: from js by abc.local with local (Exim 4.100.1)
 (envelope-from <js@sig21.net>) id 1xCj0t-000000001AW-0tG1;
 Fri, 02 Oct 2026 21:33:47 +0200
Date: Fri, 2 Oct 2026 21:33:47 +0200
From: Johannes Stezenbach <js@sig21.net>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu causes boot failure after BIOS update AGESA ComboAM5
 1.3.0.1a on Asrock X600
Message-ID: <asAHGx89B51wvigS@sig21.net>
References: <ar-GzWfyQMeRTRCt@sig21.net>
 <CADnq5_ODecWYOwbBYDnV-aeAi+pCMoxJvufuzY8_4yf5cF0dEg@mail.gmail.com>
 <2b4560f5-3458-4218-89f7-509c298b2126@amd.com>
 <asAFItSKC74Lm9mT@sig21.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asAFItSKC74Lm9mT@sig21.net>
X-Mailman-Approved-At: Mon, 05 Oct 2026 07:28:12 +0000
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

On Fri, Oct 02, 2026 at 09:25:22PM +0200, Johannes Stezenbach wrote:
> But eventually I reproduced the
> failure and got the attached log.

Just in case it helps, here is a log snippet from the
successful boot. It also has some amdgpu related errors:


[    0.000000] Linux version 7.2.8+deb14-amd64 (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-16 (Debian 16.2.0-3) 16.2.0, GNU ld (GNU Binutils for Debian) 2.47) #1 SMP PREEMPT_DYNAMIC Debian 7.2.8-1 (2026-09-26)

[   16.701811] amd_atl: AMD Address Translation Library initialized

[   16.752534] [drm] Initialized amdxdna_accel_driver 0.10.0 for 0000:6f:00.1 on minor 0

[   17.966632] amdgpu: Virtual CRAT table created for CPU
[   17.966840] amdgpu: Topology: Add CPU node
[   17.967100] amdgpu 0000:6e:00.0: enabling device (0006 -> 0007)
[   17.967318] amdgpu 0000:6e:00.0: initializing kernel modesetting (IP DISCOVERY 0x1002:0x15BF 0x1002:0x15BF 0x06).
[   17.967522] amdgpu 0000:6e:00.0: register mmio base: 0xDC900000
[   17.967712] amdgpu 0000:6e:00.0: register mmio size: 524288
[   17.970189] amdgpu 0000:6e:00.0: detected ip block number 0 <common_v1_0_0> (soc21_common)
[   17.970393] amdgpu 0000:6e:00.0: detected ip block number 1 <gmc_v11_0_0> (gmc_v11_0)
[   17.970576] amdgpu 0000:6e:00.0: detected ip block number 2 <ih_v6_0_0> (ih_v6_0)
[   17.970757] amdgpu 0000:6e:00.0: detected ip block number 3 <psp_v13_0_4> (psp)
[   17.970936] amdgpu 0000:6e:00.0: detected ip block number 4 <smu_v13_0_0> (smu)
[   17.971120] amdgpu 0000:6e:00.0: detected ip block number 5 <dce_v1_0_0> (dm)
[   17.971301] amdgpu 0000:6e:00.0: detected ip block number 6 <gfx_v11_0_0> (gfx_v11_0)
[   17.971485] amdgpu 0000:6e:00.0: detected ip block number 7 <sdma_v6_0_0> (sdma_v6_0)
[   17.971667] amdgpu 0000:6e:00.0: detected ip block number 8 <vcn_v4_0_0> (vcn_v4_0)
[   17.971846] amdgpu 0000:6e:00.0: detected ip block number 9 <jpeg_v4_0_0> (jpeg_v4_0)
[   17.972025] amdgpu 0000:6e:00.0: detected ip block number 10 <mes_v11_0_0> (mes_v11_0)
[   17.972205] amdgpu 0000:6e:00.0: Fetched VBIOS from VFCT
[   17.972380] amdgpu 0000:6e:00.0: [drm] ATOM BIOS: 113-PHXGENERIC-001, build: 00132130, ver: 022.012.000.028.000001, 2024/12/10
[   17.981854] Console: switching to colour dummy device 80x25
[   17.981875] amdgpu 0000:6e:00.0: vgaarb: deactivate vga console
[   17.981879] amdgpu 0000:6e:00.0: Trusted Memory Zone (TMZ) feature enabled
[   17.981912] amdgpu 0000:6e:00.0: vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[   17.981925] amdgpu 0000:6e:00.0: VRAM: 2048M 0x0000008000000000 - 0x000000807FFFFFFF (2048M used)
[   17.981929] amdgpu 0000:6e:00.0: GART: 512M 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[   17.981941] amdgpu 0000:6e:00.0: [drm] Detected VRAM RAM=2048M, BAR=2048M
[   17.981944] amdgpu 0000:6e:00.0: [drm] RAM width 128bits DDR5
[   17.982206] amdgpu 0000:6e:00.0:  2048M of VRAM memory ready
[   17.982211] amdgpu 0000:6e:00.0:  30934M of GTT memory ready.
[   17.982227] amdgpu 0000:6e:00.0: [drm] GART: num cpu pages 131072, num gpu pages 131072
[   17.982386] amdgpu 0000:6e:00.0: [drm] PCIE GART of 512M enabled (table at 0x0000008000900000).
[   17.982659] amdgpu 0000:6e:00.0: [drm] Loading DMUB firmware via PSP: version=0x08006200
[   17.982902] amdgpu 0000:6e:00.0: [VCN instance 0] Found VCN firmware Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 34
[   17.982947] amdgpu 0000:6e:00.0: MES: vmid_mask_mmhub 0x0000ff00, vmid_mask_gfxhub 0x0000ff00
[   17.982951] amdgpu 0000:6e:00.0: MES: gfx_hqd_mask 0x00000002, compute_hqd_mask 0x0000000c, sdma_hqd_mask 0x000000fc
[   18.006234] amdgpu 0000:6e:00.0: reserve 0x4a00000 from 0x8070000000 for PSP TMR
[   18.080641] clocksource: Watchdog remote CPU 2 read timed out
[   18.651706] amdgpu 0000:6e:00.0: RAS: optional ras ta ucode is not available
[   18.659255] amdgpu 0000:6e:00.0: RAP: optional rap ta ucode is not available
[   18.659261] amdgpu 0000:6e:00.0: SECUREDISPLAY: optional securedisplay ta ucode is not available
[   18.659300] amdgpu 0000:6e:00.0: smu driver if version = 0x00000008, smu fw if version = 0x00000008, smu fw program = 0, smu fw version = 0x004c6700 (76.103.0)
[   18.693626] amdgpu 0000:6e:00.0: SMU is initialized successfully!
[   18.693919] amdgpu 0000:6e:00.0: [drm] Display Core v3.2.384 initialized on DCN 3.1.4
[   18.693925] amdgpu 0000:6e:00.0: [drm] DP-HDMI FRL PCON supported
[   18.696537] amdgpu 0000:6e:00.0: [drm] DMUB hardware initialized: version=0x08006200
[   18.697913] workqueue: name exceeds WQ_NAME_LEN. Truncating to: hdmi_frl_status_polling_workque
[   18.698143] snd_hda_intel 0000:6e:00.1: bound 0000:6e:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[   18.726448] amdgpu 0000:6e:00.0: [drm] HDMI-A-1: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   18.726496] amdgpu 0000:6e:00.0: [drm] DP-1: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   18.726520] amdgpu 0000:6e:00.0: [drm] DP-2: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   18.726570] amdgpu 0000:6e:00.0: [drm] DP-3: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   18.726615] amdgpu 0000:6e:00.0: [drm] DP-4: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   18.726663] amdgpu 0000:6e:00.0: [drm] DP-5: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   18.726719] amdgpu 0000:6e:00.0: [drm] DP-6: PSR support 0, DC PSR ver -1, sink PSR ver 0 DPCD caps 0x0 su_y_granularity 0
[   18.732640] kfd kfd: Allocated 3969056 bytes on gart
[   18.732655] kfd kfd: Total number of KFD nodes to be created: 1
[   18.732748] amdgpu: Virtual CRAT table created for GPU
[   18.733244] amdgpu: Topology: Add GPU node [0x1002:0x15bf]
[   18.733248] kfd kfd: added device 1002:15bf
[   18.733256] amdgpu 0000:6e:00.0: SE 1, SH per SE 2, CU per SH 6, active_cu_number 12
[   18.733262] amdgpu 0000:6e:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[   18.733266] amdgpu 0000:6e:00.0: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[   18.733270] amdgpu 0000:6e:00.0: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[   18.733274] amdgpu 0000:6e:00.0: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[   18.733277] amdgpu 0000:6e:00.0: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[   18.733281] amdgpu 0000:6e:00.0: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[   18.733284] amdgpu 0000:6e:00.0: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[   18.733288] amdgpu 0000:6e:00.0: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[   18.733291] amdgpu 0000:6e:00.0: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[   18.733295] amdgpu 0000:6e:00.0: ring sdma0 uses VM inv eng 12 on hub 0
[   18.733298] amdgpu 0000:6e:00.0: ring vcn_unified_0 uses VM inv eng 0 on hub 8
[   18.733302] amdgpu 0000:6e:00.0: ring jpeg_dec uses VM inv eng 1 on hub 8
[   18.733306] amdgpu 0000:6e:00.0: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
[   18.733747] amdgpu 0000:6e:00.0: Runtime PM not available
[   18.734447] amdgpu 0000:6e:00.0: [drm] Registered 4 planes with drm panic
[   18.734452] [drm] Initialized amdgpu 3.64.0 for 0000:6e:00.0 on minor 0
[   18.736414] amdgpu 0000:6e:00.0: [drm] Failed to setup vendor infoframe on connector HDMI-A-1: -22
[   18.739062] fbcon: amdgpudrmfb (fb0) is primary device
[   18.739243] [drm] pre_validate_dsc:1746 MST_DSC dsc precompute is not needed
[   18.985664] amdgpu 0000:6e:00.0: [drm] REG_WAIT timeout 1us * 100000 tries - optc314_disable_crtc line:146
[   19.036994] Console: switching to colour frame buffer device 160x50
[   19.072438] amdgpu 0000:6e:00.0: [drm] fb0: amdgpudrmfb frame buffer device
