Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16810CD5BD1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B68110E508;
	Tue, 26 May 2026 07:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LJjUa33R";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8018F10E508
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjDBsqe9C2xBOnUm31l33OrWz8VsI4bPaJVdYApSO736ec5E0C8jWuvdu6dkyiCpIC6zZiwcYmWyECLB1Fa43D6OmqXlgFiNzL5SQRzJWZNhoXs4esfzaPe4I2UJ7/D8f9nZu51j8SAQn8Dl3gf3KWii5WfdxydqPnSUZrvEwYby2SPQqSt3CUqA/nyqf0NpqNs3osPe/5jNJjcsJPDf2hEc9ex2mrWVhTv8E2YsVc2CAzoG2beAFdGlUCmE8Gtt4oMp5A6BNR/XHI8LiK9QzziKIopBVvt9Eh+5dSNsQd/zQVwTaYPuRJP6ED1eVgETl5GyC2mHZMTC/SEhtVMxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypJMU9qClCfSvN43R7dzN9sTGl5DD/naABlfKxYi2oU=;
 b=kOKe2jBEpEtewOvDXpNvzFOW3js6vj9v+yiY66XNcL1l832/kt4oDI8Qh+/D9MUkwnvad6UDz+2Tenwu+cj4vjsR9OBPk2OwVmbLUexK9wokAKqcZl6XAhzMKB97vwZ4tWQX9KaPW2iQkkaKUGpJ6qr3Ptqg7pTCjity3x17+jfIsnkWszzOrmzQHgNyJ3+aQtJwRM6sT5DjFOyKt/DZhL9qfEkXuq4z3zSxuSozhws5fElPl30wQ3QuZWXw5Oye+hGQmnd66mgCwAhlhU2TpuRR8dpCya7p6VkSasLEJA0BLof3ffVs6JsMRSktswM0IL5vXOsr4wFzM7qH4/z3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypJMU9qClCfSvN43R7dzN9sTGl5DD/naABlfKxYi2oU=;
 b=LJjUa33RZ6hTuUeU8Z8LU6IAVoyswRqCkXiya6MPHkmUwWyUMNvWRQNwomQSP6WSdke2gGreRfg9CG/lp3RObiLuMkzxGDwVe5J8WXS5X08LC/wFjFoTF8pmvdLi6jHSVgpJR2KOL5kqjm4qguCCTS72mpMH9sWxJT82apackYs=
Received: from MN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:52f::16)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Tue, 26 May 2026 07:19:53 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::63) by MN0PR03CA0028.outlook.office365.com
 (2603:10b6:208:52f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:19:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:19:52 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:19:43 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 35/41] drm/amd/display: Add dcn42b_soc_bb to DML2
Date: Tue, 26 May 2026 15:01:58 +0800
Message-ID: <20260526071413.2181251-36-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: df152932-fad7-4650-821a-08debaf72e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|30052699003|1800799024|3023799007|22082099003|18002099003|11063799006|56012099003;
X-Microsoft-Antispam-Message-Info: hFrOSEALpWy2gwov05sbu5tpCFpFJ4nDtMCY3QOXcM4sIxiDNzVl9am5P4exHEQPocdU1cSEHMItAfnrtrn6xqtWorHege6uJbEVkdTMnd0+p3iAq+7XXs0lB9DuN9PRmkvLKuix4B1lNlRBBii1mWZa1mibkcW1OOwRYW6rRimiy6DflyB8DV/ZpCjV036R6Hxn6KC4tZgNgFPbitMjoyes5F5I+3d+2BIcgMGO0JRXC5Llyy0SOmPfal9+/gHHPaTDgFDAIF3eWzeYVyLb8F0CMCmtDpNWW4bYQWMRjElrUwbnyr39e3GehIC+QEcs8/E2XWnPzdg9fEHgCmfq63EAZvwJugbnVbHmLzWUF3X+RkPwq/X3rbYWwUnXvoEA/xFzq5hixqWF0T7cMRiDo82D909EPI6NlKz99Rhs8PDFJkH3dlZA58mGbJwSIRX1o6VV21Tt7uN6nBRkrML0Vo6Q7gvRg6NF90/vWIcmJ/M0AtjRl1lSBVPyfLoGJq9XJjvMn/3yitCWy1YmWxKIhFtjShbrkAe6ZtXTa1/zTLgNIfZEGrp8R9S/XJ1k191euq5ehAfV7pxP8MNSFYjucuRlOMQjyA2cmkEO+BpJyjSC34KoVxuthpXNZXYt86tHzO9ikGQ0dmrlyvZUDSJ9F3My4ZfNexBOj8WnvWik+1EgSTLA3iGA87847KjdKSir28dzKVsLlTVeaiRcujFjUUXU3y54Z8cZ4KunrKd4/94=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(30052699003)(1800799024)(3023799007)(22082099003)(18002099003)(11063799006)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EISWv2JtgK7ypFBvsdOkNnn6iLTa6kyIjLAVGjhce7flPoRmnNVYBBbZM0cr5jDB9JYgcRbgAm7gTtqTSSdLzO0/k8EpG5vv3MbRwaswQ/bJIE3i1hd3yobj3GjJNv4trRuXih6PNvBRRyCZ5rAEPyWH/tQoiYQfmJ7XgqAhyKsKg27j6fMVlLpNGxLSh6EeQg6NBiOWr1+6ERZbqhyUQrDH+8+LF6AxvtKqZd++oVGQjbK5EErgzfa4RIZybBI+6tPZgC25y2yKHtmUqOWpeaGxeyBJVA4XNKXR2NIUkzGqXcQfp3quw2bH325kxpsoQNtGmWiREzU/o9wvIP33DFZHj8cD/BgHLME2rutDja0an3Vc6o9hncKbBJWDgcdxK11YERDZmdRLUwdrypnOXCdYxIumQ2/CNVAre0FdujNOVo6hBgubTRIRqGwJ3QkF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:19:52.7570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df152932-fad7-4650-821a-08debaf72e33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
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

From: Matthew Stewart <matthew.stewart2@amd.com>

[Why & How]
Add bounding box for dcn42b

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  | 227 ++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
new file mode 100644
index 000000000000..ce4025591b87
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#ifndef __DML_DML_DCN42B_SOC_BB__
+#define __DML_DML_DCN42B_SOC_BB__
+
+#include "dml_top_soc_parameter_types.h"
+
+/* DCN42B Bounding Box values */
+static const struct dml2_soc_qos_parameters dml_dcn42b_variant_a_soc_qos_params = {
+	.derate_table = {
+		.system_active_urgent = {
+			.dram_derate_percent_pixel = 65,
+			.dram_derate_percent_vm = 30,
+			.dram_derate_percent_pixel_and_vm = 60,
+			.fclk_derate_percent = 80,
+			.dcfclk_derate_percent = 80,
+		},
+		.system_active_average = {
+			.dram_derate_percent_pixel = 30,
+			.dram_derate_percent_vm = 30,
+			.dram_derate_percent_pixel_and_vm = 30,
+			.fclk_derate_percent = 60,
+			.dcfclk_derate_percent = 60,
+		},
+		.dcn_mall_prefetch_urgent = {
+			.dram_derate_percent_pixel = 65,
+			.dram_derate_percent_vm = 30,
+			.dram_derate_percent_pixel_and_vm = 60,
+			.fclk_derate_percent = 80,
+			.dcfclk_derate_percent = 80,
+		},
+		.dcn_mall_prefetch_average = {
+			.dram_derate_percent_pixel = 30,
+			.dram_derate_percent_vm = 30,
+			.dram_derate_percent_pixel_and_vm = 30,
+			.fclk_derate_percent = 60,
+			.dcfclk_derate_percent = 60,
+		},
+		.system_idle_average = {
+			.dram_derate_percent_pixel = 30,
+			.dram_derate_percent_vm = 30,
+			.dram_derate_percent_pixel_and_vm = 30,
+			.fclk_derate_percent = 60,
+			.dcfclk_derate_percent = 60,
+		},
+	},
+	.writeback = {
+		.base_latency_us = 12,
+		.scaling_factor_us = 0,
+		.scaling_factor_mhz = 0,
+	},
+	.qos_params = {
+		.dcn32x = {
+			.loaded_round_trip_latency_fclk_cycles = 106,
+			.urgent_latency_us = {
+				.base_latency_us = 4,
+				.base_latency_pixel_vm_us = 4,
+				.base_latency_vm_us = 4,
+				.scaling_factor_fclk_us = 0,
+				.scaling_factor_mhz = 0,
+			},
+			.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+			.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+			.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
+		},
+	},
+	.qos_type = dml2_qos_param_type_dcn3,
+};
+
+static const struct dml2_soc_bb dml2_socbb_dcn42b = {
+	.clk_table = {
+		.wck_ratio = {
+				.clk_values_khz = {2},
+		},
+		.uclk = {
+				.clk_values_khz = {400000},
+				.num_clk_values = 1,
+		},
+		.fclk = {
+				.clk_values_khz = {1600000},
+				.num_clk_values = 1,
+		},
+		.dcfclk = {
+				.clk_values_khz = {800000},
+				.num_clk_values = 1,
+		},
+		.dispclk = {
+				.clk_values_khz = {1200000},
+				.num_clk_values = 1,
+		},
+		.dppclk = {
+				.clk_values_khz = {1200000},
+				.num_clk_values = 1,
+		},
+		.dtbclk = {
+				.clk_values_khz = {0},
+				.num_clk_values = 0,
+		},
+		.phyclk = {
+				.clk_values_khz = {810000},
+				.num_clk_values = 1,
+		},
+		.socclk = {
+				.clk_values_khz = {1600000},
+				.num_clk_values = 1,
+		},
+		.dscclk = {
+				.clk_values_khz = {400000},
+				.num_clk_values = 1,
+		},
+		.phyclk_d18 = {
+				.clk_values_khz = {667000},
+				.num_clk_values = 1,
+		},
+		.phyclk_d32 = {
+				.clk_values_khz = {625000},
+				.num_clk_values = 1,
+		},
+		.dram_config = {
+			.channel_width_bytes = 4,
+			.channel_count = 4,
+			.alt_clock_bw_conversion = true,
+		},
+	},
+
+	.qos_parameters = {
+		.derate_table = {
+			.system_active_urgent = {
+				.dram_derate_percent_pixel = 65,
+				.dram_derate_percent_vm = 30,
+				.dram_derate_percent_pixel_and_vm = 60,
+				.fclk_derate_percent = 80,
+				.dcfclk_derate_percent = 80,
+			},
+			.system_active_average = {
+				.dram_derate_percent_pixel = 30,
+				.dram_derate_percent_vm = 30,
+				.dram_derate_percent_pixel_and_vm = 30,
+				.fclk_derate_percent = 60,
+				.dcfclk_derate_percent = 60,
+			},
+			.dcn_mall_prefetch_urgent = {
+				.dram_derate_percent_pixel = 65,
+				.dram_derate_percent_vm = 30,
+				.dram_derate_percent_pixel_and_vm = 60,
+				.fclk_derate_percent = 80,
+				.dcfclk_derate_percent = 80,
+			},
+			.dcn_mall_prefetch_average = {
+				.dram_derate_percent_pixel = 30,
+				.dram_derate_percent_vm = 30,
+				.dram_derate_percent_pixel_and_vm = 30,
+				.fclk_derate_percent = 60,
+				.dcfclk_derate_percent = 60,
+			},
+			.system_idle_average = {
+				.dram_derate_percent_pixel = 30,
+				.dram_derate_percent_vm = 30,
+				.dram_derate_percent_pixel_and_vm = 30,
+				.fclk_derate_percent = 60,
+				.dcfclk_derate_percent = 60,
+			},
+		},
+		.writeback = {
+			.base_latency_us = 12,
+			.scaling_factor_us = 0,
+			.scaling_factor_mhz = 0,
+		},
+		.qos_params = {
+			.dcn32x = {
+				.loaded_round_trip_latency_fclk_cycles = 106,
+				.urgent_latency_us = {
+					.base_latency_us = 4,
+					.base_latency_pixel_vm_us = 4,
+					.base_latency_vm_us = 4,
+					.scaling_factor_fclk_us = 0,
+					.scaling_factor_mhz = 0,
+				},
+				.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+				.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+				.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
+			},
+		},
+		.qos_type = dml2_qos_param_type_dcn3,
+	},
+
+	/* Reuse of DCN42 params for LPDDR5/LPCAMM2 */
+	.power_management_parameters = {
+		.dram_clk_change_blackout_us = 36,
+		.fclk_change_blackout_us = 0,
+		.g7_ppt_blackout_us = 0,
+		.stutter_enter_plus_exit_latency_us = 14,
+		.stutter_exit_latency_us = 12,
+		.z8_stutter_enter_plus_exit_latency_us = 300,
+		.z8_stutter_exit_latency_us = 200,
+	},
+
+	.vmin_limit = {
+		.dispclk_khz = 632 * 1000,
+	},
+
+	.dprefclk_mhz = 600,
+	.xtalclk_mhz = 24,
+	.pcie_refclk_mhz = 100,
+	.dchub_refclk_mhz = 50,
+	.mall_allocated_for_dcn_mbytes = 64,
+	.max_outstanding_reqs = 256,
+	.fabric_datapath_to_dcn_data_return_bytes = 32,
+	.return_bus_width_bytes = 64,
+	.hostvm_min_page_size_kbytes = 4,
+	.gpuvm_min_page_size_kbytes = 256,
+	.gpuvm_max_page_table_levels = 1,
+	.hostvm_max_non_cached_page_table_levels = 2,
+	.phy_downspread_percent = 0.38,
+	.dcn_downspread_percent = 0.38,
+	.dispclk_dppclk_vco_speed_mhz = 3000,
+	.do_urgent_latency_adjustment = 0,
+	.mem_word_bytes = 0,
+	.num_dcc_mcaches = 0,
+	.mcache_size_bytes = 0,
+	.mcache_line_size_bytes = 0,
+	.max_fclk_for_uclk_dpm_khz = 2200 * 1000,
+};
+
+#endif
-- 
2.43.0

