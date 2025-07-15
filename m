Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6DEC83F22
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C71910E515;
	Tue, 15 Jul 2025 06:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tny6lWKT";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A5B10E515
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sI28Rx3BlqfWuZ8YAW0uav8q9CxCHKKdEaI35Bti70iOWQnyqSwB7VSaCzUqIVV2YoQ5cnnYTC37g6AiAAKBLdLLixP6EIn6vI3/5e36ZIb3EfNepRWgRUINCR0J8++RsPyQ6r7ooj4goL+QjXn11e89p+gIeI03FdznAWfnvKjDUidGbmt6v6XbKeCJzuQQ8T8/37jq23XxV7xNaqIURCaK4ae5bO9lPumT/SgkbGlFfaVem/CV1IDk1duXDOSUdHwL0U4yLeKnzw3iadba4lXOfdgzkolpvAlsLoMI+mKObX4bkcB2/Y34Hu77eGzClDxBQbnqqDnOum6w5JXC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3mjCW6EWiDDHxDHhYWfXvD2x8+tDkIUnj0/MbXI9sc=;
 b=yZK0bNtoLVj+YEj2zKysm3aSmbFjkVjZsnzy4CHBy2eI6X8VeoecgXmRaaX37BYhUCPPTS6JMJ9V+ooexh9JwcoquLIbLjShTijvcRgP5i6PFSjvlWXqt6hktywMp+9CQBxVUely0a5S6+zjNjmxeGJCS+V+9/Ap8vQ2hCvd4lVmOolL/5jaYvqcZpNFEFnNOObiKs5rfBRqPfxlq/Le+sYMPDJkpct897DfJeRg1FgunEYM03rMaLBqEXJ3JnRGi82ypgu08yBV7TsrR5lz/nfUTiVrtEwc01aV2kfk80N4yJmoYvASFXZHRPPLunYUiYjlRZaQ+U62UnyxhXunPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3mjCW6EWiDDHxDHhYWfXvD2x8+tDkIUnj0/MbXI9sc=;
 b=Tny6lWKTl89Q1DbMQxzy+nUrNXqBk23tRzyEFaFGR5J43OntVRB66dLlq7t35CZQ/S5I/6bhJBkYnFWdGr5NMgQlsEUUsbfcbLVZLM2V2p1Qz9mxI3qzwP6PMcw3wNMP8a3+KMT15r2YeDrSTEjxvXATuMrbkcoVrr7QtvjBC24=
Received: from CH5P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::6)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.33; Tue, 15 Jul 2025 06:53:18 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::63) by CH5P220CA0011.outlook.office365.com
 (2603:10b6:610:1ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 06:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 06:53:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:16 -0500
Received: from 172.93.31.172.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 15 Jul 2025 01:53:12 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Gabe Teeger
 <gabe.teeger@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 05/10] drm/amd/display: Revert Add HPO encoder support to
 Replay
Date: Tue, 15 Jul 2025 14:49:29 +0800
Message-ID: <20250715065233.160043-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715065233.160043-1-Wayne.Lin@amd.com>
References: <20250715065233.160043-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 34baa1bd-47ca-45bd-0db4-08ddc36c476b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5RaD1TEJkgiLSWbXacItFLKlebzxKJ4WJEG6unq9x1v/rIrvIiBaS+6Rdnmx?=
 =?us-ascii?Q?9ElNwpnM2v2Utov4S4pClUYX/4IRWMSKTmBukYacICpEjuifUfZ5HMcyo3Lj?=
 =?us-ascii?Q?r9XpiN6due67gY1vq8Cf4FBAt+Ahhx9hLt00NE7R85uS88aZWA7LqTYHMqnq?=
 =?us-ascii?Q?fCloDI9E5cjA3OK9htfN9u//W4H8eqVVUooPHbvUXPODk5RwMjbCKhnKaG+f?=
 =?us-ascii?Q?1U8htlEGKkeT3j+IS7ltlQE5NZhyv0HQxcw8xoYC5Hl4e0PFfzeom9+I4TGE?=
 =?us-ascii?Q?YZu2ejgEzOH26dTEqX4XGzjlgZTxS4EzSXU5M1NiWgBMvPQKjRTpvAhs39FO?=
 =?us-ascii?Q?/LQjeZT0v+AtqWyxdq2WZjI1sbV/CYBEORlqeqL11pDDg1vxVtMSMiGZGBor?=
 =?us-ascii?Q?E2bXYvKlYQNAzMHdoG+5ameXbPyEuiSgFsO1RK7OeTf6EiIB5Bm56hm3+02O?=
 =?us-ascii?Q?GyGtyQvwdvzK/FYt06QkjmXSAYZ9zKvAONZn4NtdgkLg5IuVbKWiMTwMHxb3?=
 =?us-ascii?Q?tsbuhcmxOXV6y93Dg8f0HQzeLZjccoflEEcofXapRDSDAtQKMhfJO33laZsh?=
 =?us-ascii?Q?x7v6NS0ON5IfVr7h+0ni2QSbCT+St3GrkO8ifj9W/HOJstDkiYNDNl5re8zW?=
 =?us-ascii?Q?WygBTZosQ1sUax4/WWIhtpu0cSQwDG2ZVPubMEa0n0jwoXOeSKAqOmuImngg?=
 =?us-ascii?Q?jeUYHXVLkwg/e3yVLAOf96fmf+ccJ8Zz9PPCnWZNbFW1z2/f7MzXT/unPdmm?=
 =?us-ascii?Q?Qd1bthmlYgNIlrrxE7WkGVg+6h18Kbisz0bhq1l68IQiVjTyNpfgC7yR0h2q?=
 =?us-ascii?Q?+x4KhTZxwtRv1q9Bfl2NpYAa8pyPwvL9AV6rR1itUZT2Jo4+lrZRBL5nAYfa?=
 =?us-ascii?Q?IgnBvQQT2qDnRdfx+Vb0YsDEl9jnrsP4PkiJQ5OSNmU6Xdn3LLWv6h5witF6?=
 =?us-ascii?Q?21BB5rkWbaPaPh6Q63o9kiQuRF6KKe4lHrc/XovpyJo1HbrJPNywcMLWYB+/?=
 =?us-ascii?Q?a19C8pUrPFhYm295XOONrpxY9So3d2t6gw+hiYqx4NU1Oul8p2UWzI3s/tT3?=
 =?us-ascii?Q?sA7Cwq82Wfg39uPypkzdRM6TevOTbt9zdh2FU3HuWPwo1KejOtZfKPWJ2cI5?=
 =?us-ascii?Q?wkwiAEw592pDrcbWT4ybG17z2Y5zbBTtx5Ji2v9KqVB5hov6WJw3waO+791R?=
 =?us-ascii?Q?q4yKGc9xIJNEBL8+bC+Sydkxfm4vwy4wXyHJr3u+8w4AbJvnMQbwokvNIlxZ?=
 =?us-ascii?Q?qHHe/7leLqXBL9QAGwC1er6eAegSCZUl1ZxMpo2KUBlfQuJIkFye1kfI0d1+?=
 =?us-ascii?Q?KktDKuGQ7gi2POqdUz/DPd4pXK0sNV/QXL3dzwtOXMu1dTGfjaIIhVpWYlC9?=
 =?us-ascii?Q?Vj3a7feRCwb/wnBLQj0L2QhHjrElm4/ouOYPILTER5nFj0bkQgSYwk7B0g2y?=
 =?us-ascii?Q?wEHRIpC4wVEyTp5Al5POmiAfPuxoAUGWaP5Mni8iwU9X9eJ5Stqzb9AnfcBV?=
 =?us-ascii?Q?guNPk/5RiYZiJBiuVlZEwoKr9FmLsEu3DQzux09uuB/CPqoKkqmcZBU7BA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:53:17.7898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34baa1bd-47ca-45bd-0db4-08ddc36c476b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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

From: Gabe Teeger <gabe.teeger@amd.com>

This reverts commits:
commit e6bd65ba7323 ("drm/amd/display: Add HPO encoder support to Replay")
commit 2595b2de3005 ("drm/amd/display: Add support for Panel Replay on DP1 eDP (panel_inst=1)")
due to visual confirm issue.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 43 ++-----------------
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  2 +-
 .../link/protocols/link_edp_panel_control.c   |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 20 ---------
 4 files changed, 5 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index e7a318e26d38..fcd3d86ad517 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -4,7 +4,6 @@
 
 #include "dc.h"
 #include "dc_dmub_srv.h"
-#include "dc_dp_types.h"
 #include "dmub/dmub_srv.h"
 #include "core_types.h"
 #include "dmub_replay.h"
@@ -44,45 +43,21 @@ static void dmub_replay_get_state(struct dmub_replay *dmub, enum replay_state *s
 /*
  * Enable/Disable Replay.
  */
-static void dmub_replay_enable(struct dmub_replay *dmub, bool enable, bool wait, uint8_t panel_inst,
-			       struct dc_link *link)
+static void dmub_replay_enable(struct dmub_replay *dmub, bool enable, bool wait, uint8_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
 	uint32_t retry_count;
 	enum replay_state state = REPLAY_STATE_0;
-	struct pipe_ctx *pipe_ctx = NULL;
-	struct resource_context *res_ctx = &link->ctx->dc->current_state->res_ctx;
-	uint8_t i;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.replay_enable.header.type = DMUB_CMD__REPLAY;
 	cmd.replay_enable.data.panel_inst = panel_inst;
 
 	cmd.replay_enable.header.sub_type = DMUB_CMD__REPLAY_ENABLE;
-	if (enable) {
+	if (enable)
 		cmd.replay_enable.data.enable = REPLAY_ENABLE;
-		// hpo stream/link encoder assignments are not static, need to update everytime we try to enable replay
-		if (link->cur_link_settings.link_rate >= LINK_RATE_UHBR10) {
-			for (i = 0; i < MAX_PIPES; i++) {
-				if (res_ctx &&
-					res_ctx->pipe_ctx[i].stream &&
-					res_ctx->pipe_ctx[i].stream->link &&
-					res_ctx->pipe_ctx[i].stream->link == link &&
-					res_ctx->pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
-					pipe_ctx = &res_ctx->pipe_ctx[i];
-					//TODO: refactor for multi edp support
-					break;
-				}
-			}
-
-			if (!pipe_ctx)
-				return;
-
-			cmd.replay_enable.data.hpo_stream_enc_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
-			cmd.replay_enable.data.hpo_link_enc_inst = pipe_ctx->link_res.hpo_dp_link_enc->inst;
-		}
-	} else
+	else
 		cmd.replay_enable.data.enable = REPLAY_DISABLE;
 
 	cmd.replay_enable.header.payload_bytes = sizeof(struct dmub_rb_cmd_replay_enable_data);
@@ -174,17 +149,6 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
 	copy_settings_data->digbe_inst				= replay_context->digbe_inst;
 	copy_settings_data->digfe_inst				= replay_context->digfe_inst;
 
-	if (link->cur_link_settings.link_rate >= LINK_RATE_UHBR10) {
-		if (pipe_ctx->stream_res.hpo_dp_stream_enc)
-			copy_settings_data->hpo_stream_enc_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
-		else
-			copy_settings_data->hpo_stream_enc_inst = 0;
-		if (pipe_ctx->link_res.hpo_dp_link_enc)
-			copy_settings_data->hpo_link_enc_inst = pipe_ctx->link_res.hpo_dp_link_enc->inst;
-		else
-			copy_settings_data->hpo_link_enc_inst = 0;
-	}
-
 	if (pipe_ctx->plane_res.dpp)
 		copy_settings_data->dpp_inst			= pipe_ctx->plane_res.dpp->inst;
 	else
@@ -247,7 +211,6 @@ static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
 	pCmd->header.type = DMUB_CMD__REPLAY;
 	pCmd->header.sub_type = DMUB_CMD__REPLAY_SET_COASTING_VTOTAL;
 	pCmd->header.payload_bytes = sizeof(struct dmub_cmd_replay_set_coasting_vtotal_data);
-	pCmd->replay_set_coasting_vtotal_data.panel_inst = panel_inst;
 	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal = (coasting_vtotal & 0xFFFF);
 	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal_high = (coasting_vtotal & 0xFFFF0000) >> 16;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index ccbe385e132c..e6346c0ffc0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -19,7 +19,7 @@ struct dmub_replay_funcs {
 	void (*replay_get_state)(struct dmub_replay *dmub, enum replay_state *state,
 		uint8_t panel_inst);
 	void (*replay_enable)(struct dmub_replay *dmub, bool enable, bool wait,
-		uint8_t panel_inst, struct dc_link *link);
+		uint8_t panel_inst);
 	bool (*replay_copy_settings)(struct dmub_replay *dmub, struct dc_link *link,
 		struct replay_context *replay_context, uint8_t panel_inst);
 	void (*replay_set_power_opt)(struct dmub_replay *dmub, unsigned int power_opt,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index e7927b8f5ba3..98ec9b5a559c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -944,7 +944,7 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 		// TODO: Handle mux change case if force_static is set
 		// If force_static is set, just change the replay_allow_active state directly
 		if (replay != NULL && link->replay_settings.replay_feature_enabled)
-			replay->funcs->replay_enable(replay, *allow_active, wait, panel_inst, link);
+			replay->funcs->replay_enable(replay, *allow_active, wait, panel_inst);
 		link->replay_settings.replay_allow_active = *allow_active;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 686de58a0412..1fb1472737ad 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -4047,14 +4047,6 @@ struct dmub_cmd_replay_copy_settings_data {
 	 * DIG BE HW instance.
 	 */
 	uint8_t digbe_inst;
-	/**
-	 * @hpo_stream_enc_inst: HPO stream encoder instance
-	 */
-	uint8_t hpo_stream_enc_inst;
-	/**
-	 * @hpo_link_enc_inst: HPO link encoder instance
-	 */
-	uint8_t hpo_link_enc_inst;
 	/**
 	 * AUX HW instance.
 	 */
@@ -4158,18 +4150,6 @@ struct dmub_rb_cmd_replay_enable_data {
 	 * This does not support HDMI/DP2 for now.
 	 */
 	uint8_t phy_rate;
-	/**
-	 * @hpo_stream_enc_inst: HPO stream encoder instance
-	 */
-	uint8_t hpo_stream_enc_inst;
-	/**
-	 * @hpo_link_enc_inst: HPO link encoder instance
-	 */
-	uint8_t hpo_link_enc_inst;
-	/**
-	 * @pad: Align structure to 4 byte boundary.
-	 */
-	uint8_t pad[2];
 };
 
 /**
-- 
2.43.0

