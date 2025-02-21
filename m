Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C47C021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 12:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBCB010EA6C;
	Fri, 21 Feb 2025 12:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JAGVguEP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7376210EA69
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 12:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJlUpWAITFfG0GfApRlr7vmx/guqUslIjSxU0KiSZ1LequEbGpFecOvIEi0dVrYILabMIEviL5f5qGTz+I+cwLhBgKsdJBIijbdzbNHD+7vNGy0PueptYNIfnG5oGBjQJPFKnI5+F+4yMkH2Jw73GTyBq9d3WqN2a3Z2Ye3X2Y2e2in2fqN7w/qHi8O28qV0gxAY+sVpxc0n5ZMH2pNYKtREmSOQcjDnnxJhJg8J2C8FE/sP6fXXM/rdm7rVpjZagwUyNKqKDp2Qm+nOEnndeSph9DoMz7nz0R1cq0qi+E29oh0kDXcVThxeQIDnHGI+p8mjFOWoNKkeiuzpwE5ZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7axRJRflMM4CC6TRHW6oB+FFom8eP04sXeKC02hbFQ=;
 b=NDD9HGPv7PZMbqnHIpYM2VeMNQzknZxsLv4ukHdwQ79sQ5f5eum7vHDzNyBzuMnRwyMXANsIScr1To5rLO8bCBK/pOmjq+BpYiD++TZ8qMRHF64TthJ3DPq0jlUzHD3SgiSaX19pjblRzuoFpRph+5qUOt/sprHNdIlfLZQzIaVkuVYx79QPabrj3zlEcXI52eBlj1W4Pa5U+MJkFwYalz5DnGaugLHEqjINPt43e79yjGydxx3wLrj75xMEUKzp/hU6uyO+WlurtLE3j0ov3nqml6/8bjPlfsXA+JyG1rQs/U2qGjlvhRH3zCARbRf/HnTmWiHR7bE5T6CznisIyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7axRJRflMM4CC6TRHW6oB+FFom8eP04sXeKC02hbFQ=;
 b=JAGVguEPj0ju/4Nb4RRW6hDKLg94zlrOY1QNSbCT2XcKEF6FijYU885YgexCYSCEOcxAuhIizyBykgOTa4i3hzzNaV+lomvqQbOoVCgyYj8yReC9GUJERhOcu+ENoHhmDYb26xiFKrsKgMliBzjeL9P/9+XOkEEnserg23o9v6E=
Received: from BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::18)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 12:19:46 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::14) by BL1P222CA0013.outlook.office365.com
 (2603:10b6:208:2c7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 12:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 12:19:45 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 06:19:42 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amd/pm: Use separate metrics table for smu_v13_0_12
Date: Fri, 21 Feb 2025 20:19:19 +0800
Message-ID: <20250221121920.779576-5-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250221121920.779576-1-asad.kamal@amd.com>
References: <20250221121920.779576-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cef444d-474f-43c1-cdd6-08dd52720709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?25bOqotuJf/FA7nJv47nx4C8eNMIEunPCm9hN+HZw1NaJslblgnO5Vy7KZx8?=
 =?us-ascii?Q?R3p84pnW0SUpzLqk0RW9JdonCvWgI9xy/hmLZglYU8Owtaryo/3tIpNxCOGd?=
 =?us-ascii?Q?Te4PvJNHeFv45NHa5i06IPTrLixQrkVAAD1ff5tK47lEzwWjyPMPw/hPuWb/?=
 =?us-ascii?Q?Q21Psb/+DL4YhXW0huJdhTjaKeBYNPSScBZsOBaXt2HAhuUXndPMw0cDngpd?=
 =?us-ascii?Q?UkFrZefJqTlS/1gAqPeAJyDMbhSdgdYf+H1NtyWevCLwWJTchhsnhyCywDQJ?=
 =?us-ascii?Q?QhP+DiEEIBAc4R988Nooq2EAkGHycn8YkMslxY2SEP9bcEG6KbE0QJm4yRWD?=
 =?us-ascii?Q?RGbrrQjYOHxvI8U6JnaAade0wfO6dlPoTpUPWFGkvlxPeUbQCA1rekQzvhQV?=
 =?us-ascii?Q?Mk2MAREzCR5FHxqNxnTujrotq4nZSErqewvwkBuFqDGcjflHVD24n4wrx7uD?=
 =?us-ascii?Q?3joOW0ma9soxg8OF1QTOxwZv9LyDzZ09n5EuYHrZGPAl/qjWaI+jrosZqnTE?=
 =?us-ascii?Q?dlRVXz3T1nS/y+Geg3081znLNao5IGaT7fngvuTCOXCc/IHk0E5zqTSxJypT?=
 =?us-ascii?Q?JeirEtqO82LCyJhYyOC2fU9Zonuj7mwRO0eQVpHnVAMEK89MhQ8j8F152/y0?=
 =?us-ascii?Q?ItMSF/kg/JXy/r47aNprjJv/bvS4MgqEmLvTtFIC/Irpx3UAIX6mbnhmcbWs?=
 =?us-ascii?Q?1Jofs4B8gNhmo+8QOdaCCAwxz/QrzFRs6KGg5w/KejwRDhYj6s75tdwf5LQL?=
 =?us-ascii?Q?gdHlCsynn7HKMpFjd1DGi4yqldBzmvfbKpNowNPKB+5PByBTSalruWhYAKTh?=
 =?us-ascii?Q?zxzfXkHdz9CLBOfyapi58f2BUrH0DQ8JwvjIX75bmIyJM7hmjgiMEDw4tUov?=
 =?us-ascii?Q?NDWq25KV6E1Zz1XigDl7dyjiyHs3cMZZ6Q9Frz4yCv06WuOURtqki5rzWBbp?=
 =?us-ascii?Q?/9UYn5IrVSOg7xM1P2dQ8qwCzjFh9v4a7sdwyCyGV2cP/r2b1XGkfjb9B5gt?=
 =?us-ascii?Q?Ix5aeWt5DTxLJuNWXrPAmCcXzplPnm22lFKOgAcuzRUfPl1hWw93VDAH2LED?=
 =?us-ascii?Q?mfuiBUNVUQwc74L5DpTvVD/EmL+V/26iohDcgAPKApS6YCE6ja3TQpAOS8K7?=
 =?us-ascii?Q?DirAt4RpQPSUy8H7ZqcPiu13wK+s4goYUrykNyUeEN9ZJHFEb5XaHu2n20hP?=
 =?us-ascii?Q?hTysWUV05oKaUlfTvSlkwv/X1hwuJxaU4Lo4Jb7MqcaphL1rtjiZ6nHf2uQG?=
 =?us-ascii?Q?HrVE3FbGWsUeera1RH4OBdT0rPgF86a8FtnzmSM1vo8E81IAe9G4LayquMb5?=
 =?us-ascii?Q?6sqlcLM0y/AZhn2IvgDeoIgM2LbkLNPrXoXHo+WbyDzVv/G7uwR/JR7YffnM?=
 =?us-ascii?Q?iFnDjZWE6M6yS02JS6DYeW9c9c0MnVjT0wx1GHMkQKaIBZuUsWwTfk21cU29?=
 =?us-ascii?Q?ghi8GTI2dGrdQgAl6fHQJFDmDmu9fDjKeQ39f07vRRea/CJwnsKPTyESPOXK?=
 =?us-ascii?Q?7yhmc9pbkzOTB84=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 12:19:45.3685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cef444d-474f-43c1-cdd6-08dd52720709
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
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

Use separate metrics table for smu_v13_0_12 and fetch metrics data using
that.

v2: Fix jpeg busy indexing (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   4 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 219 +++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   9 +-
 3 files changed, 230 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 4dc3b37d52b9..cd03caffe317 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -313,6 +313,10 @@ void smu_v13_0_interrupt_work(struct smu_context *smu);
 bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
 int smu_v13_0_12_get_max_metrics_size(void);
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
+int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
+				      MetricsMember_t member,
+				      uint32_t *value);
+ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index e153062adf77..5e7e97d90805 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -56,6 +56,10 @@
 	(FEATURE_MASK(FEATURE_DATA_CALCULATION) |                              \
 	 FEATURE_MASK(FEATURE_DPM_GFXCLK) | FEATURE_MASK(FEATURE_DPM_FCLK))
 
+#define NUM_JPEG_RINGS_FW	10
+#define NUM_JPEG_RINGS_GPU_METRICS(gpu_metrics) \
+	(ARRAY_SIZE(gpu_metrics->xcp_stats[0].jpeg_busy) / 4)
+
 const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] = {
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DATA_CALCULATIONS_BIT, 		FEATURE_DATA_CALCULATION),
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DPM_GFXCLK_BIT, 		FEATURE_DPM_GFXCLK),
@@ -175,7 +179,7 @@ static int smu_v13_0_12_fru_get_product_info(struct smu_context *smu,
 
 int smu_v13_0_12_get_max_metrics_size(void)
 {
-	return sizeof(StaticMetricsTable_t);
+	return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t));
 }
 
 static int smu_v13_0_12_get_static_metrics_table(struct smu_context *smu)
@@ -258,3 +262,216 @@ bool smu_v13_0_12_is_dpm_running(struct smu_context *smu)
 
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
+
+int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
+				      MetricsMember_t member,
+				      uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+	int xcc_id;
+
+	/* For clocks with multiple instances, only report the first one */
+	switch (member) {
+	case METRICS_CURR_GFXCLK:
+	case METRICS_AVERAGE_GFXCLK:
+		xcc_id = GET_INST(GC, 0);
+		*value = SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
+		break;
+	case METRICS_CURR_SOCCLK:
+	case METRICS_AVERAGE_SOCCLK:
+		*value = SMUQ10_ROUND(metrics->SocclkFrequency[0]);
+		break;
+	case METRICS_CURR_UCLK:
+	case METRICS_AVERAGE_UCLK:
+		*value = SMUQ10_ROUND(metrics->UclkFrequency);
+		break;
+	case METRICS_CURR_VCLK:
+		*value = SMUQ10_ROUND(metrics->VclkFrequency[0]);
+		break;
+	case METRICS_CURR_DCLK:
+		*value = SMUQ10_ROUND(metrics->DclkFrequency[0]);
+		break;
+	case METRICS_CURR_FCLK:
+		*value = SMUQ10_ROUND(metrics->FclkFrequency);
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		*value = SMUQ10_ROUND(metrics->SocketGfxBusy);
+		break;
+	case METRICS_AVERAGE_MEMACTIVITY:
+		*value = SMUQ10_ROUND(metrics->DramBandwidthUtilization);
+		break;
+	case METRICS_CURR_SOCKETPOWER:
+		*value = SMUQ10_ROUND(metrics->SocketPower) << 8;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = SMUQ10_ROUND(metrics->MaxSocketTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_MEM:
+		*value = SMUQ10_ROUND(metrics->MaxHbmTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	/* This is the max of all VRs and not just SOC VR.
+	 * No need to define another data type for the same.
+	 */
+	case METRICS_TEMPERATURE_VRSOC:
+		*value = SMUQ10_ROUND(metrics->MaxVrTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	return ret;
+}
+
+ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v1_7 *gpu_metrics =
+		(struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
+	int ret = 0, xcc_id, inst, i, j, k, idx;
+	struct amdgpu_device *adev = smu->adev;
+	u8 num_jpeg_rings_gpu_metrics;
+	MetricsTable_t *metrics;
+	struct amdgpu_xcp *xcp;
+	u32 inst_mask;
+
+	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
+	memcpy(metrics, smu_table->metrics_table, sizeof(MetricsTable_t));
+
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 7);
+
+	gpu_metrics->temperature_hotspot =
+		SMUQ10_ROUND(metrics->MaxSocketTemperature);
+	/* Individual HBM stack temperature is not reported */
+	gpu_metrics->temperature_mem =
+		SMUQ10_ROUND(metrics->MaxHbmTemperature);
+	/* Reports max temperature of all voltage rails */
+	gpu_metrics->temperature_vrsoc =
+		SMUQ10_ROUND(metrics->MaxVrTemperature);
+
+	gpu_metrics->average_gfx_activity =
+		SMUQ10_ROUND(metrics->SocketGfxBusy);
+	gpu_metrics->average_umc_activity =
+		SMUQ10_ROUND(metrics->DramBandwidthUtilization);
+
+	gpu_metrics->mem_max_bandwidth =
+		SMUQ10_ROUND(metrics->MaxDramBandwidth);
+
+	gpu_metrics->curr_socket_power =
+		SMUQ10_ROUND(metrics->SocketPower);
+	/* Energy counter reported in 15.259uJ (2^-16) units */
+	gpu_metrics->energy_accumulator = metrics->SocketEnergyAcc;
+
+	for (i = 0; i < MAX_GFX_CLKS; i++) {
+		xcc_id = GET_INST(GC, i);
+		if (xcc_id >= 0)
+			gpu_metrics->current_gfxclk[i] =
+				SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
+
+		if (i < MAX_CLKS) {
+			gpu_metrics->current_socclk[i] =
+				SMUQ10_ROUND(metrics->SocclkFrequency[i]);
+			inst = GET_INST(VCN, i);
+			if (inst >= 0) {
+				gpu_metrics->current_vclk0[i] =
+					SMUQ10_ROUND(metrics->VclkFrequency[inst]);
+				gpu_metrics->current_dclk0[i] =
+					SMUQ10_ROUND(metrics->DclkFrequency[inst]);
+			}
+		}
+	}
+
+	gpu_metrics->current_uclk = SMUQ10_ROUND(metrics->UclkFrequency);
+
+	/* Total accumulated cycle counter */
+	gpu_metrics->accumulation_counter = metrics->AccumulationCounter;
+
+	/* Accumulated throttler residencies */
+	gpu_metrics->prochot_residency_acc = metrics->ProchotResidencyAcc;
+	gpu_metrics->ppt_residency_acc = metrics->PptResidencyAcc;
+	gpu_metrics->socket_thm_residency_acc = metrics->SocketThmResidencyAcc;
+	gpu_metrics->vr_thm_residency_acc = metrics->VrThmResidencyAcc;
+	gpu_metrics->hbm_thm_residency_acc = metrics->HbmThmResidencyAcc;
+
+	/* Clock Lock Status. Each bit corresponds to each GFXCLK instance */
+	gpu_metrics->gfxclk_lock_status = metrics->GfxLockXCDMak >> GET_INST(GC, 0);
+
+	gpu_metrics->pcie_link_width = metrics->PCIeLinkWidth;
+	gpu_metrics->pcie_link_speed =
+		pcie_gen_to_speed(metrics->PCIeLinkSpeed);
+	gpu_metrics->pcie_bandwidth_acc =
+		SMUQ10_ROUND(metrics->PcieBandwidthAcc[0]);
+	gpu_metrics->pcie_bandwidth_inst =
+		SMUQ10_ROUND(metrics->PcieBandwidth[0]);
+	gpu_metrics->pcie_l0_to_recov_count_acc = metrics->PCIeL0ToRecoveryCountAcc;
+	gpu_metrics->pcie_replay_count_acc = metrics->PCIenReplayAAcc;
+	gpu_metrics->pcie_replay_rover_count_acc =
+		metrics->PCIenReplayARolloverCountAcc;
+	gpu_metrics->pcie_nak_sent_count_acc = metrics->PCIeNAKSentCountAcc;
+	gpu_metrics->pcie_nak_rcvd_count_acc = metrics->PCIeNAKReceivedCountAcc;
+	gpu_metrics->pcie_lc_perf_other_end_recovery = metrics->PCIeOtherEndRecoveryAcc;
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
+	gpu_metrics->gfx_activity_acc = SMUQ10_ROUND(metrics->SocketGfxBusyAcc);
+	gpu_metrics->mem_activity_acc = SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);
+
+	for (i = 0; i < NUM_XGMI_LINKS; i++) {
+		gpu_metrics->xgmi_read_data_acc[i] =
+			SMUQ10_ROUND(metrics->XgmiReadDataSizeAcc[i]);
+		gpu_metrics->xgmi_write_data_acc[i] =
+			SMUQ10_ROUND(metrics->XgmiWriteDataSizeAcc[i]);
+		ret = amdgpu_get_xgmi_link_status(adev, i);
+		if (ret >= 0)
+			gpu_metrics->xgmi_link_status[i] = ret;
+	}
+
+	gpu_metrics->num_partition = adev->xcp_mgr->num_xcps;
+
+	num_jpeg_rings_gpu_metrics = NUM_JPEG_RINGS_GPU_METRICS(gpu_metrics);
+	for_each_xcp(adev->xcp_mgr, xcp, i) {
+		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
+		idx = 0;
+		for_each_inst(k, inst_mask) {
+			/* Both JPEG and VCN has same instances */
+			inst = GET_INST(VCN, k);
+
+			for (j = 0; j < num_jpeg_rings_gpu_metrics; ++j) {
+				gpu_metrics->xcp_stats[i].jpeg_busy
+					[(idx * num_jpeg_rings_gpu_metrics) + j] =
+					SMUQ10_ROUND(metrics->JpegBusy
+							[(inst * NUM_JPEG_RINGS_FW) + j]);
+			}
+			gpu_metrics->xcp_stats[i].vcn_busy[idx] =
+			       SMUQ10_ROUND(metrics->VcnBusy[inst]);
+			idx++;
+		}
+
+		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
+		idx = 0;
+		for_each_inst(k, inst_mask) {
+			inst = GET_INST(GC, k);
+			gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =
+				SMUQ10_ROUND(metrics->GfxBusy[inst]);
+			gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
+				SMUQ10_ROUND(metrics->GfxBusyAcc[inst]);
+				idx++;
+		}
+	}
+
+	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(metrics->XgmiWidth);
+	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(metrics->XgmiBitrate);
+
+	gpu_metrics->firmware_timestamp = metrics->Timestamp;
+
+	*table = (void *)gpu_metrics;
+	kfree(metrics);
+
+	return sizeof(*gpu_metrics);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c3e0da680cf8..76cc827f128c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -515,7 +515,8 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 			       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
-		       max(gpu_metrcs_size, smu_v13_0_12_get_max_metrics_size()),
+		       max(gpu_metrcs_size,
+			    smu_v13_0_12_get_max_metrics_size()),
 		       PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
@@ -1145,6 +1146,9 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	if (ret)
 		return ret;
 
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+		return smu_v13_0_12_get_smu_metrics_data(smu, member, value);
+
 	/* For clocks with multiple instances, only report the first one */
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
@@ -2507,6 +2511,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		return ret;
 	}
 
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+		return smu_v13_0_12_get_gpu_metrics(smu, table);
+
 	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
 	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
 
-- 
2.46.0

