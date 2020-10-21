Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14281C2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FEE2225F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="i5llHd5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FEE2225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049B56EEB5;
	Wed, 21 Oct 2020 23:31:50 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DA96EEBB
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 23:31:47 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id k3so17016ejj.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oWNb2QVtPoIG0nRnDDQMH3KsHOSLrCx63mIY3MC3Z6E=;
 b=i5llHd5AyGCCR0K6nP1x1s2p6c614WNMWc9M+oKPLtoIOYVY+knnGbOW8Aq2aly5SW
 xxMLpB9dC+teOczss95cVUOMXr1fs5qDI6uFBbd9ekYWulWz4FqbRaedh3VN8suziLY/
 vo8jx/v+FSukVyBXR/unMF9waOKrgWfrvVIRtZ7CinhrwBJewALjhvloOogJO4kCBAqP
 wlDI3ddAHVUXovSuVzGYazXglP6syqRl2NGcrgxobHfJe+pwO+MwM67V5/CokeB57V3u
 cbgmOO5QS96yHN6ac4tM6vKze5n577Dv4qXfg26h7Ln0pCalLx+hng9d1a72V7XJW8xq
 lglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oWNb2QVtPoIG0nRnDDQMH3KsHOSLrCx63mIY3MC3Z6E=;
 b=YzjVeQa8RRIPlb0AplYIUf0+j4/9wUWhuVclTsWfMJ+LP8HmcPBTCLpC8GPHcYNcSl
 RfbkcOWAwkMutwniZzNTQpjuamCMDpyRwMRkCyXeDThk7pcNkRQhGuCaNpwVLbwG1KIB
 BZpZbuyhVj8pSrVLK9gQ9tDZ6RN0X4uybsX2yhlSVdpa/lvYSun9P42Cb3JH46mAvlOO
 jJmYFusPalIq6XqpscC6ffVqSACsnc4iEnynfj1fZS82Jhev2X2ZJGMkvXAAdROehQKh
 Gd0iqijNV87dQkX1YjOcQvwVz+mGCQKVGInyZ+ZO/ksHC3PVOeB29ds4MOyMZLg08qaZ
 GpRg==
X-Gm-Message-State: AOAM531rAM0WfijfLEtay/huEFbVChWfwAsg1kYPatIe32Le4xbg9uuN
 8XDoeKrdDXsWwhdwDb8J+WJhb67xQgqiULnv
X-Google-Smtp-Source: ABdhPJyrasmGGaAxJPRXfw4LKMA5PPYyBNWl263Ii6r0639nRKMm4Z2AiiOsTyjyOrQcUwGFajgUrQ==
X-Received: by 2002:a17:906:7e0e:: with SMTP id
 e14mr5767452ejr.238.1603323105763; 
 Wed, 21 Oct 2020 16:31:45 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id k23sm2845236ejs.100.2020.10.21.16.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 16:31:44 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 09/11] drm/amd/display: Add formats for DCC with 2/3 planes.
Date: Thu, 22 Oct 2020 01:31:28 +0200
Message-Id: <20201021233130.874615-10-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
References: <20201021233130.874615-1-bas@basnieuwenhuizen.nl>
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
Cc: maraeo@gmail.com, sunpeng.li@amd.com, daniel@ffwll.ch,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, alexdeucher@gmail.com,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For DCC we will use 2/3 planes to avoid X rendering to the frontbuffer
with DCC compressed images. To make this work with the core KMS
validation we need to add extra formats with the extra planes.

However, due to flexibility we set bpp = 0 for the extra planes and
do the validation ourselves.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 034397c1f2b1..6b33e030fe20 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -185,6 +185,9 @@ static bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
 static bool amdgpu_dm_psr_disable(struct dc_stream_state *stream);
 static bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
 
+static const struct drm_format_info *
+amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
+
 /*
  * dm_vblank_get_counter
  *
@@ -2160,6 +2163,7 @@ const struct amdgpu_ip_block_version dm_ip_block =
 
 static const struct drm_mode_config_funcs amdgpu_dm_mode_funcs = {
 	.fb_create = amdgpu_display_user_framebuffer_create,
+	.get_format_info = amd_get_format_info,
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
 	.atomic_check = amdgpu_dm_atomic_check,
 	.atomic_commit = amdgpu_dm_atomic_commit,
@@ -4010,6 +4014,98 @@ modifier_gfx9_swizzle_mode(uint64_t modifier)
 	return AMD_FMT_MOD_GET(TILE, modifier);
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
+static const struct drm_format_info *
+amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd)
+{
+	uint64_t modifier = cmd->modifier[0];
+
+	if (!IS_AMD_FMT_MOD(modifier))
+		return NULL;
+
+	if (AMD_FMT_MOD_GET(DCC_RETILE, modifier))
+		return lookup_format_info(dcc_retile_formats,
+					  ARRAY_SIZE(dcc_retile_formats),
+					  cmd->pixel_format);
+
+	if (AMD_FMT_MOD_GET(DCC, modifier))
+		return lookup_format_info(dcc_formats, ARRAY_SIZE(dcc_formats),
+					  cmd->pixel_format);
+
+	/* returning NULL will cause the default format structs to be used. */
+	return NULL;
+}
+
 static void
 fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
 				    union dc_tiling_info *tiling_info,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
