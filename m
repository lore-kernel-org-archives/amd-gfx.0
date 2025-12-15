Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3C5D59D99
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 01:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07EF110E0BC;
	Mon, 15 Dec 2025 01:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BmTtTSWh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5CF10E0AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F238442D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2B5C19421;
 Mon, 15 Dec 2025 01:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765761155;
 bh=rVa6QeDtSO3pA7cxvekxMAOq2/MRD8x+/eIteJGyDI0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BmTtTSWhZMJQpKib8I8QnMXkLE7uK7HqBFdMSuNbHWf+DAM/56kEbtzSPCC8PiXoV
 QE33TpxsJ5ghR3UhndToNprO74dMD/4hqE3SlSsGMrok4f7KQyc1Wzwy7bPjKzh5LZ
 EeYRfMnpONLrnx8tFyYOfML7q960S1z+X7UaoWvjPJy4KW7PgeIwuAvmTgDzwVfKLP
 TEh1eCVvLRhPUBmsGrEqOTR78RxHwL+6hCpmt0XK1+R2LAwmdXL+2Yi+PwUyMvFuUD
 DlMjuvkG69JT7cNFHE/vzy9Z6ZBIpjlemLkt5dCPx3BPalK6IgJo6Co7J3CjpF1YqF
 nJtbPZWWYUrRA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 4/9] drm/amd: Pass `adev` to amdgpu_gfx_parse_disable_cu()
Date: Sun, 14 Dec 2025 19:12:22 -0600
Message-ID: <20251215011227.161597-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215011227.161597-1-superm1@kernel.org>
References: <20251215011227.161597-1-superm1@kernel.org>
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

In order for messages to be attribute to the correct device
amdgpu_gfx_parse_disable_cu() needs to know what device is being
operated on.  Pass the argument in.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
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
index ab2bbf1f90e0c..b321783f2bccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -100,6 +100,7 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev,
 /**
  * amdgpu_gfx_parse_disable_cu - Parse the disable_cu module parameter
  *
+ * @adev: amdgpu device pointer
  * @mask: array in which the per-shader array disable masks will be stored
  * @max_se: number of SEs
  * @max_sh: number of SHs
@@ -107,7 +108,8 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev,
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
index 281e03ad32556..585cc8e81bb28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -569,8 +569,8 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
 	return (u32)((1ULL << bit_width) - 1);
 }
 
-void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
-				 unsigned max_sh);
+void amdgpu_gfx_parse_disable_cu(struct amdgpu_device *adev, unsigned int *mask,
+				 unsigned int max_se, unsigned int max_sh);
 
 int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 31c2d33f02d5f..1081354a18929 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -10114,7 +10114,7 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 	if (!adev || !cu_info)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2);
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 4, 2);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 79a6977d56b0e..5ab6122916c81 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -7472,7 +7472,7 @@ static int gfx_v11_0_get_cu_info(struct amdgpu_device *adev,
 	if (!adev || !cu_info)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 8, 2);
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 8, 2);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b4dd954363ee1..c2e1db200712a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5728,7 +5728,7 @@ static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 	if (!adev || !cu_info)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 8, 2);
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 8, 2);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 80565392313f1..63e6924a1f223 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3555,7 +3555,7 @@ static void gfx_v6_0_get_cu_info(struct amdgpu_device *adev)
 
 	memset(cu_info, 0, sizeof(*cu_info));
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2);
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 4, 2);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 9c0bcf836b2ee..2fa3a37a26542 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -5063,7 +5063,7 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev)
 
 	memset(cu_info, 0, sizeof(*cu_info));
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2);
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 4, 2);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5c1f8230be8ce..4e285ed5afaca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -7084,7 +7084,7 @@ static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev)
 	else
 		ao_cu_num = adev->gfx.config.max_cu_per_sh;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks, 4, 2);
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 4, 2);
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index bb1465a98c7ca..4eadcf58804a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7762,7 +7762,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 		adev->gfx.config.max_sh_per_se > 16)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks,
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks,
 				    adev->gfx.config.max_shader_engines,
 				    adev->gfx.config.max_sh_per_se);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 4e4d88d6357f9..14fc9a3b93343 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4903,7 +4903,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 		adev->gfx.config.max_sh_per_se > 16)
 		return -EINVAL;
 
-	amdgpu_gfx_parse_disable_cu(disable_masks,
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks,
 				    adev->gfx.config.max_shader_engines,
 				    adev->gfx.config.max_sh_per_se);
 
-- 
2.43.0

