Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2502FCA600A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B570810F6F8;
	Wed,  7 Oct 2026 17:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ri+PrZVf";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011027.outbound.protection.outlook.com
 [40.93.194.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649AB10E659
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLQwhl3ssoUozIL+USu+iW9y1euHe009bD6/8QSrWyVRoOFEYRlA286PQf4rYvcEceeTAdIIUW3ssros3cl0BeLXmcLr4uchIIF73YwFMUaXgOCE6ZMtG8tR9fEpIGhmiC+ZHLDppGejMTRz/aUIiN/huBG8D6yyQkwtAfl1kd6k4oiFgNVWOL5hBIXrXg6t1lYD4Gow98nGNJfJe0bJB+8ZwcDk4IiGCBr7/Fxjfhuiy2puBTecMotP8d2TmfYyXnkhTJDgPwa4QtBek2VcegQdidzVwJuXSOsM13PrWhFgr4rJPtswtstbe107ZDdFf0AwR2h2MQXR3Hjgjq/Xfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpqHgF8SWQWXYfvJ4XVscPymAcyxeIbvreCXSPDozvE=;
 b=CEFdpB39GXpIhhRBP+BXzg4+YTmVv7cwlAl6I3f/kbKUeK/w/zcBWWkWtUUBLZYA3VMJaIimyNZA404D0SBwsV+i0QGkQH4TG++tYrhO7tTBywluac4lPh2cbgieQZMPo12ME914QIuH8rPvcQt1uD7I3lEG/+IMsGlI3xAdDkCTI+cKiD4gUpQyI1oa/KkCNh6PnaJ4p0KE6oq/JgtTlYq10bBKQj6/HUyQgdefehKI5S/ZbHVPpbO8Xm7YMEbTJldl75l/6mXdimXaINeHBti0cYgDxc7hvuytZ+oMLfT3epKEBP9g7BNJAWIII78JxBAtB/ke4Y59U5vqDE5Ppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpqHgF8SWQWXYfvJ4XVscPymAcyxeIbvreCXSPDozvE=;
 b=Ri+PrZVfiU9qcKAFthEqUhh/Pjw2Edrf+im2PnC+RndnuDRX3BzhSHWne9kwmIMe5DGeS736JeA0+OQRPdOcD6UbtNshfCfd8HcepKUtjRCetvykfOxS/kIfInFT0XXP0N6V55CkYonw77xqgLnZ95d+fwm3sNZ8RqaHIHRCLMU=
Received: from PH8PR15CA0011.namprd15.prod.outlook.com (2603:10b6:510:2d2::28)
 by SA6PR12MB999202.namprd12.prod.outlook.com (2603:10b6:806:450::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 17:04:34 +0000
Received: from MW1PEPF0001888D.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::e) by PH8PR15CA0011.outlook.office365.com
 (2603:10b6:510:2d2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 17:04:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001888D.mail.protection.outlook.com (10.167.249.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:28 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:27 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Sridevi Arvindekar <sridevi.arvindekar@amd.com>,
 Samson Tam <samson.tam@amd.com>
Subject: [PATCH 09/19] drm/amd/display: Fix linear scaling and upsampling
Date: Wed, 7 Oct 2026 12:59:42 -0400
Message-ID: <20261007170412.1898315-10-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888D:EE_|SA6PR12MB999202:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d920c5a-22c2-4f7c-a513-08df24950f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qZeRXmQHf3MPOdiynuNGOy+iyx61bJD7j8hldn1ZZ5WtYuOq21ICdrvBJFR6kXHjMfb3yjM8+5HKtfTCexnAfFjCc0GRUH8GJXZTmjf16x3x2FdzAEyMN0Tu8g6l3EeOTHeDw/xZfUQPsUiBe5JMU5v/vmdGhWE6VCfTG+SJmMDMLrA63xR+Qyf6X0BhwxjSXlWQvXdJXnFGNHz3mtT/diC/ups6BE0Mx8YRxg5XJ9tE15X4N7FaOoGC08QZxD4F2Xu06MA0gdlIULeItUwJBxy7gpvkkkv1LOm0a47wWd9VUCzn4WlILbhE4pmbRkgTnlT/+tvU2I/wJ6TVDTHpsx6/rQvAzMFYP0Qg47oiQA4xdLGtTlz6ccTmCD8GaERpq15f8cdhH2GfDpquZieBXBYaekcjMwzUHUh5cTcNnfh7cy/lLtLDLd41ERT4Vj8y9jXRu8uYSehVr13fMVIT+SN54Jp7gItbosLyUl1XduDisCvnhqNWWyZpJmDASOSd4rvafVaZxvpd5Cl9L7tKqCzA9/8K2Gtk0UyYFozgpsX37mQ/IRe63ZfXn9Hf6seH0ZoYFFtqlHjpj8+28WJ2kWp6ZbdRyiCjjKo+cNtBVii3CQMQmXhY/HThtUXEy10WRkwR61iXQo7lGwBAUyPK8tpApHdYuj45S0Psu9O/x6xeaSVg+AIz3WJKL0iGPMBHVr5bEJk/svusP4MEGVi8XA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: chdJV5RC8bB2ATaJ1mv+8bIVPq6jCSn/VMaUG8h2mft5b+xwW1qx3SUkzx6fHtWy0N64nWgq4h805tkbtR4pQWTl7KxoE4UpGY36WLeWF7EKjJ1afh+0WHJqTFMUWkKhBFo/Jl+r3QBRbfm+PkuVJy4jVg97vGdVO0xLkqrHzyyzSx0XumONzGl7vxFzrSWQZLC6s2YipVBn4YprKFInxtnKc40BZ37AwRYnNCpF4m89t/apY2rsmXZ4Di3HkycuScNXCg3NDeND0dcUlZBz0xmNcyIDtQw+aJwlx/9G2aO6QOrGhCrrzk67SnByp2wWPIt5zgwDoA+wmuuus/wDTwqoxpunM4v5mf6Jwz8OsKd3s80VU1xrjsGBiVDWSIXCVCEGnOqRGR9MAhawQSAAlG1tp6N/wK6WUIQ3tkEyBOgz3gyV8objcArDd5DZLBkQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:33.5910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d920c5a-22c2-4f7c-a513-08df24950f66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001888D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999202
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

From: Sridevi Arvindekar <sridevi.arvindekar@amd.com>

[Why/How]
For upsampling/linear scaling case, SPL needs to consider format
to be rgb and not yuv.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 52 +++++++++++---------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index f14e3069acfd..1b7ce1a8c59d 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -487,15 +487,17 @@ static void spl_calculate_scaling_ratios(struct spl_in *spl_in,
 	spl_scratch->scl_data.ratios.horz_c = spl_scratch->scl_data.ratios.horz;
 	spl_scratch->scl_data.ratios.vert_c = spl_scratch->scl_data.ratios.vert;
 
-	if (spl_is_yuv420(spl_in->basic_in.format)) {
-		spl_scratch->scl_data.ratios.horz_c.value /= 2;
-		spl_scratch->scl_data.ratios.vert_c.value /= 2;
-	} else if (spl_is_yuv422(spl_in->basic_in.format)) {
-		if (spl_in->basic_in.rotation == SPL_ROTATION_ANGLE_90 ||
-			spl_in->basic_in.rotation == SPL_ROTATION_ANGLE_270)
-			spl_scratch->scl_data.ratios.vert_c.value /= 2;
-		else
+	if (!spl_in->upsp_mode) {
+		if (spl_is_yuv420(spl_in->basic_in.format)) {
 			spl_scratch->scl_data.ratios.horz_c.value /= 2;
+			spl_scratch->scl_data.ratios.vert_c.value /= 2;
+		} else if (spl_is_yuv422(spl_in->basic_in.format)) {
+			if (spl_in->basic_in.rotation == SPL_ROTATION_ANGLE_90 ||
+				spl_in->basic_in.rotation == SPL_ROTATION_ANGLE_270)
+				spl_scratch->scl_data.ratios.vert_c.value /= 2;
+			else
+				spl_scratch->scl_data.ratios.horz_c.value /= 2;
+		}
 	}
 	spl_scratch->scl_data.ratios.horz = spl_fixpt_truncate(
 			spl_scratch->scl_data.ratios.horz, 19);
@@ -669,7 +671,8 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 			&flip_vert_scan_dir,
 			&flip_horz_scan_dir);
 
-	if (spl_is_subsampled_format(spl_in->basic_in.format)) {
+	if (spl_is_subsampled_format(spl_in->basic_in.format) &&
+			!spl_in->upsp_mode) {
 		/* this gives the direction of the cositing (negative will move
 		 * left, right otherwise)
 		 */
@@ -804,6 +807,9 @@ static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
 			&& !enable_isharp)
 		return SCL_MODE_SCALING_444_BYPASS;
 
+	if (spl_in->upsp_mode)
+		return SCL_MODE_SCALING_444_RGB_ENABLE;
+
 	if (!spl_is_subsampled_format(pixel_format)) {
 		if (spl_is_video_format(pixel_format))
 			return SCL_MODE_SCALING_444_YCBCR_ENABLE;
@@ -824,9 +830,9 @@ static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
 }
 
 static void spl_choose_lls_policy(enum spl_pixel_format format,
-	enum linear_light_scaling *lls_pref)
+	enum linear_light_scaling *lls_pref, enum upsp_mode upsp_mode)
 {
-	if (spl_is_subsampled_format(format))
+	if (spl_is_subsampled_format(format) && !upsp_mode)
 		*lls_pref = LLS_PREF_NO;
 	else /* RGB or YUV444 */
 		*lls_pref = LLS_PREF_YES;
@@ -858,7 +864,7 @@ static bool enable_easf(struct spl_in *spl_in, struct spl_scratch *spl_scratch)
 	 */
 	if (spl_in->lls_pref == LLS_PREF_DONT_CARE)
 		spl_choose_lls_policy(spl_in->basic_in.format,
-			&spl_in->lls_pref);
+			&spl_in->lls_pref, spl_in->upsp_mode);
 
 	/* Check for linear scaling or EASF preferred */
 	if (spl_in->lls_pref != LLS_PREF_YES && !spl_in->prefer_easf)
@@ -1009,8 +1015,8 @@ static bool spl_get_optimal_number_of_taps(
 	unsigned int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
 	bool skip_easf          = false;
-	bool is_horz_subsampled = spl_is_subsampled_format(spl_in->basic_in.format);
-	bool is_vert_subsampled = spl_is_yuv420(spl_in->basic_in.format);
+	bool is_horz_subsampled = (spl_is_subsampled_format(spl_in->basic_in.format) && !spl_in->upsp_mode);
+	bool is_vert_subsampled = (spl_is_yuv420(spl_in->basic_in.format) && !spl_in->upsp_mode);
 
 	if (spl_scratch->scl_data.viewport.width > spl_scratch->scl_data.h_active &&
 		max_downscale_src_width != 0 &&
@@ -1043,7 +1049,8 @@ static bool spl_get_optimal_number_of_taps(
 		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps, is_horz_subsampled, is_vert_subsampled);
 	}
 	else {
-		if (spl_is_subsampled_format(spl_in->basic_in.format)) {
+		if (spl_is_subsampled_format(spl_in->basic_in.format) &&
+				!spl_in->upsp_mode) {
 			spl_scratch->scl_data.taps.h_taps = 6;
 			spl_scratch->scl_data.taps.v_taps = 6;
 			spl_scratch->scl_data.taps.h_taps_c = 4;
@@ -1213,9 +1220,10 @@ static bool spl_get_optimal_number_of_taps(
 }
 
 static void spl_set_black_color_data(enum spl_pixel_format format,
-			struct scl_black_color *scl_black_color)
+		struct scl_black_color *scl_black_color,
+		enum upsp_mode upsp_mode)
 {
-	bool ycbcr = spl_is_video_format(format);
+	bool ycbcr = (spl_is_video_format(format) && !upsp_mode);
 	if (ycbcr)	{
 		scl_black_color->offset_rgb_y = BLACK_OFFSET_RGB_Y;
 		scl_black_color->offset_rgb_cbcr = BLACK_OFFSET_CBCR;
@@ -1298,8 +1306,8 @@ static void spl_set_dscl_prog_data(struct spl_in *spl_in, struct spl_scratch *sp
 		enable_easf);
 
 	// SCL_BLACK_COLOR
-	spl_set_black_color_data(spl_in->basic_in.format, scl_black_color);
-
+	spl_set_black_color_data(spl_in->basic_in.format, scl_black_color,
+			spl_in->upsp_mode);
 	/* Manually calculate scale ratio and init values */
 	spl_set_manual_ratio_init_data(dscl_prog_data, data);
 
@@ -1358,7 +1366,7 @@ static void spl_calculate_c0_c3_hdr(struct dscl_prog_data *dscl_prog_data, uint3
 static void spl_set_easf_data(struct spl_scratch *spl_scratch, struct spl_out *spl_out, bool enable_easf_v,
 	bool enable_easf_h, enum linear_light_scaling lls_pref,
 	enum spl_pixel_format format, enum system_setup setup,
-	uint32_t sdr_white_level_nits)
+	uint32_t sdr_white_level_nits, enum upsp_mode upsp_mode)
 {
 	struct dscl_prog_data *dscl_prog_data = spl_out->dscl_prog_data;
 	if (enable_easf_v) {
@@ -1689,7 +1697,7 @@ static void spl_set_easf_data(struct spl_scratch *spl_scratch, struct spl_out *s
 			0x0;	// fp1.5.10, C3 coefficient
 	}
 
-	if (spl_is_subsampled_format(format)) { /* TODO: 0 = RGB, 1 = YUV */
+	if (spl_is_subsampled_format(format) && !upsp_mode) { /* TODO: 0 = RGB, 1 = YU//V */
 		dscl_prog_data->easf_matrix_mode = 1;
 		/*
 		 * 2-bit, BF3 chroma mode correction calculation mode
@@ -2073,7 +2081,7 @@ bool SPL_NAMESPACE(spl_calculate_scaler_params(struct spl_in *spl_in, struct spl
 
 	// Set EASF
 	spl_set_easf_data(&spl_scratch, spl_out, enable_easf_v, enable_easf_h, spl_in->lls_pref,
-		spl_in->basic_in.format, setup, spl_in->sdr_white_level_nits);
+		spl_in->basic_in.format, setup, spl_in->sdr_white_level_nits, spl_in->upsp_mode);
 
 	// Set iSHARP
 	vratio = spl_fixpt_ceil(spl_scratch.scl_data.ratios.vert);
-- 
2.43.0

