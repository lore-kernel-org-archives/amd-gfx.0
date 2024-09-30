Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A8CE834C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C6A10E521;
	Mon, 30 Sep 2024 14:32:27 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FC610E51B
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:32:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48UEWF2x2682352; Mon, 30 Sep 2024 20:02:15 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48UEWF4B2682351;
 Mon, 30 Sep 2024 20:02:15 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 07/12] drm/amdgpu: update the handle ptr in post_soft_reset
Date: Mon, 30 Sep 2024 20:00:14 +0530
Message-Id: <20240930143019.2682202-8-sunil.khatri@amd.com>
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
functions pointers of post_soft_reset.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      | 4 ++--
 drivers/gpu/drm/amd/include/amd_shared.h   | 2 +-
 11 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 527b8f186f45..1e47655e02c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5070,7 +5070,7 @@ static int amdgpu_device_ip_post_soft_reset(struct amdgpu_device *adev)
 			continue;
 		if (adev->ip_blocks[i].status.hang &&
 		    adev->ip_blocks[i].version->funcs->post_soft_reset)
-			r = adev->ip_blocks[i].version->funcs->post_soft_reset(adev);
+			r = adev->ip_blocks[i].version->funcs->post_soft_reset(&adev->ip_blocks[i]);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ebf783763ac5..a0f80cc993cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4931,12 +4931,13 @@ static bool gfx_v11_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
-static int gfx_v11_0_post_soft_reset(void *handle)
+static int gfx_v11_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
 	/**
 	 * GFX soft reset will impact MES, need resume MES when do GFX soft reset
 	 */
-	return amdgpu_mes_resume((struct amdgpu_device *)handle);
+	return amdgpu_mes_resume(adev);
 }
 
 static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 0b72dc3062b5..6864219987e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5086,9 +5086,9 @@ static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gfx_v8_0_post_soft_reset(void *handle)
+static int gfx_v8_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 grbm_soft_reset = 0;
 
 	if ((!adev->gfx.grbm_soft_reset) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 7ffb33dd54ef..47ba4480b757 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1361,9 +1361,9 @@ static int gmc_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v8_0_post_soft_reset(void *handle)
+static int gmc_v8_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (!adev->gmc.srbm_soft_reset)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 3e702853e0ac..18bc1463238f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1271,9 +1271,9 @@ static int sdma_v3_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v3_0_post_soft_reset(void *handle)
+static int sdma_v3_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset = 0;
 
 	if (!adev->sdma.srbm_soft_reset)
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index 59f167166f83..d76c528d08f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -415,9 +415,9 @@ static int tonga_ih_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 	return tonga_ih_hw_fini(adev);
 }
 
-static int tonga_ih_post_soft_reset(void *handle)
+static int tonga_ih_post_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (!adev->irq.srbm_soft_reset)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 1046ab677ea7..0c334d90e4f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1226,9 +1226,9 @@ static int uvd_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int uvd_v6_0_post_soft_reset(void *handle)
+static int uvd_v6_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (!adev->uvd.inst->srbm_soft_reset)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index d4342556c09c..6c2acde977b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1548,9 +1548,9 @@ static int uvd_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int uvd_v7_0_post_soft_reset(void *handle)
+static int uvd_v7_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (!adev->uvd.inst[ring->me].srbm_soft_reset)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 34d7c2e4da8e..92ffd3fa5b00 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -712,9 +712,9 @@ static int vce_v3_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 }
 
 
-static int vce_v3_0_post_soft_reset(void *handle)
+static int vce_v3_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (!adev->vce.srbm_soft_reset)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index b5399ecb6bb2..b17aabaf220a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -806,9 +806,9 @@ static int vce_v4_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 }
 
 
-static int vce_v4_0_post_soft_reset(void *handle)
+static int vce_v4_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (!adev->vce.srbm_soft_reset)
 		return 0;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 97a1726cd968..6601d3e0f5dd 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -395,7 +395,7 @@ struct amd_ip_funcs {
 	bool (*check_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*pre_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
-	int (*post_soft_reset)(void *handle);
+	int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*set_clockgating_state)(void *handle,
 				     enum amd_clockgating_state state);
 	int (*set_powergating_state)(void *handle,
-- 
2.34.1

