Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1389FFB44C8
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6157F10F3B8;
	Fri, 24 Apr 2026 08:04:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j65xhbmC";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 712E5890BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 00:49:42 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12dbd0f7ecaso4797248c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776991782; x=1777596582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2TqsQ3VTtmFOdJXnJ7xYfxOi+4kprx1dikYuBadGme8=;
 b=j65xhbmCIzKvyfPvNrRqDdzLAaar7M1tkDgOSkE8rdhM9RZO4O+4i/7z/GhL+Ww+Tm
 MpqHDpyKsslhms4G26K+wgfLjO+EJwrBQaMRcjTHCa49KiVRPmQ/oJl5O9Y+0mK3KoC4
 6c5LlpZ6whqutqvQzkMyuXnuEtY0E0uDT5YML4yA9rOiS+ry3dVe5x6H/Jy6zRlQO+vO
 W9TYhAzhDIn0aI9tT16uSUNUCm1ZX2QTTkQTbfdOTrE01A/J13CzDrsn4qj6JozuyLyl
 Nws7tsyZGpWX4xTMAjppMkKG98UIX3AfadhnULbhBr34Wlii8YZc66ziakUgsKAIHr34
 DGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776991782; x=1777596582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TqsQ3VTtmFOdJXnJ7xYfxOi+4kprx1dikYuBadGme8=;
 b=AlELK0gdGJeY+ZRcAIHJsIdwhGgVWbP1hKLoCkmAwfWKFqYW0/72URZGDhwE/p9BZV
 wmClJDwhPPqP4YsQdMQDJHWsVEEK8JncDPM62MHnLZtEGiLwctsYDoA/j4lbIzHlSIDK
 OR+NedSDPgN3pcsNsimPsGe5r9iqGqWKtKiwjs8zvF6JTlFjCF06vxqU6fVqFp1xu3op
 Or+S6UhDtMaFylz65Bfm0RFK7jfEK5WS0qec53ivjCcSp3UvZ35xp4LJP1XTG3VGikQE
 Bj9di4vQ7t8gKqElolrTuUiI91qT2XrNh/tLPZPvREzgSasVV+YB2BIbsyMr766oSMao
 3YBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vZe9KvHQYwsMoYx8BSYPjYNYpGUIaIx1cB6z6U8krjxDRLSpNKBr9PGqrs3dU3NDUxH6YDFm1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLDITg70E//APBkxQDz7JXEEn90J+GIRjlvpx6apkNP6/Aswfj
 Tbg/uRn9M+sEtqjbnC12aYOfRbUtiliJ/YUVZ1MRiY1epI3ob03OvE4J
X-Gm-Gg: AeBDieuQofzUz2ONz3OA94YNQUFTUnbEBIBg6a1uuwLwViLNlAUh+25bispN1Xygmp5
 OeaHEaDOhHwNgUO8pY1DroDvIQOx4VMRGr0Vzmt+Thgn6nvU01JkwipWXmYwLsPcPQ7tOhcNwb9
 XF8Ws+kkJvNYPP5W5ddIq31Vug8nxcQaOqSTGERm7VnQEmAsx2tdbqZoQEXZUaeCOyMGhtUNf5V
 lIgvQDLWziT1BTvcG2zDDTOpBw1IQ5+pjmML91fm5/P1S74JxtO4zcANj7zkkfBxiKbQjtPZ9Bi
 m8AAk+xNyupCq2Cwm2ib4wxom6HXRtusJiw9ks8ITlaCXVyexxI5Kph/XntTAayAPQvnuMjA4mr
 /wt2aq66Mz+ERu98G4kWnjsUSTGRFpPKJUqTT1/TyRDPZziAds30dSHOA9BDRGzTXIivYELA0pe
 FXN73nALEhER0HuVHVvbUYZVBLmBXYIOyYe5X85A==
X-Received: by 2002:a05:7022:68d:b0:123:34e8:aec2 with SMTP id
 a92af1059eb24-12c73f68419mr15738793c88.1.1776991781564; 
 Thu, 23 Apr 2026 17:49:41 -0700 (PDT)
Received: from osabio.. ([2804:14c:498:1391:e297:f15e:34f:a801])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a185a8sm30930634c88.9.2026.04.23.17.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 17:49:40 -0700 (PDT)
From: Gabriel Almeida <gabrielsousa230@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, gabrielsousa230@gmail.com
Subject: [PATCH v3 1/2] drm/amdgpu: move program_aspm to amdgpu_nbio
Date: Thu, 23 Apr 2026 21:49:09 -0300
Message-ID: <20260424004910.21003-1-gabrielsousa230@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 08:04:49 +0000
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

The program_aspm helper is duplicated across multiple files with
identical logic.

Move it to amdgpu_nbio.c as amdgpu_nbio_program_aspm and update
all users accordingly.

Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
---
v3:
- split from previous combined patch

v2:
- move program_aspm to amdgpu_nbio.c
- drop amdgpu_common

 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/nv.c          | 12 +-----------
 drivers/gpu/drm/amd/amdgpu/soc15.c       | 11 +----------
 drivers/gpu/drm/amd/amdgpu/soc21.c       | 11 +----------
 5 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index a97426583..e4c8e9872 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -84,3 +84,13 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
 	amdgpu_ras_block_late_fini(adev, ras_block);
 	return r;
 }
+
+
+void amdgpu_nbio_program_aspm(struct amdgpu_device *adev)
+{
+	if (!amdgpu_device_should_use_aspm(adev))
+		return;
+
+	if (adev->nbio.funcs->program_aspm)
+		adev->nbio.funcs->program_aspm(adev);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index b528de6a0..a61f3a6e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -121,4 +121,6 @@ u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev);
 
 bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev);
 
+void amdgpu_nbio_program_aspm(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7ce1a1b95..030d80664 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -511,16 +511,6 @@ static int nv_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 	return 0;
 }
 
-static void nv_program_aspm(struct amdgpu_device *adev)
-{
-	if (!amdgpu_device_should_use_aspm(adev))
-		return;
-
-	if (adev->nbio.funcs->program_aspm)
-		adev->nbio.funcs->program_aspm(adev);
-
-}
-
 const struct amdgpu_ip_block_version nv_common_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
 	.major = 1,
@@ -984,7 +974,7 @@ static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
 		adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev);
 
 	/* enable aspm */
-	nv_program_aspm(adev);
+	amdgpu_nbio_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
 	/* remap HDP registers to a hole in mmio space,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index b456e4541..27bcbbae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -695,15 +695,6 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
 	return 0;
 }
 
-static void soc15_program_aspm(struct amdgpu_device *adev)
-{
-	if (!amdgpu_device_should_use_aspm(adev))
-		return;
-
-	if (adev->nbio.funcs->program_aspm)
-		adev->nbio.funcs->program_aspm(adev);
-}
-
 const struct amdgpu_ip_block_version vega10_common_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
@@ -1284,7 +1275,7 @@ static int soc15_common_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	/* enable aspm */
-	soc15_program_aspm(adev);
+	amdgpu_nbio_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
 	/* remap HDP registers to a hole in mmio space,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index fbd1d97f3..7e4353d0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -470,15 +470,6 @@ static int soc21_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
 	return 0;
 }
 
-static void soc21_program_aspm(struct amdgpu_device *adev)
-{
-	if (!amdgpu_device_should_use_aspm(adev))
-		return;
-
-	if (adev->nbio.funcs->program_aspm)
-		adev->nbio.funcs->program_aspm(adev);
-}
-
 const struct amdgpu_ip_block_version soc21_common_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
 	.major = 1,
@@ -925,7 +916,7 @@ static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	/* enable aspm */
-	soc21_program_aspm(adev);
+	amdgpu_nbio_program_aspm(adev);
 	/* setup nbio registers */
 	adev->nbio.funcs->init_registers(adev);
 	/* remap HDP registers to a hole in mmio space,
-- 
2.43.0

