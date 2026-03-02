Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19FDEB362A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 18:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE54010E57E;
	Mon,  2 Mar 2026 18:09:02 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51AE110E579
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 18:09:00 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 622I8tbY1344210; Mon, 2 Mar 2026 23:38:55 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 622I8tUo1344209;
 Mon, 2 Mar 2026 23:38:55 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu/userq: remove the unused variable from
 cleanup fn
Date: Mon,  2 Mar 2026 23:38:52 +0530
Message-Id: <20260302180852.1344171-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302180852.1344171-1-sunil.khatri@amd.com>
References: <20260302180852.1344171-1-sunil.khatri@amd.com>
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

Remove the queue_id which is no more needed in amdgpu_userq_cleanup
fn.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index bd62c95eeaad..2e54638af0d2 100644
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
@@ -657,7 +656,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 	}
-	amdgpu_userq_cleanup(queue, queue_id);
+	amdgpu_userq_cleanup(queue);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -1410,7 +1409,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 			continue;
 		amdgpu_userq_wait_for_last_fence(queue);
 		amdgpu_userq_unmap_helper(queue);
-		amdgpu_userq_cleanup(queue, queue_id);
+		amdgpu_userq_cleanup(queue);
 		amdgpu_userq_put(userq_mgr, queue_id);
 		/* Second put is for the reference taken in this function itself */
 		amdgpu_userq_put(userq_mgr, queue_id);
-- 
2.34.1

