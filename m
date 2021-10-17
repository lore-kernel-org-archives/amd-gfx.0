Return-Path: <SRS0=QO8y=PF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91366C433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Oct 2021 11:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B5A60F46
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Oct 2021 11:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5B5A60F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=net-c.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FBE6E7D2;
	Sun, 17 Oct 2021 11:35:10 +0000 (UTC)
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4CF26E7D9
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Oct 2021 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
 t=1634470505; bh=g+XIaDjo7w31FHQ6jHg0Y6ErCFzrLDo2wqUGUTyTKak=;
 h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding;
 b=Tmzzn4YG8+WCGEOmmpC/rsWimwQiIBt0QOoYIw8uPGv1/eCzN86aQiAR7yCtq4kIw
 VF5A6V9jHKDap/0OncNVVNratY4bhXaPWYDzjNfTFlD3iRyJD1OeoC8ZWyPNZpJN2H
 8Gmn9AVv+4uLsARfhOLVocrt5+XKV4UYBUjWdAvQ=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Sun, 17 Oct 2021 13:35:05 +0200 (CEST)
X-EA-Auth: KdQhrOa+YsdgkgzNlyr7d8YiboFpJ59WmMj1/5DvlVOAEPKD5Ar3eNoTqZ0qP0suEkkw5vN0qhxxecgl14l2SmyyCaWYPe88
From: Claudio Suarez <cssk@net-c.es>
To: amd-gfx@lists.freedesktop.org
Cc: Claudio Suarez <cssk@net-c.es>
Subject: [PATCH 3/3] drm/amdgpu: replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
Date: Sun, 17 Oct 2021 13:35:00 +0200
Message-Id: <20211017113500.7033-4-cssk@net-c.es>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017113500.7033-1-cssk@net-c.es>
References: <20211017113500.7033-1-cssk@net-c.es>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Once EDID is parsed, the monitor HDMI support information is available
through drm_display_info.is_hdmi. The amdgpu driver still calls
drm_detect_hdmi_monitor() to retrieve the same information, which
is less efficient. Change to drm_display_info.is_hdmi

This is a TODO task in Documentation/gpu/todo.rst

Signed-off-by: Claudio Suarez <cssk@net-c.es>
---
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c  |  4 ++--
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    |  6 +++---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 19 +++++++------------
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
 7 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 647aecee1185..0710c19d5e2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -108,7 +108,7 @@ int amdgpu_connector_get_monitor_bpc(struct drm_connector *connector)
 	case DRM_MODE_CONNECTOR_DVII:
 	case DRM_MODE_CONNECTOR_HDMIB:
 		if (amdgpu_connector->use_digital) {
-			if (drm_detect_hdmi_monitor(amdgpu_connector_edid(connector))) {
+			if (connector->display_info.is_hdmi) {
 				if (connector->display_info.bpc)
 					bpc = connector->display_info.bpc;
 			}
@@ -116,7 +116,7 @@ int amdgpu_connector_get_monitor_bpc(struct drm_connector *connector)
 		break;
 	case DRM_MODE_CONNECTOR_DVID:
 	case DRM_MODE_CONNECTOR_HDMIA:
-		if (drm_detect_hdmi_monitor(amdgpu_connector_edid(connector))) {
+		if (connector->display_info.is_hdmi) {
 			if (connector->display_info.bpc)
 				bpc = connector->display_info.bpc;
 		}
@@ -125,7 +125,7 @@ int amdgpu_connector_get_monitor_bpc(struct drm_connector *connector)
 		dig_connector = amdgpu_connector->con_priv;
 		if ((dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT) ||
 		    (dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_eDP) ||
-		    drm_detect_hdmi_monitor(amdgpu_connector_edid(connector))) {
+		    connector->display_info.is_hdmi) {
 			if (connector->display_info.bpc)
 				bpc = connector->display_info.bpc;
 		}
@@ -149,7 +149,7 @@ int amdgpu_connector_get_monitor_bpc(struct drm_connector *connector)
 		break;
 	}
 
-	if (drm_detect_hdmi_monitor(amdgpu_connector_edid(connector))) {
+	if (connector->display_info.is_hdmi) {
 		/*
 		 * Pre DCE-8 hw can't handle > 12 bpc, and more than 12 bpc doesn't make
 		 * much sense without support for > 12 bpc framebuffers. RGB 4:4:4 at
@@ -1173,7 +1173,7 @@ static enum drm_mode_status amdgpu_connector_dvi_mode_valid(struct drm_connector
 		    (amdgpu_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D) ||
 		    (amdgpu_connector->connector_object_id == CONNECTOR_OBJECT_ID_HDMI_TYPE_B)) {
 			return MODE_OK;
-		} else if (drm_detect_hdmi_monitor(amdgpu_connector_edid(connector))) {
+		} else if (connector->display_info.is_hdmi) {
 			/* HDMI 1.3+ supports max clock of 340 Mhz */
 			if (mode->clock > 340000)
 				return MODE_CLOCK_HIGH;
@@ -1465,7 +1465,7 @@ static enum drm_mode_status amdgpu_connector_dp_mode_valid(struct drm_connector
 		    (amdgpu_dig_connector->dp_sink_type == CONNECTOR_OBJECT_ID_eDP)) {
 			return amdgpu_atombios_dp_mode_valid_helper(connector, mode);
 		} else {
-			if (drm_detect_hdmi_monitor(amdgpu_connector_edid(connector))) {
+			if (connector->display_info.is_hdmi) {
 				/* HDMI 1.3+ supports max clock of 340 Mhz */
 				if (mode->clock > 340000)
 					return MODE_CLOCK_HIGH;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index dc50c05f23fc..0bd9d7a4d76f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1364,7 +1364,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 		if ((!(mode->flags & DRM_MODE_FLAG_INTERLACE)) &&
 		    ((amdgpu_encoder->underscan_type == UNDERSCAN_ON) ||
 		     ((amdgpu_encoder->underscan_type == UNDERSCAN_AUTO) &&
-		      drm_detect_hdmi_monitor(amdgpu_connector_edid(connector)) &&
+		      connector->display_info.is_hdmi &&
 		      amdgpu_display_is_hdtv_mode(mode)))) {
 			if (amdgpu_encoder->underscan_hborder != 0)
 				amdgpu_crtc->h_border = amdgpu_encoder->underscan_hborder;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
index af4ef84e27a7..c96e458ed088 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
@@ -222,7 +222,7 @@ bool amdgpu_dig_monitor_is_duallink(struct drm_encoder *encoder,
 	case DRM_MODE_CONNECTOR_HDMIB:
 		if (amdgpu_connector->use_digital) {
 			/* HDMI 1.3 supports up to 340 Mhz over single link */
-			if (drm_detect_hdmi_monitor(amdgpu_connector_edid(connector))) {
+			if (connector->display_info.is_hdmi) {
 				if (pixel_clock > 340000)
 					return true;
 				else
@@ -244,7 +244,7 @@ bool amdgpu_dig_monitor_is_duallink(struct drm_encoder *encoder,
 			return false;
 		else {
 			/* HDMI 1.3 supports up to 340 Mhz over single link */
-			if (drm_detect_hdmi_monitor(amdgpu_connector_edid(connector))) {
+			if (connector->display_info.is_hdmi) {
 				if (pixel_clock > 340000)
 					return true;
 				else
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index 6134ed964027..a92d86e12718 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -469,7 +469,7 @@ int amdgpu_atombios_encoder_get_encoder_mode(struct drm_encoder *encoder)
 			if (amdgpu_connector->use_digital &&
 			    (amdgpu_connector->audio == AMDGPU_AUDIO_ENABLE))
 				return ATOM_ENCODER_MODE_HDMI;
-			else if (drm_detect_hdmi_monitor(amdgpu_connector_edid(connector)) &&
+			else if (connector->display_info.is_hdmi &&
 				 (amdgpu_connector->audio == AMDGPU_AUDIO_AUTO))
 				return ATOM_ENCODER_MODE_HDMI;
 			else if (amdgpu_connector->use_digital)
@@ -488,7 +488,7 @@ int amdgpu_atombios_encoder_get_encoder_mode(struct drm_encoder *encoder)
 		if (amdgpu_audio != 0) {
 			if (amdgpu_connector->audio == AMDGPU_AUDIO_ENABLE)
 				return ATOM_ENCODER_MODE_HDMI;
-			else if (drm_detect_hdmi_monitor(amdgpu_connector_edid(connector)) &&
+			else if (connector->display_info.is_hdmi &&
 				 (amdgpu_connector->audio == AMDGPU_AUDIO_AUTO))
 				return ATOM_ENCODER_MODE_HDMI;
 			else
@@ -506,7 +506,7 @@ int amdgpu_atombios_encoder_get_encoder_mode(struct drm_encoder *encoder)
 		} else if (amdgpu_audio != 0) {
 			if (amdgpu_connector->audio == AMDGPU_AUDIO_ENABLE)
 				return ATOM_ENCODER_MODE_HDMI;
-			else if (drm_detect_hdmi_monitor(amdgpu_connector_edid(connector)) &&
+			else if (connector->display_info.is_hdmi &&
 				 (amdgpu_connector->audio == AMDGPU_AUDIO_AUTO))
 				return ATOM_ENCODER_MODE_HDMI;
 			else
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index bc58ee29306a..fb33dd0a1f52 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -50,10 +50,12 @@
  *	void
  * */
 enum dc_edid_status dm_helpers_parse_edid_caps(
-		struct dc_context *ctx,
+		struct dc_link *link,
 		const struct dc_edid *edid,
 		struct dc_edid_caps *edid_caps)
 {
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	struct drm_connector *connector = &aconnector->base;
 	struct edid *edid_buf = (struct edid *) edid->raw_edid;
 	struct cea_sad *sads;
 	int sad_count = -1;
@@ -81,8 +83,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 				  edid_caps->display_name,
 				  AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
 
-	edid_caps->edid_hdmi = drm_detect_hdmi_monitor(
-			(struct edid *) edid->raw_edid);
+	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
 	if (sad_count <= 0)
@@ -598,14 +599,8 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		/* We don't need the original edid anymore */
 		kfree(edid);
 
-		/* connector->display_info will be parsed from EDID and saved
-		 * into drm_connector->display_info from edid by call stack
-		 * below:
-		 * drm_parse_ycbcr420_deep_color_info
-		 * drm_parse_hdmi_forum_vsdb
-		 * drm_parse_cea_ext
-		 * drm_add_display_info
-		 * drm_connector_update_edid_property
+		/* connector->display_info is parsed from EDID and saved
+		 * into drm_connector->display_info
 		 *
 		 * drm_connector->display_info will be used by amdgpu_dm funcs,
 		 * like fill_stream_properties_from_drm_display_mode
@@ -613,7 +608,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		amdgpu_dm_update_connector_after_detect(aconnector);
 
 		edid_status = dm_helpers_parse_edid_caps(
-						ctx,
+						link,
 						&sink->dc_edid,
 						&sink->edid_caps);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c798c65d4276..5efe89fe6c2c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3254,7 +3254,7 @@ struct dc_sink *dc_link_add_remote_sink(
 		goto fail_add_sink;
 
 	edid_status = dm_helpers_parse_edid_caps(
-			link->ctx,
+			link,
 			&dc_sink->dc_edid,
 			&dc_sink->edid_caps);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 9ab854293ace..94dc80060610 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -59,7 +59,7 @@ void dm_helpers_free_gpu_mem(
 		void *pvMem);
 
 enum dc_edid_status dm_helpers_parse_edid_caps(
-	struct dc_context *ctx,
+	struct dc_link *link,
 	const struct dc_edid *edid,
 	struct dc_edid_caps *edid_caps);
 
-- 
2.33.0



