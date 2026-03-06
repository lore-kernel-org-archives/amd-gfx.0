Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065B7F01822
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 10:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 890EE10ECC6;
	Fri,  6 Mar 2026 10:15:04 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF77510ECC9
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 10:15:02 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 626AEvQL1940182; Fri, 6 Mar 2026 15:44:57 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 626AEvJe1940181;
 Fri, 6 Mar 2026 15:44:57 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu/userq: declutter the code with goto
Date: Fri,  6 Mar 2026 15:44:53 +0530
Message-Id: <20260306101453.1940129-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306101453.1940129-1-sunil.khatri@amd.com>
References: <20260306101453.1940129-1-sunil.khatri@amd.com>
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

Clean up the amdgpu_userq_create function clean up in
failure condition using goto method. This avoid replication
of cleanup for every failure conditon.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 45 ++++++++++-------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a614b01b7eab..aef9b5855812 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -758,7 +758,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_db_info db_info;
-	bool skip_map_queue;
+	bool skip_map_queue = false, sem_held = false;
 	u32 qid;
 	uint64_t index;
 	int r = 0;
@@ -818,17 +818,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
 		r = -EINVAL;
-		kfree(queue);
-		goto unlock;
+		goto free_queue;
 	}
 
 	/* Convert relative doorbell offset into absolute doorbell index */
 	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
 	if (index == (uint64_t)-EINVAL) {
 		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
-		kfree(queue);
 		r = -EINVAL;
-		goto unlock;
+		goto free_queue;
 	}
 
 	queue->doorbell_index = index;
@@ -836,15 +834,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
-		goto unlock;
+		goto free_queue;
 	}
 
 	r = uq_funcs->mqd_create(queue, &args->in);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
-		amdgpu_userq_fence_driver_free(queue);
-		kfree(queue);
-		goto unlock;
+		goto clean_fence_driver;
 	}
 
 	/* don't map the queue if scheduling is halted */
@@ -852,16 +848,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 	     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)))
 		skip_map_queue = true;
-	else
-		skip_map_queue = false;
+
 	if (!skip_map_queue) {
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
-			uq_funcs->mqd_destroy(queue);
-			amdgpu_userq_fence_driver_free(queue);
-			kfree(queue);
-			goto unlock;
+			goto clean_mqd;
 		}
 	}
 
@@ -870,18 +862,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	/* Wait for mode-1 reset to complete */
 	down_read(&adev->reset_domain->sem);
+	sem_held = true;
 	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
 		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
 	if (r) {
 		if (!skip_map_queue)
 			amdgpu_userq_unmap_helper(queue);
 
-		uq_funcs->mqd_destroy(queue);
-		amdgpu_userq_fence_driver_free(queue);
-		kfree(queue);
 		r = -ENOMEM;
-		up_read(&adev->reset_domain->sem);
-		goto unlock;
+		goto clean_mqd;
 	}
 
 	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
@@ -890,11 +879,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		if (!skip_map_queue)
 			amdgpu_userq_unmap_helper(queue);
 
-		uq_funcs->mqd_destroy(queue);
-		amdgpu_userq_fence_driver_free(queue);
-		kfree(queue);
-		up_read(&adev->reset_domain->sem);
-		goto unlock;
+		goto clean_mqd;
 	}
 	up_read(&adev->reset_domain->sem);
 
@@ -910,7 +895,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	args->out.queue_id = qid;
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
+	mutex_unlock(&uq_mgr->userq_mutex);
+	return 0;
 
+clean_mqd:
+	uq_funcs->mqd_destroy(queue);
+	if (sem_held)
+		up_read(&adev->reset_domain->sem);
+clean_fence_driver:
+	amdgpu_userq_fence_driver_free(queue);
+free_queue:
+	kfree(queue);
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.34.1

