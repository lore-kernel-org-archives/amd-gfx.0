Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80207109E540
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2313310E919;
	Thu, 26 Mar 2026 03:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aepMMpGa";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACF110E919
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0iKwgdrT783zwf9Vmee0514aNqZHBfjf437rp0HjG/ltRgfQQNggkLN7KX20CWtRmgPltJ3dqDBmaO+SoOlSfUYHbFsp4hcdDCuvXcXvkY0FK0tz7/6EN8xErhWtfWCYOIgAFUlEj6a+HyI9lsA6nUQ7i2oPPKER6VLeMfLwcgt8zP7O3Rt5MutaOdtJubq0csTaaDcP1t13mvlaBk+FXGp+U+YQklfiLhwzAKTOQKbFjtnMPOWrkQ5PmXPqjs3rxJYLPwAZnlXU8TWDRs3sG19F7qdon9Fl0icl9bHGB4PktZC390egCwye96S+/QPg3gPmBPBoFRBafIuLcPaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hHlzaW1WDwmzdEu/m8Y1B2PbCaArVVRdNo2gaeZCv4=;
 b=I94qYiZNttyp/RIMHOwOM6EXPCEq+bgJot70UHRJaQTEeYyXGr6UcET4u0OO5RTQkBt7BIdbhiw3do65L7KKO3IpxWcw1HNYqiX/e4Vi8lkFckX7lqgovFs3Tb8Zuti45KsPCHGmH62zLArCFJSy+SLrFVTmo9h2IH2O1rWAZ6J27EgsL4xVreOVjcS0T09pIXoE9R2dMbPmG3WFoz9IKO4fkzlzDMKeTqA1u/8qnex/+KlksosM0vgLKTewL9736nHZODpplxpzzv9cnll74DhnM6oPbkqiZzCt9G3RC5SyrH+YGjX//o2FFk08inUotRaPAvfAKWCXorNcQ4dsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hHlzaW1WDwmzdEu/m8Y1B2PbCaArVVRdNo2gaeZCv4=;
 b=aepMMpGaR/Jfp7AG3jQJuLGrl2sArzUiYaLUOYFa7C7paVJGMhv32PEhAqMTUKZ0+gc9VnLJcFXVneCMCFUgLz6ZQqFPwjoiTGUvkZ8ZsgZKP3khu8EIRPe6ZiCAhjO60tb7+eJMOUuQIGiUQXkRr82n9COU6UE+yMNil5tcqeY=
Received: from BL1PR13CA0166.namprd13.prod.outlook.com (2603:10b6:208:2bd::21)
 by CH1PR12MB9598.namprd12.prod.outlook.com (2603:10b6:610:2ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Thu, 26 Mar
 2026 03:01:03 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::fd) by BL1PR13CA0166.outlook.office365.com
 (2603:10b6:208:2bd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Thu,
 26 Mar 2026 03:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:03 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:00:51 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 08/30] drm/amd/display: Don't set 4to1MPC config dynamically
Date: Thu, 26 Mar 2026 10:56:59 +0800
Message-ID: <20260326030153.406612-9-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CH1PR12MB9598:EE_
X-MS-Office365-Filtering-Correlation-Id: 945db6a8-faf5-4a90-0fb3-08de8ae3eaa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CSTPi099kcNF3MdI89DcADRX5fGQdLe1oIDms1y2lrM+1t33duZeSD21UhbXQd0c8QMFzJFai6zZarFwb850JLeUNnz8CEhKj/ABKf4Skiz21tXsxy7uvT+tWkqrHDwUV+QiXzpB+rchvSe74JxY1eOlLvQjSHdvTPTlRzyVjTXJYsFalrjQCFYctEb1OH3mGVLEdgxRr1MrMz/fjTHKp/AiEgdNK6GEWQ5MFmB3OGxdF1UUdPdbZxdZO5JbqT+WYvNzsPlXa5un1t+2sGgl7GoOWGmghXjATelbzOY7gQyCifzWnng/5BAzxHI0DG+p4xIGeezEsHnZBuALZVi+c1lRFdtH8JGcetvw5M9kNRMYBk5JJ4R1Kth1fblkOiy54M227JhcIm+3J/RDrSg/uhn4o410icz6KHo1jpWo2nmyZ/bkHY/UAFeu0iRVFvuUIkFx6TW9aWyDI96YC5s/Ca0lPoQgPyn1ccwwnycGH8xOHSfJau5ISibcPBEpO3NK8MMRY2NDf9S22iMGe7uqKbalnNWYcr3XkTmYdaSw6e2ac5IvfDGFT+okCzPq9Ymavh65pA+w/yAsGbQ6OOAvwQxrKeiaktwetQF8lQRHYLNyj4vJLvMv6vzYjPBhhsDWRryJ04SserJEnUUCR36yfZrjV0IS8rXVq7UfmJzSSlW/izEm2UYm5Sd7Cn+5L72lUSWJtT2sLK0Zkk+fisT4jLmWBPc7+uluVNLMoCEzRuPnqo3asRGsMCIRL040UL5cz1Z5DMCvzbI6zZQOvbfhnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zj5f40AcSWO7ygAy/SFZsrEgvRXPQ498hctZruDxIBX9VjqJHOQ6e4ZL4xeC20XpdID8xo6sk+OPNAulVRyrTgzJuT+bJiluuWZc8fDSDtqQ8nrKIqZri3udChFo2lRV8oIkSq43UzoQDYVT6BuGRhOaWn2xcuET5tedyob6cuG8BFen77QFfl5kEeivltUcCmRHQBMxmANrcJt1a1IF+xg5uNJOBdT/VFOI++dDqEprwZMZQcuNjqXFPvOUIw+JVIPDcCk5o9xc2oycTyktbK8goP5tbSBSnJhVlNJ4qsJMneOZaZjvYXNe355LSZcQL7X06Uo+fTqLS7nQltGVKmvFUl6ueGK8guzJwJuDNejLNn/cDO2bYuZdnIusGxZWCS71GhF5oJ7Q259/YVbVFL1TFD62YViZobwbhGuAs8X0nrk7Ah8tXbn4HC3UGnmY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:03.1619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945db6a8-faf5-4a90-0fb3-08de8ae3eaa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9598
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

