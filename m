Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D1ACA600D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 06:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911D810E74E;
	Thu,  8 Oct 2026 06:52:48 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD3110E74E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 06:52:47 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 6986qbox2945086; Thu, 8 Oct 2026 12:22:37 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 6986qb0c2945085;
 Thu, 8 Oct 2026 12:22:37 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 2/2] drm/amdgpu: let amdgpu_vmid_mgr_set_vmid_mask set up
 both hubs at once
Date: Thu,  8 Oct 2026 12:22:34 +0530
Message-Id: <20261008065234.2945047-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008065234.2945047-1-sunil.khatri@amd.com>
References: <20261008065234.2945047-1-sunil.khatri@amd.com>
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

Set the kernel- and user-queue VMID pools for both hubs in one call
instead of two calls plus a separate amdgpu_vmid_uq_mask_init() step,
so a hub's full VMID layout lives in one place.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 46 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  |  6 +---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   |  5 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  5 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  5 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  5 +--
 9 files changed, 36 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index d2414b4656805..60c52042ff540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -630,8 +630,27 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
 	}
 }
 
+/**
+ * amdgpu_vmid_mgr_set_vmid_mask - set the kernel- and user-queue VMID
+ * pools for both hubs
+ *
+ * @adev: amdgpu device structure
+ * @gfx_vmid_mask: kernel-queue round-robin VMID mask for GFXHUB
+ * @mmhub_vmid_mask: kernel-queue round-robin VMID mask for MMHUB
+ *
+ * Sets both hubs' kernel-queue round-robin pools. The KFD/MES
+ * user-queue pool is set alongside them: on GFXHUB it is whatever
+ * @gfx_vmid_mask leaves behind, since every generation's GFXHUB kq/uq
+ * split is a clean partition of the full VMID range; on MMHUB it is the
+ * fixed VMIDs 8-15, since MMHUB's kq and uq pools are allowed to overlap
+ * and are not generally complementary. A VMID dedicated to a single
+ * fixed purpose on MMHUB (npa_vmid) is excluded from both MMHUB pools;
+ * it is the caller's responsibility to have already set npa_vmid, and to
+ * exclude it from @mmhub_vmid_mask as well.
+ */
 void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
-				   unsigned long vmid_mask, bool for_mmhub)
+				   unsigned long gfx_vmid_mask,
+				   unsigned long mmhub_vmid_mask)
 {
 	unsigned int i;
 
@@ -640,26 +659,17 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
 		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
 
-		if (is_mmhub == for_mmhub)
-			bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
-				    &vmid_mask, AMDGPU_NUM_VMID);
+		bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
+			    is_mmhub ? &mmhub_vmid_mask : &gfx_vmid_mask,
+			    AMDGPU_NUM_VMID);
 	}
-}
 
-/**
- * amdgpu_vmid_uq_mask_init - init the user queue VMID masks
- *
- * @adev: amdgpu_device pointer
- *
- * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
- * first_userq_vmid, shared by KFD and MES user queues.
- */
-static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
-{
 	adev->vm_manager.vmid_uq_mask_gfxhub =
-		((1U << AMDGPU_NUM_VMID) - 1) &
-		~((1U << adev->vm_manager.first_userq_vmid) - 1);
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
+
 	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
+	if (adev->vm_manager.npa_vmid)
+		adev->vm_manager.vmid_uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
 }
 
 /**
@@ -673,8 +683,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 {
 	unsigned i, j;
 
-	amdgpu_vmid_uq_mask_init(adev);
-
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; ++i) {
 		struct amdgpu_kq_vmid_mgr *id_mgr =
 			&adev->vm_manager.id_mgr[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 21d6a41d1738a..353986452fb54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -119,6 +119,7 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev);
 void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
 void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
 void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
-				   unsigned long vmid_mask, bool for_mmhub);
+				   unsigned long gfx_vmid_mask,
+				   unsigned long mmhub_vmid_mask);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 259aca57a3ec0..369881267ebb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -872,8 +872,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
 				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
+				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index daec00725b969..afdf3153976b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -858,8 +858,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
 				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
+				      GENMASK(AMDGPU_NUM_VMID - 1, 1));
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index f3e9759833b77..31cfe1a874bc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -1007,16 +1007,12 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (adev->gfx.disable_kq)
 		adev->vm_manager.first_userq_vmid = 1;
 
-	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
 				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
-				      false);
+				      mmhub_vmid_mask);
 
 	amdgpu_vm_manager_init(adev);
 
-	if (adev->vm_manager.npa_vmid)
-		adev->vm_manager.vmid_uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
-
 	r = amdgpu_gmc_ras_sw_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 2fb3b0687ab70..0f868323029f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -827,10 +827,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
 				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
-				      true);
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1));
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 1208822b6ef8d..69acfd0408f41 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1009,10 +1009,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
 				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
-				      true);
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1));
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index b21dc8fc6a9a1..14a05f653d453 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1124,10 +1124,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->vm_manager.first_userq_vmid = 8;
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
 				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
-				      true);
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1));
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f9d2e82c34793..8723199b6e4dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2041,10 +2041,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_vmid_mgr_set_vmid_mask(adev,
 				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1),
-				      true);
+				      GENMASK(adev->vm_manager.first_userq_vmid - 1, 1));
 	amdgpu_vm_manager_init(adev);
 
 	gmc_v9_0_save_registers(adev);
-- 
2.34.1

