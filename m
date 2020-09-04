Return-Path: <SRS0=eFkV=CN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F27DC2D0A8
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408AD207EA
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen-nl.20150623.gappssmtp.com header.i=@basnieuwenhuizen-nl.20150623.gappssmtp.com header.b="MqIvhMB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408AD207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E326EC8D;
	Fri,  4 Sep 2020 16:07:20 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE7E6EC8B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2020 16:07:18 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id v4so6552620wmj.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2020 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen-nl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FuJHWVxsosvb86NQqqzWseSA7dH5opMNswxA2CEbAgQ=;
 b=MqIvhMB4I0O6tFewuwgcKQXYCwDFPHCllmY01wqJpE3tPQOCg72q9qfkhYMK67bEey
 h9QMNDOh0oci1jOdCCPNr8UKnEEUwwsA+VkdkI08wGoYtYzEaTDayUMmBKFruKCPvjSI
 D2ckQm+SQ+MZIjthjX2xNpBAEfu0bPTOZyUSkw4JKdoRzx5hH6fKoNehXdpgDXWerNCA
 jn5tn3HnOBQALvv081gKBV+czZNDu4G5UVurTNGMzRG9MWivMMcQ9gIoQ/DNtMSNjS74
 NesqpjTJvqTMy9sbp7tLbDooWvzFsZTl3pyNy+F1dKBRUoEeXKjuzi0lZC+gBXZNhmZV
 03MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FuJHWVxsosvb86NQqqzWseSA7dH5opMNswxA2CEbAgQ=;
 b=F8TQCNgVic849U1QGAycilyYhXxOx4ucM09ce+MujMgR4GusgaJLUkf/jjTSVPDMC3
 4hDcRyZraQnsSKovWGuxAclsJW2dRcXTOMxNaj1d6UcBp2yPKMxLRjuh5cqnn8OlEE7Z
 eAkCb7V9Wh6kL5Utw1JWMIYrKYumnFCaYE+fnaNpYMfhw9aGnGas4FPCJCpVNCZWpmsh
 asUUqJsVmLW34LYgP+ODDDXZ+FlkypwWVyP3+OzSZOfsRAWkdf5BMzttGxR/4azbQULZ
 tUp4l5dz/3BC5uwj+vcZImnfbZR1cd6NIZPl6Wi9jmyd8DhO+Pq5ZA+M5gRFyoa/RX2D
 M8Qw==
X-Gm-Message-State: AOAM533q3AnjCcdV/d2G5Lt3nEZba04B45Ks3c+x64CA9YE4DTOikJJA
 zlh3HP3ccU906K/tzzMcksnyN4Ewm6HQL/r1izM=
X-Google-Smtp-Source: ABdhPJyLAsuQ3uCXZ99AyyOZL9Rc7fvdTI9FkQY+/pGI6F1R566G0zFaqISrNLcx9SicxmQI2OnQ6g==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr8015401wmj.138.1599235637176; 
 Fri, 04 Sep 2020 09:07:17 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id h185sm12467609wme.25.2020.09.04.09.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:07:16 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 08/11] drm/amd/display: Set DC options from modifiers.
Date: Fri,  4 Sep 2020 18:07:06 +0200
Message-Id: <20200904160709.123970-9-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904160709.123970-1-bas@basnieuwenhuizen.nl>
References: <20200904160709.123970-1-bas@basnieuwenhuizen.nl>
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
Cc: maraeo@gmail.com, daniel@fooishbar.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 alexdeucher@gmail.com, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This sets the DC tiling options from the modifier, if modifiers
are used for the FB. This patch by itself does not expose the
support yet though.

There is not much validation yet to limit the scope of this
patch, but the current validation is at the same level as
the BO metadata path.

v2: Add modifier check to should_reset_plane.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 102 ++++++++++++++++--
 1 file changed, 95 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4fb77b25e28c..545d177bf703 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3840,6 +3840,83 @@ fill_gfx9_plane_attributes_from_flags(struct amdgpu_device *adev,
 	return 0;
 }
 
+static bool
+modifier_has_dcc(uint64_t modifier)
+{
+	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
+}
+
+static unsigned
+modifier_gfx9_swizzle_mode(uint64_t modifier)
+{
+	if (modifier == DRM_FORMAT_MOD_LINEAR)
+		return 0;
+
+	return AMD_FMT_MOD_GET(TILE, modifier);
+}
+
+static void
+fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
+				    union dc_tiling_info *tiling_info,
+				    uint64_t modifier)
+{
+	unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS, modifier);
+	unsigned int mod_pipe_xor_bits = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
+	unsigned int pkrs_log2 = AMD_FMT_MOD_GET(PACKERS, modifier);
+	unsigned int pipes_log2 = min(4u, mod_pipe_xor_bits);
+
+	fill_gfx9_tiling_info_from_device(adev, tiling_info);
+
+	if (!IS_AMD_FMT_MOD(modifier))
+		return;
+
+	tiling_info->gfx9.num_pipes = 1u << pipes_log2;
+	tiling_info->gfx9.num_shader_engines = 1u << (mod_pipe_xor_bits - pipes_log2);
+
+	if (adev->family >= AMDGPU_FAMILY_NV) {
+		tiling_info->gfx9.num_pkrs = 1u << pkrs_log2;
+	} else {
+		tiling_info->gfx9.num_banks = 1u << mod_bank_xor_bits;
+
+		/* for DCC we know it isn't rb aligned, so rb_per_se doesn't matter. */
+	}
+}
+
+static int
+fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
+					  const struct amdgpu_framebuffer *afb,
+					  const enum surface_pixel_format format,
+					  const enum dc_rotation_angle rotation,
+					  const struct plane_size *plane_size,
+					  union dc_tiling_info *tiling_info,
+					  struct dc_plane_dcc_param *dcc,
+					  struct dc_plane_address *address,
+					  const bool force_disable_dcc)
+{
+	const uint64_t modifier = afb->base.modifier;
+	int ret;
+
+	fill_gfx9_tiling_info_from_modifier(adev, tiling_info, modifier);
+	tiling_info->gfx9.swizzle = modifier_gfx9_swizzle_mode(modifier);
+
+	if (modifier_has_dcc(modifier) && !force_disable_dcc) {
+		uint64_t dcc_address = afb->address + afb->base.offsets[1];
+
+		dcc->enable = 1;
+		dcc->meta_pitch = afb->base.pitches[1];
+		dcc->independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
+
+		address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
+		address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
+	}
+
+	ret = validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int
 fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			     const struct amdgpu_framebuffer *afb,
@@ -3908,12 +3985,22 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 	}
 
 	if (adev->family >= AMDGPU_FAMILY_AI) {
-		ret = fill_gfx9_plane_attributes_from_flags(adev, afb, format, rotation,
-							    plane_size, tiling_info, dcc,
-							    address, tiling_flags,
-							    force_disable_dcc);
-		if (ret)
-			return ret;
+		if (afb->base.flags & DRM_MODE_FB_MODIFIERS) {
+			ret = fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
+									rotation, plane_size,
+									tiling_info, dcc,
+									address,
+									force_disable_dcc);
+			if (ret)
+				return ret;
+		} else {
+			ret = fill_gfx9_plane_attributes_from_flags(adev, afb, format, rotation,
+								    plane_size, tiling_info, dcc,
+								    address, tiling_flags,
+								    force_disable_dcc);
+			if (ret)
+				return ret;
+		}
 	} else {
 		fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
 	}
@@ -8372,7 +8459,8 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 		new_afb = (struct amdgpu_framebuffer *)new_other_state->fb;
 
 		/* Tiling and DCC changes also require bandwidth updates. */
-		if (old_afb->tiling_flags != new_afb->tiling_flags)
+		if (old_afb->tiling_flags != new_afb->tiling_flags ||
+		    old_afb->base.modifier != new_afb->base.modifier)
 			return true;
 	}
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
