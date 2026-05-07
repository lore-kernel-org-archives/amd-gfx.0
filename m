Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF95ACD3444
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 15:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C9610F1F3;
	Thu,  7 May 2026 15:52:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dDAPh3gf";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010012.outbound.protection.outlook.com
 [52.101.193.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF6F810F1EE
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 15:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHrMXH3bitn2S2aCBKhkgP6s3zZ+kV7QlmlwSZpozAnOzHwBespLSK7hAMzz+P+uiNMGqF9654Dfbet2Ptr3Zb0vGi0H8je8KT5Dz6iNMih+J6SjZhSDmfRa9FDS6LqA2AwmbOohQp4Bp//HCphLG5x9lJi7MRsQETn6VfKjDBKZQ2akl+2w5oqae1wdqH0ka2cNpa0RexExKc290zdm5pCGoA11VVxS1fZuJgl/L139o39gcJ2nQx1qWYLHeoELs8Baf46hprxLfwG6qEgnRvRtc20TYcDmGaxEeG8zqScwij2dbgznKDVDigXFTYKv2xyVXuVRC96pnCKL/zXjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo43LulxZiNnB0kpp6p4fr+P5eWe0msq+chkE5MW2Mc=;
 b=oXwYDNV3r/sAQNAYeOSPP5Y8JQbs/xUe3lc6mf3lzlYZnJfBXA1aCne+ETsQwBCV6g6CwLwrvxMeCD+AsGudB788wR7Tnd/Yj0xyT0+bt9FXGi4YtjlYjFGWcZcI1ODWRpX75o24uUCA9tcF+9ipw8hNqkZ9jWDeSkasMhHXavyMq9GtoZrMv1U06VulKCzsutm820/iPrY3sMWXxyToHQuTcixinmIS5aMolOvOAPP5387RaFgVKmH3TqTkWW4hHS9KkPyA8ViNNkM34ACXpIEschWKlmykS1We0lnq7yuZDbVm1l5O7zvaBczM3fBkP+KUbGBHDowVxkQyP2ul4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo43LulxZiNnB0kpp6p4fr+P5eWe0msq+chkE5MW2Mc=;
 b=dDAPh3gf5fjFqD4opalQCRjadokdK97drvCBw46HmYVOZ5vIV5+162CoK3evQzMWH5TW/ja6Y+5r6Nacx3bcF5qkfcA6hsn/QLVeoD/PzdI0IIAI+m+z2jgmuQogImR36JFXWe4j14uAMaywfNh1m0xCQXIzlah94ky9FlNzrUE=
Received: from MW4PR03CA0328.namprd03.prod.outlook.com (2603:10b6:303:dd::33)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 15:52:12 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::98) by MW4PR03CA0328.outlook.office365.com
 (2603:10b6:303:dd::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Thu,
 7 May 2026 15:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:52:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 7 May
 2026 10:51:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 May
 2026 10:51:59 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 10:51:58 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 15/22] drm/amd/display: Tie FRL programming together in HWSS
Date: Thu, 7 May 2026 11:51:37 -0400
Message-ID: <20260507155147.182540-16-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507155147.182540-1-harry.wentland@amd.com>
References: <20260507155147.182540-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cff49aa-bbd0-43d1-2ecc-08deac50999b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TTQi35B02idjxbdMhUq7P65JE1MzggRX21cgnYOA6uFrS5r1cYnU9WzARc/89XmKnq84BWi5k55S7d1U5C1riP4QRop1Jn+NTZWzqV6oD2/mRHXM0Xj7Qsg4YC38Qi96NSGsh9QZyjZcLEToS7K5GmiwZyIL8Wn4uO0zWxqaqspQrg5D8SSbWpAV1jm7IW5IRbx7Z07WCgTYWIBuo9X58shP0tx9Ip8cpLE1cRYZxFBvrkPiXgjQV3aD7jWmEG8naeYwuViuKXV7mmzbmoQb2jR9u8reteUIEG4/hZJ+LeM12fYXyG0tXA77RLASb/fxgXIt09Imp64n5FSzpPcx/C42RJqAm0c8AaC82Cm17X+CLrcMQTQ4XO5eEYypRRXkr8xpCaiHfiCQlEAmST8Jb02RHPd9PHHfvL8NhG5pGvT3UtmT9NxdWTQYjR9nnlg79X32XakKUacNoBkXirMlBsS9/5utizWrzV5cjN6ou7sG+FbglzcH++MIjutpTUq5n4mo2H+qmNDeUsRXAKgChBnT4GIz1oCcfJ0xfmziV2N8X1hTkmX97GMtmFFQ9A6DEYFTAsk15PaDVC6qrNpMr7YM20Z1cNnGW5yMSe9ILjmWmnxEFIjHOVVFkJxUj39P28nqpde3dOWRYYksY903dYb9fudnVHYLsKuVwULRDSb2YAZ7RoRmyqlsc9ZBq98ZQKN5/Zr+YP82s6eWB3/Hsbr/NYJNGA8UxaCjFGS0hic=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p6uQ6PThYAHRenrP67Zp95mSyCZ8eGGKqwkeae4FmO3K7N/WagtqR239bjX/SHXlIXBRFsKm7EhZqlLLZYD3vt3XFuNaQcH1OzLWTxUv7SfKJrKHpyD9967aYwy6t17Eji2V1lM7crRkuJGW7f4yM5MncHYTNCCmJIPTl7gsWCobGhdFHWw54hCQ9OdyV/yiuXecawe2Y0uGwfScDm/I7O8J75RNpryHjIGQshSZC+4w0v3dTKcGWwvdzPIDVO1S/5zjVC06awq0/N6cyoALHswF0JeGmVYqkY9D3ic/ICaYfo0v1b4Q6Txgku2PHowxzrKqVSI/0NSBcDVKI5/o1Q81gC+VO8bN0J/wOx8PNxQUk2eY9808rn789o4xXEbIvVGmfJ2/2zvxXlPLgkG4VPFvTVOweCAZFK/t4pTWqlNG12NqICUkN26fLcWY44AY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:52:10.6850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cff49aa-bbd0-43d1-2ecc-08deac50999b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
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

This patch adds HW Sequencer support for FRL programming, which
ties the HW programming for the different blocks together for
FRL.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 99 +++++++++++++++++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 37 +++++++
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 19 +++-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 49 ++++++++-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   | 16 +++
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 13 ++-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  1 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 13 ++-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 42 ++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 13 +++
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  1 +
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 38 ++++++-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |  2 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 32 ++++++
 .../display/dc/hwss/hw_sequencer_private.h    |  3 +
 22 files changed, 373 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 7af239524d71..236ea3f7b36a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1192,6 +1192,9 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 			pipe_ctx->stream_res.stream_enc);
 	}
 
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->stop_hdmi_info_packets(
+			pipe_ctx->stream_res.hpo_frl_stream_enc);
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->stop_dp_info_packets(
 					pipe_ctx->stream_res.hpo_dp_stream_enc);
@@ -1216,6 +1219,7 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 			}
 		}
 	} else if (dccg && dccg->funcs->disable_symclk_se) {
+		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_FRL)
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
 					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
@@ -1287,6 +1291,18 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 		link->dc->link_srv->edp_receiver_ready_T9(link);
 	}
 
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal)) {
+		pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_blank(pipe_ctx->stream_res.hpo_frl_stream_enc);
+
+		/* Set HDMISTREAMCLK source to REFCLK */
+		if (link->dc->res_pool->dccg &&
+			link->dc->res_pool->dccg->funcs->set_hdmistreamclk) {
+			link->dc->res_pool->dccg->funcs->set_hdmistreamclk(
+					link->dc->res_pool->dccg,
+					REFCLK,
+					pipe_ctx->stream_res.tg->inst);
+		}
+	}
 }
 
 
@@ -1476,9 +1492,32 @@ void build_audio_output(
 
 		}
 	}
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_FRL) {
+		switch (pipe_ctx->stream->link->frl_link_settings.frl_link_rate) {
+		case HDMI_FRL_LINK_RATE_3GBPS:
+			audio_output->crtc_info.frl_character_clock_kHz = 166667;
+			break;
+		case HDMI_FRL_LINK_RATE_6GBPS:
+		case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
+			audio_output->crtc_info.frl_character_clock_kHz = 333333;
+			break;
+		case HDMI_FRL_LINK_RATE_8GBPS:
+			audio_output->crtc_info.frl_character_clock_kHz = 444444;
+			break;
+		case HDMI_FRL_LINK_RATE_10GBPS:
+			audio_output->crtc_info.frl_character_clock_kHz = 555555;
+			break;
+		case HDMI_FRL_LINK_RATE_12GBPS:
+		default:
+			audio_output->crtc_info.frl_character_clock_kHz = 666667;
+			break;
+		}
+	} else
+			audio_output->crtc_info.frl_character_clock_kHz = 0;
 
 	if (state->clk_mgr &&
 		(pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
+			pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_FRL ||
 			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)) {
 		audio_output->pll_info.audio_dto_source_clock_in_khz =
 				state->clk_mgr->funcs->get_dp_ref_clk_frequency(
@@ -1724,7 +1763,8 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 				pipe_ctx->stream_res.tg, event_triggers, 2);
 
 	if (!dc_is_virtual_signal(pipe_ctx->stream->signal) &&
-		!dc_is_rgb_signal(pipe_ctx->stream->signal))
+		!dc_is_rgb_signal(pipe_ctx->stream->signal) &&
+		!dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream_res.stream_enc->funcs->dig_connect_to_otg(
 			pipe_ctx->stream_res.stream_enc,
 			pipe_ctx->stream_res.tg->inst);
@@ -2476,7 +2516,8 @@ static void dce110_setup_audio_dto(
 
 		if (pipe_ctx->top_pipe)
 			continue;
-		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A)
+		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A &&
+			pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_FRL)
 			continue;
 		if (pipe_ctx->stream_res.audio != NULL) {
 			struct audio_output audio_output;
@@ -2485,15 +2526,27 @@ static void dce110_setup_audio_dto(
 
 			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
 				struct dtbclk_dto_params dto_params = {0};
+				dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
 
-				dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
-					dc->res_pool->dccg, &dto_params);
+				if (pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_FRL) {
+					/* For DCN3.1, audio to HPO FRL encoder is using audio DTBCLK DTO */
+					/* set audio DTBCLK DTO to 24MHz */
+					dto_params.req_audio_dtbclk_khz = 24000;
+					dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
+						dc->res_pool->dccg,
+						&dto_params);
+				} else {
+					/* Audio DTBCLK params default to disabled */
+					dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
+						dc->res_pool->dccg,
+						&dto_params);
 
-				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
+					pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 						pipe_ctx->stream_res.audio,
 						pipe_ctx->stream->signal,
 						&audio_output.crtc_info,
 						&audio_output.pll_info);
+				}
 			} else
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
@@ -2523,11 +2576,37 @@ static void dce110_setup_audio_dto(
 
 				build_audio_output(context, pipe_ctx, &audio_output);
 
-				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
-					pipe_ctx->stream_res.audio,
-					pipe_ctx->stream->signal,
-					&audio_output.crtc_info,
-					&audio_output.pll_info);
+				/* Audio to HPO DP encoder is using audio DTBCLK DTO */
+				if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
+					struct dtbclk_dto_params dto_params = {0};
+					dto_params.ref_dtbclk_khz =
+							dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
+
+					if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+						/* set audio DTBCLK DTO to 24MHz */
+						dto_params.req_audio_dtbclk_khz = 24000;
+						dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
+							dc->res_pool->dccg,
+							&dto_params);
+					} else {
+						/* Audio DTBCLK params default to disabled */
+						dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
+							dc->res_pool->dccg,
+							&dto_params);
+
+						pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
+							pipe_ctx->stream_res.audio,
+							pipe_ctx->stream->signal,
+							&audio_output.crtc_info,
+							&audio_output.pll_info);
+					}
+				} else {
+					pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
+						pipe_ctx->stream_res.audio,
+						pipe_ctx->stream->signal,
+						&audio_output.crtc_info,
+						&audio_output.pll_info);
+				}
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 566edc05b99d..a2fc6846564b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -752,6 +752,43 @@ void dcn10_log_hw_state(struct dc *dc,
 
 	log_mpc_crc(dc, log_ctx);
 
+	for (i = 0; i < pool->hpo_frl_stream_enc_count; i++) {
+		struct hpo_frl_stream_encoder_state hpo_se_state = {0};
+		struct hpo_frl_link_enc_state hpo_le_state = {0};
+		struct hpo_frl_stream_encoder *hpo_frl_stream_enc = pool->hpo_frl_stream_enc[i];
+		struct hpo_frl_link_encoder *hpo_frl_link_enc = dc->links[i]->hpo_frl_link_enc;
+		bool printed_header = false;
+
+		hpo_frl_stream_enc->funcs->read_state(hpo_frl_stream_enc, &hpo_se_state);
+		if (hpo_se_state.stream_enc_enabled)
+			hpo_frl_link_enc->funcs->read_state(hpo_frl_link_enc, &hpo_le_state);
+
+		/* Only print if HPO link is enabled */
+		if ((hpo_se_state.stream_enc_enabled == 0)
+				|| (hpo_le_state.link_enc_enabled == 0))
+			continue;
+		if (!printed_header) {
+			DTN_INFO("\n");
+			DTN_INFO("HPO:   OTG Inst     Link   Pixel Format   Depth   ODM Segments   Lanes   Borrow   h_active   h_blank\n");
+			printed_header = true;
+		}
+
+		DTN_INFO("[%d]: %10d   %6s   %10s   %5d          %5d   %5d   %6s      %5d     %5d\n",
+				hpo_frl_stream_enc->id - ENGINE_ID_HPO_0,
+				hpo_se_state.otg_inst,
+				hpo_le_state.link_active ? "Active" : "Training",
+				(hpo_se_state.pixel_format == PIXEL_ENCODING_YCBCR420) ? "4:2:0" :
+						((hpo_se_state.pixel_format == PIXEL_ENCODING_YCBCR422) ? "4:2:2" : "4:4:4"),
+				hpo_se_state.color_depth,
+				hpo_se_state.num_odm_segments,
+				hpo_le_state.lane_count,
+				(hpo_se_state.borrow_mode == 0) ? "NONE" :
+						((hpo_se_state.borrow_mode == 1) ? "ACTIVE" : "BLANK"),
+				hpo_se_state.h_active,
+				hpo_se_state.h_blank);
+	}
+	DTN_INFO("\n");
+
 	{
 		if (pool->hpo_dp_stream_enc_count > 0) {
 			DTN_INFO("DP HPO S_ENC:  Enabled  OTG   Format   Depth   Vid   SDP   Compressed  Link\n");
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index c2ea0106fdec..8b382b4e10f1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -917,6 +917,11 @@ enum dc_status dcn20_enable_stream_timing(
 			pipe_ctx->stream->signal,
 			true);
 
+	/* Must use manual div mode for FRL */
+	if (pipe_ctx->stream_res.tg->funcs->set_h_timing_div_manual_mode) {
+		bool manual_mode = dc_is_hdmi_frl_signal(pipe_ctx->stream->signal) || !is_h_timing_divisible_by_2(stream) || dc_is_virtual_signal(pipe_ctx->stream->signal);
+		pipe_ctx->stream_res.tg->funcs->set_h_timing_div_manual_mode(pipe_ctx->stream_res.tg, manual_mode);
+	}
 	rate_control_2x_pclk = rate_control_2x_pclk || opp_cnt > 1;
 	flow_control.flow_ctrl_mode = 0;
 	flow_control.flow_ctrl_cnt0 = 0x80;
@@ -2785,6 +2790,16 @@ void dcn20_unblank_stream(struct pipe_ctx *pipe_ctx,
 		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
 	}
 
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal)) {
+		if (params.opp_cnt == 4)
+			params.timing.pix_clk_100hz /= 4;
+		else if (is_two_pixels_per_container || params.opp_cnt > 1)
+			params.timing.pix_clk_100hz /= 2;
+		if (link->link_status.link_active && link->frl_link_settings.frl_link_rate != 0)
+			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_unblank(
+					pipe_ctx->stream_res.hpo_frl_stream_enc,
+					pipe_ctx->stream_res.tg->inst);
+	}
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
 		hws->funcs.edp_backlight_control(link, true);
 	}
@@ -3052,7 +3067,9 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 			dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
 		}
 	} else {
-		if (dccg->funcs->enable_symclk_se && link_enc) {
+		if (dccg->funcs->enable_symclk_se
+			&& link_enc
+			&& pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_FRL) {
 			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA
 				&& link->cur_link_settings.link_rate == LINK_RATE_UNKNOWN
 				&& !link->link_status.link_active) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 2705c58a9150..cfca7af6cd1f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -836,6 +836,10 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 	if (pipe_ctx == NULL)
 		return;
 
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal) && pipe_ctx->stream_res.hpo_frl_stream_enc != NULL)
+		pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->set_avmute(
+				pipe_ctx->stream_res.hpo_frl_stream_enc,
+				enable);
 	if (dc_is_hdmi_signal(pipe_ctx->stream->signal) && pipe_ctx->stream_res.stream_enc != NULL) {
 		pipe_ctx->stream_res.stream_enc->funcs->set_avmute(
 				pipe_ctx->stream_res.stream_enc,
@@ -856,22 +860,29 @@ void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx)
 {
 	bool is_hdmi_tmds;
 	bool is_dp;
+	bool is_hdmi_frl;
 
 	ASSERT(pipe_ctx->stream);
 
-	if (pipe_ctx->stream_res.stream_enc == NULL)
+	if (pipe_ctx->stream_res.stream_enc == NULL &&
+			pipe_ctx->stream_res.hpo_frl_stream_enc == NULL)
 		return;  /* this is not root pipe */
 
 	is_hdmi_tmds = dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal);
 	is_dp = dc_is_dp_signal(pipe_ctx->stream->signal);
 
-	if (!is_hdmi_tmds && !is_dp)
+	is_hdmi_frl = dc_is_hdmi_frl_signal(pipe_ctx->stream->signal);
+	if (!is_hdmi_tmds && !is_dp && !is_hdmi_frl)
 		return;
 
 	if (is_hdmi_tmds)
 		pipe_ctx->stream_res.stream_enc->funcs->update_hdmi_info_packets(
 			pipe_ctx->stream_res.stream_enc,
 			&pipe_ctx->stream_res.encoder_info_frame);
+	else if (is_hdmi_frl)
+		pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->update_hdmi_info_packets(
+			pipe_ctx->stream_res.hpo_frl_stream_enc,
+			&pipe_ctx->stream_res.encoder_info_frame);
 	else {
 		if (pipe_ctx->stream_res.stream_enc->funcs->update_dp_info_packets_sdp_line_num)
 			pipe_ctx->stream_res.stream_enc->funcs->update_dp_info_packets_sdp_line_num(
@@ -890,6 +901,7 @@ void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx)
 	struct hubp               *hubp       = pipe_ctx->plane_res.hubp;
 	bool                       enable     = false;
 	struct stream_encoder     *stream_enc = pipe_ctx->stream_res.stream_enc;
+	struct hpo_frl_stream_encoder *hpo_enc    = pipe_ctx->stream_res.hpo_frl_stream_enc;
 	enum dynamic_metadata_mode mode       = dc_is_dp_signal(stream->signal)
 							? dmdata_dp
 							: dmdata_hdmi;
@@ -903,11 +915,44 @@ void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx)
 	if (!hubp)
 		return;
 
+	if (dc_is_hdmi_frl_signal(stream->signal)) {
+		ASSERT(mode == dmdata_hdmi);
+
+		if (!hpo_enc || !hpo_enc->funcs->set_dynamic_metadata)
+			return;
+
+		hpo_enc->funcs->set_dynamic_metadata(hpo_enc, enable,
+						     hubp->inst, dmdata_hdmi);
+	} else {
 	if (!stream_enc || !stream_enc->funcs->set_dynamic_metadata)
 		return;
 
 	stream_enc->funcs->set_dynamic_metadata(stream_enc, enable,
 							hubp->inst, mode);
+	}
+}
+enum dc_status dcn30_setup_hdmi_frl_link(
+		struct dc_link *link,
+		int hpo_inst,
+		enum clock_source_id frl_phy_clock_source_id)
+{
+	(void)hpo_inst;
+	enum dc_status status = DC_OK;
+	struct dc *dc = link->ctx->dc;
+
+	if ((!link->link_enc) ||
+			(!link->hpo_frl_link_enc) ||
+			(!dc->res_pool->dccg->funcs->enable_hdmicharclk))
+		return DC_ERROR_UNEXPECTED;
+
+	//Enable phy output for FRL case
+	link->hpo_frl_link_enc->funcs->enable_frl_phy_output(
+		link->hpo_frl_link_enc,
+		link->link_enc,
+		frl_phy_clock_source_id,
+		link->frl_link_settings.frl_link_rate);
+	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+	return status;
 }
 
 bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index 40afbbfb5b9c..2306354e90af 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -72,6 +72,22 @@ void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable);
 void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx);
 void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx);
 
+enum dc_status dcn30_setup_hdmi_frl_link(
+		struct dc_link *link,
+		int hpo_inst,
+		enum clock_source_id frl_phy_clock_source_id);
+void dcn30_hw_set_fva_vrr_adj(struct dc *dc, struct pipe_ctx **pipe_ctx, int num_pipes,
+		struct fva_adj *fva_adj,
+		struct dc_crtc_timing_adjust *vrr_adj);
+
+int dcn30_hw_get_max_fva_factor(struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_crtc_timing *timing,
+		unsigned int max_pixel_clock);
+
+void dcn30_hw_set_vstartup_dsc_frl(struct dc *dc,
+		struct pipe_ctx *pipe_ctx);
+
 bool dcn30_does_plane_fit_in_mall(struct dc *dc,
 		unsigned int pitch,
 		unsigned int height,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index 5cbae0cdda96..26c7386a8a36 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -105,6 +105,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
 	.disable_link_output = dce110_disable_link_output,
+	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index b4afb2bc4493..fd8311ad4fa6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -104,6 +104,8 @@ static void enable_memory_low_power(struct dc *dc)
 				dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
 		for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++)
 			dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
+		for (i = 0; i < dc->res_pool->hpo_frl_stream_enc_count; i++)
+			dc->res_pool->hpo_frl_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_frl_stream_enc[i]->vpg);
 	}
 
 }
@@ -377,22 +379,29 @@ void dcn31_update_info_frame(struct pipe_ctx *pipe_ctx)
 {
 	bool is_hdmi_tmds;
 	bool is_dp;
+	bool is_hdmi_frl;
 
 	ASSERT(pipe_ctx->stream);
 
-	if (pipe_ctx->stream_res.stream_enc == NULL)
+	if (pipe_ctx->stream_res.stream_enc == NULL &&
+			pipe_ctx->stream_res.hpo_frl_stream_enc == NULL)
 		return;  /* this is not root pipe */
 
 	is_hdmi_tmds = dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal);
 	is_dp = dc_is_dp_signal(pipe_ctx->stream->signal);
 
-	if (!is_hdmi_tmds && !is_dp)
+	is_hdmi_frl = dc_is_hdmi_frl_signal(pipe_ctx->stream->signal);
+	if (!is_hdmi_tmds && !is_dp && !is_hdmi_frl)
 		return;
 
 	if (is_hdmi_tmds)
 		pipe_ctx->stream_res.stream_enc->funcs->update_hdmi_info_packets(
 			pipe_ctx->stream_res.stream_enc,
 			&pipe_ctx->stream_res.encoder_info_frame);
+	else if (is_hdmi_frl)
+		pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->update_hdmi_info_packets(
+			pipe_ctx->stream_res.hpo_frl_stream_enc,
+			&pipe_ctx->stream_res.encoder_info_frame);
 	else if (pipe_ctx->stream->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		if (pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->update_dp_info_packets_sdp_line_num)
 			pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->update_dp_info_packets_sdp_line_num(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index e56b9a46aecf..23b30d6f3956 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -98,6 +98,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
+	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 1e856ee508f1..1ee862972584 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -335,7 +335,8 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 	two_pix_per_container = pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
-	if (stream->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal) ||
+			stream->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		*k1_div = PIXEL_RATE_DIV_BY_1;
 		*k2_div = PIXEL_RATE_DIV_BY_1;
 	} else if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) || dc_is_dvi_signal(pipe_ctx->stream->signal)) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 9900c87b4567..98771fc443c7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -100,6 +100,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
+	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 7dbaaf9403f2..34f9b3624011 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1205,7 +1205,8 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	two_pix_per_container = pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
-	if (stream->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal) ||
+			stream->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		*k1_div = PIXEL_RATE_DIV_BY_1;
 		*k2_div = PIXEL_RATE_DIV_BY_1;
 	} else if (dc_is_hdmi_tmds_signal(stream->signal) || dc_is_dvi_signal(stream->signal)) {
@@ -1351,6 +1352,16 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
 	}
 
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal)) {
+		if (params.opp_cnt == 4)
+			params.timing.pix_clk_100hz /= 4;
+		else if (pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&stream->timing) || params.opp_cnt > 1)
+			params.timing.pix_clk_100hz /= 2;
+		if (link->link_status.link_active && link->frl_link_settings.frl_link_rate != 0)
+			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_unblank(
+					pipe_ctx->stream_res.hpo_frl_stream_enc,
+					pipe_ctx->stream_res.tg->inst);
+	}
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP)
 		hws->funcs.edp_backlight_control(link, true);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 849dae18b738..0b3e8512ebf1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -31,6 +31,7 @@
 #include "dcn31/dcn31_hwseq.h"
 #include "dcn32/dcn32_hwseq.h"
 #include "dcn401/dcn401_hwseq.h"
+#include "dml/dcn32/dcn32_fpu.h"
 #include "dcn32_init.h"
 
 static const struct hw_sequencer_funcs dcn32_funcs = {
@@ -96,6 +97,8 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
+	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
+	.get_max_dispclk_mhz = dcn32_get_max_dispclk_mhz,
 	.apply_idle_power_optimizations = dcn32_apply_idle_power_optimizations,
 	.does_plane_fit_in_mall = NULL,
 	.set_backlight_level = dcn31_set_backlight_level,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 894d48fcd7f8..6de4cd32bdad 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -110,6 +110,8 @@ static void enable_memory_low_power(struct dc *dc)
 		for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++)
 			dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
 #endif
+		for (i = 0; i < dc->res_pool->hpo_frl_stream_enc_count; i++)
+			dc->res_pool->hpo_frl_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_frl_stream_enc[i]->vpg);
 	}
 
 }
@@ -439,6 +441,9 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
+	if (!(pipe_ctx->stream_res.hpo_frl_stream_enc &&
+			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_fifo_odm_enabled &&
+			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_fifo_odm_enabled(pipe_ctx->stream_res.hpo_frl_stream_enc))) {
 	if (opp_cnt > 1)
 		pipe_ctx->stream_res.tg->funcs->set_odm_combine(
 				pipe_ctx->stream_res.tg,
@@ -463,6 +468,7 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 				odm_pipe->stream_res.opp,
 				true);
 	}
+	}
 
 	if (pipe_ctx->stream_res.dsc) {
 		struct pipe_ctx *current_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx];
@@ -501,6 +507,17 @@ void dcn35_dpstream_root_clock_control(struct dce_hwseq *hws, unsigned int dp_hp
 	}
 }
 
+void dcn35_hdmistream_root_clock_control(struct dce_hwseq *hws, bool clock_on)
+{
+	if (!hws->ctx->dc->debug.root_clock_optimization.bits.hdmistream)
+		return;
+
+	if (hws->ctx->dc->res_pool->dccg->funcs->set_hdmistreamclk_root_clock_gating) {
+		hws->ctx->dc->res_pool->dccg->funcs->set_hdmistreamclk_root_clock_gating(
+			hws->ctx->dc->res_pool->dccg, clock_on);
+	}
+}
+
 void dcn35_physymclk_root_clock_control(struct dce_hwseq *hws, unsigned int phy_inst, bool clock_on)
 {
 	if (!hws->ctx->dc->debug.root_clock_optimization.bits.physymclk)
@@ -928,6 +945,14 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 
 	memset(update_state, 0, sizeof(struct pg_block_update));
 
+	for (i = 0; i < dc->res_pool->hpo_frl_stream_enc_count; i++) {
+		if (context->res_ctx.is_hpo_frl_stream_enc_acquired[i] &&
+				dc->res_pool->hpo_frl_stream_enc[i]) {
+			hpo_frl_stream_enc_acquired = true;
+			break;
+		}
+	}
+
 	for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++) {
 		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[i] &&
 				dc->res_pool->hpo_dp_stream_enc[i]) {
@@ -983,6 +1008,9 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 			update_state->pg_pipe_res_update[PG_DPSTREAM][pipe_ctx->stream_res.hpo_dp_stream_enc->inst] = false;
 	}
 
+	if (hpo_frl_stream_enc_acquired)
+		update_state->pg_pipe_res_update[PG_HDMISTREAM][0] = false;
+
 	for (i = 0; i < dc->link_count; i++) {
 		update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_inst] = true;
 		if (dc->links[i]->type != dc_connection_none)
@@ -1104,6 +1132,14 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		if (dc->links[i]->type != dc_connection_none)
 			update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_inst] = true;
 
+	for (i = 0; i < dc->res_pool->hpo_frl_stream_enc_count; i++) {
+		if (context->res_ctx.is_hpo_frl_stream_enc_acquired[i] &&
+				dc->res_pool->hpo_frl_stream_enc[i]) {
+			hpo_frl_stream_enc_acquired = true;
+			break;
+		}
+	}
+
 	for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++) {
 		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[i] &&
 				dc->res_pool->hpo_dp_stream_enc[i]) {
@@ -1320,6 +1356,9 @@ void dcn35_root_clock_control(struct dc *dc,
 				if (dc->hwseq->funcs.physymclk_root_clock_control)
 					dc->hwseq->funcs.physymclk_root_clock_control(dc->hwseq, i, power_on);
 
+		if (update_state->pg_pipe_res_update[PG_HDMISTREAM][0])
+			if (dc->hwseq->funcs.hdmistream_root_clock_control)
+				dc->hwseq->funcs.hdmistream_root_clock_control(dc->hwseq, power_on);
 	}
 	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
 		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
@@ -1350,6 +1389,9 @@ void dcn35_root_clock_control(struct dc *dc,
 				if (dc->hwseq->funcs.physymclk_root_clock_control)
 					dc->hwseq->funcs.physymclk_root_clock_control(dc->hwseq, i, power_on);
 
+		if (update_state->pg_pipe_res_update[PG_HDMISTREAM][0])
+			if (dc->hwseq->funcs.hdmistream_root_clock_control)
+				dc->hwseq->funcs.hdmistream_root_clock_control(dc->hwseq, power_on);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index e3459546a908..235ebf00bd1f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -39,6 +39,8 @@ void dcn35_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst,
 
 void dcn35_dpstream_root_clock_control(struct dce_hwseq *hws, unsigned int dp_hpo_inst, bool clock_on);
 
+void dcn35_hdmistream_root_clock_control(struct dce_hwseq *hws, bool clock_on);
+
 void dcn35_physymclk_root_clock_control(struct dce_hwseq *hws, unsigned int phy_inst, bool clock_on);
 
 void dcn35_enable_power_gating_plane(struct dce_hwseq *hws, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 6ac8ad97cf13..fc18d2207711 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -107,6 +107,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
+	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
 	.set_backlight_level = dcn31_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
@@ -158,6 +159,7 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	//.hubp_pg_control = dcn35_hubp_pg_control,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
+	.hdmistream_root_clock_control = dcn35_hdmistream_root_clock_control,
 	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn35_update_odm,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 04c260015eec..19ec5b4edfdc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -100,6 +100,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
+	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
 	.set_backlight_level = dcn31_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
@@ -147,6 +148,7 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	//.hubp_pg_control = dcn35_hubp_pg_control,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
+	.hdmistream_root_clock_control = dcn35_hdmistream_root_clock_control,
 	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn35_update_odm,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 9c505a8a773c..a0be7e15b9ca 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -638,6 +638,9 @@ static void enable_stream_timing_calc(
 			stream->link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
 	}
 
+	if (pipe_ctx->stream_res.tg->funcs->set_h_timing_div_manual_mode) {
+		*manual_mode = !is_h_timing_divisible_by_2(stream);
+	}
 	params->vertical_total_min = stream->adjust.v_total_min;
 	params->vertical_total_max = stream->adjust.v_total_max;
 	params->vertical_total_mid = stream->adjust.v_total_mid;
@@ -695,6 +698,8 @@ enum dc_status dcn401_enable_stream_timing(
 	if (dc->res_pool->dccg->funcs->set_dtbclk_p_src) {
 		if (dc_is_dp_signal(stream->signal) || dc_is_virtual_signal(stream->signal)) {
 			dc->res_pool->dccg->funcs->set_dtbclk_p_src(dc->res_pool->dccg, DPREFCLK, pipe_ctx->stream_res.tg->inst);
+		} else if (dc_is_hdmi_frl_signal(stream->signal)) {
+			dc->res_pool->dccg->funcs->set_dtbclk_p_src(dc->res_pool->dccg, DTBCLK0, pipe_ctx->stream_res.tg->inst);
 		}
 	}
 
@@ -733,6 +738,8 @@ enum dc_status dcn401_enable_stream_timing(
 		pipe_ctx->stream->signal,
 		true);
 
+	if (pipe_ctx->stream_res.tg->funcs->set_h_timing_div_manual_mode)
+		pipe_ctx->stream_res.tg->funcs->set_h_timing_div_manual_mode(pipe_ctx->stream_res.tg, manual_mode);
 	for (i = 0; i < opp_cnt; i++) {
 		opp_heads[i]->stream_res.opp->funcs->opp_pipe_clock_control(
 				opp_heads[i]->stream_res.opp,
@@ -1691,6 +1698,12 @@ void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx,
 		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
 	}
 
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal)) {
+		if (link->link_status.link_active && link->frl_link_settings.frl_link_rate != 0)
+			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_unblank(
+					pipe_ctx->stream_res.hpo_frl_stream_enc,
+					pipe_ctx->stream_res.tg->inst);
+	}
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP)
 		hws->funcs.edp_backlight_control(link, true);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 5d0dfb36f3e1..d24a352937b4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -84,6 +84,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
+	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
 	.apply_idle_power_optimizations = dcn401_apply_idle_power_optimizations,
 	.does_plane_fit_in_mall = NULL,
 	.set_backlight_level = dcn31_set_backlight_level,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index 46f2f9833d9e..31dca33fdf8f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -546,6 +546,14 @@ void dcn42_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 
 	update_state->pg_res_update[PG_DIO] = true;
 
+	for (i = 0; i < dc->res_pool->hpo_frl_stream_enc_count; i++) {
+		if (context->res_ctx.is_hpo_frl_stream_enc_acquired[i] &&
+				dc->res_pool->hpo_frl_stream_enc[i]) {
+			hpo_frl_stream_enc_acquired = true;
+			break;
+		}
+	}
+
 	for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++) {
 		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[i] &&
 				dc->res_pool->hpo_dp_stream_enc[i]) {
@@ -591,11 +599,14 @@ void dcn42_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 		if (pipe_ctx->link_res.dio_link_enc) {
 			update_state->pg_res_update[PG_DIO] = false;
 		}
-		if (pipe_ctx->link_res.hpo_dp_link_enc) {
+		if (pipe_ctx->link_res.hpo_dp_link_enc
+		    || pipe_ctx->link_res.hpo_frl_link_enc) {
 			update_state->pg_res_update[PG_HPO] = false;
 		}
 	}
 
+	if (hpo_frl_stream_enc_acquired)
+		update_state->pg_pipe_res_update[PG_HDMISTREAM][0] = false;
 
 	for (i = 0; i < dc->link_count; i++) {
 		update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_inst] = true;
@@ -615,6 +626,12 @@ void dcn42_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 		}
 	}
 
+	for (i = 0; i < dc->res_pool->hpo_frl_stream_enc_count; i++) {
+		if (dc->current_state->res_ctx.is_hpo_frl_stream_enc_acquired[i]) {
+			update_state->pg_res_update[PG_HPO] = false;
+			break;
+		}
+	}
 }
 
 void dcn42_prepare_bandwidth(
@@ -662,6 +679,7 @@ void dcn42_optimize_bandwidth(struct dc *dc, struct dc_state *context)
 void dcn42_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 	struct pg_block_update *update_state)
 {
+	bool hpo_frl_stream_enc_acquired = false;
 	bool hpo_dp_stream_enc_acquired = false;
 	int i = 0, j = 0;
 
@@ -747,6 +765,14 @@ void dcn42_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 			break;
 		}
 	}
+	for (i = 0; i < dc->res_pool->hpo_frl_stream_enc_count; i++) {
+		if (context->res_ctx.is_hpo_frl_stream_enc_acquired[i] &&
+				dc->res_pool->hpo_frl_stream_enc[i]) {
+			hpo_frl_stream_enc_acquired = true;
+			break;
+		}
+	}
+
 	for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++) {
 		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[i] &&
 				dc->res_pool->hpo_dp_stream_enc[i]) {
@@ -755,9 +781,11 @@ void dcn42_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		}
 	}
 
-	if (hpo_dp_stream_enc_acquired)
+	if (hpo_frl_stream_enc_acquired || hpo_dp_stream_enc_acquired)
 		update_state->pg_res_update[PG_HPO] = true;
 
+	if (hpo_frl_stream_enc_acquired)
+		update_state->pg_pipe_res_update[PG_HDMISTREAM][0] = true;
 	if (count_active_streams(dc) > 0) {
 		update_state->pg_res_update[PG_DCCG] = true;
 		update_state->pg_res_update[PG_DCIO] = true;
@@ -967,6 +995,9 @@ void dcn42_root_clock_control(struct dc *dc,
 				if (dc->hwseq->funcs.physymclk_root_clock_control)
 					dc->hwseq->funcs.physymclk_root_clock_control(dc->hwseq, i, power_on);
 
+		if (update_state->pg_pipe_res_update[PG_HDMISTREAM][0])
+			if (dc->hwseq->funcs.hdmistream_root_clock_control)
+				dc->hwseq->funcs.hdmistream_root_clock_control(dc->hwseq, power_on);
 	}
 	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
 		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
@@ -997,6 +1028,9 @@ void dcn42_root_clock_control(struct dc *dc,
 				if (dc->hwseq->funcs.physymclk_root_clock_control)
 					dc->hwseq->funcs.physymclk_root_clock_control(dc->hwseq, i, power_on);
 
+		if (update_state->pg_pipe_res_update[PG_HDMISTREAM][0])
+			if (dc->hwseq->funcs.hdmistream_root_clock_control)
+				dc->hwseq->funcs.hdmistream_root_clock_control(dc->hwseq, power_on);
 	}
 }
 void dcn42_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
index b324a2195e8a..49c13611a518 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
@@ -85,6 +85,7 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
+	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
 	.apply_idle_power_optimizations = dcn35_apply_idle_power_optimizations,
 	.does_plane_fit_in_mall = NULL,
 	.set_backlight_level = dcn31_set_backlight_level,
@@ -159,6 +160,7 @@ static const struct hwseq_private_funcs dcn42_private_funcs = {
 	.program_cm_hist = dcn42_program_cm_hist,
 	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
+	.hdmistream_root_clock_control = dcn35_hdmistream_root_clock_control,
 	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
 	.resync_fifo_dccg_dio = dcn314_resync_fifo_dccg_dio,
 	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 7f0743de1b14..7e65ccd11386 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -806,6 +806,10 @@ struct stream_enc_update_hdmi_info_packets_params {
 	struct pipe_ctx *pipe_ctx;
 };
 
+struct hpo_frl_stream_enc_update_hdmi_info_packets_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
 struct hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params {
 	struct pipe_ctx *pipe_ctx;
 };
@@ -847,6 +851,12 @@ struct stream_enc_dp_set_dsc_pps_info_packet_params {
 	bool pps_sdp_stream;
 };
 
+struct hpo_frl_stream_enc_set_dsc_config_params {
+	struct hpo_frl_stream_encoder *hpo_frl_stream_enc;
+	const struct dc_crtc_timing *timing;
+	uint8_t *dsc_packed_pps;
+};
+
 struct dp_trace_source_sequence_params {
 	struct dc_link *link;
 	enum dpcd_source_sequence source;
@@ -1028,6 +1038,7 @@ union block_sequence_params {
 	struct update_cursor_offload_pipe_params update_cursor_offload_pipe_params;
 	struct commit_cursor_offload_update_params commit_cursor_offload_update_params;
 	struct stream_enc_update_hdmi_info_packets_params stream_enc_update_hdmi_info_packets_params;
+	struct hpo_frl_stream_enc_update_hdmi_info_packets_params hpo_frl_stream_enc_update_hdmi_info_packets_params;
 	struct hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num_params;
 	struct hpo_dp_stream_enc_update_dp_info_packets_params hpo_dp_stream_enc_update_dp_info_packets_params;
 	struct stream_enc_update_dp_info_packets_sdp_line_num_params stream_enc_update_dp_info_packets_sdp_line_num_params;
@@ -1036,6 +1047,7 @@ union block_sequence_params {
 	struct stream_enc_dp_set_dsc_config_params stream_enc_dp_set_dsc_config_params;
 	struct hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params hpo_dp_stream_enc_dp_set_dsc_pps_info_packet_params;
 	struct stream_enc_dp_set_dsc_pps_info_packet_params stream_enc_dp_set_dsc_pps_info_packet_params;
+	struct hpo_frl_stream_enc_set_dsc_config_params hpo_frl_stream_enc_set_dsc_config_params;
 	struct dp_trace_source_sequence_params dp_trace_source_sequence_params;
 	struct set_dmdata_attributes_params set_dmdata_attributes_params;
 	struct link_increase_mst_payload_params link_increase_mst_payload_params;
@@ -1179,6 +1191,7 @@ enum block_sequence_func {
 	HUBP_SET_BLANK,
 	PHANTOM_HUBP_POST_ENABLE,
 	STREAM_ENC_UPDATE_HDMI_INFO_PACKETS,
+	HPO_FRL_STREAM_ENC_UPDATE_HDMI_INFO_PACKETS,
 	HPO_DP_STREAM_ENC_UPDATE_DP_INFO_PACKETS_SDP_LINE_NUM,
 	HPO_DP_STREAM_ENC_UPDATE_DP_INFO_PACKETS,
 	STREAM_ENC_UPDATE_DP_INFO_PACKETS_SDP_LINE_NUM,
@@ -1187,6 +1200,7 @@ enum block_sequence_func {
 	STREAM_ENC_DP_SET_DSC_CONFIG,
 	HPO_DP_STREAM_ENC_DP_SET_DSC_PPS_INFO_PACKET,
 	STREAM_ENC_DP_SET_DSC_PPS_INFO_PACKET,
+	HPO_FRL_STREAM_ENC_SET_DSC_CONFIG,
 	LINK_INCREASE_MST_PAYLOAD,
 	LINK_REDUCE_MST_PAYLOAD,
 	DP_TRACE_SOURCE_SEQUENCE,
@@ -1415,6 +1429,14 @@ struct hw_sequencer_funcs {
 
 	void (*get_dcc_en_bits)(struct dc *dc, int *dcc_en_bits);
 
+	enum dc_status (*setup_hdmi_frl_link)(
+			struct dc_link *link,
+			int hpo_inst,
+			enum clock_source_id frl_phy_clock_source_id);
+
+	unsigned int (*get_max_dispclk_mhz)(struct dc *dc,
+			struct dc_state *context);
+
 	/* Idle Optimization Related */
 	bool (*apply_idle_power_optimizations)(struct dc *dc, bool enable);
 
@@ -1672,6 +1694,8 @@ void hwss_dsc_set_config_simple(union block_sequence_params *params);
 
 void hwss_stream_enc_update_hdmi_info_packets(union block_sequence_params *params);
 
+void hwss_hpo_frl_stream_enc_update_hdmi_info_packets(union block_sequence_params *params);
+
 void hwss_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(union block_sequence_params *params);
 
 void hwss_hpo_dp_stream_enc_update_dp_info_packets(union block_sequence_params *params);
@@ -2367,6 +2391,9 @@ void hwss_add_commit_cursor_offload_update(struct block_sequence_state *seq_stat
 void hwss_add_stream_enc_update_hdmi_info_packets(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx);
 
+void hwss_add_hpo_frl_stream_enc_update_hdmi_info_packets(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
 void hwss_add_hpo_dp_stream_enc_update_dp_info_packets_sdp_line_num(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx);
 
@@ -2400,6 +2427,11 @@ void hwss_add_stream_enc_dp_set_dsc_pps_info_packet(struct block_sequence_state
 		uint8_t *dsc_packed_pps,
 		bool pps_sdp_stream);
 
+void hwss_add_hpo_frl_stream_enc_set_dsc_config(struct block_sequence_state *seq_state,
+		struct hpo_frl_stream_encoder *hpo_frl_stream_enc,
+		const struct dc_crtc_timing *timing,
+		uint8_t *dsc_packed_pps);
+
 void hwss_add_setup_periodic_interrupt(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 8e3f54fb53fd..63c6c841c681 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -140,6 +140,9 @@ struct hwseq_private_funcs {
 			struct dce_hwseq *hws,
 			unsigned int dpp_inst,
 			bool clock_on);
+	void (*hdmistream_root_clock_control)(
+			struct dce_hwseq *hws,
+			bool clock_on);
 	void (*physymclk_root_clock_control)(
 			struct dce_hwseq *hws,
 			unsigned int phy_inst,
-- 
2.54.0

