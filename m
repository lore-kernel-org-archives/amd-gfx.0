Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB347CA6012
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 09:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6576510FFF8;
	Fri,  9 Oct 2026 09:40:12 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D174110FFF0
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 09:40:08 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 6999e3j83521912; Fri, 9 Oct 2026 15:10:03 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 6999e2R33521911;
 Fri, 9 Oct 2026 15:10:02 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: store the user-queue VMID mask instead of
 first_kfd_vmid
Date: Fri,  9 Oct 2026 15:10:00 +0530
Message-Id: <20261009094001.3521891-1-sunil.khatri@amd.com>
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

first_kfd_vmid only ever existed to be turned back into a mask
(directly, or via range loops over VMIDs). Drop it and have each
generation set vmid_uq_mask_gfxhub directly instead, add
for_each_uq_vmid() to replace the range loops, and mask-test it in
amdgpu_amdkfd_is_kfd_vmid().

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 41 +++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h    | 16 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 +++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 20 ++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c    |  6 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h    |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 10 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 11 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 20 +++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 14 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 14 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 14 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 18 +++++-----
 21 files changed, 119 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3391e8c77f13b..e023cc734ebc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -789,7 +789,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
 {
 	if (adev->kfd.dev)
-		return vmid >= adev->vm_manager.first_kfd_vmid;
+		return !!(adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid));
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9cdd8870960a6..55d6b2107d8f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -630,6 +630,21 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
 	}
 }
 
+/**
+ * amdgpu_vmid_mgr_set_vmid_mask - set the kernel-queue VMID pool for a
+ * hub, and the matching user-queue mask on MMHUB
+ *
+ * @adev: amdgpu device structure
+ * @vmid_mask: kernel-queue round-robin VMID mask for this hub
+ * @for_mmhub: true to target MMHUB instances, false for GFXHUB
+ *
+ * On MMHUB, also sets vmid_uq_mask_mmhub to the fixed pool of VMIDs
+ * MES/KFD use there, excluding npa_vmid (a VMID dedicated to a single
+ * fixed purpose) from both the kernel- and user-queue masks; the
+ * caller must already have set npa_vmid. vmid_uq_mask_gfxhub is set
+ * directly by each generation's sw_init(), since unlike MMHUB's it
+ * varies per generation.
+ */
 void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
 				   unsigned long vmid_mask, bool for_mmhub)
 {
@@ -637,6 +652,9 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
 
 	BUILD_BUG_ON(AMDGPU_NUM_VMID > BITS_PER_LONG);
 
+	if (for_mmhub && adev->vm_manager.npa_vmid)
+		vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
+
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
 		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
 
@@ -644,22 +662,13 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
 			bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
 				    &vmid_mask, AMDGPU_NUM_VMID);
 	}
-}
 
-/**
- * amdgpu_vmid_uq_mask_init - init the user queue VMID masks
- *
- * @adev: amdgpu_device pointer
- *
- * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
- * first_kfd_vmid, shared by KFD and MES user queues.
- */
-static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
-{
-	adev->vm_manager.vmid_uq_mask_gfxhub =
-		((1U << AMDGPU_NUM_VMID) - 1) &
-		~((1U << adev->vm_manager.first_kfd_vmid) - 1);
-	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
+	if (for_mmhub) {
+		adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
+		if (adev->vm_manager.npa_vmid)
+			adev->vm_manager.vmid_uq_mask_mmhub &=
+				~BIT(adev->vm_manager.npa_vmid);
+	}
 }
 
 /**
@@ -673,8 +682,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 {
 	unsigned i, j;
 
-	amdgpu_vmid_uq_mask_init(adev);
-
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; ++i) {
 		struct amdgpu_kq_vmid_mgr *id_mgr =
 			&adev->vm_manager.id_mgr[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 21d6a41d1738a..73ac1b18e8487 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -56,6 +56,22 @@
 	     __vmid_mask; __vmid_mask = 0)				\
 		for_each_set_bit((vmid), &__vmid_mask, AMDGPU_NUM_VMID)
 
+/**
+ * for_each_uq_gfx_vmid - iterate over every VMID set in vmid_uq_mask_gfxhub
+ * @vmid:	loop cursor (int / unsigned int)
+ * @adev:	struct amdgpu_device *
+ *
+ * Equivalent to walking adev->vm_manager.vmid_uq_mask_gfxhub with
+ * for_each_set_bit().
+ *
+ * Relies on AMDGPU_NUM_VMID (16) fitting in a single unsigned long.
+ */
+#define for_each_uq_gfx_vmid(vmid, adev)					\
+	for (unsigned long __uq_vmid_mask =				\
+		(adev)->vm_manager.vmid_uq_mask_gfxhub;		\
+	     __uq_vmid_mask; __uq_vmid_mask = 0)			\
+		for_each_set_bit((vmid), &__uq_vmid_mask, AMDGPU_NUM_VMID)
+
 struct amdgpu_device;
 struct amdgpu_fpriv;
 struct amdgpu_vm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8e478d3bda1ac..d99e42ca308ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -383,7 +383,6 @@ struct amdgpu_vm {
 struct amdgpu_vm_manager {
 	/* Handling of VMIDs */
 	struct amdgpu_kq_vmid_mgr		id_mgr[AMDGPU_MAX_VMHUBS];
-	unsigned int				first_kfd_vmid;
 	bool					concurrent_flush;
 
 	uint64_t				max_pfn;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 33403e16df5ca..e791bf86ad571 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5178,19 +5178,12 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
 #define DEFAULT_SH_MEM_BASES	(0x6000)
 
 static void gfx_v10_0_debug_trap_config_init(struct amdgpu_device *adev,
-				uint32_t first_vmid,
-				uint32_t last_vmid)
+				uint32_t vmid_mask)
 {
 	uint32_t data;
-	uint32_t trap_config_vmid_mask = 0;
-	int i;
-
-	/* Calculate trap config vmid mask */
-	for (i = first_vmid; i < last_vmid; i++)
-		trap_config_vmid_mask |= (1 << i);
 
 	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
-			VMID_SEL, trap_config_vmid_mask);
+			VMID_SEL, vmid_mask);
 	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
 			TRAP_EN, 1);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
@@ -5214,7 +5207,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
@@ -5227,15 +5220,14 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
 	}
 
-	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_kfd_vmid,
-					AMDGPU_NUM_VMID);
+	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.vmid_uq_mask_gfxhub);
 }
 
 static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d5f428ac19bf3..1caecf26c4589 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2167,7 +2167,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 			SCRATCH_APP_BASE;
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		soc21_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
@@ -2185,7 +2185,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_GWS_VMID0, i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 420ce997bebc7..a5151e15e1011 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1808,7 +1808,7 @@ static void gfx_v12_0_init_compute_vmid(struct amdgpu_device *adev)
 			SCRATCH_APP_BASE;
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		soc24_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 4498e253846f1..4ceb3c0aa3322 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1540,7 +1540,7 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	sh_mem_config = gfx_v12_1_get_sh_mem_config(adev);
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		soc_v1_0_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 549d1239e326b..2eaea0e4864dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1837,7 +1837,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 	sh_mem_config |= MTYPE_NONCACHED << SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT;
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		cik_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
@@ -1850,7 +1850,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index ab4123ddbb942..696558f6f30d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3682,7 +3682,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__PRIVATE_ATC_MASK;
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		vi_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
@@ -3695,7 +3695,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1678015ce5a97..3fb51417ebee5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2568,19 +2568,12 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 }
 
 static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
-				uint32_t first_vmid,
-				uint32_t last_vmid)
+				uint32_t vmid_mask)
 {
 	uint32_t data;
-	uint32_t trap_config_vmid_mask = 0;
-	int i;
-
-	/* Calculate trap config vmid mask */
-	for (i = first_vmid; i < last_vmid; i++)
-		trap_config_vmid_mask |= (1 << i);
 
 	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
-			VMID_SEL, trap_config_vmid_mask);
+			VMID_SEL, vmid_mask);
 	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
 			TRAP_EN, 1);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
@@ -2610,7 +2603,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
@@ -2621,7 +2614,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
@@ -4932,11 +4925,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
-		gfx_v9_4_2_debug_trap_config_init(adev,
-			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
+		gfx_v9_4_2_debug_trap_config_init(adev);
 	else
 		gfx_v9_0_debug_trap_config_init(adev,
-			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
+			adev->vm_manager.vmid_uq_mask_gfxhub);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 54bcb5fdca242..f54f54fe535e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -836,16 +836,14 @@ void gfx_v9_4_2_init_sq(struct amdgpu_device *adev)
 	}
 }
 
-void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
-				uint32_t first_vmid,
-				uint32_t last_vmid)
+void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev)
 {
 	uint32_t data;
 	int i;
 
 	mutex_lock(&adev->srbm_mutex);
 
-	for (i = first_vmid; i < last_vmid; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		data = 0;
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index c8757de669eaa..ca240f4298da6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -24,8 +24,7 @@
 #ifndef __GFX_V9_4_2_H__
 #define __GFX_V9_4_2_H__
 
-void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
-				uint32_t first_vmid, uint32_t last_vmid);
+void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev);
 void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
 void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 01ed1701c781a..3572eb9b5758a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1173,7 +1173,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
@@ -1191,7 +1191,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for_each_uq_gfx_vmid(i, adev) {
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 490b4c4eb662a..a95bfe22c640e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -746,6 +746,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
 	struct amdgpu_device *adev = ip_block->adev;
+	unsigned long gfx_vmid_mask;
 
 	adev->gfxhub.funcs->init(adev);
 
@@ -869,10 +870,11 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
-				      false);
+	gfx_vmid_mask = GENMASK(7, 1);
+
+	adev->vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
 	amdgpu_vm_manager_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 3cdc7893587a1..7b19c59a2f743 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -745,6 +745,8 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
 	struct amdgpu_device *adev = ip_block->adev;
+	unsigned int first_userq_vmid;
+	unsigned long gfx_vmid_mask;
 
 	adev->mmhub.funcs->init(adev);
 
@@ -854,11 +856,12 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
+	first_userq_vmid = adev->gfx.disable_kq ? 1 : 8;
+	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
 
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
-				      false);
+	adev->vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
 	amdgpu_vm_manager_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index fcc1d580fa946..9194130c25f29 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -849,6 +849,8 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	uint64_t pte_addr_mask = 0;
 	u32 mmhub_vmid_mask;
+	unsigned int first_userq_vmid;
+	unsigned long gfx_vmid_mask;
 	int i;
 
 	adev->mmhub.funcs->init(adev);
@@ -997,26 +999,24 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 */
 	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
-		adev->vm_manager.first_kfd_vmid = 3;
+		first_userq_vmid = 3;
 		adev->vm_manager.npa_vmid = 15;
-		mmhub_vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
 	} else {
-		adev->vm_manager.first_kfd_vmid = 8;
+		first_userq_vmid = 8;
 	}
 
 	if (adev->gfx.disable_kq)
-		adev->vm_manager.first_kfd_vmid = 1;
+		first_userq_vmid = 1;
 
+	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
+
+	adev->vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
 	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
-				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
 
 	amdgpu_vm_manager_init(adev);
 
-	if (adev->vm_manager.npa_vmid)
-		adev->vm_manager.vmid_uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
-
 	r = amdgpu_gmc_ras_sw_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 71409eb718d39..4e593e67221ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -768,6 +768,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
+	unsigned long gfx_vmid_mask;
 
 	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
@@ -824,13 +825,12 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
-				      true);
+	gfx_vmid_mask = GENMASK(7, 1);
+
+	adev->vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index c95e097241bf8..bbb5c42b9d4ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -941,6 +941,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
+	unsigned long gfx_vmid_mask;
 
 	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
@@ -1006,13 +1007,12 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
-				      true);
+	gfx_vmid_mask = GENMASK(7, 1);
+
+	adev->vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 8d8a0775878ff..25d47d2c288dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1051,6 +1051,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
+	unsigned long gfx_vmid_mask;
 
 	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
@@ -1121,13 +1122,12 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
-				      true);
+	gfx_vmid_mask = GENMASK(7, 1);
+
+	adev->vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 85ba228f002d0..7ebf7b1299ff6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1849,6 +1849,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
 	struct amdgpu_device *adev = ip_block->adev;
 	unsigned long inst_mask = adev->aid_mask;
+	unsigned int first_userq_vmid;
+	unsigned long gfx_vmid_mask;
 
 	adev->gfxhub.funcs->init(adev);
 
@@ -2030,21 +2032,21 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	    adev->jpeg.disable_kq &&
 	    adev->vcn.disable_kq &&
 	    adev->sdma.no_user_submission)
-		adev->vm_manager.first_kfd_vmid = 1;
+		first_userq_vmid = 1;
 	else
-		adev->vm_manager.first_kfd_vmid =
+		first_userq_vmid =
 			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
 			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
 			 amdgpu_is_multi_aid(adev)) ?
 			3 :
 			8;
 
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
-				      true);
+	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
+
+	adev->vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
 	amdgpu_vm_manager_init(adev);
 
 	gmc_v9_0_save_registers(adev);
-- 
2.34.1

