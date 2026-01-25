Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448B7C88E76
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D1510E3DC;
	Mon, 26 Jan 2026 08:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OgyFHtG8";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E7310E207
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:21 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-658323d1c91so558871a12.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366360; x=1769971160; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBLEx0I4dFJbqms9FUHoyNpeQ/njWHpc2q7k6geZkNY=;
 b=OgyFHtG8Tsp9aaMZjse7wWofIgt95gLxvBCZ/7YA/lnR4LWMbpMsmWVf5WNBcgByZk
 /VbQdfmIphiALN3Uzb29YZ+whIXl42RRfuid169YYKOzP912ufjHaFfE7CZLy+8Ucg0X
 QH82ofYrAFT6u52Fo+z2Kfd9BYuroAArUPMz7wyDF6DwgDKywgyiBpV9+bGwA8uHlRZL
 PnloWSl/hDMonJ24XHccPhJH1TlYkZOuKu3EEl5O3Wk6PUNfsCNxA/PEcN9l7ASyj+AY
 CJrZqVOMij6r0u3iSMDnkR59SUxo4fSDMph9SDKAWWKqBJbsNIz2qosvSOCk3HMHv0L+
 dWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366360; x=1769971160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PBLEx0I4dFJbqms9FUHoyNpeQ/njWHpc2q7k6geZkNY=;
 b=nhYirU5gzDPFZ8aN8XU5B0wu5ewt0PNTjIkoCdBqbQ6em106R7+EB3XIRWiFWVzx0N
 46qfLYIAznR8tO+N+uX8u/2o5F9y4pjOyoW5aKm2FIQAuv00b05yulrB1+hZeKrbAijE
 +fnSiIJA1c/R1KCVz1wKGhdVJT3t+ANfW62UHhpJXtdvlUNXrg1+0RTcHYvqme9+Wn1x
 XoeFLgvF0aIgIUtsWSyLU6O52mDaXVpktUHYTbubvLa87Bl8P+gA8WX81cvyeAxGj2sG
 TSAc3l9K7g6M9HKOGVkrPnSNz6qt5FW7hB5/mx9lb2bBariZhgqKykw3lg02qWLS8839
 YxHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq3bbR6KMTmHpduHOupbwIN+G35lXR3PwSpSzDJ/CqK7Cub42V/IPn4aamkkYR7ZHnYmVRs+rE@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/W3s2BH9UMVTxNmP2zzUfctjdEC9KmUmQ2qwNie8MHGxNAtvQ
 Uw3MdNKwWdkwHEbYjj5yJiBpDqibDY4zzVQPPH6TqItltRIYZ+1l3lc2
X-Gm-Gg: AZuq6aLKcjA0dNJGloR78k7dU6NpT4MVB2NC4aiC2V/PAA/va3TZMwuprKZlC/EWj0v
 7D/FXsoQUdXRcLUKVyqgOH8vbCVduBfD8a+L1rtk/DtmVR6FlJfRzImDDK6rK63VdQ82ATSofaP
 btq7ikoS4PDrJkMnUGX8sAPs1LRKJx8Si56fZ+Z+eIxkvAsxG7L3EfwFpQYT59vqhoNVojEVHWk
 Tja8biWnikiLn/PlTKQbzhB10UGueiWY2NRvMrWnBqqZncMhtL5C92YCnF2PheUXLMe/Ux8T/JN
 q4gKlYsVNenS/NGn6MECCWy/kVPUH/RDjQqvQNXBi50CKceUSD2E9AVUHaX95e5SLesEc2zRa+I
 LnRRgzRyyxLiGg3Iw3qHCSiNVKXZ4E4G2q+ynZ/nRe3I7X4J7MKEPV91sm8iiabzwx3tpagDMl+
 VWBzhmNc7z0flXSV7KhDWHbs1pKP9CiRaVyIhrLep9z8H3aTbNqQWJs7tPiSn1ZUNH
X-Received: by 2002:a17:907:3f0f:b0:b87:1e1:e562 with SMTP id
 a640c23a62f3a-b8d4f7f155fmr84091466b.8.1769366359659; 
 Sun, 25 Jan 2026 10:39:19 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:19 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 02/19] drm/amd/display: Refactor
 amdgpu_dm_update_freesync_caps()
Date: Sun, 25 Jan 2026 19:38:57 +0100
Message-ID: <20260125183914.459228-3-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125183914.459228-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260125183914.459228-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Jan 2026 08:09:08 +0000
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 119 +++++++++++-------
 1 file changed, 72 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f01ddde1a50c..77a903880543 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13098,8 +13098,8 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
 	}
 }
 
-static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
-			  const struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
+static int parse_amd_vsdb_did(struct amdgpu_dm_connector *aconnector,
+			      const struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	u8 *edid_ext = NULL;
 	int i;
@@ -13151,9 +13151,9 @@ static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 	return false;
 }
 
-static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
-			       const struct edid *edid,
-			       struct amdgpu_hdmi_vsdb_info *vsdb_info)
+static int parse_amd_vsdb_cea(struct amdgpu_dm_connector *aconnector,
+			      const struct edid *edid,
+			      struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	u8 *edid_ext = NULL;
 	int i;
@@ -13183,6 +13183,44 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 	return valid_vsdb_found ? i : -ENODEV;
 }
 
+static bool is_monitor_range_invalid(struct drm_connector *conn)
+{
+	return conn->display_info.monitor_range.min_vfreq == 0 ||
+	       conn->display_info.monitor_range.max_vfreq == 0;
+}
+
+/*
+ * Returns true if (max_vfreq - min_vfreq) > 10
+ */
+static bool is_freesync_capable(struct drm_monitor_range_info *range)
+{
+	return (range->max_vfreq - range->min_vfreq) > 10;
+}
+
+static void monitor_range_from_vsdb(struct drm_connector *conn,
+				    struct amdgpu_hdmi_vsdb_info *vsdb)
+{
+	struct drm_monitor_range_info *range = &conn->display_info.monitor_range;
+
+	range->min_vfreq = vsdb->min_refresh_rate_hz;
+	range->max_vfreq = vsdb->max_refresh_rate_hz;
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
+}
+
 /**
  * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
  *
@@ -13197,15 +13235,18 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
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
+	bool valid_vsdb_cea = false;
+	bool vsdb_freesync = false;
 	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
 
 	if (!connector->state) {
@@ -13235,62 +13276,46 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		goto update;
 
 	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
+	valid_vsdb_cea = parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info) >= 0;
+	vsdb_freesync = valid_vsdb_cea && vsdb_info.freesync_supported;
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
+	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A && vsdb_freesync) {
+		monitor_range_from_vsdb(connector, &vsdb_info);
+		freesync_capable = copy_range_to_amdgpu_connector(connector);
 	}
 
 	if (amdgpu_dm_connector->dc_link)
 		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
-	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
-		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
-		if (i >= 0 && vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
+	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST && vsdb_freesync) {
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
+		monitor_range_from_vsdb(connector, &vsdb_info);
+		freesync_capable = copy_range_to_amdgpu_connector(connector);
 	}
 
 update:
-- 
2.52.0

