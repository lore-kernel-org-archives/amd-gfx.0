Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FA9CA600B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 06:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9220310FC7D;
	Thu,  8 Oct 2026 06:52:49 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D9D10FC7C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 06:52:47 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 6986qbQS2945081; Thu, 8 Oct 2026 12:22:37 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 6986qa0m2945080;
 Thu, 8 Oct 2026 12:22:36 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/2] drm/amdgpu: rename first_kfd_vmid to first_userq_vmid
Date: Thu,  8 Oct 2026 12:22:33 +0530
Message-Id: <20261008065234.2945047-1-sunil.khatri@amd.com>
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

The boundary VMID is shared by KFD and KGD MES user queues alike,
not just KFD, so first_kfd_vmid is a misnomer. Rename it to
first_userq_vmid. Pure rename, no functional change.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 8 ++++----
 18 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3391e8c77f13b..38eef8e7155aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -789,7 +789,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
 {
 	if (adev->kfd.dev)
-		return vmid >= adev->vm_manager.first_kfd_vmid;
+		return vmid >= adev->vm_manager.first_userq_vmid;
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9cdd8870960a6..d2414b4656805 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -652,13 +652,13 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  *
  * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
- * first_kfd_vmid, shared by KFD and MES user queues.
+ * first_userq_vmid, shared by KFD and MES user queues.
  */
 static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
 {
 	adev->vm_manager.vmid_uq_mask_gfxhub =
 		((1U << AMDGPU_NUM_VMID) - 1) &
-		~((1U << adev->vm_manager.first_kfd_vmid) - 1);
+		~((1U << adev->vm_manager.first_userq_vmid) - 1);
 	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8e478d3bda1ac..4c407d705d0c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -383,7 +383,7 @@ struct amdgpu_vm {
 struct amdgpu_vm_manager {
 	/* Handling of VMIDs */
 	struct amdgpu_kq_vmid_mgr		id_mgr[AMDGPU_MAX_VMHUBS];
-	unsigned int				first_kfd_vmid;
+	unsigned int				first_userq_vmid;
 	bool					concurrent_flush;
 
 	uint64_t				max_pfn;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 33403e16df5ca..cd1f01604c4b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5214,7 +5214,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
@@ -5227,14 +5227,14 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
 	}
 
-	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_kfd_vmid,
+	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_userq_vmid,
 					AMDGPU_NUM_VMID);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d5f428ac19bf3..7d66f41aa8957 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2167,7 +2167,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 			SCRATCH_APP_BASE;
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		soc21_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
@@ -2185,7 +2185,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_GWS_VMID0, i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 420ce997bebc7..9245fc1c95767 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1808,7 +1808,7 @@ static void gfx_v12_0_init_compute_vmid(struct amdgpu_device *adev)
 			SCRATCH_APP_BASE;
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		soc24_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 4498e253846f1..4b7f90fa203b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1540,7 +1540,7 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	sh_mem_config = gfx_v12_1_get_sh_mem_config(adev);
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		soc_v1_0_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 549d1239e326b..0bdb800dafc64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1837,7 +1837,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 	sh_mem_config |= MTYPE_NONCACHED << SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT;
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		cik_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
@@ -1850,7 +1850,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index ab4123ddbb942..403ed29e7c0b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3682,7 +3682,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__PRIVATE_ATC_MASK;
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		vi_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
@@ -3695,7 +3695,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1678015ce5a97..231dacdf16548 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2610,7 +2610,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
@@ -2621,7 +2621,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
@@ -4933,10 +4933,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
 		gfx_v9_4_2_debug_trap_config_init(adev,
-			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
+			adev->vm_manager.first_userq_vmid, AMDGPU_NUM_VMID);
 	else
 		gfx_v9_0_debug_trap_config_init(adev,
-			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
+			adev->vm_manager.first_userq_vmid, AMDGPU_NUM_VMID);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 01ed1701c781a..1479dbc20c706 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1173,7 +1173,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
@@ -1191,7 +1191,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
+	for (i = adev->vm_manager.first_userq_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 490b4c4eb662a..259aca57a3ec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -869,9 +869,9 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 3cdc7893587a1..daec00725b969 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -854,10 +854,10 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
+	adev->vm_manager.first_userq_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index fcc1d580fa946..f3e9759833b77 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -997,19 +997,19 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 */
 	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
-		adev->vm_manager.first_kfd_vmid = 3;
+		adev->vm_manager.first_userq_vmid = 3;
 		adev->vm_manager.npa_vmid = 15;
 		mmhub_vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
 	} else {
-		adev->vm_manager.first_kfd_vmid = 8;
+		adev->vm_manager.first_userq_vmid = 8;
 	}
 
 	if (adev->gfx.disable_kq)
-		adev->vm_manager.first_kfd_vmid = 1;
+		adev->vm_manager.first_userq_vmid = 1;
 
 	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
 				      false);
 
 	amdgpu_vm_manager_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 71409eb718d39..2fb3b0687ab70 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -824,12 +824,12 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
 				      true);
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index c95e097241bf8..1208822b6ef8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1006,12 +1006,12 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
 				      true);
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 8d8a0775878ff..b21dc8fc6a9a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1121,12 +1121,12 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
 				      true);
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 85ba228f002d0..f9d2e82c34793 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2030,9 +2030,9 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	    adev->jpeg.disable_kq &&
 	    adev->vcn.disable_kq &&
 	    adev->sdma.no_user_submission)
-		adev->vm_manager.first_kfd_vmid = 1;
+		adev->vm_manager.first_userq_vmid = 1;
 	else
-		adev->vm_manager.first_kfd_vmid =
+		adev->vm_manager.first_userq_vmid =
 			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
 			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
 			 amdgpu_is_multi_aid(adev)) ?
@@ -2040,10 +2040,10 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 			8;
 
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
 				      false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
 				      true);
 	amdgpu_vm_manager_init(adev);
 
-- 
2.34.1

