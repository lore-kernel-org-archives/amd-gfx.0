Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB132CA6019
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 09:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6073210FFF0;
	Fri,  9 Oct 2026 09:40:10 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB06C10FFF4
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 09:40:08 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 6999e3UT3521917; Fri, 9 Oct 2026 15:10:03 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 6999e3kR3521916;
 Fri, 9 Oct 2026 15:10:03 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: amdgpu_vmid_mgr_set_vmid_mask to set up
 both hubs at once
Date: Fri,  9 Oct 2026 15:10:01 +0530
Message-Id: <20261009094001.3521891-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009094001.3521891-1-sunil.khatri@amd.com>
References: <20261009094001.3521891-1-sunil.khatri@amd.com>
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

Set the kernel and user-queue VMID pools for both hubs in one call.
The caller now just hands over each hub's raw kernel-queue mask;
vmid_uq_mask_gfxhub is derived here as its complement, and
vmid_uq_mask_mmhub is the fixed pool set here too, with npa_vmid
excluded from both MMHUB pools, instead of any of this being split
across a separate post-hoc fix-up or a field the caller had to
pre-compute itself.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 50 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 13 ++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 17 +++------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 28 ++++++--------
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 14 +++----
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 14 +++----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 14 +++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 24 +++++-------
 9 files changed, 75 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 55d6b2107d8f9..1c5bce0500ac9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -631,44 +631,48 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_vmid_mgr_set_vmid_mask - set the kernel-queue VMID pool for a
- * hub, and the matching user-queue mask on MMHUB
+ * amdgpu_vmid_mgr_set_vmid_mask - set the kernel- and user-queue VMID
+ * pools for both hubs
  *
  * @adev: amdgpu device structure
- * @vmid_mask: kernel-queue round-robin VMID mask for this hub
- * @for_mmhub: true to target MMHUB instances, false for GFXHUB
- *
- * On MMHUB, also sets vmid_uq_mask_mmhub to the fixed pool of VMIDs
- * MES/KFD use there, excluding npa_vmid (a VMID dedicated to a single
- * fixed purpose) from both the kernel- and user-queue masks; the
- * caller must already have set npa_vmid. vmid_uq_mask_gfxhub is set
- * directly by each generation's sw_init(), since unlike MMHUB's it
- * varies per generation.
+ * @gfx_vmid_mask: kernel-queue VMID pool mask for GFXHUB
+ * @mmhub_vmid_mask: kernel-queue VMID pool mask for MMHUB
+ *
+ * Sets both hubs' kernel-queue VMID pools (tracked least-recently-used
+ * via id_mgr[].ids_lru), and both hubs' KFD/MES user-queue masks.
+ * vmid_uq_mask_gfxhub is set to the
+ * complement of @gfx_vmid_mask, since unlike MMHUB's it is always a
+ * clean partition of the full VMID range; vmid_uq_mask_mmhub is the
+ * fixed pool set here instead, since MMHUB's kq and uq pools are
+ * allowed to overlap. A VMID dedicated to a single fixed purpose on
+ * MMHUB (npa_vmid) is excluded from both MMHUB pools; it is the
+ * caller's responsibility to have already set npa_vmid.
  */
 void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
-				   unsigned long vmid_mask, bool for_mmhub)
+				   unsigned long gfx_vmid_mask,
+				   unsigned long mmhub_vmid_mask)
 {
 	unsigned int i;
 
 	BUILD_BUG_ON(AMDGPU_NUM_VMID > BITS_PER_LONG);
 
-	if (for_mmhub && adev->vm_manager.npa_vmid)
-		vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
+	if (adev->vm_manager.npa_vmid)
+		mmhub_vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
 
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
 		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
 
-		if (is_mmhub == for_mmhub)
-			bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
-				    &vmid_mask, AMDGPU_NUM_VMID);
+		bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
+			    is_mmhub ? &mmhub_vmid_mask : &gfx_vmid_mask,
+			    AMDGPU_NUM_VMID);
 	}
 
-	if (for_mmhub) {
-		adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
-		if (adev->vm_manager.npa_vmid)
-			adev->vm_manager.vmid_uq_mask_mmhub &=
-				~BIT(adev->vm_manager.npa_vmid);
-	}
+	adev->vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
+
+	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
+	if (adev->vm_manager.npa_vmid)
+		adev->vm_manager.vmid_uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 73ac1b18e8487..4dfcec76afed7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -135,6 +135,7 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev);
 void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
 void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
 void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
-				   unsigned long vmid_mask, bool for_mmhub);
+				   unsigned long gfx_vmid_mask,
+				   unsigned long mmhub_vmid_mask);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index a95bfe22c640e..55d286275466d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -746,7 +746,6 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
 	struct amdgpu_device *adev = ip_block->adev;
-	unsigned long gfx_vmid_mask;
 
 	adev->gfxhub.funcs->init(adev);
 
@@ -867,15 +866,11 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/*
 	 * number of VMs
 	 * VMID 0 is reserved for System
-	 * amdgpu graphics/compute will use VMIDs 1-7
-	 * amdkfd will use VMIDs 8-15
+	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
+	 * amdkfd/MES user queues will use VMIDs 8-15
 	 */
-	gfx_vmid_mask = GENMASK(7, 1);
-
-	adev->vm_manager.vmid_uq_mask_gfxhub =
-		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
-	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(7, 1),
+				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 7b19c59a2f743..301ffb89c9672 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -745,8 +745,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
 	struct amdgpu_device *adev = ip_block->adev;
-	unsigned int first_userq_vmid;
-	unsigned long gfx_vmid_mask;
+	unsigned int last_kq_vmid;
 
 	adev->mmhub.funcs->init(adev);
 
@@ -853,16 +852,12 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/*
 	 * number of VMs
 	 * VMID 0 is reserved for System
-	 * amdgpu graphics/compute will use VMIDs 1-7
-	 * amdkfd will use VMIDs 8-15
+	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
+	 * amdkfd/MES user queues will use VMIDs 8-15
 	 */
-	first_userq_vmid = adev->gfx.disable_kq ? 1 : 8;
-	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
-
-	adev->vm_manager.vmid_uq_mask_gfxhub =
-		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
-	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
+	last_kq_vmid = adev->gfx.disable_kq ? 0 : 7;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(last_kq_vmid, 1),
+				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 9194130c25f29..e4a74cd6574f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -848,9 +848,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
 	struct amdgpu_device *adev = ip_block->adev;
 	uint64_t pte_addr_mask = 0;
-	u32 mmhub_vmid_mask;
-	unsigned int first_userq_vmid;
-	unsigned long gfx_vmid_mask;
+	unsigned int last_kq_vmid;
 	int i;
 
 	adev->mmhub.funcs->init(adev);
@@ -992,28 +990,24 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/*
 	 * number of VMs
 	 * VMID 0 is reserved for System
-	 * amdgpu graphics/compute will use VMIDs 1-7
-	 * amdkfd will use VMIDs 8-15.
-	 * On GFX 12.1, amdkfd will use VMIDs 3-15, with VMID 15 reserved
-	 * for NPA and therefore excluded from the MMHUB VMID pool.
+	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
+	 * amdkfd/MES user queues will use VMIDs 8-15.
+	 * On GFX 12.1, amdkfd/MES user queues will use VMIDs 3-15, with
+	 * VMID 15 reserved for NPA and therefore excluded from the
+	 * MMHUB VMID pool.
 	 */
-	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
-		first_userq_vmid = 3;
+		last_kq_vmid = 2;
 		adev->vm_manager.npa_vmid = 15;
 	} else {
-		first_userq_vmid = 8;
+		last_kq_vmid = 7;
 	}
 
 	if (adev->gfx.disable_kq)
-		first_userq_vmid = 1;
+		last_kq_vmid = 0;
 
-	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
-
-	adev->vm_manager.vmid_uq_mask_gfxhub =
-		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
-	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
-	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(last_kq_vmid, 1),
+				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 4e593e67221ff..a7c353d1ac09d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -768,7 +768,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
-	unsigned long gfx_vmid_mask;
+	unsigned long vmid_mask;
 
 	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
@@ -822,15 +822,11 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/*
 	 * number of VMs
 	 * VMID 0 is reserved for System
-	 * amdgpu graphics/compute will use VMIDs 1-7
-	 * amdkfd will use VMIDs 8-15
+	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
+	 * amdkfd/MES user queues will use VMIDs 8-15
 	 */
-	gfx_vmid_mask = GENMASK(7, 1);
-
-	adev->vm_manager.vmid_uq_mask_gfxhub =
-		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
-	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
+	vmid_mask = GENMASK(7, 1);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index bbb5c42b9d4ed..4199300eab177 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -941,7 +941,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
-	unsigned long gfx_vmid_mask;
+	unsigned long vmid_mask;
 
 	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
@@ -1004,15 +1004,11 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/*
 	 * number of VMs
 	 * VMID 0 is reserved for System
-	 * amdgpu graphics/compute will use VMIDs 1-7
-	 * amdkfd will use VMIDs 8-15
+	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
+	 * amdkfd/MES user queues will use VMIDs 8-15
 	 */
-	gfx_vmid_mask = GENMASK(7, 1);
-
-	adev->vm_manager.vmid_uq_mask_gfxhub =
-		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
-	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
+	vmid_mask = GENMASK(7, 1);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 25d47d2c288dd..3f9ec7427319d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1051,7 +1051,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
-	unsigned long gfx_vmid_mask;
+	unsigned long vmid_mask;
 
 	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
@@ -1119,15 +1119,11 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/*
 	 * number of VMs
 	 * VMID 0 is reserved for System
-	 * amdgpu graphics/compute will use VMIDs 1-7
-	 * amdkfd will use VMIDs 8-15
+	 * amdgpu graphics/compute kernel queues will use VMIDs 1-7
+	 * amdkfd/MES user queues will use VMIDs 8-15
 	 */
-	gfx_vmid_mask = GENMASK(7, 1);
-
-	adev->vm_manager.vmid_uq_mask_gfxhub =
-		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
-	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
+	vmid_mask = GENMASK(7, 1);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7ebf7b1299ff6..3a8dc15ef95b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1849,8 +1849,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
 	struct amdgpu_device *adev = ip_block->adev;
 	unsigned long inst_mask = adev->aid_mask;
-	unsigned int first_userq_vmid;
-	unsigned long gfx_vmid_mask;
+	unsigned int last_kq_vmid;
+	unsigned long vmid_mask;
 
 	adev->gfxhub.funcs->init(adev);
 
@@ -2019,8 +2019,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/*
 	 * number of VMs
 	 * VMID 0 is reserved for System
-	 * amdgpu graphics/compute will use VMIDs 1..n-1
-	 * amdkfd will use VMIDs n..15
+	 * amdgpu graphics/compute kernel queues will use VMIDs 1..n-1
+	 * amdkfd/MES user queues will use VMIDs n..15
 	 *
 	 * The first KFD VMID is 8 for GPUs with graphics, 3 for
 	 * compute-only GPUs. On compute-only GPUs that leaves 2 VMIDs
@@ -2032,21 +2032,17 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	    adev->jpeg.disable_kq &&
 	    adev->vcn.disable_kq &&
 	    adev->sdma.no_user_submission)
-		first_userq_vmid = 1;
+		last_kq_vmid = 0;
 	else
-		first_userq_vmid =
+		last_kq_vmid =
 			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
 			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
 			 amdgpu_is_multi_aid(adev)) ?
-			3 :
-			8;
+			2 :
+			7;
 
-	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
-
-	adev->vm_manager.vmid_uq_mask_gfxhub =
-		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
-	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
+	vmid_mask = GENMASK(last_kq_vmid, 1);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, vmid_mask, vmid_mask);
 	amdgpu_vm_manager_init(adev);
 
 	gmc_v9_0_save_registers(adev);
-- 
2.34.1

