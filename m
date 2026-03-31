Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5926109B469
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 13:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3241B10E92E;
	Tue, 31 Mar 2026 13:47:09 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F57610E921
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 13:47:06 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62VDkv5D2762867; Tue, 31 Mar 2026 19:16:57 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62VDkvFj2762866;
 Tue, 31 Mar 2026 19:16:57 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v5 5/5] drm/amdgpu/userq: use dma_fence_wait_timeout without
 test for signalled
Date: Tue, 31 Mar 2026 19:16:54 +0530
Message-Id: <20260331134654.2762805-6-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331134654.2762805-1-sunil.khatri@amd.com>
References: <20260331134654.2762805-1-sunil.khatri@amd.com>
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

In function amdgpu_userq_wait_for_last_fence use
dma_fence_wait to wait infinitely.

Also there is no need to print error as we wont be
timing out anymore.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 31f45bd2732c..4136f1ac1e7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -427,23 +427,15 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 	return r;
 }
 
-static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
+static void amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct dma_fence *f = queue->last_fence;
-	int ret = 0;
 
-	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
-		if (ret <= 0) {
-			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
-				     f->context, f->seqno);
-			queue->state = AMDGPU_USERQ_STATE_HUNG;
-			return -ETIME;
-		}
-	}
+	if (!f)
+		return;
 
-	return ret;
+	dma_fence_wait(f, false);
 }
 
 static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
-- 
2.34.1

