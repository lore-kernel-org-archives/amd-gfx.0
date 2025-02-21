Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19112C021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 12:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7E210E2DC;
	Fri, 21 Feb 2025 12:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5CUdprNy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87EC210E2C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 12:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0SwjFKtJRBoTNgk90xbFkNfeSsUQcT7JbLtxZMzV+91TPeO1D76bJo5z+L64eUyaogxQc8BIeZJ2gbXUwmuYcnXw4Tyv2gI1Dn9x7nX0ei6WWJomye3uQDMfmvGiVCDzEhLBRqNizHLZwu+Hiqk84CkW+gzSnki0V0qqRdoK8KTQZHvkeRvIkHo+OUQyrYyNay78bJfWLvva83ZCLvPCBO+DeSaatwTRXUmDFR2mnd/fC5Gh2ORfwYJfx2EUO8G2DiLVcsmW1ccfTITf2tLtlPfDHnkZvF39tAwCClbUU5iEMADptm8cdM9XrW33zfnNRbdwp17AsOnUvKu5eJXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9eTs68s/PnDVDdo4CMuMZdZ4/GBZXdS21WUJM6O6R8=;
 b=Pj3ktJ5vZJ5BJpiurNC67yN44qprxPVoWvvfc+kocelSiiFAHGsegpwihnWgFWPazH38wipqiMt4ejXgtWYXoprSRK9EwL+0OxWqngWya5JEAMmNvNTXoNuLJXCcV2auXcaksK+RcQkVIhYZeIJPXn7gOiVdck81U+AZOOoFeg1BODcOV3lTJpm7I11vhx0FLArYp8kH8hJze9DubBbkpVMdcmxqJ8AWhqXvmv/bdi3WiXf9byEdSqt+RVHbiBXihdKlHTC8my7tA6jF4KED4P2xqExDpyfT0st401VxxzNzFOWtDHGiZjgajN9+6dadhQO1/6Gb8J/jOEDVv2Etmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9eTs68s/PnDVDdo4CMuMZdZ4/GBZXdS21WUJM6O6R8=;
 b=5CUdprNytcYTlM+ZRn8MgmSSU5VvgFWzipGjlHddclBM6vGT62tuZt5DKLlajZzbNA/KYhVjbyAgHdqnwjcHnybGL4YJESXQV1aRbjLYvuBXQRWewDJn26zztdQvRAe0YYw27A/ZLZ8aPoY6bxares0SNZjj32uhuZqT7f4VOr8=
Received: from BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::20)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 12:19:39 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::be) by BL1P222CA0015.outlook.office365.com
 (2603:10b6:208:2c7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 12:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 12:19:38 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 06:19:35 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amd/pm: Add GetStaticMetricTable message
Date: Fri, 21 Feb 2025 20:19:16 +0800
Message-ID: <20250221121920.779576-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250221121920.779576-1-asad.kamal@amd.com>
References: <20250221121920.779576-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: ae25f650-db1d-4eb3-e8b6-08dd52720335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/5hQJprALPdynQ2r5OU5PIamRxn2suokbB3+mtrVMsgcb5fFf5PL2wcAEdrb?=
 =?us-ascii?Q?VNPfhHxpRYlpTSWp6sU/9EDzpul8jaltFhNcMmPxvbE6X5BqKTEc2LFjT3qw?=
 =?us-ascii?Q?BF3NjUr/9TzVeQ7D6MpouxZOs/L8WQ9oJ9kCd+9z5Gm8SlwfYGVg06lixlXL?=
 =?us-ascii?Q?kgfNCaI9I9xYZWw6XBYko0PPPetBncTfyplyypoADdp4yLSnuwjm9a4Cscgp?=
 =?us-ascii?Q?ps25HYzxHwTfM46ewl/R47fsNRL8SAVtq4z0yRxz2TxA4sfYPixTvdNxjs6r?=
 =?us-ascii?Q?h8CTuHqQL1o7PYZH1N1ouSkloCw2tdzz5EoEjMJHlnUHzaUXIcwkWb/hGhmG?=
 =?us-ascii?Q?F9q3z/XIj86CqbNB9BBI0hVrVb3qjSwoeq8faji7x0yNOEptzW5C42NLGZR9?=
 =?us-ascii?Q?2fQW8RABWqRh4lqwbPv84d1tguyzGhlzXiwcufz4V2yPvuZmRvUvCIBZKdwe?=
 =?us-ascii?Q?jeRvV3FMNuCXADIaCBCl8a+txoWYI+JTasgcOIoy78QaTFnNSSpHTuZ4Ba91?=
 =?us-ascii?Q?2Th/TvdUVi/WjsV6y26Bd5STz37odFXrmPxH6/9A6GMZIIuCgZCekvz6onxJ?=
 =?us-ascii?Q?+QPjd+Rly4JqWgB4Jf/zEhMdE9rRqSWXYOCc5BRAyBO6umAW1obdqdl1fbel?=
 =?us-ascii?Q?HW1D2y4g7UUILerapzv2VYQNbmRja8JV9/8A0U9yczNazVufFVgVadQjfL8W?=
 =?us-ascii?Q?cgZ/yQ8zQXPQFskF6AghRkEvxul9p7HDSqax/sKnSShE3KadgjgHlrSkDtnT?=
 =?us-ascii?Q?sNzsmUj0BeKnFUudMBXBmCSge+6eqpXs7p/R/pqvG8Eak4dLlVa/tDATeKfU?=
 =?us-ascii?Q?pbRXTkE6sTPkylJRerxgC77niACRE3KygkFnsal8oHqwbPS5V0lveOA+PVm+?=
 =?us-ascii?Q?UfurqfJIL08C1LpVyAq0Zgoc+Asp1/d/miGNcz+va3N5MSNGJpAMP8WFCuVL?=
 =?us-ascii?Q?vTvUyL45dWaKy1Enl37xvS1xGuAzFEufSqiW380IMFkk6HeP2R+ElLSFcHSp?=
 =?us-ascii?Q?3Os8DIl7DpQj/ibjlJiLvvBPiEJtvUNTpwWRwEnwefvNEanKLaIITqdhvblb?=
 =?us-ascii?Q?b35/pa8fWiSe/TfLBD+8koXniLWYMeC+CJa5IpFCONQ8OQcjGhoKsfhSu0t6?=
 =?us-ascii?Q?R2DoPEWnzl+FPYwghzKCIP/E9w5zQ9JNLhDST3x31Q9TqxWsVg0JcG7ZDWQH?=
 =?us-ascii?Q?TFguHyNx46T5E5mUmtsPi3o0J0WhJ6kufbHQjqXY+6wO97gZS0JtwHU3dI6w?=
 =?us-ascii?Q?EhmErjB7OPMcC2jLjPXUzOdfRXVA8wdTqrKv5BrI5TVr4TcEv0bGG9edH7zA?=
 =?us-ascii?Q?yhKAnG2EPVvgQOBH5aKOpYkutzxqCMS6ke17DAuJ4M0dJp0M/2vD4x5Jj14x?=
 =?us-ascii?Q?1GMU2jzdpqkviXiwp7oPOjs+xcaoZ/97snBLlafGe7UIVrHhSz0TLjIemsjg?=
 =?us-ascii?Q?8sK7ICXPy2s3oZvVSHjt0t2fWeVx3FcNpbZzXvKzLvoHvL4XgprH6BKdoq1N?=
 =?us-ascii?Q?FUXgA3p2xuiNXQk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 12:19:38.9623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae25f650-db1d-4eb3-e8b6-08dd52720335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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

Add GetStaticMetricTable message for smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 58 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  3 +-
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 9ccd5a1986d3..9c8468fb203a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -276,7 +276,8 @@
 	__SMU_DUMMY_MAP(SetThrottlingPolicy), \
 	__SMU_DUMMY_MAP(MALLPowerController), \
 	__SMU_DUMMY_MAP(MALLPowerState), \
-	__SMU_DUMMY_MAP(ResetSDMA),
+	__SMU_DUMMY_MAP(ResetSDMA), \
+	__SMU_DUMMY_MAP(GetStaticMetricsTable),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 31166974746f..609a04c75129 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -308,5 +308,6 @@ int smu_v13_0_get_boot_freq_by_index(struct smu_context *smu,
 void smu_v13_0_interrupt_work(struct smu_context *smu);
 bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
+extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 86852e738837..5ad5dd879e81 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -28,6 +28,7 @@
 #include "amdgpu_smu.h"
 #include "smu_v13_0_12_pmfw.h"
 #include "smu_v13_0_6_ppt.h"
+#include "smu_v13_0_12_ppsmc.h"
 #include "smu_v13_0.h"
 #include "amdgpu_xgmi.h"
 #include <linux/pci.h>
@@ -72,6 +73,63 @@ const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] =
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT,	FEATURE_XGMI_PER_LINK_PWR_DOWN),
 };
 
+// clang-format off
+const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] = {
+	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
+	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
+	MSG_MAP(GetDriverIfVersion,		     PPSMC_MSG_GetDriverIfVersion,		1),
+	MSG_MAP(EnableAllSmuFeatures,		     PPSMC_MSG_EnableAllSmuFeatures,		0),
+	MSG_MAP(DisableAllSmuFeatures,		     PPSMC_MSG_DisableAllSmuFeatures,		0),
+	MSG_MAP(RequestI2cTransaction,		     PPSMC_MSG_RequestI2cTransaction,		0),
+	MSG_MAP(GetMetricsTable,		     PPSMC_MSG_GetMetricsTable,			1),
+	MSG_MAP(GetMetricsVersion,		     PPSMC_MSG_GetMetricsVersion,		1),
+	MSG_MAP(GetEnabledSmuFeaturesHigh,	     PPSMC_MSG_GetEnabledSmuFeaturesHigh,	1),
+	MSG_MAP(GetEnabledSmuFeaturesLow,	     PPSMC_MSG_GetEnabledSmuFeaturesLow,	1),
+	MSG_MAP(SetDriverDramAddrHigh,		     PPSMC_MSG_SetDriverDramAddrHigh,		1),
+	MSG_MAP(SetDriverDramAddrLow,		     PPSMC_MSG_SetDriverDramAddrLow,		1),
+	MSG_MAP(SetToolsDramAddrHigh,		     PPSMC_MSG_SetToolsDramAddrHigh,		0),
+	MSG_MAP(SetToolsDramAddrLow,		     PPSMC_MSG_SetToolsDramAddrLow,		0),
+	MSG_MAP(SetSoftMinByFreq,		     PPSMC_MSG_SetSoftMinByFreq,		0),
+	MSG_MAP(SetSoftMaxByFreq,		     PPSMC_MSG_SetSoftMaxByFreq,		1),
+	MSG_MAP(GetMinDpmFreq,			     PPSMC_MSG_GetMinDpmFreq,			1),
+	MSG_MAP(GetMaxDpmFreq,			     PPSMC_MSG_GetMaxDpmFreq,			1),
+	MSG_MAP(GetDpmFreqByIndex,		     PPSMC_MSG_GetDpmFreqByIndex,		1),
+	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
+	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
+	MSG_MAP(GfxDeviceDriverReset,		     PPSMC_MSG_GfxDriverReset,			SMU_MSG_RAS_PRI),
+	MSG_MAP(DramLogSetDramAddrHigh,		     PPSMC_MSG_DramLogSetDramAddrHigh,		0),
+	MSG_MAP(DramLogSetDramAddrLow,		     PPSMC_MSG_DramLogSetDramAddrLow,		0),
+	MSG_MAP(DramLogSetDramSize,		     PPSMC_MSG_DramLogSetDramSize,		0),
+	MSG_MAP(GetDebugData,			     PPSMC_MSG_GetDebugData,			0),
+	MSG_MAP(SetNumBadHbmPagesRetired,	     PPSMC_MSG_SetNumBadHbmPagesRetired,	0),
+	MSG_MAP(DFCstateControl,		     PPSMC_MSG_DFCstateControl,			0),
+	MSG_MAP(GetGmiPwrDnHyst,		     PPSMC_MSG_GetGmiPwrDnHyst,			0),
+	MSG_MAP(SetGmiPwrDnHyst,		     PPSMC_MSG_SetGmiPwrDnHyst,			0),
+	MSG_MAP(GmiPwrDnControl,		     PPSMC_MSG_GmiPwrDnControl,			0),
+	MSG_MAP(EnterGfxoff,			     PPSMC_MSG_EnterGfxoff,			0),
+	MSG_MAP(ExitGfxoff,			     PPSMC_MSG_ExitGfxoff,			0),
+	MSG_MAP(EnableDeterminism,		     PPSMC_MSG_EnableDeterminism,		0),
+	MSG_MAP(DisableDeterminism,		     PPSMC_MSG_DisableDeterminism,		0),
+	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		0),
+	MSG_MAP(GetMinGfxclkFrequency,               PPSMC_MSG_GetMinGfxDpmFreq,                1),
+	MSG_MAP(GetMaxGfxclkFrequency,               PPSMC_MSG_GetMaxGfxDpmFreq,                1),
+	MSG_MAP(SetSoftMinGfxclk,                    PPSMC_MSG_SetSoftMinGfxClk,                1),
+	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                1),
+	MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDriverUnload,          0),
+	MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,                     0),
+	MSG_MAP(GetThermalLimit,                     PPSMC_MSG_ReadThrottlerLimit,              0),
+	MSG_MAP(ClearMcaOnRead,	                     PPSMC_MSG_ClearMcaOnRead,                  0),
+	MSG_MAP(QueryValidMcaCount,                  PPSMC_MSG_QueryValidMcaCount,              SMU_MSG_RAS_PRI),
+	MSG_MAP(QueryValidMcaCeCount,                PPSMC_MSG_QueryValidMcaCeCount,            SMU_MSG_RAS_PRI),
+	MSG_MAP(McaBankDumpDW,                       PPSMC_MSG_McaBankDumpDW,                   SMU_MSG_RAS_PRI),
+	MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDumpDW,                 SMU_MSG_RAS_PRI),
+	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
+	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
+	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
+	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
+	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
+};
+
 static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
 					 uint64_t *feature_mask)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9f276f393b81..c43fce62df1c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3616,7 +3616,8 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &smu_v13_0_6_ppt_funcs;
-	smu->message_map = smu_v13_0_6_message_map;
+	smu->message_map = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12)) ?
+		smu_v13_0_12_message_map : smu_v13_0_6_message_map;
 	smu->clock_map = smu_v13_0_6_clk_map;
 	smu->feature_map = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12)) ?
 		smu_v13_0_12_feature_mask_map : smu_v13_0_6_feature_mask_map;
-- 
2.46.0

