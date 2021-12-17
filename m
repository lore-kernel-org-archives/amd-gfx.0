Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5D8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BA510E699;
	Fri, 17 Dec 2021 21:24:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAD710E699
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6uSnykW1PEQi8LLtXZOmkhLAyg3IFwM3dGYiGbQiC6VfWtvOhztDOe/cuOdINd7bsiWPRutzkn3yuNrs03BHadG3Ho9z71RsPW1uco4rGb6LJnNdV7KQWABCpmVCIRK3jP2DZCMLSTfsC0hCOeQR3RfeGCDti3Vn7HTO4sZ3GKthraGFGzAgV6N2clrXXOU8wL3ntG2d9sKK1JmQ9N2Q1ZOkelmGy/y8TaAJoIPsnhaqa/PxBT79gOlOfE1Z1ZCY7rpaBky4FEF674FqlMlTDEZ6Z9KEHQoQtRsDx2kIJUvEbNsagH2NvYzX+3JUvE7X04IUWIrssuCV2oldmQcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1elLLgui+gzzI+b0eLADU1Xeg5nhh0nKfuxN0DPd1Vk=;
 b=VjSQKAAbtJlbFSKx9mEHCTcnjrhh5mBYyk8JTwfHjtuJP2CbiKftnhIpcpX6Ptc4R2CSeFhnYL6WAPPKTd7vwr8EE2DXevhh28mTeIe9kV+FA9pl6LdVANaMaiyXP4IYCEeKiY8xMEUa9IfF2kL1yKoRqC5+7woYFvo36JGFQ5ZkxReqyGN30NjdiVOv+QvHm8WiGU/tBEPcC1tFMLMrJiTA+eruQW0huORBZHU0Sly/lH++/j9LyFMvScirHk80stFmLwPyJGYISjno2Zt7FLBjgBQvhtBEgeIMR8YnpgPhCWg62Nt9TsAHSHe4U4221uW471QQUu60+7Qkk3AlUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1elLLgui+gzzI+b0eLADU1Xeg5nhh0nKfuxN0DPd1Vk=;
 b=w9ZjHBZi5h/rIk6djOtmpw/bQ3t+yvai3YQH+Hz9BawP/TQm3bmKh/h4pVb+yHvAISltBqLEjjd33S+yK/I6P+OqXGOIpCg2MyIfhAiFK4apYHmk+xy3RKvaQJ8T9+Wdtg6izHaTf3skJQ+6PrgojA+XjrJT/G3gLnZ5WE9lJ5g=
Received: from MW4PR04CA0246.namprd04.prod.outlook.com (2603:10b6:303:88::11)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 21:24:37 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::2f) by MW4PR04CA0246.outlook.office365.com
 (2603:10b6:303:88::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:37 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:35 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/19] drm/amd/display: Undo ODM combine
Date: Fri, 17 Dec 2021 16:24:00 -0500
Message-ID: <20211217212407.3583190-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b98e92d-4ac3-4f84-aa97-08d9c1a3a0e2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4270:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4270BA54A4E44F37C754AE6498789@MN2PR12MB4270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCDZPMrzFB8U6bDOZ/Y0pbvy6dNejfRtd33UgYpqI8sZebKVDvCnQsG55O2Nc5m8UqGq8S1cptxkHVYS8z4uaRoDIkdrgZLEnCmhw5qJO34N+no3nCT1SlkqeD3hF2EkfhR0ZBGZUGGCVn06Tv9UKghJ1js29dTiESPgUaOKWS4Xy8b3PcDUNoCrtPzObeB7AdTrQLKZ6GdlStJE9SNUfWepZEYknc1RAjVGJ3fSNJE2SJsfzrYKS9kuPI7RzPWsVgrUujLmvr9mMooi5/ozGnWGoQsqswgjrkzO8RVViSsiUyryTPP58aALC3QNDOH0p4nDl22A5Sq2burb9h7ZGBHm7bNx7D3VD0HzEgQg/iVt0H7pF5ozxmLdHWO9jo90k93tOMDsZ0Uwgi2kLw3EQf5j9G44p0CloNwEkeii8E3fwpfCo66iRAok4vJyrKsgYQAVVYAWTyCrSdc7D6pPJOlWA9JEKg00dleOxbIpQT/FzU4tyhL19u7MU6qSiTo8oEB3JJrNhK8m2exXd+E3vsOz/2m4e7847vs3cStHwDfqRLeMSAzw0xJ9y0RX1WvpDAnOb/KYgMz+yPscv66+A/BkQgWiWuKqxP3jZDl0KSak6BTDG5DI/5xe6uUBd0P0U9cjxBOCZNslxx1gsdlsrX6AD8x4rUO5bC/GhdSYRviJzRMhukVxR953YaSz31cXTM/ViBY1tZ8djDqniZa4U0b/e5yno6I0K94xqz8jkqcY8Km7PEOfQg3R2EeP05vz8A3U1Lv54C+hxt4RL2mZ2a5yW9FwCyhN0nhVPg+l6Ac=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(2616005)(47076005)(36756003)(426003)(508600001)(70206006)(86362001)(70586007)(8936002)(54906003)(336012)(316002)(16526019)(8676002)(26005)(186003)(2906002)(81166007)(36860700001)(6666004)(356005)(1076003)(82310400004)(40460700001)(83380400001)(4326008)(6916009)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:37.1113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b98e92d-4ac3-4f84-aa97-08d9c1a3a0e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

Undo ODM Combine regression causing causing pipe allocation issues.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 81 +++++--------------
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 11 ---
 2 files changed, 21 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 8b6b035bfa9c..0da692c9a543 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -734,10 +734,6 @@ static void calculate_split_count_and_index(struct pipe_ctx *pipe_ctx, int *spli
 			(*split_idx)++;
 			split_pipe = split_pipe->top_pipe;
 		}
-
-		/* MPO window on right side of ODM split */
-		if (split_pipe && split_pipe->prev_odm_pipe && !pipe_ctx->prev_odm_pipe)
-			(*split_idx)++;
 	} else {
 		/*Get odm split index*/
 		struct pipe_ctx *split_pipe = pipe_ctx->prev_odm_pipe;
@@ -784,11 +780,7 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 	/*
 	 * Only the leftmost ODM pipe should be offset by a nonzero distance
 	 */
-	if (pipe_ctx->top_pipe && pipe_ctx->top_pipe->prev_odm_pipe && !pipe_ctx->prev_odm_pipe) {
-		/* MPO window on right side of ODM split */
-		data->recout.x = stream->dst.x + (surf_clip.x - stream->dst.width/2) *
-				stream->dst.width / stream->src.width;
-	} else if (!pipe_ctx->prev_odm_pipe || split_idx == split_count) {
+	if (!pipe_ctx->prev_odm_pipe || split_idx == split_count) {
 		data->recout.x = stream->dst.x;
 		if (stream->src.x < surf_clip.x)
 			data->recout.x += (surf_clip.x - stream->src.x) * stream->dst.width
@@ -986,8 +978,6 @@ static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 			* stream->dst.height / stream->src.height;
 	if (pipe_ctx->prev_odm_pipe && split_idx)
 		ro_lb = data->h_active * split_idx - recout_full_x;
-	else if (pipe_ctx->top_pipe && pipe_ctx->top_pipe->prev_odm_pipe)
-		ro_lb = data->h_active * split_idx - recout_full_x + data->recout.x;
 	else
 		ro_lb = data->recout.x - recout_full_x;
 	ro_tb = data->recout.y - recout_full_y;
@@ -1086,9 +1076,6 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 		timing->v_border_top + timing->v_border_bottom;
 	if (pipe_ctx->next_odm_pipe || pipe_ctx->prev_odm_pipe)
 		pipe_ctx->plane_res.scl_data.h_active /= get_num_odm_splits(pipe_ctx) + 1;
-	/* ODM + windows MPO, where window is on either right or left ODM half */
-	else if (pipe_ctx->top_pipe && (pipe_ctx->top_pipe->next_odm_pipe || pipe_ctx->top_pipe->prev_odm_pipe))
-		pipe_ctx->plane_res.scl_data.h_active /= get_num_odm_splits(pipe_ctx->top_pipe) + 1;
 
 	/* depends on h_active */
 	calculate_recout(pipe_ctx);
@@ -1097,6 +1084,11 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	/* depends on scaling ratios and recout, does not calculate offset yet */
 	calculate_viewport_size(pipe_ctx);
 
+	/* Stopgap for validation of ODM + MPO on one side of screen case */
+	if (pipe_ctx->plane_res.scl_data.viewport.height < 1 ||
+			pipe_ctx->plane_res.scl_data.viewport.width < 1)
+		return false;
+
 	/*
 	 * LB calculations depend on vp size, h/v_active and scaling ratios
 	 * Setting line buffer pixel depth to 24bpp yields banding
@@ -1445,54 +1437,23 @@ bool dc_add_plane_to_context(
 		if (head_pipe != free_pipe) {
 			tail_pipe = resource_get_tail_pipe(&context->res_ctx, head_pipe);
 			ASSERT(tail_pipe);
-
-			/* ODM + window MPO, where MPO window is on right half only */
-			if (free_pipe->plane_state &&
-					(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.width/2) &&
-					tail_pipe->next_odm_pipe) {
-				free_pipe->stream_res.tg = tail_pipe->next_odm_pipe->stream_res.tg;
-				free_pipe->stream_res.abm = tail_pipe->next_odm_pipe->stream_res.abm;
-				free_pipe->stream_res.opp = tail_pipe->next_odm_pipe->stream_res.opp;
-				free_pipe->stream_res.stream_enc = tail_pipe->next_odm_pipe->stream_res.stream_enc;
-				free_pipe->stream_res.audio = tail_pipe->next_odm_pipe->stream_res.audio;
-				free_pipe->clock_source = tail_pipe->next_odm_pipe->clock_source;
-
-				free_pipe->top_pipe = tail_pipe->next_odm_pipe;
-				tail_pipe->next_odm_pipe->bottom_pipe = free_pipe;
-			} else {
-				free_pipe->stream_res.tg = tail_pipe->stream_res.tg;
-				free_pipe->stream_res.abm = tail_pipe->stream_res.abm;
-				free_pipe->stream_res.opp = tail_pipe->stream_res.opp;
-				free_pipe->stream_res.stream_enc = tail_pipe->stream_res.stream_enc;
-				free_pipe->stream_res.audio = tail_pipe->stream_res.audio;
-				free_pipe->clock_source = tail_pipe->clock_source;
-
-				free_pipe->top_pipe = tail_pipe;
-				tail_pipe->bottom_pipe = free_pipe;
-
-				if (!free_pipe->next_odm_pipe && tail_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe) {
-					free_pipe->next_odm_pipe = tail_pipe->next_odm_pipe->bottom_pipe;
-					tail_pipe->next_odm_pipe->bottom_pipe->prev_odm_pipe = free_pipe;
-				}
-				if (!free_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe->bottom_pipe) {
-					free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
-					tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
-				}
+			free_pipe->stream_res.tg = tail_pipe->stream_res.tg;
+			free_pipe->stream_res.abm = tail_pipe->stream_res.abm;
+			free_pipe->stream_res.opp = tail_pipe->stream_res.opp;
+			free_pipe->stream_res.stream_enc = tail_pipe->stream_res.stream_enc;
+			free_pipe->stream_res.audio = tail_pipe->stream_res.audio;
+			free_pipe->clock_source = tail_pipe->clock_source;
+			free_pipe->top_pipe = tail_pipe;
+			tail_pipe->bottom_pipe = free_pipe;
+			if (!free_pipe->next_odm_pipe && tail_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe) {
+				free_pipe->next_odm_pipe = tail_pipe->next_odm_pipe->bottom_pipe;
+				tail_pipe->next_odm_pipe->bottom_pipe->prev_odm_pipe = free_pipe;
+			}
+			if (!free_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe->bottom_pipe) {
+				free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
+				tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
 			}
 		}
-
-		/* ODM + window MPO, where MPO window is on left half only */
-		if (free_pipe->plane_state &&
-				(free_pipe->plane_state->clip_rect.x + free_pipe->plane_state->clip_rect.width <=
-				free_pipe->stream->src.x + free_pipe->stream->src.width/2)) {
-			break;
-		}
-		/* ODM + window MPO, where MPO window is on right half only */
-		if (free_pipe->plane_state &&
-				(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.width/2)) {
-			break;
-		}
-
 		head_pipe = head_pipe->next_odm_pipe;
 	}
 	/* assign new surfaces*/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index e12660c609ee..602ec9a08549 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1761,17 +1761,6 @@ static bool dcn30_split_stream_for_mpc_or_odm(
 	int pipe_idx = sec_pipe->pipe_idx;
 	const struct resource_pool *pool = dc->res_pool;
 
-	if (pri_pipe->plane_state) {
-		/* ODM + window MPO, where MPO window is on left half only */
-		if (pri_pipe->plane_state->clip_rect.x + pri_pipe->plane_state->clip_rect.width <=
-				pri_pipe->stream->src.x + pri_pipe->stream->src.width/2)
-			return true;
-
-		/* ODM + window MPO, where MPO window is on right half only */
-		if (pri_pipe->plane_state->clip_rect.x >= pri_pipe->stream->src.width/2)
-			return true;
-	}
-
 	*sec_pipe = *pri_pipe;
 
 	sec_pipe->pipe_idx = pipe_idx;
-- 
2.25.1

