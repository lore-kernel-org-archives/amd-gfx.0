Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB95FCD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E9E310ECD9;
	Wed,  6 May 2026 07:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F+igmTm/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F1610ECD9
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv5VcLWWGOvgHaKllFObj4T2bxk2dbV3f9xEBPDp7fyZRCjGBefzcpgcX1aVmHGponJRGuXUJFi3WV+JMIJns5nZGR4Ce9CsfZf4UxEyfiM2UeMDFSvPgaHp8ZKA2bvRdWlkpdd1+QKJbd2H/Sda3s7MIsAM69k/jCLqo5k1SG4hWAmK4Oi5jR5kmvaUF7HgMF5pLbtbI4sE21DaVelyj6oEf+a4N4fQDwF6PqROci77viL+kYzotkNz1cm/dMzOnXgQBsJz3BKLZ/aBfFWMZPoNYYjdLzFNutp9NZWqeIqcq+8CM/0NEnbbgvpKeZjXgwbZwLc9kTGHm9QA00Ik9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T62Pdz07HheczJwZc3atlQFpTEI28Y4Dxj5zF+QlFK4=;
 b=e6kFPl9ZozqAmQTSYX6ag3VLM0pHp5iLXwMKbYjbk1L3dR1G7tF3AeZdGmJ3Caum/9Le5pdd/IVk1ZDBZJwtvmtarDA3oM10JmlJPHyMAgx7dwAYhlGjoNtFdHIiQqx06ehWPJWJZpvDiTkrobooTdDaebRf73P99ySr1PGJxmy9oiRYU7jKSunbbB2/UStS00M3FUsyBz8J4CBb//SO3R9TJ4/JGdKDejxjtXUWoLpjQJRWUrJNpvHw20cXgSfFXWz/DgD5L7YwhmbrlnzPfqkY6A8hQFwx/RhSz3lghbSHD35fzLYnjxlikpc7e9Od/RngNw7mXmrYAJ3T6MpYxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T62Pdz07HheczJwZc3atlQFpTEI28Y4Dxj5zF+QlFK4=;
 b=F+igmTm/3QnKfWUQIaeZd2ejWrU1E+CtNcgvxI+AJRZVcd39Y11jYp/q13PUy+978nI3ChoMn3KX7UOQJWTpB+N154lemEn6LdIrOrO7pe++X692dQxW7SqyHGlG9tQDlIUEOZJyB+HPPeH+JGphQrl1MeTEYD37qT+VZdsunmc=
Received: from BLAPR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:32b::11)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:03:55 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::5a) by BLAPR03CA0006.outlook.office365.com
 (2603:10b6:208:32b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 07:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:03:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:03:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:03:53 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:03:45 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 06/20] drm/amd/display: Fix multiple compiler warnings
Date: Wed, 6 May 2026 12:31:04 +0800
Message-ID: <20260506043342.2164710-7-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: a73353b6-218e-4b0f-aca5-08deab3da30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003|22082099003|20052099010;
X-Microsoft-Antispam-Message-Info: wmblYu4d/FxLCzy7VouMjK9fvn5qogBSSZW6UXTxWUlNQBuYp0Hytl8mjD/0mYE5K86J302velCSksrj/VPtZyym0DKvve7vMQGIINA8oFyLARjcbh8uIGr6z+Q1z2j/k/uc7GI0auClY3p2emOVSNXKgMpAtqiRe/UadXq6CWw6v6VV/VfB7EBuehXNSyxQKr95Zi0NfoSzB5XgSnser0hWEjES22z/fzMseNI673WQ35UHXLi26sXSl2IQp66/5tJk785b7nc/i2LTjQGobGxt+wpPVBlUU3qQECk/jzvFtJHdimO9QXJVyeyxvUwKZcw7jIrub/Rlrt3BTu4+zfJcbmZtmh+/YkMw/kBW+NmziT+F2HDFMUJPMF4D5ez3QwaQUZzRuk4sokDKz9yuM7+qdLrArp07nDitCu3LWk66qyxq3zWolPamful/oc5M+eSacl1kPJjOWlb78Rw3B5kxELDnkUirPd/niGmsC42ICK8NHn2TDJbuvRGRF/IHO6w7TKZcmO180VvGebH45tukat5Z0KfXh5hayUiTgD3qbCOKKnvnWZ6EJNApaH4R5Z/eh/1JXsma/j1xOn86x8Xy3pCyM8Zi0fCge/bX7PXPgLHagXMJxN82Z6KO+duCVAfdNi+quBLhFJjic+6mqelRZ6/p3PG7BW+M0mCz4H/Gy70xNGO8lQs0wkUUKEGQm6AqCktsZINEOg8YxlvLd34PpxbuGz3DGfIO1SX4afs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003)(20052099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6UF6lA6W3Ub9yxV/ZJz3hBgwJItejhNo6aVoT8Rc7fAOp3Fs046Izp8vFrOyR0nksgd/rpYAlKKvlt4oANEi/3qmgPYIMIpcUPukuPxDGgPfuJpJJ2HHEy2tSHk6Hn9hx9oxxH8tO6gfHGQfAC1CxMkuIM8My1V3AdlFtDpTZUe4tK6uCGWddMz3s9jNBmyGuUoeBaPRi4WX3Hh5Tv98LJPUqphfCWQhVBF79nmMd6q/jxqkpGAGbq7BCvHqEDT/dtPWMa6Ms9EXYBRdWoem/JuzyQeYKrakjOKPCc1pX6do8h7FLX/wIg5ZoK/qDUSvwvxT+AbPJt1ddYAdnmr9uLQVgNm8/10peZdzJl8uFcDKHhGupZbzmwmSJH7wWqByldfUh2AXPGBHHlr0HzujngVd5gsF1+MQBGsL0HBUq7EasGnp6UQw7dr8O0ICYH3M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:03:54.9565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a73353b6-218e-4b0f-aca5-08deab3da30b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
Unreachable Code;
Copy Constructor Deleted;
Local Declaration Hides Parameter;
Local Declaration Hides Outer Scope;
Uninitialized or Suspicious Memory Use.

[How]
- Removed or refactored unreachable code paths
- Ensured proper copy constructors in C++ classes
- Renamed local variables that shadowed function parameters
- Renamed inner loop/block variables to avoid shadowing outer scope
  Fixed in 8 files across several FPU layers
  Also fixed in color_gamma and cs_funcs modules
- Reordered guard conditions to validate pipe type before accessing stream
- Ensures safe memory access patterns in DC DMUB service layer

All changes maintain backward compatibility and preserve functional behavior.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  8 +++---
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  6 ++--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  4 +--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  3 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |  8 +++---
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  4 +--
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 10 +++----
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 13 +++++----
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  | 10 +++----
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    | 10 +++----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  4 +--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  3 ++
 .../amd/display/modules/color/color_gamma.c   | 28 +++++++++----------
 13 files changed, 57 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1e178becf949..0e9ea06d7297 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4976,7 +4976,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (!pipe_ctx->top_pipe &&
 			!pipe_ctx->prev_odm_pipe &&
 			should_update_pipe_for_stream(context, pipe_ctx, stream)) {
-			struct dc_stream_status *stream_status = NULL;
+			struct dc_stream_status *pipe_stream_status = NULL;
 
 			if (!pipe_ctx->plane_state)
 				continue;
@@ -4985,12 +4985,12 @@ static void commit_planes_for_stream(struct dc *dc,
 			if (update_type == UPDATE_TYPE_FAST)
 				continue;
 
-			stream_status =
+			pipe_stream_status =
 				stream_get_status(context, pipe_ctx->stream);
 
-			if (dc->hwss.apply_ctx_for_surface && stream_status)
+			if (dc->hwss.apply_ctx_for_surface && pipe_stream_status)
 				dc->hwss.apply_ctx_for_surface(
-					dc, pipe_ctx->stream, stream_status->plane_count, context);
+					dc, pipe_ctx->stream, pipe_stream_status->plane_count, context);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 0cc26f750586..1f183ae85a3f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -218,13 +218,13 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 		}
 
 		if (dc->caps.dcmode_power_limits_present) {
-			bool status;
+			bool dc_power_status;
 
 			DC_FP_START();
-			status = dml2_create(dc, &dc->dml2_dc_power_options, &state->bw_ctx.dml2_dc_power_source);
+			dc_power_status = dml2_create(dc, &dc->dml2_dc_power_options, &state->bw_ctx.dml2_dc_power_source);
 			DC_FP_END();
 
-			if (!status) {
+			if (!dc_power_status) {
 				dc_state_release(state);
 				return NULL;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 438e6415db6d..d4c32c945606 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -602,7 +602,7 @@ bool dc_stream_add_writeback(struct dc *dc,
 
 	if (dc->hwss.enable_writeback) {
 		struct dc_stream_status *stream_status = dc_stream_get_status(stream);
-		struct dwbc *dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
+		dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
 		if (stream_status)
 			dwb->otg_inst = stream_status->primary_otg_inst;
 	}
@@ -614,7 +614,7 @@ bool dc_stream_add_writeback(struct dc *dc,
 
 	/* enable writeback */
 	if (dc->hwss.enable_writeback) {
-		struct dwbc *dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
+		dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
 
 		if (dwb->funcs->is_enabled(dwb)) {
 			/* writeback pipe already enabled, only need to update */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index af487fa0db03..ea0210216d9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -488,12 +488,11 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	for (i = 0, k = 0; context && i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (!resource_is_pipe_type(pipe, OTG_MASTER))
+		if (!resource_is_pipe_type(pipe, OTG_MASTER) || !pipe->stream)
 			continue;
 
 		stream_status = dc_state_get_stream_status(context, pipe->stream);
 		if (stream_status && stream_status->fpo_in_use) {
-			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 			uint8_t min_refresh_in_hz;
 
 			min_refresh_in_hz = (uint8_t)((pipe->stream->timing.min_refresh_in_uhz + 999999) / 1000000);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index df23ced2ff5a..3ff71751db1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -4809,14 +4809,14 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				mode_lib->vba.MaximumReadBandwidthWithoutPrefetch = 0.0;
 				mode_lib->vba.MaximumReadBandwidthWithPrefetch = 0.0;
 				for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
-					unsigned int m;
+					unsigned int cursor_idx;
 
 					locals->cursor_bw[k] = 0;
 					locals->cursor_bw_pre[k] = 0;
-					for (m = 0; m < mode_lib->vba.NumberOfCursors[k]; m++) {
-						locals->cursor_bw[k] = mode_lib->vba.CursorWidth[k][m] * mode_lib->vba.CursorBPP[k][m]
+					for (cursor_idx = 0; cursor_idx < mode_lib->vba.NumberOfCursors[k]; cursor_idx++) {
+						locals->cursor_bw[k] = mode_lib->vba.CursorWidth[k][cursor_idx] * mode_lib->vba.CursorBPP[k][cursor_idx]
 							/ 8.0 / (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * mode_lib->vba.VRatio[k];
-						locals->cursor_bw_pre[k] = mode_lib->vba.CursorWidth[k][m] * mode_lib->vba.CursorBPP[k][m]
+						locals->cursor_bw_pre[k] = mode_lib->vba.CursorWidth[k][cursor_idx] * mode_lib->vba.CursorBPP[k][cursor_idx]
 							/ 8.0 / (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * locals->VRatioPreY[i][j][k];
 					}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 79c567b6806e..0ba388c6aec1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -721,9 +721,9 @@ void dcn3_fpu_build_wm_range_table(struct clk_mgr *base)
 	base->bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_uclk = 0xFFFF;
 }
 
-void patch_dcn30_soc_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *dcn3_0_ip)
+void patch_dcn30_soc_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *soc_bb)
 {
-	(void)dcn3_0_ip;
+	(void)soc_bb;
 	dc_assert_fp_enabled();
 
 	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 29334772408e..2f9ae79da731 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -410,15 +410,15 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		context->bw_ctx.dml.ip.odm_combine_4to1_supported = true;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *cur_pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe->stream)
+		if (!cur_pipe->stream)
 			continue;
 
-		if (pipe->stream->signal == SIGNAL_TYPE_EDP && dc->debug.seamless_boot_odm_combine &&
-				pipe->stream->apply_seamless_boot_optimization) {
+		if (cur_pipe->stream->signal == SIGNAL_TYPE_EDP && dc->debug.seamless_boot_odm_combine &&
+				cur_pipe->stream->apply_seamless_boot_optimization) {
 
-			if (pipe->stream->apply_boot_odm_mode == dm_odm_combine_policy_2to1) {
+			if (cur_pipe->stream->apply_boot_odm_mode == dm_odm_combine_policy_2to1) {
 				context->bw_ctx.dml.vba.ODMCombinePolicy = dm_odm_combine_policy_2to1;
 				break;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index a97e38aa7fed..03e49d298a85 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2216,7 +2216,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 	if (repopulate_pipes) {
 		int flag_max_mpc_comb = vba->maxMpcComb;
 		int flag_vlevel = vlevel;
-		int i;
+		int j;
 
 		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, validate_mode);
 		if (!dc->config.enable_windowed_mpo_odm)
@@ -2231,19 +2231,20 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 					dm_prefetch_support_uclk_fclk_and_stutter_if_possible;
 
 		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+		const int num_states = (int)context->bw_ctx.dml.soc.num_states;
 
-		if (vlevel == context->bw_ctx.dml.soc.num_states) {
+		if (vlevel == num_states) {
 			/* failed after DET size changes */
 			goto validate_fail;
 		} else if (flag_max_mpc_comb == 0 &&
 				flag_max_mpc_comb != context->bw_ctx.dml.vba.maxMpcComb) {
 			/* check the context constructed with pipe split flags is still valid*/
 			bool flags_valid = false;
-			for (i = flag_vlevel; i < (int)context->bw_ctx.dml.soc.num_states; i++) {
-				if (vba->ModeSupport[i][flag_max_mpc_comb]) {
+			for (j = flag_vlevel; j < (int)context->bw_ctx.dml.soc.num_states; j++) {
+				if (vba->ModeSupport[j][flag_max_mpc_comb]) {
 					vba->maxMpcComb = flag_max_mpc_comb;
-					vba->VoltageLevel = i;
-					vlevel = i;
+					vba->VoltageLevel = j;
+					vlevel = j;
 					flags_valid = true;
 					break;
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index bef2b0bcfcf0..c15fbc18bfdf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -551,16 +551,16 @@ int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *cur_pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe->stream)
+		if (!cur_pipe->stream)
 			continue;
 
-		if (pipe->stream->signal == SIGNAL_TYPE_EDP &&
+		if (cur_pipe->stream->signal == SIGNAL_TYPE_EDP &&
 		    dc->debug.seamless_boot_odm_combine &&
-		    pipe->stream->apply_seamless_boot_optimization) {
+		    cur_pipe->stream->apply_seamless_boot_optimization) {
 
-			if (pipe->stream->apply_boot_odm_mode ==
+			if (cur_pipe->stream->apply_boot_odm_mode ==
 			    dm_odm_combine_policy_2to1) {
 				context->bw_ctx.dml.vba.ODMCombinePolicy =
 					dm_odm_combine_policy_2to1;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index 9545d946215b..6552b26de845 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -583,16 +583,16 @@ int dcn351_populate_dml_pipes_from_context_fpu(struct dc *dc,
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *cur_pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe->stream)
+		if (!cur_pipe->stream)
 			continue;
 
-		if (pipe->stream->signal == SIGNAL_TYPE_EDP &&
+		if (cur_pipe->stream->signal == SIGNAL_TYPE_EDP &&
 		    dc->debug.seamless_boot_odm_combine &&
-		    pipe->stream->apply_seamless_boot_optimization) {
+		    cur_pipe->stream->apply_seamless_boot_optimization) {
 
-			if (pipe->stream->apply_boot_odm_mode ==
+			if (cur_pipe->stream->apply_boot_odm_mode ==
 			    dm_odm_combine_policy_2to1) {
 				context->bw_ctx.dml.vba.ODMCombinePolicy =
 					dm_odm_combine_policy_2to1;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 169f34ea75b1..2c2fa320df40 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3636,8 +3636,8 @@ void dcn10_update_pending_status(struct pipe_ctx *pipe_ctx)
 
 	if (dc->hwseq->wa_state.disallow_self_refresh_during_multi_plane_transition_applied) {
 		struct dce_hwseq *hwseq = dc->hwseq;
-		struct timing_generator *tg = dc->res_pool->timing_generators[0];
-		unsigned int cur_frame = tg->funcs->get_frame_count(tg);
+		struct timing_generator *wa_tg = dc->res_pool->timing_generators[0];
+		unsigned int cur_frame = wa_tg->funcs->get_frame_count(wa_tg);
 
 		if (cur_frame != hwseq->wa_state.disallow_self_refresh_during_multi_plane_transition_applied_on_frame) {
 			struct hubbub *hubbub = dc->res_pool->hubbub;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 55a672b4e886..204f11b784bb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1952,6 +1952,9 @@ void dcn401_perform_3dlut_wa_unlock(struct pipe_ctx *pipe_ctx)
 	 * This is meant to work around a known HW issue where VREADY will cancel the pending 3DLUT_ENABLE signal regardless
 	 * of whether OTG lock is currently being held or not.
 	 */
+	if (!pipe_ctx)
+		return;
+
 	struct pipe_ctx *wa_pipes[MAX_PIPES] = { NULL };
 	struct pipe_ctx *odm_pipe, *mpc_pipe;
 	int i, wa_pipe_ct = 0;
diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index b79ca7a2eedc..2ac01083de88 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -690,7 +690,7 @@ static bool find_software_points(
 static bool build_custom_gamma_mapping_coefficients_worker(
 	const struct dc_gamma *ramp,
 	struct pixel_gamma_point *coeff,
-	const struct hw_x_point *coordinates_x,
+	const struct hw_x_point *hw_coordinates_x,
 	const struct gamma_pixel *axis_x,
 	enum channel_name channel,
 	uint32_t number_of_points)
@@ -712,11 +712,11 @@ static bool build_custom_gamma_mapping_coefficients_worker(
 		struct fixed31_32 right_pos;
 
 		if (channel == CHANNEL_NAME_RED)
-			coord_x = coordinates_x[i].regamma_y_red;
+			coord_x = hw_coordinates_x[i].regamma_y_red;
 		else if (channel == CHANNEL_NAME_GREEN)
-			coord_x = coordinates_x[i].regamma_y_green;
+			coord_x = hw_coordinates_x[i].regamma_y_green;
 		else
-			coord_x = coordinates_x[i].regamma_y_blue;
+			coord_x = hw_coordinates_x[i].regamma_y_blue;
 
 		if (!find_software_points(
 			ramp, axis_x, coord_x, channel,
@@ -1539,11 +1539,11 @@ static void build_evenly_distributed_points(
 }
 
 static inline void copy_rgb_regamma_to_coordinates_x(
-		struct hw_x_point *coordinates_x,
+		struct hw_x_point *hw_coordinates_x,
 		uint32_t hw_points_num,
 		const struct pwl_float_data_ex *rgb_ex)
 {
-	struct hw_x_point *coords = coordinates_x;
+	struct hw_x_point *coords = hw_coordinates_x;
 	uint32_t i = 0;
 	const struct pwl_float_data_ex *rgb_regamma = rgb_ex;
 
@@ -1562,7 +1562,7 @@ static bool calculate_interpolated_hardware_curve(
 	const struct dc_gamma *ramp,
 	struct pixel_gamma_point *coeff128,
 	struct pwl_float_data *rgb_user,
-	const struct hw_x_point *coordinates_x,
+	const struct hw_x_point *hw_coordinates_x,
 	const struct gamma_pixel *axis_x,
 	uint32_t number_of_points,
 	struct dc_transfer_func_distributed_points *tf_pts)
@@ -1575,7 +1575,7 @@ static bool calculate_interpolated_hardware_curve(
 
 	for (i = 0; i < 3; i++) {
 		if (!build_custom_gamma_mapping_coefficients_worker(
-				ramp, coeff128, coordinates_x, axis_x, i,
+				ramp, coeff128, hw_coordinates_x, axis_x, i,
 				number_of_points))
 			return false;
 	}
@@ -1789,14 +1789,14 @@ bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
 	if (input_tf->tf == TRANSFER_FUNCTION_PQ) {
 		/* just copy current rgb_regamma into  tf_pts */
 		struct pwl_float_data_ex *curvePt = curve;
-		int i = 0;
+		int j = 0;
 
-		while (i <= MAX_HW_POINTS) {
-			tf_pts->red[i]   = curvePt->r;
-			tf_pts->green[i] = curvePt->g;
-			tf_pts->blue[i]  = curvePt->b;
+		while (j <= MAX_HW_POINTS) {
+			tf_pts->red[j]   = curvePt->r;
+			tf_pts->green[j] = curvePt->g;
+			tf_pts->blue[j]  = curvePt->b;
 			++curvePt;
-			++i;
+			++j;
 		}
 	} else {
 		// clamps to 0-1
-- 
2.43.0

