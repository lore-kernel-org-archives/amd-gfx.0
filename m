From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] gpu: drm: amd: amdgpu: remove dead code
Date: Mon, 8 May 2017 12:01:09 -0500
Message-ID: <20170508170109.GA11477@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Tom St Denis <tom.stdenis@amd.com>, Monk Liu <Monk.Liu@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Peter Senna Tschudin <peter.senna@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Local variable use_doorbell is assigned to a constant value and it is never
updated again. Remove this variable and the dead code it guards.

Addresses-Coverity-ID: 1401828
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 53 +++++++++++++----------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 67afc90..e824c2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4991,7 +4991,6 @@ static int gfx_v8_0_cp_compute_resume(struct amdgpu_device *adev)
 {
 	int r, i, j;
 	u32 tmp;
-	bool use_doorbell = true;
 	u64 hqd_gpu_addr;
 	u64 mqd_gpu_addr;
 	u64 eop_gpu_addr;
@@ -5079,11 +5078,7 @@ static int gfx_v8_0_cp_compute_resume(struct amdgpu_device *adev)
 
 		/* enable doorbell? */
 		tmp = RREG32(mmCP_HQD_PQ_DOORBELL_CONTROL);
-		if (use_doorbell) {
-			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-		} else {
-			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 0);
-		}
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
 		WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, tmp);
 		mqd->cp_hqd_pq_doorbell_control = tmp;
 
@@ -5157,29 +5152,23 @@ static int gfx_v8_0_cp_compute_resume(struct amdgpu_device *adev)
 		       mqd->cp_hqd_pq_wptr_poll_addr_hi);
 
 		/* enable the doorbell if requested */
-		if (use_doorbell) {
-			if ((adev->asic_type == CHIP_CARRIZO) ||
-			    (adev->asic_type == CHIP_FIJI) ||
-			    (adev->asic_type == CHIP_STONEY) ||
-			    (adev->asic_type == CHIP_POLARIS11) ||
-			    (adev->asic_type == CHIP_POLARIS10) ||
-			    (adev->asic_type == CHIP_POLARIS12)) {
-				WREG32(mmCP_MEC_DOORBELL_RANGE_LOWER,
-				       AMDGPU_DOORBELL_KIQ << 2);
-				WREG32(mmCP_MEC_DOORBELL_RANGE_UPPER,
-				       AMDGPU_DOORBELL_MEC_RING7 << 2);
-			}
-			tmp = RREG32(mmCP_HQD_PQ_DOORBELL_CONTROL);
-			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
-					    DOORBELL_OFFSET, ring->doorbell_index);
-			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_SOURCE, 0);
-			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_HIT, 0);
-			mqd->cp_hqd_pq_doorbell_control = tmp;
-
-		} else {
-			mqd->cp_hqd_pq_doorbell_control = 0;
+		if ((adev->asic_type == CHIP_CARRIZO) ||
+		    (adev->asic_type == CHIP_FIJI) ||
+		    (adev->asic_type == CHIP_STONEY) ||
+		    (adev->asic_type == CHIP_POLARIS11) ||
+		    (adev->asic_type == CHIP_POLARIS10) ||
+		    (adev->asic_type == CHIP_POLARIS12)) {
+			WREG32(mmCP_MEC_DOORBELL_RANGE_LOWER, AMDGPU_DOORBELL_KIQ << 2);
+			WREG32(mmCP_MEC_DOORBELL_RANGE_UPPER, AMDGPU_DOORBELL_MEC_RING7 << 2);
 		}
+		tmp = RREG32(mmCP_HQD_PQ_DOORBELL_CONTROL);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				   DOORBELL_OFFSET, ring->doorbell_index);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_SOURCE, 0);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_HIT, 0);
+		mqd->cp_hqd_pq_doorbell_control = tmp;
+
 		WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL,
 		       mqd->cp_hqd_pq_doorbell_control);
 
@@ -5217,11 +5206,9 @@ static int gfx_v8_0_cp_compute_resume(struct amdgpu_device *adev)
 		amdgpu_bo_unreserve(ring->mqd_obj);
 	}
 
-	if (use_doorbell) {
-		tmp = RREG32(mmCP_PQ_STATUS);
-		tmp = REG_SET_FIELD(tmp, CP_PQ_STATUS, DOORBELL_ENABLE, 1);
-		WREG32(mmCP_PQ_STATUS, tmp);
-	}
+	tmp = RREG32(mmCP_PQ_STATUS);
+	tmp = REG_SET_FIELD(tmp, CP_PQ_STATUS, DOORBELL_ENABLE, 1);
+	WREG32(mmCP_PQ_STATUS, tmp);
 
 	gfx_v8_0_cp_compute_enable(adev, true);
 
-- 
2.5.0
