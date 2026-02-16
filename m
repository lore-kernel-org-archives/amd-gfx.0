Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CFDE68152
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B069310E48C;
	Tue, 17 Feb 2026 08:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f4uw/QRr";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC02F10E3C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:32 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b8fa033d805so46891866b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260331; x=1771865131; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qpQ8hMace7VylP1UXnY5VctYMrzTpDvAnEUQfsbXrTg=;
 b=f4uw/QRrMHwZitEaxratw2eu5cQr0pvcJyeNfkYE/zzFoqHLlGU/fXRBIt6tnSqHGE
 re0szvzlj5IsNiBPakKl9lN/nRUVAB+KiN0rSTm75B2q92jMlayUxaiulvO1aHSk2xZ6
 Qsk4X89k6GZByasHSHRvr/HHqpAVx+RFCn9NjjsdDM/qRkuHfpKYAD2lPWfeZZuF2GnE
 JjoknB6G21i4Q8zuXZCcOC/UVjUj8S7l4crIUIDbdZnEz9Wvpmm3uDtz81pMoNhT/g8m
 v1mGkUp1vqMQiqusRfUAkkCrA8Fm1QsCxjOZR7czmYP0y03zgrkKb9WY0cNSFCWMS4Ip
 nyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260331; x=1771865131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qpQ8hMace7VylP1UXnY5VctYMrzTpDvAnEUQfsbXrTg=;
 b=mpRfR57aZiMe58BsCwqaOmZBdcdvSYQEZGH92QIvb/S5q8OPL7h7O3BuUIyAmETOVT
 XoBsHnYeIBnJxo47QoTQGzRqEYEj6hW6vLLhFthMug7SawmHhUUhUlZaeA21o7pENq6w
 y2B6sxjjuOU3wCo+nJSgrSrSp7qhbaWZpHeWebLhl7sJKxYUE46no5hPSDQ8WDpQP1WI
 dNkclI7eC89cJ27ZV39ltpj+R2ul3S32Rr8SHYyBXQCkhTXCyippu8ZzwPOEfETVGXNK
 ofDr75XLk2YlYvQXd7fODwN7HOOUe11PU1R9a17kX55/LX6ZYULpfWK5nGDYTfb99iCD
 7+Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVegkZlcDmJ3WXiy4pNdAjuJmTu7jHB5K3X9NyTCKM7haJqp85JIGHs3dRdEvhT72ehQyilA38r@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2ka9hCV+N6d1geltHHTaJ99jCwg5PTxvgYbvPXSC7HYRxBDAt
 Msfftb9OJegXhLqXtq22FlP8TS/p5j9+hGhbGHZWyini7EZ6LBz4TLiK
X-Gm-Gg: AZuq6aI2CGEaIgENfspMYHkr81B/B7crJlJ27MRN9pgn7fMsnAI2zvbLbvfWN+WRgxC
 UgllKXxamxijTjkKEE2sUudQ94v9EyI0KsJlYIppi8EJUGEkzt+nuuyewqAinh1ywsvGL7LJzUD
 wseCV/Ai3xbdXxWvsSm24hmXDi2wnvTYiJSKtiny1pCe2TNKuO41Cx6hX+wXRNPNtkdOnibdDgZ
 eI7XGsdv+oIGpRr6f3zqUYgp6ISDJm5PTQGnhyu7FZVLjFAP/Ja+L5xTnrEPCVYtblrTt1sbsrm
 HsnrhG0wtnh5j1CSZmrh47nAJmZgkGJvnjweVovVAyIvTD5UrwB0NOGrISABZZVKiWZ6N1YbMYg
 tF26ZXJeH6uFZcBKuLQImikLfD48ewSqBrXOQYWUrmrgsGLNQPRmwRY0EblepAzXeuk6zKP7tjp
 dakA0+5WQXUEl8G8H1H7ux0QaVAcae6KmTAMPDswpcpqhLbt6EboBhDwR8St9T9osjgk9CEpmXT
 E7A
X-Received: by 2002:a17:907:3e88:b0:b73:59b0:34c6 with SMTP id
 a640c23a62f3a-b8face510e0mr348070666b.4.1771260331308; 
 Mon, 16 Feb 2026 08:45:31 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:31 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 09/27] drm/amd/display: Refactor PCON VRR compatibility
 check
Date: Mon, 16 Feb 2026 17:44:58 +0100
Message-ID: <20260216164516.36803-10-tomasz.pakula.oficjalny@gmail.com>
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
DP->HDMI PCONs prevously entered the DP path

[How]
Restructure amdgpu_dm_update_freesync_caps() and move
dm_get_adaptive_sync_support_type() to dm_helpers_is_vrr_pcon_allowed()
to better reflect what this function does. It never actually gave us any
other info.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++----
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 39 ++++++-------------
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
 3 files changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2f31fe7265d9..2603da69d772 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13321,8 +13321,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct dpcd_caps dpcd_caps = {0};
 	const struct edid *edid;
 	bool freesync_capable = false;
+	bool pcon_allowed = false;
 	bool is_pcon = false;
-	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
 
 	if (!connector->state) {
 		drm_err(adev_to_drm(adev), "%s - Connector has no state", __func__);
@@ -13357,6 +13357,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (amdgpu_dm_connector->dc_link) {
 		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
 		is_pcon = dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+		pcon_allowed = dm_helpers_is_vrr_pcon_allowed(amdgpu_dm_connector->dc_link);
 	}
 
 	/* DP & eDP excluding PCONs */
@@ -13390,15 +13391,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A && vsdb_info.freesync_supported) {
 		monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
 		freesync_capable = copy_range_to_amdgpu_connector(connector);
-	}
-
-	if (amdgpu_dm_connector->dc_link && is_pcon)
-		as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
 
 	/* DP -> HDMI PCON */
-	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST && vsdb_info.freesync_supported) {
+	} else if (pcon_allowed && vsdb_info.freesync_supported) {
+		amdgpu_dm_connector->as_type = FREESYNC_TYPE_PCON_IN_WHITELIST;
 		amdgpu_dm_connector->pack_sdp_v1_3 = true;
-		amdgpu_dm_connector->as_type = as_type;
 		amdgpu_dm_connector->vsdb_info = vsdb_info;
 
 		parse_amd_vsdb_cea(amdgpu_dm_connector, edid, &vsdb_info);
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
2.53.0

