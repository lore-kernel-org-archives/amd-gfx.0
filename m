Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB94CD37AC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98C210F061;
	Wed, 13 May 2026 20:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KiHLF5qX";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE16A10F061
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:43:30 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so6723392f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778705009; x=1779309809; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lazp6U03JBhzkXRmXdYYmFwBtMKHRY1kzAfL+o9qDI=;
 b=KiHLF5qXMmgiGrroqfukEjnLMhKGBGEZLYeXOGi9x5nBd2jeOQ/AiMMJZQUY21+Sw1
 6yYL4pxooJbHhVqV+aI6RsyZDqyYUOth5YIUdTeY3bfy/ckj5AFzbygJtzZgMuSOiGvo
 9EP4gdZu2FjdhxudKgnk77C52b8XT0CwsUa15pj4LzuFiAMTRDA8z0PQGFMMGx1h7KBR
 WZMPQ45Q/oXhX0C7QF0Hon/qCS+XZ9su+IHOWOpwVEweddOyBltjjva5N3fNiRbcMZhY
 vo5YSjsvgk4RWG0mJzsv/bQmOV17H/SyZtvE3L5oIAW+oEO74wzA3z2HbrE/pyphKp48
 fXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778705009; x=1779309809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9lazp6U03JBhzkXRmXdYYmFwBtMKHRY1kzAfL+o9qDI=;
 b=mgBGi21UevRV69Pn5lQkkF21whHrcKMReyLmhC7w3rro9lp8z+Ni7MMeFGGZcpxY29
 T72Hdssokk7ZrJOB0o/KISP2jABLpwG5c1LNuf0o64H4wHQpDQ97n3aXnUgnC2xRILI1
 blQ5xOdUHuYq1FJV/h6LwQxFtL4vwhqwifOdOTfiSbgm4RdI0hiTpqQ8L1UNNAy6HNrG
 qHxKU1oIE+cfCqkWKp+LEPV8Jmg/LOuZjOJp3x/RJLnwuH+gSFFSRYoGmAyGet3LiojI
 w7NQCsi2dkP7Ua4xxMSxbcVDzwJdpN1zXxKx1F4j18oLTd4y9eLPO+1Gry/f0H0k3Q9+
 EyDA==
X-Gm-Message-State: AOJu0Yy/ZoQqPmH7T+AufU9QLneR6DfvlFjpalZwx/SPCqHpaqGKR7oQ
 HY46URZcO9WBtdfHScQMkg8IshjikTJEh/WRSpwqcHkPM24gvkOUfrX1qceGr7kr
X-Gm-Gg: Acq92OG6EJOSLTftcSuesm2QgiLG5Mu4yU6tS8ZspdQHkpJtpqH/xRf2NFU/y70X6bz
 Fy4SLQv+B3/EvsWKY7etQ9MN/Mf7XjhWOIcfgnM/JtCrlcZvVRKgSbA2EQhqF8uyQkCzaLUhSBv
 mY25j6gLOygXYfHqV6m6psiBc5b5cJvWfUd45B6ocdUqu7PBULf/Csw9ACHYD1/HJp16E8sqvpR
 uXTW6wav/CxpYPSxCc2WtmdmBjsT55r9rabPhCZbwX7bS1l4IXqcUGhZMYcl+Z92b+wtwIJqZi5
 kDfMWeMz09fNT0cSPpPcDFhQ5L4yAohmu+vdVs+6+7NVbKmbeDLi7bEEC6ANENsn7ILgK8ajqZq
 BtE9rwVdx/Bq3LdO76/AmcybzSgEcNIh8MlH0gwe4KDqfiPdV8rLA6kyxHKgnCVPe5k97+Y+jhM
 H/NAME1cW+/BjP5oPP0W7ebyapdSUCGYyzdcniQ7jDeYDf9gdrvpEuTAWBRJ6nKcN8
X-Received: by 2002:a05:6000:288c:b0:445:eb07:f0bf with SMTP id
 ffacd0b85a97d-45c584a9048mr7527589f8f.16.1778705009261; 
 Wed, 13 May 2026 13:43:29 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm1308356f8f.21.2026.05.13.13.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:43:28 -0700 (PDT)
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
Subject: [PATCH 3/4] drm/amd/display: Support DRM format modifiers on GFX6-8
Date: Wed, 13 May 2026 22:43:21 +0200
Message-ID: <20260513204322.73542-4-timur.kristof@gmail.com>
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

Expose displayable DRM format modifiers based on which tiling
modes are supported by the GFX block.

Technically, DCE could support all possible modes independently
of what GFX supports, but it doesn't make sense to expose all
possible permutations.

The following modes will be advertised:
- 2D_TILED_THIN1 + DISPLAY (macro tiled)
- 1D_TILED_THIN1 + DISPLAY (micro tiled only)
- LINEAR

The macro tiling configuration depends on how many bits per pixel
the given surface has.

When sharing buffers between different GPUs, it is unlikely that
they will support the same macro tile mode, so it will likely
need to use the micro tiled only mode.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Link Mauve <linkmauve@linkmauve.fr>
Reviewed-by: Marek Olšák <maraeo@gmail.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 313 +++++++++++++++++-
 1 file changed, 306 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 23a9faa2ea89..24e3510613ce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -165,6 +165,18 @@ static void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size, uint64
 	*size += 1;
 }
 
+static void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64_t *size,
+					       uint64_t *cap, uint64_t mod)
+{
+	uint64_t i;
+
+	for (i = 0; i < *size; ++i)
+		if ((*mods)[i] == mod)
+			return;
+
+	amdgpu_dm_plane_add_modifier(mods, size, cap, mod);
+}
+
 static bool amdgpu_dm_plane_modifier_has_dcc(uint64_t modifier)
 {
 	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
@@ -211,6 +223,39 @@ static void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(struct dc_tiling_in
 			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
 }
 
+static int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(struct dc_tiling_info *tiling_info,
+							       uint64_t modifier)
+{
+	if (modifier == DRM_FORMAT_MOD_LINEAR) {
+		tiling_info->gfx8.array_mode = DC_ARRAY_LINEAR_GENERAL;
+		tiling_info->gfxversion = DcGfxVersion8;
+
+		return 0;
+	}
+
+	if (!IS_AMD_FMT_MOD(modifier))
+		return -EINVAL;
+
+	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) != AMD_FMT_MOD_TILE_VER_GFX6)
+		return -EINVAL;
+
+	tiling_info->gfx8.array_mode = AMD_FMT_MOD_GET(TILE, modifier);
+	tiling_info->gfxversion = DcGfxVersion8;
+	tiling_info->gfx8.tile_mode = AMD_FMT_MOD_GET(MICROTILE, modifier);
+
+	if (AMD_FMT_MOD_GET(TILE, modifier) < AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1)
+		return 0;
+
+	tiling_info->gfx8.pipe_config = AMD_FMT_MOD_GET(PIPE_CONFIG, modifier);
+	tiling_info->gfx8.tile_split = AMD_FMT_MOD_GET(TILE_SPLIT, modifier);
+	tiling_info->gfx8.bank_width = AMD_FMT_MOD_GET(BANK_WIDTH, modifier);
+	tiling_info->gfx8.bank_height = AMD_FMT_MOD_GET(BANK_HEIGHT, modifier);
+	tiling_info->gfx8.tile_aspect = AMD_FMT_MOD_GET(MACRO_TILE_ASPECT, modifier);
+	tiling_info->gfx8.num_banks = AMD_FMT_MOD_GET(NUM_BANKS, modifier);
+
+	return 0;
+}
+
 static void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
 							      struct dc_tiling_info *tiling_info)
 {
@@ -446,6 +491,246 @@ static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_device *ad
 				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
 }
 
+/**
+ * amdgpu_dm_plane_get_gfx6_tile_idx() - Get tile mode index on GFX6-8
+ *
+ * @adev: amdgpu_device pointer
+ * @bpp: bits per pixel in the image
+ * @arr: array mode (aka. tile mode) of the image layout
+ *
+ * Select which tiling mode from the table is suitable for the given bits per pixel
+ * using the given array mode, assuming the displayable micro tile mode is used.
+ *
+ * On GFX6-8, the GFX block can only use pre-programmed tiling modes from GB_TILE_MODEn
+ * registers which are programmed by the kernel according to the tiling mode table.
+ * Note that the tiling table is uAPI and userspace relies on specific modes being
+ * present at specific indices.
+ * See SiLib::HwlSetupTileInfo() and CiLib::HwlSetupTileInfo() in addrlib.
+ */
+static u32 amdgpu_dm_plane_get_gfx6_tile_idx(const struct amdgpu_device *adev,
+					 const u32 bpp,
+					 const enum array_mode_values arr)
+{
+	/* Assume that the microtile mode is DISPLAY. */
+
+	if (arr == DC_ARRAY_1D_TILED_THIN1)
+		return 9;
+
+	ASSERT(arr == DC_ARRAY_2D_TILED_THIN1);
+
+	if (adev->family > AMDGPU_FAMILY_SI)
+		return 10;
+
+	switch (bpp) {
+	case 8:
+		return 10;
+	case 16:
+		return 11;
+	default:
+		return 12;
+	}
+}
+
+/**
+ * amdgpu_dm_plane_calc_gfx7_tile_split() - Calculate tile split on GFX7-8
+ *
+ * @adev: amdgpu_device pointer
+ * @bpp: bits per pixel in the image
+ * @gb_tile_mode: GB_TILE_MODEn register value for the current tiling mode
+ *
+ * Calculate the actual tile split value on GFX7-8, assuming 2D_TILED_THIN1 array mode
+ * with a non-depth micro tile mode.
+ *
+ * On GFX7-8, SAMPLE_SPLIT holds a factor from which the actual tile split bytes
+ * can be calculated. The TILE_SPLIT field is only used for the depth micro tile mode.
+ * See CiLib::HwlComputeMacroModeIndex() in addrlib.
+ */
+static u32 amdgpu_dm_plane_calc_gfx7_tile_split(const struct amdgpu_device *adev,
+						const u32 bpp,
+						const u32 gb_tile_mode)
+{
+	/* Assume 2D_TILED_THIN1 mode with non-DEPTH microtiles */
+	const u32 sample_split = (gb_tile_mode >> 25) & 0x3;
+	const u32 thickness = 1;
+	const u32 tile_size_pixels = 8 * 8;
+	const u32 tile_bytes_1x = tile_size_pixels * bpp * thickness / 8;
+	const u32 sample_split_factor = 1 << sample_split;
+
+	return clamp(tile_bytes_1x * sample_split_factor,
+		     256,
+		     adev->gfx.config.mem_row_size_in_kb * 1024);
+}
+
+/**
+ * amdgpu_dm_plane_get_gfx7_macro_tile_idx() - Get macro tile mode index on GFX7-8
+ *
+ * @bpp: bits per pixel in the image
+ * @tile_split_bytes: actual tile split bytes, see amdgpu_dm_plane_calc_gfx7_tile_split()
+ *
+ * Select which macro tiling mode from the table is suitable for the given bits per pixel,
+ * assuming 2D_TILED_THIN1 array mode and DISPLAY micro tile mode (and no multisampling).
+ * Note that the tiling table is uAPI and userspace relies on specific modes being
+ * present at specific indices.
+ * See CiLib::HwlComputeMacroModeIndex() in addrlib.
+ */
+static u32 amdgpu_dm_plane_get_gfx7_macro_tile_idx(const u32 bpp, const u32 tile_split_bytes)
+{
+	const u32 tile_bytes = clamp(8 * 8 * bpp, 64, tile_split_bytes);
+	const u32 macro_tile_idx = ilog2(tile_bytes / 64);
+
+	WARN_ON(macro_tile_idx >= 16);
+
+	return macro_tile_idx;
+}
+
+/**
+ * amdgpu_dm_plane_calc_gfx6_mod() - Calculate a DRM format modifier for GFX6-8
+ *
+ * @adev: amdgpu_device pointer
+ * @bpp: bits per pixel in the image
+ * @arr: array mode (aka. tile mode) of the image layout
+ *
+ * Select suitable micro and macro tile modes for the given bits per pixel,
+ * and calculate the corresponding DRM format modifier.
+ */
+static u64 amdgpu_dm_plane_calc_gfx6_mod(const struct amdgpu_device *adev,
+					 const u32 bpp,
+					 const enum array_mode_values arr)
+{
+	u32 array_mode, micro_tile_mode, tile_split_bytes;
+	u32 gb_macrotile_mode, macrotile_idx;
+	u32 gb_tile_mode, tile_idx;
+
+	u64 modifier_base =
+		AMD_FMT_MOD |
+		AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+		AMD_FMT_MOD_SET(TILE, arr) |
+		AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY);
+
+	if (arr < DC_ARRAY_2D_TILED_THIN1)
+		return modifier_base;
+
+	tile_idx = amdgpu_dm_plane_get_gfx6_tile_idx(adev, bpp, arr);
+	gb_tile_mode = adev->gfx.config.tile_mode_array[tile_idx];
+	array_mode = (gb_tile_mode >> 2) & 0xf;
+
+	if (adev->family == AMDGPU_FAMILY_SI) {
+		micro_tile_mode = (gb_tile_mode >> 0) & 0x3;
+		tile_split_bytes = 64 << ((gb_tile_mode >> 11) & 0x7);
+	} else {
+		micro_tile_mode = (gb_tile_mode >> 22) & 0x7;
+		tile_split_bytes = amdgpu_dm_plane_calc_gfx7_tile_split(adev, bpp, gb_tile_mode);
+	}
+
+	ASSERT(array_mode == arr);
+	ASSERT(micro_tile_mode == AMD_FMT_MOD_MICROTILE_DISPLAY);
+
+	modifier_base |=
+		AMD_FMT_MOD_SET(PIPE_CONFIG, (gb_tile_mode >> 6) & 0x1f) |
+		AMD_FMT_MOD_SET(TILE_SPLIT, ilog2(tile_split_bytes / 64));
+
+	if (adev->family == AMDGPU_FAMILY_SI)
+		return modifier_base |
+			AMD_FMT_MOD_SET(BANK_WIDTH, (gb_tile_mode >> 14) & 0x3) |
+			AMD_FMT_MOD_SET(BANK_HEIGHT, (gb_tile_mode >> 16) & 0x3) |
+			AMD_FMT_MOD_SET(MACRO_TILE_ASPECT, (gb_tile_mode >> 18) & 0x3) |
+			AMD_FMT_MOD_SET(NUM_BANKS, (gb_tile_mode >> 20) & 0x3);
+
+	macrotile_idx = amdgpu_dm_plane_get_gfx7_macro_tile_idx(bpp, tile_split_bytes);
+	gb_macrotile_mode = adev->gfx.config.macrotile_mode_array[macrotile_idx];
+
+	return modifier_base |
+		AMD_FMT_MOD_SET(BANK_WIDTH, (gb_macrotile_mode >> 0) & 0x3) |
+		AMD_FMT_MOD_SET(BANK_HEIGHT, (gb_macrotile_mode >> 2) & 0x3) |
+		AMD_FMT_MOD_SET(MACRO_TILE_ASPECT, (gb_macrotile_mode >> 4) & 0x3) |
+		AMD_FMT_MOD_SET(NUM_BANKS, (gb_macrotile_mode >> 6) & 0x3);
+}
+
+/**
+ * amdgpu_dm_plane_gfx6_format_mod_supported() - Check if a modifier is supported on GFX6-8
+ *
+ * @adev: amdgpu_device pointer
+ * @bpp: bits per pixel in the image
+ * @modifier: the modifier whose support we check
+ *
+ * On GFX6-8, not all DRM format modifier can be used with all image formats.
+ * Check whether the specified modifier is supported with the given bits per pixel value.
+ */
+static bool amdgpu_dm_plane_gfx6_format_mod_supported(const struct amdgpu_device *adev,
+						      const u32 bpp,
+						      const u64 modifier)
+{
+	const u32 array_mode = AMD_FMT_MOD_GET(TILE, modifier);
+	const u32 micro_tile_mode = AMD_FMT_MOD_GET(MICROTILE, modifier);
+
+	if (!IS_AMD_FMT_MOD(modifier))
+		return false;
+
+	/* GFX9 and newer format modifiers are not supported on GFX6-8 yet. */
+	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) != AMD_FMT_MOD_TILE_VER_GFX6)
+		return false;
+
+	/* GFX8 and older format modifiers are not supported on GFX9+ yet. */
+	if (adev->family >= AMDGPU_FAMILY_AI)
+		return false;
+
+	/* GFX6-7 doesn't have any DCC, GFX8 doesn't have displayable DCC. */
+	if (AMD_FMT_MOD_GET(DCC, modifier))
+		return false;
+
+	/*
+	 * For now, only expose 1D and 2D tiles THIN array modes.
+	 * Linear is already exposed through DRM_FORMAT_MOD_LINEAR.
+	 */
+	if (array_mode != AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 &&
+	    array_mode != AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1)
+		return false;
+
+	/*
+	 * For now, only expose DISPLAY micro tile mode.
+	 * THIN, DEPTH and THICK modes are not displayable.
+	 * ROTATED has never been supported on Linux.
+	 */
+	if (micro_tile_mode != AMD_FMT_MOD_MICROTILE_DISPLAY)
+		return false;
+
+	/* Verify that the modifier is the same that we'd expose for this bpp */
+	return amdgpu_dm_plane_calc_gfx6_mod(adev, bpp, array_mode) == modifier;
+}
+
+/**
+ * amdgpu_dm_plane_add_gfx6_modifiers() - Expose modifiers for GFX6-8
+ *
+ * @adev: amdgpu_device pointer
+ * @mods: Pointer to array of format modifiers
+ * @size: Pointer to size of the array
+ * @capacity: Pointer to capacity of the array
+ *
+ * Calculate a DRM format modifier for macro tiled modes for each supported
+ * bits per pixel value. Use de-duplication because on some GPUs it may happen
+ * that different bpp results in the exact same macro tiling mode, depending
+ * on the tiling table.
+ *
+ * Also expose a micro tiled only mode. This is less optimal, but supported.
+ */
+static void amdgpu_dm_plane_add_gfx6_modifiers(const struct amdgpu_device *adev,
+					       u64 **mods,
+					       u64 *size,
+					       u64 *capacity)
+{
+	/* 2D tiled displayable */
+	amdgpu_dm_plane_add_modifier(mods, size, capacity,
+		amdgpu_dm_plane_calc_gfx6_mod(adev, 16, DC_ARRAY_2D_TILED_THIN1));
+	amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
+		amdgpu_dm_plane_calc_gfx6_mod(adev, 32, DC_ARRAY_2D_TILED_THIN1));
+	amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
+		amdgpu_dm_plane_calc_gfx6_mod(adev, 64, DC_ARRAY_2D_TILED_THIN1));
+
+	/* 1D tiled displayable */
+	amdgpu_dm_plane_add_modifier(mods, size, capacity,
+		amdgpu_dm_plane_calc_gfx6_mod(adev, 0, DC_ARRAY_1D_TILED_THIN1));
+}
+
 static void amdgpu_dm_plane_add_gfx9_modifiers(const struct amdgpu_device *adev,
 					       uint64_t **mods,
 					       uint64_t *size,
@@ -727,12 +1012,6 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(struct amdgpu_device *adev,
 static int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
 {
 	uint64_t size = 0, capacity = 128;
-	*mods = NULL;
-
-	/* We have not hooked up any pre-GFX9 modifiers. */
-	if (adev->family < AMDGPU_FAMILY_AI)
-		return 0;
-
 	*mods = kmalloc_array(capacity, sizeof(uint64_t), GFP_KERNEL);
 
 	if (plane_type == DRM_PLANE_TYPE_CURSOR) {
@@ -742,6 +1021,13 @@ static int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsig
 	}
 
 	switch (adev->family) {
+	case AMDGPU_FAMILY_SI:
+	case AMDGPU_FAMILY_CI:
+	case AMDGPU_FAMILY_KV:
+	case AMDGPU_FAMILY_VI:
+	case AMDGPU_FAMILY_CZ:
+		amdgpu_dm_plane_add_gfx6_modifiers(adev, mods, &size, &capacity);
+		break;
 	case AMDGPU_FAMILY_AI:
 	case AMDGPU_FAMILY_RV:
 		amdgpu_dm_plane_add_gfx9_modifiers(adev, mods, &size, &capacity);
@@ -916,8 +1202,13 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 										address);
 		if (ret)
 			return ret;
-	} else {
+	} else if (!afb->base.modifier) {
 		amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
+	} else {
+		ret = amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(tiling_info,
+									  afb->base.modifier);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -1552,6 +1843,7 @@ static bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	const struct drm_format_info *info = drm_format_info(format);
+	const u32 bpp = drm_format_info_bpp(info, 0);
 	int i;
 
 	if (!info)
@@ -1575,6 +1867,13 @@ static bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
 	if (i == plane->modifier_count)
 		return false;
 
+	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX6)
+		return amdgpu_dm_plane_gfx6_format_mod_supported(adev, bpp, modifier);
+
+	/* GFX9+ modifers are not supported on GFX8 and older yet. */
+	if (adev->family < AMDGPU_FAMILY_AI)
+		return false;
+
 	/* GFX12 doesn't have these limitations. */
 	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) <= AMD_FMT_MOD_TILE_VER_GFX11) {
 		enum dm_micro_swizzle microtile = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier) & 3;
-- 
2.54.0

