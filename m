Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D608C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC80110ECA8;
	Tue, 11 Aug 2026 15:48:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VuO4A2Qq";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1746310EC97
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:48:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZKXY6r/crYmD2OwKBn6btcUpTiD1BFu3eWDNqfWrn/LI5dpOIBmDXnvYQdvPZGccWK7JaLu9BP7ZU1a5VGEXX0c+aE6Xlmmqr08H5AALxMaGIwZMsFr+JTtI13zrK8BXTsoH5YwSybJccDT8rBDb6pKor+qBoi0M6X8XlGLLWmWoo5rwcNxZJiHSjLHW2nIgQ7wTPTAl3+dqWb1SIAm0XWevMrGDvdkLXZUZYsOe2zjsVvx9s+0Tsa++6Uch7DRdrcT41U86S/09eJ8J/QfebnjFc6qUFQ36Lf4XxmAOySSbJeaS2hW59ECdUbe425rmuT603ssH8ZPEzOri9EhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui3sefNo4qEOV/ajcUxjwMAMXIlJvQa0tJFEzxrZy7s=;
 b=NMy/BLJeRxbFi5HDqNA9qjOAGtepkJFahOrBgeGp3ji6m7MNAUWXFmWpdei1azsa8tF1gcEXsnnzH//fhLTQwV/eYH32H9R5LRRLWJBBDYxnDIMp0JtHeXs5oxDcv73BbM+caA0Ua1wYrSdNAymqzggtIJtq09sUTEMzVB+/rGytZ2V50ifCqA9fEbkpfxEK2Qx5rRDCwr9mnR8AEjxqZCSH4sI/6xw40CiB7gg8hLy51fcC+qCiCChbmz2f9vBLSAOvjp9XPZdz2ailqYD1G9TW39gshPdufRjQUvIeuYB/9CPbo6ldWNmiGh4FDcdfC8ozSAoPjwD7xdXo61uYnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui3sefNo4qEOV/ajcUxjwMAMXIlJvQa0tJFEzxrZy7s=;
 b=VuO4A2QqWFF6moncwl2Lp1h7raq6cOn3KSvnygJiOfpL3hiYuu31AymKh6LYryBc6gCdELV4YQhfMKZ4znyT0dbDOD9qBXaN75lIN3JvCHnTBH5vFYXRItmdsc/B42/zNCyi/Ix70ZNh25Wowfr5Q2oAtJzp2qd3gqJHR1x3B30=
Received: from CH0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:610:119::26)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:48:35 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::5c) by CH0PR03CA0384.outlook.office365.com
 (2603:10b6:610:119::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 15:48:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:48:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:48:28 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:48:19 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 02/24] drm/amd/display: Move periodic interrupt calculations
 to HWSS
Date: Tue, 11 Aug 2026 05:28:36 +0800
Message-ID: <20260810213010.1703162-3-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e108d73-ae8c-483c-bbdd-08def7c00064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|18002099003|22082099003|11063799006|10067099003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 4AJ6RgCTxTiEM3h4zW5vDLH/MXALUCV0j2Z7PF4+r2vD4iAm9l/NsftOQ10/OhWuMVn5XY58/vlkYjuGr2Ee2p9z/rWzLv2MKuZ0dQuOX9qlzna4ckuT5yYOYcL+Rcbqhml/q9ESszP8pKefjTL8XNWX46l/m1PUWpaFoZ01i9xid4BEhQkFcPGYS8iu6FcepwXjI9vudlpC2ww/Ku4MwqX76RUMqCLoCngOfchtXFkqvW4eWuZKdMq53LWjECTNSIFc4XqpMXp48c97+mYIA6v7uAI0GLIX9I4jkFvKYmh+nv0Z8bZr4oTXtbYzXTzwxu9Y0LLBD1g60dv1tnXQA0OfTIWdsRKXd6bwKKDxEaQVJm+PgLKT+EzVKJU9tENDO0qHHb4o9OvuA1UT4jDWRnhuEXl5coGCs+QKLqFU7mrqggmdcogNcvyOBuz59weHeJvXWoiRWV+F2S1Eq0ElEU19OfTra2+eLKhlPRZHHwFPjqVHmmng6oJE34jCmsjGAMkOOWF7QNmETgJx080nUx7MG9crcmpcXjPeeffqvu3ZDwPKVIgMZg2YubJ+Sf6/oDqqE8RDES/uAShY4Vk2Iv5eu4sBu/jg4DjL3bJI3dAiDWXi7mDBfWifiKu0U8AWEzk7xMDL67VJTzGPbw85LPExmf6g3hrgLmffzrlaqk/hDC6qSWdTZKaQx0xNk9nXt6sSa6ylw6y/YqLRHaeaEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aQSYYMrd97tox752+PRxqXadxhNlZ1xnHkHvjGFcOyE3rrPo20vUpOVN/pZ8dfDMs6CJaXFIFlKwVRBLqI1NgIfNjiTOUFQLS8xCdpw0TWjADK1650IxVFESOhD72cfGgf5G8KcdCeb64TH5MxEtvZdAEKAbOoxhc0p0Z4IdnB4tyOW5pLO1VY0QXKEDp3met93RM2cZmhQAzzOvt7mEXeEc29VE5wZqy+YeGIrF+r2TO0m14P6cDlY3CpjPyExUiVhXLFJ4LySYgWiiYYhkWUZHgq47aJ3BvkqLlE0Nv9s8LKjL0a7+m+3Sg860X9xT4dN1KpfhIQGCSFWF3RfOS+kJHxBLZm2/9tBswA79WxvWcdKRl7GDjRMHL/G1ZMDe1yA/p11znmegsuapJeKeAurCNAUg1sPd+FG4Yh4a2bmYPh0WDqN2WTHK/Rk8UHHS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:48:34.5021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e108d73-ae8c-483c-bbdd-08def7c00064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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

From: Tomasz Siemek <tomasz.siemek@amd.com>

[why]
Periodic interrupt line calculations depends on stream and pipe state, not
ASIC-specific register programming. Keeping it in the DCN10 implementation
also prevents block-sequence callers from carrying fully resolved
parameters.
We want HWSS block parameters to not include complex structures like
pipe_ctx.

[how]
- Move the vertical interrupt line calculation into common HWSS code.
- Update the periodic interrupt callback.
- Calculate the values before direct or block-sequence execution.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 76 ++++++++++++++++---
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 41 +---------
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  5 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 12 +--
 5 files changed, 83 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 68f228014305..bc2207d29954 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4367,8 +4367,8 @@ static void commit_planes_do_stream_update(struct dc *dc,
 
 		if (resource_is_pipe_type(pipe_ctx, OTG_MASTER) && pipe_ctx->stream == stream) {
 
-			if (stream_update->periodic_interrupt && dc->hwss.setup_periodic_interrupt)
-				dc->hwss.setup_periodic_interrupt(dc, pipe_ctx);
+			if (stream_update->periodic_interrupt)
+				hwss_setup_periodic_interrupt(dc, pipe_ctx);
 
 			if ((stream_update->hdr_static_metadata && !stream->use_dynamic_meta) ||
 					stream_update->vrr_infopacket ||
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 90d754d192f1..bfb598a22c26 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -745,6 +745,38 @@ static bool get_update_dchubp_dpp_flags_status(struct pipe_ctx *pipe)
 	return false;
 }
 
+static void calc_vline_position(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		uint32_t *start_line,
+		uint32_t *end_line)
+{
+	if (!dc->hwss.get_vupdate_offset_from_vsync)
+		return;
+
+	const struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
+	int vline_pos = pipe_ctx->stream->periodic_interrupt.lines_offset;
+
+	if (pipe_ctx->stream->periodic_interrupt.ref_point == START_V_UPDATE) {
+		if (vline_pos > 0)
+			vline_pos--;
+		else if (vline_pos < 0)
+			vline_pos++;
+
+		vline_pos += dc->hwss.get_vupdate_offset_from_vsync(pipe_ctx);
+		if (vline_pos >= 0)
+			*start_line = vline_pos - ((vline_pos / timing->v_total) * timing->v_total);
+		else
+			*start_line = vline_pos + ((-vline_pos / timing->v_total) + 1) * timing->v_total - 1;
+		*end_line = (*start_line + 2) % timing->v_total;
+	} else if (pipe_ctx->stream->periodic_interrupt.ref_point == START_V_SYNC) {
+		// vsync is line 0 so start_line is just the requested line offset
+		*start_line = vline_pos;
+		*end_line = (*start_line + 2) % timing->v_total;
+	} else
+		ASSERT(0);
+}
+
 // Function to check if any update flags are set
 static bool get_pipe_update_bits_status(struct pipe_ctx *pipe, struct dc_plane_state *plane, struct dc_stream_state *stream)
 {
@@ -1173,8 +1205,16 @@ void hwss_build_fast_sequence(struct dc *dc,
 	}
 
 	if (dc->hwss.setup_periodic_interrupt && stream->update_flags.bits.periodic_interrupt) {
-		block_sequence[*num_steps].params.setup_periodic_interrupt_params.dc = dc;
-		block_sequence[*num_steps].params.setup_periodic_interrupt_params.pipe_ctx = pipe_ctx;
+		uint32_t start_line = 0;
+		uint32_t end_line = 0;
+
+		calc_vline_position(dc, pipe_ctx, &start_line, &end_line);
+		block_sequence[*num_steps].params.setup_periodic_interrupt_params.tg =
+				pipe_ctx->stream_res.tg;
+		block_sequence[*num_steps].params.setup_periodic_interrupt_params.start_line =
+				start_line;
+		block_sequence[*num_steps].params.setup_periodic_interrupt_params.end_line =
+				end_line;
 		block_sequence[*num_steps].func = HWSS_SETUP_PERIODIC_INTERRUPT;
 		(*num_steps)++;
 	}
@@ -1668,7 +1708,11 @@ void hwss_execute_sequence(struct dc *dc,
 			hwss_tg_setup_vertical_interrupt0(params);
 			break;
 		case HWSS_SETUP_PERIODIC_INTERRUPT:
-			hwss_setup_periodic_interrupt(dc, params);
+			if (dc->hwss.setup_periodic_interrupt)
+				dc->hwss.setup_periodic_interrupt(
+						params->setup_periodic_interrupt_params.tg,
+						params->setup_periodic_interrupt_params.start_line,
+						params->setup_periodic_interrupt_params.end_line);
 			break;
 		case HWSS_UPDATE_INFO_FRAME:
 			hwss_update_info_frame(dc, params);
@@ -3322,12 +3366,18 @@ void hwss_update_info_frame(struct dc *dc, union block_sequence_params *params)
 		dc->hwss.update_info_frame(pipe_ctx);
 }
 
-void hwss_setup_periodic_interrupt(struct dc *dc, union block_sequence_params *params)
+void hwss_setup_periodic_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
-	struct pipe_ctx *pipe_ctx = params->setup_periodic_interrupt_params.pipe_ctx;
+	uint32_t start_line = 0;
+	uint32_t end_line = 0;
 
-	if (dc->hwss.setup_periodic_interrupt)
-		dc->hwss.setup_periodic_interrupt(dc, pipe_ctx);
+	if (dc->hwss.setup_periodic_interrupt) {
+		calc_vline_position(dc, pipe_ctx, &start_line, &end_line);
+		dc->hwss.setup_periodic_interrupt(
+				pipe_ctx->stream_res.tg,
+				start_line,
+				end_line);
+	}
 }
 
 void hwss_tg_setup_vertical_interrupt0(union block_sequence_params *params)
@@ -5934,9 +5984,17 @@ void hwss_add_setup_periodic_interrupt(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx)
 {
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		uint32_t start_line = 0;
+		uint32_t end_line = 0;
+
+		calc_vline_position(dc, pipe_ctx, &start_line, &end_line);
 		seq_state->steps[*seq_state->num_steps].func = HWSS_SETUP_PERIODIC_INTERRUPT;
-		seq_state->steps[*seq_state->num_steps].params.setup_periodic_interrupt_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.setup_periodic_interrupt_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.setup_periodic_interrupt_params.tg =
+				pipe_ctx->stream_res.tg;
+		seq_state->steps[*seq_state->num_steps].params.setup_periodic_interrupt_params.start_line =
+				start_line;
+		seq_state->steps[*seq_state->num_steps].params.setup_periodic_interrupt_params.end_line =
+				end_line;
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 097e4ac2df05..850639b6fd9b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -4026,45 +4026,12 @@ void dcn10_calc_vupdate_position(
 	*end_line = (*start_line + 2) % timing->v_total;
 }
 
-static void dcn10_cal_vline_position(
-		struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		uint32_t *start_line,
-		uint32_t *end_line)
-{
-	const struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
-	int vline_pos = pipe_ctx->stream->periodic_interrupt.lines_offset;
-
-	if (pipe_ctx->stream->periodic_interrupt.ref_point == START_V_UPDATE) {
-		if (vline_pos > 0)
-			vline_pos--;
-		else if (vline_pos < 0)
-			vline_pos++;
-
-		vline_pos += dc->hwss.get_vupdate_offset_from_vsync(pipe_ctx);
-		if (vline_pos >= 0)
-			*start_line = vline_pos - ((vline_pos / timing->v_total) * timing->v_total);
-		else
-			*start_line = vline_pos + ((-vline_pos / timing->v_total) + 1) * timing->v_total - 1;
-		*end_line = (*start_line + 2) % timing->v_total;
-	} else if (pipe_ctx->stream->periodic_interrupt.ref_point == START_V_SYNC) {
-		// vsync is line 0 so start_line is just the requested line offset
-		*start_line = vline_pos;
-		*end_line = (*start_line + 2) % timing->v_total;
-	} else
-		ASSERT(0);
-}
-
 void dcn10_setup_periodic_interrupt(
-		struct dc *dc,
-		struct pipe_ctx *pipe_ctx)
+		struct timing_generator *tg,
+		uint32_t start_line,
+		uint32_t end_line
+	)
 {
-	struct timing_generator *tg = pipe_ctx->stream_res.tg;
-	uint32_t start_line = 0;
-	uint32_t end_line = 0;
-
-	dcn10_cal_vline_position(dc, pipe_ctx, &start_line, &end_line);
-
 	tg->funcs->setup_vertical_interrupt0(tg, start_line, end_line);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index 2cb674ba54e1..a93109c2199b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -183,8 +183,9 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx);
 void dcn10_set_cursor_attribute(struct pipe_ctx *pipe_ctx);
 void dcn10_set_cursor_sdr_white_level(struct pipe_ctx *pipe_ctx);
 void dcn10_setup_periodic_interrupt(
-		struct dc *dc,
-		struct pipe_ctx *pipe_ctx);
+		struct timing_generator *tg,
+		uint32_t start_line,
+		uint32_t end_line);
 enum dc_status dcn10_set_clock(struct dc *dc,
 		enum dc_clock_type clock_type,
 		uint32_t clk_khz,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index cdf2562a9a40..129120ac6d9e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -819,8 +819,9 @@ struct cursor_lock_params {
 };
 
 struct setup_periodic_interrupt_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct timing_generator *tg;
+	uint32_t start_line;
+	uint32_t end_line;
 };
 
 struct send_cursor_info_to_dmu_params {
@@ -1452,8 +1453,9 @@ struct hw_sequencer_funcs {
 	void (*enable_vblanks_synchronization)(struct dc *dc,
 			int group_index, int group_size,
 			struct pipe_ctx *grouped_pipes[]);
-	void (*setup_periodic_interrupt)(struct dc *dc,
-			struct pipe_ctx *pipe_ctx);
+	void (*setup_periodic_interrupt)(struct timing_generator *tg,
+			uint32_t start_line,
+			uint32_t end_line);
 	void (*set_drr)(struct pipe_ctx **pipe_ctx, int num_pipes,
 			struct dc_crtc_timing_adjust adjust);
 	void (*set_static_screen_control)(struct pipe_ctx **pipe_ctx,
@@ -2113,7 +2115,7 @@ void hwss_commit_cursor_offload_update(union block_sequence_params *params);
 
 void hwss_update_cursor_offload_pipe(union block_sequence_params *params);
 
-void hwss_setup_periodic_interrupt(struct dc *dc, union block_sequence_params *params);
+void hwss_setup_periodic_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx);
 
 void hwss_disable_audio_stream(struct dc *dc, union block_sequence_params *params);
 
-- 
2.43.0

