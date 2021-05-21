Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B01FC47076
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A57D61168
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A57D61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF986E526;
	Fri, 21 May 2021 17:37:13 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD306E51B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn1Aag6TSFTcG+sZ7ZIzAyl3EpckZJ57yTySqpH8aaVx34Mb7EKGHJeambEXPmR288leK1KaOqz69F1YQMdm98stnlI5GhG8BXdsyR6uF7AON1nypGMSoU9HdOR3EKDoS/PuL4WJf47+BN/+kGoKICRJQhdVIAvkhk1pBY84BXykQBkzBpSmQ99AJlLXj2XF1Mj+V6RLuKJwMSDBJ0FQyEoqv0mf/6mHA3Psdu3F0A6BRVKejKYPMjxdsQtAf95/PDDmfex66ccvDUWGmHx0Br3nKnNpyQmdDA+MTP72fH14VmxpNDe9hYww+J62lpfoF/+BnDfYGbaFDy8xQr7z6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUXAzCj8KFAelOkPn3srf0yD1pXQu5O7nUe2NhbPPF8=;
 b=UziKGnWgWRGFQomGkmir7mJZZwqfbEOlIPQpyoWg9v/J4wIXTIbjT9b9cvaSC46/d1dbVzq+OepV8gxPqzSj5PmRQLioFhQkZQGSbAFPDK8jXuMkFi87K5GMYlrKbqjHwwck/kuCl3LiTUCRpZ4WD7VMLUxbLNczB702XSw7snc85/8/Es4EcGpl9KmnRNSqWyahc7ROyS+VTXE3JgeNXqXWBBrRUzuvpM4h5u+JUNhjCNOmdem0lFgNDKVLLx9+DNKcJVENvnOOFGHyCpM8TnSrSU5QQ7+sSn6SyQdv7XVdgyqljTRVcjv1DDlUB315Y8+wsBNDCK+5IJYvuCJOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUXAzCj8KFAelOkPn3srf0yD1pXQu5O7nUe2NhbPPF8=;
 b=CFJ5vXIgRYRHC4Rsamf/w0hLWQ9eeP4ukoKkKEoc+egbgjV9dVrBylbEfm19xiqUiPGA/kMjQdlDJSXTyF7cATCK5zPEDOoEIM+bDfpSroT11DFnH1AmR0RD2FqAmZ0HnrpLr7KCgE7PE/c8HykzGghxotpNBQn6FgzVc2F9kuY=
Received: from BN9PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:fa::27)
 by BL0PR12MB4692.namprd12.prod.outlook.com (2603:10b6:208:82::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:37:01 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::17) by BN9PR03CA0022.outlook.office365.com
 (2603:10b6:408:fa::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 17:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:37:01 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:37:00 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/15] drm/amd/display: Expand DP module clock recovery API.
Date: Fri, 21 May 2021 13:36:36 -0400
Message-ID: <20210521173646.1140586-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf65475b-a7c1-4ea1-c5d8-08d91c7f0ae5
X-MS-TrafficTypeDiagnostic: BL0PR12MB4692:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4692FC209578170E14F69814FB299@BL0PR12MB4692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwNYJRJp7Mz7fv6z1WE8Swo7p8xyq8EznnUEnArd4j5V4zbFz/hSdMc9MeoU/9Ln3FY2jm1R6P6aPbX/jsSHEnaXH4uY7zWnF/hf3rgEbd1HwKvbFgxs+hg7tmUIxUtXZZJ4a0UzSlGvojZY9dRZPY7R0xdDw+p5oWdOw+WtcxZVL5ziuLjECusFcLiju2yYtfqm90n5RjsPa6oSR3HbJROw+RSgsiXPC4hGmueO6GVp3qJYOB4/TspRHopNDo+4kjTEqjeKzdahfIuuavQP2BcAa1njXIFizJwwCM4yeZsOTXz2rsZw3ykyKpYmvM4NoEYLcAqGcsrUriatWLdsGoE0f8lXFu3aQOdsvCeJM+boad9elYgD8qQPtpytzCxLXFtGtOaT0rTNQ4YHo/iFYNVW43EBppedMnPevGVNN4wP2xMdcUDiO1XOwP03Tcls3CYN+bVRWt7eRXzmcFL1oR++OJVJAYhKmLOARStGFTF2J1WfKkt69kiHJlefcTgpkkaBf+PxWUHkOKiJznNpZVVCmWf9DTn9O3kRhdJzOLelLST44ofoLZ99UFt+t7fGP0SNCQvw78s/rwMtCRJrnR08oz0+wc3PzMoEylZMcTyqNOAcCIlWkXONf8kkbtB9IwLhzDXqVvLlmGDEG4nXMODj03Li3mf4q4tu+8XnwKAM9DBrjZnkgz1WB5Rc/p3s
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(376002)(136003)(346002)(46966006)(36840700001)(6916009)(2906002)(36860700001)(70586007)(54906003)(478600001)(186003)(16526019)(44832011)(82740400003)(70206006)(426003)(356005)(2616005)(316002)(6666004)(1076003)(8676002)(82310400003)(47076005)(83380400001)(30864003)(36756003)(26005)(81166007)(8936002)(336012)(5660300002)(19627235002)(86362001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:37:01.8450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf65475b-a7c1-4ea1-c5d8-08d91c7f0ae5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4692
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why & How]
Add functionality useful for DP clock recovery phase of link training to
public interface.

Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 79 +++++++++----------
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   | 49 ++++++++++++
 2 files changed, 85 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5812412382c0..d9b538e193c4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -25,8 +25,6 @@ static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
 	link->ctx->logger
 #define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
 
-#define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE   0x50
-
 	/* maximum pre emphasis level allowed for each voltage swing level*/
 	static const enum dc_pre_emphasis
 	voltage_swing_to_pre_emphasis[] = { PRE_EMPHASIS_LEVEL3,
@@ -39,14 +37,6 @@ enum {
 	POST_LT_ADJ_REQ_TIMEOUT = 200
 };
 
-enum {
-	LINK_TRAINING_MAX_RETRY_COUNT = 5,
-	/* to avoid infinite loop where-in the receiver
-	 * switches between different VS
-	 */
-	LINK_TRAINING_MAX_CR_RETRY = 100
-};
-
 static bool decide_fallback_link_setting(
 		struct dc_link_settings initial_link_settings,
 		struct dc_link_settings *current_link_setting,
@@ -97,7 +87,7 @@ static uint32_t get_eq_training_aux_rd_interval(
 	return wait_in_micro_secs;
 }
 
-static void wait_for_training_aux_rd_interval(
+void dp_wait_for_training_aux_rd_interval(
 	struct dc_link *link,
 	uint32_t wait_in_micro_secs)
 {
@@ -108,7 +98,7 @@ static void wait_for_training_aux_rd_interval(
 		wait_in_micro_secs);
 }
 
-static enum dpcd_training_patterns
+enum dpcd_training_patterns
 	dc_dp_training_pattern_to_dpcd_training_pattern(
 	struct dc_link *link,
 	enum dc_dp_training_pattern pattern)
@@ -284,7 +274,7 @@ enum dc_status dpcd_set_link_settings(
 	return status;
 }
 
-static uint8_t dc_dp_initialize_scrambling_data_symbols(
+uint8_t dc_dp_initialize_scrambling_data_symbols(
 	struct dc_link *link,
 	enum dc_dp_training_pattern pattern)
 {
@@ -433,7 +423,7 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 	link->cur_lane_setting = lt_settings->lane_settings[0];
 }
 
-static bool is_cr_done(enum dc_lane_count ln_count,
+bool dp_is_cr_done(enum dc_lane_count ln_count,
 	union lane_status *dpcd_lane_status)
 {
 	uint32_t lane;
@@ -472,7 +462,7 @@ static inline bool is_interlane_aligned(union lane_align_status_updated align_st
 	return align_status.bits.INTERLANE_ALIGN_DONE == 1;
 }
 
-static void update_drive_settings(
+void dp_update_drive_settings(
 		struct link_training_settings *dest,
 		struct link_training_settings src)
 {
@@ -616,7 +606,7 @@ static void find_max_drive_settings(
 
 }
 
-static void get_lane_status_and_drive_settings(
+enum dc_status dp_get_lane_status_and_drive_settings(
 	struct dc_link *link,
 	const struct link_training_settings *link_training_setting,
 	union lane_status *ln_status,
@@ -631,6 +621,7 @@ static void get_lane_status_and_drive_settings(
 	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
 	struct link_training_settings request_settings = { {0} };
 	uint32_t lane;
+	enum dc_status status;
 
 	memset(req_settings, '\0', sizeof(struct link_training_settings));
 
@@ -641,7 +632,7 @@ static void get_lane_status_and_drive_settings(
 		lane_adjust_offset = 3;
 	}
 
-	core_link_read_dpcd(
+	status = core_link_read_dpcd(
 		link,
 		lane01_status_address,
 		(uint8_t *)(dpcd_buf),
@@ -729,9 +720,10 @@ static void get_lane_status_and_drive_settings(
 	 * read DpcdAddress_AdjustRequestPostCursor2 = 0x020C
 	 */
 
+	return status;
 }
 
-static void dpcd_set_lane_settings(
+enum dc_status dpcd_set_lane_settings(
 	struct dc_link *link,
 	const struct link_training_settings *link_training_setting,
 	uint32_t offset)
@@ -739,6 +731,7 @@ static void dpcd_set_lane_settings(
 	union dpcd_training_lane dpcd_lane[LANE_COUNT_DP_MAX] = {{{0}}};
 	uint32_t lane;
 	unsigned int lane0_set_address;
+	enum dc_status status;
 
 	lane0_set_address = DP_TRAINING_LANE0_SET;
 
@@ -766,7 +759,7 @@ static void dpcd_set_lane_settings(
 			PRE_EMPHASIS_MAX_LEVEL ? 1 : 0);
 	}
 
-	core_link_write_dpcd(link,
+	status = core_link_write_dpcd(link,
 		lane0_set_address,
 		(uint8_t *)(dpcd_lane),
 		link_training_setting->link_settings.lane_count);
@@ -812,9 +805,10 @@ static void dpcd_set_lane_settings(
 	}
 	link->cur_lane_setting = link_training_setting->lane_settings[0];
 
+	return status;
 }
 
-static bool is_max_vs_reached(
+bool dp_is_max_vs_reached(
 	const struct link_training_settings *lt_settings)
 {
 	uint32_t lane;
@@ -856,19 +850,19 @@ static bool perform_post_lt_adj_req_sequence(
 			union lane_align_status_updated
 				dpcd_lane_status_updated;
 
-			get_lane_status_and_drive_settings(
-			link,
-			lt_settings,
-			dpcd_lane_status,
-			&dpcd_lane_status_updated,
-			&req_settings,
-			DPRX);
+			dp_get_lane_status_and_drive_settings(
+				link,
+				lt_settings,
+				dpcd_lane_status,
+				&dpcd_lane_status_updated,
+				&req_settings,
+				DPRX);
 
 			if (dpcd_lane_status_updated.bits.
 					POST_LT_ADJ_REQ_IN_PROGRESS == 0)
 				return true;
 
-			if (!is_cr_done(lane_count, dpcd_lane_status))
+			if (!dp_is_cr_done(lane_count, dpcd_lane_status))
 				return false;
 
 			if (!is_ch_eq_done(lane_count, dpcd_lane_status) ||
@@ -891,7 +885,7 @@ static bool perform_post_lt_adj_req_sequence(
 			}
 
 			if (req_drv_setting_changed) {
-				update_drive_settings(
+				dp_update_drive_settings(
 					lt_settings, req_settings);
 
 				dc_link_dp_set_drive_settings(link,
@@ -943,7 +937,7 @@ static uint32_t translate_training_aux_read_interval(uint32_t dpcd_aux_read_inte
 	return aux_rd_interval_us;
 }
 
-static enum link_training_result get_cr_failure(enum dc_lane_count ln_count,
+enum link_training_result dp_get_cr_failure(enum dc_lane_count ln_count,
 					union lane_status *dpcd_lane_status)
 {
 	enum link_training_result result = LINK_TRAINING_SUCCESS;
@@ -1007,14 +1001,14 @@ static enum link_training_result perform_channel_equalization_sequence(
 					translate_training_aux_read_interval(
 						link->dpcd_caps.lttpr_caps.aux_rd_interval[offset - 1]);
 
-		wait_for_training_aux_rd_interval(
+		dp_wait_for_training_aux_rd_interval(
 				link,
 				wait_time_microsec);
 
 		/* 4. Read lane status and requested
 		 * drive settings as set by the sink*/
 
-		get_lane_status_and_drive_settings(
+		dp_get_lane_status_and_drive_settings(
 			link,
 			lt_settings,
 			dpcd_lane_status,
@@ -1023,7 +1017,7 @@ static enum link_training_result perform_channel_equalization_sequence(
 			offset);
 
 		/* 5. check CR done*/
-		if (!is_cr_done(lane_count, dpcd_lane_status))
+		if (!dp_is_cr_done(lane_count, dpcd_lane_status))
 			return LINK_TRAINING_EQ_FAIL_CR;
 
 		/* 6. check CHEQ done*/
@@ -1033,13 +1027,12 @@ static enum link_training_result perform_channel_equalization_sequence(
 			return LINK_TRAINING_SUCCESS;
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
-		update_drive_settings(lt_settings, req_settings);
+		dp_update_drive_settings(lt_settings, req_settings);
 	}
 
 	return LINK_TRAINING_EQ_FAIL_EQ;
 
 }
-#define TRAINING_AUX_RD_INTERVAL 100 //us
 
 static void start_clock_recovery_pattern_early(struct dc_link *link,
 		struct link_training_settings *lt_settings,
@@ -1110,14 +1103,14 @@ static enum link_training_result perform_clock_recovery_sequence(
 		if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
 			wait_time_microsec = TRAINING_AUX_RD_INTERVAL;
 
-		wait_for_training_aux_rd_interval(
+		dp_wait_for_training_aux_rd_interval(
 				link,
 				wait_time_microsec);
 
 		/* 4. Read lane status and requested drive
 		* settings as set by the sink
 		*/
-		get_lane_status_and_drive_settings(
+		dp_get_lane_status_and_drive_settings(
 				link,
 				lt_settings,
 				dpcd_lane_status,
@@ -1126,11 +1119,11 @@ static enum link_training_result perform_clock_recovery_sequence(
 				offset);
 
 		/* 5. check CR done*/
-		if (is_cr_done(lane_count, dpcd_lane_status))
+		if (dp_is_cr_done(lane_count, dpcd_lane_status))
 			return LINK_TRAINING_SUCCESS;
 
 		/* 6. max VS reached*/
-		if (is_max_vs_reached(lt_settings))
+		if (dp_is_max_vs_reached(lt_settings))
 			break;
 
 		/* 7. same lane settings*/
@@ -1145,7 +1138,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 			retries_cr = 0;
 
 		/* 8. update VS/PE/PC2 in lt_settings*/
-		update_drive_settings(lt_settings, req_settings);
+		dp_update_drive_settings(lt_settings, req_settings);
 
 		retry_count++;
 	}
@@ -1158,7 +1151,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 
 	}
 
-	return get_cr_failure(lane_count, dpcd_lane_status);
+	return dp_get_cr_failure(lane_count, dpcd_lane_status);
 }
 
 static inline enum link_training_result dp_transition_to_video_idle(
@@ -1585,7 +1578,7 @@ bool dc_link_dp_perform_link_training_skip_aux(
 	dp_set_hw_lane_settings(link, &lt_settings, DPRX);
 
 	/* wait receiver to lock-on*/
-	wait_for_training_aux_rd_interval(link, lt_settings.cr_pattern_time);
+	dp_wait_for_training_aux_rd_interval(link, lt_settings.cr_pattern_time);
 
 	/* 2. Perform_channel_equalization_sequence. */
 
@@ -1596,7 +1589,7 @@ bool dc_link_dp_perform_link_training_skip_aux(
 	dp_set_hw_lane_settings(link, &lt_settings, DPRX);
 
 	/* wait receiver to lock-on. */
-	wait_for_training_aux_rd_interval(link, lt_settings.eq_pattern_time);
+	dp_wait_for_training_aux_rd_interval(link, lt_settings.eq_pattern_time);
 
 	/* 3. Perform_link_training_int. */
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 3581159e61af..50bd277955a2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -30,11 +30,21 @@
 #define LINK_TRAINING_RETRY_DELAY 50 /* ms */
 #define LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD 3200 /*us*/
 #define LINK_AUX_DEFAULT_TIMEOUT_PERIOD 552 /*us*/
+#define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE 0x50
+#define TRAINING_AUX_RD_INTERVAL 100 //us
 
 struct dc_link;
 struct dc_stream_state;
 struct dc_link_settings;
 
+enum {
+	LINK_TRAINING_MAX_RETRY_COUNT = 5,
+	/* to avoid infinite loop where-in the receiver
+	 * switches between different VS
+	 */
+	LINK_TRAINING_MAX_CR_RETRY = 100
+};
+
 bool dp_verify_link_cap(
 	struct dc_link *link,
 	struct dc_link_settings *known_limit_link_setting,
@@ -92,6 +102,45 @@ void dpcd_set_source_specific_data(struct dc_link *link);
 enum dc_status dpcd_set_link_settings(
 	struct dc_link *link,
 	const struct link_training_settings *lt_settings);
+/* Write DPCD drive settings. */
+enum dc_status dpcd_set_lane_settings(
+	struct dc_link *link,
+	const struct link_training_settings *link_training_setting,
+	uint32_t offset);
+/* Read training status and adjustment requests from DPCD. */
+enum dc_status dp_get_lane_status_and_drive_settings(
+	struct dc_link *link,
+	const struct link_training_settings *link_training_setting,
+	union lane_status *ln_status,
+	union lane_align_status_updated *ln_status_updated,
+	struct link_training_settings *req_settings,
+	uint32_t offset);
+
+void dp_wait_for_training_aux_rd_interval(
+	struct dc_link *link,
+	uint32_t wait_in_micro_secs);
+
+bool dp_is_cr_done(enum dc_lane_count ln_count,
+	union lane_status *dpcd_lane_status);
+
+enum link_training_result dp_get_cr_failure(enum dc_lane_count ln_count,
+	union lane_status *dpcd_lane_status);
+
+bool dp_is_max_vs_reached(
+	const struct link_training_settings *lt_settings);
+
+void dp_update_drive_settings(
+	struct link_training_settings *dest,
+	struct link_training_settings src);
+
+enum dpcd_training_patterns
+	dc_dp_training_pattern_to_dpcd_training_pattern(
+	struct dc_link *link,
+	enum dc_dp_training_pattern pattern);
+
+uint8_t dc_dp_initialize_scrambling_data_symbols(
+	struct dc_link *link,
+	enum dc_dp_training_pattern pattern);
 
 enum dc_status dp_set_fec_ready(struct dc_link *link, bool ready);
 void dp_set_fec_enable(struct dc_link *link, bool enable);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
