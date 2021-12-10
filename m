Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB64C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1966810E446;
	Fri, 10 Dec 2021 23:05:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8238510E4B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbtML1jzbJjhwBi1y8tR4CfpkUB14XxZTqEZRo98WEKlP/1VJGU1cSkLdLOzbaYC23LVp1IKr9xGFR/+BhBzXNFaggteVvmJIxCaDpk4KNwTdMIK0Qp3cyemldtDHIroGQBuC31UlECab1oUQ9wfTTgJTFB/WnOV4FjFYa2tMegcu8vlaWO0J9me7iQV54Xi5x9hVt2k7aoyvuTaCjSXJkU5H8xYcBc+2CdkXU1ueFk4IqZ99iHR720N+nnMJhYGRui4KNtnYPsfsgtZ+o/ELUJ4jcCRPUllARZs2nPq5SsMw7TVWrhM34kAlnXfHEhB17pwS82rkGmOCnHIsbatjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvdCvlqhf014fZ/Uss0ZB+z9UWTEXBueJFm4BFSWtfA=;
 b=GiE93Y8/zm+Pro3PG7u4OUWs6fJzynmtrqSFDYPEzGI2waPqy+3N2atftm9YH4LGBguKlPBbRVym/1/UqbFIslSYodhRzCae2X+7H62OMzf0/ZFfEbs/nrqZRQ39fpCwNB9AD3OzIdnLxebngKjPEyT5udGArSedSPTMuCyhX/iiE7dGAx9HMIOOwHMsUTnghky3wJjmO1tQMe1EwtBd1r/c7rs1Zx1g+TW3ag4xeKAeIqC17l2z4060PV9gSTD+xl4hmfpK0V8FuR4XklEtdZK+zla0ZczRZ1H99RTk3Z98j27InaqnEpCQSNzsItvBHRQR1iWV0i9XtXRnrYT7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvdCvlqhf014fZ/Uss0ZB+z9UWTEXBueJFm4BFSWtfA=;
 b=WJFsBzM5sgpA2juMBV74WZV8W5N3yoLDEsKedXgl/eTfWN/C/hSmgxi6bTLKO/YojidBeZa/zfHZPtWsp2SG2oTYFyHTWsMxR5OMU0LSjYcZd5zYaS4QOuFyIHAqsWtWs+dtveG9y3/23b5A+BI6WfVRh8AbOTSsQ1ZQ3Iwn08U=
Received: from DM5PR18CA0083.namprd18.prod.outlook.com (2603:10b6:3:3::21) by
 DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Fri, 10 Dec 2021 23:05:26 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::15) by DM5PR18CA0083.outlook.office365.com
 (2603:10b6:3:3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 23:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 23:05:26 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 17:05:23 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/10] drm/amd/display: implement dc_mode_memclk
Date: Fri, 10 Dec 2021 15:04:07 -0800
Message-ID: <20211210230408.619373-10-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
References: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 582ec1ac-27af-432e-df1a-08d9bc318d8e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4895:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4895E306423F270B05517528FC719@DM6PR12MB4895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7v4/OjONHUcIe0xyzztT12Np4/bwn4uwZRkEdc3ltZHOrpiWFJDuQMJqlQFGl7Q6oH4ebruQJeG0Z0JJ2OvoUh8RvxWCA/VRNS4Z5fjzdXLrHtW1ASg8Yir7yUSNoPo9s5vqxC0mLbw7EJd1GR1r1G8zBWI4IaMNsyegjZkX4lXGjz6jmxVr61XrhCPMWliTtlhjyAh1ehOUTRyOUYfjJhe0PoZ4eK0GJLIHHSW+VbQq/GRVetklfwKKGURM7bjmZfKRpCykM5IcCsivouzsCLd+Thf7pJF+ndFXmoM4gxjrPJozle3zcNd4OkDiKpnPvQEzzPhG6lHhm8/FImaPM6e1RlQ0OlRXoRZdldVc39uLLtjTi0q3pfR5tiLtBU/FXi+COLPNi3tSVHLmw5uuFyeNYVCJIGoIRJiRSv2XcrIfvxPV8tb83jxmePWb+xe5My6PB+zQhdKdYMJGKAvStQ1vrG0ksjC8ebW0VvDCcdq4bG/A/D/JS1k+GLkMthknKdgRdvKFBt5KEd6QEEXHNj95A3WgFWKngQNI/vyYoVT4kuBm6Ci6STkJfmezj7SEG5worEDzl6XAXoEiHK1cnUh4Uo0XBUq1w6EC02aPcNiwQDgAzKaB7dIuvrOIQCEgqHD/4YeE07g4d4N6pccF/w8/OYFixcr7aZpuu2yq/4+c//XyxZ03LFXyWmAYHmJ56nM/NOz7vNKF/NrSXRuog5uBVXC1ZEc8UHD0rLMQvpbvAWM/TteXBfh9iNSJSRhMkUorpbVjD3ufG50yHd6AqgQRo1K1IjXV2rMHpQEUcI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(70206006)(7696005)(70586007)(26005)(356005)(83380400001)(2616005)(426003)(16526019)(186003)(336012)(4326008)(30864003)(5660300002)(36860700001)(8676002)(1076003)(8936002)(47076005)(6666004)(86362001)(508600001)(6916009)(36756003)(40460700001)(54906003)(81166007)(2906002)(82310400004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 23:05:26.3224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582ec1ac-27af-432e-df1a-08d9bc318d8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

why:
Need interface to lower clocks when in dc (power save)
mode. Must be able to work with p_state unsupported cases
Can cause flicker when OS notifies us of dc state change

how:
added dal3 interface for KMD
added pathway to query smu for this softmax
added blank before clock change to override underflow
added logic to change clk based on pstatesupport and softmax
added logic in prepare/optimize_bw to conform while changing
clocks

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 44 ++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 92 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 14 ++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 10 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |  4 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 11 +++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  5 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  7 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  1 +
 14 files changed, 188 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 1861a147a7fa..f977f29907df 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -252,6 +252,7 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool update_dispclk = false;
 	bool enter_display_off = false;
 	bool dpp_clock_lowered = false;
+	bool update_pstate_unsupported_clk = false;
 	struct dmcu *dmcu = clk_mgr_base->ctx->dc->res_pool->dmcu;
 	bool force_reset = false;
 	bool update_uclk = false;
@@ -299,13 +300,28 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 	clk_mgr_base->clks.prev_p_state_change_support = clk_mgr_base->clks.p_state_change_support;
 	total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
 	p_state_change_support = new_clocks->p_state_change_support || (total_plane_count == 0);
-	if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
+
+	// invalidate the current P-State forced min in certain dc_mode_softmax situations
+	if (dc->clk_mgr->dc_mode_softmax_enabled && safe_to_lower && !p_state_change_support) {
+		if ((new_clocks->dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000) !=
+				(clk_mgr_base->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000))
+			update_pstate_unsupported_clk = true;
+	}
+
+	if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.p_state_change_support) ||
+			update_pstate_unsupported_clk) {
 		clk_mgr_base->clks.p_state_change_support = p_state_change_support;
 
 		/* to disable P-State switching, set UCLK min = max */
-		if (!clk_mgr_base->clks.p_state_change_support)
-			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+		if (!clk_mgr_base->clks.p_state_change_support) {
+			if (dc->clk_mgr->dc_mode_softmax_enabled &&
+				new_clocks->dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+				dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+					dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
+			else
+				dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
 					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
+		}
 	}
 
 	/* Always update saved value, even if new value not set due to P-State switching unsupported */
@@ -421,6 +437,24 @@ static void dcn3_set_hard_max_memclk(struct clk_mgr *clk_mgr_base)
 			clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
 }
 
+static void dcn3_set_max_memclk(struct clk_mgr *clk_mgr_base, unsigned int memclk_mhz)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	if (!clk_mgr->smu_present)
+		return;
+
+	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, memclk_mhz);
+}
+static void dcn3_set_min_memclk(struct clk_mgr *clk_mgr_base, unsigned int memclk_mhz)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	if (!clk_mgr->smu_present)
+		return;
+	dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, memclk_mhz);
+}
+
 /* Get current memclk states, update bounding box */
 static void dcn3_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 {
@@ -436,6 +470,8 @@ static void dcn3_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 			&num_levels);
 	clk_mgr_base->bw_params->clk_table.num_entries = num_levels ? num_levels : 1;
 
+	clk_mgr_base->bw_params->dc_mode_softmax_memclk = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_UCLK);
+
 	/* Refresh bounding box */
 	clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
 			clk_mgr->base.ctx->dc, clk_mgr_base->bw_params);
@@ -505,6 +541,8 @@ static struct clk_mgr_funcs dcn3_funcs = {
 		.notify_wm_ranges = dcn3_notify_wm_ranges,
 		.set_hard_min_memclk = dcn3_set_hard_min_memclk,
 		.set_hard_max_memclk = dcn3_set_hard_max_memclk,
+		.set_max_memclk = dcn3_set_max_memclk,
+		.set_min_memclk = dcn3_set_min_memclk,
 		.get_memclk_states_from_smu = dcn3_get_memclk_states_from_smu,
 		.are_clock_states_equal = dcn3_are_clock_states_equal,
 		.enable_pme_wa = dcn3_enable_pme_wa,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 598739182461..c250f6de5136 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3605,6 +3605,98 @@ void dc_lock_memory_clock_frequency(struct dc *dc)
 			core_link_enable_stream(dc->current_state, &dc->current_state->res_ctx.pipe_ctx[i]);
 }
 
+static void blank_and_force_memclk(struct dc *dc, bool apply, unsigned int memclk_mhz)
+{
+	struct dc_state *context = dc->current_state;
+	struct hubp *hubp;
+	struct pipe_ctx *pipe;
+	int i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream != NULL) {
+			dc->hwss.disable_pixel_data(dc, pipe, true);
+
+			// wait for double buffer
+			pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg, CRTC_STATE_VACTIVE);
+			pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg, CRTC_STATE_VACTIVE);
+
+			hubp = pipe->plane_res.hubp;
+			hubp->funcs->set_blank_regs(hubp, true);
+		}
+	}
+
+	dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, memclk_mhz);
+	dc->clk_mgr->funcs->set_min_memclk(dc->clk_mgr, memclk_mhz);
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream != NULL) {
+			dc->hwss.disable_pixel_data(dc, pipe, false);
+
+			hubp = pipe->plane_res.hubp;
+			hubp->funcs->set_blank_regs(hubp, false);
+		}
+	}
+}
+
+
+/**
+ * dc_enable_dcmode_clk_limit() - lower clocks in dc (battery) mode
+ * @dc: pointer to dc of the dm calling this
+ * @enable: True = transition to DC mode, false = transition back to AC mode
+ *
+ * Some SoCs define additional clock limits when in DC mode, DM should
+ * invoke this function when the platform undergoes a power source transition
+ * so DC can apply/unapply the limit. This interface may be disruptive to
+ * the onscreen content.
+ *
+ * Context: Triggered by OS through DM interface, or manually by escape calls.
+ * Need to hold a dclock when doing so.
+ *
+ * Return: none (void function)
+ *
+ */
+void dc_enable_dcmode_clk_limit(struct dc *dc, bool enable)
+{
+	uint32_t hw_internal_rev = dc->ctx->asic_id.hw_internal_rev;
+	unsigned int softMax, maxDPM, funcMin;
+	bool p_state_change_support;
+
+	if (!ASICREV_IS_BEIGE_GOBY_P(hw_internal_rev))
+		return;
+
+	softMax = dc->clk_mgr->bw_params->dc_mode_softmax_memclk;
+	maxDPM = dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz;
+	funcMin = (dc->clk_mgr->clks.dramclk_khz + 999) / 1000;
+	p_state_change_support = dc->clk_mgr->clks.p_state_change_support;
+
+	if (enable && !dc->clk_mgr->dc_mode_softmax_enabled) {
+		if (p_state_change_support) {
+			if (funcMin <= softMax)
+				dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, softMax);
+			// else: No-Op
+		} else {
+			if (funcMin <= softMax)
+				blank_and_force_memclk(dc, true, softMax);
+			// else: No-Op
+		}
+	} else if (!enable && dc->clk_mgr->dc_mode_softmax_enabled) {
+		if (p_state_change_support) {
+			if (funcMin <= softMax)
+				dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, maxDPM);
+			// else: No-Op
+		} else {
+			if (funcMin <= softMax)
+				blank_and_force_memclk(dc, true, maxDPM);
+			// else: No-Op
+		}
+	}
+	dc->clk_mgr->dc_mode_softmax_enabled = enable;
+}
 bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_state *plane,
 		struct dc_cursor_attributes *cursor_attr)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a43c008bd0f2..963b58803ae5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1432,6 +1432,9 @@ void dc_unlock_memory_clock_frequency(struct dc *dc);
  */
 void dc_lock_memory_clock_frequency(struct dc *dc);
 
+/* set soft max for memclk, to be used for AC/DC switching clock limitations */
+void dc_enable_dcmode_clk_limit(struct dc *dc, bool enable);
+
 /* cleanup on driver unload */
 void dc_hardware_release(struct dc *dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 5adf42a7cc27..c2c12b90411c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -929,6 +929,16 @@ bool hubp2_is_flip_pending(struct hubp *hubp)
 }
 
 void hubp2_set_blank(struct hubp *hubp, bool blank)
+{
+	hubp2_set_blank_regs(hubp, blank);
+
+	if (blank) {
+		hubp->mpcc_id = 0xf;
+		hubp->opp_id = OPP_ID_INVALID;
+	}
+}
+
+void hubp2_set_blank_regs(struct hubp *hubp, bool blank)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 	uint32_t blank_en = blank ? 1 : 0;
@@ -951,9 +961,6 @@ void hubp2_set_blank(struct hubp *hubp, bool blank)
 					HUBP_NO_OUTSTANDING_REQ, 1,
 					1, 200);
 		}
-
-		hubp->mpcc_id = 0xf;
-		hubp->opp_id = OPP_ID_INVALID;
 	}
 }
 
@@ -1603,6 +1610,7 @@ static struct hubp_funcs dcn20_hubp_funcs = {
 	.hubp_setup_interdependent = hubp2_setup_interdependent,
 	.hubp_set_vm_system_aperture_settings = hubp2_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
+	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp2_dcc_control,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
index eea2254b15e4..9204c3ef323b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
@@ -330,6 +330,7 @@ void hubp2_program_surface_config(
 bool hubp2_is_flip_pending(struct hubp *hubp);
 
 void hubp2_set_blank(struct hubp *hubp, bool blank);
+void hubp2_set_blank_regs(struct hubp *hubp, bool blank);
 
 void hubp2_cursor_set_position(
 		struct hubp *hubp,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e6af99ae3d9f..0af56d67672c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -615,6 +615,11 @@ void dcn20_disable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx)
 					pipe_ctx->pipe_idx);
 }
 
+void dcn20_disable_pixel_data(struct dc *dc, struct pipe_ctx *pipe_ctx, bool blank)
+{
+	dcn20_blank_pixel_data(dc, pipe_ctx, blank);
+}
+
 static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
 		int opp_cnt)
 {
@@ -1842,6 +1847,11 @@ void dcn20_optimize_bandwidth(
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					true);
 
+	if (dc->clk_mgr->dc_mode_softmax_enabled)
+		if (dc->clk_mgr->clks.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
+				context->bw_ctx.bw.dcn.clk.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
+
 	dc->clk_mgr->funcs->update_clocks(
 			dc->clk_mgr,
 			context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index 6bba191cd33e..33a36c02b2f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -53,6 +53,10 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx);
 void dcn20_unblank_stream(struct pipe_ctx *pipe_ctx,
 		struct dc_link_settings *link_settings);
 void dcn20_disable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx);
+void dcn20_disable_pixel_data(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool blank);
 void dcn20_blank_pixel_data(
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
index eac08926b574..6a4dcafb9bba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
@@ -490,6 +490,7 @@ static struct hubp_funcs dcn30_hubp_funcs = {
 	.hubp_setup_interdependent = hubp2_setup_interdependent,
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
+	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp3_dcc_control,
 	.mem_program_viewport = min_set_viewport,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 3e99bb9c70ab..1db1ca19411d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -344,6 +344,17 @@ void dcn30_enable_writeback(
 	dwb->funcs->enable(dwb, &wb_info->dwb_params);
 }
 
+void dcn30_prepare_bandwidth(struct dc *dc,
+ 	struct dc_state *context)
+{
+	if (dc->clk_mgr->dc_mode_softmax_enabled)
+		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
+				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
+
+ 	dcn20_prepare_bandwidth(dc, context);
+}
+
 void dcn30_disable_writeback(
 		struct dc *dc,
 		unsigned int dwb_pipe_inst)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index e9a0005288d3..73e7b690e82c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -27,7 +27,7 @@
 #define __DC_HWSS_DCN30_H__
 
 #include "hw_sequencer_private.h"
-
+#include "dcn20/dcn20_hwseq.h"
 struct dc;
 
 void dcn30_init_hw(struct dc *dc);
@@ -47,6 +47,9 @@ void dcn30_disable_writeback(
 		struct dc *dc,
 		unsigned int dwb_pipe_inst);
 
+void dcn30_prepare_bandwidth(struct dc *dc,
+ 	struct dc_state *context);
+
 bool dcn30_mmhubbub_warmup(
 	struct dc *dc,
 	unsigned int num_dwb,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 93f32a312fee..fb1ad3df43a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -53,6 +53,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
+	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index a17e5de3b100..c920c4b6077d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -211,6 +211,8 @@ struct dummy_pstate_entry {
 struct clk_bw_params {
 	unsigned int vram_type;
 	unsigned int num_channels;
+ 	unsigned int dispclk_vco_khz;
+	unsigned int dc_mode_softmax_memclk;
 	struct clk_limit_table clk_table;
 	struct wm_table wm_table;
 	struct dummy_pstate_entry dummy_pstate_table[4];
@@ -261,6 +263,10 @@ struct clk_mgr_funcs {
 	/* Send message to PMFW to set hard max memclk frequency to highest DPM */
 	void (*set_hard_max_memclk)(struct clk_mgr *clk_mgr);
 
+	/* Custom set a memclk freq range*/
+	void (*set_max_memclk)(struct clk_mgr *clk_mgr, unsigned int memclk_mhz);
+	void (*set_min_memclk)(struct clk_mgr *clk_mgr, unsigned int memclk_mhz);
+
 	/* Get current memclk states from PMFW, update relevant structures */
 	void (*get_memclk_states_from_smu)(struct clk_mgr *clk_mgr);
 
@@ -274,6 +280,7 @@ struct clk_mgr {
 	struct dc_clocks clks;
 	bool psr_allow_active_cache;
 	bool force_smu_not_present;
+	bool dc_mode_softmax_enabled;
 	int dprefclk_khz; // Used by program pixel clock in clock source funcs, need to figureout where this goes
 	int dentist_vco_freq_khz;
 	struct clk_state_registers_and_bypass boot_snapshot;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 80e1a32bc63d..2c031586f4e6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -139,6 +139,7 @@ struct hubp_funcs {
 	bool (*hubp_is_flip_pending)(struct hubp *hubp);
 
 	void (*set_blank)(struct hubp *hubp, bool blank);
+	void (*set_blank_regs)(struct hubp *hubp, bool blank);
 	void (*set_hubp_blank_en)(struct hubp *hubp, bool blank);
 
 	void (*set_cursor_attributes)(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index d50f4bd06b5d..05053f3b4ab7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -64,6 +64,7 @@ struct hw_sequencer_funcs {
 	enum dc_status (*apply_ctx_to_hw)(struct dc *dc,
 			struct dc_state *context);
 	void (*disable_plane)(struct dc *dc, struct pipe_ctx *pipe_ctx);
+	void (*disable_pixel_data)(struct dc *dc, struct pipe_ctx *pipe_ctx, bool blank);
 	void (*apply_ctx_for_surface)(struct dc *dc,
 			const struct dc_stream_state *stream,
 			int num_planes, struct dc_state *context);
-- 
2.32.0

