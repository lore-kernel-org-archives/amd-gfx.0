Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F6FC53200
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 09:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A33A10EB34;
	Wed, 29 Jul 2026 09:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W0NvsF/t";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59CC410EB34
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 09:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMs1FhNyY5ZGnhs6s4LPT2xzMJ2Js2QYm3Ht9U/lXvNp4/h2ar8x4hzRBTh2Slb68og9DRh1HJPCfbBeEzO5dmPMyoHQfuYiDkgRWBydq3R4dgw0wyAHfVxOnb4BwKVj4s1+0thwx0dAJS3hW9OHfCfJjA6FMO/wNwikuAZMzZmonHBn4wDKZmbV79OQ4oSXSee2ePJJZLaf4RGdzav76NpMNmCgNwLtsB4zO1ekQySaGCsBzc+SaX9U3F9CCDN0D+7dbjUlEJKXvG+paIJe7cB80rBXB0TQQOFBbRtTitlUXBz2+XIe3Rtml2zwVVU4fuRAt7A+bUs7WxTEa/SrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39BAmCSkQ4WNSGQHGmI/bOCKbCDt/KoamgUfi9QIFx0=;
 b=tvpRT40HR89+A/IoKmgaESCbFF3VSoSDRnLJAyXnj7TOtjoLWsEe2Do+3eZK2JbEeI2xPAiuRKvyRN968HwBgl9f1Z9RvXiFh3pGU5ewzmEadQFh1mUJWCb97Uugu7okqaHRtDAZL1XuHAMyMvSxUF2LsiIdSpa4E7ZcYFSSxwKzvBMHtP9t0mx571T8nEPkGAwV/Cuw53RcklCxXQEwzev7/yyF/2/6pqCzMA/0CWmGMyeZSwk2pyOszYbepWLOYppeW2fX4eRrNu1SHH011fruO7rZjXlrK+90O9YlmRSah7LCDxzUKMgCW3CUDJ2GQX0wegodZp6I4qltJDIeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39BAmCSkQ4WNSGQHGmI/bOCKbCDt/KoamgUfi9QIFx0=;
 b=W0NvsF/ttnfE6I8RTnFa9cVME2UNCHvNl5dXhSZJ4evNaEBlQJiKqcw0zG9/5W1b0D88ffDL8vU4XMTTKo/KEJBs6XuGMZbQj02OBWzEkUFfehnBJaDvGYOgR9XmWelujyTYRjk9iesK5a6G7dOLEykT7tEtYc8JTjs42ADGSlM=
Received: from SJ0PR05CA0136.namprd05.prod.outlook.com (2603:10b6:a03:33d::21)
 by PH0PR12MB999089.namprd12.prod.outlook.com (2603:10b6:510:38e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:40:33 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::55) by SJ0PR05CA0136.outlook.office365.com
 (2603:10b6:a03:33d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 09:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 09:40:33 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 29 Jul 2026 04:40:30 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Christian.Koenig@amd.com>, <Lijo.Lazar@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Shubhankar.MilindSardeshpande@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>, <Suresh.Guttula@amd.com>,
 <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH V6 2/2] drm/amd/pm: fix SMU v15 metrics fetch, scaling,
 and sensor mapping
Date: Wed, 29 Jul 2026 15:02:47 +0530
Message-ID: <20260729093928.2958771-2-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729093928.2958771-1-Shubhankar.MilindSardeshpande@amd.com>
References: <20260729093928.2958771-1-Shubhankar.MilindSardeshpande@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|PH0PR12MB999089:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfb53db-cfee-4dd9-5967-08deed556fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ntyy3oTCQZVzhxf86gZlqfyITA2+zsehiDznoUaRxLWjjYeV7OADqGCJusQ0fqBlmgHZNvARBYahSMUHqV18hvBisY9YDYIee5xTtNyRipyPYDhcQweENkAETo3552fCQ2ChTT3dzSn14r4gtNXxKIsb+aal+STrbuf7PK7GcO4dsGaq8QhxkBCL5i7V7Kgq9dLkN0baatsS747PLuIH7y1nm3ve26gSqug+JyuGlgTdW6IncLRR6tVzlh+8Cl+UjrWhsG5QBAgMjLIg4ixC+YiRFW6B5nRT+RW4qxXZFelVjSgyu+luH443esS4O5UFemmSVx/gKK0uNAC3r7cDoyPtdHC3mIoSxmnhCPaL1eq+PmLgQssEV8n+N0j3Uo+BwlIZSEoSfqp1E6D0OQtGe3nY5GFUuDj+D43I1gKEf8MJprJAriBsxP3G5CidgqYOQWkHOuUK2C2+J0TRYhj4z4stFXItdLQX93rutJB5xnlX95xOqa9WRwPwlLZVt8xGVd3WDtuGrR0ciYkq5iLicodGqo8wKGIdku2y5irOtuMGxEhZjsnEtG4b7N8i2SQZUM39rY0r9SA/LY51bYcX9P3pjmkRUXOpqq+v8Je35jU97hEpUALeqreMUwwNR/gUvVHeEzCtsR4yJv/3FB49mc7qP+cuuKVMCIUbpjhFzdJAL/5Uh9+XbigQHjpPzc3+sTBHdT37n6cvTShSLX7CAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HDJndFv7BQNXoHy5WNCEwr022dyk15XZ2SezXZ9AbHomU+MxO1oY99SjhNHYNP4PlyM4QUatbNzchpZLoo0IEdKSxuyAwoewkgHCOZtBYj1BjjV6uGCrav+/fDdgcJYlxoHwYJtxtxOvfvQByn40qQhqimGNG9Yfy4j5UYmtJ48VHzFoshq1IRrA6R6lTvEOoQEtKWtfu1CCc7DOn8LPQeyAva0yqNruzLkb1XelzUWbcStXB6/5Pap7b78wjeMJzbRKLsjecRFGUzVmnjJMTaAahR/Ap+SILZoioGVo5XEjiqIrT5mLPN02J4yOc2iKwH1/+0n3iuJvclVg3Bwr0kJyvB0tK3a+ot+WlYBjKF9ey/1xRtsYWbHp0iSI0iflP26JCFz37RGeCTAEr5asIXzZ8L/mE4gsBAn3EEjCLXj6RH3rOAwwwx8SyKP7cKxW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:40:33.7210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfb53db-cfee-4dd9-5967-08deed556fe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999089
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

V6 fixes: Fix several issues in the SMU v15 metrics path
that were triggering CI warnings and causing
incorrect runtime metric values.

Key fixes:

-Always refresh the metrics table DRAM address during table init instead
 of skipping when addr is non-zero.
-Use memcpy_fromio() for copying the metrics table from MMIO/IO memory.
-Store metrics_time after a successful table read to make cache-age checks
 consistent.
-Use size_t for metrics table size to avoid type/size warnings.
-Correct accumulator fixed-point conversions in
 smu_v15_0_0_compute_all_metrics():
 Use div64_u64() for the 64-bit average and div_u64() for
 the final /1024 descaling so division stays in kernel helpers
 and avoids compiler-emitted divdi3 linkage/build errors
 clocks/activity: keep proper /1024 scaling
 power: convert to milliwatts
 temperature: convert to millidegree Celsius for hwmon/sysfs users
 voltage: convert fixed-point volts to millivolts
-Report GPU temperature via AMDGPU_PP_SENSOR_GPU_TEMP and map it to the
 correct metrics field (VRGFX temperature).
-This aligns computed metrics with hwmon/sysfs units and removes CI/lint
 issues from improper IO copy and integer handling.
-Bounds-check metrics member before array access.
 smu_v15_0_0_get_smu_metrics_data() indexes the fixed-size
 avg_metric[] array with a caller-supplied MetricsMember_t
 reject out-of-range members with -EINVAL to prevent a
 latent out-of-bounds access.

drm/amd/pm/smu15: switch SMU v15.0.0 to DRAM-based accumulator metrics

Replace the legacy SMU table-copy metrics path with a DRAM-mapped,
accumulator-based approach for SMU v15.0.0, using a ping-pong buffer
to compute averaged metrics from deltas between consecutive samples.

- Add GetMetricsTableVersion, GetMetricsTableLogSample and
  GetMetricsTableLogDramAddr messages and their MSG_MAP entries.
- Introduce SMU_15_0_0_MetricsInfo_t holding two MetricsTable_t
  buffers, the mapped DRAM address, table size and pre-computed
  avg_metric[] values.
- Resolve and ioremap_wc() the firmware log DRAM address once in
  init_smc_tables(); iounmap() it in fini_smc_tables().
- Fetch samples into the inactive buffer, compute averaged clocks,
  activity, power and temperature via wrapping_sub() accumulator
  deltas, then swap the active index.
- Rename the old get_metrics_table() to get_gpu_metrics_table() for
  the gpu_metrics v3.0 export path.
- Smartshift sensor reporting is dropped

Co-developed-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Co-developed-by: Suresh Guttula <Suresh.Guttula@amd.com>
Signed-off-by: Suresh Guttula <Suresh.Guttula@amd.com>
Co-developed-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h  |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 312 +++++++++++-------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |  13 +
 4 files changed, 218 insertions(+), 115 deletions(-)

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
index acf03838d49d..d6675b4ee9be 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -297,6 +297,9 @@
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
index 0da1ffb3a567..12fe2bc0488e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -33,6 +33,9 @@
 #include "smu_v15_0_0_pmfw.h"
 #include "smu_cmn.h"
 
+#include <linux/overflow.h>
+#include <linux/math64.h>
+
 /*
  * DO NOT use these for err/warn/info/debug messages.
  * Use dev_err, dev_warn, dev_info and dev_dbg instead.
@@ -119,6 +122,9 @@ static struct cmn2asic_msg_mapping smu_v15_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(DisableLSdma,                   PPSMC_MSG_DisableLSdma,				1),
 	MSG_MAP(SetSoftMaxVpe,                  PPSMC_MSG_SetSoftMaxVpe,			1),
 	MSG_MAP(SetSoftMinVpe,                  PPSMC_MSG_SetSoftMinVpe,			1),
+	MSG_MAP(GetMetricsTableVersion,         PPSMC_MSG_GetMetricsTableVersion,		1),
+	MSG_MAP(GetMetricsTableLogSample,       PPSMC_MSG_GetMetricsTableLogSample,		1),
+	MSG_MAP(GetMetricsTableLogDramAddr,     PPSMC_MSG_GetMetricsTableLogDramAddr,	1),
 };
 
 static struct cmn2asic_mapping smu_v15_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -160,10 +166,37 @@ static struct cmn2asic_mapping smu_v15_0_0_table_map[SMU_TABLE_COUNT] = {
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
@@ -173,7 +206,7 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
-	smu_table->metrics_table = kzalloc_obj(SmuMetrics_t);
+	smu_table->metrics_table = kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
 	if (!smu_table->metrics_table)
 		goto err0_out;
 	smu_table->metrics_time = 0;
@@ -192,8 +225,16 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 	if (ret)
 		goto err3_out;
 
+	metrics_info = (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
+
+	ret = smu_v15_0_0_get_metrics_table_dram_addr(smu, metrics_info);
+	if (ret)
+		goto err4_out;
+
 	return 0;
 
+err4_out:
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 err3_out:
 	kfree(smu_table->watermarks_table);
 err2_out:
@@ -207,6 +248,14 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
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
+	}
 
 	kfree(smu_table->clocks_table);
 	smu_table->clocks_table = NULL;
@@ -299,7 +348,7 @@ static int smu_v15_0_0_set_default_dpm_tables(struct smu_context *smu)
 				    smu_table->clocks_table, false);
 }
 
-static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
 							void *metrics_table,
 							bool bypass_cache)
 {
@@ -329,114 +378,161 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 	return 0;
 }
 
+/*
+ * Fetch a fresh metrics sample into the inactive buffer.
+ * Returns 0 if a new sample was copied, 1 if the cached sample is still
+ * fresh (nothing copied), or a negative errno on failure.
+ */
+static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+					SMU_15_0_0_MetricsInfo_t *metrics_info)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	void __iomem *cpu_addr = metrics_info->cpu_addr;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct smu_msg_args args = {0};
+	size_t table_size = metrics_info->table_size;
+	int ret;
+
+	if (smu_table->metrics_time &&
+	    !time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1)))
+		return 1;
+
+	if (!cpu_addr)
+		return -ENOMEM;
+
+	args.msg = SMU_MSG_GetMetricsTableLogSample;
+	args.num_args = 0;
+	args.num_out_args = 0;
+
+	ret = ctl->ops->send_msg(ctl, &args);
+	if (ret)
+		return ret;
+
+	/* best to flush before copy */
+	amdgpu_hdp_invalidate(smu->adev, NULL);
+	if (table_size <= sizeof(MetricsTable_t))
+		memcpy_fromio(&metrics_info->metrics[!metrics_info->active_idx],
+			      cpu_addr, table_size);
+	else
+		memcpy_fromio(&metrics_info->metrics[!metrics_info->active_idx],
+			      cpu_addr, sizeof(MetricsTable_t));
+
+	metrics_info->active_idx = !metrics_info->active_idx;
+	smu_table->metrics_time = jiffies;
+
+	return 0;
+}
+
+/*
+ * Accumulators monotonically increase and roll over at their type width.
+ * Use the kernel wrapping_sub() API to compute the delta so the subtraction
+ * wraps modulo 2^n (correct across a single rollover) without tripping any
+ * wrap-around sanitizers.
+ */
+static void smu_v15_0_0_compute_all_metrics(
+		uint32_t *avg_metric,
+		MetricsTable_t *prev,
+		MetricsTable_t *curr)
+{
+	uint64_t counter, val;
+	uint32_t mw;
+	MetricsTable_IOD_t *p = &prev->IOD;
+	MetricsTable_IOD_t *c = &curr->IOD;
+
+	counter = wrapping_sub(u32, c->AccumulationCounter, p->AccumulationCounter);
+	if (!counter)
+		return;
+
+	/* Accumulator-based clock frequencies (fixed-point /1024) */
+	val = wrapping_sub(u64, c->GfxclkFreqEffAcc, p->GfxclkFreqEffAcc);
+	avg_metric[METRICS_AVERAGE_GFXCLK] = div_u64(div64_u64(val, counter), 1024);
+
+	val = wrapping_sub(u64, c->SocclkFreqEffAcc, p->SocclkFreqEffAcc);
+	avg_metric[METRICS_AVERAGE_SOCCLK] = div_u64(div64_u64(val, counter), 1024);
+
+	val = wrapping_sub(u64, c->VclkFreqEffAcc, p->VclkFreqEffAcc);
+	avg_metric[METRICS_AVERAGE_VCLK] = div_u64(div64_u64(val, counter), 1024);
+
+	val = wrapping_sub(u64, c->MemclkFreqEffAcc, p->MemclkFreqEffAcc);
+	avg_metric[METRICS_AVERAGE_UCLK] = div_u64(div64_u64(val, counter), 1024);
+
+	val = wrapping_sub(u64, c->FclkFreqEffAcc, p->FclkFreqEffAcc);
+	avg_metric[METRICS_AVERAGE_FCLK] = div_u64(div64_u64(val, counter), 1024);
+
+	val = wrapping_sub(u64, c->NpuhclkFreqEffAcc, p->NpuhclkFreqEffAcc);
+	avg_metric[METRICS_AVERAGE_NPUCLK] = div_u64(div64_u64(val, counter), 1024);
+
+	/* Activity (fixed-point /1024) */
+	val = wrapping_sub(u64, c->GfxBusyAcc, p->GfxBusyAcc);
+	avg_metric[METRICS_AVERAGE_GFXACTIVITY] = div_u64(div64_u64(val, counter), 1024);
+
+	val = wrapping_sub(u64, c->VcnBusyAcc, p->VcnBusyAcc);
+	avg_metric[METRICS_AVERAGE_VCNACTIVITY] = div_u64(div64_u64(val, counter), 1024);
+
+	/*
+	 * Power: accumulator holds a 1024x fixed-point value in Watts.
+	 * Average it into milliwatts, which is the unit expected by
+	 * power sensor consumers (hwmon/debugfs).
+	 */
+	val = wrapping_sub(u64, c->ApuPowerAcc, p->ApuPowerAcc);
+	mw = div_u64(div64_u64(val, counter) * 1000, 1024);
+	avg_metric[METRICS_AVERAGE_SOCKETPOWER] = mw;
+
+	val = wrapping_sub(u64, c->SystemPowerAcc, p->SystemPowerAcc);
+	mw = div_u64(div64_u64(val, counter) * 1000, 1024);
+	avg_metric[METRICS_CURR_SOCKETPOWER] = mw;
+
+	/*
+	 * Temperature: accumulator holds a 1024x fixed-point value in
+	 * Celsius. Descale by 1024 and convert to millidegrees C as the
+	 * hwmon/sysfs consumers expect (temp*_input is in millidegrees).
+	 */
+	val = wrapping_sub(u64, c->GFX_TempAcc, p->GFX_TempAcc);
+	avg_metric[METRICS_TEMPERATURE_VRGFX] =
+		div_u64(div64_u64(val, counter) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES, 1024);
+
+	val = wrapping_sub(u64, c->STT_APU_HotSpotTempAcc, p->STT_APU_HotSpotTempAcc);
+	avg_metric[METRICS_TEMPERATURE_HOTSPOT] =
+		div_u64(div64_u64(val, counter) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES, 1024);
+
+	/* Voltage: accumulator holds a 1024x fixed-point value in Volts;
+	 * convert to millivolts for the hwmon/sysfs consumers.
+	 */
+	val = wrapping_sub(u64, c->VDDCR_GFX_TelemetryVoltage, p->VDDCR_GFX_TelemetryVoltage);
+	avg_metric[METRICS_VOLTAGE_VDDGFX] = div_u64(div64_u64(val, counter) * 1000, 1024);
+
+	val = wrapping_sub(u64, c->VDDCR_SOC_TelemetryVoltage, p->VDDCR_SOC_TelemetryVoltage);
+	avg_metric[METRICS_VOLTAGE_VDDSOC] = div_u64(div64_u64(val, counter) * 1000, 1024);
+}
+
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
 					    uint32_t *value)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	SMU_15_0_0_MetricsInfo_t *metrics_info =
+		(SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
+	int ret;
 
-	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
-	int ret = 0;
+	if (member >= ARRAY_SIZE(metrics_info->avg_metric))
+		return -EINVAL;
 
-	ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
-	if (ret)
+	ret = smu_v15_0_0_get_metrics_table(smu, metrics_info);
+	if (ret < 0)
 		return ret;
 
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
-		*value = metrics->SocketPower;
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
+	if (ret == 0 &&
+	    metrics_info->metrics[metrics_info->active_idx].IOD.AccumulationCounter !=
+	    metrics_info->metrics[!metrics_info->active_idx].IOD.AccumulationCounter) {
+		/* New sample: active_idx already points to the latest sample. */
+		smu_v15_0_0_compute_all_metrics(metrics_info->avg_metric,
+						&metrics_info->metrics[!metrics_info->active_idx],
+						&metrics_info->metrics[metrics_info->active_idx]);
 	}
 
-	return ret;
+	*value = metrics_info->avg_metric[member];
+
+	return 0;
 }
 
 static int smu_v15_0_0_read_sensor(struct smu_context *smu,
@@ -473,9 +569,9 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+	case AMDGPU_PP_SENSOR_GPU_TEMP:
 		ret = smu_v15_0_0_get_smu_metrics_data(smu,
-						       METRICS_TEMPERATURE_EDGE,
+						       METRICS_TEMPERATURE_VRGFX,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
@@ -511,18 +607,6 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
 						       (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
-		ret = smu_v15_0_0_get_smu_metrics_data(smu,
-						       METRICS_SS_APU_SHARE,
-						       (uint32_t *)data);
-		*size = 4;
-		break;
-	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
-		ret = smu_v15_0_0_get_smu_metrics_data(smu,
-						       METRICS_SS_DGPU_SHARE,
-						       (uint32_t *)data);
-		*size = 4;
-		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
@@ -633,7 +717,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, false);
+	ret = smu_v15_0_0_get_gpu_metrics_table(smu, &metrics, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
index 8365b9fea77e..8471ba1a353e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
@@ -23,6 +23,19 @@
 #ifndef __SMU_V15_0_0_PPT_H__
 #define __SMU_V15_0_0_PPT_H__
 
+#include "amdgpu_smu.h"
+
+#include "pmfw_if/smu_v15_0_0_metrics.h"
+
+typedef struct {
+	MetricsTable_t metrics[2];
+	bool active_idx;
+	uint32_t table_size;
+	uint64_t addr;
+	void __iomem *cpu_addr;
+	uint32_t avg_metric[METRICS_AVERAGE_NPUCLK+1];
+} SMU_15_0_0_MetricsInfo_t;
+
 extern void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu);
 
 #endif
\ No newline at end of file
-- 
2.43.0

