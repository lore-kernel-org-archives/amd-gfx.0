Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3C3CC6B16
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E0710F630;
	Tue, 13 Oct 2026 08:49:46 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C8B10F62A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:49:44 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69D8ndaN972587; Tue, 13 Oct 2026 14:19:39 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69D8ndWk972586;
 Tue, 13 Oct 2026 14:19:39 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 12/14] drm/amdgpu: remove the unused ring parameter from
 update_spm_vmid()
Date: Tue, 13 Oct 2026 14:19:35 +0530
Message-Id: <20261013084937.972181-12-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013084937.972181-1-sunil.khatri@amd.com>
References: <20261013084937.972181-1-sunil.khatri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Every remaining caller of adev->gfx.rlc.funcs->update_spm_vmid() passes
NULL for ring, since the only callers that ever passed a real ring
were removed earlier in this series. Drop the parameter, and the
dead SR-IOV one-VF ring-replay code in gfx_v11_0/gfx_v12_0/gfx_v12_1
that only ran when ring was non-NULL.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 12 ++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 11 +----------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 15 +++------------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  4 ++--
 9 files changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 2ae2c1d0f702b..e38a8ea02c520 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -292,7 +292,7 @@ struct amdgpu_rlc_funcs {
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
 	void (*update_spm_vmid)(struct amdgpu_device *adev, int xcc_id,
-			struct amdgpu_ring *ring, unsigned vmid);
+			unsigned int vmid);
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index fce651d9bc613..b6f61f4a08e5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8320,7 +8320,7 @@ static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 }
 
 static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		struct amdgpu_ring *ring, unsigned int vmid)
+		unsigned int vmid)
 {
 	amdgpu_gfx_off_ctrl(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1f2ad47adb9fe..315dfd806d56f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -944,7 +944,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
@@ -5748,7 +5748,7 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 }
 
 static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		struct amdgpu_ring *ring, unsigned vmid)
+		unsigned int vmid)
 {
 	u32 reg, pre_data, data;
 
@@ -5769,14 +5769,6 @@ static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
 			WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
 	}
 	amdgpu_gfx_off_ctrl(adev, true);
-
-	if (ring
-		&& amdgpu_sriov_is_pp_one_vf(adev)
-		&& (pre_data != data)
-		&& ((ring->funcs->type == AMDGPU_RING_TYPE_GFX)
-			|| (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
-		amdgpu_ring_emit_wreg(ring, reg, data);
-	}
 }
 
 static const struct amdgpu_rlc_funcs gfx_v11_0_rlc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 72ceb113689e8..d82e7f115b7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -773,7 +773,7 @@ static int gfx_v12_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
@@ -4075,7 +4075,6 @@ static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
 
 static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
 				      int xcc_id,
-				      struct amdgpu_ring *ring,
 				      unsigned vmid)
 {
 	u32 reg, data;
@@ -4093,14 +4092,6 @@ static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
 		WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
 	else
 		WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
-
-	if (ring
-	    && amdgpu_sriov_is_pp_one_vf(adev)
-	    && ((ring->funcs->type == AMDGPU_RING_TYPE_GFX)
-		|| (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
-		uint32_t reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
-		amdgpu_ring_emit_wreg(ring, reg, data);
-	}
 }
 
 static const struct amdgpu_rlc_funcs gfx_v12_0_rlc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index b44f5ec68714d..147bed75261c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -214,7 +214,7 @@ static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
 static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
 	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
 static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-				      struct amdgpu_ring *ring, unsigned vmid);
+				      unsigned int vmid);
 
 static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				   int mem_space, int opt, uint32_t addr0,
@@ -1861,7 +1861,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
 	int r;
 
 	/* init spm vmid with 0xf */
-	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.spm_vmid);
+	gfx_v12_1_update_spm_vmid(adev, xcc_id, adev->vm_manager.spm_vmid);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		gfx_v12_1_xcc_init_csb(adev, xcc_id);
@@ -2918,8 +2918,7 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
 
 static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev,
 				      int xcc_id,
-				      struct amdgpu_ring *ring,
-				      unsigned vmid)
+				      unsigned int vmid)
 {
 	u32 reg, data;
 
@@ -2936,14 +2935,6 @@ static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev,
 		WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
 	else
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
-
-	if (ring
-	    && amdgpu_sriov_is_pp_one_vf(adev)
-	    && ((ring->funcs->type == AMDGPU_RING_TYPE_GFX)
-		|| (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
-		uint32_t reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);
-		amdgpu_ring_emit_wreg(ring, reg, data);
-	}
 }
 
 static const struct amdgpu_rlc_funcs gfx_v12_1_rlc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 91ce21425126f..dd00be109d7cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3252,7 +3252,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
@@ -3479,7 +3479,7 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *adev)
 }
 
 static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		struct amdgpu_ring *ring, unsigned vmid)
+		unsigned int vmid)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 479480e39fe47..c9268cc5715b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1274,7 +1274,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
@@ -5491,7 +5491,7 @@ static void gfx_v8_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 }
 
 static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		struct amdgpu_ring *ring, unsigned vmid)
+		unsigned int vmid)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 8afcdb54a0f56..75d1bbdb421ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5225,7 +5225,7 @@ static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 }
 
 static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		struct amdgpu_ring *ring, unsigned int vmid)
+		unsigned int vmid)
 {
 	amdgpu_gfx_off_ctrl(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 1d1973fd8f677..0ffdef21df0ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1395,7 +1395,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
@@ -1607,7 +1607,7 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
 }
 
 static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
-					      int inst, struct amdgpu_ring *ring, unsigned int vmid)
+					      int inst, unsigned int vmid)
 {
 	u32 reg, pre_data, data;
 
-- 
2.34.1

