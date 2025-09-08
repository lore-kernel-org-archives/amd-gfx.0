Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFD0CA1013
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 11:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6061A10E3D3;
	Mon,  8 Sep 2025 11:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V2XAXs3v";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5317610E4BD
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 11:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN+jw9ZmGID/HCozVu5P+fo7cKVb2mpEv4LUekswlHmsEA+0fjqdlfbQTveFiHT+A1tw1HgyMbLxVj3hg6UsbNaCAMgTkdPDgJfcOrvP0GaDEo4QWcW7EsghQ7CE2sAPquSPk2CHAIk5VJ4lvC5BKatWD+x1g7rnH232nuVdLLMCmxCrFEUao1rMDscwugUeC8WHrWzMpUeAw2c8MQfS0dSy9CtQWF260n43BCxRGlAy0Loiw6bIoplHUhar5dlRYMXWV8SZnxnRi0IdQmfFBE4r/y0rY3saPD0W+9NmHmYXltrPdpJOjbmCMaba4f6JBq4cXuLX3baqp9bpl4l+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw0JscaBD4wV2wmcKYOVMAj9bmNVnmEu7Ayk+0E1ZPI=;
 b=VvcR0Ui0aAl7M+juPxOSKtvXBJPPZWh3W1HY7DejjNBgBX1AMdOV72vp3Gw6yUR02ZErOMLF2oRkePmjBGZR9SDp0m9ESP0XyxlTm7GqIvf+5fNTVK2NSgCAojTATMOdY6vzq9J/Q0uOK5JgyLoWDuiojZDgj7AasvI6BFFsvHFfIC+JYv/bIEqUpAjYWvctoY/WANbj0urg8xYxIW23FrGY5eblLVuApRX3fvrgQT02a44FoCe5a5hoGskK7W+yU/cTX+GEE9RcUHY5fcoVvQrKaEg8ArlHe5PyGwjTibjQZhJzHe+z0UKVLvrJlJVSSXcL3YKSFWc96G7/hhJsbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw0JscaBD4wV2wmcKYOVMAj9bmNVnmEu7Ayk+0E1ZPI=;
 b=V2XAXs3vO+uAmH+vLgry3Zz/kWArFRirqWSO8iyvca0AbIvtrwdv60Xyx8UoV+q+N9/kScdEvd8LSDRUDn8d6+TyWAN6n5c0qWSArOt8xwRYd0xzmT3XzDKrI/4I3B3njFeMb9ImIKgIqbfHZ6wmz4amq6BvuCFDAcaKdhd/M8M=
Received: from MN2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:208:1a0::33)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:03:00 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::11) by MN2PR07CA0023.outlook.office365.com
 (2603:10b6:208:1a0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Mon,
 8 Sep 2025 11:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:02:59 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:02:57 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2 3/7] drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.6
Date: Mon, 8 Sep 2025 16:31:14 +0530
Message-ID: <20250908110231.2888628-4-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: d2654ade-7e23-40c4-0051-08ddeec7461e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G+0U1Iq6ewi8sAcw8mt+LP8VRIGtFd1hXkVBJOQ7Bqqy/89xuD8GEFBw8lLU?=
 =?us-ascii?Q?C2hbaBbbmCF92O0y0+Ao6fqQLjhzOmldMN9WPHB+7Z1fwdvb/zAG8+MwMdnk?=
 =?us-ascii?Q?NJMRwpvVTiP5mD+iEkzG0dv/ifZWRcieA3uS9tk+xNVgTHL1tsrMJ0DDuUkT?=
 =?us-ascii?Q?QcZ0AnvB4CGdqzv+4a/ZKgUyqkl7vqDPR2vWoZJ9KxSfpJAYO1ta79jST2f1?=
 =?us-ascii?Q?Hg6dHtir/vNaiQtwq1FKWZXghZqdzZuiah7svaWaduAwWOq1H7ok1OihUZFi?=
 =?us-ascii?Q?uR/fpf9zzcZuGB1msyGMIs93IpOY2pWhGHSG4SXt1oR/zl686epJJXyGTypq?=
 =?us-ascii?Q?YQDZltrvVdroHfJ2RLdGz7HtSJPVSXtv2HHKnoapvUgEwbpZ5RNU9b+b7SBB?=
 =?us-ascii?Q?g/OqKBl4/2d3R8XD/rdj1/9OVEn1BSpgOyoD8DrJZLRKzNHC6q8dKOZ1iwAy?=
 =?us-ascii?Q?cNLNaIsbWaFqcVNjGBuG8h+RF26tgufpFdm4bQDGeKYyfbvZtvbwG8lv5BZU?=
 =?us-ascii?Q?uet3pSdhyeJZxfoEcIFkYbeUsuwTPPNhHRk+IrpMcaY8aKBlSLJtdxOQ9FUq?=
 =?us-ascii?Q?JhftY/br+3abk6/5qzpIwnyohz0h6rh8lYDxRi5u+8txbFGClqlufXBTZu5D?=
 =?us-ascii?Q?EfroAjJJw7sChtY9LbR3tXSxutdFA+4UVfYWDRc7REhIJKpOjZygXiW9jTLs?=
 =?us-ascii?Q?yLKWOCIe5LaEKKl8qZUZUNF0zeaVNzLDXAiPYAs4yX20I46VmX1/hINZevhg?=
 =?us-ascii?Q?kvMMNSl/t+MxX8Z63OycNS5Th8LioY9/VPR6s6cjxqzHUnvrVdCrC2kmNqi8?=
 =?us-ascii?Q?mhCaqi2uZYv21WJ3Wf+L+mL1XUDQ3UPJMmkQNLyssjUhgcs4XSu3HhWAazBJ?=
 =?us-ascii?Q?WWuV1banIpAHxaOlCDtinjH3xaDOKWFFeR/Kqt3muf1APwQAdBg9OlAaLWk8?=
 =?us-ascii?Q?Hr29UOT4x4m4UzxXgDig4lbFfJtYUbErCFMAqsgDDRkvpcSWs8jHJ76N77JF?=
 =?us-ascii?Q?76aRlm31R3ebuPvigt0WIAYitqYCt1OLWemSGj2Fa+pT0VVU7TCRdAxklFXo?=
 =?us-ascii?Q?FqbwScDWgzby8beMcJ0SgJmi+KN4WEoXx5Od1Vb7vWWYu5SG5hXro4MCVn9F?=
 =?us-ascii?Q?MCiyvEuDKSHBxXrOFsE13rziwnHWDAdCJJ2tMZcGu4Mp5C/pu1hshL+5YTeU?=
 =?us-ascii?Q?lk3SrSRFMvhxtNDkL1Q0YgILA8uVPjBA4PuPZEUagm7BuK7dtQACE9zk3f5r?=
 =?us-ascii?Q?MrVvK1e8kOD6Yvi23gElo4jbeehkqmiILP+1QmIQv+i/vDKycMMRmFVCifY3?=
 =?us-ascii?Q?5zo7nSFaUvGrC9lHenBySAmGsbEdLdtBFvdh/oHI9MByuylwix5M+/czV2DP?=
 =?us-ascii?Q?UYdIx0QznDfZMZK4rKvsc4lhXcyGfE05hhgQwbXYBbVQHFOF1Mm6hiC0lM1h?=
 =?us-ascii?Q?VPenYRaWDzwO4xR9Bua91upglvTcnFkRrI2JpsUkGMNHMjlLAQtR9/FMWrv2?=
 =?us-ascii?Q?e4Z7hp+E19/YExa9dIxqAN+MW5aEyd5JyWVw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:02:59.8321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2654ade-7e23-40c4-0051-08ddeec7461e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
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

