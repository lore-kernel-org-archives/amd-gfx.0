Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B202BCE834B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BAA610E534;
	Mon, 30 Sep 2024 14:32:51 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445B010E51C
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:32:46 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48UEWF5V2682342; Mon, 30 Sep 2024 20:02:15 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48UEWFCM2682341;
 Mon, 30 Sep 2024 20:02:15 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 05/12] drm/amdgpu: update the handle ptr in pre_soft_reset
Date: Mon, 30 Sep 2024 20:00:12 +0530
Message-Id: <20240930143019.2682202-6-sunil.khatri@amd.com>
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
functions pointers of pre_soft_reset.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      | 4 ++--
 drivers/gpu/drm/amd/include/amd_shared.h   | 2 +-
 10 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 595a10b23b3f..dfba53afe8d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4979,7 +4979,7 @@ static int amdgpu_device_ip_pre_soft_reset(struct amdgpu_device *adev)
 			continue;
 		if (adev->ip_blocks[i].status.hang &&
 		    adev->ip_blocks[i].version->funcs->pre_soft_reset) {
-			r = adev->ip_blocks[i].version->funcs->pre_soft_reset(adev);
+			r = adev->ip_blocks[i].version->funcs->pre_soft_reset(&adev->ip_blocks[i]);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index d14a3412a0ff..9a15bf5e6b93 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4983,9 +4983,9 @@ static bool gfx_v8_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	}
 }
 
-static int gfx_v8_0_pre_soft_reset(void *handle)
+static int gfx_v8_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 grbm_soft_reset = 0;
 
 	if ((!adev->gfx.grbm_soft_reset) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 0d300f5c9411..f579c710d3d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1316,9 +1316,9 @@ static bool gmc_v8_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
-static int gmc_v8_0_pre_soft_reset(void *handle)
+static int gmc_v8_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (!adev->gmc.srbm_soft_reset)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 7e2a523bbe1f..e7f4f7138df0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1252,9 +1252,9 @@ static bool sdma_v3_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	}
 }
 
-static int sdma_v3_0_pre_soft_reset(void *handle)
+static int sdma_v3_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	u32 srbm_soft_reset = 0;
 
 	if (!adev->sdma.srbm_soft_reset)
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index 573a2e194bb5..7cdf6a10607f 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -405,9 +405,9 @@ static bool tonga_ih_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	}
 }
 
-static int tonga_ih_pre_soft_reset(void *handle)
+static int tonga_ih_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (!adev->irq.srbm_soft_reset)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 7364cecca81a..9e6043f57805 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1184,9 +1184,9 @@ static bool uvd_v6_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	}
 }
 
-static int uvd_v6_0_pre_soft_reset(void *handle)
+static int uvd_v6_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (!adev->uvd.inst->srbm_soft_reset)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 52d613b4cd84..eebdf7b2d633 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1506,9 +1506,9 @@ static bool uvd_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	}
 }
 
-static int uvd_v7_0_pre_soft_reset(void *handle)
+static int uvd_v7_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (!adev->uvd.inst[ring->me].srbm_soft_reset)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6a8f555ffc61..6b7916c72193 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -699,9 +699,9 @@ static int vce_v3_0_soft_reset(void *handle)
 	return 0;
 }
 
-static int vce_v3_0_pre_soft_reset(void *handle)
+static int vce_v3_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (!adev->vce.srbm_soft_reset)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index c89ae2d87b02..83b7ce5e764f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -793,9 +793,9 @@ static int vce_v4_0_soft_reset(void *handle)
 	return 0;
 }
 
-static int vce_v4_0_pre_soft_reset(void *handle)
+static int vce_v4_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (!adev->vce.srbm_soft_reset)
 		return 0;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 1130dac8d173..15cd8288b9ac 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -393,7 +393,7 @@ struct amd_ip_funcs {
 	bool (*is_idle)(void *handle);
 	int (*wait_for_idle)(void *handle);
 	bool (*check_soft_reset)(struct amdgpu_ip_block *ip_block);
-	int (*pre_soft_reset)(void *handle);
+	int (*pre_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*soft_reset)(void *handle);
 	int (*post_soft_reset)(void *handle);
 	int (*set_clockgating_state)(void *handle,
-- 
2.34.1

