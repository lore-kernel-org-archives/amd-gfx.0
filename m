Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B9ECA5FE0
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BDC810FA2A;
	Fri,  2 Oct 2026 19:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1/E0kuR7";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E7AD10FA25
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZeHUdpqKhkPerMab6mF6UnFlvFAj0qlYIMItfZv8JQwfh4/8kln5ECdw9nlEf0VlfuW6bgqG9+9Im24cNh4HQVyiT+SipA+UaF+ZoU10lQKKOsVZ4eWKBjrClTpmBi958Q9t4aE5/JjPp4OucqGy3H3z5OAGw8dXVPkKdKIVFdI5q/5KKo4qEsW3bEdfuN2UamvYjrzpW/eTjiT95lmofEBcgXCSHR4sSVXWB6vsoPwQImDSC/9rzBqLF+yZXKpGDiyBPGWTLlJG0Hq27G0mtwSleCa/xYqrEqP+mACNxTR0AGUm6T3343F/ZIQ9W6KJrKpFx1LRAvly92JsSCfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfDCswEIkQZOCEmRc2ixVq44OqWr6J1ttkFWGXDP9qw=;
 b=xXipFBfujl7WxTRbiuvfNMnFDrIeqIPSz8v9f4RlAfKR8O+r7Iekie6wwX3qx/7OfJej7lrdpyivMdWNo5KldCNjR9GZ6F4m7jeQPmFqXcLBQWINeQaI++xEi6JYi9cacLZjTwJinfpKcULvYXQws+MUBQbDySERMkdgknsIZ/s71nk1ynm5D78UusiD4nUgzcrEx6gaX6fleXpyU0bx7TfMwxEo+3vUFnugaI24IwEbJUK3Op1+2Q5HUVxLOsgKEDTkdhOSw2Gk+OV6LN/0yyIMNwx30GnfrnjnBeIuIxHhf3WXejHqZ+X85hEoHfCXNg4/NWlvoxRpouzjdIdr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfDCswEIkQZOCEmRc2ixVq44OqWr6J1ttkFWGXDP9qw=;
 b=1/E0kuR7ZAf/hbzTdT9c/LKLdvs680nukvdoBZ6Sb543cqu6GP1UkZKw8jg2saem+HexKuefRkabQUgd74xXn/QjJKqnf5aQ4ava+TdptddS5XXM2cY/17+30Y8i3Goa+lHoXwSmGOwMvc+RGZt6ykaWzBZ8WFm8tMrsnZ/o/Z0=
Received: from CH2PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:52::14)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 19:33:14 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::94) by CH2PR04CA0004.outlook.office365.com
 (2603:10b6:610:52::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Fri, 2
 Oct 2026 19:33:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:07 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:06 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Alvin Lee
 <Alvin.Lee2@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 05/17] drm/amd/display: Set cursor_offload for all pipes for a
 given stream
Date: Fri, 2 Oct 2026 15:32:28 -0400
Message-ID: <20261002193240.3441018-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: b75b2d85-a579-43f1-231b-08df20bc0087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AaMiY5IG+lHksCd2gKErWqpAe5pTqAF6dBkznOvubb+dK0hMLiXvk6RiA5HxJfB0R79IJEoadwx1roEQA/LLQP5GWPOnVXZVCsVtXpF42d+vrSzlSNFuItx1yEYcWd8SseCywYMnyTzUUk8UkdQL9zma17yvApRIE/LsmV5C2yniWIun86k+c23ZotjMO58ihuPlh1klgWidDQ9dKuiYth0GJeue3TmjEq2yJVoQDeS27a5Yu8TBowqVQfvAXMYgMqA6o3rTUFozdw1vzEbAvbX/W6bowpdtPRZeScTe90V0cUKMGHLnwX0SUxwkJgkFN7pjhODD2AbG6NwTvQQ+8sFhud7I2W3Iq4ut/2uKSJTb7jbNKXYElhmPQf/7SvyvPvitLqJWhyh+sSY+2scuHoIVkFvRocpog38km0PihJ99GWGg8PemDJ/eqxQcKgeApTPVZfLaAOqOFMf5vv6r3EJUSeEGmxeuCKVza/muVtq45GXSrSN9BCuuPMFG8TSTLvEJRE65q9bWRe+3AysP4ovgzp9EnMkklhJ7X4EsgdwJ/aU6IfLzJ80F2xM+hrslBbI6UiyOI/OXbCfATuXvD64bAJR3pBZBorh3Mb550e8nVbL8Z+avmBp5WtyN2uK0Npy+1yjTgGnGf0XPiwsaNACJBE94YoKSsqDlYE9IEhLKPurUkdDWj+acf2AIvzv08bOoR3YccZotMgKythHzFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LFSZ5XvzlmrQ13LcqH0AjX1kXscK0nSyiUpvyU6KxncFkq+vVpVmQSy4vWmBjz74YdtlQjO+Ie4cKHYCVdhqSORmiZEFwJqKSWynVv0eO/oP8SCF1chM8U42gFzSWjTaY7/+2B246zBDb8AI8175JelSkAiYPxrMGo0Wutx2kduNHxr8O2njsOMZb9dh8ZQoWazpqDaHQPlpflQnyohBwLeze3ht2hBYoFpi0SvE8H1u3HeiFNN3JlBQouwUPSBM99Nx1jA3kYqCCvQHun8PEPhuH1AKzyBODbHFl1UOfo/tLRee91uPlrEG5d2r53ahqk/lo8qKbMqsAwBboVOHb76S5bmwRiLz9qcQeTCx7SRoeny9USjCacxZ0mpqCglMo3DejZTLKTunIsKoO6FNQEC2wmWVELp9HsEvKKb7oqmj4+LYvf8232qig16ATu2k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:14.4150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75b2d85-a579-43f1-231b-08df20bc0087
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- When using the cursor offload path, the cursor_offload flag must
  be set for each DPP and HUBP driving the stream
- Previous implementation only sets the flag in the DPP and HUBP for
  the OTG master pipe
- Add helper function to populate an array of DPP's and HUBP's that need
  to have the cursor_offload flag set
    - This is to avoid passing in pipe_ctx to hwss execution params

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 67 ++++++++++++-------
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 36 ++++++----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 11 ++-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 11 ++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 57 ++++++++++------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   | 10 +--
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   | 11 ++-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 31 +++++----
 8 files changed, 153 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 3d88c5c377fc..4e75eb3e3dab 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -4242,6 +4242,7 @@ void hwss_begin_cursor_offload_update(struct dc *dc, union block_sequence_params
 			params->begin_cursor_offload_update_params.dmub,
 			params->begin_cursor_offload_update_params.dpp,
 			params->begin_cursor_offload_update_params.hubp,
+			params->begin_cursor_offload_update_params.pipe_count,
 			params->begin_cursor_offload_update_params.stream_idx);
 }
 
@@ -4252,6 +4253,7 @@ void hwss_commit_cursor_offload_update(struct dc *dc, union block_sequence_param
 			params->commit_cursor_offload_update_params.dmub,
 			params->commit_cursor_offload_update_params.dpp,
 			params->commit_cursor_offload_update_params.hubp,
+			params->commit_cursor_offload_update_params.pipe_count,
 			params->commit_cursor_offload_update_params.stream_idx);
 }
 
@@ -4273,6 +4275,7 @@ void hwss_abort_cursor_offload_update(struct dc *dc, union block_sequence_params
 			params->abort_cursor_offload_update_params.dmub,
 			params->abort_cursor_offload_update_params.dpp,
 			params->abort_cursor_offload_update_params.hubp,
+			params->abort_cursor_offload_update_params.pipe_count,
 			params->abort_cursor_offload_update_params.stream_idx);
 }
 
@@ -5912,25 +5915,47 @@ void hwss_add_update_cursor_offload_pipe(struct block_sequence_state *seq_state,
 	}
 }
 
+uint8_t hwss_build_cursor_offload_pipe_list(struct pipe_ctx *pipe_ctx,
+		struct dpp **dpp,
+		struct hubp **hubp)
+{
+	struct pipe_ctx *otg_master = resource_get_otg_master(pipe_ctx);
+	struct pipe_ctx *odm_pipe;
+	struct pipe_ctx *mpc_pipe;
+	uint8_t count = 0;
+
+	if (!otg_master)
+		return 0;
+
+	for (odm_pipe = otg_master; odm_pipe != NULL; odm_pipe = odm_pipe->next_odm_pipe) {
+		for (mpc_pipe = odm_pipe; mpc_pipe != NULL; mpc_pipe = mpc_pipe->bottom_pipe) {
+			if (count >= MAX_PIPES)
+				return count;
+			dpp[count] = mpc_pipe->plane_res.dpp;
+			hubp[count] = mpc_pipe->plane_res.hubp;
+			count++;
+		}
+	}
+
+	return count;
+}
+
 void hwss_add_commit_cursor_offload_update(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx)
 {
 	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+	struct commit_cursor_offload_update_params *p;
 
 	if (!top_pipe)
 		return;
 
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = HWSS_COMMIT_CURSOR_OFFLOAD_UPDATE;
-		seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params.dmub =
-			dc->ctx->dmub_srv->dmub;
-		seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params.stream_idx =
-			top_pipe->pipe_idx;
-		seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params.dpp =
-			 pipe_ctx->plane_res.dpp;
-		seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params.hubp =
-			pipe_ctx->plane_res.hubp;
+		p = &seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params;
+		p->dmub = dc->ctx->dmub_srv->dmub;
+		p->stream_idx = top_pipe->pipe_idx;
+		p->pipe_count = hwss_build_cursor_offload_pipe_list(pipe_ctx, p->dpp, p->hubp);
 		(*seq_state->num_steps)++;
 	}
 }
@@ -5940,20 +5965,17 @@ void hwss_add_begin_cursor_offload_update(struct block_sequence_state *seq_state
 		struct pipe_ctx *pipe_ctx)
 {
 	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+	struct begin_cursor_offload_update_params *p;
 
 	if (!top_pipe)
 		return;
 
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = HWSS_BEGIN_CURSOR_OFFLOAD_UPDATE;
-		seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params.dmub =
-			dc->ctx->dmub_srv->dmub;
-		seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params.stream_idx =
-			top_pipe->pipe_idx;
-		seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params.dpp =
-			 pipe_ctx->plane_res.dpp;
-		seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params.hubp =
-			pipe_ctx->plane_res.hubp;
+		p = &seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params;
+		p->dmub = dc->ctx->dmub_srv->dmub;
+		p->stream_idx = top_pipe->pipe_idx;
+		p->pipe_count = hwss_build_cursor_offload_pipe_list(pipe_ctx, p->dpp, p->hubp);
 		(*seq_state->num_steps)++;
 	}
 }
@@ -5963,20 +5985,17 @@ void hwss_add_abort_cursor_offload_update(struct block_sequence_state *seq_state
 		struct pipe_ctx *pipe_ctx)
 {
 	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+	struct abort_cursor_offload_update_params *p;
 
 	if (!top_pipe)
 		return;
 
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = ABORT_CURSOR_OFFLOAD_UPDATE;
-		seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params.dmub =
-			dc->ctx->dmub_srv->dmub;
-		seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params.stream_idx =
-			top_pipe->pipe_idx;
-		seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params.dpp =
-			 pipe_ctx->plane_res.dpp;
-		seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params.hubp =
-			pipe_ctx->plane_res.hubp;
+		p = &seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params;
+		p->dmub = dc->ctx->dmub_srv->dmub;
+		p->stream_idx = top_pipe->pipe_idx;
+		p->pipe_count = hwss_build_cursor_offload_pipe_list(pipe_ctx, p->dpp, p->hubp);
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 6b01db8b32d0..d92c51b01272 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -309,6 +309,9 @@ void program_cursor_attributes(
 	struct pipe_ctx *pipe_to_program = NULL;
 	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
 	bool unlock_dmub = false;
+	struct dpp *dpp[MAX_PIPES];
+	struct hubp *hubp[MAX_PIPES];
+	uint8_t pipe_count = 0;
 
 	if (!stream)
 		return;
@@ -327,10 +330,13 @@ void program_cursor_attributes(
 			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
 				struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
 
-				if (top_pipe)
+				if (top_pipe) {
+					pipe_count =
+						hwss_build_cursor_offload_pipe_list(pipe_ctx, dpp, hubp);
+
 					dc->hwss.begin_cursor_offload_update(dc->ctx->dmub_srv->dmub,
-						pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp,
-						top_pipe->pipe_idx);
+						dpp, hubp, pipe_count, top_pipe->pipe_idx);
+				}
 			} else {
 				if (dc->hwss.dmub_hw_control_lock && pipe_ctx->stream &&
 				    should_use_dmub_inbox0_lock_for_link(dc, pipe_ctx->stream->link)) {
@@ -362,10 +368,10 @@ void program_cursor_attributes(
 		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update) {
 			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_to_program);
 
-			if (top_pipe)
+			if (top_pipe) {
 				dc->hwss.commit_cursor_offload_update(dc->ctx->dmub_srv->dmub,
-					pipe_to_program->plane_res.dpp, pipe_to_program->plane_res.hubp,
-					top_pipe->pipe_idx);
+					dpp, hubp, pipe_count, top_pipe->pipe_idx);
+			}
 		} else {
 			dc->hwss.cursor_lock(dc, pipe_to_program, false);
 			if (pipe_to_program->next_odm_pipe)
@@ -493,6 +499,9 @@ void program_cursor_position(
 	struct pipe_ctx *pipe_to_program = NULL;
 	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
 	bool unlock_dmub = false;
+	struct dpp *dpp[MAX_PIPES];
+	struct hubp *hubp[MAX_PIPES];
+	uint8_t pipe_count = 0;
 
 	if (!stream)
 		return;
@@ -515,10 +524,13 @@ void program_cursor_position(
 			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
 				struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
 
-				if (top_pipe)
+				if (top_pipe) {
+					pipe_count =
+						hwss_build_cursor_offload_pipe_list(pipe_ctx, dpp, hubp);
+
 					dc->hwss.begin_cursor_offload_update(dc->ctx->dmub_srv->dmub,
-						pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp,
-						top_pipe->pipe_idx);
+						dpp, hubp, pipe_count, top_pipe->pipe_idx);
+				}
 			} else {
 				if (dc->hwss.dmub_hw_control_lock && pipe_ctx->stream &&
 				    should_use_dmub_inbox0_lock_for_link(dc, pipe_ctx->stream->link)) {
@@ -547,10 +559,10 @@ void program_cursor_position(
 		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update) {
 			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_to_program);
 
-			if (top_pipe)
+			if (top_pipe) {
 				dc->hwss.commit_cursor_offload_update(dc->ctx->dmub_srv->dmub,
-					pipe_to_program->plane_res.dpp, pipe_to_program->plane_res.hubp,
-					top_pipe->pipe_idx);
+					dpp, hubp, pipe_count, top_pipe->pipe_idx);
+			}
 		} else {
 			dc->hwss.cursor_lock(dc, pipe_to_program, false);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 33f7ab4c6c15..771555ec1431 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3168,11 +3168,16 @@ static void dcn10_update_dchubp_dpp(
 	if (pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
 		if (dc_dmub_srv_is_cursor_offload_enabled(dc) && dc->hwss.abort_cursor_offload_update) {
 			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+			struct dpp *dpp[MAX_PIPES];
+			struct hubp *hubp[MAX_PIPES];
+
+			if (top_pipe) {
+				uint8_t pipe_count =
+					hwss_build_cursor_offload_pipe_list(pipe_ctx, dpp, hubp);
 
-			if (top_pipe)
 				dc->hwss.abort_cursor_offload_update(dc->ctx->dmub_srv->dmub,
-					pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp,
-					top_pipe->pipe_idx);
+					dpp, hubp, pipe_count, top_pipe->pipe_idx);
+			}
 		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index f408589072d7..e8b9495c799f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1840,11 +1840,16 @@ void dcn20_update_dchubp_dpp(
 			pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
 		if (dc_dmub_srv_is_cursor_offload_enabled(dc) && dc->hwss.abort_cursor_offload_update) {
 			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+			struct dpp *dpp[MAX_PIPES];
+			struct hubp *hubp[MAX_PIPES];
+
+			if (top_pipe) {
+				uint8_t pipe_count =
+					hwss_build_cursor_offload_pipe_list(pipe_ctx, dpp, hubp);
 
-			if (top_pipe)
 				dc->hwss.abort_cursor_offload_update(dc->ctx->dmub_srv->dmub,
-					pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp,
-					top_pipe->pipe_idx);
+					dpp, hubp, pipe_count, top_pipe->pipe_idx);
+			}
 		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index a959d8c37b6a..41abfff6cf47 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1646,9 +1646,30 @@ void dcn35_hardware_release(struct dc *dc)
 		dc->hwss.hw_block_power_up(dc, &pg_update_state);
 }
 
-void dcn35_abort_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, struct hubp *hubp, uint32_t stream_idx)
+/* Set the cursor offload flag on every resolved hubp/dpp in the pipe tree. */
+static void dcn35_set_cursor_offload(struct dpp **dpp, struct hubp **hubp,
+		uint8_t pipe_count, bool enable)
 {
-	struct dc *dc = dpp->ctx->dc;
+	uint8_t i;
+
+	for (i = 0; i < pipe_count; i++) {
+		if (hubp[i])
+			hubp[i]->cursor_offload = enable;
+		if (dpp[i])
+			dpp[i]->cursor_offload = enable;
+	}
+}
+
+void dcn35_abort_cursor_offload_update(struct dmub_srv *dmub, struct dpp **dpp,
+		struct hubp **hubp, uint8_t pipe_count, uint32_t stream_idx)
+{
+	struct dc *dc;
+	uint8_t i;
+
+	if (pipe_count == 0 || dpp[0] == NULL)
+		return;
+
+	dc = dpp[0]->ctx->dc;
 
 	/*
 	 * Insert a blank update to modify the write index and set pipe_mask to 0.
@@ -1667,10 +1688,10 @@ void dcn35_abort_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, s
 	 */
 
 	if (dc->hwss.begin_cursor_offload_update)
-		dc->hwss.begin_cursor_offload_update(dmub, dpp, hubp, stream_idx);
+		dc->hwss.begin_cursor_offload_update(dmub, dpp, hubp, pipe_count, stream_idx);
 
 	if (dc->hwss.commit_cursor_offload_update)
-		dc->hwss.commit_cursor_offload_update(dmub, dpp, hubp, stream_idx);
+		dc->hwss.commit_cursor_offload_update(dmub, dpp, hubp, pipe_count, stream_idx);
 
 	/*
 	 * The aborted payload is dropped by firmware, so resync the SW cursor
@@ -1678,13 +1699,16 @@ void dcn35_abort_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, s
 	 * set_cursor_position re-program CURSOR_ENABLE instead of skipping it
 	 * because of a stale cache.
 	 */
-	if (dpp->funcs->refresh_cursor_state)
-		dpp->funcs->refresh_cursor_state(dpp);
-	if (hubp && hubp->funcs->refresh_cursor_state)
-		hubp->funcs->refresh_cursor_state(hubp);
+	for (i = 0; i < pipe_count; i++) {
+		if (dpp[i] && dpp[i]->funcs->refresh_cursor_state)
+			dpp[i]->funcs->refresh_cursor_state(dpp[i]);
+		if (hubp[i] && hubp[i]->funcs->refresh_cursor_state)
+			hubp[i]->funcs->refresh_cursor_state(hubp[i]);
+	}
 }
 
-void dcn35_begin_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, struct hubp *hubp, uint32_t stream_idx)
+void dcn35_begin_cursor_offload_update(struct dmub_srv *dmub, struct dpp **dpp,
+		struct hubp **hubp, uint8_t pipe_count, uint32_t stream_idx)
 {
 	volatile struct dmub_cursor_offload_v1 *cs = dmub->cursor_offload_v1;
 	uint32_t write_idx, payload_idx;
@@ -1695,24 +1719,17 @@ void dcn35_begin_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, s
 	cs->offload_streams[stream_idx].payloads[payload_idx].write_idx_start = write_idx;
 	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask = 0;
 
-	if (hubp)
-		hubp->cursor_offload = true;
-
-	if (dpp)
-		dpp->cursor_offload = true;
+	dcn35_set_cursor_offload(dpp, hubp, pipe_count, true);
 }
 
-void dcn35_commit_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, struct hubp *hubp, uint32_t stream_idx)
+void dcn35_commit_cursor_offload_update(struct dmub_srv *dmub, struct dpp **dpp,
+		struct hubp **hubp, uint8_t pipe_count, uint32_t stream_idx)
 {
 	volatile struct dmub_cursor_offload_v1 *cs = dmub->cursor_offload_v1;
 	volatile struct dmub_shared_state_cursor_offload_stream_v1 *shared_stream;
 	uint32_t write_idx, payload_idx;
 
-	if (hubp)
-		hubp->cursor_offload = false;
-
-	if (dpp)
-		dpp->cursor_offload = false;
+	dcn35_set_cursor_offload(dpp, hubp, pipe_count, false);
 
 	write_idx = cs->offload_streams[stream_idx].write_idx + 1; /*  new payload (+1) */
 	payload_idx = write_idx % ARRAY_SIZE(cs->offload_streams[stream_idx].payloads);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 9f779e408ec6..d47f7232f863 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -105,10 +105,12 @@ bool dcn35_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
 
 void dcn35_hardware_release(struct dc *dc);
 
-void dcn35_abort_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, struct hubp *hubp, uint32_t stream_idx);
-void dcn35_begin_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, struct hubp *hubp, uint32_t stream_idx);
-void dcn35_commit_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp,
-	struct hubp *hubp, uint32_t stream_idx);
+void dcn35_abort_cursor_offload_update(struct dmub_srv *dmub, struct dpp **dpp,
+		struct hubp **hubp, uint8_t pipe_count, uint32_t stream_idx);
+void dcn35_begin_cursor_offload_update(struct dmub_srv *dmub, struct dpp **dpp,
+		struct hubp **hubp, uint8_t pipe_count, uint32_t stream_idx);
+void dcn35_commit_cursor_offload_update(struct dmub_srv *dmub, struct dpp **dpp,
+		struct hubp **hubp, uint8_t pipe_count, uint32_t stream_idx);
 void dcn35_update_cursor_offload_pipe(struct dmub_srv *dmub, uint32_t stream_idx,
 		uint8_t pipe_idx, const struct dpp *dpp, const struct hubp *hubp);
 void dcn35_notify_cursor_offload_drr_update(struct dc *dc, struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
index 0361c520b7d9..7a82aaa6d1d6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
@@ -204,11 +204,16 @@ void dcn50_update_dchubp_dpp(
 		pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
 		if (dc_dmub_srv_is_cursor_offload_enabled(dc) && dc->hwss.abort_cursor_offload_update) {
 			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+			struct dpp *dpp[MAX_PIPES];
+			struct hubp *hubp[MAX_PIPES];
+
+			if (top_pipe) {
+				uint8_t pipe_count =
+					hwss_build_cursor_offload_pipe_list(pipe_ctx, dpp, hubp);
 
-			if (top_pipe)
 				dc->hwss.abort_cursor_offload_update(dc->ctx->dmub_srv->dmub,
-					pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp,
-					top_pipe->pipe_idx);
+					dpp, hubp, pipe_count, top_pipe->pipe_idx);
+			}
 		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index c0c098b5bcaa..de7a12c706ac 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -887,8 +887,9 @@ struct phantom_hubp_post_enable_params {
 
 struct begin_cursor_offload_update_params {
 	struct dmub_srv *dmub;
-	struct dpp *dpp;
-	struct hubp *hubp;
+	struct dpp *dpp[MAX_PIPES];
+	struct hubp *hubp[MAX_PIPES];
+	uint8_t pipe_count;
 	uint32_t stream_idx;
 };
 
@@ -902,15 +903,17 @@ struct update_cursor_offload_pipe_params {
 
 struct commit_cursor_offload_update_params {
 	struct dmub_srv *dmub;
-	struct dpp *dpp;
-	struct hubp *hubp;
+	struct dpp *dpp[MAX_PIPES];
+	struct hubp *hubp[MAX_PIPES];
+	uint8_t pipe_count;
 	uint32_t stream_idx;
 };
 
 struct abort_cursor_offload_update_params {
 	struct dmub_srv *dmub;
-	struct dpp *dpp;
-	struct hubp *hubp;
+	struct dpp *dpp[MAX_PIPES];
+	struct hubp *hubp[MAX_PIPES];
+	uint8_t pipe_count;
 	uint32_t stream_idx;
 };
 
@@ -1526,12 +1529,12 @@ struct hw_sequencer_funcs {
 	void (*set_cursor_position_legacy)(struct pipe_ctx *pipe);
 	void (*set_cursor_attribute)(struct pipe_ctx *pipe);
 	void (*set_cursor_sdr_white_level)(struct pipe_ctx *pipe);
-	void (*abort_cursor_offload_update)(struct dmub_srv *dmub, struct dpp *dpp,
-			struct hubp *hubp, uint32_t stream_idx);
-	void (*begin_cursor_offload_update)(struct dmub_srv *dmub, struct dpp *dpp,
-			struct hubp *hubp, uint32_t stream_idx);
-	void (*commit_cursor_offload_update)(struct dmub_srv *dmub, struct dpp *dpp,
-			struct hubp *hubp, uint32_t stream_idx);
+	void (*abort_cursor_offload_update)(struct dmub_srv *dmub, struct dpp **dpp,
+			struct hubp **hubp, uint8_t pipe_count, uint32_t stream_idx);
+	void (*begin_cursor_offload_update)(struct dmub_srv *dmub, struct dpp **dpp,
+			struct hubp **hubp, uint8_t pipe_count, uint32_t stream_idx);
+	void (*commit_cursor_offload_update)(struct dmub_srv *dmub, struct dpp **dpp,
+			struct hubp **hubp, uint8_t pipe_count, uint32_t stream_idx);
 	void (*update_cursor_offload_pipe)(struct dmub_srv *dmub,
 			uint32_t stream_idx,
 			uint8_t pipe_idx,
@@ -2655,6 +2658,10 @@ void hwss_add_opp_program_left_edge_extra_pixel(struct block_sequence_state *seq
 void hwss_add_hubp_enable_3dlut_fl(struct block_sequence_state *seq_state,
 		struct hubp *hubp);
 
+uint8_t hwss_build_cursor_offload_pipe_list(struct pipe_ctx *pipe_ctx,
+		struct dpp **dpp,
+		struct hubp **hubp);
+
 void hwss_add_begin_cursor_offload_update(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx);
-- 
2.34.1

