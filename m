Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5BFCC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 17:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F6B10E1EF;
	Thu, 15 Oct 2026 17:44:52 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A5010E1EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 17:44:51 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69FHijZm948671; Thu, 15 Oct 2026 23:14:45 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69FHijI5948670;
 Thu, 15 Oct 2026 23:14:45 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping at queue creation
Date: Thu, 15 Oct 2026 23:14:44 +0530
Message-Id: <20261015174444.948651-1-sunil.khatri@amd.com>
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

The seq64 sync BO's PTE update only ran from the legacy CS path, so
userqueue-only clients never got it mapped and their fence_drv could
never signal completion. Add support for userqueues too.

Fixes: ae05e3f3d02b812c ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4dca1ab48410a..44cf25946a21c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -720,6 +720,27 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (r)
 		goto free_fence_drv;
 
+	/* Update the seq64 BO mapping in VM for User Queues */
+	if (fpriv->seq64_va) {
+		struct amdgpu_bo *seq64_bo = fpriv->seq64_va->base.bo;
+
+		r = amdgpu_bo_reserve(seq64_bo, false);
+		if (r) {
+			amdgpu_bo_unreserve(fpriv->vm.root.bo);
+			goto free_fence_drv;
+		}
+
+		r = amdgpu_vm_bo_update(adev, fpriv->seq64_va, false);
+		if (r) {
+			amdgpu_bo_unreserve(seq64_bo);
+			amdgpu_bo_unreserve(fpriv->vm.root.bo);
+			goto free_fence_drv;
+		}
+
+		dma_fence_wait(fpriv->seq64_va->last_pt_update, false);
+		amdgpu_bo_unreserve(seq64_bo);
+	}
+
 	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va,
 					   args->in.queue_size,
 					   &queue->userq_vas.va.queue_rb) ||
-- 
2.34.1

