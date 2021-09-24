Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D95FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3901261250
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3901261250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58EF6E213;
	Fri, 24 Sep 2021 19:10:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A057D6E213
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfE5X+Ev/1yVZKroeAgtzHeTw5OkfF8t08DgcSZ1XnG4UDPif3Yj3Or6VA36qkCwzros78SsCoFhZevi2v/gQ3idTfnn9Z3OpLawX4MrF79esr3PCscIdWFGVNzNAPlPn7GqaIiu5DxgGq6DksYRP2c0cn+5YA2xKeNr2BKEdzQeltrY0EKurVHtVZ5JAroIZ4L+5syYZdU/ClixhpAjwT2no/uBeuUFkDKC2C1E2Yo/xX0V18xJPpBuGHM/SyLc1qaaK6AaB0ngvX5wOIYKd7VWnryVNX9z2bTjmJrHtvd05MYZpl8+V8RcRBVOoKveGFxEeTsX+l0MF122zCWF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qVgJV+duZ3y9Cz+loalMJilZb/YoiVwrzUzIL9nJE7Y=;
 b=DX1VHmDfh+UKkBPq1SyQhXcIKRgsv8UesXo5X1tFd48KFT+YK43H3Jua7gn7d407eyWGMZhcilyqJicNIhPjYfNfkeVCRfWGtYWeJGRFboytRdZGMs3BJreSZToj2SP6pPEajHomDn4U5gCrc2lrI5Aym4+M4ALgRUz+4InsO38zx5xZAHeWBrTSNZEoaJdc+EHd+B59IzEe7Y8CcxCu+CGEvFNcRbXvIjVTucd76KsmXfyx+UezYDOmBIsxUBMSAS4nmA5Ih01UYMtf4zFAWC3mysuQhNgR8F1A+yaZOY9wUeJDBBYQvzD8lQaKuRh1kDEiqCujWNQFcHF+wPl21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVgJV+duZ3y9Cz+loalMJilZb/YoiVwrzUzIL9nJE7Y=;
 b=4wk+ATYZrbZL/6ceQq61V0cT3LT5bXZ49j4zvjCXt6Hxg79kg1sgNGnLrppxqUt4e37TUVfcWiUq47bFiionuFTQdZvTZdL4MiywtAC0OeaACfhI2krn6TaH5RcAP8i2lm1ULaVpltlZ3xGw5V/izQO2IrYzxgirEEO8wW7taCk=
Received: from CO2PR05CA0094.namprd05.prod.outlook.com (2603:10b6:104:1::20)
 by BN6PR12MB1651.namprd12.prod.outlook.com (2603:10b6:405:4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Fri, 24 Sep
 2021 19:10:01 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::56) by CO2PR05CA0094.outlook.office365.com
 (2603:10b6:104:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:01 +0000
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
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:00 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:09:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 12:09:58 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:09:56 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 07/24] drm/amd/display: add function to convert hw to dpcd
 lane settings
Date: Fri, 24 Sep 2021 15:09:17 -0400
Message-ID: <20210924190934.1193379-8-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb026033-acf1-43c6-1ca6-08d97f8ee804
X-MS-TrafficTypeDiagnostic: BN6PR12MB1651:
X-Microsoft-Antispam-PRVS: <BN6PR12MB16519CAF01FC92526E665B60EBA49@BN6PR12MB1651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhkPrmUsaB4RUutyPo6iLBQxuX+fJbBHv7rGQxZDeKf6Kr0W17nDOBDnYk57bS1lrxXRvvMkdXA7lAM3DOZUSv2RPrTZfR3Ftn6RybPMp+ehOqtGyYubUmNWHsU3oPqoDweKf6iBQPUmcu0BRDFu0ZAc85A6ovmEHxPz9VP6oOQo2unZrRl9rROGL6LW8mbZh2DEowaicHVoai5z/IeXvAVwdk7nJ7CZqs4oIzWYeO6aS4rqmqmHdeC+EfIsHYC23tZi9wMMGsX76kBY5gglxBxvIgWQ2wxZo3hQn0sinzCu1PJE6yokfwfCoHwcwcaQWO+4ppOhO7jDn5q8IkOfZ0mZrCoj642bTvxneHANoEnJ134E9/5wuEenjf7VUQMCiQ7Q+sLG1PoALIEusHoa+pkhr172Np4K8uhplqmkSurErlnsSH2Xkfbia6Sld/BpYXKYNhOw1n75XYHzSjEL9UeegT/6qzgQKInabHVyOokF9GrmFqzE3JyMq6WiIzV2g6kxM6gZUkvIyEsfoj7Rws6TThGSDy5JshR99n7EFfvh/VrMMDWkUJlRmZi8GdQgzUFTlY7Rytl/UEusgJdoPo1CBnMPnGaq1UIAg9WRycOr5KLiN921Y0QLPfuR5LS7lYLUEKH8iNN5g3LzmEgif21Rs9/gSLkspDjhMHzQEqYY7MBXfE22mIOZTG+kEchyt3FYpXGdb8fuIvqUxybW1A0uktfvdb4cWa01tZvYkvo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(54906003)(70586007)(426003)(82310400003)(356005)(19627235002)(8936002)(4326008)(47076005)(1076003)(2906002)(6916009)(83380400001)(36756003)(26005)(186003)(81166007)(316002)(36860700001)(5660300002)(336012)(508600001)(8676002)(7696005)(70206006)(6666004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:00.2783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb026033-acf1-43c6-1ca6-08d97f8ee804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1651
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
Unify the code which handles the conversion between hw lane setting
and dpcd lane setting.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 113 ++++++------------
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   5 +-
 2 files changed, 39 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 750f1ae268c3..f7be58800da6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -553,45 +553,8 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 			dpcd_base_lt_offset,
 			dpcd_pattern.v1_4.TRAINING_PATTERN_SET);
 	}
-	/*****************************************************************
-	* DpcdAddress_Lane0Set -> DpcdAddress_Lane3Set
-	*****************************************************************/
-	for (lane = 0; lane <
-		(uint32_t)(lt_settings->link_settings.lane_count); lane++) {
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-		if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
-				DP_128b_132b_ENCODING) {
-			dpcd_lane[lane].tx_ffe.PRESET_VALUE =
-					lt_settings->lane_settings[lane].FFE_PRESET.settings.level;
-		} else if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
-				DP_8b_10b_ENCODING) {
-			dpcd_lane[lane].bits.VOLTAGE_SWING_SET =
-					(uint8_t)(lt_settings->lane_settings[lane].VOLTAGE_SWING);
-			dpcd_lane[lane].bits.PRE_EMPHASIS_SET =
-					(uint8_t)(lt_settings->lane_settings[lane].PRE_EMPHASIS);
-
-			dpcd_lane[lane].bits.MAX_SWING_REACHED =
-					(lt_settings->lane_settings[lane].VOLTAGE_SWING ==
-							VOLTAGE_SWING_MAX_LEVEL ? 1 : 0);
-			dpcd_lane[lane].bits.MAX_PRE_EMPHASIS_REACHED =
-					(lt_settings->lane_settings[lane].PRE_EMPHASIS ==
-							PRE_EMPHASIS_MAX_LEVEL ? 1 : 0);
-		}
-#else
-		dpcd_lane[lane].bits.VOLTAGE_SWING_SET =
-		(uint8_t)(lt_settings->lane_settings[lane].VOLTAGE_SWING);
-		dpcd_lane[lane].bits.PRE_EMPHASIS_SET =
-		(uint8_t)(lt_settings->lane_settings[lane].PRE_EMPHASIS);
-
-		dpcd_lane[lane].bits.MAX_SWING_REACHED =
-		(lt_settings->lane_settings[lane].VOLTAGE_SWING ==
-		VOLTAGE_SWING_MAX_LEVEL ? 1 : 0);
-		dpcd_lane[lane].bits.MAX_PRE_EMPHASIS_REACHED =
-		(lt_settings->lane_settings[lane].PRE_EMPHASIS ==
-		PRE_EMPHASIS_MAX_LEVEL ? 1 : 0);
-#endif
-	}
+	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->lane_settings, dpcd_lane);
 
 	/* concatenate everything into one buffer*/
 
@@ -717,6 +680,37 @@ bool dp_is_interlane_aligned(union lane_align_status_updated align_status)
 	return align_status.bits.INTERLANE_ALIGN_DONE == 1;
 }
 
+void dp_hw_to_dpcd_lane_settings(
+		const struct link_training_settings *lt_settings,
+		const struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX],
+		union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX])
+{
+	uint8_t lane = 0;
+
+	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
+		if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
+				DP_8b_10b_ENCODING) {
+			dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET =
+					(uint8_t)(hw_lane_settings[lane].VOLTAGE_SWING);
+			dpcd_lane_settings[lane].bits.PRE_EMPHASIS_SET =
+					(uint8_t)(hw_lane_settings[lane].PRE_EMPHASIS);
+			dpcd_lane_settings[lane].bits.MAX_SWING_REACHED =
+					(hw_lane_settings[lane].VOLTAGE_SWING ==
+							VOLTAGE_SWING_MAX_LEVEL ? 1 : 0);
+			dpcd_lane_settings[lane].bits.MAX_PRE_EMPHASIS_REACHED =
+					(hw_lane_settings[lane].PRE_EMPHASIS ==
+							PRE_EMPHASIS_MAX_LEVEL ? 1 : 0);
+		}
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		else if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
+				DP_128b_132b_ENCODING) {
+			dpcd_lane_settings[lane].tx_ffe.PRESET_VALUE =
+					hw_lane_settings[lane].FFE_PRESET.settings.level;
+		}
+#endif
+	}
+}
+
 void dp_update_drive_settings(
 		struct link_training_settings *dest,
 		struct link_training_settings src)
@@ -1036,46 +1030,9 @@ enum dc_status dpcd_set_lane_settings(
 		lane0_set_address = DP_TRAINING_LANE0_SET_PHY_REPEATER1 +
 		((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
 
-	for (lane = 0; lane <
-		(uint32_t)(link_training_setting->
-		link_settings.lane_count);
-		lane++) {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-		if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
-				DP_128b_132b_ENCODING) {
-			dpcd_lane[lane].tx_ffe.PRESET_VALUE =
-					link_training_setting->lane_settings[lane].FFE_PRESET.settings.level;
-		} else if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
-				DP_8b_10b_ENCODING) {
-			dpcd_lane[lane].bits.VOLTAGE_SWING_SET =
-					(uint8_t)(link_training_setting->lane_settings[lane].VOLTAGE_SWING);
-			dpcd_lane[lane].bits.PRE_EMPHASIS_SET =
-					(uint8_t)(link_training_setting->lane_settings[lane].PRE_EMPHASIS);
-
-			dpcd_lane[lane].bits.MAX_SWING_REACHED =
-					(link_training_setting->lane_settings[lane].VOLTAGE_SWING ==
-							VOLTAGE_SWING_MAX_LEVEL ? 1 : 0);
-			dpcd_lane[lane].bits.MAX_PRE_EMPHASIS_REACHED =
-					(link_training_setting->lane_settings[lane].PRE_EMPHASIS ==
-							PRE_EMPHASIS_MAX_LEVEL ? 1 : 0);
-		}
-#else
-		dpcd_lane[lane].bits.VOLTAGE_SWING_SET =
-			(uint8_t)(link_training_setting->
-			lane_settings[lane].VOLTAGE_SWING);
-		dpcd_lane[lane].bits.PRE_EMPHASIS_SET =
-			(uint8_t)(link_training_setting->
-			lane_settings[lane].PRE_EMPHASIS);
-		dpcd_lane[lane].bits.MAX_SWING_REACHED =
-			(link_training_setting->
-			lane_settings[lane].VOLTAGE_SWING ==
-			VOLTAGE_SWING_MAX_LEVEL ? 1 : 0);
-		dpcd_lane[lane].bits.MAX_PRE_EMPHASIS_REACHED =
-			(link_training_setting->
-			lane_settings[lane].PRE_EMPHASIS ==
-			PRE_EMPHASIS_MAX_LEVEL ? 1 : 0);
-#endif
-	}
+	dp_hw_to_dpcd_lane_settings(link_training_setting,
+			link_training_setting->lane_settings,
+			dpcd_lane);
 
 	status = core_link_write_dpcd(link,
 		lane0_set_address,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index cb8e785a866e..c70375117519 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -147,7 +147,10 @@ bool dp_is_interlane_aligned(union lane_align_status_updated align_status);
 
 bool dp_is_max_vs_reached(
 	const struct link_training_settings *lt_settings);
-
+void dp_hw_to_dpcd_lane_settings(
+	const struct link_training_settings *lt_settings,
+	const struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX],
+	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX]);
 void dp_update_drive_settings(
 	struct link_training_settings *dest,
 	struct link_training_settings src);
-- 
2.25.1

