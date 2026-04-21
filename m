Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAD1F327DB
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90C5910E280;
	Tue, 21 Apr 2026 17:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="igxlM3tZ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A86910E8FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShX+26h6QpX0Ajvgd1mEV0/KW0KdzgteOTnXu3xMBbdLAftB19s1CEgFFwbh8IZeP00lXzNZI/5MuPEGJ38J/NKsKeYUvXOSXGyiZLfYLPTfPyiBm6czDs0mkPQTz89jRb9AVNW/hEF7ujoze+X99STnsjPFI04ACWw0cwMZn65u1CnnuzmgNuDNo/nllOtQvWPdVCCaiuuadK2o7B7gbTVEoDEkDCcoh8cjse23youExFfk3p9c0jqcbD1jTI34tI4iuz2uZMhAuEiCX1AAGvElKELMb2lPthHuAObq9YLtUx9R1Fu233v+q4P3ROyNs8lf+IxYx91qQZI2Oh0biA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL4t8mIevj6ccocL7zdkhuA4Sj7Rkdim/jSM8N4D054=;
 b=lBR230xOIdgdXSAiomskem2zg42PZiAMQ2TIFFbAov3JWNr4DhKsVjhQVHUlBsBn4FG757X8vbf/KiXrOLoV+UsDWWS2ICSAfPXl27MAo+wEBiu198tOZVmlI2v6tNlUl9hXjElbsKAz7M8Nw3MyWT9O8jm4L5WlqwoiXSiOZb+D+OVlb84OHzbjS8QPQcG3PT+SHvDWkAKRao6OZjZgMLoHgrGG/uLbGio4JGAkEhlyOW/9hIXtWbn0cfshIKsAJHIUdLg+dzxKr990KcGpIf0hQdva6+naD5t6BKiOuUCl2JsEQHOF7S25rgjNH+rb+L35hN96o4vNmre2XY/G4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL4t8mIevj6ccocL7zdkhuA4Sj7Rkdim/jSM8N4D054=;
 b=igxlM3tZk826kjqwMI9uY4gmnxFlWR9hUmHR4PF1QlpH8t2gD5gdtA2rjJ1IEdtbY852mAYADffncPLtbErpogB9N8xugsO+OjXFyLs4b1V4k0UvEdkqQI+y/6op4kSwJR2RYGDse5qxmy7D52/WNSDjJNgLVXsee4jdlbTn+5c=
Received: from BLAPR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:32b::18)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Tue, 21 Apr
 2026 17:42:58 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::64) by BLAPR03CA0013.outlook.office365.com
 (2603:10b6:208:32b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 17:42:57 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 12:42:55 -0500
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>,
 <KevinYang.Wang@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH v4 2/3] drm/amdgpu: smu: fix average calculation for unified
 metrics on SMU 15.0.0
Date: Tue, 21 Apr 2026 23:10:13 +0530
Message-ID: <20260421174014.3284999-2-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421174014.3284999-1-Kanala.RamalingeswaraReddy@amd.com>
References: <20260421174014.3284999-1-Kanala.RamalingeswaraReddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d949b3-f8eb-4556-4b25-08de9fcd6ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: A0z4SKIH7W3IiHm+h0bI9dDBp0joZqaYGWv63HSXSZ903GU0nRy8QimdXjmhadgOW2e8FuV8UFj7YhWwu0atshDZlNfo4I9JkzGh6iGsT1X4MkbtmHdwhQwO9vMBlqD5+2AsQV60Pi+Dor0CGv8mOoWSrUJA6FzgjUdI/VYlO1qTXqjlb2+XtdgN1vD2x5De8rd7fj72U3uvMaRj83yKnxZMY8rd2YqkMEc41XKFNA0jtyXzWv+yRS/e+nr2sMRmNrvC/NtAF5DgPirmMUIGCUKD8KAbNxClez+SdWjroP39f4X8Fk2sgBhWu7AYjy+yTdxtg4uiVav91IYMAZ/9Jr9SM6gn2By9G+Z4dEiC2JNfizkD5Qg6t3/5brRn3t9UKwk05VPmqC5tz9ScEXnwo4zxwWLJ2oI2mAJZqLAORNCF0Fcb1XPcxnFEm9D+ga72bFsL93tpnIhWsBTHVBwup/idgS2jZdYrktjwCpiR5OEsYu7keU37vmtryl9GCT0z18pr1vrt8eyuyy2I9JxMYZsMWnj+ehcsb5pnoXHZ63qSOLbGwYGddC/ngPmkA88VAfowLYzT3TgGKPTxUpwjPMEfFQaKYUz9twiOq9UKr+X1ycfbxAiPdsbxebMWVXZ1oxbt+HqjKyuKqzqT74LA786qSqEvEnELLKB8Rm1r+jJUN/vSeoT7V5VOXZvrJzxG3SGeElnHC3yMFA75SheCtThqv6DGo3dmNMW1ADdPG+dmY2oh3Cb/SH27K7UuCU9XjsQeR7QbJrQMd89mcxAFgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IcHdz1IOTeHKUonv7DsN0kuaWuj3plBTF1yBlQ22n+sT6NW9D1r7gTvSmoW1M5k+ntE7jZXUhPS+h/BbiLVqTlVVcrHyOOIiMmGRTP+6ybcX48FIjHjiAo+8rQ6CBNPilkDEw3VAfvNUrPqmFclrIqOSsYz/xpxn8/yA+ka2A8y7mBZLQ9Q6YBnFQFX2YupBpzSMjkHJnrl0H+h+Ga5fT+6JKel3uej0zTgvTTSBt4edOgJs3lnXATwqwiFfMvqw0V9iWLixGJ0CKWcI+vcWMu4LRPMGFootU0EJJPnS/VqID2VPTE5dzw0hLqQLYNlWtBUwpoCz6ZBzS/Ra+bksdDVZrSOeDAnmNdMyX+TSX+GaazB5l0nE/uF0gRTPQJTs2Pfuqr2WvpBvIAlMDImBUUS7YiBV11Kb6T39zP7yx1pDi2n5XLhQXduFc0i9G+Jf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:42:57.6475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d949b3-f8eb-4556-4b25-08de9fcd6ce1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
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
index d83bc2d4cd69..f2549754e8e9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -362,7 +362,7 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 		table_size = args.out_args[2];
 	}
 
-	cpu_addr = ioremap_wc(addr, metrics->table_size);
+	cpu_addr = ioremap_wc(addr, table_size);
 	if (!cpu_addr)
 		return -ENOMEM;
 
@@ -384,6 +384,10 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 
 #define get_diff(a, b) \
 	(a > b ? ((0xFFFFFFFF - a) + b + 1) : (b - a))
+#define get_diff_count(a, b) \
+	(a > b ? ((MAX_UINT32  - a) + b + 1) : (b - a))
+#define get_diff_val(a, b) \
+	(a > b ? ((MAX_UINT64  - a) + b + 1) : (b - a))
 
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
@@ -393,7 +397,8 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table; //TBD
 
 	SMU_15_0_0_MetricsTable_t prev_metrics;
-	int ret, counter, val;
+	uint64_t counter, val;
+	int ret;
 
 	memcpy(&prev_metrics, smu_table->metrics_table,
 			sizeof(SMU_15_0_0_MetricsTable_t));
@@ -404,67 +409,86 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 
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

