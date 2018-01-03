From: Meelis Roos <mroos@linux.ee>
Subject: Radeon rv250 GPU acceleration broken in 4.15-rc6
Date: Wed, 3 Jan 2018 22:36:00 +0200 (EET)
Message-ID: <alpine.LRH.2.21.1801032227490.12580@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Beacuse of PTI, I decided to test 4.15-rc6 on most of my test machines. 
And I happened to notice a radeon problem on RV250 era card with no 
monitor attached. 4.15-rc1 and earlier kernels did not show these 
errors, not kernels between rc1 and rc6 have been tested yet.

The messages in dmes are strange, like 2 threads trying to poke the card 
instead of one? Or is it just rrying AGP mode and then PCI mode and this 
double output is OK?

[    4.777185] [drm] radeon kernel modesetting enabled.
[    4.779418] [drm] initializing kernel modesetting (RV250 0x1002:0x4966 0x1458:0x4010 0x01).
[    4.779888] agpgart-amdk7 0000:00:00.0: AGP 2.0 bridge
[    4.779963] agpgart-amdk7 0000:00:00.0: putting AGP V2 device into 4x mode
[    4.780106] radeon 0000:01:05.0: putting AGP V2 device into 4x mode
[    4.780179] radeon 0000:01:05.0: GTT: 512M 0xC0000000 - 0xDFFFFFFF
[    4.780249] radeon 0000:01:05.0: VRAM: 128M 0x00000000E0000000 - 0x00000000E7FFFFFF (64M used)
[    4.780344] [drm] Detected VRAM RAM=128M, BAR=128M
[    4.780405] [drm] RAM width 128bits DDR
[    4.780622] [TTM] Zone  kernel: Available graphics memory: 439294 kiB
[    4.780686] [TTM] Zone highmem: Available graphics memory: 1032930 kiB
[    4.780749] [TTM] Initializing pool allocator
[    4.780898] [drm] radeon: 64M of VRAM memory ready
[    4.780961] [drm] radeon: 512M of GTT memory ready.
[    4.783068] radeon 0000:01:05.0: WB disabled
[    4.783166] radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x00000000c0000000 and cpu addr 0xf6a59461
[    4.783261] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    4.783323] [drm] Driver supports precise vblank timestamp query.
[    4.783447] [drm] radeon: irq initialized.
[    4.783509] [drm] Loading R200 Microcode
[    4.819844] [drm] radeon: ring at 0x00000000C0001000
[    4.923034] [drm:r100_ring_test [radeon]] *ERROR* radeon: ring test failed (scratch(0x15E4)=0xCAFEDEAD)
[    4.923181] [drm:r100_cp_init [radeon]] *ERROR* radeon: cp isn't working (-22).
[    4.923271] radeon 0000:01:05.0: failed initializing CP (-22).
[    4.923332] radeon 0000:01:05.0: Disabling GPU acceleration
[    5.025789] [drm:r100_cp_fini [radeon]] *ERROR* Wait for CP idle timeout, shutting down CP.
[    5.026022] [drm] radeon: cp finalized
[    5.026128] [drm] radeon: cp finalized
[    5.026223] [TTM] Finalizing pool allocator
[    5.027245] [TTM] Zone  kernel: Used memory at exit: 0 kiB
[    5.027331] [TTM] Zone highmem: Used memory at exit: 0 kiB
[    5.027397] [drm] radeon: ttm finalized
[    5.027468] [drm] Forcing AGP to PCI mode
[    5.027886] radeon 0000:01:05.0: VRAM: 128M 0x00000000E0000000 - 0x00000000E7FFFFFF (64M used)
[    5.028577] radeon 0000:01:05.0: GTT: 512M 0x00000000C0000000 - 0x00000000DFFFFFFF
[    5.028671] [drm] Detected VRAM RAM=128M, BAR=128M
[    5.028730] [drm] RAM width 128bits DDR
[    5.028942] [TTM] Zone  kernel: Available graphics memory: 439294 kiB
[    5.029005] [TTM] Zone highmem: Available graphics memory: 1032930 kiB
[    5.029066] [TTM] Initializing pool allocator
[    5.029216] [drm] radeon: 64M of VRAM memory ready
[    5.029277] [drm] radeon: 512M of GTT memory ready.
[    5.029342] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    5.034222] [drm] PCI GART of 512M enabled (table at 0x0000000035600000).
[    5.034393] radeon 0000:01:05.0: WB disabled
[    5.034465] radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x00000000c0000000 and cpu addr 0x516b4fc4
[    5.034557] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    5.034618] [drm] Driver supports precise vblank timestamp query.
[    5.034729] [drm] radeon: irq initialized.
[    5.034984] [drm] radeon: ring at 0x00000000C0001000
[    5.138470] [drm:r100_ring_test [radeon]] *ERROR* radeon: ring test failed (scratch(0x15E4)=0xCAFEDEAD)
[    5.138618] [drm:r100_cp_init [radeon]] *ERROR* radeon: cp isn't working (-22).
[    5.138704] radeon 0000:01:05.0: failed initializing CP (-22).
[    5.138764] radeon 0000:01:05.0: Disabling GPU acceleration
[    5.241223] [drm:r100_cp_fini [radeon]] *ERROR* Wait for CP idle timeout, shutting down CP.
[    5.241408] [drm] radeon: cp finalized
[    5.243484] [drm] No TV DAC info found in BIOS
[    5.243659] [drm] Radeon Display Connectors
[    5.243719] [drm] Connector 0:
[    5.243776] [drm]   VGA-1
[    5.243833] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[    5.243894] [drm]   Encoders:
[    5.243951] [drm]     CRT1: INTERNAL_DAC1
[    5.244064] [drm] Connector 1:
[    5.244120] [drm]   DVI-I-1
[    5.244176] [drm]   HPD1
[    5.244231] [drm]   DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
[    5.244291] [drm]   Encoders:
[    5.244346] [drm]     CRT2: INTERNAL_DAC2
[    5.244404] [drm]     DFP1: INTERNAL_TMDS1
[    5.244460] [drm] Connector 2:
[    5.244516] [drm]   SVIDEO-1
[    5.244571] [drm]   Encoders:
[    5.244626] [drm]     TV1: INTERNAL_DAC2
[    5.262348] [drm] Cannot find any crtc or sizes
[    5.262491] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:05.0 on minor 0
[    6.290422] [drm] Cannot find any crtc or sizes


-- 
Meelis Roos (mroos@linux.ee)
