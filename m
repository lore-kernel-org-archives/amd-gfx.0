Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C137EA3C59
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 13:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D0E10E802;
	Thu,  9 Apr 2026 13:39:19 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF7A210E7F8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 13:39:14 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 639Dd90V1368275; Thu, 9 Apr 2026 19:09:09 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 639Dd9Bj1368274;
 Thu, 9 Apr 2026 19:09:09 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu/userq: hold root bo lock in caller of
 input_va_validate
Date: Thu,  9 Apr 2026 19:09:06 +0530
Message-Id: <20260409133906.1368219-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409133906.1368219-1-sunil.khatri@amd.com>
References: <20260409133906.1368219-1-sunil.khatri@amd.com>
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

Caller should hold the reservation lock for root.bo in func
amdgpu_userq_input_va_validate.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 17 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a7fb061ac690..0163fba4cf74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -239,13 +239,12 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	u64 size;
 	int r = 0;
 
+	/* Caller must hold vm->root.bo reservation */
+	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
+
 	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
 	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
 
-	r = amdgpu_bo_reserve(vm->root.bo, false);
-	if (r)
-		return r;
-
 	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
 	if (!va_map) {
 		r = -EINVAL;
@@ -255,13 +254,11 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	if (user_addr >= va_map->start  &&
 	    va_map->last - user_addr + 1 >= size) {
 		amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr);
-		amdgpu_bo_unreserve(vm->root.bo);
 		return 0;
 	}
 
 	r = -EINVAL;
 out_err:
-	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
 }
 
@@ -773,13 +770,20 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	db_info.doorbell_offset = args->in.doorbell_offset;
 
 	queue->userq_mgr = uq_mgr;
+
 	/* Validate the userq virtual address.*/
+	r = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
+	if (r)
+		goto free_queue;
+
 	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va, args->in.queue_size) ||
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
 		r = -EINVAL;
+		amdgpu_bo_unreserve(fpriv->vm.root.bo);
 		goto clean_mapping;
 	}
+	amdgpu_bo_unreserve(fpriv->vm.root.bo);
 
 	/* Convert relative doorbell offset into absolute doorbell index */
 	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
@@ -863,6 +867,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	amdgpu_bo_unreserve(fpriv->vm.root.bo);
+free_queue:
 	kfree(queue);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 527cf2f14691..d12cd1b7790b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -322,8 +322,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
+		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+		if (r) {
+			kfree(compute_mqd);
+			goto free_mqd;
+		}
 		r = amdgpu_userq_input_va_validate(adev, queue, compute_mqd->eop_va,
 						   2048);
+		amdgpu_bo_unreserve(queue->vm->root.bo);
 		if (r) {
 			kfree(compute_mqd);
 			goto free_mqd;
@@ -365,14 +371,22 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
+		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+		if (r) {
+			kfree(mqd_gfx_v11);
+			goto free_mqd;
+		}
 		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
 						   shadow_info.shadow_size);
 		if (r) {
+			amdgpu_bo_unreserve(queue->vm->root.bo);
 			kfree(mqd_gfx_v11);
 			goto free_mqd;
 		}
+
 		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
 						   shadow_info.csa_size);
+		amdgpu_bo_unreserve(queue->vm->root.bo);
 		if (r) {
 			kfree(mqd_gfx_v11);
 			goto free_mqd;
@@ -394,8 +408,15 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			r = -ENOMEM;
 			goto free_mqd;
 		}
+
+		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+		if (r) {
+			kfree(mqd_sdma_v11);
+			goto free_mqd;
+		}
 		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
 						   32);
+		amdgpu_bo_unreserve(queue->vm->root.bo);
 		if (r) {
 			kfree(mqd_sdma_v11);
 			goto free_mqd;
-- 
2.34.1

