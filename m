Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A148CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 03:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C266E981;
	Thu,  2 Dec 2021 03:25:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257C36E96D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 03:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TD1HgRhFz4DeUvH4H3sZNxMscGsq9cD8We7UPsWI+tXM+NLGKy3eGlLJlPuoPAqd7sBhmn65bf4rfZWGGcyExwt1Htg+nQc97ySPAZpaw4vcIjYEEaj6FjAiS2pRtagU291SRjiuD0i6onwJkPbY4uSWHK22COuo0cvzhulmjsiyU4AA8XKX6ar1qsQ+TvZM46E6ya/gaSIF8DdGnLbJG2RcjwaE5RxuflSr5qraJ8mZLV7vUvxd6nE0hKQ0lBiXvawO2snn/M7Fo2AQTQSWUaWk4YdHR3PniBn3oimYhee/MeC37q4HLlKpuSugxwp3biykehVe7hMVVGcdutTLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr6ii77sLVBsZZRhDi2rqLqXtyN2xhRmEyMKVny64TM=;
 b=cAnbfByCPLTN2BmGl8LnLBJh6W4SUYAJVrMbzD3BBRFyLqOrHiG5GIyJumxWvFKAa0obKc9V1MGoQv5ubH5ifoRlnpFa3cl+Bl/o0wO1UIs9y1te7ONTwTgnz9Nk4xmIrJHa2wsGVfy73iF5qL57NKuLFOyD73CpEv9yBtUk1F8TGsI7tpTwZcFEfhC7FSrB1wVGAPT6vEshnykRzaMzz3E178IKKWjdOktbSxTPy8sCSACNm+QFoa+xtJrNdsX0/ye4qC55HPR0sjWajCJ11GUU9fZqKGRGXyI0xDyAbeL04AmcMy9Tlg/yt8iuubvW/NLGYXhC127ud3ROL2Ap3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kr6ii77sLVBsZZRhDi2rqLqXtyN2xhRmEyMKVny64TM=;
 b=JAXtEcXYlJWXA4wWbNIX5YxKJhJZ4RYGz+Kf4WzxPLW7BHZoVlV8kTnGBDD8t4mutvslqy1FiKvLs4lJuzcbO73vfSb5Rb2QHHP2JE3Nrbd3tUWlRAW8FAhc1wsa8lv+fG+hjLo4TQWj22+vrd/3FPi3fS5wxD+QVmsOP8hkfFQ=
Received: from DM5PR13CA0019.namprd13.prod.outlook.com (2603:10b6:3:23::29) by
 SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.24; Thu, 2 Dec 2021 03:10:35 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::ef) by DM5PR13CA0019.outlook.office365.com
 (2603:10b6:3:23::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Thu, 2 Dec 2021 03:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 03:10:34 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 21:10:32 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 16/17] drm/amd/pm: revise the performance level setting APIs
Date: Thu, 2 Dec 2021 11:09:29 +0800
Message-ID: <20211202030930.1681278-17-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211202030930.1681278-1-evan.quan@amd.com>
References: <20211202030930.1681278-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 636ed782-fa8d-493d-1568-08d9b5414eca
X-MS-TrafficTypeDiagnostic: SN6PR12MB2800:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2800E99099A5F125C94A3394E4699@SN6PR12MB2800.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4izpTPaJgqWlNMhSviWdiSJCK/6J5gvchdtzhLZrFjZC+W4x4ewffU2cr5oJPTwtdrcOCsCmHE2Jc7aw8EHOgW4dJXx69V6y6BSkM7b7MhmC9qNBFggRQH87Ql++ndC8xOfMFZxeTE5du7KsQUrP2kHEO62WC08Emuga+lQlEtXYrEf0Wl6yIudsRCk439AohBr4Ak4FhsCCjln+QRDeENtjRqbkOUaYcdWC4Z/OpkHq9HRw9LU06WBkcDrp24YhGrSOToyqkwG92AVHvtxwgmCSBop3glV4fg0WCJrkkKeNBRlWfP8ctxtMyf6v8voCJWlsl9qTYgVoEndwEgw1gTHt1aNBOmXk7t3fSADtVhUBGAFNLAZfGYOQdA4JOces1nzwr3zKZ/JSdFj+AM8VY8THLY3YGUphXSbUT8SUTMsMr5iWtFcSrK8U1YJw9xbSjfdWmxNwoXpTjHTb9gzGPLkWanYkr5LhCxVsM8b1lnywWkcOmn1/BSInloJZi74K+N9DP4+hkIxvRByoc0MJzokvwo7DNWbNO7PF6ZODGQ519zdw3fS4Vm5VoK+DKNAko2UNPDAeO14T6gVuvcQkRMED41jX0pOC/7fQB0iNelf3sYAF77Gnctflq7TnkvPSpjEShjntc6J6JCt5HOMUG0HahbLY+2uPifOBm2V9szdf75VYSNaBGMiZIC0ymFGNZCQDI2SyyKnofDczpHDXb4L9Bi8qG2qMzSm6gzGKvpSZMTnNXLJJMwsTErr/BSvpTVq7T8rpMTRVs8RlSZPgcVeUJ9UYw7DVuYjEnMsmfY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(1076003)(86362001)(70586007)(8936002)(81166007)(6666004)(36860700001)(508600001)(70206006)(83380400001)(2906002)(2616005)(47076005)(40460700001)(426003)(8676002)(336012)(82310400004)(4326008)(16526019)(6916009)(7696005)(186003)(5660300002)(36756003)(356005)(44832011)(316002)(26005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:10:34.8066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 636ed782-fa8d-493d-1568-08d9b5414eca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2800
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Avoid cross callings which make lock protection enforcement
on amdgpu_dpm_force_performance_level() impossible.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ie658140f40ab906ce2ec47576a086062b61076a6
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 29 ++++++++++++++++---
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 17 ++++++-----
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 12 --------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 --------
 4 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f5c0ae032954..5e5006af6b75 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -305,6 +305,10 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level;
 	enum amd_dpm_forced_level current_level;
 	int ret = 0;
+	uint32_t profile_mode_mask = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
+					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
+					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
+					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -358,10 +362,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	}
 
 	/* profile_exit setting is valid only when current mode is in profile mode */
-	if (!(current_level & (AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
-	    AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
-	    AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
-	    AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)) &&
+	if (!(current_level & profile_mode_mask) &&
 	    (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)) {
 		pr_err("Currently not in any profile mode!\n");
 		pm_runtime_mark_last_busy(ddev->dev);
@@ -369,6 +370,26 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return -EINVAL;
 	}
 
+	if (!(current_level & profile_mode_mask) &&
+	      (level & profile_mode_mask)) {
+		/* enter UMD Pstate */
+		amdgpu_device_ip_set_powergating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_clockgating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_CG_STATE_UNGATE);
+	} else if ((current_level & profile_mode_mask) &&
+		    !(level & profile_mode_mask)) {
+		/* exit UMD Pstate */
+		amdgpu_device_ip_set_clockgating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev,
+						       AMD_IP_BLOCK_TYPE_GFX,
+						       AMD_PG_STATE_GATE);
+	}
+
 	if (amdgpu_dpm_force_performance_level(adev, level)) {
 		pm_runtime_mark_last_busy(ddev->dev);
 		pm_runtime_put_autosuspend(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index 3c6ee493e410..9613c6181c17 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -953,6 +953,7 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
 
 static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 {
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	struct amdgpu_ps *ps;
 	enum amd_pm_state_type dpm_state;
 	int ret;
@@ -976,7 +977,7 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 	else
 		return -EINVAL;
 
-	if (amdgpu_dpm == 1 && adev->powerplay.pp_funcs->print_power_state) {
+	if (amdgpu_dpm == 1 && pp_funcs->print_power_state) {
 		printk("switching from power state:\n");
 		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
 		printk("switching to power state:\n");
@@ -985,14 +986,14 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 
 	/* update whether vce is active */
 	ps->vce_active = adev->pm.dpm.vce_active;
-	if (adev->powerplay.pp_funcs->display_configuration_changed)
+	if (pp_funcs->display_configuration_changed)
 		amdgpu_dpm_display_configuration_changed(adev);
 
 	ret = amdgpu_dpm_pre_set_power_state(adev);
 	if (ret)
 		return ret;
 
-	if (adev->powerplay.pp_funcs->check_state_equal) {
+	if (pp_funcs->check_state_equal) {
 		if (0 != amdgpu_dpm_check_state_equal(adev, adev->pm.dpm.current_ps, adev->pm.dpm.requested_ps, &equal))
 			equal = false;
 	}
@@ -1000,24 +1001,24 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 	if (equal)
 		return 0;
 
-	if (adev->powerplay.pp_funcs->set_power_state)
-		adev->powerplay.pp_funcs->set_power_state(adev->powerplay.pp_handle);
+	if (pp_funcs->set_power_state)
+		pp_funcs->set_power_state(adev->powerplay.pp_handle);
 
 	amdgpu_dpm_post_set_power_state(adev);
 
 	adev->pm.dpm.current_active_crtcs = adev->pm.dpm.new_active_crtcs;
 	adev->pm.dpm.current_active_crtc_count = adev->pm.dpm.new_active_crtc_count;
 
-	if (adev->powerplay.pp_funcs->force_performance_level) {
+	if (pp_funcs->force_performance_level) {
 		if (adev->pm.dpm.thermal_active) {
 			enum amd_dpm_forced_level level = adev->pm.dpm.forced_level;
 			/* force low perf level for thermal */
-			amdgpu_dpm_force_performance_level(adev, AMD_DPM_FORCED_LEVEL_LOW);
+			pp_funcs->force_performance_level(adev, AMD_DPM_FORCED_LEVEL_LOW);
 			/* save the user's level */
 			adev->pm.dpm.forced_level = level;
 		} else {
 			/* otherwise, user selected level */
-			amdgpu_dpm_force_performance_level(adev, adev->pm.dpm.forced_level);
+			pp_funcs->force_performance_level(adev, adev->pm.dpm.forced_level);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index d57d5c28c013..5a14ddd3ef05 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -323,12 +323,6 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwmgr,
 		if (*level & profile_mode_mask) {
 			hwmgr->saved_dpm_level = hwmgr->dpm_level;
 			hwmgr->en_umd_pstate = true;
-			amdgpu_device_ip_set_powergating_state(hwmgr->adev,
-					AMD_IP_BLOCK_TYPE_GFX,
-					AMD_PG_STATE_UNGATE);
-			amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
-						AMD_IP_BLOCK_TYPE_GFX,
-						AMD_CG_STATE_UNGATE);
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/
@@ -336,12 +330,6 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwmgr,
 			if (*level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
 				*level = hwmgr->saved_dpm_level;
 			hwmgr->en_umd_pstate = false;
-			amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
-					AMD_IP_BLOCK_TYPE_GFX,
-					AMD_CG_STATE_GATE);
-			amdgpu_device_ip_set_powergating_state(hwmgr->adev,
-					AMD_IP_BLOCK_TYPE_GFX,
-					AMD_PG_STATE_GATE);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1edc71dde3e4..e25b3b6fd22d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1681,12 +1681,6 @@ static int smu_enable_umd_pstate(void *handle,
 			smu_dpm_ctx->saved_dpm_level = smu_dpm_ctx->dpm_level;
 			smu_dpm_ctx->enable_umd_pstate = true;
 			smu_gpo_control(smu, false);
-			amdgpu_device_ip_set_powergating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_PG_STATE_UNGATE);
-			amdgpu_device_ip_set_clockgating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_CG_STATE_UNGATE);
 			smu_gfx_ulv_control(smu, false);
 			smu_deep_sleep_control(smu, false);
 			amdgpu_asic_update_umd_stable_pstate(smu->adev, true);
@@ -1700,12 +1694,6 @@ static int smu_enable_umd_pstate(void *handle,
 			amdgpu_asic_update_umd_stable_pstate(smu->adev, false);
 			smu_deep_sleep_control(smu, true);
 			smu_gfx_ulv_control(smu, true);
-			amdgpu_device_ip_set_clockgating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_CG_STATE_GATE);
-			amdgpu_device_ip_set_powergating_state(smu->adev,
-							       AMD_IP_BLOCK_TYPE_GFX,
-							       AMD_PG_STATE_GATE);
 			smu_gpo_control(smu, true);
 		}
 	}
-- 
2.29.0

