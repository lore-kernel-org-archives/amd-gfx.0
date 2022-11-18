Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A93C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D90D10E78C;
	Fri, 18 Nov 2022 17:00:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC32A10E78A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivypfae+gLJ1VE7zWDYarGmtGU0FoyZoDq1oMSPqpP99s6VQm6wlgZngvcTUFhpg6HkB0FYnfIEk0CMmeda6CuMWR2A2q7cmHxxhUgc2RHyNG8HwksOAgPgsnKdQNM+ySoCpInzTqCyj6FdLZAj/o1H/kslQiiEc8GSfdip8LH0JsuxdyzyA2eoZw/sPCYiPLXRW7lhVT/IyeTzkXzY2d2rjdBf7T3JIEXX5swJD2GiCyE62XGqHGAZ9kG2/25/VBi4jIC8bhKg3FGWFIcw2FVTTwu/wQeaYpPVWpDImfiEPH5+GlXvUBSUT++QS9kD4aJf6PTnNjnXmCEa4eowIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULeGN0NwqO/xbq8iwnZaLfYKZvf46oe2sIW1D0FkAK8=;
 b=VkKwXrWsvN4PzPsbav+ADztJaqwRKoWZkBiuJPlr6Yzd1dLCBPttHn5gp/CcA5mzttwymh+amb0bZ3mGfw1gkrQNl3cm/1A/2Syz69BJwVGXPxZxTL9c8TMnzQwlDo8UQVz2otk6kEpORisgpIW/NSdvSrKNdM2hsjSvgodUEaDTGRRdqs0NwBsbyiicieyfqvObvanmM3rn1o4++zNnRaoovCqQRuiV4nkBy/qTp9qlKH3iil4JApNx89/Ilnsks3Za5hqWUiXk1u3f2B/suCFo43KD2uF82GgGLrQsG81rLo94aRTkMSl44uplK5KBCZUr+VI9CyMrybvnNkGzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULeGN0NwqO/xbq8iwnZaLfYKZvf46oe2sIW1D0FkAK8=;
 b=BEHGAlykN72odDs0Qkp5QZebpXEvyFO7OXW0FGBLOe8UIRFCQOvY5fZQzuttPQuyKyGlMABnES8o/C8BJ96T4cfnkIx/Bk/w2OdShHNgs0ykE9Z/x85bPTKcgujlDuhJHRbF6iJyI251+XyhP1nI0J0TGWCkoj/YLBLQwR5h5oA=
Received: from MW4P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::33)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 16:59:51 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::41) by MW4P222CA0028.outlook.office365.com
 (2603:10b6:303:114::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 16:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 16:59:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:48 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:47 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 10:59:43
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/22] drm/amd/display: Update soc bounding box for
 dcn32/dcn321
Date: Fri, 18 Nov 2022 20:59:20 +0800
Message-ID: <20221118125935.4013669-8-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|BL1PR12MB5046:EE_
X-MS-Office365-Filtering-Correlation-Id: cd014996-d66c-4f3f-cc6a-08dac9864eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVEylGHp2t9cNCDCpWZkZGQhcXLH8vdpDBMGvkMMEiieaIDcbbsnw1JJeRgv8HC0+g7pA3ZvSrv6eaquBaIMaq+XQ3xOxrF0D+AQZn4uLtanq2gO0v/oVN3Pw3tY36i1FfP/WbAFLe8G8mKddS8gnY851mKL7KMCCA68zaBc6VR545GLXqJDL8mLjSzvdWVLkg+5SI+4DlJvsyeiaSaph4aR3fhAt9D2WIJw4g+m5c4jMSw+w2zTWXFW68xakO9/vEWpnlY0eWabFibHsUNpAVgT8nWzXNoC3XXCmXRG/3HTYheYfIys6cTTe8GxGyUMz4uB977+ALs8yDuykBvJ3FOOBxwLr9MBAij8+bmExowQ8OTBWin91FiP725UCiU/La3O6V84voEoDC69cO4zFnUfAbJmJyoym/q9PasRJlj4nxZa6qhSOA3MqfW6S3m57CByeVZ+kRqrPRGtsUe8fAVjB9IM+cKAnlvO8DjZaKBw5WHDmlCfdB5vHAoivu84jEocMDpvxj27nBpkzgOFOyvGlfWyCbgKNhUjjPkpvSghqlu2XnCmHqRG5pdbqVe/8nry9W364N9sUcdInnAx+ZBIcYPkIyAIK7s0EB9Db0VF3FTRkVv+AkMLeq0iPSnttcmVy3qCuxVBlE8HMMslMKCu2KH9MiU/bcAnakJmEhEtvtnP5eFlxjs/RTQE1E2HNj9KEDpgsXuEz7aL1569+flko2RzcClsRzMRgRKzzDVSFp1Nkga5ZqQZ7W4Wi1Odjx46sL62+T7QlaYrmc+9yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(478600001)(81166007)(83380400001)(356005)(40460700003)(36860700001)(82310400005)(86362001)(7696005)(8936002)(5660300002)(47076005)(336012)(426003)(2906002)(36756003)(82740400003)(4326008)(6666004)(1076003)(8676002)(70586007)(41300700001)(26005)(54906003)(2616005)(186003)(6916009)(70206006)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:59:51.2815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd014996-d66c-4f3f-cc6a-08dac9864eff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Description]
New values for soc bounding box and dummy pstate.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 6 +++---
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 97b333b230d1..61dbfa95eaa4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -157,7 +157,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
 	.dispclk_dppclk_vco_speed_mhz = 4300.0,
 	.do_urgent_latency_adjustment = true,
 	.urgent_latency_adjustment_fabric_clock_component_us = 1.0,
-	.urgent_latency_adjustment_fabric_clock_reference_mhz = 1000,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 3000,
 };
 
 void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr)
@@ -211,7 +211,7 @@ void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr)
 	/* 'DalDummyClockChangeLatencyNs' registry key option set to 0x7FFFFFFF can be used to disable Set C for dummy p-state */
 	if (clk_mgr->base.ctx->dc->bb_overrides.dummy_clock_change_latency_ns != 0x7FFFFFFF) {
 		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].valid = true;
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.pstate_latency_us = 38;
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.pstate_latency_us = 50;
 		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.fclk_change_latency_us = fclk_change_latency_us;
 		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us = sr_exit_time_us;
 		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
@@ -221,7 +221,7 @@ void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr)
 		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.min_uclk = min_uclk_mhz;
 		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.max_uclk = 0xFFFF;
 		clk_mgr->base.bw_params->dummy_pstate_table[0].dram_speed_mts = clk_mgr->base.bw_params->clk_table.entries[0].memclk_mhz * 16;
-		clk_mgr->base.bw_params->dummy_pstate_table[0].dummy_pstate_latency_us = 38;
+		clk_mgr->base.bw_params->dummy_pstate_table[0].dummy_pstate_latency_us = 50;
 		clk_mgr->base.bw_params->dummy_pstate_table[1].dram_speed_mts = clk_mgr->base.bw_params->clk_table.entries[1].memclk_mhz * 16;
 		clk_mgr->base.bw_params->dummy_pstate_table[1].dummy_pstate_latency_us = 9;
 		clk_mgr->base.bw_params->dummy_pstate_table[2].dram_speed_mts = clk_mgr->base.bw_params->clk_table.entries[2].memclk_mhz * 16;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 432b4ecd01a7..f4b176599be7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -126,9 +126,9 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 	.sr_enter_plus_exit_z8_time_us = 320,
 	.writeback_latency_us = 12.0,
 	.round_trip_ping_latency_dcfclk_cycles = 263,
-	.urgent_latency_pixel_data_only_us = 9.35,
-	.urgent_latency_pixel_mixed_with_vm_data_us = 9.35,
-	.urgent_latency_vm_data_only_us = 9.35,
+	.urgent_latency_pixel_data_only_us = 4,
+	.urgent_latency_pixel_mixed_with_vm_data_us = 4,
+	.urgent_latency_vm_data_only_us = 4,
 	.fclk_change_latency_us = 20,
 	.usr_retraining_latency_us = 2,
 	.smn_latency_us = 2,
@@ -156,7 +156,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
 	.dispclk_dppclk_vco_speed_mhz = 4300.0,
 	.do_urgent_latency_adjustment = true,
 	.urgent_latency_adjustment_fabric_clock_component_us = 1.0,
-	.urgent_latency_adjustment_fabric_clock_reference_mhz = 1000,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 3000,
 };
 
 static void get_optimal_ntuple(struct _vcs_dpi_voltage_scaling_st *entry)
-- 
2.25.1

