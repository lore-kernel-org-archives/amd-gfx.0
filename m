Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A36CCA5FFF
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0BA10E3BD;
	Mon, 19 Jan 2026 08:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kA1skWMG";
	dkim-atps=neutral
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD6810E303
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:11:59 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b8718294331so56144866b.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785118; x=1769389918; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fP5YEeeE3B0IdA9ryOj35W/sze8zh4cUnFXv3GSvmyE=;
 b=kA1skWMGq8O+uUc4sFSTQDfCgi7ji1cI04WCIryNgbULLVR4m7sCuJnzSdcbZjGcn3
 +/8Xi2hM90K7YNuvgrykfEXC5OeeqbAB9MvfeuPJmcU55UpQn1F/gxFjpBmhhk/knXra
 CQ752AJRacbtz0X9O5mroXZbTC8HPpntRkCxdgenctYjqrUJzbaRJSPDt/nTrpl0xfV2
 uBXEs6jcwLVR7YOwXg7wHmoki5Me+T/6pyka2kIOFTR/2TAbCpLYFb/JdKMd8NNrEeWI
 krAKHTbbLeydKQkGXNcsEKQ4w+3whbklt+kSvTaWGeCfn2UY6s89Jm4JL9DiDq7gbHAm
 A4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785118; x=1769389918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fP5YEeeE3B0IdA9ryOj35W/sze8zh4cUnFXv3GSvmyE=;
 b=bZMd8YqdOPhQjSu8wIKoyWQAkcvwxKzmB5s3aJwFTxMKOsieE1ZyYaXesvC/kEcPFC
 WeYnPM07hbPLt1w07mv2h29b2R2Lt2/0t4TprG7ZOeZGCwHh0ixhZHd05QJOsUNFTeWQ
 c+7RTfSmiqJXKTta4s1XKTRwXx0JXVaq3UpPTn2zpWRbUNh4wH+M0w8a0DwhLnvU6mwD
 SQgoPxzPkbCZBK4Y6UopqBaNPKfzO+4eTS7pvmzKxxUPF2F7L0UdJk05GUoHFxUzcbvC
 yipOFdfLgKJH+Q7Ou7/cg1a4zzM2QK9rIcBJkIKb+Ne8aA/EBZ5gNuoSDyDHdIwHRkwW
 EwYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi+TJ7E37J/tamQwIUL5IfOeBu9YO/gL8ZuwLGcKY62f96Py24TLTEzhI470u7jXaXbxuPItLT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyduG+8pZt1/txvNZm/KRZXx/Q8yd25dG8CKG7LjZs0szsRixNy
 9bhkXUi1hIQuCZZDiWvq4oR/2k4/KFkHoKzaurdVkXdKmJz4CDzQ3lk4
X-Gm-Gg: AY/fxX70gPhQezkN8VzhR0nWD5yKQUE+/JP5KMxH9FIQcDx4rqpFko2vf9Tbx54B3C1
 Fw0DDoUnH4U6B1OSvYKCvZDTHIqTAuWEfgzCjinLUtUGGUkIjrzqML/Ar31CMKSbafgXVSgbBX6
 hXHSVPRpftrX9odHmTjsShJGQ5mYPJroNU/J0jikx9Z6bFqvfvtvFSHuEO74ws2Wi/mviGl8P1A
 8xWHs7hd45TCwvQsb0yNImnzMEoVPh32mce5ihWcWPRDlB7130DITykNcadseaYjENmM0SJ2SUf
 GYk99ekN7psOcVi9RxgWQ9dgh0cuhZljeUZcvohVTmWsdRfstmp01AER68YtLDNbxvyYI+/EVn6
 +RhHj0FdJ2zu0HrV0+nFA+E1kQqxjv10DBzYjDKXtbg/mZ9N9RXKj55VPQVg6N5yqa8EGNqAuVh
 hy+DpO1fwpMCGw6hxImmbcz1LYeBk89+BjIz/eFULJQA6vGGW+GFs1ZaAu9KvKZ3mN
X-Received: by 2002:a05:6402:510c:b0:649:b47b:2ef7 with SMTP id
 4fb4d7f45d1cf-65452acc99bmr4627590a12.3.1768785117830; 
 Sun, 18 Jan 2026 17:11:57 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:11:57 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 06/17] drm/amd/display: Add PCON VRR ID check override
Date: Mon, 19 Jan 2026 02:11:35 +0100
Message-ID: <20260119011146.62302-7-tomasz.pakula.oficjalny@gmail.com>
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
It's currently very hard to test if a random PCON supports VRR and
report it's ID.

[How]
Adds override as part of dc debug mask. Allows faster testing and
reporting of VRR-compatible DP->HDMI adapters.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 6 +++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 8 +++++++-
 drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h               | 2 +-
 drivers/gpu/drm/amd/include/amd_shared.h                  | 6 ++++++
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 662f51faf949..859e34235769 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2062,6 +2062,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_SKIP_DETECTION_LT)
 		adev->dm.dc->debug.skip_detection_link_training = true;
 
+	if (amdgpu_dc_debug_mask & DC_OVERRIDE_PCON_VRR_ID_CHECK)
+		adev->dm.dc->debug.override_pcon_vrr_id_check = true;
+
 	adev->dm.dc->debug.visual_confirm = amdgpu_dc_visual_confirm;
 
 	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
@@ -13279,7 +13282,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (amdgpu_dm_connector->dc_link) {
 		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
 		is_pcon = dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER;
-		pcon_allowed = dm_helpers_is_vrr_pcon_allowed(amdgpu_dm_connector->dc_link);
+		pcon_allowed = dm_helpers_is_vrr_pcon_allowed(
+			amdgpu_dm_connector->dc_link, connector->dev);
 	}
 
 	/* Some eDP panels only have the refresh rate range info in DisplayID */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 76a10fe8d545..2ef515a4e1c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1375,7 +1375,7 @@ void dm_helpers_dp_mst_update_branch_bandwidth(
 	// TODO
 }
 
-bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link)
+bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link, const struct drm_device *dev)
 {
 	if (link->dpcd_caps.dongle_type != DISPLAY_DONGLE_DP_HDMI_CONVERTER)
 		return false;
@@ -1393,6 +1393,12 @@ bool dm_helpers_is_vrr_pcon_allowed(const struct dc_link *link)
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
index 4068d5baef21..5be0507f8a27 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1056,6 +1056,7 @@ struct dc_debug_options {
 	bool scl_reset_length10;
 	bool hdmi20_disable;
 	bool skip_detection_link_training;
+	bool override_pcon_vrr_id_check;
 	uint32_t edid_read_retry_times;
 	unsigned int force_odm_combine; //bit vector based on otg inst
 	unsigned int seamless_boot_odm_combine;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index f8b45a09d680..ea94c52d2b87 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -222,7 +222,7 @@ int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
 
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
2.52.0

