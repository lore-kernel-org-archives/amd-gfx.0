Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DFFECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 16:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5888810E6FC;
	Tue,  6 Sep 2022 16:47:17 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2249E10E033
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xgwtvvviprtaksUf4ZiYT8wfZGRHUxnmLk0kheaSZvU=; b=cqDPsEfynQBKZ8k9EYJ6lW+jVO
 orfLQbgF3+/zPwm/CwSbIV04LqGTLrmb15SzZoIfCrxntysvJXbY75ujFgaheyZS/U11yuVKfltJM
 YpqrnlIaRzDIEf+X6IHRC1/M+mXZWNgE0tffDsypuL/NaNXVlGrD3EpgJDyBYlbpz9H5b0pVikaVq
 mF93ZYepChtQvkv38Ew2+9pvwASGqqRrt2m9EtdCNOXUosna9wA51oPEsI2+0nD6XQSw3sy0+9iwK
 WzKUmLztkIN0Kph7DqbeY/5sIChupFd4eeaRbRh4jtCYdyb1zRe6LYk37163xR1ADdBSm2TuJ6js5
 wXYzyZZg==;
Received: from [38.44.74.92] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oVbjA-00CALM-C7; Tue, 06 Sep 2022 18:47:08 +0200
From: Melissa Wen <mwen@igalia.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com
Subject: [RFC PATCH v2 7/9] drm/amd/display: add user shaper LUT support to
 amdgpu_dm color pipeline
Date: Tue,  6 Sep 2022 15:46:26 -0100
Message-Id: <20220906164628.2361811-8-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906164628.2361811-1-mwen@igalia.com>
References: <20220906164628.2361811-1-mwen@igalia.com>
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
Cc: amd-gfx@lists.freedesktop.org, nikola.cornij@amd.com, kernel-dev@igalia.com,
 bhawanpreet.lakha@amd.com, nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now, we can use shaper LUT to delinearize and/or normalize the color
space for a more efficient 3D LUT support (so far, only for DRM atomic
color mgmt). If a degamma 1D LUT is passed to linearize the color space,
a custom shaper 1D LUT can be used before applying 3D LUT.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 105 +++++++++++++++---
 1 file changed, 87 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 9777252191b1..b590fc83a88c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -352,18 +352,64 @@ static int __set_input_tf(struct dc_transfer_func *func,
 	return res ? 0 : -ENOMEM;
 }
 
-static int amdgpu_dm_atomic_shaper_lut(struct dc_stream_state *stream,
-				       struct dc_transfer_func *func_shaper_new)
+static int __set_func_shaper(struct dc_transfer_func *shaper_func,
+			     const struct drm_color_lut *lut, uint32_t lut_size)
 {
+	struct dc_gamma *gamma = NULL;
+	struct calculate_buffer cal_buffer = {0};
+	bool res;
+
+	ASSERT(lut && lut_size == MAX_COLOR_LUT_ENTRIES);
+
+	cal_buffer.buffer_index = -1;
+
+	gamma = dc_create_gamma();
+	if (!gamma)
+		return -ENOMEM;
+
+	gamma->num_entries = lut_size;
+	__drm_lut_to_dc_gamma(lut, gamma, false);
+
+	/*
+	 * Color module doesn't like calculating gamma params
+	 * on top of a linear input. But degamma params can be used
+	 * instead to simulate this.
+	 */
+	gamma->type = GAMMA_CUSTOM;
+	res = mod_color_calculate_degamma_params(NULL, shaper_func, gamma, true);
+
+	dc_gamma_release(&gamma);
+
+	return res ? 0 : -ENOMEM;
+}
 
-	/* We don't get DRM shaper LUT yet. We assume the input color space is
-	 * already delinearized, so we don't need a shaper LUT and we can just
-	 * BYPASS.  However, checking dcn30_set_mpc_shaper_3dlut() it seems
+static int amdgpu_dm_atomic_shaper_lut(struct dc_stream_state *stream,
+				       struct dc_transfer_func *func_shaper_new,
+				       const struct drm_color_lut *shaper_lut,
+				       uint32_t shaper_size)
+{
+	/* If no DRM shaper LUT, we assume the input color space is already
+	 * delinearized, so we don't need a shaper LUT and we can just BYPASS
+	 * However, checking dcn30_set_mpc_shaper_3dlut() it seems
 	 * that setting shaper LUT to BYPASS is not currently supported in the
 	 * DC level, since shaper LUT programming just fails without params.
 	 */
-	func_shaper_new->type = TF_TYPE_BYPASS;
-	func_shaper_new->tf = TRANSFER_FUNCTION_LINEAR;
+	if (!shaper_size) {
+		func_shaper_new->type = TF_TYPE_BYPASS;
+		func_shaper_new->tf = TRANSFER_FUNCTION_LINEAR;
+	} else {
+		int r;
+
+		/* If DRM shaper LUT is set, we follow the same behavior of the
+		 * atomic regamma and assume a linear base */
+		func_shaper_new->type = TF_TYPE_DISTRIBUTED_POINTS;
+		func_shaper_new->tf = TRANSFER_FUNCTION_LINEAR;
+
+		r = __set_func_shaper(func_shaper_new, shaper_lut,
+				shaper_size);
+		if (r)
+			return r;
+	}
 
 	stream->func_shaper = func_shaper_new;
 
@@ -427,12 +473,27 @@ static uint32_t amdgpu_dm_get_3dlut_size(uint32_t lut_size,
 int amdgpu_dm_verify_3dlut_size(const struct drm_crtc_state *crtc_state,
 				struct amdgpu_device *adev)
 {
-	const struct drm_color_lut *lut3d = NULL;
+	const struct drm_color_lut *shaper = NULL, *lut3d = NULL;
 	uint32_t exp_size, size;
 
+	/* shaper LUT is only available if 3D LUT color caps*/
+	exp_size = amdgpu_dm_get_3dlut_size(MAX_COLOR_LUT_ENTRIES, adev);
+
+	shaper = __extract_blob_lut(crtc_state->shaper_lut, &size);
+	if (shaper && size != exp_size) {
+		DRM_DEBUG_DRIVER(
+			"Invalid Shaper LUT size. Should be %u but got %u.\n",
+			exp_size, size);
+		return -EINVAL;
+	}
+
 	exp_size = amdgpu_dm_get_3dlut_size(MAX_COLOR_3DLUT_ENTRIES, adev);
 	lut3d = __extract_blob_lut(crtc_state->lut3d, &size);
 
+	/* shaper LUT implies 3D LUT. See dcn30_set_output_transfer_func() */
+	if (shaper && !lut3d)
+		DRM_DEBUG_DRIVER("Shaper LUT is set without 3D LUT.\n");
+
 	if (lut3d && size != exp_size) {
 		DRM_DEBUG_DRIVER("Invalid Gamma 3D LUT size. Should be %u but got %u.\n",
 				 exp_size, size);
@@ -444,6 +505,8 @@ int amdgpu_dm_verify_3dlut_size(const struct drm_crtc_state *crtc_state,
 
 static int amdgpu_dm_atomic_shaper_3dlut(struct dc *dc,
 					 struct dc_stream_state *stream,
+					 const struct drm_color_lut *drm_shaper_lut,
+					 uint32_t drm_shaper_size,
 					 const struct drm_color_lut *drm_lut3d,
 					 uint32_t drm_lut3d_size)
 {
@@ -451,7 +514,6 @@ static int amdgpu_dm_atomic_shaper_3dlut(struct dc *dc,
 	struct dc_transfer_func *shaper_old = (struct dc_transfer_func *) stream->func_shaper;
 	struct dc_3dlut *lut3d_new = NULL;
 	struct dc_transfer_func *shaper_new = NULL;
-	int r;
 
 	if (lut3d_old && shaper_old) {
 		if (!dc_acquire_release_mpc_3dlut(dc, false, stream,
@@ -466,15 +528,11 @@ static int amdgpu_dm_atomic_shaper_3dlut(struct dc *dc,
 		return -EFAULT;
 	}
 
-	r = amdgpu_dm_atomic_shaper_lut(stream, shaper_new);
-	if (r)
-		return r;
-
 	__drm_3dlut_to_dc_3dlut(drm_lut3d, drm_lut3d_size, lut3d_new);
 
 	stream->lut3d_func = lut3d_new;
 
-	return 0;
+	return amdgpu_dm_atomic_shaper_lut(stream, shaper_new, drm_shaper_lut, drm_shaper_size);
 }
 
 /**
@@ -542,10 +600,10 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 	bool has_rom = adev->asic_type <= CHIP_RAVEN;
 	struct drm_color_ctm *ctm = NULL;
 	const struct drm_color_lut *degamma_lut, *regamma_lut;
-	const struct drm_color_lut *lut3d;
+	const struct drm_color_lut *shaper_lut, *lut3d;
 	uint32_t degamma_size, regamma_size;
-	uint32_t lut3d_size;
-	bool has_regamma, has_degamma, has_lut3d;
+	uint32_t shaper_size, lut3d_size;
+	bool has_regamma, has_degamma, has_shaper_lut, has_lut3d;
 	bool is_legacy;
 	int r;
 
@@ -558,12 +616,16 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 		return r;
 
 	degamma_lut = __extract_blob_lut(crtc->base.degamma_lut, &degamma_size);
+	shaper_lut = __extract_blob_lut(crtc->base.shaper_lut, &shaper_size);
 	lut3d = __extract_blob_lut(crtc->base.lut3d, &lut3d_size);
 	regamma_lut = __extract_blob_lut(crtc->base.gamma_lut, &regamma_size);
 
 	has_degamma =
 		degamma_lut && !__is_lut_linear(degamma_lut, degamma_size);
 
+	has_shaper_lut =
+		shaper_lut && !__is_lut_linear(shaper_lut, shaper_size);
+
 	has_lut3d =
 		lut3d && !__is_lut_linear(lut3d, lut3d_size);
 
@@ -605,10 +667,17 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 			return r;
 	} else {
 		if (has_lut3d) {
+			/* enable 3D LUT only for DRM atomic regamma */
+			shaper_size = has_shaper_lut ? shaper_size : 0;
+
 			r = amdgpu_dm_atomic_shaper_3dlut(adev->dm.dc, stream,
+							  shaper_lut, shaper_size,
 							  lut3d, lut3d_size);
-			if (r)
+
+			if (r) {
+				DRM_DEBUG_DRIVER("Failed to set shaper and 3D LUT\n");
 				return r;
+			}
 		}
 		/* Note: OGAM is disabled if 3D LUT is successfully programmed.
 		 * For reference, see params and set_output_gamma in
-- 
2.35.1

