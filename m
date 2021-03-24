Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E7C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 20:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9B961A10
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 20:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9B961A10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F0866E9D4;
	Wed, 24 Mar 2021 20:18:28 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E3B96EA22
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 20:16:38 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id q3so19415323qkq.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 13:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=toyon/RTuX+WnGhi9zeW3kRmhDtJjx7YpvomSBt0fYY=;
 b=gkRVgU6soyBwJP62S9fHhBQOGexdUWyb6O+eYwDWW47RLYE5l+2vhKKJTVI5/rRfo9
 GBaAu1tygxSnr5ujmv2npIVx3+MngGsI10pWRWjm6FL7WzxONRAzhUnbcKGPQzfHT573
 sQ9bfPlZffRBQNXuLVAcDTPu/gsvyD6SH50Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=toyon/RTuX+WnGhi9zeW3kRmhDtJjx7YpvomSBt0fYY=;
 b=YFi+RRKf+n9Bo1VbLFXST317L+yGgzmICG9ehBQErWLsz1TUXKRs8NLfg/SptQceG3
 qscNEYiNBR33lnGUL9H9J8umF6pfRxVOKobmc6/8TyiRgh/ZfVviZr+WR0DycUBuzUql
 mTIj36Ulvx3SBuC63KU0HHPPhBWIySXN2Rf5I6oReWNJWBrxlJozLZfYAPGfh5wXclHk
 v9vUArgG++n1cZxyd+4hT4tBQKQP9TSYnVHI8jD6ZYNE3GqClbgoeu9gKbA/9RHrAB/g
 P0YX3+lVBzYSl55fpEAtgZXtjOs22jmxMrMFgMsI/rNenxuF3bOvJDi8RqpcRQkS+8oZ
 ITvA==
X-Gm-Message-State: AOAM533Azmn7QLmD/g3h6JtUZ/nHa+HoEJGllOsp1uSMbZGxLBJCTveu
 dm7cnb3wrC0T9pdmcaiHJwv0T9CpX+wdKezj
X-Google-Smtp-Source: ABdhPJycR6CuTsSQxTuJ0ba0qV5sYaKnW+6upaacoxgcgI0jalkjgFY0vKfc7bLT0OPoYn0QViAaCQ==
X-Received: by 2002:a37:850:: with SMTP id 77mr4817656qki.289.1616616997487;
 Wed, 24 Mar 2021 13:16:37 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com
 ([2620:0:1003:513:8cc8:502f:e2e5:c982])
 by smtp.gmail.com with ESMTPSA id v6sm2396902qkf.132.2021.03.24.13.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Mar 2021 13:16:36 -0700 (PDT)
From: Mark Yacoub <markyacoub@chromium.org>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: Ensure that the modifier requested is
 supported by plane.
Date: Wed, 24 Mar 2021 16:16:24 -0400
Message-Id: <20210324201624.712307-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 24 Mar 2021 20:18:27 +0000
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
Cc: default avatarMark Yacoub <markyacoub@chromium.org>, michel@daenzer.net,
 daniel@fooishbar.org, bas@basnieuwenhuizen.nl, alexander.deucher@amd.com,
 Mark Yacoub <markyacoub@google.com>
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

=== Changes from v1 ===
Explicitly handle DRM_FORMAT_MOD_INVALID modifier.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: default avatarMark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c    | 13 +++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

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
index 961abf1cf040c..6fc746996c24f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3939,6 +3939,7 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	const struct drm_format_info *info = drm_format_info(format);
+	int i;
 
 	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
 
@@ -3946,11 +3947,22 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
 		return false;
 
 	/*
-	 * We always have to allow this modifier, because core DRM still
-	 * checks LINEAR support if userspace does not provide modifers.
+	 * We always have to allow these modifiers: 
+	 * 1. Core DRM checks for LINEAR support if userspace does not provide modifiers. 
+	 * 2. Not passing any modifiers is the same as explicitly passing INVALID.
 	 */
-	if (modifier == DRM_FORMAT_MOD_LINEAR)
+	if (modifier == DRM_FORMAT_MOD_LINEAR ||
+	    modifier == DRM_FORMAT_MOD_INVALID) {
 		return true;
+	}
+
+	/* Check that the modifier is on the list of the plane's supported modifiers. */
+	for (i = 0; i < plane->modifier_count; i++) {
+		if (modifier == plane->modifiers[i])
+			break;
+	}
+	if (i == plane->modifier_count)
+		return false;
 
 	/*
 	 * The arbitrary tiling support for multiplane formats has not been hooked
-- 
2.31.0.291.g576ba9dcdaf-goog

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
