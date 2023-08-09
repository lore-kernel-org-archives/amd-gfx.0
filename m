Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB91C0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAFF910E45B;
	Wed,  9 Aug 2023 15:08:55 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6541010E45A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6U5Rns+4tMA8gwe8D7ePVWf9UJlG37uS2437zqd+b/6Wbqwzlb8CwBaO1yh0gJ4H/lVr8svx/CDj4IA6FgbzV3rW9FvZAhm+pAI+EGQPD0C+Zm4tHDR+pnUN04CqpWaJ04D26BZn5M9eLF5WsYz26C8kKN6miOJ1N14VRX37Y8t2Aknm6+aO/lriHkfGyudOnaHh3eTh00B2foi8l/O/AO8uMqtqFfpQId5rjAOP6Ks8HzHfIMEEoaqTh9AGRlWp7oWjA624qlK8+UFQ5+BDvvGQlOrKfqCA/SIuNpUmD2VnuinGK5qxs0I0mNJtRhtSXKoqlRGb2T3dyjqb7v11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKUNi4zp8OLfoq0wBMoNrfNu3of7zACp/+s6oYmX7tQ=;
 b=UoRrEpJ7IegSMGD+Ys97cvdcmAMAb56raSjaOLET0MhcH+u4cUgXxapSBi7avdr8WQdDYlAf8LK+HuU+OY/VE3semHN8ewlIJTXAm2osH0FU18AA3e4EDHWnL8gsWQA6fI8AS0yZ7+I9d7M0KYzOpKQ9SIWeG00oOKBntnHRmE5MTVV+j1iF3XygebkXopp3MNBJIXHtmjj+fdNr9f5qs/KT3pkzut/DdIRYki+DIDkr4Jgld+zPl8bAO/bEHqnhUKg3bOIYmxkq8rrmx4+bGt8aFiHQGjb1hRAPxoRiwHFOmI/0HkWFmjk+yd7YJVoPOryGVjuxqTwhntJ/P3CMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKUNi4zp8OLfoq0wBMoNrfNu3of7zACp/+s6oYmX7tQ=;
 b=vzP3gxBJ17S/b9CbUosN9qI2ptVK8P/aRiM210YSwE8svvmg/YjlxzJoR65gjjARBKccyJuJF/N5Ouum3ENitg/17TcwqnWyC8A8VruXPsOLNo1XwZT8IzGgR27D3Rv5XZeME287iWom2in9cLCPaC+GznY6eSN0CHX6nwduzas=
Received: from CYZPR02CA0011.namprd02.prod.outlook.com (2603:10b6:930:a1::9)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 15:08:50 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::db) by CYZPR02CA0011.outlook.office365.com
 (2603:10b6:930:a1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 15:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:08:49 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:08:24 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/15] drm/amd/display: implement pipe type definition and
 adding accessors
Date: Wed, 9 Aug 2023 23:05:00 +0800
Message-ID: <20230809150620.1071566-11-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 4018a7c5-e933-4aa7-f11a-08db98ea8986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdyY01aU+O5G304IRUTXjejFFE2Ias6Q+1m2xP06lZiNRMKyX+0vA+C7ykBJpQJVv2rRYN+pX4BQIslFoxB/Rq2zuANg94H1G+0oDliRwZRR2HsZ8C6guLmk8ALFpzUxad61Hk8Tzlc6KwF/8hXbo5GkOUQsbI8nFHCm8XK6p6Au6mVV9UjWWygbdxx3b7hQABYDiv4ocJQfyXqMRiddiVNKZO+aNltkxRDsfGjw+IMqJWTxf7nQ3Z4D+EvO/ohaK3td/n69G8S/gU+EAQvpZBLBi5LxRzrwnyTw6xx/Svb/tep2z6gqHXkbUIIYXSaFHxR9WUsIlxQfFhPz4tJl7Irrg98/cYGg1fN/zbaUzM0KModn17W5Va5r/dy604OS2bb9L3CYEmJmqulizBBiIr/wqg2Rwb31SRBX4nq/wGT2fcCaWOEF/xEFzqvoj8MHeK9xd+Esq9ITu3tTWwYwHv3Z/qvq30axp488GnnKfrhtm89a7vOyEntwjhn1KONbA/AJoYVR29ZCSsDSkA+aJWgb/8Sy4JJiI+5JF5UIrCm0d+1u+jckoyxVIAfnWVTHyRvxbnZr43KcJHwQGFLrP0q9yiHQuwCkiqf2BLLQGfeXbwjOGjZ58VmJy7Vf2a4qk7+pQUWz6lmTf/Yd0PlHjCuOIixlMz4ZfsnFaavskma27YCpzYByfY6C2wlDWaaa0X4ZMIAe2hbq8l51ER+q+9YNJoBJ9sFvm0rX+b2VQtLqBec0zZsk+VxdNrESh3AZf81nltCc9KECmPkDkx7TfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(1800799006)(82310400008)(451199021)(186006)(40470700004)(36840700001)(46966006)(8936002)(83380400001)(30864003)(2906002)(47076005)(40480700001)(41300700001)(40460700003)(5660300002)(44832011)(8676002)(36756003)(36860700001)(426003)(82740400003)(356005)(478600001)(81166007)(54906003)(7696005)(6666004)(86362001)(4326008)(6916009)(1076003)(336012)(316002)(2616005)(70586007)(70206006)(26005)(16526019)(36900700001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:08:49.8898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4018a7c5-e933-4aa7-f11a-08db98ea8986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
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
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There is a lack of encapsulation of pipe connection representation in pipe context.
This has caused many challenging bugs and coding errors with repeated
logic to identify the same pipe type.

[how]
Formally define pipe types and provide getters to identify a pipe type and
find a pipe based on specific requirements. Update existing logic in non dcn
specific files and dcn32 and future versions to use the new accessors.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  41 +---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 186 ++++++++-------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  22 +-
 .../amd/display/dc/dce100/dce100_resource.c   |   2 +-
 .../amd/display/dc/dce110/dce110_resource.c   |   2 +-
 .../amd/display/dc/dce112/dce112_resource.c   |   4 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   6 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  18 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |   4 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  12 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   4 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  12 +-
 .../drm/amd/display/dc/dml/calcs/dce_calcs.c  |   2 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  11 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 220 ++++++++++++++++--
 .../display/dc/link/accessories/link_dp_cts.c |   3 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   7 +-
 19 files changed, 375 insertions(+), 185 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8504e6ee9582..b87422eb7e1a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -586,18 +586,15 @@ dc_stream_forward_crc_window(struct dc_stream_state *stream,
 bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
 			     struct crc_params *crc_window, bool enable, bool continuous)
 {
-	int i;
 	struct pipe_ctx *pipe;
 	struct crc_params param;
 	struct timing_generator *tg;
 
-	for (i = 0; i < MAX_PIPES; i++) {
-		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe->stream == stream && !pipe->top_pipe && !pipe->prev_odm_pipe)
-			break;
-	}
+	pipe = resource_get_otg_master_for_stream(
+			&dc->current_state->res_ctx, stream);
+
 	/* Stream not found */
-	if (i == MAX_PIPES)
+	if (pipe == NULL)
 		return false;
 
 	/* By default, capture the full frame */
@@ -1064,7 +1061,7 @@ static void apply_ctx_interdependent_lock(struct dc *dc,
 
 			// Copied conditions that were previously in dce110_apply_ctx_for_surface
 			if (stream == pipe_ctx->stream) {
-				if (!pipe_ctx->top_pipe &&
+				if (resource_is_pipe_type(pipe_ctx, OPP_HEAD) &&
 					(pipe_ctx->plane_state || old_pipe_ctx->plane_state))
 					dc->hwss.pipe_control_lock(dc, pipe_ctx, lock);
 			}
@@ -3164,7 +3161,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
-		if (!pipe_ctx->top_pipe &&  !pipe_ctx->prev_odm_pipe && pipe_ctx->stream == stream) {
+		if (resource_is_pipe_type(pipe_ctx, OTG_MASTER) && pipe_ctx->stream == stream) {
 
 			if (stream_update->periodic_interrupt && dc->hwss.setup_periodic_interrupt)
 				dc->hwss.setup_periodic_interrupt(dc, pipe_ctx);
@@ -3443,16 +3440,9 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 	struct pipe_ctx *top_pipe_to_program = NULL;
 	dc_z10_restore(dc);
 
-	for (j = 0; j < dc->res_pool->pipe_count; j++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
-
-		if (!pipe_ctx->top_pipe &&
-			!pipe_ctx->prev_odm_pipe &&
-			pipe_ctx->stream &&
-			pipe_ctx->stream == stream) {
-			top_pipe_to_program = pipe_ctx;
-		}
-	}
+	top_pipe_to_program = resource_get_otg_master_for_stream(
+			&context->res_ctx,
+			stream);
 
 	if (dc->debug.visual_confirm) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -3557,16 +3547,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		context_clock_trace(dc, context);
 	}
 
-	for (j = 0; j < dc->res_pool->pipe_count; j++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
-
-		if (!pipe_ctx->top_pipe &&
-			!pipe_ctx->prev_odm_pipe &&
-			pipe_ctx->stream &&
-			pipe_ctx->stream == stream) {
-			top_pipe_to_program = pipe_ctx;
-		}
-	}
+	top_pipe_to_program = resource_get_otg_master_for_stream(
+				&context->res_ctx,
+				stream);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 853e5b99dd62..f7b51aca6020 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -732,10 +732,10 @@ static inline void get_vp_scan_direction(
 		*flip_horz_scan_dir = !*flip_horz_scan_dir;
 }
 
-int get_num_mpc_splits(struct pipe_ctx *pipe)
+int resource_get_num_mpc_splits(const struct pipe_ctx *pipe)
 {
 	int mpc_split_count = 0;
-	struct pipe_ctx *other_pipe = pipe->bottom_pipe;
+	const struct pipe_ctx *other_pipe = pipe->bottom_pipe;
 
 	while (other_pipe && other_pipe->plane_state == pipe->plane_state) {
 		mpc_split_count++;
@@ -750,40 +750,30 @@ int get_num_mpc_splits(struct pipe_ctx *pipe)
 	return mpc_split_count;
 }
 
-int get_num_odm_splits(struct pipe_ctx *pipe)
+int resource_get_num_odm_splits(const struct pipe_ctx *pipe)
 {
 	int odm_split_count = 0;
-	struct pipe_ctx *next_pipe = NULL;
 
-	while (pipe->top_pipe)
-		pipe = pipe->top_pipe;
+	pipe = resource_get_otg_master(pipe);
 
-	next_pipe = pipe->next_odm_pipe;
-	while (next_pipe) {
+	while (pipe->next_odm_pipe) {
 		odm_split_count++;
-		next_pipe = next_pipe->next_odm_pipe;
-	}
-	pipe = pipe->prev_odm_pipe;
-	while (pipe) {
-		odm_split_count++;
-		pipe = pipe->prev_odm_pipe;
+		pipe = pipe->next_odm_pipe;
 	}
 	return odm_split_count;
 }
 
 static int get_odm_split_index(struct pipe_ctx *pipe_ctx)
 {
-	struct pipe_ctx *split_pipe = NULL;
 	int index = 0;
 
-	while (pipe_ctx->top_pipe)
-		pipe_ctx = pipe_ctx->top_pipe;
-
-	split_pipe = pipe_ctx->prev_odm_pipe;
+	pipe_ctx = resource_get_opp_head(pipe_ctx);
+	if (!pipe_ctx)
+		return 0;
 
-	while (split_pipe) {
+	while (pipe_ctx->prev_odm_pipe) {
 		index++;
-		split_pipe = split_pipe->prev_odm_pipe;
+		pipe_ctx = pipe_ctx->prev_odm_pipe;
 	}
 
 	return index;
@@ -854,7 +844,7 @@ static struct rect shift_rec(const struct rect *rec_in, int x, int y)
 static struct rect calculate_odm_slice_in_timing_active(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_stream_state *stream = pipe_ctx->stream;
-	int odm_slice_count = get_num_odm_splits(pipe_ctx) + 1;
+	int odm_slice_count = resource_get_num_odm_splits(pipe_ctx) + 1;
 	int odm_slice_idx = get_odm_split_index(pipe_ctx);
 	bool is_last_odm_slice = (odm_slice_idx + 1) == odm_slice_count;
 	int h_active = stream->timing.h_addressable +
@@ -972,7 +962,7 @@ static struct rect calculate_mpc_slice_in_timing_active(
 		struct rect *plane_clip_rec)
 {
 	const struct dc_stream_state *stream = pipe_ctx->stream;
-	int mpc_slice_count = get_num_mpc_splits(pipe_ctx) + 1;
+	int mpc_slice_count = resource_get_num_mpc_splits(pipe_ctx) + 1;
 	int mpc_slice_idx = get_mpc_split_index(pipe_ctx);
 	int epimo = mpc_slice_count - plane_clip_rec->width % mpc_slice_count - 1;
 	struct rect mpc_rec;
@@ -1565,7 +1555,7 @@ enum dc_status resource_build_scaling_params_for_context(
 	return DC_OK;
 }
 
-struct pipe_ctx *find_free_secondary_pipe_legacy(
+struct pipe_ctx *resource_find_free_secondary_pipe_legacy(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
 		const struct pipe_ctx *primary_pipe)
@@ -1631,7 +1621,7 @@ int resource_find_free_pipe_used_in_cur_mpc_blending_tree(
 		const struct pipe_ctx *cur_opp_head)
 {
 	const struct pipe_ctx *cur_sec_dpp = cur_opp_head->bottom_pipe;
-	struct pipe_ctx *new_sec_dpp;
+	struct pipe_ctx *new_pipe;
 	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
 
 	while (cur_sec_dpp) {
@@ -1639,9 +1629,8 @@ int resource_find_free_pipe_used_in_cur_mpc_blending_tree(
 		 * this is to avoid MPO pipe switching to different opp blending
 		 * tree
 		 */
-		new_sec_dpp = &new_res_ctx->pipe_ctx[cur_sec_dpp->pipe_idx];
-		if (new_sec_dpp->plane_state == NULL &&
-				new_sec_dpp->stream == NULL) {
+		new_pipe = &new_res_ctx->pipe_ctx[cur_sec_dpp->pipe_idx];
+		if (resource_is_pipe_type(new_pipe, FREE_PIPE)) {
 			free_pipe_idx = cur_sec_dpp->pipe_idx;
 			break;
 		}
@@ -1657,17 +1646,15 @@ int recource_find_free_pipe_not_used_in_cur_res_ctx(
 		const struct resource_pool *pool)
 {
 	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
-	const struct pipe_ctx *new_sec_dpp, *cur_sec_dpp;
+	const struct pipe_ctx *new_pipe, *cur_pipe;
 	int i;
 
 	for (i = 0; i < pool->pipe_count; i++) {
-		cur_sec_dpp = &cur_res_ctx->pipe_ctx[i];
-		new_sec_dpp = &new_res_ctx->pipe_ctx[i];
+		cur_pipe = &cur_res_ctx->pipe_ctx[i];
+		new_pipe = &new_res_ctx->pipe_ctx[i];
 
-		if (cur_sec_dpp->plane_state == NULL &&
-				cur_sec_dpp->stream == NULL &&
-				new_sec_dpp->plane_state == NULL &&
-				new_sec_dpp->stream == NULL) {
+		if (resource_is_pipe_type(cur_pipe, FREE_PIPE) &&
+				resource_is_pipe_type(new_pipe, FREE_PIPE)) {
 			free_pipe_idx = i;
 			break;
 		}
@@ -1682,18 +1669,17 @@ int resource_find_free_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
 		const struct resource_pool *pool)
 {
 	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
-	const struct pipe_ctx *new_sec_dpp, *cur_sec_dpp;
+	const struct pipe_ctx *new_pipe, *cur_pipe;
 	int i;
 
 	for (i = 0; i < pool->pipe_count; i++) {
-		cur_sec_dpp = &cur_res_ctx->pipe_ctx[i];
-		new_sec_dpp = &new_res_ctx->pipe_ctx[i];
-
-		if (cur_sec_dpp->plane_state &&
-				cur_sec_dpp->top_pipe &&
-				cur_sec_dpp->top_pipe->plane_state == cur_sec_dpp->plane_state &&
-				new_sec_dpp->plane_state == NULL &&
-				new_sec_dpp->stream == NULL) {
+		cur_pipe = &cur_res_ctx->pipe_ctx[i];
+		new_pipe = &new_res_ctx->pipe_ctx[i];
+
+		if (resource_is_pipe_type(cur_pipe, DPP_PIPE) &&
+				!resource_is_pipe_type(cur_pipe, OPP_HEAD) &&
+				resource_is_for_mpcc_combine(cur_pipe) &&
+				resource_is_pipe_type(new_pipe, FREE_PIPE)) {
 			free_pipe_idx = i;
 			break;
 		}
@@ -1706,14 +1692,13 @@ int resource_find_any_free_pipe(struct resource_context *new_res_ctx,
 		const struct resource_pool *pool)
 {
 	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
-	const struct pipe_ctx *new_sec_dpp;
+	const struct pipe_ctx *new_pipe;
 	int i;
 
 	for (i = 0; i < pool->pipe_count; i++) {
-		new_sec_dpp = &new_res_ctx->pipe_ctx[i];
+		new_pipe = &new_res_ctx->pipe_ctx[i];
 
-		if (new_sec_dpp->plane_state == NULL &&
-				new_sec_dpp->stream == NULL) {
+		if (resource_is_pipe_type(new_pipe, FREE_PIPE)) {
 			free_pipe_idx = i;
 			break;
 		}
@@ -1722,51 +1707,83 @@ int resource_find_any_free_pipe(struct resource_context *new_res_ctx,
 	return free_pipe_idx;
 }
 
-/* TODO: Unify the pipe naming convention:
- *
- * OPP head pipe - the head pipe of an MPC blending tree with a functional OPP
- * feeding to an OTG. OPP head pipe is by convention the top most pipe. i.e.
- * pipe's top_pipe is NULL.
- *
- * OTG master pipe - the master pipe of its OPP head pipes with a functional
- * OTG. It merges all its OPP head pipes pixel data from their MPCs in ODM block
- * and output to backend DIG. OTG master pipe is by convention the top most pipe
- * of the first odm slice. i.e. pipe's top_pipe is NULL and pipe's prev_odm_pipe
- * is NULL.
- *
- * Secondary OPP head pipe - an OPP head pipe which is not an OTG master pipe.
- * Its output feeds to another OTG master pipe. i.e pipe's top_pipe is NULL and
- * pipe's prev_odm_pipe is not NULL.
- *
- * Secondary DPP pipe - the pipe with a functional DPP outputting to another OPP
- * head pipe's MPC. Its output is a secondary layer in the OPP head's MPC
- * blending tree. Secondary DPP pipe is by convention a non top most pipe. i.e
- * pipe's top_pipe should be not NULL.
- *
- * The function below is actually getting the OTG master pipe associated with
- * the stream. Name it as getting head pipe is confusing.
- */
-struct pipe_ctx *resource_get_head_pipe_for_stream(
+bool resource_is_pipe_type(const struct pipe_ctx *pipe_ctx, enum pipe_type type)
+{
+#ifdef DBG
+	if (pipe_ctx->stream == NULL) {
+		/* a free pipe with dangling states */
+		ASSERT(!pipe_ctx->plane_state);
+		ASSERT(!pipe_ctx->prev_odm_pipe);
+		ASSERT(!pipe_ctx->next_odm_pipe);
+		ASSERT(!pipe_ctx->top_pipe);
+		ASSERT(!pipe_ctx->bottom_pipe);
+	} else if (pipe_ctx->top_pipe) {
+		/* a secondary DPP pipe must be signed to a plane */
+		ASSERT(pipe_ctx->plane_state)
+	}
+	/* Add more checks here to prevent corrupted pipe ctx. It is very hard
+	 * to debug this issue afterwards because we can't pinpoint the code
+	 * location causing inconsistent pipe context states.
+	 */
+#endif
+	switch (type) {
+	case OTG_MASTER:
+		return !pipe_ctx->prev_odm_pipe &&
+				!pipe_ctx->top_pipe &&
+				pipe_ctx->stream;
+	case OPP_HEAD:
+		return !pipe_ctx->top_pipe && pipe_ctx->stream;
+	case DPP_PIPE:
+		return pipe_ctx->plane_state && pipe_ctx->stream;
+	case FREE_PIPE:
+		return !pipe_ctx->plane_state && !pipe_ctx->stream;
+	default:
+		return false;
+	}
+}
+
+bool resource_is_for_mpcc_combine(const struct pipe_ctx *pipe_ctx)
+{
+	return resource_get_num_mpc_splits(pipe_ctx) > 0;
+}
+
+struct pipe_ctx *resource_get_otg_master_for_stream(
 		struct resource_context *res_ctx,
 		struct dc_stream_state *stream)
 {
 	int i;
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		if (res_ctx->pipe_ctx[i].stream == stream
-				&& !res_ctx->pipe_ctx[i].top_pipe
-				&& !res_ctx->pipe_ctx[i].prev_odm_pipe)
+		if (res_ctx->pipe_ctx[i].stream == stream &&
+				resource_is_pipe_type(&res_ctx->pipe_ctx[i], OTG_MASTER))
 			return &res_ctx->pipe_ctx[i];
 	}
 	return NULL;
 }
 
+struct pipe_ctx *resource_get_otg_master(const struct pipe_ctx *pipe_ctx)
+{
+	struct pipe_ctx *otg_master = resource_get_opp_head(pipe_ctx);
+
+	while (otg_master->prev_odm_pipe)
+		otg_master = otg_master->prev_odm_pipe;
+	return otg_master;
+}
+
+struct pipe_ctx *resource_get_opp_head(const struct pipe_ctx *pipe_ctx)
+{
+	struct pipe_ctx *opp_head = (struct pipe_ctx *) pipe_ctx;
+
+	ASSERT(!resource_is_pipe_type(opp_head, FREE_PIPE));
+	while (opp_head->top_pipe)
+		opp_head = opp_head->top_pipe;
+	return opp_head;
+}
+
 static struct pipe_ctx *get_tail_pipe(
 		struct pipe_ctx *head_pipe)
 {
-	struct pipe_ctx *tail_pipe;
-
-	tail_pipe = head_pipe->bottom_pipe;
+	struct pipe_ctx *tail_pipe = head_pipe->bottom_pipe;
 
 	while (tail_pipe) {
 		head_pipe = tail_pipe;
@@ -1908,7 +1925,7 @@ bool dc_add_plane_to_context(
 		goto out;
 	}
 
-	otg_master_pipe = resource_get_head_pipe_for_stream(
+	otg_master_pipe = resource_get_otg_master_for_stream(
 			&context->res_ctx, stream);
 	if (otg_master_pipe->plane_state == NULL)
 		added = add_plane_to_opp_head_pipes(otg_master_pipe,
@@ -2429,7 +2446,7 @@ enum dc_status dc_remove_stream_from_ctx(
 {
 	int i;
 	struct dc_context *dc_ctx = dc->ctx;
-	struct pipe_ctx *del_pipe = resource_get_head_pipe_for_stream(&new_ctx->res_ctx, stream);
+	struct pipe_ctx *del_pipe = resource_get_otg_master_for_stream(&new_ctx->res_ctx, stream);
 	struct pipe_ctx *odm_pipe;
 
 	if (!del_pipe) {
@@ -3683,7 +3700,7 @@ enum dc_status resource_map_clock_resources(
 {
 	/* acquire new resources */
 	const struct resource_pool *pool = dc->res_pool;
-	struct pipe_ctx *pipe_ctx = resource_get_head_pipe_for_stream(
+	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(
 				&context->res_ctx, stream);
 
 	if (!pipe_ctx)
@@ -4073,10 +4090,7 @@ void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
 		pipe_ctx_old =	&dc->current_state->res_ctx.pipe_ctx[i];
 		pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe_ctx_old->stream)
-			continue;
-
-		if (pipe_ctx_old->top_pipe || pipe_ctx_old->prev_odm_pipe)
+		if (!resource_is_pipe_type(pipe_ctx_old, OTG_MASTER))
 			continue;
 
 		if (!pipe_ctx->stream ||
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 8c75f7510880..e854a47d9fa4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -31,6 +31,7 @@
 #include "core_types.h"
 #include "../basics/conversion.h"
 #include "cursor_reg_cache.h"
+#include "resource.h"
 
 #define CTX dc_dmub_srv->ctx
 #define DC_LOGGER CTX->logger
@@ -356,7 +357,7 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	for (i = 0, k = 0; context && i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe->top_pipe && !pipe->prev_odm_pipe && pipe->stream && pipe->stream->fpo_in_use) {
+		if (resource_is_pipe_type(pipe, OTG_MASTER) && pipe->stream->fpo_in_use) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 			uint8_t min_refresh_in_hz = (pipe->stream->timing.min_refresh_in_uhz + 999999) / 1000000;
 
@@ -531,7 +532,8 @@ static void populate_subvp_cmd_vblank_pipe_info(struct dc *dc,
 
 		// We check for master pipe, but it shouldn't matter since we only need
 		// the pipe for timing info (stream should be same for any pipe splits)
-		if (!pipe->stream || !pipe->plane_state || pipe->top_pipe || pipe->prev_odm_pipe)
+		if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
+				!resource_is_pipe_type(pipe, DPP_PIPE))
 			continue;
 
 		// Find the SubVP pipe
@@ -728,12 +730,10 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe->stream)
-			continue;
-
 		/* For SubVP pipe count, only count the top most (ODM / MPC) pipe
 		 */
-		if (pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe &&
+		if (resource_is_pipe_type(pipe, OTG_MASTER) &&
+				resource_is_pipe_type(pipe, DPP_PIPE) &&
 				pipe->stream->mall_stream_config.type == SUBVP_MAIN)
 			subvp_pipes[subvp_count++] = pipe;
 	}
@@ -750,12 +750,14 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 			 * Any ODM or MPC splits being used in SubVP will be handled internally in
 			 * populate_subvp_cmd_pipe_info
 			 */
-			if (pipe->plane_state && pipe->stream->mall_stream_config.paired_stream &&
-					!pipe->top_pipe && !pipe->prev_odm_pipe &&
+			if (resource_is_pipe_type(pipe, OTG_MASTER) &&
+					resource_is_pipe_type(pipe, DPP_PIPE) &&
+					pipe->stream->mall_stream_config.paired_stream &&
 					pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 				populate_subvp_cmd_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
-			} else if (pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_NONE &&
-				    !pipe->top_pipe && !pipe->prev_odm_pipe) {
+			} else if (resource_is_pipe_type(pipe, OTG_MASTER) &&
+					resource_is_pipe_type(pipe, DPP_PIPE) &&
+					pipe->stream->mall_stream_config.type == SUBVP_NONE) {
 				// Don't need to check for ActiveDRAMClockChangeMargin < 0, not valid in cases where
 				// we run through DML without calculating "natural" P-state support
 				populate_subvp_cmd_vblank_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index 42e9b6a529f6..899b25b0bad8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -824,7 +824,7 @@ static enum dc_status build_mapped_resource(
 		struct dc_state *context,
 		struct dc_stream_state *stream)
 {
-	struct pipe_ctx *pipe_ctx = resource_get_head_pipe_for_stream(&context->res_ctx, stream);
+	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
 
 	if (!pipe_ctx)
 		return DC_ERROR_UNEXPECTED;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index c0214da714d4..1289b9418877 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -942,7 +942,7 @@ static enum dc_status build_mapped_resource(
 		struct dc_state *context,
 		struct dc_stream_state *stream)
 {
-	struct pipe_ctx *pipe_ctx = resource_get_head_pipe_for_stream(&context->res_ctx, stream);
+	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
 
 	if (!pipe_ctx)
 		return DC_ERROR_UNEXPECTED;
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index e115ff91aaaa..2b20180f1a32 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -873,7 +873,7 @@ static enum dc_status build_mapped_resource(
 		struct dc_state *context,
 		struct dc_stream_state *stream)
 {
-	struct pipe_ctx *pipe_ctx = resource_get_head_pipe_for_stream(&context->res_ctx, stream);
+	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
 
 	if (!pipe_ctx)
 		return DC_ERROR_UNEXPECTED;
@@ -964,7 +964,7 @@ enum dc_status resource_map_phy_clock_resources(
 {
 
 	/* acquire new resources */
-	struct pipe_ctx *pipe_ctx = resource_get_head_pipe_for_stream(
+	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(
 			&context->res_ctx, stream);
 
 	if (!pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 82e5af4d5d15..9f9145742f14 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1055,7 +1055,7 @@ static enum dc_status build_mapped_resource(
 		struct dc_state *context,
 		struct dc_stream_state *stream)
 {
-	struct pipe_ctx *pipe_ctx = resource_get_head_pipe_for_stream(&context->res_ctx, stream);
+	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
 
 	if (!pipe_ctx)
 		return DC_ERROR_UNEXPECTED;
@@ -1090,8 +1090,8 @@ static struct pipe_ctx *dcn10_acquire_free_pipe_for_layer(
 		const struct pipe_ctx *opp_head_pipe)
 {
 	struct resource_context *res_ctx = &new_ctx->res_ctx;
-	struct pipe_ctx *head_pipe = resource_get_head_pipe_for_stream(res_ctx, opp_head_pipe->stream);
-	struct pipe_ctx *idle_pipe = find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
+	struct pipe_ctx *head_pipe = resource_get_otg_master_for_stream(res_ctx, opp_head_pipe->stream);
+	struct pipe_ctx *idle_pipe = resource_find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
 	if (!head_pipe) {
 		ASSERT(0);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index efa600e46194..66b74bb5d936 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1294,7 +1294,7 @@ static enum dc_status build_pipe_hw_param(struct pipe_ctx *pipe_ctx)
 enum dc_status dcn20_build_mapped_resource(const struct dc *dc, struct dc_state *context, struct dc_stream_state *stream)
 {
 	enum dc_status status = DC_OK;
-	struct pipe_ctx *pipe_ctx = resource_get_head_pipe_for_stream(&context->res_ctx, stream);
+	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
 
 	if (!pipe_ctx)
 		return DC_ERROR_UNEXPECTED;
@@ -1948,7 +1948,7 @@ int dcn20_validate_apply_pipe_split_flags(
 			v->ODMCombineEnablePerState[vlevel][pipe_plane];
 
 		if (v->ODMCombineEnabled[pipe_plane] == dm_odm_combine_mode_disabled) {
-			if (get_num_mpc_splits(pipe) == 1) {
+			if (resource_get_num_mpc_splits(pipe) == 1) {
 				/*If need split for mpc but 2 way split already*/
 				if (split[i] == 4)
 					split[i] = 2; /* 2 -> 4 MPC */
@@ -1956,7 +1956,7 @@ int dcn20_validate_apply_pipe_split_flags(
 					split[i] = 0; /* 2 -> 2 MPC */
 				else if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state)
 					merge[i] = true; /* 2 -> 1 MPC */
-			} else if (get_num_mpc_splits(pipe) == 3) {
+			} else if (resource_get_num_mpc_splits(pipe) == 3) {
 				/*If need split for mpc but 4 way split already*/
 				if (split[i] == 2 && ((pipe->top_pipe && !pipe->top_pipe->top_pipe)
 						|| !pipe->bottom_pipe)) {
@@ -1965,7 +1965,7 @@ int dcn20_validate_apply_pipe_split_flags(
 						pipe->top_pipe->plane_state == pipe->plane_state)
 					merge[i] = true; /* 4 -> 1 MPC */
 				split[i] = 0;
-			} else if (get_num_odm_splits(pipe)) {
+			} else if (resource_get_num_odm_splits(pipe)) {
 				/* ODM -> MPC transition */
 				if (pipe->prev_odm_pipe) {
 					split[i] = 0;
@@ -1973,7 +1973,7 @@ int dcn20_validate_apply_pipe_split_flags(
 				}
 			}
 		} else {
-			if (get_num_odm_splits(pipe) == 1) {
+			if (resource_get_num_odm_splits(pipe) == 1) {
 				/*If need split for odm but 2 way split already*/
 				if (split[i] == 4)
 					split[i] = 2; /* 2 -> 4 ODM */
@@ -1983,7 +1983,7 @@ int dcn20_validate_apply_pipe_split_flags(
 					ASSERT(0); /* NOT expected yet */
 					merge[i] = true; /* exit ODM */
 				}
-			} else if (get_num_odm_splits(pipe) == 3) {
+			} else if (resource_get_num_odm_splits(pipe) == 3) {
 				/*If need split for odm but 4 way split already*/
 				if (split[i] == 2 && ((pipe->prev_odm_pipe && !pipe->prev_odm_pipe->prev_odm_pipe)
 						|| !pipe->next_odm_pipe)) {
@@ -1993,7 +1993,7 @@ int dcn20_validate_apply_pipe_split_flags(
 					merge[i] = true; /* exit ODM */
 				}
 				split[i] = 0;
-			} else if (get_num_mpc_splits(pipe)) {
+			} else if (resource_get_num_mpc_splits(pipe)) {
 				/* MPC -> ODM transition */
 				ASSERT(0); /* NOT expected yet */
 				if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state) {
@@ -2154,8 +2154,8 @@ struct pipe_ctx *dcn20_acquire_free_pipe_for_layer(
 		const struct pipe_ctx *opp_head)
 {
 	struct resource_context *res_ctx = &new_ctx->res_ctx;
-	struct pipe_ctx *otg_master = resource_get_head_pipe_for_stream(res_ctx, opp_head->stream);
-	struct pipe_ctx *sec_dpp_pipe = find_free_secondary_pipe_legacy(res_ctx, pool, otg_master);
+	struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(res_ctx, opp_head->stream);
+	struct pipe_ctx *sec_dpp_pipe = resource_find_free_secondary_pipe_legacy(res_ctx, pool, otg_master);
 
 	ASSERT(otg_master);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index 4fce3485d0f5..2dc4d2c1410b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -999,8 +999,8 @@ static struct pipe_ctx *dcn201_acquire_free_pipe_for_layer(
 		const struct pipe_ctx *opp_head_pipe)
 {
 	struct resource_context *res_ctx = &new_ctx->res_ctx;
-	struct pipe_ctx *head_pipe = resource_get_head_pipe_for_stream(res_ctx, opp_head_pipe->stream);
-	struct pipe_ctx *idle_pipe = find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
+	struct pipe_ctx *head_pipe = resource_get_otg_master_for_stream(res_ctx, opp_head_pipe->stream);
+	struct pipe_ctx *idle_pipe = resource_find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
 	if (!head_pipe)
 		ASSERT(0);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index a87afb796f47..680e7fa8d18a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -567,7 +567,7 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
 	bool ret = false;
 
 	/* program OGAM or 3DLUT only for the top pipe*/
-	if (pipe_ctx->top_pipe == NULL) {
+	if (resource_is_pipe_type(pipe_ctx, OPP_HEAD)) {
 		/*program shaper and 3dlut in MPC*/
 		ret = dcn32_set_mpc_shaper_3dlut(pipe_ctx, stream);
 		if (ret == false && mpc->funcs->set_output_gamma && stream->out_transfer_func) {
@@ -1202,10 +1202,10 @@ void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
-		if (pipe->top_pipe || pipe->prev_odm_pipe)
+		if (!resource_is_pipe_type(pipe, OTG_MASTER))
 			continue;
 
-		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))
+		if ((pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))
 			&& pipe->stream->mall_stream_config.type != SUBVP_PHANTOM) {
 			pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
 			reset_sync_context_for_pipe(dc, context, i);
@@ -1299,7 +1299,7 @@ static void apply_symclk_on_tx_off_wa(struct dc_link *link)
 	if (link->phy_state.symclk_ref_cnts.otg > 0) {
 		for (i = 0; i < MAX_PIPES; i++) {
 			pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx->stream && pipe_ctx->stream->link == link && pipe_ctx->top_pipe == NULL) {
+			if (resource_is_pipe_type(pipe_ctx, OPP_HEAD) && pipe_ctx->stream->link == link) {
 				pipe_ctx->clock_source->funcs->program_pix_clk(
 						pipe_ctx->clock_source,
 						&pipe_ctx->stream_res.pix_clk_params,
@@ -1382,7 +1382,7 @@ void dcn32_apply_update_flags_for_phantom(struct pipe_ctx *phantom_pipe)
 {
 	phantom_pipe->update_flags.raw = 0;
 	if (phantom_pipe->stream && phantom_pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
-		if (phantom_pipe->stream && phantom_pipe->plane_state) {
+		if (resource_is_pipe_type(phantom_pipe, DPP_PIPE)) {
 			phantom_pipe->update_flags.bits.enable = 1;
 			phantom_pipe->update_flags.bits.mpcc = 1;
 			phantom_pipe->update_flags.bits.dppclk = 1;
@@ -1392,7 +1392,7 @@ void dcn32_apply_update_flags_for_phantom(struct pipe_ctx *phantom_pipe)
 			phantom_pipe->update_flags.bits.scaler = 1;
 			phantom_pipe->update_flags.bits.viewport = 1;
 			phantom_pipe->update_flags.bits.det_size = 1;
-			if (!phantom_pipe->top_pipe && !phantom_pipe->prev_odm_pipe) {
+			if (resource_is_pipe_type(phantom_pipe, OTG_MASTER)) {
 				phantom_pipe->update_flags.bits.odm = 1;
 				phantom_pipe->update_flags.bits.global_sync = 1;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index cadbe1dcfbfe..935cd23e6a01 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1709,8 +1709,8 @@ void dcn32_retain_phantom_pipes(struct dc *dc, struct dc_state *context)
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe->top_pipe && !pipe->prev_odm_pipe &&
-				pipe->plane_state && pipe->stream &&
+		if (resource_is_pipe_type(pipe, OTG_MASTER) &&
+				resource_is_pipe_type(pipe, DPP_PIPE) &&
 				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
 			phantom_plane = pipe->plane_state;
 			phantom_stream = pipe->stream;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index db9c55a09d9f..3ad2b48954e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -646,10 +646,8 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe->stream)
-			continue;
-
-		if (pipe->plane_state && !pipe->top_pipe) {
+		if (resource_is_pipe_type(pipe, OPP_HEAD) &&
+				resource_is_pipe_type(pipe, DPP_PIPE)) {
 			if (pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 				subvp_count++;
 
@@ -706,10 +704,8 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe->stream)
-			continue;
-
-		if (pipe->plane_state && !pipe->top_pipe) {
+		if (resource_is_pipe_type(pipe, OPP_HEAD) &&
+				resource_is_pipe_type(pipe, DPP_PIPE)) {
 			if (pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 				subvp_count++;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
index 0100a6053ab6..f2dfa96f9ef5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
@@ -3015,7 +3015,7 @@ static bool all_displays_in_sync(const struct pipe_ctx pipe[],
 	int i, num_active_pipes = 0;
 
 	for (i = 0; i < pipe_count; i++) {
-		if (!pipe[i].stream || pipe[i].top_pipe)
+		if (!resource_is_pipe_type(&pipe[i], OPP_HEAD))
 			continue;
 
 		active_pipes[num_active_pipes++] = &pipe[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index 794d6517e511..50b0434354f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -1258,7 +1258,7 @@ bool dcn_validate_bandwidth(
 						hsplit_pipe->pipe_dlg_param.vblank_end = pipe->pipe_dlg_param.vblank_end;
 					} else {
 						/* pipe not split previously needs split */
-						hsplit_pipe = find_free_secondary_pipe_legacy(&context->res_ctx, pool, pipe);
+						hsplit_pipe = resource_find_free_secondary_pipe_legacy(&context->res_ctx, pool, pipe);
 						ASSERT(hsplit_pipe);
 						split_stream_across_pipes(&context->res_ctx, pool, pipe, hsplit_pipe);
 					}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 8ae5ddbd1b27..8afda5ecc0cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1305,7 +1305,7 @@ int dcn20_populate_dml_pipes_from_context(struct dc *dc,
 		pipes[pipe_cnt].dout.is_virtual = 0;
 		pipes[pipe_cnt].pipe.dest.vtotal_min = res_ctx->pipe_ctx[i].stream->adjust.v_total_min;
 		pipes[pipe_cnt].pipe.dest.vtotal_max = res_ctx->pipe_ctx[i].stream->adjust.v_total_max;
-		switch (get_num_odm_splits(&res_ctx->pipe_ctx[i])) {
+		switch (resource_get_num_odm_splits(&res_ctx->pipe_ctx[i])) {
 		case 1:
 			pipes[pipe_cnt].pipe.dest.odm_combine = dm_odm_combine_mode_2to1;
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 6d60ae0133ee..711d4085b33b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -756,7 +756,7 @@ static bool dcn32_enough_pipes_for_subvp(struct dc *dc, struct dc_state *context
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		// Find the minimum pipe split count for non SubVP pipes
-		if (pipe->stream && !pipe->top_pipe &&
+		if (resource_is_pipe_type(pipe, OPP_HEAD) &&
 		    pipe->stream->mall_stream_config.type == SUBVP_NONE) {
 			split_cnt = 0;
 			while (pipe) {
@@ -886,7 +886,8 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 
 		// We check for master pipe, but it shouldn't matter since we only need
 		// the pipe for timing info (stream should be same for any pipe splits)
-		if (!pipe->stream || !pipe->plane_state || pipe->top_pipe || pipe->prev_odm_pipe)
+		if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
+				!resource_is_pipe_type(pipe, DPP_PIPE))
 			continue;
 
 		// Find the SubVP pipe
@@ -899,7 +900,8 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 		drr_pipe = &context->res_ctx.pipe_ctx[i];
 
 		// We check for master pipe only
-		if (!drr_pipe->stream || !drr_pipe->plane_state || drr_pipe->top_pipe || drr_pipe->prev_odm_pipe)
+		if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
+				!resource_is_pipe_type(pipe, DPP_PIPE))
 			continue;
 
 		if (drr_pipe->stream->mall_stream_config.type == SUBVP_NONE && drr_pipe->stream->ignore_msa_timing_param &&
@@ -980,7 +982,8 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 
 		// We check for master pipe, but it shouldn't matter since we only need
 		// the pipe for timing info (stream should be same for any pipe splits)
-		if (!pipe->stream || !pipe->plane_state || pipe->top_pipe || pipe->prev_odm_pipe)
+		if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
+				!resource_is_pipe_type(pipe, DPP_PIPE))
 			continue;
 
 		if (!found && pipe->stream->mall_stream_config.type == SUBVP_NONE) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 8dabbbc2a7b9..e546b9c506c1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -37,7 +37,6 @@
 #define IS_PIPE_SYNCD_VALID(pipe) ((((pipe)->pipe_idx_syncd) & 0x80)?1:0)
 #define GET_PIPE_SYNCD_FROM_PIPE(pipe) ((pipe)->pipe_idx_syncd & 0x7F)
 #define SET_PIPE_SYNCD_TO_PIPE(pipe, pipe_syncd) ((pipe)->pipe_idx_syncd = (0x80 | pipe_syncd))
-#define FREE_PIPE_INDEX_NOT_FOUND -1
 
 enum dce_version resource_parse_asic_id(
 		struct hw_asic_id asic_id);
@@ -143,10 +142,6 @@ struct clock_source *dc_resource_find_first_free_pll(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool);
 
-struct pipe_ctx *resource_get_head_pipe_for_stream(
-		struct resource_context *res_ctx,
-		struct dc_stream_state *stream);
-
 bool resource_attach_surfaces_to_context(
 		struct dc_plane_state *const *plane_state,
 		int surface_count,
@@ -154,29 +149,232 @@ bool resource_attach_surfaces_to_context(
 		struct dc_state *context,
 		const struct resource_pool *pool);
 
-struct pipe_ctx *find_free_secondary_pipe_legacy(
-		struct resource_context *res_ctx,
-		const struct resource_pool *pool,
-		const struct pipe_ctx *primary_pipe);
+#define FREE_PIPE_INDEX_NOT_FOUND -1
 
+/*
+ * pipe types are identified based on MUXes in DCN front end that are capable
+ * of taking input from one DCN pipeline to another DCN pipeline. The name is
+ * in a form of XXXX_YYYY, where XXXX is the DCN front end hardware block the
+ * pipeline ends with and YYYY is the rendering role that the pipe is in.
+ *
+ * For instance OTG_MASTER is a pipe ending with OTG hardware block in its
+ * pipeline and it is in a role of a master pipe for timing generation.
+ *
+ * For quick reference a diagram of each pipe type's areas of responsibility
+ * for outputting timings on the screen is shown below:
+ *
+ *       Timing Active for Stream 0
+ *        __________________________________________________
+ *       |OTG master 0 (OPP head 0)|OPP head 2 (DPP pipe 2) |
+ *       |             (DPP pipe 0)|                        |
+ *       | Top Plane 0             |                        |
+ *       |           ______________|____                    |
+ *       |          |DPP pipe 1    |DPP |                   |
+ *       |          |              |pipe|                   |
+ *       |          |  Bottom      |3   |                   |
+ *       |          |  Plane 1     |    |                   |
+ *       |          |              |    |                   |
+ *       |          |______________|____|                   |
+ *       |                         |                        |
+ *       |                         |                        |
+ *       | ODM slice 0             | ODM slice 1            |
+ *       |_________________________|________________________|
+ *
+ *       Timing Active for Stream 1
+ *        __________________________________________________
+ *       |OTG master 4 (OPP head 4)                         |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |               Blank Pixel Data                   |
+ *       |              (generated by DPG4)                 |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |                                                  |
+ *       |__________________________________________________|
+ *
+ *       Inter-pipe Relation
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------MPC---------ODM----------- |
+ *       |        |  plane 1    | |         | |             |
+ *       |   1    | ------------- |         | |             |
+ *       |        |  plane 0      | slice 1 | |             |
+ *       |   2    | -------------MPC--------- |             |
+ *       |        |  plane 1    | |           |             |
+ *       |   3    | ------------- |           |             |
+ *       |        |               | blank     |             |
+ *       |   4    |               | ----------------------- |
+ *       |        |               |           |             |
+ *       |   5    |  (FREE)       |           |             |
+ *       |________|_______________|___________|_____________|
+ */
+enum pipe_type {
+	/* free pipe - free pipe is an uninitialized pipe without a stream
+	 * associated with it. It is a free DCN pipe resource. It can be
+	 * acquired as any type of pipe.
+	 */
+	FREE_PIPE,
+
+	/* OTG master pipe - the master pipe of its OPP head pipes with a
+	 * functional OTG. It merges all its OPP head pipes pixel data in ODM
+	 * block and output to backend DIG. OTG master pipe is responsible for
+	 * generating entire crtc timing to backend DIG. An OTG master pipe may
+	 * or may not have a plane. If it has a plane it blends it as the left
+	 * most MPC slice of the top most layer. If it doesn't have a plane it
+	 * can output pixel data from its OPP head pipes' test pattern
+	 * generators (DPG) such as solid black pixel data to blank the screen.
+	 */
+	OTG_MASTER,
+
+	/* OPP head pipe - the head pipe of an MPC blending tree with a
+	 * functional OPP outputting to an OTG. OPP head pipe is responsible for
+	 * processing output pixels in its own ODM slice. It may or may not have
+	 * a plane. If it has a plane it blends it as the top most layer within
+	 * its own ODM slice. If it doesn't have a plane it can output pixel
+	 * data from its DPG such as solid black pixel data to blank the pixel
+	 * data in its own ODM slice. OTG master pipe is also an OPP head pipe
+	 * but with more responsibility.
+	 */
+	OPP_HEAD,
+
+	/* DPP pipe - the pipe with a functional DPP outputting to an OPP head
+	 * pipe's MPC. DPP pipe is responsible for processing pixel data from
+	 * its own MPC slice of a plane. It must be connected to an OPP head
+	 * pipe and it must have a plane associated with it.
+	 */
+	DPP_PIPE,
+};
+
+/*
+ * Determine if the input pipe ctx is of a pipe type.
+ * return - true if pipe ctx is of the input type.
+ */
+bool resource_is_pipe_type(const struct pipe_ctx *pipe_ctx, enum pipe_type type);
+
+/*
+ * Determine if the input pipe ctx is used for rendering a plane with MPCC
+ * combine. MPCC combine is a hardware feature to combine multiple DPP pipes
+ * into a single plane. It is typically used for bypassing pipe bandwidth
+ * limitation for rendering a very large plane or saving power by reducing UCLK
+ * and DPPCLK speeds.
+ *
+ * For instance in the Inter-pipe Relation diagram shown below, both PIPE 0 and
+ * 1 are for MPCC combine for plane 0
+ *
+ *       Inter-pipe Relation
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      |           |             |
+ *       |   0    | -------------MPC----------------------- |
+ *       |        |  plane 0    | |           |             |
+ *       |   1    | ------------- |           |             |
+ *       |________|_______________|___________|_____________|
+ *
+ * return - true if pipe ctx is used for mpcc combine.
+ */
+bool resource_is_for_mpcc_combine(const struct pipe_ctx *pipe_ctx);
+
+/*
+ * Look for a free pipe in new resource context that is used as a secondary DPP
+ * pipe in MPC blending tree associated with input OPP head pipe.
+ *
+ * return - FREE_PIPE_INDEX_NOT_FOUND if free pipe is not found, otherwise
+ * pipe idx of the free pipe
+ */
 int resource_find_free_pipe_used_in_cur_mpc_blending_tree(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
 		const struct pipe_ctx *cur_opp_head);
 
+/*
+ * Look for a free pipe in new resource context that is not used in current
+ * resource context.
+ *
+ * return - FREE_PIPE_INDEX_NOT_FOUND if free pipe is not found, otherwise
+ * pipe idx of the free pipe
+ */
 int recource_find_free_pipe_not_used_in_cur_res_ctx(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
 		const struct resource_pool *pool);
 
+/*
+ * Look for a free pipe in new resource context that is used as a secondary DPP
+ * pipe in any MPCC combine in current resource context.
+ * return - FREE_PIPE_INDEX_NOT_FOUND if free pipe is not found, otherwise
+ * pipe idx of the free pipe
+ */
 int resource_find_free_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
 		const struct resource_pool *pool);
 
+/*
+ * Look for any free pipe in new resource context.
+ * return - FREE_PIPE_INDEX_NOT_FOUND if free pipe is not found, otherwise
+ * pipe idx of the free pipe
+ */
 int resource_find_any_free_pipe(struct resource_context *new_res_ctx,
 		const struct resource_pool *pool);
 
+/*
+ * Legacy find free secondary pipe logic deprecated for newer DCNs as it doesn't
+ * find the most optimal free pipe to prevent from time consuming hardware state
+ * transitions.
+ */
+struct pipe_ctx *resource_find_free_secondary_pipe_legacy(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *primary_pipe);
+
+/*
+ * Get number of MPC "cuts" of the plane associated with the pipe. MPC slice
+ * count is equal to MPC splits + 1. For example if a plane is cut 3 times, it
+ * will have 4 pieces of slice.
+ * return - 0 if pipe is not used for a plane with MPCC combine. otherwise
+ * the number of MPC "cuts" for the plane.
+ */
+int resource_get_num_mpc_splits(const struct pipe_ctx *pipe);
+
+/*
+ * Get number of ODM "cuts" of the timing associated with the pipe. ODM slice
+ * count is equal to ODM splits + 1. For example if a timing is cut 3 times, it
+ * will have 4 pieces of slice.
+ * return - 0 if pipe is not used for ODM combine. otherwise
+ * the number of ODM "cuts" for the timing.
+ */
+int resource_get_num_odm_splits(const struct pipe_ctx *pipe);
+
+/*
+ * Get the OTG master pipe in resource context associated with the stream.
+ * return - NULL if not found. Otherwise the OTG master pipe associated with the
+ * stream.
+ */
+struct pipe_ctx *resource_get_otg_master_for_stream(
+		struct resource_context *res_ctx,
+		struct dc_stream_state *stream);
+
+/*
+ * Get the OTG master pipe for the input pipe context.
+ * return - the OTG master pipe for the input pipe
+ * context.
+ */
+struct pipe_ctx *resource_get_otg_master(const struct pipe_ctx *pipe_ctx);
+
+/*
+ * Get the OPP head pipe for the input pipe context.
+ * return - the OPP head pipe for the input pipe
+ * context.
+ */
+struct pipe_ctx *resource_get_opp_head(const struct pipe_ctx *pipe_ctx);
+
+
 bool resource_validate_attach_surfaces(
 		const struct dc_validation_set set[],
 		int set_count,
@@ -212,10 +410,6 @@ unsigned int resource_pixel_format_to_bpp(enum surface_pixel_format format);
 void get_audio_check(struct audio_info *aud_modes,
 	struct audio_check *aud_chk);
 
-int get_num_mpc_splits(struct pipe_ctx *pipe);
-
-int get_num_odm_splits(struct pipe_ctx *pipe);
-
 bool get_temp_dp_link_res(struct dc_link *link,
 		struct link_resource *link_res,
 		struct dc_link_settings *link_settings);
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index c7e1f2229afd..fe4282771cd0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -675,7 +675,8 @@ bool dp_set_test_pattern(
 		if (pipes[i].stream == NULL)
 			continue;
 
-		if (pipes[i].stream->link == link && !pipes[i].top_pipe && !pipes[i].prev_odm_pipe) {
+		if (resource_is_pipe_type(&pipes[i], OTG_MASTER) &&
+				pipes[i].stream->link == link) {
 			pipe_ctx = &pipes[i];
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 7997936613fc..79aef205598b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -182,11 +182,8 @@ void link_resume(struct dc_link *link)
 static bool is_master_pipe_for_link(const struct dc_link *link,
 		const struct pipe_ctx *pipe)
 {
-	return (pipe->stream &&
-			pipe->stream->link &&
-			pipe->stream->link == link &&
-			pipe->top_pipe == NULL &&
-			pipe->prev_odm_pipe == NULL);
+	return resource_is_pipe_type(pipe, OTG_MASTER) &&
+			pipe->stream->link == link;
 }
 
 /*
-- 
2.41.0

