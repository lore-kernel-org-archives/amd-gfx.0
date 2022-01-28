Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7180EC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE32510EE7A;
	Fri, 28 Jan 2022 14:05:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923EC10EE7A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAi0jOoKwN+Kgxc3IbU7peDoV0Wg3GadpNoFHqyUHpUdq9MNGxKQ8GRjysvXFrT+OU5ieeAtYlacIS9u4DcOoUmkCYPuGqK5+XeVjV/GXXGMoOsQT0CN4sRdCwgnXUEcP8HkhdpVDyZgZYQJr9ordFfnyTt/a22FoJqhPZxSDX5ly+pFv7S2Ggcq4rbF0ivbFv9OVl3ujjqI9EaM6H4BXgQawKcOp1h05ZGQqGltZpo6jeAaNLSiXubgzIQ3/98HsN3JlSimlTI6AYdXHnbqFQJY1Nfg//jriQQ6wVPARuyEzXcjabpywgahyugc9JLcVkhgvop97sX4jplW8+nB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhJiZYJARFqafTVnR8t08l48EUBPUJETsBbHw8CYpMI=;
 b=SkP4g6XlRR+ocjWh/7zd7Z4sbcLC53fzMdZdxCoNj6Ygs9iPYz09ni906mgU3a/TkuyQrcrg7TsKh3pxf24wk8onq0bw4qyxUqXTTlDXxRTEtRY3kY0nzIWZwEZ8EguyrPJWEVW4FK/yhPhGNfcIbx+7MV0cbos/7epuqp/x6upszJjju022Kxk05Cl6ofrKXJuAnQlka6Gm+BlgkWlLVP1X1F7tIjuwIiMjT0f7CM2frlkkphZLeDd8IobRMmaU26yNwRCoZaNbcsq3J+qgezTbDjiRY92jh2EvI+ykZEckhJsGKGbS3Pza5QNtgSqz7hG+uoqegEO9vNg1feSaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhJiZYJARFqafTVnR8t08l48EUBPUJETsBbHw8CYpMI=;
 b=d2SOF1+WHy1ow7KBdbbp/O6/DdXJmfn09puTlnfIu68e/4XGCnSHi1ATUuXPsYYM2kZwXp/Xgip84zECOsgxRLLyVOe8ZUfv1DxVrc4DZzE/WnIFpRD3kjASYSq8diAGLye/VDJkvP9cnu6qo0hfqMRdgYJApYfaimvg5DaAwkU=
Received: from MWHPR10CA0022.namprd10.prod.outlook.com (2603:10b6:301::32) by
 BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 28 Jan
 2022 14:05:31 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::5f) by MWHPR10CA0022.outlook.office365.com
 (2603:10b6:301::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 14:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:05:31 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:05:22 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/17] drm/amd/display: refactor destructive verify link cap
 sequence
Date: Fri, 28 Jan 2022 22:04:01 +0800
Message-ID: <20220128140411.3683309-8-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e86a0e-648f-4095-0150-08d9e2673ed5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5364:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5364868C8F90D4B900994822FF229@BL1PR12MB5364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HaWLswxoV6zsKvu9iH/zZQvEWxOAxhVet9Ex0VaVir41d7i6RXsdbqB7ASZ7MgzAwxvewWu6Oq92ZZ9sRp7+xupkZzfZ1QispWx+OXu6yFiHXIatXm7COOB0sJiAKPmSFSokLE4DHV9ilNDxkctBA9cE/0y0KOWwSvYTGP3iOceP3GCkW91RvoSrFD5IOphr2kSMlSuVIW2sqHbMsnXV1Yj8dxxrWIpTFU9krchl0+7CpK5T4WWviTCdNBvJ29Zabq9rWi8XXtmAP5io9OlNeh1H737teczrInPXDp+l0Tz3ML5+Yq5nWJCbg1Li7I+omVbAuEZPh4tLpbSoBkG2Bdc91DC3HEkH+Wp/N6CcUeC8oK+1rYgBmB2VQ2KEfkyIEYmJ3bI10zrBXp7Nd110NXlSGHUICJMHacmu3hNW8pP5Z9XZP/TMoXxzQfA4sEJZkLe7YedTDcVoWcFqN97Vzdx8Cql15jtnlB3wxKjBo+9EeBXJpjGFb/HbfH377wWtG4mYM7sIIujsMXjltdGsDRSotVHbpse21eaO1nF/iFckuT8lL9g5S9kriLD+zrlFzYAnd1lbODw0FWnX9TgbkqzaiaKPMtXpEOF60hWAeuBrJflccnWdate7tuGAnFjLqG7sj9sKE74hiIOX6oCN2Nrj8Mcaqt5Aijnv3ThuqmQKyA9Fn4tHViCFvXatVjUv2amLO7yoYusYTRgmilUxK0ltl9PRjAibdSCdYJ9RxlxuFq1H9yYy1+EiR7a0UPexMys2t+hPrqJN5PpH5264mKmQTfmDLnZPFgTg1oUDP+I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(4326008)(70206006)(2616005)(316002)(336012)(508600001)(2906002)(47076005)(40460700003)(8676002)(8936002)(36860700001)(82310400004)(86362001)(6666004)(186003)(7696005)(81166007)(83380400001)(6916009)(36756003)(26005)(54906003)(15650500001)(1076003)(356005)(30864003)(16526019)(426003)(44832011)(70586007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:05:31.1416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e86a0e-648f-4095-0150-08d9e2673ed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[how]
1. move decide det link training link resource before each link training.
2. move disable link for handling vbios case into set all streams
dpms off for link sequence.
3. extract usbc hotplug workaround into its own wa function.
4. Minor syntax changes to improve code readability.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  17 +--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 134 +++++++-----------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  22 ++-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   7 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   7 +-
 5 files changed, 83 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 2c5d67abad3e..c99e06afc769 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -893,6 +893,7 @@ static void set_all_streams_dpms_off_for_link(struct dc_link *link)
 	struct pipe_ctx *pipe_ctx;
 	struct dc_stream_update stream_update;
 	bool dpms_off = true;
+	struct link_resource link_res = {0};
 
 	memset(&stream_update, 0, sizeof(stream_update));
 	stream_update.dpms_off = &dpms_off;
@@ -907,33 +908,29 @@ static void set_all_streams_dpms_off_for_link(struct dc_link *link)
 					link->ctx->dc->current_state);
 		}
 	}
+
+	/* link can be also enabled by vbios. In this case it is not recorded
+	 * in pipe_ctx. Disable link phy here to make sure it is completely off
+	 */
+	dp_disable_link_phy(link, &link_res, link->connector_signal);
 }
 
 static void verify_link_capability_destructive(struct dc_link *link,
 		struct dc_sink *sink,
 		enum dc_detect_reason reason)
 {
-	struct link_resource link_res = { 0 };
 	bool should_prepare_phy_clocks =
 			should_prepare_phy_clocks_for_link_verification(link->dc, reason);
 
 	if (should_prepare_phy_clocks)
 		prepare_phy_clocks_for_destructive_link_verification(link->dc);
 
-
 	if (dc_is_dp_signal(link->local_sink->sink_signal)) {
 		struct dc_link_settings known_limit_link_setting =
 				dp_get_max_link_cap(link);
-
 		set_all_streams_dpms_off_for_link(link);
-		if (dp_get_link_encoding_format(&known_limit_link_setting) ==
-				DP_128b_132b_ENCODING)
-			link_res.hpo_dp_link_enc = resource_get_hpo_dp_link_enc_for_det_lt(
-					&link->dc->current_state->res_ctx,
-					link->dc->res_pool,
-					link);
 		dp_verify_link_cap_with_retries(
-				link, &link_res, &known_limit_link_setting,
+				link, &known_limit_link_setting,
 				LINK_TRAINING_MAX_VERIFY_RETRY);
 	} else {
 		ASSERT(0);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index f1082674bcbf..abec79e80eed 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -97,6 +97,12 @@ static const struct dp_lt_fallback_entry dp_lt_fallbacks[] = {
 		{LANE_COUNT_ONE, LINK_RATE_LOW},
 };
 
+static const struct dc_link_settings fail_safe_link_settings = {
+		.lane_count = LANE_COUNT_ONE,
+		.link_rate = LINK_RATE_LOW,
+		.link_spread = LINK_SPREAD_DISABLED,
+};
+
 static bool decide_fallback_link_setting(
 		struct dc_link *link,
 		struct dc_link_settings initial_link_settings,
@@ -3182,25 +3188,22 @@ bool hpd_rx_irq_check_link_loss_status(
 	return return_code;
 }
 
-bool dp_verify_link_cap(
+static bool dp_verify_link_cap(
 	struct dc_link *link,
-	const struct link_resource *link_res,
 	struct dc_link_settings *known_limit_link_setting,
 	int *fail_count)
 {
-	struct dc_link_settings cur_link_setting = {0};
-	struct dc_link_settings *cur = &cur_link_setting;
+	struct dc_link_settings cur_link_settings = {0};
 	struct dc_link_settings initial_link_settings = *known_limit_link_setting;
-	bool success;
-	bool skip_link_training;
+	bool success = false;
 	bool skip_video_pattern;
-	enum clock_source_id dp_cs_id = CLOCK_SOURCE_ID_EXTERNAL;
+	enum clock_source_id dp_cs_id = get_clock_source_id(link);
 	enum link_training_result status;
 	union hpd_irq_data irq_data;
+	struct link_resource link_res;
 
 	memset(&irq_data, 0, sizeof(irq_data));
-	success = false;
-	skip_link_training = false;
+	cur_link_settings = initial_link_settings;
 
 	/* Grant extended timeout request */
 	if ((link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && (link->dpcd_caps.lttpr_caps.max_ext_timeout > 0)) {
@@ -3209,100 +3212,72 @@ bool dp_verify_link_cap(
 		core_link_write_dpcd(link, DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT, &grant, sizeof(grant));
 	}
 
-	/* TODO implement override and monitor patch later */
-
-	/* try to train the link from high to low to
-	 * find the physical link capability
-	 */
-	/* disable PHY done possible by BIOS, will be done by driver itself */
-	dp_disable_link_phy(link, link_res, link->connector_signal);
-
-	dp_cs_id = get_clock_source_id(link);
-
-	cur_link_setting = initial_link_settings;
-
-	/* Temporary Renoir-specific workaround for SWDEV-215184;
-	 * PHY will sometimes be in bad state on hotplugging display from certain USB-C dongle,
-	 * so add extra cycle of enabling and disabling the PHY before first link training.
-	 */
-	if (link->link_enc && link->link_enc->features.flags.bits.DP_IS_USB_C &&
-			link->dc->debug.usbc_combo_phy_reset_wa) {
-		dp_enable_link_phy(link, link_res, link->connector_signal, dp_cs_id, cur);
-		dp_disable_link_phy(link, link_res, link->connector_signal);
-	}
-
 	do {
-		skip_video_pattern = true;
-
-		if (cur->link_rate == LINK_RATE_LOW)
-			skip_video_pattern = false;
+		if (!get_temp_dp_link_res(link, &link_res, &cur_link_settings))
+			continue;
 
+		skip_video_pattern = cur_link_settings.link_rate != LINK_RATE_LOW;
 		dp_enable_link_phy(
 				link,
-				link_res,
+				&link_res,
 				link->connector_signal,
 				dp_cs_id,
-				cur);
+				&cur_link_settings);
 
+		status = dc_link_dp_perform_link_training(
+				link,
+				&link_res,
+				&cur_link_settings,
+				skip_video_pattern);
 
-		if (skip_link_training)
+		if (status == LINK_TRAINING_SUCCESS) {
 			success = true;
-		else {
-			status = dc_link_dp_perform_link_training(
+			udelay(1000);
+			if (read_hpd_rx_irq_data(link, &irq_data) == DC_OK &&
+					hpd_rx_irq_check_link_loss_status(
 							link,
-							link_res,
-							cur,
-							skip_video_pattern);
-			if (status == LINK_TRAINING_SUCCESS)
-				success = true;
-			else
+							&irq_data))
 				(*fail_count)++;
-		}
 
-		if (success) {
-			link->verified_link_cap = *cur;
-			udelay(1000);
-			if (read_hpd_rx_irq_data(link, &irq_data) == DC_OK)
-				if (hpd_rx_irq_check_link_loss_status(
-						link,
-						&irq_data))
-					(*fail_count)++;
+		} else {
+			(*fail_count)++;
 		}
-		/* always disable the link before trying another
-		 * setting or before returning we'll enable it later
-		 * based on the actual mode we're driving
-		 */
-		dp_disable_link_phy(link, link_res, link->connector_signal);
+		dp_disable_link_phy(link, &link_res, link->connector_signal);
 	} while (!success && decide_fallback_link_setting(link,
-			initial_link_settings, cur, status));
+			initial_link_settings, &cur_link_settings, status));
 
-	/* Link Training failed for all Link Settings
-	 *  (Lane Count is still unknown)
-	 */
-	if (!success) {
-		/* If all LT fails for all settings,
-		 * set verified = failed safe (1 lane low)
-		 */
-		link->verified_link_cap.lane_count = LANE_COUNT_ONE;
-		link->verified_link_cap.link_rate = LINK_RATE_LOW;
-
-		link->verified_link_cap.link_spread =
-		LINK_SPREAD_DISABLED;
-	}
+	link->verified_link_cap = success ?
+			cur_link_settings : fail_safe_link_settings;
+	return success;
+}
 
+static void apply_usbc_combo_phy_reset_wa(struct dc_link *link,
+		struct dc_link_settings *link_settings)
+{
+	/* Temporary Renoir-specific workaround PHY will sometimes be in bad
+	 * state on hotplugging display from certain USB-C dongle, so add extra
+	 * cycle of enabling and disabling the PHY before first link training.
+	 */
+	struct link_resource link_res = {0};
+	enum clock_source_id dp_cs_id = get_clock_source_id(link);
 
-	return success;
+	dp_enable_link_phy(link, &link_res, link->connector_signal,
+			dp_cs_id, link_settings);
+	dp_disable_link_phy(link, &link_res, link->connector_signal);
 }
 
 bool dp_verify_link_cap_with_retries(
 	struct dc_link *link,
-	const struct link_resource *link_res,
 	struct dc_link_settings *known_limit_link_setting,
 	int attempts)
 {
 	int i = 0;
 	bool success = false;
 
+	if (link->link_enc && link->link_enc->features.flags.bits.DP_IS_USB_C &&
+			link->dc->debug.usbc_combo_phy_reset_wa)
+		apply_usbc_combo_phy_reset_wa(link, known_limit_link_setting);
+
 	for (i = 0; i < attempts; i++) {
 		int fail_count = 0;
 		enum dc_connection_type type = dc_connection_none;
@@ -3310,12 +3285,9 @@ bool dp_verify_link_cap_with_retries(
 		memset(&link->verified_link_cap, 0,
 				sizeof(struct dc_link_settings));
 		if (!dc_link_detect_sink(link, &type) || type == dc_connection_none) {
-			link->verified_link_cap.lane_count = LANE_COUNT_ONE;
-			link->verified_link_cap.link_rate = LINK_RATE_LOW;
-			link->verified_link_cap.link_spread = LINK_SPREAD_DISABLED;
+			link->verified_link_cap = fail_safe_link_settings;
 			break;
-		} else if (dp_verify_link_cap(link, link_res,
-				known_limit_link_setting,
+		} else if (dp_verify_link_cap(link, known_limit_link_setting,
 				&fail_count) && fail_count == 0) {
 			success = true;
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 3aa6d347d73c..9af8794c5b24 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3187,9 +3187,9 @@ void get_audio_check(struct audio_info *aud_modes,
 	}
 }
 
-struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
+static struct hpo_dp_link_encoder *get_temp_hpo_dp_link_enc(
 		const struct resource_context *res_ctx,
-		const struct resource_pool *pool,
+		const struct resource_pool *const pool,
 		const struct dc_link *link)
 {
 	struct hpo_dp_link_encoder *hpo_dp_link_enc = NULL;
@@ -3206,6 +3206,24 @@ struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
 	return hpo_dp_link_enc;
 }
 
+bool get_temp_dp_link_res(struct dc_link *link,
+		struct link_resource *link_res,
+		struct dc_link_settings *link_settings)
+{
+	const struct dc *dc  = link->dc;
+	const struct resource_context *res_ctx = &dc->current_state->res_ctx;
+
+	memset(link_res, 0, sizeof(*link_res));
+
+	if (dp_get_link_encoding_format(link_settings) == DP_128b_132b_ENCODING) {
+		link_res->hpo_dp_link_enc = get_temp_hpo_dp_link_enc(res_ctx,
+				dc->res_pool, link);
+		if (!link_res->hpo_dp_link_enc)
+			return false;
+	}
+	return true;
+}
+
 void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
 		struct dc_state *context)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 3ed2dbbf5642..67286950fe5a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -56,15 +56,8 @@ enum {
 
 struct dc_link_settings dp_get_max_link_cap(struct dc_link *link);
 
-bool dp_verify_link_cap(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	struct dc_link_settings *known_limit_link_setting,
-	int *fail_count);
-
 bool dp_verify_link_cap_with_retries(
 	struct dc_link *link,
-	const struct link_resource *link_res,
 	struct dc_link_settings *known_limit_link_setting,
 	int attempts);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 2a123622564d..b2d09330de78 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -201,10 +201,9 @@ int get_num_mpc_splits(struct pipe_ctx *pipe);
 
 int get_num_odm_splits(struct pipe_ctx *pipe);
 
-struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
-		const struct resource_context *res_ctx,
-		const struct resource_pool *pool,
-		const struct dc_link *link);
+bool get_temp_dp_link_res(struct dc_link *link,
+		struct link_resource *link_res,
+		struct dc_link_settings *link_settings);
 
 void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
 	struct dc_state *context);
-- 
2.34.1

