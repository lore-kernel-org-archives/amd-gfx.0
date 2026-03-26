Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DD110A88F5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 17:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC9F610EB6A;
	Thu, 26 Mar 2026 17:45:22 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7720C10EB62
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 17:45:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62QHjCsZ3393983; Thu, 26 Mar 2026 23:15:12 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62QHjCwK3393982;
 Thu, 26 Mar 2026 23:15:12 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v3 2/4] drm/amdgpu/userq: add the return code too in error
 condition
Date: Thu, 26 Mar 2026 23:15:00 +0530
Message-Id: <20260326174502.3393880-3-sunil.khatri@amd.com>
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

In function amdgpu_userq_restore
a. amdgpu_userq_vm_validate: add return code in error condition
b. amdgpu_userq_restore_all: It already prints the error log, just
   update the erorr log in the function and remove it from caller.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cef7c2c8947c..c6fc7301423e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1023,7 +1023,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	if (ret)
-		drm_file_err(uq_mgr->file, "Failed to map all the queues\n");
+		drm_file_err(uq_mgr->file, "Failed to map all the queues, restore failed ret=%d\n", ret);
 	return ret;
 }
 
@@ -1230,13 +1230,11 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 
 	ret = amdgpu_userq_vm_validate(uq_mgr);
 	if (ret) {
-		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
+		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore ret=%d\n", ret);
 		goto put_fence;
 	}
 
-	ret = amdgpu_userq_restore_all(uq_mgr);
-	if (ret)
-		drm_file_err(uq_mgr->file, "Failed to restore all queues\n");
+	amdgpu_userq_restore_all(uq_mgr);
 
 put_fence:
 	dma_fence_put(ev_fence);
-- 
2.34.1

