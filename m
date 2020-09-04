Return-Path: <SRS0=eFkV=CN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4F2C31E40
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5987C20829
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen-nl.20150623.gappssmtp.com header.i=@basnieuwenhuizen-nl.20150623.gappssmtp.com header.b="aGwk9zie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5987C20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB60A6EC92;
	Fri,  4 Sep 2020 16:07:23 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF666EC90
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2020 16:07:22 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id e16so7291706wrm.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2020 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen-nl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J9ot4dVg+gmoEa6EnvAB4TB3j6uAys0SZkmM4BqciWs=;
 b=aGwk9ziegtBcMDkovWv0SYipppmLXqIFf1itGfMILRNsVtCyHF9cYXk7s9tnZPbGxA
 spjGgM3JU23qYLgW1ME3hKpUOZ0+lH3Q8UekcsHvqJy91TU9qjacUQatHyDdv19hQFSL
 jzJ40zsMrkwyg/9aP+/XhcBRDkOVxbJIA4PUVzbY1vsL9qKdk35iZ59c+C9C+HhzbhIG
 crZyVxwtIIA4e+X0KROB1xOTF4QBj89ysDA41X3bp6u2L4YBG+ITzhTJ5bn5si4l9EPI
 /uvd3lfjLSU2omwH9pNLyYWvjgnfUHHhTShuas0ISB83+ZZ35gp/e/zCuyyDLzI3NnUI
 +oAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J9ot4dVg+gmoEa6EnvAB4TB3j6uAys0SZkmM4BqciWs=;
 b=VRuOrfWgwS5S9SPsPR/SKowu6pXS7JK+bteUzt+l36qn2UQp5RYv4NdoWKXbedw6qb
 LtBnh1qyY5bYKnKHUkjdYTAlIjD7c5UJfpRmWc/HVc4koBg9vJHxsLsyeoHkzItyfq5O
 qCEMjRs6xXcw3epbUz/0fToIqeHgYAp79PaI+H8rh87dE2+uRKzepHX3Swq8zjILbKC0
 +SBI/aKdNXnXfqsJXlVl0DSaLmos6EQNrvYdd4xhyjAIHhu3aVfLdvEhJ9GhEi+VutR4
 SPaz/EkltMfzGJPd117HnE6Xp6pDrCIjtge/2i01QoZaQnr/bAlIpx1YZvJEGesAyh62
 UWIA==
X-Gm-Message-State: AOAM531BcTCiJi0V0nYY4uB+tmNJMkH3k5MXWgCUXdu2S/mxUwo/u/NN
 SU+Bk1r2cPFYpZS4zDI6koaeM/QWWGivF1OfuSs=
X-Google-Smtp-Source: ABdhPJxqa7JHr2i8AVUDBKfvLEZk6qfyBxGf8C9rsJCMKtikBgrkOZA+RnP+UYYoMziVaT7xfd/W+g==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr8295124wrw.223.1599235640404; 
 Fri, 04 Sep 2020 09:07:20 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id h185sm12467609wme.25.2020.09.04.09.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:07:19 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 11/11] drm/amd/display: Clean up GFX9 tiling_flags path.
Date: Fri,  4 Sep 2020 18:07:09 +0200
Message-Id: <20200904160709.123970-12-bas@basnieuwenhuizen.nl>
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

We're unconditionally using modifiers internally for GFX9+ now.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 74 ++-----------------
 1 file changed, 7 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 25b1c7c821d2..f4a4ca84485a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3793,57 +3793,6 @@ validate_dcc(struct amdgpu_device *adev,
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
@@ -4410,22 +4359,13 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
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
