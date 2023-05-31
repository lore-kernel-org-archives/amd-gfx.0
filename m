Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC34C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADFE710E470;
	Wed, 31 May 2023 04:49:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C44410E470
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAY4Rz5Kd7AQUs5n3Rp2K6qTjl7V7vKc/Wv6gN3thY71pUb2OWiarlPMulgTOj7FlNwVcAySw6Bvh6Jw2+CW/ytFqSvCJk5Rll6YgwuYvI47P6A8AAe+kCf+/gAZJqfJaVEZWJEG+b0BG1f7WN9B6lV8k4O9UAhM0bkzf0qHMZYYYUgVXztXJ9bAi0kkQg1APt29NB1BPTzFVhUDJzZhLYs8orIU7XXB4gpZFWENs9jsP1+aRV8d1MRG3tj/xObDUPjv9TmJTRfR1mnW8f+W5MJdM2GqAn0kM5HNz2QtKsdRTGq1V3yHufHI+rucnb/BQfMwjyu8fAa7+NMY9E7UlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djDvm6J0sybj3IJEV7m+4iipPVG1/6vU7YdeYFhPbPc=;
 b=Uzby2fAwWwEdzK3wMlyL1CooK6n9Qbj7NfCUGjr4gWyOAejQZlJCDm/yCZPfA4HHyyLBesBAU1yBiRK4SgIRHS2KDOz61MW82zinBiJ/L8x0f5SToUBErBelO0yIA/Xw2SP6I9HuiYLJz9SO6rT3kYY6pX0HvlkZagbpXqYTu3dfKyG/Mdgr80A/yYiUgeu21aBUfcFdDhSkMD8bDvtOIs831oqlMmE9sMf5n3OgjCfRobQ/F5+Q6iofXPzSaTOnu7Lo21XOhyKWWrsJFBF8OM7tAJAaQcTJ9ftunR3t1NjF5G/GHZZiMRjS35tDL9o9h2K0uh8DzpvPm/TKb+wd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djDvm6J0sybj3IJEV7m+4iipPVG1/6vU7YdeYFhPbPc=;
 b=04OYN4RhNPmrH2/vQWVMuVly4uvoC17p4yo1oGuDVGXeqKnqWPaqFZLWOD/3tO4jC5/H1A83JneUPqyrSaH0UVnYxUJeBuPJ8JwixwR1dL7cQ49MohNGF8wA9LVQUadAt6936YxASRcIhYVQKQ+6wy6tBRs+g22a/yxCVZ52k10=
Received: from BN9PR03CA0062.namprd03.prod.outlook.com (2603:10b6:408:fc::7)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 04:49:13 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::75) by BN9PR03CA0062.outlook.office365.com
 (2603:10b6:408:fc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 04:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:49:13 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:48:59 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amd/display: Refactor fast update to use new HWSS
 build sequence
Date: Wed, 31 May 2023 12:48:03 +0800
Message-ID: <20230531044813.145361-5-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|BL1PR12MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b05cc99-b71e-436f-0560-08db619261d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UcTN1tUzGZ466hzUNmATCfIBypMNJVwqWQ25Oq9HtkndGkPNwIyiYv3fD4oQKsWF4XACGj/Exy845FWxg/zxPsUZPRkcumDdIR4lZrTJJBZzxta7zfO4s1tAve5jgWxWqA1E1TR+i+9RDb+ED2fRZHGc7jjJmmhLOn1vj0aM4pBKP5TwcALMM4m/sfeQntQrI0HoDMUyhi+JJZiTeBhmdLVLviH6VipR48pXgFUn7bfYzC/mUfE3BOymfOriM9fnkhVDDfGPh0SZnmpWpXHkcMoAbHvsd27nWuzsRLT2zzhirnSw/IttfWBYRv6jxO3CdZI8ZHREHKXPOpRLeae+G7HKXoO1n3ZMbuNodvFsp3QEODYytIwhmqCPLIUe4rGjPZBVAtALLVACKH3Zc6NJraFRQSnEK+5wp29SRU/sRUG+UH2jSt9OOfyhwwma51zUeEiNBRgSvhvIRqPbHWu4rC9at2QFW9u9BLNPTMmq9ZgYphsGbFjsNuH6LNIvvHgU5hbtXu7MakQ3rqwvK/ZYfJgbmFVp9IQiaSTrkaV+DPMANlX3LQEvwOmz3wrLDIyez8Xi4Ndokc1cwgrXiAbDw5KKr4yK39Sx3PBKQW+EV+op/uwsDr4KXfdUSoLCZ/OsougV44/38/+LD2cwQBugQdFRX4bHGWAk7Pkvv/udkUWE+JXkm73w6SmidPMENTQ+HZI5W6sJDkYyNfKi4agOb4Q9qtIHvjH9Y0RKU0UyGADGxs6hs8L+isYFLRxLCu9v3zVNGBzX4nDZBtgH1zKzKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(16526019)(36860700001)(30864003)(2906002)(15650500001)(336012)(426003)(86362001)(47076005)(70206006)(81166007)(4326008)(41300700001)(83380400001)(70586007)(356005)(6916009)(36756003)(186003)(82740400003)(44832011)(2616005)(1076003)(26005)(8936002)(8676002)(40460700003)(5660300002)(82310400005)(7696005)(478600001)(6666004)(316002)(40480700001)(54906003)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:49:13.6418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b05cc99-b71e-436f-0560-08db619261d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- Refactor HW sequencer to use a build / execute sequence
- Also move gamma updates to become fast

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 271 ++++++++++++++++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 255 ++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 .../amd/display/dc/dce100/dce100_resource.c   |   5 +
 .../amd/display/dc/dce110/dce110_resource.c   |   5 +
 .../amd/display/dc/dce112/dce112_resource.c   |   5 +
 .../amd/display/dc/dce120/dce120_resource.c   |   1 +
 .../drm/amd/display/dc/dce80/dce80_resource.c |   6 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   1 +
 .../amd/display/dc/dcn201/dcn201_resource.c   |   1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  24 ++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   2 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  11 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h | 126 ++++++++
 20 files changed, 690 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2ad4293bb3e5..172bae983425 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2589,15 +2589,19 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 		elevate_update_type(&overall_type, type);
 	}
 
-	if (update_flags->bits.input_csc_change
-			|| update_flags->bits.coeff_reduction_change
-			|| update_flags->bits.lut_3d
-			|| update_flags->bits.gamma_change
-			|| update_flags->bits.gamut_remap_change) {
+	if (update_flags->bits.lut_3d) {
 		type = UPDATE_TYPE_FULL;
 		elevate_update_type(&overall_type, type);
 	}
 
+	if (dc->debug.enable_legacy_fast_update &&
+			(update_flags->bits.gamma_change ||
+			update_flags->bits.gamut_remap_change ||
+			update_flags->bits.input_csc_change ||
+			update_flags->bits.coeff_reduction_change)) {
+		type = UPDATE_TYPE_FULL;
+		elevate_update_type(&overall_type, type);
+	}
 	return overall_type;
 }
 
@@ -2630,7 +2634,7 @@ static enum surface_update_type check_update_surfaces_for_stream(
 			stream_update->integer_scaling_update)
 			su_flags->bits.scaling = 1;
 
-		if (stream_update->out_transfer_func)
+		if (dc->debug.enable_legacy_fast_update && stream_update->out_transfer_func)
 			su_flags->bits.out_tf = 1;
 
 		if (stream_update->abm_level)
@@ -2661,6 +2665,12 @@ static enum surface_update_type check_update_surfaces_for_stream(
 
 		if (stream_update->output_csc_transform || stream_update->output_color_space)
 			su_flags->bits.out_csc = 1;
+
+		/* Output transfer function changes do not require bandwidth recalculation,
+		 * so don't trigger a full update
+		 */
+		if (!dc->debug.enable_legacy_fast_update && stream_update->out_transfer_func)
+			su_flags->bits.out_tf = 1;
 	}
 
 	for (i = 0 ; i < surface_count; i++) {
@@ -3412,6 +3422,163 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
 	}
 }
 
+static void build_dmub_update_dirty_rect(
+		struct dc *dc,
+		int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_surface_update *srf_updates,
+		struct dc_state *context,
+		struct dc_dmub_cmd dc_dmub_cmd[],
+		unsigned int *dmub_cmd_count)
+{
+	union dmub_rb_cmd cmd;
+	struct dmub_cmd_update_dirty_rect_data *update_dirty_rect;
+	unsigned int i, j;
+	unsigned int panel_inst = 0;
+
+	if (!dc_dmub_should_send_dirty_rect_cmd(dc, stream))
+		return;
+
+	if (!dc_get_edp_link_panel_inst(dc, stream->link, &panel_inst))
+		return;
+
+	memset(&cmd, 0x0, sizeof(cmd));
+	cmd.update_dirty_rect.header.type = DMUB_CMD__UPDATE_DIRTY_RECT;
+	cmd.update_dirty_rect.header.sub_type = 0;
+	cmd.update_dirty_rect.header.payload_bytes =
+		sizeof(cmd.update_dirty_rect) -
+		sizeof(cmd.update_dirty_rect.header);
+	update_dirty_rect = &cmd.update_dirty_rect.update_dirty_rect_data;
+	for (i = 0; i < surface_count; i++) {
+		struct dc_plane_state *plane_state = srf_updates[i].surface;
+		const struct dc_flip_addrs *flip_addr = srf_updates[i].flip_addr;
+
+		if (!srf_updates[i].surface || !flip_addr)
+			continue;
+		/* Do not send in immediate flip mode */
+		if (srf_updates[i].surface->flip_immediate)
+			continue;
+		update_dirty_rect->cmd_version = DMUB_CMD_PSR_CONTROL_VERSION_1;
+		update_dirty_rect->dirty_rect_count = flip_addr->dirty_rect_count;
+		memcpy(update_dirty_rect->src_dirty_rects, flip_addr->dirty_rects,
+				sizeof(flip_addr->dirty_rects));
+		for (j = 0; j < dc->res_pool->pipe_count; j++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+
+			if (pipe_ctx->stream != stream)
+				continue;
+			if (pipe_ctx->plane_state != plane_state)
+				continue;
+			update_dirty_rect->panel_inst = panel_inst;
+			update_dirty_rect->pipe_idx = j;
+			dc_dmub_cmd[*dmub_cmd_count].dmub_cmd = cmd;
+			dc_dmub_cmd[*dmub_cmd_count].wait_type = DM_DMUB_WAIT_TYPE_NO_WAIT;
+			(*dmub_cmd_count)++;
+		}
+	}
+}
+
+
+/**
+ * ************************************************************************************************
+ * build_dmub_cmd_list: Build an array of DMCUB commands to be sent to DMCUB
+ *
+ * @param [in]: dc: Current DC state
+ * @param [in]: srf_updates: Array of surface updates
+ * @param [in]: surface_count: Number of surfaces that have an updated
+ * @param [in]: stream: Correponding stream to be updated in the current flip
+ * @param [in]: context: New DC state to be programmed
+ *
+ * @param [out]: dc_dmub_cmd: Array of DMCUB commands to be sent to DMCUB
+ * @param [out]: dmub_cmd_count: Count indicating the number of DMCUB commands in dc_dmub_cmd array
+ *
+ * This function builds an array of DMCUB commands to be sent to DMCUB. This function is required
+ * to build an array of commands and have them sent while the OTG lock is acquired.
+ *
+ * @return: void
+ * ************************************************************************************************
+ */
+static void build_dmub_cmd_list(struct dc *dc,
+		struct dc_surface_update *srf_updates,
+		int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_state *context,
+		struct dc_dmub_cmd dc_dmub_cmd[],
+		unsigned int *dmub_cmd_count)
+{
+	// Initialize cmd count to 0
+	*dmub_cmd_count = 0;
+	build_dmub_update_dirty_rect(dc, surface_count, stream, srf_updates, context, dc_dmub_cmd, dmub_cmd_count);
+}
+
+static void commit_planes_for_stream_fast(struct dc *dc,
+		struct dc_surface_update *srf_updates,
+		int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update,
+		enum surface_update_type update_type,
+		struct dc_state *context)
+{
+	int i, j;
+	struct pipe_ctx *top_pipe_to_program = NULL;
+	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
+	dc_z10_restore(dc);
+
+	for (j = 0; j < dc->res_pool->pipe_count; j++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+
+		if (!pipe_ctx->top_pipe &&
+			!pipe_ctx->prev_odm_pipe &&
+			pipe_ctx->stream &&
+			pipe_ctx->stream == stream) {
+			top_pipe_to_program = pipe_ctx;
+		}
+	}
+
+	if (dc->debug.visual_confirm)
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+			if (pipe->stream && pipe->plane_state)
+				dc_update_viusal_confirm_color(dc, context, pipe);
+		}
+
+		for (i = 0; i < surface_count; i++) {
+			struct dc_plane_state *plane_state = srf_updates[i].surface;
+			/*set logical flag for lock/unlock use*/
+			for (j = 0; j < dc->res_pool->pipe_count; j++) {
+				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+				if (!pipe_ctx->plane_state)
+					continue;
+				if (should_update_pipe_for_plane(context, pipe_ctx, plane_state))
+					continue;
+				pipe_ctx->plane_state->triplebuffer_flips = false;
+				if (update_type == UPDATE_TYPE_FAST &&
+					dc->hwss.program_triplebuffer != NULL &&
+					!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
+						/*triple buffer for VUpdate  only*/
+						pipe_ctx->plane_state->triplebuffer_flips = true;
+				}
+			}
+		}
+	build_dmub_cmd_list(dc,
+			srf_updates,
+			surface_count,
+			stream,
+			context,
+			context->dc_dmub_cmd,
+			&(context->dmub_cmd_count));
+	hwss_build_fast_sequence(dc,
+			context->dc_dmub_cmd,
+			context->dmub_cmd_count,
+			context->block_sequence,
+			&(context->block_sequence_steps),
+			top_pipe_to_program);
+	hwss_execute_sequence(dc,
+			context->block_sequence,
+			context->block_sequence_steps);
+}
+
 static void commit_planes_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
@@ -3449,21 +3616,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
-	if (get_seamless_boot_stream_count(context) > 0 && surface_count > 0) {
-		/* Optimize seamless boot flag keeps clocks and watermarks high until
-		 * first flip. After first flip, optimization is required to lower
-		 * bandwidth. Important to note that it is expected UEFI will
-		 * only light up a single display on POST, therefore we only expect
-		 * one stream with seamless boot flag set.
-		 */
-		if (stream->apply_seamless_boot_optimization) {
-			stream->apply_seamless_boot_optimization = false;
-
-			if (get_seamless_boot_stream_count(context) == 0)
-				dc->optimized_required = true;
-		}
-	}
-
 	if (update_type == UPDATE_TYPE_FULL) {
 		dc_allow_idle_optimizations(dc, false);
 
@@ -4067,6 +4219,43 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	return true;
 }
 
+/**
+ * *******************************************************************************
+ * update_seamless_boot_flags: Helper function for updating seamless boot flags
+ *
+ * @param [in]: dc: Current DC state
+ * @param [in]: context: New DC state to be programmed
+ * @param [in]: surface_count: Number of surfaces that have an updated
+ * @param [in]: stream: Correponding stream to be updated in the current flip
+ *
+ * Updating seamless boot flags do not need to be part of the commit sequence. This
+ * helper function will update the seamless boot flags on each flip (if required)
+ * outside of the HW commit sequence (fast or slow).
+ *
+ * @return: void
+ * *******************************************************************************
+ */
+static void update_seamless_boot_flags(struct dc *dc,
+		struct dc_state *context,
+		int surface_count,
+		struct dc_stream_state *stream)
+{
+	if (get_seamless_boot_stream_count(context) > 0 && surface_count > 0) {
+		/* Optimize seamless boot flag keeps clocks and watermarks high until
+		 * first flip. After first flip, optimization is required to lower
+		 * bandwidth. Important to note that it is expected UEFI will
+		 * only light up a single display on POST, therefore we only expect
+		 * one stream with seamless boot flag set.
+		 */
+		if (stream->apply_seamless_boot_optimization) {
+			stream->apply_seamless_boot_optimization = false;
+
+			if (get_seamless_boot_stream_count(context) == 0)
+				dc->optimized_required = true;
+		}
+	}
+}
+
 bool dc_update_planes_and_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
@@ -4133,14 +4322,25 @@ bool dc_update_planes_and_stream(struct dc *dc,
 		update_type = UPDATE_TYPE_FULL;
 	}
 
-	commit_planes_for_stream(
-			dc,
-			srf_updates,
-			surface_count,
-			stream,
-			stream_update,
-			update_type,
-			context);
+	update_seamless_boot_flags(dc, context, surface_count, stream);
+	if (!dc->debug.enable_legacy_fast_update && update_type == UPDATE_TYPE_FAST) {
+		commit_planes_for_stream_fast(dc,
+				srf_updates,
+				surface_count,
+				stream,
+				stream_update,
+				update_type,
+				context);
+	} else {
+		commit_planes_for_stream(
+				dc,
+				srf_updates,
+				surface_count,
+				stream,
+				stream_update,
+				update_type,
+				context);
+	}
 
 	if (dc->current_state != context) {
 
@@ -4265,7 +4465,17 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 	TRACE_DC_PIPE_STATE(pipe_ctx, i, MAX_PIPES);
 
-	commit_planes_for_stream(
+	update_seamless_boot_flags(dc, context, surface_count, stream);
+	if (!dc->debug.enable_legacy_fast_update && update_type == UPDATE_TYPE_FAST) {
+		commit_planes_for_stream_fast(dc,
+				srf_updates,
+				surface_count,
+				stream,
+				stream_update,
+				update_type,
+				context);
+	} else {
+		commit_planes_for_stream(
 				dc,
 				srf_updates,
 				surface_count,
@@ -4273,6 +4483,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
 				stream_update,
 				update_type,
 				context);
+	}
 	/*update current_State*/
 	if (dc->current_state != context) {
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 8a98b8dd008e..182c42c63bc5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -27,6 +27,8 @@
 #include "core_types.h"
 #include "timing_generator.h"
 #include "hw_sequencer.h"
+#include "hw_sequencer_private.h"
+#include "basics/dc_common.h"
 
 #define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
 
@@ -463,6 +465,259 @@ void get_subvp_visual_confirm_color(
 	}
 }
 
+void hwss_build_fast_sequence(struct dc *dc,
+		struct dc_dmub_cmd *dc_dmub_cmd,
+		unsigned int dmub_cmd_count,
+		struct block_sequence block_sequence[],
+		int *num_steps,
+		struct pipe_ctx *pipe_ctx)
+{
+	struct dc_plane_state *plane = pipe_ctx->plane_state;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dce_hwseq *hws = dc->hwseq;
+	struct pipe_ctx *current_pipe = NULL;
+	struct pipe_ctx *current_mpc_pipe = NULL;
+	unsigned int i = 0;
+
+	*num_steps = 0; // Initialize to 0
+
+	if (!plane || !stream)
+		return;
+
+	if (dc->hwss.subvp_pipe_control_lock_fast) {
+		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.dc = dc;
+		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.lock = true;
+		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.pipe_ctx = pipe_ctx;
+		block_sequence[*num_steps].func = DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST;
+		(*num_steps)++;
+	}
+	if (dc->hwss.pipe_control_lock) {
+		block_sequence[*num_steps].params.pipe_control_lock_params.dc = dc;
+		block_sequence[*num_steps].params.pipe_control_lock_params.lock = true;
+		block_sequence[*num_steps].params.pipe_control_lock_params.pipe_ctx = pipe_ctx;
+		block_sequence[*num_steps].func = OPTC_PIPE_CONTROL_LOCK;
+		(*num_steps)++;
+	}
+
+	for (i = 0; i < dmub_cmd_count; i++) {
+		block_sequence[*num_steps].params.send_dmcub_cmd_params.ctx = dc->ctx;
+		block_sequence[*num_steps].params.send_dmcub_cmd_params.cmd = &(dc_dmub_cmd[i].dmub_cmd);
+		block_sequence[*num_steps].params.send_dmcub_cmd_params.wait_type = dc_dmub_cmd[i].wait_type;
+		block_sequence[*num_steps].func = DMUB_SEND_DMCUB_CMD;
+		(*num_steps)++;
+	}
+
+	current_pipe = pipe_ctx;
+	while (current_pipe) {
+		current_mpc_pipe = current_pipe;
+		while (current_mpc_pipe) {
+			if (dc->hwss.set_flip_control_gsl && current_mpc_pipe->plane_state && current_mpc_pipe->plane_state->update_flags.raw) {
+				block_sequence[*num_steps].params.set_flip_control_gsl_params.pipe_ctx = current_mpc_pipe;
+				block_sequence[*num_steps].params.set_flip_control_gsl_params.flip_immediate = current_mpc_pipe->plane_state->flip_immediate;
+				block_sequence[*num_steps].func = HUBP_SET_FLIP_CONTROL_GSL;
+				(*num_steps)++;
+			}
+			if (dc->hwss.program_triplebuffer && dc->debug.enable_tri_buf && current_mpc_pipe->plane_state->update_flags.raw) {
+				block_sequence[*num_steps].params.program_triplebuffer_params.dc = dc;
+				block_sequence[*num_steps].params.program_triplebuffer_params.pipe_ctx = current_mpc_pipe;
+				block_sequence[*num_steps].params.program_triplebuffer_params.enableTripleBuffer = current_mpc_pipe->plane_state->triplebuffer_flips;
+				block_sequence[*num_steps].func = HUBP_PROGRAM_TRIPLEBUFFER;
+				(*num_steps)++;
+			}
+			if (dc->hwss.update_plane_addr && current_mpc_pipe->plane_state->update_flags.bits.addr_update) {
+				block_sequence[*num_steps].params.update_plane_addr_params.dc = dc;
+				block_sequence[*num_steps].params.update_plane_addr_params.pipe_ctx = current_mpc_pipe;
+				block_sequence[*num_steps].func = HUBP_UPDATE_PLANE_ADDR;
+				(*num_steps)++;
+			}
+
+			if (hws->funcs.set_input_transfer_func && current_mpc_pipe->plane_state->update_flags.bits.gamma_change) {
+				block_sequence[*num_steps].params.set_input_transfer_func_params.dc = dc;
+				block_sequence[*num_steps].params.set_input_transfer_func_params.pipe_ctx = current_mpc_pipe;
+				block_sequence[*num_steps].params.set_input_transfer_func_params.plane_state = current_mpc_pipe->plane_state;
+				block_sequence[*num_steps].func = DPP_SET_INPUT_TRANSFER_FUNC;
+				(*num_steps)++;
+			}
+
+			if (dc->hwss.program_gamut_remap && current_mpc_pipe->plane_state->update_flags.bits.gamut_remap_change) {
+				block_sequence[*num_steps].params.program_gamut_remap_params.pipe_ctx = current_mpc_pipe;
+				block_sequence[*num_steps].func = DPP_PROGRAM_GAMUT_REMAP;
+				(*num_steps)++;
+			}
+			if (current_mpc_pipe->plane_state->update_flags.bits.input_csc_change) {
+				block_sequence[*num_steps].params.setup_dpp_params.pipe_ctx = current_mpc_pipe;
+				block_sequence[*num_steps].func = DPP_SETUP_DPP;
+				(*num_steps)++;
+			}
+			if (current_mpc_pipe->plane_state->update_flags.bits.coeff_reduction_change) {
+				block_sequence[*num_steps].params.program_bias_and_scale_params.pipe_ctx = current_mpc_pipe;
+				block_sequence[*num_steps].func = DPP_PROGRAM_BIAS_AND_SCALE;
+				(*num_steps)++;
+			}
+			if (hws->funcs.set_output_transfer_func && current_mpc_pipe->stream->update_flags.bits.out_tf) {
+				block_sequence[*num_steps].params.set_output_transfer_func_params.dc = dc;
+				block_sequence[*num_steps].params.set_output_transfer_func_params.pipe_ctx = current_mpc_pipe;
+				block_sequence[*num_steps].params.set_output_transfer_func_params.stream = current_mpc_pipe->stream;
+				block_sequence[*num_steps].func = DPP_SET_OUTPUT_TRANSFER_FUNC;
+				(*num_steps)++;
+			}
+
+			current_mpc_pipe = current_mpc_pipe->bottom_pipe;
+		}
+		current_pipe = current_pipe->next_odm_pipe;
+	}
+
+	if (dc->hwss.pipe_control_lock) {
+		block_sequence[*num_steps].params.pipe_control_lock_params.dc = dc;
+		block_sequence[*num_steps].params.pipe_control_lock_params.lock = false;
+		block_sequence[*num_steps].params.pipe_control_lock_params.pipe_ctx = pipe_ctx;
+		block_sequence[*num_steps].func = OPTC_PIPE_CONTROL_LOCK;
+		(*num_steps)++;
+	}
+	if (dc->hwss.subvp_pipe_control_lock_fast) {
+		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.dc = dc;
+		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.lock = false;
+		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.pipe_ctx = pipe_ctx;
+		block_sequence[*num_steps].func = DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST;
+		(*num_steps)++;
+	}
+
+	current_pipe = pipe_ctx;
+	while (current_pipe) {
+		current_mpc_pipe = current_pipe;
+
+		while (current_mpc_pipe) {
+			if (!current_mpc_pipe->bottom_pipe && !pipe_ctx->next_odm_pipe &&
+					current_mpc_pipe->stream && current_mpc_pipe->plane_state &&
+					current_mpc_pipe->plane_state->update_flags.bits.addr_update &&
+					!current_mpc_pipe->plane_state->skip_manual_trigger) {
+				block_sequence[*num_steps].params.program_manual_trigger_params.pipe_ctx = current_mpc_pipe;
+				block_sequence[*num_steps].func = OPTC_PROGRAM_MANUAL_TRIGGER;
+				(*num_steps)++;
+			}
+			current_mpc_pipe = current_mpc_pipe->bottom_pipe;
+		}
+		current_pipe = current_pipe->next_odm_pipe;
+	}
+}
+
+void hwss_execute_sequence(struct dc *dc,
+		struct block_sequence block_sequence[],
+		int num_steps)
+{
+	unsigned int i;
+	union block_sequence_params *params;
+	struct dce_hwseq *hws = dc->hwseq;
+
+	for (i = 0; i < num_steps; i++) {
+		params = &(block_sequence[i].params);
+		switch (block_sequence[i].func) {
+
+		case DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST:
+			dc->hwss.subvp_pipe_control_lock_fast(params);
+			break;
+		case OPTC_PIPE_CONTROL_LOCK:
+			dc->hwss.pipe_control_lock(params->pipe_control_lock_params.dc,
+					params->pipe_control_lock_params.pipe_ctx,
+					params->pipe_control_lock_params.lock);
+			break;
+		case HUBP_SET_FLIP_CONTROL_GSL:
+			dc->hwss.set_flip_control_gsl(params->set_flip_control_gsl_params.pipe_ctx,
+					params->set_flip_control_gsl_params.flip_immediate);
+			break;
+		case HUBP_PROGRAM_TRIPLEBUFFER:
+			dc->hwss.program_triplebuffer(params->program_triplebuffer_params.dc,
+					params->program_triplebuffer_params.pipe_ctx,
+					params->program_triplebuffer_params.enableTripleBuffer);
+			break;
+		case HUBP_UPDATE_PLANE_ADDR:
+			dc->hwss.update_plane_addr(params->update_plane_addr_params.dc,
+					params->update_plane_addr_params.pipe_ctx);
+			break;
+		case DPP_SET_INPUT_TRANSFER_FUNC:
+			hws->funcs.set_input_transfer_func(params->set_input_transfer_func_params.dc,
+					params->set_input_transfer_func_params.pipe_ctx,
+					params->set_input_transfer_func_params.plane_state);
+			break;
+		case DPP_PROGRAM_GAMUT_REMAP:
+			dc->hwss.program_gamut_remap(params->program_gamut_remap_params.pipe_ctx);
+			break;
+		case DPP_SETUP_DPP:
+			hwss_setup_dpp(params);
+			break;
+		case DPP_PROGRAM_BIAS_AND_SCALE:
+			hwss_program_bias_and_scale(params);
+			break;
+		case OPTC_PROGRAM_MANUAL_TRIGGER:
+			hwss_program_manual_trigger(params);
+			break;
+		case DPP_SET_OUTPUT_TRANSFER_FUNC:
+			hws->funcs.set_output_transfer_func(params->set_output_transfer_func_params.dc,
+					params->set_output_transfer_func_params.pipe_ctx,
+					params->set_output_transfer_func_params.stream);
+			break;
+		case MPC_UPDATE_VISUAL_CONFIRM:
+			dc->hwss.update_visual_confirm_color(params->update_visual_confirm_params.dc,
+					params->update_visual_confirm_params.pipe_ctx,
+					params->update_visual_confirm_params.mpcc_id);
+			break;
+		case DMUB_SEND_DMCUB_CMD:
+			hwss_send_dmcub_cmd(params);
+			break;
+		default:
+			ASSERT(false);
+			break;
+		}
+	}
+}
+
+void hwss_send_dmcub_cmd(union block_sequence_params *params)
+{
+	struct dc_context *ctx = params->send_dmcub_cmd_params.ctx;
+	union dmub_rb_cmd *cmd = params->send_dmcub_cmd_params.cmd;
+	enum dm_dmub_wait_type wait_type = params->send_dmcub_cmd_params.wait_type;
+
+	dm_execute_dmub_cmd(ctx, cmd, wait_type);
+}
+
+void hwss_program_manual_trigger(union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->program_manual_trigger_params.pipe_ctx;
+
+	if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
+		pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
+}
+
+void hwss_setup_dpp(union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->setup_dpp_params.pipe_ctx;
+	struct dpp *dpp = pipe_ctx->plane_res.dpp;
+	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+
+	if (dpp && dpp->funcs->dpp_setup) {
+		// program the input csc
+		dpp->funcs->dpp_setup(dpp,
+				plane_state->format,
+				EXPANSION_MODE_ZERO,
+				plane_state->input_csc_color_matrix,
+				plane_state->color_space,
+				NULL);
+	}
+}
+
+void hwss_program_bias_and_scale(union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->program_bias_and_scale_params.pipe_ctx;
+	struct dpp *dpp = pipe_ctx->plane_res.dpp;
+	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+	struct dc_bias_and_scale bns_params = {0};
+
+	//TODO :for CNVC set scale and bias registers if necessary
+	build_prescale_params(&bns_params, plane_state);
+	if (dpp->funcs->dpp_program_bias_and_scale)
+		dpp->funcs->dpp_program_bias_and_scale(dpp, &bns_params);
+}
+
 void get_mclk_switch_visual_confirm_color(
 		struct dc *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7fd9f5a9e191..7ded574f84ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -896,6 +896,7 @@ struct dc_debug_options {
 	bool disable_dp_plus_plus_wa;
 	uint32_t fpo_vactive_min_active_margin_us;
 	uint32_t fpo_vactive_max_blank_us;
+	bool enable_legacy_fast_update;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index 54805802cbd5..42e9b6a529f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -401,6 +401,10 @@ static const struct dc_plane_cap plane_cap = {
 	}
 };
 
+static const struct dc_debug_options debug_defaults = {
+		.enable_legacy_fast_update = true,
+};
+
 #define CTX  ctx
 #define REG(reg) mm ## reg
 
@@ -1071,6 +1075,7 @@ static bool dce100_resource_construct(
 	dc->caps.dual_link_dvi = true;
 	dc->caps.disable_dp_clk_share = true;
 	dc->caps.extended_aux_timeout_support = false;
+	dc->debug = debug_defaults;
 
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		pool->base.timing_generators[i] =
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index a4a45a6ce61e..46eca5a21e1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -424,6 +424,10 @@ static const struct dc_plane_cap plane_cap = {
 		64
 };
 
+static const struct dc_debug_options debug_defaults = {
+		.enable_legacy_fast_update = true,
+};
+
 static const struct dc_plane_cap underlay_plane_cap = {
 		.type = DC_PLANE_TYPE_DCE_UNDERLAY,
 		.per_pixel_alpha = 1,
@@ -1368,6 +1372,7 @@ static bool dce110_resource_construct(
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.is_apu = true;
 	dc->caps.extended_aux_timeout_support = false;
+	dc->debug = debug_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index e179e80667d1..808855886183 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -429,6 +429,10 @@ static const struct dc_plane_cap plane_cap = {
 	64
 };
 
+static const struct dc_debug_options debug_defaults = {
+		.enable_legacy_fast_update = true,
+};
+
 #define CTX  ctx
 #define REG(reg) mm ## reg
 
@@ -1239,6 +1243,7 @@ static bool dce112_resource_construct(
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.extended_aux_timeout_support = false;
+	dc->debug = debug_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index af631085e88c..18c5a86d2d61 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -526,6 +526,7 @@ static const struct dc_plane_cap plane_cap = {
 
 static const struct dc_debug_options debug_defaults = {
 		.disable_clock_gate = true,
+		.enable_legacy_fast_update = true,
 };
 
 static struct clock_source *dce120_clock_source_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 5825e6f412bd..3935fd455f0f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -418,6 +418,10 @@ static const struct dc_plane_cap plane_cap = {
 	}
 };
 
+static const struct dc_debug_options debug_defaults = {
+		.enable_legacy_fast_update = true,
+};
+
 static const struct dce_dmcu_registers dmcu_regs = {
 		DMCU_DCE80_REG_LIST()
 };
@@ -969,6 +973,7 @@ static bool dce80_construct(
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.extended_aux_timeout_support = false;
+	dc->debug = debug_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
@@ -1369,6 +1374,7 @@ static bool dce83_construct(
 	dc->caps.max_cursor_size = 128;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 26ddf73fd5b1..4b02f8443534 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -553,6 +553,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.recovery_enabled = false, /*enable this by default after testing.*/
 		.max_downscale_src_width = 3840,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
+		.enable_legacy_fast_update = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 6ef7e2634991..4cc8de2627ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -722,6 +722,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.scl_reset_length10 = true,
 		.sanity_checks = false,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
+		.enable_legacy_fast_update = true,
 };
 
 void dcn20_dpp_destroy(struct dpp **dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index 5ff09bf4bc30..fdba8a9f5c30 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -613,6 +613,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.sanity_checks = false,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 		.enable_tri_buf = false,
+		.enable_legacy_fast_update = true,
 };
 
 static void dcn201_dpp_destroy(struct dpp **dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index da6d42de0554..d693ea42d033 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -653,6 +653,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.usbc_combo_phy_reset_wa = true,
 		.dmub_command_table = true,
 		.use_max_lb = true,
+		.enable_legacy_fast_update = true,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index f2d589c505a8..fc33b5fcabe1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -887,6 +887,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.disable_z10 = true,
+	.enable_legacy_fast_update = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
 	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 8570bdc292b4..0cc853964781 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -887,6 +887,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.afmt = true,
 		}
 	},
+	.enable_legacy_fast_update = true,
 	.psr_power_use_phy_fsm = 0,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index b6e0aa2ab27a..707cf28bbceb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -884,6 +884,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.afmt = true,
 		}
 	},
+	.enable_legacy_fast_update = true,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 7f5cd8c8d49b..3f11992e380b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -409,6 +409,30 @@ void dcn32_subvp_pipe_control_lock(struct dc *dc,
 	}
 }
 
+void dcn32_subvp_pipe_control_lock_fast(union block_sequence_params *params)
+{
+	struct dc *dc = params->subvp_pipe_control_lock_fast_params.dc;
+	bool lock = params->subvp_pipe_control_lock_fast_params.lock;
+	struct pipe_ctx *pipe_ctx = params->subvp_pipe_control_lock_fast_params.pipe_ctx;
+	bool subvp_immediate_flip = false;
+
+	if (pipe_ctx && pipe_ctx->stream && pipe_ctx->plane_state) {
+		if (pipe_ctx->stream->mall_stream_config.type == SUBVP_MAIN &&
+				pipe_ctx->plane_state->flip_immediate)
+			subvp_immediate_flip = true;
+	}
+
+	// Don't need to lock for DRR VSYNC flips -- FW will wait for DRR pending update cleared.
+	if (subvp_immediate_flip) {
+		union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
+
+		hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
+		hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
+		hw_lock_cmd.bits.lock = lock;
+		hw_lock_cmd.bits.should_release = !lock;
+		dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
+	}
+}
 
 bool dcn32_set_mpc_shaper_3dlut(
 	struct pipe_ctx *pipe_ctx, const struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 6dbe929cf599..2d2628f31bed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -84,6 +84,8 @@ void dcn32_subvp_pipe_control_lock(struct dc *dc,
 		struct pipe_ctx *top_pipe_to_program,
 		bool subvp_prev_use);
 
+void dcn32_subvp_pipe_control_lock_fast(union block_sequence_params *params);
+
 void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 		struct dc_link_settings *link_settings);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 8356b31e1d9a..c2490e16a66a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -110,6 +110,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.enable_phantom_streams = dcn32_enable_phantom_streams,
 	.subvp_pipe_control_lock = dcn32_subvp_pipe_control_lock,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
+	.subvp_pipe_control_lock_fast = dcn32_subvp_pipe_control_lock_fast,
 	.update_phantom_vp_position = dcn32_update_phantom_vp_position,
 	.update_dsc_pg = dcn32_update_dsc_pg,
 	.apply_update_flags_for_phantom = dcn32_apply_update_flags_for_phantom,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index d8dd143cf6ea..034610b74a37 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -37,6 +37,7 @@
 #include "dwb.h"
 #include "mcif_wb.h"
 #include "panel_cntl.h"
+#include "dmub/inc/dmub_cmd.h"
 
 #define MAX_CLOCK_SOURCES 7
 #define MAX_SVP_PHANTOM_STREAMS 2
@@ -499,6 +500,11 @@ struct bw_context {
 	struct display_mode_lib dml;
 };
 
+struct dc_dmub_cmd {
+	union dmub_rb_cmd dmub_cmd;
+	enum dm_dmub_wait_type wait_type;
+};
+
 /**
  * struct dc_state - The full description of a state requested by users
  */
@@ -547,6 +553,11 @@ struct dc_state {
 	 */
 	struct bw_context bw_ctx;
 
+	struct block_sequence block_sequence[50];
+	unsigned int block_sequence_steps;
+	struct dc_dmub_cmd dc_dmub_cmd[10];
+	unsigned int dmub_cmd_count;
+
 	/**
 	 * @refcount: refcount reference
 	 *
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index df160c6a630c..cc0a3a992f7b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -44,6 +44,112 @@ struct dc_virtual_addr_space_config;
 struct dpp;
 struct dce_hwseq;
 struct link_resource;
+struct dc_dmub_cmd;
+
+struct subvp_pipe_control_lock_fast_params {
+	struct dc *dc;
+	bool lock;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct pipe_control_lock_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+	bool lock;
+};
+
+struct set_flip_control_gsl_params {
+	struct pipe_ctx *pipe_ctx;
+	bool flip_immediate;
+};
+
+struct program_triplebuffer_params {
+	const struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+	bool enableTripleBuffer;
+};
+
+struct update_plane_addr_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct set_input_transfer_func_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+	struct dc_plane_state *plane_state;
+};
+
+struct program_gamut_remap_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct program_manual_trigger_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct send_dmcub_cmd_params {
+	struct dc_context *ctx;
+	union dmub_rb_cmd *cmd;
+	enum dm_dmub_wait_type wait_type;
+};
+
+struct setup_dpp_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct program_bias_and_scale_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct set_output_transfer_func_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+	const struct dc_stream_state *stream;
+};
+
+struct update_visual_confirm_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+	int mpcc_id;
+};
+
+union block_sequence_params {
+	struct update_plane_addr_params update_plane_addr_params;
+	struct subvp_pipe_control_lock_fast_params subvp_pipe_control_lock_fast_params;
+	struct pipe_control_lock_params pipe_control_lock_params;
+	struct set_flip_control_gsl_params set_flip_control_gsl_params;
+	struct program_triplebuffer_params program_triplebuffer_params;
+	struct set_input_transfer_func_params set_input_transfer_func_params;
+	struct program_gamut_remap_params program_gamut_remap_params;
+	struct program_manual_trigger_params program_manual_trigger_params;
+	struct send_dmcub_cmd_params send_dmcub_cmd_params;
+	struct setup_dpp_params setup_dpp_params;
+	struct program_bias_and_scale_params program_bias_and_scale_params;
+	struct set_output_transfer_func_params set_output_transfer_func_params;
+	struct update_visual_confirm_params update_visual_confirm_params;
+};
+
+enum block_sequence_func {
+	DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST = 0,
+	OPTC_PIPE_CONTROL_LOCK,
+	HUBP_SET_FLIP_CONTROL_GSL,
+	HUBP_PROGRAM_TRIPLEBUFFER,
+	HUBP_UPDATE_PLANE_ADDR,
+	DPP_SET_INPUT_TRANSFER_FUNC,
+	DPP_PROGRAM_GAMUT_REMAP,
+	OPTC_PROGRAM_MANUAL_TRIGGER,
+	DMUB_SEND_DMCUB_CMD,
+	DPP_SETUP_DPP,
+	DPP_PROGRAM_BIAS_AND_SCALE,
+	DPP_SET_OUTPUT_TRANSFER_FUNC,
+	MPC_UPDATE_VISUAL_CONFIRM,
+};
+
+struct block_sequence {
+	union block_sequence_params params;
+	enum block_sequence_func func;
+};
 
 struct hw_sequencer_funcs {
 	void (*hardware_release)(struct dc *dc);
@@ -252,6 +358,7 @@ struct hw_sequencer_funcs {
 			const struct tg_color *solid_color,
 			int width, int height, int offset);
 
+	void (*subvp_pipe_control_lock_fast)(union block_sequence_params *params);
 	void (*z10_restore)(const struct dc *dc);
 	void (*z10_save_init)(struct dc *dc);
 
@@ -313,4 +420,23 @@ void get_mclk_switch_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
 
+void hwss_execute_sequence(struct dc *dc,
+		struct block_sequence block_sequence[],
+		int num_steps);
+
+void hwss_build_fast_sequence(struct dc *dc,
+		struct dc_dmub_cmd *dc_dmub_cmd,
+		unsigned int dmub_cmd_count,
+		struct block_sequence block_sequence[],
+		int *num_steps,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_send_dmcub_cmd(union block_sequence_params *params);
+
+void hwss_program_manual_trigger(union block_sequence_params *params);
+
+void hwss_setup_dpp(union block_sequence_params *params);
+
+void hwss_program_bias_and_scale(union block_sequence_params *params);
+
 #endif /* __DC_HW_SEQUENCER_H__ */
-- 
2.40.1

