Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30589C3064D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7BB10E99C;
	Wed, 26 Jun 2024 18:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kg30Ko7d";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8C210E999
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:32:05 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-6b505f11973so6573006d6.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426723; x=1720031523; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eaz2XXXQbDudnuts7b3N5AWyhGs3QKyUfgJkXsJeNAQ=;
 b=Kg30Ko7dE3vFclFmsTVNrgsPGu1Xn7Uy2GzI4ij0KYE55saDGmzwkpplcZpkqRbbZa
 J/LIh6O8HGX0BWB7b8HXFJZly1T3/3O1HCWpIdKqE8v3977Z2NRfTiQgc2jqVHGEh2CX
 3HnOZ6DFc/iwCFnqk+/Wt74ZwaemdVlXcT+slfnZwp3hxlereygvOEydL6IaG66b/80h
 3RiKu8HGgAPOzogo2Dh7vl+ki1+MqEFMDqk8T3jTy1wZmauI+eQBOSyD7aJPDNzMnQhI
 +LMpucuJsjYY4wQjgKj3qq96/08LE/WU5T/TeY7FsV0baRdHx1k8zCqUlUy7rVbWqxbF
 5Zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426723; x=1720031523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eaz2XXXQbDudnuts7b3N5AWyhGs3QKyUfgJkXsJeNAQ=;
 b=WU7+zcVMKEbDGHDvK0+yIyWR4jRMxGvKkR2tcjKKiaJJnYeCQ1WwjEP6XYuU1lvQBF
 hp4XMb/9S7NuNHUEkVKTnmAV1y0Jx0+WwL4HnqlZy42ey1HrKWXH/ALm5Bv4trS1n7kx
 U+ACIa+WaEWjy8mJf0FmqZhiMoJeJbzBKICcjK7U4N1izHwQjXP7SKSEEzYgeQlgvxBi
 GlEzqKjKuzApPWZ+UaDK51+xL3joVVxqVnaGIRZh1GYhUDD54OnXTai3j830/eG3l0Yg
 cgB3FgPlLedEns+jmO1jwwLd34x8kBzEEtcNvtdz49/XXJTzEWVqPuATftQd7PzJdCWh
 M/LQ==
X-Gm-Message-State: AOJu0Yz9oBWKloGfd7Mva0x10INdgOOkipZaH1EgfRegMAgyAEJCTGU1
 SMQnjBFT6UQcTXHVcpGwYHlyElBx5d4kly9sQVGE2BfIccPfbJsoAOjGFw==
X-Google-Smtp-Source: AGHT+IEe2GZ75qFI2asV1OxEhyeJgkge3pwlVPGz/lGk5KQyzhr+SK+gEIkOkMcCDSKIV0xPFltt/A==
X-Received: by 2002:a0c:e8c7:0:b0:6b5:ab8:3c5a with SMTP id
 6a1803df08f44-6b5636a1b5cmr98269166d6.25.1719426723439; 
 Wed, 26 Jun 2024 11:32:03 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:32:02 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Subject: [PATCH 07/13] drm/amdgpu: add amdgpu_framebuffer::gfx12_dcc
Date: Wed, 26 Jun 2024 14:31:29 -0400
Message-Id: <20240626183135.8606-7-marek.olsak@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626183135.8606-1-marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

amdgpu_framebuffer doesn't have tiling_flags, so we need this.

amdgpu_display_get_fb_info never gets NULL parameters, so checking for NULL
was useless.

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 15 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 3c5fb907bdd9..3f431e6b155a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1143,7 +1143,8 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 }
 
 static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb,
-				      uint64_t *tiling_flags, bool *tmz_surface)
+				      uint64_t *tiling_flags, bool *tmz_surface,
+				      bool *gfx12_dcc)
 {
 	struct amdgpu_bo *rbo;
 	int r;
@@ -1151,6 +1152,7 @@ static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb
 	if (!amdgpu_fb) {
 		*tiling_flags = 0;
 		*tmz_surface = false;
+		*gfx12_dcc = false;
 		return 0;
 	}
 
@@ -1164,11 +1166,9 @@ static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb
 		return r;
 	}
 
-	if (tiling_flags)
-		amdgpu_bo_get_tiling_flags(rbo, tiling_flags);
-
-	if (tmz_surface)
-		*tmz_surface = amdgpu_bo_encrypted(rbo);
+	amdgpu_bo_get_tiling_flags(rbo, tiling_flags);
+	*tmz_surface = amdgpu_bo_encrypted(rbo);
+	*gfx12_dcc = rbo->flags & AMDGPU_GEM_CREATE_GFX12_DCC;
 
 	amdgpu_bo_unreserve(rbo);
 
@@ -1237,7 +1237,8 @@ static int amdgpu_display_framebuffer_init(struct drm_device *dev,
 		}
 	}
 
-	ret = amdgpu_display_get_fb_info(rfb, &rfb->tiling_flags, &rfb->tmz_surface);
+	ret = amdgpu_display_get_fb_info(rfb, &rfb->tiling_flags, &rfb->tmz_surface,
+					 &rfb->gfx12_dcc);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 1fe21a70ddd0..d002b845d8ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -300,6 +300,7 @@ struct amdgpu_framebuffer {
 
 	uint64_t tiling_flags;
 	bool tmz_surface;
+	bool gfx12_dcc;
 
 	/* caching for later use */
 	uint64_t address;
-- 
2.34.1

