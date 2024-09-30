Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11C5CE834D
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C26010E52B;
	Mon, 30 Sep 2024 14:32:48 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B4610E51A
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:32:45 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48UEWFrp2682337; Mon, 30 Sep 2024 20:02:15 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48UEWF0b2682336;
 Mon, 30 Sep 2024 20:02:15 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 04/12] drm/amdgpu: update the handle ptr in check_soft_reset
Date: Mon, 30 Sep 2024 20:00:11 +0530
Message-Id: <20240930143019.2682202-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930143019.2682202-1-sunil.khatri@amd.com>
References: <20240930143019.2682202-1-sunil.khatri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update the *handle to amdgpu_ip_block ptr for all
functions pointers of check_soft_reset.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 3 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 drivers/gpu/drm/amd/include/amd_shared.h          | 2 +-
 15 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 98083efd35e5..595a10b23b3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4949,7 +4949,8 @@ static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
 			continue;
 		if (adev->ip_blocks[i].version->funcs->check_soft_reset)
 			adev->ip_blocks[i].status.hang =
-				adev->ip_blocks[i].version->funcs->check_soft_reset(adev);
+				adev->ip_blocks[i].version->funcs->check_soft_reset(
+					&adev->ip_blocks[i]);
 		if (adev->ip_blocks[i].status.hang) {
 			dev_info(adev->dev, "IP block:%s is hung!\n", adev->ip_blocks[i].version->funcs->name);
 			asic_hang = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index cac0850c6610..4eb331336d95 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2953,9 +2953,9 @@ static int dce_v10_0_wait_for_idle(void *handle)
 	return 0;
 }
 
-static bool dce_v10_0_check_soft_reset(void *handle)
+static bool dce_v10_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return dce_v10_0_is_display_hung(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a190c0b53c57..df08f29843ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4907,10 +4907,10 @@ static int gfx_v11_0_soft_reset(void *handle)
 	return gfx_v11_0_cp_resume(adev);
 }
 
-static bool gfx_v11_0_check_soft_reset(void *handle)
+static bool gfx_v11_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	int i, r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	long tmo = msecs_to_jiffies(1000);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index a6a38719a333..d14a3412a0ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4921,9 +4921,9 @@ static int gfx_v8_0_resume(void *handle)
 	return gfx_v8_0_hw_init(handle);
 }
 
-static bool gfx_v8_0_check_soft_reset(void *handle)
+static bool gfx_v8_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
 	u32 tmp;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 23547561e97f..0d300f5c9411 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1289,10 +1289,10 @@ static int gmc_v8_0_wait_for_idle(void *handle)
 
 }
 
-static bool gmc_v8_0_check_soft_reset(void *handle)
+static bool gmc_v8_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 srbm_soft_reset = 0;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 tmp = RREG32(mmSRBM_STATUS);
 
 	if (tmp & SRBM_STATUS__VMC_BUSY_MASK)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 1b73bbb1ba3d..7e2a523bbe1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1231,9 +1231,9 @@ static int sdma_v3_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static bool sdma_v3_0_check_soft_reset(void *handle)
+static bool sdma_v3_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset = 0;
 	u32 tmp = RREG32(mmSRBM_STATUS2);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index d4eb1cb4594a..edf8f23a0211 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -791,9 +791,9 @@ static int sdma_v6_0_soft_reset(void *handle)
 	return sdma_v6_0_start(adev);
 }
 
-static bool sdma_v6_0_check_soft_reset(void *handle)
+static bool sdma_v6_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	int i, r;
 	long tmo = msecs_to_jiffies(1000);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 3c017db5800c..691870eca6d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -783,9 +783,9 @@ static int sdma_v7_0_soft_reset(void *handle)
 	return sdma_v7_0_start(adev);
 }
 
-static bool sdma_v7_0_check_soft_reset(void *handle)
+static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	int i, r;
 	long tmo = msecs_to_jiffies(1000);
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index bfcf672b527b..573a2e194bb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -386,9 +386,9 @@ static int tonga_ih_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static bool tonga_ih_check_soft_reset(void *handle)
+static bool tonga_ih_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset = 0;
 	u32 tmp = RREG32(mmSRBM_STATUS);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 642b8db993b3..7364cecca81a 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1164,9 +1164,9 @@ static int uvd_v6_0_wait_for_idle(void *handle)
 }
 
 #define AMDGPU_UVD_STATUS_BUSY_MASK    0xfd
-static bool uvd_v6_0_check_soft_reset(void *handle)
+static bool uvd_v6_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset = 0;
 	u32 tmp = RREG32(mmSRBM_STATUS);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index aef7ca1435f2..52d613b4cd84 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1484,9 +1484,9 @@ static int uvd_v7_0_wait_for_idle(void *handle)
 }
 
 #define AMDGPU_UVD_STATUS_BUSY_MASK    0xfd
-static bool uvd_v7_0_check_soft_reset(void *handle)
+static bool uvd_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset = 0;
 	u32 tmp = RREG32(mmSRBM_STATUS);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 3edd33978d67..6a8f555ffc61 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -627,9 +627,9 @@ static int vce_v3_0_wait_for_idle(void *handle)
 #define  AMDGPU_VCE_STATUS_BUSY_MASK (VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK | \
 				      VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK)
 
-static bool vce_v3_0_check_soft_reset(void *handle)
+static bool vce_v3_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset = 0;
 
 	/* According to VCE team , we should use VCE_STATUS instead
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 8ba0e3af018d..c89ae2d87b02 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -721,9 +721,9 @@ static int vce_v4_0_wait_for_idle(void *handle)
 #define  AMDGPU_VCE_STATUS_BUSY_MASK (VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK | \
 				      VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK)
 
-static bool vce_v4_0_check_soft_reset(void *handle)
+static bool vce_v4_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset = 0;
 
 	/* According to VCE team , we should use VCE_STATUS instead
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 71dc00548e92..3fc7ec283d9e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -326,7 +326,7 @@ static int dm_wait_for_idle(void *handle)
 	return 0;
 }
 
-static bool dm_check_soft_reset(void *handle)
+static bool dm_check_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 1939c0dcdd1d..1130dac8d173 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -392,7 +392,7 @@ struct amd_ip_funcs {
 	int (*resume)(void *handle);
 	bool (*is_idle)(void *handle);
 	int (*wait_for_idle)(void *handle);
-	bool (*check_soft_reset)(void *handle);
+	bool (*check_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*pre_soft_reset)(void *handle);
 	int (*soft_reset)(void *handle);
 	int (*post_soft_reset)(void *handle);
-- 
2.34.1

