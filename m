Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36E0CCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 14:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D59C10EC0C;
	Fri, 10 Oct 2025 14:07:44 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2FDE10EC0F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 14:07:42 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 59AE7bC44019181; Fri, 10 Oct 2025 19:37:37 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 59AE7bbn4019178;
 Fri, 10 Oct 2025 19:37:37 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v4 2/2] drm/amdgpu/userqueue: validate userptrs for userqueues
Date: Fri, 10 Oct 2025 19:37:12 +0530
Message-Id: <20251010140712.3983709-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010140712.3983709-1-sunil.khatri@amd.com>
References: <20251010140712.3983709-1-sunil.khatri@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 74 +++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8dc12064da49..e9f423cf11b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -29,6 +29,7 @@
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userq.h"
+#include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
@@ -758,12 +759,21 @@ static int
 amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	bool invalidated = false, new_addition = false;
+	struct ttm_operation_ctx ctx = { true, false };
 	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_hmm_range *range;
 	struct amdgpu_vm *vm = &fpriv->vm;
+	unsigned long key = 0, tmp_key;
 	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_bo *bo;
 	struct drm_exec exec;
+	struct xarray xa;
 	int ret;
 
+	xa_init(&xa);
+
+retry_lock:
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
 		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
@@ -794,6 +804,63 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
+	if (invalidated) {
+		xa_for_each(&xa, tmp_key, range) {
+			bo = range->bo;
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
+	key = 0;
+	/* Validate User Ptr BOs */
+	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
+		bo = bo_va->base.bo;
+
+		if (!amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
+			continue;
+
+		range = xa_load(&xa, key);
+		if (range && range->bo != bo) {
+			xa_erase(&xa, key);
+			amdgpu_hmm_range_free(range);
+			range = NULL;
+		}
+
+		if (!range) {
+			range = amdgpu_hmm_range_alloc(bo);
+			if (!range) {
+				ret = -ENOMEM;
+				goto unlock_all;
+			}
+
+			xa_store(&xa, key, range, GFP_KERNEL);
+			new_addition = true;
+		}
+		key++;
+	}
+
+	if (new_addition) {
+		drm_exec_fini(&exec);
+		xa_for_each(&xa, tmp_key, range) {
+			if (!range)
+				continue;
+			bo = range->bo;
+			ret = amdgpu_ttm_tt_get_user_pages(bo, range);
+			if (ret)
+				goto unlock_all;
+		}
+
+		invalidated = true;
+		new_addition = false;
+		goto retry_lock;
+	}
+
 	ret = amdgpu_vm_update_pdes(adev, vm, false);
 	if (ret)
 		goto unlock_all;
@@ -813,6 +880,13 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
 unlock_all:
 	drm_exec_fini(&exec);
+	xa_for_each(&xa, tmp_key, range) {
+		if (!range)
+			continue;
+		bo = range->bo;
+		amdgpu_hmm_range_free(range);
+	}
+	xa_destroy(&xa);
 	return ret;
 }
 
-- 
2.34.1

