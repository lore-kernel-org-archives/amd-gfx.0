Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C7DCD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 12:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A2C10E154;
	Wed, 20 May 2026 12:10:28 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF46A10E613
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 12:10:26 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64KCALOi2581428; Wed, 20 May 2026 17:40:21 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64KCALKB2581427;
 Wed, 20 May 2026 17:40:21 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/userq: remove
 amdgpu_userq_create/destroy_object wrapper
Date: Wed, 20 May 2026 17:40:17 +0530
Message-Id: <20260520121019.2581398-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

Remove the amdgpu_userq_create/destroy_object wrapper functions and
use directly the kernel bo allocation function which does all the
things which are done in wrapper.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 67 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  7 ---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 29 +++++++---
 3 files changed, 21 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 798998d65e17..eaaffcdd6960 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -465,74 +465,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 	dma_fence_put(ev_fence);
 }
 
-int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
-			       struct amdgpu_userq_obj *userq_obj,
-			       int size)
-{
-	struct amdgpu_device *adev = uq_mgr->adev;
-	struct amdgpu_bo_param bp;
-	int r;
-
-	memset(&bp, 0, sizeof(bp));
-	bp.byte_align = PAGE_SIZE;
-	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
-	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
-		   AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-	bp.type = ttm_bo_type_kernel;
-	bp.size = size;
-	bp.resv = NULL;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-
-	r = amdgpu_bo_create(adev, &bp, &userq_obj->obj);
-	if (r) {
-		drm_file_err(uq_mgr->file, "Failed to allocate BO for userqueue (%d)", r);
-		return r;
-	}
 
-	r = amdgpu_bo_reserve(userq_obj->obj, true);
-	if (r) {
-		drm_file_err(uq_mgr->file, "Failed to reserve BO to map (%d)", r);
-		goto free_obj;
-	}
-
-	r = amdgpu_bo_pin(userq_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
-	if (r)
-		goto unresv;
-
-	r = amdgpu_ttm_alloc_gart(&(userq_obj->obj)->tbo);
-	if (r) {
-		drm_file_err(uq_mgr->file, "Failed to alloc GART for userqueue object (%d)", r);
-		goto unpin_bo;
-	}
-
-	r = amdgpu_bo_kmap(userq_obj->obj, &userq_obj->cpu_ptr);
-	if (r) {
-		drm_file_err(uq_mgr->file, "Failed to map BO for userqueue (%d)", r);
-		goto unpin_bo;
-	}
-
-	userq_obj->gpu_addr = amdgpu_bo_gpu_offset(userq_obj->obj);
-	amdgpu_bo_unreserve(userq_obj->obj);
-	memset(userq_obj->cpu_ptr, 0, size);
-	return 0;
-
-unpin_bo:
-	amdgpu_bo_unpin(userq_obj->obj);
-unresv:
-	amdgpu_bo_unreserve(userq_obj->obj);
-free_obj:
-	amdgpu_bo_unref(&userq_obj->obj);
-
-	return r;
-}
-
-void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
-				 struct amdgpu_userq_obj *userq_obj)
-{
-	amdgpu_bo_kunmap(userq_obj->obj);
-	amdgpu_bo_unpin(userq_obj->obj);
-	amdgpu_bo_unref(&userq_obj->obj);
-}
 
 static int
 amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 033b8a0de6b1..76ef5cfab52e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -151,13 +151,6 @@ void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev);
 void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
-int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
-			       struct amdgpu_userq_obj *userq_obj,
-			       int size);
-
-void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
-				 struct amdgpu_userq_obj *userq_obj);
-
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
 
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2d95203ec58e..ebd4e90cce63 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -192,12 +192,16 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	 * for the same.
 	 */
 	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
-	r = amdgpu_userq_create_object(uq_mgr, ctx, size);
+	r = amdgpu_bo_create_kernel(uq_mgr->adev, size, PAGE_SIZE,
+				   AMDGPU_GEM_DOMAIN_GTT,
+				   &ctx->obj, &ctx->gpu_addr,
+				   &ctx->cpu_ptr);
 	if (r) {
 		DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
 		return r;
 	}
 
+	memset(ctx->cpu_ptr, 0, size);
 	return 0;
 }
 
@@ -270,13 +274,19 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		return -ENOMEM;
 	}
 
-	r = amdgpu_userq_create_object(uq_mgr, &queue->mqd,
-			AMDGPU_MQD_SIZE_ALIGN(mqd_hw_default->mqd_size));
+	r = amdgpu_bo_create_kernel(adev,
+				   AMDGPU_MQD_SIZE_ALIGN(mqd_hw_default->mqd_size),
+				   PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
+				   &queue->mqd.obj, &queue->mqd.gpu_addr,
+				   &queue->mqd.cpu_ptr);
 	if (r) {
 		DRM_ERROR("Failed to create MQD object for userqueue\n");
 		goto free_props;
 	}
 
+	memset(queue->mqd.cpu_ptr, 0,
+	       AMDGPU_MQD_SIZE_ALIGN(mqd_hw_default->mqd_size));
+
 	/* Initialize the MQD BO with user given values */
 	userq_props->wptr_gpu_addr = mqd_user->wptr_va;
 	userq_props->rptr_gpu_addr = mqd_user->rptr_va;
@@ -432,10 +442,12 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return 0;
 
 free_ctx:
-	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+	amdgpu_bo_free_kernel(&queue->fw_obj.obj, &queue->fw_obj.gpu_addr,
+			      &queue->fw_obj.cpu_ptr);
 
 free_mqd:
-	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
+	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr,
+			      &queue->mqd.cpu_ptr);
 
 free_props:
 	kfree(userq_props);
@@ -445,11 +457,12 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
 {
-	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 
-	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+	amdgpu_bo_free_kernel(&queue->fw_obj.obj, &queue->fw_obj.gpu_addr,
+			      &queue->fw_obj.cpu_ptr);
 	kfree(queue->userq_prop);
-	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
+	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr,
+			      &queue->mqd.cpu_ptr);
 }
 
 static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
-- 
2.34.1

