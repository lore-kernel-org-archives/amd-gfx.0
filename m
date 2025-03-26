Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64E3C3600E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 08:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B2210E666;
	Wed, 26 Mar 2025 08:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bIy9Senc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09DD210E65F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 08:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifQ2z9lcSKZB8aIfo+1aRxqGK1lsQiHxDnK/JHkcMHj+xf4U6WsDrwgPOfD7ss9okjVV5tcsP6kyGG3f9fgITW0xwqylrdhb+EJLkK7nNhkoBEgi5VlxTBNAoaL/dFHSWg6Ske1t4XYiBHGJX1P5t1OpD8qre4IlQQFjjymZcq7LffHGozj+GKy309+noMeOFSUrrAKMdNrgtm2IOowYdfzbZsTWmhcfNAKmzPXWrStTVfBaxs5IwUoaM7u9UE5tcIn94J0C+T3e5DkLB84vPQxAkNfwK53/LTh5lf/CsRiCGVAsukrLJHhK4T+enXW+6nPAWMFw0ifs0GTlIHLekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTS7PASmGKmRq4jQyPYMkvlGT6UmuISY/JQ6IhjB820=;
 b=HND3s0B2t5k+iowFQpDnd/tx4r3GmTphA+JULFp2qEsm1lYTKLmi9JFIVRNJ+X6UlLlodLxTi867S3d4GNE/aTTw7RinmHvkyAIibZ76TjQbXxh15QhAlLedFpRtJkHYzglhHlZCeA/P+lzCny8RKs3hNTdrkD/SLaWHDH35y3oysy93a9cLtqK2GZKJszvqF81+c5Pzl7VLoiXH32p1m3QCOk2dcHQystoF7IBlryxWEYDkDAxPEp77djOZrrlS6nXAOBe/D66NsjPo0Dc/iCHIJO7W2XgZdCUH4A3VCj6OiHf1r46R8AeB2M7nQbEnS71xCdQKfZygn0XiGEr+FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTS7PASmGKmRq4jQyPYMkvlGT6UmuISY/JQ6IhjB820=;
 b=bIy9Senc7rbw8upA3kI90xlMYHHiPUWUiTLnAfm5ZcqcqvMSACDqcqXVu1NhfakeIET5sqqp9EQ4PUalHlxA8ANf4Q4EVO8Vo/1GVlf2Jb6XztS7mpVW9jeCQC3TQ63dPRhBgnpO39l7RGTN7TMfL4wFgSfMsEv/CNivSzi3PXE=
Received: from DM6PR18CA0024.namprd18.prod.outlook.com (2603:10b6:5:15b::37)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 08:14:27 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::2c) by DM6PR18CA0024.outlook.office365.com
 (2603:10b6:5:15b::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 08:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 08:14:27 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 03:14:24 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amd/pm: Use gpu_metrics_v1_8 for smu_v13_0_12
Date: Wed, 26 Mar 2025 16:14:00 +0800
Message-ID: <20250326081400.1305136-6-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250326081400.1305136-1-asad.kamal@amd.com>
References: <20250326081400.1305136-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: c32c5657-c8fd-4345-4479-08dd6c3e3a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S/enlu5o3VNuonfNEF2b1pM0n+JuuUNOJdKSK5sWGcoANAYdSwT77ofnfSXy?=
 =?us-ascii?Q?odsbLZKXvIcIqRkp7hIJhWeN2qU0rvq+mewXJmpZhVZ1PZh+sHdoPrWGvsIy?=
 =?us-ascii?Q?WUb0im9c+vVMZs700ImIz+sByD6OiSMk0r8jtlVnByYeN2BRe2YwvfJ3Z0q6?=
 =?us-ascii?Q?cX0CLrmY2rwRM9PjHP2rn4q1MBHhUY1SjRiUQq9I/6g++idrIjPa4zIxv7he?=
 =?us-ascii?Q?3FhYgH39jSspMJEHJaLe4NGr6jTotBnHQDXmnMRN12b/gJiWlB2AwKTyQ7j2?=
 =?us-ascii?Q?YUK6JKQawo59JgZkYpzTAC+qKuWCsZFfnH9ksbKd9x8xq54ra4XfrsU0YO5D?=
 =?us-ascii?Q?BkoEhXMkVRQyLxXe+KxllYe5p9mpnBL5MApxTaSoWbzSVKuW2YNDpA9boorJ?=
 =?us-ascii?Q?2trZ88GdmTyy9kAU3evEoGiI01GRAISFd/YgoqK11lAqR5gTddxqw6k9HX5Z?=
 =?us-ascii?Q?8H0c/1bv7THVuA51hUFOcy5Y6t3LVQOtrHoKOeFHEKfAzCoHEnfZrHdq9Pn8?=
 =?us-ascii?Q?yh3gAIYUeePolfBr5cpbSTbtuf3DFEme2S7QbG295/GiJ3bvU0nnRcfQqAUq?=
 =?us-ascii?Q?x5VqvAb+vxiYxvaklKjMbLhp/qU2tfy4Z9gM8IQrMpx0g2eRb5waF1PjlmSR?=
 =?us-ascii?Q?Ad/8VWM3HoJhDCZ69n6zT3D/FqYF9FxsTbqIExhb5y7C9NplnK6fC628TyRR?=
 =?us-ascii?Q?6q+kMTDsvsnRCG7no+8LuVwDcK+Um6jyRml8SIHs2YfdS2dj2zmM2wjn1ZX9?=
 =?us-ascii?Q?sQ34MdGXHCsnFzX5OxmrHAaBrKBgQprCI5yRMOsGU0ZtUL/QEciMPgZ4oS3C?=
 =?us-ascii?Q?6f8ejvFHSJjwS9sC0z3QwYZf0OMB4aLTxYQdQJ34YedFGl1jM2diWHnHq7fc?=
 =?us-ascii?Q?0/e3Q1LKzZrZCQzDf4qalD1ZRRb8GgO4vNPFb/6YYOIsCw4WTzxXu4wViRjv?=
 =?us-ascii?Q?gocBK7z347WzOyvn32tzVh0JN3BFLER4GGxWyiktHgz4XEYhit73l9gUvSc6?=
 =?us-ascii?Q?OpMbiHvNHJEIimfsbeI7IWRjRUEjEQXodrDzssRrd7eVQQA1yKkWvGX1JotU?=
 =?us-ascii?Q?kptyYvlL87/Qtzzx1zhamOos4SXxx96NcmZwVt6JuELyM+FWeirKZ7c+KIpa?=
 =?us-ascii?Q?IehtrK14ZES8OBKFn4uZdmgUEl3DH/l/rEKMTvppNbwVcCZTn+whyj1ml5vW?=
 =?us-ascii?Q?DXugcshvCaf4h7ECrsNDETZdrmfsRdi9PpTTUVjV86XPZ/2aAHE1shtkgZOs?=
 =?us-ascii?Q?CIdScV6enxrsSh6f01p6We5kulugWpNAIraHAM/dd84nt9zIo1Yyy74G26WD?=
 =?us-ascii?Q?Ow2Vpxjs2q+By44HI9XUyho7LXp6CgBaNSL8po1Zi6n0U9HgKfYVJDmo4lcB?=
 =?us-ascii?Q?jhJMi2/iOLmfwsPRBUBAVpEEdzi950Nr5hClqTv0Zf23ynfmzIVf1uR2btDo?=
 =?us-ascii?Q?63DI2fpm1KOh3vTFxcEEFVVtaQF0ofwaKZvFZ36taR08tEGe1Xddz1yWloJR?=
 =?us-ascii?Q?apoxFQdZbAu+L9g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:14:27.2111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32c5657-c8fd-4345-4479-08dd6c3e3a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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

Use gpu_metrics_v1_8 for smu_v13_0_12 to fill metrics data

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c    | 16 +++++++++++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c |  1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 238bd71baa6d..5d4437e413cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -345,8 +345,8 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_7 *gpu_metrics =
-		(struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_8 *gpu_metrics =
+		(struct gpu_metrics_v1_8 *)smu_table->gpu_metrics_table;
 	int ret = 0, xcc_id, inst, i, j, k, idx;
 	struct amdgpu_device *adev = smu->adev;
 	u8 num_jpeg_rings_gpu_metrics;
@@ -357,7 +357,7 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
 	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
 	memcpy(metrics, smu_table->metrics_table, sizeof(MetricsTable_t));
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 7);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 8);
 
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(metrics->MaxSocketTemperature);
@@ -474,6 +474,16 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
 				SMUQ10_ROUND(metrics->GfxBusy[inst]);
 			gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
 				SMUQ10_ROUND(metrics->GfxBusyAcc[inst]);
+			if (smu_v13_0_6_cap_supported(smu, SMU_CAP(HST_LIMIT_METRICS))) {
+				gpu_metrics->xcp_stats[i].gfx_below_host_limit_ppt_acc[idx] =
+					SMUQ10_ROUND(metrics->GfxclkBelowHostLimitPptAcc[inst]);
+				gpu_metrics->xcp_stats[i].gfx_below_host_limit_thm_acc[idx] =
+					SMUQ10_ROUND(metrics->GfxclkBelowHostLimitThmAcc[inst]);
+				gpu_metrics->xcp_stats[i].gfx_low_utilization_acc[idx] =
+					SMUQ10_ROUND(metrics->GfxclkLowUtilizationAcc[inst]);
+				gpu_metrics->xcp_stats[i].gfx_below_host_limit_total_acc[idx] =
+					SMUQ10_ROUND(metrics->GfxclkBelowHostLimitTotalAcc[inst]);
+			}
 			idx++;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 4f767948b172..8900c94bda0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -335,6 +335,7 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 
 	if (fw_ver >= 0x00561E00)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
+
 }
 
 static void smu_v13_0_6_init_caps(struct smu_context *smu)
-- 
2.46.0

