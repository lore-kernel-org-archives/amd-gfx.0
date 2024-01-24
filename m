Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE754C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FEF10F648;
	Wed, 24 Jan 2024 07:02:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6EAC10F648
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpDmhCJxRpgAhGfcp7PgbZJCvm7Aymeb00MyHaxMzkIcmHsDsjumEc8d9+ksbRSN1p/xqPqpbvqdxgjnC7H92iI0uHE9okcsAYVhIkDxF0q5+r71g+5YfPSgauIjrQp708eoqXo4Cxlu1gY8Q5vD+6ucKYFyhyr7hW3WfF9TdJm5KAkavNCQz5+JWYX78aXiCaf5odCKofq422zQa5yNV7VtG514PJqLi9QOR4BdlUOKHTdUqEFme8eTv26jcU6Hg2Fl8fssDWPRvsD5ykk39UPcx5fL1m6JZlFOc/2b145aG95f+kT5sscQumddBiAkOuc28b/2+iz1mfLFmJ66+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1MTGVlRCp7EsAbakxaQNXcmy0Ft+5gD1roYqyRHHRE=;
 b=cY3v+SU8e8G74STVsa8nrcIR+FYNnrKbYm4QUlTBTSoHTDcbnXJT6nSfxV8kc1L3Kq880/mWQ6ua788FBRE1HbKTqJEPEo0WdMAKcxLGwTj4lNxs0xSb+q7xdW0dfk0f7PN6d5JO+7cDJlE9LoyPwW8FgWXA/bsPce9fQ0vhEEGxvUc1o63fikAENIG0XB66ht9Hv+bMwaaRYoAoXmB4UskGRGdmxcr3UAw5/HU7OucCIVueoETWV+iB6dnTg7uYoEv2+0+uBDB/BjmCxlpTtjVLJgGTSXYP7TtD3coIdXK8R7OlhWG/pxpTcTnzbIMbUFZw7eKlQ0JQDjVsSLVRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1MTGVlRCp7EsAbakxaQNXcmy0Ft+5gD1roYqyRHHRE=;
 b=XKL4OrnAdOZgKPdUGaVYWqTXKxr+xviYojHTaeCpE45rSEEvZbVwuB3BidX5IGMMm3EUTdARMHFPoeeZAE0TgfNQ6lFepqYZzsJ7en1jSbZW+ssjmP5D2yeMvWUzSeIc4EYBbUhiXphSSzbnIdlb9dV6BugDEaUZ32CalKNdsM0=
Received: from MW4PR04CA0044.namprd04.prod.outlook.com (2603:10b6:303:6a::19)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:02:33 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:6a:cafe::d3) by MW4PR04CA0044.outlook.office365.com
 (2603:10b6:303:6a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:31 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:29 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/22] drm/amd/display: For FPO and SubVP/DRR configs program
 vmin/max sel
Date: Wed, 24 Jan 2024 15:01:44 +0800
Message-ID: <20240124070159.1900622-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 28cb019c-4764-4635-0735-08dc1caa7012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXqUliLB5lfFfm/FvBJDhEhEMtgmZgupO1SsAAqX42pDytMm/kkL7A3UDV6TXCHQfo8VfDOCBBDLeln2F8h30LHaUkHWGWjWuC4s+P22AZqm1F6m8ZktWQzAhRxNs6P0+DHiNjmrN7du7dnLDKsRnBhkkjNkz9sZfCHgNx4CFGDufWctqvrk3wsxSJjrE/7K2f+CQ415pMhowo5QnOaRPaqQzocR1GIavV22lihihuQrjKY/arLmDnE1W9b2We+OU2pVK344lJYzN7JdgfPEBlTUHWFUPS9lopDcyMHVi6fcScOoY3HiVfVxOA73yMTRtRJwjiBnsxFhFBBggiPdkqTQE9xAinSTJCT3cIX7pJp8N6INsUerL9FZ+fzDB+JUscn6aPCtCcivslG0MeQsRS1iqtFea6LTEVU0MBlPBpFkDCwlZwykabCyXQjthEy/h2yf5V09Nv1H5KNg1SVGmHUYEfZ8KndEH1Y5gsDNXrgnQJTF8KJ4sYRcPrH1+3lYC82jo3qKdvJ1zhnKGd3sDNPZSDCNRiNsqshy7ZKQHbRjB+3P6ms2c13myWp3xlhWTiypLYSocKX01fY94vUYQudXeb2xVPQVoKY2VfHehD8wtd02us6+0NShcJkWwzkDZeF+evKKuOvdI7z/ljnfFYHMrn/iArBGVhY2y0WcofKjL27nWRb7s5yT62o0aiVfwyZmnME85MBow5A3kGlnkXsBZE/A5/Sd8+lU60x7vjVJogFgAUXox+bMDfXVIoLsP9xhrA941Yw8ggRBr6nr/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(5660300002)(41300700001)(8676002)(70586007)(6916009)(54906003)(70206006)(316002)(478600001)(2906002)(4326008)(8936002)(7696005)(6666004)(1076003)(2616005)(40460700003)(40480700001)(83380400001)(47076005)(30864003)(36860700001)(26005)(336012)(426003)(356005)(81166007)(82740400003)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:32.8453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cb019c-4764-4635-0735-08dc1caa7012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why & How]
For FPO and SubVP/DRR cases we need to ensure to program
OTG_V_TOTAL_MIN/MAX_SEL, otherwise stretching the vblank
in FPO / SubVP / DRR cases will not have any effect
and we could hit underflow / corruption.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 31 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 14 +++++++++
 .../display/dc/dcn32/dcn32_resource_helpers.c | 14 ---------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 11 ++++---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  1 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 ++
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 --
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 9 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 186d54205bcc..2db361aeaf25 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3481,6 +3481,33 @@ static void wait_for_outstanding_hw_updates(struct dc *dc, const struct dc_state
 	}
 }
 
+static void update_drr_for_full_update(struct dc *dc, struct dc_state *context)
+{
+	uint32_t i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct dc_stream_state *stream = pipe->stream;
+		struct timing_generator *tg = pipe->stream_res.tg;
+		struct drr_params params = {0};
+
+		/* pipe not in use */
+		if (!resource_is_pipe_type(pipe, OTG_MASTER))
+			continue;
+
+		/* skip phantom pipes */
+		if (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM)
+			continue;
+
+		params.vertical_total_min = stream->adjust.v_total_min;
+		params.vertical_total_max = stream->adjust.v_total_max;
+		params.vertical_total_mid = stream->adjust.v_total_mid;
+		params.vertical_total_mid_frame_num = stream->adjust.v_total_mid_frame_num;
+		if (pipe->stream_res.tg->funcs->set_drr)
+			tg->funcs->set_drr(pipe->stream_res.tg, &params);
+	}
+}
+
 static void commit_planes_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
@@ -3848,6 +3875,10 @@ static void commit_planes_for_stream(struct dc *dc,
 			pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
 	}
 
+	// Update DRR for all pipes
+	if (update_type != UPDATE_TYPE_FAST)
+		update_drr_for_full_update(dc, context);
+
 	current_stream_mask = get_stream_mask(dc, context);
 	if (current_stream_mask != context->stream_mask) {
 		context->stream_mask = current_stream_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 9fbdb09697fd..259ccbe858b4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4990,6 +4990,20 @@ enum dc_status update_dp_encoder_resources_for_test_harness(const struct dc *dc,
 	return DC_OK;
 }
 
+bool resource_subvp_in_use(struct dc *dc,
+		struct dc_state *context)
+{
+	uint32_t i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_NONE)
+			return true;
+	}
+	return false;
+}
+
 bool check_subvp_sw_cursor_fallback_req(const struct dc *dc, struct dc_stream_state *stream)
 {
 	if (!dc->debug.disable_subvp_high_refresh && is_subvp_high_refresh_candidate(stream))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 87760600e154..e4a328b45c8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -183,20 +183,6 @@ bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 	return true;
 }
 
-bool dcn32_subvp_in_use(struct dc *dc,
-		struct dc_state *context)
-{
-	uint32_t i;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_NONE)
-			return true;
-	}
-	return false;
-}
-
 bool dcn32_mpo_in_use(struct dc_state *context)
 {
 	uint32_t i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b13a6fd7cc83..9b80f65c0466 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -33,6 +33,7 @@
 #include "dcn30/dcn30_resource.h"
 #include "link.h"
 #include "dc_state_priv.h"
+#include "resource.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -291,7 +292,7 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 
 		/* for subvp + DRR case, if subvp pipes are still present we support pstate */
 		if (vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported &&
-				dcn32_subvp_in_use(dc, context))
+				resource_subvp_in_use(dc, context))
 			vba->DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = temp_clock_change_support;
 
 		if (vlevel < context->bw_ctx.dml.vba.soc.num_states &&
@@ -2272,7 +2273,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	unsigned int dummy_latency_index = 0;
 	int maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
 	unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
-	bool subvp_in_use = dcn32_subvp_in_use(dc, context);
+	bool subvp_active = resource_subvp_in_use(dc, context);
 	unsigned int min_dram_speed_mts_margin;
 	bool need_fclk_lat_as_dummy = false;
 	bool is_subvp_p_drr = false;
@@ -2281,7 +2282,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	dc_assert_fp_enabled();
 
 	/* need to find dummy latency index for subvp */
-	if (subvp_in_use) {
+	if (subvp_active) {
 		/* Override DRAMClockChangeSupport for SubVP + DRR case where the DRR cannot switch without stretching it's VBLANK */
 		if (!pstate_en) {
 			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
@@ -2467,7 +2468,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 				dc->clk_mgr->bw_params->clk_table.entries[min_dram_speed_mts_offset].memclk_mhz * 16;
 		}
 
-		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && !subvp_in_use) {
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && !subvp_active) {
 			/* find largest table entry that is lower than dram speed,
 			 * but lower than DPM0 still uses DPM0
 			 */
@@ -3527,7 +3528,7 @@ void dcn32_set_clock_limits(const struct _vcs_dpi_soc_bounding_box_st *soc_bb)
 void dcn32_override_min_req_memclk(struct dc *dc, struct dc_state *context)
 {
 	// WA: restrict FPO and SubVP to use first non-strobe mode (DCN32 BW issue)
-	if ((context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dcn32_subvp_in_use(dc, context)) &&
+	if ((context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || resource_subvp_in_use(dc, context)) &&
 			dc->dml.soc.num_chans <= 8) {
 		int num_mclk_levels = dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index a2a30204f565..1ffdaa38c932 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2064,7 +2064,6 @@ void dcn20_program_front_end_for_ctx(
 				&& context->res_ctx.pipe_ctx[i].stream)
 			hws->funcs.blank_pixel_data(dc, &context->res_ctx.pipe_ctx[i], true);
 
-
 	/* Disconnect mpcc */
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index c958ef37b78a..1d51fed12e20 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -609,6 +609,9 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy(
 		struct pipe_ctx *sec_pipe,
 		bool odm);
 
+bool resource_subvp_in_use(struct dc *dc,
+		struct dc_state *context);
+
 /* A test harness interface that modifies dp encoder resources in the given dc
  * state and bypasses the need to revalidate. The interface assumes that the
  * test harness interface is called with pre-validated link config stored in the
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index c4d71e7f18af..ac04a9c9a3d8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1899,7 +1899,7 @@ int dcn32_populate_dml_pipes_from_context(
 
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
-	.get_subvp_en = dcn32_subvp_in_use,
+	.get_subvp_en = resource_subvp_in_use,
 };
 
 void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 0c87b0fabba7..62611acd4bcb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -131,9 +131,6 @@ void dcn32_merge_pipes_for_subvp(struct dc *dc,
 bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 		struct dc_state *context);
 
-bool dcn32_subvp_in_use(struct dc *dc,
-		struct dc_state *context);
-
 bool dcn32_mpo_in_use(struct dc_state *context);
 
 bool dcn32_any_surfaces_rotated(struct dc *dc, struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 6f832bf278cf..eefc127a9381 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1574,7 +1574,7 @@ static void dcn321_destroy_resource_pool(struct resource_pool **pool)
 
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
-	.get_subvp_en = dcn32_subvp_in_use,
+	.get_subvp_en = resource_subvp_in_use,
 };
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-- 
2.34.1

