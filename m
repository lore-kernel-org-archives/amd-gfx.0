Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2937108B90B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 12:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA1510E204;
	Fri, 20 Mar 2026 12:10:05 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D9710E204
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 12:10:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62KC9w7r3777055; Fri, 20 Mar 2026 17:39:58 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62KC9wQ33777054;
 Fri, 20 Mar 2026 17:39:58 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>,
 Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: cleanup amdgpu_userq_get/put where not
 needed
Date: Fri, 20 Mar 2026 17:39:57 +0530
Message-Id: <20260320120957.3777035-1-sunil.khatri@amd.com>
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

amdgpu_userq_put/get are not needed in case we already holding
the userq_mutex and reference is valid already from queue create
time or from signal ioctl. These additional get/put could be a
potential reason for deadlock in case the ref count reaches zero
and destroy is called which again try to take the userq_mutex.

Due to the above change we avoid deadlock between suspend/restore
calling destroy queues trying to take userq_mutex again.

Cc: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ced9ade44be4..3162edf19136 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -999,15 +999,11 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
-		queue = amdgpu_userq_get(uq_mgr, queue_id);
-		if (!queue)
-			continue;
 
 		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
 			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
-			amdgpu_userq_put(queue);
 			continue;
 		}
 
@@ -1015,7 +1011,6 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 		if (r)
 			ret = r;
 
-		amdgpu_userq_put(queue);
 	}
 
 	if (ret)
@@ -1251,14 +1246,10 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
-	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
-		queue = amdgpu_userq_get(uq_mgr, queue_id);
-		if (!queue)
-			continue;
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {;
 		r = amdgpu_userq_preempt_helper(queue);
 		if (r)
 			ret = r;
-		amdgpu_userq_put(queue);
 	}
 
 	if (ret)
@@ -1291,24 +1282,18 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 	int ret;
 
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
-		queue = amdgpu_userq_get(uq_mgr, queue_id);
-		if (!queue)
-			continue;
-
 		struct dma_fence *f = queue->last_fence;
 
-		if (!f || dma_fence_is_signaled(f)) {
-			amdgpu_userq_put(queue);
+		if (!f || dma_fence_is_signaled(f))
 			continue;
-		}
+
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
 		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
-			amdgpu_userq_put(queue);
+
 			return -ETIMEDOUT;
 		}
-		amdgpu_userq_put(queue);
 	}
 
 	return 0;
-- 
2.34.1

