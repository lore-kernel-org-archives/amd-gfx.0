Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F154EEBFD3A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 10:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808C310E3FF;
	Mon, 13 Apr 2026 10:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5EwHGqiS";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D1C10E3F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 10:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJJh09nJq1VqESqEgdwgKC/x0l45oy3o852Ie8Cb18BEaEVwPqeqL8X0aXYuhI9yj7U08B3RSsETNE9CPwiWH5XTjvmI6a2ADBKeK9s1Eujdvo+fnRVKUliVZGcc4IhWjBRCPgln3VOGHVKqm0KJ04aRpVg9l5PGpzUvrT3ixoaab0cVYxjfRvsFF+XjJgr64GHM6AVsdQ+YiIzNr0SM/Lu4vinFwWNGiPNLhGPmE7NLkxT3l2nafvxVua9RAf0F8yFlO+as/OJMg1KkEF9qbWe7USycUT0Qe+AQNrciT/iZTrStVr2Wzy0hkOcut4Ug9xaaCVaGXEI/dl4NptYe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5N3I9pzVZWf0M+l2yzwaGDcNiM3f0bzni2sXErsc+A=;
 b=WOggwnxANFLq8ZH+Qxjj7dmsR4Ne96uggwLN2du8Ccu4mFShW9yobM4yb89yQw+TkrMhIPLdffrFYwC/zhRDmBZoeY7rGVCwub5ywWuac6MJvMI7qmAfZ5kJWJxJCl0VN7F9DB2cSnbviWbYN2CwzJ5bosMpOgSYe1KshnZQJ02AVSJYJeM92Ou+dkjrq7HDopxdj0YXGKniSHcOY1l85hXDL5qTV9UsbbA5G3YVWL6oE0F/g51xSvgm2P3MNp7dO0yFi18QVTRQWtX3Nft8aICJjCLadGlfnXgu8WbA0+YMg94koNuCoTnizwdko+f3+91oIpSpyMSeoW/b+3J9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5N3I9pzVZWf0M+l2yzwaGDcNiM3f0bzni2sXErsc+A=;
 b=5EwHGqiSw9K2Isyxz+Q7L3eSR0X9lPnQnPeuXNsYiPMLVuiMAyVAgRCYE/g+nCN+x1+rAulC+pxRpsHFxK206O1CUOGa75zNifgrQOvsbbRrTWjUNEBK1doj3WR0Z1UZQ2uC41kD9RbcTUPgFGeXS/8384gUHy3rVDB70CBAtDI=
Received: from BL1PR13CA0281.namprd13.prod.outlook.com (2603:10b6:208:2bc::16)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Mon, 13 Apr
 2026 10:53:07 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::4f) by BL1PR13CA0281.outlook.office365.com
 (2603:10b6:208:2bc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 10:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 13 Apr 2026 10:53:05 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 05:53:03 -0500
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: smu: cache and reuse averaged unified metrics
 values
Date: Mon, 13 Apr 2026 16:22:30 +0530
Message-ID: <20260413105230.1633947-3-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413105230.1633947-1-Kanala.RamalingeswaraReddy@amd.com>
References: <20260413105230.1633947-1-Kanala.RamalingeswaraReddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d6fa69-7320-4c34-0272-08de994ad778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hZK1OQsseAtSEURFXBlmrgjF1zh5KbtC394CUbwk6+wtlWCcnnojlilZXJ9oBJj8b5Z+TFvk9hnv5wpbsDGfv0shHcfmHHcwTWBq5h+jkTtOSNtPLZ59hpbuvLnrAcszwDHpW55FX+bBWNPwgr+krsuoxbKTVdCjeqHvOIVXlzwBwEqcroMsim+QOQ/eH/fiafNlflqGcrBSUmwg1MVGmZbMREAXo2CEfvLRuOijs/I5yKYfPMczgNVDKVdHos/yAI+JdGewefELD6VNMe3fBZ9RZHu0xFlAaQw8+a0Gy7awynW7KaODdZY6cXCy+Yztgr4whgWA9xkL+KR4hEoggAMD5WXPyXTp1UgDfp5IDf++sQDv1DGLcNg4qI4utOJsTi2PWj/CiW89R1+2SmjiRGgENN6y6cWj1bRZh504lKBHcNz1z6K+pVdASXNxngO/ICr4HTJ0PNDlZ7XdUbcdShA5qGiNYyQk2YbgJkOqmElwCopMkJ1DGWEXn7anublV9HiOJsGxeG2i/SBC6OEbM7+3gssEPmYE7L5fI4vER3VsH4OvgcPVrzfN8X7QFes6iNGuFqh/Lhp58LxgH/jX21OifN4roE+VIF0srGKdtu28dE50OZLBkq2ecDCMxhsUZBoB9LpttWUgwmm4X1m6DpOyW8ZQfRJlMzB0HM6YYeXV3NwSuOEzGDaNtVXf/YVAdJ0KX3d2ajon+wSElNN1pTEq2aTpJRUaaCKoxsJc9lHEQz7+Qs+G0cqnMWlPpaL6fCZfoJ33JYmgN/iRohdi8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7D+wYnQldjZs4sjIZjErGkn8R9mN/Cb3skR7rfCJZpmiT/g98nBb0vSvCb9QTFF9b80k5kwHytpsSH5SBYUR8+GGYn1y+1bxQ+OJWvCC+2FPHZgVKxPtQJ02Xk21v+VkSdSHkJcIOyKOEyJYTAjbSIb+6iCQM9Njfl9NXog/z26JL4xGXKwpZr/yfeCO38mVWGGFTnLYHczTogx7DuRRDyM3msvucFhZidwk5djmemhZEsZ02CPj0hjEihH0HOs0CRDyTdT2rkickpE/Um1mYEx8kA2x7dR2wIyTJ/OPYNY4rSVn+GQKCuxZw0KcZFC7NJTwhI9VMl3XTpnb3aRLsKNN+R4kaCB/j949O+4QgJDRh4sq7XS839V0x+leY0uc9/Ulhhl74JwdLHP9E1hK5VKqJ060aQTr4S3TiPy6ZRNsDzLBXq0kDV+EsCXeiCDx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:53:05.4352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d6fa69-7320-4c34-0272-08de994ad778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
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

Compute averaged metrics from accumulated SMU values and store them in a
local cache. If the metrics accumulation counter has not changed, return
the previously cached metrics instead of recalculating them.

Signed-off-by: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index a6a7df683b7e..f0a798631903 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -384,6 +384,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table; //TBD
 
 	SMU_15_0_0_MetricsTable_t prev_metrics;
+	static uint32_t Avg_Metric_copy[METRICS_AVERAGE_NPUCLK+1] = {0};
 	uint64_t counter, val;
 	int ret;
 
@@ -394,6 +395,12 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	if (ret)
 		return ret;
 
+	if (prev_metrics.IOD.AccumulationCounter ==
+		((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter) {
+		*value = Avg_Metric_copy[member];
+		return 0;
+	}
+
 	switch (member) {
 	case METRICS_AVERAGE_GFXCLK:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -401,6 +408,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.GfxclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GfxclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_SOCCLK:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -408,6 +416,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.SocclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.SocclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_VCLK:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -415,9 +424,11 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.VclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.VclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_DCLK:
 		*value = 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_UCLK:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -425,6 +436,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.MemclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.MemclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_FCLK:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -432,9 +444,11 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.FclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.FclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_VPECLK:
 		*value = metrics->VpeclkFrequency;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_NPUCLK:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -442,6 +456,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.NpuhclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.NpuhclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -449,6 +464,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.GfxBusyAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GfxBusyAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -456,6 +472,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.VcnBusyAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.VcnBusyAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -463,54 +480,68 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.ApuPowerAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.ApuPowerAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 	case METRICS_CURR_SOCKETPOWER:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
 		val = get_diff_val(prev_metrics.IOD.SystemPowerAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.SystemPowerAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
 		val = get_diff_val(prev_metrics.IOD.GFX_TempAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GFX_TempAcc);
-		*value = counter ? (val/counter)/1024 : 0;
+		*value = counter ? (val/counter) : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
 		*value = metrics->SocTemperature / 100 *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_PROCHOT:
 		*value = metrics->ThrottleResidency_PROCHOT;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_SPL:
 		*value = metrics->ThrottleResidency_SPL;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_FPPT:
 		*value = metrics->ThrottleResidency_FPPT;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_SPPT:
 		*value = metrics->ThrottleResidency_SPPT;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_THM_SOC:
 		*value = metrics->ThrottleResidency_THM_SOC;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_VOLTAGE_VDDGFX:
 		*value = 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_VOLTAGE_VDDSOC:
 		*value = 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_SS_APU_SHARE:
 		/* return the percentage of APU power with respect to APU's power limit.
 		 * percentage is reported, this isn't boost value. Smartshift power
 		 * boost/shift is only when the percentage is more than 100.
 		 */
-		if (metrics->StapmOpnLimit > 0)
+		if (metrics->StapmOpnLimit > 0) {
 			*value = (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
-		else
+			Avg_Metric_copy[member] = *value;
+		} else {
 			*value = 0;
+			Avg_Metric_copy[member] = *value;
+		}
 		break;
 	case METRICS_SS_DGPU_SHARE:
 		/* return the percentage of dGPU power with respect to dGPU's power limit.
@@ -518,14 +549,18 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		 * boost/shift is only when the percentage is more than 100.
 		 */
 		if ((metrics->dGpuPower > 0) &&
-		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
+		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit)) {
 			*value = (metrics->dGpuPower * 100) /
 				 (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
-		else
+			Avg_Metric_copy[member] = *value;
+		} else {
 			*value = 0;
+			Avg_Metric_copy[member] = *value;
+		}
 		break;
 	default:
 		*value = UINT_MAX;
+		Avg_Metric_copy[member] = *value;
 		break;
 	}
 
-- 
2.53.0

