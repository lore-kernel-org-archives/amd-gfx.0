Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713BCCD4F50
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 14:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D782310E8BE;
	Mon, 18 May 2026 14:45:29 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5ABE10E8B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:45:27 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64IEjMcg3697801; Mon, 18 May 2026 20:15:22 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64IEjMdP3697800;
 Mon, 18 May 2026 20:15:22 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 8/8] drm/amdgpu/userq: make sure queue is valid in the
 hang_detect_work
Date: Mon, 18 May 2026 20:15:05 +0530
Message-Id: <20260518144505.3697615-9-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518144505.3697615-1-sunil.khatri@amd.com>
References: <20260518144505.3697615-1-sunil.khatri@amd.com>
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

Thread 1: Running amdgpu_userq_destroy which eventually remove
the queue from door bell and set userq_mgr = NULL.

Thread2: An interrupt might have scheduled the hang_detect_work
which still need userq_mgr to be valid but could get an NULL
ptrs.

To fix that make sure we cancel the hang_detect_work again before
setting userq_mgr to NULL.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8b0b53f80499..5c2e0c400d5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -427,7 +427,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
 	amdgpu_userq_fence_driver_free(queue);
 	queue->fence_drv = NULL;
-	queue->userq_mgr = NULL;
 	list_del(&queue->userq_va_list);
 
 	up_read(&adev->reset_domain->sem);
@@ -635,6 +634,10 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_userq_cleanup(queue);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
+	/* This is case an interrupt was fired and a hang detection work is pending */
+	cancel_delayed_work_sync(&queue->hang_detect_work);
+	queue->userq_mgr = NULL;
+
 	amdgpu_bo_reserve(queue->db_obj.obj, true);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unreserve(queue->db_obj.obj);
-- 
2.34.1

