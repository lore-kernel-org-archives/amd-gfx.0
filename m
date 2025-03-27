Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE74C36014
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB5310E949;
	Thu, 27 Mar 2025 20:39:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RpNEOwc4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E748910E946
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CEC1F614C5;
 Thu, 27 Mar 2025 20:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C235C4CEEB;
 Thu, 27 Mar 2025 20:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107954;
 bh=YhIFCBqL4X7IlFc02EV2H50LnrHTqzDYw+dVwUackpg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RpNEOwc4vHasJBDsc/v8wPVZaB7Z8yW8cAJfVr99yUxQSptN2JNc7kvtdNQVM1n3t
 MWJhYzNiPDUcAvk8OCredNuhEQ6YbELpZyuknnQWX5c7Ll5J8eSxr4dwhLWSgiBuXH
 FlvMlixzrkbwHAWUD4wJ9kdzNqjGbj+z4yFgPRXzr7ReK7VQkQXSvmGu9Rk86Zyi8a
 JXt+RYdbzaKbqo75uVHSJ4Tbbm+EgM1Js4cht4etonU5iag0D64jnY1xf8LW1y7heI
 +f9cz4r3I2LCRqGkP2VvpR6oT633AfKa8qEVhLKm0wjjnz0EarSzYP2fom0grJZra4
 pZWjUKARsr0iQ==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 11/14] drm/amd: Add struct amdgpu_device into
 amdgpu_gfx_parse_disable_cu()
Date: Thu, 27 Mar 2025 15:38:55 -0500
Message-ID: <20250327203858.3796086-12-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

In order for messages from amdgpu_gfx_parse_disable_cu() to be device
specific pass in the device to the function and adjust all callers.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 10 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 72af5e5a894a2..0cf11e0fa2985 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -97,6 +97,7 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev,
 /**
  * amdgpu_gfx_parse_disable_cu - Parse the disable_cu module parameter
  *
+ * @adev: amdgpu device
  * @mask: array in which the per-shader array disable masks will be stored
  * @max_se: number of SEs
  * @max_sh: number of SHs
@@ -104,7 +105,8 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev,
  * The bitmask of CUs to be disabled in the shader array determined by se and
  * sh is stored in mask[se * max_sh + sh].
  */
-void amdgpu_gfx_parse_disable_cu(unsigned int *mask, unsigned int max_se, unsigned int max_sh)
+void amdgpu_gfx_parse_disable_cu(struct amdgpu_device *adev, unsigned int *mask,
+				 unsigned int max_se, unsigned int max_sh)
 {
 	unsigned int se, sh, cu;
 	const char *p;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 75af4f25a133b..4f59844191f5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -519,8 +519,8 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
 	return (u32)((1ULL << bit_width) - 1);
 }
 
-void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
-				 unsigned max_sh);
+void amdgpu_gfx_parse_disable_cu(struct amdgpu_device *adev, unsigned int *mask,
+				 unsigned int max_se, unsigned int max_sh);
 
 int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e93567e87fd93..17a4f60b7b516 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -10086,7 +10086,7 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 	if (!adev || !cu_info)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2);
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 4, 2);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b0bad4e55ae26..bfee9eb901b8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -7109,7 +7109,7 @@ static int gfx_v11_0_get_cu_info(struct amdgpu_device *adev,
 	if (!adev || !cu_info)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 8, 2);
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 8, 2);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 52af71147b0b1..b6a79c7a66ddb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5465,7 +5465,7 @@ static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 	if (!adev || !cu_info)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 8, 2);
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 8, 2);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index b2bb8a33ab5df..14b9bae75cd2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3574,7 +3574,7 @@ static void gfx_v6_0_get_cu_info(struct amdgpu_device *adev)
 
 	memset(cu_info, 0, sizeof(*cu_info));
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2);
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 4, 2);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 3292ed7442f84..9a24cfbd14900 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -5145,7 +5145,7 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev)
 
 	memset(cu_info, 0, sizeof(*cu_info));
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2);
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 4, 2);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index bfedd487efc53..d51d4124edab3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -7149,7 +7149,7 @@ static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev)
 	else
 		ao_cu_num = adev->gfx.config.max_cu_per_sh;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2);
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 4, 2);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index a8d9875a46e1c..c4162716a78c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7780,7 +7780,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 		adev->gfx.config.max_sh_per_se > 16)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks,
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks,
 				    adev->gfx.config.max_shader_engines,
 				    adev->gfx.config.max_sh_per_se);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a26159d749aae..205b44a3108d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4842,7 +4842,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 		adev->gfx.config.max_sh_per_se > 16)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks,
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks,
 				    adev->gfx.config.max_shader_engines,
 				    adev->gfx.config.max_sh_per_se);
 
-- 
2.43.0

