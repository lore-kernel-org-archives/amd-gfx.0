Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DADFCAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 09:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AF310E896;
	Thu, 25 Sep 2025 09:02:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C9410E29A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 09:02:01 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 58P91u6r111329; Thu, 25 Sep 2025 14:31:56 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 58P91t4e111322;
 Thu, 25 Sep 2025 14:31:55 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v1] drm/amdgpu/userqueue: validate userptrs for userqueues
Date: Thu, 25 Sep 2025 14:31:54 +0530
Message-Id: <20250925090154.111303-1-sunil.khatri@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 76 +++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3bbe1001fda1..880bcc6edcbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -25,6 +25,8 @@
 #include <drm/drm_auth.h>
 #include <drm/drm_exec.h>
 #include <linux/pm_runtime.h>
+#include <linux/hmm.h>
+#include <drm/ttm/ttm_tt.h>
 
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
@@ -761,9 +763,19 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_bo *bo;
 	struct drm_exec exec;
+	struct xarray xa;
+	struct hmm_range *range;
+	unsigned long key = 0, tmp_key, count = 0;
 	int ret;
+	bool present;
+	bool invalidated = false;
+	struct ttm_operation_ctx ctx = { true, false };
+
+	xa_init(&xa);
 
+retry_lock:
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
 		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
@@ -794,6 +806,63 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
+	if (invalidated) {
+		tmp_key = 0;
+		xa_for_each(&xa, tmp_key, range) {
+			bo = range->dev_private_owner;
+			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
+			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+			if (ret)
+				goto unlock_all;
+
+			amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
+		}
+		invalidated = false;
+	}
+
+	/* Validate userptr BOs */
+	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
+		bo = bo_va->base.bo;
+		if (amdgpu_ttm_tt_is_userptr(bo->tbo.ttm)) {
+			tmp_key = 0;
+			present = false;
+			xa_for_each(&xa, tmp_key, range) {
+				if (range->dev_private_owner == bo) {
+					present = true;
+					break;
+				}
+			}
+
+			if (!present) {
+				range = kvmalloc(sizeof(*range), GFP_KERNEL);
+				if (!range) {
+					ret = -ENOMEM;
+					goto unlock_all;
+				}
+
+				xa_store(&xa, key++, range, GFP_KERNEL);
+				range->dev_private_owner = bo;
+				amdgpu_bo_ref(bo);
+			}
+		}
+	}
+
+	if (key && (key != count)) {
+		drm_file_err(uq_mgr->file, "userptr bos:%lu\n", key);
+		drm_exec_fini(&exec);
+		xa_for_each(&xa, tmp_key, range) {
+			if (!range)
+				continue;
+			bo = range->dev_private_owner;
+			ret = amdgpu_ttm_tt_get_user_pages(bo, range);
+			if (ret)
+				goto unlock_all;
+		}
+		count = key;
+		invalidated = true;
+		goto retry_lock;
+	}
+	/* End validate user ptr*/
 	ret = amdgpu_vm_update_pdes(adev, vm, false);
 	if (ret)
 		goto unlock_all;
@@ -813,6 +882,13 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
 unlock_all:
 	drm_exec_fini(&exec);
+	tmp_key = 0;
+	xa_for_each(&xa, tmp_key, range) {
+		bo = range->dev_private_owner;
+		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
+		amdgpu_bo_unref(&bo);
+	}
+	xa_destroy(&xa);
 	return ret;
 }
 
-- 
2.34.1

