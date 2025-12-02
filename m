Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E59D116FE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 11:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF5710E624;
	Tue,  2 Dec 2025 11:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fUzRj99n";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012004.outbound.protection.outlook.com
 [40.93.195.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A46C10E183
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 11:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAmOYidDozjadkN1iuS2rCAIUP3w8b/JQ4kIJ4/Pf/ewdWWekuvhZ7HTd6u4CdMR6aS2VOvtEiPkkjGTdFYE53CbPzFInRRfJ/dvVX4mdk6eyk5dVFb8vryhboFBJBMbd/kBXvQcZeiSpdGGYRye7xZokEXvMrvQuYyKURMskioPrFq2bDPacsrSIINh3HCpDkMMLKkH26lRtOGgOTfGz4kkVshW90Ajw3L/kffyuhgxRu76+KyZ+F1NTTuk57gRELNFURktdCBxaKEK9B/quID30ENcO9PP83bZU8fkOnkvmvmRLIXTizw+mQaLwF3lTDRWyGGkmo2b5gh/a7BVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tsq8xACEkqv1DdU2F4+QQ6V6+FdrGXLRvOIoZdY7B2c=;
 b=bEMpBOAb3mPCc80CLae97+L2bwdDGSNnAOLWRyeKbuy9mw/5Oq32mz4ZvUxaainorGO28YgAtnAp5dVpHCJ7M0si5dBwoNKMJiSV+a2IxIPfoIjZfQ2rkhyVahAQ90FmzeaXJM091Ji2khkD9wOJw1JPjAGqDaXRwPTen8/z9ciCMYC94bPAXSckbzmaiM0QrKW3YdVwrBvbqInBk1R1mPpRdkdHTH7Kz3ehbv5eZ/Oqnquup5fk3U0U8nsmHdaynCqEBdHpl4RgMk0PEycnzeHTpzNsnjyMKeMYOQzFqKMKAHzO3ghWlzqgg0m30DmwF6O/aP6zXvT0bCrLWwOPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tsq8xACEkqv1DdU2F4+QQ6V6+FdrGXLRvOIoZdY7B2c=;
 b=fUzRj99nkOaAKfJA7i3cYzLruYoKicM2uVzIpTyylNeM9qPy3s0xIZUkiCIFI/D6C0+irHwHdfC4lNuXEsAt06QD653U4eTD0z51ggHztYLbzho56mTya/BIdcP1cu7rOa0YnBfVekfE+v3K+hTgbkiQ2If9G6mLEUWHitQMWmA=
Received: from SJ0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:a03:331::35)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 11:44:27 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:331:cafe::dc) by SJ0PR03CA0090.outlook.office365.com
 (2603:10b6:a03:331::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 11:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Tue, 2 Dec 2025 11:44:26 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 05:44:24 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/7] drm/amd/pm: Use driver table structure in smuv11
Date: Tue, 2 Dec 2025 17:09:09 +0530
Message-ID: <20251202114358.512048-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251202114358.512048-1-lijo.lazar@amd.com>
References: <20251202114358.512048-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b51fd9-dd8a-4689-3cb3-08de319825b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PNms/qvTh7WjDyFV9WAev9cHcriQHkRayeusFUD718/peqWJNsUxTglDhAXb?=
 =?us-ascii?Q?ZzBS1tJqsHWgCkEXp+zPUibF96/3eZ3Tg1SMVt4xNdXCBrqwlWLxiinfEqEh?=
 =?us-ascii?Q?ClnyLXxKkIEKkkBMxQqiLM7uvWmFDZAL+lztaYx4bWm8EAyMyAFYcB4GL/Ha?=
 =?us-ascii?Q?0ifD3l4inn4qIkybkuiZUT3rd2armOVk8d3rNR8eQeUce7wsujAGDssVR7eD?=
 =?us-ascii?Q?r9U9hrD3FYzCqF935S168yowSmInnPLMObccEh9rNEIkJTPwgBV1/CbCNqL7?=
 =?us-ascii?Q?nQ0G94gFTNsKIYB6dmQD/z8Hchcuez7G46oEv72oPcygDY5VENxTE0NCVGHf?=
 =?us-ascii?Q?LsBovQc/LWEptEH0znTgHgNu7nT19NQqh7v78IiQy9KATVonMhCUcmRn8OOc?=
 =?us-ascii?Q?D9u3W4DPStLpjMLx24+WJlRpNa14EYt6lp9C+jkGRW66eN+ucuMb7xaT8neL?=
 =?us-ascii?Q?sSfIwOrlzboJvyHt1TC+4JpOcLFrpv3SxZ+9jOSgZjNdrKU7PQFXaP+1wXhU?=
 =?us-ascii?Q?ZTMaraNyNc9Gw1aYq9cYrZlzinwXktLFji63htUbhKm3ComYXjLjQ+DAmu3X?=
 =?us-ascii?Q?KHDnIY1TEyJkFrG60aW/IoGHqkFG1+t5/uBUUujY228KILr/1ffuyCfz6jNy?=
 =?us-ascii?Q?mpWcw6RGr8FWbLONWqHmWRjpczLM/Z15ADhN7tZZTKyyu9R0Tci4XRej2SJ4?=
 =?us-ascii?Q?R10PcvBNbzaDwHTkdDDWYqGs1mKcHcirUayP68UJsVc4ItQdloYfDQv7y83d?=
 =?us-ascii?Q?dgdUsMEQ0sQIjIo9H5zj+MhXiOaJB523rJKRGNmAY+9Kw4dri8NvCGHMDDCd?=
 =?us-ascii?Q?HfDSuh6cySSgL8zLc7bsxofSQxdeG7e7GZMZ9bT29o6PcmMGNDIpEXx26yA4?=
 =?us-ascii?Q?FpLmFGn96dzVWXqDW0MDar8sM0H8mCyBzU1F4Mtx8r9AN9TqGL0JRIoZa1EU?=
 =?us-ascii?Q?12DTu+YaLfa+Op38OKMovuJ6oRrZ2W/WL4xn9f8xBiY6xrL7D8IRSAxrifOF?=
 =?us-ascii?Q?a89PIB5zMEGjwV8eglLpqR1f8olyIyIyGjdvm/YoeBzO4FQ8FybnMgzAxSVc?=
 =?us-ascii?Q?29PbghBkpxozv4JxHv+7T1kmHYDXqreFn6FsoSYcLnerxqD+Lxs3ii58C8Ho?=
 =?us-ascii?Q?nqS40S+7C+EJx5sacHd8wRmI6SrrLwHi17hAhUmV83bJ+csepQMszubeDS9X?=
 =?us-ascii?Q?GxsMXeuUFWhJGDA5Aoy+HYyuLL10OMEicq0szDuTiahXitnju3RXvaTKJXWY?=
 =?us-ascii?Q?Xb0CWckdstSmt56M7sBRbRBNGaNuYb8MnIqYAUi/SUsqBU4Ss0YltvE3PBbn?=
 =?us-ascii?Q?dyPE/Ec0SUeiUvcq3upFJz9SM6nPaJxvAUOv+RaCx3097GWHkMGAemyiJb01?=
 =?us-ascii?Q?+X/Rgp85+2do0MlbtdjEHcTKUQzqy0LIr76hnmr3ZhrO6APB5IDwXC7qBSyu?=
 =?us-ascii?Q?IAs3TMlwt77nz1cju1mCLhFttceqpYFdIKyg0uPn40r23Y6tktAijkRnvMCs?=
 =?us-ascii?Q?QCB/fDam7gYo1mommdES09KB2eYGC567TAtAvsaGm23cHrqQOt2NYBf1+ctM?=
 =?us-ascii?Q?Nf6iFaGmBdKnbDIW2sI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 11:44:26.9538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b51fd9-dd8a-4689-3cb3-08de319825b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928
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

Use driver table structure for gpu metrics in smuv11. The default cache
interval is set at 5ms.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 16 ++++---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 15 ++++---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 33 +++++++++-----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 16 ++++---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 44 ++++++++++++-------
 7 files changed, 83 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 23ab75b705b6..e5c04da15b6f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -41,6 +41,8 @@
 #define SMU_CUSTOM_FAN_SPEED_RPM     (1 << 1)
 #define SMU_CUSTOM_FAN_SPEED_PWM     (1 << 2)
 
+#define SMU_GPU_METRICS_CACHE_INTERVAL 5
+
 // Power Throttlers
 #define SMU_THROTTLER_PPT0_BIT			0
 #define SMU_THROTTLER_PPT1_BIT			1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4fff78da81ff..dca4b2836696 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -251,6 +251,7 @@ static int arcturus_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -273,11 +274,12 @@ static int arcturus_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
-	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table) {
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				    sizeof(struct gpu_metrics_v1_3),
+				    SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret) {
 		kfree(smu_table->metrics_table);
-		return -ENOMEM;
+		return ret;
 	}
 
 	return 0;
@@ -1874,9 +1876,9 @@ static uint16_t arcturus_get_current_pcie_link_speed(struct smu_context *smu)
 static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 					void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_3 *gpu_metrics =
-		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v1_3 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1930,6 +1932,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 55401e6b2b0b..276d7559a2d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -88,6 +88,7 @@ static int cyan_skillfish_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
 				sizeof(SmuMetrics_t),
@@ -98,9 +99,10 @@ static int cyan_skillfish_tables_init(struct smu_context *smu)
 	if (!smu_table->metrics_table)
 		goto err0_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
-	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table)
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				    sizeof(struct gpu_metrics_v2_2),
+				    SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret)
 		goto err1_out;
 
 	smu_table->metrics_time = 0;
@@ -108,7 +110,6 @@ static int cyan_skillfish_tables_init(struct smu_context *smu)
 	return 0;
 
 err1_out:
-	smu_table->gpu_metrics_table_size = 0;
 	kfree(smu_table->metrics_table);
 err0_out:
 	return -ENOMEM;
@@ -384,9 +385,9 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
 static ssize_t cyan_skillfish_get_gpu_metrics(struct smu_context *smu,
 						void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v2_2 *gpu_metrics =
-		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v2_2 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_t metrics;
 	int i, ret = 0;
 
@@ -433,6 +434,8 @@ static ssize_t cyan_skillfish_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v2_2);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7c9f77124ab2..4822e446468e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -495,8 +495,8 @@ static int navi10_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
-	struct smu_table *dummy_read_1_table =
-			&smu_table->dummy_read_1_table;
+	struct smu_table *dummy_read_1_table = &smu_table->dummy_read_1_table;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -526,9 +526,10 @@ static int navi10_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
-	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table)
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				    sizeof(struct gpu_metrics_v1_3),
+				    SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret)
 		goto err1_out;
 
 	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
@@ -545,7 +546,7 @@ static int navi10_tables_init(struct smu_context *smu)
 err3_out:
 	kfree(smu_table->watermarks_table);
 err2_out:
-	kfree(smu_table->gpu_metrics_table);
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 err1_out:
 	kfree(smu_table->metrics_table);
 err0_out:
@@ -2964,7 +2965,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_3 *gpu_metrics =
-		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v1_3 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
 
@@ -3026,6 +3028,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
@@ -3172,7 +3176,8 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_3 *gpu_metrics =
-		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v1_3 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -3236,6 +3241,8 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
@@ -3244,7 +3251,8 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_3 *gpu_metrics =
-		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v1_3 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_NV12_legacy_t metrics;
 	int ret = 0;
 
@@ -3311,6 +3319,8 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
@@ -3319,7 +3329,8 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_3 *gpu_metrics =
-		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v1_3 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_NV12_t metrics;
 	int ret = 0;
 
@@ -3388,6 +3399,8 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 774283ac7827..a0dc585877fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -533,6 +533,7 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
 	int table_size;
+	int ret;
 
 	table_size = get_table_size(smu);
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, table_size,
@@ -560,9 +561,10 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
-	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table)
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				    sizeof(struct gpu_metrics_v1_3),
+				    SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret)
 		goto err1_out;
 
 	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
@@ -585,7 +587,7 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 err3_out:
 	kfree(smu_table->watermarks_table);
 err2_out:
-	kfree(smu_table->gpu_metrics_table);
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 err1_out:
 	kfree(smu_table->metrics_table);
 err0_out:
@@ -2674,9 +2676,9 @@ static void sienna_cichlid_i2c_control_fini(struct smu_context *smu)
 static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 					      void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_3 *gpu_metrics =
-		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v1_3 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetricsExternal_t metrics_external;
 	SmuMetrics_t *metrics =
 		&(metrics_external.SmuMetrics);
@@ -2825,6 +2827,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b0d6487171d7..32055e6c313f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -428,14 +428,13 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
-	kfree(smu_table->gpu_metrics_table);
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	kfree(smu_table->user_overdrive_table);
 	kfree(smu_table->boot_overdrive_table);
 	kfree(smu_table->overdrive_table);
 	kfree(smu_table->max_sustainable_clocks);
 	kfree(smu_table->driver_pptable);
 	kfree(smu_table->clocks_table);
-	smu_table->gpu_metrics_table = NULL;
 	smu_table->user_overdrive_table = NULL;
 	smu_table->boot_overdrive_table = NULL;
 	smu_table->overdrive_table = NULL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 9626da2dba58..f2b9f2e3c2df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -225,6 +225,7 @@ static int vangogh_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -242,11 +243,12 @@ static int vangogh_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
-	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_3));
-	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_4));
-	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table)
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				    max3(sizeof(struct gpu_metrics_v2_2),
+					 sizeof(struct gpu_metrics_v2_3),
+					 sizeof(struct gpu_metrics_v2_4)),
+				    SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret)
 		goto err1_out;
 
 	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
@@ -262,7 +264,7 @@ static int vangogh_tables_init(struct smu_context *smu)
 err3_out:
 	kfree(smu_table->watermarks_table);
 err2_out:
-	kfree(smu_table->gpu_metrics_table);
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 err1_out:
 	kfree(smu_table->metrics_table);
 err0_out:
@@ -1652,9 +1654,9 @@ static int vangogh_set_watermarks_table(struct smu_context *smu,
 static ssize_t vangogh_get_legacy_gpu_metrics_v2_3(struct smu_context *smu,
 				      void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v2_3 *gpu_metrics =
-		(struct gpu_metrics_v2_3 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v2_3 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
 
@@ -1703,15 +1705,17 @@ static ssize_t vangogh_get_legacy_gpu_metrics_v2_3(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v2_3);
 }
 
 static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v2_2 *gpu_metrics =
-		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v2_2 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
 
@@ -1760,15 +1764,17 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v2_2);
 }
 
 static ssize_t vangogh_get_gpu_metrics_v2_3(struct smu_context *smu,
 				      void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v2_3 *gpu_metrics =
-		(struct gpu_metrics_v2_3 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v2_3 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1831,6 +1837,8 @@ static ssize_t vangogh_get_gpu_metrics_v2_3(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v2_3);
 }
 
@@ -1838,9 +1846,9 @@ static ssize_t vangogh_get_gpu_metrics_v2_4(struct smu_context *smu,
 					    void **table)
 {
 	SmuMetrics_t metrics;
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v2_4 *gpu_metrics =
-				(struct gpu_metrics_v2_4 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v2_4 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	int ret = 0;
 
 	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
@@ -1911,15 +1919,17 @@ static ssize_t vangogh_get_gpu_metrics_v2_4(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v2_4);
 }
 
 static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v2_2 *gpu_metrics =
-		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v2_2 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1975,6 +1985,8 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v2_2);
 }
 
-- 
2.49.0

