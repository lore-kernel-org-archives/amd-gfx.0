Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDB1C4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3960710E6A9;
	Wed, 10 Jan 2024 21:57:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12F110E6A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4xxrmzlbKoTkTJAK5OvFH4beI3uqL9DyOU2EuIlUUOdqBTQRVGcq0SmpioR+K/eMzF4guVoiSoUyj5WiWPUYUBewwGWQE/AIyk8h5ZDAd9xw05HIj+ZI/7ol+spoWhhEAbouWX5Rrb5hZZlkTGYLn7sgq6xxKbAwVQlyskcWfFtnnAm5YLYHvH8fOzp+v6r0y/EvPyGsc46s5Yf2Y17gOl4wmrV1Cc7xUJOOSFbBYRWQfu/RPnZUN8xcZCkD6dr2L529IMuDWS1D8SsuF7zPagNCwE03yAWXCZnEnGhfho/4WpXMiJY5XcnvPRTiRRfEVDuTA5zwGK4+T+6N0Zokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgVzS9B6T5KnoDpwi9P/hsLrjYclkS8nDUj5RTaE71c=;
 b=OTdixDtydZsDiREEKWwPXMU5Mo05lLpJ5qAeYa/hnYS3IKKf8BTweQcyjq5lUQ/3WKf8e8/qCvo14tWI+yAkSmEyYJxVcUbi+FE/u3Fj7ZRs5CHuCuJzjuEHrcA/ndD4GI82bSuGXBG6UjWeGQiMCTBMmrIec5DXJf5LYxbAPLtROXozcJR48a7CTBnriQ1JTmn6nz/pNnz98UFpST0dfhr130vwV1bq7VmcKyEJF0lj8Eu+nr94J4LZ8f3Q038FO3R2mkVlVAgyeAQsQaVVjqYZB/1goDezQQnPtJ4x9cFJly5eZj9XZovRINRhxwVTEdQC8pux2h8lgxFHddV7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgVzS9B6T5KnoDpwi9P/hsLrjYclkS8nDUj5RTaE71c=;
 b=F0jRTVcEzHdZQK6EhGmXCeepKEjmSJ1Gs5QPfMyoyV+vJRmrh5+bwfWmRxbg8o8eWSJtxGhVm9H22p0auDCACRCsaRSPdcFFwB6aJhclN7D9/ISxAHLoevp05v1c1vSYBKcaCL0ZkchxPDw6qXy4DStAzSpP3Yc3E0wAEPEre6A=
Received: from SJ0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:33a::30)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Wed, 10 Jan
 2024 21:57:07 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::bf) by SJ0PR03CA0025.outlook.office365.com
 (2603:10b6:a03:33a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 21:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 21:57:06 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:57:03 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/19] drm/amd/display: Add DP audio BW validation
Date: Wed, 10 Jan 2024 14:52:56 -0700
Message-ID: <20240110215302.2116049-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: e30aea91-8f7f-4847-3eb9-08dc1227162f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6llrYP/KDVkNeC1FPMEYHc+/wA8+D9mydefGZmlUSRyUMZolHb/WdY150s6MINzVSzeQkGInKVzHpY3W4NdEjnHfaS8Ajfo6Rj+fLIy2qos0lnj4l8WElEbTTvt7i61p/MP0DMl7uSiO1kUufCqvNZda5WNF4jzHR557CoXrePz2W8FuveozUDgdMvP3y2QRPVkHriLzMwhNETfwRY3K2Le31MSpRAfsxAkR8UMFC0XkBsYAMhA8C0r10cBHp9+w93QDwgzMzVBaa4u4pxp0NPAE7zMBiQ8EM1f+rpGT40qJLK+bi3qibGbmvK8i//lvvl17bYhg1bpCxh1ROppyf5MG3ICnZ4/GeXLmm244bITQw/zwdw3Wg53+WWfnlA2c4wgJbR3UwbHkjMLQlUp5vqT01DDeU8Ij2UU5GRBDhsripmBjD4YHtVCngefofXyaSKli5eNsy3JxrHxLQCJbnCbeE6PMK6m4KEcLrzbXAfyi4jkHR0bTkUBo7GHWQEwm5IqGoCPavaPYAWjQj5NBl2bK5BgQGNJK7ThQSUBHHJ4tZQ2yXxKPnw9fLgFNQ31YP/A9gy55B4/lCOvSeilQenfsg02z8jpd0nzx+dQ+utY4gxcSrpeyT1YYbJQMYWFx6ToKXwhd+TqlX/K14x6NBvsHA7qFwnOVgqcTDOlk+Frw/CJYLcKxkeXxtmTCe30ShCBgiSk3lVJlRGi4cij1KigDtcaPtirrl4e9tlWRtwL/3HjW1k0CYzXKyqrXwGporF3FGYlYiKCxj2pLJ3Cz+DTA6IBiIzuAYJNied3fm7w2SuAmiYk1PVZ//p0tzLR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(83380400001)(426003)(16526019)(336012)(26005)(478600001)(1076003)(2616005)(5660300002)(7696005)(4326008)(44832011)(8676002)(8936002)(2906002)(30864003)(6916009)(6666004)(54906003)(47076005)(70206006)(70586007)(41300700001)(2013699003)(36860700001)(356005)(81166007)(36756003)(82740400003)(316002)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:57:06.3268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e30aea91-8f7f-4847-3eb9-08dc1227162f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alex Hung <alex.hung@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Timings with small HBlank (such as CVT RBv2) can result in insufficient
HBlank bandwidth for audio SDP transmission when DSC is active. This
will cause some higher bandwidth audio modes to fail.

The combination of CVT RBv2 timings + DSC can commonly be encountered
in MST scenarios.

[How]
Add DP audio bandwidth validation for 8b/10b MST and 128b/132b SST/MST
cases and filter out modes that cannot be supported with the current
timing config.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    | 288 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/dce/dce_audio.h    |   3 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  56 +++-
 drivers/gpu/drm/amd/display/dc/inc/hw/audio.h |   3 +-
 .../gpu/drm/amd/display/include/audio_types.h |  15 +
 5 files changed, 349 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index f0458b8f00af..07b507150c51 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -239,27 +239,289 @@ static void check_audio_bandwidth_hdmi(
 		}
 	}
 }
+static struct fixed31_32 get_link_symbol_clk_freq_mhz(enum dc_link_rate link_rate)
+{
+	switch (link_rate) {
+	case LINK_RATE_LOW:
+		return dc_fixpt_from_int(162); /* 162 MHz */
+	case LINK_RATE_HIGH:
+		return dc_fixpt_from_int(270); /* 270 MHz */
+	case LINK_RATE_HIGH2:
+		return dc_fixpt_from_int(540); /* 540 MHz */
+	case LINK_RATE_HIGH3:
+		return dc_fixpt_from_int(810); /* 810 MHz */
+	case LINK_RATE_UHBR10:
+		return dc_fixpt_from_fraction(3125, 10); /* 312.5 MHz */
+	case LINK_RATE_UHBR13_5:
+		return dc_fixpt_from_fraction(421875, 1000); /* 421.875 MHz */
+	case LINK_RATE_UHBR20:
+		return dc_fixpt_from_int(625); /* 625 MHz */
+	default:
+		/* Unexpected case, this requires debug if encountered. */
+		ASSERT(0);
+		return dc_fixpt_from_int(0);
+	}
+}
+
+struct dp_audio_layout_config {
+	uint8_t layouts_per_sample_denom;
+	uint8_t symbols_per_layout;
+	uint8_t max_layouts_per_audio_sdp;
+};
+
+static void get_audio_layout_config(
+	uint32_t channel_count,
+	enum dp_link_encoding encoding,
+	struct dp_audio_layout_config *output)
+{
+	/* Assuming L-PCM audio. Current implementation uses max 1 layout per SDP,
+	 * with each layout being the same size (8ch layout).
+	 */
+	if (encoding == DP_8b_10b_ENCODING) {
+		if (channel_count == 2) {
+			output->layouts_per_sample_denom = 4;
+			output->symbols_per_layout = 40;
+			output->max_layouts_per_audio_sdp = 1;
+		} else if (channel_count == 8) {
+			output->layouts_per_sample_denom = 1;
+			output->symbols_per_layout = 40;
+			output->max_layouts_per_audio_sdp = 1;
+		}
+	} else if (encoding == DP_128b_132b_ENCODING) {
+		if (channel_count == 2) {
+			output->layouts_per_sample_denom = 4;
+			output->symbols_per_layout = 10;
+			output->max_layouts_per_audio_sdp = 1;
+		} else if (channel_count == 8) {
+			output->layouts_per_sample_denom = 1;
+			output->symbols_per_layout = 10;
+			output->max_layouts_per_audio_sdp = 1;
+		}
+	}
+}
 
-/*For DP SST, calculate if specified sample rates can fit into a given timing */
-static void check_audio_bandwidth_dpsst(
+static uint32_t get_av_stream_map_lane_count(
+	enum dp_link_encoding encoding,
+	enum dc_lane_count lane_count,
+	bool is_mst)
+{
+	uint32_t av_stream_map_lane_count = 0;
+
+	if (encoding == DP_8b_10b_ENCODING) {
+		if (!is_mst)
+			av_stream_map_lane_count = lane_count;
+		else
+			av_stream_map_lane_count = 4;
+	} else if (encoding == DP_128b_132b_ENCODING) {
+		av_stream_map_lane_count = 4;
+	}
+
+	ASSERT(av_stream_map_lane_count != 0);
+
+	return av_stream_map_lane_count;
+}
+
+static uint32_t get_audio_sdp_overhead(
+	enum dp_link_encoding encoding,
+	enum dc_lane_count lane_count,
+	bool is_mst)
+{
+	uint32_t audio_sdp_overhead = 0;
+
+	if (encoding == DP_8b_10b_ENCODING) {
+		if (is_mst)
+			audio_sdp_overhead = 16; /* 4 * 2 + 8 */
+		else
+			audio_sdp_overhead = lane_count * 2 + 8;
+	} else if (encoding == DP_128b_132b_ENCODING) {
+		audio_sdp_overhead = 10; /* 4 x 2.5 */
+	}
+
+	ASSERT(audio_sdp_overhead != 0);
+
+	return audio_sdp_overhead;
+}
+
+static uint32_t calculate_required_audio_bw_in_symbols(
 	const struct audio_crtc_info *crtc_info,
+	const struct dp_audio_layout_config *layout_config,
 	uint32_t channel_count,
-	union audio_sample_rates *sample_rates)
+	uint32_t sample_rate_hz,
+	uint32_t av_stream_map_lane_count,
+	uint32_t audio_sdp_overhead)
 {
-	/* do nothing */
+	/* DP spec recommends between 1.05 to 1.1 safety margin to prevent sample under-run */
+	struct fixed31_32 audio_sdp_margin = dc_fixpt_from_fraction(110, 100);
+	struct fixed31_32 horizontal_line_freq_khz = dc_fixpt_from_fraction(
+			crtc_info->requested_pixel_clock_100Hz, crtc_info->h_total * 10);
+	struct fixed31_32 samples_per_line;
+	struct fixed31_32 layouts_per_line;
+	struct fixed31_32 symbols_per_sdp_max_layout;
+	struct fixed31_32 remainder;
+	uint32_t num_sdp_with_max_layouts;
+	uint32_t required_symbols_per_hblank;
+
+	samples_per_line = dc_fixpt_from_fraction(sample_rate_hz, 1000);
+	samples_per_line = dc_fixpt_div(samples_per_line, horizontal_line_freq_khz);
+	layouts_per_line = dc_fixpt_div_int(samples_per_line, layout_config->layouts_per_sample_denom);
+
+	num_sdp_with_max_layouts = dc_fixpt_floor(
+			dc_fixpt_div_int(layouts_per_line, layout_config->max_layouts_per_audio_sdp));
+	symbols_per_sdp_max_layout = dc_fixpt_from_int(
+			layout_config->max_layouts_per_audio_sdp * layout_config->symbols_per_layout);
+	symbols_per_sdp_max_layout = dc_fixpt_add_int(symbols_per_sdp_max_layout, audio_sdp_overhead);
+	symbols_per_sdp_max_layout = dc_fixpt_mul(symbols_per_sdp_max_layout, audio_sdp_margin);
+	required_symbols_per_hblank = num_sdp_with_max_layouts;
+	required_symbols_per_hblank *= ((dc_fixpt_ceil(symbols_per_sdp_max_layout) + av_stream_map_lane_count) /
+			av_stream_map_lane_count) *	av_stream_map_lane_count;
+
+	if (num_sdp_with_max_layouts !=	dc_fixpt_ceil(
+			dc_fixpt_div_int(layouts_per_line, layout_config->max_layouts_per_audio_sdp))) {
+		remainder = dc_fixpt_sub_int(layouts_per_line,
+				num_sdp_with_max_layouts * layout_config->max_layouts_per_audio_sdp);
+		remainder = dc_fixpt_mul_int(remainder, layout_config->symbols_per_layout);
+		remainder = dc_fixpt_add_int(remainder, audio_sdp_overhead);
+		remainder = dc_fixpt_mul(remainder, audio_sdp_margin);
+		required_symbols_per_hblank += ((dc_fixpt_ceil(remainder) + av_stream_map_lane_count) /
+				av_stream_map_lane_count) * av_stream_map_lane_count;
+	}
+
+	return required_symbols_per_hblank;
 }
 
-/*For DP MST, calculate if specified sample rates can fit into a given timing */
-static void check_audio_bandwidth_dpmst(
+/* Current calculation only applicable for 8b/10b MST and 128b/132b SST/MST.
+ */
+static uint32_t calculate_available_hblank_bw_in_symbols(
 	const struct audio_crtc_info *crtc_info,
+	const struct audio_dp_link_info *dp_link_info)
+{
+	uint64_t hblank = crtc_info->h_total - crtc_info->h_active;
+	struct fixed31_32 hblank_time_msec =
+			dc_fixpt_from_fraction(hblank * 10, crtc_info->requested_pixel_clock_100Hz);
+	struct fixed31_32 lsclkfreq_mhz =
+			get_link_symbol_clk_freq_mhz(dp_link_info->link_rate);
+	struct fixed31_32 average_stream_sym_bw_frac;
+	struct fixed31_32 peak_stream_bw_kbps;
+	struct fixed31_32 bits_per_pixel;
+	struct fixed31_32 link_bw_kbps;
+	struct fixed31_32 available_stream_sym_count;
+	uint32_t available_hblank_bw = 0; /* in stream symbols */
+
+	if (crtc_info->dsc_bits_per_pixel) {
+		bits_per_pixel = dc_fixpt_from_fraction(crtc_info->dsc_bits_per_pixel, 16);
+	} else {
+		switch (crtc_info->color_depth) {
+		case COLOR_DEPTH_666:
+			bits_per_pixel = dc_fixpt_from_int(6);
+			break;
+		case COLOR_DEPTH_888:
+			bits_per_pixel = dc_fixpt_from_int(8);
+			break;
+		case COLOR_DEPTH_101010:
+			bits_per_pixel = dc_fixpt_from_int(10);
+			break;
+		case COLOR_DEPTH_121212:
+			bits_per_pixel = dc_fixpt_from_int(12);
+			break;
+		default:
+			/* Default to commonly supported color depth. */
+			bits_per_pixel = dc_fixpt_from_int(8);
+			break;
+		}
+
+		bits_per_pixel = dc_fixpt_mul_int(bits_per_pixel, 3);
+
+		if (crtc_info->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+			bits_per_pixel = dc_fixpt_div_int(bits_per_pixel, 3);
+			bits_per_pixel = dc_fixpt_mul_int(bits_per_pixel, 2);
+		} else if (crtc_info->pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+			bits_per_pixel = dc_fixpt_div_int(bits_per_pixel, 2);
+		}
+	}
+
+	/* Use simple stream BW calculation because mainlink overhead is
+	 * accounted for separately in the audio BW calculations.
+	 */
+	peak_stream_bw_kbps = dc_fixpt_from_fraction(crtc_info->requested_pixel_clock_100Hz, 10);
+	peak_stream_bw_kbps = dc_fixpt_mul(peak_stream_bw_kbps, bits_per_pixel);
+	link_bw_kbps = dc_fixpt_from_int(dp_link_info->link_bandwidth_kbps);
+	average_stream_sym_bw_frac = dc_fixpt_div(peak_stream_bw_kbps, link_bw_kbps);
+
+	available_stream_sym_count = dc_fixpt_mul_int(hblank_time_msec, 1000);
+	available_stream_sym_count = dc_fixpt_mul(available_stream_sym_count, lsclkfreq_mhz);
+	available_stream_sym_count = dc_fixpt_mul(available_stream_sym_count, average_stream_sym_bw_frac);
+	available_hblank_bw = dc_fixpt_floor(available_stream_sym_count);
+	available_hblank_bw *= dp_link_info->lane_count;
+	available_hblank_bw -= crtc_info->dsc_num_slices * 4; /* EOC overhead */
+
+	if (available_hblank_bw < dp_link_info->hblank_min_symbol_width)
+		available_hblank_bw = dp_link_info->hblank_min_symbol_width;
+
+	if (available_hblank_bw < 12)
+		available_hblank_bw = 0;
+	else
+		available_hblank_bw -= 12; /* Main link overhead */
+
+	return available_hblank_bw;
+}
+
+static void check_audio_bandwidth_dp(
+	const struct audio_crtc_info *crtc_info,
+	const struct audio_dp_link_info *dp_link_info,
 	uint32_t channel_count,
 	union audio_sample_rates *sample_rates)
 {
-	/* do nothing  */
+	struct dp_audio_layout_config layout_config = {0};
+	uint32_t available_hblank_bw;
+	uint32_t av_stream_map_lane_count;
+	uint32_t audio_sdp_overhead;
+
+	/* TODO: Add validation for SST 8b/10 case  */
+	if (!dp_link_info->is_mst && dp_link_info->encoding == DP_8b_10b_ENCODING)
+		return;
+
+	available_hblank_bw = calculate_available_hblank_bw_in_symbols(
+			crtc_info, dp_link_info);
+	av_stream_map_lane_count = get_av_stream_map_lane_count(
+			dp_link_info->encoding, dp_link_info->lane_count, dp_link_info->is_mst);
+	audio_sdp_overhead = get_audio_sdp_overhead(
+			dp_link_info->encoding, dp_link_info->lane_count, dp_link_info->is_mst);
+	get_audio_layout_config(
+			channel_count, dp_link_info->encoding, &layout_config);
+
+	if (available_hblank_bw < calculate_required_audio_bw_in_symbols(
+			crtc_info, &layout_config, channel_count, 192000,
+			av_stream_map_lane_count, audio_sdp_overhead))
+		sample_rates->rate.RATE_192 = 0;
+	if (available_hblank_bw < calculate_required_audio_bw_in_symbols(
+			crtc_info, &layout_config, channel_count, 176400,
+			av_stream_map_lane_count, audio_sdp_overhead))
+		sample_rates->rate.RATE_176_4 = 0;
+	if (available_hblank_bw < calculate_required_audio_bw_in_symbols(
+			crtc_info, &layout_config, channel_count, 96000,
+			av_stream_map_lane_count, audio_sdp_overhead))
+		sample_rates->rate.RATE_96 = 0;
+	if (available_hblank_bw < calculate_required_audio_bw_in_symbols(
+			crtc_info, &layout_config, channel_count, 88200,
+			av_stream_map_lane_count, audio_sdp_overhead))
+		sample_rates->rate.RATE_88_2 = 0;
+	if (available_hblank_bw < calculate_required_audio_bw_in_symbols(
+			crtc_info, &layout_config, channel_count, 48000,
+			av_stream_map_lane_count, audio_sdp_overhead))
+		sample_rates->rate.RATE_48 = 0;
+	if (available_hblank_bw < calculate_required_audio_bw_in_symbols(
+			crtc_info, &layout_config, channel_count, 44100,
+			av_stream_map_lane_count, audio_sdp_overhead))
+		sample_rates->rate.RATE_44_1 = 0;
+	if (available_hblank_bw < calculate_required_audio_bw_in_symbols(
+			crtc_info, &layout_config, channel_count, 32000,
+			av_stream_map_lane_count, audio_sdp_overhead))
+		sample_rates->rate.RATE_32 = 0;
 }
 
 static void check_audio_bandwidth(
 	const struct audio_crtc_info *crtc_info,
+	const struct audio_dp_link_info *dp_link_info,
 	uint32_t channel_count,
 	enum signal_type signal,
 	union audio_sample_rates *sample_rates)
@@ -271,12 +533,9 @@ static void check_audio_bandwidth(
 		break;
 	case SIGNAL_TYPE_EDP:
 	case SIGNAL_TYPE_DISPLAY_PORT:
-		check_audio_bandwidth_dpsst(
-			crtc_info, channel_count, sample_rates);
-		break;
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
-		check_audio_bandwidth_dpmst(
-			crtc_info, channel_count, sample_rates);
+		check_audio_bandwidth_dp(
+			crtc_info, dp_link_info, channel_count, sample_rates);
 		break;
 	default:
 		break;
@@ -394,7 +653,8 @@ void dce_aud_az_configure(
 	struct audio *audio,
 	enum signal_type signal,
 	const struct audio_crtc_info *crtc_info,
-	const struct audio_info *audio_info)
+	const struct audio_info *audio_info,
+	const struct audio_dp_link_info *dp_link_info)
 {
 	struct dce_audio *aud = DCE_AUD(audio);
 
@@ -529,6 +789,7 @@ void dce_aud_az_configure(
 
 				check_audio_bandwidth(
 					crtc_info,
+					dp_link_info,
 					channel_count,
 					signal,
 					&sample_rates);
@@ -588,6 +849,7 @@ void dce_aud_az_configure(
 
 	check_audio_bandwidth(
 		crtc_info,
+		dp_link_info,
 		8,
 		signal,
 		&sample_rate);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
index dbd2cfed0603..539f881928d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
@@ -170,7 +170,8 @@ void dce_aud_az_disable(struct audio *audio);
 void dce_aud_az_configure(struct audio *audio,
 	enum signal_type signal,
 	const struct audio_crtc_info *crtc_info,
-	const struct audio_info *audio_info);
+	const struct audio_info *audio_info,
+	const struct audio_dp_link_info *dp_link_info);
 
 void dce_aud_wall_dto_setup(struct audio *audio,
 	enum signal_type signal,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 4078e6be8810..db71a261e9da 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1290,6 +1290,46 @@ static enum audio_dto_source translate_to_dto_source(enum controller_id crtc_id)
 	}
 }
 
+static void populate_audio_dp_link_info(
+	const struct pipe_ctx *pipe_ctx,
+	struct audio_dp_link_info *dp_link_info)
+{
+	const struct dc_stream_state *stream = pipe_ctx->stream;
+	const struct dc_link *link = stream->link;
+	struct fixed31_32 link_bw_kbps;
+
+	dp_link_info->encoding = link->dc->link_srv->dp_get_encoding_format(
+				&pipe_ctx->link_config.dp_link_settings);
+	dp_link_info->is_mst = (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST);
+	dp_link_info->lane_count = pipe_ctx->link_config.dp_link_settings.lane_count;
+	dp_link_info->link_rate = pipe_ctx->link_config.dp_link_settings.link_rate;
+
+	link_bw_kbps = dc_fixpt_from_int(dc_link_bandwidth_kbps(link,
+			&pipe_ctx->link_config.dp_link_settings));
+
+	/* For audio stream calculations, the video stream should not include FEC or SSC
+	 * in order to get the most pessimistic values.
+	 */
+	if (dp_link_info->encoding == DP_8b_10b_ENCODING &&
+			link->dc->link_srv->dp_is_fec_supported(link)) {
+		link_bw_kbps = dc_fixpt_mul(link_bw_kbps,
+				dc_fixpt_from_fraction(100, DATA_EFFICIENCY_8b_10b_FEC_EFFICIENCY_x100));
+	} else if (dp_link_info->encoding == DP_128b_132b_ENCODING) {
+		link_bw_kbps = dc_fixpt_mul(link_bw_kbps,
+				dc_fixpt_from_fraction(10000, 9975)); /* 99.75% SSC overhead*/
+	}
+
+	dp_link_info->link_bandwidth_kbps = dc_fixpt_floor(link_bw_kbps);
+
+	/* HW minimum for 128b/132b HBlank is 4 frame symbols.
+	 * TODO: Plumb the actual programmed HBlank min symbol width to here.
+	 */
+	if (dp_link_info->encoding == DP_128b_132b_ENCODING)
+		dp_link_info->hblank_min_symbol_width = 4;
+	else
+		dp_link_info->hblank_min_symbol_width = 0;
+}
+
 static void build_audio_output(
 	struct dc_state *state,
 	const struct pipe_ctx *pipe_ctx,
@@ -1337,6 +1377,15 @@ static void build_audio_output(
 	audio_output->crtc_info.calculated_pixel_clock_100Hz =
 			pipe_ctx->stream_res.pix_clk_params.requested_pix_clk_100hz;
 
+	audio_output->crtc_info.pixel_encoding =
+		stream->timing.pixel_encoding;
+
+	audio_output->crtc_info.dsc_bits_per_pixel =
+			stream->timing.dsc_cfg.bits_per_pixel;
+
+	audio_output->crtc_info.dsc_num_slices =
+			stream->timing.dsc_cfg.num_slices_h;
+
 /*for HDMI, audio ACR is with deep color ratio factor*/
 	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) &&
 		audio_output->crtc_info.requested_pixel_clock_100Hz ==
@@ -1370,6 +1419,10 @@ static void build_audio_output(
 
 	audio_output->pll_info.ss_percentage =
 			pipe_ctx->pll_settings.ss_percentage;
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+		populate_audio_dp_link_info(pipe_ctx, &audio_output->dp_link_info);
+	}
 }
 
 static void program_scaler(const struct dc *dc,
@@ -1506,7 +1559,8 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 				pipe_ctx->stream_res.audio,
 				pipe_ctx->stream->signal,
 				&audio_output.crtc_info,
-				&pipe_ctx->stream->audio_info);
+				&pipe_ctx->stream->audio_info,
+				&audio_output.dp_link_info);
 	}
 
 	/* make sure no pipes syncd to the pipe being enabled */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/audio.h b/drivers/gpu/drm/amd/display/dc/inc/hw/audio.h
index 6ed1fb8c9300..b6203253111c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/audio.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/audio.h
@@ -43,7 +43,8 @@ struct audio_funcs {
 	void (*az_configure)(struct audio *audio,
 		enum signal_type signal,
 		const struct audio_crtc_info *crtc_info,
-		const struct audio_info *audio_info);
+		const struct audio_info *audio_info,
+		const struct audio_dp_link_info *dp_link_info);
 
 	void (*wall_dto_setup)(struct audio *audio,
 		enum signal_type signal,
diff --git a/drivers/gpu/drm/amd/display/include/audio_types.h b/drivers/gpu/drm/amd/display/include/audio_types.h
index 915a031a43cb..e4a26143f14c 100644
--- a/drivers/gpu/drm/amd/display/include/audio_types.h
+++ b/drivers/gpu/drm/amd/display/include/audio_types.h
@@ -27,11 +27,21 @@
 #define __AUDIO_TYPES_H__
 
 #include "signal_types.h"
+#include "fixed31_32.h"
+#include "dc_dp_types.h"
 
 #define AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS 20
 #define MAX_HW_AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS 18
 #define MULTI_CHANNEL_SPLIT_NO_ASSO_INFO 0xFFFFFFFF
 
+struct audio_dp_link_info {
+	uint32_t link_bandwidth_kbps;
+	uint32_t hblank_min_symbol_width;
+	enum dp_link_encoding encoding;
+	enum dc_link_rate link_rate;
+	enum dc_lane_count lane_count;
+	bool is_mst;
+};
 
 struct audio_crtc_info {
 	uint32_t h_total;
@@ -42,7 +52,10 @@ struct audio_crtc_info {
 	uint32_t calculated_pixel_clock_100Hz; /* in 100Hz */
 	uint32_t refresh_rate;
 	enum dc_color_depth color_depth;
+	enum dc_pixel_encoding pixel_encoding;
 	bool interlaced;
+	uint32_t dsc_bits_per_pixel;
+	uint32_t dsc_num_slices;
 };
 struct azalia_clock_info {
 	uint32_t pixel_clock_in_10khz;
@@ -95,6 +108,8 @@ struct audio_output {
 	enum signal_type signal;
 	/* video timing */
 	struct audio_crtc_info crtc_info;
+	/* DP link info */
+	struct audio_dp_link_info dp_link_info;
 	/* PLL for audio */
 	struct audio_pll_info pll_info;
 };
-- 
2.34.1

