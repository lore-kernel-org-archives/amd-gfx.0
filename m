Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E10C433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 09:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F33A613BE
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 09:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F33A613BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B366E1CE;
	Tue,  4 May 2021 09:43:34 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF276E1CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 09:43:32 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id l13so7030967wru.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 May 2021 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L/C9gArl2m+YWCqna7d4IVELdSHJhPz5felu8sJRcm4=;
 b=iPVdY9iBS9VRI78iVNTPZPFKwTPJQGk7iOT42Ycl4nSWUM7GIPy0S/1IGiPyoEqY3R
 3OWpHL2UlqJh6wwsKM5QcENSg0TZLbnndeF/NA8nSQgb8m9HdMUF+L81lk3y80llL5o2
 KN0NoH9ykQQ8djLt92Kxh9c/s71DhTT1j78L4K+x5kT6WTbFqT+xGO6u3OV41hOjHCCt
 nNLDmaG228M2+4QJi9XN/Hrr3jL5OHEErjIRzhuYpn+lBXudEEog099uJEsSrfaF7rAx
 P6ERSHYRj6rLyz3g2IlD3FR69vUEpUYUNma4xRWDNy8ax/QKm1jOJSauOnkImujFjiST
 T7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L/C9gArl2m+YWCqna7d4IVELdSHJhPz5felu8sJRcm4=;
 b=WnVQuyXNXQ8MQnMkG5FqemkBzZ6Z1lltXkokXfulFIl9naan6sWdfOq/JPmhBnd9nD
 O9tR/BlQZnLEUoMcAjqBqG5LWx8vWZsu9r6SuTK+rKZGpJSksMgyIbmXt8DXDbeRLQoi
 Cnk1C6hjwZiWUn3P3pZRUu9caLa0B4eblrpyYKN6fg4CIwodmlIz1T0bzGbgrgOLsjz7
 e9z71JAGzHVPDoZzvzJoO0OK0EfWebdhhRIX6pg7m2uc99AYRv0LcNmmgdy7VQy81ZAx
 Owhkm5pUNrFnA3Uezd1WiYPbzBbGYzTPOHtgslic94cRb+08G8C6UwfmIYnCnso9uKRW
 5DJQ==
X-Gm-Message-State: AOAM5305Yizq4GcNSmCrQcy5LZW8Y/e9qp4r5j5vJzArE3cIOLYFXI70
 UoM85Qp0T5a4mYWL5pBoekTD8IY4XZthqw==
X-Google-Smtp-Source: ABdhPJximLingRQ75hubz9TjWAAzYaY3vuwbXJrz6lh8yYpBKTvUaXQuuiq5kj/o1vZg/BQafCpEZA==
X-Received: by 2002:a5d:5488:: with SMTP id h8mr29900245wrv.81.1620121411072; 
 Tue, 04 May 2021 02:43:31 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
 by smtp.gmail.com with ESMTPSA id i11sm15504530wrp.56.2021.05.04.02.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 May 2021 02:43:30 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Use device specific BO size & stride check.
Date: Tue,  4 May 2021 11:43:34 +0200
Message-Id: <20210504094334.1162856-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.31.1
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
Cc: alexdeucher@gmail.com, markyacoub@chromium.org, michel@daenzer.net,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, contact@emersion.fr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The builtin size check isn't really the right thing for AMD
modifiers due to a couple of reasons:

1) In the format structs we don't do set any of the tilesize / blocks
etc. to avoid having format arrays per modifier/GPU
2) The pitch on the main plane is pixel_pitch * bytes_per_pixel even
for tiled ...
3) The pitch for the DCC planes is really the pixel pitch of the main
surface that would be covered by it ...

Note that we only handle GFX9+ case but we do this after converting
the implicit modifier to an explicit modifier, so on GFX9+ all
framebuffers should be checked here.

There is a TODO about DCC alignment, but it isn't worse than before
and I'd need to dig a bunch into the specifics. Getting this out in
a reasonable timeframe to make sure it gets the appropriate testing
seemed more important.

Finally as I've found that debugging addfb2 failures is a pita I was
generous adding explicit error messages to every failure case.

Fixes: f258907fdd83 ("drm/amdgpu: Verify bo size can fit framebuffer size on init.")
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---

For drm-fixes, replaces the 'Revert "drm/amdgpu: Verify bo size can fit framebuffer size on init."'
revert on the ML, intended for -fixes.
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 181 +++++++++++++++++++-
 1 file changed, 175 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 2e622c1675d7..80d81774fda8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -837,6 +837,174 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 	return 0;
 }
 
+static void get_block_dimensions(unsigned int block_log2, unsigned int cpp,
+				 unsigned int *width, unsigned int *height)
+{
+	unsigned int cpp_log2 = ilog2(cpp);
+	unsigned int pixel_log2 = block_log2 - cpp_log2;
+	unsigned int width_log2 = (pixel_log2 + 1) / 2;
+	unsigned int height_log2 = pixel_log2 - width_log2;
+
+	*width = 1 << width_log2;
+	*height = 1 << height_log2;
+}
+
+static unsigned int get_dcc_block_size(uint64_t modifier, bool rb_aligned,
+				       bool pipe_aligned)
+{
+	unsigned int ver = AMD_FMT_MOD_GET(TILE_VERSION, modifier);
+
+	switch (ver) {
+	case AMD_FMT_MOD_TILE_VER_GFX9: {
+		/*
+		 * TODO: for pipe aligned we may need to check the alignment of the
+		 * total size of the surface, which may need to be bigger than the
+		 * natural alignment due to some HW workarounds
+		 */
+		return max(10 + (rb_aligned ? (int)AMD_FMT_MOD_GET(RB, modifier) : 0), 12);
+	}
+	case AMD_FMT_MOD_TILE_VER_GFX10:
+	case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS: {
+		int pipes_log2 = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
+
+		if (ver == AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS && pipes_log2 > 1 &&
+		    AMD_FMT_MOD_GET(PACKERS, modifier) == pipes_log2)
+			++pipes_log2;
+
+		return max(8 + (pipe_aligned ? pipes_log2 : 0), 12);
+	}
+	default:
+		return 0;
+	}
+}
+
+static int amdgpu_display_verify_plane(struct amdgpu_framebuffer *rfb, int plane,
+				       const struct drm_format_info *format,
+				       unsigned int block_width, unsigned int block_height,
+				       unsigned int block_size_log2)
+{
+	unsigned int width = rfb->base.width /
+		((plane && plane < format->num_planes) ? format->hsub : 1);
+	unsigned int height = rfb->base.height /
+		((plane && plane < format->num_planes) ? format->vsub : 1);
+	unsigned int cpp = plane < format->num_planes ? format->cpp[plane] : 1;
+	unsigned int block_pitch = block_width * cpp;
+	unsigned int min_pitch = ALIGN(width * cpp, block_pitch);
+	unsigned int block_size = 1 << block_size_log2;
+	uint64_t size;
+
+	if (rfb->base.pitches[plane] % block_pitch) {
+		drm_dbg_kms(rfb->base.dev,
+			    "pitch %d for plane %d is not a multiple of block pitch %d\n",
+			    rfb->base.pitches[plane], plane, block_pitch);
+		return -EINVAL;
+	}
+	if (rfb->base.pitches[plane] < min_pitch) {
+		drm_dbg_kms(rfb->base.dev,
+			    "pitch %d for plane %d is less than minimum pitch %d\n",
+			    rfb->base.pitches[plane], plane, min_pitch);
+		return -EINVAL;
+	}
+
+	/* Force at least natural alignment. */
+	if (rfb->base.offsets[plane] % block_size) {
+		drm_dbg_kms(rfb->base.dev,
+			    "offset 0x%x for plane %d is not a multiple of block pitch 0x%x\n",
+			    rfb->base.offsets[plane], plane, block_size);
+		return -EINVAL;
+	}
+
+	size = rfb->base.offsets[plane] +
+		(uint64_t)rfb->base.pitches[plane] / block_pitch *
+		block_size * DIV_ROUND_UP(height, block_height);
+
+	if (rfb->base.obj[0]->size < size) {
+		drm_dbg_kms(rfb->base.dev,
+			    "BO size 0x%zx is less than 0x%llx required for plane %d\n",
+			    rfb->base.obj[0]->size, size, plane);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
+{
+	const struct drm_format_info *format_info = drm_format_info(rfb->base.format->format);
+	uint64_t modifier = rfb->base.modifier;
+	int ret;
+	unsigned int i, block_width, block_height, block_size_log2;
+
+	if (!rfb->base.dev->mode_config.allow_fb_modifiers)
+		return 0;
+
+	for (i = 0; i < format_info->num_planes; ++i) {
+		if (modifier == DRM_FORMAT_MOD_LINEAR) {
+			block_width = 256 / format_info->cpp[i];
+			block_height = 1;
+			block_size_log2 = 8;
+		} else {
+			int swizzle = AMD_FMT_MOD_GET(TILE, modifier);
+
+			switch ((swizzle & ~3) + 1) {
+			case DC_SW_256B_S:
+				block_size_log2 = 8;
+				break;
+			case DC_SW_4KB_S:
+			case DC_SW_4KB_S_X:
+				block_size_log2 = 12;
+				break;
+			case DC_SW_64KB_S:
+			case DC_SW_64KB_S_T:
+			case DC_SW_64KB_S_X:
+				block_size_log2 = 16;
+				break;
+			default:
+				drm_dbg_kms(rfb->base.dev,
+					    "Swizzle mode with unknown block size: %d\n", swizzle);
+				return -EINVAL;
+			}
+
+			get_block_dimensions(block_size_log2, format_info->cpp[i],
+					     &block_width, &block_height);
+		}
+
+		ret = amdgpu_display_verify_plane(rfb, i, format_info,
+						  block_width, block_height, block_size_log2);
+		if (ret)
+			return ret;
+	}
+
+	if (AMD_FMT_MOD_GET(DCC, modifier)) {
+		if (AMD_FMT_MOD_GET(DCC_RETILE, modifier)) {
+			block_size_log2 = get_dcc_block_size(modifier, false, false);
+			get_block_dimensions(block_size_log2 + 8, format_info->cpp[0],
+					     &block_width, &block_height);
+			ret = amdgpu_display_verify_plane(rfb, i, format_info,
+							  block_width, block_height,
+							  block_size_log2);
+			if (ret)
+				return ret;
+
+			++i;
+			block_size_log2 = get_dcc_block_size(modifier, true, true);
+		} else {
+			bool pipe_aligned = AMD_FMT_MOD_GET(DCC_PIPE_ALIGN, modifier);
+
+			block_size_log2 = get_dcc_block_size(modifier, true, pipe_aligned);
+		}
+		get_block_dimensions(block_size_log2 + 8, format_info->cpp[0],
+				     &block_width, &block_height);
+		ret = amdgpu_display_verify_plane(rfb, i, format_info,
+						  block_width, block_height, block_size_log2);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb,
 				      uint64_t *tiling_flags, bool *tmz_surface)
 {
@@ -902,10 +1070,8 @@ int amdgpu_display_gem_fb_verify_and_init(
 	int ret;
 
 	rfb->base.obj[0] = obj;
-
-	/* Verify that bo size can fit the fb size. */
-	ret = drm_gem_fb_init_with_funcs(dev, &rfb->base, file_priv, mode_cmd,
-					 &amdgpu_fb_funcs);
+	drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
+	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
 	if (ret)
 		goto err;
 	/* Verify that the modifier is supported. */
@@ -967,9 +1133,12 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 		}
 	}
 
-	for (i = 1; i < rfb->base.format->num_planes; ++i) {
+	ret = amdgpu_display_verify_sizes(rfb);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < rfb->base.format->num_planes; ++i) {
 		drm_gem_object_get(rfb->base.obj[0]);
-		drm_gem_object_put(rfb->base.obj[i]);
 		rfb->base.obj[i] = rfb->base.obj[0];
 	}
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
