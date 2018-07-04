From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm/amd/display: Use 2-factor allocator calls
Date: Wed, 4 Jul 2018 10:27:30 -0700
Message-ID: <20180704172730.GA33562@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

As already done treewide, switch from open-coded multiplication to
2-factor allocation helper.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 98edaefa2b47..ee69c949bfbf 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1723,8 +1723,8 @@ bool  mod_color_calculate_curve(enum dc_transfer_func_predefined trans,
 		kvfree(rgb_regamma);
 	} else if (trans == TRANSFER_FUNCTION_HLG ||
 		trans == TRANSFER_FUNCTION_HLG12) {
-		rgb_regamma = kvzalloc(sizeof(*rgb_regamma) *
-				       (MAX_HW_POINTS + _EXTRA_POINTS),
+		rgb_regamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
+				       sizeof(*rgb_regamma),
 				       GFP_KERNEL);
 		if (!rgb_regamma)
 			goto rgb_regamma_alloc_fail;
@@ -1802,8 +1802,8 @@ bool  mod_color_calculate_degamma_curve(enum dc_transfer_func_predefined trans,
 		kvfree(rgb_degamma);
 	} else if (trans == TRANSFER_FUNCTION_HLG ||
 		trans == TRANSFER_FUNCTION_HLG12) {
-		rgb_degamma = kvzalloc(sizeof(*rgb_degamma) *
-				       (MAX_HW_POINTS + _EXTRA_POINTS),
+		rgb_degamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
+				       sizeof(*rgb_degamma),
 				       GFP_KERNEL);
 		if (!rgb_degamma)
 			goto rgb_degamma_alloc_fail;
-- 
2.17.1


-- 
Kees Cook
Pixel Security
