Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD213D41C16
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 08:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDEC10E68D;
	Wed, 13 Nov 2024 08:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MMG/0XUr";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84B110E68D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 08:24:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2KSw+TaQ/BaIx5XytQxGpCUglBlpqyQLuVJJndCvKm6ccuIieeU+pVb/ZdhldYczT6UnM8ZyNNdr8JDva8/CDDEfIRtFuuCloMwdKQB4ECsf9HqXjaEZKm0pTyd/pxT+4KxQpv1Aik5dJL73dZFuO+DCXTFniFNPrIav48eN6pLI3ItJoIh83TAGbQq/0xhKwU/iSectGxeKXQIFXXkb6grSzDbITjwyHJpZ3yAm+N1uaTOFAKPpu9q1yJ2NT4zeQUm/vUc2IFmSjJutCLr8bC9wZwIJcqDhjA81j1uDauWYDHC0w/1XY25nbHnSdTVd13E3708jyfbxoYf3+oshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+QnT6WISXAbfjK2pkFXZgKVuPbTnInYqkHHnJYDx80=;
 b=dxPmirELhLzRWxuGw5/+7oF5ZT0D6Ufa6EmanpvOBWtJfHqrfGknqbNfzklE71eyL8sLgIpZrwgRKSvCMKeAMUbb053aB2kgwRnV64rXWs+sm6dgu41+5NBPwux3N/be+SX+uatW+mOeXW64ofyNe6EYr6ftLv270+6j/sGqfnKupC3xiFVx4Sq229QFLMFMcqTottj4aq1xaqSLqjr+f1By1pUFKzicrpUoIAd6Z4bxcJhBtYeEPEkbIoZbxtKhDt1xldXAMPV6q6bkzfJakUQiwkWrw1O/BkG1Gk9JOaovfIX01YRIzgQgCQCwMpTlxP5sTW6v+wr7aeQjkpEt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+QnT6WISXAbfjK2pkFXZgKVuPbTnInYqkHHnJYDx80=;
 b=MMG/0XUrOhoJ1Qc1pyPdHIanDaxkciy17CDXcvyjzCq7r8Q54Es7f3QQVOBZGK81qNz6cXFMG4MpgBUK4CHt6myHyLFqz2NA/LrjU9Na+O9/4KLpNrtugnq5yUDVvFQ2FFVxs+gf1yZ61izLb7Q7fQp+xtJS1+9/Jhdb+0zo184=
Received: from SJ0PR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:33f::34)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 08:24:51 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:33f:cafe::f8) by SJ0PR05CA0059.outlook.office365.com
 (2603:10b6:a03:33f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Wed, 13 Nov 2024 08:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Wed, 13 Nov 2024 08:24:50 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 02:24:47 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: Add gpu_metrics_v1_7
Date: Wed, 13 Nov 2024 16:24:32 +0800
Message-ID: <20241113082433.1308830-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b52788-6b86-4aec-6bca-08dd03bca4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/zow2fx41Wvrfc35idiinpoJHJbuDDrpbvvL7NYWmFQc4UW3f5qzxgUnF0xz?=
 =?us-ascii?Q?aR5Jyr7t87A1EI4bLGX8UfH1XtFYB0+6HprMxsfhfAYw/e9IUIvHRPg63Jx6?=
 =?us-ascii?Q?CGaPo/p7Vf7e6sFXeaUCHyHHJfU4M0yL1Uhcp59CLADKNLZcLVPvcIEN+gvW?=
 =?us-ascii?Q?5jICOCX4etDTlhyhHHl10+O77sOzuajkyvS6HaGpEsAK6ZSYloIqp+mLXSuI?=
 =?us-ascii?Q?o7nz7iWh/papYcMxVu+ssFacWCXG0xFv0XrAKPj/6E9q6XbDNalDqdCf/hfi?=
 =?us-ascii?Q?cv+CkIvppatKxDP8D+RHxPALMcxzOkFOni4W5tR5W+OuHSkgQ7bXpocYry/y?=
 =?us-ascii?Q?UM/WyqKvl7MTAKxonHYh6NdavG9UeKOm2KASh8RE8xa+HrLAqBb9a6LVBQZT?=
 =?us-ascii?Q?+uKut2A2Llmd/VX/whA06N089ujHsKQDW3hvwQjLyROxy4wTaG08XkMW8QgQ?=
 =?us-ascii?Q?Q4VtGKrPw7yf5rrvXSeOMJddTEKuotBnGCp3D+YNXDxPVM1NG4taK/6dj7QD?=
 =?us-ascii?Q?tRiKbquW+qhRYpNn47PFQ/mGjXlFXKf0jv5H+xrDlCkzK8auoSq734m5l80t?=
 =?us-ascii?Q?9BOI2xZ3PUkxDVb8qrGrQOdLrDl283aLHgRjKDAxuYV6S8+R93YhNoMr7uB4?=
 =?us-ascii?Q?/uqyXvqHlepgCNgrE4k1qB/HXQyL9VIWGZcLO3QQ4J4H/g8iLGqKxLS7p4Pm?=
 =?us-ascii?Q?6E/fwK+QbbjNgnGIpsT/MKeV6dy36fLw+Ks0m5AW6NmizzIdsx3HYfjvURDj?=
 =?us-ascii?Q?OJFIuSqYGKf4XDTuPdtmpQio56E4qfi7WGOAckWJdnfQ1ZcxUntAe+3NsjHx?=
 =?us-ascii?Q?3M8Z81eONEH7H2PvH4R2i4KBUY9Y++KIEmtRvzlCAIvkFYa7vEP/lWGn2HmP?=
 =?us-ascii?Q?xOeUP3rc9VKypaooWS9cVRlmHD1u5t6piSqgo29lUx43eQI/c7ipGmOvY4OA?=
 =?us-ascii?Q?9062hFoVBTBJY8qy9f09xbFIr4gSSEBbyBeZEXEJjRJTTIh8Zctj1ZakhJNd?=
 =?us-ascii?Q?jkGafHJVt88HdsbBhA2X0CvACsKpAzXsGHjBipBn0cLPRiBMpuYoZ/rNdLCu?=
 =?us-ascii?Q?Y3fanJdVRIdFniCmrIg+67LDMr9otqxNsmHlPbnnHpXoPUbAP+xz5JirRe4+?=
 =?us-ascii?Q?WZnq8ooohcWPTi1xyhpUV/7WAqxry+F+gSnMj0Rk3/3UGi+QQ6RYxT1uDn5h?=
 =?us-ascii?Q?KaavgzYSd0kq+ks0x6Lsa2SNLzCw7cTdUWolTXTy8ExJtWvORja1fpTIzBDa?=
 =?us-ascii?Q?BJxO3LRJ57iNpr74df6WcXiQbi2vQ3giFbSdbUSkAgcegpOUIdjB/uXl32IF?=
 =?us-ascii?Q?HUFpn6oKOB2lmYEsYH13r24HlNp8E97j8uh8mQK7p1jStN97t9OjM8qpge6U?=
 =?us-ascii?Q?Ud0dTzzSMvYrL6EVG7YwMaT/rTdzCBuYQZpafsTVvfLDqu6Zrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 08:24:50.8123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b52788-6b86-4aec-6bca-08dd03bca4d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
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

Add new gpu_metrics_v1_7 to acquire xgmi link status,
application counter and max vram bandwidth

v2: Use gpu_metrics_v1_7 for SMU_v_13_0_6 (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 110 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   8 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   3 +
 3 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index ee8170cda1d7..a95935cc3d76 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -364,6 +364,17 @@ struct amdgpu_xcp_metrics {
 	u64 gfx_busy_acc[MAX_XCC];
 };
 
+struct amdgpu_xcp_metrics_v1_1 {
+	/* Utilization Instantaneous (%) */
+	u32 gfx_busy_inst[MAX_XCC];
+	u16 jpeg_busy[NUM_JPEG_ENG];
+	u16 vcn_busy[NUM_VCN];
+	/* Utilization Accumulated (%) */
+	u64 gfx_busy_acc[MAX_XCC];
+	/* Total App Clock Counter Accumulated */
+	u64 gfx_below_host_limit_acc[MAX_XCC];
+};
+
 struct amd_pm_funcs {
 /* export for dpm on ci and si */
 	int (*pre_set_power_state)(void *handle);
@@ -979,6 +990,105 @@ struct gpu_metrics_v1_6 {
 	uint32_t			pcie_lc_perf_other_end_recovery;
 };
 
+struct gpu_metrics_v1_7 {
+	struct metrics_table_header	common_header;
+
+	/* Temperature (Celsius) */
+	uint16_t			temperature_hotspot;
+	uint16_t			temperature_mem;
+	uint16_t			temperature_vrsoc;
+
+	/* Power (Watts) */
+	uint16_t			curr_socket_power;
+
+	/* Utilization (%) */
+	uint16_t			average_gfx_activity;
+	uint16_t			average_umc_activity; // memory controller
+
+	/* VRAM max bandwidthi (in GB/sec) at max memory clock */
+	uint64_t			mem_max_bandwidth;
+
+	/* Energy (15.259uJ (2^-16) units) */
+	uint64_t			energy_accumulator;
+
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
+
+	/* Accumulation cycle counter */
+	uint32_t                        accumulation_counter;
+
+	/* Accumulated throttler residencies */
+	uint32_t                        prochot_residency_acc;
+	uint32_t                        ppt_residency_acc;
+	uint32_t                        socket_thm_residency_acc;
+	uint32_t                        vr_thm_residency_acc;
+	uint32_t                        hbm_thm_residency_acc;
+
+	/* Clock Lock Status. Each bit corresponds to clock instance */
+	uint32_t			gfxclk_lock_status;
+
+	/* Link width (number of lanes) and speed (in 0.1 GT/s) */
+	uint16_t			pcie_link_width;
+	uint16_t			pcie_link_speed;
+
+	/* XGMI bus width and bitrate (in Gbps) */
+	uint16_t			xgmi_link_width;
+	uint16_t			xgmi_link_speed;
+
+	/* Utilization Accumulated (%) */
+	uint32_t			gfx_activity_acc;
+	uint32_t			mem_activity_acc;
+
+	/*PCIE accumulated bandwidth (GB/sec) */
+	uint64_t			pcie_bandwidth_acc;
+
+	/*PCIE instantaneous bandwidth (GB/sec) */
+	uint64_t			pcie_bandwidth_inst;
+
+	/* PCIE L0 to recovery state transition accumulated count */
+	uint64_t			pcie_l0_to_recov_count_acc;
+
+	/* PCIE replay accumulated count */
+	uint64_t			pcie_replay_count_acc;
+
+	/* PCIE replay rollover accumulated count */
+	uint64_t			pcie_replay_rover_count_acc;
+
+	/* PCIE NAK sent  accumulated count */
+	uint32_t			pcie_nak_sent_count_acc;
+
+	/* PCIE NAK received accumulated count */
+	uint32_t			pcie_nak_rcvd_count_acc;
+
+	/* XGMI accumulated data transfer size(KiloBytes) */
+	uint64_t			xgmi_read_data_acc[NUM_XGMI_LINKS];
+	uint64_t			xgmi_write_data_acc[NUM_XGMI_LINKS];
+
+	/* XGMI link status(active/inactive) */
+	uint16_t			xgmi_link_status[NUM_XGMI_LINKS];
+
+	uint16_t			padding;
+
+	/* PMFW attached timestamp (10ns resolution) */
+	uint64_t			firmware_timestamp;
+
+	/* Current clocks (Mhz) */
+	uint16_t			current_gfxclk[MAX_GFX_CLKS];
+	uint16_t			current_socclk[MAX_CLKS];
+	uint16_t			current_vclk0[MAX_CLKS];
+	uint16_t			current_dclk0[MAX_CLKS];
+	uint16_t			current_uclk;
+
+	/* Number of current partition */
+	uint16_t			num_partition;
+
+	/* XCP metrics stats */
+	struct amdgpu_xcp_metrics_v1_1	xcp_stats[NUM_XCP];
+
+	/* PCIE other end recovery counter */
+	uint32_t			pcie_lc_perf_other_end_recovery;
+};
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index fa30a9e1f27a..11ecaa62f419 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -370,7 +370,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_6);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_7);
 	smu_table->gpu_metrics_table =
 		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
@@ -2321,8 +2321,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 {
 	bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_inst;
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_6 *gpu_metrics =
-		(struct gpu_metrics_v1_6 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_7 *gpu_metrics =
+		(struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
 	bool flag = smu_v13_0_6_is_unified_metrics(smu);
 	int ret = 0, xcc_id, inst, i, j, k, idx;
 	struct amdgpu_device *adev = smu->adev;
@@ -2341,7 +2341,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	metrics_a = (MetricsTableA_t *)metrics_x;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 6);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 7);
 
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, flag));
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index fd2aa949538e..a9e69d321f8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1081,6 +1081,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 6):
 		structure_size = sizeof(struct gpu_metrics_v1_6);
 		break;
+	case METRICS_VERSION(1, 7):
+		structure_size = sizeof(struct gpu_metrics_v1_7);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
-- 
2.46.0

