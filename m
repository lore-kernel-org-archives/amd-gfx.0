Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2508AC6FA90
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06CB810EA05;
	Thu, 22 Sep 2022 00:19:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC16910E9E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvJnPBTSP58as9ruAlhbCqQgiGm1Fgh1CxJPtBiMZCQzhcPCkGdEb6Snb0k08w9+b++ocLVzPsp31GUq1aN8Fdd3hL6H4euEYrhmKMNnQS2R08puTCUbblSQbP+MaoG7OjOUIcXQQeCpogIqWwpM43/ddDq8sS3oIaStYvGyPxOk9ERgCqP3qEmga/XD2OCYAH8kA79i0+ichkWyJsluR2p8Y4GhvELv7pcii704NWlnhRXyR0jJU0TSkNtJckzBa69/fSCqk0Ju+UXRZQedTNfhuRs0g/dG+bWC/rsSERNum4lmYxftSLrj10PwbzShGXavFQpqUVWYJRep8LDzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgUjNfa/DolPVAbwKhiK3ThcSSqKruZ3HK+/FTijP8g=;
 b=Bf6gaV4acJlegf/xRsYdd6lp+ZlJhG/mSp//IdYQt/KF7kgswvAto0AYvn352Riy8q4uytPG+yvJZClhYJMiVoLWEviKOZjTK9F4nMTs+QJVjtMSVqEXlTIRchcR8aMCzihrc140eZWwDNh8g79BAKUKsHC3mCCBXnlHOXBdN4TVW30iyzbs4bgWtQKDlLLLdD47rzKdWrogeGgyqDO5hN3p/8XRnIpF1TsV0UUm3PKd5zICld+bS2qWIJaLX8yPVZ2k81JaRy/6zhr/oAGgW68gSA4vKz9xHV7Cg3kpbd/Q8W8Noz4JsfLoLpjRFqKnWhvmiK0TMWYTMJoPlzul6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgUjNfa/DolPVAbwKhiK3ThcSSqKruZ3HK+/FTijP8g=;
 b=bpjjcEHZmD0qahv8BkQZjndIK15WB9K0qS+8EuJp0k4qLFc6R41w1V1kO0l6PYDtiZY2/TB15n5lKlFxAMt8z5rNM4kxODFx6Fm+okr8984Vt+hHZi6WllyBgIuPaIFrU13iCotZCxhcoYeyWfNzHrewGjC0lDhg9eDxWGwb52I=
Received: from BN9PR03CA0566.namprd03.prod.outlook.com (2603:10b6:408:138::31)
 by SJ0PR12MB5486.namprd12.prod.outlook.com (2603:10b6:a03:3bb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 00:19:05 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::7a) by BN9PR03CA0566.outlook.office365.com
 (2603:10b6:408:138::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:05 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:01 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/31] drm/amd/display: Update MALL SS NumWays calculation
Date: Wed, 21 Sep 2022 20:18:02 -0400
Message-ID: <20220922001821.320255-13-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT061:EE_|SJ0PR12MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fdc70b-1273-489e-f845-08da9c300f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDcOYrwTjzvG0W3wz03BhmMZCwNVPTf4U86Cwdn91rkgh2cVm+E09p1HpzLr1hLu4Qx9bgA0Vf2BA0xrwtwtEnLJwJfdvgKpnMeDTB9UxJh/lMijAerOkM//6QEDwNIErN8YV9LhHL20N3H8muWqetMWOZutdV0vSUiP6ILfTjisHkZ+UotvzrC15H2jWXy4GX7TcemGDQUiUZTfhSIqe14wEu2EwO3DEvIHJHWCtNMSGslb0R1cG3Qn/rwtdc9iq1HZaQRtip/4QFrjPvrMNV5mwY7yWUGynZJs7rv1eHWtA6cCkmnd/a/tkKt+NohgMZeZluptmXWSErXEx/CqGcDnneshnHpUelastvDTk43ZHfvGnG/1h2d3ONostTdo2J3IGgS8TOwnqM+RnkEWhbbyQD/5g1l/3Cw/1+b69biiyqN+vFXYP6NuJhjrwEejCEcjc5cGESex3Mb+9/SlOjlBC52G8tI9h6NdQJ/8sidhQamsyqJ9axczLFJjPADCcwjYNz2wED5uxR9LE+1uKyegUOgQlCMNA5GM6N2/dPsvJKFRU5NTmthkByA61dXTqw2j4Bs7fxBjv9NUwyuERE2s/xPJL35aIrlCDgaFwyykP/i69UbT4Li8aChjSqljuqpK+MJPAT/Y23+1eMlvlb5zHOjtIqFAUnoDvPb8zeBBv8MzPiTaLNaXlaLs9JFarrMXEJHYGRaCXR8qZn4SW/si6y6h8+s+fOwgxBjcl+BBa6IFMIzvIILNgOCyoArMPXAkgPpmHmBCp15lbkuRsSaor5CpLpjhQc5F/sb7JzApBSkxr4sxdebFzvhz9mIJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(2616005)(1076003)(426003)(336012)(83380400001)(47076005)(70206006)(41300700001)(70586007)(26005)(36860700001)(5660300002)(30864003)(2906002)(82310400005)(316002)(54906003)(36756003)(4326008)(40460700003)(356005)(478600001)(16526019)(186003)(40480700001)(82740400003)(6916009)(81166007)(15650500001)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:05.6138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fdc70b-1273-489e-f845-08da9c300f63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5486
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Update MALL SS NumWays calculation according
to programming guide.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 206 ++++++++----------
 2 files changed, 97 insertions(+), 110 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index bbc352b18bf4..30274e8a6d23 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -832,6 +832,7 @@ struct dc_debug_options {
 	bool force_subvp_mclk_switch;
 	bool allow_sw_cursor_fallback;
 	unsigned int force_subvp_num_ways;
+	unsigned int force_mall_ss_num_ways;
 	bool alloc_extra_way_for_cursor;
 	bool force_usr_allow;
 	/* uses value at boot and disables switch */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 6baea56f259c..ab47475c18ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -49,6 +49,7 @@
 #include "dcn20/dcn20_optc.h"
 #include "dmub_subvp_state.h"
 #include "dce/dmub_hw_lock_mgr.h"
+#include "dcn32_resource.h"
 #include "dc_link_dp.h"
 #include "dmub/inc/dmub_subvp_state.h"
 
@@ -198,42 +199,6 @@ static bool dcn32_check_no_memory_request_for_cab(struct dc *dc)
 	return false;
 }
 
-/* This function takes in the start address and surface size to be cached in CAB
- * and calculates the total number of cache lines required to store the surface.
- * The number of cache lines used for each surface is calculated independently of
- * one another. For example, if there is a primary surface(1), meta surface(2), and
- * cursor(3), this function should be called 3 times to calculate the number of cache
- * lines used for each of those surfaces.
- */
-static uint32_t dcn32_cache_lines_for_surface(struct dc *dc, uint32_t surface_size, uint64_t start_address)
-{
-	uint32_t lines_used = 1;
-	uint32_t num_cached_bytes = 0;
-	uint32_t remaining_size = 0;
-	uint32_t cache_line_size = dc->caps.cache_line_size;
-	uint32_t remainder = 0;
-
-	/* 1. Calculate surface size minus the number of bytes stored
-	 * in the first cache line (all bytes in first cache line might
-	 * not be fully used).
-	 */
-	div_u64_rem(start_address, cache_line_size, &remainder);
-	num_cached_bytes = cache_line_size - remainder;
-	remaining_size = surface_size - num_cached_bytes;
-
-	/* 2. Calculate number of cache lines that will be fully used with
-	 * the remaining number of bytes to be stored.
-	 */
-	lines_used += (remaining_size / cache_line_size);
-
-	/* 3. Check if we need an extra line due to the remaining size not being
-	 * a multiple of CACHE_LINE_SIZE.
-	 */
-	if (remaining_size % cache_line_size > 0)
-		lines_used++;
-
-	return lines_used;
-}
 
 /* This function loops through every surface that needs to be cached in CAB for SS,
  * and calculates the total number of ways required to store all surfaces (primary,
@@ -241,96 +206,115 @@ static uint32_t dcn32_cache_lines_for_surface(struct dc *dc, uint32_t surface_si
  */
 static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *ctx)
 {
-	uint8_t i, j;
+	uint8_t i; 
+	int j;
 	struct dc_stream_state *stream = NULL;
 	struct dc_plane_state *plane = NULL;
-	uint32_t surface_size = 0;
 	uint32_t cursor_size = 0;
-	uint32_t cache_lines_used = 0;
 	uint32_t total_lines = 0;
 	uint32_t lines_per_way = 0;
-	uint32_t num_ways = 0;
-	uint32_t prev_addr_low = 0;
+	uint8_t num_ways = 0;
+	uint8_t bytes_per_pixel = 0;
+	uint8_t cursor_bpp = 0;
+	uint16_t mblk_width = 0;
+	uint16_t mblk_height = 0;
+	uint16_t mall_alloc_width_blk_aligned = 0;
+	uint16_t mall_alloc_height_blk_aligned = 0;
+	uint16_t num_mblks = 0;
+	uint32_t bytes_in_mall = 0;
+	uint32_t cache_lines_per_plane = 0;
 
-	for (i = 0; i < ctx->stream_count; i++) {
-		stream = ctx->streams[i];
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
-		// Don't include PSR surface in the total surface size for CAB allocation
-		if (stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED)
+		if (!pipe->stream || !pipe->plane_state ||
+				pipe->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED ||
+				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM)
 			continue;
 
-		if (ctx->stream_status[i].plane_count == 0)
-			continue;
+		bytes_per_pixel = pipe->plane_state->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4;
+		mblk_width = DCN3_2_MBLK_WIDTH;
+		mblk_height = bytes_per_pixel == 4 ? DCN3_2_MBLK_HEIGHT_4BPE : DCN3_2_MBLK_HEIGHT_8BPE;
 
-		// For each stream, loop through each plane to calculate the number of cache
-		// lines required to store the surface in CAB
-		for (j = 0; j < ctx->stream_status[i].plane_count; j++) {
-			plane = ctx->stream_status[i].plane_states[j];
+		/* full_vp_width_blk_aligned = FLOOR(vp_x_start + full_vp_width + blk_width - 1, blk_width) -
+		 * FLOOR(vp_x_start, blk_width)
+		 *
+		 * mall_alloc_width_blk_aligned_l/c = full_vp_width_blk_aligned_l/c
+		 */
+		mall_alloc_width_blk_aligned = ((pipe->plane_res.scl_data.viewport.x +
+				pipe->plane_res.scl_data.viewport.width + mblk_width - 1) / mblk_width * mblk_width) +
+						(pipe->plane_res.scl_data.viewport.x / mblk_width * mblk_width);
+
+		/* full_vp_height_blk_aligned = FLOOR(vp_y_start + full_vp_height + blk_height - 1, blk_height) -
+		 * FLOOR(vp_y_start, blk_height)
+		 *
+		 * mall_alloc_height_blk_aligned_l/c = full_vp_height_blk_aligned_l/c
+		 */
+		mall_alloc_height_blk_aligned = ((pipe->plane_res.scl_data.viewport.y +
+				pipe->plane_res.scl_data.viewport.height + mblk_height - 1) / mblk_height * mblk_height) +
+						(pipe->plane_res.scl_data.viewport.y / mblk_height * mblk_height);
 
-			// Calculate total surface size
-			if (prev_addr_low != plane->address.grph.addr.u.low_part) {
-				/* if plane address are different from prev FB, then userspace allocated separate FBs*/
-				surface_size += plane->plane_size.surface_pitch *
-					plane->plane_size.surface_size.height *
-					(plane->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4);
+		num_mblks = ((mall_alloc_width_blk_aligned + mblk_width - 1) / mblk_width) *
+				((mall_alloc_height_blk_aligned + mblk_height - 1) / mblk_height);
 
-				prev_addr_low = plane->address.grph.addr.u.low_part;
-			} else {
-				/* We have the same fb for all the planes.
-				 * Xorg always creates one giant fb that holds all surfaces,
-				 * so allocating it once is sufficient.
-				 * */
-				continue;
-			}
-			// Convert surface size + starting address to number of cache lines required
-			// (alignment accounted for)
-			cache_lines_used += dcn32_cache_lines_for_surface(dc, surface_size,
-					plane->address.grph.addr.quad_part);
-
-			if (plane->address.grph.meta_addr.quad_part) {
-				// Meta surface
-				cache_lines_used += dcn32_cache_lines_for_surface(dc, surface_size,
-						plane->address.grph.meta_addr.quad_part);
-			}
-		}
+		/* For DCC:
+		 * meta_num_mblk = CEILING(full_mblk_width_ub_l*full_mblk_height_ub_l*Bpe/256/mblk_bytes, 1)
+		 */
+		if (pipe->plane_state->dcc.enable)
+			num_mblks += (mall_alloc_width_blk_aligned * mall_alloc_width_blk_aligned * bytes_per_pixel +
+					(256 * DCN3_2_MALL_MBLK_SIZE_BYTES) - 1) / (256 * DCN3_2_MALL_MBLK_SIZE_BYTES);
 
-		// Include cursor size for CAB allocation
-		for (j = 0; j < dc->res_pool->pipe_count; j++) {
-			struct pipe_ctx *pipe = &ctx->res_ctx.pipe_ctx[j];
-			struct hubp *hubp = pipe->plane_res.hubp;
+		bytes_in_mall = num_mblks * DCN3_2_MALL_MBLK_SIZE_BYTES;
 
-			if (pipe->stream && pipe->plane_state && hubp)
-				/* Find the cursor plane and use the exact size instead of
-				 * using the max for calculation
-				 */
-				if (hubp->curs_attr.width > 0) {
-					// Round cursor width to next multiple of 64
-					cursor_size = (((hubp->curs_attr.width + 63) / 64) * 64) * hubp->curs_attr.height;
-					break;
-				}
-		}
+		/* (cache lines used is total bytes / cache_line size. Add +2 for worst case alignment
+		 * (MALL is 64-byte aligned)
+		 */
+		cache_lines_per_plane = bytes_in_mall / dc->caps.cache_line_size + 2;
+		cache_lines_used += cache_lines_per_plane;
+	}
 
-		switch (stream->cursor_attributes.color_format) {
-		case CURSOR_MODE_MONO:
-			cursor_size /= 2;
-			break;
-		case CURSOR_MODE_COLOR_1BIT_AND:
-		case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
-		case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
-			cursor_size *= 4;
-			break;
+	// Include cursor size for CAB allocation
+	for (j = 0; j < dc->res_pool->pipe_count; j++) {
+		struct pipe_ctx *pipe = &ctx->res_ctx.pipe_ctx[j];
+		struct hubp *hubp = pipe->plane_res.hubp;
 
-		case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
-		case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
-			cursor_size *= 8;
-			break;
-		}
+		if (pipe->stream && pipe->plane_state && hubp)
+			/* Find the cursor plane and use the exact size instead of
+			using the max for calculation */
 
-		if (stream->cursor_position.enable && !dc->debug.alloc_extra_way_for_cursor &&
-				cursor_size > 16384) {
-			cache_lines_used += dcn32_cache_lines_for_surface(dc, cursor_size,
-					plane->address.grph.cursor_cache_addr.quad_part);
-		}
+		if (hubp->curs_attr.width > 0) {
+				// Round cursor width to next multiple of 64
+				cursor_size = (((hubp->curs_attr.width + 63) / 64) * 64) * hubp->curs_attr.height;
+
+				switch (pipe->stream->cursor_attributes.color_format) {
+				case CURSOR_MODE_MONO:
+					cursor_size /= 2;
+					cursor_bpp = 4;
+					break;
+				case CURSOR_MODE_COLOR_1BIT_AND:
+				case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
+				case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
+					cursor_size *= 4;
+					cursor_bpp = 4;
+					break;
+
+				case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
+				case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
+					cursor_size *= 8;
+					cursor_bpp = 8;
+					break;
+				}
+
+				if (pipe->stream->cursor_position.enable && !dc->debug.alloc_extra_way_for_cursor &&
+						cursor_size > 16384) {
+					/* cursor_num_mblk = CEILING(num_cursors*cursor_width*cursor_width*cursor_Bpe/mblk_bytes, 1)
+					 */
+					cache_lines_used += (((hubp->curs_attr.width * hubp->curs_attr.height * cursor_bpp +
+										DCN3_2_MALL_MBLK_SIZE_BYTES - 1) / DCN3_2_MALL_MBLK_SIZE_BYTES) *
+										DCN3_2_MALL_MBLK_SIZE_BYTES) / dc->caps.cache_line_size + 2;
+				}
+				break;
+			}
 	}
 
 	// Convert number of cache lines required to number of ways
@@ -360,7 +344,9 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 			}
 		}
 	}
-
+	if (dc->debug.force_mall_ss_num_ways > 0) {
+		num_ways = dc->debug.force_mall_ss_num_ways;
+	}
 	return num_ways;
 }
 
-- 
2.25.1

