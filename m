Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A508EEB59B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 12:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAAC110EB74;
	Thu, 12 Sep 2024 12:00:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vFLuMEsC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C84F10EB65
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 12:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnCGpqZmi+RrLhqCHVU2aqKq61igo+hiYuiG2VB9JO8uH3jGB83Tx21NAp7SNJjJcXc3RMvSu3UbKt74tJ6Wl/V+A3xdWIqwHUXMeDJHv8U0gA94I1KRNaJuSpm8bNjkOK/umbjXM1E/RKFyYmMNwf+nqItBWxPOPJzD8U+CWB/1VZ4p19x3FV1yyBAi+tIPbqoQHjFGd7n1OwoLwITbIW8B6zvLWqQ7CzHbDTn8t6TQWYoMnk0wNWjSiQq0QVFKXZ999nhpwgPMJdvLpK2kvu2ZKPDfeYLtDY1zCH3Dhhyd6T9l2agrtNbit4qShbEIEcY60BdMOA6QOkcx06W7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsK4G0gdWdkJCCbZl47B13EHURdo+q+9l4+wFAezsNQ=;
 b=tIJ1Q9WEc/9gg1zLkPf4hD84ZtK62RP7HWG3Xe+m53ckTsWh9zhg9b/qp/RE1D14+8EadcEfNJXfLgNnqTCmF0vBwPqWqnHe3K8KV/AZ3D2H53dPHUFMiHaxE+F5e7/5rhgXXuTjzXGEmiuCeZJ8rO+8tF3EULTM8hKvhYcDqzUT/AyUYsWyMtvM2kp9JruHkG7AgPOJpFIECjJESHercqD8ZjheIcAkmTWejVxquYsd4Y6ldA6jVabyYzlLaTDxNRION0svbYmxMb86KVsU/Ka0GoBpufjR3veqHY+G4o7R7MA2Jos78PnOzCfXrk/oGJVPiyqJwiFFG2U2Ut11ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsK4G0gdWdkJCCbZl47B13EHURdo+q+9l4+wFAezsNQ=;
 b=vFLuMEsC4nuJXjzRYmU1lLyUVTURgJ/Ovl2IQhn8DgXJhV232OmKGT0ZWMG/MIuZ2ElvxJbMKuGrwOm2cBT0BlFYrmpXvP07WgJ2wRx11YZRx9S4tJLooBW8+uC9Sh99v9Ko/KEDj793JhriGl1CakAw+O8HaBf21KrK+Ot0tzs=
Received: from CH2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:610:5a::31)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 12:00:22 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::48) by CH2PR08CA0021.outlook.office365.com
 (2603:10b6:610:5a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 12:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 12:00:21 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 07:00:18 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 5/5] drm/amd/pm: Use metrics 1_6
Date: Thu, 12 Sep 2024 19:59:47 +0800
Message-ID: <20240912115947.2208807-5-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912115947.2208807-1-asad.kamal@amd.com>
References: <20240912115947.2208807-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb8eea0-f63c-4cca-34d0-08dcd3227aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R3yxE1JqN0JAEsaXlseQjuXLAdZ3bYiSlrgdpDnYZfdA1/VzhWrU+Zc+2CRR?=
 =?us-ascii?Q?QlYfA/J7EjTKyrKKg/lb/Si9F6Swzfpkq0w/0Q6rpjCSduJmOZeMKT2QXvhL?=
 =?us-ascii?Q?udNekgUb4zNOfooGIRSUolie4n2FDNeruqATFPgsHTixc4G506UiXUjSkJbD?=
 =?us-ascii?Q?8cxxvklaiG6L6oM/oir6r9DSSH+tzVboKM5qEQXD4PBOPJVFHbxegDiXCOBG?=
 =?us-ascii?Q?6zoEB4L0CiYya4eu5nGDIiQT11f5Fv9if/hhlR+eE0aI9tR07PqB8Nduab/f?=
 =?us-ascii?Q?dOkBFzUKmSfTa4TKpwgXyQdekHcWnNTfxRZFxOLtpMmZnhmI3YhRXWoFjBbG?=
 =?us-ascii?Q?2fZV/DHIOSmsp76AJ+f62aUuKRBWRiHMlwlbTxBtkft5lDpoUQq1h9wsReiL?=
 =?us-ascii?Q?iZtGS+x3dZRjAml+bd7yjGmGOl2QJpjP5l33LebLJ+bnMwtw2SL4L44BDps/?=
 =?us-ascii?Q?h5x1Lu9eoQiZewlYwn8ifsWMn5iT35DgK5Ammq7jAKPVtXGl9ADq0s1XR0Wm?=
 =?us-ascii?Q?7P3xEsjVei+zDWJu0MXhdkxuEYYFGtJcC3bPjkbkFi25t7E5rVqfiU0LZWOK?=
 =?us-ascii?Q?oEmEvBPriSjo6ncQjN1XH7V18qrE4pUKh/nj/y/g0Ae63I5/d7iz9fwmXfw0?=
 =?us-ascii?Q?xw9p/tRTw1kdOVNGDL9AASk5Rxw2oHVgksG4DnXNUExYsOvcAXHTU0yD7V1N?=
 =?us-ascii?Q?OHIspDos5NyEj69xjdyNcYe2Askm0Cb6Js198aW3/iAjBlIFflRJDfJvUYTv?=
 =?us-ascii?Q?WGHeX/h4U9ggMwk7ixbjCeM/wEQsj11capOGDXLqoG3Z7JEBg+ve9pNH9mJF?=
 =?us-ascii?Q?Q6UMbKwQ6IcvZlyrnYYziaz+BPP5xWx+2pWZxaClQWUxz9nqfcpGIKyP5Djv?=
 =?us-ascii?Q?5bO6Wpg/3Ap7jN4cpXTFyqVM5rKMb64dtFvjDEufc7H6dzQDo7T5Sy2iuCy/?=
 =?us-ascii?Q?EB4Gw1O7XhW3WC9O4htt1EBFnfwqgf7YJzo9ueI+GyyTrFHeWETsUijCUpHN?=
 =?us-ascii?Q?JwRQeSIPNSNr7WeNdBZljDXFfX9t+Vc7OpKLc/qvXIaIK5s0YOlCBbHTTmyf?=
 =?us-ascii?Q?2/CBQbd5sfSBfoKybDpJYat/YHRDF3bxY42JP9YNx4uGHce2kV4lI74BEWvt?=
 =?us-ascii?Q?dbTwUWcVx8f29H/BWE39vTt9vgbqGMykxdy5lSTyTD8b2HsoL+xqH1mU0lCb?=
 =?us-ascii?Q?S3LlxFGI64gYjm7nsf1xVQ6ci6g9RNNooQB0JDiqiZKP3xniVLInF3cIABrT?=
 =?us-ascii?Q?gHWxH/iPpn5QsfbrNOeTjO++apT8IxJ7aOSoJMrBKrf0G7OQDeoBv5Ez06x3?=
 =?us-ascii?Q?vjKLAlKSXHC2+iZe82zWF0oexRY88+gwtMbgcfKzH79XTgkPbVxhkdvAB3DD?=
 =?us-ascii?Q?vjylC1JvpFaBBvZlM9htCyjYiYTuGtgLU0t1jvSKUrfz24agp6o6hMYk4qkK?=
 =?us-ascii?Q?v1bicWMZ9FQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 12:00:21.8957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb8eea0-f63c-4cca-34d0-08dcd3227aa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
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

Use metrics 1_6 to report activities per partition

v2: Use separate per instance for different platforms, shared
vcn handled by other fix

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 78 ++++++++++++++-----
 1 file changed, 60 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ee178914ca53..cd739f627df0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -358,7 +358,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_5);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_6);
 	smu_table->gpu_metrics_table =
 		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
@@ -2302,15 +2302,18 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
 {
+	bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_inst;
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_5 *gpu_metrics =
-		(struct gpu_metrics_v1_5 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_6 *gpu_metrics =
+		(struct gpu_metrics_v1_6 *)smu_table->gpu_metrics_table;
 	bool flag = smu_v13_0_6_is_unified_metrics(smu);
+	int ret = 0, xcc_id, inst, i, j, k, idx;
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0, xcc_id, inst, i, j;
 	MetricsTableX_t *metrics_x;
 	MetricsTableA_t *metrics_a;
+	struct amdgpu_xcp *xcp;
 	u16 link_width_level;
+	u32 inst_mask;
 
 	metrics_x = kzalloc(max(sizeof(MetricsTableX_t), sizeof(MetricsTableA_t)), GFP_KERNEL);
 	ret = smu_v13_0_6_get_metrics_table(smu, metrics_x, true);
@@ -2321,7 +2324,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	metrics_a = (MetricsTableA_t *)metrics_x;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 5);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 6);
 
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, flag));
@@ -2363,8 +2366,15 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, flag));
 
-	/* Throttle status is not reported through metrics now */
-	gpu_metrics->throttle_status = 0;
+	/* Total accumulated cycle counter */
+	gpu_metrics->accumulation_counter = GET_METRIC_FIELD(AccumulationCounter, flag);
+
+	/* Accumulated throttler residencies */
+	gpu_metrics->prochot_residency_acc = GET_METRIC_FIELD(ProchotResidencyAcc, flag);
+	gpu_metrics->ppt_residency_acc = GET_METRIC_FIELD(PptResidencyAcc, flag);
+	gpu_metrics->socket_thm_residency_acc = GET_METRIC_FIELD(SocketThmResidencyAcc, flag);
+	gpu_metrics->vr_thm_residency_acc = GET_METRIC_FIELD(VrThmResidencyAcc, flag);
+	gpu_metrics->hbm_thm_residency_acc = GET_METRIC_FIELD(HbmThmResidencyAcc, flag);
 
 	/* Clock Lock Status. Each bit corresponds to each GFXCLK instance */
 	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak, flag) >> GET_INST(GC, 0);
@@ -2419,19 +2429,51 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc, flag)[i]);
 	}
 
-	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-		inst = GET_INST(JPEG, i);
-		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			gpu_metrics->jpeg_activity[(i * adev->jpeg.num_jpeg_rings) + j] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy, flag)
-				[(inst * adev->jpeg.num_jpeg_rings) + j]);
+	gpu_metrics->num_partition = adev->xcp_mgr->num_xcps;
+
+	apu_per_inst = (adev->flags & AMD_IS_APU) && (smu->smc_fw_version >= 0x04556A00);
+	smu_13_0_6_per_inst = !(adev->flags & AMD_IS_APU) &&
+				(amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
+				 == IP_VERSION(13, 0, 6)) &&
+				(smu->smc_fw_version >= 0x556F00);
+	smu_13_0_14_per_inst = !(adev->flags & AMD_IS_APU) &&
+				(amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
+				 == IP_VERSION(13, 0, 14)) &&
+				(smu->smc_fw_version >= 0x05550B00);
+
+	per_inst = apu_per_inst || smu_13_0_6_per_inst || smu_13_0_14_per_inst;
+
+	for_each_xcp(adev->xcp_mgr, xcp, i) {
+		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
+		idx = 0;
+		for_each_inst(k, inst_mask) {
+			/* Both JPEG and VCN has same instances */
+			inst = GET_INST(VCN, k);
+
+			for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+				gpu_metrics->xcp_stats[i].jpeg_busy
+					[(idx * adev->jpeg.num_jpeg_rings) + j] =
+					SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy, flag)
+							[(inst * adev->jpeg.num_jpeg_rings) + j]);
+			}
+			gpu_metrics->xcp_stats[i].vcn_busy[idx] =
+			       SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, flag)[inst]);
+			idx++;
+
 		}
-	}
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		inst = GET_INST(VCN, i);
-		gpu_metrics->vcn_activity[i] =
-			SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, flag)[inst]);
+		if (per_inst) {
+			amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
+			idx = 0;
+			for_each_inst(k, inst_mask) {
+				inst = GET_INST(GC, k);
+				gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =
+					SMUQ10_ROUND(metrics_x->GfxBusy[inst]);
+				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
+					SMUQ10_ROUND(metrics_x->GfxBusyAcc[inst]);
+				idx++;
+			}
+		}
 	}
 
 	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth, flag));
-- 
2.46.0

