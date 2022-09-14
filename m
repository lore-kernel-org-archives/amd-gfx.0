Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC6AECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529EE10E83F;
	Wed, 14 Sep 2022 05:15:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92C410E83D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKktDHHUkY5iMcCIufT37PER2FgXhOx1M2Lic2ix+SXwu9+tQYClV/qIOWcaKXIyoenghnXddkmQfQWg47wWQVg/B6A/iEAuGLSm2XKp8Y6N37qXbkYxw9LGVUILCGqXZA+QKROUAzibTPWicl0kxd34Y6SuAv3ORT1K5aLjvXJt1COzMxeK0cUozv7oaoYDMlI5gWF7SBWWoKmaD3a04W9+0SkLoETXDEG9ofBvDYrsq4m6ZyElb9khM4NZMeOsgml6rF3Pa9K2Q5w2SmNLLfAWltRsWDVPhGJhBaoJby+T7kBX5dB7a3CLnZcU89p7bC0QhRTYbn4aI1RX71uKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqXMQIT2Hy0qNkSf6JCIuJisvsRmByP25zNJHTB3/kc=;
 b=XmMKD4bwPtlzMpnGvXBOD3pX86G/jKj05ZQ8dKIxMCdhZURrU8q7jdF1apnMF6BJQ8SNOPq+6xbum7LBfcoLaxrMlqgTYHtE3yBBtzgj30vu2TXOX8hmx6V3pVoOOl5knAx3FSSE7julnLnnu6ovf429Ay79ydxGALYpRhu14Cs4JKtrdofEonCl9fA1zyifJhQUXa11cFFukKffYRBlaXhxKCzm3m0j6juit8ql4ahjB3U+D6ZGGEh2xHlnvRTm7h6BvrUK1l10fYTr4Z/w1DNZSPRJ5KdHwghb5o3z2n0p7evN3PWLJ9PxhZqwJAnaa3KPvYBd4dPF2SftjNwpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqXMQIT2Hy0qNkSf6JCIuJisvsRmByP25zNJHTB3/kc=;
 b=MXelZt/qFAwiWLTnvYM90ASYcf6f8YJCx/Aq/BiwEJHiE+YEt8rPpEbhlePHo7ZS6Wj0NElp1W0H2gZtR3jzdzrJuT7np2JjRzXx5z0uV8m5vgFCt05mB7x6HMDe9/tILzVHnGnk8uLhIRLIyYgDoGztx7/OEmxu+mu3v8e5XmM=
Received: from MW4PR04CA0207.namprd04.prod.outlook.com (2603:10b6:303:86::32)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 14 Sep
 2022 05:15:42 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::8) by MW4PR04CA0207.outlook.office365.com
 (2603:10b6:303:86::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:42 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:15:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:14:38 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:14:33 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 19/47] drm/amd/display: Refactor edp panel power
 sequencer(PPS) codes
Date: Wed, 14 Sep 2022 13:10:18 +0800
Message-ID: <20220914051046.1131186-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: e895a988-1d0c-421a-3c53-08da96102bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sImnHfrmbEv9bRkpDSQQobJKATTIChmMkwgGaSteDp9MJR2Gc2i1KTVXNuzJ+eZGA3uEx2kOI14hENZ73Ei5yww55/KcGxL9crzLLPrAPKdTF8EBlaeNEyvLBt8h1PYOTq46ZkZdDoyhZTfllOb1Ra6NuMAPEcwkRXK9QUlg340oaBAz5WSF2M+7I+jNXvIm/J5ZJdnDaS93CRw8YZ7shr7l6l4LOuXNe1irG3tyCJGtW3GGsHDDCKa1ABJCW3P2KazJPxMfipE0+CoABrjI4yf+daHa560ejbcxwf5zbJz0dBPaF2NtvFwD3s9t4Z1GI62hJJEhJMBwX79NTjWiLNf/+vhuZvb54wbP9OW3d3bYm/hBiFDWGDopHRTqWFpkjoezhKX89a7LewUTS2TsXBRGLbA8H0H1bfddr2h+DMrJ9YmLYo/puG5fza+Kqk/2mkG/DyobPvJKIjdMYyJ/7hTIs08arJkIuHXzPiY6TEcO2DFacwj/0znnX+VjNHuEuaPg+JXuQOTGz+2W/rm4TSlGxP1MlUKNKTgZ9ZitS3UZfYtWt/PnW6Onn+z3ZxWit5dNNeiTw7rZLBKAH0mqlR4ap3LVQAwG6uxDwWojJjUMurLGnS6fdoimjQc0cE8qMXYUcpL2HdVmq/ghjUPANRaCGoIriXQTnhjboxBkuY3QWPU3hPVdmkdlFofEhsiqbC5ut+ccBnysDJS6zEMmDIOxuyJvI6nfbzWCSRset9Ft0hsajRWT5jGx1yahQ0xrBnYnfUlVb6aQD6AC8O2BcS13ada62THAAAaAVFgBFFkmiZgruOSTWUAJfxrsghn1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(5660300002)(356005)(8936002)(2616005)(70586007)(7696005)(316002)(40460700003)(82740400003)(83380400001)(6916009)(26005)(40480700001)(36756003)(336012)(8676002)(41300700001)(54906003)(82310400005)(1076003)(4326008)(6666004)(81166007)(86362001)(478600001)(70206006)(47076005)(186003)(2906002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:42.2788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e895a988-1d0c-421a-3c53-08da96102bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
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
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

[Why & How]
Move extra panel power sequencer settings into panel_cofig struct.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 11 +++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  8 +++---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 10 +++-----
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 10 ++++++++
 .../display/dc/dce110/dce110_hw_sequencer.c   | 25 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  3 ++-
 6 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 0b7440b92c10..4956a0118215 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -918,8 +918,17 @@ void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigne
 
 void dm_helpers_init_panel_settings(
 	struct dc_context *ctx,
-	struct dc_panel_config *panel_config)
+	struct dc_panel_config *panel_config,
+	struct dc_sink *sink)
 {
+	// Extra Panel Power Sequence
+	panel_config->pps.extra_t3_ms = sink->edid_caps.panel_patch.extra_t3_ms;
+	panel_config->pps.extra_t7_ms = sink->edid_caps.panel_patch.extra_t7_ms;
+	panel_config->pps.extra_delay_backlight_off = sink->edid_caps.panel_patch.extra_delay_backlight_off;
+	panel_config->pps.extra_post_t7_ms = 0;
+	panel_config->pps.extra_pre_t11_ms = 0;
+	panel_config->pps.extra_t12_ms = sink->edid_caps.panel_patch.extra_t12_ms;
+	panel_config->pps.extra_post_OUI_ms = 0;
 	// Feature DSC
 	panel_config->dsc.disable_dsc_edp = false;
 	panel_config->dsc.force_dsc_edp_policy = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 4fb57d4041a0..3529be5888c8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1308,7 +1308,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 
 		if (link->connector_signal == SIGNAL_TYPE_EDP) {
 			// Init dc_panel_config
-			dm_helpers_init_panel_settings(dc_ctx, &link->panel_config);
+			dm_helpers_init_panel_settings(dc_ctx, &link->panel_config, sink);
 			// Override dc_panel_config if system has specific settings
 			dm_helpers_override_panel_settings(dc_ctx, &link->panel_config);
 		}
@@ -1977,7 +1977,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	int i;
 	bool apply_seamless_boot_optimization = false;
 	uint32_t bl_oled_enable_delay = 50; // in ms
-	const uint32_t post_oui_delay = 30; // 30ms
+	uint32_t post_oui_delay = 30; // 30ms
 	/* Reduce link bandwidth between failed link training attempts. */
 	bool do_fallback = false;
 
@@ -2024,8 +2024,10 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 
 	// during mode switch we do DP_SET_POWER off then on, and OUI is lost
 	dpcd_set_source_specific_data(link);
-	if (link->dpcd_sink_ext_caps.raw != 0)
+	if (link->dpcd_sink_ext_caps.raw != 0) {
+		post_oui_delay += link->panel_config.pps.extra_post_OUI_ms;
 		msleep(post_oui_delay);
+	}
 
 	// similarly, mode switch can cause loss of cable ID
 	dpcd_write_cable_id_to_dprx(link);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index eea6ec0a76b4..f317e48c2721 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -7075,9 +7075,8 @@ void dp_enable_link_phy(
 
 void edp_add_delay_for_T9(struct dc_link *link)
 {
-	if (link->local_sink &&
-			link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off > 0)
-		udelay(link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off * 1000);
+	if (link && link->panel_config.pps.extra_delay_backlight_off > 0)
+		udelay(link->panel_config.pps.extra_delay_backlight_off * 1000);
 }
 
 bool edp_receiver_ready_T9(struct dc_link *link)
@@ -7133,9 +7132,8 @@ bool edp_receiver_ready_T7(struct dc_link *link)
 		} while (time_taken_in_ns < 50 * 1000000); //MAx T7 is 50ms
 	}
 
-	if (link->local_sink &&
-			link->local_sink->edid_caps.panel_patch.extra_t7_ms > 0)
-		udelay(link->local_sink->edid_caps.panel_patch.extra_t7_ms * 1000);
+	if (link && link->panel_config.pps.extra_t7_ms > 0)
+		udelay(link->panel_config.pps.extra_t7_ms * 1000);
 
 	return result;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 4d9819d9ffb6..d890a03910c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -117,6 +117,16 @@ struct psr_settings {
  * Add a struct dc_panel_config under dc_link
  */
 struct dc_panel_config {
+	// extra panel power sequence parameters
+	struct pps {
+		unsigned int extra_t3_ms;
+		unsigned int extra_t7_ms;
+		unsigned int extra_delay_backlight_off;
+		unsigned int extra_post_t7_ms;
+		unsigned int extra_pre_t11_ms;
+		unsigned int extra_t12_ms;
+		unsigned int extra_post_OUI_ms;
+	} pps;
 	// edp DSC
 	struct dsc {
 		bool disable_dsc_edp;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 8ffb13847ae0..70ac0b31baba 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -722,7 +722,6 @@ void dce110_edp_wait_for_hpd_ready(
 	struct dc_context *ctx = link->ctx;
 	struct graphics_object_id connector = link->link_enc->connector;
 	struct gpio *hpd;
-	struct dc_sink *sink = link->local_sink;
 	bool edp_hpd_high = false;
 	uint32_t time_elapsed = 0;
 	uint32_t timeout = power_up ?
@@ -755,9 +754,9 @@ void dce110_edp_wait_for_hpd_ready(
 		return;
 	}
 
-	if (sink != NULL) {
-		if (sink->edid_caps.panel_patch.extra_t3_ms > 0) {
-			int extra_t3_in_ms = sink->edid_caps.panel_patch.extra_t3_ms;
+	if (link != NULL) {
+		if (link->panel_config.pps.extra_t3_ms > 0) {
+			int extra_t3_in_ms = link->panel_config.pps.extra_t3_ms;
 
 			msleep(extra_t3_in_ms);
 		}
@@ -842,7 +841,7 @@ void dce110_edp_power_control(
 			/* add time defined by a patch, if any (usually patch extra_t12_ms is 0) */
 			if (link->local_sink != NULL)
 				remaining_min_edp_poweroff_time_ms +=
-					link->local_sink->edid_caps.panel_patch.extra_t12_ms;
+					link->panel_config.pps.extra_t12_ms;
 
 			/* Adjust remaining_min_edp_poweroff_time_ms if this is not the first time. */
 			if (dp_trace_get_edp_poweroff_timestamp(link) != 0) {
@@ -946,7 +945,7 @@ void dce110_edp_wait_for_T12(
 						current_ts,
 						dp_trace_get_edp_poweroff_timestamp(link)), 1000000);
 
-		t12_duration += link->local_sink->edid_caps.panel_patch.extra_t12_ms; // Add extra T12
+		t12_duration += link->panel_config.pps.extra_t12_ms; // Add extra T12
 
 		if (time_since_edp_poweroff_ms < t12_duration)
 			msleep(t12_duration - time_since_edp_poweroff_ms);
@@ -965,6 +964,8 @@ void dce110_edp_backlight_control(
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
 	uint8_t panel_instance;
+	unsigned int pre_T11_delay = OLED_PRE_T11_DELAY;
+	unsigned int post_T7_delay = OLED_POST_T7_DELAY;
 
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
 		!= CONNECTOR_ID_EDP) {
@@ -1043,8 +1044,10 @@ void dce110_edp_backlight_control(
 
 	link_transmitter_control(ctx->dc_bios, &cntl);
 
-	if (enable && link->dpcd_sink_ext_caps.bits.oled)
-		msleep(OLED_POST_T7_DELAY);
+	if (enable && link->dpcd_sink_ext_caps.bits.oled) {
+		post_T7_delay += link->panel_config.pps.extra_post_t7_ms;
+		msleep(post_T7_delay);
+	}
 
 	if (link->dpcd_sink_ext_caps.bits.oled ||
 		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
@@ -1066,8 +1069,10 @@ void dce110_edp_backlight_control(
 			DC_LOG_DC("edp_receiver_ready_T9 skipped\n");
 	}
 
-	if (!enable && link->dpcd_sink_ext_caps.bits.oled)
-		msleep(OLED_PRE_T11_DELAY);
+	if (!enable && link->dpcd_sink_ext_caps.bits.oled) {
+		pre_T11_delay += link->panel_config.pps.extra_pre_t11_ms;
+		msleep(pre_T11_delay);
+	}
 }
 
 void dce110_enable_audio_stream(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 6e4d3df0454e..6abbed22bb20 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -173,7 +173,8 @@ void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigne
 	(result == 0x0)
 void dm_helpers_init_panel_settings(
 	struct dc_context *ctx,
-	struct dc_panel_config *config);
+	struct dc_panel_config *config,
+	struct dc_sink *sink);
 void dm_helpers_override_panel_settings(
 	struct dc_context *ctx,
 	struct dc_panel_config *config);
-- 
2.37.3

