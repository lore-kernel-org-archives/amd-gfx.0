Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE0BCA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE5F10E659;
	Wed,  7 Oct 2026 17:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fuzizTgj";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF45D10E64A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDiqjfzNy2AoSwz2RCtA3/NJYus0C2fVbwsyuN5zfQj7d6zkRVFq5U4kGg9dOifzCM9wEEBobALq1X7fldAarf51eek92c6RzOKf0IKKpB9qYyeYcdbVc/iYqrDLAc/cNEFGL92IMEwxoMMI1ILSEzWqnJiNRjtKMyr1WvCUMSG69s+6D3MjVtokIzWT1Ae3Bnohq0iM+8b7YYWb87GcOJYF7+RKUR/qxuwNsKqIK/8MZbsxJRhT/3vOGU0oaAdAoERdmIa2SRR5wXWSg5qKLgyIRySdd1KzANQ1/OSCmyhjp+bGw/q5+/PJU6WcPejtmP204nb/VQ11JB9X0MXX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6RGtetQoOcyoqLnfmJpv7sy1ITsS5QX3pt08aXHFCk=;
 b=LRKKmAQHzZFR+pPrS7Y/f/3TGwe6JL/bRoc3tRRNjG3LskiN0HmnQOUyQSFcj6rYJv4XSBFyBVIAdmq+836drTzKZj9mjSVQomDE/18Zbw2EPQ/bSJLXCZ8epBHBYdt1ynojDboAJmjxXMIkOXBUVqJf0Jbw686EW0mCmYcaLAQfJTk6iItwbWNjWCdk4MZEpE0o+BjBzXh5IwYbpxfQOij2Q1/6qcBUGr8g2MRfjF0RFuVgfaJG35bsRCBqklI2qNNI5L6xPzs0SMzqn0V2ZrHf/sYHMLlrPg5nxgzOKSb3WDiaGPRB+mrBvtuOQe0eI0Ob/u6mULbwPLPpF0ROZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6RGtetQoOcyoqLnfmJpv7sy1ITsS5QX3pt08aXHFCk=;
 b=fuzizTgjbD3DHdxKi7kqZIMT6Ek+KEEYWWARdeIQep2knJDEDHh7mP6iiXHUU0Zsnd8H/ih18ir/lN8Ft325gHsNavmtI8mYuFAINvT6ZtgcjY63jglK6ZLgS0iNIi4tlucrrwflifUNOLgfNQWN0dgzRchOjaAHtVkwh4G9NCE=
Received: from YT3PR01CA0139.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:83::31)
 by DS0PR12MB9725.namprd12.prod.outlook.com (2603:10b6:8:226::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Wed, 7 Oct
 2026 17:04:32 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:b01:83:cafe::7b) by YT3PR01CA0139.outlook.office365.com
 (2603:10b6:b01:83::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 17:04:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:27 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:27 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Karthi Kandasamy <karthi.kandasamy@amd.com>, "Anthony
 Koo" <anthony.koo@amd.com>
Subject: [PATCH 08/19] drm/amd/display: Do full link training during HDR/SDR
 seamless switch
Date: Wed, 7 Oct 2026 12:59:41 -0400
Message-ID: <20261007170412.1898315-9-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS0PR12MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: f7cff581-dcd1-4a87-288d-08df24950d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|56012099006|10067099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: cUUlk7mlNP6xXF4c748wNx5+TI6M+4Q0BCKXtCasG4jUQTQkmwPp3Y9YQVvrUTJRPSHh9nPDjjE5MqYicRLpFXMvdKLu1lO6U4kzl90OtHW2Jl+s99CCJi1U1DngBFHoFdRPhLxOzTVKCJJB/W2+E0w4+tfGFssCLs+3URavymid3rUYjzHU7lTb0lanGhwnHHC+PZPTAuu5G4UFgdZxR50kJQpoaIyvozr+m5++SoDPLEoZTJjmBto7+mXXAQPcEQ36u54II4PWY0gbk0gv9ocH+jbhQz0Kt0M0FTvlGxZ42DDnfLil0VfueSEMUEMRTflWMjGmr+0su6Pv0RZ8HnJjKh2WUKp689zgxdS2pva+Htds4w/sM/uVFysl7SPpyO9YzwsyWq7Dp7x27liVgg3CNNNmh9nceNefG7+D2oauhnrnvHqrHm0GALP+W9MrCCPBB+qw7tYSuLDnINU0LPkT6U2HD/W5MI/KljjyeS/UK6Mxe3zXPSNwjRL4BMn2MGOSihhRQHMAwncJBeU60tFsdObQv/AVCKDGRk9sry1F463FyXoucKMQEi+/j2JVtFPM1SNKadetQf3AeCTVJfjSICB3MZjImb3MmwzAJk2MHdImfHfhFNZvHNG71h0eNO+C9NC3Ri0zbtZWuoiWQl0i+rrueT0xNwny8UdCoNPLdQRvyWRrxKHGa5qUvtZoHQUbMba2xoqAxMA+2C5llw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RBsPaArsormQbro+v2ogKFw2a6rgqTf32QGw0oBcm3vmHEVEkYa/VrdvM5DE7kjFfmO8U/040boyPoWzL6ksDsh5W7bLLY6h1vcTo7Jnw1mD2xCmdz6MGQz4wgIw9CCOwWAFqTTj21mXQWOeBt7uTQX4P06SvxCle3ciMD/z9z3bftqFRkIs6pmUuBZ388o1APdFN3ojUXWK1012YaUgNdyTfKP3FBZNaU3TiG+kNeLoTC9fcaOh26ZH2Dqd3nT1nT9720qrHBZb/smUg//lj+OBl99So87D4K25tmozgFiKHF1zn7dEie5vdsVduwBuTP1n3XzRyppeHeKCaYYIbIYwl7bIMLmS7aACBCO5yQM2dnv6queENJ46scYk7TUt4qmDWSwpNEZExfgtQAyXiypy1eW+Buw4Jo8K7pGBC4Og4Myfvz2zYIDVbyeucG0k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:30.3784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cff581-dcd1-4a87-288d-08df24950d72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9725
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
The forced_psr_active gates added across hwseq skipped backlight, ABM,
CRTC/OTG, PHY link output and DPMS teardown whenever seamless switch happens.
This meant the link was not fully retrained during an HDR/SDR switch, going beyond the
intended scope of just preventing the frozen frame from being disrupted.

[How]
Removed the forced_psr_active conditionals from early return, the dpms_on gate,
the disable_link_output gates, and the reset_back_end_for_pipe
dpms_off/abm/disable_crtc/enable_optc_clock skips and hwseq,
restoring their unconditional behavior so full link training runs during the HDR/SDR
switch even with seamless switch

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 13 +++---------
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 19 ++++++-----------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 17 +++++----------
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 21 ++++++-------------
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  8 +++----
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  7 ++-----
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  7 ++-----
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  4 +---
 8 files changed, 28 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 7b3aa02dda63..1abb28504aec 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1285,8 +1285,6 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 		return;
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-		if (link->forced_psr_active)
-			return;
 		if (!link->skip_implict_edp_power_control && hws)
 			hws->funcs.edp_backlight_control(link, false);
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
@@ -1815,9 +1813,7 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 			dc->link_srv->set_dsc_enable(pipe_ctx, true);
 	}
 
-	if (!stream->dpms_off &&
-	    !(link->connector_signal == SIGNAL_TYPE_EDP &&
-	      link->forced_psr_active))
+	if (!stream->dpms_off)
 		dc->link_srv->set_dpms_on(context, pipe_ctx);
 
 	/* DCN3.1 FPGA Workaround
@@ -3607,11 +3603,8 @@ void dce110_disable_link_output(struct dc_link *link,
 	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
 
-	if (!(signal == SIGNAL_TYPE_EDP &&
-			link->forced_psr_active)) {
-		link_hwss->disable_link_output(link, link_res, signal);
-		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
-	}
+	link_hwss->disable_link_output(link, link_res, signal);
+	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 	/*
 	 * Add the logic to extract BOTH power up and power down sequences
 	 * from enable/disable link output and only call edp panel control
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 2ab247d9748b..f1d14b97977f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1350,12 +1350,7 @@ static void dcn10_reset_back_end_for_pipe(
 	 * screen only, the dpms_off would be true but
 	 * VBIOS lit up eDP, so check link status too.
 	 */
-	if (link->connector_signal == SIGNAL_TYPE_EDP &&
-	    link->forced_psr_active) {
-		/* forced psr is active for seamless switch; skip dpms-off. */
-		if (pipe_ctx->stream_res.audio)
-			dc->hwss.disable_audio_stream(pipe_ctx);
-	} else if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+	if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 		dc->link_srv->set_dpms_off(pipe_ctx);
 	else if (pipe_ctx->stream_res.audio)
 		dc->hwss.disable_audio_stream(pipe_ctx);
@@ -1379,15 +1374,13 @@ static void dcn10_reset_back_end_for_pipe(
 	 * parent pipe.
 	 */
 	if (pipe_ctx->top_pipe == NULL) {
-		if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
-			link->forced_psr_active)) {
-			if (pipe_ctx->stream_res.abm)
-				dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
-			pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
+		if (pipe_ctx->stream_res.abm)
+			dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
-			pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
-		}
+		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
+
+		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
 		set_drr_and_clear_adjust_pending(pipe_ctx, pipe_ctx->stream, NULL);
 		if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
 			pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 6b8c5b1e436c..b0cc1f2506ba 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2914,12 +2914,7 @@ void dcn20_reset_back_end_for_pipe(
 	 * screen only, the dpms_off would be true but
 	 * VBIOS lit up eDP, so check link status too.
 	 */
-	if (link->connector_signal == SIGNAL_TYPE_EDP &&
-	    link->forced_psr_active) {
-		/* forced psr is active for seamless switch; skip dpms-off. */
-		if (pipe_ctx->stream_res.audio)
-			dc->hwss.disable_audio_stream(pipe_ctx);
-	} else if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+	if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 		dc->link_srv->set_dpms_off(pipe_ctx);
 	else if (pipe_ctx->stream_res.audio)
 		dc->hwss.disable_audio_stream(pipe_ctx);
@@ -2944,14 +2939,12 @@ void dcn20_reset_back_end_for_pipe(
 	 * parent pipe.
 	 */
 	if (pipe_ctx->top_pipe == NULL) {
-		if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
-				link->forced_psr_active)) {
-			dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
-			pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
+		dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
-			pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
-		}
+		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
+
+		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
 		if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
 			pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 823ef06c64f5..b6f3c0480ab6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -537,11 +537,9 @@ static void dcn31_reset_back_end_for_pipe(
 	}
 	ASSERT(!pipe_ctx->top_pipe);
 
-	link = pipe_ctx->stream->link;
+	dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
-	if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
-	      link->forced_psr_active))
-		dc->hwss.set_abm_immediate_disable(pipe_ctx);
+	link = pipe_ctx->stream->link;
 
 	if (dc->hwseq)
 		dc->hwseq->wa_state.skip_blank_stream = false;
@@ -557,11 +555,9 @@ static void dcn31_reset_back_end_for_pipe(
 			pipe_ctx->stream_res.tg,
 			OPTC_DSC_DISABLED, 0, 0);
 
-	if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
-	      link->forced_psr_active)) {
-		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
-		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
-	}
+	pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
+
+	pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
 	if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
@@ -590,12 +586,7 @@ static void dcn31_reset_back_end_for_pipe(
 	 * screen only, the dpms_off would be true but
 	 * VBIOS lit up eDP, so check link status too.
 	 */
-	if (link->connector_signal == SIGNAL_TYPE_EDP &&
-	    link->forced_psr_active) {
-		/* forced psr is active for seamless switch; skip dpms-off. */
-		if (pipe_ctx->stream_res.audio)
-			dc->hwss.disable_audio_stream(pipe_ctx);
-	} else if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+	if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 		dc->link_srv->set_dpms_off(pipe_ctx);
 	else if (pipe_ctx->stream_res.audio)
 		dc->hwss.disable_audio_stream(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 583007c1fee3..de7dde2b036b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -531,11 +531,9 @@ void dcn314_disable_link_output(struct dc_link *link,
 		link->dc->hwss.edp_backlight_control(link, false);
 	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
-	if (!(signal == SIGNAL_TYPE_EDP &&
-		link->forced_psr_active)) {
-		link_hwss->disable_link_output(link, link_res, signal);
-		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
-	}
+
+	link_hwss->disable_link_output(link, link_res, signal);
+	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 	/*
 	 * Add the logic to extract BOTH power up and power down sequences
 	 * from enable/disable link output and only call edp panel control
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index e7bf865755d4..9135b01fe388 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1463,11 +1463,8 @@ void dcn32_disable_link_output(struct dc_link *link,
 	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
 
-	if (!(signal == SIGNAL_TYPE_EDP &&
-		link->forced_psr_active)) {
-		link_hwss->disable_link_output(link, link_res, signal);
-		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
-	}
+	link_hwss->disable_link_output(link, link_res, signal);
+	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 	/*
 	 * Add the logic to extract BOTH power up and power down sequences
 	 * from enable/disable link output and only call edp panel control
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index fbf4d0f95c5c..aa047b5b4939 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1849,11 +1849,8 @@ void dcn35_disable_link_output(struct dc_link *link,
 		disable_link_output_symclk_on_tx_off(link, DP_UNKNOWN_ENCODING);
 		link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
 	} else {
-		if (!(signal == SIGNAL_TYPE_EDP &&
-		      link->forced_psr_active)) {
-			link_hwss->disable_link_output(link, link_res, signal);
-			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
-		}
+		link_hwss->disable_link_output(link, link_res, signal);
+		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 	}
 	/*
 	 * Add the logic to extract BOTH power up and power down sequences
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index d515b9cbc934..f8254dfe1ce7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -413,9 +413,7 @@ enum dc_status dcn60_apply_single_controller_ctx_to_hw(
 			dc_is_virtual_signal(pipe_ctx->stream->signal)))
 			dc->link_srv->set_dsc_enable(pipe_ctx, true);
 	}
-	if (!stream->dpms_off &&
-	    !(link->connector_signal == SIGNAL_TYPE_EDP &&
-	      link->forced_psr_active))
+	if (!stream->dpms_off)
 		dc->link_srv->set_dpms_on(context, pipe_ctx);
 
 	/* DCN3.1 FPGA Workaround
-- 
2.43.0

