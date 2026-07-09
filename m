Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1181C44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CED410F6B7;
	Thu,  9 Jul 2026 21:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NX66t15x";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 483F010F6B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdNXC0ySkWpwd6OucQzUodEt44nI3eikf9xzC8D6EHrBlP1jkWZKZhyjF2Bjn4MQs354S9/LaZ4BFUgSfYnb5Yqm5T8RL+NM67SoWczDMNJdAmOCjpDkh01xMWXIj4CakJEV7WDsZ53tIfbWWu3bV03Ww+dTLHmK8wC4+yqUoPP1qny0c0fopjj8Cj/it0eCX403NNII+xPk++FGA+EjPXVH9ZkXM+WWpLvPOg5eY0GOgKcWgryoOiy8kF1A0WefroGuUX6hgK1OFOHASuqa3CHlMVOYZHM7taIKYCNFe5XVzD8DrO8uIPJS+e/SRTOWeGDSPxOb3QOTxfLGUzallA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlZUE8EyxjoLag6RpuJ6gUjYjfQFr7fUCs+eTWRdVm4=;
 b=AqRgHEPAIGaxqDx2y50KYGTgQEpoZTEL9D5jy94HWq2zJeimkC11qjsbHHQky/CIFbwQDV7rqCv5Oivq61UX6li4dJUqPAZTRTIXs1IzBz5+phs/0r7UEqULCSgggeCfEfJOxnktFjY9/oKKt20i3fgvRHoUjExh6zKuyqTQAFlqS+eV9VjOpiqSnB3KZx3kNu2Oo//kGN2zVC66i9QDjOoJqYCDetqjW3W2uF0jutrwZhy9Tuk02xt7RsTu0sN5g20vnwd6PGS8LDStHXWCV7z0byx+9X59DOQvTKfjp4oN2BsmvinTlyP5iN2tgCpEIcahyfkh+ooqwif5Qlq9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlZUE8EyxjoLag6RpuJ6gUjYjfQFr7fUCs+eTWRdVm4=;
 b=NX66t15xZAjMiB5u9AAYIvnlIuMl988UyBeJKYH8dF7bFVwviZUEhppsuMtXks3FQ2DCv/y5kgXHpT3qoVeL8QXSnpvE7UrN/u2du3pXRbjj8sz5ZQbd7hs5sr/hzGNJT85kWo+d9j2qvFk3It4yZ8P/JYJlIOYuwOJwpzBJ6Qc=
Received: from PH7PR10CA0002.namprd10.prod.outlook.com (2603:10b6:510:23d::28)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:01:48 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:510:23d:cafe::26) by PH7PR10CA0002.outlook.office365.com
 (2603:10b6:510:23d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:48 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:42 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 11/80] drm/amd/display: Remove sink usage from DPMS
Date: Thu, 9 Jul 2026 16:47:39 -0400
Message-ID: <20260709205936.5719-12-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: a08833f7-e1d1-41ef-6e05-08deddfd4aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: WUzEDJue5yEvVsXhmVj08ytJsUQ/oyOj+lNNgXCbl7p/QBAcYv8jJIjZioILq43nvUYzCoQyClRK9GWVc2Q6woqmvlc9hJdsc5wp04mMyaJCXHGab3GIlrFecqxTH0rNepMBfWgrtjFV6QeKInAc6py0ODVnsAYws0MK58NcfX1PgdLrijNtZOSVSFk4Emk90Udm6ZE6KkYayziAXOeDAY8zKc0fwvme68U9WwJz7dhpTpEmT9Egh/Jjq5pC9qF9RU5iOBz6vA4umJJp/tmjMzn62/ZDVCE8sjIsFwsAKTu032uvMBxyDcIqQN7HftjbgB7i+xGdBG9qL5UytYlIlnbR8JyKJ6bipLMEByb+/GRUTcaluwPnB9QjqTV9TkpMpeFwIIzZu0lj8ln+NmE2QAnFAgjllC8I57eDaQp3aZaE/DaLysE6cikwEt3FO+qLZKLAa+NNhCPxsXcAWe/FRoXj0KMQcaxZOnT9NgWncLZAD4PHeIp7LJydt8OgISGVty9rt7cAH6bTkQB4iHs/1ZxgERWedUYrWvL2cNbiUF7EmLZACoD71S5rEGZv70lwcKaUhD6+DPBObVXVSnDtHr5hNXx7SOjH5qrhAzOouapZblLI8EAvvSH82v/DM25G/kHpdMZLk+KUzScs7w5GCYCJmxZ9C+qlESOMITvHEoX3nWIy5wofes3jXorfkW6gRDHADXBsri+QqxiPjomYpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8zIyJka4+sLSe/jCvSxXc5JU599tS3CcZYsEeP0vMy5mPf02u5qp3Y7uW99np47KJ3QLH/ipi0cwNljoSgY15CK0s5yJysOBPsXOPfQ7EnJDP9f2qwkQHnqHI7YBoPb3U5Dfku2cHO9GKPiFW3BlMppIUwLWhXMXE96QVwopzx22og6FXx/1nBaONZFqxknHoPfhZVpbGtub7R73Jwr/61zyb/XGgbUmWuLhFuorfPC8ERp4v2zdZID9Qp4+5G55jYDQJjTaabd5lBRyo+iOx2DA6Bl4QEi4+JXTqMMat10I7pWY2xWIiqNuIiMvvv/zIB6XtwQSAFY/t7g37CylXDIFs9GjhDOnb5LDCX5jyUAfPHzr/kxg7LdbWsjkq4UmEB3B4iXZpOG4buRr7AQmu5RltpppIwpXiVPBKjwSR4RO3rIHgz0HbinBEU/HktI7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:48.1455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a08833f7-e1d1-41ef-6e05-08deddfd4aa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
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
stream->sink is optional and can be null, so should always be checked
before dereference. Additionally, most of its usage in DPMS sequences
is for stream->sink->link, which can be replaced with stream->link,
as the two should always be the same.

[How]
* Replace stream->sink->link in DPMS on/off
* Add assert to USB4 BW allocation where sink is required
* Avoid inconsistencies in resource access, e.g. don't repeat
stream->link after it was already saved to a local variable
* Pull out effective VPG calculation to helper getter
* Formatting fixes

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 178 +++++++++---------
 1 file changed, 90 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 42e7f0e9b3ce..479a8fbfdc5d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2296,6 +2296,8 @@ static enum dc_status enable_link(

 static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, int stream_bw)
 {
+	ASSERT(stream->sink);
+
 	struct dc_link *link = stream->sink->link;
 	int req_bw = stream_bw;

@@ -2342,6 +2344,8 @@ static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, i

 static bool allocate_usb4_bandwidth(struct dc_stream_state *stream)
 {
+	ASSERT(stream->sink);
+
 	bool ret;

 	int bw = dc_bandwidth_in_kbps_from_timing(&stream->timing,
@@ -2361,38 +2365,43 @@ static bool deallocate_usb4_bandwidth(struct dc_stream_state *stream)
 	return ret;
 }

+static struct vpg *get_vpg(struct pipe_ctx *pipe_ctx)
+{
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		return pipe_ctx->stream_res.hpo_frl_stream_enc->vpg;
+	else if (dp_is_128b_132b_signal(pipe_ctx))
+		return pipe_ctx->stream_res.hpo_dp_stream_enc->vpg;
+	else
+		return pipe_ctx->stream_res.stream_enc->vpg;
+}
+
 void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 {
-	struct dc  *dc = pipe_ctx->stream->ctx->dc;
+	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	struct dc_link *link = stream->sink->link;
-	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
+	struct dc *dc = stream->ctx->dc;
+	struct dc_link *link = stream->link;
+	struct vpg *vpg = get_vpg(pipe_ctx);
 	enum dp_panel_mode panel_mode_dp = dp_get_panel_mode(link);

-	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
-
 	ASSERT(is_master_pipe_for_link(link, pipe_ctx));

-	if (dp_is_128b_132b_signal(pipe_ctx))
-		vpg = pipe_ctx->stream_res.hpo_dp_stream_enc->vpg;
-	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
-		vpg = pipe_ctx->stream_res.hpo_frl_stream_enc->vpg;
-	if (dc_is_virtual_signal(pipe_ctx->stream->signal))
+	if (dc_is_virtual_signal(stream->signal))
 		return;

-	if (pipe_ctx->stream->sink) {
-		if (pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
-			pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
+	if (stream->sink) {
+		if (stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
+			stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
 			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d sink_count=%d\n", __func__,
-			pipe_ctx->stream->sink->edid_caps.display_name,
-			pipe_ctx->stream->signal, link->link_index, link->sink_count);
+			stream->sink->edid_caps.display_name,
+			stream->signal, link->link_index, link->sink_count);
 		}
 	}

 	link_wait_for_unlocked(link);

-	if (!pipe_ctx->stream->sink->edid_caps.panel_patch.skip_avmute) {
-		if (dc_is_hdmi_signal(pipe_ctx->stream->signal))
+	if (stream->sink && !stream->sink->edid_caps.panel_patch.skip_avmute) {
+		if (dc_is_hdmi_signal(stream->signal))
 			set_avmute(pipe_ctx, true);
 	}

@@ -2402,15 +2411,15 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	dc->hwss.blank_stream(pipe_ctx);

 	if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_allocation)
-		deallocate_usb4_bandwidth(pipe_ctx->stream);
+		deallocate_usb4_bandwidth(stream);

-	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		deallocate_mst_payload(pipe_ctx);
-	else if (dc_is_dp_sst_signal(pipe_ctx->stream->signal) &&
+	else if (dc_is_dp_sst_signal(stream->signal) &&
 			dp_is_128b_132b_signal(pipe_ctx))
 		update_sst_payload(pipe_ctx, false);

-	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
+	if (dc_is_hdmi_signal(stream->signal)) {
 		struct ext_hdmi_settings settings = {0};
 		enum engine_id eng_id = pipe_ctx->stream_res.stream_enc->id;

@@ -2433,7 +2442,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		}
 	}

-	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
 			!dp_is_128b_132b_signal(pipe_ctx)) {

 		/* In DP1.x SST mode, our encoder will go to TPS1
@@ -2443,18 +2452,18 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		 * state machine.
 		 * In DP2 or MST mode, our encoder will stay video active
 		 */
-		disable_link(pipe_ctx->stream->link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
+		disable_link(link, &pipe_ctx->link_res, stream->signal);
 		dc->hwss.disable_stream(pipe_ctx);
 	} else {
 		dc->hwss.disable_stream(pipe_ctx);
-		disable_link(pipe_ctx->stream->link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
+		disable_link(link, &pipe_ctx->link_res, stream->signal);
 	}
 	edp_set_panel_assr(link, pipe_ctx, &panel_mode_dp, false);

-	if (pipe_ctx->stream->timing.flags.DSC) {
-		if (dc_is_dp_signal(pipe_ctx->stream->signal))
+	if (stream->timing.flags.DSC) {
+		if (dc_is_dp_signal(stream->signal))
 			link_set_dsc_enable(pipe_ctx, false);
-		else if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		else if (dc_is_hdmi_frl_signal(stream->signal))
 			link_set_dsc_on_stream(pipe_ctx, false);
 	}
 	if (dp_is_128b_132b_signal(pipe_ctx)) {
@@ -2468,7 +2477,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	/* for psp not exist case */
 	if (link->connector_signal == SIGNAL_TYPE_EDP && dc->debug.psp_disabled_wa) {
 		/* reset internal save state to default since eDP is  off */
-		enum dp_panel_mode panel_mode = dp_get_panel_mode(pipe_ctx->stream->link);
+		enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
 		/* since current psp not loaded, we need to reset it to default */
 		link->panel_mode = panel_mode;
 	}
@@ -2478,62 +2487,57 @@ void link_set_dpms_on(
 		struct dc_state *state,
 		struct pipe_ctx *pipe_ctx)
 {
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	struct dc_link *link = stream->sink->link;
+	struct dc *dc = stream->ctx->dc;
+	struct dc_link *link = stream->link;
 	enum dc_status status;
 	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
-	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
+	struct vpg *vpg = get_vpg(pipe_ctx);
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	bool apply_edp_fast_boot_optimization =
-		pipe_ctx->stream->apply_edp_fast_boot_optimization;
-
-	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
+		stream->apply_edp_fast_boot_optimization;

 	ASSERT(is_master_pipe_for_link(link, pipe_ctx));

-	if (dp_is_128b_132b_signal(pipe_ctx))
-		vpg = pipe_ctx->stream_res.hpo_dp_stream_enc->vpg;
-	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
-		vpg = pipe_ctx->stream_res.hpo_frl_stream_enc->vpg;
-	if (dc_is_virtual_signal(pipe_ctx->stream->signal))
+	if (dc_is_virtual_signal(stream->signal))
 		return;

-	if (pipe_ctx->stream->sink) {
-		if (pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
-			pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
+	if (stream->sink) {
+		if (stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
+			stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
 			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d sink_count=%d\n", __func__,
-			pipe_ctx->stream->sink->edid_caps.display_name,
-			pipe_ctx->stream->signal,
+			stream->sink->edid_caps.display_name,
+			stream->signal,
 			link->link_index,
 			link->sink_count);
 		}
 	}

-	link_wait_for_unlocked(stream->link);
+	link_wait_for_unlocked(link);
 	if (!dc->config.unify_link_enc_assignment)
 		link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);

-	if (!dc_is_virtual_signal(pipe_ctx->stream->signal)
-			&& !dc_is_hdmi_frl_signal(pipe_ctx->stream->signal)
+	if (!dc_is_virtual_signal(stream->signal)
+			&& !dc_is_hdmi_frl_signal(stream->signal)
 			&& !dp_is_128b_132b_signal(pipe_ctx)) {
 		if (link_enc)
 			link_enc->funcs->setup(
 				link_enc,
-				pipe_ctx->stream->signal);
+				stream->signal);
 	}

-	pipe_ctx->stream->link->link_state_valid = true;
+	link->link_state_valid = true;

-	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
-		hdmi_frl_decide_link_settings(stream, &stream->link->frl_link_settings, &pipe_ctx->dsc_padding_params);
+	if (dc_is_hdmi_frl_signal(stream->signal))
+		hdmi_frl_decide_link_settings(stream, &link->frl_link_settings, &pipe_ctx->dsc_padding_params);

 	if (pipe_ctx->stream_res.tg->funcs->set_out_mux) {
 		if (dp_is_128b_132b_signal(pipe_ctx))
 			otg_out_dest = OUT_MUX_HPO_DP;
-		else if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		else if (dc_is_hdmi_frl_signal(stream->signal))
 			otg_out_dest = OUT_MUX_HPO_FRL;
 		else
 			otg_out_dest = OUT_MUX_DIO;
@@ -2542,7 +2546,7 @@ void link_set_dpms_on(

 	link_hwss->setup_stream_attribute(pipe_ctx);

-	pipe_ctx->stream->apply_edp_fast_boot_optimization = false;
+	stream->apply_edp_fast_boot_optimization = false;

 	// Enable VPG before building infoframe
 	if (vpg && vpg->funcs->vpg_poweron)
@@ -2551,15 +2555,15 @@ void link_set_dpms_on(
 	resource_build_info_frame(pipe_ctx);
 	dc->hwss.update_info_frame(pipe_ctx);

-	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+	if (dc_is_dp_signal(stream->signal))
 		dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME);

 	/* Do not touch link on seamless boot optimization. */
-	if (pipe_ctx->stream->apply_seamless_boot_optimization) {
-		pipe_ctx->stream->dpms_off = false;
+	if (stream->apply_seamless_boot_optimization) {
+		stream->dpms_off = false;

 		/* Still enable stream features & audio on seamless boot for DP external displays */
-		if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
+		if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
 			enable_stream_features(pipe_ctx);
 			dc->hwss.enable_audio_stream(pipe_ctx);
 		}
@@ -2569,11 +2573,11 @@ void link_set_dpms_on(
 	}

 	/* eDP lit up by bios already, no need to enable again. */
-	if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP &&
+	if (stream->signal == SIGNAL_TYPE_EDP &&
 				apply_edp_fast_boot_optimization &&
-				!pipe_ctx->stream->timing.flags.DSC &&
+				!stream->timing.flags.DSC &&
 				!pipe_ctx->next_odm_pipe) {
-		pipe_ctx->stream->dpms_off = false;
+		stream->dpms_off = false;
 		update_psp_stream_config(pipe_ctx, false);

 		if (link->is_dds) {
@@ -2586,7 +2590,7 @@ void link_set_dpms_on(
 		return;
 	}

-	if (pipe_ctx->stream->dpms_off)
+	if (stream->dpms_off)
 		return;

 	/* For Dp tunneling link, a pending HPD means that we have a race condition between processing
@@ -2604,9 +2608,9 @@ void link_set_dpms_on(
 	 * will be automatically set at a later time when the video is enabled
 	 * (DP_VID_STREAM_EN = 1).
 	 */
-	if (pipe_ctx->stream->timing.flags.DSC) {
-		if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
-		    dc_is_virtual_signal(pipe_ctx->stream->signal))
+	if (stream->timing.flags.DSC) {
+		if (dc_is_dp_signal(stream->signal) ||
+		    dc_is_virtual_signal(stream->signal))
 			link_set_dsc_enable(pipe_ctx, true);
 	}

@@ -2617,7 +2621,7 @@ void link_set_dpms_on(

 	if (status != DC_OK) {
 		DC_LOG_WARNING("enabling link %u failed: %d\n",
-		pipe_ctx->stream->link->link_index,
+		link->link_index,
 		status);

 		/* Abort stream enable *unless* the failure was due to
@@ -2627,19 +2631,18 @@ void link_set_dpms_on(
 		 */
 			if ((status != DC_FAIL_DP_LINK_TRAINING &&
 					status != DC_FAIL_HDMI_FRL_LINK_TRAINING) ||
-					pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-			if (false == stream->link->link_status.link_active)
-				disable_link(stream->link, &pipe_ctx->link_res,
-						pipe_ctx->stream->signal);
+					stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+			if (false == link->link_status.link_active)
+				disable_link(link, &pipe_ctx->link_res,
+						stream->signal);
 			BREAK_TO_DEBUGGER();
 			return;
 		}
 	}

-	if (pipe_ctx->stream->timing.flags.DSC &&
-			dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
-			//TODO: bring HDMI FRL in line with DP
-			link_set_dsc_on_stream(pipe_ctx, true);
+	if (stream->timing.flags.DSC && dc_is_hdmi_frl_signal(stream->signal))
+		//TODO: bring HDMI FRL in line with DP
+		link_set_dsc_on_stream(pipe_ctx, true);

 	/* turn off otg test pattern if enable */
 	if (pipe_ctx->stream_res.tg->funcs->set_test_pattern)
@@ -2651,37 +2654,37 @@ void link_set_dpms_on(
 	 * as a workaround for the incorrect value being applied
 	 * from transmitter control.
 	 */
-	if (!(dc_is_virtual_signal(pipe_ctx->stream->signal) ||
-			dc_is_hdmi_frl_signal(pipe_ctx->stream->signal) ||
+	if (!(dc_is_virtual_signal(stream->signal) ||
+			dc_is_hdmi_frl_signal(stream->signal) ||
 			dp_is_128b_132b_signal(pipe_ctx))) {

 			if (link_enc)
 				link_enc->funcs->setup(
 					link_enc,
-					pipe_ctx->stream->signal);
+					stream->signal);

 		}

 	dc->hwss.enable_stream(pipe_ctx);

 	/* Set DPS PPS SDP (AKA "info frames") */
-	if (pipe_ctx->stream->timing.flags.DSC) {
-		if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
-				dc_is_virtual_signal(pipe_ctx->stream->signal)) {
+	if (stream->timing.flags.DSC) {
+		if (dc_is_dp_signal(stream->signal) ||
+				dc_is_virtual_signal(stream->signal)) {
 			dp_set_dsc_on_rx(pipe_ctx, true);
 			link_set_dsc_pps_packet(pipe_ctx, true, true);
 		}
 	}

-	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+	if (dc_is_dp_signal(stream->signal))
 		dp_set_hblank_reduction_on_rx(pipe_ctx);

 	if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_allocation)
-		allocate_usb4_bandwidth(pipe_ctx->stream);
+		allocate_usb4_bandwidth(stream);

-	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		allocate_mst_payload(pipe_ctx);
-	else if (dc_is_dp_sst_signal(pipe_ctx->stream->signal) &&
+	else if (dc_is_dp_sst_signal(stream->signal) &&
 			dp_is_128b_132b_signal(pipe_ctx))
 		update_sst_payload(pipe_ctx, true);

@@ -2690,23 +2693,22 @@ void link_set_dpms_on(
 	 * training and stream unblank resolves the corruption issue.
 	 * This is workaround.
 	 */
-	if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP &&
+	if (stream->signal == SIGNAL_TYPE_EDP &&
 			link->is_display_mux_present)
 		msleep(20);

 	dc->hwss.unblank_stream(pipe_ctx,
-		&pipe_ctx->stream->link->cur_link_settings);
+		&link->cur_link_settings);

 	if (stream->sink_patches.delay_ignore_msa > 0)
 		msleep(stream->sink_patches.delay_ignore_msa);

-	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+	if (dc_is_dp_signal(stream->signal))
 		enable_stream_features(pipe_ctx);
 	update_psp_stream_config(pipe_ctx, false);

 	dc->hwss.enable_audio_stream(pipe_ctx);

-	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
+	if (dc_is_hdmi_signal(stream->signal))
 		set_avmute(pipe_ctx, false);
-	}
 }
--
2.55.0

