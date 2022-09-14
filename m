Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9609DECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F17610E853;
	Wed, 14 Sep 2022 05:19:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DAD10E852
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ3d+TzfTSQuUyF+UbNp1NF76aQbDsNLZYhLtXDNXwHaJQZRaApYRxYBvHI6dUFQBOvHkYuqTt7LWcmSpz/e7IrInwEJCJisKUCDn3VhtzbGTialPHgZ6uq8VIdFDGXuHXiN+jS7I1Vf13dXieueAOesrUq660QA8A+Dg6RiAU3az1M9vRiyYuTPkf26hKe6YQWSrv28dy1ANJ4hZIgGsSxRTviNHwyMQyXwzykMngfjui0uW4TRWt8GCLkAt63ldxEyW8RlPOYyPWQr13F/Id53teYxu9NY5z9r9DP0SvhOCwjTV9x0QWp1fOPVOl53d3nPXNg+4rO/lnHh4RkVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h6pVgPiRx5GrabnsE98u6Cc4FkKVfixIglBP48aU0Y=;
 b=cq/5NnmMov7JsZQH+NYPF7w3WryeJhdE4p0mbcK0su7GKi4uG7Zd+Knfbg/EiJaHYRLsaQ+GeEzYdnNabcBZruj9r/9wNhd50q0rPo54MwrfHmA3ICWW9NWv1b+eOyaLAemoFYQIDP6dLsq+3NJojHZ+rNSEqUGUG+CCurXem3RSJd9DfSfuIb/swTLv0Fp4kySAUcB/JNKnL07pPqCsyQMZseumSW7Wmp3UeyTBxeWJygMoW+/6wxnJk9+vhMm/sVtg2+lofVGXeN8gJYo+iTi+LaCxMskZtoezkWfa7hd/QG2xcgRAJ+j512WCP25iG6mLulj7XxEO7MAB5tUteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h6pVgPiRx5GrabnsE98u6Cc4FkKVfixIglBP48aU0Y=;
 b=l2hiNncDmHZy8t6Jzo3urO1fINynPk1XSQ8W3UPIWSQc78sANrw1sgfZCAJHfOds8OCTOkUbzZO7n3AvU/TetB1CvSfbAvtkAIgqDQD7++vsiy5EdnHKd9LOS6yjKN22QQQ+l8RPAI9IuDACKByFgB2+kMJSp9YrgccinvJxf6Y=
Received: from BN9PR03CA0913.namprd03.prod.outlook.com (2603:10b6:408:107::18)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 14 Sep
 2022 05:19:00 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::55) by BN9PR03CA0913.outlook.office365.com
 (2603:10b6:408:107::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Wed, 14 Sep 2022 05:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:18:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:18:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:18:56 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:18:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 42/47] drm/amd/display: Do second pass through DML for DET
 calculation
Date: Wed, 14 Sep 2022 13:10:41 +0800
Message-ID: <20220914051046.1131186-43-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 677ad742-33fd-4326-6685-08da9610a175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LQGixeEN5TKJwn37Z9FHBDypHh22Vfi6f9fyb6TgjQwhAd98GqdMyFTqTkFxJQDt5gvxn3Gscyozgs+enJBfVFuiThxMw/fwI14cZR6lKccBpRiij4jDMfF9kTjjekQ6SKaeCM/RA3D2RrgAFJKAe44L0o9SC561w3jQcjq0liBGNf0Q2TCnjqFn3y81KvEg+N+5dth/qRKOwAipw0gw9RmjjLDwOkphaq2hJ0L3M4a/e3nK20qTRUBZvfH8U0YwvIvCetPabpIN4RSAr8Vsl1hwgqFTTYxQLxwYlUxZCrBZAh26Ir52+FI7O8JxFi9CdGuVMKb/oN17ioiQ0cWZVxkR1qJDi3b/dgSG7ojgnamxU5RPI5VESisk/QTdDcX/72tL+RTwGXfvIsY/CM4wdzEYShPMuhWrc2ThP+o1OJ/kW1u8aniQps2M1NO+oCMm3N7g1Zlje+FRO8vxzaowo4tGU7daWAKhqLCRixWJKWLduDXAPgYBdrE9yTp6l6ZqZVNWuvlrJ4jmTYJY3Si2fmg/7f2fVCwaiqpZ7ppg+x1VBc6HcvbvbfbN6qqGOg7JfGqbdd3PwCjp/fHNYyE6RlqoPbNbeNUPE6OeGbHjlepUONe8Zy3J/D3EnTssk5cuZZapSb77jtXMijcBH0+0Xs7AXJPXtheSjtU9qe16wefM9ornZaoTUoVeeWLLsePiSzVidInPyXIf/GnnLEIqwyjR73aEzl+o8OtGLleC5we8AnSnjMAF5bHOq1Vf4tJz3L4gmIWvHyMOZCeYosunSgqfkOzgGnICQlFPBGcrCE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(30864003)(86362001)(7696005)(82740400003)(70586007)(8676002)(26005)(478600001)(1076003)(426003)(82310400005)(70206006)(40480700001)(81166007)(336012)(316002)(8936002)(47076005)(36756003)(40460700003)(4326008)(41300700001)(6916009)(36860700001)(54906003)(356005)(2616005)(186003)(83380400001)(2906002)(6666004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:18:59.8190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 677ad742-33fd-4326-6685-08da9610a175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
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

