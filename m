Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E341C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 16:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2056864EB3
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 16:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2056864EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E1E6E20E;
	Wed, 10 Mar 2021 16:17:56 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 004406E0A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 16:14:50 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id f124so17347514qkj.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 08:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jM0TN8kYvVX1f27cKjzfv7fRrmwsBjDSqYgQLR6O2IU=;
 b=LeE7Lr+irnczDRVZ7TI+icDQ3U9u/H0waNh0pKPjPVg2OpiG29oK8+6vUPDiuUE9R5
 NjACimgDxYvlaAnTC6xN+muuj/W6X+zL9cjcA3afYK1Pv5lPnlXoEqpaK1Q2H03knvEf
 40TysDCMsnpT6yd3zrp3GoxvFAffSqQETjF8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jM0TN8kYvVX1f27cKjzfv7fRrmwsBjDSqYgQLR6O2IU=;
 b=fUMJEWA2ELX6CMkTvoymySuwjJZ/JOvRd48kvBOkS4NzuQawLm2dyJUQnprk6ee/rX
 8wlKXl15xmHwhWpu2k8BoRG9uCsSmIpr49jeHSMyiswIpj8KyFb4T+2UjwUCzRTntinH
 C7LbbPw9dlQdLINhJGynKk7w8W6Xu/KrexHzUCObEK4m2Ux2UOzhMX7KqMxyURi7KlBD
 JGb7jWRBGtXfX+/VbRyFHIFRdJcyslpSfpojokgLog5YokH/VFk2KvwKOJ+fXEqQtDwv
 KAgp7YzXo1iuIF9TUr57udVPG2gRBfcVPEcHb0ZS2LXJd+43bheN1Q5cznfFaVTiNkH6
 07bA==
X-Gm-Message-State: AOAM530pSqHT8ohmM2MhKlLaUxBjpQOotLMoF2o01593DELeJ6Bnwim3
 apFKtO4GCpNEF13GWCnRRz759IRCPQHO/A==
X-Google-Smtp-Source: ABdhPJzm/3+/1ivniUlMrayNdGcdJRUr7W/tR2ymWUjkMXBSapbaGqszc7wnp/HdXSxkZXkZzkCabw==
X-Received: by 2002:a37:9b01:: with SMTP id d1mr1230331qke.337.1615392889778; 
 Wed, 10 Mar 2021 08:14:49 -0800 (PST)
Received: from markyacoub.nyc.corp.google.com
 ([2620:0:1003:513:43d:6d63:2f0c:ddfb])
 by smtp.gmail.com with ESMTPSA id m17sm12975924qkh.82.2021.03.10.08.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Mar 2021 08:14:49 -0800 (PST)
From: Mark Yacoub <markyacoub@chromium.org>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Ensure that the modifier requested is supported
 by plane.
Date: Wed, 10 Mar 2021 11:14:44 -0500
Message-Id: <20210310161444.1015500-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 10 Mar 2021 16:17:55 +0000
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
Cc: alexander.deucher@amd.com,
 default avatarMark Yacoub <markyacoub@chromium.org>,
 Mark Yacoub <markyacoub@google.com>, bas@basnieuwenhuizen.nl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mark Yacoub <markyacoub@google.com>

On initializing the framebuffer, call drm_any_plane_has_format to do a
check if the modifier is supported. drm_any_plane_has_format calls
dm_plane_format_mod_supported which is extended to validate that the
modifier is on the list of the plane's supported modifiers.

The bug was caught using igt-gpu-tools test: kms_addfb_basic.addfb25-bad-modifier

Tested on ChromeOS Zork by turning on the display, running an overlay
test, and running a YT video.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: default avatarMark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 13 +++++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index afa5f8ad0f563..a947b5aa420d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -908,6 +908,19 @@ int amdgpu_display_gem_fb_verify_and_init(
 					 &amdgpu_fb_funcs);
 	if (ret)
 		goto err;
+	/* Verify that the modifier is supported. */
+	if (!drm_any_plane_has_format(dev, mode_cmd->pixel_format,
+				      mode_cmd->modifier[0])) {
+		struct drm_format_name_buf format_name;
+		drm_dbg_kms(dev,
+			    "unsupported pixel format %s / modifier 0x%llx\n",
+			    drm_get_format_name(mode_cmd->pixel_format,
+						&format_name),
+			    mode_cmd->modifier[0]);
+
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 961abf1cf040c..21314024a83ce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3939,6 +3939,7 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	const struct drm_format_info *info = drm_format_info(format);
+	int i;
 
 	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
 
@@ -3952,6 +3953,14 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return true;
 
+	/* Check that the modifier is on the list of the plane's supported modifiers. */
+	for (i = 0; i < plane->modifier_count; i++) {
+		if (modifier == plane->modifiers[i])
+			break;
+	}
+	if (i == plane->modifier_count)
+		return false;
+
 	/*
 	 * The arbitrary tiling support for multiplane formats has not been hooked
 	 * up.
-- 
2.30.1.766.gb4fecdf3b7-goog

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
