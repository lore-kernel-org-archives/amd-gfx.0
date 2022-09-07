Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA40BC6FA86
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 17:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA3310E802;
	Wed,  7 Sep 2022 17:33:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DF310E800
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 17:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEWVBIBQz4J5cKUjOYm7xyGk0wF9DOcJNd1k1yItsF4N/EMdGZydw1DlrR/ZQ8fCKIS8t4J4NJHu3c8M7omTDIFUP6II/Hvti2cFbHh1PkGzHyMwXELGJQT7ffReABhc6X1caVGItXVq8HyO+3pbj9SJlXvBsDB2Y354cKhU83VZ7oBYyXDm6HrY/1bitgkYY4ExLPawtU0wVWMdq3wFzrd0RGYrJh8ffLT446tdOzkE5+jkuND2xHCQAwiURGPOhclsgiRIUZvqydzlbolpmbTSXTaCOvhRrDHSmT08p6qT9Zpzro/EKObANHAgkvqanMvJoaZZ1g2R2Mb/YwksQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KghQVoiWqBU14h+rZ9TJezz30Vc1wCD+rkECKPG3ZEA=;
 b=CZayB14vgZxd1MYEsqHsIiBct6S+CY8fSbinU/dHzA6K5FIO5ZOroqUoUKHrCAd9c6y7VNAqNWakUS2BipB3qHGAIYObJ1WDtc1urnLDg5BlpcITR0Oh0ibaWg+jxzt4hV4KZwNGh34uFzlxxq9xMpKl0egGUgWwmqpdT1vtSOQnrp91D7tSmtjbjxyeZkbnhW6icvbM//Vf8KsNBWfcvchiqCkJfcRWii/3Jr6hQgjr4dpFvXdHs2pY5/Td24R6Mz39J+pYAISdgMCvBaJV5wLvNnGONz63pxxeyfMp5U6NMzw59UqEDFJpL1HS8w4+fgsJlnGa33QkBOSlM6W8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KghQVoiWqBU14h+rZ9TJezz30Vc1wCD+rkECKPG3ZEA=;
 b=dGFCJKI3enTSDUSelOSidDvl29CZUzITDc5/4Cjg+7wdSvMEcTlz5nqYuLIey/04MFUPirDD76ZDNvGPgJP2yY0YLrSgggZxBI+m7MFy9i9v9m1YIOmWKaZlup8y98i5hsu8F9gG59g2tHjyBU5YUaEeDJQB0Ax3noI8PFZBQko=
Received: from BN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:ee::18)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Wed, 7 Sep
 2022 17:33:23 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::f0) by BN0PR04CA0013.outlook.office365.com
 (2603:10b6:408:ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 17:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 17:33:22 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 12:33:21 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/27] drm/amd/display: Update MBLK calculation for SubVP
Date: Wed, 7 Sep 2022 13:32:10 -0400
Message-ID: <20220907173232.11755-6-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907173232.11755-1-pavle.kotarac@amd.com>
References: <20220907173232.11755-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f12adb-8e7f-4891-80ea-08da90f70fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/75JMp/9dUlgNWRCXJ81ssrZxlQunNFbwVcF3dHbkQk3hw5efHJUyh9xOGlOsdqS2GqtcaiHMAWD3Q0QRQXTgH5efH3Wb4SFeXndgBPXBwDz7wrFF36WZirxmuLwp/ZyXYgBZdlI4TAr7TK7SKLkcbTxdDuf5vOOvH5BWhRSAkcqnMxMtAGqtmWFVxKJ8HiZIsC69lfQgLNCIymQOGmfAYMo9d3ehkMxVk8LtePriWroDArdcsi2KJTV0Fd91JmHt/w2uBNvcwypW4E99+m6wOZpgMjY28upGfXnVjRSJabFE7axoB20QQ2+wqHV+aTRXk6b5k0+BvPvkTMGW0br5ZOx/cxx6ODHYyruENeBx65+fVuvwCcPVx1kXOBNcECN7bWJKdYwNzIVYg+5qpdaMzpPySsZEQ/V9jhKBSUqMKVnYh6uepsTyAEKjtWjPvHif5laR7aPgrNkvYLujfhpC4gHhWyPN/lMaCOJ9E3aXC3/ymzLBxFQ0yJeujMFeqA/5ID8ItkqwieWUlx4x48hwCUs/wq7P8gtcp84FtDF5ulXpWqDfcdqPXT9YbwDmj/kT9Ustdk4/4vFNifc4kEw7XmF4SKc8sfznFEmGgWEqw3n7tLZyjrKo5Cq9agK/54ZrWmYKisK/aMCoTVv6qK4CJiSDYNDFdpG5gwgUh2FIywgF2NKgzeUwgA7SeMDlfVqx3B9dJwhUt0K+jeG70EqJOss5rJAw7BPm3ki+eAoeBqVGVFofb34OZGJApT36jYLTVdRfBiblylAhrNvAeRJFqqkj3jUdr24eNmkbUZDtP0PgQLYtYvumAjGzltuIOL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(40470700004)(40460700003)(36860700001)(356005)(83380400001)(82740400003)(81166007)(70586007)(70206006)(316002)(6916009)(54906003)(8676002)(186003)(8936002)(4326008)(5660300002)(44832011)(2616005)(40480700001)(336012)(2906002)(47076005)(426003)(26005)(1076003)(16526019)(15650500001)(36756003)(6666004)(478600001)(7696005)(86362001)(82310400005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:33:22.4175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f12adb-8e7f-4891-80ea-08da90f70fee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, "Lee,
 Alvin" <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lee, Alvin" <Alvin.Lee2@amd.com>

[Description]
Update MBLK calculation according to hardware doc.
For DCC case we were not allocation enough MALL
due to an inaccurate MBLK calculation.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  3 +
 .../display/dc/dcn32/dcn32_resource_helpers.c | 59 ++++++++++++++++---
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index dbcdf8607ee9..d1e85622dd3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -30,6 +30,9 @@
 
 #define DCN3_2_DET_SEG_SIZE 64
 #define DCN3_2_MALL_MBLK_SIZE_BYTES 65536 // 64 * 1024
+#define DCN3_2_MBLK_WIDTH 128
+#define DCN3_2_MBLK_HEIGHT_4BPE 128
+#define DCN3_2_MBLK_HEIGHT_8BPE 64
 
 #define TO_DCN32_RES_POOL(pool)\
 	container_of(pool, struct dcn32_resource_pool, base)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index ab918fe38f6a..1f195c5b3377 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -46,7 +46,6 @@
 uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_state *context)
 {
 	uint32_t num_ways = 0;
-	uint32_t mall_region_pixels = 0;
 	uint32_t bytes_per_pixel = 0;
 	uint32_t cache_lines_used = 0;
 	uint32_t lines_per_way = 0;
@@ -54,20 +53,64 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 	uint32_t bytes_in_mall = 0;
 	uint32_t num_mblks = 0;
 	uint32_t cache_lines_per_plane = 0;
-	uint32_t i = 0;
+	uint32_t i = 0, j = 0;
+	uint32_t mblk_width = 0;
+	uint32_t mblk_height = 0;
+	uint32_t full_vp_width_blk_aligned = 0;
+	uint32_t full_vp_height_blk_aligned = 0;
+	uint32_t mall_alloc_width_blk_aligned = 0;
+	uint32_t mall_alloc_height_blk_aligned = 0;
+	uint32_t full_vp_height = 0;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		// Find the phantom pipes
-		if (pipe->stream && pipe->plane_state && !pipe->top_pipe &&
+		if (pipe->stream && pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe &&
 				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
-			bytes_per_pixel = pipe->plane_state->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4;
-			mall_region_pixels = pipe->plane_state->plane_size.surface_pitch * pipe->stream->timing.v_addressable;
+			struct pipe_ctx *main_pipe = NULL;
+
+			/* Get full viewport height from main pipe (required for MBLK calculation) */
+			for (j = 0; j < dc->res_pool->pipe_count; j++) {
+				main_pipe = &context->res_ctx.pipe_ctx[j];
+				if (main_pipe->stream == pipe->stream->mall_stream_config.paired_stream) {
+					full_vp_height = main_pipe->plane_res.scl_data.viewport.height;
+					break;
+				}
+			}
 
-			// For bytes required in MALL, calculate based on number of MBlks required
-			num_mblks = (mall_region_pixels * bytes_per_pixel +
-					DCN3_2_MALL_MBLK_SIZE_BYTES - 1) / DCN3_2_MALL_MBLK_SIZE_BYTES;
+			bytes_per_pixel = pipe->plane_state->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4;
+			mblk_width = DCN3_2_MBLK_WIDTH;
+			mblk_height = bytes_per_pixel == 4 ? DCN3_2_MBLK_HEIGHT_4BPE : DCN3_2_MBLK_HEIGHT_8BPE;
+
+			/* full_vp_width_blk_aligned = FLOOR(vp_x_start + full_vp_width + blk_width - 1, blk_width) -
+			 * FLOOR(vp_x_start, blk_width)
+			 */
+			full_vp_width_blk_aligned = ((pipe->plane_res.scl_data.viewport.x +
+					pipe->plane_res.scl_data.viewport.width + mblk_width - 1) / mblk_width * mblk_width) +
+					(pipe->plane_res.scl_data.viewport.x / mblk_width * mblk_width);
+
+			/* full_vp_height_blk_aligned = FLOOR(vp_y_start + full_vp_height + blk_height - 1, blk_height) -
+			 * FLOOR(vp_y_start, blk_height)
+			 */
+			full_vp_height_blk_aligned = ((pipe->plane_res.scl_data.viewport.y +
+					full_vp_height + mblk_height - 1) / mblk_height * mblk_height) +
+					(pipe->plane_res.scl_data.viewport.y / mblk_height * mblk_height);
+
+			/* mall_alloc_width_blk_aligned_l/c = full_vp_width_blk_aligned_l/c */
+			mall_alloc_width_blk_aligned = full_vp_width_blk_aligned;
+
+			/* mall_alloc_height_blk_aligned_l/c = CEILING(sub_vp_height_l/c - 1, blk_height_l/c) + blk_height_l/c */
+			mall_alloc_height_blk_aligned = (pipe->stream->timing.v_addressable - 1 + mblk_height - 1) /
+					mblk_height * mblk_height + mblk_height;
+
+			/* full_mblk_width_ub_l/c = mall_alloc_width_blk_aligned_l/c;
+			 * full_mblk_height_ub_l/c = mall_alloc_height_blk_aligned_l/c;
+			 * num_mblk_l/c = (full_mblk_width_ub_l/c / mblk_width_l/c) * (full_mblk_height_ub_l/c / mblk_height_l/c);
+			 * (Should be divisible, but round up if not)
+			 */
+			num_mblks = ((mall_alloc_width_blk_aligned + mblk_width - 1) / mblk_width) *
+					((mall_alloc_height_blk_aligned + mblk_height - 1) / mblk_height);
 			bytes_in_mall = num_mblks * DCN3_2_MALL_MBLK_SIZE_BYTES;
 			// cache lines used is total bytes / cache_line size. Add +2 for worst case alignment
 			// (MALL is 64-byte aligned)
-- 
2.34.1

