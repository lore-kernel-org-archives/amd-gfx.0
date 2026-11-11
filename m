Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F17606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c3FqTMmc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9505D10F8FC;
	Wed, 11 Nov 2026 01:45:41 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF28910F8FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zas2WHw4oQYs86Rv193u6EIF+NBolLKt8e+Xc3f1naBjFYgGQlX+3Ki6tNHHd2QoLiAZ5++mcKFSxaFAdRizPQ0lJr7O7Q/iHttcWW19Fc3G7hVvDiwCQ0eODR0vzk7Qhm5YRHQwyqbvhG+RDtt3jGbf2N/4dTF82mdeF7pTiXKGd07sP4pKklUX6Ayh4ZDmHcyNJU6dgPPiQ5y3+h3ifQahRTq3PVy4kSvj2fPYdrC62Y3yIMVDPT/xifuh7u2fieMoWIapM6ySTyppluaZv55KZqTwngHTsm+hWqklAv8v8ZBg22LORNiPpIs2n/COqZU2y3LJfHMAKEDxFZvIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdUGzZid1BwfYG0rjKzdFGFNKyJEl4qLaEHGL4SgF8g=;
 b=obu8KvTe5G7dliHppdeIWjJJ47ASzIR6JaSTpd1oSl5SUmG1iClvW0l2rbQk3CHEDTmGCIIxZqhDr6qEP8XwbT+UJpeBauYq07Z7gWeVMG0eAO3YEPL+QQbtul+d96RPFWgU11PL5AM1YChRsrhYGany4B2xQ7/bp0bDkw2eFa5YBRLpFi3BCFtGVizBd1i80dRhK2w5RxeqyOL+wY1vWupn1pqIkEsQ4iYaYnb1RrB9e2mIyBGYkQFl3mBFzNMEamTgQFYuhfmsVK/R//e01/IrpkZbrGMGytDtUAI2KB7yZHtWlCD+WHUN6Rgl19n5cGTCxrVvt7TdPMd8R4qO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdUGzZid1BwfYG0rjKzdFGFNKyJEl4qLaEHGL4SgF8g=;
 b=c3FqTMmcXBdFDCHLT5NtKRm1scwtqmI9nnbjXSM1WWZbPcKnUMpR72vCBl3DGJUp18QPsUMSRXOpreqpSu1JCTuz+hkSJ9mBHgfySWPbz/3+lCryahtAnBWrkEMta2PynkznJ3UQEuHWVnJysIPktEMnRNdaOi9AUVfURH/ztD8=
Received: from SJ0PR03CA0194.namprd03.prod.outlook.com (2603:10b6:a03:2ef::19)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:45:31 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::97) by SJ0PR03CA0194.outlook.office365.com
 (2603:10b6:a03:2ef::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Wed,
 11 Nov 2026 01:45:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:45:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:29 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:29 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:45:26 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 70/74] drm/amd/display: Get OPP heads and DPP pipes by stream
 in dc_resource
Date: Wed, 11 Nov 2026 09:29:16 +0800
Message-ID: <20261111014100.3596072-71-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b909fb0-e1d5-4771-e079-08df3f9577fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|6133799003|10067099003|261009221727099003|11063799006|261102123227099003|261026121527099003|261021121427099003|261021123027099003|261009220027099003|56012099006|261009221227099003|261009223027099003|261009223327099003;
X-Microsoft-Antispam-Message-Info: OvCJDWDsX2/92/v70a89Ui6M84bthieCUf4CGGyRKrFsbhjo4SOOPcutWkyusNqgSgOmhg2Q4YapB9x0YePHZ/dIT4l8SujiC+0SXq85EmioMcLFVRCFkJTQE1XyRJd8EhuaOBRUaeJKwWLwYGGENGIaHPkzYQd4esug3t5p5yYWHBlMbBPyW6V8/WpSnrR94Sxd/o1hHj/PUmdhddlMuGyNKmAzUyPhl/tDtDm/8WWKUw+n+WCk3+XVXdbzQah4D2WE8C6M8tkkeav5ZoETj2k/jX142t5ONkYTpBD+Le/m7hD8NbSmYS2CDOMSpSFH7XFUrUojEGYHut2h9DSO9mW34j/JxejrQeWcsuGYUvnYEJ9hyEKGQhZvftCl3Y0G7XoeCtiI9RBWVwoghjX14JYK57/G7yt/4eM3hcRYfmRPpJ8PMdO03xrSYKSnAueAEV69z3QY9803If1aJa4ucY8PiVi8B6WgBIV1z1V3SaR+h4ubCUDEi/MhP2ahGOtGyiZFTGc2Hrc/dHttqvU6pPk565uSebZhHwjMNZByLjtEe4wx/NdjCk809i7rgsWvVg1GMpS4V2SlRb1yXz9F1Hb5Kv1hee+0kE41x7wb3mJ4ezSn5FKAVU87vGxIxQO6DsOwHIp2K9ar7UAtO55b7urz9zVfKB3i4YuV/QIJRT4OCkxFY47OUHsVIfLXxBsHutmDrQQ0t0TahY7Y9+1bHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(261009221727099003)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261009220027099003)(56012099006)(261009221227099003)(261009223027099003)(261009223327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EdC6K5qk1I/fTZ1BdDdMr5J7YcbambXeKmtik3zeV3eDD4uqwvlP9lSbxXlKz/O+6gYyRsq4e7XwYHhiLMhDBCYoREVRrrUQFlc08ymvB7oXH8CXWbns3gkBqid2eDC92kcaBR3YoYyYPHLHoBFrT0/bP5SEG2b1jLLiDBjJXRlCZMtaLOSYB+Mf1LqJ/JaywMRvIMzdIsEXEPovdpTCTIwrxE/kumG7Ir56YRhotd67FYiYpuCzUnyPjwjjkE1scmjQnj0W6yju09TYjCwehj2k9B23ILyoGCY+Fk6FS1CS4TKemLAY8Ywbtht7ULD0Fa++sA/Cm/ekFkPuFphnDQaee2xXVGTJtZC9PgYumrfbgPLKmJnZTDk5sGx/39haWrhmQQ4rc3A2wl6BLgfQab0ks9pdhkw9LR8zDns8mr4L5lhpMKHEjs+QVn2CLHW1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:45:30.4409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b909fb0-e1d5-4771-e079-08df3f9577fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

[Why]
The DC2 builders on dcn401 need every OPP head and DPP pipe of a stream,
across all of its ODM slices. Core2 walked a stream's DPP pipes with
its own helper. Pipe traversal belongs to dc_resource.

[How]
Add resource_get_opp_heads_for_stream and
resource_get_dpp_pipes_for_stream. Both find the OTG master of the
stream; the DPP pipes come slice by slice, in OPP head order. Core2
walks a stream's DPP pipes through dc_resource and drops
core2_next_dpp_pipe.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 32 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   | 27 +++++++++++-----
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 18 +++++++++++
 3 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 2240afde4089..7f770a43e1fe 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2174,6 +2174,38 @@ int resource_get_dpp_pipes_for_opp_head(const struct pipe_ctx *opp_head,
 	return i;
 }
 
+int resource_get_opp_heads_for_stream(const struct dc_stream_state *stream,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *opp_heads[MAX_PIPES])
+{
+	struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(
+			res_ctx, stream);
+
+	if (!otg_master)
+		return 0;
+	return resource_get_opp_heads_for_otg_master(otg_master, res_ctx,
+			opp_heads);
+}
+
+int resource_get_dpp_pipes_for_stream(const struct dc_stream_state *stream,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *dpp_pipes[MAX_PIPES])
+{
+	struct pipe_ctx *opp_heads[MAX_PIPES];
+	struct pipe_ctx *slice_pipes[MAX_PIPES];
+	int opp_head_count = resource_get_opp_heads_for_stream(stream, res_ctx,
+			opp_heads);
+	int i, j, slice_count, count = 0;
+
+	for (i = 0; i < opp_head_count; i++) {
+		slice_count = resource_get_dpp_pipes_for_opp_head(opp_heads[i],
+				res_ctx, slice_pipes);
+		for (j = 0; j < slice_count && count < MAX_PIPES; j++)
+			dpp_pipes[count++] = slice_pipes[j];
+	}
+	return count;
+}
+
 int resource_get_dpp_pipes_for_plane(const struct dc_plane_state *plane,
 		struct resource_context *res_ctx,
 		struct pipe_ctx *dpp_pipes[MAX_PIPES])
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
index 33c52ef9b728..0e92c2e7a4e6 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -61,7 +61,8 @@ static struct pipe_ctx *core2_otg_master(struct dc_state *state)
 		return NULL;
 	for (i = 0; i < MAX_PIPES; i++) {
 		if (state->res_ctx.pipe_ctx[i].stream == state->streams[0] &&
-				!state->res_ctx.pipe_ctx[i].top_pipe)
+				!state->res_ctx.pipe_ctx[i].top_pipe &&
+				!state->res_ctx.pipe_ctx[i].prev_odm_pipe)
 			return &state->res_ctx.pipe_ctx[i];
 	}
 	return NULL;
@@ -160,10 +161,12 @@ static void core2_commit_enable_done(struct pipe_ctx *pipe)
 static void core2_commit_disable_done(struct dc *dc, struct pipe_ctx *pipe)
 {
 	struct dc_link *link = pipe->stream->link;
-	struct pipe_ctx *dpp_pipe;
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	int i, n = resource_get_dpp_pipes_for_stream(pipe->stream,
+			&dc->current_state->res_ctx, dpp_pipes);
 
-	for (dpp_pipe = pipe; dpp_pipe; dpp_pipe = dpp_pipe->bottom_pipe)
-		dpp_pipe->plane_res.hubp->power_gated = true;
+	for (i = 0; i < n; i++)
+		dpp_pipes[i]->plane_res.hubp->power_gated = true;
 	link->link_status.link_active = false;
 	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 	pipe->stream->timing_adjust_pending = true;
@@ -314,11 +317,15 @@ static bool core2_update_state_supported(
  */
 static void core2_update_done(struct dc *dc, struct dc_state *context)
 {
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
 	struct pipe_ctx *pipe;
 	struct dc_plane_state *plane;
 	struct hubp *hubp;
+	int i, n = context->stream_count ? resource_get_dpp_pipes_for_stream(
+			context->streams[0], &context->res_ctx, dpp_pipes) : 0;
 
-	for (pipe = core2_otg_master(context); pipe; pipe = pipe->bottom_pipe) {
+	for (i = 0; i < n; i++) {
+		pipe = dpp_pipes[i];
 		if (!pipe->plane_state || !pipe->plane_res.hubp ||
 				!pipe->stream_res.opp)
 			return;
@@ -341,6 +348,8 @@ static void core2_update_state_execute(
 	struct dc *dc = scratch->dc;
 	struct dc_state *context = scratch->new_context;
 	struct pipe_ctx *pipe = core2_otg_master(context);
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	int i, n;
 
 	/*
 	 * The values DC1 computes into the context before it programs the
@@ -350,9 +359,11 @@ static void core2_update_state_execute(
 		return;
 	if (dc->res_pool->funcs->prepare_mcache_programming)
 		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
-	for (; pipe; pipe = pipe->bottom_pipe)
-		pipe->plane_res.scl_data.lb_params.alpha_en =
-				pipe->plane_state->per_pixel_alpha;
+	n = resource_get_dpp_pipes_for_stream(pipe->stream, &context->res_ctx,
+			dpp_pipes);
+	for (i = 0; i < n; i++)
+		dpp_pipes[i]->plane_res.scl_data.lb_params.alpha_en =
+				dpp_pipes[i]->plane_state->per_pixel_alpha;
 
 	if (core2_build_and_run(dc, DCN_DECL_SEAMLESS_UPDATE, context) != DC_OK) {
 		ASSERT(false);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index fbd874476aaf..5dc6173b3948 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -427,6 +427,24 @@ int resource_get_dpp_pipes_for_opp_head(const struct pipe_ctx *opp_head,
 		struct resource_context *res_ctx,
 		struct pipe_ctx *dpp_pipes[MAX_PIPES]);
 
+/*
+ * Get an array of OPP heads in opp_heads ordered with index low to high for
+ * the OTG master of stream in res_ctx.
+ * return - number of OPP heads in the array, 0 if stream has no OTG master.
+ */
+int resource_get_opp_heads_for_stream(const struct dc_stream_state *stream,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *opp_heads[MAX_PIPES]);
+
+/*
+ * Get an array of DPP pipes in dpp_pipes for stream in res_ctx, ODM slice by
+ * slice, each slice top pipe first.
+ * return - number of DPP pipes in the array, 0 if stream has no OTG master.
+ */
+int resource_get_dpp_pipes_for_stream(const struct dc_stream_state *stream,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *dpp_pipes[MAX_PIPES]);
+
 /*
  * Get an array of DPP pipes in dpp_pipes ordered with index low to high for
  * plane in res_ctx.
-- 
2.43.0

