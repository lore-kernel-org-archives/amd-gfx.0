Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9E9C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9E810EB0B;
	Tue,  8 Sep 2026 11:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uP+xL1r4";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D48E10EB0B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHdKxR+rR1a7V15fft46hFNxKQsF8yBD1WGt3Il5u+Yx9W+vgAxyp5kav2fH5rNcxpqNhFSi2BQKn9jm4ZCJ5EGmTKn6VmtAC4++4UoO6R9h6R8T7QWBNvCrUB/aDFSZ5Ltp7f2e9mBKSTf9yM884XB3R4T6aMCDlVSlIYdanG8LYcvOd8SF6CDxWFB0W/sUNINSmejVVHQYZafm/hEdD3zbLzxoVQxHixPWRDnZaHX394OpZ5GNDDLycQWy1fkGwZggOpxqFDcSDNjkdEVgff/rE6Thqu/2ZHDwwnAV+Oy0cY/7sX4x15F0MxuzVTKIeM0mTYUrCNLuiqgF63eY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWjfMiyI3qmG522Zj2zU+zf61riiiwHs3CCI0E8tAPc=;
 b=eAROBy8dymMGwnpQrETQYm8WQ4sSTA0fIcPYwVBQB5tIHohzbYGAz5ysfOyU3bvwCq+8pnBrH4oC2PA1lXP4OOqbVSzMtYA0OBuardAWsS/1r9TAzDya+ciIHO1cEsYRJQg55R9tCazFsSycnyMiGCpWjSfLClKXPfhvC4dUiMdV8FvFts/um+BIGrEY6s8srU2oqBryN8fGUbZe14K4MtEMM0celERoiO04fBNP0UtMDXCdA207ncmRi8zWak65GPzM4WV8lxzkvsyWc/HduQtAiFnUQkRWLcw1QJp9OioEb9hksrjqQIFjZqWoWZZ3JvkxRNp//Aa2E4vl6aVLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWjfMiyI3qmG522Zj2zU+zf61riiiwHs3CCI0E8tAPc=;
 b=uP+xL1r4Lr/JTc4Bkpozp+VM3yIeCSBLMxVY7XTOm2jWSqtNzljy24HhMCQTKeCU00eBm66vX0Ub21w7zPEiXiXfW+eLY8NIRkRwttFs1hpGnDv6oZgnKUA42m/aJ3Wr0b8AjXpmgD32qZQ4/uioCK9G4Gp/Uv+m6U8evvMtqLg=
Received: from DSSP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::6) by
 SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Tue, 8 Sep 2026 11:34:27 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:3d3:cafe::31) by DSSP220CA0003.outlook.office365.com
 (2603:10b6:8:3d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:34:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:34:02 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:33:53 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Taimur Hassan <syed.hassan@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 02/66] drm/amd/display: Update LLS and UPSP programming paths
Date: Tue, 8 Sep 2026 19:30:55 +0800
Message-ID: <20260908113338.2433445-3-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb97322-bdd2-4131-3f44-08df0d9d240c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: ERvjfigq3rpXspxTl6kzrxqLFw612oAVY+yiy6NIKsq0WwWJNQnMusQmR8Zw1Ydj0psD78D7buWopSDBc815kIuFmXtD3BxVSd6ktaiacwbR2PtAR+OBqUmYVcyiX1niyRbAC7oS0vj70GN6ZzlZRM1mum+P7LjgBPHSlHUnObblIcrwblg3ObVOb00HRyz7q1fWW5dbXGlgDjN6y7G7xMgUyaLUxJIR/cQdAiGKOizl96cwv1QRy3uJvN2paOZTxSliBGfGpm8WZEnVAjMfXIHhfB3mn38crxrzGaXWNIlKVJKSup1Ge7Dd9CpjRtZpYgRLpBAzFbWxZzUZMPNuc6z5R3JwRwJIGjUMpkWBtr67N2xj2NHia/lT8j2Vp7EXHO8QEzGr74Rrvv1l1HjhWDPO5KF45yEZYLuilYkPfxqt5oDktlPX81GPX/PrWdOWUxKUksElI/8CXRK1LiGvPhNb5/FHRFEP+1GFzEc4g7hZN/H5ugLIKq33FQMDRQLcgBiGMLK0pp0gh+QtmDsR8+FVHH1gZo/jhTwOMOSaU94Nh+39zsueh2LWOUpADud23NkcLQ+nG47I9epFBfwCHH561E9nh1zibexkZQzkAZ5BtuIbXw6MdgwlRBN8p+5JGUL178CFTf7Qu6L2E3tSD7QDLwQZAs3Qp4jGbZBJMBTvhM4dABqf6wsrzRPNW+wmN3o1q0n5FBbrbeBRoI2OFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZG4CaxjLAOaYbBqDRWmx7buHD4TQjX7cyrCmYVhKpWU5y+MzQImFqzmdwFk1XEXGCmy9X+4tU+qhedKRZv7kKidDRz4D+6Rzfx9l99d2fQn5wcA5k/hA99RC8nKzx7cb46mIeE0Yse0hbddtpojat+AeK5b7uawUllNOv+7UrJirHoJH4pX5TeKHJo1YIyf6NToHwqWQ3YZjHW9ufl50XMaU9Ihp2VNpdiHU9cnanPms+3tRbE/9e0pIaA4cIvw1O8XuHTDVwNH2taJ6FicFaKDJDwS+Rv20L/vD2x82KR0rw8JzwY8Ijy0/KUpWZVDQMyUfXZrdp7001MdeV2Ei3H/wc+7GnYpT4u1WHikff2LmZ4nF70zTsclCT7C6bKdE7WnM9LaowDbNMOv6sQEqlDalgEk51nv0UslCcKkMjbygRODTcOKU7Z5a0EUksO8A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:34:27.5316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb97322-bdd2-4131-3f44-08df0d9d240c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- UPSP should only be enabled when we want linear scaling for 420/422
- In DC for non-FP16 formats that are told to scale in non-linear, program
  bypass for PRE_GAM since these formats are already non-linear (i.e.,
  YUV420, YUV422, RGB, etc.)

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Taimur Hassan <syed.hassan@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 18 ++++++++++++----
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c  | 20 +++++++++++++-----
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h  |  3 ++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 21 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  3 ++-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 ++-
 6 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f9b8e9474b4c..593c1fd537ae 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1557,11 +1557,21 @@ void resource_build_test_pattern_params(struct resource_context *res_ctx,
 	}
 }
 
-enum upsp_mode resource_is_upsp_required(enum surface_pixel_format format)
+enum upsp_mode resource_is_upsp_required(enum surface_pixel_format format,
+		enum dc_scaling_linearity scaling_linearity)
 {
-	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN && format <= SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb) //420 Formats
+	bool scaling_in_linear = (scaling_linearity == DC_SCALING_LINEARITY_LINEAR);
+	bool is_420_format = (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
+			format <= SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb);
+	bool is_422_format = (format > SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb &&
+			format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
+
+	/* UPSP (chroma upsampling) is only needed when subsampled YUV is scaled in
+	 * linear space.
+	 */
+	if (scaling_in_linear && is_420_format)
 		return UPSP_HORIZONTAL_VERTICAL_UPSAMPLING;
-	if (format > SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb && format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END) //422 Formats
+	if (scaling_in_linear && is_422_format)
 		return UPSP_HORIZONTAL_UPSAMPLING_ONLY;
 	return UPSP_BYPASS;
 }
@@ -1611,7 +1621,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 			pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
 
 		pipe_ctx->plane_res.scl_data.lb_params.alpha_en = plane_state->per_pixel_alpha;
-		pipe_ctx->plane_res.scl_data.upsp = resource_is_upsp_required(plane_state->format);
+		pipe_ctx->plane_res.scl_data.upsp = resource_is_upsp_required(plane_state->format, plane_state->scaling_linearity);
 
 		// Convert pipe_ctx to respective input params for SPL
 		translate_SPL_in_params_from_pipe_ctx(pipe_ctx, spl_in);
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
index 04cab7d3a5c2..38739ed048fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
@@ -25,17 +25,27 @@
 void dpp50_set_pregam_state(
 	struct dpp *dpp_base,
 	enum dc_transfer_func_predefined tr,
-	enum dc_scaling_linearity scaling)
+	enum dc_scaling_linearity scaling,
+	bool source_is_linear)
 {
 	struct dcn50_dpp *dpp = TO_DCN50_DPP(dpp_base);
 	enum pregam_mode pre_degam_en = PREGAM_DEGAM;
 	enum degam_lut degamma_lut_selection = 0;
 
 	if (scaling == DC_SCALING_LINEARITY_SOURCE) {
-		//If scaling in non-linear, apply regamma
-		REG_SET_2(PRE_GAM, 0,
-			PRE_GAM_MODE, PREGAM_REGAM,
-			PRE_REGAM_SELECT, REGAM_20);
+		if (source_is_linear) {
+			//Linear source data (e.g. FP16) must be de-linearized
+			//(apply regamma) before scaling in source/non-linear space.
+			REG_SET_2(PRE_GAM, 0,
+				PRE_GAM_MODE, PREGAM_REGAM,
+				PRE_REGAM_SELECT, REGAM_20);
+		} else {
+			//Non-linear source data (e.g. YUV) is already in source
+			//space, so scale directly with no pregam conversion.
+			REG_SET_2(PRE_GAM, 0,
+				PRE_GAM_MODE, PREGAM_BYPASS,
+				PRE_DEGAM_SELECT, 0);
+		}
 	} else {
 		//If scaling in linear, apply degamma based on TF
 		switch (tr) {
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
index 7f5d3fa6bbef..c81e910ae095 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
@@ -82,6 +82,7 @@ void dpp50_dpp_setup(
 void dpp50_set_pregam_state(
 	struct dpp *dpp_base,
 	enum dc_transfer_func_predefined tr,
-	enum dc_scaling_linearity scaling);
+	enum dc_scaling_linearity scaling,
+	bool source_is_linear);
 
 #endif /* __DCN50_DPP_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 79be5c385280..430966af3808 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -528,6 +528,24 @@ bool dcn32_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
 	return result;
 }
 
+/*
+ * FP16 / 64bpp 16161616 surfaces store pixel data in linear light. These are
+ * the only source formats that must be de-linearized before scaling in
+ * source/non-linear space; every other format is already non-linear.
+ */
+static bool is_source_pixel_format_linear(enum surface_pixel_format format)
+{
+	switch (format) {
+	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
+	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
+		return true;
+	default:
+		return false;
+	}
+}
+
 bool dcn32_set_input_transfer_func(struct set_input_transfer_func_params *params)
 {
 	struct dce_hwseq *hws = params->dc->hwseq;
@@ -547,7 +565,8 @@ bool dcn32_set_input_transfer_func(struct set_input_transfer_func_params *params
 		tf = plane_state->in_transfer_func.tf;
 
 	if (dpp->funcs->dpp_set_pregam_state)
-		dpp->funcs->dpp_set_pregam_state(dpp, tf, plane_state->scaling_linearity);
+		dpp->funcs->dpp_set_pregam_state(dpp, tf, plane_state->scaling_linearity,
+				is_source_pixel_format_linear(plane_state->format));
 	else
 		dpp->funcs->dpp_set_pre_degam(dpp, tf);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index b31b144d2e8f..930b5533256f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -378,7 +378,8 @@ struct dpp_funcs {
 	void (*dpp_set_pregam_state)(
 			struct dpp *dpp_base,
 			enum dc_transfer_func_predefined tr,
-			enum dc_scaling_linearity scaling);
+			enum dc_scaling_linearity scaling,
+			bool source_is_linear);
 	void (*dpp_program_upsp)(
 			struct dpp *dpp_base,
 			const struct dscl_prog_data *dscl_prog_data);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 8e21aaac06b3..9c6794f8dec0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -123,7 +123,8 @@ void resource_build_test_pattern_params(
 		struct resource_context *res_ctx,
 		struct pipe_ctx *pipe_ctx);
 
-enum upsp_mode resource_is_upsp_required(enum surface_pixel_format format);
+enum upsp_mode resource_is_upsp_required(enum surface_pixel_format format,
+		enum dc_scaling_linearity scaling_linearity);
 
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx);
 
-- 
2.43.0

