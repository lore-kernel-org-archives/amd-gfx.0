Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FE7EBFD38
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 10:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F1E110E32F;
	Mon, 13 Apr 2026 10:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="umYeKcl0";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EC2110E32F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 10:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGBDd3xYc6OzgUVw0L1SC3Epbdtm88HEW4JJ3M4Bf5mvDL2hRGAtZcJHbNQXEIRnyFdjHvjWksZv2vW0avWztozon22J6CkH+AOzLTFOuhTUU3hxyH4RrlJGJ3l/gEjp3C8/ldbxQZjL0/eJ8foqd5fHzrmjLsMmcaav7gjt/4QiGGJ/Ix9E68x+gGwNAyQUYlLGxVCq8NrGyUjax5fQb6kDZXIQUv/OIuJ8j09BkZ8iyF6Col8UCKTfZoz6qoOcEYzsT7XKc6lRnsaJRQlt6trnOVpGogvmqjmHHjUS+9cWrMEdiVeSJ3KzFqdxylcjKFo/euZE+FSKVJiXqHUOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TW/yhCgUe83izubZnDy2Yq4Mu/JSwJO5WdwawAE/So=;
 b=Qe9QtFV7P+CbNp343c/2ysxgM6dFkN2DyYmNkQvzyBILX8r3FwUnOxSnH/+3KcG7eZn9hcbYUa0GGwnbVrHm0ZT1GqkEhmR6Ny8TDDiNrr+Mk1XcqM0Gf/A7ow39ktI1dqgZPumzH6x8uxsColY01lFT3EA83XvtetkK7WaHBfBzrAl3UGrtMHwpdI7YUccom+YFYAvA0WA3ztXW8F89oDjvguOPky02UU+vY6i4e5F2rr53moq0BTpHwfay20idX825uhzXiJ2RRDFJ9mM2NOsv02Wps7zEPWoVNtZ1UnRTDc+Npf99JW7FU6NsFt51wyMCKDQTwmpWbUEwc9d7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TW/yhCgUe83izubZnDy2Yq4Mu/JSwJO5WdwawAE/So=;
 b=umYeKcl05OGIwVjt0FpHXMwG2YSEaitSJ21lYd1ATRZSqkbuB0quzXl58aWKmjfFLfHW1etFQkPzwynGEDq9t6Nts9KpLk9kRiyJlxbCWfSAqF3B4ImX4nc5H6H9F/ioya1zin5WODCkbwGDPsPqA/zxFOvPBIpg4IkAYkJjeOA=
Received: from MN2PR20CA0019.namprd20.prod.outlook.com (2603:10b6:208:e8::32)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 10:52:57 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::98) by MN2PR20CA0019.outlook.office365.com
 (2603:10b6:208:e8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 10:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 10:52:56 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 05:52:54 -0500
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: smu: add unified metrics table support for
 SMU 15.0.0
Date: Mon, 13 Apr 2026 16:22:28 +0530
Message-ID: <20260413105230.1633947-1-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c0a8b9-2bdc-41d9-4b11-08de994ad261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5LDS4p5vrrjKQtwV0Iqra3ej4Eggwr0+fJISs8eRbMBRj8s1/TTAoFtkyexL99Ku63bVXfCW7w8nUcloLL7GUwjHWK/K5xl4NGeJ4j0CL+JRMy+HOCGqD3NHjzLPB/gE9O/lQ7E8apL+J6b6TuPaF1qVSqlcKlP03j7sm9fXMOfAVvh7OkGv2AWrV7kHdwkw9JS5fmMZQl9wlQLIjUqPXLTjSA7uev46hNdLj6ouvG7QEPkRnmkQRJW5HG1uIoV2J9NSu7fX092H/5ghocjyjwlEBQkTwsAJNcMx0JMzxBeIk+zWLmS8m83N2tzOxwgytF+MXXf5CkH6dHe1EcdNWKb0y+qYr0eEdtzLhJSsFpjKyqyp2HroW0jkvYhjpkcvvyd4oypDf0k/2p8CGJw6yslBvpqy5jm3sj9+Z/7eqkNwhKH9DP+DynKtyMjTSr4mZ9UMlRfWDzqatDvb7fqdxKqlpw/q+DnSy1PmzjyZZnCMddOoJs99M+QTkJtUB00CR7U+yaMhosHg1ybvwU3hdzscl7SopvFujTShWakmEse/LgocY2CareYRCGoe6VRgkyynUYRanc75P02LLQKRB6odTgqm47/5VNbaJwXgLM82DECNyT54EXuTGoFkzHHqBqBPlyhpaJir/bN/rIoIpGzT0gJQaKpHV9dfUCZfcT7b7dcWVNIRYovKz5GC7uE6rHOh6F5zBw1sxAaUXqOT9blcPQRgS1hfyHTGAN3tu6fGACBP+Hrt1uBYowNnsslTJyWp4YNY4w4DNwDdZFwNuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pvamk5g4mZj6dzeDClseig6joqPmBqnEIk8IBjqpRbsg49dNmMdyS74N9kWeuj971v1kw4dv3uERogP9cwXszUx+nxxCsRjh1ICyU+I/nxEW8GEX5pHMX/7RS0mL4yxMmGzaY5zS8BjqBFdy7OpFeTL/ClpYrvH3uYMHOwf0QyIIdsFX74rQ8s6IqoI9ig7gW5m/ehGXLSAsZajkI/A+72+I3dK6QS0NbJaNV/zbS6z1cMctRHC46Ap53jwOg9Orgz0YpjvxcP4Y++G3/eC0lVle69vpnjIrKbMx2Jv4PstwyGORMAslKt9GqHv/GVlysNME6dbnnSPqr8JpU9JcoGxGt0QAUZHwOc6UZ/tRknlySFATzVa6ifNEQq5XJoljBrrZ1id8BRC5LydOzyEdUkOFWeTvVgaqT77x/RgVXRO2Fss+lrV1jyd1DG2a778E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:52:56.8979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c0a8b9-2bdc-41d9-4b11-08de994ad261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008
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

From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

SMU 15.0.0 reports metric values in an accumulated form and no longer
provides pre-averaged metrics. Introduce support for the new unified
metrics table and prepare the driver to compute average values in

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h  |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 102 +++++++--
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  | 198 +++++++++++++++++-
 4 files changed, 289 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
index bf216f83e689..9f627b5fef5b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
@@ -100,7 +100,10 @@
 #define PPSMC_MSG_DisableLSdma                  0x1F ///< Disable LSDMA
 #define PPSMC_MSG_SetSoftMaxVpe                 0x20 ///<
 #define PPSMC_MSG_SetSoftMinVpe                 0x21 ///<
-#define PPSMC_Message_Count                     0x22 ///< Total number of PPSMC messages
+#define PPSMC_MSG_GetMetricsTableVersion        0x22
+#define PPSMC_MSG_GetMetricsTableLogSample      0x23
+#define PPSMC_MSG_GetMetricsTableLogDramAddr    0x24
+#define PPSMC_Message_Count                     0x25 ///< Total number of PPSMC messages
 /** @}*/
 
 /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 636ff90923d9..e1b92d2dbc59 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -295,6 +295,9 @@
 	__SMU_DUMMY_MAP(GetSmartShiftStatus), \
 	__SMU_DUMMY_MAP(EnableLSdma), \
 	__SMU_DUMMY_MAP(DisableLSdma), \
+	__SMU_DUMMY_MAP(GetMetricsTableVersion), \
+	__SMU_DUMMY_MAP(GetMetricsTableLogSample), \
+	__SMU_DUMMY_MAP(GetMetricsTableLogDramAddr), \
 	__SMU_DUMMY_MAP(InitializeGfx), \
 	__SMU_DUMMY_MAP(SetSoftMaxFclk), \
 	__SMU_DUMMY_MAP(SetSoftMaxGl2clk), \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 9a4a5f482e75..a280506f43fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -119,6 +119,9 @@ static struct cmn2asic_msg_mapping smu_v15_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(DisableLSdma,                   PPSMC_MSG_DisableLSdma,				1),
 	MSG_MAP(SetSoftMaxVpe,                  PPSMC_MSG_SetSoftMaxVpe,			1),
 	MSG_MAP(SetSoftMinVpe,                  PPSMC_MSG_SetSoftMinVpe,			1),
+	MSG_MAP(GetMetricsTableVersion,         PPSMC_MSG_GetMetricsTableVersion,		1),
+	MSG_MAP(GetMetricsTableLogSample,       PPSMC_MSG_GetMetricsTableLogSample,		1),
+	MSG_MAP(GetMetricsTableLogDramAddr,     PPSMC_MSG_GetMetricsTableLogDramAddr,	1),
 };
 
 static struct cmn2asic_mapping smu_v15_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -170,10 +173,10 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SMU_15_0_0_MetricsTable_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
-	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
+	smu_table->metrics_table = kzalloc(sizeof(SMU_15_0_0_MetricsTable_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		goto err0_out;
 	smu_table->metrics_time = 0;
@@ -299,7 +302,7 @@ static int smu_v15_0_0_set_default_dpm_tables(struct smu_context *smu)
 				    smu_table->clocks_table, false);
 }
 
-static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
 							void *metrics_table,
 							bool bypass_cache)
 {
@@ -329,34 +332,90 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 	return 0;
 }
 
+
+static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+					SMU_15_0_0_MetricsTable_t *metrics)
+{
+	uint64_t addr;
+	void __iomem *cpu_addr;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	int ret, table_size;
+
+	struct smu_msg_args args = {
+		.msg = SMU_MSG_GetMetricsTableLogDramAddr,
+		.num_args = 0,
+		.num_out_args = 3,
+	};
+
+	ret = ctl->ops->send_msg(ctl, &args);
+
+	if (ret)
+		return ret;
+
+	addr = ((uint64_t)args.out_args[1] << 32) | args.out_args[0];
+	table_size = args.out_args[2];
+
+	cpu_addr = ioremap_wc(addr, metrics->table_size);
+
+	args.msg = SMU_MSG_GetMetricsTableLogSample;
+	args.num_args = 0;
+	args.num_out_args = 0;
+
+	ret = ctl->ops->send_msg(ctl, &args);
+	if (!ret) {
+		amdgpu_hdp_invalidate(smu->adev, NULL);//best to flush before copy?
+		memcpy(metrics, cpu_addr, table_size);
+	}
+	return ret;
+}
+
+#define get_diff(a, b) \
+	(a > b ? ((0xFFFFFFFF - a) + b + 1) : (b - a))
+
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
 					    uint32_t *value)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table; //TBD
 
-	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
-	int ret = 0;
+	SMU_15_0_0_MetricsTable_t prev_metrics;
+	int ret, counter, val;
 
-	ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
+	memcpy(&prev_metrics, smu_table->metrics_table,
+			sizeof(SMU_15_0_0_MetricsTable_t));
+	ret = smu_v15_0_0_get_metrics_table(smu,
+			(SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table);
 	if (ret)
 		return ret;
 
 	switch (member) {
 	case METRICS_AVERAGE_GFXCLK:
-		*value = metrics->GfxclkFrequency;
+		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff(prev_metrics.IOD.GfxclkFreqEffAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GfxclkFreqEffAcc);
+		*value = counter ? (val/counter)*1024 : 0;
 		break;
 	case METRICS_AVERAGE_SOCCLK:
-		*value = metrics->SocclkFrequency;
+		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff(prev_metrics.IOD.SocclkFreqEffAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.SocclkFreqEffAcc);
+		*value = counter ? (val/counter)*1024 : 0;
 		break;
 	case METRICS_AVERAGE_VCLK:
-		*value = metrics->VclkFrequency;
+		*value = 0;//metrics->VclkFrequency;
 		break;
 	case METRICS_AVERAGE_DCLK:
 		*value = 0;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		*value = metrics->MemclkFrequency;
+		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff(prev_metrics.IOD.MemclkFreqEffAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.MemclkFreqEffAcc);
+		*value = counter ? (val/counter)*1024 : 0;
 		break;
 	case METRICS_AVERAGE_FCLK:
 		*value = metrics->FclkFrequency;
@@ -368,18 +427,27 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->NpuclkFrequency;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		if ((smu->smc_fw_version > 0x5d4600))
-			*value = metrics->GfxActivity;
-		else
-			*value = metrics->GfxActivity / 100;
+		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff(prev_metrics.IOD.GfxBusyAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GfxBusyAcc);
+		*value = counter ? (val/counter)*1024 : 0;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
 		*value = metrics->VcnActivity / 100;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
+		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff(prev_metrics.IOD.ApuPowerAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.ApuPowerAcc);
+		*value = counter ? (val/counter)*1024 : 0;
 	case METRICS_CURR_SOCKETPOWER:
-		*value = (metrics->SocketPower / 1000 << 8) +
-		(metrics->SocketPower % 1000 / 10);
+		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff(prev_metrics.IOD.SystemPowerAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.SystemPowerAcc);
+		*value = counter ? (val/counter)*1024 : 0;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		*value = metrics->GfxTemperature / 100 *
@@ -637,7 +705,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, false);
+	ret = smu_v15_0_0_get_gpu_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
index 8365b9fea77e..b3dc6ccdddaf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
@@ -23,6 +23,202 @@
 #ifndef __SMU_V15_0_0_PPT_H__
 #define __SMU_V15_0_0_PPT_H__
 
+#pragma pack(push, 1)
+
+typedef struct {
+	uint32_t AccumulationCounter;
+
+	//SET_VOLTAGES
+	uint64_t VDDCR_SetVoltage;
+	uint64_t VDDCR_SOC_SetVoltage;
+	uint64_t VDDCR_NPU_SetVoltage;
+	uint64_t VDDCR_LP_SetVoltage;
+	uint64_t VDDCR_GFX_SetVoltage;
+	uint64_t VDD_MISC_SetVoltage;
+
+	//TELEMETRY_VOLTAGES
+	uint64_t VDDCR_TelemetryVoltage;
+	uint64_t VDDCR_SOC_TelemetryVoltage;
+	uint64_t VDDCR_NPU_TelemetryVoltage;
+	uint64_t VDDCR_LP_TelemetryVoltage;
+	uint64_t VDDCR_GFX_TelemetryVoltage;
+	uint64_t VDD_MISC_TelemetryVoltage;
+
+	//TELEMETRY_POWERS
+	uint64_t VDDCR_TelemetryPower;
+	uint64_t VDDCR_SOC_TelemetryPower;
+	uint64_t VDDCR_NPU_TelemetryPower;
+	uint64_t VDDCR_LP_TelemetryPower;
+	uint64_t VDDCR_GFX_TelemetryPower;
+	uint64_t VDD_MISC_TelemetryPower;
+
+	//THROTTLERS
+	uint32_t fPPT_FusedLimit;
+	uint32_t fPPT_MaxIrmLimit;
+	uint32_t fPPT_MaxPboLimit; // Inst | Fast PPT MaxPboLimit (W)
+	uint32_t fPPT_Limit;
+	uint64_t fPPT_ValueAcc;
+	uint32_t fPPT_ResidencyAcc; // Acc | Fast PPT Residency Active
+
+	uint32_t sPPT_FusedLimit;
+	uint32_t sPPT_MaxIrmLimit;
+	uint32_t sPPT_MaxPboLimit;
+	uint32_t sPPT_Limit;
+	uint64_t sPPT_ValueAcc;
+	uint32_t sPPT_ResidencyAcc;
+
+	uint32_t SPL_FusedLimit;
+	uint32_t SPL_MaxIrmLimit;
+	uint32_t SPL_MaxPboLimit;
+	uint32_t SPL_Limit;
+	uint64_t SPL_ValueAcc;
+	uint32_t SPL_ResidencyAcc;
+
+	uint32_t TDC_VDDCR_FusedLimit;
+	uint32_t TDC_VDDCR_MaxIrmLimit;
+	uint32_t TDC_VDDCR_MaxPboLimit;
+	uint32_t TDC_VDDCR_Limit;
+	uint64_t TDC_VDDCR_ValueAcc;
+	uint32_t TDC_VDDCR_ResidencyAcc;
+
+	uint32_t TDC_VDDCR_SOC_FusedLimit;
+	uint32_t TDC_VDDCR_SOC_MaxIrmLimit;
+	uint32_t TDC_VDDCR_SOC_MaxPboLimit;
+	uint32_t TDC_VDDCR_SOC_Limit;
+	uint64_t TDC_VDDCR_SOC_ValueAcc;
+	uint32_t TDC_VDDCR_SOC_ResidencyAcc;
+
+	uint32_t TDC_VDDCR_NPU_FusedLimit;
+	uint32_t TDC_VDDCR_NPU_MaxIrmLimit;
+	uint32_t TDC_VDDCR_NPU_MaxPboLimit;
+	uint32_t TDC_VDDCR_NPU_Limit;
+	uint64_t TDC_VDDCR_NPU_ValueAcc;
+	uint32_t TDC_VDDCR_NPU_ResidencyAcc;
+
+	uint32_t TDC_VDDCR_LP_FusedLimit;
+	uint32_t TDC_VDDCR_LP_MaxIrmLimit;
+	uint32_t TDC_VDDCR_LP_MaxPboLimit;
+	uint32_t TDC_VDDCR_LP_Limit;
+	uint64_t TDC_VDDCR_LP_ValueAcc;
+	uint32_t TDC_VDDCR_LP_ResidencyAcc;
+
+	uint32_t TDC_VDDCR_GFX_FusedLimit;
+	uint32_t TDC_VDDCR_GFX_MaxIrmLimit;
+	uint32_t TDC_VDDCR_GFX_MaxPboLimit;
+	uint32_t TDC_VDDCR_GFX_Limit;
+	uint64_t TDC_VDDCR_GFX_ValueAcc;
+	uint32_t TDC_VDDCR_GFX_ResidencyAcc;
+
+	uint32_t EDC_VDDCR_FusedLimit;
+	uint32_t EDC_VDDCR_MaxIrmLimit;
+	uint32_t EDC_VDDCR_MaxPboLimit;
+	uint32_t EDC_VDDCR_Limit;
+
+	uint32_t THM_FusedLimit;
+	uint32_t THM_Limit;
+	uint64_t THM_ValueAcc;
+	uint32_t THM_ResidencyAcc;
+	uint32_t PROCHOT_ResidencyAcc;
+	uint64_t GFX_TempAcc;
+	uint64_t SOC_TempAcc;
+	uint32_t P3T_FusedLimit;
+	uint64_t P3T_ValueAcc;
+
+	//POWER
+	uint64_t SystemPowerAcc;
+	uint64_t ApuPowerAcc;
+	uint64_t dGpuPowerAcc;
+	uint64_t NpuPowerAcc;
+
+	//FREQUENCIES
+	uint64_t FclkFreqEffAcc;
+	uint64_t MemclkFreqEffAcc;
+	uint64_t LclkFreqEffAcc;
+	uint64_t GfxclkFreqEffAcc;
+	uint64_t SocclkFreqEffAcc;
+	uint64_t VclkFreqEffAcc;
+	uint64_t VpeclkFreqEffAcc;
+	uint64_t AieclkFreqEffAcc;
+	uint64_t NpuhclkFreqEffAcc;
+
+	//BANDWIDTH
+	uint64_t DramReadBandwidth;
+	uint64_t DramWriteBandwidth;
+
+	//ACTIVITY MONITORS
+	uint64_t GfxBusyAcc;
+	uint64_t VcnBusyAcc;
+	uint64_t NpuBusyAcc[3];
+
+	//STT
+	uint32_t STT_MinLimit;
+	uint64_t STT_APU_HotSpotTempAcc;
+	uint64_t STT_HS2_HotSpotTempAcc;
+	uint32_t STT_APU_Temp_Limit;
+	uint64_t STT_APU_SkinTempAcc;
+
+	//RESIDENCIES
+	uint64_t CpuOffResidency_CCX0;
+	uint64_t CpuOffResidency_CCX1;
+	uint64_t CpuOffResidency_CCX2;
+	uint64_t CpuOffResidency_CCX3;
+
+	//DFPSTATES
+	uint32_t FclkFreqTable[8];
+	uint32_t UclkFreqTable[8];
+	uint32_t DdrRateTable[8];
+	uint8_t  DfPstate_Source[8];  //(0=not_trained; 1=fused; 2=EXPO)
+
+	//SYSTEM
+	uint8_t  GfxDisabled;
+	uint8_t  spare2[3];
+	uint32_t GfxClk_Fmax;
+	uint8_t  CClk_CoreFuseEnable[4][12];
+	uint8_t  CClk_CoreEnabled[4][12];
+	uint32_t CClk_Fmax[4][12];
+
+	//OVERCLOCK CAPABLE
+	uint8_t CpuPreciseAndDirectOverClockingCapable;
+	uint8_t GfxPreciseAndDirectOverClockingCapable;
+	uint8_t PboBasicOverClockingCapable;
+	uint8_t PboAdvancedOverClockingCapable;
+	uint8_t PboNitroOverClockingCapable;
+	uint8_t MemoryAndFabricOverClockingCapable;
+	uint8_t MiscOverClockingCapable;
+	uint8_t ExtremeColdOverclockingCapable;
+	uint8_t DownConfigControlCapable;
+	uint8_t spare0[3];
+
+	//OVERCLOCK STATUS
+	uint32_t FIT_LimitScalar;
+	uint8_t  LN2Enabled;
+	uint8_t  CpuPreciseAndDirectOcEnabled;
+	uint8_t  GfxPreciseAndDirectOcEnabled;
+	uint8_t  spare1[2];
+	int8_t   PsmGuardband[5][5][3]; //Curve shaper (5 avfs guardband types
+		 //[CCD0/CCD1/CLASSIC/DENSE/LP] * 5 frequency points * 3 temperature points)
+	int32_t  CorePowerLimitOffset;
+	uint32_t MaxFreqOffset[5]; //5 avfs guardband types [CCD0/CCD1/CLASSIC/DENSE/LP]
+
+	//per-core PSM margin (curve optimizer)
+} MetricsTable_IOD_t;
+
+typedef struct {
+	uint64_t Core_C0[12];
+	uint64_t Core_CC6[12];
+	uint64_t Core_FREQ[12];
+	uint64_t Core_FREQEFF[12];
+	uint64_t Core_TEMP[12];
+	uint64_t Core_POWER[12];
+} MetricsTable_CCX_t;
+
+typedef struct {
+	uint32_t table_size;
+	MetricsTable_IOD_t IOD;
+	MetricsTable_CCX_t CCX[4];
+} SMU_15_0_0_MetricsTable_t;
+
+
 extern void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu);
 
-#endif
\ No newline at end of file
+#endif
-- 
2.53.0

