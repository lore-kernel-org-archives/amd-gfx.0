Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F8BD116F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 11:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACBB210E625;
	Tue,  2 Dec 2025 11:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AmK+n7yR";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012039.outbound.protection.outlook.com
 [40.93.195.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD4B10E625
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 11:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlPyHWh2/q9zzhi2JSQdZvJK12uOJuNRYX948qXALpW/5FIgp9/z0XZ0DJlo9MyXZ4WiJCdbaZcv36GEMGcCyrsRZROHbIHlE2wjnTlwpNjnB6xXAA/LB2jylhyD8lYmdbNkSMDgVSsD5CyuBwOERoMJt034pkpYoi4Es+fqaDbKI8IQ8CLT151V78nmzyaGaR7Qweex5YQDPj76yHJ0oX2FBf9Ei+GdCC2zjjLgRpR/blmMqfWJtJlCO2lofB1ZNGyeC5T6qjmanANwhVfKHyRHfVOPrYRPvlyosXh/ESJH81slce3pIAYPRREk91WVjlL1bb75G0/pvQISsalc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFbYc0mbL7tbQQE6ELJC8QYCmF0B5yBGABCf8lXuqVg=;
 b=oCJGd29/5mlIKUcEtcsYoL00mcROrA0xgXjkJkie6nreE0jG39KLNWVwXN9PFYVqIq9P4+EGl46/936FhUwDGDtWEp1iCEY9PYhhrWrL2SBVhpWldFu7OS//xOwxs1hAZ+9hjTpbND2eew9fCxA1YoxOyFOGv4TtjgC5sPNsorqrHc0tiuB63QjIZcS+C4VZASSOAk4ZvDnzfA4at22o2FHJ5GU0qjHgdPCMKtaUMqGLLkKZPQUQ1sQTy2MVJwufE9x0vp4B/V4Ti0XXVt0MojSO0lZPcOB8io0HMKdq4Aogc147RLyjFp3fhNaCFg2uS3ExtR1Q33IL8SWSurNptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFbYc0mbL7tbQQE6ELJC8QYCmF0B5yBGABCf8lXuqVg=;
 b=AmK+n7yRE+5rRKQ830+fLtmftdm/RZa91udwKVkaLEFCsA89MAcPXz+IwnFyBMI+YxATQGZlJJ505z+udfMRCpsYgZFIGLFz5REbV4BIUAk3Vx6vjHB0b0SHvBrmr6TeHXm8wVJJ9uR90uqDvwncdrEySQo8f7oABOlzbXe4J+Y=
Received: from BY3PR10CA0007.namprd10.prod.outlook.com (2603:10b6:a03:255::12)
 by LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 11:44:31 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::57) by BY3PR10CA0007.outlook.office365.com
 (2603:10b6:a03:255::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 11:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Tue, 2 Dec 2025 11:44:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 05:44:28 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 4/7] drm/amd/pm: Use driver table structure in smuv13
Date: Tue, 2 Dec 2025 17:09:11 +0530
Message-ID: <20251202114358.512048-5-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: 931a2858-d893-4560-17f4-08de319827e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6S3nZgHNrHhFcdkEzH34fPrHohVS465tNBWAmL6GzQaRU+bupEivjNyvkQO9?=
 =?us-ascii?Q?kfSnAI9nJf9s0U8CQLgp1HDzoBuY+7v197Fw6x32uaLCoKoYRGdj45d/HGdo?=
 =?us-ascii?Q?vnCwlbTSjRYVQ68GLcLPCGMk+hua2tcMOmWPH8KKY22CTuyo0x7coeiLZmMy?=
 =?us-ascii?Q?t1o0ZWrU9Hnx+qoPdXcQbCVOcXYliGF1c6akoz45rl5EaBry03T2mgNZndBA?=
 =?us-ascii?Q?UeSBnvTKYVF/VeR5nb2mA2+7iHwYPXNq0SJyTnZeNexiOJg4knL4V4opbkQZ?=
 =?us-ascii?Q?E+FYzsnuyeKobgRNkZcrsOsCmOVglDbl2Tk75LVbPTEpSXl2DyZJDszQ4K75?=
 =?us-ascii?Q?4Hdrz0h3N9SAcSw5yVWH1d6DBlarEU1NgIK59yhkg94/LyK3SBRROo+14k+s?=
 =?us-ascii?Q?yct7UkQhmkFMWj8hK72dL9tP8lOeWSQk20hEqOyfQdyIsNeO4InjhSLhutWt?=
 =?us-ascii?Q?l4WEG4UzX6Eu2LGLSMV/bp55Mh4z9N3mzh2cBgIbU8qHdrAKuflRhgia9Eto?=
 =?us-ascii?Q?7IJFiBuhpyDuwFiRZOGB8P1UlQfx691QJl4oI0bNPmhqkR1bG1vBZ+urIk1m?=
 =?us-ascii?Q?jhPH0/ifZep28HI8Tx/0IYKEHrZW6xyAlMAnvBHPpipLlEsXmmG8Skpm4AG5?=
 =?us-ascii?Q?07U9IYUUWi4mDrmm8U5743W0LSWYUEtppkhiFd4/RiNkJCsaTBODhFAk1KRq?=
 =?us-ascii?Q?86hwsrWqzikizc0Lfx7CfLZQga67rv7zoXBRzBbTkj/QwVMQaigfG2Iz8anX?=
 =?us-ascii?Q?M+F5HeddQkxDmyHeoy3Q6Bt6hN9B6OPvK2RVSWJ+HOkUOL/uOtdHB6hTzQVJ?=
 =?us-ascii?Q?YoMXmaTMpkByxieDYKBrLsuk6phKyQ/bNXpBQ+7oyTsB+hWze1o+m+njQ+3H?=
 =?us-ascii?Q?YJgbDMDnaWAM/GPtTObiFGaKL1cQ+FtsBESlMZwFmrHayEHCwipOfSFJAZqO?=
 =?us-ascii?Q?E/FpSqHvw3dlHdHowRHc2q7y/D7fPkYSf9fHsmo1HCrunRtTmGnGWds+2iwE?=
 =?us-ascii?Q?NoRVTnurOyf0FDfxerT0LY8fPrLn/VIqhlO2JuI3RKnfe4L2AZwP7JZbZZqo?=
 =?us-ascii?Q?THzECBrIeXAxwyzQIsmA9+qlRfsLWRox63ESQs6B0NheW10W57VKyWYsLZ//?=
 =?us-ascii?Q?ZNK9mt3Z0cnC5r2FuUMxBHbJGa3Ik3iTzvOonKH/E8A9gNtDWiFyeo/oZFu/?=
 =?us-ascii?Q?DIhd/ScUtVCEWDCZJv7hdbw3c7KIY2qbO+h7DwkoJSAult/V7lRY3Ust6jpz?=
 =?us-ascii?Q?J+/y5700aW553kHEgbHrIFxyGiVS62hm+dy1Ty9kF/25+ykcSJe6ncSXa/fo?=
 =?us-ascii?Q?FEBHzp2d8FPQ+4kUSS2+dCzQwqY3Ca4kS7JMu+L7ku1cHgNyaOmjWmM0I7hf?=
 =?us-ascii?Q?8bGVmXXGHMlTnEFXOJbBP436mvde6FzSV8v/k3k0LL7vhME0sIUGIwEpYi5C?=
 =?us-ascii?Q?FWTpHU1bN60r1K+/NRgyIetVvq7M/PJsuOjzHePT8fuuUC9Do5jgv5d+L5ie?=
 =?us-ascii?Q?b2sGTnCUs/ThykH7BgABP2MgiS7/4SuZwTXea3vHL4f33xsEVe5j/wlnDiFg?=
 =?us-ascii?Q?ddwSVzNL4c6BPzttgCU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 11:44:30.6169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931a2858-d893-4560-17f4-08de319827e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756
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

Use driver table structure for gpu metrics in smuv13. The default cache
interval is set at 5ms.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 18 +++++++++------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  3 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 16 ++++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 17 ++++++++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 19 ++++++++-------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 ++++++++++---------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 16 ++++++++-----
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 19 ++++++++-------
 8 files changed, 76 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 18d5d0704509..4dd257dc5298 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -228,6 +228,7 @@ static int aldebaran_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -249,17 +250,18 @@ static int aldebaran_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
-	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table) {
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				     sizeof(struct gpu_metrics_v1_3),
+				     SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret) {
 		kfree(smu_table->metrics_table);
-		return -ENOMEM;
+		return ret;
 	}
 
 	smu_table->ecc_table = kzalloc(tables[SMU_TABLE_ECCINFO].size, GFP_KERNEL);
 	if (!smu_table->ecc_table) {
 		kfree(smu_table->metrics_table);
-		kfree(smu_table->gpu_metrics_table);
+		smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 		return -ENOMEM;
 	}
 
@@ -1762,9 +1764,9 @@ static int aldebaran_get_current_pcie_link_speed(struct smu_context *smu)
 static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 					 void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_3 *gpu_metrics =
-		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v1_3 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_t metrics;
 	int i, ret = 0;
 
@@ -1836,6 +1838,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a89075e25717..dc81652fc684 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -507,14 +507,13 @@ int smu_v13_0_fini_smc_tables(struct smu_context *smu)
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
-	kfree(smu_table->gpu_metrics_table);
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	kfree(smu_table->combo_pptable);
 	kfree(smu_table->user_overdrive_table);
 	kfree(smu_table->boot_overdrive_table);
 	kfree(smu_table->overdrive_table);
 	kfree(smu_table->max_sustainable_clocks);
 	kfree(smu_table->driver_pptable);
-	smu_table->gpu_metrics_table = NULL;
 	smu_table->combo_pptable = NULL;
 	smu_table->user_overdrive_table = NULL;
 	smu_table->boot_overdrive_table = NULL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 677781060246..5d88ecbd31de 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -482,6 +482,7 @@ static int smu_v13_0_0_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -511,9 +512,10 @@ static int smu_v13_0_0_tables_init(struct smu_context *smu)
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
@@ -529,7 +531,7 @@ static int smu_v13_0_0_tables_init(struct smu_context *smu)
 err3_out:
 	kfree(smu_table->watermarks_table);
 err2_out:
-	kfree(smu_table->gpu_metrics_table);
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 err1_out:
 	kfree(smu_table->metrics_table);
 err0_out:
@@ -2105,9 +2107,9 @@ static int smu_v13_0_0_get_thermal_temperature_range(struct smu_context *smu,
 static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
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
@@ -2181,6 +2183,8 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 6908f9930f16..51d45a9bc2f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -151,6 +151,7 @@ static int smu_v13_0_4_init_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -172,9 +173,10 @@ static int smu_v13_0_4_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
-	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table)
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				     sizeof(struct gpu_metrics_v2_1),
+				     SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret)
 		goto err3_out;
 
 	return 0;
@@ -202,8 +204,7 @@ static int smu_v13_0_4_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->watermarks_table);
 	smu_table->watermarks_table = NULL;
 
-	kfree(smu_table->gpu_metrics_table);
-	smu_table->gpu_metrics_table = NULL;
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 
 	return 0;
 }
@@ -247,9 +248,9 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 static ssize_t smu_v13_0_4_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v2_1 *gpu_metrics =
-		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v2_1 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -294,6 +295,8 @@ static ssize_t smu_v13_0_4_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v2_1);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 4576bf008b22..2f6ed5fd3985 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -125,6 +125,7 @@ static int smu_v13_0_5_init_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -146,9 +147,10 @@ static int smu_v13_0_5_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
-	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table)
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				     sizeof(struct gpu_metrics_v2_1),
+				     SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret)
 		goto err3_out;
 
 	return 0;
@@ -176,8 +178,7 @@ static int smu_v13_0_5_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->watermarks_table);
 	smu_table->watermarks_table = NULL;
 
-	kfree(smu_table->gpu_metrics_table);
-	smu_table->gpu_metrics_table = NULL;
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 
 	return 0;
 }
@@ -466,11 +467,11 @@ static int smu_v13_0_5_set_watermarks_table(struct smu_context *smu,
 }
 
 static ssize_t smu_v13_0_5_get_gpu_metrics(struct smu_context *smu,
-						void **table)
+					   void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v2_1 *gpu_metrics =
-		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v2_1 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -500,6 +501,8 @@ static ssize_t smu_v13_0_5_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v2_1);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a3ceecbe5d68..f7d47dd2f3c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -589,20 +589,22 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 	if (!driver_pptable)
 		return -ENOMEM;
 
-	ret = smu_table_cache_init(smu, SMU_TABLE_SMU_METRICS,
-				   sizeof(struct smu_v13_0_6_gpu_metrics), 1);
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				    sizeof(struct smu_v13_0_6_gpu_metrics),
+				    SMU_GPU_METRICS_CACHE_INTERVAL);
 	if (ret)
 		return ret;
 
-	gpu_metrics = (struct smu_v13_0_6_gpu_metrics
-			       *)(tables[SMU_TABLE_SMU_METRICS].cache.buffer);
+	gpu_metrics = (struct smu_v13_0_6_gpu_metrics *)smu_driver_table_ptr(
+		smu, SMU_DRIVER_TABLE_GPU_METRICS);
 
 	smu_v13_0_6_gpu_metrics_init(gpu_metrics, 1, 9);
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
 	    IP_VERSION(13, 0, 12)) {
 		ret = smu_v13_0_12_tables_init(smu);
 		if (ret) {
-			smu_table_cache_fini(smu, SMU_TABLE_SMU_METRICS);
+			smu_driver_table_fini(smu,
+					      SMU_DRIVER_TABLE_GPU_METRICS);
 			return ret;
 		}
 	}
@@ -742,7 +744,6 @@ static int smu_v13_0_6_fini_smc_tables(struct smu_context *smu)
 {
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
 		smu_v13_0_12_tables_fini(smu);
-	smu_table_cache_fini(smu, SMU_TABLE_SMU_METRICS);
 	return smu_v13_0_fini_smc_tables(smu);
 }
 
@@ -2852,8 +2853,6 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_table *tables = smu_table->tables;
 	struct smu_v13_0_6_gpu_metrics *gpu_metrics;
 	int version = smu_v13_0_6_get_metrics_version(smu);
 	MetricsTableV0_t *metrics_v0 __free(kfree) = NULL;
@@ -2871,8 +2870,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		return ret;
 
 	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
-	gpu_metrics = (struct smu_v13_0_6_gpu_metrics
-			       *)(tables[SMU_TABLE_SMU_METRICS].cache.buffer);
+	gpu_metrics = (struct smu_v13_0_6_gpu_metrics *)smu_driver_table_ptr(
+		smu, SMU_DRIVER_TABLE_GPU_METRICS);
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
 	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
@@ -3057,7 +3056,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, version);
 
 fill:
-	*table = tables[SMU_TABLE_SMU_METRICS].cache.buffer;
+	*table = gpu_metrics;
+
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 
 	return sizeof(*gpu_metrics);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index a3fc35b9011e..ffed8c2bcfe5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -497,6 +497,7 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -525,9 +526,10 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
-	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table)
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				     sizeof(struct gpu_metrics_v1_3),
+				     SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret)
 		goto err1_out;
 
 	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
@@ -537,7 +539,7 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
 	return 0;
 
 err2_out:
-	kfree(smu_table->gpu_metrics_table);
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 err1_out:
 	kfree(smu_table->metrics_table);
 err0_out:
@@ -2091,9 +2093,9 @@ static int smu_v13_0_7_get_thermal_temperature_range(struct smu_context *smu,
 static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
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
@@ -2167,6 +2169,8 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 5d7e671fa3c3..7e43ca81e416 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -152,6 +152,7 @@ static int yellow_carp_init_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -173,9 +174,10 @@ static int yellow_carp_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
-	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table)
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				     sizeof(struct gpu_metrics_v2_1),
+				     SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret)
 		goto err3_out;
 
 	return 0;
@@ -203,8 +205,7 @@ static int yellow_carp_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->watermarks_table);
 	smu_table->watermarks_table = NULL;
 
-	kfree(smu_table->gpu_metrics_table);
-	smu_table->gpu_metrics_table = NULL;
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 
 	return 0;
 }
@@ -557,11 +558,11 @@ static int yellow_carp_set_watermarks_table(struct smu_context *smu,
 }
 
 static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
-						void **table)
+					    void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v2_1 *gpu_metrics =
-		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v2_1 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -606,6 +607,8 @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v2_1);
 }
 
-- 
2.49.0

