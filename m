Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B934BC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA6F10E7D6;
	Wed,  1 May 2024 07:17:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sgAAeer9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9272510E7D6
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:17:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Izybu+M6x7qbUw5/0OrjCDp4NO0rMOL4MTQntSrGcn/qa8xXPvQbg0nPFSTfXVDkHW0cNjoh65TO9eLhU6OEQFL9xr9uA+fKHjXweM7euSYP0aqAYrsSEu+w83vEdECU9Awu6YHp9f67QkkckDNZVUiwqsYm7ic7e5U3P3C9uRtsbAGFQBG6m5UXwlV1+UBCcHb4ggsVy4xBAWVG+tognXJVx+GrzctMeEg5oSSuey0tgCQjH9SdLEcbt+8CAAfKF28g8HnGTDIfkghWBlUhUrzFHOpO7BYADPIhmUM6/XgRljTtUn3iH7tdwJL96RdijsJ9AGLC5VsH9v5YcHeABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pl+h1dJPqC+1Y8kKj0vOeVhry2ayk7Hz5gz3B49CKI=;
 b=lZmBKEu4xMZMNqt2ULIzr+5Ni/ma7uEeL35Bviy3xc2D/aw1LdUCNjwIqc2dqwKiqj+b4KMtmSgvs9iOqEtfnDsWgNcJyDReufhogHy3qt/1JxtGCc1yXgZ6/usveW0IdhPJfvRkdGKPxKaojSJbaM6TCJyPwjMgfaoI/OkIK9hlvnzThQCGYlSjxgld1BFDEq63bZBpKONAPGJWNm/Ix85emP2MuLBaMFrEWgqbqUBaCTSB+HcKLsqHxvpkwscjKTBk98XuezsyWkSNIC1+dnkgEjOaXmwkycm947xkBgxiFzUErax8vRBJF53RH+gN6Xwkdt8DRWgSesIFLTty2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pl+h1dJPqC+1Y8kKj0vOeVhry2ayk7Hz5gz3B49CKI=;
 b=sgAAeer9+4eEcbkkzKI8mULQvvDPnrkK+w30j+JlvUK5KdALZkXyxWE4yVIp+1oWCnV+x9XMPPmzNxpzMx6ECAE2homgI9dDP/cfdGAey4ksdUFExpaTmo98JIyVcLL/+rnpBLbmYcPfxpF9G3yyTYsvLlM5bBSrzZfwWsgluEk=
Received: from CH2PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:59::19)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 07:17:26 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::48) by CH2PR03CA0009.outlook.office365.com
 (2603:10b6:610:59::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Wed, 1 May 2024 07:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:17:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:25 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:17:22 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 07/45] drm/amd/display: Refactor input mode programming for
 DIG FIFO
Date: Wed, 1 May 2024 15:16:13 +0800
Message-ID: <20240501071651.3541919-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: b9df87ca-040e-467f-7169-08dc69aec112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+yBvFQJC/HwCmlK0Yyu5LO5Px0b+1X5X3pur90ejc4/WpnJFeUoC2NXViSHu?=
 =?us-ascii?Q?GAs1zSp5UfxkmPZVdwoE45xwzr0QgMnI9UTSRPfu7gWzUURJSDc5sThXpbqb?=
 =?us-ascii?Q?F3HzEjmjjr+XBjQQrUCErxvM0eFwK0ns8RMC4tIDdNI8NQrr0e9/yMGcgFDe?=
 =?us-ascii?Q?ooqLhOWvRlr/b47pD9iChCUNSpNGFh6dXkZJG5yvWekC3P7aKcI0k//EK9fQ?=
 =?us-ascii?Q?f+wYa6VHGFkPC2fv/WWLOmaaVeM3AjY41RqurrJXmrT/UkatJA0ssZM0m4rB?=
 =?us-ascii?Q?ts84SeD2w0tG4PC6us6PBMdjvt/9D4sYBxmBM36Pn6LTIxbRjjE12KqK7KZc?=
 =?us-ascii?Q?EBBWgG/6N/r5kHszqnJHeTu3UqvPgTYrremaB72Ul1QYV6Dx6pja30LwONyp?=
 =?us-ascii?Q?4FBdgUoUIGd5afJA9tOgO0xj4vGnXkl/pv50RdEXNecgHrVQMzvVs2YwMT/5?=
 =?us-ascii?Q?a0jxPzP33lw17brxymbjxiWEXFDo222OhiVR45RUrx9tMbgcUqcIegXBtqwA?=
 =?us-ascii?Q?XdbE7Z1Jx/D8DPnI7VK9yj2RD4X2xlo6epIvtzXVVaQEhMmxOCz+K6dVp87o?=
 =?us-ascii?Q?6XLpdOJKcuAEZc+C+yh+ATqvhgpyqqFSw3o8iMq7Z0LHfdtuGJrZFz7Ilu6q?=
 =?us-ascii?Q?d8xVfVKBML9qWauk88jn/h2lnDItuFGnQUdgu7ONvQjd75Fi2jCVD9vGERC5?=
 =?us-ascii?Q?mrdrsr69BpCrmGK7Kjf8mps9769p1R8qFp2kdBZYU/E2h3Mi3sU4OEJwP2G/?=
 =?us-ascii?Q?srUbk8JhC6GfgajeIqwEKcBnDEhNV+2szw4+0vg+7HrwxoInMNdUKSoBk4gZ?=
 =?us-ascii?Q?tajsRedYIF78ymNN2dOLFzn/+clkNtMhFuodX9B9ZDaCCaeI091OxOtjhEw4?=
 =?us-ascii?Q?KX4JTHrjLovKzGHjJ/83pTXGOESft2lB9G8mxHJ/7OKzx/uE+GYl1GHEDuDK?=
 =?us-ascii?Q?GeJ08YFkQsojnJv7EJ21PZQ/iN/5qGIbCpH3KUQzkeQjY3tgQzSaO9hOkIBB?=
 =?us-ascii?Q?hugpfgePYpNmvfetzAu0IDgngBaJzmwJ1sn5y4yhJ5PfbhjID6xUpRxiIWd4?=
 =?us-ascii?Q?80DiM+WTosds24Tnbf7Vtb0YScwa4aNxFw5zXYxflXUe02d3oYQp8nx7Abcu?=
 =?us-ascii?Q?q2BdeMxRjTBGbXv/Zo37C+9UPDFvqTs2d05OgqRhZXk1gh8mvEsmNpOI8i6T?=
 =?us-ascii?Q?9BGTE7NqgNV/KxXYPvAOyrqtOhoWTQWF5p+bRQlxyl6daLUYl7vnzRGakq/8?=
 =?us-ascii?Q?vBSaMDrM3ddwR+iZ4swiA4SqSkCNlgJUZAVnmeKoF5Caf06HDiF+GNCF7vge?=
 =?us-ascii?Q?nDjJr74zt0SJ+lgY15LI84hkiu7WleTMEUVPVpFsKY5SpHz6nn31Ke0+hKSN?=
 =?us-ascii?Q?vEGXQJ2xatqQlQuj62oA9YIp4rJr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:17:26.3580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9df87ca-040e-467f-7169-08dc69aec112
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY]
Input mode for the DIG FIFO should be programmed as part of stream
encoder setup.

[HOW]
Pre-calculate the pixels per cycle as part of the pixel clock params,
and program as part of stream encoder setup.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../dc/dcn401/dcn401_dio_stream_encoder.c     | 113 +++++++-----------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   3 -
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  17 ---
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   2 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 -
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  18 ---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   2 -
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  30 ++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   4 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   1 -
 .../gpu/drm/amd/display/dc/inc/clock_source.h |   1 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |   3 +
 .../dc/resource/dcn20/dcn20_resource.c        |   9 ++
 .../dc/resource/dcn401/dcn401_resource.c      |  18 ++-
 19 files changed, 103 insertions(+), 124 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
index be0ebb6a8a55..1c55ccede09b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
@@ -228,7 +228,27 @@ static void enc401_stream_encoder_hdmi_set_stream_attribute(
 	REG_UPDATE(HDMI_GC, HDMI_GC_AVMUTE, 0);
 }
 
+static void enc401_set_dig_input_mode(struct stream_encoder *enc, unsigned int pix_per_container)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
+	// The naming of this field is confusing, what it means is the output mode of otg, which
+	// is the input mode of the dig
+	switch (pix_per_container)	{
+	case 2:
+		REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_PER_CYCLE, 0x1);
+		break;
+	case 4:
+		REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_PER_CYCLE, 0x2);
+		break;
+	case 8:
+		REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_PER_CYCLE, 0x3);
+		break;
+	default:
+		REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_PER_CYCLE, 0x0);
+		break;
+	}
+}
 
 static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 {
@@ -239,68 +259,28 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 	return two_pix;
 }
 
-static bool is_h_timing_divisible_by_2(const struct dc_crtc_timing *timing)
-{
-	/* math borrowed from function of same name in inc/resource
-	 * checks if h_timing is divisible by 2
-	 */
-
-	bool divisible = false;
-	uint16_t h_blank_start = 0;
-	uint16_t h_blank_end = 0;
-
-	if (timing) {
-		h_blank_start = timing->h_total - timing->h_front_porch;
-		h_blank_end = h_blank_start - timing->h_addressable;
-
-		/* HTOTAL, Hblank start/end, and Hsync start/end all must be
-		 * divisible by 2 in order for the horizontal timing params
-		 * to be considered divisible by 2. Hsync start is always 0.
-		 */
-		divisible = (timing->h_total % 2 == 0) &&
-				(h_blank_start % 2 == 0) &&
-				(h_blank_end % 2 == 0) &&
-				(timing->h_sync_width % 2 == 0);
-	}
-	return divisible;
-}
-
-static bool is_dp_dig_pixel_rate_div_policy(struct dc *dc, const struct dc_crtc_timing *timing)
-{
-	/* should be functionally the same as dcn32_is_dp_dig_pixel_rate_div_policy for DP encoders*/
-	return is_h_timing_divisible_by_2(timing) &&
-		dc->debug.enable_dp_dig_pixel_rate_div_policy;
-}
-
 static void enc401_stream_encoder_dp_unblank(
 		struct dc_link *link,
 		struct stream_encoder *enc,
 		const struct encoder_unblank_param *param)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-	struct dc *dc = enc->ctx->dc;
 
 	if (param->link_settings.link_rate != LINK_RATE_UNKNOWN) {
 		uint32_t n_vid = 0x8000;
 		uint32_t m_vid;
-		uint32_t n_multiply = 0;
-		// TODO: Fix defined but not used
-		//uint32_t pix_per_cycle = 0;
+		uint32_t pix_per_container = 1;
 		uint64_t m_vid_l = n_vid;
 
-		/* YCbCr 4:2:0 : Computed VID_M will be 2X the input rate */
-		if (is_two_pixels_per_containter(&param->timing) || param->opp_cnt > 1
-			|| is_dp_dig_pixel_rate_div_policy(dc, &param->timing)) {
-			/*this logic should be the same in get_pixel_clock_parameters() */
-			n_multiply = 1;
-			// TODO: Fix defined but not used
-			//pix_per_cycle = 1;
+		/* YCbCr 4:2:0 or YCbCr4:2:2 simple + DSC: Computed VID_M will be 2X the input rate */
+		if (is_two_pixels_per_containter(&param->timing)) {
+			pix_per_container = 2;
 		}
+
 		/* M / N = Fstream / Flink
 		 * m_vid / n_vid = pixel rate / link rate
 		 */
-
-		m_vid_l *= param->timing.pix_clk_100hz / 10;
+		m_vid_l *= param->timing.pix_clk_100hz / pix_per_container / 10;
 		m_vid_l = div_u64(m_vid_l,
 			param->link_settings.link_rate
 				* LINK_RATE_REF_FREQ_IN_KHZ);
@@ -319,9 +299,23 @@ static void enc401_stream_encoder_dp_unblank(
 
 		REG_UPDATE(DP_VID_M, DP_VID_M, m_vid);
 
-		REG_UPDATE_2(DP_VID_TIMING,
-				DP_VID_M_N_GEN_EN, 1,
-				DP_VID_N_INTERVAL, n_multiply);
+		/* reduce jitter based on read rate */
+		switch (param->pix_per_cycle)	{
+		case 2:
+			REG_UPDATE(DP_VID_TIMING, DP_VID_N_INTERVAL, 0x1);
+			break;
+		case 4:
+			REG_UPDATE(DP_VID_TIMING, DP_VID_N_INTERVAL, 0x2);
+			break;
+		case 8:
+			REG_UPDATE(DP_VID_TIMING, DP_VID_N_INTERVAL, 0x3);
+			break;
+		default:
+			REG_UPDATE(DP_VID_TIMING, DP_VID_N_INTERVAL, 0x0);
+			break;
+		}
+
+		REG_UPDATE(DP_VID_TIMING, DP_VID_M_N_GEN_EN, 1);
 	}
 
 	/* make sure stream is disabled before resetting steer fifo */
@@ -413,27 +407,6 @@ static void enc401_read_state(struct stream_encoder *enc, struct enc_state *s)
 	}
 }
 
-static void enc401_set_dig_input_mode(struct stream_encoder *enc, unsigned int pix_per_container)
-{
-	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-
-	// The naming of this field is confusing, what it means is the output mode of otg, which
-	// is the input mode of the dig
-	switch (pix_per_container)	{
-	case 2:
-		REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_PER_CYCLE, 0x1);
-		break;
-	case 4:
-		REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_PER_CYCLE, 0x2);
-		break;
-	case 8:
-		REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_PER_CYCLE, 0x3);
-		break;
-	default:
-		REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_PER_CYCLE, 0x0);
-		break;
-	}
-}
 static void enc401_stream_encoder_enable(
 	struct stream_encoder *enc,
 	enum signal_type signal,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 2e8a30f5c3d1..5812b0938cd3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2959,9 +2959,6 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 		early_control = lane_count;
 
 	tg->funcs->set_early_control(tg, early_control);
-
-	if (dc->hwseq->funcs.set_pixels_per_cycle)
-		dc->hwseq->funcs.set_pixels_per_cycle(pipe_ctx);
 }
 
 void dcn20_program_dmdata_engine(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 0c994b5a48b1..0b12a69e2df0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -332,23 +332,6 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 	return odm_combine_factor;
 }
 
-void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
-{
-	uint32_t pix_per_cycle = 1;
-	uint32_t odm_combine_factor = 1;
-
-	if (!pipe_ctx || !pipe_ctx->stream || !pipe_ctx->stream_res.stream_enc)
-		return;
-
-	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
-	if (pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&pipe_ctx->stream->timing) || odm_combine_factor > 1)
-		pix_per_cycle = 2;
-
-	if (pipe_ctx->stream_res.stream_enc->funcs->set_input_mode)
-		pipe_ctx->stream_res.stream_enc->funcs->set_input_mode(pipe_ctx->stream_res.stream_enc,
-				pix_per_cycle);
-}
-
 void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context)
 {
 	unsigned int i;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
index eafcc4ea6d24..f4613d96e013 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
@@ -39,8 +39,6 @@ void dcn314_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
 
 unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
-void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
-
 void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
 
 void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 29b56736fa84..9c46b6a7b4dc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -152,7 +152,6 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn314_calculate_dccg_k1_k2_values,
-	.set_pixels_per_cycle = dcn314_set_pixels_per_cycle,
 	.resync_fifo_dccg_dio = dcn314_resync_fifo_dccg_dio,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 4302f9be1a7d..901e3b531a12 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1173,24 +1173,6 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	return odm_combine_factor;
 }
 
-void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
-{
-	uint32_t pix_per_cycle = 1;
-	uint32_t odm_combine_factor = 1;
-
-	if (!pipe_ctx || !pipe_ctx->stream || !pipe_ctx->stream_res.stream_enc)
-		return;
-
-	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
-	if (pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&pipe_ctx->stream->timing) || odm_combine_factor > 1
-		|| dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
-		pix_per_cycle = 2;
-
-	if (pipe_ctx->stream_res.stream_enc->funcs->set_input_mode)
-		pipe_ctx->stream_res.stream_enc->funcs->set_input_mode(pipe_ctx->stream_res.stream_enc,
-				pix_per_cycle);
-}
-
 void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context)
 {
 	unsigned int i;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index f55c11fc56ec..c510f3a652ad 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -73,8 +73,6 @@ void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 
 unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
-void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx);
-
 void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
 
 void dcn32_subvp_pipe_control_lock(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index b1f79ca7d77a..10d2ae99c118 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -158,7 +158,6 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.update_force_pstate = dcn32_update_force_pstate,
 	.update_mall_sel = dcn32_update_mall_sel,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
-	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 	.resync_fifo_dccg_dio = dcn32_resync_fifo_dccg_dio,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 8e5b87798192..663bacd1fafd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -159,7 +159,6 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.set_mcm_luts = dcn32_set_mcm_luts,
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
-	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 	.resync_fifo_dccg_dio = dcn314_resync_fifo_dccg_dio,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
 	.dsc_pg_control = dcn35_dsc_pg_control,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 701b66634e2d..d8de1c6a84e8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -158,7 +158,6 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.set_mcm_luts = dcn32_set_mcm_luts,
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
-	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
 	.dsc_pg_control = dcn35_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 8ce4f46b302b..ba9c27e05787 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -976,9 +976,6 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 		dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME);
 
 	tg->funcs->set_early_control(tg, early_control);
-
-	if (dc->hwseq->funcs.set_pixels_per_cycle)
-		dc->hwseq->funcs.set_pixels_per_cycle(pipe_ctx);
 }
 
 void dcn401_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable)
@@ -1543,3 +1540,30 @@ void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool en
 
 	dc_dmub_srv_fams2_update_config(dc, context, enable && fams2_required);
 }
+
+void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx,
+		struct dc_link_settings *link_settings)
+{
+	struct encoder_unblank_param params = {0};
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	struct dce_hwseq *hws = link->dc->hwseq;
+
+	/* calculate parameters for unblank */
+	params.opp_cnt = resource_get_odm_slice_count(pipe_ctx);
+
+	params.timing = pipe_ctx->stream->timing;
+	params.link_settings.link_rate = link_settings->link_rate;
+	params.pix_per_cycle = pipe_ctx->stream_res.pix_clk_params.dio_se_pix_per_cycle;
+
+	if (link->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_unblank(
+				pipe_ctx->stream_res.hpo_dp_stream_enc,
+				pipe_ctx->stream_res.tg->inst);
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
+	}
+
+	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP)
+		hws->funcs.edp_backlight_control(link, true);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index e70ac1f6e68b..16084ae1d31d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -72,5 +72,6 @@ void dcn401_fams2_global_control_lock(struct dc *dc,
 		bool lock);
 void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool enable);
 void dcn401_fams2_global_control_lock_fast(union block_sequence_params *params);
+void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx, struct dc_link_settings *link_settings);
 
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index c051c1cd0665..56c4b28c1f2e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -31,7 +31,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn401_enable_stream,
 	.disable_stream = dce110_disable_stream,
-	.unblank_stream = dcn32_unblank_stream,
+	.unblank_stream = dcn401_unblank_stream,
 	.blank_stream = dce110_blank_stream,
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
@@ -137,8 +137,6 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.update_mall_sel = dcn32_update_mall_sel,
 	.setup_hpo_hw_control = dcn401_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = NULL,
-	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
-	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
 	.populate_mcm_luts = dcn401_populate_mcm_luts,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 7bfb4fb50dad..7ac3f2a09487 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -169,7 +169,6 @@ struct hwseq_private_funcs {
 	unsigned int (*calculate_dccg_k1_k2_values)(struct pipe_ctx *pipe_ctx,
 			unsigned int *k1_div,
 			unsigned int *k2_div);
-	void (*set_pixels_per_cycle)(struct pipe_ctx *pipe_ctx);
 	void (*resync_fifo_dccg_dio)(struct dce_hwseq *hws, struct dc *dc,
 			struct dc_state *context);
 	enum dc_status (*apply_single_controller_ctx_to_hw)(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/clock_source.h b/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
index 8f8ac8e29ed0..ed2f8005d85e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
@@ -96,6 +96,7 @@ struct pixel_clk_params {
 /*> de-spread info, relevant only for on-the-fly tune-up pixel rate*/
 	enum dc_pixel_encoding pixel_encoding;
 	struct pixel_clk_flags flags;
+	uint32_t dio_se_pix_per_cycle;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 75b9ec21f297..60228f5de4d7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -99,6 +99,7 @@ struct encoder_unblank_param {
 	struct dc_link_settings link_settings;
 	struct dc_crtc_timing timing;
 	int opp_cnt;
+	uint32_t pix_per_cycle;
 };
 
 struct encoder_set_dp_phy_pattern_param {
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index 1328a0ade342..16412094c612 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -49,6 +49,9 @@ void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 	if (stream_enc->funcs->map_stream_to_link)
 		stream_enc->funcs->map_stream_to_link(stream_enc,
 				stream_enc->stream_enc_inst, link_enc->transmitter - TRANSMITTER_UNIPHY_A);
+	if (stream_enc->funcs->set_input_mode)
+		stream_enc->funcs->set_input_mode(stream_enc,
+				pipe_ctx->stream_res.pix_clk_params.dio_se_pix_per_cycle);
 	if (stream_enc->funcs->enable_fifo)
 		stream_enc->funcs->enable_fifo(stream_enc);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index cf0929b8bec0..c78675f8be8a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1261,6 +1261,15 @@ static void get_pixel_clock_parameters(
 	if (stream->timing.timing_3d_format == TIMING_3D_FORMAT_HW_FRAME_PACKING)
 		pixel_clk_params->requested_pix_clk_100hz *= 2;
 
+	if ((pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container &&
+			pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&pipe_ctx->stream->timing)) ||
+			(hws->funcs.is_dp_dig_pixel_rate_div_policy &&
+			hws->funcs.is_dp_dig_pixel_rate_div_policy(pipe_ctx)) ||
+			opp_cnt > 1) {
+		pixel_clk_params->dio_se_pix_per_cycle = 2;
+	} else {
+		pixel_clk_params->dio_se_pix_per_cycle = 1;
+	}
 }
 
 static void build_clamping_params(struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index ac93c8b9361b..c244262800e1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1643,7 +1643,6 @@ static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 	if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422)
 		pixel_clk_params->color_depth = COLOR_DEPTH_888;
 
-	/* TODO: Do we still need this? */
 	if (stream->timing.timing_3d_format == TIMING_3D_FORMAT_HW_FRAME_PACKING)
 		pixel_clk_params->requested_pix_clk_100hz *= 2;
 	if (dc_is_tmds_signal(stream->signal) &&
@@ -1654,6 +1653,23 @@ static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 			pipe_ctx->clock_source,
 			&pipe_ctx->stream_res.pix_clk_params,
 			&pipe_ctx->pll_settings);
+
+	pixel_clk_params->dio_se_pix_per_cycle = 1;
+	if (dc_is_tmds_signal(stream->signal) &&
+			stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+		pixel_clk_params->dio_se_pix_per_cycle = 2;
+	} else if (dc_is_dp_signal(stream->signal)) {
+		/* round up to nearest power of 2, or max at 8 pixels per cycle */
+		if (pixel_clk_params->requested_pix_clk_100hz > 4 * stream->ctx->dc->clk_mgr->dprefclk_khz * 10) {
+			pixel_clk_params->dio_se_pix_per_cycle = 8;
+		} else if (pixel_clk_params->requested_pix_clk_100hz > 2 * stream->ctx->dc->clk_mgr->dprefclk_khz * 10) {
+			pixel_clk_params->dio_se_pix_per_cycle = 4;
+		} else if (pixel_clk_params->requested_pix_clk_100hz > stream->ctx->dc->clk_mgr->dprefclk_khz * 10) {
+			pixel_clk_params->dio_se_pix_per_cycle = 2;
+		} else {
+			pixel_clk_params->dio_se_pix_per_cycle = 1;
+		}
+	}
 }
 
 static struct resource_funcs dcn401_res_pool_funcs = {
-- 
2.34.1

