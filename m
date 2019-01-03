From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amd/display: Fix boolean expression in get_surf_rq_param
Date: Thu, 3 Jan 2019 13:48:45 -0600
Message-ID: <20190103194845.GA26175@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

Fix boolean expression by using logical AND operator '&&'
instead of bitwise operator '&'.

This issue was detected with the help of Coccinelle.

Fixes: 6d04ee9dc101 ("drm/amd/display: Restructuring and cleaning up DML")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index c2037daa8e66..d341b69fdc1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -881,7 +881,7 @@ static void get_surf_rq_param(
 	/* the dpte_group_bytes is reduced for the specific case of vertical
 	 * access of a tile surface that has dpte request of 8x1 ptes.
 	 */
-	if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) /*reduced, in this case, will have page fault within a group */
+	if (!surf_linear && (log2_dpte_req_height_ptes == 0) && surf_vert) /*reduced, in this case, will have page fault within a group */
 		rq_sizing_param->dpte_group_bytes = 512;
 	else
 		/*full size */
-- 
2.20.1
