Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ACBCE834D
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E14A10E519;
	Mon, 30 Sep 2024 14:32:23 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B8B210E51A
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:32:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48UEWFvO2682347; Mon, 30 Sep 2024 20:02:15 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48UEWF2Z2682346;
 Mon, 30 Sep 2024 20:02:15 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 06/12] drm/amdgpu: update the handle ptr in soft_reset
Date: Mon, 30 Sep 2024 20:00:13 +0530
Message-Id: <20240930143019.2682202-7-sunil.khatri@amd.com>
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
functions pointers of soft_reset.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          | 2 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                  | 2 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c               | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c             | 6 +++---
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                | 4 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 2 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c              | 2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c              | 2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c              | 2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                   | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            | 6 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/si.c                   | 2 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c               | 2 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c                | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc15.c                | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c                | 2 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                   | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 drivers/gpu/drm/amd/include/amd_shared.h          | 2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        | 2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 2 +-
 63 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 8c85d7a9e0b0..436f24d6bd83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -595,7 +595,7 @@ static int acp_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int acp_soft_reset(void *handle)
+static int acp_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dfba53afe8d1..527b8f186f45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5041,7 +5041,7 @@ static int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev)
 			continue;
 		if (adev->ip_blocks[i].status.hang &&
 		    adev->ip_blocks[i].version->funcs->soft_reset) {
-			r = adev->ip_blocks[i].version->funcs->soft_reset(adev);
+			r = adev->ip_blocks[i].version->funcs->soft_reset(&adev->ip_blocks[i]);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index f2198ac27967..e90b5f807440 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -160,7 +160,7 @@ static int isp_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int isp_soft_reset(void *handle)
+static int isp_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d2eafca7d320..af274e6b8422 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -637,7 +637,7 @@ static int amdgpu_vkms_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int amdgpu_vkms_soft_reset(void *handle)
+static int amdgpu_vkms_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 8e8e266b44ce..b39944e3ac68 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2177,7 +2177,7 @@ static int cik_common_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int cik_common_soft_reset(void *handle)
+static int cik_common_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX hard reset?? */
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 2ce7a6075a98..612330f40447 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -378,9 +378,9 @@ static int cik_ih_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int cik_ih_soft_reset(void *handle)
+static int cik_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	u32 srbm_soft_reset = 0;
 	u32 tmp = RREG32(mmSRBM_STATUS);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 6e7e78079630..8706855d681b 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -54,7 +54,7 @@ static void cik_sdma_set_ring_funcs(struct amdgpu_device *adev);
 static void cik_sdma_set_irq_funcs(struct amdgpu_device *adev);
 static void cik_sdma_set_buffer_funcs(struct amdgpu_device *adev);
 static void cik_sdma_set_vm_pte_funcs(struct amdgpu_device *adev);
-static int cik_sdma_soft_reset(void *handle);
+static int cik_sdma_soft_reset(struct amdgpu_ip_block *ip_block);
 
 MODULE_FIRMWARE("amdgpu/bonaire_sdma.bin");
 MODULE_FIRMWARE("amdgpu/bonaire_sdma1.bin");
@@ -1056,10 +1056,10 @@ static int cik_sdma_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int cik_sdma_soft_reset(void *handle)
+static int cik_sdma_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 srbm_soft_reset = 0;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 tmp;
 
 	/* sdma0 */
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index 71fe21313635..12a55f1e0e1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -374,10 +374,10 @@ static int cz_ih_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int cz_ih_soft_reset(void *handle)
+static int cz_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 srbm_soft_reset = 0;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 tmp = RREG32(mmSRBM_STATUS);
 
 	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 4eb331336d95..6f81621649d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2960,10 +2960,10 @@ static bool dce_v10_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return dce_v10_0_is_display_hung(adev);
 }
 
-static int dce_v10_0_soft_reset(void *handle)
+static int dce_v10_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 srbm_soft_reset = 0, tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (dce_v10_0_is_display_hung(adev))
 		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 9929b5bc6095..b1afe4b837a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3091,10 +3091,10 @@ static int dce_v11_0_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int dce_v11_0_soft_reset(void *handle)
+static int dce_v11_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 srbm_soft_reset = 0, tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (dce_v11_0_is_display_hung(adev))
 		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 7c464fc50dd6..a6bbeb3bde3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2848,7 +2848,7 @@ static int dce_v6_0_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int dce_v6_0_soft_reset(void *handle)
+static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	DRM_INFO("xxxx: dce_v6_0_soft_reset --- no impl!!\n");
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 3fbc275a9c42..0b57e22a7c95 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2871,10 +2871,10 @@ static int dce_v8_0_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int dce_v8_0_soft_reset(void *handle)
+static int dce_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 srbm_soft_reset = 0, tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (dce_v8_0_is_display_hung(adev))
 		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 123da87a3142..c544ea2aea6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7495,11 +7495,11 @@ static int gfx_v10_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int gfx_v10_0_soft_reset(void *handle)
+static int gfx_v10_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 grbm_soft_reset = 0;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* GRBM_STATUS */
 	tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index df08f29843ae..ebf783763ac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4776,12 +4776,12 @@ int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v11_0_soft_reset(void *handle)
+static int gfx_v11_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 grbm_soft_reset = 0;
 	u32 tmp;
 	int r, i, j, k;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 1fef47735da4..60579b3029b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3190,7 +3190,7 @@ static int gfx_v6_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int gfx_v6_0_soft_reset(void *handle)
+static int gfx_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 6fa6114e094d..990e7de8da25 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4540,11 +4540,11 @@ static int gfx_v7_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int gfx_v7_0_soft_reset(void *handle)
+static int gfx_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* GRBM_STATUS */
 	tmp = RREG32(mmGRBM_STATUS);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 9a15bf5e6b93..0b72dc3062b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5024,9 +5024,9 @@ static int gfx_v8_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gfx_v8_0_soft_reset(void *handle)
+static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
 	u32 tmp;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d7ef05cdb72e..3e07976d371b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4106,11 +4106,11 @@ static int gfx_v9_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int gfx_v9_0_soft_reset(void *handle)
+static int gfx_v9_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 grbm_soft_reset = 0;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* GRBM_STATUS */
 	tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 27f331e2cdd9..81bd4ca4fba5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2423,11 +2423,11 @@ static int gfx_v9_4_3_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int gfx_v9_4_3_soft_reset(void *handle)
+static int gfx_v9_4_3_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 grbm_soft_reset = 0;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* GRBM_STATUS */
 	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_STATUS);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ff7596b5b306..8e51c7e4e8c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1088,7 +1088,7 @@ static int gmc_v10_0_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int gmc_v10_0_soft_reset(void *handle)
+static int gmc_v10_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 3241effb67fa..2fc69cdf8843 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -996,7 +996,7 @@ static int gmc_v11_0_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int gmc_v11_0_soft_reset(void *handle)
+static int gmc_v11_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 745010a24a2f..3cbb5824a378 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -980,7 +980,7 @@ static int gmc_v12_0_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int gmc_v12_0_soft_reset(void *handle)
+static int gmc_v12_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index e8566a53838a..82a097d32f28 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -973,9 +973,9 @@ static int gmc_v6_0_wait_for_idle(void *handle)
 
 }
 
-static int gmc_v6_0_soft_reset(void *handle)
+static int gmc_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset = 0;
 	u32 tmp = RREG32(mmSRBM_STATUS);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 77e09503e2b9..ad9bad951cc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1167,9 +1167,9 @@ static int gmc_v7_0_wait_for_idle(void *handle)
 
 }
 
-static int gmc_v7_0_soft_reset(void *handle)
+static int gmc_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset = 0;
 	u32 tmp = RREG32(mmSRBM_STATUS);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index f579c710d3d1..7ffb33dd54ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1330,9 +1330,9 @@ static int gmc_v8_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v8_0_soft_reset(void *handle)
+static int gmc_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset;
 
 	if (!adev->gmc.srbm_soft_reset)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 24a269c2e493..1d0eb31d7b72 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2461,7 +2461,7 @@ static int gmc_v9_0_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int gmc_v9_0_soft_reset(void *handle)
+static int gmc_v9_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX for emulation.*/
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index 6e611aedf519..6210fa17eeca 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -368,10 +368,10 @@ static int iceland_ih_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int iceland_ih_soft_reset(void *handle)
+static int iceland_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 srbm_soft_reset = 0;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 tmp = RREG32(mmSRBM_STATUS);
 
 	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index e2bf3b58fe07..80c021598b78 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -670,7 +670,7 @@ static int ih_v6_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int ih_v6_0_soft_reset(void *handle)
+static int ih_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index a401324d8da0..be700137d5a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -649,7 +649,7 @@ static int ih_v6_1_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int ih_v6_1_soft_reset(void *handle)
+static int ih_v6_1_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 646e007ccc2c..a86d12e3ab24 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -639,7 +639,7 @@ static int ih_v7_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int ih_v7_0_soft_reset(void *handle)
+static int ih_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 93bf5e58cb49..85361dcb4b4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -644,7 +644,7 @@ static int navi10_ih_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int navi10_ih_soft_reset(void *handle)
+static int navi10_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 8966a8b7c4ee..7fdd5739b608 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1053,7 +1053,7 @@ static int nv_common_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int nv_common_soft_reset(void *handle)
+static int nv_common_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 12add2483250..a77977478ebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -944,10 +944,10 @@ static int sdma_v2_4_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v2_4_soft_reset(void *handle)
+static int sdma_v2_4_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	u32 srbm_soft_reset = 0;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 tmp = RREG32(mmSRBM_STATUS2);
 
 	if (tmp & SRBM_STATUS2__SDMA_BUSY_MASK) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index e7f4f7138df0..3e702853e0ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1290,9 +1290,9 @@ static int sdma_v3_0_post_soft_reset(void *handle)
 	return 0;
 }
 
-static int sdma_v3_0_soft_reset(void *handle)
+static int sdma_v3_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset = 0;
 	u32 tmp;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index ae5abb9bfcb4..10887eeb50af 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2049,7 +2049,7 @@ static int sdma_v4_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v4_0_soft_reset(void *handle)
+static int sdma_v4_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 5d5b8d539085..a8c5e30c83c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1559,7 +1559,7 @@ static int sdma_v4_4_2_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v4_4_2_soft_reset(void *handle)
+static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index ab230b3dfd9f..c67ccb541127 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1548,7 +1548,7 @@ static int sdma_v5_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v5_0_soft_reset(void *handle)
+static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index ddbb26f4f400..2b310576e59c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -761,9 +761,9 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int sdma_v5_2_soft_reset(void *handle)
+static int sdma_v5_2_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 grbm_soft_reset;
 	u32 tmp;
 	int i;
@@ -823,7 +823,7 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 			msleep(1000);
 	}
 
-	sdma_v5_2_soft_reset(adev);
+	sdma_v5_2_soft_reset(&adev->ip_blocks[AMD_IP_BLOCK_TYPE_SDMA]);
 	/* unhalt the MEs */
 	sdma_v5_2_enable(adev, true);
 	/* enable sdma ring preemption */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index edf8f23a0211..f18e3a40ceeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -755,9 +755,9 @@ static int sdma_v6_0_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int sdma_v6_0_soft_reset(void *handle)
+static int sdma_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 tmp;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 691870eca6d6..670529e16289 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -747,9 +747,9 @@ static int sdma_v7_0_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int sdma_v7_0_soft_reset(void *handle)
+static int sdma_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 tmp;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index b312c4cbcd98..096cf2deeb40 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2674,7 +2674,7 @@ static int si_common_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int si_common_soft_reset(void *handle)
+static int si_common_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 1e9669a7c7dd..93f80ab50626 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -571,7 +571,7 @@ static int si_dma_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int si_dma_soft_reset(void *handle)
+static int si_dma_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	DRM_INFO("si_dma_soft_reset --- not implemented !!!!!!!\n");
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index c8e664f27df1..089921417ec5 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -240,9 +240,9 @@ static int si_ih_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int si_ih_soft_reset(void *handle)
+static int si_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	u32 srbm_soft_reset = 0;
 	u32 tmp = RREG32(SRBM_STATUS);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 62b7c1aa1f66..2f9f7e3fa833 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1346,7 +1346,7 @@ static int soc15_common_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int soc15_common_soft_reset(void *handle)
+static int soc15_common_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 4ed3b821bf79..5946911a4191 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -939,7 +939,7 @@ static int soc21_common_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int soc21_common_soft_reset(void *handle)
+static int soc21_common_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 83714f409373..64d2f8ce548d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -536,7 +536,7 @@ static int soc24_common_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int soc24_common_soft_reset(void *handle)
+static int soc24_common_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index 7cdf6a10607f..59f167166f83 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -425,9 +425,9 @@ static int tonga_ih_post_soft_reset(void *handle)
 	return tonga_ih_hw_init(adev);
 }
 
-static int tonga_ih_soft_reset(void *handle)
+static int tonga_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset;
 
 	if (!adev->irq.srbm_soft_reset)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index c33b86f24a17..0fd864247a48 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -778,9 +778,9 @@ static int uvd_v3_1_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int uvd_v3_1_soft_reset(void *handle)
+static int uvd_v3_1_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	uvd_v3_1_stop(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index de9e6222d495..853af18fcc43 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -678,9 +678,9 @@ static int uvd_v4_2_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int uvd_v4_2_soft_reset(void *handle)
+static int uvd_v4_2_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	uvd_v4_2_stop(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index f9bdbd148383..7b6128660294 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -600,9 +600,9 @@ static int uvd_v5_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int uvd_v5_0_soft_reset(void *handle)
+static int uvd_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	uvd_v5_0_stop(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 9e6043f57805..1046ab677ea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1195,9 +1195,9 @@ static int uvd_v6_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int uvd_v6_0_soft_reset(void *handle)
+static int uvd_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset;
 
 	if (!adev->uvd.inst->srbm_soft_reset)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index eebdf7b2d633..d4342556c09c 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1517,9 +1517,9 @@ static int uvd_v7_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int uvd_v7_0_soft_reset(void *handle)
+static int uvd_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset;
 
 	if (!adev->uvd.inst[ring->me].srbm_soft_reset)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index cb77a9c12693..71ca9966711e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -532,9 +532,9 @@ static int vce_v2_0_resume(void *handle)
 	return vce_v2_0_hw_init(adev);
 }
 
-static int vce_v2_0_soft_reset(void *handle)
+static int vce_v2_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	WREG32_FIELD(SRBM_SOFT_RESET, SOFT_RESET_VCE, 1);
 	mdelay(5);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6b7916c72193..34d7c2e4da8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -668,9 +668,9 @@ static bool vce_v3_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	}
 }
 
-static int vce_v3_0_soft_reset(void *handle)
+static int vce_v3_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset;
 
 	if (!adev->vce.srbm_soft_reset)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 83b7ce5e764f..b5399ecb6bb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -762,9 +762,9 @@ static bool vce_v4_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	}
 }
 
-static int vce_v4_0_soft_reset(void *handle)
+static int vce_v4_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset;
 
 	if (!adev->vce.srbm_soft_reset)
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 07c229d2c4e1..2d80aafcdbc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -576,7 +576,7 @@ static int vega10_ih_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int vega10_ih_soft_reset(void *handle)
+static int vega10_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 89880d915fe4..c2461211aefb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -642,7 +642,7 @@ static int vega20_ih_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int vega20_ih_soft_reset(void *handle)
+static int vega20_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a13f8edfd001..e832dd50a628 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1755,7 +1755,7 @@ static int vi_common_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int vi_common_soft_reset(void *handle)
+static int vi_common_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3fc7ec283d9e..87429766c70f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -331,7 +331,7 @@ static bool dm_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
-static int dm_soft_reset(void *handle)
+static int dm_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
 	return 0;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 15cd8288b9ac..97a1726cd968 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -394,7 +394,7 @@ struct amd_ip_funcs {
 	int (*wait_for_idle)(void *handle);
 	bool (*check_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*pre_soft_reset)(struct amdgpu_ip_block *ip_block);
-	int (*soft_reset)(void *handle);
+	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*post_soft_reset)(void *handle);
 	int (*set_clockgating_state)(void *handle,
 				     enum amd_clockgating_state state);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 69aa62460a8d..92c7e45c64b2 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3105,7 +3105,7 @@ static int kv_dpm_wait_for_idle(void *handle)
 }
 
 
-static int kv_dpm_soft_reset(void *handle)
+static int kv_dpm_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 415c65148b46..157777db75c7 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7849,7 +7849,7 @@ static int si_dpm_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int si_dpm_soft_reset(void *handle)
+static int si_dpm_soft_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 5c109be6bcbd..334f03c04257 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -250,7 +250,7 @@ static int pp_wait_for_idle(void *handle)
 	return 0;
 }
 
-static int pp_sw_reset(void *handle)
+static int pp_sw_reset(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
-- 
2.34.1

