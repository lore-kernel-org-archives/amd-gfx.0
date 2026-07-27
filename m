Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C720C531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 15:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1EF010E44B;
	Mon, 27 Jul 2026 15:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vWNce6l+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE99D10E44B
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 15:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZL6KemgpxgaZYr0cxmfYh7YlaQ4pEMqtE4osaFbvOkchwcIzHB+6sKyabZQhI/tM9ZYe9HqhSyNfd0Fh/XczanrDz3ddn8bo9VyKPqpU3RXYVxgQDm+ElsvtHfs6ksSVgu+IUS4QLhe/47qZ2P4yrbL3Esrlu/olrzbVQCFIBfMjFKNgfDFFrpHxyL8idliAVx+sQzThlykG54j+6g1Ylmw3iJgk7q59PLiJQsKi0wO78FAY2/fEVPoz1IB3DD8QQqnAFri9HMJGo/se+fCuifSYJA9kWY1c31D/nuJgKOH8080304E/sru5M3DB3g7a0cdSjqhf8PPUEDbHgXTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c74IToLJWUYMventawQZ9VhhLh7uFZPgcLezapCqj84=;
 b=XdTe7Xyo0W4w2M2rR916tnfRbTTN8L4jmmelhlBb8R3p6W9oPK7HYNrZ35kFh9OjH8eD+8yB6CkRp2D7ipdSErhtfVa3GfQ/XH3DKRE05QFi8KnR1G32bkigkxluTVWOVqLq0Sl9wok8qa69u6Ts9N+n6n7iI6QiZdPMAu2TMTqfZZwIjF5TGF3fSlnd+EU0E466QZ315XIxekmJtGVUD20kcEQIiqjD6zI4H5cS6jYS31RdFw+dJtREfMizmLw6wKxVga46RZVJdQfZafDZ7QIdN5J3azaQlPr1UpouIq+MZfauV9KQptQHpQnt1vXTywUqu+FO3YCDIKKkyGykzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c74IToLJWUYMventawQZ9VhhLh7uFZPgcLezapCqj84=;
 b=vWNce6l+I4P88nZCpmyEG1lCERoe6dY6eFD9boYXz6upFy0hNi3t7JcHspLQYvZkkaYdZ+NJ+AWEb7UYebu8ZOchpa8V6Xn11jV4omj2Z8pL5HFurmI6wudX7SKV3/550JwsIueJKm6JwXDwNDEOIqbMQRSpsWm33I1FbRYCUww=
Received: from DS7PR05CA0009.namprd05.prod.outlook.com (2603:10b6:5:3b9::14)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 15:38:03 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::31) by DS7PR05CA0009.outlook.office365.com
 (2603:10b6:5:3b9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Mon,
 27 Jul 2026 15:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 15:38:02 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 27 Jul 2026 10:38:00 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Christian.Koenig@amd.com>, <Lijo.Lazar@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Shubhankar.MilindSardeshpande@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>, <Suresh.Guttula@amd.com>,
 <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH V5 2/2] drm/amd/pm/smu15: switch SMU v15.0.0 to DRAM-based
 accumulator metrics
Date: Mon, 27 Jul 2026 21:03:52 +0530
Message-ID: <20260727153720.4111771-2-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727153720.4111771-1-Shubhankar.MilindSardeshpande@amd.com>
References: <20260727153720.4111771-1-Shubhankar.MilindSardeshpande@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b8ae8b-a457-4e74-7cb5-08deebf50bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|56012099006|5023799004|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: l4pX3Gy2npYhPDmHfsMlwY6CilEb49WwjTWbpb/nYpAh7ULoAV5H4M02gLsPr87fWkU1ZmvmwGgmiHbs6GxFJ2oqJ/wI7YqAb/TpOcKEPi6uxw54HJsyOu0lAfmyhIXDzCrSb38nAvEEEjNTa4LSUigGJ846NNP7JS5IhSrYpq9villRKZDvqmmihqxQMPoF65gJg60KgXKUyI1P3ShJOzutRZVJqoqOSky4w8NG4CMZ68V+Y69Yv/58SaMRDvx7oaq2t3VkC4e8iZDUmQHqEwbePieUyip9wYpRcSfRjHBPTChwsBhiWVrN7NHCA6mvlUGrwQsaCBmpmf+/UkmcPh0YryWIVK9HNMkOVgqh0ZLxm8jm+dd0tI6QbQasq1rKA/nJ4UHirpH2zB9g8Zs2iawUI9SqRlASaqw2t5KG8XKFxIw1n4KxIBK+HmTYvRl+8iejR1B0GEGfjCc6I5T/g4/xxVLd6g63mTeZLTwKdGtbDmvhp3ZeuLH+Q3fNMUHWaAClkRUkX/A7gYkN5M9hXv6eFvJ2uuUZn9F1R/yDseczQ3HGvxjdelwbqGAKV9/q1YuqjcVYPPoxubCD015KSfKn40ek/8LV7OhsAFRuinqa8pnaoHbMN0fX4YkJdu+N6jZ4Rz2WcrajzVNHfgwfj/DJRpGj4qO+LlLOrxyBgpuZy8SM1QQ6h0kjQ7ogNpT4j3ED21/ZbD+JCXjwfN5GSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(56012099006)(5023799004)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q8PPaUhzp4Nbq7zGS+Ha2dM5LbMdENzaAjxu4mCUyUcRCuswRP/bSd45uVDJqM5VDrFb5qyw4umRGmlvfzZRbZ6PypbJI+jlOkdRVhXUvren5mUA5meajP16v+rgAc25p9lmQfiCdBoDvRuTyi2a3KbfhuMwgEDk3GYlus+gkvzJsDyWr9SiZLmhgqIAueN/ALVA/tgC54H0DRp6DmXkX+go/5iIJhlmDS2G59ZQ9+T1NGRVtvjyPqLlPMhIgK/RFCbgxTYpNy6HndbBb8i1p80w0Hh2FZ3MY4kpIBFK6J/vq141vK7az3d6KUv0y04Vqqj86XSHAux9FLYeOuTX8gsjpRfFTRmTM1O8L1lMGSXu7nfygG5mYYUaPfJWzK08StrcbG8dxcCI+SGt3oZ0UP1WND6T77VilCbWjSOkMYLxPQkuqyggJHEHFHArFAUV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 15:38:02.9832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b8ae8b-a457-4e74-7cb5-08deebf50bc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651
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
- Move AMDGPU_PP_SENSOR_SS_APU_SHARE, AMDGPU_PP_SENSOR_SS_DGPU_SHARE
  to default case since they are not supported.

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
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 293 +++++++++++-------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |  13 +
 4 files changed, 199 insertions(+), 115 deletions(-)

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
index faa7d661f3bf..9da411bf2ad9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -33,6 +33,8 @@
 #include "smu_v15_0_0_pmfw.h"
 #include "smu_cmn.h"
 
+#include <linux/overflow.h>
+
 /*
  * DO NOT use these for err/warn/info/debug messages.
  * Use dev_err, dev_warn, dev_info and dev_dbg instead.
@@ -119,6 +121,9 @@ static struct cmn2asic_msg_mapping smu_v15_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(DisableLSdma,                   PPSMC_MSG_DisableLSdma,				1),
 	MSG_MAP(SetSoftMaxVpe,                  PPSMC_MSG_SetSoftMaxVpe,			1),
 	MSG_MAP(SetSoftMinVpe,                  PPSMC_MSG_SetSoftMinVpe,			1),
+	MSG_MAP(GetMetricsTableVersion,         PPSMC_MSG_GetMetricsTableVersion,		1),
+	MSG_MAP(GetMetricsTableLogSample,       PPSMC_MSG_GetMetricsTableLogSample,		1),
+	MSG_MAP(GetMetricsTableLogDramAddr,     PPSMC_MSG_GetMetricsTableLogDramAddr,	1),
 };
 
 static struct cmn2asic_mapping smu_v15_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -160,10 +165,37 @@ static struct cmn2asic_mapping smu_v15_0_0_table_map[SMU_TABLE_COUNT] = {
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
@@ -173,7 +205,7 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
-	smu_table->metrics_table = kzalloc_obj(SmuMetrics_t);
+	smu_table->metrics_table = kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
 	if (!smu_table->metrics_table)
 		goto err0_out;
 	smu_table->metrics_time = 0;
@@ -192,8 +224,18 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
 	if (ret)
 		goto err3_out;
 
+	metrics_info = (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
+
+	if (metrics_info->addr == 0) {
+		ret = smu_v15_0_0_get_metrics_table_dram_addr(smu, metrics_info);
+		if (ret)
+			goto err4_out;
+	}
+
 	return 0;
 
+err4_out:
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 err3_out:
 	kfree(smu_table->watermarks_table);
 err2_out:
@@ -207,6 +249,14 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
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
@@ -299,7 +349,7 @@ static int smu_v15_0_0_set_default_dpm_tables(struct smu_context *smu)
 				    smu_table->clocks_table, false);
 }
 
-static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
 							void *metrics_table,
 							bool bypass_cache)
 {
@@ -329,115 +379,142 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
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
+	int table_size = metrics_info->table_size;
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
+		memcpy(&metrics_info->metrics[!metrics_info->active_idx],
+		       cpu_addr, table_size);
+	else
+		memcpy(&metrics_info->metrics[!metrics_info->active_idx],
+		       cpu_addr, sizeof(MetricsTable_t));
+
+	metrics_info->active_idx = !metrics_info->active_idx;
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
+	MetricsTable_IOD_t *p = &prev->IOD;
+	MetricsTable_IOD_t *c = &curr->IOD;
+
+	counter = wrapping_sub(u32, c->AccumulationCounter, p->AccumulationCounter);
+	if (!counter)
+		return;
+
+	/* Accumulator-based clock frequencies (fixed-point /1024) */
+	val = wrapping_sub(u64, c->GfxclkFreqEffAcc, p->GfxclkFreqEffAcc);
+	avg_metric[METRICS_AVERAGE_GFXCLK] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->SocclkFreqEffAcc, p->SocclkFreqEffAcc);
+	avg_metric[METRICS_AVERAGE_SOCCLK] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->VclkFreqEffAcc, p->VclkFreqEffAcc);
+	avg_metric[METRICS_AVERAGE_VCLK] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->MemclkFreqEffAcc, p->MemclkFreqEffAcc);
+	avg_metric[METRICS_AVERAGE_UCLK] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->FclkFreqEffAcc, p->FclkFreqEffAcc);
+	avg_metric[METRICS_AVERAGE_FCLK] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->NpuhclkFreqEffAcc, p->NpuhclkFreqEffAcc);
+	avg_metric[METRICS_AVERAGE_NPUCLK] = (val / counter) / 1024;
+
+	/* Activity (fixed-point /1024) */
+	val = wrapping_sub(u64, c->GfxBusyAcc, p->GfxBusyAcc);
+	avg_metric[METRICS_AVERAGE_GFXACTIVITY] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->VcnBusyAcc, p->VcnBusyAcc);
+	avg_metric[METRICS_AVERAGE_VCNACTIVITY] = (val / counter) / 1024;
+
+	/* Power (fixed-point /1024) */
+	val = wrapping_sub(u64, c->ApuPowerAcc, p->ApuPowerAcc);
+	avg_metric[METRICS_AVERAGE_SOCKETPOWER] = (val / counter) / 1024;
+
+	val = wrapping_sub(u64, c->SystemPowerAcc, p->SystemPowerAcc);
+	avg_metric[METRICS_CURR_SOCKETPOWER] = (val / counter) / 1024;
+
+	/* Temperature */
+	val = wrapping_sub(u64, c->GFX_TempAcc, p->GFX_TempAcc);
+	avg_metric[METRICS_TEMPERATURE_EDGE] = val / counter;
+
+	val = wrapping_sub(u64, c->STT_APU_HotSpotTempAcc, p->STT_APU_HotSpotTempAcc);
+	avg_metric[METRICS_TEMPERATURE_HOTSPOT] = val / counter;
+
+	/* Voltage(mV) */
+	val = wrapping_sub(u64, c->VDDCR_GFX_TelemetryVoltage, p->VDDCR_GFX_TelemetryVoltage);
+		avg_metric[METRICS_VOLTAGE_VDDGFX] = (val / counter) / 1000;
+
+	val = wrapping_sub(u64, c->VDDCR_SOC_TelemetryVoltage, p->VDDCR_SOC_TelemetryVoltage);
+		avg_metric[METRICS_VOLTAGE_VDDSOC] = (val / counter) / 1000;
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
-
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
@@ -512,18 +589,6 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
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
@@ -634,7 +699,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
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

