Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A177BECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B04310E80C;
	Wed, 14 Sep 2022 03:52:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 350F510E80B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDcQNnFIB8tigY20pzqbnxMqsX8WxbBFAiYkbFcPI5k8xom8QC3IfOkF2MeJPlbur3aDtQoSnWr/ADjKyudb6Kk7oWy44QTsqo45pJr6ogpNJX3bb98IN0YxD6VKwlH7dHt1ZVmmUlIUc9UiC1P1EuqUXeGeKGC+1EjbKg5+73Cm1JR8yfD9SVfepy7jR+u4A42vwQvW5wBsU0nNz0IFwetHYNl4yRNI/F7WkhC0rCFYfMhrgMFvzwEEcH85nhiSXUXxQ03ZhRnPXFa80INSR0gMQwCm4tZbE17mUUKeAVpIXGlKQtAYX6PYLxhjaHO1M6SIlG322xzQxJWhnQnSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqXMQIT2Hy0qNkSf6JCIuJisvsRmByP25zNJHTB3/kc=;
 b=nSfrNPfOU0cI1xMKGPJWehU9ABOmsHYPbbeWvq2oW5jnM86WLPAb2LP9D2j2i0K2R80jipUafGmLRIBFVBUS0hJFI13Dt+YpJH1jarOnueTDW1X8TzzqHMpEP8Jbpl79kZqZWwnNpWsUw5zYjCntHsUdZoF0EerzuzD82CHvT24VRw29cpgaKI42/SFzHjtdUOKfGog95R2nTAQTQ7T1k96i4DpGcuTbxmt6lictQkNzFLPXt2JvMlbq+2fvStmjWT2Vaq9DEIAQq5v3o5yN7BzF4O5sIEf1Sn+RT44L6tXYF5yCMM+MX8ZXDY6glGQQx2Q80Ze/C/DpZvjTfQ7sAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqXMQIT2Hy0qNkSf6JCIuJisvsRmByP25zNJHTB3/kc=;
 b=L+uaggDqL3HqKVn2tQsqM91C0GdJVp/Mwsv8ou75NZ7D2fckm0H0aAR6WsYvS8xW4ziJJ4ZbOq1BCJBKbEIPw/pelpYgvcy16PzMikXyQTTb+qDKhzYI9vWbxi+5OurxQ1GLBRom5DTRxhrEk9Lw9ciLvJs17U7tDJ0klV6kEgc=
Received: from DM6PR06CA0043.namprd06.prod.outlook.com (2603:10b6:5:54::20) by
 IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 14 Sep
 2022 03:52:27 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:54:cafe::14) by DM6PR06CA0043.outlook.office365.com
 (2603:10b6:5:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 03:52:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:52:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:51:55 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:51:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 19/47] drm/amd/display: Refactor edp panel power
 sequencer(PPS) codes
Date: Wed, 14 Sep 2022 11:47:40 +0800
Message-ID: <20220914034808.1093521-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 619f976e-5698-42a8-7cdf-08da96048a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ez4wcL/YhAXWQdnxAtuc4S6qlokU6ppqeVw9Uq+BMShGEATaXs+0MNblE5S96G67J1+t9qxrtx2hxFNfqnpejLDlbHaXnhMmzETa4oFQqifNxrTvmWFPUuDqFsZ08qOr8MlEP/LHpv9SDvqASBTElb4Di9gCydZRQxMEXNAtOF135YIpPevvDXLG4NxYC9uvVd4BxQr03W5sM24Tsqd4FahTEnc5GMcYEWgnJIcWxsIA+Or4JzacN4OOtgyRB0rExF2qecaSn1HsBu0YW0LP73e+DsHvMISktKz4fFBAY+d2U6nud7Ntqxkt3lAqgEMKalbtw6ZkGUxX/tW2M2aMkE/3h0qPAupXanVfRuEzYByW7xxq8JUf8rS2s8RWJ7x6W4VaSrYIF+WAnbIgVaHqkzyG2mLOmA6GEbsXSfgD8GQXwerX6rpurje//ZMPMUw1Z/S9IN4xZuyizbRaO7SZ7ISxCzk02tR/Kl3zL6OdTbE8fowuyoAnGvQJftHYNVkNi9NK+1fJP93ZwK2RXC0ghLaQrsKrfGGnpSpugXHnCt4/v+0tSuoRHkVLTf/hA4HA/CGvuSdGpwTKskrR0b9M3urY0OAivHsevmBWuv+iGvfyc6kdnNILDhcGqCLYNa3fVzJHwfqkYXneWkxycb5jaTBpG/hctwlj+aavu8y+6wlcg4VBkA82hD14C9JfSPtLSgWaprzkyv1gRA60K5EIMa4L8lVZ0BCesA87I949Xg4GIReJXaI8ScGtxG62UebslPMjPTtPY9iylHD/4WRRXP/le8TPFMo+0BjgvH1192OF+RKum0H7z47loAh72BDO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(70586007)(5660300002)(336012)(6916009)(36860700001)(8676002)(81166007)(47076005)(478600001)(6666004)(40460700003)(54906003)(2906002)(70206006)(356005)(2616005)(4326008)(1076003)(40480700001)(82310400005)(83380400001)(8936002)(82740400003)(426003)(26005)(36756003)(316002)(41300700001)(7696005)(186003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:52:27.3161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 619f976e-5698-42a8-7cdf-08da96048a83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
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

