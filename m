Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD840C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7010910F088;
	Wed, 15 Jul 2026 13:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hWgbqQBV";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F25A10F083
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tye+bH1Qjl84uUSSgDDm3V0hg8j3RI8YjBThSLR4zOFmu/95085QvrlvvF24GPl5KVxnh21kZ67O23NbPY1o7eu/JL72v5J7LCOeKQQwtboBhZxHGQrfkR81rTvmH6NBC7k01AOy5wBSMR5TD8QnjpfvjSBdS4+p9UNF+W3rtRdGYIHAQ2Ep+J5o7GuLsmnYWLVkDxRAnzz7hlYEp1XESOOVaHXsRb0IBUnl5YwPzwoAnvf+Iw2tAK82uWSdy7+FWf9zosoSJx3/EMWcvSfzDYTAcx4vMwW/w8yIerztCBJbE5pmf/UuInV2++hNK0yu2CZRamaU7oZCxNzBrSN7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf8cwstddYF7ENUobYjadQvwGCQqyfQgcl8cuTckm/Y=;
 b=Hb03nVU3Yk4Dgd6HklNJpqYeHpS4jUc34Y+mZ9zSFHqkn2hu/ML0lDuu5uXhYjOVnbW4kyGmziefHqLpjt52ubwEaApa2M0Zs+YtBWod6Yu2bFoGk/52eOtk9fC5peEsnniiFrOom1gOUyc4LZeqp+hU5lmfG+uQ1ZCbR1a22GRZCO9k4IGyskoTa/4K7cISEt4RELd7kIz4jAcyXnS4Wr4TyUtaLT4iZsp38sBXRd54aWvmLIXLhyV410/9QGMpHE1/Qe1VOgWsAu7BpV32SbPXleFB35qcHAG170uQW6qxd+bVtIYrCYTrIwwOPhkDruXlPvZA6TJCZRB6UyiFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf8cwstddYF7ENUobYjadQvwGCQqyfQgcl8cuTckm/Y=;
 b=hWgbqQBVrhqQUU+qkVtg6Yag6vuh683t6dOMbgRY6dMvSVLbDihCvtNfFrBg3++wPJy6sCCPz6ka6Y75rw4lxuSBvZa+KMCm4q38/PM/FUpg5zNn97tLHd/zYCd83vp8h7ZRCCyiGxa/KY6ZRkNWIWWLxZ133NOCY1nm3e+vGRE=
Received: from SJ0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:33b::24)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:46:30 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::6) by SJ0PR05CA0019.outlook.office365.com
 (2603:10b6:a03:33b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:24 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:20 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, "Alvin
 Lee" <alvin.lee2@amd.com>
Subject: [PATCH 24/70] drm/amd/display: Split DPMS ON into parts
Date: Wed, 15 Jul 2026 21:37:34 +0800
Message-ID: <20260715134432.1975118-25-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: fc32b81b-9edd-4b24-e55d-08dee277799c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: XLqW9kzpA1Qk3GGksR4LYXTK8Te4kbPcvYq+uHGtyuVN1DDkJ/Rn67tI8CoXTBv+38oDY0Y3Yb5IU7y3D29tx1OG3cptPmBgCaQs0a6/eRAOV0mQlCdQNNz9LEq3Q1OC1R5MZeatbAQd58wGF9UKvYdGeJJGBFyXMYommOYECUqe+3V42UXhPOM8+9MBWST8lokcxPAIU6QDdZwUg+CErPrmNvKSZXcHqUmyO7lNDRwDgpd4KOzsdZd+4KqXUtYb2a8n+UwAhuSl5Eyzzkhc0s9uwVNN6lzxjH1y24iY49E+MY/tMFM8acrY4TvfJp4zTl2r1W0Eq/ONZchzyhP76/BPD/Xi0hWiR/tMMEjuKhKeRhmc6lo67IKCdZIQHL+IpkgbYPcvtKQoIDrJt94iHv3e0NncHHCA072lvFaRz0lAEXnddP0SiNR5baoe+P3IflAWwvhdTpYY8ilz56molHXAxer2N2aeyXCfq38GuhqUCTYbBEK6tKOw55phYTfxvsdcgItwBI6Jfy0tbANxZevaFN5JWzpu2+GQUqMF64lfu/fKqEQf+mjI8RZaB00B0RqPTkB2ZTAOBVXdNB0Ei++13wMLOwUn1zv8bJ7ONTl2IkemS6vE/0GViptXRKMthX+t+jWJEfYrnerpG+P8sc9VEqI5WArlytDiLoNwswTZVFF9TtjOncpzKwOAE/o5hGGSIb22tLfzwHrxcMZzAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JQZ57cnAwROgwFnV3ZH9n1tbC+o4EiEwj84KYhI++OPjI6/DYvQC/3/O9Zf43F2Rl1LYV3bWcKnqzaMZFL+1BRphyJG/KlzOJJctmRTrVcxXHkpQcq+9lbK5cwxkU5pDbv2mETzXL9tWwvhzTu9cChs7oeFsm88XVW+wFF6ztzILaimx/rdDEnEhmKYZB3UMzwXkO7PoTpDFDCSRQGmpni64dbG0xhfW2JAmcSRzHuYng9Qt/y4Gy4ZU5o4egoqXaPb3HjNigDWyR4tk1cjfZuBfemOnDZHbf8P0pvWvy3FZAjs4urVJ/EjJWIJa7t2h/MUw9DJQkyiaRSQupTb52D6pF4zod9cJ7PjRfN2zvzNQthkP2/97Y/VVtrYfDvb0ZcGWGK4bOvcqH9/q0Ro+W9Ny1xkb7HLYOazkb3lQI7m12AyTRrxnjGynCrj/U0Qs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:30.1848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc32b81b-9edd-4b24-e55d-08dee277799c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why]
Ongoing optimization efforts require splitting DPMS ON around
enable_link, in order to enable running multiple sequences
in parallel.

[How]
* Split link_set_dpms_on across enable_link
* Add return value indicating whether the programming sequence
succeeded and/or run to the end.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/inc/core_status.h  |  10 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |   4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 184 ++++++++++++++----
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |   4 +-
 4 files changed, 156 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_status.h b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
index 388f801f4582..1a17e727ed04 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_status.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
@@ -62,6 +62,16 @@ enum dc_status {
 	DC_FAIL_DP_LINK_BANDWIDTH = 28,
 	DC_FAIL_HW_CURSOR_SUPPORT = 29,
 	DC_FAIL_DP_TUNNEL_BW_VALIDATE = 30,
+
+	/// Link protocol handshake and DPMS hardware programming successful.
+	DC_DPMS_SUCCESS = DC_OK,
+	/// Handshake skipped by optimized path, programming successfully completed.
+	DC_DPMS_SKIPPED_HANDSHAKE = 31,
+	/// Handshake failed, programming successful, DCN in consistent state.
+	DC_DPMS_FAILED_HANDSHAKE = 32,
+	/// Handshake failed, programming aborted, DCN may be in inconsistent state.
+	DC_DPMS_FAILED_INCOMPLETE = 33,
+
 	DC_ERROR_UNEXPECTED = -1
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index addeb3e3b25a..026d28046eea 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -155,8 +155,8 @@ struct link_service {
 
 
 	/*************************** DPMS *************************************/
-	void (*set_dpms_on)(struct dc_state *state, struct pipe_ctx *pipe_ctx);
-	void (*set_dpms_off)(struct pipe_ctx *pipe_ctx);
+	enum dc_status (*set_dpms_on)(struct dc_state *state, struct pipe_ctx *pipe_ctx);
+	enum dc_status (*set_dpms_off)(struct pipe_ctx *pipe_ctx);
 	void (*resume)(struct dc_link *link);
 	void (*blank_all_dp_displays)(struct dc *dc);
 	void (*blank_all_edp_displays)(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 335ae952ef60..949c669eb259 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -528,19 +528,27 @@ static bool write_i2c_redriver_setting(
 	return success;
 }
 
+static struct link_encoder *get_link_encoder(struct pipe_ctx *pipe_ctx)
+{
+	struct link_encoder *link_enc
+			= pipe_ctx->stream->ctx->dc->config.unify_link_enc_assignment
+			? pipe_ctx->link_res.dio_link_enc
+			: link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
+
+	ASSERT(link_enc);
+	return link_enc;
+}
+
 static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 {
 	struct cp_psp *cp_psp = &pipe_ctx->stream->ctx->cp_psp;
-	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
+	struct link_encoder *link_enc = get_link_encoder(pipe_ctx);
 	struct cp_psp_stream_config config = {0};
 	enum dp_panel_mode panel_mode =
 			dp_get_panel_mode(pipe_ctx->stream->link);
 
 	if (cp_psp == NULL || cp_psp->funcs.update_stream_config == NULL)
 		return;
-	if (!pipe_ctx->stream->ctx->dc->config.unify_link_enc_assignment)
-		link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
-	ASSERT(link_enc);
 	if (link_enc == NULL)
 		return;
 
@@ -2375,7 +2383,7 @@ static struct vpg *get_vpg(struct pipe_ctx *pipe_ctx)
 		return pipe_ctx->stream_res.stream_enc->vpg;
 }
 
-void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
+enum dc_status link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 {
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 	struct dc_stream_state *stream = pipe_ctx->stream;
@@ -2387,7 +2395,8 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	ASSERT(is_master_pipe_for_link(link, pipe_ctx));
 
 	if (dc_is_virtual_signal(stream->signal))
-		return;
+		/* No real hardware to program for virtual signals. */
+		return DC_DPMS_SKIPPED_HANDSHAKE;
 
 	if (stream->sink) {
 		if (stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
@@ -2481,18 +2490,23 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		/* since current psp not loaded, we need to reset it to default */
 		link->panel_mode = panel_mode;
 	}
+
+	return DC_DPMS_SUCCESS;
 }
 
-void link_set_dpms_on(
+static enum dc_status link_set_dpms_on_pre_enable_link(
 		struct dc_state *state,
-		struct pipe_ctx *pipe_ctx)
+		struct pipe_ctx *pipe_ctx
+)
 {
+	// Used conditionally in ifdef'ed diagnostic builds
+	(void) state;
+
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc *dc = stream->ctx->dc;
 	struct dc_link *link = stream->link;
-	enum dc_status status;
-	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
+
 	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
 	struct vpg *vpg = get_vpg(pipe_ctx);
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
@@ -2502,7 +2516,8 @@ void link_set_dpms_on(
 	ASSERT(is_master_pipe_for_link(link, pipe_ctx));
 
 	if (dc_is_virtual_signal(stream->signal))
-		return;
+		/* No real hardware to program for virtual signals. */
+		return DC_DPMS_SKIPPED_HANDSHAKE;
 
 	if (stream->sink) {
 		if (stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
@@ -2516,13 +2531,12 @@ void link_set_dpms_on(
 	}
 
 	link_wait_for_unlocked(link);
-	if (!dc->config.unify_link_enc_assignment)
-		link_enc = link_enc_cfg_get_link_enc(link);
-	ASSERT(link_enc);
 
 	if (!dc_is_virtual_signal(stream->signal)
 			&& !dc_is_hdmi_frl_signal(stream->signal)
 			&& !dp_is_128b_132b_signal(pipe_ctx)) {
+		struct link_encoder *link_enc = get_link_encoder(pipe_ctx);
+
 		if (link_enc)
 			link_enc->funcs->setup(
 				link_enc,
@@ -2569,7 +2583,9 @@ void link_set_dpms_on(
 		}
 
 		update_psp_stream_config(pipe_ctx, false);
-		return;
+
+		/* Seamless boot: hardware already enabled by BIOS; skip link training. */
+		return DC_DPMS_SKIPPED_HANDSHAKE;
 	}
 
 	/* eDP lit up by bios already, no need to enable again. */
@@ -2587,11 +2603,16 @@ void link_set_dpms_on(
 			msleep(post_oui_delay);
 		}
 
-		return;
+		/* eDP already lit by BIOS; skip standard enable steps. */
+		return DC_DPMS_SKIPPED_HANDSHAKE;
 	}
 
 	if (stream->dpms_off)
-		return;
+		/*
+		 * Stream is configured as DPMS-off; skip link enable.
+		 * Hardware will NOT be in a fully enabled state after this early exit.
+		 */
+		return DC_DPMS_FAILED_INCOMPLETE;
 
 	/* For Dp tunneling link, a pending HPD means that we have a race condition between processing
 	 * current link and processing the pending HPD. If we enable the link now, we may end up with a
@@ -2599,7 +2620,11 @@ void link_set_dpms_on(
 	 */
 	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && link->is_hpd_pending) {
 		DC_LOG_DEBUG("%s, Link%d HPD is pending, not enable it.\n", __func__, link->link_index);
-		return;
+		/*
+		 * Pending HPD on USB4 DPIA link: skip enable to avoid race condition.
+		 * Hardware will NOT be in a fully enabled state after this early exit.
+		 */
+		return DC_DPMS_FAILED_INCOMPLETE;
 	}
 
 	/* Have to setup DSC before DIG FE and BE are connected (which happens before the
@@ -2617,30 +2642,61 @@ void link_set_dpms_on(
 	if (link->replay_settings.config.replay_supported && !dc_is_embedded_signal(link->connector_signal))
 		dp_setup_replay(link, stream);
 
-	// TODO: Split DPMS-on into 3 functions at this point
-	status = enable_link(state, pipe_ctx);
+	return DC_DPMS_SUCCESS;
+}
+
+static enum dc_status link_set_dpms_on_enable_link(
+		struct dc_state *state,
+		struct pipe_ctx *pipe_ctx
+)
+{
+	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	const enum dc_status status = enable_link(state, pipe_ctx);
+
+	if (status == DC_OK)
+		return DC_DPMS_SUCCESS;
 
-	if (status != DC_OK) {
-		DC_LOG_WARNING("enabling link %u failed: %d\n",
-		link->link_index,
-		status);
+	DC_LOG_WARNING("enabling link %u failed: %d\n", link->link_index, status);
 
-		/* Abort stream enable *unless* the failure was due to
-		 * DP link training - some DP monitors will recover and
-		 * show the stream anyway. But MST displays can't proceed
-		 * without link training.
-		 */
-		if ((status != DC_FAIL_DP_LINK_TRAINING &&
-				status != DC_FAIL_HDMI_FRL_LINK_TRAINING) ||
-				stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-			if (false == link->link_status.link_active)
-				disable_link(link, &pipe_ctx->link_res,
-						stream->signal);
-			BREAK_TO_DEBUGGER();
-			return;
-		}
+	/* Abort stream enable *unless* the failure was due to
+	 * DP link training - some DP monitors will recover and
+	 * show the stream anyway. But MST displays can't proceed
+	 * without link training.
+	 */
+	switch (status) {
+	case DC_FAIL_DP_LINK_TRAINING:
+	case DC_FAIL_HDMI_FRL_LINK_TRAINING:
+		if (stream->signal != SIGNAL_TYPE_DISPLAY_PORT_MST)
+			return DC_DPMS_SUCCESS;
+		break;
+
+	default:
+		break;
 	}
-	// TODO: Split DPMS-on into 3 functions at this point
+
+	if (!link->link_status.link_active)
+		disable_link(link, &pipe_ctx->link_res, stream->signal);
+
+	/*
+	 * Link enable failed; do NOT set skip_remaining so that post_enable_link
+	 * still runs and leaves hardware in a consistent state.
+	 */
+	return DC_DPMS_FAILED_HANDSHAKE;
+}
+
+static enum dc_status link_set_dpms_on_post_enable_link(
+		struct dc_state *state,
+		struct pipe_ctx *pipe_ctx
+)
+{
+	// Used conditionally in ifdef'ed diagnostic builds
+	(void) state;
+
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	struct hw_sequencer_funcs *hwss = &stream->ctx->dc->hwss;
 
 	if (stream->timing.flags.DSC && dc_is_hdmi_frl_signal(stream->signal))
 		//TODO: bring HDMI FRL in line with DP
@@ -2659,13 +2715,15 @@ void link_set_dpms_on(
 	if (!(dc_is_virtual_signal(stream->signal) ||
 			dc_is_hdmi_frl_signal(stream->signal) ||
 			dp_is_128b_132b_signal(pipe_ctx))) {
+		struct link_encoder *link_enc = get_link_encoder(pipe_ctx);
+
 		if (link_enc)
 			link_enc->funcs->setup(
 					link_enc,
 					stream->signal);
 	}
 
-	dc->hwss.enable_stream(pipe_ctx);
+	hwss->enable_stream(pipe_ctx);
 
 	/* Set DPS PPS SDP (AKA "info frames") */
 	if (stream->timing.flags.DSC) {
@@ -2697,7 +2755,7 @@ void link_set_dpms_on(
 			link->is_display_mux_present)
 		msleep(20);
 
-	dc->hwss.unblank_stream(pipe_ctx,
+	hwss->unblank_stream(pipe_ctx,
 		&link->cur_link_settings);
 
 	if (stream->sink_patches.delay_ignore_msa > 0)
@@ -2707,8 +2765,50 @@ void link_set_dpms_on(
 		enable_stream_features(pipe_ctx);
 	update_psp_stream_config(pipe_ctx, false);
 
-	dc->hwss.enable_audio_stream(pipe_ctx);
+	hwss->enable_audio_stream(pipe_ctx);
 
 	if (dc_is_hdmi_signal(stream->signal))
 		set_avmute(pipe_ctx, false);
+
+	return DC_DPMS_SUCCESS;
+}
+
+enum dc_status link_set_dpms_on(
+		struct dc_state *state,
+		struct pipe_ctx *pipe_ctx
+)
+{
+	enum dc_status result = DC_DPMS_SUCCESS;
+
+	typedef enum dc_status (*step)(struct dc_state *, struct pipe_ctx *);
+	const step steps[] = {
+		link_set_dpms_on_pre_enable_link,
+		link_set_dpms_on_enable_link,
+		link_set_dpms_on_post_enable_link,
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(steps); i++) {
+		const enum dc_status step_result = steps[i](state, pipe_ctx);
+
+		switch (step_result) {
+		case DC_DPMS_SUCCESS:
+		case DC_DPMS_FAILED_HANDSHAKE:
+			// Enum is ordered from "best" to "worst" results
+			result = max(result, step_result);
+			break;
+
+		case DC_DPMS_SKIPPED_HANDSHAKE:
+			return step_result;
+
+		case DC_DPMS_FAILED_INCOMPLETE:
+			ASSERT(false);
+			return step_result;
+
+		default:
+			ASSERT(false);
+			return step_result;
+		}
+	}
+
+	return result;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.h b/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
index e8662147dd8e..6559bc04d90e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
@@ -27,10 +27,10 @@
 #define __DC_LINK_DPMS_H__
 
 #include "link_service.h"
-void link_set_dpms_on(
+enum dc_status link_set_dpms_on(
 		struct dc_state *state,
 		struct pipe_ctx *pipe_ctx);
-void link_set_dpms_off(struct pipe_ctx *pipe_ctx);
+enum dc_status link_set_dpms_off(struct pipe_ctx *pipe_ctx);
 void link_resume(struct dc_link *link);
 void link_blank_all_dp_displays(struct dc *dc);
 void link_blank_all_edp_displays(struct dc *dc);
-- 
2.43.0

