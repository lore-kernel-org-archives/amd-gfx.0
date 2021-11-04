Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC123C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B100161215
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B100161215
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E9066EF2E;
	Thu,  4 Nov 2021 20:20:13 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2037386A
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:03:07 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id d6so6089898qvb.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Nov 2021 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n6LDFw29hZsoKOLns/SZzto6jZDnxgAkgjGJO4dyrRY=;
 b=T/ckcQBWOViogOXX72QJ6w3HvGmn5rL2NW06Yjte/zJcE/AB/v4oyf/SkjhFR0E227
 pI+xYaEgHixkWOy5DgzDRBV4gQ/rKqui2oQnykhq4YenADyPYoZHwx8ZkZpTVaERR2xz
 UduZGcSig2OE5calDBgcMjyWXIaGnoszW9veY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n6LDFw29hZsoKOLns/SZzto6jZDnxgAkgjGJO4dyrRY=;
 b=OIWXU/lu0tfPRcvnrwiP7wwICMDlP1FWtf/+4XIXwlJqjx+DUHoJYJvPrlb5nevXDz
 trY9jOrhJnbj4Dqc5kTn7bJwYVM0mOe9Hl0jMHHAYph1UsaaoIZJKNBmOAvYhqxrhGui
 XGhpbwMpfNWehuw39oWyQEEYWPyhV+Y256vqMHLcP0GJrMmtT3O69GZPscOqPXpdJHmP
 aoPC4JTCYdl0yEV2eFqYzMK4VGIhk3uYAgsTMSB+cIrXM442gSDpTTUL13Se/0B/aJ63
 8OhgMp46z6HIUy0waknDMmV8jkSIzod53kEIiDzL1xcXjS+5pGZ7yV35fWGybdeVXs/9
 iz1w==
X-Gm-Message-State: AOAM531pc9NVjyj/ohsbNLgmrrKTb7VQy4KzsjLlorU8HMxgun9YB856
 nj1YRJjOz6QE6lHEmQtGjoV8pQ==
X-Google-Smtp-Source: ABdhPJxLZ+5Oy62QzLHHu/KSvILvzeCBEI0UAESxsEUKEIxTcMhOTMEEJsV+Day34F+jzG9/rBb/yA==
X-Received: by 2002:a05:6214:240c:: with SMTP id
 fv12mr3237449qvb.58.1636056186439; 
 Thu, 04 Nov 2021 13:03:06 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com
 ([2620:0:1003:314:1118:14fe:72e3:f013])
 by smtp.gmail.com with ESMTPSA id j22sm4577411qko.121.2021.11.04.13.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Nov 2021 13:03:05 -0700 (PDT)
From: Mark Yacoub <markyacoub@chromium.org>
To: 
Subject: [PATCH v5 3/3] amd/amdgpu_dm: Verify Gamma and Degamma LUT sizes
 using DRM Core check
Date: Thu,  4 Nov 2021 16:02:52 -0400
Message-Id: <20211104200255.63499-3-markyacoub@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211104200255.63499-1-markyacoub@chromium.org>
References: <20211104200255.63499-1-markyacoub@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Nov 2021 20:20:12 +0000
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
Cc: pmenzel@molgen.mpg.de, Leo Li <sunpeng.li@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>, dri-devel@lists.freedesktop.org, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 jani.nikula@linux.intel.com, David Airlie <airlied@linux.ie>,
 seanpaul@chromium.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mark Yacoub <markyacoub@google.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mark Yacoub <markyacoub@google.com>

[Why]
drm_atomic_helper_check_crtc now verifies both legacy and non-legacy LUT
sizes. There is no need to check it within amdgpu_dm_atomic_check.

[How]
Remove the local call to verify LUT sizes and use DRM Core function
instead.

Tested on ChromeOS Zork.

v1:
Remove amdgpu_dm_verify_lut_sizes everywhere.

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 35 -------------------
 3 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f74663b6b046e..47f8de1cfc3a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10244,6 +10244,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		}
 	}
 #endif
+	ret = drm_atomic_helper_check_crtcs(state);
+	if (ret)
+		return ret;
+
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
@@ -10253,10 +10257,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			dm_old_crtc_state->dsc_force_changed == false)
 			continue;
 
-		ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
-		if (ret)
-			goto fail;
-
 		if (!new_crtc_state->enable)
 			continue;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index fcb9c4a629c32..22730e5542092 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -617,7 +617,6 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev);
 #define MAX_COLOR_LEGACY_LUT_ENTRIES 256
 
 void amdgpu_dm_init_color_mod(void);
-int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);
 int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
 int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 				      struct dc_plane_state *dc_plane_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index a022e5bb30a5c..319f8a8a89835 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -284,37 +284,6 @@ static int __set_input_tf(struct dc_transfer_func *func,
 	return res ? 0 : -ENOMEM;
 }
 
-/**
- * Verifies that the Degamma and Gamma LUTs attached to the |crtc_state| are of
- * the expected size.
- * Returns 0 on success.
- */
-int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)
-{
-	const struct drm_color_lut *lut = NULL;
-	uint32_t size = 0;
-
-	lut = __extract_blob_lut(crtc_state->degamma_lut, &size);
-	if (lut && size != MAX_COLOR_LUT_ENTRIES) {
-		DRM_DEBUG_DRIVER(
-			"Invalid Degamma LUT size. Should be %u but got %u.\n",
-			MAX_COLOR_LUT_ENTRIES, size);
-		return -EINVAL;
-	}
-
-	lut = __extract_blob_lut(crtc_state->gamma_lut, &size);
-	if (lut && size != MAX_COLOR_LUT_ENTRIES &&
-	    size != MAX_COLOR_LEGACY_LUT_ENTRIES) {
-		DRM_DEBUG_DRIVER(
-			"Invalid Gamma LUT size. Should be %u (or %u for legacy) but got %u.\n",
-			MAX_COLOR_LUT_ENTRIES, MAX_COLOR_LEGACY_LUT_ENTRIES,
-			size);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 /**
  * amdgpu_dm_update_crtc_color_mgmt: Maps DRM color management to DC stream.
  * @crtc: amdgpu_dm crtc state
@@ -348,10 +317,6 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 	bool is_legacy;
 	int r;
 
-	r = amdgpu_dm_verify_lut_sizes(&crtc->base);
-	if (r)
-		return r;
-
 	degamma_lut = __extract_blob_lut(crtc->base.degamma_lut, &degamma_size);
 	regamma_lut = __extract_blob_lut(crtc->base.gamma_lut, &regamma_size);
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

