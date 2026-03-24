Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0861FEC116
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556AB10E063;
	Tue, 24 Mar 2026 21:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nfpsF7B8";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012009.outbound.protection.outlook.com
 [40.107.200.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1548710E10A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:06:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tW0G4Xr2FuVsLuTRVD5ujDdndcKmL4u5K/L0m9aA/sCCGK6CLuHt3BfwSN+eFfPIH+JxweKfzBUeR9xsJvGSBKHCUCHA35OsEn4UFr3Qu1VKN0wir64LZUM4U9Akgx3MDfsVt/fBnrZ6pueGYOqtRo4rPsga9ByHJDEox3KP/jEoJKoqPHwQukbxIOm9/0ArKCEcUD/hnxuzjjjsZrPCGBNXX3Kx6jNdUA1vNK+6L13Y5c/qQMKWroyg421Ah1H9frBitJ/sO1VpjGOjUyOCGQ3RvTh8juz93FIqfvYHWSSydj0IFZX8eGWAjnAvy6wlfpaQ6ZdprykZTRogTpjhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2LgosbRFzZ+1PGl0yrTVu3+t117Dits+aF85F3nzbI=;
 b=rF0zQdMCPqlgfGRATDbkzEFP2adbF6JDwS+SPLqd4PL6ePW5ADyr2SK6X9gfYOOgBfNcZHc6VLuTxeuL+gy6cBG/YZNpopOz6SdLNSIP05xAqeqC4pzwciRiBMhwXq6yz6gPUGFmfj/Ra0ocaZ/+ONhctxgb57rS1txAG7/A7d95DaKqvjMrAS6Ki/CUqjBKXguwO7kbzhpNCD8630l9V3gDCW5bO5OWcoMYZQKsO4aI2VLhpLHD7nOduqr6cfrkj6IQoCR7IPhZXX59RJanL1+pSv+Cki8TBO8BkKXcK5W/g6JHlsCQRyc/4hrwRlZXtEh3Wb1SUVooxvj+1cUz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2LgosbRFzZ+1PGl0yrTVu3+t117Dits+aF85F3nzbI=;
 b=nfpsF7B8Vp/PKGfC4N0Glm+SZemdOC4zfVNNUtcGF13mhplUFYn83KbKyd4q9ZzQpTEm21GwPP67jOIsHwH5EuHpAgGA6cT0JOzBgj8YFcLOKntB3Ok+GdZwErznytcJ0uVr0ASAeHhMOjhhwb4aFB0R4KqBDOO0Fj4ep9zGI6Y=
Received: from SJ0PR13CA0179.namprd13.prod.outlook.com (2603:10b6:a03:2c7::34)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:06:46 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::e2) by SJ0PR13CA0179.outlook.office365.com
 (2603:10b6:a03:2c7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Tue,
 24 Mar 2026 21:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:06:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:06:44 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 14:06:44 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Mar 2026 16:06:43 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, "Kovac, Krunoslav"
 <Krunoslav.Kovac@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Mario Kleiner
 <mario.kleiner.de@gmail.com>
Subject: [PATCH] drm/amd/display: Dither when plane bpc is higher than output
 bpc
Date: Tue, 24 Mar 2026 17:04:48 -0400
Message-ID: <20260324210447.541630-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
References: <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fac092c-3fd2-4390-d957-08de89e94176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qzvyFauuj/R3Lk75Hizj1gsxtRKTZyJCNLR72FVcn7eKx7YA+QnkR5lpyIXI4wVlRv4WwWCz5T9gqaVB8O223KXWwlyGPD4/jIOSR5YshEQnvzrn2/KXQmhcdJMt6LpDwj2P7QWhLhVvDR1/jE00AlyQs/CHyeK+JD8zGYWp062Ow1oqUpx6URiUimrO5yE2sYwEEetGqKoCPZ4WV10+DPuU0uuy00zm00jXybEiZ/awhxLpCJnGQ6i0FUp0zZYHzdB82aPeMfYzTmeuqBOAlgkLXsjnThUItzeyYNaJKr67xB2tOFCgAPl5fEG1wCxeZtDZMTED2MHUfg7xlC3/PZgoo233DGG2ZWERmX8ecg/fsQ5hPiVgYR1PMeWY457vwcs54a5GgZ9EEJWOj7Lfa26Mc1AEGjqGmNN7rF2JleeqiT7T+KA6h7RwIumb5uHcjNYaEYfp5fSd6C7dnDwEgXxXzTJSDl5OjHPwuKxY3G7/aXwMQAUDtKByBIEiWK77r4PLgEsoCUyOV9IcrNKHLX4DQUzJcq5tIw70o3dQyNot4XG7SzcdxBaKn5n2vUzirYysza0Uq3GIESleY31ZKQkJ1yyE5bIUw61i9O1JgPRS4SfAopQ1sIVpKoP0/a0/PaIn0xYfIgBsKP3PJI34Sjuluarhe2Kzy+lqXl3ZwZhxB/rjTecv0CtWMJs+sULAGet1LWGHdN+9Su+9H3oM/9Q7JTsaq5LZZ98GXBsJYKrWdgyDjicUgDaxl1/RPIJBa6apENAz8ECjqHeBTTZQ1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K+xfhYSdv/eLGVd3oiFwlnuLDmvGUbWpzIY3MNF/XTO3lZNvwfJms5ksSZlfBCSHDkJn1eIQIir0BLe7MV5KB7evz7GQiw84k8IzLjIKWNu5iABnnd6V2zz033/CgMrnM8v+wdQz/HibfEyTyf7291XUmZbmDC5S8XGhlv5P/YWl5BSwi1N3x+YIInwjwADsj9IZsZGtMQOvDImI5GybGlGMOjilOpUYMwdyPX0K8kL8tQOByDySCxCrV7wODBFMBYV9uteskMV2Ylv8aqaTlKDZ1YoIzV6u75uY9j4v+7lRUYNUQOg9MULHwDzvmUDHFrN/IuYblXV6bWcTVDGVKNbSOdsTZ/wndvMMBWpzJjopo0gG9vsZC+D8JKmrRVSZFDeqpPecKiGnFoqY7T1FR3r0oet1AvOzmdQRd6YmAyl1Fungg+eNtgghKlw4Q/yU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:06:45.0722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fac092c-3fd2-4390-d957-08de89e94176
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
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

We don't want to dither when a 10bpc buffer is output on a 10bpc
connection as we'd get off-by-one errors. But we do want to dither
if we have planes with a higher bit depth.

In order to solve this, look at all planes, and pick TRUN dither
when input bit depth doesn't exceed output bit depth, otherwise
pick SPATIAL.

Cc: Kovac, Krunoslav <Krunoslav.Kovac@amd.com>
Cc: Hung, Alex <Alex.Hung@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Reported-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---

Mario, Kruno,

this patch looks at planes and picks dither based on the max
bit depth of all planes on the stream. Would this work for
both of you?

I've only made sure my Rembrandt system boots with this but
haven't been able to confirm that the correct dither mode is
selected.

Harry

 drivers/gpu/drm/amd/display/dc/core/dc.c      |   5 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   3 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 110 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   3 +-
 .../display/dc/link/accessories/link_dp_cts.c |   3 +-
 .../dc/resource/dce110/dce110_resource.c      |   3 +-
 .../dc/resource/dcn10/dcn10_resource.c        |   3 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   3 +-
 8 files changed, 122 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8b21816cf7c8..56d6f9d2fcca 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -788,7 +788,7 @@ void dc_stream_set_dither_option(struct dc_stream_state *stream,
 	stream->dither_option = option;
 
 	memset(&params, 0, sizeof(params));
-	resource_build_bit_depth_reduction_params(stream, &params);
+	resource_build_bit_depth_reduction_params(stream, &params, stream->ctx->dc);
 	stream->bit_depth_params = params;
 
 	if (pipes->plane_res.xfm &&
@@ -3841,7 +3841,8 @@ static void commit_planes_do_stream_update(struct dc *dc,
 			if (stream_update->dither_option) {
 				struct pipe_ctx *odm_pipe = pipe_ctx->next_odm_pipe;
 				resource_build_bit_depth_reduction_params(pipe_ctx->stream,
-									&pipe_ctx->stream->bit_depth_params);
+									&pipe_ctx->stream->bit_depth_params,
+									pipe_ctx->stream->ctx->dc);
 				pipe_ctx->stream_res.opp->funcs->opp_program_fmt(pipe_ctx->stream_res.opp,
 						&stream->bit_depth_params,
 						&stream->clamping);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 5b3695e72e19..a042b31b57ba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -2485,7 +2485,8 @@ void hwss_opp_program_bit_depth_reduction(union block_sequence_params *params)
 	if (use_default_params)
 		memset(&bit_depth_params, 0, sizeof(bit_depth_params));
 	else
-		resource_build_bit_depth_reduction_params(pipe_ctx->stream, &bit_depth_params);
+		resource_build_bit_depth_reduction_params(pipe_ctx->stream,
+			&bit_depth_params, pipe_ctx->stream->ctx->dc);
 
 	if (opp->funcs->opp_program_bit_depth_reduction)
 		opp->funcs->opp_program_bit_depth_reduction(opp, &bit_depth_params);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 8271b12c1a66..10b7e14ef66f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5037,25 +5037,129 @@ bool pipe_need_reprogram(
 	return false;
 }
 
+/**
+ * get_bit_depth_from_surface_pixel_format - Get effective bit depth from surface format
+ * @format: Surface pixel format
+ *
+ * Returns the effective bit depth per channel for the given surface format.
+ * This is used to determine if input precision is higher than output precision
+ * for dithering decisions.
+ *
+ * Return: Bits per channel (6, 8, 10, 12, or 16)
+ */
+static unsigned int get_bit_depth_from_surface_pixel_format(enum surface_pixel_format format)
+{
+	switch (format) {
+	case SURFACE_PIXEL_FORMAT_GRPH_PALETA_256_COLORS:
+		return 8;
+	case SURFACE_PIXEL_FORMAT_GRPH_ARGB1555:
+		return 5; /* 5 bits per channel */
+	case SURFACE_PIXEL_FORMAT_GRPH_RGB565:
+		return 6;
+	case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
+	case SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr:
+	case SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb:
+		return 8;
+	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
+	case SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCbCr:
+	case SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb:
+		return 10;
+	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
+		return 16; /* 16-bit fixed point */
+	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
+		return 16; /* FP16 has higher effective precision */
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBE:
+	case SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA:
+		return 8; /* 8-bit mantissa per channel */
+	default:
+		return 8;
+	}
+}
+
+/**
+ * get_max_input_bpc_for_stream - Get maximum input plane bit depth for a stream
+ * @dc: DC context
+ * @stream: The stream to check
+ *
+ * Iterate through all pipes in the current DC state to find planes attached
+ * to this stream, and return the maximum bit depth across all those planes.
+ * This is used to determine if spatial dithering (for higher precision inputs
+ * like FP16/RGBA16) or rounding (for bit-accurate matching precision like
+ * RGB10->10bpc) should be used.
+ *
+ * Returns: Maximum bits per channel across all planes for this stream,
+ *          or 0 if no planes found or no current state.
+ */
+static unsigned int get_max_input_bpc_for_stream(const struct dc *dc,
+						 struct dc_stream_state *stream)
+{
+	unsigned int max_bpc = 0;
+	int i;
+
+	if (!dc || !dc->current_state || !stream)
+		return 0;
+
+	/* Iterate through all pipes to find planes for this stream */
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		unsigned int plane_bpc;
+
+		if (!pipe->plane_state || pipe->stream != stream)
+			continue;
+
+		plane_bpc = get_bit_depth_from_surface_pixel_format(
+				pipe->plane_state->format);
+
+		if (plane_bpc > max_bpc)
+			max_bpc = plane_bpc;
+	}
+
+	return max_bpc;
+}
+
 void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
-		struct bit_depth_reduction_params *fmt_bit_depth)
+		struct bit_depth_reduction_params *fmt_bit_depth,
+		const struct dc *dc)
 {
 	enum dc_dither_option option = stream->dither_option;
 	enum dc_pixel_encoding pixel_encoding =
 			stream->timing.pixel_encoding;
+	unsigned int max_plane_bpp;
 
 	memset(fmt_bit_depth, 0, sizeof(*fmt_bit_depth));
 
+	/* Get max input bpc from planes attached to this stream */
+	max_plane_bpp = get_max_input_bpc_for_stream(dc, stream);
+
 	if (option == DITHER_OPTION_DEFAULT) {
 		switch (stream->timing.display_color_depth) {
 		case COLOR_DEPTH_666:
 			option = DITHER_OPTION_SPATIAL6;
 			break;
 		case COLOR_DEPTH_888:
-			option = DITHER_OPTION_SPATIAL8;
+			/* Use spatial dithering if we don't know plane bpp (0) or
+			 * if plane precision > output precision, otherwise use
+			 * rounding/truncation for bit accuracy.
+			 */
+			if (max_plane_bpp == 0 || max_plane_bpp > 8)
+				option = DITHER_OPTION_SPATIAL8;
+			else
+				option = DITHER_OPTION_TRUN8;
 			break;
 		case COLOR_DEPTH_101010:
-			option = DITHER_OPTION_TRUN10;
+			/* Use spatial dithering if we don't know plane bpp (0) or
+			 * if plane precision > output precision, otherwise use
+			 * rounding for bit accuracy.
+			 */
+			if (max_plane_bpp == 0 || max_plane_bpp > 10)
+				option = DITHER_OPTION_SPATIAL10;
+			else
+				option = DITHER_OPTION_TRUN10;
 			break;
 		default:
 			option = DITHER_OPTION_DISABLE;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index cecd3282a29f..2d040e735521 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -591,7 +591,8 @@ bool pipe_need_reprogram(
 		struct pipe_ctx *pipe_ctx);
 
 void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
-		struct bit_depth_reduction_params *fmt_bit_depth);
+		struct bit_depth_reduction_params *fmt_bit_depth,
+		const struct dc *dc);
 
 void update_audio_usage(
 		struct resource_context *res_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 693d852b1c40..377e02095867 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -543,7 +543,8 @@ static void set_crtc_test_pattern(struct dc_link *link,
 	case DP_TEST_PATTERN_VIDEO_MODE:
 	{
 		/* restore bitdepth reduction */
-		resource_build_bit_depth_reduction_params(pipe_ctx->stream, &params);
+		resource_build_bit_depth_reduction_params(pipe_ctx->stream, &params,
+			pipe_ctx->stream->ctx->dc);
 		pipe_ctx->stream->bit_depth_params = params;
 		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern) {
 			opp->funcs->opp_program_bit_depth_reduction(opp, &params);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index 7c09825cd9bd..6433f48e9158 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -928,7 +928,8 @@ void dce110_resource_build_pipe_hw_param(struct pipe_ctx *pipe_ctx)
 		&pipe_ctx->stream_res.pix_clk_params,
 		&pipe_ctx->pll_settings);
 	resource_build_bit_depth_reduction_params(pipe_ctx->stream,
-			&pipe_ctx->stream->bit_depth_params);
+			&pipe_ctx->stream->bit_depth_params,
+			pipe_ctx->stream->ctx->dc);
 	pipe_ctx->stream->clamping.pixel_encoding = pipe_ctx->stream->timing.pixel_encoding;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index 9c1a57a1f989..6cd16b64baae 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -1042,7 +1042,8 @@ static void build_pipe_hw_param(struct pipe_ctx *pipe_ctx)
 	pipe_ctx->stream->clamping.pixel_encoding = pipe_ctx->stream->timing.pixel_encoding;
 
 	resource_build_bit_depth_reduction_params(pipe_ctx->stream,
-					&pipe_ctx->stream->bit_depth_params);
+					&pipe_ctx->stream->bit_depth_params,
+					pipe_ctx->stream->ctx->dc);
 	build_clamping_params(pipe_ctx->stream);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index b28e877fb99d..f2786bfc87c1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1302,7 +1302,8 @@ static enum dc_status build_pipe_hw_param(struct pipe_ctx *pipe_ctx)
 	pipe_ctx->stream->clamping.pixel_encoding = pipe_ctx->stream->timing.pixel_encoding;
 
 	resource_build_bit_depth_reduction_params(pipe_ctx->stream,
-					&pipe_ctx->stream->bit_depth_params);
+					&pipe_ctx->stream->bit_depth_params,
+					pipe_ctx->stream->ctx->dc);
 	build_clamping_params(pipe_ctx->stream);
 
 	return DC_OK;
-- 
2.53.0

