Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0258E98FB7
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 13:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A11010E4CD;
	Thu,  9 Apr 2026 13:39:16 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB2310E7F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 13:39:14 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 639Dd91Y1368265; Thu, 9 Apr 2026 19:09:09 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 639Dd9EN1368264;
 Thu, 9 Apr 2026 19:09:09 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu/userq: create_mqd does not need userq_mutex
Date: Thu,  9 Apr 2026 19:09:04 +0530
Message-Id: <20260409133906.1368219-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409133906.1368219-1-sunil.khatri@amd.com>
References: <20260409133906.1368219-1-sunil.khatri@amd.com>
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

Reshuffle the code to run create_mqd outside the mutex.
code here is mostly setting up software structure init
before actually registering the userqueue in the xa and
to the driver.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cf8c8dfde721..2408f888c4d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -793,14 +793,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto clean_mapping;
 	}
 
-	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
-
 	r = uq_funcs->mqd_create(queue, &args->in);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
 		goto clean_fence_driver;
 	}
 
+	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+
 	/* don't map the queue if scheduling is halted */
 	if (adev->userq_halt_for_enforce_isolation &&
 	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
@@ -812,7 +812,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
-			down_read(&adev->reset_domain->sem);
 			goto clean_mqd;
 		}
 	}
@@ -828,9 +827,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (r) {
 		if (!skip_map_queue)
 			amdgpu_userq_unmap_helper(queue);
-
 		r = -ENOMEM;
-		goto clean_mqd;
+		goto clean_reset_domain;
 	}
 
 	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
@@ -838,8 +836,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		xa_erase(&uq_mgr->userq_xa, qid);
 		if (!skip_map_queue)
 			amdgpu_userq_unmap_helper(queue);
-
-		goto clean_mqd;
+		goto clean_reset_domain;
 	}
 	up_read(&adev->reset_domain->sem);
 
@@ -851,12 +848,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	mutex_unlock(&uq_mgr->userq_mutex);
 	return 0;
 
+clean_reset_domain:
+	up_read(&adev->reset_domain->sem);
 clean_mqd:
+	mutex_unlock(&uq_mgr->userq_mutex);
 	uq_funcs->mqd_destroy(queue);
-	up_read(&adev->reset_domain->sem);
 clean_fence_driver:
 	amdgpu_userq_fence_driver_free(queue);
-	mutex_unlock(&uq_mgr->userq_mutex);
 clean_mapping:
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	kfree(queue);
-- 
2.34.1

