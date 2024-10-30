Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C71D74963
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 05:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCC010E07F;
	Wed, 30 Oct 2024 05:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y/wokCXq";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71E110E07F
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 05:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEsg3cBOot32giUREI66KOXfSLOIVS8WhRUb6GijIERe2mPyV0i2Rnhck1SCR+FBYtZinq+nMEqKccAI6O0kOmFKp51wijtmrV9zPSpb98feUGXB6GAX5VYyscTmRazJy6iql9cpHF+JxUl8Rmc3urZg9L5/Uin+Qk6fOJY5//54joUzQRVRNjAV+FdL+JEEuydsCp5LrI1jNNAj1GtJKBAooRuM6oJUWKKI6oWXgoDfv6i7I1kC3QSp03AUlSk/BPgKxTB1NKzvqYLfG1bAcldU0SljHp9XFqJOXOa/SktW4hWU3mncpa4suIwcKZrb4TcLFYmyN0KQu/+q8gmyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJJx7OZW3zO7kfWEtlZF5CnP1ZPUQBCzM2mqO2BCaBM=;
 b=HRDsvcsxJxWai6sCPFiHbfoFP0NzhZAFneaFISuTkAeV0yZOX+fFR+SPzV6zXTfKA60WhyCM+1pgDmIMefSLPvyeQstcR0MpaMaP5NIkDmgRJ3IobiaJJt3n3RL9Pu1Qw17Ggr5YkInFuRUYkqR9tJTFRrs8F9LU30dyuHaIX2NOmEAYTkfW8PXhERHB38xWUeKPwOKx2McGzpYEDhjZ/abK9nCIksXeRbgFRllbDn4jk31AFA2phFKCuQyM97Vr7tCVhnAf3ooDwy3G3+3PCREh7gBphVFJ5VZZgtTvcw4yBQQxpw2OWrMiCXz67XDbrCFEOuCo5yAj6ZpEvhqC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJJx7OZW3zO7kfWEtlZF5CnP1ZPUQBCzM2mqO2BCaBM=;
 b=Y/wokCXqgFlo4xxoYFIhYeK568Ugr7IbbNVY4huPn59wevNOL3XJmWJ50ofyQg/6mybzhYo2OEIQQvKLcDli6ZJrf8hYzlgOTNAtOxs3QvrCM1IONk+P7cxP3LRPTKRiJUjUa4lN0KtPk9vh7EK1jUVg5GFTNDeoYzh3mNUeexU=
Received: from SA0PR11CA0151.namprd11.prod.outlook.com (2603:10b6:806:1bb::6)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 05:25:53 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::3f) by SA0PR11CA0151.outlook.office365.com
 (2603:10b6:806:1bb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 05:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 05:25:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 00:25:51 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 30 Oct 2024 00:25:49 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <Alexander.Deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH v3] drm/amd/pm: correct the workload setting
Date: Wed, 30 Oct 2024 13:25:46 +0800
Message-ID: <20241030052546.45020-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a817af9-095e-4759-ad7e-08dcf8a35265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YWQoMaZX+9p13JeGR54yqi+qCy05kALiLGizTMgPsKr+RF8HV3HngszaPlfG?=
 =?us-ascii?Q?Su2v4+YTQqJXI/GY/lFyUYaWFhczOE3Ae8wXRUFxBRgK3a6Rop9AUJvrM6jp?=
 =?us-ascii?Q?d80fCyXsmhrwnlZWkKO8ywpHh/d2IY0/PqwEjZaW/7GWcccfaivUG0o92Qo9?=
 =?us-ascii?Q?GCofrtnw6l90G3PCXpLD5KA/sYBeH6/YuqL2FJDuW/tV1oiZJ9uMSBAsbWNM?=
 =?us-ascii?Q?6uTPNXHy7JyTyQcdpPtA/NOqoYHbqXQh/ToOYGlOclL9h52hIvI5saoveN6C?=
 =?us-ascii?Q?khttsszHn+5sFsaWIdsWlmBqfzvcm553XhPLDDaEvtRoCg7oz0sw9YjSo/6l?=
 =?us-ascii?Q?yapA0UfuFbyFgbxJ/PSVCp4pJP6NYcJ/6d8ufDk/uZXZUaEGpfprUEKuOtCi?=
 =?us-ascii?Q?QIwJlB1NlXi0v5tEukbX4OY27yKE5w+r84sba6MK2Io9QyXgqqEKScA6wFxP?=
 =?us-ascii?Q?8jHYsEva7EkoKWMmPKZ9dyY2raGidZqfAJG6ENce5Xmr8sZDfsc3qNLxIqFu?=
 =?us-ascii?Q?bT3llbZzFDsNi9Hy/L/TaVlM5E5fRcLtcIYq52o4x40YGKOJeB7HlMbu/PUI?=
 =?us-ascii?Q?t9ERvL+ss5gCjNXBgH36kxhcMrjyKZavzRxWD3VbmuRG7aLJ9SO1c7HC0nxK?=
 =?us-ascii?Q?h3HdZF9C7loZ2zjciFFdx6ODwrQA4QkQgJrSL0xWiOfq4GlwC36ZikbbtyXb?=
 =?us-ascii?Q?Vh5oKcJeHzHT+4UYZAJK3mAZb+/DfvRq4r3EWvaishSPgF2cPDfIqERrUbnQ?=
 =?us-ascii?Q?JDVgHyY2krctlc5WjA4MrqH40WNWsmLS+ixeiEFRF+dJwNBKxD0Fr0/DGROe?=
 =?us-ascii?Q?Qvzq3JguzQ+Ctn1/0SO8BzduWpXTuZuOsKZhIZJoRpJK/ha1nET+bJ2gbJGn?=
 =?us-ascii?Q?8jMO7SxGLp151NxRGaSZ1orKi1ouzCJJprgdcCvQmVkGplgVTfRaRsn0bXCu?=
 =?us-ascii?Q?FedgrakXB9ErWg+Sp6/V6Ge5/PCj5J/o13ex3ypr/LiwtIjoz3q95d+sOs1l?=
 =?us-ascii?Q?lPDahhrO6NOCCiRfViM2McFJuwHpJM4Obx7YfK2OkEpDJagtBkEIBeNALkDS?=
 =?us-ascii?Q?4Tch4D9jf67llkUPu2wQtm/O3gcOCAjGOusc6yU6Dm76U81Je7W81u7TwUGF?=
 =?us-ascii?Q?Ef8qEftnmr/FKpchgySka1/6xDQNxFQnTdNoi2QOhcn6tLGh9Ib/bEG1bR5V?=
 =?us-ascii?Q?O1KyabmvarJIy/2jaZdG/IEqLfFL5xwFId+d2b47Dt4w1Ulqla1HRa4eyZXm?=
 =?us-ascii?Q?b+9QVB1t6Jb6F+LI3dV0As1+uWeJc6D59XhedDVXnP8+3MBJWgXYYdnU6nGR?=
 =?us-ascii?Q?VKLQ0Itksj0l0VkJkIFOLHf8Y6pNLDUwEIWRSjp3yy3UvIgvaUgQpfdKHP2Q?=
 =?us-ascii?Q?st15Dfd0Op5jLYHmba226jPaGbpYzou0JoNOU7uxC4CIQ8g4tQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:25:52.4739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a817af9-095e-4759-ad7e-08dcf8a35265
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
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

Correct the workload setting in order not to mix the setting
with the end user. Update the workload mask accordingly.

v2: changes as below:
1. the end user can not erase the workload from driver except default workload.
2. always shows the real highest priority workoad to the end user.
3. the real workload mask is combined with driver workload mask and end user workload mask.

v3: apply this to the other ASICs as well.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 43 +++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 19 +++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 23 +++++++++-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 23 +++++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 20 ++++++++-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 20 ++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 31 +++++++++++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 25 +++++++++--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 28 +++++++++---
 10 files changed, 202 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8d4aee4e2287..7d7bf44c4496 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1261,26 +1261,31 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+	smu->user_dpm_profile.user_workload_mask = 0;
+	smu->user_dpm_profile.prev_user_workload_mask = 0;
 
 	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
+	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
 
 	if (smu->is_apu ||
-	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
-	else
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
+	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
+		smu->workload_mask = 1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+	} else {
+		smu->workload_mask = 1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
+		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	}
 
+	smu->driver_workload_mask = smu->workload_mask;
 	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
@@ -2354,12 +2359,14 @@ static int smu_switch_power_profile(void *handle,
 		return -EINVAL;
 
 	if (!en) {
-		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
+		smu->workload_mask &= ~(1 << smu->workload_priority[type]);
+		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 	} else {
-		smu->workload_mask |= (1 << smu->workload_prority[type]);
+		smu->workload_mask |= (1 << smu->workload_priority[type]);
+		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
 		index = fls(smu->workload_mask);
 		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
@@ -3054,12 +3061,20 @@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
+	int ret;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	return smu_bump_power_profile_mode(smu, param, param_size);
+	smu->user_dpm_profile.prev_user_workload_mask =
+			smu->user_dpm_profile.user_workload_mask;
+	smu->user_dpm_profile.user_workload_mask = (1 << smu->workload_priority[param[param_size]]);
+	ret = smu_bump_power_profile_mode(smu, param, param_size);
+	smu->user_dpm_profile.prev_user_workload_mask =
+			smu->user_dpm_profile.user_workload_mask;
+
+	return ret;
 }
 
 static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8bb32b3f0d9c..88294d986b36 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -240,6 +240,8 @@ struct smu_user_dpm_profile {
 	/* user clock state information */
 	uint32_t clk_mask[SMU_CLK_COUNT];
 	uint32_t clk_dependency;
+	uint32_t user_workload_mask;
+	uint32_t prev_user_workload_mask;
 };
 
 #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
@@ -557,7 +559,8 @@ struct smu_context {
 	bool disable_uclk_switch;
 
 	uint32_t workload_mask;
-	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
+	uint32_t driver_workload_mask;
+	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
 	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
 	uint32_t power_profile_mode;
 	uint32_t default_power_profile_mode;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 5ad09323a29d..c0ae36e7c896 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1449,12 +1449,24 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 	int workload_type = 0;
 	uint32_t profile_mode = input[size];
 	int ret = 0;
+	uint32_t index;
 
 	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
+	if (smu->user_dpm_profile.prev_user_workload_mask !=
+		smu->user_dpm_profile.user_workload_mask) {
+		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
+			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
+			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
+
+		if (input[size] != smu->default_power_profile_mode) {
+			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+		}
+	}
 
 	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
 	     (smu->smc_fw_version >= 0x360d00)) {
@@ -1521,16 +1533,19 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 		return -EINVAL;
 	}
 
+	smu->workload_mask |= (1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetWorkloadMask,
-					  1 << workload_type,
+					  smu->workload_mask,
 					  NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
+	index = fls(smu->workload_mask);
+	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+	smu->power_profile_mode = smu->workload_setting[index];
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 9fa305ba6422..e929b882ce60 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2008,9 +2008,22 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
 	int workload_type, ret = 0;
+	uint32_t index;
 
 	smu->power_profile_mode = input[size];
 
+	if (smu->user_dpm_profile.prev_user_workload_mask !=
+		smu->user_dpm_profile.user_workload_mask) {
+		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
+			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
+			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
+
+		if (input[size] != smu->default_power_profile_mode) {
+			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+		}
+	}
+
 	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
@@ -2081,11 +2094,19 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
+	smu->workload_mask |= (1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
 
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+	}
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 77e58eb46328..9f6548039948 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1713,9 +1713,22 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
+	uint32_t index;
 
 	smu->power_profile_mode = input[size];
 
+	if (smu->user_dpm_profile.prev_user_workload_mask !=
+		smu->user_dpm_profile.user_workload_mask) {
+		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
+			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
+			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
+
+		if (input[size] != smu->default_power_profile_mode) {
+			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+		}
+	}
+
 	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
@@ -1786,11 +1799,19 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
+	smu->workload_mask |= (1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
 
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+	}
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 6c43724c01dd..ba8bf369d6d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1058,12 +1058,25 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 {
 	int workload_type, ret;
 	uint32_t profile_mode = input[size];
+	uint32_t index;
 
 	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
+	if (smu->user_dpm_profile.prev_user_workload_mask !=
+		smu->user_dpm_profile.user_workload_mask) {
+		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
+			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
+			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
+
+		if (input[size] != smu->default_power_profile_mode) {
+			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+		}
+	}
+
 	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
 			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
 		return 0;
@@ -1078,8 +1091,9 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 		return -EINVAL;
 	}
 
+	smu->workload_mask |= (1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
+				    smu->workload_mask,
 				    NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
@@ -1087,7 +1101,9 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
+	index = fls(smu->workload_mask);
+	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+	smu->power_profile_mode = smu->workload_setting[index];
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 0b210b1f2628..6a18cb9b6e59 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -866,12 +866,25 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 {
 	int workload_type, ret;
 	uint32_t profile_mode = input[size];
+	uint32_t index;
 
 	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
+	if (smu->user_dpm_profile.prev_user_workload_mask !=
+		smu->user_dpm_profile.user_workload_mask) {
+		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
+			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
+			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
+
+		if (input[size] != smu->default_power_profile_mode) {
+			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+		}
+	}
+
 	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
 			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
 		return 0;
@@ -889,15 +902,18 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 		return -EINVAL;
 	}
 
+	smu->workload_mask |= (1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
+				    smu->workload_mask,
 				    NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
+	index = fls(smu->workload_mask);
+	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+	smu->power_profile_mode = smu->workload_setting[index];
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 8d25cc1f218f..8c26cac6cf18 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2474,9 +2474,22 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
 	u32 workload_mask, selected_workload_mask;
+	uint32_t index;
 
 	smu->power_profile_mode = input[size];
 
+	if (smu->user_dpm_profile.prev_user_workload_mask !=
+		smu->user_dpm_profile.user_workload_mask) {
+		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
+			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
+			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
+
+		if (input[size] != smu->default_power_profile_mode) {
+			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+		}
+	}
+
 	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
@@ -2555,12 +2568,24 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 			workload_mask |= 1 << workload_type;
 	}
 
+	smu->workload_mask |= workload_mask;
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
-					       workload_mask,
+					       smu->workload_mask,
 					       NULL);
-	if (!ret)
-		smu->workload_mask = selected_workload_mask;
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
+			workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
+			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
+										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
+										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+		}
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 23f13388455f..2323c74ee50b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2429,9 +2429,22 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
+	uint32_t index;
 
 	smu->power_profile_mode = input[size];
 
+	if (smu->user_dpm_profile.prev_user_workload_mask !=
+		smu->user_dpm_profile.user_workload_mask) {
+		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
+			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
+			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
+
+		if (input[size] != smu->default_power_profile_mode) {
+			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+		}
+	}
+
 	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
@@ -2487,13 +2500,19 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
+	smu->workload_mask |= (1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu->workload_mask = (1 << workload_type);
+
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index cefe10b95d8e..c2fd47f04e2d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1787,9 +1787,22 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
+	uint32_t index;
 	uint32_t current_profile_mode = smu->power_profile_mode;
 	smu->power_profile_mode = input[size];
 
+	if (smu->user_dpm_profile.prev_user_workload_mask !=
+		smu->user_dpm_profile.user_workload_mask) {
+		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
+			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
+			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
+
+		if (input[size] != smu->default_power_profile_mode) {
+			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
+		}
+	}
+
 	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
@@ -1857,12 +1870,15 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetWorkloadMask,
-					       1 << workload_type,
-					       NULL);
-	if (!ret)
-		smu->workload_mask = 1 << workload_type;
+	smu->workload_mask |= (1 << workload_type);
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+										  smu->workload_mask, NULL);
+
+	if (!ret) {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+	}
 
 	return ret;
 }
-- 
2.34.1

