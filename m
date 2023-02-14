Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED08C6379F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 12:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8249A10E8AD;
	Tue, 14 Feb 2023 12:14:19 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F6710E8AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kbn5zqUciJHutZ48knDotdoIrC0XOwEHbm7VZUjlILk=; b=H7kmNe+F0aDgHCuQpv3sG2NT2m
 E8cL0dUlEYUxaTbZzFOC4AwzTVUE2eExwhJBCRa8+Rcb8TvhDyfZDmClVz0mDRXQhWtY8JaN4U6gS
 SYxqc0HNjwknIGAf3Fu9+0X8mNT3KiJRovIIryVMpU678y58YO6j9BEm1XLuw2DZTOT/nLQ4P8b39
 sfK2y3JEDEXsfzycG9EDEHftD0tnp7X1mesrF3p4hCTXxt5XbepCn4ir5SQuOgxbziezEH1ybw7EA
 apL1dKad5xKqMG13IKiycCrlg/i1WYQsior9V5OCve6hWCg2rU1MQ8XyKUiFGaj4TZJc1+gW6hcKl
 e3cYrSRg==;
Received: from [38.44.66.31] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pRuCK-0022pF-W5; Tue, 14 Feb 2023 13:14:13 +0100
From: Melissa Wen <mwen@igalia.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amd/display: remove unused _calculate_degamma_curve
 function
Date: Tue, 14 Feb 2023 11:14:06 -0100
Message-Id: <20230214121406.97750-7-mwen@igalia.com>
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

We don't use this function anywhere, therefore, remove it.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/modules/color/color_gamma.c   | 86 -------------------
 .../amd/display/modules/color/color_gamma.h   |  3 -
 2 files changed, 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 6e606b11286a..67a062af3ab0 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -2217,89 +2217,3 @@ bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
 rgb_user_alloc_fail:
 	return ret;
 }
-
-bool  mod_color_calculate_degamma_curve(enum dc_transfer_func_predefined trans,
-				struct dc_transfer_func_distributed_points *points)
-{
-	uint32_t i;
-	bool ret = false;
-	struct pwl_float_data_ex *rgb_degamma = NULL;
-
-	if (trans == TRANSFER_FUNCTION_UNITY ||
-		trans == TRANSFER_FUNCTION_LINEAR) {
-
-		for (i = 0; i <= MAX_HW_POINTS ; i++) {
-			points->red[i]    = coordinates_x[i].x;
-			points->green[i]  = coordinates_x[i].x;
-			points->blue[i]   = coordinates_x[i].x;
-		}
-		ret = true;
-	} else if (trans == TRANSFER_FUNCTION_PQ) {
-		rgb_degamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
-				       sizeof(*rgb_degamma),
-				       GFP_KERNEL);
-		if (!rgb_degamma)
-			goto rgb_degamma_alloc_fail;
-
-
-		build_de_pq(rgb_degamma,
-				MAX_HW_POINTS,
-				coordinates_x);
-		for (i = 0; i <= MAX_HW_POINTS ; i++) {
-			points->red[i]    = rgb_degamma[i].r;
-			points->green[i]  = rgb_degamma[i].g;
-			points->blue[i]   = rgb_degamma[i].b;
-		}
-		ret = true;
-
-		kvfree(rgb_degamma);
-	} else if (trans == TRANSFER_FUNCTION_SRGB ||
-		trans == TRANSFER_FUNCTION_BT709 ||
-		trans == TRANSFER_FUNCTION_GAMMA22 ||
-		trans == TRANSFER_FUNCTION_GAMMA24 ||
-		trans == TRANSFER_FUNCTION_GAMMA26) {
-		rgb_degamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
-				       sizeof(*rgb_degamma),
-				       GFP_KERNEL);
-		if (!rgb_degamma)
-			goto rgb_degamma_alloc_fail;
-
-		build_degamma(rgb_degamma,
-				MAX_HW_POINTS,
-				coordinates_x,
-				trans);
-		for (i = 0; i <= MAX_HW_POINTS ; i++) {
-			points->red[i]    = rgb_degamma[i].r;
-			points->green[i]  = rgb_degamma[i].g;
-			points->blue[i]   = rgb_degamma[i].b;
-		}
-		ret = true;
-
-		kvfree(rgb_degamma);
-	} else if (trans == TRANSFER_FUNCTION_HLG) {
-		rgb_degamma = kvcalloc(MAX_HW_POINTS + _EXTRA_POINTS,
-				       sizeof(*rgb_degamma),
-				       GFP_KERNEL);
-		if (!rgb_degamma)
-			goto rgb_degamma_alloc_fail;
-
-		build_hlg_degamma(rgb_degamma,
-				MAX_HW_POINTS,
-				coordinates_x,
-				80, 1000);
-		for (i = 0; i <= MAX_HW_POINTS ; i++) {
-			points->red[i]    = rgb_degamma[i].r;
-			points->green[i]  = rgb_degamma[i].g;
-			points->blue[i]   = rgb_degamma[i].b;
-		}
-		ret = true;
-		kvfree(rgb_degamma);
-	}
-	points->end_exponent = 0;
-	points->x_point_at_y1_red = 1;
-	points->x_point_at_y1_green = 1;
-	points->x_point_at_y1_blue = 1;
-
-rgb_degamma_alloc_fail:
-	return ret;
-}
diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.h b/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
index 2893abf48208..ee5c466613de 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
@@ -115,9 +115,6 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 		struct dc_transfer_func *output_tf,
 		const struct dc_gamma *ramp, bool mapUserRamp);
 
-bool mod_color_calculate_degamma_curve(enum dc_transfer_func_predefined trans,
-				struct dc_transfer_func_distributed_points *points);
-
 bool calculate_user_regamma_coeff(struct dc_transfer_func *output_tf,
 		const struct regamma_lut *regamma,
 		struct calculate_buffer *cal_buffer,
-- 
2.39.0

