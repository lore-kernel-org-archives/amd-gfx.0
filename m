Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16C9EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 21:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25A410E5AA;
	Thu, 22 Jun 2023 21:58:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450EA10E5A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 21:58:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le0+tSxp8d6Z8YSN12zPYLP10ylIcLFfChuk+OOILujVA8vmoM3Yck0+wZ4hh2BtFta/y+OCCdnX0eNLaD0cOeApMDIh8r772V2O3r312G43Shro74BLosAYctmV/1gX/+c3scNDRFsZ/gF22vbyzElYhQBODqeBZYAJs7aMNiDLJ0+nTNHDgCScVqK32tTbhpKM0ZEV94olnd1PnexjwmPoY8ey/Wgo4U/YlaIYjsOT3nWc2ro2BWA3UKbp3igzzZt1E8tmpfxrOMCd15qF25bPnzM9634uKirRyhPESKBX19Ofh28fPnaCvWVBWzGRXgH0XltSuaW5qZaXa+MdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmpxEUuUvJAEXMlPO06iSUCtfYGXs288jCYj5/4HoaY=;
 b=AphgQs0K523jxy6kNJd59uohLl8Zp+46msVpLHWwu3zCcg6xTl8bqkyOE/t+N+HdDxf5n2DK+1eTZZ5Oz102f6YUTFoJ9k3iPsAH34sSj7cs0X0CBpsjyzCzWTj9Szn3OlVt2kQB0nMkhezNFK1qXisREapCagc8BXLF43v3X6O/g+4VvIHLNDj1vvPLEKEcsWhjvHeBMSfwqM0OGmbpvqIW/5ylwTm7Y6pDGpyB7MfKoKNJXrsDsxuknQjSxTPHQZg8GkxPO6SOSK2hOJMvBRf+ig9DtXNtzh0FkjymS3acAdlo7cJ4mjm0Cj5Syi2QavokaQy2x54YbQ5izppiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmpxEUuUvJAEXMlPO06iSUCtfYGXs288jCYj5/4HoaY=;
 b=E7x9+i/xaS5HMo4srDPReT+86iB1xZCgmSSNLCdBcmdlrqB+9Wxg+69MMt0Xl4PXFNOn2n/gWtW6ZuEDjCJzeT11SrR9mBZDuKmTBIop6mRc6NGoZr6dOePtAcAj+FXFN1czKn7O+WX/ET11JFdJAHHHKS9sxhmcaE93iCmEb08=
Received: from SA1P222CA0136.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::16)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 21:58:11 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::6) by SA1P222CA0136.outlook.office365.com
 (2603:10b6:806:3c2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 21:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 21:58:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:58:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/11] drm/amd/display: Fix the delta clamping for shaper LUT
Date: Thu, 22 Jun 2023 15:57:28 -0600
Message-ID: <20230622215735.2026220-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
References: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 525bbc5f-b59e-4c03-ad90-08db736bc4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PE1s2v4/+Zh0QK42EIwrvxMPUaNQ0sXHNfotYhBYXnSf0qkwL0qoEf5hCM4Zor2CtGks/yBIiUj1eTcQPi8W6kCiUVsCMOGgr01FQfHtuQmny/ve2Z6BfFdiAImM7mMNt4JqwpQmQGfmsjBCtS42jUpkE+0c74D63UF5I+8QB5ozQ6SRiQcWz2XCZPxVwEdfe1MqZvW89zOXVUY14PmX6UrOBDzfJWJrtz5iyMX3pNF2lzLRmJMNMxMRgfuJcWSpPei2OB/LHef52B76xjjdrRr1byokyuC6Pas3obzDDT1XxV+9tHZinm7DB3ET6opVFYixcBi0S9/il2EoHnH2udGUIQcv8DfcFRgTFdT/pNofYIFEYd69m9+QpX7N0jqi/YCXHYoaigesXiAxOj2v3uJEpBwWcFCOVKYYrNfPYD+AzexL3g7p8FYGTjKybFYczvKGTp0c3yD22OQpmnLSFhwm8dP5pivrHfyh5/XWiTUnKO46uOXtfsCXViM9iAqd9mGGYPv8fxe413ZJ9QbwNnvw2TdZMn9Rj7FBPtU27kq14GEHhX4gXPhNTiepyBGcvSgW1531OnmLDqZRrEBc4XAw9SUtAGxvsbLp2Mwfds8lOgYWL4VsotCqpm7+MOmMl+ACAGXcue/ye3crEl04NBDqatHkYqPkMpF/vK+ybrKo4Ylwnx8OX7llbV2N4V1sViDFe1v4ur0AuW3m+gfbUFrnMGogRwjzMHJDO1HM7wQHHZC5ilvI9rLe+ACUSka0g1c86j4Of2z6pFAs3H9O3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(6666004)(82740400003)(1076003)(186003)(5660300002)(16526019)(82310400005)(478600001)(356005)(81166007)(26005)(40480700001)(2616005)(2906002)(8936002)(41300700001)(40460700003)(8676002)(54906003)(6916009)(70206006)(36756003)(426003)(83380400001)(316002)(47076005)(70586007)(36860700001)(86362001)(4326008)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:58:10.5718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525bbc5f-b59e-4c03-ad90-08db736bc4f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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
Cc: stylon.wang@amd.com, Krunoslav Kovac <krunoslav.kovac@amd.com>,
 Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 qingqing.zhuo@amd.com, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

The shaper LUT requires a 10-bit value of the delta between segments. We
were using dc_fixpt_clamp_u0d10() to do that but it doesn't do what we
want it to do. It will preserve 10-bit precision after the decimal
point, but that's not quite what we want. We want 14-bit precision and
discard the 4 most-significant bytes.

To do that we'll do dc_fixpt_clamp_u0d14() & 0x3ff instead.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_cm_common.c    | 19 +++++++++++++++----
 .../amd/display/dc/dcn10/dcn10_cm_common.h    |  1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  6 +++---
 .../drm/amd/display/dc/dcn30/dcn30_dwb_cm.c   |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  2 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  6 +++---
 7 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 7a00fe525dfb..3538973bd0c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -308,7 +308,10 @@ bool cm_helper_convert_to_custom_float(
 #define NUMBER_REGIONS     32
 #define NUMBER_SW_SEGMENTS 16
 
-bool cm_helper_translate_curve_to_hw_format(
+#define DC_LOGGER \
+		ctx->logger
+
+bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 				const struct dc_transfer_func *output_tf,
 				struct pwl_params *lut_params, bool fixpoint)
 {
@@ -482,10 +485,18 @@ bool cm_helper_translate_curve_to_hw_format(
 		rgb->delta_green = dc_fixpt_sub(rgb_plus_1->green, rgb->green);
 		rgb->delta_blue  = dc_fixpt_sub(rgb_plus_1->blue,  rgb->blue);
 
+
 		if (fixpoint == true) {
-			rgb->delta_red_reg   = dc_fixpt_clamp_u0d10(rgb->delta_red);
-			rgb->delta_green_reg = dc_fixpt_clamp_u0d10(rgb->delta_green);
-			rgb->delta_blue_reg  = dc_fixpt_clamp_u0d10(rgb->delta_blue);
+			uint32_t red_clamp = dc_fixpt_clamp_u0d14(rgb->delta_red);
+			uint32_t green_clamp = dc_fixpt_clamp_u0d14(rgb->delta_green);
+			uint32_t blue_clamp = dc_fixpt_clamp_u0d14(rgb->delta_blue);
+
+			if (red_clamp >> 10 || green_clamp >> 10 || blue_clamp >> 10)
+				DC_LOG_WARNING("Losing delta precision while programming shaper LUT.");
+
+			rgb->delta_red_reg   = red_clamp & 0x3ff;
+			rgb->delta_green_reg = green_clamp & 0x3ff;
+			rgb->delta_blue_reg  = blue_clamp & 0x3ff;
 			rgb->red_reg         = dc_fixpt_clamp_u0d14(rgb->red);
 			rgb->green_reg       = dc_fixpt_clamp_u0d14(rgb->green);
 			rgb->blue_reg        = dc_fixpt_clamp_u0d14(rgb->blue);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.h
index 3b8cd7410498..0a68b63d6126 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.h
@@ -106,6 +106,7 @@ bool cm_helper_convert_to_custom_float(
 		bool fixpoint);
 
 bool cm_helper_translate_curve_to_hw_format(
+		struct dc_context *ctx,
 		const struct dc_transfer_func *output_tf,
 		struct pwl_params *lut_params, bool fixpoint);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 20a1582be0b1..a50309039d08 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1843,7 +1843,7 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	/* dcn10_translate_regamma_to_hw_format takes 750us, only do it when full
 	 * update.
 	 */
-	else if (cm_helper_translate_curve_to_hw_format(
+	else if (cm_helper_translate_curve_to_hw_format(dc->ctx,
 			stream->out_transfer_func,
 			&dpp->regamma_params, false)) {
 		dpp->funcs->dpp_program_regamma_pwl(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 4c8aa3dfb959..4492bc2392b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -867,7 +867,7 @@ bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			params = &stream->out_transfer_func->pwl;
 		else if (pipe_ctx->stream->out_transfer_func->type ==
 			TF_TYPE_DISTRIBUTED_POINTS &&
-			cm_helper_translate_curve_to_hw_format(
+			cm_helper_translate_curve_to_hw_format(dc->ctx,
 			stream->out_transfer_func,
 			&mpc->blender_params, false))
 			params = &mpc->blender_params;
@@ -896,7 +896,7 @@ bool dcn20_set_blend_lut(
 		if (plane_state->blend_tf->type == TF_TYPE_HWPWL)
 			blend_lut = &plane_state->blend_tf->pwl;
 		else if (plane_state->blend_tf->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(
+			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
 					plane_state->blend_tf,
 					&dpp_base->regamma_params, false);
 			blend_lut = &dpp_base->regamma_params;
@@ -918,7 +918,7 @@ bool dcn20_set_shaper_3dlut(
 		if (plane_state->in_shaper_func->type == TF_TYPE_HWPWL)
 			shaper_lut = &plane_state->in_shaper_func->pwl;
 		else if (plane_state->in_shaper_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(
+			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
 					plane_state->in_shaper_func,
 					&dpp_base->shaper_params, true);
 			shaper_lut = &dpp_base->shaper_params;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
index 6a3d3a0ec0a3..701c7d8bc038 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
@@ -280,7 +280,7 @@ bool dwb3_ogam_set_input_transfer_func(
 	dwb_ogam_lut = kzalloc(sizeof(*dwb_ogam_lut), GFP_KERNEL);
 
 	if (dwb_ogam_lut) {
-		cm_helper_translate_curve_to_hw_format(
+		cm_helper_translate_curve_to_hw_format(dwbc->ctx,
 			in_transfer_func_dwb_ogam,
 			dwb_ogam_lut, false);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index b9753867d97b..bf8864bc8a99 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -106,7 +106,7 @@ static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
 		if (stream->func_shaper->type == TF_TYPE_HWPWL) {
 			shaper_lut = &stream->func_shaper->pwl;
 		} else if (stream->func_shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(stream->func_shaper,
+			cm_helper_translate_curve_to_hw_format(stream->ctx, stream->func_shaper,
 							       &dpp_base->shaper_params, true);
 			shaper_lut = &dpp_base->shaper_params;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index e5bd76c6b1d3..526e89ef9cdc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -448,7 +448,7 @@ bool dcn32_set_mpc_shaper_3dlut(
 		if (stream->func_shaper->type == TF_TYPE_HWPWL)
 			shaper_lut = &stream->func_shaper->pwl;
 		else if (stream->func_shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(
+			cm_helper_translate_curve_to_hw_format(stream->ctx,
 					stream->func_shaper,
 					&dpp_base->shaper_params, true);
 			shaper_lut = &dpp_base->shaper_params;
@@ -484,7 +484,7 @@ bool dcn32_set_mcm_luts(
 		if (plane_state->blend_tf->type == TF_TYPE_HWPWL)
 			lut_params = &plane_state->blend_tf->pwl;
 		else if (plane_state->blend_tf->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(
+			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
 					plane_state->blend_tf,
 					&dpp_base->regamma_params, false);
 			lut_params = &dpp_base->regamma_params;
@@ -499,7 +499,7 @@ bool dcn32_set_mcm_luts(
 		else if (plane_state->in_shaper_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
 			// TODO: dpp_base replace
 			ASSERT(false);
-			cm_helper_translate_curve_to_hw_format(
+			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
 					plane_state->in_shaper_func,
 					&dpp_base->shaper_params, true);
 			lut_params = &dpp_base->shaper_params;
-- 
2.39.2

