From: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Modesetting (amdgpudrmfb) artifacts on RAVEN APU
Date: Tue, 6 Mar 2018 06:18:57 -0500
Message-ID: <6919064d-1d4e-0497-b362-930385386817@amd.com>
References: <58ac616f-a10a-3452-03c9-a85e6bd88626@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------E326DC93A65AEDD52EB5E0C2"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <58ac616f-a10a-3452-03c9-a85e6bd88626-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
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
To: KARBOWSKI Piotr <piotr.karbowski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Wentland, Harry" <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------E326DC93A65AEDD52EB5E0C2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I believe this is the same issue I had which is a VGA handoff problem.

Can you try this patch the display team sent me?

Harry:  Will this patch be promoted in the next cycle?

Tom

On 03/05/2018 11:40 AM, KARBOWSKI Piotr wrote:
> Hi list,
> 
> I'd like to report a very odd screen artifacts while running both 
> 4.16-rc3, as well as latest 4.16-rc4 with git linux-firmware.
> 
> I am using Ryzen 2400G with the integrate Vega.
> 
> I am aware that RAVEN support is yet to be finished, however I've read 
> that some people do run it already, so I figured I will report the 
> issues, since other does not seems to hit it.
> 
> I have amdgpu and all it's symbols built into the kernel image, and the 
> firmware added to initrammfs. The moment modesetting is initializing I 
> can see that native screen resolution goes, however, I can see only like 
> 25% of the screen and this very top-left 25% of screen is duplicated to 
> top-right. While the bottom half of screen is either black or have 
> lines, usually gray, unless some text on screen had another color then 
> it's green, blue, etc.
> 
> Screenshots:
> 
>      https://i.imgur.com/qnDOKY7.jpg
>      https://i.imgur.com/XH42zit.jpg
> 
> The AMD symbols that I've enabled in kernel:
> 
>      CONFIG_CPU_SUP_AMD=y
>      CONFIG_X86_MCE_AMD=y
>      CONFIG_AMD_NB=y
>      CONFIG_NET_VENDOR_AMD=y
>      CONFIG_DRM_AMDGPU=y
>      CONFIG_DRM_AMDGPU_SI=y
>      CONFIG_DRM_AMDGPU_CIK=y
>      CONFIG_DRM_AMD_ACP=y
>      CONFIG_DRM_AMD_DC=y
>      CONFIG_DRM_AMD_DC_FBC=y
>      CONFIG_DRM_AMD_DC_DCN1_0=y
>      CONFIG_HSA_AMD=y
>      CONFIG_AMD_IOMMU=y
>      CONFIG_AMD_IOMMU_V2=y
> 
> The kernel log that had either drm, amd or firmware in there:
> 
>      [    0.000000] RAMDISK: [mem 0x7f88c000-0x7fffffff]
>      [    0.000000] ACPI: SSDT 0x000000009BD94908 005367 (v02 AMD 
> AmdTable 00000002 MSFT 02000002)
>      [    0.000000] ACPI: SSDT 0x000000009BD99C70 00119C (v01 AMD    AMD 
> CPU  00000001 AMD  00000001)
>      [    0.000000] ACPI: CRAT 0x000000009BD9AE10 000810 (v01 AMD    AMD 
> CRAT 00000001 AMD  00000001)
>      [    0.000000] ACPI: CDIT 0x000000009BD9B620 000029 (v01 AMD    AMD 
> CDIT 00000001 AMD  00000001)
>      [    0.000000] ACPI: SSDT 0x000000009BD9B650 002E6E (v01 AMD    AMD 
> AOD  00000001 INTL 20120913)
>      [    0.000000] ACPI: IVRS 0x000000009BD9E580 0000D0 (v02 AMD    AMD 
> IVRS 00000001 AMD  00000000)
>      [    0.000000] ACPI: SSDT 0x000000009BD9E650 0000F8 (v01 AMD    AMD 
> PT   00001000 INTL 20120913)
>      [    0.000000] ACPI: SSDT 0x000000009BD9E748 000E96 (v01 AMD 
> AmdTable 00000001 INTL 20120913)
>      [    0.000000] ACPI: SSDT 0x000000009BD9F5E0 000850 (v01 AMD 
> AmdTable 00000001 INTL 20120913)
>      [    0.000000] ACPI: SSDT 0x000000009BD9FE30 001993 (v01 AMD 
> AmdTable 00000001 INTL 20120913)
>      [    0.000000] Kernel command line: BOOT_IMAGE=/bzImage-4.16.0-rc4 
> rootfstype=ext4 luks enc_root=/dev/sda2 lvm 
> root=/dev/mapper/megumin-rootfs 
> initrd=/initramfs.cpio.gz,/firmware-initramfs.cpio.gz
>      [    0.000000] ACPI Error: AE_ALREADY_EXISTS, (SSDT:  AMD PT) while 
> loading table (20180105/tbxfload-228)
>      [    0.080000] smpboot: CPU0: AMD Ryzen 5 2400G with Radeon Vega 
> Graphics (family: 0x17, model: 0x11, stepping: 0x0)
>      [    0.080000] Performance Events: Fam17h core perfctr, AMD PMU 
> driver.
>      [    0.101786] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
>      [    0.615782] AMD-Vi: IOMMU performance counters supported
>      [    0.623179] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
>      [    0.623314] AMD-Vi: Extended features (0x4f77ef22294ada):
>      [    0.623684] AMD-Vi: Lazy IO/TLB flushing enabled
>      [    0.624533] amd_uncore: AMD NB counters detected
>      [    0.624666] amd_uncore: AMD LLC counters detected
>      [    0.625076] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 
> counters/bank).
>      [    0.636229] AMD IOMMUv2 driver by Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>      [    0.637179] [drm] amdgpu kernel modesetting enabled.
>      [    0.637409] [drm] initializing kernel modesetting (RAVEN 
> 0x1002:0x15DD 0x1458:0xD000 0xC6).
>      [    0.637583] [drm] register mmio base: 0xFE500000
>      [    0.637709] [drm] register mmio size: 524288
>      [    0.637852] [drm] probing gen 2 caps for device 1022:15db = 
> 700d03/e
>      [    0.638005] [drm] probing mlw for device 1022:15db = 700d03
>      [    0.638213] [drm] VCN decode is enabled in VM mode
>      [    0.638341] [drm] VCN encode is enabled in VM mode
>      [    0.660265] [drm] BIOS signature incorrect 74 7
>      [    0.660422] [drm] vm size is 262144 GB, 4 levels, block size is 
> 9-bit, fragment size is 9-bit
>      [    0.660515] amdgpu 0000:09:00.0: VRAM: 1024M 0x000000F400000000 
> - 0x000000F43FFFFFFF (1024M used)
>      [    0.660607] amdgpu 0000:09:00.0: GTT: 1024M 0x000000F500000000 - 
> 0x000000F53FFFFFFF
>      [    0.660689] [drm] Detected VRAM RAM=1024M, BAR=256M
>      [    0.660756] [drm] RAM width 128bits UNKNOWN
>      [    0.661653] [drm] amdgpu: 1024M of VRAM memory ready
>      [    0.661720] [drm] amdgpu: 3072M of GTT memory ready.
>      [    0.661793] [drm] GART: num cpu pages 262144, num gpu pages 262144
>      [    0.662027] [drm] PCIE GART of 1024M enabled (table at 
> 0x000000F400800000).
>      [    0.663093] [drm] use_doorbell being set to: [true]
>      [    0.663229] [drm] Found VCN firmware Version: 1.73 Family ID: 18
>      [    1.011745] [drm:construct] *ERROR* construct: Invalid Connector 
> ObjectID from Adapter Service for connector index:1! type 0 expected 3
>      [    1.011969] [drm:construct] *ERROR* construct: Invalid Connector 
> ObjectID from Adapter Service for connector index:2! type 0 expected 3
>      [    1.025959] [drm] Display Core initialized with v3.1.27!
>      [    1.051053] [drm] Supports vblank timestamp caching Rev 2 
> (21.10.2013).
>      [    1.051128] [drm] Driver supports precise vblank timestamp query.
>      [    1.074231] [drm] VCN decode and encode initialized successfully.
>      [    1.081965] [drm] fb mappable at 0xE1000000
>      [    1.082029] [drm] vram apper at 0xE0000000
>      [    1.082095] [drm] size 8294400
>      [    1.082155] [drm] fb depth is 24
>      [    1.082216] [drm]    pitch is 7680
>      [    1.082323] fbcon: amdgpudrmfb (fb0) is primary device
>      [    1.200687] amdgpu 0000:09:00.0: fb0: amdgpudrmfb frame buffer 
> device
>      [    1.200734] amdgpu 0000:09:00.0: ring 0(gfx) uses VM inv eng 4 
> on hub 0
>      [    1.200752] amdgpu 0000:09:00.0: ring 1(comp_1.0.0) uses VM inv 
> eng 5 on hub 0
>      [    1.200770] amdgpu 0000:09:00.0: ring 2(comp_1.1.0) uses VM inv 
> eng 6 on hub 0
>      [    1.200788] amdgpu 0000:09:00.0: ring 3(comp_1.2.0) uses VM inv 
> eng 7 on hub 0
>      [    1.200806] amdgpu 0000:09:00.0: ring 4(comp_1.3.0) uses VM inv 
> eng 8 on hub 0
>      [    1.200824] amdgpu 0000:09:00.0: ring 5(comp_1.0.1) uses VM inv 
> eng 9 on hub 0
>      [    1.200845] amdgpu 0000:09:00.0: ring 6(comp_1.1.1) uses VM inv 
> eng 10 on hub 0
>      [    1.200863] amdgpu 0000:09:00.0: ring 7(comp_1.2.1) uses VM inv 
> eng 11 on hub 0
>      [    1.200881] amdgpu 0000:09:00.0: ring 8(comp_1.3.1) uses VM inv 
> eng 12 on hub 0
>      [    1.200900] amdgpu 0000:09:00.0: ring 9(kiq_2.1.0) uses VM inv 
> eng 13 on hub 0
>      [    1.200918] amdgpu 0000:09:00.0: ring 10(sdma0) uses VM inv eng 
> 4 on hub 1
>      [    1.200935] amdgpu 0000:09:00.0: ring 11(vcn_dec) uses VM inv 
> eng 5 on hub 1
>      [    1.200952] amdgpu 0000:09:00.0: ring 12(vcn_enc0) uses VM inv 
> eng 6 on hub 1
>      [    1.200970] amdgpu 0000:09:00.0: ring 13(vcn_enc1) uses VM inv 
> eng 7 on hub 1
>      [    1.204453] [drm] Initialized amdgpu 3.23.0 20150101 for 
> 0000:09:00.0 on minor 0
> 
> -- Piotr.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------E326DC93A65AEDD52EB5E0C2
Content-Type: text/x-patch;
 name="0001-drm-amd-display-Fix-takeover-from-VGA-mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-amd-display-Fix-takeover-from-VGA-mode.patch"

>From d8b5b07a417df123ed5eda909a266b0632f2b0d8 Mon Sep 17 00:00:00 2001
From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 27 Feb 2018 10:15:56 -0500
Subject: [PATCH] drm/amd/display: Fix takeover from VGA mode

HW Engineer's Notes:
During switch from vga->extended, if we set the VGA_TEST_ENABLE and then
hit the VGA_TEST_RENDER_START, then the DCHUBP timing gets updated correctly.
Then vBIOS will have it poll for the VGA_TEST_RENDER_DONE and unset
VGA_TEST_ENABLE, to leave it in the same state as before.

Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h            | 10 ++++++++--
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
index 3336428b1fed..4448cf926179 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
@@ -190,6 +190,7 @@
 	SR(D2VGA_CONTROL), \
 	SR(D3VGA_CONTROL), \
 	SR(D4VGA_CONTROL), \
+	SR(VGA_TEST_CONTROL), \
 	SR(DC_IP_REQUEST_CNTL), \
 	BL_REG_LIST()
 
@@ -261,6 +262,7 @@ struct dce_hwseq_registers {
 	uint32_t D2VGA_CONTROL;
 	uint32_t D3VGA_CONTROL;
 	uint32_t D4VGA_CONTROL;
+	uint32_t VGA_TEST_CONTROL;
 	/* MMHUB registers. read only. temporary hack */
 	uint32_t VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32;
 	uint32_t VM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
@@ -358,7 +360,9 @@ struct dce_hwseq_registers {
 	HWSEQ_PIXEL_RATE_MASK_SH_LIST(mask_sh, OTG0_),\
 	HWS_SF1(OTG0_, PHYPLL_PIXEL_RATE_CNTL, PHYPLL_PIXEL_RATE_SOURCE, mask_sh), \
 	HWS_SF(, DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, mask_sh), \
-	HWS_SF(, DCFCLK_CNTL, DCFCLK_GATE_DIS, mask_sh)
+	HWS_SF(, DCFCLK_CNTL, DCFCLK_GATE_DIS, mask_sh),\
+	HWS_SF(, VGA_TEST_CONTROL, VGA_TEST_ENABLE, mask_sh),\
+	HWS_SF(, VGA_TEST_CONTROL, VGA_TEST_RENDER_START, mask_sh)
 
 #define HWSEQ_DCN1_MASK_SH_LIST(mask_sh)\
 	HWSEQ_DCN_MASK_SH_LIST(mask_sh), \
@@ -483,7 +487,9 @@ struct dce_hwseq_registers {
 	type DCFCLK_GATE_DIS; \
 	type DCHUBBUB_GLOBAL_TIMER_REFDIV; \
 	type DENTIST_DPPCLK_WDIVIDER; \
-	type DENTIST_DISPCLK_WDIVIDER;
+	type DENTIST_DISPCLK_WDIVIDER; \
+	type VGA_TEST_ENABLE; \
+	type VGA_TEST_RENDER_START;
 
 struct dce_hwseq_shift {
 	HWSEQ_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 1907ade1574a..eedf83078751 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -224,6 +224,8 @@ static void disable_vga(
 	REG_WRITE(D2VGA_CONTROL, 0);
 	REG_WRITE(D3VGA_CONTROL, 0);
 	REG_WRITE(D4VGA_CONTROL, 0);
+	REG_UPDATE(VGA_TEST_CONTROL, VGA_TEST_ENABLE, 1);
+	REG_UPDATE(VGA_TEST_CONTROL, VGA_TEST_RENDER_START, 1);
 }
 
 static void dpp_pg_control(
-- 
2.14.3


--------------E326DC93A65AEDD52EB5E0C2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------E326DC93A65AEDD52EB5E0C2--
