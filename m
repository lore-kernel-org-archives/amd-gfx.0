Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19D5C77B76
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5685410ED58;
	Thu, 20 Apr 2023 23:50:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB43810ED5D
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neMvIkvBEfk6UrV+fxTjpqcuWP0a5JVjYgyTJilQBvTb6ihTXoXBNRei+uppxRYjV6s48kh2/j1mLdB+KdsK7OMBG4L2y5xlQcdHSi/KWVW/ZVsS7IWTypVkSQG9nVsz7MkGZSzpQh972K6TdE4zR71hRrqtgYjvC+3VfLtASNagh+RAH4ZvMbF7nkTOhatx+G2sHhSB/J2n4pXrN2zSLaekIa1PRkGIqHcnzIDLJ/I1uoes8TzoTb1N0DC/L/c0w7qNEtTdUzzM7YjfCE5CxzeQEfeIyrsdK0f7abnYE0lcqDMOuk3bcSBzjKSGdLDGpNf45BxlNGrxEWfhTw/XdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLM9P8aw/o1JCE0LXjve4LK1Vv8HqmFhxMzt/Sg/pgo=;
 b=UXIbVLOfEjsvBzOic1m08q+B/CoqMSjGrxODOu4ggkDPk+tbr5/5b2P642qEyXsZ00wvHSXLLfjxA/SO3VLPyJzm2BkUEQ1l6ugbX2zsqzVcio8ou56q6AnCASJzy52+pswo4UYXTHac26LBW/1YpBPGx9sHptxwUBI4qjrw7efLEboLkBilPsfLLccwW49VQmmt/rD929nV4kynLaBpQlq1taVOSeEizqRGvoxE3Ly64Ph6bsJ7R25NjdqFmTQQn70RQn1LH2HEj2TVeh6hZH1g9MwUchb6QbSg20OnPaJxAc10oqVpcz4o1yZcrrUkIR7osYmm6u2WttyKf0Wo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLM9P8aw/o1JCE0LXjve4LK1Vv8HqmFhxMzt/Sg/pgo=;
 b=RWqtaVbHpI9yySlbPn+x2oIERg3ZL1D6KQZpX8f9heqC4qmAN/PUhT6gO9B5mNU8t876g1OzlXYz7EKAacM3NlUu22QANf7s8jyblNvC0gfZXYGWANmX/ly2lFmqjneAsDvtOWQeGr7fP9lTEnTX6xfd+lsTZG4zYT+EgiVgrxI=
Received: from DS7PR03CA0204.namprd03.prod.outlook.com (2603:10b6:5:3b6::29)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 23:50:37 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::97) by DS7PR03CA0204.outlook.office365.com
 (2603:10b6:5:3b6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.27 via Frontend Transport; Thu, 20 Apr 2023 23:50:37 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:35 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/21] drm/amd/display: For no plane case set pstate support
 in validation
Date: Thu, 20 Apr 2023 17:49:46 -0600
Message-ID: <20230420234951.1772270-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: da04a1bf-a92c-4b34-a962-08db41fa0a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EkntWKw0J26GdLLsIC3rYCDbROuT91Z34NaBaE3ivLHJYnOEZTmKo5wta2QeeGf0f19SHcPeBvjR+cHNw1PQEoltdHS/SWIH3vFnyDwhmgrjcIWwlDopDxH5EtSo2TFf/3QjsMCMPWbdvSGoIGVxbEKwVF8MdmAW+rk7tQb8h/GR/E9b9aMacKGbDcM/7R2bNHNOAMed0rnfmRCrTIIPDH/a+f1HIykSp0HkaYz0Al6t2wqw65VIMhUrnlxpX9wewq5Nrdmy2pqo8JyXQ2MeUHi99iqxtNz1AFdC1w7w0J4ZO6qWnSrfn0jvpSP6o5LKWMZAWeNuOmKuHhi28LwbYZyfdzQCwz/+8Is6LDDfd8oFi0InYftbs5vn8Ym9ZTr4DtX+N17BgMz/FHwLiyhIaDlo01UkUhNNGWMiPhRVK09rHbyzP9yuGPw/XMQ4CPjax6zJtypPwC/Jwh++6RwNUT7VjMQ+Fx6+j9XBm2QaEhzo2sg49DJsSLXOhDPz/cDNPtZNX58A5+dggektJTyws0Pauoa6qlAm893/wunjNJlPDWjMbNHdoxOarnFlM/uHjJnf5Fj0wg+HMBYMWRgcXs5vo48y9OoxFfAQxyEi/LK59BbqOK1JuDUP0ngMOzJMIsfaF5RFUhU/kDXCUix0AeyuOU93D3WTOLo3TPUejv7w25yz4btP7/jgYUxIEUiWRDEFkYJ4+wcRY28sVZgKzSD/8J3Fbgt6mEGQDbUSo6E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(6666004)(8936002)(8676002)(316002)(41300700001)(82740400003)(4326008)(6916009)(70586007)(70206006)(40480700001)(54906003)(81166007)(356005)(186003)(40460700003)(2906002)(16526019)(36756003)(426003)(1076003)(26005)(83380400001)(336012)(47076005)(82310400005)(36860700001)(5660300002)(86362001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:37.0735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da04a1bf-a92c-4b34-a962-08db41fa0a2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

- Previously update_clocks was overriding pstate support if
  it checked that there were no planes
- However, P-State support should be determined in validation
  phase instead
- This fixes an issue where a transition from FPO -> no planes
  expects UCLK MAX, but update_clocks was overriding to set
  UCLK to min

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 4 +---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 7 ++-----
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c      | 8 +++++++-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c      | 1 +
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 694a9d3d92ae..3908e7cfd6cb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -206,7 +206,6 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool force_reset = false;
 	bool update_uclk = false;
 	bool p_state_change_support;
-	int total_plane_count;
 
 	if (dc->work_arounds.skip_clock_update || !clk_mgr->smu_present)
 		return;
@@ -247,8 +246,7 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 		clk_mgr_base->clks.socclk_khz = new_clocks->socclk_khz;
 
 	clk_mgr_base->clks.prev_p_state_change_support = clk_mgr_base->clks.p_state_change_support;
-	total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
-	p_state_change_support = new_clocks->p_state_change_support || (total_plane_count == 0);
+	p_state_change_support = new_clocks->p_state_change_support;
 
 	// invalidate the current P-State forced min in certain dc_mode_softmax situations
 	if (dc->clk_mgr->dc_mode_softmax_enabled && safe_to_lower && !p_state_change_support) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index eea103908b09..85e963ec25ab 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -459,7 +459,6 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool update_uclk = false, update_fclk = false;
 	bool p_state_change_support;
 	bool fclk_p_state_change_support;
-	int total_plane_count;
 
 	if (dc->work_arounds.skip_clock_update)
 		return;
@@ -488,8 +487,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 
 		clk_mgr_base->clks.fclk_prev_p_state_change_support = clk_mgr_base->clks.fclk_p_state_change_support;
 
-		total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
-		fclk_p_state_change_support = new_clocks->fclk_p_state_change_support || (total_plane_count == 0);
+		fclk_p_state_change_support = new_clocks->fclk_p_state_change_support;
 
 		if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
 			clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
@@ -528,8 +526,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			dcn32_smu_send_cab_for_uclk_message(clk_mgr, clk_mgr_base->clks.num_ways);
 		}
 
-
-		p_state_change_support = new_clocks->p_state_change_support || (total_plane_count == 0);
+		p_state_change_support = new_clocks->p_state_change_support;
 		if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
 			clk_mgr_base->clks.p_state_change_support = p_state_change_support;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 7661f8946aa3..a5b1e4bb1a22 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1042,7 +1042,7 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 				int pipe_cnt,
 				int vlevel)
 {
-	int i, pipe_idx;
+	int i, pipe_idx, active_hubp_count = 0;
 
 	dc_assert_fp_enabled();
 
@@ -1078,6 +1078,8 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
+		if (context->res_ctx.pipe_ctx[i].plane_state)
+			active_hubp_count++;
 		pipes[pipe_idx].pipe.dest.vstartup_start = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
 		pipes[pipe_idx].pipe.dest.vupdate_offset = get_vupdate_offset(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
 		pipes[pipe_idx].pipe.dest.vupdate_width = get_vupdate_width(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
@@ -1104,6 +1106,10 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 
 		pipe_idx++;
 	}
+	/* If DCN isn't making memory requests we can allow pstate change */
+	if (!active_hubp_count) {
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+	}
 	/*save a original dppclock copy*/
 	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
 	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index e1e82ad4c583..2624236d20d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1433,6 +1433,7 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 		context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
 		context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = true;
 	}
 	/*save a original dppclock copy*/
 	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
-- 
2.39.2

