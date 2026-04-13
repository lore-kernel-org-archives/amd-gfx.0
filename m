Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6A4EBFD3B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 10:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5ADC10E370;
	Mon, 13 Apr 2026 10:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ysSsSMKa";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FFB10E370
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 10:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbhMmdcM/i9OEPwXg3bRn9IYEaQZeY4Q53dk46co7X8yY+9LZ8/nk/DbPIHTAnaz6uMDUzOd4nC5ObLUiYU+iGAXevuON2B3LXwYPssPC0BZxz2OHJntzGHNRaRQQya+uqi9+m87e5d7piywkFEolb2096pNMcmaNgIswLsiiov9oufVb9zopBOMpvNE2bajy4TBTytbnL3rvSn8zLHZA1uxqoueavd3Hw3UO5v8L2wYWR5CKK1ktyWkxzg8t+TBTJveKIbCJf71+mbjtkFV7MvDkbwZYqmO+DiRQ5xFdLPMQQms/65TR6GmGAUdLC4gqBs5pC+iD+bDZ5Hqil9TbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao4w8pnT0dKMcFgVq2yND15f+mHPWeYD5gtXQWckiR8=;
 b=CK4KpKLvSMXN+v6kvUZhfQM39s3MnYWKK7LmPersYWNkJl64C6Z5g1BvXjiiTRaC5J1Uicf+8HvguksenX8k8JauXEHW0v8utLP9xvwFWlvc/b7XefKSnsIm/EitdXfgFQBsY6XZ2BFwyLNNvcFFMtd1cosuEwJJALOGwkPls8YpV5bfMaaoDWbrK0AJmsz5KEeLEB9ZuL83U4P5T4j6Kw1by7W5eVqLI+Mk/K1Jia/5TgwPcK9pD4JIjCiXU6QvglUrwscXPelcGcfjZaApn7HcOW0ZMs9B6Dc6AHyVwSrfgpQ+xMXQbDHmCqbwiDoaq7rz5/Wk6qnLyOg3tMqQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao4w8pnT0dKMcFgVq2yND15f+mHPWeYD5gtXQWckiR8=;
 b=ysSsSMKacSmknBDYb5ZzxxiTEBA4p2nh/JricZk0yV0EyKOfK/TJejs5xy76oxprjTyFKC4ltAhuwU1+QUeqNreNiP6S14z3QABgNnwTzFEPJOXARh0I8UdtlqCPqFQ+A2ImThBtAMkn4KKR8d5P4arIoJ6SwPfzK5k9U5plJTs=
Received: from MN2PR20CA0036.namprd20.prod.outlook.com (2603:10b6:208:e8::49)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 10:53:02 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::1c) by MN2PR20CA0036.outlook.office365.com
 (2603:10b6:208:e8::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 10:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 10:53:02 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 05:52:59 -0500
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: smu: fix average calculation for unified
 metrics on SMU 15.0.0
Date: Mon, 13 Apr 2026 16:22:29 +0530
Message-ID: <20260413105230.1633947-2-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413105230.1633947-1-Kanala.RamalingeswaraReddy@amd.com>
References: <20260413105230.1633947-1-Kanala.RamalingeswaraReddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0e5786-1bf8-49ba-0262-08de994ad590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hGKewRYZHAy94rxDpU7H5O0NUvoyCYTQ0W5RJAOW+1t5VOxe8NvPRuLGWw2tpaefIuGsEr5EsOE+7QyRJb1kXNKycICt94gQIKsI7AEbzhCv2jXRf+ejXD3plCs9msub96RbLVVt3qtXg9Y+0be+pODuldWfDFrWVNTTL0SD70zZDyXe3V8Ycgf+U0I6+JdcEP0IB4BaiG3OT4goLderFQHAeeM37O5EKz1qxm4tYjPaAIKbjYdPEgmGgFKWuouHtxwmFCgOX+kNi/MVS7fL5SmjZfl53Jmaogakwja53V7AODtZEyx98ci5wEwlBEw0r6/C+VTIyKC1bUGw4AaytuOIOwDsCLd19NtUxfFdZ0TEDsUkkEKDf0Y0PiFthT5F63ErdHSkEtwWJ8hHtNYNk1PDflI1+hhAmtEMoZlRh6Dd8qZrL+CJgsHa9gOBrQTa84w7rbh9qvo3ZTyA+UZPuUiV+V8/oqWZTDxuN2B+g1o9gQkgQRXNrZZBiA3jCi2ycMtmIR/pl99UNW68Y0pkVkWZzZXHUeGAQW61d/uRhOGaONAH35jwhaBQuuMNoTIhV5Xn1b0a0ha6weS0jwPdzTQJ3CDdzIV/iX1eELG33f01mMVbMiZGHSb2idMwId/xdidX1cteMaDq9tLj6OvDXl0elsXkDaul+my4Fqw4NckEsSSGlkBIGZrTODiUmezQnj+btYTFytoB6ODvM7kBuuA+i8jdQuRJbqpZaCNB1X3dZjbxPPe5o0Q+iNjLC2AxUKfbFyVIrJ6WAVQe9XXZMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MPLU1iJ393Q8HNPkYDmOKVKGwL8H8Aa8Gybq9gPQRa05ziAr/ZcHHN7lGVZI1RgATlwKyhXH+wkVizj2aKC6+1uKwLVLEK1XYx39GYULxjjBbziFAI8CQjyV1qjtCdIO+Ls2U0cBfjUX6105mjl/f2iNTRiaJYN68v+p7sW5lXcetVJXURmrsEqcKO9tREJ2CuwbtLNVOR42ksjGsl+Acjo5SQczPCr14dF4t72btCYlAuD2KJN5wrBwmTGgvAKknAzK6gf0LKiKcMmdJrVatb8MsigR+h8+SiPjDfszkTWrEX31OtAMDmM1Tm/Au9aUmGGema/h8wk2DdoL4/j/x0W8nsrFT3KkvKEY1yUmxEWR1/hn6ND5zqCkxkuPs63EAiTLR/kR0CGFGP2oFi2e4MFwsG2i1g3Twqd7wbDG5VEK1jX0oFYVhXNQ0TqZEVQ/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:53:02.2370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0e5786-1bf8-49ba-0262-08de994ad590
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
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

