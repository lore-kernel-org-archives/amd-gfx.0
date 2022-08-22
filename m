Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D6DC28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 14:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A3E38F56D;
	Mon, 22 Aug 2022 14:01:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E888F4EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 14:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIslKeXbumDN+heLf6e64/k9ZylYkImyM4hq2xNiY60aQpKjvYVNSvp9SId+RMT/zTuuzkT73NBujvQlnv5knXx4xTMl6JqgGmxtkXuwssCC+srqRn5bRno3RY1rVi050NxNisS8wL/ELsiCD647+vdB4LtBWuypLJYj5aC69G/SAHgzqduygReuywl7Q+C4zsEXGf/n6sbNQBWSQupgrQTZd08MUib1vQitkhm6u7HiyvQtpXmxkCiyZWIYY6qxc/Rq5C7sT8uVIVM0RgjO4tPHYrKwzikNoR0SlM7Ut3kWAber4ye36Hflp/zYFVK9DgBeXHQkEFNT2tG69aGqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zstSnezNWkXIwR9wx5ZoNnpgnNGv1vgt9TXhupARDo8=;
 b=obZz5j7gjofEm7q0wMWEwgVE5S8VsctMO4g3ESYeXvoASdX5u6NVW2lcAfsJi9E9GUaXpbiFFice4eGhGKtH0289b7MDBGDJjwvMS6vuxelmgVdT6FWACdtAatNAvkGv4hv7csp5JvSDynsrnjIt7oxHgCVtfG8Q5hrd5sHOSuDn2vgEnsVdG9cGDPxvmi5w/tRlsS8uIhv3bUyNSxIzjvy7oVjJs6vdwgv6rXzPPgIlCtKJL6W7Tcrw7s2Fux1wWFo5Kjx4a7lvg6OE8M6iAT+rRizni9EMWbqItTxsH1H9u7mi6od1RRGyBUMO5DIXou+sS15M3zII8YNsKwUeWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zstSnezNWkXIwR9wx5ZoNnpgnNGv1vgt9TXhupARDo8=;
 b=FN0QhLoV+81AXnmLwjVzF1WZrnWfS80fZSYMHDWRwN6BChvBFXIBbXI6uRyOoHKoq9BfVQkwtz0Oz8qJTC/ohO6V5hWVIkvcwPnJBg0e6tpi0yuQgGkc+DIrC/EgUwiIMRM3QEYToB/WJhzvEkQcLST4U9CdfBNcf2JikH69e8o=
Received: from DS7PR05CA0099.namprd05.prod.outlook.com (2603:10b6:8:56::20) by
 BN7PR12MB2626.namprd12.prod.outlook.com (2603:10b6:408:29::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 14:01:10 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::66) by DS7PR05CA0099.outlook.office365.com
 (2603:10b6:8:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4 via Frontend
 Transport; Mon, 22 Aug 2022 14:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 14:01:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 09:01:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 09:00:36 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 09:00:33
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: Add interface to track PHY state
Date: Mon, 22 Aug 2022 17:57:49 +0800
Message-ID: <20220822095752.3750614-12-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa5e4e69-f61e-484c-638f-08da8446c47d
X-MS-TrafficTypeDiagnostic: BN7PR12MB2626:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/IMkUNTGetPoSGzBrcE+VQ+F77JnIyXqfhUOtRrC0xHsFGdc9tlOdTtJbxSZ9yxundOfREs8/gk6Ir4YbFBnf6JU36FFyiNcASvW6STn67NQEQRh3bh2NB2egJrHix0aatwSmJ8v8ju7ijyXkNSL5bKvQKuDQenl+jlTcf/3NOypuyXyM03Lla2wkxto7f8XAtUOlqCIMDoSADI8GIn+kvDxyYCtzPQwj9/ip2qTad3aP7Sa1wmP9LoKN/ZdoRTLy1k1GsFn7oRti9aBtTJucMYED6dxHMUOliyAOmxZljrOq9nELAqp86jO+CnGy7R53UqM/u4Cy7u2vvz3F3oHc+yIJaz8UZcl1EGvUHGvAQ55btVOe3VOGngigcQ8HqbVGOz6KrjJIwcgCRwPfgY028ZMafQmJVLVSmfhgphOTpb8iUDYf99FFwPcAT9TmOfa/0gkaWv6OQbzLNiwSCnp3Nbyulgbi4ic3U+6/gmtd5Kv2UTHdFyRWiWbMTP9HfXZWwXxpTRVDTBsClEUvV8WNtZO6PWElGuu4wRCIJO38Qkw5OU2+EZYlso7H8ZgggZwVJIWvuR8YepVuJRhBdt23ayqvesYpZgwulEd1UVGlsVE9XJPjaR7LJ0O7m2UvvmI16Y0cXOf+1MvLJ58q803P1H/wkOBB2CHp3gMHKp5y4Euz7XlUZrYWG+PRXpfz4mlQHJLbLetbT0xC3JxZiOT0JG5jwPEOihnh/QEUN+s58nnwsQsjnwoOoT/xLjKPqbROwNArDZh0pD/Fwbkchfe+7Sih8rQ0daLNbm8LmPxax/tjQLb7biyNvoXuVy7arBbcJ/r/B5rP4I2c3ujx41mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(40470700004)(82740400003)(41300700001)(81166007)(356005)(478600001)(30864003)(6666004)(26005)(47076005)(2616005)(426003)(1076003)(5660300002)(186003)(8936002)(7696005)(336012)(36756003)(4326008)(2906002)(54906003)(82310400005)(86362001)(6916009)(40460700003)(70586007)(8676002)(70206006)(316002)(83380400001)(36860700001)(40480700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 14:01:10.4538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5e4e69-f61e-484c-638f-08da8446c47d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2626
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, alvin.lee2@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why]
Sometimes pixel clock needs to remain active after transmitter disable.

[How]
Use update_phy_state to track PHY state after stream
enable/disable and program pixel clock as needed.

Reviewed-by: Alvin Lee <USER DID NOT SET AN EMAIL>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 18 +++++++++--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 12 +++++--
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  8 +++--
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  9 ++++--
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  9 ++++--
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 32 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  3 ++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  6 ++++
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  2 ++
 11 files changed, 88 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5006263f8d56..ced09f875e58 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1180,7 +1180,11 @@ static void disable_vbios_mode_if_required(
 						pipe->stream_res.pix_clk_params.requested_pix_clk_100hz;
 
 					if (pix_clk_100hz != requested_pix_clk_100hz) {
-						core_link_disable_stream(pipe);
+						if (dc->hwss.update_phy_state)
+							dc->hwss.update_phy_state(dc->current_state,
+									pipe, TX_OFF_SYMCLK_OFF);
+						else
+							core_link_disable_stream(pipe);
 						pipe->stream->dpms_off = false;
 					}
 				}
@@ -3063,7 +3067,11 @@ static void commit_planes_do_stream_update(struct dc *dc,
 
 			if (stream_update->dpms_off) {
 				if (*stream_update->dpms_off) {
-					core_link_disable_stream(pipe_ctx);
+					if (dc->hwss.update_phy_state)
+						dc->hwss.update_phy_state(dc->current_state,
+								pipe_ctx, TX_OFF_SYMCLK_ON);
+					else
+						core_link_disable_stream(pipe_ctx);
 					/* for dpms, keep acquired resources*/
 					if (pipe_ctx->stream_res.audio && !dc->debug.az_endpoint_mute_only)
 						pipe_ctx->stream_res.audio->funcs->az_disable(pipe_ctx->stream_res.audio);
@@ -3074,7 +3082,11 @@ static void commit_planes_do_stream_update(struct dc *dc,
 					if (get_seamless_boot_stream_count(context) == 0)
 						dc->hwss.prepare_bandwidth(dc, dc->current_state);
 
-					core_link_enable_stream(dc->current_state, pipe_ctx);
+					if (dc->hwss.update_phy_state)
+						dc->hwss.update_phy_state(dc->current_state,
+								pipe_ctx, TX_ON_SYMCLK_ON);
+					else
+						core_link_enable_stream(dc->current_state, pipe_ctx);
 				}
 			}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index bdf6b8081716..2b7bb3a796e8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4519,7 +4519,11 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
 				pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe) {
-			core_link_disable_stream(pipe_ctx);
+			if (link->dc->hwss.update_phy_state)
+				link->dc->hwss.update_phy_state(link->dc->current_state,
+						pipe_ctx, TX_OFF_SYMCLK_OFF);
+			else
+				core_link_disable_stream(pipe_ctx);
 		}
 	}
 
@@ -4527,7 +4531,11 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
 				pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe) {
-			core_link_enable_stream(link->dc->current_state, pipe_ctx);
+			if (link->dc->hwss.update_phy_state)
+				link->dc->hwss.update_phy_state(link->dc->current_state,
+						pipe_ctx, TX_ON_SYMCLK_ON);
+			else
+				core_link_enable_stream(link->dc->current_state, pipe_ctx);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 9544abf75e84..b18efe988830 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -232,6 +232,7 @@ struct dc_link {
 
 	struct gpio *hpd_gpio;
 	enum dc_link_fec_state fec_state;
+	enum phy_state phy_state;
 };
 
 const struct dc_link_status *dc_link_get_status(const struct dc_link *dc_link);
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 38a67051d470..801206aed63a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1577,8 +1577,12 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_OTG);
 
-	if (!stream->dpms_off)
-		core_link_enable_stream(context, pipe_ctx);
+	if (!stream->dpms_off) {
+		if (dc->hwss.update_phy_state)
+			dc->hwss.update_phy_state(context, pipe_ctx, TX_ON_SYMCLK_ON);
+		else
+			core_link_enable_stream(context, pipe_ctx);
+	}
 
 	/* DCN3.1 FPGA Workaround
 	 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 884fa060f375..cf439ed270de 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2361,9 +2361,12 @@ static void dcn20_reset_back_end_for_pipe(
 		 * screen only, the dpms_off would be true but
 		 * VBIOS lit up eDP, so check link status too.
 		 */
-		if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
-			core_link_disable_stream(pipe_ctx);
-		else if (pipe_ctx->stream_res.audio)
+		if (!pipe_ctx->stream->dpms_off || link->link_status.link_active) {
+			if (dc->hwss.update_phy_state)
+				dc->hwss.update_phy_state(dc->current_state, pipe_ctx, TX_OFF_SYMCLK_OFF);
+			else
+				core_link_disable_stream(pipe_ctx);
+		} else if (pipe_ctx->stream_res.audio)
 			dc->hwss.disable_audio_stream(pipe_ctx);
 
 		/* free acquired resources */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 1ed1404e969d..8d83b611507a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -553,9 +553,12 @@ static void dcn31_reset_back_end_for_pipe(
 		 * screen only, the dpms_off would be true but
 		 * VBIOS lit up eDP, so check link status too.
 		 */
-		if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
-			core_link_disable_stream(pipe_ctx);
-		else if (pipe_ctx->stream_res.audio)
+		if (!pipe_ctx->stream->dpms_off || link->link_status.link_active) {
+			if (dc->hwss.update_phy_state)
+				dc->hwss.update_phy_state(dc->current_state, pipe_ctx, TX_OFF_SYMCLK_OFF);
+			else
+				core_link_disable_stream(pipe_ctx);
+		} else if (pipe_ctx->stream_res.audio)
 			dc->hwss.disable_audio_stream(pipe_ctx);
 
 		/* free acquired resources */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index d1249fe1e412..3b1c6603ae0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1218,3 +1218,35 @@ bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx)
 		return true;
 	return false;
 }
+
+void dcn32_update_phy_state(struct dc_state *state, struct pipe_ctx *pipe_ctx,
+		enum phy_state target_state)
+{
+	enum phy_state current_state = pipe_ctx->stream->link->phy_state;
+
+	if (current_state == target_state) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	if (target_state == TX_OFF_SYMCLK_OFF) {
+		core_link_disable_stream(pipe_ctx);
+		pipe_ctx->stream->link->phy_state = TX_OFF_SYMCLK_OFF;
+	} else if (target_state == TX_ON_SYMCLK_ON) {
+		core_link_enable_stream(state, pipe_ctx);
+		pipe_ctx->stream->link->phy_state = TX_ON_SYMCLK_ON;
+	} else if (target_state == TX_OFF_SYMCLK_ON) {
+		if (current_state == TX_ON_SYMCLK_ON) {
+			core_link_disable_stream(pipe_ctx);
+			pipe_ctx->stream->link->phy_state = TX_OFF_SYMCLK_OFF;
+		}
+
+		pipe_ctx->clock_source->funcs->program_pix_clk(
+			pipe_ctx->clock_source,
+			&pipe_ctx->stream_res.pix_clk_params,
+			dp_get_link_encoding_format(&pipe_ctx->link_config.dp_link_settings),
+			&pipe_ctx->pll_settings);
+		pipe_ctx->stream->link->phy_state = TX_OFF_SYMCLK_ON;
+	} else
+		BREAK_TO_DEBUGGER();
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 083f3aeb54f0..221e31144d50 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -84,4 +84,7 @@ void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
 
 bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
 
+void dcn32_update_phy_state(struct dc_state *state, struct pipe_ctx *pipe_ctx,
+		enum phy_state target_state);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index c279a25ea293..28d220218133 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -104,6 +104,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.commit_subvp_config = dcn32_commit_subvp_config,
 	.subvp_pipe_control_lock = dcn32_subvp_pipe_control_lock,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
+	.update_phy_state = dcn32_update_phy_state,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index d89bd55f110f..437b64e87377 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -268,6 +268,12 @@ enum dc_lut_mode {
 	LUT_RAM_B
 };
 
+enum phy_state {
+	TX_OFF_SYMCLK_OFF,
+	TX_ON_SYMCLK_ON,
+	TX_OFF_SYMCLK_ON
+};
+
 /**
  * speakersToChannels
  *
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index ccb3c719fc4d..be81814da376 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -245,6 +245,8 @@ struct hw_sequencer_funcs {
 			struct tg_color *color,
 			int mpcc_id);
 
+	void (*update_phy_state)(struct dc_state *state, struct pipe_ctx *pipe_ctx,enum phy_state target_state);
+
 	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
 	void (*subvp_pipe_control_lock)(struct dc *dc,
 			struct dc_state *context,
-- 
2.25.1

