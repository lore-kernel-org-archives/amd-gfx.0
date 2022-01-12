Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CB9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 14:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C455310F1AE;
	Wed, 12 Jan 2022 14:28:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310AE10F1AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 14:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlygfQh0VAUqLhWT5CZ4J7JW10pWxou4vFXguFk3AfpPT55MYFN0Thd6eMcu03yFqOCDVX8sDY0TiDhjuxZnRQcYhDSAHZEUkDYePMP/09DqsAqQVIreqW6qjvSGGBSheNxxdWWVNNS7PqIQrvHIJNGI5WYBydiz5A6mR/pMzONOTy8WmdqyCSXt0dPjqvTzXjLJQiBdG8LilJ7wpMeeti+K/DIj/pcEbOgjo/MrDGWFN4wvbYx7ilp4ou7TAY642iXbN3oXD+dl+teXEUMOuWp9lHzTxt+5JP0mwPaquoGOrY4UevYy1WauXm0yE5PX/p4aYNCkR5tGqxk3Jm5emA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeUwYaHyRVVN3mwZYI2q/L2S4Uzbk+I9wvvuaa1DsaE=;
 b=n/SXYf3j6b3bbM09sHya5WIEmpizK1kycuvYwFYQ/yTfZ9O+TAXHJ1o6uk3RiA+p6ZcCrnBhDSyd6ubfaQKoeRqa7dEvfR3vQJDnTaVcm1MvgG9xrxWBlJ3gaypB6h7hRNYmtLmYz1t/4puEOnzRdfhDXxaM/zrP1LVfnlgLWMfGCuYisSRmqe5RhBMPzEU9Q+0WmeG9rM3EoOck9MynAxDHb3eokoZgeyb9XQncd9NrnaosqtEmW5sG88Xwa5cqvD6Dpvn1ibss6ZPkXxQkDMxifLrADVV5SpjjpoGi2xHIpwSPtUz1me7nGGfVAJ3mDxotkKnky3mfCn1mHS8yqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeUwYaHyRVVN3mwZYI2q/L2S4Uzbk+I9wvvuaa1DsaE=;
 b=UUuLOkf65W9JZpxEhM0wyOFZa8wqMk1p8ouyTYoBl2Gl6QKaC6LEyu1TBmAUWT9mSQMm+zkpC+yXQojhMR30RlFMR1MIzzYSs6bLqsriLCwVlcngxgntfPiTOErGF8awBrpg0WA5U9Dk9SF94pA55DJSoGwDraepnLYKDcrZhGs=
Received: from BN8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:408:ac::21)
 by CH2PR12MB3878.namprd12.prod.outlook.com (2603:10b6:610:2a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 14:28:11 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::8e) by BN8PR07CA0008.outlook.office365.com
 (2603:10b6:408:ac::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 14:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 14:28:10 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 08:28:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 06:28:07 -0800
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 12 Jan 2022 08:27:45 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] Revert "drm/amd/display: Fix for otg synchronization
 logic"
Date: Wed, 12 Jan 2022 09:27:26 -0500
Message-ID: <20220112142727.16295-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112142727.16295-1-harry.wentland@amd.com>
References: <20220112142727.16295-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af198f6-4348-42ef-a058-08d9d5d7c224
X-MS-TrafficTypeDiagnostic: CH2PR12MB3878:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB387833A788FC958157E85EC88C529@CH2PR12MB3878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Chok+vzpMhWdFAF/FKaOUAm1krKh/uuqzxAGVxI3wgtwT73y7HW54taSAPrxSFvn4r60x2FT5xaWF9eApjG62zNJGP147Da6fffK7YTa6YP4dTiO55DLv4qN/5Es4yqMGdxxIjopu6dltVyQBUbiO2PFZPDCcvuy0DzN8tb0NWIxC0lb8+DYSvjtbjpLW7ttvvUBBUMdR/d2sk/BT1TFX91AMafzhEQIvGQxdUMCjZP4cH8C8JKvFMlppo1CHE8BIOdU7/se/xBbnvd9niq3vRN+n8eQb58uobb4aO95ZVyRni/F7HCxDfflOdDavR8Nh/zbKEz0VJp5uLvdH6dD1AkuLNIm2tfPAAudn6BBr06Mx6JZSXobYIadeR+ih+LLz3HGAldu6K04JNe7Ctzy0xZSFZYtMtKBAxVwbil3QpkYYEpXku7IrOeJObRXPJgReZ388GpubPHGLzMiYavcZWDULmktr34xGaofD1jIvhiSXqiQGYi5xWOgWyPz9ZY/qJNsLUDWv3u0ai2ZO8WPgNMGMXBETGqDDFgUohLGB0g+tcwyM+9mZ5uY7pNqxj/qXsgAIoSWhjlCeK6UsFfh6RkaIV0jpUlUSndJVN5pDEI4iesUnPRYjLdPxbmGauBQPUhTW6NqiEbi1r8IUz4vP5djMbxAywz5Cdz31zEkNsJXfiWJzWEmEbjxxGsBCLLz4BY9ALVWxLJC+517Evqa01ETDQbteBd+r1REFvPD64s2sDsryYXrEXladEwWlBcUk8hYdDQy98C1NnWacwYfD7iuqrwTcMo3uJYubgIb+g36QftBNCdM5QL23ZfT/CL8DeA+3QTxWjqqutvE89MyPps1EN89TffppNuB9M0gt4ha4jFTpfru+Bbnik6k84e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(82310400004)(5660300002)(356005)(426003)(81166007)(86362001)(83380400001)(6916009)(40460700001)(7696005)(316002)(47076005)(44832011)(26005)(6666004)(336012)(8936002)(36860700001)(966005)(2616005)(4326008)(8676002)(2906002)(70206006)(508600001)(186003)(70586007)(54906003)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 14:28:10.1032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af198f6-4348-42ef-a058-08d9d5d7c224
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3878
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
Cc: meenakshikumar somasundaram <meenakshikumar.somasundaram@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Harry
 Wentland <harry.wentland@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Jun Lei <Jun.Lei@amd.com>, Dave Airlie <airlied@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Mustapha Ghaddar <mustapha.ghaddar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Linus Torvalds <torvalds@linux-foundation.org>

This reverts commit a896f870f8a5f23ec961d16baffd3fda1f8be57c.

It causes odd flickering on my Radeon RX580 (PCI ID 1002:67df rev e7,
subsystem ID 1da2:e353).

Bisected right to this commit, and reverting it fixes things.

Link: https://lore.kernel.org/all/CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com/
Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Jun Lei <Jun.Lei@amd.com>
Cc: Mustapha Ghaddar <mustapha.ghaddar@amd.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: meenakshikumar somasundaram <meenakshikumar.somasundaram@amd.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 35 +++++-------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 54 -------------------
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |  8 ---
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  3 --
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 10 ----
 7 files changed, 14 insertions(+), 98 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 91c4874473d6..01c8849b9db2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1404,29 +1404,22 @@ static void program_timing_sync(
 				status->timing_sync_info.master = false;
 
 		}
+		/* remove any other unblanked pipes as they have already been synced */
+		for (j = j + 1; j < group_size; j++) {
+			bool is_blanked;
 
-		/* remove any other pipes that are already been synced */
-		if (dc->config.use_pipe_ctx_sync_logic) {
-			/* check pipe's syncd to decide which pipe to be removed */
-			for (j = 1; j < group_size; j++) {
-				if (pipe_set[j]->pipe_idx_syncd == pipe_set[0]->pipe_idx_syncd) {
-					group_size--;
-					pipe_set[j] = pipe_set[group_size];
-					j--;
-				} else
-					/* link slave pipe's syncd with master pipe */
-					pipe_set[j]->pipe_idx_syncd = pipe_set[0]->pipe_idx_syncd;
+			if (pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked)
+				is_blanked =
+					pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked(pipe_set[j]->stream_res.opp);
+			else
+				is_blanked =
+					pipe_set[j]->stream_res.tg->funcs->is_blanked(pipe_set[j]->stream_res.tg);
+			if (!is_blanked) {
+				group_size--;
+				pipe_set[j] = pipe_set[group_size];
+				j--;
 			}
-		} else {
-			/* remove any other pipes by checking valid plane */
-			for (j = j + 1; j < group_size; j++) {
-				if (pipe_set[j]->plane_state) {
-					group_size--;
-					pipe_set[j] = pipe_set[group_size];
-					j--;
-				}
- 			}
- 		}
+		}
 
 		if (group_size > 1) {
 			if (sync_type == TIMING_SYNCHRONIZABLE) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b3912ff9dc91..d4ff6cc6b8d9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3217,60 +3217,6 @@ struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
 }
 #endif
 
-void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
-		struct dc_state *context)
-{
-	int i, j;
-	struct pipe_ctx *pipe_ctx_old, *pipe_ctx, *pipe_ctx_syncd;
-
-	/* If pipe backend is reset, need to reset pipe syncd status */
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		pipe_ctx_old =	&dc->current_state->res_ctx.pipe_ctx[i];
-		pipe_ctx = &context->res_ctx.pipe_ctx[i];
-
-		if (!pipe_ctx_old->stream)
-			continue;
-
-		if (pipe_ctx_old->top_pipe || pipe_ctx_old->prev_odm_pipe)
-			continue;
-
-		if (!pipe_ctx->stream ||
-				pipe_need_reprogram(pipe_ctx_old, pipe_ctx)) {
-
-			/* Reset all the syncd pipes from the disabled pipe */
-			for (j = 0; j < dc->res_pool->pipe_count; j++) {
-				pipe_ctx_syncd = &context->res_ctx.pipe_ctx[j];
-				if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_syncd) == pipe_ctx_old->pipe_idx) ||
-					!IS_PIPE_SYNCD_VALID(pipe_ctx_syncd))
-					SET_PIPE_SYNCD_TO_PIPE(pipe_ctx_syncd, j);
-			}
-		}
-	}
-}
-
-void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
-	struct dc_state *context,
-	uint8_t disabled_master_pipe_idx)
-{
-	int i;
-	struct pipe_ctx *pipe_ctx, *pipe_ctx_check;
-
-	pipe_ctx = &context->res_ctx.pipe_ctx[disabled_master_pipe_idx];
-	if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx) != disabled_master_pipe_idx) ||
-		!IS_PIPE_SYNCD_VALID(pipe_ctx))
-		SET_PIPE_SYNCD_TO_PIPE(pipe_ctx, disabled_master_pipe_idx);
-
-	/* for the pipe disabled, check if any slave pipe exists and assert */
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		pipe_ctx_check = &context->res_ctx.pipe_ctx[i];
-
-		if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_check) == disabled_master_pipe_idx) &&
-			IS_PIPE_SYNCD_VALID(pipe_ctx_check) && (i != disabled_master_pipe_idx))
-			DC_ERR("DC: Failure: pipe_idx[%d] syncd with disabled master pipe_idx[%d]\n",
-				i, disabled_master_pipe_idx);
-	}
-}
-
 uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter transmitter)
 {
 	/* TODO - get transmitter to phy idx mapping from DMUB */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 288e7b01f561..da2c78ce14d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -344,7 +344,6 @@ struct dc_config {
 	uint8_t  vblank_alignment_max_frame_time_diff;
 	bool is_asymmetric_memory;
 	bool is_single_rank_dimm;
-	bool use_pipe_ctx_sync_logic;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index f1593186e964..78192ecba102 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1566,10 +1566,6 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 				&pipe_ctx->stream->audio_info);
 	}
 
-	/* make sure no pipes syncd to the pipe being enabled */
-	if (!pipe_ctx->stream->apply_seamless_boot_optimization && dc->config.use_pipe_ctx_sync_logic)
-		check_syncd_pipes_for_disabled_master_pipe(dc, context, pipe_ctx->pipe_idx);
-
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* DCN3.1 FPGA Workaround
 	 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
@@ -2301,10 +2297,6 @@ enum dc_status dce110_apply_ctx_to_hw(
 	enum dc_status status;
 	int i;
 
-	/* reset syncd pipes from disabled pipes */
-	if (dc->config.use_pipe_ctx_sync_logic)
-		reset_syncd_pipes_from_disabled_pipes(dc, context);
-
 	/* Reset old context */
 	/* look up the targets that have been removed since last commit */
 	hws->funcs.reset_hw_ctx_wrap(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 40778c05f9b3..1f1c158658ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2254,9 +2254,6 @@ static bool dcn31_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
-	/* Use pipe context based otg sync logic */
-	dc->config.use_pipe_ctx_sync_logic = true;
-
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 943240e2809e..890280026e69 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -382,7 +382,6 @@ struct pipe_ctx {
 	struct pll_settings pll_settings;
 
 	uint8_t pipe_idx;
-	uint8_t pipe_idx_syncd;
 
 	struct pipe_ctx *top_pipe;
 	struct pipe_ctx *bottom_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 028180f58f71..4249bf306e09 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -34,10 +34,6 @@
 #define MEMORY_TYPE_HBM 2
 
 
-#define IS_PIPE_SYNCD_VALID(pipe) ((((pipe)->pipe_idx_syncd) & 0x80)?1:0)
-#define GET_PIPE_SYNCD_FROM_PIPE(pipe) ((pipe)->pipe_idx_syncd & 0x7F)
-#define SET_PIPE_SYNCD_TO_PIPE(pipe, pipe_syncd) ((pipe)->pipe_idx_syncd = (0x80 | pipe_syncd))
-
 enum dce_version resource_parse_asic_id(
 		struct hw_asic_id asic_id);
 
@@ -212,12 +208,6 @@ struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
 		const struct dc_link *link);
 #endif
 
-void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
-	struct dc_state *context);
-
-void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
-	struct dc_state *context,
-	uint8_t disabled_master_pipe_idx);
 uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter transmitter);
 
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.34.1

