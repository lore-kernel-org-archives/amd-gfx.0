Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30129CD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6B2112184;
	Thu, 28 Mar 2024 19:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4u4x43Ju";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3900D10F60E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvSQHgCPT/xNSAi8RwzDwc+6JnpMIEBeXWbrE5YWwh9IFUqBPuWBYTYvyG87lTjm0aLLj0384/gwT48+JJudGXC+lR4KV2W3cLlmyZF3wO12QFCXit0qOTn97VitXZ9edz2ZFcXEOK5tt5LMFuK13TjzyGh8aAnyAHzef/61kkHVjrG5V1kJYlXwvt6074Yt7CIi8ywuEJa1JwUV/Mvi07Du4Bk75b3A5D5AN76/wRZrXeydLAahjTOQSsrEl0p5dQKJnEFfmu48uGyh0nwIqxE9VmMsD961Zpa6yuH9K1GEQI5CMUlHt5WMude44xXSuUqfmTYDiTsZaKabk6mjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQbysL9tNCnJDaqohS3X0PUZRtGNBmul3eTy7bshFQc=;
 b=kTYX8FVkNGlNTZ8P6lV9G+IsCRXlAlKbWnaUFTfoDUGCon6+OU8zqjSLyYFuvfQD8wEgHuMaERV9LwmqDld4lwQ2ERp2SvKj0zLcUUCFIthij78TIEeWlKIPOVlNncOABbqxqbe6Us/UpJPuC0y0Pg1CXuR0Y/NidQnIBYE7BkAO27sKS2yS9vXiO1BkPqXggqulaAwq2YucCGxdQR2Ue53EF9uPcoImCHti87ilKbJSRZ5fCQ98r99rOQkaqg0ishRQV2ZDNEh/jYUhjfy90/BmIk015g538FK+DgdsGiqIU8lSXxx0gsP1O+k26bs4NWTjpwZIwGIWEQuQmxdT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQbysL9tNCnJDaqohS3X0PUZRtGNBmul3eTy7bshFQc=;
 b=4u4x43JuRzrnS3nHAX2eNQBoPQiX3ZlScuqKMGFPIAKmP8qR7x49BksnJW+vIE8rT86ks3ZNWD/A2fsAyuXb1ixtAGwzJoA9bjBZCQ6+YQS6ecXret+L89cApKhyJtuxy4zC+CZkJ0oS73XCxwLSzPDZnOiqtV/nohATC/97bUQ=
Received: from CH2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:610:54::19)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 19:51:39 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::d) by CH2PR11CA0009.outlook.office365.com
 (2603:10b6:610:54::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:37 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:36 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 11/43] drm/amd/display: update pipe topology log to support
 subvp
Date: Thu, 28 Mar 2024 15:50:15 -0400
Message-ID: <20240328195047.2843715-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e2c44a-3491-4175-35e1-08dc4f607b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7fRtBNO+qXkUvedlpECqo+3bKR2et1ihtTp8E/7ZkGBBLroVWOpKgCh91gCBu+zDVUO31MiSB9BQ5+2JTGNF/m2u7fWfd1kBc2yJqYl6NI8UHHINmSnExbgvZphxCFhzwIllQ0uTuiLJQdCazBHE25qVsCdu+sa+f1TQTG4RLSadFNLtCm/2aUMZTJCH5m/o8A//qIlD/KJf76u419G32NQXD56YvAU0IJ5vdeP4n/PCNYd70f+T+00Sf2TbrQAy3gy2wPUnvo0fpE+1wmSxk8nWSBfhJpx0vYMW9+47d9GKfhmFcLWUPGFiTkphg1rkDSXaOGhmk5WkHCozBCEFFMq9izqBvNowEpdGHaENshFGgv+bYi3nR2VbN/yhbm8zZWfwXknkS/QmInF4v3PY7UN0ebyKPl/zogqO+D5O+lgicGoMgDbPvWdzIyoUfq1E1ZmFwNj1Q5kQZ/FbSIDN6layHolBQ+K9kRpddaDei60vqhbm2XPm2rmHKmNuTiWk1i48EsGYWG89fYPWmKCLkbzOJB13QGsP0ELrvHYH6Hj3Y1kEmcn5ooyG02ABZ5eX6Isldjzpeb2hdQXgWEYJUzJMt1PmF0bSxaO+y4X/0hs/njgGEm86j815Xlu7rQphukC6Lo8BvLSmpMer6RjYevAhEk7J2g7EhPFqWlo++h7kK1jIzcLLvYt+7oyPVPoVa3zSDF6yO2sVs5cc9OdcATZZCeWBIHfiGjKBRVOi69ffb8yMWjv11kMa71//Ac8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:38.5241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e2c44a-3491-4175-35e1-08dc4f607b7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There is an ambiguity in subvp pipe topology log. The log doesn't show
subvp relation to main stream and it is not clear that certain stream
is an internal stream for subvp pipes.

[how]
Separate subvp pipe topology logging from main pipe topology. Log main
stream indices instead of the internal stream for subvp pipes.
The following is a sample log showing 2 streams with subvp enabled on
both:

   pipe topology update
 ________________________
| plane0  slice0  stream0|
|DPP1----OPP1----OTG1----|
| plane0  slice0  stream1|
|DPP0----OPP0----OTG0----|
|    (phantom pipes)     |
| plane0  slice0  stream0|
|DPP3----OPP3----OTG3----|
| plane0  slice0  stream1|
|DPP2----OPP2----OTG2----|
|________________________|

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 96 +++++++++++++------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 601af21b2df9..c4a3484554b0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2193,50 +2193,84 @@ static void resource_log_pipe(struct dc *dc, struct pipe_ctx *pipe,
 	}
 }
 
-void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
+static void resource_log_pipe_for_stream(struct dc *dc, struct dc_state *state,
+		struct pipe_ctx *otg_master, int stream_idx)
 {
-	struct pipe_ctx *otg_master;
 	struct pipe_ctx *opp_heads[MAX_PIPES];
 	struct pipe_ctx *dpp_pipes[MAX_PIPES];
 
-	int stream_idx, slice_idx, dpp_idx, plane_idx, slice_count, dpp_count;
+	int slice_idx, dpp_idx, plane_idx, slice_count, dpp_count;
 	bool is_primary;
 	DC_LOGGER_INIT(dc->ctx->logger);
 
+	slice_count = resource_get_opp_heads_for_otg_master(otg_master,
+			&state->res_ctx, opp_heads);
+	for (slice_idx = 0; slice_idx < slice_count; slice_idx++) {
+		plane_idx = -1;
+		if (opp_heads[slice_idx]->plane_state) {
+			dpp_count = resource_get_dpp_pipes_for_opp_head(
+					opp_heads[slice_idx],
+					&state->res_ctx,
+					dpp_pipes);
+			for (dpp_idx = 0; dpp_idx < dpp_count; dpp_idx++) {
+				is_primary = !dpp_pipes[dpp_idx]->top_pipe ||
+						dpp_pipes[dpp_idx]->top_pipe->plane_state != dpp_pipes[dpp_idx]->plane_state;
+				if (is_primary)
+					plane_idx++;
+				resource_log_pipe(dc, dpp_pipes[dpp_idx],
+						stream_idx, slice_idx,
+						plane_idx, slice_count,
+						is_primary);
+			}
+		} else {
+			resource_log_pipe(dc, opp_heads[slice_idx],
+					stream_idx, slice_idx, plane_idx,
+					slice_count, true);
+		}
+
+	}
+}
+
+static int resource_stream_to_stream_idx(struct dc_state *state,
+		struct dc_stream_state *stream)
+{
+	int i, stream_idx = -1;
+
+	for (i = 0; i < state->stream_count; i++)
+		if (state->streams[i] == stream) {
+			stream_idx = i;
+			break;
+		}
+	return stream_idx;
+}
+
+void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
+{
+	struct pipe_ctx *otg_master;
+	int stream_idx, phantom_stream_idx;
+	DC_LOGGER_INIT(dc->ctx->logger);
+
 	DC_LOG_DC("    pipe topology update");
 	DC_LOG_DC("  ________________________");
 	for (stream_idx = 0; stream_idx < state->stream_count; stream_idx++) {
+		if (state->streams[stream_idx]->is_phantom)
+			continue;
+
 		otg_master = resource_get_otg_master_for_stream(
 				&state->res_ctx, state->streams[stream_idx]);
-		if (!otg_master	|| otg_master->stream_res.tg == NULL) {
-			DC_LOG_DC("topology update: otg_master NULL stream_idx %d!\n", stream_idx);
-			return;
-		}
-		slice_count = resource_get_opp_heads_for_otg_master(otg_master,
-				&state->res_ctx, opp_heads);
-		for (slice_idx = 0; slice_idx < slice_count; slice_idx++) {
-			plane_idx = -1;
-			if (opp_heads[slice_idx]->plane_state) {
-				dpp_count = resource_get_dpp_pipes_for_opp_head(
-						opp_heads[slice_idx],
-						&state->res_ctx,
-						dpp_pipes);
-				for (dpp_idx = 0; dpp_idx < dpp_count; dpp_idx++) {
-					is_primary = !dpp_pipes[dpp_idx]->top_pipe ||
-							dpp_pipes[dpp_idx]->top_pipe->plane_state != dpp_pipes[dpp_idx]->plane_state;
-					if (is_primary)
-						plane_idx++;
-					resource_log_pipe(dc, dpp_pipes[dpp_idx],
-							stream_idx, slice_idx,
-							plane_idx, slice_count,
-							is_primary);
-				}
-			} else {
-				resource_log_pipe(dc, opp_heads[slice_idx],
-						stream_idx, slice_idx, plane_idx,
-						slice_count, true);
-			}
+		resource_log_pipe_for_stream(dc, state, otg_master, stream_idx);
+	}
+	if (state->phantom_stream_count > 0) {
+		DC_LOG_DC(" |    (phantom pipes)     |");
+		for (stream_idx = 0; stream_idx < state->stream_count; stream_idx++) {
+			if (state->stream_status[stream_idx].mall_stream_config.type != SUBVP_MAIN)
+				continue;
 
+			phantom_stream_idx = resource_stream_to_stream_idx(state,
+					state->stream_status[stream_idx].mall_stream_config.paired_stream);
+			otg_master = resource_get_otg_master_for_stream(
+					&state->res_ctx, state->streams[phantom_stream_idx]);
+			resource_log_pipe_for_stream(dc, state, otg_master, stream_idx);
 		}
 	}
 	DC_LOG_DC(" |________________________|\n");
-- 
2.34.1

