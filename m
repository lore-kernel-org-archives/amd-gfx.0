Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19D2E64007
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 06:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CFB810E318;
	Mon, 13 Apr 2026 06:22:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FD5810E319
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 06:22:01 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 63D6LuA64051050; Mon, 13 Apr 2026 11:51:56 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 63D6LuOX4051049;
 Mon, 13 Apr 2026 11:51:56 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 5/6] drm/amdgpu/userq: unmap is to be called before freeing
 doorbell/wptr bo
Date: Mon, 13 Apr 2026 11:51:52 +0530
Message-Id: <20260413062153.4050981-6-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413062153.4050981-1-sunil.khatri@amd.com>
References: <20260413062153.4050981-1-sunil.khatri@amd.com>
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

Unmap the queue after freeing doorbell and wptr memory is completely
wrong. Any operation on the queue needs the doorbell and wptr to be
valid and hence fixing the ordering.

Also since we are using amdgpu_bo_reserve in non interruptrable mode
so there is no need to check for its return values.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 28 +++++++++++------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6a635bb8bb30..86e7a93e93a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -635,21 +635,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	queue->hang_detect_fence = NULL;
 	amdgpu_userq_wait_for_last_fence(queue);
 
-	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
-	if (!r) {
-		amdgpu_bo_unpin(queue->db_obj.obj);
-		amdgpu_bo_unreserve(queue->db_obj.obj);
-	}
-	amdgpu_bo_unref(&queue->db_obj.obj);
-
-	r = amdgpu_bo_reserve(queue->wptr_obj.obj, true);
-	if (!r) {
-		amdgpu_bo_unpin(queue->wptr_obj.obj);
-		amdgpu_bo_unreserve(queue->wptr_obj.obj);
-	}
-	amdgpu_bo_unref(&queue->wptr_obj.obj);
-
-	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
 #endif
@@ -660,6 +645,19 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 	}
+
+	amdgpu_bo_reserve(queue->db_obj.obj, true);
+	amdgpu_bo_unpin(queue->db_obj.obj);
+	amdgpu_bo_unreserve(queue->db_obj.obj);
+	amdgpu_bo_unref(&queue->db_obj.obj);
+
+	amdgpu_bo_reserve(queue->wptr_obj.obj, true);
+	amdgpu_bo_unpin(queue->wptr_obj.obj);
+	amdgpu_bo_unreserve(queue->wptr_obj.obj);
+	amdgpu_bo_unref(&queue->wptr_obj.obj);
+
+	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
+
 	amdgpu_userq_cleanup(queue);
 	mutex_unlock(&uq_mgr->userq_mutex);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.34.1

