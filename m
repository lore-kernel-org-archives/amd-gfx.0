Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A27CD4F25
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6853210F05C;
	Wed, 13 May 2026 20:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PPPA7Xj9";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADDB610F05A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:43:29 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso4579555f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778705008; x=1779309808; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ir74CLLiQOUBe8V0c5PWlS0bD6Uuf/ALVrfnhEoRtBg=;
 b=PPPA7Xj9ZhycILl17X+JI+AopYwMlH5k0CPoV4mHAZeTYFFM1DhoFnDDlFj6BKArFz
 NVbVffzmYXmvau0mXEeFY1nENw7Xj3bdFsyOGTxn5iB5e2m2zqjJ8p1/hHW9SLDbhrjA
 DSvgXMCUxDItG41YvYGY4IDpqSL6m5nYgJqJusReAdPpY/GkcyS2BQHjnp6f+2pu1b1b
 fqCvklSn1E+dej9XQQ3UX/ap6Q0WTsyPIX9TazFxVefhgriW8ZwT+xUK/VBaT5sEcNBP
 T9Q3+4lCBa5c525de68V+OhXcMe5ff/xGWEY/QiuF2+9EjT1UcwH5vLsA71ZFhZQrrf1
 S/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778705008; x=1779309808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ir74CLLiQOUBe8V0c5PWlS0bD6Uuf/ALVrfnhEoRtBg=;
 b=BAr4QswF6/iOxcrsyTh4+rdGsuM7N7TLWai7t+KZKTSWjTXvngP1vg3u8NKNgSZ987
 xdo94nqOHNWxyyBfc5AfQf2fykzrwzV23A5GzxRanUqykaU6XubbIKPtBYhqksxkfRpe
 +4Lsp62cmYYO4vIrErdmNElI8erLoR9s6Alt/iGL3XDKRk1dau5xPMwxw6A7ZaY8yJlE
 DHDh3E2vlo1XzMU+0J/eYd5MDRpncxh1C6jtUafsZo5s9397c2ScpabOGMZ8730xTnke
 0WMnY5tmQ9jXwSeyBDw9+Gd8AOz09+1bpwr+gUaImMv++ezlYltvLx1HItSPZISPocZR
 uabg==
X-Gm-Message-State: AOJu0YwEvhm5K7VT5G1DXJ+BYU00SbhAOaH+5k4PcYSKSbxNW8r6f0aE
 e6Eih+bO5/0LN80OyqGSPTtHt5QI3R07CKlRxPEWrso1lPnewVq2LV48LXH7mxOs
X-Gm-Gg: Acq92OGPuz9jzCnejC8vKEZeL+Bg9trYwJEeUDyHt5Q3jIzEEZkM8gTjODkVrSsT4VR
 Z0spHh4z6k33PnXwSlc9fPIrDx19numiL+GGd7Su+pWkWJ5qVFxvI3Uis+8dhmz1hHu4iBPBI+F
 9gydtQOFzFK77GswPsGzylG6L/sJgeSUNuc4NS8MAhkPPLVVM9TF4Z/GMiwkqP2KAJ38crnLAaH
 2Z8ZHKKiF9zMN6sqVtE29PzjYfZPGgkJFl934F20MOCRoP0efn/S7AaHAg79+P6ADMR08Nt9MnA
 oHS7W/37zkxpher21coJ3zv/S+/pJMBL2rwnxz46cbv0e6SwH5ris242+Yt3T4rIa57uawJwc3V
 9fnmjy+MvvtYBqDeeRb8Owp+RVMJzbYBoWhkoon90l5uZtCPXdF9gjtCUVFO5reVOsXpSnI5H52
 Dd8gnItcKpLTDnXQPCPiNriUQIEuKgcQRQy3iNRxx/J+2M8lKcQRnhslBxKPsekabs
X-Received: by 2002:a05:6000:4027:b0:43d:733f:aee6 with SMTP id
 ffacd0b85a97d-45c583b2a1emr7887022f8f.10.1778705008071; 
 Wed, 13 May 2026 13:43:28 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm1308356f8f.21.2026.05.13.13.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:43:27 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH 2/4] drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
Date: Wed, 13 May 2026 22:43:20 +0200
Message-ID: <20260513204322.73542-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513204322.73542-1-timur.kristof@gmail.com>
References: <20260513204322.73542-1-timur.kristof@gmail.com>
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
Convert the tiling flags to modifers on GFX8 and older, so that
the DC display driver can rely on them like on newer generations.

Note that this code path will only be taken when DC actually
exposes any modifiers on GFX6-8, which is handled in a subsequent
commit after this one.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Link Mauve <linkmauve@linkmauve.fr>
Reviewed-by: Marek Olšák <maraeo@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 111 +++++++++++++++++++-
 1 file changed, 108 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 950937b363fb..dcca930ed3c0 100644
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
@@ -940,6 +940,55 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 	return 0;
 }
 
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
+		drm_err(&adev->ddev, "array mode 0x%x not supported by DCE\n", array_mode);
+		return -EINVAL;
+	}
+
+	afb->base.modifier = modifier;
+	afb->base.flags |= DRM_MODE_FB_MODIFIERS;
+	return 0;
+}
+
 /* Mirrors the is_displayable check in radeonsi's gfx6_compute_surface */
 static int check_tiling_flags_gfx6(struct amdgpu_framebuffer *afb)
 {
@@ -1093,7 +1142,7 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 
 			get_block_dimensions(block_size_log2, format_info->cpp[i],
 					     &block_width, &block_height);
-		} else {
+		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) >= AMD_FMT_MOD_TILE_VER_GFX9) {
 			int swizzle = AMD_FMT_MOD_GET(TILE, modifier);
 
 			switch ((swizzle & ~3) + 1) {
@@ -1120,6 +1169,60 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 
 			get_block_dimensions(block_size_log2, format_info->cpp[i],
 					     &block_width, &block_height);
+		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX6) {
+			const u32 display_micro_tile_pitch = 32; /* required by DCE */
+			const u32 micro_tile_width = 8;
+			const u32 micro_tile_height = 8;
+			const u32 micro_tile_mode = AMD_FMT_MOD_GET(MICROTILE, modifier);
+			const u32 array_mode = AMD_FMT_MOD_GET(TILE, modifier);
+			u32 num_banks, bank_width, bank_height, pipe_config, macro_tile_aspect;
+			u32 num_pipes;
+
+			if (AMD_FMT_MOD_GET(DCC, modifier)) {
+				drm_dbg_kms(rfb->base.dev, "DCC is not displayable on GFX6-8\n");
+				return -EINVAL;
+			}
+			if (array_mode != AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 &&
+			    array_mode != AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
+				drm_dbg_kms(rfb->base.dev,
+					"Array mode %u is not supported by the display driver\n",
+					array_mode);
+				return -EINVAL;
+			}
+			if (micro_tile_mode != AMD_FMT_MOD_MICROTILE_DISPLAY) {
+				drm_dbg_kms(rfb->base.dev,
+					"Micro tile mode %u is not displayable on GFX6-8\n",
+					micro_tile_mode);
+				return -EINVAL;
+			}
+
+			num_banks = 2 << AMD_FMT_MOD_GET(NUM_BANKS, modifier);
+			bank_width = 1 << AMD_FMT_MOD_GET(BANK_WIDTH, modifier);
+			bank_height = 1 << AMD_FMT_MOD_GET(BANK_HEIGHT, modifier);
+			pipe_config = AMD_FMT_MOD_GET(PIPE_CONFIG, modifier);
+			macro_tile_aspect = 1 << AMD_FMT_MOD_GET(MACRO_TILE_ASPECT, modifier);
+
+			if (pipe_config >= AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_8x16)
+				num_pipes = 16;
+			else if (pipe_config >= AMD_FMT_MOD_PIPE_CONFIG_P8_16x16_8x16)
+				num_pipes = 8;
+			else if (pipe_config >= AMD_FMT_MOD_PIPE_CONFIG_P4_8x16)
+				num_pipes = 4;
+			else if (pipe_config == AMD_FMT_MOD_PIPE_CONFIG_P2)
+				num_pipes = 2;
+			else
+				unreachable();
+
+			if (array_mode < AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
+				block_width = display_micro_tile_pitch;
+				block_height = micro_tile_height;
+			} else {
+				/* Assume non-PRT macro tiling modes */
+				block_width = num_pipes * micro_tile_width *
+					      bank_width * macro_tile_aspect;
+				block_height = micro_tile_height * bank_height *
+					       num_banks / macro_tile_aspect;
+			}
 		}
 
 		ret = amdgpu_display_verify_plane(rfb, i, format_info,
@@ -1271,8 +1374,10 @@ static int amdgpu_display_framebuffer_init(struct drm_device *dev,
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
2.54.0

