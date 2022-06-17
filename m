Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C515CCA47C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6425510F4A6;
	Fri, 17 Jun 2022 19:36:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E10310F466
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlOx9Dbl9e9UoZt4efmM2ExWKQQY/vssNF6RXx0UrCLKzb1y34E1ghkysMcu7BFlI9STIvQZJVKwSgiEAQTN+mVSMijZUcuyX20HtJ9E9CE7XDNiZwk/8rccmziaGIlW2w1R/h2GMsbkN4Etdzj6SpLd05WH1chrchWygy1cMYA4HKtbAzS+4mO2ksHAscT6AD2U5m1yzgqNxGRBDJI6pYVS5A6hAJJ6VlVUlx9xZB+dKX2dbKPDwRpj31C520zwzy9GI+N4Als2d4CsIGRicfLmS5lUtW5hpgJ1m8Htg4omJIjcUs5uzxJSMYGHk6GXY6HWWvgJEvE/5S8GwIUS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ3tLXVxYrysTzWlPpxmmIX298+3ZZ9kb4jEXrf0wqk=;
 b=fiiayRN1+6Ec16sZbFGkY4+/TOu3IgvuSoBIIaHOaY+LpW2yKvVNdnp54Z9SB4BDWnKNrBiDr64B1xwN1E9aoG4WCr0lMxUctplJVWMc+UaaPH45XldXBHFqDmozUZ7QpQMDJl1c9mAlhwYI96mMq5MlL4+qdc55QTEPAIBd9VSeROVgCo23PMjWOE7+OQiGFC3TKNYKNue+eiyTKJZrPpRUpohSuaFtU2S067Y0ba2mUJG0AddnHIr9YMobAGLCVAxTnM1BZ/+aVXKEie54js44DgvOXdEUQ+0lM9lQxJY48u0C+YFQr7bvEptwFJNJ6Lki076iL70hHj3VbJ0OQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ3tLXVxYrysTzWlPpxmmIX298+3ZZ9kb4jEXrf0wqk=;
 b=ZXUfXpwsfXAORc/CE0ujLwAR/W4yx/CB6W7Gd66AvEYIOnwn51RwkatNi1WUJDvg4GuGP+KZof801SieKAMYOkgG55PpleMxxpqapdmUoYUp6TG7rHedkQUXWkf3oj8ZJgoUqWVnNA6gSKRWvFNuoXARd838JHk50QWN4wwPWJQ=
Received: from BN9PR03CA0754.namprd03.prod.outlook.com (2603:10b6:408:13a::9)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 19:36:06 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::fc) by BN9PR03CA0754.outlook.office365.com
 (2603:10b6:408:13a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 19:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:36:05 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:55 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/31] drm/amd/display: Remove unused vendor specific w/a
Date: Fri, 17 Jun 2022 15:35:01 -0400
Message-ID: <20220617193512.3471076-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f39b3c3-6c6b-462b-9011-08da50989f14
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB404104749A2F3C5727802B3798AF9@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jik1lGKqNGlto+7JS6tTMX0Wx6f39wM4mcwBR+7RN4aT525tJfWobISsqx7tx10mKNDDLbwvrCef5kfmyfcAj/Aer4dkwSWbYADgUjIkC0n5vLD1SEdKVe+nI+MQeoKlAasDSdxlYMNuzFOmwS6jJCel7nQDvGP7QjwlpFKhm6Hr68mEVO/yHR8+tvyAcvJl0eFg4PX9vEmdGLDUEafJaPlBredeBDbR/uOK5+222PCl42jc8XKHT7BwjNyj9p7WQ0bwQCWYkmQIyUnsYbsy7xdqJoxNeMLMGDtPmD6XIzZXMkVEDmZZY6rqJkZMiNR95MfNzRVFY+HFFB90ufifnHpMT7199cF+u3R7uL6frHZlnTvZtt3+8ZG0+Go15KSE+PIuePRH52jlU5+ElFythqCRZCyWQm7JybLkCv3OySt5WLmFcQxX5omFttxtd9PbYUOLS0xCykkXQIZHPvyklsX6m7No9MGfwX1fJN1cA/6SUZ8UItqrwquac1eLJo1y6WVpQcdGQtO4x7lVOqdVuqBiLedogmNB7gYKWONXKiGaaWqMOl8qommFgKuQwX9hQCi8E1XI5Ml1ddCzVJiXwt02DNf2MkQDtt87EiwAmmlhQAlNlX5+vARbEJPoPH2OsaiwDyps3Z3yNsQMmEi3wPvbkEw2AeyQFFRMouN655Z1zZRkYqkpl/s9iCLCwmx9H6pgprJAJOoStV9OXJ+bNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(70206006)(5660300002)(8936002)(83380400001)(8676002)(4326008)(70586007)(36860700001)(40460700003)(6666004)(7696005)(2906002)(498600001)(336012)(16526019)(36756003)(316002)(47076005)(186003)(426003)(1076003)(26005)(2616005)(54906003)(6916009)(86362001)(82310400005)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:05.9741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f39b3c3-6c6b-462b-9011-08da50989f14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <George.Shen@amd.com>

[Why & How]
Old vendor specific w/a are no longer needed
and unused. Clean up codebase by removing them.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 133 +-----------------
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 -
 2 files changed, 4 insertions(+), 130 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c993b428ca7e..76233db6876c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -329,51 +329,6 @@ static uint8_t get_dpcd_link_rate(const struct dc_link_settings *link_settings)
 	return link_rate;
 }
 
-static void vendor_specific_lttpr_wa_one_start(struct dc_link *link)
-{
-	const uint8_t vendor_lttpr_write_data[4] = {0x1, 0x50, 0x63, 0xff};
-	const uint8_t offset = dp_convert_to_count(
-			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
-	uint32_t vendor_lttpr_write_address = 0xF004F;
-
-	if (offset != 0xFF)
-		vendor_lttpr_write_address +=
-				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
-
-	/* W/A for certain LTTPR to reset their lane settings, part one of two */
-	core_link_write_dpcd(
-			link,
-			vendor_lttpr_write_address,
-			&vendor_lttpr_write_data[0],
-			sizeof(vendor_lttpr_write_data));
-}
-
-static void vendor_specific_lttpr_wa_one_two(
-	struct dc_link *link,
-	const uint8_t rate)
-{
-	if (link->apply_vendor_specific_lttpr_link_rate_wa) {
-		uint8_t toggle_rate = 0x0;
-
-		if (rate == 0x6)
-			toggle_rate = 0xA;
-		else
-			toggle_rate = 0x6;
-
-		if (link->vendor_specific_lttpr_link_rate_wa == rate) {
-			/* W/A for certain LTTPR to reset internal state for link training */
-			core_link_write_dpcd(
-					link,
-					DP_LINK_BW_SET,
-					&toggle_rate,
-					1);
-		}
-
-		/* Store the last attempted link rate for this link */
-		link->vendor_specific_lttpr_link_rate_wa = rate;
-	}
-}
-
 static void dp_fixed_vs_pe_read_lane_adjust(
 	struct dc_link *link,
 	union dpcd_training_lane dpcd_lane_adjust[LANE_COUNT_DP_MAX])
@@ -423,51 +378,6 @@ static void dp_fixed_vs_pe_read_lane_adjust(
 	}
 }
 
-static void vendor_specific_lttpr_wa_four(
-	struct dc_link *link,
-	bool apply_wa)
-{
-	const uint8_t vendor_lttpr_write_data_one[4] = {0x1, 0x55, 0x63, 0x8};
-	const uint8_t vendor_lttpr_write_data_two[4] = {0x1, 0x55, 0x63, 0x0};
-	const uint8_t offset = dp_convert_to_count(
-			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
-	uint32_t vendor_lttpr_write_address = 0xF004F;
-	uint8_t sink_status = 0;
-	uint8_t i;
-
-	if (offset != 0xFF)
-		vendor_lttpr_write_address +=
-				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
-
-	/* W/A to pass through DPCD write of TPS=0 to DPRX */
-	if (apply_wa) {
-		core_link_write_dpcd(
-				link,
-				vendor_lttpr_write_address,
-				&vendor_lttpr_write_data_one[0],
-				sizeof(vendor_lttpr_write_data_one));
-	}
-
-	/* clear training pattern set */
-	dpcd_set_training_pattern(link, DP_TRAINING_PATTERN_VIDEOIDLE);
-
-	if (apply_wa) {
-		core_link_write_dpcd(
-				link,
-				vendor_lttpr_write_address,
-				&vendor_lttpr_write_data_two[0],
-				sizeof(vendor_lttpr_write_data_two));
-	}
-
-	/* poll for intra-hop disable */
-	for (i = 0; i < 10; i++) {
-		if ((core_link_read_dpcd(link, DP_SINK_STATUS, &sink_status, 1) == DC_OK) &&
-				(sink_status & DP_INTRA_HOP_AUX_REPLY_INDICATION) == 0)
-			break;
-		udelay(1000);
-	}
-}
-
 static void dp_fixed_vs_pe_set_retimer_lane_settings(
 	struct dc_link *link,
 	const union dpcd_training_lane dpcd_lane_adjust[LANE_COUNT_DP_MAX],
@@ -561,14 +471,6 @@ enum dc_status dpcd_set_link_settings(
 				&lt_settings->link_settings.link_rate_set, 1);
 	} else {
 		rate = get_dpcd_link_rate(&lt_settings->link_settings);
-		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
-					(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-					link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
-			vendor_specific_lttpr_wa_one_start(link);
-
-		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
-					(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN))
-			vendor_specific_lttpr_wa_one_two(link, rate);
 
 		status = core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
 	}
@@ -1303,12 +1205,6 @@ static enum link_training_result perform_channel_equalization_sequence(
 					dp_translate_training_aux_read_interval(
 						link->dpcd_caps.lttpr_caps.aux_rd_interval[offset - 1]);
 
-		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
-				(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-				link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
-			wait_time_microsec = 16000;
-		}
-
 		dp_wait_for_training_aux_rd_interval(
 				link,
 				wait_time_microsec);
@@ -1415,11 +1311,6 @@ static enum link_training_result perform_clock_recovery_sequence(
 		/* 3. wait receiver to lock-on*/
 		wait_time_microsec = lt_settings->cr_pattern_time;
 
-		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
-				(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN)) {
-			wait_time_microsec = 16000;
-		}
-
 		dp_wait_for_training_aux_rd_interval(
 				link,
 				wait_time_microsec);
@@ -2752,14 +2643,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 			&lt_settings);
 
 	/* reset previous training states */
-	if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
-			(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-			link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
-		link->apply_vendor_specific_lttpr_link_rate_wa = true;
-		vendor_specific_lttpr_wa_four(link, true);
-	} else {
-		dpcd_exit_training_mode(link);
-	}
+	dpcd_exit_training_mode(link);
 
 	/* configure link prior to entering training mode */
 	dpcd_configure_lttpr_mode(link, &lt_settings);
@@ -2780,14 +2664,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 		ASSERT(0);
 
 	/* exit training mode */
-	if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
-			(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-			link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
-		link->apply_vendor_specific_lttpr_link_rate_wa = false;
-		vendor_specific_lttpr_wa_four(link, (status != LINK_TRAINING_SUCCESS));
-	} else {
-		dpcd_exit_training_mode(link);
-	}
+	dpcd_exit_training_mode(link);
 
 	/* switch to video idle */
 	if ((status == LINK_TRAINING_SUCCESS) || !skip_video_pattern)
@@ -4227,8 +4104,7 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 			&dpcd_lane_adjustment[0].raw,
 			sizeof(dpcd_lane_adjustment));
 
-	if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
-			(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+	if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
 			link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
 		dp_fixed_vs_pe_read_lane_adjust(
 				link,
@@ -6198,8 +6074,7 @@ bool dc_link_dp_set_test_pattern(
 	if (is_dp_phy_pattern(test_pattern)) {
 		/* Set DPCD Lane Settings before running test pattern */
 		if (p_link_settings != NULL) {
-			if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
-					(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+			if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
 					link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
 				dp_fixed_vs_pe_set_retimer_lane_settings(
 						link,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 236a204d41ad..81e308d59a97 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -744,7 +744,6 @@ struct dc_debug_options {
 	bool force_usr_allow;
 	/* uses value at boot and disables switch */
 	bool disable_dtb_ref_clk_switch;
-	bool apply_vendor_specific_lttpr_wa;
 	bool extended_blank_optimization;
 	union aux_wake_wa_options aux_wake_wa;
 	uint8_t psr_power_use_phy_fsm;
-- 
2.25.1

