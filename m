Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E68F8D761
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 17:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1584610E917;
	Thu, 16 Apr 2026 17:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DVEFj6/b";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2540B10E916
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 17:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fE05/tApVY54S0YpW/U92AhEc72SffmnyTYCRT8xHwCzJYtrvVurFulpZnwnfrMi8c4RWDBQWXk0QsdsDlhO8fiQW/qJvw+hXItqNPcbN9cIkvH1qpCJFnbkLeZPYdrLM1YihK36v1G0MjsPPGY1qEMlFbiOFJ30HydnQlcq5qoNvshk4itXceVQUZz4idRI/5DzzPJ9zskkrAjMDTNyoxVm6dNbnq6DKPBtCkKUuN5XsEEV2lzBkUBhn3qpf2DNl45RLBkW7ZIWd5gKOj4+1y9dghEILs2he7IL6yqc2W3aWM/pahShR86QHFibSB9iLVQ47uE0j8lLNCXvsP/Xyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TW/yhCgUe83izubZnDy2Yq4Mu/JSwJO5WdwawAE/So=;
 b=OownvHAfhhTlJCnp8K7BJea5HOI3LzvHLiCv1czMBiqld8nfPpiDeVKDAfkWEh9y3TRNFFj2cPNX/3ZPbndfiTUDleSYryzURFRXOEQUmnjU2o64S+qaT7oBy9oLlHMK0kbQssbieUiNzRED58na7JVEw1H1oDnPPLMOkbWvwJxy9kOlnBRssiVDxdxZDMw/1GJOMZi/RHFfab27QEzaE48Bdi/E/TKzzi5nG/g6BrC19uc565uH4IpXlxNo4dWX83XjEEaBfZLi8KOTzdvHcRJJM0SOFfWWTd0XtqzywVYqkoM/0I5N12r94EysMjg6auwXGdjTGvALA2WF0qF22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TW/yhCgUe83izubZnDy2Yq4Mu/JSwJO5WdwawAE/So=;
 b=DVEFj6/bVVCQewVbBKsroG/2vWGV8b5s0OF17HCVRZDBeUJBcRphn7Ct8FGnyGiiZpFiITlCf23hrSJls2ib/B1nc4hVhiUcLA+xAdKA8OucIm+SbIrVRACNM9rhC+wiyju+fCa1g04jur8d87fxw+TjxhVKUDyiQoIUfAKFw2I=
Received: from SJ0PR13CA0067.namprd13.prod.outlook.com (2603:10b6:a03:2c4::12)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 17:32:07 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d2) by SJ0PR13CA0067.outlook.office365.com
 (2603:10b6:a03:2c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 17:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Thu, 16 Apr 2026 17:32:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 12:32:07 -0500
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 10:32:04 -0700
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>,
 <KevinYang.Wang@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH v3 1/4] drm/amdgpu: smu: add unified metrics table support for
 SMU 15.0.0
Date: Thu, 16 Apr 2026 23:01:42 +0530
Message-ID: <20260416173145.856326-1-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9339ec-f08f-4627-ff7f-08de9bde151c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Bf6QzvEJD1tcWMjwxJho8iv7ZdfsYqpUn/2wWgLg1H/yW1eReJTYJQo/XmUCVlEgqGnZuoLFUHqcWdQoZlzvJo5mNRsA68TnSDYgMg1luCP98ZsxSfnb9gkSV1huTf5VgSfPYk2FwKk1yb76Nbmd80PFRRvJ3Awq3mPxTQ8eauJ+WNuUdvIvWeu3WB/AveEBNmomDRCGmB0uhYxOPMXIg6srF2nZf5PS7RyFkgFwQIF72uWqbGIbc+9tDy6tUyojYjdFiq8WuuVTTgrcXQgZyhOYOLaY0CfuzImJAv9Pfo355/HX8st1s6+fClsqZuRJqTHKg2TsAPKlx0sqnILvtvntXJXOsQOyd7nEtyF/TeOBiTF6NZqQjCa5xhmMpxu/KXyzDvlTLPD0vrSghCLBZXP6pRM8r/nXr//YYP8wM95SF8aihPwFW1bjwhxwqG9EqtTDqECrTKt1c/pOQffAP5jHNxUf95Qhw+gNGjhZQExtRBAKVoMCemcbT7ttatkM9KfFgkMHzoOeukPgQ3k3KmgfK/hP8nl0GBdPesmGoGMy89qmgSgvGetu19HJVyQ7VELocRWnC1OayId5m+E3tSzin216oJj00mjOHTBpdrRoJmcCHV9vlXhvn+7M+45ceQc5O6GMXH2LTHHPh+HKDnwU4WBlAHk6/XFE9QEL9liMOGGWng0mCWRjC3jtUw/bD4wlGppRdCOq9JnY6O/s/kY7XhY3SZb11WBbaAt5TdAQ4nfESKGJjcqLM+wHjQvL0CNENBqSVpA83WHhiaO4BA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: livY36t0VAGKa9mRPXVLYCaBmcuYXIss9p69AhV6vD5va4M8jmD9XurMh9sEg+U9YLzrdBBNnqTxEbyFlxRKsP1W0E2CEUiHhfo0WYc/bckP96dSgbAy0hD+nAazid5JcF/4jUp2tRl60V+s9YROrfmMRjatHxa8Cb8y8kemqqLxMdiXdSzz/fTv+mftld3UB6TXdytl7K+3kGNhAo7zdigYfinjg2b3L7HPr83hLexmP6kQ0BcmvMlarWyMu/A12Yz4b2Io2OACl61WDW86MwAVAe2siPCO+nXzqLSA+qjUV7IoPvNtiopFIDGN7YERfRFjM9CEUZP57uvCVD3T3I5/T5Z3R25iIjx6owf+lokwWPMK/YRnxxej0Rvfy1Jh0ojjjRWlY2+Inv/C3g6wI38AcCbayprC+wfnmpDPQErQP+7QE8ZuiwoO/oKCYjCD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 17:32:07.1758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9339ec-f08f-4627-ff7f-08de9bde151c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
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

