Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668CACCD190
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B29910E482;
	Mon, 13 Oct 2025 14:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G4j2mli7";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0255E10E483
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:35:16 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b3c2c748bc8so615145466b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760366115; x=1760970915; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jwl6XaBMnrWtOkCeylltwJV5yddo3L+rehYMfN8Q8HY=;
 b=G4j2mli7dZrWjTp4xQvQ7d2M/v6OWPjqYH3Ue/pQ5VSc8+H/nxbld2i0AKkGEpOEeK
 s/R2jbKBoSnnB1s0napT+R4HokTHd7Kckc6ngAdqu1pildbTYuO6fyV0aT3U52AsFenT
 jgO7DSssRRp9hF4cIXE/DlaTMeGQ1qNsqObEiKyI++Q35z4tQmG9qRCbBgb4uOLLZhZB
 631IUoaHvRhO7ufhF2e+zIr3kcZ7GUJMh6XtVDfFHI0zNZgl0Loa33o/C2OG7nK+Tgva
 bN385XUiD37vNNSJ1WGJWQjY8mgRpw+paB0JxspEWCZMg4m1wIes8uJa+faFpOKvsNtt
 3J4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366115; x=1760970915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jwl6XaBMnrWtOkCeylltwJV5yddo3L+rehYMfN8Q8HY=;
 b=l5bEDkBI7lO/TX7FTjQmWEc6y/bg89rfZoAp+yOBgXUjsk/vs4wsbun1iskwcsunSU
 ZgSIIXcfqBbAJFBl7TPWcYDjFKg3w/eQF/wS4NvNOo9sC3Dr8lNfrHt27EVVdX75KBQe
 lc/KucK85Hyd/HAU17knLUVN40jWZ+9eAMqBEcdCsIKj+KgpE/xgDv7QNjYgEJGebWRw
 9l3qjwY0SFVUYTUEKhwNjP40QfhU08yh3CYIOg36ZRxVNpUbg1Rq7XzLPQFSw7H/fo7I
 wycIshu3QcXEQfMh/gT/64FP/bW3SuzPIZOgogMRqMEgsmYSIccP74hWDy8pa2MbRCPF
 4G1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXioE+Xnoz56TuTpvJ4xyO6TFu3FEqbkx585fTw35gkuTsxSBITmNtsR9VyjuUbQtZK1vJDcmLc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFslyFbM8nWH82gaarNLNj14Fi0jtlj1HhCgmrMQTFsDDfcn3T
 AalB7mIxotUqGYR3TaFnbt84zGgD+kuirwbzPetRlVoeZhdDVx4R6zlA
X-Gm-Gg: ASbGncsqyOsfeSmgjqs0KL7LBHL+UNijFbfD4LpPGPeC38MUiYR2aZsXfDSpQT24ByK
 ZRNfavXG6GuM6+0RnkYF0MMr0t9GgcFLXVm5ZiXPPWIiicCZR5zPyNZqzLODz/VBba532MGqJFS
 bwfajI41qwTjZ87cQUyLEWqXnR0iqqJqSyCE4byUVhfR5JgXutcn9bKkyIDwDaz2FKpTtOawORG
 8sFpFBFXhNQSydS9GSS2BDEMtTO6gjfAowTR/oW0mbw2au8WAYjb63l8Vew2MN90Bdk39CKfiT9
 T8+qoBba/fI2PwWvMn/q6jFugEo2t2s7VgDfwcmCmk0vq6Z4V8QGzZktN9deAXAMVhbWuCFGKtO
 +yQ1R/fTC0LgBmyP26fPLdM0/GpcPJoS0QGujomanusxj1yDeQk3Z0TY=
X-Google-Smtp-Source: AGHT+IHNw71CXQOpB2p7JUhDHo0Due1lg1gSXVJ7u4nJoIdZ2N7vLWMyij3q2B64/uzbtZ0jMMKMwA==
X-Received: by 2002:a17:907:da9:b0:b3b:ff00:5d4 with SMTP id
 a640c23a62f3a-b50aa586a25mr2177321966b.5.1760366115362; 
 Mon, 13 Oct 2025 07:35:15 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151b:dc00:15d1:ebc5:76e6:730f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm8942037a12.39.2025.10.13.07.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:35:15 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/15] drm/amdgpu: independence for the amdgpu_userq__fence!
Date: Mon, 13 Oct 2025 15:48:42 +0200
Message-ID: <20251013143502.1655-16-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013143502.1655-1-christian.koenig@amd.com>
References: <20251013143502.1655-1-christian.koenig@amd.com>
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

This should allow amdgpu_userq_fences to outlive the amdgpu module.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +----
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 54 ++++---------------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  8 ---
 3 files changed, 11 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b4c41b19cb88..808a5907a325 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3136,11 +3136,7 @@ static int __init amdgpu_init(void)
 
 	r = amdgpu_sync_init();
 	if (r)
-		goto error_sync;
-
-	r = amdgpu_userq_fence_slab_init();
-	if (r)
-		goto error_fence;
+		return r;
 
 	DRM_INFO("amdgpu kernel modesetting enabled.\n");
 	amdgpu_register_atpx_handler();
@@ -3157,12 +3153,6 @@ static int __init amdgpu_init(void)
 
 	/* let modprobe override vga console setting */
 	return pci_register_driver(&amdgpu_kms_pci_driver);
-
-error_fence:
-	amdgpu_sync_fini();
-
-error_sync:
-	return r;
 }
 
 static void __exit amdgpu_exit(void)
@@ -3172,7 +3162,6 @@ static void __exit amdgpu_exit(void)
 	amdgpu_unregister_atpx_handler();
 	amdgpu_acpi_release();
 	amdgpu_sync_fini();
-	amdgpu_userq_fence_slab_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 761bad98da3e..9e0d558c1e4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -33,26 +33,6 @@
 #include "amdgpu_userq_fence.h"
 
 static const struct dma_fence_ops amdgpu_userq_fence_ops;
-static struct kmem_cache *amdgpu_userq_fence_slab;
-
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
 
 static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
 {
@@ -226,7 +206,7 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
 
 static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
 {
-	*userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
+	*userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
 	return *userq_fence ? 0 : -ENOMEM;
 }
 
@@ -242,12 +222,11 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	if (!fence_drv)
 		return -EINVAL;
 
-	spin_lock_init(&userq_fence->lock);
 	INIT_LIST_HEAD(&userq_fence->link);
 	fence = &userq_fence->base;
 	userq_fence->fence_drv = fence_drv;
 
-	dma_fence_init64(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
+	dma_fence_init64(fence, &amdgpu_userq_fence_ops, NULL,
 			 fence_drv->context, seq);
 
 	amdgpu_userq_fence_driver_get(fence_drv);
@@ -317,35 +296,22 @@ static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
 	rptr = amdgpu_userq_fence_read(fence_drv);
 	wptr = fence->base.seqno;
 
-	if (rptr >= wptr)
+	if (rptr >= wptr) {
+		amdgpu_userq_fence_driver_put(fence->fence_drv);
+		fence->fence_drv = NULL;
+
+		kvfree(fence->fence_drv_array);
+		fence->fence_drv_array = NULL;
 		return true;
+	}
 
 	return false;
 }
 
-static void amdgpu_userq_fence_free(struct rcu_head *rcu)
-{
-	struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
-	struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
-	struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
-
-	/* Release the fence driver reference */
-	amdgpu_userq_fence_driver_put(fence_drv);
-
-	kvfree(userq_fence->fence_drv_array);
-	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
-}
-
-static void amdgpu_userq_fence_release(struct dma_fence *f)
-{
-	call_rcu(&f->rcu, amdgpu_userq_fence_free);
-}
-
 static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 	.get_driver_name = amdgpu_userq_fence_get_driver_name,
 	.get_timeline_name = amdgpu_userq_fence_get_timeline_name,
 	.signaled = amdgpu_userq_fence_signaled,
-	.release = amdgpu_userq_fence_release,
 };
 
 /**
@@ -558,7 +524,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
 	if (r) {
 		mutex_unlock(&userq_mgr->userq_mutex);
-		kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
+		kfree(userq_fence);
 		goto put_gobj_write;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index d76add2afc77..6f04782f3ea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -31,11 +31,6 @@
 
 struct amdgpu_userq_fence {
 	struct dma_fence base;
-	/*
-	 * This lock is necessary to synchronize the
-	 * userqueue dma fence operations.
-	 */
-	spinlock_t lock;
 	struct list_head link;
 	unsigned long fence_drv_array_count;
 	struct amdgpu_userq_fence_driver *fence_drv;
@@ -58,9 +53,6 @@ struct amdgpu_userq_fence_driver {
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

