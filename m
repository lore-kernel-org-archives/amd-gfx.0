Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9305FC55174
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38F010F41A;
	Fri, 31 Jul 2026 21:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S+qffJfT";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DC610F403
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvC/o++5xAKkxWVFdD25ifGN5xj+YgktQ9F4er7IHB7XGyXt18YMNWVioWtxHoOzlQ1iypU4a0o5hYTHcvas2qEHomFqyiYhA9VGbvEmYuO4Zb/ZBwbTT57hM0SbhSwSAgbUz5pPnZHs2C6ZZ0WnPiQeyGYtKDAMJjNrZdpr0rIzBgdRe9/KGcEY0wU/IJ/31nM0Uw1HUj1g2/Lc+D70aSCp0iFUFsbHzWTiYrVIVa8vY0EPl/2507P3oGpb6izgAKdKpILlUuuUKkReefT4VJQqJi1KSNjeK/MahQQjq3I0OEWrhm3vxJrBJSdWNQ9LQESPsgVWLa9eVX/RHDaB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi89bz5+lYEsWq1lSk1ciYVQhGtHQiQJ5Hw4T/Q9KY8=;
 b=AwAT8pj1bb3cU3MiYQb3eFgPUZwi4hD6pFt/p53SsslKmolE8OG2/P6INVc4D7m2cV2DNqkiJCOIx5y1GvQIBXtE4P3WECBM7mz0YpHnH7mxHtAyAiyFGsVg9QTB8FWXR/0+CGW0yrv65MpP3diILiTddNGnEuXfnXEZJKULnbIxTTIxQtDCL/xdGZ9lA548JmvQHIFa7PgXcPod0U/BgNbU0G97ztsd4oLlYVVmUhuqs0+A47L+v5yS12+MVmywwhmIhfJDbBVp1TOfJvj1JGI0hdG54EJBW7alXCbo2XIh76dZQtdaCk8DxUYDf0cjhXVV/ODvc0HmUMnQ0Yd1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xi89bz5+lYEsWq1lSk1ciYVQhGtHQiQJ5Hw4T/Q9KY8=;
 b=S+qffJfTfLd9CLOBqIZIP31C92Bb5YF+0VMVtuJzTNFPS7D50HvmLVoty4Vs+3wZ0VA3CTQDUZA6Nxsamg0lKYnQ655SHLpdIv6dEI/r/TSaVx2+syast0uwkC+UZmYD+FZaunnKhrTUthWn95AVOuDY4sbcTwewBxuz+gx0xaI=
Received: from MN0P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::12)
 by SAVPR12MB999122.namprd12.prod.outlook.com (2603:10b6:806:4e7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:50 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::2b) by MN0P222CA0008.outlook.office365.com
 (2603:10b6:208:531::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:49 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:48 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 21/41] drm/amd/display: Refactor stream validation
Date: Fri, 31 Jul 2026 17:12:42 -0400
Message-ID: <20260731211302.3040343-22-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SAVPR12MB999122:EE_
X-MS-Office365-Filtering-Correlation-Id: 85eb4aa4-ef71-4717-520c-08deef48e591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|22082099003|18002099003|5023799004|11063799006|56012099006|3023799007|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 0DZL5bclbHjB51DWGtPJ510GfOKtz0QoFvVMwHR2ITz1bTGjEICMPeNAkdBmfEAXbv6LoMlGRJ7IBFpTnh5204baJMsJYir/vhfbptlliU+59GF8aF3m/LRuqiiAyiyVdXtD8Y5lCgkDCk2qTO/qXMFEXGGqkNILZCaOlncqA5TMsExKW1fU5+yHY1BDqW3Xf0GaIJ6CQiUIsW8IoTtgX6jDw3rgEAlAzGDCJ3v1bm8D5kchtU1fY0BcBfegUHwsuQi/X39GnEd/Sx+hBslpm6G9fHFzlfCkRVSMhy5GqKJneehHK92axbZ8YPp9+WfiseUsTmG0Uc+NiZ6Ox5JMLCAl8cDEOAx27T27hMh+2pj003ddfVyrWz0Qxodf0PuOg3kW5UH8cJ5PpJv4sgB2yiokmD3tS2l0gKklD/UesbkiyOkakDbZktrB8M1u3rXZrCN9pRd1KOSP1CByMTslLG6j5NI/Liq8eDi8lRUux2yt85m8f0jebNrh5SvhgWMUkiyV/+M+Y4aqSRr4c20JMx4IUzQUKm3WMFMQDHPMM5HQNXsdW0If1kMF6EmKISVyUJvP1hOXnmh4sJisAN23Y+794nd6fEBOOm0OQKgIcbAoijxeLRwG0RVkxpco7/bTmkf8zoUkuMr+Rrb/Q8r/yId4Yw3YEKhrT5Bz2vPQZqeXEY94QNv0iyeV0MTVjL9e/fzYE4dzWyC7aF3hEFMCnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(3023799007)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IO+4Ip8hEqX2ahEQwa569ArmHJ3ZVeJ3U+phFHAqsqd2TXtRjuM4B6UVEnOUx3YPkWIDlhLjbZ6Zs6z0CX8YrxYCaX4JipDfwlHZt024b4fyN/GW/ziYmNdiN96zt5kXZJg+8fQONUbR+ok6ZSh6H4GQ5b+W05eKsWOwKwovNqeyyomdBr3tu/kgG9L1cOo0pL7j8OEntdrl5PrVfr7kSzN4T1/tbMpws1BzmdG8IIlJB3wJukEJj2uj9Hrgj3t3MinzZvGKwQL/LlblI+lf7XC5xFIpD3rhc4W6T9aNWxNHnZhKi1WqPAoEsTthZge0JXRekz1W8278NfXQqDNtbbbG7Rtg2SzR/izHb8f8PwXd1EwzzGOHhS+awRylCTZldyV7ABXjcgJwntB3Vd9e9Es1hpTJ0h7aJNZgyMOO9Kb43/mpljUTUsG9Lw5rQ3aZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:50.0922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85eb4aa4-ef71-4717-520c-08deef48e591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999122
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
amdgpu_dm_create_validate_stream_for_sink() drove its RGB -> YUV422 ->
YUV420 chroma fallback by recursing and toggling the shared
aconnector->force_yuv420_output / force_yuv422_output fields, resetting
them after each recursive call. Those fields have no locking and the
function runs concurrently on the same connector from two paths: the
connector probe worker (->mode_valid) and a compositor's atomic check
(dm_update_crtc_state). When both run at once, one thread can clear the
override just before the other tests its exit condition, so the exit is
missed and validation loops indefinitely, hanging the modeset path.

[How]
- Replace the recursion with an explicit loop over the chroma encodings
  wrapping the existing bpc walk.
- Carry the encoding/bpc selection on the stack, passed by value into
  create_stream_for_sink() / fill_stream_properties_from_drm_display_mode(),
  instead of mutating shared connector state.
- Derive the supported encodings and bit depths into bitmaps and drive
  validation from them, gating each candidate on the sink's advertised
  capability so unsupported encodings are never retried.
- Move encoding selection entirely to the caller and pass the chosen
  dc_pixel_encoding into fill_stream_properties_from_drm_display_mode().

Assisted-by: Copilot:claude-opus-4.8
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 280 ++++++++++++------
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   8 +-
 2 files changed, 189 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index e637db2723c1..825c3408763c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -855,7 +855,9 @@ STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
 	const struct drm_connector *connector,
 	const struct drm_connector_state *connector_state,
 	const struct dc_stream_state *old_stream,
-	int requested_bpc)
+	int requested_bpc,
+	enum dc_pixel_encoding requested_encoding,
+	bool is_hdmi_ep)
 {
 	struct dc_crtc_timing *timing_out = &stream->timing;
 	const struct drm_display_info *info = &connector->display_info;
@@ -874,26 +876,14 @@ STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
 	timing_out->h_border_right = 0;
 	timing_out->v_border_top = 0;
 	timing_out->v_border_bottom = 0;
-	/* TODO: un-hardcode */
-	if (drm_mode_is_420_only(info, mode_in) ||
-	    (aconnector &&
-	     (aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR420 ||
-	      aconnector->force_yuv420_output) &&
-	     drm_mode_is_420_also(info, mode_in)))
-		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-	else if ((connector->display_info.color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422))
-			&& aconnector
-			&& (aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR422
-			|| aconnector->force_yuv422_output))
-		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR422;
-	else if ((connector->display_info.color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444))
-			&& (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
-			    stream->signal == SIGNAL_TYPE_HDMI_FRL)
-			&& aconnector
-			&& aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR444)
-		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
-	else
-		timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
+
+	/*
+	 * The pixel encoding to use is decided entirely by the caller (see
+	 * amdgpu_dm_create_validate_stream_for_sink()), which enumerates only
+	 * the encodings the sink actually advertises. This helper must not
+	 * second-guess that choice; it simply applies it.
+	 */
+	timing_out->pixel_encoding = requested_encoding;
 
 	timing_out->timing_3d_format = TIMING_3D_FORMAT_NONE;
 	timing_out->display_color_depth = amdgpu_dm_convert_color_depth_from_display_info(
@@ -959,14 +949,15 @@ STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
 
 	stream->out_transfer_func.type = TF_TYPE_PREDEFINED;
 	stream->out_transfer_func.tf = TRANSFER_FUNCTION_SRGB;
-	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
-		if (!adjust_colour_depth_from_display_info(timing_out, info) &&
-		    drm_mode_is_420_also(info, mode_in) &&
-		    timing_out->pixel_encoding != PIXEL_ENCODING_YCBCR420) {
-			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-			adjust_colour_depth_from_display_info(timing_out, info);
-		}
-	}
+
+	/* Clamp the HDMI colour depth to what the sink's max TMDS clock
+	 * allows. The pixel encoding is fixed by the caller and must not be
+	 * changed here: the caller already enumerates YCbCr420 as its own
+	 * candidate, so silently switching to it would hide an enumeration
+	 * bug and produce a stream the caller never asked to validate.
+	 */
+	if (is_hdmi_ep)
+		adjust_colour_depth_from_display_info(timing_out, info);
 
 	stream->output_color_space = amdgpu_dm_get_output_color_space(timing_out, connector_state);
 	stream->content_type = get_output_content_type(connector_state);
@@ -1433,7 +1424,9 @@ create_stream_for_sink(struct drm_connector *connector,
 		       const struct drm_display_mode *drm_mode,
 		       const struct dm_connector_state *dm_state,
 		       const struct dc_stream_state *old_stream,
-		       int requested_bpc)
+		       int requested_bpc,
+		       enum dc_pixel_encoding requested_encoding,
+		       bool is_hdmi_ep)
 {
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_dm_connector *aconnector = NULL;
@@ -1544,11 +1537,11 @@ create_stream_for_sink(struct drm_connector *connector,
 	if (!scale || mode_refresh != preferred_refresh)
 		fill_stream_properties_from_drm_display_mode(
 			stream, &mode, connector, con_state, NULL,
-			requested_bpc);
+			requested_bpc, requested_encoding, is_hdmi_ep);
 	else
 		fill_stream_properties_from_drm_display_mode(
 			stream, &mode, connector, con_state, old_stream,
-			requested_bpc);
+			requested_bpc, requested_encoding, is_hdmi_ep);
 
 	/* The rest isn't needed for writeback connectors */
 	if (!aconnector)
@@ -2221,13 +2214,31 @@ amdgpu_dm_create_validate_stream_for_sink(struct drm_connector *connector,
 					  const struct dm_connector_state *dm_state,
 					  const struct dc_stream_state *old_stream)
 {
+	/*
+	 * Ordered lists of the encodings and bit depths we are willing to
+	 * validate, best quality/bandwidth first. The per-sink masks built
+	 * below gate which of these entries are actually attempted.
+	 */
+	static const enum dc_pixel_encoding encoding_order[] = {
+		PIXEL_ENCODING_YCBCR444,
+		PIXEL_ENCODING_RGB,
+		PIXEL_ENCODING_YCBCR422,
+		PIXEL_ENCODING_YCBCR420,
+	};
+	static const u8 bpc_order[] = { 16, 12, 10, 8, 6 };
+
 	struct amdgpu_dm_connector *aconnector = NULL;
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
-	struct dc_stream_state *stream;
+	const struct drm_display_info *info = &connector->display_info;
+	struct dc_stream_state *stream = NULL;
 	const struct drm_connector_state *drm_state = dm_state ? &dm_state->base : NULL;
 	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
 	enum dc_status dc_result = DC_OK;
-	uint8_t bpc_limit = 6;
+	enum signal_type signal = SIGNAL_TYPE_NONE;
+	u32 encoding_mask = 0;
+	u32 bpc_mask = 0;
+	bool is_hdmi_ep = false;
+	unsigned int i, j;
 
 	if (!dm_state)
 		return NULL;
@@ -2235,87 +2246,162 @@ amdgpu_dm_create_validate_stream_for_sink(struct drm_connector *connector,
 	if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
 		aconnector = to_amdgpu_dm_connector(connector);
 
-	if (aconnector &&
-	    (aconnector->dc_link->connector_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
-	     aconnector->dc_link->connector_signal == SIGNAL_TYPE_HDMI_FRL ||
-	     aconnector->dc_link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER))
-		bpc_limit = 8;
-
-	do {
-		drm_dbg_kms(connector->dev, "Trying with %d bpc\n", requested_bpc);
-		stream = create_stream_for_sink(connector, drm_mode,
-						dm_state, old_stream,
-						requested_bpc);
-		if (stream == NULL) {
+	/*
+	 * Writeback connectors have no sink EDID to enumerate against. They
+	 * only ever use RGB at the requested depth, so build and validate a
+	 * single stream directly and return it (dc_validate_stream() is not
+	 * meaningful for the writeback path).
+	 */
+	if (!aconnector) {
+		stream = create_stream_for_sink(connector, drm_mode, dm_state,
+						old_stream, requested_bpc,
+						PIXEL_ENCODING_RGB, is_hdmi_ep);
+		if (!stream)
 			drm_err(adev_to_drm(adev), "Failed to create stream for sink!\n");
-			break;
-		}
+		return stream;
+	}
 
-		dc_result = dc_validate_stream(adev->dm.dc, stream);
+	signal = aconnector->dc_link->connector_signal;
 
-		if (!aconnector) /* writeback connector */
-			return stream;
+	/*
+	 * Determine whether this is a native HDMI sink or a DP->HDMI dongle.
+	 * Since we check for it a few times below, cache the result.
+	 */
+	is_hdmi_ep = (signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+		     signal == SIGNAL_TYPE_HDMI_FRL 	||
+		     aconnector->dc_link->dpcd_caps.dongle_type ==
+			     DISPLAY_DONGLE_DP_HDMI_CONVERTER);
+
+	/*
+	 * Build the set of pixel encodings this sink advertises, so we only
+	 * ever validate combinations the display can actually accept. Ordered
+	 * best-first: RGB / YCbCr444 (full bandwidth) -> YCbCr422 -> YCbCr420.
+	 *
+	 *  - RGB is the mandatory baseline and always available.
+	 *  - YCbCr444 is only meaningful for native HDMI sinks.
+	 *  - A 420-only mode collapses the mask to YCbCr420 alone.
+	 *  - The debugfs force_yuv420_output / force_yuv422_output overrides
+	 *    pin the encoding to a single value when set. An explicit YCbCr420
+	 *    force is honoured even on modes the sink only lists as RGB/4:4:4
+	 *    capable (drm_mode_is_420_also() clear), as required for HDMI
+	 *    compliance testing; dc_validate_stream() still rejects anything
+	 *    the link genuinely cannot carry. The YCbCr422 force stays gated on
+	 *    the sink's advertised caps.
+	 */
+	if (drm_mode_is_420_only(info, drm_mode) ||
+	    aconnector->force_yuv420_output) {
+		encoding_mask = BIT(PIXEL_ENCODING_YCBCR420);
+	} else if (aconnector->force_yuv422_output &&
+		   (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422))) {
+		encoding_mask = BIT(PIXEL_ENCODING_YCBCR422);
+	} else {
+		encoding_mask = BIT(PIXEL_ENCODING_RGB);
+
+		if ((info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444)) &&
+		    is_hdmi_ep)
+			encoding_mask |= BIT(PIXEL_ENCODING_YCBCR444);
+
+		if (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422))
+			encoding_mask |= BIT(PIXEL_ENCODING_YCBCR422);
+
+		if (drm_mode_is_420_also(info, drm_mode))
+			encoding_mask |= BIT(PIXEL_ENCODING_YCBCR420);
+	}
+
+	/*
+	 * Build the set of bit depths to try, high-to-low. Start from the
+	 * atomic-requested cap and clear anything the sink cannot do:
+	 *
+	 *  - Never exceed the requested bpc.
+	 *  - HDMI/FRL and DP->HDMI dongles have no defined 6 bpc mode.
+	 *  - Any depth above the EDID-reported bpc is dropped.
+	 *
+	 * amdgpu_dm_convert_color_depth_from_display_info() applies the final
+	 * per-encoding cap (e.g. YCbCr420 deep-colour limits) when the stream
+	 * is built, so this mask only needs the coarse sink limits.
+	 */
+	for (j = 0; j < ARRAY_SIZE(bpc_order); j++) {
+		u8 bpc = bpc_order[j];
+
+		if (requested_bpc > 0 && bpc > requested_bpc)
+			continue;
+
+		if (bpc == 6 && is_hdmi_ep)
+			continue;
+
+		if (info->bpc && bpc > info->bpc)
+			continue;
+
+		bpc_mask |= BIT(bpc);
+	}
+
+	/*
+	 * Enumerate the supported (encoding, bpc) combinations in priority
+	 * order and return the first that validates. Because the masks only
+	 * contain sink-supported entries, this is generic across connector
+	 * types and needs no encoding-specific fallback afterwards.
+	 *
+	 * The selection lives entirely on the stack and is passed by value to
+	 * create_stream_for_sink(); no shared connector state is mutated. This
+	 * matters because this helper runs concurrently from the connector
+	 * probe worker (->mode_valid) and from a compositor's atomic check on
+	 * the same connector.
+	 */
+	for (i = 0; i < ARRAY_SIZE(encoding_order); i++) {
+		enum dc_pixel_encoding enc = encoding_order[i];
+
+		if (!(encoding_mask & BIT(enc)))
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(bpc_order); j++) {
+			u8 bpc = bpc_order[j];
 
-		if (dc_result == DC_OK && stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
-			dc_result = dm_dp_mst_is_port_support_mode(aconnector, stream);
+			if (!(bpc_mask & BIT(bpc)))
+				continue;
 
-		if (dc_result == DC_OK)
-			dc_result = dm_validate_stream_and_context(adev->dm.dc, stream);
+			drm_dbg_kms(connector->dev,
+				    "Trying %s with %d bpc (encoding_mask=0x%x bpc_mask=0x%x requested_bpc=%d drm max_bpc)\n",
+				    dc_pixel_encoding_to_str(enc), bpc,
+				    encoding_mask, bpc_mask, requested_bpc);
 
-		if (dc_result != DC_OK) {
-			drm_dbg_kms(connector->dev, "Pruned mode %d x %d (clk %d) %s %s -- %s\n",
+			stream = create_stream_for_sink(connector, drm_mode,
+							dm_state, old_stream,
+							bpc, enc, is_hdmi_ep);
+			if (stream == NULL) {
+				drm_err(adev_to_drm(adev), "Failed to create stream for sink!\n");
+				return NULL;
+			}
+
+			dc_result = dc_validate_stream(adev->dm.dc, stream);
+
+			if (dc_result == DC_OK &&
+			    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+				dc_result = dm_dp_mst_is_port_support_mode(aconnector, stream);
+
+			if (dc_result == DC_OK)
+				dc_result = dm_validate_stream_and_context(adev->dm.dc, stream);
+
+			if (dc_result == DC_OK)
+				return stream;
+
+			drm_dbg_kms(connector->dev, "Pruned mode %d x %d (refresh rate %d) %s %s -- %s\n",
 				      drm_mode->hdisplay,
 				      drm_mode->vdisplay,
-				      drm_mode->clock,
+				      drm_mode_vrefresh(drm_mode),
 				      dc_pixel_encoding_to_str(stream->timing.pixel_encoding),
 				      dc_color_depth_to_str(stream->timing.display_color_depth),
 				      dc_status_to_str(dc_result));
 
 			dc_stream_release(stream);
 			stream = NULL;
-			requested_bpc -= 2; /* lower bpc to retry validation */
 		}
+	}
 
-	} while (stream == NULL && requested_bpc >= bpc_limit);
-
-	switch (dc_result) {
 	/*
-	 * If we failed to validate DP bandwidth stream with the requested RGB color depth,
-	 * we try to fallback and configure in order:
-	 * YUV422 (8bpc, 6bpc)
-	 * YUV420 (8bpc, 6bpc)
+	 * Every sink-supported combination was exhausted without validating;
+	 * the mode is genuinely unsupported on this link.
 	 */
-	case DC_FAIL_ENC_VALIDATE:
-	case DC_EXCEED_DONGLE_CAP:
-	case DC_NO_DP_LINK_BANDWIDTH:
-		/* recursively entered twice and already tried both YUV422 and YUV420 */
-		if (aconnector->force_yuv422_output && aconnector->force_yuv420_output)
-			break;
-		/* first failure; try YUV422 */
-		if (!aconnector->force_yuv422_output) {
-			drm_dbg_kms(connector->dev, "%s:%d Validation failed with %d, retrying w/ YUV422\n",
-				    __func__, __LINE__, dc_result);
-			aconnector->force_yuv422_output = true;
-		/* recursively entered and YUV422 failed, try YUV420 */
-		} else if (!aconnector->force_yuv420_output) {
-			drm_dbg_kms(connector->dev, "%s:%d Validation failed with %d, retrying w/ YUV420\n",
-				    __func__, __LINE__, dc_result);
-			aconnector->force_yuv420_output = true;
-		}
-		stream = amdgpu_dm_create_validate_stream_for_sink(connector, drm_mode,
-							 dm_state, old_stream);
-		aconnector->force_yuv422_output = false;
-		aconnector->force_yuv420_output = false;
-		break;
-	case DC_OK:
-		break;
-	default:
-		drm_dbg_kms(connector->dev, "%s:%d Unhandled validation failure %d\n",
-			    __func__, __LINE__, dc_result);
-		break;
-	}
-
-	return stream;
+	return NULL;
 }
 EXPORT_IF_KUNIT(amdgpu_dm_create_validate_stream_for_sink);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 13c54229d72c..4e9eb3ff2c90 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -189,13 +189,17 @@ void fill_stream_properties_from_drm_display_mode(
 	const struct drm_connector *connector,
 	const struct drm_connector_state *connector_state,
 	const struct dc_stream_state *old_stream,
-	int requested_bpc);
+	int requested_bpc,
+	enum dc_pixel_encoding requested_encoding,
+	bool is_hdmi_ep);
 struct dc_stream_state *
 create_stream_for_sink(struct drm_connector *connector,
 		       const struct drm_display_mode *drm_mode,
 		       const struct dm_connector_state *dm_state,
 		       const struct dc_stream_state *old_stream,
-		       int requested_bpc);
+		       int requested_bpc,
+		       enum dc_pixel_encoding requested_encoding,
+		       bool is_hdmi_ep);
 enum drm_connector_status
 amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force);
 enum drm_connector_status
-- 
2.34.1

