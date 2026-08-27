Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A76AC61DC2
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 12:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2939E10F02A;
	Thu, 27 Aug 2026 12:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zp/wnP7t";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F1F10F018
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 12:49:21 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-499d1ab3f9dso8428615e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787834960; x=1788439760; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8EdCrSCj77M32Pu3SEBs0Nl7Jw7mm9Bq+OEkpl3c1Aw=;
 b=Zp/wnP7tdp26eTbxQB6mPgt+vTWkS5X4kk3FiJCgplHEg5dBTcx+Fm6jlljox9BdO6
 Vd0GsprV5GSs9J5J63z8jEhIrEqXSI2F/3wQqRiZqz8uZ/TBJ8R5J4ajL6ONp+PXrB8+
 vUvLZzmo1uXte2EXzrs49UYZO6fAQuBx+e0213qatT/sPCpdRfpq8NHKFcP0ZL2poGqe
 XPKWsXLb52JnOEHcIyykecnXLIHRS0ykvgzZ6YgYfKSc8q89LQy+ma4V22pX3V4KJKGh
 R/wnRz6b868Rf6GX4EQ5Xhm5qcjCyH+bmMhDFWYSnf5mP+3IAe5oyRfYeRkBJqBrwd/o
 SIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834960; x=1788439760;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8EdCrSCj77M32Pu3SEBs0Nl7Jw7mm9Bq+OEkpl3c1Aw=;
 b=TA9dMqDgMAtoXRx5OVFl2xyw/g3dsWoRl6XKCGKnV4dKBHV12pRbXF7+ZJsO139MDu
 9xOVYEjhKSQ6tgz8+LwbpGQ6D2RPxPBqPH+cnvlI9oDC/nyT1Fy2fuf4uiZLnOZ/tSvm
 j0m0ZQkG9ZXP7vat2u9+PkrLaVvzt/qYZ+GzlaMskNdKBSi8TZZNVNST75EH4LDQqIuP
 vM86KJQjN3rq2DtPcG2qMasARvuQLvBm35uUssJzRwxGFP5JjXMZEBwqcJqQxK1x8qgZ
 IvVTYl1ySpjTNKtRwghWDSb/QclyjBKNlltBeR8KKH5h7RGSfcPXshnHYiUplVOcdNZB
 TB5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI49iM+QjlCkdw1k5DgueenibZ1YwEUVK255jnMEWmx9lXJOizbDlcKil5fJsVGA5uxwcZFdwz@lists.freedesktop.org
X-Gm-Message-State: AFuF++ls1ETKwoFeKS1h+OVgavq3K0m7/4XmVpCQqXSAzrD2RSCLEJWn
 KMVKSFhGvycPKYTctHm8sMJEUtZuRN3AkagrSZh5vb2G78OeqMg2vm5c
X-Gm-Gg: AR+sD10MbntBhF+boYe2azMRrZCeesaomTzU1LyEW3ReVf+muKJuoDpwQDQAdWgKGf0
 CKo1Q2XKSv1LeFn+yi1OnTruUCqibSSnV+q53ERpVHcpaTkPDQO3I8JtDcKAKvN+tsfw+UKOPC7
 qx9kC0McxGoNqVQo40TL67h1fw6J7k+IW+35l6TO6yOjVhxBQD9fAP1loKCl8FA0YXLSkeI/hVb
 Jh8D1sIHr3FZ+A14zRbv+/G4aCaZt1nJub+/TNvwe2Dv8SGk/nUFfLxy/4KaC8wDxuZNFfhTaam
 QHWNmcNpQX5fwdwQtxt4NSDdMFlNu2F2Oq0yK2sq7RZVBBDPYY7RKG4D5N7FeVUjeKyZiMeYNqq
 gV+580h3A/WxbqHvO2ogeCT63LH9rZUPmRG7004lWPg05oO33u8waLowTpg6nwkeFw/843UCv9y
 lq4DH8AvxBJvpKvWkNIIlz3HDEHsWK2bLF325OxGvgmpQCz/SqX4oyhW425wshonfzhpcf5dE/2
 w==
X-Received: by 2002:a05:600c:3e0b:b0:499:adb5:e7b2 with SMTP id
 5b1f17b1804b1-499dc717dcbmr214934505e9.11.1787834959912; 
 Thu, 27 Aug 2026 05:49:19 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1524:4300:a4b8:720e:f64f:4778])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b465226d8sm52089985e9.0.2026.08.27.05.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:49:19 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/10] drm/mode_config: Use dma_resv_alloc for lockdep
 annotation
Date: Thu, 27 Aug 2026 14:38:54 +0200
Message-ID: <20260827124910.2245-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827124910.2245-1-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace the stack-allocated dma_resv in the lockdep annotation code
with a dynamically allocated one using dma_resv_alloc(). This aligns
with the move away from embedded dma_resv structures and towards
reference-counted dynamic allocation.

The lockdep annotation block in drmm_mode_config_init() is used to
establish lock ordering dependencies between modeset locks and dma_resv
locks. Since this only runs when CONFIG_LOCKDEP is enabled and the resv
is immediately freed after use, the change is straightforward.

If allocation fails, return -ENOMEM early. The existing dma_resv_put()
at the end of the block properly handles the cleanup.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/gpu/drm/drm_mode_config.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 312d5e9675f0..de424b755c62 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -658,10 +658,12 @@ int drmm_mode_config_init(struct drm_device *dev)
 	if (IS_ENABLED(CONFIG_LOCKDEP)) {
 		struct drm_modeset_acquire_ctx modeset_ctx;
 		struct ww_acquire_ctx resv_ctx;
-		struct dma_resv resv;
+		struct dma_resv *resv;
 		int ret;
 
-		dma_resv_init(&resv);
+		resv = dma_resv_alloc();
+		if (!resv)
+			return -ENOMEM;
 
 		drm_modeset_acquire_init(&modeset_ctx, 0);
 		ret = drm_modeset_lock(&dev->mode_config.connection_mutex,
@@ -672,16 +674,16 @@ int drmm_mode_config_init(struct drm_device *dev)
 		might_fault();
 
 		ww_acquire_init(&resv_ctx, &reservation_ww_class);
-		ret = dma_resv_lock(&resv, &resv_ctx);
+		ret = dma_resv_lock(resv, &resv_ctx);
 		if (ret == -EDEADLK)
-			dma_resv_lock_slow(&resv, &resv_ctx);
+			dma_resv_lock_slow(resv, &resv_ctx);
 
-		dma_resv_unlock(&resv);
+		dma_resv_unlock(resv);
 		ww_acquire_fini(&resv_ctx);
 
 		drm_modeset_drop_locks(&modeset_ctx);
 		drm_modeset_acquire_fini(&modeset_ctx);
-		dma_resv_put(&resv);
+		dma_resv_put(resv);
 	}
 
 	return drmm_add_action_or_reset(dev, drm_mode_config_init_release,
-- 
2.43.0

