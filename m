Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC05FC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1913910E9B1;
	Wed, 28 Sep 2022 19:41:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C1CC10E9B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I//vWle/7dksZxMzCCRCmBmnSPpb1pyFhauzPeaPspTOag/nLq4X+N3w5KCCw4ujNRymM8vd3qr3WBKRuA24BH/ErtlKk30QzwgnKSf72ORmV1ImLWrM0M9f/G5Qz6PqqEjE57EsSLKf0CSBCt2p8wfTOyJoGvul6oqxoICjboPoctYSjDdPS1aSMPJrNAJh8bs9e3OKQiFUIWOuWjoaAZLU4BP/l3OoJ2Mh+liw2I5Nm3qQwbAGom56YrftOLN/n+sGFsP0DSB6HArrug1KwJRG2HIU7/PCAbBTXDqe5YsturdinEWO8nNaP683jRN2pof2Ddv7c7dtG3+eke7kPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfHZ89g9uw/1qhZ2Gegyqlwg5zKtf4YV9/7T9hAUENg=;
 b=hhXrfIP2VO68ejkJmariYbWjC4g6SC8wcn0awG6iYZlkmI8bq7A+4jKt4qhVmuLmX7B3rfW5A038bpYe5crsiNMbCAlNS7RQqb/DE5XuGsSMhOpYChtK3IK/M3B0owPSxZyZv5XtLlVq962YauwCjFRcwn1RHDr9sfyJbrOS1wZ09/wAjk1fsOQMZt9Jsg7K9RzAakLW8LT5xZR8GNbIURGqEc5Hyo8ioUWV5KMNulFgZXV17xIryE5HrivtVm8k7nbkXYpvOcMK5jVu3IUWjoddTgKviyrSIComgl7XbTOtcUD1aKaTXulU5qMHMoANrKMf5CnzOsZ6aPyeWiwLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfHZ89g9uw/1qhZ2Gegyqlwg5zKtf4YV9/7T9hAUENg=;
 b=NEaGJaWHpn5liSscoxrnc5Aki/A0VGs4Ao9umCfM49HMvaB0BAjSmTKuDnGPj6IKRFSVd18hPzr6Y9o6Q7fmKx2d53kIShjnRnPiwPpax4oIZk2l0ob4vjsnpcsDDTlpAAa7gpAA7FPjKBMaFsJJPEFUCnd4kJejpRzdqftGAe8=
Received: from BN9PR03CA0541.namprd03.prod.outlook.com (2603:10b6:408:138::6)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 28 Sep
 2022 19:41:23 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::88) by BN9PR03CA0541.outlook.office365.com
 (2603:10b6:408:138::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:23 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:21 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/36] drm/amd/display: block odd h_total timings from halving
 pixel rate
Date: Wed, 28 Sep 2022 15:40:13 -0400
Message-ID: <20220928194028.144879-22-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|PH7PR12MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e012ed-01b3-48e4-8aa7-08daa1896cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y62S6sY/t1vBh65SLWXL1H+yeVjgp5g2r7Lxm7E+O3qXbwKT8npUi+KXePsik8JnhrpmAlMwGJOLf1t37k4zHzuau7pF5I6o+PVN8OCgCSDnAQhmMlE5bAjR2e3llhOA6NAvfF2aDbAfe5WkJ9TkhabizJhKgdh/cq80tnpCEOqG8XheGir2x8j4hk0DPE8X5T/OpH0bLIx6Umm9S9mzVhM8BTbMwfqzWtDc7QxOKDbfNuuivp4NBwNLqxLMM6uUuunvlbpSbO1sKSNpkZRDsLmpsUc3PcRmnq8S5txAzmgZfzM8CDpQBSJYDhlFstU29fj4mtMqxzkz9y+2Yls2ZThuPbaiXaWjd/ZoE7HER63MKNktUvNItYADKQxQf1ZDab81qchr77rlEVEUWgGJZX0PPRMpGta97/vqPpWSQ0eK2DYC1bo577HGaQ7t2gb2Js21fWaZV4efStKKJGdf9Xw7Oj3gvfDFXnZ9TN2HuL19JoDMiM2VdxGznoD8HVFVOpP9tS7/nEID9v8/xYKMRoXpbI5s39QFNt4L0yiwR6zskWuOCY2drT80qahE1SlTGwL7Rd/0kbrB6cCjSQPU2gg9tfP5r3e/2u+NZDyIYVaC74iL9rJ02Q1Z2pA1HrYQrC9J9Un01ccTVLnhw7GWprH82Syi+MKSzeApcZL3wJHRa3dKuTENFjj4CUi7U4XF+xqicYZm6kiIwpxhk0VMWdVGjJomeZMN8XSmGjHgAG5pUhJnqPUE+VRdZ9rl+8HjJ6gUj4vn+/1CvhIl2nxPA2Kv5iZDvQn4ruEVYgNVrWbiXQkgPffO3fTo4meQcys/P6RK6dVrKmuMMrsHjsbCyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(1076003)(316002)(86362001)(2616005)(16526019)(82740400003)(8936002)(356005)(336012)(36860700001)(186003)(54906003)(81166007)(70206006)(426003)(40480700001)(4326008)(44832011)(70586007)(82310400005)(40460700003)(478600001)(2906002)(41300700001)(26005)(5660300002)(8676002)(47076005)(7696005)(6916009)(6666004)(83380400001)(36756003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:23.1560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e012ed-01b3-48e4-8aa7-08daa1896cac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211
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
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

why:
when dynamic odm was turned on, there is also logic to halve the pixelclk
this still turned on when we avoided odm in the case of odd h_total timings

how:
block the pixel clk mechanism also in the case of odd h_total timings

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 .../dc/dcn32/dcn32_dio_stream_encoder.c       | 35 ++++++++++++++++++-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  9 ++---
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index 0e9dce414641..3195be9d38f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -243,6 +243,39 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 	return two_pix;
 }
 
+static bool is_h_timing_divisible_by_2(const struct dc_crtc_timing *timing)
+{
+	/* math borrowed from function of same name in inc/resource
+	 * checks if h_timing is divisible by 2
+	 */
+
+	bool divisible = false;
+	uint16_t h_blank_start = 0;
+	uint16_t h_blank_end = 0;
+
+	if (timing) {
+		h_blank_start = timing->h_total - timing->h_front_porch;
+		h_blank_end = h_blank_start - timing->h_addressable;
+
+		/* HTOTAL, Hblank start/end, and Hsync start/end all must be
+		 * divisible by 2 in order for the horizontal timing params
+		 * to be considered divisible by 2. Hsync start is always 0.
+		 */
+		divisible = (timing->h_total % 2 == 0) &&
+				(h_blank_start % 2 == 0) &&
+				(h_blank_end % 2 == 0) &&
+				(timing->h_sync_width % 2 == 0);
+	}
+	return divisible;
+}
+
+static bool is_dp_dig_pixel_rate_div_policy(struct dc *dc, const struct dc_crtc_timing *timing)
+{
+	/* should be functionally the same as dcn32_is_dp_dig_pixel_rate_div_policy for DP encoders*/
+	return is_h_timing_divisible_by_2(timing) &&
+		dc->debug.enable_dp_dig_pixel_rate_div_policy;
+}
+
 static void enc32_stream_encoder_dp_unblank(
         struct dc_link *link,
 		struct stream_encoder *enc,
@@ -259,7 +292,7 @@ static void enc32_stream_encoder_dp_unblank(
 
 		/* YCbCr 4:2:0 : Computed VID_M will be 2X the input rate */
 		if (is_two_pixels_per_containter(&param->timing) || param->opp_cnt > 1
-			|| dc->debug.enable_dp_dig_pixel_rate_div_policy) {
+			|| is_dp_dig_pixel_rate_div_policy(dc, &param->timing)) {
 			/*this logic should be the same in get_pixel_clock_parameters() */
 			n_multiply = 1;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index a750343ca521..8012a48859b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1161,7 +1161,6 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	unsigned int odm_combine_factor = 0;
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	bool two_pix_per_container = false;
 
 	// For phantom pipes, use the same programming as the main pipes
@@ -1189,7 +1188,7 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 		} else {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-			if ((odm_combine_factor == 2) || dc->debug.enable_dp_dig_pixel_rate_div_policy)
+			if ((odm_combine_factor == 2) || dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
 				*k2_div = PIXEL_RATE_DIV_BY_2;
 		}
 	}
@@ -1226,7 +1225,6 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 	struct dc_link *link = stream->link;
 	struct dce_hwseq *hws = link->dc->hwseq;
 	struct pipe_ctx *odm_pipe;
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	uint32_t pix_per_cycle = 1;
 
 	params.opp_cnt = 1;
@@ -1245,7 +1243,7 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 				pipe_ctx->stream_res.tg->inst);
 	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
 		if (optc2_is_two_pixels_per_containter(&stream->timing) || params.opp_cnt > 1
-			|| dc->debug.enable_dp_dig_pixel_rate_div_policy) {
+			|| dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx)) {
 			params.timing.pix_clk_100hz /= 2;
 			pix_per_cycle = 2;
 		}
@@ -1262,6 +1260,9 @@ bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx)
 {
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 
+	if (!is_h_timing_divisible_by_2(pipe_ctx->stream))
+		return false;
+
 	if (dc_is_dp_signal(pipe_ctx->stream->signal) && !is_dp_128b_132b_signal(pipe_ctx) &&
 		dc->debug.enable_dp_dig_pixel_rate_div_policy)
 		return true;
-- 
2.37.2

