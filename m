Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5AFC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F21610E8C1;
	Wed, 10 Jul 2024 19:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KC0uJ0iV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F0910E8BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acY2f02I2IHEGOKPiUyQKzxT459N3yS0GEBWlUsmFWz55wC0S9qXmfuw1yBEj+kIjGJmltg5T6ZRroDEsjNnVSnICfxQtjMtGPOkC8emuVjdc1ufQDtlPnTj+cZYrFw3C+m9CYdNSqgmS+/DTlSb2NeVFnrPcFofyqMbZ/R+N9sqO7ZXSLxnbOculflVB7H8xz3PgNND4AT4wsg5zAXRp2Axb4ij+kNK+pKva5GCeFKRI41WgOdfPTVZGEegz1J8lWgw5Nw0+UZu5kACCNXXcgH5ShcjPbdTW1sL3t1xPWBHJ90ZYnB5DpETEHUOht28HNuDDFoITKgQgPzJ3kaiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFsCyXVig+wgWPYwzjmKhEAY7d8pREQrwvhHhtdzVik=;
 b=YxtffKz2yLm3iHtVcnFWj4FySvEffOEUSGLxSKcs43OqqxPh87bKmucgopGhzb+hbiwqWAY8spMRArvJXLLGJOINeMWQV1N4fevKwoqwG5q4c0ONPaj/BQvY1nEYKxlxhbfUdIBOvpxehkK9emoejG3+aPuxqo2MxNqlInDUhxMKjE04w9+FSgYe9pQ5FYbz4Hb43PWzvyrcgKH7RfzX2ERLhSob5uPFyWHqS2kRnFECbaiKDt3cfF6/AzBxvoidcXVowDvgtnFOhgYBui5oestmfe8sqqYBF48K7Kh3u5mRDYtvpo4EIMmGFt+lKIuN7NhNAK1JEgoAFwK7KarJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFsCyXVig+wgWPYwzjmKhEAY7d8pREQrwvhHhtdzVik=;
 b=KC0uJ0iVIRXTo8+8WMc0TSZfED+5s125lyjuYTGH+imXbgjX2l/7yY0waCfgsu8G/E1Bl6zMFGNaXP+aCB0CUDqHUzN9GcOLwJ2X6hP4qvSJAq+0n33bmGjr4ebUPmgz+dMWSG0tcIsbMXPFu54DvYz3A87VJwk4BRIVVUvOEog=
Received: from MN2PR22CA0005.namprd22.prod.outlook.com (2603:10b6:208:238::10)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:39:56 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::f2) by MN2PR22CA0005.outlook.office365.com
 (2603:10b6:208:238::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:55 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:49 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 36/50] drm/amd/display: Check null pointers before used
Date: Wed, 10 Jul 2024 15:36:53 -0400
Message-ID: <20240710193707.43754-37-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM3PR12MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: 81348497-d22e-4f98-0828-08dca11813f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wmgIABOMdO7JmnlKuUoFf7Hdf8iN+aMT+XIyk/DghzeHnlbXp928R/fp0kx/?=
 =?us-ascii?Q?ArBhHff30PnFBHAQJ6GLiJxn/5VLH8vk02ktr4UNOmF9faw2dHkh4Wa7Cdqo?=
 =?us-ascii?Q?ewElWeSTqUdcSML9GBfOnqWAaBxAJJnGTKjPLsNrAKWwJy80Y7mIcKeehavu?=
 =?us-ascii?Q?0mSxf0wEfKnxKNSjKWDdDmFEbSPjK75N2FyGSuv98QtKEnJWyD6VsxYrLckI?=
 =?us-ascii?Q?JOnm1hDQnQc1QIP8+m+2aElfmI8VVqw77trBlTfoF6NrzRya+dGxsYGqAdSf?=
 =?us-ascii?Q?uRnb47PgHq2/6hNDj/iPX66fRK6mArD+fDQNrm1JbZjRiYx6OwgQoRrqPHe5?=
 =?us-ascii?Q?O5Kjxr9Gxr6vg84RdhK4mFMqyBf/gd2E78SFYm/Ld9vZvJhXID4Dh5L+S/dw?=
 =?us-ascii?Q?TyO9ghukNiLb0ogwrqUzsT+ajsiuQe8cf74WlpDC4y4pSMtwE2SrFc6ICdwL?=
 =?us-ascii?Q?zbPnY3KDBZU9ptdieTrCwyr5K59hUN1W0HHWRajuJ0CjqwRECYc0ls2T/wAA?=
 =?us-ascii?Q?ZJrByAZwAoUaqF0K4q2M1thywzAU3BLZf1inkMwSOERl+9tj2Jhj+vIzvUEX?=
 =?us-ascii?Q?x4wNX3ilt6KKFdJCUZtRTnHNJjsSj6nvRUxliHfQMM4i7OWobMP++CyJqbzE?=
 =?us-ascii?Q?q6ixZrLKpV3IuDFIeAs4L6E7WwcBTKm+mm4bPZD8uxJ971Jh/CUP5qFLGfwV?=
 =?us-ascii?Q?bT/FFtejrgffhdGDDLxAcgETurghx9hmPK4N4Zg8KpxHwBvhyMZ5WKlQeV9r?=
 =?us-ascii?Q?uZWz6rXt1l5X7IyU6o7BmOrEp8+CfXkR783aKT142A7siLFv18hJsA0AXUbV?=
 =?us-ascii?Q?lht93c737aTDXXkRks7+RLzZ+Lzh2hdT0gZkZN09G3ZBtQUW9shEdNpJHLsQ?=
 =?us-ascii?Q?B6CA7zXUuvGunj4fHct4PXlKblb40ZBU2L1oG44c+AF04EQ0+eSZexg8Lv8X?=
 =?us-ascii?Q?keC0NpeECKKG0iJyCSExLcxzWTGu8phGrI2KV8VDqz7t0pdbO3GdR03NV5cJ?=
 =?us-ascii?Q?XOaKvDMCD9McoeMIuZl6j1EaGyj4kNR/n5S1GzImWln6j7A3JnmWBhIPfrE6?=
 =?us-ascii?Q?T7NAXd/CDiV5v+Yyp4Fd6djF/Q0ev3VNTx0tqaTmZcE7lPbLq9wX+w26PAlx?=
 =?us-ascii?Q?fWv/3rJUlN2Ok/jvoPlnwaZZZskJFylIsZt8CL5/qPbRAZJL+rVZeEnMuYTj?=
 =?us-ascii?Q?Jo9YmiuIzEKHCl1kGgUlA73rq0+7LUa21bSbJIBHJ6QPS59LDBKByWzSu0+i?=
 =?us-ascii?Q?n3CvnCmZ/Gl6EXzMoWbkbJWIHBWWnR5mK6cVXo1N9IK+LDuw1aoxhbudxkl1?=
 =?us-ascii?Q?uHpyaqCRQNY+uwzRw3xFYBA2KRcn4lztAmB8a41kteA8XEkaEnJjjdQcYCNS?=
 =?us-ascii?Q?BHObHW97Wkqt93rXvwQY48rfojRwbKGN5DzpmbjDI30adtA8E0gbiUGpFLiC?=
 =?us-ascii?Q?M5xjFKxU1IwL4Ma9V8l6l06nWwnADTNH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:56.3576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81348497-d22e-4f98-0828-08dca11813f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
Poniters, such as dc->clk_mgr, are null checked previously in the same
function, so Coverity warns "implies that "dc->clk_mgr" might be null".
As a result, these pointers need to be checked when used again.

This fixes 10 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c    | 3 ++-
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c    | 3 ++-
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 5 +++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 4 ++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 4 ++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 8 ++++----
 .../amd/display/dc/link/protocols/link_dp_capability.c    | 2 +-
 8 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index 78df96882d6e..f8409453434c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -195,7 +195,7 @@ void dce11_pplib_apply_display_requirements(
 	 * , then change minimum memory clock based on real-time bandwidth
 	 * limitation.
 	 */
-	if ((dc->ctx->asic_id.chip_family == FAMILY_AI) &&
+	if (dc->bw_vbios && (dc->ctx->asic_id.chip_family == FAMILY_AI) &&
 	     ASICREV_IS_VEGA20_P(dc->ctx->asic_id.hw_internal_rev) && (context->stream_count >= 2)) {
 		pp_display_cfg->min_memory_clock_khz = max(pp_display_cfg->min_memory_clock_khz,
 							   (uint32_t) div64_s64(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index bf399819ca80..22ac2b7e49ae 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -749,7 +749,8 @@ bool hubp1_is_flip_pending(struct hubp *hubp)
 	if (flip_pending)
 		return true;
 
-	if (earliest_inuse_address.grph.addr.quad_part != hubp->request_address.grph.addr.quad_part)
+	if (hubp &&
+	    earliest_inuse_address.grph.addr.quad_part != hubp->request_address.grph.addr.quad_part)
 		return true;
 
 	return false;
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index 6bba020ad6fb..0637e4c552d8 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -927,7 +927,8 @@ bool hubp2_is_flip_pending(struct hubp *hubp)
 	if (flip_pending)
 		return true;
 
-	if (earliest_inuse_address.grph.addr.quad_part != hubp->request_address.grph.addr.quad_part)
+	if (hubp &&
+	    earliest_inuse_address.grph.addr.quad_part != hubp->request_address.grph.addr.quad_part)
 		return true;
 
 	return false;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 849b41f886d3..4593fb2a0536 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -949,7 +949,7 @@ void dce110_edp_backlight_control(
 {
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
-	uint8_t pwrseq_instance;
+	uint8_t pwrseq_instance = 0;
 	unsigned int pre_T11_delay = OLED_PRE_T11_DELAY;
 	unsigned int post_T7_delay = OLED_POST_T7_DELAY;
 
@@ -1002,7 +1002,8 @@ void dce110_edp_backlight_control(
 	 */
 	/* dc_service_sleep_in_milliseconds(50); */
 		/*edp 1.2*/
-	pwrseq_instance = link->panel_cntl->pwrseq_inst;
+	if (link->panel_cntl)
+		pwrseq_instance = link->panel_cntl->pwrseq_inst;
 
 	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON) {
 		if (!link->dc->config.edp_no_power_sequencing)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 4846601c612d..212576dbc336 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1553,7 +1553,7 @@ void dcn10_init_hw(struct dc *dc)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
 	/* Align bw context with hw config when system resume. */
-	if (dc->clk_mgr->clks.dispclk_khz != 0 && dc->clk_mgr->clks.dppclk_khz != 0) {
+	if (dc->clk_mgr && dc->clk_mgr->clks.dispclk_khz != 0 && dc->clk_mgr->clks.dppclk_khz != 0) {
 		dc->current_state->bw_ctx.bw.dcn.clk.dispclk_khz = dc->clk_mgr->clks.dispclk_khz;
 		dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz = dc->clk_mgr->clks.dppclk_khz;
 	}
@@ -1673,7 +1673,7 @@ void dcn10_init_hw(struct dc *dc)
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 746c522adf84..3d4b31bd9946 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -256,10 +256,10 @@ void dcn31_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index e4f7078c1026..ddf0807db627 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -235,7 +235,7 @@ void dcn35_init_hw(struct dc *dc)
 	if (hws->funcs.enable_power_gating_plane)
 		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
 */
-	if (res_pool->hubbub->funcs->dchubbub_init)
+	if (res_pool->hubbub && res_pool->hubbub->funcs->dchubbub_init)
 		res_pool->hubbub->funcs->dchubbub_init(dc->res_pool->hubbub);
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
@@ -328,10 +328,10 @@ void dcn35_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 
@@ -1039,7 +1039,7 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 		if (pipe_ctx->plane_res.hubp)
 			update_state->pg_pipe_res_update[PG_HUBP][pipe_ctx->plane_res.hubp->inst] = false;
 
-		if (pipe_ctx->plane_res.dpp)
+		if (pipe_ctx->plane_res.dpp && pipe_ctx->plane_res.hubp)
 			update_state->pg_pipe_res_update[PG_DPP][pipe_ctx->plane_res.hubp->inst] = false;
 
 		if (pipe_ctx->plane_res.dpp || pipe_ctx->stream_res.opp)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index c257e733044a..f3b6d8936f91 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2258,7 +2258,7 @@ bool dp_verify_link_cap_with_retries(
 
 		memset(&link->verified_link_cap, 0,
 				sizeof(struct dc_link_settings));
-		if (!link_detect_connection_type(link, &type) || type == dc_connection_none) {
+		if (link->link_enc && (!link_detect_connection_type(link, &type) || type == dc_connection_none)) {
 			link->verified_link_cap = fail_safe_link_settings;
 			break;
 		} else if (dp_verify_link_cap(link, known_limit_link_setting, &fail_count)) {
-- 
2.34.1

