Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99FAC55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71E1A10E24B;
	Fri, 31 Jul 2026 21:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mEtuBqTy";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7649F10E24B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eihqMXPEFtNrCCqxsADqmBZdQVv8qEI2bpV5Nm7jADxXWM0yw6l2rnK1bjfTO3V/w8Z2hgjCQrTl+jAZX/oBG211H8A5sbNIhm5By9CQoeSr8PT7n3cFZSRV6bx2jH10NdRJS6oyNwt9uol/vZRxuktln6SR+tTK/hXdA5lTlME94S8sAfkhpE8hM9cB55S6zHBr8+jUZtW9PHi38bx9XuXc2Owmsq5etaCia7jDlMQxZC3+vj8O3TQy7IjHCkQzUCMWL87w4UOak9AW+aaagSZzW25jPuupkapJwhdN7AQq+7bDsThL2VFx1NnCWrTppxoqgd9aAey/vat/RpchXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20x2XVYcvd0Z3hC4Bnh3muzKyFk5o4vZWshVv5Ri6y4=;
 b=uIj/eDushZ3bQZIGNJujDE3YfYePzx2gpz+KlkEisyEx+atbi3XQZUf1gSCCu1ONLrwbP6tRU7svH569Lp1xfklW0cammNGg4ZKy4HcPKu5mVuIMFY3L5mlPjXR4hKze3tzDwEtBuPKQIfVl1uJDNHUoZ1aDZ0mj9Gc+K2tmTyYP0Wb2nG6HUNIp7tpcL+OZotz1+QQo/uYUX4TA8JtkdlqorFa80uAWPtHR7z5XVhS0j9xFjKQtZ9w+5ODk60AHNXnAAL4ZV+fit/4oLJ9yEYFGC2IAc4x3XMwXrQnIqyC7ptzmyWuOZkQDFPSj0ydsT30XKL0U7qxDOe3TUVZrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20x2XVYcvd0Z3hC4Bnh3muzKyFk5o4vZWshVv5Ri6y4=;
 b=mEtuBqTyxbVI8riM5KPsDmJDu0ZUgfZkA8VVGWp0Tv/0QO54nxfhp7r1em3xfyg7Kgzf4vyP8NS0BEtkfYTV1h+u0zrybNNNJrgemUa0NksSuSTjafSLyL8tm3BKug9KLl4KslUahVL5nFUaSFtMva2FFzSS9MjbuSqQhXK0bX4=
Received: from BN9PR03CA0906.namprd03.prod.outlook.com (2603:10b6:408:107::11)
 by SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Fri, 31 Jul
 2026 21:15:42 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::1d) by BN9PR03CA0906.outlook.office365.com
 (2603:10b6:408:107::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:41 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:40 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Karthi Kandasamy <karthi.kandasamy@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 13/41] drm/amd/display: Fix seamless mode switch not
 triggering for HDR to SDR transition
Date: Fri, 31 Jul 2026 17:12:34 -0400
Message-ID: <20260731211302.3040343-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SN7PR12MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: d7213a20-873c-4941-70c7-08deef48e0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|3023799007|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: F9/9sTBlO3POVqTxiiCpdpmv5pgOFQ7uR3zaznRYaUNLKbbij5s7IA/dn0R8EHBkJQvvF6waM5WoEC63olcIbE6U5VlrtPwSUC11B/dA2L4c7qpt6iiDobXvBMqgK95t7Tkw08YrmfqhnPHYqApL0Z+czP34VTa+2r6ftA+kdVTf67FtES+blrG3ZFTTbAlJ/N4mL1/WyF8wkG9MrkHu3fQidb44sCYWFkUfA/qJlimnOMiGArw5wTgSix0gKF9yrW92AKshC4ox4GH4V6x8/nM9n/5msvCBn7vcoS8ISKTj0m8Mh4yJwldVO2QPUqMPunhbhFJjqQG9nWzADO1+tf5oD8swPFN3Cf2RkOv6G36b0A+cYBdtCtJoTGoOQD+PbNVwH0SvZMaijwq9GjqX68lggvCXeBg8/VtPtVSGJUykZXYXu/vj65HCm5ve4NgE4WlxDgGZ6ljNEUDRdEPxSp82DWtYzn9GlAjOvT8t2mh7WkEA5A0iphFPMFUA29SO8yDMOVqd+W6H45Q/1Lxop27rB4w66AWzk3H/IStHZap1SzY2b9n690dz2Sd75+gINMPjTn9XqyOn8U+pL7fphSYpdJik4qotQZLBCtCCsiLByYC14q3WDYWJaADeAoXfhhCiPRjfs3zlhYfXYtC8Lltshs7D764PHyrqCq4kxURkzLZFMzokZnU0K+y/k02b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(3023799007)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y0mnijmZJiHJohZXKsI1OEs0A+2PhtoYJZ8paZT18kJ67380/Mhe5cyJelrbDlcKiaVcWT/miTyqR1m4Y/xLgoGqGpuIsaPS8lyDtQaeTZXOX8Gipf8Z+xy0TWo81agp3lFgF1bSkCUhsLJ9G3VyzF6WkFd+7WwvlivUsGICDWgWpEkMpsH9krW5IS5ArHQsm4zxcOlDf/Pt20wTlzCeMZyR9NURMSDpKZCENeGw8N2/Goo4GxkKR8VKTWDorWqg3GLgxqV12FZB8gM2JWyb6bFY45yAAhy3N8AIUOp3Y1eKor8PBYtUBBaXF1RVfnYypQSUgW8MdazAdJcs842UIhXjZeQpFfgmZjcto3dikT8nnXvksIifSsT9i7Ms8sMhATWXzg5fucxfaaRQQueQrUdnsDD33ZuUntAs3+VgDcdGC4bHXnXotH3g4zOjtsQd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:42.3554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7213a20-873c-4941-70c7-08deef48e0f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

[Why]
The seamless mode switch was not getting triggered during HDR to SDR
transitions, and no DPCD write was observed. Root cause analysis
revealed that incorrect panel capabilities were being reported for PSR
SU panels. Due to the wrong capabilities, the OS was not invoking the
seamless mode switch API, resulting in no DPCD communication and also
gated eDP teardown across the seamless mode switch hold.

[How]
Fixed by setting the correct power panel capabilities for PSR SU panels.
This ensures the OS receives accurate panel capability information and
triggers the seamless mode switch API as expected, restoring proper
DPCD writes during HDR to SDR transitions.
The DC commit sequence was tearing the eDP down anyway -- backlight off,
ABM disable, DPMS off, PSR/Replay enable state cleared, PHY TX off,
OTG/OPTC off; all these actions are blocked now with the
skip_implict_edp_power_control

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 10 ++++++--
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 21 ++++++++++++-----
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  7 ++++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 23 ++++++++++++++-----
 .../drm/amd/display/modules/power/power_psr.c |  7 ++++++
 .../amd/display/modules/power/power_replay.c  |  7 ++++++
 7 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index cc029af0cef2..683b5fb1945d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1994,6 +1994,7 @@ struct dc_scratch_space {
 	// BW ALLOCATON USB4 ONLY
 	struct dc_dpia_bw_alloc dpia_bw_alloc_config;
 	bool skip_implict_edp_power_control;
+	bool forced_psr_active;
 	enum backlight_control_type backlight_control_type;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 5fcf30b448a5..80180cb00aba 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1286,6 +1286,8 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 		return;
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
+		if (link->forced_psr_active)
+			return;
 		if (!link->skip_implict_edp_power_control && hws)
 			hws->funcs.edp_backlight_control(link, false);
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
@@ -1811,7 +1813,9 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 			dc->link_srv->set_dsc_enable(pipe_ctx, true);
 	}
 
-	if (!stream->dpms_off)
+	if (!stream->dpms_off &&
+	    !(link->connector_signal == SIGNAL_TYPE_EDP &&
+	      link->forced_psr_active))
 		dc->link_srv->set_dpms_on(context, pipe_ctx);
 
 	/* DCN3.1 FPGA Workaround
@@ -1830,7 +1834,9 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 	 * is constructed with the same sink). Make sure not to override
 	 * and link programming on the main.
 	 */
-	if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM) {
+	if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM &&
+	    !(link->connector_signal == SIGNAL_TYPE_EDP &&
+	      link->forced_psr_active)) {
 		pipe_ctx->stream->link->psr_settings.psr_feature_enabled = false;
 		pipe_ctx->stream->link->replay_settings.replay_feature_enabled = false;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index b6f3c0480ab6..823ef06c64f5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -537,10 +537,12 @@ static void dcn31_reset_back_end_for_pipe(
 	}
 	ASSERT(!pipe_ctx->top_pipe);
 
-	dc->hwss.set_abm_immediate_disable(pipe_ctx);
-
 	link = pipe_ctx->stream->link;
 
+	if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
+	      link->forced_psr_active))
+		dc->hwss.set_abm_immediate_disable(pipe_ctx);
+
 	if (dc->hwseq)
 		dc->hwseq->wa_state.skip_blank_stream = false;
 
@@ -555,9 +557,11 @@ static void dcn31_reset_back_end_for_pipe(
 			pipe_ctx->stream_res.tg,
 			OPTC_DSC_DISABLED, 0, 0);
 
-	pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
-
-	pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
+	if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
+	      link->forced_psr_active)) {
+		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
+		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
+	}
 	if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
@@ -586,7 +590,12 @@ static void dcn31_reset_back_end_for_pipe(
 	 * screen only, the dpms_off would be true but
 	 * VBIOS lit up eDP, so check link status too.
 	 */
-	if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+	if (link->connector_signal == SIGNAL_TYPE_EDP &&
+	    link->forced_psr_active) {
+		/* forced psr is active for seamless switch; skip dpms-off. */
+		if (pipe_ctx->stream_res.audio)
+			dc->hwss.disable_audio_stream(pipe_ctx);
+	} else if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 		dc->link_srv->set_dpms_off(pipe_ctx);
 	else if (pipe_ctx->stream_res.audio)
 		dc->hwss.disable_audio_stream(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 08f1f307657c..6e1079377f48 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1819,8 +1819,11 @@ void dcn35_disable_link_output(struct dc_link *link,
 		disable_link_output_symclk_on_tx_off(link, DP_UNKNOWN_ENCODING);
 		link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
 	} else {
-		link_hwss->disable_link_output(link, link_res, signal);
-		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		if (!(signal == SIGNAL_TYPE_EDP &&
+		      link->forced_psr_active)) {
+			link_hwss->disable_link_output(link, link_res, signal);
+			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		}
 	}
 	/*
 	 * Add the logic to extract BOTH power up and power down sequences
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index b89010a88b44..904780e02f70 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1113,8 +1113,11 @@ void dcn401_disable_link_output(struct dc_link *link,
 		disable_link_output_symclk_on_tx_off(link, DP_UNKNOWN_ENCODING);
 		link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
 	} else {
-		link_hwss->disable_link_output(link, link_res, signal);
-		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		if (!(signal == SIGNAL_TYPE_EDP &&
+		      link->forced_psr_active)) {
+			link_hwss->disable_link_output(link, link_res, signal);
+			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		}
 	}
 
 	if (signal == SIGNAL_TYPE_EDP &&
@@ -2162,7 +2165,12 @@ void dcn401_reset_back_end_for_pipe(
 	 * screen only, the dpms_off would be true but
 	 * VBIOS lit up eDP, so check link status too.
 	 */
-	if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+	if (link->connector_signal == SIGNAL_TYPE_EDP &&
+	    link->forced_psr_active) {
+		/* Forced psr is active for seamless switch; skip dpms-off. */
+		if (pipe_ctx->stream_res.audio)
+			dc->hwss.disable_audio_stream(pipe_ctx);
+	} else if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 		dc->link_srv->set_dpms_off(pipe_ctx);
 	else if (pipe_ctx->stream_res.audio)
 		dc->hwss.disable_audio_stream(pipe_ctx);
@@ -2187,12 +2195,15 @@ void dcn401_reset_back_end_for_pipe(
 	 * parent pipe.
 	 */
 	if (pipe_ctx->top_pipe == NULL) {
+		if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
+		      link->forced_psr_active)) {
 
-		dc->hwss.set_abm_immediate_disable(pipe_ctx);
+			dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
-		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
+			pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
-		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
+			pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
+		}
 		if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
 			pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_psr.c b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
index 5ecb570c204e..96bb77fff05b 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_psr.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
@@ -58,6 +58,13 @@ bool mod_power_psr_notify_mode_change(struct mod_power *mod_power,
 	// stream_index is passed as validated parameter
 	active_psr_events = core_power->map[stream_index].psr_events;
 
+	/* forced psr is active for seamless switch.
+	 * Re-running edp_setup_psr would disturb the freeze,
+	 * so skip the PSR re-setup until forced psr releases the override.
+	 */
+	if (active_psr_events & psr_event_os_override_hold)
+		return false;
+
 	/* Calculate PSR configurations */
 	mod_power_calc_psr_configs(&psr_config, link, stream);
 
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_replay.c b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
index e782501442c4..31d9cb3a12ba 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_replay.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
@@ -805,6 +805,13 @@ void mod_power_replay_notify_mode_change(struct mod_power *mod_power,
 	core_power = MOD_POWER_TO_CORE(mod_power);
 	active_replay_events = core_power->map[stream_index].replay_events;
 
+	/* forced psr is active for seamless switch.
+	 * Re-running edp_setup_psr would disturb the freeze,
+	 * so skip the PSR re-setup until forced psr releases the override.
+	 */
+	if (active_replay_events & replay_event_os_override_hold)
+		return;
+
 	link->replay_settings.replay_smu_opt_enable =
 		(link->replay_settings.config.replay_smu_opt_supported &&
 		mod_power_only_edp(dc->current_state, stream));
-- 
2.34.1

