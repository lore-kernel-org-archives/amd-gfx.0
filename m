Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1F3C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFEBC10EAB4;
	Thu,  6 Jun 2024 21:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tmx34fk1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9EA10EAA9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoJeByMOGcdSmIB/vBpv3IdnnHLm47McxUDutciVAlWjIkak8Zqzd7ec7XTYGaKPDJdtr6A3HQHs5TuPowUZ2REC3Ks43+ce80vesZ0kECX2UA7J+nW9YvRVTR1IN+wmuFez2G1xkPWWx6NTGAPJTWe3lo6AF2hzVa30lIXPwEKzkrJ1q0QSRenvmuRjQB+CHQnmz07TTqsbA29plRMXQv4+n5rGUlH8VRBC0WjtdxFE9lIFE2zsB1dvS1kC17a+1eeNoTxeawIQYz4Q881qAw2TNDH3afTyz1oWsVp0jB65UN/D17zsdVxPX3CsRHsa6rpDNMHk+Xk108+mnRDwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHJiXhIQY/v7LdWGK20/clBRNzQ94sZVjpQj56ixfVo=;
 b=XetD22LMR4ZUYmhgf7513p82pYjSCL2tHmtc/zWlAuRhG7OStw8CAe276ioIiSpFAvKT0bpehgKwz6QibtVO1MaTWJOfuDCVmo/y6irWruvuSZoL2EtLW94yBTPivegp2+8UvxQ3tFBY1kbhRiSZdK+t/XsV/zI06Wbb2gIIawP1n4xIwqRUq7C5WmXD2K9C7XQJcfvL70S1hVrLb+k1DlMdeDfPGYXxJ+DHL8fILXMCrC5Wcck+9QelbhILYzcI1cYPiF7pWPTJ0/gdiW6DVgEhZPRa+BAQ1Csy8PTS2sbrq3Qq4bpsJQ9rx+eLkuZEiHhSqeZGERvIucxqxXUf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHJiXhIQY/v7LdWGK20/clBRNzQ94sZVjpQj56ixfVo=;
 b=Tmx34fk1AS50/L0QxCTXp5vFzgsOC34ZgaV8onnoyTdGxC+8C4O7sGz+teolf63ShmI2CKKXDY78homGtmcEVXU1YYXCasgOD/QSYqrrJZM0fUel6668DM1QqK6BBAmOH0XVwGAsGvjq9GFh8Hw4+k89loEajwg3Fjac3mvaVzI=
Received: from SA9PR13CA0029.namprd13.prod.outlook.com (2603:10b6:806:21::34)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Thu, 6 Jun
 2024 21:02:21 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::9c) by SA9PR13CA0029.outlook.office365.com
 (2603:10b6:806:21::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:16 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:12 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 16/67] drm/amd/display: reduce ODM slice count to initial new
 dc state only when needed
Date: Thu, 6 Jun 2024 16:58:37 -0400
Message-ID: <20240606205928.4050859-17-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 720dbb61-4ed3-416e-394b-08dc866bf276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jhedK/wM109ALyQmT+Z3rcuUreYghAbpmF7G9VIcIC65zvLipJ7Gl4kEYoV8?=
 =?us-ascii?Q?mvLvZuAeiyrgIeSPd+zpMLxXc4WHmA9HJPasPjGTpeXR2GekkPYgHAY8vgZ6?=
 =?us-ascii?Q?aK1vMin7Elri/jaT/7I07fUaMo4+8xYyabc77B5JTbfgc1ub8Sq6qCZWw2GJ?=
 =?us-ascii?Q?jCw3LwYrJqkBVwhCAh2647A3xATSdN0rlDjCt0wWOM1d3LfvTuq63USUcS9i?=
 =?us-ascii?Q?7RbSShd6q2W6+3JG9JhfOI61GsSKCrySuiRr7asC/9v1tC7tPtlv2jm7M26j?=
 =?us-ascii?Q?DoJ1ibFOIy3zuo7ropFzzPRiVwotB1QcAbvbr0E+W/NJwQrQFXoYLQKwMe4Z?=
 =?us-ascii?Q?vFnWcvZqgK+vG4Yv+4QBlU1FtCnnBUgoPtfGCubwhum26hKomVa//v2sbhrs?=
 =?us-ascii?Q?w+RLet2W1B5nAKW8A/XIbwW5qYtwocWE+QI9GVGw663ACk+H+ijYjQpNZmPb?=
 =?us-ascii?Q?hJmeQFvyUtZ2wf27fhjql01WLP1bw3io1D867h5v6a/Pak6iAJJsd7M4be62?=
 =?us-ascii?Q?+7R7tjsGSJLhicKkV5Cdx9SJ2KkeaxjPpaqUcUHKQSxC39ng9CZYvq67e0EH?=
 =?us-ascii?Q?RM3ZKJ3sGFl04s1XyPgfjcVtnmwiqtEfbaF9aT0zEyzKGkWT0h2RF9BWI/qS?=
 =?us-ascii?Q?QMjIk5HUBEu14E4s1HlYy2RS/3oX7TPqCulNISxT9g9aq0MHhNvDPhXSYoPO?=
 =?us-ascii?Q?G7yNJaVKkdYkU7K0MgK9/K8P/x9byr8a1088NPLOnWHcQAOLopnpRuRvhdPc?=
 =?us-ascii?Q?8UNNquJLwgJLSQq9mCHHiCtttCoZR8fWXqTRpWQFB53DTDc6oo+Gi/3/8Ey+?=
 =?us-ascii?Q?xq5NZ6QoQUgBycrVFoaNhpYqlp5sIlRxzsj255Bcdi87ZFEL/FA4os2Rk/Dt?=
 =?us-ascii?Q?KqC+9Eok2r0Pjzm5kAkCURrz/CtH2265qDxerluQd+5xEC16mQmM1c0AqFRK?=
 =?us-ascii?Q?u4Cky4QVjOU5X6vrrTFARTf5ntp0NRkexRHSNsk+f/ag3HqTBOBXU0wLvzTf?=
 =?us-ascii?Q?7efVU+p2y+BuvTa0J3iZQfhol0/9z+tU7zBjxqgoaxNhbyYQ/AxEPfwf+clI?=
 =?us-ascii?Q?Q0RGdYf2TFaHMUYvI8l1BswlEmtM9FbIJzgPRGEq2FTQuIt9bBi7aOzTOquJ?=
 =?us-ascii?Q?D1RUeumstrq1EScHA8kd4LhL8ZbCv6Qt5peKSIFvl8/yMYjC0bQC1Ggh2QBP?=
 =?us-ascii?Q?mPic0GQVNzbM5SlDGquVA2OsQMjDYWggwTkb2YREwM8PXaTjG6i3h3RElIMG?=
 =?us-ascii?Q?uHXWJmmvuW7e/mIaFCY2mbNh9KiybAdeTwA1RHOb0BcZQr8o1ls8P1OjaWgx?=
 =?us-ascii?Q?MGk6Fw0Mqc9Ocri6RLUBdlbSlg0kuSb22pN0ZRTeXT08ulXrXibyCectRxVy?=
 =?us-ascii?Q?Ew984lnvMZT0fi9BNVPmC2A78XHGN3Ny7fIlterzib5fCqT5Cw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:16.6443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 720dbb61-4ed3-416e-394b-08dc866bf276
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647
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
We need to decrease ODM slice when adding or removing planes because MPO
support takes precedence over dynamic ODM combine. However there is a case where
we remove ODM combine even for ODM combine required timing in the initial new
dc state. This is normally okay because ODM will be added back after we pass DML
bandwidth validation. However since we remove ODM combine in the initial new
state, the previous ODM pipe allocation is lost. This may cause the new plane to
take away the original secondary OPP head pipe that is still required in the new
state.

For a timing that requires ODM 2:1 but optimized with ODM 4:1, if we add an MPO
plane, we will not have enough pipe to preserve ODM 4:1. In this case we should
reduce ODM slice count then try to add the MPO plane again. By reducing, we are
gradually remove 1 ODM slice from right most side one at a time until we have
enough free pipes for the new plane. If we remove ODM combine entirely, we could
use the pipe at ODM slice index 1 as a DPP pipe for the new plane. But ODM slice
1 is still needed as the timing requires ODM 2:1. This transition is not
seamless and user will see corruption on the screen.

[how]
Remove single ODM slice one at time until we have enough pipes for a new plane.
Remove previous logic to always remove ODM combine entirely.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 45 +++++++------
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 67 +++++++++++++------
 2 files changed, 71 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 61d6b5b21571..45a719fe884e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2596,6 +2596,17 @@ static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
 	}
 }
 
+static int get_num_of_free_pipes(const struct resource_pool *pool, const struct dc_state *context)
+{
+	int i;
+	int count = 0;
+
+	for (i = 0; i < pool->pipe_count; i++)
+		if (resource_is_pipe_type(&context->res_ctx.pipe_ctx[i], FREE_PIPE))
+			count++;
+	return count;
+}
+
 enum dc_status resource_add_otg_master_for_stream_output(struct dc_state *new_ctx,
 		const struct resource_pool *pool,
 		struct dc_stream_state *stream)
@@ -2729,37 +2740,33 @@ static bool acquire_secondary_dpp_pipes_and_add_plane(
 		struct dc_state *cur_ctx,
 		struct resource_pool *pool)
 {
-	struct pipe_ctx *opp_head_pipe, *sec_pipe, *tail_pipe;
+	struct pipe_ctx *sec_pipe, *tail_pipe;
+	struct pipe_ctx *opp_heads[MAX_PIPES];
+	int opp_head_count;
+	int i;
 
 	if (!pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe) {
 		ASSERT(0);
 		return false;
 	}
 
-	opp_head_pipe = otg_master_pipe;
-	while (opp_head_pipe) {
+	opp_head_count = resource_get_opp_heads_for_otg_master(otg_master_pipe,
+			&new_ctx->res_ctx, opp_heads);
+	if (get_num_of_free_pipes(pool, new_ctx) < opp_head_count)
+		/* not enough free pipes */
+		return false;
+
+	for (i = 0; i < opp_head_count; i++) {
 		sec_pipe = pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe(
 				cur_ctx,
 				new_ctx,
 				pool,
-				opp_head_pipe);
-		if (!sec_pipe) {
-			/* try tearing down MPCC combine */
-			int pipe_idx = acquire_first_split_pipe(
-					&new_ctx->res_ctx, pool,
-					otg_master_pipe->stream);
-
-			if (pipe_idx >= 0)
-				sec_pipe = &new_ctx->res_ctx.pipe_ctx[pipe_idx];
-		}
-
-		if (!sec_pipe)
-			return false;
-
+				opp_heads[i]);
+		ASSERT(sec_pipe);
 		sec_pipe->plane_state = plane_state;
 
 		/* establish pipe relationship */
-		tail_pipe = get_tail_pipe(opp_head_pipe);
+		tail_pipe = get_tail_pipe(opp_heads[i]);
 		tail_pipe->bottom_pipe = sec_pipe;
 		sec_pipe->top_pipe = tail_pipe;
 		sec_pipe->bottom_pipe = NULL;
@@ -2770,8 +2777,6 @@ static bool acquire_secondary_dpp_pipes_and_add_plane(
 		} else {
 			sec_pipe->prev_odm_pipe = NULL;
 		}
-
-		opp_head_pipe = opp_head_pipe->next_odm_pipe;
 	}
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 06b22897137e..c75dcdc20428 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -442,6 +442,19 @@ enum dc_status dc_state_remove_stream(
 	return DC_OK;
 }
 
+static void remove_mpc_combine_for_stream(const struct dc *dc,
+		struct dc_state *new_ctx,
+		const struct dc_state *cur_ctx,
+		struct dc_stream_status *status)
+{
+	int i;
+
+	for (i = 0; i < status->plane_count; i++)
+		resource_update_pipes_for_plane_with_slice_count(
+				new_ctx, cur_ctx, dc->res_pool,
+				status->plane_states[i], 1);
+}
+
 bool dc_state_add_plane(
 		const struct dc *dc,
 		struct dc_stream_state *stream,
@@ -452,8 +465,12 @@ bool dc_state_add_plane(
 	struct pipe_ctx *otg_master_pipe;
 	struct dc_stream_status *stream_status = NULL;
 	bool added = false;
+	int odm_slice_count;
+	int i;
 
 	stream_status = dc_state_get_stream_status(state, stream);
+	otg_master_pipe = resource_get_otg_master_for_stream(
+			&state->res_ctx, stream);
 	if (stream_status == NULL) {
 		dm_error("Existing stream not found; failed to attach surface!\n");
 		goto out;
@@ -461,22 +478,39 @@ bool dc_state_add_plane(
 		dm_error("Surface: can not attach plane_state %p! Maximum is: %d\n",
 				plane_state, MAX_SURFACE_NUM);
 		goto out;
+	} else if (!otg_master_pipe) {
+		goto out;
 	}
 
-	if (stream_status->plane_count == 0 && dc->config.enable_windowed_mpo_odm)
-		/* ODM combine could prevent us from supporting more planes
-		 * we will reset ODM slice count back to 1 when all planes have
-		 * been removed to maximize the amount of planes supported when
-		 * new planes are added.
-		 */
-		resource_update_pipes_for_stream_with_slice_count(
-				state, dc->current_state, dc->res_pool, stream, 1);
+	added = resource_append_dpp_pipes_for_plane_composition(state,
+			dc->current_state, pool, otg_master_pipe, plane_state);
 
-	otg_master_pipe = resource_get_otg_master_for_stream(
-			&state->res_ctx, stream);
-	if (otg_master_pipe)
+	if (!added) {
+		/* try to remove MPC combine to free up pipes */
+		for (i = 0; i < state->stream_count; i++)
+			remove_mpc_combine_for_stream(dc, state,
+					dc->current_state,
+					&state->stream_status[i]);
 		added = resource_append_dpp_pipes_for_plane_composition(state,
-				dc->current_state, pool, otg_master_pipe, plane_state);
+					dc->current_state, pool,
+					otg_master_pipe, plane_state);
+	}
+
+	if (!added) {
+		/* try to decrease ODM slice count gradually to free up pipes */
+		odm_slice_count = resource_get_odm_slice_count(otg_master_pipe);
+		for (i = odm_slice_count - 1; i > 0; i--) {
+			resource_update_pipes_for_stream_with_slice_count(state,
+					dc->current_state, dc->res_pool, stream,
+					i);
+			added = resource_append_dpp_pipes_for_plane_composition(
+					state,
+					dc->current_state, pool,
+					otg_master_pipe, plane_state);
+			if (added)
+				break;
+		}
+	}
 
 	if (added) {
 		stream_status->plane_states[stream_status->plane_count] =
@@ -536,15 +570,6 @@ bool dc_state_remove_plane(
 
 	stream_status->plane_states[stream_status->plane_count] = NULL;
 
-	if (stream_status->plane_count == 0 && dc->config.enable_windowed_mpo_odm)
-		/* ODM combine could prevent us from supporting more planes
-		 * we will reset ODM slice count back to 1 when all planes have
-		 * been removed to maximize the amount of planes supported when
-		 * new planes are added.
-		 */
-		resource_update_pipes_for_stream_with_slice_count(
-				state, dc->current_state, dc->res_pool, stream, 1);
-
 	return true;
 }
 
-- 
2.34.1

