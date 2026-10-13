Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64682CC6B13
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 07:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE9F910F5CC;
	Tue, 13 Oct 2026 07:56:54 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34A610F5CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 07:56:51 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69D7ukpc775266; Tue, 13 Oct 2026 13:26:46 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69D7uk2m775265;
 Tue, 13 Oct 2026 13:26:46 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 13/13] drm/amdgpu: bind the SPM VMID's page table to the
 reserving VM
Date: Tue, 13 Oct 2026 13:26:44 +0530
Message-Id: <20261013075644.775162-13-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013075644.775162-1-sunil.khatri@amd.com>
References: <20261013075644.775162-1-sunil.khatri@amd.com>
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
amdgpu_vm_spm_update(), called from amdgpu_vm_validate(), to bind the
fixed SPM VMID's page-table-base to the reserving VM's root PD when
that VM holds the reservation; it is a no-op for every other VM.
amdgpu_vmid_free_reserved() unbinds it directly to a dummy address
under the same lock that clears the reservation, so stray SPM accesses
fault instead of racing a new reservation's binding.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 37 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  1 +
 3 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 992f7cb3a3102..0ad94b09c6b46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -581,6 +581,12 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (vm->reserved_vmid[vmhub]) {
 		vm->reserved_vmid[vmhub] = NULL;
 		id_mgr->reserved_vmid = false;
+
+		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs) {
+			adev->gfxhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.spm_vmid, 0);
+			amdgpu_gmc_flush_gpu_tlb(adev, adev->vm_manager.spm_vmid,
+						 AMDGPU_GFXHUB(0), TLB_FLUSH_LEGACY);
+		}
 	}
 	mutex_unlock(&id_mgr->lock);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index de992405ed718..3967dadb8d425 100644
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
+	    &id_mgr->ids[adev->vm_manager.spm_vmid] || !vm->root.bo) {
+		mutex_unlock(&id_mgr->lock);
+		return;
+	}
+
+	pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
+	adev->gfxhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.spm_vmid, pd_addr);
+	amdgpu_gmc_flush_gpu_tlb(adev, adev->vm_manager.spm_vmid, AMDGPU_GFXHUB(0),
+				 TLB_FLUSH_LEGACY);
+	mutex_unlock(&id_mgr->lock);
+}
+
 /**
  * amdgpu_vm_validate - validate evicted BOs tracked in the VM
  *
@@ -630,6 +665,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		amdgpu_vm_bo_needs_update(bo_base);
 	}
 
+	amdgpu_vm_spm_update(adev, vm);
+
 	if (!ticket)
 		return 0;
 
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

