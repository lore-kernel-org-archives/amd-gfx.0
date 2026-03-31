Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BD7FF60DE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 07:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE44710E8BB;
	Tue, 31 Mar 2026 07:49:52 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A7910E8BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 07:49:51 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62V7nlap2510993; Tue, 31 Mar 2026 13:19:47 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62V7nlO72510992;
 Tue, 31 Mar 2026 13:19:47 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v4 2/4] drm/amdgpu/userq: add the return code too in error
 condition
Date: Tue, 31 Mar 2026 13:19:41 +0530
Message-Id: <20260331074943.2510941-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331074943.2510941-1-sunil.khatri@amd.com>
References: <20260331074943.2510941-1-sunil.khatri@amd.com>
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

In function amdgpu_userq_restore
a. amdgpu_userq_vm_validate: add return code in error condition
b. amdgpu_userq_restore_all: It already prints the error log, just
   update the erorr log in the function and remove it from caller.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 79ee2f6e09da..c85a4f4eefcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1023,7 +1023,8 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	if (ret)
-		drm_file_err(uq_mgr->file, "Failed to map all the queues\n");
+		drm_file_err(uq_mgr->file,
+			     "Failed to map all the queues, restore failed ret=%d\n", ret);
 	return ret;
 }
 
@@ -1230,13 +1231,11 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 
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

