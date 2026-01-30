Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66114D49C9B
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 10:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9FA10E986;
	Fri, 30 Jan 2026 10:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aqXVHxD1";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1DA710E986
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 10:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4re9fkQznsXPBCB0se7fNs7GiJOno/mAs9tn/uxnsvTmdNXvau4W4L4BR6qIVsAjeqzXooOXX0vgqVgqVAWDKOfLBPQhodHOxybxDp17AT7XL9/xpIsRNQj0lq7SjtA7/jUEev0NQpg1otGUwlncccwpn8G8KIlJnRnVnGiRYQLdOi1guubUXGJSmz0CpBiqUM1dACfQUtRD3lWhIdhCCGMm8s3VlQ92aff8I31e2wRzrMTydDPjEVpi2qB7jA0Ge+XyKY2+wSbWN0lbTV4PuTqzxX2zD9BsbIAQhr9wb/0IOlm+ayFlypo5t7+tSJpGDi/LrXCdrJ+j+ThupRL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j87qZH4y3lZPKsM1Pkb3RhphUMl0t7ERPkr3ol36v7Y=;
 b=qlvLH9HiZ3d8Q0BkjVTptXMizqZJ45/bPdt7PoDKDOBxczHeILsSQgUj/NatvjMA2W27Rh4mZm7VT/iIisFIliXAFFIpn4C6W1VHCFNqbDVXfB2tTHAwDHUTRMl0XR5VJEjDh478oOqX4YYrbFOvsf3E0GAtcCdDXnFKz0T9RxVzVlmIG1uHfyv3WMC/fwWDoK+ZJXH81CDjTpOd86n6plZ8/mQ68Zk0zSCDgj8r0E3yA9AColBqcMNe8X9jMlWtcyJhw3S8Q+1t+ISVJxO5IscMeVld7S28y3XZWS8aZVQOJMhAoikmc+8/9MpToa1A0ueMp6psn5zNoj3vkrbvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j87qZH4y3lZPKsM1Pkb3RhphUMl0t7ERPkr3ol36v7Y=;
 b=aqXVHxD1JCd/KJ1Lp2S8X7+Y5C/G3v5b/LNJMmxCMOHCz7NUXc3bqKYuypV7QoA/QF4G5JBR4GJiBiFGFicPo8jlHWPcpsmn/lgOgA+O88+Y6nD9l8hjTlgbLSSrR8gR+L0O1i1FUTg5T+7qEpoedqlLpVNGfA6bP5P6TWXx1Tk=
Received: from MN2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:c0::25)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 10:38:49 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::7b) by MN2PR05CA0012.outlook.office365.com
 (2603:10b6:208:c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.5 via Frontend Transport; Fri,
 30 Jan 2026 10:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 10:38:48 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 04:38:47 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Remove buffer allocation in SMUv13.0.6
Date: Fri, 30 Jan 2026 16:08:25 +0530
Message-ID: <20260130103825.3099276-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca6c009-69e7-4c66-a473-08de5febc0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R57Ve0u6ucjVXf1FnJ+mcVUc6r5Y9Msd8N/vY6fz6UEC6SW3c5bbfZNJw4ma?=
 =?us-ascii?Q?mHuxRnvly8clUFKv7umhxGQSrfMMDtCBbibRcfSIyGdaiB1HgiVWFONq9ECJ?=
 =?us-ascii?Q?EPnc8Hk0ObGq+sAxPzH2viTZ7wHh630wXW9qofcznf6mhryX1uO1Ll6+2aJe?=
 =?us-ascii?Q?yM2e9MToN1ajivPxVh2SMfCSpnFxppzuBA+hu5nkVw3uBbdVuU4yB4lBTB5i?=
 =?us-ascii?Q?A070ilznIuPTvFpSY+3ZpTI6+9FWaI9Oy6HE6d+2rRsObtbKeU+yemY1zoaK?=
 =?us-ascii?Q?G5Qcca0tZssV31+/lpTqSuWJXStW4BQqEHQ7yGHDABmRq6GfAxlkicdYV9bn?=
 =?us-ascii?Q?4fx/HEnuCOkHhc/6v1Z+m1vBQ9fjr5s4ifKc2fmaRwTJQzrtFEwM4CZBw18T?=
 =?us-ascii?Q?0oF9Iv9Glhj6ylPzEc3w69bLe9BFzkhDRaE0z94zDzmmYz5J1EtEA4OQy+zm?=
 =?us-ascii?Q?OgHMPhcDfGzeA0KgZC6VgKOTXGrJSiq3fPOJSf+btCMyqTqJVXUUKZ4OxiXg?=
 =?us-ascii?Q?RujIF2DZEJr/032c/N7q/7e1idgkx4LOe5de7COgQQSuFyVWPoj8IwQI3wCZ?=
 =?us-ascii?Q?aTG12FUuir1GPpAwbuouRJIu0kC3XJnlk/396752vEPM287PYNCW+Z734GjT?=
 =?us-ascii?Q?ZSxNcVzg22Q9esOOwQaQox8p8j5YUbuvu52H11XYQXPXNowS8KpsjQ2nVzDa?=
 =?us-ascii?Q?O05d4fktDc718tdWqACVhXBqS9YgT7aDfpPd+Xp0CYjo5GlF67sg11O+IQjk?=
 =?us-ascii?Q?UTp1w8YyWvAUOCkwWB8GqrsmYJg9rUIAcHFYjkv6WBZPvkQ871fOTqFXcjy5?=
 =?us-ascii?Q?Sdag63CMN9h1fvZUvbHZ1Q6CaXYZp/orVAIMsAMJzh863YmUm9y5ZT3glPpX?=
 =?us-ascii?Q?YefXtRQIOGsXm/t9v+NpzQPIDp8Hq0ijnn4yyHaTZQQELWHENefOBjE04/f3?=
 =?us-ascii?Q?M8/F7vM6iufLcohr+Z0Wh4B2g/dgLX7ravttO7Wy7IjWghGsxJYyPJdoyPr2?=
 =?us-ascii?Q?F5PbfaUfDz9mu0i/Ro6d8POJnQgGZ4dNzHEf4UmvHrqVnUbzB540PgzUqBHH?=
 =?us-ascii?Q?qxt0r/3QZtzuNPmJ3qd5xcxBXnnSogPOevFhJH7MBPou9+7Unu5juqILkCoh?=
 =?us-ascii?Q?DWL+Gv4AreLCF2NbM5+Twzs430JRuQK4HnfMNceWFEtLr8Mu52HY+ITJHurk?=
 =?us-ascii?Q?gSFke2tsLIuYU1qwy0apjuL0lxNiGCvGsF9M3yeou4abRpSiDrrVe22yDixC?=
 =?us-ascii?Q?NNtzI4mWvxOAF6M7Su/XkvmYVmnok4DPHF0DOBUv+Z3tIzVrxXxu2PtJr61o?=
 =?us-ascii?Q?CmqYd2mNaosnwEyU0snVSTqeMBHqoM2eL2Gp6Td6zZX29dL51rnoeCC7enTh?=
 =?us-ascii?Q?O3cOQOXridop/FYwGm5oDF9WwwcRJQyiOAjS+4fW0YHZSFHnS/aYXf2hRLRQ?=
 =?us-ascii?Q?iDKVYo+0lMQQ5p4P436dGKwU2lFEzGGessODzJr+aVD4muvIsEhhzUnW7mBW?=
 =?us-ascii?Q?myLV47lKmQab0vjBhirVd1SrXZQKi8mQ8+z5VjHLfBNpdckiN4Y/8sMoa35i?=
 =?us-ascii?Q?MjeQiBJNZriKLbzkcXeKUYyAx3J+OnkrOlxXAnrYsDkZMRFP/O0akre1cQuA?=
 =?us-ascii?Q?MuofqqW+TidhNPYPmt7TF/f6O+lr9j5fyKaSLL0D/DDmiAKhtOclQ7JxG++/?=
 =?us-ascii?Q?arZJTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AL4LrPv0Z9hhlRwS7HJS6RrVuJ3dnbtiYef0ZMrbFa10hXTADjrDJwLxT2rlYfdscNJNH4MkVaf1u3qhalRknvplGygPvqjYuC0pRi66FhyWLkVDy/r6JZyynr6cjHaiOQZgYr86K3BQ0BvAKaAr0xB7A+LjJ1MTUHzh4Q/aNEEHs+gW1/Qa924M50po65eZaDe57fv7L/rY1IoUq0nYoS8gdURLPl4mwGIXNrjO1I+H14KNf1kB/ymKTvlEjubQnth6k5vyg+DSunRel5Q11Gy2k/KEDsMoqxMyfFOVXXwa9NQJ4UM22QLNkthLKFUAHBDipB0peBcRnSVsdZ2S3Si4yEU1g7IPfFcdqh9C4CvZo0511eUAYSkQokeNVb34hlSYGcsZqE/aGItvlKaOJlIGzK6yS+28VeSANm6nBBAAyhysLiUUN2KsS8xRgz/j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 10:38:48.9990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca6c009-69e7-4c66-a473-08de5febc0d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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

No longer required to allocate temporary buffer while fetching metrcis,
instead, use metrics table cache data directly.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1e82c43c851a..379f3c80cadb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2563,9 +2563,10 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 	const u8 num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS_4_0_3;
 	int version = smu_v13_0_6_get_metrics_version(smu);
 	struct smu_v13_0_6_partition_metrics *xcp_metrics;
-	MetricsTableV0_t *metrics_v0 __free(kfree) = NULL;
+	struct smu_table_context *smu_table = &smu->smu_table;
 	struct amdgpu_device *adev = smu->adev;
 	int ret, inst, i, j, k, idx;
+	MetricsTableV0_t *metrics_v0;
 	MetricsTableV1_t *metrics_v1;
 	MetricsTableV2_t *metrics_v2;
 	struct amdgpu_xcp *xcp;
@@ -2585,22 +2586,20 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 	xcp_metrics = (struct smu_v13_0_6_partition_metrics *)table;
 	smu_v13_0_6_partition_metrics_init(xcp_metrics, 1, 1);
 
-	metrics_v0 = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
-	if (!metrics_v0)
-		return -ENOMEM;
-
-	ret = smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
+	ret = smu_v13_0_6_get_metrics_table(smu, NULL, false);
 	if (ret)
 		return ret;
 
+	metrics_v0 = (MetricsTableV0_t *)smu_table->metrics_table;
+
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
 		    IP_VERSION(13, 0, 12) &&
 	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
 		return smu_v13_0_12_get_xcp_metrics(smu, xcp, table,
 						    metrics_v0);
 
-	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
-	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
+	metrics_v1 = (MetricsTableV1_t *)smu_table->metrics_table;
+	metrics_v2 = (MetricsTableV2_t *)smu_table->metrics_table;
 
 	per_inst = smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METRICS));
 
@@ -2676,21 +2675,21 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 {
 	struct smu_v13_0_6_gpu_metrics *gpu_metrics;
 	int version = smu_v13_0_6_get_metrics_version(smu);
-	MetricsTableV0_t *metrics_v0 __free(kfree) = NULL;
+	struct smu_table_context *smu_table = &smu->smu_table;
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, xcc_id, inst, i, j;
+	MetricsTableV0_t *metrics_v0;
 	MetricsTableV1_t *metrics_v1;
 	MetricsTableV2_t *metrics_v2;
 	u16 link_width_level;
 	u8 num_jpeg_rings;
 	bool per_inst;
 
-	metrics_v0 = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
-	ret = smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
+	ret = smu_v13_0_6_get_metrics_table(smu, NULL, false);
 	if (ret)
 		return ret;
 
-	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
+	metrics_v0 = (MetricsTableV0_t *)smu_table->metrics_table;
 	gpu_metrics = (struct smu_v13_0_6_gpu_metrics *)smu_driver_table_ptr(
 		smu, SMU_DRIVER_TABLE_GPU_METRICS);
 
@@ -2701,8 +2700,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		goto fill;
 	}
 
-	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
-	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
+	metrics_v1 = (MetricsTableV1_t *)smu_table->metrics_table;
+	metrics_v2 = (MetricsTableV2_t *)smu_table->metrics_table;
 
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version));
-- 
2.49.0

