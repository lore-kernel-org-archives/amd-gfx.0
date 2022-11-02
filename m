Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ECAC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4B310E4E7;
	Wed,  2 Nov 2022 16:04:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38E410E4E9
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnWgAdf/E2k2fCVU3ZJxm5CJrC2+VahfOxUYWRwgWl3rq6PSCFoveFAVAPl2HlrrGgNql7KYhMLG6qiPR9P+hCEhZ70anepMa4CXHzXRqJcj91AkCGThTjAvvlpAtrk5ywDtnEW5v5BHFVM5RcoQxy8RlrruItRm5eniepBkc9UkrshfdVx+CH2bVo7nqNMeJ8os7oXnAdXwLBEtBvQVz3WC1CUPr7W9HVIZJEEQHu9PQz5Mt189uLnHODQANEKHWq2Vc50Bn1Nz2UDOVb+0dNK0QZZsOfj4vSiImgMdmzVh34PCEXIB7z/jpJj5qx7xfp2ALhoQNzn+zr/ZkXZLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WrbQ3v6f3ohbBE/BVjenI+d/hptmD3tAkwXL4kJGhU=;
 b=hNPPFom/twGslOvDtIV5cQNIyXlHPZHCyjq2Uwg8DzQkP4Vt8Xvyd62nUV5gsJp56GO1TClgdpFZoN7HktipiQIUXh6OW1YQ5pJlyX1xZdjBnZVXVg1YlxA2zxwdNypW2TsQ9qLqH2FFG/PSlHU+CDAetv4dGUw+pCQ/8TH6xBQKLEq5tWgI/QyLOUaeeli4HG7oiNuqKhPJAv5Kq4WFgXrNRLLvz58zICsuI/J6e8JyGzgymt/oHRBGRuY2lq1MJD/qxIeY5K7On6sAqupxJoz4tPPNJXi3CTTncp6hQiNuMaRSbW52RC0J+OmYzBcqanINaDXjb70JzzV8bpB07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WrbQ3v6f3ohbBE/BVjenI+d/hptmD3tAkwXL4kJGhU=;
 b=c4MezJttO2vqkqbxhKZUqzcbP7dJdcJD4Ufrs+URlrl3MyzWbBdpJ1SOw0QepOsvjBgUqrKnDR7iqIv1Oe60VM9mklUcCr9oiEX4oiA7xwtOiQDUFOz1u6bYy51htT884qRFMBsu4wGaFwC7De8mBxJn8PId/ym0M5ftYqcGUa0=
Received: from DS7PR05CA0079.namprd05.prod.outlook.com (2603:10b6:8:57::9) by
 BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 16:03:52 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::23) by DS7PR05CA0079.outlook.office365.com
 (2603:10b6:8:57::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:51 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:47 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/22] drm/amd/display: Fix fallback issues for DP LL 1.4a
 tests
Date: Thu, 3 Nov 2022 00:01:08 +0800
Message-ID: <20221102160117.506511-14-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|BY5PR12MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: c572128f-754f-4f8b-32f4-08dabcebd62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OeFYpeidY44FUIP8UlnLCHl2S+LRQTS7MWftpgQdAxiRgXHWxGX89MDBbStpWoiFmo5Zj9pDTwMLmqhAofVKHuDj+f0UEl4vdQrQrwDTTv58ffiwARHukEFnkMXB3WwQqILjhUZLzb/9oNi/r+ca/4XWy0WaELGSQx7gvJ4TObcBC36E4XiA7nXtuFQN0TH9nXnV7YWWQMVsalgwXeIh++rofZoUGzY+mnjEJlPchljWvwqCRb/XYCfIXbJTWhAHdwQkArSM7I1WAV3P6TbhCdX9Wc2BvbbxWRDurFWaNeGDiFeud3Qo52VekqjG47NXBNHj1B+g0kzYFZd+mUh0l/iTS2q0LLVQoc1rpZVgPRHJuiGzvw7mOwuwx4QWXFMDHhu9pEVu8hvWxdLeRR4ycX+tD9J19lDq527o/6W/jQkLoOy/5SlsVuDCJ77I5FpZnyhmIaejX2vY71XNuPooXTfkIZwPzsI4LYGwaQ3A8YM33gUHzl5iVR8sIyVuhXhVbbCD+uRssfz6FRdajLVO3EGnAqLoGv6HOGapJWkklegfcS3Ke5DfHD8ok2xxOvkx0IkWpbcKaUGvbUkeXKA8VezW2CP6o7XeCCE6Sjz5OqiW34Bcva+0uA7P8f6RyPRU7gzZQ9yVCCZc5kRlDY1ulZ7UQ1yaCjJ37U4eHI+lYsB2zDtBASa83AMPTqaYIo4TFrncQUKWa9ZjP10gtKK1NwRSvmVTZz0cYBOWrNJjL1nnvbbzvDwM7nMqwr86frympWLLKT3ShgjZAoO0wOKloVY/PQ60XfiG7ziTw2BG5fUL69tcWczj4IoDR5sKIWB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(8936002)(2906002)(5660300002)(4326008)(6916009)(54906003)(316002)(70586007)(70206006)(8676002)(41300700001)(186003)(478600001)(40480700001)(356005)(81166007)(83380400001)(36860700001)(82740400003)(6666004)(7696005)(86362001)(426003)(47076005)(1076003)(336012)(26005)(2616005)(40460700003)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:52.2319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c572128f-754f-4f8b-32f4-08dabcebd62f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Mustapha Ghaddar <mustapha.ghaddar@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY]
Unlike DP or USBC, the USB4 link does not get its own encoder and
has to share therefore verify_caps is skipped.

[HOW]
Fix the fallback logic for automated tests and take that
into consideration for LT and LS.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Mustapha Ghaddar <mustapha.ghaddar@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 22 ++++++++++++++++---
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 15 ++++++++-----
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 601f78b0b08b..cf9191053365 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4554,9 +4554,19 @@ void dc_link_dp_handle_link_loss(struct dc_link *link)
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
-				pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe)
+		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off
+				&& pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe) {
+			// Always use max settings here for DP 1.4a LL Compliance CTS
+			if (link->is_automated) {
+				pipe_ctx->link_config.dp_link_settings.lane_count =
+						link->verified_link_cap.lane_count;
+				pipe_ctx->link_config.dp_link_settings.link_rate =
+						link->verified_link_cap.link_rate;
+				pipe_ctx->link_config.dp_link_settings.link_spread =
+						link->verified_link_cap.link_spread;
+			}
 			core_link_enable_stream(link->dc->current_state, pipe_ctx);
+		}
 	}
 }
 
@@ -4597,6 +4607,8 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 	}
 
 	if (hpd_irq_dpcd_data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
+		// Workaround for DP 1.4a LL Compliance CTS as USB4 has to share encoders unlike DP and USBC
+		link->is_automated = true;
 		device_service_clear.bits.AUTOMATED_TEST = 1;
 		core_link_write_dpcd(
 			link,
@@ -7240,6 +7252,7 @@ void dp_retrain_link_dp_test(struct dc_link *link,
 	struct pipe_ctx *pipes =
 			&link->dc->current_state->res_ctx.pipe_ctx[0];
 	unsigned int i;
+	bool do_fallback = false;
 
 
 	for (i = 0; i < MAX_PIPES; i++) {
@@ -7272,13 +7285,16 @@ void dp_retrain_link_dp_test(struct dc_link *link,
 			memset(&link->cur_link_settings, 0,
 				sizeof(link->cur_link_settings));
 
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+				do_fallback = true;
+
 			perform_link_training_with_retries(
 					link_setting,
 					skip_video_pattern,
 					LINK_TRAINING_ATTEMPTS,
 					&pipes[i],
 					SIGNAL_TYPE_DISPLAY_PORT,
-					false);
+					do_fallback);
 
 			link->dc->hwss.enable_stream(&pipes[i]);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 74e36b34d3f7..d130d58ac08e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -791,10 +791,14 @@ static enum link_training_result dpia_training_eq_transparent(
 		}
 
 		if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
-		    dp_is_symbol_locked(link->cur_link_settings.lane_count, dpcd_lane_status) &&
-		    dp_is_interlane_aligned(dpcd_lane_status_updated)) {
-			result =  LINK_TRAINING_SUCCESS;
-			break;
+				dp_is_symbol_locked(link->cur_link_settings.lane_count, dpcd_lane_status)) {
+			/* Take into consideration corner case for DP 1.4a LL Compliance CTS as USB4
+			 * has to share encoders unlike DP and USBC
+			 */
+			if (dp_is_interlane_aligned(dpcd_lane_status_updated) || (link->is_automated && retries_eq)) {
+				result =  LINK_TRAINING_SUCCESS;
+				break;
+			}
 		}
 
 		/* Update VS/PE. */
@@ -1008,7 +1012,8 @@ enum link_training_result dc_link_dpia_perform_link_training(
 	 */
 	if (result == LINK_TRAINING_SUCCESS) {
 		msleep(5);
-		result = dp_check_link_loss_status(link, &lt_settings);
+		if (!link->is_automated)
+			result = dp_check_link_loss_status(link, &lt_settings);
 	} else if (result == LINK_TRAINING_ABORT) {
 		dpia_training_abort(link, &lt_settings, repeater_id);
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index edb4532eaa39..dc6afe33bca2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -184,6 +184,7 @@ struct dc_link {
 	bool is_dig_mapping_flexible;
 	bool hpd_status; /* HPD status of link without physical HPD pin. */
 	bool is_hpd_pending; /* Indicates a new received hpd */
+	bool is_automated; /* Indicates automated testing */
 
 	bool edp_sink_present;
 
-- 
2.25.1

