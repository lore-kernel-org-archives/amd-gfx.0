Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEF3106F304
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 08:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AD910EA4D;
	Thu, 26 Mar 2026 08:56:28 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E99710EA2E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 08:56:18 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62Q8u7Ht2665279; Thu, 26 Mar 2026 14:26:07 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62Q8u7VT2665278;
 Thu, 26 Mar 2026 14:26:07 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v1 2/4] drm/amdgpu/userq: no need to use local variable here
 for return
Date: Thu, 26 Mar 2026 14:25:59 +0530
Message-Id: <20260326085601.2665215-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326085601.2665215-1-sunil.khatri@amd.com>
References: <20260326085601.2665215-1-sunil.khatri@amd.com>
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

In function amdgpu_userq_restore_worker use directly
the function's return value in the if condition instead
of local variable ret.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2a1832fce6d2..2b07c3941927 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1222,20 +1222,17 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct dma_fence *ev_fence;
-	int ret;
 
 	ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
 	if (!dma_fence_is_signaled(ev_fence))
 		goto put_fence;
 
-	ret = amdgpu_userq_vm_validate(uq_mgr);
-	if (ret) {
+	if (amdgpu_userq_vm_validate(uq_mgr)) {
 		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
 		goto put_fence;
 	}
 
-	ret = amdgpu_userq_restore_all(uq_mgr);
-	if (ret)
+	if (amdgpu_userq_restore_all(uq_mgr))
 		drm_file_err(uq_mgr->file, "Failed to restore all queues\n");
 
 put_fence:
-- 
2.34.1

