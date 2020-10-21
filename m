Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5F9C56201
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F8A2225F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="W7Im4iiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F8A2225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF7A6EEB7;
	Wed, 21 Oct 2020 23:31:46 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0CF6EEB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 23:31:45 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id dt13so5627049ejb.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 16:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ryen1cCa8xw+mhpBaXSWR/l1v7+984S2xUGDSKOKJCk=;
 b=W7Im4iiENn3ADzTAb5BSxF9zVWTcZFLDKMWMsaP1CfmOWjlz/2lZAum7K69h/YW5Cd
 DjOr0MIX6PGULnaWPzW/IrgYyFYn8ibuTrOCl41N3aLIeaj63C0JJ1SLCTFcg0hf7Aww
 blpU3psXvK8cpU+BBc2FLFiGL07Bdxfg85Lh326uNNhmNx64TZl+4Om0bl4I9M9GN33G
 Gu2hQ50I2SlV/GcArf9M1ZRWbX21Sx0zdffg7CjgdX1mjlq2Tou7Jmz0shCq2EWLiQha
 7wfZ7Hkxz3D7knbxcBPeUe5jSYEDBwLNhgzinxx0+iTepjAHiOpOFPc7lqMW/y6SNQ7+
 bcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ryen1cCa8xw+mhpBaXSWR/l1v7+984S2xUGDSKOKJCk=;
 b=JTMMUfXmek6nyl41qFanYSMA1kgZSJ7mDFAZJbIqxU13gG2lgjGd/riMYuSM4rlz9X
 8ENYEh9Cezt8Fu1lIbhXLr28jWuwf16HndX/D7yLYbmKWIEXK78PsEKiwSXSTrVq7GAB
 yccMlo3+SkcOxaPPgR9a6ozGaEe0oASWTqQDMhtkV2nyde/j59W1VgSF0n/cFig5KrBE
 IPUa8OJt2XQlfmInC3l5aUZskzEPvbJUTnXnvPCsgE0dgcMWEyCuM5NIuKDHmtjQ/yGK
 zdCmOIpbpjK0uidrn2tLZDbaEt/AHePpkh4nyyCVURo7WSyAjCW7WAJoDCbA/NznBMyR
 ty8g==
X-Gm-Message-State: AOAM530mvcStdBy6rMbtHVdDrXdULCIfOa+T8MrqOJag/T7LWM44NvR5
 NUa8A3O0Gdk9ekKWgNyrO61Ov6LraKe7WeJ4
X-Google-Smtp-Source: ABdhPJxr1FwaUDBqQC7hVG78bmkVfxUk6rh3aHI//4CIBLFk9vuaBHQAuWj3obDOSnZ43HR7OokB+Q==
X-Received: by 2002:a17:906:284f:: with SMTP id
 s15mr5913870ejc.336.1603323103587; 
 Wed, 21 Oct 2020 16:31:43 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id k23sm2845236ejs.100.2020.10.21.16.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 16:31:42 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 08/11] drm/amd/display: Set DC options from modifiers.
Date: Thu, 22 Oct 2020 01:31:27 +0200
Message-Id: <20201021233130.874615-9-bas@basnieuwenhuizen.nl>
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
index 479c886816d9..034397c1f2b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3995,6 +3995,83 @@ fill_gfx9_plane_attributes_from_flags(struct amdgpu_device *adev,
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
@@ -4063,12 +4140,22 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
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
@@ -8511,7 +8598,8 @@ static bool should_reset_plane(struct drm_atomic_state *state,
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
