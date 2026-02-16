Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D67E68153
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECDF510E492;
	Tue, 17 Feb 2026 08:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jSs7Jroa";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D578410E0EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:23 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b8f7fd33bd2so48120566b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260322; x=1771865122; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnYsqKjwkdi7cukTOBwMkwqlRWnCwHpOCDkCCBv/1xY=;
 b=jSs7JroaqUBRRLP//N5/jXaTO+xM0khHoMP5ovm43NctaJYmR/TRC1vDlzyxnKstBp
 En0asybKh5iKsSxRxykKp7nXvUK9Fe0acVPfleVMLTXrcgZYlahk8aejgxDp5y41XiDw
 KkfxZUy0WxAp13h/COw4Kc0b+Ddyeug/DTcYy2nQ4GHMdcK4oqc/AYNQRtuwL23BhzNt
 lbByGD8NIidQZ9dgK/GKcOETC6F9+7aaJZj9M5c3i0vyglpIMR89YyIOVXUzXl1n5PE7
 wJCdmKgcdYidPK7GLwi4Ge0XaCBlsFFmNgaFEZmhfZCz9j8QrPUyXlHYNCQI8f9aXaT+
 k/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260322; x=1771865122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZnYsqKjwkdi7cukTOBwMkwqlRWnCwHpOCDkCCBv/1xY=;
 b=E47bv5I/Rf6RopU7BXA2jKfrTsmf1bu0naLr1I/29njLf/ao8IoZ69iNHuC9v0ScXH
 RBvvcVZ2LEiAR963nYlzHc/c7zWrgr3Q3jgGNqxihEbgE52f7QhMubBOaoto7tSHygsY
 DeIGIxDa4AdncbkFedKkpeqU7QpiQG8pyql/AFuHUfSHPJL8cXmqcY5flzQyWZS9MMjf
 2cpiF5FQbwdw7k0bYNm5EDlzKnf2BvYveaq4tXeeI/gY8MPbU1sP7VFEdwI5STNi6QmZ
 Ry/atwajx7d9ndmKMrtePsdxUJt7ce/swtWq8l+9uQRgVvEhQKhMrkTBE7PqJjZWkMKR
 DLmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0yXfMOrV2g0klX97qv/HRK9zRrdB983IPZuqU7B4om6clTqWzMPAXes2PDhk56bkBJJSRz7fp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTUIyr/2Ef4oDbpRBeREH7yFdbarOs1pl4ibwthCaemqOqsWfp
 InlSM3TsNHUmzjR7o+8qSbxYLezTJPVSS3j0jAlviLQY3UxFK4g9lVrh
X-Gm-Gg: AZuq6aJnclpETd3BWn2I/WT5X+FYzYPUM8lHML8zn+SPx/PZtRKXYcOGPWX7BCwqVdJ
 IM4XEGfn2p87qr/Xq3AvNhyqfT2/RUdgmqHunhcAIFs9uP+XtV87YUySAKubzg5v3aor6r/yPpd
 tuDFTeDR014X4Yke91VZj00oWdlJxTDcd25TVf3DRDfd1oXVcvjs+h6a3TSlq/B5GbQh+sHNbVK
 DqmlNQPcqc5uG+A/Q5QNDgiTFfh20kwJIVUH6/VqLiLaljIzRVLxcrsjy8YRwvg7nglZB6wPPwV
 wRT+rHwkWMCF6u29QrIgNL3Xq7DTwghVwJl2BBQ+sU0TFMlMZlAZyLUcGb8wM5Y0l8KiYeQfa2g
 3q5sIfJ8f9BuAVQBLS2hf6BxUHHgfaidYmJAiXz5oiwEe7PtyDBV4urt4u1mF888aY/bxgMfTLa
 TsFZOc1L6Z19iBGi0RENm541LCffSyZn1n9Hl8xnviEmjTQx5qyiV+w7sCsaMlqP+VQfjy2YB29
 04P
X-Received: by 2002:a17:907:3e88:b0:b73:59b0:34c6 with SMTP id
 a640c23a62f3a-b8face510e0mr348057966b.4.1771260321971; 
 Mon, 16 Feb 2026 08:45:21 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:21 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 02/27] drm/amd/display: Refactor
 amdgpu_dm_update_freesync_caps()
Date: Mon, 16 Feb 2026 17:44:51 +0100
Message-ID: <20260216164516.36803-3-tomasz.pakula.oficjalny@gmail.com>
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
This function started to get very messy and hard to follow.

[How]
Eject some functionality to separate functions and simplify greatly.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 110 +++++++++++-------
 1 file changed, 69 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2d770ed98871..6218ad911fde 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13144,8 +13144,8 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
 	}
 }
 
-static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
-			  const struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
+static int parse_amd_vsdb_did(struct amdgpu_dm_connector *aconnector,
+			      const struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	u8 *edid_ext = NULL;
 	int i;
@@ -13199,13 +13199,13 @@ static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 	return false;
 }
 
-static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
+static bool parse_amd_vsdb_cea(struct amdgpu_dm_connector *aconnector,
 			       const struct edid *edid,
 			       struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
+	struct amdgpu_hdmi_vsdb_info vsdb_local = {0};
 	u8 *edid_ext = NULL;
 	int i;
-	bool valid_vsdb_found = false;
 
 	/*----- drm_find_cea_extension() -----*/
 	/* No EDID or EDID extensions */
@@ -13226,9 +13226,47 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 	if (edid_ext[0] != CEA_EXT)
 		return -ENODEV;
 
-	valid_vsdb_found = parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, vsdb_info);
+	if (!parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, &vsdb_local))
+		return -ENODEV;
 
-	return valid_vsdb_found ? i : -ENODEV;
+	*vsdb_info = vsdb_local;
+	return false;
+}
+
+static bool is_monitor_range_invalid(const struct drm_connector *conn)
+{
+	return conn->display_info.monitor_range.min_vfreq == 0 ||
+	       conn->display_info.monitor_range.max_vfreq == 0;
+}
+
+/*
+ * Returns true if (max_vfreq - min_vfreq) > 10
+ */
+static bool is_freesync_capable(const struct drm_monitor_range_info *range)
+{
+	return (range->max_vfreq - range->min_vfreq) > 10;
+}
+
+static void monitor_range_from_vsdb(struct drm_display_info *display,
+				    const struct amdgpu_hdmi_vsdb_info *vsdb)
+{
+	display->monitor_range.min_vfreq = vsdb->min_refresh_rate_hz;
+	display->monitor_range.max_vfreq = vsdb->max_refresh_rate_hz;
+}
+
+/*
+ * Returns true if connector is capable of freesync
+ * Optionally, can fetch the range from AMD vsdb
+ */
+static bool copy_range_to_amdgpu_connector(struct drm_connector *conn)
+{
+	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(conn);
+	struct drm_monitor_range_info *range = &conn->display_info.monitor_range;
+
+	aconn->min_vfreq = range->min_vfreq;
+	aconn->max_vfreq = range->max_vfreq;
+
+	return is_freesync_capable(range);
 }
 
 /**
@@ -13245,13 +13283,14 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				    const struct drm_edid *drm_edid)
 {
-	int i = 0;
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 			to_amdgpu_dm_connector(connector);
 	struct dm_connector_state *dm_con_state = NULL;
 	struct dc_sink *sink;
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
+	struct amdgpu_hdmi_vsdb_info vsdb_did = {0};
+	struct dpcd_caps dpcd_caps = {0};
 	const struct edid *edid;
 	bool freesync_capable = false;
 	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
@@ -13284,60 +13323,49 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
 
+	if (amdgpu_dm_connector->dc_link)
+		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
+
 	/* Some eDP panels only have the refresh rate range info in DisplayID */
-	if ((connector->display_info.monitor_range.min_vfreq == 0 ||
-	     connector->display_info.monitor_range.max_vfreq == 0))
+	if (is_monitor_range_invalid(connector))
 		parse_edid_displayid_vrr(connector, edid);
 
 	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
 		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
-		if (amdgpu_dm_connector->dc_link &&
-		    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_param) {
-			amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
-			amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
-			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
-				freesync_capable = true;
-		}
 
-		parse_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
+		if (dpcd_caps.allow_invalid_MSA_timing_param)
+			freesync_capable = copy_range_to_amdgpu_connector(connector);
 
-		if (vsdb_info.replay_mode) {
-			amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_info.replay_mode;
-			amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
+		/* eDP */
+		parse_amd_vsdb_did(amdgpu_dm_connector, edid, &vsdb_did);
+		if (vsdb_did.replay_mode) {
+			amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_did.replay_mode;
+			amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_did.amd_vsdb_version;
 			amdgpu_dm_connector->as_type = ADAPTIVE_SYNC_TYPE_EDP;
 		}
 
-	} else if (drm_edid && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
-		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
-		if (i >= 0 && vsdb_info.freesync_supported) {
-			amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
-			amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
-			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
-				freesync_capable = true;
-
-			connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
-			connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
+	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
+		   drm_edid) {
+		parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
+		if (vsdb_info.freesync_supported) {
+			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+			freesync_capable = copy_range_to_amdgpu_connector(connector);
 		}
 	}
 
 	if (amdgpu_dm_connector->dc_link)
 		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
-	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
-		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
-		if (i >= 0 && vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
-
+	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST && drm_edid) {
+		parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
+		if (vsdb_info.freesync_supported) {
 			amdgpu_dm_connector->pack_sdp_v1_3 = true;
 			amdgpu_dm_connector->as_type = as_type;
 			amdgpu_dm_connector->vsdb_info = vsdb_info;
 
-			amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
-			amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
-			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
-				freesync_capable = true;
-
-			connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
-			connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
+			parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
+			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+			freesync_capable = copy_range_to_amdgpu_connector(connector);
 		}
 	}
 
-- 
2.53.0

