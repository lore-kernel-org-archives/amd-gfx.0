From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] drm/amd/display: fix  possible condition with no effect (if
 == else)
Date: Sat, 25 May 2019 23:24:23 +0530
Message-ID: <20190525175423.GA27834@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Charlene Liu <charlene.liu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, Ken Chalmers <ken.chalmers@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

fix below warning reported by coccicheck

./drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c:1364:3-5: WARNING:
possible condition with no effect (if == else)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index f3aa7b5..0706ced 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -1361,13 +1361,7 @@ static void calculate_bandwidth(
 	/*if stutter and dram clock state change are gated before cursor then the cursor latency hiding does not limit stutter or dram clock state change*/
 	for (i = 0; i <= maximum_number_of_surfaces - 1; i++) {
 		if (data->enable[i]) {
-			if (dceip->graphics_lb_nodownscaling_multi_line_prefetching == 1) {
-				data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i], bw_mul(bw_frc_to_fixed(5, 10), data->total_dmifmc_urgent_latency));
-			}
-			else {
-				/*maximum_latency_hiding(i) = minimum_latency_hiding(i) + 1 / vsr(i) * h_total(i) / pixel_rate(i) + 0.5 * total_dmifmc_urgent_latency*/
-				data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i], bw_mul(bw_frc_to_fixed(5, 10), data->total_dmifmc_urgent_latency));
-			}
+			data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i], bw_mul(bw_frc_to_fixed(5, 10), data->total_dmifmc_urgent_latency));
 			data->maximum_latency_hiding_with_cursor[i] = bw_min2(data->maximum_latency_hiding[i], data->cursor_latency_hiding[i]);
 		}
 	}
-- 
2.7.4
