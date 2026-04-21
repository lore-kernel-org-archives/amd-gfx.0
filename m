Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D052BF8FA73
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 12:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5284510E8AB;
	Tue, 21 Apr 2026 12:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OOQUk1gt";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B230210E1D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 12:55:22 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso17684165e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776776121; x=1777380921; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28xQbfybL825edxKg3Mynkw7AayiCObNWD5QVpsTi2I=;
 b=OOQUk1gtvEl7AB+4oIzvw9txbtw5pZqBgxcLz79LVqtdmS1qx/8rWEKtNP1emrXlB2
 sEMuabN1LWOEO+P8O6y5+VFxeFAhVyjMlaE0MNTruMJ73lNYxxtGlsC22mwJ1p6xugt/
 AAzO4tUWJSR6DSXcuIi4pOMyanXXgCbBYwKLAv5Qd5o3umtnbC5JweOPutRcj4Vn1AID
 WJV9neW32BSKiM1+9vWqyrcl+T2jKilmLo4ZU+cBVDqLmGcoFzDvMZFLFLKS979D97DJ
 fs3fR7rCp1bD02h0A7FFA5WbCWn0+wXbwje1RrmKJzFKI7M7isoVu+yuhTyBkK/VIkj3
 21HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776121; x=1777380921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=28xQbfybL825edxKg3Mynkw7AayiCObNWD5QVpsTi2I=;
 b=o2V3eadYgHxzqPWPCz82iZny0cKAcNyDqGhq3NhjO/h/fHRNrIqkeS6Ev6v6ba9KTH
 mkpsCSm1cFxRs8tSLNx6YsQz25ZB5A1iZeLLd0GZAZMDAfKFhCuQG4lBabCdQf2RWEoE
 2Gtzhc7TluYRUVQfXO1GmFOfkRLtrx56083R0KAFwK4I66FCr5vzsB6d8p080cjC+NYj
 aJ7nAwKBPX9QfGLa9J5/X1dkCeMWT+QDxuyfULbsUzEKF7WX8Lct+TGY9Z3wN97IEVyf
 Jb9mDbIZ4OsOBfDD0Wby868VMVGAzfaHAh3/t5+NTplieFv0ENj2uaGJjs3Q6Yhd8ELd
 BEWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fDJnTVHhcZtoA/yZNdJt3CExpym59HDkyJmfGVDDhTTH6xlpPiNJ+1GMVnPbiWGQ86+3bbzal@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyv7cup0mKyQrrapxm2tPLfJHKxcfBaCflkPQoQwfJZEMVk+9i+
 soWvkZTvqGlq9Dw92AYmf6xhyKLzSdcr3t7MqFF6PfY+l78UrK3/oLDN
X-Gm-Gg: AeBDietUUl4stjK5gi5HeKCXJhwi/KWFJxvoNQsjqnFC48iYlwsikvXK+JOFKUpMRdZ
 ZlfvzkCkQs0bfQk3E8CoYPiqv0RICiQzmabpzqTBTGXVsADNLnV47/5MiCjzTA8PdPvpHYS2AZ+
 4eTeEp9gd9bEQVc1XTZ7ofT0hN9wVZdwoZveFmt0Hwcvc01aDBLoCyuasPxjJZJj2bPcdJamS+z
 JS3stchPk/RL2WYmb1M+boB8Lp9P/oNJkoOOWkcGJr7T2kAd6aWiacJLUW8ueZFI/AGfp1CQuws
 ffl6H8/FmniOOlHoiuIdeOr/OaN7zs6CaUnZcwvMmavPgzUdygrvsz1rHuaWOf4SkwdZdOrMIyZ
 lhrTgl/hMsvr1uaAei2X24980lAaJhr+nORDSuaz3F/dDtk4Bv+u3ujFXpptnR3lfUJ/z9Qsmjp
 PzSU2v6aXHnsoDHM/cjo9Yolw0Ew8imuEDjgygrUdx8KSS6tggHfzkrpM7Ag==
X-Received: by 2002:a05:600c:8588:b0:489:2005:b36e with SMTP id
 5b1f17b1804b1-4892005b4e9mr66334675e9.19.1776776120168; 
 Tue, 21 Apr 2026 05:55:20 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15aa:5a00:935c:42ec:dfce:89a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb79ecb9sm154777915e9.8.2026.04.21.05.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:55:19 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Subject: [PATCH 03/11] drm/amdgpu: nuke amdgpu_userq_fence_free
Date: Tue, 21 Apr 2026 14:55:05 +0200
Message-ID: <20260421125513.4545-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421125513.4545-1-christian.koenig@amd.com>
References: <20260421125513.4545-1-christian.koenig@amd.com>
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

As preparation for independent fences remove the function and do all of
it's cleanup directly after signaling.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +--
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 79 +++++++------------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 -
 3 files changed, 31 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c6546a858597..1b15b51dc3f4 100644
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
@@ -3182,12 +3178,6 @@ static int __init amdgpu_init(void)
 
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
@@ -3197,7 +3187,6 @@ static void __exit amdgpu_exit(void)
 	amdgpu_unregister_atpx_handler();
 	amdgpu_acpi_release();
 	amdgpu_sync_fini();
-	amdgpu_userq_fence_slab_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a58342c2ac44..909bdccc2a92 100644
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
@@ -146,12 +126,18 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 }
 
 static void
-amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
+amdgpu_userq_fence_put_fence_drv_refs(struct amdgpu_userq_fence *userq_fence)
 {
 	unsigned long i;
+
 	for (i = 0; i < userq_fence->fence_drv_array_count; i++)
 		amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
 	userq_fence->fence_drv_array_count = 0;
+	kfree(userq_fence->fence_drv_array);
+	userq_fence->fence_drv_array = NULL;
+
+	amdgpu_userq_fence_driver_put(userq_fence->fence_drv);
+	userq_fence->fence_drv = NULL;
 }
 
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
@@ -181,10 +167,11 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 		fence = &userq_fence->base;
 		list_del_init(&userq_fence->link);
 		dma_fence_signal(fence);
-		/* Drop fence_drv_array outside fence_list_lock
+		/*
+		 * Drop fence_drv_array outside fence_list_lock
 		 * to avoid the recursion lock.
 		 */
-		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
+		amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
 		dma_fence_put(fence);
 	}
 
@@ -231,7 +218,7 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
 
 static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
 {
-	*userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
+	*userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
 	return *userq_fence ? 0 : -ENOMEM;
 }
 
@@ -299,7 +286,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
 	if (signaled)
-		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
+		amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
 
 	*f = fence;
 
@@ -333,29 +320,10 @@ static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
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
@@ -546,7 +514,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
 	if (r) {
 		mutex_unlock(&userq_mgr->userq_mutex);
-		kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
+		kfree(userq_fence);
 		goto put_gobj_write;
 	}
 
@@ -871,6 +839,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 	for (i = 0, cnt = 0; i < num_fences; i++) {
 		struct amdgpu_userq_fence_driver *fence_drv;
 		struct amdgpu_userq_fence *userq_fence;
+		unsigned long flags;
 		u32 index;
 
 		userq_fence = to_amdgpu_userq_fence(fences[i]);
@@ -886,7 +855,19 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 			continue;
 		}
 
+		spin_lock_irqsave(userq_fence->base.lock, flags);
+		if (dma_fence_is_signaled_locked(&userq_fence->base)) {
+			/*
+			 * It is possible that fence is already signaled and the
+			 * fence_drv now NULL, just skip over such fences.
+			*/
+			spin_unlock_irqrestore(userq_fence->base.lock, flags);
+			continue;
+		}
 		fence_drv = userq_fence->fence_drv;
+		amdgpu_userq_fence_driver_get(fence_drv);
+		spin_unlock_irqrestore(userq_fence->base.lock, flags);
+
 		/*
 		 * We need to make sure the user queue release their reference
 		 * to the fence drivers at some point before queue destruction.
@@ -895,10 +876,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 		 */
 		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
 			     xa_limit_32b, GFP_KERNEL);
-		if (r)
+		if (r) {
+			amdgpu_userq_fence_driver_put(fence_drv);
 			goto put_waitq;
-
-		amdgpu_userq_fence_driver_get(fence_drv);
+		}
 
 		/* Store drm syncobj's gpu va address and value */
 		fence_info[cnt].va = fence_drv->va;
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

