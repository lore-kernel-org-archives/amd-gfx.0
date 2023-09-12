Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D108ACA0EEB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 16:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7836E10E435;
	Tue, 12 Sep 2023 16:02:07 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A942E10E435
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=svJcxVjI9Ymf/YnEZ/Tq2MFL7xZ5b7GW1vzo/EcE5ow=; b=IIe22wwsSduYPLDGBbcaj4reoj
 b/T8nMU+7hhedBXzk1WR8PlyPx5NrUg/oMuQJHruudN1Rl8k0GZRr/cDrUopJ3PCiwqRyNRmgIZUX
 Wz/gGuFQCOJsDDp5AdxYDZDv9g1wY9y2N83CyaMAwzndp7tAY36FVPJWXHA7Cpll58i6sAxu2dGZD
 HDU1wjt///CLJfphPH0v/wDKuy1aqzhvb2DaUU1SuTuEZlkDlNU7kYzQhLTBSRZE+VcpgPYf42kpB
 mbQEiXi0NlOgbCA9FI8is/lZ2DPLTJf804xkfuc8InxIeQwCl2AezIp2Ki/h0l63v48VndrXA7Fto
 7n1WrpLQ==;
Received: from [38.44.68.151] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qg5pw-002m4H-Dh; Tue, 12 Sep 2023 18:02:00 +0200
From: Melissa Wen <mwen@igalia.com>
To: Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Subject: [PATCH v2 1/2] drm/amd/display: Hook up 'content type' property for
 HDMI
Date: Tue, 12 Sep 2023 15:01:56 -0100
Message-Id: <20230912160157.107975-2-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230912160157.107975-1-mwen@igalia.com>
References: <20230912160157.107975-1-mwen@igalia.com>
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
Cc: kernel-dev@igalia.com, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 amd-gfx@lists.freedesktop.org, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Ashton <joshua@froggi.es>

Implements the 'content type' property for HDMI connectors.
Verified by checking the avi infoframe on a connected TV.

This also simplifies a lot of the code in that area as well, there were
a lot of temp variables doing very little and unnecessary logic
that was quite confusing.

It is not necessary to check for support in the EDID before sending a
'content type' value in the avi infoframe also.

v2:
- rebase to amd-staging-drm-next
- mark CRTC state for reset if content_type differs

Reviewed-by: Harry Wentland <harry.wentland@amd.com> (v1)
Signed-off-by: Joshua Ashton <joshua@froggi.es>
Co-developed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 69 ++++++-------------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
 3 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5efebc06296b..811e2223f643 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5461,6 +5461,24 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 	return color_space;
 }
 
+static enum display_content_type
+get_output_content_type(const struct drm_connector_state *connector_state)
+{
+	switch (connector_state->content_type) {
+	default:
+	case DRM_MODE_CONTENT_TYPE_NO_DATA:
+		return DISPLAY_CONTENT_TYPE_NO_DATA;
+	case DRM_MODE_CONTENT_TYPE_GRAPHICS:
+		return DISPLAY_CONTENT_TYPE_GRAPHICS;
+	case DRM_MODE_CONTENT_TYPE_PHOTO:
+		return DISPLAY_CONTENT_TYPE_PHOTO;
+	case DRM_MODE_CONTENT_TYPE_CINEMA:
+		return DISPLAY_CONTENT_TYPE_CINEMA;
+	case DRM_MODE_CONTENT_TYPE_GAME:
+		return DISPLAY_CONTENT_TYPE_GAME;
+	}
+}
+
 static bool adjust_colour_depth_from_display_info(
 	struct dc_crtc_timing *timing_out,
 	const struct drm_display_info *info)
@@ -5595,6 +5613,7 @@ static void fill_stream_properties_from_drm_display_mode(
 	}
 
 	stream->output_color_space = get_output_color_space(timing_out, connector_state);
+	stream->content_type = get_output_content_type(connector_state);
 }
 
 static void fill_audio_info(struct audio_info *audio_info,
@@ -6795,6 +6814,14 @@ amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
 		new_crtc_state->mode_changed = true;
 	}
 
+	if (new_con_state->content_type != old_con_state->content_type) {
+		new_crtc_state = drm_atomic_get_crtc_state(state, crtc);
+		if (IS_ERR(new_crtc_state))
+			return PTR_ERR(new_crtc_state);
+
+		new_crtc_state->mode_changed = true;
+	}
+
 	if (!drm_connector_atomic_hdr_metadata_equal(old_con_state, new_con_state)) {
 		struct dc_info_packet hdr_infopacket;
 
@@ -7430,6 +7457,11 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				adev->mode_info.abm_level_property, 0);
 	}
 
+	if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
+		/* Content Type is currently only implemented for HDMI. */
+		drm_connector_attach_content_type_property(&aconnector->base);
+	}
+
 	if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
 		if (!drm_mode_create_hdmi_colorspace_property(&aconnector->base, supported_colorspaces))
 			drm_connector_attach_colorspace_property(&aconnector->base);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 494efbede0b2..5810cf78cf29 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3928,14 +3928,9 @@ static void set_avi_info_frame(
 	uint32_t pixel_encoding = 0;
 	enum scanning_type scan_type = SCANNING_TYPE_NODATA;
 	enum dc_aspect_ratio aspect = ASPECT_RATIO_NO_DATA;
-	bool itc = false;
-	uint8_t itc_value = 0;
-	uint8_t cn0_cn1 = 0;
-	unsigned int cn0_cn1_value = 0;
 	uint8_t *check_sum = NULL;
 	uint8_t byte_index = 0;
 	union hdmi_info_packet hdmi_info;
-	union display_content_support support = {0};
 	unsigned int vic = pipe_ctx->stream->timing.vic;
 	unsigned int rid = pipe_ctx->stream->timing.rid;
 	unsigned int fr_ind = pipe_ctx->stream->timing.fr_index;
@@ -4045,49 +4040,27 @@ static void set_avi_info_frame(
 	/* Active Format Aspect ratio - same as Picture Aspect Ratio. */
 	hdmi_info.bits.R0_R3 = ACTIVE_FORMAT_ASPECT_RATIO_SAME_AS_PICTURE;
 
-	/* TODO: un-hardcode cn0_cn1 and itc */
-
-	cn0_cn1 = 0;
-	cn0_cn1_value = 0;
-
-	itc = true;
-	itc_value = 1;
-
-	support = stream->content_support;
-
-	if (itc) {
-		if (!support.bits.valid_content_type) {
-			cn0_cn1_value = 0;
-		} else {
-			if (cn0_cn1 == DISPLAY_CONTENT_TYPE_GRAPHICS) {
-				if (support.bits.graphics_content == 1) {
-					cn0_cn1_value = 0;
-				}
-			} else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_PHOTO) {
-				if (support.bits.photo_content == 1) {
-					cn0_cn1_value = 1;
-				} else {
-					cn0_cn1_value = 0;
-					itc_value = 0;
-				}
-			} else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_CINEMA) {
-				if (support.bits.cinema_content == 1) {
-					cn0_cn1_value = 2;
-				} else {
-					cn0_cn1_value = 0;
-					itc_value = 0;
-				}
-			} else if (cn0_cn1 == DISPLAY_CONTENT_TYPE_GAME) {
-				if (support.bits.game_content == 1) {
-					cn0_cn1_value = 3;
-				} else {
-					cn0_cn1_value = 0;
-					itc_value = 0;
-				}
-			}
-		}
-		hdmi_info.bits.CN0_CN1 = cn0_cn1_value;
-		hdmi_info.bits.ITC = itc_value;
+	switch (stream->content_type) {
+	case DISPLAY_CONTENT_TYPE_NO_DATA:
+		hdmi_info.bits.CN0_CN1 = 0;
+		hdmi_info.bits.ITC = 0;
+		break;
+	case DISPLAY_CONTENT_TYPE_GRAPHICS:
+		hdmi_info.bits.CN0_CN1 = 0;
+		hdmi_info.bits.ITC = 1;
+		break;
+	case DISPLAY_CONTENT_TYPE_PHOTO:
+		hdmi_info.bits.CN0_CN1 = 1;
+		hdmi_info.bits.ITC = 1;
+		break;
+	case DISPLAY_CONTENT_TYPE_CINEMA:
+		hdmi_info.bits.CN0_CN1 = 2;
+		hdmi_info.bits.ITC = 1;
+		break;
+	case DISPLAY_CONTENT_TYPE_GAME:
+		hdmi_info.bits.CN0_CN1 = 3;
+		hdmi_info.bits.ITC = 1;
+		break;
 	}
 
 	if (stream->qs_bit == 1) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index d5b3e3a32cc6..d4224de13138 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -212,6 +212,7 @@ struct dc_stream_state {
 	struct dc_csc_transform csc_color_matrix;
 
 	enum dc_color_space output_color_space;
+	enum display_content_type content_type;
 	enum dc_dither_option dither_option;
 
 	enum view_3d_format view_format;
-- 
2.40.1

