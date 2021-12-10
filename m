Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DD9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B7510E397;
	Fri, 10 Dec 2021 23:05:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAC810E4BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bpp5x4TAzPXGqEP6k3hlyJUJLt73+bX03giu3BqHTj9nGaxKsvJuJlqEW3oLo6gydFwd76S1WpGhN5/ryfVCdIbfbrOtrQhd5/uBrYAk9p3DluRbFLl4doZb2b9bg9yONnonPZPceTUdYTYOnOGA0UxHYAwf7NHxiTF7DOwGBQutw/7ek6kEAB8bgkQ2lh994hxJ925wAO6dQ7Sw7d0qt97mHpnJfUgogUub0h/fpokb5mYXONwtDNau/fq6kgexur6M7XXoZxzWfDpTNQSIqOUTOmif4Hh5S7LqrASMXk+mrPu9bA5hPl97Se3gC4/vY6J6m574+HhQ0hiJ8wv2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkCn5J+1Bde/RXMH9OTv9CjBW8BFw4CoHhIDbE9w+SU=;
 b=hRUxpRbxdeEYuOntIoPXTD4+ApEt2dLu67ylZOCVnj3dLxANQqd91BgshZeCUXTp4/Ra6knwJO3Y5G5VBeHw5zSbRvZHpj045hlZ1EKIGuHsj7kmfsP66X2kXUYNkzzcbPto2UyMZh0QhhBnJa+VJwKw5R5MecBV6B4Fb2XkEOXo5rjDanHSuS8nvGz7aNMD0L4mHg7MRmp+72jgpFiH+qOPV+EYDQ9BK42tKmmSYPq8K+UIdzFA5Sp9agzPYbABxt4HoaKZAO+bZxfSiksMI67wSfdpIViD+uK3jIIgdSSrquEV0E3mFMs7s8VT6roLvmNWKCop/gOu3vHA97LhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkCn5J+1Bde/RXMH9OTv9CjBW8BFw4CoHhIDbE9w+SU=;
 b=FPi821RUhWyH9VEKJVuG9hraZdsQaufDkI5w9Ds9M6iSIKKjdB52NSw9UnGg37ORnNHf42+klkEjNgxj7XH+4k7tLpZYteGHlKM5zA6bkVOybwKDUO4XztQhO6qK8dnVZV8birxkSmNZkn2Ao2AMXmxq25i/tKMPKTDp3oa1IEA=
Received: from DM6PR07CA0068.namprd07.prod.outlook.com (2603:10b6:5:74::45) by
 MWHPR12MB1279.namprd12.prod.outlook.com (2603:10b6:300:d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.24; Fri, 10 Dec 2021 23:05:24 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::76) by DM6PR07CA0068.outlook.office365.com
 (2603:10b6:5:74::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 23:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 23:05:24 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 17:05:22 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/10] drm/amd/display: ODM + MPO window on only one half of
 ODM
Date: Fri, 10 Dec 2021 15:04:06 -0800
Message-ID: <20211210230408.619373-9-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
References: <20211210230408.619373-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8983996e-f9e1-4a45-81c6-08d9bc318c2e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1279:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1279AAC5D4CBB31E9F7C5064FC719@MWHPR12MB1279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHhRWklhcNsMlNEro8Y6mgO+BObFUyiQgc6Zz0bSnw3F1U1Aw/NtK/gsS296qSalVr+EXihxdSn1amyJ/lYhip5Oxbs/toNfd6qWf/SIJkeSCoWwh45dfZKa9U30a4LJ+gSh3ZiFdhX0dqnDLzVtMAy9IjgD7euhwqrqVWbcrOTToFiVaNR8Rt7nfqpUpu4orb4xGm/D3OjPFeuPfsL15YTfn+Q+moTQxdypulCSep0186S1BzJOk0/50cJhkpKeRTOrp4Bl4f28kO/Z/Ec53HhaaX4DuZHkHhXp4UPLnVyOq3/QYQgsvE7ULSAOEr7GjEg9s3PdHd4Es7ebFt+fewpQl4PWmfqejxRjmlyYQrT9HRDP1fb8a20VR6QpE/0iI72byn309TdEvhugpPufoybwScaclw32gN+QvPydwZIY1PXNAdsyPLIvDbwKz2WVTLhfcLiY1S+8rejv/UPtfWo0wpJuvefxXQTYJkJSczVSj6CSuYBrEze2uNB9NLzF66GjTQEO0CmVufLYzo/HUztbd824SjxgJ5ih7bzW0gic55pktLYPivF0ACAtBzGh7w+o2V2JJkHFQ6+PUViSzel8aMZG+OExuKOQRjij/Ohr0x8wIwmRZYGc2j24fQUjapNBin30zLpDM56vU+lb9uQRxOs4hsBZ9NuZqcFv75o17CSqM5NHxQO3Eu+qFZeBGrlrOhxRi5npWRimH5TWLyUYifL8aRHKDTTNNoxtzaHAYG7YKZyScor+an8GEnjsQXIKloTDyBzMQoZW50FCM6Xqg00IfhVDmfPDicEGvmI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(8676002)(336012)(54906003)(6916009)(47076005)(70206006)(70586007)(81166007)(316002)(356005)(6666004)(83380400001)(2906002)(1076003)(8936002)(26005)(4326008)(82310400004)(40460700001)(36860700001)(426003)(5660300002)(2616005)(7696005)(186003)(16526019)(86362001)(508600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 23:05:24.0132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8983996e-f9e1-4a45-81c6-08d9bc318c2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1279
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
Cc: stylon.wang@amd.com, Dmytro
 Laktyushkin <Dmytro.Laktyushkin@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Eric Bernstein <eric.bernstein@amd.com>,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
For ODM + MPO window on one half of ODM, only 3 pipes should
be allocated and scaling parameters adjusted to handle this case

[How]
Fix pipe allocation when MPO viewport is only on one side of ODM
split, and modify scaling paramters.
Added diags test cases for ODM + windows MPO, where MPO window is
on right half, left half, and both halves or ODM.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 81 ++++++++++++++-----
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 11 +++
 2 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 0da692c9a543..8b6b035bfa9c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -734,6 +734,10 @@ static void calculate_split_count_and_index(struct pipe_ctx *pipe_ctx, int *spli
 			(*split_idx)++;
 			split_pipe = split_pipe->top_pipe;
 		}
+
+		/* MPO window on right side of ODM split */
+		if (split_pipe && split_pipe->prev_odm_pipe && !pipe_ctx->prev_odm_pipe)
+			(*split_idx)++;
 	} else {
 		/*Get odm split index*/
 		struct pipe_ctx *split_pipe = pipe_ctx->prev_odm_pipe;
@@ -780,7 +784,11 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 	/*
 	 * Only the leftmost ODM pipe should be offset by a nonzero distance
 	 */
-	if (!pipe_ctx->prev_odm_pipe || split_idx == split_count) {
+	if (pipe_ctx->top_pipe && pipe_ctx->top_pipe->prev_odm_pipe && !pipe_ctx->prev_odm_pipe) {
+		/* MPO window on right side of ODM split */
+		data->recout.x = stream->dst.x + (surf_clip.x - stream->dst.width/2) *
+				stream->dst.width / stream->src.width;
+	} else if (!pipe_ctx->prev_odm_pipe || split_idx == split_count) {
 		data->recout.x = stream->dst.x;
 		if (stream->src.x < surf_clip.x)
 			data->recout.x += (surf_clip.x - stream->src.x) * stream->dst.width
@@ -978,6 +986,8 @@ static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 			* stream->dst.height / stream->src.height;
 	if (pipe_ctx->prev_odm_pipe && split_idx)
 		ro_lb = data->h_active * split_idx - recout_full_x;
+	else if (pipe_ctx->top_pipe && pipe_ctx->top_pipe->prev_odm_pipe)
+		ro_lb = data->h_active * split_idx - recout_full_x + data->recout.x;
 	else
 		ro_lb = data->recout.x - recout_full_x;
 	ro_tb = data->recout.y - recout_full_y;
@@ -1076,6 +1086,9 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 		timing->v_border_top + timing->v_border_bottom;
 	if (pipe_ctx->next_odm_pipe || pipe_ctx->prev_odm_pipe)
 		pipe_ctx->plane_res.scl_data.h_active /= get_num_odm_splits(pipe_ctx) + 1;
+	/* ODM + windows MPO, where window is on either right or left ODM half */
+	else if (pipe_ctx->top_pipe && (pipe_ctx->top_pipe->next_odm_pipe || pipe_ctx->top_pipe->prev_odm_pipe))
+		pipe_ctx->plane_res.scl_data.h_active /= get_num_odm_splits(pipe_ctx->top_pipe) + 1;
 
 	/* depends on h_active */
 	calculate_recout(pipe_ctx);
@@ -1084,11 +1097,6 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	/* depends on scaling ratios and recout, does not calculate offset yet */
 	calculate_viewport_size(pipe_ctx);
 
-	/* Stopgap for validation of ODM + MPO on one side of screen case */
-	if (pipe_ctx->plane_res.scl_data.viewport.height < 1 ||
-			pipe_ctx->plane_res.scl_data.viewport.width < 1)
-		return false;
-
 	/*
 	 * LB calculations depend on vp size, h/v_active and scaling ratios
 	 * Setting line buffer pixel depth to 24bpp yields banding
@@ -1437,23 +1445,54 @@ bool dc_add_plane_to_context(
 		if (head_pipe != free_pipe) {
 			tail_pipe = resource_get_tail_pipe(&context->res_ctx, head_pipe);
 			ASSERT(tail_pipe);
-			free_pipe->stream_res.tg = tail_pipe->stream_res.tg;
-			free_pipe->stream_res.abm = tail_pipe->stream_res.abm;
-			free_pipe->stream_res.opp = tail_pipe->stream_res.opp;
-			free_pipe->stream_res.stream_enc = tail_pipe->stream_res.stream_enc;
-			free_pipe->stream_res.audio = tail_pipe->stream_res.audio;
-			free_pipe->clock_source = tail_pipe->clock_source;
-			free_pipe->top_pipe = tail_pipe;
-			tail_pipe->bottom_pipe = free_pipe;
-			if (!free_pipe->next_odm_pipe && tail_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe) {
-				free_pipe->next_odm_pipe = tail_pipe->next_odm_pipe->bottom_pipe;
-				tail_pipe->next_odm_pipe->bottom_pipe->prev_odm_pipe = free_pipe;
-			}
-			if (!free_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe->bottom_pipe) {
-				free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
-				tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
+
+			/* ODM + window MPO, where MPO window is on right half only */
+			if (free_pipe->plane_state &&
+					(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.width/2) &&
+					tail_pipe->next_odm_pipe) {
+				free_pipe->stream_res.tg = tail_pipe->next_odm_pipe->stream_res.tg;
+				free_pipe->stream_res.abm = tail_pipe->next_odm_pipe->stream_res.abm;
+				free_pipe->stream_res.opp = tail_pipe->next_odm_pipe->stream_res.opp;
+				free_pipe->stream_res.stream_enc = tail_pipe->next_odm_pipe->stream_res.stream_enc;
+				free_pipe->stream_res.audio = tail_pipe->next_odm_pipe->stream_res.audio;
+				free_pipe->clock_source = tail_pipe->next_odm_pipe->clock_source;
+
+				free_pipe->top_pipe = tail_pipe->next_odm_pipe;
+				tail_pipe->next_odm_pipe->bottom_pipe = free_pipe;
+			} else {
+				free_pipe->stream_res.tg = tail_pipe->stream_res.tg;
+				free_pipe->stream_res.abm = tail_pipe->stream_res.abm;
+				free_pipe->stream_res.opp = tail_pipe->stream_res.opp;
+				free_pipe->stream_res.stream_enc = tail_pipe->stream_res.stream_enc;
+				free_pipe->stream_res.audio = tail_pipe->stream_res.audio;
+				free_pipe->clock_source = tail_pipe->clock_source;
+
+				free_pipe->top_pipe = tail_pipe;
+				tail_pipe->bottom_pipe = free_pipe;
+
+				if (!free_pipe->next_odm_pipe && tail_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe) {
+					free_pipe->next_odm_pipe = tail_pipe->next_odm_pipe->bottom_pipe;
+					tail_pipe->next_odm_pipe->bottom_pipe->prev_odm_pipe = free_pipe;
+				}
+				if (!free_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe->bottom_pipe) {
+					free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
+					tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
+				}
 			}
 		}
+
+		/* ODM + window MPO, where MPO window is on left half only */
+		if (free_pipe->plane_state &&
+				(free_pipe->plane_state->clip_rect.x + free_pipe->plane_state->clip_rect.width <=
+				free_pipe->stream->src.x + free_pipe->stream->src.width/2)) {
+			break;
+		}
+		/* ODM + window MPO, where MPO window is on right half only */
+		if (free_pipe->plane_state &&
+				(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.width/2)) {
+			break;
+		}
+
 		head_pipe = head_pipe->next_odm_pipe;
 	}
 	/* assign new surfaces*/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 48ca4ad0b720..9db92ac1d339 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1763,6 +1763,17 @@ static bool dcn30_split_stream_for_mpc_or_odm(
 	int pipe_idx = sec_pipe->pipe_idx;
 	const struct resource_pool *pool = dc->res_pool;
 
+	if (pri_pipe->plane_state) {
+		/* ODM + window MPO, where MPO window is on left half only */
+		if (pri_pipe->plane_state->clip_rect.x + pri_pipe->plane_state->clip_rect.width <=
+				pri_pipe->stream->src.x + pri_pipe->stream->src.width/2)
+			return true;
+
+		/* ODM + window MPO, where MPO window is on right half only */
+		if (pri_pipe->plane_state->clip_rect.x >= pri_pipe->stream->src.width/2)
+			return true;
+	}
+
 	*sec_pipe = *pri_pipe;
 
 	sec_pipe->pipe_idx = pipe_idx;
-- 
2.32.0

