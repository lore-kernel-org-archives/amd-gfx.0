Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77681C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8A110FCBF;
	Wed, 31 Jan 2024 20:15:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C456310FCBF
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khRmGedxvQuHi2iwOmNe3kvItWK6SL1zoqiVOKVN8SEm6N/NT8GfUMZ3ZDP2NbeatX+A4fO58SXwgozQTHcWY/mtFQdrWRDi/+HNO96qnqrOTlhNntlZRMb4I5cC8ESeYQ8xSbKGuAWVK92InWMaYn2AiwzV5ylcnM90FDUPwBZYdsBWMSTOM4GJ/GlAY9u/O7nKuf1ujYUHuD//scnf7/mFnQocEsQsZQb0rwIDd5mdH6N6UovcbxO62SrF5g1XOpAJuQyRKefp56XXrt3ZZ9vddyzAJ+1M2sBR2HILJe3WrmbxNXxzgjp+lp4xA7b7c+YyXqyox9qGl+qnsUzdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evzxTsRdM8lYzMzxYJnN5wnRyvV93r8Cq3A7iTs4IN8=;
 b=KrhdkFVesFOO9QxGMIYCwoy2H7/grpd2Nymbq+uKhWcMCUWy2M8NphVZx4fZxTiq/0eFvnJssJgWNQlYGJ+bghMQAVXr/hqlxmMxQPcRV8wPMoXxDbQpQ7vZ0ObzDQyf6ZWzQXTOVyNPSNWDMaVfXb80dvjCm2CNIYPeLY8sgAwh9F04RlHju00EkxnBuRkL4dh1xX5Qlv3nhOPo1xA3/F/wDClok3b59BKIBSON1QpPrYER1JRTVeDgO+B3EcqKqiln0O7X9LnV/CpRrt3s0TBqLqbCuzlFIMTEnVUiNn0V7eMNo4qmSAFFMB0kP3NxhtRt05T3smKRTPNFdHl02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evzxTsRdM8lYzMzxYJnN5wnRyvV93r8Cq3A7iTs4IN8=;
 b=hcC78lDXdKhkT/ZtHJNsidaBrJ3BVo3v5rmLss6j8s+ZYTZswbwvMoDJS2mc6W8zcDo9T9pzHR7FhYxkt/HHz7HxXi7VMYT1wzgEdccgd/pP+9r1+alra1XhM17k5wdEnJjh8Htxk8wwGGwYjl9e1nNPGQ0xtTG+uzUbWWjYPeg=
Received: from SN7PR18CA0015.namprd18.prod.outlook.com (2603:10b6:806:f3::6)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 20:15:19 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::f6) by SN7PR18CA0015.outlook.office365.com
 (2603:10b6:806:f3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 20:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:15:19 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:14:51 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/21] Revert "drm/amd/display: For FPO and SubVP/DRR configs
 program vmin/max sel"
Date: Wed, 31 Jan 2024 15:11:21 -0500
Message-ID: <20240131201220.19106-16-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 37443f5e-50f3-4c02-5543-08dc229958a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oK0SOkpVvGyn4tKmenBq75FgvfwJ7WsoLP1u0f1pGdq2fScaR/6fjjghef63II1iZaj7gLTgw4Zy6xOzJHeozX6295Vmr/ACtid2KYRqpS3dd2cp937xRpeoh1QF6AL0GtFpXtqias9cK4sTdSel6fljZtF6zi2GI8L3PMrH7qG6XWHVg97jQNstTqmgx+8rY4CLWMDMuq+VpB7dpwQJ9YN88uxzyMB72pmAw5G7WVW9L+SBOUW9hdo87jfhaDsFYART2Y/jrbFBga0vC1+cpLSmqyMkNdFn3ycp/pR9orc0griuUoSOJxc8ziwymR6A6dASd19TtLnXQAnwfQLeQLqpmfuIvnbVeyyjr3ZZLulfUrq9nsWStpDif7ejkIBtPuPPtWbB/8hc1fRd65eMaJg3yWsTH748Jej2woFebFbN7uo0Lv04mTIDHfSlJqpOCXeucOFFwg0UzoONzkssjYw6Yh8PlTReY4abNlSiC2gqmkP89pa6ohO2tiyWwc7iLAOV2KNtYzMewH/V6w3JZsdOj+eAARZsMkodpUmXT+/gOFvgQXL3BEvNf1SEYPdUCrNPl2hL5FPiZYoRwVoiYgXYteV1BYSsAfYVzkEXQJ5//pL054fRV7HJifN1XFwJOaUuavm8yJ8p4kP1yl/g5PKsp46uUaCGM1emHRPGO0DJ1VKNEiW2y8R1ZNJwhp2phsY9xtM2tkDHLQ98gbV4NcA/ZA+2OHrmuJXpJoPD+VlgJM4oTCssReAoHfgimyhwi4IUfrV+7DRCwgXQMibaiTsjhQLeeDtM4pbc0oR3qe05jVjfaJw4fQT9/0z/wWMT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(26005)(41300700001)(36860700001)(8676002)(44832011)(4326008)(86362001)(2906002)(30864003)(5660300002)(8936002)(70586007)(70206006)(6916009)(82740400003)(54906003)(478600001)(36756003)(356005)(47076005)(316002)(81166007)(6666004)(83380400001)(1076003)(16526019)(336012)(2616005)(426003)(40480700001)(40460700003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:15:19.0998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37443f5e-50f3-4c02-5543-08dc229958a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915
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
Cc: Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Nevenko Stupar <nevenko.stupar@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, Hamza
 Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

This reverts commit af89970ba286ef0237b971f28721b0d3d0d6b794.

Since, it was causing regression for some DRR scenarios.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 45 ++++---------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 14 ------
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +
 .../display/dc/dcn32/dcn32_resource_helpers.c | 14 ++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 11 +++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  8 ++--
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 --
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 ++
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 12 files changed, 41 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9127805f19f4..c81f8af5d374 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -411,12 +411,9 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	 * avoid conflicting with firmware updates.
 	 */
 	if (dc->ctx->dce_version > DCE_VERSION_MAX)
-		if (dc->optimized_required)
+		if (dc->optimized_required || dc->wm_optimized_required)
 			return false;
 
-	if (!memcmp(&stream->adjust, adjust, sizeof(*adjust)))
-		return true;
-
 	dc_exit_ips_for_hw_access(dc);
 
 	stream->adjust.v_total_max = adjust->v_total_max;
@@ -2256,6 +2253,7 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 	}
 
 	dc->optimized_required = false;
+	dc->wm_optimized_required = false;
 }
 
 bool dc_set_generic_gpio_for_stereo(bool enable,
@@ -2678,6 +2676,8 @@ enum surface_update_type dc_check_update_surfaces_for_stream(
 		} else if (memcmp(&dc->current_state->bw_ctx.bw.dcn.clk, &dc->clk_mgr->clks, offsetof(struct dc_clocks, prev_p_state_change_support)) != 0) {
 			dc->optimized_required = true;
 		}
+
+		dc->optimized_required |= dc->wm_optimized_required;
 	}
 
 	return type;
@@ -2885,6 +2885,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->vrr_active_fixed)
 		stream->vrr_active_fixed = *update->vrr_active_fixed;
 
+	if (update->crtc_timing_adjust)
+		stream->adjust = *update->crtc_timing_adjust;
+
 	if (update->dpms_off)
 		stream->dpms_off = *update->dpms_off;
 
@@ -3513,33 +3516,6 @@ static void wait_for_outstanding_hw_updates(struct dc *dc, const struct dc_state
 	}
 }
 
-static void update_drr_for_full_update(struct dc *dc, struct dc_state *context)
-{
-	uint32_t i;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		struct dc_stream_state *stream = pipe->stream;
-		struct timing_generator *tg = pipe->stream_res.tg;
-		struct drr_params params = {0};
-
-		/* pipe not in use */
-		if (!resource_is_pipe_type(pipe, OTG_MASTER))
-			continue;
-
-		/* skip phantom pipes */
-		if (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM)
-			continue;
-
-		params.vertical_total_min = stream->adjust.v_total_min;
-		params.vertical_total_max = stream->adjust.v_total_max;
-		params.vertical_total_mid = stream->adjust.v_total_mid;
-		params.vertical_total_mid_frame_num = stream->adjust.v_total_mid_frame_num;
-		if (pipe->stream_res.tg->funcs->set_drr)
-			tg->funcs->set_drr(pipe->stream_res.tg, &params);
-	}
-}
-
 static void commit_planes_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
@@ -3909,10 +3885,6 @@ static void commit_planes_for_stream(struct dc *dc,
 			pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
 	}
 
-	// Update DRR for all pipes
-	if (update_type != UPDATE_TYPE_FAST)
-		update_drr_for_full_update(dc, context);
-
 	current_stream_mask = get_stream_mask(dc, context);
 	if (current_stream_mask != context->stream_mask) {
 		context->stream_mask = current_stream_mask;
@@ -4353,7 +4325,8 @@ static bool full_update_required(struct dc *dc,
 			stream_update->mst_bw_update ||
 			stream_update->func_shaper ||
 			stream_update->lut3d_func ||
-			stream_update->pending_test_pattern))
+			stream_update->pending_test_pattern ||
+			stream_update->crtc_timing_adjust))
 		return true;
 
 	if (stream) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 528d3eb245ea..bb750c3d17f8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5027,20 +5027,6 @@ enum dc_status update_dp_encoder_resources_for_test_harness(const struct dc *dc,
 	return DC_OK;
 }
 
-bool resource_subvp_in_use(struct dc *dc,
-		struct dc_state *context)
-{
-	uint32_t i;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_NONE)
-			return true;
-	}
-	return false;
-}
-
 bool check_subvp_sw_cursor_fallback_req(const struct dc *dc, struct dc_stream_state *stream)
 {
 	if (!dc->debug.disable_subvp_high_refresh && is_subvp_high_refresh_candidate(stream))
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2dec2507e971..b510c366ed12 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1039,6 +1039,7 @@ struct dc {
 
 	/* Require to optimize clocks and bandwidth for added/removed planes */
 	bool optimized_required;
+	bool wm_optimized_required;
 	bool idle_optimizations_allowed;
 	bool enable_c20_dtm_b0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index a23eebd9933b..ee10941caa59 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -139,6 +139,7 @@ union stream_update_flags {
 		uint32_t wb_update:1;
 		uint32_t dsc_changed : 1;
 		uint32_t mst_bw : 1;
+		uint32_t crtc_timing_adjust : 1;
 		uint32_t fams_changed : 1;
 	} bits;
 
@@ -325,6 +326,7 @@ struct dc_stream_update {
 	struct dc_3dlut *lut3d_func;
 
 	struct test_pattern *pending_test_pattern;
+	struct dc_crtc_timing_adjust *crtc_timing_adjust;
 };
 
 bool dc_is_stream_unchanged(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index e4a328b45c8a..87760600e154 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -183,6 +183,20 @@ bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 	return true;
 }
 
+bool dcn32_subvp_in_use(struct dc *dc,
+		struct dc_state *context)
+{
+	uint32_t i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_NONE)
+			return true;
+	}
+	return false;
+}
+
 bool dcn32_mpo_in_use(struct dc_state *context)
 {
 	uint32_t i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 4edf7df4c6aa..ba76dd4a2ce2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -33,7 +33,6 @@
 #include "dcn30/dcn30_resource.h"
 #include "link.h"
 #include "dc_state_priv.h"
-#include "resource.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -292,7 +291,7 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 
 		/* for subvp + DRR case, if subvp pipes are still present we support pstate */
 		if (vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported &&
-				resource_subvp_in_use(dc, context))
+				dcn32_subvp_in_use(dc, context))
 			vba->DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = temp_clock_change_support;
 
 		if (vlevel < context->bw_ctx.dml.vba.soc.num_states &&
@@ -2280,7 +2279,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	unsigned int dummy_latency_index = 0;
 	int maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
 	unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
-	bool subvp_active = resource_subvp_in_use(dc, context);
+	bool subvp_in_use = dcn32_subvp_in_use(dc, context);
 	unsigned int min_dram_speed_mts_margin;
 	bool need_fclk_lat_as_dummy = false;
 	bool is_subvp_p_drr = false;
@@ -2289,7 +2288,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	dc_assert_fp_enabled();
 
 	/* need to find dummy latency index for subvp */
-	if (subvp_active) {
+	if (subvp_in_use) {
 		/* Override DRAMClockChangeSupport for SubVP + DRR case where the DRR cannot switch without stretching it's VBLANK */
 		if (!pstate_en) {
 			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
@@ -2475,7 +2474,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 				dc->clk_mgr->bw_params->clk_table.entries[min_dram_speed_mts_offset].memclk_mhz * 16;
 		}
 
-		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && !subvp_active) {
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && !subvp_in_use) {
 			/* find largest table entry that is lower than dram speed,
 			 * but lower than DPM0 still uses DPM0
 			 */
@@ -3535,7 +3534,7 @@ void dcn32_set_clock_limits(const struct _vcs_dpi_soc_bounding_box_st *soc_bb)
 void dcn32_override_min_req_memclk(struct dc *dc, struct dc_state *context)
 {
 	// WA: restrict FPO and SubVP to use first non-strobe mode (DCN32 BW issue)
-	if ((context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || resource_subvp_in_use(dc, context)) &&
+	if ((context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dcn32_subvp_in_use(dc, context)) &&
 			dc->dml.soc.num_chans <= 8) {
 		int num_mclk_levels = dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 70fb22c9d48c..314798400b16 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3129,7 +3129,7 @@ void dcn10_prepare_bandwidth(
 			context,
 			false);
 
-	dc->optimized_required |= hubbub->funcs->program_watermarks(hubbub,
+	dc->wm_optimized_required = hubbub->funcs->program_watermarks(hubbub,
 			&context->bw_ctx.bw.dcn.watermarks,
 			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 			true);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 68268803e754..7557e58f58b2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2269,10 +2269,10 @@ void dcn20_prepare_bandwidth(
 	}
 
 	/* program dchubbub watermarks:
-	 * For assigning optimized_required, use |= operator since we don't want
+	 * For assigning wm_optimized_required, use |= operator since we don't want
 	 * to clear the value if the optimize has not happened yet
 	 */
-	dc->optimized_required |= hubbub->funcs->program_watermarks(hubbub,
+	dc->wm_optimized_required |= hubbub->funcs->program_watermarks(hubbub,
 					&context->bw_ctx.bw.dcn.watermarks,
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					false);
@@ -2285,10 +2285,10 @@ void dcn20_prepare_bandwidth(
 	if (hubbub->funcs->program_compbuf_size) {
 		if (context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes) {
 			compbuf_size_kb = context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes;
-			dc->optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.dml.ip.min_comp_buffer_size_kbytes);
+			dc->wm_optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.dml.ip.min_comp_buffer_size_kbytes);
 		} else {
 			compbuf_size_kb = context->bw_ctx.bw.dcn.compbuf_size_kb;
-			dc->optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.bw.dcn.compbuf_size_kb);
+			dc->wm_optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.bw.dcn.compbuf_size_kb);
 		}
 
 		hubbub->funcs->program_compbuf_size(hubbub, compbuf_size_kb, false);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 77e87c8de777..b14d52e52fa2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -609,9 +609,6 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy(
 		struct pipe_ctx *sec_pipe,
 		bool odm);
 
-bool resource_subvp_in_use(struct dc *dc,
-		struct dc_state *context);
-
 /* A test harness interface that modifies dp encoder resources in the given dc
  * state and bypasses the need to revalidate. The interface assumes that the
  * test harness interface is called with pre-validated link config stored in the
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 71cd20618bfe..6f10052caeef 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1913,7 +1913,7 @@ int dcn32_populate_dml_pipes_from_context(
 
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
-	.get_subvp_en = resource_subvp_in_use,
+	.get_subvp_en = dcn32_subvp_in_use,
 };
 
 void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 62611acd4bcb..0c87b0fabba7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -131,6 +131,9 @@ void dcn32_merge_pipes_for_subvp(struct dc *dc,
 bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 		struct dc_state *context);
 
+bool dcn32_subvp_in_use(struct dc *dc,
+		struct dc_state *context);
+
 bool dcn32_mpo_in_use(struct dc_state *context);
 
 bool dcn32_any_surfaces_rotated(struct dc *dc, struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index eefc127a9381..6f832bf278cf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1574,7 +1574,7 @@ static void dcn321_destroy_resource_pool(struct resource_pool **pool)
 
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
-	.get_subvp_en = resource_subvp_in_use,
+	.get_subvp_en = dcn32_subvp_in_use,
 };
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-- 
2.43.0

