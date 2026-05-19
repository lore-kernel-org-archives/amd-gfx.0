Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3382ACD5BA7
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD2E210EBEA;
	Tue, 19 May 2026 10:18:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2199810EBE5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:18:17 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64JAI8hK871919; Tue, 19 May 2026 15:48:08 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64JAI8Xe871918;
 Tue, 19 May 2026 15:48:08 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v5 8/8] drm/amdgpu/userq: user array to store userq vas
Date: Tue, 19 May 2026 15:47:55 +0530
Message-Id: <20260519101755.871750-9-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519101755.871750-1-sunil.khatri@amd.com>
References: <20260519101755.871750-1-sunil.khatri@amd.com>
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

Add per queue array to store userq vas and keep
size to accommodate vas of all types of queues
i.e gfx, compute and sdma.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 36 ++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  4 ++-
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 57136b80d62d..bec5b9f5064e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -218,18 +218,11 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
 					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
 {
-	struct amdgpu_userq_va_cursor *va_cursor;
-	struct userq_va_list;
-
-	va_cursor = kzalloc(sizeof(*va_cursor), GFP_KERNEL);
-	if (!va_cursor)
+	if (queue->userq_va_count >= ARRAY_SIZE(queue->userq_va))
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&va_cursor->list);
-	va_cursor->gpu_addr = addr;
+	queue->userq_va[queue->userq_va_count++] = addr;
 	va_map->bo_va->userq_va_mapped = true;
-	list_add(&va_cursor->list, &queue->userq_va_list);
-
 	return 0;
 }
 
@@ -284,14 +277,13 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 
 static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
 {
-	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
-	int r = 0;
+	int i, r = 0;
 
-	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
-		r += amdgpu_userq_buffer_va_mapped(queue->vm, va_cursor->gpu_addr);
+	for (i = 0; i < queue->userq_va_count; i++) {
+		r += amdgpu_userq_buffer_va_mapped(queue->vm, queue->userq_va[i]);
 		dev_dbg(queue->userq_mgr->adev->dev,
 			"validate the userq mapping:%p va:%llx r:%d\n",
-			queue, va_cursor->gpu_addr, r);
+			queue, queue->userq_va[i], r);
 	}
 
 	if (r != 0)
@@ -303,19 +295,19 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
 static void amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
 						 struct amdgpu_usermode_queue *queue)
 {
-	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
 	struct amdgpu_bo_va_mapping *mapping;
+	int i;
 
 	/* Caller must hold vm->root.bo reservation */
 	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
 
-	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
-		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
-		if (mapping)
+	for (i = 0; i < queue->userq_va_count; i++) {
+		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, queue->userq_va[i]);
+		if (mapping) {
+			mapping->bo_va->userq_va_mapped = false;
 			dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
-				queue, va_cursor->gpu_addr);
-		list_del(&va_cursor->list);
-		kfree(va_cursor);
+				queue, queue->userq_va[i]);
+			}
 	}
 }
 
@@ -427,7 +419,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
 	amdgpu_userq_fence_driver_free(queue);
 	queue->fence_drv = NULL;
-	list_del(&queue->userq_va_list);
 
 	up_read(&adev->reset_domain->sem);
 }
@@ -740,7 +731,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	kref_init(&queue->refcount);
-	INIT_LIST_HEAD(&queue->userq_va_list);
 	queue->doorbell_handle = args->in.doorbell_handle;
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 033b8a0de6b1..fdf4d878c894 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -93,7 +93,9 @@ struct amdgpu_usermode_queue {
 	struct delayed_work	hang_detect_work;
 	struct kref		refcount;
 
-	struct list_head	userq_va_list;
+	/* User to store core bo's va addresses */
+	u64			userq_va[5];
+	int			userq_va_count;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.34.1

