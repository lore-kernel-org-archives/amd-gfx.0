Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C6BEEB59B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 12:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB13E10EB62;
	Thu, 12 Sep 2024 12:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IV8Jh+wk";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5819A10EB62
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 12:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+7EooYgsYUEYrpTmRL881Awob8omFg3IIUiddw5SxQcl8wiAztohfp+Hf1CwAyh4M9ClNTRE1q2LqgsmP+tMp0E+vCShGZHUqksDBCJW4h+JUagLS4nfCsWiBoBYcebvpSeQWA3N9wOGvImnZV2D74T4eiNQgiZqZZRgEYdIB4SEzS/pOhkuSxNlTpW9eO+qrZoC+uYvmcpQC+uSyAjJy0v9PaxnKzO/bwXqy4VcREQy0F9IAs3UZNvvLOeh2Je/6o6Y/63U1Cc07m5xb7icsRVzDn3gBtfV66FFXBFpVDU58aSSkz+oWaw3qRG//uP0/fFjUbI6K8dwrR93IdFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNA9Mj3u1MC71MO1ykD9apHsBMHzo7z2r474WThdgIY=;
 b=e06QJtOw1CpxXxTtSCP56po9HaUTQC/ziR1/+Xyefr3SVBzz785DCxAwhWPOfakLl3WzhyU5DI1OmvdrZVrVUt8veMkSOzZFkx1atKT31/mX0x9Fp6rVB4WWTFXTZhcSzv1sACWphJymAfopWKH6kKGdZ0NLB/BULxkHtMilCZVu+6rIZZG1Wbv6NSWyz/NpwATuW2dPRn/199naFxaJTJXMsb2+o2zdkMKAeyrEXa3UHeyK1jDA4cFnE1x5dL1jr4wJq8r2Q5ZmGhAVxk4D4Nhf4GMB4E5p2qmK070CJI1bgXru5RNL9bmgJJ6D/xDvQ5DXISpj3nLfNXIUM0jEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNA9Mj3u1MC71MO1ykD9apHsBMHzo7z2r474WThdgIY=;
 b=IV8Jh+wkq7A2gSdT5Xdq7mvEjPqH1rPLGiV6Drazs9k2pUqvZ3dpcojUr5VuddL3qolt05LF7QFzjHb+RUYZiOxe2/VZDyz7tLGs29wXVWEmJNjCmcAMUcGoKQI6BFjJuospaaOQxqDx7c4FJzIVjqoI0wp7LN/F7zndZdJWzjM=
Received: from CH0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::28)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Thu, 12 Sep
 2024 12:00:16 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::d) by CH0P220CA0030.outlook.office365.com
 (2603:10b6:610:ef::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.18 via Frontend
 Transport; Thu, 12 Sep 2024 12:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 12:00:16 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 07:00:13 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 3/5] drm/amd/pm: Add gpu_metrics_v1_6
Date: Thu, 12 Sep 2024 19:59:45 +0800
Message-ID: <20240912115947.2208807-3-asad.kamal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dda96f3-c834-4411-e58e-08dcd322775c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p+mxTQOhuSsoCl16PMKDl8KEEVa41uU3CkVwoysZYd6DgJznfms9RCpDrDx4?=
 =?us-ascii?Q?XpMlPp8f6HDDfq43BhJ3YRFvA0HKLz0susmPbmzqAsZe6UKp5s2CNVfIV4QE?=
 =?us-ascii?Q?WaB/SF+aVMSo6NItvtxRX4V5dRc4/Qs0tkez7pTfXVg4W4WisjP0CB0mRNZa?=
 =?us-ascii?Q?9aBOQ5c9R0aSJ2UkBL0SNNAmSiaGfRPwDvS5gGQywII4EFx88K8Sg41QSs8p?=
 =?us-ascii?Q?KAxBeZkLmf+AUBPfUziCjKHcSpyIjPImFouXzNMEC/KBPPzT7J7Wt62JvhU1?=
 =?us-ascii?Q?LKA6kjv7BBmaYiUEU3B949EB+mGqIPBft71Bp5LIsbgJgizBkRi4aSdJphDW?=
 =?us-ascii?Q?iq/GoSgAWl2ZP0/B+nUU8wgM5TuAXBXcH8dF9B1xtnQmlO4WuBj1xv9ANEP4?=
 =?us-ascii?Q?QDU29V44wsdPhGonswBj9rxkvIkZxFCV3xwQ50nysdKp9ns5JV2axUpYXH0f?=
 =?us-ascii?Q?0RnyC3XFrFRhfWUB5KRFVSjoJ/rVj6iY61oMpDYNko2GjuN8XYNKStqmT3r7?=
 =?us-ascii?Q?x/8R6K8bhppcixhcHyHmtlgCCInefVV1JlT/iVf8ug5TUWT+YZbdNQ1p7Aqm?=
 =?us-ascii?Q?pJBPYCs1Wtj6ltDHMvNNM3jHeLenqrbgpblXUG8YCaj+V+yXXJAUXxZ+5sKD?=
 =?us-ascii?Q?ir+Ta958pYqYatYrLniJNpW9ncOUGSy5mWN8MeZANkGgcAxsWX5K5Z5c44yi?=
 =?us-ascii?Q?4dZYNp8wHwTbL+feQKZrdgeiZLIytI3Tgje/hf9XjuZmCfJWbZqV6mp8VsIY?=
 =?us-ascii?Q?Lh2WlhSYRIZ0y9QsSQEegO0njWBVKieDPHqCXMGjKB1jaTOMnTW+e0g3P9h6?=
 =?us-ascii?Q?GpQmI0oll0166u/abAj+B8gzdnX1CG7sTH6BdakpJcuqI88aO5JIUuTWHUsy?=
 =?us-ascii?Q?etpz8SnL2DXSBu2U+fHZ1AqCEWDC/OmDZZELhEGPKCDv7F241mkotKAn62qz?=
 =?us-ascii?Q?2FFuoQ9pOHpOLfrnKf0sZH/4MLock0Oz57U52I1nEF1vyY4IIPLpfnLLMoUQ?=
 =?us-ascii?Q?mL/0jfTMAnrl0O1C9B+pvxXm5XJlK22CmhDf23UUFCQJ0szLhyqMK2uMvlA/?=
 =?us-ascii?Q?2sRXmZVbzh2R3OC+5S4UIsrE5L6SmDZw6vnSM511AlJgHM2tvUEfdZuW003U?=
 =?us-ascii?Q?gOfBQEbKnSf+8Ly6eWd644N1R6w1U01etGR+EThRSPfSB54uyV+UfYBgOtWm?=
 =?us-ascii?Q?dJ+YlmHtR/OEoKQYfYrcF3Or4oHHPmyuJ+2+UCWXc0t17ABZxPku50AVE2Dv?=
 =?us-ascii?Q?sE5xLXHF6S6W9Vxvm1sMRKrR5fT6ffpRMIZpOoscQwugGMNeghC1OwB0epG3?=
 =?us-ascii?Q?jDreqdX3EEsVFm+/sa9mFkqwkHhReekXfSk4DQgcvIkYMhMu23p+CEZTeNUP?=
 =?us-ascii?Q?vBhd4etPWxh5gVy3/DNUpLVK9e0Pao+VV92vUNyDXAwGGWxhW6UdWb+daN1v?=
 =?us-ascii?Q?/LPq97V8/WE70oxZ/0kGSjuIS2xlcFMT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 12:00:16.3912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dda96f3-c834-4411-e58e-08dcd322775c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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

Add new gpu_metrics_v1_6 with activities per partition

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 103 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   3 +
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 19a48d98830a..2fa71f68205e 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -336,7 +336,8 @@ enum pp_policy_soc_pstate {
 #define MAX_CLKS 4
 #define NUM_VCN 4
 #define NUM_JPEG_ENG 32
-
+#define MAX_XCC 8
+#define NUM_XCP 8
 struct seq_file;
 enum amd_pp_clock_type;
 struct amd_pp_simple_clock_info;
@@ -350,6 +351,15 @@ struct pp_smu_wm_range_sets;
 struct pp_smu_nv_clock_table;
 struct dpm_clocks;
 
+struct amdgpu_xcp_metrics {
+	/* Utilization Instantaneous (%) */
+	u32 gfx_busy_inst[MAX_XCC];
+	u16 jpeg_busy[NUM_JPEG_ENG];
+	u16 vcn_busy[NUM_VCN];
+	/* Utilization Accumulated (%) */
+	u64 gfx_busy_acc[MAX_XCC];
+};
+
 struct amd_pm_funcs {
 /* export for dpm on ci and si */
 	int (*pre_set_power_state)(void *handle);
@@ -872,6 +882,97 @@ struct gpu_metrics_v1_5 {
 	uint16_t			padding;
 };
 
+struct gpu_metrics_v1_6 {
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
+	struct amdgpu_xcp_metrics	xcp_stats[NUM_XCP];
+
+	/* PCIE other end recovery counter */
+	uint32_t			pcie_lc_perf_other_end_recovery;
+};
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 88eefef05fae..63c4f75fa118 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1078,6 +1078,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 5):
 		structure_size = sizeof(struct gpu_metrics_v1_5);
 		break;
+	case METRICS_VERSION(1, 6):
+		structure_size = sizeof(struct gpu_metrics_v1_6);
+		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
-- 
2.46.0

