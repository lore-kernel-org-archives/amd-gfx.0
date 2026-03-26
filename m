Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD6710A88F5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 17:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A3010EB23;
	Thu, 26 Mar 2026 17:45:22 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7325110EB3F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 17:45:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62QHjCm33393993; Thu, 26 Mar 2026 23:15:12 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62QHjCmk3393992;
 Thu, 26 Mar 2026 23:15:12 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v3 4/4] drm/amdgpu/userq: use dma_fence_wait_timeout without
 test for signalled
Date: Thu, 26 Mar 2026 23:15:02 +0530
Message-Id: <20260326174502.3393880-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326174502.3393880-1-sunil.khatri@amd.com>
References: <20260326174502.3393880-1-sunil.khatri@amd.com>
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
dma_fence_wait_timeout directly instead of checking
for signalled fence first.

Return dma_fence_wait_timeout return value. Also update
the fence timeout log to differentiate where fence timedout.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9666f31e5f39..22c2bd4e71a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -433,14 +433,16 @@ static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
 	struct dma_fence *f = queue->last_fence;
 	int ret = 0;
 
-	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
-		if (ret <= 0) {
-			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
-				     f->context, f->seqno);
-			queue->state = AMDGPU_USERQ_STATE_HUNG;
-			return -ETIME;
-		}
+	if (!f)
+		return 0;
+
+	ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+	if (ret <= 0) {
+		drm_file_err(uq_mgr->file,
+			     "Timed out in wait_for_last_fence fence=%llu:%llu\n",
+			     f->context, f->seqno);
+		queue->state = AMDGPU_USERQ_STATE_HUNG;
+		return -ETIMEDOUT;
 	}
 
 	return ret;
-- 
2.34.1

