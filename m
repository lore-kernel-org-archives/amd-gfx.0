From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amd/amdgpu: enable GUI idle INT after enabling CGCG
Date: Mon, 28 Nov 2016 17:10:01 -0500
Message-ID: <1480371001-17318-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Arindam Nath <arindam.nath@amd.com>, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Arindam Nath <arindam.nath@amd.com>

GUI idle interrupts should be enabled only after we
have enabled coarse grain clock gating (CGCG). This
prevents GFX engine generating idle interrupt even
though CGCG is not completely enabled.

Most of the time this goes un-noticed, but on some
Stoney ASICs this results in GFX engine hang after
system resumes from suspend. The issue is not
particular to Stoney though and could have occured
on any ASIC. The patch fixes this issue.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Sunil Uttarwar <Sunil.Uttarwar1@amd.com>
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 33be2c1..4602757 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5919,29 +5919,24 @@ static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 	adev->gfx.rlc.funcs->enter_safe_mode(adev);
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
-		/* 1 enable cntx_empty_int_enable/cntx_busy_int_enable/
-		 * Cmp_busy/GFX_Idle interrupts
-		 */
-		gfx_v8_0_enable_gui_idle_interrupt(adev, true);
-
 		temp1 = data1 =	RREG32(mmRLC_CGTT_MGCG_OVERRIDE);
 		data1 &= ~RLC_CGTT_MGCG_OVERRIDE__CGCG_MASK;
 		if (temp1 != data1)
 			WREG32(mmRLC_CGTT_MGCG_OVERRIDE, data1);
 
-		/* 2 wait for RLC_SERDES_CU_MASTER & RLC_SERDES_NONCU_MASTER idle */
+		/* : wait for RLC_SERDES_CU_MASTER & RLC_SERDES_NONCU_MASTER idle */
 		gfx_v8_0_wait_for_rlc_serdes(adev);
 
-		/* 3 - clear cgcg override */
+		/* 2 - clear cgcg override */
 		gfx_v8_0_send_serdes_cmd(adev, BPM_REG_CGCG_OVERRIDE, CLE_BPM_SERDES_CMD);
 
 		/* wait for RLC_SERDES_CU_MASTER & RLC_SERDES_NONCU_MASTER idle */
 		gfx_v8_0_wait_for_rlc_serdes(adev);
 
-		/* 4 - write cmd to set CGLS */
+		/* 3 - write cmd to set CGLS */
 		gfx_v8_0_send_serdes_cmd(adev, BPM_REG_CGLS_EN, SET_BPM_SERDES_CMD);
 
-		/* 5 - enable cgcg */
+		/* 4 - enable cgcg */
 		data |= RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
 
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS) {
@@ -5959,6 +5954,11 @@ static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 
 		if (temp != data)
 			WREG32(mmRLC_CGCG_CGLS_CTRL, data);
+
+		/* 5 enable cntx_empty_int_enable/cntx_busy_int_enable/
+		 * Cmp_busy/GFX_Idle interrupts
+		 */
+		gfx_v8_0_enable_gui_idle_interrupt(adev, true);
 	} else {
 		/* disable cntx_empty_int_enable & GFX Idle interrupt */
 		gfx_v8_0_enable_gui_idle_interrupt(adev, false);
-- 
2.5.5
