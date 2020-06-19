Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594B6C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8A9208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LeuC/63o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8A9208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 532836EA6D;
	Fri, 19 Jun 2020 20:13:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3BF89AB7
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg5Pw+WUDkahLdmDYY/DJRGvnqfbGf69F3HU2QSrQYOZzwlRGP/t7BgjRJMEBOKL/873JjtTWc8bnP9Yh9XR9er+mhQqDzSaMOeVHXtap3uhKSj50wnyhbBMHdveeMTxQaVKTile96uqS1TJ3wgMf1FEB13Yh0ToggBR5qAHfBG2pjRmOn4rocmGnQy8KBtbfgCIv1S56baNU+xHNNLFe3o4YGffgR2UxtUrRkwiWzVgWu7EIdKs8gW1HsWIu2Y9out/c/HC++FpP3idyiYmhV0Fn7c1fkZFfQet9tHMRFfBbYAHs8rwMIX8rbewcOFQinXhQurR0KUDY94295pQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNFzvFGDzT/PyNu6sxXRtxiF/3hTSyT9FiWXLQdpejk=;
 b=W99p05S0tSzLDKlzdh/bCSBvQByw/0MH9v0mwJTMTv9jook2QxaxcBGpMu9tKOVmFs/dOZWlUuSFOBKRdL5QZm68f2uFrz5nC2OujnqIuAoA5q2tMJyr80tnBtAn7Njns0FOcbRw2hB2tfUPGmp+N6VJon7Epdxe9TBrwNXyoVh/qdIw4Lo+c8rcmYC4i2XMR713CazIRAe8fI1o9EKECGiAT9j2Bkf7LNjhyRfeCr5OLpd9aDhmIzyrxwx9KRuawKufQGuKnfggO8e/iwil0JUDkv9Rf4Vez3tG+CHEyIDKnZOtiXmDUkLKb2/Uxyel+PG4YDDZSVU78ir8YgZ1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNFzvFGDzT/PyNu6sxXRtxiF/3hTSyT9FiWXLQdpejk=;
 b=LeuC/63o36W3Oufo4nXvxcVa1P9vw8ovsHtYQMOgP+bSl0ccKRx7wqwz7LH2bkPOnq8GTDnAqKM1NMWQvdJEpzjSoI93cWN9UiRPTlA1a0a2sP68lWAk6rf7HQZClSuZd/8611ZCddIR5MkfpOYajcw50tjzpyRBVjg7BmFrPek=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:04 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:04 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/30] drm/amd/display: enable seamless boot for dcn30
Date: Fri, 19 Jun 2020 16:12:16 -0400
Message-Id: <20200619201222.2916504-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:13:03 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bdf2cc00-a3df-4394-1cbb-08d8148d2c8b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4087380FF48D66F0299DCE9B98980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwibKq99SBTKMNRpLCOwRpL++NyP/qLDjSCIN9nCllwyyLNIC6i7XAbke3a3Py/vZ+L3MwYY/qsDGcbGfctLw10XEICub+cIAvWr4l+zD4PYbNAmBf0waiNKPY82nEytbzY63VBVTkMvdW2NFE2qD1A22oG0NqaGvco4B4q7yNqKaRbYZFkPbR3qEE5iMsOPF1318+WqdZYXG33cENDUj7rk4MdATrE2zNLRdrh1lj8hrky5Lb3f5EBQYebJ7kwUn8qdODkO8q3q8SA1YeibRU19VygGZyEOoKmL9Ubp3wU9OZht45rRKp6+ioGG1ZckP6aIt99Pjk/RKz9Htf1xcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(30864003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pN6YKIOHouFNB3N1/tScI/kRZrPNbxYgCwnk+JvSJPVQ9MmXE0Rk2vyMwfUuQ1Av11gYldXpJgLYF1IuSrarbT590Eba6tnsXnGmERWsYwv4BUEygLYvvN/EC2CG7ouL7XW6LC/Ebv3KhUNmoC8CPcUO2Mas0lc3BTvk72HjZkPUDiFyu7cbPFkdmEk+BjJO9MO6PT2JZOXFqWIfRQfG/6PND8mETvGvdcCwemRtx2pmDrX1A+iGq+w9B5I2MnGo8b/5wF0aSjvgGO9g9mw/mYCNMwG5lsxVUCc19MmIo5akbN6rPh61ows9TkdrnTvd9r7Ux0UHJ4cYEWpVgaV8RZY5jocGRgWJV+dO4dcDiGX/Nlr3+uH456a3Tlhey/mbT6tlBy41zSyMYEKYmClhDFIVuY8knFi4J1Y0Ff3+dFZpVXEbmmYHw8tBZ52AoGkb2PAMXMsSfX0vRIAanBv6oicI5bTZlDHzeKnd+hUFCvAS3u9kdjIejoCUPkMj/PkCosv70PVqjcwItA8NKKmo9Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf2cc00-a3df-4394-1cbb-08d8148d2c8b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:13:04.4811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiL5sbjAfruCv2W/Px0ql0hPBkOiSj/j8tuM+jp5hMfxamw6AVBzNzmASESeq7VEjIPVww0xDblDpuh0mNMVvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Martin Leung <martin.leung@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

why:
seamless boots requires split of init_hw into hw and pipes to work. This
was implemented in dcn10_init_hw but did not apply yet to dcn30.

how:
Copy over dcn10_init_hw and adapt it to dcn30 using recent changes to
dcn3.  Behavior will be different in init sequence.

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 245 +++++++++---------
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   8 +-
 2 files changed, 126 insertions(+), 127 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 37c310dbb366..a5d750ed569e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -47,6 +47,8 @@
 #include "mpc.h"
 #include "mcif_wb.h"
 #include "dc_dmub_srv.h"
+#include "link_hwss.h"
+#include "dpcd_defs.h"
 
 
 
@@ -427,7 +429,6 @@ void dcn30_init_hw(struct dc *dc)
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
-	struct dc_state  *context = dc->current_state;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
@@ -437,153 +438,155 @@ void dcn30_init_hw(struct dc *dc)
 	if (res_pool->dccg->funcs->dccg_init)
 		res_pool->dccg->funcs->dccg_init(res_pool->dccg);
 
-	//Enable ability to power gate / don't force power on permanently
-	hws->funcs.enable_power_gating_plane(dc->hwseq, true);
-
 	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		REG_WRITE(RBBMIF_TIMEOUT_DIS, 0xFFFFFFFF);
-		REG_WRITE(RBBMIF_TIMEOUT_DIS_2, 0xFFFFFFFF);
-
-		hws->funcs.dccg_init(hws);
 
-		REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, 2);
-		REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
 		REG_WRITE(REFCLK_CNTL, 0);
-	} else {
-		if (!dcb->funcs->is_accelerated_mode(dcb)) {
-			hws->funcs.bios_golden_init(dc);
-			hws->funcs.disable_vga(dc->hwseq);
-		}
+		REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
+		REG_WRITE(DIO_MEM_PWR_CTRL, 0);
 
-		if (dc->ctx->dc_bios->fw_info_valid) {
-			res_pool->ref_clocks.xtalin_clock_inKhz =
-					dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
-
-			if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-				if (res_pool->dccg && res_pool->hubbub) {
-
-					(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
-							dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
-							&res_pool->ref_clocks.dccg_ref_clock_inKhz);
-
-					(res_pool->hubbub->funcs->get_dchub_ref_freq)(res_pool->hubbub,
-							res_pool->ref_clocks.dccg_ref_clock_inKhz,
-							&res_pool->ref_clocks.dchub_ref_clock_inKhz);
-				} else {
-					// Not all ASICs have DCCG sw component
-					res_pool->ref_clocks.dccg_ref_clock_inKhz =
-							res_pool->ref_clocks.xtalin_clock_inKhz;
-					res_pool->ref_clocks.dchub_ref_clock_inKhz =
-							res_pool->ref_clocks.xtalin_clock_inKhz;
-				}
-			}
-		} else
-			ASSERT_CRITICAL(false);
+		if (!dc->debug.disable_clock_gate) {
+			/* enable all DCN clock gating */
+			REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
 
-		for (i = 0; i < dc->link_count; i++) {
-			/* Power up AND update implementation according to the
-			 * required signal (which may be different from the
-			 * default signal on connector).
-			 */
-			struct dc_link *link = dc->links[i];
+			REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
 
-			link->link_enc->funcs->hw_init(link->link_enc);
+			REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 		}
-	}
 
-	/* Power gate DSCs */
-	for (i = 0; i < res_pool->res_cap->num_dsc; i++)
-		hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
+		//Enable ability to power gate / don't force power on permanently
+		if (hws->funcs.enable_power_gating_plane)
+			hws->funcs.enable_power_gating_plane(hws, true);
 
-	/* Blank pixel data with OPP DPG */
-	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
-		struct timing_generator *tg = dc->res_pool->timing_generators[i];
-
-		if (tg->funcs->is_tg_enabled(tg))
-			hws->funcs.init_blank(dc, tg);
+		return;
 	}
 
-	for (i = 0; i < res_pool->timing_generator_count; i++) {
-		struct timing_generator *tg = dc->res_pool->timing_generators[i];
-
-		if (tg->funcs->is_tg_enabled(tg))
-			tg->funcs->lock(tg);
+	if (!dcb->funcs->is_accelerated_mode(dcb)) {
+		hws->funcs.bios_golden_init(dc);
+		hws->funcs.disable_vga(dc->hwseq);
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct dpp *dpp = res_pool->dpps[i];
-
-		dpp->funcs->dpp_reset(dpp);
-	}
+	if (dc->ctx->dc_bios->fw_info_valid) {
+		res_pool->ref_clocks.xtalin_clock_inKhz =
+				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-	/* Reset all MPCC muxes */
-	res_pool->mpc->funcs->mpc_init(res_pool->mpc);
+		if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+			if (res_pool->dccg && res_pool->hubbub) {
 
-	/* initialize OPP mpc_tree parameter */
-	for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
-		res_pool->opps[i]->mpc_tree_params.opp_id = res_pool->opps[i]->inst;
-		res_pool->opps[i]->mpc_tree_params.opp_list = NULL;
-		for (j = 0; j < MAX_PIPES; j++)
-			res_pool->opps[i]->mpcc_disconnect_pending[j] = false;
-	}
+				(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
+						dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
+						&res_pool->ref_clocks.dccg_ref_clock_inKhz);
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct timing_generator *tg = dc->res_pool->timing_generators[i];
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-		struct hubp *hubp = dc->res_pool->hubps[i];
-		struct dpp *dpp = dc->res_pool->dpps[i];
-
-		pipe_ctx->stream_res.tg = tg;
-		pipe_ctx->pipe_idx = i;
-
-		pipe_ctx->plane_res.hubp = hubp;
-		pipe_ctx->plane_res.dpp = dpp;
-		pipe_ctx->plane_res.mpcc_inst = dpp->inst;
-		hubp->mpcc_id = dpp->inst;
-		hubp->opp_id = OPP_ID_INVALID;
-		hubp->power_gated = false;
-		pipe_ctx->stream_res.opp = NULL;
-
-		hubp->funcs->hubp_init(hubp);
-
-		//dc->res_pool->opps[i]->mpc_tree_params.opp_id = dc->res_pool->opps[i]->inst;
-		//dc->res_pool->opps[i]->mpc_tree_params.opp_list = NULL;
-		dc->res_pool->opps[i]->mpcc_disconnect_pending[pipe_ctx->plane_res.mpcc_inst] = true;
-		pipe_ctx->stream_res.opp = dc->res_pool->opps[i];
-		/*to do*/
-		hws->funcs.plane_atomic_disconnect(dc, pipe_ctx);
-	}
+				(res_pool->hubbub->funcs->get_dchub_ref_freq)(res_pool->hubbub,
+						res_pool->ref_clocks.dccg_ref_clock_inKhz,
+						&res_pool->ref_clocks.dchub_ref_clock_inKhz);
+			} else {
+				// Not all ASICs have DCCG sw component
+				res_pool->ref_clocks.dccg_ref_clock_inKhz =
+						res_pool->ref_clocks.xtalin_clock_inKhz;
+				res_pool->ref_clocks.dchub_ref_clock_inKhz =
+						res_pool->ref_clocks.xtalin_clock_inKhz;
+			}
+		}
+	} else
+		ASSERT_CRITICAL(false);
 
-	/* initialize DWB pointer to MCIF_WB */
-	for (i = 0; i < res_pool->res_cap->num_dwb; i++)
-		res_pool->dwbc[i]->mcif = res_pool->mcif_wb[i];
+	for (i = 0; i < dc->link_count; i++) {
+		/* Power up AND update implementation according to the
+		 * required signal (which may be different from the
+		 * default signal on connector).
+		 */
+		struct dc_link *link = dc->links[i];
 
-	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
-		struct timing_generator *tg = dc->res_pool->timing_generators[i];
+		link->link_enc->funcs->hw_init(link->link_enc);
 
-		if (tg->funcs->is_tg_enabled(tg))
-			tg->funcs->unlock(tg);
+		/* Check for enabled DIG to identify enabled display */
+		if (link->link_enc->funcs->is_dig_enabled &&
+			link->link_enc->funcs->is_dig_enabled(link->link_enc))
+			link->link_status.link_active = true;
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+	/* Power gate DSCs */
+	for (i = 0; i < res_pool->res_cap->num_dsc; i++)
+		if (hws->funcs.dsc_pg_control != NULL)
+			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
 
-		dc->hwss.disable_plane(dc, pipe_ctx);
+	/* we want to turn off all dp displays before doing detection */
+	if (dc->config.power_down_display_on_boot) {
+		uint8_t dpcd_power_state = '\0';
+		enum dc_status status = DC_ERROR_UNEXPECTED;
 
-		pipe_ctx->stream_res.tg = NULL;
-		pipe_ctx->plane_res.hubp = NULL;
+		for (i = 0; i < dc->link_count; i++) {
+			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
+				continue;
+
+			/* if any of the displays are lit up turn them off */
+			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
+						     &dpcd_power_state, sizeof(dpcd_power_state));
+			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
+				/* blank dp stream before power off receiver*/
+				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
+					unsigned int fe;
+
+					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
+										dc->links[i]->link_enc);
+
+					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+						if (fe == dc->res_pool->stream_enc[j]->id) {
+							dc->res_pool->stream_enc[j]->funcs->dp_blank(
+										dc->res_pool->stream_enc[j]);
+							break;
+						}
+					}
+				}
+				dp_receiver_power_ctrl(dc->links[i], false);
+			}
+		}
 	}
 
-	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
-		struct timing_generator *tg = dc->res_pool->timing_generators[i];
-
-		tg->funcs->tg_init(tg);
+	/* If taking control over from VBIOS, we may want to optimize our first
+	 * mode set, so we need to skip powering down pipes until we know which
+	 * pipes we want to use.
+	 * Otherwise, if taking control is not possible, we need to power
+	 * everything down.
+	 */
+	if (dcb->funcs->is_accelerated_mode(dcb) || dc->config.power_down_display_on_boot) {
+		hws->funcs.init_pipes(dc, dc->current_state);
+		if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
+			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
+					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
 	}
 
-	/* end of FPGA. Below if real ASIC */
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
-		return;
+	/* In headless boot cases, DIG may be turned
+	 * on which causes HW/SW discrepancies.
+	 * To avoid this, power down hardware on boot
+	 * if DIG is turned on and seamless boot not enabled
+	 */
+	if (dc->config.power_down_display_on_boot) {
+		struct dc_link *edp_link = get_edp_link(dc);
+
+		if (edp_link &&
+				edp_link->link_enc->funcs->is_dig_enabled &&
+				edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
+				dc->hwss.edp_backlight_control &&
+				dc->hwss.power_down &&
+				dc->hwss.edp_power_control) {
+			dc->hwss.edp_backlight_control(edp_link, false);
+			dc->hwss.power_down(dc);
+			dc->hwss.edp_power_control(edp_link, false);
+		} else {
+			for (i = 0; i < dc->link_count; i++) {
+				struct dc_link *link = dc->links[i];
+
+				if (link->link_enc->funcs->is_dig_enabled &&
+						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
+						dc->hwss.power_down) {
+					dc->hwss.power_down(dc);
+					break;
+				}
 
+			}
+		}
+	}
 
 	for (i = 0; i < res_pool->audio_count; i++) {
 		struct audio *audio = res_pool->audios[i];
@@ -614,6 +617,8 @@ void dcn30_init_hw(struct dc *dc)
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
+	if (hws->funcs.enable_power_gating_plane)
+		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
 
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index a76a191abaf2..1b354c219d0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -30,7 +30,7 @@
 
 static const struct hw_sequencer_funcs dcn30_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
-	.init_hw = dcn10_init_hw,
+	.init_hw = dcn30_init_hw,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
@@ -138,10 +138,4 @@ void dcn30_hw_sequencer_construct(struct dc *dc)
 		dc->hwss.init_hw = dcn20_fpga_init_hw;
 		dc->hwseq->funcs.init_pipes = NULL;
 	}
-
-	// TODO: Use generic dcn10_init_hw and dcn10_init_pipes sequence
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		dc->hwss.init_hw = dcn30_init_hw;
-		dc->hwseq->funcs.init_pipes = NULL;
-	}
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
