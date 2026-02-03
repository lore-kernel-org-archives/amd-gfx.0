Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAC9E83EED
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6581110E4BA;
	Wed,  4 Feb 2026 08:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="InTP80Pw";
	dkim-atps=neutral
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BE7110E743
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:38 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id
 a640c23a62f3a-b8ea0a386cdso1342066b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770144996; x=1770749796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+ZB2qoFB/Khv3mGyMG5d46tlWok9FKjAcvbDsJRp/U=;
 b=InTP80PwOHumYDBytOp544iexTkE1Cd6p/bpYZIcM81M6UrlDOfSPWi8Cu5tqhkqeD
 28A0ieTxouu+GCVE3zH+V1s9o9RKiUf1yHn/YlQStCWGuAsqtAbCBySDPm0V55QGn3bf
 wOwaFD4Ba6+KKcce2GZR522Q2xIkfxMdL39zmZA3ez31zNH3kwqNhtpavM8kgHtYVz1m
 coeRXDOxg5e8l2zjks+h/G+B5RTL2F6NgWV/2/88jNkp9nriferHdtdM+g912uwDa7NQ
 c3/aiv+rl5IeuzJJhgDQN4R/8MN54AFBdW0qxyIgloxyBva6FCqwwa35anRZq8eo756e
 Dudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770144996; x=1770749796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q+ZB2qoFB/Khv3mGyMG5d46tlWok9FKjAcvbDsJRp/U=;
 b=ZLu/4nkIkXE15jDqgWkh4oKuA39X8T2N9DE/aM4K6HgvY36IiM0SjNA9KXlUi+ilAe
 LGBWi3r64UUm7tirmuWEUV17v1CsH3EZxJFatz104+bVQvTYbFTv9zn53Hjj722aO8oV
 L50aaHfCT+H5WPbBIFDubYcYC9UKgUJVJ0OuaAJEL/iHtmZ1Iu4Zo0vGH/F00uc8+tHM
 9SY275XMpFt69I4BleABAtNAkfFV9e6wtBpaXT2WtsV68fuXn+erZ51AeNfRrQVNiReg
 W5BB2p3YCwSeoe2l4KUxWuA709kaByJZdQniCHrqRg/qVVgTL8lcgKO4Vdb45lc5j14z
 /FPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr2r7elJB9bamOPl87tEHHkEAejy2ilABaC3d67K4IIAC6MVPJSKLFOOASIWhpH05ri/FRc1AW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHNAax7coe38etv6tZiL3GonQrzXcpsobmU7Dvj460uYE4CQqw
 DAN/3hhVNfUbkDTSObDawJq1W2GdA2HVtE425ELQigjXDsdrS+mcs02k
X-Gm-Gg: AZuq6aLq7RMX9EatSTKqcFAgjV2dr5nHbjYSAfYyc+bFpniCHVGK1Db9aOR+0Udsgi6
 U8I5UcEoj4rH/bTnQ2+YKL6kd0L6oq8W58u9g+8CL8ls2xHvkUpuAQqy4y6qM8XLJasE8M88NAM
 0jKW0Q9A2SbPbsFWqoJ+xcDDlWnVCgM0msLnj08F6MK6WsfqoXbOdn7Dzfm9+OfeAOrVpoefuLb
 eQxuDYqnVwmqdVrJ/wlN8rAMCOOfTZEryhTB0fgQYXqcuH3HB+HdgCejiyAi219WhI8jJAPAGQV
 saj5LaFZ+bDuNwnUWfc5Nc/IhtGwzIK9mXL1CHw7TK1Wo/TeCHp1H6wSEHYY7f83bwZyHEMWqDL
 ya5FVVR/c43BPG/3PE45ndv8n7i5G03wndvcfuGPxvWnPGrkt7Z93UI7YWaxw1NH2YO0rpvQUpc
 LoPs8CYIpZlIEYakypwb6JRv0rPaFYCtPPOc3ErPFKVQIqKF1NOEzxgOWL5Ym0Sw/v
X-Received: by 2002:a17:907:d78b:b0:b8d:e6d2:6440 with SMTP id
 a640c23a62f3a-b8e9f176cb7mr24148866b.2.1770144996415; 
 Tue, 03 Feb 2026 10:56:36 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:36 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Subject: [PATCH v3 05/19] drm/amd/display: Refactor PCON VRR compatibility
 check
Date: Tue,  3 Feb 2026 19:56:12 +0100
Message-ID: <20260203185626.55428-6-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Feb 2026 08:10:21 +0000
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 39 ++++++-------------
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
 3 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 284f5b326c18..9346b62d981b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13278,7 +13278,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct dpcd_caps dpcd_caps = {0};
 	const struct edid *edid;
 	bool freesync_capable = false;
-	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
+	bool pcon_allowed = false;
+	bool is_pcon = false;
 
 	if (!connector->state) {
 		drm_err(adev_to_drm(adev), "%s - Connector has no state", __func__);
@@ -13306,18 +13307,23 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module || !dc_supports_vrr(sink->ctx->dce_version))
 		goto update;
 
+	/* Gather all data */
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
 	parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
 
-	if (amdgpu_dm_connector->dc_link)
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
@@ -13342,17 +13348,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
 		}
 
+	/* HDMI */
 	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A && vsdb_info.freesync_supported) {
 		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
-	}
 
-	if (amdgpu_dm_connector->dc_link)
-		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
-
-	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST && vsdb_info.freesync_supported) {
+	/* DP -> HDMI PCON */
+	} else if (pcon_allowed && vsdb_info.freesync_supported) {
+		amdgpu_dm_connector->as_type = FREESYNC_TYPE_PCON_IN_WHITELIST;
 		amdgpu_dm_connector->pack_sdp_v1_3 = true;
-		amdgpu_dm_connector->as_type = as_type;
 		amdgpu_dm_connector->vsdb_info = vsdb_info;
 
 		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 1f41d6540b83..45a91df619d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1381,40 +1381,25 @@ void dm_helpers_dp_mst_update_branch_bandwidth(
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
index 7014b8c2c956..e51f1e489129 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -220,10 +220,10 @@ int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
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

