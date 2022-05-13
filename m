Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9ACFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 20:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD84810E888;
	Fri, 13 May 2022 20:51:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B637A10E76F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 20:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn8T7Ow7hZ8Gx0VDsexwlb6ZU7uEyhOkJc1tmxdJHHBzgkNeWwsXiY6c6Cv9VLgzwl66yvZ6dybXqLdbi9vF5B5oZt5YoBxdl9/WimgBHDGU6nbZZ6qiqMlX9nbIhvlw4+vukmKvAKb9kx6hHKPrDPoxWEzzTyVmZcHqp/sGOAyiDbRFQEDJQGAYg2kV2IhD4/rYQMZDLJ3XeSymSS9wGEUWhd2cHEmSc8jnJK7Cv9UT1S7xaC5kY76j0BmInMf1wwzdaTajGdAO+/prCUL7PfA+DG50KCOr8WFwmx1CNRI9jOn+AQSWwNpnrxQ6DQAPgz6xiTESz8O9zl7CgfKbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpoC+j9ZAI1Hwlt+zlrVhxUyP/4uaKj4wZWUApp8HRk=;
 b=GcyX3L6TGqJukUjMbL1SRLDXs/7Nwpw6u/Zp4YZQ+T1jvA1MCbX9BtH7dYgMagrQnxgPCNJ3IuU+kjnCL7Ge7NEzONePUmxgk97YgWpA/P9iX/wMlTca0RzbsHQQo08BiEY8bB1RP1PBzbGoAvV1qzC6+J9sKHBvUq8NkoV7m6zRFNgqMwZtldAx6/7F3Os/SIxn419pTRZkzn4QAaAam2GYQc3cQ5UHCqZk2EbErfFyl7HIYZZL29/Vk/tSh4Ak51c9bVH0fs4sllJ6KJOhzXBEsfzdc+lsTK/dRPp2oR0XDwX9AXMq7c39YUznTZ8LyNzliC4Dw517D3VWByKh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpoC+j9ZAI1Hwlt+zlrVhxUyP/4uaKj4wZWUApp8HRk=;
 b=MFjtk8/Cj7h0Mn/KPemr/U7Y8fAcK+U4yJnwtcUXMYVwCXbumyrl/Kofv7qx6KhEBTLdOqvCu3plWknHYQWMIcuEBPdP1M4srNgER59KkemG1ARjSQ99X/04d8R5LviGW6g4W1lEo85HNAsBJhpVoCWPGHcYvXrfLHbNropDLuo=
Received: from MW4PR03CA0291.namprd03.prod.outlook.com (2603:10b6:303:b5::26)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 13 May
 2022 20:51:26 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::3a) by MW4PR03CA0291.outlook.office365.com
 (2603:10b6:303:b5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Fri, 13 May 2022 20:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 20:51:25 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 15:51:23 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/11] drm/amd/display: Update link training fallback
 behaviour.
Date: Fri, 13 May 2022 16:50:31 -0400
Message-ID: <20220513205041.1311639-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
References: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85624296-6444-45b9-08eb-08da35225883
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24972AB0852C1B25F13758B0FBCA9@BL0PR12MB2497.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpOWG/sXDFxKNzw6V91anClFL0vLFhrdifmbPS13KoCLjArISlg7lZp75LIRYMG5A1BKA/4KAMYxiaprirH22u2u70Mtv5UHgmKRvvLi2zSlIFBuPmNGDrmj3EItLfOYeKEPZaJm657O/OKyY0zl/9V7g2VtXKVvKIoDhglU3vSf67/SyO1rdOIBZULkb8/jm1LGrAhYZ6b2cK4WLreWkeH++GolBa2TAzCDL5YgfAumaXxPEE9SZUXvB5dZwRr4VwCDeTm7vaghDFPj0/545fM4NEkqYSZz3l+9ZWqmFn7oMsrv8rvYdCEoYzCU1ow5snBaGUiElLOhEhvtx7PsrYAApejkpvIMsxEA/aZnmZHQ9x3rY1ySjr55S2IO+kfS2rXADO9+/t8LytxhL+hM5Ut13Wkz1NfhPKwb81BNKrMldvU1KhrB4VD/vkHNC0N3RByZLYL2Ri4grxE3siH9VdXfRdZ7rrXt6hOHvf1kdtf9+BUo7aRgDCcqI37CiqCHp/QzG+F6d1y6SjtqgsF/RNvZiUGXNvEkL/jcv6TmMIYyNVcvHV3EXUefeOU4aVIIQyF/G1rxfgoAbIKJe8f91ddfvu2EF2IYFVn2FQ9eHyLaG3VeNjnA3ys+ph9MjfL5+BYITu3pnmT2x/X3w9vuFXvwmb4YOnDySnJKuks0P8+Tacge/pr+u6C3S962PbIjjEtz4TfHRAdZCyy91NXilw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(44832011)(40460700003)(186003)(47076005)(508600001)(83380400001)(16526019)(6666004)(356005)(2906002)(8936002)(426003)(336012)(26005)(36860700001)(82310400005)(316002)(2616005)(6916009)(54906003)(70206006)(70586007)(1076003)(86362001)(8676002)(36756003)(4326008)(81166007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 20:51:25.4614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85624296-6444-45b9-08eb-08da35225883
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Some displays may need several link training attempts before
link training succeeds.

[How]
If training succeeds after falling back to lower link bandwidth,
retry at original link bandwidth instead of abandoning link training
whenever link bandwidth is less than stream bandwidth.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 77 +++++++++++++------
 1 file changed, 53 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 975d631534b5..d8de8dbf3676 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2783,31 +2783,37 @@ bool perform_link_training_with_retries(
 	struct dc_link *link = stream->link;
 	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
 	enum link_training_result status = LINK_TRAINING_CR_FAIL_LANE0;
-	struct dc_link_settings current_setting = *link_setting;
+	struct dc_link_settings cur_link_settings = *link_setting;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	int fail_count = 0;
+	bool is_link_bw_low = false; /* link bandwidth < stream bandwidth */
+	bool is_link_bw_min = /* RBR x 1 */
+		(cur_link_settings.link_rate <= LINK_RATE_LOW) &&
+		(cur_link_settings.lane_count <= LANE_COUNT_ONE);
 
 	dp_trace_commit_lt_init(link);
 
 
-	if (dp_get_link_encoding_format(&current_setting) == DP_8b_10b_ENCODING)
+	if (dp_get_link_encoding_format(&cur_link_settings) == DP_8b_10b_ENCODING)
 		/* We need to do this before the link training to ensure the idle
 		 * pattern in SST mode will be sent right after the link training
 		 */
 		link_hwss->setup_stream_encoder(pipe_ctx);
 
 	dp_trace_set_lt_start_timestamp(link, false);
-	for (j = 0; j < attempts; ++j) {
+	j = 0;
+	while (j < attempts && fail_count < (attempts * 10)) {
 
-		DC_LOG_HW_LINK_TRAINING("%s: Beginning link training attempt %u of %d\n",
-			__func__, (unsigned int)j + 1, attempts);
+		DC_LOG_HW_LINK_TRAINING("%s: Beginning link training attempt %u of %d @ rate(%d) x lane(%d)\n",
+			__func__, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
+			cur_link_settings.lane_count);
 
 		dp_enable_link_phy(
 			link,
 			&pipe_ctx->link_res,
 			signal,
 			pipe_ctx->clock_source->id,
-			&current_setting);
+			&cur_link_settings);
 
 		if (stream->sink_patches.dppowerup_delay > 0) {
 			int delay_dp_power_up_in_ms = stream->sink_patches.dppowerup_delay;
@@ -2832,30 +2838,30 @@ bool perform_link_training_with_retries(
 		dp_set_panel_mode(link, panel_mode);
 
 		if (link->aux_access_disabled) {
-			dc_link_dp_perform_link_training_skip_aux(link, &pipe_ctx->link_res, &current_setting);
+			dc_link_dp_perform_link_training_skip_aux(link, &pipe_ctx->link_res, &cur_link_settings);
 			return true;
 		} else {
 			/** @todo Consolidate USB4 DP and DPx.x training. */
 			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
 				status = dc_link_dpia_perform_link_training(link,
 						&pipe_ctx->link_res,
-						&current_setting,
+						&cur_link_settings,
 						skip_video_pattern);
 
 				/* Transmit idle pattern once training successful. */
-				if (status == LINK_TRAINING_SUCCESS)
+				if (status == LINK_TRAINING_SUCCESS && !is_link_bw_low)
 					dp_set_hw_test_pattern(link, &pipe_ctx->link_res, DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
 			} else {
 				status = dc_link_dp_perform_link_training(link,
 						&pipe_ctx->link_res,
-						&current_setting,
+						&cur_link_settings,
 						skip_video_pattern);
 			}
 
 			dp_trace_lt_total_count_increment(link, false);
 			dp_trace_lt_result_update(link, status, false);
 			dp_trace_set_lt_end_timestamp(link, false);
-			if (status == LINK_TRAINING_SUCCESS)
+			if (status == LINK_TRAINING_SUCCESS && !is_link_bw_low)
 				return true;
 		}
 
@@ -2866,8 +2872,9 @@ bool perform_link_training_with_retries(
 		if (j == (attempts - 1) && link->ep_type == DISPLAY_ENDPOINT_PHY)
 			break;
 
-		DC_LOG_WARNING("%s: Link training attempt %u of %d failed\n",
-			__func__, (unsigned int)j + 1, attempts);
+		DC_LOG_WARNING("%s: Link training attempt %u of %d failed @ rate(%d) x lane(%d)\n",
+			__func__, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
+			cur_link_settings.lane_count);
 
 		dp_disable_link_phy(link, &pipe_ctx->link_res, signal);
 
@@ -2876,27 +2883,49 @@ bool perform_link_training_with_retries(
 			enum dc_connection_type type = dc_connection_none;
 
 			dc_link_detect_sink(link, &type);
-			if (type == dc_connection_none)
+			if (type == dc_connection_none) {
+				DC_LOG_HW_LINK_TRAINING("%s: Aborting training because sink unplugged\n", __func__);
 				break;
-		} else if (do_fallback) {
+			}
+		}
+
+		/* Try to train again at original settings if:
+		 * - not falling back between training attempts;
+		 * - aborted previous attempt due to reasons other than sink unplug;
+		 * - successfully trained but at a link rate lower than that required by stream;
+		 * - reached minimum link bandwidth.
+		 */
+		if (!do_fallback || (status == LINK_TRAINING_ABORT) ||
+				(status == LINK_TRAINING_SUCCESS && is_link_bw_low) ||
+				is_link_bw_min) {
+			j++;
+			cur_link_settings = *link_setting;
+			delay_between_attempts += LINK_TRAINING_RETRY_DELAY;
+			is_link_bw_low = false;
+			is_link_bw_min = (cur_link_settings.link_rate <= LINK_RATE_LOW) &&
+				(cur_link_settings.lane_count <= LANE_COUNT_ONE);
+
+		} else if (do_fallback) { /* Try training at lower link bandwidth if doing fallback. */
 			uint32_t req_bw;
 			uint32_t link_bw;
 
-			decide_fallback_link_setting(link, *link_setting, &current_setting, status);
-			/* Fail link training if reduced link bandwidth no longer meets
-			 * stream requirements.
+			decide_fallback_link_setting(link, *link_setting, &cur_link_settings, status);
+			/* Flag if reduced link bandwidth no longer meets stream requirements or fallen back to
+			 * minimum link bandwidth.
 			 */
 			req_bw = dc_bandwidth_in_kbps_from_timing(&stream->timing);
-			link_bw = dc_link_bandwidth_kbps(link, &current_setting);
-			if (req_bw > link_bw)
-				break;
+			link_bw = dc_link_bandwidth_kbps(link, &cur_link_settings);
+			is_link_bw_low = (req_bw > link_bw);
+			is_link_bw_min = ((cur_link_settings.link_rate <= LINK_RATE_LOW) &&
+				(cur_link_settings.lane_count <= LANE_COUNT_ONE));
+
+			if (is_link_bw_low)
+				DC_LOG_WARNING("%s: Link bandwidth too low after fallback req_bw(%d) > link_bw(%d)\n",
+					__func__, req_bw, link_bw);
 		}
 
 		msleep(delay_between_attempts);
-
-		delay_between_attempts += LINK_TRAINING_RETRY_DELAY;
 	}
-
 	return false;
 }
 
-- 
2.25.1

