Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB96C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE6560724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCE6560724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D9E46E169;
	Sun, 24 Oct 2021 13:32:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3CB889E3B
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvbRwhFZ8u3uT+0+Fl7iEbbzbSz0YUOG5nJhVnpgKN+NGWe9XfSgmym1AxFc/ceYhp1xRFFt8kvjOhqfpqxlkRFc2Q+byfU+wSPZpKXLblCmlKXCYcT1ta9mYX/roaDbLXKGxvpeEo9xGMQC9+CV+s11w+Lnl+d4QOsyKRxoADw6lEjIXcojEcGFn3aB+f18clBsHiN7O6sOyF0lsg9LH9gY/IR4fDqNau5Ze6S2DubF1WU3in7FkwdkWLqzVhNc8SUN0L0LFDnqA9Ny9GEJZvLmaEBgdGJL72/sNlVxeNSES/NfMKT13LiQFpXAv5cSjC5+8XR0MyVgfvF5fWrBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CdgIFDMe1FjzKFdt+Rb4TkKg8G1No5LlTavji5fwLI=;
 b=RBBdR6z/7G6oJSN80l9CO6M3+kzFGy5Tx7CSXEg9tnYFKun9I+w5erN3Za9gq0cKzryE0i/H+QeJsjTYV7Yn+ljKxP3xAve5C8JRlGmnWAVv8NWqx8M0nsvSeNcWbHXlaamG7FNe4fP//g1TSNub5kR2HDEWFGQM7pcEnAVlESoTg2nFSsvrDYV6hZ55fgwV2PhEFOPQBKVkQeYvXg/9+Pop3l7goqb/gxGJoOWEQ//wwVyIvg153gKWTSE5/nlMY57EVSX/7IaniKEg7zc6zr5YU6dXcvFYh3ZkrXtxVdXzkvv/jx4+qv31lp41JMcKUSojL5TFRGysnnV6k2fOIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CdgIFDMe1FjzKFdt+Rb4TkKg8G1No5LlTavji5fwLI=;
 b=CFesHv46s92Djm4BXpPaJfDR8JQ+VDxb4a2X7EbdjdDNE2GWoC/cCU5otUGHvRhHTTnFoJKDsN7OKWYoK1CPs16Giv8mjZB5Pxu3m6xpZXLbKOOUo3cgYguNbCjH7/Py7cTHOUFWGkitO/7gVmzkYYCa6PhgroRyk0Yz7yin5zI=
Received: from CO2PR04CA0151.namprd04.prod.outlook.com (2603:10b6:104::29) by
 BYAPR12MB3333.namprd12.prod.outlook.com (2603:10b6:a03:a9::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Sun, 24 Oct 2021 13:32:42 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::c4) by CO2PR04CA0151.outlook.office365.com
 (2603:10b6:104::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
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
 2021 08:32:41 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 30/33] drm/amd/display: decouple hw_lane_settings from
 dpcd_lane_settings
Date: Sun, 24 Oct 2021 09:31:38 -0400
Message-ID: <20211024133141.239861-31-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a06dcb78-3d08-4312-216d-08d996f2c1dc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3333:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3333F52DD28B1E960B7D564298829@BYAPR12MB3333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAA/Up/5pQW6WwLmuDAadU2OsKkiGsQwoel5FjAMJUWorZ8Xk2Sl2mMYlnHdencWVjVAbW9QEfcu6IojaflPj0IzVSKzVkoDD/P8ymEHfCpScVe3uRqjeAFMnvxqhPYcDM4MAsj7emSsuE8+epZ408xhEqNQYs4TVXXzCxle8lGsdpZj2/QDLxJd8E3RQug6e07s52ZHNdsvpoQeUVEkOLE6SbclWeqIwYfAYPqMrd87Ke6xBNHzvML46wsQgfuJLx1czjDbfxFWMI5p6AQ+e8MiLmvrbnGxuMQTPM5rgblvn0mQNCmjL6/YaG4KmE9ruGonGt6OjKxOQeCvCl4tUGi1Si9FROGK59p9G7BUbGpY2uyv1n7mKcB+Osjv+vBrqepFv+MQP0E7LilRhXncuJjR/aMItuY+OqekZCR0hCG8CtK14EQbNzBOKhMDBvnugccj0x12fDBzBM+zsbVCfioqqPWMd6+3YGF/RjSPKCvpmzKhK/egjWRq6wbkdYQaO0TFY5eA3EruZunAXvYfOwzImKBxZa1n0yNhrd6C/khquo7ZXK4L3+/6QArkxTRKN/VNBAB1u7KOrqbEhhCM4EQn6Yr0dXdJ3cVj1N0mseIH29r/vJfP1qE159dmotDG7G/9bSvnVSeCXIEOoxMvg0EOQhyMeOceQMZom5aTAsDCa/eQ04Xs/W97h9S2wmmQ56LiAh8l8dciACzeWMbJyczwU1IepO3TajYiqLAb/Jg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(30864003)(6666004)(82310400003)(426003)(186003)(36756003)(508600001)(2616005)(86362001)(356005)(8936002)(6916009)(4326008)(83380400001)(16526019)(70206006)(47076005)(8676002)(316002)(1076003)(2906002)(5660300002)(81166007)(70586007)(26005)(36860700001)(336012)(19627235002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:42.6767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06dcb78-3d08-4312-216d-08d996f2c1dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
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
As DP features expands, we have encountered many situations where we
must configure a different DPCD lane setting from hw lane settings we
output.  The change is to decouple hw lane settings from dpcd lane
settings to provide flexibility to configure dpcd and hw individually.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 148 +++++++-----------
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   5 -
 .../amd/display/include/link_service_types.h  |   5 +-
 4 files changed, 63 insertions(+), 106 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index fff238f07b9e..8f27097d56cc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -516,8 +516,6 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 	enum dc_dp_training_pattern pattern,
 	uint32_t offset)
 {
-	union dpcd_training_lane dpcd_lane[LANE_COUNT_DP_MAX] = { { {0} } };
-
 	uint32_t dpcd_base_lt_offset;
 
 	uint8_t dpcd_lt_buffer[5] = {0};
@@ -555,16 +553,14 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 			dpcd_pattern.v1_4.TRAINING_PATTERN_SET);
 	}
 
-	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->lane_settings, dpcd_lane);
-
 	/* concatenate everything into one buffer*/
-
-	size_in_bytes = lt_settings->link_settings.lane_count * sizeof(dpcd_lane[0]);
+	size_in_bytes = lt_settings->link_settings.lane_count *
+			sizeof(lt_settings->dpcd_lane_settings[0]);
 
 	 // 0x00103 - 0x00102
 	memmove(
 		&dpcd_lt_buffer[DP_TRAINING_LANE0_SET - DP_TRAINING_PATTERN_SET],
-		dpcd_lane,
+		lt_settings->dpcd_lane_settings,
 		size_in_bytes);
 
 	if (is_repeater(link, offset)) {
@@ -576,7 +572,7 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 					__func__,
 					offset,
 					dpcd_base_lt_offset,
-					dpcd_lane[0].tx_ffe.PRESET_VALUE);
+					lt_settings->dpcd_lane_settings[0].tx_ffe.PRESET_VALUE);
 		else if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
 				DP_8b_10b_ENCODING)
 #endif
@@ -585,10 +581,10 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 			__func__,
 			offset,
 			dpcd_base_lt_offset,
-			dpcd_lane[0].bits.VOLTAGE_SWING_SET,
-			dpcd_lane[0].bits.PRE_EMPHASIS_SET,
-			dpcd_lane[0].bits.MAX_SWING_REACHED,
-			dpcd_lane[0].bits.MAX_PRE_EMPHASIS_REACHED);
+			lt_settings->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET,
+			lt_settings->dpcd_lane_settings[0].bits.PRE_EMPHASIS_SET,
+			lt_settings->dpcd_lane_settings[0].bits.MAX_SWING_REACHED,
+			lt_settings->dpcd_lane_settings[0].bits.MAX_PRE_EMPHASIS_REACHED);
 	} else {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
@@ -596,17 +592,17 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 			DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X TX_FFE_PRESET_VALUE = %x\n",
 					__func__,
 					dpcd_base_lt_offset,
-					dpcd_lane[0].tx_ffe.PRESET_VALUE);
+					lt_settings->dpcd_lane_settings[0].tx_ffe.PRESET_VALUE);
 		else if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
 				DP_8b_10b_ENCODING)
 #endif
 		DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X VS set = %x  PE set = %x max VS Reached = %x  max PE Reached = %x\n",
 			__func__,
 			dpcd_base_lt_offset,
-			dpcd_lane[0].bits.VOLTAGE_SWING_SET,
-			dpcd_lane[0].bits.PRE_EMPHASIS_SET,
-			dpcd_lane[0].bits.MAX_SWING_REACHED,
-			dpcd_lane[0].bits.MAX_PRE_EMPHASIS_REACHED);
+			lt_settings->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET,
+			lt_settings->dpcd_lane_settings[0].bits.PRE_EMPHASIS_SET,
+			lt_settings->dpcd_lane_settings[0].bits.MAX_SWING_REACHED,
+			lt_settings->dpcd_lane_settings[0].bits.MAX_PRE_EMPHASIS_REACHED);
 	}
 	if (edp_workaround) {
 		/* for eDP write in 2 parts because the 5-byte burst is
@@ -621,7 +617,7 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 		core_link_write_dpcd(
 			link,
 			DP_TRAINING_LANE0_SET,
-			(uint8_t *)(dpcd_lane),
+			(uint8_t *)(lt_settings->dpcd_lane_settings),
 			size_in_bytes);
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
@@ -913,7 +909,6 @@ enum dc_status dpcd_set_lane_settings(
 	const struct link_training_settings *link_training_setting,
 	uint32_t offset)
 {
-	union dpcd_training_lane dpcd_lane[LANE_COUNT_DP_MAX] = {{{0}}};
 	unsigned int lane0_set_address;
 	enum dc_status status;
 
@@ -923,34 +918,11 @@ enum dc_status dpcd_set_lane_settings(
 		lane0_set_address = DP_TRAINING_LANE0_SET_PHY_REPEATER1 +
 		((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
 
-	dp_hw_to_dpcd_lane_settings(link_training_setting,
-			link_training_setting->lane_settings,
-			dpcd_lane);
-
 	status = core_link_write_dpcd(link,
 		lane0_set_address,
-		(uint8_t *)(dpcd_lane),
+		(uint8_t *)(link_training_setting->dpcd_lane_settings),
 		link_training_setting->link_settings.lane_count);
 
-	/*
-	if (LTSettings.link.rate == LinkRate_High2)
-	{
-		DpcdTrainingLaneSet2 dpcd_lane2[lane_count_DPMax] = {0};
-		for ( uint32_t lane = 0;
-		lane < lane_count_DPMax; lane++)
-		{
-			dpcd_lane2[lane].bits.post_cursor2_set =
-			static_cast<unsigned char>(
-			LTSettings.laneSettings[lane].postCursor2);
-			dpcd_lane2[lane].bits.max_post_cursor2_reached = 0;
-		}
-		m_pDpcdAccessSrv->WriteDpcdData(
-		DpcdAddress_Lane0Set2,
-		reinterpret_cast<unsigned char*>(dpcd_lane2),
-		LTSettings.link.lanes);
-	}
-	*/
-
 	if (is_repeater(link, offset)) {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
@@ -960,7 +932,7 @@ enum dc_status dpcd_set_lane_settings(
 					__func__,
 					offset,
 					lane0_set_address,
-					dpcd_lane[0].tx_ffe.PRESET_VALUE);
+					link_training_setting->dpcd_lane_settings[0].tx_ffe.PRESET_VALUE);
 		else if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
 				DP_8b_10b_ENCODING)
 #endif
@@ -969,10 +941,10 @@ enum dc_status dpcd_set_lane_settings(
 			__func__,
 			offset,
 			lane0_set_address,
-			dpcd_lane[0].bits.VOLTAGE_SWING_SET,
-			dpcd_lane[0].bits.PRE_EMPHASIS_SET,
-			dpcd_lane[0].bits.MAX_SWING_REACHED,
-			dpcd_lane[0].bits.MAX_PRE_EMPHASIS_REACHED);
+			link_training_setting->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET,
+			link_training_setting->dpcd_lane_settings[0].bits.PRE_EMPHASIS_SET,
+			link_training_setting->dpcd_lane_settings[0].bits.MAX_SWING_REACHED,
+			link_training_setting->dpcd_lane_settings[0].bits.MAX_PRE_EMPHASIS_REACHED);
 
 	} else {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
@@ -981,17 +953,17 @@ enum dc_status dpcd_set_lane_settings(
 			DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X TX_FFE_PRESET_VALUE = %x\n",
 					__func__,
 					lane0_set_address,
-					dpcd_lane[0].tx_ffe.PRESET_VALUE);
+					link_training_setting->dpcd_lane_settings[0].tx_ffe.PRESET_VALUE);
 		else if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
 				DP_8b_10b_ENCODING)
 #endif
 		DC_LOG_HW_LINK_TRAINING("%s\n 0x%X VS set = %x  PE set = %x max VS Reached = %x  max PE Reached = %x\n",
 			__func__,
 			lane0_set_address,
-			dpcd_lane[0].bits.VOLTAGE_SWING_SET,
-			dpcd_lane[0].bits.PRE_EMPHASIS_SET,
-			dpcd_lane[0].bits.MAX_SWING_REACHED,
-			dpcd_lane[0].bits.MAX_PRE_EMPHASIS_REACHED);
+			link_training_setting->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET,
+			link_training_setting->dpcd_lane_settings[0].bits.PRE_EMPHASIS_SET,
+			link_training_setting->dpcd_lane_settings[0].bits.MAX_SWING_REACHED,
+			link_training_setting->dpcd_lane_settings[0].bits.MAX_PRE_EMPHASIS_REACHED);
 	}
 
 	return status;
@@ -1004,7 +976,7 @@ bool dp_is_max_vs_reached(
 	for (lane = 0; lane <
 		(uint32_t)(lt_settings->link_settings.lane_count);
 		lane++) {
-		if (lt_settings->lane_settings[lane].VOLTAGE_SWING
+		if (lt_settings->dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET
 			== VOLTAGE_SWING_MAX_LEVEL)
 			return true;
 	}
@@ -1038,7 +1010,6 @@ static bool perform_post_lt_adj_req_sequence(
 			union lane_align_status_updated
 				dpcd_lane_status_updated;
 			union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
-			union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 			dp_get_lane_status_and_lane_adjust(
 				link,
@@ -1063,9 +1034,9 @@ static bool perform_post_lt_adj_req_sequence(
 			for (lane = 0; lane < (uint32_t)(lane_count); lane++) {
 
 				if (lt_settings->
-				lane_settings[lane].VOLTAGE_SWING !=
+				dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET !=
 				dpcd_lane_adjust[lane].bits.VOLTAGE_SWING_LANE ||
-				lt_settings->lane_settings[lane].PRE_EMPHASIS !=
+				lt_settings->dpcd_lane_settings[lane].bits.PRE_EMPHASIS_SET !=
 				dpcd_lane_adjust[lane].bits.PRE_EMPHASIS_LANE) {
 
 					req_drv_setting_changed = true;
@@ -1075,7 +1046,7 @@ static bool perform_post_lt_adj_req_sequence(
 
 			if (req_drv_setting_changed) {
 				dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-						lt_settings->lane_settings, dpcd_lane_settings);
+						lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 
 				dc_link_dp_set_drive_settings(link,
 						lt_settings);
@@ -1162,10 +1133,8 @@ static enum link_training_result perform_channel_equalization_sequence(
 	union lane_align_status_updated dpcd_lane_status_updated = {0};
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
 	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
-	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	/* Note: also check that TPS4 is a supported feature*/
-
 	tr_pattern = lt_settings->pattern_for_eq;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
@@ -1231,7 +1200,7 @@ static enum link_training_result perform_channel_equalization_sequence(
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-				lt_settings->lane_settings, dpcd_lane_settings);
+				lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 	}
 
 	return LINK_TRAINING_EQ_FAIL_EQ;
@@ -1484,6 +1453,7 @@ static inline void decide_8b_10b_training_settings(
 	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_setting);
 	lt_settings->enhanced_framing = 1;
 	lt_settings->should_set_fec_ready = true;
+	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 }
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
@@ -1509,6 +1479,8 @@ static inline void decide_128b_132b_training_settings(struct dc_link *link,
 			link->dpcd_caps.lttpr_caps.phy_repeater_cnt) + 1) * 20000;
 	lt_settings->lttpr_mode = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) ?
 			LTTPR_MODE_NON_TRANSPARENT : LTTPR_MODE_TRANSPARENT;
+	dp_hw_to_dpcd_lane_settings(lt_settings,
+			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 }
 #endif
 
@@ -1571,6 +1543,9 @@ static void override_training_settings(
 			: POST_CURSOR2_DISABLED;
 	}
 
+	dp_hw_to_dpcd_lane_settings(lt_settings,
+			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
+
 	/* Initialize training timings */
 	if (overrides->cr_pattern_time != NULL)
 		lt_settings->cr_pattern_time = *overrides->cr_pattern_time;
@@ -1841,6 +1816,9 @@ void dc_link_dp_set_drive_settings(
 	/* program ASIC PHY settings*/
 	dp_set_hw_lane_settings(link, lt_settings, DPRX);
 
+	dp_hw_to_dpcd_lane_settings(lt_settings,
+			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
+
 	/* Notify DP sink the PHY settings from source */
 	dpcd_set_lane_settings(link, lt_settings, DPRX);
 }
@@ -1975,7 +1953,6 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
-	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	/* Transmit 128b/132b_TPS1 over Main-Link */
 	dp_set_hw_training_pattern(link, lt_settings->pattern_for_cr, DPRX);
@@ -1987,7 +1964,7 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
 			&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
 	dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-			lt_settings->lane_settings, dpcd_lane_settings);
+			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 	dp_set_hw_lane_settings(link, lt_settings, DPRX);
 	dp_set_hw_training_pattern(link, lt_settings->pattern_for_eq, DPRX);
 
@@ -2005,7 +1982,7 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 		dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
 				&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-				lt_settings->lane_settings, dpcd_lane_settings);
+			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 		dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
 		if (dp_is_ch_eq_done(lt_settings->link_settings.lane_count,
 				dpcd_lane_status)) {
@@ -2120,7 +2097,7 @@ static enum link_training_result dp_perform_8b_10b_link_training(
 		}
 
 		for (lane = 0; lane < (uint8_t)lt_settings->link_settings.lane_count; lane++)
-			lt_settings->lane_settings[lane].VOLTAGE_SWING = VOLTAGE_SWING_LEVEL0;
+			lt_settings->dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET = VOLTAGE_SWING_LEVEL0;
 	}
 
 	if (status == LINK_TRAINING_SUCCESS) {
@@ -3496,15 +3473,13 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 #endif
 	unsigned int test_pattern_size = 0;
 	enum dp_test_pattern test_pattern;
-	struct dc_link_training_settings link_settings;
 	union lane_adjust dpcd_lane_adjust;
 	unsigned int lane;
 	struct link_training_settings link_training_settings;
-	int i = 0;
 
 	dpcd_test_pattern.raw = 0;
 	memset(dpcd_lane_adjustment, 0, sizeof(dpcd_lane_adjustment));
-	memset(&link_settings, 0, sizeof(link_settings));
+	memset(&link_training_settings, 0, sizeof(link_training_settings));
 
 	/* get phy test pattern and pattern parameters from DP receiver */
 	core_link_read_dpcd(
@@ -3625,48 +3600,37 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 #endif
 
 	/* prepare link training settings */
-	link_settings.link = link->cur_link_settings;
+	link_training_settings.link_settings = link->cur_link_settings;
 
 	for (lane = 0; lane <
 		(unsigned int)(link->cur_link_settings.lane_count);
 		lane++) {
 		dpcd_lane_adjust.raw =
 			get_nibble_at_index(&dpcd_lane_adjustment[0].raw, lane);
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (dp_get_link_encoding_format(&link->cur_link_settings) ==
-				DP_128b_132b_ENCODING) {
-			link_settings.lane_settings[lane].FFE_PRESET.raw =
-					dpcd_lane_adjust.tx_ffe.PRESET_VALUE;
-		} else if (dp_get_link_encoding_format(&link->cur_link_settings) ==
 				DP_8b_10b_ENCODING) {
-			link_settings.lane_settings[lane].VOLTAGE_SWING =
+			link_training_settings.hw_lane_settings[lane].VOLTAGE_SWING =
 				(enum dc_voltage_swing)
 				(dpcd_lane_adjust.bits.VOLTAGE_SWING_LANE);
-			link_settings.lane_settings[lane].PRE_EMPHASIS =
+			link_training_settings.hw_lane_settings[lane].PRE_EMPHASIS =
 				(enum dc_pre_emphasis)
 				(dpcd_lane_adjust.bits.PRE_EMPHASIS_LANE);
-			link_settings.lane_settings[lane].POST_CURSOR2 =
+			link_training_settings.hw_lane_settings[lane].POST_CURSOR2 =
 				(enum dc_post_cursor2)
 				((dpcd_post_cursor_2_adjustment >> (lane * 2)) & 0x03);
 		}
-#else
-		link_settings.lane_settings[lane].VOLTAGE_SWING =
-			(enum dc_voltage_swing)
-			(dpcd_lane_adjust.bits.VOLTAGE_SWING_LANE);
-		link_settings.lane_settings[lane].PRE_EMPHASIS =
-			(enum dc_pre_emphasis)
-			(dpcd_lane_adjust.bits.PRE_EMPHASIS_LANE);
-		link_settings.lane_settings[lane].POST_CURSOR2 =
-			(enum dc_post_cursor2)
-			((dpcd_post_cursor_2_adjustment >> (lane * 2)) & 0x03);
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		else if (dp_get_link_encoding_format(&link->cur_link_settings) ==
+				DP_128b_132b_ENCODING) {
+			link_training_settings.hw_lane_settings[lane].FFE_PRESET.raw =
+					dpcd_lane_adjust.tx_ffe.PRESET_VALUE;
+		}
 #endif
 	}
 
-	for (i = 0; i < 4; i++)
-		link_training_settings.lane_settings[i] =
-				link_settings.lane_settings[i];
-	link_training_settings.link_settings = link_settings.link;
-	link_training_settings.allow_invalid_msa_timing_param = false;
+	dp_hw_to_dpcd_lane_settings(&link_training_settings,
+			link_training_settings.hw_lane_settings,
+			link_training_settings.dpcd_lane_settings);
 	/*Usage: Measure DP physical lane signal
 	 * by DP SI test equipment automatically.
 	 * PHY test pattern request is generated by equipment via HPD interrupt.
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index c971f8c761ca..b1c9f77d6bf4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -267,8 +267,6 @@ static enum link_training_result dpia_training_cr_non_transparent(struct dc_link
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
 	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
-	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
-
 	uint8_t set_cfg_data;
 	enum dpia_set_config_ts ts;
 
@@ -385,7 +383,7 @@ static enum link_training_result dpia_training_cr_non_transparent(struct dc_link
 		/* Update VS/PE. */
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
 				lt_settings->lane_settings,
-				dpcd_lane_settings);
+				lt_settings->dpcd_lane_settings);
 		retry_count++;
 	}
 
@@ -425,7 +423,6 @@ static enum link_training_result dpia_training_cr_transparent(struct dc_link *li
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
 	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
-	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	/* Cap of LINK_TRAINING_MAX_CR_RETRY attempts at clock recovery.
 	 * Fix inherited from perform_clock_recovery_sequence() -
@@ -578,7 +575,6 @@ static enum link_training_result dpia_training_eq_non_transparent(struct dc_link
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
 	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
-	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 	uint8_t set_cfg_data;
 	enum dpia_set_config_ts ts;
 
@@ -675,7 +671,7 @@ static enum link_training_result dpia_training_eq_non_transparent(struct dc_link
 
 		/* Update VS/PE. */
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-				lt_settings->lane_settings, dpcd_lane_settings);
+				lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 	}
 
 	/* Abort link training if equalization failed due to HPD unplug. */
@@ -716,7 +712,6 @@ static enum link_training_result dpia_training_eq_transparent(struct dc_link *li
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
 	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
-	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	wait_time_microsec = dpia_get_eq_aux_rd_interval(link, lt_settings, DPRX);
 
@@ -759,7 +754,7 @@ static enum link_training_result dpia_training_eq_transparent(struct dc_link *li
 
 		/* Update VS/PE. */
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-				lt_settings->lane_settings, dpcd_lane_settings);
+				lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 	}
 
 	/* Abort link training if equalization failed due to HPD unplug. */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index a23937e1dc5c..bc87ea0adf94 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -174,11 +174,6 @@ struct dc_lane_settings {
 #endif
 };
 
-struct dc_link_training_settings {
-	struct dc_link_settings link;
-	struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX];
-};
-
 struct dc_link_training_overrides {
 	enum dc_voltage_swing *voltage_swing;
 	enum dc_pre_emphasis *pre_emphasis;
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index dc30dcd918bb..622c03f15df2 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -90,8 +90,11 @@ enum lttpr_mode {
 
 struct link_training_settings {
 	struct dc_link_settings link_settings;
-	struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX];
 
+	/* TODO: turn lane settings below into mandatory fields
+	 * as initial lane configuration
+	 */
+	struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX];
 	enum dc_voltage_swing *voltage_swing;
 	enum dc_pre_emphasis *pre_emphasis;
 	enum dc_post_cursor2 *post_cursor2;
-- 
2.25.1

