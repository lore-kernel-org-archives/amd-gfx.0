Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3412C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 17:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7146A10F918;
	Tue, 24 May 2022 17:58:16 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B774610F918
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 17:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpyeUrkjwDMR0qvG9L1lVAgR2MJhadJvob5p2vWeUYBh6joC+Mfl3DGvXWxwbcZJNQdADT+0hDaWFs1QUOg1XfqzuxoyzT7J1HGuZb5EMs7nFMu7ryKjo5ImRfaqeCfGO+y/HuDUMqH/68OP4Nku/RI0HFJwtrB87O1ZosbiLKqv69O0Z9I1gDZ65j7hWBb6WSzussxqh6fva0MsNW/lErGrdzfYAUtd8T2etBwx94pfK7LeGeL0L7P+FBbWxQp0Noch6B7IdwJW8wMY+T3494DN5NvRk8lLAIgiMetAhMJBi2wMdRI247/yYrAhB1lU/mO/TU+G++2j5+d1iPP42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUDqbNTIIcrAZ/awBBFyfc/ZY9dlbABrW+arPbLAceQ=;
 b=TLBA78t6rbMxQsycWchMd5++A6fd2nZ8Lrm0aNd7v+SQr6Sv1vK23BTv5h5VJl86+PfdaZ1E8Ja4380KMomnXHpzzwN8MfzPWeH8QhmUFDDPqTmDCNNjpr9SegEqPVqF6PcQuNjooxm9tI6pSJQKmBu8lrzie3uBeoFM4zzjMlAKNQ/RwLCzMSLpEGMZOqG+u1LsAkxBa07Gtemhw8/H8z0EyxF7LiJpys97U183ugi7cN3ggNEkxGA7GvaCwiKn72ab3UO7dJIBGv+y1xPF3QIx4WruB48cRaqFFuGs9WSJRK9X/RwMmzTKtLyO4HqaRECgyCTLWuNuOf7qa1Yzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUDqbNTIIcrAZ/awBBFyfc/ZY9dlbABrW+arPbLAceQ=;
 b=na6HVquFCu4bm33OlePORJhKeI1BVsngPPlXaUmhz5Jyy2113QTjVu66xXLh++3kfLG9n6vWMwoy2tRLcZDyjekGDaDiezqz68FHepHyLtWrMbkH+fU2CmxAktwudORcQDaomA6twsyMLhuoTIRbMFdtHuXby57eDUfBDMNBaCo=
Received: from DM6PR13CA0021.namprd13.prod.outlook.com (2603:10b6:5:bc::34) by
 BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 17:58:10 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::c9) by DM6PR13CA0021.outlook.office365.com
 (2603:10b6:5:bc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.7 via Frontend
 Transport; Tue, 24 May 2022 17:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:58:10 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 12:58:06 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amd/display: Fix possible infinite loop in DP LT
 fallback
Date: Tue, 24 May 2022 13:57:23 -0400
Message-ID: <20220524175724.126380-8-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524175724.126380-1-jdhillon@amd.com>
References: <20220524175724.126380-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c080fd9-7155-477b-b865-08da3daef707
X-MS-TrafficTypeDiagnostic: BN9PR12MB5260:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5260E28CFC78FAF1E436AFA4FBD79@BN9PR12MB5260.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d89yzzoe1Rh9uQZle0+3GKAgeoWDqudD5B+4mfkpubMYxvdmmbqjC/Mnv123pCglcNxWatdHGF6qFdAVSVHKb7Dm1j6EGOz9AT1uHBUxuVoRctJ0vjp3t3s8qwHKJ1iptOKOCRemudky6g/acEBAwFJhExJBiZB5pfuW86bkSmSJIjgciORD+nQbu+LfbhvZFlUj5svgKtKo81OJDI7TKO7fLgmd5R4Yey4Y4hNKFEjGwIiXPaVCoa0+SqK+t/5LokAkMlROTI9DOEe9KW+Xh3dVZR6NWHppd6hfDjpz/ZlWpf8vqxpfdmyjmx/43H3VQl/mhFziGWxsSwPxmqU5mNFHiYK31mVwpTf6OsliszVIPN4Yt8QzasyfJOw2syIQuMTqiW5pZHzNiSYcDPLR9+e45Qm89UsWDDdJyp+STU1Dl7GWxk7nZIJedoRsa23T0Dk0hZgdXR2fzn253Ds4ms1j8b8Q1+UlAR5Uix9AMXIwGbamMbDf3iYIKcarLmfQq705jX6zVUBgq/4PfJNRTb1zYHsGc3WB7/f7Pzx3V0n0xtNl02iYWTT7Dh5zbU4RIkigO+g/FPAUHDm79iQLnvR/5grOBnbQQfGPJ8j/BiTRuB9Pwm76XUKrNc4fi35pChAb4hWJphr/Wn8Tu63dcqabQoCGSYj/rf4lzM+Txip9P5+AFD9uHBP0j2NV2Qw8LYkLg4Qt83hTonT7ZlrSIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(2906002)(16526019)(186003)(2616005)(40460700003)(83380400001)(426003)(1076003)(6666004)(336012)(8676002)(316002)(508600001)(26005)(356005)(82310400005)(36756003)(70586007)(81166007)(8936002)(70206006)(5660300002)(4326008)(6916009)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:58:10.3491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c080fd9-7155-477b-b865-08da3daef707
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
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
Cc: stylon.wang@amd.com, Ilya <Ilya.Bakoulin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya <Ilya.Bakoulin@amd.com>

[Why]
It's possible for some fallback scenarios to result in infinite looping
during link training.

[How]
This change modifies DP LT fallback behavior to more closely match the
DP standard. Keep track of the link rate during the EQ_FAIL fallback,
and use it as the maximum link rate for the CR sequence.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Signed-off-by: Ilya <Ilya.Bakoulin@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 106 ++++++++----------
 1 file changed, 49 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index b60255950844..bea77172bd14 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -114,8 +114,8 @@ static const struct dc_link_settings fail_safe_link_settings = {
 
 static bool decide_fallback_link_setting(
 		struct dc_link *link,
-		struct dc_link_settings initial_link_settings,
-		struct dc_link_settings *current_link_setting,
+		struct dc_link_settings *max,
+		struct dc_link_settings *cur,
 		enum link_training_result training_result);
 static void maximize_lane_settings(const struct link_training_settings *lt_settings,
 		struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
@@ -2792,6 +2792,7 @@ bool perform_link_training_with_retries(
 	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
 	enum link_training_result status = LINK_TRAINING_CR_FAIL_LANE0;
 	struct dc_link_settings cur_link_settings = *link_setting;
+	struct dc_link_settings max_link_settings = *link_setting;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	int fail_count = 0;
 	bool is_link_bw_low = false; /* link bandwidth < stream bandwidth */
@@ -2801,7 +2802,6 @@ bool perform_link_training_with_retries(
 
 	dp_trace_commit_lt_init(link);
 
-
 	if (dp_get_link_encoding_format(&cur_link_settings) == DP_8b_10b_ENCODING)
 		/* We need to do this before the link training to ensure the idle
 		 * pattern in SST mode will be sent right after the link training
@@ -2917,19 +2917,15 @@ bool perform_link_training_with_retries(
 			uint32_t req_bw;
 			uint32_t link_bw;
 
-			decide_fallback_link_setting(link, *link_setting, &cur_link_settings, status);
-			/* Flag if reduced link bandwidth no longer meets stream requirements or fallen back to
-			 * minimum link bandwidth.
+			decide_fallback_link_setting(link, &max_link_settings,
+					&cur_link_settings, status);
+			/* Fail link training if reduced link bandwidth no longer meets
+			 * stream requirements.
 			 */
 			req_bw = dc_bandwidth_in_kbps_from_timing(&stream->timing);
 			link_bw = dc_link_bandwidth_kbps(link, &cur_link_settings);
-			is_link_bw_low = (req_bw > link_bw);
-			is_link_bw_min = ((cur_link_settings.link_rate <= LINK_RATE_LOW) &&
-				(cur_link_settings.lane_count <= LANE_COUNT_ONE));
-
-			if (is_link_bw_low)
-				DC_LOG_WARNING("%s: Link bandwidth too low after fallback req_bw(%d) > link_bw(%d)\n",
-					__func__, req_bw, link_bw);
+			if (req_bw > link_bw)
+				break;
 		}
 
 		msleep(delay_between_attempts);
@@ -3317,7 +3313,7 @@ static bool dp_verify_link_cap(
 	int *fail_count)
 {
 	struct dc_link_settings cur_link_settings = {0};
-	struct dc_link_settings initial_link_settings = *known_limit_link_setting;
+	struct dc_link_settings max_link_settings = *known_limit_link_setting;
 	bool success = false;
 	bool skip_video_pattern;
 	enum clock_source_id dp_cs_id = get_clock_source_id(link);
@@ -3326,7 +3322,7 @@ static bool dp_verify_link_cap(
 	struct link_resource link_res;
 
 	memset(&irq_data, 0, sizeof(irq_data));
-	cur_link_settings = initial_link_settings;
+	cur_link_settings = max_link_settings;
 
 	/* Grant extended timeout request */
 	if ((link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && (link->dpcd_caps.lttpr_caps.max_ext_timeout > 0)) {
@@ -3369,7 +3365,7 @@ static bool dp_verify_link_cap(
 		dp_trace_lt_result_update(link, status, true);
 		dp_disable_link_phy(link, &link_res, link->connector_signal);
 	} while (!success && decide_fallback_link_setting(link,
-			initial_link_settings, &cur_link_settings, status));
+			&max_link_settings, &cur_link_settings, status));
 
 	link->verified_link_cap = success ?
 			cur_link_settings : fail_safe_link_settings;
@@ -3604,16 +3600,19 @@ static bool decide_fallback_link_setting_max_bw_policy(
  */
 static bool decide_fallback_link_setting(
 		struct dc_link *link,
-		struct dc_link_settings initial_link_settings,
-		struct dc_link_settings *current_link_setting,
+		struct dc_link_settings *max,
+		struct dc_link_settings *cur,
 		enum link_training_result training_result)
 {
-	if (!current_link_setting)
+	if (!cur)
 		return false;
-	if (dp_get_link_encoding_format(&initial_link_settings) == DP_128b_132b_ENCODING ||
+	if (!max)
+		return false;
+
+	if (dp_get_link_encoding_format(max) == DP_128b_132b_ENCODING ||
 			link->dc->debug.force_dp2_lt_fallback_method)
-		return decide_fallback_link_setting_max_bw_policy(link, &initial_link_settings,
-				current_link_setting, training_result);
+		return decide_fallback_link_setting_max_bw_policy(link, max, cur,
+				training_result);
 
 	switch (training_result) {
 	case LINK_TRAINING_CR_FAIL_LANE0:
@@ -3621,28 +3620,18 @@ static bool decide_fallback_link_setting(
 	case LINK_TRAINING_CR_FAIL_LANE23:
 	case LINK_TRAINING_LQA_FAIL:
 	{
-		if (!reached_minimum_link_rate
-				(current_link_setting->link_rate)) {
-			current_link_setting->link_rate =
-				reduce_link_rate(
-					current_link_setting->link_rate);
-		} else if (!reached_minimum_lane_count
-				(current_link_setting->lane_count)) {
-			current_link_setting->link_rate =
-				initial_link_settings.link_rate;
+		if (!reached_minimum_link_rate(cur->link_rate)) {
+			cur->link_rate = reduce_link_rate(cur->link_rate);
+		} else if (!reached_minimum_lane_count(cur->lane_count)) {
+			cur->link_rate = max->link_rate;
 			if (training_result == LINK_TRAINING_CR_FAIL_LANE0)
 				return false;
 			else if (training_result == LINK_TRAINING_CR_FAIL_LANE1)
-				current_link_setting->lane_count =
-						LANE_COUNT_ONE;
-			else if (training_result ==
-					LINK_TRAINING_CR_FAIL_LANE23)
-				current_link_setting->lane_count =
-						LANE_COUNT_TWO;
+				cur->lane_count = LANE_COUNT_ONE;
+			else if (training_result == LINK_TRAINING_CR_FAIL_LANE23)
+				cur->lane_count = LANE_COUNT_TWO;
 			else
-				current_link_setting->lane_count =
-					reduce_lane_count(
-					current_link_setting->lane_count);
+				cur->lane_count = reduce_lane_count(cur->lane_count);
 		} else {
 			return false;
 		}
@@ -3650,17 +3639,17 @@ static bool decide_fallback_link_setting(
 	}
 	case LINK_TRAINING_EQ_FAIL_EQ:
 	{
-		if (!reached_minimum_lane_count
-				(current_link_setting->lane_count)) {
-			current_link_setting->lane_count =
-				reduce_lane_count(
-					current_link_setting->lane_count);
-		} else if (!reached_minimum_link_rate
-				(current_link_setting->link_rate)) {
-			current_link_setting->link_rate =
-				reduce_link_rate(
-					current_link_setting->link_rate);
-			current_link_setting->lane_count = initial_link_settings.lane_count;
+		if (!reached_minimum_lane_count(cur->lane_count)) {
+			cur->lane_count = reduce_lane_count(cur->lane_count);
+		} else if (!reached_minimum_link_rate(cur->link_rate)) {
+			cur->link_rate = reduce_link_rate(cur->link_rate);
+			/* Reduce max link rate to avoid potential infinite loop.
+			 * Needed so that any subsequent CR_FAIL fallback can't
+			 * re-set the link rate higher than the link rate from
+			 * the latest EQ_FAIL fallback.
+			 */
+			max->link_rate = cur->link_rate;
+			cur->lane_count = max->lane_count;
 		} else {
 			return false;
 		}
@@ -3668,12 +3657,15 @@ static bool decide_fallback_link_setting(
 	}
 	case LINK_TRAINING_EQ_FAIL_CR:
 	{
-		if (!reached_minimum_link_rate
-				(current_link_setting->link_rate)) {
-			current_link_setting->link_rate =
-				reduce_link_rate(
-					current_link_setting->link_rate);
-			current_link_setting->lane_count = initial_link_settings.lane_count;
+		if (!reached_minimum_link_rate(cur->link_rate)) {
+			cur->link_rate = reduce_link_rate(cur->link_rate);
+			/* Reduce max link rate to avoid potential infinite loop.
+			 * Needed so that any subsequent CR_FAIL fallback can't
+			 * re-set the link rate higher than the link rate from
+			 * the latest EQ_FAIL fallback.
+			 */
+			max->link_rate = cur->link_rate;
+			cur->lane_count = max->lane_count;
 		} else {
 			return false;
 		}
-- 
2.25.1

