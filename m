Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A29CDD1CD
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF56210ECF5;
	Fri, 27 Sep 2024 17:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cRTxf57D";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE5110ECF5
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II6Jh+wCxSGlUVKfqnjq/wUXPyfjTOK+Zg2KZUIxyYRdtfqvBPoawECUNCyzZd0T6ztHFJSTr0s4Q9ozHJusPuef3N6hExqPxmYfEymBi8jD3gsKWjNeuegRY0jnlWb2/RgbPcqpfsHM67qyCRVqdT3IzPjGVXv4KzC815U/3dw70rerhLRTu6CCXzv0MtT/85h5XTmI3pCmSnuiuFaMIatqbggfQ505KFT4Xq3orJZolTTWMwa2FoZJplWYV98bNXbdYgC1c15MEaTuKj0bBsyPQbL33RGuwgCFut1y/T7rT7fcd03mOvl+9uDIPRfPgD3tct/YGqlfphUUkcOaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx7dGu4XaXES+aNNIcM8792SMxGMF1nkG3CnLkY4sWI=;
 b=NzkGKMHmXiC8uq6uKlDDisbMb4/63+nxV4Tttq/mm0D3pjoJLVV+lgI9zZz7vfJwe0OA8J6eg8eCU7k5AWVYs/cjSDV5anqvpTpizb2V/9OBV0pN+9vcZWOpyNJadUpuc5fWtY+4sU42Z9H1Hnf3aQ8pUhEKED9nubcy8RNDbiUHKnrQxU6Ao7zKv7qdkaN/9WpmZJcUU53SR+YI9eMbiQk88Yghuvf3U1OBirCtvU/ZDbt/1mC9v9byaEiJf5d0fPGwSLoVl7kNGZW86J9gmr2Xi/FQO3kAbJaLyK4elehclAquRdu/DTF+35AE1HkLtgydsw8riZQISxnH20YSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx7dGu4XaXES+aNNIcM8792SMxGMF1nkG3CnLkY4sWI=;
 b=cRTxf57DGj1dUlddfAtf5e7YIWh/PUI24eztA9dHXZIlDQ+h9ccoy2xd9hayHbIuMqEN9wpie4CG6mxD5vj5eU6/5WYJfCfuLVgcjlV92DyTzjA8fGmlncaryL3oxqFBVXzA3ZulWl36RJtOdQJKKqTihpCM6drJ3iYDIXxrtLM=
Received: from CH0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:76::11)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 17:01:51 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::e2) by CH0PR04CA0006.outlook.office365.com
 (2603:10b6:610:76::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:49 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:48 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 11/13] drm/amd/display: Configure DTBCLK_P with OPTC only for
 dcn401
Date: Fri, 27 Sep 2024 13:01:01 -0400
Message-ID: <20240927170103.102180-12-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 521106bb-6bdb-4ea9-25a9-08dcdf1614af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?98ihtupJ17qB4omSRZNirFGAnu4PnCoyvdEevKMnCnHxdzzMEnSO0Iuhtcd6?=
 =?us-ascii?Q?pYJUOUX7k9m23vOUKXOWNQXPmCId+PNb7mxywglmsoPyXAcJSMnQWHMfqp7p?=
 =?us-ascii?Q?vuUGUMoI2CGBExw+x5ewsHuKRQv35SxWvWOoNiYgqU1ZID/p+iifkzkPpumi?=
 =?us-ascii?Q?JiVUzBKJeuYfn4XIPBma6AeVyzDk4wlQdjacHjH6nDq8n1DCjuP5IvykVISJ?=
 =?us-ascii?Q?+a8ZUvqPJhrWtZ5VvIBocrdLoZfiEoOSZxEceoMV5UBK5E4+Ym0Xomuyk4jn?=
 =?us-ascii?Q?80sN1Wu0X+sZFs3bhRQFpc6laskjh5eo3pp/UQ9mE4tiQ1f8cE7Teq8gRZVr?=
 =?us-ascii?Q?eHGRkoE4B1Dr17nAqr5B8Hoztb3lxPD1cg146qe4Odi7J41ODwdumL+O7qAi?=
 =?us-ascii?Q?jxAbk8WD4tGy65KhR+9SkZZSJ5wqJqOcIUXl7/s2GEVs1J4cA2Z8Qp6ekOOr?=
 =?us-ascii?Q?2X9jgcGlkuN+mi1ahh/t2pCxOJahS5Qp3WFx6leUa5YE13HWoSDXFuABAhpL?=
 =?us-ascii?Q?9LLwZd2eHSkt3WvK+0928Vr3+ASjf8QlDLI5T5oQ3WoB5vbV/1g2St25tdBd?=
 =?us-ascii?Q?cC1TC5MPDSqRI2V0R63gXurUTh+om7AsFS5hDrNvoehmF+o/EtzlIY+C0l60?=
 =?us-ascii?Q?KYb2hcOCzDo0OgzCqeifqzdKPGxJ6S0oonU09i2q5PQWetgZQNfffaYqHBfi?=
 =?us-ascii?Q?NsdRfQPhzJt9Jyylf9y6VP6oA47QJ+QF1S2Pcvdc/i4kz11j2vaiKlHCo49s?=
 =?us-ascii?Q?mtASQq4SGU7uoxhSKcLLBAq9lZthkrCdFBbnmEu68Kc1leYqYhAVH1habB2n?=
 =?us-ascii?Q?R5s/tqS9vU8NWWhchu0Ht7bP0LazLEN74dTLvNnL5V00kzosF4rT3YvGSqXP?=
 =?us-ascii?Q?NQw+trpAocbuBejQJbFYqgvEwiAJrB98KqnB1s53mnpQqOetsZi9O+IOSrMz?=
 =?us-ascii?Q?nfLJAiuq2l9KHy6ZaX6nW6vjObbHUZHUfMo0axaFy+FjWNEJKxE0XAuY78QX?=
 =?us-ascii?Q?sg5DseeeJG4FYr4HH81X6nIjK20fy41MFoAQnBV+vtG9zgSHZg5h0kRKNBoJ?=
 =?us-ascii?Q?U3+GVzHVZHhyegGmWf3dIMX1ojqW/wtdrNbJg0Ak9ecBoqgrq35FCeYxRMre?=
 =?us-ascii?Q?GkiDAr24sJJ4MNmC77ocLuAetDVAjblVFoNWArOfhX9hWCb1xLC+01auP7ci?=
 =?us-ascii?Q?TL6zI5kHWjj4yvBH0+2Plot1BqTSk1ZcNJsMwByiLmIgj7lyEQWBpbLtl0QG?=
 =?us-ascii?Q?NlKxIiKhJpIKX7tJUrNhrHBlEVYUoH3XolTh2BqrDvnK/BW98DV4xl3F9EZu?=
 =?us-ascii?Q?qtpWxojarNhp9+WxjHwAaxgYv+gjvUEij9coADnuMaM/g8KeE5RKeLT2ilu7?=
 =?us-ascii?Q?4KsQj1oLuw8HQZv6DJj6OatY1LZCe153iyxXpopKyQmvcAldDVRLnp99DqcB?=
 =?us-ascii?Q?WNNbIXuvUjUNsrt+2xgpUw6OXiPpj81N?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:50.6096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 521106bb-6bdb-4ea9-25a9-08dcdf1614af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY]
DTBCLK_P is used to generate virtual pixel clock, and to drive the HPO
stream encoder clock. Programming the required clock when
enabling/disabling both components can cause issues.
For example, if HPO is being disabled and clock source is changed to
REFCLK, virtual pixel rate will then be wrong, causing issues in CRTC.

[HOW]
Only program the DTBCLK_P when programming CRTC, as its expected it will
be enabled prior to HPO, and disabled after HPO in all valid cases.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   3 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 135 +++++++++++++++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   7 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   4 +-
 4 files changed, 142 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 5babd53025ae..d3e46c3cfa57 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -580,9 +580,6 @@ static void dccg401_set_dpstreamclk(
 		int otg_inst,
 		int dp_hpo_inst)
 {
-	/* set the dtbclk_p source */
-	dccg401_set_dtbclk_p_src(dccg, src, otg_inst);
-
 	/* enabled to select one of the DTBCLKs for pipe */
 	if (src == REFCLK)
 		dccg401_disable_dpstreamclk(dccg, dp_hpo_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index b690f0565d28..49a37f5ee28e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -844,6 +844,13 @@ enum dc_status dcn401_enable_stream_timing(
 				odm_slice_width, last_odm_slice_width);
 	}
 
+	/* set DTBCLK_P */
+	if (dc->res_pool->dccg->funcs->set_dtbclk_p_src) {
+		if (dc_is_dp_signal(stream->signal) || dc_is_virtual_signal(stream->signal)) {
+			dc->res_pool->dccg->funcs->set_dtbclk_p_src(dc->res_pool->dccg, DPREFCLK, pipe_ctx->stream_res.tg->inst);
+		}
+	}
+
 	/* HW program guide assume display already disable
 	 * by unplug sequence. OTG assume stop.
 	 */
@@ -1004,8 +1011,6 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 
 			dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
 		} else {
-			/* need to set DTBCLK_P source to DPREFCLK for DP8B10B */
-			dccg->funcs->set_dtbclk_p_src(dccg, DPREFCLK, tg->inst);
 			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
 					link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 		}
@@ -1819,3 +1824,129 @@ void dcn401_program_outstanding_updates(struct dc *dc,
 	if (hubbub->funcs->program_compbuf_segments)
 		hubbub->funcs->program_compbuf_segments(hubbub, context->bw_ctx.bw.dcn.arb_regs.compbuf_size, true);
 }
+
+void dcn401_reset_back_end_for_pipe(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context)
+{
+	int i;
+	struct dc_link *link = pipe_ctx->stream->link;
+	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+
+	DC_LOGGER_INIT(dc->ctx->logger);
+	if (pipe_ctx->stream_res.stream_enc == NULL) {
+		pipe_ctx->stream = NULL;
+		return;
+	}
+
+	/* DPMS may already disable or */
+	/* dpms_off status is incorrect due to fastboot
+	 * feature. When system resume from S4 with second
+	 * screen only, the dpms_off would be true but
+	 * VBIOS lit up eDP, so check link status too.
+	 */
+	if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+		dc->link_srv->set_dpms_off(pipe_ctx);
+	else if (pipe_ctx->stream_res.audio)
+		dc->hwss.disable_audio_stream(pipe_ctx);
+
+	/* free acquired resources */
+	if (pipe_ctx->stream_res.audio) {
+		/*disable az_endpoint*/
+		pipe_ctx->stream_res.audio->funcs->az_disable(pipe_ctx->stream_res.audio);
+
+		/*free audio*/
+		if (dc->caps.dynamic_audio == true) {
+			/*we have to dynamic arbitrate the audio endpoints*/
+			/*we free the resource, need reset is_audio_acquired*/
+			update_audio_usage(&dc->current_state->res_ctx, dc->res_pool,
+					pipe_ctx->stream_res.audio, false);
+			pipe_ctx->stream_res.audio = NULL;
+		}
+	}
+
+	/* by upper caller loop, parent pipe: pipe0, will be reset last.
+	 * back end share by all pipes and will be disable only when disable
+	 * parent pipe.
+	 */
+	if (pipe_ctx->top_pipe == NULL) {
+
+		dc->hwss.set_abm_immediate_disable(pipe_ctx);
+
+		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
+
+		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
+		if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
+			pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
+					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
+
+		if (pipe_ctx->stream_res.tg->funcs->set_drr)
+			pipe_ctx->stream_res.tg->funcs->set_drr(
+					pipe_ctx->stream_res.tg, NULL);
+		/* TODO - convert symclk_ref_cnts for otg to a bit map to solve
+		 * the case where the same symclk is shared across multiple otg
+		 * instances
+		 */
+		if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
+			link->phy_state.symclk_ref_cnts.otg = 0;
+		if (link->phy_state.symclk_state == SYMCLK_ON_TX_OFF) {
+			link_hwss->disable_link_output(link,
+					&pipe_ctx->link_res, pipe_ctx->stream->signal);
+			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		}
+
+		/* reset DTBCLK_P */
+		if (dc->res_pool->dccg->funcs->set_dtbclk_p_src)
+			dc->res_pool->dccg->funcs->set_dtbclk_p_src(dc->res_pool->dccg, REFCLK, pipe_ctx->stream_res.tg->inst);
+	}
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++)
+		if (&dc->current_state->res_ctx.pipe_ctx[i] == pipe_ctx)
+			break;
+
+	if (i == dc->res_pool->pipe_count)
+		return;
+
+/*
+ * In case of a dangling plane, setting this to NULL unconditionally
+ * causes failures during reset hw ctx where, if stream is NULL,
+ * it is expected that the pipe_ctx pointers to pipes and plane are NULL.
+ */
+	pipe_ctx->stream = NULL;
+	DC_LOG_DEBUG("Reset back end for pipe %d, tg:%d\n",
+					pipe_ctx->pipe_idx, pipe_ctx->stream_res.tg->inst);
+}
+
+void dcn401_reset_hw_ctx_wrap(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	int i;
+	struct dce_hwseq *hws = dc->hwseq;
+
+	/* Reset Back End*/
+	for (i = dc->res_pool->pipe_count - 1; i >= 0 ; i--) {
+		struct pipe_ctx *pipe_ctx_old =
+			&dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe_ctx_old->stream)
+			continue;
+
+		if (pipe_ctx_old->top_pipe || pipe_ctx_old->prev_odm_pipe)
+			continue;
+
+		if (!pipe_ctx->stream ||
+				pipe_need_reprogram(pipe_ctx_old, pipe_ctx)) {
+			struct clock_source *old_clk = pipe_ctx_old->clock_source;
+
+			if (hws->funcs.reset_back_end_for_pipe)
+				hws->funcs.reset_back_end_for_pipe(dc, pipe_ctx_old, dc->current_state);
+			if (hws->funcs.enable_stream_gating)
+				hws->funcs.enable_stream_gating(dc, pipe_ctx_old);
+			if (old_clk)
+				old_clk->funcs->cs_power_down(old_clk);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index e6692cd905d6..66d679080c44 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -88,4 +88,11 @@ void adjust_hotspot_between_slices_for_2x_magnify(uint32_t cursor_width, struct
 void dcn401_wait_for_det_buffer_update_under_otg_master(struct dc *dc, struct dc_state *context, struct pipe_ctx *otg_master);
 void dcn401_interdependent_update_lock(struct dc *dc, struct dc_state *context, bool lock);
 void dcn401_program_outstanding_updates(struct dc *dc, struct dc_state *context);
+void dcn401_reset_back_end_for_pipe(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context);
+void dcn401_reset_hw_ctx_wrap(
+		struct dc *dc,
+		struct dc_state *context);
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index d1128a8082a5..af0d40a5cb77 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -112,7 +112,7 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.power_down = dce110_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
-	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
+	.reset_hw_ctx_wrap = dcn401_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn401_enable_stream_timing,
 	.edp_backlight_control = dce110_edp_backlight_control,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
@@ -137,7 +137,7 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.update_mall_sel = dcn32_update_mall_sel,
 	.calculate_dccg_k1_k2_values = NULL,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
-	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
+	.reset_back_end_for_pipe = dcn401_reset_back_end_for_pipe,
 	.populate_mcm_luts = NULL,
 };
 
-- 
2.34.1

