Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B6C55178
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB682225F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="HOT6qB15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB682225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B8CF6EEB2;
	Wed, 21 Oct 2020 23:31:40 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4262B6EEB2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 23:31:39 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id o18so4281392edq.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7tktjmcwk5yXhgNFT9XQCSpahtSlQF+mPeJj6PdoM48=;
 b=HOT6qB15DRbZ27JhtZzYMESygv3hG2umSVUv3PAtql/f+0Kh2M3wxhDuEGz6abThBX
 ay/AlpT34+ZQEW5P2MZIBX0I/9WpBX6DGMI43c3SRzUvAxAmy+D836s02tCvEoKg3eUH
 SWR/H9ijFqVBTggOObzkNF2AFGGRyqKQrfhK00wgMAfLwtT7wMJjopcfEX9oAr/2s1sO
 YFMFgz29QN+Xw1rlsZq8WbZVg6MiSNL9S1zbdugV77EzyEpIEJLswuWZREMrEPq2iihS
 KkNWc73QFe08uAOwI1wsnFRIn91zW5jgRY7jVdF4r73hagBR5/RROyDqxOcyhwCVTzbm
 hagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7tktjmcwk5yXhgNFT9XQCSpahtSlQF+mPeJj6PdoM48=;
 b=HOlaqOPTYZeaETN9cjnQBIuevvip8EfzEvoZAoBmCCToAk5LQskLmFDNuO7Lz9/Bbp
 TZ1hdwZfL4nmjYbbGdRJ58dKriNXEdaXi3EjJwhpCW6HsbIMAzy8MH9OKwHQQjqNQO4W
 0ky8d9ASXPh30gjzVc8Z8Ni33kcb2jPvuxIYYoZhd4Lv3ukbR/Zk4k/1XlLRd+j7yFk/
 PKgjLbEpwwPo11m2SUyFrbOdcGOumOjkjeqGC4t//Dj2BGSXVbM4PLUVkBVyrrOsIu4L
 6Wz8qqxA9UnlJk03R4SZsf5MrqbR77x06joBnPxMsSvNycokM0GimfD+CcL2vEzPIvUw
 Z7AQ==
X-Gm-Message-State: AOAM533NvSLPRHfV8tLIyfCf9r1klSkOY9KrhWPAAr//CXenlRXR3I2v
 4SB7LeYPizcUi4tsBhbynsYhz5Fj96Ps6Ryj
X-Google-Smtp-Source: ABdhPJwuKdWeP7GaedFgJa7TLi5WpSdqmXyeV4Rf5VwR7bsDGmxUitYEPLBVVMrlxJUpHmeklFW4eQ==
X-Received: by 2002:a05:6402:551:: with SMTP id
 i17mr5231149edx.384.1603323097686; 
 Wed, 21 Oct 2020 16:31:37 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id k23sm2845236ejs.100.2020.10.21.16.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 16:31:37 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 03/11] drm/amd/display: Honor the offset for plane 0.
Date: Thu, 22 Oct 2020 01:31:22 +0200
Message-Id: <20201021233130.874615-4-bas@basnieuwenhuizen.nl>
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
Cc: maraeo@gmail.com, sunpeng.li@amd.com, stable@vger.kernel.org,
 daniel@ffwll.ch, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 alexdeucher@gmail.com, harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With modifiers I'd like to support non-dedicated buffers for
images.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: stable@vger.kernel.org # 5.1.0
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 73987fdb6a09..833887b9b0ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3894,6 +3894,7 @@ fill_plane_dcc_attributes(struct amdgpu_device *adev,
 	struct dc *dc = adev->dm.dc;
 	struct dc_dcc_surface_param input;
 	struct dc_surface_dcc_cap output;
+	uint64_t plane_address = afb->address + afb->base.offsets[0];
 	uint32_t offset = AMDGPU_TILING_GET(info, DCC_OFFSET_256B);
 	uint32_t i64b = AMDGPU_TILING_GET(info, DCC_INDEPENDENT_64B) != 0;
 	uint64_t dcc_address;
@@ -3937,7 +3938,7 @@ fill_plane_dcc_attributes(struct amdgpu_device *adev,
 		AMDGPU_TILING_GET(info, DCC_PITCH_MAX) + 1;
 	dcc->independent_64b_blks = i64b;
 
-	dcc_address = get_dcc_address(afb->address, info);
+	dcc_address = get_dcc_address(plane_address, info);
 	address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
 	address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
 
@@ -3968,6 +3969,8 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 	address->tmz_surface = tmz_surface;
 
 	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN) {
+		uint64_t addr = afb->address + fb->offsets[0];
+
 		plane_size->surface_size.x = 0;
 		plane_size->surface_size.y = 0;
 		plane_size->surface_size.width = fb->width;
@@ -3976,9 +3979,10 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			fb->pitches[0] / fb->format->cpp[0];
 
 		address->type = PLN_ADDR_TYPE_GRAPHICS;
-		address->grph.addr.low_part = lower_32_bits(afb->address);
-		address->grph.addr.high_part = upper_32_bits(afb->address);
+		address->grph.addr.low_part = lower_32_bits(addr);
+		address->grph.addr.high_part = upper_32_bits(addr);
 	} else if (format < SURFACE_PIXEL_FORMAT_INVALID) {
+		uint64_t luma_addr = afb->address + fb->offsets[0];
 		uint64_t chroma_addr = afb->address + fb->offsets[1];
 
 		plane_size->surface_size.x = 0;
@@ -3999,9 +4003,9 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 
 		address->type = PLN_ADDR_TYPE_VIDEO_PROGRESSIVE;
 		address->video_progressive.luma_addr.low_part =
-			lower_32_bits(afb->address);
+			lower_32_bits(luma_addr);
 		address->video_progressive.luma_addr.high_part =
-			upper_32_bits(afb->address);
+			upper_32_bits(luma_addr);
 		address->video_progressive.chroma_addr.low_part =
 			lower_32_bits(chroma_addr);
 		address->video_progressive.chroma_addr.high_part =
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
