Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7D3C6FA99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 17:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BF710E315;
	Fri, 10 Mar 2023 17:49:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274EB10E315
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 17:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjbmVuDfQyzRt209Mk3aKNlOrwVn5D5WDaEnbP3ttpsYSSlb4+Q4NLLjEm4VGR5ZAlOqp7XQijEQ6EP0A/+PyUupMCodDbeb92F3IfYr6kgWJZyLB7tKkOOsWlF4KceCMkjoV3N0K9N28MlNydv/tfvOlvb24Skz2xpIcWt24L/6rdS2roRSxzpQQbTxlmTF8fCoT4TcOtG8jlNwGN1EoN/J05aEoiHhsoBKney3RWg2UoMGS47Mng1xkRObuzO71JPemQ6FbtEzaTvphuK8vaJ/KMLx8aI+AROQW5gmhpk4cm8E49zlC9QZWMxBATgB3vu30SwuQb7o51hd4xxRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amp1rfsMuSPCwhiq9INv/Z9errusE/graz/S3H6JACQ=;
 b=JgV2X3cC0EZ3D4P71XJa/dVQbT+RNc5A5+ScumlerCtaEx1M8vbqk7rBgxx1DQUAkIkeozEDP1O5IfdnWW+MJYgCGNErUhkGXquNXPXVE7d6YzeaZbAvOoRHofVUC/PX+B1NY1p6rDuf6BudF1gKASQanwwj+YDReLf72NM2aNmQ+nxJC8tEyGDBkg/XA8FrduYGmIarP6uRnKgty7RcnwulvLhTjZK73y/8qiF3/dxvep97AT50uBmI+wUtGhAOsWMPI0a19OGVfji9pqwdEeNijwJq5r2Ow+58h6jpyWCK6HZBWNvjX8Ryp4dE5hF5Ty2NQITr+eMDEGL+ZPDVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amp1rfsMuSPCwhiq9INv/Z9errusE/graz/S3H6JACQ=;
 b=Pa8UW5w3X/rgyR4+vIpUAXDN/hxHtEwxpj794O9Poc6hQ7095TKT5OwEenI8yeuZC9mxh5yTjIw1Is4trIp6UOIWuOrHHm3HiCQ/DAwz7WHl7s0rK7LbQrcZOVyF1UlyRmL/0gLJB7B5Q8O5fFT7HZAWoTRCZkHcPwJYZv5T2sw=
Received: from DM6PR17CA0028.namprd17.prod.outlook.com (2603:10b6:5:1b3::41)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:48:57 +0000
Received: from DS1PEPF0000E64A.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::e0) by DM6PR17CA0028.outlook.office365.com
 (2603:10b6:5:1b3::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 17:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E64A.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 17:48:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 11:48:55 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Fri, 10 Mar 2023 11:48:50 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Enable FAMS for DCN3x
Date: Fri, 10 Mar 2023 12:48:49 -0500
Message-ID: <20230310174849.1619771-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310174849.1619771-1-aurabindo.pillai@amd.com>
References: <20230310174849.1619771-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64A:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: efd40151-b59c-44f5-dabd-08db218fb8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6Bs27WbUYA4SBbamnUmn4D2YQQkykxN0bSk/SyU1gmkerezyIQwSngMyIgX+uPaXOmbMRnFXZ+7CWx8toZzHoEOm0nkGi0gqoheqFIhXXx3NYvcXyY8FVPaLzBKTek3ey46bHQWzK+EHCFQM5ANJPAfwoXlZxCBgh4xKMogMKEP7xNbR73hOnqElQvHULMlAYR6TlmZsiuCGarrUbx+gghcxng0OeybruJREw5eE7GfYjWH3kiRFDMc5+CWrYBpI1pakWUkz4CIWa/FUaIEEbLgbETJEaEeBBFqT5RTJCt7HgaZATYWwjQSsbReBb6pnrKSkog/oFBiQjC3kmiXp+gP8T5ETe4WbHHga+F4xokCG9ofctoDTKGK19UJuu3234l5PgXZhrMa3W0FoPCcUdczz11SNeQTXnmcFLuPckWi0ZxzwWUfv2Q4UPOPKNDWDm5rVvxNOj6oKqZK5nOVLSXJyWHqpNmNQEerwJT/WpVvlvzIkEepSlxpG8IhjjlbamBe1OjDJRz553cXKl/R/oagF5hQoOqy1ctLeNVjFdOmpVNOu9qNu5vlTfBnzrf9qrcicjTGRYWQXROEXH+MzDMVmW8j5DljtEGck/vOWuzr8bekAoYzkdxwRFbeu2mQvi3TrVQBHdItfWw7Xb7KvYsk0vbSGgj59lYVXakuirzWXDAfGdpb0Fx002t3q0SKfTEd5pLX2nsuZbl1TwP+Nh5I0BhGEzKspOpxZC79Kj/csl2j1slzLzMLSeQPV5Uv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(2906002)(83380400001)(7696005)(36756003)(44832011)(40460700003)(26005)(30864003)(5660300002)(186003)(40480700001)(41300700001)(8676002)(2616005)(316002)(86362001)(47076005)(6916009)(356005)(426003)(4326008)(70586007)(70206006)(336012)(81166007)(478600001)(8936002)(82740400003)(1076003)(54906003)(36860700001)(82310400005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:48:56.5175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd40151-b59c-44f5-dabd-08db218fb8b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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
Cc: harry.wentland@amd.com, aurabindo.pillai@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, hamza.mahfooz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Firmware Assisted Memclk Switching enables lowering mclk using DMCUB
when it cannot be normally done due to not having enough time within
vblank. FAMS extends vblank on monitors that support variable refresh
rate thereby allowing enough time to do an mclk switch sequence
during vblank.

When tested with 4k@144Hz monitor on DCN32, power consumption of about
40W was saved since multiple clocks like MCLK, SOCCLK, and FCLK
were brought down.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  7 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |  3 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  4 ++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  2 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  2 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 71 ++++++++++++++++---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  5 ++
 7 files changed, 84 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 08b92715e2e6..9963bffb1e07 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -301,7 +301,12 @@ void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc)
 
 void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
 {
-	optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
+	struct dc *dc = optc->ctx->dc;
+
+	if (dc->caps.dmub_caps.mclk_sw && !dc->debug.disable_fams)
+		dc_dmub_srv_drr_update_cmd(dc, optc->inst, vtotal_min, vtotal_max);
+	else
+		optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
 }
 
 void optc3_tg_init(struct timing_generator *optc)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index 8e6b8b7368fd..d8805618a9a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -102,6 +102,9 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 
 bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context);
 void dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context);
+
+void dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context);
+
 int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes, int pipe_cnt, int vlevel);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 80a0c5a575a9..40080113ed5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -295,6 +295,10 @@ void dcn31_init_hw(struct dc *dc)
 	if (dc->res_pool->hubbub->funcs->init_crb)
 		dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub);
 #endif
+	/* Get DMCUB capabilities */
+	dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
+	dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
+	dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
 }
 
 void dcn31_dsc_pg_control(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index f87db2271924..3220f9ad8a47 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -919,6 +919,8 @@ void dcn32_init_hw(struct dc *dc)
 	if (dc->ctx->dmub_srv) {
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
+		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
+
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 100b6df33b33..b1944e49a65d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2013,7 +2013,7 @@ int dcn32_populate_dml_pipes_from_context(
 	// In general cases we want to keep the dram clock change requirement
 	// (prefer configs that support MCLK switch). Only override to false
 	// for SubVP
-	if (subvp_in_use)
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || subvp_in_use)
 		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = false;
 	else
 		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 4fa636364793..53f21b0b3630 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -368,7 +368,9 @@ void dcn30_fpu_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
 	dc_assert_fp_enabled();
 
 	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching ||
+				context->bw_ctx.dml.soc.dram_clock_change_latency_us == 0)
+			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
 		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
 	}
@@ -384,9 +386,34 @@ void dcn30_fpu_calculate_wm_and_dlg(
 	int i, pipe_idx;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][maxMpcComb];
 	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] != dm_dram_clock_change_unsupported;
+	unsigned int dummy_latency_index = 0;
 
 	dc_assert_fp_enabled();
 
+	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
+
+	if (!pstate_en) {
+		/* only when the mclk switch can not be natural, is the fw based vblank stretch attempted */
+		context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching =
+			dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(dc, context);
+
+		if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+			dummy_latency_index = dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(dc,
+				context, pipes, pipe_cnt, vlevel);
+
+			/* After calling dcn30_find_dummy_latency_index_for_fw_based_mclk_switch
+			 * we reinstate the original dram_clock_change_latency_us on the context
+			 * and all variables that may have changed up to this point, except the
+			 * newly found dummy_latency_index
+			 */
+			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+			dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false, true);
+			maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
+			dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+			pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] != dm_dram_clock_change_unsupported;
+		}
+	}
+
 	if (context->bw_ctx.dml.soc.min_dcfclk > dcfclk)
 		dcfclk = context->bw_ctx.dml.soc.min_dcfclk;
 
@@ -449,15 +476,29 @@ void dcn30_fpu_calculate_wm_and_dlg(
 		unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
 		unsigned int min_dram_speed_mts_margin = 160;
 
-		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_unsupported)
-			min_dram_speed_mts = dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz * 16;
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+			dc->clk_mgr->bw_params->dummy_pstate_table[0].dummy_pstate_latency_us;
 
-		/* find largest table entry that is lower than dram speed, but lower than DPM0 still uses DPM0 */
-		for (i = 3; i > 0; i--)
-			if (min_dram_speed_mts + min_dram_speed_mts_margin > dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts)
-				break;
+		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] ==
+			dm_dram_clock_change_unsupported) {
+			int min_dram_speed_mts_offset = dc->clk_mgr->bw_params->clk_table.num_entries - 1;
+
+			min_dram_speed_mts =
+				dc->clk_mgr->bw_params->clk_table.entries[min_dram_speed_mts_offset].memclk_mhz * 16;
+		}
 
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+			/* find largest table entry that is lower than dram speed,
+			 * but lower than DPM0 still uses DPM0
+			 */
+			for (dummy_latency_index = 3; dummy_latency_index > 0; dummy_latency_index--)
+				if (min_dram_speed_mts + min_dram_speed_mts_margin >
+					dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dram_speed_mts)
+					break;
+		}
+
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+			dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
 
 		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
 		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
@@ -520,6 +561,20 @@ void dcn30_fpu_calculate_wm_and_dlg(
 		pipe_idx++;
 	}
 
+	/* WA: restrict FW MCLK switch to use first non-strobe mode (Beige Goby BW issue) */
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching &&
+			dc->dml.soc.num_chans <= 4 &&
+			context->bw_ctx.dml.vba.DRAMSpeed <= 1700 &&
+			context->bw_ctx.dml.vba.DRAMSpeed >= 1500) {
+
+		for (i = 0; i < dc->dml.soc.num_states; i++) {
+			if (dc->dml.soc.clock_limits[i].dram_speed_mts > 1700) {
+				context->bw_ctx.dml.vba.DRAMSpeed = dc->dml.soc.clock_limits[i].dram_speed_mts;
+				break;
+			}
+		}
+	}
+
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
 	if (!pstate_en)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 077674be452b..ee2683200799 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1331,6 +1331,11 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb]
 					!= dm_dram_clock_change_unsupported;
 
+	/* Pstate change might not be supported by hardware, but it might be
+	 * possible with firmware driven vertical blank stretching.
+	 */
+	context->bw_ctx.bw.dcn.clk.p_state_change_support |= context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching;
+
 	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
 	context->bw_ctx.bw.dcn.clk.dtbclk_en = is_dtbclk_required(dc, context);
 	context->bw_ctx.bw.dcn.clk.ref_dtbclk_khz = context->bw_ctx.dml.vba.DTBCLKPerState[vlevel] * 1000;
-- 
2.39.2

