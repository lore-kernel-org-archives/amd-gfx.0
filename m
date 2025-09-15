Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42644CAC58F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 08:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3DAE10E339;
	Mon, 15 Sep 2025 08:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pfuMg8Qo";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6128B10E339
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 08:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8DkJRuz+PA+oTTPoIu89Y8QRtDtooWTXh9tqvNkIoS6NbPv7cqyUMqOx8PDM248SNkN69UclebKF3fBrJAzm4Yf6YkQD2zrjUf1i8hyO1exFR2ZvZ4DVfNMdSjtzlxapOJjpDWJWtJudrNgtKVXGogP+Uhy2b4s85IW+n0A+lTQz/8Vf7XxiNjw4bLzZbvCNrX7XMxGj7lqm1koBi/BplwK5CYAZo1QrqXS0U+w5EsEH0GIlSizkVUhxJo/u1GwSM+lMOrelwEC3yiIOa/efu2yxnB08YbEFqnb6+Y6BnyA1oXQH7n4TKM9wLwX8RsJ67fFUgDZGyOQW2Hx8Kjlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLG0t1obAvSAqBRyLiQI9u4CIDa5m4O2g9N7Teozo6o=;
 b=D53MytpUSkKlIzlAbFZZSqLHBpzSTyIC2FEBYoEzfITQYMVkPARc7eCUDpR/V15Py35NZCQXvIqkuw2A4tDVgM1L4AhNSJlcemuihWBWE0nzsC4mWKkmlhphoHFXdGx68/7SD3YC0/VXlbZqNk1Ih31bOOhSRQJn3fA7ntqMlETH1mCdDEowp93J6ra2L8npe4eWKu4cXZq4CuZ3co3ZZP3X1w/jB8QAqBPw0zM0q5PVGI5vfRi35nUfnZjSmRvjtSlbwF6BcfrbdQJsTh/MQ/d1aHntGBBcED0BWXxjSl2qBCJV4aSoe0b+mF+GN1uBgHO1C/0W5qaKlciCDXtQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLG0t1obAvSAqBRyLiQI9u4CIDa5m4O2g9N7Teozo6o=;
 b=pfuMg8QoyoKQYEudX+g7g6bxisdosOhNrdU/io1/Xpdw2MpBDMUQHvGKUY6nxDjhmXRxC+BgjF4nUeZzQgLGEUz4xvKHIBB2CVEjxS/YWzVxW1yin4h/Rcp2ljwy7rs7pBnVhZvDewPOiHhUQ4RaWhErT3vc3yZwOzJg4JyQjyg=
Received: from MW4PR04CA0315.namprd04.prod.outlook.com (2603:10b6:303:82::20)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 08:01:56 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::6b) by MW4PR04CA0315.outlook.office365.com
 (2603:10b6:303:82::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 08:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 08:01:54 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 01:01:52 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v4 3/7] drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.6
Date: Mon, 15 Sep 2025 13:26:32 +0530
Message-ID: <20250915080123.3024297-4-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 48058146-984d-434a-7f30-08ddf42e2305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MHkmnPEQxfn9NxjICAvDo0jkI3FY1LwblJSdFinrha1q6SQheWuECbrxjgJd?=
 =?us-ascii?Q?RTyI4CtwXGtK2Jm0hjxMHYE4iWQGIJZk508PzoInhDtKzPPOu97FxrBaX8Li?=
 =?us-ascii?Q?HguC9HZi+O74bLxGWhfAr9xbc6yP3+ull/YWJqhNzIpSEw2OXIYU8yet7kXR?=
 =?us-ascii?Q?/ikZ5mk3V9JP+tQXyKoHPYn5MH2kIt5wia1+OJVZA5KWEqbVShiXFMf117OO?=
 =?us-ascii?Q?+uuKmB1HaM+zWJG6a6/jtEW3b4yHXXW61qR9ECu/19FCgqS1380eMztNdMdg?=
 =?us-ascii?Q?m1HvxGHWq84jLz2hbvKdIU+u1FjOyYXGMesUSz6iznvS7wbbQ6wNPlFY9noN?=
 =?us-ascii?Q?9tw8+F/ZwE6pyM3uIQp1YzzflKsj5J6GSWtp246853kyWeA5dtZjrLLjzElC?=
 =?us-ascii?Q?RUFj8pTJe+03aytLhyJErRClaMBvy+Kotgg2ohqdsPPCYx4oapTpYYRrT9IM?=
 =?us-ascii?Q?I4mCbSXwIbsjsvBgGVDkSq2pQcgy+nN34q/L29+0FP5YhGGRCDLv65R+N6hp?=
 =?us-ascii?Q?8uJ9cbj3HqPztxnSYbpYjR2QDGA8lbh9+i2EWLidDDLAODtm6UONMMdXx3jg?=
 =?us-ascii?Q?kbxAq9SIdP+1KHPm7M1vr3nFPlDO73lguX4WT/VC4PN1IwK3uAc9z24OdMBn?=
 =?us-ascii?Q?Ub0PQeNut5UNFmX6wVX0pB4kw/LtW7F3GqI216eqT342iVeqaDhmQVrH/ZaX?=
 =?us-ascii?Q?5mW2giquAsWfTAFot3rayNi0MIGxtRd1IP0vHpa+PBKbWFP3Al6gBtUDjcax?=
 =?us-ascii?Q?5NPeByo7AM7YT7ySDHnflen4KQZJW0802UiCNtmIV5L90ITu5MCRBXkf8rma?=
 =?us-ascii?Q?cTDp18lL3+PCjaRDqhiKa51UOQWBiV2upkhuhHq2WOCFf29J6TLj+5wgcCt2?=
 =?us-ascii?Q?UmX08ODH+XFRapJfg3o+tkGiUMhyfFTKjiCxttk33WycTxji2l0uUBY/LaJB?=
 =?us-ascii?Q?dhbz/xeGntSjCY/CGRYOLCzZzKI6dWYX5umTTq3jir2ZpP/WxmK+wtwqVJJC?=
 =?us-ascii?Q?MnSMmh1WoaHqoi9h/iBWBxoyrLj9UkBJwjmHcuDND5/OZc2VI1kq17Z5aRIl?=
 =?us-ascii?Q?l1dLbuHJH5Kao0S6KsS5rBgobFUwdJIG40NBnTr58YYjNaHYG4IDr/dxY06C?=
 =?us-ascii?Q?6Cy5l/KObKXDLTHOTromePnDXqi8Jo/JiTRLp2fh68POBKKpUwLVkIVXfaD6?=
 =?us-ascii?Q?oqlIHnwijBAfz7Ms5cRyFEVO14Mi2UX9wRiLQYtqeJVqyZ0lYcOo5uzbSmQO?=
 =?us-ascii?Q?jJFpSJN5Jzg7HuoyZswlna1JqbG/WnUswnNf566csxO4canLIN8IgfGHj29Q?=
 =?us-ascii?Q?9Yr7HNgkmGOaZUKUdMY17BqbY7vCST/togxcgJkF4L/Oopkjq/Nw0jn3wtLd?=
 =?us-ascii?Q?aAuNViX8lCv65yTCe2NtmWyZPmgCHzvrVw6ct79ZgS/qphuQ55k+QRWxA829?=
 =?us-ascii?Q?Z+VTB2RI7Bi3o1ya4v0o60hir+7u23d0SO6OoWrs7vsb5+MgMiKxa/dsTP7f?=
 =?us-ascii?Q?dNfA1xei8C9suBMZO9dj8d5CmALLzc64ROWw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:01:54.8373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48058146-984d-434a-7f30-08ddf42e2305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 113 +++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 118 ++++++++++++++++++
 2 files changed, 177 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index bcd6525ca5e9..8e89ab9e3360 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -543,6 +543,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
 	void *gpu_metrics_table __free(kfree) = NULL;
+	struct smu_v13_0_6_gpu_metrics *gpu_metrics;
 	void *driver_pptable __free(kfree) = NULL;
 	void *metrics_table __free(kfree) = NULL;
 	struct amdgpu_device *adev = smu->adev;
@@ -582,11 +583,22 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
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
@@ -725,6 +737,7 @@ static int smu_v13_0_6_fini_smc_tables(struct smu_context *smu)
 {
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
 		smu_v13_0_12_tables_fini(smu);
+	smu_table_cache_fini(smu, SMU_TABLE_SMU_METRICS);
 	return smu_v13_0_fini_smc_tables(smu);
 }
 
@@ -2740,18 +2753,16 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
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
@@ -2766,8 +2777,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
 	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
-
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 8);
+	gpu_metrics = (struct smu_v13_0_6_gpu_metrics
+			       *)(tables[SMU_TABLE_SMU_METRICS].cache.buffer);
 
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version));
@@ -2889,55 +2900,49 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
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
@@ -2947,7 +2952,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, version);
 
-	*table = (void *)gpu_metrics;
+	*table = tables[SMU_TABLE_SMU_METRICS].cache.buffer;
 
 	return sizeof(*gpu_metrics);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 4652fcd5e068..d0cc1b03749b 100644
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
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
@@ -94,4 +101,115 @@ void smu_v13_0_12_tables_fini(struct smu_context *smu);
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

