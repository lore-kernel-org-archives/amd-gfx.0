Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F91C531C9
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 12:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F56710F3A3;
	Fri, 24 Jul 2026 12:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3/kJQLIy";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E7010F39B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 12:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T43+gjYrduB9ZgFLI1wZMYINfCgovuWuWV8mW8Ld+JCsoB1XirAvqyG9QDZT/EnnU3fuhTb4eiu/K1qf9L0I0RQAGxNFUH4QgPwyQobOaezpBb+W6MZM/JKryoWbCwRu4OE3hZ00QEamjD2eg+gGRi3Hf6Tnvedsil3511Ju175Uo5DinjK1GaUSAUhdGkuNDG9yUC6NO9IGkxKDj6/8c5ybwswD28UkMrhmg3eE3FpQQEbmAcx076zLo8r6G8RyeA0PQtxgPA3tOfzzA0l7rmdPWS+8dfna2kIz3v2NqLf0SP2LncJs1XBNW5ttl01VpLnTiO/nAnEDzqm8k6OTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XThAuO0TaxvljC9vY0YWNhYJBAfWj8O5tZYm01juCo=;
 b=GBflyi/dSbFN7bki1Y4pbCEUC4BJA2Spfb0YswgmRv7D2iwUFSvs98prNFO6nXn01nqy2fc+92kXL+6eSIDe+5CURHdfwd6TlTIWMflU+G/Dk/ZDj5JeSrv6iwNqVIP3o3Dcnhb0VnQBv28z51ZnLqnADm7Zmkr3wkCSmXt2GtsQMxpubUAvOs5fXuy+xockE+n/q6zjsrPuH5jctfBTgs/zvtwnsmCy1VBe8pox6QGBGrx/cKvsDCesigJC73K4vqV6hGboe8/mlRT6oPRRzI5Iygu0dLGdNcpzFpXIYlveJV2CkyPYiBI8qOenJsu/JH8aeJYkG/NthpMv5NH+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XThAuO0TaxvljC9vY0YWNhYJBAfWj8O5tZYm01juCo=;
 b=3/kJQLIyLbZ9ONpF+2bcU4wtHhl9mLCFf8fezNWozRinjTkDTlLXG9cRMtDz5H87N8tH3R8cp1qLoH9+0Ag/98Vai4BMD4IEPNYL1x9du+MpriSCVTOrRNpKn+RzKbSsdDPX0x//RI6sGH0+87SBHji9jvBtdY8lRJasZTwFr6k=
Received: from BN9PR03CA0272.namprd03.prod.outlook.com (2603:10b6:408:f5::7)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 12:04:33 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::31) by BN9PR03CA0272.outlook.office365.com
 (2603:10b6:408:f5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 12:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 12:04:33 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 24 Jul 2026 07:04:30 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>,
 <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Veerabadhran.Gopalakrishnan@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Suresh.Guttula@amd.com>, <Kanala.RamalingeswaraReddy@amd.com>, "Shubhankar
 Milind Sardeshpande" <Shubhankar.MilindSardeshpande@amd.com>
Subject: [PATCH V3 3/3] drm/amdgpu/smu15: set up metrics DRAM mapping and prev
 buffer once
Date: Fri, 24 Jul 2026 17:33:44 +0530
Message-ID: <20260724120408.3364408-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 19aac856-5a80-4057-555e-08dee97bb971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|11063799006|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: LQnaYQgMRkyOwsUyDVU8uz7M4sAQLHk93W9CegaHqIOwxRUA0CdBp1/12rdqhMLK5R1ttUn2EOJPMOtCsPtLkqaeCL2PNutdlrUz6GezPAcDO2EMZQ/GStQiZWzDBV5Xbab8AQ9apABlmjktpQ0+r3RGKkZCA+O30c/ao6CR7MXiD5YenW7obIw3atmDp4wKsSeOT2drV7bUm32TKrivi2Q5nseCg+0Wnk7QQN1yiQJzwV13tof5qljS/usvMLmExThQqXk/7/+XUNweIU3MqMoHGdkfJMMtBEkGOl0dIV4PJ2zBUGgUa/oQbbn+mMAYkhfDoY/I/9D7RHTSV5VBNIiTmE0G1voaLi0mZDo6xNYC4j88c9SwdKUVjNJTPBXRQA50idqEh2QrdTyToppu8Qw7zZZzLc7ZNLEPwXjWsu8+BNv+3TX+Dm2T/7Sm+sUeKe12QJdeeLHFVKdK1hGmnbs72whV4P/94YZVx/riJtM4PMTXUZ9jBEb/nPpA91P4KpWoKn5H5MfolWYXt5pyOXKjs6mEeYIgRHOCx+Pv/w0Eqz9m8FDBvGQsMkJMnT/QG8qh1jo3Yv06H464b945b3agyBGpuy77WK2MTM1VghA+xxFPPpi0qSTRq1PbX1yMwtp6h9V5gbamyEVOWPzwRY4dNyJfyp/0s0LJ47phwikUQKwcaq4q3/wbC1N9BQrVQVI+Wc9z2g8eJEfHEJyIUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(11063799006)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SI6ExfBq5Np/uCATwbGrSwKEq94ZHiwcAKlzpW3sOa5jqaMwBa3YgvvyAbCnGe1tmBFO/iUIZVIfvld4Y5NmuVoCHkI4rDHSN5BhyhmAFGYY+Lu96zWoS7fGZp/kQOP2KHfSmUj1T401o4dirB3K8gKnBhrhnqruhci/AUDiumvRPIE3qtTwgTu6e2j4t14W8pF8DAMRekhLj2meSQpRS1vYscLG9N8eDAGlMN3qd13ozh6Ip7uixhp2CXnPAuaBB/EmjMXdN1CudSUMQ8PFLh3mua1euZFdYYHZwa09FutVAxOLohfROgTbWeH6QaQ9I7HgPjJmlUATy3mO8+EnJUvlXk48IVdopJllDumLeM64KEDDckC1GQzFoTWMocLdKE+UjfwIOhtrpF2iJaZmociIqvTMf24iDNiRDChySir33JfiCCfi+9vuzcutbLhP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:04:33.4199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19aac856-5a80-4057-555e-08dee97bb971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
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

The metrics path re-resolved and ioremap()'d the firmware log DRAM
address on every read, and kzalloc()/kfree()'d a previous-sample
scratch buffer on every sensor query.

Set both up once at table init and tear them down at fini:

- Add cpu_addr and prev_metrics to SMU_15_0_0_MetricsInfo_t.
- Add smu_v15_0_0_get_metrics_table_dram_addr() to query the address
  and ioremap_wc() it from init_smc_tables(); allocate prev_metrics
  there too, extending the error-unwind ladder.
- get_metrics_table() reuses the persistent cpu_addr.
- get_smu_metrics_data() reuses the persistent prev_metrics buffer.
- fini_smc_tables() iounmap()s cpu_addr and frees prev_metrics.

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 99 +++++++++++--------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |  2 +
 2 files changed, 62 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 1d268a02992e..31cf538246fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -165,10 +165,37 @@ static struct cmn2asic_mapping smu_v15_0_0_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP_VALID(DPMCLOCKS),
 };
 
+static int smu_v15_0_0_get_metrics_table_dram_addr(struct smu_context *smu,
+					SMU_15_0_0_MetricsInfo_t *metrics_info)
+{
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct smu_msg_args args = {
+		.msg = SMU_MSG_GetMetricsTableLogDramAddr,
+		.num_args = 0,
+		.num_out_args = 3,
+	};
+	int ret;
+
+	ret = ctl->ops->send_msg(ctl, &args);
+	if (ret)
+		return ret;
+
+	metrics_info->addr = ((uint64_t)args.out_args[1] << 32) | args.out_args[0];
+	metrics_info->table_size = args.out_args[2];
+
+	metrics_info->cpu_addr = ioremap_wc(metrics_info->addr,
+					    metrics_info->table_size);
+	if (!metrics_info->cpu_addr)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	SMU_15_0_0_MetricsInfo_t *metrics_info;
 	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
@@ -197,8 +224,24 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 	if (ret)
 		goto err3_out;
 
+	metrics_info = (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
+
+	metrics_info->prev_metrics = kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
+	if (!metrics_info->prev_metrics)
+		goto err4_out;
+
+	if (metrics_info->addr == 0) {
+		ret = smu_v15_0_0_get_metrics_table_dram_addr(smu, metrics_info);
+		if (ret)
+			goto err5_out;
+	}
+
 	return 0;
 
+err5_out:
+	kfree(metrics_info->prev_metrics);
+err4_out:
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 err3_out:
 	kfree(smu_table->watermarks_table);
 err2_out:
@@ -212,6 +255,16 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 static int smu_v15_0_0_fini_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	SMU_15_0_0_MetricsInfo_t *metrics_info = smu_table->metrics_table;
+
+	if (metrics_info) {
+		if (metrics_info->cpu_addr) {
+			iounmap(metrics_info->cpu_addr);
+			metrics_info->cpu_addr = NULL;
+		}
+		kfree(metrics_info->prev_metrics);
+		metrics_info->prev_metrics = NULL;
+	}
 
 	kfree(smu_table->clocks_table);
 	smu_table->clocks_table = NULL;
@@ -334,41 +387,20 @@ static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
 	return 0;
 }
 
-
 static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 					SMU_15_0_0_MetricsInfo_t *metrics_info)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	void __iomem *cpu_addr = NULL;
+	void __iomem *cpu_addr = metrics_info->cpu_addr;
 	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct smu_msg_args args = {0};
 	int table_size = metrics_info->table_size;
-	uint64_t addr = metrics_info->addr;
 	int ret;
 
 	if (smu_table->metrics_time &&
 	    !time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1)))
 		return 0;
 
-	if (addr == 0) {
-		struct smu_msg_args args = {
-			.msg = SMU_MSG_GetMetricsTableLogDramAddr,
-			.num_args = 0,
-			.num_out_args = 3,
-		};
-
-		ret = ctl->ops->send_msg(ctl, &args);
-
-		if (ret)
-			return ret;
-
-		addr = ((uint64_t)args.out_args[1] << 32) | args.out_args[0];
-		table_size = args.out_args[2];
-		metrics_info->addr = addr;
-		metrics_info->table_size = table_size;
-	}
-
-	cpu_addr = ioremap_wc(addr, table_size);
 	if (!cpu_addr)
 		return -ENOMEM;
 
@@ -384,7 +416,6 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 		else
 			memcpy(&metrics_info->metrics, cpu_addr, sizeof(MetricsTable_t));
 	}
-	iounmap(cpu_addr);
 	return ret;
 }
 
@@ -455,25 +486,16 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    uint32_t *value)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-
-	SMU_15_0_0_MetricsInfo_t *prev_metrics;
-	SMU_15_0_0_MetricsInfo_t *curr_metrics;
+	SMU_15_0_0_MetricsInfo_t *curr_metrics =
+		(SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
+	SMU_15_0_0_MetricsInfo_t *prev_metrics = curr_metrics->prev_metrics;
 	int ret;
 
-	prev_metrics = kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
-	if (!prev_metrics)
-		return -ENOMEM;
-
-	memcpy(prev_metrics, smu_table->metrics_table,
+	memcpy(prev_metrics, curr_metrics,
 			sizeof(SMU_15_0_0_MetricsInfo_t));
-	ret = smu_v15_0_0_get_metrics_table(smu,
-			(SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table);
-	if (ret) {
-		kfree(prev_metrics);
+	ret = smu_v15_0_0_get_metrics_table(smu, curr_metrics);
+	if (ret)
 		return ret;
-	}
-
-	curr_metrics = (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
 
 	if (prev_metrics->metrics.IOD.AccumulationCounter !=
 		curr_metrics->metrics.IOD.AccumulationCounter) {
@@ -483,7 +505,6 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 
 	*value = curr_metrics->avg_metric[member];
 
-	kfree(prev_metrics);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
index 8ee45591e9a6..27e7c60be15c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
@@ -31,6 +31,8 @@ typedef struct {
 	MetricsTable_t metrics;
 	uint32_t table_size;
 	uint64_t addr;
+	void __iomem *cpu_addr;
+	void *prev_metrics;
 	uint32_t avg_metric[METRICS_AVERAGE_NPUCLK+1];
 } SMU_15_0_0_MetricsInfo_t;
 
-- 
2.43.0

