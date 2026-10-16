Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC016CCA463
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 03:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D7810E2CB;
	Fri, 16 Oct 2026 03:07:47 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DE5810E223
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 03:07:45 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69G37Zw41091849; Fri, 16 Oct 2026 08:37:35 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69G37ZdF1091848;
 Fri, 16 Oct 2026 08:37:35 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping for userqueues
Date: Fri, 16 Oct 2026 08:37:34 +0530
Message-Id: <20261016030734.1091829-1-sunil.khatri@amd.com>
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
never signal completion. Commit it in
amdgpu_userq_vm_validate_and_restore_queue() too, the same way prt_va
is already handled there, so it covers both queue creation and
post-eviction restore.

Fixes: ae05e3f3d02b812c ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4dca1ab48410a..0c92534131b9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1083,6 +1083,14 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		if (unlikely(ret))
 			goto unlock_all;
 
+		if (fpriv->seq64_va) {
+			ret = drm_exec_prepare_obj(&exec, &fpriv->seq64_va->base.bo->tbo.base,
+						   TTM_NUM_MOVE_FENCES + 1);
+			drm_exec_retry_on_contention(&exec);
+			if (unlikely(ret))
+				goto unlock_all;
+		}
+
 		/*
 		 * WPTR BOs are VM-mapped, but each BO has its own reservation
 		 * object. Lock them into this drm_exec ww context so the later
@@ -1140,6 +1148,12 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
+	if (fpriv->seq64_va) {
+		ret = amdgpu_vm_bo_update(adev, fpriv->seq64_va, false);
+		if (ret)
+			goto unlock_all;
+	}
+
 	key = 0;
 	/* Validate User Ptr BOs */
 	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status) {
@@ -1203,6 +1217,10 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	 * it explicitly (as the CS path syncs it) before restarting queues.
 	 */
 	dma_fence_wait(fpriv->prt_va->last_pt_update, false);
+
+	if (fpriv->seq64_va)
+		dma_fence_wait(fpriv->seq64_va->last_pt_update, false);
+
 	dma_fence_wait(vm->last_update, false);
 
 	xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
-- 
2.34.1

