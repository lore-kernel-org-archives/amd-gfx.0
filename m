Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B013C27C5F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 09:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD90210E3D4;
	Mon, 10 Jun 2024 09:26:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PiskgUOW";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A237810E3BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 09:26:14 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-35f090093d8so1791270f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718011573; x=1718616373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=707xc1FGGs8U0S0rou6yZiJmXoSuOVw/k/dGbR2JedI=;
 b=PiskgUOWUC0JcU1wmKHildVJL4KnPpIW6CqvVQViaz4Sj2ezgES1xzZorOII3PH3N9
 xs7m8tMxizl2Yrj0r6oLDOf8KctSIzqK72kEDHdNffJfbrfDXBBpZsuGo4ZM5WYmb7DC
 HpF3k4RNWMp+OfHPp4y0tVJGRD7iuFO5n0Dxk9dXlsfhEfuk9ZoCsjOnLypCrcmFRoox
 X2HMNJIU7iKEJywmiDYa+q4whHRKxkxfOJdnL2f1OkJMSxjN8JsX89FSmIcv/VOU8n+1
 6m543LrLHor34ytBP9f0touz7gCWH2qXTV2AEdaq2c6pvwp5AE7M5lZxqE9uq2q+Recy
 ptTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718011573; x=1718616373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=707xc1FGGs8U0S0rou6yZiJmXoSuOVw/k/dGbR2JedI=;
 b=R1D3HMtubPDU9RcVzcwEoheX+C7wrsyIri/iUEUdx/HPzMWJ/zdMWpj+OGKv2CCOre
 cu6uJTL2RMd1iEAq+tKyAiFaCLGoZQ5JDwaMAV7R6ZZyCZ3kxM6b1F8Nn07/de69Igsg
 1rj5xxn2yHUn62Jgl9txZV22JMcICGUIZD68gEACT6T5DNvIzPekRHUDNPIbQD0vcni3
 w/MLWC0GnQ/4IdV5oD0EdEQ3moLaAfnuiSU2C90HaLM9jxq63xZFOBJ1v80byiwPhb48
 8BvwLwDWrYR5F8zs04VwrsQpKNRVvpuvMwcn/SnzG3/ttszF8id0H9WglwUHW2xn1raz
 Eufg==
X-Gm-Message-State: AOJu0YwKJlfS6LdEWDCzXzx5xKORVadDb3GVhpG7ObE7q56AMEAZD6gQ
 ybYAcdbFQRQ95CHvranx+DfGoAP0XKD0OK0LF2NsPWlHwqI0NO6G
X-Google-Smtp-Source: AGHT+IGS9j5gsyx5eCOrTR84n+YHrmCqrWMqfdaGmUtMOjqkWjjbiiW5/DXV1GuLrARLEWTaBTq0hg==
X-Received: by 2002:a5d:618d:0:b0:35f:650:e90e with SMTP id
 ffacd0b85a97d-35f0650eb8emr6430634f8f.49.1718011572577; 
 Mon, 10 Jun 2024 02:26:12 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f9:7000:4916:a8ec:dd12:5894])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f2169fc45sm3075827f8f.10.2024.06.10.02.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:26:12 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: pierre-eric.pelloux-prayer@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/9] drm/amdgpu: explicitely set the
 AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag
Date: Mon, 10 Jun 2024 11:26:03 +0200
Message-Id: <20240610092611.2894-1-christian.koenig@amd.com>
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
index cfec85563bc6..7ef518d888dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -233,6 +233,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 	}
 
 	if (!adev->enable_virtual_display) {
+		new_abo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 		r = amdgpu_bo_pin(new_abo,
 				  amdgpu_display_supported_domains(adev, new_abo->flags));
 		if (unlikely(r != 0)) {
@@ -1739,6 +1740,7 @@ int amdgpu_display_resume_helper(struct amdgpu_device *adev)
 
 			r = amdgpu_bo_reserve(aobj, true);
 			if (r == 0) {
+				aobj->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 				r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 				if (r != 0)
 					dev_err(adev->dev, "Failed to pin cursor BO (%d)\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1eadcad1856d..f5a33178651e 100644
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
index e30eecd02ae1..2ce99ab63e4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -335,6 +335,7 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
 	else
 		domain = AMDGPU_GEM_DOMAIN_VRAM;
 
+	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	r = amdgpu_bo_pin(rbo, domain);
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index b44fce44c066..ff99475f7225 100644
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
index 80b2e7f79acf..bae0d5ea4a4b 100644
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
index db20012600f5..ac4271a84cc8 100644
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
index 5b56100ec902..29bbf083c5d2 100644
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
index b339642b86c0..81e87c079624 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -890,6 +890,7 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
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

