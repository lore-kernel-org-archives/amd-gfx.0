Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1686AFD707A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 10:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F1410E5CC;
	Tue, 17 Mar 2026 10:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aMIwQbT7";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C45210E5C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 10:55:08 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43b41b545d9so2788070f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 03:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773744906; x=1774349706; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9XPj8Y4YXkE/+DMe7TvXrv/4coZYHNzyotuu11HHWIk=;
 b=aMIwQbT7rDUVtEW3sX8NHRYwNdcLHBEAar1JVDW1rzemDVxUfDytoX9Vj77gppeVq+
 f4nqDl+yB2VeFKknXf5msTH3xY8u7qsaASO9QR0HS6Cg+ncascA3ope2UnmRnmg1qp8z
 rlaTczuCu4eEBvHiUBxS6EJ4xuddnm4uMK8vcJbZu2TLdchIVIyWPTUQ5y7V/rYy/DF9
 cfOkuroIYIrqkhHEezgEhy8Oaasc7CMOZBopZZsQh4DiAH9KdAwBsKl8FScuXRh++fII
 EfnEnn/ry0jUZ8L1x5U1lmMDcFvdPPz0W6Rsxom0ZVhkX6dW/2/9LP+5UukpglP62IkK
 wjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773744906; x=1774349706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9XPj8Y4YXkE/+DMe7TvXrv/4coZYHNzyotuu11HHWIk=;
 b=JfhnHqRPN9L7MIgnJUzSLKEyDpcWkSCuZFVMvtqPiPnfhNfWofT0gnXp3P+XSZiATN
 vCtlzPpIn687QYpTVn7WRKBlEfVQX7krloJl26GjoYrnCP3LCe8SmFz68fahktDqFwA5
 JplLmpijoie5Ri4kc9nQmDTmsZiQ6NGfuXTjBe0w0CWTzq8Mlr4DiKh2ZXBPE5jCjb0z
 y40M4onddoJTAwe9R3202e/V1bICRII+PDtcILbeW88JkQSY1X6W/xGiouBOrri3/3cq
 5uDLWausiL+Z81A0FSgmLqBI0TOY1QGsmvv4cdD4+FW+SWVsjUdU6XpsVXDyOxav5DA1
 Imug==
X-Gm-Message-State: AOJu0Yzl2bzuoQUaDWvPnxSqli+Mh27bTpEE6wbk3bViCXiKPg372Mla
 WZkXvSkywz6znKI2v9LiMF05l6Z/Gnrt36iS79oWJ1jVMtyyShHiQ5hN
X-Gm-Gg: ATEYQzyvsbWelHxHc4qeaMQ4/GZn0PJsPdM/Ku5ywMS9NCkwcrRKf9bZ6gKRBKLNofa
 o214Rg5pdHoRQYxTIFHZi0fVZjY/rryYpfxSYIRlLRexsW8afUqSOC6cS3H0F4q2lPk2N+K/fan
 L5Ve4wCrWZZNDvPo78fnQBvoAN7tfTPyIKPkQXuCTVk99teGQZHx/YqHKq9116yhpx+e7yHvYOQ
 cL0QTgodFzI6Ex8gWdce+JPhucWPHbkr58lZlzw4RI9AV9e0Axlx8uOldDzRNcIvEINM+ArShoV
 nqSx94NOTSBcx2BcRYOKMTH5aQ7ev2KvXGSj87V1UjKQNqvlW1GfzbE7Mvdq/Ejh+VoH2w2ArLs
 z/+5/pJz7N765E7u6Je7f8+yp5RJP12x1UVqmkhKF4hErL9Fo6dkGxV8c1GmTw84dsDpvCTxxxc
 imTGzqgWQ7HhxCtyyzTnn5meHj60SmIcIOZxpy
X-Received: by 2002:a05:6000:2584:b0:439:ccd7:cdb6 with SMTP id
 ffacd0b85a97d-43a04d8c23bmr28646839f8f.14.1773744906062; 
 Tue, 17 Mar 2026 03:55:06 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1570:2300:fbdd:8811:84b7:347c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bd9csm49852223f8f.21.2026.03.17.03.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:55:05 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: sukhatri@amd.com, tursulin@ursulin.net, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, SRINIVASAN.SHANMUGAM@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/10] drm/amdgpu: rework amdgpu_userq_wait_ioctl v4
Date: Tue, 17 Mar 2026 11:54:54 +0100
Message-ID: <20260317105501.21479-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317105501.21479-1-christian.koenig@amd.com>
References: <20260317105501.21479-1-christian.koenig@amd.com>
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

Lockdep was complaining about a number of issues here. Especially lock
inversion between syncobj, dma_resv and copying things into userspace.

Rework the functionality. Split it up into multiple functions,
consistenly use memdup_array_user(), fix the lock inversions and a few
more bugs in error handling.

v2: drop the dma_fence leak fix, turned out that was actually correct,
    just not well documented. Apply some more cleanup suggestion from
    Tvrtko.
v3: rebase on already done cleanups
v4: add missing dma_fence_put() in error path.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 582 ++++++++++--------
 1 file changed, 323 insertions(+), 259 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 442c08b69f7c..0d9a13081f2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -617,335 +617,399 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
-int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
-			    struct drm_file *filp)
+/* Count the number of expected fences so userspace can alloc a buffer */
+static int
+amdgpu_userq_wait_count_fences(struct drm_file *filp,
+			       struct drm_amdgpu_userq_wait *wait_info,
+			       u32 *syncobj_handles, u32 *timeline_points,
+			       u32 *timeline_handles,
+			       struct drm_gem_object **gobj_write,
+			       struct drm_gem_object **gobj_read)
 {
-	struct drm_amdgpu_userq_wait *wait_info = data;
-	const unsigned int num_write_bo_handles = wait_info->num_bo_write_handles;
-	const unsigned int num_read_bo_handles = wait_info->num_bo_read_handles;
-	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
-	struct drm_gem_object **gobj_write, **gobj_read;
-	u32 *timeline_points, *timeline_handles;
-	struct amdgpu_usermode_queue *waitq = NULL;
-	u32 *syncobj_handles, num_syncobj;
-	struct dma_fence **fences = NULL;
-	u16 num_points, num_fences = 0;
+	int num_read_bo_handles, num_write_bo_handles;
+	struct dma_fence_unwrap iter;
+	struct dma_fence *fence, *f;
+	unsigned int num_fences = 0;
 	struct drm_exec exec;
-	int r, i, cnt;
-
-	if (!amdgpu_userq_enabled(dev))
-		return -ENOTSUPP;
-
-	if (wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
-	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
-		return -EINVAL;
-
-	num_syncobj = wait_info->num_syncobj_handles;
-	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
-					    num_syncobj, sizeof(u32));
-	if (IS_ERR(syncobj_handles))
-		return PTR_ERR(syncobj_handles);
-
+	int i, r;
+
+	/*
+	 * This needs to be outside of the lock provided by drm_exec for
+	 * DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT to work correctly.
+	 */
+
+	/* Count timeline fences */
+	for (i = 0; i < wait_info->num_syncobj_timeline_handles; i++) {
+		r = drm_syncobj_find_fence(filp, timeline_handles[i],
+					   timeline_points[i],
+					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+					   &fence);
+		if (r)
+			return r;
+
+		dma_fence_unwrap_for_each(f, &iter, fence)
+			num_fences++;
 
-	num_points = wait_info->num_syncobj_timeline_handles;
-	timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
-					     num_points, sizeof(u32));
-	if (IS_ERR(timeline_handles)) {
-		r = PTR_ERR(timeline_handles);
-		goto free_syncobj_handles;
+		dma_fence_put(fence);
 	}
 
-	timeline_points = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
-					    num_points, sizeof(u32));
+	/* Count boolean fences */
+	for (i = 0; i < wait_info->num_syncobj_handles; i++) {
+		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
+					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+					   &fence);
+		if (r)
+			return r;
 
-	if (IS_ERR(timeline_points)) {
-		r = PTR_ERR(timeline_points);
-		goto free_timeline_handles;
+		num_fences++;
+		dma_fence_put(fence);
 	}
 
-	r = drm_gem_objects_lookup(filp,
-				   u64_to_user_ptr(wait_info->bo_read_handles),
-				   num_read_bo_handles,
-				   &gobj_read);
-	if (r)
-		goto free_timeline_points;
-
-	r = drm_gem_objects_lookup(filp,
-				   u64_to_user_ptr(wait_info->bo_write_handles),
-				   num_write_bo_handles,
-				   &gobj_write);
-	if (r)
-		goto put_gobj_read;
-
+	/* Lock all the GEM objects */
+	/* TODO: It is actually not necessary to lock them */
+	num_read_bo_handles = wait_info->num_bo_read_handles;
+	num_write_bo_handles = wait_info->num_bo_write_handles;
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
-		      (num_read_bo_handles + num_write_bo_handles));
+		      num_read_bo_handles + num_write_bo_handles);
 
-	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
+		r = drm_exec_prepare_array(&exec, gobj_read,
+					   num_read_bo_handles, 1);
 		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			drm_exec_fini(&exec);
-			goto put_gobj_write;
-		}
+		if (r)
+			goto error_unlock;
 
-		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
+		r = drm_exec_prepare_array(&exec, gobj_write,
+					   num_write_bo_handles, 1);
 		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			drm_exec_fini(&exec);
-			goto put_gobj_write;
-		}
+		if (r)
+			goto error_unlock;
 	}
 
-	if (!wait_info->num_fences) {
-		if (num_points) {
-			struct dma_fence_unwrap iter;
-			struct dma_fence *fence;
-			struct dma_fence *f;
-
-			for (i = 0; i < num_points; i++) {
-				r = drm_syncobj_find_fence(filp, timeline_handles[i],
-							   timeline_points[i],
-							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
-							   &fence);
-				if (r)
-					goto exec_fini;
-
-				dma_fence_unwrap_for_each(f, &iter, fence)
-					num_fences++;
-
-				dma_fence_put(fence);
-			}
-		}
+	/* Count read fences */
+	for (i = 0; i < num_read_bo_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+		struct dma_fence *fence;
 
-		/* Count syncobj's fence */
-		for (i = 0; i < num_syncobj; i++) {
-			struct dma_fence *fence;
+		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
+					DMA_RESV_USAGE_READ, fence)
+			num_fences++;
+	}
 
-			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
-						   0,
-						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
-						   &fence);
-			if (r)
-				goto exec_fini;
+	/* Count write fences */
+	for (i = 0; i < num_write_bo_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+		struct dma_fence *fence;
 
+		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
+					DMA_RESV_USAGE_WRITE, fence)
 			num_fences++;
-			dma_fence_put(fence);
-		}
+	}
 
-		/* Count GEM objects fence */
-		for (i = 0; i < num_read_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
+	wait_info->num_fences = num_fences;
+	r = 0;
 
-			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
-						DMA_RESV_USAGE_READ, fence)
-				num_fences++;
-		}
+error_unlock:
+	/* Unlock all the GEM objects */
+	drm_exec_fini(&exec);
+	return r;
+}
 
-		for (i = 0; i < num_write_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
+static int
+amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
+				    struct drm_amdgpu_userq_wait *wait_info,
+				    u32 *syncobj_handles, u32 *timeline_points,
+				    u32 *timeline_handles,
+				    struct drm_gem_object **gobj_write,
+				    struct drm_gem_object **gobj_read)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
+	struct drm_amdgpu_userq_fence_info *fence_info;
+	int num_read_bo_handles, num_write_bo_handles;
+	struct amdgpu_usermode_queue *waitq;
+	struct dma_fence **fences, *fence, *f;
+	struct dma_fence_unwrap iter;
+	int num_points, num_syncobj;
+	unsigned int num_fences = 0;
+	struct drm_exec exec;
+	int i, cnt, r;
 
-			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
-						DMA_RESV_USAGE_WRITE, fence)
-				num_fences++;
-		}
+	fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info),
+				   GFP_KERNEL);
+	if (!fence_info)
+		return -ENOMEM;
 
-		/*
-		 * Passing num_fences = 0 means that userspace doesn't want to
-		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
-		 * userq_fence_info and return the actual number of fences on
-		 * args->num_fences.
-		 */
-		wait_info->num_fences = num_fences;
-	} else {
-		/* Array of fence info */
-		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
-		if (!fence_info) {
-			r = -ENOMEM;
-			goto exec_fini;
-		}
+	fences = kmalloc_array(wait_info->num_fences, sizeof(*fences),
+			       GFP_KERNEL);
+	if (!fences) {
+		r = -ENOMEM;
+		goto free_fence_info;
+	}
+
+	/* Retrieve timeline fences */
+	num_points = wait_info->num_syncobj_timeline_handles;
+	for (i = 0; i < num_points; i++) {
+		r = drm_syncobj_find_fence(filp, timeline_handles[i],
+					   timeline_points[i],
+					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+					   &fence);
+		if (r)
+			goto free_fences;
+
+		dma_fence_unwrap_for_each(f, &iter, fence) {
+			if (num_fences >= wait_info->num_fences) {
+				r = -EINVAL;
+				dma_fence_put(fence);
+				goto free_fences;
+			}
 
-		/* Array of fences */
-		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
-		if (!fences) {
-			r = -ENOMEM;
-			goto free_fence_info;
+			fences[num_fences++] = dma_fence_get(f);
 		}
 
-		/* Retrieve GEM read objects fence */
-		for (i = 0; i < num_read_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
+		dma_fence_put(fence);
+	}
 
-			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
-						DMA_RESV_USAGE_READ, fence) {
-				if (num_fences >= wait_info->num_fences) {
-					r = -EINVAL;
-					goto free_fences;
-				}
+	/* Retrieve boolean fences */
+	num_syncobj = wait_info->num_syncobj_handles;
+	for (i = 0; i < num_syncobj; i++) {
+		struct dma_fence *fence;
 
-				fences[num_fences++] = fence;
-				dma_fence_get(fence);
-			}
+		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
+					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+					   &fence);
+		if (r)
+			goto free_fences;
+
+		if (num_fences >= wait_info->num_fences) {
+			dma_fence_put(fence);
+			r = -EINVAL;
+			goto free_fences;
 		}
 
-		/* Retrieve GEM write objects fence */
-		for (i = 0; i < num_write_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
+		/* Give the reference to the fence array */
+		fences[num_fences++] = fence;
+	}
+
+	/* Lock all the GEM objects */
+	num_read_bo_handles = wait_info->num_bo_read_handles;
+	num_write_bo_handles = wait_info->num_bo_write_handles;
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+		      num_read_bo_handles + num_write_bo_handles);
 
-			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
-						DMA_RESV_USAGE_WRITE, fence) {
-				if (num_fences >= wait_info->num_fences) {
-					r = -EINVAL;
-					goto free_fences;
-				}
+	drm_exec_until_all_locked(&exec) {
+		r = drm_exec_prepare_array(&exec, gobj_read,
+					   num_read_bo_handles, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto error_unlock;
 
-				fences[num_fences++] = fence;
-				dma_fence_get(fence);
-			}
-		}
+		r = drm_exec_prepare_array(&exec, gobj_write,
+					   num_write_bo_handles, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto error_unlock;
+	}
 
-		if (num_points) {
-			struct dma_fence_unwrap iter;
-			struct dma_fence *fence;
-			struct dma_fence *f;
-
-			for (i = 0; i < num_points; i++) {
-				r = drm_syncobj_find_fence(filp, timeline_handles[i],
-							   timeline_points[i],
-							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
-							   &fence);
-				if (r)
-					goto free_fences;
-
-				dma_fence_unwrap_for_each(f, &iter, fence) {
-					if (num_fences >= wait_info->num_fences) {
-						r = -EINVAL;
-						dma_fence_put(fence);
-						goto free_fences;
-					}
-
-					dma_fence_get(f);
-					fences[num_fences++] = f;
-				}
+	/* Retrieve GEM read objects fence */
+	for (i = 0; i < num_read_bo_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+		struct dma_fence *fence;
 
-				dma_fence_put(fence);
+		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
+					DMA_RESV_USAGE_READ, fence) {
+			if (num_fences >= wait_info->num_fences) {
+				r = -EINVAL;
+				goto error_unlock;
 			}
-		}
 
-		/* Retrieve syncobj's fence */
-		for (i = 0; i < num_syncobj; i++) {
-			struct dma_fence *fence;
+			fences[num_fences++] = dma_fence_get(fence);
+		}
+	}
 
-			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
-						   0,
-						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
-						   &fence);
-			if (r)
-				goto free_fences;
+	/* Retrieve GEM write objects fence */
+	for (i = 0; i < num_write_bo_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+		struct dma_fence *fence;
 
+		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
+					DMA_RESV_USAGE_WRITE, fence) {
 			if (num_fences >= wait_info->num_fences) {
 				r = -EINVAL;
-				dma_fence_put(fence);
-				goto free_fences;
+				goto error_unlock;
 			}
 
-			fences[num_fences++] = fence;
+			fences[num_fences++] = dma_fence_get(fence);
 		}
+	}
 
-		/*
-		 * Keep only the latest fences to reduce the number of values
-		 * given back to userspace.
-		 */
-		num_fences = dma_fence_dedup_array(fences, num_fences);
+	drm_exec_fini(&exec);
 
-		waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
-		if (!waitq) {
-			r = -EINVAL;
-			goto free_fences;
-		}
+	/*
+	 * Keep only the latest fences to reduce the number of values
+	 * given back to userspace.
+	 */
+	num_fences = dma_fence_dedup_array(fences, num_fences);
 
-		for (i = 0, cnt = 0; i < num_fences; i++) {
-			struct amdgpu_userq_fence_driver *fence_drv;
-			struct amdgpu_userq_fence *userq_fence;
-			u32 index;
-
-			userq_fence = to_amdgpu_userq_fence(fences[i]);
-			if (!userq_fence) {
-				/*
-				 * Just waiting on other driver fences should
-				 * be good for now
-				 */
-				r = dma_fence_wait(fences[i], true);
-				if (r)
-					goto free_fences;
-
-				continue;
-			}
+	waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
+	if (!waitq) {
+		r = -EINVAL;
+		goto free_fences;
+	}
+
+	for (i = 0, cnt = 0; i < num_fences; i++) {
+		struct amdgpu_userq_fence_driver *fence_drv;
+		struct amdgpu_userq_fence *userq_fence;
+		u32 index;
 
-			fence_drv = userq_fence->fence_drv;
+		userq_fence = to_amdgpu_userq_fence(fences[i]);
+		if (!userq_fence) {
 			/*
-			 * We need to make sure the user queue release their reference
-			 * to the fence drivers at some point before queue destruction.
-			 * Otherwise, we would gather those references until we don't
-			 * have any more space left and crash.
+			 * Just waiting on other driver fences should
+			 * be good for now
 			 */
-			r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
-				     xa_limit_32b, GFP_KERNEL);
+			r = dma_fence_wait(fences[i], true);
 			if (r)
-				goto free_fences;
+				goto put_waitq;
 
-			amdgpu_userq_fence_driver_get(fence_drv);
+			continue;
+		}
 
-			/* Store drm syncobj's gpu va address and value */
-			fence_info[cnt].va = fence_drv->va;
-			fence_info[cnt].value = fences[i]->seqno;
+		fence_drv = userq_fence->fence_drv;
+		/*
+		 * We need to make sure the user queue release their reference
+		 * to the fence drivers at some point before queue destruction.
+		 * Otherwise, we would gather those references until we don't
+		 * have any more space left and crash.
+		 */
+		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
+			     xa_limit_32b, GFP_KERNEL);
+		if (r)
+			goto put_waitq;
 
-			/* Increment the actual userq fence count */
-			cnt++;
-		}
+		amdgpu_userq_fence_driver_get(fence_drv);
 
-		wait_info->num_fences = cnt;
-		/* Copy userq fence info to user space */
-		if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
-				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
-			r = -EFAULT;
-			goto free_fences;
-		}
+		/* Store drm syncobj's gpu va address and value */
+		fence_info[cnt].va = fence_drv->va;
+		fence_info[cnt].value = fences[i]->seqno;
+
+		/* Increment the actual userq fence count */
+		cnt++;
 	}
+	wait_info->num_fences = cnt;
+
+	/* Copy userq fence info to user space */
+	if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
+			 fence_info, cnt * sizeof(*fence_info)))
+		r = -EFAULT;
+	else
+		r = 0;
+
+put_waitq:
+	amdgpu_userq_put(waitq);
 
 free_fences:
-	if (fences) {
-		while (num_fences-- > 0)
-			dma_fence_put(fences[num_fences]);
-		kfree(fences);
-	}
+	while (num_fences--)
+		dma_fence_put(fences[num_fences]);
+	kfree(fences);
+
 free_fence_info:
 	kfree(fence_info);
-exec_fini:
+	return r;
+
+error_unlock:
 	drm_exec_fini(&exec);
-put_gobj_write:
-	for (i = 0; i < num_write_bo_handles; i++)
-		drm_gem_object_put(gobj_write[i]);
+	goto free_fences;
+}
+
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp)
+{
+	int num_points, num_syncobj, num_read_bo_handles, num_write_bo_handles;
+	u32 *syncobj_handles, *timeline_points, *timeline_handles;
+	struct drm_amdgpu_userq_wait *wait_info = data;
+	struct drm_gem_object **gobj_write;
+	struct drm_gem_object **gobj_read;
+	void __user *ptr;
+	int r;
+
+	if (!amdgpu_userq_enabled(dev))
+		return -ENOTSUPP;
+
+	if (wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
+	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
+		return -EINVAL;
+
+	num_syncobj = wait_info->num_syncobj_handles;
+	ptr = u64_to_user_ptr(wait_info->syncobj_handles);
+	syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
+	if (IS_ERR(syncobj_handles))
+		return PTR_ERR(syncobj_handles);
+
+	num_points = wait_info->num_syncobj_timeline_handles;
+	ptr = u64_to_user_ptr(wait_info->syncobj_timeline_handles);
+	timeline_handles = memdup_array_user(ptr, num_points, sizeof(u32));
+	if (IS_ERR(timeline_handles)) {
+		r = PTR_ERR(timeline_handles);
+		goto free_syncobj_handles;
+	}
+
+	ptr = u64_to_user_ptr(wait_info->syncobj_timeline_points);
+	timeline_points = memdup_array_user(ptr, num_points, sizeof(u32));
+	if (IS_ERR(timeline_points)) {
+		r = PTR_ERR(timeline_points);
+		goto free_timeline_handles;
+	}
+
+	num_read_bo_handles = wait_info->num_bo_read_handles;
+	ptr = u64_to_user_ptr(wait_info->bo_read_handles),
+	r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
+	if (r)
+		goto free_timeline_points;
+
+	num_write_bo_handles = wait_info->num_bo_write_handles;
+	ptr = u64_to_user_ptr(wait_info->bo_write_handles),
+	r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
+				   &gobj_write);
+	if (r)
+		goto put_gobj_read;
+
+	/*
+	 * Passing num_fences = 0 means that userspace doesn't want to
+	 * retrieve userq_fence_info. If num_fences = 0 we skip filling
+	 * userq_fence_info and return the actual number of fences on
+	 * args->num_fences.
+	 */
+	if (!wait_info->num_fences) {
+		r = amdgpu_userq_wait_count_fences(filp, wait_info,
+						   syncobj_handles,
+						   timeline_points,
+						   timeline_handles,
+						   gobj_write,
+						   gobj_read);
+	} else {
+		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
+							syncobj_handles,
+							timeline_points,
+							timeline_handles,
+							gobj_write,
+							gobj_read);
+	}
+
+	while (num_write_bo_handles--)
+		drm_gem_object_put(gobj_write[num_write_bo_handles]);
 	kvfree(gobj_write);
+
 put_gobj_read:
-	for (i = 0; i < num_read_bo_handles; i++)
-		drm_gem_object_put(gobj_read[i]);
+	while (num_read_bo_handles--)
+		drm_gem_object_put(gobj_read[num_read_bo_handles]);
 	kvfree(gobj_read);
+
 free_timeline_points:
 	kfree(timeline_points);
 free_timeline_handles:
 	kfree(timeline_handles);
 free_syncobj_handles:
 	kfree(syncobj_handles);
-
-	if (waitq)
-		amdgpu_userq_put(waitq);
-
 	return r;
 }
-- 
2.43.0

