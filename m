Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239CBCA6011
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE2310E3BA;
	Mon, 19 Jan 2026 08:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="McJSTm2y";
	dkim-atps=neutral
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B3710E303
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:11:57 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id
 a640c23a62f3a-b86ff9ff9feso39037266b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785116; x=1769389916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/+mgz8tz1oq1jAsf41mu+R3jbahLDvbH8hDJMkGxqs=;
 b=McJSTm2yfBa/a8idzZVTqnFpIFkhrm3TeSfzbO2ZeAouGUMybFn+ptqDvvQAADsV0L
 H79dH1aNn5mowzQXbY6d5d5urXE+/RlA6ZIoEmmkdH9utn6gvS/3Ld6n2A37BJ8BBg2P
 brZNYxfvoIZcfjpBbqSruXv/K1dyVRDKyRuOxGN+m1dVhBUrtWLZHpQToPKl9BBAMVjW
 cm6OINlHBYbTAyOiD3Lv+HplyOTbfO/UPlW0jg89ggxwdQf7Lb4kUeIQV77UTz4TPgE8
 9mn29Th3AT7bieQ4Y6r0RNkSeONbk8YRCWT8Gzm5Nbt35RnikrXjLorjoX+NfEdYPWi4
 DCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785116; x=1769389916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O/+mgz8tz1oq1jAsf41mu+R3jbahLDvbH8hDJMkGxqs=;
 b=u4SeSsqzhgT9pF5xNbFNhaaREEIkU7CPwjEj4SaA4/89VKt1k3r//OFTlzoHMmOXix
 SHuE0W6Y9KZoIrbqSMdc8GK4B8o+6SSFfRBpgXFcGYrHiSr2pV8rmwDYuuX7T9HYPUQY
 8U2q8GKZDMTOl/kNtl0AkNjxtcazQRGWdHK831ogop6TDzIgjBynPdarvaU1rS5pL3yo
 7XI0ZhzapoWCOa8muTdFLpRQL8Le6niia55scQjlbm4XhJiGqY79iuUx5QcVX35tuFp/
 gNLj5o6GswsoFP311Tj8htphQZTwUMMThD7euYSLUNmCaI0yhAX0ssKTpHawN6eiuHyE
 OMUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURzdkMwHKXEzhojiEh3NcVuPpSdbuFYhUhJCtmbdRZ1749GX4UwdDsvxIzcsweLwUryEx5ukGx@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxjf681BfYbCMIfID9G54nRszaRTtgxwDWnhMJyHEGJJFdNHEKS
 lbI+DpyqKt2/gmu38TAi+FoSfHf3Mo21c+Jy1MCLyqiHC55C45ST4aHT
X-Gm-Gg: AY/fxX57p27p3Qk+EhQZ+U84XXESzUnutTuG+5fRnnJa1Kb7XeBVSUWFtacMZ/E56UX
 lOO2656O52tfax5dgTlaB2k65bHihLeSsqq0Ms4Fq2dPJRY9nxmka4jHHtnqp/dxyljm4A4qtuE
 yNs1vEsZhlneDsy9VllrkewQQTcVzrmyazbpkkcLbP2PjGXit5H5hpBPRtj2P3okg6hZ6DuZAZC
 R02sFRcVy5Iq6ZIVf8ZWOkegwaNNGewmN8SE/MzV3YS+5QRQhXD8JV7IMX98Z6bShTWpFp0vfka
 Akto0Fyy2G/4ONt3fNILLk3uNIDKRld7fgMG3mHVA5RQLa5r3zx7G4WaAv5d8mVBMsdKzxXmO0m
 W5Th19+VzoUx1IIHubZ6rI5UIt0Memf07PFxjMnBYB2F9TD98qP3HtMOcwNbPEINnZsDSktZ+8o
 NuX4nV5t1wYeqNhCqz9r3Xz1wvQ7ugxyAEQfHh2asWpq2TWwFV0xz65NoOHldNJvds
X-Received: by 2002:a05:6402:5114:b0:64b:45db:3624 with SMTP id
 4fb4d7f45d1cf-654529d2140mr4486900a12.3.1768785116317; 
 Sun, 18 Jan 2026 17:11:56 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:11:55 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 05/17] drm/amd/display: Refactor PCON VRR compatibility check
Date: Mon, 19 Jan 2026 02:11:34 +0100
Message-ID: <20260119011146.62302-6-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Jan 2026 08:18:28 +0000
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
DP->HDMI PCONs prevously entered the DP path

[How]
Restructure amdgpu_dm_update_freesync_caps() and move
dm_get_adaptive_sync_support_type() to dm_helpers_is_vrr_pcon_allowed()
to better reflect what this function does. It never actually gave us any
other info.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 +++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 39 ++++++-------------
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
 3 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 37ab89532408..662f51faf949 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13242,7 +13242,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	bool freesync_capable = false;
 	bool valid_vsdb_cea = false;
 	bool vsdb_freesync = false;
-	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
+	bool pcon_allowed = false;
+	bool is_pcon = false;
 
 	if (!connector->state) {
 		drm_err(adev_to_drm(adev), "%s - Connector has no state", __func__);
@@ -13270,18 +13271,24 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module || !dc_supports_vrr(sink->ctx->dce_version))
 		goto update;
 
+	/* Gather all data */
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
 	valid_vsdb_cea = parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info) >= 0;
 	vsdb_freesync = valid_vsdb_cea && vsdb_info.freesync_supported;
-	if (amdgpu_dm_connector->dc_link)
+
+	if (amdgpu_dm_connector->dc_link) {
 		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
+		is_pcon = dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+		pcon_allowed = dm_helpers_is_vrr_pcon_allowed(amdgpu_dm_connector->dc_link);
+	}
 
 	/* Some eDP panels only have the refresh rate range info in DisplayID */
 	if (is_monitor_range_invalid(connector))
 		parse_edid_displayid_vrr(connector, edid);
 
-	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
-	    sink->sink_signal == SIGNAL_TYPE_EDP) {
+	/* DP & eDP excluding PCONs */
+	if ((sink->sink_signal == SIGNAL_TYPE_EDP ||
+	     sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) && !is_pcon) {
 		/*
 		 * Many monitors expose AMD vsdb in CAE even for DP and their
 		 * monitor ranges do not contain Range Limits Only flag
@@ -13306,17 +13313,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
 		}
 
+	/* HDMI */
 	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A && vsdb_freesync) {
 		monitor_range_from_vsdb(connector, &vsdb_info);
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
-	}
 
-	if (amdgpu_dm_connector->dc_link)
-		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
-
-	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST && vsdb_freesync) {
+	/* DP -> HDMI PCON */
+	} else if (pcon_allowed && vsdb_freesync) {
+		amdgpu_dm_connector->as_type = FREESYNC_TYPE_PCON_IN_WHITELIST;
 		amdgpu_dm_connector->pack_sdp_v1_3 = true;
-		amdgpu_dm_connector->as_type = as_type;
 		amdgpu_dm_connector->vsdb_info = vsdb_info;
 
 		monitor_range_from_vsdb(connector, &vsdb_info);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index e5e993d3ef74..76a10fe8d545 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1375,40 +1375,25 @@ void dm_helpers_dp_mst_update_branch_bandwidth(
 	// TODO
 }
 
-static bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id)
+bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link)
 {
-	bool ret_val = false;
+	if (link->dpcd_caps.dongle_type != DISPLAY_DONGLE_DP_HDMI_CONVERTER)
+		return false;
 
-	switch (branch_dev_id) {
+	if (!link->dpcd_caps.allow_invalid_MSA_timing_param)
+		return false;
+
+	if (!link->dpcd_caps.adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT)
+		return false;
+
+	switch (link->dpcd_caps.branch_dev_id) {
 	case DP_BRANCH_DEVICE_ID_0060AD:
 	case DP_BRANCH_DEVICE_ID_00E04C:
 	case DP_BRANCH_DEVICE_ID_90CC24:
-		ret_val = true;
-		break;
-	default:
-		break;
+		return true;
 	}
 
-	return ret_val;
-}
-
-enum adaptive_sync_type dm_get_adaptive_sync_support_type(struct dc_link *link)
-{
-	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
-	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
-
-	switch (dpcd_caps->dongle_type) {
-	case DISPLAY_DONGLE_DP_HDMI_CONVERTER:
-		if (dpcd_caps->adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT == true &&
-			dpcd_caps->allow_invalid_MSA_timing_param == true &&
-			dm_is_freesync_pcon_whitelist(dpcd_caps->branch_dev_id))
-			as_type = FREESYNC_TYPE_PCON_IN_WHITELIST;
-		break;
-	default:
-		break;
-	}
-
-	return as_type;
+	return false;
 }
 
 bool dm_helpers_is_fullscreen(struct dc_context *ctx, struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 9d160b39e8c5..f8b45a09d680 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -219,10 +219,10 @@ int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
 		const struct dc_link *link,
 		struct set_config_cmd_payload *payload,
 		enum set_config_status *operation_result);
-enum adaptive_sync_type dm_get_adaptive_sync_support_type(struct dc_link *link);
 
 enum dc_edid_status dm_helpers_get_sbios_edid(struct dc_link *link, struct dc_edid *edid);
 
+bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link);
 bool dm_helpers_is_fullscreen(struct dc_context *ctx, struct dc_stream_state *stream);
 bool dm_helpers_is_hdr_on(struct dc_context *ctx, struct dc_stream_state *stream);
 
-- 
2.52.0

