Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0318FC44506
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD1710F702;
	Thu,  9 Jul 2026 21:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y6OxzGyp";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6316110F6F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUAZpigvZIbNuV7dg+Cr1Th+EZ/TatuPV/0n5FT7kX2eXXX3bySXIOz3XkXL45aQN6GiRw2a+7Twd5Cgt6bYktSFQOP81wJ3Npi6V1CWPf5ADk7b1dDSdlwfwd7RVJVWWpmmZ3dD1oB+CKC6z/vrD+ZHbNKqsMMVYbOr/7cstMOpA9DMgRvqIHwd0iENLT301F4O1Y8IcQvjlvUz8aN732nS3sggvINM3SW1EcKMHa0D49d6rD5I/EG8Sfjm/j5mmqms0y4Ptwzbc4+PTeGNDToFjmsCjN1Ynmyxe2PI9aRoY8RmdFLOeR/EkVF4TN/tVChK6KaRPsCu5h880uFLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88oXVeYYXU62zHRnGxZQFK0eWez/eMzFM16G4nhRtOQ=;
 b=gKS+qQEfh9e1g14IzABNOsNQEI35PD/67NTQ1Xfy+oQaatmA0EE9YEyoPad6haj/LZoL/DoYyMndSpgCkTXwyB0rkLsB7EE/M8iAZ5wQb6En++CaB63xJ4BrM4Tr6dx0yEKUTXEuO4p5uAiN4O7tfpdKDLSHuYM2mP0+MHZl8eD6E81PvEPYQ9OtgS9RDWgqEGgKp0iRqcnBRm01ktY6c2+fBbTEkN14j6uylJRBs6rZUSlj4X+8Tsm5xx8Gwgv84+d2iX6RBNwMXD4fi/WyItlRt4idTKqFgpQfNwrX8jz52Vkx5y1Ej+qyGnsOtJcZ+sa4h2NQGIB/oJu+BDk3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88oXVeYYXU62zHRnGxZQFK0eWez/eMzFM16G4nhRtOQ=;
 b=Y6OxzGypyQjz0CtKfptoAeUtqhLlcFrdkMv9JfbnvkAgPUBSwWdFUPYiSnCbmbgootI1cMdOSvvpY/m4ppoVZ2ePEpAivaSPSFjZDhI6ngWtiNn5ACgkoF6hMBRpY87QpyvXVmsSUJ40nel9h6ngo/xBZvX4rEO1zs4f6oL2VcE=
Received: from MN0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:208:52d::25)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 9 Jul
 2026 21:02:38 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::4) by MN0PR04CA0010.outlook.office365.com
 (2603:10b6:208:52d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:38 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:32 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Karthi Kandasamy <karthi.kandasamy@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 73/80] drm/amd/display: Fix DMSS not triggering for HDR to SDR
 transition
Date: Thu, 9 Jul 2026 16:48:41 -0400
Message-ID: <20260709205936.5719-74-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a9f153-0635-4094-c3e5-08deddfd68a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|3023799007|22082099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: gP4ZEokM3OKkyNUiMcjzfjnsFHSuk5OqvAgaNgUMr5ppMeFTKQoewpSB03MmBcYfXkddZEO+uP/GZ16Rz8EAK9BTgjbj6EgGrBolfbvLIHHolf3sOckMYtCo/jjFBTRp2HVqPglZN/04e4GGjJI07ZfMLPp62j0Z4Zq7HNZJcTTuNYHVOcjNrosMEz62/c8Et36LUPQ4i2eR0rv3F+hNtciDiKjmgx4QLRHJl4fz6+CqoRUPYB846SKFGYuXSdadvUoKthvBSgkIgwzrAmohc1IdR+mcwRmCK5S0SDqdG2y8mW9w+vww7kp1zZo9i+eUWaM5cQD48o6L4MZJuDbFlKahDt594vzkEfXRVba4U2PnwbLOMymvSMpbxO76z0QZTHPVUVOvDgFGe+pPsJH0ykfTKng3L0Nv+mu17oNCZOoV7QxPLsEd0AZuWZgkZ5OLF4EcZLjsF59WytPbo+P5xyZ/PaOPlxvPFmmkiM/yMoHErqnwAmp0bxY2YiHyc4DivMPTcXu5OPsvvRy77QrVc3AiUY6bPEw2VHlMXN071o8lQrhnF/VU6LjRFqdkLuKD4fgr6Gcs7sFZ+auVCJZGiQK7MdMeabxZHG44Yvnv5sDXmlXGiC6Np/9WrazCpj/VQfTcb46HWyBI0i6m7Pg7MYjU3JDfeF+g6IaNK912dzKlUQkrPBo1Sp4jkQsRaQEqBdLynfEMH04AepHLukw4iA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(3023799007)(22082099003)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3C20H3fDe0AEXZH3pmM7hZQhm7+2jMqrloq62lqULdnsSb5MR6ePNSRwt/sW6QrKlwzSrmayO0ENzrKCHeP9BJdMdFIhErCKi8m8hn6TYDtAME+5hJclfPyZW3N7Cb84z44cZlBV82+81KmG9uXxvhbMU+AD4FY6v9mArNqg0bogb0NCKLnKpIXDqukCE0rWHaQgRvhXf1QIoJT4IUwGpedHJ97m+/8nNV+o8Rb1HwgskL72wGPoGDoVn54C/HxcVqq78Evt7tJYOVNgue/Ino3q99onxbcuRe2u2v2IKf6EinylYL8Azazyo/HQu93nCVY6M0kBJX3IcO1C1kSFyD5QCrEYBfvBu0Li4rPGz4m5RxIuVk3ah29XVvQJ+7ZnNqbRlquzmsnPz/iOfXuuOJCH1szXPWSdhTVIzFS3kXbFDaLo8lwmGNJxZg/eKxT7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:38.5050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a9f153-0635-4094-c3e5-08deddfd68a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980
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

Why:
DMSS feature was not getting triggered during HDR to SDR transitions,
and no DPCD write was observed. Root cause analysis revealed that
incorrect panel capabilities were being reported for PSR SU panels.
Due to the wrong capabilities, the OS was not invoking the DMSS API,
resulting in no DPCD communication and also gate eDP teardown across
DMSS hold

How:
Fixed by setting the correct power panel capabilities for PSR SU panels.
This ensures the OS receives accurate panel capability information and
triggers the DMSS API as expected, restoring proper DPCD writes during
HDR to SDR transitions.
The DC commit sequence,was tearing the eDP down anyway -- backlight off, ABM disable,
DPMS off, PSR/Replay feature_enabled cleared, PHY TX off, OTG/OPTC off
all these actions are blocked now with the skip_implict_edp_power_control

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 12 +++++++---
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 21 ++++++++++++-----
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  7 ++++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 23 ++++++++++++++-----
 .../drm/amd/display/modules/power/power_psr.c |  7 ++++++
 .../amd/display/modules/power/power_replay.c  |  7 ++++++
 6 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index c9691974bf72..cce4f3065575 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1287,7 +1287,9 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 		return;
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-		if (!link->skip_implict_edp_power_control && hws)
+		if (link->skip_implict_edp_power_control)
+			return;
+		if (hws)
 			hws->funcs.edp_backlight_control(link, false);
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}
@@ -1793,7 +1795,9 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 			dc->link_srv->set_dsc_enable(pipe_ctx, true);
 	}
 
-	if (!stream->dpms_off)
+	if (!stream->dpms_off &&
+	    !(link->connector_signal == SIGNAL_TYPE_EDP &&
+	      link->skip_implict_edp_power_control))
 		dc->link_srv->set_dpms_on(context, pipe_ctx);
 
 	/* DCN3.1 FPGA Workaround
@@ -1812,7 +1816,9 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 	 * is constructed with the same sink). Make sure not to override
 	 * and link programming on the main.
 	 */
-	if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM) {
+	if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM &&
+	    !(link->connector_signal == SIGNAL_TYPE_EDP &&
+	      link->skip_implict_edp_power_control)) {
 		pipe_ctx->stream->link->psr_settings.psr_feature_enabled = false;
 		pipe_ctx->stream->link->replay_settings.replay_feature_enabled = false;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index b6f3c0480ab6..6f1ad651ed2c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -537,10 +537,12 @@ static void dcn31_reset_back_end_for_pipe(
 	}
 	ASSERT(!pipe_ctx->top_pipe);
 
-	dc->hwss.set_abm_immediate_disable(pipe_ctx);
-
 	link = pipe_ctx->stream->link;
 
+	if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
+	      link->skip_implict_edp_power_control))
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
+	      link->skip_implict_edp_power_control)) {
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
+	    link->skip_implict_edp_power_control) {
+		/* DMSS is holding the panel across the commit; skip dpms-off. */
+		if (pipe_ctx->stream_res.audio)
+			dc->hwss.disable_audio_stream(pipe_ctx);
+	} else if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 		dc->link_srv->set_dpms_off(pipe_ctx);
 	else if (pipe_ctx->stream_res.audio)
 		dc->hwss.disable_audio_stream(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index f14c39a643da..4ed7480d1efa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1818,8 +1818,11 @@ void dcn35_disable_link_output(struct dc_link *link,
 		disable_link_output_symclk_on_tx_off(link, DP_UNKNOWN_ENCODING);
 		link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
 	} else {
-		link_hwss->disable_link_output(link, link_res, signal);
-		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		if (!(signal == SIGNAL_TYPE_EDP &&
+		      link->skip_implict_edp_power_control)) {
+			link_hwss->disable_link_output(link, link_res, signal);
+			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		}
 	}
 	/*
 	 * Add the logic to extract BOTH power up and power down sequences
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 632f183fe755..1862670ea042 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1101,8 +1101,11 @@ void dcn401_disable_link_output(struct dc_link *link,
 		disable_link_output_symclk_on_tx_off(link, DP_UNKNOWN_ENCODING);
 		link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
 	} else {
-		link_hwss->disable_link_output(link, link_res, signal);
-		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		if (!(signal == SIGNAL_TYPE_EDP &&
+		      link->skip_implict_edp_power_control)) {
+			link_hwss->disable_link_output(link, link_res, signal);
+			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		}
 	}
 
 	if (signal == SIGNAL_TYPE_EDP &&
@@ -2150,7 +2153,12 @@ void dcn401_reset_back_end_for_pipe(
 	 * screen only, the dpms_off would be true but
 	 * VBIOS lit up eDP, so check link status too.
 	 */
-	if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+	if (link->connector_signal == SIGNAL_TYPE_EDP &&
+	    link->skip_implict_edp_power_control) {
+		/* DMSS is holding the panel across the commit; skip dpms-off. */
+		if (pipe_ctx->stream_res.audio)
+			dc->hwss.disable_audio_stream(pipe_ctx);
+	} else if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 		dc->link_srv->set_dpms_off(pipe_ctx);
 	else if (pipe_ctx->stream_res.audio)
 		dc->hwss.disable_audio_stream(pipe_ctx);
@@ -2175,12 +2183,15 @@ void dcn401_reset_back_end_for_pipe(
 	 * parent pipe.
 	 */
 	if (pipe_ctx->top_pipe == NULL) {
+		if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
+		      link->skip_implict_edp_power_control)) {
 
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
index 5ecb570c204e..0ad4c4924696 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_psr.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
@@ -58,6 +58,13 @@ bool mod_power_psr_notify_mode_change(struct mod_power *mod_power,
 	// stream_index is passed as validated parameter
 	active_psr_events = core_power->map[stream_index].psr_events;
 
+	/* DMSS holds the panel in a forced PSR freeze (e.g. during HDR/SDR toggle).
+	 * Re-running edp_setup_psr would reprogram DPCD 0x170 and disturb the freeze,
+	 * so skip the PSR re-setup until DMSS releases the override.
+	 */
+	if (active_psr_events & psr_event_os_override_hold)
+		return false;
+
 	/* Calculate PSR configurations */
 	mod_power_calc_psr_configs(&psr_config, link, stream);
 
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_replay.c b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
index e782501442c4..1ad2ee01d560 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_replay.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
@@ -805,6 +805,13 @@ void mod_power_replay_notify_mode_change(struct mod_power *mod_power,
 	core_power = MOD_POWER_TO_CORE(mod_power);
 	active_replay_events = core_power->map[stream_index].replay_events;
 
+	/* DMSS holds the panel in a forced freeze (e.g. during HDR/SDR toggle).
+	 * Re-running dp_setup_replay would reprogram DPCD 0x37B and disturb the
+	 * freeze, so skip the replay re-setup until DMSS releases the override.
+	 */
+	if (active_replay_events & replay_event_os_override_hold)
+		return;
+
 	link->replay_settings.replay_smu_opt_enable =
 		(link->replay_settings.config.replay_smu_opt_supported &&
 		mod_power_only_edp(dc->current_state, stream));
-- 
2.55.0

