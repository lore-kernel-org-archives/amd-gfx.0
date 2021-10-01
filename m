Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E477C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F069B61A0A
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F069B61A0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F5916ED91;
	Fri,  1 Oct 2021 14:42:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA9ED6ED8E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeW0jM9m1UJ1rdapZad3DT920g0dWWKV1TtiE1Y6NfGfVu++pdwMOLEoRkmPrY70U3EFIJmSrswY41uTAIx3g/XLvIx8AamGHyu+V8W48IotQxl/PJQIwj8eOPUg4y5OCx3T1FOcBzhTLR9bxA6dIIEUjzYrPwxSzMadWg3EfXob2Jtdks6IjfSOpzIdH36hvIGUZB+11V9z4inY2q1Tbyc435SwYjomnSuYmTw/aAWIi2LLyFezlYcxs/lh/uzYaurFd7HXKrVyOKD176H5WK+WxG/yAPgU4SYMuNsH2U2Zc7OGwnryZ2vsd8AkbFiDYZs32s9O0lgN27DtLLgWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpRu2zoEwka/i4Wuzcm1Z2zz8zXgmnR2BgI3Mn/lSDU=;
 b=azOxrn4lvVteKyS1UzcxMZW9FcsnLdjVKGsa56CTiVXJQiBet/7lsznUZSZlqR6MFOAJMtvprEzfTo1SHEq/mwaFOg+8w9KQtFOhfEYBNI9YlmL3imjAJsQKdkAqikvTUIfd2A/D59eVBAXbOvAFPXdo7N3sYItQK9gNZqZHcYWCNQLudwKnhXQtVFWFekbOnPbU8YgsWqXP/kZO3HDXUbvEnzR+FKxZAgD0ABexMFAcnBON9bYsEDnDO1Hvm9BkbK8BnMvANxqfTeThWvVYpz7ARRar5PY/b2wt36UkWAikJYxpwg511G2gs5OBNeUCQJ3dqFTan5Ye3plqawPT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpRu2zoEwka/i4Wuzcm1Z2zz8zXgmnR2BgI3Mn/lSDU=;
 b=FsZFRy+KIYBLvUsfyMx6adp8mYjtFoW9W4aqDRTIyk713bxo5DVtTbENvLs7Cj6Vb3xduVbwNnCN1U+Y2358FxdIRR43p01aBxGW5h9yHKlyKSrOUahrGLUK2rUquNemDMflVKVp94pHrf5G0r+/AqPY+QopsqrT+DxXZhH33EU=
Received: from MWHPR18CA0065.namprd18.prod.outlook.com (2603:10b6:300:39::27)
 by BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Fri, 1 Oct
 2021 14:41:56 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::c5) by MWHPR18CA0065.outlook.office365.com
 (2603:10b6:300:39::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Fri, 1 Oct 2021 14:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:41:56 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:41:51 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, "Leo (Hanghong) Ma"
 <hanghong.ma@amd.com>, Aric Cyr <Aric.Cyr@amd.com>
Subject: [PATCH 12/14] drm/amd/display: Add helper for blanking all dp displays
Date: Fri, 1 Oct 2021 22:36:18 +0800
Message-ID: <20211001143620.192679-13-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f96a2f9d-4f62-4a71-a451-08d984e99e07
X-MS-TrafficTypeDiagnostic: BL0PR12MB5011:
X-Microsoft-Antispam-PRVS: <BL0PR12MB50118E1B93CF9BCBC09BD60797AB9@BL0PR12MB5011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRlFRpOs4h6z2PM6Ry2IqlzRaQbKYB+mW60IEi1Qyba9dvTOlNYRY7SRh3bnVYBOs3p03teR4hR71cQ/PviZ5hHOE4HImuqIiY+Gv3Si2mRP18vo1nWhYK0X5otpKmK1k/M8D/o0tUNuTr2IeT28AfgxG13BNRa5JxyvMMDiO+MTh4GY4wqYA0S3za4XTW1UWtoOr6r246uDQ5EGQHpLNvlV3vyji00cJrTwWdUGg1KWz4Pw5oGBdUY6Tt1OsYYc/fRdRbYqaSLerIUf7MJgJ9TIMkPjD2WPkdegs2ZE7vzAVPlRdwpA5y7Zyi+71usOM7pbrZXm3FYwJ1lhjnMMPXbQqpmkPEaWbiQ1s7SEpyhXpW7A18mfM13GMwRbID/QytJ1ZkaSTF92to0/eojAtlOexGlU4PFOjvYvn54oToOLX19n3uRmuVIczyGIltPDiO6vf17wffMkfNgedE6EYkZMFhydCVf0u5JkyuIlboxoP6GUwU1vC8exbs01ARbXXiwPqR515Dqruj9hVewkft8GrxwnrdoO2FI1ZhAGZ2SctwTZ7hhUN3xk9+jAX3Fhozik5VwjADLrSTJdorAsAA1EmAMTP1rJdeaztYrXnHqIQoWxbAI0+Oe8MqvJXsXsIw2oBmkRYe2v359WJ0jRy1JnJ8gdpElLvENn2SpkZDcQS5ub8PpGiKMd15epmlomzpOTr63b6uNMImamkzbW+4rTVrUhzH95BmcdP1DCDGs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(2616005)(6916009)(44832011)(30864003)(8936002)(4326008)(7696005)(186003)(16526019)(83380400001)(86362001)(508600001)(316002)(47076005)(36756003)(54906003)(5660300002)(1076003)(426003)(6666004)(36860700001)(8676002)(70586007)(2906002)(81166007)(70206006)(336012)(356005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:41:56.1663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f96a2f9d-4f62-4a71-a451-08d984e99e07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5011
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

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why & How]
The codes to blank all dp display have been called many times,
so add a helper in dc_link to make it more concise.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 45 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   | 24 ++--------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 41 ++---------------
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 39 ++--------------
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 39 ++--------------
 6 files changed, 59 insertions(+), 130 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 02c7a18c095f..74da226efffe 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1906,6 +1906,51 @@ static enum dc_status enable_link_dp_mst(
 	return enable_link_dp(state, pipe_ctx);
 }
 
+void blank_all_dp_displays(struct dc *dc, bool hw_init)
+{
+	unsigned int i, j, fe;
+	uint8_t dpcd_power_state = '\0';
+	enum dc_status status = DC_ERROR_UNEXPECTED;
+
+	for (i = 0; i < dc->link_count; i++) {
+		enum signal_type signal = dc->links[i]->connector_signal;
+
+		if ((signal == SIGNAL_TYPE_EDP) ||
+			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
+			if (hw_init && signal != SIGNAL_TYPE_EDP) {
+				/* DP 2.0 spec requires that we read LTTPR caps first */
+				dp_retrieve_lttpr_cap(dc->links[i]);
+				/* if any of the displays are lit up turn them off */
+				status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
+							&dpcd_power_state, sizeof(dpcd_power_state));
+			}
+
+			if ((signal != SIGNAL_TYPE_EDP && status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) ||
+				(!hw_init && dc->links[i]->link_enc->funcs->is_dig_enabled(dc->links[i]->link_enc))) {
+				if (dc->links[i]->ep_type == DISPLAY_ENDPOINT_PHY &&
+						dc->links[i]->link_enc->funcs->get_dig_frontend) {
+					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
+					if (fe == ENGINE_ID_UNKNOWN)
+						continue;
+
+					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+						if (fe == dc->res_pool->stream_enc[j]->id) {
+							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
+									dc->res_pool->stream_enc[j]);
+							break;
+						}
+					}
+				}
+
+				if (!dc->links[i]->wa_flags.dp_keep_receiver_powered ||
+					(hw_init && signal != SIGNAL_TYPE_EDP))
+					dp_receiver_power_ctrl(dc->links[i], false);
+			}
+		}
+	}
+
+}
+
 static bool get_ext_hdmi_settings(struct pipe_ctx *pipe_ctx,
 		enum engine_id eng_id,
 		struct ext_hdmi_settings *settings)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index a73d64b1fd33..69b008bafbbc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -277,6 +277,7 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
 		struct psr_context *psr_context);
 
 void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency);
+void blank_all_dp_displays(struct dc *dc, bool hw_init);
 
 /* Request DC to detect if there is a Panel connected.
  * boot - If this call is during initial boot.
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index af3e68d3e747..8108f9ae2638 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1649,31 +1649,13 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 
 static void power_down_encoders(struct dc *dc)
 {
-	int i, j;
+	int i;
+
+	blank_all_dp_displays(dc, false);
 
 	for (i = 0; i < dc->link_count; i++) {
 		enum signal_type signal = dc->links[i]->connector_signal;
 
-		if ((signal == SIGNAL_TYPE_EDP) ||
-			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
-			if (dc->links[i]->link_enc->funcs->get_dig_frontend &&
-				dc->links[i]->link_enc->funcs->is_dig_enabled(dc->links[i]->link_enc)) {
-				unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
-									dc->links[i]->link_enc);
-
-				for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-					if (fe == dc->res_pool->stream_enc[j]->id) {
-						dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-									dc->res_pool->stream_enc[j]);
-						break;
-					}
-				}
-			}
-
-			if (!dc->links[i]->wa_flags.dp_keep_receiver_powered)
-				dp_receiver_power_ctrl(dc->links[i], false);
-		}
-
 		if (signal != SIGNAL_TYPE_EDP)
 			signal = SIGNAL_TYPE_NONE;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c5e2b4f138fd..bc3ec05bf34b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1366,7 +1366,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 
 void dcn10_init_hw(struct dc *dc)
 {
-	int i, j;
+	int i;
 	struct abm *abm = dc->res_pool->abm;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dce_hwseq *hws = dc->hwseq;
@@ -1462,43 +1462,8 @@ void dcn10_init_hw(struct dc *dc)
 		dmub_enable_outbox_notification(dc);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot) {
-		uint8_t dpcd_power_state = '\0';
-		enum dc_status status = DC_ERROR_UNEXPECTED;
-
-		for (i = 0; i < dc->link_count; i++) {
-			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
-				continue;
-
-			/* DP 2.0 requires that LTTPR Caps be read first */
-			dp_retrieve_lttpr_cap(dc->links[i]);
-
-			/*
-			 * If any of the displays are lit up turn them off.
-			 * The reason is that some MST hubs cannot be turned off
-			 * completely until we tell them to do so.
-			 * If not turned off, then displays connected to MST hub
-			 * won't light up.
-			 */
-			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
-							&dpcd_power_state, sizeof(dpcd_power_state));
-			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
-				/* blank dp stream before power off receiver*/
-				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
-					unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
-
-					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-										dc->res_pool->stream_enc[j]);
-							break;
-						}
-					}
-				}
-				dp_receiver_power_ctrl(dc->links[i], false);
-			}
-		}
-	}
+	if (dc->config.power_down_display_on_boot)
+		blank_all_dp_displays(dc, true);
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index b132ebed09d4..01a90badd173 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -437,7 +437,7 @@ void dcn30_init_hw(struct dc *dc)
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
-	int i, j;
+	int i;
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 
@@ -534,41 +534,8 @@ void dcn30_init_hw(struct dc *dc)
 			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot) {
-		uint8_t dpcd_power_state = '\0';
-		enum dc_status status = DC_ERROR_UNEXPECTED;
-
-		for (i = 0; i < dc->link_count; i++) {
-			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
-				continue;
-			/* DP 2.0 states that LTTPR regs must be read first */
-			dp_retrieve_lttpr_cap(dc->links[i]);
-
-			/* if any of the displays are lit up turn them off */
-			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
-						     &dpcd_power_state, sizeof(dpcd_power_state));
-			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
-				/* blank dp stream before power off receiver*/
-				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
-					unsigned int fe;
-
-					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
-										dc->links[i]->link_enc);
-					if (fe == ENGINE_ID_UNKNOWN)
-						continue;
-
-					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-										dc->res_pool->stream_enc[j]);
-							break;
-						}
-					}
-				}
-				dp_receiver_power_ctrl(dc->links[i], false);
-			}
-		}
-	}
+	if (dc->config.power_down_display_on_boot)
+		blank_all_dp_displays(dc, true);
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 0713910a3aa9..80f06ceccea8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -71,7 +71,7 @@ void dcn31_init_hw(struct dc *dc)
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
-	int i, j;
+	int i;
 	int edp_num;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
@@ -175,40 +175,9 @@ void dcn31_init_hw(struct dc *dc)
 			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot) {
-		uint8_t dpcd_power_state = '\0';
-		enum dc_status status = DC_ERROR_UNEXPECTED;
-
-		for (i = 0; i < dc->link_count; i++) {
-			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
-				continue;
-
-			/* if any of the displays are lit up turn them off */
-			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
-						     &dpcd_power_state, sizeof(dpcd_power_state));
-			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
-				/* blank dp stream before power off receiver*/
-				if (dc->links[i]->ep_type == DISPLAY_ENDPOINT_PHY &&
-						dc->links[i]->link_enc->funcs->get_dig_frontend) {
-					unsigned int fe;
-
-					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
-										dc->links[i]->link_enc);
-					if (fe == ENGINE_ID_UNKNOWN)
-						continue;
-
-					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-										dc->res_pool->stream_enc[j]);
-							break;
-						}
-					}
-				}
-				dp_receiver_power_ctrl(dc->links[i], false);
-			}
-		}
-	}
+	if (dc->config.power_down_display_on_boot)
+		blank_all_dp_displays(dc, true);
+
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
-- 
2.25.1

