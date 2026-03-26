Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9261810A88E6
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 17:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACEA10EB1F;
	Thu, 26 Mar 2026 17:45:22 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7112710EB23
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 17:45:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62QHjCRK3393978; Thu, 26 Mar 2026 23:15:12 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62QHjC4h3393977;
 Thu, 26 Mar 2026 23:15:12 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v3 1/4] drm/amdgpu/userq: dont check return value in
 amdgpu_userq_evict
Date: Thu, 26 Mar 2026 23:14:59 +0530
Message-Id: <20260326174502.3393880-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326174502.3393880-1-sunil.khatri@amd.com>
References: <20260326174502.3393880-1-sunil.khatri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In function amdgpu_userq_evict we do not need to check
for return values and print errors as we are already
print error in all the functions of amdgpu_userq_evict.

a. amdgpu_userq_wait_for_signal: Could timeout and we print
   error message in the function already
b. amdgpu_userq_evict_all: We unmap all the queues here and
   in case of unmap failure we already print unmap error.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index fdae8c411aaa..cef7c2c8947c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1258,7 +1258,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	}
 
 	if (ret)
-		drm_file_err(uq_mgr->file, "Couldn't unmap all the queues\n");
+		drm_file_err(uq_mgr->file, "Couldn't unmap all the queues, eviction failed\n");
 	return ret;
 }
 
@@ -1289,12 +1289,13 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
 		struct dma_fence *f = queue->last_fence;
 
-		if (!f || dma_fence_is_signaled(f))
+		if (!f)
 			continue;
 
-		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
+		ret = dma_fence_wait_timeout(f, false, MAX_SCHEDULE_TIMEOUT);
 		if (ret <= 0) {
-			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
+			drm_file_err(uq_mgr->file,
+				     "Timed out in wait_for_signal fence=%llu:%llu\n",
 				     f->context, f->seqno);
 
 			return -ETIMEDOUT;
@@ -1307,18 +1308,10 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 void
 amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
 {
-	struct amdgpu_device *adev = uq_mgr->adev;
-	int ret;
-
 	/* Wait for any pending userqueue fence work to finish */
-	ret = amdgpu_userq_wait_for_signal(uq_mgr);
-	if (ret)
-		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
-
-	ret = amdgpu_userq_evict_all(uq_mgr);
-	if (ret)
-		dev_err(adev->dev, "Failed to evict userqueue\n");
-
+	amdgpu_userq_wait_for_signal(uq_mgr);
+	/* unmaps all the queues */
+	amdgpu_userq_evict_all(uq_mgr);
 }
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
-- 
2.34.1

