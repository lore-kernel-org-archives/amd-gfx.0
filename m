Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D84C369B9
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC5F10E7C5;
	Tue, 15 Apr 2025 14:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WavNC8q8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 230AB10E7C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qai9oxv2scyPkrOmprGo25iI24JJAAFNWCt7JRGFQC/qVyANBpHeiOtcoOQrL7ZHQ5rsyvj0vYwa8MARod4dV5JEVZxzdJiyTPBoAEnDHlfTeR6cnsMQIVZOuTRKx8sGP50rfJgzz40iJkw+/ft4kNF+YknMz7EgWJfjXmzwCGqVZ0re4uQ7O43e8pMA4EEjwAxAT6+WZcoioCKFen8/ia/GrcRuS1Kqw4Wus8dKJJKDNcA3U6mxaL37/A/0dgM4lpTlLR/RK5EJaCIjqwldaou9GoZ5eyKyBq+TRFcSRFeQPebleCoc4c7k3KDF9P7ucUnmcrcOSLOq+cv0cw1GsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPW7KdBtszPYbrLSGQjXrdifenVCf3gwuXSzdRUMEVU=;
 b=w6HigKUEMN8YWqSZ0WPIqxDDqwY/DEnOQ+OV+z1o3JdZufTdvVOo6c6fLJjvQfxKViOky4/2L2+PeSRGWTKkMv28aUVOcDib39STQKX4oDPjkFjDD7FayeO+eKN7XuNx1Ajf6WV4TdFbMBDylaw2aNMiICPrhNZb/foScccTspXc36LmhU1DhjP/zlwUbEES4DDk4jw5h5HJp8RVUNtJfbOFqlR/qWFZAObuxD+EJj2nYoISbSNkG/VWrYpifAbnNN5UZkXckMbdL/7dRSrXoP2+I5/lUhF9s0y41hqqtcYlMK+How2tdJU9s9xSSaHgPZ7msZWbP2AbfQIhKOR40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPW7KdBtszPYbrLSGQjXrdifenVCf3gwuXSzdRUMEVU=;
 b=WavNC8q88/bGKwdPJ7fsmkdQqD5yvjESHtRNb8+rYtc672HSM5ZL9uWoohBtIlMj6DGuucYBmq71hZCalDjZa+lS/RTfngxxB9ZEaGV4qKTuMkhSmtwVSIQlBmkZVY4RNx/A0n8N+YN6YZ1OJQHWdleI02WSZnPJqLcTDNfDpAs=
Received: from SA0PR11CA0166.namprd11.prod.outlook.com (2603:10b6:806:1bb::21)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 15 Apr
 2025 14:59:47 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::83) by SA0PR11CA0166.outlook.office365.com
 (2603:10b6:806:1bb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 14:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:47 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:44 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Yihan Zhu
 <Yihan.Zhu@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 09/22] drm/amd/display: DCN42 RMCM and MCM 3DLUT support
Date: Tue, 15 Apr 2025 10:58:55 -0400
Message-ID: <20250415145908.3790253-10-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c15ad0f-a48c-4377-1c91-08dd7c2e29f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vKkt/iIEfxcIiWKgN+bGQdUOTdQ5WDoSgqzn1D8Vv5MxPKkns3vs2wyR2r2u?=
 =?us-ascii?Q?jYlCFlXoC9x/xhD1YpI/NfzyVAQ1cO26AB0ITTM252wUJGtTMU4xn3YjuTx9?=
 =?us-ascii?Q?STFWZZs3eLVGg+BdjkjWnIgImbdo3uyjYxYzocFW28YYG9/sodRoK7RyrI9n?=
 =?us-ascii?Q?fpkFg4ra7mmJzBMKpXqoctDQol58m/2B1cBWJPNbTurS7/UhYCwcDmeVDxdd?=
 =?us-ascii?Q?rrgBgB3EK3XmrSk4oSRU+QvR8K6Z0eNhMAXM++Hd+OUPjF4jZ2fZvV1yinbt?=
 =?us-ascii?Q?Quv75JCfMSvSFOYaL0LiGSxTyw012YOZcPeWOWDM2NW9xtfO6u8ZrJGaNxV0?=
 =?us-ascii?Q?uUZZ/bNbieG7SFrOi6wajlxgEPaChPTWIIcVS9Iun3sMDnfQ2hD8/fc2lp+R?=
 =?us-ascii?Q?0l6guLkGkVbYBdgHkFPJf5nUVBscPrfNEk47DLQ8JHIhsQzNG5c5MvcqocsP?=
 =?us-ascii?Q?h9u5WgzOzCehNPuD+RAM+j6tEAtY5RwQ7NK0JbKkfXf3dGbAmWPyZBFon3ub?=
 =?us-ascii?Q?sl18TncdZgr0X5QffxLGnk0Ld8USXlL/XVNrSVDpNDz9exPmibqp8V5SNeoR?=
 =?us-ascii?Q?37fQ5do6sHqSbqCwhMQR5MRyfFDCf90jpaa8W5dM1nO1ep1YvAcySwDiwnMm?=
 =?us-ascii?Q?c4Ob4XwN7TFBXti/XM7mER9p8izGILCl76I8mzw/9LFqwncB4Ponyob0tWN3?=
 =?us-ascii?Q?ZP/bXuaElcxmtVXk+B2Xz/FWoATx4QaFQjCJwnNDGnWOkdBUssOmbouP3awE?=
 =?us-ascii?Q?rZonM7GP063jCN6yIgKgCEC+VIeGBzRdraDetouZTi74U6ZG0wjrVOTves+e?=
 =?us-ascii?Q?vr1M90aCFoofdRdiQm9aDSG+/iB+168LNMi8XPTjuYnH7Q3bB3xMI7RhaKsQ?=
 =?us-ascii?Q?YApcZWQWGj6b64jmhyXEH8UPFg6npP33pHvMxTyGU6M2QOpZCQh8P2msrXnp?=
 =?us-ascii?Q?VstSlmBuZ0ySq3k5KtUTONJGPpF8qG2FDzhvVCsV3c0Gc0Yd5mbBsRBJB0iH?=
 =?us-ascii?Q?QQk/jawG5V5lbFqpf3eVdyIdX7j/uxL8SoVwk0VmPLr86tW4+dLOPGckizVx?=
 =?us-ascii?Q?OYL86O5AcolTNiMaqMW20ma2s2A6oSvzg5xZuVUECqkFe6u6ZyJnhaFoer/A?=
 =?us-ascii?Q?kW1cNYMxmCkaGw3g1kRIm0kycO6YscaXnkmYz2zplcci/m82i9Ev5bg16Aow?=
 =?us-ascii?Q?yGqgonhtVVsOoAt4sTll+neVxS+bY5MQF4KnpyTW0ltJx03ha63P7SPv2pf9?=
 =?us-ascii?Q?HfmJ9+LqXIH8Q5zb9wZOMnfePl/RvD7+66GpWKQaAxFefbuQXUFeSNEG/At4?=
 =?us-ascii?Q?JjMs1Bkcl98gCPT+BWNzkRYuOyBgmyxMNptb6UGjU792iBuTCKdIkVpJI1qZ?=
 =?us-ascii?Q?FdN/S4YezBX8XIwJ0cIDoW3YNjPDSkx9p03EWcN9OSc8wRibXUod6ucu0vOs?=
 =?us-ascii?Q?6uIw7K1k2anIkwNuWXhjFkExE0y+nXH9tnCVnbKaJQA6v60WpXiyz/I53L70?=
 =?us-ascii?Q?sG+7yYHrPTFTeVfIPuVKjpUK2djpw5K+c3di?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:47.0187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c15ad0f-a48c-4377-1c91-08dd7c2e29f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY & HOW]
Providing hardware programming for the RMCM and MCM IPs for 3DLUT in DCN42.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   9 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   3 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 351 ++++++++++++++++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   8 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  29 ++
 5 files changed, 363 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index ab1adc836018..a4cd0eb39a3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1255,6 +1255,7 @@ enum dc_cm2_gpu_mem_layout {
 
 enum dc_cm2_gpu_mem_pixel_component_order {
 	DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_RGBA,
+	DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_BGRA
 };
 
 enum dc_cm2_gpu_mem_format {
@@ -1276,7 +1277,8 @@ struct dc_cm2_gpu_mem_format_parameters {
 
 enum dc_cm2_gpu_mem_size {
 	DC_CM2_GPU_MEM_SIZE_171717,
-	DC_CM2_GPU_MEM_SIZE_TRANSFORMED
+	DC_CM2_GPU_MEM_SIZE_333333,
+	DC_CM2_GPU_MEM_SIZE_TRANSFORMED,
 };
 
 struct dc_cm2_gpu_mem_parameters {
@@ -1285,6 +1287,7 @@ struct dc_cm2_gpu_mem_parameters {
 	struct dc_cm2_gpu_mem_format_parameters format_params;
 	enum dc_cm2_gpu_mem_pixel_component_order component_order;
 	enum dc_cm2_gpu_mem_size  size;
+	uint16_t bit_depth;
 };
 
 enum dc_cm2_transfer_func_source {
@@ -1308,6 +1311,10 @@ struct dc_cm2_func_luts {
 			const struct dc_3dlut *lut3d_func;
 			struct dc_cm2_gpu_mem_parameters gpu_mem_params;
 		};
+		bool rmcm_3dlut_shaper_select;
+		bool mpc_3dlut_enable;
+		bool rmcm_3dlut_enable;
+		bool mpc_mcm_post_blend;
 	} lut3d_data;
 	const struct dc_transfer_func *lut1d_func;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 0c8ec30ea672..f721aabdd470 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -885,6 +885,9 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 		case DC_CM2_GPU_MEM_SIZE_171717:
 			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_17_cube;
 			break;
+		case DC_CM2_GPU_MEM_SIZE_333333:
+			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_33_cube;
+			break;
 		case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
 			//plane->tdlut.tdlut_width_mode = dml2_tdlut_width_flatten; // dml2_tdlut_width_flatten undefined
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 5489f3d431f6..423c0d28218b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -396,6 +396,249 @@ static void dcn401_get_mcm_lut_xable_from_pipe_ctx(struct dc *dc, struct pipe_ct
 	}
 }
 
+static void dcn401_set_mcm_location_post_blend(struct dc *dc, struct pipe_ctx *pipe_ctx, bool bPostBlend)
+{
+	struct mpc *mpc = dc->res_pool->mpc;
+	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
+
+	if (!pipe_ctx->plane_state)
+		return;
+
+	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
+	pipe_ctx->plane_state->mcm_location = (bPostBlend) ?
+											MPCC_MOVABLE_CM_LOCATION_AFTER :
+											MPCC_MOVABLE_CM_LOCATION_BEFORE;
+}
+
+static void dc_get_lut_mode(
+	enum dc_cm2_gpu_mem_layout layout,
+	enum hubp_3dlut_fl_mode *mode,
+	enum hubp_3dlut_fl_addressing_mode *addr_mode)
+{
+	switch (layout) {
+	case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_RGB:
+		*mode = hubp_3dlut_fl_mode_native_1;
+		*addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
+		break;
+	case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_BGR:
+		*mode = hubp_3dlut_fl_mode_native_2;
+		*addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
+		break;
+	case DC_CM2_GPU_MEM_LAYOUT_1D_PACKED_LINEAR:
+		*mode = hubp_3dlut_fl_mode_transform;
+		*addr_mode = hubp_3dlut_fl_addressing_mode_simple_linear;
+		break;
+	default:
+		*mode = hubp_3dlut_fl_mode_disable;
+		*addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
+		break;
+	}
+}
+
+static void dc_get_lut_format(
+	enum dc_cm2_gpu_mem_format dc_format,
+	enum hubp_3dlut_fl_format *format)
+{
+	switch (dc_format) {
+	case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12MSB:
+		*format = hubp_3dlut_fl_format_unorm_12msb_bitslice;
+		break;
+	case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12LSB:
+		*format = hubp_3dlut_fl_format_unorm_12lsb_bitslice;
+		break;
+	case DC_CM2_GPU_MEM_FORMAT_16161616_FLOAT_FP1_5_10:
+		*format = hubp_3dlut_fl_format_float_fp1_5_10;
+		break;
+	}
+}
+
+static void dc_get_lut_xbar(
+	enum dc_cm2_gpu_mem_pixel_component_order order,
+	enum hubp_3dlut_fl_crossbar_bit_slice *cr_r,
+	enum hubp_3dlut_fl_crossbar_bit_slice *y_g,
+	enum hubp_3dlut_fl_crossbar_bit_slice *cb_b)
+{
+	switch (order) {
+	case DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_RGBA:
+		*cr_r = hubp_3dlut_fl_crossbar_bit_slice_32_47;
+		*y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
+		*cb_b =  hubp_3dlut_fl_crossbar_bit_slice_0_15;
+		break;
+	case DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_BGRA:
+		*cr_r = hubp_3dlut_fl_crossbar_bit_slice_0_15;
+		*y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
+		*cb_b = hubp_3dlut_fl_crossbar_bit_slice_32_47;
+		break;
+	}
+}
+
+static void dc_get_lut_width(
+	enum dc_cm2_gpu_mem_size  size,
+	enum hubp_3dlut_fl_width *width)
+{
+	switch (size) {
+	case DC_CM2_GPU_MEM_SIZE_333333:
+		*width = hubp_3dlut_fl_width_33;
+		break;
+	case DC_CM2_GPU_MEM_SIZE_171717:
+		*width = hubp_3dlut_fl_width_17;
+		break;
+	case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
+		*width = hubp_3dlut_fl_width_transformed;
+		break;
+	}
+}
+static bool dc_is_rmcm_3dlut_supported(struct hubp *hubp, struct mpc *mpc)
+{
+	if (mpc->funcs->rmcm.update_3dlut_fast_load_select &&
+		mpc->funcs->rmcm.program_lut_read_write_control &&
+		hubp->funcs->hubp_program_3dlut_fl_addr &&
+		mpc->funcs->rmcm.program_bit_depth &&
+		hubp->funcs->hubp_program_3dlut_fl_mode &&
+		hubp->funcs->hubp_program_3dlut_fl_addressing_mode &&
+		hubp->funcs->hubp_program_3dlut_fl_format &&
+		hubp->funcs->hubp_update_3dlut_fl_bias_scale &&
+		mpc->funcs->rmcm.program_bias_scale &&
+		hubp->funcs->hubp_program_3dlut_fl_crossbar &&
+		hubp->funcs->hubp_program_3dlut_fl_width &&
+		mpc->funcs->rmcm.update_3dlut_fast_load_select &&
+		mpc->funcs->rmcm.populate_lut &&
+		mpc->funcs->rmcm.program_lut_mode &&
+		hubp->funcs->hubp_enable_3dlut_fl &&
+		mpc->funcs->rmcm.enable_3dlut_fl)
+		return true;
+
+	return false;
+}
+
+bool dcn401_program_rmcm_luts(
+	struct hubp *hubp,
+	struct pipe_ctx *pipe_ctx,
+	enum dc_cm2_transfer_func_source lut3d_src,
+	struct dc_cm2_func_luts *mcm_luts,
+	struct mpc *mpc,
+	bool lut_bank_a,
+	int mpcc_id)
+{
+	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
+	union mcm_lut_params m_lut_params;
+	enum MCM_LUT_XABLE shaper_xable, lut3d_xable = MCM_LUT_DISABLE, lut1d_xable;
+	enum hubp_3dlut_fl_mode mode;
+	enum hubp_3dlut_fl_addressing_mode addr_mode;
+	enum hubp_3dlut_fl_format format;
+	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g;
+	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b;
+	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cr_r;
+	enum hubp_3dlut_fl_width width;
+	struct dc *dc = hubp->ctx->dc;
+
+	bool bypass_rmcm_3dlut  = false;
+	bool bypass_rmcm_shaper = false;
+
+	dcn401_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
+
+	/* 3DLUT */
+	switch (lut3d_src) {
+	case DC_CM2_TRANSFER_FUNC_SOURCE_SYSMEM:
+		memset(&m_lut_params, 0, sizeof(m_lut_params));
+		// Don't know what to do in this case.
+		//case DC_CM2_TRANSFER_FUNC_SOURCE_SYSMEM:
+		break;
+	case DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM:
+		dc_get_lut_width(mcm_luts->lut3d_data.gpu_mem_params.size, &width);
+		if (!dc_is_rmcm_3dlut_supported(hubp, mpc) ||
+			!mpc->funcs->rmcm.is_config_supported(width))
+			return false;
+
+		//0. disable fl on mpc
+		mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, 0xF);
+
+		//1. power down the block
+		mpc->funcs->rmcm.power_on_shaper_3dlut(mpc, mpcc_id, false);
+
+		//2. program RMCM
+		//2a. 3dlut reg programming
+		mpc->funcs->rmcm.program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a,
+				(!bypass_rmcm_3dlut) && lut3d_xable != MCM_LUT_DISABLE, mpcc_id);
+
+		hubp->funcs->hubp_program_3dlut_fl_addr(hubp,
+				mcm_luts->lut3d_data.gpu_mem_params.addr);
+
+		mpc->funcs->rmcm.program_bit_depth(mpc,
+				mcm_luts->lut3d_data.gpu_mem_params.bit_depth, mpcc_id);
+
+		// setting native or transformed mode,
+		dc_get_lut_mode(mcm_luts->lut3d_data.gpu_mem_params.layout, &mode, &addr_mode);
+
+		//these program the mcm 3dlut
+		hubp->funcs->hubp_program_3dlut_fl_mode(hubp, mode);
+
+		hubp->funcs->hubp_program_3dlut_fl_addressing_mode(hubp, addr_mode);
+
+		//seems to be only for the MCM
+		dc_get_lut_format(mcm_luts->lut3d_data.gpu_mem_params.format_params.format, &format);
+		hubp->funcs->hubp_program_3dlut_fl_format(hubp, format);
+
+		mpc->funcs->rmcm.program_bias_scale(mpc,
+			mcm_luts->lut3d_data.gpu_mem_params.format_params.float_params.bias,
+			mcm_luts->lut3d_data.gpu_mem_params.format_params.float_params.scale,
+			mpcc_id);
+		hubp->funcs->hubp_update_3dlut_fl_bias_scale(hubp,
+					mcm_luts->lut3d_data.gpu_mem_params.format_params.float_params.bias,
+					mcm_luts->lut3d_data.gpu_mem_params.format_params.float_params.scale);
+
+		dc_get_lut_xbar(
+			mcm_luts->lut3d_data.gpu_mem_params.component_order,
+			&crossbar_bit_slice_cr_r,
+			&crossbar_bit_slice_y_g,
+			&crossbar_bit_slice_cb_b);
+
+		hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp,
+			crossbar_bit_slice_cr_r,
+			crossbar_bit_slice_y_g,
+			crossbar_bit_slice_cb_b);
+
+		mpc->funcs->rmcm.program_3dlut_size(mpc, width, mpcc_id);
+
+		mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, hubp->inst);
+
+		//2b. shaper reg programming
+		memset(&m_lut_params, 0, sizeof(m_lut_params));
+
+		if (mcm_luts->shaper->type == TF_TYPE_HWPWL) {
+			m_lut_params.pwl = &mcm_luts->shaper->pwl;
+		} else if (mcm_luts->shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
+			ASSERT(false);
+			cm_helper_translate_curve_to_hw_format(
+					dc->ctx,
+					mcm_luts->shaper,
+					&dpp_base->regamma_params, true);
+			m_lut_params.pwl = &dpp_base->regamma_params;
+		}
+		if (m_lut_params.pwl) {
+			mpc->funcs->rmcm.populate_lut(mpc, m_lut_params, lut_bank_a, mpcc_id);
+			mpc->funcs->rmcm.program_lut_mode(mpc, !bypass_rmcm_shaper, lut_bank_a, mpcc_id);
+		} else {
+			//RMCM 3dlut won't work without its shaper
+			return false;
+		}
+
+		//3. Select the hubp connected to this RMCM
+		hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
+		mpc->funcs->rmcm.enable_3dlut_fl(mpc, true, mpcc_id);
+
+		//4. power on the block
+		if (m_lut_params.pwl)
+			mpc->funcs->rmcm.power_on_shaper_3dlut(mpc, mpcc_id, true);
+
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 void dcn401_populate_mcm_luts(struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		struct dc_cm2_func_luts mcm_luts,
@@ -407,9 +650,9 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 	struct mpc *mpc = dc->res_pool->mpc;
 	union mcm_lut_params m_lut_params;
 	enum dc_cm2_transfer_func_source lut3d_src = mcm_luts.lut3d_data.lut3d_src;
-	enum hubp_3dlut_fl_format format;
+	enum hubp_3dlut_fl_format format = 0;
 	enum hubp_3dlut_fl_mode mode;
-	enum hubp_3dlut_fl_width width;
+	enum hubp_3dlut_fl_width width = 0;
 	enum hubp_3dlut_fl_addressing_mode addr_mode;
 	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g;
 	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b;
@@ -417,11 +660,29 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 	enum MCM_LUT_XABLE shaper_xable = MCM_LUT_DISABLE;
 	enum MCM_LUT_XABLE lut3d_xable = MCM_LUT_DISABLE;
 	enum MCM_LUT_XABLE lut1d_xable = MCM_LUT_DISABLE;
-	bool is_17x17x17 = true;
 	bool rval;
 
 	dcn401_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
 
+	//MCM - setting its location (Before/After) blender
+	//set to post blend (true)
+	dcn401_set_mcm_location_post_blend(
+		dc,
+		pipe_ctx,
+		mcm_luts.lut3d_data.mpc_mcm_post_blend);
+
+	//RMCM - 3dLUT+Shaper
+	if (mcm_luts.lut3d_data.rmcm_3dlut_enable) {
+		dcn401_program_rmcm_luts(
+			hubp,
+			pipe_ctx,
+			lut3d_src,
+			&mcm_luts,
+			mpc,
+			lut_bank_a,
+			mpcc_id);
+	}
+
 	/* 1D LUT */
 	if (mcm_luts.lut1d_func) {
 		memset(&m_lut_params, 0, sizeof(m_lut_params));
@@ -442,7 +703,7 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 	}
 
 	/* Shaper */
-	if (mcm_luts.shaper) {
+	if (mcm_luts.shaper && mcm_luts.lut3d_data.mpc_3dlut_enable) {
 		memset(&m_lut_params, 0, sizeof(m_lut_params));
 		if (mcm_luts.shaper->type == TF_TYPE_HWPWL)
 			m_lut_params.pwl = &mcm_luts.shaper->pwl;
@@ -454,11 +715,10 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 			m_lut_params.pwl = rval ? &dpp_base->regamma_params : NULL;
 		}
 		if (m_lut_params.pwl) {
-			if (mpc->funcs->populate_lut)
-				mpc->funcs->populate_lut(mpc, MCM_LUT_SHAPER, m_lut_params, lut_bank_a, mpcc_id);
+			if (mpc->funcs->mcm.populate_lut)
+				mpc->funcs->mcm.populate_lut(mpc, m_lut_params, lut_bank_a, mpcc_id);
+			mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_ENABLE, lut_bank_a, mpcc_id);
 		}
-		if (mpc->funcs->program_lut_mode)
-			mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, shaper_xable, lut_bank_a, mpcc_id);
 	}
 
 	/* 3DLUT */
@@ -467,6 +727,7 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 		memset(&m_lut_params, 0, sizeof(m_lut_params));
 		if (hubp->funcs->hubp_enable_3dlut_fl)
 			hubp->funcs->hubp_enable_3dlut_fl(hubp, false);
+
 		if (mcm_luts.lut3d_data.lut3d_func && mcm_luts.lut3d_data.lut3d_func->state.bits.initialized) {
 			m_lut_params.lut3d = &mcm_luts.lut3d_data.lut3d_func->lut_3d;
 			if (mpc->funcs->populate_lut)
@@ -476,16 +737,35 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 						mpcc_id);
 		}
 		break;
-	case DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM:
+		case DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM:
+		switch (mcm_luts.lut3d_data.gpu_mem_params.size) {
+		case DC_CM2_GPU_MEM_SIZE_333333:
+			width = hubp_3dlut_fl_width_33;
+			break;
+		case DC_CM2_GPU_MEM_SIZE_171717:
+			width = hubp_3dlut_fl_width_17;
+			break;
+		case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
+			width = hubp_3dlut_fl_width_transformed;
+			break;
+		}
+
+		//check for support
+		if (mpc->funcs->mcm.is_config_supported &&
+			!mpc->funcs->mcm.is_config_supported(width))
+			break;
 
 		if (mpc->funcs->program_lut_read_write_control)
 			mpc->funcs->program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a, mpcc_id);
 		if (mpc->funcs->program_lut_mode)
 			mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, lut3d_xable, lut_bank_a, mpcc_id);
-		if (mpc->funcs->program_3dlut_size)
-			mpc->funcs->program_3dlut_size(mpc, is_17x17x17, mpcc_id);
+
 		if (hubp->funcs->hubp_program_3dlut_fl_addr)
 			hubp->funcs->hubp_program_3dlut_fl_addr(hubp, mcm_luts.lut3d_data.gpu_mem_params.addr);
+
+		if (mpc->funcs->mcm.program_bit_depth)
+			mpc->funcs->mcm.program_bit_depth(mpc, mcm_luts.lut3d_data.gpu_mem_params.bit_depth, mpcc_id);
+
 		switch (mcm_luts.lut3d_data.gpu_mem_params.layout) {
 		case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_RGB:
 			mode = hubp_3dlut_fl_mode_native_1;
@@ -512,7 +792,6 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 
 		switch (mcm_luts.lut3d_data.gpu_mem_params.format_params.format) {
 		case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12MSB:
-		default:
 			format = hubp_3dlut_fl_format_unorm_12msb_bitslice;
 			break;
 		case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12LSB:
@@ -524,37 +803,37 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 		}
 		if (hubp->funcs->hubp_program_3dlut_fl_format)
 			hubp->funcs->hubp_program_3dlut_fl_format(hubp, format);
-		if (hubp->funcs->hubp_update_3dlut_fl_bias_scale)
+		if (hubp->funcs->hubp_update_3dlut_fl_bias_scale &&
+				mpc->funcs->mcm.program_bias_scale) {
+			mpc->funcs->mcm.program_bias_scale(mpc,
+				mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.bias,
+				mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.scale,
+				mpcc_id);
 			hubp->funcs->hubp_update_3dlut_fl_bias_scale(hubp,
-					mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.bias,
-					mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.scale);
-
-		switch (mcm_luts.lut3d_data.gpu_mem_params.component_order) {
-		case DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_RGBA:
-		default:
-			crossbar_bit_slice_cr_r = hubp_3dlut_fl_crossbar_bit_slice_0_15;
-			crossbar_bit_slice_y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
-			crossbar_bit_slice_cb_b = hubp_3dlut_fl_crossbar_bit_slice_32_47;
-			break;
+						mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.bias,
+						mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.scale);
 		}
 
+		//navi 4x has a bug and r and blue are swapped and need to be worked around here in
+		//TODO: need to make a method for get_xbar per asic OR do the workaround in program_crossbar for 4x
+		dc_get_lut_xbar(
+			mcm_luts.lut3d_data.gpu_mem_params.component_order,
+			&crossbar_bit_slice_cr_r,
+			&crossbar_bit_slice_y_g,
+			&crossbar_bit_slice_cb_b);
+
 		if (hubp->funcs->hubp_program_3dlut_fl_crossbar)
 			hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp,
+					crossbar_bit_slice_cr_r,
 					crossbar_bit_slice_y_g,
-					crossbar_bit_slice_cb_b,
-					crossbar_bit_slice_cr_r);
+					crossbar_bit_slice_cb_b);
+
+		if (mpc->funcs->mcm.program_lut_read_write_control)
+			mpc->funcs->mcm.program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a, true, mpcc_id);
+
+		if (mpc->funcs->mcm.program_3dlut_size)
+			mpc->funcs->mcm.program_3dlut_size(mpc, width, mpcc_id);
 
-		switch (mcm_luts.lut3d_data.gpu_mem_params.size) {
-		case DC_CM2_GPU_MEM_SIZE_171717:
-		default:
-			width = hubp_3dlut_fl_width_17;
-			break;
-		case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
-			width = hubp_3dlut_fl_width_transformed;
-			break;
-		}
-		if (hubp->funcs->hubp_program_3dlut_fl_width)
-			hubp->funcs->hubp_program_3dlut_fl_width(hubp, width);
 		if (mpc->funcs->update_3dlut_fast_load_select)
 			mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, hubp->inst);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 781cf0efccc6..ce65b4f6c672 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -109,4 +109,12 @@ void dcn401_detect_pipe_changes(
 void dcn401_plane_atomic_power_down(struct dc *dc,
 		struct dpp *dpp,
 		struct hubp *hubp);
+bool dcn401_program_rmcm_luts(
+	struct hubp *hubp,
+	struct pipe_ctx *pipe_ctx,
+	enum dc_cm2_transfer_func_source lut3d_src,
+	struct dc_cm2_func_luts *mcm_luts,
+	struct mpc *mpc,
+	bool lut_bank_a,
+	int mpcc_id);
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index eaef3899da7b..6e303b81bfb0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -1037,6 +1037,35 @@ struct mpc_funcs {
 	* void
 	*/
 	void (*program_3dlut_size)(struct mpc *mpc, bool is_17x17x17, int mpcc_id);
+
+	struct {
+		void (*program_3dlut_size)(struct mpc *mpc, uint32_t width, int mpcc_id);
+		void (*program_bias_scale)(struct mpc *mpc, uint16_t bias, uint16_t scale, int mpcc_id);
+		void (*program_bit_depth)(struct mpc *mpc, uint16_t bit_depth, int mpcc_id);
+		bool (*is_config_supported)(uint32_t width);
+		void (*program_lut_read_write_control)(struct mpc *mpc, const enum MCM_LUT_ID id,
+			bool lut_bank_a, bool enabled, int mpcc_id);
+
+		void (*populate_lut)(struct mpc *mpc, const union mcm_lut_params params,
+			bool lut_bank_a, int mpcc_id);
+	} mcm;
+
+	struct {
+		void (*enable_3dlut_fl)(struct mpc *mpc, bool enable, int mpcc_id);
+		void (*update_3dlut_fast_load_select)(struct mpc *mpc, int mpcc_id, int hubp_idx);
+		void (*program_lut_read_write_control)(struct mpc *mpc, const enum MCM_LUT_ID id,
+			bool lut_bank_a, bool enabled, int mpcc_id);
+		void (*program_lut_mode)(struct mpc *mpc, const enum MCM_LUT_XABLE xable,
+			bool lut_bank_a, int mpcc_id);
+		void (*program_3dlut_size)(struct mpc *mpc, uint32_t width, int mpcc_id);
+		void (*program_bias_scale)(struct mpc *mpc, uint16_t bias, uint16_t scale, int mpcc_id);
+		void (*program_bit_depth)(struct mpc *mpc, uint16_t bit_depth, int mpcc_id);
+		bool (*is_config_supported)(uint32_t width);
+
+		void (*power_on_shaper_3dlut)(struct mpc *mpc, uint32_t mpcc_id, bool power_on);
+		void (*populate_lut)(struct mpc *mpc, const union mcm_lut_params params,
+			bool lut_bank_a, int mpcc_id);
+	} rmcm;
 };
 
 #endif
-- 
2.34.1

