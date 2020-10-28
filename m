Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA55C56201
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03DC2071A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="R4Kena3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03DC2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F57B6E820;
	Wed, 28 Oct 2020 23:52:49 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF33B6E820
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 23:52:47 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id gs25so1409057ejb.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=huoahXa7QObEqf+o9Ukou9QES8eFlLH0pYIIV9MhYRk=;
 b=R4Kena3wnlFMfEqorvOEhvHaEbQBNZEcamgAtcsenQyHP8OMaJzuvHUU3W+hwQ/I12
 J4N+Iyp8gHYgLout+EtBvFjfpm2j1ZQZ+EfIrBG4NOPjqF7rYWb7RX9e94bK2jganz26
 4m9rhqf9H6Oa80R15t8iz84FZfcVXjVc6yV7Tf+3xIMYShkGX7Y93r39bD8sw4xWk40O
 TRMyxIiXMXp95ray9uB/lVnFElaGx9Dj34R07MDBpB20EmFIG/JeOjaikVEmne+m4M/F
 3kjtYro8jR7xjipeXF05SS6NDqUDDMzOl+2pLbLmUo33G1smeovadOT+erXBGwewBljs
 61Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=huoahXa7QObEqf+o9Ukou9QES8eFlLH0pYIIV9MhYRk=;
 b=VKWNSrT4U6iUAp5DNV4giw/GLxdKR9JZoye8ioz6UjRJVOGxmEb3xi9Hv/hYh1t/EU
 4gZ0RrtQuXIDswcFVYjBaDHQ2QNEVwgXoPO5cw+/8KMv5tsATtN6lhLYAIKxVAMfdId9
 +iobvjfADUxuwenfvffOKLizZeDTtAGudxI8AIxJjDf8WVXOz3tnSXN3g7U7N8S6mDCg
 kGhllO3a84AyZT1u/LjUwe14ammjCJm0ZGoVrPJKW/0B0MNLStSaCpRM6Mk57fbnxaZc
 TFezfYzgG5eBcBd6BvV/hZeeUUfdVvWSONIFJ0MK8UvFDbAKst8VnhKio9f3yOWcZNIe
 Tcow==
X-Gm-Message-State: AOAM533LU7sj+KqNcCvnlefUBim7z6v/DBf5MY3F/rvDJGVwA19YN6mG
 jN8hCK4GJgetYRgtosyiE3SxIgOC4qT8Tw==
X-Google-Smtp-Source: ABdhPJyJQN5YWAgSi2bQXjINX260mCJo/qaVNu7VyiyssRb7C5lZniz9F1yjcpEQAzBPCGCHvB7IcQ==
X-Received: by 2002:a17:906:a10a:: with SMTP id
 t10mr1587453ejy.89.1603929166083; 
 Wed, 28 Oct 2020 16:52:46 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id o13sm479174ejr.120.2020.10.28.16.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 16:52:45 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 06/11] drm/amd/display: Convert tiling_flags to modifiers.
Date: Thu, 29 Oct 2020 00:52:36 +0100
Message-Id: <20201028235241.3299-7-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028235241.3299-1-bas@basnieuwenhuizen.nl>
References: <20201028235241.3299-1-bas@basnieuwenhuizen.nl>
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
Cc: alexdeucher@gmail.com, Alex Deucher <alexander.deucher@amd.com>,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This way the modifier path gets exercised all the time, improving
testing. Furthermore, for modifiers this is required as getfb2
will always return the modifier if the driver sets allow_fb_modifiers.

This only triggers once allow_fb_modifiers is set.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 123 ++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 1a2664c3fc26..89c3ead36501 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -38,6 +38,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_vblank.h>
 
 static void amdgpu_display_flip_callback(struct dma_fence *f,
@@ -541,6 +542,121 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	return domain;
 }
 
+static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
+{
+	struct amdgpu_device *adev = drm_to_adev(afb->base.dev);
+	uint64_t modifier = 0;
+
+	if (!afb->tiling_flags || !AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE)) {
+		modifier = DRM_FORMAT_MOD_LINEAR;
+	} else {
+		int swizzle = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE);
+		bool has_xor = swizzle >= 16;
+		int block_size_bits;
+		int version;
+		int pipe_xor_bits = 0;
+		int bank_xor_bits = 0;
+		int packers = 0;
+		uint32_t dcc_offset = AMDGPU_TILING_GET(afb->tiling_flags, DCC_OFFSET_256B);
+
+		switch (swizzle >> 2) {
+		case 0: /* 256B */
+			block_size_bits = 8;
+			break;
+		case 1: /* 4KiB */
+		case 5: /* 4KiB _X */
+			block_size_bits = 12;
+			break;
+		case 2: /* 64KiB */
+		case 4: /* 64 KiB _T */
+		case 6: /* 64 KiB _X */
+			block_size_bits = 16;
+			break;
+		default:
+			/* RESERVED or VAR */
+			return -EINVAL;
+		}
+
+		if (adev->asic_type >= CHIP_SIENNA_CICHLID)
+			version = AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
+		else if (adev->family == AMDGPU_FAMILY_NV)
+			version = AMD_FMT_MOD_TILE_VER_GFX10;
+		else
+			version = AMD_FMT_MOD_TILE_VER_GFX9;
+
+		switch (swizzle & 3) {
+		case 0: /* Z microtiling */
+			return -EINVAL;
+		case 1: /* S microtiling */
+			if (!has_xor)
+				version = AMD_FMT_MOD_TILE_VER_GFX9;
+			break;
+		case 2:
+			if (!has_xor && afb->base.format->cpp[0] != 4)
+				version = AMD_FMT_MOD_TILE_VER_GFX9;
+			break;
+		case 3:
+			break;
+		}
+
+		if (has_xor) {
+			switch (version) {
+			case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:
+				pipe_xor_bits = min(block_size_bits - 8,
+						    ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes));
+				packers = min(block_size_bits - 8 - pipe_xor_bits,
+					      ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs));
+				break;
+			case AMD_FMT_MOD_TILE_VER_GFX10:
+				pipe_xor_bits = min(block_size_bits - 8,
+						    ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes));
+				break;
+			case AMD_FMT_MOD_TILE_VER_GFX9:
+				pipe_xor_bits = min(block_size_bits - 8,
+						    ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes) +
+						    ilog2(adev->gfx.config.gb_addr_config_fields.num_se));
+				bank_xor_bits = min(block_size_bits - 8 - pipe_xor_bits,
+						    ilog2(adev->gfx.config.gb_addr_config_fields.num_banks));
+				break;
+			}
+		}
+
+		modifier = AMD_FMT_MOD |
+			   AMD_FMT_MOD_SET(TILE, AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE)) |
+			   AMD_FMT_MOD_SET(TILE_VERSION, version) |
+			   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+			   AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+			   AMD_FMT_MOD_SET(PACKERS, packers);
+
+		if (dcc_offset != 0) {
+			bool dcc_i64b = AMDGPU_TILING_GET(afb->tiling_flags, DCC_INDEPENDENT_64B) != 0;
+			bool dcc_i128b = version >= AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
+
+			/* Enable constant encode on RAVEN2 and later. */
+			bool dcc_constant_encode = adev->asic_type > CHIP_RAVEN ||
+						   (adev->asic_type == CHIP_RAVEN &&
+						    adev->external_rev_id >= 0x81);
+
+			int max_cblock_size = dcc_i64b ? AMD_FMT_MOD_DCC_BLOCK_64B :
+					      dcc_i128b ? AMD_FMT_MOD_DCC_BLOCK_128B :
+					      AMD_FMT_MOD_DCC_BLOCK_256B;
+
+			modifier |= AMD_FMT_MOD_SET(DCC, 1) |
+				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, dcc_constant_encode) |
+				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, dcc_i64b) |
+				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, dcc_i128b) |
+				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, max_cblock_size);
+
+			afb->base.offsets[1] = dcc_offset * 256 + afb->base.offsets[0];
+			afb->base.pitches[1] = AMDGPU_TILING_GET(afb->tiling_flags, DCC_PITCH_MAX) + 1;
+		}
+	}
+
+	afb->base.modifier = modifier;
+	afb->base.flags |= DRM_MODE_FB_MODIFIERS;
+	return 0;
+}
+
 static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb,
 				      uint64_t *tiling_flags, bool *tmz_surface)
 {
@@ -590,6 +706,13 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 	if (ret)
 		goto fail;
 
+	if (dev->mode_config.allow_fb_modifiers &&
+	    !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
+		ret = convert_tiling_flags_to_modifier(rfb);
+		if (ret)
+			goto fail;
+	}
+
 	return 0;
 
 fail:
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
