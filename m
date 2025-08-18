Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F56CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 07:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F1610E3DE;
	Mon, 18 Aug 2025 07:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="osNdVv+E";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5AA310E3D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 07:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lt9rIfighyvtMh2ENXE3r6l2vhKj+jP11lAplXuMSer0vMtH39eQ7V/hE1rq02/xYvel9G9QmzvTAtLersAIoaaJtXOMVUk+J3ZziFYY9M59eXLdCOrOttIQcUV+Ogs7aLH7ix/gYGSL5l3BcD2P4ghex1+opidh3l7JI7LAaTCj41FAZ23AK730OBYI3IT8AWUIUbVCfW3zRctShX+Vib4NkLcsUI2//bH/tBWUa/TOUMQVJkY7Jfg6IoaxdbLaYsZ7ir2Gk0GyiUHt1XBQFCR1qrCo8jVga1ouC/UpRcunjt/AUvYMeoqMcJXWbsh8ZkG2IgmyO9jlE5WQMC4m4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtTSgrG/dIsEG7genen0SBNKfcy22HQ4EvTROUN5D5k=;
 b=pYCEJsvBlO6y35wPI7VvU63ZNe2uSeQU7+X8GI7iuTmTEUlY3JUPNj0ym/+ecIO7DnJLkuwj3+5KfP/S7L7vst7HwOTggwoMGXJMsY4ttnzkXJoUZg+ZOK8J+CK3uwuTw2HLaqamttp1Yydj0sx2EI1e9w7xCR7KdaNkXcgGYWanfgZoPj++voywFlNFBxUSEtKosWmLSxG5CvPfYgc9QaGE5rGIJFETgXJDtuNyUzgVBHnEwMGsl6qx6PDCaGbDs78ApcmKeMTyzy65zDXnx/8gem86a+iB/5doC/mkH3WtQ7H2wY7SfuDR0pT0J1zfbgkavOHaqPsok8aY2v6nAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtTSgrG/dIsEG7genen0SBNKfcy22HQ4EvTROUN5D5k=;
 b=osNdVv+EtJr9Lw13ctuC10y82DMlIcLyKG9ygf7V6gI4oPpu3IsQekqnhm+/JnQhfLia/83UbH5euAPYzPcJH0PSOzavj3PeNYcG2pERrSli8Y5hL8grrS5UmQMIUONvOXE1OP+pNe2nYEX/KoeUlbIohKqa5XdQbydNBZtRZEQ=
Received: from BYAPR02CA0022.namprd02.prod.outlook.com (2603:10b6:a02:ee::35)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 07:36:12 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::d) by BYAPR02CA0022.outlook.office365.com
 (2603:10b6:a02:ee::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 07:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 07:36:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 02:36:06 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: Make use of __free for cleanup
Date: Mon, 18 Aug 2025 13:05:08 +0530
Message-ID: <20250818073550.2074766-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ba0c8e-8215-4ced-e834-08ddde29e767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VEI/0d7P2ItbHkg8iFR9a2lSUncJv/lAL0sYjYRdiifh+GmAB5sZJ2qgFHue?=
 =?us-ascii?Q?3dFcxI9WWUfGnlMl9+8CxEfSKG/uHtYMg2zmUmvuesOM8ZIEC3mweWV4tJtW?=
 =?us-ascii?Q?CvbQ/7TdRaZDSyo9b0jdkh2pvz7b/PLBhSVa5e71eVQWA5+FSePZMSTUIjs0?=
 =?us-ascii?Q?8a8uk8zO02OX6mfuYv48gFB2h/01vuCvVCd7bISnSN4lLUO8LrX/t3JYBqVg?=
 =?us-ascii?Q?IQU1WD5iQS2GaA5CCDSzry0zycKjJcKQKRq798GSX6YvAtCtve+idEWvK5Fz?=
 =?us-ascii?Q?kQQUw8NqOlR1DoV5Gz1lLX7nZCfwWSQLEm7f3LRlrZXMTTmCwqjN2UC7AoIS?=
 =?us-ascii?Q?7+iS93kHayowR4oKiKBb7qhIOjJiwJrfiORgoufnEr8kS28uxm9RFE5jMHvg?=
 =?us-ascii?Q?ayU77OIOhNUKA0mDv5X+DxzoxGei3juEYz4jXk+tLlXwikf14t/tXq3MIurR?=
 =?us-ascii?Q?u/5cfUlSTP6QSObYP5khST/vZyHGV4IdPA4gGiB9fgWZ1NfI1AfitG2DZbsR?=
 =?us-ascii?Q?mh4k/zmpgAXTyfni+Ue7JEVzU8ZZhSVW3ZuFXKJKkFzg0eDoIS6cIM28X2yc?=
 =?us-ascii?Q?Cn7gzVSRGTJeADRE6Xy32gEc7zlKiZND+LFOzpzdI6pl9EaqqBDcbyQwalNb?=
 =?us-ascii?Q?FGELCvEo/mCblQG5sO4GdYo+P1vQBiKjMY6nUV+Hux3KTbhS72ZaBmr6qn6w?=
 =?us-ascii?Q?6CZu0/RaS37xjGZwHiwBGpifqkM/UEKQ3ts4uHIb3K3eT9Ae/ACcoydE7Zpv?=
 =?us-ascii?Q?dirL6ZyiOhW3K+aZxZw752sHVO3k3IMIggU1bmpnAr0mCKCbKtJIdi/+fQN+?=
 =?us-ascii?Q?auL3tLWIjaH5vVdSNOaJGvwsMZakoSgGH9zZAOhUtXpbqJ6CAP048PAJkeoM?=
 =?us-ascii?Q?8qtft+9S/OrtYFrNyGZPlLT7rMHzHlplgndiu2OjgppaJzw7B+nFJPzCD6F9?=
 =?us-ascii?Q?KIRECtk7fv+rIO6hc/hJZ0cgNyeANpw7QxoSn8EGRRC4tlPfwUahaHriNz8+?=
 =?us-ascii?Q?Tvksh739d5v3478h8RiRmT4WElR247Ud7bWClkCXEt0WGh/cwLYV0HlH9od/?=
 =?us-ascii?Q?dNaHVng297Lza6AI3Jdn+xmfVCr2iWLe8QOp+eILxPGiEamtl87RAcoXvE3W?=
 =?us-ascii?Q?ACk5h6cE24vhWSUTL+Ok1S96EthulOWDw/aDAwUDkYM5aRryOiyVxYqH4jWW?=
 =?us-ascii?Q?LkjQhgzNfA2FCAxF4ZuuEKwRdF2Uoq+Fh7D+yUQ2/bF4tItmeS0TcY+h3MFF?=
 =?us-ascii?Q?eL4JwRgEr00IaKN6wHZLGOwRu81deF1GXvqDbA3c7zMIv9ZR9r47lbDDcTAL?=
 =?us-ascii?Q?fY0fZkIgkTjSvzkoQcgJawsVrU1CZodbqQ0vjSRieHP8/DaB8e7tUN3785wS?=
 =?us-ascii?Q?3JhKMAUnaxmxIgPQ4EJ9GEHV7p0a7N3asTBHNV3RpXsR9G+ZhRBwl06SkKwk?=
 =?us-ascii?Q?6ezAi4FC36dNiL/vBT5HEhQ1iZcKvjiQyaUtH/jMQ0YeAe5vp7xuyzv4qGPe?=
 =?us-ascii?Q?pWjlmqp0lG72kpqW3KVTmKVMX4+m95hh3gpD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:36:11.2515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ba0c8e-8215-4ced-e834-08ddde29e767
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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

Use __free(kfree) for memory alloc cleanups in SMUv13.0.6

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Use __free in metrics related functions also.

 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 63 ++++++++-----------
 1 file changed, 25 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 627a8188d868..b5d1b2427c3c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -535,6 +535,9 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	void *gpu_metrics_table __free(kfree) = NULL;
+	void *driver_pptable __free(kfree) = NULL;
+	void *metrics_table __free(kfree) = NULL;
 	struct amdgpu_device *adev = smu->adev;
 	int gpu_metrcs_size = METRICS_TABLE_SIZE;
 	int ret;
@@ -553,37 +556,32 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		       PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
-	smu_table->metrics_table = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
-	if (!smu_table->metrics_table)
+	metrics_table = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
+	if (!metrics_table)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
 	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_8);
-	smu_table->gpu_metrics_table =
+	gpu_metrics_table =
 		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!smu_table->gpu_metrics_table) {
-		kfree(smu_table->metrics_table);
+	if (!gpu_metrics_table)
 		return -ENOMEM;
-	}
 
-	smu_table->driver_pptable =
-		kzalloc(sizeof(struct PPTable_t), GFP_KERNEL);
-	if (!smu_table->driver_pptable) {
-		kfree(smu_table->metrics_table);
-		kfree(smu_table->gpu_metrics_table);
+	driver_pptable = kzalloc(sizeof(struct PPTable_t), GFP_KERNEL);
+	if (!driver_pptable)
 		return -ENOMEM;
-	}
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
 	    IP_VERSION(13, 0, 12)) {
 		ret = smu_v13_0_12_tables_init(smu);
-		if (ret) {
-			kfree(smu_table->metrics_table);
-			kfree(smu_table->gpu_metrics_table);
+		if (ret)
 			return ret;
-		}
 	}
 
+	smu_table->gpu_metrics_table = no_free_ptr(gpu_metrics_table);
+	smu_table->metrics_table = no_free_ptr(metrics_table);
+	smu_table->driver_pptable = no_free_ptr(driver_pptable);
+
 	return 0;
 }
 
@@ -2619,9 +2617,9 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 	const u8 num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS_4_0_3;
 	int version = smu_v13_0_6_get_metrics_version(smu);
 	struct amdgpu_partition_metrics_v1_0 *xcp_metrics;
+	MetricsTableV0_t *metrics_v0 __free(kfree) = NULL;
 	struct amdgpu_device *adev = smu->adev;
 	int ret, inst, i, j, k, idx;
-	MetricsTableV0_t *metrics_v0;
 	MetricsTableV1_t *metrics_v1;
 	MetricsTableV2_t *metrics_v2;
 	struct amdgpu_xcp *xcp;
@@ -2646,17 +2644,14 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 		return -ENOMEM;
 
 	ret = smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
-	if (ret) {
-		kfree(metrics_v0);
+	if (ret)
 		return ret;
-	}
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
 		    IP_VERSION(13, 0, 12) &&
-	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
-		ret = smu_v13_0_12_get_xcp_metrics(smu, xcp, table, metrics_v0);
-		goto out;
-	}
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+		return smu_v13_0_12_get_xcp_metrics(smu, xcp, table,
+						    metrics_v0);
 
 	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
 	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
@@ -2727,8 +2722,6 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 			idx++;
 		}
 	}
-out:
-	kfree(metrics_v0);
 
 	return sizeof(*xcp_metrics);
 }
@@ -2739,31 +2732,26 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	struct gpu_metrics_v1_8 *gpu_metrics =
 		(struct gpu_metrics_v1_8 *)smu_table->gpu_metrics_table;
 	int version = smu_v13_0_6_get_metrics_version(smu);
+	MetricsTableV0_t *metrics_v0 __free(kfree) = NULL;
 	int ret = 0, xcc_id, inst, i, j, k, idx;
 	struct amdgpu_device *adev = smu->adev;
-	MetricsTableV0_t *metrics_v0;
 	MetricsTableV1_t *metrics_v1;
 	MetricsTableV2_t *metrics_v2;
 	struct amdgpu_xcp *xcp;
 	u16 link_width_level;
-	ssize_t num_bytes;
 	u8 num_jpeg_rings;
 	u32 inst_mask;
 	bool per_inst;
 
 	metrics_v0 = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
 	ret = smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
-	if (ret) {
-		kfree(metrics_v0);
+	if (ret)
 		return ret;
-	}
 
-	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
-	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
-		num_bytes = smu_v13_0_12_get_gpu_metrics(smu, table, metrics_v0);
-		kfree(metrics_v0);
-		return num_bytes;
-	}
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
+		    IP_VERSION(13, 0, 12) &&
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+		return smu_v13_0_12_get_gpu_metrics(smu, table, metrics_v0);
 
 	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
 	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
@@ -2949,7 +2937,6 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, version);
 
 	*table = (void *)gpu_metrics;
-	kfree(metrics_v0);
 
 	return sizeof(*gpu_metrics);
 }
-- 
2.49.0

