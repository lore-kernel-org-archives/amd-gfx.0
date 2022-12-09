Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F335BC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CD010E55D;
	Fri,  9 Dec 2022 16:37:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7FB10E565
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja7kn5pjGOhHic5DA5LOE6jBA7dS3PmIDxELCpVo5hJbqaCmN1mBQXd9TQ/1yNVjWq5pQasXWEUHf3nsyu1jhicqpmmft/pPsz2ma1KiY7LmcpNe8DOfXXBnKn9I7jq3KfTqBJoS8jfADZEN1vlJg+OxLh+dAjQqBvP8sUMWJTJcVkGnlwp7P6eADlg244NE4HK2KCN8renr6KIFZ3AyICyc0ugtBv9JrXEfG1t9jSOr4UKtWYYcmwb2HgUF6aSTvZwqo1CY33GRzqzNEWLrJogVmRhinvsFzQTAQHcOhcNWRD9SWSDiMzrVdCkJh7BnhgoW8PwwbPynsUwUuFZCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78H8g5cfnEi8LhLz92f88Z1ID5Dj75JnGfM3yYTw+oQ=;
 b=IKF0AdJzFQeMigt8187D/pYrVzRYSSSuny9s8fD5vjxWIa2/anq2vqFAthWi2uIC6Ept0rHQ4rLTfpzGNmHcUkMOVw4qhKnSUSa8YjD/yi5u65nqybJ5n5raGpHFAd0EDDvhApQgfz81YftpRfT/gtyerxEmJhCyhmXXQ0natWHTeQ5lCCOx2Ntz3Cp0P1Bh6radpbNSFtiwYyaDq3oX499RwS/ZRdjsrtvwx2W8SjTVm2A5GKpI+88upSjCennCF7R4olyeixqxzJ/YBunDZRirjkgkLske2h/yS+i9RbKADRipZX2UD9bwz/53h47u3SdcjTwVCGqtnRxpgn1C8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78H8g5cfnEi8LhLz92f88Z1ID5Dj75JnGfM3yYTw+oQ=;
 b=l5cF//xnoBvZr+OFulLT8HII7HoR2odyIfdFkflvcEAJZ7jZq6XlwV/et1a9Bma6/M0YL1LUpbDkkokKxlRLbGxVig/LCWpRkknJM6wOWGJEybqvW+EvoHZcYZdgt7BTKY2YF7Reb9pJGr0uhpbgOsD7ahjLwkLo6XJbndrg0Ok=
Received: from MW2PR16CA0051.namprd16.prod.outlook.com (2603:10b6:907:1::28)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 16:37:34 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::a1) by MW2PR16CA0051.outlook.office365.com
 (2603:10b6:907:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Fri, 9 Dec 2022 16:37:33 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:30 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/23] drm/amd/display: add support for three new square
 pattern variants from DP2.1 specs
Date: Fri, 9 Dec 2022 11:36:39 -0500
Message-ID: <20221209163647.25704-16-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 070e0a54-7742-4277-7a53-08dada03ac62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDVMywprn8Ij9UvFGhS4T8qCKT63KtbyN7EqirfcIVrKoddWBY6lbCQIysbbVvprzEbrIJM1QObedzbF6cfziqGBw6BTUd1GWH6qBMJNeE93w6bHgPtkmMkt8Bh554PQv7CzACwoVAleS0wTUWOAWpgrFwj7lm6pBGqgX3YFqSpIZ7QiHkzjRCfN1LgX5db9XC+1uz6WipSk7QxGjeel+bTTPvNO7nnCzgL/mj0IlRL5DFMsKXsZkRiqcjhshskPnQ/GFjxAPEWEFmeQeOQG4FDi7UIjtdE5gtvosJDPtkWZ3XvuTHAmxgy2wZP6KmzhvIx9w4PzEdHYHPS57a4fRCnDFNCkq+E/e+G1JZ1gRVF0n7un1WaHGVuQUpEYcKYKuAIqXykOMD6GBzUW5ztCOS7LBPtCZqdd/Cul0sGNshPdUV5EdOrGGtoEDOoY83k+pwRJr+J1U+1IEJMzhtIoztRBcX4rXp9HKhXL6RCnnxvCvptel1PQPFmFnAVUBmD+jEJdfUhVmr0lHSMATF/fK0MuTDHookOW+k9216jqIzRtlVZcjzu0bOGxbB8UB6va0y2df4uNtsz4SHpt0a1+RNYDGon9jaZx3xBWLYwwjXy59/bOsLqdEUla2iTwj3gCel//AhAxcMb+xJ17QSkf9Ip39diC3Qp4OSNHH2+zlU7rPcZ/RjnH6RJl9DAk9LK26yyreNhec0kDS3yXKG+Xbvkg/GAfHwwGvtZCCQ5H9Nw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(4326008)(70206006)(70586007)(426003)(47076005)(5660300002)(41300700001)(83380400001)(54906003)(316002)(2906002)(16526019)(40480700001)(6916009)(82740400003)(336012)(36756003)(1076003)(2616005)(186003)(26005)(8676002)(478600001)(82310400005)(81166007)(8936002)(40460700003)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:33.6832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070e0a54-7742-4277-7a53-08dada03ac62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
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
 Jasdeep Dhillon <jdhillon@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
DP2.1 specs has brought 3 new variants of sqaure patterns with different
pre-shoot and de-emphasis equalization requirements. The commit adds
logic to identify these variants and apply corresponding eqaulization
requirements into hardware lane settings.

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 48 +++++++++++++++----
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  3 ++
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.c      |  5 +-
 .../gpu/drm/amd/display/include/dpcd_defs.h   |  5 +-
 .../amd/display/include/link_service_types.h  |  7 ++-
 5 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index dedd1246ce58..909434faf039 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4094,6 +4094,12 @@ static void dp_test_send_link_training(struct dc_link *link)
 	dp_retrain_link_dp_test(link, &link_settings, false);
 }
 
+static bool is_dp_phy_sqaure_pattern(enum dp_test_pattern test_pattern)
+{
+	return (DP_TEST_PATTERN_SQUARE_BEGIN <= test_pattern &&
+			test_pattern <= DP_TEST_PATTERN_SQUARE_END);
+}
+
 /* TODO Raven hbr2 compliance eye output is unstable
  * (toggling on and off) with debugger break
  * This caueses intermittent PHY automation failure
@@ -4111,6 +4117,8 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 	union lane_adjust dpcd_lane_adjust;
 	unsigned int lane;
 	struct link_training_settings link_training_settings;
+	unsigned char no_preshoot = 0;
+	unsigned char no_deemphasis = 0;
 
 	dpcd_test_pattern.raw = 0;
 	memset(dpcd_lane_adjustment, 0, sizeof(dpcd_lane_adjustment));
@@ -4204,8 +4212,21 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 	case PHY_TEST_PATTERN_264BIT_CUSTOM:
 		test_pattern = DP_TEST_PATTERN_264BIT_CUSTOM;
 		break;
-	case PHY_TEST_PATTERN_SQUARE_PULSE:
-		test_pattern = DP_TEST_PATTERN_SQUARE_PULSE;
+	case PHY_TEST_PATTERN_SQUARE:
+		test_pattern = DP_TEST_PATTERN_SQUARE;
+		break;
+	case PHY_TEST_PATTERN_SQUARE_PRESHOOT_DISABLED:
+		test_pattern = DP_TEST_PATTERN_SQUARE_PRESHOOT_DISABLED;
+		no_preshoot = 1;
+		break;
+	case PHY_TEST_PATTERN_SQUARE_DEEMPHASIS_DISABLED:
+		test_pattern = DP_TEST_PATTERN_SQUARE_DEEMPHASIS_DISABLED;
+		no_deemphasis = 1;
+		break;
+	case PHY_TEST_PATTERN_SQUARE_PRESHOOT_DEEMPHASIS_DISABLED:
+		test_pattern = DP_TEST_PATTERN_SQUARE_PRESHOOT_DEEMPHASIS_DISABLED;
+		no_preshoot = 1;
+		no_deemphasis = 1;
 		break;
 	default:
 		test_pattern = DP_TEST_PATTERN_VIDEO_MODE;
@@ -4222,7 +4243,7 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 				test_pattern_size);
 	}
 
-	if (test_pattern == DP_TEST_PATTERN_SQUARE_PULSE) {
+	if (is_dp_phy_sqaure_pattern(test_pattern)) {
 		test_pattern_size = 1; // Square pattern data is 1 byte (DP spec)
 		core_link_read_dpcd(
 				link,
@@ -4259,8 +4280,10 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 				((dpcd_post_cursor_2_adjustment >> (lane * 2)) & 0x03);
 		} else if (dp_get_link_encoding_format(&link->cur_link_settings) ==
 				DP_128b_132b_ENCODING) {
-			link_training_settings.hw_lane_settings[lane].FFE_PRESET.raw =
+			link_training_settings.hw_lane_settings[lane].FFE_PRESET.settings.level =
 					dpcd_lane_adjust.tx_ffe.PRESET_VALUE;
+			link_training_settings.hw_lane_settings[lane].FFE_PRESET.settings.no_preshoot = no_preshoot;
+			link_training_settings.hw_lane_settings[lane].FFE_PRESET.settings.no_deemphasis = no_deemphasis;
 		}
 	}
 
@@ -6178,8 +6201,17 @@ bool dc_link_dp_set_test_pattern(
 		case DP_TEST_PATTERN_264BIT_CUSTOM:
 			pattern = PHY_TEST_PATTERN_264BIT_CUSTOM;
 			break;
-		case DP_TEST_PATTERN_SQUARE_PULSE:
-			pattern = PHY_TEST_PATTERN_SQUARE_PULSE;
+		case DP_TEST_PATTERN_SQUARE:
+			pattern = PHY_TEST_PATTERN_SQUARE;
+			break;
+		case DP_TEST_PATTERN_SQUARE_PRESHOOT_DISABLED:
+			pattern = PHY_TEST_PATTERN_SQUARE_PRESHOOT_DISABLED;
+			break;
+		case DP_TEST_PATTERN_SQUARE_DEEMPHASIS_DISABLED:
+			pattern = PHY_TEST_PATTERN_SQUARE_DEEMPHASIS_DISABLED;
+			break;
+		case DP_TEST_PATTERN_SQUARE_PRESHOOT_DEEMPHASIS_DISABLED:
+			pattern = PHY_TEST_PATTERN_SQUARE_PRESHOOT_DEEMPHASIS_DISABLED;
 			break;
 		default:
 			return false;
@@ -6190,14 +6222,12 @@ bool dc_link_dp_set_test_pattern(
 			return false;
 
 		if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12) {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-			if (test_pattern == DP_TEST_PATTERN_SQUARE_PULSE)
+			if (is_dp_phy_sqaure_pattern(test_pattern))
 				core_link_write_dpcd(link,
 						DP_LINK_SQUARE_PATTERN,
 						p_custom_pattern,
 						1);
 
-#endif
 			/* tell receiver that we are sending qualification
 			 * pattern DP 1.2 or later - DP receiver's link quality
 			 * pattern is set using DPCD LINK_QUAL_LANEx_SET
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 2c54b6e0498b..b4eddd83b330 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -926,6 +926,9 @@ struct dpcd_usb4_dp_tunneling_info {
 #ifndef DP_128b_132b_TRAINING_AUX_RD_INTERVAL
 #define DP_128b_132b_TRAINING_AUX_RD_INTERVAL		0x2216
 #endif
+#ifndef DP_LINK_SQUARE_PATTERN
+#define DP_LINK_SQUARE_PATTERN				0x10F
+#endif
 #ifndef DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX
 #define DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX		0x2217
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
index 80dfaa4d4d81..0b317ed31f91 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
@@ -242,7 +242,10 @@ void dcn31_hpo_dp_link_enc_set_link_test_pattern(
 		REG_UPDATE(DP_DPHY_SYM32_CONTROL,
 				MODE, DP2_TEST_PATTERN);
 		break;
-	case DP_TEST_PATTERN_SQUARE_PULSE:
+	case DP_TEST_PATTERN_SQUARE:
+	case DP_TEST_PATTERN_SQUARE_PRESHOOT_DISABLED:
+	case DP_TEST_PATTERN_SQUARE_DEEMPHASIS_DISABLED:
+	case DP_TEST_PATTERN_SQUARE_PRESHOOT_DEEMPHASIS_DISABLED:
 		REG_SET(DP_DPHY_SYM32_TP_SQ_PULSE, 0,
 				TP_SQ_PULSE_WIDTH, tp_params->custom_pattern[0]);
 
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index b2df07f9e91c..c062a44db078 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -88,7 +88,10 @@ enum dpcd_phy_test_patterns {
 	PHY_TEST_PATTERN_PRBS23 = 0x30,
 	PHY_TEST_PATTERN_PRBS31 = 0x38,
 	PHY_TEST_PATTERN_264BIT_CUSTOM = 0x40,
-	PHY_TEST_PATTERN_SQUARE_PULSE = 0x48,
+	PHY_TEST_PATTERN_SQUARE = 0x48,
+	PHY_TEST_PATTERN_SQUARE_PRESHOOT_DISABLED = 0x49,
+	PHY_TEST_PATTERN_SQUARE_DEEMPHASIS_DISABLED = 0x4A,
+	PHY_TEST_PATTERN_SQUARE_PRESHOOT_DEEMPHASIS_DISABLED = 0x4B,
 };
 
 enum dpcd_test_dyn_range {
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index d1e91d31d151..18b9173d5a96 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -165,7 +165,12 @@ enum dp_test_pattern {
 	DP_TEST_PATTERN_PRBS23,
 	DP_TEST_PATTERN_PRBS31,
 	DP_TEST_PATTERN_264BIT_CUSTOM,
-	DP_TEST_PATTERN_SQUARE_PULSE,
+	DP_TEST_PATTERN_SQUARE_BEGIN,
+	DP_TEST_PATTERN_SQUARE = DP_TEST_PATTERN_SQUARE_BEGIN,
+	DP_TEST_PATTERN_SQUARE_PRESHOOT_DISABLED,
+	DP_TEST_PATTERN_SQUARE_DEEMPHASIS_DISABLED,
+	DP_TEST_PATTERN_SQUARE_PRESHOOT_DEEMPHASIS_DISABLED,
+	DP_TEST_PATTERN_SQUARE_END = DP_TEST_PATTERN_SQUARE_PRESHOOT_DEEMPHASIS_DISABLED,
 
 	/* Link Training Patterns */
 	DP_TEST_PATTERN_TRAINING_PATTERN1,
-- 
2.34.1

