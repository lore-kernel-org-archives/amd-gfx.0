Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0E5CC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE1B810F77B;
	Tue, 13 Oct 2026 11:19:33 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9362110F781
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQcz9csVJ1MZnch23jeECsTXFejprdnmj6zOdqas8Zr4c4dEMpmVMopttOOiWSGvT8utLC3eAUSf10/qBHURwlJKVcZgdNWuNKkI3adKNkSBiHbPHNoCNpxS/gJS4DB6ODgEy6pAbnH/Qu8NJDUgivACzpQCO4SmLCRbnFnGEfK57kJms10+4bOAxoBFmJk4L2NMat3dQEQSjhkkAmY7epDg/krArEuais738R0JTlKwqVxhGu7MTpcjh8eiX20dX1PPjWcHrxFxX/m7BRwKXw5NuO6guzI3cCHJU6BRtRM55YbNwfN6FxKjhfy2eIZnVQO8z8rdDcPlHnWd5SvAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayvQzeJWL63JIJNj19tN4QcaioWMhkEgfh9gzZjTk6A=;
 b=fL+PrRsnVVKMIxsD43mmth9jNfqPzJKG8pEcajmN3boUXzbb/ZuJ6Qv/gUuuvulrj2UOfpTKS12kVEGjMlYol4bY6d0iuX+UdTRjKJoUQN91Z+FIXemy0JiA1L9WuDAIFIDmbQr8gBMN9v+f6vipSJ+cllO97vuteDXrJWUf9RkmYL/0vceIY/j5aLMbBIpvT46OUpOQxpJkbat/8MnojNQDhjTBOXJNkQzyhHdOM+V8fQWghrgoViaYkZ34RJERNy47ENEf4cpmqN+O3A2ealbYHHYWVTMBWITHAkx++AahLDfgMi8563ug7Q0E73Z6L5YmAqs8kumHwEQK23Y5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayvQzeJWL63JIJNj19tN4QcaioWMhkEgfh9gzZjTk6A=;
 b=UfasV8XRKGdwUEXUEbf8spsZ8K3JgkMHDuotWoE6xDXKQViVKU5Ofq5SAHOG1IWWJid19gBsnFLl1pqARy6gQBR4KxjNf/NvXifDpIo2/QM7RzQZxEbdH1lCsF23XH/X5S0rH3KrF3F/4yrQ+I1o+Kh9C5fjQ74v0xozoIC0rGg=
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:19:23 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::21) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:19:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:19:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:19:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:19:09 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:18:56 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Roman Li <Roman.Li@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 21/30] drm/amd/display: guard DCE-only hwseq definitions
Date: Tue, 13 Oct 2026 19:08:08 +0800
Message-ID: <20261013111616.2267344-22-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 565207be-eeb8-4da5-a139-08df291bd5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223327099003|261009221227099003|261009223027099003|261009220027099003|261009221727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 9KZp7gozVMiwmMSUsN5Oq2F5zyTjeK7sw/qRB4trlEwOBnK4qiI3d6TF+pF7sFMAZfHazF5xISnzMryGhHrGlYfDuJRmewMJDt8ApwvXgqPnvo4TciECBME1GwoM2hthTEfJAR4xBPTQVa+J5Vq0gxZChC4ot+x+Ie9l2kukKbQmKF62F3BsPEMQQ+accsKggqJB76Wz2oMAmcKH0OSurZgCsRhDrmdYtqQ9tE6ZQHOVarxQA6O6HADD5igvhX/MuRpI4vPvNbgxZcqbEZOwl2+XcrWTEdJBDil0f+L+RR80IyLs5stFSDiw5drLbREOiksoF0hZe13sAn+haakwzqexbhbja1twYgLKq5Nb/U/OsaNLRk34uOqZZEPyZE2aP/3X+HNXVVRORvcEOr3fTia88KYF+oY1ugQa+UmnZQyH1ty+DbDEKliD5LFnetCIW+kqVW5X8CVivvJnwqrf71LB8G6k7VaUUzMmq/zgp40XQ/iJSkRUx57gBViaBdRjL2dlyfxXGK9jWgvsUK+s8msap8jqKKpzWGSmel4Sp6NXU04c9iHuHETpa0vWgh0KuifttKllMe1pqHdgf5uZWoPnvzV16jaCZ6nfc+4XVZ1s4Ro8U/yy6HAwomauL0zH0g62chgkLxzcLElqHhp/TIg80oa2KarqrbtLH338fUVFTiBCmQExvHwqJv6jZIYTS5gkZbb3fjEFt9/cOd49/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223327099003)(261009221227099003)(261009223027099003)(261009220027099003)(261009221727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UDkyWqMrdEG66NIu1DmbfhWKkzVumumMPWEpA/MKq9rE3/mICfJEg4Ajm4S15IrVivJ+8ycgh1ZWxQRQFqEG2pyyaBhjqPsHRAXO/o98hAjfheYSL7rGBZZ4lwBVaIiYaAfBjSr4oc0Bp+7QbGqtBtUhg0RS14xKcOKsGVIUxFnMxByip7Ni90wifij7WfpBUuQ5cr1aU3uMhyuKoewOX2XEWx9YC17frnaxZ0+1ajafK0pb80VsqYD+xisy/S7GZYe3Nuvw5PELB4XCgXwUKDLJBLDIO/8y0XPBcgoFU6wrMx2C1eTYVpj1qBVt3Q2SMqYoGn//VqakikT+xhZ1ixq6zzHsCt1ihvg7XFrNvobtEXcrhNUvnNIKQQKnR3aIh9J5ZTWHRT1Hq7BoF9swgZXEZ3qbmsPlqwxE7AH+S+iRIgFzethhm9cetttY1eRN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:19:23.4460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 565207be-eeb8-4da5-a139-08df291bd5aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747
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

From: Roman Li <Roman.Li@amd.com>

[Why]
When CONFIG_DRM_AMD_DC_DCE is disabled, the DCE110 hw_sequencer function
tables along with the DCE-only callbacks and helpers are unused. Some
compilers emit unused-function warnings for them, and the function
tables keep references to code that is not needed in this configuration.

[How]
Wrap the DCE-only function tables, the constructor, and the DCE-only
callbacks and helpers in #if defined(CONFIG_DRM_AMD_DC_DCE) so they are
only compiled when DCE support is enabled. Shared functions used by the
other DCE/DCN hardware sequencers remain compiled unconditionally.
Replace the IS_ENABLED() runtime check in
dce110_hw_sequencer_construct() with the compile-time guard.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 40 +++++++++++++++++--
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index ed6c2096272c..a08ceaeda91c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -102,6 +102,7 @@ struct dce110_hw_seq_reg_offsets {
 	uint32_t crtc;
 };
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static const struct dce110_hw_seq_reg_offsets reg_offsets[] = {
 {
 	.crtc = (mmCRTC0_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
@@ -122,6 +123,7 @@ static const struct dce110_hw_seq_reg_offsets reg_offsets[] = {
 
 #define HW_REG_CRTC(reg, id)\
 	(reg + reg_offsets[id].crtc)
+#endif
 
 #define MAX_WATERMARK 0xFFFF
 #define SAFE_NBP_MARK 0x7FFF
@@ -130,6 +132,7 @@ static const struct dce110_hw_seq_reg_offsets reg_offsets[] = {
  * Private definitions
  ******************************************************************************/
 /***************************PIPE_CONTROL***********************************/
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static void dce110_init_pte(struct dc_context *ctx)
 {
 	uint32_t addr;
@@ -196,6 +199,7 @@ static void dce110_init_pte(struct dc_context *ctx)
 		dm_write_reg(ctx, addr, value);
 	}
 }
+#endif
 /**************************************************************************/
 
 static void enable_display_pipe_clock_gating(
@@ -207,6 +211,7 @@ static void enable_display_pipe_clock_gating(
 	/*TODO*/
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static bool dce110_enable_display_power_gating(
 	struct dc *dc,
 	uint8_t controller_id,
@@ -631,6 +636,8 @@ dce110_set_output_transfer_func(struct set_output_transfer_func_params *params)
 	return true;
 }
 
+#endif
+
 void dce110_update_info_frame(struct pipe_ctx *pipe_ctx)
 {
 	bool is_hdmi_tmds;
@@ -698,6 +705,7 @@ dce110_external_encoder_control(enum bp_external_encoder_control_action action,
 		DC_LOG_ERROR("Failed to execute external encoder action: 0x%x\n", action);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static void
 dce110_prepare_ddc(struct dc_link *link)
 {
@@ -717,6 +725,8 @@ dce110_dac_load_detect(struct dc_link *link)
 	return bp_result == BP_RESULT_OK;
 }
 
+#endif
+
 void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 {
 	enum dc_lane_count lane_count =
@@ -1595,6 +1605,7 @@ void build_audio_output(
 	}
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static void program_scaler(const struct dc *dc,
 		const struct pipe_ctx *pipe_ctx)
 {
@@ -1700,6 +1711,8 @@ static enum dc_status dce110_enable_stream_timing(
 	return DC_OK;
 }
 
+#endif
+
 enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context,
@@ -2284,6 +2297,7 @@ void dce110_set_safe_displaymarks(
  * Public functions
  ******************************************************************************/
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static void set_drr(struct pipe_ctx **pipe_ctx,
 		int num_pipes, struct dc_crtc_timing_adjust adjust)
 {
@@ -2358,6 +2372,8 @@ static void set_static_screen_control(struct pipe_ctx **pipe_ctx,
 					triggers, params->num_frames);
 }
 
+#endif
+
 /*
  *  Check if FBC can be enabled
  */
@@ -2450,6 +2466,7 @@ void enable_fbc(
 	}
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static void dce110_reset_hw_ctx_wrap(
 		struct dc *dc,
 		struct dc_state *context)
@@ -2522,6 +2539,8 @@ static void dce110_reset_hw_ctx_wrap(
 	}
 }
 
+#endif
+
 static void dce110_setup_audio_dto(
 		struct dc *dc,
 		struct dc_state *context)
@@ -2764,6 +2783,7 @@ enum dc_status dce110_apply_ctx_to_hw(
 /*******************************************************************************
  * Front End programming
  ******************************************************************************/
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static void set_default_colors(struct pipe_ctx *pipe_ctx)
 {
 	struct default_adjustment default_adjust = { 0 };
@@ -2893,12 +2913,15 @@ static void dce110_update_pending_status(struct pipe_ctx *pipe_ctx)
 	}
 }
 
+#endif
+
 void dce110_power_down(struct dc *dc)
 {
 	power_down_all_hw_blocks(dc);
 	disable_vga_and_power_gate_all_controllers(dc);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static bool wait_for_reset_trigger_to_occur(
 	struct dc_context *dc_ctx,
 	struct timing_generator *tg)
@@ -3105,6 +3128,8 @@ static void dce110_init_hw(struct dc *dc)
 }
 
 
+#endif
+
 void dce110_prepare_bandwidth(
 		struct dc *dc,
 		struct dc_state *context)
@@ -3134,6 +3159,7 @@ void dce110_optimize_bandwidth(
 				true);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static void dce110_program_front_end_for_pipe(
 		struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
@@ -3411,6 +3437,8 @@ static void dce110_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
 				pipe_ctx->plane_res.xfm, attributes);
 }
 
+#endif
+
 bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	struct set_backlight_level_params *backlight_level_params)
 {
@@ -3514,6 +3542,7 @@ void dce110_enable_tmds_link_output(struct dc_link *link,
 				link->ddc_hw_inst, false);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static void dce110_enable_analog_link_output(
 		struct dc_link *link,
 		uint32_t pix_clk_100hz)
@@ -3523,6 +3552,8 @@ static void dce110_enable_analog_link_output(
 			pix_clk_100hz);
 }
 
+#endif
+
 void dce110_enable_dp_link_output(
 		struct dc_link *link,
 		const struct link_resource *link_res,
@@ -3622,6 +3653,7 @@ void dce110_disable_link_output(struct dc_link *link,
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static const struct hw_sequencer_funcs dce110_funcs = {
 	.program_gamut_remap = program_gamut_remap,
 	.program_output_csc = program_output_csc,
@@ -3688,8 +3720,8 @@ static const struct hwseq_private_funcs dce110_private_funcs = {
 
 void dce110_hw_sequencer_construct(struct dc *dc)
 {
-	if (IS_ENABLED(CONFIG_DRM_AMD_DC_DCE)) {
-		dc->hwss = dce110_funcs;
-		dc->hwseq->funcs = dce110_private_funcs;
-	}
+	dc->hwss = dce110_funcs;
+	dc->hwseq->funcs = dce110_private_funcs;
 }
+
+#endif /* CONFIG_DRM_AMD_DC_DCE */
-- 
2.43.0

