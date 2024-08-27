Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3944C54734
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 14:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6333B10E30D;
	Tue, 27 Aug 2024 14:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GYt9bLQ9";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C1710E30D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 14:12:15 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-a86e5e9ff05so112807066b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724767934; x=1725372734; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xh+e7yYTdaQhcBwR8wYRTmm0I+/ZbobV9MMOb3mAojs=;
 b=GYt9bLQ98ahUN7TVsaQdZfSE5SuR/Rmbs2WEwCGUt3g/lgkc3mqFXWFmn/gf45Ycv0
 deeha93cLe58fWY0yJkeIJ+Bf4jmb3ZdrLRxHhSCxMMLjfZFSOKQ/bdPCeWoPY9DD5WZ
 qjFqunOWKWWSQ618Y+WbOKgafNUJoop0EXsJywIBCpuWRo5iU5aYszKzh5Nnoh6nuyPU
 rahQk8A0qvUt9gCIJJdiQH6Yxmnf0Pnn0tJBjMCC1HCDSIwgCawOkeh6PRsU4oiUkdrr
 cCFhS30j14/MadULoB3eGzBfJMh4LxTMTDvFQk+Q7p3WuMSoGAmIwYBCEEm2W1WWQmSH
 W+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724767934; x=1725372734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xh+e7yYTdaQhcBwR8wYRTmm0I+/ZbobV9MMOb3mAojs=;
 b=FYcISUehMEiYCKOcQiGiSlq9RroBR4GiPmmk9u01RnGj33fZC3vJqEbpnesep0rfVQ
 jbizxrqXdenXs1x8pmrU9JUrLZ/Xm8Q7FmJXiz6PJSSMSsS3AQMs0IhRsfIrpbjt1Vf7
 yLK61JGtV3+C6N53CxW9jLblWZSYJoh4ed14PLZKj3aZQBFPBi7AM8KYXw40yI8Eew/W
 b/Rp2oO2WyBbTbMDlEqhiZGy6EBqpEvfVBlKX37LkZac+qAMJawhsvaTYvbYlqIiNS4d
 d8ait4aLHp2rDZ8iiAy4tvRpo0q2odjeFokX4Ww4ptUJHhZplc8iKPXAYELd+EWN5kFQ
 lToA==
X-Gm-Message-State: AOJu0Yw20IBqGkbuHAzwGEbu147+Fkwy3rxFzEKwAiuULd14LOJuBw1s
 qoKV9uBH5m7mJw4AaoPPa9QnHnmymeigEfDBPh7ueu9utIgO7JVAvRvIEu0r
X-Google-Smtp-Source: AGHT+IHQvrQc9XoMvE0e92Oxzth2VYTPuOWGXDaRHtwxJJ1/oyBu/K8iUy4G0VYv+ZABEhrdTAoChw==
X-Received: by 2002:a17:907:97ca:b0:a86:8a89:3d6c with SMTP id
 a640c23a62f3a-a86e3d41848mr222944766b.66.1724767933359; 
 Tue, 27 Aug 2024 07:12:13 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15b3:7800:8c1b:1972:54d8:6ca6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e54875e5sm114196866b.5.2024.08.27.07.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 07:12:12 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Lijo.Lazar@amd.com,
	Alexander.Deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: explicitely set the
 AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag
Date: Tue, 27 Aug 2024 16:12:09 +0200
Message-Id: <20240827141211.2411-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

Instead of having that in the amdgpu_bo_pin() function applied for all
pinned BOs.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c             | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c              | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                | 1 +
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                  | 2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c                  | 2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                   | 2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                   | 2 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c    | 1 +
 9 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 092ec11258cd..813520655fd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -233,6 +233,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 	}
 
 	if (!adev->enable_virtual_display) {
+		new_abo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 		r = amdgpu_bo_pin(new_abo,
 				  amdgpu_display_supported_domains(adev, new_abo->flags));
 		if (unlikely(r != 0)) {
@@ -1759,6 +1760,7 @@ int amdgpu_display_resume_helper(struct amdgpu_device *adev)
 
 			r = amdgpu_bo_reserve(aobj, true);
 			if (r == 0) {
+				aobj->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 				r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 				if (r != 0)
 					dev_err(adev->dev, "Failed to pin cursor BO (%d)\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6faeb9e4a572..60ab6ae699bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1003,7 +1003,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
  */
 int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
 {
-	bo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	return amdgpu_bo_pin_restricted(bo, domain, 0, 0);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index fa6928ea9555..56592ab61d16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -342,6 +342,7 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
 	else
 		domain = AMDGPU_GEM_DOMAIN_VRAM;
 
+	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	r = amdgpu_bo_pin(rbo, domain);
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 11d648e688ce..078d37f80ebf 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1881,6 +1881,7 @@ static int dce_v10_0_crtc_do_set_base(struct drm_crtc *crtc,
 		return r;
 
 	if (!atomic) {
+		abo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 		r = amdgpu_bo_pin(abo, AMDGPU_GEM_DOMAIN_VRAM);
 		if (unlikely(r != 0)) {
 			amdgpu_bo_unreserve(abo);
@@ -2401,6 +2402,7 @@ static int dce_v10_0_crtc_cursor_set2(struct drm_crtc *crtc,
 		return ret;
 	}
 
+	aobj->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	ret = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 	amdgpu_bo_unreserve(aobj);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 01536f523032..6f287e921e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -1931,6 +1931,7 @@ static int dce_v11_0_crtc_do_set_base(struct drm_crtc *crtc,
 		return r;
 
 	if (!atomic) {
+		abo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 		r = amdgpu_bo_pin(abo, AMDGPU_GEM_DOMAIN_VRAM);
 		if (unlikely(r != 0)) {
 			amdgpu_bo_unreserve(abo);
@@ -2485,6 +2486,7 @@ static int dce_v11_0_crtc_cursor_set2(struct drm_crtc *crtc,
 		return ret;
 	}
 
+	aobj->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	ret = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 	amdgpu_bo_unreserve(aobj);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 0e5b568a96fc..aff32ae97d03 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1861,6 +1861,7 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
 		return r;
 
 	if (!atomic) {
+		abo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 		r = amdgpu_bo_pin(abo, AMDGPU_GEM_DOMAIN_VRAM);
 		if (unlikely(r != 0)) {
 			amdgpu_bo_unreserve(abo);
@@ -2321,6 +2322,7 @@ static int dce_v6_0_crtc_cursor_set2(struct drm_crtc *crtc,
 		return ret;
 	}
 
+	aobj->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	ret = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 	amdgpu_bo_unreserve(aobj);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 895f050a3e62..3cd27f5b1b34 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1828,6 +1828,7 @@ static int dce_v8_0_crtc_do_set_base(struct drm_crtc *crtc,
 		return r;
 
 	if (!atomic) {
+		abo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 		r = amdgpu_bo_pin(abo, AMDGPU_GEM_DOMAIN_VRAM);
 		if (unlikely(r != 0)) {
 			amdgpu_bo_unreserve(abo);
@@ -2320,6 +2321,7 @@ static int dce_v8_0_crtc_cursor_set2(struct drm_crtc *crtc,
 		return ret;
 	}
 
+	aobj->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	ret = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 	amdgpu_bo_unreserve(aobj);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index a573a6639898..7c4e3f26580d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -961,6 +961,7 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	else
 		domain = AMDGPU_GEM_DOMAIN_VRAM;
 
+	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	r = amdgpu_bo_pin(rbo, domain);
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 08c494a7a21b..0d5fefb0f591 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -114,6 +114,7 @@ static int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector
 
 	domain = amdgpu_display_supported_domains(adev, rbo->flags);
 
+	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	r = amdgpu_bo_pin(rbo, domain);
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
-- 
2.34.1

