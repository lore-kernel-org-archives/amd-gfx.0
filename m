Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B374C6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41BA410E81F;
	Wed, 14 Sep 2022 03:57:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8321F10E820
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmM2y2yAkqJ6EWAZXWutP/t50/9WM2fDfSOnMmTTs8bPdQ7A0AwUjkqPIU5M/8Ui+ivttE9QJ1shj030tfWZFZ8f/b1bOrOpidbnLMfWROrBkgXI+jc4g43vkCtJBJdU6uwS0GVM3CkiVprZnS2pzSSoX26wxKQQEjL7S0JxnPbkRssMOYb8oeU7kSpAGKW/3y58s+c8bVgirIl36KoOA84Bw8IHk+2zyRGKKL4I0FJ10GRAoViYXeXIcAuMnpWoAlJvQGc3G/Rx+uEuTllOYO7HOYz6MOcbSe8pjC8nlZtGHKR0J/qOi/VfxnBzMdoQUoo6JSl39EEi5VtgqUZGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h6pVgPiRx5GrabnsE98u6Cc4FkKVfixIglBP48aU0Y=;
 b=ataW8w3n3xp+s6ZEGP4Qh4tidJ7JIby2e4E8jDq7Fn7GirbgnwnJaKJ6PIUF9V6DNRpsEfnMyYh9spHb8kRyMnU0xotXoGK1cpvHtE+pZkRohtCfW1rU4udnWKMp+4qRMZm2XS0dTumTqEzyZ1qAsc/jr1XeCjvlq/DW8l5p758iS9GjpyrQj7cl/brGdQ8M3jlhvG/oOblHo91TtfrrWafn7RNyyW+F9KC8MZslId+Q25ZDraI4OxmySAC2McnrcmIVBHi7qm+HBgeqiGZXMHsl29gT+vRLcOv4krEr968Ma5DWcOWqLOrT7vLPlHzxfoqoOzC1Z3paojUlFzJbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h6pVgPiRx5GrabnsE98u6Cc4FkKVfixIglBP48aU0Y=;
 b=u0MwoBodM/FQMfCRUxbEjsIP7yBNNa45+3KJiD2dJyuyU2IuF9p53ySFMnbJqU62UDJHJtck/wVBmsYUpb7nZr80KXZmCsmfUUK3j4Rkaqd0lvFvD8QGH5QkwRPdH+WaIc9LamBx88EuP3+lYxoZ3qpu48JZCeGTi1Y3ZL+5t00=
Received: from BN8PR15CA0002.namprd15.prod.outlook.com (2603:10b6:408:c0::15)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:57:21 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::d6) by BN8PR15CA0002.outlook.office365.com
 (2603:10b6:408:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 03:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:57:21 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:57:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:57:06 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:57:02 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 42/47] drm/amd/display: Do second pass through DML for DET
 calculation
Date: Wed, 14 Sep 2022 11:48:03 +0800
Message-ID: <20220914034808.1093521-43-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 5791a557-932f-432a-70c7-08da960539a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C14Ugd2/F5uJEkhPZuWi9IKG8ZB3umb9dAbbR6vhXYGoCWxTnAVqW1KX5DQZutA8KvkfNIqWrhXMDt0nLRg4rbo08JNanRog5m9GdjJMsH9hCZ3Egp+KMD1p9z0/3brNg1nWld5k6WcIeycmUB7jhgQ/Kwu23ekhqJYm7UMkIkAMXZo285SqWgUbdRcrttSK5vhR22Mx4awOhKklMWljKAE4qZ5Adg65qvTwjdVprWX9u+cnMLrlJkDwQ9RRTJBEy+MSpdUTDuKuG47B/OIkQejAStye7srucchBjubyqn4NVK5vmQtftOXls7JyiaP40L6GiQMjLuAiRTotJOrrJXzix8Y727gvQQaPm+emqn9ZDEMR7rzMAdx2SfRpI8kJRw6Mw0INrqdSnCUgZDeNcLwdJCgZ2M/VZieA+sP9BnzpqenU/FF7bpX4kjntlnc/3U4LITbC7f5hiz0re1FmUND9syVg7nBFvgAWZKm5TX+wzA/+xMasXMi60myiUrivT6307t1bJe9vVIG+8+Q6riaQ9UBqPhQ5DERTjjdRzioYKZ3OViQ91AXMaV3RK4FSgKbi5UWGFsmPC89kfwjemPBP9VIZy2ukRIxpLOonfLlv16ckS2KxsYGosqE12z2gU9hITXVjeMwCNdo51TMdZNzfw81VNgIqBaMKbAdLf2DoHPcz9A3H4eR2mzvbyWO/pybwvbXUNcek40jwbq8za7719NeISN80+4h9yLNlg11IM6579guChnaPhm3k/vAehKSmU65SgU5M4TZK3saN55reSbZuLkbET6f26Bp2Iao=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(426003)(47076005)(336012)(82740400003)(40460700003)(30864003)(86362001)(81166007)(478600001)(41300700001)(82310400005)(2906002)(316002)(356005)(2616005)(83380400001)(186003)(7696005)(1076003)(8936002)(54906003)(26005)(36756003)(6916009)(4326008)(40480700001)(70586007)(8676002)(5660300002)(70206006)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:57:21.1646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5791a557-932f-432a-70c7-08da960539a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
If we find that DML requires pipe split, run through
DML again because the DET allocation per pipe must
be re-assigned.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 26 +-----
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  9 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c | 89 ++++++++++++-------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 14 ++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  5 --
 5 files changed, 76 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index dad174a52449..55198c3878b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1837,12 +1837,6 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 	return out;
 }
 
-
-static bool is_dual_plane(enum surface_pixel_format format)
-{
-	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
-}
-
 int dcn32_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes,
@@ -1852,7 +1846,6 @@ int dcn32_populate_dml_pipes_from_context(
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool subvp_in_use = false;
-	uint8_t is_pipe_split_expected[MAX_PIPES] = {0};
 	int plane_count = 0;
 	struct dc_crtc_timing *timing;
 
@@ -1940,11 +1933,6 @@ int dcn32_populate_dml_pipes_from_context(
 		if (pipe->stream && !pipe->prev_odm_pipe &&
 				(!pipe->top_pipe || pipe->top_pipe->plane_state != pipe->plane_state))
 			++plane_count;
-
-		DC_FP_START();
-		is_pipe_split_expected[i] = dcn32_predict_pipe_split(context, &pipes[pipe_cnt]);
-		DC_FP_END();
-
 		pipe_cnt++;
 	}
 
@@ -1952,19 +1940,7 @@ int dcn32_populate_dml_pipes_from_context(
 	 * the DET available for each pipe). Use the DET override input to maintain our driver
 	 * policy.
 	 */
-	if (pipe_cnt == 1 && !is_pipe_split_expected[0]) {
-		pipes[0].pipe.src.det_size_override = DCN3_2_MAX_DET_SIZE;
-		if (pipe->plane_state && !dc->debug.disable_z9_mpc) {
-			if (!is_dual_plane(pipe->plane_state->format)) {
-				pipes[0].pipe.src.det_size_override = DCN3_2_DEFAULT_DET_SIZE;
-				pipes[0].pipe.src.unbounded_req_mode = true;
-				if (pipe->plane_state->src_rect.width >= 5120 &&
-					pipe->plane_state->src_rect.height >= 2880)
-					pipes[0].pipe.src.det_size_override = 320; // 5K or higher
-			}
-		}
-	} else
-		dcn32_determine_det_override(dc, context, pipes, is_pipe_split_expected);
+	dcn32_set_det_allocations(dc, context, pipes);
 
 	// In general cases we want to keep the dram clock change requirement
 	// (prefer configs that support MCLK switch). Only override to false
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 1039df3f9565..40e9211eec1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -28,6 +28,10 @@
 
 #include "core_types.h"
 
+#define DCN3_2_DEFAULT_DET_SIZE 256
+#define DCN3_2_MAX_DET_SIZE 1152
+#define DCN3_2_MIN_DET_SIZE 128
+#define DCN3_2_MIN_COMPBUF_SIZE_KB 128
 #define DCN3_2_DET_SEG_SIZE 64
 #define DCN3_2_MALL_MBLK_SIZE_BYTES 65536 // 64 * 1024
 #define DCN3_2_MBLK_WIDTH 128
@@ -111,9 +115,10 @@ struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
 
 void dcn32_determine_det_override(struct dc *dc,
 		struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		uint8_t *is_pipe_split_expected);
+		display_e2e_pipe_params_st *pipes);
 
+void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
+	display_e2e_pipe_params_st *pipes);
 /* definitions for run time init of reg offsets */
 
 /* CLK SRC */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 160aefaac173..46ba6eee69ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -28,6 +28,11 @@
 #include "dcn20/dcn20_resource.h"
 #include "dml/dcn32/display_mode_vba_util_32.h"
 
+static bool is_dual_plane(enum surface_pixel_format format)
+{
+	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
+}
+
 /**
  * ********************************************************************************************
  * dcn32_helper_calculate_num_ways_for_subvp: Calculate number of ways needed for SubVP
@@ -239,22 +244,17 @@ bool dcn32_mpo_in_use(struct dc_state *context)
  * If there is a plane that's driven by more than 1 pipe (i.e. pipe split), then the
  * number of DET for that given plane will be split among the pipes driving that plane.
  *
- * The pipe split prediction (is_pipe_split_expected) has to work 100% of the time in
- * order for this function to work properly.
  *
  * High level algorithm:
  * 1. Split total DET among number of streams
  * 2. For each stream, split DET among the planes
- * 3. For each plane, check if pipe split is expected. If yes, split the DET for that plane
- *    among the number of splits we expect (i.e. 2 [2:1] or 4 [4:1])
- *    - NOTE: Make sure not to double count the pipe splits (i.e. the pipes could
- *            already be split in the context).
+ * 3. For each plane, check if there is a pipe split. If yes, split the DET allocation
+ *    among those pipes.
  * 4. Assign the DET override to the DML pipes.
  *
  * @param [in]: dc: Current DC state
  * @param [in]: context: New DC state to be programmed
  * @param [in]: pipes: Array of DML pipes
- * @param [in]: is_pipe_split_expected: Array indicating pipe split prediction for each pipe
  *
  * @return: void
  *
@@ -262,16 +262,13 @@ bool dcn32_mpo_in_use(struct dc_state *context)
  */
 void dcn32_determine_det_override(struct dc *dc,
 		struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		uint8_t *is_pipe_split_expected)
+		display_e2e_pipe_params_st *pipes)
 {
-	uint32_t i, j;
+	uint32_t i, j, k;
 	uint8_t pipe_plane_count, stream_segments, plane_segments, pipe_segments[MAX_PIPES] = {0};
 	uint8_t pipe_counted[MAX_PIPES] = {0};
 	uint8_t pipe_cnt = 0;
 	struct dc_plane_state *current_plane = NULL;
-	struct pipe_ctx *next_odm_pipe = NULL;
-	struct pipe_ctx *bottom_pipe = NULL;
 	uint8_t stream_count = 0;
 
 	for (i = 0; i < context->stream_count; i++) {
@@ -301,32 +298,21 @@ void dcn32_determine_det_override(struct dc *dc,
 					pipe_plane_count++;
 					pipe_counted[j] = 1;
 					current_plane = context->res_ctx.pipe_ctx[j].plane_state;
-					if (is_pipe_split_expected[j] != 0) {
-						pipe_plane_count += is_pipe_split_expected[j];
-
-						next_odm_pipe = context->res_ctx.pipe_ctx[j].next_odm_pipe;
-						bottom_pipe = context->res_ctx.pipe_ctx[j].bottom_pipe;
-
-						/* If pipe already happens to be split in context, mark as already
-						 * counted so we don't double count the pipe split.
-						 */
-						while (next_odm_pipe) {
-							if (next_odm_pipe->plane_state == current_plane) {
-								pipe_counted[next_odm_pipe->pipe_idx] = 1;
-								pipe_segments[next_odm_pipe->pipe_idx] = plane_segments / pipe_plane_count;
-							}
-							next_odm_pipe = next_odm_pipe->next_odm_pipe;
+					for (k = 0; k < dc->res_pool->pipe_count; k++) {
+						if (k != j && context->res_ctx.pipe_ctx[k].stream == context->streams[i] &&
+								context->res_ctx.pipe_ctx[k].plane_state == current_plane) {
+							pipe_plane_count++;
+							pipe_counted[k] = 1;
 						}
+					}
 
-						while (bottom_pipe) {
-							if (bottom_pipe->plane_state == current_plane) {
-								pipe_counted[bottom_pipe->pipe_idx] = 1;
-								pipe_segments[bottom_pipe->pipe_idx] = plane_segments / pipe_plane_count;
-							}
-							bottom_pipe = bottom_pipe->bottom_pipe;
+					pipe_segments[j] = plane_segments / pipe_plane_count;
+					for (k = 0; k < dc->res_pool->pipe_count; k++) {
+						if (k != j && context->res_ctx.pipe_ctx[k].stream == context->streams[i] &&
+								context->res_ctx.pipe_ctx[k].plane_state == current_plane) {
+							pipe_segments[k] = plane_segments / pipe_plane_count;
 						}
 					}
-					pipe_segments[j] = plane_segments / pipe_plane_count;
 				}
 			}
 		}
@@ -342,3 +328,38 @@ void dcn32_determine_det_override(struct dc *dc,
 			pipes[i].pipe.src.det_size_override = 4 * DCN3_2_DET_SEG_SIZE; //DCN3_2_DEFAULT_DET_SIZE
 	}
 }
+
+void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
+	display_e2e_pipe_params_st *pipes)
+{
+	int i, pipe_cnt;
+	struct resource_context *res_ctx = &context->res_ctx;
+	struct pipe_ctx *pipe;
+
+	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+
+		if (!res_ctx->pipe_ctx[i].stream)
+			continue;
+
+		pipe = &res_ctx->pipe_ctx[i];
+		pipe_cnt++;
+	}
+
+	/* For DET allocation, we don't want to use DML policy (not optimal for utilizing all
+	 * the DET available for each pipe). Use the DET override input to maintain our driver
+	 * policy.
+	 */
+	if (pipe_cnt == 1) {
+		pipes[0].pipe.src.det_size_override = DCN3_2_MAX_DET_SIZE;
+		if (pipe->plane_state && !dc->debug.disable_z9_mpc && pipe->plane_state->tiling_info.gfx9.swizzle != DC_SW_LINEAR) {
+			if (!is_dual_plane(pipe->plane_state->format)) {
+				pipes[0].pipe.src.det_size_override = DCN3_2_DEFAULT_DET_SIZE;
+				pipes[0].pipe.src.unbounded_req_mode = true;
+				if (pipe->plane_state->src_rect.width >= 5120 &&
+					pipe->plane_state->src_rect.height >= 2880)
+					pipes[0].pipe.src.det_size_override = 320; // 5K or higher
+			}
+		}
+	} else
+		dcn32_determine_det_override(dc, context, pipes);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b573ab7b81ed..fe0770038a90 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1720,8 +1720,20 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		goto validate_fail;
 	}
 
-	if (repopulate_pipes)
+	if (repopulate_pipes) {
 		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
+
+		/* repopulate_pipes = 1 means the pipes were either split or merged. In this case
+		 * we have to re-calculate the DET allocation and run through DML once more to
+		 * ensure all the params are calculated correctly. We do not need to run the
+		 * pipe split check again after this call (pipes are already split / merged).
+		 * */
+		if (!fast_validate) {
+			context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
+						dm_prefetch_support_uclk_fclk_and_stutter_if_possible;
+			vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+		}
+	}
 	*vlevel_out = vlevel;
 	*pipe_cnt_out = pipe_cnt;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index b43c45adb7d3..732ed7fadb8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -29,11 +29,6 @@
 
 #include "clk_mgr_internal.h"
 
-#define DCN3_2_DEFAULT_DET_SIZE 256
-#define DCN3_2_MAX_DET_SIZE 1152
-#define DCN3_2_MIN_DET_SIZE 128
-#define DCN3_2_MIN_COMPBUF_SIZE_KB 128
-
 void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr);
 
 void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
-- 
2.37.3

