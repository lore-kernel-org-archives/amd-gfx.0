Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676E5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 21:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC2A10E4A7;
	Fri, 13 May 2022 21:17:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5670B10E4A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 21:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6sA56K7qyDil9g53jUtElh6eKT6gw05q7fu+85cB+ExiaxpQoRvX59fxviukmSyJvXwZsnBVuf+5D9qIy+Nq5uacoWx4zlgkex/kb7c0r+6Ho4tXUe3J3aIyGf7N/j5CP6PjtWBMKF84Eo0ZGgkslXOK/Y79r5WYeAl+IQIMWY5NkAMZX4m9ezNc4Np2aTm8jUdJ0pis8UHAydHR4sOca6bgaURNYnLmw41wyRqAfpgub8cbQW224dEpK2GPzNft3Iu7HBJOsaRRi0A0LQ6ckUVi8pj2SlT9x6fpchjzEyPR+EE2F8h0pJUstBVPDjlPcf5HW8GEY+fIvQnGfnTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpoC+j9ZAI1Hwlt+zlrVhxUyP/4uaKj4wZWUApp8HRk=;
 b=VJA7/q8OkP9t3hp+N+hv43c4SrKUr5w5qcFiIurQpAbxGpnKXN+xzIgzRMH3h9wt0j0fUBf688GGSDy0SSxhw/2r60RkljC9i9Ep+c3147t69AcakUrFQ1P0crFFuqxzCoiVIuVJgRmc8KDWF9sS8/cSoujuD0yeEbr+SuGFGRsSghNSMUfWK9u+VhqhjQRUJU4oJXLg/f07B8eM0xHLhpNiwHjLODkWyY8q1u/Rdr2HLksQrrnGc2P9ewi9UEGrSX3upKeK+Mwzoe/US4CRB3nuyzqqxxeUvqPXK1uXZglLzCDdY69IlvnH9sRfN4psQRIA03usyNXUGKThNqFPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpoC+j9ZAI1Hwlt+zlrVhxUyP/4uaKj4wZWUApp8HRk=;
 b=3GJCXxBgMlLa6s3E425M/hhuHteTwQd58izzeF6wEqjotGHe277vl8uGa2iYud+wSFTCuK7+ZpUcRxdPAdUKvUJ/fHjb/uDzxVQoZbrWe3agU2WLHvvqVacX/P7fEZqkylT8u97q+yMaNui/PEqZA0iiNoGMkiwB2yEhzEB+x2Y=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 21:17:18 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::9a) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16 via Frontend
 Transport; Fri, 13 May 2022 21:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 21:17:17 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:17:15 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 01/11] drm/amd/display: Update link training fallback
 behaviour.
Date: Fri, 13 May 2022 17:16:41 -0400
Message-ID: <20220513211651.1312846-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
References: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2c53ed6-e2ec-4655-5e6c-08da3525f581
X-MS-TrafficTypeDiagnostic: IA1PR12MB6650:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB66501676F3A1D1471E980917FBCA9@IA1PR12MB6650.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1uXnbnu35NcrzhciU4/qBlNB6yMU4ZwCVkL4Z6egRlfShjZRVS9rshpIt/gekTtQlPyFCjWuceSUJWhyLt91uLZi6pzh7j9ceRRH+XzUxcjuXRGCOJ0BTtyuCPi9P8QghJezxNDO3Rx1LNxGMqnKRzNfCqhZ+6cTiKlf2SVO8VZS7MvN9RlgPUjGgir6MPycQRfNtiX0/5cr/KeLL7iQb52T8jmkqST11xrD6Ha8/oRfXgnR9DY3khCTwEN1b4EM7GpP7lXCCulddtnT7S1zFyR84VlotGHOJtUA5QepuM+bHkQm6sJLYRuQ3e6YCCw4rvsw4FtMJTtljiHSWImeAOUcRae0VsJYGcxOJM6QZSW+F5Zn4pVZQJZb/Vul+FGmpSFpLJBm3SMV+U3laxoqTppt93n94WG9jW96XSwZItJkNnuRnj1Q3TnqHpWfE2LY5zxbpvXYrFbIReXJ9z+i5ziTyiRBjeREwhwTLkn7JqqBVs55lB95nkO0M2hvPzZ5QEbjf9S0OPXexWIvi88Uh8RYohIF5HhupoMno//J/qlzKif2yFO0l1itSbB0SaFz36FSjzXGlOa8a/xP7BQSvLboOlIZZMMAz/DU5tn9uylmQZTewSnzXm7/XlszjuJiBGgJ2D5KAzTPUGVcXbAqMbutplGxkwarS/pHrfcq6VsGPhOr1TcUYNfi6m3DJBeLi2mWhjJTAKgv3bH4mtdVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(2906002)(6666004)(508600001)(86362001)(316002)(356005)(83380400001)(5660300002)(26005)(336012)(4326008)(1076003)(44832011)(70586007)(70206006)(2616005)(47076005)(186003)(426003)(8676002)(16526019)(82310400005)(8936002)(36860700001)(40460700003)(36756003)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 21:17:17.3429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c53ed6-e2ec-4655-5e6c-08da3525f581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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

