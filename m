Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749A5CC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 466B310F62E;
	Tue, 13 Oct 2026 08:49:46 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8A610F624
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:49:43 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69D8ncPV972405; Tue, 13 Oct 2026 14:19:38 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69D8nc0E972402;
 Tue, 13 Oct 2026 14:19:38 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 02/14] drm/amdgpu: add spm_vmid and exclude it from the MES,
 KFD and kq pools
Date: Tue, 13 Oct 2026 14:19:25 +0530
Message-Id: <20261013084937.972181-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013084937.972181-1-sunil.khatri@amd.com>
References: <20261013084937.972181-1-sunil.khatri@amd.com>
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

The SPM (Streaming Performance Monitor) path needs a VMID that is
isolated from other GPU contexts. Introduce vm_manager.spm_vmid to let
a GFXHUB dedicate a VMID to SPM.

When spm_vmid is set, exclude it from both the kernel-queue pool and
vmid_uq_mask_gfxhub, so neither the round-robin kernel-queue allocator
nor MES/Userqueues ever maps another context onto it.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 46 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 ++
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 392a18b1f2b4b..ed1efde29a9a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -638,26 +638,45 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
  * @vmid_kq_mask_gfxhub: kernel-queue VMID pool mask for GFXHUB
  * @vmid_kq_mask_mmhub: kernel-queue VMID pool mask for MMHUB
  *
- * Sets both hubs' kernel-queue VMID pools (tracked least-recently-used
- * via id_mgr[].ids_lru), and both hubs' KFD/MES user-queue masks.
- * vmid_uq_mask_gfxhub is set to the
- * complement of @vmid_kq_mask_gfxhub, since unlike MMHUB's it is always a
- * clean partition of the full VMID range; vmid_uq_mask_mmhub is the
- * fixed pool set here instead, since MMHUB's kq and uq pools are
- * allowed to overlap. A VMID dedicated to a single fixed purpose on
- * MMHUB (npa_vmid) is excluded from both MMHUB pools; it is the
- * caller's responsibility to have already set npa_vmid.
+ * Sets both GFXHUB and MMHUB kernel-queue VMID pools
+ * via id_mgr[].ids_lru, and KFD/MES user-queue masks too.
  */
 void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
 				   unsigned long vmid_kq_mask_gfxhub,
 				   unsigned long vmid_kq_mask_mmhub)
 {
+	unsigned long uq_mask_gfxhub, uq_mask_mmhub;
 	unsigned int i;
 
 	BUILD_BUG_ON(AMDGPU_NUM_VMID > BITS_PER_LONG);
 
-	if (adev->vm_manager.npa_vmid)
+	/*
+	 * Derive the uq masks from the kq masks as given, then carve each
+	 * hub's dedicated out-of-pool VMID out of both of that hub's pools.
+	 */
+	uq_mask_gfxhub = GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~vmid_kq_mask_gfxhub;
+	uq_mask_mmhub = 0xFF00;
+
+	/*
+	 * SPM uses a dedicated vmid that is reserved from gfxhub.
+	 * Unmask the reserved vmids from both user and kernel queues
+	 */
+	if (adev->vm_manager.spm_vmid) {
+		vmid_kq_mask_gfxhub &= ~BIT(adev->vm_manager.spm_vmid);
+		uq_mask_gfxhub &= ~BIT(adev->vm_manager.spm_vmid);
+	}
+
+	/*
+	 * NPA uses a dedicated vmid that is reserved from mmhub.
+	 * Unmask the reserved VMIDs from both user and kernel queues
+	 */
+	if (adev->vm_manager.npa_vmid) {
 		vmid_kq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
+		uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
+	}
+
+	adev->vm_manager.vmid_uq_mask_gfxhub = uq_mask_gfxhub;
+	adev->vm_manager.vmid_uq_mask_mmhub = uq_mask_mmhub;
 
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
 		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
@@ -666,13 +685,6 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
 			    is_mmhub ? &vmid_kq_mask_mmhub : &vmid_kq_mask_gfxhub,
 			    AMDGPU_NUM_VMID);
 	}
-
-	adev->vm_manager.vmid_uq_mask_gfxhub =
-		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~vmid_kq_mask_gfxhub;
-
-	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
-	if (adev->vm_manager.npa_vmid)
-		adev->vm_manager.vmid_uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d99e42ca308ef..ddcdc7256ef07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -411,7 +411,9 @@ struct amdgpu_vm_manager {
 
 	/* Global registration of recent page fault information */
 	struct amdgpu_vm_fault_info		fault_info;
+	/* VMIDs dedicated to a single fixed purpose, 0 if unused */
 	unsigned int				npa_vmid;
+	unsigned int				spm_vmid;
 
 	/* VMID masks for GFXHUB and MMHUB */
 	uint32_t				vmid_uq_mask_gfxhub;
-- 
2.34.1

