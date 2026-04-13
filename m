Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E5CF45A0F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 06:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C59910E316;
	Mon, 13 Apr 2026 06:22:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730A310E31C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 06:22:01 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 63D6Luiq4051045; Mon, 13 Apr 2026 11:51:56 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 63D6LuGl4051044;
 Mon, 13 Apr 2026 11:51:56 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 4/6] drm/amdgpu/userq: use pm_runtime_resume_and_get and
 fix err handling
Date: Mon, 13 Apr 2026 11:51:51 +0530
Message-Id: <20260413062153.4050981-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413062153.4050981-1-sunil.khatri@amd.com>
References: <20260413062153.4050981-1-sunil.khatri@amd.com>
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

Use pm_runtime_resume_and_get instead of pm_runtime_get_sync as it
return error but put the reference in the function itself.

In goto statements we need to drop the pm reference too.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 76badb4d4a81..6a635bb8bb30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -734,10 +734,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (r)
 		return r;
 
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	r = pm_runtime_resume_and_get(adev_to_drm(adev)->dev);
 	if (r < 0) {
-		drm_file_err(uq_mgr->file, "pm_runtime_get_sync() failed for userqueue create\n");
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		drm_file_err(uq_mgr->file, "pm_runtime_resume_and_get() failed for userqueue create\n");
 		return r;
 	}
 
@@ -745,13 +744,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (!uq_funcs) {
 		drm_file_err(uq_mgr->file, "Usermode queue is not supported for this IP (%u)\n",
 			     args->in.ip_type);
-		return -EINVAL;
+		r = -EINVAL;
+		goto err_pm_runtime;
 	}
 
 	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
 	if (!queue) {
 		drm_file_err(uq_mgr->file, "Failed to allocate memory for queue\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto err_pm_runtime;
 	}
 
 	INIT_LIST_HEAD(&queue->userq_va_list);
@@ -865,6 +866,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	amdgpu_bo_unreserve(fpriv->vm.root.bo);
 free_queue:
 	kfree(queue);
+err_pm_runtime:
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 	return r;
 }
 
-- 
2.34.1

