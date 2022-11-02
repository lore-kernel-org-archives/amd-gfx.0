Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1BEC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFD310E4E4;
	Wed,  2 Nov 2022 16:03:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A924F10E4E4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5B3/C3FHjFpikRXubUP9xSffNReaGd8lSkBwXYsWc5CJo0oFJACHvN8MQBUa5nOrGgarbxTg8FtNc8aW7NsKbMaS80orDUTb0hEXe70h0XamDrSWsSMLx+AbU5HAHKjWDivuthLkkK2gwpI1FAi2+nrvUa8OGjLsj6YnDQb0Orw8hjmsfL+JfAjoeJCwIwDt0Mb9z4DXjomCpCdy1xaLe4J5mF/MX+AuPnsxu+M+NRsfduOwWSmYbttzyz5ySLVEU/ULb4bz05yBRU3JFuNNzDBfpNiEbSU8uZk2S+sqTLPt3OHpNNMHyS7EYajwqe7ZNSDtAFkVmOEwklzP69qQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S16b0EFpxJKSsft6FDhrmZR2eC/g+gLOVpU7InxVxq0=;
 b=WfBrTrzsl/DmczI7fKQuDCe5/1jBKeeDIQeKoBF/HdQ6gr7XsCQ9dC9eIH3EcQVcQqRkzn7reXFsTxhihT6oZLAXTMOgfNPfZZOcVzGKGhftfnd2WkdR5UTevbCP9F0y4ud8ldUmJhnGk2F83yfpaCsJErZA738O8q/iiLTCqL5bFLCZvUynV/UTdCmUPMDqX0MWcA+M7zGS7dPDY7rw7aT6Zc0auf/C/2999WM2nlRD7TC2K6Ai8y/RBDEvgVqVoTS+CgplIVV2a/bMGnOGbEXBdK+DJ4ZpXRWldcvL1ETxBSP4l6kkgn/V4+md5dl71cGF8xUNUiRTEjME05U3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S16b0EFpxJKSsft6FDhrmZR2eC/g+gLOVpU7InxVxq0=;
 b=VsVmKXgtFyw2oAfvb4ZcoruQZeBIjV50Ko7bXtWuUzy9MisqEC8mO0oVlbYTxyKeN1yMGckCVXRjKArKx+ldJ6bWJlnSZXxOKRPOf04vy3Vt31es3aghNSp3z8qpvbu46xFce5dkMKYidJ7Gy7ndf99P5RwsKBa/KlWDhQI6+dE=
Received: from DS7PR03CA0139.namprd03.prod.outlook.com (2603:10b6:5:3b4::24)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Wed, 2 Nov
 2022 16:03:39 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::92) by DS7PR03CA0139.outlook.office365.com
 (2603:10b6:5:3b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.21 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:38 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:34 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/22] drm/amd/display: Use min transition for SubVP into MPO
Date: Thu, 3 Nov 2022 00:01:05 +0800
Message-ID: <20221102160117.506511-11-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: e43f6ce7-8f6c-45f4-b9c8-08dabcebce66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4NR7aUteDYNHLvZMyEdz1qeUgDFpkskmEtj+HYPZPz8rtKH7v5zF63ku4h3Nas8WktVUb1N7F4OYIH6QLeeJhqwRPw9LQVIT5qRB0tbrn14P8qQmKM26dbIdaKoAAYFR/dGHrbKTrYJBKQ0GRivi9ochjgqeXV31DWTB+QXrihEzd/nwcbR5LV4rTpHTia2tTgkH2E7slpZyOOcAjmBRtRboyAEokf63HZsNIzhsZnQJP4hVf8eaJOV2MGLrWcYxFvSiGeAxW6NjNxJPCZ8y2kh3NskftcOAjskIJf3SUYRJhYm8voChB9ntYAfmTa/o2xdjrEMjJyBTHVuCW9xXUe2MNyrxrR6VC4uC//qJzpQrZ5WZcCAJFvapFcEcIBSi6m24eYjrC8AX9jpHADh4so+dS9ZXu+sZnkfUAjyYI2iyMLoRBKJJST6RbKxfO39LwAhrTqN1QicyeGVj+qnhvU/gUG2Jxm00SHVTu7/kyF3yHJl5vyJPdy85HhsxhAmBRr1RsV5YyRpzrjM/mkaDFFREz9BwD35RYRGj9gaPS4i3KtGcZIoEPmAkD+PgBbK/Sb2BoDDNGKQQcAjHmO/VrdTyLUxNswzhGNqP3l15EngucaZdx/qQuvGcqqENANJ+yZtrltShc1Km8+BzYMjgEwAgH6HYtERcSGe+z27vLJnJnuhQwdqouw0q9aRpYovRXBnWTXOW5LSs1RlioO9z48K1NYlGakdimdoqC6dSoqsjE8YmxxXdwCm7Cde6fPpZePN5cBkRpzfojquDASc+FSa8fsUG8S1IWQ/P5C3V8DpJopqFyQq4NF8s98D5klq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(336012)(83380400001)(86362001)(82740400003)(36860700001)(8676002)(426003)(356005)(4326008)(47076005)(5660300002)(81166007)(8936002)(1076003)(70586007)(6666004)(6916009)(70206006)(40460700003)(2906002)(82310400005)(41300700001)(186003)(26005)(2616005)(316002)(54906003)(478600001)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:39.1896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43f6ce7-8f6c-45f4-b9c8-08dabcebce66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- For SubVP transitioning into MPO, we want to
  use a minimal transition to prevent transient
  underflow
- Transitioning a phantom pipe directly into a
  "real" pipe can result in underflow due to the
  HUBP still having it's "phantom" programming
  when HUBP is unblanked (have to wait for next
  VUPDATE of the new OTG)
- Also ensure subvp pipe lock is acquired early
  enough for programming in dc_commit_state_no_check
- When disabling phantom planes, enable phantom OTG
  first so the disable gets the double buffer update

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 43 +++++++++++-------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d446e6098948..da808996e21d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1054,6 +1054,7 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 	int i, j;
 	struct dc_state *dangling_context = dc_create_state(dc);
 	struct dc_state *current_ctx;
+	struct pipe_ctx *pipe;
 
 	if (dangling_context == NULL)
 		return;
@@ -1096,6 +1097,16 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 		}
 
 		if (should_disable && old_stream) {
+			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			/* When disabling plane for a phantom pipe, we must turn on the
+			 * phantom OTG so the disable programming gets the double buffer
+			 * update. Otherwise the pipe will be left in a partially disabled
+			 * state that can result in underflow or hang when enabling it
+			 * again for different use.
+			 */
+			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
+				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+			}
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
 
@@ -1749,6 +1760,12 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		context->stream_count == 0)
 		dc->hwss.prepare_bandwidth(dc, context);
 
+	/* When SubVP is active, all HW programming must be done while
+	 * SubVP lock is acquired
+	 */
+	if (dc->hwss.subvp_pipe_control_lock)
+		dc->hwss.subvp_pipe_control_lock(dc, context, true, true, NULL, subvp_prev_use);
+
 	if (dc->debug.enable_double_buffered_dsc_pg_support)
 		dc->hwss.update_dsc_pg(dc, context, false);
 
@@ -1776,9 +1793,6 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.wait_for_mpcc_disconnect(dc, dc->res_pool, pipe);
 	}
 
-	if (dc->hwss.subvp_pipe_control_lock)
-		dc->hwss.subvp_pipe_control_lock(dc, context, true, true, NULL, subvp_prev_use);
-
 	result = dc->hwss.apply_ctx_to_hw(dc, context);
 
 	if (result != DC_OK) {
@@ -3675,7 +3689,6 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 
 	struct dc_stream_status *cur_stream_status = stream_get_status(dc->current_state, stream);
 	bool force_minimal_pipe_splitting = false;
-	uint32_t i;
 
 	*is_plane_addition = false;
 
@@ -3707,27 +3720,11 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 		}
 	}
 
-	/* For SubVP pipe split case when adding MPO video
-	 * we need to add a minimal transition. In this case
-	 * there will be 2 streams (1 main stream, 1 phantom
-	 * stream).
+	/* For SubVP when adding MPO video we need to add a minimal transition.
 	 */
-	if (cur_stream_status &&
-			dc->current_state->stream_count == 2 &&
-			stream->mall_stream_config.type == SUBVP_MAIN) {
-		bool is_pipe_split = false;
-
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			if (dc->current_state->res_ctx.pipe_ctx[i].stream == stream &&
-					(dc->current_state->res_ctx.pipe_ctx[i].bottom_pipe ||
-					dc->current_state->res_ctx.pipe_ctx[i].next_odm_pipe)) {
-				is_pipe_split = true;
-				break;
-			}
-		}
-
+	if (cur_stream_status && stream->mall_stream_config.type == SUBVP_MAIN) {
 		/* determine if minimal transition is required due to SubVP*/
-		if (surface_count > 0 && is_pipe_split) {
+		if (surface_count > 0) {
 			if (cur_stream_status->plane_count > surface_count) {
 				force_minimal_pipe_splitting = true;
 			} else if (cur_stream_status->plane_count < surface_count) {
-- 
2.25.1

