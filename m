Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFB7C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 05:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A2710E140;
	Mon, 20 May 2024 05:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2N5ael40";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A458E10E140
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 05:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grovK3y+M5NfS+KlMVHG2iXR5RebexvW8uMG7UY9yKJZN7RLDhsfcV+hjb5aVh/TqM4BOQXwJwf7WTyPkpg3cB1njefcyLvW54VvNwnhA1XBlZXbVRFAKaYI86RUM0ihpO1ADZzaOvsTF5PdmZZkiN05o0b9yEwiZq9eGy+8wcagqh0dDh4HHxFf9AcMZCh0M5q+EFjkj6oCkrw3+PwgICvuTOI6mtWXGJrYxQc1E8+I+IHuLKh6/5iEHomPr+5n5rwP36QgBQOmuYaPkheLHzuJybPE3wcaT5t7ojFCTUmEbo6S1p2VMTfllOzWmaQlI1+SDIBnEWUyl+2MLRpfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZP9uwHrBu0YT4YCJlYNOIlPw/F/xBkP4KjS+bZ8kKo=;
 b=VCYxwqZnLplHxv//V+FKqvf6LmOBIyDb6RPqIGQbut7/aOahqtBdAwgcQNxLCkvBIeAwhSGRHUjDidJiI9f4BLouhXqK8Hw7e2erZ9TeA2ZbRcuUxXTWZ2KuPI2dGUyUwg6RuIsH5y/i6YJSy/LkkU7YpBdcBp+gbF/GSOwZXbNP7zXMpVai86dp7LQsROd2D9+hOhD0lcy62fUxo7TnkZJsx4sar5eGEGVp5BOfFHCNuz9wuDNqN1Y4U8fM6dobB8qoZ1pX/uUZG+GZMwhYFCaXT16SQiI5is+F8jMfndC9R8OX0DoW0pz1/x0ejTZg3dOcg3xBss5ZDal5cWwEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZP9uwHrBu0YT4YCJlYNOIlPw/F/xBkP4KjS+bZ8kKo=;
 b=2N5ael40ke1ucxrKaytHmURY/eEY6HVgLUFxrm0bm8O+LARYeBS7Qmuv8oFH/5RLTn+LuDlYQulqWTB5UKMKlTazHUEhe/foJO3O+81kdcxDOmY4uIvZv/O+38rMydGbQIX/gtHlZtIW4rply1M8WD7xmXyqxn6DX1naFc6ps/g=
Received: from DM6PR07CA0051.namprd07.prod.outlook.com (2603:10b6:5:74::28) by
 SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 05:01:35 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::62) by DM6PR07CA0051.outlook.office365.com
 (2603:10b6:5:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Mon, 20 May 2024 05:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 05:01:34 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 00:01:31 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>, <charis.poag@amd.com>,
 <Shuzhou.Liu@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd/pm: Use gpu_metrics_v1_6 for SMUv13.0.6"
Date: Mon, 20 May 2024 13:01:14 +0800
Message-ID: <20240520050115.19806-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d7ed5b-d3f0-4fb0-8e88-08dc7889ec25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ke14t/mztWG1Tfy9HF59oNXAcsW4p3/x5hqNAQXB55UD7ODqhgIULt/KJzLO?=
 =?us-ascii?Q?1y/aTPFC5lXkXE9DDBBoW305GyK9nteZT+aqn7DJJN2hw2HYPzj2E0MFL1Yo?=
 =?us-ascii?Q?wd2AjzgYM4bHBEmnj6jjTRBNhbzcezKkQBbMdkm0J8PWv4WR3ZiTGbqerBs/?=
 =?us-ascii?Q?Y5XTe0m9LKcZQSmsnKJOOqYwKsovPV7dbo49eqkXdgFysWpYkn7oTt+QjdLD?=
 =?us-ascii?Q?0fytD+I/I/Rv/M7SKc7zqwuJDsrUr0T4M4NxC2LF98hv35aLXAn97WbAgHck?=
 =?us-ascii?Q?gfJ2SXlizqWFHDtNWgLR9E3X2JZ/bxN++tuHR31Ed/uUI0dukt+zP8ZV7NOI?=
 =?us-ascii?Q?7bfB84B/2pWCFabt9S5Cu2OAARitVxlZx/tZ25891udg/WrtShnLEBR7by+w?=
 =?us-ascii?Q?43Of+q16RqQZqTaj5iTuc/ebHUj1zRT9g+iiPJr+Vf4xsTscWxeBS7tkgnss?=
 =?us-ascii?Q?pIc0iNjshHY8wZhFrKSm98nJKZD3YAVM6AfuaUWm8hb7K4DNi1in3fxzRfJh?=
 =?us-ascii?Q?QKhFzmypdT3/HprNn52qsJXqjtppO1YUH/uya1Wy87kHQgX4mKoAcQADcLvj?=
 =?us-ascii?Q?HLRkLOdHs5tdK51JV8Aefgii7DBVvScgHvAaypz70xjQhIf6oNRSWPlZbnYq?=
 =?us-ascii?Q?xvHNq56RNlDozkSwj/L7y4hzSSsDUliAEo5/E9rz9M5nV4TynxcfFAQ0gfkw?=
 =?us-ascii?Q?7rAO4oowqLL6MToNmssQQkv1JW6fyqwjmVE4AtV4XrJHcqDEeID/iH3yPxnn?=
 =?us-ascii?Q?ZLQfH1jpcu18YcBrbsAEbIDrr4pwf0DSEbd+3YcztcthX17G6RLa2EO0P9D+?=
 =?us-ascii?Q?B/Cw93Bj9luiqpsNSKumjBxSmN4oGXclgJMIUpg78nATiefQJwfUFZh0RhcZ?=
 =?us-ascii?Q?FGStQkYTvSAtU6XspszK+1g4CQjDF882c7aHz39KZ6eUNtwWdVFxzBKwConY?=
 =?us-ascii?Q?bsqLTFvYmDjCK49a/uzRDRIOfqi4AOXwU5wQepDRYWx4mQQtszRcgqnWKVN3?=
 =?us-ascii?Q?8G8/fKSHpTi5Rj0jCszkTAo56sFvoyqBtU/ZEFRnGnU9i1fibtRsOzCXRaHd?=
 =?us-ascii?Q?VP/juKf8XVkyw+M7vqE1CoNjNaJxyUVYb6qicx4uT/iYPLz4ciL1Yje+Z+/l?=
 =?us-ascii?Q?hiDhnzYEf0FQCu1UBvFRUvWj0ddUhgfhP8QZ9JPI+A+D8E00BhwaKtzsN/9L?=
 =?us-ascii?Q?02Yo0ORqChCVs+QJ9JxAPbBLyv716aS2cqhtaZsPGx7a9bJblxFe0JA6no8M?=
 =?us-ascii?Q?MXlUxiuaz8O/rdnXZyp/LSa6HzXYrXGINtwrSyU+DmwcbEcg9M+zKqj7gQU/?=
 =?us-ascii?Q?zmNFbJsx1OLYX11VEXZMPqAHinQN/GSAqDocsIUP2n/rGV8O2NNd5oQF47D3?=
 =?us-ascii?Q?4YRZ4eY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 05:01:34.6879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d7ed5b-d3f0-4fb0-8e88-08dc7889ec25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
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

Remove gpu_metrics_v1_6 usage for SMUv13.0.6 temporarily and use
gpu_metrics_v1_5 until tool support is ready for it.

This reverts commit e6efb71ae640eada28f44cc97aa79e8ae4901e63.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ceb2174baff6..81a241ed18f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -351,7 +351,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_6);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_5);
 	smu_table->gpu_metrics_table =
 		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
@@ -2290,8 +2290,8 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_6 *gpu_metrics =
-		(struct gpu_metrics_v1_6 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_5 *gpu_metrics =
+		(struct gpu_metrics_v1_5 *)smu_table->gpu_metrics_table;
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, xcc_id, inst, i, j;
 	MetricsTableX_t *metrics_x;
@@ -2307,7 +2307,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	metrics_a = (MetricsTableA_t *)metrics_x;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 6);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 5);
 
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature));
@@ -2349,16 +2349,6 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
 
-	/* Total accumulated cycle counter */
-	gpu_metrics->accumulation_counter = GET_METRIC_FIELD(AccumulationCounter);
-
-	/* Accumulated throttler residencies */
-	gpu_metrics->prochot_residency_acc = GET_METRIC_FIELD(ProchotResidencyAcc);
-	gpu_metrics->ppt_residency_acc = GET_METRIC_FIELD(PptResidencyAcc);
-	gpu_metrics->socket_thm_residency_acc = GET_METRIC_FIELD(SocketThmResidencyAcc);
-	gpu_metrics->vr_thm_residency_acc = GET_METRIC_FIELD(VrThmResidencyAcc);
-	gpu_metrics->hbm_thm_residency_acc = GET_METRIC_FIELD(HbmThmResidencyAcc);
-
 	/* Throttle status is not reported through metrics now */
 	gpu_metrics->throttle_status = 0;
 
-- 
2.42.0

