From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amd/display: fix memory leaks on error exit return
Date: Wed, 22 Nov 2017 16:47:35 +0000
Message-ID: <20171122164735.1497-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, Tony Cheng <tony.cheng@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

Currently in the case where some of the allocations fail for dce110_tgv,
dce110_xfmv, dce110_miv or dce110_oppv then the exit return path ends
up leaking allocated objects. Fix this by kfree'ing them before returning.
Also re-work the comparison of the null pointers to use the !ptr idiom.

Detected by CoverityScan, CID#1460246, 1460325, 1460324, 1460392
("Resource Leak")

Fixes: c4562236b3bc ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index db96d2b47ff1..61adb8174ce0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -1037,11 +1037,13 @@ static bool underlay_create(struct dc_context *ctx, struct resource_pool *pool)
 	struct dce110_opp *dce110_oppv = kzalloc(sizeof(*dce110_oppv),
 						 GFP_KERNEL);
 
-	if ((dce110_tgv == NULL) ||
-		(dce110_xfmv == NULL) ||
-		(dce110_miv == NULL) ||
-		(dce110_oppv == NULL))
-			return false;
+	if (!dce110_tgv || !dce110_xfmv || !dce110_miv || !dce110_oppv) {
+		kfree(dce110_tgv);
+		kfree(dce110_xfmv);
+		kfree(dce110_miv);
+		kfree(dce110_oppv);
+		return false;
+	}
 
 	dce110_opp_v_construct(dce110_oppv, ctx);
 
-- 
2.14.1
