Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4228EF54ACE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 15:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D9D10E46D;
	Tue, 24 Mar 2026 15:25:22 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF6A10E46D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 15:25:21 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62OFPGYe1419928; Tue, 24 Mar 2026 20:55:16 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62OFPFpO1419927;
 Tue, 24 Mar 2026 20:55:15 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/2] drm/amdgpu/userq: amdgpu_userq_vm_validate does not
 need userq mutex
Date: Tue, 24 Mar 2026 20:55:13 +0530
Message-Id: <20260324152514.1419906-1-sunil.khatri@amd.com>
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

amdgpu_userq_vm_validate function does not need userq_mutex and exec
lock is good enough to locking all bos and updating the eviction fence.

Also since we only need userq_mutex for amdgpu_userq_restore_all
so move the locks in the function itself.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a351383b432b..85c6a2256c4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -997,6 +997,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret = 0, r;
 
+	mutex_lock(&uq_mgr->userq_mutex);
 	/* Resume all the queues for this process */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
 
@@ -1012,6 +1013,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 			ret = r;
 
 	}
+	mutex_unlock(&uq_mgr->userq_mutex);
 
 	if (ret)
 		drm_file_err(uq_mgr->file, "Failed to map all the queues\n");
@@ -1215,23 +1217,21 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 	struct dma_fence *ev_fence;
 	int ret;
 
-	mutex_lock(&uq_mgr->userq_mutex);
 	ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
 	if (!dma_fence_is_signaled(ev_fence))
-		goto unlock;
+		goto put_fence;
 
 	ret = amdgpu_userq_vm_validate(uq_mgr);
 	if (ret) {
 		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
-		goto unlock;
+		goto put_fence;
 	}
 
 	ret = amdgpu_userq_restore_all(uq_mgr);
 	if (ret)
 		drm_file_err(uq_mgr->file, "Failed to restore all queues\n");
 
-unlock:
-	mutex_unlock(&uq_mgr->userq_mutex);
+put_fence:
 	dma_fence_put(ev_fence);
 }
 
-- 
2.34.1

