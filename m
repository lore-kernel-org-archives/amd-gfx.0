Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130E9CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF0610E700;
	Wed, 22 Oct 2025 07:34:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nGnFwXFS";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EADCD10E701
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mF82Ln2KpOBAnrqSe42fGDgvPqJVpH4br1voSf1je7dKeJc29+QT+RriEj6IQB4qvtaFiXGKpcaHVPkD6GjwNs+MUTPi4Ya/PLpLkrHhl2yZl3caj/o1MrVhM872rqPxPpcrGDpz3BiddHuJscKJQ09fDAgYnvb1UbijRu5SJhc7pjRud5Z9h+YJNuQWAWef6ewu2rJj2VqBTsUraKfDY1plIUu1l6akOM8zPyC9c2etxOe8UXod88sr4/MK5F/q+T+yAifwXU0GANDhna2GlFWnwikK6RwNzQgef2XbMBCxwP08xA9PAeRSyykC7+jg92tOXPiwMP9NoH5dB8h+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZP+1nLR50sbIm7RTZ83qJ+w0yFg1n5N8gkHkYUQtBk=;
 b=IwG0OKc5NDf6hVEaMsalRC+8J0alDTQO3PHibj/1mkbi9OSaZgZ5OhZPKVsYTQVrUJ+9K1zzY9syQgWjac44Pbyc2oyPtSMvaWG7+Mtl/E/I5mm2xUTVtRwxuf/XLGl6owvUGu+sQKlLjp5UeRNA+55+KFcvrLuxD6WlhXI62OlX+DHcb8qWoYvupCyB2wMYu5hqxxO28m6VzmBUImL2zDLd9nLsLJ+Zx1vealCjP0PsueK4peQz0Z+OUrP18zGNyt7t3gFjf/dVN+4m3kBpeFZwi/PwnaYeI90EC9YMm+r4MtiI7ffC2W2ke4b7ObRpDFBHALC/31wvGdIOF9dbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZP+1nLR50sbIm7RTZ83qJ+w0yFg1n5N8gkHkYUQtBk=;
 b=nGnFwXFST/bQfYD4mNxbjfz4kgr+wyOokmt4w0vtz3Aa77XKNq7Lx/wIr73cTH7+oCmy16TkXQJSVVJvedsTbSC1nkWcGTCLEenIZAtENpzkoxo06Z7qsdcldauJJZDhkvOS715A345mnRBsu1UDIGkK42kgpSjqU97/6rtpBhw=
Received: from DS7PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:3b8::13)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 07:34:52 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::6) by DS7PR03CA0008.outlook.office365.com
 (2603:10b6:5:3b8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.14 via Frontend Transport; Wed,
 22 Oct 2025 07:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:34:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:51 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:50 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:34:47 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 11/20] drm/amd/display: Remove dc param from check_update
Date: Wed, 22 Oct 2025 15:30:23 +0800
Message-ID: <20251022073332.666119-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdcd583-17b9-42a4-7694-08de113d7d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2e25ta03557xrim8fTRnYJxRPW6E2Bb5xcDxYwwd4UUBKMzCKR0MJ3Df4BCC?=
 =?us-ascii?Q?4vi3Iid9LA4DwRuZ4/Ec/o016vN8SKkwvSCm93FR4a03AWioad23dRZL9KcV?=
 =?us-ascii?Q?fYZHhrjevSmBX4wdjpeuXH/j+G8AMNrf/63q1hkOzNCIrDfVrmxcxaj/bqNM?=
 =?us-ascii?Q?6Q6O+WouJgg1WtzHWwPp33IysBHMhDjMoe6PtKdQEn+e1E+7cwsUdra8dcAx?=
 =?us-ascii?Q?h/9GGjIZCT1SXhq1772t5Pfne9m52UZJ+Uk/FQXaoKvR+po4s6Z824TrBvDZ?=
 =?us-ascii?Q?w39hlyvJy0zDNbDiPuIIjxdVOTjEI2JoQvKzgu22ylwESdz3d5tS70tTNbeh?=
 =?us-ascii?Q?d1F4r2QVxTrYrbUDVGscI6PxZ4fHmuUMPg7gCoC9v+T3IHyu0ZBPFMuRRIyR?=
 =?us-ascii?Q?G9C4EQTe/kAlCYFyuZ9vEY3ZYskCwS4mR2LIjv62wBqL802kCNW6XV/gPbzn?=
 =?us-ascii?Q?5FmlxbCPlHJHifoP18Rz6opgeRCWVj8WfcncBlG0UYD6PTsdZmeztz+Xat+5?=
 =?us-ascii?Q?T5E/cWIgFAZc0sOHr6J+s6BVvCtmBZdVMAsxT37gZcMC0xxkZHMxATU+PzqY?=
 =?us-ascii?Q?pOVKzwoWBMAzZkKCPkLl0oMbS8xdrR5gu9NLVMGAeTimy+8EhW7bslOf3tGo?=
 =?us-ascii?Q?6vE+WoLw7SqN0kwtGV82H7I33pGR5KjWt8wxGLpwzJmlXrv5gZGyc+vi27Z9?=
 =?us-ascii?Q?/dolMNulDfOLRcDAzNwo4Ps3JTd7uVyv/Jn9BT3bUT3zNviuIdOrCIfUlA4e?=
 =?us-ascii?Q?/UvS/gfyBeuUXVV5bT6d7krTAORwI+Dmc0rG2T7XpqyyBnDTcjohMq7kD5Wo?=
 =?us-ascii?Q?XerjewGo9Sm6E3gPgKjWJlVBCDl8cKWtDhI2yRbWuZHzGqbfYOLMlnSTGB8h?=
 =?us-ascii?Q?zcdFQVdRnLMxhuDfFziXf/rc7ERTSANsK8GM3veD1ENDFpbOn3BbV+a1NlKv?=
 =?us-ascii?Q?1AC7mlzvh7j1ojfhkKWiwxtVYjWVmX1O/ofg/7DuQSePme1VsUPtq6k09AVP?=
 =?us-ascii?Q?q84MQsLzyT5DFWqqeh5pB3X2SPZlQpnHkCTegPC+cUlUywZxB9H1H+G4i3Rf?=
 =?us-ascii?Q?FQGXRTu+OVsUVm6KrDYtgOTC7QfEeTzP7AdxEe4xJMXyqzP9pauO6JsjlDpt?=
 =?us-ascii?Q?syQnpgzK1M3X/yB2GFkShyCSIucz2+L58xy6UVSYc7MmuWtTQ75aBpUxWoCB?=
 =?us-ascii?Q?QQII3KntBQz6Jcb7eQdGu8Y1crWg/1KTii0OgcNc6hx9OpEnurAkpc5Ffl7P?=
 =?us-ascii?Q?sNAgfpF5vJlOfgb1Edu1ZfetCx2zw07C8ge+8Y95j1E5oR9A8jD7fTfEiWAc?=
 =?us-ascii?Q?1fd0pIDzzKmyh05TtxhgUnwAf19YMpWGdHy7PnRj0ad8SF2+NZ8TvAftCsvl?=
 =?us-ascii?Q?OG/pBy2tICHdIwkNqUWH3nDftQXsqxyb+PFvGqlM9ahaRN0NpttbQ75y/hYI?=
 =?us-ascii?Q?s5s7OOE0yNllqbO4VqkHV+W7zsGVInz31vBGYjEGmI9GzKNZNfTn+uGllFxi?=
 =?us-ascii?Q?Plt+xr/b8oaiSLfAAbPtvZISh6sASdFTRyGWCleRUbAd2ojvQdSzvP4Dx6fG?=
 =?us-ascii?Q?j4cebKtpABAGRFs3gkmhgPNDK92HVM1rEU2f33Xj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:34:52.5293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdcd583-17b9-42a4-7694-08de113d7d4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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
dc_check_update_surfaces_for_stream should not have access to entire
DC, especially not a mutable one. Concurrent checks should be able
to run independently of one another, without risk of changing state.

[How]
* Replace dc and stream_status structs with new dc_check_config.
* Move required fields from dc_debug and dc_caps to dc_check_config.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 51 +++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h           | 17 ++++---
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  5 +-
 .../dc/resource/dce100/dce100_resource.c      |  7 ++-
 .../dc/resource/dce110/dce110_resource.c      |  5 +-
 .../dc/resource/dce112/dce112_resource.c      |  7 ++-
 .../dc/resource/dce120/dce120_resource.c      |  8 ++-
 .../dc/resource/dce80/dce80_resource.c        |  8 ++-
 .../dc/resource/dcn10/dcn10_resource.c        |  7 ++-
 .../dc/resource/dcn20/dcn20_resource.c        |  6 ++-
 .../dc/resource/dcn201/dcn201_resource.c      |  6 ++-
 .../dc/resource/dcn21/dcn21_resource.c        |  6 ++-
 .../dc/resource/dcn30/dcn30_resource.c        |  6 ++-
 .../dc/resource/dcn301/dcn301_resource.c      |  6 ++-
 .../dc/resource/dcn302/dcn302_resource.c      |  6 ++-
 .../dc/resource/dcn303/dcn303_resource.c      |  6 ++-
 .../dc/resource/dcn31/dcn31_resource.c        |  6 ++-
 .../dc/resource/dcn314/dcn314_resource.c      |  6 ++-
 .../dc/resource/dcn315/dcn315_resource.c      |  6 ++-
 .../dc/resource/dcn316/dcn316_resource.c      |  6 ++-
 .../dc/resource/dcn32/dcn32_resource.c        |  6 ++-
 .../dc/resource/dcn321/dcn321_resource.c      |  6 ++-
 .../dc/resource/dcn35/dcn35_resource.c        |  6 ++-
 .../dc/resource/dcn351/dcn351_resource.c      |  6 ++-
 .../dc/resource/dcn36/dcn36_resource.c        |  6 ++-
 .../dc/resource/dcn401/dcn401_resource.c      |  6 ++-
 26 files changed, 152 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 246ea9754810..2eb02345dadd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1148,8 +1148,8 @@ static bool dc_construct(struct dc *dc,
 	/* set i2c speed if not done by the respective dcnxxx__resource.c */
 	if (dc->caps.i2c_speed_in_khz_hdcp == 0)
 		dc->caps.i2c_speed_in_khz_hdcp = dc->caps.i2c_speed_in_khz;
-	if (dc->caps.max_optimizable_video_width == 0)
-		dc->caps.max_optimizable_video_width = 5120;
+	if (dc->check_config.max_optimizable_video_width == 0)
+		dc->check_config.max_optimizable_video_width = 5120;
 	dc->clk_mgr = dc_clk_mgr_create(dc->ctx, dc->res_pool->pp_smu, dc->res_pool->dccg);
 	if (!dc->clk_mgr)
 		goto fail;
@@ -2656,7 +2656,7 @@ static bool is_surface_in_context(
 	return false;
 }
 
-static enum surface_update_type get_plane_info_update_type(const struct dc *dc, const struct dc_surface_update *u)
+static enum surface_update_type get_plane_info_update_type(const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
 	enum surface_update_type update_type = UPDATE_TYPE_FAST;
@@ -2760,7 +2760,7 @@ static enum surface_update_type get_plane_info_update_type(const struct dc *dc,
 }
 
 static enum surface_update_type get_scaling_info_update_type(
-		const struct dc *dc,
+		const struct dc_check_config *check_config,
 		const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
@@ -2790,7 +2790,7 @@ static enum surface_update_type get_scaling_info_update_type(
 			/* Making dst rect smaller requires a bandwidth change */
 			update_flags->bits.bandwidth_change = 1;
 
-		if (u->scaling_info->src_rect.width > dc->caps.max_optimizable_video_width &&
+		if (u->scaling_info->src_rect.width > check_config->max_optimizable_video_width &&
 			(u->scaling_info->clip_rect.width > u->surface->clip_rect.width ||
 			 u->scaling_info->clip_rect.height > u->surface->clip_rect.height))
 			 /* Changing clip size of a large surface may result in MPC slice count change */
@@ -2817,7 +2817,8 @@ static enum surface_update_type get_scaling_info_update_type(
 	return UPDATE_TYPE_FAST;
 }
 
-static enum surface_update_type det_surface_update(const struct dc *dc,
+static enum surface_update_type det_surface_update(
+		const struct dc_check_config *check_config,
 		const struct dc_surface_update *u)
 {
 	enum surface_update_type type;
@@ -2831,10 +2832,10 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 
 	update_flags->raw = 0; // Reset all flags
 
-	type = get_plane_info_update_type(dc, u);
+	type = get_plane_info_update_type(u);
 	elevate_update_type(&overall_type, type);
 
-	type = get_scaling_info_update_type(dc, u);
+	type = get_scaling_info_update_type(check_config, u);
 	elevate_update_type(&overall_type, type);
 
 	if (u->flip_addr) {
@@ -2911,7 +2912,7 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 		elevate_update_type(&overall_type, type);
 	}
 
-	if (dc->debug.enable_legacy_fast_update &&
+	if (check_config->enable_legacy_fast_update &&
 			(update_flags->bits.gamma_change ||
 			update_flags->bits.gamut_remap_change ||
 			update_flags->bits.input_csc_change ||
@@ -2946,11 +2947,11 @@ static void force_immediate_gsl_plane_flip(struct dc *dc, struct dc_surface_upda
 }
 
 static enum surface_update_type check_update_surfaces_for_stream(
-		struct dc *dc,
+		const struct dc_check_config *check_config,
 		struct dc_surface_update *updates,
 		int surface_count,
-		struct dc_stream_update *stream_update,
-		const struct dc_stream_status *stream_status)
+		struct dc_stream_update *stream_update
+)
 {
 	int i;
 	enum surface_update_type overall_type = UPDATE_TYPE_FAST;
@@ -2972,7 +2973,7 @@ static enum surface_update_type check_update_surfaces_for_stream(
 			stream_update->integer_scaling_update)
 			su_flags->bits.scaling = 1;
 
-		if (dc->debug.enable_legacy_fast_update && stream_update->out_transfer_func)
+		if (check_config->enable_legacy_fast_update && stream_update->out_transfer_func)
 			su_flags->bits.out_tf = 1;
 
 		if (stream_update->abm_level)
@@ -3016,13 +3017,13 @@ static enum surface_update_type check_update_surfaces_for_stream(
 		/* Output transfer function changes do not require bandwidth recalculation,
 		 * so don't trigger a full update
 		 */
-		if (!dc->debug.enable_legacy_fast_update && stream_update->out_transfer_func)
+		if (!check_config->enable_legacy_fast_update && stream_update->out_transfer_func)
 			su_flags->bits.out_tf = 1;
 	}
 
 	for (i = 0 ; i < surface_count; i++) {
 		enum surface_update_type type =
-				det_surface_update(dc, &updates[i]);
+				det_surface_update(check_config, &updates[i]);
 
 		elevate_update_type(&overall_type, type);
 	}
@@ -3036,22 +3037,17 @@ static enum surface_update_type check_update_surfaces_for_stream(
  * See :c:type:`enum surface_update_type <surface_update_type>` for explanation of update types
  */
 enum surface_update_type dc_check_update_surfaces_for_stream(
-		struct dc *dc,
+		const struct dc_check_config *check_config,
 		struct dc_surface_update *updates,
 		int surface_count,
-		struct dc_stream_update *stream_update,
-		const struct dc_stream_status *stream_status)
+		struct dc_stream_update *stream_update)
 {
-	int i;
-	enum surface_update_type type;
-
 	if (stream_update)
 		stream_update->stream->update_flags.raw = 0;
-	for (i = 0; i < surface_count; i++)
+	for (size_t i = 0; i < surface_count; i++)
 		updates[i].surface->update_flags.raw = 0;
 
-	type = check_update_surfaces_for_stream(dc, updates, surface_count, stream_update, stream_status);
-	return type;
+	return check_update_surfaces_for_stream(check_config, updates, surface_count, stream_update);
 }
 
 static struct dc_stream_status *stream_get_status(
@@ -3472,8 +3468,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 	context = dc->current_state;
 	update_type = dc_check_update_surfaces_for_stream(
-			dc, srf_updates, surface_count, stream_update, stream_status);
-
+			&dc->check_config, srf_updates, surface_count, stream_update);
 	if (full_update_required_weak(dc, srf_updates, surface_count, stream_update, stream))
 		update_type = UPDATE_TYPE_FULL;
 
@@ -5208,7 +5203,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 		commit_minimal_transition_state_in_dc_update(dc, context, stream,
 				srf_updates, surface_count);
 
-	if (is_fast_update_only && !dc->debug.enable_legacy_fast_update) {
+	if (is_fast_update_only && !dc->check_config.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
 				surface_count,
@@ -5251,7 +5246,7 @@ static void commit_planes_and_stream_update_on_current_context(struct dc *dc,
 			stream_update);
 	if (fast_update_only(dc, fast_update, srf_updates, surface_count,
 			stream_update, stream) &&
-			!dc->debug.enable_legacy_fast_update)
+			!dc->check_config.enable_legacy_fast_update)
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
 				surface_count,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ea629c06ec53..b80bcbf7ae13 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -286,6 +286,15 @@ struct dc_scl_caps {
 	bool sharpener_support;
 };
 
+struct dc_check_config {
+	/**
+	 * max video plane width that can be safely assumed to be always
+	 * supported by single DPP pipe.
+	 */
+	unsigned int max_optimizable_video_width;
+	bool enable_legacy_fast_update;
+};
+
 struct dc_caps {
 	uint32_t max_streams;
 	uint32_t max_links;
@@ -301,11 +310,6 @@ struct dc_caps {
 	unsigned int max_cursor_size;
 	unsigned int max_buffered_cursor_size;
 	unsigned int max_video_width;
-	/*
-	 * max video plane width that can be safely assumed to be always
-	 * supported by single DPP pipe.
-	 */
-	unsigned int max_optimizable_video_width;
 	unsigned int min_horizontal_blanking_period;
 	int linear_pitch_alignment;
 	bool dcc_const_color;
@@ -1128,7 +1132,6 @@ struct dc_debug_options {
 	uint32_t fpo_vactive_min_active_margin_us;
 	uint32_t fpo_vactive_max_blank_us;
 	bool enable_hpo_pg_support;
-	bool enable_legacy_fast_update;
 	bool disable_dc_mode_overwrite;
 	bool replay_skip_crtc_disabled;
 	bool ignore_pg;/*do nothing, let pmfw control it*/
@@ -1160,7 +1163,6 @@ struct dc_debug_options {
 	bool enable_ips_visual_confirm;
 	unsigned int sharpen_policy;
 	unsigned int scale_to_sharpness_policy;
-	bool skip_full_updated_if_possible;
 	unsigned int enable_oled_edp_power_up_opt;
 	bool enable_hblank_borrow;
 	bool force_subvp_df_throttle;
@@ -1711,6 +1713,7 @@ struct dc {
 	struct dc_debug_options debug;
 	struct dc_versions versions;
 	struct dc_caps caps;
+	struct dc_check_config check_config;
 	struct dc_cap_funcs cap_funcs;
 	struct dc_config config;
 	struct dc_bounding_box_overrides bb_overrides;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 76cf9fdedab0..c68153c77972 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -474,11 +474,10 @@ void dc_enable_stereo(
 void dc_trigger_sync(struct dc *dc, struct dc_state *context);
 
 enum surface_update_type dc_check_update_surfaces_for_stream(
-		struct dc *dc,
+		const struct dc_check_config *check_config,
 		struct dc_surface_update *updates,
 		int surface_count,
-		struct dc_stream_update *stream_update,
-		const struct dc_stream_status *stream_status);
+		struct dc_stream_update *stream_update);
 
 /**
  * Create a new default stream for the requested sink
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index c4b4dc3ad8c9..550466de1a66 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -402,8 +402,10 @@ static const struct dc_plane_cap plane_cap = {
 	}
 };
 
-static const struct dc_debug_options debug_defaults = {
-		.enable_legacy_fast_update = true,
+static const struct dc_debug_options debug_defaults = { 0 };
+
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
 };
 
 #define CTX  ctx
@@ -1093,6 +1095,7 @@ static bool dce100_resource_construct(
 	dc->caps.disable_dp_clk_share = true;
 	dc->caps.extended_aux_timeout_support = false;
 	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		pool->base.timing_generators[i] =
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index cccde5a6f3cd..9e14ffb3c942 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -424,7 +424,9 @@ static const struct dc_plane_cap plane_cap = {
 		64
 };
 
-static const struct dc_debug_options debug_defaults = {
+static const struct dc_debug_options debug_defaults = { 0 };
+
+static const struct dc_check_config config_defaults = {
 		.enable_legacy_fast_update = true,
 };
 
@@ -1376,6 +1378,7 @@ static bool dce110_resource_construct(
 	dc->caps.is_apu = true;
 	dc->caps.extended_aux_timeout_support = false;
 	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 869a8e515fc0..62977bcdeaa0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -429,8 +429,10 @@ static const struct dc_plane_cap plane_cap = {
 	64
 };
 
-static const struct dc_debug_options debug_defaults = {
-		.enable_legacy_fast_update = true,
+static const struct dc_debug_options debug_defaults = { 0 };
+
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
 };
 
 #define CTX  ctx
@@ -1247,6 +1249,7 @@ static bool dce112_resource_construct(
 	dc->caps.dual_link_dvi = true;
 	dc->caps.extended_aux_timeout_support = false;
 	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index 540e04ec1e2d..0770ea37183f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -526,8 +526,11 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults = {
-		.disable_clock_gate = true,
-		.enable_legacy_fast_update = true,
+	.disable_clock_gate = true,
+};
+
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
 };
 
 static struct clock_source *dce120_clock_source_create(
@@ -1089,6 +1092,7 @@ static bool dce120_resource_construct(
 	dc->caps.psp_setup_panel_mode = true;
 	dc->caps.extended_aux_timeout_support = false;
 	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 5b7769745202..c4a56ec60b82 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -418,8 +418,10 @@ static const struct dc_plane_cap plane_cap = {
 	}
 };
 
-static const struct dc_debug_options debug_defaults = {
-		.enable_legacy_fast_update = true,
+static const struct dc_debug_options debug_defaults = { 0 };
+
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
 };
 
 static const struct dce_dmcu_registers dmcu_regs = {
@@ -919,6 +921,7 @@ static bool dce80_construct(
 	dc->caps.dual_link_dvi = true;
 	dc->caps.extended_aux_timeout_support = false;
 	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
@@ -1320,6 +1323,7 @@ static bool dce83_construct(
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.is_apu = true;
 	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index 652c05c35494..f12367adf145 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -556,10 +556,13 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.recovery_enabled = false, /*enable this by default after testing.*/
 		.max_downscale_src_width = 3840,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
-		.enable_legacy_fast_update = true,
 		.using_dml2 = false,
 };
 
+static const struct dc_check_config config_defaults = {
+		.enable_legacy_fast_update = true,
+};
+
 static void dcn10_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN10_DPP(*dpp));
@@ -1395,6 +1398,8 @@ static bool dcn10_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 0;
+	dc->debug = debug_defaults_drv;
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 30f155dc54e5..6679c1a14f2f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -718,10 +718,13 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.scl_reset_length10 = true,
 		.sanity_checks = false,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
-		.enable_legacy_fast_update = true,
 		.using_dml2 = false,
 };
 
+static const struct dc_check_config config_defaults = {
+		.enable_legacy_fast_update = true,
+};
+
 void dcn20_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
@@ -2471,6 +2474,7 @@ static bool dcn20_resource_construct(
 	dc->caps.color.mpc.ocsc = 1;
 
 	dc->caps.dp_hdmi21_pcon_support = true;
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 9a80bebcee48..055107843a70 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -614,10 +614,13 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.sanity_checks = false,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 		.enable_tri_buf = true,
-		.enable_legacy_fast_update = true,
 		.using_dml2 = false,
 };
 
+static const struct dc_check_config config_defaults = {
+		.enable_legacy_fast_update = true,
+};
+
 static void dcn201_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN201_DPP(*dpp));
@@ -1151,6 +1154,7 @@ static bool dcn201_resource_construct(
 	dc->caps.color.mpc.ocsc = 1;
 
 	dc->debug = debug_defaults_drv;
+	dc->check_config = config_defaults;
 
 	/*a0 only, remove later*/
 	dc->work_arounds.no_connect_phy_config  = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 918742a42ded..2060acd5ae09 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -626,10 +626,13 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.usbc_combo_phy_reset_wa = true,
 		.dmub_command_table = true,
 		.use_max_lb = true,
-		.enable_legacy_fast_update = true,
 		.using_dml2 = false,
 };
 
+static const struct dc_check_config config_defaults = {
+		.enable_legacy_fast_update = true,
+};
+
 static const struct dc_panel_config panel_config_defaults = {
 		.psr = {
 			.disable_psr = false,
@@ -1458,6 +1461,7 @@ static bool dcn21_resource_construct(
 	dc->caps.color.mpc.ocsc = 1;
 
 	dc->caps.dp_hdmi21_pcon_support = true;
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index ff63f59ff928..d0ebb733e802 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -727,10 +727,13 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.dmub_command_table = true,
 	.use_max_lb = true,
 	.exit_idle_opt_for_cursor_updates = true,
-	.enable_legacy_fast_update = false,
 	.using_dml2 = false,
 };
 
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = false,
+};
+
 static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
@@ -2374,6 +2377,7 @@ static bool dcn30_resource_construct(
 			dc->caps.vbios_lttpr_aware = (bp_query_result == BP_RESULT_OK) && !!is_vbios_interop_enabled;
 		}
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 82a205a7c25c..3ad6a3d4858e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -701,10 +701,13 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.dmub_command_table = true,
 	.use_max_lb = false,
 	.exit_idle_opt_for_cursor_updates = true,
-	.enable_legacy_fast_update = true,
 	.using_dml2 = false,
 };
 
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
+};
+
 static void dcn301_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
@@ -1498,6 +1501,7 @@ static bool dcn301_resource_construct(
 		bp_query_result = ctx->dc_bios->funcs->get_lttpr_interop(ctx->dc_bios, &is_vbios_interop_enabled);
 		dc->caps.vbios_lttpr_aware = (bp_query_result == BP_RESULT_OK) && !!is_vbios_interop_enabled;
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 61623cb518d9..c0d4a1dc94f8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -98,10 +98,13 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.dmub_command_table = true,
 		.use_max_lb = true,
 		.exit_idle_opt_for_cursor_updates = true,
-		.enable_legacy_fast_update = false,
 		.using_dml2 = false,
 };
 
+static const struct dc_check_config config_defaults = {
+		.enable_legacy_fast_update = false,
+};
+
 static const struct dc_panel_config panel_config_defaults = {
 		.psr = {
 			.disable_psr = false,
@@ -1290,6 +1293,7 @@ static bool dcn302_resource_construct(
 				&is_vbios_interop_enabled);
 		dc->caps.vbios_lttpr_aware = (bp_query_result == BP_RESULT_OK) && !!is_vbios_interop_enabled;
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 02b9a84f2db3..75e09c2c283e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -98,10 +98,13 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.dmub_command_table = true,
 		.use_max_lb = true,
 		.exit_idle_opt_for_cursor_updates = true,
-		.enable_legacy_fast_update = false,
 		.using_dml2 = false,
 };
 
+static const struct dc_check_config config_defaults = {
+		.enable_legacy_fast_update = false,
+};
+
 static const struct dc_panel_config panel_config_defaults = {
 		.psr = {
 			.disable_psr = false,
@@ -1234,6 +1237,7 @@ static bool dcn303_resource_construct(
 		bp_query_result = ctx->dc_bios->funcs->get_lttpr_interop(ctx->dc_bios, &is_vbios_interop_enabled);
 		dc->caps.vbios_lttpr_aware = (bp_query_result == BP_RESULT_OK) && !!is_vbios_interop_enabled;
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 3ed7f50554e2..0d667b54ccf8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -888,12 +888,15 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.disable_z10 = true,
-	.enable_legacy_fast_update = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
 	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
 	.using_dml2 = false,
 };
 
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
+};
+
 static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
@@ -1978,6 +1981,7 @@ static bool dcn31_resource_construct(
 			dc->caps.vbios_lttpr_aware = true;
 		}
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index d4917a35b991..3ccde75a4ecb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -924,12 +924,15 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 
 	.seamless_boot_odm_combine = true,
-	.enable_legacy_fast_update = true,
 	.using_dml2 = false,
 	.disable_dsc_power_gate = true,
 	.min_disp_clk_khz = 100000,
 };
 
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
+};
+
 static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
@@ -1910,6 +1913,7 @@ static bool dcn314_resource_construct(
 			dc->caps.vbios_lttpr_aware = true;
 		}
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 82cc78c291d8..38f6328cda92 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -887,11 +887,14 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.afmt = true,
 		}
 	},
-	.enable_legacy_fast_update = true,
 	.psr_power_use_phy_fsm = 0,
 	.using_dml2 = false,
 };
 
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
+};
+
 static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
@@ -1939,6 +1942,7 @@ static bool dcn315_resource_construct(
 			dc->caps.vbios_lttpr_aware = true;
 		}
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 636110e48d01..5a95dd54cb42 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -882,10 +882,13 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.afmt = true,
 		}
 	},
-	.enable_legacy_fast_update = true,
 	.using_dml2 = false,
 };
 
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
+};
+
 static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
@@ -1815,6 +1818,7 @@ static bool dcn316_resource_construct(
 			dc->caps.vbios_lttpr_aware = true;
 		}
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 4c2e8aa96d1f..81e64e17d0cb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -738,10 +738,13 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dp_plus_plus_wa = true,
 	.fpo_vactive_min_active_margin_us = 200,
 	.fpo_vactive_max_blank_us = 1000,
-	.enable_legacy_fast_update = false,
 	.disable_stutter_for_wm_program = true
 };
 
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = false,
+};
+
 static struct dce_aux *dcn32_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
@@ -2294,6 +2297,7 @@ static bool dcn32_resource_construct(
 			dc->caps.vbios_lttpr_aware = true;
 		}
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index ad214986f7ac..3466ca34c93f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -731,11 +731,14 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_subvp_high_refresh = false,
 	.fpo_vactive_min_active_margin_us = 200,
 	.fpo_vactive_max_blank_us = 1000,
-	.enable_legacy_fast_update = false,
 	.disable_dc_mode_overwrite = true,
 	.using_dml2 = false,
 };
 
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = false,
+};
+
 static struct dce_aux *dcn321_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
@@ -1797,6 +1800,7 @@ static bool dcn321_resource_construct(
 			dc->caps.vbios_lttpr_aware = true;
 		}
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 3a83a63d2116..ef69898d2cc5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -767,7 +767,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.using_dml2 = true,
 	.support_eDP1_5 = true,
 	.enable_hpo_pg_support = false,
-	.enable_legacy_fast_update = true,
 	.enable_single_display_2to1_odm_policy = true,
 	.disable_idle_power_optimizations = false,
 	.dmcub_emulation = false,
@@ -788,6 +787,10 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_disp_clk_khz = 50000,
 };
 
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
+};
+
 static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
@@ -1946,6 +1949,7 @@ static bool dcn35_resource_construct(
 			dc->caps.vbios_lttpr_aware = true;
 		}
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index d00cc4030be3..f3c614c4490c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -747,7 +747,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.using_dml2 = true,
 	.support_eDP1_5 = true,
 	.enable_hpo_pg_support = false,
-	.enable_legacy_fast_update = true,
 	.enable_single_display_2to1_odm_policy = true,
 	.disable_idle_power_optimizations = false,
 	.dmcub_emulation = false,
@@ -768,6 +767,10 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_disp_clk_khz = 50000,
 };
 
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
+};
+
 static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
@@ -1917,6 +1920,7 @@ static bool dcn351_resource_construct(
 			dc->caps.vbios_lttpr_aware = true;
 		}
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index f4b28617b2de..6469d5fe2e6d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -748,7 +748,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.using_dml2 = true,
 	.support_eDP1_5 = true,
 	.enable_hpo_pg_support = false,
-	.enable_legacy_fast_update = true,
 	.enable_single_display_2to1_odm_policy = true,
 	.disable_idle_power_optimizations = false,
 	.dmcub_emulation = false,
@@ -769,6 +768,10 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_disp_clk_khz = 50000,
 };
 
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
+};
+
 static const struct dc_panel_config panel_config_defaults = {
 	.psr = {
 		.disable_psr = false,
@@ -1918,6 +1921,7 @@ static bool dcn36_resource_construct(
 			dc->caps.vbios_lttpr_aware = true;
 		}
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 8e2d3781752c..130058d7a70c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -721,7 +721,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.alloc_extra_way_for_cursor = true,
 	.min_prefetch_in_strobe_ns = 60000, // 60us
 	.disable_unbounded_requesting = false,
-	.enable_legacy_fast_update = false,
 	.dcc_meta_propagation_delay_us = 10,
 	.fams_version = {
 		.minor = 1,
@@ -737,6 +736,10 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.force_cositing = CHROMA_COSITING_NONE + 1,
 };
 
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = false,
+};
+
 static struct dce_aux *dcn401_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
@@ -1995,6 +1998,7 @@ static bool dcn401_resource_construct(
 			dc->caps.vbios_lttpr_aware = true;
 		}
 	}
+	dc->check_config = config_defaults;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-- 
2.43.0

