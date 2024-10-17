Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54493D21275
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 10:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D574910E7E1;
	Thu, 17 Oct 2024 10:06:33 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3AF910E7DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 10:06:24 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 49HA6IiW1492208; Thu, 17 Oct 2024 15:36:18 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 49HA6IgE1492207;
 Thu, 17 Oct 2024 15:36:18 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v4 07/15] drm/amdgpu: validate resume before function call
Date: Thu, 17 Oct 2024 15:36:07 +0530
Message-Id: <20241017100615.1492144-8-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017100615.1492144-1-sunil.khatri@amd.com>
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 23 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 47 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 28 ++++++------
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 14 +++---
 4 files changed, 66 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index e55d680d95ce..4dd9af51210d 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -247,9 +247,11 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 		dev_err(adev->dev, "Failed to get BIF handle\n");
 		return -EINVAL;
 	}
-	r = cmn_block->version->funcs->resume(cmn_block);
-	if (r)
-		return r;
+	if (cmn_block->version->funcs->resume) {
+		r = cmn_block->version->funcs->resume(cmn_block);
+		if (r)
+			return r;
+	}
 
 	/* Reinit GFXHUB */
 	adev->gfxhub.funcs->init(adev);
@@ -283,12 +285,15 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 		      adev->ip_blocks[i].version->type ==
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-		if (r) {
-			dev_err(adev->dev,
-				"resume of IP block <%s> failed %d\n",
-				adev->ip_blocks[i].version->funcs->name, r);
-			return r;
+
+		if (adev->ip_blocks[i].version->funcs->resume) {
+			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
+			if (r) {
+				dev_err(adev->dev,
+					"resume of IP block <%s> failed %d\n",
+					adev->ip_blocks[i].version->funcs->name, r);
+				return r;
+			}
 		}
 
 		adev->ip_blocks[i].status.hw = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fda89aeb4d1b..aa7314c14db8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2744,11 +2744,15 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 				break;
 
 			if (amdgpu_in_reset(adev) || adev->in_suspend) {
-				r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-				if (r) {
-					DRM_ERROR("resume of IP block <%s> failed %d\n",
-							  adev->ip_blocks[i].version->funcs->name, r);
-					return r;
+				if (adev->ip_blocks[i].version->funcs->resume) {
+					r = adev->ip_blocks[i].version->funcs->resume(
+						&adev->ip_blocks[i]);
+					if (r) {
+						DRM_ERROR("resume of IP block <%s> failed %d\n",
+							adev->ip_blocks[i].version->funcs
+							->name, r);
+						return r;
+					}
 				}
 			} else {
 				r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
@@ -3683,10 +3687,12 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 				block->status.hw)
 				continue;
 
-			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC)
-				r = block->version->funcs->resume(&adev->ip_blocks[i]);
-			else
+			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC) {
+				if (adev->ip_blocks[i].version->funcs->resume)
+					r = block->version->funcs->resume(&adev->ip_blocks[i]);
+			} else {
 				r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
+			}
 
 			DRM_INFO("RE-INIT-late: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
 			if (r)
@@ -3721,12 +3727,13 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP && amdgpu_sriov_vf(adev))) {
-
-			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-			if (r) {
-				DRM_ERROR("resume of IP block <%s> failed %d\n",
-					  adev->ip_blocks[i].version->funcs->name, r);
-				return r;
+			if (adev->ip_blocks[i].version->funcs->resume) {
+				r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
+				if (r) {
+					DRM_ERROR("resume of IP block <%s> failed %d\n",
+						adev->ip_blocks[i].version->funcs->name, r);
+					return r;
+				}
 			}
 			adev->ip_blocks[i].status.hw = true;
 		}
@@ -3760,11 +3767,13 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
 			continue;
-		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-		if (r) {
-			DRM_ERROR("resume of IP block <%s> failed %d\n",
-				  adev->ip_blocks[i].version->funcs->name, r);
-			return r;
+		if (adev->ip_blocks[i].version->funcs->resume) {
+			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
+			if (r) {
+				DRM_ERROR("resume of IP block <%s> failed %d\n",
+					adev->ip_blocks[i].version->funcs->name, r);
+				return r;
+			}
 		}
 		adev->ip_blocks[i].status.hw = true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 10dece12509f..082a69babe62 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -176,12 +176,14 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
-			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-			if (r) {
-				dev_err(adev->dev,
-					"resume of IP block <%s> failed %d\n",
-					adev->ip_blocks[i].version->funcs->name, r);
-				return r;
+			if (adev->ip_blocks[i].version->funcs->resume) {
+				r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
+				if (r) {
+					dev_err(adev->dev,
+						"resume of IP block <%s> failed %d\n",
+						adev->ip_blocks[i].version->funcs->name, r);
+					return r;
+				}
 			}
 
 			adev->ip_blocks[i].status.hw = true;
@@ -194,12 +196,14 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 		      adev->ip_blocks[i].version->type ==
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-		if (r) {
-			dev_err(adev->dev,
-				"resume of IP block <%s> failed %d\n",
-				adev->ip_blocks[i].version->funcs->name, r);
-			return r;
+		if (adev->ip_blocks[i].version->funcs->resume) {
+			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
+			if (r) {
+				dev_err(adev->dev,
+					"resume of IP block <%s> failed %d\n",
+					adev->ip_blocks[i].version->funcs->name, r);
+				return r;
+			}
 		}
 
 		adev->ip_blocks[i].status.hw = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index ab049f0b4d39..2e041424ef9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -187,12 +187,14 @@ static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
 		      adev->ip_blocks[i].version->type ==
 			      AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
-		if (r) {
-			dev_err(adev->dev,
-				"resume of IP block <%s> failed %d\n",
-				adev->ip_blocks[i].version->funcs->name, r);
-			return r;
+		if (adev->ip_blocks[i].version->funcs->resume) {
+			r = adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
+			if (r) {
+				dev_err(adev->dev,
+					"resume of IP block <%s> failed %d\n",
+					adev->ip_blocks[i].version->funcs->name, r);
+				return r;
+			}
 		}
 
 		adev->ip_blocks[i].status.hw = true;
-- 
2.34.1

