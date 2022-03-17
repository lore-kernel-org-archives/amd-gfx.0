Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAD2C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 13:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7727A10EBD5;
	Thu, 17 Mar 2022 13:50:54 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61CFF10EBD8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 13:50:53 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id bi12so10897868ejb.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u2lI/ppNv892Dq55XFh+RxtmF67xHDY65q9bnox/QWA=;
 b=ME0p/VDd4VBGzAKpu/R9kO5n+hBZQRyHrTikz4GSRh2jS9r3TDzGeMcJB2lw6+B3fr
 G6IeF5wKvMg9i5spv/G0EkBCSnnCTBm2qDx/m3rBfz8MKPNZuFDaw2VMN88JbOCjHTR8
 /V1PW4ogWCnfED/gXn+anwTItMeBdeEzGQIIwcIBwjh2PYzSuTSekh2BjaI7m7Ag/kAu
 TV8QfI+LvymbMqKfKFjEvnVQ7NPUoHQNmwgEj32Fz1p8eWukxa/ATYc56yZaKdSNlk0Q
 IK3cMItVm3DoP2+UQBP/+JJbu6/lZz0eXpZ3uYnDARr4CAlzOxdBSjwYn4mFJ3zKqh/3
 8chQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u2lI/ppNv892Dq55XFh+RxtmF67xHDY65q9bnox/QWA=;
 b=KvsdHFLNz9hZezjhPC5gWxp+DyrbXX/cD3MvYvU0ckna2nOusj+dM6KHnP9C2PjhTf
 xVF9/7YXU0s1/A/j3CC78LUcvNb4MsDXhHLkF3HLx8J/AcwRijW8JdQ6+KRWJZUIMiwe
 oV5OrANV1paMWxWyRH9n8nkvGwkcbU1qaSBB9q8D//ozKFAvDCHhDA46m+HbAXBE43mf
 ZVgcWE1SYhWPJslS7QuI7ysfNbaePLJ1yr34qKTUkrU6PWefRqdbUV5JI+4Ax9ItqY6y
 lyRTwcKs9iCPsyHC5ZxrEHc00duuZCwGWS8vI6+iBvnXR1kWde7MNT0XUEdpz/qavqAW
 LbmA==
X-Gm-Message-State: AOAM53073GWXu7Gxao0wcs+w2r0KK2CTxGLnk0w+n71NOrrGO5iu4UHw
 BWd0eS/J459qQs+MUIGwg0dBcbBzsws=
X-Google-Smtp-Source: ABdhPJxeN1nslJUp8MHPyFtElRq+tbjqftx6Wh0s8XokYbZKyn5TMWzDHpk6gef3N2adr6cQ5zh+IQ==
X-Received: by 2002:a17:906:7948:b0:6da:64ed:178e with SMTP id
 l8-20020a170906794800b006da64ed178emr4665860ejo.523.1647525051700; 
 Thu, 17 Mar 2022 06:50:51 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056402254900b00416b0ec98b5sm2706721edb.45.2022.03.17.06.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 06:50:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix.Kuehling@amd.com
Subject: [PATCH 3/7] drm/amdgpu: simplify VM update tracking a bit
Date: Thu, 17 Mar 2022 14:50:40 +0100
Message-Id: <20220317135044.2099-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317135044.2099-1-christian.koenig@amd.com>
References: <20220317135044.2099-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Store the 64bit sequence directly. Makes it simpler to use and saves a bit
of fence reference counting overhead.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c  | 40 +++++++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c |  9 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  2 +-
 4 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index b66da1ab8dd5..b05c5fcb168d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -276,19 +276,15 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	struct amdgpu_device *adev = ring->adev;
 	unsigned vmhub = ring->funcs->vmhub;
 	uint64_t fence_context = adev->fence_context + ring->idx;
-	struct dma_fence *updates = sync->last_vm_update;
 	bool needs_flush = vm->use_cpu_for_update;
-	int r = 0;
+	uint64_t updates = sync->last_vm_update;
+	int r;
 
 	*id = vm->reserved_vmid[vmhub];
-	if (updates && (*id)->flushed_updates &&
-	    updates->context == (*id)->flushed_updates->context &&
-	    !dma_fence_is_later(updates, (*id)->flushed_updates))
-		updates = NULL;
-
 	if ((*id)->owner != vm->immediate.fence_context ||
-	    job->vm_pd_addr != (*id)->pd_gpu_addr ||
-	    updates || !(*id)->last_flush ||
+	    (*id)->pd_gpu_addr != job->vm_pd_addr ||
+	    (*id)->flushed_updates < updates ||
+	    !(*id)->last_flush ||
 	    ((*id)->last_flush->context != fence_context &&
 	     !dma_fence_is_signaled((*id)->last_flush))) {
 		struct dma_fence *tmp;
@@ -302,8 +298,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 		tmp = amdgpu_sync_peek_fence(&(*id)->active, ring);
 		if (tmp) {
 			*id = NULL;
-			r = amdgpu_sync_fence(sync, tmp);
-			return r;
+			return amdgpu_sync_fence(sync, tmp);
 		}
 		needs_flush = true;
 	}
@@ -315,10 +310,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	if (r)
 		return r;
 
-	if (updates) {
-		dma_fence_put((*id)->flushed_updates);
-		(*id)->flushed_updates = dma_fence_get(updates);
-	}
+	(*id)->flushed_updates = updates;
 	job->vm_needs_flush = needs_flush;
 	return 0;
 }
@@ -346,7 +338,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 	unsigned vmhub = ring->funcs->vmhub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	uint64_t fence_context = adev->fence_context + ring->idx;
-	struct dma_fence *updates = sync->last_vm_update;
+	uint64_t updates = sync->last_vm_update;
 	int r;
 
 	job->vm_needs_flush = vm->use_cpu_for_update;
@@ -354,7 +346,6 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 	/* Check if we can use a VMID already assigned to this VM */
 	list_for_each_entry_reverse((*id), &id_mgr->ids_lru, list) {
 		bool needs_flush = vm->use_cpu_for_update;
-		struct dma_fence *flushed;
 
 		/* Check all the prerequisites to using this VMID */
 		if ((*id)->owner != vm->immediate.fence_context)
@@ -368,8 +359,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 		     !dma_fence_is_signaled((*id)->last_flush)))
 			needs_flush = true;
 
-		flushed  = (*id)->flushed_updates;
-		if (updates && (!flushed || dma_fence_is_later(updates, flushed)))
+		if ((*id)->flushed_updates < updates)
 			needs_flush = true;
 
 		if (needs_flush && !adev->vm_manager.concurrent_flush)
@@ -382,11 +372,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 		if (r)
 			return r;
 
-		if (updates && (!flushed || dma_fence_is_later(updates, flushed))) {
-			dma_fence_put((*id)->flushed_updates);
-			(*id)->flushed_updates = dma_fence_get(updates);
-		}
-
+		(*id)->flushed_updates = updates;
 		job->vm_needs_flush |= needs_flush;
 		return 0;
 	}
@@ -432,8 +418,6 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 			goto error;
 
 		if (!id) {
-			struct dma_fence *updates = sync->last_vm_update;
-
 			/* Still no ID to use? Then use the idle one found earlier */
 			id = idle;
 
@@ -442,8 +426,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 			if (r)
 				goto error;
 
-			dma_fence_put(id->flushed_updates);
-			id->flushed_updates = dma_fence_get(updates);
+			id->flushed_updates = sync->last_vm_update;
 			job->vm_needs_flush = true;
 		}
 
@@ -610,7 +593,6 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
 			struct amdgpu_vmid *id = &id_mgr->ids[j];
 
 			amdgpu_sync_free(&id->active);
-			dma_fence_put(id->flushed_updates);
 			dma_fence_put(id->last_flush);
 			dma_fence_put(id->pasid_mapping);
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 0c3b4fa1f936..06c8a0034fa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -47,7 +47,7 @@ struct amdgpu_vmid {
 
 	uint64_t		pd_gpu_addr;
 	/* last flushed PD/PT update */
-	struct dma_fence	*flushed_updates;
+	uint64_t		flushed_updates;
 
 	uint32_t                current_gpu_reset_count;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index f7d8487799b2..bc5ab44c5830 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -51,7 +51,7 @@ static struct kmem_cache *amdgpu_sync_slab;
 void amdgpu_sync_create(struct amdgpu_sync *sync)
 {
 	hash_init(sync->fences);
-	sync->last_vm_update = NULL;
+	sync->last_vm_update = 0;
 }
 
 /**
@@ -184,7 +184,7 @@ int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, struct dma_fence *fence)
 	if (!fence)
 		return 0;
 
-	amdgpu_sync_keep_later(&sync->last_vm_update, fence);
+	sync->last_vm_update = max(sync->last_vm_update, fence->seqno);
 	return amdgpu_sync_fence(sync, fence);
 }
 
@@ -377,8 +377,7 @@ int amdgpu_sync_clone(struct amdgpu_sync *source, struct amdgpu_sync *clone)
 		}
 	}
 
-	dma_fence_put(clone->last_vm_update);
-	clone->last_vm_update = dma_fence_get(source->last_vm_update);
+	clone->last_vm_update = source->last_vm_update;
 
 	return 0;
 }
@@ -420,8 +419,6 @@ void amdgpu_sync_free(struct amdgpu_sync *sync)
 		dma_fence_put(e->fence);
 		kmem_cache_free(amdgpu_sync_slab, e);
 	}
-
-	dma_fence_put(sync->last_vm_update);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
index 7c0fe20c470d..876c1ee8869c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
@@ -43,7 +43,7 @@ enum amdgpu_sync_mode {
  */
 struct amdgpu_sync {
 	DECLARE_HASHTABLE(fences, 4);
-	struct dma_fence	*last_vm_update;
+	uint64_t	last_vm_update;
 };
 
 void amdgpu_sync_create(struct amdgpu_sync *sync);
-- 
2.25.1

