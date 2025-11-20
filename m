Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E8CCF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F400510E7AC;
	Thu, 20 Nov 2025 18:17:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4gMKjBFE";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013049.outbound.protection.outlook.com
 [40.107.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EEE10E7AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vs/aJTupS/XzE5w0QQimSAr6VOxnAYC6SjyNd/qsn1uJQtDcfNT/W4NLZzc63ISynAgGgYQXzEFXJ4Z3JJFLmp8wm84cXp04cOv92SHq+dH/O+IsURE725nUhpH3MNU033juK2e184K7sMcMipvBPhCT2B+WXsnoWvbwrHT/t5y/Cl6vebp1Uxalx3fbUPW2Ky2n0p/fcTNNPq7waX/tfCumIFnAX7Of4VpJlq0uBiWyT36YLU6gZN/VARxpM1QIzMgFNZNkjXKqGPRJ38dH2JE5CYBXUjsuZWUX80rbPuMdhsYKyu4zR10R7xQfkTWS3h/rVkqaUCoTLAZUasLM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8H9KXFpMTeJBN2VKB4MExJ6Eg/vC5DLVQQ9xm8NH3A=;
 b=re1zR3qLIqmIWDJEuzKMWVobWIF8RbdOyo16n35WI71lye4qsRy8twbh6zhiUgAXkgQ8I2r0m+7amsY/VbHSGneBcLJJxXB9zvyWQUHZJfaAB6sGV0nL+ES34a3Jv4qcOuzYkEpV08pfp8E91Jpus8Kkpk5SZgHSDilpo/37HKnxmpzhZ+HYt4USk7RUJyobOboN6gDMD7Djbt+4e5AGQ55xBP8iPAH/41sLPRp9VZBMkOJJ5NEWBNy2G3EKlpMtTpRkXGlRSy0M1/FjFuhdfGROzvCe7ViTZusmRu3nQiqUXZzg8Vzf6Z/soR/LOZRTDskGNp4Hmrw4IZqMV5k12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8H9KXFpMTeJBN2VKB4MExJ6Eg/vC5DLVQQ9xm8NH3A=;
 b=4gMKjBFELyaJDKzWE/gazC6i3uK3MKfRSU1rs8NxFX8/cNde0tek7X8zCstNyaXty8YO0AIV4H2qCxkR7uYj4EiNN6IJSwvbYzWz7dWnnCjYuSjAO9HffVvEqk/9dhgGX6PlOsAmL0ga3SqkVlZ5A+h1eaXqibUO7rWoKZPYIbE=
Received: from DM6PR02CA0100.namprd02.prod.outlook.com (2603:10b6:5:1f4::41)
 by IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 20 Nov
 2025 18:17:36 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::ea) by DM6PR02CA0100.outlook.office365.com
 (2603:10b6:5:1f4::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 18:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:17:36 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:17:34 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Leon Huang <Leon.Huang1@amd.com>
Subject: [PATCH 03/26] drm/amd/display: Refactor panel replay set dmub cmd flow
Date: Thu, 20 Nov 2025 11:02:59 -0700
Message-ID: <20251120181527.317107-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 9790a17c-a276-4696-104c-08de2861151b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VUWoL9fYy6RE6AmgEz4WeQbL/6MI8nzMjzthlS1ohbmIQeaF0w85iqqkMHTw?=
 =?us-ascii?Q?yKtaDnM9rrdPrup6QQotoj862BCyUS71fR1nosYWscwCW9bjBCgAGu3XKl14?=
 =?us-ascii?Q?dPoV9yDabkhJT4cUaRj56K1hA3QmiNaMqmSiwXIYJsb9BmZ6hNsMeXX4yHp2?=
 =?us-ascii?Q?VAQHTlEz8c3GQfZmZZJJ++SASur2pjftgJtzhXjcEAJYnsn54bWrerw8Ljqa?=
 =?us-ascii?Q?VwowKjrGIJDS0fkSuumGMmkDNnqH07Eki3A9HnBqe8f2ovZChWfCKvansR/g?=
 =?us-ascii?Q?5pr0qo2XXIhAyRcEXnJEckyK+kiinqNwAtQgYaZPGjo9NbwYpkro4WidPzgx?=
 =?us-ascii?Q?6JCSlefNpIzuOSmhCYMlEryK1H64kfQVv9xCRH8DUUxbctoO9FYuaNEVIrAU?=
 =?us-ascii?Q?R596BHTamVPmNoQPjm2FyGGd41ER1XWSImbqxZhnbRDG3R4rZCQ8vjarnaUW?=
 =?us-ascii?Q?ODtOlP0ZVzNkivoe1VjI30roFhvgvS5xSuLEdlagiLMzd4mpT9Eo+ze9Ygc2?=
 =?us-ascii?Q?1ZPxqExtWDFlEHWFMYGmVwqmya7x3WaYMVzJj542QYc6+F2x3MbvF0+t2cSa?=
 =?us-ascii?Q?ZIaFTt7gn70D3kMEZxsCmlD6Dbs12xpMnaGHeF1fQuJDOpKF5yAjltRikZf/?=
 =?us-ascii?Q?E3K/MWaupYWaigERlbGplsUbHVkAZ2lVT2u0VVjSJOBVLlolBlEB/erP7vMc?=
 =?us-ascii?Q?K0wVCDUPyhw+Ey5p9ymtnVKOrw0RXjrN/CFv9BTAp5O9/nCRRPjSmFZ+i5Ka?=
 =?us-ascii?Q?zwKFzS0RDBa1nsoSygk3AKv6Y7fh8WgpXlPoGVmoRbzYO6poXZVW5SyR3S6v?=
 =?us-ascii?Q?rU3/WoQd0hPsjOIxNOuwvNBK5kkFCyebsw8mA28Mp9qJ22eI0FqkSz4VsVel?=
 =?us-ascii?Q?qJYVj3iGKUdh0sj5Qu7ZQOSfBGgg6m4FhnTtDHJkTalpHbcbwIdtLJ2R2qhL?=
 =?us-ascii?Q?Wm8ylsNSqjWXObgSB0jG9aiDqj1FAmLmVOqM/7rhlFvdLmXxlp6tnLsc4ND8?=
 =?us-ascii?Q?52Wl6KnoOUM1kJ3Qip9HzzyGe2J8GXCTqjs2+6Lqv9jGmqCFlVYV9rbKlWIV?=
 =?us-ascii?Q?l8becJdBqYHQyfMS46wRDNE46UBWEOQzbg0yceMkqlDI13vtYL6O8GThxmaW?=
 =?us-ascii?Q?hT+UaRebDYEYfrQL72D7BSl243I3Kkb0LpySglSkTypldy93W84wSNVGA0F2?=
 =?us-ascii?Q?9NSelruDwCTL8+6Ht0C6iVORPE1Zm+U+MKTiFcf/eTIaR8gbrwn4AUt2dw5u?=
 =?us-ascii?Q?WMlU8zZpjLeV1KaHb/1kLGcKPQ+ZlmXEoAFl+1POxDKomaRJBdFQuDvleJoF?=
 =?us-ascii?Q?jjT8iAjoIuvPkFkKdlj5UWPBt//hZzmVA68Rmf8/7d5nuB92+IHWDvDxyuFo?=
 =?us-ascii?Q?3xvCp87jtOz7EWMyrBRsROvupb8lTDap3txXSdDnpHxLY/UvGBHtEqZL1E9f?=
 =?us-ascii?Q?k6jMTrABLNY8kmllI0oWUErB86bl+F7rFLcHA8EsoxlNPo9U9NogXqYv+q/1?=
 =?us-ascii?Q?Km9GkjEXHL5En8T0cb8qGX1qnp0mx+j6F4v0Eez69A+rAAH/ktuToIJI+i25?=
 =?us-ascii?Q?kynN+ZIbIzAfjnAOnv0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:17:36.3484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9790a17c-a276-4696-104c-08de2861151b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
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

From: Jack Chang <jack.chang@amd.com>

[WHY]
Add link service interface for setting PR dmub command

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/inc/link_service.h |   4 +
 .../drm/amd/display/dc/link/link_factory.c    |   4 +
 .../link/protocols/link_edp_panel_control.c   | 146 +++++++++++++++++-
 .../link/protocols/link_edp_panel_control.h   |   5 +
 4 files changed, 157 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index 6f94e48a24d1..2f805ba19a52 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -307,6 +307,10 @@ struct link_service {
 	bool (*edp_receiver_ready_T9)(struct dc_link *link);
 	bool (*edp_receiver_ready_T7)(struct dc_link *link);
 	bool (*edp_power_alpm_dpcd_enable)(struct dc_link *link, bool enable);
+	bool (*edp_pr_enable)(struct dc_link *link, bool enable);
+	bool (*edp_pr_update_state)(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data);
+	bool (*edp_pr_set_general_cmd)(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data);
+	bool (*edp_pr_get_state)(const struct dc_link *link, uint64_t *state);
 	void (*edp_set_panel_power)(struct dc_link *link, bool powerOn);
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index a6e2b0821969..e9af184dbe5d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -229,6 +229,10 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 	link_srv->edp_receiver_ready_T9 = edp_receiver_ready_T9;
 	link_srv->edp_receiver_ready_T7 = edp_receiver_ready_T7;
 	link_srv->edp_power_alpm_dpcd_enable = edp_power_alpm_dpcd_enable;
+	link_srv->edp_pr_enable = edp_pr_enable;
+	link_srv->edp_pr_update_state = edp_pr_update_state;
+	link_srv->edp_pr_set_general_cmd = edp_pr_set_general_cmd;
+	link_srv->edp_pr_get_state = edp_pr_get_state;
 	link_srv->edp_set_panel_power = edp_set_panel_power;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index c56e69eb27ef..80ee6efe91e2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1049,8 +1049,7 @@ static bool edp_setup_panel_replay(struct dc_link *link, const struct dc_stream_
 
 	replay_context.line_time_in_ns = lineTimeInNs;
 
-	link->replay_settings.replay_feature_enabled =
-			replay->funcs->replay_copy_settings(replay, link, &replay_context, panel_inst);
+	link->replay_settings.replay_feature_enabled = edp_pr_copy_settings(link, &replay_context);
 
 	if (link->replay_settings.replay_feature_enabled) {
 		pr_config_1.bits.PANEL_REPLAY_ENABLE = 1;
@@ -1305,6 +1304,149 @@ bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
 	return true;
 }
 
+bool edp_pr_enable(struct dc_link *link, bool enable)
+{
+	struct dc  *dc = link->ctx->dc;
+	unsigned int panel_inst = 0;
+	union dmub_rb_cmd cmd;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	//for sending PR enable commands to DMUB
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.pr_enable.header.type = DMUB_CMD__PR;
+	cmd.pr_enable.header.sub_type = DMUB_CMD__PR_ENABLE;
+	cmd.pr_enable.header.payload_bytes = sizeof(struct dmub_cmd_pr_enable_data);
+	cmd.pr_enable.data.panel_inst = panel_inst;
+	cmd.pr_enable.data.enable = enable ? 1 : 0;
+
+	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	return true;
+}
+
+bool edp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_context)
+{
+	struct dc  *dc = link->ctx->dc;
+	unsigned int panel_inst = 0;
+	union dmub_rb_cmd cmd;
+	struct pipe_ctx *pipe_ctx = NULL;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	for (unsigned int i = 0; i < MAX_PIPES; i++) {
+		if (dc->current_state->res_ctx.pipe_ctx[i].stream &&
+			dc->current_state->res_ctx.pipe_ctx[i].stream->link &&
+			dc->current_state->res_ctx.pipe_ctx[i].stream->link == link &&
+			dc->current_state->res_ctx.pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
+			pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+			//TODO: refactor for multi edp support
+			break;
+		}
+	}
+
+	if (!pipe_ctx)
+		return false;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.pr_copy_settings.header.type = DMUB_CMD__PR;
+	cmd.pr_copy_settings.header.sub_type = DMUB_CMD__PR_COPY_SETTINGS;
+	cmd.pr_copy_settings.header.payload_bytes = sizeof(struct dmub_cmd_pr_copy_settings_data);
+	cmd.pr_copy_settings.data.panel_inst = panel_inst;
+	// HW inst
+	cmd.pr_copy_settings.data.aux_inst = replay_context->aux_inst;
+	cmd.pr_copy_settings.data.digbe_inst = replay_context->digbe_inst;
+	cmd.pr_copy_settings.data.digfe_inst = replay_context->digfe_inst;
+	if (pipe_ctx->plane_res.dpp)
+		cmd.pr_copy_settings.data.dpp_inst = pipe_ctx->plane_res.dpp->inst;
+	else
+		cmd.pr_copy_settings.data.dpp_inst = 0;
+	if (pipe_ctx->stream_res.tg)
+		cmd.pr_copy_settings.data.otg_inst = pipe_ctx->stream_res.tg->inst;
+	else
+		cmd.pr_copy_settings.data.otg_inst = 0;
+
+	cmd.pr_copy_settings.data.dpphy_inst = link->link_enc->transmitter;
+
+	cmd.pr_copy_settings.data.line_time_in_ns = replay_context->line_time_in_ns;
+	cmd.pr_copy_settings.data.flags.bitfields.fec_enable_status = (link->fec_state == dc_link_fec_enabled);
+	cmd.pr_copy_settings.data.flags.bitfields.dsc_enable_status = (pipe_ctx->stream->timing.flags.DSC == 1);
+
+	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	return true;
+}
+
+bool edp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data)
+{
+	struct dc  *dc = link->ctx->dc;
+	unsigned int panel_inst = 0;
+	union dmub_rb_cmd cmd;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.pr_update_state.header.type = DMUB_CMD__PR;
+	cmd.pr_update_state.header.sub_type = DMUB_CMD__PR_UPDATE_STATE;
+	cmd.pr_update_state.header.payload_bytes = sizeof(struct dmub_cmd_pr_update_state_data);
+	cmd.pr_update_state.data.panel_inst = panel_inst;
+
+	memcpy(&cmd.pr_update_state.data, update_state_data, sizeof(struct dmub_cmd_pr_update_state_data));
+
+	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	return true;
+}
+
+bool edp_pr_set_general_cmd(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data)
+{
+	struct dc  *dc = link->ctx->dc;
+	unsigned int panel_inst = 0;
+	union dmub_rb_cmd cmd;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.pr_general_cmd.header.type = DMUB_CMD__PR;
+	cmd.pr_general_cmd.header.sub_type = DMUB_CMD__PR_GENERAL_CMD;
+	cmd.pr_general_cmd.header.payload_bytes = sizeof(struct dmub_cmd_pr_general_cmd_data);
+	cmd.pr_general_cmd.data.panel_inst = panel_inst;
+
+	memcpy(&cmd.pr_general_cmd.data, general_cmd_data, sizeof(struct dmub_cmd_pr_general_cmd_data));
+
+	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	return true;
+}
+
+bool edp_pr_get_state(const struct dc_link *link, uint64_t *state)
+{
+	const struct dc  *dc = link->ctx->dc;
+	unsigned int panel_inst = 0;
+	uint32_t retry_count = 0;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	do {
+		// Send gpint command and wait for ack
+		if (!dc_wake_and_execute_gpint(dc->ctx, DMUB_GPINT__GET_REPLAY_STATE, panel_inst,
+					       (uint32_t *)state, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
+			// Return invalid state when GPINT times out
+			*state = PR_STATE_INVALID;
+		}
+	} while (++retry_count <= 1000 && *state == PR_STATE_INVALID);
+
+	// Assert if max retry hit
+	if (retry_count >= 1000 && *state == PR_STATE_INVALID) {
+		ASSERT(0);
+		/* To-do: Add retry fail log */
+	}
+
+	return true;
+}
+
 static struct abm *get_abm_from_stream_res(const struct dc_link *link)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index dd79c7cd2828..360129732109 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -75,6 +75,11 @@ void edp_add_delay_for_T9(struct dc_link *link);
 bool edp_receiver_ready_T9(struct dc_link *link);
 bool edp_receiver_ready_T7(struct dc_link *link);
 bool edp_power_alpm_dpcd_enable(struct dc_link *link, bool enable);
+bool edp_pr_enable(struct dc_link *link, bool enable);
+bool edp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_context);
+bool edp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data);
+bool edp_pr_set_general_cmd(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data);
+bool edp_pr_get_state(const struct dc_link *link, uint64_t *state);
 void edp_set_panel_power(struct dc_link *link, bool powerOn);
 void edp_set_panel_assr(struct dc_link *link, struct pipe_ctx *pipe_ctx,
 		enum dp_panel_mode *panel_mode, bool enable);
-- 
2.43.0

