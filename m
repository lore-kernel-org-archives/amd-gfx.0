Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E10D2E010
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 03:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94AB110E031;
	Wed, 23 Oct 2024 03:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yABQd/bA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEE010E031
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 03:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsAbia53k5BrMQKrAwz+NRRRgibwBvqNlVU8wg2bfjpfwWtihURvDCM1ZnQI9KBS72MBChML40A9RnJiql95+Nn2omg19AlnZJHVsSRd9Y5AZBgYghJeZQLI/TxnQk63gQiT3yEeyBas3fae74py9unfJzLcjYI5C49elNEaKNIvqNS9VRaXWpNoBaGCu6jUdC9pcMvtCvmV+VFmL/OdrxOw67B3l6j2687IzRZpqd+StljbmlyAd1T+f9z8L8pklIxOmhXVapq9CNGL2rKhQr4NdLVwnASe1oHZoqCf/ofESgOwjc346yt+YL6H59hZhCk9Il7dkavIo6kCbDG0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpnZrE3Ar1axstvU38fF1jvYhJqLIfYzLVAgDfAjPag=;
 b=P1SXyo8fOKCQhKw+Og9XNh0grhxOzvyazQHIJM+/jR+vNuJIkGm7dIFUe8+bdoTb88HdC7rO62jGa553bTeTRHzOfhN8ZjTNE6MWPg9rCOApz4291l6Bvk/bpB7vXhmHCbPTvbquqcntKWjByG3IuDzVGkeBrau7QQ05uWGzmSBil6uxHorl9Rj6jqAQTjf3vBjMEMSi+ztDNosfaS43V6ZeQD0qKSXZ9a3dGaUVFnf3c4KqKW0H1W6onZ+SCFjjeiflnhkNqEgk3TNfXHvUfy5gTO4b3lo6XgETo3mzvAzrj+4TN3bR5KtU1vUoV2pmXUveIu6xox9YqSGwan/Fng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpnZrE3Ar1axstvU38fF1jvYhJqLIfYzLVAgDfAjPag=;
 b=yABQd/bAsQr0Lu8JcWGOmydD23XDs7uq3DRuwCNPeNBD6v+t/EZIm1xt+y1qCVFhDHVlknwPvEBQTMEG+odo59HMz+U8KVq5YpMhSVm/aIr4AqLYQPJqEY6Q2jr9Sckki7oRVYUU9Xr1N0DLe9RPbafbbAtud5y6SMCk1HE0Pxk=
Received: from SN6PR16CA0071.namprd16.prod.outlook.com (2603:10b6:805:ca::48)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 03:13:57 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::87) by SN6PR16CA0071.outlook.office365.com
 (2603:10b6:805:ca::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 03:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 03:13:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 22:13:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 22:13:03 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 22 Oct 2024 22:13:02 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: correct the workload setting
Date: Wed, 23 Oct 2024 11:12:57 +0800
Message-ID: <20241023031257.14238-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 1685843f-c814-4de0-ef66-08dcf310bbb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G65c+l05u2bXYl1pFROrwvX7WL+eRDv5ukgf3ShpJtKdTIZ9OlZXAT+1ZQLm?=
 =?us-ascii?Q?iriwNMYGxBYA+4aZFOcZRGp3W0M9+P7v8tDz779SqOvvg7s3IAtV7Wq1fR6n?=
 =?us-ascii?Q?ZJkCz5eeFyKvnxL6C0e4uthwdA9k22HmlkUGCO9DHpcikKyNrF9BRAVD5u34?=
 =?us-ascii?Q?PFe/YuKaVRNf2RnPZ+kNLAStu+f7RN3S6buYRUmNcDNGCrCWl0WgdoF6obAG?=
 =?us-ascii?Q?wT7xI7oDIE6v7q/NJ77hv0LMsLcCgDp0ld6cn5/7T90KyEHFpudvjU5mdP5v?=
 =?us-ascii?Q?5745E5NOgmlDK24XufUDqRIfTjAKOEzbveT3aJMwGyYMLAojNTx4EFFveIwz?=
 =?us-ascii?Q?eVomNcwnUNqYYeno9dNvW2iOjEWWgcr53wNckZEV6O3h/fiiAu0KS/WnJun3?=
 =?us-ascii?Q?eGDxQADRzCcqp97P8m2aqSRC4ZraaTp84oggmTfy96HHsvJ/qLkFQK0wu5Tg?=
 =?us-ascii?Q?1W024zaSFqQfXAU+flkbuWyFwigsUxq2gu7yspoCBqefRQeH7/vO+/LQKCva?=
 =?us-ascii?Q?wG82FOKS6GYUABoxC9hxMyXOQpZqXX+r62+zjcFvw+9P07rh0cNcPLhDSYRY?=
 =?us-ascii?Q?EfOyT2hYu4BcgaxWk9xHO8V9cD47MWZIuZjfLxDtqwkUihCGO46tu65LdWNW?=
 =?us-ascii?Q?Wdi/L+1Y9WeKQSXvI92t0gt5L8B1cu9t0ATCOv26yekwDDx/rvez6Gz6SgP5?=
 =?us-ascii?Q?S2eI18Ef3b5dM5D/J581IRiukFeak005W1DI64OhNSf4FO/PA1ow0CKG1erS?=
 =?us-ascii?Q?IgCTSuaS4ZrB81D4aAUcZvMxBRRHrkuP0fU8x4JYd6Pz4qH4tggojSu1EGuF?=
 =?us-ascii?Q?3fMFrsgV5iNtE+Y7bF7lST2sQPE1rYqpTQQ5UG5GZ2DD/1K/NW4hnr2NRn0G?=
 =?us-ascii?Q?jtLmBTku1xjJIMLaESbrm/4MnGRh2b8ElSUmUmMttgXmJRNKcgRl3/XZdkfj?=
 =?us-ascii?Q?fek2KZ1zulDsVfoO31EVmgPBkBIQXRL8fSYL+GAAoGjR3jrzR+qaQGWGIhh6?=
 =?us-ascii?Q?9DmXlFrQapJGwQVv/ZN2IL2KW2xCfxcSGvv7NJV8RIZVVztLgngFR9NXVllg?=
 =?us-ascii?Q?o5n+WtgWe8yCahJjd67yOw9K/X9+wabeIH3O38SW3NOpIdzXOysF/4ebtcFX?=
 =?us-ascii?Q?9vrN6zXDZQ/i/rjxlcSGM1nrVJOUwWgJ6aoAf0xXWuLCxI2HQYH4pBGpJN6D?=
 =?us-ascii?Q?PaGu2YbOILZjE8wUP8faFqByiP/rAdy3NoqjvmUGspFt3NeebDLpcLJ6o1OP?=
 =?us-ascii?Q?jNogDdZd3bVCbaycuQkmVZF2NCDHRivLVuV+wSprlappN4p0NPFMPYlzhoV8?=
 =?us-ascii?Q?ADppj20nYFnIpT2QgVtY4z8Iv/8TUiVoZf/rwTvgRL3AxXfCXPW5gAqbpI23?=
 =?us-ascii?Q?7Q59ZJLicT6bq57DY1MUCuU8ihQ+JUK+vv88MVfKFJanpk/RdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 03:13:57.2181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1685843f-c814-4de0-ef66-08dcf310bbb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
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

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 17 ++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 39 +++++++++++++++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 33 ++++++++++++---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 42 ++++++++++++++++---
 5 files changed, 115 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index accc96a03bd9..f1984736ff4a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1252,7 +1252,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	atomic64_set(&smu->throttle_int_counter, 0);
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+	smu->user_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+	smu->driver_workload_mask = 0;
 
 	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
@@ -1267,10 +1268,12 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
 
-	if (smu->is_apu)
+	if (smu->is_apu) {
 		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
-	else
+	} else {
 		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
+		smu->user_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	}
 
 	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
@@ -2346,11 +2349,13 @@ static int smu_switch_power_profile(void *handle,
 
 	if (!en) {
 		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
+		smu->driver_workload_mask &= ~(1 << smu->workload_prority[type]);
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 	} else {
 		smu->workload_mask |= (1 << smu->workload_prority[type]);
+		smu->driver_workload_mask |= (1 << smu->workload_prority[type]);
 		index = fls(smu->workload_mask);
 		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
@@ -3045,12 +3050,16 @@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
+	int ret;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
+	smu->user_profile_mode_setting = true;
+	ret = smu_bump_power_profile_mode(smu, param, param_size);
+	smu->user_profile_mode_setting = false;
 
-	return smu_bump_power_profile_mode(smu, param, param_size);
+	return ret;
 }
 
 static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8bb32b3f0d9c..e43b23dd3457 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -557,10 +557,11 @@ struct smu_context {
 	bool disable_uclk_switch;
 
 	uint32_t workload_mask;
+	uint32_t driver_workload_mask;
 	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
 	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
 	uint32_t power_profile_mode;
-	uint32_t default_power_profile_mode;
+	uint32_t user_profile_mode;
 	bool pm_enabled;
 	bool is_apu;
 
@@ -572,6 +573,7 @@ struct smu_context {
 
 	bool uploading_custom_pp_table;
 	bool dc_controlled_by_gpio;
+	bool user_profile_mode_setting;
 
 	struct work_struct throttling_logging_work;
 	atomic64_t throttle_int_counter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3e2277abc754..7250b2bad198 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2433,7 +2433,7 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
 		}
 
 		size += sysfs_emit_at(buf, size, "%2d %14s%s:\n",
-			i, amdgpu_pp_profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
+			i, amdgpu_pp_profile_name[i], (i == smu->user_profile_mode) ? "*" : " ");
 
 		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
@@ -2474,9 +2474,27 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
 	u32 workload_mask;
+	uint32_t current_user_profile_mode;
+	uint32_t index;
+
+	if (smu->user_profile_mode_setting && smu->user_profile_mode == input[size])
+		return 0;
 
 	smu->power_profile_mode = input[size];
 
+	if (smu->user_profile_mode_setting) {
+		current_user_profile_mode = smu->user_profile_mode;
+		smu->user_profile_mode = input[size];
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       current_user_profile_mode);
+		if (workload_type < 0)
+			return -EINVAL;
+
+		if (!(smu->driver_workload_mask & (1 << workload_type)))
+			smu->workload_mask &= ~(1 << workload_type);
+	}
+
 	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
@@ -2555,12 +2573,25 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 			workload_mask |= 1 << workload_type;
 	}
 
+	smu->workload_mask |= workload_mask;
+
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
-					       workload_mask,
+					       smu->workload_mask,
 					       NULL);
-	if (!ret)
-		smu->workload_mask = workload_mask;
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
index 23f13388455f..8afd43e78ebc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2367,7 +2367,7 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
 	size += sysfs_emit_at(buf, size, "                              ");
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++)
 		size += sysfs_emit_at(buf, size, "%d %-14s%s", i, amdgpu_pp_profile_name[i],
-			(i == smu->power_profile_mode) ? "* " : "  ");
+			(i == smu->user_profile_mode) ? "* " : "  ");
 
 	size += sysfs_emit_at(buf, size, "\n");
 
@@ -2429,9 +2429,27 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
+	uint32_t current_user_profile_mode;
+	uint32_t index;
+
+	if (smu->user_profile_mode_setting && smu->user_profile_mode == input[size])
+		return 0;
 
 	smu->power_profile_mode = input[size];
 
+	if (smu->user_profile_mode_setting) {
+		current_user_profile_mode = smu->user_profile_mode;
+		smu->user_profile_mode = input[size];
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       current_user_profile_mode);
+		if (workload_type < 0)
+			return -EINVAL;
+
+		if (!(smu->driver_workload_mask & (1 << workload_type)))
+			smu->workload_mask &= ~(1 << workload_type);
+	}
+
 	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
@@ -2487,13 +2505,18 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
+
+	smu->workload_mask |= (1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+				    smu->workload_mask, NULL);
 
-	if (ret)
+	if (ret) {
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu->workload_mask = (1 << workload_type);
+	} else {
+		index = fls(smu->workload_mask);
+		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
+		smu->power_profile_mode = smu->workload_setting[index];
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index cefe10b95d8e..d88bf9bad313 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1747,7 +1747,7 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
 		}
 
 		size += sysfs_emit_at(buf, size, "%2d %14s%s:\n",
-			i, amdgpu_pp_profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
+			i, amdgpu_pp_profile_name[i], (i == smu->user_profile_mode) ? "*" : " ");
 
 		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
@@ -1787,9 +1787,27 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
-	uint32_t current_profile_mode = smu->power_profile_mode;
+	uint32_t current_user_profile_mode;
+	uint32_t index;
+
+	if (smu->user_profile_mode_setting && smu->user_profile_mode == input[size])
+		return 0;
+
 	smu->power_profile_mode = input[size];
 
+	if (smu->user_profile_mode_setting) {
+		current_user_profile_mode = smu->user_profile_mode;
+		smu->user_profile_mode = input[size];
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       current_user_profile_mode);
+		if (workload_type < 0)
+			return -EINVAL;
+
+		if (!(smu->driver_workload_mask & (1 << workload_type)))
+			smu->workload_mask &= ~(1 << workload_type);
+	}
+
 	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
 		return -EINVAL;
@@ -1845,9 +1863,16 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 		}
 	}
 
+	workload_type = smu_cmn_to_asic_specific_index(smu,
+						       CMN2ASIC_MAPPING_WORKLOAD,
+						       PP_SMC_POWER_PROFILE_COMPUTE);
+
+	if (workload_type < 0)
+		return -EINVAL;
+
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
 		smu_v14_0_deep_sleep_control(smu, false);
-	else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
+	else if (smu->workload_mask & (1 << workload_type))
 		smu_v14_0_deep_sleep_control(smu, true);
 
 	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
@@ -1857,12 +1882,17 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
+	smu->workload_mask |= (1 << workload_type);
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
-					       1 << workload_type,
+					       smu->workload_mask,
 					       NULL);
-	if (!ret)
-		smu->workload_mask = 1 << workload_type;
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

