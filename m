Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914E5C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 14:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F0FF10F348;
	Wed, 12 Jan 2022 14:28:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9678410F348
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 14:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHPBRuoL+s4Po6lIdPQtczHD7J+Hfl0hQvzsLlGe7dCygJc9+3xwvnJOPw/DEetn20DfPbNNOtBCDq5PYpCPmI8bJnvHqPVXlU4mBzbs1bYuKdCjsha/+lNlOWSA25V1jwZNHfFaS4o2g6L5LAs612lDEXT4kyhvaY6UaiIKvz4rZg8jphP6pcoo+G3/QhzcQ1TW3BkQLeSYokOVeJ4ekxXR2JePtuCN+zibOKQCjl8M5YXgHUlVS+/6Aec65/nOj+UQj8xU2FwZ80XTkOLU8K1bT6VlZyy292mJ2hdz/TLVzCUPvthmT5bERc9sHHuTAH+PdyXJO9HCnZwGtLWEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+Qlg9Io+vrk++vt9fTJRknphQJkvnPgqWd5tQTB1TY=;
 b=FRu0fmQ4n4O1cY0BX4GlaDttDnTeZBpAQUZ7Lvewju2uKVfYP35DxsVRPIpI/8IXblmwG/DM6aQpgKnSmGn/8XyrHpZ2hxmxhHiluS7i0210YhTbifld/HtX7T21I7wj4vAuXGZxQLhxZCJtjAWu+ODs7PMqNSNBjHl6dkgLoLROZRLAxVP65TLPXSMEyhG2ONcdouaaS/aSv/eHw/WsUC6FXmPa6ll95z1kV9xwZq8wyGCpc7KG2ACH/kLEZvgAOteiQBzAh8gtURJG+W1ru82WfBByNThqqtdDKbIwjab95X9YB57m+iqMjwxY11rf3eE8D0Qcgc8wdNjzhjgIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+Qlg9Io+vrk++vt9fTJRknphQJkvnPgqWd5tQTB1TY=;
 b=eEk5U73JB7RLpCVwbskjg4TdJQptkow0bGFb9RO2ONYjCIJ3qdinJG12ZOuBXoWGbQcRwysk0QXK/BGSCrHD8K1JWFsGqDwZFN8EvNMQfvWeJpABCAX2dcfE4OW60akj2tZSfApaRm+OvUnvqT8m/nbJHbBj6sOi1VRKY9AQdeo=
Received: from BN6PR13CA0001.namprd13.prod.outlook.com (2603:10b6:404:10a::11)
 by MWHPR12MB1533.namprd12.prod.outlook.com (2603:10b6:301:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 14:28:35 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::2a) by BN6PR13CA0001.outlook.office365.com
 (2603:10b6:404:10a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 14:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 14:28:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 08:28:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 06:28:29 -0800
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 12 Jan 2022 08:28:11 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Fix for otg synchronization logic
Date: Wed, 12 Jan 2022 09:27:27 -0500
Message-ID: <20220112142727.16295-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112142727.16295-1-harry.wentland@amd.com>
References: <20220112142727.16295-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d08f2f08-8ea3-4ab7-fbc4-08d9d5d7d118
X-MS-TrafficTypeDiagnostic: MWHPR12MB1533:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1533EC8F8FEFAEAF6E1649CE8C529@MWHPR12MB1533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBxlcpMUGpFsss1kMn39XeXJITAYWR8b1ieoRGTV8LpQtGLM6EPYY/B3oWUG9MwShtQyfca4iGcoaomoeWYgcXdcr1Oj1rVj59UVL9t+EM04kHoogbeIveqxS92gff32UxCUYrD3UOx8r4GfzoceMso0AOakvbl8JcaxwqVDRI1IIO+qJaWtfXTgJ+sFvLuKPSUTUeZ9+niv5ty7iOKd7jVYNi8UOTj54WBAPF4rIk8z2w8NOpcW7fdRrNj7S/9bbxCwsJRmI6TlmevhoNk1CRjrJYOLeu5OAA2hYyxJHaQFubZ823/sh7PItP3E79L/1pvxMGewfAno+gQCSMdeRzSZav2TKbWO/iw1qDckuUd94+oFI+kJ3EEfeVNTxIBZHoG9Zbny6f6muFOfxKpqy/86XtfhSM+RQCae38lW95iEPtufP7+/wDhtaddzbQZi+BVVmUjPSMzfMzXyubBd/xztEwi0gStjICNF1qbr3dNq7vLOASSqTYWL3qOVKRYrtHSmp0HqQenRNeHBnzHAAUpoO7UhzuEuaxHBF5hZDAExZSGupjccmztNp4v5/gAd77+pw36AjjhFQxNowmimn5Orcym3SbcAR3QnOwsBuNdb1FHsZqOcgizQwl9uiDyVPmhFBbL9SNjdCmSZtSEpEArKkavosjlNlCdtFEJIP5ewD/IhOmof58jOJ0awit1giMbpXPMK1mhHHn2+UlO41ofMJTkBpsxjbqhPAG1NnKHatYCeTIZkIioPt6xOLNatw2ISLsBtMg2gTr20a0y0rozrMJbu/xhGkiTakwilies=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(6666004)(316002)(36756003)(6916009)(8936002)(8676002)(1076003)(4326008)(54906003)(44832011)(2906002)(82310400004)(336012)(186003)(7696005)(70586007)(356005)(40460700001)(86362001)(81166007)(426003)(508600001)(5660300002)(36860700001)(70206006)(47076005)(83380400001)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 14:28:35.1927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d08f2f08-8ea3-4ab7-fbc4-08d9d5d7d118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1533
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 torvalds@linux-foundation.org, Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet
 Lakha <Bhawanpreet.Lakha@amd.com>, Mustapha Ghaddar <mustapha.ghaddar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
During otg sync trigger, plane states are used to decide whether the otg
is already synchronized or not. There are scenarions when otgs are
disabled without plane state getting disabled and in such case the otg is
excluded from synchronization.

[How]
Introduced pipe_idx_syncd in pipe_ctx that tracks each otgs master pipe.
When a otg is disabled/enabled, pipe_idx_syncd is reset to itself.
On sync trigger, pipe_idx_syncd is checked to decide whether a otg is
already synchronized and the otg is further included or excluded from
synchronization.

v2:
  Don't drop is_blanked logic

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Mustapha Ghaddar <mustapha.ghaddar@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: meenakshikumar somasundaram <meenakshikumar.somasundaram@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Cc: torvalds@linux-foundation.org
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 40 +++++++++-----
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 54 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  8 +++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  3 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 11 ++++
 7 files changed, 105 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 01c8849b9db2..6f5528d34093 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1404,20 +1404,34 @@ static void program_timing_sync(
 				status->timing_sync_info.master = false;
 
 		}
-		/* remove any other unblanked pipes as they have already been synced */
-		for (j = j + 1; j < group_size; j++) {
-			bool is_blanked;
 
-			if (pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked)
-				is_blanked =
-					pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked(pipe_set[j]->stream_res.opp);
-			else
-				is_blanked =
-					pipe_set[j]->stream_res.tg->funcs->is_blanked(pipe_set[j]->stream_res.tg);
-			if (!is_blanked) {
-				group_size--;
-				pipe_set[j] = pipe_set[group_size];
-				j--;
+		/* remove any other pipes that are already been synced */
+		if (dc->config.use_pipe_ctx_sync_logic) {
+			/* check pipe's syncd to decide which pipe to be removed */
+			for (j = 1; j < group_size; j++) {
+				if (pipe_set[j]->pipe_idx_syncd == pipe_set[0]->pipe_idx_syncd) {
+					group_size--;
+					pipe_set[j] = pipe_set[group_size];
+					j--;
+				} else
+					/* link slave pipe's syncd with master pipe */
+					pipe_set[j]->pipe_idx_syncd = pipe_set[0]->pipe_idx_syncd;
+			}
+		} else {
+			for (j = j + 1; j < group_size; j++) {
+				bool is_blanked;
+
+				if (pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked)
+					is_blanked =
+						pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked(pipe_set[j]->stream_res.opp);
+				else
+					is_blanked =
+						pipe_set[j]->stream_res.tg->funcs->is_blanked(pipe_set[j]->stream_res.tg);
+				if (!is_blanked) {
+					group_size--;
+					pipe_set[j] = pipe_set[group_size];
+					j--;
+				}
 			}
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d4ff6cc6b8d9..b3912ff9dc91 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3217,6 +3217,60 @@ struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
 }
 #endif
 
+void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
+		struct dc_state *context)
+{
+	int i, j;
+	struct pipe_ctx *pipe_ctx_old, *pipe_ctx, *pipe_ctx_syncd;
+
+	/* If pipe backend is reset, need to reset pipe syncd status */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe_ctx_old =	&dc->current_state->res_ctx.pipe_ctx[i];
+		pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe_ctx_old->stream)
+			continue;
+
+		if (pipe_ctx_old->top_pipe || pipe_ctx_old->prev_odm_pipe)
+			continue;
+
+		if (!pipe_ctx->stream ||
+				pipe_need_reprogram(pipe_ctx_old, pipe_ctx)) {
+
+			/* Reset all the syncd pipes from the disabled pipe */
+			for (j = 0; j < dc->res_pool->pipe_count; j++) {
+				pipe_ctx_syncd = &context->res_ctx.pipe_ctx[j];
+				if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_syncd) == pipe_ctx_old->pipe_idx) ||
+					!IS_PIPE_SYNCD_VALID(pipe_ctx_syncd))
+					SET_PIPE_SYNCD_TO_PIPE(pipe_ctx_syncd, j);
+			}
+		}
+	}
+}
+
+void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
+	struct dc_state *context,
+	uint8_t disabled_master_pipe_idx)
+{
+	int i;
+	struct pipe_ctx *pipe_ctx, *pipe_ctx_check;
+
+	pipe_ctx = &context->res_ctx.pipe_ctx[disabled_master_pipe_idx];
+	if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx) != disabled_master_pipe_idx) ||
+		!IS_PIPE_SYNCD_VALID(pipe_ctx))
+		SET_PIPE_SYNCD_TO_PIPE(pipe_ctx, disabled_master_pipe_idx);
+
+	/* for the pipe disabled, check if any slave pipe exists and assert */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe_ctx_check = &context->res_ctx.pipe_ctx[i];
+
+		if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_check) == disabled_master_pipe_idx) &&
+			IS_PIPE_SYNCD_VALID(pipe_ctx_check) && (i != disabled_master_pipe_idx))
+			DC_ERR("DC: Failure: pipe_idx[%d] syncd with disabled master pipe_idx[%d]\n",
+				i, disabled_master_pipe_idx);
+	}
+}
+
 uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter transmitter)
 {
 	/* TODO - get transmitter to phy idx mapping from DMUB */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index da2c78ce14d6..288e7b01f561 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -344,6 +344,7 @@ struct dc_config {
 	uint8_t  vblank_alignment_max_frame_time_diff;
 	bool is_asymmetric_memory;
 	bool is_single_rank_dimm;
+	bool use_pipe_ctx_sync_logic;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 78192ecba102..f1593186e964 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1566,6 +1566,10 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 				&pipe_ctx->stream->audio_info);
 	}
 
+	/* make sure no pipes syncd to the pipe being enabled */
+	if (!pipe_ctx->stream->apply_seamless_boot_optimization && dc->config.use_pipe_ctx_sync_logic)
+		check_syncd_pipes_for_disabled_master_pipe(dc, context, pipe_ctx->pipe_idx);
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* DCN3.1 FPGA Workaround
 	 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
@@ -2297,6 +2301,10 @@ enum dc_status dce110_apply_ctx_to_hw(
 	enum dc_status status;
 	int i;
 
+	/* reset syncd pipes from disabled pipes */
+	if (dc->config.use_pipe_ctx_sync_logic)
+		reset_syncd_pipes_from_disabled_pipes(dc, context);
+
 	/* Reset old context */
 	/* look up the targets that have been removed since last commit */
 	hws->funcs.reset_hw_ctx_wrap(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 1f1c158658ac..40778c05f9b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2254,6 +2254,9 @@ static bool dcn31_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	/* Use pipe context based otg sync logic */
+	dc->config.use_pipe_ctx_sync_logic = true;
+
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 890280026e69..943240e2809e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -382,6 +382,7 @@ struct pipe_ctx {
 	struct pll_settings pll_settings;
 
 	uint8_t pipe_idx;
+	uint8_t pipe_idx_syncd;
 
 	struct pipe_ctx *top_pipe;
 	struct pipe_ctx *bottom_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 4249bf306e09..dbfe6690ded8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -34,6 +34,10 @@
 #define MEMORY_TYPE_HBM 2
 
 
+#define IS_PIPE_SYNCD_VALID(pipe) ((((pipe)->pipe_idx_syncd) & 0x80)?1:0)
+#define GET_PIPE_SYNCD_FROM_PIPE(pipe) ((pipe)->pipe_idx_syncd & 0x7F)
+#define SET_PIPE_SYNCD_TO_PIPE(pipe, pipe_syncd) ((pipe)->pipe_idx_syncd = (0x80 | pipe_syncd))
+
 enum dce_version resource_parse_asic_id(
 		struct hw_asic_id asic_id);
 
@@ -208,6 +212,13 @@ struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
 		const struct dc_link *link);
 #endif
 
+void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
+	struct dc_state *context);
+
+void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
+	struct dc_state *context,
+	uint8_t disabled_master_pipe_idx);
+
 uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter transmitter);
 
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.34.1

