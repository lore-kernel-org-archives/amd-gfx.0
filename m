Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3747CECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 16:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8A010E6FB;
	Tue,  6 Sep 2022 16:47:02 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A729F10E093
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=it7ihV+PKmt02NyQXtZIKw2mgGa6I9gSWOZGeL7PIe0=; b=lUV1JjNJb/4+xO6emspEAZmV2w
 KyWqUwEADF5dr6X2rZ9vc8ozMyszwKfTp83oRa8XZmyzqcXRstAI0gA72cuvjGJz5W4iyRcEjzl5K
 oDKO6HFokvNpyg95FfGG5rX9nrcgGO1DJ2oZrcdWTsWJ21t5adrgg46IKHJeWJUPpI+7Ac4nTCP6F
 m20y7iDS0WSAbRPPplKM09WejwBvo2Cx5taAhA4TTmbuY19ufcgN2MxE2iEdqv90OuDfAmF9WnTRU
 n86MnWoOCa9/64DkrClQkAeOBN3p7zlovDE8mP0FDUQMXpo9In/50Zs2Zo6zLRBqZy3gmu481aPc8
 Ze5HZzXA==;
Received: from [38.44.74.92] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oVbix-00CALM-SZ; Tue, 06 Sep 2022 18:46:55 +0200
From: Melissa Wen <mwen@igalia.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com
Subject: [RFC PATCH v2 4/9] drm/drm_color_mgmt: add 3D LUT to color mgmt
 properties
Date: Tue,  6 Sep 2022 15:46:23 -0100
Message-Id: <20220906164628.2361811-5-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906164628.2361811-1-mwen@igalia.com>
References: <20220906164628.2361811-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add 3D LUT for gammar correction using a 3D lookup table. The position
in the color correction pipeline where 3D LUT is applied depends on hw
design, being after CTM or gamma. If just after CTM, a shaper lut must
be set to shape the content for a non-linear space. That details should
be handled by the driver according to its color capabilities.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic_state_helper.c |  3 ++
 drivers/gpu/drm/drm_atomic_uapi.c         | 10 ++++
 drivers/gpu/drm/drm_color_mgmt.c          | 58 +++++++++++++++++++++++
 drivers/gpu/drm/drm_fb_helper.c           |  2 +
 drivers/gpu/drm/drm_mode_config.c         | 14 ++++++
 include/drm/drm_color_mgmt.h              |  4 ++
 include/drm/drm_crtc.h                    | 12 ++++-
 include/drm/drm_mode_config.h             | 13 +++++
 8 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index bf3222fbf4bb..cad579c66248 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -141,6 +141,8 @@ void __drm_atomic_helper_crtc_duplicate_state(struct drm_crtc *crtc,
 		drm_property_blob_get(state->ctm);
 	if (state->shaper_lut)
 		drm_property_blob_get(state->shaper_lut);
+	if (state->lut3d)
+		drm_property_blob_get(state->lut3d);
 	if (state->gamma_lut)
 		drm_property_blob_get(state->gamma_lut);
 
@@ -216,6 +218,7 @@ void __drm_atomic_helper_crtc_destroy_state(struct drm_crtc_state *state)
 	drm_property_blob_put(state->degamma_lut);
 	drm_property_blob_put(state->ctm);
 	drm_property_blob_put(state->shaper_lut);
+	drm_property_blob_put(state->lut3d);
 	drm_property_blob_put(state->gamma_lut);
 }
 EXPORT_SYMBOL(__drm_atomic_helper_crtc_destroy_state);
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index ee78f4f5976d..041b00faebe9 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -437,6 +437,14 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 					&replaced);
 		state->color_mgmt_changed |= replaced;
 		return ret;
+	} else if (property == config->lut3d_property) {
+		ret = drm_atomic_replace_property_blob_from_id(dev,
+					&state->lut3d,
+					val,
+					-1, sizeof(struct drm_color_lut),
+					&replaced);
+		state->color_mgmt_changed |= replaced;
+		return ret;
 	} else if (property == config->gamma_lut_property) {
 		ret = drm_atomic_replace_property_blob_from_id(dev,
 					&state->gamma_lut,
@@ -490,6 +498,8 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
 		*val = (state->ctm) ? state->ctm->base.id : 0;
 	else if (property == config->shaper_lut_property)
 		*val = (state->shaper_lut) ? state->shaper_lut->base.id : 0;
+	else if (property == config->lut3d_property)
+		*val = (state->lut3d) ? state->lut3d->base.id : 0;
 	else if (property == config->gamma_lut_property)
 		*val = (state->gamma_lut) ? state->gamma_lut->base.id : 0;
 	else if (property == config->prop_out_fence_ptr)
diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index 873cca35f078..a87bfb866bcb 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -87,6 +87,25 @@
  *	publish the largest size, and sub-sample smaller sized LUTs
  *	appropriately.
  *
+ * “LUT3D”:
+ *	Blob property to set the 3D LUT mapping pixel data after the color
+ *	transformation matrix and before gamma 1D lut correction. The
+ *	data is interpreted as an array of &struct drm_color_lut elements.
+ *	Hardware might choose not to use the full precision of the LUT
+ *	elements.
+ *
+ *	Setting this to NULL (blob property value set to 0) means a the output
+ *	color is identical to the input color. This is generally the driver
+ *	boot-up state too. Drivers can access this blob through
+ *	&drm_crtc_state.gamma_lut.
+ *
+ * “LUT3D_SIZE”:
+ *	Unsigned range property to give the size of the 3D lookup table to be
+ *	set on the LUT3D property (the size depends on the underlying
+ *	hardware). If drivers support multiple LUT sizes then they should
+ *	publish the largest size, and sub-sample smaller sized LUTs
+ *	appropriately.
+ *
  * “GAMMA_LUT”:
  *	Blob property to set the gamma lookup table (LUT) mapping pixel data
  *	after the transformation matrix to data sent to the connector. The
@@ -208,6 +227,45 @@ void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_crtc_enable_color_mgmt);
 
+/**
+ * drm_crtc_enable_lut3d - enable 3D LUT properties
+ * @crtc: DRM CRTC
+ * @shaper_lut_size: the size of shaper lut
+ * @lut3d_size: the size of 3D lut
+ *
+ * This function lets the driver enable the 3D LUT color correction property
+ * on a CRTC. This includes 3D LUT and also a shaper LUT, if set. The shaper
+ * LUT property is only attached if its size is not 0 and 3D LUT is set, being
+ * therefore optional.
+ */
+void drm_crtc_enable_lut3d(struct drm_crtc *crtc,
+			   uint shaper_lut_size,
+			   uint lut3d_size)
+{
+	struct drm_device *dev = crtc->dev;
+	struct drm_mode_config *config = &dev->mode_config;
+
+	if (!lut3d_size)
+		return;
+
+	drm_object_attach_property(&crtc->base,
+				   config->lut3d_property, 0);
+	drm_object_attach_property(&crtc->base,
+				   config->lut3d_size_property,
+				   lut3d_size);
+	if (!shaper_lut_size)
+		return;
+
+	drm_object_attach_property(&crtc->base,
+				   config->shaper_lut_property, 0);
+	drm_object_attach_property(&crtc->base,
+				   config->shaper_lut_size_property,
+				   shaper_lut_size);
+
+}
+EXPORT_SYMBOL(drm_crtc_enable_lut3d);
+
+
 /**
  * drm_mode_crtc_set_gamma_size - set the gamma table size
  * @crtc: CRTC to set the gamma table size for
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 20c4878bd4d9..a91db904392e 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1100,6 +1100,8 @@ static int setcmap_atomic(struct fb_cmap *cmap, struct fb_info *info)
 		replaced |= drm_property_replace_blob(&crtc_state->ctm, NULL);
 		replaced |= drm_property_replace_blob(&crtc_state->shaper_lut,
 						      NULL);
+		replaced |= drm_property_replace_blob(&crtc_state->lut3d,
+						      NULL);
 		replaced |= drm_property_replace_blob(&crtc_state->gamma_lut,
 						      gamma_lut);
 
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 4ba2a95b88e8..5458a7dfbe63 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -364,6 +364,20 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
 		return -ENOMEM;
 	dev->mode_config.shaper_lut_size_property = prop;
 
+	prop = drm_property_create(dev,
+			DRM_MODE_PROP_BLOB,
+			"LUT3D", 0);
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.lut3d_property = prop;
+
+	prop = drm_property_create_range(dev,
+			DRM_MODE_PROP_IMMUTABLE,
+			"LUT3D_SIZE", 0, UINT_MAX);
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.lut3d_size_property = prop;
+
 	prop = drm_property_create(dev,
 			DRM_MODE_PROP_BLOB,
 			"GAMMA_LUT", 0);
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 81c298488b0c..a4f054e0108f 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -59,6 +59,10 @@ void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
 				bool has_ctm,
 				uint gamma_lut_size);
 
+void drm_crtc_enable_lut3d(struct drm_crtc *crtc,
+			   uint shaper_lut_size,
+			   uint lut3d_size);
+
 int drm_mode_crtc_set_gamma_size(struct drm_crtc *crtc,
 				 int gamma_size);
 
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 21938780d4bd..1ac61001e0e7 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -165,7 +165,7 @@ struct drm_crtc_state {
 	bool zpos_changed : 1;
 	/**
 	 * @color_mgmt_changed: Color management properties have changed
-	 * (@shaper_lut, @gamma_lut, @degamma_lut or @ctm). Used by
+	 * (@shaper_lut, @lut3d, @gamma_lut, @degamma_lut or @ctm). Used by
 	 * the atomic helpers and drivers to steer the atomic commit control
 	 * flow.
 	 */
@@ -302,6 +302,16 @@ struct drm_crtc_state {
 	 */
 	struct drm_property_blob *shaper_lut;
 
+	/**
+	 * @lut3d:
+	 *
+	 * 3D Lookup table for converting pixel data. Position where it takes
+	 * place depends on hw design, after @ctm or @gamma_lut. See
+	 * drm_crtc_enable_color_mgmt(). The blob (if not NULL) is an array of
+	 * &struct drm_color_lut.
+	 */
+	struct drm_property_blob *lut3d;
+
 	/**
 	 * @target_vblank:
 	 *
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index c174d3a7c951..c15be4e88f6b 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -812,6 +812,19 @@ struct drm_mode_config {
 	 */
 	struct drm_property *shaper_lut_size_property;
 
+	/**
+	 * @lut3d_property: Optional CRTC property to set the 3D LUT used to
+	 * convert colors; before or after gamma conversion depends on hw
+	 * design. A shaper LUT can be used to delinearize content before apply
+	 * 3D LUT correction.
+	 */
+	struct drm_property *lut3d_property;
+	/**
+	 * @lut3d_size_property: Optional CRTC property for the size of the
+	 * 3D LUT as supported by the driver (read-only).
+	 */
+	struct drm_property *lut3d_size_property;
+
 	/**
 	 * @gamma_lut_property: Optional CRTC property to set the LUT used to
 	 * convert the colors, after the CTM matrix, to the gamma space of the
-- 
2.35.1

