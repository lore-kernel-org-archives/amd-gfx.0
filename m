From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] gpu: drm: amd: amdgpu: remove dead code
Date: Mon, 8 May 2017 11:41:13 -0500
Message-ID: <20170508164113.GA9196@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Tom St Denis <tom.stdenis@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Monk Liu <Monk.Liu@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Peter Senna Tschudin <peter.senna@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Local variable use_doorbell is assigned to a constant value and it is never
updated again. Remove this variable and the dead code it guards.

Addresses-Coverity-ID: 1401837
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 1f93545..27ea28f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2936,7 +2936,6 @@ static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
 {
 	int r, i, j;
 	u32 tmp;
-	bool use_doorbell = true;
 	u64 hqd_gpu_addr;
 	u64 mqd_gpu_addr;
 	u64 eop_gpu_addr;
@@ -3034,10 +3033,7 @@ static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
 		/* enable doorbell? */
 		mqd->queue_state.cp_hqd_pq_doorbell_control =
 			RREG32(mmCP_HQD_PQ_DOORBELL_CONTROL);
-		if (use_doorbell)
-			mqd->queue_state.cp_hqd_pq_doorbell_control |= CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_EN_MASK;
-		else
-			mqd->queue_state.cp_hqd_pq_doorbell_control &= ~CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_EN_MASK;
+		mqd->queue_state.cp_hqd_pq_doorbell_control |= CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_EN_MASK;
 		WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL,
 		       mqd->queue_state.cp_hqd_pq_doorbell_control);
 
@@ -3116,23 +3112,19 @@ static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
 		       mqd->queue_state.cp_hqd_pq_rptr_report_addr_hi);
 
 		/* enable the doorbell if requested */
-		if (use_doorbell) {
-			mqd->queue_state.cp_hqd_pq_doorbell_control =
+		mqd->queue_state.cp_hqd_pq_doorbell_control =
 				RREG32(mmCP_HQD_PQ_DOORBELL_CONTROL);
-			mqd->queue_state.cp_hqd_pq_doorbell_control &=
+		mqd->queue_state.cp_hqd_pq_doorbell_control &=
 				~CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK;
-			mqd->queue_state.cp_hqd_pq_doorbell_control |=
+		mqd->queue_state.cp_hqd_pq_doorbell_control |=
 				(ring->doorbell_index <<
 				 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT);
-			mqd->queue_state.cp_hqd_pq_doorbell_control |=
+		mqd->queue_state.cp_hqd_pq_doorbell_control |=
 				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_EN_MASK;
-			mqd->queue_state.cp_hqd_pq_doorbell_control &=
+		mqd->queue_state.cp_hqd_pq_doorbell_control &=
 				~(CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_SOURCE_MASK |
 				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_HIT_MASK);
 
-		} else {
-			mqd->queue_state.cp_hqd_pq_doorbell_control = 0;
-		}
 		WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL,
 		       mqd->queue_state.cp_hqd_pq_doorbell_control);
 
-- 
2.5.0
