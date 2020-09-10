Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6E1C2D0E0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3879521D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dSXe9/El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3879521D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFBF26E93C;
	Thu, 10 Sep 2020 13:47:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C8E6E93C
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qzq+/R4TF5x/68qQyZxI+7z2gRpWwYEEIgHWymDI5cRZMyRDhw18VxtzrbTtwswubp1KgRFh8kscBvcFgNrkM3vFWWuAcZs4ed3fOVMl9hWZePYg/Jy3sURvL1s1A3piVZirwok4Tz0gIDRHdyULU8ccbiXP5vMtk8MCX1DTnLpXLPD4yDzsHq/TjqD50+L91iMds+5lHefOpYpLOPKaR/WIval5seRaSu8kYrYmibdZWsrytjSQ8SNYs8/QjhYzITkH7dbpfiHoTH+8k0AmZQbUXe3hNt1hx22AlByaoTZeulU0ovu9ylg7j119Nu3cfKUzlFfOX3V2S9S+ikpIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/fp+fnVBIpSOK2m0+FNN89hafPAoU4ugHgjYz3Vup4=;
 b=QOqbRE4h1cLwm530lWkBbXbon9jqBl0tDncU9FAHxEEY9xa5potzx2IC0/HCROrrA9eZ7ZGJ2yyle1pkKQYK6+N666ecP/W+JMulPhVwgmkk4MuaT02+zbhqZfqSCsfnG5Q8Pl2JypAeJL6mNd0eYe+USpRqhpWvIPmvEH9nMwJAsEEHjI7w9MMuDEwbUZ8qljLCNp75plQbK+j/+I4R5obzCJkIXEshJhIsk+Fq48jiKLsnWgW8fcPVhpTlPoqzlmn6St8q6s4vQt25JJr9OKw0ORliUlVJMfpQn9nK7YpAElLEcY//GDReQ2nI6a4MlwXJSmuvvIyhgaSWQIfaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/fp+fnVBIpSOK2m0+FNN89hafPAoU4ugHgjYz3Vup4=;
 b=dSXe9/ElxFPtnVIKGRnE0hjQKR+3ucnl5hMEQkC7I4jPT0zvqHlf9ltvecGNzszwTvCOpchAqn9FvMD7v7vP09mfeMjMUconfZY12eJUeG2FKx468vZS7J/5S7oDAL/ib1z2t0Qmg9f76lefRFGZOPtJPqZTP2a4V4RFnqDC/vk=
Received: from DM5PR04CA0039.namprd04.prod.outlook.com (2603:10b6:3:12b::25)
 by BN8PR12MB3172.namprd12.prod.outlook.com (2603:10b6:408:68::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 13:47:29 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::d8) by DM5PR04CA0039.outlook.office365.com
 (2603:10b6:3:12b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:29 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:28 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/42] drm/amd/display: add option to override cr training
 pattern
Date: Thu, 10 Sep 2020 09:46:48 -0400
Message-ID: <20200910134723.27410-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ede676b-33e8-4173-d40f-08d855900f7c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3172:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3172F2F81D6536AB57C3F8B88B270@BN8PR12MB3172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Odfu2BkF7zpqdV3RN65nFMB3c3f+U5a+K6cvAFVfOBKBkijy6cLaFJal1JLm02pRzU6wQzLj2QzgsArMXYukA34HwP5ZHjAWa9CtMkLKE/6mTlW3YisEeky/lGwtOeJlYBCXyR9FqbBq4061BLaCfYVO2SnnS0FNHWqGmHkEEFaAcs2k3wYJqhHRjSI5jcdaNVJRHiO94raBMqcFI1qeerdGVGpzLo8NLT8JlS/LFoUcp31RjRqV9/E+BLdbpRzAIaXIP7kKioZ85W89UG31xKi7TSpF+x7t5uimTRIXpVPS1BDCV3gHtEiPCj1Xsv9mi6LPh8oRliNno3Vz17AT6mS/nPkhodP1etU1rAqSp0XcJNoE02laxvoYjn/DrWnQaGngmJE0bML7XdGQo2IofA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966005)(54906003)(6666004)(44832011)(26005)(478600001)(8936002)(86362001)(36756003)(186003)(1076003)(47076004)(2616005)(316002)(336012)(7696005)(70206006)(82310400003)(70586007)(83380400001)(2906002)(426003)(356005)(8676002)(4326008)(6916009)(82740400003)(81166007)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:29.5576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ede676b-33e8-4173-d40f-08d855900f7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3172
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 33 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  1 +
 .../amd/display/include/link_service_types.h  |  1 +
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d1d95d3e248a..2334ec428098 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -101,7 +101,16 @@ static void dpcd_set_training_pattern(
 		dpcd_pattern.v1_4.TRAINING_PATTERN_SET);
 }
 
-static enum dc_dp_training_pattern get_supported_tp(struct dc_link *link)
+static enum dc_dp_training_pattern decide_cr_training_pattern(
+		const struct dc_link_settings *link_settings)
+{
+	enum dc_dp_training_pattern pattern = DP_TRAINING_PATTERN_SEQUENCE_1;
+
+	return pattern;
+}
+
+static enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *link,
+		const struct dc_link_settings *link_settings)
 {
 	enum dc_dp_training_pattern highest_tp = DP_TRAINING_PATTERN_SEQUENCE_2;
 	struct encoder_feature_support *features = &link->link_enc->features;
@@ -132,7 +141,6 @@ static void dpcd_set_link_settings(
 
 	union down_spread_ctrl downspread = { {0} };
 	union lane_count_set lane_count_set = { {0} };
-	enum dc_dp_training_pattern dp_tr_pattern;
 
 	downspread.raw = (uint8_t)
 	(lt_settings->link_settings.link_spread);
@@ -143,9 +151,8 @@ static void dpcd_set_link_settings(
 	lane_count_set.bits.ENHANCED_FRAMING = lt_settings->enhanced_framing;
 	lane_count_set.bits.POST_LT_ADJ_REQ_GRANTED = 0;
 
-	dp_tr_pattern = get_supported_tp(link);
 
-	if (dp_tr_pattern != DP_TRAINING_PATTERN_SEQUENCE_4) {
+	if (lt_settings->pattern_for_eq < DP_TRAINING_PATTERN_SEQUENCE_4) {
 		lane_count_set.bits.POST_LT_ADJ_REQ_GRANTED =
 				link->dpcd_caps.max_ln_count.bits.POST_LT_ADJ_REQ_SUPPORTED;
 	}
@@ -979,7 +986,7 @@ static void start_clock_recovery_pattern_early(struct dc_link *link,
 {
 	DC_LOG_HW_LINK_TRAINING("%s\n GPU sends TPS1. Wait 400us.\n",
 			__func__);
-	dp_set_hw_training_pattern(link, DP_TRAINING_PATTERN_SEQUENCE_1, offset);
+	dp_set_hw_training_pattern(link, lt_settings->pattern_for_cr, offset);
 	dp_set_hw_lane_settings(link, lt_settings, offset);
 	udelay(400);
 }
@@ -994,7 +1001,6 @@ static enum link_training_result perform_clock_recovery_sequence(
 	uint32_t wait_time_microsec;
 	struct link_training_settings req_settings;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
-	enum dc_dp_training_pattern tr_pattern = DP_TRAINING_PATTERN_SEQUENCE_1;
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
 	union lane_align_status_updated dpcd_lane_status_updated;
 
@@ -1002,7 +1008,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 	retry_count = 0;
 
 	if (!link->ctx->dc->work_arounds.lt_early_cr_pattern)
-		dp_set_hw_training_pattern(link, tr_pattern, offset);
+		dp_set_hw_training_pattern(link, lt_settings->pattern_for_cr, offset);
 
 	/* najeeb - The synaptics MST hub can put the LT in
 	* infinite loop by switching the VS
@@ -1029,7 +1035,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 			dpcd_set_lt_pattern_and_lane_settings(
 					link,
 					lt_settings,
-					tr_pattern,
+					lt_settings->pattern_for_cr,
 					offset);
 		else
 			dpcd_set_lane_settings(
@@ -1113,7 +1119,7 @@ static inline enum link_training_result perform_link_training_int(
 	 * TPS4 must be used instead of POST_LT_ADJ_REQ.
 	 */
 	if (link->dpcd_caps.max_ln_count.bits.POST_LT_ADJ_REQ_SUPPORTED != 1 ||
-			get_supported_tp(link) == DP_TRAINING_PATTERN_SEQUENCE_4)
+			lt_settings->pattern_for_eq == DP_TRAINING_PATTERN_SEQUENCE_4)
 		return status;
 
 	if (status == LINK_TRAINING_SUCCESS &&
@@ -1252,10 +1258,14 @@ static void initialize_training_settings(
 	else
 		lt_settings->eq_pattern_time = get_training_aux_rd_interval(link, 400);
 
+	if (overrides->pattern_for_cr != NULL)
+		lt_settings->pattern_for_cr = *overrides->pattern_for_cr;
+	else
+		lt_settings->pattern_for_cr = decide_cr_training_pattern(link_setting);
 	if (overrides->pattern_for_eq != NULL)
 		lt_settings->pattern_for_eq = *overrides->pattern_for_eq;
 	else
-		lt_settings->pattern_for_eq = get_supported_tp(link);
+		lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_setting);
 
 	if (overrides->enhanced_framing != NULL)
 		lt_settings->enhanced_framing = *overrides->enhanced_framing;
@@ -1457,7 +1467,6 @@ bool dc_link_dp_perform_link_training_skip_aux(
 	const struct dc_link_settings *link_setting)
 {
 	struct link_training_settings lt_settings;
-	enum dc_dp_training_pattern pattern_for_cr = DP_TRAINING_PATTERN_SEQUENCE_1;
 
 	initialize_training_settings(
 			link,
@@ -1468,7 +1477,7 @@ bool dc_link_dp_perform_link_training_skip_aux(
 	/* 1. Perform_clock_recovery_sequence. */
 
 	/* transmit training pattern for clock recovery */
-	dp_set_hw_training_pattern(link, pattern_for_cr, DPRX);
+	dp_set_hw_training_pattern(link, lt_settings.pattern_for_cr, DPRX);
 
 	/* call HWSS to set lane settings*/
 	dp_set_hw_lane_settings(link, &lt_settings, DPRX);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index a8a3b0643505..80a2191a3115 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -123,6 +123,7 @@ struct dc_link_training_overrides {
 
 	uint16_t *cr_pattern_time;
 	uint16_t *eq_pattern_time;
+	enum dc_dp_training_pattern *pattern_for_cr;
 	enum dc_dp_training_pattern *pattern_for_eq;
 
 	enum dc_link_spread *downspread;
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 550f46e9b95f..7392a89e771f 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -80,6 +80,7 @@ struct link_training_settings {
 
 	uint16_t cr_pattern_time;
 	uint16_t eq_pattern_time;
+	enum dc_dp_training_pattern pattern_for_cr;
 	enum dc_dp_training_pattern pattern_for_eq;
 
 	bool enhanced_framing;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
