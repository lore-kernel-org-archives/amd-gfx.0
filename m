Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A19C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AE210F0A2;
	Wed, 15 Jul 2026 13:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HiOr75We";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9E410F0A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJME6t4BiufckoQGTzkF8bgheEjrvhOzDPWDGZENYpFdy94swZhWSdvIARidJG2ypH5IMVH8NhUDQn1/hMrxgxQs2ChGyUDkUNEKhb7o+EtejHdYpbLXlaek96Ebi6VPTWfpfPBLoMINj/TmoNPNXIiIBkiTzSDBCcZPV28YCSc1L8S5mNhv+DsIu38zN8uq/TQcKx8JstJpi6uBIEwFsGuejNKY5hzhYLSuU/fkJ6QlyxoJ3edGj5V0uklt2KaPpCHMusJlh7CZpcZTHosX+N3tSyIWxxHCQJXcOcIJ9nkbIXcJnbkXyHCpSL29aBjTzvXbqgp8vaSnpNpFztuFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PkyZWg/ebOY7Iu9hnLvYgqVjwZ8Rw2qIPi1118JXMQ=;
 b=jPV0FBEIP+naeQTraeDJ18gooVlnN8GD+jkzhzCPXfb5Fcz6l4CEnAcdcKNFwitd/V9AwP+RToDnINuCRQz+v7WPawzYzoX2QqPcxkmfjn2ju2TsSElq9js4mpH2f+seP6ocHWloV2a71uxG7Ib1puERoqGJw1opfaoMuSXIXFm48yjxa/aWcSgDBMUcilLKJjfI4z+TG6kQZFINovTbhoX7sV5W9aoYd98fuPrCJ+mDKu/uP8WIEP6pJGt5lYgJoGgxcUlnV6BjUd4nu3wrNwguLe5ZUeM+29uaNJTxcqZCi7y2C19rRoLGWtxsBaA7zk5qX0Yc3UNxsDwqm+o/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PkyZWg/ebOY7Iu9hnLvYgqVjwZ8Rw2qIPi1118JXMQ=;
 b=HiOr75WekXhhy2i650Y/nKd5QyFMIS7SsQl522QB63bijP3f3gipuPI+AIkUFGbjBEkTKCfJiPpPrwRmwUlRBSVJHuWTW5574hhQcssu1F7lHa3NZ/kLVKzkia5pJ9CUK7Gw9DIzeUt/x2a+aMP/CI+2AJVZcabgdaoIuJbiaeQ=
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by SA5PPF8DEAB7A29.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Wed, 15 Jul
 2026 13:48:22 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::ac) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:01 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:57 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Justin Chen <Justin.Chen5@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Yihan Zhu <yihan.zhu@amd.com>
Subject: [PATCH 50/70] drm/amd/display: Revert Fix DMSS not triggering for HDR
 to SDR transition
Date: Wed, 15 Jul 2026 21:38:00 +0800
Message-ID: <20260715134432.1975118-51-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SA5PPF8DEAB7A29:EE_
X-MS-Office365-Filtering-Correlation-Id: 892d7f69-52cf-402b-71cc-08dee277bc96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|22082099003|18002099003|3023799007|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: Vw0kCpxu34PNau10nCemVqfoB3igMqrzXOAydj0Dn3UGi4Drx4czHPL9nz2+oR71yNlnXZyRoLpOJIYuYeDwwMoMURN2r6biTVZYqhDjvC5gVCQYe6X6FzxWnwrA8W7x9J02O7gYZ95w94o97SZnUO7fCR3D1E6xv/bTA2HXZueYacEv7z/ouSi2ChFveLUtPWfsIVYIiTR6BDOsO9NfhlwKYNezhado88evLok0sJlMm+cN8m2DiEdLt67rqdGPnWS4K2D3COX0F+U13ajYvx7Tz63S/ZqknWaHPPNv2vIig+vVi0+dN52gtNOqJyNgQiBroQRRz/p94FiN6vYGfxZY2fQskSPbAEX5GUPm7Gbhp1WlQUDd3gEQmKfJdqH7vcaQjLNFFb85+fo+Y4Ubl+DSDl5hQxf/2Nk96oS3MyAS+HUJswAGH7NaDYHIPTmIYSX0kSXVeDCR+s+yDZSY2u3Bkz7NNzBtSFiKoGqsp991QbB/Ndk1E/sH5x4l7Fxrbo6uIusY8eeaCZnpjBzilfTMSCA4/hOAtr7ZUpYimhRStQKeF3Jpb50/yK7TuXa5pYsBWrE36BaRORw0mZlVLXfAOmLH6ts/Y/zBIh9dMOdUkeXezOkUM5OdwXcxu8DagcD+ZzD0XGbMw0qYFYk5aptkGiTDzaU88yf3SuAGYmaOMK8ShOnBZmcskUz7Bgrfa6uh+lc5A6Vsk4vkNWmQcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Elmp715p7Z4eTvi3b5dR0TGlXXrq+pjF+A/qmDdumpKIn9lbSeEBGDCsXQlXu7O5Hl5B7HjMRMhcSPTaBPrFkFjBWOvLorB8w/0orpq2Jqg4I48H7ZbyvUq/lyiRIQ9u75SAIe66I4U+vTcZtMKbMsYq4fcOhjowglLfRRyArRKXfCeqlCSwBx4+iB7GvPcRAjBu7I4AhXUb7iJwK5fHO1K1zL9e9KNOedQPDf3xBy3KHrpP3CbfJcI/BH/Yhi868a3hCpEH3iz8oX+yC9bDAopjonpL4ZuU/Hp+ig6/x5Y1y1kS3VavY88X6WvjNWcVIWLmgttxMyYFV8GvzziUK/hPSdbzYGbmP9G0lLHqQW0BoEnFKLLzRke4HM8BvPkzxPrGfATgul+ueUO8I0qNMQh6UYng6NuKCqC5GXE7/MVs/7KpooM49gJqv7efMNsv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:22.5275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 892d7f69-52cf-402b-71cc-08dee277bc96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8DEAB7A29
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

From: Justin Chen <Justin.Chen5@amd.com>

Reverting this commit as it causes a regression lighting up eDP panels:
This reverts commit 1fecc9989637 (drm/amd/display: Fix DMSS not triggering
for HDR to SDR transition)

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Justin Chen <Justin.Chen5@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 12 +++-------
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 21 +++++------------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  7 ++----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 23 +++++--------------
 .../drm/amd/display/modules/power/power_psr.c |  7 ------
 .../amd/display/modules/power/power_replay.c  |  7 ------
 6 files changed, 17 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 4830a0d94177..262982ca5ad9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1286,9 +1286,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 		return;
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-		if (link->skip_implict_edp_power_control)
-			return;
-		if (hws)
+		if (!link->skip_implict_edp_power_control && hws)
 			hws->funcs.edp_backlight_control(link, false);
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}
@@ -1794,9 +1792,7 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 			dc->link_srv->set_dsc_enable(pipe_ctx, true);
 	}
 
-	if (!stream->dpms_off &&
-	    !(link->connector_signal == SIGNAL_TYPE_EDP &&
-	      link->skip_implict_edp_power_control))
+	if (!stream->dpms_off)
 		dc->link_srv->set_dpms_on(context, pipe_ctx);
 
 	/* DCN3.1 FPGA Workaround
@@ -1815,9 +1811,7 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 	 * is constructed with the same sink). Make sure not to override
 	 * and link programming on the main.
 	 */
-	if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM &&
-	    !(link->connector_signal == SIGNAL_TYPE_EDP &&
-	      link->skip_implict_edp_power_control)) {
+	if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM) {
 		pipe_ctx->stream->link->psr_settings.psr_feature_enabled = false;
 		pipe_ctx->stream->link->replay_settings.replay_feature_enabled = false;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 6f1ad651ed2c..b6f3c0480ab6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -537,11 +537,9 @@ static void dcn31_reset_back_end_for_pipe(
 	}
 	ASSERT(!pipe_ctx->top_pipe);
 
-	link = pipe_ctx->stream->link;
+	dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
-	if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
-	      link->skip_implict_edp_power_control))
-		dc->hwss.set_abm_immediate_disable(pipe_ctx);
+	link = pipe_ctx->stream->link;
 
 	if (dc->hwseq)
 		dc->hwseq->wa_state.skip_blank_stream = false;
@@ -557,11 +555,9 @@ static void dcn31_reset_back_end_for_pipe(
 			pipe_ctx->stream_res.tg,
 			OPTC_DSC_DISABLED, 0, 0);
 
-	if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
-	      link->skip_implict_edp_power_control)) {
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
-	    link->skip_implict_edp_power_control) {
-		/* DMSS is holding the panel across the commit; skip dpms-off. */
-		if (pipe_ctx->stream_res.audio)
-			dc->hwss.disable_audio_stream(pipe_ctx);
-	} else if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+	if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 		dc->link_srv->set_dpms_off(pipe_ctx);
 	else if (pipe_ctx->stream_res.audio)
 		dc->hwss.disable_audio_stream(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 4ed7480d1efa..f14c39a643da 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1818,11 +1818,8 @@ void dcn35_disable_link_output(struct dc_link *link,
 		disable_link_output_symclk_on_tx_off(link, DP_UNKNOWN_ENCODING);
 		link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
 	} else {
-		if (!(signal == SIGNAL_TYPE_EDP &&
-		      link->skip_implict_edp_power_control)) {
-			link_hwss->disable_link_output(link, link_res, signal);
-			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
-		}
+		link_hwss->disable_link_output(link, link_res, signal);
+		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 	}
 	/*
 	 * Add the logic to extract BOTH power up and power down sequences
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 161ef57ebce1..54afd42d73ed 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1102,11 +1102,8 @@ void dcn401_disable_link_output(struct dc_link *link,
 		disable_link_output_symclk_on_tx_off(link, DP_UNKNOWN_ENCODING);
 		link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
 	} else {
-		if (!(signal == SIGNAL_TYPE_EDP &&
-		      link->skip_implict_edp_power_control)) {
-			link_hwss->disable_link_output(link, link_res, signal);
-			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
-		}
+		link_hwss->disable_link_output(link, link_res, signal);
+		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 	}
 
 	if (signal == SIGNAL_TYPE_EDP &&
@@ -2154,12 +2151,7 @@ void dcn401_reset_back_end_for_pipe(
 	 * screen only, the dpms_off would be true but
 	 * VBIOS lit up eDP, so check link status too.
 	 */
-	if (link->connector_signal == SIGNAL_TYPE_EDP &&
-	    link->skip_implict_edp_power_control) {
-		/* DMSS is holding the panel across the commit; skip dpms-off. */
-		if (pipe_ctx->stream_res.audio)
-			dc->hwss.disable_audio_stream(pipe_ctx);
-	} else if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+	if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 		dc->link_srv->set_dpms_off(pipe_ctx);
 	else if (pipe_ctx->stream_res.audio)
 		dc->hwss.disable_audio_stream(pipe_ctx);
@@ -2184,15 +2176,12 @@ void dcn401_reset_back_end_for_pipe(
 	 * parent pipe.
 	 */
 	if (pipe_ctx->top_pipe == NULL) {
-		if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
-		      link->skip_implict_edp_power_control)) {
 
-			dc->hwss.set_abm_immediate_disable(pipe_ctx);
+		dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
-			pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
+		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
-			pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
-		}
+		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
 		if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
 			pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_psr.c b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
index 0ad4c4924696..5ecb570c204e 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_psr.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
@@ -58,13 +58,6 @@ bool mod_power_psr_notify_mode_change(struct mod_power *mod_power,
 	// stream_index is passed as validated parameter
 	active_psr_events = core_power->map[stream_index].psr_events;
 
-	/* DMSS holds the panel in a forced PSR freeze (e.g. during HDR/SDR toggle).
-	 * Re-running edp_setup_psr would reprogram DPCD 0x170 and disturb the freeze,
-	 * so skip the PSR re-setup until DMSS releases the override.
-	 */
-	if (active_psr_events & psr_event_os_override_hold)
-		return false;
-
 	/* Calculate PSR configurations */
 	mod_power_calc_psr_configs(&psr_config, link, stream);
 
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_replay.c b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
index 1ad2ee01d560..e782501442c4 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_replay.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_replay.c
@@ -805,13 +805,6 @@ void mod_power_replay_notify_mode_change(struct mod_power *mod_power,
 	core_power = MOD_POWER_TO_CORE(mod_power);
 	active_replay_events = core_power->map[stream_index].replay_events;
 
-	/* DMSS holds the panel in a forced freeze (e.g. during HDR/SDR toggle).
-	 * Re-running dp_setup_replay would reprogram DPCD 0x37B and disturb the
-	 * freeze, so skip the replay re-setup until DMSS releases the override.
-	 */
-	if (active_replay_events & replay_event_os_override_hold)
-		return;
-
 	link->replay_settings.replay_smu_opt_enable =
 		(link->replay_settings.config.replay_smu_opt_supported &&
 		mod_power_only_edp(dc->current_state, stream));
-- 
2.43.0

