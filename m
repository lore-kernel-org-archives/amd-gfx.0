Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD52CFF886F
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 12:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC7510E3CF;
	Mon,  4 May 2026 12:56:53 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40C510E3CF
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2026 12:56:51 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 644Cukk8091856; Mon, 4 May 2026 18:26:46 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 644CuklH091855;
 Mon, 4 May 2026 18:26:46 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu/userq: fix access to stale wptr mapping
Date: Mon,  4 May 2026 18:26:45 +0530
Message-Id: <20260504125645.91836-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

Use drm_exec to take both locks i.e vm root bo and
wptr_obj bo to access the mapping data properly.

This fixes the security issue of unmap the wptr_obj while
a queue creation is in progress and passing other
bo at same address.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 122 ++++++++++-----------
 1 file changed, 57 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 501e2e10b4a6..3d4f83015488 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -30,34 +30,6 @@
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
 
-static int
-mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
-{
-	int ret;
-
-	ret = amdgpu_bo_reserve(bo, true);
-	if (ret) {
-		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
-		goto err_reserve_bo_failed;
-	}
-
-	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
-	if (ret) {
-		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
-		goto err_map_bo_gart_failed;
-	}
-
-	amdgpu_bo_unreserve(bo);
-	bo = amdgpu_bo_ref(bo);
-
-	return 0;
-
-err_map_bo_gart_failed:
-	amdgpu_bo_unreserve(bo);
-err_reserve_bo_failed:
-	return ret;
-}
-
 static int
 mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 			      struct amdgpu_userq_mgr *uq_mgr,
@@ -65,55 +37,75 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 			      uint64_t wptr)
 {
 	struct amdgpu_bo_va_mapping *wptr_mapping;
-	struct amdgpu_vm *wptr_vm;
 	struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
+	struct amdgpu_bo *obj;
+	struct amdgpu_vm *vm = queue->vm;
+	struct drm_exec exec;
 	int ret;
 
-	wptr_vm = queue->vm;
-	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
-	if (ret)
-		return ret;
-
 	wptr &= AMDGPU_GMC_HOLE_MASK;
-	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
-	amdgpu_bo_unreserve(wptr_vm->root.bo);
-	if (!wptr_mapping) {
-		DRM_ERROR("Failed to lookup wptr bo\n");
-		return -EINVAL;
-	}
 
-	wptr_obj->obj = wptr_mapping->bo_va->base.bo;
-	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
-		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
-		return -EINVAL;
-	}
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&exec) {
+		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret))
+			goto fail_lock;
+
+		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
+		if (!wptr_mapping) {
+			DRM_ERROR("Failed to lock up wptr bo\n");
+			ret = -EINVAL;
+			goto fail_lock;
+		}
 
-	ret = mes_userq_map_gtt_bo_to_gart(wptr_obj->obj);
-	if (ret) {
-		DRM_ERROR("Failed to map wptr bo to GART\n");
-		return ret;
-	}
+		obj = wptr_mapping->bo_va->base.bo;
+		ret = drm_exec_prepare_obj(&exec, &obj->tbo.base, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret)) {
+			DRM_ERROR("Failed to prepare wptr bo\n");
+			goto fail_lock;
+		}
 
-	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
-	if (ret) {
-		DRM_ERROR("Failed to reserve wptr bo\n");
-		return ret;
-	}
+		/* mapping now should be stable since both the locks are held */
+		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
+		if (!wptr_mapping) {
+			DRM_ERROR("Failed to lock up wptr bo\n");
+			ret = -EINVAL;
+			goto fail_lock;
+		}
 
-	/* TODO use eviction fence instead of pinning. */
-	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
-	if (ret) {
-		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n");
-		goto unresv_bo;
-	}
+		wptr_obj->obj = amdgpu_bo_ref(wptr_mapping->bo_va->base.bo);
+
+		if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
+			DRM_ERROR("Requested wptr bo size is larger than one page\n");
+			ret = -EINVAL;
+			goto fail_map;
+		}
+
+		ret = amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
+		if (ret) {
+			DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
+			goto fail_map;
+		}
+
+		/* TODO use eviction fence instead of pinning. */
+		ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
+		if (ret) {
+			DRM_ERROR("Failed to pin wptr bo. ret %d\n", ret);
+			goto fail_map;
+		}
 
-	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
-	amdgpu_bo_unreserve(wptr_obj->obj);
+		queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
+	}
 
+	drm_exec_fini(&exec);
 	return 0;
 
-unresv_bo:
-	amdgpu_bo_unreserve(wptr_obj->obj);
+fail_map:
+	amdgpu_bo_unref(&wptr_obj->obj);
+fail_lock:
+	drm_exec_fini(&exec);
 	return ret;
 
 }
-- 
2.34.1

