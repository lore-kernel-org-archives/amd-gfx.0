Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EC5CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 05:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1C610E617;
	Tue,  9 Sep 2025 05:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="csdY/Xq4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6248010E614
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 05:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4YuNbWnVAS04bSABEFZpTdsMAkR/TITarkiqLKVIx5LtS61Dwe+l0vaQ+nxP1Uxl/uftw/IBfJhLDNNfwsSyGhx4F9GFWLhqdIuLe/DueSFFr3TBxgK6m3k3n0fjaiTqjwY5GNbkH17Stf8Q7OmRHB1JQK0Fx4BTrx2eexBZK5CFkiYFVnV/tDLtOIHRdp1ap7C9SIUv+9d4MDj3wzoy1o7ZgJYMd6/e6TaRDaqnQKKF+JBcTyneIvIDrvFw5Vptg0qB/WuqFhsSmJqqYQVvOC6Ww9tJjjhPiNC6G4Pl1nfF20oPdB4jsBd8AWWWJlpq2bxaal274HqzieRwZOJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGgMtzbEYd5AXUGnzDVWaLD/E5+WvA2xaI06PnSoiyc=;
 b=DzVpELEoSLK8KrHRTzZNDoEjI4nhJCgI3mPTLhQvqyRpn1f981H+xiE3HMkHuVqhx4Xzxw+7xBumCbye7At7k7R3kZjEd13F0Omv/kOZvqxxrgMdHgg0W4+GJw7GYjvQj65AT2QyJeC+y0dd/X8ZrP5N+FFiyelKap92qJpkvJxyJn71tKSfPIj7L0q3P+Vs6LNmPjvXLgGAhi+SDhvSj3uiKb6TokjVt3uRShLRcq9+Cq94sexxgCN27sCShXvMzbmcAd7dl7I15wO5aWAMQCBtXL9WET6TK7Knb0wcm5yi4Vmn6I69x+jp0m8/Y2XbCxb85/2cgfQnlQAFNyoVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGgMtzbEYd5AXUGnzDVWaLD/E5+WvA2xaI06PnSoiyc=;
 b=csdY/Xq4uqS2AimjK390f3dKEDNcEP9150ZAYPdBP8x/Gaz9rfeVguVTP7M+eYBIVRpt24VF207Dn7m8nBmWs3a6Aq2Wnvr5w1+TqC/AUaPmfk4lbWI3yDjxU147RWDGuGRYhQgVeSesrgp+YIfR4etRZKU4HWtQIRrh0uNbZ6k=
Received: from BN8PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:94::43)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 05:50:10 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:94:cafe::da) by BN8PR03CA0030.outlook.office365.com
 (2603:10b6:408:94::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 05:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 05:50:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 22:50:02 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v3 4/7] drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.12
Date: Tue, 9 Sep 2025 11:17:34 +0530
Message-ID: <20250909054933.2911159-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250909054933.2911159-1-lijo.lazar@amd.com>
References: <20250909054933.2911159-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: b7be7db9-9e36-465f-d33d-08ddef64bd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XbJJTKDUwj3twopbxuLsHrRXMI9CuAr7WS3IJN7Ar7R0FjgovDn3WzjUuo9V?=
 =?us-ascii?Q?ZKlOWMGm/y/+RLDz//tOZb0lK8O7q8eXC80MIbE8U8nuVb1wJDFzzhGG+qyy?=
 =?us-ascii?Q?534Ry3F6Rdqo8WD9Uz69qZzE+Wr8LvN4OSKaoXrrVkGIy7Dz9gcZUv7mIBvh?=
 =?us-ascii?Q?EqhbYmsQ7Sp/fTyrOnh+iYbt5zopTr3nYW8VjSb6GiFEyFxYS9kLIynbYWMl?=
 =?us-ascii?Q?W1Y2qL7l3BbCH7ntI5uLxI6p4RDhPKAmpW55BJMoDQVjI0b+dVnftnefWt5a?=
 =?us-ascii?Q?SuHOQtf5OwxyTu2+pz8yNEIDyFop+KOX8cn4qOa5kmssTGqu9dfOMhXIjYxs?=
 =?us-ascii?Q?CkGlMjOkYF8SSX0Q22w+FbK/o7pc4FaaCzuLvhQ8gs3J+uT/gXbx3BLx5tzT?=
 =?us-ascii?Q?tg7uRurw1eMBhGfkRBiQQbhY6WcUAamKCmar7namHIHLJYsmnpKfDShWVJac?=
 =?us-ascii?Q?BQBH6rn3jc5EOUMVnd1ge03t0xdOhQrf0DgRJiF2WAQsUd4lZ5PxnuFjGNMz?=
 =?us-ascii?Q?+C6ByYONBu6Lqc/K3ylEQds2FwrGa+FO70b9E3Yp3UU9raTnUvZK0+tylj2S?=
 =?us-ascii?Q?/4EjwJPeK4iYe4yiZ6lZtM6XHQPMgQ/scKjFHrKqGM9wX2bFaep21JwpLLaJ?=
 =?us-ascii?Q?mgQDPR7cMNDBb5xKboUNpfqKN4l9CgouQX4Ye4rPu4WntnMVX5Naexhja2by?=
 =?us-ascii?Q?ua/15qJdapaEkN9FG/FGSIaXKXSpmV6a03ENjzGoYXuNA6V9kc7Beoxe/z7s?=
 =?us-ascii?Q?+yUbYcqQak6oA1+C4XQbjDDNXMobyBppmjFRc9ojQ6X8TmXTjSo1UxxW4WAP?=
 =?us-ascii?Q?oBxHN1joEPpvAOU3SLKQNktJmKmuGapRaJtd9ErKTjec+0RoglLyJSwOsyjD?=
 =?us-ascii?Q?dzk1zXwwmG37bEHBsNGq41/UsM4Zpa4xHA4FP90okrYeu1cwr0OjWF78Tl5Q?=
 =?us-ascii?Q?mD2Krnwd+l2C4MA1dfA5YGXrPo7ZH7I3Crk5nbo+Z5gMiY45/t+ftV3oRRbQ?=
 =?us-ascii?Q?jxP8lKbZss7l5GqEanjQFdFu7BS55MZijPenjxbSZdh2tzVSYZajg9YYkIo8?=
 =?us-ascii?Q?fxNl22ZQdoBUgsHtJ2Sz88yk7d9YsAryCosCuWdmWeNUoITaknV4mxH4ODqb?=
 =?us-ascii?Q?uU+0n8+vQGeipH16NlGUeINZhjSeuVNBijWZv67IswuxgJonTVMO2QrdgfS+?=
 =?us-ascii?Q?jCmjKzfCoyTbVYqQhbgljRT7tYkzoWL/kolKwN69N9CZn6qlBjq/74TRvUIT?=
 =?us-ascii?Q?RWo1smOUOT5zc7j6cpep4CVgtqb8Z1KBaOEMirtPDtTbe3g9Q4uFvBQC+dzq?=
 =?us-ascii?Q?zokx/WeXey6o6q+TCVAyxx88nYJG5ci+usFIOUz6c9ueNM2OgBitUli567MN?=
 =?us-ascii?Q?DbBjsKeiuWNtjd+/5v1qcNbNNcraqQ5bKJ15VzylXATQ/j9U40mbo2UEqdIJ?=
 =?us-ascii?Q?CdAvlQ085qSwJ2H0bw+bQK02xwHY5uthjGDL6KdPUzo4/w28rPwThgbbiApv?=
 =?us-ascii?Q?4KlIvVfWRBDmcyP9Z5z2UfOwL/wM0cPQI08k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:50:10.2915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7be7db9-9e36-465f-d33d-08ddef64bd02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

Fill and publish GPU metrics in v1.9 format for SMUv13.0.12 SOCs

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Keep return type of smu_v13_0_12_get_gpu_metrics as void (Asad)

 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 89 ++++++++-----------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 25 +++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  4 +-
 3 files changed, 51 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 0bec12b348ce..09f1e4072db6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -58,7 +58,7 @@
 
 #define NUM_JPEG_RINGS_FW	10
 #define NUM_JPEG_RINGS_GPU_METRICS(gpu_metrics) \
-	(ARRAY_SIZE(gpu_metrics->xcp_stats[0].jpeg_busy) / 4)
+	(ARRAY_SIZE(gpu_metrics->jpeg_busy) / 4)
 
 const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] = {
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DATA_CALCULATIONS_BIT, 		FEATURE_DATA_CALCULATION),
@@ -724,22 +724,17 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp
 	return sizeof(*xcp_metrics);
 }
 
-ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void *smu_metrics)
+void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
+				  void *smu_metrics,
+				  struct smu_v13_0_6_gpu_metrics *gpu_metrics)
 {
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_8 *gpu_metrics =
-		(struct gpu_metrics_v1_8 *)smu_table->gpu_metrics_table;
-	int ret = 0, xcc_id, inst, i, j, k, idx;
 	struct amdgpu_device *adev = smu->adev;
+	int ret = 0, xcc_id, inst, i, j;
 	u8 num_jpeg_rings_gpu_metrics;
 	MetricsTable_t *metrics;
-	struct amdgpu_xcp *xcp;
-	u32 inst_mask;
 
 	metrics = (MetricsTable_t *)smu_metrics;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 8);
-
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(metrics->MaxSocketTemperature);
 	/* Individual HBM stack temperature is not reported */
@@ -829,57 +824,47 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void
 			gpu_metrics->xgmi_link_status[j] = ret;
 	}
 
-	gpu_metrics->num_partition = adev->xcp_mgr->num_xcps;
-
 	num_jpeg_rings_gpu_metrics = NUM_JPEG_RINGS_GPU_METRICS(gpu_metrics);
-	for_each_xcp(adev->xcp_mgr, xcp, i) {
-		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
-		idx = 0;
-		for_each_inst(k, inst_mask) {
-			/* Both JPEG and VCN has same instances */
-			inst = GET_INST(VCN, k);
-
-			for (j = 0; j < num_jpeg_rings_gpu_metrics; ++j) {
-				gpu_metrics->xcp_stats[i].jpeg_busy
-					[(idx * num_jpeg_rings_gpu_metrics) + j] =
-					SMUQ10_ROUND(metrics->JpegBusy
-							[(inst * NUM_JPEG_RINGS_FW) + j]);
-			}
-			gpu_metrics->xcp_stats[i].vcn_busy[idx] =
-			       SMUQ10_ROUND(metrics->VcnBusy[inst]);
-			idx++;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		inst = GET_INST(VCN, i);
+
+		for (j = 0; j < num_jpeg_rings_gpu_metrics; ++j) {
+			gpu_metrics->jpeg_busy[(i * num_jpeg_rings_gpu_metrics) +
+					       j] =
+				SMUQ10_ROUND(
+					metrics->JpegBusy[(inst *
+							   NUM_JPEG_RINGS_FW) +
+							  j]);
 		}
+		gpu_metrics->vcn_busy[i] = SMUQ10_ROUND(metrics->VcnBusy[inst]);
+	}
 
-		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
-		idx = 0;
-		for_each_inst(k, inst_mask) {
-			inst = GET_INST(GC, k);
-			gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =
-				SMUQ10_ROUND(metrics->GfxBusy[inst]);
-			gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
-				SMUQ10_ROUND(metrics->GfxBusyAcc[inst]);
-			if (smu_v13_0_6_cap_supported(smu, SMU_CAP(HST_LIMIT_METRICS))) {
-				gpu_metrics->xcp_stats[i].gfx_below_host_limit_ppt_acc[idx] =
-					SMUQ10_ROUND(metrics->GfxclkBelowHostLimitPptAcc[inst]);
-				gpu_metrics->xcp_stats[i].gfx_below_host_limit_thm_acc[idx] =
-					SMUQ10_ROUND(metrics->GfxclkBelowHostLimitThmAcc[inst]);
-				gpu_metrics->xcp_stats[i].gfx_low_utilization_acc[idx] =
-					SMUQ10_ROUND(metrics->GfxclkLowUtilizationAcc[inst]);
-				gpu_metrics->xcp_stats[i].gfx_below_host_limit_total_acc[idx] =
-					SMUQ10_ROUND(metrics->GfxclkBelowHostLimitTotalAcc[inst]);
-			}
-			idx++;
-		}
+	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); ++i) {
+		inst = GET_INST(GC, i);
+		gpu_metrics->gfx_busy_inst[i] =
+			SMUQ10_ROUND(metrics->GfxBusy[inst]);
+		gpu_metrics->gfx_busy_acc[i] =
+			SMUQ10_ROUND(metrics->GfxBusyAcc[inst]);
+		if (smu_v13_0_6_cap_supported(smu,
+					      SMU_CAP(HST_LIMIT_METRICS))) {
+			gpu_metrics
+				->gfx_below_host_limit_ppt_acc[i] = SMUQ10_ROUND(
+				metrics->GfxclkBelowHostLimitPptAcc[inst]);
+			gpu_metrics
+				->gfx_below_host_limit_thm_acc[i] = SMUQ10_ROUND(
+				metrics->GfxclkBelowHostLimitThmAcc[inst]);
+			gpu_metrics->gfx_low_utilization_acc[i] = SMUQ10_ROUND(
+				metrics->GfxclkLowUtilizationAcc[inst]);
+			gpu_metrics->gfx_below_host_limit_total_acc
+				[i] = SMUQ10_ROUND(
+				metrics->GfxclkBelowHostLimitTotalAcc[inst]);
+		};
 	}
 
 	gpu_metrics->xgmi_link_width = metrics->XgmiWidth;
 	gpu_metrics->xgmi_link_speed = metrics->XgmiBitrate;
 
 	gpu_metrics->firmware_timestamp = metrics->Timestamp;
-
-	*table = (void *)gpu_metrics;
-
-	return sizeof(*gpu_metrics);
 }
 
 const struct smu_temp_funcs smu_v13_0_12_temp_funcs = {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 654612623341..8eaa81dd7f0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -538,7 +538,6 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
-	void *gpu_metrics_table __free(kfree) = NULL;
 	struct smu_v13_0_6_gpu_metrics *gpu_metrics;
 	void *driver_pptable __free(kfree) = NULL;
 	void *metrics_table __free(kfree) = NULL;
@@ -569,12 +568,6 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_8);
-	gpu_metrics_table =
-		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
-	if (!gpu_metrics_table)
-		return -ENOMEM;
-
 	driver_pptable = kzalloc(sizeof(struct PPTable_t), GFP_KERNEL);
 	if (!driver_pptable)
 		return -ENOMEM;
@@ -597,7 +590,6 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		}
 	}
 
-	smu_table->gpu_metrics_table = no_free_ptr(gpu_metrics_table);
 	smu_table->metrics_table = no_free_ptr(metrics_table);
 	smu_table->driver_pptable = no_free_ptr(driver_pptable);
 
@@ -2766,16 +2758,20 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	if (ret)
 		return ret;
 
-	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
-		    IP_VERSION(13, 0, 12) &&
-	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
-		return smu_v13_0_12_get_gpu_metrics(smu, table, metrics_v0);
-
-	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
 	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
 	gpu_metrics = (struct smu_v13_0_6_gpu_metrics
 			       *)(tables[SMU_TABLE_SMU_METRICS].cache.buffer);
 
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
+		smu_v13_0_12_get_gpu_metrics(smu, table, metrics_v0,
+					     gpu_metrics);
+		goto fill;
+	}
+
+	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
+	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
+
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version));
 	/* Individual HBM stack temperature is not reported */
@@ -2948,6 +2944,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, version);
 
+fill:
 	*table = tables[SMU_TABLE_SMU_METRICS].cache.buffer;
 
 	return sizeof(*gpu_metrics);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 0e336cd5e8cc..1b449ab2d89f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -93,7 +93,6 @@ size_t smu_v13_0_12_get_system_metrics_size(void);
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
 int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 				      MetricsMember_t member, uint32_t *value);
-ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void *smu_metrics);
 ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu,
 				     struct amdgpu_xcp *xcp, void *table,
 				     void *smu_metrics);
@@ -210,6 +209,9 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 		  SMU_13_0_6_MAX_XCC)
 
 DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_gpu_metrics, SMU_13_0_6_METRICS_FIELDS);
+void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
+				  void *smu_metrics,
+				  struct smu_v13_0_6_gpu_metrics *gpu_metrics);
 
 #endif /* SWSMU_CODE_LAYER_L2 */
 
-- 
2.49.0

