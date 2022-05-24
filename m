Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773EAC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 17:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1F710F966;
	Tue, 24 May 2022 17:58:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CCF610F966
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 17:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzSmvPzSXAZWs+MbDPyJS8qgSDAWjgHfQQGfRcr5B5Bte0k34SJfzZ5ThPAjy0/t8kjBOucKRsG0qgHTi0ogIY6dNE4wgdp0nID0zzMOnqy/7ucgu5OaZbn5WN+6hT9FavDeJwUQiL0q/z2UnkpjWIaHU6a6becpAunXuFVREAFyp05HzGrADy1A8i0uRW5800NY8WG/eAIKFhdLFxz7Vv6gbyfCIWS7SOov1VPaIDLSYAhlRtwp+hYdkxjkrQcuMALZ43SUXmpZmkGdz7YDrAP2UvSg+XK0i7cTsT/yzQ61H0vVcVlKCwuBnN8C/vp6t3wtUdCJtya6Zd9o2ZH4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Zp7/hdv9uVcoG4IqdODkmIdiVgH6OLcp/uy/nqsMb4=;
 b=WQ/tEIGHlVVnXjkmgQPiIUKV2QDm/NxSN2aQgzJjTDcz5tk6SXgj9WnG4Pnf9v/IRYgYoRnV2iUL4NEwS52qSvsyvef1awxGV8Ue1SjHVT5wGeIL3V+2Yhz4AUG2hi7SvfYJ7g4hOU7nzBvLTv1ebt04P1bP8L5gvEC2ZrWRqPaIq1eU+E7f2y8G/HOWXbjoFpNp65soWxb4YtkbZjXRSMZcb1LVe8Ff6Nc1gLRct8vg+mssQXXCfHhDuejLMzwa4TYfqKhvgHnMCnj7LGBQJ9M446kScPHC1hJfMyfDiGW7Is8J1JiUIYn8Iy3+KH9n7MN+dxQKmLvLvT2XBkiIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Zp7/hdv9uVcoG4IqdODkmIdiVgH6OLcp/uy/nqsMb4=;
 b=3NeIuZr5a2vZ1WDffOFWqjDuBn44hzGAMsrpGZFX0yWVsz8QyPiU27+LMv0EMApdX/SRN4NGbuF9WRY1cggJarkzbUKxTFqdPyc7Wm7OEO4BH30Hxt8saZNLfCvo5mKgvAWOCP4QRl/iCYC19j+KoONMCQsQj57fuB9r+gPoeyg=
Received: from BN8PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:d4::23)
 by MN2PR12MB2990.namprd12.prod.outlook.com (2603:10b6:208:cc::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Tue, 24 May
 2022 17:58:05 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::55) by BN8PR04CA0049.outlook.office365.com
 (2603:10b6:408:d4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 24 May 2022 17:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:58:05 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 12:58:00 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] Prepare for new interfaces
Date: Tue, 24 May 2022 13:57:22 -0400
Message-ID: <20220524175724.126380-7-jdhillon@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 99fea076-ee78-4917-5eee-08da3daef3fc
X-MS-TrafficTypeDiagnostic: MN2PR12MB2990:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2990D5F58DC4A88D03D449F7FBD79@MN2PR12MB2990.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3FDCE0W6TLArDzmDcCbS6IDyNb7aix5OiuemjBgs1D8yLF2D01kNX2HdIoDsNIoj4Ds3HkcpMNpWWslfhZ+ns29SExkRgIlTa6PrBrBVfLTFtRYWwSk88NJtF924Mg2/NbpKS0vIW3qucPuMx5c/+jO53rtq+xxwpM9vuiv2tDSpFRZMmX9BsQpEOmbwIjixCrXcbbCg2PzTt/zM5TfvKVlS+6kMxr31+1knzvn3WWzvg0fTN4DmrCV0L5UWdxEJ0xL5OEsFrax/wANvIJQS2wOMA/VU7Ws+3tZo9Akjbkhzf5T11G2vonUUWVHuVnJJKKdmwAB7MMLbz2KONZEJMqaRJ8tNOBmQ6FzAVEvCF6rgGh9/rvCKioFiZT1DD02Y2Xdl9O4k8PMq1fuNfspa6Elv9lS5mSCNTo9990QFTDzGFXyJe9ZziUWUygDYUjja3Bl6yOddEnUxm1O80bzdA8t4YTVWxibjSbqGwA5+Y0pyC6rVw/3tlw18iS+JqQuvzjzkS1bGEBX6NQx7srppU2/Os8CW3J6K8EJCQN4UAevsl4g6+j1/3uOFnFciNZx2SMSooLtCK2nnY1qPSz/oOZJnuPGnxiDn8PuF2T4GJ86k+xOKSCMxVtM8F70ebcTAsRO713AYLjNBUaCmm7qPQ9JPASkL8h4EFEj7CIBvCAa0RRtzWiL56OGDydTkcVa9eu9IQ0TJgQfBilONctcvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(70206006)(30864003)(8936002)(5660300002)(6666004)(83380400001)(336012)(40460700003)(2616005)(508600001)(26005)(4326008)(81166007)(1076003)(16526019)(54906003)(426003)(70586007)(186003)(8676002)(6916009)(316002)(47076005)(36756003)(36860700001)(2906002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:58:05.2728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fea076-ee78-4917-5eee-08da3daef3fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2990
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
Cc: stylon.wang@amd.com, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <martin.leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

why:
lut pipeline will be hooked up differently in some asics
need to add new interfaces

how:
add them

Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Martin Leung <martin.leung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 17 +++++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 52 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   | 23 ++++++--
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 13 +++--
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  5 ++
 .../amd/display/dc/inc/hw_sequencer_private.h |  2 +
 10 files changed, 83 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 97e711503695..1853f2198b54 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1506,6 +1506,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		DRM_INFO("Seamless boot condition check passed\n");
 	}
 
+	init_data.flags.enable_mipi_converter_optimization = true;
+
 	INIT_LIST_HEAD(&adev->dm.da_list);
 	/* Display Core create. */
 	adev->dm.dc = dc_create(&init_data);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a789ea8af27f..55a8f58ee239 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -235,7 +235,8 @@ bool dc_link_detect_sink(struct dc_link *link, enum dc_connection_type *type)
 
 	if (link->connector_signal == SIGNAL_TYPE_EDP) {
 		/*in case it is not on*/
-		link->dc->hwss.edp_power_control(link, true);
+		if (!link->dc->config.edp_no_power_sequencing)
+			link->dc->hwss.edp_power_control(link, true);
 		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
 	}
 
@@ -1016,6 +1017,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 	bool same_edid = false;
 	enum dc_edid_status edid_status;
 	struct dc_context *dc_ctx = link->ctx;
+	struct dc *dc = dc_ctx->dc;
 	struct dc_sink *sink = NULL;
 	struct dc_sink *prev_sink = NULL;
 	struct dpcd_caps prev_dpcd_caps;
@@ -1095,6 +1097,16 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 
 			detect_edp_sink_caps(link);
 			read_current_link_settings_on_detect(link);
+
+			/* Disable power sequence on MIPI panel + converter
+			 */
+			if (dc->config.enable_mipi_converter_optimization &&
+				dc_ctx->dce_version == DCN_VERSION_3_01 &&
+				link->dpcd_caps.sink_dev_id == DP_BRANCH_DEVICE_ID_0022B9 &&
+				memcmp(&link->dpcd_caps.branch_dev_name, DP_SINK_BRANCH_DEV_NAME_7580,
+					sizeof(link->dpcd_caps.branch_dev_name)) == 0)
+				dc->config.edp_no_power_sequencing = true;
+
 			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C_OVER_AUX;
 			sink_caps.signal = SIGNAL_TYPE_EDP;
 			break;
@@ -1993,7 +2005,8 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
 		/*in case it is not on*/
-		link->dc->hwss.edp_power_control(link, true);
+		if (!link->dc->config.edp_no_power_sequencing)
+			link->dc->hwss.edp_power_control(link, true);
 		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 3c9523218c19..b60255950844 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2074,7 +2074,8 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	uint32_t wait_time = 0;
 	union lane_align_status_updated dpcd_lane_status_updated = {0};
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
-	enum link_training_result status = LINK_TRAINING_SUCCESS;
+	enum dc_status status = DC_OK;
+	enum link_training_result result = LINK_TRAINING_SUCCESS;
 	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
 
 	/* Transmit 128b/132b_TPS1 over Main-Link */
@@ -2099,22 +2100,24 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 			lt_settings->pattern_for_eq, DPRX);
 
 	/* poll for channel EQ done */
-	while (status == LINK_TRAINING_SUCCESS) {
+	while (result == LINK_TRAINING_SUCCESS) {
 		dp_wait_for_training_aux_rd_interval(link, aux_rd_interval);
 		wait_time += aux_rd_interval;
-		dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
+		status = dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
 				&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
 		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
 			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 		dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
-		if (dp_is_ch_eq_done(lt_settings->link_settings.lane_count,
+		if (status != DC_OK) {
+			result = LINK_TRAINING_ABORT;
+		} else if (dp_is_ch_eq_done(lt_settings->link_settings.lane_count,
 				dpcd_lane_status)) {
 			/* pass */
 			break;
 		} else if (loop_count >= lt_settings->eq_loop_count_limit) {
-			status = DP_128b_132b_MAX_LOOP_COUNT_REACHED;
+			result = DP_128b_132b_MAX_LOOP_COUNT_REACHED;
 		} else if (dpcd_lane_status_updated.bits.LT_FAILED_128b_132b) {
-			status = DP_128b_132b_LT_FAILED;
+			result = DP_128b_132b_LT_FAILED;
 		} else {
 			dp_set_hw_lane_settings(link, link_res, lt_settings, DPRX);
 			dpcd_set_lane_settings(link, lt_settings, DPRX);
@@ -2123,24 +2126,26 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
 	}
 
 	/* poll for EQ interlane align done */
-	while (status == LINK_TRAINING_SUCCESS) {
-		if (dpcd_lane_status_updated.bits.EQ_INTERLANE_ALIGN_DONE_128b_132b) {
+	while (result == LINK_TRAINING_SUCCESS) {
+		if (status != DC_OK) {
+			result = LINK_TRAINING_ABORT;
+		} else if (dpcd_lane_status_updated.bits.EQ_INTERLANE_ALIGN_DONE_128b_132b) {
 			/* pass */
 			break;
 		} else if (wait_time >= lt_settings->eq_wait_time_limit) {
-			status = DP_128b_132b_CHANNEL_EQ_DONE_TIMEOUT;
+			result = DP_128b_132b_CHANNEL_EQ_DONE_TIMEOUT;
 		} else if (dpcd_lane_status_updated.bits.LT_FAILED_128b_132b) {
-			status = DP_128b_132b_LT_FAILED;
+			result = DP_128b_132b_LT_FAILED;
 		} else {
 			dp_wait_for_training_aux_rd_interval(link,
 					lt_settings->eq_pattern_time);
 			wait_time += lt_settings->eq_pattern_time;
-			dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
+			status = dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
 					&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
 		}
 	}
 
-	return status;
+	return result;
 }
 
 static enum link_training_result dp_perform_128b_132b_cds_done_sequence(
@@ -2149,7 +2154,8 @@ static enum link_training_result dp_perform_128b_132b_cds_done_sequence(
 		struct link_training_settings *lt_settings)
 {
 	/* Assumption: assume hardware has transmitted eq pattern */
-	enum link_training_result status = LINK_TRAINING_SUCCESS;
+	enum dc_status status = DC_OK;
+	enum link_training_result result = LINK_TRAINING_SUCCESS;
 	union lane_align_status_updated dpcd_lane_status_updated = {0};
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
 	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
@@ -2159,24 +2165,26 @@ static enum link_training_result dp_perform_128b_132b_cds_done_sequence(
 	dpcd_set_training_pattern(link, lt_settings->pattern_for_cds);
 
 	/* poll for CDS interlane align done and symbol lock */
-	while (status == LINK_TRAINING_SUCCESS) {
+	while (result  == LINK_TRAINING_SUCCESS) {
 		dp_wait_for_training_aux_rd_interval(link,
 				lt_settings->cds_pattern_time);
 		wait_time += lt_settings->cds_pattern_time;
-		dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
+		status = dp_get_lane_status_and_lane_adjust(link, lt_settings, dpcd_lane_status,
 						&dpcd_lane_status_updated, dpcd_lane_adjust, DPRX);
-		if (dp_is_symbol_locked(lt_settings->link_settings.lane_count, dpcd_lane_status) &&
+		if (status != DC_OK) {
+			result = LINK_TRAINING_ABORT;
+		} else if (dp_is_symbol_locked(lt_settings->link_settings.lane_count, dpcd_lane_status) &&
 				dpcd_lane_status_updated.bits.CDS_INTERLANE_ALIGN_DONE_128b_132b) {
 			/* pass */
 			break;
 		} else if (dpcd_lane_status_updated.bits.LT_FAILED_128b_132b) {
-			status = DP_128b_132b_LT_FAILED;
+			result = DP_128b_132b_LT_FAILED;
 		} else if (wait_time >= lt_settings->cds_wait_time_limit) {
-			status = DP_128b_132b_CDS_DONE_TIMEOUT;
+			result = DP_128b_132b_CDS_DONE_TIMEOUT;
 		}
 	}
 
-	return status;
+	return result;
 }
 
 static enum link_training_result dp_perform_8b_10b_link_training(
@@ -7107,7 +7115,8 @@ void dp_enable_link_phy(
 	unsigned int i;
 
 	if (link->connector_signal == SIGNAL_TYPE_EDP) {
-		link->dc->hwss.edp_power_control(link, true);
+		if (!link->dc->config.edp_no_power_sequencing)
+			link->dc->hwss.edp_power_control(link, true);
 		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
 	}
 
@@ -7234,7 +7243,8 @@ void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_
 			link->dc->hwss.edp_backlight_control(link, false);
 		if (link_hwss->ext.disable_dp_link_output)
 			link_hwss->ext.disable_dp_link_output(link, link_res, signal);
-		link->dc->hwss.edp_power_control(link, false);
+		if (!link->dc->config.edp_no_power_sequencing)
+			link->dc->hwss.edp_power_control(link, false);
 	} else {
 		if (dmcu != NULL && dmcu->funcs->lock_phy)
 			dmcu->funcs->lock_phy(dmcu);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1c54628de0ae..1ea662af01b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -337,6 +337,7 @@ struct dc_config {
 	bool is_single_rank_dimm;
 	bool use_pipe_ctx_sync_logic;
 	bool ignore_dpref_ss;
+	bool enable_mipi_converter_optimization;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 7eff7811769d..a76523c95ab2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1245,8 +1245,18 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 			 * has changed or they enter protection state and hang.
 			 */
 			msleep(60);
-		} else if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP)
-			edp_receiver_ready_T9(link);
+		} else if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
+			if (!link->dc->config.edp_no_power_sequencing) {
+				/*
+				 * Sometimes, DP receiver chip power-controlled externally by an
+				 * Embedded Controller could be treated and used as eDP,
+				 * if it drives mobile display. In this case,
+				 * we shouldn't be doing power-sequencing, hence we can skip
+				 * waiting for T9-ready.
+				 */
+				edp_receiver_ready_T9(link);
+			}
+		}
 	}
 
 }
@@ -2181,15 +2191,18 @@ static void dce110_setup_audio_dto(
 			build_audio_output(context, pipe_ctx, &audio_output);
 
 			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
-				/* disable audio DTBCLK DTO */
-				dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
-					dc->res_pool->dccg, 0);
+				struct dtbclk_dto_params dto_params = {0};
 
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 						pipe_ctx->stream_res.audio,
 						pipe_ctx->stream->signal,
 						&audio_output.crtc_info,
 						&audio_output.pll_info);
+
+				dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
+					dc->res_pool->dccg,
+					&dto_params);
+
 			} else
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index bbc58d167c63..4519ecef2e7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -513,7 +513,7 @@ void dccg31_set_physymclk(
 /* Controls the generation of pixel valid for OTG in (OTG -> HPO case) */
 static void dccg31_set_dtbclk_dto(
 		struct dccg *dccg,
-		struct dtbclk_dto_params *params)
+		const struct dtbclk_dto_params *params)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	int req_dtbclk_khz = params->pixclk_khz;
@@ -579,18 +579,17 @@ static void dccg31_set_dtbclk_dto(
 
 void dccg31_set_audio_dtbclk_dto(
 		struct dccg *dccg,
-		uint32_t req_audio_dtbclk_khz)
+		const struct dtbclk_dto_params *params)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (dccg->ref_dtbclk_khz && req_audio_dtbclk_khz) {
+	if (params->ref_dtbclk_khz && params->req_audio_dtbclk_khz) {
 		uint32_t modulo, phase;
 
 		// phase / modulo = dtbclk / dtbclk ref
-		modulo = dccg->ref_dtbclk_khz * 1000;
-		phase = div_u64((((unsigned long long)modulo * req_audio_dtbclk_khz) + dccg->ref_dtbclk_khz - 1),
-			dccg->ref_dtbclk_khz);
-
+		modulo = params->ref_dtbclk_khz * 1000;
+		phase = div_u64((((unsigned long long)modulo * params->req_audio_dtbclk_khz) + params->ref_dtbclk_khz - 1),
+			params->ref_dtbclk_khz);
 
 		REG_WRITE(DCCG_AUDIO_DTBCLK_DTO_MODULO, modulo);
 		REG_WRITE(DCCG_AUDIO_DTBCLK_DTO_PHASE, phase);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index 269cabbea72a..f158c1ea214b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -192,7 +192,7 @@ void dccg31_set_physymclk(
 
 void dccg31_set_audio_dtbclk_dto(
 		struct dccg *dccg,
-		uint32_t req_audio_dtbclk_khz);
+		const struct dtbclk_dto_params *params);
 
 void dccg31_set_hdmistreamclk(
 		struct dccg *dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index c7021915bac8..c1023cc84f55 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -120,11 +120,11 @@ struct dccg_funcs {
 
 	void (*set_dtbclk_dto)(
 			struct dccg *dccg,
-			struct dtbclk_dto_params *dto_params);
+			const struct dtbclk_dto_params *params);
 
 	void (*set_audio_dtbclk_dto)(
 			struct dccg *dccg,
-			uint32_t req_audio_dtbclk_khz);
+			const struct dtbclk_dto_params *params);
 
 	void (*set_dispclk_change_mode)(
 			struct dccg *dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index f5fd2a067323..5097037e3962 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -346,6 +346,11 @@ struct mpc_funcs {
 			int mpcc_id,
 			const struct mpc_grph_gamut_adjustment *adjust);
 
+	bool (*program_1dlut)(
+			struct mpc *mpc,
+			const struct pwl_params *params,
+			uint32_t rmu_idx);
+
 	bool (*program_shaper)(
 			struct mpc *mpc,
 			const struct pwl_params *params,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 8c2f190c4712..d2cb0e794500 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -140,6 +140,8 @@ struct hwseq_private_funcs {
 			const struct dc_plane_state *plane_state);
 	bool (*set_shaper_3dlut)(struct pipe_ctx *pipe_ctx,
 			const struct dc_plane_state *plane_state);
+	bool (*set_mcm_luts)(struct pipe_ctx *pipe_ctx,
+			const struct dc_plane_state *plane_state);
 	void (*PLAT_58856_wa)(struct dc_state *context,
 			struct pipe_ctx *pipe_ctx);
 	void (*setup_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
-- 
2.25.1

