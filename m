Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CC2E7B5E1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E1DE10E35D;
	Wed,  4 Oct 2023 09:25:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CBB210E35D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGE3WsvBmPFLsJGLGfx5jcnCz9JcHMkzKoy6+q/52xx41GdFG8jtp6FN8cFkjhCZTc51zkGmKtCtV9710Q8yGPzKtER7bF59tihO1ty+7gJ2J0cw6HC5elNxDn6rF7EytFRWg6e13sxnuoFvKoyww06dv7yAPQ58BoU4VyC+8kW8QezuKe3DNwJaYuRHlsAsLHv66KjgmJhdC+Y3rXAXS0OY4zcc0Um7KFJVXz6gqnaR8Xla6eP1eVFbzi2jalWaBhT507Ox3jQ1DjGeQfo7MH4n+eSoNq2X7GnSCsEEuiusx4MMgoei2ai8nvkJhO8SHipaItCZxAk1UwjqgnrEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BWZb9bX6BMKrFcayPwTvXmqPXzp4B2Xet8O9PYEsaI=;
 b=XH2QvMPS0QZT/tlw0XTXwlzlVkGmlGp6HrwNBN/GD18q2k87/ALm6sN+TJvqvYsMu9+dMlR/8DGn1BXxirm62vQYOAtLLgnUwF8pWEBmX1sQVT3fF3Pq/ocmi5SJxTZJNN333XGkJrx8gHpXyJFuOtxRr7PxbY+VoBNQQpd9NtCJro/jOxSfou8ZwUachgAvxmQY4I7xN2AQNo9g9feKPRKJChA4uuqYW6sTXDEWJP1sodgZXauieJMGXzmE7Y2mOpqBonRZ9JUxYZ7btIG0sOrI4K4/XTDFgS5pLHVCOqcU2VoS3LcDMA/WEiVZ92A9uZMo62IAaJ7vv7KnDiLcTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BWZb9bX6BMKrFcayPwTvXmqPXzp4B2Xet8O9PYEsaI=;
 b=3a0mZEJo/93RwFYFsd411PgvSla5ZFmXTG+AWhv12edyNId0yJaUO0ZNp9Cm8vke3yG65vTmPOckUsVlBRJ+Hr1e/XEL8ZZjya1zP3goweztbniU96nsE4aWp1UNaAjlNudCXbxomXXyae4NDUhWyR+yxYJHUz1v4wg0e0fhQe4=
Received: from MN2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:208:120::26)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 09:24:58 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::3) by MN2PR10CA0013.outlook.office365.com
 (2603:10b6:208:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 09:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:24:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:24:57 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:24:51 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: Refactor DPG test pattern logic for
 ODM cases
Date: Wed, 4 Oct 2023 17:22:59 +0800
Message-ID: <20231004092301.2371458-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: bb901bb7-85ee-46d8-6dd2-08dbc4bbc6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWSKD8xlOVh9HAdfgo/6sCZuaUDkvJ+/R/QWNsj+2bby9dCGqHzhQXHivEPmFL+Js2W0LeJWN/wfERI25VSsy9XMw+3rzYLRPEPvk+uleNfzfB+FR80zuJgfx2tPCwsPdHziR+/7RtgKYk09toFxi4gT9ni3rvD/EXOdxnMCFRxz4ZysZ+ia3Jz6gj1Yk/y2h6LXTLRg3sdOY6hz47lYUfnQx3kKQeUDTcRxopDEDzi5v9ckea95eZ+d5A//vYmzQuDbvqIdJ5Jtb3gmFkt2Ct0n5Nx9UvJFltZT0aVoAslRqcmfHVDQ0kp+onrXG+0IiUkyrjyE/0yN7ajyjjEaqblveAfs5It/Tae7nCfyHncC4pHTT4752+WTwJGE6EaqNNdCFZp+BTjSKNzo+zuY3qRAhB34MAbyr4nHHdNp7zGB6IU8aBJqQiinFoHQ3jAH2nLXIGmHl7x4XxadSaDJs6Xxk28Wn0WwMqC4MKP4TtVc2JGjP5r9KqPDD9NRcrYgGQeERuqY5hW4E8nyrLhs+14HMHB2UtapwSdcJmo2ye2ALJHyMk3GskA08heb9Eit41EHQvPeFtUiEoGA9pl47+Tkd4v0G8F7fdsJMZDcYy3IgZB7MdSbMaNEw0V6XO951GpvAya7L8Xvglf4znckcO6Gr7ZRofl0U03+H9vIKamwPV6TBDdqlX9UDnFNrN11BuG2uzXA033DaAa2ltXuSBWm1Mcu8UYJeU3AtUZ8SKsfyV1hE4JzrST1eOa6AvAgL/sYPtCOLMsRe0SnhfDb6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(1076003)(41300700001)(7696005)(478600001)(2616005)(316002)(6916009)(70206006)(70586007)(54906003)(336012)(426003)(8676002)(4326008)(8936002)(5660300002)(26005)(47076005)(40460700003)(30864003)(83380400001)(2906002)(82740400003)(81166007)(356005)(36860700001)(36756003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:24:57.6458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb901bb7-85ee-46d8-6dd2-08dbc4bbc6d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Current DPG test pattern logic does not account for ODM configuration
changes after test pattern has already been programmed. For example, if
ODM2:1 is enabled after test pattern is already being output, the second
pipe is not programmed to output test pattern, causing half the screen
to be black.

[How]
Move DPG test pattern parameter calculations into separate function.
Whenever ODM pipe configuration changes, re-calculate DPG test pattern
parameters and program DPG if test pattern is currently enabled.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 ++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 104 ++++++++++++++++
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  22 ++++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  13 ++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 +
 .../display/dc/link/accessories/link_dp_cts.c | 117 ++++--------------
 6 files changed, 175 insertions(+), 93 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 88d41bf6d53a..544c915469f9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3145,6 +3145,14 @@ static bool update_planes_and_stream_state(struct dc *dc,
 			BREAK_TO_DEBUGGER();
 			goto fail;
 		}
+
+		for (i = 0; i < context->stream_count; i++) {
+			struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(&context->res_ctx,
+					context->streams[i]);
+
+			if (otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
+				resource_build_test_pattern_params(&context->res_ctx, otg_master);
+		}
 	}
 
 	*new_context = context;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 3549a9b852a2..22e05f3d01e0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1360,6 +1360,110 @@ static bool is_subvp_high_refresh_candidate(struct dc_stream_state *stream)
 	return false;
 }
 
+static enum controller_dp_test_pattern convert_dp_to_controller_test_pattern(
+				enum dp_test_pattern test_pattern)
+{
+	enum controller_dp_test_pattern controller_test_pattern;
+
+	switch (test_pattern) {
+	case DP_TEST_PATTERN_COLOR_SQUARES:
+		controller_test_pattern =
+				CONTROLLER_DP_TEST_PATTERN_COLORSQUARES;
+	break;
+	case DP_TEST_PATTERN_COLOR_SQUARES_CEA:
+		controller_test_pattern =
+				CONTROLLER_DP_TEST_PATTERN_COLORSQUARES_CEA;
+	break;
+	case DP_TEST_PATTERN_VERTICAL_BARS:
+		controller_test_pattern =
+				CONTROLLER_DP_TEST_PATTERN_VERTICALBARS;
+	break;
+	case DP_TEST_PATTERN_HORIZONTAL_BARS:
+		controller_test_pattern =
+				CONTROLLER_DP_TEST_PATTERN_HORIZONTALBARS;
+	break;
+	case DP_TEST_PATTERN_COLOR_RAMP:
+		controller_test_pattern =
+				CONTROLLER_DP_TEST_PATTERN_COLORRAMP;
+	break;
+	default:
+		controller_test_pattern =
+				CONTROLLER_DP_TEST_PATTERN_VIDEOMODE;
+	break;
+	}
+
+	return controller_test_pattern;
+}
+
+static enum controller_dp_color_space convert_dp_to_controller_color_space(
+		enum dp_test_pattern_color_space color_space)
+{
+	enum controller_dp_color_space controller_color_space;
+
+	switch (color_space) {
+	case DP_TEST_PATTERN_COLOR_SPACE_RGB:
+		controller_color_space = CONTROLLER_DP_COLOR_SPACE_RGB;
+		break;
+	case DP_TEST_PATTERN_COLOR_SPACE_YCBCR601:
+		controller_color_space = CONTROLLER_DP_COLOR_SPACE_YCBCR601;
+		break;
+	case DP_TEST_PATTERN_COLOR_SPACE_YCBCR709:
+		controller_color_space = CONTROLLER_DP_COLOR_SPACE_YCBCR709;
+		break;
+	case DP_TEST_PATTERN_COLOR_SPACE_UNDEFINED:
+	default:
+		controller_color_space = CONTROLLER_DP_COLOR_SPACE_UDEFINED;
+		break;
+	}
+
+	return controller_color_space;
+}
+
+void resource_build_test_pattern_params(struct resource_context *res_ctx,
+				struct pipe_ctx *otg_master)
+{
+	int odm_slice_width, last_odm_slice_width, offset = 0;
+	struct pipe_ctx *opp_heads[MAX_PIPES];
+	struct test_pattern_params *params;
+	int odm_cnt = 1;
+	enum controller_dp_test_pattern controller_test_pattern;
+	enum controller_dp_color_space controller_color_space;
+	enum dc_color_depth color_depth = otg_master->stream->timing.display_color_depth;
+	int h_active = otg_master->stream->timing.h_addressable +
+		otg_master->stream->timing.h_border_left +
+		otg_master->stream->timing.h_border_right;
+	int v_active = otg_master->stream->timing.v_addressable +
+		otg_master->stream->timing.v_border_bottom +
+		otg_master->stream->timing.v_border_top;
+	int i;
+
+	controller_test_pattern = convert_dp_to_controller_test_pattern(
+			otg_master->stream->test_pattern.type);
+	controller_color_space = convert_dp_to_controller_color_space(
+			otg_master->stream->test_pattern.color_space);
+
+	odm_cnt = resource_get_opp_heads_for_otg_master(otg_master, res_ctx, opp_heads);
+
+	odm_slice_width = h_active / odm_cnt;
+	last_odm_slice_width = h_active - odm_slice_width * (odm_cnt - 1);
+
+	for (i = 0; i < odm_cnt; i++) {
+		params = &opp_heads[i]->stream_res.test_pattern_params;
+		params->test_pattern = controller_test_pattern;
+		params->color_space = controller_color_space;
+		params->color_depth = color_depth;
+		params->height = v_active;
+		params->offset = offset;
+
+		if (i < odm_cnt - 1)
+			params->width = odm_slice_width;
+		else
+			params->width = last_odm_slice_width;
+
+		offset += odm_slice_width;
+	}
+}
+
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index d8c02f83b7d7..4d6493e0ccfc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1538,6 +1538,11 @@ static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx
 
 	if (old_pipe->unbounded_req != new_pipe->unbounded_req)
 		new_pipe->update_flags.bits.unbounded_req = 1;
+
+	if (memcmp(&old_pipe->stream_res.test_pattern_params,
+				&new_pipe->stream_res.test_pattern_params, sizeof(struct test_pattern_params))) {
+		new_pipe->update_flags.bits.test_pattern_changed = 1;
+	}
 }
 
 static void dcn20_update_dchubp_dpp(
@@ -1846,6 +1851,23 @@ static void dcn20_program_pipe(
 				pipe_ctx->stream->abm_level);
 		}
 	}
+
+	if (pipe_ctx->update_flags.bits.test_pattern_changed) {
+		struct output_pixel_processor *odm_opp = pipe_ctx->stream_res.opp;
+		struct bit_depth_reduction_params params;
+
+		memset(&params, 0, sizeof(params));
+		odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
+		dc->hwss.set_disp_pattern_generator(dc,
+				pipe_ctx,
+				pipe_ctx->stream_res.test_pattern_params.test_pattern,
+				pipe_ctx->stream_res.test_pattern_params.color_space,
+				pipe_ctx->stream_res.test_pattern_params.color_depth,
+				NULL,
+				pipe_ctx->stream_res.test_pattern_params.width,
+				pipe_ctx->stream_res.test_pattern_params.height,
+				pipe_ctx->stream_res.test_pattern_params.offset);
+	}
 }
 
 void dcn20_program_front_end_for_ctx(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index c095ccbb80c4..92e52b218150 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -308,6 +308,16 @@ struct dcn_fe_bandwidth {
 
 };
 
+/* Parameters needed to call set_disp_pattern_generator */
+struct test_pattern_params {
+	enum controller_dp_test_pattern test_pattern;
+	enum controller_dp_color_space color_space;
+	enum dc_color_depth color_depth;
+	int width;
+	int height;
+	int offset;
+};
+
 struct stream_resource {
 	struct output_pixel_processor *opp;
 	struct display_stream_compressor *dsc;
@@ -324,6 +334,8 @@ struct stream_resource {
 	 * otherwise it's using group number 'gsl_group-1'
 	 */
 	uint8_t gsl_group;
+
+	struct test_pattern_params test_pattern_params;
 };
 
 struct plane_resource {
@@ -367,6 +379,7 @@ union pipe_update_flags {
 		uint32_t plane_changed : 1;
 		uint32_t det_size : 1;
 		uint32_t unbounded_req : 1;
+		uint32_t test_pattern_changed : 1;
 	} bits;
 	uint32_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 67d1ec0f3c68..06ca8bfb91e7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -103,6 +103,10 @@ enum dc_status resource_map_pool_resources(
 		struct dc_state *context,
 		struct dc_stream_state *stream);
 
+void resource_build_test_pattern_params(
+		struct resource_context *res_ctx,
+		struct pipe_ctx *pipe_ctx);
+
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx);
 
 enum dc_status resource_build_scaling_params_for_context(
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index fe4282771cd0..0894e6aef3dd 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -429,49 +429,13 @@ static void set_crtc_test_pattern(struct dc_link *link,
 	struct bit_depth_reduction_params params;
 	struct output_pixel_processor *opp = pipe_ctx->stream_res.opp;
 	struct pipe_ctx *odm_pipe;
-	int odm_cnt = 1;
-	int h_active = pipe_ctx->stream->timing.h_addressable +
-		pipe_ctx->stream->timing.h_border_left +
-		pipe_ctx->stream->timing.h_border_right;
-	int v_active = pipe_ctx->stream->timing.v_addressable +
-		pipe_ctx->stream->timing.v_border_bottom +
-		pipe_ctx->stream->timing.v_border_top;
-	int odm_slice_width, last_odm_slice_width, offset = 0;
+	struct test_pattern_params *tp_params;
 
 	memset(&params, 0, sizeof(params));
 
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-		odm_cnt++;
-
-	odm_slice_width = h_active / odm_cnt;
-	last_odm_slice_width = h_active - odm_slice_width * (odm_cnt - 1);
-
-	switch (test_pattern) {
-	case DP_TEST_PATTERN_COLOR_SQUARES:
-		controller_test_pattern =
-				CONTROLLER_DP_TEST_PATTERN_COLORSQUARES;
-	break;
-	case DP_TEST_PATTERN_COLOR_SQUARES_CEA:
-		controller_test_pattern =
-				CONTROLLER_DP_TEST_PATTERN_COLORSQUARES_CEA;
-	break;
-	case DP_TEST_PATTERN_VERTICAL_BARS:
-		controller_test_pattern =
-				CONTROLLER_DP_TEST_PATTERN_VERTICALBARS;
-	break;
-	case DP_TEST_PATTERN_HORIZONTAL_BARS:
-		controller_test_pattern =
-				CONTROLLER_DP_TEST_PATTERN_HORIZONTALBARS;
-	break;
-	case DP_TEST_PATTERN_COLOR_RAMP:
-		controller_test_pattern =
-				CONTROLLER_DP_TEST_PATTERN_COLORRAMP;
-	break;
-	default:
-		controller_test_pattern =
-				CONTROLLER_DP_TEST_PATTERN_VIDEOMODE;
-	break;
-	}
+	resource_build_test_pattern_params(&link->dc->current_state->res_ctx,
+			pipe_ctx);
+	controller_test_pattern = pipe_ctx->stream_res.test_pattern_params.test_pattern;
 
 	switch (test_pattern) {
 	case DP_TEST_PATTERN_COLOR_SQUARES:
@@ -490,51 +454,29 @@ static void set_crtc_test_pattern(struct dc_link *link,
 			enum controller_dp_color_space controller_color_space;
 			struct output_pixel_processor *odm_opp;
 
-			switch (test_pattern_color_space) {
-			case DP_TEST_PATTERN_COLOR_SPACE_RGB:
-				controller_color_space = CONTROLLER_DP_COLOR_SPACE_RGB;
-				break;
-			case DP_TEST_PATTERN_COLOR_SPACE_YCBCR601:
-				controller_color_space = CONTROLLER_DP_COLOR_SPACE_YCBCR601;
-				break;
-			case DP_TEST_PATTERN_COLOR_SPACE_YCBCR709:
-				controller_color_space = CONTROLLER_DP_COLOR_SPACE_YCBCR709;
-				break;
-			case DP_TEST_PATTERN_COLOR_SPACE_UNDEFINED:
-			default:
-				controller_color_space = CONTROLLER_DP_COLOR_SPACE_UDEFINED;
-				DC_LOG_ERROR("%s: Color space must be defined for test pattern", __func__);
+			controller_color_space = pipe_ctx->stream_res.test_pattern_params.color_space;
+
+			if (controller_color_space == CONTROLLER_DP_COLOR_SPACE_UDEFINED) {
+				DC_LOG_WARNING("%s: Color space must be defined for test pattern", __func__);
 				ASSERT(0);
-				break;
 			}
 
 			odm_pipe = pipe_ctx;
-			while (odm_pipe->next_odm_pipe) {
+			while (odm_pipe) {
+				tp_params = &odm_pipe->stream_res.test_pattern_params;
 				odm_opp = odm_pipe->stream_res.opp;
 				odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
 				link->dc->hwss.set_disp_pattern_generator(link->dc,
 						odm_pipe,
-						controller_test_pattern,
-						controller_color_space,
-						color_depth,
+						tp_params->test_pattern,
+						tp_params->color_space,
+						tp_params->color_depth,
 						NULL,
-						odm_slice_width,
-						v_active,
-						offset);
-				offset += odm_slice_width;
+						tp_params->width,
+						tp_params->height,
+						tp_params->offset);
 				odm_pipe = odm_pipe->next_odm_pipe;
 			}
-			odm_opp = odm_pipe->stream_res.opp;
-			odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
-			link->dc->hwss.set_disp_pattern_generator(link->dc,
-					odm_pipe,
-					controller_test_pattern,
-					controller_color_space,
-					color_depth,
-					NULL,
-					last_odm_slice_width,
-					v_active,
-					offset);
 		}
 	}
 	break;
@@ -552,32 +494,21 @@ static void set_crtc_test_pattern(struct dc_link *link,
 			struct output_pixel_processor *odm_opp;
 
 			odm_pipe = pipe_ctx;
-			while (odm_pipe->next_odm_pipe) {
+			while (odm_pipe) {
+				tp_params = &odm_pipe->stream_res.test_pattern_params;
 				odm_opp = odm_pipe->stream_res.opp;
 				odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
 				link->dc->hwss.set_disp_pattern_generator(link->dc,
 						odm_pipe,
-						CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
-						CONTROLLER_DP_COLOR_SPACE_UDEFINED,
-						color_depth,
+						tp_params->test_pattern,
+						tp_params->color_space,
+						tp_params->color_depth,
 						NULL,
-						odm_slice_width,
-						v_active,
-						offset);
-				offset += odm_slice_width;
+						tp_params->width,
+						tp_params->height,
+						tp_params->offset);
 				odm_pipe = odm_pipe->next_odm_pipe;
 			}
-			odm_opp = odm_pipe->stream_res.opp;
-			odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
-			link->dc->hwss.set_disp_pattern_generator(link->dc,
-					odm_pipe,
-					CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
-					CONTROLLER_DP_COLOR_SPACE_UDEFINED,
-					color_depth,
-					NULL,
-					last_odm_slice_width,
-					v_active,
-					offset);
 		}
 	}
 	break;
-- 
2.25.1

