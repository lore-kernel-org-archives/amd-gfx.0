Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D699D61015
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 12:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F2D10E85D;
	Thu, 29 Jan 2026 12:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RPY3ffVE";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28ABE10E858
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 12:53:34 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so899761f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769691213; x=1770296013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uWgtkxdiNH4osi87H+xrRs8TSvOqUOfbPdH5A42i57U=;
 b=RPY3ffVETMSRQQJt5XBSkd7v+P6IDBM38vO+CdOpfR6E8W0LwXyDK2DLIxM7zclnZm
 xDVHPZpE/OFPAV5BmBM1v107cUC0Ty6ysUJ69FbhyEzJm1qsEiz5LpF/AyUcAsAn0NnX
 7NWKQuKopHmpnLb78jv6ZVqAzCSBvvoWKAcYQEmSgAWtjIm2rjdiYEJSBtQiVmHCoyMG
 oqjyZoduFpkHBAs9OHK5UZ6HPsvoHpW9xLK9GSGLz8i8xdDSNmOYYw1K0ZzP6N4kp5zs
 Jq+hQd8x70tFY6IVtHTUm4j78w/fyVY7X4qoYXBQFgzetRLVol3HIuHE2+6fM0KaPS75
 hzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769691213; x=1770296013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uWgtkxdiNH4osi87H+xrRs8TSvOqUOfbPdH5A42i57U=;
 b=Gr4ElhlKBeZNGchjQMxEm+MYIxO1gOh9iZgdK6AG45MeIJZ6T7oeIj58u6rWlJDR46
 +EIu/KVQ3d2w44F2A4l/qxpyPx6zcCGNYxjUXeQnDIpdBo2byF+KqbXldNG3Krl605JG
 4RETvLeQg1sKaNpFEj3jYm44W3osu6SGYevhitikyK3OKrGIA6FxNROuCDkr1yZfgKyo
 ARAHb8GfmrrmCe0psd3PWO5Ud6SdHCG4yijwE214KZH0rdjHcCtqsUGVjvGzca5y97TH
 FSPGnl4nhBxA+a5lpqDe5pI7Cl3d4I5CtIGsWnnxkNneT257img0b9ofnGT0DgFYDLCD
 xsKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYkNcBkJW3HerPvD32ZrDREe3Rv6nOMsLV/WMOcA1sk79wbedIWCWDZqUmaTt2W4R/0XoXWbp1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOwEnpuxixgZq6moacUwInKMik6U1grkaKKAE70ro++xtHM1qG
 rJY6twC9ivpweA5tDQCBAK3niRvpUGija52MBGr1ETVMfY8tH4/LGegV
X-Gm-Gg: AZuq6aLWJqk/f2BC/dGUp/JaLmjsAVYmpth/uZW87SKpPEDo4U8MntkNQ6P25g1bl/9
 MjKuab/N/5PlWE8+LObXuiC98HlFQ6cy1UHu9trl0Tdvilq2AWV8g/aX9QT8luh5HUK7wuz4SoH
 U6MWPyvhBjzRlKxG8kfpBF9iya9a/ET1Swdz551bOZkroWh9bfbMwkihr5UUo2z8Z8MOOi6AcSm
 JseQv2y7tG2YI1Pi3MQC3yqdMz0peqE26QE31EXXExLF0/ewtLAMswg3u7sTwokjfyMrDnw3BVj
 EWmAGIbseRVnbwBHA3TpIjcwzCjyiP7gwpXnMrZI3ay0llnRt9RGG1clf2e6geEZcbtErK4p36K
 lOnYEsydcfmGH/Y0TIhkL7KAkbQ7gvwCpPiMpPdqJ17EzZ8mb1ryHIXV51kg2g/io564cc/OmSG
 qARwK/wMjKvXuIJuxDLavBopaa
X-Received: by 2002:a05:6000:2001:b0:430:f7dc:7e96 with SMTP id
 ffacd0b85a97d-435dd1ce0c8mr12510299f8f.48.1769691212317; 
 Thu, 29 Jan 2026 04:53:32 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1522:e200:97e2:f9c5:ae8b:8e89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354114sm15442569f8f.42.2026.01.29.04.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 04:53:31 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amdgpu: rework amdgpu_userq_wait_ioctl
Date: Thu, 29 Jan 2026 13:53:26 +0100
Message-ID: <20260129125327.11786-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129125327.11786-1-christian.koenig@amd.com>
References: <20260129125327.11786-1-christian.koenig@amd.com>
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
consistenly use memdup_array_user(), fix the lock inversions, a few
more bugs in error handling and a leak of dma_fence references.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 633 ++++++++++--------
 1 file changed, 349 insertions(+), 284 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 212056d4ddf0..ee8a5fbbd53b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -645,361 +645,426 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
+		fences[num_fences++] = fence;
+		dma_fence_put(fence);
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
+			fences[num_fences++] = fence;
+			dma_fence_get(fence);
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
 
 			fences[num_fences++] = fence;
+			dma_fence_get(fence);
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
+	goto free_fences;
+}
+
+
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp)
+{
+	int num_points, num_syncobj, num_read_bo_handles, num_write_bo_handles;
+	u32 *syncobj_handles, *timeline_points, *timeline_handles,
+	    *bo_handles_read, *bo_handles_write;
+	struct drm_amdgpu_userq_wait *wait_info = data;
+	struct drm_gem_object **gobj_write;
+	struct drm_gem_object **gobj_read;
+	int r, rentry, wentry;
+	void __user *ptr;
+
+	if (!amdgpu_userq_enabled(dev))
+		return -ENOTSUPP;
+
+	ptr = u64_to_user_ptr(wait_info->bo_read_handles);
+	num_read_bo_handles = wait_info->num_bo_read_handles;
+	bo_handles_read = memdup_array_user(ptr, num_read_bo_handles,
+					    sizeof(u32));
+	if (IS_ERR(bo_handles_read))
+		return PTR_ERR(bo_handles_read);
+
+	ptr = u64_to_user_ptr(wait_info->bo_write_handles);
+	num_write_bo_handles = wait_info->num_bo_write_handles;
+	bo_handles_write = memdup_array_user(ptr, num_write_bo_handles,
+					     sizeof(u32));
+	if (IS_ERR(bo_handles_write)) {
+		r = PTR_ERR(bo_handles_write);
+		goto free_bo_handles_read;
+	}
+
+	num_syncobj = wait_info->num_syncobj_handles;
+	ptr = u64_to_user_ptr(wait_info->syncobj_handles);
+	syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
+	if (IS_ERR(syncobj_handles)) {
+		r = PTR_ERR(syncobj_handles);
+		goto free_bo_handles_write;
+	}
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
+	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
+		u32 handle = bo_handles_read[rentry];
+
+		gobj_read[rentry] = drm_gem_object_lookup(filp, handle);
+		if (!gobj_read[rentry]) {
+			r = -ENOENT;
+			goto put_gobj_read;
+		}
+	}
+
+	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write),
+				   GFP_KERNEL);
+	if (!gobj_write) {
+		r = -ENOMEM;
+		goto put_gobj_read;
+	}
+
+	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
+		u32 handle = bo_handles_write[wentry];
+
+		gobj_write[wentry] = drm_gem_object_lookup(filp, handle);
+		if (!gobj_write[wentry]) {
+			r = -ENOENT;
+			goto put_gobj_write;
+		}
+	}
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
 put_gobj_write:
 	while (wentry-- > 0)
 		drm_gem_object_put(gobj_write[wentry]);
-- 
2.43.0

