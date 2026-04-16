Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C357F8D763
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 17:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9E610E91B;
	Thu, 16 Apr 2026 17:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sL11XH43";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012040.outbound.protection.outlook.com
 [40.93.195.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3812210E91B
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 17:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGs9UX4FNrU30Ayv2QdrCVwtg1Qj2GwIKJvWwiS0RbhEhixEgR1xYUBKPYcPysGn9Gl3sbEF+C5iAuXoj66DTmR3pF823grLp9CC9+GpUbOkO5CclJ4AovaUWcN3hi874mn4O0tKrZna/Pwjoc5oLMpCJc1MfbcEQ8ltGfYMenj8ApTdHcTguUEzGogNMfPdU5exgxvFTQE5JB+r7OQ7hl1e5WY15gbX9UEvBhn1/EvxVSvQad9B2WCshTlwtRso1DzKrzcNI5VY56kVxdVFoEOxlOMP3TeQkCjfnoIPmOaD6INVTdDOhvJTFB0Fnf6l7VL4XTuA4W56P3kbY4Vx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5N3I9pzVZWf0M+l2yzwaGDcNiM3f0bzni2sXErsc+A=;
 b=C60MHArEoyoWAH97gzbJc0y8zDNB/x88Eo9fxbIjlqu9oeEszS/EXfpQkG/UhRHp8LU7sXFerMvYm9f8ZbFVysLNmyq1VH+CdJMjSLrbC1Au7CAemLURI2wV7KBAW9aP3YJBkjI1m21gNShpsLCXy1uJRHaWjSqQe477nSPz28uSx+/cK1fEwBqEfTS9TLotuBaXEcKTy0UIQC88mutd7ZL29D0us3Q3U+r16iwQFdkVWTVC0dJCRotZKO8uvhOFZ/pl77+xZyC1UPJoIweTm+8lojsP6nG91l2BgqSzgBRVaugyBtnJ0x+zic0oIRxJV0dGPkYz6OKJS98Hf8EAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5N3I9pzVZWf0M+l2yzwaGDcNiM3f0bzni2sXErsc+A=;
 b=sL11XH43LFzXkK9gA0hc7n4ysDBhU4mowuAPVliUB1J8gEq2+aHmU5gGGVw7tBRhR48ZY4yK+EUlA+2eZkr6M1v22+gVGF+zjHd6wNwgTw4Ffh138KcV4JSKnb+XKu1UopVISfSmAr07IdYDzAqxPMwsUYi9Sfluru7llsU716w=
Received: from BY3PR10CA0008.namprd10.prod.outlook.com (2603:10b6:a03:255::13)
 by DS0PR12MB9725.namprd12.prod.outlook.com (2603:10b6:8:226::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 17:32:18 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::ed) by BY3PR10CA0008.outlook.office365.com
 (2603:10b6:a03:255::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 17:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Thu, 16 Apr 2026 17:32:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 12:32:17 -0500
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 10:32:15 -0700
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>, <Suresh.Guttula@amd.com>,
 <KevinYang.Wang@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH v3 3/4] drm/amdgpu: smu: cache and reuse averaged unified
 metrics values
Date: Thu, 16 Apr 2026 23:01:44 +0530
Message-ID: <20260416173145.856326-3-Kanala.RamalingeswaraReddy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|DS0PR12MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ce02f1-eee0-42b0-5ebe-08de9bde1b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bfdxDSCfhjZZdH8AhDE56fUtmXl/MFWuEDQOLxV8ZWuuiT/JsaZWvnAFgz+QU87uj/7SZxGR5GtT/cakngUaEnxPLhGE5hTLZZy2gFLLlBCICvHfyxbOADteJgYT0dKOMWsxui3b0Fl5E6U34LIrhya/JTQml/zV+zodIv7uungH3CpNx/u8HK5v/e9lPM7UTz7GXD6WyMnb4MaOXiaQ/3zXQe0MNCl9D4cg2FEuzCn1ziwECbGG3RnS86QK9bM44GfgPmw0uxwx53jrJj0Nu+V25Cy+207Lf5qgJWMHdKo+m8FRcFFYZtxAJfybkJWorwGDUS8R5dQ7tkD5D3IGnQQILqJmw0KGjbZ9f8LDkHstVy20kseEXx7uVNDgd1rE6VVkQmI3GZUG09HSJxei0Oo2PDR/bX9DG1WmOTyHgPRPpvkG+0321R5rvGQ2TPsJyEgxIzMDyx8HvUTKYyaSPLKJD4vmQ6D54W5so1yYs2DFy8TYCJqK9HiMysbKJ5EAblzyiPFlHMwDlxKGWal2bvOIa0tbOiyXYHMGBl37+XD8mHJICdaTkFqZ+fQgTHhw44ngffYrXwLocFKRws9O7EUIh9ND1vOCG/HWxYL5vB7DmEcpj56PQh+Hy4Ohz8rsrZYqDXsh4vr3wPg/B8FwS7kGtSZRoRtbwpPBcPU6mpZCYyB4gKUJsc7oCXjEmCotDthcASL+oVdTerLLTS1u5LaieTejpATGMB8NmP2WqnELOKEylyM9mprIHg8IrdoHmM++HIb04BRHwTAG82LZFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2r5jcIqkLKegaAM8xOb5Zir2WtJ/sfX9i9/g10JVUrmM89QWNt8QowWKD7J/nX+WsQ7gcT+l6IT2HyuI/g9F1QNHyfHtq3nc4aX3u3H+H1iTrSrcUhZ+Gr7Y1OTXSw52xTM41h4MKIsY7EfHVBT9iPSm8/E4P3Pf+oLClMKLEKCK0CpPmDHVFZGfqghUVUb47Z1JsNGfHvC1aPdH/kmcZ1x5tpjr25hdKANYywm4ueEapfeiYabIpS9qPXbWY+3Nu778HOTqATS95zEy9essNH5VffUeC7JbvqJdq9GiG2KYzdPtFg2ngv+otA8sbV9Nh6oM6VZQUiAePF3eJHapJKnslqb17RMvkAOmmBATANkOD07yNqcNw42EmMt/cc2FU3T8QzQ1MtI7//NtR3WGmGnKuZPKFqNP6+2fYBFL8qUobkXoaYvc9AsZKMiGSZLw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 17:32:17.6429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ce02f1-eee0-42b0-5ebe-08de9bde1b60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9725
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

Compute averaged metrics from accumulated SMU values and store them in a
local cache. If the metrics accumulation counter has not changed, return
the previously cached metrics instead of recalculating them.

Signed-off-by: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index a6a7df683b7e..f0a798631903 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -384,6 +384,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table; //TBD
 
 	SMU_15_0_0_MetricsTable_t prev_metrics;
+	static uint32_t Avg_Metric_copy[METRICS_AVERAGE_NPUCLK+1] = {0};
 	uint64_t counter, val;
 	int ret;
 
@@ -394,6 +395,12 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	if (ret)
 		return ret;
 
+	if (prev_metrics.IOD.AccumulationCounter ==
+		((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter) {
+		*value = Avg_Metric_copy[member];
+		return 0;
+	}
+
 	switch (member) {
 	case METRICS_AVERAGE_GFXCLK:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -401,6 +408,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.GfxclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GfxclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_SOCCLK:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -408,6 +416,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.SocclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.SocclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_VCLK:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -415,9 +424,11 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.VclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.VclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_DCLK:
 		*value = 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_UCLK:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -425,6 +436,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.MemclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.MemclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_FCLK:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -432,9 +444,11 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.FclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.FclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_VPECLK:
 		*value = metrics->VpeclkFrequency;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_NPUCLK:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -442,6 +456,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.NpuhclkFreqEffAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.NpuhclkFreqEffAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -449,6 +464,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.GfxBusyAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GfxBusyAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -456,6 +472,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.VcnBusyAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.VcnBusyAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
@@ -463,54 +480,68 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		val = get_diff_val(prev_metrics.IOD.ApuPowerAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.ApuPowerAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 	case METRICS_CURR_SOCKETPOWER:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
 		val = get_diff_val(prev_metrics.IOD.SystemPowerAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.SystemPowerAcc);
 		*value = counter ? (val/counter)/1024 : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
 		counter = get_diff_count(prev_metrics.IOD.AccumulationCounter,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.AccumulationCounter);
 		val = get_diff_val(prev_metrics.IOD.GFX_TempAcc,
 		 ((SMU_15_0_0_MetricsTable_t *)smu_table->metrics_table)->IOD.GFX_TempAcc);
-		*value = counter ? (val/counter)/1024 : 0;
+		*value = counter ? (val/counter) : 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
 		*value = metrics->SocTemperature / 100 *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_PROCHOT:
 		*value = metrics->ThrottleResidency_PROCHOT;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_SPL:
 		*value = metrics->ThrottleResidency_SPL;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_FPPT:
 		*value = metrics->ThrottleResidency_FPPT;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_SPPT:
 		*value = metrics->ThrottleResidency_SPPT;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_THROTTLER_RESIDENCY_THM_SOC:
 		*value = metrics->ThrottleResidency_THM_SOC;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_VOLTAGE_VDDGFX:
 		*value = 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_VOLTAGE_VDDSOC:
 		*value = 0;
+		Avg_Metric_copy[member] = *value;
 		break;
 	case METRICS_SS_APU_SHARE:
 		/* return the percentage of APU power with respect to APU's power limit.
 		 * percentage is reported, this isn't boost value. Smartshift power
 		 * boost/shift is only when the percentage is more than 100.
 		 */
-		if (metrics->StapmOpnLimit > 0)
+		if (metrics->StapmOpnLimit > 0) {
 			*value = (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
-		else
+			Avg_Metric_copy[member] = *value;
+		} else {
 			*value = 0;
+			Avg_Metric_copy[member] = *value;
+		}
 		break;
 	case METRICS_SS_DGPU_SHARE:
 		/* return the percentage of dGPU power with respect to dGPU's power limit.
@@ -518,14 +549,18 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 		 * boost/shift is only when the percentage is more than 100.
 		 */
 		if ((metrics->dGpuPower > 0) &&
-		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
+		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit)) {
 			*value = (metrics->dGpuPower * 100) /
 				 (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
-		else
+			Avg_Metric_copy[member] = *value;
+		} else {
 			*value = 0;
+			Avg_Metric_copy[member] = *value;
+		}
 		break;
 	default:
 		*value = UINT_MAX;
+		Avg_Metric_copy[member] = *value;
 		break;
 	}
 
-- 
2.53.0

