Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BB6CCA47B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28DC610E23B;
	Fri,  8 Jul 2022 16:36:52 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1538810E23B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vss92lofh8CswTUc/DeCzSheMhTmSaV8/zT3xSvga86eijJsz7NGZ/wiuwhn1k1Vy+HXYnDxuJDIrrJYYnXEa4VAF6SXT8H3P6tXQt9f0BYok+t/oUJUDAd/zaMpi/2RteYrBi+K7ZtPqcbFl38OvfpBTuym9HQQFpkryd+nfSIoeOSOfSugHIZhTvYh6zUvvkKBdv5Xs8Gaj9U/pl6QoKYmKA8PkkttxouLGRbhC1kdw3Z4ApuL+7MpNV0Z9rUE3qfFOuM0SLzz+P5c27ngjZe2thCtWDc+idFRR1c6SPfSFdVSfm8kTiYVIhrKKm3UPrZCbJA0n42rgE6OgyygxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmEXO+DGOq2ToS6K3Z3QRjnXnpRuRWctOPBluXhYdIY=;
 b=XE6z0FH2iykVJg3Zj1mHhsslkdN87rK4IpPR9wu0IN+fkmtcnQcEiVmkD85/Tm8Kv40ltc7xnwc0LTYEhNHN2j7Uq6UohZAWzY7aVPfvS0c1DioWc50bukwrp3DnI3YIShWmt80BFQjw2MZneAA4oky4nKCMS1ol+Ua9Ubxmb/7UGqAsKxZnu/qkoCSE7OQElycY4hrbWMLxTvyDSZA48xoD81a59tH8psHepBU5/GnK3JHmehUEG1gpew2ZNqcSODUYEBIg42J3dp4S2ZMA/BtRf5Bgc32vPszORsBtjWKPvqnTg35En3LpsqvtsEVfGGySujBxrgz7BOa3ZguuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmEXO+DGOq2ToS6K3Z3QRjnXnpRuRWctOPBluXhYdIY=;
 b=g4Ha8yTyRsQAja5LyOZvk2T01UjvvuzJ7oO7XeZp40S9QGsxRQEW0xsJEij68U5NJD2v/8+/ughOg2IY8pmxZYw6sMsiAyKvMr40KdirPvFUluO4cNhGGZAbywT4C4J2Se8Q0s3j5mB9VkEztcrTInq1hTNsy1EcJjKzCzQVBCA=
Received: from BN0PR04CA0087.namprd04.prod.outlook.com (2603:10b6:408:ea::32)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 16:36:46 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::a6) by BN0PR04CA0087.outlook.office365.com
 (2603:10b6:408:ea::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 16:36:45 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:41 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/21] drm/amd/display: make enable link independent from
 verified link caps
Date: Sat, 9 Jul 2022 00:35:17 +0800
Message-ID: <20220708163529.3534276-10-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5af875cc-c868-43db-222a-08da61000c4a
X-MS-TrafficTypeDiagnostic: MW3PR12MB4427:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1yLWjnA2QCxG5jp4HyiDYqWpJfJCUqkdqqED790hz79IGSxMyUElO5LV4vny49ko7c9DUGqHl2sLFZHzCGRMkuJHXwjAHyrotqhb5Po3G/yjcirEb9QwBZ09w7xgY9ZwiP45ULD57MGZtZOs2buEXB+XPpnbAIIZb3UwobSKM+KYonCDYA9ZHQuyLnZQIp2VkptIeApSTKE72k/3fGH9BsWCQbiXi55zbfDgSxGKpioFImPNlK97RsJzhZ8/FuB4rM3FBJ7fIPx42zCo7Evf0qnhAlvx4/k/KpFAMqHi+DUmNQDfQnJoP3rvy/8rmA2eK8GGrTZ4zvTmzy2K6r3sdga3f0ULZC4KdaC46zVOG5Iz6ZLL8ULbmJWML0q90usbh+yi/rRwMHdDLsRcHtU96BoOQx5AlUVge+yI/FqIU520hVOQrNCx1DAfoNomgKu5MG9hh1bU2sOS2eseebu+kkNYN9GRA7bw0L/2UMr8zm4bhDJSzkWEEOjVPdRdrZCpMSRk+2SjXjf9rW2fPUFCLI3/z0wSkDifWu+22EVDNH/3IRtRXvcmwBGu/0VqdotKg56McupwWyLf1RRsUKxVhIGBa27JRUzN8KjlxNFkQ1B1kEsP8qUnFx0MUA+Zj6FB8V0kBQ1r1Mp/BXX1jRXfir39JTx1GRDbKrN0q9EvxiqMsj2xjLr/CnhSB6YylYvAwd8kLDlm6XlhpteBpT9dpYdToehcBKgnsoFE/f9CruYa1+xgeKN+wTHLCl188qFuPyfYSgkatj0Zr7+/cp6gn2mFcbIoGGXOUpgSZOkYIKVkL4sCISPE6ucQmAWBnGfHAo9XpQQLxeDKlaumhL98HysOJEBSZhciRGauV991cVA53KKzUtG1Mxhb8aZs11Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(40470700004)(46966006)(36840700001)(70586007)(5660300002)(86362001)(70206006)(4326008)(16526019)(44832011)(7696005)(8676002)(82740400003)(41300700001)(478600001)(1076003)(8936002)(81166007)(6666004)(316002)(6916009)(54906003)(356005)(2616005)(336012)(426003)(83380400001)(40480700001)(47076005)(36756003)(26005)(36860700001)(82310400005)(30864003)(2906002)(186003)(15650500001)(34020700004)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:45.9800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af875cc-c868-43db-222a-08da61000c4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
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
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Ideally link capability should be independent from the link
configuration that we decide to use in enable link. Otherwise if link
capability is changed after validation has completed, we could end up
enabling a link configuration with invalid configuration. This would
lead to over link bandwidth subscription or in the extreme case
causes us to enable HPO link to a DIO stream.

[how]
Add a new struct in pipe ctx called link config. This structure will
contain link configuration to enable a link. It will be populated
during map pool resources after we validate link bandwidth. Remove
the reference of verified link cap during enable link process and
use link config in pipe ctx instead.

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |  2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 27 +++++------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 45 +++++++------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 10 ++---
 .../gpu/drm/amd/display/dc/inc/core_status.h  |  1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 10 +++++
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  2 +-
 7 files changed, 44 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 283957dbdf93..69f1c2b89a57 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -424,6 +424,8 @@ char *dc_status_to_str(enum dc_status status)
 		return "No link encoder resource";
 	case DC_FAIL_DP_PAYLOAD_ALLOCATION:
 		return "Fail dp payload allocation";
+	case DC_FAIL_DP_LINK_BANDWIDTH:
+		return "Insufficient DP link bandwidth";
 	case DC_ERROR_UNEXPECTED:
 		return "Unexpected error";
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index dbdeda60e9e2..65269cd8cb78 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1969,7 +1969,8 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	enum dc_status status;
 	bool skip_video_pattern;
 	struct dc_link *link = stream->link;
-	struct dc_link_settings link_settings = {0};
+	const struct dc_link_settings *link_settings =
+			&pipe_ctx->link_config.dp_link_settings;
 	bool fec_enable;
 	int i;
 	bool apply_seamless_boot_optimization = false;
@@ -1986,9 +1987,6 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 		}
 	}
 
-	/* get link settings for video mode timing */
-	decide_link_settings(stream, &link_settings);
-
 	/* Train with fallback when enabling DPIA link. Conventional links are
 	 * trained with fallback during sink detection.
 	 */
@@ -1999,7 +1997,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	 * Temporary w/a to get DP2.0 link rates to work with SST.
 	 * TODO DP2.0 - Workaround: Remove w/a if and when the issue is resolved.
 	 */
-	if (dp_get_link_encoding_format(&link_settings) == DP_128b_132b_ENCODING &&
+	if (dp_get_link_encoding_format(link_settings) == DP_128b_132b_ENCODING &&
 			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
 			link->dc->debug.set_mst_en_for_sst) {
 		dp_enable_mst_on_sink(link, true);
@@ -2012,11 +2010,11 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
 	}
 
-	if (dp_get_link_encoding_format(&link_settings) == DP_128b_132b_ENCODING) {
+	if (dp_get_link_encoding_format(link_settings) == DP_128b_132b_ENCODING) {
 		/* TODO - DP2.0 HW: calculate 32 symbol clock for HPO encoder */
 	} else {
 		pipe_ctx->stream_res.pix_clk_params.requested_sym_clk =
-				link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
+				link_settings->link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
 		if (state->clk_mgr && !apply_seamless_boot_optimization)
 			state->clk_mgr->funcs->update_clocks(state->clk_mgr,
 					state, false);
@@ -2032,16 +2030,15 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 
 	skip_video_pattern = true;
 
-	if (link_settings.link_rate == LINK_RATE_LOW)
+	if (link_settings->link_rate == LINK_RATE_LOW)
 		skip_video_pattern = false;
 
-	if (perform_link_training_with_retries(&link_settings,
+	if (perform_link_training_with_retries(link_settings,
 					       skip_video_pattern,
 					       LINK_TRAINING_ATTEMPTS,
 					       pipe_ctx,
 					       pipe_ctx->stream->signal,
 					       do_fallback)) {
-		link->cur_link_settings = link_settings;
 		status = DC_OK;
 	} else {
 		status = DC_FAIL_DP_LINK_TRAINING;
@@ -2052,7 +2049,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	else
 		fec_enable = true;
 
-	if (dp_get_link_encoding_format(&link_settings) == DP_8b_10b_ENCODING)
+	if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING)
 		dp_set_fec_enable(link, fec_enable);
 
 	// during mode set we do DP_SET_POWER off then on, aux writes are lost
@@ -4124,11 +4121,10 @@ static void fpga_dp_hpo_enable_link_and_stream(struct dc_state *state, struct pi
 	struct fixed31_32 avg_time_slots_per_mtp;
 	uint8_t req_slot_count = 0;
 	uint8_t vc_id = 1; /// VC ID always 1 for SST
-	struct dc_link_settings link_settings = {0};
+	struct dc_link_settings link_settings = pipe_ctx->link_config.dp_link_settings;
 	const struct link_hwss *link_hwss = get_link_hwss(stream->link, &pipe_ctx->link_res);
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
-	decide_link_settings(stream, &link_settings);
 	stream->link->cur_link_settings = link_settings;
 
 	if (link_hwss->ext.enable_dp_link_output)
@@ -4602,10 +4598,7 @@ void dc_link_set_preferred_link_settings(struct dc *dc,
 	if (link_stream->dpms_off)
 		return;
 
-	decide_link_settings(link_stream, &store_settings);
-
-	if ((store_settings.lane_count != LANE_COUNT_UNKNOWN) &&
-		(store_settings.link_rate != LINK_RATE_UNKNOWN))
+	if (decide_link_settings(link_stream, &store_settings))
 		dp_retrain_link_dp_test(link, &store_settings, false);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index a126921c664a..d380b8bc6f39 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3880,15 +3880,13 @@ static bool decide_mst_link_settings(const struct dc_link *link, struct dc_link_
 	return true;
 }
 
-void decide_link_settings(struct dc_stream_state *stream,
+bool decide_link_settings(struct dc_stream_state *stream,
 	struct dc_link_settings *link_setting)
 {
-	struct dc_link *link;
-	uint32_t req_bw;
-
-	req_bw = dc_bandwidth_in_kbps_from_timing(&stream->timing);
+	struct dc_link *link = stream->link;
+	uint32_t req_bw = dc_bandwidth_in_kbps_from_timing(&stream->timing);
 
-	link = stream->link;
+	memset(link_setting, 0, sizeof(*link_setting));
 
 	/* if preferred is specified through AMDDP, use it, if it's enough
 	 * to drive the mode
@@ -3897,16 +3895,15 @@ void decide_link_settings(struct dc_stream_state *stream,
 			LANE_COUNT_UNKNOWN &&
 			link->preferred_link_setting.link_rate !=
 					LINK_RATE_UNKNOWN) {
-		*link_setting =  link->preferred_link_setting;
-		return;
+		*link_setting = link->preferred_link_setting;
+		return true;
 	}
 
 	/* MST doesn't perform link training for now
 	 * TODO: add MST specific link training routine
 	 */
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-		if (decide_mst_link_settings(link, link_setting))
-			return;
+		decide_mst_link_settings(link, link_setting);
 	} else if (link->connector_signal == SIGNAL_TYPE_EDP) {
 		/* enable edp link optimization for DSC eDP case */
 		if (stream->timing.flags.DSC) {
@@ -3924,17 +3921,16 @@ void decide_link_settings(struct dc_stream_state *stream,
 				decide_edp_link_settings(link, &tmp_link_setting, orig_req_bw);
 				max_link_rate = tmp_link_setting.link_rate;
 			}
-			if (decide_edp_link_settings_with_dsc(link, link_setting, req_bw, max_link_rate))
-				return;
-		} else if (decide_edp_link_settings(link, link_setting, req_bw))
-			return;
-	} else if (decide_dp_link_settings(link, link_setting, req_bw))
-		return;
-
-	BREAK_TO_DEBUGGER();
-	ASSERT(link->verified_link_cap.lane_count != LANE_COUNT_UNKNOWN);
+			decide_edp_link_settings_with_dsc(link, link_setting, req_bw, max_link_rate);
+		} else {
+			decide_edp_link_settings(link, link_setting, req_bw);
+		}
+	} else {
+		decide_dp_link_settings(link, link_setting, req_bw);
+	}
 
-	*link_setting = link->verified_link_cap;
+	return link_setting->lane_count != LANE_COUNT_UNKNOWN &&
+			link_setting->link_rate != LINK_RATE_UNKNOWN;
 }
 
 /*************************Short Pulse IRQ***************************/
@@ -4509,7 +4505,6 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 {
 	int i;
 	struct pipe_ctx *pipe_ctx;
-	struct dc_link_settings prev_link_settings = link->preferred_link_setting;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
@@ -4520,10 +4515,6 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 	if (pipe_ctx == NULL || pipe_ctx->stream == NULL)
 		return;
 
-	/* toggle stream state with the preference for current link settings */
-	dc_link_set_preferred_training_settings((struct dc *)link->dc,
-					&link->cur_link_settings, NULL, link, true);
-
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
@@ -4539,10 +4530,6 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 			core_link_enable_stream(link->dc->current_state, pipe_ctx);
 		}
 	}
-
-	/* restore previous link settings preference */
-	dc_link_set_preferred_training_settings((struct dc *)link->dc,
-					&prev_link_settings, NULL, link, true);
 }
 
 bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 9eb7e7027622..9db50ed5460b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2374,12 +2374,10 @@ enum dc_status resource_map_pool_resources(
 	/* Allocate DP HPO Stream Encoder based on signal, hw capabilities
 	 * and link settings
 	 */
-	if (dc_is_dp_signal(stream->signal) &&
-			dc->caps.dp_hpo) {
-		struct dc_link_settings link_settings = {0};
-
-		decide_link_settings(stream, &link_settings);
-		if (dp_get_link_encoding_format(&link_settings) == DP_128b_132b_ENCODING) {
+	if (dc_is_dp_signal(stream->signal)) {
+		if (!decide_link_settings(stream, &pipe_ctx->link_config.dp_link_settings))
+			return DC_FAIL_DP_LINK_BANDWIDTH;
+		if (dp_get_link_encoding_format(&pipe_ctx->link_config.dp_link_settings) == DP_128b_132b_ENCODING) {
 			pipe_ctx->stream_res.hpo_dp_stream_enc =
 					find_first_free_match_hpo_dp_stream_enc_for_link(
 							&context->res_ctx, pool, stream);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_status.h b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
index 8eb8d4afa876..fa5edd03d004 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_status.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
@@ -55,6 +55,7 @@ enum dc_status {
 
 	DC_NO_LINK_ENC_RESOURCE = 26,
 	DC_FAIL_DP_PAYLOAD_ALLOCATION = 27,
+	DC_FAIL_DP_LINK_BANDWIDTH = 28,
 	DC_ERROR_UNEXPECTED = -1
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 078c0c3ca2c5..2e158b1f5980 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -342,6 +342,9 @@ struct link_resource {
 	struct hpo_dp_link_encoder *hpo_dp_link_enc;
 };
 
+struct link_config {
+	struct dc_link_settings dp_link_settings;
+};
 union pipe_update_flags {
 	struct {
 		uint32_t enable : 1;
@@ -375,6 +378,13 @@ struct pipe_ctx {
 
 	struct pll_settings pll_settings;
 
+	/* link config records software decision for what link config should be
+	 * enabled given current link capability and stream during hw resource
+	 * mapping. This is to decouple the dependency on link capability during
+	 * dc commit or update.
+	 */
+	struct link_config link_config;
+
 	uint8_t pipe_idx;
 	uint8_t pipe_idx_syncd;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index aaa17d4dd46b..b44c7b43f7db 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -70,7 +70,7 @@ bool decide_edp_link_settings(struct dc_link *link,
 		struct dc_link_settings *link_setting,
 		uint32_t req_bw);
 
-void decide_link_settings(
+bool decide_link_settings(
 	struct dc_stream_state *stream,
 	struct dc_link_settings *link_setting);
 
-- 
2.25.1

