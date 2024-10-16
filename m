Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010F3D206AD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 07:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977D110E69E;
	Wed, 16 Oct 2024 07:23:14 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF9A10E69A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 07:23:11 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 49G7N1bP1399808; Wed, 16 Oct 2024 12:53:01 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 49G7N1qE1399807;
 Wed, 16 Oct 2024 12:53:01 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 16/16] drm/amdgpu: validate hw_init function pointers
Date: Wed, 16 Oct 2024 12:52:58 +0530
Message-Id: <20241016072258.1399698-17-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016072258.1399698-1-sunil.khatri@amd.com>
References: <20241016072258.1399698-1-sunil.khatri@amd.com>
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

Validate function pointer at all the places where
hw_init is called to avoid a NULL dereference.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 82 ++++++++++++++--------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b9ca5b1cde0c..4142acc36796 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2687,11 +2687,13 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 		    (amdgpu_sriov_vf(adev) && (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)) ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
-			r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
-			if (r) {
-				DRM_ERROR("hw_init of IP block <%s> failed %d\n",
-					  adev->ip_blocks[i].version->funcs->name, r);
-				return r;
+			if (adev->ip_blocks[i].version->funcs->hw_init) {
+				r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
+				if (r) {
+					DRM_ERROR("hw_init of IP block <%s> failed %d\n",
+						adev->ip_blocks[i].version->funcs->name, r);
+					return r;
+				}
 			}
 			adev->ip_blocks[i].status.hw = true;
 		}
@@ -2712,11 +2714,13 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
 		if (!amdgpu_ip_member_of_hwini(
 			    adev, adev->ip_blocks[i].version->type))
 			continue;
-		r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
-		if (r) {
-			DRM_ERROR("hw_init of IP block <%s> failed %d\n",
-				  adev->ip_blocks[i].version->funcs->name, r);
-			return r;
+		if (adev->ip_blocks[i].version->funcs->hw_init) {
+			r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
+			if (r) {
+				DRM_ERROR("hw_init of IP block <%s> failed %d\n",
+					adev->ip_blocks[i].version->funcs->name, r);
+				return r;
+			}
 		}
 		adev->ip_blocks[i].status.hw = true;
 	}
@@ -2758,11 +2762,15 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 					}
 				}
 			} else {
-				r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
-				if (r) {
-					DRM_ERROR("hw_init of IP block <%s> failed %d\n",
-							  adev->ip_blocks[i].version->funcs->name, r);
-					return r;
+				if (adev->ip_blocks[i].version->funcs->hw_init) {
+					r = adev->ip_blocks[i].version->funcs
+						->hw_init(&adev->ip_blocks[i]);
+					if (r) {
+						DRM_ERROR("hw_init of IP block <%s> failed %d\n",
+						adev->ip_blocks[i].version->funcs->name,
+						r);
+						return r;
+					}
 				}
 			}
 
@@ -2873,11 +2881,17 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 			continue;
 
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
-			/* need to do common hw init early so everything is set up for gmc */
-			r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
-			if (r) {
-				DRM_ERROR("hw_init %d failed %d\n", i, r);
-				goto init_failed;
+			if (adev->ip_blocks[i].version->funcs->hw_init) {
+				/*
+				 * need to do common hw init early so everything
+				 * is set up for gmc.
+				 */
+				r = adev->ip_blocks[i].version->funcs
+					->hw_init(&adev->ip_blocks[i]);
+				if (r) {
+					DRM_ERROR("hw_init %d failed %d\n", i, r);
+					goto init_failed;
+				}
 			}
 			adev->ip_blocks[i].status.hw = true;
 		} else if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
@@ -2891,10 +2905,12 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 				DRM_ERROR("amdgpu_mem_scratch_init failed %d\n", r);
 				goto init_failed;
 			}
-			r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
-			if (r) {
-				DRM_ERROR("hw_init %d failed %d\n", i, r);
-				goto init_failed;
+			if (adev->ip_blocks[i].version->funcs->hw_init) {
+				r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
+				if (r) {
+					DRM_ERROR("hw_init %d failed %d\n", i, r);
+					goto init_failed;
+				}
 			}
 			r = amdgpu_device_wb_init(adev);
 			if (r) {
@@ -3643,11 +3659,13 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 			if (block->version->type != ip_order[j] ||
 				!block->status.valid)
 				continue;
-
-			r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
-			DRM_INFO("RE-INIT-early: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
-			if (r)
-				return r;
+			if (adev->ip_blocks[i].version->funcs->hw_init) {
+				r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
+				DRM_INFO("RE-INIT-early: %s %s\n", block->version->funcs->name,
+					 r?"failed":"succeeded");
+				if (r)
+					return r;
+			}
 			block->status.hw = true;
 		}
 	}
@@ -3687,10 +3705,12 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 				if (adev->ip_blocks[i].version->funcs->resume)
 					r = block->version->funcs->resume(&adev->ip_blocks[i]);
 			} else {
-				r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
+				if (adev->ip_blocks[i].version->funcs->hw_init)
+					r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
 			}
 
-			DRM_INFO("RE-INIT-late: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
+			DRM_INFO("RE-INIT-late: %s %s\n", block->version->funcs->name,
+				 r ? "failed":"succeeded");
 			if (r)
 				return r;
 			block->status.hw = true;
-- 
2.34.1

