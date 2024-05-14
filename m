Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19361C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 06:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E20710E1B6;
	Tue, 14 May 2024 06:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4kD7fgzv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D73510E1B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRT2J4y/jDkPLGGIe3mddSUX8xb3MI9DDUwNIlX70PYeVCVgV/khRxxJMnMle1pNJVqJTlXV11iVBO2E2LlfoZ/h/VOOvz17QU1sg5O2D8Q7zvUtHolQ+THMy9fhMxMBOF0H1xv4nNvUM4ZxkfuGViGjjzR9vtzOFCKV8wVZLu6GFLbqeeg8PVquSO1y/A7qKJF7bPZ3IH13955Az+pl7O4qKziNbzEdW11DCrqWctFWaSz/P1Trxa/T8JD1hJMCkB8Rk5cnU72blV+eCRo0sntpzg43B5kfIhMxMeh0OxgUBCERnVHgK3UnCwXHC3+fs0FcsN4Vn3AGACNGtC5RJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU45DLH1Cs9h4LfCl+ltAIanikUo580ILhPenBImrQA=;
 b=Q5aI2FQoLby7lV8KVeZkKtZP5ttHD5dd/bGqiyFaFZ3JVjhNNWrvvY2dGgPPzhOA/7mbphpeXL0zfz0T8NW8YwcQ+Pi3cMScfkJeclXvdN2QRUL1YXVnsD/6FCj1eLqRQ/hjJiTUM2+vTIpMYUEy0otct99fFUn3Bgaeggv2191NaV0dkRq6sn0M1dQcejkUIgew39K6wvfsq2Kr0vyjZnzuNv1+v9N5L1X0p0rsecMWP0r4ae4eGzCn65ZkwsKIt7lSz6qNA3miw8SsE/n09kSUeh0mnSv+/IS5DGMvuY0y0lHsi7H28BsXtxxMykIXNYpw7bPxZfO41l5zRag67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU45DLH1Cs9h4LfCl+ltAIanikUo580ILhPenBImrQA=;
 b=4kD7fgzvY8vl7NMG/xR2BTqxCJoU/xrA51wbnv7G+OkBfj5Lrg2+ZJz8EkofcI+njswya+u/S+X5njSnbowXHpwbWkrKyCvMTzEtrWM7DRhQtOPDPawFXq9rSParnuhgsL989mEaFAB58gavkdij1XnfIdvEcilDCPdjWCYGK+E=
Received: from BN8PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:d4::36)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Tue, 14 May
 2024 06:23:23 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::b9) by BN8PR04CA0062.outlook.office365.com
 (2603:10b6:408:d4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 06:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 06:23:20 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 01:23:17 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>, <charis.poag@amd.com>,
 <Shuzhou.Liu@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Use gpu_metrics_v1_6 for SMUv13.0.6
Date: Tue, 14 May 2024 14:22:55 +0800
Message-ID: <20240514062255.648187-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240514062255.648187-1-asad.kamal@amd.com>
References: <20240514062255.648187-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b53476d-cefe-46bb-bdcd-08dc73de59fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nZjeuoR1ZRk5ntohmXrcTGy3qxZQnIhEjwnek4ecm++H+C4ZjwyUpxY/uy1G?=
 =?us-ascii?Q?ufa4kuXVGaqhDulPacjd6tmbeDzmjcHQsXGTWr/7Ms/eRzakEN6m4xTK7wey?=
 =?us-ascii?Q?eGVDn5BR76MeoPxroSQ6ZKTIr+QDKFT4WLzr7+f6S8VAZMdb4U9CBS+AI8d9?=
 =?us-ascii?Q?eMPoqwlsPzczw0CbQzuuaD5K7rjDRG2dKpa93lb94Z1ko2ClqvC9CXmB31el?=
 =?us-ascii?Q?wvVnM3eYhT0rVdpbtSNxS8xbjpTyDlwNNI9qXf1AYNEOILD7vr6uUwDjLvW5?=
 =?us-ascii?Q?gCxo7rfKiS5Qg3Cc/RF4NCox+SomJKgbIKlGJxzaORlIVCnpUuZ69PkNXVjo?=
 =?us-ascii?Q?/4K1FQGD4RZKTRgFpNok62HzznoE8yopVNHH4QbrXATFdjR/70OPcFl+x+SB?=
 =?us-ascii?Q?4oLkKY9jKVedZfWPIfwhPEk6SLlogTagetOcCOSQM+QZ8V0VqTVwRTv4gn1o?=
 =?us-ascii?Q?cBnpOw8Eh/JrjTkrdF010oMrTzVY+fqcv57vii2EqToxc9ezMped+6Wnnh08?=
 =?us-ascii?Q?8VNFsGH7TnFTuUokGPcPLF433W/naabBUZdoksN/Zs7UlXC4kkyECC8PVInm?=
 =?us-ascii?Q?dJr89gUAajAWc/m2JRi/pUFvn68mPGJ472PajpfhypsUN78HK5F6+VOJddFM?=
 =?us-ascii?Q?jfprJQDyQ2AemN1FVIcONEgLfT5v7SgQkbxpIyI5alyCmoCi3/ctHWZmXQOf?=
 =?us-ascii?Q?JoAr+PdFYH9ZX8DPAgPd6WODRQytkGxkXGHLpMALVTIjRHMpNCgSsjhJIefJ?=
 =?us-ascii?Q?APV8vEbpgG8qLmKouThhXyPnP0r2CV+kzlvZhpEuG5gLGllYWb8VJK6MFeCs?=
 =?us-ascii?Q?PzrciCtAc8g0LewRO9YHtERNjqxYUuw6RdSHoNB9k8kznPS6Fxg8zhQbCtsZ?=
 =?us-ascii?Q?OAXWTSYb1QrS0PI6ebwVOH7voB5rMdX5AMxzqXtmE/75oirROATAEMf4jW1N?=
 =?us-ascii?Q?hjP2OZt8K/LQ6DYDyBwT4cqXzUMB+jR8T/ssyvm6qpp1beGS21bcdSxOjb0Y?=
 =?us-ascii?Q?AAcAJFebbuobriHwzlZlFFHDGdo8wyTxXFXRw2Bgwy52mzL64b9b8CBfATjC?=
 =?us-ascii?Q?bnBg/47stFStmkD7FagtuQ0Yglc2sfo0k5075ZHih42LRAHk7/+azy8AfGJD?=
 =?us-ascii?Q?lrkbXKbHkpTy2ufW6r8Rt6RfLSqNDMemj6V+zA50VxCsEEe1VzUpjmRjQufS?=
 =?us-ascii?Q?w4u2716ViOI0kicHPJAgdTYTeM5nBHrx5/rDdBjJGvxzXqv5Y2JIGhCbA8eN?=
 =?us-ascii?Q?GBNR3iB7uX2WkSnf8SnX1n/xYAeAdXQwbZh9zTknBCALsMLspzCZdw+xJXvW?=
 =?us-ascii?Q?PwoIIg0/9sknakpqV9FpDNMBgAL2RauvLKjLGF1/YgC+oYBlpLo/h94Wl2S0?=
 =?us-ascii?Q?FWTFyYU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 06:23:20.8787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b53476d-cefe-46bb-bdcd-08dc73de59fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
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

Use gpu_metrics_v1_6 for SMUv13.0.6 to fill gpu metric info

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 46ab70a244af..70e5589f6229 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -350,7 +350,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_5);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_6);
 	smu_table->gpu_metrics_table =
 		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
@@ -2176,8 +2176,8 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_5 *gpu_metrics =
-		(struct gpu_metrics_v1_5 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_6 *gpu_metrics =
+		(struct gpu_metrics_v1_6 *)smu_table->gpu_metrics_table;
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, xcc_id, inst, i, j;
 	MetricsTableX_t *metrics_x;
@@ -2193,7 +2193,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	metrics_a = (MetricsTableA_t *)metrics_x;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 5);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 6);
 
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature));
@@ -2235,6 +2235,16 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
 
+	/* Total accumulated cycle counter */
+	gpu_metrics->accumulation_counter = GET_METRIC_FIELD(AccumulationCounter);
+
+	/* Accumulated throttler residencies */
+	gpu_metrics->prochot_residency_acc = GET_METRIC_FIELD(ProchotResidencyAcc);
+	gpu_metrics->ppt_residency_acc = GET_METRIC_FIELD(PptResidencyAcc);
+	gpu_metrics->socket_thm_residency_acc = GET_METRIC_FIELD(SocketThmResidencyAcc);
+	gpu_metrics->vr_thm_residency_acc = GET_METRIC_FIELD(VrThmResidencyAcc);
+	gpu_metrics->hbm_thm_residency_acc = GET_METRIC_FIELD(HbmThmResidencyAcc);
+
 	/* Throttle status is not reported through metrics now */
 	gpu_metrics->throttle_status = 0;
 
-- 
2.42.0

