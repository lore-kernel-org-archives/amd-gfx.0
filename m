From: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Add SQ_WAVE_TTMPx support for gfx9
Date: Fri, 6 Apr 2018 10:51:34 -0400
Message-ID: <9e0d7965-10d8-a7ce-1a71-0194a12b6017@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------FFF13AFC43ACC0899A3D9567"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------FFF13AFC43ACC0899A3D9567
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Patches attached for both umr/kernel.

Tested on my Raven1.  I'll circle back to adding gfx8 after lunch.

Tom

--------------FFF13AFC43ACC0899A3D9567
Content-Type: text/x-patch;
 name="0001-drm-amd-amdgpu-Add-SQ_WAVE_TTMP-registers-to-wave-da.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drm-amd-amdgpu-Add-SQ_WAVE_TTMP-registers-to-wave-da.pa";
 filename*1="tch"

>From e8171c0abbb2806d644065f5e212a7d8b35ff7f8 Mon Sep 17 00:00:00 2001
From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 6 Apr 2018 10:34:47 -0400
Subject: [PATCH] drm/amd/amdgpu: Add SQ_WAVE_TTMP registers to wave data

As read by debugfs.  To aid in debugging by using TMP registers and reding
back via umr.

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index c98e59721444..c404f59d9d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -463,7 +463,7 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
 	struct amdgpu_device *adev = f->f_inode->i_private;
 	int r, x;
 	ssize_t result=0;
-	uint32_t offset, se, sh, cu, wave, simd, data[32];
+	uint32_t offset, se, sh, cu, wave, simd, data[64];
 
 	if (size & 3 || *pos & 3)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 9d39fd5b1822..2fe26dc66536 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -961,8 +961,11 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t simd,
 
 static void gfx_v9_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
-	/* type 1 wave data */
-	dst[(*no_fields)++] = 1;
+	unsigned x;
+	/* type 1 wave data was original for gfx9 */
+	/* type 2 is otherwise used */
+	/* type 3 adds TTMP to gfx9 */
+	dst[(*no_fields)++] = 3;
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_STATUS);
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_LO);
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_HI);
@@ -977,6 +980,8 @@ static void gfx_v9_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, u
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
+	for (x = 0; x < 16; x++)
+		dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TTMP0 + x);
 }
 
 static void gfx_v9_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
-- 
2.14.3


--------------FFF13AFC43ACC0899A3D9567
Content-Type: text/x-patch;
 name="0001-Add-SQ_WAVE_TTMP-support-for-gfx9-platforms.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Add-SQ_WAVE_TTMP-support-for-gfx9-platforms.patch"

>From 55c4ed5e4917c4eb09255f232110499ae2614422 Mon Sep 17 00:00:00 2001
From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 6 Apr 2018 10:49:16 -0400
Subject: [PATCH umr] Add SQ_WAVE_TTMP support for gfx9 platforms.

(gfx8... will follow)

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
---
 src/app/print_waves.c | 25 +++++++++++++++++++++++++
 src/lib/wave_status.c | 19 ++++++++++++++++---
 src/umr.h             |  3 +++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/src/app/print_waves.c b/src/app/print_waves.c
index e4e6b87566fb..ed8b104abac8 100644
--- a/src/app/print_waves.c
+++ b/src/app/print_waves.c
@@ -111,6 +111,18 @@ void umr_print_waves(struct umr_asic *asic)
 								(unsigned long long)(pgm_addr + 4 * x),
 								(unsigned long)opcodes[x]);
 						}
+
+						if (ws.have_ttmp) {
+							for (x = 0; x < 16; x += 4) {
+								printf("TTMP[%u..%u] = { %08lx, %08lx, %08lx, %08lx }\n",
+									(unsigned)x,
+									(unsigned)x + 3,
+									(unsigned long)ws.ttmp[x],
+									(unsigned long)ws.ttmp[x+1],
+									(unsigned long)ws.ttmp[x+2],
+									(unsigned long)ws.ttmp[x+3]);
+							}
+						}
 					} else {
 						first = 0;
 						printf("\n------------------------------------------------------\nse%u.sh%u.cu%u.simd%u.wave%u\n",
@@ -238,6 +250,19 @@ void umr_print_waves(struct umr_asic *asic)
 						PP(trapsts, excp_cycle);
 						PP(trapsts, dp_rate);
 
+						if (ws.have_ttmp) {
+							printf("\n\nTTMP:\n");
+							for (x = 0; x < 16; x += 4) {
+								printf("\t[%2u..%2u]\t=\t{ %08lx, %08lx, %08lx, %08lx }\n",
+									(unsigned)x,
+									(unsigned)x + 3,
+									(unsigned long)ws.ttmp[x],
+									(unsigned long)ws.ttmp[x+1],
+									(unsigned long)ws.ttmp[x+2],
+									(unsigned long)ws.ttmp[x+3]);
+							}
+						}
+
 						printf("\n"); col = 0;
 					}
 
diff --git a/src/lib/wave_status.c b/src/lib/wave_status.c
index 3f4d33b66c4a..92ce624c07a9 100644
--- a/src/lib/wave_status.c
+++ b/src/lib/wave_status.c
@@ -205,7 +205,7 @@ static int umr_get_wave_status_vi(struct umr_asic *asic, unsigned se, unsigned s
 
 static int umr_get_wave_status_ai(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, unsigned simd, unsigned wave, struct umr_wave_status *ws)
 {
-	uint32_t x, value, buf[32];
+	uint32_t x, value, buf[64];
 
 	memset(buf, 0, sizeof buf);
 
@@ -225,8 +225,8 @@ static int umr_get_wave_status_ai(struct umr_asic *asic, unsigned se, unsigned s
 		umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
 	}
 
-	if (buf[0] != 1) {
-		fprintf(stderr, "[ERROR]: Was expecting type 1 wave data on a FAMILY_AI part!\n");
+	if (buf[0] != 1 && buf[0] != 3) {
+		fprintf(stderr, "[ERROR]: Was expecting type 1 or 3 wave data on a FAMILY_AI part!\n");
 		return -1;
 	}
 
@@ -300,11 +300,24 @@ static int umr_get_wave_status_ai(struct umr_asic *asic, unsigned se, unsigned s
 	ws->ib_dbg0 = buf[x++];
 	ws->m0 = buf[x++];
 
+	if (buf[0] == 3) {
+		unsigned y;
+		// we have TTMP registers
+		ws->have_ttmp = 1;
+		for (y = 0; y < 16; y++) {
+			ws->ttmp[y] = buf[x++];
+		}
+	} else {
+		ws->have_ttmp = 0;
+		memset(ws->ttmp, 0, sizeof(ws->ttmp));
+	}
+
 	return 0;
 }
 
 int umr_get_wave_status(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, unsigned simd, unsigned wave, struct umr_wave_status *ws)
 {
+	memset(ws, 0, sizeof(*ws));
 	if (asic->family == FAMILY_AI || asic->family == FAMILY_RV)
 		return umr_get_wave_status_ai(asic, se, sh, cu, simd, wave, ws);
 	else if (asic->family <= FAMILY_VI)
diff --git a/src/umr.h b/src/umr.h
index 7a214bfb565e..560424ff4d1e 100644
--- a/src/umr.h
+++ b/src/umr.h
@@ -358,6 +358,9 @@ struct umr_wave_status {
 			excp_cycle,
 			dp_rate;
 	} trapsts;
+
+	int have_ttmp;
+	uint32_t ttmp[16];
 };
 
 struct umr_ring_decoder {
-- 
2.14.3


--------------FFF13AFC43ACC0899A3D9567
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------FFF13AFC43ACC0899A3D9567--
