Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCBAC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4E32070E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="QQRWzIVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4E32070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186EF6E821;
	Wed, 28 Oct 2020 23:52:52 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E07916E820
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 23:52:48 +0000 (UTC)
Received: by mail-ed1-x542.google.com with SMTP id k9so1305044edo.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9zv1DKYH29VgFiwMEFKVAX9HwF6XMe9LFniODLyTru0=;
 b=QQRWzIVilV11Z5+t8aPnC2XrLZW2cPQrk0Nqh8QtAWuhmTpYmh5gPsmnFrvRMM4i23
 1VBInolaN1rR6Z8KGgfeJPNNZ5QKyawnrizgvsw40ECV8BAPQJKR+R7TI22vEKQv+v66
 LCdsa91mUkZpjxsi1fkGCl7EB/pTDFMzKF/50fOWEqToTWS+07hIjvbvfGCdV6DZCuYZ
 hOgeQZr+qZ2TZfw9bpFothuhgUI1f9G9ZZCyFlLA97mduJCy5swuvLdbYHhAeLN4aLdx
 2aQGsPZF5F7228dm7aNb5TPqOuGelzs/bMQmMBNRnkhQtDZJAG7dsKs93Tuq2DNNBbEB
 0yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9zv1DKYH29VgFiwMEFKVAX9HwF6XMe9LFniODLyTru0=;
 b=my7aLAqUn17q//u+sbe+6Dden0915EIaqDBgaDahKEQG2+XA8upMXG/zimegMsCXlV
 dN5FTZ+Wun5vLJ1KETqI9++VbiwYt5h1+H5cY7LMz8wzRFx90+9tW602nPYCKaw4/nzh
 n5yJ6wv7OpTopdXN9xEt3VJZ7N5gRiCctNaXajEoQrdvQM67Sep/QJI2hyxZdzg0V7dQ
 2On0cEDQ2en52VBJ1e8oysocSVw9YbDhVm51+M+zJ0zeI2qMYDL+p4DcBH8qvasbhucG
 H3qRVP9A13kY31fap06w9TBHo5yqgZ52P2Vhno2xsvE7w9Kcyd/vnvyXH85Ubgzy4YTo
 tkBw==
X-Gm-Message-State: AOAM530OQ+eXhJyiccG+iyt8BFpibXRqo/QfftnNO4gTGnIBIFFQm/ho
 YBd3fyXzZCR/x6U3m4XBXtMNX5wYavI70w==
X-Google-Smtp-Source: ABdhPJzXWhGF0wovpYgfenZ8P25dYjNGDeD/R8harqBAl2M24LEcaYUDy+DZz20Y3zXIKOApxBSV4Q==
X-Received: by 2002:aa7:dcc2:: with SMTP id w2mr1387757edu.121.1603929167254; 
 Wed, 28 Oct 2020 16:52:47 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id o13sm479174ejr.120.2020.10.28.16.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 16:52:46 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 07/11] drm/amd/display: Refactor surface tiling setup.
Date: Thu, 29 Oct 2020 00:52:37 +0100
Message-Id: <20201028235241.3299-8-bas@basnieuwenhuizen.nl>
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

Prepare for inserting modifiers based configuration, while sharing
a bunch of DCC validation & initializing the device-based configuration.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
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
