Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0F4C35FF8
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E144110E32B;
	Mon, 17 Mar 2025 06:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FV5vF6EE";
	dkim-atps=neutral
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6900F10E271
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:37 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-6e8fc176825so36224736d6.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191656; x=1742796456; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xYgpFnCENjyCx0ujr8tvfEFugsuUEEd552y0lAob0/M=;
 b=FV5vF6EET+0RcgfDXwbMwd80bYXknKhoP//qgmFJ3aq3d+e7eUA6pc8TwSqrSzyFLj
 xt283zcAQtFWJ2HP3BIYaiqMCXylkhDZQvjyOZckMYoe5uJPtD5Y6Gc0vN9v6nX5qUM5
 BzcBtixtS0XHQbekyxiYeVhqdI3qoC/pGcHIaasUnvafip1gyTWzVFYCiRLk8xbz7Fvo
 EtNcSndZAdROJtupcZ38SEPcnmyPzMytIQ5EqCQ7LRIxq4H8Jbdwp1gAzp7NbgRuayr4
 FpJUn7CxDpU5LEfmq/dr9PmZGib9onhMwO9TlN7WWPG5Vbjcb/XOB8BXZzqyVJuqjwga
 h6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191656; x=1742796456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYgpFnCENjyCx0ujr8tvfEFugsuUEEd552y0lAob0/M=;
 b=cPEOtrMlI/MWEUFq/xe9DqLgM4xlKb0B0DWI4vxla6MjuVKMABUI7af++Dk44yd9TF
 6QtfDprAG2WvkOckPIL2yP1790dfI8DTuM8V2juWtI/vy1FxMOVTZS3ndOMgqcE7vKmz
 SI2dxcBmipuZwcyByoyJnHL4ktbpfQ/U+SFypMcNrrTCTZ2Wat1fQaUlB4WtTJs33mKp
 LMJ8vE4eSFnIq8GltoSF//iJmYy9Xmlhp5QEtFdZWX9SRk7A7r3J603tiE4LZZ3Lwrbd
 1cFA0lqyAov0iMCfvF3kS+f9n21rmk3jEpFTeMHgLwsk+JCXQHyGaus50fr0I8GxqNzf
 xd5A==
X-Gm-Message-State: AOJu0Yz8uQiR8T7NdR01Pf2CXzH9Fk5f32KDIKbYR4pOXOilcii3Rb4z
 Q/42mF+g0ZTrKAPsC/Z+oZdB3i2Ag1kScp73uFtmVaVvto7NsDyM0SQdEg==
X-Gm-Gg: ASbGncskqBEApQB6G0Dd+018QqBXEewu4Dkj6UgrViwndrrss9mv0ojrn0lAlS9fAiQ
 W55ARF2g65vtn5fIF5upT/aBa3w1Xm22ct25k7touQNXveNPOCwxKDqe+/zm9tVsw+quDjY3xfT
 chXD6F7k+CGRKsguJ9ltiAkvgcpApgKTuwjzYl4LJ12j0QRqR4a2znH3DtLcnMd4PPVBQBvl9MH
 gCQQw6KSASo+KO1v3M898qrmlTr0Umb1iVHBrNBnG9hyf9eLANbM10zwy0lHDFIUFuXIID5LjoJ
 +cuk10Nv4uHk7SnO0/vWujzBXbt/zwzKRWct/ZTxqx8IUYqM6aH05LnjmMqS2wxDqYs=
X-Google-Smtp-Source: AGHT+IEMNBEcC0em1xn1zG/Id5py3IvfMb7YLZukIk2SwRcNtlBj+exqyt63yLNPPjPJXl2qH8wYuQ==
X-Received: by 2002:a05:6214:d05:b0:6e4:4011:9dff with SMTP id
 6a1803df08f44-6eaea9f402dmr131895246d6.1.1742191656304; 
 Sun, 16 Mar 2025 23:07:36 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.35
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:35 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/18] drm/amdgpu: cleanup DCE6 a bit more
Date: Mon, 17 Mar 2025 02:07:01 -0400
Message-ID: <20250317060702.5297-18-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
References: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
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

