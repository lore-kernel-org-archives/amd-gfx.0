Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5030C3DA70
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Jul 2024 15:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D2410E247;
	Sun, 28 Jul 2024 15:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uz2J1JuI";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B47010E240;
 Sun, 28 Jul 2024 15:46:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7333CCE0104;
 Sun, 28 Jul 2024 15:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76738C116B1;
 Sun, 28 Jul 2024 15:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722181581;
 bh=7wNShyGotxCNbp1EPjLuOSGi98bosjRauLY6/gH0wAQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uz2J1JuIL7qHatwe1qtytYFjYWRRlBb5uZ+BD1og9TGgpQ/0qV0tlsnxFlvTJwg4t
 zKHCo2XiHxYRW0p0wUtazRLxqV64NaRJ4AstLvMj9QCHAK0YJgQ/A2WseaedzKTfeW
 W2IcvMooWD/pJOlV+v9bHTnpyIQT6y8nuTk4Oll5DSA4bx7vz7VwXQkAuHqQ//bbPp
 KUHlas5D2Bd7UjE1065Gs7azDIXLRpozeUgKYW4oVIpm2Yb/YH7SZXwgp5+taxt7bw
 epyZy5zP9wHiqWZiqPOQAztOt5Sp2ZqNQ0mZOc6a2d2addKZAaEhLMkS6Cr6f0aRle
 yPY6QpKKTSIsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Sasha Levin <sashal@kernel.org>, evan.quan@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, lijo.lazar@amd.com, sunil.khatri@amd.com,
 sunran001@208suo.com, kenneth.feng@amd.com, le.ma@amd.com, Lang.Yu@amd.com,
 mario.limonciello@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 03/20] drm/amdgpu/pm: Fix the param type of
 set_power_profile_mode
Date: Sun, 28 Jul 2024 11:45:01 -0400
Message-ID: <20240728154605.2048490-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154605.2048490-1-sashal@kernel.org>
References: <20240728154605.2048490-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit f683f24093dd94a831085fe0ea8e9dc4c6c1a2d1 ]

Function .set_power_profile_mode need an array as input
parameter. So define variable workload as an array to fix
the below coverity warning.

"Passing &workload to function hwmgr->hwmgr_func->set_power_profile_mode
which uses it as an array. This might corrupt or misinterpret adjacent
memory locations"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  8 ++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c  |  8 ++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 16 ++++++++--------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 9e4f8a4104a34..7bf46e4974f88 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -927,7 +927,7 @@ static int pp_dpm_switch_power_profile(void *handle,
 		enum PP_SMC_POWER_PROFILE type, bool en)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	long workload;
+	long workload[1];
 	uint32_t index;
 
 	if (!hwmgr || !hwmgr->pm_en)
@@ -945,12 +945,12 @@ static int pp_dpm_switch_power_profile(void *handle,
 		hwmgr->workload_mask &= ~(1 << hwmgr->workload_prority[type]);
 		index = fls(hwmgr->workload_mask);
 		index = index > 0 && index <= Workload_Policy_Max ? index - 1 : 0;
-		workload = hwmgr->workload_setting[index];
+		workload[0] = hwmgr->workload_setting[index];
 	} else {
 		hwmgr->workload_mask |= (1 << hwmgr->workload_prority[type]);
 		index = fls(hwmgr->workload_mask);
 		index = index <= Workload_Policy_Max ? index - 1 : 0;
-		workload = hwmgr->workload_setting[index];
+		workload[0] = hwmgr->workload_setting[index];
 	}
 
 	if (type == PP_SMC_POWER_PROFILE_COMPUTE &&
@@ -960,7 +960,7 @@ static int pp_dpm_switch_power_profile(void *handle,
 	}
 
 	if (hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
-		hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
+		hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, workload, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
index 1d829402cd2e2..f4bd8e9357e22 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
@@ -269,7 +269,7 @@ int psm_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr, bool skip_display_set
 						struct pp_power_state *new_ps)
 {
 	uint32_t index;
-	long workload;
+	long workload[1];
 
 	if (hwmgr->not_vf) {
 		if (!skip_display_settings)
@@ -294,10 +294,10 @@ int psm_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr, bool skip_display_set
 	if (hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
 		index = fls(hwmgr->workload_mask);
 		index = index > 0 && index <= Workload_Policy_Max ? index - 1 : 0;
-		workload = hwmgr->workload_setting[index];
+		workload[0] = hwmgr->workload_setting[index];
 
-		if (hwmgr->power_profile_mode != workload && hwmgr->hwmgr_func->set_power_profile_mode)
-			hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
+		if (hwmgr->power_profile_mode != workload[0] && hwmgr->hwmgr_func->set_power_profile_mode)
+			hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, workload, 0);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 56e4c312cb7a9..1402e468aa90f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1846,7 +1846,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 {
 	int ret = 0;
 	int index = 0;
-	long workload;
+	long workload[1];
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (!skip_display_settings) {
@@ -1886,10 +1886,10 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload = smu->workload_setting[index];
+		workload[0] = smu->workload_setting[index];
 
-		if (smu->power_profile_mode != workload)
-			smu_bump_power_profile_mode(smu, &workload, 0);
+		if (smu->power_profile_mode != workload[0])
+			smu_bump_power_profile_mode(smu, workload, 0);
 	}
 
 	return ret;
@@ -1939,7 +1939,7 @@ static int smu_switch_power_profile(void *handle,
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	long workload;
+	long workload[1];
 	uint32_t index;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -1952,17 +1952,17 @@ static int smu_switch_power_profile(void *handle,
 		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload = smu->workload_setting[index];
+		workload[0] = smu->workload_setting[index];
 	} else {
 		smu->workload_mask |= (1 << smu->workload_prority[type]);
 		index = fls(smu->workload_mask);
 		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload = smu->workload_setting[index];
+		workload[0] = smu->workload_setting[index];
 	}
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
 		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
-		smu_bump_power_profile_mode(smu, &workload, 0);
+		smu_bump_power_profile_mode(smu, workload, 0);
 
 	return 0;
 }
-- 
2.43.0

