Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B1FCD3438
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4320110E79B;
	Wed, 12 Nov 2025 18:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o0OUCgMW";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA2110E79B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxUY020+qOKB9yXWX0dzOGvb79Dgg8lBawEc1AWJHIweiZNf0EE0x+W6c2oZQMzYsa1/m26yd66Uw4ImwNiPiZ09sN0DrS0MF1RSAaDGBKltUW0mslhirBAsinoq8kj2v7rsle+8QkH+jNujWggSC4ItgHCpH7ivnumUrE6pNIfRjzRPFCGLSnPovyM04B/QOeYKTUDwqTkvunBRDay4rj/an+y1kU9617HDsknVqoKF+PzkoaYlH/2TopVrsNrOfChihzU4It0RUtUWMtLDkTD1tZx35PLqcHAmokR6YNkUSaRSFwwWhamaUULJtnrFenzFOUmQdbQsZQQEaAGibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyRPJl9kokIOlejUd3r7yOO8/DawoBPbj6lty81Gs2Y=;
 b=J6W5pTIj5xEsEUHlQr6j0/DNXuRzvnUsDDykbv6yRQCdOm3EbXh5uoXhnJ3jy8xglv1eIVV/FhRf198/4bvyn5s2l7R89qwaXV4dr1L3PRXRasIlf0zFTGUHBtkF/6S7Wq/qb3WV50Bl9ld4BjLikpKK3ibF5HPcrGRnoOjBTYrqW8RgdrzLPxocqI3LnGNITZx3jM0nUyDAVphCGbQOt44c3cPCOgLwfkA9bkqT2n5FB5G5IjGA943O6KsmzjKIjwmEnqKz0qqdd7je5tXdC0EyoeZmvGHvdIanjOBwZOavuuWvG4wOlpfbEDZias5CZGWLmod4EkrA7OFWNk6OiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyRPJl9kokIOlejUd3r7yOO8/DawoBPbj6lty81Gs2Y=;
 b=o0OUCgMW5cSANF9elm3m1/TYdY3LGr3qG3pvCLKMkx/P+LXDItHsE9CWsVjEP5qd+Ny1ljqc5wNj17Gjbr8H4O60WUDH6FVzgjPQ5C2C7CR8exXJWaX+0iPveSlIvjY1a1U/dzbfhbHQvIEmyG+Dyxy7Al7yLzvXpTlFm+rcmTQ=
Received: from MW4PR04CA0206.namprd04.prod.outlook.com (2603:10b6:303:86::31)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:23:00 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::f0) by MW4PR04CA0206.outlook.office365.com
 (2603:10b6:303:86::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 18:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:22:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:33 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 12:22:33 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:32 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Leon Huang <Leon.Huang1@amd.com>
Subject: [PATCH 04/16] drm/amd/display: Add panel replay enablement option and
 logic
Date: Wed, 12 Nov 2025 13:20:22 -0500
Message-ID: <20251112182212.559007-5-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1fcd30-b4e9-4e72-ca0f-08de22188226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ivujGA9y1m5U2zsFoHHyMbhdA8A9ufjqeGNKGTuq3N6H6puitr92ixfX9jLR?=
 =?us-ascii?Q?6+55RDFRUJBYaJ5ccNTRxxn4GjkF6/xFcgZHeeyxJQ3GtiIF6vAawc+VhER5?=
 =?us-ascii?Q?Koiei88/n0vv+q+r992Sbs8PDE1Xm0vBpdBNa3mO/TjQcBtTJtwF9VCPH6yd?=
 =?us-ascii?Q?yW6NhQtVoY/pG4wJsrKWsfB26r13B+lFlpldriS0P5f96l2hOZ6+ogADnXK2?=
 =?us-ascii?Q?ygIoFSm7i9wnjWJIYfGzj6QWx63mwg7X0nfbYgntO1QGaxSJgTVdfMyc4b0Y?=
 =?us-ascii?Q?3RI5ptunC3RqBX293Ha8e5hGS7U2FaC5V2o9L14JXcL593/++0Tq5A8yRulP?=
 =?us-ascii?Q?YhcaZgiWHDGQtY6EZRZVs3Y7uZn+uw8U5fFYaCTatLp39lm7Gf+gm5qTzyCR?=
 =?us-ascii?Q?ML5vNJCD+s51IdSEQWoMj7LrPO8ubDAljvgAMS659dmdafr8Bcz7ibifx3hH?=
 =?us-ascii?Q?tTXgWsQiPlmV+kd3gYNebZuyl3VKBO1Dh18mVOmLXzb6ZJqU806ITuYdO63Q?=
 =?us-ascii?Q?Mi+Zn6wihvOrnOFSMIm7b0mmbk7FrPYFITYxEeli+fTSCHS9G77gn3d+Tdkl?=
 =?us-ascii?Q?g9HmidiozoUIMaGPObWvqJFGI/6i2inRb0g0NryDVTMxa3TpvjvMMLk6gVMJ?=
 =?us-ascii?Q?Rxps3pnwWlZvqM7W9OPz/pWE16jfCcuaqvIfE9N5SFY2LhifsetuHFL3C5CO?=
 =?us-ascii?Q?KUG3rfZ8reXq4fXa+IrbfkSHKGGCpnrSflEjtX6eBJLDVf/myIgV9skY9rBY?=
 =?us-ascii?Q?1z6pPyKsR12i7yG7O0wfE7Ce6LN8BQpznp1oGD4Czd9WhIPLEfQEq+VCh6go?=
 =?us-ascii?Q?Rm6QWLj7G7ughHIkDeDc062X+qcUxfTJQPKV/3vIRXHuH8QCsQaK6I4z0GwZ?=
 =?us-ascii?Q?xpkPSq6QVgapn6irxJtmwJ6tZg5RhfI7koKID5UcRoDms131ghrnV/f1Ba08?=
 =?us-ascii?Q?zPnI9q71MVFIWzxXcz/Anz+ZZ0q/KLLIMwTKQYDZEM+9+ZdTaebQexK0//tX?=
 =?us-ascii?Q?fnOQvvgElJyL/az1cjO9p0nFSV5L6uADBsazjk1xR46D5eaXmnB3aby3AuYm?=
 =?us-ascii?Q?c1T4M6DYE6RtzLmURDwIf2LmyOpiHenWYvWSuw5lPv8zlCegRQWdzISnblS3?=
 =?us-ascii?Q?ldI4Kcx8usUipV0RLA+SY56tr+cvxZaxRyawgXEPkEygtoaE8OrZ5Mu7/a3s?=
 =?us-ascii?Q?VBlEjGFL12M+PxkiMjuy95UEolQKRwTIRQ0123ZXSgpIS3FCawXqQjk179TR?=
 =?us-ascii?Q?78brc/4hzjIEKAJxsE/wKu3UCLfR13KNWT5/xP5O2g1+0XzFazvg88d2xrmq?=
 =?us-ascii?Q?Ec7hmdj0PzScCP5sA20iCCwFpHcgvaciWoiaq0qTr7n76YDaDfmvQmnFtjpn?=
 =?us-ascii?Q?o3tpoeLj2hQmMdmoCu0/eYq66NxyIRjo2g76IulFxbld4hOEpEsBG0ltSMbl?=
 =?us-ascii?Q?8HlXHPJCLHjMhgWr2dkL7BqJzZH9voLEmF9FB+ySqabaeIG/l9Z5NlrcHsRd?=
 =?us-ascii?Q?SNl1Xc4llO8J+DBEdq3z1VVKRhuAuOv0oegKCHeo/6H3ZlgnHcUVzy6Zcyhg?=
 =?us-ascii?Q?3/b/RF3gaN49c5f0OYk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:22:58.9899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1fcd30-b4e9-4e72-ca0f-08de22188226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697
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

[Why&How]
1.Add flow to enable and configure panel replay enablement and
configuration
2.Add registry key for enable option
3.Add replay version check to be compatible with freesync replay
4.Add AC/DC switch function to notify ac/dc change.
5.Add flow in set event function to check and decide Replay
enable/disable

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  25 ++++
 .../link/protocols/link_edp_panel_control.c   | 126 +++++++++++++++++-
 .../gpu/drm/amd/display/include/dpcd_defs.h   |  16 +++
 .../amd/display/modules/power/power_helpers.c |   3 +
 4 files changed, 168 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 55413923ea86..79e1696def63 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1357,6 +1357,31 @@ union dpcd_replay_configuration {
 	unsigned char raw;
 };
 
+union panel_replay_enable_and_configuration_1 {
+	struct {
+		unsigned char PANEL_REPLAY_ENABLE                     :1;
+		unsigned char PANEL_REPLAY_CRC_ENABLE                 :1;
+		unsigned char IRQ_HPD_ASSDP_MISSING                   :1;
+		unsigned char IRQ_HPD_VSCSDP_UNCORRECTABLE_ERROR      :1;
+		unsigned char IRQ_HPD_RFB_ERROR                       :1;
+		unsigned char IRQ_HPD_ACTIVE_FRAME_CRC_ERROR          :1;
+		unsigned char PANEL_REPLAY_SELECTIVE_UPDATE_ENABLE    :1;
+		unsigned char PANEL_REPLAY_EARLY_TRANSPORT_ENABLE     :1;
+	} bits;
+	unsigned char raw;
+};
+
+union panel_replay_enable_and_configuration_2 {
+	struct {
+		unsigned char SINK_REFRESH_RATE_UNLOCK_GRANTED        :1;
+		unsigned char RESERVED                                :1;
+		unsigned char SU_Y_GRANULARITY_EXT_VALUE_ENABLED      :1;
+		unsigned char SU_Y_GRANULARITY_EXT_VALUE              :4;
+		unsigned char SU_REGION_SCAN_LINE_CAPTURE_INDICATION  :1;
+	} bits;
+	unsigned char raw;
+};
+
 union dpcd_alpm_configuration {
 	struct {
 		unsigned char ENABLE                    : 1;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 9391c75a30e5..c56e69eb27ef 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -949,7 +949,7 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 	/* Set power optimization flag */
 	if (power_opts && link->replay_settings.replay_power_opt_active != *power_opts) {
 		if (replay != NULL && link->replay_settings.replay_feature_enabled &&
-		    replay->funcs->replay_set_power_opt) {
+			replay->funcs->replay_set_power_opt) {
 			replay->funcs->replay_set_power_opt(replay, *power_opts, panel_inst);
 			link->replay_settings.replay_power_opt_active = *power_opts;
 		}
@@ -984,7 +984,117 @@ bool edp_get_replay_state(const struct dc_link *link, uint64_t *state)
 	return true;
 }
 
-bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream)
+static bool edp_setup_panel_replay(struct dc_link *link, const struct dc_stream_state *stream)
+{
+	/* To-do: Setup Replay */
+	struct dc *dc;
+	struct dmub_replay *replay;
+	int i;
+	unsigned int panel_inst;
+	struct replay_context replay_context = { 0 };
+	unsigned int lineTimeInNs = 0;
+
+	union panel_replay_enable_and_configuration_1 pr_config_1 = { 0 };
+	union panel_replay_enable_and_configuration_2 pr_config_2 = { 0 };
+
+	union dpcd_alpm_configuration alpm_config;
+
+	replay_context.controllerId = CONTROLLER_ID_UNDEFINED;
+
+	if (!link)
+		return false;
+
+	//Clear Panel Replay enable & config
+	dm_helpers_dp_write_dpcd(link->ctx, link,
+		DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_1,
+		(uint8_t *)&(pr_config_1.raw), sizeof(uint8_t));
+
+	dm_helpers_dp_write_dpcd(link->ctx, link,
+		DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_2,
+		(uint8_t *)&(pr_config_2.raw), sizeof(uint8_t));
+
+	if (!(link->replay_settings.config.replay_supported))
+		return false;
+
+	dc = link->ctx->dc;
+
+	//not sure should keep or not
+	replay = dc->res_pool->replay;
+
+	if (!replay)
+		return false;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
+	replay_context.aux_inst = link->ddc->ddc_pin->hw_info.ddc_channel;
+	replay_context.digbe_inst = link->link_enc->transmitter;
+	replay_context.digfe_inst = link->link_enc->preferred_engine;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (dc->current_state->res_ctx.pipe_ctx[i].stream
+				== stream) {
+			/* dmcu -1 for all controller id values,
+			 * therefore +1 here
+			 */
+			replay_context.controllerId =
+				dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg->inst + 1;
+			break;
+		}
+	}
+
+	lineTimeInNs =
+		((stream->timing.h_total * 1000000) /
+			(stream->timing.pix_clk_100hz / 10)) + 1;
+
+	replay_context.line_time_in_ns = lineTimeInNs;
+
+	link->replay_settings.replay_feature_enabled =
+			replay->funcs->replay_copy_settings(replay, link, &replay_context, panel_inst);
+
+	if (link->replay_settings.replay_feature_enabled) {
+		pr_config_1.bits.PANEL_REPLAY_ENABLE = 1;
+		pr_config_1.bits.PANEL_REPLAY_CRC_ENABLE = 1;
+		pr_config_1.bits.IRQ_HPD_ASSDP_MISSING = 1;
+		pr_config_1.bits.IRQ_HPD_VSCSDP_UNCORRECTABLE_ERROR = 1;
+		pr_config_1.bits.IRQ_HPD_RFB_ERROR = 1;
+		pr_config_1.bits.IRQ_HPD_ACTIVE_FRAME_CRC_ERROR = 1;
+		pr_config_1.bits.PANEL_REPLAY_SELECTIVE_UPDATE_ENABLE = 1;
+		pr_config_1.bits.PANEL_REPLAY_EARLY_TRANSPORT_ENABLE = 1;
+
+		pr_config_2.bits.SINK_REFRESH_RATE_UNLOCK_GRANTED = 0;
+		pr_config_2.bits.SU_Y_GRANULARITY_EXT_VALUE_ENABLED = 0;
+		pr_config_2.bits.SU_REGION_SCAN_LINE_CAPTURE_INDICATION = 0;
+
+		dm_helpers_dp_write_dpcd(link->ctx, link,
+			DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_1,
+			(uint8_t *)&(pr_config_1.raw), sizeof(uint8_t));
+
+		dm_helpers_dp_write_dpcd(link->ctx, link,
+			DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_2,
+			(uint8_t *)&(pr_config_2.raw), sizeof(uint8_t));
+
+		//ALPM Setup
+		memset(&alpm_config, 0, sizeof(alpm_config));
+		alpm_config.bits.ENABLE = link->replay_settings.config.alpm_mode != DC_ALPM_UNSUPPORTED ? 1 : 0;
+
+		if (link->replay_settings.config.alpm_mode == DC_ALPM_AUXLESS) {
+			alpm_config.bits.ALPM_MODE_SEL = 1;
+			alpm_config.bits.ACDS_PERIOD_DURATION = 1;
+		}
+
+		dm_helpers_dp_write_dpcd(
+			link->ctx,
+			link,
+			DP_RECEIVER_ALPM_CONFIG,
+			&alpm_config.raw,
+			sizeof(alpm_config.raw));
+	}
+
+	return true;
+}
+
+static bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_state *stream)
 {
 	/* To-do: Setup Replay */
 	struct dc *dc;
@@ -1080,6 +1190,18 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
 	return true;
 }
 
+bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream)
+{
+	if (!link)
+		return false;
+	if (link->replay_settings.config.replay_version == DC_VESA_PANEL_REPLAY)
+		return edp_setup_panel_replay(link, stream);
+	else if (link->replay_settings.config.replay_version == DC_FREESYNC_REPLAY)
+		return edp_setup_freesync_replay(link, stream);
+	else
+		return false;
+}
+
 /*
  * This is general Interface for Replay to set an 32 bit variable to dmub
  * replay_FW_Message_type: Indicates which instruction or variable pass to DMUB
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index de8f3cfed6c8..07b937b92efc 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -30,6 +30,22 @@
 #ifndef DP_SINK_HW_REVISION_START // can remove this once the define gets into linux drm_dp_helper.h
 #define DP_SINK_HW_REVISION_START 0x409
 #endif
+/* Panel Replay*/
+#ifndef DP_PANEL_REPLAY_CAPABILITY_SUPPORT // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PANEL_REPLAY_CAPABILITY_SUPPORT 0x0b0
+#endif /* DP_PANEL_REPLAY_CAPABILITY_SUPPORT */
+#ifndef DP_PANEL_REPLAY_CAPABILITY // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PANEL_REPLAY_CAPABILITY 0x0b1
+#endif /* DP_PANEL_REPLAY_CAPABILITY */
+#ifndef DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_1  // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_1  0x1b0
+#endif /* DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_1 */
+#ifndef DP_PANEL_REPLAY_ENABLE // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PANEL_REPLAY_ENABLE (1 << 0)
+#endif /* DP_PANEL_REPLAY_ENABLE */
+#ifndef DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_2 // can remove this once the define gets into linux drm_dp_helper.h
+#define DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_2 0x1b1
+#endif /* DP_PANEL_REPLAY_ENABLE_AND_CONFIGURATION_2 */
 
 enum dpcd_revision {
 	DPCD_REV_10 = 0x10,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 88b5b716a084..fd139b219bf9 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -1037,6 +1037,9 @@ void calculate_replay_link_off_frame_count(struct dc_link *link,
 	uint8_t max_link_off_frame_count = 0;
 	uint16_t max_deviation_line = 0,  pixel_deviation_per_line = 0;
 
+	if (!link || link->replay_settings.config.replay_version != DC_FREESYNC_REPLAY)
+		return;
+
 	max_deviation_line = link->dpcd_caps.pr_info.max_deviation_line;
 	pixel_deviation_per_line = link->dpcd_caps.pr_info.pixel_deviation_per_line;
 
-- 
2.43.0

