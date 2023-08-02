Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91027C04A94
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A3510E4BB;
	Wed,  2 Aug 2023 06:53:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE3F10E4B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXVVD1BtsNWSDtMMhm5UZbU5GTrSdiejdljBExnDB6USjAcT9Y+i1ryIoiNmRGd2+7zHGLP11KNsUV4VmmJ0IUBmWy10h2P7cIQlnoY1sfexeuMqET+FaBu4jEXu2vs6cxq4vmMFe632QgLsMcZAnCVgnVDkvGxp4oMNfzS079d2edzzv/9s2EexaVVPM229y3NXfMhSWpoVElj/zDcn2LhwEKKEgaD/VOD5Iur2E1JfFmYPOsrgkbekI6yq9Fvsm2pNvamjU2JONW7uPiiyBraJqFF/E5Og+p1462nrOwClfYu6lhN7hIoeUxskumWPcYINXj4+s2Dr/OzZCBFiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lla+Fnt4uGIOvRHJFCip59xmF7ngQadBfp5I+/zSEds=;
 b=b0KkXTSoz2YUd5E5fp7/HPsevbXJ7UYk9JUgszzFOcCoPkATK42Q3zQhIW+UNBHLK/lLVhgC0wSb2zPZz8s3xv1MRbM0LeA+Uqt5zfdguutHDM29JSbItMWrj/ZRRK80yyjsLqMAfAugtndBFPfqn+0Yykr7ps6hfXSJJwKXj/V8flj8ZZhqtlwHKAYsRwdsjSk5IkbhdMAqYMAQih34afizrG9qPFJO9zpll5aJzglv7oxRT5K+LidFcT6ETDw5JFlsaBsyfxTeVbE+u9VgsFciQV5mJVqAz2+CrEp3HbfPxNO3ShoDgDd0M7NPKCpe085YRu5Zn0OXzVq36EbpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lla+Fnt4uGIOvRHJFCip59xmF7ngQadBfp5I+/zSEds=;
 b=x1AnzCd5a/WldMdb6RE2FqEhKmgiZcyJsEAYEJzOKCsc2Co0prFsxXxs31gzlkzxNPEa8fZlMluHPLeK+YrtxTFQYR3jeLkBBeVb65ZuZJl5yO7AWTrDtmA9L3ccYR2r1Aj57rqcEns/qjpvCbxf4d3Vs/NcMe2hlEgwlPtXngs=
Received: from CY5PR15CA0120.namprd15.prod.outlook.com (2603:10b6:930:68::9)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:53:29 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::e4) by CY5PR15CA0120.outlook.office365.com
 (2603:10b6:930:68::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:53:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:28 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:53:24 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/22] drm/amd/display: move idle pipe allocation logic into
 dcn specific layer
Date: Wed, 2 Aug 2023 14:51:28 +0800
Message-ID: <20230802065132.3129932-19-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: 90508c05-3196-4f2f-b255-08db93252db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMhKPkRCU1oDAkO3lv0DpSshtCiaruelsZCnrdPgZosWPY2q9foaPwQzHK7kcL4q0b9YQ2lJjI6CLTez0UnMIS6/6Vm2ffz9LJVbzomrA0HHcXlWZPGweptEbNJVWqnhb+TtoPbwxq/GLustp7NlBp7F6B5G0p3n+e3RnJh0H7NiL4JHOryhsh695UJjXAWHyZHqzigfU9reybfimECDDqMS2BfADCLjp9Xl2g8HC456xSKgZnrYnIQIRIthPjb+SJPg2dFYEb7x/1ZLXZqvnMqZp/HSd4dJ01BRaRXmnk17Mr5oD4SKC3HdeM1B0H6r9z4QiKnhuXy9cov5b+rJVA6vPKD8RjRTGUJyOkR9KgABZiAGRWubzVAHKwt7w+2+03J3qwUq5CEcURiGXhxjf4fcZ6iBVZptM6fNj5G901orNocr0Hfcy8UJoW7BTKs+vRXT3LMEmPZ1+VfVdywhUf6HhWXngHqxXT/LNi7Y8vHd9S1hnHyjPXCv9JTtgqq6Sl/Xp3kfMt/2yNwg98kGcx9kQ8ImhrhnhlN5zSNkRfJpSp8Vj8MuEWAYqqKuju8wEM1m84A1BCY7lM6jirYdu3je9M/IpBtElB8GjLPm5HUGULrHAjafAYiCFA1uslcb20la0N8e9w3xrqtfHA2IL5mIBLGpSztsu6rfkICr77RIZ7/X7FP8JyMP2MSHoQBfN8CkArK9BblNMvR8lj0nEBniGxIUKZ5DF6HTkPyDDx6D2KuQhrF9ZAwJ/fj93h86fgksflmSoJOOr9Tax2LvYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(336012)(186003)(40460700003)(2616005)(36756003)(316002)(86362001)(478600001)(81166007)(54906003)(70586007)(70206006)(7696005)(4326008)(6916009)(82740400003)(356005)(26005)(1076003)(41300700001)(8936002)(8676002)(30864003)(426003)(47076005)(83380400001)(36860700001)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:53:29.1434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90508c05-3196-4f2f-b255-08db93252db0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198
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
generic dc resource file should not know what an optimal idle pipe is
because this is dcn hardware dependent.

[how]
We move the optimial pipe searching logic in dcn specific layer.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 184 +++++++-----------
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  87 ++++++++-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  19 +-
 3 files changed, 174 insertions(+), 116 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 218fe2c401e1..103dfe82dc28 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1623,139 +1623,101 @@ struct pipe_ctx *find_idle_secondary_pipe_legacy(
 	return secondary_pipe;
 }
 
-/*
- * Find the most optimal idle pipe from res_ctx, which could be used as a
- * secondary dpp pipe for input opp head pipe.
- *
- * an idle pipe - a pipe in input res_ctx not yet used for any streams or
- * planes.
- * secondary dpp pipe - a pipe gets inserted to a head OPP pipe's MPC blending
- * tree. This is typical used for rendering MPO planes or additional offset
- * areas in MPCC combine.
- *
- * Hardware Transition Minimization Algorithm for Finding a Secondary DPP Pipe
- * -------------------------------------------------------------------------
- *
- * PROBLEM:
- *
- * 1. There is a hardware limitation that a secondary DPP pipe cannot be
- * transferred from one MPC blending tree to the other in a single frame.
- * Otherwise it could cause glitches on the screen.
- *
- * For instance, we cannot transition from state 1 to state 2 in one frame. This
- * is because PIPE1 is transferred from PIPE0's MPC blending tree over to
- * PIPE2's MPC blending tree, which is not supported by hardware.
- * To support this transition we need to first remove PIPE1 from PIPE0's MPC
- * blending tree in one frame and then insert PIPE1 to PIPE2's MPC blending tree
- * in the next frame. This is not optimal as it will delay the flip for two
- * frames.
- *
- *	State 1:
- *	PIPE0 -- secondary DPP pipe --> (PIPE1)
- *	PIPE2 -- secondary DPP pipe --> NONE
- *
- *	State 2:
- *	PIPE0 -- secondary DPP pipe --> NONE
- *	PIPE2 -- secondary DPP pipe --> (PIPE1)
- *
- * 2. We want to in general minimize the unnecessary changes in pipe topology.
- * If a pipe is already added in current blending tree and there are no changes
- * to plane topology, we don't want to swap it with another idle pipe
- * unnecessarily in every update. Powering up and down a pipe would require a
- * full update which delays the flip for 1 frame. If we use the original pipe
- * we don't have to toggle its power. So we can flip faster.
- */
-struct pipe_ctx *find_optimal_idle_pipe_as_secondary_dpp_pipe(
+int resource_find_idle_pipe_used_in_cur_mpc_blending_tree(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
-		const struct resource_pool *pool,
-		const struct pipe_ctx *new_head)
+		const struct pipe_ctx *cur_opp_head)
 {
-	const struct pipe_ctx *cur_head, *cur_sec;
-	struct pipe_ctx *new_sec;
-	bool found = false;
-	int i;
-
-	cur_head = &cur_res_ctx->pipe_ctx[new_head->pipe_idx];
-	cur_sec = cur_head->bottom_pipe;
+	const struct pipe_ctx *cur_sec_dpp = cur_opp_head->bottom_pipe;
+	struct pipe_ctx *new_sec_dpp;
+	int idle_pipe_idx = IDLE_PIPE_INDEX_NOT_FOUND;
 
-	while (cur_sec) {
+	while (cur_sec_dpp) {
 		/* find an idle pipe used in current opp blend tree,
 		 * this is to avoid MPO pipe switching to different opp blending
 		 * tree
 		 */
-		new_sec = &new_res_ctx->pipe_ctx[cur_sec->pipe_idx];
-		if (new_sec->plane_state == NULL && new_sec->stream == NULL) {
-			new_sec->pipe_idx = cur_sec->pipe_idx;
-			found = true;
+		new_sec_dpp = &new_res_ctx->pipe_ctx[cur_sec_dpp->pipe_idx];
+		if (new_sec_dpp->plane_state == NULL &&
+				new_sec_dpp->stream == NULL) {
+			idle_pipe_idx = cur_sec_dpp->pipe_idx;
 			break;
 		}
-		cur_sec = cur_sec->bottom_pipe;
+		cur_sec_dpp = cur_sec_dpp->bottom_pipe;
 	}
 
-	/* Up until here if we have not found an idle secondary pipe, we will
-	 * need to wait for at least one frame to complete the transition
-	 * sequence.
-	 */
-	if (!found) {
-		/* find a free pipe not used in current res ctx, this is to
-		 * avoid tearing down other pipe's topology
-		 */
-		for (i = 0; i < pool->pipe_count; i++) {
-			cur_sec = &cur_res_ctx->pipe_ctx[i];
-			new_sec = &new_res_ctx->pipe_ctx[i];
-
-			if (cur_sec->plane_state == NULL &&
-					cur_sec->stream == NULL &&
-					new_sec->plane_state == NULL &&
-					new_sec->stream == NULL) {
-				new_sec->pipe_idx = i;
-				found = true;
-				break;
-			}
+	return idle_pipe_idx;
+}
+
+int recource_find_idle_pipe_not_used_in_cur_res_ctx(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool)
+{
+	int idle_pipe_idx = IDLE_PIPE_INDEX_NOT_FOUND;
+	const struct pipe_ctx *new_sec_dpp, *cur_sec_dpp;
+	int i;
+
+	for (i = 0; i < pool->pipe_count; i++) {
+		cur_sec_dpp = &cur_res_ctx->pipe_ctx[i];
+		new_sec_dpp = &new_res_ctx->pipe_ctx[i];
+
+		if (cur_sec_dpp->plane_state == NULL &&
+				cur_sec_dpp->stream == NULL &&
+				new_sec_dpp->plane_state == NULL &&
+				new_sec_dpp->stream == NULL) {
+			idle_pipe_idx = i;
+			break;
 		}
 	}
 
-	/* Up until here if we have not found an idle secondary pipe, we will
-	 * need to wait for at least two frames to complete the transition
-	 * sequence. It really doesn't matter which pipe we decide take from
-	 * current enabled pipes. It won't save our frame time when we swap only
-	 * one pipe or more pipes.
-	 */
-	if (!found) {
-		/* find a free pipe by taking away a secondary dpp pipe from an
-		 * MPCC combine in current context
-		 */
-		for (i = 0; i < pool->pipe_count; i++) {
-			cur_sec = &cur_res_ctx->pipe_ctx[i];
-			new_sec = &new_res_ctx->pipe_ctx[i];
-
-			if (cur_sec->plane_state &&
-					cur_sec->bottom_pipe &&
-					cur_sec->bottom_pipe->plane_state == cur_sec->plane_state &&
-					new_sec->plane_state == NULL &&
-					new_sec->stream == NULL) {
-				found = true;
-				new_sec->pipe_idx = i;
-				break;
-			}
+	return idle_pipe_idx;
+}
+
+int resource_find_idle_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool)
+{
+	int idle_pipe_idx = IDLE_PIPE_INDEX_NOT_FOUND;
+	const struct pipe_ctx *new_sec_dpp, *cur_sec_dpp;
+	int i;
+
+	for (i = 0; i < pool->pipe_count; i++) {
+		cur_sec_dpp = &cur_res_ctx->pipe_ctx[i];
+		new_sec_dpp = &new_res_ctx->pipe_ctx[i];
+
+		if (cur_sec_dpp->plane_state &&
+				cur_sec_dpp->top_pipe &&
+				cur_sec_dpp->top_pipe->plane_state == cur_sec_dpp->plane_state &&
+				new_sec_dpp->plane_state == NULL &&
+				new_sec_dpp->stream == NULL) {
+			idle_pipe_idx = i;
+			break;
 		}
 	}
 
-	if (!found) {
-		/* find any pipe not used by new state */
-		for (i = 0; i < pool->pipe_count; i++) {
-			new_sec = &new_res_ctx->pipe_ctx[i];
+	return idle_pipe_idx;
+}
 
-			if (new_sec->plane_state == NULL) {
-				found = true;
-				new_sec->pipe_idx = i;
-				break;
-			}
+int resource_find_any_idle_pipe(struct resource_context *new_res_ctx,
+		const struct resource_pool *pool)
+{
+	int idle_pipe_idx = IDLE_PIPE_INDEX_NOT_FOUND;
+	const struct pipe_ctx *new_sec_dpp;
+	int i;
+
+	for (i = 0; i < pool->pipe_count; i++) {
+		new_sec_dpp = &new_res_ctx->pipe_ctx[i];
+
+		if (new_sec_dpp->plane_state == NULL &&
+				new_sec_dpp->stream == NULL) {
+			idle_pipe_idx = i;
+			break;
 		}
 	}
 
-	return found ? new_sec : NULL;
+	return idle_pipe_idx;
 }
 
 /* TODO: Unify the pipe naming convention:
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index fd6511da2903..2615a89d580b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2485,18 +2485,100 @@ struct resource_pool *dcn32_create_resource_pool(
 	return NULL;
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
+static int find_optimal_idle_pipe_as_secondary_dpp_pipe(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *new_opp_head)
+{
+	const struct pipe_ctx *cur_opp_head;
+	int idle_pipe_idx;
+
+	cur_opp_head = &cur_res_ctx->pipe_ctx[new_opp_head->pipe_idx];
+	idle_pipe_idx = resource_find_idle_pipe_used_in_cur_mpc_blending_tree(
+			cur_res_ctx, new_res_ctx, cur_opp_head);
+
+	/* Up until here if we have not found an idle secondary pipe, we will
+	 * need to wait for at least one frame to complete the transition
+	 * sequence.
+	 */
+	if (idle_pipe_idx == IDLE_PIPE_INDEX_NOT_FOUND)
+		idle_pipe_idx = recource_find_idle_pipe_not_used_in_cur_res_ctx(
+				cur_res_ctx, new_res_ctx, pool);
+
+	/* Up until here if we have not found an idle secondary pipe, we will
+	 * need to wait for at least two frames to complete the transition
+	 * sequence. It really doesn't matter which pipe we decide take from
+	 * current enabled pipes. It won't save our frame time when we swap only
+	 * one pipe or more pipes.
+	 */
+	if (idle_pipe_idx == IDLE_PIPE_INDEX_NOT_FOUND)
+		idle_pipe_idx = resource_find_idle_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
+				cur_res_ctx, new_res_ctx, pool);
+
+	if (idle_pipe_idx == IDLE_PIPE_INDEX_NOT_FOUND)
+		idle_pipe_idx = resource_find_any_idle_pipe(new_res_ctx, pool);
+
+	return idle_pipe_idx;
+}
+
 struct pipe_ctx *dcn32_acquire_idle_pipe_for_layer(
 		const struct dc_state *cur_ctx,
 		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
 		const struct pipe_ctx *opp_head_pipe)
 {
-	struct pipe_ctx *idle_pipe =
+	int idle_pipe_idx =
 			find_optimal_idle_pipe_as_secondary_dpp_pipe(
 					&cur_ctx->res_ctx, &new_ctx->res_ctx,
 					pool, opp_head_pipe);
+	struct pipe_ctx *idle_pipe;
 
-	if (idle_pipe) {
+	if (idle_pipe_idx >= 0) {
+		idle_pipe = &new_ctx->res_ctx.pipe_ctx[idle_pipe_idx];
+		idle_pipe->pipe_idx = idle_pipe_idx;
 		idle_pipe->stream = opp_head_pipe->stream;
 		idle_pipe->stream_res.tg = opp_head_pipe->stream_res.tg;
 		idle_pipe->stream_res.opp = opp_head_pipe->stream_res.opp;
@@ -2508,6 +2590,7 @@ struct pipe_ctx *dcn32_acquire_idle_pipe_for_layer(
 				pool->dpps[idle_pipe->pipe_idx]->inst;
 	} else {
 		ASSERT(opp_head_pipe);
+		idle_pipe = NULL;
 	}
 
 	return idle_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 6ac6680711ff..c518ee8b1a03 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -37,6 +37,7 @@
 #define IS_PIPE_SYNCD_VALID(pipe) ((((pipe)->pipe_idx_syncd) & 0x80)?1:0)
 #define GET_PIPE_SYNCD_FROM_PIPE(pipe) ((pipe)->pipe_idx_syncd & 0x7F)
 #define SET_PIPE_SYNCD_TO_PIPE(pipe, pipe_syncd) ((pipe)->pipe_idx_syncd = (0x80 | pipe_syncd))
+#define IDLE_PIPE_INDEX_NOT_FOUND -1
 
 enum dce_version resource_parse_asic_id(
 		struct hw_asic_id asic_id);
@@ -158,11 +159,23 @@ struct pipe_ctx *find_idle_secondary_pipe_legacy(
 		const struct resource_pool *pool,
 		const struct pipe_ctx *primary_pipe);
 
-struct pipe_ctx *find_optimal_idle_pipe_as_secondary_dpp_pipe(
+int resource_find_idle_pipe_used_in_cur_mpc_blending_tree(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
-		const struct resource_pool *pool,
-		const struct pipe_ctx *new_pri);
+		const struct pipe_ctx *cur_opp_head);
+
+int recource_find_idle_pipe_not_used_in_cur_res_ctx(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool);
+
+int resource_find_idle_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool);
+
+int resource_find_any_idle_pipe(struct resource_context *new_res_ctx,
+		const struct resource_pool *pool);
 
 bool resource_validate_attach_surfaces(
 		const struct dc_validation_set set[],
-- 
2.25.1

