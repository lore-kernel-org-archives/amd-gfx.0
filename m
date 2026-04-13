Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DC7F34C51
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 12:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 345F310E3C2;
	Mon, 13 Apr 2026 12:56:41 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C5D10E3C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 12:56:40 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 63DCuUCQ2239459; Mon, 13 Apr 2026 18:26:30 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 63DCuU0v2239458;
 Mon, 13 Apr 2026 18:26:30 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu/userq: unpin and unref doorbell and wptr outside
 mutex
Date: Mon, 13 Apr 2026 18:26:30 +0530
Message-Id: <20260413125630.2239439-1-sunil.khatri@amd.com>
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

In amdgpu_userq_destroy once unmap_helpder is called within mutex
there is no need to hold mutex.

This helps in avoiding a deadlock between doorbell and wptr ww mutex
and we could unpin and unref these bos outside mutex safely.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index d4e18b57be80..d66ed81a3fd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -444,7 +444,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 	queue->fence_drv = NULL;
 	queue->userq_mgr = NULL;
 	list_del(&queue->userq_va_list);
-	kfree(queue);
 
 	up_read(&adev->reset_domain->sem);
 }
@@ -650,6 +649,10 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 	}
 
+	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
+	amdgpu_userq_cleanup(queue);
+	mutex_unlock(&uq_mgr->userq_mutex);
+
 	amdgpu_bo_reserve(queue->db_obj.obj, true);
 	amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unreserve(queue->db_obj.obj);
@@ -659,11 +662,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_bo_unpin(queue->wptr_obj.obj);
 	amdgpu_bo_unreserve(queue->wptr_obj.obj);
 	amdgpu_bo_unref(&queue->wptr_obj.obj);
+	kfree(queue);
 
-	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
-
-	amdgpu_userq_cleanup(queue);
-	mutex_unlock(&uq_mgr->userq_mutex);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	return r;
-- 
2.34.1

