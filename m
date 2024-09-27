Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88236CEBF8A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 09:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F99D10ECAF;
	Fri, 27 Sep 2024 09:58:04 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C89610ECA8
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 09:57:55 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48R9voG42191287; Fri, 27 Sep 2024 15:27:50 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48R9vobR2191286;
 Fri, 27 Sep 2024 15:27:50 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 3/5] drm/amdgpu: update the handle ptr in sw_init
Date: Fri, 27 Sep 2024 15:27:42 +0530
Message-Id: <20240927095744.2191253-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927095744.2191253-1-sunil.khatri@amd.com>
References: <20240927095744.2191253-1-sunil.khatri@amd.com>
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

update the *handle to amdgpu_ip_block ptr for all
functions pointers of sw_init.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cik.c                  | 2 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c               | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                | 4 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 4 ++--
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h            | 2 +-
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
 drivers/gpu/drm/amd/amdgpu/si.c                   | 2 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c               | 4 ++--
 drivers/gpu/drm/amd/amdgpu/si_ih.c                | 4 ++--
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
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             | 6 +++---
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
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        | 5 ++---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         | 4 ++--
 87 files changed, 169 insertions(+), 170 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index c4ca59875679..1680453e21c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -98,9 +98,9 @@ enum {
 	ACP_TILE_DSP2,
 };
 
-static int acp_sw_init(void *handle)
+static int acp_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->acp.parent = adev->dev;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1afd67cb6db0..01954a0bc415 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2853,7 +2853,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.valid)
 			continue;
-		r = adev->ip_blocks[i].version->funcs->sw_init((void *)adev);
+		r = adev->ip_blocks[i].version->funcs->sw_init(&adev->ip_blocks[i]);
 		if (r) {
 			DRM_ERROR("sw_init of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 7c1f17dc6b4b..02675728823d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -33,7 +33,7 @@
 #include "isp_v4_1_0.h"
 #include "isp_v4_1_1.h"
 
-static int isp_sw_init(void *handle)
+static int isp_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 8f07dad9e449..b61abc4ee0af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -421,9 +421,9 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 	return ret;
 }
 
-static int psp_sw_init(void *handle)
+static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct psp_context *psp = &adev->psp;
 	int ret;
 	struct psp_runtime_boot_cfg_entry boot_cfg_entry;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 74b1ec10be2c..d53dcee94652 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -794,9 +794,9 @@ static int umsch_mm_late_init(struct amdgpu_ip_block *ip_block)
 	return umsch_mm_test(adev);
 }
 
-static int umsch_mm_sw_init(void *handle)
+static int umsch_mm_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = umsch_mm_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d4c2afafbb73..b7857bf25b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -493,10 +493,10 @@ const struct drm_mode_config_funcs amdgpu_vkms_mode_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
-static int amdgpu_vkms_sw_init(void *handle)
+static int amdgpu_vkms_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->amdgpu_vkms_output = kcalloc(adev->mode_info.num_crtc,
 		sizeof(struct amdgpu_vkms_output), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index c9c4e8c7dc9f..73f2ada42826 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -356,9 +356,9 @@ static int vpe_common_init(struct amdgpu_vpe *vpe)
 	return 0;
 }
 
-static int vpe_sw_init(void *handle)
+static int vpe_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_vpe *vpe = &adev->vpe;
 	int ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 0a0114de11b4..7753932de1a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2124,7 +2124,7 @@ static int cik_common_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cik_common_sw_init(void *handle)
+static int cik_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 5ccd7e2ebf67..e52d378489d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -297,10 +297,10 @@ static int cik_ih_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cik_ih_sw_init(void *handle)
+static int cik_ih_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 64 * 1024, false);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 3565dbcf7e38..ce5a52eb6877 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -937,10 +937,10 @@ static int cik_sdma_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cik_sdma_sw_init(void *handle)
+static int cik_sdma_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r, i;
 
 	/* SDMA trap event */
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index bbc50a8e3bc4..dd3e04e7bea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -288,10 +288,10 @@ static int cz_ih_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cz_ih_sw_init(void *handle)
+static int cz_ih_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 64 * 1024, false);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index a7a48ad98698..75d92de74d22 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2765,10 +2765,10 @@ static int dce_v10_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int dce_v10_0_sw_init(void *handle)
+static int dce_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
 		r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, i + 1, &adev->crtc_irq);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 0b8017a9b925..12b0c1499d1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2891,10 +2891,10 @@ static int dce_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int dce_v11_0_sw_init(void *handle)
+static int dce_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
 		r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, i + 1, &adev->crtc_irq);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 2c074d35bb13..8367f35279d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2664,11 +2664,11 @@ static int dce_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int dce_v6_0_sw_init(void *handle)
+static int dce_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, i;
 	bool ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
 		r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, i + 1, &adev->crtc_irq);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 71197d58c92d..aa463daf6834 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2680,10 +2680,10 @@ static int dce_v8_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int dce_v8_0_sw_init(void *handle)
+static int dce_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
 		r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, i + 1, &adev->crtc_irq);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8008dbd24967..e7a251044208 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4683,11 +4683,11 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
 	}
 }
 
-static int gfx_v10_0_sw_init(void *handle)
+static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int i, j, k, r, ring_id = 0;
 	int xcc_id = 0;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(10, 1, 10):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a1718c52ed18..c92f47704b0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1536,11 +1536,11 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 	}
 }
 
-static int gfx_v11_0_sw_init(void *handle)
+static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int i, j, k, r, ring_id = 0;
 	int xcc_id = 0;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(11, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index e3951a548726..8a1a615c7011 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1319,12 +1319,12 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
 	}
 }
 
-static int gfx_v12_0_sw_init(void *handle)
+static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int i, j, k, r, ring_id = 0;
 	unsigned num_compute_rings;
 	int xcc_id = 0;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 0, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index cc9f9b10b435..ecb53c6c488c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3039,10 +3039,10 @@ static int gfx_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gfx_v6_0_sw_init(void *handle)
+static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, r;
 
 	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 181, &adev->gfx.eop_irq);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 73404f24667f..286ee8b5a51e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4343,10 +4343,10 @@ static int gfx_v7_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	return 0;
 }
 
-static int gfx_v7_0_sw_init(void *handle)
+static int gfx_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, j, k, r, ring_id;
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 9778b89c7125..ff5124947cbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1894,12 +1894,12 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 
 static void gfx_v8_0_sq_irq_work_func(struct work_struct *work);
 
-static int gfx_v8_0_sw_init(void *handle)
+static int gfx_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int i, j, k, r, ring_id;
 	int xcc_id = 0;
 	struct amdgpu_ring *ring;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	switch (adev->asic_type) {
 	case CHIP_TONGA:
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5ae2b63c375c..d8dac3145fc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2198,12 +2198,12 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
 	}
 }
 
-static int gfx_v9_0_sw_init(void *handle)
+static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int i, j, k, r, ring_id;
 	int xcc_id = 0;
 	struct amdgpu_ring *ring;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	unsigned int hw_prio;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 511bfa7a8bab..e103d68a0c10 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1049,10 +1049,10 @@ static void gfx_v9_4_3_alloc_ip_dump(struct amdgpu_device *adev)
 	}
 }
 
-static int gfx_v9_4_3_sw_init(void *handle)
+static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int i, j, k, r, ring_id, xcc_id, num_xcc;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ceb870d2ef13..f10b9eae860e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -769,10 +769,10 @@ static int gmc_v10_0_gart_init(struct amdgpu_device *adev)
 	return amdgpu_gart_table_vram_alloc(adev);
 }
 
-static int gmc_v10_0_sw_init(void *handle)
+static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->gfxhub.funcs->init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 653b2e70b983..55eed13f717c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -729,10 +729,10 @@ static int gmc_v11_0_gart_init(struct amdgpu_device *adev)
 	return amdgpu_gart_table_vram_alloc(adev);
 }
 
-static int gmc_v11_0_sw_init(void *handle)
+static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->mmhub.funcs->init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3e126ebe7a8d..6a0bd663909d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -731,10 +731,10 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *adev)
 	return amdgpu_gart_table_vram_alloc(adev);
 }
 
-static int gmc_v12_0_sw_init(void *handle)
+static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->mmhub.funcs->init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 321d3828cb11..a3561b20c9e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -799,10 +799,10 @@ static unsigned int gmc_v6_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	return size;
 }
 
-static int gmc_v6_0_sw_init(void *handle)
+static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 993e2db4eb13..2621dc45c799 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -968,10 +968,10 @@ static unsigned int gmc_v7_0_get_vbios_fb_size(struct amdgpu_device *adev)
 	return size;
 }
 
-static int gmc_v7_0_sw_init(void *handle)
+static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 784289ca27e0..b4ab1f23e245 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1076,10 +1076,10 @@ static unsigned int gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
 
 #define mmMC_SEQ_MISC0_FIJI 0xA71
 
-static int gmc_v8_0_sw_init(void *handle)
+static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 73b6bf1b1432..e39fe297daf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1987,10 +1987,10 @@ static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
 	adev->gmc.vram_width = 128 * 64;
 }
 
-static int gmc_v9_0_sw_init(void *handle)
+static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	unsigned long inst_mask = adev->aid_mask;
 
 	adev->gfxhub.funcs->init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index 87b29600cf1f..a893b37067e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -287,10 +287,10 @@ static int iceland_ih_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int iceland_ih_sw_init(void *handle)
+static int iceland_ih_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 64 * 1024, false);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index fa6c7e5fbbe3..0422dbf8b8be 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -568,10 +568,10 @@ static int ih_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int ih_v6_0_sw_init(void *handle)
+static int ih_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool use_bus_addr;
 
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index ebe23630e8f6..6dddc8c7d623 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -547,10 +547,10 @@ static int ih_v6_1_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int ih_v6_1_sw_init(void *handle)
+static int ih_v6_1_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool use_bus_addr;
 
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 1619f0ba4d1b..727b40822226 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -537,10 +537,10 @@ static int ih_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int ih_v7_0_sw_init(void *handle)
+static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool use_bus_addr;
 
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 8effd6dc65d4..24ac589f200a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -481,9 +481,9 @@ int jpeg_v1_0_early_init(struct amdgpu_ip_block *ip_block)
  * @handle: amdgpu_device pointer
  *
  */
-int jpeg_v1_0_sw_init(void *handle)
+int jpeg_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
index 791de235cd8b..d978422ddbd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
@@ -25,7 +25,7 @@
 #define __JPEG_V1_0_H__
 
 int jpeg_v1_0_early_init(struct amdgpu_ip_block *ip_block);
-int jpeg_v1_0_sw_init(void *handle);
+int jpeg_v1_0_sw_init(struct amdgpu_ip_block *ip_block);
 void jpeg_v1_0_sw_fini(void *handle);
 void jpeg_v1_0_start(struct amdgpu_device *adev, int mode);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 341c551dad8b..9975f9332ee6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -65,9 +65,9 @@ static int jpeg_v2_0_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int jpeg_v2_0_sw_init(void *handle)
+static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index ec0fa685e127..6af7193eabad 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -85,11 +85,11 @@ static int jpeg_v2_5_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int jpeg_v2_5_sw_init(void *handle)
+static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int i, r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index dd00daa1d7ed..4d9e432e11d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -79,9 +79,9 @@ static int jpeg_v3_0_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int jpeg_v3_0_sw_init(void *handle)
+static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index b147e0eba31d..555953774ee8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -74,9 +74,9 @@ static int jpeg_v4_0_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int jpeg_v4_0_sw_init(void *handle)
+static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 903c47e9e8eb..3155b54ac84d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -92,9 +92,9 @@ static int jpeg_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int jpeg_v4_0_3_sw_init(void *handle)
+static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	int i, j, r, jpeg_inst;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 48ab3e0a62d2..59fa78136122 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -98,9 +98,9 @@ static int jpeg_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int jpeg_v4_0_5_sw_init(void *handle)
+static int jpeg_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	int r, i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 61288104060d..ce4cf8f32ea2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -66,9 +66,9 @@ static int jpeg_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int jpeg_v5_0_0_sw_init(void *handle)
+static int jpeg_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 62da96fd7e8a..81d9443b443c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1361,9 +1361,9 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int mes_v11_0_sw_init(void *handle)
+static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
 	adev->mes.funcs = &mes_v11_0_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ae6afe3cfc9f..da7cfa1c5da2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1326,9 +1326,9 @@ static int mes_v12_0_mqd_sw_init(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int mes_v12_0_sw_init(void *handle)
+static int mes_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
 	adev->mes.funcs = &mes_v12_0_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 17aab897f86b..f9452e65730e 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -551,10 +551,10 @@ static int navi10_ih_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int navi10_ih_sw_init(void *handle)
+static int navi10_ih_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool use_bus_addr;
 
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_IH, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 281da6a08ee7..cf9dc8b27dbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -973,9 +973,9 @@ static int nv_common_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int nv_common_sw_init(void *handle)
+static int nv_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		xgpu_nv_mailbox_add_irq_id(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 5b8198558869..01d8d1ec83e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -826,11 +826,11 @@ static int sdma_v2_4_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v2_4_sw_init(void *handle)
+static int sdma_v2_4_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* SDMA trap event */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, VISLANDS30_IV_SRCID_SDMA_TRAP,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 37275b38bca8..ffffe9faa5c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1106,11 +1106,11 @@ static int sdma_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v3_0_sw_init(void *handle)
+static int sdma_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* SDMA trap event */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, VISLANDS30_IV_SRCID_SDMA_TRAP,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index acf00311547d..8f0d2f1b7cc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1792,11 +1792,11 @@ static int sdma_v4_0_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v4_0_sw_init(void *handle)
+static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_4_0);
 	uint32_t *ptr;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 45a1fa0c2c94..4f2a7cdda2bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1332,11 +1332,11 @@ static int sdma_v4_4_2_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v4_4_2_sw_init(void *handle)
+static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 aid_id;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_4_4_2);
 	uint32_t *ptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 12bd42629e74..86a9b90e569a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1385,11 +1385,11 @@ static int sdma_v5_0_early_init(struct amdgpu_ip_block *ip_block)
 }
 
 
-static int sdma_v5_0_sw_init(void *handle)
+static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_5_0);
 	uint32_t *ptr;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index e3ee1e2d8d55..ca11f694dcef 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1268,11 +1268,11 @@ static unsigned sdma_v5_2_seq_to_trap_id(int seq_num)
 	return -EINVAL;
 }
 
-static int sdma_v5_2_sw_init(void *handle)
+static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_5_2);
 	uint32_t *ptr;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 5b549e00143e..ee09478e21e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1313,11 +1313,11 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v6_0_sw_init(void *handle)
+static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_6_0);
 	uint32_t *ptr;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 90baf9a20b22..13b055f6f835 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1273,11 +1273,11 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v7_0_sw_init(void *handle)
+static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t reg_count = ARRAY_SIZE(sdma_reg_list_7_0);
 	uint32_t *ptr;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 93c68abf447a..65571a8606ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2148,7 +2148,7 @@ static int si_common_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int si_common_sw_init(void *handle)
+static int si_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 791d492e991d..2ed3e3538d64 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -471,11 +471,11 @@ static int si_dma_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int si_dma_sw_init(void *handle)
+static int si_dma_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* DMA0 trap event */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 224,
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index bd2ae8255498..c9d1565e1466 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -165,10 +165,10 @@ static int si_ih_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int si_ih_sw_init(void *handle)
+static int si_ih_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 64 * 1024, false);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 1a24634a100c..57e40ab5edcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1217,9 +1217,9 @@ static int soc15_common_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int soc15_common_sw_init(void *handle)
+static int soc15_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_add_irq_id(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index bc420ff85174..600b375883af 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -832,9 +832,9 @@ static int soc21_common_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int soc21_common_sw_init(void *handle)
+static int soc21_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		xgpu_nv_mailbox_add_irq_id(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 12ed243a2df8..14370fda5a29 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -455,9 +455,9 @@ static int soc24_common_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int soc24_common_sw_init(void *handle)
+static int soc24_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		xgpu_nv_mailbox_add_irq_id(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index ae27dac94117..873a5b20ffe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -297,10 +297,10 @@ static int tonga_ih_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int tonga_ih_sw_init(void *handle)
+static int tonga_ih_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 64 * 1024, true);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index d5e2b9639238..5258a9aa96a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -542,10 +542,10 @@ static int uvd_v3_1_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int uvd_v3_1_sw_init(void *handle)
+static int uvd_v3_1_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 	void *ptr;
 	uint32_t ucode_len;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 5c46174dabbf..5fb5870efe86 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -101,10 +101,10 @@ static int uvd_v4_2_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int uvd_v4_2_sw_init(void *handle)
+static int uvd_v4_2_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	/* UVD TRAP */
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index fd4acb1300f9..c5e740afeb71 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -99,10 +99,10 @@ static int uvd_v5_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int uvd_v5_0_sw_init(void *handle)
+static int uvd_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	/* UVD TRAP */
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index e05e81d6fbd4..350853a29586 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -375,11 +375,11 @@ static int uvd_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int uvd_v6_0_sw_init(void *handle)
+static int uvd_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int i, r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* UVD TRAP */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, VISLANDS30_IV_SRCID_UVD_SYSTEM_MESSAGE, &adev->uvd.inst->irq);
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 15b8f6211bb5..842e6a77866a 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -395,12 +395,12 @@ static int uvd_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int uvd_v7_0_sw_init(void *handle)
+static int uvd_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 
 	int i, j, r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (j = 0; j < adev->uvd.num_uvd_inst; j++) {
 		if (adev->uvd.harvest_config & (1 << j))
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 97ce06228a91..50bc883a325c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -410,11 +410,11 @@ static int vce_v2_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int vce_v2_0_sw_init(void *handle)
+static int vce_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int r, i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* VCE */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 167, &adev->vce.irq);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 31ca855a950a..de3946953fda 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -415,9 +415,9 @@ static int vce_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int vce_v3_0_sw_init(void *handle)
+static int vce_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	int r, i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 14ead62ec57d..8a85cd2bab2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -422,9 +422,9 @@ static int vce_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int vce_v4_0_sw_init(void *handle)
+static int vce_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 
 	unsigned size;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 451622184838..785371d2017b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -122,13 +122,13 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int vcn_v1_0_sw_init(void *handle)
+static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	/* VCN DEC TRAP */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
@@ -197,7 +197,7 @@ static int vcn_v1_0_sw_init(void *handle)
 		amdgpu_vcn_fwlog_init(adev->vcn.inst);
 	}
 
-	r = jpeg_v1_0_sw_init(handle);
+	r = jpeg_v1_0_sw_init(ip_block);
 
 	/* Allocate memory for VCN IP Dump buffer */
 	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 18383e7a13ce..6b5a83d6a696 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -128,13 +128,13 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int vcn_v2_0_sw_init(void *handle)
+static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	volatile struct amdgpu_fw_shared *fw_shared;
 
 	/* VCN DEC TRAP */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 0ba7bc052447..cebc000e6e1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -155,13 +155,13 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int vcn_v2_5_sw_init(void *handle)
+static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int i, j, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
 		if (adev->vcn.harvest_config & (1 << j))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 7204e3630052..361acbb23556 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -157,14 +157,14 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int vcn_v3_0_sw_init(void *handle)
+static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	int i, j, r;
 	int vcn_doorbell_index = 0;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	r = amdgpu_vcn_sw_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index cfebd1255b75..41d86957ee65 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -168,10 +168,10 @@ static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
  *
  * Load firmware and sw initialization
  */
-static int vcn_v4_0_sw_init(void *handle)
+static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
 	uint32_t *ptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d64f4735ebf3..fa4eaed28a71 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -123,9 +123,9 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int vcn_v4_0_3_sw_init(void *handle)
+static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
 	int i, r, vcn_inst;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index d13f07faae8a..c7ec93e00c18 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -128,10 +128,10 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int vcn_v4_0_5_sw_init(void *handle)
+static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
 	uint32_t *ptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d9c92df3843f..3807e8ff1426 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -112,10 +112,10 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
  *
  * Load firmware and sw initialization
  */
-static int vcn_v5_0_0_sw_init(void *handle)
+static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
 	uint32_t *ptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 5b0c81d510e7..ef21a0915290 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -481,9 +481,9 @@ static int vega10_ih_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int vega10_ih_sw_init(void *handle)
+static int vega10_ih_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_IH, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index dec7279c8106..b9e97820af35 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -535,9 +535,9 @@ static int vega20_ih_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int vega20_ih_sw_init(void *handle)
+static int vega20_ih_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	bool use_bus_addr = true;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index fc729185be3b..c3072e54862c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1689,9 +1689,9 @@ static int vi_common_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int vi_common_sw_init(void *handle)
+static int vi_common_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev))
 		xgpu_vi_mailbox_add_irq_id(adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f3b11f600670..96416c15bc88 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2502,9 +2502,9 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int dm_sw_init(void *handle)
+static int dm_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
 	adev->dm.cgs_device = amdgpu_cgs_create_device(adev);
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 8d486b018441..2f956a09465d 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -381,7 +381,7 @@ struct amd_ip_funcs {
 	char *name;
 	int (*early_init)(struct amdgpu_ip_block *ip_block);
 	int (*late_init)(struct amdgpu_ip_block *ip_block);
-	int (*sw_init)(void *handle);
+	int (*sw_init)(struct amdgpu_ip_block *ip_block);
 	int (*sw_fini)(void *handle);
 	int (*early_fini)(void *handle);
 	int (*hw_init)(void *handle);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index adb44b5a9e42..6147d319b7ce 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -2979,11 +2979,10 @@ static int kv_dpm_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int kv_dpm_sw_init(void *handle)
+static int kv_dpm_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
+	struct amdgpu_device *adev = ip_block->adev;
 	ret = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 230,
 				&adev->pm.dpm.thermal.irq);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 51cdaf040020..00efed4b117d 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7718,10 +7718,10 @@ static int si_dpm_init_microcode(struct amdgpu_device *adev)
 	return err;
 }
 
-static int si_dpm_sw_init(void *handle)
+static int si_dpm_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int ret;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	ret = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 230, &adev->pm.dpm.thermal.irq);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 903c19b4af20..deec428a5d81 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -130,9 +130,9 @@ static void pp_swctf_delayed_work_handler(struct work_struct *work)
 	orderly_poweroff(true);
 }
 
-static int pp_sw_init(void *handle)
+static int pp_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a1cd8c90a1ec..def59fbcbd55 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1235,9 +1235,9 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 	}
 }
 
-static int smu_sw_init(void *handle)
+static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret;
 
-- 
2.34.1

