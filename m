Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718A8ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4692010E800;
	Wed, 14 Sep 2022 03:50:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D334810E801
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+Kb9dOiegJwxfvHyAnIpGJN7T8SA5r9VOzzGnlwAzM8JlRhqqGTbmegtBt2lpiGtH7G9AhN8p+Tt4upgOGHj8eNSL0Wni/BCpzrALVOR8C0JJuK4Toq2Sp3ozxpMrky16dmpBAI5YBnsaIzG1agSk/F/ekKdw5QyF2eCcpx8ParCwGkKndiOzpS3NBEK/m2AxUfE/w85dde47SVzXTNPs8n+UUGxZjIg3keFMHckgWdyEeZ33JWGE9u8hUAdxKt6SUm58RhRet4xKeCpLQAsjSMaoEGHVHE1VZV7fizH+hB906uy2itHJ0hjBkLE5IVj8tAKPlb08wtzfwPKnTAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SjFPLzCyRmmq8vZtU5NdhSKVQb/U3JUjfAJ3nZzvtU=;
 b=e+ZycU0yczRZ3T89fD2rgZaRdPlfQP8n0aPkx2UqLmrhbbFZoQ0M8g/NWAIO/zUUxUA4+9Sz+96/ssgdFqSYUBZUNVGDawOw2BM8EDkb8XfuBZJ9WJe3LQ+bdUQk7a0xxwnkzWeYyOc9dO2jCKVmT6OW1/OZzmveNe11oUcwHcFdsDaWRGmL0Ts3tUnjuG7h9/HpNDxNOrl6WYeUN1oyMYb8qPI3c9dBeu8a7wg80jYA9xd5f/8yOn2hFActmlltgMXODePkTvyHN+xgn075dACUcIkn0O2EgkIyatYzTvyUGmz64qM6oWBc8qEAv55PUSpxuNFgA0v8eJlKftmZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SjFPLzCyRmmq8vZtU5NdhSKVQb/U3JUjfAJ3nZzvtU=;
 b=JmVvl/67fxRf5ydtCLouctl8iKKbYNz9J6goVN75iNDMdyyinJhl29LisFmqvo7ajHaCeZJYpZECz0g/oTJ+dY8DAgR/Srf+5fCW/CCOzlZN8vvIHomUYEb3pztNWopkjJnItfXPT+vNjC1s5VkL3uU2UlMaXkx4eDqo7hizIKU=
Received: from DM6PR02CA0103.namprd02.prod.outlook.com (2603:10b6:5:1f4::44)
 by BL0PR12MB4963.namprd12.prod.outlook.com (2603:10b6:208:17d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 03:50:05 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::63) by DM6PR02CA0103.outlook.office365.com
 (2603:10b6:5:1f4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Wed, 14 Sep 2022 03:50:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:50:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:49:49 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:49:45 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 10/47] drm/amd/display: rework recent update PHY state
 commit
Date: Wed, 14 Sep 2022 11:47:31 +0800
Message-ID: <20220914034808.1093521-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|BL0PR12MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: de293d31-8f8c-46f2-8d02-08da96043545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7J4C8hVFJiOkWtvyV4ho5NYDTLUmQx1qyowHaL4exPKE5/8sIR9PByH9atImYPw3o/Lk2oq3vMEIZZ2BZsF+7RPhaf2uvffcKqIGd+xpwpnGufcW43xFI27LOM+Gtfvdsj3oq22kgiKqorGtdN9mkvn4j2jq8mDa5sLX9MiM3FQiKw2PSe+c/uBPIjauqEM7BcI07JYXLtaiorDLJeD8RTHeKAF5vHvjuphxsAA4CpvlyDdIJiwL+vSs5gzliFvvca33sm5kYoDkK6RpyLQr3qQop1tJhgBC0njs9/s2DlE5365H4HDBee0VTcupRpIHL2kw90JvEACY7cPphqDIDgHfbJ5z96CwXaIoxdTyA1m/vQ7GhFQc40TEGWVLPnVr+cRk0/3D6P9d9G7Er/f6n3v+zr0RiLKyw7x4b3OwE85SLctIzHn6A7981ylPUclyw3FZ2/zdfwX6tCet9k0z60Ma8gqiajKcGT/5k/XKjQwvb/v9lUzUE2OB/SbNL71kytpT2nOpHTibuK9p/osAelNPEfAMQHRhJxneivcHghMjvx4kHsVElnb98XHJp4k8tZ7HKlskV1habWDi/MB0lbOuaLCuYpm6R39Oad3J7bra1UYeeiMdb/lIcSfR/wex4EOtP5g6U8p2DoZuS8STbcPow0oH+6MVUjXJPwlQu1CkYZxQKzQ+6CEi5KAj7dfMWMYzxDmmDjKlSGJpnTZs7yA7QHAiPaWHbq+SmYpB3UjvUPolddtd7YQs1LhyG1fpoOh4tPqCqNaSz5ueYCpUF+fQm9AG6jdBF21wjLRZr+BlrH17PcG3nWzVkEdu9kN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(8676002)(2906002)(356005)(40480700001)(82310400005)(81166007)(15650500001)(86362001)(41300700001)(316002)(1076003)(186003)(47076005)(8936002)(30864003)(2616005)(70586007)(26005)(336012)(426003)(5660300002)(82740400003)(54906003)(83380400001)(36860700001)(478600001)(36756003)(7696005)(4326008)(40460700003)(70206006)(6666004)(6916009)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:50:04.3195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de293d31-8f8c-46f2-8d02-08da96043545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4963
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Original change 8da78e248069 "drm/amd/display: Add
interface to track PHY state" was implemented by assuming stream's
dpms off is equivalent to PHY power off.
This assumption doesn't hold in following situations:
1. MST multiple stream scenario, where multiple streams are sharing the
same PHY output. Toggle dpms off for one of the stream doesn't power
off the PHY due to the presence of other streams.
2. enable stream failure scenario, where enable stream fails due to
failure of link training. This will cause DPMS off is set to false, while
the actual PHY power state is off in certain cases.
Due to the problematic assumption, the logic will skip disabling
other streams for MST multiple stream scenario, therefore PHY is
not actually powered off.

[how]
1. Rework this refactor by moving PHY state update down to hardware
level, where we update PHY state in place when hardware sequencer
is actually changing the power state of the PHY hardware.
2. Reimplement symclk on TX off workaround in place when we are actually
calling transmitter control to power off PHY in dcn32. Note the workaround is
added due to the lack of proper software interface to set TX while keeping
symclk on. We plan to address this interface problem so we can set TX off
only without affecting symclk in future dcn versions.

Fixes: 8da78e248069 ("drm/amd/display: Add interface to track PHY state")
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  19 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  20 +--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  96 +-----------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 137 +++++++++++++++++-
 .../display/dc/dce110/dce110_hw_sequencer.h   |  20 ++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   9 ++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   4 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  32 +++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   4 +
 .../drm/amd/display/dc/dcn201/dcn201_init.c   |   4 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   4 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   4 +
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   4 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  11 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   4 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   4 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  83 ++++++++---
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   5 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   5 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  16 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  23 ++-
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |   6 +-
 .../drm/amd/display/dc/link/link_hwss_dio.c   |   4 +-
 .../drm/amd/display/dc/link/link_hwss_dio.h   |   2 +-
 .../drm/amd/display/dc/link/link_hwss_dpia.c  |   2 +-
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |   2 +-
 .../display/dc/virtual/virtual_link_hwss.c    |   8 +
 28 files changed, 357 insertions(+), 177 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 253dc4e35ba4..81cfda5b6526 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1184,11 +1184,7 @@ static void disable_vbios_mode_if_required(
 						pipe->stream_res.pix_clk_params.requested_pix_clk_100hz;
 
 					if (pix_clk_100hz != requested_pix_clk_100hz) {
-						if (dc->hwss.update_phy_state)
-							dc->hwss.update_phy_state(dc->current_state,
-									pipe, TX_OFF_SYMCLK_OFF);
-						else
-							core_link_disable_stream(pipe);
+						core_link_disable_stream(pipe);
 						pipe->stream->dpms_off = false;
 					}
 				}
@@ -3071,11 +3067,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 
 			if (stream_update->dpms_off) {
 				if (*stream_update->dpms_off) {
-					if (dc->hwss.update_phy_state)
-						dc->hwss.update_phy_state(dc->current_state,
-								pipe_ctx, TX_OFF_SYMCLK_ON);
-					else
-						core_link_disable_stream(pipe_ctx);
+					core_link_disable_stream(pipe_ctx);
 					/* for dpms, keep acquired resources*/
 					if (pipe_ctx->stream_res.audio && !dc->debug.az_endpoint_mute_only)
 						pipe_ctx->stream_res.audio->funcs->az_disable(pipe_ctx->stream_res.audio);
@@ -3085,12 +3077,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				} else {
 					if (get_seamless_boot_stream_count(context) == 0)
 						dc->hwss.prepare_bandwidth(dc, dc->current_state);
-
-					if (dc->hwss.update_phy_state)
-						dc->hwss.update_phy_state(dc->current_state,
-								pipe_ctx, TX_ON_SYMCLK_ON);
-					else
-						core_link_enable_stream(dc->current_state, pipe_ctx);
+					core_link_enable_stream(dc->current_state, pipe_ctx);
 				}
 			}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 4bccfc8c832d..7a9f7b4bd666 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2644,9 +2644,8 @@ static void disable_link(struct dc_link *link, const struct link_resource *link_
 				dp_set_fec_ready(link, link_res, false);
 			}
 		}
-	} else {
-		if (signal != SIGNAL_TYPE_VIRTUAL)
-			link->link_enc->funcs->disable_output(link->link_enc, signal);
+	} else if (signal != SIGNAL_TYPE_VIRTUAL) {
+		link->dc->hwss.disable_link_output(link, link_res, signal);
 	}
 
 	if (signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
@@ -2668,6 +2667,7 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 	bool is_over_340mhz = false;
 	bool is_vga_mode = (stream->timing.h_addressable == 640)
 			&& (stream->timing.v_addressable == 480);
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
 
 	if (stream->phy_pix_clk == 0)
 		stream->phy_pix_clk = stream->timing.pix_clk_100hz / 10;
@@ -2707,11 +2707,12 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 	if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422)
 		display_color_depth = COLOR_DEPTH_888;
 
-	link->link_enc->funcs->enable_tmds_output(
-			link->link_enc,
+	dc->hwss.enable_tmds_link_output(
+			link,
+			&pipe_ctx->link_res,
+			pipe_ctx->stream->signal,
 			pipe_ctx->clock_source->id,
 			display_color_depth,
-			pipe_ctx->stream->signal,
 			stream->phy_pix_clk);
 
 	if (dc_is_hdmi_signal(pipe_ctx->stream->signal))
@@ -2722,15 +2723,16 @@ static void enable_link_lvds(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
+	struct dc *dc = stream->ctx->dc;
 
 	if (stream->phy_pix_clk == 0)
 		stream->phy_pix_clk = stream->timing.pix_clk_100hz / 10;
 
 	memset(&stream->link->cur_link_settings, 0,
 			sizeof(struct dc_link_settings));
-
-	link->link_enc->funcs->enable_lvds_output(
-			link->link_enc,
+	dc->hwss.enable_lvds_link_output(
+			link,
+			&pipe_ctx->link_res,
 			pipe_ctx->clock_source->id,
 			stream->phy_pix_clk);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 40bdf9708d76..eea6ec0a76b4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4518,25 +4518,15 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
-				pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe) {
-			if (link->dc->hwss.update_phy_state)
-				link->dc->hwss.update_phy_state(link->dc->current_state,
-						pipe_ctx, TX_OFF_SYMCLK_OFF);
-			else
-				core_link_disable_stream(pipe_ctx);
-		}
+				pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe)
+			core_link_disable_stream(pipe_ctx);
 	}
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
-				pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe) {
-			if (link->dc->hwss.update_phy_state)
-				link->dc->hwss.update_phy_state(link->dc->current_state,
-						pipe_ctx, TX_ON_SYMCLK_ON);
-			else
-				core_link_enable_stream(link->dc->current_state, pipe_ctx);
-		}
+				pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe)
+			core_link_enable_stream(link->dc->current_state, pipe_ctx);
 	}
 }
 
@@ -7077,60 +7067,9 @@ void dp_enable_link_phy(
 	enum clock_source_id clock_source,
 	const struct dc_link_settings *link_settings)
 {
-	struct dc  *dc = link->ctx->dc;
-	struct dmcu *dmcu = dc->res_pool->dmcu;
-	struct pipe_ctx *pipes =
-			link->dc->current_state->res_ctx.pipe_ctx;
-	struct clock_source *dp_cs =
-			link->dc->res_pool->dp_clock_source;
-	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
-	unsigned int i;
-
-	if (link->connector_signal == SIGNAL_TYPE_EDP) {
-		if (!link->dc->config.edp_no_power_sequencing)
-			link->dc->hwss.edp_power_control(link, true);
-		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
-	}
-
-	/* If the current pixel clock source is not DTO(happens after
-	 * switching from HDMI passive dongle to DP on the same connector),
-	 * switch the pixel clock source to DTO.
-	 */
-	for (i = 0; i < MAX_PIPES; i++) {
-		if (pipes[i].stream != NULL &&
-			pipes[i].stream->link == link) {
-			if (pipes[i].clock_source != NULL &&
-					pipes[i].clock_source->id != CLOCK_SOURCE_ID_DP_DTO) {
-				pipes[i].clock_source = dp_cs;
-				pipes[i].stream_res.pix_clk_params.requested_pix_clk_100hz =
-						pipes[i].stream->timing.pix_clk_100hz;
-				pipes[i].clock_source->funcs->program_pix_clk(
-							pipes[i].clock_source,
-							&pipes[i].stream_res.pix_clk_params,
-							dp_get_link_encoding_format(link_settings),
-							&pipes[i].pll_settings);
-			}
-		}
-	}
-
+	link->dc->hwss.enable_dp_link_output(link, link_res, signal,
+			clock_source, link_settings);
 	link->cur_link_settings = *link_settings;
-
-	if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
-		if (dc->clk_mgr->funcs->notify_link_rate_change)
-			dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
-	}
-
-	if (dmcu != NULL && dmcu->funcs->lock_phy)
-		dmcu->funcs->lock_phy(dmcu);
-
-	if (link_hwss->ext.enable_dp_link_output)
-		link_hwss->ext.enable_dp_link_output(link, link_res, signal,
-				clock_source, link_settings);
-
-	if (dmcu != NULL && dmcu->funcs->unlock_phy)
-		dmcu->funcs->unlock_phy(dmcu);
-
-	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY);
 	dp_receiver_power_ctrl(link, true);
 }
 
@@ -7205,29 +7144,8 @@ void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_
 		enum signal_type signal)
 {
 	struct dc  *dc = link->ctx->dc;
-	struct dmcu *dmcu = dc->res_pool->dmcu;
-	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
-
-	if (!link->wa_flags.dp_keep_receiver_powered)
-		dp_receiver_power_ctrl(link, false);
-
-	if (signal == SIGNAL_TYPE_EDP) {
-		if (link->dc->hwss.edp_backlight_control)
-			link->dc->hwss.edp_backlight_control(link, false);
-		if (link_hwss->ext.disable_dp_link_output)
-			link_hwss->ext.disable_dp_link_output(link, link_res, signal);
-		link->dc->hwss.edp_power_control(link, false);
-	} else {
-		if (dmcu != NULL && dmcu->funcs->lock_phy)
-			dmcu->funcs->lock_phy(dmcu);
-		if (link_hwss->ext.disable_dp_link_output)
-			link_hwss->ext.disable_dp_link_output(link, link_res, signal);
-		if (dmcu != NULL && dmcu->funcs->unlock_phy)
-			dmcu->funcs->unlock_phy(dmcu);
-	}
-
-	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 
+	dc->hwss.disable_link_output(link, link_res, signal);
 	/* Clear current link setting.*/
 	memset(&link->cur_link_settings, 0,
 			sizeof(link->cur_link_settings));
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 3f64b3092692..4d9819d9ffb6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -244,7 +244,7 @@ struct dc_link {
 	struct gpio *hpd_gpio;
 	enum dc_link_fec_state fec_state;
 	struct dc_panel_config panel_config;
-	enum phy_state phy_state;
+	struct phy_state phy_state;
 };
 
 const struct dc_link_status *dc_link_get_status(const struct dc_link *dc_link);
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 801206aed63a..8ffb13847ae0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1441,6 +1441,14 @@ static enum dc_status dce110_enable_stream_timing(
 			return DC_ERROR_UNEXPECTED;
 		}
 
+		if (dc_is_hdmi_tmds_signal(stream->signal)) {
+			stream->link->phy_state.symclk_ref_cnts.otg = 1;
+			if (stream->link->phy_state.symclk_state == SYMCLK_OFF_TX_OFF)
+				stream->link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
+			else
+				stream->link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+		}
+
 		pipe_ctx->stream_res.tg->funcs->program_timing(
 				pipe_ctx->stream_res.tg,
 				&stream->timing,
@@ -1577,12 +1585,8 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_OTG);
 
-	if (!stream->dpms_off) {
-		if (dc->hwss.update_phy_state)
-			dc->hwss.update_phy_state(context, pipe_ctx, TX_ON_SYMCLK_ON);
-		else
-			core_link_enable_stream(context, pipe_ctx);
-	}
+	if (!stream->dpms_off)
+		core_link_enable_stream(context, pipe_ctx);
 
 	/* DCN3.1 FPGA Workaround
 	 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
@@ -2118,6 +2122,7 @@ static void dce110_reset_hw_ctx_wrap(
 				BREAK_TO_DEBUGGER();
 			}
 			pipe_ctx_old->stream_res.tg->funcs->disable_crtc(pipe_ctx_old->stream_res.tg);
+			pipe_ctx_old->stream->link->phy_state.symclk_ref_cnts.otg = 0;
 			pipe_ctx_old->plane_res.mi->funcs->free_mem_input(
 					pipe_ctx_old->plane_res.mi, dc->current_state->stream_count);
 
@@ -2996,6 +3001,122 @@ void dce110_set_pipe(struct pipe_ctx *pipe_ctx)
 		abm->funcs->set_pipe(abm, otg_inst, panel_cntl->inst);
 }
 
+void dce110_enable_lvds_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum clock_source_id clock_source,
+		uint32_t pixel_clock)
+{
+	link->link_enc->funcs->enable_lvds_output(
+			link->link_enc,
+			clock_source,
+			pixel_clock);
+	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+}
+
+void dce110_enable_tmds_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		enum dc_color_depth color_depth,
+		uint32_t pixel_clock)
+{
+	link->link_enc->funcs->enable_tmds_output(
+			link->link_enc,
+			clock_source,
+			color_depth,
+			signal,
+			pixel_clock);
+	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+}
+
+void dce110_enable_dp_link_output(
+		struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		const struct dc_link_settings *link_settings)
+{
+	struct dc  *dc = link->ctx->dc;
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+	struct pipe_ctx *pipes =
+			link->dc->current_state->res_ctx.pipe_ctx;
+	struct clock_source *dp_cs =
+			link->dc->res_pool->dp_clock_source;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+	unsigned int i;
+
+
+	if (link->connector_signal == SIGNAL_TYPE_EDP) {
+		if (!link->dc->config.edp_no_power_sequencing)
+			link->dc->hwss.edp_power_control(link, true);
+		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
+	}
+
+	/* If the current pixel clock source is not DTO(happens after
+	 * switching from HDMI passive dongle to DP on the same connector),
+	 * switch the pixel clock source to DTO.
+	 */
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (pipes[i].stream != NULL &&
+				pipes[i].stream->link == link) {
+			if (pipes[i].clock_source != NULL &&
+					pipes[i].clock_source->id != CLOCK_SOURCE_ID_DP_DTO) {
+				pipes[i].clock_source = dp_cs;
+				pipes[i].stream_res.pix_clk_params.requested_pix_clk_100hz =
+						pipes[i].stream->timing.pix_clk_100hz;
+				pipes[i].clock_source->funcs->program_pix_clk(
+						pipes[i].clock_source,
+						&pipes[i].stream_res.pix_clk_params,
+						dp_get_link_encoding_format(link_settings),
+						&pipes[i].pll_settings);
+			}
+		}
+	}
+
+	if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
+		if (dc->clk_mgr->funcs->notify_link_rate_change)
+			dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
+	}
+
+	if (dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->lock_phy(dmcu);
+
+	if (link_hwss->ext.enable_dp_link_output)
+		link_hwss->ext.enable_dp_link_output(link, link_res, signal,
+				clock_source, link_settings);
+
+	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+
+	if (dmcu != NULL && dmcu->funcs->unlock_phy)
+		dmcu->funcs->unlock_phy(dmcu);
+
+}
+
+void dce110_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	struct dc *dc = link->ctx->dc;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+
+	if (signal == SIGNAL_TYPE_EDP &&
+			link->dc->hwss.edp_backlight_control)
+		link->dc->hwss.edp_backlight_control(link, false);
+	else if (dc_is_dp_signal(signal) && dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->lock_phy(dmcu);
+
+	link_hwss->disable_link_output(link, link_res, signal);
+	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+
+	if (signal == SIGNAL_TYPE_EDP &&
+			link->dc->hwss.edp_backlight_control)
+		link->dc->hwss.edp_power_control(link, false);
+	else if (dc_is_dp_signal(signal) && dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->unlock_phy(dmcu);
+}
+
 static const struct hw_sequencer_funcs dce110_funcs = {
 	.program_gamut_remap = program_gamut_remap,
 	.program_output_csc = program_output_csc,
@@ -3035,6 +3156,10 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
+	.enable_lvds_link_output = dce110_enable_lvds_link_output,
+	.enable_tmds_link_output = dce110_enable_tmds_link_output,
+	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.disable_link_output = dce110_disable_link_output,
 };
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
index b6f3843d3d05..758f4b3b0087 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
@@ -90,6 +90,24 @@ bool dce110_set_backlight_level(struct pipe_ctx *pipe_ctx,
 		uint32_t frame_ramp);
 void dce110_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx);
 void dce110_set_pipe(struct pipe_ctx *pipe_ctx);
-
+void dce110_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal);
+void dce110_enable_lvds_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum clock_source_id clock_source,
+		uint32_t pixel_clock);
+void dce110_enable_tmds_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		enum dc_color_depth color_depth,
+		uint32_t pixel_clock);
+void dce110_enable_dp_link_output(
+		struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal,
+		enum clock_source_id clock_source,
+		const struct dc_link_settings *link_settings);
 #endif /* __DC_HWSS_DCE110_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index f26e08032da0..287fdecc0b10 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -899,6 +899,14 @@ enum dc_status dcn10_enable_stream_timing(
 		return DC_ERROR_UNEXPECTED;
 	}
 
+	if (dc_is_hdmi_tmds_signal(stream->signal)) {
+		stream->link->phy_state.symclk_ref_cnts.otg = 1;
+		if (stream->link->phy_state.symclk_state == SYMCLK_OFF_TX_OFF)
+			stream->link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
+		else
+			stream->link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+	}
+
 	pipe_ctx->stream_res.tg->funcs->program_timing(
 			pipe_ctx->stream_res.tg,
 			&stream->timing,
@@ -1017,6 +1025,7 @@ static void dcn10_reset_back_end_for_pipe(
 		if (pipe_ctx->stream_res.tg->funcs->set_drr)
 			pipe_ctx->stream_res.tg->funcs->set_drr(
 					pipe_ctx->stream_res.tg, NULL);
+		pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 10e613ec7d24..f2371c948822 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -82,6 +82,10 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
+	.enable_lvds_link_output = dce110_enable_lvds_link_output,
+	.enable_tmds_link_output = dce110_enable_tmds_link_output,
+	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.disable_link_output = dce110_disable_link_output,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 6f8c344e321d..86ab3a71c67b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -706,6 +706,14 @@ enum dc_status dcn20_enable_stream_timing(
 		return DC_ERROR_UNEXPECTED;
 	}
 
+	if (dc_is_hdmi_tmds_signal(stream->signal)) {
+		stream->link->phy_state.symclk_ref_cnts.otg = 1;
+		if (stream->link->phy_state.symclk_state == SYMCLK_OFF_TX_OFF)
+			stream->link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
+		else
+			stream->link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
+	}
+
 	if (dc->hwseq->funcs.PLAT_58856_wa && (!dc_is_dp_signal(stream->signal)))
 		dc->hwseq->funcs.PLAT_58856_wa(context, pipe_ctx);
 
@@ -2349,7 +2357,9 @@ static void dcn20_reset_back_end_for_pipe(
 		struct dc_state *context)
 {
 	int i;
-	struct dc_link *link;
+	struct dc_link *link = pipe_ctx->stream->link;
+	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+
 	DC_LOGGER_INIT(dc->ctx->logger);
 	if (pipe_ctx->stream_res.stream_enc == NULL) {
 		pipe_ctx->stream = NULL;
@@ -2357,19 +2367,15 @@ static void dcn20_reset_back_end_for_pipe(
 	}
 
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		link = pipe_ctx->stream->link;
 		/* DPMS may already disable or */
 		/* dpms_off status is incorrect due to fastboot
 		 * feature. When system resume from S4 with second
 		 * screen only, the dpms_off would be true but
 		 * VBIOS lit up eDP, so check link status too.
 		 */
-		if (!pipe_ctx->stream->dpms_off || link->link_status.link_active) {
-			if (dc->hwss.update_phy_state)
-				dc->hwss.update_phy_state(dc->current_state, pipe_ctx, TX_OFF_SYMCLK_OFF);
-			else
-				core_link_disable_stream(pipe_ctx);
-		} else if (pipe_ctx->stream_res.audio)
+		if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+			core_link_disable_stream(pipe_ctx);
+		else if (pipe_ctx->stream_res.audio)
 			dc->hwss.disable_audio_stream(pipe_ctx);
 
 		/* free acquired resources */
@@ -2409,6 +2415,16 @@ static void dcn20_reset_back_end_for_pipe(
 		if (pipe_ctx->stream_res.tg->funcs->set_drr)
 			pipe_ctx->stream_res.tg->funcs->set_drr(
 					pipe_ctx->stream_res.tg, NULL);
+		/* TODO - convert symclk_ref_cnts for otg to a bit map to solve
+		 * the case where the same symclk is shared across multiple otg
+		 * instances
+		 */
+		link->phy_state.symclk_ref_cnts.otg = 0;
+		if (link->phy_state.symclk_state == SYMCLK_ON_TX_OFF) {
+			link_hwss->disable_link_output(link,
+					&pipe_ctx->link_res, pipe_ctx->stream->signal);
+			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+		}
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 91e4885b743e..7c5817c426fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -96,6 +96,10 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 #ifndef TRIM_FSFT
 	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
 #endif
+	.enable_lvds_link_output = dce110_enable_lvds_link_output,
+	.enable_tmds_link_output = dce110_enable_tmds_link_output,
+	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.disable_link_output = dce110_disable_link_output,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
index 1826dd7f3da1..9c16633e473a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
@@ -86,6 +86,10 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
+	.enable_lvds_link_output = dce110_enable_lvds_link_output,
+	.enable_tmds_link_output = dce110_enable_tmds_link_output,
+	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.disable_link_output = dce110_disable_link_output,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index b270f0b194dc..fe1a8e2e08ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -99,6 +99,10 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 #ifndef TRIM_FSFT
 	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
 #endif
+	.enable_lvds_link_output = dce110_enable_lvds_link_output,
+	.enable_tmds_link_output = dce110_enable_tmds_link_output,
+	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.disable_link_output = dce110_disable_link_output,
 	.is_abm_supported = dcn21_is_abm_supported,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 4c06e6e1ba4a..3216d10c58ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -100,6 +100,10 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.hardware_release = dcn30_hardware_release,
 	.set_pipe = dcn21_set_pipe,
+	.enable_lvds_link_output = dce110_enable_lvds_link_output,
+	.enable_tmds_link_output = dce110_enable_tmds_link_output,
+	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.disable_link_output = dce110_disable_link_output,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index 3d42a1a337ec..6192851c59ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -99,6 +99,10 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
+	.enable_lvds_link_output = dce110_enable_lvds_link_output,
+	.enable_tmds_link_output = dce110_enable_tmds_link_output,
+	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.disable_link_output = dce110_disable_link_output,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 8d83b611507a..bdf101547484 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -535,11 +535,11 @@ static void dcn31_reset_back_end_for_pipe(
 			pipe_ctx->stream_res.tg,
 			OPTC_DSC_DISABLED, 0, 0);
 	pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
-
 	pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
 	if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
+	pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
 
 	if (pipe_ctx->stream_res.tg->funcs->set_drr)
 		pipe_ctx->stream_res.tg->funcs->set_drr(
@@ -553,12 +553,9 @@ static void dcn31_reset_back_end_for_pipe(
 		 * screen only, the dpms_off would be true but
 		 * VBIOS lit up eDP, so check link status too.
 		 */
-		if (!pipe_ctx->stream->dpms_off || link->link_status.link_active) {
-			if (dc->hwss.update_phy_state)
-				dc->hwss.update_phy_state(dc->current_state, pipe_ctx, TX_OFF_SYMCLK_OFF);
-			else
-				core_link_disable_stream(pipe_ctx);
-		} else if (pipe_ctx->stream_res.audio)
+		if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+			core_link_disable_stream(pipe_ctx);
+		else if (pipe_ctx->stream_res.audio)
 			dc->hwss.disable_audio_stream(pipe_ctx);
 
 		/* free acquired resources */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index e708f07fe75a..3a32810bbe38 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -100,6 +100,10 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
+	.enable_lvds_link_output = dce110_enable_lvds_link_output,
+	.enable_tmds_link_output = dce110_enable_tmds_link_output,
+	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.disable_link_output = dce110_disable_link_output,
 	.z10_restore = dcn31_z10_restore,
 	.z10_save_init = dcn31_z10_save_init,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index 72a563a4c3e8..5b6c2d94ec71 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -102,6 +102,10 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
+	.enable_lvds_link_output = dce110_enable_lvds_link_output,
+	.enable_tmds_link_output = dce110_enable_tmds_link_output,
+	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.disable_link_output = dce110_disable_link_output,
 	.z10_restore = dcn31_z10_restore,
 	.z10_save_init = dcn31_z10_save_init,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 449459ca5a72..c6d2a05ded3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -883,6 +883,7 @@ void dcn32_init_hw(struct dc *dc)
 		if (link->link_enc->funcs->is_dig_enabled &&
 			link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
 			link->link_status.link_active = true;
+			link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
 			if (link->link_enc->funcs->fec_is_active &&
 					link->link_enc->funcs->fec_is_active(link->link_enc))
 				link->fec_state = dc_link_fec_enabled;
@@ -1275,31 +1276,69 @@ bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx)
 	return false;
 }
 
-void dcn32_update_phy_state(struct dc_state *state, struct pipe_ctx *pipe_ctx,
-		enum phy_state target_state)
+static void apply_symclk_on_tx_off_wa(struct dc_link *link)
 {
-	enum phy_state current_state = pipe_ctx->stream->link->phy_state;
-
-	if (target_state == TX_OFF_SYMCLK_OFF) {
-		core_link_disable_stream(pipe_ctx);
-		pipe_ctx->stream->link->phy_state = TX_OFF_SYMCLK_OFF;
-	} else if (target_state == TX_ON_SYMCLK_ON) {
-		core_link_enable_stream(state, pipe_ctx);
-		pipe_ctx->stream->link->phy_state = TX_ON_SYMCLK_ON;
-	} else if (target_state == TX_OFF_SYMCLK_ON) {
-		if (current_state == TX_ON_SYMCLK_ON) {
-			core_link_disable_stream(pipe_ctx);
-			pipe_ctx->stream->link->phy_state = TX_OFF_SYMCLK_OFF;
+	/* There are use cases where SYMCLK is referenced by OTG. For instance
+	 * for TMDS signal, OTG relies SYMCLK even if TX video output is off.
+	 * However current link interface will power off PHY when disabling link
+	 * output. This will turn off SYMCLK generated by PHY. The workaround is
+	 * to identify such case where SYMCLK is still in use by OTG when we
+	 * power off PHY. When this is detected, we will temporarily power PHY
+	 * back on and move PHY's SYMCLK state to SYMCLK_ON_TX_OFF by calling
+	 * program_pix_clk interface. When OTG is disabled, we will then power
+	 * off PHY by calling disable link output again.
+	 *
+	 * In future dcn generations, we plan to rework transmitter control
+	 * interface so that we could have an option to set SYMCLK ON TX OFF
+	 * state in one step without this workaround
+	 */
+
+	struct dc *dc = link->ctx->dc;
+	struct pipe_ctx *pipe_ctx = NULL;
+	uint8_t i;
+
+	if (link->phy_state.symclk_ref_cnts.otg > 0) {
+		for (i = 0; i < MAX_PIPES; i++) {
+			pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx->stream->link == link && pipe_ctx->top_pipe == NULL) {
+				pipe_ctx->clock_source->funcs->program_pix_clk(
+						pipe_ctx->clock_source,
+						&pipe_ctx->stream_res.pix_clk_params,
+						dp_get_link_encoding_format(&pipe_ctx->link_config.dp_link_settings),
+						&pipe_ctx->pll_settings);
+				link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
+				break;
+			}
 		}
+	}
+}
 
-		pipe_ctx->clock_source->funcs->program_pix_clk(
-			pipe_ctx->clock_source,
-			&pipe_ctx->stream_res.pix_clk_params,
-			dp_get_link_encoding_format(&pipe_ctx->link_config.dp_link_settings),
-			&pipe_ctx->pll_settings);
-		pipe_ctx->stream->link->phy_state = TX_OFF_SYMCLK_ON;
-	} else
-		BREAK_TO_DEBUGGER();
+void dcn32_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	struct dc *dc = link->ctx->dc;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+
+	if (signal == SIGNAL_TYPE_EDP &&
+			link->dc->hwss.edp_backlight_control)
+		link->dc->hwss.edp_backlight_control(link, false);
+	else if (dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->lock_phy(dmcu);
+
+	link_hwss->disable_link_output(link, link_res, signal);
+	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+
+	if (signal == SIGNAL_TYPE_EDP &&
+			link->dc->hwss.edp_backlight_control)
+		link->dc->hwss.edp_power_control(link, false);
+	else if (dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->unlock_phy(dmcu);
+
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
+
+	apply_symclk_on_tx_off_wa(link);
 }
 
 /* For SubVP the main pipe can have a viewport position change
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 150d541f35b4..86c018b2f132 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -84,8 +84,9 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 
 bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
 
-void dcn32_update_phy_state(struct dc_state *state, struct pipe_ctx *pipe_ctx,
-		enum phy_state target_state);
+void dcn32_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal);
 
 void dcn32_update_phantom_vp_position(struct dc *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index c554929471af..c66dfe14909a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -99,12 +99,15 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.hardware_release = dcn30_hardware_release,
 	.set_pipe = dcn21_set_pipe,
+	.enable_lvds_link_output = dce110_enable_lvds_link_output,
+	.enable_tmds_link_output = dce110_enable_tmds_link_output,
+	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.disable_link_output = dcn32_disable_link_output,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.commit_subvp_config = dcn32_commit_subvp_config,
 	.subvp_pipe_control_lock = dcn32_subvp_pipe_control_lock,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
-	.update_phy_state = dcn32_update_phy_state,
 	.update_phantom_vp_position = dcn32_update_phantom_vp_position,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index 437b64e87377..cd2be729846b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -268,10 +268,18 @@ enum dc_lut_mode {
 	LUT_RAM_B
 };
 
-enum phy_state {
-	TX_OFF_SYMCLK_OFF,
-	TX_ON_SYMCLK_ON,
-	TX_OFF_SYMCLK_ON
+enum symclk_state {
+	SYMCLK_OFF_TX_OFF,
+	SYMCLK_ON_TX_ON,
+	SYMCLK_ON_TX_OFF,
+};
+
+struct phy_state {
+	struct {
+		uint8_t otg		: 1;
+		uint8_t reserved	: 7;
+	} symclk_ref_cnts;
+	enum symclk_state symclk_state;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index d7a7b2790143..416b700a8d5a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -48,6 +48,7 @@ struct dc_phy_addr_space_config;
 struct dc_virtual_addr_space_config;
 struct dpp;
 struct dce_hwseq;
+struct link_resource;
 
 struct hw_sequencer_funcs {
 	void (*hardware_release)(struct dc *dc);
@@ -218,6 +219,25 @@ struct hw_sequencer_funcs {
 
 	void (*set_pipe)(struct pipe_ctx *pipe_ctx);
 
+	void (*enable_dp_link_output)(struct dc_link *link,
+			const struct link_resource *link_res,
+			enum signal_type signal,
+			enum clock_source_id clock_source,
+			const struct dc_link_settings *link_settings);
+	void (*enable_tmds_link_output)(struct dc_link *link,
+			const struct link_resource *link_res,
+			enum signal_type signal,
+			enum clock_source_id clock_source,
+			enum dc_color_depth color_depth,
+			uint32_t pixel_clock);
+	void (*enable_lvds_link_output)(struct dc_link *link,
+			const struct link_resource *link_res,
+			enum clock_source_id clock_source,
+			uint32_t pixel_clock);
+	void (*disable_link_output)(struct dc_link *link,
+			const struct link_resource *link_res,
+			enum signal_type signal);
+
 	void (*get_dcc_en_bits)(struct dc *dc, int *dcc_en_bits);
 
 	/* Idle Optimization Related */
@@ -245,9 +265,6 @@ struct hw_sequencer_funcs {
 			struct tg_color *color,
 			int mpcc_id);
 
-	void (*update_phy_state)(struct dc_state *state, struct pipe_ctx *pipe_ctx, enum phy_state target_state);
-
-
 	void (*update_phantom_vp_position)(struct dc *dc,
 			struct dc_state *context,
 			struct pipe_ctx *phantom_pipe);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index 3482a877b6af..89964c980b87 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -55,9 +55,6 @@ struct link_hwss_ext {
 			enum signal_type signal,
 			enum clock_source_id clock_source,
 			const struct dc_link_settings *link_settings);
-	void (*disable_dp_link_output)(struct dc_link *link,
-			const struct link_resource *link_res,
-			enum signal_type signal);
 	void (*set_dp_link_test_pattern)(struct dc_link *link,
 			const struct link_resource *link_res,
 			struct encoder_set_dp_phy_pattern_param *tp_params);
@@ -79,6 +76,9 @@ struct link_hwss {
 	void (*setup_stream_encoder)(struct pipe_ctx *pipe_ctx);
 	void (*reset_stream_encoder)(struct pipe_ctx *pipe_ctx);
 	void (*setup_stream_attribute)(struct pipe_ctx *pipe_ctx);
+	void (*disable_link_output)(struct dc_link *link,
+			const struct link_resource *link_res,
+			enum signal_type signal);
 };
 #endif /* __DC_LINK_HWSS_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
index 5e92019539c8..4227adbc646a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
@@ -130,7 +130,7 @@ void enable_dio_dp_link_output(struct dc_link *link,
 	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY);
 }
 
-void disable_dio_dp_link_output(struct dc_link *link,
+void disable_dio_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal)
 {
@@ -174,10 +174,10 @@ static const struct link_hwss dio_link_hwss = {
 	.setup_stream_encoder = setup_dio_stream_encoder,
 	.reset_stream_encoder = reset_dio_stream_encoder,
 	.setup_stream_attribute = setup_dio_stream_attribute,
+	.disable_link_output = disable_dio_link_output,
 	.ext = {
 		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
 		.enable_dp_link_output = enable_dio_dp_link_output,
-		.disable_dp_link_output = disable_dio_dp_link_output,
 		.set_dp_link_test_pattern = set_dio_dp_link_test_pattern,
 		.set_dp_lane_settings = set_dio_dp_lane_settings,
 		.update_stream_allocation_table = update_dio_stream_allocation_table,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
index 08f22b32df48..126d37f847a1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
@@ -40,7 +40,7 @@ void enable_dio_dp_link_output(struct dc_link *link,
 		enum signal_type signal,
 		enum clock_source_id clock_source,
 		const struct dc_link_settings *link_settings);
-void disable_dio_dp_link_output(struct dc_link *link,
+void disable_dio_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
 void set_dio_dp_link_test_pattern(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
index 89d4e8159138..64f7ea6a9aa3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
@@ -56,10 +56,10 @@ static const struct link_hwss dpia_link_hwss = {
 	.setup_stream_encoder = setup_dio_stream_encoder,
 	.reset_stream_encoder = reset_dio_stream_encoder,
 	.setup_stream_attribute = setup_dio_stream_attribute,
+	.disable_link_output = disable_dio_link_output,
 	.ext = {
 		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
 		.enable_dp_link_output = enable_dio_dp_link_output,
-		.disable_dp_link_output = disable_dio_dp_link_output,
 		.set_dp_link_test_pattern = set_dio_dp_link_test_pattern,
 		.set_dp_lane_settings = set_dio_dp_lane_settings,
 		.update_stream_allocation_table = update_dpia_stream_allocation_table,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
index 226af06278ce..7d3147175ca2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
@@ -266,11 +266,11 @@ static const struct link_hwss hpo_dp_link_hwss = {
 	.setup_stream_encoder = setup_hpo_dp_stream_encoder,
 	.reset_stream_encoder = reset_hpo_dp_stream_encoder,
 	.setup_stream_attribute = setup_hpo_dp_stream_attribute,
+	.disable_link_output = disable_hpo_dp_link_output,
 	.ext = {
 		.set_throttled_vcp_size = set_hpo_dp_throttled_vcp_size,
 		.set_hblank_min_symbol_width = set_hpo_dp_hblank_min_symbol_width,
 		.enable_dp_link_output = enable_hpo_dp_link_output,
-		.disable_dp_link_output = disable_hpo_dp_link_output,
 		.set_dp_link_test_pattern  = set_hpo_dp_link_test_pattern,
 		.set_dp_lane_settings = set_hpo_dp_lane_settings,
 		.update_stream_allocation_table = update_hpo_dp_stream_allocation_table,
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
index 501173ce270e..9522fe0b36c9 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_hwss.c
@@ -36,10 +36,18 @@ void virtual_setup_stream_attribute(struct pipe_ctx *pipe_ctx)
 void virtual_reset_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
 }
+
+void virtual_disable_link_output(struct dc_link *link,
+	const struct link_resource *link_res,
+	enum signal_type signal)
+{
+}
+
 static const struct link_hwss virtual_link_hwss = {
 	.setup_stream_encoder = virtual_setup_stream_encoder,
 	.reset_stream_encoder = virtual_reset_stream_encoder,
 	.setup_stream_attribute = virtual_setup_stream_attribute,
+	.disable_link_output = virtual_disable_link_output,
 };
 
 const struct link_hwss *get_virtual_link_hwss(void)
-- 
2.37.3

