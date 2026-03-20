Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C23108B8E2
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 09:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4E410EAB3;
	Fri, 20 Mar 2026 09:41:24 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C0F10EAB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 09:41:22 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62K9fCej3640196; Fri, 20 Mar 2026 15:11:12 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62K9fBrO3640195;
 Fri, 20 Mar 2026 15:11:11 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>,
 Liang@rtg-sunil-navi33.amd.com, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: add mutex lock/unlocked version of
 amdgpu_userq_put
Date: Fri, 20 Mar 2026 15:11:11 +0530
Message-Id: <20260320094111.3640176-1-sunil.khatri@amd.com>
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

There is a possibility of deadlock when last reference to a queue is
put in certain situations where mutex is already help when calling
the amdgpu_userq_destroy. So based on the thread where it could be
locked we pass the locked information in the destroy functionality
to avoid taking the lock again.

Cc: Liang, Prike <Prike.Liang@amd.com>
Suggested-by: Liang, Prike <Prike.Liang@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 52 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  4 +-
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ced9ade44be4..9482664e9c2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -617,13 +617,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 }
 
 static int
-amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue,
+		     bool locked)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	int r = 0;
 
-	cancel_delayed_work_sync(&uq_mgr->resume_work);
+	/* It safe to unlock since we are in destroy and the queue ref is only this */
+	if (locked)
+		mutex_unlock(&uq_mgr->userq_mutex);
 
+	cancel_delayed_work_sync(&uq_mgr->resume_work);
 	/* Cancel any pending hang detection work and cleanup */
 	cancel_delayed_work_sync(&queue->hang_detect_work);
 
@@ -657,13 +661,27 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 	}
 	amdgpu_userq_cleanup(queue);
-	mutex_unlock(&uq_mgr->userq_mutex);
+
+	if (!locked)
+		mutex_unlock(&uq_mgr->userq_mutex);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	return r;
 }
 
+static void amdgpu_userq_kref_destroy_locked(struct kref *kref)
+{
+	int r;
+	struct amdgpu_usermode_queue *queue =
+		container_of(kref, struct amdgpu_usermode_queue, refcount);
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+
+	r = amdgpu_userq_destroy(uq_mgr, queue, true);
+	if (r)
+		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
+}
+
 static void amdgpu_userq_kref_destroy(struct kref *kref)
 {
 	int r;
@@ -671,7 +689,7 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
 		container_of(kref, struct amdgpu_usermode_queue, refcount);
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 
-	r = amdgpu_userq_destroy(uq_mgr, queue);
+	r = amdgpu_userq_destroy(uq_mgr, queue, false);
 	if (r)
 		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
 }
@@ -689,10 +707,14 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
 	return queue;
 }
 
-void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
+void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked)
 {
-	if (queue)
-		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
+	if (queue) {
+		if (locked)
+			kref_put(&queue->refcount, amdgpu_userq_kref_destroy_locked);
+		else
+			kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
+	}
 }
 
 static int amdgpu_userq_priority_permit(struct drm_file *filp,
@@ -978,7 +1000,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (!queue)
 			return -ENOENT;
 
-		amdgpu_userq_put(queue);
+		amdgpu_userq_put(queue, false);
 		break;
 	}
 
@@ -1007,7 +1029,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
 			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
-			amdgpu_userq_put(queue);
+			amdgpu_userq_put(queue, true);
 			continue;
 		}
 
@@ -1015,7 +1037,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 		if (r)
 			ret = r;
 
-		amdgpu_userq_put(queue);
+		amdgpu_userq_put(queue, true);
 	}
 
 	if (ret)
@@ -1258,7 +1280,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 		r = amdgpu_userq_preempt_helper(queue);
 		if (r)
 			ret = r;
-		amdgpu_userq_put(queue);
+		amdgpu_userq_put(queue, true);
 	}
 
 	if (ret)
@@ -1298,17 +1320,17 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 		struct dma_fence *f = queue->last_fence;
 
 		if (!f || dma_fence_is_signaled(f)) {
-			amdgpu_userq_put(queue);
+			amdgpu_userq_put(queue, true);
 			continue;
 		}
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
 		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
-			amdgpu_userq_put(queue);
+			amdgpu_userq_put(queue, true);
 			return -ETIMEDOUT;
 		}
-		amdgpu_userq_put(queue);
+		amdgpu_userq_put(queue, true);
 	}
 
 	return 0;
@@ -1366,7 +1388,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 		if (!queue)
 			break;
 
-		amdgpu_userq_put(queue);
+		amdgpu_userq_put(queue, false);
 	}
 
 	xa_destroy(&userq_mgr->userq_xa);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index f0abc16d02cc..2a496e74ec6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -116,7 +116,7 @@ struct amdgpu_db_info {
 };
 
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
-void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
+void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked);
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 18390d37a7e0..10e08cb6bd13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -612,7 +612,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	kfree(syncobj_handles);
 
 	if (queue)
-		amdgpu_userq_put(queue);
+		amdgpu_userq_put(queue, false);
 
 	return r;
 }
@@ -914,7 +914,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 		r = 0;
 
 put_waitq:
-	amdgpu_userq_put(waitq);
+	amdgpu_userq_put(waitq, false);
 
 free_fences:
 	while (num_fences--)
-- 
2.34.1

