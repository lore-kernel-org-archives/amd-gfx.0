Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E58ECD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 13:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96B210E823;
	Mon, 18 May 2026 13:16:17 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F3410E811
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 13:16:13 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64IDG9Kb3501463; Mon, 18 May 2026 18:46:09 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64IDG94j3501462;
 Mon, 18 May 2026 18:46:09 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 2/6] drm/amdgpu/userq: Fix the mutex_init cleanup for
 fence_drv_lock
Date: Mon, 18 May 2026 18:46:04 +0530
Message-Id: <20260518131608.3501426-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518131608.3501426-1-sunil.khatri@amd.com>
References: <20260518131608.3501426-1-sunil.khatri@amd.com>
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

Mutex fence_drv_lock is cleanup in amdgpu_userq_fence_driver_free
but current cleanup is directly done later in the code which eventually
tried to do mutex_destroy two times.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4a50f6536f8d..d3971bf9112b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -777,14 +777,16 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	queue->doorbell_index = index;
-	mutex_init(&queue->fence_drv_lock);
-	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
+
 	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
 		goto clean_doorbell;
 	}
 
+	mutex_init(&queue->fence_drv_lock);
+	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
+
 	r = uq_funcs->mqd_create(queue, &args->in);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
@@ -860,7 +862,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	amdgpu_bo_unreserve(fpriv->vm.root.bo);
-	mutex_destroy(&queue->fence_drv_lock);
 free_queue:
 	kfree(queue);
 err_pm_runtime:
-- 
2.34.1

