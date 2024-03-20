Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7682C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DCC210EBC0;
	Wed, 20 Mar 2024 06:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xVY63mfq";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD1810EBC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLtFaW4SRpPaY3AlMqrHOwlMuH0IhQqsYgsWz7kZf7+YJsM+CbF4RZqMyjfEjoEoHE/CzE98mGmeyMZlJlcCCrJhGTsRvSpiRo2/0vtNBs/Kbtv/b+JgxPkPHOI7mudrx4X+sxkdbLjPOk+1SfTj81cNqWin6n8ZDtFpDajZjnJBnegN92erEzjzaDoFKjNOsQacBTdxLrrbUFWzzj2w9tRtVRVoOg7Vb86DmCCyqko+Uvc0mrn580OmPnZAuJxx5KFt7HX0P+N7TaY9NiiGz5ZjucmIbsU6fEes7tiNJuYlPL76i58fvR+ivsN7+oMBiYCVW70xtF/QJUev/Sdqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OQSsxcX68UjRK03bom3DQY10wz4E00KwzePTKy9QBY=;
 b=kwbDUvXOsDiSwll7jUdKbbO4tbEVVoqrBie/i5xW+c8D0HjTyQyJU/s6/EHZfJQygklMaQr7A0UUu8GRfQo1LjbNexrZ+kDg2x2fGytRIM9lJYZgTPY5JJ/03dwqSsdVTvx9Oy2n0j3QiwFvZ4RRlx1oaXRhabg8RwBfiNTjFeJfwejDzu5CqHIssOSGUyXXLuyAFAoda4yk7sC89Z22Xigcc7fd/rZuEX83rpKafXespd7irlZyg03/xvwp5AkVJJikZd/MPQUEA70dV9dAIAXxIj/lLyDsHLq+RYChQImlP56PGj4cFvmsyVXzE3FKJI+78jjWMRkUphxkeIezsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OQSsxcX68UjRK03bom3DQY10wz4E00KwzePTKy9QBY=;
 b=xVY63mfqT1NEZxF5VzGlpllFWyfoc5wHEyQU7NABYXKoJ38FBfcJWJGQzulGF3Sv5p11n4GsZhn6ZntBq0rjT6xmzWM7y3pWwUvTqpUYMdzzvlRCyhx4NJVOwCSVYDHAL7q3U7ZtOD4an6Gh3jXSHe0N3bq6qMi7OMs1nAngsPA=
Received: from BN9PR03CA0161.namprd03.prod.outlook.com (2603:10b6:408:f4::16)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 06:36:20 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::a3) by BN9PR03CA0161.outlook.office365.com
 (2603:10b6:408:f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:19 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 23:36:14 -0700
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:11 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Natanel Roizenman
 <natanel.roizenman@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 02/22] drm/amd/display: Consolidate HPO enable/disable and
 restrict only to state transitions.
Date: Wed, 20 Mar 2024 14:35:36 +0800
Message-ID: <20240320063556.1326615-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: dd84eef1-b191-4d40-af34-08dc48a80d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekTO8AmlVr3L0jH/3KhfqV9934k4KL7R2bDlCRrRYkGconYGypD8ZIBRAOoW0RdA7dEjeYs9vOToBvaukgmmdqOoEqHjZ4PXZSJqPkOzKUl/DPX4v5iZFYbIiqLD2pLBqE2Y0FY3avMPNrbP7Y67F3q7/X1Y0+ZDS8XUGOsVA9PSjxgS5WqRLtRwoHT5lLx+9u0Fz9YRBtD17PmFJRynm+F1vrA5Wztf8of3LSIyTQKtBoOFJ+oQPDuiiKvik4tm+bM2rQaiqssgfxpFXWEdtJUD8+H1TCSns0CxqNsM6nKUgJnlOTNuUhRaafU4xHx5NDKXAyv1mELkFsdsZD2YW0ZlFGJwdXpVy0G8RlbQzdgfZuBgQcV6Q4xUPKtm7gcqRJVOwIy9fNkhfLpmTBNtP8q2+Zr9tK78BwRuUVZNalwqAW3GLz+hzhy5PvOxg2ivs4PhzZhfTAZTEI9ZEqMf+iFBXJsxCbyFQlZdKIn6MnG7oWqqEvhVDaQG1qP04E+ceAcZfzbUc7ug3eWjCf2pC6SlffvUStZS2qKw0GrjYiXyfNUE2qtPUzX78KMYSImZn7bB3YvfXBonGzzaW2wlci9lcvYEmLwrOt5JizV/cxeHMoS1xEjUhqWX4iUcucVxHRiFKzkdTD4FDivYhejztf5UneEMAm3vsrnR85PMJUHHpJtLhnCuXbmPZ0iwiekfahkLuTc4xGwE/dQxc9qg/AgDnemnTQIRyzlKw+4gjA00HnOIyMNlqq0slhSRY3od
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:19.2062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd84eef1-b191-4d40-af34-08dc48a80d2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
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

From: Natanel Roizenman <natanel.roizenman@amd.com>

[WHY]
Previously, we'd disabled HPO whenever an HPO display was disconnected. This
caused other HPO displays to blank whenever one was unplugged.

[HOW]
This change restricts HPO enable/disable to dce110_apply_ctx_to_hw and adds a
helper function (dce110_is_hpo_enabled) that returns true if any HPO displays
are present in a context. We compare the current and previous dc ctx to check
whether HPO is transitioning from on to off or vice versa, and adjust the HPO
state accordingly.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Natanel Roizenman <natanel.roizenman@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 29 ++++++++++++-------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  5 ----
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 0ba1feaf96c0..de5542c20103 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1192,16 +1192,6 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
 					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
-
-	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
-		/* TODO: This looks like a bug to me as we are disabling HPO IO when
-		 * we are just disabling a single HPO stream. Shouldn't we disable HPO
-		 * HW control only when HPOs for all streams are disabled?
-		 */
-		if (pipe_ctx->stream->ctx->dc->hwseq->funcs.setup_hpo_hw_control)
-			pipe_ctx->stream->ctx->dc->hwseq->funcs.setup_hpo_hw_control(
-					pipe_ctx->stream->ctx->dc->hwseq, false);
-	}
 }
 
 void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
@@ -2288,6 +2278,19 @@ static void dce110_setup_audio_dto(
 	}
 }
 
+static bool dce110_is_hpo_enabled(struct dc_state *context)
+{
+	int i;
+
+	for (i = 0; i < MAX_HPO_DP2_ENCODERS; i++) {
+		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[i]) {
+			return true;
+		}
+	}
+
+	return false;
+}
+
 enum dc_status dce110_apply_ctx_to_hw(
 		struct dc *dc,
 		struct dc_state *context)
@@ -2296,6 +2299,8 @@ enum dc_status dce110_apply_ctx_to_hw(
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	enum dc_status status;
 	int i;
+	bool was_hpo_enabled = dce110_is_hpo_enabled(dc->current_state);
+	bool is_hpo_enabled = dce110_is_hpo_enabled(context);
 
 	/* reset syncd pipes from disabled pipes */
 	if (dc->config.use_pipe_ctx_sync_logic)
@@ -2338,6 +2343,10 @@ enum dc_status dce110_apply_ctx_to_hw(
 
 	dce110_setup_audio_dto(dc, context);
 
+	if (dc->hwseq->funcs.setup_hpo_hw_control && was_hpo_enabled != is_hpo_enabled) {
+		dc->hwseq->funcs.setup_hpo_hw_control(dc->hwseq, is_hpo_enabled);
+	}
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx_old =
 					&dc->current_state->res_ctx.pipe_ctx[i];
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 8b3536c380b8..eae71f448143 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2892,11 +2892,6 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
-	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
-		if (dc->hwseq->funcs.setup_hpo_hw_control)
-			dc->hwseq->funcs.setup_hpo_hw_control(dc->hwseq, true);
-	}
-
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		dto_params.otg_inst = tg->inst;
 		dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
-- 
2.34.1

