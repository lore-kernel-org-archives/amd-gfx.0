Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63594D30008
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 13:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E31F010E916;
	Fri, 18 Oct 2024 13:23:44 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B5F10E916
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 13:23:44 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 49IDNdbC1638293; Fri, 18 Oct 2024 18:53:39 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 49IDNdFF1638292;
 Fri, 18 Oct 2024 18:53:39 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v6 04/12] drm/amdgpu: validate suspend before function call
Date: Fri, 18 Oct 2024 18:53:19 +0530
Message-Id: <20241018132327.1638247-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018132327.1638247-1-sunil.khatri@amd.com>
References: <20241018132327.1638247-1-sunil.khatri@amd.com>
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

Use the helper function amdgpu_ip_block_suspend where
same checks and calls are repeated.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 11 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 38 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  9 ++---
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 10 ++----
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 10 ++----
 6 files changed, 32 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index c1ff24335a0c..07f195a89e9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -85,16 +85,9 @@ static int aldebaran_mode2_suspend_ip(struct amdgpu_device *adev)
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
-
-		adev->ip_blocks[i].status.hw = false;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 48c9b9b06905..df57efa019ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -364,6 +364,7 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			      enum amd_ip_block_type block_type);
+int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
 
 #define AMDGPU_MAX_IP_NUM 16
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3ccc5a608bf2..2dca9fd14ad3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -272,6 +272,24 @@ void amdgpu_reg_state_sysfs_fini(struct amdgpu_device *adev)
 	sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_reg_state);
 }
 
+int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+
+	if (ip_block->version->funcs->suspend) {
+		r = ip_block->version->funcs->suspend(ip_block);
+		if (r) {
+			dev_err(ip_block->adev->dev,
+				"suspend of IP block <%s> failed %d\n",
+				ip_block->version->funcs->name, r);
+			return r;
+		}
+	}
+
+	ip_block->status.hw = false;
+	return 0;
+}
+
 /**
  * DOC: board_info
  *
@@ -3473,15 +3491,9 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
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
-
-		adev->ip_blocks[i].status.hw = false;
 	}
 
 	return 0;
@@ -3555,14 +3567,10 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
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
-		adev->ip_blocks[i].status.hw = false;
+
 		/* handle putting the SMC in the appropriate state */
 		if (!amdgpu_sriov_vf(adev)) {
 			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 70f737c52a90..0b66d902d572 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -40,14 +40,9 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 			continue;
 
 		/* XXX handle errors */
-		r = adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
-		/* XXX handle errors */
-		if (r) {
-			dev_err(adev->dev, "suspend of IP block <%s> failed %d",
-				adev->ip_blocks[i].version->funcs->name, r);
+		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
+		if (r)
 			return r;
-		}
-		adev->ip_blocks[i].status.hw = false;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 475b7df3a908..341de4e38eeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -81,15 +81,9 @@ static int sienna_cichlid_mode2_suspend_ip(struct amdgpu_device *adev)
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
-		adev->ip_blocks[i].status.hw = false;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index 5ea9090b5040..12e792ca873b 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -80,15 +80,9 @@ static int smu_v13_0_10_mode2_suspend_ip(struct amdgpu_device *adev)
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
-		adev->ip_blocks[i].status.hw = false;
 	}
 
 	return 0;
-- 
2.34.1

