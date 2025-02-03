Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FA6C02194
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 11:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED8C10E49B;
	Mon,  3 Feb 2025 11:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mxJXs7jv";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB4210E495
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 11:58:50 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso3617063f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Feb 2025 03:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738583929; x=1739188729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Px8wg6JGeS1mce8gdB6ndNjJyi9HHPV6cZ1oWl0zb2s=;
 b=mxJXs7jvNCOzLhbb2LeKOZGjiwF8MUoun5i5pLuYEvycs35YyjCANuwKf+2Nt9UZaH
 MleM9IjaB2WBf5Ea7l/nfoYEL3Ipg3Ed37oxBOInEJ6P6WFluqB3MZp4h27FSTsybpAJ
 E8pCUWjpinIr0s2MKKVabSz7VHySk+ZalOUN3FHJPpYQrGIZDUeR20HyaQ5OqDu/eDdu
 nY1XBv3fg8OKjGKuUByQL1AJTmbstG4BE6aDhrcKkGrwq7gGOzVTC2Yy9dLQy2JvbSZu
 uyinpWKM6YMs6pTiiMlLgj5yUEbqIT6+4cF0JjTfbmeoEKj4l8e0eU6+zVtG+D5/OkYd
 NWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738583929; x=1739188729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Px8wg6JGeS1mce8gdB6ndNjJyi9HHPV6cZ1oWl0zb2s=;
 b=NI7surDiQ+LHNC+iEHbXoQPyQXsrrr0qeDFeTS35pyRmQ3djDsCuNI/BsOUVcHgc06
 EeP8mm5IiVslCdQhS/DJZKGpn/f+xlOoI+63HsXd760Dt76LdRwKFwbJmnW7VMHJSlo3
 bEhWy4LtiPbsx9IZeBfyrvX2voHfT2ntbGRoKtPU1RNrgVYbn7bALegIGtkiT3i481ps
 DUgmnus93KHY5Rbh+mddMc7TdRRUKi5gkgq6LM6brsRGpD5W9yUAnE5v8i3CbdAAFf1s
 5ktniYPjcAhGPg+VKj5OeQIO15oiMnDrFe3StxrjAt3cl8eG+lRlypRyD7tdNBFP5Emi
 sdwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjWyx1NwMHV3TKDbf5mC+fYzGy84v8dH/Lzws3tEe6TKOtWBlmticfJ2o5iobJJgntHJwFNpSV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyL8EOm1OKRL9fYbiHd1RemAoAFbdL+h11ppRVg2iZOJlZKlJM
 kY/NgnJPOiAARe48Ne1xrdsZtWA3iHG7AoipLmmRAlruY9uKbiNL
X-Gm-Gg: ASbGncuH8Jm4fH/XquZ+TkjQCnmJRhTRwrvvMEsPWCYFb8SoF433gVC2QbtWwbFQuS3
 PoH5TG7hMpsgKI+/HS5CPTtstUYrmyNTJQjNKQ8CLGqtODwaz/WDN6nDfPmsg/WZAyBTtyCEEAO
 Ndz3MeyDxaCtiYxafjaJKmD6kGmOYW3zYxJrJXf7c+P7Bd4hzsU8nQ5oabdCs5m6IZrS+o3+C5V
 8b5ydsvcTqjHbdk2QU9kqeR0a2yeZQH2u1QqYwjNuK29iD/deLHW7k1EFsOKp2+QEQjNlhwGjCH
 z5go/UhfQXOJ/Beqb9nuioQRdck=
X-Google-Smtp-Source: AGHT+IFukXAGn/d6I5Dgj7Cf1tji662J0LRNuX0SKYiif7E3/lGrSidiLI3iQOM7IUGlrh/yCi2rrQ==
X-Received: by 2002:adf:f943:0:b0:385:f996:1b8e with SMTP id
 ffacd0b85a97d-38c51951006mr18459988f8f.16.1738583928681; 
 Mon, 03 Feb 2025 03:58:48 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15c2:700:903a:ba89:5ce0:8312])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1017besm12298928f8f.26.2025.02.03.03.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 03:58:48 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH 2/6] drm/amdgpu: use GFP_NOWAIT for memory allocations
Date: Mon,  3 Feb 2025 12:58:42 +0100
Message-Id: <20250203115846.13142-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203115846.13142-1-christian.koenig@amd.com>
References: <20250203115846.13142-1-christian.koenig@amd.com>
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

In the critical submission path memory allocations can't wait for
reclaim since that can potentially wait for submissions to finish.

Finally clean that up and mark most memory allocations in the critical
path with GFP_NOWAIT. The only exception left is the dma_fence_array()
used when no VMID is available, but that will be cleaned up later on.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c         | 18 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c        | 11 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c       | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h       |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c   |  4 ++--
 7 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2b4d3840e5bc..cb819919192a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -499,7 +499,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
 	if (ret)
 		return ret;
 
-	return amdgpu_sync_fence(sync, vm->last_update);
+	return amdgpu_sync_fence(sync, vm->last_update, GFP_KERNEL);
 }
 
 static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
@@ -1263,7 +1263,7 @@ static int unmap_bo_from_gpuvm(struct kgd_mem *mem,
 
 	(void)amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
 
-	(void)amdgpu_sync_fence(sync, bo_va->last_pt_update);
+	(void)amdgpu_sync_fence(sync, bo_va->last_pt_update, GFP_KERNEL);
 
 	return 0;
 }
@@ -1287,7 +1287,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 		return ret;
 	}
 
-	return amdgpu_sync_fence(sync, bo_va->last_pt_update);
+	return amdgpu_sync_fence(sync, bo_va->last_pt_update, GFP_KERNEL);
 }
 
 static int map_bo_to_gpuvm(struct kgd_mem *mem,
@@ -2948,7 +2948,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 		}
 		dma_resv_for_each_fence(&cursor, bo->tbo.base.resv,
 					DMA_RESV_USAGE_KERNEL, fence) {
-			ret = amdgpu_sync_fence(&sync_obj, fence);
+			ret = amdgpu_sync_fence(&sync_obj, fence, GFP_KERNEL);
 			if (ret) {
 				pr_debug("Memory eviction: Sync BO fence failed. Try again\n");
 				goto validate_map_fail;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5df21529b3b1..2ce0c6a152a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -428,7 +428,7 @@ static int amdgpu_cs_p2_dependencies(struct amdgpu_cs_parser *p,
 			dma_fence_put(old);
 		}
 
-		r = amdgpu_sync_fence(&p->sync, fence);
+		r = amdgpu_sync_fence(&p->sync, fence, GFP_KERNEL);
 		dma_fence_put(fence);
 		if (r)
 			return r;
@@ -450,7 +450,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
 		return r;
 	}
 
-	r = amdgpu_sync_fence(&p->sync, fence);
+	r = amdgpu_sync_fence(&p->sync, fence, GFP_KERNEL);
 	dma_fence_put(fence);
 	return r;
 }
@@ -1124,7 +1124,8 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_sync_fence(&p->sync, fpriv->prt_va->last_pt_update);
+	r = amdgpu_sync_fence(&p->sync, fpriv->prt_va->last_pt_update,
+			      GFP_KERNEL);
 	if (r)
 		return r;
 
@@ -1135,7 +1136,8 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (r)
 			return r;
 
-		r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update);
+		r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
+				      GFP_KERNEL);
 		if (r)
 			return r;
 	}
@@ -1154,7 +1156,8 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (r)
 			return r;
 
-		r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update);
+		r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
+				      GFP_KERNEL);
 		if (r)
 			return r;
 	}
@@ -1167,7 +1170,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_sync_fence(&p->sync, vm->last_update);
+	r = amdgpu_sync_fence(&p->sync, vm->last_update, GFP_KERNEL);
 	if (r)
 		return r;
 
@@ -1248,7 +1251,8 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 			continue;
 		}
 
-		r = amdgpu_sync_fence(&p->gang_leader->explicit_sync, fence);
+		r = amdgpu_sync_fence(&p->gang_leader->explicit_sync, fence,
+				      GFP_KERNEL);
 		dma_fence_put(fence);
 		if (r)
 			return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 8e712a11aba5..56d27cea052e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -209,7 +209,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_ring *ring,
 		return 0;
 	}
 
-	fences = kmalloc_array(id_mgr->num_ids, sizeof(void *), GFP_KERNEL);
+	fences = kmalloc_array(id_mgr->num_ids, sizeof(void *), GFP_NOWAIT);
 	if (!fences)
 		return -ENOMEM;
 
@@ -326,7 +326,8 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	/* Good we can use this VMID. Remember this submission as
 	* user of the VMID.
 	*/
-	r = amdgpu_sync_fence(&(*id)->active, &job->base.s_fence->finished);
+	r = amdgpu_sync_fence(&(*id)->active, &job->base.s_fence->finished,
+			      GFP_NOWAIT);
 	if (r)
 		return r;
 
@@ -385,7 +386,8 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 		 * user of the VMID.
 		 */
 		r = amdgpu_sync_fence(&(*id)->active,
-				      &job->base.s_fence->finished);
+				      &job->base.s_fence->finished,
+				      GFP_NOWAIT);
 		if (r)
 			return r;
 
@@ -437,7 +439,8 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 
 			/* Remember this submission as user of the VMID */
 			r = amdgpu_sync_fence(&id->active,
-					      &job->base.s_fence->finished);
+					      &job->base.s_fence->finished,
+					      GFP_NOWAIT);
 			if (r)
 				goto error;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index cee38bb6cfaf..597476c441bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1332,14 +1332,14 @@ int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
 		DRM_ERROR("failed to do vm_bo_update on meta data\n");
 		goto error_del_bo_va;
 	}
-	amdgpu_sync_fence(&sync, bo_va->last_pt_update);
+	amdgpu_sync_fence(&sync, bo_va->last_pt_update, GFP_KERNEL);
 
 	r = amdgpu_vm_update_pdes(adev, vm, false);
 	if (r) {
 		DRM_ERROR("failed to update pdes on meta data\n");
 		goto error_del_bo_va;
 	}
-	amdgpu_sync_fence(&sync, vm->last_update);
+	amdgpu_sync_fence(&sync, vm->last_update, GFP_KERNEL);
 
 	amdgpu_sync_wait(&sync, false);
 	drm_exec_fini(&exec);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index c586ab4c911b..86c17a8946f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -152,7 +152,8 @@ static bool amdgpu_sync_add_later(struct amdgpu_sync *sync, struct dma_fence *f)
  *
  * Add the fence to the sync object.
  */
-int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f)
+int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f,
+		      gfp_t flags)
 {
 	struct amdgpu_sync_entry *e;
 
@@ -162,7 +163,7 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f)
 	if (amdgpu_sync_add_later(sync, f))
 		return 0;
 
-	e = kmem_cache_alloc(amdgpu_sync_slab, GFP_KERNEL);
+	e = kmem_cache_alloc(amdgpu_sync_slab, flags);
 	if (!e)
 		return -ENOMEM;
 
@@ -249,7 +250,7 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 			struct dma_fence *tmp = dma_fence_chain_contained(f);
 
 			if (amdgpu_sync_test_fence(adev, mode, owner, tmp)) {
-				r = amdgpu_sync_fence(sync, f);
+				r = amdgpu_sync_fence(sync, f, GFP_KERNEL);
 				dma_fence_put(f);
 				if (r)
 					return r;
@@ -281,7 +282,7 @@ int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv)
 		if (fence_owner != AMDGPU_FENCE_OWNER_KFD)
 			continue;
 
-		r = amdgpu_sync_fence(sync, f);
+		r = amdgpu_sync_fence(sync, f, GFP_KERNEL);
 		if (r)
 			break;
 	}
@@ -388,7 +389,7 @@ int amdgpu_sync_clone(struct amdgpu_sync *source, struct amdgpu_sync *clone)
 	hash_for_each_safe(source->fences, i, tmp, e, node) {
 		f = e->fence;
 		if (!dma_fence_is_signaled(f)) {
-			r = amdgpu_sync_fence(clone, f);
+			r = amdgpu_sync_fence(clone, f, GFP_KERNEL);
 			if (r)
 				return r;
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
index e3272dce798d..1504f5e7fc46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
@@ -47,7 +47,8 @@ struct amdgpu_sync {
 };
 
 void amdgpu_sync_create(struct amdgpu_sync *sync);
-int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f);
+int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f,
+		      gfp_t flags);
 int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
 		     void *owner);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index ba550c7e2118..3e1587c6cf34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -120,13 +120,13 @@ static int map_ring_data(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_del_bo_va;
 
-	amdgpu_sync_fence(&sync, (*bo_va)->last_pt_update);
+	amdgpu_sync_fence(&sync, (*bo_va)->last_pt_update, GFP_KERNEL);
 
 	r = amdgpu_vm_update_pdes(adev, vm, false);
 	if (r)
 		goto error_del_bo_va;
 
-	amdgpu_sync_fence(&sync, vm->last_update);
+	amdgpu_sync_fence(&sync, vm->last_update, GFP_KERNEL);
 
 	amdgpu_sync_wait(&sync, false);
 	drm_exec_fini(&exec);
-- 
2.34.1

