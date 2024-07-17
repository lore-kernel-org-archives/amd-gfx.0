Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86A7C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6118810E141;
	Wed, 17 Jul 2024 19:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yTWEbdDb";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D98E10E3C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qv1xhrgcYEGiQX7+kfV2IXPylqJaObFLSAf7asbPJYIEiRHbZh7E0CV4/eZyFNGwj3ClOe3G4JUgFUA0Y+SjJym8ukA5UdkE8sQTZL0CmmYZeNsNKXrcsASscZJ+60BLEAJH3ET97jJMnrivfWhaT7UolNJlFiS/XQMhaovhSECLNUdVMeZvq73UmXPzxPiT7KUMzx5QTICyAF63n+MpQt6QWJ7hVa2wz4dRhQ4MeSZavuYvIxohTtRwmHHQ5mkatYP+aE36HiGIUAIRFTJfuSLDoFWXJIGsZTVw3Q6YS0VSacRt6wNGyxfL+MUFQKi2gRC7d9XJ4M8lhFV64zO1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZJqEWoL2WFph3+YBmgB9mMGIk24+08MQgP9tEQNWls=;
 b=vcsrhzOB3c5uXia9bye/QMnKykEusD35NPQMHVkjx6CTsiDB7frvkYRwfAkuyAS6Hdtsci7M3KeUOU8ZKZysmUm9/19JhmEzUH1oMM5kmOR3aPS4US0O4AH+YpvRZUDNYyIoMSMQ5I7V6eJon9RXfS+Lo3u1eQUB7oc/truto2NXVNM97AJwd1DDwNBeeAksbwDy3hUN3gtTZzm1xYe0ZXyrzw2vds26GKIwdyhoQjEPHikxKncLnNaIgxOJR2Dryi7tkoTqBazh6Z++D7PmAbAot3qUIF7hFxoGiDDJ2Y8q/xDdFab5m42wdlt6UFUI75GLScwBOREaLXd1sOMJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZJqEWoL2WFph3+YBmgB9mMGIk24+08MQgP9tEQNWls=;
 b=yTWEbdDbEpWYFsJKulxxv9C4oCJeTbOObIBcUk+A2BJFolgn3Zs4PusOL8p4LN1cyR8rajijgdBEx2wHCQsR96t9QCK9zD41dZQE5f2+slBfA4vqM9B4I4tqKXTEvCuHgOZXVYlyinlWLq5usk6jRLiRuUhoUaHJ7AjnRUAQ/NA=
Received: from CH2PR17CA0025.namprd17.prod.outlook.com (2603:10b6:610:53::35)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 19:41:24 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::fd) by CH2PR17CA0025.outlook.office365.com
 (2603:10b6:610:53::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 19:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:41:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:23 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:41:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 20/22] drm/amd/display: Remove duplicate HWSS interfaces
Date: Wed, 17 Jul 2024 19:38:59 +0000
Message-ID: <20240717193901.8821-21-aurabindo.pillai@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5e82ff-fda2-4346-0ff2-08dca6987138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DRWtnYjVtnNiQEnxvG8g3bjeP5YxQyuS8rb6BoKOh4SlQdJwhqWPvM1UPG/H?=
 =?us-ascii?Q?8jzzT5ie5D7RNjGe4mV5a/yRZuZ3pNGJIkIQCNYd1nSVME7oOHeBpCQNmSz6?=
 =?us-ascii?Q?5bpkii4Lr+dvq2wrmiHixXvLz2CJZ1qWZv6JvsJ8mV1xgdSIVQHM7l+E2eWF?=
 =?us-ascii?Q?slPlefkypVfcRjLNIwG+NDYzn4BlVDa+OtxRLJf7jL6eRgzvmhTPDcP4yypi?=
 =?us-ascii?Q?DqYj8tCKdYrlGTEExw7gaQa33B1NsMl6X7kcVWKXZctBRzebUDzycbonRwMq?=
 =?us-ascii?Q?cKKu4+uuNzTiKLOp61UXH0bMxfpq40KCiTa9q3+sHN2/zbOJG2ivfKlgr8PD?=
 =?us-ascii?Q?319f+9fwzu52utXrImQm3wbbXSvJPNZ2guKoqxBPUzO1C+Jni0i5pVZqAUYb?=
 =?us-ascii?Q?C9qlSwz+JkvltQ5mx9EzId6elAE0pYrJq08j9YsPywBoph/le3l5QbheMSZb?=
 =?us-ascii?Q?1eYn3wkQuZSlbujgLn73DAiJTC/VE8iwyvNp6/ui67FycmAdgJDczvZ20OwZ?=
 =?us-ascii?Q?36SZzswm0a37ToUrK1eJ/Ykb7sf9anDfNemIVDgw7YxQjNf1zbao6WSY2r6/?=
 =?us-ascii?Q?YWDH77q/eo7aq8Az50zERSXVRFdYb/CFIb1n1LnEAK9GL9CWeG5NiJesVObV?=
 =?us-ascii?Q?nPbBl09JyvXawghuSdIKrd923Ikfm4n6HqI3nIyuco6zQn67JJpUb5cqhN9/?=
 =?us-ascii?Q?Zk/xWytgIv8sohKPMxjkZMbRPPI0sfnxfujhPidymicMKc3LxvAGW4RVCUaS?=
 =?us-ascii?Q?XsI8wIHTuUdUZVj9tD5xf1wKhDfN1ovuid+uG86K4bZWUO7gR3uemDZvFOtp?=
 =?us-ascii?Q?QE3wq1Y2IvE1j9tAs3u70NkcaGBlOrv8kNuk+dwFRNgZK27U4yXHn54b50v4?=
 =?us-ascii?Q?73yZ3kZ1KnXsrBAxT1MaRcP3Sp1QX2lxFLIW1fmq7S4/hyjIklM0pFTnoUkH?=
 =?us-ascii?Q?T1o/lAKfHVDRCKP+gyGt291QQkCDNYbRiDhqmZJhWHyyEvoQ+dGK29a40OsF?=
 =?us-ascii?Q?Q2PVGHyIbrgGJkd+5KIhLHZ/ucnXOCoPS/0Cpj7k0zupZ7twM6/5Spodiroc?=
 =?us-ascii?Q?2SzX+XZAJjeD+L8oa/hMRmjmVnXP3mWacCW0is2wNMotk9svkaydWcxWsWeW?=
 =?us-ascii?Q?0iKvd+79X4YHxYVC7d8b69rK1tI79j2wPDzRtLkBgO6ptkhkoAVvKxa43LZc?=
 =?us-ascii?Q?dPWth7NHuYmFzFJC7EAD4Z3RcdGj+KQnlkhSYAkPckEup1dTfT8BAenOtUn6?=
 =?us-ascii?Q?vOZjMR7TtnMuux1B4ECb7wzPLXcfKtVhL3Muty95tRDvgyohRh+WV3oTT24G?=
 =?us-ascii?Q?XIvIRUVZQAEAISWyLAZeDpj5FJwXHSTnd0D+aAiUBvuxjs5nDJPjyOEBVGbr?=
 =?us-ascii?Q?mO8jQuIUOsuaACGdiHDAl93xrM14XQKQ6ADn9rEwHcj6H3wtVwP5c28ISVge?=
 =?us-ascii?Q?NJm2NkfV7qEkBsGZd5ss5j19Nm80JO/q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:41:24.3568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5e82ff-fda2-4346-0ff2-08dca6987138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Some interface functions are defined in both the public and private HWSS
interfaces, which can lead to confusion and runtime issues, therefore
the duplicates should be eliminated.

[How]
- power_down should only be private, because it's only used within HWSS.
- update_plane_addr should only be public, as it's used outside HWSS.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |  1 -
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    | 10 +++++-----
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c |  2 --
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c |  1 -
 .../gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c   |  1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c |  2 --
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |  8 ++++----
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c |  1 -
 .../gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c   |  1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c |  2 --
 .../gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c   |  2 --
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |  8 ++++----
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c |  1 -
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  8 ++++----
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |  2 --
 .../gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c   |  2 --
 .../gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |  8 ++++----
 .../gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |  2 --
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h     |  1 -
 .../gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h |  2 --
 21 files changed, 22 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 4593fb2a0536..e2f5c4d34a55 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3319,7 +3319,6 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
 	.init_pipes = init_pipes,
-	.update_plane_addr = update_plane_addr,
 	.set_input_transfer_func = dce110_set_input_transfer_func,
 	.set_output_transfer_func = dce110_set_output_transfer_func,
 	.power_down = dce110_power_down,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 212576dbc336..e31249d1dd22 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1696,10 +1696,10 @@ void dcn10_power_down_on_boot(struct dc *dc)
 	if (edp_link && edp_link->link_enc->funcs->is_dig_enabled &&
 			edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
 			dc->hwseq->funcs.edp_backlight_control &&
-			dc->hwss.power_down &&
+			dc->hwseq->funcs.power_down &&
 			dc->hwss.edp_power_control) {
 		dc->hwseq->funcs.edp_backlight_control(edp_link, false);
-		dc->hwss.power_down(dc);
+		dc->hwseq->funcs.power_down(dc);
 		dc->hwss.edp_power_control(edp_link, false);
 	} else {
 		for (i = 0; i < dc->link_count; i++) {
@@ -1707,8 +1707,8 @@ void dcn10_power_down_on_boot(struct dc *dc)
 
 			if (link->link_enc && link->link_enc->funcs->is_dig_enabled &&
 					link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-					dc->hwss.power_down) {
-				dc->hwss.power_down(dc);
+					dc->hwseq->funcs.power_down) {
+				dc->hwseq->funcs.power_down(dc);
 				break;
 			}
 
@@ -2913,7 +2913,7 @@ static void dcn10_update_dchubp_dpp(
 
 	hubp->power_gated = false;
 
-	hws->funcs.update_plane_addr(dc, pipe_ctx);
+	dc->hwss.update_plane_addr(dc, pipe_ctx);
 
 	if (is_pipe_tree_visible(pipe_ctx))
 		hubp->funcs->set_blank(hubp, false);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
index a5bdac79a744..5e51e1761707 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
@@ -78,7 +78,6 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.get_clock = dcn10_get_clock,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.power_down = dce110_power_down,
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
@@ -92,7 +91,6 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn10_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.program_pipe = dcn10_program_pipe,
 	.update_mpcc = dcn10_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index bd7b186fb2e4..270e337ae27b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1825,7 +1825,7 @@ static void dcn20_update_dchubp_dpp(
 			params.subvp_save_surf_addr.subvp_index = pipe_ctx->subvp_index;
 			hwss_subvp_save_surf_addr(&params);
 		}
-		hws->funcs.update_plane_addr(dc, pipe_ctx);
+		dc->hwss.update_plane_addr(dc, pipe_ctx);
 	}
 
 	if (pipe_ctx->update_flags.bits.enable)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
index ef6488165b8f..32707b344f0b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
@@ -105,7 +105,6 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn20_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
index a13bf6c9386e..78351408e864 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
@@ -96,7 +96,6 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 
 static const struct hwseq_private_funcs dcn201_private_funcs = {
 	.init_pipes = NULL,
-	.update_plane_addr = dcn201_update_plane_addr,
 	.plane_atomic_disconnect = dcn201_plane_atomic_disconnect,
 	.program_pipe = dcn10_program_pipe,
 	.update_mpcc = dcn201_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
index 3dfac372d165..e044e9e0a3a1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
@@ -93,7 +93,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.power_down = dce110_power_down,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
@@ -109,7 +108,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn20_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index eaeeade31ed7..fc5936460ac2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -731,10 +731,10 @@ void dcn30_init_hw(struct dc *dc)
 		if (edp_link && edp_link->link_enc->funcs->is_dig_enabled &&
 				edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
 				dc->hwss.edp_backlight_control &&
-				dc->hwss.power_down &&
+				hws->funcs.power_down &&
 				dc->hwss.edp_power_control) {
 			dc->hwss.edp_backlight_control(edp_link, false);
-			dc->hwss.power_down(dc);
+			hws->funcs.power_down(dc);
 			dc->hwss.edp_power_control(edp_link, false);
 		} else {
 			for (i = 0; i < dc->link_count; i++) {
@@ -742,8 +742,8 @@ void dcn30_init_hw(struct dc *dc)
 
 				if (link->link_enc->funcs->is_dig_enabled &&
 						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-						dc->hwss.power_down) {
-					dc->hwss.power_down(dc);
+						hws->funcs.power_down) {
+					hws->funcs.power_down(dc);
 					break;
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index 4b32497c09d0..2a8dc40d2847 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -113,7 +113,6 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn30_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index 97e33eb7ac5a..93e49d87a67c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -111,7 +111,6 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn30_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 9cb7afe0e731..b57dd45611f2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.power_down = dce110_power_down,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
@@ -116,7 +115,6 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 
 static const struct hwseq_private_funcs dcn31_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn30_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 7a8db4b81471..fe5495a8e7a2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -100,7 +100,6 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.power_down = dce110_power_down,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
@@ -119,7 +118,6 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 
 static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn30_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 7f41eccefe02..a7cb003f1dfb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -901,10 +901,10 @@ void dcn32_init_hw(struct dc *dc)
 				if (edp_link->link_enc->funcs->is_dig_enabled &&
 						edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
 						dc->hwss.edp_backlight_control &&
-						dc->hwss.power_down &&
+						hws->funcs.power_down &&
 						dc->hwss.edp_power_control) {
 					dc->hwss.edp_backlight_control(edp_link, false);
-					dc->hwss.power_down(dc);
+					hws->funcs.power_down(dc);
 					dc->hwss.edp_power_control(edp_link, false);
 				}
 			}
@@ -914,8 +914,8 @@ void dcn32_init_hw(struct dc *dc)
 
 				if (link->link_enc->funcs->is_dig_enabled &&
 						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-						dc->hwss.power_down) {
-					dc->hwss.power_down(dc);
+						hws->funcs.power_down) {
+					hws->funcs.power_down(dc);
 					break;
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 5c50458b12cb..968b010971ea 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -124,7 +124,6 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index ac1e3331a77c..a9dc7cf12dac 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -629,10 +629,10 @@ void dcn35_power_down_on_boot(struct dc *dc)
 	if (edp_link && edp_link->link_enc->funcs->is_dig_enabled &&
 			edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
 			dc->hwseq->funcs.edp_backlight_control &&
-			dc->hwss.power_down &&
+			dc->hwseq->funcs.power_down &&
 			dc->hwss.edp_power_control) {
 		dc->hwseq->funcs.edp_backlight_control(edp_link, false);
-		dc->hwss.power_down(dc);
+		dc->hwseq->funcs.power_down(dc);
 		dc->hwss.edp_power_control(edp_link, false);
 	} else {
 		for (i = 0; i < dc->link_count; i++) {
@@ -640,8 +640,8 @@ void dcn35_power_down_on_boot(struct dc *dc)
 
 			if (link->link_enc && link->link_enc->funcs->is_dig_enabled &&
 					link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-					dc->hwss.power_down) {
-				dc->hwss.power_down(dc);
+					dc->hwseq->funcs.power_down) {
+				dc->hwseq->funcs.power_down(dc);
 				break;
 			}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 428912f37129..55dc5799e725 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -101,7 +101,6 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.power_down = dce110_power_down,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
@@ -128,7 +127,6 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.init_pipes = dcn35_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 55e791552bca..b1b2a58684e7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -100,7 +100,6 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
-	.power_down = dce110_power_down,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
@@ -127,7 +126,6 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 
 static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.init_pipes = dcn35_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 779960278a5c..87c5ef579ecb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -354,10 +354,10 @@ void dcn401_init_hw(struct dc *dc)
 				if (edp_link->link_enc->funcs->is_dig_enabled &&
 						edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
 						dc->hwss.edp_backlight_control &&
-						dc->hwss.power_down &&
+						hws->funcs.power_down &&
 						dc->hwss.edp_power_control) {
 					dc->hwss.edp_backlight_control(edp_link, false);
-					dc->hwss.power_down(dc);
+					hws->funcs.power_down(dc);
 					dc->hwss.edp_power_control(edp_link, false);
 				}
 			}
@@ -367,8 +367,8 @@ void dcn401_init_hw(struct dc *dc)
 
 				if (link->link_enc->funcs->is_dig_enabled &&
 						link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
-						dc->hwss.power_down) {
-					dc->hwss.power_down(dc);
+						hws->funcs.power_down) {
+					hws->funcs.power_down(dc);
 					break;
 				}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 1439f07f0b64..2533f16510ba 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -99,12 +99,10 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.fams2_global_control_lock = dcn401_fams2_global_control_lock,
 	.fams2_update_config = dcn401_fams2_update_config,
 	.fams2_global_control_lock_fast = dcn401_fams2_global_control_lock_fast,
-	.power_down = dce110_power_down,
 };
 
 static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
-	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index d05be65a2256..f50b2955ce8c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -240,7 +240,6 @@ struct hw_sequencer_funcs {
 	void (*program_triplebuffer)(const struct dc *dc,
 		struct pipe_ctx *pipe_ctx, bool enableTripleBuffer);
 	void (*update_pending_status)(struct pipe_ctx *pipe_ctx);
-	void (*power_down)(struct dc *dc);
 	void (*update_dsc_pg)(struct dc *dc, struct dc_state *context, bool safe_to_disable);
 
 	/* Pipe Lock Related */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 7a75ff320511..0ac675456979 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -76,8 +76,6 @@ struct hwseq_private_funcs {
 	void (*enable_stream_gating)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 	void (*init_pipes)(struct dc *dc, struct dc_state *context);
 	void (*reset_hw_ctx_wrap)(struct dc *dc, struct dc_state *context);
-	void (*update_plane_addr)(const struct dc *dc,
-			struct pipe_ctx *pipe_ctx);
 	void (*plane_atomic_disconnect)(struct dc *dc,
 			struct dc_state *state,
 			struct pipe_ctx *pipe_ctx);
-- 
2.39.2

