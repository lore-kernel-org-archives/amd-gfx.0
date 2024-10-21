Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46A3D0E6C8
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 08:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8475B10E442;
	Mon, 21 Oct 2024 08:14:00 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7973510E43F
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 08:13:52 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 49L8Dfvu1824163; Mon, 21 Oct 2024 13:43:41 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 49L8DfLr1824162;
 Mon, 21 Oct 2024 13:43:41 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v7 08/10] drm/amdgpu: clean the dummy soft_reset functions
Date: Mon, 21 Oct 2024 13:43:37 +0530
Message-Id: <20241021081339.1824078-9-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021081339.1824078-1-sunil.khatri@amd.com>
References: <20241021081339.1824078-1-sunil.khatri@amd.com>
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

Remove the dummy soft_reset functions for all
ip blocks.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c          | 6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c          | 6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c         | 6 ------
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c            | 6 ------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c           | 6 ------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c           | 6 ------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c           | 6 ------
 drivers/gpu/drm/amd/amdgpu/nv.c                  | 6 ------
 drivers/gpu/drm/amd/amdgpu/si.c                  | 6 ------
 drivers/gpu/drm/amd/amdgpu/soc15.c               | 6 ------
 drivers/gpu/drm/amd/amdgpu/soc21.c               | 6 ------
 drivers/gpu/drm/amd/amdgpu/soc24.c               | 6 ------
 drivers/gpu/drm/amd/amdgpu/vi.c                  | 6 ------
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c       | 6 ------
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c       | 6 ------
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 6 ------
 16 files changed, 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 1a9b7e8947d8..8b7e056a7355 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -584,11 +584,6 @@ static bool acp_is_idle(void *handle)
 	return true;
 }
 
-static int acp_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int acp_set_clockgating_state(void *handle,
 				     enum amd_clockgating_state state)
 {
@@ -617,7 +612,6 @@ static const struct amd_ip_funcs acp_ip_funcs = {
 	.suspend = acp_suspend,
 	.resume = acp_resume,
 	.is_idle = acp_is_idle,
-	.soft_reset = acp_soft_reset,
 	.set_clockgating_state = acp_set_clockgating_state,
 	.set_powergating_state = acp_set_powergating_state,
 	.dump_ip_state = NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 4832a179d8c3..05ea7d9cb7d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -128,11 +128,6 @@ static bool isp_is_idle(void *handle)
 	return true;
 }
 
-static int isp_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int isp_set_clockgating_state(void *handle,
 				     enum amd_clockgating_state state)
 {
@@ -152,7 +147,6 @@ static const struct amd_ip_funcs isp_ip_funcs = {
 	.hw_init = isp_hw_init,
 	.hw_fini = isp_hw_fini,
 	.is_idle = isp_is_idle,
-	.soft_reset = isp_soft_reset,
 	.set_clockgating_state = isp_set_clockgating_state,
 	.set_powergating_state = isp_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 1f2bc8116434..f9fc08952aa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -632,11 +632,6 @@ static bool amdgpu_vkms_is_idle(void *handle)
 	return true;
 }
 
-static int amdgpu_vkms_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int amdgpu_vkms_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
@@ -660,7 +655,6 @@ static const struct amd_ip_funcs amdgpu_vkms_ip_funcs = {
 	.suspend = amdgpu_vkms_suspend,
 	.resume = amdgpu_vkms_resume,
 	.is_idle = amdgpu_vkms_is_idle,
-	.soft_reset = amdgpu_vkms_soft_reset,
 	.set_clockgating_state = amdgpu_vkms_set_clockgating_state,
 	.set_powergating_state = amdgpu_vkms_set_powergating_state,
 	.dump_ip_state = NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 6ac6d4dfa49f..5769055909bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3186,11 +3186,6 @@ static int gfx_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int gfx_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static void gfx_v6_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 						 enum amdgpu_interrupt_state state)
 {
@@ -3449,7 +3444,6 @@ static const struct amd_ip_funcs gfx_v6_0_ip_funcs = {
 	.resume = gfx_v6_0_resume,
 	.is_idle = gfx_v6_0_is_idle,
 	.wait_for_idle = gfx_v6_0_wait_for_idle,
-	.soft_reset = gfx_v6_0_soft_reset,
 	.set_clockgating_state = gfx_v6_0_set_clockgating_state,
 	.set_powergating_state = gfx_v6_0_set_powergating_state,
 	.dump_ip_state = NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5cf2002fcba8..3c9b7f88a6cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1085,11 +1085,6 @@ static int gmc_v10_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v10_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int gmc_v10_0_set_clockgating_state(void *handle,
 					   enum amd_clockgating_state state)
 {
@@ -1151,7 +1146,6 @@ const struct amd_ip_funcs gmc_v10_0_ip_funcs = {
 	.resume = gmc_v10_0_resume,
 	.is_idle = gmc_v10_0_is_idle,
 	.wait_for_idle = gmc_v10_0_wait_for_idle,
-	.soft_reset = gmc_v10_0_soft_reset,
 	.set_clockgating_state = gmc_v10_0_set_clockgating_state,
 	.set_powergating_state = gmc_v10_0_set_powergating_state,
 	.get_clockgating_state = gmc_v10_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 4df4d73038f8..6e7cf551fe16 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -993,11 +993,6 @@ static int gmc_v11_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v11_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int gmc_v11_0_set_clockgating_state(void *handle,
 					   enum amd_clockgating_state state)
 {
@@ -1038,7 +1033,6 @@ const struct amd_ip_funcs gmc_v11_0_ip_funcs = {
 	.resume = gmc_v11_0_resume,
 	.is_idle = gmc_v11_0_is_idle,
 	.wait_for_idle = gmc_v11_0_wait_for_idle,
-	.soft_reset = gmc_v11_0_soft_reset,
 	.set_clockgating_state = gmc_v11_0_set_clockgating_state,
 	.set_powergating_state = gmc_v11_0_set_powergating_state,
 	.get_clockgating_state = gmc_v11_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index e33f9e9058cc..d4a9a03e5fd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -977,11 +977,6 @@ static int gmc_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v12_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int gmc_v12_0_set_clockgating_state(void *handle,
 					   enum amd_clockgating_state state)
 {
@@ -1022,7 +1017,6 @@ const struct amd_ip_funcs gmc_v12_0_ip_funcs = {
 	.resume = gmc_v12_0_resume,
 	.is_idle = gmc_v12_0_is_idle,
 	.wait_for_idle = gmc_v12_0_wait_for_idle,
-	.soft_reset = gmc_v12_0_soft_reset,
 	.set_clockgating_state = gmc_v12_0_set_clockgating_state,
 	.set_powergating_state = gmc_v12_0_set_powergating_state,
 	.get_clockgating_state = gmc_v12_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 38f5a2cbc3fe..c16f724384cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1039,11 +1039,6 @@ static bool nv_common_is_idle(void *handle)
 	return true;
 }
 
-static int nv_common_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int nv_common_set_clockgating_state(void *handle,
 					   enum amd_clockgating_state state)
 {
@@ -1106,7 +1101,6 @@ static const struct amd_ip_funcs nv_common_ip_funcs = {
 	.suspend = nv_common_suspend,
 	.resume = nv_common_resume,
 	.is_idle = nv_common_is_idle,
-	.soft_reset = nv_common_soft_reset,
 	.set_clockgating_state = nv_common_set_clockgating_state,
 	.set_powergating_state = nv_common_set_powergating_state,
 	.get_clockgating_state = nv_common_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 36f17c87de85..adedbf4bff78 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2649,11 +2649,6 @@ static bool si_common_is_idle(void *handle)
 	return true;
 }
 
-static int si_common_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int si_common_set_clockgating_state(void *handle,
 					    enum amd_clockgating_state state)
 {
@@ -2674,7 +2669,6 @@ static const struct amd_ip_funcs si_common_ip_funcs = {
 	.hw_fini = si_common_hw_fini,
 	.resume = si_common_resume,
 	.is_idle = si_common_is_idle,
-	.soft_reset = si_common_soft_reset,
 	.set_clockgating_state = si_common_set_clockgating_state,
 	.set_powergating_state = si_common_set_powergating_state,
 	.dump_ip_state = NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index d974c0b5a909..19391cbc1474 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1341,11 +1341,6 @@ static bool soc15_common_is_idle(void *handle)
 	return true;
 }
 
-static int soc15_common_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static void soc15_update_drm_clock_gating(struct amdgpu_device *adev, bool enable)
 {
 	uint32_t def, data;
@@ -1496,7 +1491,6 @@ static const struct amd_ip_funcs soc15_common_ip_funcs = {
 	.suspend = soc15_common_suspend,
 	.resume = soc15_common_resume,
 	.is_idle = soc15_common_is_idle,
-	.soft_reset = soc15_common_soft_reset,
 	.set_clockgating_state = soc15_common_set_clockgating_state,
 	.set_powergating_state = soc15_common_set_powergating_state,
 	.get_clockgating_state= soc15_common_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 78550a965579..078f25b5f09b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -927,11 +927,6 @@ static bool soc21_common_is_idle(void *handle)
 	return true;
 }
 
-static int soc21_common_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int soc21_common_set_clockgating_state(void *handle,
 					   enum amd_clockgating_state state)
 {
@@ -995,7 +990,6 @@ static const struct amd_ip_funcs soc21_common_ip_funcs = {
 	.suspend = soc21_common_suspend,
 	.resume = soc21_common_resume,
 	.is_idle = soc21_common_is_idle,
-	.soft_reset = soc21_common_soft_reset,
 	.set_clockgating_state = soc21_common_set_clockgating_state,
 	.set_powergating_state = soc21_common_set_powergating_state,
 	.get_clockgating_state = soc21_common_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 216a45556cf4..3af10ef4b793 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -522,11 +522,6 @@ static bool soc24_common_is_idle(void *handle)
 	return true;
 }
 
-static int soc24_common_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int soc24_common_set_clockgating_state(void *handle,
 					      enum amd_clockgating_state state)
 {
@@ -586,7 +581,6 @@ static const struct amd_ip_funcs soc24_common_ip_funcs = {
 	.suspend = soc24_common_suspend,
 	.resume = soc24_common_resume,
 	.is_idle = soc24_common_is_idle,
-	.soft_reset = soc24_common_soft_reset,
 	.set_clockgating_state = soc24_common_set_clockgating_state,
 	.set_powergating_state = soc24_common_set_powergating_state,
 	.get_clockgating_state = soc24_common_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a40c789dc3c4..607b48a2d5eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1741,11 +1741,6 @@ static bool vi_common_is_idle(void *handle)
 	return true;
 }
 
-static int vi_common_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static void vi_update_bif_medium_grain_light_sleep(struct amdgpu_device *adev,
 						   bool enable)
 {
@@ -2038,7 +2033,6 @@ static const struct amd_ip_funcs vi_common_ip_funcs = {
 	.suspend = vi_common_suspend,
 	.resume = vi_common_resume,
 	.is_idle = vi_common_is_idle,
-	.soft_reset = vi_common_soft_reset,
 	.set_clockgating_state = vi_common_set_clockgating_state,
 	.set_powergating_state = vi_common_set_powergating_state,
 	.get_clockgating_state = vi_common_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index fbea169460f2..785cb20e64b6 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3099,11 +3099,6 @@ static bool kv_dpm_is_idle(void *handle)
 	return true;
 }
 
-static int kv_dpm_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int kv_dpm_set_interrupt_state(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *src,
 				      unsigned type,
@@ -3307,7 +3302,6 @@ static const struct amd_ip_funcs kv_dpm_ip_funcs = {
 	.suspend = kv_dpm_suspend,
 	.resume = kv_dpm_resume,
 	.is_idle = kv_dpm_is_idle,
-	.soft_reset = kv_dpm_soft_reset,
 	.set_clockgating_state = kv_dpm_set_clockgating_state,
 	.set_powergating_state = kv_dpm_set_powergating_state,
 	.dump_ip_state = NULL,
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index a4908f0402f1..7b0ded50251a 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7849,11 +7849,6 @@ static int si_dpm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int si_dpm_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int si_dpm_set_clockgating_state(void *handle,
 					enum amd_clockgating_state state)
 {
@@ -8049,7 +8044,6 @@ static const struct amd_ip_funcs si_dpm_ip_funcs = {
 	.resume = si_dpm_resume,
 	.is_idle = si_dpm_is_idle,
 	.wait_for_idle = si_dpm_wait_for_idle,
-	.soft_reset = si_dpm_soft_reset,
 	.set_clockgating_state = si_dpm_set_clockgating_state,
 	.set_powergating_state = si_dpm_set_powergating_state,
 	.dump_ip_state = NULL,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 7eacf4dd1b60..5aadb6061c22 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -244,11 +244,6 @@ static bool pp_is_idle(void *handle)
 	return false;
 }
 
-static int pp_sw_reset(struct amdgpu_ip_block *ip_block)
-{
-	return 0;
-}
-
 static int pp_set_powergating_state(void *handle,
 				    enum amd_powergating_state state)
 {
@@ -290,7 +285,6 @@ static const struct amd_ip_funcs pp_ip_funcs = {
 	.suspend = pp_suspend,
 	.resume = pp_resume,
 	.is_idle = pp_is_idle,
-	.soft_reset = pp_sw_reset,
 	.set_clockgating_state = pp_set_clockgating_state,
 	.set_powergating_state = pp_set_powergating_state,
 	.dump_ip_state = NULL,
-- 
2.34.1

