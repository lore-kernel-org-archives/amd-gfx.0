Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFB3D597A4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 20:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D8610E64E;
	Tue, 12 Nov 2024 20:29:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aafqA5X1";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE5410E645
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 20:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg4irSSWDVwhXEPiQqNYHzMbYpWB8fn8YwF+JJut1G2hy3wMvs8RXHboZTTzTTop/xSDaQhojL/k580w5x+LqiD7X2FAsSx5Wui0Zzx9UxdLEy304mFSGNmKXfK4NXhYGiDW5PkBohwnp57xrTz4zUupGpMc5kFoPVDLxEdyci3hE//YGP8krjyNwWmC9zbgoCQ9MZ2ZmgFKRyLs9GD6Krk7B/I62LGiVdwmGWayR0VzA18tVYhyqsgR3pDPS9Z77r2Pb47hO95ROlXPLxrRCO/AX8MDRVjFEvLn7Wd1q/8YcKBVNLU1PGztRT0pb4SVOQzk/s89k2rk9RuS2afz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDDZAvXSfdst/Dm3mPCgcPlfZwfClEdcDiRQZS9D6J8=;
 b=R4hiqdoEdRs+6LAQ3GgDU4AMMJE6HQeD9+W49tKSuKjY0VavZjCS4R+ik6IezGTOXpbcjwSLkVH/hTHKrZoUhkCQb00EqA6Wrwn34gPFIEup8DYaG917XeoNAXI0b4vn2l51S8DXzvqJrPYTgNesuhxn4j8nOq+r/jXuRQRpteD6lEHmh77EpnffoN67eMaOerX3roBjgPrT1JQrrxqjrdmnLaTOI91SWIhY70KiWHwUsFB1oIy7JGbYk1X6SKeC2TYKsalrqXAd2uIlgKbkt81ac7r30i37a/6CZFoBLmGuV760o2ttJar0GbvgtLbinvcn6hm2iQGM8pDXbl9n3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDDZAvXSfdst/Dm3mPCgcPlfZwfClEdcDiRQZS9D6J8=;
 b=aafqA5X1havlfGGhtoz9nLFrblOaErDWKciBbhy9UFUcLonwfoHz/c7GXomQDhxiUS4EdLViNYZTinvO7RVAeOToisrbXRhDdSlWsL1L+0QSBR04psENPo6PMQw0JX8Ldc/19FQpnjAS1KqNIVBLARaXFrlfVEc0ipJ/RvyGCbw=
Received: from SN6PR08CA0026.namprd08.prod.outlook.com (2603:10b6:805:66::39)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 20:29:04 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::7c) by SN6PR08CA0026.outlook.office365.com
 (2603:10b6:805:66::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 20:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 20:29:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 14:29:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: handle custom workload profiles across suspend
Date: Tue, 12 Nov 2024 15:28:47 -0500
Message-ID: <20241112202847.8509-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112202847.8509-1-alexander.deucher@amd.com>
References: <20241112202847.8509-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 459c15b5-2631-4797-529c-08dd0358a681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j+RMqUDflwifD5fL/CTZea2FvoQHmvtnwdjn/HfRatTM3cAHto0ACDaNnqPY?=
 =?us-ascii?Q?q73kq6SakD7PL5dbJdAF1eIGR6MbziCONkwC6F4GExM98b5msOZD/PRO9vi7?=
 =?us-ascii?Q?YTYTRoOcXP+w5rId0FBor09i5WPy4yb/Y8/oSkaovoUF7P88V+BX0NWDSY5v?=
 =?us-ascii?Q?pJ1NRRC5vFhl1TNOCAmIDjI5PgptyAbRhLAVOpUkbIcA5qTt58JegdWyGJ/w?=
 =?us-ascii?Q?/X4ZYpFFS/ZkfVpwOPVL2cBl3b4n0HhROtGfiLa4cpQigr4KjIfvf//09Cz1?=
 =?us-ascii?Q?8u24jf+JDlAEWRC5LEsTghdRSIlk7TzPZM/55NGJAG3/l/tbqcW7LKawrzkK?=
 =?us-ascii?Q?AYLSp34Hp03Vehuym2BgUyGt5mc6Xm30gW+Ig9kWioLfM8yxc9+pp4S5pYuj?=
 =?us-ascii?Q?792oFQYMBUhBJ4+/yLbJxlL13/6cRFl1ko3rBt8k2FHyMly8YSM0rnOxTD7j?=
 =?us-ascii?Q?l6YnE0LCjEXFSIofOeWfzCdQkYWXE8p/bozamnqfsBdTIRRVKrGrlP8boDfB?=
 =?us-ascii?Q?JGUDHre+RwDK84qWiPPmSUwQYolvnSujiOT2lfSEaWKRuhMqHGwjOWfo/18U?=
 =?us-ascii?Q?ECQz1GOAB7H8kTIX8lRaTBaS4rnhlXTCoRJM4iXgDHDhFh1YPgNFh+kTP8yR?=
 =?us-ascii?Q?OOOuHorSU2QAqLEiWvO1lhGYT/He1O6rygtzC8/UI2kYR+170JAzcccFRb5p?=
 =?us-ascii?Q?k4wSRe/cuP/oHC1bfqeUqkeTjm8CAEkBcI7PEOQ+CNh16nfVxstvWYqiuv/g?=
 =?us-ascii?Q?pP3jqimc2o5pvWrSzT/ZBRJ/KrrJLdZMfbC3RTPmEPb48qJoQ23MPA4AGKmK?=
 =?us-ascii?Q?nZPkKD9h0tOYKBkmTE8gX4sbpSl6cJyzEyFNYFvPCKkpdEMCL0uGMcIi9GWn?=
 =?us-ascii?Q?Qnn3xoDOLZ3B42mscacxG/XJH/X9n1ArQpUUm63tAxzCnS6pe2ayYOiVFrJk?=
 =?us-ascii?Q?6diRZEXEc1i6yzXcHw/uMrC/rcGSYjqLLsbd51z+s+ZT7rh3Yox82v0PyCxY?=
 =?us-ascii?Q?8K++iFThF3+4vMr1Noi0kwsHbdzvdclHUw3rY2+wiaVA0ji/VIRVui/WUXsS?=
 =?us-ascii?Q?lQXLqnrWsqGcLSb9HEFtkRGDaVw0aClEKeqqUV7xiUwIHjOKYQYbg23WoiCd?=
 =?us-ascii?Q?bnCgjaL9scFQAfGzlFuMnOHiVtNfErld6Um61T42G8WrfeVaRSeErQnGhoDp?=
 =?us-ascii?Q?d6XIXu3pQbSAxkYY9HPiESvSRLUavLdpSMVWdoDlzY6FOK9D5/dqrKResFar?=
 =?us-ascii?Q?ad8l3C/x+P9FKAwyYo5uV7KasyDhPTuiucJSZ0Du5ycEP0XdALP7OJHSVs/X?=
 =?us-ascii?Q?YuymwWasjCS7/i7mmWHnBCBD0p6N2AFhJi2Or1ql6O9ZbbovKslVLgGCeDvR?=
 =?us-ascii?Q?AopFNMymmZax435s7Mv9OVv6HwN18a7rBxZCIevYi0BxALv8vg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 20:29:04.0883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 459c15b5-2631-4797-529c-08dd0358a681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
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

If a custom workload profile was provided, save the custom state
and reapply if the custom profile is enabled when applying the
workload profile.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   3 +
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 128 +++++++++-------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 141 ++++++++++-------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 144 ++++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 126 ++++++++-------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 114 ++++++++------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 132 +++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  12 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   3 +
 9 files changed, 484 insertions(+), 319 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index da7558a65c09..ae57394beb84 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -562,6 +562,9 @@ struct smu_context {
 	uint32_t power_profile_mode;
 	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
 	struct mutex workload_lock;
+	/* backend specific custom workload settings */
+	long custom_profile_input[10];
+	bool custom_profile_size;
 	bool pm_enabled;
 	bool is_apu;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1e44cf6fec4b..72dca191263f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1441,72 +1441,87 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
+static int arcturus_set_power_profile_mode_coeff(struct smu_context *smu,
+						 long *input,
+						 uint32_t size)
+{
+	DpmActivityMonitorCoeffInt_t activity_monitor;
+	int ret;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
+
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor.Gfx_FPS = input[1];
+		activity_monitor.Gfx_UseRlcBusy = input[2];
+		activity_monitor.Gfx_MinActiveFreqType = input[3];
+		activity_monitor.Gfx_MinActiveFreq = input[4];
+		activity_monitor.Gfx_BoosterFreqType = input[5];
+		activity_monitor.Gfx_BoosterFreq = input[6];
+		activity_monitor.Gfx_PD_Data_limit_c = input[7];
+		activity_monitor.Gfx_PD_Data_error_coeff = input[8];
+		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 1: /* Uclk */
+		activity_monitor.Mem_FPS = input[1];
+		activity_monitor.Mem_UseRlcBusy = input[2];
+		activity_monitor.Mem_MinActiveFreqType = input[3];
+		activity_monitor.Mem_MinActiveFreq = input[4];
+		activity_monitor.Mem_BoosterFreqType = input[5];
+		activity_monitor.Mem_BoosterFreq = input[6];
+		activity_monitor.Mem_PD_Data_limit_c = input[7];
+		activity_monitor.Mem_PD_Data_error_coeff = input[8];
+		activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
+
+	return ret;
+}
+
 static int arcturus_set_power_profile_mode(struct smu_context *smu,
 					   long *input,
 					   uint32_t size,
 					   bool enable)
 {
-	DpmActivityMonitorCoeffInt_t activity_monitor;
 	int workload_type = 0;
 	uint32_t profile_mode = input[size];
-	int ret = 0;
+	int i, ret;
 
 	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
-	if (enable &&
-	    (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
+	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
 	    (smu->smc_fw_version >= 0x360d00)) {
-		if (size != 10)
-			return -EINVAL;
-
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-				       WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor),
-				       false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
-
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor.Gfx_FPS = input[1];
-			activity_monitor.Gfx_UseRlcBusy = input[2];
-			activity_monitor.Gfx_MinActiveFreqType = input[3];
-			activity_monitor.Gfx_MinActiveFreq = input[4];
-			activity_monitor.Gfx_BoosterFreqType = input[5];
-			activity_monitor.Gfx_BoosterFreq = input[6];
-			activity_monitor.Gfx_PD_Data_limit_c = input[7];
-			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 1: /* Uclk */
-			activity_monitor.Mem_FPS = input[1];
-			activity_monitor.Mem_UseRlcBusy = input[2];
-			activity_monitor.Mem_MinActiveFreqType = input[3];
-			activity_monitor.Mem_MinActiveFreq = input[4];
-			activity_monitor.Mem_BoosterFreqType = input[5];
-			activity_monitor.Mem_BoosterFreq = input[6];
-			activity_monitor.Mem_PD_Data_limit_c = input[7];
-			activity_monitor.Mem_PD_Data_error_coeff = input[8];
-			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-				       WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor),
-				       true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
+		if (enable) {
+			if (size != 10)
+				return -EINVAL;
+			for (i = 0; i < size; i++)
+				smu->custom_profile_input[i] = input[i];
+			smu->custom_profile_size = size;
+		} else {
+			smu->custom_profile_size = 0;
 		}
 	}
 
@@ -1526,6 +1541,15 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 		smu->workload_mask |= (1 << workload_type);
 	else
 		smu->workload_mask &= ~(1 << workload_type);
+
+	if (smu_cmn_is_workload_profile_enabled(smu, PP_SMC_POWER_PROFILE_CUSTOM)) {
+		ret = arcturus_set_power_profile_mode_coeff(smu,
+							    smu->custom_profile_input,
+							    smu->custom_profile_size);
+		if (ret)
+			return ret;
+	}
+
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetWorkloadMask,
 					  smu->workload_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index d944a9f954d0..339e64b1e95b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2006,74 +2006,90 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 	return size;
 }
 
+static int navi10_set_power_profile_mode_coeff(struct smu_context *smu,
+					       long *input,
+					       uint32_t size)
+{
+	DpmActivityMonitorCoeffInt_t activity_monitor;
+	int ret;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor), false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
+
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor.Gfx_FPS = input[1];
+		activity_monitor.Gfx_MinFreqStep = input[2];
+		activity_monitor.Gfx_MinActiveFreqType = input[3];
+		activity_monitor.Gfx_MinActiveFreq = input[4];
+		activity_monitor.Gfx_BoosterFreqType = input[5];
+		activity_monitor.Gfx_BoosterFreq = input[6];
+		activity_monitor.Gfx_PD_Data_limit_c = input[7];
+		activity_monitor.Gfx_PD_Data_error_coeff = input[8];
+		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 1: /* Socclk */
+		activity_monitor.Soc_FPS = input[1];
+		activity_monitor.Soc_MinFreqStep = input[2];
+		activity_monitor.Soc_MinActiveFreqType = input[3];
+		activity_monitor.Soc_MinActiveFreq = input[4];
+		activity_monitor.Soc_BoosterFreqType = input[5];
+		activity_monitor.Soc_BoosterFreq = input[6];
+		activity_monitor.Soc_PD_Data_limit_c = input[7];
+		activity_monitor.Soc_PD_Data_error_coeff = input[8];
+		activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 2: /* Memclk */
+		activity_monitor.Mem_FPS = input[1];
+		activity_monitor.Mem_MinFreqStep = input[2];
+		activity_monitor.Mem_MinActiveFreqType = input[3];
+		activity_monitor.Mem_MinActiveFreq = input[4];
+		activity_monitor.Mem_BoosterFreqType = input[5];
+		activity_monitor.Mem_BoosterFreq = input[6];
+		activity_monitor.Mem_PD_Data_limit_c = input[7];
+		activity_monitor.Mem_PD_Data_error_coeff = input[8];
+		activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
+
+	return ret;
+}
+
 static int navi10_set_power_profile_mode(struct smu_context *smu, long *input,
 					 uint32_t size, bool enable)
 {
-	DpmActivityMonitorCoeffInt_t activity_monitor;
-	int workload_type, ret = 0;
 	uint32_t profile_mode = input[size];
+	int workload_type, i, ret = 0;
 
 	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
-	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 10)
-			return -EINVAL;
-
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
-
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor.Gfx_FPS = input[1];
-			activity_monitor.Gfx_MinFreqStep = input[2];
-			activity_monitor.Gfx_MinActiveFreqType = input[3];
-			activity_monitor.Gfx_MinActiveFreq = input[4];
-			activity_monitor.Gfx_BoosterFreqType = input[5];
-			activity_monitor.Gfx_BoosterFreq = input[6];
-			activity_monitor.Gfx_PD_Data_limit_c = input[7];
-			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 1: /* Socclk */
-			activity_monitor.Soc_FPS = input[1];
-			activity_monitor.Soc_MinFreqStep = input[2];
-			activity_monitor.Soc_MinActiveFreqType = input[3];
-			activity_monitor.Soc_MinActiveFreq = input[4];
-			activity_monitor.Soc_BoosterFreqType = input[5];
-			activity_monitor.Soc_BoosterFreq = input[6];
-			activity_monitor.Soc_PD_Data_limit_c = input[7];
-			activity_monitor.Soc_PD_Data_error_coeff = input[8];
-			activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 2: /* Memclk */
-			activity_monitor.Mem_FPS = input[1];
-			activity_monitor.Mem_MinFreqStep = input[2];
-			activity_monitor.Mem_MinActiveFreqType = input[3];
-			activity_monitor.Mem_MinActiveFreq = input[4];
-			activity_monitor.Mem_BoosterFreqType = input[5];
-			activity_monitor.Mem_BoosterFreq = input[6];
-			activity_monitor.Mem_PD_Data_limit_c = input[7];
-			activity_monitor.Mem_PD_Data_error_coeff = input[8];
-			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor), true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
+	if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+		if (enable) {
+			if (size != 10)
+				return -EINVAL;
+			for (i = 0; i < size; i++)
+				smu->custom_profile_input[i] = input[i];
+			smu->custom_profile_size = size;
+		} else {
+			smu->custom_profile_size = 0;
 		}
 	}
 
@@ -2088,6 +2104,15 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input,
 		smu->workload_mask |= (1 << workload_type);
 	else
 		smu->workload_mask &= ~(1 << workload_type);
+
+	if (smu_cmn_is_workload_profile_enabled(smu, PP_SMC_POWER_PROFILE_CUSTOM)) {
+		ret = navi10_set_power_profile_mode_coeff(smu,
+							  smu->custom_profile_input,
+							  smu->custom_profile_size);
+		if (ret)
+			return ret;
+	}
+
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    smu->workload_mask, NULL);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 4967e087088b..8580fef73222 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1704,78 +1704,93 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 	return size;
 }
 
-static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
-						 long *input, uint32_t size,
-						 bool enable)
+static int sienna_cichlid_set_power_profile_mode_coeff(struct smu_context *smu,
+						       long *input, uint32_t size)
 {
 
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	uint32_t profile_mode = input[size];
-	int workload_type, ret = 0;
+	int ret;
 
-	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
+
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor->Gfx_FPS = input[1];
+		activity_monitor->Gfx_MinFreqStep = input[2];
+		activity_monitor->Gfx_MinActiveFreqType = input[3];
+		activity_monitor->Gfx_MinActiveFreq = input[4];
+		activity_monitor->Gfx_BoosterFreqType = input[5];
+		activity_monitor->Gfx_BoosterFreq = input[6];
+		activity_monitor->Gfx_PD_Data_limit_c = input[7];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[8];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 1: /* Socclk */
+		activity_monitor->Fclk_FPS = input[1];
+		activity_monitor->Fclk_MinFreqStep = input[2];
+		activity_monitor->Fclk_MinActiveFreqType = input[3];
+		activity_monitor->Fclk_MinActiveFreq = input[4];
+		activity_monitor->Fclk_BoosterFreqType = input[5];
+		activity_monitor->Fclk_BoosterFreq = input[6];
+		activity_monitor->Fclk_PD_Data_limit_c = input[7];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[8];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 2: /* Memclk */
+		activity_monitor->Mem_FPS = input[1];
+		activity_monitor->Mem_MinFreqStep = input[2];
+		activity_monitor->Mem_MinActiveFreqType = input[3];
+		activity_monitor->Mem_MinActiveFreq = input[4];
+		activity_monitor->Mem_BoosterFreqType = input[5];
+		activity_monitor->Mem_BoosterFreq = input[6];
+		activity_monitor->Mem_PD_Data_limit_c = input[7];
+		activity_monitor->Mem_PD_Data_error_coeff = input[8];
+		activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
+		break;
+	default:
 		return -EINVAL;
 	}
 
-	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 10)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_FPS = input[1];
-			activity_monitor->Gfx_MinFreqStep = input[2];
-			activity_monitor->Gfx_MinActiveFreqType = input[3];
-			activity_monitor->Gfx_MinActiveFreq = input[4];
-			activity_monitor->Gfx_BoosterFreqType = input[5];
-			activity_monitor->Gfx_BoosterFreq = input[6];
-			activity_monitor->Gfx_PD_Data_limit_c = input[7];
-			activity_monitor->Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 1: /* Socclk */
-			activity_monitor->Fclk_FPS = input[1];
-			activity_monitor->Fclk_MinFreqStep = input[2];
-			activity_monitor->Fclk_MinActiveFreqType = input[3];
-			activity_monitor->Fclk_MinActiveFreq = input[4];
-			activity_monitor->Fclk_BoosterFreqType = input[5];
-			activity_monitor->Fclk_BoosterFreq = input[6];
-			activity_monitor->Fclk_PD_Data_limit_c = input[7];
-			activity_monitor->Fclk_PD_Data_error_coeff = input[8];
-			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 2: /* Memclk */
-			activity_monitor->Mem_FPS = input[1];
-			activity_monitor->Mem_MinFreqStep = input[2];
-			activity_monitor->Mem_MinActiveFreqType = input[3];
-			activity_monitor->Mem_MinActiveFreq = input[4];
-			activity_monitor->Mem_BoosterFreqType = input[5];
-			activity_monitor->Mem_BoosterFreq = input[6];
-			activity_monitor->Mem_PD_Data_limit_c = input[7];
-			activity_monitor->Mem_PD_Data_error_coeff = input[8];
-			activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
-			break;
-		default:
-			return -EINVAL;
-		}
+static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
+						 long *input, uint32_t size,
+						 bool enable)
+{
+	uint32_t profile_mode = input[size];
+	int workload_type, i, ret = 0;
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
+	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
+		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
+		return -EINVAL;
+	}
+
+	if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+		if (enable) {
+			if (size != 10)
+				return -EINVAL;
+			for (i = 0; i < size; i++)
+				smu->custom_profile_input[i] = input[i];
+			smu->custom_profile_size = size;
+		} else {
+			smu->custom_profile_size = 0;
 		}
 	}
 
@@ -1790,6 +1805,15 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
 		smu->workload_mask |= (1 << workload_type);
 	else
 		smu->workload_mask &= ~(1 << workload_type);
+
+	if (smu_cmn_is_workload_profile_enabled(smu, PP_SMC_POWER_PROFILE_CUSTOM)) {
+		ret = sienna_cichlid_set_power_profile_mode_coeff(smu,
+								  smu->custom_profile_input,
+								  smu->custom_profile_size);
+		if (ret)
+			return ret;
+	}
+
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    smu->workload_mask, NULL);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3cc734331891..e928719bf6b7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2571,16 +2571,70 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
+static int smu_v13_0_0_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input,
+						    uint32_t size)
+{
+	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
+	DpmActivityMonitorCoeffInt_t *activity_monitor =
+		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
+	int ret;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
+
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor->Gfx_FPS = input[1];
+		activity_monitor->Gfx_MinActiveFreqType = input[2];
+		activity_monitor->Gfx_MinActiveFreq = input[3];
+		activity_monitor->Gfx_BoosterFreqType = input[4];
+		activity_monitor->Gfx_BoosterFreq = input[5];
+		activity_monitor->Gfx_PD_Data_limit_c = input[6];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[7];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
+		break;
+	case 1: /* Fclk */
+		activity_monitor->Fclk_FPS = input[1];
+		activity_monitor->Fclk_MinActiveFreqType = input[2];
+		activity_monitor->Fclk_MinActiveFreq = input[3];
+		activity_monitor->Fclk_BoosterFreqType = input[4];
+		activity_monitor->Fclk_BoosterFreq = input[5];
+		activity_monitor->Fclk_PD_Data_limit_c = input[6];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[7];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
+
+	return ret;
+}
+
 static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 					      long *input,
 					      uint32_t size,
 					      bool enable)
 {
-	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
-	DpmActivityMonitorCoeffInt_t *activity_monitor =
-		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	uint32_t profile_mode = input[size];
-	int workload_type, ret = 0;
+	int workload_type, i, ret = 0;
 	u32 workload_mask;
 
 	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
@@ -2588,53 +2642,15 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 9)
-			return -EINVAL;
-
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
-
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_FPS = input[1];
-			activity_monitor->Gfx_MinActiveFreqType = input[2];
-			activity_monitor->Gfx_MinActiveFreq = input[3];
-			activity_monitor->Gfx_BoosterFreqType = input[4];
-			activity_monitor->Gfx_BoosterFreq = input[5];
-			activity_monitor->Gfx_PD_Data_limit_c = input[6];
-			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
-			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
-			break;
-		case 1: /* Fclk */
-			activity_monitor->Fclk_FPS = input[1];
-			activity_monitor->Fclk_MinActiveFreqType = input[2];
-			activity_monitor->Fclk_MinActiveFreq = input[3];
-			activity_monitor->Fclk_BoosterFreqType = input[4];
-			activity_monitor->Fclk_BoosterFreq = input[5];
-			activity_monitor->Fclk_PD_Data_limit_c = input[6];
-			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
-			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
+	if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+		if (enable) {
+			if (size != 9)
+				return -EINVAL;
+			for (i = 0; i < size; i++)
+				smu->custom_profile_input[i] = input[i];
+			smu->custom_profile_size = size;
+		} else {
+			smu->custom_profile_size = 0;
 		}
 	}
 
@@ -2666,6 +2682,14 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 			smu->workload_mask |= 1 << workload_type;
 	}
 
+	if (smu_cmn_is_workload_profile_enabled(smu, PP_SMC_POWER_PROFILE_CUSTOM)) {
+		ret = smu_v13_0_0_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_input,
+							       smu->custom_profile_size);
+		if (ret)
+			return ret;
+	}
+
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
 					       smu->workload_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 1aafd23857f0..e14d8d46ca2a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2528,63 +2528,78 @@ do {													\
 	return result;
 }
 
-static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
-					      long *input, uint32_t size,
-					      bool enable)
+static int smu_v13_0_7_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input, uint32_t size)
 {
 
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	uint32_t profile_mode = input[size];
-	int workload_type, ret = 0;
+	int ret;
 
-	if (profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
+
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor->Gfx_ActiveHystLimit = input[1];
+		activity_monitor->Gfx_IdleHystLimit = input[2];
+		activity_monitor->Gfx_FPS = input[3];
+		activity_monitor->Gfx_MinActiveFreqType = input[4];
+		activity_monitor->Gfx_BoosterFreqType = input[5];
+		activity_monitor->Gfx_MinActiveFreq = input[6];
+		activity_monitor->Gfx_BoosterFreq = input[7];
+		break;
+	case 1: /* Fclk */
+		activity_monitor->Fclk_ActiveHystLimit = input[1];
+		activity_monitor->Fclk_IdleHystLimit = input[2];
+		activity_monitor->Fclk_FPS = input[3];
+		activity_monitor->Fclk_MinActiveFreqType = input[4];
+		activity_monitor->Fclk_BoosterFreqType = input[5];
+		activity_monitor->Fclk_MinActiveFreq = input[6];
+		activity_monitor->Fclk_BoosterFreq = input[7];
+		break;
+	default:
 		return -EINVAL;
 	}
 
-	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 8)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_ActiveHystLimit = input[1];
-			activity_monitor->Gfx_IdleHystLimit = input[2];
-			activity_monitor->Gfx_FPS = input[3];
-			activity_monitor->Gfx_MinActiveFreqType = input[4];
-			activity_monitor->Gfx_BoosterFreqType = input[5];
-			activity_monitor->Gfx_MinActiveFreq = input[6];
-			activity_monitor->Gfx_BoosterFreq = input[7];
-			break;
-		case 1: /* Fclk */
-			activity_monitor->Fclk_ActiveHystLimit = input[1];
-			activity_monitor->Fclk_IdleHystLimit = input[2];
-			activity_monitor->Fclk_FPS = input[3];
-			activity_monitor->Fclk_MinActiveFreqType = input[4];
-			activity_monitor->Fclk_BoosterFreqType = input[5];
-			activity_monitor->Fclk_MinActiveFreq = input[6];
-			activity_monitor->Fclk_BoosterFreq = input[7];
-			break;
-		default:
-			return -EINVAL;
-		}
+static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
+					      long *input, uint32_t size,
+					      bool enable)
+{
+	uint32_t profile_mode = input[size];
+	int workload_type, i, ret = 0;
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
+	if (profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
+		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
+		return -EINVAL;
+	}
+
+	if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+		if (enable) {
+			if (size != 8)
+				return -EINVAL;
+			for (i = 0; i < size; i++)
+				smu->custom_profile_input[i] = input[i];
+			smu->custom_profile_size = size;
+		} else {
+			smu->custom_profile_size = 0;
 		}
 	}
 
@@ -2599,6 +2614,15 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
 		smu->workload_mask |= (1 << workload_type);
 	else
 		smu->workload_mask &= ~(1 << workload_type);
+
+	if (smu_cmn_is_workload_profile_enabled(smu, PP_SMC_POWER_PROFILE_CUSTOM)) {
+		ret = smu_v13_0_7_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_input,
+							       smu->custom_profile_size);
+		if (ret)
+			return ret;
+	}
+
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    smu->workload_mask, NULL);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index b64490bcfd62..ba586bbaade9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1717,69 +1717,85 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
+static int smu_v14_0_2_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input,
+						    uint32_t size)
+{
+	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
+	DpmActivityMonitorCoeffInt_t *activity_monitor =
+		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
+	int ret;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
+
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor->Gfx_FPS = input[1];
+		activity_monitor->Gfx_MinActiveFreqType = input[2];
+		activity_monitor->Gfx_MinActiveFreq = input[3];
+		activity_monitor->Gfx_BoosterFreqType = input[4];
+		activity_monitor->Gfx_BoosterFreq = input[5];
+		activity_monitor->Gfx_PD_Data_limit_c = input[6];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[7];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
+		break;
+	case 1: /* Fclk */
+		activity_monitor->Fclk_FPS = input[1];
+		activity_monitor->Fclk_MinActiveFreqType = input[2];
+		activity_monitor->Fclk_MinActiveFreq = input[3];
+		activity_monitor->Fclk_BoosterFreqType = input[4];
+		activity_monitor->Fclk_BoosterFreq = input[5];
+		activity_monitor->Fclk_PD_Data_limit_c = input[6];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[7];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
+
+	return ret;
+}
+
 static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 					      long *input,
 					      uint32_t size,
 					      bool enable)
 {
-	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
-	DpmActivityMonitorCoeffInt_t *activity_monitor =
-		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	uint32_t profile_mode = input[size];
-	int workload_type, ret = 0;
+	int workload_type, i, ret = 0;
 
 	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
 		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
 		return -EINVAL;
 	}
 
-	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 9)
-			return -EINVAL;
-
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
-
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_FPS = input[1];
-			activity_monitor->Gfx_MinActiveFreqType = input[2];
-			activity_monitor->Gfx_MinActiveFreq = input[3];
-			activity_monitor->Gfx_BoosterFreqType = input[4];
-			activity_monitor->Gfx_BoosterFreq = input[5];
-			activity_monitor->Gfx_PD_Data_limit_c = input[6];
-			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
-			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
-			break;
-		case 1: /* Fclk */
-			activity_monitor->Fclk_FPS = input[1];
-			activity_monitor->Fclk_MinActiveFreqType = input[2];
-			activity_monitor->Fclk_MinActiveFreq = input[3];
-			activity_monitor->Fclk_BoosterFreqType = input[4];
-			activity_monitor->Fclk_BoosterFreq = input[5];
-			activity_monitor->Fclk_PD_Data_limit_c = input[6];
-			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
-			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
+	if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+		if (enable) {
+			if (size != 9)
+				return -EINVAL;
+			for (i = 0; i < size; i++)
+				smu->custom_profile_input[i] = input[i];
+			smu->custom_profile_size = size;
+		} else {
+			smu->custom_profile_size = 0;
 		}
 	}
 
@@ -1796,8 +1812,18 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 		smu->workload_mask &= ~(1 << workload_type);
 
 	/* disable deep sleep if compute is enabled */
-	if (profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
-		smu_v14_0_deep_sleep_control(smu, !enable);
+	if (smu_cmn_is_workload_profile_enabled(smu, PP_SMC_POWER_PROFILE_COMPUTE))
+		smu_v14_0_deep_sleep_control(smu, false);
+	else
+		smu_v14_0_deep_sleep_control(smu, true);
+
+	if (smu_cmn_is_workload_profile_enabled(smu, PP_SMC_POWER_PROFILE_CUSTOM)) {
+		ret = smu_v14_0_2_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_input,
+							       smu->custom_profile_size);
+		if (ret)
+			return ret;
+	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 					      smu->workload_mask, NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 63c4f75fa118..5d70cebdc48a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1218,3 +1218,15 @@ void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy)
 {
 	policy->desc = &xgmi_plpd_policy_desc;
 }
+
+bool smu_cmn_is_workload_profile_enabled(struct smu_context *smu,
+					 enum PP_SMC_POWER_PROFILE profile_mode)
+{
+	bool enabled;
+
+	mutex_lock(&smu->workload_lock);
+	enabled = smu->workload_refcount[profile_mode];
+	mutex_unlock(&smu->workload_lock);
+
+	return enabled;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 1de685defe85..11ad33a0b5a3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -147,5 +147,8 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
 void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
 void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);
 
+bool smu_cmn_is_workload_profile_enabled(struct smu_context *smu,
+					 enum PP_SMC_POWER_PROFILE profile_mode);
+
 #endif
 #endif
-- 
2.47.0

