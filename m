Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12289C36008
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 01:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A923710E85F;
	Sat, 22 Mar 2025 01:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SyS0HH4s";
	dkim-atps=neutral
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7372010E85A
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 01:47:25 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-476af5479feso24531591cf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742608044; x=1743212844; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xYgpFnCENjyCx0ujr8tvfEFugsuUEEd552y0lAob0/M=;
 b=SyS0HH4sS7Omc/45phZW4XB6J99fgCWAvnQc2FGYspzVtuIjlYxSavXkRuBlvkKtVq
 7MqQVxgjfsFL40gJKjwsFKKpDrSPlnOW5DC7ihR5xNKEOXM6WDVQv+nmhT/8xzXjrISK
 iJPMcOrZvePc16fTcIhKYRsoMfTuK29f0IxYPO4HCsiOod0IjDrIVb07PbtqZCkDg6SN
 EbNd98bSUaZq4sfiXZUn133SsrEytZGmp08soBy1/7VCL2//8bj+ZXwvZmErIKiDaaap
 s8xXxGqqqBfRlJBZ6KFw0j1KFAZ/ee1JXXdd6a5OJyzC89OJteydzns22dX5x0sSP0CN
 QlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742608044; x=1743212844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYgpFnCENjyCx0ujr8tvfEFugsuUEEd552y0lAob0/M=;
 b=nP3P+4tzFhCxA1e+rowyn6+Iq+2ht0X4pI2XZaqltsPky4QS2eCywAmIjuwF3RJynw
 zIOeGFdQC1NPrx7Ki1fGb3QZHeDzWrcEr/Rjj5cAw5CpxkGuyCKfmIO30aw6pQH/Q82x
 iYDSqQmrDorrB4BR98XcRzjcTK3WAejs69G5xbRC0+QriydyaogFRKkkAOQn+1CL8Nn3
 UdSB5dgazLO6n3otIjqEMANFXH9dkikiJMQX2W9UqD+EsSxwSF3OSBADm9I7+hJli/WB
 Bevhp/ZkL8u4s3eCifrvg1voqqKbpbBVRE8X/A/RAT3YWEA1S8Tz3VQsOJw2/KF1R2Du
 q6BA==
X-Gm-Message-State: AOJu0YznwTx36J6hkAbSur7RI5cfDd7TzzWVUwjEDWRZijDWVdryvKJq
 PkCm9e6ugeCDdVoZcT4SJYAKJWh8mwLMEiFALfiui5AnJSMgfdBrtRD5ag==
X-Gm-Gg: ASbGncvFWA3uxeS8B/uLf8zRrR3gQr+U2i4lKKjuM4vI/j5X7n66PxrquBfs1vdo6+1
 WSqN4c84Hr97/gtPjSZhzkDusHf42f+rxYo+iwYkpB6hBdctcpAkx/xzLerA0N1H1Jk3C634A38
 gNTtRRER8hCQGAa6NpBAGZl4FVVTlBqXNEigNrdURSFK4ItHc6cS3F5+YmbNaY3NXYzzeIAVAL+
 1VIRD4uykj4GHLzxQysfqi+iixiL8qboFHVGYxhrmWQBmawFuUY/ouXIuuSz/RzsHiljUKcQZsQ
 qemgDH3PeEiOXBhYDS6uQIvklc/eERSE+aY/cEvalIhHSyCFwVpa94JiC+En42ibo40=
X-Google-Smtp-Source: AGHT+IEKhwEiE1g4uo4JlnuxNAY/aSEDPBSn6B6lpi15ckLztAZrR20KHcr/TfXC+VDwH5X5UGhh3g==
X-Received: by 2002:ac8:690f:0:b0:477:c04:b512 with SMTP id
 d75a77b69052e-4771dd7fb72mr88309991cf.16.1742608044352; 
 Fri, 21 Mar 2025 18:47:24 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159964sm18688591cf.8.2025.03.21.18.47.23
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 18:47:24 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/18] drm/amdgpu: cleanup DCE6 a bit more
Date: Fri, 21 Mar 2025 21:46:59 -0400
Message-ID: <20250322014700.62356-18-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
References: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use shifts already available in DCE6's defines, masks and shifts.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sid.h      | 8 --------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 19b267f1540b..761ba83385ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1968,8 +1968,8 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
 	case DRM_FORMAT_ABGR8888:
 		fb_format = ((GRPH_DEPTH_32BPP << GRPH_CONTROL__GRPH_DEPTH__SHIFT) |
 			     (GRPH_FORMAT_ARGB8888 << GRPH_CONTROL__GRPH_FORMAT__SHIFT));
-		fb_swap = (GRPH_RED_CROSSBAR(GRPH_RED_SEL_B) |
-			   GRPH_BLUE_CROSSBAR(GRPH_BLUE_SEL_R));
+		fb_swap = ((GRPH_RED_SEL_B << GRPH_SWAP_CNTL__GRPH_RED_CROSSBAR__SHIFT) |
+			   (GRPH_BLUE_SEL_R << GRPH_SWAP_CNTL__GRPH_BLUE_CROSSBAR__SHIFT));
 #ifdef __BIG_ENDIAN
 		fb_swap |= (GRPH_ENDIAN_8IN32 << GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index b5d5ff639be4..6c6bf2154ce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -708,26 +708,18 @@
 #define ES_AND_GS_AUTO       3
 #define BUF_SWAP_32BIT       (2 << 16)
 
-
-#define GRPH_RED_CROSSBAR(x)           (((x) & 0x3) << 4)
 #define GRPH_RED_SEL_R                 0
 #define GRPH_RED_SEL_G                 1
 #define GRPH_RED_SEL_B                 2
 #define GRPH_RED_SEL_A                 3
-
-#define GRPH_GREEN_CROSSBAR(x)         (((x) & 0x3) << 6)
 #define GRPH_GREEN_SEL_G               0
 #define GRPH_GREEN_SEL_B               1
 #define GRPH_GREEN_SEL_A               2
 #define GRPH_GREEN_SEL_R               3
-
-#define GRPH_BLUE_CROSSBAR(x)          (((x) & 0x3) << 8)
 #define GRPH_BLUE_SEL_B                0
 #define GRPH_BLUE_SEL_A                1
 #define GRPH_BLUE_SEL_R                2
 #define GRPH_BLUE_SEL_G                3
-
-#define GRPH_ALPHA_CROSSBAR(x)         (((x) & 0x3) << 10)
 #define GRPH_ALPHA_SEL_A               0
 #define GRPH_ALPHA_SEL_R               1
 #define GRPH_ALPHA_SEL_G               2
-- 
2.48.1

