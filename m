Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCAAC3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE4E10E34D;
	Wed, 17 Jul 2024 19:39:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iXBheFVI";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E1110E36D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXeMFjut4bgBWC9dCIlTzHbvhOa/Y7fk9e3nXBVAvtvsKgz8uDKk1k/Aw45ydd41awHd3+BpPKLsJFIEb9Adidg4n5Ol5kCY6/U1HX42BSbyQaT0kTLwHflAGV7UxW9Di6lWJ6c/MpAo0zy+2xQ0yzD+5fo/b9BeaZq3n9YmJ8P55xd1j0p27/yxq0QEDPv+TK712DMFIyH1hjBbeVQf+KSgwSN6f51UDR+HTdfm6bSu4wWTz5RvCaKDMxB1F0nfDXEl+h1QcRe4v+ZJ9gZKtBFPGDzDNoaRYCioIEZpWb74jr0cHuoNzJERqR4cc+U5gvrqK9XlCexDgr9evSm+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGBM46IOUSgYWClRGbHNKwj+kXHHIA6rD7j9gOniBVo=;
 b=JMk036FXEve3Tz6tEoqqOI6oDeg9GT/58UU5SVBCsqeoIek9qh3WhgSm2omwsHaAE/C+x2sy5qISvdwXgTlTL/PBikUeMa472iT7FGU/sPUmLiAwS0tfWvvjhRobncaqIQrDly0vr1NwYIVKPeiyEUZLGy/TXvP2Y3G+1hJgJuSX74yEtaqUmY3n2L7lg1MatdYQ/CuLPrU5iiE8gFx61HRYdZgcYx/59XzTzAGEX/tDb9K564IjeSpu80RoQkRbmYg+ZXkfuM+PgsogxXjf2Crr8AXxL/y/4rEhmHMpqCBVPWdpAmXXR+/t4lRpEDCPOkxku1tkLaRQKxVQlkuz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGBM46IOUSgYWClRGbHNKwj+kXHHIA6rD7j9gOniBVo=;
 b=iXBheFVI8GbDogb4ru9kv8qlqLSzbpZdUsWjBUMlJTVcuZr/lPgNhDkMa3tpChWNzyD8Qmdx9Fjp+YVScOYG/dGbThEgnrAlZh0Y0FzM1R39pWXhPKD6T86kDY1gXRPbbAB57t3K8H35lzxdYcVWYuNXyvn4s0Oi0bkuhl8VL3g=
Received: from DM6PR13CA0001.namprd13.prod.outlook.com (2603:10b6:5:bc::14) by
 PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 19:39:14 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::c7) by DM6PR13CA0001.outlook.office365.com
 (2603:10b6:5:bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.8 via Frontend
 Transport; Wed, 17 Jul 2024 19:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:39:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:13 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:39:07 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 01/22] drm/amd/display: Remove hardmax usage for dcn401
Date: Wed, 17 Jul 2024 19:38:40 +0000
Message-ID: <20240717193901.8821-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: ade95642-1ca2-44ba-d2ce-08dca6982375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?789lqekKOHoRdbtkCUtUzFdwB5lhcP603iLrZUXPRuozdIUBlVpK2cQSlULo?=
 =?us-ascii?Q?fMtmqAbW7zzDefq2VJ5Qt0NyhmCtTqxnj1KzeJ9jclAoX+WQgGO0bJO2rALM?=
 =?us-ascii?Q?OorTbnnYIkpGdcxIQjHOyFYh6y10jiUBzq4b4vOfBPJPrgYcKYCauLqNJSz3?=
 =?us-ascii?Q?Hdi1PTt3nYuIU7ULEv1VDuW8I/A6OpDjJiZMS5YAQhJhv3La/1Gz8Xb0XLCm?=
 =?us-ascii?Q?l8FND1BVWmXHklw00GgEUyt4BRRw91VVz5IkssSoxATKncRhUD5ic1oZS/Yl?=
 =?us-ascii?Q?djLutyL5tr05nwu811I+vJXki3OSr14XsRIYIsq2DRsJhWhvyBLQ5L9K6+2v?=
 =?us-ascii?Q?FlnofxeUZKY8G/1v0ZRMuXPTlnhK+/i67JwcYBxWz19Hh/tLYTOlcOwxTsgO?=
 =?us-ascii?Q?oBs+70VJYEU7vkOr3D4llq/cV3axpTT6L9lAEyXWl3KQzoJquZZkGL4nF4iE?=
 =?us-ascii?Q?nbw6wxlFWHWz+oaKt7KR11XRaf+R0c6UvPB+bUPhnbzIUoSBQ+dBbjS5qUv9?=
 =?us-ascii?Q?uTcr4PuIOT0QEH/zzOt1ZqhjSgumlPUm9EJCzsLiucisb1TEUrsstoLQzkmV?=
 =?us-ascii?Q?94OmU5SL6oNfRHPQwhSM05DiJthVXW6/zMIAWu9cGy0uzJj8oa78QyDE86K4?=
 =?us-ascii?Q?qebNDzIcXwUzGd2rGZC1Qdak95UAmb/uRJ3ufjA4dlpepgAvDdMA4QlZaNR/?=
 =?us-ascii?Q?o1xq20P41ED3NM26bbrr/7NkY+HWDKH+sSotUKtUJQ4BELe/Eb3Yj6Byjnoc?=
 =?us-ascii?Q?gAhUIEay4N/XMYqSt+vQsSJFYR2Z4fGLGntpzVIYRNFaFolXuFI8xedwEyw5?=
 =?us-ascii?Q?qHFrUwm74+3/u6fMXrSgTEXpuxw5acxsIDeUhfkG8E0JaM8LTeY9eAFCwwlA?=
 =?us-ascii?Q?KrcMNZ68AXj7WFrVgY+llazruUmOaOGm7GULh8anXbeIHkrzyc9XlFcMZ3s8?=
 =?us-ascii?Q?rpmU+6llaaSzVpvA9rDyWLQ8bG3VMczAz/9emfnuSW2POLD/tUGq8SoEREGL?=
 =?us-ascii?Q?j0uSgLaesxVrgxUzLjYABgbLdNZs88q+g9bBDFWSStdjAFZpRz0kNrmUHynm?=
 =?us-ascii?Q?95gTMcR5OxtU/Hb1+0VQfRGUeumsgIhLTq/wjym1ouF+6uBo7lwCvuv926Re?=
 =?us-ascii?Q?MOTPFwklXREOVQlk3LF4A0BPM34PPNValBmFt5m0pb+6ZZIZNJnABFZ2UkD8?=
 =?us-ascii?Q?pjL3fxhcVMBgNF8N1rYm1/981kdFzdkwtiZwf9XHNJx2+3tCFRITTsOfz+9Z?=
 =?us-ascii?Q?mPHBiud0iCnC2KLcmWJpYE4w/xB2GDmXL76AgX6zWJmHoRhKQPO1Qg9AW/OH?=
 =?us-ascii?Q?UUKE+1VVKTKVAvqXHAt44pkGuQC55p3w5Kh3hDp3EqrQaCgIIn4KFGNbZX/A?=
 =?us-ascii?Q?M+RYL8pOL5rGJZJ61M0RtWzvERaAyUrK8Zf0wKyjacyr1a9d2YkNn/bwZH5U?=
 =?us-ascii?Q?5BkRTH1N4G0GsuUgyodjAhZayLnqwjI1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:39:13.8994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ade95642-1ca2-44ba-d2ce-08dca6982375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Hardmax message will be retired for dcn4, so this removes it.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 44 ++++++++++---------
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 11 ++---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  3 --
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index c453c5f15ce7..cce425dd62d2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -931,12 +931,12 @@ static void dcn401_execute_block_sequence(struct clk_mgr *clk_mgr_base, unsigned
 static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 		struct clk_mgr *clk_mgr_base,
 		struct dc_state *context,
+		struct dc_clocks *new_clocks,
 		bool safe_to_lower)
 {
 	struct clk_mgr_internal *clk_mgr_internal = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dcn401_clk_mgr *clk_mgr401 = TO_DCN401_CLK_MGR(clk_mgr_internal);
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dcn401_clk_mgr_block_sequence *block_sequence = clk_mgr401->block_sequence;
 	bool enter_display_off = false;
 	bool update_active_fclk = false;
@@ -1218,13 +1218,13 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 static unsigned int dcn401_build_update_display_clocks_sequence(
 		struct clk_mgr *clk_mgr_base,
 		struct dc_state *context,
+		struct dc_clocks *new_clocks,
 		bool safe_to_lower)
 {
 	struct clk_mgr_internal *clk_mgr_internal = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dcn401_clk_mgr *clk_mgr401 = TO_DCN401_CLK_MGR(clk_mgr_internal);
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	struct dmcu *dmcu = clk_mgr_base->ctx->dc->res_pool->dmcu;
-	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dcn401_clk_mgr_block_sequence *block_sequence = clk_mgr401->block_sequence;
 	bool force_reset = false;
 	bool update_dispclk = false;
@@ -1375,6 +1375,7 @@ static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
 	/* build bandwidth related clocks update sequence */
 	num_steps = dcn401_build_update_bandwidth_clocks_sequence(clk_mgr_base,
 			context,
+			&context->bw_ctx.bw.dcn.clk,
 			safe_to_lower);
 
 	/* execute sequence */
@@ -1383,6 +1384,7 @@ static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
 	/* build display related clocks update sequence */
 	num_steps = dcn401_build_update_display_clocks_sequence(clk_mgr_base,
 			context,
+			&context->bw_ctx.bw.dcn.clk,
 			safe_to_lower);
 
 	/* execute sequence */
@@ -1474,33 +1476,34 @@ static void dcn401_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 static void dcn401_set_hard_min_memclk(struct clk_mgr *clk_mgr_base, bool current_mode)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	const struct dc *dc = clk_mgr->base.ctx->dc;
+	struct dc_state *context = dc->current_state;
+	struct dc_clocks new_clocks;
+	int num_steps;
 
 	if (!clk_mgr->smu_present || !dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_UCLK))
 		return;
 
+	/* build clock update */
+	memcpy(&new_clocks, &clk_mgr_base->clks, sizeof(struct dc_clocks));
+
 	if (current_mode) {
-		if (clk_mgr_base->clks.p_state_change_support)
-			dcn401_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
-		else
-			dcn401_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					clk_mgr_base->bw_params->max_memclk_mhz);
+		new_clocks.dramclk_khz = context->bw_ctx.bw.dcn.clk.dramclk_khz;
+		new_clocks.idle_dramclk_khz = context->bw_ctx.bw.dcn.clk.idle_dramclk_khz;
+		new_clocks.p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
 	} else {
-		dcn401_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-				clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz);
+		new_clocks.dramclk_khz = clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz * 1000;
+		new_clocks.idle_dramclk_khz = new_clocks.dramclk_khz;
+		new_clocks.p_state_change_support = true;
 	}
-}
 
-/* Set max memclk to highest DPM value */
-static void dcn401_set_hard_max_memclk(struct clk_mgr *clk_mgr_base)
-{
-	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-
-	if (!clk_mgr->smu_present || !dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_UCLK))
-		return;
+	num_steps = dcn401_build_update_bandwidth_clocks_sequence(clk_mgr_base,
+			context,
+			&new_clocks,
+			true);
 
-	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK,
-			clk_mgr_base->bw_params->max_memclk_mhz);
+	/* execute sequence */
+	dcn401_execute_block_sequence(clk_mgr_base,	num_steps);
 }
 
 /* Get current memclk states, update bounding box */
@@ -1631,7 +1634,6 @@ static struct clk_mgr_funcs dcn401_funcs = {
 		.init_clocks = dcn401_init_clocks,
 		.notify_wm_ranges = dcn401_notify_wm_ranges,
 		.set_hard_min_memclk = dcn401_set_hard_min_memclk,
-		.set_hard_max_memclk = dcn401_set_hard_max_memclk,
 		.get_memclk_states_from_smu = dcn401_get_memclk_states_from_smu,
 		.are_clock_states_equal = dcn401_are_clock_states_equal,
 		.enable_pme_wa = dcn401_enable_pme_wa,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f07b13ad4ead..b71c4d8e73dd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5462,9 +5462,10 @@ static void blank_and_force_memclk(struct dc *dc, bool apply, unsigned int memcl
 			hubp->funcs->set_blank_regs(hubp, true);
 		}
 	}
-
-	dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, memclk_mhz);
-	dc->clk_mgr->funcs->set_min_memclk(dc->clk_mgr, memclk_mhz);
+	if (dc->clk_mgr->funcs->set_max_memclk)
+		dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, memclk_mhz);
+	if (dc->clk_mgr->funcs->set_min_memclk)
+		dc->clk_mgr->funcs->set_min_memclk(dc->clk_mgr, memclk_mhz);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		pipe = &context->res_ctx.pipe_ctx[i];
@@ -5513,7 +5514,7 @@ void dc_enable_dcmode_clk_limit(struct dc *dc, bool enable)
 
 	if (enable && !dc->clk_mgr->dc_mode_softmax_enabled) {
 		if (p_state_change_support) {
-			if (funcMin <= softMax)
+			if (funcMin <= softMax && dc->clk_mgr->funcs->set_max_memclk)
 				dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, softMax);
 			// else: No-Op
 		} else {
@@ -5523,7 +5524,7 @@ void dc_enable_dcmode_clk_limit(struct dc *dc, bool enable)
 		}
 	} else if (!enable && dc->clk_mgr->dc_mode_softmax_enabled) {
 		if (p_state_change_support) {
-			if (funcMin <= softMax)
+			if (funcMin <= softMax && dc->clk_mgr->funcs->set_max_memclk)
 				dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, maxDPM);
 			// else: No-Op
 		} else {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index f4c1547a368f..779960278a5c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -416,9 +416,6 @@ void dcn401_init_hw(struct dc *dc)
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
-		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
-
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
 		dc->res_pool->hubbub->funcs->force_pstate_change_control(
 				dc->res_pool->hubbub, false, false);
-- 
2.39.2

