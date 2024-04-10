Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A16CD11C2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A524E10EA5B;
	Wed, 10 Apr 2024 21:28:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qux6FV2D";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5732410EA44
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDF0W29Eol5gtsq/JFmpcsRMIequmj9dQdKbVFhdFhkgUk4YVsOqJtl3jcpvE/ZYLfQpA6BgUQVM8Vx4yUZeAh9+2aaA8lXFFgy1ftjIRx1WeZJOJK9vEVpG5JJxluAZe3NDmEapDMkQmdYEG37ERQBoS5KY6/gjjYv1IQNp1ObyKF4dDtwlPcN3e8+6tlBiIsqPTeicXFthhd86Fz0iDwvzP21g0NAyoMBB3NYIGqXRQxjZKPAVDlO0WW2jAVMn6RGX7xCYStEuRMHdBcOT2srHphI0o90segGNP2lmFGykNvlrBSPrc6N9aJhY7MImrZ5gLVGGePSrou2FgOWASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+1dhmodlqZkdQWhsUoyi7bd+EP7YOT5g0H7lm0xE2I=;
 b=TstsnD6IgYvNmb3sjpJ/pUP+8RjJMpctSyk5A+BCqb9UfEOjRWlMhpKg9vfVUKZxG0+QvA8YP5oAczbcZKakpm52/oZuo+xBtrEpSxLncbl58jAFlPJSSUdhY5ndmnN6YkyqDo1hExg8BqZxPk1xmHJOn+3z+azDykAPQj++MKwJt5itZzWgAodqrrd1tOkBcITIkySHFUKq08DNpO5cnsH5I3o2DzTsY6S/Id5LGJSue6LdUGU23zpYEcMWbSZIKjSpBJqjnw3Xcurvh9NAKyGFgG4fuh3RTr5KUshXuomiHfs+klvBrT5Buisfmt6kTnyGJQudjnu5yLejXJ3zwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+1dhmodlqZkdQWhsUoyi7bd+EP7YOT5g0H7lm0xE2I=;
 b=qux6FV2DoZMQhDHxVhIwTxeUWQEX3Ki0PU+YXIwGCxFK+BC9ya2e6LDpe+aVjH+75Dhoi3uezvY2KRh2+1KBM4M7zDurVhsRQim4BoHi3dOkf7Cc0KrYTajUzlrhF2hLfrd9tyGIWSC4XOOcf9glV+7Rrf7eCOKwJdGEJbtSIWQ=
Received: from BN0PR04CA0141.namprd04.prod.outlook.com (2603:10b6:408:ed::26)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Wed, 10 Apr
 2024 21:27:56 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::97) by BN0PR04CA0141.outlook.office365.com
 (2603:10b6:408:ed::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:27:56 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:27:54 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung Joon Kim
 <sungjoon.kim@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 03/25] drm/amd/display: Modify resource allocation logic
Date: Wed, 10 Apr 2024 15:25:52 -0600
Message-ID: <20240410212726.1312989-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: c538e624-9001-45f7-7627-08dc59a516d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2alMgiqv2QslCYIu1tsJFk6JTGyz4/Ux9qmZPwxdX/mb/ZT4eJcyPBlEIINdG9b3g7q27jABMfPjaO5g1DKZPy8GXJxQgCUrxDW/fRKkVwWk9Loug7W6/etFTHfkfCkmI0cbMbbqmTvuAjo4XVWdeOafZI5JSAlWkAO0WBbzbwUfpPe0h3PU/kIwV2zMzFub1hv9GTxnurtRtd4kar+6d0ZB5WF0hO7FTO+MYUQCmh5mWQbzUONE0LeDrvdE4yRyLfsO4wFz73ROAo1hBYwrd/TNqyTP3mrvlshB+OiJ2dF9+SUrwdzcJmGg5iTif3uKJ+raEjv3xYpb/wMZXuONuBssoGC0uvfhHheVoQy8Txecs/uJrOdWb597B+rBjw42cs/UwoJ/mJIBe31tHbbtfHw02gF3Dxe5RSfs8gQdJgewDG8AQ4K3IOMWiUiz5SVua1HjcYVl+0X46r/eQsE1ud3Dr1U4M+fTji3Z7/VVEignBqs8I+7Nq1mcOnPZI7TrC2pAq1z8M7YHIVzBULCu+V3raoAqLD27DgsQ1ZEUCp6dyCzoG0Qu8rP/QP5Qo3X/GNoGw5cyT7LywhPCJP/TL7ggJFFJU0f7G8UChuiZ2YE8ucq32MAbFBENhtBIaqNaWJbPpRBEf7EulbAbMAJERLdxQrNRZduVTSm4lnM50h9so9XrsfPJWm93Pq2xOE38y2/7+PHkSVdVbaZOOatu+ddrF4fIASScvKpgRg6unj0DihUAzvtAgPxR1JRbbA9T
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:27:56.6616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c538e624-9001-45f7-7627-08dc59a516d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

To reduce the complexity of pipe resource allocation for different
use-cases, now we search for any free pipe sequentially rather than from
bottom up.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 .../dc/resource/dcn32/dcn32_resource.c        |  4 +--
 .../dc/resource/dcn32/dcn32_resource.h        |  6 ++++
 .../dc/resource/dcn351/dcn351_resource.c      | 35 ++++++++++++++++++-
 .../dc/resource/dcn351/dcn351_resource.h      |  6 ++++
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 9aa39bd25be9..c16e915686fc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2547,7 +2547,7 @@ struct resource_pool *dcn32_create_resource_pool(
  * full update which delays the flip for 1 frame. If we use the original pipe
  * we don't have to toggle its power. So we can flip faster.
  */
-static int find_optimal_free_pipe_as_secondary_dpp_pipe(
+int dcn32_find_optimal_free_pipe_as_secondary_dpp_pipe(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
 		const struct resource_pool *pool,
@@ -2730,7 +2730,7 @@ struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_dpp_pipe(
 		return dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
 				new_ctx, pool, opp_head_pipe->stream, opp_head_pipe);
 
-	free_pipe_idx = find_optimal_free_pipe_as_secondary_dpp_pipe(
+	free_pipe_idx = dcn32_find_optimal_free_pipe_as_secondary_dpp_pipe(
 					&cur_ctx->res_ctx, &new_ctx->res_ctx,
 					pool, opp_head_pipe);
 	if (free_pipe_idx >= 0) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 286e20ad46ed..fee67fbab8e2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -137,6 +137,12 @@ bool dcn32_any_surfaces_rotated(struct dc *dc, struct dc_state *context);
 bool dcn32_is_center_timing(struct pipe_ctx *pipe);
 bool dcn32_is_psr_capable(struct pipe_ctx *pipe);
 
+int dcn32_find_optimal_free_pipe_as_secondary_dpp_pipe(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *new_opp_head);
+
 struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_dpp_pipe(
 		const struct dc_state *cur_ctx,
 		struct dc_state *new_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 8a57adb27264..cc1a44a890b5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1728,6 +1728,37 @@ static bool dcn351_validate_bandwidth(struct dc *dc,
 	return out;
 }
 
+struct pipe_ctx *dcn351_acquire_free_pipe_as_secondary_dpp_pipe(
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *opp_head_pipe)
+{
+	int free_pipe_idx;
+	struct pipe_ctx *free_pipe;
+
+	free_pipe_idx = dcn32_find_optimal_free_pipe_as_secondary_dpp_pipe(
+					&cur_ctx->res_ctx, &new_ctx->res_ctx,
+					pool, opp_head_pipe);
+	if (free_pipe_idx >= 0) {
+		free_pipe = &new_ctx->res_ctx.pipe_ctx[free_pipe_idx];
+		free_pipe->pipe_idx = free_pipe_idx;
+		free_pipe->stream = opp_head_pipe->stream;
+		free_pipe->stream_res.tg = opp_head_pipe->stream_res.tg;
+		free_pipe->stream_res.opp = opp_head_pipe->stream_res.opp;
+
+		free_pipe->plane_res.hubp = pool->hubps[free_pipe->pipe_idx];
+		free_pipe->plane_res.ipp = pool->ipps[free_pipe->pipe_idx];
+		free_pipe->plane_res.dpp = pool->dpps[free_pipe->pipe_idx];
+		free_pipe->plane_res.mpcc_inst =
+				pool->dpps[free_pipe->pipe_idx]->inst;
+	} else {
+		ASSERT(opp_head_pipe);
+		free_pipe = NULL;
+	}
+
+	return free_pipe;
+}
 
 static struct resource_funcs dcn351_res_pool_funcs = {
 	.destroy = dcn351_destroy_resource_pool,
@@ -1740,7 +1771,8 @@ static struct resource_funcs dcn351_res_pool_funcs = {
 	.calculate_wm_and_dlg = NULL,
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn351_populate_dml_pipes_from_context_fpu,
-	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn351_acquire_free_pipe_as_secondary_dpp_pipe,
+	.acquire_free_pipe_as_secondary_opp_head = dcn32_acquire_free_pipe_as_secondary_opp_head,
 	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
@@ -2130,6 +2162,7 @@ static bool dcn351_resource_construct(
 
 	dc->dml2_options.max_segments_per_hubp = 24;
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
+	dc->dml2_options.map_dc_pipes_with_callbacks = true;
 
 	if (dc->config.sdpif_request_limit_words_per_umc == 0)
 		dc->config.sdpif_request_limit_words_per_umc = 16;/*todo*/
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.h
index f3e045777a3d..e4553c5100f8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.h
@@ -20,4 +20,10 @@ struct resource_pool *dcn351_create_resource_pool(
 		const struct dc_init_data *init_data,
 		struct dc *dc);
 
+struct pipe_ctx *dcn351_acquire_free_pipe_as_secondary_dpp_pipe(
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *opp_head_pipe);
+
 #endif /* _DCN351_RESOURCE_H_ */
-- 
2.43.0

