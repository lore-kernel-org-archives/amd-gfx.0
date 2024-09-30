Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF4DCE834E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C24B10E524;
	Mon, 30 Sep 2024 14:32:48 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D907810E51B
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:32:45 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48UEWFFs2682362; Mon, 30 Sep 2024 20:02:15 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48UEWFJZ2682361;
 Mon, 30 Sep 2024 20:02:15 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 09/12] drm/amdgpu: update the handle ptr in suspend
Date: Mon, 30 Sep 2024 20:00:16 +0530
Message-Id: <20240930143019.2682202-10-sunil.khatri@amd.com>
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
functions pointers of suspend.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cik.c                  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cik_ih.c               | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                | 4 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 6 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 6 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 6 +++---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 6 ++++--
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
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c       | 2 +-
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
 89 files changed, 190 insertions(+), 178 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 574aeca993e8..5bcf45109cb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -85,7 +85,7 @@ static int aldebaran_mode2_suspend_ip(struct amdgpu_device *adev)
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 
-		r = adev->ip_blocks[i].version->funcs->suspend(adev);
+		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
 
 		if (r) {
 			dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 7e327addd7a4..1d3948e56a88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -565,9 +565,9 @@ static int acp_hw_fini(void *handle)
 	return 0;
 }
 
-static int acp_suspend(void *handle)
+static int acp_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* power up on suspend */
 	if (!adev->acp.acp_cell)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 45b431eb6804..778427e74dc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3464,7 +3464,7 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 			continue;
 
 		/* XXX handle errors */
-		r = adev->ip_blocks[i].version->funcs->suspend(adev);
+		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
 		/* XXX handle errors */
 		if (r) {
 			DRM_ERROR("suspend of IP block <%s> failed %d\n",
@@ -3546,7 +3546,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			continue;
 
 		/* XXX handle errors */
-		r = adev->ip_blocks[i].version->funcs->suspend(adev);
+		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
 		/* XXX handle errors */
 		if (r) {
 			DRM_ERROR("suspend of IP block <%s> failed %d\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 63a16402333a..46d6136b70d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -83,7 +83,7 @@ static int isp_hw_fini(void *handle)
 	return -ENODEV;
 }
 
-static int isp_suspend(void *handle)
+static int isp_suspend(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f3f191dc8728..c0b85965773f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3026,10 +3026,10 @@ static int psp_hw_fini(void *handle)
 	return 0;
 }
 
-static int psp_suspend(void *handle)
+static int psp_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int ret = 0;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct psp_context *psp = &adev->psp;
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1 &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index f35fcb46861e..3e2724590dbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -40,7 +40,7 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 			continue;
 
 		/* XXX handle errors */
-		r = adev->ip_blocks[i].version->funcs->suspend(adev);
+		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
 		/* XXX handle errors */
 		if (r) {
 			dev_err(adev->dev, "suspend of IP block <%s> failed %d",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index c95c6eabb07b..99cb0643fae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -873,9 +873,9 @@ static int umsch_mm_hw_fini(void *handle)
 	return 0;
 }
 
-static int umsch_mm_suspend(void *handle)
+static int umsch_mm_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return umsch_mm_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 822c9e092109..e27c5d2b4290 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -605,15 +605,15 @@ static int amdgpu_vkms_hw_fini(void *handle)
 	return 0;
 }
 
-static int amdgpu_vkms_suspend(void *handle)
+static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = drm_mode_config_helper_suspend(adev_to_drm(adev));
 	if (r)
 		return r;
-	return amdgpu_vkms_hw_fini(handle);
+	return amdgpu_vkms_hw_fini(adev);
 }
 
 static int amdgpu_vkms_resume(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 1b4c60231596..fd784b80c574 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -434,9 +434,9 @@ static int vpe_hw_fini(void *handle)
 	return 0;
 }
 
-static int vpe_suspend(void *handle)
+static int vpe_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	cancel_delayed_work_sync(&adev->vpe.idle_work);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 5ff1c9161fa3..05a9530eb40e 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2153,9 +2153,9 @@ static int cik_common_hw_fini(void *handle)
 	return 0;
 }
 
-static int cik_common_suspend(void *handle)
+static int cik_common_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return cik_common_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 8aaf2c205eb1..47d72f6bfffd 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -337,9 +337,9 @@ static int cik_ih_hw_fini(void *handle)
 	return 0;
 }
 
-static int cik_ih_suspend(void *handle)
+static int cik_ih_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return cik_ih_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 844bc8ca7717..d9b222be356c 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1011,9 +1011,9 @@ static int cik_sdma_hw_fini(void *handle)
 	return 0;
 }
 
-static int cik_sdma_suspend(void *handle)
+static int cik_sdma_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return cik_sdma_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index cfae31890983..198dcbcb1845 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -333,9 +333,9 @@ static int cz_ih_hw_fini(void *handle)
 	return 0;
 }
 
-static int cz_ih_suspend(void *handle)
+static int cz_ih_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return cz_ih_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 2ae065e7051d..cf30a14b0d14 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2905,9 +2905,9 @@ static int dce_v10_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int dce_v10_0_suspend(void *handle)
+static int dce_v10_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = amdgpu_display_suspend_helper(adev);
@@ -2917,7 +2917,7 @@ static int dce_v10_0_suspend(void *handle)
 	adev->mode_info.bl_level =
 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
 
-	return dce_v10_0_hw_fini(handle);
+	return dce_v10_0_hw_fini(adev);
 }
 
 static int dce_v10_0_resume(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index cc90ee99d7ea..fc4de8ce9489 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3043,9 +3043,9 @@ static int dce_v11_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int dce_v11_0_suspend(void *handle)
+static int dce_v11_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = amdgpu_display_suspend_helper(adev);
@@ -3055,7 +3055,7 @@ static int dce_v11_0_suspend(void *handle)
 	adev->mode_info.bl_level =
 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
 
-	return dce_v11_0_hw_fini(handle);
+	return dce_v11_0_hw_fini(adev);
 }
 
 static int dce_v11_0_resume(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 52c7298a02da..767c7070cca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2801,9 +2801,9 @@ static int dce_v6_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int dce_v6_0_suspend(void *handle)
+static int dce_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = amdgpu_display_suspend_helper(adev);
@@ -2812,7 +2812,7 @@ static int dce_v6_0_suspend(void *handle)
 	adev->mode_info.bl_level =
 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
 
-	return dce_v6_0_hw_fini(handle);
+	return dce_v6_0_hw_fini(adev);
 }
 
 static int dce_v6_0_resume(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 3225c7ce9720..9033e27f5768 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2823,9 +2823,9 @@ static int dce_v8_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int dce_v8_0_suspend(void *handle)
+static int dce_v8_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = amdgpu_display_suspend_helper(adev);
@@ -2835,7 +2835,7 @@ static int dce_v8_0_suspend(void *handle)
 	adev->mode_info.bl_level =
 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
 
-	return dce_v8_0_hw_fini(handle);
+	return dce_v8_0_hw_fini(adev);
 }
 
 static int dce_v8_0_resume(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 86d9d4c53b4b..044d8460f725 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7456,9 +7456,11 @@ static int gfx_v10_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gfx_v10_0_suspend(void *handle)
+static int gfx_v10_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	return gfx_v10_0_hw_fini(handle);
+	struct amdgpu_device *adev = ip_block->adev;
+
+	return gfx_v10_0_hw_fini(adev);
 }
 
 static int gfx_v10_0_resume(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3068e275a36b..9532bcd75f15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4705,9 +4705,11 @@ static int gfx_v11_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gfx_v11_0_suspend(void *handle)
+static int gfx_v11_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	return gfx_v11_0_hw_fini(handle);
+	struct amdgpu_device *adev = ip_block->adev;
+
+	return gfx_v11_0_hw_fini(adev);
 }
 
 static int gfx_v11_0_resume(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3a87b4b57ee0..9f1f6f390f02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3643,9 +3643,11 @@ static int gfx_v12_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gfx_v12_0_suspend(void *handle)
+static int gfx_v12_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	return gfx_v12_0_hw_fini(handle);
+	struct amdgpu_device *adev = ip_block->adev;
+
+	return gfx_v12_0_hw_fini(adev);
 }
 
 static int gfx_v12_0_resume(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 8fb78d82d129..8f2e79f7016f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3153,9 +3153,9 @@ static int gfx_v6_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gfx_v6_0_suspend(void *handle)
+static int gfx_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return gfx_v6_0_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index e45ab9c80531..f2b294b1bcbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4499,9 +4499,9 @@ static int gfx_v7_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gfx_v7_0_suspend(void *handle)
+static int gfx_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return gfx_v7_0_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 162b73ecd388..fac705e50028 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4911,9 +4911,11 @@ static int gfx_v8_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gfx_v8_0_suspend(void *handle)
+static int gfx_v8_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	return gfx_v8_0_hw_fini(handle);
+	struct amdgpu_device *adev = ip_block->adev;
+
+	return gfx_v8_0_hw_fini(adev);
 }
 
 static int gfx_v8_0_resume(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b1b9e867ade5..252f459a1552 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4072,9 +4072,11 @@ static int gfx_v9_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gfx_v9_0_suspend(void *handle)
+static int gfx_v9_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	return gfx_v9_0_hw_fini(handle);
+	struct amdgpu_device *adev = ip_block->adev;
+
+	return gfx_v9_0_hw_fini(adev);
 }
 
 static int gfx_v9_0_resume(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 197840dc6c9a..4b86c0a42e7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2386,9 +2386,11 @@ static int gfx_v9_4_3_hw_fini(void *handle)
 	return 0;
 }
 
-static int gfx_v9_4_3_suspend(void *handle)
+static int gfx_v9_4_3_suspend(struct amdgpu_ip_block *ip_block)
 {
-	return gfx_v9_4_3_hw_fini(handle);
+	struct amdgpu_device *adev = ip_block->adev;
+
+	return gfx_v9_4_3_hw_fini(adev);
 }
 
 static int gfx_v9_4_3_resume(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 0096ddfd6233..f19b3f055a1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1053,9 +1053,9 @@ static int gmc_v10_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gmc_v10_0_suspend(void *handle)
+static int gmc_v10_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	gmc_v10_0_hw_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 9fd550c7510c..dab32d161b06 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -961,9 +961,9 @@ static int gmc_v11_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gmc_v11_0_suspend(void *handle)
+static int gmc_v11_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	gmc_v11_0_hw_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 9f967e0c0a7b..05f6b4c7ef2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -945,9 +945,9 @@ static int gmc_v12_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gmc_v12_0_suspend(void *handle)
+static int gmc_v12_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	gmc_v12_0_hw_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index b5e25c03be0f..f51e3f570acf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -924,9 +924,9 @@ static int gmc_v6_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gmc_v6_0_suspend(void *handle)
+static int gmc_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	gmc_v6_0_hw_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 2644e97565ef..5f725ff8dc71 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1111,9 +1111,9 @@ static int gmc_v7_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gmc_v7_0_suspend(void *handle)
+static int gmc_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	gmc_v7_0_hw_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 073cfcdb3ea9..738ce68721db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1232,9 +1232,9 @@ static int gmc_v8_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gmc_v8_0_suspend(void *handle)
+static int gmc_v8_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	gmc_v8_0_hw_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index bbc1e06376ce..198101ee35ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2428,9 +2428,9 @@ static int gmc_v9_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int gmc_v9_0_suspend(void *handle)
+static int gmc_v9_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return gmc_v9_0_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index 9e0f5f72981b..ed2939296311 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -327,9 +327,9 @@ static int iceland_ih_hw_fini(void *handle)
 	return 0;
 }
 
-static int iceland_ih_suspend(void *handle)
+static int iceland_ih_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return iceland_ih_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index a719c1c072f4..41bc748f7d16 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -644,9 +644,9 @@ static int ih_v6_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int ih_v6_0_suspend(void *handle)
+static int ih_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return ih_v6_0_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index f3b8f67d442f..e6c69608b7b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -623,9 +623,9 @@ static int ih_v6_1_hw_fini(void *handle)
 	return 0;
 }
 
-static int ih_v6_1_suspend(void *handle)
+static int ih_v6_1_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return ih_v6_1_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 3658e93ccd26..73201d251c23 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -613,9 +613,9 @@ static int ih_v7_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int ih_v7_0_suspend(void *handle)
+static int ih_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return ih_v7_0_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 65a0eed96f5d..a334357b51c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -166,9 +166,9 @@ static int jpeg_v2_0_hw_fini(void *handle)
  *
  * HW fini and suspend JPEG block
  */
-static int jpeg_v2_0_suspend(void *handle)
+static int jpeg_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = jpeg_v2_0_hw_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 363a1fdba03a..b0d19a2f0f89 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -235,9 +235,9 @@ static int jpeg_v2_5_hw_fini(void *handle)
  *
  * HW fini and suspend JPEG block
  */
-static int jpeg_v2_5_suspend(void *handle)
+static int jpeg_v2_5_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = jpeg_v2_5_hw_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 0afd3f027403..f6f5924f4527 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -180,9 +180,9 @@ static int jpeg_v3_0_hw_fini(void *handle)
  *
  * HW fini and suspend JPEG block
  */
-static int jpeg_v3_0_suspend(void *handle)
+static int jpeg_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = jpeg_v3_0_hw_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index e73fe80d579a..bb6fb11383e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -214,9 +214,9 @@ static int jpeg_v4_0_hw_fini(void *handle)
  *
  * HW fini and suspend JPEG block
  */
-static int jpeg_v4_0_suspend(void *handle)
+static int jpeg_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = jpeg_v4_0_hw_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 973baa7f5e27..a219acadc1a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -384,9 +384,9 @@ static int jpeg_v4_0_3_hw_fini(void *handle)
  *
  * HW fini and suspend JPEG block
  */
-static int jpeg_v4_0_3_suspend(void *handle)
+static int jpeg_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = jpeg_v4_0_3_hw_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 7fc36a832d07..de3c4238f596 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -241,9 +241,9 @@ static int jpeg_v4_0_5_hw_fini(void *handle)
  *
  * HW fini and suspend JPEG block
  */
-static int jpeg_v4_0_5_suspend(void *handle)
+static int jpeg_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = jpeg_v4_0_5_hw_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 8af33188bf1b..638c1ec3e1c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -177,9 +177,9 @@ static int jpeg_v5_0_0_hw_fini(void *handle)
  *
  * HW fini and suspend JPEG block
  */
-static int jpeg_v5_0_0_suspend(void *handle)
+static int jpeg_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = jpeg_v5_0_0_hw_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e62a41dffd98..a047b76cd5a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1629,10 +1629,10 @@ static int mes_v11_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int mes_v11_0_suspend(void *handle)
+static int mes_v11_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_mes_suspend(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 471adfbb9a10..0902f7cce29a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1593,10 +1593,10 @@ static int mes_v12_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int mes_v12_0_suspend(void *handle)
+static int mes_v12_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_mes_suspend(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index c249cbeea0ab..fafe416d95f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -618,9 +618,9 @@ static int navi10_ih_hw_fini(void *handle)
 	return 0;
 }
 
-static int navi10_ih_suspend(void *handle)
+static int navi10_ih_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return navi10_ih_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index f0b42271cccf..b6d373b167dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1029,9 +1029,9 @@ static int nv_common_hw_fini(void *handle)
 	return 0;
 }
 
-static int nv_common_suspend(void *handle)
+static int nv_common_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return nv_common_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 912b0bb0613c..4d878c05775d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -901,9 +901,9 @@ static int sdma_v2_4_hw_fini(void *handle)
 	return 0;
 }
 
-static int sdma_v2_4_suspend(void *handle)
+static int sdma_v2_4_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v2_4_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 145867839f14..c31334e8bac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1188,9 +1188,9 @@ static int sdma_v3_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int sdma_v3_0_suspend(void *handle)
+static int sdma_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v3_0_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 7343b86ea9df..1571444a6cfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1988,9 +1988,9 @@ static int sdma_v4_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int sdma_v4_0_suspend(void *handle)
+static int sdma_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* SMU saves SDMA state for us */
 	if (adev->in_s0ix) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index d83e247081dc..91eed9066e39 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1508,9 +1508,9 @@ static int sdma_v4_4_2_hw_fini(void *handle)
 static int sdma_v4_4_2_set_clockgating_state(void *handle,
 					     enum amd_clockgating_state state);
 
-static int sdma_v4_4_2_suspend(void *handle)
+static int sdma_v4_4_2_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_in_reset(adev))
 		sdma_v4_4_2_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 0dd152241eec..65a5c2429466 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1502,9 +1502,9 @@ static int sdma_v5_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int sdma_v5_0_suspend(void *handle)
+static int sdma_v5_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v5_0_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 40721bacae3f..ba2cbc520c9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1397,9 +1397,9 @@ static int sdma_v5_2_hw_fini(void *handle)
 	return 0;
 }
 
-static int sdma_v5_2_suspend(void *handle)
+static int sdma_v5_2_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v5_2_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index ac1491625ab6..a378d35a11b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1400,9 +1400,9 @@ static int sdma_v6_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int sdma_v6_0_suspend(void *handle)
+static int sdma_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v6_0_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 0e70169098c4..d74b66a9d858 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1358,9 +1358,9 @@ static int sdma_v7_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int sdma_v7_0_suspend(void *handle)
+static int sdma_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return sdma_v7_0_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 42588b14f7f1..b251a93baffe 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2650,9 +2650,9 @@ static int si_common_hw_fini(void *handle)
 	return 0;
 }
 
-static int si_common_suspend(void *handle)
+static int si_common_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return si_common_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index ac05b74ad162..12a6c713559a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -533,9 +533,9 @@ static int si_dma_hw_fini(void *handle)
 	return 0;
 }
 
-static int si_dma_suspend(void *handle)
+static int si_dma_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return si_dma_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index f09b1d8731fa..569e552ea4e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -202,9 +202,9 @@ static int si_ih_hw_fini(void *handle)
 	return 0;
 }
 
-static int si_ih_suspend(void *handle)
+static int si_ih_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return si_ih_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index bda786d6caca..37f63779174d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -81,7 +81,7 @@ static int sienna_cichlid_mode2_suspend_ip(struct amdgpu_device *adev)
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 
-		r = adev->ip_blocks[i].version->funcs->suspend(adev);
+		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
 
 		if (r) {
 			dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index e0c051818b5b..3008d806ad5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -80,7 +80,7 @@ static int smu_v13_0_10_mode2_suspend_ip(struct amdgpu_device *adev)
 			      AMD_IP_BLOCK_TYPE_MES))
 			continue;
 
-		r = adev->ip_blocks[i].version->funcs->suspend(adev);
+		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
 
 		if (r) {
 			dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index ca3675fa2855..c0be766110aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1318,9 +1318,9 @@ static int soc15_common_hw_fini(void *handle)
 	return 0;
 }
 
-static int soc15_common_suspend(void *handle)
+static int soc15_common_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return soc15_common_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 5454d2f12d1a..d267d975df28 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -890,9 +890,9 @@ static int soc21_common_hw_fini(void *handle)
 	return 0;
 }
 
-static int soc21_common_suspend(void *handle)
+static int soc21_common_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return soc21_common_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 4a41af80ac81..180cb39e5e78 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -512,9 +512,9 @@ static int soc24_common_hw_fini(void *handle)
 	return 0;
 }
 
-static int soc24_common_suspend(void *handle)
+static int soc24_common_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return soc24_common_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index be17007e4699..f642cdb7fdaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -345,9 +345,9 @@ static int tonga_ih_hw_fini(void *handle)
 	return 0;
 }
 
-static int tonga_ih_suspend(void *handle)
+static int tonga_ih_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return tonga_ih_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 7ba5e64de918..079ce9416d01 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -711,10 +711,10 @@ static int uvd_v3_1_prepare_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_uvd_prepare_suspend(adev);
 }
 
-static int uvd_v3_1_suspend(void *handle)
+static int uvd_v3_1_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/*
 	 * Proper cleanups before halting the HW engine:
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 5a60d7cb7e8b..53233c48999c 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -225,10 +225,10 @@ static int uvd_v4_2_prepare_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_uvd_prepare_suspend(adev);
 }
 
-static int uvd_v4_2_suspend(void *handle)
+static int uvd_v4_2_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/*
 	 * Proper cleanups before halting the HW engine:
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index e8638be8de50..3b678e0c11b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -223,10 +223,10 @@ static int uvd_v5_0_prepare_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_uvd_prepare_suspend(adev);
 }
 
-static int uvd_v5_0_suspend(void *handle)
+static int uvd_v5_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/*
 	 * Proper cleanups before halting the HW engine:
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 3b0bbbd4e222..8bbb9a2e2601 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -547,10 +547,10 @@ static int uvd_v6_0_prepare_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_uvd_prepare_suspend(adev);
 }
 
-static int uvd_v6_0_suspend(void *handle)
+static int uvd_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/*
 	 * Proper cleanups before halting the HW engine:
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 6fa2feb9e235..26e32a98e641 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -615,10 +615,10 @@ static int uvd_v7_0_prepare_suspend(struct amdgpu_ip_block *ip_block)
 	return amdgpu_uvd_prepare_suspend(adev);
 }
 
-static int uvd_v7_0_suspend(void *handle)
+static int uvd_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/*
 	 * Proper cleanups before halting the HW engine:
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 8b1cbc0a4fc2..8f019a546ead 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -484,10 +484,10 @@ static int vce_v2_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int vce_v2_0_suspend(void *handle)
+static int vce_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index be11772a5bdb..5d9b8d2549ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -500,10 +500,10 @@ static int vce_v3_0_hw_fini(void *handle)
 	return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
 }
 
-static int vce_v3_0_suspend(void *handle)
+static int vce_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/*
 	 * Proper cleanups before halting the HW engine:
@@ -708,7 +708,7 @@ static int vce_v3_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 
 	mdelay(5);
 
-	return vce_v3_0_suspend(adev);
+	return vce_v3_0_suspend(ip_block);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 17ff2357a2aa..b3e47c2cb810 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -553,9 +553,9 @@ static int vce_v4_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int vce_v4_0_suspend(void *handle)
+static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r, idx;
 
 	if (adev->vce.vcpu_bo == NULL)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 0727c418108e..d5ff66c34559 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -294,10 +294,10 @@ static int vcn_v1_0_hw_fini(void *handle)
  *
  * HW fini and suspend VCN block
  */
-static int vcn_v1_0_suspend(void *handle)
+static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool idle_work_unexecuted;
 
 	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index aef0aa935989..0aef4afbc079 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -330,10 +330,10 @@ static int vcn_v2_0_hw_fini(void *handle)
  *
  * HW fini and suspend VCN block
  */
-static int vcn_v2_0_suspend(void *handle)
+static int vcn_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = vcn_v2_0_hw_fini(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index c48312463e28..93bf87d4f611 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -415,10 +415,10 @@ static int vcn_v2_5_hw_fini(void *handle)
  *
  * HW fini and suspend VCN block
  */
-static int vcn_v2_5_suspend(void *handle)
+static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = vcn_v2_5_hw_fini(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index e5c22b18f0ad..44c1db24c15b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -447,10 +447,10 @@ static int vcn_v3_0_hw_fini(void *handle)
  *
  * HW fini and suspend VCN block
  */
-static int vcn_v3_0_suspend(void *handle)
+static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = vcn_v3_0_hw_fini(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4c9284459d3c..3832f6be7492 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -376,10 +376,10 @@ static int vcn_v4_0_hw_fini(void *handle)
  *
  * HW fini and suspend VCN block
  */
-static int vcn_v4_0_suspend(void *handle)
+static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = vcn_v4_0_hw_fini(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index b00ad0aa30ee..e071fb63e983 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -331,9 +331,9 @@ static int vcn_v4_0_3_hw_fini(void *handle)
  *
  * HW fini and suspend VCN block
  */
-static int vcn_v4_0_3_suspend(void *handle)
+static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = vcn_v4_0_3_hw_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 8989713712d4..d7460b49f170 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -324,10 +324,10 @@ static int vcn_v4_0_5_hw_fini(void *handle)
  *
  * HW fini and suspend VCN block
  */
-static int vcn_v4_0_5_suspend(void *handle)
+static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = vcn_v4_0_5_hw_fini(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index f3f6e37428d0..4d4d7ca5d224 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -288,10 +288,10 @@ static int vcn_v5_0_0_hw_fini(void *handle)
  *
  * HW fini and suspend VCN block
  */
-static int vcn_v5_0_0_suspend(void *handle)
+static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = vcn_v5_0_0_hw_fini(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 31f3ed1e71f6..c024d2577571 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -550,9 +550,9 @@ static int vega10_ih_hw_fini(void *handle)
 	return 0;
 }
 
-static int vega10_ih_suspend(void *handle)
+static int vega10_ih_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return vega10_ih_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 6a9ef3e92c3b..d9b56339ce30 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -616,9 +616,9 @@ static int vega20_ih_hw_fini(void *handle)
 	return 0;
 }
 
-static int vega20_ih_suspend(void *handle)
+static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return vega20_ih_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index b1d78ccda81c..c428950e5b4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1731,9 +1731,9 @@ static int vi_common_hw_fini(void *handle)
 	return 0;
 }
 
-static int vi_common_suspend(void *handle)
+static int vi_common_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return vi_common_hw_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ae8d626a1414..232702208eee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2936,9 +2936,9 @@ static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 	}
 }
 
-static int dm_suspend(void *handle)
+static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index d095a73e7e6d..9110a3ad4893 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -388,7 +388,7 @@ struct amd_ip_funcs {
 	int (*hw_fini)(void *handle);
 	void (*late_fini)(struct amdgpu_ip_block *ip_block);
 	int (*prepare_suspend)(struct amdgpu_ip_block *ip_block);
-	int (*suspend)(void *handle);
+	int (*suspend)(struct amdgpu_ip_block *ip_block);
 	int (*resume)(void *handle);
 	bool (*is_idle)(void *handle);
 	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 7d2ff59f76e7..c46882837423 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3062,9 +3062,9 @@ static int kv_dpm_hw_fini(void *handle)
 	return 0;
 }
 
-static int kv_dpm_suspend(void *handle)
+static int kv_dpm_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->pm.dpm_enabled) {
 		/* disable dpm */
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 3a083506dbf4..cba82d151f07 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7805,9 +7805,9 @@ static int si_dpm_hw_fini(void *handle)
 	return 0;
 }
 
-static int si_dpm_suspend(void *handle)
+static int si_dpm_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->pm.dpm_enabled) {
 		/* disable dpm */
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index d531d0848654..dfdc26fe2ee7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -261,9 +261,9 @@ static int pp_set_powergating_state(void *handle,
 	return 0;
 }
 
-static int pp_suspend(void *handle)
+static int pp_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 
 	cancel_delayed_work_sync(&hwmgr->swctf_delayed_work);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2f15a17a7500..4be34505d4b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2070,9 +2070,9 @@ static int smu_reset(struct smu_context *smu)
 	return 0;
 }
 
-static int smu_suspend(void *handle)
+static int smu_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret;
 	uint64_t count;
-- 
2.34.1

