Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9559CCE834E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E451810E516;
	Mon, 30 Sep 2024 14:32:22 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4096E10E515
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:32:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48UEWFro2682357; Mon, 30 Sep 2024 20:02:15 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48UEWFeb2682356;
 Mon, 30 Sep 2024 20:02:15 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 08/12] drm/amdgpu: update the handle ptr in wait_for_idle
Date: Mon, 30 Sep 2024 20:00:15 +0530
Message-Id: <20240930143019.2682202-9-sunil.khatri@amd.com>
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
functions pointers of wait_for_idle.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/cz_ih.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c           |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c           |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c         |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c           | 17 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c           |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c           | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c         |  4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                 |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c          |  4 ++--
 drivers/gpu/drm/amd/amdgpu/si.c                 |  2 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c             |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/si_ih.c              |  6 +++---
 drivers/gpu/drm/amd/amdgpu/soc15.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c           |  6 +++---
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c           |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c           |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c         |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c         |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c         |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                 |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h        |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c      |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c      |  2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c    |  2 +-
 79 files changed, 154 insertions(+), 152 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 436f24d6bd83..7e327addd7a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -590,7 +590,7 @@ static bool acp_is_idle(void *handle)
 	return true;
 }
 
-static int acp_wait_for_idle(void *handle)
+static int acp_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e47655e02c6..45b431eb6804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2204,7 +2204,7 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 		if (!adev->ip_blocks[i].status.valid)
 			continue;
 		if (adev->ip_blocks[i].version->type == block_type) {
-			r = adev->ip_blocks[i].version->funcs->wait_for_idle((void *)adev);
+			r = adev->ip_blocks[i].version->funcs->wait_for_idle(&adev->ip_blocks[i]);
 			if (r)
 				return r;
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index e90b5f807440..63a16402333a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -155,7 +155,7 @@ static bool isp_is_idle(void *handle)
 	return true;
 }
 
-static int isp_wait_for_idle(void *handle)
+static int isp_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index af274e6b8422..822c9e092109 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -632,7 +632,7 @@ static bool amdgpu_vkms_is_idle(void *handle)
 	return true;
 }
 
-static int amdgpu_vkms_wait_for_idle(void *handle)
+static int amdgpu_vkms_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index b39944e3ac68..5ff1c9161fa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2172,7 +2172,7 @@ static bool cik_common_is_idle(void *handle)
 	return true;
 }
 
-static int cik_common_wait_for_idle(void *handle)
+static int cik_common_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 612330f40447..8aaf2c205eb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -362,11 +362,11 @@ static bool cik_ih_is_idle(void *handle)
 	return true;
 }
 
-static int cik_ih_wait_for_idle(void *handle)
+static int cik_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		/* read MC_STATUS */
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 8706855d681b..844bc8ca7717 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1039,11 +1039,11 @@ static bool cik_sdma_is_idle(void *handle)
 	return true;
 }
 
-static int cik_sdma_wait_for_idle(void *handle)
+static int cik_sdma_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		tmp = RREG32(mmSRBM_STATUS2) & (SRBM_STATUS2__SDMA_BUSY_MASK |
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index 12a55f1e0e1f..cfae31890983 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -358,11 +358,11 @@ static bool cz_ih_is_idle(void *handle)
 	return true;
 }
 
-static int cz_ih_wait_for_idle(void *handle)
+static int cz_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		/* read MC_STATUS */
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 6f81621649d6..2ae065e7051d 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2948,7 +2948,7 @@ static bool dce_v10_0_is_idle(void *handle)
 	return true;
 }
 
-static int dce_v10_0_wait_for_idle(void *handle)
+static int dce_v10_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index b1afe4b837a7..cc90ee99d7ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3086,7 +3086,7 @@ static bool dce_v11_0_is_idle(void *handle)
 	return true;
 }
 
-static int dce_v11_0_wait_for_idle(void *handle)
+static int dce_v11_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index a6bbeb3bde3b..52c7298a02da 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2843,7 +2843,7 @@ static bool dce_v6_0_is_idle(void *handle)
 	return true;
 }
 
-static int dce_v6_0_wait_for_idle(void *handle)
+static int dce_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 0b57e22a7c95..3225c7ce9720 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2866,7 +2866,7 @@ static bool dce_v8_0_is_idle(void *handle)
 	return true;
 }
 
-static int dce_v8_0_wait_for_idle(void *handle)
+static int dce_v8_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c544ea2aea6e..86d9d4c53b4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7477,11 +7477,11 @@ static bool gfx_v10_0_is_idle(void *handle)
 		return true;
 }
 
-static int gfx_v10_0_wait_for_idle(void *handle)
+static int gfx_v10_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned int i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		/* read MC_STATUS */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a0f80cc993cf..3068e275a36b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4726,11 +4726,11 @@ static bool gfx_v11_0_is_idle(void *handle)
 		return true;
 }
 
-static int gfx_v11_0_wait_for_idle(void *handle)
+static int gfx_v11_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		/* read MC_STATUS */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 63e1a2803503..3a87b4b57ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3664,11 +3664,11 @@ static bool gfx_v12_0_is_idle(void *handle)
 		return true;
 }
 
-static int gfx_v12_0_wait_for_idle(void *handle)
+static int gfx_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		/* read MC_STATUS */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 60579b3029b4..8fb78d82d129 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3177,13 +3177,13 @@ static bool gfx_v6_0_is_idle(void *handle)
 		return true;
 }
 
-static int gfx_v6_0_wait_for_idle(void *handle)
+static int gfx_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (gfx_v6_0_is_idle(handle))
+		if (gfx_v6_0_is_idle(adev))
 			return 0;
 		udelay(1);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 990e7de8da25..e45ab9c80531 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4523,11 +4523,11 @@ static bool gfx_v7_0_is_idle(void *handle)
 		return true;
 }
 
-static int gfx_v7_0_wait_for_idle(void *handle)
+static int gfx_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		/* read MC_STATUS */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 6864219987e9..162b73ecd388 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4865,13 +4865,13 @@ static int gfx_v8_0_wait_for_rlc_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int gfx_v8_0_wait_for_idle(void *handle)
+static int gfx_v8_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned int i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (gfx_v8_0_is_idle(handle))
+		if (gfx_v8_0_is_idle(adev))
 			return 0;
 
 		udelay(1);
@@ -4898,7 +4898,7 @@ static int gfx_v8_0_hw_fini(void *handle)
 		return 0;
 	}
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	if (!gfx_v8_0_wait_for_idle(adev))
+	if (!gfx_v8_0_wait_for_idle(&adev->ip_blocks[AMD_IP_BLOCK_TYPE_GFX]))
 		gfx_v8_0_cp_enable(adev, false);
 	else
 		pr_err("cp is busy, skip halt cp\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3e07976d371b..b1b9e867ade5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4093,13 +4093,13 @@ static bool gfx_v9_0_is_idle(void *handle)
 		return true;
 }
 
-static int gfx_v9_0_wait_for_idle(void *handle)
+static int gfx_v9_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (gfx_v9_0_is_idle(handle))
+		if (gfx_v9_0_is_idle(adev))
 			return 0;
 		udelay(1);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 81bd4ca4fba5..197840dc6c9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2410,13 +2410,13 @@ static bool gfx_v9_4_3_is_idle(void *handle)
 	return true;
 }
 
-static int gfx_v9_4_3_wait_for_idle(void *handle)
+static int gfx_v9_4_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (gfx_v9_4_3_is_idle(handle))
+		if (gfx_v9_4_3_is_idle(adev))
 			return 0;
 		udelay(1);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 8e51c7e4e8c8..0096ddfd6233 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1082,7 +1082,7 @@ static bool gmc_v10_0_is_idle(void *handle)
 	return true;
 }
 
-static int gmc_v10_0_wait_for_idle(void *handle)
+static int gmc_v10_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* There is no need to wait for MC idle in GMC v10.*/
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 2fc69cdf8843..9fd550c7510c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -990,7 +990,7 @@ static bool gmc_v11_0_is_idle(void *handle)
 	return true;
 }
 
-static int gmc_v11_0_wait_for_idle(void *handle)
+static int gmc_v11_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* There is no need to wait for MC idle in GMC v11.*/
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3cbb5824a378..9f967e0c0a7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -974,7 +974,7 @@ static bool gmc_v12_0_is_idle(void *handle)
 	return true;
 }
 
-static int gmc_v12_0_wait_for_idle(void *handle)
+static int gmc_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* There is no need to wait for MC idle in GMC v11.*/
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 82a097d32f28..b5e25c03be0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -43,7 +43,7 @@
 
 static void gmc_v6_0_set_gmc_funcs(struct amdgpu_device *adev);
 static void gmc_v6_0_set_irq_funcs(struct amdgpu_device *adev);
-static int gmc_v6_0_wait_for_idle(void *handle);
+static int gmc_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block);
 
 MODULE_FIRMWARE("amdgpu/tahiti_mc.bin");
 MODULE_FIRMWARE("amdgpu/pitcairn_mc.bin");
@@ -65,7 +65,7 @@ static void gmc_v6_0_mc_stop(struct amdgpu_device *adev)
 {
 	u32 blackout;
 
-	gmc_v6_0_wait_for_idle((void *)adev);
+	gmc_v6_0_wait_for_idle(&adev->ip_blocks[AMD_IP_BLOCK_TYPE_GMC]);
 
 	blackout = RREG32(mmMC_SHARED_BLACKOUT_CNTL);
 	if (REG_GET_FIELD(blackout, MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE) != 1) {
@@ -224,7 +224,7 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 	}
 	WREG32(mmHDP_REG_COHERENCY_FLUSH_CNTL, 0);
 
-	if (gmc_v6_0_wait_for_idle((void *)adev))
+	if (gmc_v6_0_wait_for_idle(&adev->ip_blocks[AMD_IP_BLOCK_TYPE_GMC]))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
 
 	if (adev->mode_info.num_crtc) {
@@ -251,7 +251,7 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
 	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 
-	if (gmc_v6_0_wait_for_idle((void *)adev))
+	if (gmc_v6_0_wait_for_idle(&adev->ip_blocks[AMD_IP_BLOCK_TYPE_GMC]))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
 }
 
@@ -950,6 +950,7 @@ static int gmc_v6_0_resume(void *handle)
 static bool gmc_v6_0_is_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
 	u32 tmp = RREG32(mmSRBM_STATUS);
 
 	if (tmp & (SRBM_STATUS__MCB_BUSY_MASK | SRBM_STATUS__MCB_NON_DISPLAY_BUSY_MASK |
@@ -959,13 +960,13 @@ static bool gmc_v6_0_is_idle(void *handle)
 	return true;
 }
 
-static int gmc_v6_0_wait_for_idle(void *handle)
+static int gmc_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned int i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (gmc_v6_0_is_idle(handle))
+		if (gmc_v6_0_is_idle(adev))
 			return 0;
 		udelay(1);
 	}
@@ -992,7 +993,7 @@ static int gmc_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 
 	if (srbm_soft_reset) {
 		gmc_v6_0_mc_stop(adev);
-		if (gmc_v6_0_wait_for_idle(adev))
+		if (gmc_v6_0_wait_for_idle(&adev->ip_blocks[AMD_IP_BLOCK_TYPE_GMC]))
 			dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
 
 		tmp = RREG32(mmSRBM_SOFT_RESET);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index ad9bad951cc6..2644e97565ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -52,7 +52,7 @@
 
 static void gmc_v7_0_set_gmc_funcs(struct amdgpu_device *adev);
 static void gmc_v7_0_set_irq_funcs(struct amdgpu_device *adev);
-static int gmc_v7_0_wait_for_idle(void *handle);
+static int gmc_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block);
 
 MODULE_FIRMWARE("amdgpu/bonaire_mc.bin");
 MODULE_FIRMWARE("amdgpu/hawaii_mc.bin");
@@ -1146,11 +1146,11 @@ static bool gmc_v7_0_is_idle(void *handle)
 	return true;
 }
 
-static int gmc_v7_0_wait_for_idle(void *handle)
+static int gmc_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned int i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		/* read MC_STATUS */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 47ba4480b757..073cfcdb3ea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -53,7 +53,7 @@
 
 static void gmc_v8_0_set_gmc_funcs(struct amdgpu_device *adev);
 static void gmc_v8_0_set_irq_funcs(struct amdgpu_device *adev);
-static int gmc_v8_0_wait_for_idle(void *handle);
+static int gmc_v8_0_wait_for_idle(struct amdgpu_ip_block *ip_block);
 
 MODULE_FIRMWARE("amdgpu/tonga_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris11_mc.bin");
@@ -171,7 +171,7 @@ static void gmc_v8_0_mc_stop(struct amdgpu_device *adev)
 {
 	u32 blackout;
 
-	gmc_v8_0_wait_for_idle(adev);
+	gmc_v8_0_wait_for_idle(&adev->ip_blocks[AMD_IP_BLOCK_TYPE_GMC]);
 
 	blackout = RREG32(mmMC_SHARED_BLACKOUT_CNTL);
 	if (REG_GET_FIELD(blackout, MC_SHARED_BLACKOUT_CNTL, BLACKOUT_MODE) != 1) {
@@ -439,7 +439,7 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 	}
 	WREG32(mmHDP_REG_COHERENCY_FLUSH_CNTL, 0);
 
-	if (gmc_v8_0_wait_for_idle((void *)adev))
+	if (gmc_v8_0_wait_for_idle(&adev->ip_blocks[AMD_IP_BLOCK_TYPE_GMC]))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
 
 	if (adev->mode_info.num_crtc) {
@@ -474,7 +474,7 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_AGP_BASE, 0);
 	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
 	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
-	if (gmc_v8_0_wait_for_idle((void *)adev))
+	if (gmc_v8_0_wait_for_idle(&adev->ip_blocks[AMD_IP_BLOCK_TYPE_GMC]))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
 
 	WREG32(mmBIF_FB_EN, BIF_FB_EN__FB_READ_EN_MASK | BIF_FB_EN__FB_WRITE_EN_MASK);
@@ -1267,11 +1267,11 @@ static bool gmc_v8_0_is_idle(void *handle)
 	return true;
 }
 
-static int gmc_v8_0_wait_for_idle(void *handle)
+static int gmc_v8_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned int i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		/* read MC_STATUS */
@@ -1324,7 +1324,7 @@ static int gmc_v8_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 		return 0;
 
 	gmc_v8_0_mc_stop(adev);
-	if (gmc_v8_0_wait_for_idle(adev))
+	if (gmc_v8_0_wait_for_idle(ip_block))
 		dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1d0eb31d7b72..bbc1e06376ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2455,7 +2455,7 @@ static bool gmc_v9_0_is_idle(void *handle)
 	return true;
 }
 
-static int gmc_v9_0_wait_for_idle(void *handle)
+static int gmc_v9_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* There is no need to wait for MC idle in GMC v9.*/
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index 6210fa17eeca..9e0f5f72981b 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -352,11 +352,11 @@ static bool iceland_ih_is_idle(void *handle)
 	return true;
 }
 
-static int iceland_ih_wait_for_idle(void *handle)
+static int iceland_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		/* read MC_STATUS */
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 80c021598b78..a719c1c072f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -664,7 +664,7 @@ static bool ih_v6_0_is_idle(void *handle)
 	return true;
 }
 
-static int ih_v6_0_wait_for_idle(void *handle)
+static int ih_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 	return -ETIMEDOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index be700137d5a7..f3b8f67d442f 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -643,7 +643,7 @@ static bool ih_v6_1_is_idle(void *handle)
 	return true;
 }
 
-static int ih_v6_1_wait_for_idle(void *handle)
+static int ih_v6_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 	return -ETIMEDOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index a86d12e3ab24..3658e93ccd26 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -633,7 +633,7 @@ static bool ih_v7_0_is_idle(void *handle)
 	return true;
 }
 
-static int ih_v7_0_wait_for_idle(void *handle)
+static int ih_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 	return -ETIMEDOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index b7aa37b3a717..65a0eed96f5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -666,9 +666,9 @@ static bool jpeg_v2_0_is_idle(void *handle)
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 }
 
-static int jpeg_v2_0_wait_for_idle(void *handle)
+static int jpeg_v2_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	ret = SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS, UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index a0cddb37a541..363a1fdba03a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -501,9 +501,9 @@ static bool jpeg_v2_5_is_idle(void *handle)
 	return ret;
 }
 
-static int jpeg_v2_5_wait_for_idle(void *handle)
+static int jpeg_v2_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, ret;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 45ffea1c759b..0afd3f027403 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -459,9 +459,9 @@ static bool jpeg_v3_0_is_idle(void *handle)
 	return ret;
 }
 
-static int jpeg_v3_0_wait_for_idle(void *handle)
+static int jpeg_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS,
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 3f91d79c07f8..e73fe80d579a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -621,9 +621,9 @@ static bool jpeg_v4_0_is_idle(void *handle)
 	return ret;
 }
 
-static int jpeg_v4_0_wait_for_idle(void *handle)
+static int jpeg_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_JRBC_STATUS,
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 74b3700052ad..973baa7f5e27 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -923,9 +923,9 @@ static bool jpeg_v4_0_3_is_idle(void *handle)
 	return ret;
 }
 
-static int jpeg_v4_0_3_wait_for_idle(void *handle)
+static int jpeg_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 	int i, j;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index ad4030ccd917..7fc36a832d07 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -637,9 +637,9 @@ static bool jpeg_v4_0_5_is_idle(void *handle)
 	return ret;
 }
 
-static int jpeg_v4_0_5_wait_for_idle(void *handle)
+static int jpeg_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 85fb1a5265a8..8af33188bf1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -546,9 +546,9 @@ static bool jpeg_v5_0_0_is_idle(void *handle)
 	return ret;
 }
 
-static int jpeg_v5_0_0_wait_for_idle(void *handle)
+static int jpeg_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_JRBC_STATUS,
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 85361dcb4b4c..c249cbeea0ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -638,7 +638,7 @@ static bool navi10_ih_is_idle(void *handle)
 	return true;
 }
 
-static int navi10_ih_wait_for_idle(void *handle)
+static int navi10_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 	return -ETIMEDOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7fdd5739b608..f0b42271cccf 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1048,7 +1048,7 @@ static bool nv_common_is_idle(void *handle)
 	return true;
 }
 
-static int nv_common_wait_for_idle(void *handle)
+static int nv_common_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index a77977478ebe..912b0bb0613c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -927,11 +927,11 @@ static bool sdma_v2_4_is_idle(void *handle)
 	return true;
 }
 
-static int sdma_v2_4_wait_for_idle(void *handle)
+static int sdma_v2_4_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		tmp = RREG32(mmSRBM_STATUS2) & (SRBM_STATUS2__SDMA_BUSY_MASK |
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 18bc1463238f..145867839f14 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1214,11 +1214,11 @@ static bool sdma_v3_0_is_idle(void *handle)
 	return true;
 }
 
-static int sdma_v3_0_wait_for_idle(void *handle)
+static int sdma_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		tmp = RREG32(mmSRBM_STATUS2) & (SRBM_STATUS2__SDMA_BUSY_MASK |
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 10887eeb50af..7343b86ea9df 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2030,11 +2030,11 @@ static bool sdma_v4_0_is_idle(void *handle)
 	return true;
 }
 
-static int sdma_v4_0_wait_for_idle(void *handle)
+static int sdma_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i, j;
 	u32 sdma[AMDGPU_MAX_SDMA_INSTANCES];
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		for (j = 0; j < adev->sdma.num_instances; j++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index a8c5e30c83c8..d83e247081dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1540,11 +1540,11 @@ static bool sdma_v4_4_2_is_idle(void *handle)
 	return true;
 }
 
-static int sdma_v4_4_2_wait_for_idle(void *handle)
+static int sdma_v4_4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i, j;
 	u32 sdma[AMDGPU_MAX_SDMA_INSTANCES];
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		for (j = 0; j < adev->sdma.num_instances; j++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index c67ccb541127..0dd152241eec 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1531,11 +1531,11 @@ static bool sdma_v5_0_is_idle(void *handle)
 	return true;
 }
 
-static int sdma_v5_0_wait_for_idle(void *handle)
+static int sdma_v5_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 sdma0, sdma1;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		sdma0 = RREG32(sdma_v5_0_get_reg_offset(adev, 0, mmSDMA0_STATUS_REG));
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 2b310576e59c..40721bacae3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1426,11 +1426,11 @@ static bool sdma_v5_2_is_idle(void *handle)
 	return true;
 }
 
-static int sdma_v5_2_wait_for_idle(void *handle)
+static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 sdma0, sdma1, sdma2, sdma3;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		sdma0 = RREG32(sdma_v5_2_get_reg_offset(adev, 0, mmSDMA0_STATUS_REG));
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index f18e3a40ceeb..ac1491625ab6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1429,11 +1429,11 @@ static bool sdma_v6_0_is_idle(void *handle)
 	return true;
 }
 
-static int sdma_v6_0_wait_for_idle(void *handle)
+static int sdma_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 sdma0, sdma1;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		sdma0 = RREG32(sdma_v6_0_get_reg_offset(adev, 0, regSDMA0_STATUS_REG));
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 670529e16289..0e70169098c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1387,11 +1387,11 @@ static bool sdma_v7_0_is_idle(void *handle)
 	return true;
 }
 
-static int sdma_v7_0_wait_for_idle(void *handle)
+static int sdma_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 sdma0, sdma1;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		sdma0 = RREG32(sdma_v7_0_get_reg_offset(adev, 0, regSDMA0_STATUS_REG));
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 096cf2deeb40..42588b14f7f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2669,7 +2669,7 @@ static bool si_common_is_idle(void *handle)
 	return true;
 }
 
-static int si_common_wait_for_idle(void *handle)
+static int si_common_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 93f80ab50626..ac05b74ad162 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -550,6 +550,7 @@ static int si_dma_resume(void *handle)
 static bool si_dma_is_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
 	u32 tmp = RREG32(SRBM_STATUS2);
 
 	if (tmp & (DMA_BUSY_MASK | DMA1_BUSY_MASK))
@@ -558,13 +559,13 @@ static bool si_dma_is_idle(void *handle)
 	return true;
 }
 
-static int si_dma_wait_for_idle(void *handle)
+static int si_dma_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (si_dma_is_idle(handle))
+		if (si_dma_is_idle(adev))
 			return 0;
 		udelay(1);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 089921417ec5..f09b1d8731fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -227,13 +227,13 @@ static bool si_ih_is_idle(void *handle)
 	return true;
 }
 
-static int si_ih_wait_for_idle(void *handle)
+static int si_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (si_ih_is_idle(handle))
+		if (si_ih_is_idle(adev))
 			return 0;
 		udelay(1);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 2f9f7e3fa833..ca3675fa2855 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1341,7 +1341,7 @@ static bool soc15_common_is_idle(void *handle)
 	return true;
 }
 
-static int soc15_common_wait_for_idle(void *handle)
+static int soc15_common_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 5946911a4191..5454d2f12d1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -934,7 +934,7 @@ static bool soc21_common_is_idle(void *handle)
 	return true;
 }
 
-static int soc21_common_wait_for_idle(void *handle)
+static int soc21_common_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 64d2f8ce548d..4a41af80ac81 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -531,7 +531,7 @@ static bool soc24_common_is_idle(void *handle)
 	return true;
 }
 
-static int soc24_common_wait_for_idle(void *handle)
+static int soc24_common_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index d76c528d08f1..be17007e4699 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -370,11 +370,11 @@ static bool tonga_ih_is_idle(void *handle)
 	return true;
 }
 
-static int tonga_ih_wait_for_idle(void *handle)
+static int tonga_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
 	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		/* read MC_STATUS */
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 0fd864247a48..7ba5e64de918 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -766,10 +766,10 @@ static bool uvd_v3_1_is_idle(void *handle)
 	return !(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK);
 }
 
-static int uvd_v3_1_wait_for_idle(void *handle)
+static int uvd_v3_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (!(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK))
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 853af18fcc43..5a60d7cb7e8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -666,10 +666,10 @@ static bool uvd_v4_2_is_idle(void *handle)
 	return !(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK);
 }
 
-static int uvd_v4_2_wait_for_idle(void *handle)
+static int uvd_v4_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (!(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK))
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 7b6128660294..e8638be8de50 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -588,10 +588,10 @@ static bool uvd_v5_0_is_idle(void *handle)
 	return !(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK);
 }
 
-static int uvd_v5_0_wait_for_idle(void *handle)
+static int uvd_v5_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (!(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK))
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 0c334d90e4f3..3b0bbbd4e222 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1151,13 +1151,13 @@ static bool uvd_v6_0_is_idle(void *handle)
 	return !(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK);
 }
 
-static int uvd_v6_0_wait_for_idle(void *handle)
+static int uvd_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (uvd_v6_0_is_idle(handle))
+		if (uvd_v6_0_is_idle(adev))
 			return 0;
 	}
 	return -ETIMEDOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 6c2acde977b8..6fa2feb9e235 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1471,10 +1471,10 @@ static bool uvd_v7_0_is_idle(void *handle)
 	return !(RREG32(mmSRBM_STATUS) & SRBM_STATUS__UVD_BUSY_MASK);
 }
 
-static int uvd_v7_0_wait_for_idle(void *handle)
+static int uvd_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (uvd_v7_0_is_idle(handle))
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 71ca9966711e..8b1cbc0a4fc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -208,13 +208,13 @@ static bool vce_v2_0_is_idle(void *handle)
 	return !(RREG32(mmSRBM_STATUS2) & SRBM_STATUS2__VCE_BUSY_MASK);
 }
 
-static int vce_v2_0_wait_for_idle(void *handle)
+static int vce_v2_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	unsigned i;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (vce_v2_0_is_idle(handle))
+		if (vce_v2_0_is_idle(adev))
 			return 0;
 	}
 	return -ETIMEDOUT;
@@ -282,7 +282,7 @@ static int vce_v2_0_stop(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (vce_v2_0_wait_for_idle(adev)) {
+	if (vce_v2_0_wait_for_idle(&adev->ip_blocks[AMD_IP_BLOCK_TYPE_VCN])) {
 		DRM_INFO("VCE is busy, Can't set clock gating");
 		return 0;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 92ffd3fa5b00..be11772a5bdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -64,7 +64,7 @@
 static void vce_v3_0_mc_resume(struct amdgpu_device *adev, int idx);
 static void vce_v3_0_set_ring_funcs(struct amdgpu_device *adev);
 static void vce_v3_0_set_irq_funcs(struct amdgpu_device *adev);
-static int vce_v3_0_wait_for_idle(void *handle);
+static int vce_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block);
 static int vce_v3_0_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state);
 /**
@@ -609,13 +609,13 @@ static bool vce_v3_0_is_idle(void *handle)
 	return !(RREG32(mmSRBM_STATUS2) & mask);
 }
 
-static int vce_v3_0_wait_for_idle(void *handle)
+static int vce_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++)
-		if (vce_v3_0_is_idle(handle))
+		if (vce_v3_0_is_idle(adev))
 			return 0;
 
 	return -ETIMEDOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index b17aabaf220a..17ff2357a2aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -703,10 +703,10 @@ static bool vce_v4_0_is_idle(void *handle)
 	return !(RREG32(mmSRBM_STATUS2) & mask);
 }
 
-static int vce_v4_0_wait_for_idle(void *handle)
+static int vce_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++)
 		if (vce_v4_0_is_idle(handle))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 6717ff692d8d..0727c418108e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1384,9 +1384,9 @@ static bool vcn_v1_0_is_idle(void *handle)
 	return (RREG32_SOC15(VCN, 0, mmUVD_STATUS) == UVD_STATUS__IDLE);
 }
 
-static int vcn_v1_0_wait_for_idle(void *handle)
+static int vcn_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	ret = SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index be6998ed56bc..aef0aa935989 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1326,9 +1326,9 @@ static bool vcn_v2_0_is_idle(void *handle)
 	return (RREG32_SOC15(VCN, 0, mmUVD_STATUS) == UVD_STATUS__IDLE);
 }
 
-static int vcn_v2_0_wait_for_idle(void *handle)
+static int vcn_v2_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int ret;
 
 	ret = SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 7ab0314b27ec..c48312463e28 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1786,9 +1786,9 @@ static bool vcn_v2_5_is_idle(void *handle)
 	return ret;
 }
 
-static int vcn_v2_5_wait_for_idle(void *handle)
+static int vcn_v2_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, ret = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 38452446fcb0..e5c22b18f0ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2116,9 +2116,9 @@ static bool vcn_v3_0_is_idle(void *handle)
 	return ret;
 }
 
-static int vcn_v3_0_wait_for_idle(void *handle)
+static int vcn_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, ret = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 078bb30497e0..4c9284459d3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1979,9 +1979,9 @@ static bool vcn_v4_0_is_idle(void *handle)
  *
  * Wait for VCN block idle
  */
-static int vcn_v4_0_wait_for_idle(void *handle)
+static int vcn_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, ret = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index be7b0bfba27a..b00ad0aa30ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1571,9 +1571,9 @@ static bool vcn_v4_0_3_is_idle(void *handle)
  *
  * Wait for VCN block idle
  */
-static int vcn_v4_0_3_wait_for_idle(void *handle)
+static int vcn_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, ret = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 0e70df04ceb9..8989713712d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1473,9 +1473,9 @@ static bool vcn_v4_0_5_is_idle(void *handle)
  *
  * Wait for VCN block idle
  */
-static int vcn_v4_0_5_wait_for_idle(void *handle)
+static int vcn_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, ret = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 6b38927024d1..f3f6e37428d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1200,9 +1200,9 @@ static bool vcn_v5_0_0_is_idle(void *handle)
  *
  * Wait for VCN block idle
  */
-static int vcn_v5_0_0_wait_for_idle(void *handle)
+static int vcn_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	int i, ret = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 2d80aafcdbc6..31f3ed1e71f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -570,7 +570,7 @@ static bool vega10_ih_is_idle(void *handle)
 	return true;
 }
 
-static int vega10_ih_wait_for_idle(void *handle)
+static int vega10_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 	return -ETIMEDOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index c2461211aefb..6a9ef3e92c3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -636,7 +636,7 @@ static bool vega20_ih_is_idle(void *handle)
 	return true;
 }
 
-static int vega20_ih_wait_for_idle(void *handle)
+static int vega20_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* todo */
 	return -ETIMEDOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index e832dd50a628..b1d78ccda81c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1750,7 +1750,7 @@ static bool vi_common_is_idle(void *handle)
 	return true;
 }
 
-static int vi_common_wait_for_idle(void *handle)
+static int vi_common_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 87429766c70f..ae8d626a1414 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -320,7 +320,7 @@ static bool dm_is_idle(void *handle)
 	return true;
 }
 
-static int dm_wait_for_idle(void *handle)
+static int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
 	return 0;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 6601d3e0f5dd..d095a73e7e6d 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -391,7 +391,7 @@ struct amd_ip_funcs {
 	int (*suspend)(void *handle);
 	int (*resume)(void *handle);
 	bool (*is_idle)(void *handle);
-	int (*wait_for_idle)(void *handle);
+	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
 	bool (*check_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*pre_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 92c7e45c64b2..7d2ff59f76e7 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3099,7 +3099,7 @@ static bool kv_dpm_is_idle(void *handle)
 	return true;
 }
 
-static int kv_dpm_wait_for_idle(void *handle)
+static int kv_dpm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 157777db75c7..3a083506dbf4 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7843,7 +7843,7 @@ static bool si_dpm_is_idle(void *handle)
 	return true;
 }
 
-static int si_dpm_wait_for_idle(void *handle)
+static int si_dpm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX */
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 334f03c04257..d531d0848654 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -245,7 +245,7 @@ static bool pp_is_idle(void *handle)
 	return false;
 }
 
-static int pp_wait_for_idle(void *handle)
+static int pp_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	return 0;
 }
-- 
2.34.1

