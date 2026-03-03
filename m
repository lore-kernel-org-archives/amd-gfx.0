Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BEDEC1437
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 12:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE6810E03F;
	Tue,  3 Mar 2026 12:07:07 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F4210E03F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 12:07:05 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 623C6teO2583015; Tue, 3 Mar 2026 17:36:55 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 623C6tIg2583014;
 Tue, 3 Mar 2026 17:36:55 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v4] drm/amdgpu/userq: refcount userqueues to avoid any race
 conditions
Date: Tue,  3 Mar 2026 17:36:54 +0530
Message-Id: <20260303120654.2582995-1-sunil.khatri@amd.com>
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

To avoid race condition and avoid UAF cases, implement kref
based queues and protect the below operations using xa lock
a. Getting a queue from xarray
b. Increment/Decrement it's refcount

Every time some one want to access a queue, always get via
amdgpu_userq_get to make sure we have locks in place and get
the object if active.

A userqueue is destroyed on the last refcount is dropped which
typically would be via IOCTL or during fini.

v2: Add the missing drop in one the condition in the signal ioclt [Alex]

v3: remove the queue from the xarray first in the free queue ioctl path
    [Christian]

- Pass queue to the amdgpu_userq_put directly.
- make amdgpu_userq_put xa_lock free since we are doing put for each get
  only and final put is done via destroy and we remove the queue from xa
  with lock.
- use userq_put in fini too so cleanup is done fully.

v4: Use xa_erase directly rather than doing load and erase in free
    ioctl. Also remove some of the error logs which could be exploited
    by the user to flood the logs [Christian]

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 110 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  14 ++-
 3 files changed, 91 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e07b2082cf25..ed6a9d779d1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -446,8 +446,7 @@ static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
 	return ret;
 }
 
-static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
-				 u32 queue_id)
+static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
@@ -461,7 +460,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
 	uq_funcs->mqd_destroy(queue);
 	amdgpu_userq_fence_driver_free(queue);
 	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
-	xa_erase_irq(&uq_mgr->userq_xa, queue_id);
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
 	queue->userq_mgr = NULL;
 	list_del(&queue->userq_va_list);
@@ -470,12 +468,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
 	up_read(&adev->reset_domain->sem);
 }
 
-static struct amdgpu_usermode_queue *
-amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
-{
-	return xa_load(&uq_mgr->userq_xa, qid);
-}
-
 void
 amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
 			     struct amdgpu_eviction_fence_mgr *evf_mgr)
@@ -625,22 +617,13 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 static int
-amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
+amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
-	struct amdgpu_usermode_queue *queue;
 	int r = 0;
 
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
 	mutex_lock(&uq_mgr->userq_mutex);
-	queue = amdgpu_userq_find(uq_mgr, queue_id);
-	if (!queue) {
-		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
-		mutex_unlock(&uq_mgr->userq_mutex);
-		return -EINVAL;
-	}
 	amdgpu_userq_wait_for_last_fence(queue);
 	/* Cancel any pending hang detection work and cleanup */
 	if (queue->hang_detect_fence) {
@@ -672,13 +655,44 @@ amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 	}
-	amdgpu_userq_cleanup(queue, queue_id);
+	amdgpu_userq_cleanup(queue);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	return r;
 }
+static void amdgpu_userq_kref_destroy(struct kref *kref)
+{
+	int r;
+	struct amdgpu_usermode_queue *queue =
+		container_of(kref, struct amdgpu_usermode_queue, refcount);
+
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+
+	r = amdgpu_userq_destroy(uq_mgr, queue);
+	if (r)
+		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue\n");
+}
+
+struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
+{
+	struct amdgpu_usermode_queue *queue;
+
+	xa_lock(&uq_mgr->userq_xa);
+	queue = xa_load(&uq_mgr->userq_xa, qid);
+	if (queue)
+		kref_get(&queue->refcount);
+	xa_unlock(&uq_mgr->userq_xa);
+
+	return queue;
+}
+
+void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
+{
+	if (queue)
+		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
+}
 
 static int amdgpu_userq_priority_permit(struct drm_file *filp,
 					int priority)
@@ -891,6 +905,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	args->out.queue_id = qid;
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
+	/* drop this refcount during queue destroy */
+	kref_init(&queue->refcount);
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
@@ -985,6 +1001,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
 	union drm_amdgpu_userq *args = data;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_usermode_queue *queue;
 	int r;
 
 	if (!amdgpu_userq_enabled(dev))
@@ -1000,11 +1018,14 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 			drm_file_err(filp, "Failed to create usermode queue\n");
 		break;
 
-	case AMDGPU_USERQ_OP_FREE:
-		r = amdgpu_userq_destroy(filp, args->in.queue_id);
-		if (r)
-			drm_file_err(filp, "Failed to destroy usermode queue\n");
+	case AMDGPU_USERQ_OP_FREE: {
+		queue = xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
+		if (!queue)
+			return -ENOENT;
+
+		amdgpu_userq_put(queue);
 		break;
+	}
 
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
@@ -1023,16 +1044,23 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+		queue = amdgpu_userq_get(uq_mgr, queue_id);
+		if (!queue)
+			continue;
+
 		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
 			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+			amdgpu_userq_put(queue);
 			continue;
 		}
 
 		r = amdgpu_userq_restore_helper(queue);
 		if (r)
 			ret = r;
+
+		amdgpu_userq_put(queue);
 	}
 
 	if (ret)
@@ -1266,9 +1294,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+		queue = amdgpu_userq_get(uq_mgr, queue_id);
+		if (!queue)
+			continue;
 		r = amdgpu_userq_preempt_helper(queue);
 		if (r)
 			ret = r;
+		amdgpu_userq_put(queue);
 	}
 
 	if (ret)
@@ -1301,16 +1333,24 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 	int ret;
 
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+		queue = amdgpu_userq_get(uq_mgr, queue_id);
+		if (!queue)
+			continue;
+
 		struct dma_fence *f = queue->last_fence;
 
-		if (!f || dma_fence_is_signaled(f))
+		if (!f || dma_fence_is_signaled(f)) {
+			amdgpu_userq_put(queue);
 			continue;
+		}
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
 		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			amdgpu_userq_put(queue);
 			return -ETIMEDOUT;
 		}
+		amdgpu_userq_put(queue);
 	}
 
 	return 0;
@@ -1361,20 +1401,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
-	unsigned long queue_id;
+	unsigned long queue_id = 0;
 
 	cancel_delayed_work_sync(&userq_mgr->resume_work);
+	for (;;) {
+		xa_lock(&userq_mgr->userq_xa);
+		queue = xa_find(&userq_mgr->userq_xa, &queue_id, ULONG_MAX,
+				XA_PRESENT);
+		if (queue)
+			__xa_erase(&userq_mgr->userq_xa, queue_id);
+		xa_unlock(&userq_mgr->userq_xa);
+
+		if (!queue)
+			break;
 
-	mutex_lock(&userq_mgr->userq_mutex);
-	amdgpu_userq_detect_and_reset_queues(userq_mgr);
-	xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
-		amdgpu_userq_wait_for_last_fence(queue);
-		amdgpu_userq_unmap_helper(queue);
-		amdgpu_userq_cleanup(queue, queue_id);
+		amdgpu_userq_put(queue);
 	}
 
 	xa_destroy(&userq_mgr->userq_xa);
-	mutex_unlock(&userq_mgr->userq_mutex);
 	mutex_destroy(&userq_mgr->userq_mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index f4d1d46ae15e..54e1997b3cc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -74,6 +74,7 @@ struct amdgpu_usermode_queue {
 	struct dentry		*debugfs_queue;
 	struct delayed_work hang_detect_work;
 	struct dma_fence *hang_detect_fence;
+	struct kref		refcount;
 
 	struct list_head	userq_va_list;
 };
@@ -114,6 +115,9 @@ struct amdgpu_db_info {
 	struct amdgpu_userq_obj	*db_obj;
 };
 
+struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
+void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3c30512a6266..a7ded25346b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -470,7 +470,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	struct drm_gem_object **gobj_write, **gobj_read;
 	u32 *syncobj_handles, num_syncobj_handles;
 	struct amdgpu_userq_fence *userq_fence;
-	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_usermode_queue *queue = NULL;
 	struct drm_syncobj **syncobj = NULL;
 	struct dma_fence *fence;
 	struct drm_exec exec;
@@ -521,7 +521,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		goto put_gobj_read;
 
 	/* Retrieve the user queue */
-	queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
+	queue = amdgpu_userq_get(userq_mgr, args->queue_id);
 	if (!queue) {
 		r = -ENOENT;
 		goto put_gobj_write;
@@ -612,6 +612,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 free_syncobj_handles:
 	kfree(syncobj_handles);
 
+	if (queue)
+		amdgpu_userq_put(queue);
+
 	return r;
 }
 
@@ -626,7 +629,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
 	struct drm_gem_object **gobj_write, **gobj_read;
 	u32 *timeline_points, *timeline_handles;
-	struct amdgpu_usermode_queue *waitq;
+	struct amdgpu_usermode_queue *waitq = NULL;
 	u32 *syncobj_handles, num_syncobj;
 	struct dma_fence **fences = NULL;
 	u16 num_points, num_fences = 0;
@@ -863,7 +866,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		 */
 		num_fences = dma_fence_dedup_array(fences, num_fences);
 
-		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
+		waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
 		if (!waitq) {
 			r = -EINVAL;
 			goto free_fences;
@@ -947,5 +950,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 free_syncobj_handles:
 	kfree(syncobj_handles);
 
+	if (waitq)
+		amdgpu_userq_put(waitq);
+
 	return r;
 }
-- 
2.34.1

