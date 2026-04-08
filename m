Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E66FD5F70
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 05:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48B810E43A;
	Wed,  8 Apr 2026 05:36:15 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 712B610E33E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 05:36:12 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 6385a7am2894782; Wed, 8 Apr 2026 11:06:07 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 6385a63q2894775;
 Wed, 8 Apr 2026 11:06:06 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH V1 1/2] drm/amdgpu/userq: avoid uneccessary locking in
 amdgpu_userq_create
Date: Wed,  8 Apr 2026 11:06:02 +0530
Message-Id: <20260408053603.2894742-1-sunil.khatri@amd.com>
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

Reorganise code to avoid holding mutex userq_mutex while
also trying to grab exec lock ww_mutex where its not needed
for function amdgpu_userq_input_va_validate

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 33 +++++++++++------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3a6e7a569c78..3f502c18879a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -737,28 +737,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		return r;
 	}
 
-	/*
-	 * There could be a situation that we are creating a new queue while
-	 * the other queues under this UQ_mgr are suspended. So if there is any
-	 * resume work pending, wait for it to get done.
-	 *
-	 * This will also make sure we have a valid eviction fence ready to be used.
-	 */
-	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
-
 	uq_funcs = adev->userq_funcs[args->in.ip_type];
 	if (!uq_funcs) {
 		drm_file_err(uq_mgr->file, "Usermode queue is not supported for this IP (%u)\n",
 			     args->in.ip_type);
-		r = -EINVAL;
-		goto unlock;
+		return -EINVAL;
 	}
 
 	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
 	if (!queue) {
 		drm_file_err(uq_mgr->file, "Failed to allocate memory for queue\n");
-		r = -ENOMEM;
-		goto unlock;
+		return -ENOMEM;
 	}
 
 	INIT_LIST_HEAD(&queue->userq_va_list);
@@ -781,12 +770,21 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto free_queue;
 	}
 
+	/*
+	 * There could be a situation that we are creating a new queue while
+	 * the other queues under this UQ_mgr are suspended. So if there is any
+	 * resume work pending, wait for it to get done.
+	 *
+	 * This will also make sure we have a valid eviction fence ready to be used.
+	 */
+	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+
 	/* Convert relative doorbell offset into absolute doorbell index */
 	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
 	if (index == (uint64_t)-EINVAL) {
 		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
 		r = -EINVAL;
-		goto free_queue;
+		goto unlock;
 	}
 
 	queue->doorbell_index = index;
@@ -794,7 +792,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
-		goto free_queue;
+		goto unlock;
 	}
 
 	r = uq_funcs->mqd_create(queue, &args->in);
@@ -858,11 +856,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	up_read(&adev->reset_domain->sem);
 clean_fence_driver:
 	amdgpu_userq_fence_driver_free(queue);
-free_queue:
-	kfree(queue);
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
-
+free_queue:
+	kfree(queue);
 	return r;
 }
 
-- 
2.34.1

