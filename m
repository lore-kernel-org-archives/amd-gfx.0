Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9445C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB6A10E5EE;
	Wed, 28 Feb 2024 18:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZreOoyfa";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA9010E632
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2sHBt7jBcHer2TRdd7QTJ7doXRcUTAVAbS3RJcnWf1SwMc103I0OGe26eItF6mLHXFGNS2CgW/RkIHKqE0/gIFdUrIcPmV1mcQpDjUReq6KcBNXFFe+9aNj71TZlWvDmAm89NkQ67GlvoAtmt0CbugVOwNYsYQaAaAVkEDovVBOHP435107vp216ZhhOR/zTrs+yf1bbMmrTZSyHWnUx2Wwc2IlDTtEp0F1XdxoeYKtZKMzFfymicOSQ50vf88KZVsC8h9kaVzjhj0Xy+MSMIpsJ5Jh/r1qh2HHfDSr2JOb7b7QSDqx+l8Uho9MlQzNtfRS0GoWGhjJu+7HC8450g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj/SUxtIvhkYDNWMkUgTCSS56csMTDbb9UlbNt4GR08=;
 b=KNEn2qLSxiuuQ2SfdePvF/wy662ygDVuPeJ6EWyrCbaHx0F6FNyQZlvSu5HDMgHZ+v3DTCKeFrc0tKNHDYzurKQazB2e69WhfqIXEa1N/Su7nDh/PC5omaC3TDCp1vAjC3BkA8eOBkzYbaH5g8WE7iRUES9Sc8bUqDz/PuK5/TTQeIzXl7txhPrCf16oTMw69TBzYTvVN2qIS90vNpm5kAUQNkbRnszlziAtvxzv0AUIYB/A6JFLBcMaQNmnt5TbtAElKFPVCXprbP6seZTs8N/0yQbdF0KafF1zXnm1k6XBI7za/rrGV+oKeLnzBHOm7DXsAl5Wv8wR1qReXoZa7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj/SUxtIvhkYDNWMkUgTCSS56csMTDbb9UlbNt4GR08=;
 b=ZreOoyfa/jEQkW9rvUohx48ojYnD3e1OQDvd7c5T8/uw6Sb0PwmXDwC6L1pHGbZ6GSkV+VKWfvQfxpM8FQCIUBU8x4XTFqmiSa9wYJx5kVWYAPCpb7zEPgLXNTez8eK9tTDDZHmXtnSmeC/+bDq7A1UrQPeCWP2yyJMwlTGC1zU=
Received: from CY5P221CA0161.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::15)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 18:45:45 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:6a:cafe::9c) by CY5P221CA0161.outlook.office365.com
 (2603:10b6:930:6a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:45:44 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:45:42 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, George Shen
 <george.shen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alvin Lee
 <alvin.lee2@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 22/34] drm/amd/display: Add left edge pixel for YCbCr422/420 +
 ODM pipe split
Date: Wed, 28 Feb 2024 11:39:28 -0700
Message-ID: <20240228183940.1883742-23-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e8d508-73f1-4892-df77-08dc388d78ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbnBqtyw6aYj7luKs7oerLkkDcebq/vYisN28hBACDXX9WbVa1KVPUIXoqObipUtnOEvzG/8jDJ4ga4ANcajZ91tIhySObP77A7ZZBBCj9DVYGj15fSea6pJg2weHKHSs+EL1hGFi8CGXatBTL5i8AazKnvsfnW2zzmObsNTS3H1Sa84p5O9nmc/q1Ayqv15Fggme7XRx4v5YLF844amxEm5BDjh6lBFUunxm6f/2HojoOvV8aqgCdpRdUdV/P6czvw8W9RgPUIL34E6zE6TcPP/xRJXZ3W17IA0bJua2Yqsw4OatUabk9gcKfWn6pl4ptBGguBn22BOKyz8uF77ZgRnuf6G0Iihq0OpSR3qUoKo25/XfOmYx1HrczQuocp1XWDoftCDIoECJwI5KW/x0oT+9bFqmb7nE6aHhjPniEamQuAZ6aQ8S/LB+IntlpCq19SbniMy0syE3pBJeZQA5l+XfvPg1wdf6mhi/dBrOcdrMT2LaSQtVjl3mDNfxN8s26ruN7eyf/Vwl8j06mQZCDgtVsUbl9MS1Uv7p+p7LH/C6p+eKM/sPbevpxisA/rD0Pff5H3HfpLNT2fEat0Ija7pWAWP7HMtwF9AaFHUQjyrNSq61t1XpeIoNHkFHYwnUQYh5DDLCBp/s9Pq2usokLHz5ZcH714vu8dE4t9i3Oj7R4Ao9lldJQLDyZzwn+9otcTNEY5T0EvXqX1DCCyeLlpKJHfCsOjvn8jTdh1nv7ydKtcTFTOjwti8ylrnleoq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:45:44.9033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e8d508-73f1-4892-df77-08dc388d78ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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

[WHY]
Currently 3-tap chroma subsampling is used for YCbCr422/420. When ODM
pipesplit is used, pixels on the left edge of ODM slices need one extra
pixel from the right edge of the previous slice to calculate the correct
chroma value.

Without this change, the chroma value is slightly different than
expected. This is usually imperceptible visually, but it impacts test
pattern CRCs for compliance test automation.

[HOW]
Update logic to use the register for adding extra left edge pixel for
YCbCr422/420 ODM cases.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 ++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 37 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 10 +++++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  4 ++
 5 files changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index acd8f1257ade..ed6579633a58 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3147,6 +3147,10 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 			if (otg_master && otg_master->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE)
 				resource_build_test_pattern_params(&context->res_ctx, otg_master);
+
+			if (otg_master && (otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
+					otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420))
+				resource_build_subsampling_params(&context->res_ctx, otg_master);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1b7765bc5e5e..96ea283bd169 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -822,6 +822,16 @@ static struct rect calculate_odm_slice_in_timing_active(struct pipe_ctx *pipe_ct
 			stream->timing.v_border_bottom +
 			stream->timing.v_border_top;
 
+	/* Recout for ODM slices after the first slice need one extra left edge pixel
+	 * for 3-tap chroma subsampling.
+	 */
+	if (odm_slice_idx > 0 &&
+			(pipe_ctx->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
+				pipe_ctx->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)) {
+		odm_rec.x -= 1;
+		odm_rec.width += 1;
+	}
+
 	return odm_rec;
 }
 
@@ -1438,6 +1448,7 @@ void resource_build_test_pattern_params(struct resource_context *res_ctx,
 	enum controller_dp_test_pattern controller_test_pattern;
 	enum controller_dp_color_space controller_color_space;
 	enum dc_color_depth color_depth = otg_master->stream->timing.display_color_depth;
+	enum dc_pixel_encoding pixel_encoding = otg_master->stream->timing.pixel_encoding;
 	int h_active = otg_master->stream->timing.h_addressable +
 		otg_master->stream->timing.h_border_left +
 		otg_master->stream->timing.h_border_right;
@@ -1469,10 +1480,36 @@ void resource_build_test_pattern_params(struct resource_context *res_ctx,
 		else
 			params->width = last_odm_slice_width;
 
+		/* Extra left edge pixel is required for 3-tap chroma subsampling. */
+		if (i != 0 && (pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
+				pixel_encoding == PIXEL_ENCODING_YCBCR420)) {
+			params->offset -= 1;
+			params->width += 1;
+		}
+
 		offset += odm_slice_width;
 	}
 }
 
+void resource_build_subsampling_params(struct resource_context *res_ctx,
+	struct pipe_ctx *otg_master)
+{
+	struct pipe_ctx *opp_heads[MAX_PIPES];
+	int odm_cnt = 1;
+	int i;
+
+	odm_cnt = resource_get_opp_heads_for_otg_master(otg_master, res_ctx, opp_heads);
+
+	/* For ODM slices after the first slice, extra left edge pixel is required
+	 * for 3-tap chroma subsampling.
+	 */
+	if (otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422 ||
+			otg_master->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+		for (i = 0; i < odm_cnt; i++)
+			opp_heads[i]->stream_res.left_edge_extra_pixel = (i == 0) ? false : true;
+	}
+}
+
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 40098d9f70cb..a698f026198c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1579,6 +1579,11 @@ static void dcn20_detect_pipe_changes(struct dc_state *old_state,
 	if (old_pipe->stream_res.tg != new_pipe->stream_res.tg)
 		new_pipe->update_flags.bits.tg_changed = 1;
 
+	if (resource_is_pipe_type(new_pipe, OPP_HEAD)) {
+		if (old_pipe->stream_res.left_edge_extra_pixel != new_pipe->stream_res.left_edge_extra_pixel)
+			new_pipe->update_flags.bits.opp_changed = 1;
+	}
+
 	/*
 	 * Detect mpcc blending changes, only dpp inst and opp matter here,
 	 * mpccs getting removed/inserted update connected ones during their own
@@ -1962,6 +1967,11 @@ static void dcn20_program_pipe(
 			pipe_ctx->stream_res.opp,
 			&pipe_ctx->stream->bit_depth_params,
 			&pipe_ctx->stream->clamping);
+
+		if (resource_is_pipe_type(pipe_ctx, OPP_HEAD))
+			pipe_ctx->stream_res.opp->funcs->opp_program_left_edge_extra_pixel(
+				pipe_ctx->stream_res.opp,
+				pipe_ctx->stream_res.left_edge_extra_pixel);
 	}
 
 	/* Set ABM pipe after other pipe configurations done */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index b1b72e688f74..e034cbb40620 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -333,6 +333,8 @@ struct stream_resource {
 	uint8_t gsl_group;
 
 	struct test_pattern_params test_pattern_params;
+
+	bool left_edge_extra_pixel;
 };
 
 struct plane_resource {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 77a60aa9f27b..b14d52e52fa2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -107,6 +107,10 @@ void resource_build_test_pattern_params(
 		struct resource_context *res_ctx,
 		struct pipe_ctx *pipe_ctx);
 
+void resource_build_subsampling_params(
+		struct resource_context *res_ctx,
+		struct pipe_ctx *pipe_ctx);
+
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx);
 
 enum dc_status resource_build_scaling_params_for_context(
-- 
2.34.1

