Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42B9C54E71
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 15:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D3A112588;
	Fri, 22 Mar 2024 15:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xWfQ9ak6";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B81112588
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 15:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asf+MVvhTNGX5DCDmU5vDTBYoaKlfa00wxUJgeZ7FMxfSNRnAnGwZahfUjqknAEd/WZBSZVlwPLlRMdE76qIXJ2lN6crPBYvWLvNw3kEur2XEsoUVTvvxTAqXUlyLzyLEOKQlwWNFCaUZdFBsUn04omN3JctH9HxxfsAlF7M0Ky+rzv9nXjollXfqJBA6KNRjftWgp5AajuiX5Dru2NwCPRlWq4ZmYFMBfCh/FGU4g77VACJID47ok6imuR5GNygZbvUCspKiSATNv2Jgbh0KFXVy1D2gHWz19bjioWf3cThxSmYlpfV6gU1xsgTQEMyPgFpznUEaooc5K0uUm+xGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsKCSQ41rU8aIqOtLDWMnqpe049tumADW0FmcgM3w30=;
 b=JjMwSbXtdxez/8kaGw2vb6SiFkA4tH+akiJecidlFTbM+0IXOMQyEbVvhdp1vSm50eH+Dif+EIRKzoJKOibZWPtJPq0d0tj3WSGCamvgNyVlCZqsTbFy4dk3izzNqurW1+v5PuUZ1flMVKcv382gw9tFFGhA7JjrZ5mSwPg6pa1iJpjdV6XFPcENtfN4IDq0qRAG5Rc/oPk/8hlkOyRfEfyLrzzhYME0Z3yr+mIgHbPm8wg2c0EmGc3lCw30UtKIwonJasi987xhp9RO7h/oFODc0NdHpG+lvbB1h94JW4zsVw0tmcrqKvcaAbubMPSh2RoUP63I/JelPjTyp6CUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsKCSQ41rU8aIqOtLDWMnqpe049tumADW0FmcgM3w30=;
 b=xWfQ9ak67zG2zaaYfCNIPLXDT8cHzqipa+jOBzGnHZPnWlCTtdgP7Far+u3VXbPlUwFYqk9xYkVoJXPB33V1gCLqIYFmc2/plm4xNDeKaI4p/OAgAuyY5X38VLwtYQKE+iC31Z9FxXzI3k2V4y9j6zXMcE5BuZ+pzq20lOo/yV4=
Received: from BL1PR13CA0301.namprd13.prod.outlook.com (2603:10b6:208:2c1::6)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 15:46:45 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::61) by BL1PR13CA0301.outlook.office365.com
 (2603:10b6:208:2c1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Fri, 22 Mar 2024 15:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 15:46:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 10:46:44 -0500
Received: from roma-lnx-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 22 Mar 2024 10:46:43 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <mario.limonciello@amd.com>, <Yifan1.Zhang@amd.com>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <hamza.mahfooz@amd.com>, <chiahsuan.chung@amd.com>,
 <xiliu102@amd.com>, Sung Joon Kim <sungkim@amd.com>
Subject: [PATCH IP-REVIEW] drm/amd/display: Update dcn351 to latest dcn35
 config
Date: Fri, 22 Mar 2024 11:46:30 -0400
Message-ID: <1711122390-12109-1-git-send-email-Roman.Li@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1788ea-c76e-468d-5cf0-08dc4a874730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3rIcIBdSyA6BkbhvgC28+YFhq1F/04dDlhfQ2K8lfcoZXn0yrkBis8ze7UhriXx0SJPIpiZK1532Y6q069tW+EtCn2LWLsLUqcxXN/qPg9kZvLx39b+QccIizMmhqUkTil5UyERh7ExbRkriWD0wAQZAxcyt4ph0YfhHJbLZ0JTpXOE/6sempmy1knKKfDdU3lilDG/y83e94V7weRaiwt56YWuV52H+k8BCyE8B+umt1BiANlZrWFGTjQAgRawDgAadVJrvEfVz72kBVQkt5q9A+w1BbqjpwWtw4ICdWVbnwhGBNB91VBs17Vghip/+3/CqWiwGinl/NbxDez+WMj6655WzSAsBQCew9GHDZSwHON8rmXkMYBUr9CM/tEhR8/umr9wTPiZny1hLuD4hWqf50oi0NKgzIkNWLOIQAsyHegvJB2Ci4z8JaYbqPxUjWLeT7Zju89bIRfLUnHzTfC6i+KOzdqKEUQZmbGysHd0TDG3e76qBW6U//kEMoHtwh8R/Q+7xax/CvRb/ap353rTJs8Nc4lwnf2E0BDktWwH6sSHg5ihYE621PyruiQ4dxBZ9P4YlNZrbxkirFsNlQt/gUGuYKPP3TEwHuF6SgGilL85w0mtgkJVPgFkpQ5ruJsFb625FJiH1N84tIKV+6FjJBVdsulHMR0bZFIK26m+NYfR6SH98EKOvvFMOwMT/2Daj6wIe4Tep73zXAy4NwVk0ua6pXJe0v7xrKKoyoSn94KK8BQHQUvxCIYV08K4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 15:46:45.2816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1788ea-c76e-468d-5cf0-08dc4a874730
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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

From: Sung Joon Kim <sungkim@amd.com>

[why & how]
There were some fixes in dcn35 that need
to be ported over to dcn351 to prevent any
regression.

Signed-off-by: Sung Joon Kim <sungkim@amd.com>
Reviewed-by: Liu, Xi (Alex) <xiliu102@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c        |  9 ++++++---
 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c      |  2 +-
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 11 ++++++++---
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index b624640..b3ffab7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -402,6 +402,8 @@ void dcn351_update_bw_bounding_box_fpu(struct dc *dc,
 				clock_limits[i].socclk_mhz;
 			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].memclk_mhz =
 				clk_table->entries[i].memclk_mhz * clk_table->entries[i].wck_ratio;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dtbclk_mhz =
+				clock_limits[i].dtbclk_mhz;
 			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels =
 				clk_table->num_entries;
 			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_fclk_levels =
@@ -414,6 +416,8 @@ void dcn351_update_bw_bounding_box_fpu(struct dc *dc,
 				clk_table->num_entries;
 			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_memclk_levels =
 				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dtbclk_levels =
+				clk_table->num_entries;
 		}
 	}
 
@@ -613,6 +617,7 @@ void dcn351_decide_zstate_support(struct dc *dc, struct dc_state *context)
 		if (context->res_ctx.pipe_ctx[i].plane_state)
 			plane_count++;
 	}
+
 	/*dcn351 does not support z9/z10*/
 	if (context->stream_count == 0 || plane_count == 0) {
 		support = DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY;
@@ -626,11 +631,9 @@ void dcn351_decide_zstate_support(struct dc *dc, struct dc_state *context)
 			dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
 
-
 		/*for psr1/psr-su, we allow z8 and z10 based on latency, for replay with IPS enabled, it will enter ips2*/
-		 if (is_pwrseq0 && (is_psr || is_replay))
+		if (is_pwrseq0 && (is_psr || is_replay))
 			support = allow_z8 ? allow_z8 : DCN_ZSTATE_SUPPORT_DISALLOW;
-
 	}
 	context->bw_ctx.bw.dcn.clk.zstate_support = support;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index ab17fa1..670255c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -67,7 +67,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.prepare_bandwidth = dcn35_prepare_bandwidth,
 	.optimize_bandwidth = dcn35_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
-	.set_drr = dcn10_set_drr,
+	.set_drr = dcn35_set_drr,
 	.get_position = dcn10_get_position,
 	.set_static_screen_control = dcn35_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 2dfd73d..fe13c89 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -700,6 +700,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.disable_dpp_power_gate = true,
 	.disable_hubp_power_gate = true,
+	.disable_optc_power_gate = true, /*should the same as above two*/
+	.disable_hpo_power_gate = true, /*dmubfw force domain25 on*/
 	.disable_clock_gate = false,
 	.disable_dsc_power_gate = true,
 	.vsr_support = true,
@@ -742,12 +744,13 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.seamless_boot_odm_combine = DML_FAIL_SOURCE_PIXEL_FORMAT,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
+	.minimum_z8_residency_time = 2100,
 	.using_dml2 = true,
 	.support_eDP1_5 = true,
 	.enable_hpo_pg_support = false,
 	.enable_legacy_fast_update = true,
 	.enable_single_display_2to1_odm_policy = true,
-	.disable_idle_power_optimizations = true,
+	.disable_idle_power_optimizations = false,
 	.dmcub_emulation = false,
 	.disable_boot_optimizations = false,
 	.disable_unbounded_requesting = false,
@@ -758,8 +761,10 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = true,
 	.ignore_pg = true,
 	.psp_disabled_wa = true,
-	.ips2_eval_delay_us = 200,
-	.ips2_entry_delay_us = 400
+	.ips2_eval_delay_us = 2000,
+	.ips2_entry_delay_us = 800,
+	.disable_dmub_reallow_idle = true,
+	.static_screen_wait_frames = 2,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.7.4

