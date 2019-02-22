From: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: don't call dm_pp_ function from an fpu block
Date: Fri, 22 Feb 2019 10:39:06 -0500
Message-ID: <20190222153906.661-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: robdclark@gmail.com, Harry Wentland <harry.wentland@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Powerplay functions called from dm_pp_* functions tend to do a
mutex_lock which isn't safe to do inside a kernel_fpu_begin/end block as
those will disable/enable preemption.

Rearrange the dm_pp_get_clock_levels_by_type_with_voltage calls to make
sure they happen outside of kernel_fpu_begin/end.

Cc: stable@vger.kernel.org
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index 2a807b9f77f7..5955634f6e27 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -1348,12 +1348,12 @@ void dcn_bw_update_from_pplib(struct dc *dc)
 	struct dm_pp_clock_levels_with_voltage fclks = {0}, dcfclks = {0};
 	bool res;
 
-	kernel_fpu_begin();
-
 	/* TODO: This is not the proper way to obtain fabric_and_dram_bandwidth, should be min(fclk, memclk) */
 	res = dm_pp_get_clock_levels_by_type_with_voltage(
 			ctx, DM_PP_CLOCK_TYPE_FCLK, &fclks);
 
+	kernel_fpu_begin();
+
 	if (res)
 		res = verify_clock_values(&fclks);
 
@@ -1372,9 +1372,13 @@ void dcn_bw_update_from_pplib(struct dc *dc)
 	} else
 		BREAK_TO_DEBUGGER();
 
+	kernel_fpu_end();
+
 	res = dm_pp_get_clock_levels_by_type_with_voltage(
 			ctx, DM_PP_CLOCK_TYPE_DCFCLK, &dcfclks);
 
+	kernel_fpu_begin();
+
 	if (res)
 		res = verify_clock_values(&dcfclks);
 
-- 
2.19.1
