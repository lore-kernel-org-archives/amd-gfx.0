Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F80C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 956D910EFE0;
	Wed,  2 Sep 2026 05:09:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E4TBacfJ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21EC10EFDF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1sue5GuUChKoGLBqdoDlv7LdEiKwQxhugk5McpjEwS/SGhztQIrx8nfOO7PRNOeRCEmG9KAvIlAPwHDk0sNuYD6tJxeWCJDGSiOYEzvHUdRs4A/GUW5CW5fM2HC/oeYJn3BBaYWsBVmAwU7G9556bcFxgPGW40AT4VgEndD2QpdZKO1oJqI2EBqcl3Q7dxwz3hRmSoskzgeNiNLffpB1/E7PdCwGt81X2eM67y4Waq4fui/su5blG2Ku36mR22AsPVU4ilQzcAbj3Y1G5q19nM5hejZVpyVIHlRTdsLUkhFVYdFUPf0n6EMGCrKdujgy4yDA6NEBHatJ8kb/wZWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKcRDurohW5X5lZVTWCyAKlkPhyZJVIBNJ3P3hrFQmM=;
 b=moJyAbNbKOrnv5yE4WbMsKT8BhqHpKUXaZLzC8yXIHUvM8CwbVSBc8CTv6XTfOJgKn3LdypuTJ3lqXRf/B4rZPnWvYU6ZimYXvvbu/9jWeUvElpIlo2rM+0+rX9FdplTtMNH4rrcfjY1rWlc8JSRW6AuRzM/HELVMi6zR1wqs6e7+fRM0rMsEq4OPZZusC4RLPKZ8f0BATL0baYyQ2d/nRnAxzuZBhpeqSkc05sStki7D8Nfgx5UvXLxI2Fs4+1GjZR3ggCcRPYTzSpPwSUGfOfFusSGp3c6YC8XhNxF3ME1QxFH0I7vai17DpKaiD+vzxabGYqgxwHw3hJTFV19cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKcRDurohW5X5lZVTWCyAKlkPhyZJVIBNJ3P3hrFQmM=;
 b=E4TBacfJEtXaUmQ5tIrZK6zEdxZhp8lXaM3aQw+xY4IbkJkmpLoscL8v3l46AWvl4NIgEHeyGM4TEOrAXJhjvTPz/LYBBytI81aQsEPjmsOhIfhHTi6qRK57wMfQvdwyilWoK18mAckbhfWzxvdcjVH2vO1/+iQAV/k1axecYTI=
Received: from SJ0PR03CA0180.namprd03.prod.outlook.com (2603:10b6:a03:338::35)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:09:29 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::36) by SJ0PR03CA0180.outlook.office365.com
 (2603:10b6:a03:338::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 05:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:09:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:09:28 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:09:20 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Austin Zheng
 <austin.zheng@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 34/40] drm/amd/display: Route DCN6 mode support calcs through
 function pointer table
Date: Wed, 2 Sep 2026 12:58:56 +0800
Message-ID: <20260902050411.3473916-35-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a4cf76-c9d2-46c1-5322-08df08b05de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|3023799007|10067099003|5023799004|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sDN71UKIiACokrLfMueVNctJSFxIwSWP8AvUe5f4dKBGFNIc3HwDHPpNi1NP7+YjmlWEp2pVu9i/ukWop3+ck0hOt5I0K58vHnvvmkFr4bDmZNktKsq4ERIWhxPV5DNf6TvwLzZwpXejjb1+K1kXbXFGke/ueLJXleB6sHiajUHv1wwWmZX3MEE1aHZxjxX0d1myDbn/jJ33uUJbcR67bDInRLt4RsrF5zqekzLVL8wN6aWOLvoGXDBw82/huR5ITSzjJ5NIAggOgh1qRxn+bOBHmwcG4nH5wL5ZiJg0wyyw4CrA3j9Mcl7eodfipZVXozXPxtoGr/j01QvZSkiocNl/Ta/jC/4WwCKXGBL7HX/NwI7rjlcmYRdk5MdL4Kh6goJq9QplTarTyEVkTD+v/KCJ2Jd9ItBu/5CB9eQ9EhG3n3t7/AhUG3/VqBxM3mK3ylLaTyNgNJ+PaudpFwv/Y7fc1XhxetjC2Dv9/bDkmWBWlDvW2rktwF5YQaZw+bnwzWnBp/0+fJZQUJE8OQClUR/q4pW2fJrEYU6oRluOnHLj41wX9fiaShPqqgjXs4gCgIGOlTuJK3kVxik4byLfN0W8NPCvp2Ww36sKJ2KOOErImpQWNHVwToHXXQtN1FJWAj7e+qh/VenaG2uXSe042k2g0Tg9kKsH6DZN2lYlHNpYDRKn7BP+QddheTI3wacpWRJFfDG9du24rUyQ2jms5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(3023799007)(10067099003)(5023799004)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7nOeTB78r9r9LPEcKZllLgwqsgjdgmudSbFhxA8VYwU7opJpVTW3TIItr1YdUc9IF663YPmX0jTzfB61fn9k/fkbJ6I3AK6QKEKuOrP+0MrJluAuaDvi1iZwhX/BnyOoTPjsMrlURJo914eM23moT7bhuu0KP9YU7vfZ0RZp3FTpA2Yw8Mb8lqYPPGD4XMwcuvWvR547MBP+/uia/5BERQgu+a8uHO2QmofsOK7fsfBmKyxRii9OlL78ZdZblELXUt8jm3lzeAjSCQQPDqYzBOrxQbNwD2JRmN1sm9/MJMnFMWvxXXYrkw9tX3H9xbbG4a8fctY3kcK4BQZGLAjIQzSqO0Jp+HtuCsZFtMR2RNJsMCOYpjDUNhhjdZtjCo9LZQ1cWAksIF1OHS/ofjZmM7pLMgeyNt9tnNS/9x8sOnCRzLqNbp4Rzpnp9pY3LQ/i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:09:29.1832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a4cf76-c9d2-46c1-5322-08df08b05de5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
dml2_core_dcn6_funcs_mode_support.c called DCN5 and DCN6 calcs
functions directly by name, coupling the mode support flow to
specific generations. Routing through the calcs table lets a
future core generation reuse this flow without editing it.

[How]
Add a static get_calcs(ctx) helper returning ctx->calcs->dcn6.
Replace every direct dcn5_*/dcn6_* calcs call with
get_calcs(ctx)->slot(...). Assign calc_ms_ctx->calcs from
core->calcs when the context is built. Drop the now-unused
dml2_core_dcn5_calcs_dchub.h, dml2_core_dcn5_calcs_display_pipe.h,
and dml2_core_dcn6_calcs_dchub.h includes in favor of
dml2_core_dcn6_calcs.h.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dml2_core_dcn6_funcs_mode_support.c       | 115 ++++++++++--------
 1 file changed, 65 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index 166022bb3096..abb1c90cfad2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -3,11 +3,14 @@
 // Copyright 2025 Advanced Micro Devices, Inc.
 #include "dml2_core_dcn6_funcs_mode_support.h"
 #include "dml2_core_utils.h"
-#include "dml2_core_dcn5_calcs_dchub.h"
-#include "dml2_core_dcn5_calcs_display_pipe.h"
-#include "dml2_core_dcn6_calcs_dchub.h"
+#include "dml2_core_dcn6_calcs.h"
 #include "dml_top_types.h"
 
+static const struct dml2_core_dcn6_calcs *get_calcs(const struct dml2_core_calculate_ms_context *ctx)
+{
+	return ctx->calcs->dcn6;
+}
+
 static void dcn6_ms_check_input_sanity(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
@@ -66,7 +69,7 @@ static void dcn6_ms_calculate_max_det_and_min_compressed_buffer_size(
 	struct dml2_core_internal_mode_support *outputs = states;
 
 	DML_LOG_FUNC_ENTER();
-	dcn5_calculate_max_det_and_min_compressed_buffer_size(
+	get_calcs(ctx)->calculate_max_det_and_min_compressed_buffer_size(
 			ip->config_return_buffer_size_in_kbytes,
 			ip->config_return_buffer_segment_size_in_kbytes,
 			ip->rob_buffer_size_kbytes,
@@ -99,7 +102,8 @@ static void dcn6_ms_calculate_effective_pixel_clock(
 	 * This function should probably be removed since ptoi is never true, so the function is a noop; not really
 	 * obvious if the comment means DML2.1 doesn't support interlace today.
 	 */
-	dcn5_adjust_pixel_clock_for_progressive_to_interlace_unit(display_cfg, ip->ptoi_supported, outputs->PixelClockBackEnd);
+	get_calcs(ctx)->adjust_pixel_clock_for_progressive_to_interlace_unit(display_cfg, ip->ptoi_supported,
+			outputs->PixelClockBackEnd);
 
 	DML_LOG_DEBUG_ARRAY_DOUBLE(outputs->PixelClockBackEnd, display_cfg->num_planes);
 	DML_LOG_FUNC_EXIT();
@@ -197,7 +201,7 @@ static void dcn6_ms_calculate_byte_per_pixel_and_block_sizes(
 	DML_LOG_FUNC_ENTER();
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		plane = &display_cfg->plane_descriptors[k];
-		dcn5_calculate_byte_per_pixel_and_block_sizes(
+		get_calcs(ctx)->calculate_byte_per_pixel_and_block_sizes(
 				plane->pixel_format,
 				plane->surface.tiling,
 				plane->surface.plane0.pitch,
@@ -460,7 +464,7 @@ static void dcn6_ms_calculate_single_pipe_dppclk_and_pscl_factor(
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		plane = &display_cfg->plane_descriptors[k];
 		stream = &display_cfg->stream_descriptors[plane->stream_index];
-		dcn5_calculate_single_pipe_dppclk_and_scl_throughput(
+		get_calcs(ctx)->calculate_single_pipe_dppclk_and_scl_throughput(
 				plane->composition.scaler_info.plane0.h_ratio,
 				plane->composition.scaler_info.plane1.h_ratio,
 				plane->composition.scaler_info.plane0.v_ratio,
@@ -747,7 +751,7 @@ static void dcn6_ms_calculate_swath_and_det_configuration_for_single_dpp(
 	p->ViewportSizeSupportPerSurface = outputs->SingleDPPViewportSizeSupportPerSurface;
 	p->ViewportSizeSupport = &dummies->dummy_boolean[1];
 	// This calls is just to find out if there is enough DET space to support full vp in 1 pipe.
-	dcn5_calculate_swath_and_det_configuration(ctx->func_params, p);
+	get_calcs(ctx)->calculate_swath_and_det_configuration(ctx->func_params, p);
 
 	DML_LOG_DEBUG_ARRAY_BOOL(outputs->SingleDPPViewportSizeSupportPerSurface, display_cfg->num_planes);
 	DML_LOG_FUNC_EXIT();
@@ -809,7 +813,7 @@ static void dcn6_ms_calculate_output_link(
 	DML_LOG_FUNC_ENTER();
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		stream = &display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index];
-		dcn5_calculate_output_link(
+		get_calcs(ctx)->calculate_output_link(
 				ctx->func_params,
 				((double) soc_bb->max_phyclk_khz / 1000),
 				((double) soc_bb->max_phyclk_d18_khz / 1000),
@@ -869,7 +873,7 @@ static void dcn6_ms_calculate_odm_mode(
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		stream = &display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index];
 
-		dcn5_calculate_odm_mode(
+		get_calcs(ctx)->calculate_odm_mode(
 				ip->maximum_pixels_per_line_per_dsc_unit,
 				stream->timing.h_active,
 				stream->output.output_format,
@@ -1121,7 +1125,7 @@ static void dcn6_ms_calculate_dispclk_and_dppclk_required(
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		stream = &display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index];
 		for (j = 0; j < stream->writeback.active_writebacks_per_stream; ++j) {
-			writeback_required_dispclk = dcn5_calculate_write_back_dispclk(
+			writeback_required_dispclk = get_calcs(ctx)->calculate_write_back_dispclk(
 				stream->writeback.writeback_stream[j].pixel_format,
 				((double)stream->timing.pixel_clock_khz / 1000),
 				inputs->ODMMode[k],
@@ -1401,7 +1405,7 @@ static void dcn6_ms_calculate_dtbclk_required(
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		stream = &display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index];
 		if (stream->output.output_encoder == dml2_hdmifrl) {
-			outputs->RequiredDTBCLK[k] = dcn5_calculate_required_dtbclk(
+			outputs->RequiredDTBCLK[k] = get_calcs(ctx)->calculate_required_dtbclk(
 				inputs->RequiresDSC[k],
 				inputs->PixelClockBackEnd[k],
 				stream->output.output_format,
@@ -1598,7 +1602,7 @@ static void dcn6_ms_calculate_dsc_delay(
 	/*DSC Delay per state*/
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		stream = &display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index];
-		outputs->DSCDelay[k] = dcn5_calculate_dsc_delay_requirement(
+		outputs->DSCDelay[k] = get_calcs(ctx)->calculate_dsc_delay_requirement(
 				inputs->RequiresDSC[k],
 				inputs->ODMMode[k],
 				ip->maximum_dsc_bits_per_component,
@@ -1685,7 +1689,7 @@ static void dcn6_ms_calculate_swath_and_det_configuration(
 	p->CompressedBufferSizeInkByte = &outputs->CompressedBufferSizeInkByte;
 	p->ViewportSizeSupportPerSurface = dummies->dummy_boolean_array[0];
 	p->ViewportSizeSupport = &outputs->support.ViewportSizeSupport;
-	dcn5_calculate_swath_and_det_configuration(ctx->func_params, p);
+	get_calcs(ctx)->calculate_swath_and_det_configuration(ctx->func_params, p);
 
 	DML_LOG_DEBUG_ARRAY_UINT(outputs->SwathWidthY, display_cfg->num_planes);
 	DML_LOG_DEBUG_UINT(outputs->CompressedBufferSizeInkByte);
@@ -1860,7 +1864,7 @@ static void dcn6_ms_calculate_vm_row_and_swath_and_calculate_dcc_meta_cache_requ
 	p->meta_row_width_chroma = outputs->meta_row_width_chroma;
 	p->meta_row_height_chroma = outputs->meta_row_height_chroma;
 	p->meta_pte_bytes_per_frame_ub_c = outputs->meta_pte_bytes_per_frame_ub_c;
-	dcn5_calculate_vm_row_and_swath(ctx->func_params, p);
+	get_calcs(ctx)->calculate_vm_row_and_swath(ctx->func_params, p);
 
 	DML_LOG_DEBUG_ARRAY_BOOL(outputs->PTEBufferSizeNotExceeded, display_cfg->num_planes);
 	DML_LOG_DEBUG_ARRAY_UINT(outputs->dpte_row_width_luma_ub, display_cfg->num_planes);
@@ -2056,11 +2060,11 @@ static void dcn6_ms_calculate_vactive_pstate_requirements(
 		p->bytes_required_l = outputs->pstate_bytes_required_l[pstate_type];
 		p->bytes_required_c = outputs->pstate_bytes_required_c[pstate_type];
 
-		dcn5_calculate_bytes_to_fetch_required_to_hide_latency(p);
+		get_calcs(ctx)->calculate_bytes_to_fetch_required_to_hide_latency(p);
 	}
 
 	/* Excess VActive bandwidth required to fill DET */
-	dcn6_calculate_excess_vactive_bandwidth_required(display_cfg,
+	get_calcs(ctx)->calculate_excess_vactive_bandwidth_required(display_cfg,
 			outputs->pstate_bytes_required_l,
 			outputs->pstate_bytes_required_c,
 
@@ -2104,7 +2108,7 @@ static void dcn6_ms_calculate_det_buffer_time_value_urgent_burst_factor_and_urge
 		stream = &display_cfg->stream_descriptors[plane->stream_index];
 		line_time_us = stream->timing.h_total / ((double) stream->timing.pixel_clock_khz / 1000);
 		cursor_not_enough_urgent_latency_hiding = 0;
-		dcn5_calculate_cursor_req_attributes(
+		get_calcs(ctx)->calculate_cursor_req_attributes(
 				plane->cursor.cursor_width,
 				plane->cursor.cursor_bpp,
 				// output
@@ -2112,7 +2116,7 @@ static void dcn6_ms_calculate_det_buffer_time_value_urgent_burst_factor_and_urge
 				&outputs->cursor_bytes_per_line[k],
 				&outputs->cursor_bytes_per_chunk[k],
 				&cursor_bytes);
-		dcn5_calculate_cursor_urgent_burst_factor(
+		get_calcs(ctx)->calculate_cursor_urgent_burst_factor(
 				ip->cursor_buffer_size,
 				plane->cursor.cursor_width,
 				outputs->cursor_bytes_per_chunk[k],
@@ -2128,7 +2132,7 @@ static void dcn6_ms_calculate_det_buffer_time_value_urgent_burst_factor_and_urge
 				plane->composition.scaler_info.plane0.v_ratio);
 		DML_LOG_VERBOSE("DML::%s: k=%d, VRatioChroma=%f\n", __func__, k,
 				plane->composition.scaler_info.plane1.v_ratio);
-		dcn5_calculate_urgent_burst_factor(
+		get_calcs(ctx)->calculate_urgent_burst_factor(
 				&display_cfg->plane_descriptors[k],
 				inputs->swath_width_luma_ub[k],
 				inputs->swath_width_chroma_ub[k],
@@ -2176,7 +2180,7 @@ static void dcn6_ms_calculate_min_dcfclk_deepsleep_clock(
 	double raw_dcfclk_deepsleep_mhz = 0;
 
 	DML_LOG_FUNC_ENTER();
-	dcn5_calculate_dcfclk_deep_sleep(
+	get_calcs(ctx)->calculate_dcfclk_deep_sleep(
 			display_cfg,
 			display_cfg->num_planes,
 			inputs->BytePerPixelY,
@@ -2217,7 +2221,7 @@ static void dcn6_ms_calculate_writeback_delay(
 		for (j = 0; j < stream->writeback.active_writebacks_per_stream; j++) {
 			outputs->WritebackDelayTime[k] = math_max2(outputs->WritebackDelayTime[k],
 					soc_bb->writeback_base_latency_us
-					+ dcn5_calculate_write_back_delay(
+					+ get_calcs(ctx)->calculate_write_back_delay(
 							stream->writeback.writeback_stream[j].pixel_format,
 							stream->writeback.writeback_stream[j].h_ratio,
 							stream->writeback.writeback_stream[j].v_ratio,
@@ -2315,7 +2319,7 @@ static void dcn6_ms_calculate_alternate_params(const struct dml2_core_calculate_
 	p->max_prefetch_in_lines = outputs->max_prefetch_in_lines;
 	p->lsdma_bw_req_for_alt_kbps = &outputs->lsdma_bw_req_for_alt_kbps;
 
-	dcn6_calculate_alternate_params(p);
+	get_calcs(ctx)->calculate_alternate_params(p);
 
 	DML_LOG_DEBUG_UINT(outputs->svp0_max_bytes);
 	DML_LOG_DEBUG_UINT(outputs->svp1_max_bytes);
@@ -2359,7 +2363,7 @@ static void dcn6_ms_calculate_alternate_svp_lines(const struct dml2_core_calcula
 	p->svp1_dst_lines = outputs->svp1_dst_lines;
 	p->svp_req_limit = outputs->svp_req_limit;
 
-	dcn6_calculate_alternate_svp_lines(p);
+	get_calcs(ctx)->calculate_alternate_svp_lines(p);
 
 	DML_LOG_DEBUG_ARRAY_UINT(outputs->svp0_dst_lines, ctx->display_cfg->num_streams);
 	DML_LOG_DEBUG_ARRAY_UINT(outputs->svp1_dst_lines, ctx->display_cfg->num_streams);
@@ -2383,7 +2387,7 @@ static void dcn6_ms_calculate_max_vstartup(
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		stream_index = display_cfg->plane_descriptors[k].stream_index;
 		stream = &display_cfg->stream_descriptors[stream_index];
-		outputs->MaximumVStartup[k] = dcn6_calculate_max_vstartup(
+		outputs->MaximumVStartup[k] = get_calcs(ctx)->calculate_max_vstartup(
 				ip->ptoi_supported,
 				ip->vblank_nom_default_us,
 				&stream->timing,
@@ -2531,7 +2535,7 @@ static void dcn6_ms_calculate_mcache_setting(
 			p->mall_comb_mcache_l = &outputs->mall_comb_mcache_l[k];
 			p->mall_comb_mcache_c = &outputs->mall_comb_mcache_c[k];
 			p->lc_comb_mcache = &outputs->lc_comb_mcache[k];
-			dcn5_calculate_mcache_setting(ctx->func_params, p);
+			get_calcs(ctx)->calculate_mcache_setting(ctx->func_params, p);
 		}
 	}
 
@@ -2567,7 +2571,7 @@ static void dcn6_ms_calculate_avg_bandwidth_and_dcfclk_lb_required(
 
 	DML_LOG_FUNC_ENTER();
 	// Average BW support check
-	dcn5_calculate_avg_bandwidth_required(
+	get_calcs(ctx)->calculate_avg_bandwidth_required(
 			*outputs->support.avg_bandwidth_required,
 			// input
 			display_cfg->num_planes,
@@ -2634,7 +2638,7 @@ static void dcn6_ms_calculate_hostvm_inefficiency_factor(
 	struct dml2_core_internal_mode_support *outputs = states;
 
 	DML_LOG_FUNC_ENTER();
-	dcn5_calculate_hostvm_inefficiency_factor(
+	get_calcs(ctx)->calculate_hostvm_inefficiency_factor(
 			&outputs->HostVMInefficiencyFactor,
 			&outputs->HostVMInefficiencyFactorPrefetch,
 			display_cfg->gpuvm_enable,
@@ -2687,7 +2691,7 @@ static void dcn6_ms_calculate_3dlut_settings(
 		p->tdlut_opt_time = &outputs->tdlut_opt_time[k];
 		p->tdlut_drain_time = &outputs->tdlut_drain_time[k];
 		p->tdlut_bytes_per_group = &outputs->tdlut_bytes_per_group[k];
-		dcn5_calculate_tdlut_setting(ctx->func_params, p);
+		get_calcs(ctx)->calculate_tdlut_setting(ctx->func_params, p);
 	}
 
 	DML_LOG_DEBUG_ARRAY_UINT(outputs->tdlut_bytes_per_group, display_cfg->num_planes);
@@ -2710,7 +2714,7 @@ static void dcn6_ms_calculate_urgent_latency(
 	struct dml2_core_internal_mode_support *outputs = states;
 
 	DML_LOG_FUNC_ENTER();
-	dcn5_calculate_extra_latency(
+	get_calcs(ctx)->calculate_extra_latency(
 			display_cfg,
 			ip->rob_buffer_size_kbytes,
 			0,
@@ -2770,7 +2774,7 @@ static void dcn6_ms_calculate_prefetch_schedule(
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		plane = &display_cfg->plane_descriptors[k];
 		stream = &display_cfg->stream_descriptors[plane->stream_index];
-		outputs->TWait[k] = dcn5_calculate_t_wait(
+		outputs->TWait[k] = get_calcs(ctx)->calculate_t_wait(
 				plane->overrides.reserved_vblank_time_ns,
 				inputs->UrgLatency,
 				inputs->TripToMemory,
@@ -2883,7 +2887,7 @@ static void dcn6_ms_calculate_prefetch_schedule(
 		p->Tpre_rounded = &Tpre_rounded;
 		p->Tpre_oto = &Tpre_oto;
 
-		outputs->NoTimeForPrefetch[k] = dcn5_calculate_prefetch_schedule(ctx->func_params, p);
+		outputs->NoTimeForPrefetch[k] = get_calcs(ctx)->calculate_prefetch_schedule(ctx->func_params, p);
 		DML_LOG_VERBOSE("DML::%s: k=%d, dst_y_per_vm_vblank = %f\n", __func__, k, *p->dst_y_per_vm_vblank);
 		DML_LOG_VERBOSE("DML::%s: k=%d, dst_y_per_row_vblank = %f\n", __func__, k, *p->dst_y_per_row_vblank);
 		outputs->VStartupMin[k] = inputs->MaxVStartupLines[k];
@@ -3020,7 +3024,7 @@ static void dcn6_ms_calculate_urgent_burst_factor_for_prefetch(
 		DML_LOG_VERBOSE("DML::%s: k=%d, Calling CalculateUrgentBurstFactor (for prefetch)\n", __func__, k);
 		DML_LOG_VERBOSE("DML::%s: k=%d, VRatioPreY=%f\n", __func__, k, inputs->VRatioPreY[k]);
 		DML_LOG_VERBOSE("DML::%s: k=%d, VRatioPreC=%f\n", __func__, k, inputs->VRatioPreC[k]);
-		dcn5_calculate_urgent_burst_factor(
+		get_calcs(ctx)->calculate_urgent_burst_factor(
 				&display_cfg->plane_descriptors[k],
 				inputs->swath_width_luma_ub[k],
 				inputs->swath_width_chroma_ub[k],
@@ -3092,7 +3096,7 @@ static void dcn6_ms_calculate_peak_bandwidth_required(
 	p->urgent_burst_factor_prefetch_l = inputs->UrgentBurstFactorLumaPre;
 	p->urgent_burst_factor_prefetch_c = inputs->UrgentBurstFactorChromaPre;
 	p->urgent_burst_factor_prefetch_cursor = inputs->UrgentBurstFactorCursorPre;
-	dcn5_calculate_peak_bandwidth_required(ctx->func_params, p);
+	get_calcs(ctx)->calculate_peak_bandwidth_required(ctx->func_params, p);
 
 	p->urg_vactive_bandwidth_required = dummies->dummy_bw;
 	p->urg_bandwidth_required = outputs->support.urg_bandwidth_required_flip;
@@ -3100,7 +3104,7 @@ static void dcn6_ms_calculate_peak_bandwidth_required(
 	p->surface_avg_vactive_required_bw = dummies->surface_dummy_bw;
 	p->surface_peak_required_bw = outputs->surface_peak_required_bw;
 	p->inc_flip_bw = 1;
-	dcn5_calculate_peak_bandwidth_required(ctx->func_params, p);
+	get_calcs(ctx)->calculate_peak_bandwidth_required(ctx->func_params, p);
 
 	DML_LOG_DEBUG_2D_ARRAY_DOUBLE(outputs->support.urg_bandwidth_required,
 				dml2_core_internal_soc_state_max, dml2_core_internal_bw_max);
@@ -3157,7 +3161,7 @@ static void dcn6_ms_calculate_flip_schedule(
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		plane = &display_cfg->plane_descriptors[k];
 		stream = &display_cfg->stream_descriptors[plane->stream_index];
-		dcn6_calculate_flip_schedule(
+		get_calcs(ctx)->calculate_flip_schedule(
 				ctx->func_params,
 				display_cfg->plane_descriptors[k].immediate_flip,
 				display_cfg->hostvm_enable,
@@ -3299,7 +3303,7 @@ static void dcn6_ms_calculate_vactive_det_fill_latency(
 	DML_LOG_FUNC_ENTER();
 	/* VActive fill time calculations (informative) */
 	for (pstate_type = 0; pstate_type < dml2_pstate_type_count; pstate_type++) {
-		dcn5_calculate_vactive_det_fill_latency(
+		get_calcs(ctx)->calculate_vactive_det_fill_latency(
 				display_cfg,
 				display_cfg->num_planes,
 				inputs->pstate_bytes_required_l[pstate_type],
@@ -3775,7 +3779,7 @@ static void dcn6_ms_calculate_watermarks(
 	p->temp_read_or_ppt_support = outputs->support.temp_read_or_ppt_support;
 	p->VActiveLatencyHidingMargin = outputs->VActiveLatencyHidingMargin;
 	p->VActiveLatencyHidingUs = outputs->VActiveLatencyHidingUs;
-	dcn6_calculate_watermarks_and_dram_speed_change_support(ctx->func_params, p);
+	get_calcs(ctx)->calculate_watermarks_and_dram_speed_change_support(ctx->func_params, p);
 
 	DML_LOG_DEBUG_BOOL(outputs->support.global_dram_clock_change_supported);
 	DML_LOG_DEBUG_BOOL(outputs->support.global_fclk_change_supported);
@@ -3833,7 +3837,7 @@ static void dcn6_ms_calculate_pstate_schedule_windows(
 
 	/* fclk pstate */
 	if (inputs->support.global_fclk_change_supported)
-		dcn6_calculate_pstate_schedule_windows(
+		get_calcs(ctx)->calculate_pstate_schedule_windows(
 			display_cfg->num_planes,
 			v_blank_start,
 			v_blank_end,
@@ -3848,7 +3852,7 @@ static void dcn6_ms_calculate_pstate_schedule_windows(
 
 	/* ppt pstate */
 	if (inputs->support.global_temp_read_or_ppt_supported)
-		dcn6_calculate_pstate_schedule_windows(
+		get_calcs(ctx)->calculate_pstate_schedule_windows(
 			display_cfg->num_planes,
 			v_blank_start,
 			v_blank_end,
@@ -3865,7 +3869,7 @@ static void dcn6_ms_calculate_pstate_schedule_windows(
 
 	/* temp read pstate */
 	if (inputs->support.global_temp_read_or_ppt_supported)
-		dcn6_calculate_pstate_schedule_windows(
+		get_calcs(ctx)->calculate_pstate_schedule_windows(
 			display_cfg->num_planes,
 			v_blank_start,
 			v_blank_end,
@@ -3920,7 +3924,7 @@ static bool dcn6_ms_check_pstate_schedule_admissibility(
 	/* fclk pstate */
 	outputs->support.fclk_pstate_schedule_admissible = false;
 	if (inputs->support.global_fclk_change_supported)
-		dcn6_calculate_pstate_schedule_admissibility(
+		get_calcs(ctx)->calculate_pstate_schedule_admissibility(
 			display_cfg->num_planes,
 			ip->fams2_max_allow_delay_us,
 			ip->fams2_min_allow_width_us,
@@ -3940,7 +3944,7 @@ static bool dcn6_ms_check_pstate_schedule_admissibility(
 	/* ppt pstate */
 	outputs->support.ppt_pstate_schedule_admissible = false;
 	if (inputs->support.global_temp_read_or_ppt_supported)
-		dcn6_calculate_pstate_schedule_admissibility(
+		get_calcs(ctx)->calculate_pstate_schedule_admissibility(
 			display_cfg->num_planes,
 			ip->ppt_max_allow_delay_us,
 			ip->fams2_min_allow_width_us,
@@ -3960,7 +3964,7 @@ static bool dcn6_ms_check_pstate_schedule_admissibility(
 	/* temp read pstate */
 	outputs->support.temp_read_pstate_schedule_admissible = false;
 	if (inputs->support.global_temp_read_or_ppt_supported)
-		dcn6_calculate_pstate_schedule_admissibility(
+		get_calcs(ctx)->calculate_pstate_schedule_admissibility(
 			display_cfg->num_planes,
 			ip->temp_read_max_allow_delay_us,
 			ip->fams2_min_allow_width_us,
@@ -4229,6 +4233,21 @@ static enum dml2_status dcn6_mode_support(
 	return status;
 }
 
+static void dcn6_ms_build_calculate_ms_context(struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_instance *core,
+		const struct dml2_display_solution *solution)
+{
+	struct dml2_core_internal_display_mode_lib *mode_lib = &core->clean_me_up.mode_lib;
+
+	ctx->display_cfg = &solution->dispcfg;
+	ctx->ip = &mode_lib->ip;
+	ctx->soc_bb = core->utm_soc_bb;
+	ctx->clock_adjuster = core->clock_adjuster;
+	ctx->dummies = &mode_lib->scratch.dml_core_mode_support_locals;
+	ctx->func_params = &mode_lib->scratch;
+	ctx->calcs = &core->calcs;
+}
+
 enum dml2_status dml2_core_dcn6_funcs_validate_solution(struct dml2_core_instance *core,
 		const struct dml2_display_solution *solution,
 		struct dml2_validation_result *result)
@@ -4241,6 +4260,8 @@ enum dml2_status dml2_core_dcn6_funcs_validate_solution(struct dml2_core_instanc
 	unsigned int i;
 
 	DML_LOG_COMP_IF_ENTER();
+	dcn6_ms_build_calculate_ms_context(calc_ms_ctx, core, solution);
+
 	if (solution->unvalidated_change.bits.mpc_combine_overrides
 			|| solution->unvalidated_change.bits.odm_combine_overrides
 			|| solution->unvalidated_change.bits.reserved_vblank_time
@@ -4253,12 +4274,6 @@ enum dml2_status dml2_core_dcn6_funcs_validate_solution(struct dml2_core_instanc
 		result->is_prefetch_valid = false;
 
 	if (!result->is_mode_support_valid) {
-		calc_ms_ctx->display_cfg = &solution->dispcfg;
-		calc_ms_ctx->ip = &core->clean_me_up.mode_lib.ip;
-		calc_ms_ctx->soc_bb = core->utm_soc_bb;
-		calc_ms_ctx->clock_adjuster = core->clock_adjuster;
-		calc_ms_ctx->dummies = &mode_lib->scratch.dml_core_mode_support_locals;
-		calc_ms_ctx->func_params = &mode_lib->scratch;
 		memset(calc_ms_ctx->func_params, 0, sizeof(struct dml2_core_internal_scratch));
 		memset(&mode_lib->ms, 0, sizeof(struct dml2_core_internal_mode_support));
 
-- 
2.43.0

