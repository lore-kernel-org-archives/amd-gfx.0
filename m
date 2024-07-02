Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97896C3064D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 06:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC2710E145;
	Tue,  2 Jul 2024 06:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gUWHPm8M";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BEA410E145
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 06:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ57UQQdTrdZfplIaAdh9WySFXnVv4j/1WmSQ+SjP7/yFBEgmIdr94U7yva/WxIxUZCy4otVvHiNGnLt5jpmfYMlGgRGROfSt/c5DXh5XJxQMV5AR6anybtnaqaI5KeH9kzc1uACcANQSK7DQPmtegjDenTSmBLPh0Pt8v4EwXP2bjnA3fw4QuG038Vn6LtinNuZvHSQOVm0ubkar1IOiXjM/6JZu9rtDN2pXfyPOxRGSwdfi4Kbq7jneCr3CFrdwGJH5CYDEVvoVJCYe0lx3K+S6jXwo/yMA0a2gxzBxyMIzYfwg4vVCvcBW4n+bLSeXF3zKaHSmbEo/EIGsee1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ufog5WkBjQ+Es5qC/VVfelizpu6UbdY1BeSDzyLthBE=;
 b=O9lPjPWvNK+YT/XZzNVhf1gIt7wD9MK/dMvc0/QDP/WipbN3trWtqRxqBltOkaK10w82ChsMRrUOd5TIfqICcTphZKssKpLtErcgFreDxTfdHp9Ph1HnddrmYnEd6N4EzzCVMvbSbnVtZ7pwcrv77ytb64gk/AZIyiJweSadjWU5A/1y5XgReOMYq27AGf4O7NzIPxtuLRxyUoygfz5SwxrIljZW3l68VU1CvywBeUwVj0VJOAh9SZxZNsx6FkdtJXgu0pLZL5/MBtvyN/ijIeGLYGlFSQPrLWAv7tzYeZQcI8IXIR4srv0S6MgrV3pPjo8U0HS9gstjwEH2u0KIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ufog5WkBjQ+Es5qC/VVfelizpu6UbdY1BeSDzyLthBE=;
 b=gUWHPm8MgoWAnyteAZ7gxBWMd0/4QFw9ntM/3pUqP/70NSHJsrkQPYH26pf/Ns2dvG3GoVYAJcGhsOeR/iTsm3QbbJ/WtbVTVslaclsMYhRggPMcc9TESw67IWkgipAHJNfwA18GLDf++KfnJs0PbA6iuKCoHenld/uxv7rd2tc=
Received: from CH5PR02CA0009.namprd02.prod.outlook.com (2603:10b6:610:1ed::10)
 by LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Tue, 2 Jul
 2024 06:22:10 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ba) by CH5PR02CA0009.outlook.office365.com
 (2603:10b6:610:1ed::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Tue, 2 Jul 2024 06:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.1 via Frontend Transport; Tue, 2 Jul 2024 06:22:09 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 01:22:07 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tim.huang@amd.com>, <Alexander.Deucher@amd.com>, <yifan1.zhang@amd.com>, 
 Li Ma <li.ma@amd.com>
Subject: [PATCH v3] drm/amd/swsmu: enable more Pstates profile levels for SMU
 v14.0.0 and v14.0.1
Date: Tue, 2 Jul 2024 14:20:14 +0800
Message-ID: <20240702062013.529169-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: fd88fc75-44da-4d1b-e33a-08dc9a5f4de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/e40jymQcgxAipUnY7OIBdlxR1PzdWAAIuKeW+3HNMtAKtYYJHzbE2tqYTww?=
 =?us-ascii?Q?qy9n9xcoISMtd60zKaaHzL9MVJhzfbPYRIM7emyjA7DKUQoj/ktl5jmQ0QEE?=
 =?us-ascii?Q?kjsaSNV322A3CkNOVOGduVF16Wa4JYuq1pXqFxD01yzex/c6HZG0u0cbQ9HW?=
 =?us-ascii?Q?zionVouYT4GjWVhW9+wM8cQn9/BlTPL+evt+Y+DditTk6aG+gPVgvNJ5gbHZ?=
 =?us-ascii?Q?9f7pL3DE4iH+xDtrbD5oNYA7zgwpQz66bi2o3QF/ZgGbGFhmxIyJqBqpyftm?=
 =?us-ascii?Q?sAw8nNPPX1V6Dli9VU3HAX4Xx71VxejyXwCjWfnIaFQVSCEgBAr7+NiuRuq2?=
 =?us-ascii?Q?MhZcsUzrNy0B7muWubHtjadwxhlzNAPUvmgDF5FFomjkZ804WFFOkGXVgxn4?=
 =?us-ascii?Q?i/U1H9Zt7TwndjikjzUtog3UvzQ3HKPrd7B4c9qqquWdS0zDS3CN9/FGq/jK?=
 =?us-ascii?Q?zdR1H07kD4siX2dZb8XVST8rKib6E85cptIRqmahscKEreFFGawhto18bmKO?=
 =?us-ascii?Q?oJmuGSrkiag4/qsrdMu4Iz373RFH8ifM51Xvzve1MKdXIA4egWhcUi+RIgoC?=
 =?us-ascii?Q?qHZtrKTuJ/bphhCBQ8zyzjy6XluS63qWan6rNpWfTuW4YKiw5dNwCIhlDW5k?=
 =?us-ascii?Q?P5Vjixgaa42/0UkgKYtyXBkUFSoWT0bKTA7cpnlBemdJUurEpbLH3PXNxsLf?=
 =?us-ascii?Q?A+VGdPYTf+grKh9Uj+uo9FBZPS9lJN+BKBlO50puyr8boIjJEI9kNxH0eJ9A?=
 =?us-ascii?Q?eJHjp+iQs8FmnfjKbG5ds1N9pqfn4Y791OTBMeo5LY9jWaqCiuxlu+RmgtfI?=
 =?us-ascii?Q?ryTkn3N6/2TRKHhLrSjSVoqkHdKeFYC+CyEe2IOZKkuFuIitEPnX+pf7qhVV?=
 =?us-ascii?Q?DNwMqQQ3x6217bBBZOjTZtf3xZhpRaNWAu5f1S42dawOML8dsb/5OPVy/KWI?=
 =?us-ascii?Q?cJihjj6TVyEFSZHjH4gDfheYRmGoFqR4BH7iz6cg6iOgvB84EztQ4ByS9ZSM?=
 =?us-ascii?Q?/+PI2i7x/DUje6tqUOs8xwjZaL7BXjojwy4e3coJbmFSGAA0ZT3s+qLtXCe9?=
 =?us-ascii?Q?oYmhhqaG9/dY2XM5SFgmwL/u3aipbfQjvrdOmRlGDNNl/9VwOTRT2udQdqrm?=
 =?us-ascii?Q?lNM1l9EyLhjLmeGkhWC7i/XJfFKjWBRshTTT5FV/PR8GtYkHYO99Dq57TVpi?=
 =?us-ascii?Q?rlf4AI/Wh4xV1Gh3f2S8HUcJFr0c9j1oghzPVc2QIHV6gj23HWRakK/80z3h?=
 =?us-ascii?Q?XJQLraod5THTU68hZMausW1wu65T2o269gU6vYdaAzJJI8e54u5ElQ9vam0y?=
 =?us-ascii?Q?TC0GpxgDO4Zy69MyvoqO1cXwIlIf6++EUUTMJICfN/8729Kx0539WCFKA+qI?=
 =?us-ascii?Q?RLXkh5CKaIUldNwcanrzYeQ6a6sCIJdOICzUwHFTNVb7j9ReCXg2ptQxgPyX?=
 =?us-ascii?Q?wqUsUcThmkCIrxyHtxr57wrinypJRHLf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 06:22:09.8206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd88fc75-44da-4d1b-e33a-08dc9a5f4de1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269
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

V1: 	This patch enables following UMD stable Pstates profile
	levels for power_dpm_force_performance_level interface.

	- profile_peak
	- profile_min_mclk
	- profile_min_sclk
	- profile_standard

V2:	Fix conflict with commit "drm/amd/pm: smu v14.0.4 reuse smu v14.0.0 dpmtable "

V3:	Add VCLK1 and DCLK1 support for SMU V14.0.1
	And avoid to set VCLK1 and DCLK1 for SMU v14.0.0

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 152 ++++++++++++++++--
 1 file changed, 142 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 3a9d58c036ea..5d47d58944f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -65,6 +65,10 @@
 
 #define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
 
+#define SMU_14_0_0_UMD_PSTATE_GFXCLK			700
+#define SMU_14_0_0_UMD_PSTATE_SOCCLK			678
+#define SMU_14_0_0_UMD_PSTATE_FCLK			1800
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
@@ -725,7 +729,7 @@ static int smu_v14_0_common_get_dpm_freq_by_index(struct smu_context *smu,
 {
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
 		smu_v14_0_1_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
-	else
+	else if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
 		smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
 
 	return 0;
@@ -818,9 +822,11 @@ static int smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
 			break;
 		case SMU_MCLK:
 		case SMU_UCLK:
-		case SMU_FCLK:
 			max_dpm_level = 0;
 			break;
+		case SMU_FCLK:
+			max_dpm_level = clk_table->NumFclkLevelsEnabled - 1;
+			break;
 		case SMU_SOCCLK:
 			max_dpm_level = clk_table->NumSocClkLevelsEnabled - 1;
 			break;
@@ -855,7 +861,7 @@ static int smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
 			min_dpm_level = clk_table->NumMemPstatesEnabled - 1;
 			break;
 		case SMU_FCLK:
-			min_dpm_level = clk_table->NumFclkLevelsEnabled - 1;
+			min_dpm_level = 0;
 			break;
 		case SMU_SOCCLK:
 			min_dpm_level = 0;
@@ -936,9 +942,11 @@ static int smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
 			break;
 		case SMU_MCLK:
 		case SMU_UCLK:
-		case SMU_FCLK:
 			max_dpm_level = 0;
 			break;
+		case SMU_FCLK:
+			max_dpm_level = clk_table->NumFclkLevelsEnabled - 1;
+			break;
 		case SMU_SOCCLK:
 			max_dpm_level = clk_table->NumSocClkLevelsEnabled - 1;
 			break;
@@ -969,7 +977,7 @@ static int smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
 			min_dpm_level = clk_table->NumMemPstatesEnabled - 1;
 			break;
 		case SMU_FCLK:
-			min_dpm_level = clk_table->NumFclkLevelsEnabled - 1;
+			min_dpm_level = 0;
 			break;
 		case SMU_SOCCLK:
 			min_dpm_level = 0;
@@ -1001,7 +1009,7 @@ static int smu_v14_0_common_get_dpm_ultimate_freq(struct smu_context *smu,
 {
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
 		smu_v14_0_1_get_dpm_ultimate_freq(smu, clk_type, min, max);
-	else
+	else if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
 		smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
 
 	return 0;
@@ -1020,9 +1028,15 @@ static int smu_v14_0_0_get_current_clk_freq(struct smu_context *smu,
 	case SMU_VCLK:
 		member_type = METRICS_AVERAGE_VCLK;
 		break;
+	case SMU_VCLK1:
+		member_type = METRICS_AVERAGE_VCLK1;
+		break;
 	case SMU_DCLK:
 		member_type = METRICS_AVERAGE_DCLK;
 		break;
+	case SMU_DCLK1:
+		member_type = METRICS_AVERAGE_DCLK1;
+		break;
 	case SMU_MCLK:
 		member_type = METRICS_AVERAGE_UCLK;
 		break;
@@ -1106,7 +1120,7 @@ static int smu_v14_0_common_get_dpm_level_count(struct smu_context *smu,
 {
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
 		smu_v14_0_1_get_dpm_level_count(smu, clk_type, count);
-	else
+	else if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
 		smu_v14_0_0_get_dpm_level_count(smu, clk_type, count);
 
 	return 0;
@@ -1250,6 +1264,8 @@ static int smu_v14_0_0_force_clk_levels(struct smu_context *smu,
 	case SMU_FCLK:
 	case SMU_VCLK:
 	case SMU_DCLK:
+	case SMU_VCLK1:
+	case SMU_DCLK1:
 		ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
 		if (ret)
 			break;
@@ -1268,13 +1284,67 @@ static int smu_v14_0_0_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v14_0_0_set_performance_level(struct smu_context *smu,
+static int smu_v14_0_common_get_dpm_profile_freq(struct smu_context *smu,
+					enum amd_dpm_forced_level level,
+					enum smu_clk_type clk_type,
+					uint32_t *min_clk,
+					uint32_t *max_clk)
+{
+	uint32_t clk_limit = 0;
+	int ret = 0;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		clk_limit = SMU_14_0_0_UMD_PSTATE_GFXCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
+			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, &clk_limit, NULL);
+		break;
+	case SMU_SOCCLK:
+		clk_limit = SMU_14_0_0_UMD_PSTATE_SOCCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &clk_limit);
+		break;
+	case SMU_FCLK:
+		clk_limit = SMU_14_0_0_UMD_PSTATE_FCLK;
+		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
+			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &clk_limit);
+		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK)
+			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, &clk_limit, NULL);
+		break;
+	case SMU_VCLK:
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &clk_limit);
+		break;
+	case SMU_VCLK1:
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1, NULL, &clk_limit);
+		break;
+	case SMU_DCLK:
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &clk_limit);
+		break;
+	case SMU_DCLK1:
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1, NULL, &clk_limit);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	*min_clk = *max_clk = clk_limit;
+	return ret;
+}
+
+static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
 					     enum amd_dpm_forced_level level)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t sclk_min = 0, sclk_max = 0;
 	uint32_t fclk_min = 0, fclk_max = 0;
 	uint32_t socclk_min = 0, socclk_max = 0;
+	uint32_t vclk_min = 0, vclk_max = 0;
+	uint32_t dclk_min = 0, dclk_max = 0;
+	uint32_t vclk1_min = 0, vclk1_max = 0;
+	uint32_t dclk1_min = 0, dclk1_max = 0;
 	int ret = 0;
 
 	switch (level) {
@@ -1282,28 +1352,54 @@ static int smu_v14_0_0_set_performance_level(struct smu_context *smu,
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk_max);
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK, NULL, &vclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK, NULL, &dclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1, NULL, &vclk1_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1, NULL, &dclk1_max);
 		sclk_min = sclk_max;
 		fclk_min = fclk_max;
 		socclk_min = socclk_max;
+		vclk_min = vclk_max;
+		dclk_min = dclk_max;
+		vclk1_min = vclk1_max;
+		dclk1_min = dclk1_max;
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, NULL);
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, NULL);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, NULL);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1, &vclk1_min, NULL);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1, &dclk1_min, NULL);
 		sclk_max = sclk_min;
 		fclk_max = fclk_min;
 		socclk_max = socclk_min;
+		vclk_max = vclk_min;
+		dclk_max = dclk_min;
+		vclk1_max = vclk1_min;
+		dclk1_max = dclk1_min;
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, &fclk_max);
 		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK, &vclk_min, &vclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK, &dclk_min, &dclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1, &vclk1_min, &vclk1_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1, &dclk1_min, &dclk1_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		/* Temporarily do nothing since the optimal clocks haven't been provided yet */
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_SCLK, &sclk_min, &sclk_max);
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_FCLK, &fclk_min, &fclk_max);
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_SOCCLK, &socclk_min, &socclk_max);
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_VCLK, &vclk_min, &vclk_max);
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_DCLK, &dclk_min, &dclk_max);
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_VCLK1, &vclk1_min, &vclk1_max);
+		smu_v14_0_common_get_dpm_profile_freq(smu, level, SMU_DCLK1, &dclk1_min, &dclk1_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
@@ -1343,6 +1439,42 @@ static int smu_v14_0_0_set_performance_level(struct smu_context *smu,
 			return ret;
 	}
 
+	if (vclk_min && vclk_max) {
+		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
+							      SMU_VCLK,
+							      vclk_min,
+							      vclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (vclk1_min && vclk1_max) {
+		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
+							      SMU_VCLK1,
+							      vclk1_min,
+							      vclk1_max);
+		if (ret)
+			return ret;
+	}
+
+	if (dclk_min && dclk_max) {
+		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
+							      SMU_DCLK,
+							      dclk_min,
+							      dclk_max);
+		if (ret)
+			return ret;
+	}
+
+	if (dclk1_min && dclk1_max) {
+		ret = smu_v14_0_0_set_soft_freq_limited_range(smu,
+							      SMU_DCLK1,
+							      dclk1_min,
+							      dclk1_max);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
@@ -1520,7 +1652,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.od_edit_dpm_table = smu_v14_0_od_edit_dpm_table,
 	.print_clk_levels = smu_v14_0_0_print_clk_levels,
 	.force_clk_levels = smu_v14_0_0_force_clk_levels,
-	.set_performance_level = smu_v14_0_0_set_performance_level,
+	.set_performance_level = smu_v14_0_common_set_performance_level,
 	.set_fine_grain_gfx_freq_parameters = smu_v14_0_common_set_fine_grain_gfx_freq_parameters,
 	.set_gfx_power_up_by_imu = smu_v14_0_set_gfx_power_up_by_imu,
 	.dpm_set_vpe_enable = smu_v14_0_0_set_vpe_enable,
-- 
2.25.1

