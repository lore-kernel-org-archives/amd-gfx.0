Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A904C5517A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 02:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E612168B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 02:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="FfvHXMNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E612168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 998A389DE5;
	Wed, 11 Nov 2020 02:48:43 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E4589D7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 02:48:40 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id h2so838268wmm.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 18:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aVutieMHr3I/FM1nXj1UhKk5PBnPC4fRfmnuQO+0amY=;
 b=FfvHXMNXt7TSq0w4X1ddw81+j6SUeMwdzXxLtotuASYgCCSSakIPWaRP1FBoqrGFyq
 0CgFcMN8vavIIre53mFMTVowNsc5BGKtNl4yrt4qekvhbDyZbYMm2e0hLJidYNh5kdcE
 9inOzmO1ozwoSxfeQ7axlwzCSWP2RzblUnC9DiEmmkS5tvzJa6pV+uxjk/WeJ9tLlveq
 5KxjZ4vN0mdlTCCU+LYVMioVIPTV2TkHh5xLc6oPJtbR7GXTxP57MYFBpiZJAxYNwku5
 pEB6zuDdfUUOO6PbUa/fkJmYl1qTr0jY3xE0oM1pGFDliOkFuQ89vpItTTJYDe30M70L
 Hg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aVutieMHr3I/FM1nXj1UhKk5PBnPC4fRfmnuQO+0amY=;
 b=R2E13rFcz+P2eZNqUR9Am7Ep8O9lhO/+jy47ZsJzkGZeeEsYaegMMZ6Jq/cb5ev9Ky
 aPS5SmhjaPk1kn2IDYuxlwv9QzQkscGvQ+47Q/VW6jdr+j13NVSMOCv85k5sAw0yegUt
 o+itVYdA++RlvH0deS0ZVK++EqmD8ZWdCiEbyrdvaLu6qdyKHYRjO1TR2zKJimLKt4+M
 W+Irp//2GgiHGRk71LhacfZne+WopknZPTuEeAMePsWZJaDMHwUwXcI0jsBvvpazI75X
 KbQ/j7aGi5x3iUppwAbV6G0gurBPAPXEXndbZrOprKdmMF4xEl2fuUlNHws8fP/6StBM
 2z1Q==
X-Gm-Message-State: AOAM530SZ4hAzquEr+tBR6vPy2W/fPKRuJCEaVcg4nX983yAlgBg9Ust
 M6gPUmNM8t79J9B8xWchmsYkNktq4AqcwVdW
X-Google-Smtp-Source: ABdhPJwPiUScmzS7T/ONZ6B5licuiDeGFCam751m8jHpraxB2lG5H6Rxt3eF+x6uIZrQonX8GmhjAw==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr1257397wmg.21.1605062918899; 
 Tue, 10 Nov 2020 18:48:38 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id c185sm724498wma.44.2020.11.10.18.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 18:48:38 -0800 (PST)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/display: Set new format info for converted
 metadata.
Date: Wed, 11 Nov 2020 03:48:39 +0100
Message-Id: <20201111024840.496679-3-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111024840.496679-1-bas@basnieuwenhuizen.nl>
References: <20201111024840.496679-1-bas@basnieuwenhuizen.nl>
MIME-Version: 1.0
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
Cc: alexdeucher@gmail.com, harry.wentland@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If we use DCC modifiers this can increase the number of planes from
the initial 1 plane with metadata, so that we get a valid modifier
from getfb2.

Since the code didn't update the format_info getfb2 would only ever
return 1 plane with a modifier for which userspace expects > 1.

This moves the format lookup to amdgpu_display.c so we do not have
issues when DC is not compiled.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 97 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |  2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 88 +----------------
 3 files changed, 100 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index e33acc3de286..f66ce6ec4843 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -542,6 +542,95 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	return domain;
 }
 
+static const struct drm_format_info dcc_formats[] = {
+	{ .format = DRM_FORMAT_XRGB8888, .depth = 24, .num_planes = 2,
+	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
+	 { .format = DRM_FORMAT_XBGR8888, .depth = 24, .num_planes = 2,
+	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
+	{ .format = DRM_FORMAT_ARGB8888, .depth = 32, .num_planes = 2,
+	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
+	   .has_alpha = true, },
+	{ .format = DRM_FORMAT_ABGR8888, .depth = 32, .num_planes = 2,
+	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
+	  .has_alpha = true, },
+	{ .format = DRM_FORMAT_BGRA8888, .depth = 32, .num_planes = 2,
+	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
+	  .has_alpha = true, },
+	{ .format = DRM_FORMAT_XRGB2101010, .depth = 30, .num_planes = 2,
+	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
+	{ .format = DRM_FORMAT_XBGR2101010, .depth = 30, .num_planes = 2,
+	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
+	{ .format = DRM_FORMAT_ARGB2101010, .depth = 30, .num_planes = 2,
+	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
+	  .has_alpha = true, },
+	{ .format = DRM_FORMAT_ABGR2101010, .depth = 30, .num_planes = 2,
+	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
+	  .has_alpha = true, },
+	{ .format = DRM_FORMAT_RGB565, .depth = 16, .num_planes = 2,
+	  .cpp = { 2, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
+};
+
+static const struct drm_format_info dcc_retile_formats[] = {
+	{ .format = DRM_FORMAT_XRGB8888, .depth = 24, .num_planes = 3,
+	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
+	 { .format = DRM_FORMAT_XBGR8888, .depth = 24, .num_planes = 3,
+	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
+	{ .format = DRM_FORMAT_ARGB8888, .depth = 32, .num_planes = 3,
+	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
+	   .has_alpha = true, },
+	{ .format = DRM_FORMAT_ABGR8888, .depth = 32, .num_planes = 3,
+	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
+	  .has_alpha = true, },
+	{ .format = DRM_FORMAT_BGRA8888, .depth = 32, .num_planes = 3,
+	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
+	  .has_alpha = true, },
+	{ .format = DRM_FORMAT_XRGB2101010, .depth = 30, .num_planes = 3,
+	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
+	{ .format = DRM_FORMAT_XBGR2101010, .depth = 30, .num_planes = 3,
+	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
+	{ .format = DRM_FORMAT_ARGB2101010, .depth = 30, .num_planes = 3,
+	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
+	  .has_alpha = true, },
+	{ .format = DRM_FORMAT_ABGR2101010, .depth = 30, .num_planes = 3,
+	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
+	  .has_alpha = true, },
+	{ .format = DRM_FORMAT_RGB565, .depth = 16, .num_planes = 3,
+	  .cpp = { 2, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
+};
+
+static const struct drm_format_info *
+lookup_format_info(const struct drm_format_info formats[],
+		  int num_formats, u32 format)
+{
+	int i;
+
+	for (i = 0; i < num_formats; i++) {
+		if (formats[i].format == format)
+			return &formats[i];
+	}
+
+	return NULL;
+}
+
+const struct drm_format_info *
+amdgpu_lookup_format_info(u32 format, uint64_t modifier)
+{
+	if (!IS_AMD_FMT_MOD(modifier))
+		return NULL;
+
+	if (AMD_FMT_MOD_GET(DCC_RETILE, modifier))
+		return lookup_format_info(dcc_retile_formats,
+					  ARRAY_SIZE(dcc_retile_formats),
+					  format);
+
+	if (AMD_FMT_MOD_GET(DCC, modifier))
+		return lookup_format_info(dcc_formats, ARRAY_SIZE(dcc_formats),
+					  format);
+
+	/* returning NULL will cause the default format structs to be used. */
+	return NULL;
+}
+
 static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 {
 	struct amdgpu_device *adev = drm_to_adev(afb->base.dev);
@@ -631,6 +720,7 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 		if (dcc_offset != 0) {
 			bool dcc_i64b = AMDGPU_TILING_GET(afb->tiling_flags, DCC_INDEPENDENT_64B) != 0;
 			bool dcc_i128b = version >= AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
+			const struct drm_format_info *format_info;
 
 			/* Enable constant encode on RAVEN2 and later. */
 			bool dcc_constant_encode = adev->asic_type > CHIP_RAVEN ||
@@ -649,6 +739,13 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 
 			afb->base.offsets[1] = dcc_offset * 256 + afb->base.offsets[0];
 			afb->base.pitches[1] = AMDGPU_TILING_GET(afb->tiling_flags, DCC_PITCH_MAX) + 1;
+
+			format_info = amdgpu_lookup_format_info(afb->base.format->format,
+								modifier);
+			if (!format_info)
+				return -EINVAL;
+
+			afb->base.format = format_info;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
index 3620b24785e1..dc7b7d116549 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
@@ -44,5 +44,7 @@ struct drm_framebuffer *
 amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 				       struct drm_file *file_priv,
 				       const struct drm_mode_fb_cmd2 *mode_cmd);
+const struct drm_format_info *
+amdgpu_lookup_format_info(u32 format, uint64_t modifier);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 423f6f07a070..234a04043a86 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3963,96 +3963,10 @@ modifier_gfx9_swizzle_mode(uint64_t modifier)
 	return AMD_FMT_MOD_GET(TILE, modifier);
 }
 
-static const struct drm_format_info dcc_formats[] = {
-	{ .format = DRM_FORMAT_XRGB8888, .depth = 24, .num_planes = 2,
-	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
-	 { .format = DRM_FORMAT_XBGR8888, .depth = 24, .num_planes = 2,
-	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
-	{ .format = DRM_FORMAT_ARGB8888, .depth = 32, .num_planes = 2,
-	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
-	   .has_alpha = true, },
-	{ .format = DRM_FORMAT_ABGR8888, .depth = 32, .num_planes = 2,
-	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
-	  .has_alpha = true, },
-	{ .format = DRM_FORMAT_BGRA8888, .depth = 32, .num_planes = 2,
-	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
-	  .has_alpha = true, },
-	{ .format = DRM_FORMAT_XRGB2101010, .depth = 30, .num_planes = 2,
-	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
-	{ .format = DRM_FORMAT_XBGR2101010, .depth = 30, .num_planes = 2,
-	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
-	{ .format = DRM_FORMAT_ARGB2101010, .depth = 30, .num_planes = 2,
-	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
-	  .has_alpha = true, },
-	{ .format = DRM_FORMAT_ABGR2101010, .depth = 30, .num_planes = 2,
-	  .cpp = { 4, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
-	  .has_alpha = true, },
-	{ .format = DRM_FORMAT_RGB565, .depth = 16, .num_planes = 2,
-	  .cpp = { 2, 0, }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
-};
-
-static const struct drm_format_info dcc_retile_formats[] = {
-	{ .format = DRM_FORMAT_XRGB8888, .depth = 24, .num_planes = 3,
-	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
-	 { .format = DRM_FORMAT_XBGR8888, .depth = 24, .num_planes = 3,
-	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
-	{ .format = DRM_FORMAT_ARGB8888, .depth = 32, .num_planes = 3,
-	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
-	   .has_alpha = true, },
-	{ .format = DRM_FORMAT_ABGR8888, .depth = 32, .num_planes = 3,
-	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
-	  .has_alpha = true, },
-	{ .format = DRM_FORMAT_BGRA8888, .depth = 32, .num_planes = 3,
-	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
-	  .has_alpha = true, },
-	{ .format = DRM_FORMAT_XRGB2101010, .depth = 30, .num_planes = 3,
-	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
-	{ .format = DRM_FORMAT_XBGR2101010, .depth = 30, .num_planes = 3,
-	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
-	{ .format = DRM_FORMAT_ARGB2101010, .depth = 30, .num_planes = 3,
-	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
-	  .has_alpha = true, },
-	{ .format = DRM_FORMAT_ABGR2101010, .depth = 30, .num_planes = 3,
-	  .cpp = { 4, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1,
-	  .has_alpha = true, },
-	{ .format = DRM_FORMAT_RGB565, .depth = 16, .num_planes = 3,
-	  .cpp = { 2, 0, 0 }, .block_w = {1, 1, 1}, .block_h = {1, 1, 1}, .hsub = 1, .vsub = 1, },
-};
-
-
-static const struct drm_format_info *
-lookup_format_info(const struct drm_format_info formats[],
-		  int num_formats, u32 format)
-{
-	int i;
-
-	for (i = 0; i < num_formats; i++) {
-		if (formats[i].format == format)
-			return &formats[i];
-	}
-
-	return NULL;
-}
-
 static const struct drm_format_info *
 amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd)
 {
-	uint64_t modifier = cmd->modifier[0];
-
-	if (!IS_AMD_FMT_MOD(modifier))
-		return NULL;
-
-	if (AMD_FMT_MOD_GET(DCC_RETILE, modifier))
-		return lookup_format_info(dcc_retile_formats,
-					  ARRAY_SIZE(dcc_retile_formats),
-					  cmd->pixel_format);
-
-	if (AMD_FMT_MOD_GET(DCC, modifier))
-		return lookup_format_info(dcc_formats, ARRAY_SIZE(dcc_formats),
-					  cmd->pixel_format);
-
-	/* returning NULL will cause the default format structs to be used. */
-	return NULL;
+	return amdgpu_lookup_format_info(cmd->pixel_format, cmd->modifier[0]);
 }
 
 static void
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
