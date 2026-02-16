Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D75E63F29
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C6B10E475;
	Tue, 17 Feb 2026 08:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kyi2wZhK";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCCBA10E3DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:56 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b8fa19e6186so64127266b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260355; x=1771865155; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Q1lJwLmcWJWoDUb++cAchh6MvBOjQlKFX7ixOTz8S8=;
 b=kyi2wZhKuYVdIkL+Zg7BshrPJqQ9AYrOvHDrGmECh0DTecNbzy/UQTSLF6yA+rA9jM
 oV8FFO8693PAiJkX0VM6Af5URRDaEZ9O2AVHlv/SEzVMTPxFd4ibvwekYO3eY6bLhHFI
 XfUIHSvDnLxE2hMQKyNpBEolZMPt2eROeGfieVHZEBsYIEJGhsfsuG2ExX0F+NnHDEA9
 2xRE/1AnI03nxYsaBcasdcS1kQHbIrP5Gyguifclqs9db0PerKdskqNoA4fSaG5STjCh
 WbxC34rWqvOJZfp+JeQFzUfRpG3/xO95AXWg71/Ymi/wkWx/IGIR++N1n4jZkhylxf2h
 44oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260355; x=1771865155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Q1lJwLmcWJWoDUb++cAchh6MvBOjQlKFX7ixOTz8S8=;
 b=oyqNoWKI0BJJwgrNyC/E+b4r6H1Jw2a3l0pP1uuAKw6gRC76wW7cGYYtx/WnG5fD5g
 vUrj4LApcNoHFk7yfL1byDy7YUtxn6ryxCtymg3QUjKaVEW2VazhFqS9jCLSbR63RDC1
 Crt42SWNiTzz/SMbM9XpFoUDQJOCtfqZ9XrodWTpvuX3EqoidijMf6NCtGn+hMoYbv1q
 J0C16uvDs74ddCisv0LCiALtGHrgsst9eaZs7VFaCmduozEhPSenZoMghRBgzjQ9zN2T
 WXA9PBwRQip84YqOi2TplWvjlv6k0iTKBFRahCjpbRUHAl4KRtsZ67M9ehREQRfbiSvM
 hfIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTDfbzTBdClRHb0iX92jeUeTFvS1tI92xMCkXGGVotdBRDYTWXl4hBrvqTkekc3yOxwizvApO5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyomUzwm5/gELb+u6p+9REp8ZJNyfAMyBjZ9kGA8n5k0/FsR9bs
 DGXHNe8ZVJSLI7DNJFGN47sRAQdlHgvp4PJpspC1igkPm/g0yLea+ZRvegLScg==
X-Gm-Gg: AZuq6aKixERntBms/q+3VbufcM6C9olzjkXnRCuWtwSOlqQzVfKnCicEAzaucDpWAUb
 t95EdqNwX4p7qLmSbLBCca5bqoXP/r3G+iKG/yHnOxAA/ae833v0RdPfdzWe57jGZHiLKiOx1Vj
 wCzLAnSFVyMmvA/515kjfizudbWXYOBaVMk+ZqTiQY+QGa9heatGX6p+z9kgBeOWzq9XZuiyQgW
 6Ym/QvuPYKJulfq3rCyOTqrKLnTO6lUYg156mfXIX/sNMsWx88BV1KeumZymvpsXSM0EywzDL9e
 fQkNaKKZpKQDMNwP9jl8yIGcbEn0V44kv+AGwzzSu1Ympoo9GxtEDLiItlAE9EAgiPs9m9YBf5L
 loX9LsKEwO8Wb4DOM9nQxPXHi3ZN7Onrnx+ghFRBbSwZyOBAvWct+Fm5dbZqDlgiMkOJOByTIY6
 B84zT69eRRpE6Yy+d22JlpQwmYtWeHH7yVhN2fWPalZylqSGCUfP3gYLhCF7SBPmL+TN5Jcn0fX
 uo9
X-Received: by 2002:a17:907:3da0:b0:b87:2780:1b2b with SMTP id
 a640c23a62f3a-b8facd9eeb2mr384160566b.4.1771260355157; 
 Mon, 16 Feb 2026 08:45:55 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:54 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 27/27] drm/amd/display: Use ALLM properties in amdgpu
Date: Mon, 16 Feb 2026 17:45:16 +0100
Message-ID: <20260216164516.36803-28-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 08:05:08 +0000
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

[Why]
To enable ALLM when asked for by compositor

[How]
Attach properties to HDMI sinks, detect support and set allm_capable
property, set allm_capable property for amdgpu_dm_connector

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 54 ++++++++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  3 ++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +
 .../display/modules/info_packet/info_packet.c |  4 +-
 6 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 41677c50b3d2..695100c78314 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8969,6 +8969,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	aconnector->audio_inst = -1;
 	aconnector->pack_sdp_v1_3 = false;
 	aconnector->as_type = ADAPTIVE_SYNC_TYPE_NONE;
+	aconnector->hdmi_allm_capable = false;
 	memset(&aconnector->vsdb_info, 0, sizeof(aconnector->vsdb_info));
 	mutex_init(&aconnector->hpd_lock);
 	mutex_init(&aconnector->handle_mst_msg_ready);
@@ -9166,6 +9167,10 @@ int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector)
 	struct drm_device *ddev = aconnector->base.dev;
 	struct device *hdmi_dev = ddev->dev;
 
+	/* ALLM */
+	drm_connector_attach_allm_capable_property(&aconnector->base);
+	drm_connector_attach_allm_mode_property(&aconnector->base);
+
 	if (amdgpu_dc_debug_mask & DC_DISABLE_HDMI_CEC) {
 		drm_info(ddev, "HDMI-CEC feature masked\n");
 		return -EINVAL;
@@ -10856,6 +10861,31 @@ static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_state *state)
 	return 0;
 }
 
+static void update_allm_state_on_crtc_stream(struct dm_crtc_state *new_crtc_state,
+					     const struct drm_connector_state *new_conn)
+{
+	struct mod_freesync_config *config = &new_crtc_state->freesync_config;
+	struct dc_stream_state *new_stream = new_crtc_state->stream;
+	bool allm_active = false;
+
+	switch (new_conn->allm_mode) {
+	case DRM_ALLM_MODE_ENABLED_DYNAMIC:
+		allm_active = config->state == VRR_STATE_ACTIVE_VARIABLE ||
+			      new_stream->content_type == DISPLAY_CONTENT_TYPE_GAME;
+		break;
+
+	case DRM_ALLM_MODE_ENABLED_FORCED:
+		allm_active = true;
+		break;
+
+	case DRM_ALLM_MODE_DISABLED:
+	default:
+		allm_active = false;
+	}
+
+	new_stream->hdmi_allm_active = allm_active;
+}
+
 /**
  * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
  * @state: The atomic state to commit
@@ -10898,12 +10928,14 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct dm_connector_state *dm_old_con_state = to_dm_connector_state(old_con_state);
+		struct amdgpu_dm_connector *dm_conn = to_amdgpu_dm_connector(connector);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
 		struct dc_surface_update *dummy_updates;
 		struct dc_stream_update stream_update;
 		struct dc_info_packet hdr_packet;
 		struct dc_stream_status *status = NULL;
 		bool abm_changed, hdr_changed, scaling_changed, output_color_space_changed = false;
+		bool allm_changed = false;
 
 		memset(&stream_update, 0, sizeof(stream_update));
 
@@ -10933,7 +10965,11 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		hdr_changed =
 			!drm_connector_atomic_hdr_metadata_equal(old_con_state, new_con_state);
 
-		if (!scaling_changed && !abm_changed && !hdr_changed && !output_color_space_changed)
+		allm_changed = dm_conn->hdmi_allm_capable &&
+			       (new_con_state->allm_mode != old_con_state->allm_mode);
+
+		if (!scaling_changed && !abm_changed && !hdr_changed &&
+		    !output_color_space_changed && !allm_changed)
 			continue;
 
 		stream_update.stream = dm_new_crtc_state->stream;
@@ -10963,6 +10999,17 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			stream_update.hdr_static_metadata = &hdr_packet;
 		}
 
+		if (allm_changed) {
+			update_allm_state_on_crtc_stream(dm_new_crtc_state, new_con_state);
+			mod_build_hf_vsif_infopacket(dm_new_crtc_state->stream,
+				&dm_new_crtc_state->stream->hfvsif_infopacket);
+
+			stream_update.hdmi_allm_active =
+				&dm_new_crtc_state->stream->hdmi_allm_active;
+			stream_update.hfvsif_infopacket =
+				&dm_new_crtc_state->stream->hfvsif_infopacket;
+		}
+
 		status = dc_stream_get_status(dm_new_crtc_state->stream);
 
 		if (WARN_ON(!status))
@@ -13478,6 +13525,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	if (connector->passive_vrr_capable_property)
 		drm_connector_set_passive_vrr_capable_property(connector, freesync_on_desktop);
+
+	amdgpu_dm_connector->hdmi_allm_capable = connector->display_info.hdmi.allm;
+	if (connector->allm_capable_property)
+		drm_connector_set_allm_capable_property(
+			connector, connector->display_info.hdmi.allm);
 }
 
 void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 88ec2b88dcaf..b9d27a483b1e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -847,6 +847,9 @@ struct amdgpu_dm_connector {
 	unsigned int hdmi_hpd_debounce_delay_ms;
 	struct delayed_work hdmi_hpd_debounce_work;
 	struct dc_sink *hdmi_prev_sink;
+
+	/* HDMI ALLM */
+	bool hdmi_allm_capable;
 };
 
 static inline void amdgpu_dm_set_mst_status(uint8_t *status,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 17ba7af0ddcd..bfaa2fb0cba8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3295,6 +3295,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->vrr_active_fixed)
 		stream->vrr_active_fixed = *update->vrr_active_fixed;
 
+	if (update->hdmi_allm_active)
+		stream->hdmi_allm_active = *update->hdmi_allm_active;
+
 	if (update->crtc_timing_adjust) {
 		if (stream->adjust.v_total_min != update->crtc_timing_adjust->v_total_min ||
 			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max ||
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 639831295b21..078ca4a7258f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4660,7 +4660,7 @@ static void set_avi_info_frame(
 		vic = 0;
 	format = stream->timing.timing_3d_format;
 	/*todo, add 3DStereo support*/
-	if (format != TIMING_3D_FORMAT_NONE) {
+	if (format != TIMING_3D_FORMAT_NONE || stream->hdmi_allm_active) {
 		// Based on HDMI specs hdmi vic needs to be converted to cea vic when 3D is enabled
 		switch (pipe_ctx->stream->timing.hdmi_vic) {
 		case 1:
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 9960494007ff..17f891b03416 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -242,6 +242,7 @@ struct dc_stream_state {
 	bool vrr_active_variable;
 	bool freesync_on_desktop;
 	bool vrr_active_fixed;
+	bool hdmi_allm_active;
 
 	bool converter_disable_audio;
 	uint8_t qs_bit;
@@ -345,6 +346,7 @@ struct dc_stream_update {
 	bool *allow_freesync;
 	bool *vrr_active_variable;
 	bool *vrr_active_fixed;
+	bool *hdmi_allm_active;
 
 	struct colorspace_transform *gamut_remap;
 	enum dc_color_space *output_color_space;
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 7e0adb90af39..fcfab7b9e0e2 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -500,7 +500,7 @@ static bool is_hdmi_vic_mode(const struct dc_stream_state *stream)
 	if (stream->view_format != VIEW_3D_FORMAT_NONE)
 		return false;
 
-	if (stream->link->local_sink->edid_caps.allm)
+	if (stream->hdmi_allm_active)
 		return false;
 
 	return true;
@@ -529,7 +529,7 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 
 		info_packet->valid = false;
 
-		allm = stream->link->local_sink->edid_caps.allm;
+		allm = stream->hdmi_allm_active;
 		format = stream->view_format == VIEW_3D_FORMAT_NONE ?
 			 TIMING_3D_FORMAT_NONE :
 			 stream->timing.timing_3d_format;
-- 
2.53.0

