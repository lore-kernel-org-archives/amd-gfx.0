Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7BFD2F7F6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 13:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4409310EB3B;
	Fri,  5 Dec 2025 13:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="krg14y5e";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 119D510EB39
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UJwz6I6h8UpfTH1/qOq5REEQacvCT5FuhmZipUAejhM=; b=krg14y5eIy1HyCEL9Vyek1jvLJ
 VvNWTL/fMB120BP5zF7i8R+t8QjSvvwayFqH0AASfJNXlMllWbUt7+augkmFRUViN9pB781nSwSUY
 x73cPuHJr1jsAYJNsAlKpX/crVvDse000xEMTZpmTEmmrrJWzMg8JVXkC4TGbOeFJ213Q+Racx17H
 rZg210gHmjF9OuZGX6rGS/IgsvShdYU6fW9GsAnCXKqjaQKfIXqiW7sAJSVrE1/13wE9lw8HAj/Up
 SkKojonZheSquWhsRMIaWLJ04MbgpPahvUBnrkMjz8JrBn4J99m4MPBz9TUF3FOw2lYfLSfJKEISx
 HbQUziMA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vRW39-0095hG-Bs; Fri, 05 Dec 2025 14:40:43 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 08/12] drm/amdgpu/userq: Consolidate fence lookup in
 amdgpu_userq_wait_ioctl
Date: Fri,  5 Dec 2025 13:40:31 +0000
Message-ID: <20251205134035.91551-9-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
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

Extract and consolidate the fence walking loops into a single helper with
the goal of making the flow in the main ioctl function body a bit more
readable.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 382 +++++++++---------
 1 file changed, 184 insertions(+), 198 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 6bddba2d8ba1..11992d05f8d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -599,21 +599,122 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+static int
+__add_fence(struct dma_fence **fences, unsigned int max_fences, int *num_fences,
+	    struct dma_fence *fence)
+{
+	if (fences) {
+		if (*num_fences >= max_fences)
+			return -EINVAL;
+
+		fences[*num_fences] = dma_fence_get(fence);
+	}
+
+	++*num_fences;
+
+	return 0;
+}
+
+static int
+__get_fences(struct drm_file *filp,
+	     struct drm_gem_object **obj_read, unsigned int num_read_handles,
+	     struct drm_gem_object **obj_write, unsigned int num_write_handles,
+	     u32 *tl_handles, u32 *tl_pts, unsigned int num_points,
+	     u32 *syncobjs, unsigned int num_syncobjs,
+	     struct dma_fence **fences, unsigned int max_fences)
+{
+	struct dma_fence *fence;
+	int num_fences = 0;
+	unsigned int i;
+	int r;
+
+	/* Retrieve GEM read objects fences */
+	for (i = 0; i < num_read_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+
+		dma_resv_for_each_fence(&resv_cursor, obj_read[i]->resv,
+					DMA_RESV_USAGE_READ, fence) {
+			r = __add_fence(fences, max_fences, &num_fences, fence);
+			if (r)
+				goto put_fences;
+		}
+	}
+
+	/* Retrieve GEM write objects fences */
+	for (i = 0; i < num_write_handles; i++) {
+		struct dma_resv_iter resv_cursor;
+
+		dma_resv_for_each_fence(&resv_cursor, obj_write[i]->resv,
+					DMA_RESV_USAGE_WRITE, fence) {
+			r = __add_fence(fences, max_fences, &num_fences, fence);
+			if (r)
+				goto put_fences;
+		}
+	}
+
+	if (num_points) {
+		for (i = 0; i < num_points; i++) {
+			struct dma_fence_unwrap iter;
+			struct dma_fence *f;
+
+			r = drm_syncobj_find_fence(filp, tl_handles[i],
+						   tl_pts[i],
+						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+						   &fence);
+			if (r)
+				goto put_fences;
+
+			dma_fence_unwrap_for_each(f, &iter, fence) {
+				r = __add_fence(fences, max_fences, &num_fences, f);
+				if (r) {
+					dma_fence_put(fence);
+					goto put_fences;
+				}
+			}
+
+			dma_fence_put(fence);
+		}
+	}
+
+	/* Retrieve syncobj's fences */
+	for (i = 0; i < num_syncobjs; i++) {
+		r = drm_syncobj_find_fence(filp, syncobjs[i], 0,
+					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+					   &fence);
+		if (r)
+			goto put_fences;
+
+		r = __add_fence(fences, max_fences, &num_fences, fence);
+		dma_fence_put(fence);
+		if (r)
+			goto put_fences;
+	}
+
+	return num_fences;
+
+put_fences:
+	for (i = 0; i < num_fences; i++)
+		dma_fence_put(fences[i]);
+
+	return r;
+}
+
 int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
 	struct drm_amdgpu_userq_wait *wait_info = data;
 	const unsigned int num_write_bo_handles = wait_info->num_bo_write_handles;
 	const unsigned int num_read_bo_handles = wait_info->num_bo_read_handles;
-	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
+	unsigned int num_fences = wait_info->num_fences;
+	struct drm_amdgpu_userq_fence_info *fence_info;
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
 	struct drm_gem_object **gobj_write, **gobj_read;
 	u32 *timeline_points, *timeline_handles;
 	struct amdgpu_usermode_queue *waitq;
 	u32 *syncobj_handles, num_syncobj;
-	struct dma_fence **fences = NULL;
-	u16 num_points, num_fences = 0;
+	struct dma_fence **fences;
+	unsigned int num_points;
 	struct drm_exec exec;
 	int r, i, cnt;
 
@@ -672,230 +773,115 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		}
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
-
-		/* Count syncobj's fence */
-		for (i = 0; i < num_syncobj; i++) {
-			struct dma_fence *fence;
-
-			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
-						   0,
-						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
-						   &fence);
-			if (r)
-				goto exec_fini;
-
-			num_fences++;
-			dma_fence_put(fence);
-		}
-
-		/* Count GEM objects fence */
-		for (i = 0; i < num_read_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
-
-			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
-						DMA_RESV_USAGE_READ, fence)
-				num_fences++;
-		}
-
-		for (i = 0; i < num_write_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
-
-			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
-						DMA_RESV_USAGE_WRITE, fence)
-				num_fences++;
-		}
-
-		/*
-		 * Passing num_fences = 0 means that userspace doesn't want to
-		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
-		 * userq_fence_info and return the actual number of fences on
-		 * args->num_fences.
-		 */
-		wait_info->num_fences = num_fences;
-	} else {
+	if (num_fences) {
 		/* Array of fence info */
-		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
+		fence_info = kmalloc_array(num_fences, sizeof(*fence_info), GFP_KERNEL);
 		if (!fence_info) {
 			r = -ENOMEM;
 			goto exec_fini;
 		}
 
 		/* Array of fences */
-		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
+		fences = kmalloc_array(num_fences, sizeof(*fences), GFP_KERNEL);
 		if (!fences) {
 			r = -ENOMEM;
 			goto free_fence_info;
 		}
-
-		/* Retrieve GEM read objects fence */
-		for (i = 0; i < num_read_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
-
-			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
-						DMA_RESV_USAGE_READ, fence) {
-				if (num_fences >= wait_info->num_fences) {
-					r = -EINVAL;
-					goto free_fences;
-				}
-
-				fences[num_fences++] = fence;
-				dma_fence_get(fence);
-			}
-		}
-
-		/* Retrieve GEM write objects fence */
-		for (i = 0; i < num_write_bo_handles; i++) {
-			struct dma_resv_iter resv_cursor;
-			struct dma_fence *fence;
-
-			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
-						DMA_RESV_USAGE_WRITE, fence) {
-				if (num_fences >= wait_info->num_fences) {
-					r = -EINVAL;
-					goto free_fences;
-				}
-
-				fences[num_fences++] = fence;
-				dma_fence_get(fence);
-			}
-		}
-
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
-
-				dma_fence_put(fence);
-			}
-		}
-
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
-
-			if (num_fences >= wait_info->num_fences) {
-				r = -EINVAL;
-				dma_fence_put(fence);
-				goto free_fences;
-			}
-
-			fences[num_fences++] = fence;
+	} else {
+		fences = NULL;
+		fence_info = NULL;
+	}
+
+	r = __get_fences(filp,
+			 gobj_read, num_read_bo_handles,
+			 gobj_write, num_write_bo_handles,
+			 timeline_handles, timeline_points, num_points,
+			 syncobj_handles, num_syncobj,
+			 fences, num_fences);
+	if (!num_fences) {
+		if (r < 0) {
+			drm_err_once(dev,
+				     "Error %d while counting userq fences!\n",
+				     r);
+		} else {
+			wait_info->num_fences = r;
+			r = 0;
 		}
 
 		/*
-		 * Keep only the latest fences to reduce the number of values
-		 * given back to userspace.
+		 * Passing num_fences = 0 means that userspace doesn't want to
+		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
+		 * userq_fence_info and return the actual number of fences on
+		 * args->num_fences.
 		 */
-		num_fences = dma_fence_dedup_array(fences, num_fences);
+		goto exec_fini;
+	} else if (r < 0) {
+		num_fences = 0;
+		goto free_fences;
+	}
 
-		waitq = xa_load(&userq_mgr->userq_mgr_xa, wait_info->waitq_id);
-		if (!waitq) {
-			r = -EINVAL;
-			goto free_fences;
-		}
+	/*
+	 * Keep only the latest fences to reduce the number of values
+	 * given back to userspace.
+	 */
+	num_fences = dma_fence_dedup_array(fences, r);
+	r = 0;
 
-		for (i = 0, cnt = 0; i < num_fences; i++) {
-			struct amdgpu_userq_fence_driver *fence_drv;
-			struct amdgpu_userq_fence *userq_fence;
-			u32 index;
+	waitq = xa_load(&userq_mgr->userq_mgr_xa, wait_info->waitq_id);
+	if (!waitq) {
+		r = -EINVAL;
+		goto free_fences;
+	}
 
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
+	for (i = 0, cnt = 0; i < num_fences; i++) {
+		struct amdgpu_userq_fence_driver *fence_drv;
+		struct amdgpu_userq_fence *userq_fence;
+		u32 index;
 
-				dma_fence_put(fences[i]);
-				continue;
-			}
-
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
+
+		amdgpu_userq_fence_driver_get(fence_drv);
+
+		/* Store drm syncobj's gpu va address and value */
+		fence_info[cnt].va = fence_drv->va;
+		fence_info[cnt].value = fences[i]->seqno;
+
+		dma_fence_put(fences[i]);
+		/* Increment the actual userq fence count */
+		cnt++;
 	}
 
+	wait_info->num_fences = cnt;
+	if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
+			 fence_info, cnt * sizeof(*fence_info)))
+		r = -EFAULT;
+
 free_fences:
 	if (fences) {
 		while (num_fences-- > 0)
-- 
2.51.1

