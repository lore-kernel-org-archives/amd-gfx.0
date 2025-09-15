Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36ACCAC58E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 08:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7578210E329;
	Mon, 15 Sep 2025 08:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bf5wVoSz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FF910E329
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 08:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHtYmLD+75nGmEO2w4lplPNuIZmoTsXw2HCgX5H+c0ntV/vhdAGqdyLKHTlWyoTrJM4Y62RoPIOwlZZJGBDw9a+U81af2eYjUdQqJ2dG7RQav4M8RY3RlHe9QYnaRchY5euvpSDTlYzymfdK5Oxx7Vwc96SFOybAny0JJNleQ3yFNfa1NcYwwR9imJuLHGCw5n40e3lZjrc15nL8kADlbk+3fBlFkPaHWjIu5WhD5lhXnr2k8LYrc3I8azxZBjh14GspUGHY2JIT2CsiAV3YJSuv0E1PoLAD2IqbiCJb8m+6aaVQ+csIR7zHY4QitCh2hhL3zP4YaJ2gUsrdXUkYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PRB1rrTvPVpk7U/LRVF1yXc9q9lsKAUMqUexj0am3I=;
 b=r8RLur2kHTe4LuESOEJKMmDZA+yAAtDNNos60LF2gEuTQpGgLCoSjOnUY3gP8oTcUJa/j3isepbRjpSiB+RWwy53+IYoHcHuRMtfDArBIgIiLFfAUT6bCuwLHjjy1vBTuUHfg+9l1RaJdo/CMhLjSbkHPUbLNrqibRcJy8uBf6K/qeCWxYRnkuppRvZlHndjXkjB5wjcvtbPgUeszjiWSrR0Q/7GF+T2TLgG8MQ3HT/2/cs4IJ1KkO4WZmEh6XT7g/R4fHG4OFvvpfmJJjqkf1HVfaVSXAQv1RP9p+LgCm/tslSnxfkAMv4P7dOkHD/TXPEarlWX+eI8svzu4klqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PRB1rrTvPVpk7U/LRVF1yXc9q9lsKAUMqUexj0am3I=;
 b=bf5wVoSz7UzSwMtbAyDd9ZswPW84lZQlt1AhuA7CLafce1kItW4VvdMIZ1f6pC97oc8w+gAh3mSnQkekLo+RzGJAA7VNzLyvwjNbzlY9/GTuV6LJKdQS/y0sGYEfZ5BzTGDLqFQ2f1hpPNHGv9kDYxWNLytjyuWAeS1TlPc6R8s=
Received: from BY3PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:39b::15)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 08:02:16 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::6d) by BY3PR05CA0040.outlook.office365.com
 (2603:10b6:a03:39b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 08:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 08:02:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 01:01:54 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v4 4/7] drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.12
Date: Mon, 15 Sep 2025 13:26:33 +0530
Message-ID: <20250915080123.3024297-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250915080123.3024297-1-lijo.lazar@amd.com>
References: <20250915080123.3024297-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ff303c-e153-42a8-2718-08ddf42e2fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N1sJFNGeKxcl+yqbFQw5uLyre6JDQ2rXCW218ncqaS8jPjf/IZ9qrpAHhLNs?=
 =?us-ascii?Q?gWoeSwJuKuvxy5EjiPJz9Y5sBTMWMkNP4dtr38uhFhxUpwqu2/GucK7hPyeV?=
 =?us-ascii?Q?7aiMGvbwyafEzFqBV6eiXvqjjVgE8bEPtHP9n7o4f62KlhHtC1MczUMhRdjh?=
 =?us-ascii?Q?p6p+tGJnb12aTw70CZi6arm9jbjebz3ULutuEljs3SYJx/vBhjfUWOHPrQRt?=
 =?us-ascii?Q?TdyX47UVmrqYzNBvjQh1FXJE0WwTCpLw88N0AfDU2HXDNByDjqj3R57tsOTR?=
 =?us-ascii?Q?3mr3coO6I17Mot8EnRuDtcKATMoXH3pTx2YiA5oSVqnVWRw9RRw2yvCWslg3?=
 =?us-ascii?Q?NyWO0NE7SXbGXqbTuKk0J7ETFKkyWbR9S5lZgf00jRR/w/cR1CDgeVEEhGQx?=
 =?us-ascii?Q?K/0csBTJZxJH2hr+ItXuhu2ypqXhfGBCtqSJbxsiixWtK3IHLPp4DvmfmKT5?=
 =?us-ascii?Q?hqeuSyEIjq2aFMMZgXqErJpWiFdMdtATkDLJ3ME2aiSsDmjfW1TZLR5NvV/V?=
 =?us-ascii?Q?ZgW1m7gcHRyoTFrWpEIPV3R6uyPrcO5qlVGoNtic6jUh0oyIMO/hEkRQjb0U?=
 =?us-ascii?Q?ZyjbkB7k9AUlpAtXPB76ygi5MI28oFqxy3PY7A/cVinZ9CFFaNO9B/vPeTbW?=
 =?us-ascii?Q?vXVW28JW38Ys0azkaRhweHfYTQrw6LRi50EpWU+yuvfCEgAeuQU5xdhgtpBA?=
 =?us-ascii?Q?JSLXTsyYrk2H5eH1RNN2ZNWWZX1Z8XaekSC8iCrqkyBnQvLuXTdLNo0Xm1pf?=
 =?us-ascii?Q?SDTYgwstexnJPrjL/5XFXnDop9YLDItVacV7rLbih0EQHZj94KWRbVotIXlU?=
 =?us-ascii?Q?2B7wAZvEuSE8v3Mf3xuVs1mR1R462jwuoLygI9GKm+IifinYU3sLy8AkRStm?=
 =?us-ascii?Q?gGycfPEY/wUwf9ANgxCESOtWBkv0DD4y1VMl8RcdHfXuhgKz2reEuixcgU9U?=
 =?us-ascii?Q?vTKfaQj/ahnLNpr1dO597c1vumqxZEkURxdmNcLqYORcZSDdvhgXaIqNRURR?=
 =?us-ascii?Q?mzp9yfQg0AbhRQjo6/HNf4d3gec8qZxFUv/oEHl7wbFkkmoOZtULhF4OFsin?=
 =?us-ascii?Q?6YDRxAkqVylEs9MUiUcbA4Eb1WDwDQZAh0zG0cvxsOz8QCekKuWt3B547IKh?=
 =?us-ascii?Q?SN/CHgWz7xm4XDQb9x3xnffvXlminn+C46j29QkKeRxm2I6MzoFZRu4FV1vU?=
 =?us-ascii?Q?IcWKPj6/C+4hmuiu3ZMN/hOC8NPtUL+57rM3xy2Jpig+42F2WnnJ0DpHqtTV?=
 =?us-ascii?Q?FIH1gIz4Xu3JXjyYFJqSvoebZFx9w8HU5AvXAVGcX1BxSaTlDo4spp2xAj58?=
 =?us-ascii?Q?jy7/99svieC/j74rurS7zrfl9tABudsJwlk+vp+H/goqOFnNi5v2x7+rXD6U?=
 =?us-ascii?Q?qrs6DDlzi8o8a8qI2J8olyiqVIpj5fYF1fssBFOC71ZgZzigPhKy6WlP5MI3?=
 =?us-ascii?Q?GgMKOa4Q+ENk9P+cT3/63O239c8P9bPZCqpt/uh3SgKHPH63fzN1ZL5r447D?=
 =?us-ascii?Q?IYP5nRove/ZqIULe87HRaxLEovmQVbOrp1Kk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:02:16.4033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ff303c-e153-42a8-2718-08ddf42e2fe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
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
index 8e89ab9e3360..3edfdb0b2c00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -542,7 +542,6 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
-	void *gpu_metrics_table __free(kfree) = NULL;
 	struct smu_v13_0_6_gpu_metrics *gpu_metrics;
 	void *driver_pptable __free(kfree) = NULL;
 	void *metrics_table __free(kfree) = NULL;
@@ -573,12 +572,6 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
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
@@ -601,7 +594,6 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		}
 	}
 
-	smu_table->gpu_metrics_table = no_free_ptr(gpu_metrics_table);
 	smu_table->metrics_table = no_free_ptr(metrics_table);
 	smu_table->driver_pptable = no_free_ptr(driver_pptable);
 
@@ -2770,16 +2762,20 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
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
@@ -2952,6 +2948,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, version);
 
+fill:
 	*table = tables[SMU_TABLE_SMU_METRICS].cache.buffer;
 
 	return sizeof(*gpu_metrics);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index d0cc1b03749b..003672be005e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -92,7 +92,6 @@ size_t smu_v13_0_12_get_system_metrics_size(void);
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
 int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 				      MetricsMember_t member, uint32_t *value);
-ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void *smu_metrics);
 ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu,
 				     struct amdgpu_xcp *xcp, void *table,
 				     void *smu_metrics);
@@ -209,6 +208,9 @@ extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 		  SMU_13_0_6_MAX_XCC)
 
 DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_gpu_metrics, SMU_13_0_6_METRICS_FIELDS);
+void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
+				  void *smu_metrics,
+				  struct smu_v13_0_6_gpu_metrics *gpu_metrics);
 
 #endif /* SWSMU_CODE_LAYER_L2 */
 
-- 
2.49.0

