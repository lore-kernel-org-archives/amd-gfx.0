Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99EBC0502A
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D3B10EB75;
	Sat, 27 Aug 2022 02:51:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E8310EB72
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEFbgTtIi0qJebOu67G0aXZgGE7mWK0w+LtmMM8EOgq23YouZ1vUH0PVKMxVHNtd8ZqqbTQTd0ayUZ4aY8t5rXUqqbZcTbnhbUw1MEMXGMfFxoHVMzguWVUXYoWdv+gYWWi9NZMHGyVS1Wb+eshreA9ozhrJmgOcZQGD8XH3N+aWARqN5Zj89nG4N8DHSlVgoXhaB4oUs5GPFP6OmDpV0eQgpuRWeHlWraj9ytIdnQNe/LTcedjM/W+EhJlyDfynSysPuRp9ajoadiAO+yFX/QhZF1T0WUpVsBJ7PnR3ZV90Jf9HpWaQIiYYSY4gTe26rzrgZJPOewBCZVRHET2uoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hl1QN+c6EblCygSrVSOlt3Qjzr/iHEgd1+irIFM6Fs=;
 b=O+HS6UzwSY/vv6RibTw/9GlPvQKoYhPz9+Daz/4mZrImaC6yM/qBRhHkFcybA1ALCp/JtatkvygnJYNzBQDxHTgE8I0NSbPNxAAJcZDQaFl7Bkh3XzV2wXVzYqY7A9++V3eKGbbazcfyVvkh09RKh+C8ySrZAx0gAxNWp9QoLJ7Bj5kEFySOg4z1Cz4PPfQIxfp3O/8cSuPWvSlkg1M4gI70m8cX9fIsNYuZmAODB2zWM5BoJq/9rmBAcBysagguKZf3XJ4EkV1fXyX1Q2B1uXDU+N5YpsI0qwj8XLm1TmRrZAeZQLAAcaR/gwpmjBN2Oi7yvC3xkCjLCTgr052uaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hl1QN+c6EblCygSrVSOlt3Qjzr/iHEgd1+irIFM6Fs=;
 b=wb2diuf/lZmUWkn2kUgAUyJMS7h2KAm1TVYNLaVyFglEtxjFOSb/OpS7A/cG9rAjKjIndG0GrllvbpaRc7EVeRdLrrhaA1ejgBwFUcSGScoDhn+kTHKtq+xhLA7nRjcGOl7lnP+ua2ten60jhbhAx8DU4n/f7T+bgkltAdhl5vA=
Received: from CY5PR19CA0024.namprd19.prod.outlook.com (2603:10b6:930:15::17)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:51:26 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::75) by CY5PR19CA0024.outlook.office365.com
 (2603:10b6:930:15::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Sat, 27 Aug 2022 02:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Sat, 27 Aug 2022 02:51:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:25 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:51:21
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/33] drm/amd/display: Add support for visual confirm color
Date: Sat, 27 Aug 2022 06:50:36 +0800
Message-ID: <20220826225053.1435588-17-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d629e42-f7bd-4584-11e7-08da87d708fb
X-MS-TrafficTypeDiagnostic: MN0PR12MB6319:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51Hnlw0ATe3HTUy7D5ePZtdinH3dlMAqt/+0u6suPlYH8r5IvCIllxHX66KLgi8SJKu7jDFQGPWSycG2bWTb8GRbiua3lQ4cipMDxUeS6CJvQCewwzSkhy7hjaw3N20tPNT012Q7o+RuFUEwTVZQTFAREEbFMbci7fAcgxPrcRcz//oLrihUSUnDmDaMQlwKc44xtxqHmDGauEdXLIAX1ZSpvntQ41oXaDp0edfbmTfEFVAh8XwtzFbCeT1sVvOx3DvG7TlT2pmoWa4W8mgj59C5xe4Qo58uaoIky1mRPCyn6ntI9L0mWQWbUo9hB0A5IJgVDU7R+JGs+1if17bUMGeSB3RJG0gTjicpQ4j+4+R+eNaMrDs/sBg2g1aNAQdwwD4T21tlOtneNLyIlfiVV0Ak0dggZRMqMVfA4G9nQmKUmpMQSZfx60ZN6DBto/o9pf5aXsUAKKpR4L4VBKc92cFAtW3pbqniczM7N2u79Z4NJsuP+bOSNVQ+Fvw/3kzJ/XAbB3VNz/eROC2MUf60LuPDGO0Xruylf4NM8cynJEikQdlV9ZoO0TAr2CxAvSTm+d43ULMTtEbUU4NOYLunccouUAnYGEBjV+iWVCTsRCkr45uoVBtAhbuAfLLtgAzLhMpRtKoLK7ikhD56OrYx8Nbho2L78NycXv+BTnkgPiUL/Ij10jY7V0UJVbcBX92yV8aBOt5W0s1vqnxQKHWTjPiUfb15CvxlpNven5kVdUiebTQ5SOvDlAYGNhX899pEESZxpwbi+xjuSuIipYRHI55V8RONhSvrNTU4q3pwOr+mV272AgyvgXNDJSF8vNvaykA0pxjR9UyyGbp/5L3cZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(40470700004)(36840700001)(40480700001)(356005)(82310400005)(26005)(81166007)(1076003)(6916009)(54906003)(316002)(82740400003)(36756003)(40460700003)(70206006)(70586007)(8676002)(4326008)(2906002)(41300700001)(7696005)(6666004)(86362001)(336012)(83380400001)(426003)(47076005)(5660300002)(186003)(36860700001)(478600001)(8936002)(2616005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:51:26.3486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d629e42-f7bd-4584-11e7-08da87d708fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
We want to get the visual confirm color of the bottom-most pipe
for test automation.

[How]
Save the visual confirm color to plane_state before program to MPC;

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 31 +++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  4 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  4 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 44 +++++++++++++++++++
 7 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index eef38d2e4753..a53863bddee0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1184,6 +1184,7 @@ struct dc_plane_state {
 	/* private to dc_surface.c */
 	enum dc_irq_source irq_source;
 	struct kref refcount;
+	struct tg_color visual_confirm_color;
 };
 
 struct dc_plane_info {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index cd7225d98b3d..61dfe5358d1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -387,6 +387,37 @@ void dc_dmub_srv_query_caps_cmd(struct dmub_srv *dmub)
 	}
 }
 
+void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	union dmub_rb_cmd cmd = { 0 };
+	enum dmub_status status;
+	unsigned int panel_inst = 0;
+
+	dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst);
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	// Prepare fw command
+	cmd.visual_confirm_color.header.type = DMUB_CMD__GET_VISUAL_CONFIRM_COLOR;
+	cmd.visual_confirm_color.header.sub_type = 0;
+	cmd.visual_confirm_color.header.ret_status = 1;
+	cmd.visual_confirm_color.header.payload_bytes = sizeof(struct dmub_cmd_visual_confirm_color_data);
+	cmd.visual_confirm_color.visual_confirm_color_data.visual_confirm_color.panel_inst = panel_inst;
+
+	// Send command to fw
+	status = dmub_srv_cmd_with_reply_data(dc->ctx->dmub_srv->dmub, &cmd);
+
+	ASSERT(status == DMUB_STATUS_OK);
+
+	// If command was processed, copy feature caps to dmub srv
+	if (status == DMUB_STATUS_OK &&
+		cmd.visual_confirm_color.header.ret_status == 0) {
+		memcpy(&dc->ctx->dmub_srv->dmub->visual_confirm_color,
+			&cmd.visual_confirm_color.visual_confirm_color_data,
+			sizeof(struct dmub_visual_confirm_color));
+	}
+}
+
 #ifdef CONFIG_DRM_AMD_DC_DCN
 /**
  * ***********************************************************************************************
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 159782cd6659..9f5b47b9a83d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -78,6 +78,7 @@ void dc_dmub_srv_set_drr_manual_trigger_cmd(struct dc *dc, uint32_t tg_inst);
 bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool enable_pstate, struct dc_state *context);
 
 void dc_dmub_srv_query_caps_cmd(struct dmub_srv *dmub);
+void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dc_dmub_srv_clear_inbox0_ack(struct dc_dmub_srv *dmub_srv);
 void dc_dmub_srv_wait_for_inbox0_ack(struct dc_dmub_srv *dmub_srv);
 void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dmub_srv, union dmub_inbox0_data_register data);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 2118ad3e37d0..d3f6a2609c8c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2539,8 +2539,10 @@ void dcn10_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx,
 		color_space_to_black_color(
 				dc, pipe_ctx->stream->output_color_space, color);
 
-	if (mpc->funcs->set_bg_color)
+	if (mpc->funcs->set_bg_color) {
+		memcpy(&pipe_ctx->plane_state->visual_confirm_color, color, sizeof(struct tg_color));
 		mpc->funcs->set_bg_color(mpc, color, mpcc_id);
+	}
 }
 
 void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 4b4368456477..6271caca4d9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2468,8 +2468,10 @@ void dcn20_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SUBVP)
 		get_subvp_visual_confirm_color(dc, pipe_ctx, color);
 
-	if (mpc->funcs->set_bg_color)
+	if (mpc->funcs->set_bg_color) {
+		memcpy(&pipe_ctx->plane_state->visual_confirm_color, color, sizeof(struct tg_color));
 		mpc->funcs->set_bg_color(mpc, color, mpcc_id);
+	}
 }
 
 void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 840460ad0bf8..fdaa6f4fdde1 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -442,6 +442,7 @@ struct dmub_srv {
 
 	/* Feature capabilities reported by fw */
 	struct dmub_feature_caps feature_caps;
+	struct dmub_visual_confirm_color visual_confirm_color;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 829410a883a1..1184bef22673 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -246,6 +246,16 @@ struct dmub_feature_caps {
 	uint8_t reserved[6];
 };
 
+struct dmub_visual_confirm_color {
+	/**
+	 * Maximum 10 bits color value
+	 */
+	uint16_t color_r_cr;
+	uint16_t color_g_y;
+	uint16_t color_b_cb;
+	uint16_t panel_inst;
+};
+
 #if defined(__cplusplus)
 }
 #endif
@@ -644,6 +654,10 @@ enum dmub_cmd_type {
 	 * Command type used to query FW feature caps.
 	 */
 	DMUB_CMD__QUERY_FEATURE_CAPS = 6,
+	/**
+	 * Command type used to get visual confirm color.
+	 */
+	DMUB_CMD__GET_VISUAL_CONFIRM_COLOR = 8,
 	/**
 	 * Command type used for all PSR commands.
 	 */
@@ -2778,6 +2792,31 @@ struct dmub_rb_cmd_query_feature_caps {
 	struct dmub_cmd_query_feature_caps_data query_feature_caps_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__GET_VISUAL_CONFIRM_COLOR command.
+ */
+struct dmub_cmd_visual_confirm_color_data {
+	/**
+	 * DMUB feature capabilities.
+	 * After DMUB init, driver will query FW capabilities prior to enabling certain features.
+	 */
+struct dmub_visual_confirm_color visual_confirm_color;
+};
+
+/**
+ * Definition of a DMUB_CMD__GET_VISUAL_CONFIRM_COLOR command.
+ */
+struct dmub_rb_cmd_get_visual_confirm_color {
+ /**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__GET_VISUAL_CONFIRM_COLOR command.
+	 */
+	struct dmub_cmd_visual_confirm_color_data visual_confirm_color_data;
+};
+
 struct dmub_optc_state {
 	uint32_t v_total_max;
 	uint32_t v_total_min;
@@ -3150,6 +3189,11 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__QUERY_FEATURE_CAPS command.
 	 */
 	struct dmub_rb_cmd_query_feature_caps query_feature_caps;
+
+	/**
+	 * Definition of a DMUB_CMD__GET_VISUAL_CONFIRM_COLOR command.
+	 */
+	struct dmub_rb_cmd_get_visual_confirm_color visual_confirm_color;
 	struct dmub_rb_cmd_drr_update drr_update;
 	struct dmub_rb_cmd_fw_assisted_mclk_switch fw_assisted_mclk_switch;
 
-- 
2.25.1

