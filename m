Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEB4C4829F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6F310E4C4;
	Wed,  7 Feb 2024 20:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vvSTuZz8";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5299410E460
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvZi/K19iXafghSSnWRjRSjh1CDHex4i7fu/7KnyP3lc/X6hvEOtL6tvM+lLcMEPsz7uPbtwDwntS5gNBqJqyzz2IrjKH24hOuIz5gQgVmT/QcG5rceOC0rg5C2t7m7YWOCLUGczXxCjoLNqqHDCDxLnxxNrXI/8cUFcuJKvL1+nhQ0yWdqRRrSC6UiOAo0vaxswL3D4UpX4J3QMWquhv/b+QNHSK2RFEuzU3bz1J2KkIMkLu1vFGxNHUmnX9NC1AStlAPCbUcKN7BeZ/ul1SikD6bPr5oNABsOOo9T3iyKaM6ude3VxcrnD1GJxYBg/PR5P2CHedjJGJAYwpmHcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heEjFPlA1i+6gfCZC7ArCgZwFltR8YwalZDLMp2ub0E=;
 b=kFbjabT7FHL/5k7GY0P88NCRSLeHRd1RPkX5o/Az94sXnPIo6+yBPEfz8PNJCu62GHoeD206FHwmQmR/Fe/qr1mdLtdvm9O3p6aRPC7cb4R90894S/g7vjxtGIgeNABe2GKGta/ijr2JEBxxys4kYFHHXBb8iNHBpGImDDcU1k5sbxVF+V/8iOBzg73wIEKJ8xjNIp/zQpJ9ohMZpkv178EmQ8tjov+GmPhq7nUYUBoD3hMY+LSHQSzZZespvR2KFjZCZNYHCDDn0GzuhwPQlAJYkwd+Jjm8IYjy+O8ULV4Q4fLIDj8519NDSVaIu+9Y4mpXW8NgTWRDKGYWn4TcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heEjFPlA1i+6gfCZC7ArCgZwFltR8YwalZDLMp2ub0E=;
 b=vvSTuZz8TVQP8aNZNSS1K7DWxvRvhG+oaLz4D8ZrP58wO3Yf/7WY+iKIEtboQiE3uvh4mNmszQQXLEHATXfq2Cgb8saXez0eZ9a50pH36NVKJpoW+LrUuu2TlSCJRkzTWyQkXbYf/E+kbOYE2F21JRqyq2vejBE6PUO00wU+AUw=
Received: from DM6PR18CA0021.namprd18.prod.outlook.com (2603:10b6:5:15b::34)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 20:52:21 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::9a) by DM6PR18CA0021.outlook.office365.com
 (2603:10b6:5:15b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:52:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:17 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:17 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, George Shen
 <george.shen@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 14/15] Revert "drm/amd/display: Add left edge pixel for
 YCbCr422/420 + ODM pipe split"
Date: Wed, 7 Feb 2024 15:50:49 -0500
Message-ID: <20240207205200.1608684-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|BL1PR12MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: cf5e3038-00a2-4d54-b3fe-08dc281eadc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwKL0uWIV8osA+VzfEIpiz+9yHGWlc+fNap5mumx0ay5N4dlu6vyCoWcc+tHwWMidkxO0EZ/ZmN6pyy0BCrfqInBujlhgv3C+F+rt2WIozUBGdS+81V/Je5ZX239LHksuTZSsjX1+ox1iE2ihNEZ15PipXlpXR7sITyhf6salVCZwstN+n3nMLYUI5jmsrrvdnBjORY+ZDev5gVpvKjL/w325sjaWuCkcvuq/1K1HT6BEeWuhTEtzdnbxKWw0GFAegG/ZGjvSNWvo8/WR+23W9mGtjWM9+sJrXXPy2CwgFoRmF49cOwNxN6cs+MuQ+6+0Wp+WG70OxkMx4Jbp6KT1h+aLLheU1r1dsWaCH9cB02uCEKn4Ui8p96RjB8xVPyjnGxojXBZWJtNROlIuJ9wzwBqAos9U23+QwcPaRadRWmuEE6no1RQNml6ZXQFSqUKHAh4WDOdrffBuE9BBbAQ4bmIK8cdF/zVntnQ6dZ2j1uY8QcayJVS8s07rbMcPWfMo1DJELey3neY7DXa42RHtkXFND0Bnp4oHPqeZxuaOY9O8ctcVDN+dTnbhzGuVGweeyPY+o8ZfqdSPoQ6/VpreHtckQz46XbZdMHwc5IzZOo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(6029001)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(81166007)(54906003)(82740400003)(6916009)(83380400001)(356005)(2616005)(8676002)(336012)(6666004)(7696005)(26005)(1076003)(70586007)(316002)(70206006)(44832011)(86362001)(2906002)(5660300002)(426003)(4326008)(478600001)(8936002)(36756003)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:20.7699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5e3038-00a2-4d54-b3fe-08dc281eadc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
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

From: George Shen <george.shen@amd.com>

[Why/How]
A regression was identified with the change to add left edge pixel for
YCbCr422/420 + ODM combine cases.

This reverts commit 8d09500a33f6a0e0df9cf17822fe51520d0df002

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 --
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 37 -------------------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  7 +---
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  4 --
 5 files changed, 1 insertion(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1d0fd69cc7bd..4d5194293dbd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3098,10 +3098,6 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 			if (otg_master && otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
 				resource_build_test_pattern_params(&context->res_ctx, otg_master);
-
-			if (otg_master && (otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
-					otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420))
-				resource_build_subsampling_params(&context->res_ctx, otg_master);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 96ea283bd169..1b7765bc5e5e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -822,16 +822,6 @@ static struct rect calculate_odm_slice_in_timing_active(struct pipe_ctx *pipe_ct
 			stream->timing.v_border_bottom +
 			stream->timing.v_border_top;
 
-	/* Recout for ODM slices after the first slice need one extra left edge pixel
-	 * for 3-tap chroma subsampling.
-	 */
-	if (odm_slice_idx > 0 &&
-			(pipe_ctx->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
-				pipe_ctx->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)) {
-		odm_rec.x -= 1;
-		odm_rec.width += 1;
-	}
-
 	return odm_rec;
 }
 
@@ -1448,7 +1438,6 @@ void resource_build_test_pattern_params(struct resource_context *res_ctx,
 	enum controller_dp_test_pattern controller_test_pattern;
 	enum controller_dp_color_space controller_color_space;
 	enum dc_color_depth color_depth = otg_master->stream->timing.display_color_depth;
-	enum dc_pixel_encoding pixel_encoding = otg_master->stream->timing.pixel_encoding;
 	int h_active = otg_master->stream->timing.h_addressable +
 		otg_master->stream->timing.h_border_left +
 		otg_master->stream->timing.h_border_right;
@@ -1480,36 +1469,10 @@ void resource_build_test_pattern_params(struct resource_context *res_ctx,
 		else
 			params->width = last_odm_slice_width;
 
-		/* Extra left edge pixel is required for 3-tap chroma subsampling. */
-		if (i != 0 && (pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
-				pixel_encoding == PIXEL_ENCODING_YCBCR420)) {
-			params->offset -= 1;
-			params->width += 1;
-		}
-
 		offset += odm_slice_width;
 	}
 }
 
-void resource_build_subsampling_params(struct resource_context *res_ctx,
-	struct pipe_ctx *otg_master)
-{
-	struct pipe_ctx *opp_heads[MAX_PIPES];
-	int odm_cnt = 1;
-	int i;
-
-	odm_cnt = resource_get_opp_heads_for_otg_master(otg_master, res_ctx, opp_heads);
-
-	/* For ODM slices after the first slice, extra left edge pixel is required
-	 * for 3-tap chroma subsampling.
-	 */
-	if (otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
-			otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
-		for (i = 0; i < odm_cnt; i++)
-			opp_heads[i]->stream_res.left_edge_extra_pixel = (i == 0) ? false : true;
-	}
-}
-
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index f15ba7335336..c55d5155ecb9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1573,8 +1573,7 @@ static void dcn20_detect_pipe_changes(struct dc_state *old_state,
 	 * makes this assumption at the moment with how hubp reset is matched to
 	 * same index mpcc reset.
 	 */
-	if (old_pipe->stream_res.opp != new_pipe->stream_res.opp ||
-			old_pipe->stream_res.left_edge_extra_pixel != new_pipe->stream_res.left_edge_extra_pixel)
+	if (old_pipe->stream_res.opp != new_pipe->stream_res.opp)
 		new_pipe->update_flags.bits.opp_changed = 1;
 	if (old_pipe->stream_res.tg != new_pipe->stream_res.tg)
 		new_pipe->update_flags.bits.tg_changed = 1;
@@ -1962,10 +1961,6 @@ static void dcn20_program_pipe(
 			pipe_ctx->stream_res.opp,
 			&pipe_ctx->stream->bit_depth_params,
 			&pipe_ctx->stream->clamping);
-
-		pipe_ctx->stream_res.opp->funcs->opp_program_left_edge_extra_pixel(
-			pipe_ctx->stream_res.opp,
-			pipe_ctx->stream_res.left_edge_extra_pixel);
 	}
 
 	/* Set ABM pipe after other pipe configurations done */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index ebb659c327e0..3a6bf77a6873 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -333,8 +333,6 @@ struct stream_resource {
 	uint8_t gsl_group;
 
 	struct test_pattern_params test_pattern_params;
-
-	bool left_edge_extra_pixel;
 };
 
 struct plane_resource {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index b14d52e52fa2..77a60aa9f27b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -107,10 +107,6 @@ void resource_build_test_pattern_params(
 		struct resource_context *res_ctx,
 		struct pipe_ctx *pipe_ctx);
 
-void resource_build_subsampling_params(
-		struct resource_context *res_ctx,
-		struct pipe_ctx *pipe_ctx);
-
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx);
 
 enum dc_status resource_build_scaling_params_for_context(
-- 
2.43.0

