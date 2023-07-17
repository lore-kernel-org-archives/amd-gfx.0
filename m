Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB40EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 13:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B2410E23C;
	Mon, 17 Jul 2023 13:10:08 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D0110E082
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 13:10:06 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202307171510010120; Mon, 17 Jul 2023 15:10:01 +0200
Message-ID: <647beed4-9d0b-e351-6f66-756f73eb73a5@daenzer.net>
Date: Mon, 17 Jul 2023 15:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-CA
To: Philip Yang <Philip.Yang@amd.com>
References: <20230510212333.2071373-28-alexander.deucher@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 28/29] drm/amdkfd: Refactor migrate init to support
 partition switch
In-Reply-To: <20230510212333.2071373-28-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1E.64B53DAB.001C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/10/23 23:23, Alex Deucher wrote:
> From: Philip Yang <Philip.Yang@amd.com>
> 
> Rename smv_migrate_init to a better name kgd2kfd_init_zone_device
> because it setup zone devive pgmap for page migration and keep it in
> kfd_migrate.c to access static functions svm_migrate_pgmap_ops. Call it
> only once in amdgpu_device_ip_init after adev ip blocks are initialized,
> but before amdgpu_amdkfd_device_init initialize kfd nodes which enable
> SVM support based on pgmap.
> 
> svm_range_set_max_pages is called by kgd2kfd_device_init everytime after
> switching compute partition mode.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I bisected a regression to this commit, which broke HW acceleration on this ThinkPad E595 with Picasso APU.

The IB test fails for the compute rings, see dmesg below.

Reverting this commit on top of the DRM changes merged for 6.5 fixes the issue.


[drm] amdgpu kernel modesetting enabled.
amdgpu: Topology: Add APU node [0x0:0x0]
[drm] initializing kernel modesetting (RAVEN 0x1002:0x15D8 0x17AA:0x5124 0xC1).
[drm] register mmio base: 0xD0500000
[drm] register mmio size: 524288
[drm] MCBP is enabled
[drm] add ip block number 0 <soc15_common>
[drm] add ip block number 1 <gmc_v9_0>
[drm] add ip block number 2 <vega10_ih>
[drm] add ip block number 3 <psp>
[drm] add ip block number 4 <powerplay>
[drm] add ip block number 5 <dm>
[drm] add ip block number 6 <gfx_v9_0>
[drm] add ip block number 7 <sdma_v4_0>
[drm] add ip block number 8 <vcn_v1_0>
[...]
[drm] BIOS signature incorrect 0 0
amdgpu 0000:05:00.0: amdgpu: Fetched VBIOS from ROM BAR
amdgpu: ATOM BIOS: 113-PICASSO-114
[drm] VCN decode is enabled in VM mode
[drm] VCN encode is enabled in VM mode
[drm] JPEG decode is enabled in VM mode
Console: switching to colour dummy device 80x25
amdgpu 0000:05:00.0: vgaarb: deactivate vga console
amdgpu 0000:05:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
stackdepot: allocating hash table of 1048576 entries via kvcalloc
[drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
amdgpu 0000:05:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
amdgpu 0000:05:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
amdgpu 0000:05:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
[drm] Detected VRAM RAM=2048M, BAR=2048M
[drm] RAM width 64bits DDR4
[drm] amdgpu: 2048M of VRAM memory ready
[drm] amdgpu: 6926M of GTT memory ready.
[drm] GART: num cpu pages 262144, num gpu pages 262144
[drm] PCIE GART of 1024M enabled.
[drm] PTB located at 0x000000F400A00000
amdgpu: hwmgr_sw_init smu backed is smu10_smu
[drm] Found VCN firmware Version ENC: 1.13 DEC: 2 VEP: 0 Revision: 4
amdgpu 0000:05:00.0: amdgpu: Will use PSP to load VCN firmware
[drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
amdgpu 0000:05:00.0: amdgpu: RAS: optional ras ta ucode is not available
amdgpu 0000:05:00.0: amdgpu: RAP: optional rap ta ucode is not available
[...]
[drm] DM_PPLIB: values for F clock
[drm] DM_PPLIB:         400000 in kHz, 2749 in mV
[drm] DM_PPLIB:         933000 in kHz, 3224 in mV
[drm] DM_PPLIB:         1067000 in kHz, 3924 in mV
[drm] DM_PPLIB:         1200000 in kHz, 4074 in mV
[drm] DM_PPLIB: values for DCF clock
[drm] DM_PPLIB:         300000 in kHz, 2749 in mV
[drm] DM_PPLIB:         600000 in kHz, 3224 in mV
[drm] DM_PPLIB:         626000 in kHz, 3924 in mV
[drm] DM_PPLIB:         654000 in kHz, 4074 in mV
[drm] Display Core initialized with v3.2.236! DCN 1.0
[...]
[drm] DM_MST: Differing MST start on aconnector: 000000008d5d4db0 [id: 94]
[drm] kiq ring mec 2 pipe 1 q 0
[drm] VCN decode and encode initialized successfully(under SPG Mode).
amdgpu: HMM registered 2048MB device memory
kfd kfd: amdgpu: Allocated 3969056 bytes on gart
kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
amdgpu: Topology: Add APU node [0x15d8:0x1002]
amdgpu 0000:05:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x169801800 flags=0x0070]
amdgpu 0000:05:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x13957d380 flags=0x0070]
kfd kfd: amdgpu: added device 1002:15d8
amdgpu 0000:05:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 11, active_cu_number 10
amdgpu 0000:05:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
amdgpu 0000:05:00.0: amdgpu: ring gfx_low uses VM inv eng 1 on hub 0
amdgpu 0000:05:00.0: amdgpu: ring gfx_high uses VM inv eng 4 on hub 0
amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 5 on hub 0
amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 6 on hub 0
amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 7 on hub 0
amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 8 on hub 0
amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 9 on hub 0
amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 10 on hub 0
amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 11 on hub 0
amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 12 on hub 0
amdgpu 0000:05:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 13 on hub 0
amdgpu 0000:05:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 8
amdgpu 0000:05:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 8
amdgpu 0000:05:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 8
amdgpu 0000:05:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 8
amdgpu 0000:05:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 8
[...]
[drm] Initialized amdgpu 3.54.0 20150101 for 0000:05:00.0 on minor 0
[...]
amdgpu 0000:05:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on comp_1.0.0 (-110).
amdgpu 0000:05:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on comp_1.1.0 (-110).
amdgpu 0000:05:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on comp_1.2.0 (-110).
amdgpu 0000:05:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on comp_1.3.0 (-110).
amdgpu 0000:05:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on comp_1.0.1 (-110).
amdgpu 0000:05:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on comp_1.1.1 (-110).
amdgpu 0000:05:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on comp_1.2.1 (-110).
amdgpu 0000:05:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on comp_1.3.1 (-110).
[drm:process_one_work] *ERROR* ib ring test failed (-110).
[drm] Downstream port present 1, type 0
fbcon: amdgpudrmfb (fb0) is primary device
Console: switching to colour frame buffer device 192x60
amdgpu 0000:05:00.0: [drm] fb0: amdgpudrmfb frame buffer device


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

