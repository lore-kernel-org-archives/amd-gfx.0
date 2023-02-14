Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0E8C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 12:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F5110E89D;
	Tue, 14 Feb 2023 12:14:14 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3DF510E89C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/2ulCQ8v6/h6UkeAAlSUubaVqet/QcXscPAsKdgYSx8=; b=JApFVGltSVB7rZ9V3uT3/yi9tB
 VJBxRF52kW5F8Qpu9ihf+/MbAp6cOSvXShdfNNbSzIYxsi5eyPFNW/dPGyhSKGGDMu/vx5zrFA7Qe
 5QWJXu5PknLm/RI7s55t3ZtDzUHAW7dZwOKYqwtRZOgFfH5n8Vz/TbvPuhRPbxLhu4ZIie0/0Iru7
 kl6DUONpSG6IlrJ1SFPXnAxXE/FBwuTeg/A3acKqf0weiN5reI+Z3nyOVhGNdF6dbclWkyNzcaIOl
 bjctXUeiml1NuS1Xe14MzDXRox3XXw5EC41eZfosFP0GN+cZqhH/SOd0Y64JHibPltlQB0Ixe7Zlc
 DJ59NleQ==;
Received: from [38.44.66.31] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pRuCI-0022pF-Ij; Tue, 14 Feb 2023 13:14:10 +0100
From: Melissa Wen <mwen@igalia.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amd/display: camel case cleanup in color_gamma file
Date: Tue, 14 Feb 2023 11:14:03 -0100
Message-Id: <20230214121406.97750-4-mwen@igalia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214121406.97750-1-mwen@igalia.com>
References: <20230214121406.97750-1-mwen@igalia.com>
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
Cc: sunpeng.li@amd.com, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 kernel-dev@igalia.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rename mapUserRamp to map_user_ramp and doClamping to do_clamping

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/modules/color/color_gamma.c   | 50 ++++++++++---------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index f6034213c700..fdb20dfc70c9 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1715,8 +1715,8 @@ static bool map_regamma_hw_to_x_user(
 	const struct pwl_float_data_ex *rgb_regamma,
 	uint32_t hw_points_num,
 	struct dc_transfer_func_distributed_points *tf_pts,
-	bool mapUserRamp,
-	bool doClamping)
+	bool map_user_ramp,
+	bool do_clamping)
 {
 	/* setup to spare calculated ideal regamma values */
 
@@ -1724,7 +1724,7 @@ static bool map_regamma_hw_to_x_user(
 	struct hw_x_point *coords = coords_x;
 	const struct pwl_float_data_ex *regamma = rgb_regamma;
 
-	if (ramp && mapUserRamp) {
+	if (ramp && map_user_ramp) {
 		copy_rgb_regamma_to_coordinates_x(coords,
 				hw_points_num,
 				rgb_regamma);
@@ -1744,7 +1744,7 @@ static bool map_regamma_hw_to_x_user(
 		}
 	}
 
-	if (doClamping) {
+	if (do_clamping) {
 		/* this should be named differently, all it does is clamp to 0-1 */
 		build_new_custom_resulted_curve(hw_points_num, tf_pts);
 	}
@@ -1875,7 +1875,7 @@ bool calculate_user_regamma_ramp(struct dc_transfer_func *output_tf,
 
 bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 		struct dc_transfer_func *input_tf,
-		const struct dc_gamma *ramp, bool mapUserRamp)
+		const struct dc_gamma *ramp, bool map_user_ramp)
 {
 	struct dc_transfer_func_distributed_points *tf_pts = &input_tf->tf_pts;
 	struct dividers dividers;
@@ -1891,12 +1891,12 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 		return false;
 
 	/* we can use hardcoded curve for plain SRGB TF
-	 * If linear, it's bypass if on user ramp
+	 * If linear, it's bypass if no user ramp
 	 */
 	if (input_tf->type == TF_TYPE_PREDEFINED) {
 		if ((input_tf->tf == TRANSFER_FUNCTION_SRGB ||
 				input_tf->tf == TRANSFER_FUNCTION_LINEAR) &&
-				!mapUserRamp)
+				!map_user_ramp)
 			return true;
 
 		if (dc_caps != NULL &&
@@ -1919,7 +1919,7 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 
 	input_tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 
-	if (mapUserRamp && ramp && ramp->type == GAMMA_RGB_256) {
+	if (map_user_ramp && ramp && ramp->type == GAMMA_RGB_256) {
 		rgb_user = kvcalloc(ramp->num_entries + _EXTRA_POINTS,
 				sizeof(*rgb_user),
 				GFP_KERNEL);
@@ -2007,7 +2007,7 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 		map_regamma_hw_to_x_user(ramp, coeff, rgb_user,
 				coordinates_x, axis_x, curve,
 				MAX_HW_POINTS, tf_pts,
-				mapUserRamp && ramp && ramp->type == GAMMA_RGB_256,
+				map_user_ramp && ramp && ramp->type == GAMMA_RGB_256,
 				true);
 	}
 
@@ -2112,9 +2112,11 @@ static bool calculate_curve(enum dc_transfer_func_predefined trans,
 }
 
 bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
-		const struct dc_gamma *ramp, bool mapUserRamp, bool canRomBeUsed,
-		const struct hdr_tm_params *fs_params,
-		struct calculate_buffer *cal_buffer)
+					const struct dc_gamma *ramp,
+					bool map_user_ramp,
+					bool can_rom_be_used,
+					const struct hdr_tm_params *fs_params,
+					struct calculate_buffer *cal_buffer)
 {
 	struct dc_transfer_func_distributed_points *tf_pts = &output_tf->tf_pts;
 	struct dividers dividers;
@@ -2124,26 +2126,26 @@ bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
 	struct gamma_pixel *axis_x = NULL;
 	struct pixel_gamma_point *coeff = NULL;
 	enum dc_transfer_func_predefined tf = TRANSFER_FUNCTION_SRGB;
-	bool doClamping = true;
+	bool do_clamping = true;
 	bool ret = false;
 
 	if (output_tf->type == TF_TYPE_BYPASS)
 		return false;
 
 	/* we can use hardcoded curve for plain SRGB TF */
-	if (output_tf->type == TF_TYPE_PREDEFINED && canRomBeUsed == true &&
+	if (output_tf->type == TF_TYPE_PREDEFINED && can_rom_be_used == true &&
 			output_tf->tf == TRANSFER_FUNCTION_SRGB) {
 		if (ramp == NULL)
 			return true;
 		if ((ramp->is_identity && ramp->type != GAMMA_CS_TFM_1D) ||
-				(!mapUserRamp && ramp->type == GAMMA_RGB_256))
+		    (!map_user_ramp && ramp->type == GAMMA_RGB_256))
 			return true;
 	}
 
 	output_tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 
 	if (ramp && ramp->type != GAMMA_CS_TFM_1D &&
-			(mapUserRamp || ramp->type != GAMMA_RGB_256)) {
+	    (map_user_ramp || ramp->type != GAMMA_RGB_256)) {
 		rgb_user = kvcalloc(ramp->num_entries + _EXTRA_POINTS,
 			    sizeof(*rgb_user),
 			    GFP_KERNEL);
@@ -2164,7 +2166,7 @@ bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
 				ramp->num_entries,
 				dividers);
 
-		if (ramp->type == GAMMA_RGB_256 && mapUserRamp)
+		if (ramp->type == GAMMA_RGB_256 && map_user_ramp)
 			scale_gamma(rgb_user, ramp, dividers);
 		else if (ramp->type == GAMMA_RGB_FLOAT_1024)
 			scale_gamma_dx(rgb_user, ramp, dividers);
@@ -2191,15 +2193,15 @@ bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
 			cal_buffer);
 
 	if (ret) {
-		doClamping = !(output_tf->tf == TRANSFER_FUNCTION_GAMMA22 &&
-			fs_params != NULL && fs_params->skip_tm == 0);
+		do_clamping = !(output_tf->tf == TRANSFER_FUNCTION_GAMMA22 &&
+				fs_params != NULL && fs_params->skip_tm == 0);
 
 		map_regamma_hw_to_x_user(ramp, coeff, rgb_user,
-				coordinates_x, axis_x, rgb_regamma,
-				MAX_HW_POINTS, tf_pts,
-				(mapUserRamp || (ramp && ramp->type != GAMMA_RGB_256)) &&
-				(ramp && ramp->type != GAMMA_CS_TFM_1D),
-				doClamping);
+					 coordinates_x, axis_x, rgb_regamma,
+					 MAX_HW_POINTS, tf_pts,
+					 (map_user_ramp || (ramp && ramp->type != GAMMA_RGB_256)) &&
+					 (ramp && ramp->type != GAMMA_CS_TFM_1D),
+					 do_clamping);
 
 		if (ramp && ramp->type == GAMMA_CS_TFM_1D)
 			apply_lut_1d(ramp, MAX_HW_POINTS, tf_pts);
-- 
2.39.0

