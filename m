Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6EEC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA2EB10EEC9;
	Wed, 20 Mar 2024 06:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J0goWa3w";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5778C10EE94
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG3EokNgBeghZd+U4lmqmG2EMZq8Yh0iwSIPzaNqYhVIqoeVxGRqprK7MjxVTUO1KMGgaT9r6vZEBaOZe4SVQB2AAJksBfskgulhARg2qjdrcrlMcq5/Em7tihpV2aCktR7cWkfZV91w/cLSHK4594HunGHYc4dWeSdwmc/bKXIq4Zi5MvmmC5F75hL6fiGtIQhkEekfsOhBaMUNly+TLiD+EYkSp2hLIodQKCsxAXJcXMSZbb4bCHudxw8DqDlB0E+l+Z2Cj3tw7zef0R/jhNJIgbnqxsdX6YuiGyBxBsYH1xJiV5r+cFA3GsPijBYSugmkHU3mPvpjG9sfrAtwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiUcRv59FqqlSDjc7wmgICNxJeMmyqKg030W48CZALM=;
 b=fIHCSnunpa0dJ9PmzkPnj3GUeI4tySDky9U+aO7TDGLqVIUxF0so17Q1hVkB5sTf7gLxKjPGilJjsTUlSPsRGKmA2l6bIIbajVYPzvofJq+ibVYoo3ADeJj/fqAUwwxIYnGbe6ceunn+jMCu4aEVZDK+YkRqOWXXEfMTQbQHWFFS3PWLPw6Ex1yr+dmdRPh/J+h1oDOw4h4Kdt2dbRpQ1s6l1EpuipW8lJqtOCGh7OhBVTQ7nVUru8HdJ3d9grDx03obeEMdwr7X7TN3nf1EqZOb2LqY62EuJvkkZbOH/9nFuDhJdiOZbjEfD4VgLZi6BTaHlMo75vBR+YharwwG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiUcRv59FqqlSDjc7wmgICNxJeMmyqKg030W48CZALM=;
 b=J0goWa3wAnlbna28Ms9mrXW1u8Vi1WgN0DVGM9FXZe9FcGZ07rrnEYl9VKNY9RFfHjYbV+m9jyFPUIy1cB/aT2CiGv5piCWlgtJxM4KbYbPu6D/jswL6ON01ukK8QDa6E+3F9ae0w8nNDyEwksniKQVWHKpybzc4Uf+AnlJrerE=
Received: from MN2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:208:1b4::26)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 06:37:20 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::bc) by MN2PR15CA0013.outlook.office365.com
 (2603:10b6:208:1b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 06:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:37:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:37:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 23:37:17 -0700
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:37:14 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 18/22] drm/amd/display: Remove plane and stream pointers from
 dc scratch
Date: Wed, 20 Mar 2024 14:35:52 +0800
Message-ID: <20240320063556.1326615-19-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|BL3PR12MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 86046b21-92a6-45f2-a4fb-08dc48a831df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upaRNRHNWkeXrpCn5T9Ip5kaPctpBsKv9K9AElgGaQ3bkr86swkld5ul/0g9LMWDzCHFfcajFaX+g4rTjMb96XS5Cm5TZjBZcqyEDATCmezwHDj0ihiYlpGXtfErt7nbl8zyXHDx9YFlDJcnUiET8+BCKWfmqHDdCnRrggGV3xha6qt5dVw9W0PvfpYlSC883IcY85mLGAF2OlYWbc7ab57pjTn/IDuO6SWTLgHygt7PUUNehm6h/KY0uETRvmpyfXXBzqgUjr3XHybCqoOU6v2WQZ8UMxzYuOBOnK8ghY0I3ZEIAw+fwg83HPdn2pnYn/z/FADu6o5w2ZGl3Y7uG/ZqiEnQgNQZ6r9c+wV1miILiJecUneYNHUbMEfqfjHFNnoi0j1Oiq1Q3v3sWH3IU/uj/NAFDu62KyRY12tPukaiMMUHyoO+MGs0YTHcCyxmlr9FGLzImX7zBS0zEyWlO33AIGNAPU4seQ4cQWT1Wjso8fVl7CIIvNFvbo0mHXpa2P0LVe/sIG9mtg/cG0I+0ss4vkFgKZXhfR3gKnnrb1B0mxBxqGfqHKWes28lFn2Ye4Z5toV74tWgYbX7EwGVgOWXTKZoXQLyEaaT1CGeO6cHF9g/bkWdANsPqMbtS5Jf7Y9yZuRXWIxSdS5J37aYx4XPsO2mVSEvrm+h3Q6ljoP5A7z6Bic8x2NiN1OWSHp6+QKdDFOTX8q8sqK+RlSQJi64/OuiFSWM3hqBrMHT4gIiwc51/PvHgRsr7ND5WwH9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:37:20.7744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86046b21-92a6-45f2-a4fb-08dc48a831df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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

From: Alvin Lee <alvin.lee2@amd.com>

[Why&How]
Remove several plane and stream pointers from dc for code
refactoring.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 18 ++---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 42 +++++-----
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 80 +++++++------------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  8 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 16 +---
 .../gpu/drm/amd/display/dc/core/dc_surface.c  | 47 ++---------
 drivers/gpu/drm/amd/display/dc/dc.h           | 26 +++---
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 +-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h  |  2 +-
 .../amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c   | 10 +--
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  | 10 +--
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 15 ++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 24 +++---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 63 +++++++--------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 66 +++++++--------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  5 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 73 ++++++++---------
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  2 +-
 21 files changed, 218 insertions(+), 300 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6bfe327dfb4f..399f736207d0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5700,8 +5700,8 @@ static void fill_stream_properties_from_drm_display_mode(
 
 	timing_out->aspect_ratio = get_aspect_ratio(mode_in);
 
-	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
-	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
+	stream->out_transfer_func.type = TF_TYPE_PREDEFINED;
+	stream->out_transfer_func.tf = TRANSFER_FUNCTION_SRGB;
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
 		if (!adjust_colour_depth_from_display_info(timing_out, info) &&
 		    drm_mode_is_420_also(info, mode_in) &&
@@ -6320,7 +6320,7 @@ create_stream_for_sink(struct drm_connector *connector,
 			if (stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
 				stream->use_vsc_sdp_for_colorimetry = true;
 		}
-		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
+		if (stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22)
 			tf = TRANSFER_FUNC_GAMMA_22;
 		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
 
@@ -8395,13 +8395,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 		bundle->surface_updates[planes_count].surface = dc_plane;
 		if (new_pcrtc_state->color_mgmt_changed) {
-			bundle->surface_updates[planes_count].gamma = dc_plane->gamma_correction;
-			bundle->surface_updates[planes_count].in_transfer_func = dc_plane->in_transfer_func;
+			bundle->surface_updates[planes_count].gamma = &dc_plane->gamma_correction;
+			bundle->surface_updates[planes_count].in_transfer_func = &dc_plane->in_transfer_func;
 			bundle->surface_updates[planes_count].gamut_remap_matrix = &dc_plane->gamut_remap_matrix;
 			bundle->surface_updates[planes_count].hdr_mult = dc_plane->hdr_mult;
-			bundle->surface_updates[planes_count].func_shaper = dc_plane->in_shaper_func;
-			bundle->surface_updates[planes_count].lut3d_func = dc_plane->lut3d_func;
-			bundle->surface_updates[planes_count].blend_tf = dc_plane->blend_tf;
+			bundle->surface_updates[planes_count].func_shaper = &dc_plane->in_shaper_func;
+			bundle->surface_updates[planes_count].lut3d_func = &dc_plane->lut3d_func;
+			bundle->surface_updates[planes_count].blend_tf = &dc_plane->blend_tf;
 		}
 
 		amdgpu_dm_plane_fill_dc_scaling_info(dm->adev, new_plane_state,
@@ -8614,7 +8614,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			bundle->stream_update.output_csc_transform =
 				&acrtc_state->stream->csc_color_matrix;
 			bundle->stream_update.out_transfer_func =
-				acrtc_state->stream->out_transfer_func;
+				&acrtc_state->stream->out_transfer_func;
 			bundle->stream_update.lut3d_func =
 				(struct dc_3dlut *) acrtc_state->stream->lut3d_func;
 			bundle->stream_update.func_shaper =
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index c87b64e464ed..ebabfe3a512f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -571,7 +571,7 @@ static int amdgpu_dm_set_atomic_regamma(struct dc_stream_state *stream,
 					uint32_t regamma_size, bool has_rom,
 					enum dc_transfer_func_predefined tf)
 {
-	struct dc_transfer_func *out_tf = stream->out_transfer_func;
+	struct dc_transfer_func *out_tf = &stream->out_transfer_func;
 	int ret = 0;
 
 	if (regamma_size || tf != TRANSFER_FUNCTION_LINEAR) {
@@ -954,8 +954,8 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 		 * inverse color ramp in legacy userspace.
 		 */
 		crtc->cm_is_degamma_srgb = true;
-		stream->out_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
-		stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
+		stream->out_transfer_func.type = TF_TYPE_DISTRIBUTED_POINTS;
+		stream->out_transfer_func.tf = TRANSFER_FUNCTION_SRGB;
 		/*
 		 * Note: although we pass has_rom as parameter here, we never
 		 * actually use ROM because the color module only takes the ROM
@@ -963,7 +963,7 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 		 *
 		 * See more in mod_color_calculate_regamma_params()
 		 */
-		r = __set_legacy_tf(stream->out_transfer_func, regamma_lut,
+		r = __set_legacy_tf(&stream->out_transfer_func, regamma_lut,
 				    regamma_size, has_rom);
 		if (r)
 			return r;
@@ -1034,7 +1034,7 @@ map_crtc_degamma_to_dc_plane(struct dm_crtc_state *crtc,
 						 &degamma_size);
 		ASSERT(degamma_size == MAX_COLOR_LUT_ENTRIES);
 
-		dc_plane_state->in_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
+		dc_plane_state->in_transfer_func.type = TF_TYPE_DISTRIBUTED_POINTS;
 
 		/*
 		 * This case isn't fully correct, but also fairly
@@ -1061,12 +1061,12 @@ map_crtc_degamma_to_dc_plane(struct dm_crtc_state *crtc,
 		 * map these to the atomic one instead.
 		 */
 		if (crtc->cm_is_degamma_srgb)
-			dc_plane_state->in_transfer_func->tf = tf;
+			dc_plane_state->in_transfer_func.tf = tf;
 		else
-			dc_plane_state->in_transfer_func->tf =
+			dc_plane_state->in_transfer_func.tf =
 				TRANSFER_FUNCTION_LINEAR;
 
-		r = __set_input_tf(caps, dc_plane_state->in_transfer_func,
+		r = __set_input_tf(caps, &dc_plane_state->in_transfer_func,
 				   degamma_lut, degamma_size);
 		if (r)
 			return r;
@@ -1075,12 +1075,12 @@ map_crtc_degamma_to_dc_plane(struct dm_crtc_state *crtc,
 		 * For legacy gamma support we need the regamma input
 		 * in linear space. Assume that the input is sRGB.
 		 */
-		dc_plane_state->in_transfer_func->type = TF_TYPE_PREDEFINED;
-		dc_plane_state->in_transfer_func->tf = tf;
+		dc_plane_state->in_transfer_func.type = TF_TYPE_PREDEFINED;
+		dc_plane_state->in_transfer_func.tf = tf;
 
 		if (tf != TRANSFER_FUNCTION_SRGB &&
 		    !mod_color_calculate_degamma_params(caps,
-							dc_plane_state->in_transfer_func,
+							&dc_plane_state->in_transfer_func,
 							NULL, false))
 			return -ENOMEM;
 	}
@@ -1114,24 +1114,24 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
 	if (!has_degamma_lut && tf == AMDGPU_TRANSFER_FUNCTION_DEFAULT)
 		return -EINVAL;
 
-	dc_plane_state->in_transfer_func->tf = amdgpu_tf_to_dc_tf(tf);
+	dc_plane_state->in_transfer_func.tf = amdgpu_tf_to_dc_tf(tf);
 
 	if (has_degamma_lut) {
 		ASSERT(degamma_size == MAX_COLOR_LUT_ENTRIES);
 
-		dc_plane_state->in_transfer_func->type =
+		dc_plane_state->in_transfer_func.type =
 			TF_TYPE_DISTRIBUTED_POINTS;
 
-		ret = __set_input_tf(color_caps, dc_plane_state->in_transfer_func,
+		ret = __set_input_tf(color_caps, &dc_plane_state->in_transfer_func,
 				     degamma_lut, degamma_size);
 		if (ret)
 			return ret;
        } else {
-		dc_plane_state->in_transfer_func->type =
+		dc_plane_state->in_transfer_func.type =
 			TF_TYPE_PREDEFINED;
 
 		if (!mod_color_calculate_degamma_params(color_caps,
-		    dc_plane_state->in_transfer_func, NULL, false))
+		    &dc_plane_state->in_transfer_func, NULL, false))
 			return -ENOMEM;
 	}
 	return 0;
@@ -1156,11 +1156,11 @@ amdgpu_dm_plane_set_color_properties(struct drm_plane_state *plane_state,
 	lut3d = __extract_blob_lut(dm_plane_state->lut3d, &lut3d_size);
 	lut3d_size = lut3d != NULL ? lut3d_size : 0;
 
-	amdgpu_dm_atomic_lut3d(lut3d, lut3d_size, dc_plane_state->lut3d_func);
+	amdgpu_dm_atomic_lut3d(lut3d, lut3d_size, &dc_plane_state->lut3d_func);
 	ret = amdgpu_dm_atomic_shaper_lut(shaper_lut, false,
 					  amdgpu_tf_to_dc_tf(shaper_tf),
 					  shaper_size,
-					  dc_plane_state->in_shaper_func);
+					  &dc_plane_state->in_shaper_func);
 	if (ret) {
 		drm_dbg_kms(plane_state->plane->dev,
 			    "setting plane %d shaper LUT failed.\n",
@@ -1175,7 +1175,7 @@ amdgpu_dm_plane_set_color_properties(struct drm_plane_state *plane_state,
 
 	ret = amdgpu_dm_atomic_blend_lut(blend_lut, false,
 					 amdgpu_tf_to_dc_tf(blend_tf),
-					 blend_size, dc_plane_state->blend_tf);
+					 blend_size, &dc_plane_state->blend_tf);
 	if (ret) {
 		drm_dbg_kms(plane_state->plane->dev,
 			    "setting plane %d gamma lut failed.\n",
@@ -1221,8 +1221,8 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 		color_caps = &dc_plane_state->ctx->dc->caps.color;
 
 	/* Initially, we can just bypass the DGM block. */
-	dc_plane_state->in_transfer_func->type = TF_TYPE_BYPASS;
-	dc_plane_state->in_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
+	dc_plane_state->in_transfer_func.type = TF_TYPE_BYPASS;
+	dc_plane_state->in_transfer_func.tf = TRANSFER_FUNCTION_LINEAR;
 
 	/* After, we start to update values according to color props */
 	has_crtc_cm_degamma = (crtc->cm_has_degamma || crtc->cm_is_degamma_srgb);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5e93bd696d21..9756aa5db09c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2851,55 +2851,45 @@ static void copy_surface_update_to_plane(
 				srf_update->plane_info->layer_index;
 	}
 
-	if (srf_update->gamma &&
-			(surface->gamma_correction !=
-					srf_update->gamma)) {
-		memcpy(&surface->gamma_correction->entries,
+	if (srf_update->gamma) {
+		memcpy(&surface->gamma_correction.entries,
 			&srf_update->gamma->entries,
 			sizeof(struct dc_gamma_entries));
-		surface->gamma_correction->is_identity =
+		surface->gamma_correction.is_identity =
 			srf_update->gamma->is_identity;
-		surface->gamma_correction->num_entries =
+		surface->gamma_correction.num_entries =
 			srf_update->gamma->num_entries;
-		surface->gamma_correction->type =
+		surface->gamma_correction.type =
 			srf_update->gamma->type;
 	}
 
-	if (srf_update->in_transfer_func &&
-			(surface->in_transfer_func !=
-				srf_update->in_transfer_func)) {
-		surface->in_transfer_func->sdr_ref_white_level =
+	if (srf_update->in_transfer_func) {
+		surface->in_transfer_func.sdr_ref_white_level =
 			srf_update->in_transfer_func->sdr_ref_white_level;
-		surface->in_transfer_func->tf =
+		surface->in_transfer_func.tf =
 			srf_update->in_transfer_func->tf;
-		surface->in_transfer_func->type =
+		surface->in_transfer_func.type =
 			srf_update->in_transfer_func->type;
-		memcpy(&surface->in_transfer_func->tf_pts,
+		memcpy(&surface->in_transfer_func.tf_pts,
 			&srf_update->in_transfer_func->tf_pts,
 			sizeof(struct dc_transfer_func_distributed_points));
 	}
 
-	if (srf_update->func_shaper &&
-			(surface->in_shaper_func !=
-			srf_update->func_shaper))
-		memcpy(surface->in_shaper_func, srf_update->func_shaper,
-		sizeof(*surface->in_shaper_func));
+	if (srf_update->func_shaper)
+		memcpy(&surface->in_shaper_func, srf_update->func_shaper,
+		sizeof(surface->in_shaper_func));
 
-	if (srf_update->lut3d_func &&
-			(surface->lut3d_func !=
-			srf_update->lut3d_func))
-		memcpy(surface->lut3d_func, srf_update->lut3d_func,
-		sizeof(*surface->lut3d_func));
+	if (srf_update->lut3d_func)
+		memcpy(&surface->lut3d_func, srf_update->lut3d_func,
+		sizeof(surface->lut3d_func));
 
 	if (srf_update->hdr_mult.value)
 		surface->hdr_mult =
 				srf_update->hdr_mult;
 
-	if (srf_update->blend_tf &&
-			(surface->blend_tf !=
-			srf_update->blend_tf))
-		memcpy(surface->blend_tf, srf_update->blend_tf,
-		sizeof(*surface->blend_tf));
+	if (srf_update->blend_tf)
+		memcpy(&surface->blend_tf, srf_update->blend_tf,
+		sizeof(surface->blend_tf));
 
 	if (srf_update->input_csc_color_matrix)
 		surface->input_csc_color_matrix =
@@ -2930,14 +2920,13 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->dst.height && update->dst.width)
 		stream->dst = update->dst;
 
-	if (update->out_transfer_func &&
-	    stream->out_transfer_func != update->out_transfer_func) {
-		stream->out_transfer_func->sdr_ref_white_level =
+	if (update->out_transfer_func) {
+		stream->out_transfer_func.sdr_ref_white_level =
 			update->out_transfer_func->sdr_ref_white_level;
-		stream->out_transfer_func->tf = update->out_transfer_func->tf;
-		stream->out_transfer_func->type =
+		stream->out_transfer_func.tf = update->out_transfer_func->tf;
+		stream->out_transfer_func.type =
 			update->out_transfer_func->type;
-		memcpy(&stream->out_transfer_func->tf_pts,
+		memcpy(&stream->out_transfer_func.tf_pts,
 		       &update->out_transfer_func->tf_pts,
 		       sizeof(struct dc_transfer_func_distributed_points));
 	}
@@ -3050,15 +3039,8 @@ static void backup_planes_and_stream_state(
 
 	for (i = 0; i < status->plane_count; i++) {
 		scratch->plane_states[i] = *status->plane_states[i];
-		scratch->gamma_correction[i] = *status->plane_states[i]->gamma_correction;
-		scratch->in_transfer_func[i] = *status->plane_states[i]->in_transfer_func;
-		scratch->lut3d_func[i] = *status->plane_states[i]->lut3d_func;
-		scratch->in_shaper_func[i] = *status->plane_states[i]->in_shaper_func;
-		scratch->blend_tf[i] = *status->plane_states[i]->blend_tf;
 	}
 	scratch->stream_state = *stream;
-	if (stream->out_transfer_func)
-		scratch->out_transfer_func = *stream->out_transfer_func;
 }
 
 static void restore_planes_and_stream_state(
@@ -3073,15 +3055,8 @@ static void restore_planes_and_stream_state(
 
 	for (i = 0; i < status->plane_count; i++) {
 		*status->plane_states[i] = scratch->plane_states[i];
-		*status->plane_states[i]->gamma_correction = scratch->gamma_correction[i];
-		*status->plane_states[i]->in_transfer_func = scratch->in_transfer_func[i];
-		*status->plane_states[i]->lut3d_func = scratch->lut3d_func[i];
-		*status->plane_states[i]->in_shaper_func = scratch->in_shaper_func[i];
-		*status->plane_states[i]->blend_tf = scratch->blend_tf[i];
 	}
 	*stream = scratch->stream_state;
-	if (stream->out_transfer_func)
-		*stream->out_transfer_func = scratch->out_transfer_func;
 }
 
 /**
@@ -5352,10 +5327,13 @@ void dc_enable_dcmode_clk_limit(struct dc *dc, bool enable)
 	}
 	dc->clk_mgr->dc_mode_softmax_enabled = enable;
 }
-bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_state *plane,
+bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc,
+		unsigned int pitch,
+		unsigned int height,
+		enum surface_pixel_format format,
 		struct dc_cursor_attributes *cursor_attr)
 {
-	if (dc->hwss.does_plane_fit_in_mall && dc->hwss.does_plane_fit_in_mall(dc, plane, cursor_attr))
+	if (dc->hwss.does_plane_fit_in_mall && dc->hwss.does_plane_fit_in_mall(dc, pitch, height, format, cursor_attr))
 		return true;
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 9c05b1a07142..3b1b324c0824 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -392,10 +392,10 @@ void get_hdr_visual_confirm_color(
 
 	switch (top_pipe_ctx->plane_res.scl_data.format) {
 	case PIXEL_FORMAT_ARGB2101010:
-		if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_PQ) {
+		if (top_pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_PQ) {
 			/* HDR10, ARGB2101010 - set border color to red */
 			color->color_r_cr = color_value;
-		} else if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
+		} else if (top_pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22) {
 			/* FreeSync 2 ARGB2101010 - set border color to pink */
 			color->color_r_cr = color_value;
 			color->color_b_cb = color_value;
@@ -403,10 +403,10 @@ void get_hdr_visual_confirm_color(
 			is_sdr = true;
 		break;
 	case PIXEL_FORMAT_FP16:
-		if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_PQ) {
+		if (top_pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_PQ) {
 			/* HDR10, FP16 - set border color to blue */
 			color->color_b_cb = color_value;
-		} else if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
+		} else if (top_pipe_ctx->stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22) {
 			/* FreeSync 2 HDR - set border color to green */
 			color->color_g_y = color_value;
 		} else
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 2b01b4a3861d..dd0428024173 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4041,7 +4041,7 @@ static void set_avi_info_frame(
 	}
 
 	if (pixel_encoding && color_space == COLOR_SPACE_2020_YCBCR &&
-			stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
+			stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22) {
 		hdmi_info.bits.EC0_EC2 = 0;
 		hdmi_info.bits.C0_C1 = COLORIMETRY_ITU709;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 212e057ed9b0..ee6493a9a79c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -116,12 +116,7 @@ bool dc_stream_construct(struct dc_stream_state *stream,
 
 	update_stream_signal(stream, dc_sink_data);
 
-	stream->out_transfer_func = dc_create_transfer_func();
-	if (stream->out_transfer_func == NULL) {
-		dc_sink_release(dc_sink_data);
-		return false;
-	}
-	stream->out_transfer_func->type = TF_TYPE_BYPASS;
+	stream->out_transfer_func.type = TF_TYPE_BYPASS;
 
 	dc_stream_assign_stream_id(stream);
 
@@ -131,10 +126,6 @@ bool dc_stream_construct(struct dc_stream_state *stream,
 void dc_stream_destruct(struct dc_stream_state *stream)
 {
 	dc_sink_release(stream->sink);
-	if (stream->out_transfer_func != NULL) {
-		dc_transfer_func_release(stream->out_transfer_func);
-		stream->out_transfer_func = NULL;
-	}
 }
 
 void dc_stream_assign_stream_id(struct dc_stream_state *stream)
@@ -201,9 +192,6 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
 	if (new_stream->sink)
 		dc_sink_retain(new_stream->sink);
 
-	if (new_stream->out_transfer_func)
-		dc_transfer_func_retain(new_stream->out_transfer_func);
-
 	dc_stream_assign_stream_id(new_stream);
 
 	/* If using dynamic encoder assignment, wait till stream committed to assign encoder. */
@@ -425,7 +413,7 @@ bool dc_stream_add_writeback(struct dc *dc,
 
 	dc_exit_ips_for_hw_access(dc);
 
-	wb_info->dwb_params.out_transfer_func = stream->out_transfer_func;
+	wb_info->dwb_params.out_transfer_func = &stream->out_transfer_func;
 
 	dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
 	dwb->dwb_is_drc = false;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index acc7a8baa169..ea624e000ec0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -41,25 +41,15 @@ void dc_plane_construct(struct dc_context *ctx, struct dc_plane_state *plane_sta
 {
 	plane_state->ctx = ctx;
 
-	plane_state->gamma_correction = dc_create_gamma();
-	if (plane_state->gamma_correction != NULL)
-		plane_state->gamma_correction->is_identity = true;
+	plane_state->gamma_correction.is_identity = true;
 
-	plane_state->in_transfer_func = dc_create_transfer_func();
-	if (plane_state->in_transfer_func != NULL) {
-		plane_state->in_transfer_func->type = TF_TYPE_BYPASS;
-	}
-	plane_state->in_shaper_func = dc_create_transfer_func();
-	if (plane_state->in_shaper_func != NULL) {
-		plane_state->in_shaper_func->type = TF_TYPE_BYPASS;
-	}
+	plane_state->in_transfer_func.type = TF_TYPE_BYPASS;
 
-	plane_state->lut3d_func = dc_create_3dlut_func();
+	plane_state->in_shaper_func.type = TF_TYPE_BYPASS;
 
-	plane_state->blend_tf = dc_create_transfer_func();
-	if (plane_state->blend_tf != NULL) {
-		plane_state->blend_tf->type = TF_TYPE_BYPASS;
-	}
+	plane_state->lut3d_func.state.raw = 0;
+
+	plane_state->blend_tf.type = TF_TYPE_BYPASS;
 
 	plane_state->pre_multiplied_alpha = true;
 
@@ -67,30 +57,7 @@ void dc_plane_construct(struct dc_context *ctx, struct dc_plane_state *plane_sta
 
 void dc_plane_destruct(struct dc_plane_state *plane_state)
 {
-	if (plane_state->gamma_correction != NULL) {
-		dc_gamma_release(&plane_state->gamma_correction);
-	}
-	if (plane_state->in_transfer_func != NULL) {
-		dc_transfer_func_release(
-				plane_state->in_transfer_func);
-		plane_state->in_transfer_func = NULL;
-	}
-	if (plane_state->in_shaper_func != NULL) {
-		dc_transfer_func_release(
-				plane_state->in_shaper_func);
-		plane_state->in_shaper_func = NULL;
-	}
-	if (plane_state->lut3d_func != NULL) {
-		dc_3dlut_func_release(
-				plane_state->lut3d_func);
-		plane_state->lut3d_func = NULL;
-	}
-	if (plane_state->blend_tf != NULL) {
-		dc_transfer_func_release(
-				plane_state->blend_tf);
-		plane_state->blend_tf = NULL;
-	}
-
+	// no more pointers to free within dc_plane_state
 }
 
 /*******************************************************************************
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 52fd2ebdcdbb..dd54de5f3b2f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1212,6 +1212,8 @@ union surface_update_flags {
 	uint32_t raw;
 };
 
+#define DC_REMOVE_PLANE_POINTERS 1
+
 struct dc_plane_state {
 	struct dc_plane_address address;
 	struct dc_plane_flip_time time;
@@ -1226,8 +1228,8 @@ struct dc_plane_state {
 
 	struct dc_plane_dcc_param dcc;
 
-	struct dc_gamma *gamma_correction;
-	struct dc_transfer_func *in_transfer_func;
+	struct dc_gamma gamma_correction;
+	struct dc_transfer_func in_transfer_func;
 	struct dc_bias_and_scale *bias_and_scale;
 	struct dc_csc_transform input_csc_color_matrix;
 	struct fixed31_32 coeff_reduction_factor;
@@ -1239,9 +1241,9 @@ struct dc_plane_state {
 
 	enum dc_color_space color_space;
 
-	struct dc_3dlut *lut3d_func;
-	struct dc_transfer_func *in_shaper_func;
-	struct dc_transfer_func *blend_tf;
+	struct dc_3dlut lut3d_func;
+	struct dc_transfer_func in_shaper_func;
+	struct dc_transfer_func blend_tf;
 
 	struct dc_transfer_func *gamcor_tf;
 	enum surface_pixel_format format;
@@ -1308,14 +1310,8 @@ struct dc_scratch_space {
 	 * a valid current state during dc update.
 	 */
 	struct dc_plane_state plane_states[MAX_SURFACE_NUM];
-	struct dc_gamma gamma_correction[MAX_SURFACE_NUM];
-	struct dc_transfer_func in_transfer_func[MAX_SURFACE_NUM];
-	struct dc_3dlut lut3d_func[MAX_SURFACE_NUM];
-	struct dc_transfer_func in_shaper_func[MAX_SURFACE_NUM];
-	struct dc_transfer_func blend_tf[MAX_SURFACE_NUM];
 
 	struct dc_stream_state stream_state;
-	struct dc_transfer_func out_transfer_func;
 };
 
 struct dc {
@@ -1384,6 +1380,7 @@ struct dc {
 		} update_bw_bounding_box;
 		struct dc_scratch_space current_state;
 		struct dc_scratch_space new_state;
+		struct dc_stream_state temp_stream; // Used so we don't need to allocate stream on the stack
 	} scratch;
 
 	struct dml2_configuration_options dml2_options;
@@ -2364,8 +2361,11 @@ bool dc_is_dmcu_initialized(struct dc *dc);
 enum dc_status dc_set_clock(struct dc *dc, enum dc_clock_type clock_type, uint32_t clk_khz, uint32_t stepping);
 void dc_get_clock(struct dc *dc, enum dc_clock_type clock_type, struct dc_clock_config *clock_cfg);
 
-bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_state *plane,
-				struct dc_cursor_attributes *cursor_attr);
+bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc,
+		unsigned int pitch,
+		unsigned int height,
+		enum surface_pixel_format format,
+		struct dc_cursor_attributes *cursor_attr);
 
 #define dc_allow_idle_optimizations(dc, allow) dc_allow_idle_optimizations_internal(dc, allow, __func__)
 #define dc_exit_ips_for_hw_access(dc) dc_exit_ips_for_hw_access_internal(dc, __func__)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index ee10941caa59..68dc668f3e14 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -190,7 +190,7 @@ struct dc_stream_state {
 	PHYSICAL_ADDRESS_LOC dmdata_address;
 	bool   use_dynamic_meta;
 
-	struct dc_transfer_func *out_transfer_func;
+	struct dc_transfer_func out_transfer_func;
 	struct colorspace_transform gamut_remap_matrix;
 	struct dc_csc_transform csc_color_matrix;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index be2ac5c442a4..e219a1812360 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -422,7 +422,7 @@ struct dc_dwb_params {
 	enum dwb_capture_rate		capture_rate;	/* controls the frame capture rate */
 	struct scaling_taps 		scaler_taps;	/* Scaling taps */
 	enum dwb_subsample_position	subsample_position;
-	struct dc_transfer_func *out_transfer_func;
+	const struct dc_transfer_func *out_transfer_func;
 };
 
 /* audio*/
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h
index 672cde46c4b9..49cb25c9cb36 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h
@@ -736,7 +736,7 @@ bool dpp20_program_shaper(
 
 bool dpp20_program_3dlut(
 		struct dpp *dpp_base,
-		struct tetrahedral_params *params);
+		const struct tetrahedral_params *params);
 
 void dpp2_cnv_set_alpha_keyer(
 			struct dpp *dpp_base,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
index 131a8de8e0f8..f43fa29971f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c
@@ -1114,15 +1114,15 @@ static void dpp20_select_3dlut_ram_mask(
 
 bool dpp20_program_3dlut(
 		struct dpp *dpp_base,
-		struct tetrahedral_params *params)
+		const struct tetrahedral_params *params)
 {
 	enum dc_lut_mode mode;
 	bool is_17x17x17;
 	bool is_12bits_color_channel;
-	struct dc_rgb *lut0;
-	struct dc_rgb *lut1;
-	struct dc_rgb *lut2;
-	struct dc_rgb *lut3;
+	const struct dc_rgb *lut0;
+	const struct dc_rgb *lut1;
+	const struct dc_rgb *lut2;
+	const struct dc_rgb *lut3;
 	int lut_size0;
 	int lut_size;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 0c31b12cacaf..58095ac75506 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -1384,15 +1384,15 @@ static void dpp3_select_3dlut_ram_mask(
 }
 
 static bool dpp3_program_3dlut(struct dpp *dpp_base,
-			       struct tetrahedral_params *params)
+			       const struct tetrahedral_params *params)
 {
 	enum dc_lut_mode mode;
 	bool is_17x17x17;
 	bool is_12bits_color_channel;
-	struct dc_rgb *lut0;
-	struct dc_rgb *lut1;
-	struct dc_rgb *lut2;
-	struct dc_rgb *lut3;
+	const struct dc_rgb *lut0;
+	const struct dc_rgb *lut1;
+	const struct dc_rgb *lut2;
+	const struct dc_rgb *lut3;
 	int lut_size0;
 	int lut_size;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index de5542c20103..35c631c22934 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -289,16 +289,14 @@ dce110_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	if (ipp == NULL)
 		return false;
 
-	if (plane_state->in_transfer_func)
-		tf = plane_state->in_transfer_func;
+	tf = &plane_state->in_transfer_func;
 
 	build_prescale_params(&prescale_params, plane_state);
 	ipp->funcs->ipp_program_prescale(ipp, &prescale_params);
 
-	if (plane_state->gamma_correction &&
-			!plane_state->gamma_correction->is_identity &&
+	if (!plane_state->gamma_correction.is_identity &&
 			dce_use_lut(plane_state->format))
-		ipp->funcs->ipp_program_input_lut(ipp, plane_state->gamma_correction);
+		ipp->funcs->ipp_program_input_lut(ipp, &plane_state->gamma_correction);
 
 	if (tf == NULL) {
 		/* Default case if no input transfer function specified */
@@ -614,11 +612,10 @@ dce110_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	xfm->funcs->opp_power_on_regamma_lut(xfm, true);
 	xfm->regamma_params.hw_points_num = GAMMA_HW_POINTS_NUM;
 
-	if (stream->out_transfer_func &&
-	    stream->out_transfer_func->type == TF_TYPE_PREDEFINED &&
-	    stream->out_transfer_func->tf == TRANSFER_FUNCTION_SRGB) {
+	if (stream->out_transfer_func.type == TF_TYPE_PREDEFINED &&
+	    stream->out_transfer_func.tf == TRANSFER_FUNCTION_SRGB) {
 		xfm->funcs->opp_set_regamma_mode(xfm, OPP_REGAMMA_SRGB);
-	} else if (dce110_translate_regamma_to_hw_format(stream->out_transfer_func,
+	} else if (dce110_translate_regamma_to_hw_format(&stream->out_transfer_func,
 							 &xfm->regamma_params)) {
 		xfm->funcs->opp_program_regamma_pwl(xfm, &xfm->regamma_params);
 		xfm->funcs->opp_set_regamma_mode(xfm, OPP_REGAMMA_USER);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index e0c3c14d12f3..3940f25f7d9f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1829,14 +1829,12 @@ bool dcn10_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	if (dpp_base == NULL)
 		return false;
 
-	if (plane_state->in_transfer_func)
-		tf = plane_state->in_transfer_func;
+	tf = &plane_state->in_transfer_func;
 
-	if (plane_state->gamma_correction &&
-		!dpp_base->ctx->dc->debug.always_use_regamma
-		&& !plane_state->gamma_correction->is_identity
+	if (!dpp_base->ctx->dc->debug.always_use_regamma
+		&& !plane_state->gamma_correction.is_identity
 			&& dce_use_lut(plane_state->format))
-		dpp_base->funcs->dpp_program_input_lut(dpp_base, plane_state->gamma_correction);
+		dpp_base->funcs->dpp_program_input_lut(dpp_base, &plane_state->gamma_correction);
 
 	if (tf == NULL)
 		dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE_BYPASS);
@@ -1877,7 +1875,7 @@ bool dcn10_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 #define MAX_NUM_HW_POINTS 0x200
 
 static void log_tf(struct dc_context *ctx,
-				struct dc_transfer_func *tf, uint32_t hw_points_num)
+				const struct dc_transfer_func *tf, uint32_t hw_points_num)
 {
 	// DC_LOG_GAMMA is default logging of all hw points
 	// DC_LOG_ALL_GAMMA logs all points, not only hw points
@@ -1914,16 +1912,15 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 
 	dpp->regamma_params.hw_points_num = GAMMA_HW_POINTS_NUM;
 
-	if (stream->out_transfer_func &&
-	    stream->out_transfer_func->type == TF_TYPE_PREDEFINED &&
-	    stream->out_transfer_func->tf == TRANSFER_FUNCTION_SRGB)
+	if (stream->out_transfer_func.type == TF_TYPE_PREDEFINED &&
+	    stream->out_transfer_func.tf == TRANSFER_FUNCTION_SRGB)
 		dpp->funcs->dpp_program_regamma_pwl(dpp, NULL, OPP_REGAMMA_SRGB);
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us, only do it when full
 	 * update.
 	 */
 	else if (cm_helper_translate_curve_to_hw_format(dc->ctx,
-			stream->out_transfer_func,
+			&stream->out_transfer_func,
 			&dpp->regamma_params, false)) {
 		dpp->funcs->dpp_program_regamma_pwl(
 				dpp,
@@ -1931,10 +1928,9 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	} else
 		dpp->funcs->dpp_program_regamma_pwl(dpp, NULL, OPP_REGAMMA_BYPASS);
 
-	if (stream->ctx &&
-	    stream->out_transfer_func) {
+	if (stream->ctx) {
 		log_tf(stream->ctx,
-				stream->out_transfer_func,
+				&stream->out_transfer_func,
 				dpp->regamma_params.hw_points_num);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index eae71f448143..1530b1f8f8be 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1011,7 +1011,7 @@ bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 {
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
-	struct pwl_params *params = NULL;
+	const struct pwl_params *params = NULL;
 	/*
 	 * program OGAM only for the top pipe
 	 * if there is a pipe split then fix diagnostic is required:
@@ -1022,19 +1022,19 @@ bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	if (mpc->funcs->power_on_mpc_mem_pwr)
 		mpc->funcs->power_on_mpc_mem_pwr(mpc, mpcc_id, true);
 	if (pipe_ctx->top_pipe == NULL
-			&& mpc->funcs->set_output_gamma && stream->out_transfer_func) {
-		if (stream->out_transfer_func->type == TF_TYPE_HWPWL)
-			params = &stream->out_transfer_func->pwl;
-		else if (pipe_ctx->stream->out_transfer_func->type ==
+			&& mpc->funcs->set_output_gamma) {
+		if (stream->out_transfer_func.type == TF_TYPE_HWPWL)
+			params = &stream->out_transfer_func.pwl;
+		else if (pipe_ctx->stream->out_transfer_func.type ==
 			TF_TYPE_DISTRIBUTED_POINTS &&
 			cm_helper_translate_curve_to_hw_format(dc->ctx,
-			stream->out_transfer_func,
+			&stream->out_transfer_func,
 			&mpc->blender_params, false))
 			params = &mpc->blender_params;
 		/*
 		 * there is no ROM
 		 */
-		if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
+		if (stream->out_transfer_func.type == TF_TYPE_PREDEFINED)
 			BREAK_TO_DEBUGGER();
 	}
 	/*
@@ -1050,17 +1050,15 @@ bool dcn20_set_blend_lut(
 {
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	bool result = true;
-	struct pwl_params *blend_lut = NULL;
-
-	if (plane_state->blend_tf) {
-		if (plane_state->blend_tf->type == TF_TYPE_HWPWL)
-			blend_lut = &plane_state->blend_tf->pwl;
-		else if (plane_state->blend_tf->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
-					plane_state->blend_tf,
-					&dpp_base->regamma_params, false);
-			blend_lut = &dpp_base->regamma_params;
-		}
+	const struct pwl_params *blend_lut = NULL;
+
+	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
+		blend_lut = &plane_state->blend_tf.pwl;
+	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
+		cm_helper_translate_curve_to_hw_format(plane_state->ctx,
+				&plane_state->blend_tf,
+				&dpp_base->regamma_params, false);
+		blend_lut = &dpp_base->regamma_params;
 	}
 	result = dpp_base->funcs->dpp_program_blnd_lut(dpp_base, blend_lut);
 
@@ -1072,24 +1070,21 @@ bool dcn20_set_shaper_3dlut(
 {
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	bool result = true;
-	struct pwl_params *shaper_lut = NULL;
-
-	if (plane_state->in_shaper_func) {
-		if (plane_state->in_shaper_func->type == TF_TYPE_HWPWL)
-			shaper_lut = &plane_state->in_shaper_func->pwl;
-		else if (plane_state->in_shaper_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
-					plane_state->in_shaper_func,
-					&dpp_base->shaper_params, true);
-			shaper_lut = &dpp_base->shaper_params;
-		}
+	const struct pwl_params *shaper_lut = NULL;
+
+	if (plane_state->in_shaper_func.type == TF_TYPE_HWPWL)
+		shaper_lut = &plane_state->in_shaper_func.pwl;
+	else if (plane_state->in_shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
+		cm_helper_translate_curve_to_hw_format(plane_state->ctx,
+				&plane_state->in_shaper_func,
+				&dpp_base->shaper_params, true);
+		shaper_lut = &dpp_base->shaper_params;
 	}
 
 	result = dpp_base->funcs->dpp_program_shaper_lut(dpp_base, shaper_lut);
-	if (plane_state->lut3d_func &&
-		plane_state->lut3d_func->state.bits.initialized == 1)
+	if (plane_state->lut3d_func.state.bits.initialized == 1)
 		result = dpp_base->funcs->dpp_program_3dlut(dpp_base,
-								&plane_state->lut3d_func->lut_3d);
+								&plane_state->lut3d_func.lut_3d);
 	else
 		result = dpp_base->funcs->dpp_program_3dlut(dpp_base, NULL);
 
@@ -1112,9 +1107,7 @@ bool dcn20_set_input_transfer_func(struct dc *dc,
 	hws->funcs.set_shaper_3dlut(pipe_ctx, plane_state);
 	hws->funcs.set_blend_lut(pipe_ctx, plane_state);
 
-	if (plane_state->in_transfer_func)
-		tf = plane_state->in_transfer_func;
-
+	tf = &plane_state->in_transfer_func;
 
 	if (tf == NULL) {
 		dpp_base->funcs->dpp_set_degamma(dpp_base,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 8bc3d01537bb..af3a26c2656b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -223,16 +223,14 @@ bool dcn30_set_blend_lut(
 {
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	bool result = true;
-	struct pwl_params *blend_lut = NULL;
-
-	if (plane_state->blend_tf) {
-		if (plane_state->blend_tf->type == TF_TYPE_HWPWL)
-			blend_lut = &plane_state->blend_tf->pwl;
-		else if (plane_state->blend_tf->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm3_helper_translate_curve_to_hw_format(
-					plane_state->blend_tf, &dpp_base->regamma_params, false);
-			blend_lut = &dpp_base->regamma_params;
-		}
+	const struct pwl_params *blend_lut = NULL;
+
+	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
+		blend_lut = &plane_state->blend_tf.pwl;
+	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
+		cm3_helper_translate_curve_to_hw_format(
+				&plane_state->blend_tf, &dpp_base->regamma_params, false);
+		blend_lut = &dpp_base->regamma_params;
 	}
 	result = dpp_base->funcs->dpp_program_blnd_lut(dpp_base, blend_lut);
 
@@ -300,27 +298,24 @@ bool dcn30_set_input_transfer_func(struct dc *dc,
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	enum dc_transfer_func_predefined tf;
 	bool result = true;
-	struct pwl_params *params = NULL;
+	const struct pwl_params *params = NULL;
 
 	if (dpp_base == NULL || plane_state == NULL)
 		return false;
 
 	tf = TRANSFER_FUNCTION_UNITY;
 
-	if (plane_state->in_transfer_func &&
-		plane_state->in_transfer_func->type == TF_TYPE_PREDEFINED)
-		tf = plane_state->in_transfer_func->tf;
+	if (plane_state->in_transfer_func.type == TF_TYPE_PREDEFINED)
+		tf = plane_state->in_transfer_func.tf;
 
 	dpp_base->funcs->dpp_set_pre_degam(dpp_base, tf);
 
-	if (plane_state->in_transfer_func) {
-		if (plane_state->in_transfer_func->type == TF_TYPE_HWPWL)
-			params = &plane_state->in_transfer_func->pwl;
-		else if (plane_state->in_transfer_func->type == TF_TYPE_DISTRIBUTED_POINTS &&
-			cm3_helper_translate_curve_to_hw_format(plane_state->in_transfer_func,
-					&dpp_base->degamma_params, false))
-			params = &dpp_base->degamma_params;
-	}
+	if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
+		params = &plane_state->in_transfer_func.pwl;
+	else if (plane_state->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS &&
+		cm3_helper_translate_curve_to_hw_format(&plane_state->in_transfer_func,
+				&dpp_base->degamma_params, false))
+		params = &dpp_base->degamma_params;
 
 	result = dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
 
@@ -378,24 +373,24 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
 {
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
-	struct pwl_params *params = NULL;
+	const struct pwl_params *params = NULL;
 	bool ret = false;
 
 	/* program OGAM or 3DLUT only for the top pipe*/
 	if (pipe_ctx->top_pipe == NULL) {
 		/*program rmu shaper and 3dlut in MPC*/
 		ret = dcn30_set_mpc_shaper_3dlut(pipe_ctx, stream);
-		if (ret == false && mpc->funcs->set_output_gamma && stream->out_transfer_func) {
-			if (stream->out_transfer_func->type == TF_TYPE_HWPWL)
-				params = &stream->out_transfer_func->pwl;
-			else if (pipe_ctx->stream->out_transfer_func->type ==
+		if (ret == false && mpc->funcs->set_output_gamma) {
+			if (stream->out_transfer_func.type == TF_TYPE_HWPWL)
+				params = &stream->out_transfer_func.pwl;
+			else if (pipe_ctx->stream->out_transfer_func.type ==
 					TF_TYPE_DISTRIBUTED_POINTS &&
 					cm3_helper_translate_curve_to_hw_format(
-					stream->out_transfer_func,
+					&stream->out_transfer_func,
 					&mpc->blender_params, false))
 				params = &mpc->blender_params;
 			 /* there are no ROM LUTs in OUTGAM */
-			if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
+			if (stream->out_transfer_func.type == TF_TYPE_PREDEFINED)
 				BREAK_TO_DEBUGGER();
 		}
 	}
@@ -946,7 +941,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 					plane->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB8888 &&
 					plane->address.page_table_base.quad_part == 0 &&
 					dc->hwss.does_plane_fit_in_mall &&
-					dc->hwss.does_plane_fit_in_mall(dc, plane,
+					dc->hwss.does_plane_fit_in_mall(dc, plane->plane_size.surface_pitch,
+							plane->plane_size.surface_size.height, plane->format,
 							cursor_cache_enable ? &cursor_attr : NULL)) {
 				unsigned int v_total = stream->adjust.v_total_max ?
 						stream->adjust.v_total_max : stream->timing.v_total;
@@ -1076,11 +1072,15 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 	return true;
 }
 
-bool dcn30_does_plane_fit_in_mall(struct dc *dc, struct dc_plane_state *plane, struct dc_cursor_attributes *cursor_attr)
+bool dcn30_does_plane_fit_in_mall(struct dc *dc,
+		unsigned int pitch,
+		unsigned int height,
+		enum surface_pixel_format format,
+		struct dc_cursor_attributes *cursor_attr)
 {
 	// add meta size?
-	unsigned int surface_size = plane->plane_size.surface_pitch * plane->plane_size.surface_size.height *
-			(plane->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4);
+	unsigned int surface_size = pitch * height *
+			(format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4);
 	unsigned int mall_size = dc->caps.mall_size_total;
 	unsigned int cursor_size = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index 638f018a3cb5..76b16839486a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -71,7 +71,10 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable);
 void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx);
 void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx);
 
-bool dcn30_does_plane_fit_in_mall(struct dc *dc, struct dc_plane_state *plane,
+bool dcn30_does_plane_fit_in_mall(struct dc *dc,
+		unsigned int pitch,
+		unsigned int height,
+		enum surface_pixel_format format,
 		struct dc_cursor_attributes *cursor_attr);
 
 bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 62ff99463834..0f522f8a7228 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -479,39 +479,35 @@ bool dcn32_set_mcm_luts(
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
 	bool result = true;
-	struct pwl_params *lut_params = NULL;
+	const struct pwl_params *lut_params = NULL;
 
 	// 1D LUT
-	if (plane_state->blend_tf) {
-		if (plane_state->blend_tf->type == TF_TYPE_HWPWL)
-			lut_params = &plane_state->blend_tf->pwl;
-		else if (plane_state->blend_tf->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm3_helper_translate_curve_to_hw_format(plane_state->blend_tf,
-					&dpp_base->regamma_params, false);
-			lut_params = &dpp_base->regamma_params;
-		}
+	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
+		lut_params = &plane_state->blend_tf.pwl;
+	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
+		cm3_helper_translate_curve_to_hw_format(&plane_state->blend_tf,
+				&dpp_base->regamma_params, false);
+		lut_params = &dpp_base->regamma_params;
 	}
 	result = mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
 	lut_params = NULL;
 
 	// Shaper
-	if (plane_state->in_shaper_func) {
-		if (plane_state->in_shaper_func->type == TF_TYPE_HWPWL)
-			lut_params = &plane_state->in_shaper_func->pwl;
-		else if (plane_state->in_shaper_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			// TODO: dpp_base replace
-			ASSERT(false);
-			cm3_helper_translate_curve_to_hw_format(plane_state->in_shaper_func,
-					&dpp_base->shaper_params, true);
-			lut_params = &dpp_base->shaper_params;
-		}
+	if (plane_state->in_shaper_func.type == TF_TYPE_HWPWL)
+		lut_params = &plane_state->in_shaper_func.pwl;
+	else if (plane_state->in_shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
+		// TODO: dpp_base replace
+		ASSERT(false);
+		cm3_helper_translate_curve_to_hw_format(&plane_state->in_shaper_func,
+				&dpp_base->shaper_params, true);
+		lut_params = &dpp_base->shaper_params;
 	}
 
 	result = mpc->funcs->program_shaper(mpc, lut_params, mpcc_id);
 
 	// 3D
-	if (plane_state->lut3d_func && plane_state->lut3d_func->state.bits.initialized == 1)
-		result = mpc->funcs->program_3dlut(mpc, &plane_state->lut3d_func->lut_3d, mpcc_id);
+	if (plane_state->lut3d_func.state.bits.initialized == 1)
+		result = mpc->funcs->program_3dlut(mpc, &plane_state->lut3d_func.lut_3d, mpcc_id);
 	else
 		result = mpc->funcs->program_3dlut(mpc, NULL, mpcc_id);
 
@@ -528,27 +524,24 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
 
 	enum dc_transfer_func_predefined tf;
 	bool result = true;
-	struct pwl_params *params = NULL;
+	const struct pwl_params *params = NULL;
 
 	if (mpc == NULL || plane_state == NULL)
 		return false;
 
 	tf = TRANSFER_FUNCTION_UNITY;
 
-	if (plane_state->in_transfer_func &&
-		plane_state->in_transfer_func->type == TF_TYPE_PREDEFINED)
-		tf = plane_state->in_transfer_func->tf;
+	if (plane_state->in_transfer_func.type == TF_TYPE_PREDEFINED)
+		tf = plane_state->in_transfer_func.tf;
 
 	dpp_base->funcs->dpp_set_pre_degam(dpp_base, tf);
 
-	if (plane_state->in_transfer_func) {
-		if (plane_state->in_transfer_func->type == TF_TYPE_HWPWL)
-			params = &plane_state->in_transfer_func->pwl;
-		else if (plane_state->in_transfer_func->type == TF_TYPE_DISTRIBUTED_POINTS &&
-			cm3_helper_translate_curve_to_hw_format(plane_state->in_transfer_func,
-					&dpp_base->degamma_params, false))
-			params = &dpp_base->degamma_params;
-	}
+	if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
+		params = &plane_state->in_transfer_func.pwl;
+	else if (plane_state->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS &&
+		cm3_helper_translate_curve_to_hw_format(&plane_state->in_transfer_func,
+				&dpp_base->degamma_params, false))
+		params = &dpp_base->degamma_params;
 
 	dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
 
@@ -566,24 +559,24 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
 {
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
-	struct pwl_params *params = NULL;
+	const struct pwl_params *params = NULL;
 	bool ret = false;
 
 	/* program OGAM or 3DLUT only for the top pipe*/
 	if (resource_is_pipe_type(pipe_ctx, OPP_HEAD)) {
 		/*program shaper and 3dlut in MPC*/
 		ret = dcn32_set_mpc_shaper_3dlut(pipe_ctx, stream);
-		if (ret == false && mpc->funcs->set_output_gamma && stream->out_transfer_func) {
-			if (stream->out_transfer_func->type == TF_TYPE_HWPWL)
-				params = &stream->out_transfer_func->pwl;
-			else if (pipe_ctx->stream->out_transfer_func->type ==
+		if (ret == false && mpc->funcs->set_output_gamma) {
+			if (stream->out_transfer_func.type == TF_TYPE_HWPWL)
+				params = &stream->out_transfer_func.pwl;
+			else if (pipe_ctx->stream->out_transfer_func.type ==
 					TF_TYPE_DISTRIBUTED_POINTS &&
 					cm3_helper_translate_curve_to_hw_format(
-					stream->out_transfer_func,
+					&stream->out_transfer_func,
 					&mpc->blender_params, false))
 				params = &mpc->blender_params;
 			/* there are no ROM LUTs in OUTGAM */
-			if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
+			if (stream->out_transfer_func.type == TF_TYPE_PREDEFINED)
 				BREAK_TO_DEBUGGER();
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 65df90842b83..2368fad61b41 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -377,7 +377,10 @@ struct hw_sequencer_funcs {
 	/* Idle Optimization Related */
 	bool (*apply_idle_power_optimizations)(struct dc *dc, bool enable);
 
-	bool (*does_plane_fit_in_mall)(struct dc *dc, struct dc_plane_state *plane,
+	bool (*does_plane_fit_in_mall)(struct dc *dc,
+			unsigned int pitch,
+			unsigned int height,
+			enum surface_pixel_format format,
 			struct dc_cursor_attributes *cursor_attr);
 	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
 	void (*enable_phantom_streams)(struct dc *dc, struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 0f24afbf4388..ca8de345d039 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -322,7 +322,7 @@ struct dpp_funcs {
 			const struct pwl_params *params);
 	bool (*dpp_program_3dlut)(
 			struct dpp *dpp,
-			struct tetrahedral_params *params);
+			const struct tetrahedral_params *params);
 	void (*dpp_cnv_set_alpha_keyer)(
 			struct dpp *dpp_base,
 			struct cnv_color_keyer_params *color_keyer);
-- 
2.34.1

