Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42C6CCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B39410E6E6;
	Wed, 29 Oct 2025 03:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eLDcTuRf";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322C010E6E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJQwtWtlD7MZRc6euMOpHYcOrztsTWBTMSLRULuKN4rY4D/AveYVqYsNeabxrkuYy6Xsbg0cVue1GaX3zH3DK3rAOEgdff8+cfGaivoeX5anS8mqOQcx341KikTn/6M9fjpUNAWGtTr20V9ulIUtyB4DaKIt3ApSfbXp6YrSFzqDTpy2I2BCnLdwFmAsnQiRC3/RJTgBOi/WjyxjqQu8lH/T1SH5wZkD0oM+ErevdJc239wslAXiboOPIB/IALd74M1i9JsUVqu95QO9bvDIDAoSKm0IostntCLWSj97tWth0XwfBaTRKAGrThB6rbf61ntxbc8B00/Pt4ucLtZWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndAPRPmO2FLbLjvaP511lPzTy5uqB56F40bRWk4g9bg=;
 b=DuwL1PljTmVyGyh85lbPMiuDyU77rHOnhMX+k5Mug84FlGVk1qCjioM7edy1hfOBClX4fjQelCufKi3rq6D3A3QBkagML63FXJXzJUOKxPOIZL9vr1ngfQMS/h1WU60iFe+MV/deY0viyHBreuVW4eliQpcH3JQ4dYK4X+pRPjlx/zUs8df9dpdFvwOYBflq5Nqjp7rCunh6cNjBqHlbjs4blRvWOMNChV+3shJcV5v4/LhBY2NzUqQcTsuu8ivL8/b65KIpLW9PvlXkq2Q9cuLpw8I1aY7mp+8BfKlmZVXiHfle6heygaht8TCisqmn70Laxs/w2fTzGESrS4FZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndAPRPmO2FLbLjvaP511lPzTy5uqB56F40bRWk4g9bg=;
 b=eLDcTuRfudjsDX0Ojo43RMfhIRlmvm6o1C9rYszkPwew18OKE0zydYiN71iX2c7Iak7S0EV0VUwjwRxh9KJHMc0P/TBAvwYuHw6bR7OB4kNslfVwQ2IhrkCps8Ht2uQ77F2LwmBTlObr+61ZEscdJ2h2wIMidU9gs3aOZaU68v0=
Received: from SJ0PR13CA0081.namprd13.prod.outlook.com (2603:10b6:a03:2c4::26)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 03:11:09 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::aa) by SJ0PR13CA0081.outlook.office365.com
 (2603:10b6:a03:2c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 03:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:11:08 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 20:10:46 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:10:38 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 04/13] drm/amd/display: Remove old PMO options
Date: Wed, 29 Oct 2025 11:02:52 +0800
Message-ID: <20251029030935.2785560-5-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CYYPR12MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bfcada-5b14-48ae-2f53-08de1698ce93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZZ15TYtXtTif5wKfRsipRRIYrkSzFWJnznt+ZXqsugAIthUaxZqkVC7+Yu1I?=
 =?us-ascii?Q?/jUUOGO7A7CP68HItRgBacDfUdK5eWy8oNfO+CzuF73Uo87tLjrEg1U0cBDK?=
 =?us-ascii?Q?Ig0u6A0G+bFUfCQQXWJqPnw4XblUJduNJG8VZLsltuhCR0odVX/3ZX6fOm7i?=
 =?us-ascii?Q?GXzl3uT6durYz/38yocKXKW8xy1zzzxTuhPrE6fLE8OBfVbdk/P5keA7MVVL?=
 =?us-ascii?Q?hb9tHWMT4xV4e5lRnju7Y6TRWC7HJnGIzTlYa9Y8Sky1gY30gIQdXqgEt7VA?=
 =?us-ascii?Q?Y7R2BR/QQPEcNUQfgwbrVrxBwwKawIM9O/n1O32kNMWXdV1X6vTQPuA7oqDx?=
 =?us-ascii?Q?5UYPQAdf9Tr8LWkEpfFVdEWR1Hc5sfEMFJdt5fWR/YEETLrMOW82Yy7YCSSG?=
 =?us-ascii?Q?qQ7x9pDmUtEzxx3gvs8BPvR9jX3VJIyGrFoyNiAH34uJmUV70gbf4WM60y5/?=
 =?us-ascii?Q?jyTpL0qNiSbcl7LnIo8lacABjUVUiO1BXnTHYnJmBdhRXddlqY5axnMd3XEr?=
 =?us-ascii?Q?7IwcIWUnFbzQKTzD2zosVPPWPg2U7a3B4KiyjYdMMDDSkjj5pdjiv6VbvSx0?=
 =?us-ascii?Q?zegurnwgLl5mjtBNbHEuwpMYu86639yFaFx0gk3PSFnOCW4vL7S5WCa1PYxe?=
 =?us-ascii?Q?oCF2xY4aeguJgvm/ZtY/Q5e9TDCNQh+Ca0jSpBktRmhFEdmSAxUvXqF0VT4b?=
 =?us-ascii?Q?AhqmvTEPLv2wnDw9aA4EAq3IVdKOD/EEexFH4bTD5uYUooEqrdymG/YQRmNa?=
 =?us-ascii?Q?rtkxo2wR+FO4w8ZBbhIjkH8+lZNtoRbZ7ysAiwBLSDV57PYz0OOeCVRoSaV6?=
 =?us-ascii?Q?2GuLL/a5QzQ5dqQJGYXq7eWoLL864obApnYgUiEtnLzBxUmk6LzZNFzOtPmi?=
 =?us-ascii?Q?cpevXxDRVqP6/jEckfwAP5q4OYEeaWBDocT7AigcywBZ1tTKFdI69W+lg1uB?=
 =?us-ascii?Q?kb4queNZulEyzn+xuJvT885OZVyMl5jwT8HDbkrvnVH+ryyWNVr/puAP5iAL?=
 =?us-ascii?Q?6eMeD6/ixdfDBSYgZtALTGPA/m1gOv2Vp1kQetxuniO46+UREXCCcV4+X2cP?=
 =?us-ascii?Q?b1shHS8nLBbzzNqJDsfCzv7nOQpo/sq05pLd0Y0Q5vXqLDRahMSaRZmYGmIe?=
 =?us-ascii?Q?Y+vipTRFWg3mzXu5L02TP17RY1K2yLQs8HzL/tvptkGMBdcLAILGAGtJecnf?=
 =?us-ascii?Q?7xBMnTuchZ0vi9xSaggL8vjS9dMCMS5joBt+6/qkqzpZpWDbhagBxoOF+S6z?=
 =?us-ascii?Q?LCLLsBfo6hN0hHWTmPQrKR833mwQWFnMrqy2uT63Ir80nwSAfp3FppTIaxqp?=
 =?us-ascii?Q?3BeS66wMXD2TmskAmy+T7gKOGqKUa3lSf9sg+uc03cM/wbHZDf1a+H/L47PW?=
 =?us-ascii?Q?3n/U3tELoiIgmNOGUmrYlchv/yKP56UJOM0/mu+AH6OeMqwwNCTL3p8AnxA4?=
 =?us-ascii?Q?OGGgDbwCc3pqQL0RVPP+nxa2UgRxwhJtDU8twtgCM+pY0IH2RKzuNowlGCiY?=
 =?us-ascii?Q?xlsY51AxrYRzqdpbmtk79yUBnURXP5LxMsOREa27+bzqm04pwUs8LcWOCbPw?=
 =?us-ascii?Q?ag//ZLRihXSwIufiExY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:11:08.8407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bfcada-5b14-48ae-2f53-08de1698ce93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why & How]
Removes deprecated or unused PMO options.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h | 2 --
 .../dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h       | 4 ++--
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c      | 6 +-----
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
index 13749c9fcf18..da8e5c8b2244 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
@@ -423,7 +423,6 @@ struct dml2_stream_parameters {
 		bool disable_dynamic_odm;
 		bool disable_subvp;
 		int minimum_vblank_idle_requirement_us;
-		bool minimize_active_latency_hiding;
 
 		struct {
 			struct {
@@ -489,7 +488,6 @@ struct dml2_display_cfg {
 		bool synchronize_ddr_displays_for_uclk_pstate_change;
 		bool max_outstanding_when_urgent_expected_disable;
 		bool enable_subvp_implicit_pmo; //enables PMO to switch pipe uclk strategy to subvp, and generate phantom programming
-		unsigned int best_effort_min_active_latency_hiding_us;
 		bool all_streams_blanked;
 	} overrides;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
index 4a9a0d5a09b7..e87d04a734b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
@@ -89,8 +89,8 @@ struct dml2_soc_qos_parameters {
 
 struct dml2_soc_power_management_parameters {
 	double dram_clk_change_blackout_us;
-	double dram_clk_change_read_only_us;
-	double dram_clk_change_write_only_us;
+	double dram_clk_change_read_only_us; // deprecated
+	double dram_clk_change_write_only_us; // deprecated
 	double fclk_change_blackout_us;
 	double g7_ppt_blackout_us;
 	double g7_temperature_read_blackout_us;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 5769c2638f9a..abd210401fe2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1962,9 +1962,6 @@ static void reset_display_configuration(struct display_configuation_with_meta *d
 
 	for (stream_index = 0; stream_index < display_config->display_config.num_streams; stream_index++) {
 		display_config->stage3.stream_svp_meta[stream_index].valid = false;
-
-		display_config->display_config.stream_descriptors[stream_index].overrides.minimize_active_latency_hiding = false;
-		display_config->display_config.overrides.best_effort_min_active_latency_hiding_us = 0;
 	}
 
 	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
@@ -1997,7 +1994,6 @@ static void setup_planes_for_drr_by_mask(struct display_configuation_with_meta *
 			plane->overrides.uclk_pstate_change_strategy = dml2_uclk_pstate_change_strategy_force_drr;
 
 			display_config->stage3.pstate_switch_modes[plane_index] = dml2_pstate_method_fw_drr;
-
 		}
 	}
 }
@@ -2063,7 +2059,6 @@ static void setup_planes_for_vblank_by_mask(struct display_configuation_with_met
 					plane->overrides.reserved_vblank_time_ns);
 
 			display_config->stage3.pstate_switch_modes[plane_index] = dml2_pstate_method_vblank;
-
 		}
 	}
 }
@@ -2078,6 +2073,7 @@ static void setup_planes_for_vblank_drr_by_mask(struct display_configuation_with
 	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
 		if (is_bit_set_in_bitfield(plane_mask, plane_index)) {
 			plane = &display_config->display_config.plane_descriptors[plane_index];
+
 			plane->overrides.reserved_vblank_time_ns = (long)(pmo->soc_bb->power_management_parameters.dram_clk_change_blackout_us * 1000);
 
 			display_config->stage3.pstate_switch_modes[plane_index] = dml2_pstate_method_fw_vblank_drr;
-- 
2.43.0

