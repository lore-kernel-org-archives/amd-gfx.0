Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A825AC88E72
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC6010E3C0;
	Mon, 26 Jan 2026 08:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y/F79cVb";
	dkim-atps=neutral
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0627310E372
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:26 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id
 4fb4d7f45d1cf-64b7a91f9daso544564a12.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366365; x=1769971165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmgwWRrt6HOF0PbDVge366fL7Mh7GQU+20kTg/ePqis=;
 b=Y/F79cVbfOUsbU+QOW6XTZU7ZLHs/McOQGmdac83H1UBHA8HWYVWw0KAG3K6QsYeK5
 i5AbDe/2qu7aMwWkTmjUvAvZQrxKDfidcJOctBHq4h24vPvH438aaeIvBsvxCheoLWpt
 H0uihTrx64IStS3xMVfGk1k7HHLaZk7mTmLR8puqIWpYLN7WbUUf0v9wfQJiibuAX4uw
 KMfFv0hz6HySioB5vuDekMig6PlUEUw/vw96blMfydsONIHB1dF79vBPwaHfN5A93ouu
 QzSrT/iJ/Gl8HfMEGjPNEPeqgkWoytMSXV08ZF9fiZUWvDXUiHs4Zhi9cwxc0Ev1DVAa
 ls7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366365; x=1769971165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hmgwWRrt6HOF0PbDVge366fL7Mh7GQU+20kTg/ePqis=;
 b=pTxzW8KDrLpGSjXQnhCYhdwqu3J1GqTmkCydndnE/+mUJ98iZbSBVzwYsD8tsac46/
 bFXIFNTgoSoxj8f7f9dhYGSxV103pRKLy2vk78aGFwtoch6V/XnDc5clFk54VW6pbrPO
 ixq0mqqF0XDhZma9vUl+o07Zd4ZAdPJs0cFOIZnB9HWgzmD8YarhHPXwy0rm9pio/gL7
 0wnIZ/wHC+RwUkMTLCAlwhFX3FyFR8WPtCR7G8rVNIYAz08dRf6XzkTI573um+heDKNC
 NwqlIowIkMFFt5GHZCM5seUpE9YN3Z3ekQ1dTd0n4IS2gAKequp0AxJjQhJoKO9lIcff
 EJnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkbp44MW/c1Lbp1WVizPHz38gDLWYDjH4dSP7r8sPjhg/a6Di44757C+uRCrTqMvZIILvkUEqq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymdXxx0FqHXlWZQqu8aO40cIAnfHWz0xuGTufX4JPBcoK2ZNfQ
 Il0grMlIBSPcBNt8JksLPot196UCPJmPKd3rN9ZRV4ffahBPC5UMw3JY
X-Gm-Gg: AZuq6aLygZBtRO6Nc35RveGpFgTz42flPgVCBTo49+2h8B9X7z/BQYLxzdAbPwOsKN4
 dVxJHucgDnThyq240e0Zcv6LZagl5S9Jd5hrYTz6H2KGaaxtPaqaQLxoeH4TiWsCqZb2D1x/hmA
 Tv/P04zM1jq9lxPhZl8MH/Rl7v3pAcc9WymsrzEMmI7ckudN5b4KSXn8pnyZ09JFpO4y0FmdIYZ
 TpTPavZOq4hF5+Uonk+675WEhHDq9mPZ1BGhRez0OGzx0745VdOhmeXLDLLuNVNKwtZPlDm7UgA
 TK3hHOmePVDVCdLKdxHRHVtFnTOwCfnCPVU3eOYBy2JEOwg1TeK6v9s328J7P+uhgj2l0gqvl1P
 skeHyw9DHKAvsedSQrzCCSHYVIsPnGSNKFgoQdGsFAgseHZFvPAihnwODvStHYULVcw32UEwuVz
 +2c5T69kDUeygIVp2PBU7S4zrAoII2cMkqFx6x/hX8zgwNRGHgwT9OJuexEj5LKbQVrhRb9uLMk
 9E=
X-Received: by 2002:a17:907:d18:b0:b71:a627:3d9f with SMTP id
 a640c23a62f3a-b8d20b42346mr96019266b.0.1769366365198; 
 Sun, 25 Jan 2026 10:39:25 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:24 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 06/19] drm/amd/display: Add PCON VRR ID check override
Date: Sun, 25 Jan 2026 19:39:01 +0100
Message-ID: <20260125183914.459228-7-tomasz.pakula.oficjalny@gmail.com>
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
index 33b76c1850b1..7673143ba651 100644
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
@@ -13296,7 +13299,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
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
index ff15e5990ec0..144b5357e6fb 100644
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

