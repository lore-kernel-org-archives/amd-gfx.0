Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9F4F45A0C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 19:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE75710E9CA;
	Fri, 10 Apr 2026 19:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KTDl3XCl";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011062.outbound.protection.outlook.com
 [40.93.194.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89DCA10E9CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 19:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwiAX6FEYGTstwiUP4hS5LaOclTP8JgLDSfd/LXQ0GvXEc9Vpr5u4yrB3VtOOzL6QTOKgCPl3DQ6r19/ETK/IOCOqbynPAIAdMfo57P+NyF52GAm5cUT6AR4uzKNtlrLHITUsRY6shK/GsQ43eBq+PZj4c7R5hN2dCt/hI42Pi+05WWMpIJoqm5y94UN9EX10S/QHR0z9B5UH01F7e7gBmj3YPIpniaURXL0UZQbI4oU4GSJDI+Yn+iLlO4cjjhSxIGzF1V+TQO45HzkNrGpKjcxPMJmOZBZgEdGErekRgnlL+mqlzzDgfBfJkGqlryZNeDO8/8fRaNeUg+mwYELLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qhssm0MJ8hvAmupnosEXDRoGGK008JEwO1Xbi7iMSO4=;
 b=nK5rymqY2p2ImoXzIsudDLCc/ZHQvUj5V0CvnyfpfpE1a3Yd6tTJesj/PbDyEyW2lQlhuOvwnqb4RuM/+OHIS34E7d62yq2r/1+nTOAoMhvPSdiV1tNCmUCV7TeRgcQtGg4k6rlvYtDRh1vVCbjjRcYbYE5+9Auk9vL5QRKIbRcID/ZSr0CD/E1S4BEzUeDoimvlMi8NIAVhltgcNzUb/JH56O05USawo8GjuLg1RePvhuEk0KPPf7PcH5i5YU2YwVDvsTHlPETb47t2lDTWUI18589Dpzk79W6Bf4k4J/oR/4W/HvHBnt11zK9+vVzcEq0VFr1yFN1pqbBhNj0V2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qhssm0MJ8hvAmupnosEXDRoGGK008JEwO1Xbi7iMSO4=;
 b=KTDl3XClGwBZrTxYJTrbRV3aBuqYfi9HGwPdAhqFr6NgKJBmJrR1ZZbKndCMsGZhF11RGM6OTcDQGWIrlJJRp988ghMKBagPbYD1VWABJyl+121Q7dL8S/i2LOaciJ+rhRueyEDmInVb9Yx2BSHuP9/++9/wQe8JevXOCIJeMBg=
Received: from SA9PR13CA0042.namprd13.prod.outlook.com (2603:10b6:806:22::17)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Fri, 10 Apr
 2026 19:47:03 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::ee) by SA9PR13CA0042.outlook.office365.com
 (2603:10b6:806:22::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Fri,
 10 Apr 2026 19:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 19:47:03 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 14:47:01 -0500
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: [Medusa]- Fix Unified metrics average values
 reporting
Date: Sat, 11 Apr 2026 01:16:32 +0530
Message-ID: <20260410194632.1461984-3-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410194632.1461984-1-Kanala.RamalingeswaraReddy@amd.com>
References: <20260410194632.1461984-1-Kanala.RamalingeswaraReddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2a6bce-f153-4de3-0900-08de9739f076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2TtRxiPjNigv+H9S+wmLmd2H67fSldT1cn0IIshY6aeXoUbgp7/mG9ZJkMec20AMhtkrj0q2OTuLPR5DP+NyBoihvS7PG9eVlPovVUJnLqw52TyRL9jr323KDXcvJwZPWVWGgi6l7BENPIuysvXIqvm3qrjl6IGN/Sm1cEDzumopgfpqDhMreEyhn2Lyk9BHC/qVwVNrDGXBFR5qPHC/iKGyaTdAS0Bl2dJ1gvfU3KYaCKoFLYyLnzpNAHFBJkQ6qZoq/O3csqK4BII87gPdjok5zYXE4jlLDrdtXfNb9Hk9anKvFTCq1hGhoXZLi1+IgUfxKS2zykDtBDuOaCUhUHcTEzmBPLxRKajvP+pJpAX8x7khTDLJKe32uqDcpJ7/3YhfuGEv8e7QyGfTmM4ugeo+RYzGZqKMEm/M9zrZHtV9CpezAshZ2ILtTDTT6NgenpxAgenelEA508+D9nwsdU6uwx0ng4ypgj5yeuHL2azySwODYGfKw+7Uti470rRAk6V8hXVV9IxuPhzVreAWU4eUxKHroKM2W4K/tGapshvkstd/nocgbXCy6Q5rpjcSajkVEki5C/9hzLwJsMmTzdMQLnqJDvsGErm/RI++AQfQgWW8kGkJHMPLtHaWY2TzVcyitnOaTvcj6w6cRzgrAwT/Lspv7W/MYMA5fzN87/XuPpCsu4qWu2dZniz+sT+nW+sCfgxc6MTThDSKkGc30/nGbaKU2x6/wA43rUsuqrpZLIWb5/1nt8uM2yjSCMQ5IfTFrrdU2fcLALsqIoGMew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IIW9f7X3RRmQtNUHeNQc11JPed6RHQMmJ3hOAI8PU5nxdTzTsb9sgS80dwWBqYAV9NqmjKODW6dpr5tCeG8mcvrHelrjRTXONd0rfo/G92QSDbKn63Yms2GiXH4s3q9pY0+N1WxDyN/tjguizcifOtm1mSxZNT18d7zcXBYLxk4MBw52KsHg4L9ip9AATRInzM7Pwgfd1zgDjyBeOeDQpY8WiM3xMfOOA1ppG43mi9kUBKgJCG1rnKeV1oeuVsHXepa+NfVN/lZE6uA9aWOf1uJW/yFWyJXBSuDj4m1SQzJ4FZG97LpZnoFmOZl3COV2yUR3hw3KF7ZMuM310SqRghJ1E39KczJ5A2Dl+KL+iogRZJaAFlsE+U2PmT9B4/ufGFPsF80AMlJwbnY2/UZTWrWVXW6qhFucPjivYS2Bb/c5e2fcR+76pZC5IMl0z2Uk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 19:47:03.5763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2a6bce-f153-4de3-0900-08de9739f076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843
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

SWDEV-577922:[Medusa]-SMU Metrics:New Unified metrics table support
With new design SMU is sending accummulated metric values,
and stop sending us average metrics, so needs to average metrics once read.
If no changes metrics accumulation return previous metrics only.

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

