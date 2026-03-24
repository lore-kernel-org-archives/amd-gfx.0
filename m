Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C32F54ACF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 15:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53A610E5BA;
	Tue, 24 Mar 2026 15:25:22 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A167410E5BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 15:25:21 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62OFPGm11419933; Tue, 24 Mar 2026 20:55:16 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62OFPGNA1419932;
 Tue, 24 Mar 2026 20:55:16 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 2/2] drm/amdgpu/userq: schedule_delayed_work should be
 after fence signalled
Date: Tue, 24 Mar 2026 20:55:14 +0530
Message-Id: <20260324152514.1419906-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324152514.1419906-1-sunil.khatri@amd.com>
References: <20260324152514.1419906-1-sunil.khatri@amd.com>
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

Reorganise the amdgpu_eviction_fence_suspend_worker code so
schedule_delayed_work is the last thing we do after amdgpu_userq_evict
is complete and the eviction fence is signalled.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          | 3 +--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 641d03ef8608..5ae477c49a53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -76,7 +76,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	cookie = dma_fence_begin_signalling();
 
 	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
-	amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
+	amdgpu_userq_evict(uq_mgr);
 
 	/*
 	 * Signaling the eviction fence must be done while holding the
@@ -86,6 +86,10 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	dma_fence_signal(ev_fence);
 	dma_fence_end_signalling(cookie);
 	dma_fence_put(ev_fence);
+
+	if (!evf_mgr->shutdown)
+		schedule_delayed_work(&uq_mgr->resume_work, 0);
+
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 85c6a2256c4a..f312afae0e88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1298,7 +1298,7 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 }
 
 void
-amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr, bool schedule_resume)
+amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	int ret;
@@ -1312,8 +1312,6 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr, bool schedule_resume)
 	if (ret)
 		dev_err(adev->dev, "Failed to evict userqueue\n");
 
-	if (schedule_resume)
-		schedule_delayed_work(&uq_mgr->resume_work, 0);
 }
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index f0abc16d02cc..a4d44abf24fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -133,8 +133,7 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_userq_obj *userq_obj);
 
-void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
-			bool schedule_resume);
+void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
 
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
-- 
2.34.1

