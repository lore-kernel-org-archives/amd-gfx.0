Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8262C369A2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 12:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472A310E68A;
	Tue,  8 Apr 2025 12:42:12 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FE810E68A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 12:42:07 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 538CftMr950196; Tue, 8 Apr 2025 18:11:55 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 538CftP0950195;
 Tue, 8 Apr 2025 18:11:55 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 2/2] drm/amdgpu: update the error logging for more
 information
Date: Tue,  8 Apr 2025 18:11:50 +0530
Message-Id: <20250408124150.950175-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408124150.950175-1-sunil.khatri@amd.com>
References: <20250408124150.950175-1-sunil.khatri@amd.com>
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

add process and pid information in the userqueue error
logging to make it more useful in resolving the error
by logs.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index ecd49cf15b2a..3b55601b012f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -67,7 +67,8 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	if (f && !dma_fence_is_signaled(f)) {
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
 		if (ret <= 0) {
-			DRM_ERROR("Timed out waiting for fence f=%p\n", f);
+			DRM_ERROR("Timed out waiting for fence f=%p for process:%s:%d\n",
+				  f, uq_mgr->process_name, uq_mgr->pid);
 			return;
 		}
 	}
@@ -436,7 +437,8 @@ amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
 	}
 
 	if (ret)
-		DRM_ERROR("Failed to resume all the queue\n");
+		DRM_ERROR("Failed to resume all the queue for process:%s:%d\n",
+			  uq_mgr->process_name, uq_mgr->pid);
 	return ret;
 }
 
@@ -594,7 +596,8 @@ amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
 	}
 
 	if (ret)
-		DRM_ERROR("Couldn't suspend all the queues\n");
+		DRM_ERROR("Couldn't suspend all the queues for process:%s:%d\n",
+			  uq_mgr->process_name, uq_mgr->pid);
 	return ret;
 }
 
@@ -611,7 +614,8 @@ amdgpu_userqueue_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 			continue;
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
 		if (ret <= 0) {
-			DRM_ERROR("Timed out waiting for fence f=%p\n", f);
+			DRM_ERROR("Timed out waiting for fence f=%p for process:%s:%d\n",
+				  f, uq_mgr->process_name, uq_mgr->pid);
 			return -ETIMEDOUT;
 		}
 	}
@@ -630,13 +634,15 @@ amdgpu_userqueue_suspend(struct amdgpu_userq_mgr *uq_mgr,
 	/* Wait for any pending userqueue fence work to finish */
 	ret = amdgpu_userqueue_wait_for_signal(uq_mgr);
 	if (ret) {
-		DRM_ERROR("Not suspending userqueue, timeout waiting for work\n");
+		DRM_ERROR("Not suspending userqueue, timeout waiting for work process:%s:%d\n",
+			  uq_mgr->process_name, uq_mgr->pid);
 		return;
 	}
 
 	ret = amdgpu_userqueue_suspend_all(uq_mgr);
 	if (ret) {
-		DRM_ERROR("Failed to evict userqueue\n");
+		DRM_ERROR("Failed to evict userqueue for process:%s:%d\n",
+			  uq_mgr->process_name, uq_mgr->pid);
 		return;
 	}
 
-- 
2.34.1

