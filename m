Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEDACD128D
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD72112539;
	Thu, 28 Mar 2024 19:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LLAAQ0PN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC60211252C
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8AwRsc0XEmOYWB7aoTdqVv4bqQ5aDxjCK7PNrAK4oTb8/qHZK6TDRvhabSHyPMCGONXeOc/jgBzvm46K9L0QkFwXrYExgYZwZoYrbBz9nPMQGBZMM8WGL6soF+BybYvIx6OZWsANF4ZWAWgWt2vrcek+VnLsmetoEiHaBeHCnljKUMRi6yOLMwJAI1TnkBhDiX+6bVsP1evGjWoQKxT/NggvSNTN6ZX4wd6Km9cQOWEFVNsyXS0kp3E8ROyjGYfgnYDzOFhJ6xdB4ZMeSSAQx+dSrbwPXeos8341pMWkyzjc9ScDM0C2uejhBseDrvR7r6UvQ50jSWiibWH3n/HTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PExvA87fSxBo16WHhqSmrTBOzCc4Y7i7fjnJS1noBHA=;
 b=K6AlvSiYT8K4LhjWIdrVfRUGedCM0qiJyYesuGG98BTXNho9AxfwrF15RsYE+ehrv86jAnOyvqx3ILdprt9D0GZ+r5zdw/HWWSo7b/hryKAtpn7MiOZ94RH+TnEEDs6s+ns3VRLBIt7dYKNs6WfPIM3cHJ05pVqDaZHNObFRo716mEWpuTFA8YTl5/b11U/QGv7GzOD2l6BqWpEAvOsRORwOUh2CtfVLAB4W5wjkTADk7KdJRV9VXJWkRobKVTw1Ur1wbimuLtvOIc3lEi9qqIRg5TovU5fSEHC6dtQTUSEp/1V/puaFN6wDMJfuPGUlU7ePMeag/EgRwYufaAMwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PExvA87fSxBo16WHhqSmrTBOzCc4Y7i7fjnJS1noBHA=;
 b=LLAAQ0PNTZfLqnQWu7eo6qMLQ5naWbe8QDQbS0kzG7Uj0N6eH9Z4vr009/oNgHZLnlW52tvHJ5EYskekn5pG1YSuOvDzD0OY68azmoRHBhXg+5ocDfKj6ZcBhs2yYrHVuDqgjHYyubSn6Xd9zTwLquuKNoQwROK/pPui1+gNhfg=
Received: from CH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::34)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:51:56 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::c5) by CH0P220CA0017.outlook.office365.com
 (2603:10b6:610:ef::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:55 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:55 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, George Shen <george.shen@amd.com>
Subject: [PATCH 24/43] drm/amd/display: move build test pattern params as part
 of pipe resource update for odm
Date: Thu, 28 Mar 2024 15:50:28 -0400
Message-ID: <20240328195047.2843715-25-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: c69142c2-ff0a-472b-b05d-08dc4f608624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QL8WcBqct4D9HnihlkvxH1vI/UywrLOPjpN8j2U+6FmcvWipRoz0/QHvqhHeyzPo/hC4OZx+2uF+fEk6q2GcuS2MKW8LNRLT7HXA1mvpWN98KzI4SUxYuTTxrvToYrd7I0kLaJtqU7R36xdrhDplkNhBQgW7fBY+75DiXu+88y8id4WcLM81XK90CyGfqEj4c1nuLEbOuTPjGe+Fy+cXkS/LEHYyi1vXNUz3uL5zPPU14gczyM5uv2jC30VdpxC683d1WQOb9zQmENTQkHW7sBu95Wj9+fdlIqq7704rJlbthIQ7ZFoObHYRwNpbf2ttRe8EYCkt87gVhWmMt/Q4b2F3HX3+nRTjqSIE4rnQzxg0ZVSAnginT7WEi6aH1R99SC+0bUb3W7Hwd8PDfGpUdr2RcT24wnEdnSb+PF5/W1VauaVlX7h1Zzg9mTFCfcSFW+ifMt6GjoyPmMirRGPmRi7B4HMblzw/Lc4nI+S+D09TIZHw85TBvcPubFse+/LKwFFv8+U/XuYCkhdIIbOXaNDww+ElfnawZsPrRMqAwSXKU80tgyUbXHO+Cf7G2C55wbEWjuW9z25wOLtJORX4W0XJ26eMq3WjxUo72xINdJFway/fTpM/fUJmzK5+NoqmG4GcS0xvPP1aBGhLP8ZWMWOOPim9Z090vTKTQYf81/6m3Nstcm1pXhGJZkHyLcT5BQwKEsODkxJVM0SVBeGYfEDSs32KZDl7TIBED2kP8Pefj3lvA7HNE8YX/T9fE6BM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:56.4367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69142c2-ff0a-472b-b05d-08dc4f608624
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
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
Move built test pattern as part of pipe resource update for odm to ensure we rebuild
test pattern params every time we have an ODM update

Reviewed-by: George Shen <george.shen@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 24 ++++++++++++-------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  7 ++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  8 +++++++
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  6 +++++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  1 +
 5 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f44025eacc0a..5a93278fa246 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3235,14 +3235,6 @@ static bool update_planes_and_stream_state(struct dc *dc,
 			BREAK_TO_DEBUGGER();
 			goto fail;
 		}
-
-		for (i = 0; i < context->stream_count; i++) {
-			struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(&context->res_ctx,
-					context->streams[i]);
-
-			if (otg_master && otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
-				resource_build_test_pattern_params(&context->res_ctx, otg_master);
-		}
 	}
 	update_seamless_boot_flags(dc, context, surface_count, stream);
 
@@ -3338,12 +3330,26 @@ static void commit_planes_do_stream_update(struct dc *dc,
  			}
 
 			if (stream_update->pending_test_pattern) {
-				dc_link_dp_set_test_pattern(stream->link,
+				/*
+				 * test pattern params depends on ODM topology
+				 * changes that we could be applying to front
+				 * end. Since at the current stage front end
+				 * changes are not yet applied. We can only
+				 * apply test pattern in hw based on current
+				 * state and populate the final test pattern
+				 * params in new state. If current and new test
+				 * pattern params are different as result of
+				 * different ODM topology being used, it will be
+				 * detected and handle during front end
+				 * programming update.
+				 */
+				dc->link_srv->dp_set_test_pattern(stream->link,
 					stream->test_pattern.type,
 					stream->test_pattern.color_space,
 					stream->test_pattern.p_link_settings,
 					stream->test_pattern.p_custom_pattern,
 					stream->test_pattern.cust_pattern_size);
+				resource_build_test_pattern_params(&context->res_ctx, pipe_ctx);
 			}
 
 			if (stream_update->dpms_off) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index c4a3484554b0..d48a181d2249 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1457,6 +1457,9 @@ void resource_build_test_pattern_params(struct resource_context *res_ctx,
 	controller_color_space = convert_dp_to_controller_color_space(
 			otg_master->stream->test_pattern.color_space);
 
+	if (controller_test_pattern == CONTROLLER_DP_TEST_PATTERN_VIDEOMODE)
+		return;
+
 	odm_cnt = resource_get_opp_heads_for_otg_master(otg_master, res_ctx, opp_heads);
 
 	odm_slice_width = h_active / odm_cnt;
@@ -2325,6 +2328,9 @@ static bool update_pipe_params_after_odm_slice_count_change(
 
 	if (pool->funcs->build_pipe_pix_clk_params)
 		pool->funcs->build_pipe_pix_clk_params(otg_master);
+
+	if (otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
+		resource_build_test_pattern_params(&context->res_ctx, otg_master);
 	return result;
 }
 
@@ -5082,6 +5088,7 @@ void resource_init_common_dml2_callbacks(struct dc *dc, struct dml2_configuratio
 {
 	dml2_options->callbacks.dc = dc;
 	dml2_options->callbacks.build_scaling_params = &resource_build_scaling_params;
+	dml2_options->callbacks.build_test_pattern_params = &resource_build_test_pattern_params;
 	dml2_options->callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
 	dml2_options->callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
 	dml2_options->callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 8c0e1ab29aa9..9e6498d2439d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2115,6 +2115,14 @@ static bool dcn32_apply_merge_split_flags_helper(
 					return false;
 			}
 		}
+
+		for (i = 0; i < context->stream_count; i++) {
+			struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(&context->res_ctx,
+					context->streams[i]);
+
+			if (otg_master && otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
+				resource_build_test_pattern_params(&context->res_ctx, otg_master);
+		}
 	}
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 27d9da8ad7c1..237b67de62c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -1078,6 +1078,12 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 				ASSERT(false);
 			}
 		}
+
+		if (ctx->config.callbacks.build_test_pattern_params &&
+				pipe->stream &&
+				pipe->prev_odm_pipe == NULL &&
+				pipe->top_pipe == NULL)
+			ctx->config.callbacks.build_test_pattern_params(&state->res_ctx, pipe);
 	}
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 3760d67af7d5..4a8bd2f4195e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -71,6 +71,7 @@ struct dml2_dcn_clocks {
 struct dml2_dc_callbacks {
 	struct dc *dc;
 	bool (*build_scaling_params)(struct pipe_ctx *pipe_ctx);
+	void (*build_test_pattern_params)(struct resource_context *res_ctx, struct pipe_ctx *otg_master);
 	bool (*can_support_mclk_switch_using_fw_based_vblank_stretch)(struct dc *dc, struct dc_state *context);
 	bool (*acquire_secondary_pipe_for_mpc_odm)(const struct dc *dc, struct dc_state *state, struct pipe_ctx *pri_pipe, struct pipe_ctx *sec_pipe, bool odm);
 	bool (*update_pipes_for_stream_with_slice_count)(
-- 
2.34.1

