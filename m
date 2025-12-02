Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13122D116FE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 11:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A337110E628;
	Tue,  2 Dec 2025 11:44:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JJ+SzxNm";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D2B510E625
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 11:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKgBrDSoCsyqsSCGyOx4DxZExUP0+GJ7f5/ks0Kz0TNEdUG01whAWW0A0yUWwLuHdgTrRAJWh8frygGL2AhiPMbeBMV2w0r8RHFW+DKXCCiz0wJ3EmGuraM0hkqGEDQNKJdnKE8SpWM9Gfe5exPlTGNGhbxfAmzq6AszA4e87jO7f6rl8JBpHOtL0FNMO8GhwVtIxTOJuoTGoGqiqMpfWEvUE4vBp1GITCMLDvxF5+4MfNjoViUFJvkout1sj3kfxrsy4QLEMxni0UlVlKw1ogmveHAHYeiN6GXIQXc2tC+VqPjW37PdtgWRsDcvaZgZUKZCAyojkKzS4oGAfRfEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xNw3pcHjm/WLX+kTeH6ugoPbXqfHcUO4iOmQi2wXKw=;
 b=rHdVa5lx6KqeQUKyuL3HSVd3hO+z8OBu0GlRxnRHSQrHGWBlgR9YSvYwWc0hZMclAXxPqEyCjVWoMycjyc9mUdwPcJkAjaK0UC9iiqBZA6NqRtMXkJfljfis32FgD/KR1ApmusohYxxeOo9yzlxuiohza3GlcnGgwqghz1C032g76cPqqVpgZAn9P7uxiZt2pDVLdidoPumNlptmEDYKoHBipmG1yB8b8NYHdrPgW84wej/0N2KPx4nWpH80LmLz/mkwz4+iVk0bt1jOHhPzr4ny8Zvm8Z/+MahjrVhhYdwnr2pV99Ps5nmvDaXYQ4j2aARjmAAwBPn/3e/wOxPvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xNw3pcHjm/WLX+kTeH6ugoPbXqfHcUO4iOmQi2wXKw=;
 b=JJ+SzxNmw0ksweiBFowjpjb0VRq/9LNFQci3cVpmovCV9H5z/4j7XcNDfTPDX9kiLgVVoz8MrUv8iGILLAPKVYCyQERnkugRXP3dMqJbubKVt3QLL1FZ+di7hBquAxc3QuVXA1khNCZcFg7aVwm4PU8aMhzbePW5GlLHtY/h82E=
Received: from PH8P221CA0049.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::6)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 11:44:32 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:346:cafe::a8) by PH8P221CA0049.outlook.office365.com
 (2603:10b6:510:346::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 11:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Tue, 2 Dec 2025 11:44:32 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 05:44:30 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 5/7] drm/amd/pm: Use driver table structure in smuv14
Date: Tue, 2 Dec 2025 17:09:12 +0530
Message-ID: <20251202114358.512048-6-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: e768edb8-b952-44a6-723c-08de319828de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CPi9ciRZabmc25lCXn5x/cor8YrysDIQRyvdaxOqOL9Z7CHAXrmHrH82KdTk?=
 =?us-ascii?Q?sdu1Tqrcwi6dJ5FkGYBFNYsv6uZpg9a8bso2C5JPt8EC/TNy9Jqf5YpQi+lm?=
 =?us-ascii?Q?9aFJYravD4YsKitXvJ3uCckvw3dw8MQWbQCnyvlguA/VMKEul4dg/KrNYFXm?=
 =?us-ascii?Q?fJ8LumNApvXrYxI1OM+D4bLQt55cPVVD0OEsKAvjpe3bMalB2sP0UL89T0Ak?=
 =?us-ascii?Q?1MqSrfikrXJ9olFnyDOq1A78/JThNfmJ0gijPNmpjxA7Y5DWb7tkDtjv7HjV?=
 =?us-ascii?Q?5DUygdt3CRsohy6EF0pO8/yJaJN/SmQ9F220OKjEjMqDMexVo75HV29jv2UC?=
 =?us-ascii?Q?EJyb5Iby9k4p6hrdrhpvDhGdRvVW7+9ClBnIxI0oMIPIajfelDI3+TeKR864?=
 =?us-ascii?Q?fVllImoECj6xy0KhW81/OFXxDgY06H6w031MW74esU/3Jnwl1iJmDHMVNRoM?=
 =?us-ascii?Q?UBsmSOkqWJC0NHMEmJ5IaBooUb9IVUAGA9GP4NUFpnmYOgfVtqtnxxVQJDXc?=
 =?us-ascii?Q?IKMBh7DvVZZQ0uTYMWfEW/pE+gUVJEOT0Zsz08bnzAlmqbSjz9amyjoH5oiS?=
 =?us-ascii?Q?m0ChRLr+6bnht4JcMG1QIbA5HUTtkjNg5rq6y++0cl9padA7bk0O1rJCvgCr?=
 =?us-ascii?Q?nvNdqbAZwU7o0gXXnhb8okDon2YVPqQyt5I28lXUAUvq2XlSidf5RvyF2Ymv?=
 =?us-ascii?Q?4W6SCYykcJgq/V83JsNoseE5rQD39W20UeAvRMU2/p79tdNv7Eku15z0eAVw?=
 =?us-ascii?Q?zghPBYl/T9D0znQjVSctgaVwhHPNgYk5I5BJS2V68EunP9HFn4a+k7VlzHKb?=
 =?us-ascii?Q?VuNqWmq8+a3jjIUH6uPr/bHb6B+4xgaTWkHTnvRtzcEI8auuD1g3UBztMHe4?=
 =?us-ascii?Q?0DH21PXsOvnGZog5ms1SjU8yip19svrW72CiOkwOP3RsdVoAU8p2CaB2t2+L?=
 =?us-ascii?Q?iOxZoVMFhu78Te/1y4itEcEcWvnd7L+Mof4aHp0/9hfPmFtaIcbmjM3gcoDg?=
 =?us-ascii?Q?4vYxEbi9rpCbomeaRmiaEQzRl+eHld03e6p6v8cD9lZxYNVwoBP7v7uaY5L2?=
 =?us-ascii?Q?4RD/QANNG/oeigwTu2vcrIraUxeZaIW+HygyTKWW/VaZtSwusJRnvw7bAp/+?=
 =?us-ascii?Q?a9I2sIihkpd/F0R1a8HbVuEPW6dXrbaQiVid0UiT8J/Ep0JRDbJhWjtWz5Xc?=
 =?us-ascii?Q?A/rYn31XZkS7JIx2Rk27G/mtzMlNtbqDAW2ZFhVPBTbOJeTPRAK7VagiEKPH?=
 =?us-ascii?Q?VhgmneenXTwFg6Y97wg09HmqyHSYChwUJ7qatrKLwIBOK5ucxAu1oxEVYD3Q?=
 =?us-ascii?Q?kwyjobT6cYEErfKJpBRLbmOdQRigBHrexYQONUCFwguFUhqj7BetYlVOeQXP?=
 =?us-ascii?Q?/kpvIB6MgplQqsuCstt89bvR9C9JFtyDDcOH/hkDVqLLLsAJa6ZNnL0Qzc5a?=
 =?us-ascii?Q?rr7xeWuHnYTYn1eOTYaivCp66k0SfjAb2hSwGE/nqTFem2tQd2G6y+6OV5Ab?=
 =?us-ascii?Q?ql1/iTVoHFHfvcNS63cEqDUp7Z2OqG76wmrtwheFmrAKakDoxVem7SxxTkHA?=
 =?us-ascii?Q?RtmRvPuNbglrBetnK2A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 11:44:32.2289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e768edb8-b952-44a6-723c-08de319828de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
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

Use driver table structure for gpu metrics in smuv14. The default cache
interval is set at 5ms.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  3 +--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 19 +++++++++++--------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 16 ++++++++++------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index f9b0938c57ea..d7eb3bb74405 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -496,13 +496,12 @@ int smu_v14_0_fini_smc_tables(struct smu_context *smu)
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
-	kfree(smu_table->gpu_metrics_table);
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	kfree(smu_table->combo_pptable);
 	kfree(smu_table->boot_overdrive_table);
 	kfree(smu_table->overdrive_table);
 	kfree(smu_table->max_sustainable_clocks);
 	kfree(smu_table->driver_pptable);
-	smu_table->gpu_metrics_table = NULL;
 	smu_table->combo_pptable = NULL;
 	smu_table->boot_overdrive_table = NULL;
 	smu_table->overdrive_table = NULL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index b1bd946d8e30..52e213e88644 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -186,6 +186,7 @@ static int smu_v14_0_0_init_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -207,9 +208,10 @@ static int smu_v14_0_0_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v3_0);
-	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table)
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				    sizeof(struct gpu_metrics_v3_0),
+				    SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret)
 		goto err3_out;
 
 	return 0;
@@ -237,8 +239,7 @@ static int smu_v14_0_0_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->watermarks_table);
 	smu_table->watermarks_table = NULL;
 
-	kfree(smu_table->gpu_metrics_table);
-	smu_table->gpu_metrics_table = NULL;
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 
 	return 0;
 }
@@ -538,11 +539,11 @@ static int smu_v14_0_0_set_watermarks_table(struct smu_context *smu,
 }
 
 static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
-						void **table)
+					   void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v3_0 *gpu_metrics =
-		(struct gpu_metrics_v3_0 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v3_0 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -611,6 +612,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v3_0);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 2cea688c604f..49f3ac4c9015 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -415,6 +415,7 @@ static int smu_v14_0_2_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -441,9 +442,10 @@ static int smu_v14_0_2_tables_init(struct smu_context *smu)
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
@@ -459,7 +461,7 @@ static int smu_v14_0_2_tables_init(struct smu_context *smu)
 err3_out:
 	kfree(smu_table->watermarks_table);
 err2_out:
-	kfree(smu_table->gpu_metrics_table);
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 err1_out:
 	kfree(smu_table->metrics_table);
 err0_out:
@@ -2188,9 +2190,9 @@ static void smu_v14_0_2_set_smu_mailbox_registers(struct smu_context *smu)
 static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_3 *gpu_metrics =
-		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v1_3 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetricsExternal_t metrics_ext;
 	SmuMetrics_t *metrics = &metrics_ext.SmuMetrics;
 	int ret = 0;
@@ -2264,6 +2266,8 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
-- 
2.49.0

