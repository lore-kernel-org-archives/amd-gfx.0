Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB27FCE834B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA9310E515;
	Mon, 30 Sep 2024 14:32:22 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4029110E514
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:32:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48UEWFQ92682367; Mon, 30 Sep 2024 20:02:15 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48UEWFDw2682366;
 Mon, 30 Sep 2024 20:02:15 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 10/12] drm/amdgpu: update the handle ptr in resume
Date: Mon, 30 Sep 2024 20:00:17 +0530
Message-Id: <20240930143019.2682202-11-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930143019.2682202-1-sunil.khatri@amd.com>
References: <20240930143019.2682202-1-sunil.khatri@amd.com>
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

Update the *handle to amdgpu_ip_block ptr for all
functions pointers of resume.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cik.c                  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cik_ih.c               | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c             | 6 +++---
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                | 4 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 6 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 6 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 6 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c              | 4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c              | 4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c              | 4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c          | 4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c          | 4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c          | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/nv.c                   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/si.c                   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/si_dma.c               | 4 ++--
 drivers/gpu/drm/amd/amdgpu/si_ih.c                | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c       | 4 ++--
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc21.c                | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc24.c                | 4 ++--
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             | 6 +++---
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vi.c                   | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 drivers/gpu/drm/amd/include/amd_shared.h          | 2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        | 4 ++--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         | 4 ++--
 88 files changed, 182 insertions(+), 182 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 5bcf45109cb4..c1ff24335a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -246,7 +246,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 		dev_err(adev->dev, "Failed to get BIF handle\n");
 		return -EINVAL;
 	}
-	r = cmn_block->version->funcs->resume(adev);
+	r = cmn_block->version->funcs->resume(cmn_block);
 	if (r)
 		return r;
 
@@ -282,7 +282,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 		      adev->ip_blocks[i].version->type ==
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		r = adev->ip_blocks[i].version->funcs->resume(adev);
+		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
 		if (r) {
 			dev_err(adev->dev,
 				"resume of IP block <%s> failed %d\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 1d3948e56a88..50eed2b46520 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -575,9 +575,9 @@ static int acp_suspend(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int acp_resume(void *handle)
+static int acp_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* power down again on resume */
 	if (!adev->acp.acp_cell)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 778427e74dc7..39a60db44fc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2744,7 +2744,7 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 				break;
 
 			if (amdgpu_in_reset(adev) || adev->in_suspend) {
-				r = adev->ip_blocks[i].version->funcs->resume(adev);
+				r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
 				if (r) {
 					DRM_ERROR("resume of IP block <%s> failed %d\n",
 							  adev->ip_blocks[i].version->funcs->name, r);
@@ -3666,7 +3666,7 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 				continue;
 
 			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC)
-				r = block->version->funcs->resume(adev);
+				r = block->version->funcs->resume(&adev->ip_blocks[i]);
 			else
 				r = block->version->funcs->hw_init(adev);
 
@@ -3704,7 +3704,7 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP && amdgpu_sriov_vf(adev))) {
 
-			r = adev->ip_blocks[i].version->funcs->resume(adev);
+			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
 			if (r) {
 				DRM_ERROR("resume of IP block <%s> failed %d\n",
 					  adev->ip_blocks[i].version->funcs->name, r);
@@ -3742,7 +3742,7 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
 			continue;
-		r = adev->ip_blocks[i].version->funcs->resume(adev);
+		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
 		if (r) {
 			DRM_ERROR("resume of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 46d6136b70d9..64e7fe9186ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -88,7 +88,7 @@ static int isp_suspend(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int isp_resume(void *handle)
+static int isp_resume(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c0b85965773f..d77e64735a25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3089,10 +3089,10 @@ static int psp_suspend(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int psp_resume(void *handle)
+static int psp_resume(struct amdgpu_ip_block *ip_block)
 {
 	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct psp_context *psp = &adev->psp;
 
 	dev_info(adev->dev, "PSP is resuming...\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 99cb0643fae9..0e77f14232ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -880,9 +880,9 @@ static int umsch_mm_suspend(struct amdgpu_ip_block *ip_block)
 	return umsch_mm_hw_fini(adev);
 }
 
-static int umsch_mm_resume(void *handle)
+static int umsch_mm_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return umsch_mm_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index e27c5d2b4290..d876b407249d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -616,12 +616,12 @@ static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_vkms_hw_fini(adev);
 }
 
-static int amdgpu_vkms_resume(void *handle)
+static int amdgpu_vkms_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	r = amdgpu_vkms_hw_init(handle);
+	r = amdgpu_vkms_hw_init(adev);
 	if (r)
 		return r;
 	return drm_mode_config_helper_resume(adev_to_drm(adev));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index fd784b80c574..d9ace55dd520 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -443,9 +443,9 @@ static int vpe_suspend(struct amdgpu_ip_block *ip_block)
 	return vpe_hw_fini(adev);
 }
 
-static int vpe_resume(void *handle)
+static int vpe_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return vpe_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 05a9530eb40e..afe2d4c5d22a 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2160,9 +2160,9 @@ static int cik_common_suspend(struct amdgpu_ip_block *ip_block)
 	return cik_common_hw_fini(adev);
 }
 
-static int cik_common_resume(void *handle)
+static int cik_common_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return cik_common_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 47d72f6bfffd..3507442fe4d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -344,9 +344,9 @@ static int cik_ih_suspend(struct amdgpu_ip_block *ip_block)
 	return cik_ih_hw_fini(adev);
 }
 
-static int cik_ih_resume(void *handle)
+static int cik_ih_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return cik_ih_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index d9b222be356c..a37d2d00b83b 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1018,11 +1018,11 @@ static int cik_sdma_suspend(struct amdgpu_ip_block *ip_block)
 	return cik_sdma_hw_fini(adev);
 }
 
-static int cik_sdma_resume(void *handle)
+static int cik_sdma_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
-	cik_sdma_soft_reset(handle);
+	cik_sdma_soft_reset(ip_block);
 
 	return cik_sdma_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index 198dcbcb1845..4ae8156fe691 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -340,9 +340,9 @@ static int cz_ih_suspend(struct amdgpu_ip_block *ip_block)
 	return cz_ih_hw_fini(adev);
 }
 
-static int cz_ih_resume(void *handle)
+static int cz_ih_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return cz_ih_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index cf30a14b0d14..c630c877cb9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2920,15 +2920,15 @@ static int dce_v10_0_suspend(struct amdgpu_ip_block *ip_block)
 	return dce_v10_0_hw_fini(adev);
 }
 
-static int dce_v10_0_resume(void *handle)
+static int dce_v10_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	amdgpu_atombios_encoder_set_backlight_level_to_reg(adev,
 							   adev->mode_info.bl_level);
 
-	ret = dce_v10_0_hw_init(handle);
+	ret = dce_v10_0_hw_init(adev);
 
 	/* turn on the BL */
 	if (adev->mode_info.bl_encoder) {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index fc4de8ce9489..a8867fc701b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3058,15 +3058,15 @@ static int dce_v11_0_suspend(struct amdgpu_ip_block *ip_block)
 	return dce_v11_0_hw_fini(adev);
 }
 
-static int dce_v11_0_resume(void *handle)
+static int dce_v11_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	amdgpu_atombios_encoder_set_backlight_level_to_reg(adev,
 							   adev->mode_info.bl_level);
 
-	ret = dce_v11_0_hw_init(handle);
+	ret = dce_v11_0_hw_init(adev);
 
 	/* turn on the BL */
 	if (adev->mode_info.bl_encoder) {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 767c7070cca3..9b2bb2185305 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2815,15 +2815,15 @@ static int dce_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 	return dce_v6_0_hw_fini(adev);
 }
 
-static int dce_v6_0_resume(void *handle)
+static int dce_v6_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	amdgpu_atombios_encoder_set_backlight_level_to_reg(adev,
 							   adev->mode_info.bl_level);
 
-	ret = dce_v6_0_hw_init(handle);
+	ret = dce_v6_0_hw_init(adev);
 
 	/* turn on the BL */
 	if (adev->mode_info.bl_encoder) {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 9033e27f5768..d834d7b17a0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2838,15 +2838,15 @@ static int dce_v8_0_suspend(struct amdgpu_ip_block *ip_block)
 	return dce_v8_0_hw_fini(adev);
 }
 
-static int dce_v8_0_resume(void *handle)
+static int dce_v8_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	amdgpu_atombios_encoder_set_backlight_level_to_reg(adev,
 							   adev->mode_info.bl_level);
 
-	ret = dce_v8_0_hw_init(handle);
+	ret = dce_v8_0_hw_init(adev);
 
 	/* turn on the BL */
 	if (adev->mode_info.bl_encoder) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 044d8460f725..c7a5ae5be35b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7463,9 +7463,9 @@ static int gfx_v10_0_suspend(struct amdgpu_ip_block *ip_block)
 	return gfx_v10_0_hw_fini(adev);
 }
 
-static int gfx_v10_0_resume(void *handle)
+static int gfx_v10_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	return gfx_v10_0_hw_init(handle);
+	return gfx_v10_0_hw_init(ip_block->adev);
 }
 
 static bool gfx_v10_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 9532bcd75f15..6d068154c133 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4712,9 +4712,9 @@ static int gfx_v11_0_suspend(struct amdgpu_ip_block *ip_block)
 	return gfx_v11_0_hw_fini(adev);
 }
 
-static int gfx_v11_0_resume(void *handle)
+static int gfx_v11_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	return gfx_v11_0_hw_init(handle);
+	return gfx_v11_0_hw_init(ip_block->adev);
 }
 
 static bool gfx_v11_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9f1f6f390f02..0bae09bec1bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3650,9 +3650,9 @@ static int gfx_v12_0_suspend(struct amdgpu_ip_block *ip_block)
 	return gfx_v12_0_hw_fini(adev);
 }
 
-static int gfx_v12_0_resume(void *handle)
+static int gfx_v12_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	return gfx_v12_0_hw_init(handle);
+	return gfx_v12_0_hw_init(ip_block->adev);
 }
 
 static bool gfx_v12_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 8f2e79f7016f..57ddc0051648 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3160,9 +3160,9 @@ static int gfx_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 	return gfx_v6_0_hw_fini(adev);
 }
 
-static int gfx_v6_0_resume(void *handle)
+static int gfx_v6_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return gfx_v6_0_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index f2b294b1bcbe..09a0dcd59dd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4506,9 +4506,9 @@ static int gfx_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 	return gfx_v7_0_hw_fini(adev);
 }
 
-static int gfx_v7_0_resume(void *handle)
+static int gfx_v7_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return gfx_v7_0_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fac705e50028..a7d92412585d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4918,9 +4918,9 @@ static int gfx_v8_0_suspend(struct amdgpu_ip_block *ip_block)
 	return gfx_v8_0_hw_fini(adev);
 }
 
-static int gfx_v8_0_resume(void *handle)
+static int gfx_v8_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	return gfx_v8_0_hw_init(handle);
+	return gfx_v8_0_hw_init(ip_block->adev);
 }
 
 static bool gfx_v8_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 252f459a1552..03f502931448 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4079,9 +4079,9 @@ static int gfx_v9_0_suspend(struct amdgpu_ip_block *ip_block)
 	return gfx_v9_0_hw_fini(adev);
 }
 
-static int gfx_v9_0_resume(void *handle)
+static int gfx_v9_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	return gfx_v9_0_hw_init(handle);
+	return gfx_v9_0_hw_init(ip_block->adev);
 }
 
 static bool gfx_v9_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 4b86c0a42e7f..ac53c6a1b849 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2393,9 +2393,9 @@ static int gfx_v9_4_3_suspend(struct amdgpu_ip_block *ip_block)
 	return gfx_v9_4_3_hw_fini(adev);
 }
 
-static int gfx_v9_4_3_resume(void *handle)
+static int gfx_v9_4_3_resume(struct amdgpu_ip_block *ip_block)
 {
-	return gfx_v9_4_3_hw_init(handle);
+	return gfx_v9_4_3_hw_init(ip_block->adev);
 }
 
 static bool gfx_v9_4_3_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f19b3f055a1f..c8fe545bf10e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1062,10 +1062,10 @@ static int gmc_v10_0_suspend(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v10_0_resume(void *handle)
+static int gmc_v10_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = gmc_v10_0_hw_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index dab32d161b06..68d3be40a6cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -970,10 +970,10 @@ static int gmc_v11_0_suspend(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v11_0_resume(void *handle)
+static int gmc_v11_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = gmc_v11_0_hw_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 05f6b4c7ef2c..ce56f6c35932 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -954,10 +954,10 @@ static int gmc_v12_0_suspend(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v12_0_resume(void *handle)
+static int gmc_v12_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = gmc_v12_0_hw_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index f51e3f570acf..892d2ba8769e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -933,10 +933,10 @@ static int gmc_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v6_0_resume(void *handle)
+static int gmc_v6_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = gmc_v6_0_hw_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 5f725ff8dc71..3e75804edc7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1120,10 +1120,10 @@ static int gmc_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v7_0_resume(void *handle)
+static int gmc_v7_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = gmc_v7_0_hw_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 738ce68721db..7527748d9bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1241,10 +1241,10 @@ static int gmc_v8_0_suspend(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v8_0_resume(void *handle)
+static int gmc_v8_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = gmc_v8_0_hw_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 198101ee35ca..145db9472ed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2435,10 +2435,10 @@ static int gmc_v9_0_suspend(struct amdgpu_ip_block *ip_block)
 	return gmc_v9_0_hw_fini(adev);
 }
 
-static int gmc_v9_0_resume(void *handle)
+static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = gmc_v9_0_hw_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index ed2939296311..bd6a1dc39a56 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -334,9 +334,9 @@ static int iceland_ih_suspend(struct amdgpu_ip_block *ip_block)
 	return iceland_ih_hw_fini(adev);
 }
 
-static int iceland_ih_resume(void *handle)
+static int iceland_ih_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return iceland_ih_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 41bc748f7d16..73c04e7acd30 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -651,9 +651,9 @@ static int ih_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 	return ih_v6_0_hw_fini(adev);
 }
 
-static int ih_v6_0_resume(void *handle)
+static int ih_v6_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return ih_v6_0_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index e6c69608b7b8..793885260218 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -630,9 +630,9 @@ static int ih_v6_1_suspend(struct amdgpu_ip_block *ip_block)
 	return ih_v6_1_hw_fini(adev);
 }
 
-static int ih_v6_1_resume(void *handle)
+static int ih_v6_1_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return ih_v6_1_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 73201d251c23..20944345b48f 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -620,9 +620,9 @@ static int ih_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 	return ih_v7_0_hw_fini(adev);
 }
 
-static int ih_v7_0_resume(void *handle)
+static int ih_v7_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return ih_v7_0_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index a334357b51c3..46fdde0f5c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -187,10 +187,10 @@ static int jpeg_v2_0_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init JPEG block
  */
-static int jpeg_v2_0_resume(void *handle)
+static int jpeg_v2_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_jpeg_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index b0d19a2f0f89..4ff6ee91ec5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -256,9 +256,9 @@ static int jpeg_v2_5_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init JPEG block
  */
-static int jpeg_v2_5_resume(void *handle)
+static int jpeg_v2_5_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = amdgpu_jpeg_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index f6f5924f4527..173db8d4c088 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -201,9 +201,9 @@ static int jpeg_v3_0_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init JPEG block
  */
-static int jpeg_v3_0_resume(void *handle)
+static int jpeg_v3_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = amdgpu_jpeg_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index bb6fb11383e0..02142b4576fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -235,9 +235,9 @@ static int jpeg_v4_0_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init JPEG block
  */
-static int jpeg_v4_0_resume(void *handle)
+static int jpeg_v4_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = amdgpu_jpeg_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index a219acadc1a9..637b47ae3f45 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -405,9 +405,9 @@ static int jpeg_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init JPEG block
  */
-static int jpeg_v4_0_3_resume(void *handle)
+static int jpeg_v4_0_3_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = amdgpu_jpeg_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index de3c4238f596..929fdaa72bdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -262,9 +262,9 @@ static int jpeg_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init JPEG block
  */
-static int jpeg_v4_0_5_resume(void *handle)
+static int jpeg_v4_0_5_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = amdgpu_jpeg_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 638c1ec3e1c1..6740a704b11c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -198,9 +198,9 @@ static int jpeg_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init JPEG block
  */
-static int jpeg_v5_0_0_resume(void *handle)
+static int jpeg_v5_0_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = amdgpu_jpeg_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a047b76cd5a1..fc5498b2c4fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1641,10 +1641,10 @@ static int mes_v11_0_suspend(struct amdgpu_ip_block *ip_block)
 	return mes_v11_0_hw_fini(adev);
 }
 
-static int mes_v11_0_resume(void *handle)
+static int mes_v11_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = mes_v11_0_hw_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 0902f7cce29a..5b928315dab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1605,10 +1605,10 @@ static int mes_v12_0_suspend(struct amdgpu_ip_block *ip_block)
 	return mes_v12_0_hw_fini(adev);
 }
 
-static int mes_v12_0_resume(void *handle)
+static int mes_v12_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = mes_v12_0_hw_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index fafe416d95f2..7d919e65c076 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -625,9 +625,9 @@ static int navi10_ih_suspend(struct amdgpu_ip_block *ip_block)
 	return navi10_ih_hw_fini(adev);
 }
 
-static int navi10_ih_resume(void *handle)
+static int navi10_ih_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return navi10_ih_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index b6d373b167dc..a8f5a951486d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1036,9 +1036,9 @@ static int nv_common_suspend(struct amdgpu_ip_block *ip_block)
 	return nv_common_hw_fini(adev);
 }
 
-static int nv_common_resume(void *handle)
+static int nv_common_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return nv_common_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 4d878c05775d..e3aa09ab3eac 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -908,9 +908,9 @@ static int sdma_v2_4_suspend(struct amdgpu_ip_block *ip_block)
 	return sdma_v2_4_hw_fini(adev);
 }
 
-static int sdma_v2_4_resume(void *handle)
+static int sdma_v2_4_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v2_4_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index c31334e8bac5..232fb36854e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1195,9 +1195,9 @@ static int sdma_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 	return sdma_v3_0_hw_fini(adev);
 }
 
-static int sdma_v3_0_resume(void *handle)
+static int sdma_v3_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v3_0_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 1571444a6cfa..de6ff5643665 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2001,9 +2001,9 @@ static int sdma_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 	return sdma_v4_0_hw_fini(adev);
 }
 
-static int sdma_v4_0_resume(void *handle)
+static int sdma_v4_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* SMU restores SDMA state for us */
 	if (adev->in_s0ix) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 91eed9066e39..551b4bb976b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1518,9 +1518,9 @@ static int sdma_v4_4_2_suspend(struct amdgpu_ip_block *ip_block)
 	return sdma_v4_4_2_hw_fini(adev);
 }
 
-static int sdma_v4_4_2_resume(void *handle)
+static int sdma_v4_4_2_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v4_4_2_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 65a5c2429466..b93745202c60 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1509,9 +1509,9 @@ static int sdma_v5_0_suspend(struct amdgpu_ip_block *ip_block)
 	return sdma_v5_0_hw_fini(adev);
 }
 
-static int sdma_v5_0_resume(void *handle)
+static int sdma_v5_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v5_0_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index ba2cbc520c9b..4b76247c6a23 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1404,9 +1404,9 @@ static int sdma_v5_2_suspend(struct amdgpu_ip_block *ip_block)
 	return sdma_v5_2_hw_fini(adev);
 }
 
-static int sdma_v5_2_resume(void *handle)
+static int sdma_v5_2_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v5_2_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index a378d35a11b4..9884deaadc94 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1407,9 +1407,9 @@ static int sdma_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 	return sdma_v6_0_hw_fini(adev);
 }
 
-static int sdma_v6_0_resume(void *handle)
+static int sdma_v6_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v6_0_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index d74b66a9d858..57b7b166aad6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1365,9 +1365,9 @@ static int sdma_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 	return sdma_v7_0_hw_fini(adev);
 }
 
-static int sdma_v7_0_resume(void *handle)
+static int sdma_v7_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v7_0_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index b251a93baffe..0fc303843493 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2657,9 +2657,9 @@ static int si_common_suspend(struct amdgpu_ip_block *ip_block)
 	return si_common_hw_fini(adev);
 }
 
-static int si_common_resume(void *handle)
+static int si_common_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return si_common_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 12a6c713559a..77722ea6fc21 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -540,9 +540,9 @@ static int si_dma_suspend(struct amdgpu_ip_block *ip_block)
 	return si_dma_hw_fini(adev);
 }
 
-static int si_dma_resume(void *handle)
+static int si_dma_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return si_dma_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 569e552ea4e6..7976702f500e 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -209,9 +209,9 @@ static int si_ih_suspend(struct amdgpu_ip_block *ip_block)
 	return si_ih_hw_fini(adev);
 }
 
-static int si_ih_resume(void *handle)
+static int si_ih_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return si_ih_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 37f63779174d..475b7df3a908 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -175,7 +175,7 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
-			r = adev->ip_blocks[i].version->funcs->resume(adev);
+			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
 			if (r) {
 				dev_err(adev->dev,
 					"resume of IP block <%s> failed %d\n",
@@ -193,7 +193,7 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 		      adev->ip_blocks[i].version->type ==
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		r = adev->ip_blocks[i].version->funcs->resume(adev);
+		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
 		if (r) {
 			dev_err(adev->dev,
 				"resume of IP block <%s> failed %d\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index 3008d806ad5a..5ea9090b5040 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -186,7 +186,7 @@ static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
 		      adev->ip_blocks[i].version->type ==
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		r = adev->ip_blocks[i].version->funcs->resume(adev);
+		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
 		if (r) {
 			dev_err(adev->dev,
 				"resume of IP block <%s> failed %d\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c0be766110aa..b17f70b85e77 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1325,9 +1325,9 @@ static int soc15_common_suspend(struct amdgpu_ip_block *ip_block)
 	return soc15_common_hw_fini(adev);
 }
 
-static int soc15_common_resume(void *handle)
+static int soc15_common_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (soc15_need_reset_on_resume(adev)) {
 		dev_info(adev->dev, "S3 suspend abort case, let's reset ASIC.\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d267d975df28..269857b7e7c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -917,9 +917,9 @@ static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
 	return false;
 }
 
-static int soc21_common_resume(void *handle)
+static int soc21_common_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (soc21_need_reset_on_resume(adev)) {
 		dev_info(adev->dev, "S3 suspend aborted, resetting...");
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 180cb39e5e78..82d8473a9120 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -519,9 +519,9 @@ static int soc24_common_suspend(struct amdgpu_ip_block *ip_block)
 	return soc24_common_hw_fini(adev);
 }
 
-static int soc24_common_resume(void *handle)
+static int soc24_common_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return soc24_common_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index f642cdb7fdaf..c63044187954 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -352,9 +352,9 @@ static int tonga_ih_suspend(struct amdgpu_ip_block *ip_block)
 	return tonga_ih_hw_fini(adev);
 }
 
-static int tonga_ih_resume(void *handle)
+static int tonga_ih_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return tonga_ih_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 079ce9416d01..79b2fbb0509e 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -747,10 +747,10 @@ static int uvd_v3_1_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_uvd_suspend(adev);
 }
 
-static int uvd_v3_1_resume(void *handle)
+static int uvd_v3_1_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_uvd_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 53233c48999c..b03abfc0c275 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -261,10 +261,10 @@ static int uvd_v4_2_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_uvd_suspend(adev);
 }
 
-static int uvd_v4_2_resume(void *handle)
+static int uvd_v4_2_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_uvd_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 3b678e0c11b9..9b3ea63b9276 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -259,10 +259,10 @@ static int uvd_v5_0_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_uvd_suspend(adev);
 }
 
-static int uvd_v5_0_resume(void *handle)
+static int uvd_v5_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_uvd_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 8bbb9a2e2601..a99ad9295ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -583,10 +583,10 @@ static int uvd_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_uvd_suspend(adev);
 }
 
-static int uvd_v6_0_resume(void *handle)
+static int uvd_v6_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_uvd_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 26e32a98e641..7c36d50f4d56 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -651,10 +651,10 @@ static int uvd_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_uvd_suspend(adev);
 }
 
-static int uvd_v7_0_resume(void *handle)
+static int uvd_v7_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_uvd_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 8f019a546ead..022cfb6dd6a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -520,10 +520,10 @@ static int vce_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_vce_suspend(adev);
 }
 
-static int vce_v2_0_resume(void *handle)
+static int vce_v2_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_vce_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 5d9b8d2549ec..9601d915bec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -535,10 +535,10 @@ static int vce_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_vce_suspend(adev);
 }
 
-static int vce_v3_0_resume(void *handle)
+static int vce_v3_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_vce_resume(adev);
 	if (r)
@@ -721,7 +721,7 @@ static int vce_v3_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
 
 	mdelay(5);
 
-	return vce_v3_0_resume(adev);
+	return vce_v3_0_resume(ip_block);
 }
 
 static int vce_v3_0_set_interrupt_state(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index b3e47c2cb810..4789e60555a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -601,9 +601,9 @@ static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_vce_suspend(adev);
 }
 
-static int vce_v4_0_resume(void *handle)
+static int vce_v4_0_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r, idx;
 
 	if (adev->vce.vcpu_bo == NULL)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index d5ff66c34559..40ebf9c3f574 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -322,10 +322,10 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init VCN block
  */
-static int vcn_v1_0_resume(void *handle)
+static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 0aef4afbc079..817b4dbec3d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -351,10 +351,10 @@ static int vcn_v2_0_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init VCN block
  */
-static int vcn_v2_0_resume(void *handle)
+static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 93bf87d4f611..f12011db9372 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -436,10 +436,10 @@ static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init VCN block
  */
-static int vcn_v2_5_resume(void *handle)
+static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 44c1db24c15b..c2b3ba9c6c90 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -468,10 +468,10 @@ static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init VCN block
  */
-static int vcn_v3_0_resume(void *handle)
+static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 3832f6be7492..18761ad8c25d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -397,10 +397,10 @@ static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init VCN block
  */
-static int vcn_v4_0_resume(void *handle)
+static int vcn_v4_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index e071fb63e983..c3d96bdc8356 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -352,9 +352,9 @@ static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init VCN block
  */
-static int vcn_v4_0_3_resume(void *handle)
+static int vcn_v4_0_3_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = amdgpu_vcn_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index d7460b49f170..b98e1533a830 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -345,10 +345,10 @@ static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init VCN block
  */
-static int vcn_v4_0_5_resume(void *handle)
+static int vcn_v4_0_5_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 4d4d7ca5d224..ed1c2b379460 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -309,10 +309,10 @@ static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
  *
  * Resume firmware and hw init VCN block
  */
-static int vcn_v5_0_0_resume(void *handle)
+static int vcn_v5_0_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index c024d2577571..2076c09f0488 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -557,9 +557,9 @@ static int vega10_ih_suspend(struct amdgpu_ip_block *ip_block)
 	return vega10_ih_hw_fini(adev);
 }
 
-static int vega10_ih_resume(void *handle)
+static int vega10_ih_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return vega10_ih_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index d9b56339ce30..fc02941cefd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -623,9 +623,9 @@ static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)
 	return vega20_ih_hw_fini(adev);
 }
 
-static int vega20_ih_resume(void *handle)
+static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return vega20_ih_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index c428950e5b4b..5e18ba72a03e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1738,9 +1738,9 @@ static int vi_common_suspend(struct amdgpu_ip_block *ip_block)
 	return vi_common_hw_fini(adev);
 }
 
-static int vi_common_resume(void *handle)
+static int vi_common_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return vi_common_hw_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 232702208eee..52188a07d6a4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3124,9 +3124,9 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 	kfree(bundle);
 }
 
-static int dm_resume(void *handle)
+static int dm_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct drm_device *ddev = adev_to_drm(adev);
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct amdgpu_dm_connector *aconnector;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 9110a3ad4893..000adb83941f 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -389,7 +389,7 @@ struct amd_ip_funcs {
 	void (*late_fini)(struct amdgpu_ip_block *ip_block);
 	int (*prepare_suspend)(struct amdgpu_ip_block *ip_block);
 	int (*suspend)(struct amdgpu_ip_block *ip_block);
-	int (*resume)(void *handle);
+	int (*resume)(struct amdgpu_ip_block *ip_block);
 	bool (*is_idle)(void *handle);
 	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
 	bool (*check_soft_reset)(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index c46882837423..01043e954f85 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3075,10 +3075,10 @@ static int kv_dpm_suspend(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int kv_dpm_resume(void *handle)
+static int kv_dpm_resume(struct amdgpu_ip_block *ip_block)
 {
 	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->pm.dpm_enabled) {
 		/* asic init will reset to the boot state */
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index cba82d151f07..e23bac6c0c08 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7818,10 +7818,10 @@ static int si_dpm_suspend(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int si_dpm_resume(void *handle)
+static int si_dpm_resume(struct amdgpu_ip_block *ip_block)
 {
 	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->pm.dpm_enabled) {
 		/* asic init will reset to the boot state */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index dfdc26fe2ee7..cd70941edec5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -271,9 +271,9 @@ static int pp_suspend(struct amdgpu_ip_block *ip_block)
 	return hwmgr_suspend(hwmgr);
 }
 
-static int pp_resume(void *handle)
+static int pp_resume(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 
 	return hwmgr_resume(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4be34505d4b4..7bae464f1bf8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2104,10 +2104,10 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int smu_resume(void *handle)
+static int smu_resume(struct amdgpu_ip_block *ip_block)
 {
 	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
 	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
-- 
2.34.1

