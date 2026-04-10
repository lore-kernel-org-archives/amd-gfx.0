Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4902DF45A08
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 19:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B4C10E9CC;
	Fri, 10 Apr 2026 19:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZM2bG2oD";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C6810E9CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 19:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5lOBv5nS0Q90zxb7mV6pwuqTWWp+qnka2IMbU4RJgcgAXuCcto0XMi9/o8HkbM1A+PUM+EFItwzy5ocJqI1AznEn4EZVTaD4oPjzZjAHI2P1ND5/DR3N2R85vupy96tDSP4lT7YuAwyBFxqIEzaDer8hbIDTfufVkIZS9Hv3t/Ps7+Kb1ihgHM7YhCr8HIG57RN9/UJVwj6oJpHh8gC/ZR9pv3eJ/4V5H1ngNI3IYWI/LpFSYCONjQTJ1c39sFQ9n+R4kcimhTuhjF8unumvntMl0xPkKWni1Ok/Iy9E8XfocqWQQbFp2T+TcHVzSYxhStK5/537BWbQqxUER8xVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOLJ9ckxLNDt5Kp/4/wdLWvJNC3HOjJI04cIHJjgIPg=;
 b=xJR2Ww196AbxAfkvl9Nqw5qGltv6GyKULZclLynET8QwQhNn1U14G6cYmOI5Ew7U8o/KbHUekZiJFfUxlZDBzPuriIdf0tg4QGNn9zUYk1mx8KFqZ7eRUNnU4gPFDvYS2SLeUTIQ5HPvswptBJzZvYmoFieDdCqqAjGAL30rNK0e28abaGzPA6UumNwWMfybJFlIW7PehHMQnboytQEDG28JDb9hCH4gxV6UdxpEx4TNkeJhToRSi3UddofERVrqwbpY1MLw/MtmSD3jkbLACwH8Za9wSKHM3iME3rNHWaNxNdy5IdsLMjNrg8LvdjchKFLs3t+xQZ740/i322L4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOLJ9ckxLNDt5Kp/4/wdLWvJNC3HOjJI04cIHJjgIPg=;
 b=ZM2bG2oDhaRDP75h+daD+lTlfNmcLqkMJfKm7+Bjb7JAvyhhbiN6AIfi+0n8k71kwbtgGuvQLQkUXRoaTHGqaujX6Stccew6LkGZUof9sIR8uIMOdrCoqqoFMDbvmN9+DWjQK1BQPz/6ZD/HI1kTt+3JIDmP6pxzsOB4PTr0O7Q=
Received: from SA9PR13CA0022.namprd13.prod.outlook.com (2603:10b6:806:21::27)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 19:46:55 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::90) by SA9PR13CA0022.outlook.office365.com
 (2603:10b6:806:21::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 19:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 19:46:55 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 14:46:52 -0500
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: [Medusa]-New Unified metrics table support
Date: Sat, 11 Apr 2026 01:16:30 +0530
Message-ID: <20260410194632.1461984-1-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d711ee-c76b-4dac-00cc-08de9739eb71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Qh2r0tydLfbbb8oeuA4C+UKwyaTM+WwscK5U6h9goer/l2Qfll5EoC1c5ULY6ZwqKH8b7ZP7aqYgdc0ktM6Km0FAfipPDwb0EI8fnTRwFlEpe+qgNilfBZMKUU3BSEBpQfsIDYC+cHYQPvQBXiUkvGrLmWtdoBLaLY6E7YwQVtt2n8UnQ3iwsmGNYAXEXVN1xLMusQ2HQRkchs5LICHrOKARYaaVomv5m6MxnALy8cK+h+lvRy9oINmEhdoB4b+fUMF5dHXeCzg4QhlTVZNi/+FvE640tODXNHCNx9+Oum1wcJueZ/ESmXZfy+fCIHuar3jgp5UQw4XUPK3hzN0HaX7x98oO1W+98tpIBCCajYAJzQ++qe57K05HAYT+xZ79ChWRRsJHJvPAULrPuId+lxvIE/PKTGLnfubPLbRDfiH8B6BsIrw5BSOblpxlNrTxzxm0Tx8BuZejY6p470wCaJXJ8LoIDr5tA8KfVPjZCAO5+sARZb/iFQwDG48adFGC4mVVLwoqTLhjIFbrjurTLetNPZUyVsFkkoRWWOC1cai3Y0xYirshRao7u4Bz0AgRVpPaiHlg38jjhghJhUO8O5bKWk0dVoPd2GUWP31oR5YYPDlQdo9N7pYSMyPtNYJEirT2XX1ScP6w8DEMyuaE9uv/3lpK2CiHaedFlnQPP44bVJaz+Q3WQeXXvTZ8nUOEtadPRTuQvErc1YrgTnMlU2MNAiI+ebaPT9DXEslzlNA5ao2tja8ltU3zbx15UrFu3FLEOs3PEpY+1FG3b6AAAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0cpf7IXxBdOmNv4KWIQV5bEC8cIEFrk8b31X48m2yM122V9c5CmNqkQLFFz5XqDPWkh16QpibG2OAq1NCdBTF/f2r8ugH1il3TZhEDx7gOsK+cj0xr5lM12mrxlWgAZKOI8dZF10LNYtPPnSqKaLfIpwMTOGtzYsgvEPc+Yhbq+wmJ8fSDM4LUFYuqUrTvop3wsOExuVIU0k17fKfr9ALl6IJmUeJ6Rrp6iVEkTustoFGXweSJGJ0Cqib4r0GdgM/Y7+mnJfyEjrjX6RC6jsnT+Zo8nKp2ROwJ02j9VmCvOqHooCa2B+bxZUVUh183t6hEhHR45127UTxnipSPlu1fJW9QA92yfeB7GRQe4kmdCeCjeDCWi3HutoOO89xOn7WNg2Px2iUtlNzXTGqiO8YMlvFi3lYanA8dVbERoqq9SMY4Xk5HSKuNwPuonxPWPm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 19:46:55.1536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d711ee-c76b-4dac-00cc-08de9739eb71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306
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

