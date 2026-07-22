Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0A2C4453F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 16:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF8010E4C3;
	Wed, 22 Jul 2026 16:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LyGMuL4v";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F0610EE56
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 16:59:40 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4956242332dso29655205e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784739579; x=1785344379; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0KvbofwtghnP7MV8GNGaBkS4sVxatALZ05fdEddLx8E=;
 b=LyGMuL4vm/t+GUNjQZk9+NQC5fuVqc9nMJv68YMGlkYEjtwunv2wgX6E1zGbw3dKuC
 LTl8k47a9mdD/AeDyHKs0LHBB8LWfdK1uhZo92pOickFClS0h8saS4UBmPp7b3sZyjPO
 0aMxm1TIEj/7YwMkvFK9GyI5haubcj7ri2M0XXri0CWBrx4plMYZmvxy9+7PB1E8KMIn
 EwLqU3pMqNFcKscm0bUO5YGuYVbrIPZYx6z+Gr/FAvdyymAYOUdFZLDAQoZetsRciUFQ
 CjWhsUwhBRFtdmFAnovoeuE90WLCpGcLmH51+slls/0uOVOOVKnbgpzgYY2+KyhJPS53
 rhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739579; x=1785344379;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0KvbofwtghnP7MV8GNGaBkS4sVxatALZ05fdEddLx8E=;
 b=ZmjPsJTx/SyeeMhQ3n1Tglkqp4J0fE4WxrJRzT3X7ekPV6lhvcjVYqQk0PI66lYjrG
 e7ukI3Pc8lmSuFiCTlJTo35KVSzyQ3XAj9mTXXO7nK902v9pElRi91Srq1tseD+voFDY
 CUen9tIH1dIekrhjTJTs9Bmo+M1sPgJ2nAnlXeHnvOWoOf+vu6fk037ILqV7G9ybK0Oy
 lFQoh916VHGmq4lPsfeIiT423TZYXuj/ljx3vE14HM321BmthRssDtYXVNVZdaazasXJ
 CPfjD3Vo20/tmx4fX9plx2gUpCCqgqQfYNDEwOqOuuPiQdT/xlVvm4H8xTHRZ3XhyG1J
 Ijeg==
X-Gm-Message-State: AOJu0YybJQJa/XZFF/J6cdfEA8NawwzcWzR9LDCCq+aw4ijR9N6FID6p
 pYEcL64tedQuk4ycHtEmHHR4ntUgJOwf/RB0JjV3r4BRFnGzT5BHL0k0pvkG07Zk
X-Gm-Gg: AR+sD127Gkknnhd7P75SaGQTMVDiAXWUTUnQGsB7QhEsjnDmpayp44O8/xPOKtZudJr
 N7Zzu2j5eLFlL/zSivtcSc8U6vm1D4/srJOvnm5o+e9xx9HyKtTU8M37MV/1Ct7NiaSBw7D5QeG
 jOCbXHI6qfCd80HeCP1ZCiECC9Y3NMSNsNpSx8suqcnIZHDu48i+B1onAmstgCE2F/wcQDXyfca
 XzkSkv5erjVnw+hVyf7m+mi8QRjJ5pPOzrtQGl/D/bdtWH1nRjKhx7vHXud44jPzhuA32hmmko0
 L0gNPrDlWZfX5zyEeqAD1pxP8dAMvcfva1mN+nthBh/yuX2FTNKqFOk5C+7ahQxFqIyfl/b1VDR
 JKmws0GDktSzOBcA+my47ar5RP0+SQo1aHgw+FjMWnQCrzjsOMLja8O5i6QPbBQrmLslijCuBTp
 654ZE=
X-Received: by 2002:a05:600c:6a0b:b0:493:c453:6002 with SMTP id
 5b1f17b1804b1-4954a516453mr158865155e9.35.1784739578420; 
 Wed, 22 Jul 2026 09:59:38 -0700 (PDT)
Received: from Timur-Max ([62.77.225.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956ab41aa2sm68369615e9.1.2026.07.22.09.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:59:37 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Link Mauve <linkmauve@linkmauve.fr>,
 =?UTF-8?q?Nikola=20Medi=C4=87?= <nmedic89@gmail.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Daniel Stone <daniels@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Dieter=20N=C3=BCtzel?= <Dieter@nuetzel-hh.de>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, airlied@gmail.com,
 simona.vetter@ffwll.ch
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/4] drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
Date: Wed, 22 Jul 2026 18:59:23 +0200
Message-ID: <20260722165925.15805-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722165925.15805-1-timur.kristof@gmail.com>
References: <20260722165925.15805-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This is done for consistency between different GPU generations.

Tiling flags are "implicit modifiers" which are used on AMD GPUs
to let the kernel know the tiling information without modifiers.
Convert the tiling flags to modifers on GFX8 and older, so that
the DC display driver can rely on them like on newer generations.

Note that this code path will only be taken when DC actually
exposes any modifiers on GFX6-8, which is handled in a subsequent
commit after this one. This code path mainly exists for legacy
compositors which don't support explicit DRM format modifiers
and rely on the tiling flags, and for compatibility with old
Mesa that didn't support modifiers on GFX6-8.

Add amdgpu_display_verify_sizes_gfx6() to validate modifiers
on GFX6-8 and only accept the modes that the display driver
really supports, as well as validate the FB sizes.

Additionally adjust check_tiling_flags_gfx6() to allow the
LINEAR_GENERAL mode and disallow the ROTATED mode which has
never been supported by Mesa or Linux and was mistakenly
allowed previously.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Link Mauve <linkmauve@linkmauve.fr>
Tested-by: Nikola Medić <nmedic89@gmail.com>
Tested-by: Dieter Nützel <Dieter@nuetzel-hh.de>
Reviewed-by: Marek Olšák <maraeo@gmail.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 177 ++++++++++++++++++--
 1 file changed, 165 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index f5cd68542442..59ea338b554c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -746,7 +746,7 @@ static int convert_tiling_flags_to_modifier_gfx12(struct amdgpu_framebuffer *afb
 	return 0;
 }
 
-static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
+static int convert_tiling_flags_to_modifier_gfx9(struct amdgpu_framebuffer *afb)
 {
 	struct amdgpu_device *adev = drm_to_adev(afb->base.dev);
 	uint64_t modifier = 0;
@@ -940,25 +940,85 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 	return 0;
 }
 
-/* Mirrors the is_displayable check in radeonsi's gfx6_compute_surface */
+static int convert_tiling_flags_to_modifier_gfx6(struct amdgpu_framebuffer *afb)
+{
+	const uint32_t array_mode = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE);
+	const uint32_t pipe_config = AMDGPU_TILING_GET(afb->tiling_flags, PIPE_CONFIG);
+	const uint32_t tile_split = AMDGPU_TILING_GET(afb->tiling_flags, TILE_SPLIT);
+	const uint32_t micro_tile_mode = AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE);
+	const uint32_t bank_width = AMDGPU_TILING_GET(afb->tiling_flags, BANK_WIDTH);
+	const uint32_t bank_height = AMDGPU_TILING_GET(afb->tiling_flags, BANK_HEIGHT);
+	const uint32_t macro_tile_aspect = AMDGPU_TILING_GET(afb->tiling_flags, MACRO_TILE_ASPECT);
+	const uint32_t num_banks = AMDGPU_TILING_GET(afb->tiling_flags, NUM_BANKS);
+	struct amdgpu_device *adev = drm_to_adev(afb->base.dev);
+	uint64_t modifier = 0;
+
+	switch (array_mode) {
+	case DC_ARRAY_LINEAR_GENERAL:
+	case DC_ARRAY_LINEAR_ALLIGNED:
+		modifier = DRM_FORMAT_MOD_LINEAR;
+		break;
+
+	case DC_ARRAY_2D_TILED_THIN1:
+		/* Macro tiled modes only */
+		modifier |=
+			AMD_FMT_MOD_SET(PIPE_CONFIG, pipe_config) |
+			AMD_FMT_MOD_SET(TILE_SPLIT, tile_split) |
+			AMD_FMT_MOD_SET(BANK_WIDTH, bank_width) |
+			AMD_FMT_MOD_SET(BANK_HEIGHT, bank_height) |
+			AMD_FMT_MOD_SET(MACRO_TILE_ASPECT, macro_tile_aspect) |
+			AMD_FMT_MOD_SET(NUM_BANKS, num_banks);
+		fallthrough;
+
+	case DC_ARRAY_1D_TILED_THIN1:
+		/* Micro and macro tiled modes */
+		modifier |=
+			AMD_FMT_MOD |
+			AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+			AMD_FMT_MOD_SET(TILE, array_mode) |
+			AMD_FMT_MOD_SET(MICROTILE, micro_tile_mode);
+		break;
+
+	default:
+		drm_dbg_kms(&adev->ddev, "array mode 0x%x not supported\n", array_mode);
+		return -EINVAL;
+	}
+
+	afb->base.modifier = modifier;
+	afb->base.flags |= DRM_MODE_FB_MODIFIERS;
+	return 0;
+}
+
 static int check_tiling_flags_gfx6(struct amdgpu_framebuffer *afb)
 {
-	u64 micro_tile_mode;
+	const u64 array_mode = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE);
+	const u64 micro_tile_mode = AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE);
 
-	if (AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) == 1) /* LINEAR_ALIGNED */
+	/* LINEAR_GENERAL, LINEAR_ALIGNED */
+	if (array_mode == 0 || array_mode == 1)
 		return 0;
 
-	micro_tile_mode = AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE);
-	switch (micro_tile_mode) {
-	case 0: /* DISPLAY */
-	case 3: /* RENDER */
-		return 0;
-	default:
+	/* 1D_TILED_THIN1, 2D_TILED_THIN1 */
+	if (array_mode != 2 && array_mode != 4) {
+		drm_dbg_kms(afb->base.dev,
+			    "Array mode %llu not supported for scanout\n",
+			    array_mode);
+		return -EINVAL;
+	}
+
+	/*
+	 * For now, only allow DISPLAY micro tile mode.
+	 * THIN, DEPTH and THICK modes are not displayable.
+	 * ROTATED has never been supported by Linux or Mesa.
+	 */
+	if (micro_tile_mode != 0) {
 		drm_dbg_kms(afb->base.dev,
 			    "Micro tile mode %llu not supported for scanout\n",
 			    micro_tile_mode);
 		return -EINVAL;
 	}
+
+	return 0;
 }
 
 static void get_block_dimensions(unsigned int block_log2, unsigned int cpp,
@@ -1053,6 +1113,85 @@ static int amdgpu_display_verify_plane(struct amdgpu_framebuffer *rfb, int plane
 	return 0;
 }
 
+static int amdgpu_display_verify_sizes_gfx6(struct drm_device *dev,
+					    const u64 modifier,
+					    unsigned int *out_block_width,
+					    unsigned int *out_block_height)
+{
+	const u32 display_micro_tile_pitch = 32; /* required by DCE */
+	const u32 micro_tile_width = 8;
+	const u32 micro_tile_height = 8;
+	const u32 micro_tile_mode = AMD_FMT_MOD_GET(MICROTILE, modifier);
+	const u32 array_mode = AMD_FMT_MOD_GET(TILE, modifier);
+	u32 num_banks, bank_width, bank_height, pipe_config, macro_tile_aspect;
+	u32 num_pipes;
+
+	if (AMD_FMT_MOD_GET(DCC, modifier)) {
+		drm_dbg_kms(dev, "DCC is not displayable on GFX6-8\n");
+		return -EINVAL;
+	}
+	if (array_mode != AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 &&
+	    array_mode != AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
+		drm_dbg_kms(dev, "Array mode %u not supported for scanout\n", array_mode);
+		return -EINVAL;
+	}
+	if (micro_tile_mode != AMD_FMT_MOD_MICROTILE_DISPLAY) {
+		drm_dbg_kms(dev, "Microtile mode %u not supported for scanout\n", micro_tile_mode);
+		return -EINVAL;
+	}
+
+	num_banks = 2 << AMD_FMT_MOD_GET(NUM_BANKS, modifier);
+	bank_width = 1 << AMD_FMT_MOD_GET(BANK_WIDTH, modifier);
+	bank_height = 1 << AMD_FMT_MOD_GET(BANK_HEIGHT, modifier);
+	pipe_config = AMD_FMT_MOD_GET(PIPE_CONFIG, modifier);
+	macro_tile_aspect = 1 << AMD_FMT_MOD_GET(MACRO_TILE_ASPECT, modifier);
+
+	switch (pipe_config) {
+	case AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_8x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_16x16:
+		num_pipes = 16;
+		break;
+
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_16x16_8x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_8x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_8x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_16x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x32:
+	case AMD_FMT_MOD_PIPE_CONFIG_P8_32x64_32x32:
+		num_pipes = 8;
+		break;
+
+	case AMD_FMT_MOD_PIPE_CONFIG_P4_8x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P4_16x16:
+	case AMD_FMT_MOD_PIPE_CONFIG_P4_16x32:
+	case AMD_FMT_MOD_PIPE_CONFIG_P4_32x32:
+		num_pipes = 4;
+		break;
+
+	case AMD_FMT_MOD_PIPE_CONFIG_P2:
+		num_pipes = 2;
+		break;
+
+	default:
+		drm_dbg_kms(dev, "Pipe config %u invalid\n", pipe_config);
+		return -EINVAL;
+	}
+
+	/* For reference, see SiLib::InitEquationTable() in addrlib */
+	if (array_mode < AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
+		*out_block_width = display_micro_tile_pitch;
+		*out_block_height = micro_tile_height;
+	} else {
+		/* Assume non-PRT macro tiling modes */
+		*out_block_width = num_pipes * micro_tile_width *
+				   bank_width * macro_tile_aspect;
+		*out_block_height = micro_tile_height * bank_height *
+				    num_banks / macro_tile_aspect;
+	}
+
+	return 0;
+}
 
 static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 {
@@ -1093,7 +1232,7 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 
 			get_block_dimensions(block_size_log2, format_info->cpp[i],
 					     &block_width, &block_height);
-		} else {
+		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) >= AMD_FMT_MOD_TILE_VER_GFX9) {
 			int swizzle = AMD_FMT_MOD_GET(TILE, modifier);
 
 			switch ((swizzle & ~3) + 1) {
@@ -1120,6 +1259,18 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 
 			get_block_dimensions(block_size_log2, format_info->cpp[i],
 					     &block_width, &block_height);
+		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX6) {
+			ret = amdgpu_display_verify_sizes_gfx6(rfb->base.dev, modifier,
+							       &block_width, &block_height);
+			if (ret)
+				return ret;
+
+			/* amdgpu_display_verify_plane() assumes the block size is a power of 2 */
+			WARN_ON(!is_power_of_2(block_width));
+			WARN_ON(!is_power_of_2(block_height));
+			WARN_ON(!is_power_of_2(format_info->cpp[i]));
+
+			block_size_log2 = ilog2(block_width * block_height * format_info->cpp[i]);
 		}
 
 		ret = amdgpu_display_verify_plane(rfb, i, format_info,
@@ -1271,8 +1422,10 @@ static int amdgpu_display_framebuffer_init(struct drm_device *dev,
 	    !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0))
 			ret = convert_tiling_flags_to_modifier_gfx12(rfb);
+		else if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 0, 0))
+			ret = convert_tiling_flags_to_modifier_gfx9(rfb);
 		else
-			ret = convert_tiling_flags_to_modifier(rfb);
+			ret = convert_tiling_flags_to_modifier_gfx6(rfb);
 
 		if (ret) {
 			drm_dbg_kms(dev, "Failed to convert tiling flags 0x%llX to a modifier",
-- 
2.55.0

