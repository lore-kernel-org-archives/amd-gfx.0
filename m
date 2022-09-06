Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0740ECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 16:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC8910E033;
	Tue,  6 Sep 2022 16:47:14 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE69210E092
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 16:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EBVz9frfX12EQ4tma6Vf2nnUFM+LsQx8zZRVoL7xmeM=; b=dbx3JFqwDKnpaOlv9xTcgtpVZ0
 1zWEMahZJm1kRNq9jWHs4Cbwb7y4Pco+x0wNBQpL77Iw0S+H/EVrSBU126Zi590gai81XABZLW4fq
 K9SsidLH+U0bIOr3Da+IZtXWKt7XpxBAt7KWrm9vdja51vwL/uN8Xj1W/k5lkiOdukG4ASz4rJHxr
 tRBrlPs+g4LmsyyuQ6Ho4L3GcHeEdEg13ZWp6xU0/4LVGks2IfY8TB2cWddep3nVSt7UmJXMQ3jvK
 rTY38m6+N2T7pl2zI6d3PcFPVHYquigjPgTYc5pSjvCUsDNfJ5DYFNz1GjC3W5kkLreE3xRMZTzsU
 dWQpIjug==;
Received: from [38.44.74.92] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oVbj6-00CALM-5W; Tue, 06 Sep 2022 18:47:04 +0200
From: Melissa Wen <mwen@igalia.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com
Subject: [RFC PATCH v2 6/9] drm/amd/display: add user 3D LUT support to the
 amdgpu_dm color pipeline
Date: Tue,  6 Sep 2022 15:46:25 -0100
Message-Id: <20220906164628.2361811-7-mwen@igalia.com>
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

Map DRM 3D LUT in the atomic color mgmt pipeline to DC. 3D LUT works
better in a non-linear color space, therefore using a degamma to
linearize the input space may produce unexpected results. The next patch
introduces shaper LUT support that can be used to delinearize the color
space before applying 3D LUT conversion.

Note that there is no implicit sRGB degamma/regamma in the original
implementation for DRM atomic color mgmt. Atomic degamma/regamma 1D LUT
is applied considering a linear base.
For reference, see IGT test amdgpu/amd_color and commit
cf020d49b3c4 ("drm/amd/display: Rework CRTC color management")

dc_acquire_release_mpc_3dlut initializes the bits required to program
3DLUT in DC MPC hw block, that is applied by set_output_transfer_func().
But we should verify if the timing to acquire and release shaper and 3D
LUTs from the resource pool in this patch is correct.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 149 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  13 ++
 4 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dbe76b85552e..05d96978925c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9435,6 +9435,12 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 		}
 
+		ret = amdgpu_dm_verify_3dlut_size(new_crtc_state, adev);
+		if (ret) {
+			DRM_DEBUG_DRIVER("amdgpu_dm_verify_lut_sizes() failed\n");
+			goto fail;
+		}
+
 		if (!new_crtc_state->enable)
 			continue;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index b44faaad9b0b..435cf6b4efc1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -784,12 +784,17 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 void amdgpu_dm_trigger_timing_sync(struct drm_device *dev);
 
+/* 3D LUT max size is 17x17x17 */
+#define MAX_COLOR_3DLUT_ENTRIES 4913
+/* 1D LUT degamma, regamma and shaper*/
 #define MAX_COLOR_LUT_ENTRIES 4096
 /* Legacy gamm LUT users such as X doesn't like large LUT sizes */
 #define MAX_COLOR_LEGACY_LUT_ENTRIES 256
 
 void amdgpu_dm_init_color_mod(void);
 int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);
+int amdgpu_dm_verify_3dlut_size(const struct drm_crtc_state *crtc_state,
+				struct amdgpu_device *adev);
 int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
 int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 				      struct dc_plane_state *dc_plane_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 54d95745f0f0..9777252191b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -352,6 +352,131 @@ static int __set_input_tf(struct dc_transfer_func *func,
 	return res ? 0 : -ENOMEM;
 }
 
+static int amdgpu_dm_atomic_shaper_lut(struct dc_stream_state *stream,
+				       struct dc_transfer_func *func_shaper_new)
+{
+
+	/* We don't get DRM shaper LUT yet. We assume the input color space is
+	 * already delinearized, so we don't need a shaper LUT and we can just
+	 * BYPASS.  However, checking dcn30_set_mpc_shaper_3dlut() it seems
+	 * that setting shaper LUT to BYPASS is not currently supported in the
+	 * DC level, since shaper LUT programming just fails without params.
+	 */
+	func_shaper_new->type = TF_TYPE_BYPASS;
+	func_shaper_new->tf = TRANSFER_FUNCTION_LINEAR;
+
+	stream->func_shaper = func_shaper_new;
+
+	return 0;
+}
+
+static void __to_dc_lut3d_color(struct dc_rgb *rgb,
+				const struct drm_color_lut lut,
+				int bit_precision)
+{
+	rgb->red = drm_color_lut_extract(lut.red, bit_precision);
+	rgb->green = drm_color_lut_extract(lut.green, bit_precision);
+	rgb->blue  = drm_color_lut_extract(lut.blue, bit_precision);
+}
+
+static void __drm_3dlut_to_dc_3dlut(const struct drm_color_lut *lut,
+				    uint32_t lut_size,
+				    struct dc_3dlut *lut3d)
+{
+	int lut_i, i;
+
+	ASSERT(lut3d && lut_size == MAX_COLOR_3DLUT_ENTRIES);
+
+	/* So far, only supports 17x17x17 3D LUT with 12-bit*/
+	lut3d->lut_3d.use_tetrahedral_9 = false;
+	lut3d->lut_3d.use_12bits = true;
+	lut3d->state.bits.initialized = 1;
+
+	for (lut_i = 0, i = 0; i < lut_size - 4; lut_i++, i += 4) {
+		/* We should consider the 3dlut RGB values are distributed
+		 * along four arrays lut0-3 where the first sizes 1229 and the
+		 * other 1228. The bit depth supported for 3dlut channel is
+		 * 12-bit, but DC also supports 10-bit.
+		 *
+		 * TODO: improve color pipeline API to enable the userspace set
+		 * bit depth and 3D LUT size/stride, as specified by VA-API.
+		 */
+		__to_dc_lut3d_color(&lut3d->lut_3d.tetrahedral_17.lut0[lut_i], lut[i], 12);
+		__to_dc_lut3d_color(&lut3d->lut_3d.tetrahedral_17.lut1[lut_i], lut[i + 1], 12);
+		__to_dc_lut3d_color(&lut3d->lut_3d.tetrahedral_17.lut2[lut_i], lut[i + 2], 12);
+		__to_dc_lut3d_color(&lut3d->lut_3d.tetrahedral_17.lut3[lut_i], lut[i + 3], 12);
+	}
+	/* lut0 has 1229 points (lut_size/4 + 1) */
+	__to_dc_lut3d_color(&lut3d->lut_3d.tetrahedral_17.lut0[lut_i], lut[i], 12);
+}
+
+/**
+ * amdgpu_dm_3dlut_size - get expected size according to hw color caps
+ * @lut_size: default size
+ * @adev: amdgpu device
+ *
+ * Return:
+ * lut_size if 3dlut is supported, zero otherwise
+ */
+static uint32_t amdgpu_dm_get_3dlut_size(uint32_t lut_size,
+					 struct amdgpu_device *adev)
+{
+	return adev->dm.dc->caps.color.mpc.num_3dluts ? lut_size : 0;
+}
+
+int amdgpu_dm_verify_3dlut_size(const struct drm_crtc_state *crtc_state,
+				struct amdgpu_device *adev)
+{
+	const struct drm_color_lut *lut3d = NULL;
+	uint32_t exp_size, size;
+
+	exp_size = amdgpu_dm_get_3dlut_size(MAX_COLOR_3DLUT_ENTRIES, adev);
+	lut3d = __extract_blob_lut(crtc_state->lut3d, &size);
+
+	if (lut3d && size != exp_size) {
+		DRM_DEBUG_DRIVER("Invalid Gamma 3D LUT size. Should be %u but got %u.\n",
+				 exp_size, size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int amdgpu_dm_atomic_shaper_3dlut(struct dc *dc,
+					 struct dc_stream_state *stream,
+					 const struct drm_color_lut *drm_lut3d,
+					 uint32_t drm_lut3d_size)
+{
+	struct dc_3dlut *lut3d_old = (struct dc_3dlut *) stream->lut3d_func;
+	struct dc_transfer_func *shaper_old = (struct dc_transfer_func *) stream->func_shaper;
+	struct dc_3dlut *lut3d_new = NULL;
+	struct dc_transfer_func *shaper_new = NULL;
+	int r;
+
+	if (lut3d_old && shaper_old) {
+		if (!dc_acquire_release_mpc_3dlut(dc, false, stream,
+						  &lut3d_old, &shaper_old)) {
+			DRM_DEBUG_DRIVER("Failed to release. Shaper or 3D LUT not found.\n");
+		}
+	}
+
+	if (!dc_acquire_release_mpc_3dlut(dc, true, stream,
+					  &lut3d_new, &shaper_new)) {
+		DRM_DEBUG_DRIVER("No MPC 3D LUT available in the resource pool.\n");
+		return -EFAULT;
+	}
+
+	r = amdgpu_dm_atomic_shaper_lut(stream, shaper_new);
+	if (r)
+		return r;
+
+	__drm_3dlut_to_dc_3dlut(drm_lut3d, drm_lut3d_size, lut3d_new);
+
+	stream->lut3d_func = lut3d_new;
+
+	return 0;
+}
+
 /**
  * amdgpu_dm_verify_lut_sizes - verifies if DRM luts match the hw supported sizes
  * @crtc_state: the DRM CRTC state
@@ -417,8 +542,10 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 	bool has_rom = adev->asic_type <= CHIP_RAVEN;
 	struct drm_color_ctm *ctm = NULL;
 	const struct drm_color_lut *degamma_lut, *regamma_lut;
+	const struct drm_color_lut *lut3d;
 	uint32_t degamma_size, regamma_size;
-	bool has_regamma, has_degamma;
+	uint32_t lut3d_size;
+	bool has_regamma, has_degamma, has_lut3d;
 	bool is_legacy;
 	int r;
 
@@ -426,12 +553,20 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 	if (r)
 		return r;
 
+	r =  amdgpu_dm_verify_3dlut_size(&crtc->base, adev);
+	if (r)
+		return r;
+
 	degamma_lut = __extract_blob_lut(crtc->base.degamma_lut, &degamma_size);
+	lut3d = __extract_blob_lut(crtc->base.lut3d, &lut3d_size);
 	regamma_lut = __extract_blob_lut(crtc->base.gamma_lut, &regamma_size);
 
 	has_degamma =
 		degamma_lut && !__is_lut_linear(degamma_lut, degamma_size);
 
+	has_lut3d =
+		lut3d && !__is_lut_linear(lut3d, lut3d_size);
+
 	has_regamma =
 		regamma_lut && !__is_lut_linear(regamma_lut, regamma_size);
 
@@ -469,6 +604,18 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 		if (r)
 			return r;
 	} else {
+		if (has_lut3d) {
+			r = amdgpu_dm_atomic_shaper_3dlut(adev->dm.dc, stream,
+							  lut3d, lut3d_size);
+			if (r)
+				return r;
+		}
+		/* Note: OGAM is disabled if 3D LUT is successfully programmed.
+		 * For reference, see params and set_output_gamma in
+		 * dcn30_set_output_transfer_func(). So, in this case, it would
+		 * be more correct to program OGAM only when user 3DLUT is not
+		 * set.
+		 */
 		regamma_size = has_regamma ? regamma_size : 0;
 		r = amdgpu_dm_set_atomic_regamma(stream, regamma_lut, regamma_size);
 		if (r)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index f62d50901d92..53043fe02a96 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -129,11 +129,24 @@ static bool dc_stream_construct(struct dc_stream_state *stream,
 
 static void dc_stream_destruct(struct dc_stream_state *stream)
 {
+	struct dc_3dlut *lut3d_old = (struct dc_3dlut *) stream->lut3d_func;
+	struct dc_transfer_func *shaper_old = (struct dc_transfer_func *) stream->func_shaper;
+	struct dc *dc = stream->ctx->dc;
+
 	dc_sink_release(stream->sink);
 	if (stream->out_transfer_func != NULL) {
 		dc_transfer_func_release(stream->out_transfer_func);
 		stream->out_transfer_func = NULL;
 	}
+
+	/* TODO: Check if the timing to acquire and release is correct */
+	if (lut3d_old && shaper_old) {
+		if (!dc_acquire_release_mpc_3dlut(dc, false, stream,
+						  &lut3d_old, &shaper_old)) {
+			DRM_DEBUG_DRIVER("Failed to release. Shaper or 3D LUT not found.\n");
+		}
+	}
+
 }
 
 void dc_stream_retain(struct dc_stream_state *stream)
-- 
2.35.1

