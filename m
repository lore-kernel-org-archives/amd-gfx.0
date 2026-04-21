Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169B4F327DB
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D92410E8FD;
	Tue, 21 Apr 2026 17:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="myOXWr73";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7A710E8FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwUHw4bWzLHXp6XBsdt+7agy/Dpl0SukHPPim1NEZ0Ot9iPoIGbzGgI9h5m4IvPNRrmdpOqNl6HzR7draS5/UVFDuwIRc6QD72zQ9Gep8F1XnJEj3QffU5YhY8abdAnfGR12/vy46w29QsANt2TfXMhe+LqOkhZ6AnYOUdyr7x1Le3tkfp4w7x9OevmkLO+lUsJErLHw2U3kF7oZC9AVzeu/vw3v1PxGLd4u6XQlqU03w3KCaxoMw0aBovxcRfBv9WqNvzm4QFx1SI/NPGLGzjq2sbm+au9uilpDRv5Xaw3+xGm8B+Cpf0mZ9/y8HB4sN/XorqXNKCrptYB+r2suXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkeFbr2iF8ky0sgYYkh+PY/dDf6IxecuQlDCPbuWRSM=;
 b=hjtjf5uS3CW2wSe52BZfXjMpObWxx5cW4TV6ad40oFSWZeAQtj541n9qlq8xEg20SMpOsauZP99OAVI8AMywFfbib0z6RxSI8Ydfgc7nrrLtz9l+mr8r2ThvP2Yu8TZLA6ZccHck3QtkSYiCJUdad3WTuCxfEC5mdVZmZNNRcRsFmrfFG+BN6sMOvS/zQxTzGUWIZDTyVnA+H0IjcM1/9/nXCH10Yw4R2maSkOGpknvLK+0eNRrnDN+CeyMv+8W78KTis59tewCc4fJyyt2nBlX8hkCB7t7CB8CY8mLEoWrrymaczwtqpVFUbljuZjBPFpYUvioLgZiPEmRSf5tP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkeFbr2iF8ky0sgYYkh+PY/dDf6IxecuQlDCPbuWRSM=;
 b=myOXWr73v9gs/bGsrH+WhSk1P/c4yK94pKFLCTpX6Htu+4lNWARh6HUOzg8oBj0wfZmp1w53bKRfQRPvZDu7MK7DVFFngYmKn0FSzTwCk/qg5A/VDpukzwTXdy0Kj17c48thR/uM0Sza3rYbYT8M+K1RlRFF47rRuu8D0m60/+8=
Received: from BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::30)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Tue, 21 Apr
 2026 17:43:01 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::18) by BL1P223CA0025.outlook.office365.com
 (2603:10b6:208:2c4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 17:43:01 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 12:42:58 -0500
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>,
 <KevinYang.Wang@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH v4 3/3] drm/amdgpu: smu: cache and reuse averaged unified
 metrics values
Date: Tue, 21 Apr 2026 23:10:14 +0530
Message-ID: <20260421174014.3284999-3-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421174014.3284999-1-Kanala.RamalingeswaraReddy@amd.com>
References: <20260421174014.3284999-1-Kanala.RamalingeswaraReddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: cd26e1c3-5b46-44a1-b87b-08de9fcd6f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: YF2fGiBMQKAIFD2g17CmEyCzAp8RhDgQ8PCmJI/QPeiBT1sC+pNq7Vf19reLdg2+IFEZiuH/lVE6VzwkvPqbSugQA0JpJ7t5nOSqDmiNaDv03TGBhsIgzMiuV327C8DH177yX9uAsHbTcSuzow026ChJfvv80t5vxwy7Ro9eb0dV7xCfCF6mdJNSp6xJFgcxSXmKocaQvH7vjo5e3IQ+JHpXjrh7IJQRs/DjIxYGLqBTAdPeBPn08HzpzarFuQsTzmf2hxJzrk6+zuRJFO/+9nBVzCVqzO1qFFaFpvV/QiTiVhQFRxAFJW9HXbrGruS7BZkgVaWQwPxoMdCtP5wPZP6tZ+rkKTIp8Y3TOuI4WBUBI8GohZmoV1MwZn/zLzBDvi3KHfkoF5ZzmEFcOxIssyOtRPHGh8gRxUq9uQdKeYo089Bl9HRE7//qT/bRU7kn3t0kO2H2bbAHOctGuITm1whqPa+yv+whIVgY0wTqISTpc6qPsSnX3rzzuflgsDB7rLYx812LnRb7pfu7Wl5awFl817PbEaWE6A87baynfEyw0wAMKjXkHJDCeemYs+7UI7KhTk1sBmeIEXGBrthSQR/ltgC86jlWQJTGQf97yi+pDyCLcTj7hLuZnMrY0BalIiKRyoPnJ6g8bOOeupaVHNs1+wgG8lBK5MUjo/rENqNnFIgck7FCaAIfHHTg7XDqqiGvhxn48w/2obVYg5iGPHtUYReOOVKz1mcF69YxRodLguK1DLVfJ8qGZIZlD68U0HCl8s7gPoN5sNUvef6Bsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +HvHaqFS3fuJUKvz3q61/gfvbEA5OZLae32uALaH3SmjqKBwGFXWWtOp/ROAgTuw3Y/VHzRIWiAWivr/3ZnALIKB79wolvB1lLJYAP32ZyGR3SAvwka2subcJ1FJ7vWc6xDGMLmC+sTVK3sgDBXMTUTRiR5yLOPVMx82h9xAdewtK5ZpyaZGJjQ1SpKenqP6qRRmX/XrQ7+y8sVsmR3GGQ5GXq7YrY0JcCQL8xmEB6jsRGMN0uikiuuv43c3jftxDz3NOFztiJ3+a2a7RM/FADuNJCrnuYpf9O9x+22RDL937BBREZz3UKt4bLO+8+4cc5u58SGyq8Bf76Vo8c/eO9EWpDZnkKY8z6oYqKsrQPIAQsQQN8CXTus4g2D9P8YP15MF+GQoS3tdYzB/0f4geVTmm+pUSeQ06aXLKrpAbVKSFga/qH9ubM+KPVqfwca0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:43:01.4534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd26e1c3-5b46-44a1-b87b-08de9fcd6f24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012
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
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 169 +++++++++++-------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |   9 +
 2 files changed, 115 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index f2549754e8e9..6635177881e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -173,10 +173,10 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SMU_15_0_0_MetricsTable_t),
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SMU_15_0_0_MetricsInfo_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
-	smu_table->metrics_table = kzalloc(sizeof(SMU_15_0_0_MetricsTable_t), GFP_KERNEL);
+	smu_table->metrics_table = kzalloc(sizeof(SMU_15_0_0_MetricsInfo_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		goto err0_out;
 	smu_table->metrics_time = 0;
@@ -334,16 +334,13 @@ static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
 
 
 static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
-					SMU_15_0_0_MetricsTable_t *metrics)
+					SMU_15_0_0_MetricsInfo_t *metrics_info)
 {
 	void __iomem *cpu_addr = NULL;
 	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct smu_msg_args args = {0};
-	/* store table_size and DramAddr value returned by SMU in static at first request,
-	 * use these valuse to read LogSample in case of later requests
-	 */
-	static int table_size;
-	static uint64_t addr;
+	int table_size = metrics_info->table_size;
+	uint64_t addr = metrics_info->addr;
 	int ret;
 
 	if (addr == 0) {
@@ -360,6 +357,8 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 
 		addr = ((uint64_t)args.out_args[1] << 32) | args.out_args[0];
 		table_size = args.out_args[2];
+		metrics_info->addr = addr;
+		metrics_info->table_size = table_size;
 	}
 
 	cpu_addr = ioremap_wc(addr, table_size);
@@ -374,9 +373,9 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 	if (!ret) {
 		amdgpu_hdp_invalidate(smu->adev, NULL);//best to flush before copy
 		if (table_size <= sizeof(SMU_15_0_0_MetricsTable_t))
-			memcpy(metrics, cpu_addr, table_size);
+			memcpy(&metrics_info->metrics, cpu_addr, table_size);
 		else
-			memcpy(metrics, cpu_addr, sizeof(SMU_15_0_0_MetricsTable_t));
+			memcpy(&metrics_info->metrics, cpu_addr, sizeof(SMU_15_0_0_MetricsTable_t));
 	}
 	iounmap(cpu_addr);
 	return ret;
@@ -396,134 +395,173 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	struct smu_table_context *smu_table = &smu->smu_table;
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table; //TBD
 
-	SMU_15_0_0_MetricsTable_t prev_metrics;
+	SMU_15_0_0_MetricsInfo_t *prev_metrics;
+	SMU_15_0_0_MetricsInfo_t *curr_metrics;
 	uint64_t counter, val;
 	int ret;
 
-	memcpy(&prev_metrics, smu_table->metrics_table,
-			sizeof(SMU_15_0_0_MetricsTable_t));
+	prev_metrics = kzalloc(sizeof(SMU_15_0_0_MetricsInfo_t), GFP_KERNEL);
+	if (!prev_metrics)
+		return -ENOMEM;
+
+	memcpy(prev_metrics, smu_table->metrics_table,
+			sizeof(SMU_15_0_0_MetricsInfo_t));
 	ret = smu_v15_0_0_get_metrics_table(smu,
-			(SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table);
+			(SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table);
 	if (ret)
 		return ret;
 
+	curr_metrics = (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
+
+	if (prev_metrics->metrics.IOD.AccumulationCounter ==
+		curr_metrics->metrics.IOD.AccumulationCounter) {
+		*value = prev_metrics->avg_metric[member];
+		kfree(prev_metrics);
+		return 0;
+	}
+
 	switch (member) {
 	case METRICS_AVERAGE_GFXCLK:
-		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff_val(prev_metrics.IOD.GfxclkFreqEffAcc,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GfxclkFreqEffAcc);
+		counter = get_diff_count(prev_metrics->metrics.IOD.AccumulationCounter,
+				curr_metrics->metrics.IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics->metrics.IOD.GfxclkFreqEffAcc,
+				curr_metrics->metrics.IOD.GfxclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_AVERAGE_SOCCLK:
-		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff_val(prev_metrics.IOD.SocclkFreqEffAcc,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.SocclkFreqEffAcc);
+		counter = get_diff_count(prev_metrics->metrics.IOD.AccumulationCounter,
+				curr_metrics->metrics.IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics->metrics.IOD.SocclkFreqEffAcc,
+				curr_metrics->metrics.IOD.SocclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_AVERAGE_VCLK:
-		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff_val(prev_metrics.IOD.VclkFreqEffAcc,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.VclkFreqEffAcc);
+		counter = get_diff_count(prev_metrics->metrics.IOD.AccumulationCounter,
+				curr_metrics->metrics.IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics->metrics.IOD.VclkFreqEffAcc,
+				curr_metrics->metrics.IOD.VclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_AVERAGE_DCLK:
 		*value = 0;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff_val(prev_metrics.IOD.MemclkFreqEffAcc,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.MemclkFreqEffAcc);
+		counter = get_diff_count(prev_metrics->metrics.IOD.AccumulationCounter,
+				curr_metrics->metrics.IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics->metrics.IOD.MemclkFreqEffAcc,
+				curr_metrics->metrics.IOD.MemclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_AVERAGE_FCLK:
-		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff_val(prev_metrics.IOD.FclkFreqEffAcc,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.FclkFreqEffAcc);
+		counter = get_diff_count(prev_metrics->metrics.IOD.AccumulationCounter,
+				curr_metrics->metrics.IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics->metrics.IOD.FclkFreqEffAcc,
+				curr_metrics->metrics.IOD.FclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_AVERAGE_VPECLK:
 		*value = metrics->VpeclkFrequency;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_AVERAGE_NPUCLK:
-		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff_val(prev_metrics.IOD.NpuhclkFreqEffAcc,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.NpuhclkFreqEffAcc);
+		counter = get_diff_count(prev_metrics->metrics.IOD.AccumulationCounter,
+				curr_metrics->metrics.IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics->metrics.IOD.NpuhclkFreqEffAcc,
+				curr_metrics->metrics.IOD.NpuhclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff_val(prev_metrics.IOD.GfxBusyAcc,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GfxBusyAcc);
+		counter = get_diff_count(prev_metrics->metrics.IOD.AccumulationCounter,
+				curr_metrics->metrics.IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics->metrics.IOD.GfxBusyAcc,
+				curr_metrics->metrics.IOD.GfxBusyAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
-		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff_val(prev_metrics.IOD.VcnBusyAcc,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.VcnBusyAcc);
+		counter = get_diff_count(prev_metrics->metrics.IOD.AccumulationCounter,
+				curr_metrics->metrics.IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics->metrics.IOD.VcnBusyAcc,
+				curr_metrics->metrics.IOD.VcnBusyAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff_val(prev_metrics.IOD.ApuPowerAcc,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.ApuPowerAcc);
+		counter = get_diff_count(prev_metrics->metrics.IOD.AccumulationCounter,
+				curr_metrics->metrics.IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics->metrics.IOD.ApuPowerAcc,
+				curr_metrics->metrics.IOD.ApuPowerAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		curr_metrics->avg_metric[member] = *value;
+		break;
 	case METRICS_CURR_SOCKETPOWER:
-		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff_val(prev_metrics.IOD.SystemPowerAcc,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.SystemPowerAcc);
+		counter = get_diff_count(prev_metrics->metrics.IOD.AccumulationCounter,
+				curr_metrics->metrics.IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics->metrics.IOD.SystemPowerAcc,
+				curr_metrics->metrics.IOD.SystemPowerAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
-		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff_val(prev_metrics.IOD.GFX_TempAcc,
-		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GFX_TempAcc);
-		*value = counter ? (val/counter)/1024 : 0;
+		counter = get_diff_count(prev_metrics->metrics.IOD.AccumulationCounter,
+				curr_metrics->metrics.IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics->metrics.IOD.GFX_TempAcc,
+				curr_metrics->metrics.IOD.GFX_TempAcc);
+		*value = counter ? (val/counter) : 0;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
 		*value = metrics->SocTemperature / 100 *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_PROCHOT:
 		*value = metrics->ThrottleResidency_PROCHOT;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_SPL:
 		*value = metrics->ThrottleResidency_SPL;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_FPPT:
 		*value = metrics->ThrottleResidency_FPPT;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_SPPT:
 		*value = metrics->ThrottleResidency_SPPT;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_THM_SOC:
 		*value = metrics->ThrottleResidency_THM_SOC;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_VOLTAGE_VDDGFX:
 		*value = 0;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	case METRICS_VOLTAGE_VDDSOC:
 		*value = 0;
+		curr_metrics->avg_metric[member] = *value;
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
+			curr_metrics->avg_metric[member] = *value;
+		} else {
 			*value = 0;
+			curr_metrics->avg_metric[member] = *value;
+		}
 		break;
 	case METRICS_SS_DGPU_SHARE:
 		/* return the percentage of dGPU power with respect to dGPU's power limit.
@@ -531,17 +569,22 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		 * boost/shift is only when the percentage is more than 100.
 		 */
 		if ((metrics->dGpuPower > 0) &&
-		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
+		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit)) {
 			*value = (metrics->dGpuPower * 100) /
 				 (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
-		else
+			curr_metrics->avg_metric[member] = *value;
+		} else {
 			*value = 0;
+			curr_metrics->avg_metric[member] = *value;
+		}
 		break;
 	default:
 		*value = UINT_MAX;
+		curr_metrics->avg_metric[member] = *value;
 		break;
 	}
 
+	kfree(prev_metrics);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
index 592bb0f8ee96..d4708ad23bcd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
@@ -23,6 +23,8 @@
 #ifndef __SMU_V15_0_0_PPT_H__
 #define __SMU_V15_0_0_PPT_H__
 
+#include "amdgpu_smu.h"
+
 #define MAX_UINT32 0x00000000FFFFFFFF
 #define MAX_UINT64 0xFFFFFFFFFFFFFFFF
 #pragma pack(push, 1)
@@ -220,6 +222,13 @@ typedef struct {
 } SMU_15_0_0_MetricsTable_t;
 
 
+typedef struct {
+	SMU_15_0_0_MetricsTable_t metrics;
+	uint32_t table_size;
+	uint64_t addr;
+	uint32_t avg_metric[METRICS_AVERAGE_NPUCLK+1];
+} SMU_15_0_0_MetricsInfo_t;
+
 extern void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu);
 
 #endif
-- 
2.53.0

