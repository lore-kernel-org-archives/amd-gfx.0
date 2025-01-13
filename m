Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA69C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9C010E35F;
	Mon, 13 Jan 2025 01:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YbruA+/x";
	dkim-atps=neutral
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 746D710E332
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736732550; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=h6IHH+CZCpzDvygdPt7+XcaqDxP5CGTBgvVbUqyQ6a4=;
 b=YbruA+/xsTrTvYJSGwiEuuqQa/3+YVn3EJsEQ8SOzIeMI9PKG2n8MJYR3o1TgI8qkEATLYGCg3rJGka4J2DoqntpN4JmyHR5yCwsIxaJSqCXuWu6y48CtQYPjCli7WyrAQNK/cEBmMSJJScpsqXn4A9RxpBzB9WZ0C3oMI8sF4A=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNS0NGR_1736732549 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:42:30 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 12/15] drm/amdgpu: introduce IP block iterators to reduce
 duplicated code
Date: Mon, 13 Jan 2025 09:42:17 +0800
Message-ID: <dacc1584dec2df32b1dc3245d8309ea83dbe4d33.1736732062.git.gerry@linux.alibaba.com>
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

Introduce following IP block iterators to reduce duplicated code:
 - amdgpu_for_each_ip_block
 - amdgpu_for_each_ip_block_reverse
 - amdgpu_for_each_ip_block_valid
 - amdgpu_for_each_ip_block_valid_reverse

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  30 +-
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 479 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  14 +-
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  50 +-
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  51 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  10 +-
 11 files changed, 337 insertions(+), 378 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index b2bad8837b64..9fcce99544d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -73,19 +73,18 @@ aldebaran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 
 static int aldebaran_mode2_suspend_ip(struct amdgpu_device *adev)
 {
-	int r, i;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
-	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!(adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_GFX ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_SDMA))
+	amdgpu_for_each_ip_block_reverse(adev, ip_block) {
+		if (!(ip_block->version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 
-		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
+		r = amdgpu_ip_block_suspend(ip_block);
 		if (r)
 			return r;
 	}
@@ -201,7 +200,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 {
 	struct amdgpu_firmware_info *ucode_list[AMDGPU_UCODE_ID_MAXIMUM];
 	struct amdgpu_firmware_info *ucode;
-	struct amdgpu_ip_block *cmn_block;
+	struct amdgpu_ip_block *cmn_block, *ip_block;
 	int ucode_count = 0;
 	int i, r;
 
@@ -269,39 +268,32 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 		return r;
 	}
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!(adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_GFX ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_SDMA))
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (!(ip_block->version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 
-		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+		r = amdgpu_ip_block_resume(ip_block);
 		if (r)
 			return r;
 	}
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!(adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_GFX ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_SDMA ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_COMMON))
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (!(ip_block->version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_SDMA ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_COMMON))
 			continue;
 
-		if (adev->ip_blocks[i].version->funcs->late_init) {
-			r = adev->ip_blocks[i].version->funcs->late_init(
-				&adev->ip_blocks[i]);
+		if (ip_block->version->funcs->late_init) {
+			r = ip_block->version->funcs->late_init(ip_block);
 			if (r) {
 				dev_err(adev->dev,
 					"late_init of IP block <%s> failed %d after reset\n",
-					adev->ip_blocks[i].version->funcs->name,
-					r);
+					ip_block->version->funcs->name, r);
 				return r;
 			}
 		}
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_LATE);
+		amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_LATE);
 	}
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f3275a281280..8707ca566ea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -450,11 +450,9 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
 int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 			       const struct amdgpu_ip_block_version *ip_block_version);
 
-void amdgpu_device_ip_set_state(struct amdgpu_device *adev, int index,
-				enum amdgpu_device_ip_state state);
-enum amdgpu_device_ip_state amdgpu_device_ip_state(struct amdgpu_device *adev,
-						   int index);
-bool amdgpu_device_ip_valid(struct amdgpu_device *adev, int index);
+enum amdgpu_device_ip_state
+amdgpu_device_ip_state(struct amdgpu_device *adev, int index);
+
 void amdgpu_ip_block_set_state(struct amdgpu_ip_block *ip_block,
 			       enum amdgpu_device_ip_state state);
 
@@ -491,6 +489,28 @@ static inline bool amdgpu_ip_block_test_and_clear_marker(struct amdgpu_ip_block
 	return set;
 }
 
+#define amdgpu_for_each_ip_block(adev, entry)				\
+	for (int __i = 0;						\
+	     __i < (adev)->num_ip_blocks && ((entry) = &(adev)->ip_blocks[__i]); \
+	     __i++)
+
+#define amdgpu_for_each_ip_block_reverse(adev, entry)			\
+	for (int __i = (adev)->num_ip_blocks;				\
+	     __i >= 0 && ((entry) = &(adev)->ip_blocks[__i]);		\
+	     __i--)
+
+#define amdgpu_for_each_ip_block_valid(adev, entry)			\
+	for (int __i = (adev)->num_ip_blocks;				\
+	     __i >= 0 && ((entry) = &(adev)->ip_blocks[__i]);		\
+	     __i--)							\
+		if (amdgpu_ip_block_valid((entry)))
+
+#define amdgpu_for_each_ip_block_valid_reverse(adev, entry)		\
+	for (int __i = (adev)->num_ip_blocks;				\
+	     __i >= 0 && (entry = &(adev)->ip_blocks[__i]);		\
+	     __i--)							\
+		if (amdgpu_ip_block_valid((entry)))
+
 /*
  * BIOS.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 824f9da5b6ce..d3a30b9a26a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -282,8 +282,7 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 
 	/* dump the ip state for each ip */
 	drm_printf(&p, "IP Dump\n");
-	for (int i = 0; i < coredump->adev->num_ip_blocks; i++) {
-		ip_block = &coredump->adev->ip_blocks[i];
+	amdgpu_for_each_ip_block(coredump->adev, ip_block) {
 		if (ip_block->version->funcs->print_ip_state) {
 			drm_printf(&p, "IP: %s\n", ip_block->version->funcs->name);
 			ip_block->version->funcs->print_ip_state(ip_block, &p);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fcfbdcfd1fa3..af356226fbca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2161,20 +2161,18 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 					   enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = dev;
-	int i, r = 0;
+	struct amdgpu_ip_block *ip_block;
+	int r = 0;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i))
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (ip_block->version->type != block_type)
 			continue;
-		if (adev->ip_blocks[i].version->type != block_type)
+		if (!ip_block->version->funcs->set_clockgating_state)
 			continue;
-		if (!adev->ip_blocks[i].version->funcs->set_clockgating_state)
-			continue;
-		r = adev->ip_blocks[i].version->funcs->set_clockgating_state(
-			&adev->ip_blocks[i], state);
+		r = ip_block->version->funcs->set_clockgating_state(ip_block, state);
 		if (r)
 			DRM_ERROR("set_clockgating_state of IP block <%s> failed %d\n",
-				  adev->ip_blocks[i].version->funcs->name, r);
+				  ip_block->version->funcs->name, r);
 	}
 	return r;
 }
@@ -2195,20 +2193,18 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = dev;
-	int i, r = 0;
+	int r = 0;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i))
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (ip_block->version->type != block_type)
 			continue;
-		if (adev->ip_blocks[i].version->type != block_type)
+		if (!ip_block->version->funcs->set_powergating_state)
 			continue;
-		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
-			continue;
-		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
-			&adev->ip_blocks[i], state);
+		r = ip_block->version->funcs->set_powergating_state(ip_block, state);
 		if (r)
 			DRM_ERROR("set_powergating_state of IP block <%s> failed %d\n",
-				  adev->ip_blocks[i].version->funcs->name, r);
+				  ip_block->version->funcs->name, r);
 	}
 	return r;
 }
@@ -2227,13 +2223,11 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags)
 {
-	int i;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
-		if (adev->ip_blocks[i].version->funcs->get_clockgating_state)
-			adev->ip_blocks[i].version->funcs->get_clockgating_state((void *)adev, flags);
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (ip_block->version->funcs->get_clockgating_state)
+			ip_block->version->funcs->get_clockgating_state((void *)adev, flags);
 	}
 }
 
@@ -2249,15 +2243,13 @@ void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type)
 {
-	int i, r;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
-		if (adev->ip_blocks[i].version->type == block_type) {
-			if (adev->ip_blocks[i].version->funcs->wait_for_idle) {
-				r = adev->ip_blocks[i].version->funcs->wait_for_idle(
-								&adev->ip_blocks[i]);
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (ip_block->version->type == block_type) {
+			if (ip_block->version->funcs->wait_for_idle) {
+				r = ip_block->version->funcs->wait_for_idle(ip_block);
 				if (r)
 					return r;
 			}
@@ -2280,11 +2272,11 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			       enum amd_ip_block_type block_type)
 {
-	int i;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (adev->ip_blocks[i].version->type == block_type)
-			return amdgpu_device_ip_valid(adev, i);
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (ip_block->version->type == block_type)
+			return amdgpu_ip_block_valid(ip_block);
 	}
 	return false;
 
@@ -2303,11 +2295,11 @@ struct amdgpu_ip_block *
 amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
 			      enum amd_ip_block_type type)
 {
-	int i;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++)
-		if (adev->ip_blocks[i].version->type == type)
-			return &adev->ip_blocks[i];
+	amdgpu_for_each_ip_block(adev, ip_block)
+		if (ip_block->version->type == type)
+			return ip_block;
 
 	return NULL;
 }
@@ -2375,23 +2367,12 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 	return 0;
 }
 
-void amdgpu_device_ip_set_state(struct amdgpu_device *adev, int index,
-			       enum amdgpu_device_ip_state state)
-{
-	amdgpu_ip_block_set_state(&adev->ip_blocks[index], state);
-}
-
 enum amdgpu_device_ip_state amdgpu_device_ip_state(struct amdgpu_device *adev,
 						 int index)
 {
 	return amdgpu_ip_block_state(&adev->ip_blocks[index]);
 }
 
-bool amdgpu_device_ip_valid(struct amdgpu_device *adev, int index)
-{
-	return amdgpu_ip_block_valid(&adev->ip_blocks[index]);
-}
-
 void amdgpu_ip_block_set_state(struct amdgpu_ip_block *ip_block,
 			       enum amdgpu_device_ip_state state)
 {
@@ -2693,25 +2674,24 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
 		if ((amdgpu_ip_block_mask & (1 << i)) == 0) {
 			DRM_WARN("disabled ip block: %d <%s>\n",
-				  i, adev->ip_blocks[i].version->funcs->name);
-			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_INVALID);
+				  i, ip_block->version->funcs->name);
+			amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_INVALID);
 		} else if (ip_block->version->funcs->early_init) {
 			r = ip_block->version->funcs->early_init(ip_block);
 			if (r == -ENOENT) {
-				amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_INVALID);
+				amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_INVALID);
 			} else if (r) {
 				DRM_ERROR("early_init of IP block <%s> failed %d\n",
-					  adev->ip_blocks[i].version->funcs->name, r);
+					  ip_block->version->funcs->name, r);
 				total = false;
-				amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_INVALID);
 			} else {
-				amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_EARLY);
+				amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_EARLY);
 			}
 		} else {
-			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_EARLY);
+			amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_EARLY);
 		}
 		/* get the vbios after the asic_funcs are set up */
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
+		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_COMMON) {
 			r = amdgpu_device_parse_gpu_info_fw(adev);
 			if (r)
 				return r;
@@ -2750,26 +2730,26 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
 static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
 {
-	int i, r;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_SW)
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_SW)
 			continue;
-		if (amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
+		if (amdgpu_ip_block_state(ip_block) >= AMDGPU_IP_STATE_HW)
 			continue;
-		if (!amdgpu_ip_member_of_hwini(
-			    adev, adev->ip_blocks[i].version->type))
+		if (!amdgpu_ip_member_of_hwini(adev, ip_block->version->type))
 			continue;
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
-		    (amdgpu_sriov_vf(adev) && (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)) ||
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
-			r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
+		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+		    (amdgpu_sriov_vf(adev) && (ip_block->version->type == AMD_IP_BLOCK_TYPE_PSP)) ||
+		    ip_block->version->type == AMD_IP_BLOCK_TYPE_IH) {
+			r = ip_block->version->funcs->hw_init(ip_block);
 			if (r) {
 				DRM_ERROR("hw_init of IP block <%s> failed %d\n",
-					  adev->ip_blocks[i].version->funcs->name, r);
+					  ip_block->version->funcs->name, r);
 				return r;
 			}
-			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
+			amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_HW);
 		}
 	}
 
@@ -2778,23 +2758,23 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
 
 static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
 {
-	int i, r;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_SW)
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_SW)
 			continue;
-		if (amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
+		if (amdgpu_ip_block_state(ip_block) >= AMDGPU_IP_STATE_HW)
 			continue;
-		if (!amdgpu_ip_member_of_hwini(
-			    adev, adev->ip_blocks[i].version->type))
+		if (!amdgpu_ip_member_of_hwini(adev, ip_block->version->type))
 			continue;
-		r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
+		r = ip_block->version->funcs->hw_init(ip_block);
 		if (r) {
 			DRM_ERROR("hw_init of IP block <%s> failed %d\n",
-				  adev->ip_blocks[i].version->funcs->name, r);
+				  ip_block->version->funcs->name, r);
 			return r;
 		}
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
+		amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_HW);
 	}
 
 	return 0;
@@ -2803,37 +2783,37 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
 static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 {
 	int r = 0;
-	int i;
 	uint32_t smu_version;
+	struct amdgpu_ip_block *ip_block;
 
 	if (adev->asic_type >= CHIP_VEGA10) {
-		for (i = 0; i < adev->num_ip_blocks; i++) {
-			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
+		amdgpu_for_each_ip_block(adev, ip_block) {
+			if (ip_block->version->type != AMD_IP_BLOCK_TYPE_PSP)
 				continue;
 
 			if (!amdgpu_ip_member_of_hwini(adev,
 						       AMD_IP_BLOCK_TYPE_PSP))
 				break;
 
-			if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_SW)
+			if (amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_SW)
 				continue;
 
 			/* no need to do the fw loading again if already done*/
-			if (amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
+			if (amdgpu_ip_block_state(ip_block) >= AMDGPU_IP_STATE_HW)
 				break;
 
 			if (amdgpu_in_reset(adev) || adev->in_suspend) {
-				r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+				r = amdgpu_ip_block_resume(ip_block);
 				if (r)
 					return r;
 			} else {
-				r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
+				r = ip_block->version->funcs->hw_init(ip_block);
 				if (r) {
 					DRM_ERROR("hw_init of IP block <%s> failed %d\n",
-							  adev->ip_blocks[i].version->funcs->name, r);
+						  ip_block->version->funcs->name, r);
 					return r;
 				}
-				amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
+				amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_HW);
 			}
 			break;
 		}
@@ -2917,38 +2897,37 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 {
 	bool init_badpage;
-	int i, r;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
 	r = amdgpu_ras_init(adev);
 	if (r)
 		return r;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
-		if (adev->ip_blocks[i].version->funcs->sw_init) {
-			r = adev->ip_blocks[i].version->funcs->sw_init(&adev->ip_blocks[i]);
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (ip_block->version->funcs->sw_init) {
+			r = ip_block->version->funcs->sw_init(ip_block);
 			if (r) {
 				DRM_ERROR("sw_init of IP block <%s> failed %d\n",
-					  adev->ip_blocks[i].version->funcs->name, r);
+					  ip_block->version->funcs->name, r);
 				goto init_failed;
 			}
 		}
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
+		amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_SW);
 
-		if (!amdgpu_ip_member_of_hwini(
-			    adev, adev->ip_blocks[i].version->type))
+		if (!amdgpu_ip_member_of_hwini(adev, ip_block->version->type))
 			continue;
 
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
+		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_COMMON) {
 			/* need to do common hw init early so everything is set up for gmc */
-			r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
+			r = ip_block->version->funcs->hw_init(ip_block);
 			if (r) {
-				DRM_ERROR("hw_init %d failed %d\n", i, r);
+				DRM_ERROR("hw_init %s failed %d\n",
+					  ip_block->version->funcs->name, r);
 				goto init_failed;
 			}
-			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
-		} else if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
+			amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_HW);
+		} else if (ip_block->version->type == AMD_IP_BLOCK_TYPE_GMC) {
 			/* need to do gmc hw init early so we can allocate gpu mem */
 			/* Try to reserve bad pages early */
 			if (amdgpu_sriov_vf(adev))
@@ -2959,9 +2938,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 				DRM_ERROR("amdgpu_mem_scratch_init failed %d\n", r);
 				goto init_failed;
 			}
-			r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
+			r = ip_block->version->funcs->hw_init(ip_block);
 			if (r) {
-				DRM_ERROR("hw_init %d failed %d\n", i, r);
+				DRM_ERROR("hw_init %s failed %d\n",
+					  ip_block->version->funcs->name, r);
 				goto init_failed;
 			}
 			r = amdgpu_device_wb_init(adev);
@@ -2969,7 +2949,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 				DRM_ERROR("amdgpu_device_wb_init failed %d\n", r);
 				goto init_failed;
 			}
-			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
+			amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_HW);
 
 			/* right after GMC hw init, we create CSA */
 			if (adev->gfx.mcbp) {
@@ -3267,20 +3247,21 @@ static int amdgpu_device_enable_mgpu_fan_boost(void)
 static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_gpu_instance *gpu_instance;
+	struct amdgpu_ip_block *ip_block;
 	int i = 0, r;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_HW)
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_HW)
 			continue;
-		if (adev->ip_blocks[i].version->funcs->late_init) {
-			r = adev->ip_blocks[i].version->funcs->late_init(&adev->ip_blocks[i]);
+		if (ip_block->version->funcs->late_init) {
+			r = ip_block->version->funcs->late_init(ip_block);
 			if (r) {
 				DRM_ERROR("late_init of IP block <%s> failed %d\n",
-					  adev->ip_blocks[i].version->funcs->name, r);
+					  ip_block->version->funcs->name, r);
 				return r;
 			}
 		}
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_LATE);
+		amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_LATE);
 	}
 
 	r = amdgpu_ras_late_init(adev);
@@ -3372,16 +3353,16 @@ static void amdgpu_ip_block_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
 {
-	int i;
+	struct amdgpu_ip_block *ip_block;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(9, 0, 0))
 		return;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_HW)
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_HW)
 			continue;
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
-			amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
+		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_SMC) {
+			amdgpu_ip_block_hw_fini(ip_block);
 			break;
 		}
 	}
@@ -3389,19 +3370,20 @@ static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
 
 static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 {
-	int i, r;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].version->funcs->early_fini)
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (!ip_block->version->funcs->early_fini)
 			continue;
 
-		r = adev->ip_blocks[i].version->funcs->early_fini(&adev->ip_blocks[i]);
+		r = ip_block->version->funcs->early_fini(ip_block);
 		if (r) {
 			DRM_DEBUG("early_fini of IP block <%s> failed %d\n",
-				  adev->ip_blocks[i].version->funcs->name, r);
+				  ip_block->version->funcs->name, r);
 		}
 
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
+		amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_HW);
 	}
 
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
@@ -3412,11 +3394,11 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	/* Workaround for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
 
-	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_HW)
+	amdgpu_for_each_ip_block_reverse(adev, ip_block) {
+		if (amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_HW)
 			continue;
 
-		amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
+		amdgpu_ip_block_hw_fini(ip_block);
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -3440,7 +3422,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
-	int i, r;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
 		amdgpu_virt_release_ras_err_handler_data(adev);
@@ -3450,11 +3433,11 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_device_fini_sw(adev);
 
-	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_SW)
+	amdgpu_for_each_ip_block_reverse(adev, ip_block) {
+		if (amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_SW)
 			continue;
 
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
+		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_GMC) {
 			amdgpu_ucode_free_bo(adev);
 			amdgpu_free_static_csa(&adev->virt.csa_obj);
 			amdgpu_device_wb_fini(adev);
@@ -3462,25 +3445,23 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 			amdgpu_ib_pool_fini(adev);
 			amdgpu_seq64_fini(adev);
 		}
-		if (adev->ip_blocks[i].version->funcs->sw_fini) {
-			r = adev->ip_blocks[i].version->funcs->sw_fini(&adev->ip_blocks[i]);
+		if (ip_block->version->funcs->sw_fini) {
+			r = ip_block->version->funcs->sw_fini(ip_block);
 			/* XXX handle errors */
 			if (r) {
 				DRM_DEBUG("sw_fini of IP block <%s> failed %d\n",
-					  adev->ip_blocks[i].version->funcs->name, r);
+					  ip_block->version->funcs->name, r);
 			}
 		}
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_EARLY);
+		amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_EARLY);
 	}
 
 	amdgpu_ras_fini(adev);
 
-	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
-		if (adev->ip_blocks[i].version->funcs->late_fini)
-			adev->ip_blocks[i].version->funcs->late_fini(&adev->ip_blocks[i]);
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_INVALID);
+	amdgpu_for_each_ip_block_valid_reverse(adev, ip_block) {
+		if (ip_block->version->funcs->late_fini)
+			ip_block->version->funcs->late_fini(ip_block);
+		amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_INVALID);
 	}
 
 	return 0;
@@ -3527,7 +3508,8 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
  */
 static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
-	int i, r;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
@@ -3540,34 +3522,29 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
 		dev_warn(adev->dev, "Failed to disallow df cstate");
 
-	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
-		if (amdgpu_device_ip_state(adev, i) < AMDGPU_IP_STATE_LATE)
+	amdgpu_for_each_ip_block_valid_reverse(adev, ip_block) {
+		if (amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_LATE)
 			continue;
 
-		if (adev->ip_blocks[i].version->funcs->early_fini) {
-			r = adev->ip_blocks[i].version->funcs->early_fini(&adev->ip_blocks[i]);
+		if (ip_block->version->funcs->early_fini) {
+			r = ip_block->version->funcs->early_fini(ip_block);
 			if (r) {
 				DRM_ERROR(" of IP block <%s> failed %d\n",
-					  adev->ip_blocks[i].version->funcs->name, r);
+					  ip_block->version->funcs->name, r);
 				return r;
 			}
 		}
 
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
+		amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_HW);
 	}
 
-	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
-
+	amdgpu_for_each_ip_block_valid_reverse(adev, ip_block) {
 		/* displays are handled separately */
-		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_DCE)
+		if (ip_block->version->type != AMD_IP_BLOCK_TYPE_DCE)
 			continue;
 
 		/* XXX handle errors */
-		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
+		r = amdgpu_ip_block_suspend(ip_block);
 		if (r)
 			return r;
 	}
@@ -3588,27 +3565,25 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 {
-	int i, r;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
 	if (adev->in_s0ix)
 		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D3Entry);
 
-	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
+	amdgpu_for_each_ip_block_valid_reverse(adev, ip_block) {
 		/* displays are handled in phase1 */
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE)
+		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_DCE)
 			continue;
 		/* PSP lost connection when err_event_athub occurs */
 		if (amdgpu_ras_intr_triggered() &&
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP) {
-			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
+		    ip_block->version->type == AMD_IP_BLOCK_TYPE_PSP) {
+			amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_SW);
 			continue;
 		}
 
 		/* skip unnecessary suspend if we do not initialize them yet */
-		if (!amdgpu_ip_member_of_hwini(
-			    adev, adev->ip_blocks[i].version->type))
+		if (!amdgpu_ip_member_of_hwini(adev, ip_block->version->type))
 			continue;
 
 		/* skip suspend of gfx/mes and psp for S0ix
@@ -3617,17 +3592,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		 * so no need to suspend it.
 		 */
 		if (adev->in_s0ix &&
-		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP ||
-		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
-		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_MES))
+		    (ip_block->version->type == AMD_IP_BLOCK_TYPE_PSP ||
+		     ip_block->version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		     ip_block->version->type == AMD_IP_BLOCK_TYPE_MES))
 			continue;
 
 		/* SDMA 5.x+ is part of GFX power domain so it's covered by GFXOFF */
 		if (adev->in_s0ix &&
 		    (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >=
 		     IP_VERSION(5, 0, 0)) &&
-		    (adev->ip_blocks[i].version->type ==
-		     AMD_IP_BLOCK_TYPE_SDMA))
+		    (ip_block->version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 
 		/* Once swPSP provides the IMU, RLC FW binaries to TOS during cold-boot.
@@ -3639,16 +3613,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		 */
 		if (amdgpu_in_reset(adev) &&
 		    (adev->flags & AMD_IS_APU) && adev->gfx.imu.funcs &&
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
+		    ip_block->version->type == AMD_IP_BLOCK_TYPE_PSP)
 			continue;
 
 		/* XXX handle errors */
-		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
+		r = amdgpu_ip_block_suspend(ip_block);
+		amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_SW);
 
 		/* handle putting the SMC in the appropriate state */
 		if (!amdgpu_sriov_vf(adev)) {
-			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
+			if (ip_block->version->type == AMD_IP_BLOCK_TYPE_SMC) {
 				r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
 				if (r) {
 					DRM_ERROR("SMC failed to set mp1 state %d, %d\n",
@@ -3697,7 +3671,8 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 
 static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 {
-	int i, r;
+	int r;
+	struct amdgpu_ip_block *block;
 
 	static enum amd_ip_block_type ip_order[] = {
 		AMD_IP_BLOCK_TYPE_COMMON,
@@ -3706,26 +3681,24 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_IH,
 	};
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
+	amdgpu_for_each_ip_block(adev, block) {
 		int j;
-		struct amdgpu_ip_block *block;
 
-		block = &adev->ip_blocks[i];
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
+		amdgpu_ip_block_set_state(block, AMDGPU_IP_STATE_SW);
 
 		for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
 
 			if (block->version->type != ip_order[j] ||
-			    !amdgpu_device_ip_valid(adev, i))
+			    !amdgpu_ip_block_valid(block))
 				continue;
 
-			r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
+			r = block->version->funcs->hw_init(block);
 			if (r) {
 				dev_err(adev->dev, "RE-INIT-early: %s failed\n",
 					 block->version->funcs->name);
 				return r;
 			}
-			amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_HW);
+			amdgpu_ip_block_set_state(block, AMDGPU_IP_STATE_HW);
 		}
 	}
 
@@ -3789,18 +3762,18 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
 {
-	int i, r;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i) ||
-		    amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (amdgpu_ip_block_state(ip_block) >= AMDGPU_IP_STATE_HW)
 			continue;
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
-		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP && amdgpu_sriov_vf(adev))) {
+		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+		    ip_block->version->type == AMD_IP_BLOCK_TYPE_GMC ||
+		    ip_block->version->type == AMD_IP_BLOCK_TYPE_IH ||
+		    (ip_block->version->type == AMD_IP_BLOCK_TYPE_PSP && amdgpu_sriov_vf(adev))) {
 
-			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+			r = amdgpu_ip_block_resume(ip_block);
 			if (r)
 				return r;
 		}
@@ -3824,19 +3797,19 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 {
-	int i, r;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i) ||
-		    amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (amdgpu_ip_block_state(ip_block) >= AMDGPU_IP_STATE_HW)
 			continue;
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE ||
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
+		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+		    ip_block->version->type == AMD_IP_BLOCK_TYPE_GMC ||
+		    ip_block->version->type == AMD_IP_BLOCK_TYPE_IH ||
+		    ip_block->version->type == AMD_IP_BLOCK_TYPE_DCE ||
+		    ip_block->version->type == AMD_IP_BLOCK_TYPE_PSP)
 			continue;
-		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+		r = amdgpu_ip_block_resume(ip_block);
 		if (r)
 			return r;
 	}
@@ -3859,14 +3832,14 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
 {
-	int i, r;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i) ||
-		    amdgpu_device_ip_state(adev, i) >= AMDGPU_IP_STATE_HW)
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (amdgpu_ip_block_state(ip_block) >= AMDGPU_IP_STATE_HW)
 			continue;
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
-			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_DCE) {
+			r = amdgpu_ip_block_resume(ip_block);
 			if (r)
 				return r;
 		}
@@ -4901,7 +4874,8 @@ static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mo
 int amdgpu_device_prepare(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int i, r;
+	struct amdgpu_ip_block *ip_block;
+	int r;
 
 	amdgpu_choose_low_power_state(adev);
 
@@ -4915,12 +4889,10 @@ int amdgpu_device_prepare(struct drm_device *dev)
 
 	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i))
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (!ip_block->version->funcs->prepare_suspend)
 			continue;
-		if (!adev->ip_blocks[i].version->funcs->prepare_suspend)
-			continue;
-		r = adev->ip_blocks[i].version->funcs->prepare_suspend(&adev->ip_blocks[i]);
+		r = ip_block->version->funcs->prepare_suspend(ip_block);
 		if (r)
 			goto unprepare;
 	}
@@ -5108,8 +5080,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
  */
 static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
 {
-	int i;
 	bool asic_hang = false;
+	struct amdgpu_ip_block *block;
 
 	if (amdgpu_sriov_vf(adev))
 		return true;
@@ -5117,15 +5089,11 @@ static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
 	if (amdgpu_asic_need_full_reset(adev))
 		return true;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
-		if (adev->ip_blocks[i].version->funcs->check_soft_reset)
-			adev->ip_blocks[i].status.hang =
-				adev->ip_blocks[i].version->funcs->check_soft_reset(
-					&adev->ip_blocks[i]);
-		if (adev->ip_blocks[i].status.hang) {
-			dev_info(adev->dev, "IP block:%s is hung!\n", adev->ip_blocks[i].version->funcs->name);
+	amdgpu_for_each_ip_block_valid(adev, block) {
+		if (block->version->funcs->check_soft_reset)
+			block->status.hang = block->version->funcs->check_soft_reset(block);
+		if (block->status.hang) {
+			dev_info(adev->dev, "IP block:%s is hung!\n", block->version->funcs->name);
 			asic_hang = true;
 		}
 	}
@@ -5145,14 +5113,13 @@ static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_pre_soft_reset(struct amdgpu_device *adev)
 {
-	int i, r = 0;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
-		if (adev->ip_blocks[i].status.hang &&
-		    adev->ip_blocks[i].version->funcs->pre_soft_reset) {
-			r = adev->ip_blocks[i].version->funcs->pre_soft_reset(&adev->ip_blocks[i]);
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (ip_block->status.hang &&
+		    ip_block->version->funcs->pre_soft_reset) {
+			r = ip_block->version->funcs->pre_soft_reset(ip_block);
 			if (r)
 				return r;
 		}
@@ -5172,20 +5139,18 @@ static int amdgpu_device_ip_pre_soft_reset(struct amdgpu_device *adev)
  */
 static bool amdgpu_device_ip_need_full_reset(struct amdgpu_device *adev)
 {
-	int i;
+	struct amdgpu_ip_block *ip_block;
 
 	if (amdgpu_asic_need_full_reset(adev))
 		return true;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
-		if ((adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) ||
-		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) ||
-		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_ACP) ||
-		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) ||
-		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP) {
-			if (adev->ip_blocks[i].status.hang) {
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if ((ip_block->version->type == AMD_IP_BLOCK_TYPE_GMC) ||
+		    (ip_block->version->type == AMD_IP_BLOCK_TYPE_SMC) ||
+		    (ip_block->version->type == AMD_IP_BLOCK_TYPE_ACP) ||
+		    (ip_block->version->type == AMD_IP_BLOCK_TYPE_DCE) ||
+		     ip_block->version->type == AMD_IP_BLOCK_TYPE_PSP) {
+			if (ip_block->status.hang) {
 				dev_info(adev->dev, "Some block need full reset!\n");
 				return true;
 			}
@@ -5207,14 +5172,13 @@ static bool amdgpu_device_ip_need_full_reset(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev)
 {
-	int i, r = 0;
+	int r = 0;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
-		if (adev->ip_blocks[i].status.hang &&
-		    adev->ip_blocks[i].version->funcs->soft_reset) {
-			r = adev->ip_blocks[i].version->funcs->soft_reset(&adev->ip_blocks[i]);
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (ip_block->status.hang &&
+		    ip_block->version->funcs->soft_reset) {
+			r = ip_block->version->funcs->soft_reset(ip_block);
 			if (r)
 				return r;
 		}
@@ -5236,14 +5200,13 @@ static int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_post_soft_reset(struct amdgpu_device *adev)
 {
-	int i, r = 0;
+	int r = 0;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
-		if (adev->ip_blocks[i].status.hang &&
-		    adev->ip_blocks[i].version->funcs->post_soft_reset)
-			r = adev->ip_blocks[i].version->funcs->post_soft_reset(&adev->ip_blocks[i]);
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (ip_block->status.hang &&
+		    ip_block->version->funcs->post_soft_reset)
+			r = ip_block->version->funcs->post_soft_reset(ip_block);
 		if (r)
 			return r;
 	}
@@ -5473,6 +5436,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	int i, r = 0;
 	struct amdgpu_job *job = NULL;
 	struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
+	struct amdgpu_ip_block *ip_block;
 	bool need_full_reset =
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 
@@ -5532,10 +5496,9 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
 			dev_info(tmp_adev->dev, "Dumping IP State\n");
 			/* Trigger ip dump before we reset the asic */
-			for (i = 0; i < tmp_adev->num_ip_blocks; i++)
-				if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
-					tmp_adev->ip_blocks[i].version->funcs
-						->dump_ip_state((void *)&tmp_adev->ip_blocks[i]);
+			amdgpu_for_each_ip_block(tmp_adev, ip_block)
+				if (ip_block->version->funcs->dump_ip_state)
+					ip_block->version->funcs->dump_ip_state((void *)ip_block);
 			dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 100f04475943..07340fa4a30e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -36,13 +36,13 @@
 static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
 				    struct amdgpu_job *job)
 {
-	int i;
+	struct amdgpu_ip_block *block;
 
 	dev_info(adev->dev, "Dumping IP State\n");
-	for (i = 0; i < adev->num_ip_blocks; i++)
-		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
-			adev->ip_blocks[i].version->funcs
-				->dump_ip_state((void *)&adev->ip_blocks[i]);
+	amdgpu_for_each_ip_block(adev, block) {
+		if (block->version->funcs->dump_ip_state)
+			block->version->funcs->dump_ip_state((void *)block);
+	}
 	dev_info(adev->dev, "Dumping IP State Completed\n");
 
 	amdgpu_coredump(adev, true, false, job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 33030a0bfef2..5582b1433621 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -400,6 +400,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	enum amd_ip_block_type type;
 	unsigned int num_rings = 0;
 	unsigned int i, j;
+	bool found = false;
+	struct amdgpu_ip_block *ip_block;
 
 	if (info->query_hw_ip.ip_instance >= AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
 		return -EINVAL;
@@ -513,19 +515,21 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
-	for (i = 0; i < adev->num_ip_blocks; i++)
-		if (adev->ip_blocks[i].version->type == type &&
-		    amdgpu_device_ip_valid(adev, i))
+	amdgpu_for_each_ip_block_valid(adev, ip_block) {
+		if (ip_block->version->type == type) {
+			found = true;
 			break;
+		}
+	}
 
-	if (i == adev->num_ip_blocks)
+	if (!found)
 		return 0;
 
 	num_rings = min(amdgpu_ctx_num_entities[info->query_hw_ip.type],
 			num_rings);
 
-	result->hw_ip_version_major = adev->ip_blocks[i].version->major;
-	result->hw_ip_version_minor = adev->ip_blocks[i].version->minor;
+	result->hw_ip_version_major = ip_block->version->major;
+	result->hw_ip_version_minor = ip_block->version->minor;
 
 	if (adev->asic_type >= CHIP_VEGA10) {
 		switch (type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 26a0d9050dca..3d7b715cd369 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3897,8 +3897,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
 	int ret;
 
 	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP);
-	if (!ip_block ||
-	    amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_LATE) {
+	if (!ip_block || amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_LATE) {
 		dev_info(adev->dev, "PSP block is not ready yet\n.");
 		return -EBUSY;
 	}
@@ -3930,8 +3929,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	struct amdgpu_ip_block *ip_block;
 
 	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP);
-	if (!ip_block ||
-	    amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_LATE) {
+	if (!ip_block || amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_LATE) {
 		dev_err(adev->dev, "PSP block is not ready yet.");
 		return -EBUSY;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index eb72dac61c83..fafec228f57e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -28,20 +28,18 @@
 
 static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 {
-	int i;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!amdgpu_device_ip_valid(adev, i))
-			continue;
-		if (amdgpu_device_ip_state(adev, i) <= AMDGPU_IP_STATE_HW)
+	amdgpu_for_each_ip_block_valid_reverse(adev, ip_block) {
+		if (amdgpu_ip_block_state(ip_block) < AMDGPU_IP_STATE_HW)
 			continue;
 		/* displays are handled in phase1 */
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE)
+		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_DCE)
 			continue;
 
 		/* XXX handle errors */
-		amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_SW);
+		amdgpu_ip_block_suspend(ip_block);
+		amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_SW);
 	}
 
 	/* VCN FW shared region is in frambuffer, there are some flags
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index c9479a92a9df..01f2f9bd8dd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -69,19 +69,18 @@ sienna_cichlid_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 
 static int sienna_cichlid_mode2_suspend_ip(struct amdgpu_device *adev)
 {
-	int r, i;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
-	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!(adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_GFX ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_SDMA))
+	amdgpu_for_each_ip_block_reverse(adev, ip_block) {
+		if (!(ip_block->version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 
-		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
+		r = amdgpu_ip_block_suspend(ip_block);
 		if (r)
 			return r;
 	}
@@ -148,8 +147,9 @@ sienna_cichlid_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 
 static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 {
-	int i, r;
+	int r;
 	struct psp_context *psp = &adev->psp;
+	struct amdgpu_ip_block *ip_block;
 
 	r = psp_rlc_autoload_start(psp);
 	if (r) {
@@ -167,44 +167,38 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 		return r;
 	}
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
-			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (ip_block->version->type == AMD_IP_BLOCK_TYPE_IH) {
+			r = amdgpu_ip_block_resume(ip_block);
 			if (r)
 				return r;
 		}
 	}
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!(adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_GFX ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_SDMA))
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (!(ip_block->version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+		r = amdgpu_ip_block_resume(ip_block);
 		if (r)
 			return r;
 	}
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!(adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_GFX ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_SDMA))
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (!(ip_block->version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 
-		if (adev->ip_blocks[i].version->funcs->late_init) {
-			r = adev->ip_blocks[i].version->funcs->late_init(
-				&adev->ip_blocks[i]);
+		if (ip_block->version->funcs->late_init) {
+			r = ip_block->version->funcs->late_init(ip_block);
 			if (r) {
 				dev_err(adev->dev,
 					"late_init of IP block <%s> failed %d after reset\n",
-					adev->ip_blocks[i].version->funcs->name,
-					r);
+					ip_block->version->funcs->name, r);
 				return r;
 			}
 		}
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_LATE);
+		amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_LATE);
 	}
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index 75dc5cb1e1ec..90b20f658c8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -66,21 +66,19 @@ smu_v13_0_10_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 
 static int smu_v13_0_10_mode2_suspend_ip(struct amdgpu_device *adev)
 {
-	int r, i;
+	int r;
+	struct amdgpu_ip_block *ip_block;
 
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
-	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
-		if (!(adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_GFX ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_SDMA ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_MES))
+	amdgpu_for_each_ip_block_reverse(adev, ip_block) {
+		if (!(ip_block->version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_SDMA ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_MES))
 			continue;
 
-		r = amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
+		r = amdgpu_ip_block_suspend(ip_block);
 		if (r)
 			return r;
 	}
@@ -144,6 +142,7 @@ static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *ucode;
 	struct amdgpu_firmware_info *ucode_list[2];
 	int ucode_count = 0;
+	struct amdgpu_ip_block *ip_block;
 
 	for (i = 0; i < adev->firmware.max_ucodes; i++) {
 		ucode = &adev->firmware.ucode[i];
@@ -172,40 +171,32 @@ static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
 
 	amdgpu_dpm_enable_gfx_features(adev);
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!(adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_GFX ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_MES ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_SDMA))
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (!(ip_block->version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_MES ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
-		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+		r = amdgpu_ip_block_resume(ip_block);
 		if (r)
 			return r;
 	}
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!(adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_GFX ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_MES ||
-		      adev->ip_blocks[i].version->type ==
-			      AMD_IP_BLOCK_TYPE_SDMA))
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if (!(ip_block->version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_MES ||
+		      ip_block->version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 
-		if (adev->ip_blocks[i].version->funcs->late_init) {
-			r = adev->ip_blocks[i].version->funcs->late_init(
-				&adev->ip_blocks[i]);
+		if (ip_block->version->funcs->late_init) {
+			r = ip_block->version->funcs->late_init(ip_block);
 			if (r) {
 				dev_err(adev->dev,
 					"late_init of IP block <%s> failed %d after reset\n",
-					adev->ip_blocks[i].version->funcs->name,
-					r);
+					ip_block->version->funcs->name, r);
 				return r;
 			}
 		}
-		amdgpu_device_ip_set_state(adev, i, AMDGPU_IP_STATE_LATE);
+		amdgpu_ip_block_set_state(ip_block, AMDGPU_IP_STATE_LATE);
 	}
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c75402d606c3..1f8450fb1cc1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -225,12 +225,12 @@ static int smu_set_gfx_imu_enable(struct smu_context *smu)
 
 static bool is_vcn_enabled(struct amdgpu_device *adev)
 {
-	int i;
+	struct amdgpu_ip_block *ip_block;
 
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if ((adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_VCN ||
-			adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_JPEG) &&
-			!amdgpu_device_ip_valid(adev, i))
+	amdgpu_for_each_ip_block(adev, ip_block) {
+		if ((ip_block->version->type == AMD_IP_BLOCK_TYPE_VCN ||
+			ip_block->version->type == AMD_IP_BLOCK_TYPE_JPEG) &&
+			!amdgpu_ip_block_valid(ip_block))
 			return false;
 	}
 
-- 
2.43.5

