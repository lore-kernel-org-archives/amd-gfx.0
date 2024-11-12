Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA5ED597A2
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 20:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0AA10E645;
	Tue, 12 Nov 2024 20:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nlg08Ud2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C4610E645
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 20:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CU0KQ5WNhaL96RCwt4b+rh57QBRarkkV7vCpSOsTNntncuy7oA93PS41KDPdjgEYA0F11W0rjLSAAbgX/ZT52LzY9N6vDF3FhXdv1Lu5Vef53rEEr3jFxzWon3JI1c5h8HOVasDbl34+46pKWswrVQResw0NLoZzgaUO+H8gWqkAVBIKaJv199QZDrpDWsmFuaaia/Jb3NowaPCFEnlypbI4XO4/QZ58neXDXmtLI0ZVxgAmUAJZ+GVgbwOOQUhlu8KnRDDLpZCDOekhSdbXs486tw2AFvbvPmyc5pAPgvpdzFb0wm3KwPHB7MtRay1sFH7/uNPA/uATEmkfLBZ9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFCV76jMReoS+r36XksQlElLiEd2cy6lCTfxk3NrlGM=;
 b=bWabD3pt/U/O6u/Hra3uhdHu4ePVMB2ID9jCT0GuyPfvd0ZwE2qeCKETVHncJUQENm2E8UcIgq8L/1qZVNd32n/pM5ln+wg05y9MIXa5VvEDrIuQU+6DvKa+IlUNxPAPc9KYUW/63urP/3i1NkxVGxkqDNHg5asEvEe98pIsfqyfVpFS2Ij5/y6j9eaae4rRI85TflQxSha4Jhh1w0G7wnnLhqiErNEfntGgjCOQC7MoDJwi2RjASdHf6Mfun5g6S6R9BVDcKnQVZbfZ35pF/RyxytiC98iyCKE1H6k31larMtDu6zYaJIjnwri0ZCQlsMd1THwl/XprihuDNcQuvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFCV76jMReoS+r36XksQlElLiEd2cy6lCTfxk3NrlGM=;
 b=Nlg08Ud2ixpz56z62P/Jnbnq77nEO6pv8Meq4SQl0go4ET+GU4BeXrNpzCVa+6wntnqjy8prY8capcLidruU2YjVC8U7hXqFs2QLcaLuMWfxn5Ys+fmlbG8FVDC0rUIg1HAwVDCKZdZayQ/96u/KoFt3HUtD+CTcV52BjktAkQw=
Received: from SN6PR08CA0020.namprd08.prod.outlook.com (2603:10b6:805:66::33)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 20:29:03 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::d4) by SN6PR08CA0020.outlook.office365.com
 (2603:10b6:805:66::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 20:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 20:29:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 14:29:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fix and simplify workload handling
Date: Tue, 12 Nov 2024 15:28:46 -0500
Message-ID: <20241112202847.8509-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c31f745-91d3-4731-a75a-08dd0358a5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wQbzRyLslLRMn6RA8M3OsXxicmgHv0h9BSW4wkrwQMC3T7Mtd00uXnSLtu5j?=
 =?us-ascii?Q?9fFt8JPwNB50O7kbPvTEbBLL8jEkW/noxO6YqxmEKY35ZKksoTZ9OhxMY4i9?=
 =?us-ascii?Q?hI8GxCdx1BbEzfeu9NeFn1pHDjnR4H7zaqu45h6QdRLcu4+YPU0Vunn/KVF7?=
 =?us-ascii?Q?+Ub+uGHkSrjRgdyr8hxK8nKAvz1cMPzZDd2N5i6pw+MwOCYbQA+3yE18b8eW?=
 =?us-ascii?Q?+t1dMqN4WTiDCFauWr2J8tE10uxtnsQBVJJ+eCwa4jrc7YbPb3d311gHcsam?=
 =?us-ascii?Q?6qhuCXm3VR/lQr84vKYynokaTozHURbr11Th/vmXyV2I0Bdf3bJBXX7NX2SC?=
 =?us-ascii?Q?Wf4L1G8L3tMCY55nLpSP4gwt2oBg4xH1oZQw+DVcfqYg8t6IxeUs7pw5DaLV?=
 =?us-ascii?Q?OpHi+y6QF6mppqKx9YVjzj7hZNg1v/GYe6MrXHKKVTNg3Nv5sP4YwdqWJGR4?=
 =?us-ascii?Q?TAFz2fgj82hYFbP5fkbZxhbs7YaF+p2Mjg2e8hVHnssRtibtIm02XcQb7MAm?=
 =?us-ascii?Q?kuNYD5YsT0V6LEA+eRHs9LucEFT6qryvV8Ya7/xf0Cjg62uApdX5rHl/fPuH?=
 =?us-ascii?Q?rUdSH68Q7uird58npfm4KhicNI0q1Aaq4ierBAQHFkM3rJnlPiCKEpVIOiqT?=
 =?us-ascii?Q?S0GJxc3Y/n72pivGAju1TGthONXO8QnOiV0LbyO3HgV4+Jg0VE6TXUZm7SMB?=
 =?us-ascii?Q?cGNs6fCJOwtNgsEaYxyoLBLMsv/i6XoAdABuCrhS/zKyISi19uY6TEIHFz8K?=
 =?us-ascii?Q?I0VqLdMrlFoUi1yg/6CLIYzLuxqq26AhGwFeIvd9dy2tm8MfIy41LATPRfpj?=
 =?us-ascii?Q?brbWr8USLH8G97y/pUehN6oGICKTT8TuAHdG2Lp6MZOQjV5ZmF3bMZxHnMrb?=
 =?us-ascii?Q?cfDq9Po8aWeZT0/A5opWUf6KJYXm/9laX2NZqPO1IBDQ5wZwIEC9JxX3lKNA?=
 =?us-ascii?Q?MV6koTdjvDwwAVAsYBoM9TC15EFeF+OyvRPdEXrEh7TzGTOjC2Nel5oBxqFI?=
 =?us-ascii?Q?3rvvMPx2+zJAQCqC6oigRLoY8Is/RpEWE6Kw3qOX+3dp5973qH9I8ya/v9wI?=
 =?us-ascii?Q?r6lCc/3o3a+o+UTVQtCeyez51JjHSZ04oSx0rH7DPgddTLH/N4tXUt2OKIkv?=
 =?us-ascii?Q?o2uYjdGyqKFvhpLBuIV+P0dKyklcI8Sq0rcCEsHWE3VGhQp6yp/XeXo/iGG4?=
 =?us-ascii?Q?WZ96PdB2giTbL+rDNsQhJuQSxlyFi4eQk+JV9NSthwKhIY9Cw/aBh6mAyZ8T?=
 =?us-ascii?Q?WUahR1I61UVO4+nySscbxuYGhE0pA1Ve79TRbmeb0n38vW5xrqn+3wVW74I8?=
 =?us-ascii?Q?OAjyzi61sfbVgzAhEP29v3vLqCwe9wqniKhbY4UmCn6zR7YLePMwoIHrobwD?=
 =?us-ascii?Q?pOHqqt6QnknoI+kfGGP/NsR52Aa4+vZURNmyfjh0Jbkaoodeqw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 20:29:03.1820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c31f745-91d3-4731-a75a-08dd0358a5f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
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

v2: use refcounts for workload profiles

Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 128 +++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  13 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  20 +--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  20 +--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  21 +--
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  17 +--
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  17 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  33 ++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 +--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  33 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   8 --
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 -
 12 files changed, 162 insertions(+), 171 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c3a6b6f20455..41b591ecfb64 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -72,6 +72,10 @@ static int smu_set_power_limit(void *handle, uint32_t limit);
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
+static void smu_power_profile_mode_get(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode);
+static void smu_power_profile_mode_put(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode);
 
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
@@ -765,6 +769,7 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 	smu->user_dpm_profile.fan_mode = -1;
 
 	mutex_init(&smu->message_lock);
+	mutex_init(&smu->workload_lock);
 
 	adev->powerplay.pp_handle = smu;
 	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
@@ -1268,9 +1273,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
 	atomic64_set(&smu->throttle_int_counter, 0);
 	smu->watermarks_bitmap = 0;
-	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->user_dpm_profile.user_workload_mask = 0;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
@@ -1278,33 +1280,13 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
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
+	smu_power_profile_mode_get(smu, smu->power_profile_mode);
+
 	smu->display_config = &adev->pm.pm_display_cfg;
 
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
@@ -2252,24 +2234,41 @@ static int smu_enable_umd_pstate(void *handle,
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
 
+static void smu_power_profile_mode_get(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode)
+{
+	mutex_lock(&smu->workload_lock);
+	smu->workload_refcount[profile_mode]++;
+	mutex_unlock(&smu->workload_lock);
+}
+
+static void smu_power_profile_mode_put(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode)
+{
+	mutex_lock(&smu->workload_lock);
+	if (smu->workload_refcount[profile_mode])
+		smu->workload_refcount[profile_mode]--;
+	mutex_unlock(&smu->workload_lock);
+}
+
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 					  enum amd_dpm_forced_level level,
 					  bool skip_display_settings,
 					  bool init)
 {
 	int ret = 0;
-	int index = 0;
 	long workload[1];
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
@@ -2307,13 +2306,11 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
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
+		if (init)
+			smu_bump_power_profile_mode(smu, workload, 0, true);
 	}
 
 	return ret;
@@ -2361,12 +2358,11 @@ static int smu_handle_dpm_task(void *handle,
 
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
@@ -2374,24 +2370,16 @@ static int smu_switch_power_profile(void *handle,
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
-
-	smu->workload_mask = smu->driver_workload_mask |
-						 smu->user_dpm_profile.user_workload_mask;
+	workload[0] = type;
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
-		smu_bump_power_profile_mode(smu, workload, 0);
+	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
+		if (enable)
+			smu_power_profile_mode_get(smu, type);
+		else
+			smu_power_profile_mode_put(smu, type);
+		smu_bump_power_profile_mode(smu, workload, 0, enable);
+	}
 
 	return 0;
 }
@@ -3090,21 +3078,27 @@ static int smu_set_power_profile_mode(void *handle,
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
+		smu_power_profile_mode_put(smu, smu->power_profile_mode);
+		ret = smu_bump_power_profile_mode(smu, workload, 0, false);
+		if (ret)
+			return ret;
+		/* set the new user preference */
+		smu_power_profile_mode_get(smu, param[param_size]);
+		ret = smu_bump_power_profile_mode(smu, param, param_size, true);
+		if (!ret)
+			/* store the user's preference */
+			smu->power_profile_mode = param[param_size];
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index fa93a8879113..da7558a65c09 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
 	/* user clock state information */
 	uint32_t clk_mask[SMU_CLK_COUNT];
 	uint32_t clk_dependency;
-	uint32_t user_workload_mask;
 };
 
 #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
@@ -557,12 +556,12 @@ struct smu_context {
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
+	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
+	struct mutex workload_lock;
 	bool pm_enabled;
 	bool is_apu;
 
@@ -734,8 +733,10 @@ struct pptable_funcs {
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
index 59b369eff30f..b64490bcfd62 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1719,21 +1719,21 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
 
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
-	uint32_t current_profile_mode = smu->power_profile_mode;
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
 
@@ -1783,23 +1783,24 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 		}
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
-		smu_v14_0_deep_sleep_control(smu, false);
-	else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
-		smu_v14_0_deep_sleep_control(smu, true);
-
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
 	workload_type = smu_cmn_to_asic_specific_index(smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
+						       profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-										  smu->workload_mask, NULL);
+	if (enable)
+		smu->workload_mask |= (1 << workload_type);
+	else
+		smu->workload_mask &= ~(1 << workload_type);
 
-	if (!ret)
-		smu_cmn_assign_power_profile(smu);
+	/* disable deep sleep if compute is enabled */
+	if (profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
+		smu_v14_0_deep_sleep_control(smu, !enable);
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
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

