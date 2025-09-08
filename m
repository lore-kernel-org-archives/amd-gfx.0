Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636DACAC586
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 11:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8E610E4BF;
	Mon,  8 Sep 2025 11:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3zQNcEkN";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A1A10E4BD
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 11:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0E564y9LRwUDo7OGZb8oiFvhgKlsJzQD31VvAKPmLsLEEXRXyzCsDUbrKUYTFEIRPSRNRlABK6cmudbaCxP69MnXucdP29lT1vLiD/riS1IoBx5hH7ehBACI+D2gU1CKM/XtjwDgTXgjSvm7yBbt6I6SYWZz9/BW45nCONAGoLqWYPzjpCtRTSZsif4g2RebFwnbRv9My74zO5qbWJeAeVShJ8An/bf2MVs2kd5zwtaKmEO9MXdruYTkMAnxwkUqaV3+reLTNBM/QcYJC/ZnWbw5oSF+vcY/ugBAhYMwlPzWKWhjMr4CX5K0c5p6jHm+Cz7oh/ldpTssWyGpC8xBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGgMtzbEYd5AXUGnzDVWaLD/E5+WvA2xaI06PnSoiyc=;
 b=Olf6wKPbiP/4l4Fr1CaqcdAat6ffLW3ddhULNZQ75eh+qvQxc4KOwoSQeizcFGcgEmqQENIMcrPibGeHaaDoHOiOrsKYMKB8meRWxXs1Nk3/YSg6vBXzOvxZT7Z5XeUg1mvNxdpYu+lAVnvglU3vYpv/DsbzUaBzXqkuLn8vUWVm/8URepSTr/oxNKW4t8zJBBRDYd1bwgsIKE3x1SM689OoX+jAOqtd2GMelfTZO1d9lH02KLfVyOOvDxKyDgL1g/nZ9rVVqLnIRXbo6dlrTjpUhhuFzi9aVRxgdEMcgqj08DicGI6DseXxspg5BciJRMJTRJX2OqG4h5tY7C75vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGgMtzbEYd5AXUGnzDVWaLD/E5+WvA2xaI06PnSoiyc=;
 b=3zQNcEkNUZMq02dA1gOHHICmjmy2nV2vluFtj8/xsBsl347NNQOBWAefIm3D7GuQglE5HBmWSiBkGOxkyaBWbpHib1O24hc7e9tRE7nlCFv0oUcvbXq+lxdXxJlMFKpbi4urMgSwW1WiDtLXCequli2GaasGr8pxSANWSqadl2I=
Received: from BN8PR04CA0056.namprd04.prod.outlook.com (2603:10b6:408:d4::30)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:03:02 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::71) by BN8PR04CA0056.outlook.office365.com
 (2603:10b6:408:d4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:03:02 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:02:59 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2 4/7] drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.12
Date: Mon, 8 Sep 2025 16:31:15 +0530
Message-ID: <20250908110231.2888628-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908110231.2888628-1-lijo.lazar@amd.com>
References: <20250908110231.2888628-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 2623106b-56bb-474f-5eed-08ddeec747b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NYe1zXeK+Dnt/uT9rHDEWtVMP6Y8E0XXZyA4Wvfdse/WUz+38Fqho9hZ11Ad?=
 =?us-ascii?Q?cvGoSHGB5XY1raolCrOkxfYV0d2rgm8qL8GcX58JdtzjH9SyzdGTdMVfno8b?=
 =?us-ascii?Q?YXZXe/Mi+w4buH0eirFoUxX4AMFEaSRw0Gg2phO0yRlnf83jauttw8GO72/U?=
 =?us-ascii?Q?jZPZ5NxXssVZxpXLtUniVvTj2yyzbCV3AdYksikd84sYjk6KhgZSnlMcrpzQ?=
 =?us-ascii?Q?/LWXmlE4pwGQ6KXCJCkMtiggkSBvLcsPynRkh1Lf3Ly3qDBt/BJdH8vXXKk/?=
 =?us-ascii?Q?Nr2ZvtsArPq4qrgmzs0DKDFbWo++02cc8t7+11ynZPbKYoaDx21y4dkJx0uy?=
 =?us-ascii?Q?V3VvaKvSvdOOQcE5Lu62j4366DhKutNzEcQmikFygwD7A/VPbG6mMw7KOJg+?=
 =?us-ascii?Q?3nSn5pDnbydhlUd7T26paHO6xYvBECWSaVufbv4sXTWRL2p1h+2xVOjbq5Aw?=
 =?us-ascii?Q?azeDm8OJWKhlY8DBNwElPWW+n4H/b6o5ETx6WvcC576FcyUFEzCzvZqxk/HF?=
 =?us-ascii?Q?SXHasHCSXiXBM1poTSozCggFgASRzFpnVPb7ntQGMV74e/3FIjcw/BIx4cIR?=
 =?us-ascii?Q?SSDf5xZbp/eQD1XMEVn0BVeT+Pjl/eB/ys1gN/3t9gnOgdzTidXMnkEoVizY?=
 =?us-ascii?Q?2xIkGpgHTVzIOFVOFbVBQEfMt3D5idtg6lClEpjk5qhSkl35msotbJNefVKI?=
 =?us-ascii?Q?2I+o+C4GKJmshHtPtZhHAoeGuIoagVX+wRMeD07hHwj72vGikTKf+uuso21G?=
 =?us-ascii?Q?b8HL9R7bChNbAwJ7UUR32cHYwuhip5ncqv+u4lwrCvQDMCpHNYutFgFJminw?=
 =?us-ascii?Q?VerQ75zasq8YK+XsCALM6f9ZzeOcF60kbzoIGky1zvYND6YoITSgyhqfV7j6?=
 =?us-ascii?Q?nxxlo4ZUEJbuvT48ES5eTw7VfZqDoPVgNcTJc9WwQa83JMIfL65Jd3Zrxb/U?=
 =?us-ascii?Q?kZ2gBU5u99yitOHo9m4WL2sv+cXtEJq25CZZRK5RjhlkL1w4QJUDX9iXEMZS?=
 =?us-ascii?Q?6pFwspdSyPV+CQIG/4waUymBD+FTXwfZdkuNSbOJktSx1KeuszRM+NvbMkaJ?=
 =?us-ascii?Q?FPkXzgi1psh+C+nfQsBLA0mN0W683qO01qVjtNoPh6UDPBP4PK5wLPKQmTwY?=
 =?us-ascii?Q?YaQpomOdjR2Na2R7Oj/53S7LBPkG4pyRrRCn2Vs3Ala1u3mq4UEAdcMYTySE?=
 =?us-ascii?Q?xe7M7ymFnft1yDNQLgzNBzZVqGC1vr4ytVd/n0kA49CMnzrPeCj4Rq+0lZTs?=
 =?us-ascii?Q?JXTzJND6NyWOMM2RPnY4qj4G03Yoq31DQY890ronIeRkQKRgIw6bmNmzGSIw?=
 =?us-ascii?Q?f230hXxvEh2iUbzc9aUPhzO5jGPhwoTK4bgm5Ms65j0mnlQLHpcnCkQEuATd?=
 =?us-ascii?Q?MnHiC8yDKgHV6Untji6ZlMUQECE4a1ImSYJscXfcdVmKcODn7U3QyvNe5CDa?=
 =?us-ascii?Q?F9FRZqo56PaMDyYFTfmMOsazFKluCdZIA1FH6rtjYE7K3+aXxrrBxYw8hggZ?=
 =?us-ascii?Q?L6hv9MFoFhktRIwI8RvxODPV9YVl+X9XqBBr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:03:02.4963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2623106b-56bb-474f-5eed-08ddeec747b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
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

