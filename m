Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAA0D35660
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 01:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 034E910E5EE;
	Wed, 28 Jan 2026 01:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V9ZalQ8v";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5526510E5E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 01:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oz0cByD1WsFopbh5nqYfzA9rmXgbLLJFP7a58z5TshaWbRhrHOAo15RhIP6F3rRtMRJ/fEN0OsY+iYbR/WYJuLSlTnS4XGX/M+4i8WHWEl4HDZj08lt9cYutF3ClUjQBmhwbFMB7JSeD24O8fkW0iO7Vtu/QPFaQdyXdVphQRDJx+OoOE4qL1iOTzRXB2fSaw9xzqtMKxy3IECCsEUNvijTrdIk1edVZq+yGdSsHFI5hue51ygB1AOjDIVVjJJE1N7YRqcXpcItvRYcbRsQP/qjGG64NtxCH/t8Pp4/YCkhONkWg3yc6IR93FX/HfG8JLioJC0Lhnz99SUqm1c0HLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHKOU40fDtrkTPlO0Bq4y+dIZgpFRciOhI/N+oeC4xY=;
 b=jUrwqeEdIlKypatC3rKSzc+8ZE9MA0npSDHSDzkmCICvD4ML3KDJv7QtHMXrLkdM5G18oB5BgkL0+VocQsu/LQVuCtihYZOEQmCGKKmRaWVXzlYNoheYEYn8750OhpWzPlVILaOJOHapn5wQSpJxaGLW+B91Rh7oWjArzziVmnqJnRvSItpWxt/h2SEwABbqRMwiYwWTYDe2BArA8+sq9BfOJnvY3XLErkApOMaGnxkJv7ywqltuqrISDOtavmvGQ/SUIt5zpL70jVtvEljur8DE40qBRE3BXJw2aY5UJOzU5eruYlBkhjQ79zWSUrxJ04J+T3ufy1vMhbLzoByl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHKOU40fDtrkTPlO0Bq4y+dIZgpFRciOhI/N+oeC4xY=;
 b=V9ZalQ8v78WJ3t+6fkWjE5dbJr3e8mhG1hmzjSg2APM5qkSoRhu7FV4Zu57u9ThhdnLavrOf27BpFCE0bHneYq89j7LFKFhQ8ufLh7WGa/WRfxBwAfCeGIC2KYNgBrSj1X/BOo9HxwwXJGZTqgt2CQRzX1OyMHQnTtSLw+B/gGo=
Received: from MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27) by
 SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 01:59:18 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::c8) by MN2PR01CA0058.outlook.office365.com
 (2603:10b6:208:23f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 01:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 01:59:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:17 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:14 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 02/21] drm/amd/display: Add lpddr5 handling to dml2.1
Date: Wed, 28 Jan 2026 09:51:27 +0800
Message-ID: <20260128015538.568712-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db53479-48c5-4ea0-1f4a-08de5e10d8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6MTFJgCWml+Ic/VMVGIyj+0lohJqnLVroD+62bjwYpzlCdon7rai3Oqq55Rh?=
 =?us-ascii?Q?xBjRfbXhcv+7X2DBTUgnBKgbbzWLlZVFyr7lT2Z3M+HuZioKwM0nRof3uI1l?=
 =?us-ascii?Q?sLpm051l74lmidIK21/MjRhIuTLR/ckYVQ95P3UtaaZorthuG+FTLr1bBM4G?=
 =?us-ascii?Q?bLIw9JVh9ZYGtK71KYY3u7AyGMq+tG1uEaZC0as24uzR7Vjnm0h1Dlb5aom0?=
 =?us-ascii?Q?vovNfL6812EtkZzEh6CzSUsiuI8VxT2BbQlYmm4W4qrUETib7MhX6iYu8WY3?=
 =?us-ascii?Q?0Ox1tD6o4/ydrBXXF79AO5Yn/34zb+mqPnV4y49FJMCmkB3u27dXleRau5QM?=
 =?us-ascii?Q?prQrs9jSAvAQToX+rAEq5QRKKhtuhQXUOvWaWZATVG2H/xOG8Imf4fUtw3QV?=
 =?us-ascii?Q?hT25hKgnq62GYv1N4eb3qTfBtg1Uef8Mrl5bUASJ2iet9gEsQtr1a2aj3hYR?=
 =?us-ascii?Q?wSDbp/Rc/lSIHWgBNnLpmVChD5OTOjMPf4L2ARw0NFHJhhHfLn9FdHMPxOD8?=
 =?us-ascii?Q?68A0XymafubH4vfcIasMerVeS3mJwzVpZpyuq4SuNmL3CIxAjdVVgtI87mcM?=
 =?us-ascii?Q?jbDtYkTfgDfisH0g8j46kf1IROgXJLnNWtuOTJojltlpkQbMAWY3pOzjzhZX?=
 =?us-ascii?Q?SKDItxUYJBKebunYInMyCiTXuTdlVbfLSjOS+E9fk+taLfOwVqJh17LdP2s2?=
 =?us-ascii?Q?uCfFEu85P2zowEMde+kx8nVlSwKjFsiYuVAxS5FVcfcfuOiLBmHvYxFOt1SJ?=
 =?us-ascii?Q?o2O3kWcdNDHmFuqaJ86NHfGwEGtoiryRVrDKA0m+qJoiw9mWSXkjBEiwAzni?=
 =?us-ascii?Q?EBAXchFdyBBW3GtDU6932yP/MDQ9zSObnKgits+PWS4daD7vIYlJADnHeRAy?=
 =?us-ascii?Q?Qs+JrPSeXuFF0whxk1TDs7AaSJd224BNOhgr350qXYUWajY0LKN/FJ+gKNSG?=
 =?us-ascii?Q?2R2Tj9Txd2oNtNmXDY+QHJLTajTS0u5EkwOGM7C2O+omay5AMx9pmTayevM0?=
 =?us-ascii?Q?XKP3vt0ob5V59aCDMf9wvXiisOyoHpVMjlFa1wOs0q1FfRD+v2ZjfKyOqcFP?=
 =?us-ascii?Q?VdPH5kmNoEjSWSjeJPSJgK4kVQArbg56w+cMwcqYgcmgnxOt17YqYaTpfOoD?=
 =?us-ascii?Q?u5c2sZvPfdvwzD7K3ZA2tWXDqvdYQ5Usr+xrApw1iu5QpVzLpJcmdZlea09T?=
 =?us-ascii?Q?eoiOS/Ynck2NOoc8wu4yqD29/h84oaSxzH6nAg6wKQTiXOMhxp/BY7Bbzm5g?=
 =?us-ascii?Q?dCmAmupqUaXBG5sVnHSqiHuctOmH1JdHjt5T4maCrMs3XySuQCWBSjxBw0uj?=
 =?us-ascii?Q?JSRR9GJ+7EHWCFvICeDH7Czl6a7l9yxI0KJMc7vJ6QOSV2sq/6zllZxv7dha?=
 =?us-ascii?Q?/T21+6guFijPmVLDX4hw0gSqrfG5FV3oTvsBjdDC5P3bFkk8BgZ2GwG1ICVJ?=
 =?us-ascii?Q?UCCITcxrgqqH7bkd/Er76rM+l2mTa8UOwyhpA008UYfcujeAAFvCLwB7lNpH?=
 =?us-ascii?Q?lq3+AU2lUCAJObvBUoeGwy/rAOm1GrvK/1bhJqG3Tpj6moWDiKpf2N8zu6lF?=
 =?us-ascii?Q?2zKoDyexpbt2jimMzDhVugpR/u1fyefzhwf6hcVNbBZm2wlsdrhKFX+gT4KL?=
 =?us-ascii?Q?v4/KiJbqjUbiH25CTkkNCPip+tRneTwYeQq7Pg3FU6WF9jWkdOeEakEusx5A?=
 =?us-ascii?Q?GSTf9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:59:18.4532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db53479-48c5-4ea0-1f4a-08de5e10d8ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[Why & How]
Memory bandwidth calculations work differently than for ddr.
Add lpddr5 handling.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dml21/inc/dml_top_soc_parameter_types.h   |  3 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 26 ++++++--
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      | 59 ++++++++++++-------
 .../src/inc/dml2_internal_shared_types.h      |  1 +
 4 files changed, 64 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
index 1fbc520c2540..c4cce870877a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
@@ -115,9 +115,12 @@ struct dml2_dram_params {
 	unsigned int channel_width_bytes;
 	unsigned int channel_count;
 	unsigned int transactions_per_clock;
+	bool alt_clock_bw_conversion;
 };
 
+#define ENABLE_WCK
 struct dml2_soc_state_table {
+	struct dml2_clk_table wck_ratio;
 	struct dml2_clk_table uclk;
 	struct dml2_clk_table fclk;
 	struct dml2_clk_table dcfclk;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 01b87be24ce3..37699cc9e5c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7077,10 +7077,21 @@ static void calculate_excess_vactive_bandwidth_required(
 	}
 }
 
-static double uclk_khz_to_dram_bw_mbps(unsigned long uclk_khz, const struct dml2_dram_params *dram_config)
+static double uclk_khz_to_dram_bw_mbps(unsigned long uclk_khz, const struct dml2_dram_params *dram_config, const struct dml2_mcg_dram_bw_to_min_clk_table *dram_bw_table)
 {
 	double bw_mbps = 0;
-	bw_mbps = ((double)uclk_khz * dram_config->channel_count * dram_config->channel_width_bytes * dram_config->transactions_per_clock) / 1000.0;
+	int i;
+
+	if (!dram_config->alt_clock_bw_conversion)
+		bw_mbps = ((double)uclk_khz * dram_config->channel_count * dram_config->channel_width_bytes * dram_config->transactions_per_clock) / 1000.0;
+	else
+		for (i = 0; i < dram_bw_table->num_entries; i++)
+			if (dram_bw_table->entries[i].min_uclk_khz >= uclk_khz) {
+				bw_mbps = (double)dram_bw_table->entries[i].pre_derate_dram_bw_kbps / 1000.0;
+				break;
+			}
+
+	ASSERT(bw_mbps > 0);
 
 	return bw_mbps;
 }
@@ -7964,7 +7975,9 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	mode_lib->ms.max_dispclk_freq_mhz = (double)min_clk_table->max_ss_clocks_khz.dispclk / 1000;
 	mode_lib->ms.max_dscclk_freq_mhz = (double)min_clk_table->max_clocks_khz.dscclk / 1000;
 	mode_lib->ms.max_dppclk_freq_mhz = (double)min_clk_table->max_ss_clocks_khz.dppclk / 1000;
-	mode_lib->ms.uclk_freq_mhz = dram_bw_kbps_to_uclk_mhz(min_clk_table->dram_bw_table.entries[in_out_params->min_clk_index].pre_derate_dram_bw_kbps, &mode_lib->soc.clk_table.dram_config);
+	mode_lib->ms.uclk_freq_mhz = (double)min_clk_table->dram_bw_table.entries[in_out_params->min_clk_index].min_uclk_khz / 1000.0;
+	if (!mode_lib->ms.uclk_freq_mhz)
+		mode_lib->ms.uclk_freq_mhz = dram_bw_kbps_to_uclk_mhz(min_clk_table->dram_bw_table.entries[in_out_params->min_clk_index].pre_derate_dram_bw_kbps, &mode_lib->soc.clk_table.dram_config);
 	mode_lib->ms.dram_bw_mbps = ((double)min_clk_table->dram_bw_table.entries[in_out_params->min_clk_index].pre_derate_dram_bw_kbps / 1000);
 	mode_lib->ms.max_dram_bw_mbps = ((double)min_clk_table->dram_bw_table.entries[min_clk_table->dram_bw_table.num_entries - 1].pre_derate_dram_bw_kbps / 1000);
 	mode_lib->ms.qos_param_index = get_qos_param_index((unsigned int) (mode_lib->ms.uclk_freq_mhz * 1000.0), mode_lib->soc.qos_parameters.qos_params.dcn4x.per_uclk_dpm_params);
@@ -10407,7 +10420,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 
 	mode_lib->mp.Dcfclk = programming->min_clocks.dcn4x.active.dcfclk_khz / 1000.0;
 	mode_lib->mp.FabricClock = programming->min_clocks.dcn4x.active.fclk_khz / 1000.0;
-	mode_lib->mp.dram_bw_mbps = uclk_khz_to_dram_bw_mbps(programming->min_clocks.dcn4x.active.uclk_khz, &mode_lib->soc.clk_table.dram_config);
+	mode_lib->mp.dram_bw_mbps = uclk_khz_to_dram_bw_mbps(programming->min_clocks.dcn4x.active.uclk_khz, &mode_lib->soc.clk_table.dram_config, &min_clk_table->dram_bw_table);
 	mode_lib->mp.uclk_freq_mhz = programming->min_clocks.dcn4x.active.uclk_khz / 1000.0;
 	mode_lib->mp.GlobalDPPCLK = programming->min_clocks.dcn4x.dpprefclk_khz / 1000.0;
 	s->SOCCLK = (double)programming->min_clocks.dcn4x.socclk_khz / 1000;
@@ -10485,7 +10498,10 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 	DML_LOG_VERBOSE("DML::%s: SOCCLK = %f\n", __func__, s->SOCCLK);
 	DML_LOG_VERBOSE("DML::%s: min_clk_index = %0d\n", __func__, in_out_params->min_clk_index);
 	DML_LOG_VERBOSE("DML::%s: min_clk_table min_fclk_khz = %ld\n", __func__, min_clk_table->dram_bw_table.entries[in_out_params->min_clk_index].min_fclk_khz);
-	DML_LOG_VERBOSE("DML::%s: min_clk_table uclk_mhz = %f\n", __func__, dram_bw_kbps_to_uclk_mhz(min_clk_table->dram_bw_table.entries[in_out_params->min_clk_index].pre_derate_dram_bw_kbps, &mode_lib->soc.clk_table.dram_config));
+	if (min_clk_table->dram_bw_table.entries[in_out_params->min_clk_index].min_uclk_khz)
+		DML_LOG_VERBOSE("DML::%s: min_clk_table uclk_mhz = %f\n", __func__, min_clk_table->dram_bw_table.entries[in_out_params->min_clk_index].min_uclk_khz / 1000.0);
+	else
+		DML_LOG_VERBOSE("DML::%s: min_clk_table uclk_mhz = %f\n", __func__, dram_bw_kbps_to_uclk_mhz(min_clk_table->dram_bw_table.entries[in_out_params->min_clk_index].pre_derate_dram_bw_kbps, &mode_lib->soc.clk_table.dram_config));
 	for (k = 0; k < mode_lib->mp.num_active_pipes; ++k) {
 		DML_LOG_VERBOSE("DML::%s: pipe=%d is in plane=%d\n", __func__, k, mode_lib->mp.pipe_plane[k]);
 		DML_LOG_VERBOSE("DML::%s: Per-plane DPPPerSurface[%0d] = %d\n", __func__, k, mode_lib->mp.NoOfDPP[k]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index 22969a533a7b..5c713f2e6eca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -7,14 +7,24 @@
 #include "dml_top_types.h"
 #include "lib_float_math.h"
 
-static double dram_bw_kbps_to_uclk_khz(unsigned long long bandwidth_kbps, const struct dml2_dram_params *dram_config)
+static double dram_bw_kbps_to_uclk_khz(unsigned long long bandwidth_kbps, const struct dml2_dram_params *dram_config, struct dml2_mcg_dram_bw_to_min_clk_table *dram_bw_table)
 {
 	double uclk_khz = 0;
-	unsigned long uclk_mbytes_per_tick = 0;
 
-	uclk_mbytes_per_tick = dram_config->channel_count * dram_config->channel_width_bytes * dram_config->transactions_per_clock;
+	if (!dram_config->alt_clock_bw_conversion) {
+		unsigned long uclk_bytes_per_tick = 0;
 
-	uclk_khz = (double)bandwidth_kbps / uclk_mbytes_per_tick;
+		uclk_bytes_per_tick = dram_config->channel_count * dram_config->channel_width_bytes * dram_config->transactions_per_clock;
+		uclk_khz = (double)bandwidth_kbps / uclk_bytes_per_tick;
+	} else {
+		int i;
+		/* For lpddr5 bytes per tick changes with mpstate, use table to find uclk*/
+		for (i = 0; i < dram_bw_table->num_entries; i++)
+			if (dram_bw_table->entries[i].pre_derate_dram_bw_kbps >= bandwidth_kbps) {
+				uclk_khz = dram_bw_table->entries[i].min_uclk_khz;
+				break;
+			}
+	}
 
 	return uclk_khz;
 }
@@ -34,7 +44,7 @@ static void get_minimum_clocks_for_latency(struct dml2_dpmm_map_mode_to_soc_dpm_
 	*dcfclk = in_out->min_clk_table->dram_bw_table.entries[min_clock_index_for_latency].min_dcfclk_khz;
 	*fclk = in_out->min_clk_table->dram_bw_table.entries[min_clock_index_for_latency].min_fclk_khz;
 	*uclk = dram_bw_kbps_to_uclk_khz(in_out->min_clk_table->dram_bw_table.entries[min_clock_index_for_latency].pre_derate_dram_bw_kbps,
-		&in_out->soc_bb->clk_table.dram_config);
+		&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 }
 
 static unsigned long dml_round_up(double a)
@@ -53,14 +63,18 @@ static void calculate_system_active_minimums(struct dml2_dpmm_map_mode_to_soc_dp
 	double min_uclk_latency, min_fclk_latency, min_dcfclk_latency;
 	const struct dml2_core_mode_support_result *mode_support_result = &in_out->display_cfg->mode_support_result;
 
-	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.active.average_bw_dram_kbps, &in_out->soc_bb->clk_table.dram_config);
-	min_uclk_avg = (double)min_uclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100);
+	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.active.average_bw_dram_kbps
+											/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100),
+							&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
-	min_uclk_urgent = dram_bw_kbps_to_uclk_khz(mode_support_result->global.active.urgent_bw_dram_kbps, &in_out->soc_bb->clk_table.dram_config);
 	if (in_out->display_cfg->display_config.hostvm_enable)
-		min_uclk_urgent = (double)min_uclk_urgent / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel_and_vm / 100);
+		min_uclk_urgent = dram_bw_kbps_to_uclk_khz(mode_support_result->global.active.urgent_bw_dram_kbps
+										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel_and_vm / 100),
+							 &in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 	else
-		min_uclk_urgent = (double)min_uclk_urgent / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel / 100);
+		min_uclk_urgent = dram_bw_kbps_to_uclk_khz(mode_support_result->global.active.urgent_bw_dram_kbps
+										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel / 100),
+							 &in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
 	min_uclk_bw = min_uclk_urgent > min_uclk_avg ? min_uclk_urgent : min_uclk_avg;
 
@@ -97,11 +111,13 @@ static void calculate_svp_prefetch_minimums(struct dml2_dpmm_map_mode_to_soc_dpm
 	const struct dml2_core_mode_support_result *mode_support_result = &in_out->display_cfg->mode_support_result;
 
 	/* assumes DF throttling is enabled */
-	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.average_bw_dram_kbps, &in_out->soc_bb->clk_table.dram_config);
-	min_uclk_avg = (double)min_uclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.dcn_mall_prefetch_average.dram_derate_percent_pixel / 100);
+	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.average_bw_dram_kbps
+								/ ((double)in_out->soc_bb->qos_parameters.derate_table.dcn_mall_prefetch_average.dram_derate_percent_pixel / 100),
+						&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
-	min_uclk_urgent = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.urgent_bw_dram_kbps, &in_out->soc_bb->clk_table.dram_config);
-	min_uclk_urgent = (double)min_uclk_urgent / ((double)in_out->soc_bb->qos_parameters.derate_table.dcn_mall_prefetch_urgent.dram_derate_percent_pixel / 100);
+	min_uclk_urgent = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.urgent_bw_dram_kbps
+								/ ((double)in_out->soc_bb->qos_parameters.derate_table.dcn_mall_prefetch_urgent.dram_derate_percent_pixel / 100),
+						 &in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
 	min_uclk_bw = min_uclk_urgent > min_uclk_avg ? min_uclk_urgent : min_uclk_avg;
 
@@ -128,11 +144,13 @@ static void calculate_svp_prefetch_minimums(struct dml2_dpmm_map_mode_to_soc_dpm
 	in_out->programming->min_clocks.dcn4x.svp_prefetch.dcfclk_khz = dml_round_up(min_dcfclk_bw > min_dcfclk_latency ? min_dcfclk_bw : min_dcfclk_latency);
 
 	/* assumes DF throttling is disabled */
-	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.average_bw_dram_kbps, &in_out->soc_bb->clk_table.dram_config);
-	min_uclk_avg = (double)min_uclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100);
+	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.average_bw_dram_kbps
+										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100),
+								&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
-	min_uclk_urgent = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.urgent_bw_dram_kbps, &in_out->soc_bb->clk_table.dram_config);
-	min_uclk_urgent = (double)min_uclk_urgent / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel / 100);
+	min_uclk_urgent = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.urgent_bw_dram_kbps
+										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel / 100),
+								&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
 	min_uclk_bw = min_uclk_urgent > min_uclk_avg ? min_uclk_urgent : min_uclk_avg;
 
@@ -167,8 +185,9 @@ static void calculate_idle_minimums(struct dml2_dpmm_map_mode_to_soc_dpm_params_
 	double min_uclk_latency, min_fclk_latency, min_dcfclk_latency;
 	const struct dml2_core_mode_support_result *mode_support_result = &in_out->display_cfg->mode_support_result;
 
-	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.active.average_bw_dram_kbps, &in_out->soc_bb->clk_table.dram_config);
-	min_uclk_avg = (double)min_uclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.system_idle_average.dram_derate_percent_pixel / 100);
+	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.active.average_bw_dram_kbps
+										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_idle_average.dram_derate_percent_pixel / 100),
+								&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
 	min_fclk_avg = (double)mode_support_result->global.active.average_bw_sdp_kbps / in_out->soc_bb->fabric_datapath_to_dcn_data_return_bytes;
 	min_fclk_avg = (double)min_fclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.system_idle_average.fclk_derate_percent / 100);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index 1a6c0727cd2a..a6bd75f30d20 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -16,6 +16,7 @@
 
 struct dram_bw_to_min_clk_table_entry {
 	unsigned long long pre_derate_dram_bw_kbps;
+	unsigned long min_uclk_khz;
 	unsigned long min_fclk_khz;
 	unsigned long min_dcfclk_khz;
 };
-- 
2.43.0

