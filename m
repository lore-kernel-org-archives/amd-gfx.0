Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466AFC4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA97A2225F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="QOhGWENM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA97A2225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9306EEBA;
	Wed, 21 Oct 2020 23:31:48 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FF26EEB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 23:31:44 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id z5so5660219ejw.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xl+YvbHo/jEDfLmYxyb7b5e3nCugjB9AK25GUOkro6w=;
 b=QOhGWENM72wn7lhPrfiKPDwHDLj1F+BsRn7nLR5zzDkdh+T1WSVfENCeZPF6h9wobD
 tp/eUl9FFbrCAiaDNDj9Vdc0Y8bgivwq2XYW55aqQ/OLQEW9l35HrbFHw4MfvxqJ77xk
 QwrDUkgQnFCgnqeruDqQGG+qvoy5WBc6NfViIHUQemsAj7yWLjnSJe3tejJwZY0JX7d7
 R9SGTwl9sUHEWiguF179US/BSX3+hjw2IHTgAx7teatdRbH1rXo1xGZL3SvH69Bd++3Z
 Dv03k5T2Ga9AWxj2+GAYNS6BcnHprb8/mJlNPTSX14W1Wk5oNLgIvImsG9yZor/gzjAu
 tXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xl+YvbHo/jEDfLmYxyb7b5e3nCugjB9AK25GUOkro6w=;
 b=CGIO47mEBEV5IjRAiwCZGbWSvVn0F9JHJ3vE8Lf669qBQ7jqvcw6Cgt2sNNk3DYOm7
 1MP+tEgSIaFy1TUjT9DoEAlyWTBNiJ2Rp/mVnCIm9Y1t6G/922Z44cQFPLv0X6QD0X3R
 MOvSmiJg1MK8TiZAmsY/+Hwa/vkh50fnwvSuA6VAPsU8mr0ByWYZcGerumbTruqq7WQA
 SZaj8+ipoP1Lqp5G1xWudS5FqmrIHwD/od8dmFQob9vKfpuQiz9oz4Oyn72aDQLjsKX5
 5YRa6gli/iS86AY/08c1ydWNjfdxOuRRWYh5mwcr5EgxL39MS80odS1QEfXIvlfvwU80
 AY0A==
X-Gm-Message-State: AOAM532oT7qXDxbFRAN5zLO4nUOwkV27FG+C5EGwPK+nC8DJ7oumA3mm
 eAPBSnybeXEszGtz9DtuNjITwsxd809Phx1F
X-Google-Smtp-Source: ABdhPJwKwXTywYWfMY8Dfrww88ry9bLk1tluFD9j/fTuTGv9FCiHu0E9qPIuu+rJyX4QBrzVuvR4+w==
X-Received: by 2002:a17:906:1e04:: with SMTP id
 g4mr5781717ejj.72.1603323102421; 
 Wed, 21 Oct 2020 16:31:42 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id k23sm2845236ejs.100.2020.10.21.16.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 16:31:41 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 07/11] drm/amd/display: Refactor surface tiling setup.
Date: Thu, 22 Oct 2020 01:31:26 +0200
Message-Id: <20201021233130.874615-8-bas@basnieuwenhuizen.nl>
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

Prepare for inserting modifiers based configuration, while sharing
a bunch of DCC validation & initializing the device-based configuration.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 222 ++++++++++--------
 1 file changed, 119 insertions(+), 103 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5a0efaefbd7f..479c886816d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3839,46 +3839,86 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
 	return 0;
 }
 
-static inline uint64_t get_dcc_address(uint64_t address, uint64_t tiling_flags)
+static void
+fill_gfx8_tiling_info_from_flags(union dc_tiling_info *tiling_info,
+				 uint64_t tiling_flags)
 {
-	uint32_t offset = AMDGPU_TILING_GET(tiling_flags, DCC_OFFSET_256B);
+	/* Fill GFX8 params */
+	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == DC_ARRAY_2D_TILED_THIN1) {
+		unsigned int bankw, bankh, mtaspect, tile_split, num_banks;
+
+		bankw = AMDGPU_TILING_GET(tiling_flags, BANK_WIDTH);
+		bankh = AMDGPU_TILING_GET(tiling_flags, BANK_HEIGHT);
+		mtaspect = AMDGPU_TILING_GET(tiling_flags, MACRO_TILE_ASPECT);
+		tile_split = AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT);
+		num_banks = AMDGPU_TILING_GET(tiling_flags, NUM_BANKS);
+
+		/* XXX fix me for VI */
+		tiling_info->gfx8.num_banks = num_banks;
+		tiling_info->gfx8.array_mode =
+				DC_ARRAY_2D_TILED_THIN1;
+		tiling_info->gfx8.tile_split = tile_split;
+		tiling_info->gfx8.bank_width = bankw;
+		tiling_info->gfx8.bank_height = bankh;
+		tiling_info->gfx8.tile_aspect = mtaspect;
+		tiling_info->gfx8.tile_mode =
+				DC_ADDR_SURF_MICRO_TILING_DISPLAY;
+	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE)
+			== DC_ARRAY_1D_TILED_THIN1) {
+		tiling_info->gfx8.array_mode = DC_ARRAY_1D_TILED_THIN1;
+	}
 
-	return offset ? (address + offset * 256) : 0;
+	tiling_info->gfx8.pipe_config =
+			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
+}
+
+static void
+fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
+				  union dc_tiling_info *tiling_info)
+{
+	tiling_info->gfx9.num_pipes =
+		adev->gfx.config.gb_addr_config_fields.num_pipes;
+	tiling_info->gfx9.num_banks =
+		adev->gfx.config.gb_addr_config_fields.num_banks;
+	tiling_info->gfx9.pipe_interleave =
+		adev->gfx.config.gb_addr_config_fields.pipe_interleave_size;
+	tiling_info->gfx9.num_shader_engines =
+		adev->gfx.config.gb_addr_config_fields.num_se;
+	tiling_info->gfx9.max_compressed_frags =
+		adev->gfx.config.gb_addr_config_fields.max_compress_frags;
+	tiling_info->gfx9.num_rb_per_se =
+		adev->gfx.config.gb_addr_config_fields.num_rb_per_se;
+	tiling_info->gfx9.shaderEnable = 1;
+#ifdef CONFIG_DRM_AMD_DC_DCN3_0
+	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
+	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
+	    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
+	    adev->asic_type == CHIP_VANGOGH)
+		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
+#endif
 }
 
 static int
-fill_plane_dcc_attributes(struct amdgpu_device *adev,
-			  const struct amdgpu_framebuffer *afb,
-			  const enum surface_pixel_format format,
-			  const enum dc_rotation_angle rotation,
-			  const struct plane_size *plane_size,
-			  const union dc_tiling_info *tiling_info,
-			  const uint64_t info,
-			  struct dc_plane_dcc_param *dcc,
-			  struct dc_plane_address *address,
-			  bool force_disable_dcc)
+validate_dcc(struct amdgpu_device *adev,
+	     const enum surface_pixel_format format,
+	     const enum dc_rotation_angle rotation,
+	     const union dc_tiling_info *tiling_info,
+	     const struct dc_plane_dcc_param *dcc,
+	     const struct dc_plane_address *address,
+	     const struct plane_size *plane_size)
 {
 	struct dc *dc = adev->dm.dc;
 	struct dc_dcc_surface_param input;
 	struct dc_surface_dcc_cap output;
-	uint64_t plane_address = afb->address + afb->base.offsets[0];
-	uint32_t offset = AMDGPU_TILING_GET(info, DCC_OFFSET_256B);
-	uint32_t i64b = AMDGPU_TILING_GET(info, DCC_INDEPENDENT_64B) != 0;
-	uint64_t dcc_address;
 
 	memset(&input, 0, sizeof(input));
 	memset(&output, 0, sizeof(output));
 
-	if (force_disable_dcc)
+	if (!dcc->enable)
 		return 0;
 
-	if (!offset)
-		return 0;
-
-	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
-		return -EINVAL;
-
-	if (!dc->cap_funcs.get_dcc_compression_cap)
+	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN ||
+	    !dc->cap_funcs.get_dcc_compression_cap)
 		return -EINVAL;
 
 	input.format = format;
@@ -3897,17 +3937,60 @@ fill_plane_dcc_attributes(struct amdgpu_device *adev,
 	if (!output.capable)
 		return -EINVAL;
 
-	if (i64b == 0 && output.grph.rgb.independent_64b_blks != 0)
+	if (dcc->independent_64b_blks == 0 &&
+	    output.grph.rgb.independent_64b_blks != 0)
 		return -EINVAL;
 
+	return 0;
+}
+
+static void
+fill_dcc_params_from_flags(const struct amdgpu_framebuffer *afb,
+			   struct dc_plane_dcc_param *dcc,
+			   struct dc_plane_address *address,
+			   const uint64_t flags, bool force_disable_dcc)
+{
+	uint64_t dcc_address;
+	uint64_t plane_address = afb->address + afb->base.offsets[0];
+	uint32_t offset = AMDGPU_TILING_GET(flags, DCC_OFFSET_256B);
+	uint32_t i64b = AMDGPU_TILING_GET(flags, DCC_INDEPENDENT_64B) != 0;
+
+	if (!offset || force_disable_dcc)
+		return;
+
 	dcc->enable = 1;
-	dcc->meta_pitch =
-		AMDGPU_TILING_GET(info, DCC_PITCH_MAX) + 1;
+	dcc->meta_pitch = AMDGPU_TILING_GET(flags, DCC_PITCH_MAX) + 1;
 	dcc->independent_64b_blks = i64b;
 
-	dcc_address = get_dcc_address(plane_address, info);
+	dcc_address = plane_address + (uint64_t)offset * 256;
 	address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
 	address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
+}
+
+
+static int
+fill_gfx9_plane_attributes_from_flags(struct amdgpu_device *adev,
+				      const struct amdgpu_framebuffer *afb,
+				      const enum surface_pixel_format format,
+				      const enum dc_rotation_angle rotation,
+				      const struct plane_size *plane_size,
+				      union dc_tiling_info *tiling_info,
+				      struct dc_plane_dcc_param *dcc,
+				      struct dc_plane_address *address,
+				      uint64_t tiling_flags,
+				      bool force_disable_dcc)
+{
+	int ret;
+
+	fill_gfx9_tiling_info_from_device(adev, tiling_info);
+
+	tiling_info->gfx9.swizzle =
+		AMDGPU_TILING_GET(tiling_flags, SWIZZLE_MODE);
+
+	fill_dcc_params_from_flags(afb, dcc, address, tiling_flags, force_disable_dcc);
+	ret = validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -3979,82 +4062,15 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			upper_32_bits(chroma_addr);
 	}
 
-	/* Fill GFX8 params */
-	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == DC_ARRAY_2D_TILED_THIN1) {
-		unsigned int bankw, bankh, mtaspect, tile_split, num_banks;
-
-		bankw = AMDGPU_TILING_GET(tiling_flags, BANK_WIDTH);
-		bankh = AMDGPU_TILING_GET(tiling_flags, BANK_HEIGHT);
-		mtaspect = AMDGPU_TILING_GET(tiling_flags, MACRO_TILE_ASPECT);
-		tile_split = AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT);
-		num_banks = AMDGPU_TILING_GET(tiling_flags, NUM_BANKS);
-
-		/* XXX fix me for VI */
-		tiling_info->gfx8.num_banks = num_banks;
-		tiling_info->gfx8.array_mode =
-				DC_ARRAY_2D_TILED_THIN1;
-		tiling_info->gfx8.tile_split = tile_split;
-		tiling_info->gfx8.bank_width = bankw;
-		tiling_info->gfx8.bank_height = bankh;
-		tiling_info->gfx8.tile_aspect = mtaspect;
-		tiling_info->gfx8.tile_mode =
-				DC_ADDR_SURF_MICRO_TILING_DISPLAY;
-	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE)
-			== DC_ARRAY_1D_TILED_THIN1) {
-		tiling_info->gfx8.array_mode = DC_ARRAY_1D_TILED_THIN1;
-	}
-
-	tiling_info->gfx8.pipe_config =
-			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
-
-	if (adev->asic_type == CHIP_VEGA10 ||
-	    adev->asic_type == CHIP_VEGA12 ||
-	    adev->asic_type == CHIP_VEGA20 ||
-	    adev->asic_type == CHIP_NAVI10 ||
-	    adev->asic_type == CHIP_NAVI14 ||
-	    adev->asic_type == CHIP_NAVI12 ||
-#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
-		adev->asic_type == CHIP_SIENNA_CICHLID ||
-		adev->asic_type == CHIP_NAVY_FLOUNDER ||
-#endif
-#if defined(CONFIG_DRM_AMD_DC_DCN3_02)
-		adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
-#endif
-#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
-		adev->asic_type == CHIP_VANGOGH ||
-#endif
-	    adev->asic_type == CHIP_RENOIR ||
-	    adev->asic_type == CHIP_RAVEN) {
-		/* Fill GFX9 params */
-		tiling_info->gfx9.num_pipes =
-			adev->gfx.config.gb_addr_config_fields.num_pipes;
-		tiling_info->gfx9.num_banks =
-			adev->gfx.config.gb_addr_config_fields.num_banks;
-		tiling_info->gfx9.pipe_interleave =
-			adev->gfx.config.gb_addr_config_fields.pipe_interleave_size;
-		tiling_info->gfx9.num_shader_engines =
-			adev->gfx.config.gb_addr_config_fields.num_se;
-		tiling_info->gfx9.max_compressed_frags =
-			adev->gfx.config.gb_addr_config_fields.max_compress_frags;
-		tiling_info->gfx9.num_rb_per_se =
-			adev->gfx.config.gb_addr_config_fields.num_rb_per_se;
-		tiling_info->gfx9.swizzle =
-			AMDGPU_TILING_GET(tiling_flags, SWIZZLE_MODE);
-		tiling_info->gfx9.shaderEnable = 1;
-
-#ifdef CONFIG_DRM_AMD_DC_DCN3_0
-		if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-		    adev->asic_type == CHIP_NAVY_FLOUNDER ||
-		    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
-		    adev->asic_type == CHIP_VANGOGH)
-			tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
-#endif
-		ret = fill_plane_dcc_attributes(adev, afb, format, rotation,
-						plane_size, tiling_info,
-						tiling_flags, dcc, address,
-						force_disable_dcc);
+	if (adev->family >= AMDGPU_FAMILY_AI) {
+		ret = fill_gfx9_plane_attributes_from_flags(adev, afb, format, rotation,
+							    plane_size, tiling_info, dcc,
+							    address, tiling_flags,
+							    force_disable_dcc);
 		if (ret)
 			return ret;
+	} else {
+		fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
 	}
 
 	return 0;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
