Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5350FEA817
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F70410E79B;
	Wed, 25 Mar 2026 07:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIb5Iyj7";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76DAD10E79F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgN85R/hD4PxBk27B1EbKxi8UAbymZ9ufHkFx5qFDXnSpql7x7ApXHv+0ss5YwixWhqrTE7J9Ujof4sAeesnkXtBoNPQQdjTKkp0YCrZ3TUCuEHEbD2cX2lmHuH46GZYCH3zWjFmb5jGb3f8j5Xyhsh2F1mlnt16jGNwQkBOgqhm0X2Pz2b2wkudNBlhmVmNTnlSmvJgpibOpfOHk4BaHbVLpBdLvsRFNcFXEIAg5EiZAy7ROQGFbr8DUJV5qS7qJfLKzBJIqqNK0iEOeQVE2wfOmkzdKtafTOJnzjcIHW8uWmXmVe2PSEQTTfMqBElAkqjUyZPfPY8XB4/0ZvSmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hHlzaW1WDwmzdEu/m8Y1B2PbCaArVVRdNo2gaeZCv4=;
 b=Ad7+N7l9YxuG78zxPuW4hiLXNW0GaH5f2EIO7Xqf/yQmrxeH0n+gC/n57bTF8ltAOl7JLuBAH/gSp26J9lC3ph8sYMyk13NmdEoPkOm7WzB8HyPLpLuNpM6MBc4Fj8k0IKYBQd7Lm5nJioylCP26kfVwwhv1FbFAnyllw4dlkNFpUjqlwWpy8yCj46iGVd5NT6IThLeevCwJQqg/1G7TKcdyaTIgtvw5ZYWOrQFFYwhWE8s+E6ZlvLpZIi1fVuz06LEcBGvkNnRw69BEN+GYhKkP35cBU9yL8d2x6iAyKFjDmJjBpB4CMdEw/qvJnlXuuxK4b64UZwfEoyzHXzB1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hHlzaW1WDwmzdEu/m8Y1B2PbCaArVVRdNo2gaeZCv4=;
 b=uIb5Iyj7Ckt4mNTxqDOXTf9Ov7yfCgvDUT11luDrclI3Z76RkRjAeLi9us0DTfxXkemGPw638pDI48RB/ljBk3cDFSgBVr9lFahz5zwK96WMS8Nx70FD16AhrRWhDhFF/3BJnFafgBmY9sApxrCq+tUOcz0cDV53TOdh+64uWX4=
Received: from BL1P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::29)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:09:01 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::f3) by BL1P222CA0024.outlook.office365.com
 (2603:10b6:208:2c7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:09:01 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:08:57 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 07/29] drm/amd/display: Don't set 4to1MPC config dynamically
Date: Wed, 25 Mar 2026 15:06:13 +0800
Message-ID: <20260325071003.4022594-8-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 687db672-e9e3-4520-c3f9-08de8a3d6435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: R/EFaiDGYPlVTqeh2EqZlNZ3/BA3ACX5gT4f/NHqWiGmB6jBUCjh/d13pubcDLdU6dNzfcEG0rYF87CdFS5gBJAd4zkAXv7APTCMuRber39XKoGOaqTPZ785S4Ub+kX0mhlkP0tNVWBorxcffNCav44EWLswlWpEoESMwFU6301OmeDy5i8Dh3PpTh0VgVCHOvQGzaSaofFUflVzGuQFus/RkchVc+5w+gmaRSY98xyvc0QVBvO6C2FJlq5wZwZfMc5kZcONKDH+CL3tzNc6zjCQbG+9Ywo+fGAs7Uwd+3S6AgAJcmGIGSKwYQyXSA7XUMHFFrfZp9FM70mvKhccNrWdN6XeSeXp12eS7C+iE8P0JS5Z/sWNb8Ffh+R8wg6R7LPOoeHnvHlnjoiKwUdip6UIyHBjtUrMHmnlRtKFm1X6s7TMBmri5XBK5yydNhHoiPy6mgGqqmfpX/n6gzo2nvqvLg2le/vdssbNhHcPsdhqrhLpZG68L1ONoEf/XtsWK9rT6YFfFoJJYf/LjyzRK16Yaa2e+h5rf6lq9EmzlUlI7dxWAfTn+lDZ4AIj8Nns3LwgXgtFSd7cVaFkkguHT246o797H+Qa+Ibjq45uXCBWMOIJv7H+DGgnZoaK5wKKJY8Jn61b+w+RY7274XqX1qTdrmDKTaoh+4Ay9tBG3A5rTgvsSYJTImLrNgzBfERL3iif8Hdso949eHhV5rBo4CdrFp4Gr+Te4ppWLwreFMBAH7JYfp1v/+5u59GlHQQP1zFleAzEues82sE/KPxxig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fc3Qw4tecnHRxWag08BJWfX6vPYvgLzn0m+Q2wlKLS1pyTJNU5WNp274CoK4rcx6q1En2PYjJAb7Aw6uI9hXtao+gFOrexBoJDdbhu8YJPn6z0mejXekVVRzL8qVBfyqLJqyTWEe+qXRLpBKql8IFp2gfVJyedHxWKDt/4pIHNshi9AWckQhO3/Ys5wVudIOxqHo1+vYQJgoZz7eXtOdqWtrGe1CxRiYIcjZD/lvmXJ3ouqYXfPNz2doX2oHhu6Fy9ozQ1PUxS54oZPSFKuXuJ3HigO4ht26yqE60aCr1NmDWy+Gci+AwkiSJuXNsKbXf4LuWaHDO74ILNfoS4hQzcX3kX4wgSqdObcXgfb2mh1yfDd8xcStiw8s8d2ODmGz/avgKzaYYotnIlJHWsy+RkhjtedBFXZW1iCBXBjeH1Yci74Ud1w3bVRMcEss13Jv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:01.1719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 687db672-e9e3-4520-c3f9-08de8a3d6435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
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

From: Harry Wentland <harry.wentland@amd.com>

We were previously modifying the global dc->config.enable_4to1MPC
dynamically. These variables are meant as global configs, not to
by dynamically modified. Modifying them dynamically prevents us
from enabling/disabling functionality for debug purposes and can
easily lead to bad things since we're not operating on the current
state but on DC-wide variables.

Instead we should look at the existing split4mpc decision in
dcn20_validate_apply_split_flags and make the decision there,
if the global config.enable_4to1MPC is set to true for the
DCN version we're running.

This fixes corruption that is observed when running a new IGT
kms_colorop test for color-space-conversion that uses a
YUV plane and outputs to a writeback connector.

Assisted-by: Claude Sonnet 4.5.
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h              |  2 +-
 .../drm/amd/display/dc/dml/dcn314/dcn314_fpu.c   |  6 +-----
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c |  7 +------
 .../drm/amd/display/dc/dml/dcn351/dcn351_fpu.c   |  7 +------
 .../display/dc/resource/dcn20/dcn20_resource.c   | 16 ++++++++++++++--
 .../display/dc/resource/dcn31/dcn31_resource.c   | 10 +++++-----
 .../display/dc/resource/dcn314/dcn314_resource.c |  3 +++
 .../display/dc/resource/dcn315/dcn315_resource.c |  5 +++--
 .../display/dc/resource/dcn316/dcn316_resource.c |  6 ++++--
 .../display/dc/resource/dcn35/dcn35_resource.c   |  3 +++
 .../display/dc/resource/dcn351/dcn351_resource.c |  3 +++
 11 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 80e217c5a23d..41b5dedb6eff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -521,7 +521,7 @@ struct dc_config {
 	union allow_lttpr_non_transparent_mode allow_lttpr_non_transparent_mode;
 	bool multi_mon_pp_mclk_switch;
 	bool disable_dmcu;
-	bool enable_4to1MPC;
+	bool allow_4to1MPC;
 	bool enable_windowed_mpo_odm;
 	bool forceHBR2CP2520; // Used for switching between test patterns TPS4 and CP2520
 	uint32_t allow_edp_hotplug_detection;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index df9d50b9b57c..ab016c294ba7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -391,13 +391,9 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 	}
 	context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_14_DEFAULT_DET_SIZE;
 
-	dc->config.enable_4to1MPC = false;
 	if (pipe_cnt == 1 && pipe->plane_state
 		&& pipe->plane_state->rotation == ROTATION_ANGLE_0 && !dc->debug.disable_z9_mpc) {
-		if (is_dual_plane(pipe->plane_state->format)
-				&& pipe->plane_state->src_rect.width <= 1920 && pipe->plane_state->src_rect.height <= 1080) {
-			dc->config.enable_4to1MPC = true;
-		} else if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
+		if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
 			/* Limit to 5k max to avoid forced pipe split when there is not enough detile for swath */
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 			pipes[0].pipe.src.unbounded_req_mode = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 8a177d5ae213..6713cd8ba86a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -528,14 +528,9 @@ int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
 	}
 
 	context->bw_ctx.dml.ip.det_buffer_size_kbytes = 384;/*per guide*/
-	dc->config.enable_4to1MPC = false;
 
 	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
-		if (is_dual_plane(pipe->plane_state->format)
-				&& pipe->plane_state->src_rect.width <= 1920 &&
-				pipe->plane_state->src_rect.height <= 1080) {
-			dc->config.enable_4to1MPC = true;
-		} else if (!is_dual_plane(pipe->plane_state->format) &&
+		if (!is_dual_plane(pipe->plane_state->format) &&
 			   pipe->plane_state->src_rect.width <= 5120) {
 			/*
 			 * Limit to 5k max to avoid forced pipe split when there
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index 77023b619f1e..73c2aee57f28 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -561,14 +561,9 @@ int dcn351_populate_dml_pipes_from_context_fpu(struct dc *dc,
 	}
 
 	context->bw_ctx.dml.ip.det_buffer_size_kbytes = 384;/*per guide*/
-	dc->config.enable_4to1MPC = false;
 
 	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
-		if (is_dual_plane(pipe->plane_state->format)
-				&& pipe->plane_state->src_rect.width <= 1920 &&
-				pipe->plane_state->src_rect.height <= 1080) {
-			dc->config.enable_4to1MPC = true;
-		} else if (!is_dual_plane(pipe->plane_state->format) &&
+		if (!is_dual_plane(pipe->plane_state->format) &&
 			   pipe->plane_state->src_rect.width <= 5120) {
 			/*
 			 * Limit to 5k max to avoid forced pipe split when there
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index b28e877fb99d..7d49a6003f03 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1814,6 +1814,11 @@ void dcn20_merge_pipes_for_validate(
 	}
 }
 
+static bool is_dual_plane(enum surface_pixel_format format)
+{
+	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
+}
+
 int dcn20_validate_apply_pipe_split_flags(
 		struct dc *dc,
 		struct dc_state *context,
@@ -1898,8 +1903,15 @@ int dcn20_validate_apply_pipe_split_flags(
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 		int pipe_plane = v->pipe_plane[pipe_idx];
-		bool split4mpc = context->stream_count == 1 && plane_count == 1
-				&& dc->config.enable_4to1MPC && dc->res_pool->pipe_count >= 4;
+		bool split4mpc = false;
+
+		if (context->stream_count == 1 && plane_count == 1
+		    && dc->config.allow_4to1MPC && dc->res_pool->pipe_count >= 4
+		    && !dc->debug.disable_z9_mpc
+		    && pipe->plane_state && is_dual_plane(pipe->plane_state->format)
+		    && pipe->plane_state->src_rect.width <= 1920
+		    && pipe->plane_state->src_rect.height <= 1080)
+				split4mpc = true;
 
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 95c7ecdb3496..6d23d88e400c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1703,12 +1703,9 @@ int dcn31_populate_dml_pipes_from_context(
 		pipe_cnt++;
 	}
 	context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_1_DEFAULT_DET_SIZE;
-	dc->config.enable_4to1MPC = false;
+
 	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
-		if (is_dual_plane(pipe->plane_state->format)
-				&& pipe->plane_state->src_rect.width <= 1920 && pipe->plane_state->src_rect.height <= 1080) {
-			dc->config.enable_4to1MPC = true;
-		} else if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
+		if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
 			/* Limit to 5k max to avoid forced pipe split when there is not enough detile for swath */
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 			pipes[0].pipe.src.unbounded_req_mode = true;
@@ -1926,6 +1923,9 @@ static bool dcn31_resource_construct(
 	dc->caps.is_apu = true;
 	dc->caps.zstate_support = true;
 
+	/* Enable 4to1MPC by default */
+	dc->config.allow_4to1MPC = true;
+
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
 	dc->caps.color.dpp.input_lut_shared = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 803b87986802..7b1f426652be 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1834,6 +1834,9 @@ static bool dcn314_resource_construct(
 	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
+
+	/* Enable 4to1MPC by default */
+	dc->config.allow_4to1MPC = true;
 	dc->caps.max_downscale_ratio = 400;
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 100;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index e488fa6f32e6..10feb64c0010 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1789,11 +1789,9 @@ static int dcn315_populate_dml_pipes_from_context(
 	if (context->bw_ctx.dml.ip.det_buffer_size_kbytes > DCN3_15_MAX_DET_SIZE)
 		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_15_MAX_DET_SIZE;
 
-	dc->config.enable_4to1MPC = false;
 	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
 		if (is_dual_plane(pipe->plane_state->format)
 				&& pipe->plane_state->src_rect.width <= 1920 && pipe->plane_state->src_rect.height <= 1080) {
-			dc->config.enable_4to1MPC = true;
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes =
 					(max_usable_det / DCN3_15_CRB_SEGMENT_SIZE_KB / 4) * DCN3_15_CRB_SEGMENT_SIZE_KB;
 		} else if (!is_dual_plane(pipe->plane_state->format)
@@ -1874,6 +1872,9 @@ static bool dcn315_resource_construct(
 	 *************************************************/
 	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
+
+	/* Enable 4to1MPC by default */
+	dc->config.allow_4to1MPC = true;
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
 	dc->caps.i2c_speed_in_khz = 100;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index fa51a9ae945f..835bedfd6074 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1673,11 +1673,9 @@ static int dcn316_populate_dml_pipes_from_context(
 	if (context->bw_ctx.dml.ip.det_buffer_size_kbytes > DCN3_16_MAX_DET_SIZE)
 		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_16_MAX_DET_SIZE;
 	ASSERT(context->bw_ctx.dml.ip.det_buffer_size_kbytes >= DCN3_16_DEFAULT_DET_SIZE);
-	dc->config.enable_4to1MPC = false;
 	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
 		if (is_dual_plane(pipe->plane_state->format)
 				&& pipe->plane_state->src_rect.width <= 1920 && pipe->plane_state->src_rect.height <= 1080) {
-			dc->config.enable_4to1MPC = true;
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes =
 					(max_usable_det / DCN3_16_CRB_SEGMENT_SIZE_KB / 4) * DCN3_16_CRB_SEGMENT_SIZE_KB;
 		} else if (!is_dual_plane(pipe->plane_state->format)) {
@@ -1750,6 +1748,10 @@ static bool dcn316_resource_construct(
 	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
+
+	/* Enable 4to1MPC by default */
+	dc->config.allow_4to1MPC = true;
+
 	dc->caps.max_downscale_ratio = 600;
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 5; /*1.5 w/a applied by default*/
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index f7e2e79bc0e1..154e00c32511 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1830,6 +1830,9 @@ static bool dcn35_resource_construct(
 	clk_src_regs_init(3, D),
 	clk_src_regs_init(4, E);
 
+	/* Enable 4to1MPC by default */
+	dc->config.allow_4to1MPC = true;
+
 #undef REG_STRUCT
 #define REG_STRUCT abm_regs
 	abm_regs_init(0),
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 5dffaf12a7c0..640650ed2184 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1803,6 +1803,9 @@ static bool dcn351_resource_construct(
 	clk_src_regs_init(3, D),
 	clk_src_regs_init(4, E);
 
+	/* Enable 4to1MPC by default */
+	dc->config.allow_4to1MPC = true;
+
 #undef REG_STRUCT
 #define REG_STRUCT abm_regs
 	abm_regs_init(0),
-- 
2.43.0

