Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4091CD343F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 15:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4226910F1E4;
	Thu,  7 May 2026 15:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5DPHON8F";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0507F10F1E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 15:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHj87Dx1xA1YS4O3dldxOY3eM/z/JzfrJoERUcXe8fIPJrIA8NWGx5oXD//GHiiQJ/HmxJVkS7fsGMfAGHWuoEvlEFGRBQL3KmkYutAx6WNws8RZ5KiQsTt/J+Xkio/duxr+zWuk6u5phQ2dvddoshGWnQccddVZYt8cVdKXGhF1XY1z2anlIRuaK8V/39GrwWpRfV7gcJ92W+gm5PTNLDUnJUkhB2BcZlEFfbXh2Hupx5D0l2mPF2RhFBStg1zrOH2Xk9NQzeX4PvS2B7t9i0j2ukNG1xUtjSodH6x9I5fwDi806jrAOc0eSuzcU290UBvPvZiwA1iiKFyhfr9n6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmIRuVD5uiWsEHiWO14qNHfF8SszPOjVliX39L7cZlI=;
 b=VzMlatzvJ+yqUOboVuPZ9hxbhsely2U5JkZoKnyRLVWCucU/aANv1PAOz9Rjt1Oh+TS/+XFBsGCQ4eZhuNA7PG1az1fwjW+2Pw+7nWXyYx6hlMxMu+FybrmmQUHI2sSynXIdFc80QRyeEF4qIDJAwU7c2zQGr4WlkQqt5EueA+VuJw8RHO/bwpNT5klCnIZPJNngCCC1V0nPcTE0eDrO3oISfcgDgnnE0vr5njR52eiAatAVkWnDRzr0OyPoMqp5m/BXR2AY+ZQnCRyEGiL2qV0PCl5TRxcT8EUVqW2oV6AnDYXNaNiVcqMek1KhqeBd1GdDjp4+SG5t8zSZJjejoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmIRuVD5uiWsEHiWO14qNHfF8SszPOjVliX39L7cZlI=;
 b=5DPHON8FYE1Qi5Up5evDqtmiLZzlBPOKkqG2PfPSlXNgRh/xcBkvuNEqXlUdUtFzagB98DlImZehsEiVUKtrGjeOfARoN8oHiDDyFfv8Met8Oogy9SR3y5jVOyqpI9dxM8YAgMD1xt1UeOijX98ACphjOwlQ9yxLEL5ulfvC8sg=
Received: from PH7PR17CA0068.namprd17.prod.outlook.com (2603:10b6:510:325::12)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 15:51:51 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::b4) by PH7PR17CA0068.outlook.office365.com
 (2603:10b6:510:325::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Thu,
 7 May 2026 15:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:51:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 10:51:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 08:51:49 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 10:51:49 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH v2 01/22] drm/amd/display: Implement block sequencing
 infrastructure for modular hardware operations.
Date: Thu, 7 May 2026 11:51:23 -0400
Message-ID: <20260507155147.182540-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507155147.182540-1-harry.wentland@amd.com>
References: <20260507155147.182540-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ca426b-3886-4b6f-62a8-08deac508da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|22082099003|3023799003|56012099003;
X-Microsoft-Antispam-Message-Info: 8sQAWDbyY8gpBYHiyPVTIK/a8/fcs8oTFxFTstUrYJIumUDlb/VpgR0GS6Zsg44B3nZZ/ZJTx7U61FvraPCCn7/mQCTYLo4XPstj3dV0z7dhkrtN/lI1+5i4n8mgqlFgjAnzINNuEfuYLApWxMw2qgfXtwVW9cCqF0Zw8HN0VQ8LY7Jflob0BgIi5izfTXL93RYHWJppEfFPQPTFpCfjjSdQ5YDUXvufwdtjZG+BYRstF0LIPTtSRUquZ08+TNB+9pcjzYvLjvw3Pu1SFEn4AKY6nmQmymPoJAOrHulknizlBz9I1L4AxZgBN5kPhbtHMHgJaP2qSMDz/DFQH0wKXdXgQXfSBjcejHnyV0V1Rn2ombjvOcjD+X5gmBlC6kjDtsFFRWrwKE0O9QE9ZEEMWLmCttN1DS39nTHsTNc4q2d1wdAfX0sETTyjWYwHNZk0p+w3MZPA0Tcu+4OcAyvCrBZun7jKR3Uz3ZXqg4Z6J9s2MKBbGJRXF1QACwM9J6Ir2zlpfxx4BDRDahwXQeZK4xAkibXVwElLmLxZ+kDzbLxA6mNFI7gQR0Grrm9vxsfiM+iXXuu3kEAu1MXHqFlEXRhYadu8xu/9K2mZ4+5NFXIyePM/V/KxPjt+ytuRdRYh15lcDNGRFS9BsIKO5YRbSOaLVQLrmjCgFmU6Dc6dosVFT6K13wkAm0PXgOCmI1kGI7rt2OYy2fYW7lMKPFNOPhF05euPEdr6215h3tKvGgM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(3023799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UkzsekoKSYVb5AocmpK4V4pZrfKaMVfBRE8sWbxvxPv47es9dUV7pgtV+TvsPwRCiWC8b6Zc5uoKgw+2y5mozJRZc9+NqwQOxNoOFUqp3aCNsjVY6MqtKKBRWFUSTxZBdkwZ+wC3mZe8Re1ru+vS2AC0UDyLeOzBcKIjiV5fm/HHEXUYYpEgtCDS6o7vODfV8sHxWruPpO9KfPEfev0ABLvAfQwQ5CHprskOcisWgwiKa4fMj6wv+7OBnwIOKaheaNJ8zL7VXthJPdFO5Hnb+aJ6ZhTIMla7arU+n+3aV33YN9b1qqE7OLMqa4Ae4eBKX4iOMvMp4rJMScWJLBAZxA5QKZsl4pWDG+ed4x3mcKvcpgbhbx+s31e+/6zk9rWIjGgLL84XKDFYoiGYnKw2VcdDqIQu0QEgDRgbbr1JHa5ygUASyFMFg6WxzsID30iM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:51:50.6040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ca426b-3886-4b6f-62a8-08deac508da5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936
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

From: Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>

[why]
Hardware sequencer operations need better modularity and testability.
Current monolithic functions make it difficult to unit test individual operations and create maintainable workflows.

[how]
Implement new hwss_add_* helper functions with standardized parameter structures.
Add block_sequence_state framework for execution context management.
Create cursor, info frame, DSC, and stream encoder sequence functions with comprehensive unit test support.

Signed-off-by: Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 421 +++++++++++++
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 586 ++++++++++++++++--
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 345 +++++++++--
 3 files changed, 1268 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0c7c84276d1f..ad927e63c207 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -32,6 +32,7 @@
 #include "core_types.h"
 #include "hw_sequencer.h"
 #include "dce/dce_hwseq.h"
+#include "hw/dccg.h"
 
 #include "resource.h"
 #include "dc_state.h"
@@ -61,6 +62,7 @@
 #include "link_enc_cfg.h"
 
 #include "link_service.h"
+#include "link/protocols/link_dp_capability.h"
 #include "dm_helpers.h"
 #include "mem_input.h"
 
@@ -3792,6 +3794,409 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 }
 
+static void program_cursor_attributes_sequence(
+		struct dc *dc,
+		struct dc_stream_state *stream,
+		struct dc_state *context,
+		struct block_sequence_state *seq_state)
+{
+	int k;
+	struct pipe_ctx *pipe_to_program = NULL;
+	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
+
+	for (k = 0; k < dc->res_pool->pipe_count; k++) {
+		struct pipe_ctx *tmp_pipe = &context->res_ctx.pipe_ctx[k];
+
+		if (tmp_pipe->stream != stream)
+			continue;
+
+		if (!pipe_to_program) {
+			pipe_to_program = tmp_pipe;
+
+			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
+				hwss_add_begin_cursor_offload_update(seq_state, dc, tmp_pipe);
+			} else {
+				hwss_add_cursor_lock(seq_state, dc, pipe_to_program, true);
+				if (pipe_to_program->next_odm_pipe)
+					hwss_add_cursor_lock(seq_state, dc, pipe_to_program->next_odm_pipe, true);
+			}
+		}
+
+		hwss_add_set_cursor_attribute(seq_state, dc, tmp_pipe);
+		if (dc->ctx->dmub_srv)
+			hwss_add_send_update_cursor_info_to_dmu(seq_state, tmp_pipe, k);
+		if (dc->hwss.set_cursor_sdr_white_level)
+			hwss_add_set_cursor_sdr_white_level(seq_state, dc, tmp_pipe);
+		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe)
+			hwss_add_update_cursor_offload_pipe(seq_state, dc, tmp_pipe);
+	}
+
+	if (pipe_to_program) {
+		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update) {
+			hwss_add_commit_cursor_offload_update(seq_state, dc, pipe_to_program);
+		} else {
+			hwss_add_cursor_lock(seq_state, dc, pipe_to_program, false);
+			if (pipe_to_program->next_odm_pipe)
+				hwss_add_cursor_lock(seq_state, dc, pipe_to_program->next_odm_pipe, false);
+		}
+	}
+}
+
+static void program_cursor_position_sequence(
+		struct dc *dc,
+		struct dc_stream_state *stream,
+		struct dc_state *context,
+		struct block_sequence_state *seq_state)
+{
+	int k;
+	struct pipe_ctx *pipe_to_program = NULL;
+	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
+
+	for (k = 0; k < dc->res_pool->pipe_count; k++) {
+		struct pipe_ctx *tmp_pipe = &context->res_ctx.pipe_ctx[k];
+
+		if (tmp_pipe->stream != stream ||
+				(!tmp_pipe->plane_res.mi  && !tmp_pipe->plane_res.hubp) ||
+				!tmp_pipe->plane_state ||
+				(!tmp_pipe->plane_res.xfm && !tmp_pipe->plane_res.dpp) ||
+				(!tmp_pipe->plane_res.ipp && !tmp_pipe->plane_res.dpp))
+			continue;
+
+		if (!pipe_to_program) {
+			pipe_to_program = tmp_pipe;
+
+			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update)
+				hwss_add_begin_cursor_offload_update(seq_state, dc, tmp_pipe);
+			else
+				hwss_add_cursor_lock(seq_state, dc, pipe_to_program, true);
+		}
+
+		hwss_add_set_cursor_position(seq_state, dc, tmp_pipe);
+		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe)
+			hwss_add_update_cursor_offload_pipe(seq_state, dc, tmp_pipe);
+
+		if (dc->ctx->dmub_srv)
+			hwss_add_send_update_cursor_info_to_dmu(seq_state, tmp_pipe, k);
+	}
+
+	if (pipe_to_program) {
+		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update)
+			hwss_add_commit_cursor_offload_update(seq_state, dc, pipe_to_program);
+		else
+			hwss_add_cursor_lock(seq_state, dc, pipe_to_program, false);
+	}
+}
+
+static void add_update_info_frame_sequence(
+		struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	bool is_hdmi_tmds;
+	bool is_dp;
+
+	if (!pipe_ctx || !pipe_ctx->stream)
+		return;
+
+	if (pipe_ctx->stream_res.stream_enc == NULL)
+		return;
+
+	is_hdmi_tmds = dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal);
+	is_dp = dc_is_dp_signal(pipe_ctx->stream->signal);
+
+	if (!is_hdmi_tmds && !is_dp)
+		return;
+
+	if (is_hdmi_tmds) {
+		hwss_add_stream_enc_update_hdmi_info_packets(seq_state, pipe_ctx);
+		return;
+	}
+
+	if (is_dp) {
+		if (dp_is_128b_132b_signal(pipe_ctx)) {
+			hwss_add_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(seq_state, pipe_ctx);
+			hwss_add_hpo_dp_stream_enc_update_dp_info_packets(seq_state, pipe_ctx);
+		} else {
+			hwss_add_stream_enc_update_dp_info_packets_sdp_line_num(seq_state, pipe_ctx);
+			hwss_add_stream_enc_update_dp_info_packets(seq_state, pipe_ctx);
+		}
+	}
+}
+
+static void add_link_update_dsc_config_sequence(
+		struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx,
+		struct dsc_config *dsc_cfg,
+		struct dsc_optc_config *dsc_optc_cfg)
+{
+	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc *dc = stream->ctx->dc;
+	struct dccg *dccg = dc->res_pool->dccg;
+	struct pipe_ctx *top_pipe = pipe_ctx;
+	struct pipe_ctx *odm_pipe = NULL;
+	int opp_cnt = 1;
+	bool should_use_dto_dscclk = false;
+	struct dsc_config dsc_pps_cfg;
+	uint8_t *dsc_packed_pps = stream->dsc_packed_pps;
+	int last_dsc_set_config_step = 0;
+
+	if (!stream->timing.flags.DSC || !dsc)
+		return;
+
+	while (top_pipe->prev_odm_pipe)
+		top_pipe = top_pipe->prev_odm_pipe;
+
+	for (odm_pipe = top_pipe->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+		opp_cnt++;
+
+	memset(dsc_cfg, 0, sizeof(*dsc_cfg));
+	memset(dsc_optc_cfg, 0, sizeof(*dsc_optc_cfg));
+
+	dsc_cfg->pic_width = (stream->timing.h_addressable +
+		top_pipe->dsc_padding_params.dsc_hactive_padding +
+		stream->timing.h_border_left +
+		stream->timing.h_border_right) / opp_cnt;
+	dsc_cfg->pic_height = stream->timing.v_addressable +
+		stream->timing.v_border_top +
+		stream->timing.v_border_bottom;
+	dsc_cfg->pixel_encoding = stream->timing.pixel_encoding;
+	dsc_cfg->color_depth = stream->timing.display_color_depth;
+	dsc_cfg->is_odm = top_pipe->next_odm_pipe ? true : false;
+	dsc_cfg->dc_dsc_cfg = stream->timing.dsc_cfg;
+	ASSERT(dsc_cfg->dc_dsc_cfg.num_slices_h % opp_cnt == 0);
+	dsc_cfg->dc_dsc_cfg.num_slices_h /= opp_cnt;
+	dsc_cfg->dsc_padding = 0;
+
+	if (dccg && dccg->funcs->set_dto_dscclk &&
+			stream->timing.pix_clk_100hz > 480000)
+		should_use_dto_dscclk = true;
+
+	if (should_use_dto_dscclk)
+		hwss_add_dccg_set_dto_dscclk(seq_state, dccg, dsc->inst,
+			dsc_cfg->dc_dsc_cfg.num_slices_h);
+
+	last_dsc_set_config_step = *seq_state->num_steps;
+	hwss_add_dsc_set_config(seq_state, dsc, dsc_cfg, dsc_optc_cfg);
+	hwss_add_dsc_enable_with_opp(seq_state, top_pipe);
+
+	for (odm_pipe = top_pipe->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+		struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
+
+		if (should_use_dto_dscclk)
+			hwss_add_dccg_set_dto_dscclk(seq_state, dccg, odm_dsc->inst,
+				dsc_cfg->dc_dsc_cfg.num_slices_h);
+
+		last_dsc_set_config_step = *seq_state->num_steps;
+		hwss_add_dsc_set_config(seq_state, odm_dsc, dsc_cfg, dsc_optc_cfg);
+		hwss_add_dsc_enable_with_opp(seq_state, odm_pipe);
+	}
+
+	if (dc_is_dp_signal(stream->signal) && !dp_is_128b_132b_signal(pipe_ctx))
+		hwss_add_stream_enc_dp_set_dsc_config(seq_state,
+			pipe_ctx->stream_res.stream_enc,
+			&seq_state->steps[last_dsc_set_config_step].params.dsc_set_config_simple_params.dsc_optc_cfg);
+
+	hwss_add_tg_set_dsc_config(seq_state, top_pipe->stream_res.tg,
+		&seq_state->steps[last_dsc_set_config_step].params.dsc_set_config_simple_params.dsc_optc_cfg, true);
+
+	memset(&dsc_pps_cfg, 0, sizeof(dsc_pps_cfg));
+	dsc_pps_cfg.pic_width = stream->timing.h_addressable +
+		stream->timing.h_border_left + stream->timing.h_border_right;
+	dsc_pps_cfg.pic_height = stream->timing.v_addressable +
+		stream->timing.v_border_top + stream->timing.v_border_bottom;
+	dsc_pps_cfg.pixel_encoding = stream->timing.pixel_encoding;
+	dsc_pps_cfg.color_depth = stream->timing.display_color_depth;
+	dsc_pps_cfg.is_odm = top_pipe->next_odm_pipe ? true : false;
+	dsc_pps_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
+	dsc_pps_cfg.dsc_padding = top_pipe->dsc_padding_params.dsc_hactive_padding;
+
+	if (dsc->funcs->dsc_get_packed_pps) {
+		dsc->funcs->dsc_get_packed_pps(dsc, &dsc_pps_cfg, dsc_packed_pps);
+
+		if (dc_is_dp_signal(stream->signal)) {
+			if (dp_is_128b_132b_signal(pipe_ctx))
+				hwss_add_hpo_dp_stream_enc_dp_set_dsc_pps_info_packet(seq_state,
+					pipe_ctx->stream_res.hpo_dp_stream_enc,
+					true, dsc_packed_pps, false);
+			else
+				hwss_add_stream_enc_dp_set_dsc_pps_info_packet(seq_state,
+					pipe_ctx->stream_res.stream_enc,
+					true, dsc_packed_pps, false);
+		}
+	}
+}
+
+static void commit_planes_do_stream_update_sequence(struct dc *dc,
+		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update,
+		enum surface_update_type update_type,
+		struct dc_state *context,
+		struct block_sequence block_sequence[MAX_HWSS_BLOCK_SEQUENCE_SIZE],
+		unsigned int *num_steps)
+{
+	int j;
+	struct block_sequence_state seq_state = { .steps = block_sequence, .num_steps = num_steps };
+	struct dsc_config dsc_cfgs[MAX_PIPES];
+	struct dsc_optc_config dsc_optc_cfgs[MAX_PIPES];
+	unsigned int dsc_cfg_index = 0;
+	*num_steps = 0; // Initialize to 0
+
+	// Stream updates
+	for (j = 0; j < dc->res_pool->pipe_count; j++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+
+		if (resource_is_pipe_type(pipe_ctx, OTG_MASTER) && pipe_ctx->stream == stream) {
+
+			if (stream_update->periodic_interrupt && dc->hwss.setup_periodic_interrupt)
+				hwss_add_setup_periodic_interrupt(&seq_state, dc, pipe_ctx);
+
+			if ((stream_update->hdr_static_metadata && !stream->use_dynamic_meta) ||
+					stream_update->vrr_infopacket ||
+					stream_update->vsc_infopacket ||
+					stream_update->vsp_infopacket ||
+					stream_update->hfvsif_infopacket ||
+					stream_update->adaptive_sync_infopacket ||
+					stream_update->vtem_infopacket ||
+					stream_update->avi_infopacket) {
+				resource_build_info_frame(pipe_ctx);
+				add_update_info_frame_sequence(&seq_state, pipe_ctx);
+
+				if (dc_is_dp_signal(pipe_ctx->stream->signal))
+					hwss_add_dp_trace_source_sequence(&seq_state,
+							pipe_ctx->stream->link,
+							DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME);
+			}
+
+			if (stream_update->hdr_static_metadata &&
+					stream->use_dynamic_meta &&
+					dc->hwss.set_dmdata_attributes &&
+					pipe_ctx->stream->dmdata_address.quad_part != 0)
+				hwss_add_set_dmdata_attributes(&seq_state, pipe_ctx);
+
+			if (stream_update->gamut_remap)
+				hwss_add_dpp_program_gamut_remap(&seq_state, pipe_ctx);
+
+			if (stream_update->output_csc_transform)
+				hwss_add_program_output_csc(&seq_state, dc, pipe_ctx,
+					stream->output_color_space,
+					stream->csc_color_matrix.matrix,
+					pipe_ctx->stream_res.opp->inst);
+
+			if (stream_update->dither_option) {
+				struct pipe_ctx *odm_pipe = pipe_ctx->next_odm_pipe;
+				resource_build_bit_depth_reduction_params(pipe_ctx->stream,
+								&pipe_ctx->stream->bit_depth_params);
+				hwss_add_opp_program_fmt(&seq_state, pipe_ctx->stream_res.opp,
+						&stream->bit_depth_params,
+						&stream->clamping);
+				while (odm_pipe) {
+					hwss_add_opp_program_fmt(&seq_state, odm_pipe->stream_res.opp,
+							&stream->bit_depth_params,
+							&stream->clamping);
+					odm_pipe = odm_pipe->next_odm_pipe;
+				}
+			}
+
+			if (stream_update->cursor_attributes)
+				program_cursor_attributes_sequence(dc, stream, context, &seq_state);
+
+			if (stream_update->cursor_position)
+				program_cursor_position_sequence(dc, stream, context, &seq_state);
+
+			/* Full fe update*/
+			if (update_type == UPDATE_TYPE_FAST)
+				continue;
+
+			if (stream_update->dsc_config)
+				if (dsc_cfg_index < MAX_PIPES) {
+					add_link_update_dsc_config_sequence(&seq_state,
+						pipe_ctx,
+						&dsc_cfgs[dsc_cfg_index],
+						&dsc_optc_cfgs[dsc_cfg_index]);
+					dsc_cfg_index++;
+				}
+
+			if (stream_update->mst_bw_update) {
+				if (stream_update->mst_bw_update->is_increase)
+					hwss_add_link_increase_mst_payload(&seq_state,
+							pipe_ctx,
+							stream_update->mst_bw_update->mst_stream_bw);
+				else
+					hwss_add_link_reduce_mst_payload(&seq_state,
+							pipe_ctx,
+							stream_update->mst_bw_update->mst_stream_bw);
+			}
+
+			if (stream_update->pending_test_pattern) {
+				/*
+				 * test pattern params depends on ODM topology
+				 * changes that we could be applying to front
+				 * end. Since at the current stage front end
+				 * changes are not yet applied. We can only
+				 * apply test pattern in hw based on current
+				 * state and populate the final test pattern
+				 * params in new state. If current and new test
+				 * pattern params are different as result of
+				 * different ODM topology being used, it will be
+				 * detected and handle during front end
+				 * programming update.
+				 */
+				hwss_add_dp_set_test_pattern(&seq_state,
+					stream->link,
+					stream->test_pattern.type,
+					stream->test_pattern.color_space,
+					stream->test_pattern.p_link_settings,
+					stream->test_pattern.p_custom_pattern,
+					stream->test_pattern.cust_pattern_size);
+				resource_build_test_pattern_params(&context->res_ctx, pipe_ctx);
+			}
+
+			if (stream_update->dpms_off) {
+				// DPMS should not use partially updated pipe context
+				struct pipe_ctx *dpms_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[j];
+
+				if (*stream_update->dpms_off) {
+					hwss_add_link_set_dpms_off(&seq_state, dpms_pipe_ctx);
+					/* for dpms, keep acquired resources*/
+					if (dpms_pipe_ctx->stream_res.audio && !dc->debug.az_endpoint_mute_only)
+						hwss_add_disable_audio_stream(&seq_state, dpms_pipe_ctx);
+
+					hwss_add_dc_set_optimized_required(&seq_state, dc, true);
+
+				} else {
+					if (get_seamless_boot_stream_count(context) == 0)
+						hwss_add_prepare_bandwidth(&seq_state, dc, dc->current_state);
+					hwss_add_link_set_dpms_on(&seq_state, dc->current_state, dpms_pipe_ctx);
+				}
+			} else if (pipe_ctx->stream->link->wa_flags.blank_stream_on_ocs_change && stream_update->output_color_space
+					&& !stream->dpms_off && dc_is_dp_signal(pipe_ctx->stream->signal)) {
+				/*
+				 * Workaround for firmware issue in some receivers where they don't pick up
+				 * correct output color space unless DP link is disabled/re-enabled
+				 */
+					hwss_add_link_set_dpms_on(&seq_state, dc->current_state, pipe_ctx);
+			}
+
+			if (stream_update->abm_level && pipe_ctx->stream_res.abm) {
+				bool should_program_abm = true;
+
+				// if otg funcs defined check if blanked before programming
+				if (pipe_ctx->stream_res.tg->funcs->is_blanked)
+					if (pipe_ctx->stream_res.tg->funcs->is_blanked(pipe_ctx->stream_res.tg))
+						should_program_abm = false;
+
+				if (should_program_abm) {
+					if (*stream_update->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE) {
+						hwss_add_abm_set_immediate_disable(&seq_state, dc, pipe_ctx);
+					} else {
+						hwss_add_abm_set_level(&seq_state, pipe_ctx->stream_res.abm, stream->abm_level);
+					}
+				}
+			}
+		}
+	}
+}
+
 static void commit_planes_do_stream_update(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
@@ -3800,6 +4205,22 @@ static void commit_planes_do_stream_update(struct dc *dc,
 {
 	int j;
 
+	// Check if block sequence programming is enabled
+	if (dc->debug.enable_block_sequence_programming) {
+		unsigned int num_steps = 0;
+
+		// Build the block sequence using context's pre-allocated array
+		commit_planes_do_stream_update_sequence(dc, stream, stream_update,
+				update_type, context, context->block_sequence, &num_steps);
+
+		// Execute the block sequence
+		if (num_steps > 0)
+			hwss_execute_sequence(dc, context->block_sequence, num_steps);
+
+		return;
+	}
+
+	// Legacy path (existing implementation)
 	// Stream updates
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index a347d3ff5e6e..b3a5935e3811 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -806,9 +806,8 @@ void hwss_build_fast_sequence(struct dc *dc,
 		(*num_steps)++;
 
 		if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
-			block_sequence[*num_steps].params.dp_trace_source_sequence_params.dc = dc;
 			block_sequence[*num_steps].params.dp_trace_source_sequence_params.link = pipe_ctx->stream->link;
-			block_sequence[*num_steps].params.dp_trace_source_sequence_params.dp_test_mode = DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME;
+			block_sequence[*num_steps].params.dp_trace_source_sequence_params.source = DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME;
 			block_sequence[*num_steps].func = DP_TRACE_SOURCE_SEQUENCE;
 			(*num_steps)++;
 		}
@@ -1251,9 +1250,6 @@ void hwss_execute_sequence(struct dc *dc,
 		case HWSS_UPDATE_INFO_FRAME:
 			hwss_update_info_frame(dc, params);
 			break;
-		case DP_TRACE_SOURCE_SEQUENCE:
-			hwss_dp_trace_source_sequence(params);
-			break;
 		case HUBP_SET_DMDATA_ATTRIBUTES:
 			hwss_set_dmdata_attributes(params);
 			break;
@@ -1616,6 +1612,57 @@ void hwss_execute_sequence(struct dc *dc,
 		case PHANTOM_HUBP_POST_ENABLE:
 			hwss_phantom_hubp_post_enable(params);
 			break;
+		case STREAM_ENC_UPDATE_HDMI_INFO_PACKETS:
+			hwss_stream_enc_update_hdmi_info_packets(params);
+			break;
+		case HPO_DP_STREAM_ENC_UPDATE_DP_INFO_PACKETS_SDP_LINE_NUM:
+			hwss_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(params);
+			break;
+		case HPO_DP_STREAM_ENC_UPDATE_DP_INFO_PACKETS:
+			hwss_hpo_dp_stream_enc_update_dp_info_packets(params);
+			break;
+		case STREAM_ENC_UPDATE_DP_INFO_PACKETS_SDP_LINE_NUM:
+			hwss_stream_enc_update_dp_info_packets_sdp_line_num(params);
+			break;
+		case STREAM_ENC_UPDATE_DP_INFO_PACKETS:
+			hwss_stream_enc_update_dp_info_packets(params);
+			break;
+		case DSC_SET_CONFIG_SIMPLE:
+			hwss_dsc_set_config_simple(params);
+			break;
+		case STREAM_ENC_DP_SET_DSC_CONFIG:
+			hwss_stream_enc_dp_set_dsc_config(params);
+			break;
+		case HPO_DP_STREAM_ENC_DP_SET_DSC_PPS_INFO_PACKET:
+			hwss_hpo_dp_stream_enc_dp_set_dsc_pps_info_packet(params);
+			break;
+		case STREAM_ENC_DP_SET_DSC_PPS_INFO_PACKET:
+			hwss_stream_enc_dp_set_dsc_pps_info_packet(params);
+			break;
+		case DP_TRACE_SOURCE_SEQUENCE:
+			hwss_dp_trace_source_sequence(params);
+			break;
+		case LINK_INCREASE_MST_PAYLOAD:
+			hwss_link_increase_mst_payload(params);
+			break;
+		case LINK_REDUCE_MST_PAYLOAD:
+			hwss_link_reduce_mst_payload(params);
+			break;
+		case DP_SET_TEST_PATTERN:
+			hwss_dp_set_test_pattern(params);
+			break;
+		case LINK_SET_DPMS_OFF:
+			hwss_link_set_dpms_off(params);
+			break;
+		case DISABLE_AUDIO_STREAM:
+			hwss_disable_audio_stream(dc, params);
+			break;
+		case PREPARE_BANDWIDTH:
+			hwss_prepare_bandwidth(dc, params);
+			break;
+		case LINK_SET_DPMS_ON:
+			hwss_link_set_dpms_on(params);
+			break;
 		default:
 			ASSERT(false);
 			break;
@@ -2259,17 +2306,6 @@ void hwss_add_hubp_enable_3dlut_fl(struct block_sequence_state *seq_state,
 	}
 }
 
-void hwss_add_set_dmdata_attributes(struct block_sequence_state *seq_state,
-		struct hubp *hubp, struct dc_dmdata_attributes *attr)
-{
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.set_dmdata_attributes_params.hubp = hubp;
-		seq_state->steps[*seq_state->num_steps].params.set_dmdata_attributes_params.attr = *attr;
-		seq_state->steps[*seq_state->num_steps].func = HUBP_SET_DMDATA_ATTRIBUTES;
-		(*seq_state->num_steps)++;
-	}
-}
-
 void hwss_program_manual_trigger(union block_sequence_params *params)
 {
 	struct pipe_ctx *pipe_ctx = params->program_manual_trigger_params.pipe_ctx;
@@ -2763,25 +2799,6 @@ void hwss_setup_periodic_interrupt(struct dc *dc, union block_sequence_params *p
 		dc->hwss.setup_periodic_interrupt(dc, pipe_ctx);
 }
 
-void hwss_dp_trace_source_sequence(union block_sequence_params *params)
-{
-	struct dc *dc = params->dp_trace_source_sequence_params.dc;
-	struct dc_link *link = params->dp_trace_source_sequence_params.link;
-	uint8_t dp_test_mode = params->dp_trace_source_sequence_params.dp_test_mode;
-
-	if (dc->link_srv->dp_trace_source_sequence)
-		dc->link_srv->dp_trace_source_sequence(link, dp_test_mode);
-}
-
-void hwss_set_dmdata_attributes(union block_sequence_params *params)
-{
-	struct hubp *hubp = params->set_dmdata_attributes_params.hubp;
-	struct dc_dmdata_attributes *attr = &params->set_dmdata_attributes_params.attr;
-
-	if (hubp->funcs->dmdata_set_attributes)
-		hubp->funcs->dmdata_set_attributes(hubp, attr);
-}
-
 void hwss_tg_setup_vertical_interrupt0(union block_sequence_params *params)
 {
 	struct timing_generator *tg = params->tg_setup_vertical_interrupt0_params.tg;
@@ -3616,6 +3633,198 @@ void hwss_phantom_hubp_post_enable(union block_sequence_params *params)
 		hubp->funcs->phantom_hubp_post_enable(hubp);
 }
 
+void hwss_stream_enc_update_hdmi_info_packets(union block_sequence_params *params)
+{
+	if (params->stream_enc_update_hdmi_info_packets_params.pipe_ctx->stream_res.stream_enc &&
+	    params->stream_enc_update_hdmi_info_packets_params.pipe_ctx->stream_res.stream_enc->funcs->update_hdmi_info_packets)
+		params->stream_enc_update_hdmi_info_packets_params.pipe_ctx->stream_res.stream_enc->funcs->update_hdmi_info_packets(
+			params->stream_enc_update_hdmi_info_packets_params.pipe_ctx->stream_res.stream_enc,
+			&params->stream_enc_update_hdmi_info_packets_params.pipe_ctx->stream_res.encoder_info_frame);
+}
+
+void hwss_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(union block_sequence_params *params)
+{
+	if (params->hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx->stream_res.hpo_dp_stream_enc &&
+	    params->hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->update_dp_info_packets_sdp_line_num)
+		params->hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->update_dp_info_packets_sdp_line_num(
+			params->hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx->stream_res.hpo_dp_stream_enc,
+			&params->hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx->stream_res.encoder_info_frame);
+}
+
+void hwss_hpo_dp_stream_enc_update_dp_info_packets(union block_sequence_params *params)
+{
+	if (params->hpo_dp_stream_enc_update_dp_info_packets_params.pipe_ctx->stream_res.hpo_dp_stream_enc &&
+	    params->hpo_dp_stream_enc_update_dp_info_packets_params.pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->update_dp_info_packets)
+		params->hpo_dp_stream_enc_update_dp_info_packets_params.pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->update_dp_info_packets(
+			params->hpo_dp_stream_enc_update_dp_info_packets_params.pipe_ctx->stream_res.hpo_dp_stream_enc,
+			&params->hpo_dp_stream_enc_update_dp_info_packets_params.pipe_ctx->stream_res.encoder_info_frame);
+}
+
+void hwss_stream_enc_update_dp_info_packets_sdp_line_num(union block_sequence_params *params)
+{
+	if (params->stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx->stream_res.stream_enc &&
+	    params->stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx->stream_res.stream_enc->funcs->update_dp_info_packets_sdp_line_num)
+		params->stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx->stream_res.stream_enc->funcs->update_dp_info_packets_sdp_line_num(
+			params->stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx->stream_res.stream_enc,
+			&params->stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx->stream_res.encoder_info_frame);
+}
+
+void hwss_stream_enc_update_dp_info_packets(union block_sequence_params *params)
+{
+	if (params->stream_enc_update_dp_info_packets_params.pipe_ctx->stream_res.stream_enc &&
+	    params->stream_enc_update_dp_info_packets_params.pipe_ctx->stream_res.stream_enc->funcs->update_dp_info_packets)
+		params->stream_enc_update_dp_info_packets_params.pipe_ctx->stream_res.stream_enc->funcs->update_dp_info_packets(
+			params->stream_enc_update_dp_info_packets_params.pipe_ctx->stream_res.stream_enc,
+			&params->stream_enc_update_dp_info_packets_params.pipe_ctx->stream_res.encoder_info_frame);
+}
+
+void hwss_stream_enc_dp_set_dsc_config(union block_sequence_params *params)
+{
+	if (params->stream_enc_dp_set_dsc_config_params.stream_enc &&
+	    params->stream_enc_dp_set_dsc_config_params.stream_enc->funcs->dp_set_dsc_config) {
+		enum optc_dsc_mode dsc_mode = OPTC_DSC_DISABLED;
+		uint32_t dsc_bytes_per_pixel = 0;
+		uint32_t dsc_slice_width = 0;
+		const struct dsc_optc_config *dsc_optc_cfg = params->stream_enc_dp_set_dsc_config_params.dsc_optc_cfg;
+
+		if (dsc_optc_cfg) {
+			dsc_mode = dsc_optc_cfg->is_pixel_format_444 ?
+				OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
+			dsc_bytes_per_pixel = dsc_optc_cfg->bytes_per_pixel;
+			dsc_slice_width = dsc_optc_cfg->slice_width;
+		}
+
+		params->stream_enc_dp_set_dsc_config_params.stream_enc->funcs->dp_set_dsc_config(
+			params->stream_enc_dp_set_dsc_config_params.stream_enc,
+			dsc_mode, dsc_bytes_per_pixel, dsc_slice_width);
+	}
+}
+
+void hwss_hpo_dp_stream_enc_dp_set_dsc_pps_info_packet(union block_sequence_params *params)
+{
+	if (params->hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params.hpo_dp_stream_enc &&
+	    params->hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet)
+		params->hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
+			params->hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params.hpo_dp_stream_enc,
+			params->hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params.immediate_update,
+			params->hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params.dsc_packed_pps,
+			params->hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params.pps_sdp_stream);
+}
+
+void hwss_stream_enc_dp_set_dsc_pps_info_packet(union block_sequence_params *params)
+{
+	if (params->stream_enc_dp_set_dsc_pps_info_packet_params.stream_enc &&
+	    params->stream_enc_dp_set_dsc_pps_info_packet_params.stream_enc->funcs->dp_set_dsc_pps_info_packet)
+		params->stream_enc_dp_set_dsc_pps_info_packet_params.stream_enc->funcs->dp_set_dsc_pps_info_packet(
+			params->stream_enc_dp_set_dsc_pps_info_packet_params.stream_enc,
+			params->stream_enc_dp_set_dsc_pps_info_packet_params.immediate_update,
+			params->stream_enc_dp_set_dsc_pps_info_packet_params.dsc_packed_pps,
+			params->stream_enc_dp_set_dsc_pps_info_packet_params.pps_sdp_stream);
+}
+
+void hwss_set_dmdata_attributes(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->set_dmdata_attributes_params.hubp;
+
+	if (!hubp || !hubp->funcs->dmdata_set_attributes)
+		return;
+
+	hubp->funcs->dmdata_set_attributes(hubp,
+		&params->set_dmdata_attributes_params.attr);
+}
+
+void hwss_dp_trace_source_sequence(union block_sequence_params *params)
+{
+	struct dc_link *link = params->dp_trace_source_sequence_params.link;
+	enum dpcd_source_sequence source = params->dp_trace_source_sequence_params.source;
+
+	if (link && link->dc && link->dc->link_srv && link->dc->link_srv->dp_trace_source_sequence)
+		link->dc->link_srv->dp_trace_source_sequence(link, source);
+}
+
+void hwss_link_increase_mst_payload(union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->link_increase_mst_payload_params.pipe_ctx;
+	uint32_t mst_stream_bw = params->link_increase_mst_payload_params.mst_stream_bw;
+
+	if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link &&
+		pipe_ctx->stream->link->dc && pipe_ctx->stream->link->dc->link_srv &&
+		pipe_ctx->stream->link->dc->link_srv->increase_mst_payload)
+		pipe_ctx->stream->link->dc->link_srv->increase_mst_payload(pipe_ctx, mst_stream_bw);
+}
+
+void hwss_link_reduce_mst_payload(union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->link_reduce_mst_payload_params.pipe_ctx;
+	uint32_t mst_stream_bw = params->link_reduce_mst_payload_params.mst_stream_bw;
+
+	if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link &&
+		pipe_ctx->stream->link->dc && pipe_ctx->stream->link->dc->link_srv &&
+		pipe_ctx->stream->link->dc->link_srv->reduce_mst_payload)
+		pipe_ctx->stream->link->dc->link_srv->reduce_mst_payload(pipe_ctx, mst_stream_bw);
+}
+
+void hwss_dp_set_test_pattern(union block_sequence_params *params)
+{
+	struct dc_link *link = params->dp_set_test_pattern_params.link;
+	enum dp_test_pattern test_pattern = params->dp_set_test_pattern_params.test_pattern;
+	enum dp_test_pattern_color_space test_pattern_color_space =
+	params->dp_set_test_pattern_params.test_pattern_color_space;
+	const struct link_training_settings *p_link_settings =
+	params->dp_set_test_pattern_params.p_link_settings;
+	const unsigned char *p_custom_pattern = params->dp_set_test_pattern_params.p_custom_pattern;
+	unsigned int cust_pattern_size = params->dp_set_test_pattern_params.cust_pattern_size;
+
+	if (link && link->dc && link->dc->link_srv && link->dc->link_srv->dp_set_test_pattern)
+		link->dc->link_srv->dp_set_test_pattern(link, test_pattern, test_pattern_color_space,
+			p_link_settings, p_custom_pattern, cust_pattern_size);
+}
+
+void hwss_link_set_dpms_off(union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->link_set_dpms_off_params.pipe_ctx;
+
+	if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link &&
+	    pipe_ctx->stream->link->dc && pipe_ctx->stream->link->dc->link_srv &&
+	    pipe_ctx->stream->link->dc->link_srv->set_dpms_off)
+		pipe_ctx->stream->link->dc->link_srv->set_dpms_off(pipe_ctx);
+}
+
+void hwss_disable_audio_stream(struct dc *dc, union block_sequence_params *params)
+{
+	if (dc->hwss.disable_audio_stream)
+		dc->hwss.disable_audio_stream(
+			params->disable_audio_stream_params.pipe_ctx);
+}
+
+void hwss_prepare_bandwidth(struct dc *dc, union block_sequence_params *params)
+{
+	if (dc && dc->hwss.prepare_bandwidth)
+		dc->hwss.prepare_bandwidth(dc,
+			params->prepare_bandwidth_params.context);
+}
+
+void hwss_link_set_dpms_on(union block_sequence_params *params)
+{
+	struct dc_state *state = params->link_set_dpms_on_params.state;
+	struct pipe_ctx *pipe_ctx = params->link_set_dpms_on_params.pipe_ctx;
+
+	if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link &&
+	    pipe_ctx->stream->link->dc && pipe_ctx->stream->link->dc->link_srv &&
+	    pipe_ctx->stream->link->dc->link_srv->set_dpms_on)
+		pipe_ctx->stream->link->dc->link_srv->set_dpms_on(state, pipe_ctx);
+}
+
+void hwss_dsc_set_config_simple(union block_sequence_params *params)
+{
+	struct display_stream_compressor *dsc = params->dsc_set_config_simple_params.dsc;
+	struct dsc_config *dsc_cfg = &params->dsc_set_config_simple_params.dsc_cfg;
+	struct dsc_optc_config *dsc_optc_cfg = &params->dsc_set_config_simple_params.dsc_optc_cfg;
+
+	if (dsc && dsc->funcs && dsc->funcs->dsc_set_config)
+		dsc->funcs->dsc_set_config(dsc, dsc_cfg, dsc_optc_cfg);
+}
+
 void hwss_add_dccg_set_dto_dscclk(struct block_sequence_state *seq_state,
 		struct dccg *dccg, int inst, int num_slices_h)
 {
@@ -4580,6 +4789,313 @@ void hwss_add_tg_get_frame_count(struct block_sequence_state *seq_state,
 	}
 }
 
+void hwss_add_begin_cursor_offload_update(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HWSS_BEGIN_CURSOR_OFFLOAD_UPDATE;
+		seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_cursor_lock(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool lock)
+{
+	/* cursor lock is per MPCC tree, so only need to lock one pipe per stream */
+	if (!pipe_ctx || pipe_ctx->top_pipe)
+		return;
+
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HWSS_CURSOR_LOCK;
+		seq_state->steps[*seq_state->num_steps].params.cursor_lock_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.cursor_lock_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.cursor_lock_params.lock = lock;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_send_update_cursor_info_to_dmu(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx,
+		int index)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DC_SEND_CURSOR_INFO_TO_DMU;
+		seq_state->steps[*seq_state->num_steps].params.send_cursor_info_to_dmu_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.send_cursor_info_to_dmu_params.pipe_idx = index;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_update_cursor_offload_pipe(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HWSS_UPDATE_CURSOR_OFFLOAD_PIPE;
+		seq_state->steps[*seq_state->num_steps].params.update_cursor_offload_pipe_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.update_cursor_offload_pipe_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_commit_cursor_offload_update(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HWSS_COMMIT_CURSOR_OFFLOAD_UPDATE;
+		seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_stream_enc_update_hdmi_info_packets(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = STREAM_ENC_UPDATE_HDMI_INFO_PACKETS;
+		seq_state->steps[*seq_state->num_steps].params.stream_enc_update_hdmi_info_packets_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HPO_DP_STREAM_ENC_UPDATE_DP_INFO_PACKETS_SDP_LINE_NUM;
+		seq_state->steps[*seq_state->num_steps].params.hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hpo_dp_stream_enc_update_dp_info_packets(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HPO_DP_STREAM_ENC_UPDATE_DP_INFO_PACKETS;
+		seq_state->steps[*seq_state->num_steps].params.hpo_dp_stream_enc_update_dp_info_packets_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_stream_enc_update_dp_info_packets_sdp_line_num(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = STREAM_ENC_UPDATE_DP_INFO_PACKETS_SDP_LINE_NUM;
+		seq_state->steps[*seq_state->num_steps].params.stream_enc_update_dp_info_packets_sdp_line_num_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_stream_enc_update_dp_info_packets(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = STREAM_ENC_UPDATE_DP_INFO_PACKETS;
+		seq_state->steps[*seq_state->num_steps].params.stream_enc_update_dp_info_packets_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dsc_set_config(struct block_sequence_state *seq_state,
+		struct display_stream_compressor *dsc,
+		const struct dsc_config *dsc_cfg,
+		const struct dsc_optc_config *dsc_optc_cfg)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DSC_SET_CONFIG_SIMPLE;
+		seq_state->steps[*seq_state->num_steps].params.dsc_set_config_simple_params.dsc = dsc;
+		seq_state->steps[*seq_state->num_steps].params.dsc_set_config_simple_params.dsc_cfg = *dsc_cfg;
+		seq_state->steps[*seq_state->num_steps].params.dsc_set_config_simple_params.dsc_optc_cfg = *dsc_optc_cfg;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_stream_enc_dp_set_dsc_config(struct block_sequence_state *seq_state,
+		struct stream_encoder *stream_enc,
+		const struct dsc_optc_config *dsc_optc_cfg)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = STREAM_ENC_DP_SET_DSC_CONFIG;
+		seq_state->steps[*seq_state->num_steps].params.stream_enc_dp_set_dsc_config_params.stream_enc = stream_enc;
+		seq_state->steps[*seq_state->num_steps].params.stream_enc_dp_set_dsc_config_params.dsc_optc_cfg = dsc_optc_cfg;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hpo_dp_stream_enc_dp_set_dsc_pps_info_packet(struct block_sequence_state *seq_state,
+		struct hpo_dp_stream_encoder *hpo_dp_stream_enc,
+		bool immediate_update,
+		uint8_t *dsc_packed_pps,
+		bool pps_sdp_stream)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HPO_DP_STREAM_ENC_DP_SET_DSC_PPS_INFO_PACKET;
+		seq_state->steps[*seq_state->num_steps].params.hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params.hpo_dp_stream_enc = hpo_dp_stream_enc;
+		seq_state->steps[*seq_state->num_steps].params.hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params.immediate_update = immediate_update;
+		seq_state->steps[*seq_state->num_steps].params.hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params.dsc_packed_pps = dsc_packed_pps;
+		seq_state->steps[*seq_state->num_steps].params.hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params.pps_sdp_stream = pps_sdp_stream;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_stream_enc_dp_set_dsc_pps_info_packet(struct block_sequence_state *seq_state,
+		struct stream_encoder *stream_enc,
+		bool immediate_update,
+		uint8_t *dsc_packed_pps,
+		bool pps_sdp_stream)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = STREAM_ENC_DP_SET_DSC_PPS_INFO_PACKET;
+		seq_state->steps[*seq_state->num_steps].params.stream_enc_dp_set_dsc_pps_info_packet_params.stream_enc = stream_enc;
+		seq_state->steps[*seq_state->num_steps].params.stream_enc_dp_set_dsc_pps_info_packet_params.immediate_update = immediate_update;
+		seq_state->steps[*seq_state->num_steps].params.stream_enc_dp_set_dsc_pps_info_packet_params.dsc_packed_pps = dsc_packed_pps;
+		seq_state->steps[*seq_state->num_steps].params.stream_enc_dp_set_dsc_pps_info_packet_params.pps_sdp_stream = pps_sdp_stream;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_setup_periodic_interrupt(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HWSS_SETUP_PERIODIC_INTERRUPT;
+		seq_state->steps[*seq_state->num_steps].params.setup_periodic_interrupt_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.setup_periodic_interrupt_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dp_trace_source_sequence(struct block_sequence_state *seq_state,
+		struct dc_link *link,
+		enum dpcd_source_sequence source)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DP_TRACE_SOURCE_SEQUENCE;
+		seq_state->steps[*seq_state->num_steps].params.dp_trace_source_sequence_params.link = link;
+		seq_state->steps[*seq_state->num_steps].params.dp_trace_source_sequence_params.source = source;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_set_dmdata_attributes(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		struct dc_dmdata_attributes *attr =
+			&seq_state->steps[*seq_state->num_steps].params.set_dmdata_attributes_params.attr;
+
+		memset(attr, 0, sizeof(*attr));
+		attr->dmdata_mode = DMDATA_HW_MODE;
+		attr->dmdata_size = dc_is_hdmi_signal(pipe_ctx->stream->signal) ? 32 : 36;
+		attr->address.quad_part = pipe_ctx->stream->dmdata_address.quad_part;
+		attr->dmdata_repeat = 1; /* always repeat */
+		attr->dmdata_updated = 1;
+
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SET_DMDATA_ATTRIBUTES;
+		seq_state->steps[*seq_state->num_steps].params.set_dmdata_attributes_params.hubp =
+			pipe_ctx->plane_res.hubp;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_link_increase_mst_payload(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx,
+		uint32_t mst_stream_bw)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = LINK_INCREASE_MST_PAYLOAD;
+		seq_state->steps[*seq_state->num_steps].params.link_increase_mst_payload_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.link_increase_mst_payload_params.mst_stream_bw = mst_stream_bw;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_link_reduce_mst_payload(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx,
+		uint32_t mst_stream_bw)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = LINK_REDUCE_MST_PAYLOAD;
+		seq_state->steps[*seq_state->num_steps].params.link_reduce_mst_payload_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.link_reduce_mst_payload_params.mst_stream_bw = mst_stream_bw;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dp_set_test_pattern(struct block_sequence_state *seq_state,
+		struct dc_link *link,
+		enum dp_test_pattern test_pattern,
+		enum dp_test_pattern_color_space test_pattern_color_space,
+		const struct link_training_settings *p_link_settings,
+		const unsigned char *p_custom_pattern,
+		unsigned int cust_pattern_size)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DP_SET_TEST_PATTERN;
+		seq_state->steps[*seq_state->num_steps].params.dp_set_test_pattern_params.link = link;
+		seq_state->steps[*seq_state->num_steps].params.dp_set_test_pattern_params.test_pattern = test_pattern;
+		seq_state->steps[*seq_state->num_steps].params.dp_set_test_pattern_params.test_pattern_color_space = test_pattern_color_space;
+		seq_state->steps[*seq_state->num_steps].params.dp_set_test_pattern_params.p_link_settings = p_link_settings;
+		seq_state->steps[*seq_state->num_steps].params.dp_set_test_pattern_params.p_custom_pattern = p_custom_pattern;
+		seq_state->steps[*seq_state->num_steps].params.dp_set_test_pattern_params.cust_pattern_size = cust_pattern_size;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_link_set_dpms_off(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = LINK_SET_DPMS_OFF;
+		seq_state->steps[*seq_state->num_steps].params.link_set_dpms_off_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_disable_audio_stream(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DISABLE_AUDIO_STREAM;
+		seq_state->steps[*seq_state->num_steps].params.disable_audio_stream_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_prepare_bandwidth(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct dc_state *context)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = PREPARE_BANDWIDTH;
+		seq_state->steps[*seq_state->num_steps].params.prepare_bandwidth_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.prepare_bandwidth_params.context = context;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_link_set_dpms_on(struct block_sequence_state *seq_state,
+		struct dc_state *state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = LINK_SET_DPMS_ON;
+		seq_state->steps[*seq_state->num_steps].params.link_set_dpms_on_params.state = state;
+		seq_state->steps[*seq_state->num_steps].params.link_set_dpms_on_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
 
 void get_refresh_rate_confirm_color(struct pipe_ctx *pipe_ctx, struct tg_color *color)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 1cb2be00bf72..7f0743de1b14 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -33,6 +33,7 @@
 #include "inc/core_status.h"
 #include "inc/hw/hw_shared.h"
 #include "dsc/dsc.h"
+#include "link_service_types.h"
 
 struct pipe_ctx;
 struct dc_state;
@@ -53,6 +54,12 @@ struct dc_underflow_debug_data;
 struct dsc_optc_config;
 struct vm_system_aperture_param;
 struct memory_qos;
+struct stream_encoder;
+struct hpo_dp_stream_encoder;
+struct hpo_frl_stream_encoder;
+struct link_training_settings;
+struct dc_link;
+struct dc_crtc_timing;
 struct subvp_pipe_control_lock_fast_params {
 	struct dc *dc;
 	bool lock;
@@ -106,22 +113,6 @@ struct update_info_frame_params {
 	struct pipe_ctx *pipe_ctx;
 };
 
-struct setup_periodic_interrupt_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
-};
-
-struct dp_trace_source_sequence_params {
-	struct dc *dc;
-	struct dc_link *link;
-	uint8_t dp_test_mode;
-};
-
-struct set_dmdata_attributes_params {
-	struct hubp *hubp;
-	struct dc_dmdata_attributes attr;
-};
-
 struct program_manual_trigger_params {
 	struct pipe_ctx *pipe_ctx;
 };
@@ -744,17 +735,7 @@ struct cursor_lock_params {
 	bool lock;
 };
 
-struct begin_cursor_offload_update_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
-};
-
-struct commit_cursor_offload_update_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
-};
-
-struct update_cursor_offload_pipe_params {
+struct setup_periodic_interrupt_params {
 	struct dc *dc;
 	struct pipe_ctx *pipe_ctx;
 };
@@ -806,6 +787,113 @@ struct phantom_hubp_post_enable_params {
 	struct hubp *hubp;
 };
 
+struct begin_cursor_offload_update_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct update_cursor_offload_pipe_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct commit_cursor_offload_update_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct stream_enc_update_hdmi_info_packets_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct hpo_dp_stream_enc_update_dp_info_packets_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct stream_enc_update_dp_info_packets_sdp_line_num_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct stream_enc_update_dp_info_packets_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct dsc_set_config_simple_params {
+	struct display_stream_compressor *dsc;
+	struct dsc_config dsc_cfg;
+	struct dsc_optc_config dsc_optc_cfg;
+};
+
+struct stream_enc_dp_set_dsc_config_params {
+	struct stream_encoder *stream_enc;
+	const struct dsc_optc_config *dsc_optc_cfg;
+};
+
+struct hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params {
+	struct hpo_dp_stream_encoder *hpo_dp_stream_enc;
+	bool immediate_update;
+	uint8_t *dsc_packed_pps;
+	bool pps_sdp_stream;
+};
+
+struct stream_enc_dp_set_dsc_pps_info_packet_params {
+	struct stream_encoder *stream_enc;
+	bool immediate_update;
+	uint8_t *dsc_packed_pps;
+	bool pps_sdp_stream;
+};
+
+struct dp_trace_source_sequence_params {
+	struct dc_link *link;
+	enum dpcd_source_sequence source;
+};
+
+struct set_dmdata_attributes_params {
+	struct hubp *hubp;
+	struct dc_dmdata_attributes attr;
+};
+
+struct link_increase_mst_payload_params {
+	struct pipe_ctx *pipe_ctx;
+	uint32_t mst_stream_bw;
+};
+
+struct link_reduce_mst_payload_params {
+	struct pipe_ctx *pipe_ctx;
+	uint32_t mst_stream_bw;
+};
+
+struct dp_set_test_pattern_params {
+	struct dc_link *link;
+	enum dp_test_pattern test_pattern;
+	enum dp_test_pattern_color_space test_pattern_color_space;
+	const struct link_training_settings *p_link_settings;
+	const unsigned char *p_custom_pattern;
+	unsigned int cust_pattern_size;
+};
+
+struct link_set_dpms_off_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct disable_audio_stream_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct prepare_bandwidth_params {
+	struct dc *dc;
+	struct dc_state *context;
+};
+
+struct link_set_dpms_on_params {
+	struct dc_state *state;
+	struct pipe_ctx *pipe_ctx;
+};
+
 union block_sequence_params {
 	struct update_plane_addr_params update_plane_addr_params;
 	struct subvp_pipe_control_lock_fast_params subvp_pipe_control_lock_fast_params;
@@ -817,9 +905,6 @@ union block_sequence_params {
 	struct hubp_enable_3dlut_fl_params hubp_enable_3dlut_fl_params;
 	struct tg_setup_vertical_interrupt0_params tg_setup_vertical_interrupt0_params;
 	struct update_info_frame_params update_info_frame_params;
-	struct setup_periodic_interrupt_params setup_periodic_interrupt_params;
-	struct dp_trace_source_sequence_params dp_trace_source_sequence_params;
-	struct set_dmdata_attributes_params set_dmdata_attributes_params;
 	struct program_manual_trigger_params program_manual_trigger_params;
 	struct send_dmcub_cmd_params send_dmcub_cmd_params;
 	struct setup_dpp_params setup_dpp_params;
@@ -929,9 +1014,7 @@ union block_sequence_params {
 	struct hubp_mem_program_viewport_params hubp_mem_program_viewport_params;
 	struct abort_cursor_offload_update_params abort_cursor_offload_update_params;
 	struct cursor_lock_params cursor_lock_params;
-	struct begin_cursor_offload_update_params begin_cursor_offload_update_params;
-	struct commit_cursor_offload_update_params commit_cursor_offload_update_params;
-	struct update_cursor_offload_pipe_params update_cursor_offload_pipe_params;
+	struct setup_periodic_interrupt_params setup_periodic_interrupt_params;
 	struct send_cursor_info_to_dmu_params send_cursor_info_to_dmu_params;
 	struct set_cursor_attribute_params set_cursor_attribute_params;
 	struct hubp_set_cursor_attributes_params hubp_set_cursor_attributes_params;
@@ -941,6 +1024,27 @@ union block_sequence_params {
 	struct program_output_csc_params program_output_csc_params;
 	struct hubp_set_blank_params hubp_set_blank_params;
 	struct phantom_hubp_post_enable_params phantom_hubp_post_enable_params;
+	struct begin_cursor_offload_update_params begin_cursor_offload_update_params;
+	struct update_cursor_offload_pipe_params update_cursor_offload_pipe_params;
+	struct commit_cursor_offload_update_params commit_cursor_offload_update_params;
+	struct stream_enc_update_hdmi_info_packets_params stream_enc_update_hdmi_info_packets_params;
+	struct hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params;
+	struct hpo_dp_stream_enc_update_dp_info_packets_params hpo_dp_stream_enc_update_dp_info_packets_params;
+	struct stream_enc_update_dp_info_packets_sdp_line_num_params stream_enc_update_dp_info_packets_sdp_line_num_params;
+	struct stream_enc_update_dp_info_packets_params stream_enc_update_dp_info_packets_params;
+	struct dsc_set_config_simple_params dsc_set_config_simple_params;
+	struct stream_enc_dp_set_dsc_config_params stream_enc_dp_set_dsc_config_params;
+	struct hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params;
+	struct stream_enc_dp_set_dsc_pps_info_packet_params stream_enc_dp_set_dsc_pps_info_packet_params;
+	struct dp_trace_source_sequence_params dp_trace_source_sequence_params;
+	struct set_dmdata_attributes_params set_dmdata_attributes_params;
+	struct link_increase_mst_payload_params link_increase_mst_payload_params;
+	struct link_reduce_mst_payload_params link_reduce_mst_payload_params;
+	struct dp_set_test_pattern_params dp_set_test_pattern_params;
+	struct link_set_dpms_off_params link_set_dpms_off_params;
+	struct disable_audio_stream_params disable_audio_stream_params;
+	struct prepare_bandwidth_params prepare_bandwidth_params;
+	struct link_set_dpms_on_params link_set_dpms_on_params;
 };
 
 enum block_sequence_func {
@@ -955,7 +1059,6 @@ enum block_sequence_func {
 	OTG_SETUP_VERTICAL_INTERRUPT,
 	HWSS_SETUP_PERIODIC_INTERRUPT,
 	HWSS_UPDATE_INFO_FRAME,
-	DP_TRACE_SOURCE_SEQUENCE,
 	HUBP_SET_DMDATA_ATTRIBUTES,
 	OPTC_PROGRAM_MANUAL_TRIGGER,
 	DMUB_SEND_DMCUB_CMD,
@@ -1075,6 +1178,23 @@ enum block_sequence_func {
 	HUBP_SET_LEGACY_TILING_COMPAT_LEVEL,
 	HUBP_SET_BLANK,
 	PHANTOM_HUBP_POST_ENABLE,
+	STREAM_ENC_UPDATE_HDMI_INFO_PACKETS,
+	HPO_DP_STREAM_ENC_UPDATE_DP_INFO_PACKETS_SDP_LINE_NUM,
+	HPO_DP_STREAM_ENC_UPDATE_DP_INFO_PACKETS,
+	STREAM_ENC_UPDATE_DP_INFO_PACKETS_SDP_LINE_NUM,
+	STREAM_ENC_UPDATE_DP_INFO_PACKETS,
+	DSC_SET_CONFIG_SIMPLE,
+	STREAM_ENC_DP_SET_DSC_CONFIG,
+	HPO_DP_STREAM_ENC_DP_SET_DSC_PPS_INFO_PACKET,
+	STREAM_ENC_DP_SET_DSC_PPS_INFO_PACKET,
+	LINK_INCREASE_MST_PAYLOAD,
+	LINK_REDUCE_MST_PAYLOAD,
+	DP_TRACE_SOURCE_SEQUENCE,
+	DP_SET_TEST_PATTERN,
+	LINK_SET_DPMS_OFF,
+	DISABLE_AUDIO_STREAM,
+	PREPARE_BANDWIDTH,
+	LINK_SET_DPMS_ON,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
@@ -1548,6 +1668,40 @@ void hwss_dsc_calculate_and_set_config(union block_sequence_params *params);
 
 void hwss_dsc_enable_with_opp(union block_sequence_params *params);
 
+void hwss_dsc_set_config_simple(union block_sequence_params *params);
+
+void hwss_stream_enc_update_hdmi_info_packets(union block_sequence_params *params);
+
+void hwss_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(union block_sequence_params *params);
+
+void hwss_hpo_dp_stream_enc_update_dp_info_packets(union block_sequence_params *params);
+
+void hwss_stream_enc_update_dp_info_packets_sdp_line_num(union block_sequence_params *params);
+
+void hwss_stream_enc_update_dp_info_packets(union block_sequence_params *params);
+
+void hwss_stream_enc_dp_set_dsc_config(union block_sequence_params *params);
+
+void hwss_hpo_dp_stream_enc_dp_set_dsc_pps_info_packet(union block_sequence_params *params);
+
+void hwss_stream_enc_dp_set_dsc_pps_info_packet(union block_sequence_params *params);
+
+void hwss_set_dmdata_attributes(union block_sequence_params *params);
+
+void hwss_dp_trace_source_sequence(union block_sequence_params *params);
+
+void hwss_link_increase_mst_payload(union block_sequence_params *params);
+
+void hwss_link_reduce_mst_payload(union block_sequence_params *params);
+
+void hwss_dp_set_test_pattern(union block_sequence_params *params);
+
+void hwss_link_set_dpms_off(union block_sequence_params *params);
+
+void hwss_prepare_bandwidth(struct dc *dc, union block_sequence_params *params);
+
+void hwss_link_set_dpms_on(union block_sequence_params *params);
+
 void hwss_program_tg(union block_sequence_params *params);
 
 void hwss_tg_program_global_sync(union block_sequence_params *params);
@@ -1560,12 +1714,6 @@ void hwss_hubp_enable_3dlut_fl(union block_sequence_params *params);
 
 void hwss_update_info_frame(struct dc *dc, union block_sequence_params *params);
 
-void hwss_setup_periodic_interrupt(struct dc *dc, union block_sequence_params *params);
-
-void hwss_dp_trace_source_sequence(union block_sequence_params *params);
-
-void hwss_set_dmdata_attributes(union block_sequence_params *params);
-
 void hwss_tg_setup_vertical_interrupt0(union block_sequence_params *params);
 
 void hwss_tg_setup_vertical_interrupt2(union block_sequence_params *params);
@@ -1708,14 +1856,6 @@ void hwss_hubp_mem_program_viewport(union block_sequence_params *params);
 
 void hwss_abort_cursor_offload_update(union block_sequence_params *params);
 
-void hwss_cursor_lock(union block_sequence_params *params);
-
-void hwss_begin_cursor_offload_update(union block_sequence_params *params);
-
-void hwss_commit_cursor_offload_update(union block_sequence_params *params);
-
-void hwss_update_cursor_offload_pipe(union block_sequence_params *params);
-
 void hwss_send_cursor_info_to_dmu(union block_sequence_params *params);
 
 void hwss_set_cursor_attribute(union block_sequence_params *params);
@@ -1738,6 +1878,18 @@ void hwss_hubp_set_blank(union block_sequence_params *params);
 
 void hwss_phantom_hubp_post_enable(union block_sequence_params *params);
 
+void hwss_cursor_lock(union block_sequence_params *params);
+
+void hwss_begin_cursor_offload_update(union block_sequence_params *params);
+
+void hwss_commit_cursor_offload_update(union block_sequence_params *params);
+
+void hwss_update_cursor_offload_pipe(union block_sequence_params *params);
+
+void hwss_setup_periodic_interrupt(struct dc *dc, union block_sequence_params *params);
+
+void hwss_disable_audio_stream(struct dc *dc, union block_sequence_params *params);
+
 void hwss_add_optc_pipe_control_lock(struct block_sequence_state *seq_state,
 		struct dc *dc, struct pipe_ctx *pipe_ctx, bool lock);
 
@@ -2191,7 +2343,102 @@ void hwss_add_opp_program_left_edge_extra_pixel(struct block_sequence_state *seq
 void hwss_add_hubp_enable_3dlut_fl(struct block_sequence_state *seq_state,
 		struct hubp *hubp);
 
+void hwss_add_begin_cursor_offload_update(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_cursor_lock(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool lock);
+
+void hwss_add_send_update_cursor_info_to_dmu(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx,
+		int index);
+
+void hwss_add_update_cursor_offload_pipe(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_commit_cursor_offload_update(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_stream_enc_update_hdmi_info_packets(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_hpo_dp_stream_enc_update_dp_info_packets(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_stream_enc_update_dp_info_packets_sdp_line_num(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_stream_enc_update_dp_info_packets(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_dsc_set_config(struct block_sequence_state *seq_state,
+		struct display_stream_compressor *dsc,
+		const struct dsc_config *dsc_cfg,
+		const struct dsc_optc_config *dsc_optc_cfg);
+
+void hwss_add_stream_enc_dp_set_dsc_config(struct block_sequence_state *seq_state,
+		struct stream_encoder *stream_enc,
+		const struct dsc_optc_config *dsc_optc_cfg);
+
+void hwss_add_hpo_dp_stream_enc_dp_set_dsc_pps_info_packet(struct block_sequence_state *seq_state,
+		struct hpo_dp_stream_encoder *hpo_dp_stream_enc,
+		bool immediate_update,
+		uint8_t *dsc_packed_pps,
+		bool pps_sdp_stream);
+
+void hwss_add_stream_enc_dp_set_dsc_pps_info_packet(struct block_sequence_state *seq_state,
+		struct stream_encoder *stream_enc,
+		bool immediate_update,
+		uint8_t *dsc_packed_pps,
+		bool pps_sdp_stream);
+
+void hwss_add_setup_periodic_interrupt(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_dp_trace_source_sequence(struct block_sequence_state *seq_state,
+		struct dc_link *link,
+		enum dpcd_source_sequence source);
+
 void hwss_add_set_dmdata_attributes(struct block_sequence_state *seq_state,
-		struct hubp *hubp, struct dc_dmdata_attributes *attr);
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_link_increase_mst_payload(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx,
+		uint32_t mst_stream_bw);
+
+void hwss_add_link_reduce_mst_payload(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx,
+		uint32_t mst_stream_bw);
+
+void hwss_add_dp_set_test_pattern(struct block_sequence_state *seq_state,
+		struct dc_link *link,
+		enum dp_test_pattern test_pattern,
+		enum dp_test_pattern_color_space test_pattern_color_space,
+		const struct link_training_settings *p_link_settings,
+		const unsigned char *p_custom_pattern,
+		unsigned int cust_pattern_size);
+
+void hwss_add_link_set_dpms_off(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_disable_audio_stream(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_prepare_bandwidth(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct dc_state *context);
+
+void hwss_add_link_set_dpms_on(struct block_sequence_state *seq_state,
+		struct dc_state *state,
+		struct pipe_ctx *pipe_ctx);
 
 #endif /* __DC_HW_SEQUENCER_H__ */
-- 
2.54.0

