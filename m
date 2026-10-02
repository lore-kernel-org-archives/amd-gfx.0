Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A99CA5FDD
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F0F10F971;
	Fri,  2 Oct 2026 19:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wPigyELz";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013013.outbound.protection.outlook.com
 [40.93.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE5410F9D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mon6I/chVe6rD8fUXq2ydge8pyrvEzeM5k9gY1qhU9j5jsDdAAFAMN12fl260E6qwK2Jl15uoSGNtvocBEfp9YfMsiUaHU2JDrm9sjM7bNia/S54/TXKm395vGRM3PxffBMzhfLbwY41FCG/oyHHHhEomN1cpJ8lk90FZNwrxnMKtG8lMlxo/PITd5qPmdE5Jt1//KgeakN31VU2l/yxE8ZKXGxkd+n+KZY3Tlef7cxjrq5YLy6lO93Y1PbrB63bn4TfCyRIqZvwUWw6+B21Gc7/PYK2q3Nj47c728F/tc/E1WFPdiTu+Kn1VsJCyVX6VDm8mgC6aNWJ04LrrT5ilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XwmHZ4nWd3xNRNZurghK5+NTrl83JHOtwV+erP4owA=;
 b=d8FuPBViQ1wS2uvlZlmTDKudaVn8npF/GVyeLHi6IK1EWlLEkcbrbZZyR5zl0uH+G2jmmVotWzvgkltFRJDzAMag8581PCZzJfteT1Wui57Di3cDbb+5RiKLA8uYc32/vIhHMUjuo7P1N5nW7p/eKDMqVGdK6RtrWbR1gWhBRNrZA94pqiHAcqaM3UzjRTH7dD0g379+jcCwyFkuf5fyRD8Awlg/3uoAAEZJZPmtbHmisu11CNYTcGR/ObT6q1GeRWoPdVgB7i8JteYT0zL8qQLVa4GgiVMLUD5QmeLkDd31vpMDSE6emtz44p7Ts3Q7SpAP+h2KNrPIqemUFtlV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XwmHZ4nWd3xNRNZurghK5+NTrl83JHOtwV+erP4owA=;
 b=wPigyELzTOlPfy0ykS9W7D2CGDZNVy9nasb4KDJAWP165i9NgaLBnNlPpt4BaNUaj65hIN3YJHzq8NUg050g6ezPhlVe2glOxBNZjeTV4tL5P8i8C9bgF+wAscQ/ZJUXkdpBoeIAlKC9DDgJM0KtcETzIsC5aKdb2erTG3DvBPA=
Received: from CH0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::7)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 19:33:17 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::1e) by CH0P223CA0019.outlook.office365.com
 (2603:10b6:610:116::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:33:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:12 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:11 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 09/17] drm/amd/display: Prepare DSC configuration before BLS
 execution
Date: Fri, 2 Oct 2026 15:32:32 -0400
Message-ID: <20261002193240.3441018-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 7243fcb3-f919-49de-54ae-08df20bc01fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|10063799003|260925021911599003|260925022911599003|260925021311599003|5023799004|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: E8dv0uCr/EADJopBNoX/I8hjfPSJaQ6o9QoMxsxEN9MXOZFKWaOEfRI9GPdUHJF8KyPM+QmBkNVg0LJ+2s7FEHfx0poWKxiRZgaWk5uFQkkq+BqT3p3rPzL/lTSi80gyIPdVN+6j3A3EdIxXXVxxLrqHur/+VR0x2z4SnVvAK2I260vaH7jJxAooPTYp/MvkfSdj4aA2bn/dtUCtIWl7swzEucWeVi3ftZ2n/wxM0rq53OO57ehO2X6ZJ+atJHuxAwSMLEbvzUj9fkETJ7861wGedDh62GnVcpcMHR8/S7feT6ZGKkkKb9uvrrc6l6eNTjy7wklDTzgG9ZGhaRFnMcHTIN4c7nx3qtiO9W4bvJX9IXoX0osvtqPqbqEzcX/Y+TL89w5TJHJONaN6GHCUOwdRPwU/ABlwXObB/gAnl9zdH+2ewkUTfj+RE7wSlpG+h/CMiS46YK8cdhsSRyyObZODd4rYRtVchsIsRHZeZPCcREnP65uCuotb/R1FYhZb4XFaExkw7jvaLF/zspBLSQQI80Y3oRMDBhaTGjOlHyPZf9kSnlxwbwRrpp+Dx9+aJJ99j2YyuTm4hedMUArkpoV90RQTvoOSfTojUWslJ7Cnuxara6ZuG9cDklz7gCKUBDI9BdsvSp2rDb0lINNnU/ytW4PSF7eRI1ut+5e8JLXNcCFzImO44yjyzovBAxMKILmOV1JgBcoU+Hmd41gieA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(10063799003)(260925021911599003)(260925022911599003)(260925021311599003)(5023799004)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X+nd9f94JsWXaO3s4rrYuZ/Ol0/zwX8mtyQZOowLQiIfIKwkvLKu+Fa1r3xKCde2MhTDQ/MEB+UQ2zjXrymARnG6Br68MF+QIQVXsWeNnt5nYALEWcRTxR+pi5+miI1Q/2YT9fos1XIx8YUWJLQ7mc5Kyd/WSEDLQpxjpcNzvT2J/AAS7ghJ2QbOuSQwOMsS66fL7B+stDJ5IV14Wl7FXFLPMjQE2dG6gluFKcz1PNjQf0YMNU6gNKYEqR5DbUbwnclUCKaLQHID8xfqOz4DMFfdSpKgwDaGDBUJCSDbuvq96HLkIjH9qOFQJIREmHx6dJzmSE6pw72X5bYSzul05AqMeSNDNAlYRgHpPk1kJWqw1xfYou9Oa55/MZovH1L/+l7rTpefRjEOK4q82IVhqnvyQkBdCFG+uG1zgBy07ejB3Ut58Z7v6ak6k4+7IZFi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:16.8978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7243fcb3-f919-49de-54ae-08df20bc01fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[Why]
DSC sequence operations calculated configuration during execution and
passed OPTC outputs through pointers into other sequence steps. This
coupled consumers to step storage and mixed calculation with programming.

[How]
Merge the DSC configuration operations into DSC_SET_CONFIG. Prepare
register values in each DSC instance during build and pass OPTC values
by value to timing-generator and stream-encoder operations.

Share stream composition while preserving link-update and ODM padding.
Use the correct DCN401 preparation callback and remove the legacy ops.
Validate local composition inputs and capacity, stop immediate programming
on preparation failure, and publish prepared caches only on success.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  77 +---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 349 ++++++++++++------
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |  48 ++-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h  |  13 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   1 +
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |  34 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |   5 +-
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c  |  41 +-
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  14 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  14 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  14 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  51 +--
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  55 ++-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  15 +-
 16 files changed, 419 insertions(+), 318 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 254c2a9c1b04..ef876a24afc2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4106,21 +4106,14 @@ static void add_update_info_frame_sequence(
 
 static void add_link_update_dsc_config_sequence(
 		struct block_sequence_state *seq_state,
-		struct pipe_ctx *pipe_ctx,
-		struct dsc_config *dsc_cfg,
-		struct dsc_optc_config *dsc_optc_cfg)
+		struct pipe_ctx *pipe_ctx)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	struct dc *dc = stream->ctx->dc;
-	struct dccg *dccg = dc->res_pool->dccg;
 	struct pipe_ctx *top_pipe = pipe_ctx;
-	struct pipe_ctx *odm_pipe = NULL;
-	int opp_cnt = 1;
-	bool should_use_dto_dscclk = false;
-	struct dsc_config dsc_pps_cfg;
+	struct dsc_optc_config dsc_optc_cfg = {};
+	struct dsc_config dsc_pps_cfg = {};
 	uint8_t *dsc_packed_pps = stream->dsc_packed_pps;
-	int last_dsc_set_config_step = 0;
 
 	if (!stream->timing.flags.DSC || !dsc)
 		return;
@@ -4128,60 +4121,13 @@ static void add_link_update_dsc_config_sequence(
 	while (top_pipe->prev_odm_pipe)
 		top_pipe = top_pipe->prev_odm_pipe;
 
-	for (odm_pipe = top_pipe->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-		opp_cnt++;
-
-	memset(dsc_cfg, 0, sizeof(*dsc_cfg));
-	memset(dsc_optc_cfg, 0, sizeof(*dsc_optc_cfg));
-
-	dsc_cfg->pic_width = (stream->timing.h_addressable +
-		top_pipe->dsc_padding_params.dsc_hactive_padding +
-		stream->timing.h_border_left +
-		stream->timing.h_border_right) / opp_cnt;
-	dsc_cfg->pic_height = stream->timing.v_addressable +
-		stream->timing.v_border_top +
-		stream->timing.v_border_bottom;
-	dsc_cfg->pixel_encoding = stream->timing.pixel_encoding;
-	dsc_cfg->color_depth = stream->timing.display_color_depth;
-	dsc_cfg->is_odm = top_pipe->next_odm_pipe ? true : false;
-	dsc_cfg->dc_dsc_cfg = stream->timing.dsc_cfg;
-	ASSERT(dsc_cfg->dc_dsc_cfg.num_slices_h % opp_cnt == 0);
-	dsc_cfg->dc_dsc_cfg.num_slices_h /= opp_cnt;
-	dsc_cfg->dsc_padding = 0;
-
-	if (dccg && dccg->funcs->set_dto_dscclk &&
-			stream->timing.pix_clk_100hz > 480000)
-		should_use_dto_dscclk = true;
-
-	if (should_use_dto_dscclk)
-		hwss_add_dccg_set_dto_dscclk(seq_state, dccg, dsc->inst,
-			dsc_cfg->dc_dsc_cfg.num_slices_h);
-
-	last_dsc_set_config_step = *seq_state->num_steps;
-	hwss_add_dsc_set_config(seq_state, dsc, dsc_cfg, dsc_optc_cfg);
-	hwss_add_dsc_enable_with_opp(seq_state, top_pipe);
-
-	for (odm_pipe = top_pipe->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-		struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
-
-		if (should_use_dto_dscclk)
-			hwss_add_dccg_set_dto_dscclk(seq_state, dccg, odm_dsc->inst,
-				dsc_cfg->dc_dsc_cfg.num_slices_h);
-
-		last_dsc_set_config_step = *seq_state->num_steps;
-		hwss_add_dsc_set_config(seq_state, odm_dsc, dsc_cfg, dsc_optc_cfg);
-		hwss_add_dsc_enable_with_opp(seq_state, odm_pipe);
-	}
+	if (!hwss_add_dsc_sequence_for_stream(seq_state, top_pipe, 0, &dsc_optc_cfg))
+		return;
 
 	if (dc_is_dp_signal(stream->signal) && !dp_is_128b_132b_signal(pipe_ctx))
 		hwss_add_stream_enc_dp_set_dsc_config(seq_state,
-			pipe_ctx->stream_res.stream_enc,
-			&seq_state->steps[last_dsc_set_config_step].params.dsc_set_config_simple_params.dsc_optc_cfg);
-
-	hwss_add_tg_set_dsc_config(seq_state, top_pipe->stream_res.tg,
-		&seq_state->steps[last_dsc_set_config_step].params.dsc_set_config_simple_params.dsc_optc_cfg, true);
+			pipe_ctx->stream_res.stream_enc, &dsc_optc_cfg);
 
-	memset(&dsc_pps_cfg, 0, sizeof(dsc_pps_cfg));
 	dsc_pps_cfg.pic_width = stream->timing.h_addressable +
 		stream->timing.h_border_left + stream->timing.h_border_right;
 	dsc_pps_cfg.pic_height = stream->timing.v_addressable +
@@ -4224,7 +4170,6 @@ static void commit_planes_do_stream_update_sequence(struct dc *dc,
 {
 	int j;
 	struct block_sequence_state seq_state = { .steps = block_sequence, .num_steps = num_steps };
-	unsigned int dsc_cfg_index = 0;
 	*num_steps = 0; // Initialize to 0
 
 	// Stream updates
@@ -4295,15 +4240,7 @@ static void commit_planes_do_stream_update_sequence(struct dc *dc,
 				continue;
 
 			if (stream_update->dsc_config)
-				if (dsc_cfg_index < MAX_PIPES) {
-					struct dsc_config dsc_cfg;
-					struct dsc_optc_config dsc_optc_cfg;
-
-					add_link_update_dsc_config_sequence(&seq_state,
-						pipe_ctx,
-						&dsc_cfg,
-						&dsc_optc_cfg);
-				}
+				add_link_update_dsc_config_sequence(&seq_state, pipe_ctx);
 
 			if (stream_update->mst_bw_update) {
 				if (stream_update->mst_bw_update->is_increase)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 47efe05fe9bb..da98afee558f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1845,9 +1845,6 @@ void hwss_execute_sequence(struct dc *dc,
 		case DSC_READ_STATE:
 			hwss_dsc_read_state(params);
 			break;
-		case DSC_CALCULATE_AND_SET_CONFIG:
-			hwss_dsc_calculate_and_set_config(params);
-			break;
 		case DSC_ENABLE_WITH_OPP:
 			hwss_dsc_enable_with_opp(params);
 			break;
@@ -2158,9 +2155,6 @@ void hwss_execute_sequence(struct dc *dc,
 		case STREAM_ENC_UPDATE_DP_INFO_PACKETS:
 			hwss_stream_enc_update_dp_info_packets(params);
 			break;
-		case DSC_SET_CONFIG_SIMPLE:
-			hwss_dsc_set_config_simple(params);
-			break;
 		case STREAM_ENC_DP_SET_DSC_CONFIG:
 			hwss_stream_enc_dp_set_dsc_config(params);
 			break;
@@ -3287,12 +3281,15 @@ void hwss_dccg_set_dto_dscclk(union block_sequence_params *params)
 
 void hwss_dsc_set_config(union block_sequence_params *params)
 {
-	struct display_stream_compressor *dsc = params->dsc_set_config_params.dsc;
-	struct dsc_config *dsc_cfg = params->dsc_set_config_params.dsc_cfg;
-	struct dsc_optc_config *dsc_optc_cfg = params->dsc_set_config_params.dsc_optc_cfg;
+	struct display_stream_compressor *dsc;
+
+	if (!params)
+		return;
 
-	if (dsc && dsc->funcs->dsc_set_config)
-		dsc->funcs->dsc_set_config(dsc, dsc_cfg, dsc_optc_cfg);
+	dsc = params->dsc_set_config_params.dsc;
+
+	if (dsc && dsc->funcs && dsc->funcs->dsc_set_config)
+		dsc->funcs->dsc_set_config(dsc);
 }
 
 void hwss_dsc_enable(union block_sequence_params *params)
@@ -3306,24 +3303,18 @@ void hwss_dsc_enable(union block_sequence_params *params)
 
 void hwss_tg_set_dsc_config(union block_sequence_params *params)
 {
-	struct timing_generator *tg = params->tg_set_dsc_config_params.tg;
-	enum optc_dsc_mode optc_dsc_mode = OPTC_DSC_DISABLED;
-	uint32_t bytes_per_pixel = 0;
-	uint32_t slice_width = 0;
+	struct timing_generator *tg;
 
-	if (params->tg_set_dsc_config_params.enable) {
-		struct dsc_optc_config *dsc_optc_cfg = params->tg_set_dsc_config_params.dsc_optc_cfg;
+	if (!params)
+		return;
 
-		if (dsc_optc_cfg) {
-			bytes_per_pixel = dsc_optc_cfg->bytes_per_pixel;
-			slice_width = dsc_optc_cfg->slice_width;
-			optc_dsc_mode = dsc_optc_cfg->is_pixel_format_444 ?
-				OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
-		}
-	}
+	tg = params->tg_set_dsc_config_params.tg;
 
-	if (tg && tg->funcs->set_dsc_config)
-		tg->funcs->set_dsc_config(tg, optc_dsc_mode, bytes_per_pixel, slice_width);
+	if (tg && tg->funcs && tg->funcs->set_dsc_config)
+		tg->funcs->set_dsc_config(tg,
+			params->tg_set_dsc_config_params.dsc_mode,
+			params->tg_set_dsc_config_params.bytes_per_pixel,
+			params->tg_set_dsc_config_params.slice_width);
 }
 
 void hwss_dsc_disconnect(union block_sequence_params *params)
@@ -3343,41 +3334,6 @@ void hwss_dsc_read_state(union block_sequence_params *params)
 		dsc->funcs->dsc_read_state(dsc, dsc_state);
 }
 
-void hwss_dsc_calculate_and_set_config(union block_sequence_params *params)
-{
-	struct pipe_ctx *pipe_ctx = params->dsc_calculate_and_set_config_params.pipe_ctx;
-	struct pipe_ctx *top_pipe = pipe_ctx;
-	bool enable = params->dsc_calculate_and_set_config_params.enable;
-	int opp_cnt = params->dsc_calculate_and_set_config_params.opp_cnt;
-
-	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
-	struct dc_stream_state *stream = pipe_ctx->stream;
-
-	if (!dsc || !enable)
-		return;
-
-	/* Calculate DSC configuration - extracted from dcn32_update_dsc_on_stream */
-	struct dsc_config dsc_cfg;
-
-	while (top_pipe->prev_odm_pipe)
-		top_pipe = top_pipe->prev_odm_pipe;
-
-	dsc_cfg.pic_width = (stream->timing.h_addressable + top_pipe->dsc_padding_params.dsc_hactive_padding +
-			stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
-	dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
-	dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
-	dsc_cfg.color_depth = stream->timing.display_color_depth;
-	dsc_cfg.is_odm = top_pipe->next_odm_pipe ? true : false;
-	dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
-	dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-	dsc_cfg.dsc_padding = top_pipe->dsc_padding_params.dsc_hactive_padding;
-
-	/* Set DSC configuration */
-	if (dsc->funcs->dsc_set_config)
-		dsc->funcs->dsc_set_config(dsc, &dsc_cfg,
-			&params->dsc_calculate_and_set_config_params.dsc_optc_cfg);
-}
-
 void hwss_dsc_enable_with_opp(union block_sequence_params *params)
 {
 	struct display_stream_compressor *dsc = params->dsc_enable_with_opp_params.dsc;
@@ -4474,24 +4430,18 @@ void hwss_stream_enc_update_dp_info_packets(union block_sequence_params *params)
 
 void hwss_stream_enc_dp_set_dsc_config(union block_sequence_params *params)
 {
-	if (params->stream_enc_dp_set_dsc_config_params.stream_enc &&
-	    params->stream_enc_dp_set_dsc_config_params.stream_enc->funcs->dp_set_dsc_config) {
-		enum optc_dsc_mode dsc_mode = OPTC_DSC_DISABLED;
-		uint32_t dsc_bytes_per_pixel = 0;
-		uint32_t dsc_slice_width = 0;
-		const struct dsc_optc_config *dsc_optc_cfg = params->stream_enc_dp_set_dsc_config_params.dsc_optc_cfg;
+	struct stream_encoder *stream_enc;
 
-		if (dsc_optc_cfg) {
-			dsc_mode = dsc_optc_cfg->is_pixel_format_444 ?
-				OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
-			dsc_bytes_per_pixel = dsc_optc_cfg->bytes_per_pixel;
-			dsc_slice_width = dsc_optc_cfg->slice_width;
-		}
+	if (!params)
+		return;
 
-		params->stream_enc_dp_set_dsc_config_params.stream_enc->funcs->dp_set_dsc_config(
-			params->stream_enc_dp_set_dsc_config_params.stream_enc,
-			dsc_mode, dsc_bytes_per_pixel, dsc_slice_width);
-	}
+	stream_enc = params->stream_enc_dp_set_dsc_config_params.stream_enc;
+
+	if (stream_enc && stream_enc->funcs && stream_enc->funcs->dp_set_dsc_config)
+		stream_enc->funcs->dp_set_dsc_config(stream_enc,
+			params->stream_enc_dp_set_dsc_config_params.dsc_mode,
+			params->stream_enc_dp_set_dsc_config_params.bytes_per_pixel,
+			params->stream_enc_dp_set_dsc_config_params.slice_width);
 }
 
 void hwss_hpo_dp_stream_enc_dp_set_dsc_pps_info_packet(union block_sequence_params *params)
@@ -4640,16 +4590,6 @@ void hwss_link_set_dpms_on(union block_sequence_params *params)
 		pipe_ctx->stream->link->dc->link_srv->set_dpms_on(state, pipe_ctx);
 }
 
-void hwss_dsc_set_config_simple(union block_sequence_params *params)
-{
-	struct display_stream_compressor *dsc = params->dsc_set_config_simple_params.dsc;
-	struct dsc_config *dsc_cfg = &params->dsc_set_config_simple_params.dsc_cfg;
-	struct dsc_optc_config *dsc_optc_cfg = &params->dsc_set_config_simple_params.dsc_optc_cfg;
-
-	if (dsc && dsc->funcs && dsc->funcs->dsc_set_config)
-		dsc->funcs->dsc_set_config(dsc, dsc_cfg, dsc_optc_cfg);
-}
-
 /*
  * Clock manager executor functions
  */
@@ -4726,16 +4666,57 @@ void hwss_add_dccg_set_dto_dscclk(struct block_sequence_state *seq_state,
 	}
 }
 
-void hwss_add_dsc_calculate_and_set_config(struct block_sequence_state *seq_state,
-		struct pipe_ctx *pipe_ctx, bool enable, int opp_cnt)
+bool hwss_prepare_dsc_config_for_pipe(
+		struct pipe_ctx *pipe_ctx, int opp_cnt, uint32_t dsc_padding,
+		struct dsc_optc_config *dsc_optc_cfg)
 {
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = DSC_CALCULATE_AND_SET_CONFIG;
-		seq_state->steps[*seq_state->num_steps].params.dsc_calculate_and_set_config_params.pipe_ctx = pipe_ctx;
-		seq_state->steps[*seq_state->num_steps].params.dsc_calculate_and_set_config_params.enable = enable;
-		seq_state->steps[*seq_state->num_steps].params.dsc_calculate_and_set_config_params.opp_cnt = opp_cnt;
-		(*seq_state->num_steps)++;
-	}
+	struct dsc_config dsc_cfg = {};
+	struct dsc_optc_config optc = {};
+	struct display_stream_compressor *dsc;
+	struct pipe_ctx *top_pipe = pipe_ctx;
+	struct dc_stream_state *stream;
+	bool is_config_ok;
+
+	if (dsc_optc_cfg)
+		memset(dsc_optc_cfg, 0, sizeof(*dsc_optc_cfg));
+
+	if (!pipe_ctx || !pipe_ctx->stream || !pipe_ctx->stream_res.dsc ||
+			opp_cnt <= 0 || opp_cnt > MAX_PIPES)
+		return false;
+
+	dsc = pipe_ctx->stream_res.dsc;
+
+	if (!dsc->funcs || !dsc->funcs->dsc_prepare_config || !dsc->funcs->dsc_set_config)
+		return false;
+
+	stream = pipe_ctx->stream;
+
+	if (!stream->timing.dsc_cfg.num_slices_h ||
+			stream->timing.dsc_cfg.num_slices_h % opp_cnt)
+		return false;
+
+	while (top_pipe->prev_odm_pipe)
+		top_pipe = top_pipe->prev_odm_pipe;
+
+	dsc_cfg.pic_width =
+		(stream->timing.h_addressable + top_pipe->dsc_padding_params.dsc_hactive_padding +
+		 stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
+	dsc_cfg.pic_height = stream->timing.v_addressable +
+		stream->timing.v_border_top + stream->timing.v_border_bottom;
+	dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
+	dsc_cfg.color_depth = stream->timing.display_color_depth;
+	dsc_cfg.is_odm = top_pipe->next_odm_pipe ? true : false;
+	dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
+	dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
+	dsc_cfg.dsc_padding = dsc_padding;
+
+	is_config_ok = dsc->funcs->dsc_prepare_config(dsc, &dsc_cfg, &optc);
+	ASSERT(is_config_ok);
+	if (!is_config_ok)
+		return false;
+	if (dsc_optc_cfg)
+		*dsc_optc_cfg = optc;
+	return true;
 }
 
 void hwss_add_mpc_remove_mpcc(struct block_sequence_state *seq_state,
@@ -4777,13 +4758,28 @@ void hwss_add_dsc_enable_with_opp(struct block_sequence_state *seq_state,
 }
 
 void hwss_add_tg_set_dsc_config(struct block_sequence_state *seq_state,
-		struct timing_generator *tg, struct dsc_optc_config *dsc_optc_cfg, bool enable)
+		struct timing_generator *tg, const struct dsc_optc_config *dsc_optc_cfg, bool enable)
 {
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+			!tg || !tg->funcs || !tg->funcs->set_dsc_config || (enable && !dsc_optc_cfg))
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		struct tg_set_dsc_config_params *p =
+			&seq_state->steps[*seq_state->num_steps].params.tg_set_dsc_config_params;
+
 		seq_state->steps[*seq_state->num_steps].func = TG_SET_DSC_CONFIG;
-		seq_state->steps[*seq_state->num_steps].params.tg_set_dsc_config_params.tg = tg;
-		seq_state->steps[*seq_state->num_steps].params.tg_set_dsc_config_params.dsc_optc_cfg = dsc_optc_cfg;
-		seq_state->steps[*seq_state->num_steps].params.tg_set_dsc_config_params.enable = enable;
+		p->tg = tg;
+		p->dsc_mode = OPTC_DSC_DISABLED;
+		p->bytes_per_pixel = 0;
+		p->slice_width = 0;
+
+		if (enable && dsc_optc_cfg) {
+			p->dsc_mode = dsc_optc_cfg->is_pixel_format_444 ?
+				OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
+			p->bytes_per_pixel = dsc_optc_cfg->bytes_per_pixel;
+			p->slice_width = dsc_optc_cfg->slice_width;
+		}
 		(*seq_state->num_steps)++;
 	}
 }
@@ -6106,28 +6102,157 @@ void hwss_add_stream_enc_update_dp_info_packets(struct block_sequence_state *seq
 	}
 }
 
-void hwss_add_dsc_set_config(struct block_sequence_state *seq_state,
-		struct display_stream_compressor *dsc,
-		const struct dsc_config *dsc_cfg,
-		const struct dsc_optc_config *dsc_optc_cfg)
+bool hwss_add_dsc_set_config(struct block_sequence_state *seq_state,
+		struct display_stream_compressor *dsc)
 {
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = DSC_SET_CONFIG_SIMPLE;
-		seq_state->steps[*seq_state->num_steps].params.dsc_set_config_simple_params.dsc = dsc;
-		seq_state->steps[*seq_state->num_steps].params.dsc_set_config_simple_params.dsc_cfg = *dsc_cfg;
-		seq_state->steps[*seq_state->num_steps].params.dsc_set_config_simple_params.dsc_optc_cfg = *dsc_optc_cfg;
-		(*seq_state->num_steps)++;
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+			*seq_state->num_steps >= MAX_HWSS_BLOCK_SEQUENCE_SIZE ||
+			!dsc || !dsc->funcs || !dsc->funcs->dsc_set_config)
+		return false;
+	seq_state->steps[*seq_state->num_steps].func = DSC_SET_CONFIG;
+	seq_state->steps[*seq_state->num_steps].params.dsc_set_config_params.dsc = dsc;
+	(*seq_state->num_steps)++;
+	return true;
+}
+
+bool hwss_add_dsc_sequence_for_pipe(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx, int opp_cnt, uint32_t dsc_padding,
+		struct dsc_optc_config *dsc_optc_cfg)
+{
+	if (dsc_optc_cfg)
+		memset(dsc_optc_cfg, 0, sizeof(*dsc_optc_cfg));
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+			*seq_state->num_steps > MAX_HWSS_BLOCK_SEQUENCE_SIZE - 2 ||
+			!pipe_ctx || !pipe_ctx->stream_res.opp || !pipe_ctx->stream_res.dsc ||
+			!pipe_ctx->stream_res.dsc->funcs || !pipe_ctx->stream_res.dsc->funcs->dsc_enable)
+		return false;
+
+	if (!hwss_prepare_dsc_config_for_pipe(pipe_ctx, opp_cnt, dsc_padding, dsc_optc_cfg))
+		return false;
+
+	if (!hwss_add_dsc_set_config(seq_state, pipe_ctx->stream_res.dsc))
+		return false;
+
+	hwss_add_dsc_enable_with_opp(seq_state, pipe_ctx);
+	return true;
+}
+
+bool hwss_add_dsc_sequence_for_stream(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx, uint32_t dsc_padding,
+		struct dsc_optc_config *dsc_optc_cfg)
+{
+	struct pipe_ctx *top_pipe = pipe_ctx;
+	struct pipe_ctx *odm_pipe;
+	struct dc_stream_state *stream;
+	struct display_stream_compressor *dsc;
+	struct dccg *dccg = NULL;
+	struct dsc_optc_config optc = {};
+	int opp_cnt = 0;
+	int num_slices_h;
+	unsigned int initial_steps;
+	unsigned int required_steps;
+	bool should_use_dto_dscclk = false;
+
+	if (dsc_optc_cfg)
+		memset(dsc_optc_cfg, 0, sizeof(*dsc_optc_cfg));
+
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps || !top_pipe ||
+			*seq_state->num_steps > MAX_HWSS_BLOCK_SEQUENCE_SIZE)
+		return false;
+
+	while (top_pipe->prev_odm_pipe)
+		top_pipe = top_pipe->prev_odm_pipe;
+
+	if (!top_pipe->stream || !top_pipe->stream->timing.flags.DSC ||
+			!top_pipe->stream_res.tg || !top_pipe->stream_res.tg->funcs ||
+			!top_pipe->stream_res.tg->funcs->set_dsc_config)
+		return false;
+
+	dsc = top_pipe->stream_res.dsc;
+	stream = top_pipe->stream;
+
+	if (stream->ctx && stream->ctx->dc && stream->ctx->dc->res_pool)
+		dccg = stream->ctx->dc->res_pool->dccg;
+
+	for (odm_pipe = top_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+		struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
+
+		if (++opp_cnt > MAX_PIPES || odm_pipe->stream != stream ||
+				!odm_pipe->stream_res.opp || !odm_dsc || !odm_dsc->funcs ||
+				!odm_dsc->funcs->dsc_prepare_config || !odm_dsc->funcs->dsc_set_config ||
+				!odm_dsc->funcs->dsc_enable)
+			return false;
 	}
+
+	if (!stream->timing.dsc_cfg.num_slices_h || stream->timing.dsc_cfg.num_slices_h % opp_cnt)
+		return false;
+	num_slices_h = stream->timing.dsc_cfg.num_slices_h / opp_cnt;
+
+	if (dccg && dccg->funcs && dccg->funcs->set_dto_dscclk &&
+			stream->timing.pix_clk_100hz > 480000)
+		should_use_dto_dscclk = true;
+
+	initial_steps = *seq_state->num_steps;
+	required_steps = opp_cnt * (should_use_dto_dscclk ? 3 : 2) + 1;
+	if (required_steps > MAX_HWSS_BLOCK_SEQUENCE_SIZE - initial_steps)
+		return false;
+
+	/* Step 1: Set DTO DSCCLK for master DSC if needed */
+	if (should_use_dto_dscclk)
+		hwss_add_dccg_set_dto_dscclk(seq_state, dccg, dsc->inst, num_slices_h);
+
+	/* Step 2: Configure and enable master DSC + OPP */
+	if (!hwss_add_dsc_sequence_for_pipe(seq_state, top_pipe, opp_cnt, dsc_padding, &optc))
+		goto fail;
+
+	/* Step 3: Configure and enable ODM DSC blocks + OPP */
+	for (odm_pipe = top_pipe->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+		struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
+
+		if (should_use_dto_dscclk)
+			hwss_add_dccg_set_dto_dscclk(seq_state, dccg, odm_dsc->inst, num_slices_h);
+
+		if (!hwss_add_dsc_sequence_for_pipe(seq_state, odm_pipe, opp_cnt, dsc_padding, NULL))
+			goto fail;
+	}
+
+	/* Step 4: Configure DSC in timing generator (OPTC) */
+	hwss_add_tg_set_dsc_config(seq_state, top_pipe->stream_res.tg, &optc, true);
+
+	if (dsc_optc_cfg)
+		*dsc_optc_cfg = optc;
+
+	return true;
+
+fail:
+	*seq_state->num_steps = initial_steps;
+	return false;
 }
 
 void hwss_add_stream_enc_dp_set_dsc_config(struct block_sequence_state *seq_state,
 		struct stream_encoder *stream_enc,
 		const struct dsc_optc_config *dsc_optc_cfg)
 {
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+			!stream_enc || !stream_enc->funcs || !stream_enc->funcs->dp_set_dsc_config)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		struct stream_enc_dp_set_dsc_config_params *p =
+			&seq_state->steps[*seq_state->num_steps].params.stream_enc_dp_set_dsc_config_params;
+
 		seq_state->steps[*seq_state->num_steps].func = STREAM_ENC_DP_SET_DSC_CONFIG;
-		seq_state->steps[*seq_state->num_steps].params.stream_enc_dp_set_dsc_config_params.stream_enc = stream_enc;
-		seq_state->steps[*seq_state->num_steps].params.stream_enc_dp_set_dsc_config_params.dsc_optc_cfg = dsc_optc_cfg;
+		p->stream_enc = stream_enc;
+		p->dsc_mode = OPTC_DSC_DISABLED;
+		p->bytes_per_pixel = 0;
+		p->slice_width = 0;
+
+		if (dsc_optc_cfg) {
+			p->dsc_mode = dsc_optc_cfg->is_pixel_format_444 ?
+				OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
+			p->bytes_per_pixel = dsc_optc_cfg->bytes_per_pixel;
+			p->slice_width = dsc_optc_cfg->slice_width;
+		}
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index cede9588bad8..9c90cceee136 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -30,13 +30,14 @@
 #include "dsc/dscc_types.h"
 #include "dsc/rc_calc.h"
 
-static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc_reg_values *reg_vals);
+static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc20_reg_values *reg_vals);
 
 static const struct dsc_funcs dcn20_dsc_funcs = {
 	.dsc_get_enc_caps = dsc2_get_enc_caps,
 	.dsc_read_state = dsc2_read_state,
 	.dsc_read_reg_state = dsc2_read_reg_state,
 	.dsc_validate_stream = dsc2_validate_stream,
+	.dsc_prepare_config = dsc2_prepare_config,
 	.dsc_set_config = dsc2_set_config,
 	.dsc_get_packed_pps = dsc2_get_packed_pps,
 	.dsc_enable = dsc2_enable,
@@ -188,26 +189,41 @@ void dsc_config_log(struct display_stream_compressor *dsc, const struct dsc_conf
 	DC_LOG_DSC("\tcolor_depth %d", config->color_depth);
 }
 
-void dsc2_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+bool dsc2_prepare_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 		struct dsc_optc_config *dsc_optc_cfg)
 {
-	bool is_config_ok;
-	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
+	struct dcn20_dsc *dsc20;
+	struct dsc20_reg_values reg_vals = {};
+	struct dsc_optc_config optc = {};
 
-	DC_LOG_DSC("Setting DSC Config at DSC inst %d", dsc->inst);
-	dsc_config_log(dsc, dsc_cfg);
-	is_config_ok = dsc_prepare_config(dsc_cfg, &dsc20->reg_vals, dsc_optc_cfg);
-	ASSERT(is_config_ok);
+	if (!dsc || !dsc_cfg || !dsc_optc_cfg)
+		return false;
+
+	dsc20 = TO_DCN20_DSC(dsc);
+	if (!dsc_prepare_config(dsc_cfg, &reg_vals, &optc))
+		return false;
+	dsc20->reg_vals = reg_vals;
+	*dsc_optc_cfg = optc;
+	return true;
+}
+
+void dsc2_set_config(struct display_stream_compressor *dsc)
+{
+	struct dcn20_dsc *dsc20;
+
+	if (!dsc)
+		return;
+
+	dsc20 = TO_DCN20_DSC(dsc);
 	DC_LOG_DSC("programming DSC Picture Parameter Set (PPS):");
 	dsc_log_pps(dsc, &dsc20->reg_vals.pps);
 	dsc_write_to_registers(dsc, &dsc20->reg_vals);
 }
 
-
 bool dsc2_get_packed_pps(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg, uint8_t *dsc_packed_pps)
 {
 	bool is_config_ok;
-	struct dsc_reg_values dsc_reg_vals;
+	struct dsc20_reg_values dsc_reg_vals;
 	struct dsc_optc_config dsc_optc_cfg;
 
 	memset(&dsc_reg_vals, 0, sizeof(dsc_reg_vals));
@@ -368,7 +384,7 @@ void dsc_override_rc_params(struct rc_params *rc, const struct dc_dsc_rc_params_
 	rc->flatness_det_thresh = override->flatness_det_thresh;
 }
 
-bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values *dsc_reg_vals,
+bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc20_reg_values *dsc_reg_vals,
 			struct dsc_optc_config *dsc_optc_cfg)
 {
 	struct dsc_parameters dsc_params;
@@ -515,11 +531,11 @@ enum dsc_bits_per_comp dsc_dc_color_depth_to_dsc_bits_per_comp(enum dc_color_dep
 }
 
 
-void dsc_init_reg_values(struct dsc_reg_values *reg_vals)
+void dsc_init_reg_values(struct dsc20_reg_values *reg_vals)
 {
 	int i;
 
-	memset(reg_vals, 0, sizeof(struct dsc_reg_values));
+	memset(reg_vals, 0, sizeof(struct dsc20_reg_values));
 
 	/* Non-PPS values */
 	reg_vals->dsc_clock_enable            = 1;
@@ -567,11 +583,11 @@ void dsc_init_reg_values(struct dsc_reg_values *reg_vals)
 	reg_vals->pps.rc_tgt_offset_high          = 3;
 }
 
-/* Updates dsc_reg_values::reg_vals::xxx fields based on the values from computed params.
+/* Updates dsc20_reg_values::reg_vals::xxx fields based on the values from computed params.
  * This is required because dscc_compute_dsc_parameters returns a modified PPS, which in turn
  * affects non-PPS register values.
  */
-void dsc_update_from_dsc_parameters(struct dsc_reg_values *reg_vals, const struct dsc_parameters *dsc_params)
+void dsc_update_from_dsc_parameters(struct dsc20_reg_values *reg_vals, const struct dsc_parameters *dsc_params)
 {
 	int i;
 
@@ -584,7 +600,7 @@ void dsc_update_from_dsc_parameters(struct dsc_reg_values *reg_vals, const struc
 	reg_vals->rc_buffer_model_size = dsc_params->rc_buffer_model_size;
 }
 
-static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc_reg_values *reg_vals)
+static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc20_reg_values *reg_vals)
 {
 	uint32_t temp_int;
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
index 2337c3a97235..28fa02b0d6ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
@@ -536,7 +536,7 @@ enum dsc_pixel_format {
 	DSC_PIXFMT_UNKNOWN
 };
 
-struct dsc_reg_values {
+struct dsc20_reg_values {
 	/* PPS registers */
 	struct drm_dsc_config pps;
 
@@ -564,7 +564,7 @@ struct dcn20_dsc {
 	const struct dcn20_dsc_shift *dsc_shift;
 	const struct dcn20_dsc_mask *dsc_mask;
 
-	struct dsc_reg_values reg_vals;
+	struct dsc20_reg_values reg_vals;
 
 	int max_image_width;
 };
@@ -579,7 +579,7 @@ void dsc_override_rc_params(struct rc_params *rc,
 		const struct dc_dsc_rc_params_override *override);
 
 bool dsc_prepare_config(const struct dsc_config *dsc_cfg,
-		struct dsc_reg_values *dsc_reg_vals,
+		struct dsc20_reg_values *dsc_reg_vals,
 		struct dsc_optc_config *dsc_optc_cfg);
 
 enum dsc_pixel_format dsc_dc_pixel_encoding_to_dsc_pixel_format(enum dc_pixel_encoding dc_pix_enc,
@@ -587,9 +587,9 @@ enum dsc_pixel_format dsc_dc_pixel_encoding_to_dsc_pixel_format(enum dc_pixel_en
 
 enum dsc_bits_per_comp dsc_dc_color_depth_to_dsc_bits_per_comp(enum dc_color_depth dc_color_depth);
 
-void dsc_init_reg_values(struct dsc_reg_values *reg_vals);
+void dsc_init_reg_values(struct dsc20_reg_values *reg_vals);
 
-void dsc_update_from_dsc_parameters(struct dsc_reg_values *reg_vals, const struct dsc_parameters *dsc_params);
+void dsc_update_from_dsc_parameters(struct dsc20_reg_values *reg_vals, const struct dsc_parameters *dsc_params);
 
 void dsc2_construct(struct dcn20_dsc *dsc,
 		struct dc_context *ctx,
@@ -608,8 +608,9 @@ bool dsc2_get_packed_pps(struct display_stream_compressor *dsc,
 void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s);
 void dsc2_read_reg_state(struct display_stream_compressor *dsc, struct dcn_dsc_reg_state *dccg_reg_state);
 bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg);
-void dsc2_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+bool dsc2_prepare_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 		struct dsc_optc_config *dsc_optc_cfg);
+void dsc2_set_config(struct display_stream_compressor *dsc);
 void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe);
 void dsc2_disable(struct display_stream_compressor *dsc);
 void dsc2_disconnect(struct display_stream_compressor *dsc);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
index d84c3399d386..fa0851b528d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
@@ -34,6 +34,7 @@ static const struct dsc_funcs dcn35_dsc_funcs = {
 	.dsc_read_state = dsc2_read_state,
 	.dsc_read_reg_state = dsc2_read_reg_state,
 	.dsc_validate_stream = dsc2_validate_stream,
+	.dsc_prepare_config = dsc2_prepare_config,
 	.dsc_set_config = dsc2_set_config,
 	.dsc_get_packed_pps = dsc2_get_packed_pps,
 	.dsc_enable = dsc35_enable,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index 749547960046..bd5467594803 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -9,7 +9,7 @@
 #include "dsc/dscc_types.h"
 #include "dsc/rc_calc.h"
 
-static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc_reg_values *reg_vals);
+static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc20_reg_values *reg_vals);
 
 /* Object I/F functions */
 //static void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz);
@@ -19,6 +19,7 @@ static void dsc401_get_single_enc_caps(struct dsc_enc_caps *dsc_enc_caps, unsign
 static const struct dsc_funcs dcn401_dsc_funcs = {
 	.dsc_read_state = dsc401_read_state,
 	.dsc_validate_stream = dsc401_validate_stream,
+	.dsc_prepare_config = dsc401_prepare_config,
 	.dsc_set_config = dsc401_set_config,
 	.dsc_get_packed_pps = dsc2_get_packed_pps,
 	.dsc_enable = dsc401_enable,
@@ -127,16 +128,31 @@ bool dsc401_validate_stream(struct display_stream_compressor *dsc, const struct
 	return dsc_prepare_config(dsc_cfg, &dsc401->reg_vals, &dsc_optc_cfg);
 }
 
-void dsc401_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+bool dsc401_prepare_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 		struct dsc_optc_config *dsc_optc_cfg)
 {
-	bool is_config_ok;
-	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
+	struct dcn401_dsc *dsc401;
+	struct dsc20_reg_values reg_vals = {};
+	struct dsc_optc_config optc = {};
+
+	if (!dsc || !dsc_cfg || !dsc_optc_cfg)
+		return false;
+
+	dsc401 = TO_DCN401_DSC(dsc);
+	if (!dsc_prepare_config(dsc_cfg, &reg_vals, &optc))
+		return false;
+	dsc401->reg_vals = reg_vals;
+	*dsc_optc_cfg = optc;
+	return true;
+}
+
+void dsc401_set_config(struct display_stream_compressor *dsc)
+{
+	struct dcn401_dsc *dsc401;
 
-	DC_LOG_DSC("Setting DSC Config at DSC inst %d", dsc->inst);
-	dsc_config_log(dsc, dsc_cfg);
-	is_config_ok = dsc_prepare_config(dsc_cfg, &dsc401->reg_vals, dsc_optc_cfg);
-	ASSERT(is_config_ok);
+	if (!dsc)
+		return;
+	dsc401 = TO_DCN401_DSC(dsc);
 	DC_LOG_DSC("programming DSC Picture Parameter Set (PPS):");
 	dsc_log_pps(dsc, &dsc401->reg_vals.pps);
 	dsc_write_to_registers(dsc, &dsc401->reg_vals);
@@ -203,7 +219,7 @@ void dsc401_disconnect(struct display_stream_compressor *dsc)
 		DSCRM_DSC_FORWARD_EN, 0);
 }
 
-static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc_reg_values *reg_vals)
+static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc20_reg_values *reg_vals)
 {
 	uint32_t temp_int;
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
index 7acd57eb4f42..d1c51454d5b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
@@ -320,7 +320,7 @@ struct dcn401_dsc {
 	const struct dcn401_dsc_shift *dsc_shift;
 	const struct dcn401_dsc_mask *dsc_mask;
 
-	struct dsc_reg_values reg_vals;
+	struct dsc20_reg_values reg_vals;
 
 	int max_image_width;
 };
@@ -336,8 +336,9 @@ void dsc401_set_fgcg(struct dcn401_dsc *dsc401, bool enable);
 
 void dsc401_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s);
 bool dsc401_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg);
-void dsc401_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+bool dsc401_prepare_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 		struct dsc_optc_config *dsc_optc_cfg);
+void dsc401_set_config(struct display_stream_compressor *dsc);
 void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe);
 void dsc401_disable(struct display_stream_compressor *dsc);
 void dsc401_disconnect(struct display_stream_compressor *dsc);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
index 5bb4ed1d1ba7..91ec525b11d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
@@ -12,6 +12,7 @@
 static const struct dsc_funcs dcn60_dsc_funcs = {
 	.dsc_read_state = dsc401_read_state,
 	.dsc_validate_stream = dsc401_validate_stream,
+	.dsc_prepare_config = dsc60_prepare_config,
 	.dsc_set_config = dsc60_set_config,
 	.dsc_get_packed_pps = dsc2_get_packed_pps,
 	.dsc_enable = dsc401_enable,
@@ -115,10 +116,10 @@ static void dsc60_init_reg_values(struct dsc60_reg_values *reg_vals)
 	reg_vals->pps.rc_tgt_offset_high = 3;
 }
 
-/*Updates dsc_reg_values::reg_vals::xxx fields based on the values from computed params.
-* This is required because dscc_compute_dsc_parameters returns a modified PPS, which in turn
-* affects non - PPS register values.
-*/
+/* Updates dsc60_reg_values::reg_vals::xxx fields based on the values from computed params.
+ * This is required because dscc_compute_dsc_parameters returns a modified PPS, which in turn
+ * affects non-PPS register values.
+ */
 static void dsc60_update_from_dsc_parameters(struct dsc60_reg_values *reg_vals, const struct dsc_parameters *dsc_params)
 {
 	int i;
@@ -132,7 +133,7 @@ static void dsc60_update_from_dsc_parameters(struct dsc60_reg_values *reg_vals,
 	reg_vals->rc_buffer_model_size = dsc_params->rc_buffer_model_size;
 }
 
-static bool dsc60_prepare_config(const struct dsc_config *dsc_cfg, struct dsc60_reg_values *dsc_reg_vals,
+static bool dsc60_prepare_config_internal(const struct dsc_config *dsc_cfg, struct dsc60_reg_values *dsc_reg_vals,
 	struct dsc_optc_config *dsc_optc_cfg)
 {
 	struct dsc_parameters dsc_params;
@@ -403,16 +404,32 @@ static void dsc60_write_to_registers(struct display_stream_compressor *dsc, cons
 
 }
 
-void dsc60_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+bool dsc60_prepare_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 	struct dsc_optc_config *dsc_optc_cfg)
 {
-	bool is_config_ok;
-	struct dcn60_dsc *dsc60 = TO_DCN60_DSC(dsc);
+	struct dcn60_dsc *dsc60;
+	struct dsc60_reg_values reg_vals = {};
+	struct dsc_optc_config optc = {};
+
+	if (!dsc || !dsc_cfg || !dsc_optc_cfg)
+		return false;
+
+	dsc60 = TO_DCN60_DSC(dsc);
+	if (!dsc60_prepare_config_internal(dsc_cfg, &reg_vals, &optc))
+		return false;
+	dsc60->reg_vals = reg_vals;
+	*dsc_optc_cfg = optc;
+	return true;
+}
+
+void dsc60_set_config(struct display_stream_compressor *dsc)
+{
+	struct dcn60_dsc *dsc60;
+
+	if (!dsc)
+		return;
 
-	DC_LOG_DSC("Setting DSC Config at DSC inst %d", dsc->inst);
-	dsc_config_log(dsc, dsc_cfg);
-	is_config_ok = dsc60_prepare_config(dsc_cfg, &dsc60->reg_vals, dsc_optc_cfg);
-	ASSERT(is_config_ok);
+	dsc60 = TO_DCN60_DSC(dsc);
 	DC_LOG_DSC("programming DSC Picture Parameter Set (PPS):");
 	dsc_log_pps(dsc, &dsc60->reg_vals.pps);
 	dsc60_write_to_registers(dsc, &dsc60->reg_vals);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h
index b7f2d8031121..a1a3a139cd3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h
@@ -239,8 +239,9 @@ void dsc60_construct(struct dcn60_dsc *dsc,
 	const struct dcn60_dsc_mask *dsc_mask);
 
 void dsc60_set_fgcg(struct display_stream_compressor *dsc, bool enable);
-void dsc60_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+bool dsc60_prepare_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 	struct dsc_optc_config *dsc_optc_cfg);
+void dsc60_set_config(struct display_stream_compressor *dsc);
 
 void dsc60_get_single_enc_caps(struct dsc_enc_caps *dsc_enc_caps, unsigned int max_dscclk_khz);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
index ab37a7eaaf01..cb7b0b1d8686 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
@@ -116,8 +116,9 @@ struct dsc_funcs {
 	void (*dsc_read_state)(struct display_stream_compressor *dsc, struct dcn_dsc_state *s);
 	void (*dsc_read_reg_state)(struct display_stream_compressor *dsc, struct dcn_dsc_reg_state *dccg_reg_state);
 	bool (*dsc_validate_stream)(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg);
-	void (*dsc_set_config)(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
+	bool (*dsc_prepare_config)(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 			struct dsc_optc_config *dsc_optc_cfg);
+	void (*dsc_set_config)(struct display_stream_compressor *dsc);
 	bool (*dsc_get_packed_pps)(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 			uint8_t *dsc_packed_pps);
 	void (*dsc_enable)(struct display_stream_compressor *dsc, int opp_pipe);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 56d41c6fa3ee..93d8483d6f80 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -110,13 +110,23 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
 		dsc_cfg.dsc_padding = 0;
 
-		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
+		if (!dsc->funcs->dsc_prepare_config(dsc, &dsc_cfg, &dsc_optc_cfg)) {
+			ASSERT(false);
+			return;
+		}
+		dsc->funcs->dsc_set_config(dsc);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
 			ASSERT(odm_dsc);
-			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
+			if (!odm_dsc)
+				return;
+			if (!odm_dsc->funcs->dsc_prepare_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg)) {
+				ASSERT(false);
+				return;
+			}
+			odm_dsc->funcs->dsc_set_config(odm_dsc);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
 		}
 		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 10361f3b6122..e7bf865755d4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1103,17 +1103,25 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 		if (should_use_dto_dscclk)
 			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
-		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
+		if (!dsc->funcs->dsc_prepare_config(dsc, &dsc_cfg, &dsc_optc_cfg)) {
+			ASSERT(false);
+			return;
+		}
+		dsc->funcs->dsc_set_config(dsc);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
 			ASSERT(odm_dsc);
 			if (!odm_dsc)
-				continue;
+				return;
 			if (should_use_dto_dscclk)
 				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
-			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
+			if (!odm_dsc->funcs->dsc_prepare_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg)) {
+				ASSERT(false);
+				return;
+			}
+			odm_dsc->funcs->dsc_set_config(odm_dsc);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
 		}
 		optc_dsc_mode = dsc_optc_cfg.is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index f2bf7d1ca4f7..23c09801f12f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -369,13 +369,23 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
 		dsc_cfg.dsc_padding = 0;
 
-		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
+		if (!dsc->funcs->dsc_prepare_config(dsc, &dsc_cfg, &dsc_optc_cfg)) {
+			ASSERT(false);
+			return;
+		}
+		dsc->funcs->dsc_set_config(dsc);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
 			ASSERT(odm_dsc);
-			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
+			if (!odm_dsc)
+				return;
+			if (!odm_dsc->funcs->dsc_prepare_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg)) {
+				ASSERT(false);
+				return;
+			}
+			odm_dsc->funcs->dsc_set_config(odm_dsc);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
 		}
 		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 379902bdef0a..0abdfc55290c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1779,54 +1779,11 @@ static void dcn401_add_dsc_sequence_for_odm_change(struct dc *dc, struct dc_stat
 
 	/* Process new DSC configuration if DSC is enabled */
 	if (otg_master->stream_res.dsc && otg_master->stream->timing.flags.DSC) {
-		struct dc_stream_state *stream = otg_master->stream;
-		struct pipe_ctx *odm_pipe;
-		int opp_cnt = 1;
-		int last_dsc_calc = 0;
-		bool should_use_dto_dscclk = (dc->res_pool->dccg->funcs->set_dto_dscclk != NULL) &&
-				stream->timing.pix_clk_100hz > 480000;
-
-		/* Count ODM pipes */
-		for (odm_pipe = otg_master->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-			opp_cnt++;
-
-		int num_slices_h = stream->timing.dsc_cfg.num_slices_h / opp_cnt;
-
-		/* Step 1: Set DTO DSCCLK for main DSC if needed */
-		if (should_use_dto_dscclk) {
-			hwss_add_dccg_set_dto_dscclk(seq_state, dc->res_pool->dccg,
-					otg_master->stream_res.dsc->inst, num_slices_h);
-		}
-
-		/* Step 2: Calculate and set DSC config for main DSC */
-		last_dsc_calc = *seq_state->num_steps;
-		hwss_add_dsc_calculate_and_set_config(seq_state, otg_master, true, opp_cnt);
-
-		/* Step 3: Enable main DSC block */
-		hwss_add_dsc_enable_with_opp(seq_state, otg_master);
-
-		/* Step 4: Configure and enable ODM DSC blocks */
-		for (odm_pipe = otg_master->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-			if (!odm_pipe->stream_res.dsc)
-				continue;
-
-			/* Set DTO DSCCLK for ODM DSC if needed */
-			if (should_use_dto_dscclk) {
-				hwss_add_dccg_set_dto_dscclk(seq_state, dc->res_pool->dccg,
-						odm_pipe->stream_res.dsc->inst, num_slices_h);
-			}
-
-			/* Calculate and set DSC config for ODM DSC */
-			last_dsc_calc = *seq_state->num_steps;
-			hwss_add_dsc_calculate_and_set_config(seq_state, odm_pipe, true, opp_cnt);
-
-			/* Enable ODM DSC block */
-			hwss_add_dsc_enable_with_opp(seq_state, odm_pipe);
+		if (!hwss_add_dsc_sequence_for_stream(seq_state, otg_master,
+				otg_master->dsc_padding_params.dsc_hactive_padding, NULL)) {
+			ASSERT(false);
+			return;
 		}
-
-		/* Step 5: Configure DSC in timing generator */
-		hwss_add_tg_set_dsc_config(seq_state, otg_master->stream_res.tg,
-			&seq_state->steps[last_dsc_calc].params.dsc_calculate_and_set_config_params.dsc_optc_cfg, true);
 	} else if (otg_master->stream_res.dsc && !otg_master->stream->timing.flags.DSC) {
 		/* Disable DSC in OPTC */
 		hwss_add_tg_set_dsc_config(seq_state, otg_master->stream_res.tg, NULL, false);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index a1b994edf80a..7800b0501c39 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -279,8 +279,6 @@ struct dccg_set_dto_dscclk_params {
 
 struct dsc_set_config_params {
 	struct display_stream_compressor *dsc;
-	struct dsc_config *dsc_cfg;
-	struct dsc_optc_config *dsc_optc_cfg;
 };
 
 struct dsc_enable_params {
@@ -290,8 +288,9 @@ struct dsc_enable_params {
 
 struct tg_set_dsc_config_params {
 	struct timing_generator *tg;
-	struct dsc_optc_config *dsc_optc_cfg;
-	bool enable;
+	enum optc_dsc_mode dsc_mode;
+	uint32_t bytes_per_pixel;
+	uint32_t slice_width;
 };
 
 struct dsc_disconnect_params {
@@ -303,13 +302,6 @@ struct dsc_read_state_params {
 	struct dcn_dsc_state *dsc_state;
 };
 
-struct dsc_calculate_and_set_config_params {
-	struct pipe_ctx *pipe_ctx;
-	struct dsc_optc_config dsc_optc_cfg;
-	bool enable;
-	int opp_cnt;
-};
-
 struct dsc_enable_with_opp_params {
 	struct display_stream_compressor *dsc;
 	int opp_inst;
@@ -936,15 +928,11 @@ struct stream_enc_update_dp_info_packets_params {
 	struct pipe_ctx *pipe_ctx;
 };
 
-struct dsc_set_config_simple_params {
-	struct display_stream_compressor *dsc;
-	struct dsc_config dsc_cfg;
-	struct dsc_optc_config dsc_optc_cfg;
-};
-
 struct stream_enc_dp_set_dsc_config_params {
 	struct stream_encoder *stream_enc;
-	const struct dsc_optc_config *dsc_optc_cfg;
+	enum optc_dsc_mode dsc_mode;
+	uint32_t bytes_per_pixel;
+	uint32_t slice_width;
 };
 
 struct hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params {
@@ -1084,7 +1072,6 @@ union block_sequence_params {
 	struct tg_set_dsc_config_params tg_set_dsc_config_params;
 	struct dsc_disconnect_params dsc_disconnect_params;
 	struct dsc_read_state_params dsc_read_state_params;
-	struct dsc_calculate_and_set_config_params dsc_calculate_and_set_config_params;
 	struct dsc_enable_with_opp_params dsc_enable_with_opp_params;
 	struct program_tg_params program_tg_params;
 	struct tg_program_global_sync_params tg_program_global_sync_params;
@@ -1194,7 +1181,6 @@ union block_sequence_params {
 	struct hpo_dp_stream_enc_update_dp_info_packets_params hpo_dp_stream_enc_update_dp_info_packets_params;
 	struct stream_enc_update_dp_info_packets_sdp_line_num_params stream_enc_update_dp_info_packets_sdp_line_num_params;
 	struct stream_enc_update_dp_info_packets_params stream_enc_update_dp_info_packets_params;
-	struct dsc_set_config_simple_params dsc_set_config_simple_params;
 	struct stream_enc_dp_set_dsc_config_params stream_enc_dp_set_dsc_config_params;
 	struct hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params;
 	struct stream_enc_dp_set_dsc_pps_info_packet_params stream_enc_dp_set_dsc_pps_info_packet_params;
@@ -1259,7 +1245,6 @@ enum block_sequence_func {
 	TG_SET_DSC_CONFIG,
 	DSC_DISCONNECT,
 	DSC_READ_STATE,
-	DSC_CALCULATE_AND_SET_CONFIG,
 	DSC_ENABLE_WITH_OPP,
 	TG_PROGRAM_GLOBAL_SYNC,
 	TG_WAIT_FOR_STATE,
@@ -1350,7 +1335,6 @@ enum block_sequence_func {
 	HPO_DP_STREAM_ENC_UPDATE_DP_INFO_PACKETS,
 	STREAM_ENC_UPDATE_DP_INFO_PACKETS_SDP_LINE_NUM,
 	STREAM_ENC_UPDATE_DP_INFO_PACKETS,
-	DSC_SET_CONFIG_SIMPLE,
 	STREAM_ENC_DP_SET_DSC_CONFIG,
 	HPO_DP_STREAM_ENC_DP_SET_DSC_PPS_INFO_PACKET,
 	STREAM_ENC_DP_SET_DSC_PPS_INFO_PACKET,
@@ -1900,12 +1884,8 @@ void hwss_dsc_disconnect(union block_sequence_params *params);
 
 void hwss_dsc_read_state(union block_sequence_params *params);
 
-void hwss_dsc_calculate_and_set_config(union block_sequence_params *params);
-
 void hwss_dsc_enable_with_opp(union block_sequence_params *params);
 
-void hwss_dsc_set_config_simple(union block_sequence_params *params);
-
 void hwss_stream_enc_update_hdmi_info_packets(union block_sequence_params *params);
 
 void hwss_hpo_frl_stream_enc_update_hdmi_info_packets(union block_sequence_params *params);
@@ -2284,8 +2264,9 @@ void hwss_add_tg_wait_double_buffer_pending(struct block_sequence_state *seq_sta
 void hwss_add_dccg_set_dto_dscclk(struct block_sequence_state *seq_state,
 		struct dccg *dccg, int inst, int num_slices_h);
 
-void hwss_add_dsc_calculate_and_set_config(struct block_sequence_state *seq_state,
-		struct pipe_ctx *pipe_ctx, bool enable, int opp_cnt);
+/* Resolves DSC geometry and driver state for pipe; pass NULL if the caller does not need OPTC parameters. */
+bool hwss_prepare_dsc_config_for_pipe(struct pipe_ctx *pipe_ctx, int opp_cnt, uint32_t dsc_padding,
+			struct dsc_optc_config *dsc_optc_cfg);
 
 void hwss_add_mpc_remove_mpcc(struct block_sequence_state *seq_state,
 		struct mpc *mpc, struct mpc_tree *mpc_tree_params, struct mpcc *mpcc_to_remove);
@@ -2641,7 +2622,7 @@ void hwss_add_hubbub_apply_dedcn21_147_wa(struct block_sequence_state *seq_state
 
 void hwss_add_tg_set_dsc_config(struct block_sequence_state *seq_state,
 		struct timing_generator *tg,
-		struct dsc_optc_config *dsc_optc_cfg,
+		const struct dsc_optc_config *dsc_optc_cfg,
 		bool enable);
 
 void hwss_add_opp_program_left_edge_extra_pixel(struct block_sequence_state *seq_state,
@@ -2694,10 +2675,18 @@ void hwss_add_stream_enc_update_dp_info_packets_sdp_line_num(struct block_sequen
 void hwss_add_stream_enc_update_dp_info_packets(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx);
 
-void hwss_add_dsc_set_config(struct block_sequence_state *seq_state,
-		struct display_stream_compressor *dsc,
-		const struct dsc_config *dsc_cfg,
-		const struct dsc_optc_config *dsc_optc_cfg);
+bool hwss_add_dsc_set_config(struct block_sequence_state *seq_state,
+		struct display_stream_compressor *dsc);
+
+/* Composes DSC sub-sequence (prepare, set config, enable with OPP) for a pipe. */
+bool hwss_add_dsc_sequence_for_pipe(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx, int opp_cnt, uint32_t dsc_padding,
+		struct dsc_optc_config *dsc_optc_cfg);
+
+/* Composes full DSC sequence (DCCG DTO clocks, DSC, OPP, TG) for a stream. */
+bool hwss_add_dsc_sequence_for_stream(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx, uint32_t dsc_padding,
+		struct dsc_optc_config *dsc_optc_cfg);
 
 void hwss_add_stream_enc_dp_set_dsc_config(struct block_sequence_state *seq_state,
 		struct stream_encoder *stream_enc,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index c009d0fb14ca..ec503d3541c9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -767,14 +767,25 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 		if (should_use_dto_dscclk)
 			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
-		dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
+		if (!dsc->funcs->dsc_prepare_config(dsc, &dsc_cfg, &dsc_optc_cfg)) {
+			ASSERT(false);
+			return;
+		}
+		dsc->funcs->dsc_set_config(dsc);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
 		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
 
+			ASSERT(odm_dsc);
+			if (!odm_dsc)
+				return;
 			if (should_use_dto_dscclk)
 				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
-			odm_dsc->funcs->dsc_set_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg);
+			if (!odm_dsc->funcs->dsc_prepare_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg)) {
+				ASSERT(false);
+				return;
+			}
+			odm_dsc->funcs->dsc_set_config(odm_dsc);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
 		}
 		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
-- 
2.34.1

