Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E27E74ADF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CC810EB6E;
	Tue,  3 Dec 2024 21:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wgiDc/ai";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF1610EB6C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOS+WweszdEL+BXvhJYOkV+ZnaG/vC+2+XkRDrA2mO0BxGSkid31UbhpMV4sa1d3a0cudml8wAK4j6OUtYFUKW0EA8d69WDhyA2oXXSRjKbHfbDgO0bQHdKwIGUgs4Uagqbtg1m+AxykoS2eTxnWsWNdqD2SSAxiWQpwa6RrDZ5UvGIc5LHvwtB79WnGNE+6pGXoqgp5EoSaiyExLNM5zM61s/U35LB9ZzOMluN1oFP9CkXztP5O4tBX4SVm8HlIQI/2T+5zI5rPQz3fwQoo663cICB08mJlKtmlLRdj3FOsljgxNjdSxgzdJupSkPWZMQ5/tKfauDVgDuU8QDGJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UaWvJOIIwuT5Gzz058hpTfoB/5zxPgFFk6RSsl2j9s=;
 b=o25Bgqfx2zJMfIQKXAJz6i7G0WoPafP+W7RlGVtDkPjKw06eqrP0x6f3qnJbBneYqTJu8rZ8YUooyDIb9/FIzf0t+F3zvQu+IRTKtxpIHt/a1z4F3fPzOTlhtMmA3nywD96mtjIjN4C7GmWIcTeI/quVmL9VXvdCOmk/qMy1GZxwjfj6ohopKvrbfSZDLoF8RTd3AyLrPp7k4Yp9rX7CehamKtlioBpPGm9rzS4tG7BKxQJxHkMxgel7jeJjIQtS/WIWHtP6N7srzk7Xr0FGqWt6MOBYiQwTiCtZ5vFa9RvILNZkU8EFPGj47c/nwf0w85sed2Dn4Iw3urLaENoiMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UaWvJOIIwuT5Gzz058hpTfoB/5zxPgFFk6RSsl2j9s=;
 b=wgiDc/aikzAC5avHB+ExyFg75dA522Zd+kl7YVWA9+CklnNYh7V4zkrXXEZ6HzEiTCD2vibTTQDqpj+aePEpgoQgs1nG+iMoQgWSGuIXYJPTJB/rCCh4D0sxqxg3x9Nja7SJe5OhAiZxbRNPxOZ6DOrDLUNnUXIHAiqkcvGCRUA=
Received: from BN9PR03CA0345.namprd03.prod.outlook.com (2603:10b6:408:f6::20)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 21:41:43 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::bf) by BN9PR03CA0345.outlook.office365.com
 (2603:10b6:408:f6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 21:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:41 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:41 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Navid Assadian <navid.assadian@amd.com>
Subject: [PATCH 08/19] drm/amd/display: clean up SPL code
Date: Tue, 3 Dec 2024 16:39:46 -0500
Message-ID: <20241203214120.1161810-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea26c58-3b10-49b5-4c9b-08dd13e34727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ubu/pvY2C1BnKgpp6JZNBoO+ugNVFfcYUlpAGwb8Xe/peS1MFm46pB0pXtK0?=
 =?us-ascii?Q?AoEjCsKl5DaY9Fwj77mByq5uiB1jXxhUWOQIDIjc/nTnhS2NT+DwnOMR1PE/?=
 =?us-ascii?Q?593EBoOEvGREnhXve9rYanwbZloB3AbFXNnuCl3WzRacQH4KGZ98kM2sgQw4?=
 =?us-ascii?Q?3IWqq//u16Gznug64QkT/+tIe0kD/u4x9rANG7OxicGDXkvg9RWF2Cm1+CbG?=
 =?us-ascii?Q?VQi8RanPkBxhXh+yjo0YP3s0HLIch9j5N6UMzWJWEB5CClszBCKfx8aOCPUv?=
 =?us-ascii?Q?T6dvG/8YeKis1UIeYqreWyhPn5iUvdRNQrjJsNAgkEN0pAYcjqo1JYsOHwmL?=
 =?us-ascii?Q?pAvavInR7xcAxGFNNmAHulmSGy9h5QU+FxRYncH4ltw+MYfT7KXBCdUj+KB1?=
 =?us-ascii?Q?X2RY4Wo4ZWEwMQogiNC0uMOynxqxBojI05K3/dbsrXOpJvCLEQv2byyFivY0?=
 =?us-ascii?Q?TsNNGVxTsMdATv/fUrQPdXra8bTHq3hexK7WqfDURWAhAhFA0RPowXVF7WB+?=
 =?us-ascii?Q?f6vdcYlZwbZc9KjB4MQCsBDYMV2am9eZ7GI0TOt3J78exleKYO/+30tC3lSl?=
 =?us-ascii?Q?lUuGYap93X12ds1MHUqob7bha8V3VLmKUuk+pfOjjLs7Iuc2j9uBI4Khsxk3?=
 =?us-ascii?Q?XKr/EvkFIUgTVPSF6ZTeD4/14hplyz58YSd3UZmKJnKb48dZLehjOHnT/22f?=
 =?us-ascii?Q?ayKv52LaO7FuYKYzQ0Q7QYKOOAcG39RIdXeElBx3ENPf+gWc6UjYycJQ82QY?=
 =?us-ascii?Q?2muqIp6iXGodZj8U9S9foDQ+4QunKxTWbIEqVtDgLss8IW7gmF1E4TKqZUNa?=
 =?us-ascii?Q?EaltfDqS0egMOo2nmqp/xkh84miAGgqP1csJt9UZF67yHjN2ezNPYZ7iflUR?=
 =?us-ascii?Q?RFj6xnp8nlGhdp3ipBtvSX8b0LZA3Dpnh8Fcj3kczMT0dcoLTmzhjVyoHiWL?=
 =?us-ascii?Q?aoN8EQNAJNj21HszOZp75CdhlYsTwKA/kOwHsO/SxUF4wNx8RNMKRTK/Apfm?=
 =?us-ascii?Q?tu/QZ/xTYvb+WmUR+HwQ3xWXh4+/K9NoAGIpjd/3BXUwY7p050XyErYQtKwY?=
 =?us-ascii?Q?a4M+RFYuw/C71EbEyODGDow+VUzelR2kpPk46BwiRVuoaJ7wpwrWVByQgj3F?=
 =?us-ascii?Q?t8DptCIYTS7xJfXyoOd6SAEiQ6adnrZC+Su9OwQRAvl6la/Kc3UU3OkcgvHj?=
 =?us-ascii?Q?2BIXV8Ie2W5FZxJ6uEtZWFEVrAD+2x9g2ck11xmIeKdE6vKr+SwLrR9LW/73?=
 =?us-ascii?Q?rXxTKE9BoENoQzZzkrF1NvO0M7Zrvl0DaXGZjkKZY+4WpavLbKfDGOhS1RTS?=
 =?us-ascii?Q?7bhpWua3jgQHBCtgdLSzuRwGBheAe0YsU9FQVK+efscsIH5/G1CXCe6BouyO?=
 =?us-ascii?Q?JfOv5rD3cqGYMoZ8GOKTUxBl1ZXVMsjponS4ghM8ZwwTDuho73KuT9LbLW1j?=
 =?us-ascii?Q?qA3mvexbmiulAII/HVoZMFVqUYFsUUrj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:42.8115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea26c58-3b10-49b5-4c9b-08dd13e34727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
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

From: Samson Tam <Samson.Tam@amd.com>

[Why & How]
Add check for invalid pixel format, remove unused pixel formats
and clean up some names

Reviewed-by: Navid Assadian <navid.assadian@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  9 ++-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 71 +++++++++----------
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  6 +-
 3 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index a4907cfe3f08..3518eb1b8cd1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -64,6 +64,13 @@ static void populate_inits_from_splinits(struct scl_inits *inits,
 	inits->h_c = dc_fixpt_from_int_dy(spl_inits->h_filter_init_int_c, spl_inits->h_filter_init_frac_c >> 5, 0, 19);
 	inits->v_c = dc_fixpt_from_int_dy(spl_inits->v_filter_init_int_c, spl_inits->v_filter_init_frac_c >> 5, 0, 19);
 }
+static void populate_splformat_from_format(enum spl_pixel_format *spl_pixel_format, const enum pixel_format pixel_format)
+{
+	if (pixel_format < PIXEL_FORMAT_INVALID)
+		*spl_pixel_format = (enum spl_pixel_format)pixel_format;
+	else
+		*spl_pixel_format = SPL_PIXEL_FORMAT_INVALID;
+}
 /// @brief Translate SPL input parameters from pipe context
 /// @param pipe_ctx
 /// @param spl_in
@@ -89,7 +96,7 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 		spl_in->callbacks = dcn2_spl_callbacks;
 	}
 	// Make format field from spl_in point to plane_res scl_data format
-	spl_in->basic_in.format = (enum spl_pixel_format)pipe_ctx->plane_res.scl_data.format;
+	populate_splformat_from_format(&spl_in->basic_in.format, pipe_ctx->plane_res.scl_data.format);
 	// Make view_format from basic_out point to view_format from stream
 	spl_in->basic_out.view_format = (enum spl_view_3d)stream->view_format;
 	// Populate spl input basic input clip rect from plane state clip rect
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 72d55e9a4fd7..1306ce0321e2 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -563,6 +563,24 @@ static bool spl_is_rgb8(enum spl_pixel_format format)
 	return false;
 }
 
+static bool spl_is_video_format(enum spl_pixel_format format)
+{
+	if (format >= SPL_PIXEL_FORMAT_VIDEO_BEGIN
+			&& format <= SPL_PIXEL_FORMAT_VIDEO_END)
+		return true;
+	else
+		return false;
+}
+
+static bool spl_is_subsampled_format(enum spl_pixel_format format)
+{
+	if (format >= SPL_PIXEL_FORMAT_SUBSAMPLED_BEGIN
+			&& format <= SPL_PIXEL_FORMAT_SUBSAMPLED_END)
+		return true;
+	else
+		return false;
+}
+
 /*Calculate inits and viewport */
 static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 		struct spl_scratch *spl_scratch)
@@ -607,7 +625,7 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 		spl_swap(flip_vert_scan_dir, flip_horz_scan_dir);
 	}
 
-	if (spl_is_yuv420(spl_in->basic_in.format)) {
+	if (spl_is_subsampled_format(spl_in->basic_in.format)) {
 		/* this gives the direction of the cositing (negative will move
 		 * left, right otherwise)
 		 */
@@ -715,24 +733,6 @@ static void spl_clamp_viewport(struct spl_rect *viewport)
 		viewport->width = MIN_VIEWPORT_SIZE;
 }
 
-static bool spl_dscl_is_420_format(enum spl_pixel_format format)
-{
-	if (format == SPL_PIXEL_FORMAT_420BPP8 ||
-			format == SPL_PIXEL_FORMAT_420BPP10)
-		return true;
-	else
-		return false;
-}
-
-static bool spl_dscl_is_video_format(enum spl_pixel_format format)
-{
-	if (format >= SPL_PIXEL_FORMAT_VIDEO_BEGIN
-			&& format <= SPL_PIXEL_FORMAT_VIDEO_END)
-		return true;
-	else
-		return false;
-}
-
 static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
 				const struct spl_scaler_data *data,
 				bool enable_isharp, bool enable_easf)
@@ -749,8 +749,8 @@ static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
 			&& !enable_isharp)
 		return SCL_MODE_SCALING_444_BYPASS;
 
-	if (!spl_dscl_is_420_format(pixel_format)) {
-		if (spl_dscl_is_video_format(pixel_format))
+	if (!spl_is_subsampled_format(pixel_format)) {
+		if (spl_is_video_format(pixel_format))
 			return SCL_MODE_SCALING_444_YCBCR_ENABLE;
 		else
 			return SCL_MODE_SCALING_444_RGB_ENABLE;
@@ -773,7 +773,7 @@ static bool spl_choose_lls_policy(enum spl_pixel_format format,
 	enum spl_transfer_func_predefined tf_predefined_type,
 	enum linear_light_scaling *lls_pref)
 {
-	if (spl_is_yuv420(format)) {
+	if (spl_is_video_format(format)) {
 		*lls_pref = LLS_PREF_NO;
 		if ((tf_type == SPL_TF_TYPE_PREDEFINED) ||
 			(tf_type == SPL_TF_TYPE_DISTRIBUTED_POINTS))
@@ -832,7 +832,7 @@ static bool enable_easf(struct spl_in *spl_in, struct spl_scratch *spl_scratch)
 /* Check if video is in fullscreen mode */
 static bool spl_is_video_fullscreen(struct spl_in *spl_in)
 {
-	if (spl_is_yuv420(spl_in->basic_in.format) && spl_in->is_fullscreen)
+	if (spl_is_video_format(spl_in->basic_in.format) && spl_in->is_fullscreen)
 		return true;
 	return false;
 }
@@ -863,10 +863,10 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 	 * Apply sharpness to RGB and YUV (NV12/P010)
 	 *  surfaces based on policy setting
 	 */
-	if (!spl_is_yuv420(spl_in->basic_in.format) &&
+	if (!spl_is_video_format(spl_in->basic_in.format) &&
 		(spl_in->sharpen_policy == SHARPEN_YUV))
 		return enable_isharp;
-	else if ((spl_is_yuv420(spl_in->basic_in.format) && !fullscreen) &&
+	else if ((spl_is_video_format(spl_in->basic_in.format) && !fullscreen) &&
 		(spl_in->sharpen_policy == SHARPEN_RGB_FULLSCREEN_YUV))
 		return enable_isharp;
 	else if (!spl_in->is_fullscreen &&
@@ -949,7 +949,7 @@ static bool spl_get_optimal_number_of_taps(
 	int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
 	bool skip_easf = false;
-	bool is_ycbcr = spl_dscl_is_video_format(spl_in->basic_in.format);
+	bool is_subsampled = spl_is_subsampled_format(spl_in->basic_in.format);
 
 	if (spl_scratch->scl_data.viewport.width > spl_scratch->scl_data.h_active &&
 		max_downscale_src_width != 0 &&
@@ -981,7 +981,7 @@ static bool spl_get_optimal_number_of_taps(
 	if (skip_easf)
 		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps);
 	else {
-		if (spl_is_yuv420(spl_in->basic_in.format)) {
+		if (spl_is_video_format(spl_in->basic_in.format)) {
 			spl_scratch->scl_data.taps.h_taps = 6;
 			spl_scratch->scl_data.taps.v_taps = 6;
 			spl_scratch->scl_data.taps.h_taps_c = 4;
@@ -999,8 +999,7 @@ static bool spl_get_optimal_number_of_taps(
 	min_taps_c = spl_fixpt_ceil(spl_scratch->scl_data.ratios.vert_c);
 
 	/* Use LB_MEMORY_CONFIG_3 for 4:2:0 */
-	if ((spl_in->basic_in.format == SPL_PIXEL_FORMAT_420BPP8)
-		|| (spl_in->basic_in.format == SPL_PIXEL_FORMAT_420BPP10))
+	if (spl_is_yuv420(spl_in->basic_in.format))
 		lb_config = LB_MEMORY_CONFIG_3;
 	else
 		lb_config = LB_MEMORY_CONFIG_0;
@@ -1056,7 +1055,7 @@ static bool spl_get_optimal_number_of_taps(
 		if (spl_scratch->scl_data.taps.h_taps_c == 5)
 			spl_scratch->scl_data.taps.h_taps_c = 4;
 
-		if (spl_is_yuv420(spl_in->basic_in.format)) {
+		if (spl_is_video_format(spl_in->basic_in.format)) {
 			if (spl_scratch->scl_data.taps.h_taps <= 4) {
 				*enable_easf_v = false;
 				*enable_easf_h = false;
@@ -1101,10 +1100,10 @@ static bool spl_get_optimal_number_of_taps(
 			spl_scratch->scl_data.taps.h_taps = 1;
 			spl_scratch->scl_data.taps.v_taps = 1;
 
-			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c) && !is_ycbcr)
+			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c) && !is_subsampled)
 				spl_scratch->scl_data.taps.h_taps_c = 1;
 
-			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c) && !is_ycbcr)
+			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c) && !is_subsampled)
 				spl_scratch->scl_data.taps.v_taps_c = 1;
 
 			*enable_easf_v = false;
@@ -1118,11 +1117,11 @@ static bool spl_get_optimal_number_of_taps(
 				(IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert)))
 				spl_scratch->scl_data.taps.v_taps = 1;
 
-			if ((!*enable_easf_h) && !is_ycbcr &&
+			if ((!*enable_easf_h) && !is_subsampled &&
 				(IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c)))
 				spl_scratch->scl_data.taps.h_taps_c = 1;
 
-			if ((!*enable_easf_v) && !is_ycbcr &&
+			if ((!*enable_easf_v) && !is_subsampled &&
 				(IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c)))
 				spl_scratch->scl_data.taps.v_taps_c = 1;
 		}
@@ -1133,7 +1132,7 @@ static bool spl_get_optimal_number_of_taps(
 static void spl_set_black_color_data(enum spl_pixel_format format,
 			struct scl_black_color *scl_black_color)
 {
-	bool ycbcr = spl_dscl_is_video_format(format);
+	bool ycbcr = spl_is_video_format(format);
 	if (ycbcr)	{
 		scl_black_color->offset_rgb_y = BLACK_OFFSET_RGB_Y;
 		scl_black_color->offset_rgb_cbcr = BLACK_OFFSET_CBCR;
@@ -1600,7 +1599,7 @@ static void spl_set_easf_data(struct spl_scratch *spl_scratch, struct spl_out *s
 			0x0;	// fp1.5.10, C3 coefficient
 	}
 
-	if (spl_is_yuv420(format)) { /* TODO: 0 = RGB, 1 = YUV */
+	if (spl_is_video_format(format)) { /* TODO: 0 = RGB, 1 = YUV */
 		dscl_prog_data->easf_matrix_mode = 1;
 		/*
 		 * 2-bit, BF3 chroma mode correction calculation mode
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 0e6db94bbfb2..467af9dd90de 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -63,13 +63,13 @@ enum spl_pixel_format {
 	SPL_PIXEL_FORMAT_420BPP8,
 	SPL_PIXEL_FORMAT_420BPP10,
 	/*end of pixel format definition*/
-	SPL_PIXEL_FORMAT_INVALID,
-	SPL_PIXEL_FORMAT_422BPP8,
-	SPL_PIXEL_FORMAT_422BPP10,
 	SPL_PIXEL_FORMAT_GRPH_BEGIN = SPL_PIXEL_FORMAT_INDEX8,
 	SPL_PIXEL_FORMAT_GRPH_END = SPL_PIXEL_FORMAT_FP16,
+	SPL_PIXEL_FORMAT_SUBSAMPLED_BEGIN = SPL_PIXEL_FORMAT_420BPP8,
+	SPL_PIXEL_FORMAT_SUBSAMPLED_END = SPL_PIXEL_FORMAT_420BPP10,
 	SPL_PIXEL_FORMAT_VIDEO_BEGIN = SPL_PIXEL_FORMAT_420BPP8,
 	SPL_PIXEL_FORMAT_VIDEO_END = SPL_PIXEL_FORMAT_420BPP10,
+	SPL_PIXEL_FORMAT_INVALID,
 	SPL_PIXEL_FORMAT_UNKNOWN
 };
 
-- 
2.47.1

