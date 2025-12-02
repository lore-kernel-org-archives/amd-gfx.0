Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069DED11701
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 11:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BB310E62A;
	Tue,  2 Dec 2025 11:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nQjZxOzd";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8B2310E62A
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 11:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bViKJJyQShRuLIaTgJEcSfz9MJjczSv8dDeeEmUcGYbXZzNhiBqBPvr/jdbWW/okG068NY+6V4dIhUK8RzZeRcS2WEHHWVkp4y+DK6UzBSVQ3scrTyt/29jtgZo9n4+AIkC3TS9CFNosk50K/d6yG8hRZx2dWOTvYJeLsAb8/2RvDx4BlyYw0h3LaW2KhxJTY2N90tNRzbAmHUUKGN0CUJeQ/UAYZ8QCKto/mZNjOLSN7gingPXs0syrYtXUc96J2Z1famFNyMQcHQaxtMK3UmGRY8z/79teItxfzJOOlWCnr+ltUq97I1pwX3iS5dERZSp9K55+ekhD8ViJ4mfxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuTuNzzoF6i2D1frEwOiMs15rmQDKaTXxvtgWagYTwA=;
 b=BSgAOsyb5oDZIxCA5Cle0dtjN0EuhCynsFBuHXMV4VFYC10tFKox854Y7XjCzLTK1d/RxnE8G/AU3TRulpmAJ8hSvskPtjQfKLmx9TyVxY3JURycLs+tE7myz/8n6Ac4LFbUH2/p6rEnIpvLR9OzvzMlyOIRVuU/e9sygDQy/8s1RW4HRRP8ERx2I6PribsOcVV3MOYtH1iItX2z2zQvg9LLS6iYjfGmfuUrYJjFyv8WEUj5auaT84f5tjww6DTHyLdKtf5rLjct+Yzz6NrF1G/IZhxpM4ynnI3oDWMG185KvtjEEvLnqz4L6xNLOO2zsDpoH2QiYwp6Qj9HP0+7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuTuNzzoF6i2D1frEwOiMs15rmQDKaTXxvtgWagYTwA=;
 b=nQjZxOzdqeZkYAV0HC5j0D6C9HdyhJA8tsvFLFQHPiaBI+mWyLaQEFe0df/d9DCWgnp6UOFZdjuGgn2TOli7ZiMdv5dip3OjdaT44xIbIe0apy4kvt4cqwvTiB2JNfmuNnFiZ5h2E/JQ2eKeFyXG0ZWmyJwy/HF2GVZ7cvrr4OY=
Received: from SJ0PR03CA0165.namprd03.prod.outlook.com (2603:10b6:a03:338::20)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 11:44:36 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:338:cafe::36) by SJ0PR03CA0165.outlook.office365.com
 (2603:10b6:a03:338::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 11:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Tue, 2 Dec 2025 11:44:35 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 05:44:33 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 7/7] drm/amd/pm: Use driver table for board temperature
Date: Tue, 2 Dec 2025 17:09:14 +0530
Message-ID: <20251202114358.512048-8-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 4091aa3d-5e97-4366-a8d4-08de31982af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ealMycJA19AenQ+NVU1IDe5Z9psg1FRB9cNel0zrmYJC0+aca2AeEaNmzKO?=
 =?us-ascii?Q?YKMXBJU1t1Kv1IqeeD+zCgbxWt7XdBcQbmeAk5aPx6HckOjqlU29q3VCiSIP?=
 =?us-ascii?Q?YfSrDhplCawewZD1KVt0nRddkOzz+ri1ItwjdlTUGMsqkGV/D9Z8+HA8ajtv?=
 =?us-ascii?Q?tEu1vvRGyn8UKR2vzRr8wESnSGvJN1W5ax3KC/dBSxwJ9h80j3IOvcgG68Iy?=
 =?us-ascii?Q?vG7syKLIVWC2rwYsnQQk8d/tbFMD83cKIGvQz9xH7g4945kK1GXcD/3FbLvM?=
 =?us-ascii?Q?7th1IxGO8Sihu61a+KpOzaY7FJH+IihDJ7IVnfTVjcIku9XqKDyThQyq5IVv?=
 =?us-ascii?Q?rwwz2JGEuHmVDc/Aota9V0cAWMd2YIVC0yXAmHE0sWQlmdkUTrE0i/1eLK18?=
 =?us-ascii?Q?gvPiJtgCogHk1U0B5Fv1vJUvGSrVEs0B8Jg/ecQ90x0BTOlb6SVeVOnfJGbN?=
 =?us-ascii?Q?cvuHFyCGFanzsACuMfYxm0Qw4iBP2allhDlTZOruWctBMTQKMl25/+sL5x5b?=
 =?us-ascii?Q?JawRTf+sfp1oMhIV5bfmULvpCYZKC2RfNvWdBso2VGGeUT8AfwyXMbDodhRP?=
 =?us-ascii?Q?ewgVGqgI/8r4YHl480NJNbEfZ6xLLJYe8D5puQdqSu2MMkmh7CMwaYk1ynes?=
 =?us-ascii?Q?IBMmTTRyMjNclyyJDk0BhRKwwm8NzwDlMBlfypjWPxaMO0OCfb2G6hC4RAQp?=
 =?us-ascii?Q?RZjH/tOWf98IsTJmSGGTBG+g/AvwFEOf3YJVGaaSQKyDqoxLKDTfHTxoFMUu?=
 =?us-ascii?Q?NkjwnPtaCpVL2XO3ZjrM3R68Ux3VXkRCFr8+19CGO6bG/lbUS+/kDlRA+CGD?=
 =?us-ascii?Q?6nrT3CRoRXhy2ij6uiHFatkEQbom9zvRgQk+zpFDqtssXNahOmpQTUmc+NfL?=
 =?us-ascii?Q?HKcRI+/XWyFukO6oOEPGCs0Bz8O4CvKwIdRdRAFOchf7IyPhYVF2PkJsz61D?=
 =?us-ascii?Q?mMw0wUyi+UOge6+QdRLXwFKgxvXdFfAJgdFApYeT0FsLsuXiVXHbxkMw1Ko3?=
 =?us-ascii?Q?aIJOipLRKVUOh+60iuKElMqsR/9hvi5GTbM+R0K+phFEhlFqMYTKyd0NXaFb?=
 =?us-ascii?Q?ky4cjhR4E6H755C46CbylqUmuFMHavyg88QzYuLhbRP2ZBUjBHwrGZWtTQdE?=
 =?us-ascii?Q?w9ytjhXL0GRUn9eE0xr2KjRSAwT4Up883/fdLys6pMzyzRaNR32RevvyCOMH?=
 =?us-ascii?Q?6Uzo6X9nVbKmuTrMwbM2J1svDJXNqnujjbZPGlJC2IrzFPqsVQ+eanjJb0dw?=
 =?us-ascii?Q?pZ+YDS79+SPp0ZMw2yzKou3fgDFajMZpFCp+sYS087VvOfOwmmQzFrGxl3vQ?=
 =?us-ascii?Q?ZyYmlicARNLAKpwDXcnFCoapr9KqQIjSqhrlTVCzxavMQuCgIrgUI/LtbkMj?=
 =?us-ascii?Q?Dvq8UlbzM/5jcD20IU2f7UIgsQ6an9JzwSU0iormIxuofiJzUEXVmh1yuFSu?=
 =?us-ascii?Q?HgZlFtF8hFQdURUGRuJD33KZ11SIMhCQEIlQyd2M9WwdGLVa3jeMzL3xhL5E?=
 =?us-ascii?Q?hxlJuLdB7/xwlnZ1a7D0sBPjIUrvz0OvQ/go/Trc66Egu1cCMepv7aUdvNV0?=
 =?us-ascii?Q?gEgTWVc1TpNC0uylyM8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 11:44:35.7252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4091aa3d-5e97-4366-a8d4-08de31982af3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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

GPU board and Baseboard temperatures come from system metrics table.
Driver keeps separate metrics table for both. Use the new driver table
structure to represent them.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 20 ++++----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 14 +++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 49 ++++++++++---------
 3 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d0806deb9ce9..fd926552ac6f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3891,8 +3891,9 @@ static ssize_t smu_sys_get_temp_metrics(void *handle, enum smu_temp_metric_type
 {
 	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_table *tables = smu_table->tables;
-	enum smu_table_id table_id;
+	struct smu_driver_table *driver_tables = smu_table->driver_tables;
+	enum smu_driver_table_id table_id;
+	struct smu_driver_table *temp_table;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -3902,17 +3903,18 @@ static ssize_t smu_sys_get_temp_metrics(void *handle, enum smu_temp_metric_type
 
 	table_id = smu_metrics_get_temp_table_id(type);
 
-	if (table_id == SMU_TABLE_COUNT)
+	if (table_id == SMU_DRIVER_TABLE_COUNT)
 		return -EINVAL;
 
+	temp_table = &driver_tables[table_id];
+
 	/* If the request is to get size alone, return the cached table size */
-	if (!table && tables[table_id].cache.size)
-		return tables[table_id].cache.size;
+	if (!table && temp_table->cache.size)
+		return temp_table->cache.size;
 
-	if (smu_table_cache_is_valid(&tables[table_id])) {
-		memcpy(table, tables[table_id].cache.buffer,
-		       tables[table_id].cache.size);
-		return tables[table_id].cache.size;
+	if (smu_driver_table_is_valid(temp_table)) {
+		memcpy(table, temp_table->cache.buffer, temp_table->cache.size);
+		return temp_table->cache.size;
 	}
 
 	return smu->smu_temp.temp_funcs->get_temp_metrics(smu, type, table);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3b8bd8c9827a..03ecbeefa67b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -273,6 +273,8 @@ struct smu_table {
 
 enum smu_driver_table_id {
 	SMU_DRIVER_TABLE_GPU_METRICS = 0,
+	SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS,
+	SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS,
 	SMU_DRIVER_TABLE_COUNT,
 };
 
@@ -344,8 +346,6 @@ enum smu_table_id {
 	SMU_TABLE_ECCINFO,
 	SMU_TABLE_COMBO_PPTABLE,
 	SMU_TABLE_WIFIBAND,
-	SMU_TABLE_GPUBOARD_TEMP_METRICS,
-	SMU_TABLE_BASEBOARD_TEMP_METRICS,
 	SMU_TABLE_PMFW_SYSTEM_METRICS,
 	SMU_TABLE_COUNT,
 };
@@ -1691,19 +1691,19 @@ typedef struct {
 struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
 					 enum pp_pm_policy p_type);
 
-static inline enum smu_table_id
+static inline enum smu_driver_table_id
 smu_metrics_get_temp_table_id(enum smu_temp_metric_type type)
 {
 	switch (type) {
 	case SMU_TEMP_METRIC_BASEBOARD:
-		return SMU_TABLE_BASEBOARD_TEMP_METRICS;
+		return SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS;
 	case SMU_TEMP_METRIC_GPUBOARD:
-		return SMU_TABLE_GPUBOARD_TEMP_METRICS;
+		return SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS;
 	default:
-		return SMU_TABLE_COUNT;
+		return SMU_DRIVER_TABLE_COUNT;
 	}
 
-	return SMU_TABLE_COUNT;
+	return SMU_DRIVER_TABLE_COUNT;
 }
 
 static inline void smu_table_cache_update_time(struct smu_table *table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 07bee1f32f54..91a17db7912b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -156,9 +156,6 @@ int smu_v13_0_12_tables_init(struct smu_context *smu)
 {
 	struct amdgpu_baseboard_temp_metrics_v1_0 *baseboard_temp_metrics;
 	struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_table *tables = smu_table->tables;
-	struct smu_table_cache *cache;
 	int ret;
 
 	ret = smu_table_cache_init(smu, SMU_TABLE_PMFW_SYSTEM_METRICS,
@@ -167,25 +164,28 @@ int smu_v13_0_12_tables_init(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_table_cache_init(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS,
-				   sizeof(*baseboard_temp_metrics), 50);
+	ret = smu_driver_table_init(smu,
+				    SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS,
+				    sizeof(*baseboard_temp_metrics), 50);
 	if (ret)
 		return ret;
 	/* Initialize base board temperature metrics */
-	cache = &(tables[SMU_TABLE_BASEBOARD_TEMP_METRICS].cache);
-	baseboard_temp_metrics =
-		(struct amdgpu_baseboard_temp_metrics_v1_0 *) cache->buffer;
+	baseboard_temp_metrics = (struct amdgpu_baseboard_temp_metrics_v1_0 *)
+		smu_driver_table_ptr(smu,
+				     SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS);
 	smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics, 1, 0);
 	/* Initialize GPU board temperature metrics */
-	ret = smu_table_cache_init(smu, SMU_TABLE_GPUBOARD_TEMP_METRICS,
-				   sizeof(*gpuboard_temp_metrics), 50);
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS,
+				    sizeof(*gpuboard_temp_metrics), 50);
 	if (ret) {
 		smu_table_cache_fini(smu, SMU_TABLE_PMFW_SYSTEM_METRICS);
-		smu_table_cache_fini(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS);
+		smu_driver_table_fini(smu,
+				      SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS);
 		return ret;
 	}
-	cache = &(tables[SMU_TABLE_GPUBOARD_TEMP_METRICS].cache);
-	gpuboard_temp_metrics = (struct amdgpu_gpuboard_temp_metrics_v1_0 *)cache->buffer;
+	gpuboard_temp_metrics = (struct amdgpu_gpuboard_temp_metrics_v1_0 *)
+		smu_driver_table_ptr(smu,
+				     SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS);
 	smu_cmn_init_gpuboard_temp_metrics(gpuboard_temp_metrics, 1, 0);
 
 	return 0;
@@ -193,8 +193,8 @@ int smu_v13_0_12_tables_init(struct smu_context *smu)
 
 void smu_v13_0_12_tables_fini(struct smu_context *smu)
 {
-	smu_table_cache_fini(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS);
-	smu_table_cache_fini(smu, SMU_TABLE_GPUBOARD_TEMP_METRICS);
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS);
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS);
 	smu_table_cache_fini(smu, SMU_TABLE_PMFW_SYSTEM_METRICS);
 }
 
@@ -686,8 +686,8 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 	struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	enum smu_driver_table_id table_id;
 	SystemMetricsTable_t *metrics;
-	struct smu_table *data_table;
 	struct smu_table *sys_table;
 	int ret, sensor_type;
 	u32 idx, sensors;
@@ -695,18 +695,16 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 
 	if (type == SMU_TEMP_METRIC_BASEBOARD) {
 		/* Initialize base board temperature metrics */
-		data_table =
-			&smu->smu_table.tables[SMU_TABLE_BASEBOARD_TEMP_METRICS];
+		table_id = SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS;
 		baseboard_temp_metrics =
 			(struct amdgpu_baseboard_temp_metrics_v1_0 *)
-				data_table->cache.buffer;
+				smu_driver_table_ptr(smu, table_id);
 		size = sizeof(*baseboard_temp_metrics);
 	} else {
-		data_table =
-			&smu->smu_table.tables[SMU_TABLE_GPUBOARD_TEMP_METRICS];
+		table_id = SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS;
 		gpuboard_temp_metrics =
 			(struct amdgpu_gpuboard_temp_metrics_v1_0 *)
-				data_table->cache.buffer;
+				smu_driver_table_ptr(smu, table_id);
 		size = sizeof(*baseboard_temp_metrics);
 	}
 
@@ -716,7 +714,7 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 
 	sys_table = &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
 	metrics = (SystemMetricsTable_t *)sys_table->cache.buffer;
-	smu_table_cache_update_time(data_table, jiffies);
+	smu_driver_table_update_cache_time(smu, table_id);
 
 	if (type == SMU_TEMP_METRIC_GPUBOARD) {
 		gpuboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
@@ -762,7 +760,10 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 		}
 	}
 
-	memcpy(table, data_table->cache.buffer, size);
+	if (type == SMU_TEMP_METRIC_BASEBOARD)
+		memcpy(table, baseboard_temp_metrics, size);
+	else
+		memcpy(table, gpuboard_temp_metrics, size);
 
 	return size;
 }
-- 
2.49.0

