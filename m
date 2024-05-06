Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1977C10F16
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 09:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289EF10EB15;
	Mon,  6 May 2024 09:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JH5dZvs3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C90310EBCD
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 09:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAJlL9NxGHkNktp54JPN7+FdPAbkifKVgNZ1+Ecv2KHfECwb5wkyBWj0jtvtA0eVGDA0ak2zElJuBdr7lZgy0wAhboKKefKZsph/pBko25voXPFUscsZtjg7rjSbgxwyns9SHgx0C9stdm7DRo9T4zhfjOkTM9yjiRMMu4Fb+108U2b8QrQUXc3nOad743t+p+tEFsdwJKA4HlOhkEUYuRNheBgDJsj3k5isqcD2uKau8YHIGsFo8GT2kUDTtXQoYF6dkfXRb8Uw+wwyVTNKv2FH9vpVXZ8Ng/aXOkXeA9zAxnANa4/Q2K7Ef92O3y1IOt1Tey+huPkn5aCXeIZdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbFTtp0eqJFBcSppqyLPAcA39AW3uSO1yxlxC2Qf+Pc=;
 b=m3xVqA3dGYUx7yAe1znlbbJKmL4G/PygM3U08SYwEPigDbMZ5lLDe8FznCtimpKbC7nj88o+eCAumrJdDfoyzRaxwtUr0l432GgJptTP4yz24Fc93FNAbu8i08cIL+MIwFbcHQgl916o7/i0COIBRbAIgtOsJhenM1/jX+NuApcEUNQBTSbY6glMP1gy73L0ZatjL2/AI+oAtZpPJ5ktr2eIszcmhlEnkqt8gephtGTXKYAYPUIDt7FQuESk3OPng0ycENGLLdhT2Vt0Dp8DsH5i44tNAj1NcIARl0GX+jlUXbZj5bZN7F1lccCf/5hIWlOXg6fvkc2tCJisOXT4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbFTtp0eqJFBcSppqyLPAcA39AW3uSO1yxlxC2Qf+Pc=;
 b=JH5dZvs3WMdpFNJ8NnnSbtC1iijJF7S+w8FmfZLJ+tPB0fgaARzcFq+UX4tKgRVWYoGk6heiXAYmzGSAH+x65qMPsYSAGhDF8O4z+huDM2qNWeBIl7lGpdhKjrOckD/CFMMmOpQBHuogj5ltBYb32NvR/Vs53IGAos40HsgTeL4=
Received: from SA1P222CA0132.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::15)
 by PH0PR12MB8822.namprd12.prod.outlook.com (2603:10b6:510:28d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 09:57:06 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::f3) by SA1P222CA0132.outlook.office365.com
 (2603:10b6:806:3c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 09:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 09:57:06 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 04:57:03 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/pm: Fix the param type of
 set_power_profile_mode
Date: Mon, 6 May 2024 17:56:30 +0800
Message-ID: <20240506095630.258594-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506095630.258594-1-Jun.Ma2@amd.com>
References: <20240506095630.258594-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|PH0PR12MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebd14a5-f4ae-423e-747b-08dc6db2e375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lAygJ/uHlJhXW6Eme+jXltfLLVGbawPvDfppowETpi+9G2C7VsaMCGrOcHM3?=
 =?us-ascii?Q?fKT0WiRqy0E411MgdMKqx7oesIGosKhm9RvSEwE3BJ6Zxjdzp+XZcs6S4UjC?=
 =?us-ascii?Q?AkrGtKMrXzF08A6ER1KTzhrigrQ32WGy+Or+hQj51silfR7micfVOGUB6hYP?=
 =?us-ascii?Q?vqeFAEHdco9C1h8Zg0nNr6MO3pz6V3ArLBy3CBI5WZGrbjWlUp7t2faA1Udg?=
 =?us-ascii?Q?eNWNzkeU8R6SEscQjvS8nZSo7c9zivlT/4V70iIeDC8yjttDVRbNpmkebki4?=
 =?us-ascii?Q?5/oU/j0Cxb/hPoE/TqUM/uEqtlioCMwq15BiZGdYWd7Lp9ApLX7IgI/3CLo+?=
 =?us-ascii?Q?n77ybBWyt6bpgSp0qUZUQZvQAhle2r6Xj1WX96u665cF5pb0IslMFw/JaTKf?=
 =?us-ascii?Q?DxwxwlfXhHBSR0sKCyeV/SaECEW82NhNgqaGBXOpw/I6yLnbT1kFrQsRiPUY?=
 =?us-ascii?Q?HgbmDSIFEuXsVct7JSInvW7nx1UbLSI6YQFFfODBJudIfy5O/i5qEW5fp4Bb?=
 =?us-ascii?Q?P7NbaRE5ax93n0Yz8s+mCxtYq3uaytjlicIGVDovKHUhypOVYXvv7VETs0Ap?=
 =?us-ascii?Q?lBCJ++Jg3IeofAaZgofbCN8MrUnhTaXH0x+yngbEjJ3+qLDFCMklD6mzJwz5?=
 =?us-ascii?Q?wH6Ox1fHak4NvNO6R7Dq0lfWEYNhCrGJFu3b4Zt6bUqHsUAPXdpH7rkM7c5v?=
 =?us-ascii?Q?sie2GWt28VVxNoP4CUFRUQWx1dqzb4tzU+T3nFKaDi4VOYk/TYRERgd60SSo?=
 =?us-ascii?Q?vIgtFQZT+xyWScKMTFD689AlpEh+p5prqUmil8g6AOxbYkCjXvUluEik0DQk?=
 =?us-ascii?Q?UvfmNgaTaJoQKHWP+UTAuB6k4MVdgi7CB/EdTBHyE+SlgigsFqd2fMn4vGo+?=
 =?us-ascii?Q?yPxMqFU0syEe0ZC1ybSR5n2PVHriRr2TSTPF8WqHBeUq92AoAsoxwxEb9QtT?=
 =?us-ascii?Q?Dn9DPbwssgOzqwlfeKbeaO2TY3ixwAJ4u8rht8eL7xIW8LS7SwWmuDZ4Jl0M?=
 =?us-ascii?Q?P8CVb+x0Nt/H/EWQBUdygiPq077ctRX7rnHrFzvVRnO4j0O6pgO/FLxsI/7+?=
 =?us-ascii?Q?1HN4CMXZVVkuv82QwLYeGOqFbksMukWnExZMs6PYDLGkPNpZMr8oJFSGiW12?=
 =?us-ascii?Q?sTk0lp7Iwf5IxWa3T50F1/quFJSR8dD6Cb2w335yA7/JtnxkuTDYhc9KaWOX?=
 =?us-ascii?Q?7fKeFxdZOEf0sVMbpjz7g7WGUqF7n8UaqeVq4EXkzDekmi/8m5rhTP4flh/E?=
 =?us-ascii?Q?IwruyWtvm0mriH9Ax1hzjrW3WHGfll5N3iy4ZT1p/B70iLwGNZyYhajn70OF?=
 =?us-ascii?Q?docvRR9f++RSoMb2PrXqU8CF3TOMbye1JfVerTpPLhov7TRypHJIhGY+UK4k?=
 =?us-ascii?Q?xohHGAA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 09:57:06.6718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebd14a5-f4ae-423e-747b-08dc6db2e375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8822
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

Function .set_power_profile_mode need an array as input
parameter. So define variable workload as an array to fix
the below coverity warning.

"Passing &workload to function hwmgr->hwmgr_func->set_power_profile_mode
which uses it as an array. This might corrupt or misinterpret adjacent
memory locations"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  8 ++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c  |  8 ++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 16 ++++++++--------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 1c40a362d5ab..a71c6117d7e5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -929,7 +929,7 @@ static int pp_dpm_switch_power_profile(void *handle,
 		enum PP_SMC_POWER_PROFILE type, bool en)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	long workload;
+	long workload[1];
 	uint32_t index;
 
 	if (!hwmgr || !hwmgr->pm_en)
@@ -947,12 +947,12 @@ static int pp_dpm_switch_power_profile(void *handle,
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
@@ -962,7 +962,7 @@ static int pp_dpm_switch_power_profile(void *handle,
 	}
 
 	if (hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL)
-		hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
+		hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, workload, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
index 1d829402cd2e..f4bd8e9357e2 100644
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
index dc0d3a9f1d6d..e61aa4418d44 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2210,7 +2210,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 {
 	int ret = 0;
 	int index = 0;
-	long workload;
+	long workload[1];
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (!skip_display_settings) {
@@ -2250,10 +2250,10 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
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
@@ -2303,7 +2303,7 @@ static int smu_switch_power_profile(void *handle,
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	long workload;
+	long workload[1];
 	uint32_t index;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2316,17 +2316,17 @@ static int smu_switch_power_profile(void *handle,
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
2.34.1

