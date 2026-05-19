Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EB2CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 06:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2054710EA84;
	Tue, 19 May 2026 06:21:19 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B0010EA7F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 06:21:16 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 64J6LB8r439901; Tue, 19 May 2026 11:51:11 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 64J6LBQw439873;
 Tue, 19 May 2026 11:51:11 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v4 1/9] drm/amdgpu/userq: Fix doorbell cleanup on queue
 creation fail
Date: Tue, 19 May 2026 11:50:59 +0530
Message-Id: <20260519062107.438653-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519062107.438653-1-sunil.khatri@amd.com>
References: <20260519062107.438653-1-sunil.khatri@amd.com>
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

Unpin and unref the door bell obj if queue creation fails before
initialization is complete.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f1873f632547..4a50f6536f8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -782,7 +782,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
-		goto clean_mapping;
+		goto clean_doorbell;
 	}
 
 	r = uq_funcs->mqd_create(queue, &args->in);
@@ -851,6 +851,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	uq_funcs->mqd_destroy(queue);
 clean_fence_driver:
 	amdgpu_userq_fence_driver_free(queue);
+clean_doorbell:
+	amdgpu_bo_reserve(queue->db_obj.obj, true);
+	amdgpu_bo_unpin(queue->db_obj.obj);
+	amdgpu_bo_unreserve(queue->db_obj.obj);
+	amdgpu_bo_unref(&queue->db_obj.obj);
 clean_mapping:
 	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
-- 
2.34.1

