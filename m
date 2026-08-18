Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3466AC5DF85
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6A710EC9C;
	Tue, 18 Aug 2026 20:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbEwldWv";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B0810EC9D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffdPY6PGew/k6KLrqLwDXeOhUenjRqSz2w0odpoB+cQhkxtGT26F9WrWAb2RWWuOXsrgjoEhF3AMJfSdvt6dbdI3EixR5iS2k25sOD25Humlr2CSQa2bNkRFcqSOJdVLuma9sRL92cS6o80h4r50p4yagFloD5WbAywD0JhKPzFgkV61a8wWOeHa0c/ySiQ3w+jHrMLApheRhWBy3WX8VBz2uKVjoa5r5UG/hA9t2Uq9vRrLQwTA0yynDQntfgPh/YNMSsq2X5eEjMI3Q/BkMPIorTD658z8REgwhn55d5jo1XAEHhMjWej5S3Rvurf8QQsXC+w49YqWGrChmOuA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDzSKHnvhKDC1Y8wlvV20OJ5WNZarFBTNCiPXfhPCGY=;
 b=t4fMBt0ifKdKulV0nNBmS16bldKMkWdKPiMVxYHdcagmJK/QMNl8E7SmMth4BftXhefKPEY9k48ap3LMSimP7vmsHsIHAILTGsojvfKkPkwrAprpStW7nBt3vh11l/cqnAUWvWKAr3wyWaK2VqGzUA9uxw/eEPFaZAYqVs31jK4dBMWw8aHUcsW5GgotmDeGtHME714KlRwnm1KRpQ8TQo7ffwdPDfnhIanNX2a2yZGK56qnWKl8yQy7c4E1rFbtASvr52DiiTa/mK81hXYjAjfpxNf7LjBRaW5QN7OtrY1MplJwfDyXjlwownaa/zj/h4py0y/1fut0rVh2mSVZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDzSKHnvhKDC1Y8wlvV20OJ5WNZarFBTNCiPXfhPCGY=;
 b=bbEwldWvd4G9Rcj6hwE7J7TffoW+FyFRhElu5OvK3eRPUOfktTG3QYI4Wcooz+pPKDlxtz8vqlJBonBB6hvPStrd/CuLe3w9I4UBZeW5NrCTKflElI5giOB4ovQ6yWuBcfQ+sRA5cwcyH5ZPGSfL8C8qAy6l+H02NyZsoLXKchc=
Received: from BN9PR03CA0880.namprd03.prod.outlook.com (2603:10b6:408:13c::15)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:25 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::43) by BN9PR03CA0880.outlook.office365.com
 (2603:10b6:408:13c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:15 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:15 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 31/82] drm/amd/display: Update alt-ch size calculations
Date: Tue, 18 Aug 2026 16:15:23 -0400
Message-ID: <20260818202139.4172592-32-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eef025c-24b9-4b1c-b476-08defd666aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|20052099010|56012099006|22082099003|3023799007|6133799003|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: erjErrOPAuGef8tK+j+bZKEdZ/L0VJt0EabkdfaVlfGK8aVu+jkfymwHiG0bZrqN24852pECQiE66uTk/78vfmfcZEPqSm/RuBpvITNieTXKlGDVSoMDf4OJgBlTJo7xZqVshi4X90Lt90hLjNwoNRg1wz18MW+S7EkPpxCwQkeVaa3iPnn4gplEud//PcXEL8IDU/OJ0ujk6e7OcbsaQ+ZEKyjftWtJzN9zb6xwv+QomX4WTauNvTBxctUgKubjxG4SNl2Xy54QTI0J0lNR1j6hP+PBNYPRfwWLO5mM9K+43uwuA93rmhDUdZGqg3Ngl8VjuOFUOKBUHcBal1xqxYUh66Gt/NnorXWDCjnmVDM34ZEt0o+GxPplIVy1vbG76MuoKh4MCKaEcwxjzaho78/Ps9ZY5HSf4BThv7yLBAgJy6bivCww2+VujkJ6EVJB8HBMFYH/kexRwVNzenaGsQZTjjsGIppDxeZg9CT7MUU5W1n64jgYLBsxy8elYopXzsosRB69oxFz17KPeEnQrHIIHk9t7szgxQ0cLuh2os+KBsaP2nO0I41+i90BGp9XrEmMf5KZI2a0aLbiAyOJ9xddRFOJrUAJpeV/2eCWcsxLhD9WXenz2SmWV0oV8OJe7szTC6Rq0+eAIqp/tFGs9wBkejCA45ut/6FTFJ8AM7s6ekaVmHEbbO7dYoqSvGXZZ3bPa9xhoyIc5NSSSPljHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(20052099010)(56012099006)(22082099003)(3023799007)(6133799003)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: irPjea3kFn2SmOrnBByjDSYzuYwm661vvK0j+uASu+hXcQhn7TdPBxQp5JUaa5n/Qz7KWE8CKGLIxRj2KDFZndVC4vo4V+0mjOlKX3RlmFbMd9AFhMJxCIvMoDwosEwaKB5OLOmzsmU+paRszo6tMODdNls7cORs66wMn72hvtQxXnvoKhkdM86J2tzbG0vehBq1ANjq0+63ta53RB84LpanNNdi6ajRvLMjBUMIOpIL7OQ1KKYxlC6dRVWWTyOlN3xgz0gC5DgEoUwr0hSTt9b73cSD0KinfCiUprw7Kg7BuOOod8vF2F2B+EKvMNvTiThgaz2CehBWDMA+DDJatNFIU9odky57AKxbh6QCfgEYUNBa8w4ttO2FE1mOr4BU72JVmyE5S8Qvfbtz53tQ9IyDM+1dyvmZGMfBVBh4MOtOs99UeaUAX1qsoAcgN0/T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:25.0912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eef025c-24b9-4b1c-b476-08defd666aad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
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
- Align calculation with addrlib (need to align to macro tiled
  widht/height)
- Align the copy size / addr to 256KB for SW_256KB modes

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c | 15 +++---
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    | 47 +++++++++++++------
 .../dml2_core_dcn6_funcs_mode_support.c       |  3 ++
 .../src/dml2_core/dml2_core_shared_types.h    |  2 +
 4 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index 1ade48b8b621a..125ca619c8abb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -375,11 +375,12 @@ void dml21_handle_phantom_streams_planes(const struct dc *dc, struct dc_state *c
 		dml2_map_dc_pipes(dml_ctx, context, NULL, &dml_ctx->v21.dml_to_dc_pipe_mapping, dc->current_state);
 }
 
-static uint32_t calc_svp_size_64kb(uint32_t total_size_bytes)
+static uint32_t calc_svp_size_256kb(uint64_t addr_bytes)
 {
-	return (total_size_bytes + 0xFFFF) >> 16;
+    return (uint32_t)(((addr_bytes + 0x3FFFFull) >> 18) << 2); // ceil to 256KB, then return bits [47:16]
 }
 
+
 static unsigned int dml21_build_fams2_stream_programming_v3(const struct dc *dc,
 		struct dc_state *context,
 		struct dml2_context *dml_ctx)
@@ -387,7 +388,7 @@ static unsigned int dml21_build_fams2_stream_programming_v3(const struct dc *dc,
 	int dml_stream_idx, dc_stream_idx, dc_plane_idx, svp_idx;
 	unsigned int dc_pipe_idx;
 	unsigned int num_fams2_streams = 0;
-	unsigned int svp_size_64kb[2] = {0};
+	unsigned int svp_size_256kb[2] = {0};
 	struct pipe_ctx *pipe;
 
 	for (dc_stream_idx = 0; dc_stream_idx < context->stream_count; dc_stream_idx++) {
@@ -477,12 +478,12 @@ static unsigned int dml21_build_fams2_stream_programming_v3(const struct dc *dc,
 					}
 					for (svp_idx = 0; svp_idx < 2; svp_idx++) {
 						alternate_static_state->pipe_copy_addr_47_16[svp_idx][dc_pipe_idx] =
-								dml_ctx->config.alt_ch_cfg.region_base_addr_47_16[svp_idx] + svp_size_64kb[svp_idx];
-						svp_size_64kb[svp_idx] += calc_svp_size_64kb(alternate_static_state->pipe_copy_max_size[svp_idx][dc_plane_idx]);
+								dml_ctx->config.alt_ch_cfg.region_base_addr_47_16[svp_idx] + svp_size_256kb[svp_idx];
+						svp_size_256kb[svp_idx] += calc_svp_size_256kb(alternate_static_state->pipe_copy_max_size[svp_idx][dc_plane_idx]);
 						if (alternate_static_state->config[dc_plane_idx].bits.is_multi_planar) {
 							alternate_static_state->pipe_copy_addr_47_16_c[svp_idx][dc_pipe_idx] =
-									dml_ctx->config.alt_ch_cfg.region_base_addr_47_16[svp_idx] + svp_size_64kb[svp_idx];
-							svp_size_64kb[svp_idx] += calc_svp_size_64kb(alternate_static_state->pipe_copy_max_size_c[svp_idx][dc_plane_idx]);
+									dml_ctx->config.alt_ch_cfg.region_base_addr_47_16[svp_idx] + svp_size_256kb[svp_idx];
+							svp_size_256kb[svp_idx] += calc_svp_size_256kb(alternate_static_state->pipe_copy_max_size_c[svp_idx][dc_plane_idx]);
 						}
 					}
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
index cae6bee93fe30..83fada0608724 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
@@ -203,14 +203,32 @@ static unsigned int calculate_copy_swaths(double pre_first_hdl,
 	return num_swaths;
 }
 
+/**
+  * *******************************************************************************************************************************************************
+  * calculate_tile_aligned_size: Applies tiled-surface padding / alignment rules to an unaligned copy region
+  *
+  * Given the unaligned copy region dimensions (copy_width in pixels, copy_height in lines) and the plane's macro tile
+  * (swizzle block) dimensions, this returns the number of bytes reserved for the region following addrlib sizing rules:
+  * - The pitch is padded up to the macro tile width and the height is padded up to the macro tile height.
+  *   size = alignedPitch * alignedHeight * bpp, which is inherently macro-tile (block) aligned
+  * - The final ceil2 to 256 is a harmless floor for degenerate tile sizes.
+  *
+  * *******************************************************************************************************************************************************
+  */
+static unsigned int calculate_tile_aligned_size(unsigned int copy_width, unsigned int copy_height, unsigned int tile_width, unsigned int tile_height, unsigned int byte_per_pixel)
+{
+	unsigned int mem_width = (unsigned int)math_ceil2(copy_width, tile_width);
+	unsigned int mem_height = (unsigned int)math_ceil2(copy_height, tile_height);
+
+	return (unsigned int)math_ceil2(mem_width * mem_height * byte_per_pixel, 256);
+}
+
  /**
   * *******************************************************************************************************************************************************
   * calculate_max_mem_size_per_plane_per_dpp: Calculate (loose) upper bound for total number of bytes reserved in memory for the copy given number of swaths
   *
   * - The copy width / height is the min of the vp_width/height and maximum number of pixels that can fit across an ODM slice
   *     - This is to account for recout positions that cross the ODM seam but are "mostly" within the same ODM slice
-  * - For mem width assume an extra block width and tile width is required (the memory reserved must take into account pitch which must be tiled aligned)
-  * - For mem height assumes two extra block heights are required
   *
   * *******************************************************************************************************************************************************
   */
@@ -222,12 +240,11 @@ static unsigned int calculate_max_mem_size_per_plane_per_dpp(const struct dml2_c
 	unsigned int copy_src_lines = copy_swaths * (chroma ? p->SwathHeightC[plane_idx] : p->SwathHeightY[plane_idx]);
 	unsigned int vp_width = chroma ? p->display_cfg->plane_descriptors[plane_idx].composition.viewport.plane1.width : p->display_cfg->plane_descriptors[plane_idx].composition.viewport.plane0.width;
 	unsigned int vp_height = chroma ? p->display_cfg->plane_descriptors[plane_idx].composition.viewport.plane1.height : p->display_cfg->plane_descriptors[plane_idx].composition.viewport.plane0.height;
-	unsigned int block256_width = chroma ? p->Read256BlockWidthC[plane_idx] : p->Read256BlockWidthY[plane_idx];
-	unsigned int block256_height = chroma ? p->Read256BlockHeightC[plane_idx] : p->Read256BlockHeightY[plane_idx];
 	unsigned int tile_width = chroma ? p->MacroTileWidthC[plane_idx] : p->MacroTileWidthY[plane_idx];
+	unsigned int tile_height = chroma ? p->MacroTileHeightC[plane_idx] : p->MacroTileHeightY[plane_idx];
 	unsigned int byte_per_pixel = chroma ? p->BytePerPixelC[plane_idx] : p->BytePerPixelY[plane_idx];
-	unsigned int mem_width;
-	unsigned int mem_height;
+	unsigned int copy_width;
+	unsigned int copy_height;
 	unsigned int odm_combine_factor;
 	double odm_slice_pixels;
 
@@ -241,12 +258,14 @@ static unsigned int calculate_max_mem_size_per_plane_per_dpp(const struct dml2_c
 		odm_combine_factor = 1;
 
 	odm_slice_pixels = (double)h_active / odm_combine_factor * h_ratio + (odm_combine_factor == 3 ? 2 : 0);
-	mem_width = (vertical_access ? copy_src_lines : (unsigned int)math_ceil(math_min2(odm_slice_pixels, vp_width))) + block256_width + tile_width;
-	mem_height = (vertical_access ? (unsigned int)math_ceil(math_min2(odm_slice_pixels, vp_height)) : copy_src_lines) + 2 * block256_height;
 
-	return (unsigned int)math_ceil2(mem_width * mem_height * byte_per_pixel, 256);
-}
+	/* Unaligned copy region dimensions (in pixels / lines) prior to tile alignment.
+	 * Also divide vp_widht/height by NoOfDPP for MPC combine scenarios (i.e., MPC split within an ODM slice). */
+	copy_width = vertical_access ? copy_src_lines : (unsigned int)math_ceil(math_min2(odm_slice_pixels, vp_width / p->NoOfDPP[plane_idx]));
+	copy_height = vertical_access ? (unsigned int)math_ceil(math_min2(odm_slice_pixels, vp_height / p->NoOfDPP[plane_idx])) : copy_src_lines;
 
+	return calculate_tile_aligned_size(copy_width, copy_height, tile_width, tile_height, byte_per_pixel);
+}
  /**
   * ****************************************************************************************************************************************
   * calculate_ub_copy_size_per_plane_per_dpp: Calculate tight upper bound for total number of bytes required for the copy given number of swaths.
@@ -422,9 +441,9 @@ static void calculate_swath_params(const struct dml2_core_calcs_calculate_altern
 	out->prefetch_hdl_delta = (double)swath_height / vratio_pre;
 }
 
-static unsigned int calc_svp_size_64kb_aligned(unsigned int total_size_bytes)
+static unsigned int calc_svp_size_256kb_aligned(unsigned int total_size_bytes)
 {
-	return ((total_size_bytes + 0xFFFF) >> 16) << 16; // Round up to nearest 64KB boundary
+	return ((total_size_bytes + 0x3FFFFu) >> 18) << 18; // Round up to nearest 256KB boundary
 }
 
 void dcn6_calculate_alternate_params(struct dml2_core_calcs_calculate_alternate_params *p)
@@ -471,7 +490,7 @@ void dcn6_calculate_alternate_params(struct dml2_core_calcs_calculate_alternate_
 				p->prefetch_hdl_delta[j] = swath_params.prefetch_hdl_delta;
 				for (k = 0; k < 2; k++) {
 					svp_max_bytes_per_dpp[k] = calculate_ub_copy_size_per_plane_per_dpp_per_svp(p, svp_dst_lines[k], j, false);
-					svp_max_bytes[k] += calc_svp_size_64kb_aligned(svp_max_bytes_per_dpp[k]) * p->NoOfDPP[j];
+					svp_max_bytes[k] += calc_svp_size_256kb_aligned(svp_max_bytes_per_dpp[k]) * p->NoOfDPP[j];
 				}
 				p->svp0_max_bytes_per_dpp[j] = svp_max_bytes_per_dpp[0];
 				p->svp1_max_bytes_per_dpp[j] = svp_max_bytes_per_dpp[1];
@@ -485,7 +504,7 @@ void dcn6_calculate_alternate_params(struct dml2_core_calcs_calculate_alternate_
 
 					for (k = 0; k < 2; k++) {
 						svp_max_bytes_per_dpp[k] = calculate_ub_copy_size_per_plane_per_dpp_per_svp(p, svp_dst_lines[k], j, true);
-						svp_max_bytes[k] += calc_svp_size_64kb_aligned(svp_max_bytes_per_dpp[k]) * p->NoOfDPP[j];
+						svp_max_bytes[k] += calc_svp_size_256kb_aligned(svp_max_bytes_per_dpp[k]) * p->NoOfDPP[j];
 					}
 					p->svp0_max_bytes_per_dpp_c[j] = svp_max_bytes_per_dpp[0];
 					p->svp1_max_bytes_per_dpp_c[j] = svp_max_bytes_per_dpp[1];
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index cb3cff316b0e8..01bbf4aacbe3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -2246,6 +2246,8 @@ static void dcn6_ms_calculate_alternate_params(const struct dml2_core_calculate_
 	p->Read256BlockHeightC = inputs->Read256BlockHeightC;
 	p->MacroTileWidthY = inputs->MacroTileWidthY;
 	p->MacroTileWidthC = inputs->MacroTileWidthC;
+	p->MacroTileHeightY = inputs->MacroTileHeightY;
+	p->MacroTileHeightC = inputs->MacroTileHeightC;
 	p->VInitPrefillY = inputs->PrefillY;
 	p->VInitPrefillC = inputs->PrefillC;
 	p->VRatioPrefetchY = inputs->VRatioPreY;
@@ -2316,6 +2318,7 @@ static void dcn6_ms_calculate_alternate_svp_lines(const struct dml2_core_calcula
 	struct dml2_core_internal_mode_support *outputs = states;
 
 	DML_LOG_FUNC_ENTER();
+
 	p->display_cfg = ctx->display_cfg;
 	p->SwathHeightY = inputs->SwathHeightY;
 	p->SwathHeightC = inputs->SwathHeightC;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 55118fd484ce8..36250f3d83aaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -2300,6 +2300,8 @@ struct dml2_core_calcs_calculate_alternate_params {
 	unsigned int *Read256BlockHeightC;
 	unsigned int *MacroTileWidthY;
 	unsigned int *MacroTileWidthC;
+	unsigned int *MacroTileHeightY;
+	unsigned int *MacroTileHeightC;
 	unsigned int *VInitPrefillY;
 	unsigned int *VInitPrefillC;
 	double *VRatioPrefetchY;
-- 
2.43.0

