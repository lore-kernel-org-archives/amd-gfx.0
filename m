From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] drm/amdgpu: Use less generic enum definitions
Date: Wed,  3 May 2017 23:49:18 -0700
Message-ID: <1493880558-445-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

alpha:allmodconfig fails to build as follows.

drivers/gpu/drm/amd/amdgpu/amdgpu.h:1006:2: error:
	expected identifier before '(' token
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1011:28: error:
	'NGG_BUF_MAX' undeclared here

The problem is not really the enum definition of NGG_BUF_MAX but PARAM,
which happens to be defined differently for alpha and a couple of other
architectures.

Use less generic defines for NGG enums to solve the problem.

Fixes: bce23e00f3369 ("drm/amdgpu: add NGG parameters")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Another option would be to blacklist all affected architectures.
AFAICS that would currently be alpha, m32r, and sh.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 28 ++++++++++++++--------------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6a8129949333..40f1195136a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1000,10 +1000,10 @@ struct amdgpu_ngg_buf {
 };
 
 enum {
-	PRIM = 0,
-	POS,
-	CNTL,
-	PARAM,
+	NGG_PRIM = 0,
+	NGG_POS,
+	NGG_CNTL,
+	NGG_PARAM,
 	NGG_BUF_MAX
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 832be632478f..4abf2e924cd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -545,10 +545,10 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 			adev->gfx.config.double_offchip_lds_buf;
 
 		if (amdgpu_ngg) {
-			dev_info.prim_buf_gpu_addr = adev->gfx.ngg.buf[PRIM].gpu_addr;
-			dev_info.pos_buf_gpu_addr = adev->gfx.ngg.buf[POS].gpu_addr;
-			dev_info.cntl_sb_buf_gpu_addr = adev->gfx.ngg.buf[CNTL].gpu_addr;
-			dev_info.param_buf_gpu_addr = adev->gfx.ngg.buf[PARAM].gpu_addr;
+			dev_info.prim_buf_gpu_addr = adev->gfx.ngg.buf[NGG_PRIM].gpu_addr;
+			dev_info.pos_buf_gpu_addr = adev->gfx.ngg.buf[NGG_POS].gpu_addr;
+			dev_info.cntl_sb_buf_gpu_addr = adev->gfx.ngg.buf[NGG_CNTL].gpu_addr;
+			dev_info.param_buf_gpu_addr = adev->gfx.ngg.buf[NGG_PARAM].gpu_addr;
 		}
 
 		return copy_to_user(out, &dev_info,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index a447b70841c9..a95e79dd3e3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -888,7 +888,7 @@ static int gfx_v9_0_ngg_init(struct amdgpu_device *adev)
 	adev->gfx.ngg.gds_reserve_addr += adev->gds.mem.gfx_partition_size;
 
 	/* Primitive Buffer */
-	r = gfx_v9_0_ngg_create_buf(adev, &adev->gfx.ngg.buf[PRIM],
+	r = gfx_v9_0_ngg_create_buf(adev, &adev->gfx.ngg.buf[NGG_PRIM],
 				    amdgpu_prim_buf_per_se,
 				    64 * 1024);
 	if (r) {
@@ -897,7 +897,7 @@ static int gfx_v9_0_ngg_init(struct amdgpu_device *adev)
 	}
 
 	/* Position Buffer */
-	r = gfx_v9_0_ngg_create_buf(adev, &adev->gfx.ngg.buf[POS],
+	r = gfx_v9_0_ngg_create_buf(adev, &adev->gfx.ngg.buf[NGG_POS],
 				    amdgpu_pos_buf_per_se,
 				    256 * 1024);
 	if (r) {
@@ -906,7 +906,7 @@ static int gfx_v9_0_ngg_init(struct amdgpu_device *adev)
 	}
 
 	/* Control Sideband */
-	r = gfx_v9_0_ngg_create_buf(adev, &adev->gfx.ngg.buf[CNTL],
+	r = gfx_v9_0_ngg_create_buf(adev, &adev->gfx.ngg.buf[NGG_CNTL],
 				    amdgpu_cntl_sb_buf_per_se,
 				    256);
 	if (r) {
@@ -918,7 +918,7 @@ static int gfx_v9_0_ngg_init(struct amdgpu_device *adev)
 	if (amdgpu_param_buf_per_se <= 0)
 		goto out;
 
-	r = gfx_v9_0_ngg_create_buf(adev, &adev->gfx.ngg.buf[PARAM],
+	r = gfx_v9_0_ngg_create_buf(adev, &adev->gfx.ngg.buf[NGG_PARAM],
 				    amdgpu_param_buf_per_se,
 				    512 * 1024);
 	if (r) {
@@ -947,45 +947,45 @@ static int gfx_v9_0_ngg_en(struct amdgpu_device *adev)
 
 	/* Program buffer size */
 	data = 0;
-	size = adev->gfx.ngg.buf[PRIM].size / 256;
+	size = adev->gfx.ngg.buf[NGG_PRIM].size / 256;
 	data = REG_SET_FIELD(data, WD_BUF_RESOURCE_1, INDEX_BUF_SIZE, size);
 
-	size = adev->gfx.ngg.buf[POS].size / 256;
+	size = adev->gfx.ngg.buf[NGG_POS].size / 256;
 	data = REG_SET_FIELD(data, WD_BUF_RESOURCE_1, POS_BUF_SIZE, size);
 
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmWD_BUF_RESOURCE_1), data);
 
 	data = 0;
-	size = adev->gfx.ngg.buf[CNTL].size / 256;
+	size = adev->gfx.ngg.buf[NGG_CNTL].size / 256;
 	data = REG_SET_FIELD(data, WD_BUF_RESOURCE_2, CNTL_SB_BUF_SIZE, size);
 
-	size = adev->gfx.ngg.buf[PARAM].size / 1024;
+	size = adev->gfx.ngg.buf[NGG_PARAM].size / 1024;
 	data = REG_SET_FIELD(data, WD_BUF_RESOURCE_2, PARAM_BUF_SIZE, size);
 
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmWD_BUF_RESOURCE_2), data);
 
 	/* Program buffer base address */
-	base = lower_32_bits(adev->gfx.ngg.buf[PRIM].gpu_addr);
+	base = lower_32_bits(adev->gfx.ngg.buf[NGG_PRIM].gpu_addr);
 	data = REG_SET_FIELD(0, WD_INDEX_BUF_BASE, BASE, base);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmWD_INDEX_BUF_BASE), data);
 
-	base = upper_32_bits(adev->gfx.ngg.buf[PRIM].gpu_addr);
+	base = upper_32_bits(adev->gfx.ngg.buf[NGG_PRIM].gpu_addr);
 	data = REG_SET_FIELD(0, WD_INDEX_BUF_BASE_HI, BASE_HI, base);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmWD_INDEX_BUF_BASE_HI), data);
 
-	base = lower_32_bits(adev->gfx.ngg.buf[POS].gpu_addr);
+	base = lower_32_bits(adev->gfx.ngg.buf[NGG_POS].gpu_addr);
 	data = REG_SET_FIELD(0, WD_POS_BUF_BASE, BASE, base);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmWD_POS_BUF_BASE), data);
 
-	base = upper_32_bits(adev->gfx.ngg.buf[POS].gpu_addr);
+	base = upper_32_bits(adev->gfx.ngg.buf[NGG_POS].gpu_addr);
 	data = REG_SET_FIELD(0, WD_POS_BUF_BASE_HI, BASE_HI, base);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmWD_POS_BUF_BASE_HI), data);
 
-	base = lower_32_bits(adev->gfx.ngg.buf[CNTL].gpu_addr);
+	base = lower_32_bits(adev->gfx.ngg.buf[NGG_CNTL].gpu_addr);
 	data = REG_SET_FIELD(0, WD_CNTL_SB_BUF_BASE, BASE, base);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmWD_CNTL_SB_BUF_BASE), data);
 
-	base = upper_32_bits(adev->gfx.ngg.buf[CNTL].gpu_addr);
+	base = upper_32_bits(adev->gfx.ngg.buf[NGG_CNTL].gpu_addr);
 	data = REG_SET_FIELD(0, WD_CNTL_SB_BUF_BASE_HI, BASE_HI, base);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmWD_CNTL_SB_BUF_BASE_HI), data);
 
-- 
2.7.4
