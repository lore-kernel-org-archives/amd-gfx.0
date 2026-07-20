Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF11C44515
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 14:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 136BA10E95D;
	Mon, 20 Jul 2026 14:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JDSAVOxT";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E4910E95D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 14:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAfXClye5kmb9Op2IqIijP/PxE09AJGkmD7RBAbg4hfROdtW7IUgdH6WRXcj3R3ZOvmIf3yvihojaUu1QhWtjQj1FfBVzXPzEMS5o1f2CcaLI508V1F3ayE6Yg3h001xn51feTPWUOoSLrMK+23ceCZpgaHHbMInWkjpLy/VkOYoEweHqU3o/Uij4brklEMKj14R9NVAFSqIgBz64JSVeVR0pNFdfT7o4sJk0GOxtFuNWBuBgl60nhTS+uKLSImyNo0Iry3SIuMokh+I55VN20wd4ox5q/QrJfS1kq5Ek4ade7/6azMqZWukugOpIwgfsxJosxmkMEnYyr3h8QA8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnWS5rMHfvjQwnSYT/0tlrGuqx8kDmI3/5z+COu+0bo=;
 b=DheU1TTp2Cjp17v5ThxhHAslH57a7hlOeJ0xSC/9GCpxxhRu+FW+kllg+UatSNtRf0eUoPALYhZvS2hviUtswiwiaA6wNiLHnHp5enmmJ18g9IGYVA0PJ+lAMQZyfGGZeL/7QC13elBHt29Q350QO85pmy+PRaPXEUYMBWZa+uVmEYTpx/V9MWxDMqi0dSN/ruB7xjU8kVcQrRVaj1Se5rb0difz11ryylcFJq7topA4OjqQwME+nBxKY5HEq1Dg8+qiX8KwEXFzGsP0+rGJHjlVq/bZxuuvJiUa8jnPs5uiuJ0MHBvzE6EatpINzVjtZX+3UzRRabECUgeHxiRB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnWS5rMHfvjQwnSYT/0tlrGuqx8kDmI3/5z+COu+0bo=;
 b=JDSAVOxTpMeD5t6fQOlx1Lbik43cd3ivM9zOxdagMcTL0Ijm+KB7kQdHRydZol++jfTYzVvq+I1Rz+Vmtkf7Y52OBAhaFZgdOjeMEzWwx+llU2Kqu8FjsCEgrWGNU/wl+viBfPxWaj5lWSTx9/XO6Olb4laZ6mSMXnNS2kX3Qm4=
Received: from MW4PR04CA0350.namprd04.prod.outlook.com (2603:10b6:303:8a::25)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 14:36:35 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::82) by MW4PR04CA0350.outlook.office365.com
 (2603:10b6:303:8a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 14:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 14:36:35 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 20 Jul 2026 09:36:31 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Christian.Koenig@amd.com>, <Lijo.Lazar@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Shubhankar.MilindsSardeshpande@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>, Shubhankar Milind Sardeshpande
 <Shubhankar.MilindSardeshpande@amd.com>, Suresh Guttula
 <Suresh.Guttula@amd.com>, Kanala Ramalingeswara Reddy
 <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH 2/2] drm/amd/pm/smu15: switch to DRAM-based accumulator
 metrics for SMU v15.0.0 using the newly added metrics table
Date: Mon, 20 Jul 2026 20:03:33 +0530
Message-ID: <20260720143545.805691-2-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720143545.805691-1-Shubhankar.MilindSardeshpande@amd.com>
References: <20260720143545.805691-1-Shubhankar.MilindSardeshpande@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: f833ba71-5785-44cc-9d21-08dee66c4cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 0dDwVLNx+t5vbuydhBLs6G28UVsOy7JHwCS6OL2k9wI+ccSEXUiK81Lr0pJLCUYSdK0X8GjR/BsZzkH2WtAnnO+X1Fn5mDdA8i7fo4fybW7NHZl9IuianMuo/RbAFFc7pG0uFQJoCrVdxc55ey2hmH3dfpgFxArbakA2YVTmjzeTjQjQiJhge7eBU+LdUgsy0pDbJak0HNzAAEFRjVE1cVRCQ8mxswwbsNIG/St49Q5z+LmO4sLMy3M8wrJCYCpR+uTpn6etKOhFmhk+Y3ZQFilkoSfcMnm8ZJG7gpqYqCEo/r2eO1bk0DlwPp07lA5yESUmfoRPUsZlodZouyK2SCUhFEfIZUHpsLqI6bjhvpSp+uBroQuEfhm4rY6dOrqAtBIO0WAntWBX5iBFgMHdVfe5cOmdwzTq3m0AQIsTWt+hzb5/TcWxZRzK1Y9zjgnNWaG/CSz3gibab+zbw43jc/vg6E0CZF7ONg7bjk9+1+S7IuscIMVzC+/b916ZoNMiLR2/2IOMcdk9G4lJyFUGEuHizzPmeKT7wt8QMpsVcr7zeZ2enCLxaZsX5vZlR90VAREmC2mmDANre9g+Fqu45EiQyzbZNYQhEYLM7eXZVfFWPFl4Fe2r9UoPFurDDU0Y7OQAxlLPJ/1MYRPd2/dSUCB3LIrnN/wjnVmIe+VNs3tXvitwl+nVvv+TbC07D+Px
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZsxjQ/aseWBenav8XaNtCkgOhiWLE/QgHxVCEqWSTDw1aOX3tLVjOvCLWTrGBdosVWfkMVt+m7n38VI1J8FVBJ/h3u23ECGcab8bcx6YQUM/QjFJfwqEtkZkjvhp2xGo8Zy/8gE8UYD7jtIILqEjRYgCBeZyZ2jwq7zT/v7azjd0cLVxZ3l2RuyUJ0ZUH7BvsqLPTQS3s6ZGO/Jq5ypyNB0rhXFG3I0oIgP7QV+PQ1haAesYFknpD4c0fXf+58Zk/1L2AqaMwiDGwS9c1ulTlIXOQyygDIygvUTpo8ApH4WFry57Qk3VG5qW34CH/Wdz19zQadFyyV/cMDMEQolFX4g6ajIc3QwAuttGuYYXc8lRHxw5sSXiF/pumcHEMCm1ju/HPhGkr+yFOX5e5iPnVzFtPVPCTBuD83cFYDJxNNJ1BxCjUEGgrgE/vFg/kswD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 14:36:35.1057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f833ba71-5785-44cc-9d21-08dee66c4cca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
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

Replace the legacy SMU table-copy metrics path with a DRAM-mapped
accumulator-based approach for SMU v15.0.0:

- Add MSG_MAP entries for GetMetricsTableVersion,
  GetMetricsTableLogSample, and GetMetricsTableLogDramAddr messages.
- Introduce SMU_15_0_0_MetricsInfo_t wrapping MetricsTable_t with
  cached address, table size, and pre-computed average metrics.
- Add smu_v15_0_0_get_metrics_table() which obtains the DRAM address
  from the SMU, ioremaps it, and copies the metrics snapshot.
- Add smu_v15_0_0_compute_all_metrics() to derive averaged clocks,
  activity, power, and temperature from accumulator deltas between
  consecutive samples.
- Rework smu_v15_0_0_get_smu_metrics_data() to use the new
  accumulator-diff path, replacing the per-member switch statement
  with a single lookup into pre-computed avg_metric[].
- Rename the old smu_v15_0_0_get_metrics_table() to
  smu_v15_0_0_get_gpu_metrics_table(), preserving it for the
  gpu_metrics v3.0 export path.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Suresh Guttula <Suresh.Guttula@amd.com>
Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h  |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 246 +++++++++++-------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |  14 +
 4 files changed, 166 insertions(+), 102 deletions(-)

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
index bb8d09e73c7d..d2ae631b6b27 100644
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
@@ -173,7 +176,7 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
-	smu_table->metrics_table = kzalloc_obj(SmuMetrics_t);
+	smu_table->metrics_table = kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
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
@@ -329,115 +332,156 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 	return 0;
 }
 
+
+static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+					SMU_15_0_0_MetricsInfo_t *metrics_info)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	void __iomem *cpu_addr = NULL;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct smu_msg_args args = {0};
+	int table_size = metrics_info->table_size;
+	uint64_t addr = metrics_info->addr;
+	int ret;
+
+	if (smu_table->metrics_time &&
+	    !time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1)))
+		return 0;
+
+	if (addr == 0) {
+		struct smu_msg_args args = {
+			.msg = SMU_MSG_GetMetricsTableLogDramAddr,
+			.num_args = 0,
+			.num_out_args = 3,
+		};
+
+		ret = ctl->ops->send_msg(ctl, &args);
+
+		if (ret)
+			return ret;
+
+		addr = ((uint64_t)args.out_args[1] << 32) | args.out_args[0];
+		table_size = args.out_args[2];
+		metrics_info->addr = addr;
+		metrics_info->table_size = table_size;
+	}
+
+	cpu_addr = ioremap_wc(addr, table_size);
+	if (!cpu_addr)
+		return -ENOMEM;
+
+	args.msg = SMU_MSG_GetMetricsTableLogSample;
+	args.num_args = 0;
+	args.num_out_args = 0;
+
+	ret = ctl->ops->send_msg(ctl, &args);
+	if (!ret) {
+		amdgpu_hdp_invalidate(smu->adev, NULL);//best to flush before copy
+		if (table_size <= sizeof(MetricsTable_t))
+			memcpy(&metrics_info->metrics, cpu_addr, table_size);
+		else
+			memcpy(&metrics_info->metrics, cpu_addr, sizeof(MetricsTable_t));
+	}
+	iounmap(cpu_addr);
+	return ret;
+}
+
+#define get_diff_count(a, b) \
+	(a > b ? ((MAX_UINT32  - a) + b + 1) : (b - a))
+#define get_diff_val(a, b) \
+	(a > b ? ((MAX_UINT64  - a) + b + 1) : (b - a))
+
+static void smu_v15_0_0_compute_all_metrics(
+		SMU_15_0_0_MetricsInfo_t *prev,
+		SMU_15_0_0_MetricsInfo_t *curr)
+{
+	uint64_t counter, val;
+	MetricsTable_IOD_t *p = &prev->metrics.IOD;
+	MetricsTable_IOD_t *c = &curr->metrics.IOD;
+
+	counter = get_diff_count(p->AccumulationCounter, c->AccumulationCounter);
+	if (!counter)
+		return;
+
+	/* Accumulator-based clock frequencies (fixed-point /1024) */
+	val = get_diff_val(p->GfxclkFreqEffAcc, c->GfxclkFreqEffAcc);
+	curr->avg_metric[METRICS_AVERAGE_GFXCLK] = (val / counter) / 1024;
+
+	val = get_diff_val(p->SocclkFreqEffAcc, c->SocclkFreqEffAcc);
+	curr->avg_metric[METRICS_AVERAGE_SOCCLK] = (val / counter) / 1024;
+
+	val = get_diff_val(p->VclkFreqEffAcc, c->VclkFreqEffAcc);
+	curr->avg_metric[METRICS_AVERAGE_VCLK] = (val / counter) / 1024;
+
+	curr->avg_metric[METRICS_AVERAGE_DCLK] = 0;
+
+	val = get_diff_val(p->MemclkFreqEffAcc, c->MemclkFreqEffAcc);
+	curr->avg_metric[METRICS_AVERAGE_UCLK] = (val / counter) / 1024;
+
+	val = get_diff_val(p->FclkFreqEffAcc, c->FclkFreqEffAcc);
+	curr->avg_metric[METRICS_AVERAGE_FCLK] = (val / counter) / 1024;
+
+	val = get_diff_val(p->NpuhclkFreqEffAcc, c->NpuhclkFreqEffAcc);
+	curr->avg_metric[METRICS_AVERAGE_NPUCLK] = (val / counter) / 1024;
+
+	/* Activity (fixed-point /1024) */
+	val = get_diff_val(p->GfxBusyAcc, c->GfxBusyAcc);
+	curr->avg_metric[METRICS_AVERAGE_GFXACTIVITY] = (val / counter) / 1024;
+
+	val = get_diff_val(p->VcnBusyAcc, c->VcnBusyAcc);
+	curr->avg_metric[METRICS_AVERAGE_VCNACTIVITY] = (val / counter) / 1024;
+
+	/* Power (fixed-point /1024) */
+	val = get_diff_val(p->ApuPowerAcc, c->ApuPowerAcc);
+	curr->avg_metric[METRICS_AVERAGE_SOCKETPOWER] = (val / counter) / 1024;
+
+	val = get_diff_val(p->SystemPowerAcc, c->SystemPowerAcc);
+	curr->avg_metric[METRICS_CURR_SOCKETPOWER] = (val / counter) / 1024;
+
+	/* Temperature */
+	val = get_diff_val(p->GFX_TempAcc, c->GFX_TempAcc);
+	curr->avg_metric[METRICS_TEMPERATURE_EDGE] = val / counter;
+
+	/* Static zero values */
+	curr->avg_metric[METRICS_VOLTAGE_VDDGFX] = 0;
+	curr->avg_metric[METRICS_VOLTAGE_VDDSOC] = 0;
+}
+
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
 					    uint32_t *value)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
-	int ret = 0;
+	SMU_15_0_0_MetricsInfo_t *prev_metrics;
+	SMU_15_0_0_MetricsInfo_t *curr_metrics;
+	int ret;
 
-	ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
-	if (ret)
+	prev_metrics = kzalloc(sizeof(SMU_15_0_0_MetricsInfo_t), GFP_KERNEL);
+	if (!prev_metrics)
+		return -ENOMEM;
+
+	memcpy(prev_metrics, smu_table->metrics_table,
+			sizeof(SMU_15_0_0_MetricsInfo_t));
+	ret = smu_v15_0_0_get_metrics_table(smu,
+			(SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table);
+	if (ret) {
+		kfree(prev_metrics);
 		return ret;
+	}
 
-	switch (member) {
-	case METRICS_AVERAGE_GFXCLK:
-		*value = metrics->GfxclkFrequency;
-		break;
-	case METRICS_AVERAGE_SOCCLK:
-		*value = metrics->SocclkFrequency;
-		break;
-	case METRICS_AVERAGE_VCLK:
-		*value = metrics->VclkFrequency;
-		break;
-	case METRICS_AVERAGE_DCLK:
-		*value = 0;
-		break;
-	case METRICS_AVERAGE_UCLK:
-		*value = metrics->MemclkFrequency;
-		break;
-	case METRICS_AVERAGE_FCLK:
-		*value = metrics->FclkFrequency;
-		break;
-	case METRICS_AVERAGE_VPECLK:
-		*value = metrics->VpeclkFrequency;
-		break;
-	case METRICS_AVERAGE_NPUCLK:
-		*value = metrics->NpuclkFrequency;
-		break;
-	case METRICS_AVERAGE_GFXACTIVITY:
-		if ((smu->smc_fw_version > 0x5d4600))
-			*value = metrics->GfxActivity;
-		else
-			*value = metrics->GfxActivity / 100;
-		break;
-	case METRICS_AVERAGE_VCNACTIVITY:
-		*value = metrics->VcnActivity / 100;
-		break;
-	case METRICS_AVERAGE_SOCKETPOWER:
-	case METRICS_CURR_SOCKETPOWER:
-		*value = (metrics->SocketPower / 1000 << 8) +
-		(metrics->SocketPower % 1000 / 10);
-		break;
-	case METRICS_TEMPERATURE_EDGE:
-		*value = metrics->GfxTemperature / 100 *
-		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-		break;
-	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = metrics->SocTemperature / 100 *
-		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-		break;
-	case METRICS_THROTTLER_RESIDENCY_PROCHOT:
-		*value = metrics->ThrottleResidency_PROCHOT;
-		break;
-	case METRICS_THROTTLER_RESIDENCY_SPL:
-		*value = metrics->ThrottleResidency_SPL;
-		break;
-	case METRICS_THROTTLER_RESIDENCY_FPPT:
-		*value = metrics->ThrottleResidency_FPPT;
-		break;
-	case METRICS_THROTTLER_RESIDENCY_SPPT:
-		*value = metrics->ThrottleResidency_SPPT;
-		break;
-	case METRICS_THROTTLER_RESIDENCY_THM_SOC:
-		*value = metrics->ThrottleResidency_THM_SOC;
-		break;
-	case METRICS_VOLTAGE_VDDGFX:
-		*value = 0;
-		break;
-	case METRICS_VOLTAGE_VDDSOC:
-		*value = 0;
-		break;
-	case METRICS_SS_APU_SHARE:
-		/* return the percentage of APU power with respect to APU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
-		 */
-		if (metrics->StapmOpnLimit > 0)
-			*value = (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
-		else
-			*value = 0;
-		break;
-	case METRICS_SS_DGPU_SHARE:
-		/* return the percentage of dGPU power with respect to dGPU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
-		 */
-		if ((metrics->dGpuPower > 0) &&
-		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
-			*value = (metrics->dGpuPower * 100) /
-				 (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
-		else
-			*value = 0;
-		break;
-	default:
-		*value = UINT_MAX;
-		break;
+	curr_metrics = (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
+
+	if (prev_metrics->metrics.IOD.AccumulationCounter !=
+		curr_metrics->metrics.IOD.AccumulationCounter) {
+		/* New sample: compute all accumulator-based metrics at once */
+		smu_v15_0_0_compute_all_metrics(prev_metrics, curr_metrics);
 	}
 
-	return ret;
+	*value = curr_metrics->avg_metric[member];
+
+	kfree(prev_metrics);
+	return 0;
 }
 
 static int smu_v15_0_0_read_sensor(struct smu_context *smu,
@@ -634,7 +678,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, false);
+	ret = smu_v15_0_0_get_gpu_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
index 8365b9fea77e..a80d9b2ab633 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
@@ -23,6 +23,20 @@
 #ifndef __SMU_V15_0_0_PPT_H__
 #define __SMU_V15_0_0_PPT_H__
 
+#include "amdgpu_smu.h"
+
+#define MAX_UINT32 0x00000000FFFFFFFF
+#define MAX_UINT64 0xFFFFFFFFFFFFFFFF
+
+#include "pmfw_if/smu_v15_0_0_metrics.h"
+
+typedef struct {
+	MetricsTable_t metrics;
+	uint32_t table_size;
+	uint64_t addr;
+	uint32_t avg_metric[METRICS_AVERAGE_NPUCLK+1];
+} SMU_15_0_0_MetricsInfo_t;
+
 extern void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu);
 
 #endif
\ No newline at end of file
-- 
2.43.0

