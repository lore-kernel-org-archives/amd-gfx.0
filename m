Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0802BF01823
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 10:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A6010ECC9;
	Fri,  6 Mar 2026 10:15:06 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEE1110ECC6
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 10:15:02 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 626AEvgY1940177; Fri, 6 Mar 2026 15:44:57 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 626AEv1X1940170;
 Fri, 6 Mar 2026 15:44:57 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu/userq: defer queue publication until create
 completes
Date: Fri,  6 Mar 2026 15:44:52 +0530
Message-Id: <20260306101453.1940129-1-sunil.khatri@amd.com>
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

The userq create path publishes queues to global xarrays such as
userq_doorbell_xa and userq_xa before creation was fully complete.
Later on if create queue fails, teardown could free an already
visible queue, opening a UAF race with concurrent queue walkers.
Also calling amdgpu_userq_put in such cases complicates the cleanup.

Solution is to defer queue publication until create succeeds and no
partially initialized queue is exposed.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 66 +++++++++++------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7d2f78899c47..a614b01b7eab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -758,7 +758,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_db_info db_info;
-	char *queue_name;
 	bool skip_map_queue;
 	u32 qid;
 	uint64_t index;
@@ -848,32 +847,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-	/* drop this refcount during queue destroy */
-	kref_init(&queue->refcount);
-
-	/* Wait for mode-1 reset to complete */
-	down_read(&adev->reset_domain->sem);
-	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
-	if (r) {
-		kfree(queue);
-		up_read(&adev->reset_domain->sem);
-		goto unlock;
-	}
-
-	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
-		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
-	if (r) {
-		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
-		amdgpu_userq_fence_driver_free(queue);
-		xa_erase_irq(&adev->userq_doorbell_xa, index);
-		uq_funcs->mqd_destroy(queue);
-		kfree(queue);
-		r = -ENOMEM;
-		up_read(&adev->reset_domain->sem);
-		goto unlock;
-	}
-	up_read(&adev->reset_domain->sem);
-
 	/* don't map the queue if scheduling is halted */
 	if (adev->userq_halt_for_enforce_isolation &&
 	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
@@ -885,28 +858,55 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
-			xa_erase_irq(&adev->userq_doorbell_xa, index);
-			xa_erase(&uq_mgr->userq_xa, qid);
-			amdgpu_userq_fence_driver_free(queue);
 			uq_funcs->mqd_destroy(queue);
+			amdgpu_userq_fence_driver_free(queue);
 			kfree(queue);
 			goto unlock;
 		}
 	}
 
-	queue_name = kasprintf(GFP_KERNEL, "queue-%d", qid);
-	if (!queue_name) {
+	/* drop this refcount during queue destroy */
+	kref_init(&queue->refcount);
+
+	/* Wait for mode-1 reset to complete */
+	down_read(&adev->reset_domain->sem);
+	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
+		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
+	if (r) {
+		if (!skip_map_queue)
+			amdgpu_userq_unmap_helper(queue);
+
+		uq_funcs->mqd_destroy(queue);
+		amdgpu_userq_fence_driver_free(queue);
+		kfree(queue);
 		r = -ENOMEM;
+		up_read(&adev->reset_domain->sem);
 		goto unlock;
 	}
 
+	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
+	if (r) {
+		xa_erase(&uq_mgr->userq_xa, qid);
+		if (!skip_map_queue)
+			amdgpu_userq_unmap_helper(queue);
+
+		uq_funcs->mqd_destroy(queue);
+		amdgpu_userq_fence_driver_free(queue);
+		kfree(queue);
+		up_read(&adev->reset_domain->sem);
+		goto unlock;
+	}
+	up_read(&adev->reset_domain->sem);
+
 #if defined(CONFIG_DEBUG_FS)
+	char queue_name[32];
+
+	scnprintf(queue_name, sizeof(queue_name), "queue_%d", qid);
 	/* Queue dentry per client to hold MQD information   */
 	queue->debugfs_queue = debugfs_create_dir(queue_name, filp->debugfs_client);
 	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
 #endif
 	amdgpu_userq_init_hang_detect_work(queue);
-	kfree(queue_name);
 
 	args->out.queue_id = qid;
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
-- 
2.34.1

