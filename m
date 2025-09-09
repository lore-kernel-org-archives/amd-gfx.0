Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF558CAC589
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 05:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 347B210E618;
	Tue,  9 Sep 2025 05:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BMjKGrZS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE6410E616
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 05:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzje7scV3m1koUab9V4q/RparTH0NJ3R2jzNAr61mT6pj51zmZRVMUzZYR145L0Rn8A1kD4bTzeb30MokgY8OFbN7GH78KRyDl5lM2g+4Q47lkCFfZjoDn33SD75uZvavEX3vfHnVDquGaldA9x7EBfXE/ErJTIJRcUyrOIdKOBxoNmhjLYQf2oG5uG1f4YOZmi3Qvw0aG4iImD14D9JbA6TKM2pPld/9uYVwa1HmaO5ZTjlUNq0o/M8iguu9rk61DfHb2+s5u5uED6cHJwjXTIo+CQGpxik7/n3ybb/yIPr7HKQXh7EInArP2il6YLui0stE8mNfUtxCF+qeUg+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw0JscaBD4wV2wmcKYOVMAj9bmNVnmEu7Ayk+0E1ZPI=;
 b=tkJpEclIO5Hjeh+BU6Ea1Wdm8jKyh8K6lC73JrFBorJDmkKiYp40YHRyR6sOSjsXIqDNWKNYdceTOpvedslsI+WTxZCLlLaB616td2s3SrBf7eMxOA2kfWMER0/2IWNVBFzQ2hUmC7VCMiP9bQ9eUzOujosK6IEqJ6Pkg6weFfUo0hblX1EUvmy3588T3I00xsSd0c7ASS5PeVbSN81bMUTr5522+EVWV+1C2OhVJgzC47dZzySx+VBKJnHfNrXeYJMOVJB37AlK5/+p2nG0PS+5pX4p1RdvkXVfGo5nXGKP3CpxKhX+IdrUhgaqnCWubnAWAt2MvN3CyA/4Ax8o7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw0JscaBD4wV2wmcKYOVMAj9bmNVnmEu7Ayk+0E1ZPI=;
 b=BMjKGrZSOR+8cOuaQRzCcN6J6blpN9HZEI0p97atMJzI7z6eV6dNBO9Om+QdeOXE+vAhHrhAoirZfUgOVzik3fywhAjlxDpBlMZ1GcWfsmakoe5Ja2/QHzonvMuOHm+IoJocLkg1QfpRx8vyMuJPbmiF2XRTeHKazznOVOuFTTg=
Received: from MN2PR08CA0007.namprd08.prod.outlook.com (2603:10b6:208:239::12)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 05:50:09 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::a7) by MN2PR08CA0007.outlook.office365.com
 (2603:10b6:208:239::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 05:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 05:50:08 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 22:50:00 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v3 3/7] drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.6
Date: Tue, 9 Sep 2025 11:17:33 +0530
Message-ID: <20250909054933.2911159-4-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 0778f914-0984-4bfd-a920-08ddef64bc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AWx78+GYLApnHgTEzCXyLQxyfWGi3NFUJX9V1PcHT2Po7q6SSERCtDliPwma?=
 =?us-ascii?Q?f30Kl+6Atih4Nm8QyEW7iFfDP/bNaRm18u5bsGiMyG2y6QpZ80ytopmnTbev?=
 =?us-ascii?Q?m2m0zGWAzd2xG+oZ18M43SbZyFkGNXR9UfNAWzuNuIfwlkQd0W8nqbzHwkWM?=
 =?us-ascii?Q?sDjZdO+8QaasulVWRuVXTP4K/nVaIHcEUDiOUDlaNtJayiaVgLshivQq7kyD?=
 =?us-ascii?Q?Ad5DaAH0MK6eKI/rN3agwOVkswkYW6kfCSNZDt2H2hW42hDdFbaOeCFdQWUF?=
 =?us-ascii?Q?TJP0l4CkezzPyF5+XeC5yaG+d2dyr3NNuwUqGs+y3vs1hgf3BYdN+dzXfdX4?=
 =?us-ascii?Q?831GfX0wMuLhekCPNSbdOMzVmZ9gtfr3LoDRZpZ0tjW0w3Az39O4t8fJHN5f?=
 =?us-ascii?Q?NEcS5ddF+gnhwFYyFl3F2h96mlk9lFx0W+01uviAbkrWdHyNiPDoCXqy98n9?=
 =?us-ascii?Q?Zew/S+aVhnMJOO7DX0MK2HoGidwziCvIKBhlx4EoY3WFVnEpGMfFKb8d5HUx?=
 =?us-ascii?Q?8u/FVUP9SqYQyEhqa05RTA1lvWKW+5aivsAk8U/qzl83IysKLX2zzlEj3+5W?=
 =?us-ascii?Q?c0ZODvmEDdTRSdeBlpg4puhYTef5yIlSLcIb0F/ZUxmnFr+MV/myQwqLqI/m?=
 =?us-ascii?Q?afP5Pyejjn2G4xYNb3b8X0OMskMRFCk66K0ZcA/U2cG/PhuSKlsa6VIl4d58?=
 =?us-ascii?Q?P9vxDUxd6sz+f0z+aar47Tbb/6cZQeCJdceJrotiAjNod8LYQeW+uO80hZj/?=
 =?us-ascii?Q?l2SOAXE3jrpCw/0W6xGaJ7fQozMCe02arXhJB284fUCMBLkbDgfFxP3lXPBy?=
 =?us-ascii?Q?pQB3PsUr+sNitZ73APoVLtFEO8GSZ4DJKIkkXjiAH49rKlPDnY3SM9NUW9bi?=
 =?us-ascii?Q?qe1V6IUwV5AfzELeyMZjnvRBiXed6VBVeu9tEh1ZFcMEs2OLI9F4Wlqc2LAa?=
 =?us-ascii?Q?qLVVD4EJIiu1ayHHNWhd2K3/gJ8JMxnSd+s/N6s7h7rO8IF18ObEPRjH11C2?=
 =?us-ascii?Q?ayMM73tShEUb7RTnrinmut1/Ig8Q0C9cS3FIFX9QiV3cTMKk31ric6pBir8w?=
 =?us-ascii?Q?gIMVTF5vpiKRCHcwDWKvKGj7JFSaz60wgSSFu946HwjVrwAMmAE1+W08u9QH?=
 =?us-ascii?Q?CiamnRlPJ/QHkQDmOZ+UCNbf7nDoGTHQwbqduFybBoAcsX6fdnBiH4Torb6/?=
 =?us-ascii?Q?6KzTr3jCsWWHs+FWXL1ZF5EKbqMLKo/f6UVX00T9O/wdppv2CCpAGRbuH5sR?=
 =?us-ascii?Q?x4mF6SbXQb9h/Ys/+ebcB9RPPcsqmzSX6xk41jGc/VLK+6pWi0V+H9F/9ihP?=
 =?us-ascii?Q?YaTnYAIg4s8ddJ5q3DipkZYHTx9PscxMEXK9jXrZPPVhk7AvLHz8OkMfIRnQ?=
 =?us-ascii?Q?1r/Lt+7w7CpJRsS+BsN94oGySGlYCDrucU+wMeWn+sv/DO7WQn0ItrVD8XAN?=
 =?us-ascii?Q?Zad6iJdAeJ/EAIIkrHBBvqbOsnMsIgIe1zt37gTY2gieFQ/lQY4xe4iSsslM?=
 =?us-ascii?Q?WvoppDPO78DgiubnpavXtOcn6JcbjhMDIFkg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:50:08.6504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0778f914-0984-4bfd-a920-08ddef64bc08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
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

Fill and publish GPU metrics in v1.9 format for SMUv13.0.6 SOCs

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 113 +++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 118 ++++++++++++++++++
 2 files changed, 177 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ebee659f8a1c..654612623341 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -539,6 +539,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
 	void *gpu_metrics_table __free(kfree) = NULL;
+	struct smu_v13_0_6_gpu_metrics *gpu_metrics;
 	void *driver_pptable __free(kfree) = NULL;
 	void *metrics_table __free(kfree) = NULL;
 	struct amdgpu_device *adev = smu->adev;
@@ -578,11 +579,22 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 	if (!driver_pptable)
 		return -ENOMEM;
 
+	ret = smu_table_cache_init(smu, SMU_TABLE_SMU_METRICS,
+				   sizeof(struct smu_v13_0_6_gpu_metrics), 1);
+	if (ret)
+		return ret;
+
+	gpu_metrics = (struct smu_v13_0_6_gpu_metrics
+			       *)(tables[SMU_TABLE_SMU_METRICS].cache.buffer);
+
+	smu_v13_0_6_gpu_metrics_init(gpu_metrics, 1, 9);
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
 	    IP_VERSION(13, 0, 12)) {
 		ret = smu_v13_0_12_tables_init(smu);
-		if (ret)
+		if (ret) {
+			smu_table_cache_fini(smu, SMU_TABLE_SMU_METRICS);
 			return ret;
+		}
 	}
 
 	smu_table->gpu_metrics_table = no_free_ptr(gpu_metrics_table);
@@ -721,6 +733,7 @@ static int smu_v13_0_6_fini_smc_tables(struct smu_context *smu)
 {
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
 		smu_v13_0_12_tables_fini(smu);
+	smu_table_cache_fini(smu, SMU_TABLE_SMU_METRICS);
 	return smu_v13_0_fini_smc_tables(smu);
 }
 
@@ -2736,18 +2749,16 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_8 *gpu_metrics =
-		(struct gpu_metrics_v1_8 *)smu_table->gpu_metrics_table;
+	struct smu_table *tables = smu_table->tables;
+	struct smu_v13_0_6_gpu_metrics *gpu_metrics;
 	int version = smu_v13_0_6_get_metrics_version(smu);
 	MetricsTableV0_t *metrics_v0 __free(kfree) = NULL;
-	int ret = 0, xcc_id, inst, i, j, k, idx;
 	struct amdgpu_device *adev = smu->adev;
+	int ret = 0, xcc_id, inst, i, j;
 	MetricsTableV1_t *metrics_v1;
 	MetricsTableV2_t *metrics_v2;
-	struct amdgpu_xcp *xcp;
 	u16 link_width_level;
 	u8 num_jpeg_rings;
-	u32 inst_mask;
 	bool per_inst;
 
 	metrics_v0 = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
@@ -2762,8 +2773,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
 	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
-
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 8);
+	gpu_metrics = (struct smu_v13_0_6_gpu_metrics
+			       *)(tables[SMU_TABLE_SMU_METRICS].cache.buffer);
 
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version));
@@ -2885,55 +2896,49 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 			gpu_metrics->xgmi_link_status[j] = ret;
 	}
 
-	gpu_metrics->num_partition = adev->xcp_mgr->num_xcps;
-
 	per_inst = smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METRICS));
 
 	num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS_4_0_3;
-	for_each_xcp(adev->xcp_mgr, xcp, i) {
-		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
-		idx = 0;
-		for_each_inst(k, inst_mask) {
-			/* Both JPEG and VCN has same instances */
-			inst = GET_INST(VCN, k);
-
-			for (j = 0; j < num_jpeg_rings; ++j) {
-				gpu_metrics->xcp_stats[i].jpeg_busy
-					[(idx * num_jpeg_rings) + j] =
-					SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy, version)
-							[(inst * num_jpeg_rings) + j]);
-			}
-			gpu_metrics->xcp_stats[i].vcn_busy[idx] =
-			       SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, version)[inst]);
-			idx++;
-
-		}
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		inst = GET_INST(JPEG, i);
+		for (j = 0; j < num_jpeg_rings; ++j)
+			gpu_metrics->jpeg_busy[(i * num_jpeg_rings) + j] =
+				SMUQ10_ROUND(GET_METRIC_FIELD(
+					JpegBusy,
+					version)[(inst * num_jpeg_rings) + j]);
+	}
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		inst = GET_INST(VCN, i);
+		gpu_metrics->vcn_busy[i] =
+			SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, version)[inst]);
+	}
 
-		if (per_inst) {
-			amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
-			idx = 0;
-			for_each_inst(k, inst_mask) {
-				inst = GET_INST(GC, k);
-				gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =
-					SMUQ10_ROUND(GET_GPU_METRIC_FIELD(GfxBusy, version)[inst]);
-				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
-					SMUQ10_ROUND(GET_GPU_METRIC_FIELD(GfxBusyAcc,
-									  version)[inst]);
-				if (smu_v13_0_6_cap_supported(smu, SMU_CAP(HST_LIMIT_METRICS))) {
-					gpu_metrics->xcp_stats[i].gfx_below_host_limit_ppt_acc[idx] =
-						SMUQ10_ROUND
-						(metrics_v0->GfxclkBelowHostLimitPptAcc[inst]);
-					gpu_metrics->xcp_stats[i].gfx_below_host_limit_thm_acc[idx] =
-						SMUQ10_ROUND
-						(metrics_v0->GfxclkBelowHostLimitThmAcc[inst]);
-					gpu_metrics->xcp_stats[i].gfx_low_utilization_acc[idx] =
-						SMUQ10_ROUND
-						(metrics_v0->GfxclkLowUtilizationAcc[inst]);
-					gpu_metrics->xcp_stats[i].gfx_below_host_limit_total_acc[idx] =
-						SMUQ10_ROUND
-						(metrics_v0->GfxclkBelowHostLimitTotalAcc[inst]);
-				}
-				idx++;
+	if (per_inst) {
+		for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); ++i) {
+			inst = GET_INST(GC, i);
+			gpu_metrics->gfx_busy_inst[i] = SMUQ10_ROUND(
+				GET_GPU_METRIC_FIELD(GfxBusy, version)[inst]);
+			gpu_metrics->gfx_busy_acc[i] = SMUQ10_ROUND(
+				GET_GPU_METRIC_FIELD(GfxBusyAcc,
+						     version)[inst]);
+			if (smu_v13_0_6_cap_supported(
+				    smu, SMU_CAP(HST_LIMIT_METRICS))) {
+				gpu_metrics->gfx_below_host_limit_ppt_acc
+					[i] = SMUQ10_ROUND(
+					metrics_v0->GfxclkBelowHostLimitPptAcc
+						[inst]);
+				gpu_metrics->gfx_below_host_limit_thm_acc
+					[i] = SMUQ10_ROUND(
+					metrics_v0->GfxclkBelowHostLimitThmAcc
+						[inst]);
+				gpu_metrics->gfx_low_utilization_acc
+					[i] = SMUQ10_ROUND(
+					metrics_v0
+						->GfxclkLowUtilizationAcc[inst]);
+				gpu_metrics->gfx_below_host_limit_total_acc
+					[i] = SMUQ10_ROUND(
+					metrics_v0->GfxclkBelowHostLimitTotalAcc
+						[inst]);
 			}
 		}
 	}
@@ -2943,7 +2948,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, version);
 
-	*table = (void *)gpu_metrics;
+	*table = tables[SMU_TABLE_SMU_METRICS].cache.buffer;
 
 	return sizeof(*gpu_metrics);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index aae9a546a67e..0e336cd5e8cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -73,6 +73,13 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(ALL),
 };
 
+#define SMU_13_0_6_NUM_XGMI_LINKS 8
+#define SMU_13_0_6_MAX_GFX_CLKS 8
+#define SMU_13_0_6_MAX_CLKS 4
+#define SMU_13_0_6_MAX_XCC 8
+#define SMU_13_0_6_MAX_VCN 4
+#define SMU_13_0_6_MAX_JPEG 40
+
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
 extern void smu_v13_0_6_set_temp_funcs(struct smu_context *smu);
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
@@ -95,4 +102,115 @@ void smu_v13_0_12_tables_fini(struct smu_context *smu);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
+
+#if defined(SWSMU_CODE_LAYER_L2)
+#include "smu_cmn.h"
+
+/* SMUv 13.0.6 GPU metrics*/
+#define SMU_13_0_6_METRICS_FIELDS(SMU_SCALAR, SMU_ARRAY)                       \
+	SMU_SCALAR(SMU_MATTR(TEMPERATURE_HOTSPOT), SMU_MUNIT(TEMP_1),          \
+		   SMU_MTYPE(U16), temperature_hotspot)                        \
+	SMU_SCALAR(SMU_MATTR(TEMPERATURE_MEM), SMU_MUNIT(TEMP_1),              \
+		   SMU_MTYPE(U16), temperature_mem)                            \
+	SMU_SCALAR(SMU_MATTR(TEMPERATURE_VRSOC), SMU_MUNIT(TEMP_1),            \
+		   SMU_MTYPE(U16), temperature_vrsoc)                          \
+	SMU_SCALAR(SMU_MATTR(CURR_SOCKET_POWER), SMU_MUNIT(POWER_1),           \
+		   SMU_MTYPE(U16), curr_socket_power)                          \
+	SMU_SCALAR(SMU_MATTR(AVERAGE_GFX_ACTIVITY), SMU_MUNIT(PERCENT),        \
+		   SMU_MTYPE(U16), average_gfx_activity)                       \
+	SMU_SCALAR(SMU_MATTR(AVERAGE_UMC_ACTIVITY), SMU_MUNIT(PERCENT),        \
+		   SMU_MTYPE(U16), average_umc_activity)                       \
+	SMU_SCALAR(SMU_MATTR(MEM_MAX_BANDWIDTH), SMU_MUNIT(BW_1),              \
+		   SMU_MTYPE(U64), mem_max_bandwidth)                          \
+	SMU_SCALAR(SMU_MATTR(ENERGY_ACCUMULATOR), SMU_MUNIT(NONE),             \
+		   SMU_MTYPE(U64), energy_accumulator)                         \
+	SMU_SCALAR(SMU_MATTR(SYSTEM_CLOCK_COUNTER), SMU_MUNIT(TIME_1),         \
+		   SMU_MTYPE(U64), system_clock_counter)                       \
+	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
+		   SMU_MTYPE(U32), accumulation_counter)                       \
+	SMU_SCALAR(SMU_MATTR(PROCHOT_RESIDENCY_ACC), SMU_MUNIT(NONE),          \
+		   SMU_MTYPE(U32), prochot_residency_acc)                      \
+	SMU_SCALAR(SMU_MATTR(PPT_RESIDENCY_ACC), SMU_MUNIT(NONE),              \
+		   SMU_MTYPE(U32), ppt_residency_acc)                          \
+	SMU_SCALAR(SMU_MATTR(SOCKET_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),       \
+		   SMU_MTYPE(U32), socket_thm_residency_acc)                   \
+	SMU_SCALAR(SMU_MATTR(VR_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),           \
+		   SMU_MTYPE(U32), vr_thm_residency_acc)                       \
+	SMU_SCALAR(SMU_MATTR(HBM_THM_RESIDENCY_ACC), SMU_MUNIT(NONE),          \
+		   SMU_MTYPE(U32), hbm_thm_residency_acc)                      \
+	SMU_SCALAR(SMU_MATTR(GFXCLK_LOCK_STATUS), SMU_MUNIT(NONE),             \
+		   SMU_MTYPE(U32), gfxclk_lock_status)                         \
+	SMU_SCALAR(SMU_MATTR(PCIE_LINK_WIDTH), SMU_MUNIT(NONE),                \
+		   SMU_MTYPE(U16), pcie_link_width)                            \
+	SMU_SCALAR(SMU_MATTR(PCIE_LINK_SPEED), SMU_MUNIT(SPEED_2),             \
+		   SMU_MTYPE(U16), pcie_link_speed)                            \
+	SMU_SCALAR(SMU_MATTR(XGMI_LINK_WIDTH), SMU_MUNIT(NONE),                \
+		   SMU_MTYPE(U16), xgmi_link_width)                            \
+	SMU_SCALAR(SMU_MATTR(XGMI_LINK_SPEED), SMU_MUNIT(SPEED_1),             \
+		   SMU_MTYPE(U16), xgmi_link_speed)                            \
+	SMU_SCALAR(SMU_MATTR(GFX_ACTIVITY_ACC), SMU_MUNIT(PERCENT),            \
+		   SMU_MTYPE(U32), gfx_activity_acc)                           \
+	SMU_SCALAR(SMU_MATTR(MEM_ACTIVITY_ACC), SMU_MUNIT(PERCENT),            \
+		   SMU_MTYPE(U32), mem_activity_acc)                           \
+	SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_ACC), SMU_MUNIT(PERCENT),          \
+		   SMU_MTYPE(U64), pcie_bandwidth_acc)                         \
+	SMU_SCALAR(SMU_MATTR(PCIE_BANDWIDTH_INST), SMU_MUNIT(BW_1),            \
+		   SMU_MTYPE(U64), pcie_bandwidth_inst)                        \
+	SMU_SCALAR(SMU_MATTR(PCIE_L0_TO_RECOV_COUNT_ACC), SMU_MUNIT(NONE),     \
+		   SMU_MTYPE(U64), pcie_l0_to_recov_count_acc)                 \
+	SMU_SCALAR(SMU_MATTR(PCIE_REPLAY_COUNT_ACC), SMU_MUNIT(NONE),          \
+		   SMU_MTYPE(U64), pcie_replay_count_acc)                      \
+	SMU_SCALAR(SMU_MATTR(PCIE_REPLAY_ROVER_COUNT_ACC), SMU_MUNIT(NONE),    \
+		   SMU_MTYPE(U64), pcie_replay_rover_count_acc)                \
+	SMU_SCALAR(SMU_MATTR(PCIE_NAK_SENT_COUNT_ACC), SMU_MUNIT(NONE),        \
+		   SMU_MTYPE(U32), pcie_nak_sent_count_acc)                    \
+	SMU_SCALAR(SMU_MATTR(PCIE_NAK_RCVD_COUNT_ACC), SMU_MUNIT(NONE),        \
+		   SMU_MTYPE(U32), pcie_nak_rcvd_count_acc)                    \
+	SMU_ARRAY(SMU_MATTR(XGMI_READ_DATA_ACC), SMU_MUNIT(DATA_1),            \
+		  SMU_MTYPE(U64), xgmi_read_data_acc,                          \
+		  SMU_13_0_6_NUM_XGMI_LINKS)                                   \
+	SMU_ARRAY(SMU_MATTR(XGMI_WRITE_DATA_ACC), SMU_MUNIT(DATA_1),           \
+		  SMU_MTYPE(U64), xgmi_write_data_acc,                         \
+		  SMU_13_0_6_NUM_XGMI_LINKS)                                   \
+	SMU_ARRAY(SMU_MATTR(XGMI_LINK_STATUS), SMU_MUNIT(NONE),                \
+		  SMU_MTYPE(U16), xgmi_link_status, SMU_13_0_6_NUM_XGMI_LINKS) \
+	SMU_SCALAR(SMU_MATTR(FIRMWARE_TIMESTAMP), SMU_MUNIT(TIME_2),           \
+		   SMU_MTYPE(U64), firmware_timestamp)                         \
+	SMU_ARRAY(SMU_MATTR(CURRENT_GFXCLK), SMU_MUNIT(CLOCK_1),               \
+		  SMU_MTYPE(U16), current_gfxclk, SMU_13_0_6_MAX_GFX_CLKS)     \
+	SMU_ARRAY(SMU_MATTR(CURRENT_SOCCLK), SMU_MUNIT(CLOCK_1),               \
+		  SMU_MTYPE(U16), current_socclk, SMU_13_0_6_MAX_CLKS)         \
+	SMU_ARRAY(SMU_MATTR(CURRENT_VCLK0), SMU_MUNIT(CLOCK_1),                \
+		  SMU_MTYPE(U16), current_vclk0, SMU_13_0_6_MAX_CLKS)          \
+	SMU_ARRAY(SMU_MATTR(CURRENT_DCLK0), SMU_MUNIT(CLOCK_1),                \
+		  SMU_MTYPE(U16), current_dclk0, SMU_13_0_6_MAX_CLKS)          \
+	SMU_SCALAR(SMU_MATTR(CURRENT_UCLK), SMU_MUNIT(CLOCK_1),                \
+		   SMU_MTYPE(U16), current_uclk)                               \
+	SMU_SCALAR(SMU_MATTR(PCIE_LC_PERF_OTHER_END_RECOVERY),                 \
+		   SMU_MUNIT(NONE), SMU_MTYPE(U32),                            \
+		   pcie_lc_perf_other_end_recovery)                            \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_INST), SMU_MUNIT(PERCENT),                \
+		  SMU_MTYPE(U32), gfx_busy_inst, SMU_13_0_6_MAX_XCC)           \
+	SMU_ARRAY(SMU_MATTR(JPEG_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),    \
+		  jpeg_busy, SMU_13_0_6_MAX_JPEG)                              \
+	SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),     \
+		  vcn_busy, SMU_13_0_6_MAX_VCN)                                \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(PERCENT), SMU_MTYPE(U64), \
+		  gfx_busy_acc, SMU_13_0_6_MAX_XCC)                            \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),    \
+		  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,                \
+		  SMU_13_0_6_MAX_XCC)                                          \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_THM_ACC), SMU_MUNIT(NONE),    \
+		  SMU_MTYPE(U64), gfx_below_host_limit_thm_acc,                \
+		  SMU_13_0_6_MAX_XCC)                                          \
+	SMU_ARRAY(SMU_MATTR(GFX_LOW_UTILIZATION_ACC), SMU_MUNIT(NONE),         \
+		  SMU_MTYPE(U64), gfx_low_utilization_acc, SMU_13_0_6_MAX_XCC) \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
+		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
+		  SMU_13_0_6_MAX_XCC)
+
+DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_gpu_metrics, SMU_13_0_6_METRICS_FIELDS);
+
+#endif /* SWSMU_CODE_LAYER_L2 */
+
 #endif
-- 
2.49.0

