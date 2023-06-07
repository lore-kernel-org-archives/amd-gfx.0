Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB8CC7EE29
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A248010E4D3;
	Wed,  7 Jun 2023 12:16:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC34C10E4D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE9d1yorIEtCx3VDkan07uKvfRmjiqFBILyEvINBQKf7m/OnfrlFHDEzD6LmRMxmJdrQ4EF27ozW0oq3AbddVkZpLTF9wau1hVepqCa7/iRcmNhXVXF280YciH8u+SV6aWY+FImhT0abMsuUDCf2UupFGM7cQ3OVW1TUh3duWFQRP8vir9vTuaI3ICIPOhXS9RgV0163Or1+KoUezkm+X/TDiqBp1E9XUWbIAmEDUj3Kh5eUV1h9pkxvkxtaW99ltWjGoUsW9Vx1792vsR1yAUMvxlHyhDuOfdlyuYuo2jCci4K+drOgontr4fswhHJOiwFtMH+cBuoVl3OUAIiG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr/8pgAFDem+N0+NA3NaAWpyXILyHQPLZ9Xd8ri5gxs=;
 b=MKgcZM5y6RxzDPhW8LLVUxVLlIk9IlM45UuplkueLNF6Mvg3Hozvr+zpzEI83PDpwxzIkMavYg4joY1xjBQ1+aFHf645mdNYPnQQjQ+/wbfFs0UW/7vVvVhGD8cStnDAzyshySNygq/3os0hNAF1Tiu1x386cQ78Kuf77kgIldAF8DtUtPzOFnbnCNYsXAbxkTV+5TynK3yoiFB4cv3cw66PlsMFUyl1tSdXcQabOvr7epW1sEKBZNPPgJq5zQCFgQzo4a3V052O4/ztLgGqGTewlXjnLlAuK+JGYf1y63nRkG+tAuRwOtFB4qwQgX4Cn80b+4tM41rZ0RzhtAovgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr/8pgAFDem+N0+NA3NaAWpyXILyHQPLZ9Xd8ri5gxs=;
 b=1jRQdY7F38RzexKiJ4I6BlcvZf/4G/K//I7GoEelmFM0HfgJm7TzCMZLqfhMty/65urJsla0ej+oZoaXyrxAl/oMr6LQpfpgWouIege7fq18M92DRB6sImYEjTfaA9toL2gBY0uAJoP5ugCPSTQmNzOHuOZW7O2QyEbWPwTEjFM=
Received: from DS7PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:3bb::8) by
 DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 12:16:44 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::80) by DS7PR03CA0063.outlook.office365.com
 (2603:10b6:5:3bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 12:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:16:43 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:39 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/20] drm/amd/display: SubVP high refresh only if all
 displays >= 120hz
Date: Wed, 7 Jun 2023 20:15:36 +0800
Message-ID: <20230607121548.1479290-9-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 409f122e-8ed5-4873-735e-08db67510eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8+fuHUM73E060M57qsWgXChhg36P1vzCdl5O0ZInvg94HcnU8xwJ10GAMNkr0TpqbzN+wg7+ynm8RjP4bZ59cpK6VrOfU3Sl700Fdsj+frf1a3L+x0KmJsMCGOZ8YMb5/7+ZvKPhLJvc6WMk1y8z+OGStI0Qvx3lj84za/8fCmzL+viVgW/id50nyjTgaXt91K6aMbvIR+UrK8wSdhgyqcvtcv3VjpjYygutfpol11pg9gqH70V3D84JkEV4QLK5p2NCNsA2fm2Ku1RuWkhEBBcYIIOJ6vGYLamkx74bwrvhJOGomfT+8lHbJFiZvCYzdUp7axLzf7I0Mwch9W2qGkddV0dQ9RWUuMTAZ4uuFi95Kd9HD1wuzUYTmotpeVCASQB8Qgm2mvJoG2pNAnLS+LtTh2iLw4LZP5yWw+Ew2eq8MQq/ILnC/vX8eukE7PibmoPH7o9NaEdzgP25TeXjwUk0ulakJtW1pYdfiErHAbo1kgMKOHvc6W17MXsR+uQV4FQTQXVxkRmH3z6GTUKRmOIIqHxD97CLN6vVp+eINoum7KiMVMY4I75+cgq0BfI+KtCr5BghoaXkYrW+bxDz3WuSg0Rte2oB10W73gpKAFLe6xxVg4fNGMfwolmawV6O45CUCLl6cL3gugOooWkH9cxmCTh4SSF4BOwolsEyRsrM4Nqg/gnahBOLKV3c/QC6ly8fk4ogDaawVVnHc5OoNh1gKgCKZgutRC7/cxolhq2pmjskD3WL1KQwhFYuTdZn5yOS7+WvvKGvZ9a74N1BivzLajJcWwL1A2UaJddvfg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(6666004)(7696005)(36756003)(336012)(2616005)(82310400005)(36860700001)(83380400001)(47076005)(40480700001)(426003)(86362001)(81166007)(356005)(1076003)(82740400003)(26005)(16526019)(186003)(40460700003)(8936002)(8676002)(5660300002)(41300700001)(316002)(2906002)(30864003)(44832011)(54906003)(478600001)(70206006)(70586007)(4326008)(6916009)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:16:43.8904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 409f122e-8ed5-4873-735e-08db67510eb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- SubVP high refresh should only be enabled if all displays
  are >= 120hz. We do not want to accidentally enables configs
  such as 60hz[SubVP] + 120hz[SubVP]
- Ensure that the SubVP config generation code does not produce
  configs such as 60hz[SubVP] + 120hz[SubVP]
- Also add admissibility checks to ensure these configs do not
  pass as valid configs

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   4 +
 .../display/dc/dcn32/dcn32_resource_helpers.c | 101 ++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 178 +++++++++++-------
 3 files changed, 217 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 2f34f01b3ea1..81e443170829 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -169,6 +169,10 @@ double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *conte
 
 bool dcn32_check_native_scaling_for_res(struct pipe_ctx *pipe, unsigned int width, unsigned int height);
 
+bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context);
+
+bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int vlevel);
+
 /* definitions for run time init of reg offsets */
 
 /* CLK SRC */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 1d13fd797212..578070e7d44b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -660,3 +660,104 @@ bool dcn32_check_native_scaling_for_res(struct pipe_ctx *pipe, unsigned int widt
 
 	return is_native_scaling;
 }
+
+/**
+ * ************************************************************************************************
+ * dcn32_subvp_drr_admissable: Determine if SubVP + DRR config is admissible
+ *
+ * @param [in]: dc: Current DC state
+ * @param [in]: context: New DC state to be programmed
+ *
+ * SubVP + DRR is admissible under the following conditions:
+ * - Config must have 2 displays (i.e., 2 non-phantom master pipes)
+ * - One display is SubVP
+ * - Other display must have Freesync enabled
+ *
+ * @return: True if admissible, false otherwise
+ *
+ * ************************************************************************************************
+ */
+bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
+{
+	bool result = false;
+	uint32_t i;
+	uint8_t subvp_count = 0;
+	uint8_t non_subvp_pipes = 0;
+	bool drr_pipe_found = false;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+
+		if (pipe->plane_state && !pipe->top_pipe) {
+			if (pipe->stream->mall_stream_config.type == SUBVP_MAIN)
+				subvp_count++;
+			if (pipe->stream->mall_stream_config.type == SUBVP_NONE) {
+				non_subvp_pipes++;
+				if (pipe->stream->ignore_msa_timing_param &&
+						(pipe->stream->allow_freesync || pipe->stream->vrr_active_variable)) {
+					drr_pipe_found = true;
+				}
+			}
+		}
+	}
+
+	if (subvp_count == 1 && non_subvp_pipes == 1 && drr_pipe_found)
+		result = true;
+
+	return result;
+}
+
+/**
+ * ************************************************************************************************
+ * dcn32_subvp_vblank_admissable: Determine if SubVP + Vblank config is admissible
+ *
+ * @param [in]: dc: Current DC state
+ * @param [in]: context: New DC state to be programmed
+ *
+ * SubVP + Vblank is admissible under the following conditions:
+ * - Config must have 2 displays (i.e., 2 non-phantom master pipes)
+ * - One display is SubVP
+ * - Other display must not have Freesync capability
+ * - DML must have output DRAM clock change support as SubVP + Vblank
+ *
+ * @return: True if admissible, false otherwise
+ *
+ * ************************************************************************************************
+ */
+bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int vlevel)
+{
+	bool result = false;
+	uint32_t i;
+	uint8_t subvp_count = 0;
+	uint8_t non_subvp_pipes = 0;
+	bool drr_pipe_found = false;
+	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+
+		if (pipe->plane_state && !pipe->top_pipe) {
+			if (pipe->stream->mall_stream_config.type == SUBVP_MAIN)
+				subvp_count++;
+			if (pipe->stream->mall_stream_config.type == SUBVP_NONE) {
+				non_subvp_pipes++;
+				if (pipe->stream->ignore_msa_timing_param &&
+						(pipe->stream->allow_freesync || pipe->stream->vrr_active_variable)) {
+					drr_pipe_found = true;
+				}
+			}
+		}
+	}
+
+	if (subvp_count == 1 && non_subvp_pipes == 1 && !drr_pipe_found &&
+			vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_vblank_w_mall_sub_vp)
+		result = true;
+
+	return result;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index fa3678342abb..166123be4adc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -679,7 +679,6 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 	unsigned int max_frame_time = 0;
 	bool valid_assignment_found = false;
 	unsigned int free_pipes = dcn32_get_num_free_pipes(dc, context);
-	bool current_assignment_freesync = false;
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
@@ -720,19 +719,10 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 				struct dc_stream_state *stream = pipe->stream;
 				unsigned int frame_us = (stream->timing.v_total * stream->timing.h_total /
 						(double)(stream->timing.pix_clk_100hz * 100)) * 1000000;
-				if (frame_us > max_frame_time && !stream->ignore_msa_timing_param) {
+				if (frame_us > max_frame_time) {
 					*index = i;
 					max_frame_time = frame_us;
 					valid_assignment_found = true;
-					current_assignment_freesync = false;
-				/* For the 2-Freesync display case, still choose the one with the
-			     * longest frame time
-			     */
-				} else if (stream->ignore_msa_timing_param && (!valid_assignment_found ||
-						(current_assignment_freesync && frame_us > max_frame_time))) {
-					*index = i;
-					valid_assignment_found = true;
-					current_assignment_freesync = true;
 				}
 			}
 		}
@@ -878,11 +868,12 @@ static bool subvp_subvp_schedulable(struct dc *dc, struct dc_state *context)
  *
  * Return: True if the SubVP + DRR config is schedulable, false otherwise
  */
-static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context, struct pipe_ctx *drr_pipe)
+static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 {
 	bool schedulable = false;
 	uint32_t i;
 	struct pipe_ctx *pipe = NULL;
+	struct pipe_ctx *drr_pipe = NULL;
 	struct dc_crtc_timing *main_timing = NULL;
 	struct dc_crtc_timing *phantom_timing = NULL;
 	struct dc_crtc_timing *drr_timing = NULL;
@@ -908,6 +899,19 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context, struc
 			break;
 	}
 
+	// Find the DRR pipe
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		drr_pipe = &context->res_ctx.pipe_ctx[i];
+
+		// We check for master pipe only
+		if (!drr_pipe->stream || !drr_pipe->plane_state || drr_pipe->top_pipe || drr_pipe->prev_odm_pipe)
+			continue;
+
+		if (drr_pipe->stream->mall_stream_config.type == SUBVP_NONE && drr_pipe->stream->ignore_msa_timing_param &&
+				(drr_pipe->stream->allow_freesync || drr_pipe->stream->vrr_active_variable))
+			break;
+	}
+
 	main_timing = &pipe->stream->timing;
 	phantom_timing = &pipe->stream->mall_stream_config.paired_stream->timing;
 	drr_timing = &drr_pipe->stream->timing;
@@ -993,13 +997,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 		if (!subvp_pipe && pipe->stream->mall_stream_config.type == SUBVP_MAIN)
 			subvp_pipe = pipe;
 	}
-	// Use ignore_msa_timing_param and VRR active, or Freesync flag to identify as DRR On
-	if (found && context->res_ctx.pipe_ctx[vblank_index].stream->ignore_msa_timing_param &&
-			(context->res_ctx.pipe_ctx[vblank_index].stream->allow_freesync ||
-			context->res_ctx.pipe_ctx[vblank_index].stream->vrr_active_variable)) {
-		// SUBVP + DRR case -- only allowed if run through DRR validation path
-		schedulable = false;
-	} else if (found) {
+	if (found) {
 		main_timing = &subvp_pipe->stream->timing;
 		phantom_timing = &subvp_pipe->stream->mall_stream_config.paired_stream->timing;
 		vblank_timing = &context->res_ctx.pipe_ctx[vblank_index].stream->timing;
@@ -1028,6 +1026,56 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 	return schedulable;
 }
 
+/**
+ * ************************************************************************************************
+ * subvp_subvp_admissable: Determine if subvp + subvp config is admissible
+ *
+ * @param [in]: dc: Current DC state
+ * @param [in]: context: New DC state to be programmed
+ *
+ * SubVP + SubVP is admissible under the following conditions:
+ * - All SubVP pipes are < 120Hz OR
+ * - All SubVP pipes are >= 120hz
+ *
+ * @return: True if admissible, false otherwise
+ *
+ * ************************************************************************************************
+ */
+static bool subvp_subvp_admissable(struct dc *dc,
+				struct dc_state *context)
+{
+	bool result = false;
+	uint32_t i;
+	uint8_t subvp_count = 0;
+	uint32_t min_refresh = subvp_high_refresh_list.min_refresh, max_refresh = 0;
+	uint32_t refresh_rate = 0;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+
+		if (pipe->plane_state && !pipe->top_pipe &&
+				pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
+			refresh_rate = (pipe->stream->timing.pix_clk_100hz * 100 +
+					pipe->stream->timing.v_total * pipe->stream->timing.h_total - 1)
+					/ (double)(pipe->stream->timing.v_total * pipe->stream->timing.h_total);
+			if (refresh_rate < min_refresh)
+				min_refresh = refresh_rate;
+			if (refresh_rate > max_refresh)
+				max_refresh = refresh_rate;
+			subvp_count++;
+		}
+	}
+
+	if (subvp_count == 2 && ((min_refresh < 120 && max_refresh < 120) ||
+			(min_refresh >= 120 && max_refresh >= 120)))
+		result = true;
+
+	return result;
+}
+
 /**
  * subvp_validate_static_schedulability - Check which SubVP case is calculated
  * and handle static analysis based on the case.
@@ -1046,11 +1094,12 @@ static bool subvp_validate_static_schedulability(struct dc *dc,
 				struct dc_state *context,
 				int vlevel)
 {
-	bool schedulable = true;	// true by default for single display case
+	bool schedulable = false;
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 	uint32_t i, pipe_idx;
 	uint8_t subvp_count = 0;
 	uint8_t vactive_count = 0;
+	uint8_t non_subvp_pipes = 0;
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -1058,14 +1107,18 @@ static bool subvp_validate_static_schedulability(struct dc *dc,
 		if (!pipe->stream)
 			continue;
 
-		if (pipe->plane_state && !pipe->top_pipe &&
-				pipe->stream->mall_stream_config.type == SUBVP_MAIN)
-			subvp_count++;
+		if (pipe->plane_state && !pipe->top_pipe) {
+			if (pipe->stream->mall_stream_config.type == SUBVP_MAIN)
+				subvp_count++;
+			if (pipe->stream->mall_stream_config.type == SUBVP_NONE) {
+				non_subvp_pipes++;
+			}
+		}
 
 		// Count how many planes that aren't SubVP/phantom are capable of VACTIVE
 		// switching (SubVP + VACTIVE unsupported). In situations where we force
 		// SubVP for a VACTIVE plane, we don't want to increment the vactive_count.
-		if (vba->ActiveDRAMClockChangeLatencyMargin[vba->pipe_plane[pipe_idx]] > 0 &&
+		if (vba->ActiveDRAMClockChangeLatencyMarginPerState[vlevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] > 0 &&
 		    pipe->stream->mall_stream_config.type == SUBVP_NONE) {
 			vactive_count++;
 		}
@@ -1074,13 +1127,14 @@ static bool subvp_validate_static_schedulability(struct dc *dc,
 
 	if (subvp_count == 2) {
 		// Static schedulability check for SubVP + SubVP case
-		schedulable = subvp_subvp_schedulable(dc, context);
-	} else if (vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_vblank_w_mall_sub_vp) {
-		// Static schedulability check for SubVP + VBLANK case. Also handle the case where
-		// DML outputs SubVP + VBLANK + VACTIVE (DML will report as SubVP + VBLANK)
-		if (vactive_count > 0)
-			schedulable = false;
-		else
+		schedulable = subvp_subvp_admissable(dc, context) && subvp_subvp_schedulable(dc, context);
+	} else if (subvp_count == 1 && non_subvp_pipes == 0) {
+		// Single SubVP configs will be supported by default as long as it's suppported by DML
+		schedulable = true;
+	} else if (subvp_count == 1 && non_subvp_pipes == 1) {
+		if (dcn32_subvp_drr_admissable(dc, context))
+			schedulable = subvp_drr_schedulable(dc, context);
+		else if (dcn32_subvp_vblank_admissable(dc, context, vlevel))
 			schedulable = subvp_vblank_schedulable(dc, context);
 	} else if (vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_vactive_w_mall_sub_vp &&
 			vactive_count > 0) {
@@ -1104,10 +1158,6 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 	unsigned int dc_pipe_idx = 0;
 	int i = 0;
 	bool found_supported_config = false;
-	struct pipe_ctx *pipe = NULL;
-	uint32_t non_subvp_pipes = 0;
-	bool drr_pipe_found = false;
-	uint32_t drr_pipe_index = 0;
 
 	dc_assert_fp_enabled();
 
@@ -1197,31 +1247,12 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 				}
 			}
 
-			if (*vlevel < context->bw_ctx.dml.soc.num_states &&
-			    vba->DRAMClockChangeSupport[*vlevel][vba->maxMpcComb] != dm_dram_clock_change_unsupported
-			    && subvp_validate_static_schedulability(dc, context, *vlevel)) {
+			if (*vlevel < context->bw_ctx.dml.soc.num_states
+			    && subvp_validate_static_schedulability(dc, context, *vlevel))
 				found_supported_config = true;
-			} else if (*vlevel < context->bw_ctx.dml.soc.num_states) {
-				/* Case where 1 SubVP is added, and DML reports MCLK unsupported or DRR is allowed.
-				 * This handles the case for SubVP + DRR, where the DRR display does not support MCLK
-				 * switch at it's native refresh rate / timing, or DRR is allowed for the non-subvp
-				 * display.
-				 */
-				for (i = 0; i < dc->res_pool->pipe_count; i++) {
-					pipe = &context->res_ctx.pipe_ctx[i];
-					if (pipe->stream && pipe->plane_state && !pipe->top_pipe &&
-					    pipe->stream->mall_stream_config.type == SUBVP_NONE) {
-						non_subvp_pipes++;
-						// Use ignore_msa_timing_param flag to identify as DRR
-						if (pipe->stream->ignore_msa_timing_param && pipe->stream->allow_freesync) {
-							drr_pipe_found = true;
-							drr_pipe_index = i;
-						}
-					}
-				}
-				// If there is only 1 remaining non SubVP pipe that is DRR, check static
-				// schedulability for SubVP + DRR.
-				if (non_subvp_pipes == 1 && drr_pipe_found) {
+			if (found_supported_config) {
+				// For SubVP + DRR cases, we can force the lowest vlevel that supports the mode
+				if (dcn32_subvp_drr_admissable(dc, context) && subvp_drr_schedulable(dc, context)) {
 					/* find lowest vlevel that supports the config */
 					for (i = *vlevel; i >= 0; i--) {
 						if (vba->ModeSupport[i][vba->maxMpcComb]) {
@@ -1230,9 +1261,6 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 							break;
 						}
 					}
-
-					found_supported_config = subvp_drr_schedulable(dc, context,
-										       &context->res_ctx.pipe_ctx[drr_pipe_index]);
 				}
 			}
 		}
@@ -2882,16 +2910,34 @@ bool dcn32_allow_subvp_high_refresh_rate(struct dc *dc, struct dc_state *context
 {
 	bool allow = false;
 	uint32_t refresh_rate = 0;
-	uint32_t min_refresh = subvp_high_refresh_list.min_refresh;
-	uint32_t max_refresh = subvp_high_refresh_list.max_refresh;
+	uint32_t subvp_min_refresh = subvp_high_refresh_list.min_refresh;
+	uint32_t subvp_max_refresh = subvp_high_refresh_list.max_refresh;
+	uint32_t min_refresh = subvp_max_refresh;
 	uint32_t i;
 
-	if (!dc->debug.disable_subvp_high_refresh && pipe->stream &&
+	/* Only allow SubVP on high refresh displays if all connected displays
+	 * are considered "high refresh" (i.e. >= 120hz). We do not want to
+	 * allow combinations such as 120hz (SubVP) + 60hz (SubVP).
+	 */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe_ctx->stream)
+			continue;
+		refresh_rate = (pipe_ctx->stream->timing.pix_clk_100hz * 100 +
+				pipe_ctx->stream->timing.v_total * pipe_ctx->stream->timing.h_total - 1)
+						/ (double)(pipe_ctx->stream->timing.v_total * pipe_ctx->stream->timing.h_total);
+
+		if (refresh_rate < min_refresh)
+			min_refresh = refresh_rate;
+	}
+
+	if (!dc->debug.disable_subvp_high_refresh && min_refresh >= subvp_min_refresh && pipe->stream &&
 			pipe->plane_state && !(pipe->stream->vrr_active_variable || pipe->stream->vrr_active_fixed)) {
 		refresh_rate = (pipe->stream->timing.pix_clk_100hz * 100 +
 						pipe->stream->timing.v_total * pipe->stream->timing.h_total - 1)
 						/ (double)(pipe->stream->timing.v_total * pipe->stream->timing.h_total);
-		if (refresh_rate >= min_refresh && refresh_rate <= max_refresh) {
+		if (refresh_rate >= subvp_min_refresh && refresh_rate <= subvp_max_refresh) {
 			for (i = 0; i < SUBVP_HIGH_REFRESH_LIST_LEN; i++) {
 				uint32_t width = subvp_high_refresh_list.res[i].width;
 				uint32_t height = subvp_high_refresh_list.res[i].height;
-- 
2.40.1

