Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBC8CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666E010F785;
	Tue, 13 Oct 2026 11:21:29 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92AE310F79B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:21:25 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69DBLJQ61449607; Tue, 13 Oct 2026 16:51:19 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69DBLJMB1449606;
 Tue, 13 Oct 2026 16:51:19 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v4 2/2] drm/amdgpu: rename amdgpu_vmid_alloc/free_reserved to
 _spm
Date: Tue, 13 Oct 2026 16:51:12 +0530
Message-Id: <20261013112112.1449531-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013112112.1449531-1-sunil.khatri@amd.com>
References: <20261013112112.1449531-1-sunil.khatri@amd.com>
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

These functions only ever hand out the dedicated SPM VMID now, not a
generic reserved VMID. Rename them to amdgpu_vmid_alloc_spm() and
amdgpu_vmid_free_spm() to say so. Pure rename, no functional change.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index e5d84a786c4f2..f15702993eeab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -589,7 +589,7 @@ bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
 }
 
 /*
- * amdgpu_vmid_alloc_reserved - reserve a specific VMID for this vm
+ * amdgpu_vmid_alloc_spm - reserve a specific VMID for this vm
  * @adev: amdgpu device structure
  * @vm: the VM to reserve an ID for
  * @vmhub: the VMHUB which should be used
@@ -598,7 +598,7 @@ bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
  *
  * Returns: 0 for success, -ENOENT if an ID is already reserved.
  */
-int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			       unsigned vmhub)
 {
 	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
@@ -629,7 +629,7 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 }
 
 /*
- * amdgpu_vmid_free_reserved - free up a reserved VMID again
+ * amdgpu_vmid_free_spm - free up a reserved VMID again
  * @adev: amdgpu device structure
  * @vm: the VM with the reserved ID
  * @vmhub: the VMHUB which should be used
@@ -637,7 +637,7 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * Waits for all work that used the reserved VMID to finish before unbinding
  * its page table, so submissions still in flight don't suddenly fault.
  */
-void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			       unsigned vmhub)
 {
 	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index b85aa2ee19b19..c134000eecfdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -125,9 +125,9 @@ void amdgpu_pasid_mgr_cleanup(void);
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id);
 bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
-int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			       unsigned vmhub);
-void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			       unsigned vmhub);
 int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 		     struct amdgpu_job *job, struct dma_fence **fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7fd6215510a94..8d4c13f2ef7fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2894,7 +2894,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	dma_fence_put(vm->last_update);
 
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
-		amdgpu_vmid_free_reserved(adev, vm, i);
+		amdgpu_vmid_free_spm(adev, vm, i);
 	}
 
 	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
@@ -2997,7 +2997,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		int r;
 
 		/* We only have requirement to reserve vmid from gfxhub */
-		r = amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
+		r = amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(0));
 		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
 			amdgpu_vm_spm_update(adev, vm);
 			amdgpu_bo_unreserve(vm->root.bo);
@@ -3005,7 +3005,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return r;
 	}
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
-		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
+		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
 		break;
 	default:
 		return -EINVAL;
-- 
2.34.1

