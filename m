Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2C4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A94810E4FF;
	Thu, 10 Mar 2022 22:21:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B885610E4FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEi5sV2/yV1Z+fblPPJieOQ1GIu05tve9ox8M1sU8YzOoHVTvIXzukNbNGEvXCIQLOm5uR7nU/s7sIrKsmvF5gwxvphu/f4UrSYrhsZlAR83j2wv61ccRpM+478r0yWX5GWgHpL13jhLwdjlPD9yjwj+vUcLQjqkd3xrrOTOGtdsi1ttHBvssSkCDKIyVCdtZoeXeLIiZxxmrVodMsNY0znFmvSSvzZH8iDhAugL++CQQWZSUFyQhOHNbzu99XGsNfWD7IrfDdr/PTLNtyP6DwkoUlFJR8Ul/Gx8LnRcD4CsdSESOb1WNdfB3hL4Ydt+kAW8rCSPlEO2qnDPLEuRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYb8kCsoYKow/OHNtfhJrR4TelWztzRxVvuS1uI3xTk=;
 b=VsZRmrYm7AOu8dlcGHgNzcCUp0IZDXh2/LXzSS6RV4Yt0xCVwF3dNCix+YIsAJxwvpvbXLB/1KH92CXvD/1YwBompQgyO4b0xi8jhXk9PaLdP6tFxxMZ/S/97FCCmDa4ej/jp8bM3VJSDRzXkTjrt+96LKvMPwYo5I15k2OGS8cQnkGTuH33z5KinSOYIPPQQog/cOImRsN2VYmOFNjaPhFSpxCc2vDFYbRfMiaSOT2BQjjIYUUNNRp8BhO1MOHrKoR0xXCAdGt/+tAbKNkDW6gtuzFhU65+A7JKSEyohAoqSBlvBB9KTxzwZGXRf2NvW5i0Ij8UtNaiWJSHxnuSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYb8kCsoYKow/OHNtfhJrR4TelWztzRxVvuS1uI3xTk=;
 b=hsPTaeyYylLHxSPKgPNd9YBHVdI0t71pRrN806+xlZx3hL25Vk7zv4vFY9Mi1VWhgE/0BElUREHbs0WCGAjIZQVbBdhUaL00Sd1Rnq8UUNkZvpeBRly72L850wNTY29rW8Vh5g1LcpVk689Sw1No/AkwMTjasErkzdveHXaMn0U=
Received: from DM5PR15CA0068.namprd15.prod.outlook.com (2603:10b6:3:ae::30) by
 BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Thu, 10 Mar 2022 22:21:45 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::e0) by DM5PR15CA0068.outlook.office365.com
 (2603:10b6:3:ae::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:44 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:40 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amd/display: Retry when fail reading lane status
 during LT
Date: Thu, 10 Mar 2022 17:20:40 -0500
Message-ID: <20220310222045.664867-8-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12a39668-4446-477d-0a4a-08da02e45c0b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4919:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49197D99D8F56456AE0B699BF50B9@BY5PR12MB4919.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qL3qnKvlB9mE8WAiMx354wUacGz0qDdXZULFG/U0fPEElRqOw4WcMrctOfrnv74MtEqngD2OYcSMZsDk6ZXtohig0rhShRemjNfvIaJpFceiYIsHOB6orA0uSic2EvUity7YnWDhBR/QOOX0gZV+Do+2sgdnMz1md06IRgF+we217vVXVu0XSPKRsWat6p4Ryztu08JJUbHyTl06AXHyPFjDOg02sxFH4GFybUcR4VUhKyAKZLBc5BfU4WluKHLm/H+ZL7uWvlN13XtRahCeaS0OuilAVHI63Bnm79mrsQZ3SOqhqfWRiy/e/prIiMeiGlqoTkctTErr8kwNt+ij/LqcWmVNGcgkvi6yBrGAbpmxUh5FQ1MxXPiIg2tLQRJVr3bAfggWXMeAeAlILesr+n3oJAo7/FK8125iOz/YDQlL/zJbidDCftxtYPqDUGqnTAToODeA8xQG5D7ZPiM3rYO0cs8qjvAjNF0LqjWWQ90GQWy+TJut7ch3ALT00Y6WC44gYaaTscxIDTf2vLi4ThWauZhfNUsmDG8cL7+9nEIZs/tn+ZMDYygt5DGITQm7QpvGAqP1jOEaCPS7OMmMBQQRPjQamZ7eipKOAItbP4jsjWlEvLPstTsg7XZlBGVqBWuDGBIRhhMaVemNbuAP0bKuMUYOTF4m5ln9FqgGIs1XKYabVb2/6h0cBCYAMpGb2GbKNYmyl/R2CpIA1GPqyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(316002)(7696005)(47076005)(86362001)(1076003)(508600001)(2906002)(2616005)(8676002)(426003)(336012)(16526019)(36756003)(186003)(26005)(83380400001)(356005)(4326008)(82310400004)(70206006)(70586007)(8936002)(6916009)(5660300002)(81166007)(44832011)(54906003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:44.5279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a39668-4446-477d-0a4a-08da02e45c0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
In dp_get_lane_status_and_lane_adjust(), we call core_link_read_dpcd()
to get lane status but we ignore the return value of the function. If
there is problem with AUX and we eventually can only get partial data
from monitor, we might misuse the data to jude the link training result.
Which could have us trapped in the dc_link_dp_perform_link_training()
since we thought that we can still give a try on another link setting.

[How]
In dp_get_lane_status_and_lane_adjust(), take return value of
core_link_read_dpcd() into account. If we fail to read all requested
data, we treat lanes status as previous one and repeat LT steps again.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 30 ++++++++++++-------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 7d88165e8fa2..ca7bc9ffae45 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -984,6 +984,14 @@ enum dc_status dp_get_lane_status_and_lane_adjust(
 		(uint8_t *)(dpcd_buf),
 		sizeof(dpcd_buf));
 
+	if (status != DC_OK) {
+		DC_LOG_HW_LINK_TRAINING("%s:\n Failed to read from address 0x%X,"
+			" keep current lane status and lane adjust unchanged",
+			__func__,
+			lane01_status_address);
+		return status;
+	}
+
 	for (lane = 0; lane <
 		(uint32_t)(link_training_setting->link_settings.lane_count);
 		lane++) {
@@ -1124,6 +1132,9 @@ static bool perform_post_lt_adj_req_sequence(
 	uint32_t adj_req_timer;
 	bool req_drv_setting_changed;
 	uint32_t lane;
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
+	union lane_align_status_updated dpcd_lane_status_updated = {0};
+	union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
 
 	req_drv_setting_changed = false;
 	for (adj_req_count = 0; adj_req_count < POST_LT_ADJ_REQ_LIMIT;
@@ -1135,11 +1146,6 @@ static bool perform_post_lt_adj_req_sequence(
 			adj_req_timer < POST_LT_ADJ_REQ_TIMEOUT;
 			adj_req_timer++) {
 
-			union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
-			union lane_align_status_updated
-				dpcd_lane_status_updated;
-			union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = { { {0} } };
-
 			dp_get_lane_status_and_lane_adjust(
 				link,
 				lt_settings,
@@ -1366,6 +1372,10 @@ static enum link_training_result perform_clock_recovery_sequence(
 	retries_cr = 0;
 	retry_count = 0;
 
+	memset(&dpcd_lane_status, '\0', sizeof(dpcd_lane_status));
+	memset(&dpcd_lane_status_updated, '\0',
+	sizeof(dpcd_lane_status_updated));
+
 	if (!link->ctx->dc->work_arounds.lt_early_cr_pattern)
 		dp_set_hw_training_pattern(link, link_res, lt_settings->pattern_for_cr, offset);
 
@@ -1377,9 +1387,6 @@ static enum link_training_result perform_clock_recovery_sequence(
 	while ((retries_cr < LINK_TRAINING_MAX_RETRY_COUNT) &&
 		(retry_count < LINK_TRAINING_MAX_CR_RETRY)) {
 
-		memset(&dpcd_lane_status, '\0', sizeof(dpcd_lane_status));
-		memset(&dpcd_lane_status_updated, '\0',
-		sizeof(dpcd_lane_status_updated));
 
 		/* 1. call HWSS to set lane settings*/
 		dp_set_hw_lane_settings(
@@ -2475,12 +2482,13 @@ static enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 		retries_cr = 0;
 		retry_count = 0;
 
+		memset(&dpcd_lane_status, '\0', sizeof(dpcd_lane_status));
+		memset(&dpcd_lane_status_updated, '\0',
+		sizeof(dpcd_lane_status_updated));
+
 		while ((retries_cr < LINK_TRAINING_MAX_RETRY_COUNT) &&
 			(retry_count < LINK_TRAINING_MAX_CR_RETRY)) {
 
-			memset(&dpcd_lane_status, '\0', sizeof(dpcd_lane_status));
-			memset(&dpcd_lane_status_updated, '\0',
-			sizeof(dpcd_lane_status_updated));
 
 			/* 1. call HWSS to set lane settings */
 			dp_set_hw_lane_settings(
-- 
2.35.1

