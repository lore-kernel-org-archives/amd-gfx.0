Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AF5CA0FF2
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 05:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F412210E192;
	Thu, 28 Aug 2025 05:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EhJKh4dC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6384F10E192
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 05:10:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzL48kWuqUyaFQ6uIQOzMsywb/lruqEkwoAEceN6U/ibA4N1LcMR46MOo9qJbXqRTvfkzkDC7N2lXTbBN3uBIJ287bU6AmKGogRP6YGbWVcqCs9dUiK5X7n/+Db+0ugkcNPRAaq5IpfkcCoABUqW2jcSd/l9eN3zCa3K2VogCBBo6kg0WW7YX7y+59movLI9YnBJPRJKiLd1KVSjtGSthiIe0ROxesDfmBgIF4hFh7PEPjNwlTbdA732nSK76F7FVfXmp/nPM5qKFrt6n+rgNlUxs0eGdauH0e70TGh71YOGwSUzt9S62LJAbYSzSSAABgizxNzM+pZbhGjPazXunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMPsVfzjkUASzfVCesSe4ZgoiRct6de0sKhjEAXWExw=;
 b=DrnfxIC1mrtWlvoYc7LP+KlQxzcFvFFRAcLQxjaNqrpubdI4+o/SqGZLceSRHPXOR+lp5thEAx9gYcVSg+B8WjNwPjtm8RrzcUhn3yutYjM3KZbv9R23X9VgLxQQP2gt1w1DgXCUa8CMXtYL6kccSv63r70UEhzXvVNezwUohcjI2h4fDTV+7cvGXG0vh8NcrLTjYc6IGIGW8cA/PdlRAtkwpf/RlAj9y1ZC8/C9c4HvCP24dCBO7KwbWLyt2yysvNqlQ4CuEAL+FV0GuQ8uATOoA3DnKs8EH02M0NVhkK7nx7Fz2lvIUR47TfCx8jnaN7v9x+NSdnbMl/CCatBwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMPsVfzjkUASzfVCesSe4ZgoiRct6de0sKhjEAXWExw=;
 b=EhJKh4dC77IZAt5SwI0ojnlZ1iaDFA0eVGosYBty/2swfvWqQTfLQ/pZnDF/PhhY1MNo+bxz1WQPdSuxkRs0PrE26M6b2j2mSU2WogS6yNmEGPk9wntNx8RikhqIOPflzHL5boKvFJnaSVMgOWsbp3LIV2YM22uDV7I1j0fqVaw=
Received: from BY3PR10CA0025.namprd10.prod.outlook.com (2603:10b6:a03:255::30)
 by DS5PPF7856D51FE.namprd12.prod.outlook.com (2603:10b6:f:fc00::654)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 05:10:23 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::17) by BY3PR10CA0025.outlook.office365.com
 (2603:10b6:a03:255::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 05:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 05:10:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 00:10:21 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Add caching for SystemMetrics table
Date: Thu, 28 Aug 2025 10:40:06 +0530
Message-ID: <20250828051006.2244176-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|DS5PPF7856D51FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8c51e4-57db-4397-689c-08dde5f13136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tv+z0hLeivGUkqMRJXsW0PHkaNuWZy9zblsU1+hKSmBMS9xwYQLxuMudckQ6?=
 =?us-ascii?Q?ZWHlZ9gcd+WoiCUQm6Eb0AMrX6WlELq491CYPsSlqbkT2W7XasmCd0IxMHZX?=
 =?us-ascii?Q?dMZg/NR8QzsIvUUL5gm3EbooRKsk/aGga3nilyx2H2v2wRHzsifBTXk9TsWM?=
 =?us-ascii?Q?DIfyfBm5Y6Gols3oR4z9KPxufE9nEjPtVLW/Zv/RWilTMgQd6EiYrR9f5pLe?=
 =?us-ascii?Q?WerORVvahgY3nLyv2xkuZrySeck+wqUc+0EIkt1upjp2Eb9XK2Xd31E1BSnG?=
 =?us-ascii?Q?5lzCMH9beywx9tNjajkVM6O4TUaglLVAUBEAWYjRQCsjsabA9gOkpNAm226x?=
 =?us-ascii?Q?+r+dnaY2esoaxS45o7elj0DjGhUJmZOZns1lE4hTkvxvF3IKcgwH/p8LBWA7?=
 =?us-ascii?Q?C/V9UBRnOpjXhH7823ymAz6IyrcvSo7w1rWLSOWzONJX8Auu6Zazub1T0+m9?=
 =?us-ascii?Q?ljXwU7/Qow7oK3IpMgzmO6QhQnQUb8MimD3320o19PGI9hcx3Pe6xFkRr+K2?=
 =?us-ascii?Q?9gMwdVqkOxvPglWQz3K2fsiYqnRbpPGpKhyUvqbZkEi5bx2R9Fh21WQxHwFH?=
 =?us-ascii?Q?oZOHj9+6UutnRzKZTFfB+BK9H6fFsgAtegY3aoWd1RtF1hSeX01N3a1G+hEj?=
 =?us-ascii?Q?MZH7oUwnh+3hYwEyiR+T8A4kUPow1PpfWUOhbVPMbdchhtxoqe3LvYsEXu+V?=
 =?us-ascii?Q?GiWlHVGsim3SEN0NZxuAZmUP/ks3wGzLJ9MzZS34dOtbW/sE8IlQSevY1+eO?=
 =?us-ascii?Q?5AGOjW817lwc1qtx/TnLM0ybE58xtFPTTD1PRQ4nlhz0AxXp3m5dZ3sZUct+?=
 =?us-ascii?Q?znXYCDU24QsJvlAe0rvMJZSWEHZrtb1gXNbsrmwJBCE13fyRNylvbPmaUrJ5?=
 =?us-ascii?Q?K6Nw8QCcmRmiG5UynQn8U9PBtwUPqNfJMCbflrJjxoCZ7rHgGUW5uX9GzRHy?=
 =?us-ascii?Q?/B9GkwaRPh9y37eCVi5BMehyGzByYX6v3YF2GXrUpmesIvfgMVN0arwHVaZR?=
 =?us-ascii?Q?ya75nG9Uu7vkylNpD9OHlEOU7O0cOzaS7f6MOQT6A2kOXGyqvVbAyaf5EUzt?=
 =?us-ascii?Q?KJXUs1dqHVM6RxsHtZdueMAqXogqE46UZUqgo7nf0pOvHDQ7UxQnRaR7X4K7?=
 =?us-ascii?Q?8onRBAlJJ3exRnXAgPiYI65EFCnnMplrcuE9Xr4y0Pq6hxi2H0/kgwo8vlph?=
 =?us-ascii?Q?VHaoch7eWs4r2090cDJnZpjSusDcwpfJowuuDOW6n9wsePTihZ1e+Bk1tLfV?=
 =?us-ascii?Q?DwYg+eavn+BweAccv4fbamUGDaoNQnSggNU4zgFasS09B49iPPLSHrNh9XJT?=
 =?us-ascii?Q?th1CCoYWDxJURi0zsShVTg/ZhYq3S6b/Ml3tAKFwkpCL9ozTrgNQ4YZE7m6/?=
 =?us-ascii?Q?NkS4ooUXXh1IU3xlBUofsgIgYYFl1dKF7pb9Yh5bpRho6YM+BpsS6Ro/iuX/?=
 =?us-ascii?Q?sGPHPdIf2scWPgSeD8IcDV4fgtGFEk9xnGB3x5l1r5FeBcZ2fsGAzNumrTuV?=
 =?us-ascii?Q?3oOXSNEwo7q5rrthP/rSSs7hLankR8Mc0RUz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 05:10:23.0665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8c51e4-57db-4397-689c-08dde5f13136
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7856D51FE
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

Implement caching separately for SystemMetrics table from PMFW. The same
table could be used for multiple interfaces. Hence, cache it internally
to avoid multiple queries to the firmware. For SystemMetrics table, 5ms
cache interval is sufficient.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 43 +++++++++++++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  4 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  1 +
 4 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 5dd49eca598d..5976eda80035 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -333,6 +333,7 @@ enum smu_table_id {
 	SMU_TABLE_WIFIBAND,
 	SMU_TABLE_GPUBOARD_TEMP_METRICS,
 	SMU_TABLE_BASEBOARD_TEMP_METRICS,
+	SMU_TABLE_PMFW_SYSTEM_METRICS,
 	SMU_TABLE_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 32fd0be05cff..0bec12b348ce 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -149,6 +149,12 @@ int smu_v13_0_12_tables_init(struct smu_context *smu)
 	struct smu_table_cache *cache;
 	int ret;
 
+	ret = smu_table_cache_init(smu, SMU_TABLE_PMFW_SYSTEM_METRICS,
+				   smu_v13_0_12_get_system_metrics_size(), 5);
+
+	if (ret)
+		return ret;
+
 	ret = smu_table_cache_init(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS,
 				   sizeof(*baseboard_temp_metrics), 50);
 	if (ret)
@@ -162,6 +168,7 @@ int smu_v13_0_12_tables_init(struct smu_context *smu)
 	ret = smu_table_cache_init(smu, SMU_TABLE_GPUBOARD_TEMP_METRICS,
 				   sizeof(*gpuboard_temp_metrics), 50);
 	if (ret) {
+		smu_table_cache_fini(smu, SMU_TABLE_PMFW_SYSTEM_METRICS);
 		smu_table_cache_fini(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS);
 		return ret;
 	}
@@ -176,6 +183,7 @@ void smu_v13_0_12_tables_fini(struct smu_context *smu)
 {
 	smu_table_cache_fini(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS);
 	smu_table_cache_fini(smu, SMU_TABLE_GPUBOARD_TEMP_METRICS);
+	smu_table_cache_fini(smu, SMU_TABLE_PMFW_SYSTEM_METRICS);
 }
 
 static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
@@ -222,8 +230,12 @@ static int smu_v13_0_12_fru_get_product_info(struct smu_context *smu,
 
 int smu_v13_0_12_get_max_metrics_size(void)
 {
-	return max3(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t),
-		   sizeof(SystemMetricsTable_t));
+	return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t));
+}
+
+size_t smu_v13_0_12_get_system_metrics_size(void)
+{
+	return sizeof(SystemMetricsTable_t);
 }
 
 static void smu_v13_0_12_init_xgmi_data(struct smu_context *smu,
@@ -414,14 +426,18 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 	return 0;
 }
 
-static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu,
-						 void *metrics_table)
+static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
 	struct smu_table *table = &smu_table->driver_table;
+	struct smu_table *tables = smu_table->tables;
+	struct smu_table *sys_table;
 	int ret;
 
+	sys_table = &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
+	if (smu_table_cache_is_valid(sys_table))
+		return 0;
+
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
 	if (ret) {
 		dev_info(smu->adev->dev,
@@ -430,10 +446,9 @@ static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu,
 	}
 
 	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
-	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
-
-	if (metrics_table)
-		memcpy(metrics_table, smu_table->metrics_table, sizeof(SystemMetricsTable_t));
+	smu_table_cache_update_time(sys_table, jiffies);
+	memcpy(sys_table->cache.buffer, table->cpu_addr,
+	       smu_v13_0_12_get_system_metrics_size());
 
 	return 0;
 }
@@ -571,10 +586,10 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 	struct amdgpu_baseboard_temp_metrics_v1_0 *baseboard_temp_metrics;
 	struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
 	struct smu_table_context *smu_table = &smu->smu_table;
-	SystemMetricsTable_t *metrics =
-		(SystemMetricsTable_t *)smu_table->metrics_table;
-
+	struct smu_table *tables = smu_table->tables;
+	SystemMetricsTable_t *metrics;
 	struct smu_table *data_table;
+	struct smu_table *sys_table;
 	int ret, sensor_type;
 	u32 idx, sensors;
 	ssize_t size;
@@ -596,10 +611,12 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 		size = sizeof(*baseboard_temp_metrics);
 	}
 
-	ret = smu_v13_0_12_get_system_metrics_table(smu, NULL);
+	ret = smu_v13_0_12_get_system_metrics_table(smu);
 	if (ret)
 		return ret;
 
+	sys_table = &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
+	metrics = (SystemMetricsTable_t *)sys_table->cache.buffer;
 	smu_table_cache_update_time(data_table, jiffies);
 
 	if (type == SMU_TEMP_METRIC_GPUBOARD) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index e37b7b5358ea..ebee659f8a1c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -559,6 +559,10 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		       PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
+	SMU_TABLE_INIT(tables, SMU_TABLE_PMFW_SYSTEM_METRICS,
+		       smu_v13_0_12_get_system_metrics_size(), PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
+
 	metrics_table = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
 	if (!metrics_table)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index bcb8246c0804..aae9a546a67e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -82,6 +82,7 @@ int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
 
 bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
 int smu_v13_0_12_get_max_metrics_size(void);
+size_t smu_v13_0_12_get_system_metrics_size(void);
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
 int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 				      MetricsMember_t member, uint32_t *value);
-- 
2.49.0

