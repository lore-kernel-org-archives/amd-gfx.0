Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E144FF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 18:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADFF210E8BA;
	Mon, 27 Apr 2026 18:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rMCu0Iv3";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0AE510E8BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 18:27:27 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so90438115e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777314446; x=1777919246; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kSDRKFd89BDiXB7IP6kTisBZIO952Fj64rv/TZ8cVmQ=;
 b=rMCu0Iv3lQdxq1Z1azpd8ZwbcWFesctqgdSa2/gU09UCY0C88wYhVI+zIegIkEC2uZ
 k82kxnaCCbwQaA6thP53FHTj4vzEABn6YpjYaQ896Rav3WJFUiDHzM0KrTy2SlOW3x67
 v2EsDApdFVecVd2hnrm04i/CPJlhws/xkqiOlnFCaWQHMlqd8TLHAvGbhw/58NSGTpk1
 Ll5LVI5LeC1r2uhUvAxoKhbGtxtzpgjOTgf5BnUbh9trbWkBtvL9PjnYNcuQjBbOsAQ5
 YG+5nf4wG3NXb37VEu1/7KaUH4VP/mnXRfkcPfmdGp9NN8K6jkGXu2FfVw9oGSr3T8+c
 TSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777314446; x=1777919246;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kSDRKFd89BDiXB7IP6kTisBZIO952Fj64rv/TZ8cVmQ=;
 b=c/BH9cTtKIfhvY4UNrzvd1T4udXu5i2dEAxpee0MXArs6MynJ6Hmq9TTO30eShzloi
 IyPoDk9oFs9fxwuX6rGbCjNSprqzm3FklJbp4z3hKpVEhID69keWqWG46T84SV00g4Xf
 ID0sQi5/WES4LFTjLp+vn6dBW9uzIFpqJzpElsSQXpW/YiYh37AqGNBM+aODbutHZ7+C
 H5u6qO2mFlAIGJzJTk3OGEWhQusJvk249y03zKLdoF7xlfpvyoBSzFfgyLzGEyMWBzhO
 XDzGZ9/sENBdHS5GYhEWM8eOZbalTiS8rRAHZZ/NbTLuRvcsm0hy4wGH+khC4twSkVms
 XRrQ==
X-Gm-Message-State: AOJu0YxZOhS/gm31pnSc4V3suL9WOqHOGv/ec4p90TrPdCcqchgrVM1q
 E0d3iT4rEYIQZUj0tS+akZvxAfpL6bONwoAALoF7sMjt3DFgBDtzrBgY
X-Gm-Gg: AeBDievPFSzGY80iYJ977eLuyjG9CVzM+oZ3u0s971UOk+QYawm+Nxjwh+Mi2S0wf1e
 I+0Hrw8mnyf7yGObhh20Qeb2S0P0Sd1rmMuw8e1DDJPmyLEh+m4wkDhL2TqubLQQj9C2f5U8gv1
 wWfGp+UyTOw2cbb0DPWHM02ldbFsqKScVlz3+/JYbZGTidahpR0sSsD2DYzbHcE8MixrFxG93T4
 ewoDDpTVqI2iOFxSde0rhrsZsNW64v6WyMrSsprCfeTV27/yq/3AE7C8wjDXZdfiHZcpwAmLCPJ
 OhYQFfk5FYn4mcjiTZWuuvRnazfrqZ1GBvJKc0hHoTtZmYPClsLE/FgJ2sp7ZrBbw0f1CQUsVE5
 TOVL7EVMGddk5zjKU8qUtNVBiRCJi9O313zZMHfDe5JaBtrdtbXEuObVMOwsOR1yMGmDfTMwwjl
 Y1NEsP2XeoYfzdS+oGnMfA9SlD0eNWRBSg5NyNRhifOPikxA==
X-Received: by 2002:a05:600c:a101:b0:489:1b10:d896 with SMTP id
 5b1f17b1804b1-48a76e0191cmr6897145e9.0.1777314446263; 
 Mon, 27 Apr 2026 11:27:26 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:153b:d200:96aa:46be:4d7:72d2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773af5c5sm6046165e9.5.2026.04.27.11.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 11:27:25 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amdgpu: rework amdgpu_userq_signal_ioctl v2
Date: Mon, 27 Apr 2026 20:27:18 +0200
Message-ID: <20260427182723.1715-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427182723.1715-1-christian.koenig@amd.com>
References: <20260427182723.1715-1-christian.koenig@amd.com>
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

This one was fortunately not looking so bad as the wait ioctl path, but
there were still a few things which could be fixed/improved:

1. Allocating with GFP_ATOMIC was quite unecessary, we can do that
   before taking the userq_lock.
2. Use a new mutex as protection for the fence_drv_xa so that we can do
   memory allocations while holding it.
3. Starting the reset timer is unecessary when the fence is already
   signaled when we create it.
4. Cleanup error handling, avoid trying to free the queue when we don't
   even got one.

v2: fix incorrect usage of xa_find, destroy the new mutex on error

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  12 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 227 ++++++++----------
 3 files changed, 119 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a34b1df513d3..62d155d6e4ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -806,6 +806,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	queue->doorbell_index = index;
+	mutex_init(&queue->fence_drv_lock);
 	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
 	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
 	if (r) {
@@ -879,6 +880,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	amdgpu_bo_unreserve(fpriv->vm.root.bo);
+	mutex_destroy(&queue->fence_drv_lock);
 free_queue:
 	kfree(queue);
 err_pm_runtime:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8b8f345b60b6..843ea8ecc5d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -66,6 +66,18 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
+
+	/**
+	 * @fence_drv_lock: Protecting @fence_drv_xa.
+	 */
+	struct mutex		fence_drv_lock;
+
+	/**
+	 * @fence_drv_xa:
+	 *
+	 * References to the external fence drivers returned by wait_ioctl.
+	 * Dropped on the next signaled dma_fence or queue destruction.
+	 */
 	struct xarray		fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence	*last_fence;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index f3d0595e3e61..a2792f05b670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -121,6 +121,7 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 	userq->last_fence = NULL;
 	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
 	xa_destroy(&userq->fence_drv_xa);
+	mutex_destroy(&userq->fence_drv_lock);
 	/* Drop the queue's ownership reference to fence_drv explicitly */
 	amdgpu_userq_fence_driver_put(userq->fence_drv);
 }
@@ -209,81 +210,84 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
 	kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
 }
 
-static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
+static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
+				    struct amdgpu_userq_fence **pfence)
 {
-	*userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
-	return *userq_fence ? 0 : -ENOMEM;
+	struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
+	struct amdgpu_userq_fence *userq_fence;
+	void * entry;
+
+	userq_fence = kmalloc(sizeof(*userq_fence), GFP_KERNEL);
+	if (!userq_fence)
+		return -ENOMEM;
+
+	/*
+	 * Get the next unused entry, since we fill from the start this can be
+	 * used as size to allocate the array.
+	 */
+	mutex_lock(&userq->fence_drv_lock);
+	XA_STATE(xas, &userq->fence_drv_xa, 0);
+
+	rcu_read_lock();
+	do {
+		entry = xas_find_marked(&xas, ULONG_MAX, XA_FREE_MARK);
+	} while (xas_retry(&xas, entry));
+	rcu_read_unlock();
+
+	userq_fence->fence_drv_array = kvmalloc_array(xas.xa_index,
+						      sizeof(fence_drv),
+						      GFP_KERNEL);
+	if (!userq_fence->fence_drv_array) {
+		mutex_unlock(&userq->fence_drv_lock);
+		kfree(userq_fence);
+		return -ENOMEM;
+	}
+
+	userq_fence->fence_drv_array_count = xas.xa_index;
+	xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
+		   0, ULONG_MAX, xas.xa_index, XA_PRESENT);
+	xa_destroy(&userq->fence_drv_xa);
+
+	mutex_unlock(&userq->fence_drv_lock);
+
+	userq_fence->fence_drv = fence_drv;
+	amdgpu_userq_fence_driver_get(fence_drv);
+
+	*pfence = userq_fence;
+	return 0;
 }
 
-static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
-				     struct amdgpu_userq_fence *userq_fence,
-				     u64 seq, struct dma_fence **f)
+static void amdgpu_userq_fence_init(struct amdgpu_usermode_queue *userq,
+				    struct amdgpu_userq_fence *fence,
+				    u64 seq)
 {
-	struct amdgpu_userq_fence_driver *fence_drv;
-	struct dma_fence *fence;
+	struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
 	unsigned long flags;
 	bool signaled = false;
 
-	fence_drv = userq->fence_drv;
-	if (!fence_drv)
-		return -EINVAL;
-
-	spin_lock_init(&userq_fence->lock);
-	INIT_LIST_HEAD(&userq_fence->link);
-	fence = &userq_fence->base;
-	userq_fence->fence_drv = fence_drv;
-
-	dma_fence_init64(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
+	spin_lock_init(&fence->lock);
+	dma_fence_init64(&fence->base, &amdgpu_userq_fence_ops, &fence->lock,
 			 fence_drv->context, seq);
 
-	amdgpu_userq_fence_driver_get(fence_drv);
-	dma_fence_get(fence);
-
-	if (!xa_empty(&userq->fence_drv_xa)) {
-		struct amdgpu_userq_fence_driver *stored_fence_drv;
-		unsigned long index, count = 0;
-		int i = 0;
-
-		xa_lock(&userq->fence_drv_xa);
-		xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
-			count++;
-
-		userq_fence->fence_drv_array =
-			kvmalloc_array(count,
-				       sizeof(struct amdgpu_userq_fence_driver *),
-				       GFP_ATOMIC);
-
-		if (userq_fence->fence_drv_array) {
-			xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
-				userq_fence->fence_drv_array[i] = stored_fence_drv;
-				__xa_erase(&userq->fence_drv_xa, index);
-				i++;
-			}
-		}
-
-		userq_fence->fence_drv_array_count = i;
-		xa_unlock(&userq->fence_drv_xa);
-	} else {
-		userq_fence->fence_drv_array = NULL;
-		userq_fence->fence_drv_array_count = 0;
-	}
+	/* Make sure the fence is visible to the hang detect worker */
+	dma_fence_put(userq->last_fence);
+	userq->last_fence = dma_fence_get(&fence->base);
 
-	/* Check if hardware has already processed the job */
+	/* Check if hardware has already processed the fence */
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
-	if (!dma_fence_is_signaled(fence)) {
-		list_add_tail(&userq_fence->link, &fence_drv->fences);
+	if (!dma_fence_is_signaled(&fence->base)) {
+		dma_fence_get(&fence->base);
+		list_add_tail(&fence->link, &fence_drv->fences);
 	} else {
+		INIT_LIST_HEAD(&fence->link);
 		signaled = true;
-		dma_fence_put(fence);
 	}
 	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
 	if (signaled)
-		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
-
-	*f = fence;
-
-	return 0;
+		amdgpu_userq_fence_put_fence_drv_array(fence);
+	else
+		amdgpu_userq_start_hang_detect_work(userq);
 }
 
 static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
@@ -404,11 +408,6 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
 	return r;
 }
 
-static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
-{
-	dma_fence_put(fence);
-}
-
 static void
 amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
 				    int error)
@@ -452,13 +451,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	const unsigned int num_read_bo_handles = args->num_bo_read_handles;
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
+
 	struct drm_gem_object **gobj_write, **gobj_read;
 	u32 *syncobj_handles, num_syncobj_handles;
-	struct amdgpu_userq_fence *userq_fence;
-	struct amdgpu_usermode_queue *queue = NULL;
-	struct drm_syncobj **syncobj = NULL;
-	struct dma_fence *fence;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_fence *fence;
+	struct drm_syncobj **syncobj;
 	struct drm_exec exec;
+	void __user *ptr;
 	int r, i, entry;
 	u64 wptr;
 
@@ -470,13 +470,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 
 	num_syncobj_handles = args->num_syncobj_handles;
-	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
-					    num_syncobj_handles, sizeof(u32));
+	ptr = u64_to_user_ptr(args->syncobj_handles);
+	syncobj_handles = memdup_array_user(ptr, num_syncobj_handles,
+					    sizeof(u32));
 	if (IS_ERR(syncobj_handles))
 		return PTR_ERR(syncobj_handles);
 
-	/* Array of pointers to the looked up syncobjs */
-	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
+	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj),
+				GFP_KERNEL);
 	if (!syncobj) {
 		r = -ENOMEM;
 		goto free_syncobj_handles;
@@ -490,21 +491,17 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	r = drm_gem_objects_lookup(filp,
-				   u64_to_user_ptr(args->bo_read_handles),
-				   num_read_bo_handles,
-				   &gobj_read);
+	ptr = u64_to_user_ptr(args->bo_read_handles);
+	r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
 	if (r)
 		goto free_syncobj;
 
-	r = drm_gem_objects_lookup(filp,
-				   u64_to_user_ptr(args->bo_write_handles),
-				   num_write_bo_handles,
+	ptr = u64_to_user_ptr(args->bo_write_handles);
+	r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
 				   &gobj_write);
 	if (r)
 		goto put_gobj_read;
 
-	/* Retrieve the user queue */
 	queue = amdgpu_userq_get(userq_mgr, args->queue_id);
 	if (!queue) {
 		r = -ENOENT;
@@ -513,73 +510,61 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 	r = amdgpu_userq_fence_read_wptr(adev, queue, &wptr);
 	if (r)
-		goto put_gobj_write;
+		goto put_queue;
 
-	r = amdgpu_userq_fence_alloc(&userq_fence);
+	r = amdgpu_userq_fence_alloc(queue, &fence);
 	if (r)
-		goto put_gobj_write;
+		goto put_queue;
 
 	/* We are here means UQ is active, make sure the eviction fence is valid */
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
-	/* Create a new fence */
-	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
-	if (r) {
-		mutex_unlock(&userq_mgr->userq_mutex);
-		kfree(userq_fence);
-		goto put_gobj_write;
-	}
+	/* Create the new fence */
+	amdgpu_userq_fence_init(queue, fence, wptr);
 
-	dma_fence_put(queue->last_fence);
-	queue->last_fence = dma_fence_get(fence);
-	amdgpu_userq_start_hang_detect_work(queue);
 	mutex_unlock(&userq_mgr->userq_mutex);
 
+	/*
+	 * This needs to come after the fence is created since
+	 * amdgpu_userq_ensure_ev_fence() can't be called while holding the resv
+	 * locks.
+	 */
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
 		      (num_read_bo_handles + num_write_bo_handles));
 
-	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
+		r = drm_exec_prepare_array(&exec, gobj_read,
+					   num_read_bo_handles, 1);
 		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			amdgpu_userq_fence_cleanup(fence);
+		if (r)
 			goto exec_fini;
-		}
 
-		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
+		r = drm_exec_prepare_array(&exec, gobj_write,
+					   num_write_bo_handles, 1);
 		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			amdgpu_userq_fence_cleanup(fence);
+		if (r)
 			goto exec_fini;
-		}
 	}
 
-	for (i = 0; i < num_read_bo_handles; i++) {
-		if (!gobj_read || !gobj_read[i]->resv)
-			continue;
-
-		dma_resv_add_fence(gobj_read[i]->resv, fence,
+	/* And publish the new fence in the BOs and syncobj */
+	for (i = 0; i < num_read_bo_handles; i++)
+		dma_resv_add_fence(gobj_read[i]->resv, &fence->base,
 				   DMA_RESV_USAGE_READ);
-	}
 
-	for (i = 0; i < num_write_bo_handles; i++) {
-		if (!gobj_write || !gobj_write[i]->resv)
-			continue;
-
-		dma_resv_add_fence(gobj_write[i]->resv, fence,
+	for (i = 0; i < num_write_bo_handles; i++)
+		dma_resv_add_fence(gobj_write[i]->resv, &fence->base,
 				   DMA_RESV_USAGE_WRITE);
-	}
 
-	/* Add the created fence to syncobj/BO's */
 	for (i = 0; i < num_syncobj_handles; i++)
-		drm_syncobj_replace_fence(syncobj[i], fence);
+		drm_syncobj_replace_fence(syncobj[i], &fence->base);
 
+exec_fini:
 	/* drop the reference acquired in fence creation function */
-	dma_fence_put(fence);
+	dma_fence_put(&fence->base);
 
-exec_fini:
 	drm_exec_fini(&exec);
+put_queue:
+	amdgpu_userq_put(queue);
 put_gobj_write:
 	for (i = 0; i < num_write_bo_handles; i++)
 		drm_gem_object_put(gobj_write[i]);
@@ -590,15 +575,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	kvfree(gobj_read);
 free_syncobj:
 	while (entry-- > 0)
-		if (syncobj[entry])
-			drm_syncobj_put(syncobj[entry]);
+		drm_syncobj_put(syncobj[entry]);
 	kfree(syncobj);
 free_syncobj_handles:
 	kfree(syncobj_handles);
 
-	if (queue)
-		amdgpu_userq_put(queue);
-
 	return r;
 }
 
@@ -873,8 +854,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 		 * Otherwise, we would gather those references until we don't
 		 * have any more space left and crash.
 		 */
+		mutex_lock(&waitq->fence_drv_lock);
 		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
 			     xa_limit_32b, GFP_KERNEL);
+		mutex_unlock(&waitq->fence_drv_lock);
 		if (r)
 			goto put_waitq;
 
-- 
2.43.0

