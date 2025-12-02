Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B94D11701
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 11:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A3710E183;
	Tue,  2 Dec 2025 11:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vk4avtVs";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012066.outbound.protection.outlook.com
 [40.107.200.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB7B10E624
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 11:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgAAgJ1Ha5o20yv10Nv4KCNYCxFaSs2tc8wK7yIwxx3aRPewlfaM111PsDYT2opkUtezV4a7zDNKL4LvsB01hbutM/NKZms/8geLO+IfXCVu4RT6cf24GZZU+s5ed22nIzcmSIqt3hi/inz/RikHQ4AKD+nymSMUp/LomPOn2jaW+jLmj//1blxSSaYXC9f06bMnABajPjg/pe9kcR0NRUX3PzUBNpMvBF05ZdVbWkAju//VWCi978F76iga4fntozfJouKHhlTfgDibbHWWbKJemLhzTuxmLu+tKErBm4A0DU7At1CFcgsvTYD5s821yVSD7OQMUtrtkzh+pKI4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkomyblrzS6ZhD4Lyk27mguLFOnISevO9zX7+FLqy0I=;
 b=dCfSWeYZnTCU7AEByLu1J0LRPIiwBHuRitR7JYit00h2xPrhBWn2l+91HgzNGcsoidMBprNnOfNV8LOR9QsYl6LtMIjpjVvPdcg9zVw1itAs0IR3oqBSYLREhgmk/VJAx219gouUJLiyuA4XfDcJkg4IeKeYCJWN1I/JoasNF1C5YkAA1+N+ECSLpTxMHqElzCpclP0MIA04hOJjQFDEiEXmXPbVX8BW1M6M8ys8ba5AY8F2zmJnmlRCgN9qNEYPCM96zkIU9rdH+oxN5TkZiLwwnJ5D5rNQkCiq/yT/fPh3lOVwfXNtJSYxLKS1T3/8YLwpaAa6veYUvqJrQJAimA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkomyblrzS6ZhD4Lyk27mguLFOnISevO9zX7+FLqy0I=;
 b=vk4avtVsaih3Nwa1bj1/XfG48v2GSR2k17s2rfWLjAPiHVRo7zYji+vIoip47sjuENDLldjujd/2kVii12t6TE+HPDJfqZ5mqQ89aHNwAPLJscZ8GUOjv+QiLAzcHASKzGpWR62dJTyqRNQ7JJxY6OKvveh0hJ68KH7WjkjrJpM=
Received: from BYAPR21CA0006.namprd21.prod.outlook.com (2603:10b6:a03:114::16)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 11:44:29 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:114:cafe::d2) by BYAPR21CA0006.outlook.office365.com
 (2603:10b6:a03:114::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.0 via Frontend Transport; Tue, 2
 Dec 2025 11:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Tue, 2 Dec 2025 11:44:28 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 05:44:26 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 3/7] drm/amd/pm: Use driver table structure in smuv12
Date: Tue, 2 Dec 2025 17:09:10 +0530
Message-ID: <20251202114358.512048-4-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e1cac0-60e5-4e3c-9993-08de3198268e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mUDjf93KIVVMmfsW0yp06e69HMGRE+JAZt0WkOR+dSC10pvxEj11AEb5ZS4/?=
 =?us-ascii?Q?aHLRpeG/OJo36TZcFZjZu1YF/o0hIuw5wRCWg1TGJ8ZjzOq3NZnH+0YS9JtP?=
 =?us-ascii?Q?ku6rn3bPelgTBgjpTdZxd5NMEeYCMcv+kS0TyBEsU31YhYIyLaheFNsIPr5R?=
 =?us-ascii?Q?xSkWiVWYi0j6CJmemWZ3m6xeXqNQukYhkQHf3k/XD+JjUC1fU+2pVhdxq+Rx?=
 =?us-ascii?Q?70g8HewkR3y9BpCkZavsgqnRsNx5c/ZT0mibE3PQGudqQBY49CDw9f0AtFWR?=
 =?us-ascii?Q?PF+IxdsD/CPLGskSYn19KQnWxIgp2EVFJQXb9LQ9Q+sKMlox2MEqPt0zdma+?=
 =?us-ascii?Q?qfr3OdwwJDogwgAlZMQKE45yPqcEX5WMJLocerajZ5RD71gzdbfKmV1dIC9J?=
 =?us-ascii?Q?SEDcGtZcndz9ImW1yzWUas2hIrScm0BWkdW3SM/qrIGhHtDbzhWbdzVTop0w?=
 =?us-ascii?Q?+mf5CVpYp1r+A5xVj2LOU+tLhEi5gRCEwNo2l3C9Mbow9d6lQpV8YdiJiZbO?=
 =?us-ascii?Q?ujG3OQcOcn8a5XMplU7cUYHaQX9n+4C3wJN5dEghnN6JYSkcPjk4q0GhIXRH?=
 =?us-ascii?Q?Qvxynu06RlhCwXD9LpeqtKLWRVnZ0R9A+qFd+koSTKzeqDBLfsoRJNy8FzXN?=
 =?us-ascii?Q?OF8DhApv3Ynhrs2ohbVcRGlGXGUI/hHiLaPsIyWwIJQRwef0fVxwkDDAjB/B?=
 =?us-ascii?Q?dj7NOgZ+W5HRRsGdZV6jFD0/Py7yVvuDgmsSyTltlFG9EyKyIjol/El0cfJY?=
 =?us-ascii?Q?3GAkVb4fdjmqsnwfoeWccgdltFvF203sqLZ8+pSQYC5io5jULb4gRobDay5d?=
 =?us-ascii?Q?pUQZ2tTJCuL1YBQFEJ9a8ClL/5fO76R9dgNNTYFPQRH7iN1JtBp6fD6A/P6v?=
 =?us-ascii?Q?CkafVaKH7fBoYHF5RJw0qHvT1b6czpt2AlC2OovSLv6GkdMDZdVwaLFwlI3c?=
 =?us-ascii?Q?yVyj+viwp9cOAb1WcQMk97YlpQosyxoIAUcmgjUWC0+uRYbLWnVgH4833GQ5?=
 =?us-ascii?Q?oRqyHvUmi4WeWhJXmgMgrOXVGaTuu6PGQ3YBT0iKcvRXQDV6gNmyQtSwa/Io?=
 =?us-ascii?Q?t+tIbhyhVwuPXFutXJIiOFfAYcu17T8iX9zLF6MypScDvYsS0/fgD7Wb1u6g?=
 =?us-ascii?Q?DaqLMw0WyIMcxBIBE9fBrFOOcfRpKQleJlJStuGoC4V3ao7YQsiSs5CkKz+p?=
 =?us-ascii?Q?oJBtoCRxAWkS4bCaeL+wWzsdl0isTa11qAYAvrN+d/b10nq9SzTd9IZCqfAb?=
 =?us-ascii?Q?ldjJKTcALvy97iE2uvk5kT6oQPMjR/bnBBJqt8Bpry3Sp2mK1s+7WYWSpgxH?=
 =?us-ascii?Q?HSwP0juuYP7NyxHlSCubqq/iBUWz2EdNtHCJ3ACrjufiC452PIxtxyjV+OAu?=
 =?us-ascii?Q?ytwF3FxMuPR8Vd9ZGeZdLg03BmGL456MZ6Y3+WGzBU1DdWUqhCjNcaa8mMg6?=
 =?us-ascii?Q?pf9RCis6eS2ge62rtmANExLn48lmuVVUoDrz93xBupUWRmqFnOVtZkN0wlAK?=
 =?us-ascii?Q?NYCLvOR4cieBVRCxH8PVU571u6pDtN0/R/lE5ViDVLlrsBmnoLzUQkA3mwct?=
 =?us-ascii?Q?qRbqLkk8HDVm6WcDwYE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 11:44:28.3754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e1cac0-60e5-4e3c-9993-08de3198268e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
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

Use driver table structure for gpu metrics in smuv12. The default cache
interval is set at 5ms.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 14 +++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c  |  3 +--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index eaa9ea162f16..d3bd752af10b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -157,6 +157,7 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int ret;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -178,9 +179,10 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
-	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table)
+	ret = smu_driver_table_init(smu, SMU_DRIVER_TABLE_GPU_METRICS,
+				    sizeof(struct gpu_metrics_v2_2),
+				    SMU_GPU_METRICS_CACHE_INTERVAL);
+	if (ret)
 		goto err3_out;
 
 	return 0;
@@ -1371,9 +1373,9 @@ static bool renoir_is_dpm_running(struct smu_context *smu)
 static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v2_2 *gpu_metrics =
-		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
+		(struct gpu_metrics_v2_2 *)smu_driver_table_ptr(
+			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1429,6 +1431,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
+	smu_driver_table_update_cache_time(smu, SMU_DRIVER_TABLE_GPU_METRICS);
+
 	return sizeof(struct gpu_metrics_v2_2);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 3d3cd546f0ad..942bc3b0f700 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -192,8 +192,7 @@ int smu_v12_0_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->watermarks_table);
 	smu_table->watermarks_table = NULL;
 
-	kfree(smu_table->gpu_metrics_table);
-	smu_table->gpu_metrics_table = NULL;
+	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
 
 	return 0;
 }
-- 
2.49.0

