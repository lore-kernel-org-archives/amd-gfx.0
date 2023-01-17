Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43210C3DA78
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 21:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E9510E35D;
	Tue, 17 Jan 2023 21:26:25 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0252610E35D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 21:26:23 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id r30so7570660wrr.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 13:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+Xn2zbXh06OLD78lWeuyMvVLsjDOyPB+dCPLNS4D0/o=;
 b=iHdeKzXls0TtQ6XCF5TwoJY31zcffNShBNGWSCmgWbgIOlCurA9raB3hNAIKzvVA3r
 ItisVhAjjO3ExVxDU1hrPPk3ZwLlAZOA7yJmwX8l1dXt6rbEkJsHlMRzPZv2gldvuls7
 nWzzZ1xUwVNMmi2aBI7RP/X3knhXpc1Mw4xVvCQv2zZdRetyfBR4UP8F4EbcIvmN3fRP
 6EHQuVQhl1jLipHePxBU9ebpYIl07z7BGrllurJf1rAma3YoBs/d7ShVJQgA/+endu9h
 kLTC/D/jE5LR0EclYXA18NfUUo0oVLDaS421/SVoRqVB+Ay32vr14MG20kJkWUHSVhRr
 1W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Xn2zbXh06OLD78lWeuyMvVLsjDOyPB+dCPLNS4D0/o=;
 b=TEdh9sPsyftLocuy7mHI7b2dcPyhx5fdzBDyKMNPn5ihMWWpG/nnVA16QTMf6XkYBJ
 RId8BSGRJdZRV6rZEq8mXSdt9QqnkDnB850OwcVnDUWlFu7sCCP6fnSNTnLuRFYATTAA
 vQgghk/+BQ8ZSjZu06KeXPs6E69JT+NQuYPDkG949IYDSkDkEflNEHEvfISJAC9vmNkG
 G9cg0+WSmippmuwJifBwlC6aXch5QX1uQn4zGPRwA+nnq4M2Htpctm4CosF0A9JgxYqX
 tgt7zprlgpRIGulDIkOn96dFrEhj5ExgyaYfdYQdidDFHsMkrDBFUE/gEja3QmG9796g
 qaZw==
X-Gm-Message-State: AFqh2krjyCIIJfIKfokaPfdO8ELZp5Wtgs9X8GBqy9/XSk+A2tiqQO5t
 3cZYXyscP4aFNaYhvQkPfVr/TaU8BBCXu0MP
X-Google-Smtp-Source: AMrXdXvzvdZ1D45Y68TwV4MrspjIvBrH9ePnFUFknP700J6S1iwIz6kM7U4DUsanSF4XxYN4cL/O5A==
X-Received: by 2002:a5d:4cc6:0:b0:269:65c0:79fd with SMTP id
 c6-20020a5d4cc6000000b0026965c079fdmr3653640wrt.53.1673990782340; 
 Tue, 17 Jan 2023 13:26:22 -0800 (PST)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a5d6747000000b002b57bae7174sm30076381wrw.5.2023.01.17.13.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jan 2023 13:26:22 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/display: Hook up 'content type' property for HDMI
Date: Tue, 17 Jan 2023 21:26:19 +0000
Message-Id: <20230117212620.11262-1-joshua@froggi.es>
X-Mailer: git-send-email 2.39.0
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
Cc: Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implements the 'content type' property for HDMI connectors.
Verified by checking the avi infoframe on a connected TV.

This also simplifies a lot of the code in that area as well, there were
a lot of temp variables doing very little and unnecessary logic
that was quite confusing.

It is not necessary to check for support in the EDID before sending a
'content type' value in the avi infoframe also.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 69 ++++++-------------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
 3 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9547037857b6..999965fe3de9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5216,6 +5216,24 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
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
@@ -5349,6 +5367,7 @@ static void fill_stream_properties_from_drm_display_mode(
 	}
 
 	stream->output_color_space = get_output_color_space(timing_out);
+	stream->content_type = get_output_content_type(connector_state);
 }
 
 static void fill_audio_info(struct audio_info *audio_info,
@@ -7123,6 +7142,11 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				adev->mode_info.abm_level_property, 0);
 	}
 
+	if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
+		/* Content Type is currently only implemented for HDMI. */
+		drm_connector_attach_content_type_property(&aconnector->base);
+	}
+
 	if (connector_type == DRM_MODE_CONNECTOR_HDMIA ||
 	    connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
 	    connector_type == DRM_MODE_CONNECTOR_eDP) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a5b5f8592c1b..39ceccdb6586 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2944,14 +2944,9 @@ static void set_avi_info_frame(
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
@@ -3055,49 +3050,27 @@ static void set_avi_info_frame(
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
index ef33d7d8a2bf..51dc30706e43 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -205,6 +205,7 @@ struct dc_stream_state {
 	struct dc_csc_transform csc_color_matrix;
 
 	enum dc_color_space output_color_space;
+	enum display_content_type content_type;
 	enum dc_dither_option dither_option;
 
 	enum view_3d_format view_format;
-- 
2.39.0

