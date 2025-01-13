Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F189C02183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CFD10E3D2;
	Mon, 13 Jan 2025 01:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fqNy0unH";
	dkim-atps=neutral
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36CF10E34E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736732550; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=RLGQ/VKPqPBOZ5UW45hOBW3mbnohKBTO2ng3enXOuPo=;
 b=fqNy0unHNxtP+p690BqioPB4T6Je1qY6zFLDKCTgrJ9UJsI96gXU38sPcklqVd3rQY2z9+NXJvwnfT5/CRr6L824zscwSfn6aRokkJJtSMAMLz+eJZaPxhnZDw+A8sGg7drgCfsekN1M+olW/MbOE6YOsRCwrlRgDN3W+5Cn/Xo=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNS0NGH_1736732549 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:42:29 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 11/15] drm/amdgpu: convert ip block bool flags into an enum
Date: Mon, 13 Jan 2025 09:42:16 +0800
Message-ID: <17736b6c6c4cd8ca3f87800c469ff4a95429d5b7.1736732062.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736732062.git.gerry@linux.alibaba.com>
References: <cover.1736732062.git.gerry@linux.alibaba.com>
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

Convert ip block bool flags into an enumeration, to explicitly mark
current state of the ip block. Also introduce helper functions to
manipulate the ip block state. Now the state machine works as below:
Callbacks                    State after successfully execute callback
                             AMDGPU_IP_STATE_INVALID
.early_init()                AMDGPU_IP_STATE_EARLY
.sw_init()                   AMDGPU_IP_STATE_SW
.hw_init()                   AMDGPU_IP_STATE_HW
.late_init()                 AMDGPU_IP_STATE_LATE
.early_fini()                AMDGPU_IP_STATE_HW
.hw_fini()                   AMDGPU_IP_STATE_SW
.sw_fini()                   AMDGPU_IP_STATE_EARLY
.late_fini()                 AMDGPU_IP_STATE_INVALID

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  48 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 144 ++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |   6 +-
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c   |   2 +-
 9 files changed, 143 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index e13fbd974141..b2bad8837b64 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -301,7 +301,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 				return r;
 			}
 		}
-		adev->ip_blocks[i].status.late_initialized = true;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_LATE);
 	}
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 24ef39b706e3..f3275a281280 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -395,11 +395,32 @@ enum amdgpu_marker {
 
 #define AMDGPU_MARKER_IRQ(idx)		(AMDGPU_MARKER_IRQ0 + (idx))
 
+/**
+ * States for ip block state machine.
+ *
+ * The IP block state machine has five states and the associated state
+ * transition works in stack like way as below:
+ * Callbacks			State after successfully execute callback
+ *				AMDGPU_IP_STATE_INVALID
+ * .early_init()		AMDGPU_IP_STATE_EARLY
+ * .sw_init()			AMDGPU_IP_STATE_SW
+ * .hw_init()			AMDGPU_IP_STATE_HW
+ * .late_init()			AMDGPU_IP_STATE_LATE
+ * .early_fini()		AMDGPU_IP_STATE_HW
+ * .hw_fini()			AMDGPU_IP_STATE_SW
+ * .sw_fini()			AMDGPU_IP_STATE_EARLY
+ * .late_fini()			AMDGPU_IP_STATE_INVALID
+ */
+enum amdgpu_device_ip_state {
+	AMDGPU_IP_STATE_INVALID	= 0,
+	AMDGPU_IP_STATE_EARLY	= 1,
+	AMDGPU_IP_STATE_SW	= 2,
+	AMDGPU_IP_STATE_HW	= 3,
+	AMDGPU_IP_STATE_LATE	= 4,
+};
+
 struct amdgpu_ip_block_status {
-	bool valid;
-	bool sw;
-	bool hw;
-	bool late_initialized;
+	enum amdgpu_device_ip_state state;
 	bool hang;
 	uint64_t markers;
 };
@@ -429,6 +450,25 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
 int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 			       const struct amdgpu_ip_block_version *ip_block_version);
 
+void amdgpu_device_ip_set_state(struct amdgpu_device *adev, int index,
+				enum amdgpu_device_ip_state state);
+enum amdgpu_device_ip_state amdgpu_device_ip_state(struct amdgpu_device *adev,
+						   int index);
+bool amdgpu_device_ip_valid(struct amdgpu_device *adev, int index);
+void amdgpu_ip_block_set_state(struct amdgpu_ip_block *ip_block,
+			       enum amdgpu_device_ip_state state);
+
+static inline enum amdgpu_device_ip_state
+amdgpu_ip_block_state(struct amdgpu_ip_block *ip_block)
+{
+	return ip_block->status.state;
+}
+
+static inline bool amdgpu_ip_block_valid(struct amdgpu_ip_block *ip_block)
+{
+	return ip_block->status.state != AMDGPU_IP_STATE_INVALID;
+}
+
 static inline void amdgpu_ip_block_set_marker(struct amdgpu_ip_block *ip_block,
 					      enum amdgpu_marker marker)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c2e4057ecd82..fcfbdcfd1fa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -297,7 +297,7 @@ int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	ip_block->status.hw = false;
+	amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_SW);
 	return 0;
 }
 
@@ -315,7 +315,7 @@ int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	ip_block->status.hw = true;
+	amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_HW);
 	return 0;
 }
 
@@ -2164,7 +2164,7 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 	int i, r = 0;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		if (adev->ip_blocks[i].version->type != block_type)
 			continue;
@@ -2198,7 +2198,7 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 	int i, r = 0;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		if (adev->ip_blocks[i].version->type != block_type)
 			continue;
@@ -2230,7 +2230,7 @@ void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 	int i;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		if (adev->ip_blocks[i].version->funcs->get_clockgating_state)
 			adev->ip_blocks[i].version->funcs->get_clockgating_state((void *)adev, flags);
@@ -2252,7 +2252,7 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 	int i, r;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		if (adev->ip_blocks[i].version->type == block_type) {
 			if (adev->ip_blocks[i].version->funcs->wait_for_idle) {
@@ -2284,7 +2284,7 @@ bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (adev->ip_blocks[i].version->type == block_type)
-			return adev->ip_blocks[i].status.valid;
+			return amdgpu_device_ip_valid(adev, i);
 	}
 	return false;
 
@@ -2375,6 +2375,29 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 	return 0;
 }
 
+void amdgpu_device_ip_set_state(struct amdgpu_device *adev, int index,
+			       enum amdgpu_device_ip_state state)
+{
+	amdgpu_ip_block_set_state(&adev->ip_blocks[index], state);
+}
+
+enum amdgpu_device_ip_state amdgpu_device_ip_state(struct amdgpu_device *adev,
+						 int index)
+{
+	return amdgpu_ip_block_state(&adev->ip_blocks[index]);
+}
+
+bool amdgpu_device_ip_valid(struct amdgpu_device *adev, int index)
+{
+	return amdgpu_ip_block_valid(&adev->ip_blocks[index]);
+}
+
+void amdgpu_ip_block_set_state(struct amdgpu_ip_block *ip_block,
+			       enum amdgpu_device_ip_state state)
+{
+	ip_block->status.state = state;
+}
+
 /**
  * amdgpu_device_enable_virtual_display - enable virtual display feature
  *
@@ -2671,20 +2694,21 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		if ((amdgpu_ip_block_mask & (1 << i)) == 0) {
 			DRM_WARN("disabled ip block: %d <%s>\n",
 				  i, adev->ip_blocks[i].version->funcs->name);
-			adev->ip_blocks[i].status.valid = false;
+			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_INVALID);
 		} else if (ip_block->version->funcs->early_init) {
 			r = ip_block->version->funcs->early_init(ip_block);
 			if (r == -ENOENT) {
-				adev->ip_blocks[i].status.valid = false;
+				amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_INVALID);
 			} else if (r) {
 				DRM_ERROR("early_init of IP block <%s> failed %d\n",
 					  adev->ip_blocks[i].version->funcs->name, r);
 				total = false;
+				amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_INVALID);
 			} else {
-				adev->ip_blocks[i].status.valid = true;
+				amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_EARLY);
 			}
 		} else {
-			adev->ip_blocks[i].status.valid = true;
+			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_EARLY);
 		}
 		/* get the vbios after the asic_funcs are set up */
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
@@ -2715,7 +2739,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		return -ENODEV;
 
 	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
-	if (ip_block->status.valid != false)
+	if (amdgpu_ip_block_valid(ip_block))
 		amdgpu_amdkfd_device_probe(adev);
 
 	adev->cg_flags &= amdgpu_cg_mask;
@@ -2729,9 +2753,9 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.sw)
+		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_SW)
 			continue;
-		if (adev->ip_blocks[i].status.hw)
+		if (amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
 			continue;
 		if (!amdgpu_ip_member_of_hwini(
 			    adev, adev->ip_blocks[i].version->type))
@@ -2745,7 +2769,7 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
 					  adev->ip_blocks[i].version->funcs->name, r);
 				return r;
 			}
-			adev->ip_blocks[i].status.hw = true;
+			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
 		}
 	}
 
@@ -2757,9 +2781,9 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.sw)
+		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_SW)
 			continue;
-		if (adev->ip_blocks[i].status.hw)
+		if (amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
 			continue;
 		if (!amdgpu_ip_member_of_hwini(
 			    adev, adev->ip_blocks[i].version->type))
@@ -2770,7 +2794,7 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
 				  adev->ip_blocks[i].version->funcs->name, r);
 			return r;
 		}
-		adev->ip_blocks[i].status.hw = true;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
 	}
 
 	return 0;
@@ -2791,11 +2815,11 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 						       AMD_IP_BLOCK_TYPE_PSP))
 				break;
 
-			if (!adev->ip_blocks[i].status.sw)
+			if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_SW)
 				continue;
 
 			/* no need to do the fw loading again if already done*/
-			if (adev->ip_blocks[i].status.hw == true)
+			if (amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
 				break;
 
 			if (amdgpu_in_reset(adev) || adev->in_suspend) {
@@ -2809,7 +2833,7 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 							  adev->ip_blocks[i].version->funcs->name, r);
 					return r;
 				}
-				adev->ip_blocks[i].status.hw = true;
+				amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
 			}
 			break;
 		}
@@ -2900,7 +2924,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		return r;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		if (adev->ip_blocks[i].version->funcs->sw_init) {
 			r = adev->ip_blocks[i].version->funcs->sw_init(&adev->ip_blocks[i]);
@@ -2910,7 +2934,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 				goto init_failed;
 			}
 		}
-		adev->ip_blocks[i].status.sw = true;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
 
 		if (!amdgpu_ip_member_of_hwini(
 			    adev, adev->ip_blocks[i].version->type))
@@ -2923,7 +2947,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 				DRM_ERROR("hw_init %d failed %d\n", i, r);
 				goto init_failed;
 			}
-			adev->ip_blocks[i].status.hw = true;
+			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
 		} else if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
 			/* need to do gmc hw init early so we can allocate gpu mem */
 			/* Try to reserve bad pages early */
@@ -2945,7 +2969,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 				DRM_ERROR("amdgpu_device_wb_init failed %d\n", r);
 				goto init_failed;
 			}
-			adev->ip_blocks[i].status.hw = true;
+			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
 
 			/* right after GMC hw init, we create CSA */
 			if (adev->gfx.mcbp) {
@@ -3130,7 +3154,7 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 
 	for (j = 0; j < adev->num_ip_blocks; j++) {
 		i = state == AMD_CG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
-		if (!adev->ip_blocks[i].status.late_initialized)
+		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_LATE)
 			continue;
 		/* skip CG for GFX, SDMA on S0ix */
 		if (adev->in_s0ix &&
@@ -3167,7 +3191,7 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 
 	for (j = 0; j < adev->num_ip_blocks; j++) {
 		i = state == AMD_PG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
-		if (!adev->ip_blocks[i].status.late_initialized)
+		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_LATE)
 			continue;
 		/* skip PG for GFX, SDMA on S0ix */
 		if (adev->in_s0ix &&
@@ -3246,7 +3270,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	int i = 0, r;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.hw)
+		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_HW)
 			continue;
 		if (adev->ip_blocks[i].version->funcs->late_init) {
 			r = adev->ip_blocks[i].version->funcs->late_init(&adev->ip_blocks[i]);
@@ -3256,7 +3280,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 				return r;
 			}
 		}
-		adev->ip_blocks[i].status.late_initialized = true;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_LATE);
 	}
 
 	r = amdgpu_ras_late_init(adev);
@@ -3336,7 +3360,7 @@ static void amdgpu_ip_block_hw_fini(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	ip_block->status.hw = false;
+	amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_SW);
 }
 
 /**
@@ -3354,7 +3378,7 @@ static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
 		return;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.hw)
+		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_HW)
 			continue;
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
 			amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
@@ -3377,7 +3401,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 				  adev->ip_blocks[i].version->funcs->name, r);
 		}
 
-		adev->ip_blocks[i].status.late_initialized = false;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
 	}
 
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
@@ -3389,7 +3413,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_smu_fini_early(adev);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!adev->ip_blocks[i].status.hw)
+		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_HW)
 			continue;
 
 		amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
@@ -3427,7 +3451,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 	amdgpu_amdkfd_device_fini_sw(adev);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!adev->ip_blocks[i].status.sw)
+		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_SW)
 			continue;
 
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
@@ -3446,17 +3470,17 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 					  adev->ip_blocks[i].version->funcs->name, r);
 			}
 		}
-		adev->ip_blocks[i].status.sw = false;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_EARLY);
 	}
 
 	amdgpu_ras_fini(adev);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		if (adev->ip_blocks[i].version->funcs->late_fini)
 			adev->ip_blocks[i].version->funcs->late_fini(&adev->ip_blocks[i]);
-		adev->ip_blocks[i].status.valid = false;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_INVALID);
 	}
 
 	return 0;
@@ -3517,9 +3541,9 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 		dev_warn(adev->dev, "Failed to disallow df cstate");
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
-		if (!adev->ip_blocks[i].status.late_initialized)
+		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_LATE)
 			continue;
 
 		if (adev->ip_blocks[i].version->funcs->early_fini) {
@@ -3531,11 +3555,11 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 			}
 		}
 
-		adev->ip_blocks[i].status.late_initialized = false;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
 	}
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 
 		/* displays are handled separately */
@@ -3570,7 +3594,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D3Entry);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		/* displays are handled in phase1 */
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE)
@@ -3578,7 +3602,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		/* PSP lost connection when err_event_athub occurs */
 		if (amdgpu_ras_intr_triggered() &&
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP) {
-			adev->ip_blocks[i].status.hw = false;
+			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
 			continue;
 		}
 
@@ -3620,7 +3644,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 
 		/* XXX handle errors */
 		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
-		adev->ip_blocks[i].status.hw = false;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
 
 		/* handle putting the SMC in the appropriate state */
 		if (!amdgpu_sriov_vf(adev)) {
@@ -3687,12 +3711,12 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		struct amdgpu_ip_block *block;
 
 		block = &adev->ip_blocks[i];
-		block->status.hw = false;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
 
 		for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
 
 			if (block->version->type != ip_order[j] ||
-				!block->status.valid)
+			    !amdgpu_device_ip_valid(adev, i))
 				continue;
 
 			r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
@@ -3701,7 +3725,7 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 					 block->version->funcs->name);
 				return r;
 			}
-			block->status.hw = true;
+			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
 		}
 	}
 
@@ -3731,7 +3755,8 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 		if (!block)
 			continue;
 
-		if (block->status.valid && !block->status.hw) {
+		if (amdgpu_ip_block_valid(block) &&
+		    amdgpu_ip_block_state(block) < AMDGPU_IP_STATE_HW) {
 			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC) {
 				r = amdgpu_ip_block_resume(block);
 			} else {
@@ -3743,7 +3768,7 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 					 block->version->funcs->name);
 				break;
 			}
-			block->status.hw = true;
+			amdgpu_ip_block_set_state(block, AMDGPU_IP_STATE_HW);
 		}
 	}
 
@@ -3767,7 +3792,8 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
+		if (!amdgpu_device_ip_valid(adev, i) ||
+		    amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
 			continue;
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
@@ -3801,7 +3827,8 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
+		if (!amdgpu_device_ip_valid(adev, i) ||
+		    amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
 			continue;
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
@@ -3835,7 +3862,8 @@ static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
+		if (!amdgpu_device_ip_valid(adev, i) ||
+		    amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
 			continue;
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
 			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
@@ -4888,7 +4916,7 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		if (!adev->ip_blocks[i].version->funcs->prepare_suspend)
 			continue;
@@ -5090,7 +5118,7 @@ static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
 		return true;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		if (adev->ip_blocks[i].version->funcs->check_soft_reset)
 			adev->ip_blocks[i].status.hang =
@@ -5120,7 +5148,7 @@ static int amdgpu_device_ip_pre_soft_reset(struct amdgpu_device *adev)
 	int i, r = 0;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		if (adev->ip_blocks[i].status.hang &&
 		    adev->ip_blocks[i].version->funcs->pre_soft_reset) {
@@ -5150,7 +5178,7 @@ static bool amdgpu_device_ip_need_full_reset(struct amdgpu_device *adev)
 		return true;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		if ((adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) ||
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) ||
@@ -5182,7 +5210,7 @@ static int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev)
 	int i, r = 0;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		if (adev->ip_blocks[i].status.hang &&
 		    adev->ip_blocks[i].version->funcs->soft_reset) {
@@ -5211,7 +5239,7 @@ static int amdgpu_device_ip_post_soft_reset(struct amdgpu_device *adev)
 	int i, r = 0;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
 		if (adev->ip_blocks[i].status.hang &&
 		    adev->ip_blocks[i].version->funcs->post_soft_reset)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f908355df07c..33030a0bfef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -515,7 +515,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 
 	for (i = 0; i < adev->num_ip_blocks; i++)
 		if (adev->ip_blocks[i].version->type == type &&
-		    adev->ip_blocks[i].status.valid)
+		    amdgpu_device_ip_valid(adev, i))
 			break;
 
 	if (i == adev->num_ip_blocks)
@@ -636,7 +636,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
 		ip_block = amdgpu_device_ip_get_ip_block(adev, type);
 
-		if (!ip_block || !ip_block->status.valid)
+		if (!ip_block || !amdgpu_ip_block_valid(ip_block))
 			return -EINVAL;
 
 		if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a441dffca45b..26a0d9050dca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3897,7 +3897,8 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
 	int ret;
 
 	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP);
-	if (!ip_block || !ip_block->status.late_initialized) {
+	if (!ip_block ||
+	    amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_LATE) {
 		dev_info(adev->dev, "PSP block is not ready yet\n.");
 		return -EBUSY;
 	}
@@ -3929,7 +3930,8 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	struct amdgpu_ip_block *ip_block;
 
 	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP);
-	if (!ip_block || !ip_block->status.late_initialized) {
+	if (!ip_block ||
+	    amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_LATE) {
 		dev_err(adev->dev, "PSP block is not ready yet.");
 		return -EBUSY;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce..eb72dac61c83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -31,9 +31,9 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 	int i;
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!adev->ip_blocks[i].status.valid)
+		if (!amdgpu_device_ip_valid(adev, i))
 			continue;
-		if (!adev->ip_blocks[i].status.hw)
+		if (amdgpu_device_ip_state(adev, i) <= AMDGPU_IP_STATE_HW)
 			continue;
 		/* displays are handled in phase1 */
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE)
@@ -41,7 +41,7 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 
 		/* XXX handle errors */
 		amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
-		adev->ip_blocks[i].status.hw = false;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
 	}
 
 	/* VCN FW shared region is in frambuffer, there are some flags
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 2594467bdd87..c9479a92a9df 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -204,7 +204,7 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 				return r;
 			}
 		}
-		adev->ip_blocks[i].status.late_initialized = true;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_LATE);
 	}
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index 70569ea906bc..75dc5cb1e1ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -205,7 +205,7 @@ static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
 				return r;
 			}
 		}
-		adev->ip_blocks[i].status.late_initialized = true;
+		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_LATE);
 	}
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8ca793c222ff..c75402d606c3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -230,7 +230,7 @@ static bool is_vcn_enabled(struct amdgpu_device *adev)
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if ((adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_VCN ||
 			adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_JPEG) &&
-			!adev->ip_blocks[i].status.valid)
+			!amdgpu_device_ip_valid(adev, i))
 			return false;
 	}
 
-- 
2.43.5

