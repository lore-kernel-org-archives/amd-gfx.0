Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F553C48BC0
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64A210E418;
	Wed,  7 Feb 2024 20:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QzJyvS5r";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F58110E3C8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx/CZrxw7kBlY3ZQfJS/aKDA+/tl+svp72aobI95m1bdlTGThHICZlJBysr79KA/xKP79byo4BNtJBj5cg5IMLlNAAvvYI+qehIKZP7m2KMnM+0ZcOOPvgeuje82iHtgAoAq7uyw7PhcnkW8LddI/QWZdT9Scm4dnqo6xHq2epgD8aZ6TRV3H4qEhUy3UZUi1dxPSX9FSHis5IjwyzEkbK82x/6uUHUzZgiKoPIHMCjnb3QPhsI3bZxtr/7RHHrh89TlGkriO3J4IQ5Vu5IfawHgU3MJSCeizDjdFajDXiuYYry+9f1J3toZ23PBPjbhcHe/Swm26xBluhPfCS0S8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmowHr4HiSCDk3g5dDnwIca77nnjskKgRnjDl4ssu1w=;
 b=B1FpkrxwfbjiRtZ0+jhcFqG6x9SHlScgRnU2sDkPSp7BWcK3ag4zVBx7Pnnx+e8S8JlOBpMYN8BlvWqX7M4AKh6cciUwfzSDmbXvUPm1fcHg15UagsSeRJQHBozME23xm6Na5rqjdSTch8qH1w7m7LPePQabrzP5sMGWLNa3u+WDbcU0HZsWHwIrF+xOFcvW4/8TZaWAwIDsbb3MC6rFmszeij0QVThacfDrw1w3S8rCIsf686TaPj57yEAbKRHROZKjt5qzZUxBG/XqPMP2eFUfO2vyjaM8Lyu9zhKXIInP1OPsY5jBi7XU8u0Lr1zvYEKEAYASzkXEY0uxsWhTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmowHr4HiSCDk3g5dDnwIca77nnjskKgRnjDl4ssu1w=;
 b=QzJyvS5rxTTSz7zjItKGMhfMk/4+qRGasnKhiZMZwMDz/ebch57dTop8GdEbsU3dinbmOnx/GZcPmzMLrCd75hL/tVxHF7zQGSsIoVnfNz3idDq4KPacCltwuGah8lKoSGsrndM3QTdGPHQ0FKnIoU98NwVtJWFOkKtKOJPULTU=
Received: from DM6PR18CA0008.namprd18.prod.outlook.com (2603:10b6:5:15b::21)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.8; Wed, 7 Feb
 2024 20:52:14 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::d2) by DM6PR18CA0008.outlook.office365.com
 (2603:10b6:5:15b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:52:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:13 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:12 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 07/15] drm/amd/display: Update FIXED_VS Retimer HWSS Test
 Pattern Sequences
Date: Wed, 7 Feb 2024 15:50:42 -0500
Message-ID: <20240207205200.1608684-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 745f1ad2-f0c6-4c91-7f8e-08dc281eaa06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lInSnpEtn8MHA1Dl0pN1uqfS5YD+ewaQToe6Q1QA0MoiTvZ7ObXhwoD+bmOzqUdbeTorcu42N7NZ76K8RrAdP+h9EgCQp8h3kLzo3g3Rs1tAebIoP6l6iGXXaUoA+cvrAfIR2cL7tHrnD25b0qgKrbqANomdqU+urTB8+zW91uKPhZBqZFr1H+aw+nzHGxORdXEWLYNorqhLIh75VMDhoX5s5I+0UV5W4FwyOUMXaNxt0ThiQOt934kdxb+R5BfpmFtZuuBHYxcPvrTDIaydteDvR/cVUI5ddZ3yJSalD7wg7IM5efHiHiQIaE5WP2SHnrAQyye5heMyTIKarj/R8OWF5nt7TRt6Op0pQUXnT1B3cRamQ9NHjAKypg+x9Zhb2RuS8KENTri0biYIoCuA23jo//Y1waWNyJUxqeXNMezkoVlzv4DXSWcG3mFH4kWBbdALLCo1zYXv0USqumRpm+GEOD+r0KPyqKLHv9BH3KdptDB1LarPDwEFWjLk8YyuZDryg3ZTzsPtKg22n9Sym+19PhlbriUBuTF+Vy+u3EF4kC3aHEUtWxCJdidarDnyMnL+FAsJ5WLi5EqDYbiPFTNxzrmekHzKSf8v7gOSYYM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(478600001)(26005)(2616005)(356005)(81166007)(426003)(83380400001)(336012)(1076003)(82740400003)(36756003)(86362001)(15650500001)(5660300002)(54906003)(2906002)(30864003)(7696005)(6666004)(316002)(41300700001)(44832011)(8676002)(70206006)(8936002)(70586007)(6916009)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:14.4731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 745f1ad2-f0c6-4c91-7f8e-08dc281eaa06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Need to fix some broken logic and sequencing in initial commit

[HOW]
Fix logic handling override deprogramming when exiting SQ128.

Don't exit early from dp_set_hw_lane_settings for DP2/FIXED_VS case.

Move LTTPR 128b/132b check out of  requires_hwss and check during
runtime, as LTTPR caps are not populated on initial call.

Add pending_test_pattern to link state to allow HWSS to set FFE overrides
on retimer TX and/or skip setting APU TX FFE depending on requested pattern.

Use updated clock source for SQ128 override sequence.

Skip HW FFE preset programming when performing test pattern overrides.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           | 12 +++++
 .../display/dc/link/accessories/link_dp_cts.c | 27 +++-------
 .../hwss/link_hwss_dio_fixed_vs_pe_retimer.c  | 16 +++---
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    | 51 +++++++++----------
 .../display/dc/link/protocols/link_dp_phy.c   |  6 ++-
 .../amd/display/include/link_service_types.h  |  9 ++++
 6 files changed, 65 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f2c27964ec1c..181144541657 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1572,7 +1572,19 @@ struct dc_link {
 	enum engine_id dpia_preferred_eng_id;
 
 	bool test_pattern_enabled;
+	/* Pending/Current test pattern are only used to perform and track
+	 * FIXED_VS retimer test pattern/lane adjustment override state.
+	 * Pending allows link HWSS to differentiate PHY vs non-PHY pattern,
+	 * to perform specific lane adjust overrides before setting certain
+	 * PHY test patterns. In cases when lane adjust and set test pattern
+	 * calls are not performed atomically (i.e. performing link training),
+	 * pending_test_pattern will be invalid or contain a non-PHY test pattern
+	 * and current_test_pattern will contain required context for any future
+	 * set pattern/set lane adjust to transition between override state(s).
+	 * */
 	enum dp_test_pattern current_test_pattern;
+	enum dp_test_pattern pending_test_pattern;
+
 	union compliance_test_state compliance_test_state;
 
 	void *priv;
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 2d152b68a501..22b24749c9d2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -61,22 +61,6 @@ static enum dc_link_rate get_link_rate_from_test_link_rate(uint8_t test_rate)
 	}
 }
 
-static bool is_dp_phy_sqaure_pattern(enum dp_test_pattern test_pattern)
-{
-	return (DP_TEST_PATTERN_SQUARE_BEGIN <= test_pattern &&
-			test_pattern <= DP_TEST_PATTERN_SQUARE_END);
-}
-
-static bool is_dp_phy_pattern(enum dp_test_pattern test_pattern)
-{
-	if ((DP_TEST_PATTERN_PHY_PATTERN_BEGIN <= test_pattern &&
-			test_pattern <= DP_TEST_PATTERN_PHY_PATTERN_END) ||
-			test_pattern == DP_TEST_PATTERN_VIDEO_MODE)
-		return true;
-	else
-		return false;
-}
-
 static void dp_retrain_link_dp_test(struct dc_link *link,
 			struct dc_link_settings *link_setting,
 			bool skip_video_pattern)
@@ -361,7 +345,7 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 				test_pattern_size);
 	}
 
-	if (is_dp_phy_sqaure_pattern(test_pattern)) {
+	if (IS_DP_PHY_SQUARE_PATTERN(test_pattern)) {
 		test_pattern_size = 1; // Square pattern data is 1 byte (DP spec)
 		core_link_read_dpcd(
 				link,
@@ -623,6 +607,8 @@ bool dp_set_test_pattern(
 	if (pipe_ctx == NULL)
 		return false;
 
+	link->pending_test_pattern = test_pattern;
+
 	/* Reset CRTC Test Pattern if it is currently running and request is VideoMode */
 	if (link->test_pattern_enabled && test_pattern ==
 			DP_TEST_PATTERN_VIDEO_MODE) {
@@ -643,12 +629,13 @@ bool dp_set_test_pattern(
 		/* Reset Test Pattern state */
 		link->test_pattern_enabled = false;
 		link->current_test_pattern = test_pattern;
+		link->pending_test_pattern = DP_TEST_PATTERN_UNSUPPORTED;
 
 		return true;
 	}
 
 	/* Check for PHY Test Patterns */
-	if (is_dp_phy_pattern(test_pattern)) {
+	if (IS_DP_PHY_PATTERN(test_pattern)) {
 		/* Set DPCD Lane Settings before running test pattern */
 		if (p_link_settings != NULL) {
 			if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
@@ -681,6 +668,7 @@ bool dp_set_test_pattern(
 			/* Set Test Pattern state */
 			link->test_pattern_enabled = true;
 			link->current_test_pattern = test_pattern;
+			link->pending_test_pattern = DP_TEST_PATTERN_UNSUPPORTED;
 			if (p_link_settings != NULL)
 				dpcd_set_link_settings(link,
 						p_link_settings);
@@ -756,7 +744,7 @@ bool dp_set_test_pattern(
 			return false;
 
 		if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12) {
-			if (is_dp_phy_sqaure_pattern(test_pattern))
+			if (IS_DP_PHY_SQUARE_PATTERN(test_pattern))
 				core_link_write_dpcd(link,
 						DP_LINK_SQUARE_PATTERN,
 						p_custom_pattern,
@@ -884,6 +872,7 @@ bool dp_set_test_pattern(
 		/* Set Test Pattern state */
 		link->test_pattern_enabled = true;
 		link->current_test_pattern = test_pattern;
+		link->pending_test_pattern = DP_TEST_PATTERN_UNSUPPORTED;
 	}
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c
index b659baa23147..348ea4cb832d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c
@@ -80,21 +80,23 @@ static bool set_dio_fixed_vs_pe_retimer_dp_link_test_pattern_override(struct dc_
 	const uint8_t vendor_lttpr_write_data_pg0[4] = {0x1, 0x11, 0x0, 0x0};
 	const uint8_t vendor_lttpr_exit_manual_automation_0[4] = {0x1, 0x11, 0x0, 0x06};
 
+	if (!link->dpcd_caps.lttpr_caps.main_link_channel_coding.bits.DP_128b_132b_SUPPORTED)
+		return false;
 
 	if (tp_params == NULL)
 		return false;
 
-	if (link->current_test_pattern >= DP_TEST_PATTERN_SQUARE_BEGIN &&
-			link->current_test_pattern <= DP_TEST_PATTERN_SQUARE_END) {
+	if (IS_DP_PHY_SQUARE_PATTERN(link->current_test_pattern))
 		// Deprogram overrides from previous test pattern
 		dp_dio_fixed_vs_pe_retimer_exit_manual_automation(link);
-	}
 
 	switch (tp_params->dp_phy_pattern) {
 	case DP_TEST_PATTERN_80BIT_CUSTOM:
 		if (tp_params->custom_pattern_size == 0 || memcmp(tp_params->custom_pattern,
 				pltpat_custom, tp_params->custom_pattern_size) != 0)
 			return false;
+		hw_tp_params.custom_pattern = tp_params->custom_pattern;
+		hw_tp_params.custom_pattern_size = tp_params->custom_pattern_size;
 		break;
 	case DP_TEST_PATTERN_D102:
 		break;
@@ -185,13 +187,7 @@ static const struct link_hwss dio_fixed_vs_pe_retimer_link_hwss = {
 
 bool requires_fixed_vs_pe_retimer_dio_link_hwss(const struct dc_link *link)
 {
-	if (!(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN))
-		return false;
-
-	if (!link->dpcd_caps.lttpr_caps.main_link_channel_coding.bits.DP_128b_132b_SUPPORTED)
-		return false;
-
-	return true;
+	return (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN);
 }
 
 const struct link_hwss *get_dio_fixed_vs_pe_retimer_link_hwss(void)
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
index b621b97711b6..3e6c7be7e278 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
@@ -74,13 +74,16 @@ static void dp_hpo_fixed_vs_pe_retimer_set_tx_ffe(struct dc_link *link,
 static void dp_hpo_fixed_vs_pe_retimer_program_override_test_pattern(struct dc_link *link,
 		struct encoder_set_dp_phy_pattern_param *tp_params)
 {
+	uint8_t clk_src = 0x4C;
+	uint8_t pattern = 0x4F; /* SQ128 */
+
 	const uint8_t vendor_lttpr_write_data_pg0[4] = {0x1, 0x11, 0x0, 0x0};
-	const uint8_t vendor_lttpr_write_data_pg1[4] = {0x1, 0x50, 0x50, 0x0};
-	const uint8_t vendor_lttpr_write_data_pg2[4] = {0x1, 0x51, 0x50, 0x0};
+	const uint8_t vendor_lttpr_write_data_pg1[4] = {0x1, 0x50, 0x50, clk_src};
+	const uint8_t vendor_lttpr_write_data_pg2[4] = {0x1, 0x51, 0x50, clk_src};
 	const uint8_t vendor_lttpr_write_data_pg3[4]  = {0x1, 0x10, 0x58, 0x21};
 	const uint8_t vendor_lttpr_write_data_pg4[4]  = {0x1, 0x10, 0x59, 0x21};
-	const uint8_t vendor_lttpr_write_data_pg5[4] = {0x1, 0x1C, 0x58, 0x4F};
-	const uint8_t vendor_lttpr_write_data_pg6[4] = {0x1, 0x1C, 0x59, 0x4F};
+	const uint8_t vendor_lttpr_write_data_pg5[4] = {0x1, 0x1C, 0x58, pattern};
+	const uint8_t vendor_lttpr_write_data_pg6[4] = {0x1, 0x1C, 0x59, pattern};
 	const uint8_t vendor_lttpr_write_data_pg7[4]  = {0x1, 0x30, 0x51, 0x20};
 	const uint8_t vendor_lttpr_write_data_pg8[4]  = {0x1, 0x30, 0x52, 0x20};
 	const uint8_t vendor_lttpr_write_data_pg9[4]  = {0x1, 0x30, 0x54, 0x20};
@@ -123,18 +126,20 @@ static bool dp_hpo_fixed_vs_pe_retimer_set_override_test_pattern(struct dc_link
 	struct encoder_set_dp_phy_pattern_param hw_tp_params = { 0 };
 	const uint8_t vendor_lttpr_exit_manual_automation_0[4] = {0x1, 0x11, 0x0, 0x06};
 
+	if (!link->dpcd_caps.lttpr_caps.main_link_channel_coding.bits.DP_128b_132b_SUPPORTED)
+		return false;
+
 	if (tp_params == NULL)
 		return false;
 
-	if (tp_params->dp_phy_pattern < DP_TEST_PATTERN_SQUARE_BEGIN ||
-			tp_params->dp_phy_pattern > DP_TEST_PATTERN_SQUARE_END) {
+	if (!IS_DP_PHY_SQUARE_PATTERN(tp_params->dp_phy_pattern)) {
 		// Deprogram overrides from previously set square wave override
 		if (link->current_test_pattern == DP_TEST_PATTERN_80BIT_CUSTOM ||
 				link->current_test_pattern == DP_TEST_PATTERN_D102)
 			link->dc->link_srv->configure_fixed_vs_pe_retimer(link->ddc,
 					&vendor_lttpr_exit_manual_automation_0[0],
 					sizeof(vendor_lttpr_exit_manual_automation_0));
-		else
+		else if (IS_DP_PHY_SQUARE_PATTERN(link->current_test_pattern))
 			dp_dio_fixed_vs_pe_retimer_exit_manual_automation(link);
 
 		return false;
@@ -148,8 +153,6 @@ static bool dp_hpo_fixed_vs_pe_retimer_set_override_test_pattern(struct dc_link
 
 	dp_hpo_fixed_vs_pe_retimer_program_override_test_pattern(link, tp_params);
 
-	dp_hpo_fixed_vs_pe_retimer_set_tx_ffe(link, &link->cur_lane_setting[0]);
-
 	return true;
 }
 
@@ -170,16 +173,18 @@ static void set_hpo_fixed_vs_pe_retimer_dp_lane_settings(struct dc_link *link,
 		const struct dc_link_settings *link_settings,
 		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
 {
-	link_res->hpo_dp_link_enc->funcs->set_ffe(
-			link_res->hpo_dp_link_enc,
-			link_settings,
-			lane_settings[0].FFE_PRESET.raw);
-
-	// FFE is programmed when retimer is programmed for SQ128, but explicit
-	// programming needed here as well in case FFE-only update is requested
-	if (link->current_test_pattern >= DP_TEST_PATTERN_SQUARE_BEGIN &&
-			link->current_test_pattern <= DP_TEST_PATTERN_SQUARE_END)
-		dp_hpo_fixed_vs_pe_retimer_set_tx_ffe(link, &lane_settings[0]);
+	// Don't update our HW FFE when outputting phy test patterns
+	if (IS_DP_PHY_PATTERN(link->pending_test_pattern)) {
+		// Directly program FIXED_VS retimer FFE for SQ128 override
+		if (IS_DP_PHY_SQUARE_PATTERN(link->pending_test_pattern)) {
+			dp_hpo_fixed_vs_pe_retimer_set_tx_ffe(link, &lane_settings[0]);
+		}
+	} else {
+		link_res->hpo_dp_link_enc->funcs->set_ffe(
+				link_res->hpo_dp_link_enc,
+				link_settings,
+				lane_settings[0].FFE_PRESET.raw);
+	}
 }
 
 static void enable_hpo_fixed_vs_pe_retimer_dp_link_output(struct dc_link *link,
@@ -214,13 +219,7 @@ static const struct link_hwss hpo_fixed_vs_pe_retimer_dp_link_hwss = {
 
 bool requires_fixed_vs_pe_retimer_hpo_link_hwss(const struct dc_link *link)
 {
-	if (!(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN))
-		return false;
-
-	if (!link->dpcd_caps.lttpr_caps.main_link_channel_coding.bits.DP_128b_132b_SUPPORTED)
-		return false;
-
-	return true;
+	return requires_fixed_vs_pe_retimer_dio_link_hwss(link);
 }
 
 const struct link_hwss *get_hpo_fixed_vs_pe_retimer_dp_link_hwss(void)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 0050e0a06cbc..2fa4e64e2430 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -37,6 +37,7 @@
 #include "clk_mgr.h"
 #include "resource.h"
 #include "link_enc_cfg.h"
+#include "atomfirmware.h"
 #define DC_LOGGER \
 	link->ctx->logger
 
@@ -100,8 +101,11 @@ void dp_set_hw_lane_settings(
 {
 	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
 
+	// Don't return here if using FIXED_VS link HWSS and encoding is 128b/132b
 	if ((link_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) &&
-			!is_immediate_downstream(link, offset))
+			!is_immediate_downstream(link, offset) &&
+			(!(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) ||
+			link_dp_get_encoding_format(&link_settings->link_settings) == DP_8b_10b_ENCODING))
 		return;
 
 	if (link_hwss->ext.set_dp_lane_settings)
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 1b8ab20f1715..92dbff22a7c6 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -169,6 +169,15 @@ enum dp_test_pattern {
 	DP_TEST_PATTERN_UNSUPPORTED
 };
 
+#define IS_DP_PHY_SQUARE_PATTERN(test_pattern)\
+		(DP_TEST_PATTERN_SQUARE_BEGIN <= test_pattern &&\
+		test_pattern <= DP_TEST_PATTERN_SQUARE_END)
+
+#define IS_DP_PHY_PATTERN(test_pattern)\
+		((DP_TEST_PATTERN_PHY_PATTERN_BEGIN <= test_pattern &&\
+		test_pattern <= DP_TEST_PATTERN_PHY_PATTERN_END) ||\
+		test_pattern == DP_TEST_PATTERN_VIDEO_MODE)
+
 enum dp_test_pattern_color_space {
 	DP_TEST_PATTERN_COLOR_SPACE_RGB,
 	DP_TEST_PATTERN_COLOR_SPACE_YCBCR601,
-- 
2.43.0

