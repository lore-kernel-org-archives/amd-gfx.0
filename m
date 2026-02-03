Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E832FE83EF5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC08510E4DA;
	Wed,  4 Feb 2026 08:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lQf0ywnS";
	dkim-atps=neutral
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03D410E743
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:39 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id
 a640c23a62f3a-b8715908e58so58239966b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770144998; x=1770749798; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yKg3D/9dFo9DlQ2bs5wqdmVuHtjRMfS9ivthm1FMvY=;
 b=lQf0ywnSTJELb18L6fa98Zf+4hxUCQLNA2Wm8b8tsG+YPntwWbqv7Uqo5rGAfKDbkJ
 6jQCEwY4Otx+q0r+MB6KR47YjcqfnIRrce5VsFYXnUjy1EzlNC/A7qf59t++TuvbD9/V
 dML6zknQImImGx2vUKjqlQ/PDik7vvYs6iggK7i1D6uNTIResFVtN9Xr7bx/InZ4b2lU
 uTjCe6OC10XsP8f1l7BwBFxit01EzUvPOrG9ZSnDvKQXhedlt7xMC/d5qyT29UqrakYh
 xC1R8i31m5NqY0uKChI2/piRkBzXpxbOQtyDmz5+r+TqoSoaCrZvjMO3kruxbswyVjpT
 kIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770144998; x=1770749798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5yKg3D/9dFo9DlQ2bs5wqdmVuHtjRMfS9ivthm1FMvY=;
 b=UkIkH74J9y3fzotWp4ps2sR6xZhWBIGsbD+j1/7SK1G+OSB0WFDRv3RM90FHGWhmvI
 7lmJyoW9mJF7/gQVR3Bovhgb/spG4WqMl3E8NIsFGUaSsEQfuoIUNcgz9u0VEL7FBcf3
 zaK0Stxn3g9VlJzSzFZ7ntKagjRr3akc1ShdCZLEUjhj1b5mzjOrEd8W/D+N8Hr1CWfC
 uATrZVHKsRcrTorwsH176lQednv2GNj5sV1+KgKTIk+OfAkXsEyQC2K0TqdXBZUsPVkQ
 Q7Lla8SmFIzyBFfURXB0LY3IvN/SDZRW17nAEVdNh+ElQ1Dql+DWoiyE4t/ubLo8KZx7
 eO0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVJgqYgLR1Gy5o3iNks9tcqRYKTr+70w1azfRJcXJOD9rcZIoOIHpXNGaWTAJjKPOMjm8wXUkp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfF6B4V9TEcUERVAj2mV8LIUzxjrra329luGKeVKxxD8ZXXEEv
 ve77SnkPgRYkyhD/3mYP/y//lRoommLBYuXjgn5mCQ6gxKERA6PhlrRk
X-Gm-Gg: AZuq6aKKV6g289dFjV9CYZtQLpvMWS1buyrms0ji/MRyd+RzFbcA17DYCtsWsrYPbQD
 qSplsqlRnJVhaiAmazufZwv7sFOSjklEmZIo4gjAcmYoS2X1UtfqNb11SnjnMMedtQ4RUESJCDR
 TbNznfp9vsyiDhabUuS5KpgzqfYj5j8d69sh/OqzfszwNOsLR2zOIFg6kEqnl1bWwdQLAVkDUGi
 jS50Ki+zUXJtvGtBlXCnugq/BhXyQeN6zXljvIcJPtffJyzB/xvs2OL1NOkKSzH0oaGjhV65aJ9
 v0F3UD8OxWOlEygnRGVzc0qn3wL2dZoas0PR+Yh1ZhKG8fqazOKvqk7RgA+EMW2eCUlT5zkqUAD
 jFfxwoGgQL7Iem0vz5cQe5NuuikY96SpLc1RLJ/BU0Nsqvznh7jXrS6bvjpEtfs/sSeXrKctB34
 cBxrz2qA/eY2lr0AFGJls+8LoDQ2adfscCG885XpfR11LuAWN/OUsUwhoLkw78/ILV
X-Received: by 2002:a17:906:99c5:b0:b8e:92e:d2ef with SMTP id
 a640c23a62f3a-b8e9f3f70famr17566866b.5.1770144997814; 
 Tue, 03 Feb 2026 10:56:37 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:37 -0800 (PST)
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
Subject: [PATCH v3 06/19] drm/amd/display: Add PCON VRR ID check override
Date: Tue,  3 Feb 2026 19:56:13 +0100
Message-ID: <20260203185626.55428-7-tomasz.pakula.oficjalny@gmail.com>
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
index 9346b62d981b..306c29ff38f0 100644
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
@@ -13314,7 +13317,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (amdgpu_dm_connector->dc_link) {
 		dpcd_caps = amdgpu_dm_connector->dc_link->dpcd_caps;
 		is_pcon = dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER;
-		pcon_allowed = dm_helpers_is_vrr_pcon_allowed(amdgpu_dm_connector->dc_link);
+		pcon_allowed = dm_helpers_is_vrr_pcon_allowed(
+			amdgpu_dm_connector->dc_link, connector->dev);
 	}
 
 	/* Some eDP panels only have the refresh rate range info in DisplayID */
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
index ab19b6230945..7b22575ff638 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1057,6 +1057,7 @@ struct dc_debug_options {
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
2.52.0

