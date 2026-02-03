Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0FDE83EFE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA5210E53E;
	Wed,  4 Feb 2026 08:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LM2VQWbD";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E0A10E741
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:33 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b8864618c99so61958866b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770144992; x=1770749792; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2t7zmxZ0V/ra2TNj4y1ls2+nk6Mu20D0VPdmpFC7/A=;
 b=LM2VQWbDeiCsXXMtF7jRb6l+5HfMg6uDJrdAQGdgeOkqsAJ0j1hBMafHEPlGYqopXJ
 sT3Maud5I13OjdG1BmPQuetE/s4jsyTbsUT2FgIrpocUEuqQmvl6GJyBC7IMwIlVgykc
 FkItMubvTXeEp6CCgqx+u8hlwyVZx44YyNmL2DaDBnsSwp95GXjcbcacX9jbgX7bGOsS
 +LsG/4QavCeZRvFLCX/ISYAIcQhVaIqhLsyWGs74Glc8/Rbv1eVb4fj0Akfzi/IQGYFa
 lMWhqeJzs/YI7upQotHf85U3k3nzvBaqQ9X1mUSvIiTWeOxOE1UzcJsTcv5FTOqQyQD7
 hQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770144992; x=1770749792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p2t7zmxZ0V/ra2TNj4y1ls2+nk6Mu20D0VPdmpFC7/A=;
 b=Jp6hs6Zd6zMX6edUA9vYEbvTN1htbPGh9dlMWO5H2u0Kt7qHfRn4bDln4dPI1SKWFZ
 7nIcMxkZ3zd+venQ0raYucJ0E8wmkkHWvVyY6vqjOYBbaZeSYUGw7P7zdXIaTytjMNNd
 5SAZjoNIjI7pq8jYkSPRsHiWtpk+1/8arHqJUT1FJX0mvvm9cXfG0Znv1OvhAE/9GzjZ
 iD7Yv2kg9yJWNfLnd+W9CFBWrDUzQTGh77IhaeWgk08AJiKcM+AM0tSzKvIb/8iML/o+
 PZh5SGoXfjjuRgQNOMyF6OhM0ihalv2OkWriVpLBzqvH1wt6eOylEUxU/T9k7Gmbv4Zv
 Uivw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcfidXxJM4VMza4alvdDGOP41NeG+96Y9MQAB8gfKJQFrhTJz1kVLKFbhNSZHLPfs2hP0fZ/Sp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxU+tASkgKCNcUizWxz5UmiAwRla9H4ZueeD2B/ZO5LiRK+Vu6
 Bo4J8cwj39/DZ6G4JxeJcjkFwGx+3dI/vSOY7an+d0esLovZAJoRvrcK
X-Gm-Gg: AZuq6aKLFS+qDcHTLad7656c8g0XpJ9qWTnTf2LdBF92UD+qUXRB+z/FmFv3tE01Q9x
 +8dF68X6sB6OomBY2AWwUGUTryqy+NlQ8AA8GXUeuOS7wTqpCE0hr8k8dBE+Iox2rxhDT0uwX/e
 uuG2ILjiPBBvXmG14Ao3z+WQjDE8+Bkt/TQIqgva7///hi0xQcJWLULzysO2vYhuSEHmShY7tBS
 A8YE5OM9gpj/j6NEWp8065TDLj4Zpf09yvJkxqFDn8BCQ/mKKmMZQkJktJzVMDcTmhDe3FWrEop
 +jJ2TaOzVzf7DV7GDbwB9bazY3zShxiNUlQd1OW67kuNosDdoPKNS6OEUiXqOafbbHIdjLEWZo2
 gvoaGnRA3TwjXtXbMDwCeARr/SpiG1Jif3eNQ3DDa3C0qYWwoBhYcDhgHHvUIRHkk82fyYvo6kK
 We2+yhAuCPsw07P837EvCAyzGutUssdCsfH5pXC/JNXh2sfRbN6EAb4He3Fg7/m9w4
X-Received: by 2002:a17:906:9f85:b0:b87:2681:f608 with SMTP id
 a640c23a62f3a-b8e9f644b9bmr16634366b.8.1770144991764; 
 Tue, 03 Feb 2026 10:56:31 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:31 -0800 (PST)
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
Subject: [PATCH v3 02/19] drm/amd/display: Refactor
 amdgpu_dm_update_freesync_caps()
Date: Tue,  3 Feb 2026 19:56:09 +0100
Message-ID: <20260203185626.55428-3-tomasz.pakula.oficjalny@gmail.com>
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
This function started to get very messy and hard to follow.

[How]
Eject some functionality to separate functions and simplify greatly.

Changes in v3:
- Less struct traversal in helper functions

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 123 +++++++++++-------
 1 file changed, 73 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 29e4a047b455..2c5877ed5f32 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13119,8 +13119,8 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
 	}
 }
 
-static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
-			  const struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
+static int parse_amd_vsdb_did(struct amdgpu_dm_connector *aconnector,
+			      const struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	u8 *edid_ext = NULL;
 	int i;
@@ -13172,13 +13172,13 @@ static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 	return false;
 }
 
-static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
-			       const struct edid *edid,
-			       struct amdgpu_hdmi_vsdb_info *vsdb_info)
+static int parse_amd_vsdb_cea(struct amdgpu_dm_connector *aconnector,
+			      const struct edid *edid,
+			      struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
+	struct amdgpu_hdmi_vsdb_info vsdb_local = {0};
 	u8 *edid_ext = NULL;
 	int i;
-	bool valid_vsdb_found = false;
 
 	/*----- drm_find_cea_extension() -----*/
 	/* No EDID or EDID extensions */
@@ -13199,9 +13199,47 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 	if (edid_ext[0] != CEA_EXT)
 		return -ENODEV;
 
-	valid_vsdb_found = parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, vsdb_info);
+	if (!parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, &vsdb_local))
+		return -ENODEV;
 
-	return valid_vsdb_found ? i : -ENODEV;
+	*vsdb_info = vsdb_local;
+	return i;
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
@@ -13218,13 +13256,14 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
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
@@ -13256,62 +13295,46 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		goto update;
 
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
+	parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
+
+	if (amdgpu_dm_connector->dc_link)
+		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
 
 	/* Some eDP panels only have the refresh rate range info in DisplayID */
-	if ((connector->display_info.monitor_range.min_vfreq == 0 ||
-	     connector->display_info.monitor_range.max_vfreq == 0))
+	if (is_monitor_range_invalid(connector))
 		parse_edid_displayid_vrr(connector, edid);
 
-	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
-		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
-		if (amdgpu_dm_connector->dc_link &&
-		    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_param) {
-			amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
-			amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
-			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
-				freesync_capable = true;
-		}
+	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
+	    sink->sink_signal == SIGNAL_TYPE_EDP) {
 
-		parse_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
+		if (dpcd_caps.allow_invalid_MSA_timing_param)
+			freesync_capable = copy_range_to_amdgpu_connector(connector);
 
-		if (vsdb_info.replay_mode) {
-			amdgpu_dm_connector->vsdb_info.replay_mode = vsdb_info.replay_mode;
-			amdgpu_dm_connector->vsdb_info.amd_vsdb_version = vsdb_info.amd_vsdb_version;
+		/* eDP */
+		if (edid)
+			parse_amd_vsdb_did(amdgpu_dm_connector, edid, &vsdb_did);
+
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
-		}
+	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A && vsdb_info.freesync_supported) {
+		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+		freesync_capable = copy_range_to_amdgpu_connector(connector);
 	}
 
 	if (amdgpu_dm_connector->dc_link)
 		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
-	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
-		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
-		if (i >= 0 && vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
+	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST && vsdb_info.freesync_supported) {
+		amdgpu_dm_connector->pack_sdp_v1_3 = true;
+		amdgpu_dm_connector->as_type = as_type;
+		amdgpu_dm_connector->vsdb_info = vsdb_info;
 
-			amdgpu_dm_connector->pack_sdp_v1_3 = true;
-			amdgpu_dm_connector->as_type = as_type;
-			amdgpu_dm_connector->vsdb_info = vsdb_info;
-
-			amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
-			amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
-			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
-				freesync_capable = true;
-
-			connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
-			connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
-		}
+		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
+		freesync_capable = copy_range_to_amdgpu_connector(connector);
 	}
 
 update:
-- 
2.52.0

