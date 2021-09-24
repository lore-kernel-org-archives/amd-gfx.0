Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B65C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AFA61250
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0AFA61250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B4B6E21A;
	Fri, 24 Sep 2021 19:10:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A545A6E218
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vd3HQI0CdVOAH33Z/hWh6Ztber90J1FiEtsC7ObpmbgMKOZYqD7WNzfRe5EXy/XVLr5CEF6w2skzlj85zQO80v95UsxIldrBE9KUi9IlB1958lbmTTcbIO9VPJc0NZHBbZx5JWw669uIkmk4vmuTvzV7kv9Fu7xYNhHiP7L26uJiSj87LzjNIcDr93onG+Fj/Zi5SR+iT9eJPalNrf5jxM1ikAoLuK2ke7Ai3yB5Aq/cPv86IdQm3vsTNgT0xMS/Jk4TAapIySuqPMjCaEthcIxPQSJ8hysACIbdGvU1Y8gXhE9YGCVTMl8xyyHBoE4RnVJGlUpx1ztkR8x7DSNbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=zEilNXTWvi6x0gj7kAJzC2zLV48XT1TxBQxVZwbKmAk=;
 b=TATYlAdwBt1HGVfgexDPiG/88QzKLtTG4+OnS6EiJVw5o713SzJ6XAhsI+N5X+nefqH4Q3vA12lBKpiew5PzOc4U3XxgmZ5Xr5gdcxFTtQVMeb97wmHeHI9nUgXbI6eK94W8B1KooT0gMDQwdKw0v+zT14jPmY9rJrQ+6JJn5zvJxjbYd1+25722DAOw043mhheAstsf1lhGU8jNslavdNmEZIMXxI6MpL/poWDhuPfKYbZ5BGMYdk3PKm8CGsi6Mh8loPKsIxIGAoKZwqkwVcrtpAkV0OeHy6W/GuwzmBX959SJeKzN/G9uvyD9D8dn3K4Y0oMIB+l2J3SmmLchlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEilNXTWvi6x0gj7kAJzC2zLV48XT1TxBQxVZwbKmAk=;
 b=Qr5JV+EFrSTkC1rljDPTTPpeNosU9dbQag+bfbkkafbePtnoSLpTWCDkN8SGWaxGQGws6bBGriX6c6vQorblTooL9hM95Yvoo9vXurxtnEYuG2Qsf1UatgztWaZBWxitatIlptz1bhj3/fqIaWDQjdNUhEoYm2FweFNRwSRwE9w=
Received: from CO2PR05CA0095.namprd05.prod.outlook.com (2603:10b6:104:1::21)
 by MWHPR1201MB0208.namprd12.prod.outlook.com (2603:10b6:301:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 19:10:08 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::c5) by CO2PR05CA0095.outlook.office365.com
 (2603:10b6:104:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:08 +0000
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
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:04 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:02 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 10/24] drm/amd/display: decouple hw_lane_settings from
 dpcd_lane_settings
Date: Fri, 24 Sep 2021 15:09:20 -0400
Message-ID: <20210924190934.1193379-11-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 191d0eac-6c75-4008-1fa4-08d97f8eec92
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0208:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0208439BBCEBF0C3D42F50D0EBA49@MWHPR1201MB0208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAkylYkLRmGJqMc33rH8f2mRIQl3EcmzJ7Z3FvUo7iyVWCGV2Da0SqenNVCKPpKKleGcikPEJQR8KrryKEJwRe2J9QQQGLlLOXvO+gyqgxUyyLsA5ni7jTmXfEK+gD9gZfy4adH0k9TaXfvqxQPXTD8C0LKNLlG4dJKJeYKjX9hT++vfH26l3p4qDafA8Ha3Y5LlisNupZXo0e5RNpGKvjCwu5DDTZKYAs/LJ6HqKD7QX2PEQ80VtZAAACXFUWxx2ikBjS2VleVldk6wMDnObFXuO6v5ByU6J3lgGjs4SHe8udTYo1OBeBJXAetVL+cvBrZjQyTKa+rKQ1lin4Xdm0XV4n9lK9VsTlzIaEdrSgWJPHIe+Da3dr2BK1hs44OHTRoN1Pcnmrj3LmZ5/KbvzTkW9fjbb1KkmX/5j/V+jDy91KEu1yMyERL9opT/ZdKtTfpXMqExaeUpfULUfLUVSfERgE0Cxy6gBy5IkfV66gNP3UcdyNibSYx4eLFYc6H+GU+oL2qDiw606P9i7Tz5y0IJMnsfd6sBwmfbBfnJikvzka8+EUnWhiTpD9gcY38Mg9jMA6OwBAzczM1IW8FfngDiNTM3p8r/cbrkl5hBCSXxtlcRsrLbsRbGGDFR0pG35Mvbo5QhxHcC2BLv/91/lUoNsE2+K9CQjpfoSj5Gd7AYGQ4y1CQ0TeAJL9j8WpWohMg694wmdYMpiO3OnmAutKhL2x8GXQBUfkdEq8KhU+s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(8676002)(83380400001)(30864003)(54906003)(2616005)(356005)(316002)(186003)(82310400003)(19627235002)(336012)(426003)(2906002)(26005)(8936002)(70206006)(86362001)(81166007)(508600001)(36756003)(1076003)(7696005)(47076005)(6916009)(4326008)(36860700001)(5660300002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:07.9169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 191d0eac-6c75-4008-1fa4-08d97f8eec92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0208
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
must configure a different DPCD lane setting from hw lane settings we output.
The change is to decouple hw lane settings from dpcd lane settings to provide
flexibility to configure dpcd and hw individually.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 154 +++++++-----------
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   5 -
 .../amd/display/include/link_service_types.h  |  19 ++-
 3 files changed, 70 insertions(+), 108 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 84eabdca8b24..f13bf8ca93aa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -515,10 +515,7 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 	enum dc_dp_training_pattern pattern,
 	uint32_t offset)
 {
-	union dpcd_training_lane dpcd_lane[LANE_COUNT_DP_MAX] = { { {0} } };
-
 	uint32_t dpcd_base_lt_offset;
-
 	uint8_t dpcd_lt_buffer[5] = {0};
 	union dpcd_training_pattern dpcd_pattern = { {0} };
 	uint32_t size_in_bytes;
@@ -554,16 +551,14 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 			dpcd_pattern.v1_4.TRAINING_PATTERN_SET);
 	}
 
-	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->hw_lane_settings, dpcd_lane);
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
@@ -575,7 +570,7 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 					__func__,
 					offset,
 					dpcd_base_lt_offset,
-					dpcd_lane[0].tx_ffe.PRESET_VALUE);
+					lt_settings->dpcd_lane_settings[0].tx_ffe.PRESET_VALUE);
 		else if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
 				DP_8b_10b_ENCODING)
 #endif
@@ -584,10 +579,10 @@ static void dpcd_set_lt_pattern_and_lane_settings(
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
@@ -595,17 +590,17 @@ static void dpcd_set_lt_pattern_and_lane_settings(
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
@@ -620,7 +615,7 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 		core_link_write_dpcd(
 			link,
 			DP_TRAINING_LANE0_SET,
-			(uint8_t *)(dpcd_lane),
+			(uint8_t *)(lt_settings->dpcd_lane_settings),
 			size_in_bytes);
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
@@ -915,7 +910,6 @@ enum dc_status dpcd_set_lane_settings(
 	const struct link_training_settings *link_training_setting,
 	uint32_t offset)
 {
-	union dpcd_training_lane dpcd_lane[LANE_COUNT_DP_MAX] = {{{0}}};
 	unsigned int lane0_set_address;
 	enum dc_status status;
 
@@ -925,34 +919,11 @@ enum dc_status dpcd_set_lane_settings(
 		lane0_set_address = DP_TRAINING_LANE0_SET_PHY_REPEATER1 +
 		((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
 
-	dp_hw_to_dpcd_lane_settings(link_training_setting,
-			link_training_setting->hw_lane_settings,
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
@@ -962,7 +933,7 @@ enum dc_status dpcd_set_lane_settings(
 					__func__,
 					offset,
 					lane0_set_address,
-					dpcd_lane[0].tx_ffe.PRESET_VALUE);
+					link_training_setting->dpcd_lane_settings[0].tx_ffe.PRESET_VALUE);
 		else if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
 				DP_8b_10b_ENCODING)
 #endif
@@ -971,10 +942,10 @@ enum dc_status dpcd_set_lane_settings(
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
@@ -983,17 +954,17 @@ enum dc_status dpcd_set_lane_settings(
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
@@ -1006,7 +977,7 @@ bool dp_is_max_vs_reached(
 	for (lane = 0; lane <
 		(uint32_t)(lt_settings->link_settings.lane_count);
 		lane++) {
-		if (lt_settings->hw_lane_settings[lane].VOLTAGE_SWING
+		if (lt_settings->dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET
 			== VOLTAGE_SWING_MAX_LEVEL)
 			return true;
 	}
@@ -1040,7 +1011,6 @@ static bool perform_post_lt_adj_req_sequence(
 			union lane_align_status_updated
 				dpcd_lane_status_updated;
 			union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
-			union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 			dp_get_lane_status_and_lane_adjust(
 				link,
@@ -1065,9 +1035,9 @@ static bool perform_post_lt_adj_req_sequence(
 			for (lane = 0; lane < (uint32_t)(lane_count); lane++) {
 
 				if (lt_settings->
-				hw_lane_settings[lane].VOLTAGE_SWING !=
+				dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET !=
 				dpcd_lane_adjust[lane].bits.VOLTAGE_SWING_LANE ||
-				lt_settings->hw_lane_settings[lane].PRE_EMPHASIS !=
+				lt_settings->dpcd_lane_settings[lane].bits.PRE_EMPHASIS_SET !=
 				dpcd_lane_adjust[lane].bits.PRE_EMPHASIS_LANE) {
 
 					req_drv_setting_changed = true;
@@ -1077,7 +1047,7 @@ static bool perform_post_lt_adj_req_sequence(
 
 			if (req_drv_setting_changed) {
 				dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-						lt_settings->hw_lane_settings, dpcd_lane_settings);
+						lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 
 				dc_link_dp_set_drive_settings(link,
 						lt_settings);
@@ -1164,10 +1134,8 @@ static enum link_training_result perform_channel_equalization_sequence(
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
 	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
-	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	/* Note: also check that TPS4 is a supported feature*/
-
 	tr_pattern = lt_settings->pattern_for_eq;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
@@ -1233,7 +1201,7 @@ static enum link_training_result perform_channel_equalization_sequence(
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-				lt_settings->hw_lane_settings, dpcd_lane_settings);
+				lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 	}
 
 	return LINK_TRAINING_EQ_FAIL_EQ;
@@ -1263,7 +1231,6 @@ static enum link_training_result perform_clock_recovery_sequence(
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
 	union lane_align_status_updated dpcd_lane_status_updated;
 	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
-	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 
 	retries_cr = 0;
 	retry_count = 0;
@@ -1344,12 +1311,12 @@ static enum link_training_result perform_clock_recovery_sequence(
 		/* Note: settings are the same for all lanes,
 		 * so comparing first lane is sufficient*/
 		if ((dp_get_link_encoding_format(&lt_settings->link_settings) == DP_8b_10b_ENCODING) &&
-				lt_settings->hw_lane_settings[0].VOLTAGE_SWING ==
+				lt_settings->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET ==
 						dpcd_lane_adjust[0].bits.VOLTAGE_SWING_LANE)
 			retries_cr++;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		else if ((dp_get_link_encoding_format(&lt_settings->link_settings) == DP_128b_132b_ENCODING) &&
-				lt_settings->hw_lane_settings[0].FFE_PRESET.settings.level ==
+				lt_settings->dpcd_lane_settings[0].tx_ffe.PRESET_VALUE ==
 						dpcd_lane_adjust[0].tx_ffe.PRESET_VALUE)
 			retries_cr++;
 #endif
@@ -1358,7 +1325,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 
 		/* 8. update VS/PE/PC2 in lt_settings*/
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-				lt_settings->hw_lane_settings, dpcd_lane_settings);
+				lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 
 		retry_count++;
 	}
@@ -1488,6 +1455,7 @@ static inline void decide_8b_10b_training_settings(
 	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_setting);
 	lt_settings->enhanced_framing = 1;
 	lt_settings->should_set_fec_ready = true;
+	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 }
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
@@ -1513,6 +1481,8 @@ static inline void decide_128b_132b_training_settings(struct dc_link *link,
 			link->dpcd_caps.lttpr_caps.phy_repeater_cnt) + 1) * 20000;
 	lt_settings->lttpr_mode = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) ?
 			LTTPR_MODE_NON_TRANSPARENT : LTTPR_MODE_TRANSPARENT;
+	dp_hw_to_dpcd_lane_settings(lt_settings,
+			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 }
 #endif
 
@@ -1574,6 +1544,8 @@ static void override_training_settings(
 			*lt_settings->post_cursor2
 			: POST_CURSOR2_DISABLED;
 	}
+	dp_hw_to_dpcd_lane_settings(lt_settings,
+			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 
 	/* Initialize training timings */
 	if (overrides->cr_pattern_time != NULL)
@@ -1838,6 +1810,9 @@ void dc_link_dp_set_drive_settings(
 	/* program ASIC PHY settings*/
 	dp_set_hw_lane_settings(link, lt_settings, DPRX);
 
+	dp_hw_to_dpcd_lane_settings(lt_settings,
+			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
+
 	/* Notify DP sink the PHY settings from source */
 	dpcd_set_lane_settings(link, lt_settings, DPRX);
 }
@@ -1971,7 +1946,6 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
 	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
-	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX] = { { {0} } };
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 
 	/* Transmit 128b/132b_TPS1 over Main-Link and Set TRAINING_PATTERN_SET to 01h */
@@ -1982,7 +1956,7 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
 			&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
 	dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-			lt_settings->hw_lane_settings, dpcd_lane_settings);
+			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 	dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
 	dp_set_hw_lane_settings(link, lt_settings, DPRX);
 	dpcd_set_lane_settings(link, lt_settings, DPRX);
@@ -1999,7 +1973,7 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 		dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
 				&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-				lt_settings->hw_lane_settings, dpcd_lane_settings);
+				lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 		dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
 		if (dp_is_ch_eq_done(lt_settings->link_settings.lane_count,
 				dpcd_lane_status)) {
@@ -2113,7 +2087,7 @@ static enum link_training_result dp_perform_8b_10b_link_training(
 		}
 
 		for (lane = 0; lane < (uint8_t)lt_settings->link_settings.lane_count; lane++)
-			lt_settings->hw_lane_settings[lane].VOLTAGE_SWING = VOLTAGE_SWING_LEVEL0;
+			lt_settings->dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET = VOLTAGE_SWING_LEVEL0;
 	}
 
 	if (status == LINK_TRAINING_SUCCESS) {
@@ -3461,15 +3435,13 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
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
@@ -3590,47 +3562,37 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
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
-		link_training_settings.hw_lane_settings[i] =
-				link_settings.lane_settings[i];
-	link_training_settings.link_settings = link_settings.link;
+	dp_hw_to_dpcd_lane_settings(&link_training_settings,
+			link_training_settings.hw_lane_settings,
+			link_training_settings.dpcd_lane_settings);
 	link_training_settings.allow_invalid_msa_timing_param = false;
 	/*Usage: Measure DP physical lane signal
 	 * by DP SI test equipment automatically.
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index a5e798b5da79..515125fdd7b3 100644
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
index 007274e73347..3fc868b19f2f 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -91,12 +91,14 @@ enum lttpr_mode {
 struct link_training_settings {
 	struct dc_link_settings link_settings;
 
+	/* TODO: turn lane settings below into mandatory fields
+	 * as initial lane configuration
+	 */
 	enum dc_voltage_swing *voltage_swing;
 	enum dc_pre_emphasis *pre_emphasis;
 	enum dc_post_cursor2 *post_cursor2;
 	bool should_set_fec_ready;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	/* TODO - factor lane_settings out because it changes during LT */
 	union dc_dp_ffe_preset *ffe_preset;
 #endif
 
@@ -118,11 +120,14 @@ struct link_training_settings {
 	enum lttpr_mode lttpr_mode;
 
 
-	/* TODO: Move hw_lane_settings along with lane adjust,
-	 * lane align, offset and all other training states
-	 * into a new structure called link training states,
-	 * so link_training_settings becomes a constant input
-	 * pre-decided prior to link training.
+	/*****************************************************************
+	* training states - parameters that can change in link training
+	*****************************************************************/
+	/* TODO: Move hw_lane_settings and dpcd_lane_settings
+	 * along with lane adjust, lane align, offset and all
+	 * other training states into a new structure called
+	 * training states, so link_training_settings becomes
+	 * a constant input pre-decided prior to link training.
 	 *
 	 * The goal is to strictly decouple link training settings
 	 * decision making process from link training states to
@@ -130,7 +135,7 @@ struct link_training_settings {
 	 * decision on the fly.
 	 */
 	struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX];
-
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX];
 };
 
 /*TODO: Move this enum test harness*/
-- 
2.25.1

