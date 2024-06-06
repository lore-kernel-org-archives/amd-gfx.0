Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDB3C25B75
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 08:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E7410E03F;
	Thu,  6 Jun 2024 08:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="abOCGOC3";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4EFF10E03F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 08:47:33 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-35dca73095aso661482f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jun 2024 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717663652; x=1718268452; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=13MLtFKQ2W7RrwVpdWaxauXXaGT+n+FB46xcclpWghM=;
 b=abOCGOC3RsQyoonQCIxPqIXB/coRMbx5sjSPpYQGMeqBHl3wN5fqgSPVZzfgy1ubck
 ERrBxdasy0ZBuj3uAtNBPtvlnY/yFxuaqhpeYfD5NoEQPwV9ZnB/sgYYaxer2Xse05I3
 wtoVdRClGe0+XbYndR1URFA8lqxQSslhn189KtciUzEu1B7xBXG9x3F4avpY1kJU+WVC
 CWV0NPV7pVpTJJCsh/b7DxBzY4pEX9qA6tCYWkLlQ1/M+Q2gOUXaWG8l+6s1EJvDS3d+
 88/5KE2FZknabjNlKlALgDOV9onhndBT71VGOtRldydPRd6TB1ngnxwcnbBWi38HjNzo
 5nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717663652; x=1718268452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=13MLtFKQ2W7RrwVpdWaxauXXaGT+n+FB46xcclpWghM=;
 b=eWJZvegRMF5gsVnPug52s/lVwMumPrBTkY9eBveefJCf8EOlCf7/DMNqtoJmQ6YHWe
 b37DshdUtDnNWi2JT8538RLBn+RZpNaRZCz3g/NHLZ+nY67ScQjLSijCyFDoU+NVMPTs
 bNoYIVft/czgSXvf6n36e2XzSmog9Rsi3k8RSr8UdYWYbzlt7F1f5Bhx4GGgS64k1BHx
 xuKt80VKx6wxjG0yAzQ+asZSm9fX0L3/TBmps3fIWGLho4IKnLhAkwEMghe9MQNZQVxM
 CBpr7U+FdwalKBMU7YiV79P/CB02Xco2F9LH/RN+6GzQRpvWfYbs66xKHUrSZ1iHas75
 QC8w==
X-Gm-Message-State: AOJu0Yxgmkm/sjN/KIJTYKjB++N6Zq3QgQ8WGCPPzMUYhJe8U8SzfVhq
 oz0OOkuclZppk7jEhNfnPyRhIGoKmdM8x69lEHAfHUBHmuVfd5XoEMoKgWAt
X-Google-Smtp-Source: AGHT+IF0Zj8bJ8N+AKypNq9SAQhH+G/jn3eA7/Kf3jWK8VSPn2cXfIeTr5sLrXvwPdnfvVT5VguRzA==
X-Received: by 2002:adf:f7c6:0:b0:347:9bec:9ba3 with SMTP id
 ffacd0b85a97d-35e8ef8ecb2mr3719618f8f.66.1717663651768; 
 Thu, 06 Jun 2024 01:47:31 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15a8:ad00:2659:1fc3:a820:90f4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5fc47ebsm963781f8f.108.2024.06.06.01.47.31
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 01:47:31 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: explicitely set the
 AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag
Date: Thu,  6 Jun 2024 10:47:28 +0200
Message-Id: <20240606084730.96581-1-christian.koenig@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c      | 2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c      | 2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c       | 2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c       | 2 ++
 7 files changed, 11 insertions(+), 1 deletion(-)

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
-- 
2.34.1

