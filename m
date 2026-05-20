Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D756ACD4F5B
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 02:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC9410E053;
	Wed, 20 May 2026 02:53:21 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005EE10E625
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 02:53:19 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64K2rAnT1866872; Wed, 20 May 2026 08:23:10 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64K2rAUC1866871;
 Wed, 20 May 2026 08:23:10 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/userq: refactor mqd_destroy code for cleaner
 cleanup
Date: Wed, 20 May 2026 08:22:57 +0530
Message-Id: <20260520025258.1866776-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520025258.1866776-1-sunil.khatri@amd.com>
References: <20260520025258.1866776-1-sunil.khatri@amd.com>
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

Use amdgpu_userq_destroy_object to unpin and unref the queue core
objects and rearrange the code to achieve that cleanly.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 17 +++++------------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 ++-
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 758bf099f0bc..7b86b70129af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -417,12 +417,10 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
-	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
 	/* Wait for mode-1 reset to complete */
 	down_read(&adev->reset_domain->sem);
 
-	uq_funcs->mqd_destroy(queue);
 	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
 	amdgpu_userq_fence_driver_free(queue);
@@ -611,7 +609,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_vm *vm = &fpriv->vm;
-
+	const struct amdgpu_userq_funcs *uq_funcs;
 	int r = 0;
 
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
@@ -635,16 +633,11 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_bo_unreserve(vm->root.bo);
 	list_del(&queue->userq_va_list);
 	queue->userq_mgr = NULL;
+	/* Destroy all the memory associate with the queue */
+	uq_funcs = adev->userq_funcs[queue->queue_type];
+	uq_funcs->mqd_destroy(queue);
+	amdgpu_userq_destroy_object(&queue->db_obj);
 
-	amdgpu_bo_reserve(queue->db_obj.obj, true);
-	amdgpu_bo_unpin(queue->db_obj.obj);
-	amdgpu_bo_unreserve(queue->db_obj.obj);
-	amdgpu_bo_unref(&queue->db_obj.obj);
-
-	amdgpu_bo_reserve(queue->wptr_obj.obj, true);
-	amdgpu_bo_unpin(queue->wptr_obj.obj);
-	amdgpu_bo_unreserve(queue->wptr_obj.obj);
-	amdgpu_bo_unref(&queue->wptr_obj.obj);
 	kfree(queue);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 69b36ebfe7ac..ea572d924621 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -445,9 +445,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
 {
-	amdgpu_userq_destroy_object(&queue->fw_obj);
 	kfree(queue->userq_prop);
+	amdgpu_userq_destroy_object(&queue->fw_obj);
 	amdgpu_userq_destroy_object(&queue->mqd);
+	amdgpu_userq_destroy_object(&queue->wptr_obj);
 }
 
 static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
-- 
2.34.1

