Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA1FE73163
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 12:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5401410E4B8;
	Mon,  2 Feb 2026 12:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="do5OKseO";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29FE410E4B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 12:51:57 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so47323225e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 04:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770036716; x=1770641516; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LKL6I2CAxPHWLroBni7W/XlZE2iVdmUmhJtLcudUQH0=;
 b=do5OKseOQkNfHWBYit0H19gxwZx9JITYpRempMdk1fUdzqSTruDP52UFWW863bl+me
 wuQ2qCnm3xkzQtA2UGy/HTcn0hdXdd+4VYjlaVUmKF62R1lCRZTl5O7pYXrsbmeDrgcw
 J6CEsLlQueuCifqdj+ycO8bKdtvozqeqGUfQmrS1hffy0cYUlv1rB8TtudKNg1vvBUQg
 h6YWVFsjAwvgIpM2uYqDGvFLycpZNDm2Qzbnpj7Vk9dhhqB4drLGEwPaRw0GyoZBEHd9
 MYGji2HY2i0MgyLRlSr7UDiE+Q6HCSb/bQA2+KhLhEbzqRe43VBkCemD5gztHjhOVOOs
 HGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770036716; x=1770641516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LKL6I2CAxPHWLroBni7W/XlZE2iVdmUmhJtLcudUQH0=;
 b=ZQN9SN6Lk4nabnNhEVuT/rA+JyvdLtdCe06INNOIgPwhKykVOY2c4st+CdNWqq+t0x
 h/iSM2volncyV47rDjrbSaxbZeaWXQgttGV2TNewTGs8MwY4oWVC68EHspEHMtOafnib
 L94iggA2nxX0aLmllLTa3xZjb7k+xNaSEi2a8kw/nxzeH91WFzY5DF+BBfmKZsy3Fc3t
 asFe4gofI38IL1nt9LOj12IutkFV5raqrh34Ro1W9GQpLaSv5f7jEcXgPd49F9J3qlMo
 Ryajem3ADGByY0xD7PleJ9at3/2z7UQY2O1O0eF4Z8j8DjO14It1+pd9mCrWFYCbYMCq
 mc+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCJPrPcj4SYuLmaSzWUuCRP5HKzAw94e3tyTo7QD84oDQHv1oOQgMFHYWLd2ZaGq7Ru1CLb3uU@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/R41zJL3XIH6/sp+K054EuLwb57XJlv71/uw+2fReH8+DZIuD
 qQ7YV4qUOV+MSdId8NqRmQaaSoJfnmdwv+03PrJdrJKT3uf81uhMBJk9
X-Gm-Gg: AZuq6aIcqISDebUTvJRSQR83Ihoz6JHacPkmzQTqXHUoXgB6TDilmXzfqmQRcWuJKmn
 3xIZdLIdrgFSlct2Qoh/akrVnVQK0voDxxxZDKP9X6nerrASQjD3fjpCEe9rpcXkRhVGSo+37q1
 Kcs7HRXpShP3pCH0jbDunxEhgkCXA0iVLJQO1kjfztke8z2mgTKafsig054ilFKZJ11I4tS7o/K
 +aj5OjMQwkri1Sagc657KVXUptAggHv9naZHIGVEjzgzOpSi9XCvPIqMLIRWptvKjwhx82wgo6K
 GLy6zbSeJmTa+DVgtrKicTWKxUNCWGuTbgejTQtW+4j2Yz1dkIO9FsjuQ0vkLnovATSrP2Bq2et
 T879dQJFYE0FZb42cHk2aWi/rJgFi15r9OTi2ax5m4upgfxnJNKJIvdbVbLAMJuihyI2T656vFj
 EZtIcb36fmsXMIDpzPJuCPF1s=
X-Received: by 2002:a05:600c:138d:b0:47e:e5c5:f3a3 with SMTP id
 5b1f17b1804b1-482db493a03mr168586795e9.24.1770036715356; 
 Mon, 02 Feb 2026 04:51:55 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1570:8200:7824:9bef:268:2d37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482da6a042csm126165535e9.0.2026.02.02.04.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:51:54 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/9] drm/amdgpu: rework amdgpu_userq_wait_ioctl v2
Date: Mon,  2 Feb 2026 13:51:47 +0100
Message-ID: <20260202125149.2067-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202125149.2067-1-christian.koenig@amd.com>
References: <20260202125149.2067-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 614 +++++++++---------
 1 file changed, 319 insertions(+), 295 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 212056d4ddf0..da329d00843b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -645,368 +645,397 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
-	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
-	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
-	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
-	struct drm_amdgpu_userq_wait *wait_info = data;
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
-	struct amdgpu_usermode_queue *waitq;
-	struct drm_gem_object **gobj_write;
-	struct drm_gem_object **gobj_read;
-	struct dma_fence **fences = NULL;
-	u16 num_points, num_fences = 0;
-	int r, i, rentry, wentry, cnt;
+	int num_read_bo_handles, num_write_bo_handles;
+	struct dma_fence_unwrap iter;
+	struct dma_fence *fence, *f;
+	unsigned int num_fences = 0;
 	struct drm_exec exec;
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
 
-	if (!amdgpu_userq_enabled(dev))
-		return -ENOTSUPP;
+		dma_fence_put(fence);
+	}
 
-	num_read_bo_handles = wait_info->num_bo_read_handles;
-	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
-				      size_mul(sizeof(u32), num_read_bo_handles));
-	if (IS_ERR(bo_handles_read))
-		return PTR_ERR(bo_handles_read);
+	/* Count boolean fences */
+	for (i = 0; i < wait_info->num_syncobj_handles; i++) {
+		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
+					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+					   &fence);
+		if (r)
+			return r;
 
-	num_write_bo_handles = wait_info->num_bo_write_handles;
-	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
-				       size_mul(sizeof(u32), num_write_bo_handles));
-	if (IS_ERR(bo_handles_write)) {
-		r = PTR_ERR(bo_handles_write);
-		goto free_bo_handles_read;
+		num_fences++;
+		dma_fence_put(fence);
 	}
 
-	num_syncobj = wait_info->num_syncobj_handles;
-	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
-				      size_mul(sizeof(u32), num_syncobj));
-	if (IS_ERR(syncobj_handles)) {
-		r = PTR_ERR(syncobj_handles);
-		goto free_bo_handles_write;
-	}
+	/* Lock all the GEM objects */
+	/* TODO: It is actually not necessary to lock them */
+	num_read_bo_handles = wait_info->num_bo_read_handles;
+	num_write_bo_handles = wait_info->num_bo_write_handles;
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+		      num_read_bo_handles + num_write_bo_handles);
 
-	num_points = wait_info->num_syncobj_timeline_handles;
-	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
-				       sizeof(u32) * num_points);
-	if (IS_ERR(timeline_handles)) {
-		r = PTR_ERR(timeline_handles);
-		goto free_syncobj_handles;
-	}
+	drm_exec_until_all_locked(&exec) {
+		r = drm_exec_prepare_array(&exec, gobj_read,
+					   num_read_bo_handles, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto error_unlock;
 
-	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
-				      sizeof(u32) * num_points);
-	if (IS_ERR(timeline_points)) {
-		r = PTR_ERR(timeline_points);
-		goto free_timeline_handles;
+		r = drm_exec_prepare_array(&exec, gobj_write,
+					   num_write_bo_handles, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto error_unlock;
 	}
 
-	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
-	if (!gobj_read) {
-		r = -ENOMEM;
-		goto free_timeline_points;
-	}
+	/* Count read fences */
+	for (i = 0; i < num_read_bo_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+		struct dma_fence *fence;
 
-	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
-		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
-		if (!gobj_read[rentry]) {
-			r = -ENOENT;
-			goto put_gobj_read;
-		}
+		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
+					DMA_RESV_USAGE_READ, fence)
+			num_fences++;
 	}
 
-	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
-	if (!gobj_write) {
-		r = -ENOMEM;
-		goto put_gobj_read;
-	}
+	/* Count write fences */
+	for (i = 0; i < num_write_bo_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+		struct dma_fence *fence;
 
-	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
-		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
-		if (!gobj_write[wentry]) {
-			r = -ENOENT;
-			goto put_gobj_write;
-		}
+		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
+					DMA_RESV_USAGE_WRITE, fence)
+			num_fences++;
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
-		      (num_read_bo_handles + num_write_bo_handles));
-
-	/* Lock all BOs with retry handling */
-	drm_exec_until_all_locked(&exec) {
-		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			drm_exec_fini(&exec);
-			goto put_gobj_write;
-		}
+	wait_info->num_fences = num_fences;
+	r = 0;
 
-		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
-		drm_exec_retry_on_contention(&exec);
-		if (r) {
-			drm_exec_fini(&exec);
-			goto put_gobj_write;
-		}
-	}
+error_unlock:
+	/* Unlock all the GEM objects */
+	drm_exec_fini(&exec);
+	return r;
+}
 
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
 
-		/* Count syncobj's fence */
-		for (i = 0; i < num_syncobj; i++) {
-			struct dma_fence *fence;
+	fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info),
+				   GFP_KERNEL);
+	if (!fence_info)
+		return -ENOMEM;
 
-			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
-						   0,
-						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
-						   &fence);
-			if (r)
-				goto exec_fini;
+	fences = kmalloc_array(wait_info->num_fences, sizeof(*fences),
+			       GFP_KERNEL);
+	if (!fences) {
+		r = -ENOMEM;
+		goto free_fence_info;
+	}
 
-			num_fences++;
-			dma_fence_put(fence);
-		}
+	/* Retrieve timeline fences */
+	num_points = wait_info->num_syncobj_timeline_handles;
+	for (i = 0; i < num_points; i++) {
+		r = drm_syncobj_find_fence(filp, timeline_handles[i],
+					   timeline_points[i],
+					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+					   &fence);
+		if (r)
+			goto free_fences;
 
-		/* Count GEM objects fence */
-		for (i = 0; i < num_read_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
+		dma_fence_unwrap_for_each(f, &iter, fence) {
+			if (num_fences >= wait_info->num_fences) {
+				r = -EINVAL;
+				goto free_fences;
+			}
 
-			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
-						DMA_RESV_USAGE_READ, fence)
-				num_fences++;
+			fences[num_fences++] = dma_fence_get(f);
 		}
 
-		for (i = 0; i < num_write_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
+		dma_fence_put(fence);
+	}
 
-			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
-						DMA_RESV_USAGE_WRITE, fence)
-				num_fences++;
-		}
+	/* Retrieve boolean fences */
+	num_syncobj = wait_info->num_syncobj_handles;
+	for (i = 0; i < num_syncobj; i++) {
+		struct dma_fence *fence;
 
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
+		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
+					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+					   &fence);
+		if (r)
+			goto free_fences;
 
-		/* Array of fences */
-		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
-		if (!fences) {
-			r = -ENOMEM;
-			goto free_fence_info;
+		if (num_fences >= wait_info->num_fences) {
+			r = -EINVAL;
+			goto free_fences;
 		}
 
-		/* Retrieve GEM read objects fence */
-		for (i = 0; i < num_read_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
+		/* Give the reference to the fence array */
+		fences[num_fences++] = fence;
+	}
 
-			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
-						DMA_RESV_USAGE_READ, fence) {
-				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
-					r = -EINVAL;
-					goto free_fences;
-				}
+	/* Lock all the GEM objects */
+	num_read_bo_handles = wait_info->num_bo_read_handles;
+	num_write_bo_handles = wait_info->num_bo_write_handles;
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+		      num_read_bo_handles + num_write_bo_handles);
 
-				fences[num_fences++] = fence;
-				dma_fence_get(fence);
-			}
-		}
+	drm_exec_until_all_locked(&exec) {
+		r = drm_exec_prepare_array(&exec, gobj_read,
+					   num_read_bo_handles, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto error_unlock;
 
-		/* Retrieve GEM write objects fence */
-		for (i = 0; i < num_write_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
+		r = drm_exec_prepare_array(&exec, gobj_write,
+					   num_write_bo_handles, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto error_unlock;
+	}
 
-			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
-						DMA_RESV_USAGE_WRITE, fence) {
-				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
-					r = -EINVAL;
-					goto free_fences;
-				}
+	/* Retrieve GEM read objects fence */
+	for (i = 0; i < num_read_bo_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+		struct dma_fence *fence;
 
-				fences[num_fences++] = fence;
-				dma_fence_get(fence);
+		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
+					DMA_RESV_USAGE_READ, fence) {
+			if (num_fences >= wait_info->num_fences) {
+				r = -EINVAL;
+				goto error_unlock;
 			}
-		}
 
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
-					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
-						r = -EINVAL;
-						goto free_fences;
-					}
-
-					dma_fence_get(f);
-					fences[num_fences++] = f;
-				}
-
-				dma_fence_put(fence);
-			}
+			fences[num_fences++] = dma_fence_get(fence);
 		}
+	}
 
-		/* Retrieve syncobj's fence */
-		for (i = 0; i < num_syncobj; i++) {
-			struct dma_fence *fence;
-
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
 
-			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
+					DMA_RESV_USAGE_WRITE, fence) {
+			if (num_fences >= wait_info->num_fences) {
 				r = -EINVAL;
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
 
-		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
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
-				if (r) {
-					dma_fence_put(fences[i]);
-					goto free_fences;
-				}
+	waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
+	if (!waitq) {
+		r = -EINVAL;
+		goto free_fences;
+	}
 
-				dma_fence_put(fences[i]);
-				continue;
-			}
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
-			if (r)
+			r = dma_fence_wait(fences[i], true);
+			if (r) {
+				dma_fence_put(fences[i]);
 				goto free_fences;
-
-			amdgpu_userq_fence_driver_get(fence_drv);
-
-			/* Store drm syncobj's gpu va address and value */
-			fence_info[cnt].va = fence_drv->va;
-			fence_info[cnt].value = fences[i]->seqno;
+			}
 
 			dma_fence_put(fences[i]);
-			/* Increment the actual userq fence count */
-			cnt++;
+			continue;
 		}
 
-		wait_info->num_fences = cnt;
-		/* Copy userq fence info to user space */
-		if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
-				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
-			r = -EFAULT;
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
 			goto free_fences;
-		}
 
-		kfree(fences);
-		kfree(fence_info);
-	}
+		amdgpu_userq_fence_driver_get(fence_drv);
 
-	drm_exec_fini(&exec);
-	for (i = 0; i < num_read_bo_handles; i++)
-		drm_gem_object_put(gobj_read[i]);
-	kfree(gobj_read);
+		/* Store drm syncobj's gpu va address and value */
+		fence_info[cnt].va = fence_drv->va;
+		fence_info[cnt].value = fences[i]->seqno;
 
-	for (i = 0; i < num_write_bo_handles; i++)
-		drm_gem_object_put(gobj_write[i]);
-	kfree(gobj_write);
+		dma_fence_put(fences[i]);
+		/* Increment the actual userq fence count */
+		cnt++;
+	}
+	/* The refcount in the array is already decremented */
+	num_fences = 0;
 
-	kfree(timeline_points);
-	kfree(timeline_handles);
-	kfree(syncobj_handles);
-	kfree(bo_handles_write);
-	kfree(bo_handles_read);
+	wait_info->num_fences = cnt;
+	r = 0;
 
-	return 0;
+	/* Copy userq fence info to user space */
+	if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
+			 fence_info, cnt * sizeof(*fence_info))) {
+		r = -EFAULT;
+	}
 
 free_fences:
-	while (num_fences-- > 0)
+	while (num_fences--)
 		dma_fence_put(fences[num_fences]);
 	kfree(fences);
+
 free_fence_info:
 	kfree(fence_info);
-exec_fini:
+	return r;
+
+error_unlock:
 	drm_exec_fini(&exec);
-put_gobj_write:
-	while (wentry-- > 0)
-		drm_gem_object_put(gobj_write[wentry]);
+	goto free_fences;
+}
+
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
+	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read),
+				  GFP_KERNEL);
+	if (!gobj_read) {
+		r = -ENOMEM;
+		goto free_timeline_points;
+	}
+
+	ptr = u64_to_user_ptr(wait_info->bo_read_handles);
+	num_read_bo_handles = wait_info->num_bo_read_handles;
+	r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
+	if (r)
+		goto free_timeline_points;
+
+	ptr = u64_to_user_ptr(wait_info->bo_write_handles);
+	num_write_bo_handles = wait_info->num_bo_write_handles;
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
 	kfree(gobj_write);
 put_gobj_read:
-	while (rentry-- > 0)
-		drm_gem_object_put(gobj_read[rentry]);
+	while (num_read_bo_handles--)
+		drm_gem_object_put(gobj_read[num_read_bo_handles]);
 	kfree(gobj_read);
 free_timeline_points:
 	kfree(timeline_points);
@@ -1014,10 +1043,5 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	kfree(timeline_handles);
 free_syncobj_handles:
 	kfree(syncobj_handles);
-free_bo_handles_write:
-	kfree(bo_handles_write);
-free_bo_handles_read:
-	kfree(bo_handles_read);
-
 	return r;
 }
-- 
2.43.0

