Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC06AC54EBE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 663D610E60C;
	Tue, 10 Jan 2023 16:57:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0367110E60C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN+k5AjVUSJmckTtzrpSQKldTwu+GvgX3P9F00Po6R3Oa5V2k2rtzvO8fSVsd1xW5Pdl4r/JCmC2jwwS6+R/rm46XdwBhGX1mzAfPuKPVJrzxm5CX92T6J6FZ4KwGHJ/e08YPsc3HpD6yvZQGq6TjB+SSQZvspUWnyvjs2s02BOVyW+1tFJpPOaeSIXXw9wndIS7kul2NLWA6dGPPt7qHNrm4ng2a2n7C8Iqk24sMcyQB+8yut64SyzDC0Y5lmg0/uOzJepIU5qNOD0XKqr9qXT1Yi98sLBPCyWVfWcxqABA34LL+26p47G3+uwZP9rbarE7zKhNU4wlB9uC2vRpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5aCWzZDj9eU3+N0FcKuEmE7tZd02oZdo9y1OOWkK6c=;
 b=SHkXu3au+xxz0cYXUB1LcKp8oui5A47brsbWIkKF9akorDi9StbJu7A7IE2nVeyMUtLpMgkt4248ABP8xXUvZJOjpKP6xP32j5Wol2AHc7SONxpVPieT4ptz2TgG7Fl2mAb4eaRvlfpR6kKAso1pjvMYJLZbA3Z2ERSBIH8zV/SsyXdX5/9ZE772qP0yipjhn5KmxUdSWtvoMWzx2bkjbtx4lh2MaeKi6sIzjvetQj4zy6IfrQeRQWDzq/ayqCFY5/fs7vquD8BsmarbxltW67rU5M9bblHL+Ii6cK16bcR9rKA41saYSgtal233knqdxWQq4EZPKRexseQS9GIs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5aCWzZDj9eU3+N0FcKuEmE7tZd02oZdo9y1OOWkK6c=;
 b=hSZWQsptJx6l7+w/aIRrThFZ/SsB+jzCepYeJU9Jy3ybv+QDA45TXoUJHXEQrK1rThvvPPPmHMnrEp05737MvoG3XN7gexi8RMx2OSyhubCZEJ/NnvWJZONKjCJq+6rNlsVvZLuX0irlu+8LYsCy/Lm23+O/VvdXOe2JINqiWrY=
Received: from MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::9) by
 DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 16:57:53 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::e0) by MW4P221CA0004.outlook.office365.com
 (2603:10b6:303:8b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:57:53 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:57:18 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/37] drm/amd/display: Use DML for MALL SS and Subvp
 allocation calculations
Date: Tue, 10 Jan 2023 11:55:13 -0500
Message-ID: <20230110165535.3358492-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbd16b4-ef3d-4d2a-b903-08daf32bd09a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYMqmu+5W4OgZB9GHjQQnI0HPY2QWvAY500LaI/djSYMMgoLyyQhHqL2hxAjOyQ/PNTuyk4APqd6fDkKAiSgE3ItnoNNBzyWu7s+2YX+lN+E6q8rh5hj1TlF94OO5Z+F2F/KZAr0WAmtpgD8ZiQij4ZXs4S37c2YOhJkgXLOq2NECQib7VNZzcxVOqMgxEPPzefReiX60mPK24gFgO865TZdDiD/Y2Eu/GhSKkz75gtehrcL4Xnt2ScdhXW5oGXeinWQYJCUnRgqlizhGRBWIYwArw1Dha3DLOjrPL798VDz8h4EM6c8QKWdtZ726wxxqnZxNB2PlIfxAopxwG2WGZ43oBV8P0CStUy65vbkSh5tSpXwlhWwW2vnnskKijvcZ4MEG2mfCuhmYS7NFAmiP4DF9C949L7mS9ZHVNe2IiyNzC9Nj28PtdMaf16bvSTyacXG78yqNSSUcWRcgtT1o5OdgfR5lbseMHFijhOKS+ZMEBV5vYipmYsaAeuSM/TQCGQq4VcoUfFHBMi0k+GgSZgupjAXP0yhRH5H/4zJXB/05HbItcfA9IGezinGT6seUKdGvpo26IAFP3sH2d+StAXz47V56nTs9YjtmIds5mb8u16+xtAaay0HzEIhaN+fxkt62W3Zo3EGJdSCDezUEZ3L6QI+6TqAkZwtUSxg1rZRQL+iDymbbVR5VBmPVSpWsYB8/+xsdYIygALsg77yEDYkJ5+urHqiwG99oHxpzLw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(47076005)(6666004)(478600001)(40480700001)(2616005)(1076003)(4326008)(26005)(336012)(186003)(70206006)(316002)(8676002)(6916009)(70586007)(16526019)(54906003)(7696005)(36860700001)(40460700003)(86362001)(82740400003)(356005)(81166007)(426003)(83380400001)(82310400005)(41300700001)(5660300002)(36756003)(30864003)(2906002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:57:53.3728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbd16b4-ef3d-4d2a-b903-08daf32bd09a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

MALL SS and Subvp use the same calculations for determining the size of
the required allocation for a given surface, which is already done in
DML. Add an interface to extract this information from VBA variables and
use in their respective helper functions. Also refactor existing code to
remove stale workarounds.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 146 ++-------------
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  13 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c | 175 ++++++++----------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  29 ++-
 .../drm/amd/display/dc/dml/display_mode_vba.c |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   6 +-
 7 files changed, 134 insertions(+), 237 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index f2cffb96ebf1..07362c66f023 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -207,151 +207,31 @@ static bool dcn32_check_no_memory_request_for_cab(struct dc *dc)
  */
 static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *ctx)
 {
-	int i, j;
-	struct dc_stream_state *stream = NULL;
-	struct dc_plane_state *plane = NULL;
-	uint32_t cursor_size = 0;
-	uint32_t total_lines = 0;
-	uint32_t lines_per_way = 0;
+	int i;
 	uint8_t num_ways = 0;
-	uint8_t bytes_per_pixel = 0;
-	uint8_t cursor_bpp = 0;
-	uint16_t mblk_width = 0;
-	uint16_t mblk_height = 0;
-	uint16_t mall_alloc_width_blk_aligned = 0;
-	uint16_t mall_alloc_height_blk_aligned = 0;
-	uint16_t num_mblks = 0;
-	uint32_t bytes_in_mall = 0;
-	uint32_t cache_lines_used = 0;
-	uint32_t cache_lines_per_plane = 0;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-
-		/* If PSR is supported on an eDP panel that's connected, but that panel is
-		 * not in PSR at the time of trying to enter MALL SS, we have to include it
-		 * in the static screen CAB calculation
-		 */
-		if (!pipe->stream || !pipe->plane_state ||
-				(pipe->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
-				pipe->stream->link->psr_settings.psr_allow_active) ||
-				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM)
-			continue;
-
-		bytes_per_pixel = pipe->plane_state->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4;
-		mblk_width = DCN3_2_MBLK_WIDTH;
-		mblk_height = bytes_per_pixel == 4 ? DCN3_2_MBLK_HEIGHT_4BPE : DCN3_2_MBLK_HEIGHT_8BPE;
-
-		/* full_vp_width_blk_aligned = FLOOR(vp_x_start + full_vp_width + blk_width - 1, blk_width) -
-		 * FLOOR(vp_x_start, blk_width)
-		 *
-		 * mall_alloc_width_blk_aligned_l/c = full_vp_width_blk_aligned_l/c
-		 */
-		mall_alloc_width_blk_aligned = ((pipe->plane_res.scl_data.viewport.x +
-				pipe->plane_res.scl_data.viewport.width + mblk_width - 1) / mblk_width * mblk_width) -
-						(pipe->plane_res.scl_data.viewport.x / mblk_width * mblk_width);
-
-		/* full_vp_height_blk_aligned = FLOOR(vp_y_start + full_vp_height + blk_height - 1, blk_height) -
-		 * FLOOR(vp_y_start, blk_height)
-		 *
-		 * mall_alloc_height_blk_aligned_l/c = full_vp_height_blk_aligned_l/c
-		 */
-		mall_alloc_height_blk_aligned = ((pipe->plane_res.scl_data.viewport.y +
-				pipe->plane_res.scl_data.viewport.height + mblk_height - 1) / mblk_height * mblk_height) -
-						(pipe->plane_res.scl_data.viewport.y / mblk_height * mblk_height);
-
-		num_mblks = ((mall_alloc_width_blk_aligned + mblk_width - 1) / mblk_width) *
-				((mall_alloc_height_blk_aligned + mblk_height - 1) / mblk_height);
-
-		/*For DCC:
-		 * meta_num_mblk = CEILING(meta_pitch*full_vp_height*Bpe/256/mblk_bytes, 1)
-		 */
-		if (pipe->plane_state->dcc.enable)
-			num_mblks += (pipe->plane_state->dcc.meta_pitch * pipe->plane_res.scl_data.viewport.height * bytes_per_pixel +
-					(256 * DCN3_2_MALL_MBLK_SIZE_BYTES) - 1) / (256 * DCN3_2_MALL_MBLK_SIZE_BYTES);
+	uint32_t mall_ss_size_bytes = 0;
 
-		bytes_in_mall = num_mblks * DCN3_2_MALL_MBLK_SIZE_BYTES;
-
-		/* (cache lines used is total bytes / cache_line size. Add +2 for worst case alignment
-		 * (MALL is 64-byte aligned)
-		 */
-		cache_lines_per_plane = bytes_in_mall / dc->caps.cache_line_size + 2;
-		cache_lines_used += cache_lines_per_plane;
-	}
+	mall_ss_size_bytes = ctx->bw_ctx.bw.dcn.mall_ss_size_bytes;
+	// TODO add additional logic for PSR active stream exclusion optimization
+	// mall_ss_psr_active_size_bytes = ctx->bw_ctx.bw.dcn.mall_ss_psr_active_size_bytes;
 
 	// Include cursor size for CAB allocation
-	for (j = 0; j < dc->res_pool->pipe_count; j++) {
-		struct pipe_ctx *pipe = &ctx->res_ctx.pipe_ctx[j];
-		struct hubp *hubp = pipe->plane_res.hubp;
-
-		if (pipe->stream && pipe->plane_state && hubp)
-			/* Find the cursor plane and use the exact size instead of
-			using the max for calculation */
-
-		if (hubp->curs_attr.width > 0) {
-				cursor_size = hubp->curs_attr.pitch * hubp->curs_attr.height;
-
-				switch (pipe->stream->cursor_attributes.color_format) {
-				case CURSOR_MODE_MONO:
-					cursor_size /= 2;
-					cursor_bpp = 4;
-					break;
-				case CURSOR_MODE_COLOR_1BIT_AND:
-				case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
-				case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
-					cursor_size *= 4;
-					cursor_bpp = 4;
-					break;
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &ctx->res_ctx.pipe_ctx[i];
 
-				case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
-				case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
-					cursor_size *= 8;
-					cursor_bpp = 8;
-					break;
-				}
+		if (!pipe->stream || !pipe->plane_state)
+			continue;
 
-				if (pipe->stream->cursor_position.enable && !dc->debug.alloc_extra_way_for_cursor &&
-						cursor_size > 16384) {
-					/* cursor_num_mblk = CEILING(num_cursors*cursor_width*cursor_width*cursor_Bpe/mblk_bytes, 1)
-					 */
-					cache_lines_used += (((cursor_size + DCN3_2_MALL_MBLK_SIZE_BYTES - 1) /
-							DCN3_2_MALL_MBLK_SIZE_BYTES) * DCN3_2_MALL_MBLK_SIZE_BYTES) /
-							dc->caps.cache_line_size + 2;
-					break;
-				}
-			}
+		mall_ss_size_bytes += dcn32_helper_calculate_mall_bytes_for_cursor(dc, pipe, false);
 	}
 
 	// Convert number of cache lines required to number of ways
-	total_lines = dc->caps.max_cab_allocation_bytes / dc->caps.cache_line_size;
-	lines_per_way = total_lines / dc->caps.cache_num_ways;
-	num_ways = cache_lines_used / lines_per_way;
-
-	if (cache_lines_used % lines_per_way > 0)
-		num_ways++;
-
-	for (i = 0; i < ctx->stream_count; i++) {
-		stream = ctx->streams[i];
-		for (j = 0; j < ctx->stream_status[i].plane_count; j++) {
-			plane = ctx->stream_status[i].plane_states[j];
-
-			if (stream->cursor_position.enable && plane &&
-					dc->debug.alloc_extra_way_for_cursor &&
-					cursor_size > 16384) {
-				/* Cursor caching is not supported since it won't be on the same line.
-				 * So we need an extra line to accommodate it. With large cursors and a single 4k monitor
-				 * this case triggers corruption. If we're at the edge, then dont trigger display refresh
-				 * from MALL. We only need to cache cursor if its greater that 64x64 at 4 bpp.
-				 */
-				num_ways++;
-				/* We only expect one cursor plane */
-				break;
-			}
-		}
-	}
 	if (dc->debug.force_mall_ss_num_ways > 0) {
 		num_ways = dc->debug.force_mall_ss_num_ways;
+	} else {
+		num_ways = dcn32_helper_mall_bytes_to_ways(dc, mall_ss_size_bytes);
 	}
+
 	return num_ways;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 57ce1d670abe..40cda0f4c12c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -96,8 +96,17 @@ void dcn32_calculate_wm_and_dlg(
 		int pipe_cnt,
 		int vlevel);
 
-uint32_t dcn32_helper_calculate_num_ways_for_subvp
-		(struct dc *dc,
+uint32_t dcn32_helper_mall_bytes_to_ways(
+		struct dc *dc,
+		uint32_t total_size_in_mall_bytes);
+
+uint32_t dcn32_helper_calculate_mall_bytes_for_cursor(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool ignore_cursor_buf);
+
+uint32_t dcn32_helper_calculate_num_ways_for_subvp(
+		struct dc *dc,
 		struct dc_state *context);
 
 void dcn32_merge_pipes_for_subvp(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index e5287e5f66d5..50f20549c951 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -33,13 +33,75 @@ static bool is_dual_plane(enum surface_pixel_format format)
 	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
 }
 
+
+uint32_t dcn32_helper_mall_bytes_to_ways(
+		struct dc *dc,
+		uint32_t total_size_in_mall_bytes)
+{
+	uint32_t cache_lines_used, lines_per_way, total_cache_lines, num_ways;
+
+	/* add 2 lines for worst case alignment */
+	cache_lines_used = total_size_in_mall_bytes / dc->caps.cache_line_size + 2;
+
+	total_cache_lines = dc->caps.max_cab_allocation_bytes / dc->caps.cache_line_size;
+	lines_per_way = total_cache_lines / dc->caps.cache_num_ways;
+	num_ways = cache_lines_used / lines_per_way;
+	if (cache_lines_used % lines_per_way > 0)
+		num_ways++;
+
+	return num_ways;
+}
+
+uint32_t dcn32_helper_calculate_mall_bytes_for_cursor(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool ignore_cursor_buf)
+{
+	struct hubp *hubp = pipe_ctx->plane_res.hubp;
+	uint32_t cursor_size = hubp->curs_attr.pitch * hubp->curs_attr.height;
+	uint32_t cursor_bpp = 4;
+	uint32_t cursor_mall_size_bytes = 0;
+
+	switch (pipe_ctx->stream->cursor_attributes.color_format) {
+	case CURSOR_MODE_MONO:
+		cursor_size /= 2;
+		cursor_bpp = 4;
+		break;
+	case CURSOR_MODE_COLOR_1BIT_AND:
+	case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
+	case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
+		cursor_size *= 4;
+		cursor_bpp = 4;
+		break;
+
+	case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
+	case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
+		cursor_size *= 8;
+		cursor_bpp = 8;
+		break;
+	}
+
+	/* only count if cursor is enabled, and if additional allocation needed outside of the
+	 * DCN cursor buffer
+	 */
+	if (pipe_ctx->stream->cursor_position.enable && (ignore_cursor_buf ||
+			cursor_size > 16384)) {
+		/* cursor_num_mblk = CEILING(num_cursors*cursor_width*cursor_width*cursor_Bpe/mblk_bytes, 1)
+		 * Note: add 1 mblk in case of cursor misalignment
+		 */
+		cursor_mall_size_bytes = ((cursor_size + DCN3_2_MALL_MBLK_SIZE_BYTES - 1) /
+				DCN3_2_MALL_MBLK_SIZE_BYTES + 1) * DCN3_2_MALL_MBLK_SIZE_BYTES;
+	}
+
+	return cursor_mall_size_bytes;
+}
+
 /**
  * ********************************************************************************************
  * dcn32_helper_calculate_num_ways_for_subvp: Calculate number of ways needed for SubVP
  *
- * This function first checks the bytes required per pixel on the SubVP pipe, then calculates
- * the total number of pixels required in the SubVP MALL region. These are used to calculate
- * the number of cache lines used (then number of ways required) for SubVP MCLK switching.
+ * Gets total allocation required for the phantom viewport calculated by DML in bytes and
+ * converts to number of cache ways.
  *
  * @param [in] dc: current dc state
  * @param [in] context: new dc state
@@ -48,106 +110,19 @@ static bool is_dual_plane(enum surface_pixel_format format)
  *
  * ********************************************************************************************
  */
-uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_state *context)
+uint32_t dcn32_helper_calculate_num_ways_for_subvp(
+		struct dc *dc,
+		struct dc_state *context)
 {
-	uint32_t num_ways = 0;
-	uint32_t bytes_per_pixel = 0;
-	uint32_t cache_lines_used = 0;
-	uint32_t lines_per_way = 0;
-	uint32_t total_cache_lines = 0;
-	uint32_t bytes_in_mall = 0;
-	uint32_t num_mblks = 0;
-	uint32_t cache_lines_per_plane = 0;
-	uint32_t i = 0, j = 0;
-	uint16_t mblk_width = 0;
-	uint16_t mblk_height = 0;
-	uint32_t full_vp_width_blk_aligned = 0;
-	uint32_t full_vp_height_blk_aligned = 0;
-	uint32_t mall_alloc_width_blk_aligned = 0;
-	uint32_t mall_alloc_height_blk_aligned = 0;
-	uint16_t full_vp_height = 0;
-	bool subvp_in_use = false;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
-		/* Find the phantom pipes.
-		 * - For pipe split case we need to loop through the bottom and next ODM
-		 *   pipes or only half the viewport size is counted
-		 */
-		if (pipe->stream && pipe->plane_state &&
-				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
-			struct pipe_ctx *main_pipe = NULL;
-
-			subvp_in_use = true;
-			/* Get full viewport height from main pipe (required for MBLK calculation) */
-			for (j = 0; j < dc->res_pool->pipe_count; j++) {
-				main_pipe = &context->res_ctx.pipe_ctx[j];
-				if (main_pipe->stream == pipe->stream->mall_stream_config.paired_stream) {
-					full_vp_height = main_pipe->plane_res.scl_data.viewport.height;
-					break;
-				}
-			}
-
-			bytes_per_pixel = pipe->plane_state->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4;
-			mblk_width = DCN3_2_MBLK_WIDTH;
-			mblk_height = bytes_per_pixel == 4 ? DCN3_2_MBLK_HEIGHT_4BPE : DCN3_2_MBLK_HEIGHT_8BPE;
-
-			/* full_vp_width_blk_aligned = FLOOR(vp_x_start + full_vp_width + blk_width - 1, blk_width) -
-			 * FLOOR(vp_x_start, blk_width)
-			 */
-			full_vp_width_blk_aligned = ((pipe->plane_res.scl_data.viewport.x +
-					pipe->plane_res.scl_data.viewport.width + mblk_width - 1) / mblk_width * mblk_width) -
-					(pipe->plane_res.scl_data.viewport.x / mblk_width * mblk_width);
-
-			/* full_vp_height_blk_aligned = FLOOR(vp_y_start + full_vp_height + blk_height - 1, blk_height) -
-			 * FLOOR(vp_y_start, blk_height)
-			 */
-			full_vp_height_blk_aligned = ((pipe->plane_res.scl_data.viewport.y +
-					full_vp_height + mblk_height - 1) / mblk_height * mblk_height) -
-					(pipe->plane_res.scl_data.viewport.y / mblk_height * mblk_height);
-
-			/* mall_alloc_width_blk_aligned_l/c = full_vp_width_blk_aligned_l/c */
-			mall_alloc_width_blk_aligned = full_vp_width_blk_aligned;
-
-			/* mall_alloc_height_blk_aligned_l/c = CEILING(sub_vp_height_l/c - 1, blk_height_l/c) + blk_height_l/c */
-			mall_alloc_height_blk_aligned = (pipe->plane_res.scl_data.viewport.height - 1 + mblk_height - 1) /
-					mblk_height * mblk_height + mblk_height;
-
-			/* full_mblk_width_ub_l/c = mall_alloc_width_blk_aligned_l/c;
-			 * full_mblk_height_ub_l/c = mall_alloc_height_blk_aligned_l/c;
-			 * num_mblk_l/c = (full_mblk_width_ub_l/c / mblk_width_l/c) * (full_mblk_height_ub_l/c / mblk_height_l/c);
-			 * (Should be divisible, but round up if not)
-			 */
-			num_mblks = ((mall_alloc_width_blk_aligned + mblk_width - 1) / mblk_width) *
-					((mall_alloc_height_blk_aligned + mblk_height - 1) / mblk_height);
-
-			/*For DCC:
-			 * meta_num_mblk = CEILING(meta_pitch*full_vp_height*Bpe/256/mblk_bytes, 1)
-			 */
-			if (pipe->plane_state->dcc.enable)
-				num_mblks += (pipe->plane_state->dcc.meta_pitch * pipe->plane_res.scl_data.viewport.height * bytes_per_pixel +
-								(256 * DCN3_2_MALL_MBLK_SIZE_BYTES) - 1) / (256 * DCN3_2_MALL_MBLK_SIZE_BYTES);
-
-			bytes_in_mall = num_mblks * DCN3_2_MALL_MBLK_SIZE_BYTES;
-			// cache lines used is total bytes / cache_line size. Add +2 for worst case alignment
-			// (MALL is 64-byte aligned)
-			cache_lines_per_plane = bytes_in_mall / dc->caps.cache_line_size + 2;
-
-			cache_lines_used += cache_lines_per_plane;
+	if (context->bw_ctx.bw.dcn.mall_subvp_size_bytes > 0) {
+		if (dc->debug.force_subvp_num_ways) {
+			return dc->debug.force_subvp_num_ways;
+		} else {
+			return dcn32_helper_mall_bytes_to_ways(dc, context->bw_ctx.bw.dcn.mall_subvp_size_bytes);
 		}
+	} else {
+		return 0;
 	}
-
-	total_cache_lines = dc->caps.max_cab_allocation_bytes / dc->caps.cache_line_size;
-	lines_per_way = total_cache_lines / dc->caps.cache_num_ways;
-	num_ways = cache_lines_used / lines_per_way;
-	if (cache_lines_used % lines_per_way > 0)
-		num_ways++;
-
-	if (subvp_in_use && dc->debug.force_subvp_num_ways > 0)
-		num_ways = dc->debug.force_subvp_num_ways;
-
-	return num_ways;
 }
 
 void dcn32_merge_pipes_for_subvp(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 0c7ddd6f05b5..f2597c966510 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1291,7 +1291,6 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 	context->bw_ctx.bw.dcn.clk.p_state_change_support =
 			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb]
 					!= dm_dram_clock_change_unsupported;
-	context->bw_ctx.bw.dcn.clk.num_ways = dcn32_helper_calculate_num_ways_for_subvp(dc, context);
 
 	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
 	context->bw_ctx.bw.dcn.clk.dtbclk_en = is_dtbclk_required(dc, context);
@@ -1315,6 +1314,10 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 		unbounded_req_enabled = false;
 	}
 
+	context->bw_ctx.bw.dcn.mall_ss_size_bytes = 0;
+	context->bw_ctx.bw.dcn.mall_ss_psr_active_size_bytes = 0;
+	context->bw_ctx.bw.dcn.mall_subvp_size_bytes = 0;
+
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
@@ -1346,6 +1349,28 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 		else
 			context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = 0;
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
+
+		context->res_ctx.pipe_ctx[i].surface_size_in_mall_bytes = get_surface_size_in_mall(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+
+		/* MALL Allocation Sizes */
+		/* count from active, top pipes only */
+		if (context->res_ctx.pipe_ctx[i].stream && context->res_ctx.pipe_ctx[i].plane_state &&
+				context->res_ctx.pipe_ctx[i].top_pipe == NULL &&
+				context->res_ctx.pipe_ctx[i].prev_odm_pipe == NULL) {
+			/* SS: all active surfaces stored in MALL */
+			if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type != SUBVP_PHANTOM) {
+				context->bw_ctx.bw.dcn.mall_ss_size_bytes += context->res_ctx.pipe_ctx[i].surface_size_in_mall_bytes;
+
+				if (context->res_ctx.pipe_ctx[i].stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED) {
+					/* SS PSR On: all active surfaces part of streams not supporting PSR stored in MALL */
+					context->bw_ctx.bw.dcn.mall_ss_psr_active_size_bytes += context->res_ctx.pipe_ctx[i].surface_size_in_mall_bytes;
+				}
+			} else if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
+				/* SUBVP: phantom surfaces only stored in MALL */
+				context->bw_ctx.bw.dcn.mall_subvp_size_bytes += context->res_ctx.pipe_ctx[i].surface_size_in_mall_bytes;
+			}
+		}
+
 		pipe_idx++;
 	}
 	/* If DCN isn't making memory requests we can allow pstate change and lower clocks */
@@ -1366,6 +1391,8 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 	context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = context->bw_ctx.dml.soc.clock_limits[vlevel].dispclk_mhz
 			* 1000;
 
+	context->bw_ctx.bw.dcn.clk.num_ways = dcn32_helper_calculate_num_ways_for_subvp(dc, context);
+
 	context->bw_ctx.bw.dcn.compbuf_size_kb = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 8e6585dab20e..8cb28b7918db 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -202,6 +202,7 @@ dml_get_pipe_attr_func(vm_group_size_in_bytes, mode_lib->vba.vm_group_bytes);
 dml_get_pipe_attr_func(dpte_row_height_linear_l, mode_lib->vba.dpte_row_height_linear);
 dml_get_pipe_attr_func(pte_buffer_mode, mode_lib->vba.PTE_BUFFER_MODE);
 dml_get_pipe_attr_func(subviewport_lines_needed_in_mall, mode_lib->vba.SubViewportLinesNeededInMALL);
+dml_get_pipe_attr_func(surface_size_in_mall, mode_lib->vba.SurfaceSizeInMALL)
 
 double get_total_immediate_flip_bytes(
 		struct display_mode_lib *mode_lib,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 81e53e67cd0b..876b9b517ea2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -143,6 +143,7 @@ dml_get_pipe_attr_decl(vready_at_or_after_vsync);
 dml_get_pipe_attr_decl(min_dst_y_next_start);
 dml_get_pipe_attr_decl(vstartup_calculated);
 dml_get_pipe_attr_decl(subviewport_lines_needed_in_mall);
+dml_get_pipe_attr_decl(surface_size_in_mall);
 
 double get_total_immediate_flip_bytes(
 		struct display_mode_lib *mode_lib,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index b093ea495468..bebfcf8737b3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -450,10 +450,11 @@ struct pipe_ctx {
 	struct _vcs_dpi_display_e2e_pipe_params_st dml_input;
 	int det_buffer_size_kb;
 	bool unbounded_req;
+	unsigned int surface_size_in_mall_bytes;
 
-	union pipe_update_flags update_flags;
 	struct dwbc *dwbc;
 	struct mcif_wb *mcif_wb;
+	union pipe_update_flags update_flags;
 };
 
 /* Data used for dynamic link encoder assignment.
@@ -507,6 +508,9 @@ struct dcn_bw_output {
 	struct dcn_watermark_set watermarks;
 	struct dcn_bw_writeback bw_writeback;
 	int compbuf_size_kb;
+	unsigned int mall_ss_size_bytes;
+	unsigned int mall_ss_psr_active_size_bytes;
+	unsigned int mall_subvp_size_bytes;
 	unsigned int legacy_svp_drr_stream_index;
 	bool legacy_svp_drr_stream_index_valid;
 };
-- 
2.39.0

