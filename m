Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287CDFF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 18:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A805D10E8B8;
	Mon, 27 Apr 2026 18:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OSGPYmde";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D47B10E8B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 18:27:26 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so90437765e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777314445; x=1777919245; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AGXRhlWXwUTArAX2IbHc1SZiTU1nrW9t0bpXvIWFEDU=;
 b=OSGPYmde/9CdZgXkDW/fgq/OF77Ih8VNPYm/POht7RZ1BySwQGyKs0/3En/znB4TRP
 D35z9C9r7rDvU2IO/u65oyxg0O+VSTI8UY2TsJuJMxH8r57kBXs/+umcxRQaCiaHVONs
 7DbJ4z+Z0JuJcmDS1AoKuKuavLYhFmqY99A0VZguKdK6fJY4VlCPkAvlMguXf1BRSBw3
 WAETZbvkQAZtMOxYRkKfD+oqUTOmw3Bz0VSCNb5Qi0e0+ijJOy94ukuZezW9uUQeYOl7
 S/W3WC+P445qY/IKHIGDRW/BlAdsn5CwXuBWOB+BUZoyUmRjSdSbJYTv1+iPpJEg6RCM
 xpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777314445; x=1777919245;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AGXRhlWXwUTArAX2IbHc1SZiTU1nrW9t0bpXvIWFEDU=;
 b=K9keGz+O4znDM/cuShia9IAzWf/0qsOqnPTbnq8aTRybz9MM1sRRi4EQVHej27Ks4K
 qhnldGE7/MQSorZXq2TTdA8uRlybA+8nvH4+mlujg0Y/RqX3BzKMtLW4jnz5MHMrSpkQ
 FJDgOTeS70T26b1Vp00D6a5wzoM52Xq3UyiD9XG2oeV8a+q15QEpxRuBA6JS+8Z/fJxe
 VizfNKLE6FBuMsfGne+9DwB+ht5xb/0LVgudB1xX0qlUeAeY1JH65Gx7hlrgYblBJm6n
 /jB2hLepdpSMU7m3yylUec2nnHApeSxwa5lxjNBTw+57D6zhM8h//VBZn1qwtioCfaO1
 d16w==
X-Gm-Message-State: AOJu0YwaPoNrARbLwJNAZVtvBIjc6lqBIrZlTscOensMq8lVWFYXq1kd
 +FT+d7414kOLNM9XKoVrLLUiQpUbMNC2ZpSF3261diNRMz5Irah7GBVSMNym23b1
X-Gm-Gg: AeBDiesGY2KTaiIHaTJ2TYuq9g+FiIQCCmKRoEVLFjZlD8IIXNf92dAPW6yDjnwKpVt
 8GhqhTUK1whNmOVmnNR3yW10rdlqf69ViQRDzWzmWdauRbJUH/MzX4rTXPEKsgQoNKBk4oFZqCS
 1uVcmE3nkKXZ2bRRLwhCavkxK2tsPKm88paJ/871mORPQr6Cv6O0eN8tq7vixs73+7KmgPHOA6z
 iHoABs86ZWyP68bOOGXEeznnO0Ng6KXPNPIr/xHqAliY6ZNTHMSbNEViegDILKLOF3aQTLKCwmq
 MMK6X2jxvJxTqJongMroPJ6/YKkUdgJMsY1COWHT4BR5xHu9wexaIXp0zGLITuYXfupti1WecyG
 d9Jj5RyYldS0J8Hrj+E5riTXZRqEWkS7d8b/t1XLjzHXgwSs/PMkuQCP54ekDYjt2iAAHV5gf9V
 bx7nzn35+YETSTHR12cC5P8+BNfZMDID/7tt4xbQ2E37bBZg==
X-Received: by 2002:a05:600c:c4a5:b0:48a:52d4:888c with SMTP id
 5b1f17b1804b1-48a76f4d4d4mr6947455e9.3.1777314444686; 
 Mon, 27 Apr 2026 11:27:24 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:153b:d200:96aa:46be:4d7:72d2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773af5c5sm6046165e9.5.2026.04.27.11.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 11:27:24 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amdgpu: nuke amdgpu_userq_fence_slab
Date: Mon, 27 Apr 2026 20:27:16 +0200
Message-ID: <20260427182723.1715-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

As preparation for independent fences remove the extra slab, kmalloc
should do just fine.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 17 ++++-------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 28 +++----------------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 --
 3 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8f66f197f645..2b268cdf076b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3162,11 +3162,7 @@ static int __init amdgpu_init(void)
 
 	r = amdgpu_sync_init();
 	if (r)
-		goto error_sync;
-
-	r = amdgpu_userq_fence_slab_init();
-	if (r)
-		goto error_fence;
+		return r;
 
 	amdgpu_register_atpx_handler();
 	amdgpu_acpi_detect();
@@ -3174,7 +3170,7 @@ static int __init amdgpu_init(void)
 	/* Ignore KFD init failures when CONFIG_HSA_AMD is not set. */
 	r = amdgpu_amdkfd_init();
 	if (r && r != -ENOENT)
-		goto error_fence;
+		goto error_fini_sync;
 
 	if (amdgpu_pp_feature_mask & PP_OVERDRIVE_MASK) {
 		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
@@ -3185,11 +3181,9 @@ static int __init amdgpu_init(void)
 	/* let modprobe override vga console setting */
 	return pci_register_driver(&amdgpu_kms_pci_driver);
 
-error_fence:
-	amdgpu_sync_fini();
-
-error_sync:
-	return r;
+error_fini_sync:
+       amdgpu_sync_fini();
+       return r;
 }
 
 static void __exit amdgpu_exit(void)
@@ -3199,7 +3193,6 @@ static void __exit amdgpu_exit(void)
 	amdgpu_unregister_atpx_handler();
 	amdgpu_acpi_release();
 	amdgpu_sync_fini();
-	amdgpu_userq_fence_slab_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a58342c2ac44..f3d0595e3e61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -32,29 +32,9 @@
 #include "amdgpu.h"
 #include "amdgpu_userq_fence.h"
 
-static const struct dma_fence_ops amdgpu_userq_fence_ops;
-static struct kmem_cache *amdgpu_userq_fence_slab;
-
 #define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
 
-int amdgpu_userq_fence_slab_init(void)
-{
-	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
-						    sizeof(struct amdgpu_userq_fence),
-						    0,
-						    SLAB_HWCACHE_ALIGN,
-						    NULL);
-	if (!amdgpu_userq_fence_slab)
-		return -ENOMEM;
-
-	return 0;
-}
-
-void amdgpu_userq_fence_slab_fini(void)
-{
-	rcu_barrier();
-	kmem_cache_destroy(amdgpu_userq_fence_slab);
-}
+static const struct dma_fence_ops amdgpu_userq_fence_ops;
 
 static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
 {
@@ -231,7 +211,7 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
 
 static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
 {
-	*userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
+	*userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
 	return *userq_fence ? 0 : -ENOMEM;
 }
 
@@ -343,7 +323,7 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
 	amdgpu_userq_fence_driver_put(fence_drv);
 
 	kvfree(userq_fence->fence_drv_array);
-	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
+	kfree(userq_fence);
 }
 
 static void amdgpu_userq_fence_release(struct dma_fence *f)
@@ -546,7 +526,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
 	if (r) {
 		mutex_unlock(&userq_mgr->userq_mutex);
-		kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
+		kfree(userq_fence);
 		goto put_gobj_write;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index d56246ad8c26..d355a0eecc07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -58,9 +58,6 @@ struct amdgpu_userq_fence_driver {
 	char timeline_name[TASK_COMM_LEN];
 };
 
-int amdgpu_userq_fence_slab_init(void);
-void amdgpu_userq_fence_slab_fini(void);
-
 void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
-- 
2.43.0

