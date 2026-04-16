Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300E2F8D761
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 17:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE9FA10E91C;
	Thu, 16 Apr 2026 17:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hyRDXPc3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5601610E91B
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 17:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ah6fPZ15IYfQju5j9Oc+0OTbiD/XOJDR8POlUzl+L49F89knCdOu6SfEGDD8+PdC1teYFbuo8EJ1DK46NO2fb6jcSlMJPodALVFvsNJBBdrsJExt2hEVSgKNYDu1yuPdW1YEtxZk47MHHMX+xTNgS8f8B12K5BJyNMKJgdYK09O6aEvIVRrSDVtQo0bbiXFIpPqqbDtzEXe0AzQ41ltuSAb0e+6Q+/vQIMFVPAb13B1EIlr7n2Pdx4Q8LbItN/vMLDFwg3ywra3P2YoblMs0KkbqQdlY5Q6vAtDh+jNU0LesYopB18B36Y++2a9hueg5lg9nK6mnqt4IIIxJBShwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao4w8pnT0dKMcFgVq2yND15f+mHPWeYD5gtXQWckiR8=;
 b=Ero+5shD+scy5jUxINo+Bh5TBctBEPjWJ9lUK6Fj8XzAsRTII/lbODB+1hOOubRA5lqRU6LivZHx6i/8u6pfdPdcsi5tN5/QRfaptPRUvOIFw3YCWqnsdKWHvwVcV1dgYZzCIQBN0K8Q3FThKyx1x+Ciy26gCzbhl40Digbm0sEYOjD0PwE4ZivojhE1o5fU7hulw+yHeeXqtpDI2jVAd+s93LeFwNLGRLAv7tyTKoBGHsfWxEMwiSLp6HLJax25j/42iN8rJETuDIVnwAYZDQve1l19XX5YlPxM2IkN5wMh6rTDSms0fZZYH5pxUYHkVDCUIQFRW0f7AEMxQNqpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao4w8pnT0dKMcFgVq2yND15f+mHPWeYD5gtXQWckiR8=;
 b=hyRDXPc3PSHRnIpXldElgwZxu5u5SjzGn5qzHf9WEU020AYA8MFT5ks7+ZTyxhMIX104cBU8Qdn4yzlVPnESZfoaA+RqoULijDspQjnSGcfWDV3ouRt03odc0rvYC4sFyhrucJ+DmApEb/EDVDn6Yz+A6+gMCcjXRNQHY39vHdU=
Received: from PH8PR02CA0001.namprd02.prod.outlook.com (2603:10b6:510:2d0::19)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 17:32:14 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:2d0:cafe::ed) by PH8PR02CA0001.outlook.office365.com
 (2603:10b6:510:2d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 17:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Thu, 16 Apr 2026 17:32:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 12:32:13 -0500
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 10:32:11 -0700
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>,
 <KevinYang.Wang@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH v3 2/4] drm/amdgpu: smu: fix average calculation for unified
 metrics on SMU 15.0.0
Date: Thu, 16 Apr 2026 23:01:43 +0530
Message-ID: <20260416173145.856326-2-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416173145.856326-1-Kanala.RamalingeswaraReddy@amd.com>
References: <20260416173145.856326-1-Kanala.RamalingeswaraReddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd95f9f-eade-404c-95cc-08de9bde18f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: GCxvDjQ0iDb1NzZrSLaCG7YELA0BDWLWzPc7UEploi3qApzI/yCiWn4zS/qTur7rluPpEcBdPS8tfUouEDmNaNzLQjCiZAAUiLAJWlFKCo03FShcmOx5n3LVeuuSRHRetCF3Lt7dd3XaCcxS1wK3xGlgdLcf//1cmL3/Hz7ChMzc5X40fzsTYiwZj+vwFiAHBHar7toNK7imIcizE/EZ165+UtEXsOn9NTZ9HTGdDDPAhTOnlMo2lWttS1r+jS55zZlgHE07xbvW2dUAyAbhsAUWwisvsto2tiT9a/16ONgybFmXCCpBaEXOsJzNpu1vevMjZCy89QdhYz9RV+o0zf5xUmIb0ifnYCMu4acpkxX3B9mTUu1Fx2pXrV3gNNOYp9OeO/EpNZX2eMLEMWXM0wrgLhqNF/8cBu/rr18rChWFHycJR2PZIgiKmSbaWjXYU84p1ghSj5CL/A+7r6NAkosL0ru/NPJaunpZ525MGjwcLpqc5Bsomi1mfqGUe5vVRq1PGWJfWJ1uIPRV5h1PPUObmYT9TDbOo4E5wLy68nVpWZ1utzOmxc+FELRtu0st/0WHunJhjQWirllSYHrGhq3MhnIJ7VSZzq0fi2wO8tc+oqLAtRWp6U7BOziUTE/tK0qlBVIdLWTZY7T1NAcnajoOwoeZ1OeRk1ZAVCZ1coYp1BEPKz3ORbjW3a7NZoYq3dRda+0QoEEvHF5cluChXtIDnD2Y4gbunJTq0YXA7AXVS9+3OtuN39gnDf/I1oxWF4UPk2/RhqI/vQk489GbrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I1X+0yS1grNGWYs1N48oaMKhY3Wj8DCMJphAq6kDgHoDz8KHQKngsNGtHpC63+wV0Gniv9uTCfBbGTzsL7IJQ2jAK181ybteOIgV+BOBJKs4Bx99xoH44g/++NN3rtTCgFjscRdwR+giTcr5B65xz78VxbJN90oaZ9AKRMGXQG07Acuasl8pMS0oLHkoW3jzhJCVSnhDsy1K+olotYK78xajHZkpWdzj9iQRzAkFXiAccM36Yh3D+YRQD/pkaMvPWJdSSzh8Bm32a5S+L/3D69UMBxJ6u3nTHwoLWU71YoOM4yQHS1P3sbqXGZcdr/NZAPoEc6Du2yUYmGhbsk6EpBel2q03jZ/0Vleq2l8ugOjOzphllk1KfCOa4Z+An4Uj/erUSFv0L4i9SErVRtZ0auRRFzdTCbaNZexer7jJCSuTNb0VrkoREi/+Q2XBjIKH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 17:32:13.6143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd95f9f-eade-404c-95cc-08de9bde18f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
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

From: sguttula <Suresh.Guttula@amd.com>

Unified metric values reported by SMU 15.0.0 are accumulated in units of
KBytes. Convert the accumulated values to averages by dividing by 1024
before reporting them to userspace.

Signed-off-by: sguttula <Suresh.Guttula@amd.com>
Signed-off-by: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 76 ++++++++++++-------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |  3 +-
 2 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index a280506f43fa..a6a7df683b7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -355,7 +355,7 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 	addr = ((uint64_t)args.out_args[1] << 32) | args.out_args[0];
 	table_size = args.out_args[2];
 
-	cpu_addr = ioremap_wc(addr, metrics->table_size);
+	cpu_addr = ioremap_wc(addr, table_size);
 
 	args.msg = SMU_MSG_GetMetricsTableLogSample;
 	args.num_args = 0;
@@ -371,6 +371,10 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 
 #define get_diff(a, b) \
 	(a > b ? ((0xFFFFFFFF - a) + b + 1) : (b - a))
+#define get_diff_count(a, b) \
+	(a > b ? ((MAX_UINT32  - a) + b + 1) : (b - a))
+#define get_diff_val(a, b) \
+	(a > b ? ((MAX_UINT64  - a) + b + 1) : (b - a))
 
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
@@ -380,7 +384,8 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table; //TBD
 
 	SMU_15_0_0_MetricsTable_t prev_metrics;
-	int ret, counter, val;
+	uint64_t counter, val;
+	int ret;
 
 	memcpy(&prev_metrics, smu_table->metrics_table,
 			sizeof(SMU_15_0_0_MetricsTable_t));
@@ -391,67 +396,86 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 
 	switch (member) {
 	case METRICS_AVERAGE_GFXCLK:
-		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff(prev_metrics.IOD.GfxclkFreqEffAcc,
+		val = get_diff_val(prev_metrics.IOD.GfxclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GfxclkFreqEffAcc);
-		*value = counter ? (val/counter)*1024 : 0;
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_SOCCLK:
-		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff(prev_metrics.IOD.SocclkFreqEffAcc,
+		val = get_diff_val(prev_metrics.IOD.SocclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.SocclkFreqEffAcc);
-		*value = counter ? (val/counter)*1024 : 0;
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_VCLK:
-		*value = 0;//metrics->VclkFrequency;
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics.IOD.VclkFreqEffAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.VclkFreqEffAcc);
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_DCLK:
 		*value = 0;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff(prev_metrics.IOD.MemclkFreqEffAcc,
+		val = get_diff_val(prev_metrics.IOD.MemclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.MemclkFreqEffAcc);
-		*value = counter ? (val/counter)*1024 : 0;
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_FCLK:
-		*value = metrics->FclkFrequency;
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics.IOD.FclkFreqEffAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.FclkFreqEffAcc);
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_VPECLK:
 		*value = metrics->VpeclkFrequency;
 		break;
 	case METRICS_AVERAGE_NPUCLK:
-		*value = metrics->NpuclkFrequency;
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics.IOD.NpuhclkFreqEffAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.NpuhclkFreqEffAcc);
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff(prev_metrics.IOD.GfxBusyAcc,
+		val = get_diff_val(prev_metrics.IOD.GfxBusyAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GfxBusyAcc);
-		*value = counter ? (val/counter)*1024 : 0;
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
-		*value = metrics->VcnActivity / 100;
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics.IOD.VcnBusyAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.VcnBusyAcc);
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff(prev_metrics.IOD.ApuPowerAcc,
+		val = get_diff_val(prev_metrics.IOD.ApuPowerAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.ApuPowerAcc);
-		*value = counter ? (val/counter)*1024 : 0;
+		*value = counter ? (val/counter)/1024 : 0;
 	case METRICS_CURR_SOCKETPOWER:
-		counter = get_diff(prev_metrics.IOD.AccumulationCounter,
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
-		val = get_diff(prev_metrics.IOD.SystemPowerAcc,
+		val = get_diff_val(prev_metrics.IOD.SystemPowerAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.SystemPowerAcc);
-		*value = counter ? (val/counter)*1024 : 0;
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
-		*value = metrics->GfxTemperature / 100 *
-		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
+		val = get_diff_val(prev_metrics.IOD.GFX_TempAcc,
+		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GFX_TempAcc);
+		*value = counter ? (val/counter)/1024 : 0;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
 		*value = metrics->SocTemperature / 100 *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
index b3dc6ccdddaf..592bb0f8ee96 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
@@ -23,6 +23,8 @@
 #ifndef __SMU_V15_0_0_PPT_H__
 #define __SMU_V15_0_0_PPT_H__
 
+#define MAX_UINT32 0x00000000FFFFFFFF
+#define MAX_UINT64 0xFFFFFFFFFFFFFFFF
 #pragma pack(push, 1)
 
 typedef struct {
@@ -213,7 +215,6 @@ typedef struct {
 } MetricsTable_CCX_t;
 
 typedef struct {
-	uint32_t table_size;
 	MetricsTable_IOD_t IOD;
 	MetricsTable_CCX_t CCX[4];
 } SMU_15_0_0_MetricsTable_t;
-- 
2.53.0

