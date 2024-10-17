Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0134BD3C521
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 16:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB12110E86C;
	Thu, 17 Oct 2024 16:25:58 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5DB010E875
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 16:25:56 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 49HGPn6e1551515; Thu, 17 Oct 2024 21:55:49 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 49HGPnoB1551514;
 Thu, 17 Oct 2024 21:55:49 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v5 05/12] drm/amdgpu: validate resume before function call
Date: Thu, 17 Oct 2024 21:55:24 +0530
Message-Id: <20241017162531.1551442-6-sunil.khatri@amd.com>
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

Before making a function call to resume, validate
the function pointer like we do in sw_init.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 11 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 24 +++++++--------------
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 16 ++++----------
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   |  8 ++-----
 4 files changed, 18 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index f0a7bb4eaf31..2d0f07dc8b2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -241,7 +241,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 		dev_err(adev->dev, "Failed to get BIF handle\n");
 		return -EINVAL;
 	}
-	r = cmn_block->version->funcs->resume(cmn_block);
+	r = amdgpu_ip_block_resume(cmn_block);
 	if (r)
 		return r;
 
@@ -277,13 +277,10 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 		      adev->ip_blocks[i].version->type ==
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-		if (r) {
-			dev_err(adev->dev,
-				"resume of IP block <%s> failed %d\n",
-				adev->ip_blocks[i].version->funcs->name, r);
+
+		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+		if (r)
 			return r;
-		}
 
 		adev->ip_blocks[i].status.hw = true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 77669eab3511..3dd9354c4f8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2778,12 +2778,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 				break;
 
 			if (amdgpu_in_reset(adev) || adev->in_suspend) {
-				r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-				if (r) {
-					DRM_ERROR("resume of IP block <%s> failed %d\n",
-							  adev->ip_blocks[i].version->funcs->name, r);
+				r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+				if (r)
 					return r;
-				}
 			} else {
 				r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
 				if (r) {
@@ -3700,7 +3697,7 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 				continue;
 
 			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC)
-				r = block->version->funcs->resume(&adev->ip_blocks[i]);
+				r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
 			else
 				r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
 
@@ -3738,12 +3735,9 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP && amdgpu_sriov_vf(adev))) {
 
-			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-			if (r) {
-				DRM_ERROR("resume of IP block <%s> failed %d\n",
-					  adev->ip_blocks[i].version->funcs->name, r);
+			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+			if (r)
 				return r;
-			}
 			adev->ip_blocks[i].status.hw = true;
 		}
 	}
@@ -3776,12 +3770,10 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
 			continue;
-		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-		if (r) {
-			DRM_ERROR("resume of IP block <%s> failed %d\n",
-				  adev->ip_blocks[i].version->funcs->name, r);
+		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+		if (r)
 			return r;
-		}
+
 		adev->ip_blocks[i].status.hw = true;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 5327d8c5c245..798653247800 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -171,13 +171,9 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
-			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-			if (r) {
-				dev_err(adev->dev,
-					"resume of IP block <%s> failed %d\n",
-					adev->ip_blocks[i].version->funcs->name, r);
+			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+			if (r)
 				return r;
-			}
 
 			adev->ip_blocks[i].status.hw = true;
 		}
@@ -189,13 +185,9 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 		      adev->ip_blocks[i].version->type ==
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-		if (r) {
-			dev_err(adev->dev,
-				"resume of IP block <%s> failed %d\n",
-				adev->ip_blocks[i].version->funcs->name, r);
+		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+		if (r)
 			return r;
-		}
 
 		adev->ip_blocks[i].status.hw = true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index d4c4d811e547..c38045a58458 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -182,13 +182,9 @@ static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
 		      adev->ip_blocks[i].version->type ==
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-		if (r) {
-			dev_err(adev->dev,
-				"resume of IP block <%s> failed %d\n",
-				adev->ip_blocks[i].version->funcs->name, r);
+		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+		if (r)
 			return r;
-		}
 
 		adev->ip_blocks[i].status.hw = true;
 	}
-- 
2.34.1

