Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FE1C433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F89660724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F89660724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A7D56E14C;
	Sun, 24 Oct 2021 13:32:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A28B6E139
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlrKnaYtLuJvhDY6gLh53w+qx4zZz/5Y/9XaszGMANL4TBJgSy4fxkb2zu2NQij4lkPrDHtcgfMwGt2N1Pwg33KJhc0yQQzVcfwYlcZAKDTI6vwJviXMqGYr3VOz8o4mM7xrMlmMcue/AunlQ1/teGJnZgGEGJVpAnwwGx6/7Bm2D+pLrbb3AWu/PPR6Qc0QHMEUFElKJB1LCOt/4soCXLgn68f8DgCKrAFxDjDkKvywfhaAUG+NHMh79YKYzqxKlfQbHSI6TjQrHP3CCP98enP8wpGpDKVzhe5CPdH7STDs9m2A0ODXu2j+SMSR+o6BcajUFCdX66xk7B3SjIUkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Osiw1UiXLTG9i3L3h8fD8+GmnevFhESRXU4aGa2wKuw=;
 b=PNLbuZIoEJ3EjzSwo5lFJDy999pPzUnVW7xdJO8b8PDWwgmPKurmD+vnyQXUNHXMWX3d0GezRwuXlYcEFq0jaBp90dUUEGiwQn66CkGqQ7HKYRMJzkuFWaMOPcQEQnGFBkhSwZIeevtCNPgF2P9gXOyui//7MRQHQW7yzayqbfZM414XY7vwXK+u6VQCKoXnQ9pY0CHwDlS2rObJX69NKxUxKGysIDSubZM4BaHv3vGwPlfJaerFO99NiseZW6mElpRjGrDipdCbBfTArHp7fXKRyYb+dhj3b7UAFEKkubaybCHqqgXwCu6txJhD012cVWihP1j6A1ZfOkoFBvR6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Osiw1UiXLTG9i3L3h8fD8+GmnevFhESRXU4aGa2wKuw=;
 b=15EwABOHT5kaVpjMpDP8pq48eYxz8rnpF4ttlEB7YgnmN+kO+zX78TEvyq9o/zYp21YS0P2cPeW2ZUFUKn9iJuXLfjMFOtXfvwg4JDriBbYpi4Ai/UxBdqMt4A6tG+x74ApgAcKwvnruHl8cyQHMMGF0a9aCKD9s4U6u207ne2E=
Received: from CO2PR04CA0152.namprd04.prod.outlook.com (2603:10b6:104::30) by
 CY4PR1201MB0133.namprd12.prod.outlook.com (2603:10b6:910:1c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:42 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::cf) by CO2PR04CA0152.outlook.office365.com
 (2603:10b6:104::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:42 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:40 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 29/33] drm/amd/display: implement decide lane settings
Date: Sun, 24 Oct 2021 09:31:37 -0400
Message-ID: <20211024133141.239861-30-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d38bd380-085a-41c9-c879-08d996f2c180
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0133:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0133A0785A9F195CFC00458E98829@CY4PR1201MB0133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLzcWv3wpJlXUregZDrvsIJcx0LWbNId292KsAaZ75FqmNM5DUQk7+daPo8XsB2/07CZpU8kX5oQQ053UClbn8xKvkmc0ppS69z+858sPl7IAeBAjBSrndwXgo+2j3ajFQjBoPdtacRdGVnTXWqqYQs7npP7tDZ2G4IR9z5BlvMIDHICTLZosG/8/mBDc+rhMuTbCd7eHquDSKckeUU4Y6CHl7QDHxlw2ba2SGtbB/NBJykJfN2U9VFOtvv57EcLKK7TIF9bjVXnbDp+b31HrcqGwtbc+D4MHtcfCsAs+2lulxuNihw4ogcfx0I7NT6B2HrOyYrLHGmAMqgXw7D7rZU2Tlz2Anjw6vtJ50P7vGYarvbn7V/L9NaqoHJHd3AEc4RPRxynxOtjgnXPIJ3QNDzk4Vbbi4mZoLrRClH6ACToNDAnNz+Xeb4EkiizPLGTHVQl4PPSb6co346yyD4BV81LXq2L239A2nkVsapYrZxjAL6aA5KKqiOZVf9utReHTzDLrT4iWxDCLoOdr/UFjZpUcIJ8qkuefbu6tdCLtOs8PCv/RXMW0S4CZdOFpQkufvQ+YHnU9d2SjhFuvA+oxQ7uGZ9BTHtpdMvDXS4+xPIpJKcsgdDT/3CF4X8czQq3Z7w9WbIYdPEZoKEQERKuawLwmh+Kg6fGrWlY2hSe1rol1/XjkzGHPyJ4pcvGo82TaoDZexyT4k+xRZ9uogKmaAXHM96B+vAUgvaPJepHjIU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(6916009)(19627235002)(16526019)(30864003)(70586007)(70206006)(26005)(86362001)(4326008)(1076003)(508600001)(81166007)(8936002)(316002)(36756003)(356005)(336012)(2906002)(2616005)(47076005)(426003)(83380400001)(82310400003)(6666004)(8676002)(5660300002)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:42.0781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d38bd380-085a-41c9-c879-08d996f2c180
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0133
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
Decouple lane settings decision logic all to its own function. The
function takes in lane adjust array and link training settings and
decide what hw lane setting and dpcd lane setting should be used.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 292 ++++++------------
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  62 ++--
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  16 +-
 .../amd/display/include/link_service_types.h  |  17 +
 4 files changed, 155 insertions(+), 232 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index a7ed88b75042..fff238f07b9e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -106,7 +106,8 @@ static bool decide_fallback_link_setting(
 static struct dc_link_settings get_common_supported_link_settings(
 		struct dc_link_settings link_setting_a,
 		struct dc_link_settings link_setting_b);
-
+static void maximize_lane_settings(const struct link_training_settings *lt_settings,
+		struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
 static uint32_t get_cr_training_aux_rd_interval(struct dc_link *link,
 		const struct dc_link_settings *link_settings)
 {
@@ -711,34 +712,37 @@ void dp_hw_to_dpcd_lane_settings(
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
 
+	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
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
+	/* we find the maximum of the requested settings across all lanes*/
+	/* and set this maximum for all lanes*/
+	maximize_lane_settings(lt_settings, hw_lane_settings);
+	dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, dpcd_lane_settings);
 }
 
 static uint8_t get_nibble_at_index(const uint8_t *buf,
@@ -768,55 +772,29 @@ static enum dc_pre_emphasis get_max_pre_emphasis_for_voltage_swing(
 
 }
 
-static void find_max_drive_settings(
-	const struct link_training_settings *link_training_setting,
-	struct link_training_settings *max_lt_setting)
+static void maximize_lane_settings(const struct link_training_settings *lt_settings,
+		struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
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
+	for (lane = 1; lane < lt_settings->link_settings.lane_count; lane++) {
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
@@ -828,10 +806,6 @@ static void find_max_drive_settings(
 
 	if (max_requested.PRE_EMPHASIS > PRE_EMPHASIS_MAX_LEVEL)
 		max_requested.PRE_EMPHASIS = PRE_EMPHASIS_MAX_LEVEL;
-	/*
-	if (max_requested.postCursor2 > PostCursor2_MaxLevel)
-	max_requested.postCursor2 = PostCursor2_MaxLevel;
-	*/
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (max_requested.FFE_PRESET.settings.level > DP_FFE_PRESET_MAX_LEVEL)
 		max_requested.FFE_PRESET.settings.level = DP_FFE_PRESET_MAX_LEVEL;
@@ -845,61 +819,30 @@ static void find_max_drive_settings(
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
-
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
@@ -919,11 +862,11 @@ enum dc_status dp_get_lane_status_and_drive_settings(
 
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
@@ -962,55 +905,6 @@ enum dc_status dp_get_lane_status_and_drive_settings(
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
 
@@ -1140,17 +1034,18 @@ static bool perform_post_lt_adj_req_sequence(
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
@@ -1169,10 +1064,9 @@ static bool perform_post_lt_adj_req_sequence(
 
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
@@ -1180,8 +1074,8 @@ static bool perform_post_lt_adj_req_sequence(
 			}
 
 			if (req_drv_setting_changed) {
-				dp_update_drive_settings(
-					lt_settings, req_settings);
+				dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+						lt_settings->lane_settings, dpcd_lane_settings);
 
 				dc_link_dp_set_drive_settings(link,
 						lt_settings);
@@ -1261,13 +1155,14 @@ static enum link_training_result perform_channel_equalization_sequence(
 	struct link_training_settings *lt_settings,
 	uint32_t offset)
 {
-	struct link_training_settings req_settings;
 	enum dc_dp_training_pattern tr_pattern;
 	uint32_t retries_ch_eq;
 	uint32_t wait_time_microsec;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
 	union lane_align_status_updated dpcd_lane_status_updated = {0};
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	/* Note: also check that TPS4 is a supported feature*/
 
@@ -1316,12 +1211,12 @@ static enum link_training_result perform_channel_equalization_sequence(
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
@@ -1335,7 +1230,8 @@ static enum link_training_result perform_channel_equalization_sequence(
 			return LINK_TRAINING_SUCCESS;
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
-		dp_update_drive_settings(lt_settings, req_settings);
+		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+				lt_settings->lane_settings, dpcd_lane_settings);
 	}
 
 	return LINK_TRAINING_EQ_FAIL_EQ;
@@ -1361,10 +1257,10 @@ static enum link_training_result perform_clock_recovery_sequence(
 	uint32_t retries_cr;
 	uint32_t retry_count;
 	uint32_t wait_time_microsec;
-	struct link_training_settings req_settings;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
 	union lane_align_status_updated dpcd_lane_status_updated;
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	retries_cr = 0;
 	retry_count = 0;
@@ -1418,12 +1314,12 @@ static enum link_training_result perform_clock_recovery_sequence(
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
@@ -1441,33 +1337,25 @@ static enum link_training_result perform_clock_recovery_sequence(
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
+				lt_settings->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET ==
+						dpcd_lane_adjust[0].bits.VOLTAGE_SWING_LANE)
 			retries_cr++;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		else if ((dp_get_link_encoding_format(&lt_settings->link_settings) == DP_128b_132b_ENCODING) &&
+				lt_settings->dpcd_lane_settings[0].tx_ffe.PRESET_VALUE ==
+						dpcd_lane_adjust[0].tx_ffe.PRESET_VALUE)
+			retries_cr++;
+#endif
 		else
 			retries_cr = 0;
-#endif
 
 		/* 8. update VS/PE/PC2 in lt_settings*/
-		dp_update_drive_settings(lt_settings, req_settings);
-
+		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+				lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 		retry_count++;
 	}
 
@@ -2083,10 +1971,11 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	uint8_t loop_count;
 	uint32_t aux_rd_interval = 0;
 	uint32_t wait_time = 0;
-	struct link_training_settings req_settings;
 	union lane_align_status_updated dpcd_lane_status_updated = {0};
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	/* Transmit 128b/132b_TPS1 over Main-Link */
 	dp_set_hw_training_pattern(link, lt_settings->pattern_for_cr, DPRX);
@@ -2095,11 +1984,11 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 
 	/* Adjust TX_FFE_PRESET_VALUE and Transmit 128b/132b_TPS2 over Main-Link */
 	dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
-	dp_get_lane_status_and_drive_settings(link, lt_settings, dpcd_lane_status,
-			&dpcd_lane_status_updated, &req_settings, DPRX);
-	dp_update_drive_settings(lt_settings, req_settings);
+	dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
+			&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
+	dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+			lt_settings->lane_settings, dpcd_lane_settings);
 	dp_set_hw_lane_settings(link, lt_settings, DPRX);
-
 	dp_set_hw_training_pattern(link, lt_settings->pattern_for_eq, DPRX);
 
 	/* Set loop counter to start from 1 */
@@ -2113,9 +2002,10 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	while (status == LINK_TRAINING_SUCCESS) {
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
@@ -2145,8 +2035,8 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 			dp_wait_for_training_aux_rd_interval(link,
 					lt_settings->eq_pattern_time);
 			wait_time += lt_settings->eq_pattern_time;
-			dp_get_lane_status_and_drive_settings(link, lt_settings, dpcd_lane_status,
-					&dpcd_lane_status_updated, &req_settings, DPRX);
+			dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
+					&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
 		}
 	}
 
@@ -2159,9 +2049,9 @@ static enum link_training_result dp_perform_128b_132b_cds_done_sequence(
 {
 	/* Assumption: assume hardware has transmitted eq pattern */
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
-	struct link_training_settings req_settings;
 	union lane_align_status_updated dpcd_lane_status_updated = {0};
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
 	uint32_t wait_time = 0;
 
 	/* initiate CDS done sequence */
@@ -2172,8 +2062,8 @@ static enum link_training_result dp_perform_128b_132b_cds_done_sequence(
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
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index e9006d099393..c971f8c761ca 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -263,10 +263,12 @@ static enum link_training_result dpia_training_cr_non_transparent(struct dc_link
 	uint32_t retry_count = 0;
 	/* From DP spec, CR read interval is always 100us. */
 	uint32_t wait_time_microsec = TRAINING_AUX_RD_INTERVAL;
-	struct link_training_settings req_settings;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
+
 	uint8_t set_cfg_data;
 	enum dpia_set_config_ts ts;
 
@@ -345,11 +347,12 @@ static enum link_training_result dpia_training_cr_non_transparent(struct dc_link
 		dp_wait_for_training_aux_rd_interval(link, wait_time_microsec);
 
 		/* Read status and adjustment requests from DPCD. */
-		status = dp_get_lane_status_and_drive_settings(link,
+		status = dp_get_lane_status_and_lane_adjust(
+				link,
 				lt_settings,
 				dpcd_lane_status,
 				&dpcd_lane_status_updated,
-				&req_settings,
+				dpcd_lane_adjust,
 				hop);
 		if (status != DC_OK) {
 			result = LINK_TRAINING_ABORT;
@@ -371,16 +374,18 @@ static enum link_training_result dpia_training_cr_non_transparent(struct dc_link
 		 * Note: settings are the same for all lanes,
 		 * so comparing first lane is sufficient.
 		 */
-		if (lt_settings->lane_settings[0].VOLTAGE_SWING ==
-			req_settings.lane_settings[0].VOLTAGE_SWING &&
-			lt_settings->lane_settings[0].PRE_EMPHASIS ==
-			req_settings.lane_settings[0].PRE_EMPHASIS)
+		if ((lt_settings->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET ==
+				dpcd_lane_adjust[0].bits.VOLTAGE_SWING_LANE)
+				&& (lt_settings->dpcd_lane_settings[0].bits.PRE_EMPHASIS_SET ==
+						dpcd_lane_adjust[0].bits.PRE_EMPHASIS_LANE))
 			retries_cr++;
 		else
 			retries_cr = 0;
 
 		/* Update VS/PE. */
-		dp_update_drive_settings(lt_settings, req_settings);
+		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+				lt_settings->lane_settings,
+				dpcd_lane_settings);
 		retry_count++;
 	}
 
@@ -416,10 +421,11 @@ static enum link_training_result dpia_training_cr_transparent(struct dc_link *li
 	uint32_t retries_cr = 0; /* Number of consecutive attempts with same VS or PE. */
 	uint32_t retry_count = 0;
 	uint32_t wait_time_microsec = lt_settings->cr_pattern_time;
-	struct link_training_settings req_settings;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	/* Cap of LINK_TRAINING_MAX_CR_RETRY attempts at clock recovery.
 	 * Fix inherited from perform_clock_recovery_sequence() -
@@ -445,11 +451,12 @@ static enum link_training_result dpia_training_cr_transparent(struct dc_link *li
 		dp_wait_for_training_aux_rd_interval(link, wait_time_microsec);
 
 		/* Read status and adjustment requests from DPCD. */
-		status = dp_get_lane_status_and_drive_settings(link,
+		status = dp_get_lane_status_and_lane_adjust(
+				link,
 				lt_settings,
 				dpcd_lane_status,
 				&dpcd_lane_status_updated,
-				&req_settings,
+				dpcd_lane_adjust,
 				DPRX);
 		if (status != DC_OK) {
 			result = LINK_TRAINING_ABORT;
@@ -471,16 +478,17 @@ static enum link_training_result dpia_training_cr_transparent(struct dc_link *li
 		 * Note: settings are the same for all lanes,
 		 * so comparing first lane is sufficient.
 		 */
-		if (lt_settings->lane_settings[0].VOLTAGE_SWING ==
-			req_settings.lane_settings[0].VOLTAGE_SWING &&
-			lt_settings->lane_settings[0].PRE_EMPHASIS ==
-			req_settings.lane_settings[0].PRE_EMPHASIS)
+		if ((lt_settings->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET ==
+				dpcd_lane_adjust[0].bits.VOLTAGE_SWING_LANE)
+				&& (lt_settings->dpcd_lane_settings[0].bits.PRE_EMPHASIS_SET ==
+						dpcd_lane_adjust[0].bits.PRE_EMPHASIS_LANE))
 			retries_cr++;
 		else
 			retries_cr = 0;
 
 		/* Update VS/PE. */
-		dp_update_drive_settings(lt_settings, req_settings);
+		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+				lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 		retry_count++;
 	}
 
@@ -566,10 +574,11 @@ static enum link_training_result dpia_training_eq_non_transparent(struct dc_link
 	enum dc_status status;
 	enum dc_dp_training_pattern tr_pattern;
 	uint32_t wait_time_microsec;
-	struct link_training_settings req_settings;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 	uint8_t set_cfg_data;
 	enum dpia_set_config_ts ts;
 
@@ -639,11 +648,12 @@ static enum link_training_result dpia_training_eq_non_transparent(struct dc_link
 		dp_wait_for_training_aux_rd_interval(link, wait_time_microsec);
 
 		/* Read status and adjustment requests from DPCD. */
-		status = dp_get_lane_status_and_drive_settings(link,
+		status = dp_get_lane_status_and_lane_adjust(
+				link,
 				lt_settings,
 				dpcd_lane_status,
 				&dpcd_lane_status_updated,
-				&req_settings,
+				dpcd_lane_adjust,
 				hop);
 		if (status != DC_OK) {
 			result = LINK_TRAINING_ABORT;
@@ -664,7 +674,8 @@ static enum link_training_result dpia_training_eq_non_transparent(struct dc_link
 		}
 
 		/* Update VS/PE. */
-		dp_update_drive_settings(lt_settings, req_settings);
+		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+				lt_settings->lane_settings, dpcd_lane_settings);
 	}
 
 	/* Abort link training if equalization failed due to HPD unplug. */
@@ -701,10 +712,11 @@ static enum link_training_result dpia_training_eq_transparent(struct dc_link *li
 	enum dc_status status;
 	enum dc_dp_training_pattern tr_pattern = lt_settings->pattern_for_eq;
 	uint32_t wait_time_microsec;
-	struct link_training_settings req_settings;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	wait_time_microsec = dpia_get_eq_aux_rd_interval(link, lt_settings, DPRX);
 
@@ -720,11 +732,12 @@ static enum link_training_result dpia_training_eq_transparent(struct dc_link *li
 		dp_wait_for_training_aux_rd_interval(link, wait_time_microsec);
 
 		/* Read status and adjustment requests from DPCD. */
-		status = dp_get_lane_status_and_drive_settings(link,
+		status = dp_get_lane_status_and_lane_adjust(
+				link,
 				lt_settings,
 				dpcd_lane_status,
 				&dpcd_lane_status_updated,
-				&req_settings,
+				dpcd_lane_adjust,
 				DPRX);
 		if (status != DC_OK) {
 			result = LINK_TRAINING_ABORT;
@@ -745,7 +758,8 @@ static enum link_training_result dpia_training_eq_transparent(struct dc_link *li
 		}
 
 		/* Update VS/PE. */
-		dp_update_drive_settings(lt_settings, req_settings);
+		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+				lt_settings->lane_settings, dpcd_lane_settings);
 	}
 
 	/* Abort link training if equalization failed due to HPD unplug. */
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
 
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 9a16fc855254..dc30dcd918bb 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -123,6 +123,23 @@ struct link_training_settings {
 	/* dpcd lane settings will always use the same hw lane settings
 	 * even if it doesn't match requested lane adjust */
 	bool always_match_dpcd_with_hw_lane_settings;
+
+	/*****************************************************************
+	* training states - parameters that can change in link training
+	*****************************************************************/
+	/* TODO: Move hw_lane_settings and dpcd_lane_settings
+	 * along with lane adjust, lane align, offset and all
+	 * other training states into a new structure called
+	 * training states, so link_training_settings becomes
+	 * a constant input pre-decided prior to link training.
+	 *
+	 * The goal is to strictly decouple link training settings
+	 * decision making process from link training states to
+	 * prevent it from messy code practice of changing training
+	 * decision on the fly.
+	 */
+	struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX];
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX];
 };
 
 /*TODO: Move this enum test harness*/
-- 
2.25.1

