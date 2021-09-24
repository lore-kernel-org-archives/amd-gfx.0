Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB89FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7429C61250
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7429C61250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EBE86E212;
	Fri, 24 Sep 2021 19:10:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 230EB6E213
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApbsgD10PDtUQeb+5AiLPFlqb7IZaVBJDmjb7BKDHqYxJ1LaitMa4UhkfOPqbn85GAsE0cgcFSv30P7tQC6VfVfRfn6SehNw0guO3PuOIe1Oip9p6+b6K7cPfeMpGAX3zHPHyVjPIohzNJc9fV5t3xyeI9FLyHw8L7s2TKfZ+hLAjtlXDkMIAM7kk+ghTAbu9+EmxZGK3JnbXBCORpCXWn6Z93Cvv2cE6arIbZCv0VMZ87rIDc6EWUswF75zzUwwCIEkrMOlGYf6zGA6aAPBsW/EN0acqOUr1RjIZJgl7LFAUaZtp9RceutBEdZ6ACQprsIlgH2K5HJvy7H41Y0NPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=OlhK0420lDGIn+K4efxZs4v/Yeg0F7++tm/4R577m2M=;
 b=cL4/PLM4riCmPLNHuxhjtbLvhd4NEMJ5+CbrQdDWtzR5k1npp6enRnXqJWpWxf4GBoNSHEdTj51M8yhfOeOb9y7Nd9U9C31lvhORyjtgVJo6R59S8hQ7SlS6moRfeZlx4cGeB6TxGFT012oQ1jZGT+K34OQJMi5kTHlQJRblA++icpX3Tykr6eFsK4WwuAKaMlVvVKQ9vBhjoGnlSgkhw20M5XonZMYHGVYGpBFHLGjpq3hoBGJGx0pDmF8NCcFxJ0ryJZBFxSImv1sg51f+ni70kXJq6nc80zKFilTZVnbPHCWUFBHDkNShgrjpGFW4SoujN3t7IKBpsB8vOlIwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlhK0420lDGIn+K4efxZs4v/Yeg0F7++tm/4R577m2M=;
 b=TYrUIbPNsoKH7KkgW5Qa0MWvb2Pe8uPBhzMBtd7OcsVSZCz3bgJQ2Cp7Tc+HESqOu+wXZdcjygNfVMq70u3GAd6bwehhJSvPdwEy7yJQ4wQCYvbgmIcoIHgu1SAQ0mPdEcir5fm8EaRpYeNQW4O99TCFGn9HlpIwtqUqotUo78I=
Received: from CO2PR05CA0093.namprd05.prod.outlook.com (2603:10b6:104:1::19)
 by BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 19:10:04 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::53) by CO2PR05CA0093.outlook.office365.com
 (2603:10b6:104:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 12:10:00 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:09:59 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 08/24] drm/amd/display: implement decide lane settings
Date: Fri, 24 Sep 2021 15:09:18 -0400
Message-ID: <20210924190934.1193379-9-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9aca139-e962-408c-837b-08d97f8ee907
X-MS-TrafficTypeDiagnostic: BN8PR12MB3124:
X-Microsoft-Antispam-PRVS: <BN8PR12MB31241ED2BFA310F3EB84BA6FEBA49@BN8PR12MB3124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUi1+TwlSpuXEi94VcPdN3YtXhUOEK4Uunj/q6Jkwd8LghwHeGh87qgfOfxKTboWeWrM6df0Z2wfbDAQ+SSC3TIty9BZCy8g5FnnLX+BeZQNRaNpJghXz3Yz0JFLW/LbGuqExezWKQvzDMnhBWJhIMvAWdmO832ge4vwDAOWdIh766XZojOXBMf1lKjTz8aqI3RioJHmOiv+oU1T/0Jff+4LnhDaGFgQVZeIbHPtx/WIY7rqXPElnRel5v3QYAYnUd0R090saiuckG4mG4DYn4ge2WTe6opS05idcrIvpPhduzEfJgpQnRnq/AqKN3ZvStFmKPWk0p6wbGSJ86a3MK+hgKYjHNHsSSoh/RQkOYf9dBYtWYeDv+tX+IoNBl+8KzNBy+job2CObA25LOyoHfjRItvrnrPfrJS4M2k+00MlZ0iDI+f1HO4k3Ui8bL5x2/3GCu07te962wpbHcZhF8nHzjDSz9VSb9Wwk1844nBiyCetAL903NvVBEQJzsAn0v0C0rcpQPnSbg814m44rEcT6CxfGZd2EUeuM9tEQukfxa3j6v2/8ybGpklCZllbjRBUTAD10s3mvEsEFKXek7590rX52avlHNisHKZ+uXbPgOz7nZeEnnehkRwQ5kJKfuYZJtaJmaiyWqnAknwHpHOFDtmVvv/r3SCStYjZ2VSyHU7QbpeEsZdkoKi2OWUQA/cOb5BxLp6rwiSLBKNP/eW0UpJ7RyXw/vzbkkh4tGQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(30864003)(26005)(36860700001)(8676002)(5660300002)(4326008)(316002)(508600001)(186003)(2906002)(6666004)(8936002)(36756003)(86362001)(2616005)(47076005)(81166007)(70586007)(1076003)(426003)(336012)(356005)(7696005)(54906003)(6916009)(19627235002)(83380400001)(82310400003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:01.9754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9aca139-e962-408c-837b-08d97f8ee907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3124
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Decouple lane settings decision logic all to its own function.
The function takes in lane adjust array and link training settings
and decide what hw lane setting and dpcd lane setting should be used.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 292 ++++++------------
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  16 +-
 2 files changed, 102 insertions(+), 206 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index f7be58800da6..8e6af080cbe9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -105,6 +105,7 @@ static bool decide_fallback_link_setting(
 static struct dc_link_settings get_common_supported_link_settings(
 		struct dc_link_settings link_setting_a,
 		struct dc_link_settings link_setting_b);
+static void maximize_lane_settings(struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
 
 static uint32_t get_cr_training_aux_rd_interval(struct dc_link *link,
 		const struct dc_link_settings *link_settings)
@@ -520,7 +521,6 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 
 	uint8_t dpcd_lt_buffer[5] = {0};
 	union dpcd_training_pattern dpcd_pattern = { {0} };
-	uint32_t lane;
 	uint32_t size_in_bytes;
 	bool edp_workaround = false; /* TODO link_prop.INTERNAL */
 	dpcd_base_lt_offset = DP_TRAINING_PATTERN_SET;
@@ -711,34 +711,39 @@ void dp_hw_to_dpcd_lane_settings(
 	}
 }
 
-void dp_update_drive_settings(
-		struct link_training_settings *dest,
-		struct link_training_settings src)
+void dp_decide_lane_settings(
+		const struct link_training_settings *lt_settings,
+		const union lane_adjust ln_adjust[LANE_COUNT_DP_MAX],
+		struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX],
+		union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX])
 {
 	uint32_t lane;
-	for (lane = 0; lane < src.link_settings.lane_count; lane++) {
-		if (dest->voltage_swing == NULL)
-			dest->lane_settings[lane].VOLTAGE_SWING = src.lane_settings[lane].VOLTAGE_SWING;
-		else
-			dest->lane_settings[lane].VOLTAGE_SWING = *dest->voltage_swing;
-
-		if (dest->pre_emphasis == NULL)
-			dest->lane_settings[lane].PRE_EMPHASIS = src.lane_settings[lane].PRE_EMPHASIS;
-		else
-			dest->lane_settings[lane].PRE_EMPHASIS = *dest->pre_emphasis;
-
-		if (dest->post_cursor2 == NULL)
-			dest->lane_settings[lane].POST_CURSOR2 = src.lane_settings[lane].POST_CURSOR2;
-		else
-			dest->lane_settings[lane].POST_CURSOR2 = *dest->post_cursor2;
 
+	for (lane = 0; lane < (uint32_t)(lt_settings->link_settings.lane_count); lane++) {
+		if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
+				DP_8b_10b_ENCODING) {
+			hw_lane_settings[lane].VOLTAGE_SWING =
+					(enum dc_voltage_swing)(ln_adjust[lane].bits.
+							VOLTAGE_SWING_LANE);
+			hw_lane_settings[lane].PRE_EMPHASIS =
+					(enum dc_pre_emphasis)(ln_adjust[lane].bits.
+							PRE_EMPHASIS_LANE);
+		}
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-		if (dest->ffe_preset == NULL)
-			dest->lane_settings[lane].FFE_PRESET = src.lane_settings[lane].FFE_PRESET;
-		else
-			dest->lane_settings[lane].FFE_PRESET = *dest->ffe_preset;
+		else if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
+				DP_128b_132b_ENCODING) {
+			hw_lane_settings[lane].FFE_PRESET.raw =
+					ln_adjust[lane].tx_ffe.PRESET_VALUE;
+		}
 #endif
 	}
+
+	/*
+	 * We find the maximum of the requested settings across all lanes
+	 * and set this maximum for all lanes
+	 */
+	maximize_lane_settings(hw_lane_settings);
+	dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
 }
 
 static uint8_t get_nibble_at_index(const uint8_t *buf,
@@ -768,55 +773,28 @@ static enum dc_pre_emphasis get_max_pre_emphasis_for_voltage_swing(
 
 }
 
-static void find_max_drive_settings(
-	const struct link_training_settings *link_training_setting,
-	struct link_training_settings *max_lt_setting)
+static void maximize_lane_settings(struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
 {
 	uint32_t lane;
 	struct dc_lane_settings max_requested;
 
-	max_requested.VOLTAGE_SWING =
-		link_training_setting->
-		lane_settings[0].VOLTAGE_SWING;
-	max_requested.PRE_EMPHASIS =
-		link_training_setting->
-		lane_settings[0].PRE_EMPHASIS;
-	/*max_requested.postCursor2 =
-	 * link_training_setting->laneSettings[0].postCursor2;*/
+	max_requested.VOLTAGE_SWING = lane_settings[0].VOLTAGE_SWING;
+	max_requested.PRE_EMPHASIS = lane_settings[0].PRE_EMPHASIS;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	max_requested.FFE_PRESET =
-		link_training_setting->lane_settings[0].FFE_PRESET;
+	max_requested.FFE_PRESET = lane_settings[0].FFE_PRESET;
 #endif
 
 	/* Determine what the maximum of the requested settings are*/
-	for (lane = 1; lane < link_training_setting->link_settings.lane_count;
-			lane++) {
-		if (link_training_setting->lane_settings[lane].VOLTAGE_SWING >
-			max_requested.VOLTAGE_SWING)
-
-			max_requested.VOLTAGE_SWING =
-			link_training_setting->
-			lane_settings[lane].VOLTAGE_SWING;
-
-		if (link_training_setting->lane_settings[lane].PRE_EMPHASIS >
-				max_requested.PRE_EMPHASIS)
-			max_requested.PRE_EMPHASIS =
-			link_training_setting->
-			lane_settings[lane].PRE_EMPHASIS;
+	for (lane = 1; lane < LANE_COUNT_DP_MAX; lane++) {
+		if (lane_settings[lane].VOLTAGE_SWING > max_requested.VOLTAGE_SWING)
+			max_requested.VOLTAGE_SWING = lane_settings[lane].VOLTAGE_SWING;
 
-		/*
-		if (link_training_setting->laneSettings[lane].postCursor2 >
-		 max_requested.postCursor2)
-		{
-		max_requested.postCursor2 =
-		link_training_setting->laneSettings[lane].postCursor2;
-		}
-		*/
+		if (lane_settings[lane].PRE_EMPHASIS > max_requested.PRE_EMPHASIS)
+			max_requested.PRE_EMPHASIS = lane_settings[lane].PRE_EMPHASIS;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-		if (link_training_setting->lane_settings[lane].FFE_PRESET.settings.level >
+		if (lane_settings[lane].FFE_PRESET.settings.level >
 				max_requested.FFE_PRESET.settings.level)
 			max_requested.FFE_PRESET.settings.level =
-					link_training_setting->
 					lane_settings[lane].FFE_PRESET.settings.level;
 #endif
 	}
@@ -828,10 +806,7 @@ static void find_max_drive_settings(
 
 	if (max_requested.PRE_EMPHASIS > PRE_EMPHASIS_MAX_LEVEL)
 		max_requested.PRE_EMPHASIS = PRE_EMPHASIS_MAX_LEVEL;
-	/*
-	if (max_requested.postCursor2 > PostCursor2_MaxLevel)
-	max_requested.postCursor2 = PostCursor2_MaxLevel;
-	*/
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (max_requested.FFE_PRESET.settings.level > DP_FFE_PRESET_MAX_LEVEL)
 		max_requested.FFE_PRESET.settings.level = DP_FFE_PRESET_MAX_LEVEL;
@@ -845,61 +820,31 @@ static void find_max_drive_settings(
 		get_max_pre_emphasis_for_voltage_swing(
 			max_requested.VOLTAGE_SWING);
 
-	/*
-	 * Post Cursor2 levels are completely independent from
-	 * pre-emphasis (Post Cursor1) levels. But Post Cursor2 levels
-	 * can only be applied to each allowable combination of voltage
-	 * swing and pre-emphasis levels */
-	 /* if ( max_requested.postCursor2 >
-	  *  getMaxPostCursor2ForVoltageSwing(max_requested.voltageSwing))
-	  *  max_requested.postCursor2 =
-	  *  getMaxPostCursor2ForVoltageSwing(max_requested.voltageSwing);
-	  */
-
-	max_lt_setting->link_settings.link_rate =
-		link_training_setting->link_settings.link_rate;
-	max_lt_setting->link_settings.lane_count =
-	link_training_setting->link_settings.lane_count;
-	max_lt_setting->link_settings.link_spread =
-		link_training_setting->link_settings.link_spread;
-
-	for (lane = 0; lane <
-		link_training_setting->link_settings.lane_count;
-		lane++) {
-		max_lt_setting->lane_settings[lane].VOLTAGE_SWING =
-			max_requested.VOLTAGE_SWING;
-		max_lt_setting->lane_settings[lane].PRE_EMPHASIS =
-			max_requested.PRE_EMPHASIS;
-		/*max_lt_setting->laneSettings[lane].postCursor2 =
-		 * max_requested.postCursor2;
-		 */
+	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
+		lane_settings[lane].VOLTAGE_SWING = max_requested.VOLTAGE_SWING;
+		lane_settings[lane].PRE_EMPHASIS = max_requested.PRE_EMPHASIS;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-		max_lt_setting->lane_settings[lane].FFE_PRESET =
-			max_requested.FFE_PRESET;
+		lane_settings[lane].FFE_PRESET = max_requested.FFE_PRESET;
 #endif
 	}
 
 }
 
-enum dc_status dp_get_lane_status_and_drive_settings(
+enum dc_status dp_get_lane_status_and_lane_adjust(
 	struct dc_link *link,
 	const struct link_training_settings *link_training_setting,
-	union lane_status *ln_status,
-	union lane_align_status_updated *ln_status_updated,
-	struct link_training_settings *req_settings,
+	union lane_status ln_status[LANE_COUNT_DP_MAX],
+	union lane_align_status_updated *ln_align,
+	union lane_adjust ln_adjust[LANE_COUNT_DP_MAX],
 	uint32_t offset)
 {
 	unsigned int lane01_status_address = DP_LANE0_1_STATUS;
 	uint8_t lane_adjust_offset = 4;
 	unsigned int lane01_adjust_address;
 	uint8_t dpcd_buf[6] = {0};
-	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
-	struct link_training_settings request_settings = { {0} };
 	uint32_t lane;
 	enum dc_status status;
 
-	memset(req_settings, '\0', sizeof(struct link_training_settings));
-
 	if (is_repeater(link, offset)) {
 		lane01_status_address =
 				DP_LANE0_1_STATUS_PHY_REPEATER1 +
@@ -919,11 +864,11 @@ enum dc_status dp_get_lane_status_and_drive_settings(
 
 		ln_status[lane].raw =
 			get_nibble_at_index(&dpcd_buf[0], lane);
-		dpcd_lane_adjust[lane].raw =
+		ln_adjust[lane].raw =
 			get_nibble_at_index(&dpcd_buf[lane_adjust_offset], lane);
 	}
 
-	ln_status_updated->raw = dpcd_buf[2];
+	ln_align->raw = dpcd_buf[2];
 
 	if (is_repeater(link, offset)) {
 		DC_LOG_HW_LINK_TRAINING("%s:\n LTTPR Repeater ID: %d\n"
@@ -962,55 +907,6 @@ enum dc_status dp_get_lane_status_and_drive_settings(
 			dpcd_buf[lane_adjust_offset + 1]);
 	}
 
-	/*copy to req_settings*/
-	request_settings.link_settings.lane_count =
-		link_training_setting->link_settings.lane_count;
-	request_settings.link_settings.link_rate =
-		link_training_setting->link_settings.link_rate;
-	request_settings.link_settings.link_spread =
-		link_training_setting->link_settings.link_spread;
-
-	for (lane = 0; lane <
-		(uint32_t)(link_training_setting->link_settings.lane_count);
-		lane++) {
-
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-		if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
-				DP_128b_132b_ENCODING) {
-			request_settings.lane_settings[lane].FFE_PRESET.raw =
-					dpcd_lane_adjust[lane].tx_ffe.PRESET_VALUE;
-		} else if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
-				DP_8b_10b_ENCODING) {
-			request_settings.lane_settings[lane].VOLTAGE_SWING =
-					(enum dc_voltage_swing)(dpcd_lane_adjust[lane].bits.
-							VOLTAGE_SWING_LANE);
-			request_settings.lane_settings[lane].PRE_EMPHASIS =
-					(enum dc_pre_emphasis)(dpcd_lane_adjust[lane].bits.
-							PRE_EMPHASIS_LANE);
-		}
-#else
-		request_settings.lane_settings[lane].VOLTAGE_SWING =
-			(enum dc_voltage_swing)(dpcd_lane_adjust[lane].bits.
-				VOLTAGE_SWING_LANE);
-		request_settings.lane_settings[lane].PRE_EMPHASIS =
-			(enum dc_pre_emphasis)(dpcd_lane_adjust[lane].bits.
-				PRE_EMPHASIS_LANE);
-#endif
-	}
-
-	/*Note: for postcursor2, read adjusted
-	 * postcursor2 settings from*/
-	/*DpcdAddress_AdjustRequestPostCursor2 =
-	 *0x020C (not implemented yet)*/
-
-	/* we find the maximum of the requested settings across all lanes*/
-	/* and set this maximum for all lanes*/
-	find_max_drive_settings(&request_settings, req_settings);
-
-	/* if post cursor 2 is needed in the future,
-	 * read DpcdAddress_AdjustRequestPostCursor2 = 0x020C
-	 */
-
 	return status;
 }
 
@@ -1020,7 +916,6 @@ enum dc_status dpcd_set_lane_settings(
 	uint32_t offset)
 {
 	union dpcd_training_lane dpcd_lane[LANE_COUNT_DP_MAX] = {{{0}}};
-	uint32_t lane;
 	unsigned int lane0_set_address;
 	enum dc_status status;
 
@@ -1141,17 +1036,18 @@ static bool perform_post_lt_adj_req_sequence(
 			adj_req_timer < POST_LT_ADJ_REQ_TIMEOUT;
 			adj_req_timer++) {
 
-			struct link_training_settings req_settings;
 			union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
 			union lane_align_status_updated
 				dpcd_lane_status_updated;
+			union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+			union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
-			dp_get_lane_status_and_drive_settings(
+			dp_get_lane_status_and_lane_adjust(
 				link,
 				lt_settings,
 				dpcd_lane_status,
 				&dpcd_lane_status_updated,
-				&req_settings,
+				dpcd_lane_adjust,
 				DPRX);
 
 			if (dpcd_lane_status_updated.bits.
@@ -1170,10 +1066,9 @@ static bool perform_post_lt_adj_req_sequence(
 
 				if (lt_settings->
 				lane_settings[lane].VOLTAGE_SWING !=
-				req_settings.lane_settings[lane].
-				VOLTAGE_SWING ||
+				dpcd_lane_adjust[lane].bits.VOLTAGE_SWING_LANE ||
 				lt_settings->lane_settings[lane].PRE_EMPHASIS !=
-				req_settings.lane_settings[lane].PRE_EMPHASIS) {
+				dpcd_lane_adjust[lane].bits.PRE_EMPHASIS_LANE) {
 
 					req_drv_setting_changed = true;
 					break;
@@ -1181,8 +1076,8 @@ static bool perform_post_lt_adj_req_sequence(
 			}
 
 			if (req_drv_setting_changed) {
-				dp_update_drive_settings(
-					lt_settings, req_settings);
+				dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+						lt_settings->lane_settings, dpcd_lane_settings);
 
 				dc_link_dp_set_drive_settings(link,
 						lt_settings);
@@ -1262,13 +1157,14 @@ static enum link_training_result perform_channel_equalization_sequence(
 	struct link_training_settings *lt_settings,
 	uint32_t offset)
 {
-	struct link_training_settings req_settings;
 	enum dc_dp_training_pattern tr_pattern;
 	uint32_t retries_ch_eq;
 	uint32_t wait_time_microsec;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	/* Note: also check that TPS4 is a supported feature*/
 
@@ -1317,12 +1213,12 @@ static enum link_training_result perform_channel_equalization_sequence(
 		/* 4. Read lane status and requested
 		 * drive settings as set by the sink*/
 
-		dp_get_lane_status_and_drive_settings(
+		dp_get_lane_status_and_lane_adjust(
 			link,
 			lt_settings,
 			dpcd_lane_status,
 			&dpcd_lane_status_updated,
-			&req_settings,
+			dpcd_lane_adjust,
 			offset);
 
 		/* 5. check CR done*/
@@ -1336,7 +1232,8 @@ static enum link_training_result perform_channel_equalization_sequence(
 			return LINK_TRAINING_SUCCESS;
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
-		dp_update_drive_settings(lt_settings, req_settings);
+		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+				lt_settings->lane_settings, dpcd_lane_settings);
 	}
 
 	return LINK_TRAINING_EQ_FAIL_EQ;
@@ -1362,10 +1259,11 @@ static enum link_training_result perform_clock_recovery_sequence(
 	uint32_t retries_cr;
 	uint32_t retry_count;
 	uint32_t wait_time_microsec;
-	struct link_training_settings req_settings;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
 	union lane_align_status_updated dpcd_lane_status_updated;
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	retries_cr = 0;
 	retry_count = 0;
@@ -1419,12 +1317,12 @@ static enum link_training_result perform_clock_recovery_sequence(
 		/* 4. Read lane status and requested drive
 		* settings as set by the sink
 		*/
-		dp_get_lane_status_and_drive_settings(
+		dp_get_lane_status_and_lane_adjust(
 				link,
 				lt_settings,
 				dpcd_lane_status,
 				&dpcd_lane_status_updated,
-				&req_settings,
+				dpcd_lane_adjust,
 				offset);
 
 		/* 5. check CR done*/
@@ -1442,32 +1340,25 @@ static enum link_training_result perform_clock_recovery_sequence(
 			break;
 #endif
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-		if ((dp_get_link_encoding_format(&lt_settings->link_settings) == DP_128b_132b_ENCODING) &&
-				lt_settings->lane_settings[0].FFE_PRESET.settings.level ==
-						req_settings.lane_settings[0].FFE_PRESET.settings.level)
-			retries_cr++;
-		else if ((dp_get_link_encoding_format(&lt_settings->link_settings) == DP_8b_10b_ENCODING) &&
-				lt_settings->lane_settings[0].VOLTAGE_SWING ==
-						req_settings.lane_settings[0].VOLTAGE_SWING)
-			retries_cr++;
-		else
-			retries_cr = 0;
-#else
 		/* 7. same lane settings*/
 		/* Note: settings are the same for all lanes,
 		 * so comparing first lane is sufficient*/
-		if ((lt_settings->lane_settings[0].VOLTAGE_SWING ==
-			req_settings.lane_settings[0].VOLTAGE_SWING)
-			&& (lt_settings->lane_settings[0].PRE_EMPHASIS ==
-				req_settings.lane_settings[0].PRE_EMPHASIS))
+		if ((dp_get_link_encoding_format(&lt_settings->link_settings) == DP_8b_10b_ENCODING) &&
+				lt_settings->lane_settings[0].VOLTAGE_SWING ==
+						dpcd_lane_adjust[0].bits.VOLTAGE_SWING_LANE)
+			retries_cr++;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		else if ((dp_get_link_encoding_format(&lt_settings->link_settings) == DP_128b_132b_ENCODING) &&
+				lt_settings->lane_settings[0].FFE_PRESET.settings.level ==
+						dpcd_lane_adjust[0].tx_ffe.PRESET_VALUE)
 			retries_cr++;
+#endif
 		else
 			retries_cr = 0;
-#endif
 
 		/* 8. update VS/PE/PC2 in lt_settings*/
-		dp_update_drive_settings(lt_settings, req_settings);
+		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+				lt_settings->lane_settings, dpcd_lane_settings);
 
 		retry_count++;
 	}
@@ -2077,9 +1968,10 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	uint8_t loop_count = 0;
 	uint32_t aux_rd_interval = 0;
 	uint32_t wait_time = 0;
-	struct link_training_settings req_settings;
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 
 	/* Transmit 128b/132b_TPS1 over Main-Link and Set TRAINING_PATTERN_SET to 01h */
@@ -2087,9 +1979,10 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	dpcd_set_training_pattern(link, lt_settings->pattern_for_cr);
 
 	/* Adjust TX_FFE_PRESET_VALUE as requested */
-	dp_get_lane_status_and_drive_settings(link, lt_settings, dpcd_lane_status,
-			&dpcd_lane_status_updated, &req_settings, DPRX);
-	dp_update_drive_settings(lt_settings, req_settings);
+	dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
+			&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
+	dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+			lt_settings->lane_settings, dpcd_lane_settings);
 	dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
 	dp_set_hw_lane_settings(link, lt_settings, DPRX);
 	dpcd_set_lane_settings(link, lt_settings, DPRX);
@@ -2103,9 +1996,10 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 		loop_count++;
 		dp_wait_for_training_aux_rd_interval(link, aux_rd_interval);
 		wait_time += aux_rd_interval;
-		dp_get_lane_status_and_drive_settings(link, lt_settings, dpcd_lane_status,
-				&dpcd_lane_status_updated, &req_settings, DPRX);
-		dp_update_drive_settings(lt_settings, req_settings);
+		dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
+				&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
+		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+				lt_settings->lane_settings, dpcd_lane_settings);
 		dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
 		if (dp_is_ch_eq_done(lt_settings->link_settings.lane_count,
 				dpcd_lane_status)) {
@@ -2134,8 +2028,8 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 			dp_wait_for_training_aux_rd_interval(link,
 					lt_settings->eq_pattern_time);
 			wait_time += lt_settings->eq_pattern_time;
-			dp_get_lane_status_and_drive_settings(link, lt_settings, dpcd_lane_status,
-					&dpcd_lane_status_updated, &req_settings, DPRX);
+			dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
+					&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
 		}
 	}
 
@@ -2148,9 +2042,9 @@ static enum link_training_result dp_perform_128b_132b_cds_done_sequence(
 {
 	/* Assumption: assume hardware has transmitted eq pattern */
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
-	struct link_training_settings req_settings;
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
 	uint32_t wait_time = 0;
 
 	/* initiate CDS done sequence */
@@ -2161,8 +2055,8 @@ static enum link_training_result dp_perform_128b_132b_cds_done_sequence(
 		dp_wait_for_training_aux_rd_interval(link,
 				lt_settings->cds_pattern_time);
 		wait_time += lt_settings->cds_pattern_time;
-		dp_get_lane_status_and_drive_settings(link, lt_settings, dpcd_lane_status,
-						&dpcd_lane_status_updated, &req_settings, DPRX);
+		dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
+						&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
 		if (dp_is_symbol_locked(lt_settings->link_settings.lane_count, dpcd_lane_status) &&
 				dpcd_lane_status_updated.bits.CDS_INTERLANE_ALIGN_DONE_128b_132b) {
 			/* pass */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index c70375117519..a6d3d859754a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -121,12 +121,12 @@ enum dc_status dpcd_set_lane_settings(
 	const struct link_training_settings *link_training_setting,
 	uint32_t offset);
 /* Read training status and adjustment requests from DPCD. */
-enum dc_status dp_get_lane_status_and_drive_settings(
+enum dc_status dp_get_lane_status_and_lane_adjust(
 	struct dc_link *link,
 	const struct link_training_settings *link_training_setting,
-	union lane_status *ln_status,
-	union lane_align_status_updated *ln_status_updated,
-	struct link_training_settings *req_settings,
+	union lane_status ln_status[LANE_COUNT_DP_MAX],
+	union lane_align_status_updated *ln_align,
+	union lane_adjust ln_adjust[LANE_COUNT_DP_MAX],
 	uint32_t offset);
 
 void dp_wait_for_training_aux_rd_interval(
@@ -151,9 +151,11 @@ void dp_hw_to_dpcd_lane_settings(
 	const struct link_training_settings *lt_settings,
 	const struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX],
 	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX]);
-void dp_update_drive_settings(
-	struct link_training_settings *dest,
-	struct link_training_settings src);
+void dp_decide_lane_settings(
+	const struct link_training_settings *lt_settings,
+	const union lane_adjust ln_adjust[LANE_COUNT_DP_MAX],
+	struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX],
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX]);
 
 uint32_t dp_translate_training_aux_read_interval(uint32_t dpcd_aux_read_interval);
 
-- 
2.25.1

