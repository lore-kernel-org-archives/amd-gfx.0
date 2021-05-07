Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DB0C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 19:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4798661001
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 19:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4798661001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0536E424;
	Fri,  7 May 2021 19:35:19 +0000 (UTC)
X-Greylist: delayed 468 seconds by postgrey-1.36 at gabe;
 Fri, 07 May 2021 19:35:18 UTC
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD276E424
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 19:35:18 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id 00C4CC800A2;
 Fri,  7 May 2021 21:27:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id vPSkiOcuewgT; Fri,  7 May 2021 21:27:28 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box
 (p200300E37F12f200d51BE97DB8e423B2.dip0.t-ipconnect.de
 [IPv6:2003:e3:7f12:f200:d51b:e97d:b8e4:23b2])
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPA id 704D3C800A1;
 Fri,  7 May 2021 21:27:28 +0200 (CEST)
From: Werner Sembach <wse@tuxedocomputers.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Expose active display color configurations
 to userspace
Date: Fri,  7 May 2021 21:27:18 +0200
Message-Id: <20210507192718.35314-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Cc: Werner Sembach <wse@tuxedocomputers.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

xrandr --prop and other userspace info tools have currently no way of
telling which color configuration is used on HDMI and DP ports.

The ongoing transsition from HDMI 1.4 to 2.0 and the different bandwidth
requirements of YCbCr 4:2:0 and RGB color format raise different
incompatibilities. Having these configuration information readily
available is a useful tool in debuging washed out colors, color artefacts
on small fonts and missing refreshrate options.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 58 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  4 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 ++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index f753e04fee99..c0404bcda31b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -986,6 +986,40 @@ static const struct drm_prop_enum_list amdgpu_dither_enum_list[] =
 	{ AMDGPU_FMT_DITHER_ENABLE, "on" },
 };
 
+static const struct drm_prop_enum_list amdgpu_active_pixel_encoding_enum_list[] = {
+	{ PIXEL_ENCODING_UNDEFINED, "undefined" },
+	{ PIXEL_ENCODING_RGB, "RGB" },
+	{ PIXEL_ENCODING_YCBCR422, "YCbCr 4:2:2" },
+	{ PIXEL_ENCODING_YCBCR444, "YCbCr 4:4:4" },
+	{ PIXEL_ENCODING_YCBCR420, "YCbCr 4:2:0" },
+};
+
+static const struct drm_prop_enum_list amdgpu_active_display_color_depth_enum_list[] = {
+	{ COLOR_DEPTH_UNDEFINED, "undefined" },
+	{ COLOR_DEPTH_666, "6 bit" },
+	{ COLOR_DEPTH_888, "8 bit" },
+	{ COLOR_DEPTH_101010, "10 bit" },
+	{ COLOR_DEPTH_121212, "12 bit" },
+	{ COLOR_DEPTH_141414, "14 bit" },
+	{ COLOR_DEPTH_161616, "16 bit" },
+	{ COLOR_DEPTH_999, "9 bit" },
+	{ COLOR_DEPTH_111111, "11 bit" },
+};
+
+static const struct drm_prop_enum_list amdgpu_active_output_color_space_enum_list[] = {
+	{ COLOR_SPACE_UNKNOWN, "unknown" },
+	{ COLOR_SPACE_SRGB, "sRGB" },
+	{ COLOR_SPACE_SRGB_LIMITED, "sRGB limited" },
+	{ COLOR_SPACE_YCBCR601, "YCbCr 601" },
+	{ COLOR_SPACE_YCBCR709, "YCbCr 709" },
+	{ COLOR_SPACE_YCBCR601_LIMITED, "YCbCr 601 limited" },
+	{ COLOR_SPACE_YCBCR709_LIMITED, "YCbCr 709 limited" },
+	{ COLOR_SPACE_2020_RGB_FULLRANGE, "RGB 2020" },
+	{ COLOR_SPACE_2020_RGB_LIMITEDRANGE, "RGB 2020 limited" },
+	{ COLOR_SPACE_2020_YCBCR, "YCbCr 2020" },
+	{ COLOR_SPACE_ADOBERGB, "Adobe RGB" },
+};
+
 int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
 {
 	int sz;
@@ -1038,6 +1072,30 @@ int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
 						  "abm level", 0, 4);
 		if (!adev->mode_info.abm_level_property)
 			return -ENOMEM;
+
+		sz = ARRAY_SIZE(amdgpu_active_pixel_encoding_enum_list);
+		adev->mode_info.active_pixel_encoding_property =
+			drm_property_create_enum(adev_to_drm(adev), 0,
+				"active pixel encoding",
+				amdgpu_active_pixel_encoding_enum_list, sz);
+		if (!adev->mode_info.active_pixel_encoding_property)
+			return -ENOMEM;
+
+		sz = ARRAY_SIZE(amdgpu_active_display_color_depth_enum_list);
+		adev->mode_info.active_display_color_depth_property =
+			drm_property_create_enum(adev_to_drm(adev), 0,
+				"active display color depth",
+				amdgpu_active_display_color_depth_enum_list, sz);
+		if (!adev->mode_info.active_display_color_depth_property)
+			return -ENOMEM;
+
+		sz = ARRAY_SIZE(amdgpu_active_output_color_space_enum_list);
+		adev->mode_info.active_output_color_space_property =
+			drm_property_create_enum(adev_to_drm(adev), 0,
+				"active output color space",
+				amdgpu_active_output_color_space_enum_list, sz);
+		if (!adev->mode_info.active_output_color_space_property)
+			return -ENOMEM;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 319cb19e1b99..ad43af6a878d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -337,6 +337,10 @@ struct amdgpu_mode_info {
 	struct drm_property *dither_property;
 	/* Adaptive Backlight Modulation (power feature) */
 	struct drm_property *abm_level_property;
+	/* Color settings */
+	struct drm_property *active_pixel_encoding_property;
+	struct drm_property *active_display_color_depth_property;
+	struct drm_property *active_output_color_space_property;
 	/* hardcoded DFP edid from BIOS */
 	struct edid *bios_hardcoded_edid;
 	int bios_hardcoded_edid_size;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d699a5cf6c11..89465f74ca59 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5592,8 +5592,13 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct dm_connector_state *dm_state =
 		to_dm_connector_state(state);
+	struct dm_crtc_state *dm_crtc_state = NULL;
 	int ret = -EINVAL;
 
+	if (state->crtc != NULL && state->crtc->state != NULL) {
+		dm_crtc_state = to_dm_crtc_state(state->crtc->state);
+	}
+
 	if (property == dev->mode_config.scaling_mode_property) {
 		switch (dm_state->scaling) {
 		case RMX_CENTER:
@@ -5623,6 +5628,21 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 	} else if (property == adev->mode_info.abm_level_property) {
 		*val = dm_state->abm_level;
 		ret = 0;
+	} else if (property == adev->mode_info.active_pixel_encoding_property) {
+		*val = PIXEL_ENCODING_UNDEFINED;
+		if (dm_crtc_state != NULL && dm_crtc_state->stream != NULL)
+			*val = dm_crtc_state->stream->timing.pixel_encoding;
+		ret = 0;
+	} else if (property == adev->mode_info.active_display_color_depth_property) {
+		*val = COLOR_DEPTH_UNDEFINED;
+		if (dm_crtc_state != NULL && dm_crtc_state->stream != NULL)
+			*val = dm_crtc_state->stream->timing.display_color_depth;
+		ret = 0;
+	} else if (property == adev->mode_info.active_output_color_space_property) {
+		*val = COLOR_SPACE_UNKNOWN;
+		if (dm_crtc_state != NULL && dm_crtc_state->stream != NULL)
+			*val = dm_crtc_state->stream->output_color_space;
+		ret = 0;
 	}
 
 	return ret;
@@ -7083,6 +7103,22 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 			drm_connector_attach_content_protection_property(&aconnector->base, true);
 #endif
 	}
+
+	if (adev->mode_info.active_pixel_encoding_property) {
+		drm_object_attach_property(&aconnector->base.base,
+			adev->mode_info.active_pixel_encoding_property, 0);
+		DRM_DEBUG_DRIVER("amdgpu: attached active pixel encoding drm property");
+	}
+	if (adev->mode_info.active_display_color_depth_property) {
+		drm_object_attach_property(&aconnector->base.base,
+			adev->mode_info.active_display_color_depth_property, 0);
+		DRM_DEBUG_DRIVER("amdgpu: attached active color depth drm property");
+	}
+	if (adev->mode_info.active_output_color_space_property) {
+		drm_object_attach_property(&aconnector->base.base,
+			adev->mode_info.active_output_color_space_property, 0);
+		DRM_DEBUG_DRIVER("amdgpu: attached active output color space drm property");
+	}
 }
 
 static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
