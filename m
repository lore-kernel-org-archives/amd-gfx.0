Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF86C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F5BA10EF2F;
	Fri, 18 Feb 2022 15:04:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7015B10EF2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/VGiU3EdI2Khp67HYDyx2rqZ6nQ1kG/iiUy0mPduQosru9foOUwFVRaAp+c7aDVvhHpYolWBGLMYtjlnjvISEPWETZyF5rDlm1ZI7LiA9djxpF1Wh3rC1qwZBXUmQjZL1GYJZowd/N+OoTJAarpQBgv0cYEU7Cx8S06ZnFqal0tldUmlCa/VEhIAq8pKGPaOY9Wsg8FAHnO8DIhjq5vtDxWWX0MZgr1xCID+pGHagJv/GRmPrhcyLMGqCgOgXtbLe6WglxHPvEdvTbHgTB8otX8n2SiMQF90x70s2g7M/gigoahDAwPWcjQCpl08r4bhCmmYPcHWNgkbXIISP59Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43CSFnuns/i4SRg16M9Pj1p9fSgAhHeHPlRLUchLfNA=;
 b=b7KkgXaUpJrO4gfEYKmQpGMUf/k7NYpAdCop5Hga5cn3fpEqhy00lbEPTL/40+PyFctQDWr1TEzUMu9CzabmkmO2HEnrmDPj7Vo/5A2wUC+Fz5/gWusV4FmTYcKqkq6t6ZtK5IbG+dhW6Gx4gbpaU53aAzUOINLwBsQxAJ+E9x7dNItEJsBhNMHO9cCTw9n6r/6DISOqCC62mKovxp8x4q8MR3pMg5FDInnxQtnV3iK1UynR48mtY/j4RrGjQgwT/0J+DdAri2xN5PXIQGZfDRNYmxFclmzsTmxsMHk0f0nivkAu3Ysy28iEJJ/hg6s/4suxjKQ9wBPlBIdYL72DJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43CSFnuns/i4SRg16M9Pj1p9fSgAhHeHPlRLUchLfNA=;
 b=wCOQqQTMl7UkSg19DiSrAGi8AeLgXzLt6l5xoM3Ch1dk+3W6btD6Iso/fvcrPopK1/rff6qhejm6cj0CgZrqZ3DKxRzIhNhF+N6KUnhGLxCJes5/Yy/tS5jvNjDH0f1BX49n6AVxAf+44ryQtyLxl3D/e7V62hIYn0O0zgM0/MI=
Received: from DS7PR03CA0301.namprd03.prod.outlook.com (2603:10b6:8:2b::8) by
 BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:04:52 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::e7) by DS7PR03CA0301.outlook.office365.com
 (2603:10b6:8:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 15:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:04:52 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:04:46 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/display: Refactor fixed VS logic for
 non-transparent mode
Date: Fri, 18 Feb 2022 23:03:26 +0800
Message-ID: <20220218150329.7976-10-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218150329.7976-1-solomon.chiu@amd.com>
References: <20220218150329.7976-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e49e956b-187f-462e-7759-08d9f2f003fd
X-MS-TrafficTypeDiagnostic: BY5PR12MB5557:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB555737762E878D051C0B55AC97379@BY5PR12MB5557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYCGJGuODIVytJb8tAOuGYc4CtllNvonkaBWceUWa18xYwvl6v9NgveIafaXWoGHvPFP1jCzKlbEE2YzxlwlmGMkBmYH+uEZIJmHKEpHUwd+uy9T/Q3Oyy8ZCPyriwDposQOi4rCNFUDDAEuhL+bJiasVPeCMoMUm5f5V6eUMfxG/6P2vkMDF73FT/cDT3lrtEb/gKoNdeNdx9cmCTFS4jsv1lP9tCV73SpTGhhe2KYUnEfDBVZY+PQDu3EPV3V03Jjp/MAIXVfm3E9Rz+HczxXm6l6cWPWTe9OglbZq/aIuvFZHqDQb9Xlj4rupZekmzfSjDozpjEoHgAIw2ht0LgbmKO+GyrAqa3iRA3K3y/6hzmpPe+WUNPqnyqEeWpTIceGgxcy/H5I0o71nuojyvBEpxTK4JJUpeU3HgAX1lOqMsQ1Fca8yfntZ3AS2XnwE4opIQAznyyVa5vXT6npcVdnoY2CouoFRFN+PIohY2q1jiWwdl7OLVaLcwzTdYNaWZH471dFs6w+S404IBaFcHaE2C3EYE1x40ldZ3IiL/gS64FFdM/JqDheW45YkPXgFj/5uNRpukq7PYKaJnc9qRQCTJ7El3GZVEvL1ijtqaEnCb/sn9HWyuUIpyBxHc64Q4naQIeZUGN/H7Wwm+ufeSVgeJSCJMykXN8yQf/VZ9N9UnOKbcT4fhSfKrzuW79OyJKB60uia4AWFuPtV7BfQqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6916009)(36860700001)(47076005)(16526019)(54906003)(316002)(40460700003)(86362001)(508600001)(336012)(426003)(83380400001)(36756003)(6666004)(186003)(7696005)(8676002)(26005)(70206006)(70586007)(8936002)(4326008)(2616005)(1076003)(44832011)(356005)(5660300002)(2906002)(82310400004)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:04:52.1557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e49e956b-187f-462e-7759-08d9f2f003fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5557
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
 qingqing.zhuo@amd.com, "Shen, George" <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Shen, George" <George.Shen@amd.com>

[Why]
All fixed VS/PE link training sequence should be refactored
into a separate function outside of the standard link training
sequence. This includes the sequence for non-transparent
mode.

[How]
Isolate link training sequence for fixed VS/PE non-transparent
mode into a separate function.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 102 +++++++++++++++++-
 1 file changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index bfd0e48d67a5..5688b15ca9e6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2301,7 +2301,96 @@ static enum link_training_result dp_perform_128b_132b_link_training(
 	return result;
 }
 
-static enum link_training_result dc_link_dp_perform_fixed_vs_pe_training_sequence(
+static enum link_training_result perform_fixed_vs_pe_nontransparent_training_sequence(
+		struct dc_link *link,
+		const struct link_resource *link_res,
+		struct link_training_settings *lt_settings)
+{
+	enum link_training_result status = LINK_TRAINING_SUCCESS;
+	uint8_t lane = 0;
+	uint8_t toggle_rate = 0x6;
+	uint8_t target_rate = 0x6;
+	bool apply_toggle_rate_wa = false;
+	uint8_t repeater_cnt;
+	uint8_t repeater_id;
+
+	/* Fixed VS/PE specific: Force CR AUX RD Interval to at least 16ms */
+	if (lt_settings->cr_pattern_time < 16000)
+		lt_settings->cr_pattern_time = 16000;
+
+	/* Fixed VS/PE specific: Toggle link rate */
+	apply_toggle_rate_wa = (link->vendor_specific_lttpr_link_rate_wa == target_rate);
+	target_rate = get_dpcd_link_rate(&lt_settings->link_settings);
+	toggle_rate = (target_rate == 0x6) ? 0xA : 0x6;
+
+	if (apply_toggle_rate_wa)
+		lt_settings->link_settings.link_rate = toggle_rate;
+
+	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
+		start_clock_recovery_pattern_early(link, link_res, lt_settings, DPRX);
+
+	/* 1. set link rate, lane count and spread. */
+	dpcd_set_link_settings(link, lt_settings);
+
+	/* Fixed VS/PE specific: Toggle link rate back*/
+	if (apply_toggle_rate_wa) {
+		core_link_write_dpcd(
+				link,
+				DP_LINK_BW_SET,
+				&target_rate,
+				1);
+	}
+
+	link->vendor_specific_lttpr_link_rate_wa = target_rate;
+
+	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
+
+		/* 2. perform link training (set link training done
+		 *  to false is done as well)
+		 */
+		repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+
+		for (repeater_id = repeater_cnt; (repeater_id > 0 && status == LINK_TRAINING_SUCCESS);
+				repeater_id--) {
+			status = perform_clock_recovery_sequence(link, link_res, lt_settings, repeater_id);
+
+			if (status != LINK_TRAINING_SUCCESS) {
+				repeater_training_done(link, repeater_id);
+				break;
+			}
+
+			status = perform_channel_equalization_sequence(link,
+					link_res,
+					lt_settings,
+					repeater_id);
+
+			repeater_training_done(link, repeater_id);
+
+			if (status != LINK_TRAINING_SUCCESS)
+				break;
+
+			for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
+				lt_settings->dpcd_lane_settings[lane].raw = 0;
+				lt_settings->hw_lane_settings[lane].VOLTAGE_SWING = 0;
+				lt_settings->hw_lane_settings[lane].PRE_EMPHASIS = 0;
+			}
+		}
+	}
+
+	if (status == LINK_TRAINING_SUCCESS) {
+		status = perform_clock_recovery_sequence(link, link_res, lt_settings, DPRX);
+		if (status == LINK_TRAINING_SUCCESS) {
+			status = perform_channel_equalization_sequence(link,
+								       link_res,
+								       lt_settings,
+								       DPRX);
+		}
+	}
+
+	return status;
+}
+
+static enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	struct dc_link *link,
 	const struct link_resource *link_res,
 	struct link_training_settings *lt_settings)
@@ -2325,6 +2414,11 @@ static enum link_training_result dc_link_dp_perform_fixed_vs_pe_training_sequenc
 	ASSERT(dp_get_link_encoding_format(&lt_settings->link_settings) ==
 			DP_8b_10b_ENCODING);
 
+	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
+		status = perform_fixed_vs_pe_nontransparent_training_sequence(link, link_res, lt_settings);
+		return status;
+	}
+
 	if (offset != 0xFF) {
 		vendor_lttpr_write_address +=
 				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
@@ -2671,10 +2765,8 @@ enum link_training_result dc_link_dp_perform_link_training(
 	 * Per DP specs starting from here, DPTX device shall not issue
 	 * Non-LT AUX transactions inside training mode.
 	 */
-	if (!link->dc->debug.apply_vendor_specific_lttpr_wa &&
-			(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-			link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
-		status = dc_link_dp_perform_fixed_vs_pe_training_sequence(link, link_res, &lt_settings);
+	if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN)
+		status = dp_perform_fixed_vs_pe_training_sequence(link, link_res, &lt_settings);
 	else if (encoding == DP_8b_10b_ENCODING)
 		status = dp_perform_8b_10b_link_training(link, link_res, &lt_settings);
 	else if (encoding == DP_128b_132b_ENCODING)
-- 
2.25.1

