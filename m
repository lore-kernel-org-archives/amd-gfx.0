Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0D2C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E99E20725
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="FeOfjIDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E99E20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84AAE6E827;
	Wed, 28 Oct 2020 23:52:55 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 707FA6E825
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 23:52:52 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id t25so1307647ejd.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XVTOkg4+BLN7V0cBeIwZdtbXHcggV7XrEfFjZQrJ8EY=;
 b=FeOfjIDzu8K29bnep3MEYzl7UbSxD/gVEg6QkWih+Sv7z4/Gr5+VOEFkB4vqkTCJdz
 yC2nC5nLn56lzb6dMhBEwTDSjmSJT7r7fExcOnf/mVxW6BxGdI6ix9CxvWI6q5colc+0
 9SdVnrbupM29ze1K7NaUZxNd52RUTws7GbivsUsmvRmsNwSQD+WjobYTlzVagsLeFS4X
 fOnPdW69MBWiRkdeABajBtK3d7jJD+BJiHoKhLrxnTofeFWYsXmKt9eSXE21aIcIasdJ
 oRsOqI3hjdp+PjvZYAnZh5p2ckO3qgZ5vuG+zfBORB5nu/U5pLOGLNcWqG33mdHwHLVW
 h4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XVTOkg4+BLN7V0cBeIwZdtbXHcggV7XrEfFjZQrJ8EY=;
 b=eV3q+5WhdifZRVg9+WYPs7Xwgtb7+dIlbpWuPrMHMjXesrYymMIItkGV3144cLGCV8
 TNhmUdGlTg6+ZL7B/dUO35q413lr5yJbfabN7wIMakbddQsb5vNaO5rI1sIOwG0oy0ef
 SQ+tyeRdp5qbtGjpN/Oqg7NLZMiwXd8XiIeogw8TeCqpNi1N0uqznrbmtaLu76b5ayYu
 bqf7+D1XM6cgrw1XYozvcm9cSVtdbdblxvSYz7pRLuNHLF1QDUlnHEsTfTmJfQynqOrP
 BlYbwlghMpK6wWOlQE2SEr0A71MpFSScFTYJrIi0r0RCEX8MReh8Wf7r/MIK6Z57L4tE
 QUFA==
X-Gm-Message-State: AOAM530O4ozIZmtAfVUv5nKKj4HKO2nvL2sLxwwx+rxdMV7vpxObq7qr
 4phoUCYTrgjye2G4fwt4UrWAXTZ+NdPhww==
X-Google-Smtp-Source: ABdhPJwPvjhd3g6bXBZFmpvOw7fLtKAIQ4nJMFJ6InFdqstEQBXB8rQiZQDZ+RM3EvW4XR7pZE/JaQ==
X-Received: by 2002:a17:906:38d8:: with SMTP id
 r24mr1596286ejd.32.1603929170671; 
 Wed, 28 Oct 2020 16:52:50 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id o13sm479174ejr.120.2020.10.28.16.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 16:52:50 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 10/11] drm/amd/display: Expose modifiers.
Date: Thu, 29 Oct 2020 00:52:40 +0100
Message-Id: <20201028235241.3299-11-bas@basnieuwenhuizen.nl>
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

This expose modifier support on GFX9+.

Only modifiers that can be rendered on the current GPU are
added. This is to reduce the number of modifiers exposed.

The HW could expose more, but the best mechanism to decide
what to expose without an explosion in modifiers is still
to be decided, and in the meantime this should not regress
things from pre-modifiers and does not risk regressions as
we make up our mind in the future.

v2:
  - Added comment that D on Raven is only valid for 64bpp
    and will be filtered based on format later.
  - Removed D tiling modes that weren't useful for 64bpp
    on GFX10+.

v4: Add AMDGPU_FAMILY_VGH case.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 339 +++++++++++++++++-
 1 file changed, 338 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6b33e030fe20..2202c0060b5c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4133,6 +4133,336 @@ fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
 	}
 }
 
+enum dm_micro_swizzle {
+	MICRO_SWIZZLE_Z = 0,
+	MICRO_SWIZZLE_S = 1,
+	MICRO_SWIZZLE_D = 2,
+	MICRO_SWIZZLE_R = 3
+};
+
+static bool dm_plane_format_mod_supported(struct drm_plane *plane,
+					  uint32_t format,
+					  uint64_t modifier)
+{
+	struct amdgpu_device *adev = drm_to_adev(plane->dev);
+	const struct drm_format_info *info = drm_format_info(format);
+
+	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
+
+	if (!info)
+		return false;
+
+	/*
+	 * We always have to allow this modifier, because core DRM still
+	 * checks LINEAR support if userspace does not provide modifers.
+	 */
+	if (modifier == DRM_FORMAT_MOD_LINEAR)
+		return true;
+
+	/*
+	 * The arbitrary tiling support for multiplane formats has not been hooked
+	 * up.
+	 */
+	if (info->num_planes > 1)
+		return false;
+
+	/*
+	 * For D swizzle the canonical modifier depends on the bpp, so check
+	 * it here.
+	 */
+	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX9 &&
+	    adev->family >= AMDGPU_FAMILY_NV) {
+		if (microtile == MICRO_SWIZZLE_D && info->cpp[0] == 4)
+			return false;
+	}
+
+	if (adev->family >= AMDGPU_FAMILY_RV && microtile == MICRO_SWIZZLE_D &&
+	    info->cpp[0] < 8)
+		return false;
+
+	if (modifier_has_dcc(modifier)) {
+		/* Per radeonsi comments 16/64 bpp are more complicated. */
+		if (info->cpp[0] != 4)
+			return false;
+	}
+
+	return true;
+}
+
+static void
+add_modifier(uint64_t **mods, uint64_t *size, uint64_t *cap, uint64_t mod)
+{
+	if (!*mods)
+		return;
+
+	if (*cap - *size < 1) {
+		uint64_t new_cap = *cap * 2;
+		uint64_t *new_mods = kmalloc(new_cap * sizeof(uint64_t), GFP_KERNEL);
+
+		if (!new_mods) {
+			kfree(*mods);
+			*mods = NULL;
+			return;
+		}
+
+		memcpy(new_mods, *mods, sizeof(uint64_t) * *size);
+		kfree(*mods);
+		*mods = new_mods;
+		*cap = new_cap;
+	}
+
+	(*mods)[*size] = mod;
+	*size += 1;
+}
+
+static void
+add_gfx9_modifiers(const struct amdgpu_device *adev,
+		   uint64_t **mods, uint64_t *size, uint64_t *capacity)
+{
+	int pipes = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
+	int pipe_xor_bits = min(8, pipes +
+				ilog2(adev->gfx.config.gb_addr_config_fields.num_se));
+	int bank_xor_bits = min(8 - pipe_xor_bits,
+				ilog2(adev->gfx.config.gb_addr_config_fields.num_banks));
+	int rb = ilog2(adev->gfx.config.gb_addr_config_fields.num_se) +
+		 ilog2(adev->gfx.config.gb_addr_config_fields.num_rb_per_se);
+
+
+	if (adev->family == AMDGPU_FAMILY_RV) {
+		/* Raven2 and later */
+		bool has_constant_encode = adev->asic_type > CHIP_RAVEN || adev->external_rev_id >= 0x81;
+
+		/*
+		 * No _D DCC swizzles yet because we only allow 32bpp, which
+		 * doesn't support _D on DCN
+		 */
+
+		if (has_constant_encode) {
+			add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+				    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+				    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+				    AMD_FMT_MOD_SET(DCC, 1) |
+				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1));
+		}
+
+		add_modifier(mods, size, capacity, AMD_FMT_MOD |
+			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+			    AMD_FMT_MOD_SET(DCC, 1) |
+			    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+			    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+			    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0));
+
+		if (has_constant_encode) {
+			add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+				    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+				    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+				    AMD_FMT_MOD_SET(DCC, 1) |
+				    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+
+				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+				    AMD_FMT_MOD_SET(RB, rb) |
+				    AMD_FMT_MOD_SET(PIPE, pipes));
+		}
+
+		add_modifier(mods, size, capacity, AMD_FMT_MOD |
+			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+			    AMD_FMT_MOD_SET(DCC, 1) |
+			    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+			    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+			    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+			    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0) |
+			    AMD_FMT_MOD_SET(RB, rb) |
+			    AMD_FMT_MOD_SET(PIPE, pipes));
+	}
+
+	/*
+	 * Only supported for 64bpp on Raven, will be filtered on format in
+	 * dm_plane_format_mod_supported.
+	 */
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
+
+	if (adev->family == AMDGPU_FAMILY_RV) {
+		add_modifier(mods, size, capacity, AMD_FMT_MOD |
+			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
+	}
+
+	/*
+	 * Only supported for 64bpp on Raven, will be filtered on format in
+	 * dm_plane_format_mod_supported.
+	 */
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+
+	if (adev->family == AMDGPU_FAMILY_RV) {
+		add_modifier(mods, size, capacity, AMD_FMT_MOD |
+			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
+			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+	}
+}
+
+static void
+add_gfx10_1_modifiers(const struct amdgpu_device *adev,
+		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
+{
+	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(DCC, 1) |
+		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(DCC, 1) |
+		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
+
+
+	/* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+}
+
+static void
+add_gfx10_3_modifiers(const struct amdgpu_device *adev,
+		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
+{
+	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
+	int pkrs = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
+		    AMD_FMT_MOD_SET(DCC, 1) |
+		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
+		    AMD_FMT_MOD_SET(DCC, 1) |
+		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(PACKERS, pkrs));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(PACKERS, pkrs));
+
+	/* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+}
+
+static int
+get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
+{
+	uint64_t size = 0, capacity = 128;
+	*mods = NULL;
+
+	/* We have not hooked up any pre-GFX9 modifiers. */
+	if (adev->family < AMDGPU_FAMILY_AI)
+		return 0;
+
+	*mods = kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
+
+	if (plane_type == DRM_PLANE_TYPE_CURSOR) {
+		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
+		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
+		return *mods ? 0 : -ENOMEM;
+	}
+
+	switch (adev->family) {
+	case AMDGPU_FAMILY_AI:
+	case AMDGPU_FAMILY_RV:
+		add_gfx9_modifiers(adev, mods, &size, &capacity);
+		break;
+	case AMDGPU_FAMILY_NV:
+	case AMDGPU_FAMILY_VGH:
+		if (adev->asic_type >= CHIP_SIENNA_CICHLID)
+			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
+		else
+			add_gfx10_1_modifiers(adev, mods, &size, &capacity);
+		break;
+	}
+
+	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
+
+	/* INVALID marks the end of the list. */
+	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
+
+	if (!*mods)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int
 fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
 					  const struct amdgpu_framebuffer *afb,
@@ -6100,6 +6430,7 @@ static const struct drm_plane_funcs dm_plane_funcs = {
 	.reset = dm_drm_plane_reset,
 	.atomic_duplicate_state = dm_drm_plane_duplicate_state,
 	.atomic_destroy_state = dm_drm_plane_destroy_state,
+	.format_mod_supported = dm_plane_format_mod_supported,
 };
 
 static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
@@ -6392,13 +6723,19 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	int num_formats;
 	int res = -EPERM;
 	unsigned int supported_rotations;
+	uint64_t *modifiers = NULL;
 
 	num_formats = get_plane_formats(plane, plane_cap, formats,
 					ARRAY_SIZE(formats));
 
+	res = get_plane_modifiers(dm->adev, plane->type, &modifiers);
+	if (res)
+		return res;
+
 	res = drm_universal_plane_init(adev_to_drm(dm->adev), plane, possible_crtcs,
 				       &dm_plane_funcs, formats, num_formats,
-				       NULL, plane->type, NULL);
+				       modifiers, plane->type, NULL);
+	kfree(modifiers);
 	if (res)
 		return res;
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
