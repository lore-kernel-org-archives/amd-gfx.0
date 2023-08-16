Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F901C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96E910E2D2;
	Wed, 16 Aug 2023 06:08:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE8110E2D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuWmf35rmaLrcyUtRrHbVSq+iMWElqVd4+uBw8jpZSXLVc3CZcLZF1roK05hjqS+QUsVVtBsDd8afzHiX1zA6wdGwJeU9+IuE4Rujaqdo6fpjEhPovSZ0lccyhPkjIpPqZQIs+bQnOnODaI1ey49jUZKgGIhP/nQl7A0TsliK/RqM+6COWGctPhWoh+3FeJ3gzXbxcgwY5CtUNuGTNgmIrJTraK0Kjoo/nByevM5xo6KBvTDQuJ3JMUh6Wr51aLEdk5VVsoAOGHp33vBQU9xi397SnxtKzc+xehp/ecE4nAL6OtLdYTuJuC7tJCQ9zfzHvwKK+BN/+2XfYzp6KzRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QId/HB+QXeXov2Nnr0dCp+CSEwygenTsQqDXk8zspXE=;
 b=bQNxePR6kCBoq/uRkM7da9H/JZU4yo8zpA99X1g1GaB2KFx/6BeTKQ1SbcyIz/0YUqKV3q2MirHtgRlqqsSaqJ6O5lKrCOQ8N8tcWFOVXMuGVmX8lG3xNK1FgtUfUSXLcboNmyWyo/OfShFPcou058Y0cIf6uxKQ1OKdMbppfCJgobssD2uCuMP2MQPlHqX35XRrqjGryldCFSdiN9BekYwRF5fEWLOLBMQtETSaZUegPQ5xzb1JytPwPBC0b8Ga/d6LziX4G/caucgqk/vpVj2pu2gZJfPsRhpmKBQxfPDp5eaBL7XU/5oT/xjXMG5OC/S8521Iv5rTx0yDXYWLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QId/HB+QXeXov2Nnr0dCp+CSEwygenTsQqDXk8zspXE=;
 b=QnvN4/Z3TN1kyUjHc7vI4RQOSs5RRMdnG1T7pJcvxw66rk2t36800cFj2fEeWPJ1rcGzUDlZ2uOIOPTuRL7edmqOIL0uvMEzk+AmrxG3HfA7kFpr6EsWCJCPTgoU+ogeqW/bv93LZS+h1a2dqdTwkow+sP33bkasaTrpIIvlx8k=
Received: from MW4PR04CA0101.namprd04.prod.outlook.com (2603:10b6:303:83::16)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 06:07:58 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::91) by MW4PR04CA0101.outlook.office365.com
 (2603:10b6:303:83::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 06:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 06:07:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:07:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:07:56 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:07:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: Refactor edp power control
Date: Wed, 16 Aug 2023 14:06:47 +0800
Message-ID: <20230816060658.2141009-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 549b86a6-e29b-499f-f63b-08db9e1f23db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIk6yLOhC94xjjPCtCTIzkNT2g/sIcHrrl5QaaAI6Oy+ZpEDTvlgz3AubprBTXtkN8c6+F6WBy3nhkNVPzfnRFJFL1iKWrDATGkPJOAokO8ENOIuH2PJbkxlJIat0Ni7COm7+TRtCKmrUOK+YncxUzqOtvskd6B49UrvZAU4Ft1L9He52ljAmw8YRWSDamOa5XqCm1i1iBdpm3mkesznRn3mYAUoGWP0U7Gwruj4T2rKVO65sXZ2Y2vnivEvhAPXhuUEY2LMF+ffcXLOIGLyICpqZ0Akoi61zDY9B5VtS5SHB8274nzdl8oedse88DG018djToza9aubxYfV8zHdXbzZwJDcN52dbidkV8D2DckUCtJWdXooXelK6sMnOmZdoeFRNlRVbdNNNcQkmpDwJT6CIOkEhKxW3jG4QQh/Mewx68Le7otynI+TmWbnl4bDW0zejw0nPs6V36I/hNhXyKPZs/hd2be3qHTWDCs9zS+nPGzZCIb061P6q6v1qzfT6YYvqGqmyvo+FOb8gmOB95mjwo2bGHux6OmavnrZ5rjbtohIHvTqYNX1F5rbiBy2mbrh/IMxPAQDMaIN9bIf3DKVAu1b9Dw70KSeh0PTOr+r6TV+dkkG49ypWRcuXYfm9cRd8MCu98GYZfCZXj+3l+Orm0J+x5o/81S3Ky7FFT7F/TIMyWgMyAiO1VqSXe/3X2ubZAchNsrpnAdMhgv6URyVQQH82a9YJiOSgHDFh1nqRnTOwWFKVznD6EsE5XyiP0IhAAWvfZHi15y6wCsg3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(30864003)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:07:58.4287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 549b86a6-e29b-499f-f63b-08db9e1f23db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

[Why & How]
To organize the edp power control a bit:

1. add flag in dc_link to indicate dc to skip all implicit eDP power control.
2. add edp_set_panel_power link service for DM to call.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |  2 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  3 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  1 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  9 +++---
 .../drm/amd/display/dc/link/link_factory.c    |  1 +
 .../display/dc/link/protocols/link_dp_phy.c   |  3 +-
 .../link/protocols/link_edp_panel_control.c   | 29 +++++++++++++++++++
 .../link/protocols/link_edp_panel_control.h   |  1 +
 11 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 65e1b8537ca6..cbef4190c1ea 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5211,3 +5211,24 @@ void dc_query_current_properties(struct dc *dc, struct dc_current_properties *pr
 	properties->cursor_size_limit = subvp_in_use ? 64 : dc->caps.max_cursor_size;
 }
 
+/**
+ *****************************************************************************
+ * dc_set_edp_power() - DM controls eDP power to be ON/OFF
+ *
+ * Called when DM wants to power on/off eDP.
+ *     Only work on links with flag skip_implict_edp_power_control is set.
+ *
+ *****************************************************************************
+ */
+void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
+				 bool powerOn)
+{
+	if (edp_link->connector_signal != SIGNAL_TYPE_EDP)
+		return;
+
+	if (edp_link->skip_implict_edp_power_control == false)
+		return;
+
+	edp_link->dc->link_srv->edp_set_panel_power(edp_link, powerOn);
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0d0bef8eb331..7cfb3ccef075 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1572,6 +1572,7 @@ struct dc_link {
 	struct phy_state phy_state;
 	// BW ALLOCATON USB4 ONLY
 	struct dc_dpia_bw_alloc dpia_bw_alloc_config;
+	bool skip_implict_edp_power_control;
 };
 
 /* Return an enumerated dc_link.
@@ -1591,6 +1592,9 @@ void dc_get_edp_links(const struct dc *dc,
 		struct dc_link **edp_links,
 		int *edp_num);
 
+void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
+				 bool powerOn);
+
 /* The function initiates detection handshake over the given link. It first
  * determines if there are display connections over the link. If so it initiates
  * detection protocols supported by the connected receiver device. The function
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 3697ea1d14c1..d5b3e3a32cc6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -302,7 +302,6 @@ struct dc_stream_state {
 	bool vblank_synchronized;
 	bool fpo_in_use;
 	struct mall_stream_config mall_stream_config;
-	bool skip_edp_power_down;
 };
 
 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index ad967b58d7be..d0b3e29fe83e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1221,7 +1221,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 	struct dce_hwseq *hws = link->dc->hwseq;
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-		if (!stream->skip_edp_power_down)
+		if (!link->skip_implict_edp_power_control)
 			hws->funcs.edp_backlight_control(link, false);
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 4d2820ffe468..33a8626bda73 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -476,7 +476,8 @@ void dcn314_disable_link_output(struct dc_link *link,
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 
 	if (signal == SIGNAL_TYPE_EDP &&
-			link->dc->hwss.edp_backlight_control)
+			link->dc->hwss.edp_backlight_control &&
+			!link->skip_implict_edp_power_control)
 		link->dc->hwss.edp_backlight_control(link, false);
 	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index e3e8c76c17cf..d7685368140a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -295,6 +295,7 @@ struct link_service {
 	bool (*edp_receiver_ready_T9)(struct dc_link *link);
 	bool (*edp_receiver_ready_T7)(struct dc_link *link);
 	bool (*edp_power_alpm_dpcd_enable)(struct dc_link *link, bool enable);
+	void (*edp_set_panel_power)(struct dc_link *link, bool powerOn);
 
 
 	/*************************** DP CTS ************************************/
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 79aef205598b..28cb1f5a504d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1930,7 +1930,8 @@ static void disable_link_dp(struct dc_link *link,
 	dp_disable_link_phy(link, link_res, signal);
 
 	if (link->connector_signal == SIGNAL_TYPE_EDP) {
-		if (!link->dc->config.edp_no_power_sequencing)
+		if (!link->dc->config.edp_no_power_sequencing &&
+			!link->skip_implict_edp_power_control)
 			link->dc->hwss.edp_power_control(link, false);
 	}
 
@@ -2219,7 +2220,7 @@ static enum dc_status enable_link(
 	 * link settings. Need to call disable first before enabling at
 	 * new link settings.
 	 */
-	if (link->link_status.link_active && !stream->skip_edp_power_down)
+	if (link->link_status.link_active)
 		disable_link(link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
 
 	switch (pipe_ctx->stream->signal) {
@@ -2338,9 +2339,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		dc->hwss.disable_stream(pipe_ctx);
 	} else {
 		dc->hwss.disable_stream(pipe_ctx);
-		if (!pipe_ctx->stream->skip_edp_power_down) {
-			disable_link(pipe_ctx->stream->link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
-		}
+		disable_link(pipe_ctx->stream->link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
 	}
 
 	if (pipe_ctx->stream->timing.flags.DSC) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 195ca9e52eda..11b5ac218154 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -223,6 +223,7 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 	link_srv->edp_receiver_ready_T9 = edp_receiver_ready_T9;
 	link_srv->edp_receiver_ready_T7 = edp_receiver_ready_T7;
 	link_srv->edp_power_alpm_dpcd_enable = edp_power_alpm_dpcd_enable;
+	link_srv->edp_set_panel_power = edp_set_panel_power;
 }
 
 /* link dp cts implements dp compliance test automation protocols and manual
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index b7abba55bc2f..0050e0a06cbc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -73,7 +73,8 @@ void dp_disable_link_phy(struct dc_link *link,
 {
 	struct dc  *dc = link->ctx->dc;
 
-	if (!link->wa_flags.dp_keep_receiver_powered)
+	if (!link->wa_flags.dp_keep_receiver_powered &&
+		!link->skip_implict_edp_power_control)
 		dpcd_write_rx_power_ctrl(link, false);
 
 	dc->hwss.disable_link_output(link, link_res, signal);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 98e715aa6d8e..24b47fa82f93 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -33,6 +33,7 @@
 #include "link_dp_capability.h"
 #include "dm_helpers.h"
 #include "dal_asic_id.h"
+#include "link_dp_phy.h"
 #include "dce/dmub_psr.h"
 #include "dc/dc_dmub_srv.h"
 #include "dce/dmub_replay.h"
@@ -362,6 +363,34 @@ void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd)
 		link->dc->hwss.edp_backlight_control(link, true);
 }
 
+void edp_set_panel_power(struct dc_link *link, bool powerOn)
+{
+	if (powerOn) {
+		// 1. panel VDD on
+		if (!link->dc->config.edp_no_power_sequencing)
+			link->dc->hwss.edp_power_control(link, true);
+		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
+
+		// 2. panel BL on
+		if (link->dc->hwss.edp_backlight_control)
+			link->dc->hwss.edp_backlight_control(link, true);
+
+		// 3. Rx power on
+		dpcd_write_rx_power_ctrl(link, true);
+	} else {
+		// 3. Rx power off
+		dpcd_write_rx_power_ctrl(link, false);
+
+		// 2. panel BL off
+		if (link->dc->hwss.edp_backlight_control)
+			link->dc->hwss.edp_backlight_control(link, false);
+
+		// 1. panel VDD off
+		if (!link->dc->config.edp_no_power_sequencing)
+			link->dc->hwss.edp_power_control(link, false);
+	}
+}
+
 bool edp_wait_for_t12(struct dc_link *link)
 {
 	if (link->connector_signal == SIGNAL_TYPE_EDP && link->dc->hwss.edp_wait_for_T12) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 0a5bbda8c739..20f91de852e3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -69,4 +69,5 @@ void edp_add_delay_for_T9(struct dc_link *link);
 bool edp_receiver_ready_T9(struct dc_link *link);
 bool edp_receiver_ready_T7(struct dc_link *link);
 bool edp_power_alpm_dpcd_enable(struct dc_link *link, bool enable);
+void edp_set_panel_power(struct dc_link *link, bool powerOn);
 #endif /* __DC_LINK_EDP_POWER_CONTROL_H__ */
-- 
2.37.3

