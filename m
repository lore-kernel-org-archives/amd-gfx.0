Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50352C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8695B10E41E;
	Thu,  5 May 2022 14:24:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B838510E3C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlRmqC0vUrJJOexACy+TJ1Fz0pHE+EpsFROqlshLwha840FSjLRFJyZAlj6AQNeeEcpRIsryE63Puoj1JU2saBzbLtzy6bKRJSJmO9pZMff3Z/uYdfFktEmU/E4bPYFmojAzVorr5PDJqwz8wPGKOGb3qni67JIbGXFjimffDrEM93xbPcFhBFhRCxXzF6ps2YHZYDeyHZojuKwhVuuC3CpwVTw/7adMll3aAgfNFc4CWDjaOAzlRfx79qMWZr6uv9SxnAoIUVGORCJ+9fAbvIJPeeIkdEsS9GuuOAL6odeUN4Iu0XTi/a7flAVZeee7uxNzP1vhxsHHewBiy3ILcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTFXVRrDJuDHUcTP/Eyp6pxt0SwOPN8vl81t67HmjFM=;
 b=TimBmgJTfeZTT8cmDdE507uMbnw/gV46/jOF+azna2xFOy6qsWpxf5Jb3sWtq+hR4mdQF4ExtJn/t8NpMlClwVCac1QRHk+zLUfqdOxZ4YV7sMW+FqRbdxPxEJ8BUQ+QqVl9yyGK8vSsbxePNaIMK/gNneIaFgRaPU1mL60uunEJMxQ3W95x5XnsPDHpS5qAx262fi7D04jiQeP/q6NV4GhbELTHAFW8AO6WNUEXyC5opvFNSEFthtckllhA0i3W/xImN5gx4ggsTIPsFy6sFlddZtTdAfos6uoxjGPNVOOmsqCizZf3t9Odr35qXeQpFbLpqwtvWmHEygcE5HY+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTFXVRrDJuDHUcTP/Eyp6pxt0SwOPN8vl81t67HmjFM=;
 b=0pbN9NwQUZ+ZZ465FJVzOmaqeNMRAENSdFJ0JXMy2vA4RVs9XFehaENxrnKHPJpmN+MXQXoj+lZpUwHb4xuXQ01DRN5idJiP17qjZKNVnHp2AoOs/KvJw0+s7SEjTWmGMxqukq9ResKt+qNHPQhih9jaP4S611iWenFaYa6P6eY=
Received: from DM6PR10CA0011.namprd10.prod.outlook.com (2603:10b6:5:60::24) by
 DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Thu, 5 May 2022 14:24:06 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::89) by DM6PR10CA0011.outlook.office365.com
 (2603:10b6:5:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 14:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:24:06 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:24:04 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/17] drm/amd/display: update cursor position to DMUB FW
Date: Thu, 5 May 2022 10:23:22 -0400
Message-ID: <20220505142323.2566949-17-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f78109f-792b-430d-1b0f-08da2ea2e991
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB628854C7C7565A16598575868DC29@DS7PR12MB6288.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W0Vxk+hOSKH07BRbLGtmy/KEm4Zi2LWCbZ9a/zqH0VvW2+NYxKz9aHPYJP9YCz1GKhAvR9nKpAoFvqDJUwtcdF3nwhT4E11nDEieyaH1vgYPQ3AySB38TXBT1PWJPCnihWoXLJTVn4uopdfLpG/RgVL0tBgW6pJSWBHSTWTPHdRKVxoQ7QYw/gDxySl5qD/AtyuFMBElE8Kx6YyM4HpnvrFF1bxCv7xl3EbQDHDAA+NKfuCRq4wlpOkQI8gAeNAAV0Fo/CJaNyplJghYXzGxWFCBcBwRcUXCo3dwB9MbmUoZLh79oh0lJ2hgB78i98lJ5ZMjjNmS1tTIhx3zfa/C2wxv77+3wglI0mg6EFujuBtvGk37AOiaWyj53wquh1gaUw/7Vkk68q1APxHu5kfZlcOU89ZZ++UbnHCJhjXwxUGXwYfUaZKXweczRm5AFjbXOJBG0cpTAzmO6gcmdvjmnFWKK3ZhRryWG5sNfgfm1CEkPDx1yPjc9yauqIennzUX/oWtXFo5O6Fc7SFUo+bSLKu2iSr+K/fweR7HD13G/XQMCKGMz08yqauXnHLDWHxd86hBQvDeiqimQmLaHWAl3fmO3p3srqBvUvPixdm+KynrV1dz+aoJh507GcmxVyHsVFnf9LZNQs/JW3lE/01ZihBRsU9xPFqFShWG9ijoDeZF2vg2EaStKN0oD7zwlIdZNsbbDGluhLpYxV2LyPLSWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(4326008)(15650500001)(36860700001)(8936002)(1076003)(5660300002)(2616005)(70206006)(6666004)(6916009)(8676002)(70586007)(508600001)(2906002)(54906003)(47076005)(7696005)(356005)(40460700003)(336012)(81166007)(83380400001)(426003)(26005)(82310400005)(186003)(16526019)(86362001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:24:06.3589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f78109f-792b-430d-1b0f-08da2ea2e991
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
To involve the cursor position into dirty rectangle calculation.

[how]
- separate plane and cursor update by different DMUB command
- send the cursor information while cursor updating, when updating
  cursor position/attribute, store cursor pos/attr to hubp, and
  notify dmub FW to exit psr before program cursor registers

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   2 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 131 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 4 files changed, 136 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index 3a7f76e2c598..564e061ccb58 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -1188,6 +1188,8 @@ void hubp1_cursor_set_position(
 	uint32_t dst_x_offset;
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
+	hubp->curs_pos = *pos;
+
 	/*
 	 * Guard aganst cursor_set_position() from being called with invalid
 	 * attributes
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index e02ac75afbf7..b30ba9c3166b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -51,6 +51,8 @@
 #include "link_hwss.h"
 #include "dpcd_defs.h"
 #include "dsc.h"
+#include "dce/dmub_psr.h"
+#include "dc_dmub_srv.h"
 #include "dce/dmub_hw_lock_mgr.h"
 #include "dc_trace.h"
 #include "dce/dmub_outbox.h"
@@ -3327,6 +3329,115 @@ static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 	return false;
 }
 
+static void dcn10_dmub_update_cursor_data(
+		struct pipe_ctx *pipe_ctx,
+		struct hubp *hubp,
+		const struct dc_cursor_mi_param *param,
+		const struct dc_cursor_position *cur_pos,
+		const struct dc_cursor_attributes *cur_attr)
+{
+	union dmub_rb_cmd cmd;
+	struct dmub_cmd_update_cursor_info_data *update_cursor_info;
+	const struct dc_cursor_position *pos;
+	const struct dc_cursor_attributes *attr;
+	int src_x_offset = 0;
+	int src_y_offset = 0;
+	int x_hotspot = 0;
+	int cursor_height = 0;
+	int cursor_width = 0;
+	uint32_t cur_en = 0;
+	unsigned int panel_inst = 0;
+
+	struct dc_debug_options *debug = &hubp->ctx->dc->debug;
+
+	if (!debug->enable_sw_cntl_psr && pipe_ctx->stream->link->psr_settings.psr_version != DC_PSR_VERSION_SU_1)
+		return;
+
+	if (pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED ||
+		pipe_ctx->plane_state->address.type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
+		return;
+
+	/**
+	 * if cur_pos == NULL means the caller is from cursor_set_attribute
+	 * then driver use previous cursor position data
+	 * if cur_attr == NULL means the caller is from cursor_set_position
+	 * then driver use previous cursor attribute
+	 * if cur_pos or cur_attr is not NULL then update it
+	 */
+	if (cur_pos != NULL)
+		pos = cur_pos;
+	else
+		pos = &hubp->curs_pos;
+
+	if (cur_attr != NULL)
+		attr = cur_attr;
+	else
+		attr = &hubp->curs_attr;
+
+	if (!dc_get_edp_link_panel_inst(hubp->ctx->dc, pipe_ctx->stream->link, &panel_inst))
+		return;
+
+	src_x_offset = pos->x - pos->x_hotspot - param->viewport.x;
+	src_y_offset = pos->y - pos->y_hotspot - param->viewport.y;
+	x_hotspot = pos->x_hotspot;
+	cursor_height = (int)attr->height;
+	cursor_width = (int)attr->width;
+	cur_en = pos->enable ? 1:0;
+
+	// Rotated cursor width/height and hotspots tweaks for offset calculation
+	if (param->rotation == ROTATION_ANGLE_90 || param->rotation == ROTATION_ANGLE_270) {
+		swap(cursor_height, cursor_width);
+		if (param->rotation == ROTATION_ANGLE_90) {
+			src_x_offset = pos->x - pos->y_hotspot - param->viewport.x;
+			src_y_offset = pos->y - pos->x_hotspot - param->viewport.y;
+		}
+	} else if (param->rotation == ROTATION_ANGLE_180) {
+		src_x_offset = pos->x - param->viewport.x;
+		src_y_offset = pos->y - param->viewport.y;
+	}
+
+	if (param->mirror) {
+		x_hotspot = param->viewport.width - x_hotspot;
+		src_x_offset = param->viewport.x + param->viewport.width - src_x_offset;
+	}
+
+	if (src_x_offset >= (int)param->viewport.width)
+		cur_en = 0;  /* not visible beyond right edge*/
+
+	if (src_x_offset + cursor_width <= 0)
+		cur_en = 0;  /* not visible beyond left edge*/
+
+	if (src_y_offset >= (int)param->viewport.height)
+		cur_en = 0;  /* not visible beyond bottom edge*/
+
+	if (src_y_offset + cursor_height <= 0)
+		cur_en = 0;  /* not visible beyond top edge*/
+
+	// Cursor bitmaps have different hotspot values
+	// There's a possibility that the above logic returns a negative value, so we clamp them to 0
+	if (src_x_offset < 0)
+		src_x_offset = 0;
+	if (src_y_offset < 0)
+		src_y_offset = 0;
+
+	memset(&cmd, 0x0, sizeof(cmd));
+	cmd.update_cursor_info.header.type = DMUB_CMD__UPDATE_CURSOR_INFO;
+	cmd.update_cursor_info.header.payload_bytes =
+			sizeof(cmd.update_cursor_info.update_cursor_info_data);
+	update_cursor_info = &cmd.update_cursor_info.update_cursor_info_data;
+	update_cursor_info->cursor_rect.x = src_x_offset + param->viewport.x;
+	update_cursor_info->cursor_rect.y = src_y_offset + param->viewport.y;
+	update_cursor_info->cursor_rect.width = attr->width;
+	update_cursor_info->cursor_rect.height = attr->height;
+	update_cursor_info->enable = cur_en;
+	update_cursor_info->pipe_idx = pipe_ctx->pipe_idx;
+	update_cursor_info->cmd_version = DMUB_CMD_PSR_CONTROL_VERSION_1;
+	update_cursor_info->panel_inst = panel_inst;
+	dc_dmub_srv_cmd_queue(pipe_ctx->stream->ctx->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(pipe_ctx->stream->ctx->dmub_srv);
+	dc_dmub_srv_wait_idle(pipe_ctx->stream->ctx->dmub_srv);
+}
+
 void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_cursor_position pos_cpy = pipe_ctx->stream->cursor_position;
@@ -3525,6 +3636,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 			pipe_ctx->plane_res.scl_data.viewport.height - pos_cpy.y;
 	}
 
+	dcn10_dmub_update_cursor_data(pipe_ctx, hubp, &param, &pos_cpy, NULL);
 	hubp->funcs->set_cursor_position(hubp, &pos_cpy, &param);
 	dpp->funcs->set_cursor_position(dpp, &pos_cpy, &param, hubp->curs_attr.width, hubp->curs_attr.height);
 }
@@ -3532,6 +3644,25 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 void dcn10_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_cursor_attributes *attributes = &pipe_ctx->stream->cursor_attributes;
+	struct dc_cursor_mi_param param = { 0 };
+
+	/**
+	 * If enter PSR without cursor attribute update
+	 * the cursor attribute of dmub_restore_plane
+	 * are initial value. call dmub to exit PSR and
+	 * restore plane then update cursor attribute to
+	 * avoid override with initial value
+	 */
+	if (pipe_ctx->plane_state != NULL) {
+		param.pixel_clk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
+		param.ref_clk_khz = pipe_ctx->stream->ctx->dc->res_pool->ref_clocks.dchub_ref_clock_inKhz;
+		param.viewport = pipe_ctx->plane_res.scl_data.viewport;
+		param.h_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.horz;
+		param.v_scale_ratio = pipe_ctx->plane_res.scl_data.ratios.vert;
+		param.rotation = pipe_ctx->plane_state->rotation;
+		param.mirror = pipe_ctx->plane_state->horizontal_mirror;
+		dcn10_dmub_update_cursor_data(pipe_ctx, pipe_ctx->plane_res.hubp, &param, NULL, attributes);
+	}
 
 	pipe_ctx->plane_res.hubp->funcs->set_cursor_attributes(
 			pipe_ctx->plane_res.hubp, attributes);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index a665af19f201..9570c2118ccc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -967,6 +967,8 @@ void hubp2_cursor_set_position(
 	uint32_t dst_x_offset;
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
+	hubp->curs_pos = *pos;
+
 	/*
 	 * Guard aganst cursor_set_position() from being called with invalid
 	 * attributes
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index ad69d78c4ac3..fc53ee013557 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -63,6 +63,7 @@ struct hubp {
 	int opp_id;
 	int mpcc_id;
 	struct dc_cursor_attributes curs_attr;
+	struct dc_cursor_position curs_pos;
 	bool power_gated;
 };
 
-- 
2.25.1

