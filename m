Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5B4C36010
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 08:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E055C10E655;
	Wed, 26 Mar 2025 08:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v8EGI9vq";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA59310E558
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 08:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSzkbOeqz577U98/MyfMYkbYNU6FngTwyrQmUpQTwUvHKCs7LXSJUGnkrvZR0vZK/1/RWx5EsY9BTNy6hZwiinjus+epd6W9IURP3rdxXkS6bUDF/sYPdLXibah9ftKNJ32JrEM7QF7ZSriuraJfvASS8Rvjcp2lJoQCc9O3zKGz6+RYjq2FLimJODlr60AcC0LAVIOKytTTWBOazuTmVW3MMDCA1JO0DmxchpYgnlaWKnowqhr1QuPypkeYrbpaYM0jNqAKIKySegkvwMyPY3kvhRpBYbloC0H+B8NKOuW/28x46905MAmPPy1hP7dVs9S51AmWrIJaTe7hgpnC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSdSuuno6F2+O7e9xnTtHakMsVmWqOjNP5yz37f24ag=;
 b=P2NBRXjrH9YNtU07oVjzng4EbN2YK7+oclXfUhgA01SdtfMfeoZByWozR2tCNLSi0qq1rTbjsSGQAYLGbG+q2QUyA0QszjHdhIHg6zP+DJip4p0OoNq93QnOmExyGcK9Bnc5hxeip0UDislklB7LyVe34hLKwUJdfe5sa1SbWYiCpWy6pbgxCfILcXwc2Maw35rQpVF2skTafZTegGDWQOITfm0hlyv+rSBHIcljpZTww/xbYPwTZ5VYwvaw6RJiDsa8G+/zualeVAnFGW8FPJXCrsAV/ktJLLgkeyv2mgQa0+/GJR4bbsCE3GaU9Gyc+DahZrDKWM6cYbg7SLoRcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSdSuuno6F2+O7e9xnTtHakMsVmWqOjNP5yz37f24ag=;
 b=v8EGI9vq0mFKp7Mz3OrD4CP1MP/fI+ndvdGHfv4bj6WjIB+b9s+d0BwHb3gpaRy7v+q+VRe4emh7JghdLpHeiz4UBnx6EtRrQ6BMvb3Gjc+0SJetr+ZxSmRupdZI6l7H1P63VgW8YSwpk4sU6GM6GCK7AuXCm6gO8/MxIPb4u7Y=
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 08:14:21 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::28) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 08:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 08:14:20 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 03:14:17 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amd/pm: Add gpu_metrics_v1_8
Date: Wed, 26 Mar 2025 16:13:57 +0800
Message-ID: <20250326081400.1305136-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250326081400.1305136-1-asad.kamal@amd.com>
References: <20250326081400.1305136-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e77f0c5-b084-4cd1-ac6b-08dd6c3e3608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LSi1rFaoZQ97tQ4t2OYsM1Q3X7zWpJksdAzACs7EBtWC3DkfaoSImOGKYthw?=
 =?us-ascii?Q?PcQpXqdNbYzLfslcz4ubvrewF7Yf6ObtMvDuobMlSLtDH9dTOUqM3C2Wz7jf?=
 =?us-ascii?Q?mWaRSD/x2I2L+boHoMW5+qoOsDgfTCugj90UcWDQ1/jXc4PyhnAJ29uY7Ieh?=
 =?us-ascii?Q?qcSHjQaanPl7mVQftQtdLYi1QkHkv3pRbcWzAJ7ZhDZMc98NUh47qNFtXJvg?=
 =?us-ascii?Q?7Bs7bUbHlpUsjWl4VLdUMHaGFVoSCJgTrFXYGwkWId4l/6m1ubWshhNHBsq+?=
 =?us-ascii?Q?blf7U2sHDOeKgbmyz/WOY4qxbcZNicLN4P3R8jB6mrIh6SrEbUuzaHO9TKUJ?=
 =?us-ascii?Q?CrrF1cpliKZ2dAUYJenLxTeE7zfPUN+KcnrffaXuwsJiYUm1BrU4eL01QYtS?=
 =?us-ascii?Q?VAew3dREMum3JYdfwrqu4+ol2soPXqwiNVRFO90NURysLfTbX05fuS9UeFJM?=
 =?us-ascii?Q?+ftoyUIhIyQ3+0+T1xdKPNVbYLx4XYCk4xVO9Z0vdVfFbKXmNKeGmV58ZfJc?=
 =?us-ascii?Q?ohAllR3oLQSJL2talMIPkeJOiV4/+rg355GaSWUwxQkFDHBqbMsTGTJXu6Wr?=
 =?us-ascii?Q?ZdR8VweUzwXfUyRYfPXOwu4M3dm1QlSZQkB+hht1KlI5rM3RjrYFP5eTku0e?=
 =?us-ascii?Q?0muveIcAoh4Q5ebFXrfUzRfVYP3YDIJl+FB4CRnMVopvOPJNKAE6lKrbe+9V?=
 =?us-ascii?Q?q9wsKMd7SBOFJhLrYyn8hVki+qODkK5pjh8byTtUY0Rwk23VYP8nrDfxluDw?=
 =?us-ascii?Q?PyBKUjgW7OCN8kmtp2pAiV8YBVQ7Msu50GvrIIZNOOw1h9xLnGSmsfdARXd9?=
 =?us-ascii?Q?tNYqGWlqIGhAuOOlGKRsxkcn5w6MW6mOIOgLusB2hXrKdeIq84wBMxQMo6Wg?=
 =?us-ascii?Q?Cl0duE+M+kcTPgErQmGkCNe/eG7Ccp9JWxGXqpKf9gMMCJkRLvpKLC5zeJXj?=
 =?us-ascii?Q?P+UX/XMFDdGy4qsGgAdydNHCkY9Oqbed5pQAxTH1WFj03cyYKWNlAszk9lHk?=
 =?us-ascii?Q?r5ZVddFbfA5wrwT2WpnkS7SyL3pE7BXnW8txAS1U8Prm+eQHWxH1NoZzGnwf?=
 =?us-ascii?Q?gwMypJzrVRnxV7yVTaLidLRRNzkCNqC7cAxi8kYLa7Gk+i0EA/GAAq5WliHu?=
 =?us-ascii?Q?+MOXnRILwprrWDffa20SKonQELoIE87uR3hSTbelTsUhBEiAmAOQQNWsX3r+?=
 =?us-ascii?Q?OiA+gi7FU/OgOr1jhdPO0x866KH6TafyxizyBaxYJwxGhI3NVgcmz0qiXMwd?=
 =?us-ascii?Q?etY2sUsPuihx0kRJpw4lASRWgbIDKw6AFB5XPNmFlTQlHBTHXBCAhoCYZ3lA?=
 =?us-ascii?Q?EIMiHZYa231zcSCiyWaZv0y6AfXOCOgDaXaiVVVGjEu2/PRj29Oa5oCskgZm?=
 =?us-ascii?Q?mHXugGW2oJFdGe4GxMJZEsFi3FTZUpSeRVzhpBYvQAEVF93sBLIFodVTQuE9?=
 =?us-ascii?Q?yMUhLh47vEdBvQaj1SUWBBanEQG4bFvSSjXTCKr+o3jJoHPlQClDzy00xzm2?=
 =?us-ascii?Q?T8FC/I3yLX8Z1bs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:14:20.5226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e77f0c5-b084-4cd1-ac6b-08dd6c3e3608
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
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

Add new gpu_metrics_v1_8 to acquire below host limit counters

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 114 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   3 +
 2 files changed, 117 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 9189dcb65188..2a9606118d89 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -341,6 +341,7 @@ enum pp_policy_soc_pstate {
 #define MAX_CLKS 4
 #define NUM_VCN 4
 #define NUM_JPEG_ENG 32
+#define NUM_JPEG_ENG_V1 40
 #define MAX_XCC 8
 #define NUM_XCP 8
 struct seq_file;
@@ -376,6 +377,20 @@ struct amdgpu_xcp_metrics_v1_1 {
 	uint64_t gfx_below_host_limit_acc[MAX_XCC];
 };
 
+struct amdgpu_xcp_metrics_v1_2 {
+	/* Utilization Instantaneous (%) */
+	uint32_t gfx_busy_inst[MAX_XCC];
+	uint16_t jpeg_busy[NUM_JPEG_ENG_V1];
+	uint16_t vcn_busy[NUM_VCN];
+	/* Utilization Accumulated (%) */
+	uint64_t gfx_busy_acc[MAX_XCC];
+	/* Total App Clock Counter Accumulated */
+	uint64_t gfx_below_host_limit_ppt_acc[MAX_XCC];
+	uint64_t gfx_below_host_limit_thm_acc[MAX_XCC];
+	uint64_t gfx_low_utilization_acc[MAX_XCC];
+	uint64_t gfx_below_host_limit_total_acc[MAX_XCC];
+};
+
 struct amd_pm_funcs {
 /* export for dpm on ci and si */
 	int (*pre_set_power_state)(void *handle);
@@ -1090,6 +1105,105 @@ struct gpu_metrics_v1_7 {
 	uint32_t			pcie_lc_perf_other_end_recovery;
 };
 
+struct gpu_metrics_v1_8 {
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
+	struct amdgpu_xcp_metrics_v1_2	xcp_stats[NUM_XCP];
+
+	/* PCIE other end recovery counter */
+	uint32_t			pcie_lc_perf_other_end_recovery;
+};
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index d834d134ad2b..80eb1a03b3ca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1083,6 +1083,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 7):
 		structure_size = sizeof(struct gpu_metrics_v1_7);
 		break;
+	case METRICS_VERSION(1, 8):
+		structure_size = sizeof(struct gpu_metrics_v1_8);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
-- 
2.46.0

