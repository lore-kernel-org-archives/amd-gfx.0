Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F47C021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821E310E562;
	Tue, 25 Feb 2025 06:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="08hsxH2/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41E210E562
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQJ4gcfRiX0vBb1i/4JRhggZy5RuFjl3rOVyYNgouQBNQ8iQCU4zh8AKthpUZ8fMFCOAml6cnRvRrTgU1JYQtOO3SyY5XqyHA1dfTF7YDaoESY8Sb9hL4sy+c18aSsFfx2DpS5spcgGeoI4ZhV0zQay2tUNmEB0kvc82TsIINyygz4kwaJ0HSOYPZhPeclNfSMllxWQQXPePvsijjLyGsweQeJYiCV1QoFznNzuQgT2MMFEtqHPIaoWCSRm1rxcmZD57WD/kYt6RNc0SP4EYI4/iuswTuORMwReM2gi70Iizi7jTDNWABBarOv5yJxJZniGvPX/gz/ZblNCiIWqsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lrz21ksbYDu0nMo3eymDEWZmTQLjUAZl3jiI9RPYBPs=;
 b=y20kSOZ2kfWAbvoy+Cuw98KTnzsh02ixe9JCLgcxEmwNJLyMwrmUnkmpHen7Mf3yElOBG79JY+moNXEed4lyKdRPDNJhq9taHt0F9OyE1G7bFvMPt8LfKXejkRuDzKpXQG7rUeDeNkWeriDwQi5lCtWUyqTev4BN5ypz61V5c0TzWIW030hUr/1ZCUPnmtbk7LwH/P5zBAthShHj9/2JjDP7ZFkj9prZmawBIPod/k0i5BLcuLaqRNkgnoDc6LCWurQ5cVO+1BVK95zPlowb6KUGF7uVCxLsrPh+nFkMUXMTGtEgbpF92g2TGiwCPo2QS5E2wUYbNrKT5eo2MnB7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lrz21ksbYDu0nMo3eymDEWZmTQLjUAZl3jiI9RPYBPs=;
 b=08hsxH2/2PJoGc8cjfSkLnfStXjlA78OOQvtRbNgr81E0loUJ4MlEcdXxQ3ssdtapOZo2RE5BIp0nwa5ED65YWsyMIThj/35mQWG5892Ris+M5oig9sajm+grLq3Hm1fS/Rzo58fekSLnIpvpNSBEIijgIGwb2k2zJKjd2nRm9Q=
Received: from BN0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:e7::12)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:37:26 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::a3) by BN0PR03CA0037.outlook.office365.com
 (2603:10b6:408:e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 06:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:37:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:26 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:37:21 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Leo Zeng <Leo.Zeng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 11/27] drm/amd/display: Added visual confirm for DCC
Date: Tue, 25 Feb 2025 14:35:54 +0800
Message-ID: <20250225063610.631461-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 411778f8-6293-4272-8d58-08dd5566dea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VQe/CJ7X+FSTzzMtFj8B33n7EFJaSJyX8yJDCB15pVxxZAkUOIYq62Ftc0Jg?=
 =?us-ascii?Q?hHkHsrGMMWCkIZd6RENt+HXQzaAPja0DI1mzTz1q5BT59uTUew2j1jvIoorD?=
 =?us-ascii?Q?MOYKCGb3R9YMpC/2PLaTbho0WK8z2OO1l0zsIbSo3eCKg0lOy/mOnNR6xKGy?=
 =?us-ascii?Q?GUTbJTprrJuexfL0o1u2lkeYWzv+doaSQyzbLENbgywETaRJB9HJBwm6ZTcS?=
 =?us-ascii?Q?VhctruV0nz/FnhPqVvQuYkTfik1/+N7URQDQeN3FLuykr5NoQTrnTDKVP/PE?=
 =?us-ascii?Q?vqlg2HGqNk4rDrUVij679Fv8XeD8HORWuaYm6ABcrN0KY+YQ7bmBdCGGFx2C?=
 =?us-ascii?Q?3XPEbQlmvCvky4PieeyFza6P4+VfUSeqLTbFBIsQc/D33nEMZEGuzxHuEaq4?=
 =?us-ascii?Q?hQTwOe1oFKEFGgLfCBjqyVEQgR6pXPzEbpJPkIxrHpNGMBpJFec2fjVgdH3A?=
 =?us-ascii?Q?HPm/Jx7swdEI9r5ut5cle7jqCTQMDW54z0DqjH7HcwXkWR9MUHKEZ7LedcQq?=
 =?us-ascii?Q?CJbyACDqk5quflyZuxYs9Z+HNBvTbUlRuFdFLx0v3d8xDtJU1BWI1HIA6Sen?=
 =?us-ascii?Q?rMdtUJtHYsAJujqc7znoCuEWol3npaCyFfOiale0/Cuv9pX4O3MRwnuj6f6m?=
 =?us-ascii?Q?V2Owvt2c5NnwkWj8lmWUXjbXpwUF/6PT2W3wGHawsIZXQUQSo9MUKL8sHwQW?=
 =?us-ascii?Q?XtJ1TC2E9s1aj5gx5BfJWDX4LgOX64/zz5eevhXdgf/mHCmcAp8M5gDe2Rte?=
 =?us-ascii?Q?OuG39cdH2vkfh39nFudMrLheetK3AVt4GkHs6h9PpkZvUAtQmS9qgFnvh+6l?=
 =?us-ascii?Q?+Q2dEqJCEt3LtNykEKLa2vOpucJdNKZoOKl/c5xMWtBDSnM+5jjZD7pIvqPE?=
 =?us-ascii?Q?0bHCXQaFtZoSXGnHgkQQ7dj+hNI5u62iGJ+EFDpBG5eGy1eAsgn7LRF09bj7?=
 =?us-ascii?Q?oyb2kf11Io9rS5n1ugS4rlVwc1/a/GQctHhcoXxxpcMEWlAcYj29C3OSvyeD?=
 =?us-ascii?Q?6NlZFykrpQE44Xdgy1uXQxHRQw8kHZ+ak7NfAD4UHt2ti2nn3bLmaPY3cImo?=
 =?us-ascii?Q?wEZRhvAXRLlEoANVCojFfcQiB7HhOXTtU2y2SK3bcF1kLdx8yK0rK1DSapJX?=
 =?us-ascii?Q?Ykg/6l6FWejratk89+FqxncBMvgOluf4z+wgqQMlmgUsoutU0GAO3HWPf5we?=
 =?us-ascii?Q?PR7i8J/9DYD4tRnK/lrHE8REounwFAs121V8I9CBoWJc9mTyx/fSRWkb14rC?=
 =?us-ascii?Q?zHZamIgC3WYosfKjJEAj1h+vCB3pFQ66m3MjSszmf+/7s3AB38ql6YxgHicw?=
 =?us-ascii?Q?KWr/KyPeTLD47cvdcQXauGHMsV9xS65e6U21H9/REuB49hfRgMgg9oNcijd+?=
 =?us-ascii?Q?NwMOljKqcg5cHZ0lYdSVj0c53R18Ap+Zi+h6Yx8ajAGjfafBq5hbiCbWAfEt?=
 =?us-ascii?Q?7KwIoE+QPof4nIe507GjF5MZsQRWFrkAEL92xJK90l0l9VFxGlavgpTJROAQ?=
 =?us-ascii?Q?oHbWpt91NAYZn78=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:37:26.6360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 411778f8-6293-4272-8d58-08dd5566dea4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
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

From: Leo Zeng <Leo.Zeng@amd.com>

[WHY]
We want to add a visual confirm mode for DCC and MCache for
debugging purpose.

[HOW]
color pipes based on whether DCC is enabled and what MCache id
is used.
black - DCC disabled
red - DCC enabled
grey - 2 different MCaches used
other colors - 1 MCache used

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Leo Zeng <Leo.Zeng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  8 ++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 48 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  5 ++
 4 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index fe59649d3e15..e71ea21401f5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1202,6 +1202,8 @@ static void dc_update_visual_confirm_color(struct dc *dc, struct dc_state *conte
 			get_surface_tile_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
 		else if (dc->debug.visual_confirm == VISUAL_CONFIRM_HW_CURSOR)
 			get_cursor_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
+		else if (dc->debug.visual_confirm == VISUAL_CONFIRM_DCC)
+			get_dcc_visual_confirm_color(dc, pipe_ctx, &(pipe_ctx->visual_confirm_color));
 		else {
 			if (dc->ctx->dce_version < DCN_VERSION_2_0)
 				color_space_to_black_color(
@@ -3956,6 +3958,9 @@ static void commit_planes_for_stream(struct dc *dc,
 	if (update_type == UPDATE_TYPE_FULL && dc->optimized_required)
 		hwss_process_outstanding_hw_updates(dc, dc->current_state);
 
+	if (update_type != UPDATE_TYPE_FAST && dc->res_pool->funcs->prepare_mcache_programming)
+		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
@@ -4014,9 +4019,6 @@ static void commit_planes_for_stream(struct dc *dc,
 				odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
 	}
 
-	if (update_type != UPDATE_TYPE_FAST && dc->res_pool->funcs->prepare_mcache_programming)
-		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
-
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program &&
 			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 367c6b794412..e0277728268a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -34,6 +34,7 @@
 #include "dc_state_priv.h"
 
 #define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
+#define MAX_NUM_MCACHE 8
 
 /* used as index in array of black_color_format */
 enum black_color_format {
@@ -553,6 +554,53 @@ void get_cursor_visual_confirm_color(
 	}
 }
 
+void get_dcc_visual_confirm_color(
+	struct dc *dc,
+	struct pipe_ctx *pipe_ctx,
+	struct tg_color *color)
+{
+	const uint32_t MCACHE_ID_UNASSIGNED = 0xF;
+
+	if (!pipe_ctx->plane_state->dcc.enable) {
+		color->color_r_cr = 0; /* black - DCC disabled */
+		color->color_g_y = 0;
+		color->color_b_cb = 0;
+		return;
+	}
+
+	if (dc->ctx->dce_version < DCN_VERSION_4_01) {
+		color->color_r_cr = MAX_TG_COLOR_VALUE; /* red - DCC enabled */
+		color->color_g_y = 0;
+		color->color_b_cb = 0;
+		return;
+	}
+
+	uint32_t first_id = pipe_ctx->mcache_regs.main.p0.mcache_id_first;
+	uint32_t second_id = pipe_ctx->mcache_regs.main.p0.mcache_id_second;
+
+	if (first_id != MCACHE_ID_UNASSIGNED && second_id != MCACHE_ID_UNASSIGNED && first_id != second_id) {
+		color->color_r_cr = MAX_TG_COLOR_VALUE/2; /* grey - 2 mcache */
+		color->color_g_y = MAX_TG_COLOR_VALUE/2;
+		color->color_b_cb = MAX_TG_COLOR_VALUE/2;
+	}
+
+	else if (first_id != MCACHE_ID_UNASSIGNED || second_id != MCACHE_ID_UNASSIGNED) {
+		const struct tg_color id_colors[MAX_NUM_MCACHE] = {
+		{0, MAX_TG_COLOR_VALUE, 0}, /* green */
+		{0, 0, MAX_TG_COLOR_VALUE}, /* blue */
+		{MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE, 0}, /* yellow */
+		{MAX_TG_COLOR_VALUE, 0, MAX_TG_COLOR_VALUE}, /* magenta */
+		{0, MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE}, /* cyan */
+		{MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE}, /* white */
+		{MAX_TG_COLOR_VALUE/2, 0, 0}, /* dark red */
+		{0, MAX_TG_COLOR_VALUE/2, 0}, /* dark green */
+		};
+
+		uint32_t assigned_id = (first_id != MCACHE_ID_UNASSIGNED) ? first_id : second_id;
+		*color = id_colors[assigned_id];
+	}
+}
+
 void set_p_state_switch_method(
 		struct dc *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f646f537a3dc..02bf6fe51a0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -495,6 +495,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_FAMS2 = 19,
 	VISUAL_CONFIRM_HW_CURSOR = 20,
 	VISUAL_CONFIRM_VABC = 21,
+	VISUAL_CONFIRM_DCC = 22,
 };
 
 enum dc_psr_power_opts {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 599fa41fd75f..2b1a2a00648a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -517,6 +517,11 @@ void get_cursor_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
 
+void get_dcc_visual_confirm_color(
+	struct dc *dc,
+	struct pipe_ctx *pipe_ctx,
+	struct tg_color *color);
+
 void set_p_state_switch_method(
 		struct dc *dc,
 		struct dc_state *context,
-- 
2.37.3

