Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F695C05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 317E210E7EF;
	Fri,  3 Feb 2023 15:25:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B90210E7EF
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 15:25:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJfUWE4s3HYHjVnrY2GUJQRnd0FOpshBYA02t8MqQ6aRX4ZUyta6DRIfBg0t3wjQp3Xb7R106BTrX/gAMOVVxxe8w1LJdJ4HKFYvMeRjR6fnJK+DcWu2e5JTK/QahHSjM3V3Z3iknPFsXyONfgaRv+/M/z/3kHGZCXUkiQ98cr0JtyV92Gr+ibInCy1n283tGx8Oo01e5ZusuXQW+BXW+YTXTBr2Q9UPAGCYRRyHA4y2MJMY2Z3da2gzMqTfckbGtP+129oIX2EvShXxpC/mHqopzu5/hugBPVUIYWKC8fztCsg1q/JLRcjOJMZQOrzaAIdqyZLTMIUAcu8vSTyO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDm0+1FiQsOPBytaLEW6kIzCqqgSm6iiqXfozx1/JPs=;
 b=NgUTY7OpfJZslGmdVfOPlBvWxMlgd8AieGRB51mdibGk0CGeY+vxpTgIgQfRS1T3NMC+xoUO24MMbflKLVAVZSjhdkvQcoOTXciSlXvmKL/uusMLlMcgRMV9DlLif5bszi0XfjY/ErlxQN5xFZGknjc0HuL2p6nFmipsacM1kzM0hqkPbblac4TmxQUFQIZBMhRfFJ/aOqxhE0ZgMfGJ3llTF2G+62Q9npMAfOHsr2nXkzi3WT+EM90Faqfo7LEIErToBbbfYffBI3WeOStWofHKO3esJNWAgpcGV/TJBnRT3XGfCGdBmzh7OrxnC6eag0u3pxQImIlF1mpDwhWPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDm0+1FiQsOPBytaLEW6kIzCqqgSm6iiqXfozx1/JPs=;
 b=ir8IsfS+bz0kYC8mDVxRg0mhxjHaF2omG17a7aTHXLzf5lsh6wUyEp6Oi7dLglgdhS6EQ9CQDqsn9UxjP3/H2gG9Jtkk6C/jirEFwyogwC0kEYZ5ldJtDTVGEd6bvB9srsOy9A7GCVo1Fj3hV9rkmTxaQbIWj+B68AMV2K0PFmU=
Received: from MN2PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:23a::11)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Fri, 3 Feb
 2023 15:25:28 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::cd) by MN2PR03CA0006.outlook.office365.com
 (2603:10b6:208:23a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 15:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 15:25:27 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 09:25:25 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/display: Only raise FP2 outside of lock
Date: Fri, 3 Feb 2023 10:24:43 -0500
Message-ID: <20230203152452.1441747-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
References: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e777c0-1623-496e-b242-08db05fae124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcJgESGzGw352uQgINyV3Z1sAkdwP9wBMB4qp84XqMAo+LXnC2MXE1mneT/04EtEGDENPGqwKEi4tDfhMAnnZ5alZDOKHxBydm6P22rXgCSErUDVJIH5kRwQFduocsFVmYJUGT1NZ1AIqGTG4w1nPeAuQqHmvzezeFJo4DP4Rl1hGs18ryGqsWGXOICJrCs/RxGQoqa8M6vZofzY9SsvKuG9qrq8ZA2ACtYOfZscjWADXIIvjQj33Ii0/V5zedDtwz0a7BLFMIjTNTTElTNOqEwQU3iv8zrcXG18QKV8e0cPZEAXrV+oefArlm3c5xvrWi1KGQn7c3S063dky2+11CDsl4T39zhQwnlCq+tq0wyEDSoASoo/cv/3CIryVC7wfmqfMi5hyo3UYSm84kxYNzHPnPTOzxOHmFaEPPzKMunQTvU0i3c44kAoNqdvr4iQBoUwMaWqCrFUOs71+ZB9bmg/QHeAEmG+y1yHrD4S3XEJyvTFIUOnE5QnlJJas1tuyM9twD7IB2pXXZd7Sg7kzg00udrKqRtn8hoidHGE9Ydz0U6s00p98e8cm31li5utNWb2+5bwWvsVV9UCGGvmz20lxBY9AFMJC0IZETMztjFBjqPD0L/GOxyaeyYROLdAWR3wqFUZkOXCusx8yhy53LTyPsVdxRZK7KYMEX7FFrvonYCktdngx1h/3Npl0LLLEDHEyJOiOTb69BAZdgPbv+/QEtNSuhyU2R+RS9TWZf4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(41300700001)(54906003)(8676002)(83380400001)(4326008)(70586007)(70206006)(6916009)(8936002)(47076005)(36756003)(16526019)(40460700003)(30864003)(5660300002)(40480700001)(2906002)(316002)(426003)(81166007)(36860700001)(478600001)(356005)(82740400003)(82310400005)(336012)(26005)(44832011)(6666004)(1076003)(186003)(2616005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:25:27.8738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e777c0-1623-496e-b242-08db05fae124
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104
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
Cc: stylon.wang@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
If HUBP FP2 (VTG register) is higher than OTG FP2 (implicit), then
underflow can occur.

Since VTG is not double-buffered, there is risk of underflow when
raising FP2 if VBLANK is hit before programming and unlocking OTG is
completed.

It appears that if HUBP FP2 is lower than OTG FP2, no such problems
occur.

[HOW]
If FP2 is being lowered, update the VTG register in lock as normal.

If FP2 is being raised, wait until after OTG unlock, so that OTG FP2 is
raised first, then update VTG.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  9 +++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  2 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 27 +++++++++++++++++--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  1 +
 .../drm/amd/display/dc/dcn201/dcn201_optc.c   |  1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |  1 +
 .../drm/amd/display/dc/dcn314/dcn314_optc.c   |  1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |  1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 +
 10 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index c9e53dc49c92..20466195b884 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -369,6 +369,14 @@ void optc1_set_vtg_params(struct timing_generator *optc,
 		REG_UPDATE(CONTROL, VTG0_VCOUNT_INIT, v_init);
 }
 
+
+uint32_t optc1_get_vstartup_start(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	return optc1->vstartup_start;
+}
+
 void optc1_set_blank_data_double_buffer(struct timing_generator *optc, bool enable)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -1575,6 +1583,7 @@ static const struct timing_generator_funcs dcn10_tg_funcs = {
 		.get_crc = optc1_get_crc,
 		.configure_crc = optc1_configure_crc,
 		.set_vtg_params = optc1_set_vtg_params,
+		.get_vstartup_start = optc1_get_vstartup_start,
 		.program_manual_trigger = optc1_program_manual_trigger,
 		.setup_manual_trigger = optc1_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index 0b37bb0e184b..88d6e423ccf9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -721,4 +721,6 @@ bool optc1_is_two_pixels_per_containter(const struct dc_crtc_timing *timing);
 void optc1_set_vtg_params(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing, bool program_fp2);
 
+uint32_t optc1_get_vstartup_start(struct timing_generator *optc);
+
 #endif /* __DC_TIMING_GENERATOR_DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index cb8edb14603a..c657f34df0d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1695,8 +1695,9 @@ static void dcn20_program_pipe(
 		struct dc_state *context)
 {
 	struct dce_hwseq *hws = dc->hwseq;
-	/* Only need to unblank on top pipe */
+	uint32_t current_vstartup_start, old_vstartup_start;
 
+	/* Only need to unblank on top pipe */
 	if ((pipe_ctx->update_flags.bits.enable || pipe_ctx->stream->update_flags.bits.abm_level)
 			&& !pipe_ctx->top_pipe && !pipe_ctx->prev_odm_pipe)
 		hws->funcs.blank_pixel_data(dc, pipe_ctx, !pipe_ctx->plane_state->visible);
@@ -1704,6 +1705,8 @@ static void dcn20_program_pipe(
 	/* Only update TG on top pipe */
 	if (pipe_ctx->update_flags.bits.global_sync && !pipe_ctx->top_pipe
 			&& !pipe_ctx->prev_odm_pipe) {
+		old_vstartup_start = pipe_ctx->stream_res.tg->funcs->get_vstartup_start(pipe_ctx->stream_res.tg);
+		current_vstartup_start = pipe_ctx->pipe_dlg_param.vstartup_start;
 		pipe_ctx->stream_res.tg->funcs->program_global_sync(
 				pipe_ctx->stream_res.tg,
 				calculate_vready_offset_for_group(pipe_ctx),
@@ -1716,8 +1719,12 @@ static void dcn20_program_pipe(
 			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
 		}
 
-		pipe_ctx->stream_res.tg->funcs->set_vtg_params(
+		if (current_vstartup_start < old_vstartup_start)
+			pipe_ctx->stream_res.tg->funcs->set_vtg_params(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, true);
+		else
+			pipe_ctx->stream_res.tg->funcs->set_vtg_params(
+				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, false);
 
 		if (hws->funcs.setup_vupdate_interrupt)
 			hws->funcs.setup_vupdate_interrupt(dc, pipe_ctx);
@@ -1955,6 +1962,22 @@ void dcn20_post_unlock_program_front_end(
 		}
 	}
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+
+		if (!pipe->top_pipe && !pipe->prev_odm_pipe) {
+			if (pipe->stream->mall_stream_config.type != SUBVP_PHANTOM) {
+				pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg, CRTC_STATE_VBLANK);
+				pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg, CRTC_STATE_VACTIVE);
+			}
+			pipe->stream_res.tg->funcs->set_vtg_params(pipe->stream_res.tg, &pipe->stream->timing, true);
+		}
+	}
+
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index a08c335b7383..af7c4f32143d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -550,6 +550,7 @@ static struct timing_generator_funcs dcn20_tg_funcs = {
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = optc2_set_gsl_source_select,
 		.set_vtg_params = optc1_set_vtg_params,
+		.get_vstartup_start = optc1_get_vstartup_start,
 		.program_manual_trigger = optc2_program_manual_trigger,
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c
index 730875dfd8b4..203a2d7f06b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_optc.c
@@ -183,6 +183,7 @@ static struct timing_generator_funcs dcn201_tg_funcs = {
 		.set_dwb_source = NULL,
 		.get_optc_source = optc201_get_optc_source,
 		.set_vtg_params = optc1_set_vtg_params,
+		.get_vstartup_start = optc1_get_vstartup_start,
 		.program_manual_trigger = optc2_program_manual_trigger,
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 08b92715e2e6..dd25450c8625 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -365,6 +365,7 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = optc2_set_gsl_source_select,
 		.set_vtg_params = optc1_set_vtg_params,
+		.get_vstartup_start = optc1_get_vstartup_start,
 		.program_manual_trigger = optc2_program_manual_trigger,
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
index 63a677c8ee27..8e474f14d4aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -288,6 +288,7 @@ static struct timing_generator_funcs dcn31_tg_funcs = {
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = optc2_set_gsl_source_select,
 		.set_vtg_params = optc1_set_vtg_params,
+		.get_vstartup_start = optc1_get_vstartup_start,
 		.program_manual_trigger = optc2_program_manual_trigger,
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
index 0086cafb0f7a..f978e77748d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
@@ -248,6 +248,7 @@ static struct timing_generator_funcs dcn314_tg_funcs = {
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = optc2_set_gsl_source_select,
 		.set_vtg_params = optc1_set_vtg_params,
+		.get_vstartup_start = optc1_get_vstartup_start,
 		.program_manual_trigger = optc2_program_manual_trigger,
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 2ee798965bc2..596675dd6eda 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -315,6 +315,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = optc2_set_gsl_source_select,
 		.set_vtg_params = optc1_set_vtg_params,
+		.get_vstartup_start = optc1_get_vstartup_start,
 		.program_manual_trigger = optc2_program_manual_trigger,
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 1d9f9c53d2bd..5520b0a01879 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -319,6 +319,7 @@ struct timing_generator_funcs {
 			uint32_t window_start, uint32_t window_end);
 	void (*set_vtotal_change_limit)(struct timing_generator *optc,
 			uint32_t limit);
+	uint32_t (*get_vstartup_start)(struct timing_generator *tg);
 	void (*align_vblanks)(struct timing_generator *master_optc,
 			struct timing_generator *slave_optc,
 			uint32_t master_pixel_clock_100Hz,
-- 
2.25.1

