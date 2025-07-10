Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A64C83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92CEC10E970;
	Thu, 10 Jul 2025 21:31:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N7ZaBvO1";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A434B10E970
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfLylh6HKSMoLOK9yNvxCJ2e7domVSUXS6XFIJv/7T9GNk5V/rHnI9gH84ZJBMGHKUTk52rshCKmjuLJzHlm7Bor5c8v3HJ2ms7UTTQINiTOCGMGSqN3SoGvFjNL4nszEOkgDhTzvz3gdwb2JsG3JFxqIadtymAkG4WPhgLeDnR4qhb3p7hE0MVFCxCB/DT3mOgoYT2/8xoAeLE/xm5rfbJ4K+AUzemZH4dYrpzdC6gKv39Tnx5a5zNXJf+ywt3wvtxFvQRZnGJrr22ACUgutHgEnmGsOrL1vEPah999mp+d1DhcOyYmiOHr0XcqgY1FZ86fY4yKiFhafZFwtlFfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsUtVLHi0UK48vcZGSbORqPLIrnN88WfYLhXeMVwR4Y=;
 b=reYslYCzfjM5VK7am60+PzQ8Qrpm5T9Y8EzWaPyM+ucBZdReybCZKF+3XaBcD/OTJeidTnOtArDP65iw3Vl3HdTGWJbNbSo66hLhtDeXul1a36NijvbulYLYaS6I0fHO15vdz6N3AqK+ymY5M7z5OaT1Xzlwgikp2mx6wXI4UscnlejVTwr/D09tbclxyYiWGP1IEiUIwcZlIXXOwlMHKAx73lNS9W442uIP5furJ5fHmJ12Yc0Zm4kxQxWdgosXREiVB2sZWtFOcAW94BI/PPEtDUqRvi22WkTTK2x7GTQrh2JWQzPaHSb5xo2XkHqGkY6ymDeu+Pjivy+2NGExVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsUtVLHi0UK48vcZGSbORqPLIrnN88WfYLhXeMVwR4Y=;
 b=N7ZaBvO1qnZnJDbxXFgF0vVrvlcstkAbwyQy6N12I78VV6Ra2Z4DbKSVJhCAZkcmsXWEwOlIy6Vs1fmyNYY/ItNW3Hn8HMPbEXV6FeFQgRGR4eejw8nRwB6pFTMLfV8a6OkMK1cAjjBtuW4iHv8ez+EWxBKuSq1BDb9glM02NwI=
Received: from CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::25)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Thu, 10 Jul
 2025 21:31:23 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::5c) by CH5P223CA0018.outlook.office365.com
 (2603:10b6:610:1f3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.24 via Frontend Transport; Thu,
 10 Jul 2025 21:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:31:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:09 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:31:08 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ovidiu Bunea
 <Ovidiu.Bunea@amd.com>, Charlene Liu <charlene.liu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 14/18] drm/amd/display: Add HPO encoder support to Replay
Date: Thu, 10 Jul 2025 17:25:47 -0400
Message-ID: <20250710212941.630259-15-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 907003eb-fcef-4588-0a68-08ddbff91e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?daKudUQktpSKuaawlsxWCS4AIwuOLRbjdZzsF06qigfjudCFdCZJ21wJDQrD?=
 =?us-ascii?Q?7Bzs/lQl2h7AeQayMTuYKFUOUWj5j16MITVM2zOoBBEMT4De5nhH1rGAYQ5S?=
 =?us-ascii?Q?ztIZGgWNa0qqbfGwWsggbCK1JW0m5M6G7Njfa1qg907BlhTGrdjwGz7gSu4/?=
 =?us-ascii?Q?pIiCa7ByZCxVTZSW7tyt6yLnKrx2FPSc13k9pJi2f0AXtC8usylW7U0R7lp1?=
 =?us-ascii?Q?LbF9hHjPxhhAL+CJFfGlLMXNcdbo8zvfKE5dZ83OmF5B0FoCbg/zzHUEtoBV?=
 =?us-ascii?Q?YtC9l2N/+ArqrbX4sqEEfg99S2E85tfwL785iQhUefI8Ozr/l5p3+EyGQHDB?=
 =?us-ascii?Q?FyZQcbhk05r8C1xyOhCL1HrNju+BU+FpcxWj7r3ZangXihh4bolbi8AApeU9?=
 =?us-ascii?Q?JFK4pnAGL/S6MG27j+kQTfQOKOK3ZkNhcTrwqNy01z5L4s/PXx6rjEwvWqVw?=
 =?us-ascii?Q?8krT6ae3TmLzMvMmKG9rtpylkfN9xjXIk7AzS6a6RzKmKnoCfxr4z9Dl9JU9?=
 =?us-ascii?Q?c4Wy4a9ap+Gg9Qw58q9WBa1oT8489PV229Ic9S7fubamTr8SwNUWw7411LLw?=
 =?us-ascii?Q?xcOCUyXavp3vERUET+Nt02xNxcYHbEHstMj8zo3OgyOmliNkNqG/TmF4vpxz?=
 =?us-ascii?Q?6f6uVxp4zmSlJKwsR1pRulNkcg6v4iL+jAvA5aK2KK+EH58PJPyiyRiQdzGo?=
 =?us-ascii?Q?Z6R8+Zixv/hiPS7/rWeO3aUwF1U+RACb1/wrC9rvcpJ4pxtRHQSSq8UisdSX?=
 =?us-ascii?Q?weIWtsZ8hv8fjgoEXrGYbWhSoO8TDUMapRxSI9axP6dbOjVvOEWOfpglQ6U3?=
 =?us-ascii?Q?Gx0K8+XEaDM2bBaC5Dw2QTtynAmRFdsweoG4eO+ePA4G8fOEqHYJ+n2ZqoJC?=
 =?us-ascii?Q?nyMzX5+3oUw40vCVZda6BozgNJXiDaXwZSd1UBGuHJ6UNYv20ty59VSOLEJK?=
 =?us-ascii?Q?x10psjIEhp4BIVkpwkmrTYXYUBi9qLR3UJpvYTrjEE3Zbe+hZ8vvaTd4F1Kk?=
 =?us-ascii?Q?DbIk54D/rf5HI/z4Ut322dpzEm/vaRutwSJVkb1g+9UCkKxp7NyvfZTalDyd?=
 =?us-ascii?Q?uNIeqEQAOlb1O69Gyv8GMPbmCTcvcTzzCFSebs5X6DnOp2WYy6OIk1Nzjejz?=
 =?us-ascii?Q?fUXN40BNWWzoNxBZyj8gQuyC1ulg9PDNUIItL/ALRT94q/vq8J1Q4xvVakGN?=
 =?us-ascii?Q?WI0FhrOHsOLgwZ0I8IcEoK25VHEawh7gNHl58VmFHGiFQun458gshLCr4loq?=
 =?us-ascii?Q?7frtcU5UibED4nqT/w/NhJWumo5EMmbK9GqSkujGkbHVJJGYJvCpgns0CT6H?=
 =?us-ascii?Q?8NT0o7EuIDow+gF93bFJYcDa8/e+Paip/sCUl/Z2zoG0fwnw4I/nGAQMLraI?=
 =?us-ascii?Q?48WTgCm0lMhWbs7XQRtXG4EoEcbxKog519xqdqDpziyscwAGwcmDxuoqS9+h?=
 =?us-ascii?Q?rjnqvNmBwOhina4Jmt00MT6nx3E7mPP6F5mPo57UNMVKB0cEE+Axepi9FM/y?=
 =?us-ascii?Q?T+4QFj5vGSnchtUfCMURWKbXZMDeZIxgeQIZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:31:22.9829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 907003eb-fcef-4588-0a68-08ddbff91e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
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

From: Ovidiu Bunea <Ovidiu.Bunea@amd.com>

[why & how]
UHBR link rate capable eDPs will use HPO for encoding. Need to pass
HPO stream and link encoder instances to DMCUB for Replay FSM to
know which instances to use.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 42 +++++++++++++++++--
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  2 +-
 .../link/protocols/link_edp_panel_control.c   |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 25 +++++++++++
 4 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 5d77d0912ee9..e7a318e26d38 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -4,6 +4,7 @@
 
 #include "dc.h"
 #include "dc_dmub_srv.h"
+#include "dc_dp_types.h"
 #include "dmub/dmub_srv.h"
 #include "core_types.h"
 #include "dmub_replay.h"
@@ -43,21 +44,45 @@ static void dmub_replay_get_state(struct dmub_replay *dmub, enum replay_state *s
 /*
  * Enable/Disable Replay.
  */
-static void dmub_replay_enable(struct dmub_replay *dmub, bool enable, bool wait, uint8_t panel_inst)
+static void dmub_replay_enable(struct dmub_replay *dmub, bool enable, bool wait, uint8_t panel_inst,
+			       struct dc_link *link)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
 	uint32_t retry_count;
 	enum replay_state state = REPLAY_STATE_0;
+	struct pipe_ctx *pipe_ctx = NULL;
+	struct resource_context *res_ctx = &link->ctx->dc->current_state->res_ctx;
+	uint8_t i;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.replay_enable.header.type = DMUB_CMD__REPLAY;
 	cmd.replay_enable.data.panel_inst = panel_inst;
 
 	cmd.replay_enable.header.sub_type = DMUB_CMD__REPLAY_ENABLE;
-	if (enable)
+	if (enable) {
 		cmd.replay_enable.data.enable = REPLAY_ENABLE;
-	else
+		// hpo stream/link encoder assignments are not static, need to update everytime we try to enable replay
+		if (link->cur_link_settings.link_rate >= LINK_RATE_UHBR10) {
+			for (i = 0; i < MAX_PIPES; i++) {
+				if (res_ctx &&
+					res_ctx->pipe_ctx[i].stream &&
+					res_ctx->pipe_ctx[i].stream->link &&
+					res_ctx->pipe_ctx[i].stream->link == link &&
+					res_ctx->pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
+					pipe_ctx = &res_ctx->pipe_ctx[i];
+					//TODO: refactor for multi edp support
+					break;
+				}
+			}
+
+			if (!pipe_ctx)
+				return;
+
+			cmd.replay_enable.data.hpo_stream_enc_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
+			cmd.replay_enable.data.hpo_link_enc_inst = pipe_ctx->link_res.hpo_dp_link_enc->inst;
+		}
+	} else
 		cmd.replay_enable.data.enable = REPLAY_DISABLE;
 
 	cmd.replay_enable.header.payload_bytes = sizeof(struct dmub_rb_cmd_replay_enable_data);
@@ -149,6 +174,17 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
 	copy_settings_data->digbe_inst				= replay_context->digbe_inst;
 	copy_settings_data->digfe_inst				= replay_context->digfe_inst;
 
+	if (link->cur_link_settings.link_rate >= LINK_RATE_UHBR10) {
+		if (pipe_ctx->stream_res.hpo_dp_stream_enc)
+			copy_settings_data->hpo_stream_enc_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
+		else
+			copy_settings_data->hpo_stream_enc_inst = 0;
+		if (pipe_ctx->link_res.hpo_dp_link_enc)
+			copy_settings_data->hpo_link_enc_inst = pipe_ctx->link_res.hpo_dp_link_enc->inst;
+		else
+			copy_settings_data->hpo_link_enc_inst = 0;
+	}
+
 	if (pipe_ctx->plane_res.dpp)
 		copy_settings_data->dpp_inst			= pipe_ctx->plane_res.dpp->inst;
 	else
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index e6346c0ffc0e..ccbe385e132c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -19,7 +19,7 @@ struct dmub_replay_funcs {
 	void (*replay_get_state)(struct dmub_replay *dmub, enum replay_state *state,
 		uint8_t panel_inst);
 	void (*replay_enable)(struct dmub_replay *dmub, bool enable, bool wait,
-		uint8_t panel_inst);
+		uint8_t panel_inst, struct dc_link *link);
 	bool (*replay_copy_settings)(struct dmub_replay *dmub, struct dc_link *link,
 		struct replay_context *replay_context, uint8_t panel_inst);
 	void (*replay_set_power_opt)(struct dmub_replay *dmub, unsigned int power_opt,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 035795042a01..a4258b5b77be 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -937,7 +937,7 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 		// TODO: Handle mux change case if force_static is set
 		// If force_static is set, just change the replay_allow_active state directly
 		if (replay != NULL && link->replay_settings.replay_feature_enabled)
-			replay->funcs->replay_enable(replay, *allow_active, wait, panel_inst);
+			replay->funcs->replay_enable(replay, *allow_active, wait, panel_inst, link);
 		link->replay_settings.replay_allow_active = *allow_active;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index fed2d3999305..c587b3441e07 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -4047,6 +4047,14 @@ struct dmub_cmd_replay_copy_settings_data {
 	 * DIG BE HW instance.
 	 */
 	uint8_t digbe_inst;
+	/**
+	 * @hpo_stream_enc_inst: HPO stream encoder instance
+	 */
+	uint8_t hpo_stream_enc_inst;
+	/**
+	 * @hpo_link_enc_inst: HPO link encoder instance
+	 */
+	uint8_t hpo_link_enc_inst;
 	/**
 	 * AUX HW instance.
 	 */
@@ -4091,6 +4099,11 @@ struct dmub_cmd_replay_copy_settings_data {
 	 * Use for AUX-less ALPM LFPS wake operation
 	 */
 	struct dmub_alpm_auxless_data auxless_alpm_data;
+
+	/**
+	 * @pad: Align structure to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
@@ -4146,6 +4159,18 @@ struct dmub_rb_cmd_replay_enable_data {
 	 * This does not support HDMI/DP2 for now.
 	 */
 	uint8_t phy_rate;
+	/**
+	 * @hpo_stream_enc_inst: HPO stream encoder instance
+	 */
+	uint8_t hpo_stream_enc_inst;
+	/**
+	 * @hpo_link_enc_inst: HPO link encoder instance
+	 */
+	uint8_t hpo_link_enc_inst;
+	/**
+	 * @pad: Align structure to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
-- 
2.43.0

