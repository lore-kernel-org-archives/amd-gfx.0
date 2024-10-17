Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DA7D3C520
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 16:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA8A510E879;
	Thu, 17 Oct 2024 16:25:58 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D80010E86F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 16:25:56 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 49HGPnIY1551505; Thu, 17 Oct 2024 21:55:49 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 49HGPnAL1551504;
 Thu, 17 Oct 2024 21:55:49 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v5 03/12] drm/amdgpu: validate suspend before function call
Date: Thu, 17 Oct 2024 21:55:22 +0530
Message-Id: <20241017162531.1551442-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017162531.1551442-1-sunil.khatri@amd.com>
References: <20241017162531.1551442-1-sunil.khatri@amd.com>
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

Before making a function call to suspend, validate
the function pointer like we do in sw_init.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c      |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 15 +++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 10 +++-------
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 10 +++-------
 5 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index c1ff24335a0c..f0a7bb4eaf31 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -85,14 +85,9 @@ static int aldebaran_mode2_suspend_ip(struct amdgpu_device *adev)
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 
-		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
-
-		if (r) {
-			dev_err(adev->dev,
-				"suspend of IP block <%s> failed %d\n",
-				adev->ip_blocks[i].version->funcs->name, r);
+		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
+		if (r)
 			return r;
-		}
 
 		adev->ip_blocks[i].status.hw = false;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f69aba68e7b1..2d098c876151 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3490,13 +3490,9 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 			continue;
 
 		/* XXX handle errors */
-		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
-		/* XXX handle errors */
-		if (r) {
-			DRM_ERROR("suspend of IP block <%s> failed %d\n",
-				  adev->ip_blocks[i].version->funcs->name, r);
+		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
+		if (r)
 			return r;
-		}
 
 		adev->ip_blocks[i].status.hw = false;
 	}
@@ -3572,12 +3568,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			continue;
 
 		/* XXX handle errors */
-		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
-		/* XXX handle errors */
-		if (r) {
-			DRM_ERROR("suspend of IP block <%s> failed %d\n",
-				  adev->ip_blocks[i].version->funcs->name, r);
-		}
+		amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
 		adev->ip_blocks[i].status.hw = false;
 		/* handle putting the SMC in the appropriate state */
 		if (!amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 3e2724590dbf..99e75d899c9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -28,7 +28,7 @@
 
 static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 {
-	int i, r;
+	int i;
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
@@ -40,12 +40,7 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 			continue;
 
 		/* XXX handle errors */
-		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
-		/* XXX handle errors */
-		if (r) {
-			dev_err(adev->dev, "suspend of IP block <%s> failed %d",
-				adev->ip_blocks[i].version->funcs->name, r);
-		}
+		amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
 		adev->ip_blocks[i].status.hw = false;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 475b7df3a908..5327d8c5c245 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -81,14 +81,10 @@ static int sienna_cichlid_mode2_suspend_ip(struct amdgpu_device *adev)
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 
-		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
-
-		if (r) {
-			dev_err(adev->dev,
-				"suspend of IP block <%s> failed %d\n",
-				adev->ip_blocks[i].version->funcs->name, r);
+		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
+		if (r)
 			return r;
-		}
+
 		adev->ip_blocks[i].status.hw = false;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index 5ea9090b5040..d4c4d811e547 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -80,14 +80,10 @@ static int smu_v13_0_10_mode2_suspend_ip(struct amdgpu_device *adev)
 			      AMD_IP_BLOCK_TYPE_MES))
 			continue;
 
-		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
-
-		if (r) {
-			dev_err(adev->dev,
-				"suspend of IP block <%s> failed %d\n",
-				adev->ip_blocks[i].version->funcs->name, r);
+		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
+		if (r)
 			return r;
-		}
+
 		adev->ip_blocks[i].status.hw = false;
 	}
 
-- 
2.34.1

