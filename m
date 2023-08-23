Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88317EE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 007EB10E46A;
	Wed, 23 Aug 2023 16:04:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1003210E46D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6FoBf81u5RMEiLSHTaSUU3SrjTdBuJc13IcZo0PdBzdrWJkwTmWONpZyURnpnFc1FAeaswrH7V1CJhntXXM/KWPol4sz3mhsKZ6G3LoDHDanviwdiO5AVJY1iOUDcJ+jLeUOSMUNuyE8/GBt/vwob8wFSi53p/3VevmI/n7wQChWZXDOXYjaGMw06dFtt5paP4NbhVLxY+kOI/9iGKaS47SMCSLYrm6JNkpZopCwbPffJx8OxU8056G0Pbm/6rkwqwgaufIk6FxpP3aFjjHjz9HIEqdBtWo/kQJxajFC8rmQMGXENL9vUe8BEMxTn1QuNhCIViURWyx3fCbpYnVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sll7QoNiaCIHgMRiujTlfwNO94CsRyM9BiICiVH4bic=;
 b=MbPmLRiHlLw2sCf1axAiBtIVwTXu1oNDg+z/gEsHzwJeo1iBKTuUQZYAEiAwpTV8r77iEjhPkL4TfqY0LYUBNeJOh1FUgh+vlvtGFzEzQycEMcD13Kpw6KfMCNjdr5SHaz3xufbQ3wAt69T7zEGgnktphqBjZf1pSrrTAoPCNpDHuDgBBtqsQQiN0hkRtXgRCmvP1kvpVlCrSpB9cWKtapLgNJVyyBJZPpmO+G9oKjXVuhYUfwE8+XnqcP/nV++GOg9uqAN9jDUZ5y/dvPTACMOkp7nHtjexTtttukbu1iIxQCnzo8N+zNXWQlahSzeGLzFHOa8T5EKfl9XhAYPMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sll7QoNiaCIHgMRiujTlfwNO94CsRyM9BiICiVH4bic=;
 b=40PGWrEN0vT7wFRVriM+XlXrTghuzB33imLzQraftvB+pjgfIl/6zllj4kxQfav1xcFI9cJ5V1g5iC7zQtpcjAmh5gWmBc3B7icRfL08GZXjWzWNVWrBtoPllpm1aZuFapo0nL2++Khbht4qjguWYGQ6e5WmBVHnsD/2CKLp1zg=
Received: from PA7P264CA0120.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::18)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Wed, 23 Aug 2023 16:04:45 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:34c:cafe::65) by PA7P264CA0120.outlook.office365.com
 (2603:10a6:102:34c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:43 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:34 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/21] drm/amd/display: add pipe topology update log
Date: Wed, 23 Aug 2023 11:58:16 -0400
Message-ID: <20230823160347.176991-15-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6930f834-6fad-4b29-2817-08dba3f2aa61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: To4nqAuyAcQvm/OwAidEgLs05JSnjOn1Fi5gY8OSVmrwyRmd5VnuILDLRT0eYvGIFyl3BXovoKwDSvWZWm6PP4VnBQrzxbnIyXeSM3IzvENYelG+cK64UaqWWCZFddm/VvLo+8vXgBZaObUzE027huufELfiBM1UKCqxp3OwnxGTmnT4Zn997UtCrDnp2aSHiad/fVRXuEH/ZbRuRjUEDIquKJn9F11ZTjMsCPQI3/0aSio2lVeanTvuOfd7UyZkIjpwQwOEj24Tkmy/rCLH+j7COUfEGn+IEkCzBbrZz60zateMaqDGnIevndb9cg113FvkX8ZQoslG1ovsDJpZKvd9u/FqNuGP0XmXo73fDHgGmMrENKKH1WAVkY/QHJci+gvSKONBcncpNxsgMSuCMdIng/K8EU+5q8D/uYWzlZ7bJ/x4vjhLG5CGjNa+NE3HEfk5kt36R/wQnPYdLRx1Vp8lvdRFL2oKCystQwQGfRtZj+nMGv+ZgFWXN1oycM8d2NICTU5NxF/CiVXH1Cy6dKoj7dhIiUto8+9ePFCJ2J7S18YDnxVQyw8bz8N8YY+KRx/CGM2dhZcRx1h1RvJefJbYB/KZfIm7aXGD7Cl3PgfmJK8M2Wjm/ETth08JGYj8IH0ztEqAagcVhfd4fltd8olV6BNyBm7Nn6AIbxa1WxZVo4tNz9TB1Gh1SVWyrXJH5CxBan0jbB8v5CqUGr7m6K47PklkkWhdBXpZb+srFaJrFfEBcDNU1zD44z3P7cJqOLh4dN34DTrtu4JqDn1muTpVJUuidt9nXowtqsfZGG7bZnLMhtzvUXX6G0CIkCi0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(54906003)(6916009)(316002)(70586007)(8936002)(8676002)(4326008)(2616005)(70206006)(1076003)(36756003)(41300700001)(40460700003)(81166007)(356005)(82740400003)(478600001)(6666004)(40480700001)(15650500001)(83380400001)(2906002)(36860700001)(86362001)(47076005)(426003)(44832011)(336012)(5660300002)(16526019)(26005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:43.8339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6930f834-6fad-4b29-2817-08dba3f2aa61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Given an issue with pipe topology transition. It is very hard to tell
the before and after pipe topology without a pipe topology logging. The
change adds such logging to help with visualizing the issue.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 159 ++++++++++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  10 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   7 +
 3 files changed, 168 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 84db7c5fb852..f32337122f5b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1865,6 +1865,165 @@ int resource_get_odm_slice_index(const struct pipe_ctx *pipe_ctx)
 	return index;
 }
 
+bool resource_is_pipe_topology_changed(const struct dc_state *state_a,
+		const struct dc_state *state_b)
+{
+	int i;
+	const struct pipe_ctx *pipe_a, *pipe_b;
+
+	if (state_a->stream_count != state_b->stream_count)
+		return true;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_a = &state_a->res_ctx.pipe_ctx[i];
+		pipe_b = &state_b->res_ctx.pipe_ctx[i];
+
+		if (pipe_a->stream && !pipe_b->stream)
+			return true;
+		else if (!pipe_a->stream && pipe_b->stream)
+			return true;
+
+		if (pipe_a->plane_state && !pipe_b->plane_state)
+			return true;
+		else if (!pipe_a->plane_state && pipe_b->plane_state)
+			return true;
+
+		if (pipe_a->bottom_pipe && pipe_b->bottom_pipe) {
+			if (pipe_a->bottom_pipe->pipe_idx != pipe_b->bottom_pipe->pipe_idx)
+				return true;
+			if ((pipe_a->bottom_pipe->plane_state == pipe_a->plane_state) &&
+					(pipe_b->bottom_pipe->plane_state != pipe_b->plane_state))
+				return true;
+			else if ((pipe_a->bottom_pipe->plane_state != pipe_a->plane_state) &&
+					(pipe_b->bottom_pipe->plane_state == pipe_b->plane_state))
+				return true;
+		} else if (pipe_a->bottom_pipe || pipe_b->bottom_pipe) {
+			return true;
+		}
+
+		if (pipe_a->next_odm_pipe && pipe_b->next_odm_pipe) {
+			if (pipe_a->next_odm_pipe->pipe_idx != pipe_b->next_odm_pipe->pipe_idx)
+				return true;
+		} else if (pipe_a->next_odm_pipe || pipe_b->next_odm_pipe) {
+			return true;
+		}
+	}
+	return false;
+}
+
+/*
+ * Sample log:
+ *    pipe topology update
+ *  ________________________
+ * | plane0  slice0  stream0|
+ * |DPP0----OPP0----OTG0----| <--- case 0 (OTG master pipe with plane)
+ * | plane1 |       |       |
+ * |DPP1----|       |       | <--- case 5 (DPP pipe not in last slice)
+ * | plane0  slice1 |       |
+ * |DPP2----OPP2----|       | <--- case 2 (OPP head pipe with plane)
+ * | plane1 |               |
+ * |DPP3----|               | <--- case 4 (DPP pipe in last slice)
+ * |         slice0  stream1|
+ * |DPG4----OPP4----OTG4----| <--- case 1 (OTG master pipe without plane)
+ * |         slice1 |       |
+ * |DPG5----OPP5----|       | <--- case 3 (OPP head pipe without plane)
+ * |________________________|
+ */
+
+static void resource_log_pipe(struct dc *dc, struct pipe_ctx *pipe,
+		int stream_idx, int slice_idx, int plane_idx, int slice_count,
+		bool is_primary)
+{
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	if (slice_idx == 0 && plane_idx == 0 && is_primary) {
+		/* case 0 (OTG master pipe with plane) */
+		DC_LOG_DC(" | plane%d  slice%d  stream%d|",
+				plane_idx, slice_idx, stream_idx);
+		DC_LOG_DC(" |DPP%d----OPP%d----OTG%d----|",
+				pipe->plane_res.dpp->inst,
+				pipe->stream_res.opp->inst,
+				pipe->stream_res.tg->inst);
+	} else if (slice_idx == 0 && plane_idx == -1) {
+		/* case 1 (OTG master pipe without plane) */
+		DC_LOG_DC(" |         slice%d  stream%d|",
+				slice_idx, stream_idx);
+		DC_LOG_DC(" |DPG%d----OPP%d----OTG%d----|",
+				pipe->stream_res.opp->inst,
+				pipe->stream_res.opp->inst,
+				pipe->stream_res.tg->inst);
+	} else if (slice_idx != 0 && plane_idx == 0 && is_primary) {
+		/* case 2 (OPP head pipe with plane) */
+		DC_LOG_DC(" | plane%d  slice%d |       |",
+				plane_idx, slice_idx);
+		DC_LOG_DC(" |DPP%d----OPP%d----|       |",
+				pipe->plane_res.dpp->inst,
+				pipe->stream_res.opp->inst);
+	} else if (slice_idx != 0 && plane_idx == -1) {
+		/* case 3 (OPP head pipe without plane) */
+		DC_LOG_DC(" |         slice%d |       |", slice_idx);
+		DC_LOG_DC(" |DPG%d----OPP%d----|       |",
+				pipe->plane_res.dpp->inst,
+				pipe->stream_res.opp->inst);
+	} else if (slice_idx == slice_count - 1) {
+		/* case 4 (DPP pipe in last slice) */
+		DC_LOG_DC(" | plane%d |               |", plane_idx);
+		DC_LOG_DC(" |DPP%d----|               |",
+				pipe->plane_res.dpp->inst);
+	} else {
+		/* case 5 (DPP pipe not in last slice) */
+		DC_LOG_DC(" | plane%d |       |       |", plane_idx);
+		DC_LOG_DC(" |DPP%d----|       |       |",
+				pipe->plane_res.dpp->inst);
+	}
+}
+
+void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
+{
+	struct pipe_ctx *otg_master;
+	struct pipe_ctx *opp_heads[MAX_PIPES];
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+
+	int stream_idx, slice_idx, dpp_idx, plane_idx, slice_count, dpp_count;
+	bool is_primary;
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	DC_LOG_DC("    pipe topology update");
+	DC_LOG_DC("  ________________________");
+	for (stream_idx = 0; stream_idx < state->stream_count; stream_idx++) {
+		otg_master = resource_get_otg_master_for_stream(
+				&state->res_ctx, state->streams[stream_idx]);
+		slice_count = resource_get_opp_heads_for_otg_master(otg_master,
+				&state->res_ctx, opp_heads);
+		for (slice_idx = 0; slice_idx < slice_count; slice_idx++) {
+			if (opp_heads[slice_idx]->plane_state) {
+				plane_idx = 0;
+				dpp_count = resource_get_dpp_pipes_for_opp_head(
+						opp_heads[slice_idx],
+						&state->res_ctx,
+						dpp_pipes);
+				for (dpp_idx = 0; dpp_idx < dpp_count; dpp_idx++) {
+					is_primary = !dpp_pipes[dpp_idx]->top_pipe ||
+							dpp_pipes[dpp_idx]->top_pipe->plane_state != dpp_pipes[dpp_idx]->plane_state;
+					resource_log_pipe(dc, dpp_pipes[dpp_idx],
+							stream_idx, slice_idx,
+							plane_idx, slice_count,
+							is_primary);
+					if (is_primary)
+						plane_idx++;
+				}
+			} else {
+				plane_idx = -1;
+				resource_log_pipe(dc, opp_heads[slice_idx],
+						stream_idx, slice_idx, plane_idx,
+						slice_count, true);
+			}
+
+		}
+	}
+	DC_LOG_DC(" |________________________|\n");
+}
+
 static struct pipe_ctx *get_tail_pipe(
 		struct pipe_ctx *head_pipe)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 347156d02f21..dd4c7a7faf28 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1816,14 +1816,8 @@ void dcn20_program_front_end_for_ctx(
 	struct dce_hwseq *hws = dc->hwseq;
 	DC_LOGGER_INIT(dc->ctx->logger);
 
-	/* Carry over GSL groups in case the context is changing. */
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *old_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
-
-		if (pipe_ctx->stream == old_pipe_ctx->stream)
-			pipe_ctx->stream_res.gsl_group = old_pipe_ctx->stream_res.gsl_group;
-	}
+	if (resource_is_pipe_topology_changed(dc->current_state, context))
+		resource_log_pipe_topology_update(dc, context);
 
 	if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 55efd5600521..6777b07d0727 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -437,6 +437,13 @@ int resource_get_odm_slice_count(const struct pipe_ctx *otg_master);
 /* Get the ODM slice index counting from 0 from left most slice */
 int resource_get_odm_slice_index(const struct pipe_ctx *opp_head);
 
+/* determine if pipe topology is changed between state a and state b */
+bool resource_is_pipe_topology_changed(const struct dc_state *state_a,
+		const struct dc_state *state_b);
+
+/* log the pipe topology update in state */
+void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state);
+
 /*
  * Look for a free pipe in new resource context that is used as a secondary OPP
  * head by cur_otg_master.
-- 
2.41.0

