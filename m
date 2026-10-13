Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7520CA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C4F10F7A2;
	Tue, 13 Oct 2026 11:21:27 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08F910F79C
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:21:25 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69DBLJZS1449602; Tue, 13 Oct 2026 16:51:19 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69DBLJgX1449601;
 Tue, 13 Oct 2026 16:51:19 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v4 1/2] drm/amdgpu: bind the SPM VMID's page table to the
 reserving VM
Date: Tue, 13 Oct 2026 16:51:11 +0530
Message-Id: <20261013112112.1449531-1-sunil.khatri@amd.com>
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

MES userqueues bypass amdgpu_vm_flush(), so a reservation granted to a
userqueue never got its VMID's page table programmed. Add
amdgpu_vm_spm_update() to bind the fixed SPM VMID's page-table-base to
the reserving VM's root PD when that VM holds the reservation; it is a
no-op for every other VM. It is called right after a successful
AMDGPU_VM_OP_RESERVE_VMID (amdgpu_vm_ioctl(), under the root PD lock)
and from amdgpu_userq_vm_validate_and_restore_queue() (already locked
via drm_exec), the two paths that can actually change the binding.

amdgpu_vmid_free_reserved() waits for all work that used the reserved
VMID to finish, then unbinds it to a dummy address under the same lock
that clears the reservation, so in-flight submissions don't suddenly
fault and stray SPM accesses afterward fault instead of racing a new
reservation's binding.

Both binds go through the new amdgpu_gmc_bind_vmid() helper, which
pairs setup_vm_pt_regs() with the matching TLB flush for a VMID bound
outside the normal per-job VM flush path.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 24 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   | 13 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  7 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 47 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  1 +
 6 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 5d4276cd0f7d3..4204c3c750a8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -787,6 +787,30 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
 }
 
+/**
+ * amdgpu_gmc_bind_vmid - bind a VMID's page table base and flush its TLB
+ *
+ * @adev: amdgpu device pointer
+ * @vmhub: vmhub the VMID belongs to
+ * @vmid: VMID to bind
+ * @pd_addr: new page directory address, 0 to unbind to a faulting address
+ *
+ * For VMIDs that are bound directly to a VM's page table outside the
+ * normal per-job VM flush path, e.g. a dedicated out-of-pool VMID.
+ */
+void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
+			  unsigned int vmid, uint64_t pd_addr)
+{
+	bool is_mmhub = AMDGPU_IS_MMHUB0(vmhub) || AMDGPU_IS_MMHUB1(vmhub);
+
+	if (is_mmhub)
+		adev->mmhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
+	else
+		adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, pd_addr);
+
+	amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, TLB_FLUSH_LEGACY);
+}
+
 static void amdgpu_gmc_flush_pasid_regs(struct amdgpu_device *adev, u16 pasid,
 					u32 flush_type, bool all_hub,
 					u32 inst)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 76e6f1f96913c..d17055d4c50a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -444,6 +444,8 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
 void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			      uint32_t vmhub, uint32_t flush_type);
+void amdgpu_gmc_bind_vmid(struct amdgpu_device *adev, unsigned int vmhub,
+			  unsigned int vmid, uint64_t pd_addr);
 int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, u16 pasid,
 				   u32 flush_type, bool all_hub, u32 inst);
 int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, u16 pasid,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 074c6942d83b0..e5d84a786c4f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -633,16 +633,27 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * @adev: amdgpu device structure
  * @vm: the VM with the reserved ID
  * @vmhub: the VMHUB which should be used
+ *
+ * Waits for all work that used the reserved VMID to finish before unbinding
+ * its page table, so submissions still in flight don't suddenly fault.
  */
 void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			       unsigned vmhub)
 {
 	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
+	struct amdgpu_vmid *id;
 
 	mutex_lock(&id_mgr->lock);
-	if (vm->reserved_vmid[vmhub]) {
+	id = vm->reserved_vmid[vmhub];
+	if (id) {
 		vm->reserved_vmid[vmhub] = NULL;
 		id_mgr->reserved_vmid = false;
+
+		amdgpu_sync_wait(&id->active, false);
+
+		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
+			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
+					     adev->vm_manager.spm_vmid, 0);
 	}
 	mutex_unlock(&id_mgr->lock);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e29823ae8672e..d45357e092bb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1075,6 +1075,13 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		if (unlikely(ret))
 			goto unlock_all;
 
+		/*
+		 * Userqueues never go through amdgpu_vm_flush(), so this is
+		 * the only place that can rebind the SPM VMID's page table
+		 * for a userqueue-held reservation.
+		 */
+		amdgpu_vm_spm_update(adev, vm);
+
 		/* This locks and validates the remaining evicted BOs */
 		ret = amdgpu_userq_bo_validate(adev, &exec, vm);
 		drm_exec_retry_on_contention(&exec);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index de992405ed718..7fd6215510a94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -568,6 +568,41 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	return result;
 }
 
+/**
+ * amdgpu_vm_spm_update - bind the SPM VMID's page table base to @vm
+ *
+ * @adev: amdgpu device pointer
+ * @vm: vm to check against the SPM reservation
+ *
+ * The SPM VMID is fixed (adev->vm_manager.spm_vmid), so its page-table-base
+ * register must track whichever VM currently holds the reservation instead
+ * of being set per-job like a normal VMID. Bind it to @vm's real root PD
+ * address if @vm holds the reservation; otherwise do nothing, since @vm is
+ * not the one that could legitimately change the current binding.
+ *
+ * @vm's root PD must be locked by the caller.
+ */
+void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	struct amdgpu_kq_vmid_mgr *id_mgr =
+		&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)];
+	uint64_t pd_addr;
+
+	if (!adev->vm_manager.spm_vmid || !adev->gfxhub.funcs)
+		return;
+
+	mutex_lock(&id_mgr->lock);
+	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)] !=
+	    &id_mgr->ids[adev->vm_manager.spm_vmid] || !amdgpu_vm_ready(vm)) {
+		mutex_unlock(&id_mgr->lock);
+		return;
+	}
+
+	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
+	amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0), adev->vm_manager.spm_vmid, pd_addr);
+	mutex_unlock(&id_mgr->lock);
+}
+
 /**
  * amdgpu_vm_validate - validate evicted BOs tracked in the VM
  *
@@ -2958,9 +2993,17 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return -EINVAL;
 
 	switch (args->in.op) {
-	case AMDGPU_VM_OP_RESERVE_VMID:
+	case AMDGPU_VM_OP_RESERVE_VMID: {
+		int r;
+
 		/* We only have requirement to reserve vmid from gfxhub */
-		return amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
+		r = amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
+		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
+			amdgpu_vm_spm_update(adev, vm);
+			amdgpu_bo_unreserve(vm->root.bo);
+		}
+		return r;
+	}
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
 		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b8aa45db1d844..2a2a2ccbaa2cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -443,6 +443,7 @@ int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
 			      unsigned int num_fences);
 bool amdgpu_vm_ready(struct amdgpu_vm *vm);
 uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct ww_acquire_ctx *ticket,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
-- 
2.34.1

