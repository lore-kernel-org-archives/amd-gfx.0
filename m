Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CDCCD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 05:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF5610E5FA;
	Wed, 20 May 2026 05:32:02 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6EBA10E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 05:31:58 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64K5VrhX2024905; Wed, 20 May 2026 11:01:53 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64K5Vrtu2024904;
 Wed, 20 May 2026 11:01:53 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 5/5] drm/amdgpu/userq: use array instead of list for
 userq_vas
Date: Wed, 20 May 2026 11:01:51 +0530
Message-Id: <20260520053152.2024851-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520053152.2024851-1-sunil.khatri@amd.com>
References: <20260520053152.2024851-1-sunil.khatri@amd.com>
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

Use array instead of list for userq_vas since these are fixed no
of bos and its better to use userq_vas and we dont have to clean
up later since this array would be free along with queue only.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 86 ++++++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 20 +++--
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 14 ++--
 3 files changed, 46 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 551c49a4bf38..87a6ad9749e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -215,33 +215,17 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 	xa_unlock_irqrestore(xa, flags);
 }
 
-static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
-					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
-{
-	struct amdgpu_userq_va_cursor *va_cursor;
-	struct userq_va_list;
-
-	va_cursor = kzalloc(sizeof(*va_cursor), GFP_KERNEL);
-	if (!va_cursor)
-		return -ENOMEM;
 
-	INIT_LIST_HEAD(&va_cursor->list);
-	va_cursor->gpu_addr = addr;
-	va_map->bo_va->userq_va_mapped = true;
-	list_add(&va_cursor->list, &queue->userq_va_list);
-
-	return 0;
-}
 
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
-				   u64 addr, u64 expected_size)
+				   u64 addr, u64 expected_size,
+				   u64 *va_out)
 {
 	struct amdgpu_bo_va_mapping *va_map;
 	struct amdgpu_vm *vm = queue->vm;
 	u64 user_addr;
 	u64 size;
-	int r = 0;
 
 	/* Caller must hold vm->root.bo reservation */
 	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
@@ -250,20 +234,18 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
 
 	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
-	if (!va_map) {
-		r = -EINVAL;
-		goto out_err;
-	}
+	if (!va_map)
+		return -EINVAL;
+
 	/* Only validate the userq whether resident in the VM mapping range */
 	if (user_addr >= va_map->start  &&
 	    va_map->last - user_addr + 1 >= size) {
-		amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr);
+		va_map->bo_va->userq_va_mapped = true;
+		*va_out = user_addr;
 		return 0;
 	}
 
-	r = -EINVAL;
-out_err:
-	return r;
+	return -EINVAL;
 }
 
 static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
@@ -284,14 +266,16 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 
 static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
 {
-	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
-	int r = 0;
+	int i, r = 0;
 
-	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
-		r += amdgpu_userq_buffer_va_mapped(queue->vm, va_cursor->gpu_addr);
+	for (i = 0; i < ARRAY_SIZE(queue->userq_vas.va_array); i++) {
+		if (!queue->userq_vas.va_array[i])
+			continue;
+		r += amdgpu_userq_buffer_va_mapped(queue->vm,
+						   queue->userq_vas.va_array[i]);
 		dev_dbg(queue->userq_mgr->adev->dev,
 			"validate the userq mapping:%p va:%llx r:%d\n",
-			queue, va_cursor->gpu_addr, r);
+			queue, queue->userq_vas.va_array[i], r);
 	}
 
 	if (r != 0)
@@ -300,24 +284,7 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
 	return false;
 }
 
-static void amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
-						 struct amdgpu_usermode_queue *queue)
-{
-	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
-	struct amdgpu_bo_va_mapping *mapping;
-
-	/* Caller must hold vm->root.bo reservation */
-	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
 
-	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
-		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
-		if (mapping)
-			dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
-				queue, va_cursor->gpu_addr);
-		list_del(&va_cursor->list);
-		kfree(va_cursor);
-	}
-}
 
 static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
 {
@@ -628,10 +595,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	cancel_delayed_work_sync(&queue->hang_detect_work);
-	amdgpu_bo_reserve(vm->root.bo, true);
-	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
-	amdgpu_bo_unreserve(vm->root.bo);
-	list_del(&queue->userq_va_list);
+
 	queue->userq_mgr = NULL;
 	/* Destroy all the memory associate with the queue */
 	uq_funcs = adev->userq_funcs[queue->queue_type];
@@ -731,7 +695,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	kref_init(&queue->refcount);
-	INIT_LIST_HEAD(&queue->userq_va_list);
 	queue->doorbell_handle = args->in.doorbell_handle;
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
@@ -752,14 +715,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto free_fence_drv;
 
 	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va,
-					   args->in.queue_size) ||
+					   args->in.queue_size,
+					   &queue->userq_vas.va.queue_rb) ||
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va,
-					   AMDGPU_GPU_PAGE_SIZE) ||
+					   AMDGPU_GPU_PAGE_SIZE,
+					   &queue->userq_vas.va.rptr) ||
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va,
-					   AMDGPU_GPU_PAGE_SIZE)) {
+					   AMDGPU_GPU_PAGE_SIZE,
+					   &queue->userq_vas.va.wptr)) {
 		r = -EINVAL;
 		amdgpu_bo_unreserve(fpriv->vm.root.bo);
-		goto clean_mapping;
+		goto free_fence_drv;
 	}
 	amdgpu_bo_unreserve(fpriv->vm.root.bo);
 
@@ -771,7 +737,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp, &index);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
-		goto clean_mapping;
+		goto free_fence_drv;
 	}
 
 	queue->doorbell_index = index;
@@ -828,10 +794,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	uq_funcs->mqd_destroy(queue);
 clean_doorbell_bo:
 	amdgpu_userq_destroy_object(&queue->db_obj);
-clean_mapping:
-	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
-	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
-	amdgpu_bo_unreserve(fpriv->vm.root.bo);
 free_fence_drv:
 	amdgpu_userq_fence_driver_free(queue);
 free_queue:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index fe89e35b0d85..85cc6d84b196 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -48,11 +48,6 @@ struct amdgpu_userq_obj {
 	struct amdgpu_bo *obj;
 };
 
-struct amdgpu_userq_va_cursor {
-	u64			gpu_addr;
-	struct list_head	list;
-};
-
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	enum amdgpu_userq_state state;
@@ -93,7 +88,17 @@ struct amdgpu_usermode_queue {
 	struct delayed_work	hang_detect_work;
 	struct kref		refcount;
 
-	struct list_head	userq_va_list;
+	union {
+		struct {
+			u64 queue_rb;
+			u64 wptr;
+			u64 rptr;
+			u64 eop;
+			u64 shadow;
+			u64 csa;
+		} va;
+		u64 va_array[6];
+	} userq_vas;
 };
 
 struct amdgpu_userq_funcs {
@@ -180,7 +185,8 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
 
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
-				   u64 addr, u64 expected_size);
+				   u64 addr, u64 expected_size, u64 *va_out);
+
 void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 					struct amdgpu_bo_va_mapping *mapping,
 					uint64_t saddr);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index ea572d924621..3f5c7333144e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -308,8 +308,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(compute_mqd);
 			goto free_mqd;
 		}
-		r = amdgpu_userq_input_va_validate(adev, queue, compute_mqd->eop_va,
-						   2048);
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   compute_mqd->eop_va, 2048,
+						   &queue->userq_vas.va.eop);
 		amdgpu_bo_unreserve(queue->vm->root.bo);
 		if (r) {
 			kfree(compute_mqd);
@@ -358,7 +359,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
-						   shadow_info.shadow_size);
+						   shadow_info.shadow_size,
+						   &queue->userq_vas.va.shadow);
 		if (r) {
 			amdgpu_bo_unreserve(queue->vm->root.bo);
 			kfree(mqd_gfx_v11);
@@ -366,7 +368,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		}
 
 		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
-						   shadow_info.csa_size);
+						   shadow_info.csa_size,
+						   &queue->userq_vas.va.csa);
 		amdgpu_bo_unreserve(queue->vm->root.bo);
 		if (r) {
 			kfree(mqd_gfx_v11);
@@ -396,7 +399,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
-						   32);
+						   32,
+						   &queue->userq_vas.va.csa);
 		amdgpu_bo_unreserve(queue->vm->root.bo);
 		if (r) {
 			kfree(mqd_sdma_v11);
-- 
2.34.1

