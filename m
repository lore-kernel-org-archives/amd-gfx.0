Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE56C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77DD610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B77DD610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C61A6E215;
	Fri, 24 Sep 2021 19:10:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 757D76E216
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MG50SduannuVdP8wyQyysT0L4vdcvyGRp9ekuF7If1u6/VKOnmSmWamzXFjkaiH5B9bRo1Fmw0xGRL4tANlhvZEMyzLWD8vSjL2ZHXuksWOg+6iJtwA2Hv9NE9i5zBodfHAZVWM3eLbmHkpLTLO+ox1TuAkcPWuPtLQ2pHSx7+ttft59qgOxk15v2aqlcoTJJ59i0AbrJKyTrO/5pkWuXM9CcjmU/jxq2pWpGq28EVsd2X66pMFUEI8bssB6JhFYrKHAwri9N8AGwXt1RwfkhqXsTqMMmEBWdMj1O+hSzp5DYo6PmxHFUGrVJG5plFnfysnXJHD3eFrmCzKZQZ1D6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ajRLEAjBsaFcYQeqGWT2BiLLEmyJ4khUv4w4R7f8TlI=;
 b=N+QwbV/kB8kuDI/Eap9PfoM0ug5lBhYMI+DwT9VzbrI7dmow4PKuYptOfWlFot5uMhN2Q+x8rvzr2o/yIzJmAxw+ti5NTjFuVmdJIpip4yCQsJMIQdQuxnTjBONpeR3oFMv8wV4FCUxL0cFrfQmqEtHPbZ1agIyNcy5o8EiTTeAnnbUJA4qn4HChGnSy2Jw/GXrXPjWDRP1g0Ec602IhHlLXJE9uicdbA481r53BdlXuEOx0OrIESQNRhogQufQLOPdHy+8nuCYdSId6VcTseJXe6UFgWbqP/uCko0Qt8OhZWqUE0Q6wh+i08VxYvk9wHpMSurbTofaKiquymGUFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajRLEAjBsaFcYQeqGWT2BiLLEmyJ4khUv4w4R7f8TlI=;
 b=FoxaOaDjkSFCjD1VpYfOa784d/fDBlEeJpE7XtyC5Omw8cRi8E8Vm1u2QjNlAkUOYzaT/S0AoMHzRrBGToAsC6smR0C31nB5Ei2OoQ9N+6hWMkAsH5plKxt90o+9a7+HPeQehGGyfyzTPjF67Q0I6bWCBHpljoC2ts1nKWCATDo=
Received: from CO2PR05CA0104.namprd05.prod.outlook.com (2603:10b6:104:1::30)
 by BYAPR12MB2725.namprd12.prod.outlook.com (2603:10b6:a03:6b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 24 Sep
 2021 19:10:05 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::6c) by CO2PR05CA0104.outlook.office365.com
 (2603:10b6:104:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:05 +0000
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
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:02 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:00 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 09/24] drm/amd/display: rename lane_settings to
 hw_lane_settings
Date: Fri, 24 Sep 2021 15:09:19 -0400
Message-ID: <20210924190934.1193379-10-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b7463df-b002-46b8-bf56-08d97f8eeaba
X-MS-TrafficTypeDiagnostic: BYAPR12MB2725:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27259C03EA500A5CF164759EEBA49@BYAPR12MB2725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZwfBH9+gKGjqWYIc7mhtr/SOHJcJZwhS8Ud4ZuKQe4qXi7GpSlysy+4OX7/US2LzAw7y4NuSAibi45so7kOf4ALUPq/bPeQrKrrVdSp/jQkJMU8w7yDwBI44gpfz2403dLDEN+TmfCg67D/Q43+YBqr79UZrTt0FDy0jr5iWddjQte2vwVDwcx4TwONGbeF1WYEZv1Upx1XcjEZPi8873JGcG09rDaiDENXmJGXQmfOGMxHpeo3A9sEzF9aHmWgzZmgAcrhRgO2fialw9FkyfwmcC3BAv+brAXhLwBxxSvGhsSK4bx2vGZ2jiYyn6FYGeXN2D54eMjFP4EjYT7TuuI9hobP8LgqLeNb8L3HjR04xBwutMNaSbDREN+0SgHOBRUv/z+UjqCJgVe9Gs2s1+n9TNGBSaAdQE2dSzHwcOp9RXHHAIIsummFDmeVX64sAt/ySol5NWFj6CYtTfgXl+HpPpa+704QdywGg8/CIy+68+L+qM0xMoVOT7RojcEibeAE62sQw47S5MAJmXcKPmCqerXOeFg53X3Ek02mMHhf0BUMLy+X7rq2na6CU1xS90kiljMczsHa3M+4wDeM1xFbVIeGAR5SZ3YUTLBDwb8c92m+3S07a8er4kGortAiAGTjMr1/1ddCNG7pz9iV9v7/U0Xe8D+OmyVto867tJQdBC8uwSOF0K7A/AjpQFG+2myfINtTO64DIE2ZQj6FoeDivpuUnGQcR/RTDIMoJYY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(36756003)(8936002)(1076003)(4326008)(81166007)(316002)(6666004)(356005)(26005)(70586007)(186003)(336012)(82310400003)(6916009)(2906002)(70206006)(83380400001)(36860700001)(54906003)(426003)(7696005)(508600001)(86362001)(5660300002)(2616005)(47076005)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:04.8287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7463df-b002-46b8-bf56-08d97f8eeaba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2725
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
This is one of the major steps to decouple hw lane settings
from dpcd lane settings.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  8 ++--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 38 +++++++++----------
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  4 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |  6 +--
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |  6 +--
 .../amd/display/include/link_service_types.h  | 16 +++++++-
 6 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 814f67d86a3c..7ceb4a14fa2a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -535,11 +535,11 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
 
 	/* apply phy settings from user */
 	for (r = 0; r < link_lane_settings.link_settings.lane_count; r++) {
-		link_lane_settings.lane_settings[r].VOLTAGE_SWING =
+		link_lane_settings.hw_lane_settings[r].VOLTAGE_SWING =
 				(enum dc_voltage_swing) (param[0]);
-		link_lane_settings.lane_settings[r].PRE_EMPHASIS =
+		link_lane_settings.hw_lane_settings[r].PRE_EMPHASIS =
 				(enum dc_pre_emphasis) (param[1]);
-		link_lane_settings.lane_settings[r].POST_CURSOR2 =
+		link_lane_settings.hw_lane_settings[r].POST_CURSOR2 =
 				(enum dc_post_cursor2) (param[2]);
 	}
 
@@ -733,7 +733,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	}
 
 	for (i = 0; i < (unsigned int)(link_training_settings.link_settings.lane_count); i++)
-		link_training_settings.lane_settings[i] = link->cur_lane_setting[i];
+		link_training_settings.hw_lane_settings[i] = link->cur_lane_setting[i];
 
 	dc_link_set_test_pattern(
 		link,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8e6af080cbe9..84eabdca8b24 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -554,7 +554,7 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 			dpcd_pattern.v1_4.TRAINING_PATTERN_SET);
 	}
 
-	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->lane_settings, dpcd_lane);
+	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->hw_lane_settings, dpcd_lane);
 
 	/* concatenate everything into one buffer*/
 
@@ -926,7 +926,7 @@ enum dc_status dpcd_set_lane_settings(
 		((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
 
 	dp_hw_to_dpcd_lane_settings(link_training_setting,
-			link_training_setting->lane_settings,
+			link_training_setting->hw_lane_settings,
 			dpcd_lane);
 
 	status = core_link_write_dpcd(link,
@@ -1006,7 +1006,7 @@ bool dp_is_max_vs_reached(
 	for (lane = 0; lane <
 		(uint32_t)(lt_settings->link_settings.lane_count);
 		lane++) {
-		if (lt_settings->lane_settings[lane].VOLTAGE_SWING
+		if (lt_settings->hw_lane_settings[lane].VOLTAGE_SWING
 			== VOLTAGE_SWING_MAX_LEVEL)
 			return true;
 	}
@@ -1065,9 +1065,9 @@ static bool perform_post_lt_adj_req_sequence(
 			for (lane = 0; lane < (uint32_t)(lane_count); lane++) {
 
 				if (lt_settings->
-				lane_settings[lane].VOLTAGE_SWING !=
+				hw_lane_settings[lane].VOLTAGE_SWING !=
 				dpcd_lane_adjust[lane].bits.VOLTAGE_SWING_LANE ||
-				lt_settings->lane_settings[lane].PRE_EMPHASIS !=
+				lt_settings->hw_lane_settings[lane].PRE_EMPHASIS !=
 				dpcd_lane_adjust[lane].bits.PRE_EMPHASIS_LANE) {
 
 					req_drv_setting_changed = true;
@@ -1077,7 +1077,7 @@ static bool perform_post_lt_adj_req_sequence(
 
 			if (req_drv_setting_changed) {
 				dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-						lt_settings->lane_settings, dpcd_lane_settings);
+						lt_settings->hw_lane_settings, dpcd_lane_settings);
 
 				dc_link_dp_set_drive_settings(link,
 						lt_settings);
@@ -1233,7 +1233,7 @@ static enum link_training_result perform_channel_equalization_sequence(
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-				lt_settings->lane_settings, dpcd_lane_settings);
+				lt_settings->hw_lane_settings, dpcd_lane_settings);
 	}
 
 	return LINK_TRAINING_EQ_FAIL_EQ;
@@ -1344,12 +1344,12 @@ static enum link_training_result perform_clock_recovery_sequence(
 		/* Note: settings are the same for all lanes,
 		 * so comparing first lane is sufficient*/
 		if ((dp_get_link_encoding_format(&lt_settings->link_settings) == DP_8b_10b_ENCODING) &&
-				lt_settings->lane_settings[0].VOLTAGE_SWING ==
+				lt_settings->hw_lane_settings[0].VOLTAGE_SWING ==
 						dpcd_lane_adjust[0].bits.VOLTAGE_SWING_LANE)
 			retries_cr++;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		else if ((dp_get_link_encoding_format(&lt_settings->link_settings) == DP_128b_132b_ENCODING) &&
-				lt_settings->lane_settings[0].FFE_PRESET.settings.level ==
+				lt_settings->hw_lane_settings[0].FFE_PRESET.settings.level ==
 						dpcd_lane_adjust[0].tx_ffe.PRESET_VALUE)
 			retries_cr++;
 #endif
@@ -1358,7 +1358,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 
 		/* 8. update VS/PE/PC2 in lt_settings*/
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-				lt_settings->lane_settings, dpcd_lane_settings);
+				lt_settings->hw_lane_settings, dpcd_lane_settings);
 
 		retry_count++;
 	}
@@ -1561,15 +1561,15 @@ static void override_training_settings(
 #endif
 
 	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
-		lt_settings->lane_settings[lane].VOLTAGE_SWING =
+		lt_settings->hw_lane_settings[lane].VOLTAGE_SWING =
 			lt_settings->voltage_swing != NULL ?
 			*lt_settings->voltage_swing :
 			VOLTAGE_SWING_LEVEL0;
-		lt_settings->lane_settings[lane].PRE_EMPHASIS =
+		lt_settings->hw_lane_settings[lane].PRE_EMPHASIS =
 			lt_settings->pre_emphasis != NULL ?
 			*lt_settings->pre_emphasis
 			: PRE_EMPHASIS_DISABLED;
-		lt_settings->lane_settings[lane].POST_CURSOR2 =
+		lt_settings->hw_lane_settings[lane].POST_CURSOR2 =
 			lt_settings->post_cursor2 != NULL ?
 			*lt_settings->post_cursor2
 			: POST_CURSOR2_DISABLED;
@@ -1826,8 +1826,8 @@ static void print_status_message(
 				link_rate,
 				lt_settings->link_settings.lane_count,
 				lt_result,
-				lt_settings->lane_settings[0].VOLTAGE_SWING,
-				lt_settings->lane_settings[0].PRE_EMPHASIS,
+				lt_settings->hw_lane_settings[0].VOLTAGE_SWING,
+				lt_settings->hw_lane_settings[0].PRE_EMPHASIS,
 				lt_spread);
 }
 
@@ -1982,7 +1982,7 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
 			&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
 	dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-			lt_settings->lane_settings, dpcd_lane_settings);
+			lt_settings->hw_lane_settings, dpcd_lane_settings);
 	dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
 	dp_set_hw_lane_settings(link, lt_settings, DPRX);
 	dpcd_set_lane_settings(link, lt_settings, DPRX);
@@ -1999,7 +1999,7 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 		dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
 				&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-				lt_settings->lane_settings, dpcd_lane_settings);
+				lt_settings->hw_lane_settings, dpcd_lane_settings);
 		dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
 		if (dp_is_ch_eq_done(lt_settings->link_settings.lane_count,
 				dpcd_lane_status)) {
@@ -2113,7 +2113,7 @@ static enum link_training_result dp_perform_8b_10b_link_training(
 		}
 
 		for (lane = 0; lane < (uint8_t)lt_settings->link_settings.lane_count; lane++)
-			lt_settings->lane_settings[lane].VOLTAGE_SWING = VOLTAGE_SWING_LEVEL0;
+			lt_settings->hw_lane_settings[lane].VOLTAGE_SWING = VOLTAGE_SWING_LEVEL0;
 	}
 
 	if (status == LINK_TRAINING_SUCCESS) {
@@ -3628,7 +3628,7 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 	}
 
 	for (i = 0; i < 4; i++)
-		link_training_settings.lane_settings[i] =
+		link_training_settings.hw_lane_settings[i] =
 				link_settings.lane_settings[i];
 	link_training_settings.link_settings = link_settings.link;
 	link_training_settings.allow_invalid_msa_timing_param = false;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 368e834c6809..2666af299bc2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -364,7 +364,7 @@ void dp_set_hw_lane_settings(
 		link->hpo_dp_link_enc->funcs->set_ffe(
 				link->hpo_dp_link_enc,
 				&link_settings->link_settings,
-				link_settings->lane_settings[0].FFE_PRESET.raw);
+				link_settings->hw_lane_settings[0].FFE_PRESET.raw);
 	} else if (dp_get_link_encoding_format(&link_settings->link_settings)
 			== DP_8b_10b_ENCODING) {
 		encoder->funcs->dp_set_lane_settings(encoder, link_settings);
@@ -373,7 +373,7 @@ void dp_set_hw_lane_settings(
 	encoder->funcs->dp_set_lane_settings(encoder, link_settings);
 #endif
 	memmove(link->cur_lane_setting,
-			link_settings->lane_settings,
+			link_settings->hw_lane_settings,
 			sizeof(link->cur_lane_setting));
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 1e77ffee71b3..af4dcd6714cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -1348,9 +1348,9 @@ void dce110_link_encoder_dp_set_lane_settings(
 		/* translate lane settings */
 
 		training_lane_set.bits.VOLTAGE_SWING_SET =
-			link_settings->lane_settings[lane].VOLTAGE_SWING;
+			link_settings->hw_lane_settings[lane].VOLTAGE_SWING;
 		training_lane_set.bits.PRE_EMPHASIS_SET =
-			link_settings->lane_settings[lane].PRE_EMPHASIS;
+			link_settings->hw_lane_settings[lane].PRE_EMPHASIS;
 
 		/* post cursor 2 setting only applies to HBR2 link rate */
 		if (link_settings->link_settings.link_rate == LINK_RATE_HIGH2) {
@@ -1358,7 +1358,7 @@ void dce110_link_encoder_dp_set_lane_settings(
 			 * to program post cursor 2 level */
 
 			training_lane_set.bits.POST_CURSOR2_SET =
-				link_settings->lane_settings[lane].POST_CURSOR2;
+				link_settings->hw_lane_settings[lane].POST_CURSOR2;
 		}
 
 		cntl.lane_select = lane;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index 2dc4b4e4ba02..a8982ae7e876 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -1124,9 +1124,9 @@ void dcn10_link_encoder_dp_set_lane_settings(
 		/* translate lane settings */
 
 		training_lane_set.bits.VOLTAGE_SWING_SET =
-			link_settings->lane_settings[lane].VOLTAGE_SWING;
+			link_settings->hw_lane_settings[lane].VOLTAGE_SWING;
 		training_lane_set.bits.PRE_EMPHASIS_SET =
-			link_settings->lane_settings[lane].PRE_EMPHASIS;
+			link_settings->hw_lane_settings[lane].PRE_EMPHASIS;
 
 		/* post cursor 2 setting only applies to HBR2 link rate */
 		if (link_settings->link_settings.link_rate == LINK_RATE_HIGH2) {
@@ -1134,7 +1134,7 @@ void dcn10_link_encoder_dp_set_lane_settings(
 			 * to program post cursor 2 level
 			 */
 			training_lane_set.bits.POST_CURSOR2_SET =
-				link_settings->lane_settings[lane].POST_CURSOR2;
+				link_settings->hw_lane_settings[lane].POST_CURSOR2;
 		}
 
 		cntl.lane_select = lane;
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 9ffea7b40545..007274e73347 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -90,7 +90,6 @@ enum lttpr_mode {
 
 struct link_training_settings {
 	struct dc_link_settings link_settings;
-	struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX];
 
 	enum dc_voltage_swing *voltage_swing;
 	enum dc_pre_emphasis *pre_emphasis;
@@ -117,6 +116,21 @@ struct link_training_settings {
 	bool enhanced_framing;
 	bool allow_invalid_msa_timing_param;
 	enum lttpr_mode lttpr_mode;
+
+
+	/* TODO: Move hw_lane_settings along with lane adjust,
+	 * lane align, offset and all other training states
+	 * into a new structure called link training states,
+	 * so link_training_settings becomes a constant input
+	 * pre-decided prior to link training.
+	 *
+	 * The goal is to strictly decouple link training settings
+	 * decision making process from link training states to
+	 * prevent it from messy code practice of changing training
+	 * decision on the fly.
+	 */
+	struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX];
+
 };
 
 /*TODO: Move this enum test harness*/
-- 
2.25.1

