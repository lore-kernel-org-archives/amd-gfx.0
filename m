Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86628C001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3113410E4B1;
	Wed,  2 Aug 2023 06:52:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0377510E4B1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnHyE6uB610yHMOL2YYy39srbQeOLzjv+Q6b66YKFuL/RfUlzljGtkkpramAAyEiroqwQ/seVzfzkhsaqN7c8TZ7OVI4o0VnaPRHOXEbvGqUUGxQVeSwuuyue+AaHdiZkc7heQPcssyn7sbGSfKIxftDVEmpCyjih/ffY5aPU45E9LHKGAKFqTQPSEfJEyNQVYxZvkxxkh1EblP3JIsy9Bww7Ig6+Afy/8ejctmOLahull6uEky+JnULcDXUdBcYsGPZLprMjsRHOIEtC9DDRbWWWqYHUwQmEVdzVRxFbWgta7tJUrHTenUD2EJWREtmY7qzHYKJf42KbLq0HQkhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmwrLsjRBHwz0V2E0lDsvgpg+yr/7RfeDv6y/OiOZ+I=;
 b=L2yUSpXaxY/MssShiy5OD+yaWNBD6K3xzUVz3kWrzBn4b28FEm8iLYBfHXRBCNNc/7+ptwm5TxucXnWh3nenlXaDxyQwcPl8sBfdUmeJaphFljAd4jG9ARY2Xw0S4qPyi2+3lczpNCo2/FDkfIyNS1Uek0U6epYGnBqyIpZFF0qDxDgJQD0aJdniuhIdk8IwOc/JxlBvOPL66sYUjCAa2G9R7ngwMJC9084aH9juVh8al1ngCP4PqbnI4VFrYHJO+sCbxDVggsc0pcbMcA1Wa6Mjmsz06TnU1F8JthMM2zkDH+3P51H5TCYljd5BNGr0SzldPsiat4B8ZjK5ZLNf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmwrLsjRBHwz0V2E0lDsvgpg+yr/7RfeDv6y/OiOZ+I=;
 b=yTTvuZr/Lkx5KjmKlp1Q4cTWMOQs4zMK2MaZM0t2aLXLUQnIQEgSCWx7RWxNKa4s4Yc2MvXYFXo6qg2h7Y1MNz6XyPOv+ef2QfvaNBgaP51LtTXn8q2IuHu74T5Pa2eB5WTmcnhu3rPfCVM8BDOxXR1ejXPJHsbQD1Vu29/PqtY=
Received: from MW4PR03CA0180.namprd03.prod.outlook.com (2603:10b6:303:8d::35)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Wed, 2 Aug
 2023 06:52:44 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::e4) by MW4PR03CA0180.outlook.office365.com
 (2603:10b6:303:8d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:52:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:41 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:52:38 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/22] drm/amd/display: update add plane to context logic with
 a new algorithm
Date: Wed, 2 Aug 2023 14:51:20 +0800
Message-ID: <20230802065132.3129932-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b6965a-f9d2-433c-7c07-08db932512f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4gsfTTXSapZpYKMDpLRZjvyln3FZwzrvBvC+LiioWVN4KKKAprk34/Dq9CXv3GeCRMj8of02CqgwIVdTFs66+lWT7gsv9B5SaXmGMcESh+Ix3NGfOEhHwar7NXdT3YyuFK/qpqGXqX2cmyhu4w/vfcTfnYGdzvcmdWu0XxFLspW+SgmWmzzNAReFI+PqOOsa4ZxyLC2j/VvWWHisjr8YeXYQUvvnwX3wATMmIntl83ql0I6q7WqGi1LUxASQ7wR8wifdKY5mzmwgFc+Yt/W7lRoH17DOl2A7OrVpSBbRqUfuZyPgIetbI2T8KUMeUxwdyz77FW5v6ruzJ7sEh6x5uBg1QOomCUcrs/UIzufeU4qVodYsh+XtWqsFRD+uDeyZSPhOzlWiYObEfeAQPZC9iueg+CAZ8GoAsJwZX+9z3UuCianfoC5J0R0DqW0KKhQc1b9srZV1defAWDuwCHBytTsZu2uHf9X/XBivQ2sW6cXeQuJ29uWhP9A7pDuFJFb6K5OYiEfsvsatsfh3+/qhxygfVckTBntq3wtPpvSAaCbpF3eGYE79kwOOf2nD1XKDNXsjwryw5Qe45o5fKgTeANzt4LihRGPNpu3BZV8Hz3sJ560JpTxkFY1Qj9ek5J2ULMkDB5o2yB0MGoABiJIl39KR3bTNFiEdz8rfZ1EpMavNP1gEcykRPIruljurTBLbx+wJZUOPEqvavf/tS/mKYcrgYYWtAUQdgYQoBv5o6AdmlUc46bt0E6HFWGTZrT6+vJs6G5vX+ex1p0rA0tVlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(1076003)(86362001)(54906003)(4326008)(336012)(478600001)(70206006)(6666004)(6916009)(316002)(7696005)(41300700001)(36756003)(82740400003)(81166007)(8676002)(356005)(8936002)(26005)(70586007)(186003)(5660300002)(2906002)(15650500001)(40460700003)(30864003)(426003)(2616005)(83380400001)(40480700001)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:52:44.2267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b6965a-f9d2-433c-7c07-08db932512f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Preivous algorithm for finding an optimal idle pipe for a new plane was
implemented to handle dynamic pipe allocation when MPO plane moves
from one ODM slice to the other. Now pipe allocation is more static so
it no longer depends on the MPO plane's position. We are simplifying
our logic and remove unnecessary handling in our code.

[how]
Apply a new simplified version of pipe resource allocation logic to reduce
unnecessary flip delay caused by swapping secondary dpp pipe to other
MPC blending tree.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 353 +++++++++++++-----
 .../amd/display/dc/dce110/dce110_resource.c   |  10 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  11 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  11 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   5 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |  11 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 119 ++----
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   8 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   2 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  42 +--
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   8 +-
 12 files changed, 328 insertions(+), 254 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index dc6ebfa205b0..43273e54147b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1557,7 +1557,7 @@ enum dc_status resource_build_scaling_params_for_context(
 	return DC_OK;
 }
 
-struct pipe_ctx *find_idle_secondary_pipe(
+struct pipe_ctx *find_idle_secondary_pipe_legacy(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
 		const struct pipe_ctx *primary_pipe)
@@ -1617,6 +1617,165 @@ struct pipe_ctx *find_idle_secondary_pipe(
 	return secondary_pipe;
 }
 
+/*
+ * Find the most optimal idle pipe from res_ctx, which could be used as a
+ * secondary dpp pipe for input opp head pipe.
+ *
+ * an idle pipe - a pipe in input res_ctx not yet used for any streams or
+ * planes.
+ * secondary dpp pipe - a pipe gets inserted to a head OPP pipe's MPC blending
+ * tree. This is typical used for rendering MPO planes or additional offset
+ * areas in MPCC combine.
+ *
+ * Hardware Transition Minimization Algorithm for Finding a Secondary DPP Pipe
+ * -------------------------------------------------------------------------
+ *
+ * PROBLEM:
+ *
+ * 1. There is a hardware limitation that a secondary DPP pipe cannot be
+ * transferred from one MPC blending tree to the other in a single frame.
+ * Otherwise it could cause glitches on the screen.
+ *
+ * For instance, we cannot transition from state 1 to state 2 in one frame. This
+ * is because PIPE1 is transferred from PIPE0's MPC blending tree over to
+ * PIPE2's MPC blending tree, which is not supported by hardware.
+ * To support this transition we need to first remove PIPE1 from PIPE0's MPC
+ * blending tree in one frame and then insert PIPE1 to PIPE2's MPC blending tree
+ * in the next frame. This is not optimal as it will delay the flip for two
+ * frames.
+ *
+ *	State 1:
+ *	PIPE0 -- secondary DPP pipe --> (PIPE1)
+ *	PIPE2 -- secondary DPP pipe --> NONE
+ *
+ *	State 2:
+ *	PIPE0 -- secondary DPP pipe --> NONE
+ *	PIPE2 -- secondary DPP pipe --> (PIPE1)
+ *
+ * 2. We want to in general minimize the unnecessary changes in pipe topology.
+ * If a pipe is already added in current blending tree and there are no changes
+ * to plane topology, we don't want to swap it with another idle pipe
+ * unnecessarily in every update. Powering up and down a pipe would require a
+ * full update which delays the flip for 1 frame. If we use the original pipe
+ * we don't have to toggle its power. So we can flip faster.
+ */
+struct pipe_ctx *find_optimal_idle_pipe_as_secondary_dpp_pipe(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *new_head)
+{
+	const struct pipe_ctx *cur_head, *cur_sec;
+	struct pipe_ctx *new_sec;
+	bool found = false;
+	int i;
+
+	cur_head = &cur_res_ctx->pipe_ctx[new_head->pipe_idx];
+	cur_sec = cur_head->bottom_pipe;
+
+	while (cur_sec) {
+		/* find an idle pipe used in current opp blend tree,
+		 * this is to avoid MPO pipe switching to different opp blending
+		 * tree
+		 */
+		new_sec = &new_res_ctx->pipe_ctx[cur_sec->pipe_idx];
+		if (new_sec->plane_state == NULL && new_sec->stream == NULL) {
+			new_sec->pipe_idx = cur_sec->pipe_idx;
+			found = true;
+			break;
+		}
+		cur_sec = cur_sec->bottom_pipe;
+	}
+
+	/* Up until here if we have not found an idle secondary pipe, we will
+	 * need to wait for at least one frame to complete the transition
+	 * sequence.
+	 */
+	if (!found) {
+		/* find a free pipe not used in current res ctx, this is to
+		 * avoid tearing down other pipe's topology
+		 */
+		for (i = 0; i < pool->pipe_count; i++) {
+			cur_sec = &cur_res_ctx->pipe_ctx[i];
+			new_sec = &new_res_ctx->pipe_ctx[i];
+
+			if (cur_sec->plane_state == NULL &&
+					cur_sec->stream == NULL &&
+					new_sec->plane_state == NULL &&
+					new_sec->stream == NULL) {
+				new_sec->pipe_idx = i;
+				found = true;
+				break;
+			}
+		}
+	}
+
+	/* Up until here if we have not found an idle secondary pipe, we will
+	 * need to wait for at least two frames to complete the transition
+	 * sequence. It really doesn't matter which pipe we decide take from
+	 * current enabled pipes. It won't save our frame time when we swap only
+	 * one pipe or more pipes.
+	 */
+	if (!found) {
+		/* find a free pipe by taking away a secondary dpp pipe from an
+		 * MPCC combine in current context
+		 */
+		for (i = 0; i < pool->pipe_count; i++) {
+			cur_sec = &cur_res_ctx->pipe_ctx[i];
+			new_sec = &new_res_ctx->pipe_ctx[i];
+
+			if (cur_sec->plane_state &&
+					cur_sec->bottom_pipe &&
+					cur_sec->bottom_pipe->plane_state == cur_sec->plane_state &&
+					new_sec->plane_state == NULL &&
+					new_sec->stream == NULL) {
+				found = true;
+				new_sec->pipe_idx = i;
+				break;
+			}
+		}
+	}
+
+	if (!found) {
+		/* find any pipe not used by new state */
+		for (i = 0; i < pool->pipe_count; i++) {
+			new_sec = &new_res_ctx->pipe_ctx[i];
+
+			if (new_sec->plane_state == NULL) {
+				found = true;
+				new_sec->pipe_idx = i;
+				break;
+			}
+		}
+	}
+
+	return found ? new_sec : NULL;
+}
+
+/* TODO: Unify the pipe naming convention:
+ *
+ * OPP head pipe - the head pipe of an MPC blending tree with a functional OPP
+ * feeding to an OTG. OPP head pipe is by convention the top most pipe. i.e.
+ * pipe's top_pipe is NULL.
+ *
+ * OTG master pipe - the master pipe of its OPP head pipes with a functional
+ * OTG. It merges all its OPP head pipes pixel data from their MPCs in ODM block
+ * and output to backend DIG. OTG master pipe is by convention the top most pipe
+ * of the first odm slice. i.e. pipe's top_pipe is NULL and pipe's prev_odm_pipe
+ * is NULL.
+ *
+ * Secondary OPP head pipe - an OPP head pipe which is not an OTG master pipe.
+ * Its output feeds to another OTG master pipe. i.e pipe's top_pipe is NULL and
+ * pipe's prev_odm_pipe is not NULL.
+ *
+ * Secondary DPP pipe - the pipe with a functional DPP outputting to another OPP
+ * head pipe's MPC. Its output is a secondary layer in the OPP head's MPC
+ * blending tree. Secondary DPP pipe is by convention a non top most pipe. i.e
+ * pipe's top_pipe should be not NULL.
+ *
+ * The function below is actually getting the OTG master pipe associated with
+ * the stream. Name it as getting head pipe is confusing.
+ */
 struct pipe_ctx *resource_get_head_pipe_for_stream(
 		struct resource_context *res_ctx,
 		struct dc_stream_state *stream)
@@ -1632,8 +1791,7 @@ struct pipe_ctx *resource_get_head_pipe_for_stream(
 	return NULL;
 }
 
-static struct pipe_ctx *resource_get_tail_pipe(
-		struct resource_context *res_ctx,
+static struct pipe_ctx *get_tail_pipe(
 		struct pipe_ctx *head_pipe)
 {
 	struct pipe_ctx *tail_pipe;
@@ -1648,44 +1806,6 @@ static struct pipe_ctx *resource_get_tail_pipe(
 	return head_pipe;
 }
 
-/*
- * A free_pipe for a stream is defined here as a pipe
- * that has no surface attached yet
- */
-static struct pipe_ctx *acquire_free_pipe_for_head(
-		struct dc_state *context,
-		const struct resource_pool *pool,
-		struct pipe_ctx *head_pipe)
-{
-	int i;
-	struct resource_context *res_ctx = &context->res_ctx;
-
-	if (!head_pipe->plane_state)
-		return head_pipe;
-
-	/* Re-use pipe already acquired for this stream if available*/
-	for (i = pool->pipe_count - 1; i >= 0; i--) {
-		if (res_ctx->pipe_ctx[i].stream == head_pipe->stream &&
-				!res_ctx->pipe_ctx[i].plane_state) {
-			return &res_ctx->pipe_ctx[i];
-		}
-	}
-
-	/*
-	 * At this point we have no re-useable pipe for this stream and we need
-	 * to acquire an idle one to satisfy the request
-	 */
-
-	if (!pool->funcs->acquire_idle_pipe_for_layer) {
-		if (!pool->funcs->acquire_idle_pipe_for_head_pipe_in_layer)
-			return NULL;
-		else
-			return pool->funcs->acquire_idle_pipe_for_head_pipe_in_layer(context, pool, head_pipe->stream, head_pipe);
-	}
-
-	return pool->funcs->acquire_idle_pipe_for_layer(context, pool, head_pipe->stream);
-}
-
 static int acquire_first_split_pipe(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
@@ -1721,88 +1841,121 @@ static int acquire_first_split_pipe(
 	return UNABLE_TO_SPLIT;
 }
 
-bool dc_add_plane_to_context(
-		const struct dc *dc,
-		struct dc_stream_state *stream,
+static bool add_plane_to_opp_head_pipes(struct pipe_ctx *otg_master_pipe,
 		struct dc_plane_state *plane_state,
 		struct dc_state *context)
 {
-	int i;
-	struct resource_pool *pool = dc->res_pool;
-	struct pipe_ctx *head_pipe, *tail_pipe, *free_pipe;
-	struct dc_stream_status *stream_status = NULL;
+	struct pipe_ctx *opp_head_pipe = otg_master_pipe;
 
-	DC_LOGGER_INIT(stream->ctx->logger);
-	for (i = 0; i < context->stream_count; i++)
-		if (context->streams[i] == stream) {
-			stream_status = &context->stream_status[i];
-			break;
+	while (opp_head_pipe) {
+		if (opp_head_pipe->plane_state) {
+			ASSERT(0);
+			return false;
 		}
-	if (stream_status == NULL) {
-		dm_error("Existing stream not found; failed to attach surface!\n");
-		return false;
+		opp_head_pipe->plane_state = plane_state;
+		opp_head_pipe = opp_head_pipe->next_odm_pipe;
 	}
 
+	return true;
+}
 
-	if (stream_status->plane_count == MAX_SURFACE_NUM) {
-		dm_error("Surface: can not attach plane_state %p! Maximum is: %d\n",
-				plane_state, MAX_SURFACE_NUM);
-		return false;
+static void insert_secondary_dpp_pipe_with_plane(struct pipe_ctx *opp_head_pipe,
+		struct pipe_ctx *sec_pipe, struct dc_plane_state *plane_state)
+{
+	struct pipe_ctx *tail_pipe = get_tail_pipe(opp_head_pipe);
+
+	tail_pipe->bottom_pipe = sec_pipe;
+	sec_pipe->top_pipe = tail_pipe;
+	if (tail_pipe->prev_odm_pipe) {
+		ASSERT(tail_pipe->prev_odm_pipe->bottom_pipe);
+		sec_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
+		tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = sec_pipe;
 	}
+	sec_pipe->plane_state = plane_state;
+}
 
-	head_pipe = resource_get_head_pipe_for_stream(&context->res_ctx, stream);
+/* for each opp head pipe of an otg master pipe, acquire a secondary dpp pipe
+ * and add the plane. So the plane is added to all MPC blend trees associated
+ * with the otg master pipe.
+ */
+static bool acquire_secondary_dpp_pipes_and_add_plane(
+		struct pipe_ctx *otg_master_pipe,
+		struct dc_plane_state *plane_state,
+		struct dc_state *new_ctx,
+		struct dc_state *cur_ctx,
+		struct resource_pool *pool)
+{
+	struct pipe_ctx *opp_head_pipe, *sec_pipe;
 
-	if (!head_pipe) {
-		dm_error("Head pipe not found for stream_state %p !\n", stream);
+	if (!pool->funcs->acquire_idle_pipe_for_layer)
 		return false;
-	}
 
-	/* retain new surface, but only once per stream */
-	dc_plane_state_retain(plane_state);
-
-	while (head_pipe) {
-		free_pipe = acquire_free_pipe_for_head(context, pool, head_pipe);
+	opp_head_pipe = otg_master_pipe;
+	while (opp_head_pipe) {
+		sec_pipe = pool->funcs->acquire_idle_pipe_for_layer(
+				cur_ctx,
+				new_ctx,
+				pool,
+				opp_head_pipe);
+		if (!sec_pipe) {
+			/* try tearing down MPCC combine */
+			int pipe_idx = acquire_first_split_pipe(
+					&new_ctx->res_ctx, pool,
+					otg_master_pipe->stream);
 
-		if (!free_pipe) {
-			int pipe_idx = acquire_first_split_pipe(&context->res_ctx, pool, stream);
 			if (pipe_idx >= 0)
-				free_pipe = &context->res_ctx.pipe_ctx[pipe_idx];
+				sec_pipe = &new_ctx->res_ctx.pipe_ctx[pipe_idx];
 		}
 
-		if (!free_pipe) {
-			dc_plane_state_release(plane_state);
+		if (!sec_pipe)
 			return false;
-		}
-
-		free_pipe->plane_state = plane_state;
-
-		if (head_pipe != free_pipe) {
-			tail_pipe = resource_get_tail_pipe(&context->res_ctx, head_pipe);
-			ASSERT(tail_pipe);
-
-			free_pipe->stream_res.tg = tail_pipe->stream_res.tg;
-			free_pipe->stream_res.abm = tail_pipe->stream_res.abm;
-			free_pipe->stream_res.opp = tail_pipe->stream_res.opp;
-			free_pipe->stream_res.stream_enc = tail_pipe->stream_res.stream_enc;
-			free_pipe->stream_res.audio = tail_pipe->stream_res.audio;
-			free_pipe->clock_source = tail_pipe->clock_source;
-			free_pipe->top_pipe = tail_pipe;
-			tail_pipe->bottom_pipe = free_pipe;
-			if (tail_pipe->prev_odm_pipe) {
-				tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
-				free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
-			}
-		}
 
-		head_pipe = head_pipe->next_odm_pipe;
+		insert_secondary_dpp_pipe_with_plane(opp_head_pipe, sec_pipe,
+				plane_state);
+		opp_head_pipe = opp_head_pipe->next_odm_pipe;
 	}
+	return true;
+}
 
-	/* assign new surfaces*/
-	stream_status->plane_states[stream_status->plane_count] = plane_state;
+bool dc_add_plane_to_context(
+		const struct dc *dc,
+		struct dc_stream_state *stream,
+		struct dc_plane_state *plane_state,
+		struct dc_state *context)
+{
+	struct resource_pool *pool = dc->res_pool;
+	struct pipe_ctx *otg_master_pipe;
+	struct dc_stream_status *stream_status = NULL;
+	bool added = false;
 
-	stream_status->plane_count++;
+	stream_status = dc_stream_get_status_from_state(context, stream);
+	if (stream_status == NULL) {
+		dm_error("Existing stream not found; failed to attach surface!\n");
+		goto out;
+	} else if (stream_status->plane_count == MAX_SURFACE_NUM) {
+		dm_error("Surface: can not attach plane_state %p! Maximum is: %d\n",
+				plane_state, MAX_SURFACE_NUM);
+		goto out;
+	}
 
-	return true;
+	otg_master_pipe = resource_get_head_pipe_for_stream(
+			&context->res_ctx, stream);
+	if (otg_master_pipe->plane_state == NULL)
+		added = add_plane_to_opp_head_pipes(otg_master_pipe,
+				plane_state, context);
+	else
+		added = acquire_secondary_dpp_pipes_and_add_plane(
+				otg_master_pipe, plane_state, context,
+				dc->current_state, pool);
+	if (added) {
+		stream_status->plane_states[stream_status->plane_count] =
+				plane_state;
+		stream_status->plane_count++;
+		dc_plane_state_retain(plane_state);
+	}
+
+out:
+	return added;
 }
 
 bool dc_remove_plane_from_context(
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 46eca5a21e1c..b17134504944 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -1119,13 +1119,15 @@ static enum dc_status dce110_add_stream_to_ctx(
 }
 
 static struct pipe_ctx *dce110_acquire_underlay(
-		struct dc_state *context,
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
-		struct dc_stream_state *stream)
+		const struct pipe_ctx *opp_head_pipe)
 {
+	struct dc_stream_state *stream = opp_head_pipe->stream;
 	struct dc *dc = stream->ctx->dc;
 	struct dce_hwseq *hws = dc->hwseq;
-	struct resource_context *res_ctx = &context->res_ctx;
+	struct resource_context *res_ctx = &new_ctx->res_ctx;
 	unsigned int underlay_idx = pool->underlay_pipe_index;
 	struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[underlay_idx];
 
@@ -1173,7 +1175,7 @@ static struct pipe_ctx *dce110_acquire_underlay(
 				stream->timing.h_total,
 				stream->timing.v_total,
 				stream->timing.pix_clk_100hz / 10,
-				context->stream_count);
+				new_ctx->stream_count);
 
 		color_space_to_black_color(dc,
 				COLOR_SPACE_YCBCR601, &black_color);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 4b02f8443534..292e71b99808 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1084,13 +1084,14 @@ static enum dc_status dcn10_add_stream_to_ctx(
 }
 
 static struct pipe_ctx *dcn10_acquire_idle_pipe_for_layer(
-		struct dc_state *context,
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
-		struct dc_stream_state *stream)
+		const struct pipe_ctx *opp_head_pipe)
 {
-	struct resource_context *res_ctx = &context->res_ctx;
-	struct pipe_ctx *head_pipe = resource_get_head_pipe_for_stream(res_ctx, stream);
-	struct pipe_ctx *idle_pipe = find_idle_secondary_pipe(res_ctx, pool, head_pipe);
+	struct resource_context *res_ctx = &new_ctx->res_ctx;
+	struct pipe_ctx *head_pipe = resource_get_head_pipe_for_stream(res_ctx, opp_head_pipe->stream);
+	struct pipe_ctx *idle_pipe = find_idle_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
 	if (!head_pipe) {
 		ASSERT(0);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 4cc8de2627ce..d526f06e8f1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2148,13 +2148,14 @@ bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
 }
 
 struct pipe_ctx *dcn20_acquire_idle_pipe_for_layer(
-		struct dc_state *state,
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
-		struct dc_stream_state *stream)
+		const struct pipe_ctx *opp_head_pipe)
 {
-	struct resource_context *res_ctx = &state->res_ctx;
-	struct pipe_ctx *head_pipe = resource_get_head_pipe_for_stream(res_ctx, stream);
-	struct pipe_ctx *idle_pipe = find_idle_secondary_pipe(res_ctx, pool, head_pipe);
+	struct resource_context *res_ctx = &new_ctx->res_ctx;
+	struct pipe_ctx *head_pipe = resource_get_head_pipe_for_stream(res_ctx, opp_head_pipe->stream);
+	struct pipe_ctx *idle_pipe = find_idle_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
 	if (!head_pipe)
 		ASSERT(0);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index da0241e8c255..67a78ea2c0e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -59,9 +59,10 @@ unsigned int dcn20_calc_max_scaled_time(
 		unsigned int urgent_watermark);
 
 struct pipe_ctx *dcn20_acquire_idle_pipe_for_layer(
-		struct dc_state *state,
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
-		struct dc_stream_state *stream);
+		const struct pipe_ctx *opp_head_pipe);
 
 struct stream_encoder *dcn20_stream_encoder_create(
 	enum engine_id eng_id,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index fdba8a9f5c30..1a8927e9b64b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -993,13 +993,14 @@ static struct hubp *dcn201_hubp_create(
 }
 
 static struct pipe_ctx *dcn201_acquire_idle_pipe_for_layer(
-		struct dc_state *context,
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
-		struct dc_stream_state *stream)
+		const struct pipe_ctx *opp_head_pipe)
 {
-	struct resource_context *res_ctx = &context->res_ctx;
-	struct pipe_ctx *head_pipe = resource_get_head_pipe_for_stream(res_ctx, stream);
-	struct pipe_ctx *idle_pipe = find_idle_secondary_pipe(res_ctx, pool, head_pipe);
+	struct resource_context *res_ctx = &new_ctx->res_ctx;
+	struct pipe_ctx *head_pipe = resource_get_head_pipe_for_stream(res_ctx, opp_head_pipe->stream);
+	struct pipe_ctx *idle_pipe = find_idle_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
 	if (!head_pipe)
 		ASSERT(0);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 0d1f18f8348e..fd6511da2903 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2038,7 +2038,7 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.validate_bandwidth = dcn32_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn32_calculate_wm_and_dlg,
 	.populate_dml_pipes = dcn32_populate_dml_pipes_from_context,
-	.acquire_idle_pipe_for_head_pipe_in_layer = dcn32_acquire_idle_pipe_for_head_pipe_in_layer,
+	.acquire_idle_pipe_for_layer = dcn32_acquire_idle_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
@@ -2485,108 +2485,31 @@ struct resource_pool *dcn32_create_resource_pool(
 	return NULL;
 }
 
-static struct pipe_ctx *find_idle_secondary_pipe_check_mpo(
-		struct resource_context *res_ctx,
-		const struct resource_pool *pool,
-		const struct pipe_ctx *primary_pipe)
-{
-	int i;
-	struct pipe_ctx *secondary_pipe = NULL;
-	struct pipe_ctx *next_odm_mpo_pipe = NULL;
-	int primary_index, preferred_pipe_idx;
-	struct pipe_ctx *old_primary_pipe = NULL;
-
-	/*
-	 * Modified from find_idle_secondary_pipe
-	 * With windowed MPO and ODM, we want to avoid the case where we want a
-	 *  free pipe for the left side but the free pipe is being used on the
-	 *  right side.
-	 * Add check on current_state if the primary_pipe is the left side,
-	 *  to check the right side ( primary_pipe->next_odm_pipe ) to see if
-	 *  it is using a pipe for MPO ( primary_pipe->next_odm_pipe->bottom_pipe )
-	 * - If so, then don't use this pipe
-	 * EXCEPTION - 3 plane ( 2 MPO plane ) case
-	 * - in this case, the primary pipe has already gotten a free pipe for the
-	 *  MPO window in the left
-	 * - when it tries to get a free pipe for the MPO window on the right,
-	 *  it will see that it is already assigned to the right side
-	 *  ( primary_pipe->next_odm_pipe ).  But in this case, we want this
-	 *  free pipe, since it will be for the right side.  So add an
-	 *  additional condition, that skipping the free pipe on the right only
-	 *  applies if the primary pipe has no bottom pipe currently assigned
-	 */
-	if (primary_pipe) {
-		primary_index = primary_pipe->pipe_idx;
-		old_primary_pipe = &primary_pipe->stream->ctx->dc->current_state->res_ctx.pipe_ctx[primary_index];
-		if ((old_primary_pipe->next_odm_pipe) && (old_primary_pipe->next_odm_pipe->bottom_pipe)
-			&& (!primary_pipe->bottom_pipe))
-			next_odm_mpo_pipe = old_primary_pipe->next_odm_pipe->bottom_pipe;
-
-		preferred_pipe_idx = (pool->pipe_count - 1) - primary_pipe->pipe_idx;
-		if ((res_ctx->pipe_ctx[preferred_pipe_idx].stream == NULL) &&
-			!(next_odm_mpo_pipe && next_odm_mpo_pipe->pipe_idx == preferred_pipe_idx)) {
-			secondary_pipe = &res_ctx->pipe_ctx[preferred_pipe_idx];
-			secondary_pipe->pipe_idx = preferred_pipe_idx;
-		}
-	}
-
-	/*
-	 * search backwards for the second pipe to keep pipe
-	 * assignment more consistent
-	 */
-	if (!secondary_pipe)
-		for (i = pool->pipe_count - 1; i >= 0; i--) {
-			if ((res_ctx->pipe_ctx[i].stream == NULL) &&
-				!(next_odm_mpo_pipe && next_odm_mpo_pipe->pipe_idx == i)) {
-				secondary_pipe = &res_ctx->pipe_ctx[i];
-				secondary_pipe->pipe_idx = i;
-				break;
-			}
-		}
-
-	return secondary_pipe;
-}
-
-struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
-		struct dc_state *state,
+struct pipe_ctx *dcn32_acquire_idle_pipe_for_layer(
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
-		struct dc_stream_state *stream,
-		struct pipe_ctx *head_pipe)
+		const struct pipe_ctx *opp_head_pipe)
 {
-	struct resource_context *res_ctx = &state->res_ctx;
-	struct pipe_ctx *idle_pipe, *pipe;
-	struct resource_context *old_ctx = &stream->ctx->dc->current_state->res_ctx;
-	int head_index;
-
-	if (!head_pipe)
-		ASSERT(0);
-
-	/*
-	 * Modified from dcn20_acquire_idle_pipe_for_layer
-	 * Check if head_pipe in old_context already has bottom_pipe allocated.
-	 * - If so, check if that pipe is available in the current context.
-	 * --  If so, reuse pipe from old_context
-	 */
-	head_index = head_pipe->pipe_idx;
-	pipe = &old_ctx->pipe_ctx[head_index];
-	if (pipe->bottom_pipe && res_ctx->pipe_ctx[pipe->bottom_pipe->pipe_idx].stream == NULL) {
-		idle_pipe = &res_ctx->pipe_ctx[pipe->bottom_pipe->pipe_idx];
-		idle_pipe->pipe_idx = pipe->bottom_pipe->pipe_idx;
+	struct pipe_ctx *idle_pipe =
+			find_optimal_idle_pipe_as_secondary_dpp_pipe(
+					&cur_ctx->res_ctx, &new_ctx->res_ctx,
+					pool, opp_head_pipe);
+
+	if (idle_pipe) {
+		idle_pipe->stream = opp_head_pipe->stream;
+		idle_pipe->stream_res.tg = opp_head_pipe->stream_res.tg;
+		idle_pipe->stream_res.opp = opp_head_pipe->stream_res.opp;
+
+		idle_pipe->plane_res.hubp = pool->hubps[idle_pipe->pipe_idx];
+		idle_pipe->plane_res.ipp = pool->ipps[idle_pipe->pipe_idx];
+		idle_pipe->plane_res.dpp = pool->dpps[idle_pipe->pipe_idx];
+		idle_pipe->plane_res.mpcc_inst =
+				pool->dpps[idle_pipe->pipe_idx]->inst;
 	} else {
-		idle_pipe = find_idle_secondary_pipe_check_mpo(res_ctx, pool, head_pipe);
-		if (!idle_pipe)
-			return NULL;
+		ASSERT(opp_head_pipe);
 	}
 
-	idle_pipe->stream = head_pipe->stream;
-	idle_pipe->stream_res.tg = head_pipe->stream_res.tg;
-	idle_pipe->stream_res.opp = head_pipe->stream_res.opp;
-
-	idle_pipe->plane_res.hubp = pool->hubps[idle_pipe->pipe_idx];
-	idle_pipe->plane_res.ipp = pool->ipps[idle_pipe->pipe_idx];
-	idle_pipe->plane_res.dpp = pool->dpps[idle_pipe->pipe_idx];
-	idle_pipe->plane_res.mpcc_inst = pool->dpps[idle_pipe->pipe_idx]->inst;
-
 	return idle_pipe;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 81e443170829..165754ed5f49 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -136,11 +136,11 @@ bool dcn32_any_surfaces_rotated(struct dc *dc, struct dc_state *context);
 bool dcn32_is_center_timing(struct pipe_ctx *pipe);
 bool dcn32_is_psr_capable(struct pipe_ctx *pipe);
 
-struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
-		struct dc_state *state,
+struct pipe_ctx *dcn32_acquire_idle_pipe_for_layer(
+		const struct dc_state *cur_ctx,
+		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
-		struct dc_stream_state *stream,
-		struct pipe_ctx *head_pipe);
+		const struct pipe_ctx *opp_head_pipe);
 
 void dcn32_determine_det_override(struct dc *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index a53478e15ce3..c2fd841d4c0b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1588,7 +1588,7 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.validate_bandwidth = dcn32_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn32_calculate_wm_and_dlg,
 	.populate_dml_pipes = dcn32_populate_dml_pipes_from_context,
-	.acquire_idle_pipe_for_head_pipe_in_layer = dcn32_acquire_idle_pipe_for_head_pipe_in_layer,
+	.acquire_idle_pipe_for_layer = dcn32_acquire_idle_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index e73f089c84bb..8377a0b58ec3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -1258,7 +1258,7 @@ bool dcn_validate_bandwidth(
 						hsplit_pipe->pipe_dlg_param.vblank_end = pipe->pipe_dlg_param.vblank_end;
 					} else {
 						/* pipe not split previously needs split */
-						hsplit_pipe = find_idle_secondary_pipe(&context->res_ctx, pool, pipe);
+						hsplit_pipe = find_idle_secondary_pipe_legacy(&context->res_ctx, pool, pipe);
 						ASSERT(hsplit_pipe);
 						split_stream_across_pipes(&context->res_ctx, pool, pipe, hsplit_pipe);
 					}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 034610b74a37..b821e27867b7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -126,38 +126,24 @@ struct resource_funcs {
 		struct dc_state *context);
 
 	/*
-	 * Acquires a free pipe for the head pipe.
-	 * The head pipe is first pipe in the current context that matches the stream
-	 *  and does not have a top pipe or prev_odm_pipe.
-	 */
-	struct pipe_ctx *(*acquire_idle_pipe_for_layer)(
-			struct dc_state *context,
-			const struct resource_pool *pool,
-			struct dc_stream_state *stream);
-
-	/*
-	 * Acquires a free pipe for the head pipe with some additional checks for odm.
-	 * The head pipe is passed in as an argument unlike acquire_idle_pipe_for_layer
-	 *  where it is read from the context.  So this allows us look for different
-	 *  idle_pipe if the head_pipes are different ( ex. in odm 2:1 when we have
-	 *  a left and right pipe ).
-	 *
-	 * It also checks the old context to see if:
+	 * Acquire an idle pipe from context, which could be used as a secondary
+	 * pipe for the otg master pipe associated with the input stream.
 	 *
-	 * 1. a pipe has already been allocated for the head pipe.  If so, it will
-	 *  try to select that pipe as the idle pipe if it is available in the current
-	 *  context.
-	 * 2. if the head_pipe is on the left, it will check if the right pipe has
-	 *  a pipe already allocated.  If so, it will not use that pipe if it is
-	 *  selected as the idle pipe.
+	 * an idle pipe - a pipe not yet used for any streams or
+	 * planes.
+	 * secondary pipe - a pipe gets inserted to a head OPP pipe's blending
+	 * tree. This is typical used for rendering MPO planes or additional
+	 * offset areas in MPCC combine.
 	 */
-	struct pipe_ctx *(*acquire_idle_pipe_for_head_pipe_in_layer)(
-			struct dc_state *context,
+	struct pipe_ctx *(*acquire_idle_pipe_for_layer)(
+			const struct dc_state *cur_ctx,
+			struct dc_state *new_ctx,
 			const struct resource_pool *pool,
-			struct dc_stream_state *stream,
-			struct pipe_ctx *head_pipe);
+			const struct pipe_ctx *opp_head_pipe);
 
-	enum dc_status (*validate_plane)(const struct dc_plane_state *plane_state, struct dc_caps *caps);
+	enum dc_status (*validate_plane)(
+			const struct dc_plane_state *plane_state,
+			struct dc_caps *caps);
 
 	enum dc_status (*add_stream_to_ctx)(
 			struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index eaeb684c8a48..6ac6680711ff 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -153,11 +153,17 @@ bool resource_attach_surfaces_to_context(
 		struct dc_state *context,
 		const struct resource_pool *pool);
 
-struct pipe_ctx *find_idle_secondary_pipe(
+struct pipe_ctx *find_idle_secondary_pipe_legacy(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
 		const struct pipe_ctx *primary_pipe);
 
+struct pipe_ctx *find_optimal_idle_pipe_as_secondary_dpp_pipe(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *new_pri);
+
 bool resource_validate_attach_surfaces(
 		const struct dc_validation_set set[],
 		int set_count,
-- 
2.25.1

