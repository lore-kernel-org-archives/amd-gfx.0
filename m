Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB737D5C0E2
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Nov 2024 05:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E28B10E13C;
	Sat,  9 Nov 2024 05:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g8VQV4uE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B00E10E13C
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Nov 2024 05:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYBBlhYPb76IYFDSQ9QBoMT8K/ZO4lEMxzcoO7eQGYbaPgFKI83bPNm8X+pR3rqbBb7+rTB3+o6XN6f5YBSPxfS6u18cdlIJIp0EBNf/DnfHkdWzQSaFlc+8QXP2Ce1/h6XbNZtwStkjscFPUCNhC4a57JjU0Tw7AvsCzqDFr61OvPEG/icffib0C+uCKNgO/V+b50M0mPku8WHDXHEXkGRKYm4eKJ2y2hsETAVml1jmARtou+YSdT/ocxteeg7/rqoPC+D5AhmSGS3ikKsLwczx4MEOQC8w04tt1ZQcsIGDmn+MbXljkozjjlaIykywfjisYtsRXzwu5HoCJ+2b4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OgOWO5iN4NJYBAhH4RcrrX+m0u8UIiHifOHHgJGCGE=;
 b=CvPKWQpDrNRs6TdAS7aeDuNToBurn+sSIzXPz+76oBo+Zyro3qdpddbjk+4mJ+Bb+T6OaRuo0P/egGnmG4KH43X9YIpAfPBRnjQYD74gUXEa+yV8JfkLevNBirIiPt6MuVmjxR2G0TyJ/RrqwMWE8S+2XPpXwStQayl9pE1R2vPIlyWCoObK6Yxr0iZ5uV44iaMp9SudlCLkTm67kPB2WDqUGeQ/0XwmE66k9uKTyFhzNWcNNUWGVckGiuDPgGC8miUxt8KnZc5+7Fng/JE4riB348wI6+h+owrEGSdphICzDKA9BwVRUNsWSXwx0RYtsSgMGejVDD9SdVZDCOhvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OgOWO5iN4NJYBAhH4RcrrX+m0u8UIiHifOHHgJGCGE=;
 b=g8VQV4uEK2EbMyZPw6dJ60L/f/vIDLwXAOuRZQrvi4Vb9dgunGyPLYtDHBK/kQUaJHIAzKDqVEa/Pj9IOT51y7UGrjmW94I976prSXZM1ykQxJ3zBCk7ZCRwLOTdeIIHf8QAOmtzi2gMxMZWyxb+cTYBB8eitpL+PyBImGIOm/M=
Received: from BN0PR04CA0143.namprd04.prod.outlook.com (2603:10b6:408:ed::28)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Sat, 9 Nov
 2024 05:32:24 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::ca) by BN0PR04CA0143.outlook.office365.com
 (2603:10b6:408:ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Sat, 9 Nov 2024 05:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 05:32:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 23:32:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/pm: fix and simplify workload handling
Date: Sat, 9 Nov 2024 00:31:48 -0500
Message-ID: <20241109053148.13617-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cda77df-5590-4c22-dcdd-08dd007fe41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J48vpjXXVEffdQEzBfIu8Yar6jn+o7uXV7GUAnB+rlHWfoTFjlr23vou1qXK?=
 =?us-ascii?Q?m2V0tsSYW+BptqpHa7jIr6jZx3m5Gt5ZTIbj7rn33g//nV5BDD+GxWF4IL6v?=
 =?us-ascii?Q?isQ/RfpZVYpQWLlp/om6EfIq7Wf23TjmJa6OJlCnMkyOfLHx4PjvX8Tw9QoQ?=
 =?us-ascii?Q?M+eek7JfwtRFMbDaNMt25Uy2QY/PPag7vW20B8EqI7mrlwC5HoF03oS7W+/w?=
 =?us-ascii?Q?9q/GNJEb2jYCgISpu6AkQFZX518uqvK+d1sVOpAkrXYpRulzsyL9t0dqJ7KW?=
 =?us-ascii?Q?tQGCWobu0+3DSxswlstuyGN3c2TsZ6lDl6pyWlWGWY/S8IFYFpJNwYN5jYCn?=
 =?us-ascii?Q?Szb3ToiA8NQV3X58Q8EtPKZaocTpX5hoSdJecOKHYvDT3WG2FTw1fAwFzWf/?=
 =?us-ascii?Q?MISoLi/qipMBmJyho0ndJ7tW0DObJCcyDGgQl81JDaSOpYBWEUpFqQIjrsUB?=
 =?us-ascii?Q?seNC0JBUuv7cXK0t6gtiQWLaeCN43jBM37wghMNBoSAmnHcL/+DWUABttrkS?=
 =?us-ascii?Q?tkz7xRG3chsIeKCIwFGr1NQf5D4H4IKUQoJS9aFzbRG920kUsFUE7+WcjJ9z?=
 =?us-ascii?Q?PAO95KAzJf+JAzA8Bp0PLKfAIdYzc1uQe+2MzBbJD+41RFzNBSNUtgFHu7YJ?=
 =?us-ascii?Q?A9ZhCK0M2xW7r4mwtKfdBKwAgQ+Bh8GCfx7CyZRfT3yO3EXbmg6FJnm5fsF5?=
 =?us-ascii?Q?aavO3HnbROhBuqY28FW6Ejc6PXBF7VjMAWXrlT60whKjzKVs06td5E76Ku3s?=
 =?us-ascii?Q?nGVRh3fXFgTMPutGZR4k4A5UDezWTJf0NchSZ5nb3WfPyVKuIZeH4op+Vmkp?=
 =?us-ascii?Q?m2UqXTaEjUCWTs//jjBluD3KTYTedWnixYFr/nLjqilWERZHNGOEquL5TKlj?=
 =?us-ascii?Q?Gzvd5YQnV1HygY4mehfvQVVU1RPehjl0OOwcLTwRwIL4k6gcEt2mG7vT5+AO?=
 =?us-ascii?Q?ehEqdLP6L2FVlv0J+5ASnJg5zhn5q9Hy9WTrazURoYzVaQyXE59oQHIg1IUK?=
 =?us-ascii?Q?9phivRCfeekigucJm9qHPwfIQi9jTLK74DxUBvehuDdxpISeJBfCi4DuhgzE?=
 =?us-ascii?Q?XEgZ3MMFI+Xs8U1LieJoTEQBVsuddPwI5JB+EhZOoy6g1o9idwyU/n0rgBVk?=
 =?us-ascii?Q?HhHpOiuxwuVgDaL0+TCe1FjvGm2zPxnLDAX/AjtDmw0byMQZd7PMvC3PRIR6?=
 =?us-ascii?Q?kdu4JRruwXaFI/03Q8AL7mGo1V6aWA7qVSBFZGAO+XHgD55W40nUdipLpoz0?=
 =?us-ascii?Q?lTI5mkNrBnBVtZo9qwXzvjFNG+xoouszj6mswhOTxbRe7j9DQBQD5DG2xtOk?=
 =?us-ascii?Q?60HLxc8p3E3CrdujC6SmzQF7ef6RGKVy+yTujTPM9bNgCaIcWn4ihU0k3iIc?=
 =?us-ascii?Q?wRI1wZ+MYH9SzLegHpF6ssIBQnzTYqp0wBMSPApGnvSAm4KMIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 05:32:24.3575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cda77df-5590-4c22-dcdd-08dd007fe41b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
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

smu->workload_mask is IP specific and should not be messed with in
the common code. The mask bits vary across SMU versions.

Move all handling of smu->workload_mask in to the backends and
simplify the code.  Store the user's preference in smu->power_profile_mode
which will be reflected in sysfs.  For internal driver profile
switches for KFD or VCN, just update the workload mask so that the
user's preference is retained.  Remove all of the extra now unused
workload related elements in the smu structure.

Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 108 ++++++------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  11 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  20 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  20 ++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  21 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  17 +--
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  17 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  33 +++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 ++--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  24 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   8 --
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 -
 12 files changed, 132 insertions(+), 170 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c3a6b6f20455..162a3289855c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1268,9 +1268,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
 	atomic64_set(&smu->throttle_int_counter, 0);
 	smu->watermarks_bitmap = 0;
-	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->user_dpm_profile.user_workload_mask = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
@@ -1278,33 +1275,12 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
-
 	if (smu->is_apu ||
-	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
-		smu->driver_workload_mask =
-			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
-	} else {
-		smu->driver_workload_mask =
-			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
-		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-	}
-
-	smu->workload_mask = smu->driver_workload_mask |
-							smu->user_dpm_profile.user_workload_mask;
-	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
-	smu->workload_setting[3] = PP_SMC_POWER_PROFILE_VIDEO;
-	smu->workload_setting[4] = PP_SMC_POWER_PROFILE_VR;
-	smu->workload_setting[5] = PP_SMC_POWER_PROFILE_COMPUTE;
-	smu->workload_setting[6] = PP_SMC_POWER_PROFILE_CUSTOM;
+	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+	else
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+
 	smu->display_config = &adev->pm.pm_display_cfg;
 
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
@@ -2252,24 +2228,23 @@ static int smu_enable_umd_pstate(void *handle,
 }
 
 static int smu_bump_power_profile_mode(struct smu_context *smu,
-					   long *param,
-					   uint32_t param_size)
+				       long *param,
+				       uint32_t param_size,
+				       bool enable)
 {
 	int ret = 0;
 
 	if (smu->ppt_funcs->set_power_profile_mode)
-		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
+		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size, enable);
 
 	return ret;
 }
 
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 					  enum amd_dpm_forced_level level,
-					  bool skip_display_settings,
-					  bool init)
+					  bool skip_display_settings)
 {
 	int ret = 0;
-	int index = 0;
 	long workload[1];
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
@@ -2307,13 +2282,10 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	}
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
-		index = fls(smu->workload_mask);
-		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
+	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
+		workload[0] = smu->power_profile_mode;
 
-		if (init || smu->power_profile_mode != workload[0])
-			smu_bump_power_profile_mode(smu, workload, 0);
+		smu_bump_power_profile_mode(smu, workload, 0, true);
 	}
 
 	return ret;
@@ -2333,13 +2305,13 @@ static int smu_handle_task(struct smu_context *smu,
 		ret = smu_pre_display_config_changed(smu);
 		if (ret)
 			return ret;
-		ret = smu_adjust_power_state_dynamic(smu, level, false, false);
+		ret = smu_adjust_power_state_dynamic(smu, level, false);
 		break;
 	case AMD_PP_TASK_COMPLETE_INIT:
-		ret = smu_adjust_power_state_dynamic(smu, level, true, true);
+		ret = smu_adjust_power_state_dynamic(smu, level, true);
 		break;
 	case AMD_PP_TASK_READJUST_POWER_STATE:
-		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
+		ret = smu_adjust_power_state_dynamic(smu, level, true);
 		break;
 	default:
 		break;
@@ -2361,12 +2333,11 @@ static int smu_handle_dpm_task(void *handle,
 
 static int smu_switch_power_profile(void *handle,
 				    enum PP_SMC_POWER_PROFILE type,
-				    bool en)
+				    bool enable)
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	long workload[1];
-	uint32_t index;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -2374,24 +2345,15 @@ static int smu_switch_power_profile(void *handle,
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
 		return -EINVAL;
 
-	if (!en) {
-		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
-		index = fls(smu->workload_mask);
-		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-	} else {
-		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
-		index = fls(smu->workload_mask);
-		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-	}
+	/* don't disable the user's preference */
+	if (!enable && type == smu->power_profile_mode)
+		return 0;
 
-	smu->workload_mask = smu->driver_workload_mask |
-						 smu->user_dpm_profile.user_workload_mask;
+	workload[0] = type;
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
-		smu_bump_power_profile_mode(smu, workload, 0);
+	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
+		smu_bump_power_profile_mode(smu, workload, 0, enable);
 
 	return 0;
 }
@@ -3090,21 +3052,25 @@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
-	int ret;
+	long workload[1];
+	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	if (smu->user_dpm_profile.user_workload_mask &
-	   (1 << smu->workload_priority[param[param_size]]))
-	   return 0;
-
-	smu->user_dpm_profile.user_workload_mask =
-		(1 << smu->workload_priority[param[param_size]]);
-	smu->workload_mask = smu->user_dpm_profile.user_workload_mask |
-		smu->driver_workload_mask;
-	ret = smu_bump_power_profile_mode(smu, param, param_size);
+	if (param[param_size] != smu->power_profile_mode) {
+		/* clear the old user preference */
+		workload[0] = smu->power_profile_mode;
+		ret = smu_bump_power_profile_mode(smu, workload, 0, false);
+		if (ret)
+			return ret;
+		/* set the new user preference */
+		ret = smu_bump_power_profile_mode(smu, param, param_size, true);
+		if (!ret)
+			/* store the user's preference */
+			smu->power_profile_mode = param[param_size];
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index fa93a8879113..cd2db06d752b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
 	/* user clock state information */
 	uint32_t clk_mask[SMU_CLK_COUNT];
 	uint32_t clk_dependency;
-	uint32_t user_workload_mask;
 };
 
 #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
@@ -557,12 +556,10 @@ struct smu_context {
 	uint32_t hard_min_uclk_req_from_dal;
 	bool disable_uclk_switch;
 
+	/* backend specific workload mask */
 	uint32_t workload_mask;
-	uint32_t driver_workload_mask;
-	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
-	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
+	/* default/user workload preference */
 	uint32_t power_profile_mode;
-	uint32_t default_power_profile_mode;
 	bool pm_enabled;
 	bool is_apu;
 
@@ -734,8 +731,10 @@ struct pptable_funcs {
 	 *                          create/set custom power profile modes.
 	 * &input: Power profile mode parameters.
 	 * &size: Size of &input.
+	 * &enable: enable/disable the profile
 	 */
-	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
+	int (*set_power_profile_mode)(struct smu_context *smu, long *input,
+				      uint32_t size, bool enable);
 
 	/**
 	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4b36c230e43a..1e44cf6fec4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1443,7 +1443,8 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 
 static int arcturus_set_power_profile_mode(struct smu_context *smu,
 					   long *input,
-					   uint32_t size)
+					   uint32_t size,
+					   bool enable)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
 	int workload_type = 0;
@@ -1455,8 +1456,9 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
-	     (smu->smc_fw_version >= 0x360d00)) {
+	if (enable &&
+	    (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
+	    (smu->smc_fw_version >= 0x360d00)) {
 		if (size != 10)
 			return -EINVAL;
 
@@ -1520,18 +1522,18 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 		return -EINVAL;
 	}
 
+	if (enable)
+		smu->workload_mask |= (1 << workload_type);
+	else
+		smu->workload_mask &= ~(1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetWorkloadMask,
 					  smu->workload_mask,
 					  NULL);
-	if (ret) {
+	if (ret)
 		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
-		return ret;
-	}
-
-	smu_cmn_assign_power_profile(smu);
 
-	return 0;
+	return ret;
 }
 
 static int arcturus_set_performance_level(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 211635dabed8..d944a9f954d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2006,19 +2006,19 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 	return size;
 }
 
-static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int navi10_set_power_profile_mode(struct smu_context *smu, long *input,
+					 uint32_t size, bool enable)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
 	int workload_type, ret = 0;
+	uint32_t profile_mode = input[size];
 
-	smu->power_profile_mode = input[size];
-
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
+		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		if (size != 10)
 			return -EINVAL;
 
@@ -2080,16 +2080,18 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
+						       profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
 
+	if (enable)
+		smu->workload_mask |= (1 << workload_type);
+	else
+		smu->workload_mask &= ~(1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    smu->workload_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 844532a9b641..4967e087088b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1704,22 +1704,23 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 	return size;
 }
 
-static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
+						 long *input, uint32_t size,
+						 bool enable)
 {
 
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
+	uint32_t profile_mode = input[size];
 	int workload_type, ret = 0;
 
-	smu->power_profile_mode = input[size];
-
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
+		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		if (size != 10)
 			return -EINVAL;
 
@@ -1781,16 +1782,18 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
+						       profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
 
+	if (enable)
+		smu->workload_mask |= (1 << workload_type);
+	else
+		smu->workload_mask &= ~(1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    smu->workload_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f89c487dce72..b5dba4826f81 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1056,7 +1056,8 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
+					  uint32_t size, bool enable)
 {
 	int workload_type, ret;
 	uint32_t profile_mode = input[size];
@@ -1067,7 +1068,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 	}
 
 	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
+	    profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
 		return 0;
 
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
@@ -1080,18 +1081,18 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 		return -EINVAL;
 	}
 
+	if (enable)
+		smu->workload_mask |= (1 << workload_type);
+	else
+		smu->workload_mask &= ~(1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
 				    smu->workload_mask,
 				    NULL);
-	if (ret) {
+	if (ret)
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
 					workload_type);
-		return ret;
-	}
-
-	smu_cmn_assign_power_profile(smu);
 
-	return 0;
+	return ret;
 }
 
 static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 75a9ea87f419..2d1eae79ab9d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -864,7 +864,8 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int renoir_set_power_profile_mode(struct smu_context *smu, long *input,
+					 uint32_t size, bool enable)
 {
 	int workload_type, ret;
 	uint32_t profile_mode = input[size];
@@ -875,7 +876,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 	}
 
 	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
+	    profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
 		return 0;
 
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
@@ -891,17 +892,17 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 		return -EINVAL;
 	}
 
+	if (enable)
+		smu->workload_mask |= (1 << workload_type);
+	else
+		smu->workload_mask &= ~(1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
 				    smu->workload_mask,
 				    NULL);
-	if (ret) {
+	if (ret)
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
-		return ret;
-	}
 
-	smu_cmn_assign_power_profile(smu);
-
-	return 0;
+	return ret;
 }
 
 static int renoir_set_peak_clock_by_device(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 80c6b1e523aa..3cc734331891 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2573,22 +2573,22 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
 
 static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 					      long *input,
-					      uint32_t size)
+					      uint32_t size,
+					      bool enable)
 {
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
+	uint32_t profile_mode = input[size];
 	int workload_type, ret = 0;
 	u32 workload_mask;
 
-	smu->power_profile_mode = input[size];
-
-	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
+		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		if (size != 9)
 			return -EINVAL;
 
@@ -2641,13 +2641,18 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
+						       profile_mode);
 
 	if (workload_type < 0)
 		return -EINVAL;
 
 	workload_mask = 1 << workload_type;
 
+	if (enable)
+		smu->workload_mask |= workload_mask;
+	else
+		smu->workload_mask &= ~workload_mask;
+
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
 	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
 	     ((smu->adev->pm.fw_version == 0x004e6601) ||
@@ -2658,25 +2663,13 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       PP_SMC_POWER_PROFILE_POWERSAVING);
 		if (workload_type >= 0)
-			workload_mask |= 1 << workload_type;
+			smu->workload_mask |= 1 << workload_type;
 	}
 
-	smu->workload_mask |= workload_mask;
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
 					       smu->workload_mask,
 					       NULL);
-	if (!ret) {
-		smu_cmn_assign_power_profile(smu);
-		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
-			workload_type = smu_cmn_to_asic_specific_index(smu,
-							       CMN2ASIC_MAPPING_WORKLOAD,
-							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
-			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
-										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
-										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-		}
-	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c5d3e25cc967..1aafd23857f0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2528,22 +2528,23 @@ do {													\
 	return result;
 }
 
-static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
+					      long *input, uint32_t size,
+					      bool enable)
 {
 
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
+	uint32_t profile_mode = input[size];
 	int workload_type, ret = 0;
 
-	smu->power_profile_mode = input[size];
-
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+	if (profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
+		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		if (size != 8)
 			return -EINVAL;
 
@@ -2590,17 +2591,19 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
+						       profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
 
+	if (enable)
+		smu->workload_mask |= (1 << workload_type);
+	else
+		smu->workload_mask &= ~(1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    smu->workload_mask, NULL);
 
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 59b369eff30f..695480833603 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1719,21 +1719,22 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
 
 static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 					      long *input,
-					      uint32_t size)
+					      uint32_t size,
+					      bool enable)
 {
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
+	uint32_t profile_mode = input[size];
 	int workload_type, ret = 0;
 	uint32_t current_profile_mode = smu->power_profile_mode;
-	smu->power_profile_mode = input[size];
 
-	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
+		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		if (size != 9)
 			return -EINVAL;
 
@@ -1783,7 +1784,7 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 		}
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
+	if (profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
 		smu_v14_0_deep_sleep_control(smu, false);
 	else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
 		smu_v14_0_deep_sleep_control(smu, true);
@@ -1791,15 +1792,16 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
+						       profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
 
+	if (enable)
+		smu->workload_mask |= (1 << workload_type);
+	else
+		smu->workload_mask &= ~(1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-										  smu->workload_mask, NULL);
-
-	if (!ret)
-		smu_cmn_assign_power_profile(smu);
+					      smu->workload_mask, NULL);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index fd2aa949538e..63c4f75fa118 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
-void smu_cmn_assign_power_profile(struct smu_context *smu)
-{
-	uint32_t index;
-	index = fls(smu->workload_mask);
-	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-	smu->power_profile_mode = smu->workload_setting[index];
-}
-
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
 {
 	struct pci_dev *p = NULL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 8a801e389659..1de685defe85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state);
 
-void smu_cmn_assign_power_profile(struct smu_context *smu);
-
 /*
  * Helper function to make sysfs_emit_at() happy. Align buf to
  * the current page boundary and record the offset.
-- 
2.47.0

