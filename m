Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE795C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1CF2070E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="gQfm91gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1CF2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC4A6E81F;
	Wed, 28 Oct 2020 23:52:46 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3594C6E81B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 23:52:44 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id v4so1346956edi.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DGSEKASS/bd8TuE/KrHjD98p0JJoKSSs8WsMzHa7qJg=;
 b=gQfm91glFvnLHCE77A7mxjK94GjUmr1p6ovSPgN2UOvOBqDxTpNbF3gQHGsbVkph+y
 xzRteosujQg2MYEqILin4sjdlXhEikOdqxovvyAxmY2S50JP4D+tGL/vBiEGeHjiiPh/
 JtE0bqKY9iXhO1UMYGKYpEJF5rfG+Tirfnn8PKnZv/gXyhz1EKiyNBrfI3iUpICH2ma6
 7cpkHiFM5mDUysJkx1ew0ynCxXrAXiX2bQOPUGEL/CxBGaHcjnV5xWo6VRCaCDLNjrK3
 lJNHPdyWMcYISX9tTh105Ex+4C/VDT4xUrw1SRCsI9wsFzr70AYeCHOKkFpOb4/gS6ub
 NSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DGSEKASS/bd8TuE/KrHjD98p0JJoKSSs8WsMzHa7qJg=;
 b=EMzRTa9BNroCxrKTPGXwkc3hp9rn39PECoNx9y6ayDD1YV3De8nA1ObMu0TBr8iiMc
 Ho08UAx8l0jinF9mQmXvBT6iillgK8T5Xmx4VGsTXXGIRexFBG9ow7S6RZDr9/uqeSng
 W9eZPlPPkT4X4BTVoYTf22a5l2yiL4C6cwvm1tIkFilSLG1OuDfRnLEYiRX/7/d2O5Ii
 iPfwTkNCOpO/tf9Ost+Wiy7eCR9BvYWB++gLKpMI3M88I0VhggWqXSqWloHwvbwawHRY
 Chj4NkMExOhscwpigdNU8aqxDIusdhp+C7EyLz7FpTT9VL+TzDFWe60/rb1+Y+gXIIHF
 cvjA==
X-Gm-Message-State: AOAM533SUgnNCqnYxwuRezskiRUiTxN+mFX4u9jwEzo0S0aff5r8kjc3
 a1NFNGLQqsljG6Fv24US3TCp2BUnNh7+xg==
X-Google-Smtp-Source: ABdhPJyJ9WG/DfcFLhThKPqpbAG2IQWkS6UMWpOU7x8oVaRhOcjFrvFo6JK40wMy8fRNhlp+Wec2eg==
X-Received: by 2002:aa7:c98f:: with SMTP id c15mr1455564edt.200.1603929162684; 
 Wed, 28 Oct 2020 16:52:42 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id o13sm479174ejr.120.2020.10.28.16.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 16:52:41 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 03/11] drm/amd/display: Honor the offset for plane 0.
Date: Thu, 29 Oct 2020 00:52:33 +0100
Message-Id: <20201028235241.3299-4-bas@basnieuwenhuizen.nl>
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
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, alexdeucher@gmail.com,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With modifiers I'd like to support non-dedicated buffers for
images.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
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
