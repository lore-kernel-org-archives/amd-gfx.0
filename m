Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C63E68140
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFE5410E47A;
	Tue, 17 Feb 2026 08:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OXindMHz";
	dkim-atps=neutral
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF2910E094
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:34 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id
 a640c23a62f3a-b8fb8f14538so61295366b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260333; x=1771865133; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyN3DnmAfywMU21NsWIFe7SPLTrpTlCuaZerH4yt4wo=;
 b=OXindMHzf/qK9HPP+TW1NL9kwpaS64m9Qnet8zrbH34q/Dvcjjx8pZj4NL00s7jz8A
 iFUaO6d2wXS9gmZzK5oxcHaEluhCHJ6dEx89kUDnnusJZKKHB4SFPnxjkP8HwmJJO4/H
 +FY/rE7V1SPAYkDTaPngJoW/0VTv+nZIQFXX32zl0wKZDPWRIjvrcgZ17f0HjTD1GYFH
 3DmCebSbl22MfEjeoL6292ciFWZVRvM+gdqsV3ubfUvYMT3M5EB47Ip0agHEaeP3mFCd
 6WKqsXCX2hJfaF4IrVbnh6s0f44KMVO6nOUZwizR4Ir3nFz3v/mB5T9b/tu+5CVC1Kh0
 V1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260333; x=1771865133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hyN3DnmAfywMU21NsWIFe7SPLTrpTlCuaZerH4yt4wo=;
 b=BH4rIA/5+U0umzIA5Xisr2Ve64VJYpnEvFQNCPLuXoZVcmfgJGml3zYRkrAe0RvInX
 A6mUUu3MWNd7VhA9RpXv4YpG6ry+XT74XuanLW0Gjc1+khTckraYuYYrmKV8ROI8yO3+
 6kd6JBL/B2izSq9OKSa4r9qyz3Qjtp+yESb3Yzr92zEplAgj3hs06hi3Xox8sbZoOwd9
 kf7b3GhrcUo+G5+guGbMqio5U0MirW/Q7/LA0gUIU/as+jP3KXwluOvCs4n0p/2DWk4p
 hoOOxbxHtI/vtvACDUvV900XecT28+rqmpj7IlxAXuJ/aGQqz/4fzZBiHVaBvmNhCwNc
 PXTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjNpYFtAuA4YmQH2979/GwUtDiIa8UNfHZ1vHAEejYlY40DMbJzFy/jaZSDFYxH90QhZlkFaO5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWhRSauB6RuWCIElWoZuAexCo5m0XRwqcFz3tyuBL5+g3EzMA9
 sfKDFl2k6xHIu8RPQ/GCzv9meS5Cl999HupV1bAOafk++QnziPRT48pi
X-Gm-Gg: AZuq6aIleNix8oedoa+EOn48iryO0+mkRwXS4qaUcbK2QEgf9l7G3PdOTNH4w4/vzdk
 N0b44+74nQ1frov8GO8Qnwcb5G7pU0t2uMmA3+LpB0c3C5wznoBOQv+/YSCp2jD2QLZIZuHuj8h
 BO+dlMljdR1zcO7kCPijsDIaEDCkzxYMUnWXC+XdNlbmKWPL6V96WUKxEPc2U4mJzWE7YAimCpB
 oj6AieJ6+ZzdxNyBAAv916p5Z38tsZpG/FblsyMFdtyXK2HR2kN21f213ZcoPDusGiPFGzHBuK/
 P/Jtb73RPQn3DTuRd3e6E2nqcrfSZJmX5syLqe3ymerYRTN5E2bkbIh/1P961pk7jnSkIDjJyLO
 TPXHDr6lMMTOcSCp8DXfw/wl2DcYt4gg2VeiINIEf7/2ZsmOj7Q4jCJvEcKwW6cf6MyHmexifYd
 nnflJ2zSbL+CLgiTG0mSDtS+yorUgblF1V3XrnrNUR8eIHJSqoTnb09giBtcXH4cgOXOq2P/QfO
 Mmm
X-Received: by 2002:a17:907:608c:b0:b8f:e96:7880 with SMTP id
 a640c23a62f3a-b8fac86c68dmr364370966b.0.1771260332728; 
 Mon, 16 Feb 2026 08:45:32 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:32 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 10/27] drm/amd/display: Add PCON VRR ID check override
Date: Mon, 16 Feb 2026 17:44:59 +0100
Message-ID: <20260216164516.36803-11-tomasz.pakula.oficjalny@gmail.com>
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
It's currently very hard to test if a random PCON supports VRR and
report it's ID.

[How]
Adds override as part of dc debug mask. Allows faster testing and
reporting of VRR-compatible DP->HDMI adapters.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 6 +++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 8 +++++++-
 drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h               | 2 +-
 drivers/gpu/drm/amd/include/amd_shared.h                  | 6 ++++++
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2603da69d772..b6079a1ce2ac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2060,6 +2060,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_SKIP_DETECTION_LT)
 		adev->dm.dc->debug.skip_detection_link_training = true;
 
+	if (amdgpu_dc_debug_mask & DC_OVERRIDE_PCON_VRR_ID_CHECK)
+		adev->dm.dc->debug.override_pcon_vrr_id_check = true;
+
 	adev->dm.dc->debug.visual_confirm = amdgpu_dc_visual_confirm;
 
 	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
@@ -13357,7 +13360,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (amdgpu_dm_connector->dc_link) {
 		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
 		is_pcon = dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER;
-		pcon_allowed = dm_helpers_is_vrr_pcon_allowed(amdgpu_dm_connector->dc_link);
+		pcon_allowed = dm_helpers_is_vrr_pcon_allowed(
+			amdgpu_dm_connector->dc_link, connector->dev);
 	}
 
 	/* DP & eDP excluding PCONs */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 45a91df619d9..cb8a2855ac10 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1381,7 +1381,7 @@ void dm_helpers_dp_mst_update_branch_bandwidth(
 	// TODO
 }
 
-bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link)
+bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link, const struct drm_device *dev)
 {
 	if (link->dpcd_caps.dongle_type != DISPLAY_DONGLE_DP_HDMI_CONVERTER)
 		return false;
@@ -1399,6 +1399,12 @@ bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link)
 		return true;
 	}
 
+	if (link->dc->debug.override_pcon_vrr_id_check) {
+		drm_info(dev, "Overriding VRR PCON check for ID: 0x%06x\n",
+			 link->dpcd_caps.branch_dev_id);
+		return true;
+	}
+
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ce08477d1ccd..141d8c76d001 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1058,6 +1058,7 @@ struct dc_debug_options {
 	bool scl_reset_length10;
 	bool hdmi20_disable;
 	bool skip_detection_link_training;
+	bool override_pcon_vrr_id_check;
 	uint32_t edid_read_retry_times;
 	unsigned int force_odm_combine; //bit vector based on otg inst
 	unsigned int seamless_boot_odm_combine;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index e51f1e489129..5e77deb09200 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -223,7 +223,7 @@ int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
 
 enum dc_edid_status dm_helpers_get_sbios_edid(struct dc_link *link, struct dc_edid *edid);
 
-bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link);
+bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link, const struct drm_device *dev);
 bool dm_helpers_is_fullscreen(struct dc_context *ctx, struct dc_stream_state *stream);
 bool dm_helpers_is_hdr_on(struct dc_context *ctx, struct dc_stream_state *stream);
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index ac2d3701e2bd..894e1e738ce0 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -412,6 +412,12 @@ enum DC_DEBUG_MASK {
 	 * @DC_SKIP_DETECTION_LT: (0x200000) If set, skip detection link training
 	 */
 	DC_SKIP_DETECTION_LT = 0x200000,
+
+	/**
+	 * @DC_OVERRIDE_PCON_VRR_ID_CHECK: (0x400000) If set, always return true if checking for
+	 * PCON VRR compatibility and print it's ID in kernel log.
+	 */
+	DC_OVERRIDE_PCON_VRR_ID_CHECK = 0x400000,
 };
 
 enum amd_dpm_forced_level;
-- 
2.53.0

