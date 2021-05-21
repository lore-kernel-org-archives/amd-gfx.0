Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C744FC4707C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D2A611AB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D2A611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8426E51C;
	Fri, 21 May 2021 17:37:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242296E15F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz+lrY+cbA6QrnwPyHgvSGpc1rbZLOkD2MIMXTbZRVflaSB5c3XR3/Lg7Vp2RMD/YG4BqI6B2ZJ/OyZds0gjIlGdzUVRj+dDmVNzULxgLSyADTghZawPbsVSEyOPCeVUiBqwkkK1ZCCKTZrmT0lrXVAMmemwUKncbUCT5h1CZjjeRS3Yjpq0nnvxBVEQn2GisgB+ixSoVoE+bufaX+sd7ogY6spg34IxAu0P7WL/NkRDrd0zHvQU0qyf8/miypdlNFwx2CGSaT/skDlrWp7/U2y3D+al/d/XQqdAkQxAnw/6htyhnCPuoQRlwQHGSdCIsDGSpN/MNaclyv+JYcPSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bui1dYTWQ2iYxLHHQl9tzv3lOWiHrmUKe3UrwOWQU3E=;
 b=VBUhiYE4VJzclqqHL2aDxljC3NAMmPUGUX7pl/2zFEqWnFoqWQXpgMT6kFtFs9u2mGA8iukXs39TX+lWRk0TxeY70Cy35QosouU2+3retgy0TF3IhyvFStk5t0WHQ6JjILKMsJ4OOqnxnzQN+4SFcDc2qE4YLAcrKVRptvrKVcqzHB1wAwZVodlU1JygAlkveyAh7BoQNmLQzn7bX5uvDLSbC6cYPx88+esgGAYjH9URAEFURrUNSohJ6qkeaH3opcVPTW7E+yLObq6vp6ezc+z5w8MGeGmvWogF/cXKHmCmQIggJZkhpl7MhTUgNuyv/dHF+tSU6RZd2yindvoanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bui1dYTWQ2iYxLHHQl9tzv3lOWiHrmUKe3UrwOWQU3E=;
 b=V+CaNFpcaP9jLx1qVm3wm2EdACC8NF246T+Fg3e7N+YLCMWihUX9yf5oSpX8brzX9nqxoRyA9NYt0mrsL4nF5uZ4yu1oo7zuhDEAtDXjSs2pBAW1THdUifcTBhRq+NQlFKRPf7GNabLJweba2/uXiHCrCGba04xLrEWVpplu0BQ=
Received: from BN6PR1201CA0018.namprd12.prod.outlook.com
 (2603:10b6:405:4c::28) by BYAPR12MB4981.namprd12.prod.outlook.com
 (2603:10b6:a03:10d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:37:01 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::af) by BN6PR1201CA0018.outlook.office365.com
 (2603:10b6:405:4c::28) with Microsoft SMTP Server (version=TLS1_2,
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
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:37:00 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:36:59 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/15] drm/amd/display: Update DP link configuration.
Date: Fri, 21 May 2021 13:36:35 -0400
Message-ID: <20210521173646.1140586-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75837dc6-e68a-492f-efc2-08d91c7f0a56
X-MS-TrafficTypeDiagnostic: BYAPR12MB4981:
X-Microsoft-Antispam-PRVS: <BYAPR12MB49810F8567AE3E7220BF6063FB299@BYAPR12MB4981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qGRjBwwC//aGc63ADXJHJeOY1QJ4mqlOd95bqregRIT/KfjD0tUUrSykJm7Ye+JdWGlsKA1RNfHJ65FmOY6mvW3o3jDuqSJ1EwATeH0Op2MCuNjE7q3jGHE7X8qkG4nEwns9hmtSG+3ypxoQHNiYDkIBhdkD/ijy+bktQeO86YGnY+ryx9rZTg2HQ00ziyYZWuKpmgOCbOQ3d1mlJfwSE48QEVE7qcR6/qDwYPxeCZyKd4t49k8VTreMJAr+VjYjMB0abiQvSRRo/l7XUtnGffHgpw6jzXFrDsD7AjcYjirdih3XeGEU530AHQgjDKD1Y1embtMfCqAMAe/Ds9us+5Rlmp6w2nYnClFU5aqfxcCtoUjag0OeZzz3XFthWU5otD8wnroq4PsE36ZS6PHb4ndQ29PhfZ4LczOsIPT0HKcgmbQ16RFk54sf1kedrSviLLq14op7qYKtLDiADLEgd30+3qyNYVaYRgDhxvsHlwHBvm6jyLdmM238VRFzU2yQQQ63U4VLpgKWGHUx++BF/2+4oSnyfjw9x08hv8hX8uKp5XmHKLR5ESGpYvv4542MsskPBTZrQOtLUhQv3zRBW4VM94PPtMxHFiIXHDmGf565TMq5uRj0F4vtL0Pb+WqXGaDaa/lhwZJCkHYwDXTDqi+QWnV0eov+igekk8rR/giy7zUBSd5UHlTt50IMm/+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(36860700001)(316002)(47076005)(36756003)(186003)(16526019)(70206006)(8936002)(8676002)(70586007)(54906003)(356005)(81166007)(4326008)(1076003)(82740400003)(2906002)(86362001)(336012)(83380400001)(6916009)(6666004)(15650500001)(426003)(2616005)(5660300002)(26005)(478600001)(82310400003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:37:00.9090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75837dc6-e68a-492f-efc2-08d91c7f0a56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4981
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
- Update application of training settings for links whose encoders are
assigned dynamically.
- Add functionality useful for DP link configuration to public
interface.

Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 91 ++++++++++++++-----
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   | 17 +++-
 2 files changed, 83 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9e08410bfdfd..5812412382c0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -206,11 +206,12 @@ static enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *li
 	return DP_TRAINING_PATTERN_SEQUENCE_2;
 }
 
-static void dpcd_set_link_settings(
+enum dc_status dpcd_set_link_settings(
 	struct dc_link *link,
 	const struct link_training_settings *lt_settings)
 {
 	uint8_t rate;
+	enum dc_status status;
 
 	union down_spread_ctrl downspread = { {0} };
 	union lane_count_set lane_count_set = { {0} };
@@ -225,15 +226,16 @@ static void dpcd_set_link_settings(
 	lane_count_set.bits.POST_LT_ADJ_REQ_GRANTED = 0;
 
 
-	if (lt_settings->pattern_for_eq < DP_TRAINING_PATTERN_SEQUENCE_4) {
+	if (link->ep_type == DISPLAY_ENDPOINT_PHY &&
+			lt_settings->pattern_for_eq < DP_TRAINING_PATTERN_SEQUENCE_4) {
 		lane_count_set.bits.POST_LT_ADJ_REQ_GRANTED =
 				link->dpcd_caps.max_ln_count.bits.POST_LT_ADJ_REQ_SUPPORTED;
 	}
 
-	core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
+	status = core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
 		&downspread.raw, sizeof(downspread));
 
-	core_link_write_dpcd(link, DP_LANE_COUNT_SET,
+	status = core_link_write_dpcd(link, DP_LANE_COUNT_SET,
 		&lane_count_set.raw, 1);
 
 	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_14 &&
@@ -249,12 +251,12 @@ static void dpcd_set_link_settings(
 			core_link_read_dpcd(link, DP_SUPPORTED_LINK_RATES,
 					supported_link_rates, sizeof(supported_link_rates));
 		}
-		core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
-		core_link_write_dpcd(link, DP_LINK_RATE_SET,
+		status = core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
+		status = core_link_write_dpcd(link, DP_LINK_RATE_SET,
 				&lt_settings->link_settings.link_rate_set, 1);
 	} else {
 		rate = (uint8_t) (lt_settings->link_settings.link_rate);
-		core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
+		status = core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
 	}
 
 	if (rate) {
@@ -278,6 +280,8 @@ static void dpcd_set_link_settings(
 			DP_DOWNSPREAD_CTRL,
 			lt_settings->link_settings.link_spread);
 	}
+
+	return status;
 }
 
 static uint8_t dc_dp_initialize_scrambling_data_symbols(
@@ -1329,7 +1333,7 @@ static inline void decide_8b_10b_training_settings(
 		lt_settings->enhanced_framing = 1;
 }
 
-static void decide_training_settings(
+void dp_decide_training_settings(
 		struct dc_link *link,
 		const struct dc_link_settings *link_settings,
 		const struct dc_link_training_overrides *overrides,
@@ -1365,18 +1369,18 @@ uint8_t dp_convert_to_count(uint8_t lttpr_repeater_count)
 	return 0; // invalid value
 }
 
-static void configure_lttpr_mode_transparent(struct dc_link *link)
+enum dc_status configure_lttpr_mode_transparent(struct dc_link *link)
 {
 	uint8_t repeater_mode = DP_PHY_REPEATER_MODE_TRANSPARENT;
 
 	DC_LOG_HW_LINK_TRAINING("%s\n Set LTTPR to Transparent Mode\n", __func__);
-	core_link_write_dpcd(link,
+	return core_link_write_dpcd(link,
 			DP_PHY_REPEATER_MODE,
 			(uint8_t *)&repeater_mode,
 			sizeof(repeater_mode));
 }
 
-static void configure_lttpr_mode_non_transparent(
+enum dc_status configure_lttpr_mode_non_transparent(
 		struct dc_link *link,
 		const struct link_training_settings *lt_settings)
 {
@@ -1431,6 +1435,8 @@ static void configure_lttpr_mode_non_transparent(
 			}
 		}
 	}
+
+	return result;
 }
 
 static void repeater_training_done(struct dc_link *link, uint32_t offset)
@@ -1564,7 +1570,7 @@ bool dc_link_dp_perform_link_training_skip_aux(
 {
 	struct link_training_settings lt_settings;
 
-	decide_training_settings(
+	dp_decide_training_settings(
 			link,
 			link_setting,
 			&link->preferred_training_settings,
@@ -1602,6 +1608,19 @@ bool dc_link_dp_perform_link_training_skip_aux(
 	return true;
 }
 
+enum dc_status dpcd_configure_lttpr_mode(struct dc_link *link, struct link_training_settings *lt_settings)
+{
+	enum dc_status status = DC_OK;
+
+	if (lt_settings->lttpr_mode == LTTPR_MODE_TRANSPARENT)
+		status = configure_lttpr_mode_transparent(link);
+
+	else if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
+		status = configure_lttpr_mode_non_transparent(link, lt_settings);
+
+	return status;
+}
+
 enum link_training_result dc_link_dp_perform_link_training(
 	struct dc_link *link,
 	const struct dc_link_settings *link_setting,
@@ -1614,7 +1633,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 	uint8_t repeater_cnt;
 	uint8_t repeater_id;
 
-	decide_training_settings(
+	dp_decide_training_settings(
 			link,
 			link_setting,
 			&link->preferred_training_settings,
@@ -1899,7 +1918,7 @@ enum link_training_result dc_link_dp_sync_lt_attempt(
 	enum clock_source_id dp_cs_id = CLOCK_SOURCE_ID_EXTERNAL;
 	bool fec_enable = false;
 
-	decide_training_settings(
+	dp_decide_training_settings(
 		link,
 		link_settings,
 		lt_overrides,
@@ -4606,50 +4625,74 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
 	return DP_PANEL_MODE_DEFAULT;
 }
 
-void dp_set_fec_ready(struct dc_link *link, bool ready)
+enum dc_status dp_set_fec_ready(struct dc_link *link, bool ready)
 {
 	/* FEC has to be "set ready" before the link training.
 	 * The policy is to always train with FEC
 	 * if the sink supports it and leave it enabled on link.
 	 * If FEC is not supported, disable it.
 	 */
-	struct link_encoder *link_enc = link->link_enc;
+	struct link_encoder *link_enc = NULL;
+	enum dc_status status = DC_OK;
 	uint8_t fec_config = 0;
 
+	/* Access link encoder based on whether it is statically
+	 * or dynamically assigned to a link.
+	 */
+	if (link->is_dig_mapping_flexible &&
+			link->dc->res_pool->funcs->link_encs_assign)
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(link->dc->current_state, link);
+	else
+		link_enc = link->link_enc;
+	ASSERT(link_enc);
+
 	if (!dc_link_should_enable_fec(link))
-		return;
+		return status;
 
 	if (link_enc->funcs->fec_set_ready &&
 			link->dpcd_caps.fec_cap.bits.FEC_CAPABLE) {
 		if (ready) {
 			fec_config = 1;
-			if (core_link_write_dpcd(link,
+			status = core_link_write_dpcd(link,
 					DP_FEC_CONFIGURATION,
 					&fec_config,
-					sizeof(fec_config)) == DC_OK) {
+					sizeof(fec_config));
+			if (status == DC_OK) {
 				link_enc->funcs->fec_set_ready(link_enc, true);
 				link->fec_state = dc_link_fec_ready;
 			} else {
-				link->link_enc->funcs->fec_set_ready(link->link_enc, false);
+				link_enc->funcs->fec_set_ready(link->link_enc, false);
 				link->fec_state = dc_link_fec_not_ready;
 				dm_error("dpcd write failed to set fec_ready");
 			}
 		} else if (link->fec_state == dc_link_fec_ready) {
 			fec_config = 0;
-			core_link_write_dpcd(link,
+			status = core_link_write_dpcd(link,
 					DP_FEC_CONFIGURATION,
 					&fec_config,
 					sizeof(fec_config));
-			link->link_enc->funcs->fec_set_ready(
-					link->link_enc, false);
+			link_enc->funcs->fec_set_ready(link_enc, false);
 			link->fec_state = dc_link_fec_not_ready;
 		}
 	}
+
+	return status;
 }
 
 void dp_set_fec_enable(struct dc_link *link, bool enable)
 {
-	struct link_encoder *link_enc = link->link_enc;
+	struct link_encoder *link_enc = NULL;
+
+	/* Access link encoder based on whether it is statically
+	 * or dynamically assigned to a link.
+	 */
+	if (link->is_dig_mapping_flexible &&
+			link->dc->res_pool->funcs->link_encs_assign)
+		link_enc = link_enc_cfg_get_link_enc_used_by_link(
+				link->dc->current_state, link);
+	else
+		link_enc = link->link_enc;
+	ASSERT(link_enc);
 
 	if (!dc_link_should_enable_fec(link))
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index ffc3f2c63db8..3581159e61af 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -88,8 +88,12 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
 bool dp_overwrite_extended_receiver_cap(struct dc_link *link);
 
 void dpcd_set_source_specific_data(struct dc_link *link);
+/* Write DPCD link configuration data. */
+enum dc_status dpcd_set_link_settings(
+	struct dc_link *link,
+	const struct link_training_settings *lt_settings);
 
-void dp_set_fec_ready(struct dc_link *link, bool ready);
+enum dc_status dp_set_fec_ready(struct dc_link *link, bool ready);
 void dp_set_fec_enable(struct dc_link *link, bool enable);
 bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable);
 bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable);
@@ -97,6 +101,13 @@ void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
 bool dp_update_dsc_config(struct pipe_ctx *pipe_ctx);
 bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable);
 
+/* Initialize output parameter lt_settings. */
+void dp_decide_training_settings(
+	struct dc_link *link,
+	const struct dc_link_settings *link_setting,
+	const struct dc_link_training_overrides *overrides,
+	struct link_training_settings *lt_settings);
+
 /* Convert PHY repeater count read from DPCD uint8_t. */
 uint8_t dp_convert_to_count(uint8_t lttpr_repeater_count);
 
@@ -105,5 +116,9 @@ enum link_training_result dp_check_link_loss_status(
 		struct dc_link *link,
 		const struct link_training_settings *link_training_setting);
 
+enum dc_status dpcd_configure_lttpr_mode(
+		struct dc_link *link,
+		struct link_training_settings *lt_settings);
+
 enum dp_link_encoding dp_get_link_encoding_format(const struct dc_link_settings *link_settings);
 #endif /* __DC_LINK_DP_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
