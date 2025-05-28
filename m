Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68990C54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F091410E114;
	Wed, 28 May 2025 02:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nDTszpCR";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77A110E114
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgTwvBrU8il1eBK+0eyjtbYmV30WCmCuLhpct6Tm966H0D9TL8k8erPguusiG4OOzk8TyJ1f0+V/kXYnGu7Yu5gqUiMiYKxlXKw3Z69mlV6Raedbte4eDCnSaQMkNBD2UFhfdkCQmWYe/Qu6MHr7BqcxmAigjF/+F2kE28ATqCqLog3xHzrKkwa/vf2j75VtYr/cFbSP0uIX6/hHRVL3FCacBAhnkaW6Wz8z+TBvnWxo9Bul1PvlGZe8JpL0BRL4LLAF92d5gy1JzfSlO26K5OdrwtR86fWNKHoC+u86OLyPcJZoFb+21phfzjMawCpWPcNp9ee4v6nlv4uYu+y8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ19ll8he+DIOW5DSM0n0nMmm7QzZ8paC2+XYbVddxU=;
 b=oPt0kFd/04j9IjSAqVYyXsMqo773od+6iBNZhfgEGLadBqbZPOkFF5n87TLsLeFYSKHD3KSOOmsPS7L/LiYJoz9zBVqT+4eI7t52nDJ34lBCJNZgPRDqRIwSYSlQ+fK3rLji5PnoITEebNudG1XXIYaM3l+BTWBIXajiVfYn1F7VnotDl3Hwr01rBETCYUiBTLtmu7FnJtE1LU8NgmB98p/+5IbFU42VSrsi0/hoBIuHYXPuptYXuAfvh/kLrjngx6uLuZM5MGckC068WcHtGWx35Rfw4EwmcTcFuDyBm6gFPObXU76gV+k554djhI846gcxhg1zs/e3ciigvGAQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJ19ll8he+DIOW5DSM0n0nMmm7QzZ8paC2+XYbVddxU=;
 b=nDTszpCRYuWv4gcmGPITM26o8a7gxZRKuL3+nDVmxRrU6redQrW++U5/wFgfpb8K9JmvH2fcQXhWIBsaOTpPeANTBE8KFWnmsGy1GfkSMTW8wHwmjOxIyhcwBx9ZnBhStmGCx2xAlL+1gp7smFcRML5r7agMaJIb+5pBCTEsPSQ=
Received: from BN9PR03CA0876.namprd03.prod.outlook.com (2603:10b6:408:13c::11)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 28 May
 2025 02:52:42 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::ab) by BN9PR03CA0876.outlook.office365.com
 (2603:10b6:408:13c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 28 May 2025 02:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:52:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:40 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:52:36 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Yihan Zhu
 <Yihan.Zhu@amd.com>, Jun Lei <jun.lei@amd.com>
Subject: [PATCH 05/24] drm/amd/display: move RMCM programming
Date: Wed, 28 May 2025 10:49:00 +0800
Message-ID: <20250528025204.79578-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 91765c9c-94f9-4159-af30-08dd9d92b735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ELB8/5Z+atvW6NwBz/4/DdrJRxs8yvTnIjXWWxBdXJKmmaifEoguKouyzs3d?=
 =?us-ascii?Q?HISxJ8XdqSzIb6tlSvcZZoTzNrA3E6fmae4Lq154Q2KUV8vNIjuaQ7lailLz?=
 =?us-ascii?Q?gYMmFatt1gttPCMEMeRLxTXCCnfGR++W0LbAbjdqoKQGVTls2lvMx2PfrFGl?=
 =?us-ascii?Q?+nzHZoFyeYacze8jHtQuFWP7XoqokNAPmcye6Lnp9nK5WFB/aYq5OXppCdA4?=
 =?us-ascii?Q?RAlBJfiehvbGiGRxvc6qrbSjSt6c4Ql0Sx4bkzF2An5NVlB7sYWuWguLh+T0?=
 =?us-ascii?Q?cGfeEkkeUtUewLqJzAMqr+ERynGMz6UGfB/F09p5c2B2S2+Hl99mH0eCuMwM?=
 =?us-ascii?Q?7af77TDjNR4kRiTQRv85ufwCkNZxREcFqiluvcjgxpdpK02sJxFbO0moajHN?=
 =?us-ascii?Q?2uxAQVBCqMNamUZyRmO/RA5n62udecfuWLNQqX2LwgC4LL3D8tQNqZzJHw56?=
 =?us-ascii?Q?pcJ7xZSyDdsK3A04iyst8RztP/2BPJktKmuL6v6ZGtZbX11JdrxnogL5pigX?=
 =?us-ascii?Q?Rkg8sWZu8KGmnrGLx1yQ7K2a5IYLQ6G9BGT6ryNA3kAQPzDCB2srhF1mfqrN?=
 =?us-ascii?Q?BPUFYOZD6ozwisRALHaHuw9ev1zFCXviE5lLC7jR1wo6i/xMqxF/jbXdSuff?=
 =?us-ascii?Q?LKudLrgNKbXu3YylRIAlLJW5lmdyqPZJWBHDi/npVRVJ+FQiCaijhl9UdlE3?=
 =?us-ascii?Q?LSEy3WCH5if7lgOaDB3r6qmCvZUVwDl2nGFtUhIyzn/Ve2L5iAEv1JaIEh2L?=
 =?us-ascii?Q?cB7mcEx7VSwFvMsJugmt/ZbIf2wPBOfDffdpy7KnsFpvuPHpC39WJ8mnZO9w?=
 =?us-ascii?Q?7L1PMA5D3SMY/q8IDIuO9feLHDfLh2gtiRh2j88aOcymgnw3kxf+o+KaJNjF?=
 =?us-ascii?Q?MUM4cRgWK/sGmzZcqaeqI2ZLhuwoF65sI4Lv0xhOlEpbdKfuzjivf8XcBPxR?=
 =?us-ascii?Q?WTvwLqdDUJ4wRZytFUsciRV8x6HsudTrbA3RxORfmxngQPTPPj2fXmFt7iyB?=
 =?us-ascii?Q?1c6MU49JXO54VRXEXMWrOrlsbEYpd8GmeyNdosfm+oLFXKOZySuMPf4UHnW0?=
 =?us-ascii?Q?Ren/XTJVas2rGr46a4PWOXoADtGS3zKxk21GIJcL/wk+JawDqEbIWbH7ANRk?=
 =?us-ascii?Q?eO/fa5LKSjx7yEQc3qXwSPlOKdfjA5gUORr0vsasqjgjaHF4Kdl0rwJyyh94?=
 =?us-ascii?Q?PxQ33HWOkMDR+i4XIxOzY8dSoEP7FC3izQPDO2uwr7Rd+jKRZ5nvnUH9+Nyu?=
 =?us-ascii?Q?uvycD6d5eize5p7BgX+P2Upf646Uir/FrGkslBuvvIYx8UBDBRtCZMfX92Bt?=
 =?us-ascii?Q?H6XJMD9ko87kDClxGw3hhpIx/OIXE2taA/4eycbAw3wSL7N5gT6SVh2F4AMu?=
 =?us-ascii?Q?lrGVWHpKFYmDa/xAhTCyvOJ9Lx/hP5uN1Gq/uXK6ThF3t94tM0/+RwKENolT?=
 =?us-ascii?Q?QvJtHjQ/Y4wb90tBTSySf9aEP0fEC+imyIcaAvk/HI066Y8r6dRkDIA8Z3/z?=
 =?us-ascii?Q?vvg09kRpqNuxRyQ2ujt7qQfGvb9ZCxblr5Uj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:52:42.0600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91765c9c-94f9-4159-af30-08dd9d92b735
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C
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
Move only RMCM programming outside of dcn401. Extended HW
definition in dc for memory layout to extend support.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  31 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 -
 .../dc/dml2/dml21/dml21_translation_helper.c  |   4 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   8 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 288 +-----------------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   8 -
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |   3 -
 7 files changed, 42 insertions(+), 302 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1d917be36fc4..a63f7fe277fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -67,6 +67,7 @@ struct dmub_notification;
 #define MIN_VIEWPORT_SIZE 12
 #define MAX_NUM_EDP 2
 #define MAX_HOST_ROUTERS_NUM 2
+#define MAX_SUPPORTED_FORMATS 7
 
 /* Display Core Interfaces */
 struct dc_versions {
@@ -192,6 +193,34 @@ struct dpp_color_caps {
 	struct rom_curve_caps ogam_rom_caps;
 };
 
+/* Below structure is to describe the HW support for mem layout, extend support
+	range to match what OS could handle in the roadmap */
+struct lut3d_caps {
+	uint32_t dma_3d_lut : 1; /*< DMA mode support for 3D LUT */
+	struct {
+		uint32_t swizzle_3d_rgb : 1;
+		uint32_t swizzle_3d_bgr : 1;
+		uint32_t linear_1d : 1;
+	} mem_layout_support;
+	struct {
+		uint32_t unorm_12msb : 1;
+		uint32_t unorm_12lsb : 1;
+		uint32_t float_fp1_5_10 : 1;
+	} mem_format_support;
+	struct {
+		uint32_t order_rgba : 1;
+		uint32_t order_bgra : 1;
+	} mem_pixel_order_support;
+	/*< size options are 9, 17, 33, 45, 65 */
+	struct {
+		uint32_t dim_9 : 1; /* 3D LUT support for 9x9x9 */
+		uint32_t dim_17 : 1; /* 3D LUT support for 17x17x17 */
+		uint32_t dim_33 : 1; /* 3D LUT support for 33x33x33 */
+		uint32_t dim_45 : 1; /* 3D LUT support for 45x45x45 */
+		uint32_t dim_65 : 1; /* 3D LUT support for 65x65x65 */
+	} lut_dim_caps;
+};
+
 /**
  * struct mpc_color_caps - color pipeline capabilities for multiple pipe and
  * plane combined blocks
@@ -211,6 +240,8 @@ struct mpc_color_caps {
 	uint16_t num_3dluts : 3;
 	uint16_t shared_3d_lut:1;
 	struct rom_curve_caps ogam_rom_caps;
+	struct lut3d_caps mcm_3d_lut_caps;
+	struct lut3d_caps rmcm_3d_lut_caps;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index a4cd0eb39a3a..794b5f30d252 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1255,7 +1255,6 @@ enum dc_cm2_gpu_mem_layout {
 
 enum dc_cm2_gpu_mem_pixel_component_order {
 	DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_RGBA,
-	DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_BGRA
 };
 
 enum dc_cm2_gpu_mem_format {
@@ -1277,7 +1276,6 @@ struct dc_cm2_gpu_mem_format_parameters {
 
 enum dc_cm2_gpu_mem_size {
 	DC_CM2_GPU_MEM_SIZE_171717,
-	DC_CM2_GPU_MEM_SIZE_333333,
 	DC_CM2_GPU_MEM_SIZE_TRANSFORMED,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index d47cacfdb695..8b45b0bcc396 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -888,10 +888,8 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 		case DC_CM2_GPU_MEM_SIZE_171717:
 			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_17_cube;
 			break;
-		case DC_CM2_GPU_MEM_SIZE_333333:
-			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_33_cube;
-			break;
 		case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
+		default:
 			//plane->tdlut.tdlut_width_mode = dml2_tdlut_width_flatten; // dml2_tdlut_width_flatten undefined
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index c277df12c817..4ea3b4ad179b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1971,14 +1971,6 @@ static void dcn20_program_pipe(
 		pipe_ctx->plane_state->update_flags.bits.hdr_mult))
 		hws->funcs.set_hdr_multiplier(pipe_ctx);
 
-	if (hws->funcs.populate_mcm_luts) {
-		if (pipe_ctx->plane_state) {
-			hws->funcs.populate_mcm_luts(dc, pipe_ctx, pipe_ctx->plane_state->mcm_luts,
-				pipe_ctx->plane_state->lut_bank_a);
-			pipe_ctx->plane_state->lut_bank_a = !pipe_ctx->plane_state->lut_bank_a;
-		}
-	}
-
 	if (pipe_ctx->plane_state &&
 		(pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
 			pipe_ctx->plane_state->update_flags.bits.gamma_change ||
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index c4177a9a662f..ea28c75fdace 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2,6 +2,8 @@
 //
 // Copyright 2024 Advanced Micro Devices, Inc.
 
+
+#include "os_types.h"
 #include "dm_services.h"
 #include "basics/dc_common.h"
 #include "dm_helpers.h"
@@ -396,249 +398,6 @@ static void dcn401_get_mcm_lut_xable_from_pipe_ctx(struct dc *dc, struct pipe_ct
 	}
 }
 
-static void dcn401_set_mcm_location_post_blend(struct dc *dc, struct pipe_ctx *pipe_ctx, bool bPostBlend)
-{
-	struct mpc *mpc = dc->res_pool->mpc;
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-
-	if (!pipe_ctx->plane_state)
-		return;
-
-	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
-	pipe_ctx->plane_state->mcm_location = (bPostBlend) ?
-											MPCC_MOVABLE_CM_LOCATION_AFTER :
-											MPCC_MOVABLE_CM_LOCATION_BEFORE;
-}
-
-static void dc_get_lut_mode(
-	enum dc_cm2_gpu_mem_layout layout,
-	enum hubp_3dlut_fl_mode *mode,
-	enum hubp_3dlut_fl_addressing_mode *addr_mode)
-{
-	switch (layout) {
-	case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_RGB:
-		*mode = hubp_3dlut_fl_mode_native_1;
-		*addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
-		break;
-	case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_BGR:
-		*mode = hubp_3dlut_fl_mode_native_2;
-		*addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
-		break;
-	case DC_CM2_GPU_MEM_LAYOUT_1D_PACKED_LINEAR:
-		*mode = hubp_3dlut_fl_mode_transform;
-		*addr_mode = hubp_3dlut_fl_addressing_mode_simple_linear;
-		break;
-	default:
-		*mode = hubp_3dlut_fl_mode_disable;
-		*addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
-		break;
-	}
-}
-
-static void dc_get_lut_format(
-	enum dc_cm2_gpu_mem_format dc_format,
-	enum hubp_3dlut_fl_format *format)
-{
-	switch (dc_format) {
-	case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12MSB:
-		*format = hubp_3dlut_fl_format_unorm_12msb_bitslice;
-		break;
-	case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12LSB:
-		*format = hubp_3dlut_fl_format_unorm_12lsb_bitslice;
-		break;
-	case DC_CM2_GPU_MEM_FORMAT_16161616_FLOAT_FP1_5_10:
-		*format = hubp_3dlut_fl_format_float_fp1_5_10;
-		break;
-	}
-}
-
-static void dc_get_lut_xbar(
-	enum dc_cm2_gpu_mem_pixel_component_order order,
-	enum hubp_3dlut_fl_crossbar_bit_slice *cr_r,
-	enum hubp_3dlut_fl_crossbar_bit_slice *y_g,
-	enum hubp_3dlut_fl_crossbar_bit_slice *cb_b)
-{
-	switch (order) {
-	case DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_RGBA:
-		*cr_r = hubp_3dlut_fl_crossbar_bit_slice_32_47;
-		*y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
-		*cb_b =  hubp_3dlut_fl_crossbar_bit_slice_0_15;
-		break;
-	case DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_BGRA:
-		*cr_r = hubp_3dlut_fl_crossbar_bit_slice_0_15;
-		*y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
-		*cb_b = hubp_3dlut_fl_crossbar_bit_slice_32_47;
-		break;
-	}
-}
-
-static void dc_get_lut_width(
-	enum dc_cm2_gpu_mem_size  size,
-	enum hubp_3dlut_fl_width *width)
-{
-	switch (size) {
-	case DC_CM2_GPU_MEM_SIZE_333333:
-		*width = hubp_3dlut_fl_width_33;
-		break;
-	case DC_CM2_GPU_MEM_SIZE_171717:
-		*width = hubp_3dlut_fl_width_17;
-		break;
-	case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
-		*width = hubp_3dlut_fl_width_transformed;
-		break;
-	}
-}
-static bool dc_is_rmcm_3dlut_supported(struct hubp *hubp, struct mpc *mpc)
-{
-	if (mpc->funcs->rmcm.update_3dlut_fast_load_select &&
-		mpc->funcs->rmcm.program_lut_read_write_control &&
-		hubp->funcs->hubp_program_3dlut_fl_addr &&
-		mpc->funcs->rmcm.program_bit_depth &&
-		hubp->funcs->hubp_program_3dlut_fl_mode &&
-		hubp->funcs->hubp_program_3dlut_fl_addressing_mode &&
-		hubp->funcs->hubp_program_3dlut_fl_format &&
-		hubp->funcs->hubp_update_3dlut_fl_bias_scale &&
-		mpc->funcs->rmcm.program_bias_scale &&
-		hubp->funcs->hubp_program_3dlut_fl_crossbar &&
-		hubp->funcs->hubp_program_3dlut_fl_width &&
-		mpc->funcs->rmcm.update_3dlut_fast_load_select &&
-		mpc->funcs->rmcm.populate_lut &&
-		mpc->funcs->rmcm.program_lut_mode &&
-		hubp->funcs->hubp_enable_3dlut_fl &&
-		mpc->funcs->rmcm.enable_3dlut_fl)
-		return true;
-
-	return false;
-}
-
-bool dcn401_program_rmcm_luts(
-	struct hubp *hubp,
-	struct pipe_ctx *pipe_ctx,
-	enum dc_cm2_transfer_func_source lut3d_src,
-	struct dc_cm2_func_luts *mcm_luts,
-	struct mpc *mpc,
-	bool lut_bank_a,
-	int mpcc_id)
-{
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
-	union mcm_lut_params m_lut_params;
-	enum MCM_LUT_XABLE shaper_xable, lut3d_xable = MCM_LUT_DISABLE, lut1d_xable;
-	enum hubp_3dlut_fl_mode mode;
-	enum hubp_3dlut_fl_addressing_mode addr_mode;
-	enum hubp_3dlut_fl_format format = 0;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g = 0;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b = 0;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cr_r = 0;
-	enum hubp_3dlut_fl_width width = 0;
-	struct dc *dc = hubp->ctx->dc;
-
-	bool bypass_rmcm_3dlut  = false;
-	bool bypass_rmcm_shaper = false;
-
-	dcn401_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
-
-	/* 3DLUT */
-	switch (lut3d_src) {
-	case DC_CM2_TRANSFER_FUNC_SOURCE_SYSMEM:
-		memset(&m_lut_params, 0, sizeof(m_lut_params));
-		// Don't know what to do in this case.
-		//case DC_CM2_TRANSFER_FUNC_SOURCE_SYSMEM:
-		break;
-	case DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM:
-		dc_get_lut_width(mcm_luts->lut3d_data.gpu_mem_params.size, &width);
-		if (!dc_is_rmcm_3dlut_supported(hubp, mpc) ||
-			!mpc->funcs->rmcm.is_config_supported(width))
-			return false;
-
-		//0. disable fl on mpc
-		mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, 0xF);
-
-		//1. power down the block
-		mpc->funcs->rmcm.power_on_shaper_3dlut(mpc, mpcc_id, false);
-
-		//2. program RMCM
-		//2a. 3dlut reg programming
-		mpc->funcs->rmcm.program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a,
-				(!bypass_rmcm_3dlut) && lut3d_xable != MCM_LUT_DISABLE, mpcc_id);
-
-		hubp->funcs->hubp_program_3dlut_fl_addr(hubp,
-				mcm_luts->lut3d_data.gpu_mem_params.addr);
-
-		mpc->funcs->rmcm.program_bit_depth(mpc,
-				mcm_luts->lut3d_data.gpu_mem_params.bit_depth, mpcc_id);
-
-		// setting native or transformed mode,
-		dc_get_lut_mode(mcm_luts->lut3d_data.gpu_mem_params.layout, &mode, &addr_mode);
-
-		//these program the mcm 3dlut
-		hubp->funcs->hubp_program_3dlut_fl_mode(hubp, mode);
-
-		hubp->funcs->hubp_program_3dlut_fl_addressing_mode(hubp, addr_mode);
-
-		//seems to be only for the MCM
-		dc_get_lut_format(mcm_luts->lut3d_data.gpu_mem_params.format_params.format, &format);
-		hubp->funcs->hubp_program_3dlut_fl_format(hubp, format);
-
-		mpc->funcs->rmcm.program_bias_scale(mpc,
-			mcm_luts->lut3d_data.gpu_mem_params.format_params.float_params.bias,
-			mcm_luts->lut3d_data.gpu_mem_params.format_params.float_params.scale,
-			mpcc_id);
-		hubp->funcs->hubp_update_3dlut_fl_bias_scale(hubp,
-					mcm_luts->lut3d_data.gpu_mem_params.format_params.float_params.bias,
-					mcm_luts->lut3d_data.gpu_mem_params.format_params.float_params.scale);
-
-		dc_get_lut_xbar(
-			mcm_luts->lut3d_data.gpu_mem_params.component_order,
-			&crossbar_bit_slice_cr_r,
-			&crossbar_bit_slice_y_g,
-			&crossbar_bit_slice_cb_b);
-
-		hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp,
-			crossbar_bit_slice_cr_r,
-			crossbar_bit_slice_y_g,
-			crossbar_bit_slice_cb_b);
-
-		mpc->funcs->rmcm.program_3dlut_size(mpc, width, mpcc_id);
-
-		mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, hubp->inst);
-
-		//2b. shaper reg programming
-		memset(&m_lut_params, 0, sizeof(m_lut_params));
-
-		if (mcm_luts->shaper->type == TF_TYPE_HWPWL) {
-			m_lut_params.pwl = &mcm_luts->shaper->pwl;
-		} else if (mcm_luts->shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			ASSERT(false);
-			cm_helper_translate_curve_to_hw_format(
-					dc->ctx,
-					mcm_luts->shaper,
-					&dpp_base->regamma_params, true);
-			m_lut_params.pwl = &dpp_base->regamma_params;
-		}
-		if (m_lut_params.pwl) {
-			mpc->funcs->rmcm.populate_lut(mpc, m_lut_params, lut_bank_a, mpcc_id);
-			mpc->funcs->rmcm.program_lut_mode(mpc, !bypass_rmcm_shaper, lut_bank_a, mpcc_id);
-		} else {
-			//RMCM 3dlut won't work without its shaper
-			return false;
-		}
-
-		//3. Select the hubp connected to this RMCM
-		hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
-		mpc->funcs->rmcm.enable_3dlut_fl(mpc, true, mpcc_id);
-
-		//4. power on the block
-		if (m_lut_params.pwl)
-			mpc->funcs->rmcm.power_on_shaper_3dlut(mpc, mpcc_id, true);
-
-		break;
-	default:
-		return false;
-	}
-
-	return true;
-}
-
 void dcn401_populate_mcm_luts(struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		struct dc_cm2_func_luts mcm_luts,
@@ -664,25 +423,6 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 
 	dcn401_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
 
-	//MCM - setting its location (Before/After) blender
-	//set to post blend (true)
-	dcn401_set_mcm_location_post_blend(
-		dc,
-		pipe_ctx,
-		mcm_luts.lut3d_data.mpc_mcm_post_blend);
-
-	//RMCM - 3dLUT+Shaper
-	if (mcm_luts.lut3d_data.rmcm_3dlut_enable) {
-		dcn401_program_rmcm_luts(
-			hubp,
-			pipe_ctx,
-			lut3d_src,
-			&mcm_luts,
-			mpc,
-			lut_bank_a,
-			mpcc_id);
-	}
-
 	/* 1D LUT */
 	if (mcm_luts.lut1d_func) {
 		memset(&m_lut_params, 0, sizeof(m_lut_params));
@@ -740,9 +480,6 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 		break;
 		case DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM:
 		switch (mcm_luts.lut3d_data.gpu_mem_params.size) {
-		case DC_CM2_GPU_MEM_SIZE_333333:
-			width = hubp_3dlut_fl_width_33;
-			break;
 		case DC_CM2_GPU_MEM_SIZE_171717:
 			width = hubp_3dlut_fl_width_17;
 			break;
@@ -817,11 +554,14 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 
 		//navi 4x has a bug and r and blue are swapped and need to be worked around here in
 		//TODO: need to make a method for get_xbar per asic OR do the workaround in program_crossbar for 4x
-		dc_get_lut_xbar(
-			mcm_luts.lut3d_data.gpu_mem_params.component_order,
-			&crossbar_bit_slice_cr_r,
-			&crossbar_bit_slice_y_g,
-			&crossbar_bit_slice_cb_b);
+		switch (mcm_luts.lut3d_data.gpu_mem_params.component_order) {
+		case DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_RGBA:
+		default:
+			crossbar_bit_slice_cr_r = hubp_3dlut_fl_crossbar_bit_slice_0_15;
+			crossbar_bit_slice_y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
+			crossbar_bit_slice_cb_b = hubp_3dlut_fl_crossbar_bit_slice_32_47;
+			break;
+		}
 
 		if (hubp->funcs->hubp_program_3dlut_fl_crossbar)
 			hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp,
@@ -2269,14 +2009,6 @@ void dcn401_program_pipe(
 		pipe_ctx->plane_state->update_flags.bits.hdr_mult))
 		hws->funcs.set_hdr_multiplier(pipe_ctx);
 
-	if (hws->funcs.populate_mcm_luts) {
-		if (pipe_ctx->plane_state) {
-			hws->funcs.populate_mcm_luts(dc, pipe_ctx, pipe_ctx->plane_state->mcm_luts,
-				pipe_ctx->plane_state->lut_bank_a);
-			pipe_ctx->plane_state->lut_bank_a = !pipe_ctx->plane_state->lut_bank_a;
-		}
-	}
-
 	if (pipe_ctx->plane_state &&
 		(pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
 			pipe_ctx->plane_state->update_flags.bits.gamma_change ||
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index ce65b4f6c672..781cf0efccc6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -109,12 +109,4 @@ void dcn401_detect_pipe_changes(
 void dcn401_plane_atomic_power_down(struct dc *dc,
 		struct dpp *dpp,
 		struct hubp *hubp);
-bool dcn401_program_rmcm_luts(
-	struct hubp *hubp,
-	struct pipe_ctx *pipe_ctx,
-	enum dc_cm2_transfer_func_source lut3d_src,
-	struct dc_cm2_func_luts *mcm_luts,
-	struct mpc *mpc,
-	bool lut_bank_a,
-	int mpcc_id);
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
index b4cea2b8cb2a..50ea62a009e8 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
@@ -30,7 +30,6 @@
 #include "basics/conversion.h"
 #include "dcn10/dcn10_cm_common.h"
 #include "dc.h"
-#include "dcn401/dcn401_mpc.h"
 
 #define REG(reg)\
 	mpc30->mpc_regs->reg
@@ -1022,8 +1021,6 @@ static const struct mpc_funcs dcn32_mpc_funcs = {
 	.power_on_mpc_mem_pwr = mpc3_power_on_ogam_lut,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
 	.set_bg_color = mpc1_set_bg_color,
-	.set_movable_cm_location = mpc401_set_movable_cm_location,
-	.populate_lut = mpc401_populate_lut,
 };
 
 
-- 
2.43.0

