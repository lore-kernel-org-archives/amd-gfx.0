Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE064CA101F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 08:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4407010E01F;
	Fri, 12 Sep 2025 08:07:37 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7065610E01F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 08:07:35 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 58C87Tml1746965; Fri, 12 Sep 2025 13:37:29 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 58C87ShK1746964;
 Fri, 12 Sep 2025 13:37:28 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu/userqueue: validate userptrs for userqueues
Date: Fri, 12 Sep 2025 13:37:17 +0530
Message-Id: <20250912080717.1746879-1-sunil.khatri@amd.com>
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

userptrs could be changed by the user at any time and
hence while locking all the bos before GPU start processing
validate all the userptr bos.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 89 +++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 428f5e8f1cfc..5201f1c1f94d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -25,6 +25,7 @@
 #include <drm/drm_auth.h>
 #include <drm/drm_exec.h>
 #include <linux/pm_runtime.h>
+#include <drm/ttm/ttm_tt.h>
 
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
@@ -708,6 +709,89 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 	return 0;
 }
 
+static int
+amdgpu_validate_userptr(struct amdgpu_vm *vm)
+{
+	struct amdgpu_bo_va *bo_va;
+	struct xarray xa;
+	unsigned long key = 0;
+	struct hmm_range *range = NULL;
+	bool userpage_invalidated = false;
+	struct page **user_pages;
+	struct amdgpu_bo *bo;
+	unsigned int i;
+	int ret;
+	struct ttm_operation_ctx ctx = { true, false };
+
+	xa_init(&xa);
+	spin_lock(&vm->invalidated_lock);
+	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
+		bo = bo_va->base.bo;
+		spin_unlock(&vm->invalidated_lock);
+		if (!bo) {
+			spin_lock(&vm->invalidated_lock);
+			continue;
+		}
+
+		if (amdgpu_ttm_tt_is_userptr(bo->tbo.ttm)) {
+			xa_store(&xa, key++, bo, GFP_KERNEL);
+		} else {
+			spin_lock(&vm->invalidated_lock);
+			continue;
+		}
+		spin_lock(&vm->invalidated_lock);
+	}
+	spin_unlock(&vm->invalidated_lock);
+
+	/* go through the xarray to see if any of the bo userptr needs validation */
+	bo = NULL;
+	xa_for_each(&xa, key, bo) {
+		user_pages = kvcalloc(bo->tbo.ttm->num_pages,
+				 sizeof(struct page *),
+					 GFP_KERNEL);
+		if (!user_pages) {
+			DRM_ERROR("kvmalloc_array failure\n");
+			xa_destroy(&xa);
+			return -ENOMEM;
+		}
+
+		ret = amdgpu_ttm_tt_get_user_pages(bo, user_pages, &range);
+		if (ret) {
+			kvfree(user_pages);
+			xa_destroy(&xa);
+			return -EFAULT;
+		}
+
+		for (i = 0; i < bo->tbo.ttm->num_pages; i++) {
+			if (bo->tbo.ttm->pages[i] != user_pages[i]) {
+				userpage_invalidated = true;
+				break;
+			}
+		}
+
+		// Check if pages are invalidated for the bo and validate again.
+		if (userpage_invalidated) {
+			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
+			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+			if (ret) {
+				amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
+				kvfree(user_pages);
+				xa_destroy(&xa);
+				return -EFAULT;
+			}
+
+			amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, user_pages);
+		}
+
+		kvfree(user_pages);
+		user_pages = NULL;
+		range = NULL;
+	}
+
+	xa_destroy(&xa);
+	return 0;
+}
+
 /* Make sure the whole VM is ready to be used */
 static int
 amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
@@ -749,6 +833,11 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
+	/* Valids bos which are userptr bos */
+	ret = amdgpu_validate_userptr(vm);
+	if (ret)
+		goto unlock_all;
+
 	ret = amdgpu_vm_update_pdes(adev, vm, false);
 	if (ret)
 		goto unlock_all;
-- 
2.34.1

