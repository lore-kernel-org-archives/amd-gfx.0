Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C186F45A0C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 19:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE2010E9C4;
	Fri, 10 Apr 2026 19:45:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QYUL1HsD";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1AF10E9C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 19:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ3VCdgalkp0jG4WF2+AFaBnDB03y0a/qMRswkOBkh+nxTip4CTjcEkQfk+2h8QZK2MoSmqmB8mRuO1IovZj1j0gUYxMBoyH8YHxWHjb2oLAa9VO11gmJHbNCsyk4OIuxKpEPvn5fWGOCjnmDdxNuK5hD+IVezwdMXO6WUnnN/1hmG0v6cZ+1rBZ9EmWceXzMEYRcFYjmntDnQIrJQIpL6gzxqOTV/yOYAnWOUCxSVGaZjqZ1TnVVZMiClgE3NRfuKZhmlN6jo+p4gyGC+0JIRyrcSBdaoAm38jr0JZw6bSwZf7lw1FOo0HIcZs4Ltl5X6EX7HCQ2jAQ9x4nRuXUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qhssm0MJ8hvAmupnosEXDRoGGK008JEwO1Xbi7iMSO4=;
 b=oKS+IWSmSLqsL64/fLYrmsu7H4s+MYGWaEtvD9OY7Y39HpPfCzXjLazWL61HBN1MrBa+J5IIZ5AmquzSZHBw3wK9BSWvJtdkPnave4/WmIqNVtLbCKiItgV4Pbzgnr69eiPMTnNTAQZeWGMgN/ATXhM/5o9Okyjv5Sj0mF+YCZoaZZPKoAcVfkOGmuC0oG0SBDdqKrsf3M2/Z1Tzib/+dxg8ofos9m2QQj6tASTmqSiTO+8HamR5FbIqkvOk6axLmICIZQIp24JpJJla7LRA2+beVD0npXMRcGjnehNfB2BCygU0Gl/5wVPDo/Kq1c5RjnW5/uSAgnp+7N10geX+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qhssm0MJ8hvAmupnosEXDRoGGK008JEwO1Xbi7iMSO4=;
 b=QYUL1HsDylMX2zIrFUDrmh1c9OI6IG48LTtOuyRaBnhT/oaCakIpXsnOUYuDalpk6Wp3YOMelDe6+uXwCGllf7gZHc4SbpumVV5FkRIHryGxvoWhIcyMdxnufcE8LKFFGgcuBXm1siDtWfBG+k1zqV32EpO2MffBiIZfnKkZqe4=
Received: from SA9PR13CA0142.namprd13.prod.outlook.com (2603:10b6:806:27::27)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 19:44:58 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::cc) by SA9PR13CA0142.outlook.office365.com
 (2603:10b6:806:27::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Fri,
 10 Apr 2026 19:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 19:44:58 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 14:44:56 -0500
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH] drm/amdgpu: [Medusa]- Fix Unified metrics average values
 reporting
Date: Sat, 11 Apr 2026 01:14:37 +0530
Message-ID: <20260410194437.1461287-1-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: e54281b7-9411-4cd6-c551-08de9739a5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: R7s/2H02SfsJuYe6jRMXA/IeJueWyVFx7V1juRoTtAS3J1kTD+4YzLJJp0E6Bra+YSmAt1bhEW3jQ24FyjXoMAzk05dUxzRwTi6z/bIvhl4I8kY7e8cZAbVgoaet5QOi9hDCI1XVs2B+eA7A/GAxDJtbsoDSQYvnDvSxFpdbCyVqrMLZZWZ7+2BccR4S27LzQbHbF6hDkpahHfA5O5Rsts/3ZrpCV4z9dDMnzWhXPtwk2A4igAcrq/Ie0jyEIuALb61aIgYadPtI7beApI24zItbUWigTOvp/rd3t9fL8icT8y0FtqEWMnRa4rpMLWUVXpjnAU0InY3BjJGfCzaXuu50MpsWCaat0Ikyp5vEuGeRSR2AwIIy1Lopj3bLY6cfYfp1IKCOwt7EkS1YpqmmmjbKL3gfJddqJrr8ki6MhpPmVEq1u+rDB4AnqFE6jDWG5b3YVHri2jOUKe072p6J5kKT6lf8RqaS/9eRm0toBhZQZLGa6SulrYqN0HO0OWbhYfqEHXKqAP4RZJCKaaAsYr4uPpHFLvEC/Jai1J9PluT4QkzLxWFmtxUHiXhD2clZcqU5xOz3/Oqk9bzTyfaWRizWqB3lIB+NmqGs4vZk38tEmdIKBCZZAnj4qSVbj/lBRMEY/py99yeDp86S6t9sPTPSc7hdBkgDgN0R4qYHeJ/ztCUjGzXUwYaiZiMhrhUtQj62nii98IejYVn9t+6a8pUKF0FwbHqNRo4mYgwpez3SOrVo/28DF3rpENPYcNj2/WClcymQmpueOQXJG/Objg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YqBP2sCjaIdeNjyE5JwOq/FVbMJLiUTffiphWMcfyGR6G0ebCSoBkKhhajsG8fBH12wLFlWHeNLFNf0jYeO4Q5T0OBuhIq3NOtdz9k2DlAwqoTLXLcuwZpvza2zWGK5GxCkOwKSxyNs13OUlcj7ppjixvnKIdKmrqKp+CPelShxjsvrfJWplafQ3gb86HdQVySf7UXFIf0V+EfQ+Y9RX1GLQQnUBYuz7EBwROFpkZeKrcqxI4pOBTtYhz317W6hShBielj3yKF5n2xQJJcJ69M6ovL9/z/2W3DhTJvl3uHaqgQyDJ5PXAHhMQdxheHKHigNLo0gUnSNTgihRq+rCf4F/ZfetiW9eplZxCKfVMkgizCh7fSKJVTB0+OvPJZSpAi/NhE5rzZcaudSAXhPjHo1j+jqX8yHdkMPKHRvnww73JIGbO9jsoZrJMsDShyca
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 19:44:58.1787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54281b7-9411-4cd6-c551-08de9739a5b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
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

