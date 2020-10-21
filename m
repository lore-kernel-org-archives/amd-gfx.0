Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95B9C55178
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389DB2225F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="QHAXfQtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389DB2225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD06D6EEBD;
	Wed, 21 Oct 2020 23:31:51 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0711B6EEBD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 23:31:50 +0000 (UTC)
Received: by mail-ed1-x542.google.com with SMTP id bc23so1638072edb.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 16:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ocFLR7/CfV3yazDzjhMujnIzbhVcb+AZrxt+eWLVcz8=;
 b=QHAXfQtNS86OdwIEK8c0bjC9Bq4jr+3B3X3lJgrjMgfCH43wDgO0hHPNofvmXxya7z
 JWd5CMWB9k6h0PlRG5lHTXGy8xiL7DybD5Y89BN6RCDUFkKD9M9zWEWsSNKsCSNk+cTi
 va5Iv10+tT2Fvf/lTNoB/EaRiadtWXYkTU3t+g9p2eQTcEibze69XXUCMAi8BlFwSjbi
 GAeuVHoqQoCOUn9rdy9zG+5Y1EZwe3tN0LzKSZ/ebdVUcsXSjwXd2vcR8wiAY5RyAzbm
 hd48XPaY2qKKQCsxfdbAzDggbUoOcu0F7+OPYQZ3dXmXdYeu3ct7UOR25bGd3GTBItH2
 rhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ocFLR7/CfV3yazDzjhMujnIzbhVcb+AZrxt+eWLVcz8=;
 b=bnKH2wWj/FMqslY4BuYkzhJHvx4yCGJI1Omwr3jO8t8j2cdr1Yq6i3C4LQW/xtzRBk
 lvQrnkhzgKOpkwhQB2PKejdZq/pGO6F/rXUwDIb5Dz4Iv/218X7Dtw/VkuDj7STB9Ax8
 C9QZyehw2dLmWIHNC2Tf1MrMIBw9Nseo7SYZHAehYHikAOuosQeDQy0QJLA64t647xsX
 3Nz5vZJOOhh2RncxKKfxSSbSRnlXIM1H6Frf6CpoTLg4xlg3U2MNwlyThd/D/EpWT4ig
 5dzO+1MhfKXXCp2DVd9AzGIpGccSTg7P+sGj2OO/BS/ARh629/lRuRjz32pSeWyZV/MN
 5pRw==
X-Gm-Message-State: AOAM532FBpi4IWzFNzatc+kN+KEQcTGjMyd0HdO8ckNjtGPXA8InzICp
 YjluiaeXqKZDQJ21SJQQy69Gn6uhaoi/I0BX
X-Google-Smtp-Source: ABdhPJzHwWTpmPUWwHO5DqYeJaocevSYCXw/CKqkrIB+Mx47kxzqg++o46QRZZopurGT1Ej85kgk5Q==
X-Received: by 2002:a05:6402:c6:: with SMTP id
 i6mr5410780edu.363.1603323108114; 
 Wed, 21 Oct 2020 16:31:48 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id k23sm2845236ejs.100.2020.10.21.16.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 16:31:47 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 11/11] drm/amd/display: Clean up GFX9 tiling_flags path.
Date: Thu, 22 Oct 2020 01:31:30 +0200
Message-Id: <20201021233130.874615-12-bas@basnieuwenhuizen.nl>
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

We're unconditionally using modifiers internally for GFX9+ now.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 74 ++-----------------
 1 file changed, 7 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a1ce325f2fd1..ed7215737b22 100644
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
@@ -4565,22 +4514,13 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
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
