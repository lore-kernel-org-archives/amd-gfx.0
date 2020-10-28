Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BDDC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C95842070E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="fyJd6dv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95842070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C1656E825;
	Wed, 28 Oct 2020 23:52:55 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332916E825
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 23:52:53 +0000 (UTC)
Received: by mail-ed1-x544.google.com with SMTP id x1so1333053eds.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=59FEjKsohURaFxWvGfG51/QWAzC4mS0X8J1o66c38FE=;
 b=fyJd6dv2DDyMHGGj4VA6qejjFZuT9PpLA+BGUpPjam6H4Q+xPZde688pZI9icytEEA
 BvFYIHRit1zgvfOB1tNu5quFuR4MR18kyX9gEADktnczakGXnhb6Tc3cBtnqE8zyeg4Q
 fEYrK1QRAsXfBUFCNUSMOHuJqjl+t80xXDDk9A9AOOGNseC8nvq03NG9EwpHV6RLfgFl
 57wZDfRthmGCTH7JCdahypVMqCuklabQU3evDmQ5nlchO3HRFz1gClu0DP8UanyJG9+0
 JFxE7pCfDiQk3q8VvTc7//0HbvfTdjHxthNl9XzSy4aE9A8J824VQuEpv3k1TTM+XC00
 FibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=59FEjKsohURaFxWvGfG51/QWAzC4mS0X8J1o66c38FE=;
 b=JXR3Yc69euWmK/hyg5B97YY6Zs7cYmUywgcq4crEfYsbUoZvRKyyBygCQszDS0P4+G
 uKJU8aMz8mCgQdqGtK/vz6Nw/jtwasbbScBmB2eng2No3pAl9pGPNCKmPLlMygOxMpi1
 P1ShRXeX2B8ijS4YN0SPKP3TzmYsLa43HWDZwz0L6cocoEJp/nXuDBC3YsUBNPSk3BOZ
 OrSmkoeuiz/7bdBUHFYdFrgOq/rAA4LPBo69k2G+j8QG5+elHz5jGnWTtgYbAYP+Uzd3
 3Cl6aB3fizZz0NDCq4sg27FQnt69avKrIFLJurQFZoVfSborAyChuC0gfYQJPTUyIF4q
 wwBA==
X-Gm-Message-State: AOAM531craESu8EIaoxOWWaLnchgWKSpp+BruSPw45YSfpqpkbd1PX2l
 umlExOW5fobu6MrpmFK0KWmpG+4Ewj9Qzg==
X-Google-Smtp-Source: ABdhPJwrJn3tWY7dVF8lCYIp+Q78Z0g0RokvIe4Inx6IdgRcp2KN/JR42lnAtL0cs+TIQCNVgkyClg==
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr1419665edt.141.1603929171659; 
 Wed, 28 Oct 2020 16:52:51 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id o13sm479174ejr.120.2020.10.28.16.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 16:52:51 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 11/11] drm/amd/display: Clean up GFX9 tiling_flags path.
Date: Thu, 29 Oct 2020 00:52:41 +0100
Message-Id: <20201028235241.3299-12-bas@basnieuwenhuizen.nl>
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

We're unconditionally using modifiers internally for GFX9+ now.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 74 ++-----------------
 1 file changed, 7 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2202c0060b5c..423f6f07a070 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3948,57 +3948,6 @@ validate_dcc(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void
-fill_dcc_params_from_flags(const struct amdgpu_framebuffer *afb,
-			   struct dc_plane_dcc_param *dcc,
-			   struct dc_plane_address *address,
-			   const uint64_t flags, bool force_disable_dcc)
-{
-	uint64_t dcc_address;
-	uint64_t plane_address = afb->address + afb->base.offsets[0];
-	uint32_t offset = AMDGPU_TILING_GET(flags, DCC_OFFSET_256B);
-	uint32_t i64b = AMDGPU_TILING_GET(flags, DCC_INDEPENDENT_64B) != 0;
-
-	if (!offset || force_disable_dcc)
-		return;
-
-	dcc->enable = 1;
-	dcc->meta_pitch = AMDGPU_TILING_GET(flags, DCC_PITCH_MAX) + 1;
-	dcc->independent_64b_blks = i64b;
-
-	dcc_address = plane_address + (uint64_t)offset * 256;
-	address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
-	address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
-}
-
-
-static int
-fill_gfx9_plane_attributes_from_flags(struct amdgpu_device *adev,
-				      const struct amdgpu_framebuffer *afb,
-				      const enum surface_pixel_format format,
-				      const enum dc_rotation_angle rotation,
-				      const struct plane_size *plane_size,
-				      union dc_tiling_info *tiling_info,
-				      struct dc_plane_dcc_param *dcc,
-				      struct dc_plane_address *address,
-				      uint64_t tiling_flags,
-				      bool force_disable_dcc)
-{
-	int ret;
-
-	fill_gfx9_tiling_info_from_device(adev, tiling_info);
-
-	tiling_info->gfx9.swizzle =
-		AMDGPU_TILING_GET(tiling_flags, SWIZZLE_MODE);
-
-	fill_dcc_params_from_flags(afb, dcc, address, tiling_flags, force_disable_dcc);
-	ret = validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static bool
 modifier_has_dcc(uint64_t modifier)
 {
@@ -4566,22 +4515,13 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 	}
 
 	if (adev->family >= AMDGPU_FAMILY_AI) {
-		if (afb->base.flags & DRM_MODE_FB_MODIFIERS) {
-			ret = fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
-									rotation, plane_size,
-									tiling_info, dcc,
-									address,
-									force_disable_dcc);
-			if (ret)
-				return ret;
-		} else {
-			ret = fill_gfx9_plane_attributes_from_flags(adev, afb, format, rotation,
-								    plane_size, tiling_info, dcc,
-								    address, tiling_flags,
-								    force_disable_dcc);
-			if (ret)
-				return ret;
-		}
+		ret = fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
+								rotation, plane_size,
+								tiling_info, dcc,
+								address,
+								force_disable_dcc);
+		if (ret)
+			return ret;
 	} else {
 		fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
 	}
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
