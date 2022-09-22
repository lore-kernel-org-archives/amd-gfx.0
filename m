Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F65C32771
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815BD10E9E9;
	Thu, 22 Sep 2022 00:18:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D6B910E01F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ots05PSoQnrJZ3DAMkrTWDJj7dltwBUIBPx5iAFCWEdq9I8q+hiABpSfn3QD2FtVQpE9m1v/hig/6K0OaI1yrqlUr70ksZFqnupSOb/sWNMbFIBj+YcbrivQRoJN1fF9WzW7RHD46m+JRXVlY964+0RQZnkPXE5rawzaXfeh9iN/ACJTSpycmOSr5DfA+p0eRrM0p6hCFQ8SeyZtVMDNw4gSw5lN1A2SmI6WyNCAQNbNF1/ICgNHwhEn0qf1iZ4jp3cFNNkXnybEL9oNpN/PnLvs2XXintPiZr0iK4NDbO1Eigi89ZiebeCultpaYPjjuE6Zn2+g/eJFs3OqHezDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03TX8oCUSnLa/ACRl5SBaw9PN31O1YsRzpm9LKuZF+U=;
 b=Rj5WzPZOuHv5KXIIUHUiOTcgp3SF1TLYyJLWCFyYpwVmLWUFWqPsZ4P/OMe7ScIhzHzZJ8LhpNu5iAtEu3oGqh2yjDEBmwRiAs3jFtu3+o/z+SyYSbFidNR5DsHyw1tTAGlxUdDxYahLiPpu7A9nmWZR/bzxC2omzIEhSBN7otxXz+8gxxq/pnfymk0OFwf/RR5l4cN8VKg5+8lMLq4JsEOo/j94PZ+GKVq0dK3AoECqMymgGK9xjVvvQbwdafLFnJsWo9103ZZAx7CpGAukbHWRnjntoyLxUYVIwY+0unWce+Ln3yp/H4CANwDlWqRkKfh+UykL2pvKhnfn50LSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03TX8oCUSnLa/ACRl5SBaw9PN31O1YsRzpm9LKuZF+U=;
 b=Xmufd7dNcjcGdAvBHGC58Ar8L6k+RWcjyIIa9NsRyrKKIxHSpNG6o817Z6xe4zxcFrB562IPajJHfahaNyE2OhlZ2Q8d/q/GP6JFK0fJIZv2+d+EWJ56GX5T8+c2JJj0gp5aY4fL6TUtfSnd8540z8E49W20GMGrKj0iXwhfXsw=
Received: from BN9PR03CA0210.namprd03.prod.outlook.com (2603:10b6:408:f9::35)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 00:18:41 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::47) by BN9PR03CA0210.outlook.office365.com
 (2603:10b6:408:f9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 00:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:18:41 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:18:39 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/31] drm/amd/display: Refactor LTTPR mode selection
Date: Wed, 21 Sep 2022 20:17:51 -0400
Message-ID: <20220922001821.320255-2-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfc85ab-9b12-4135-f4ec-08da9c3000f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: softT1T7EBM1LAwuesegb5DCcqXkonoSyAWKJgv11g6bmRPzExoysOep0owf/OZ0lin5moXzMH15gZY2q3WQXHMQK6qTJwz4hizuRUakeG7DWBy9YdH9q8OvCvUThkmKhpwJNKwDj8zn9pKIu/5pch+ZXv33cBv1W7oNl/dwexS3sjAmQZI7Yu79MQ0Dm3ccPR5fQKlY4odGxJHnlDDtOUeJPdyX3qoV9Wp+YxnlnhkfbqFTfTw7sjah6pi9rg1YhMUBnNZQy/hCzGOLKLC9qFOnDCWNmQyzTdepwpoobQQCPQyWZ+sLZqt8ZU69sBStDIgWxmocBwa90lBAN4K8uZLKUQvw080oTQS3OqsN5GpCw/u4R7XCi/+OeTLsdUFUQuBUSwo+vv1WE6M0ajhWarZf+wH8L3pHd39QqPED9zzb4+9yYHrtZvr1UGNw79S7zPNI4glBoulszodb/cnYsuiHCPo/4h3GVnQ+/FmYzO8lmQhyBThrxGIGP12l/JfLftaCQqq+Ds6YUHSQRo9P3zbktTZiVnLXA5pU9Xo09FxNWaN+EtOAXOVlm885G1PCxCDhj7wLYXiSL4cCN/hhGmG8v9Sly4Ym6OzxFl5u9bLMl/CJbvw3+Z7C8+yRJqkpzeYm3+4RL6JfieC5PN9WAfUEM+lWqG8/CKYoyXLvcgiafQqblzoTjBQGKGR6nFxS7HwXg4EHdQxl8s3jwe/CEdAkVKjdW4AnDqbaTXupYPUhO6Auv2E8/bpZyRSx85l0sztesGEmXZEzsEz29Yxop7lhbH/jjcjmonknbcWEp2FSCqkHp6G4XavDUPGoh8gl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(1076003)(186003)(16526019)(5660300002)(336012)(40460700003)(82310400005)(2616005)(316002)(30864003)(54906003)(6916009)(356005)(8936002)(26005)(40480700001)(36860700001)(4326008)(47076005)(2906002)(36756003)(82740400003)(8676002)(478600001)(83380400001)(426003)(70586007)(81166007)(6666004)(70206006)(41300700001)(36900700001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:18:41.4400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfc85ab-9b12-4135-f4ec-08da9c3000f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Previously, LTTPR mode was decided during detection which makes
link training inflexible as mode can't be dynamically changed.

[HOW]
-Remove lttpr_mode from link struct, and move to link training settings
-Defer choosing LTTPR mode until link training

Other DP changes included:
-Only use fixed vs/pe link training sequence for 8b/10b encoding
-Restrict fixed vs aux timeout workaround to Yellow Carp family

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  19 ++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 301 ++++++++++--------
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  34 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 -
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   5 +
 .../amd/display/include/link_service_types.h  |   1 +
 scripts/extract-cert                          | Bin 0 -> 18320 bytes
 7 files changed, 208 insertions(+), 153 deletions(-)
 create mode 100755 scripts/extract-cert

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index d01d2eeed813..3d01965b533a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -35,6 +35,8 @@
 #include "dc_link_ddc.h"
 #include "dce/dce_aux.h"
 #include "dmub/inc/dmub_cmd.h"
+#include "link_dpcd.h"
+#include "include/dal_asic_id.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -683,6 +685,22 @@ bool dc_link_aux_try_to_configure_timeout(struct ddc_service *ddc,
 	bool result = false;
 	struct ddc *ddc_pin = ddc->ddc_pin;
 
+	if ((ddc->link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+			!ddc->link->dc->debug.disable_fixed_vs_aux_timeout_wa &&
+			ASICREV_IS_YELLOW_CARP(ddc->ctx->asic_id.hw_internal_rev)) {
+		/* Fixed VS workaround for AUX timeout */
+		const uint32_t fixed_vs_address = 0xF004F;
+		const uint8_t fixed_vs_data[4] = {0x1, 0x22, 0x63, 0xc};
+
+		core_link_write_dpcd(
+				ddc->link,
+				fixed_vs_address,
+				fixed_vs_data,
+				sizeof(fixed_vs_data));
+
+		timeout = 3072;
+	}
+
 	/* Do not try to access nonexistent DDC pin. */
 	if (ddc->link->ep_type != DISPLAY_ENDPOINT_PHY)
 		return true;
@@ -691,6 +709,7 @@ bool dc_link_aux_try_to_configure_timeout(struct ddc_service *ddc,
 		ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout(ddc, timeout);
 		result = true;
 	}
+
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 7842df9f62de..b3a77a16dd0c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -526,9 +526,9 @@ uint8_t dc_dp_initialize_scrambling_data_symbols(
 	return disable_scrabled_data_symbols;
 }
 
-static inline bool is_repeater(struct dc_link *link, uint32_t offset)
+static inline bool is_repeater(const struct link_training_settings *lt_settings, uint32_t offset)
 {
-	return (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && (offset != 0);
+	return (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && (offset != 0);
 }
 
 static void dpcd_set_lt_pattern_and_lane_settings(
@@ -545,7 +545,7 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 	bool edp_workaround = false; /* TODO link_prop.INTERNAL */
 	dpcd_base_lt_offset = DP_TRAINING_PATTERN_SET;
 
-	if (is_repeater(link, offset))
+	if (is_repeater(lt_settings, offset))
 		dpcd_base_lt_offset = DP_TRAINING_PATTERN_SET_PHY_REPEATER1 +
 			((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
 
@@ -561,7 +561,7 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 	dpcd_lt_buffer[DP_TRAINING_PATTERN_SET - DP_TRAINING_PATTERN_SET]
 		= dpcd_pattern.raw;
 
-	if (is_repeater(link, offset)) {
+	if (is_repeater(lt_settings, offset)) {
 		DC_LOG_HW_LINK_TRAINING("%s\n LTTPR Repeater ID: %d\n 0x%X pattern = %x\n",
 			__func__,
 			offset,
@@ -584,7 +584,7 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 		lt_settings->dpcd_lane_settings,
 		size_in_bytes);
 
-	if (is_repeater(link, offset)) {
+	if (is_repeater(lt_settings, offset)) {
 		if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
 				DP_128b_132b_ENCODING)
 			DC_LOG_HW_LINK_TRAINING("%s:\n LTTPR Repeater ID: %d\n"
@@ -873,7 +873,7 @@ enum dc_status dp_get_lane_status_and_lane_adjust(
 	uint32_t lane;
 	enum dc_status status;
 
-	if (is_repeater(link, offset)) {
+	if (is_repeater(link_training_setting, offset)) {
 		lane01_status_address =
 				DP_LANE0_1_STATUS_PHY_REPEATER1 +
 				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
@@ -906,7 +906,7 @@ enum dc_status dp_get_lane_status_and_lane_adjust(
 
 	ln_align->raw = dpcd_buf[2];
 
-	if (is_repeater(link, offset)) {
+	if (is_repeater(link_training_setting, offset)) {
 		DC_LOG_HW_LINK_TRAINING("%s:\n LTTPR Repeater ID: %d\n"
 				" 0x%X Lane01Status = %x\n 0x%X Lane23Status = %x\n ",
 			__func__,
@@ -954,7 +954,7 @@ enum dc_status dpcd_set_lane_settings(
 
 	lane0_set_address = DP_TRAINING_LANE0_SET;
 
-	if (is_repeater(link, offset))
+	if (is_repeater(link_training_setting, offset))
 		lane0_set_address = DP_TRAINING_LANE0_SET_PHY_REPEATER1 +
 		((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
 
@@ -963,7 +963,7 @@ enum dc_status dpcd_set_lane_settings(
 		(uint8_t *)(link_training_setting->dpcd_lane_settings),
 		link_training_setting->link_settings.lane_count);
 
-	if (is_repeater(link, offset)) {
+	if (is_repeater(link_training_setting, offset)) {
 		if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
 				DP_128b_132b_ENCODING)
 			DC_LOG_HW_LINK_TRAINING("%s:\n LTTPR Repeater ID: %d\n"
@@ -1172,7 +1172,7 @@ static enum link_training_result perform_channel_equalization_sequence(
 	/* Note: also check that TPS4 is a supported feature*/
 	tr_pattern = lt_settings->pattern_for_eq;
 
-	if (is_repeater(link, offset) && dp_get_link_encoding_format(&lt_settings->link_settings) == DP_8b_10b_ENCODING)
+	if (is_repeater(lt_settings, offset) && dp_get_link_encoding_format(&lt_settings->link_settings) == DP_8b_10b_ENCODING)
 		tr_pattern = DP_TRAINING_PATTERN_SEQUENCE_4;
 
 	dp_set_hw_training_pattern(link, link_res, tr_pattern, offset);
@@ -1198,7 +1198,7 @@ static enum link_training_result perform_channel_equalization_sequence(
 		/* 3. wait for receiver to lock-on*/
 		wait_time_microsec = lt_settings->eq_pattern_time;
 
-		if (is_repeater(link, offset))
+		if (is_repeater(lt_settings, offset))
 			wait_time_microsec =
 					dp_translate_training_aux_read_interval(
 						link->dpcd_caps.lttpr_caps.aux_rd_interval[offset - 1]);
@@ -1469,7 +1469,6 @@ static inline void decide_8b_10b_training_settings(
 	 */
 	lt_settings->link_settings.link_spread = link->dp_ss_off ?
 			LINK_SPREAD_DISABLED : LINK_SPREAD_05_DOWNSPREAD_30KHZ;
-	lt_settings->lttpr_mode = link->lttpr_mode;
 	lt_settings->cr_pattern_time = get_cr_training_aux_rd_interval(link, link_setting);
 	lt_settings->eq_pattern_time = get_eq_training_aux_rd_interval(link, link_setting);
 	lt_settings->pattern_for_cr = decide_cr_training_pattern(link_setting);
@@ -1478,6 +1477,7 @@ static inline void decide_8b_10b_training_settings(
 	lt_settings->should_set_fec_ready = true;
 	lt_settings->disallow_per_lane_settings = true;
 	lt_settings->always_match_dpcd_with_hw_lane_settings = true;
+	lt_settings->lttpr_mode = dp_decide_8b_10b_lttpr_mode(link);
 	dp_hw_to_dpcd_lane_settings(lt_settings, lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 }
 
@@ -1501,9 +1501,8 @@ static inline void decide_128b_132b_training_settings(struct dc_link *link,
 	lt_settings->cds_pattern_time = 2500;
 	lt_settings->cds_wait_time_limit = (dp_convert_to_count(
 			link->dpcd_caps.lttpr_caps.phy_repeater_cnt) + 1) * 20000;
-	lt_settings->lttpr_mode = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) ?
-			LTTPR_MODE_NON_TRANSPARENT : LTTPR_MODE_TRANSPARENT;
 	lt_settings->disallow_per_lane_settings = true;
+	lt_settings->lttpr_mode = dp_decide_128b_132b_lttpr_mode(link);
 	dp_hw_to_dpcd_lane_settings(lt_settings,
 			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 }
@@ -1543,7 +1542,7 @@ static void override_training_settings(
 		lt_settings->ffe_preset = overrides->ffe_preset;
 	/* Override HW lane settings with BIOS forced values if present */
 	if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN &&
-			link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+			lt_settings->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
 		lt_settings->voltage_swing = &link->bios_forced_drive_settings.VOLTAGE_SWING;
 		lt_settings->pre_emphasis = &link->bios_forced_drive_settings.PRE_EMPHASIS;
 		lt_settings->always_match_dpcd_with_hw_lane_settings = false;
@@ -1584,6 +1583,15 @@ static void override_training_settings(
 
 	if (link->preferred_training_settings.fec_enable != NULL)
 		lt_settings->should_set_fec_ready = *link->preferred_training_settings.fec_enable;
+	
+	#if defined(CONFIG_DRM_AMD_DC_DCN)
+	/* Check DP tunnel LTTPR mode debug option. */
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && link->dc->debug.dpia_debug.bits.force_non_lttpr)
+		lt_settings->lttpr_mode = LTTPR_MODE_NON_LTTPR;
+
+#endif
+	dp_get_lttpr_mode_override(link, &lt_settings->lttpr_mode);
+
 }
 
 uint8_t dp_convert_to_count(uint8_t lttpr_repeater_count)
@@ -1649,7 +1657,7 @@ static enum dc_status configure_lttpr_mode_non_transparent(
 		link->dpcd_caps.lttpr_caps.mode = repeater_mode;
 	}
 
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
+	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
 
 		DC_LOG_HW_LINK_TRAINING("%s\n Set LTTPR to Non Transparent Mode\n", __func__);
 
@@ -2099,7 +2107,7 @@ static enum link_training_result dp_perform_8b_10b_link_training(
 	/* 1. set link rate, lane count and spread. */
 	dpcd_set_link_settings(link, lt_settings);
 
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
+	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
 
 		/* 2. perform link training (set link training done
 		 *  to false is done as well)
@@ -2216,7 +2224,7 @@ static enum link_training_result perform_fixed_vs_pe_nontransparent_training_seq
 
 	link->vendor_specific_lttpr_link_rate_wa = target_rate;
 
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
+	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
 
 		/* 2. perform link training (set link training done
 		 *  to false is done as well)
@@ -2288,7 +2296,7 @@ static enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	ASSERT(dp_get_link_encoding_format(&lt_settings->link_settings) ==
 			DP_8b_10b_ENCODING);
 
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
+	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
 		status = perform_fixed_vs_pe_nontransparent_training_sequence(link, link_res, lt_settings);
 		return status;
 	}
@@ -2635,6 +2643,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 			link,
 			link_settings,
 			&lt_settings);
+
 	override_training_settings(
 			link,
 			&link->preferred_training_settings,
@@ -2652,7 +2661,7 @@ enum link_training_result dc_link_dp_perform_link_training(
 	 * Per DP specs starting from here, DPTX device shall not issue
 	 * Non-LT AUX transactions inside training mode.
 	 */
-	if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN)
+	if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN && encoding == DP_8b_10b_ENCODING)
 		status = dp_perform_fixed_vs_pe_training_sequence(link, link_res, &lt_settings);
 	else if (encoding == DP_8b_10b_ENCODING)
 		status = dp_perform_8b_10b_link_training(link, link_res, &lt_settings);
@@ -3086,7 +3095,7 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	 * account for lttpr repeaters cap
 	 * notes: repeaters do not snoop in the DPRX Capabilities addresses (3.6.3).
 	 */
-	if (link->lttpr_mode != LTTPR_MODE_NON_LTTPR) {
+	if (dp_is_lttpr_present(link)) {
 		if (link->dpcd_caps.lttpr_caps.max_lane_count < max_link_cap.lane_count)
 			max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
 		lttpr_max_link_rate = get_lttpr_max_link_rate(link);
@@ -3240,7 +3249,7 @@ static bool dp_verify_link_cap(
 	cur_link_settings = max_link_settings;
 
 	/* Grant extended timeout request */
-	if ((link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && (link->dpcd_caps.lttpr_caps.max_ext_timeout > 0)) {
+	if (dp_is_lttpr_present(link) && link->dpcd_caps.lttpr_caps.max_ext_timeout > 0) {
 		uint8_t grant = link->dpcd_caps.lttpr_caps.max_ext_timeout & 0x80;
 
 		core_link_write_dpcd(link, DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT, &grant, sizeof(grant));
@@ -4101,8 +4110,13 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 			&dpcd_lane_adjustment[0].raw,
 			sizeof(dpcd_lane_adjustment));
 
+	/* prepare link training settings */
+	link_training_settings.link_settings = link->cur_link_settings;
+
+	link_training_settings.lttpr_mode = dp_decide_lttpr_mode(link, &link->cur_link_settings);
+
 	if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-			link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
+			link_training_settings.lttpr_mode == LTTPR_MODE_TRANSPARENT)
 		dp_fixed_vs_pe_read_lane_adjust(
 				link,
 				link_training_settings.dpcd_lane_settings);
@@ -4209,9 +4223,6 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 				test_pattern_size);
 	}
 
-	/* prepare link training settings */
-	link_training_settings.link_settings = link->cur_link_settings;
-
 	for (lane = 0; lane <
 		(unsigned int)(link->cur_link_settings.lane_count);
 		lane++) {
@@ -5021,133 +5032,136 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 	return true;
 }
 
-/* Logic to determine LTTPR mode */
-static void determine_lttpr_mode(struct dc_link *link)
+bool dp_retrieve_lttpr_cap(struct dc_link *link)
 {
-	bool allow_lttpr_non_transparent_mode = 0;
-	bool vbios_lttpr_enable = link->dc->caps.vbios_lttpr_enable;
+	uint8_t lttpr_dpcd_data[8];
+	enum dc_status status = DC_ERROR_UNEXPECTED;
+	bool is_lttpr_present = false;
+
+	/* Logic to determine LTTPR support*/
 	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
 
-	if (link->ctx->dc->debug.lttpr_mode_override != 0) {
-		link->lttpr_mode = link->ctx->dc->debug.lttpr_mode_override;
-		return;
-	}
+	if (!vbios_lttpr_interop || !link->dc->caps.extended_aux_timeout_support)
+		return false;
 
-	if ((link->dc->config.allow_lttpr_non_transparent_mode.bits.DP2_0 &&
-			link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)) {
-		allow_lttpr_non_transparent_mode = 1;
-	} else if (link->dc->config.allow_lttpr_non_transparent_mode.bits.DP1_4A &&
-			!link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
-		allow_lttpr_non_transparent_mode = 1;
+	/* By reading LTTPR capability, RX assumes that we will enable
+	 * LTTPR extended aux timeout if LTTPR is present.
+	 */
+	status = core_link_read_dpcd(
+			link,
+			DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
+			lttpr_dpcd_data,
+			sizeof(lttpr_dpcd_data));
+
+	link->dpcd_caps.lttpr_caps.revision.raw =
+			lttpr_dpcd_data[DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.max_link_rate =
+			lttpr_dpcd_data[DP_MAX_LINK_RATE_PHY_REPEATER -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.phy_repeater_cnt =
+			lttpr_dpcd_data[DP_PHY_REPEATER_CNT -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.max_lane_count =
+			lttpr_dpcd_data[DP_MAX_LANE_COUNT_PHY_REPEATER -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.mode =
+			lttpr_dpcd_data[DP_PHY_REPEATER_MODE -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.max_ext_timeout =
+			lttpr_dpcd_data[DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+	link->dpcd_caps.lttpr_caps.main_link_channel_coding.raw =
+			lttpr_dpcd_data[DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.raw =
+			lttpr_dpcd_data[DP_PHY_REPEATER_128B132B_RATES -
+							DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+
+	/* If this chip cap is set, at least one retimer must exist in the chain
+	 * Override count to 1 if we receive a known bad count (0 or an invalid value) */
+	if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN &&
+			(dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == 0)) {
+		ASSERT(0);
+		link->dpcd_caps.lttpr_caps.phy_repeater_cnt = 0x80;
 	}
 
-	link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
-	if (vbios_lttpr_enable && vbios_lttpr_interop)
-		link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
-	else if (!vbios_lttpr_enable && vbios_lttpr_interop) {
-		if (allow_lttpr_non_transparent_mode)
-			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
-		else
-			link->lttpr_mode = LTTPR_MODE_TRANSPARENT;
-	} else if (!vbios_lttpr_enable && !vbios_lttpr_interop) {
-		if (!allow_lttpr_non_transparent_mode || !link->dc->caps.extended_aux_timeout_support)
-			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
-		else
-			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
-	}
+	/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
+	is_lttpr_present = dp_is_lttpr_present(link);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	/* Check DP tunnel LTTPR mode debug option. */
-	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
-	    link->dc->debug.dpia_debug.bits.force_non_lttpr)
-		link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
-#endif
+	if (is_lttpr_present)
+		CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
+
+	return is_lttpr_present;
 }
 
-bool dp_retrieve_lttpr_cap(struct dc_link *link)
+bool dp_is_lttpr_present(struct dc_link *link)
 {
-	uint8_t lttpr_dpcd_data[8];
-	enum dc_status status = DC_ERROR_UNEXPECTED;
-	bool is_lttpr_present = false;
+	return (dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) != 0 &&
+			link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
+			link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
+			link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
+}
 
-	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
+enum lttpr_mode dp_decide_lttpr_mode(struct dc_link *link, struct dc_link_settings *link_setting)
+{
+	enum dp_link_encoding encoding = dp_get_link_encoding_format(link_setting);
 
-	/* Logic to determine LTTPR mode*/
-	determine_lttpr_mode(link);
+	if (encoding == DP_8b_10b_ENCODING)
+		return dp_decide_8b_10b_lttpr_mode(link);
+	else if (encoding == DP_128b_132b_ENCODING)
+		return dp_decide_128b_132b_lttpr_mode(link);
 
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT || link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
-		if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-				!link->dc->debug.disable_fixed_vs_aux_timeout_wa) {
-			/* Fixed VS workaround for AUX timeout */
-			const uint32_t fixed_vs_address = 0xF004F;
-			const uint8_t fixed_vs_data[4] = {0x1, 0x22, 0x63, 0xc};
+	ASSERT(0);
+	return LTTPR_MODE_NON_LTTPR;
+}
 
-			core_link_write_dpcd(
-					link,
-					fixed_vs_address,
-					fixed_vs_data,
-					sizeof(fixed_vs_data));
-		}
+void dp_get_lttpr_mode_override(struct dc_link *link, enum lttpr_mode *override)
+{
+	if (!dp_is_lttpr_present(link))
+		return;
 
-		/* By reading LTTPR capability, RX assumes that we will enable
-		 * LTTPR extended aux timeout if LTTPR is present.
-		 */
-		status = core_link_read_dpcd(
-				link,
-				DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
-				lttpr_dpcd_data,
-				sizeof(lttpr_dpcd_data));
-
-		link->dpcd_caps.lttpr_caps.revision.raw =
-				lttpr_dpcd_data[DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.max_link_rate =
-				lttpr_dpcd_data[DP_MAX_LINK_RATE_PHY_REPEATER -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.phy_repeater_cnt =
-				lttpr_dpcd_data[DP_PHY_REPEATER_CNT -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.max_lane_count =
-				lttpr_dpcd_data[DP_MAX_LANE_COUNT_PHY_REPEATER -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.mode =
-				lttpr_dpcd_data[DP_PHY_REPEATER_MODE -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.max_ext_timeout =
-				lttpr_dpcd_data[DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-		link->dpcd_caps.lttpr_caps.main_link_channel_coding.raw =
-				lttpr_dpcd_data[DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.raw =
-				lttpr_dpcd_data[DP_PHY_REPEATER_128B132B_RATES -
-								DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
-
-		/* If this chip cap is set, at least one retimer must exist in the chain
-		 * Override count to 1 if we receive a known bad count (0 or an invalid value) */
-		if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN &&
-				(dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == 0)) {
-			ASSERT(0);
-			link->dpcd_caps.lttpr_caps.phy_repeater_cnt = 0x80;
-		}
+	if (link->dc->debug.lttpr_mode_override == LTTPR_MODE_TRANSPARENT) {
+		*override = LTTPR_MODE_TRANSPARENT;
+	} else if (link->dc->debug.lttpr_mode_override == LTTPR_MODE_NON_TRANSPARENT) {
+		*override = LTTPR_MODE_NON_TRANSPARENT;
+	} else if (link->dc->debug.lttpr_mode_override == LTTPR_MODE_NON_LTTPR) {
+		*override = LTTPR_MODE_NON_LTTPR;
+	}
+}
 
-		/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
-		is_lttpr_present = (link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
-				link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
-				link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
-		if (is_lttpr_present) {
-			CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
-			configure_lttpr_mode_transparent(link);
-		} else
-			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
+enum lttpr_mode dp_decide_8b_10b_lttpr_mode(struct dc_link *link)
+{
+	bool is_lttpr_present = dp_is_lttpr_present(link);
+	bool vbios_lttpr_force_non_transparent = link->dc->caps.vbios_lttpr_enable;
+	bool vbios_lttpr_aware = link->dc->caps.vbios_lttpr_aware;
+
+	if (!is_lttpr_present)
+		return LTTPR_MODE_NON_LTTPR;
+
+	if (vbios_lttpr_aware) {
+		if (vbios_lttpr_force_non_transparent)
+			return LTTPR_MODE_NON_TRANSPARENT;
+		else
+			return LTTPR_MODE_TRANSPARENT;
 	}
-	return is_lttpr_present;
+
+	if (link->dc->config.allow_lttpr_non_transparent_mode.bits.DP1_4A &&
+			link->dc->caps.extended_aux_timeout_support)
+		return LTTPR_MODE_NON_TRANSPARENT;
+
+	return LTTPR_MODE_NON_LTTPR;
+}
+
+enum lttpr_mode dp_decide_128b_132b_lttpr_mode(struct dc_link *link)
+{
+	return dp_is_lttpr_present(link) ? LTTPR_MODE_NON_TRANSPARENT : LTTPR_MODE_NON_LTTPR;
 }
 
 static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
@@ -5209,13 +5223,16 @@ static enum dc_status wa_try_to_wake_dprx(struct dc_link *link, uint64_t timeout
 	uint64_t current_ts = 0;
 	uint64_t time_taken_ms = 0;
 	enum dc_connection_type type = dc_connection_none;
+	bool lttpr_present;
+	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
 
-	determine_lttpr_mode(link);
+	lttpr_present = dp_is_lttpr_present(link) ||
+			(!vbios_lttpr_interop || !link->dc->caps.extended_aux_timeout_support);
 
 	/* Issue an AUX read to test DPRX responsiveness. If LTTPR is supported the first read is expected to
 	 * be to determine LTTPR capabilities. Otherwise trying to read power state should be an innocuous AUX read.
 	 */
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT || link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
+	if (lttpr_present)
 		status = core_link_read_dpcd(
 				link,
 				DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
@@ -5345,6 +5362,10 @@ static bool retrieve_link_cap(struct dc_link *link)
 	}
 
 	is_lttpr_present = dp_retrieve_lttpr_cap(link);
+
+	if (is_lttpr_present)
+		configure_lttpr_mode_transparent(link);
+
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
 
@@ -6096,7 +6117,7 @@ bool dc_link_dp_set_test_pattern(
 		/* Set DPCD Lane Settings before running test pattern */
 		if (p_link_settings != NULL) {
 			if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-					link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+					p_link_settings->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
 				dp_fixed_vs_pe_set_retimer_lane_settings(
 						link,
 						p_link_settings->dpcd_lane_settings,
@@ -7218,7 +7239,7 @@ void dp_set_hw_lane_settings(
 {
 	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
 
-	if ((link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && !is_immediate_downstream(link, offset))
+	if ((link_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && !is_immediate_downstream(link, offset))
 		return;
 
 	if (link_hwss->ext.set_dp_lane_settings)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 468e39589ed8..ab2d0a33dea9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -115,12 +115,14 @@ static enum link_training_result dpia_configure_link(
 	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) configuring\n - LTTPR mode(%d)\n",
 				__func__,
 				link->link_id.enum_id - ENUM_ID_1,
-				link->lttpr_mode);
+				lt_settings->lttpr_mode);
 
 	dp_decide_training_settings(link,
 		link_setting,
 		lt_settings);
 
+	dp_get_lttpr_mode_override(link, &lt_settings->lttpr_mode);
+
 	status = dpcd_configure_channel_coding(link, lt_settings);
 	if (status != DC_OK && link->is_hpd_pending)
 		return LINK_TRAINING_ABORT;
@@ -178,7 +180,7 @@ static uint8_t dpia_build_set_config_data(enum dpia_set_config_type type,
 
 	switch (type) {
 	case DPIA_SET_CFG_SET_LINK:
-		data.set_link.mode = link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT ? 1 : 0;
+		data.set_link.mode = lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT ? 1 : 0;
 		break;
 	case DPIA_SET_CFG_SET_PHY_TEST_MODE:
 		break;
@@ -553,7 +555,7 @@ static enum link_training_result dpia_training_cr_phase(
 {
 	enum link_training_result result = LINK_TRAINING_CR_FAIL_LANE0;
 
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
+	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
 		result = dpia_training_cr_non_transparent(link, link_res, lt_settings, hop);
 	else
 		result = dpia_training_cr_transparent(link, link_res, lt_settings);
@@ -830,7 +832,7 @@ static enum link_training_result dpia_training_eq_phase(
 {
 	enum link_training_result result;
 
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
+	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
 		result = dpia_training_eq_non_transparent(link, link_res, lt_settings, hop);
 	else
 		result = dpia_training_eq_transparent(link, link_res, lt_settings);
@@ -870,13 +872,14 @@ static enum dc_status dpcd_clear_lt_pattern(struct dc_link *link, uint32_t hop)
  * @param hop The Hop in display path. DPRX = 0.
  */
 static enum link_training_result dpia_training_end(struct dc_link *link,
+		struct link_training_settings *lt_settings,
 		uint32_t hop)
 {
 	enum link_training_result result = LINK_TRAINING_SUCCESS;
 	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
 	enum dc_status status;
 
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
+	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
 		repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 
 		if (hop == repeater_cnt) { /* DPTX-to-DPIA */
@@ -916,7 +919,7 @@ static enum link_training_result dpia_training_end(struct dc_link *link,
 				link->link_id.enum_id - ENUM_ID_1,
 				hop,
 				result,
-				link->lttpr_mode);
+				lt_settings->lttpr_mode);
 
 	return result;
 }
@@ -928,7 +931,10 @@ static enum link_training_result dpia_training_end(struct dc_link *link,
  * @param link DPIA link being trained.
  * @param hop The Hop in display path. DPRX = 0.
  */
-static void dpia_training_abort(struct dc_link *link, uint32_t hop)
+static void dpia_training_abort(
+	struct dc_link *link,
+	struct link_training_settings *lt_settings, 
+	uint32_t hop)
 {
 	uint8_t data = 0;
 	uint32_t dpcd_tps_offset = DP_TRAINING_PATTERN_SET;
@@ -936,7 +942,7 @@ static void dpia_training_abort(struct dc_link *link, uint32_t hop)
 	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) aborting\n - LTTPR mode(%d)\n - HPD(%d)\n",
 				__func__,
 				link->link_id.enum_id - ENUM_ID_1,
-				link->lttpr_mode,
+				lt_settings->lttpr_mode,
 				link->is_hpd_pending);
 
 	/* Abandon clean-up if sink unplugged. */
@@ -964,12 +970,16 @@ enum link_training_result dc_link_dpia_perform_link_training(
 	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
 	int8_t repeater_id; /* Current hop. */
 
+	struct dc_link_settings link_settings = *link_setting; // non-const copy to pass in
+
+	lt_settings.lttpr_mode = dp_decide_lttpr_mode(link, &link_settings);
+
 	/* Configure link as prescribed in link_setting and set LTTPR mode. */
 	result = dpia_configure_link(link, link_res, link_setting, &lt_settings);
 	if (result != LINK_TRAINING_SUCCESS)
 		return result;
 
-	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
+	if (lt_settings.lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
 		repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 
 	/* Train each hop in turn starting with the one closest to DPTX.
@@ -987,7 +997,7 @@ enum link_training_result dc_link_dpia_perform_link_training(
 			break;
 
 		/* Stop training hop. */
-		result = dpia_training_end(link, repeater_id);
+		result = dpia_training_end(link, &lt_settings, repeater_id);
 		if (result != LINK_TRAINING_SUCCESS)
 			break;
 	}
@@ -1001,9 +1011,9 @@ enum link_training_result dc_link_dpia_perform_link_training(
 		msleep(5);
 		result = dp_check_link_loss_status(link, &lt_settings);
 	} else if (result == LINK_TRAINING_ABORT) {
-		dpia_training_abort(link, repeater_id);
+		dpia_training_abort(link, &lt_settings, repeater_id);
 	} else {
-		dpia_training_end(link, repeater_id);
+		dpia_training_end(link, &lt_settings, repeater_id);
 	}
 	return result;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index d890a03910c7..6e49ec262487 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -151,7 +151,6 @@ struct dc_link {
 	bool link_state_valid;
 	bool aux_access_disabled;
 	bool sync_lt_in_progress;
-	enum lttpr_mode lttpr_mode;
 	bool is_internal_display;
 
 	/* TODO: Rename. Flag an endpoint as having a programmable mapping to a
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index b44c7b43f7db..99c2ce2e7b9e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -194,6 +194,11 @@ enum dc_status dpcd_configure_lttpr_mode(
 
 enum dp_link_encoding dp_get_link_encoding_format(const struct dc_link_settings *link_settings);
 bool dp_retrieve_lttpr_cap(struct dc_link *link);
+bool dp_is_lttpr_present(struct dc_link *link);
+enum lttpr_mode dp_decide_lttpr_mode(struct dc_link *link, struct dc_link_settings *link_setting);
+void dp_get_lttpr_mode_override(struct dc_link *link, enum lttpr_mode *override);
+enum lttpr_mode dp_decide_8b_10b_lttpr_mode(struct dc_link *link);
+enum lttpr_mode dp_decide_128b_132b_lttpr_mode(struct dc_link *link);
 bool dpcd_write_128b_132b_sst_payload_allocation_table(
 		const struct dc_stream_state *stream,
 		struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 79fabc51c991..120f6bf409c0 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -83,6 +83,7 @@ enum link_training_result {
 };
 
 enum lttpr_mode {
+	LTTPR_MODE_UNKNOWN,
 	LTTPR_MODE_NON_LTTPR,
 	LTTPR_MODE_TRANSPARENT,
 	LTTPR_MODE_NON_TRANSPARENT,
diff --git a/scripts/extract-cert b/scripts/extract-cert
new file mode 100755
index 0000000000000000000000000000000000000000..2d399cf2845e298627bc07190ae3db5347769ae4
GIT binary patch
literal 18320
zcmV;BM{l@)MNCEl0RaF2000000000306qW#0000m7XSbN0000$000000002cKL7v#
z000000000$05|{*06+jA03HAa000040000$000000000$000000000$000000002k
z0ssI20002k0ssI2000080000000003000040000O0{{R30000O0{{R30000O0{{R3
z0000S000000000S00000000010000000001000040000000000000000000000000
z000000002+3;+NC0002+3;+NC000005C8xG0000100005000005C8xG000005C8xG
z000005C8xG0002x3IG5A0002x3IG5A000005C8xG000010000400000AOHXW00000
zAOHXW00000AOHXW000000{{R3000000{{R3000005C8xG00001000060002sEC2ui
z0002sJOBUy0002sJOBUy0000m0{{R30001R0{{R3000005C8xG00002000060002+
zEC2ui0002+JOBUy0002+JOBUy000000ssI2000000ssI200008000000000400004
z0000u0{{R30000u0{{R30000u0{{R30000W000000000W00000000080000000004
z00004000130{{R3000130{{R3000130{{R30000)000000000)000000000400000
z0000}<#c2O0000u0{{R30000u0{{R30000u0{{R30000W000000000W0000000008
z000000000`<#c2O0002^AOHXW0002^AOHXW0002^AOHXW00017000000001700000
z00004000000000{<#c2Q000000000000000000000000000000000000000000000
z000000000G000000000|<#c2O0002sEC2ui0002sJOBUy0002sJOBUy0000W0{{R3
z0000W0{{R300001000000000lY-wUPG%svqEo^CSb$Bg!I5sUdG%j;*E;0ZB00004
z0000G000050000-PE`N`006)Q0000300000000040000K000030000-PE`PK$d{!$
zaal<F#dc2J(cH(g<c$Ud0000G000010000-PE`N^0000300002000000000000002
z0000V0000100006000000f7Jj0006X0000W0002dWzKCm@{1e*000000000000000
z00000000000001}0RR9J000000000000000000000000I0000W000000000000000
z000000001m0RR9J000000000000000000000000h0RR9J00000000000000000000
z0001r0RR9J000000000000000000000002t0RR9J000000000000000000000001M
z0RR9J000000000000000000000000x0RR9J000000000000000000000000X0000W
z000000000000000000000002D0000I000000000000000000000000z0000W00000
z0000000000000000000P0RR9J000000000000000000000001t0000I0000000000
z00000000000001?0RR9J000000000000000000000002T0RR9J000000000000000
z000000000^0RR9J000000000000000000000002J0RR9J00000000000000000000
z000120000I000000000000000000000001}0000I000000000000000000000001x
z0RR9J000000000000000000000001A0RR9J000000000000000000000001M0000I
z000000000000000000000002Q0000I000000000000000000000002C0RR9J00000
z0000000000000000000C0RR9J000000000000000000000002`0000I0000000000
z00000000000002m0000I000000000000000000000002-0000I000000000000000
z000000002X0RR9J000000000000000000000001Z0000I00000000000000000000
z0002e0RR9Z000000000000000000000002Q0RR9I02%-wKmY&$000080000000000
zY-wU+a(QrcZ!U9hE-@}K0AF8cZEtR0b97;HbYEWpUrAI=Uu0!+WoKz~bY*f>O+##N
zZe>(qVr*pqUrAI=Uvgz<X>)XCa#T%2Y;SI5RAFLlWdKD|QeSXoWout-VRLj}WpZ+F
zasX*EWM5b{FgaghX>R~eP(@BtQ%qlJZfSI1V{&<LbZ-DfPDe>jMPF=hVPs!ob!lvL
zX>MO-Zf9w3Wpe;UQc_=VWo2t$WpZ+FasWa}PhW0jcVA{{Y-IpgH843}XJvF>b9G{B
zWn*+-ZeeX@07XtmNlryyV{~$CUt?`#UvqSFX>Ml#LP<|wW^!d^08m9uUvgz(WM5)w
zZ(mq7FgXB4PDe>jMPFihUuk3jST!&?Urs?yMPF}jWo&6~WdKD|QeR_iWnpq(WpZ+F
zasWkAQeS6fbYEq1a&K~9Y-w&~07X(#UuAM~Z*pIAbaH8KX8=V`M@ddaUukY>bO1$8
zM@ddaUt@G~Y+qw-WB_bwVq-3IZ!R_fWq4_H0A_D+Wo`gpUvqR}V{2byXlq|)VQFjt
zb98caZ)^ZxUuJM}X>N38Ut?%%0A^!sZ*ye;XJvF{Zgv23bYx|6asXy`a%psB0AF8Y
zcwt{=X>MU`X?kS<Uter#Vq;%(bYXIIUu|J&ZU9eEMNU&wOkXiyF<&qMM@&gVLtip3
zGyq3TNkT(kGA=SMH2_CUNkT(kGA=VNGynhq00IC200RI700RI600aO80000400004
z00aO700RI700RI700aO900aO800aO700aO800aO800RI700RI600001009620000G
z0000W0000GA8iHz00aQ@0RR910000100RJf0RR9H000000000KX=x1r00jU60ssII
z0001W8fggt00RIE0ssII0001V8EFXs00ICP0ssI20002sJOBUy00008000000000G
z7ytkO0002!JOBUy00008000000002c7XSbN00008KmY&$000080000000008KmY&$
z0002kKL7v#000060000200000000000002sKL7v#000060000600000000000002!
zKL7v#000060000900000000000002+KL7v#000060000B00000000000002^KL7v#
z000060000V00000000000000WKmY&$000050000W000000000000008KL7v#00007
z0000100000000000000GKL7v#000070000300000000000000OKL7v#0000700004
z00000000000000WKL7v#000070000500000000000000eKL7v#000070000700000
z000000000mKL7v#000070000800000000000000uKL7v#000070000A0000000000
z0000$KL7v#000070000C00000000000000;KL7v#000070000D00000000000000`
zKL7v#000070000E000000000000013KL7v#000070000F00000000000001BKL7v#
z000070000G00000000000001JKL7v#000070000H00000000000001RKL7v#00007
z0000I00000000000001ZKL7v#000070000J00000000000001hKL7v#000070000K
z00000000000001pKL7v#000070000L00000000000001xKL7v#000070000M00000
z000000001(KL7v#000070000N00000000000001>KL7v#000070000O0000000000
z0001}KL7v#000070000P000000000000026KL7v#000070000Q00000000000002E
zKL7v#000070000R00000000000002MKL7v#000070000S00000000000002UKL7v#
z000070000T00000000000002cKL7v#000070000U0000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000002<4<7nR
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
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000100IC(bRcbEX>KlKIwfQ}
z3IHu2Q&UVJC389;C389@WC{RxVgMy`07ZCoa$#e1Wn>^@WpZ>nASH7O05AYcLRCpj
zL|;}#QbJEtMF2}eRY^=lUsFj(PG3+-P5^LgV{<VvIskBMV{<Vv08DRTWFSyWLsKI$
zF(5@wM@dda07XtmNlryyX>MtB08?djAW%y~QzJ1kAW%t808CFoL|;QiQdD0<R8mX;
zM`d&%SS~d%IUr_oZ*3q@OG8s5F);vgVgLYDb75y?Iv{gna%pgMb1!9hbaG*1bS-0L
za&#a(b8mHWV`V-dJY;2abUq3I000018v{FB0000A0000e@Bjah0002k@c;j~0002!
z@c;kN0001p^8f#I0RR9v_W%EQ0000e_y7Os0001Z_y7MC0RR9v`2YV%0RRAK`Tzf@
z0RRBl`Tzg$0RR910000K0000000001dQt!Zcn|>_3<n610RR9L0000S0002E_5c4b
z00000L<bN60000a0000q0001x?*IR=0RR914iH8T7)lQdcL;z0KN>nJGbADa0000K
z000170000O@c;i100000000000000K0001V0000G@c;jy0RR91000000000e0001t
z0000u_W%D(00000K@Jdx0znQKg9AhkKz<4i7(osYK@JE(3jhEx0002E00017_W%F2
z00000LJkm&0#6PYh66zkAcF))4zK|Nk_rwWK@J!}4iG{P2tf-d0002&0002!_W%DX
z0RR91LJkm&0znQKh673t@Bspi3Jw@S4iG{P2tx}n0000O0RR9D@&Es?0{{R3Mh*~+
z0znQKh66|rAcF)+4nPB|0SXQvLk<{04iG{P2tf-(0000?0RRBF_y7N800000Mh*~<
z0!a=SjsrywAdLh?4k(NTL=G^921pJ#g9k?rKyD5=K@KoM4k$tnAVLlpLJkl@4hR4c
z0001#0RRBt_y7L|00000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z0000G7ytkO0002c7XSbN0000100000000010000000001000000001c0RR910000C
z00000000005C8xG0000D000000002k8UO$Q0000P000000002sJOBUy0000R00000
z00008000000000Q000000002!JOBUy0000S0000000008000000002>{{L?P0001>
z0{{R300005000000002s1^@s600006000000002U0{{R30000A000000000Z0ssI2
z0000B000000000O000000000L00000000000000000003000000002+J^%m!00002
z000000001R0ssI20000K0000000007000000000N000000001h3IG5A0000700000
z0001}2><{900008000000002k0000000009000000000O000000000U0000000008
z000000002{|Nn0Q00001000O80002~|Nn0Q0000;2><{900030|Nn0Q0000200000
z0002+|Nn0Q000042><{90002_|Nn0Q00003000000000000000000000000000000
z00000000000000000000000000000000000000000000000000000000000000000
z00000000000002+JOBUy000000000000000000000000m5C8xG0000$5C8xG0000`
z5C8xG0001B5C8xG0001R5C8xG0001h5C8xG0001x5C8xG0001>5C8xG000265C8xG
z0002M5C8xG0002c5C8xG0002s5C8xG0002+5C8xG000005dZ)H0000G5dZ)H0000W
z5dZ)H0000m5dZ)H0000$5dZ)H0000`5dZ)H0001B5dZ)H0001R5dZ)H0001h5dZ)H
z0001x5dZ)H0001>5dZ)H000265dZ)H0002M5dZ)H0000000000000000000000000
z0000000000000000000000000000000000000008KmY&$0000-Lqj?sC{<#0Zgh1Z
zIW9CVFfB24Vs&nGbuoT2FfK4OE-@(}IW9CVFaQ7m0000000000000000000000000
z0000000000000030096P0{{R30000000000000000000300ICw0{{R30000000000
z000000000300RJ60{{R30000000000000000000300aPh0{{R3000000000000000
z0000300jV`0{{R30000000000000000000300sca0{{R300000000000000000003
z00#iz1^@s60000000000000000000300;mC2><{90000000000000000000300{s{
z2><{900000000000000000003015!82><{90000000000000000000301E(s3IG5A
z0000000000000000000301N;C5C8xG0000000000000000000301W^j5C8xG00000
z00000000000000301g1q5dZ)H0000000000000000000301p7*5dZ)H0000000000
z000000000301yCx6951J0000000000000000000301*J#8UO$Q000000000000000
z0000301^NIAOHXW00000000000000000003022WCAOHXW00000000000000000003
z02BaNApigX0000000000000000000302Kh>JOBUy0000000000000000000302Tn~
zJOBUy0000000000000000000302cu8JOBUy0000000000000000000302l!9J^%m!
z0000000000000000000302u%PKmY&$0000000000000000000302%-wKmY&$00000
z00000000000000302=@R00000000000000000001000040P+6-000000000000000
z0000G0000201yBm7ytkO0000?000000000i0000201yCh7ytkO0002B000000000=
z0000201yB$82|tP0000g0RR91000100000102%;5KmY&$00008000000001300001
z02%-=KmY&$00004000000001I0000102%-|KmY&$00008000000001R0000102%;D
zKmY&$00008000000001a000040P+6-0000000000000000001l0000201yCR7XSbN
z00000000000001n0000201yC>7XSbN00000000000001)0000201yDs7XSbN00000
z00000000250000102%-&KmY&$00001000000002K0000102Tn~JOBUy0000000000
z0002x0000201yBW7ytkO00000000000002-0000102Kh>JOBUy00000000000001a
z000040P+6-0000000000000000000G0RR9202BcHA^-pY00000000000000000004
z0P+6-0000000000000000000U0RR91022WCAOHXW00000000000000n0RR9202l!9
zJ^%m!00000000000000-0RR9102Kh}JOBUy0000000000000130RR9102Kh>JOBUy
z00000000000001M0RR9202cu8JOBUy00000000000001A0{{R501N;C5C8xG00000
z000000002B0ssIY02u%PKmY&$00000000000001V0RR9J01yDs8UO$Q0000500000
z0002F0ssIK01yB$7XSbN0000l000000001l0RR9J000000000000000000000001=
z0RR9X00000000000000000000000240RR9J000000000000000000000002M0RR9J
z000000000000000000000001f0RR9J0ucb%8UO$Q00000000000002r0RR9J00000
z0000000000000000002;0RR9J000000000000000000000000H0ssIK0000000000
z00000000000000m0ssIK000000000000000000000000|0ssIY000000000000000
z000000001P0ssIJ01^NIAOHXW00004000000001e0ssIK00000000000000000000
z0001)0ssIY00000000000000000000000290ssII02u%PKmY&$00000000000002M
z0ssIa000000000000000000000002o0ssIJ0vP}hKmY&$00000000000002!0ssIK
z00000000000000000000000090{{RK0vP}ZKmY&$00000000000000M0{{RL00000
z0000000000000000000%0{{RL00000000000000000000000100{{RL01yCR8UO$Q
z0001G000000002k1ONaM000000000000000000000001G0{{RL000000000000000
z000000001m0{{RL000000000000000000000001)0{{RL00000000000000000000
z0002I0{{RL000000000000000000000002m0{{RJ02%-gKmY&$00000000000002y
z0{{RL00000000000000000000000021ONaM000000000000000000000000T1ONaM
z000000000000000000000000v1ONaM000000000000000000000000}0RR9H02%;L
zKmY&$0000000000000191ONaM000000000000000000000001T1ONaM0000000000
z00000000000001v1ONaM00000000000000000000000251ONaM000000000000000
z000000002h1ONaL02%-wKmY&$00008000000002#1ONaM00000000000000000000
z000011pojN000000000000000000000000L1pojN000000000000000000000000u
z1pojL02u%fKmY&$00000000000000#1pojN01yCx6951J000250{{R300000Wq5RQ
zVPkYHV`Xx5E@J>>a$#w1UvF?_ZgX>NUuAM~Z*p@kaA9(EE-(OOX>)LFVR>I~aAj_D
zb8KH_a&m8Sb1raUa&#^*0C#d}bY)*-WpZ=?cVYl*Vs&Y3WM6h=a$;|DWdLJka&%v0
zb94Y}WqDt4VRLf;V{&wJbaiHCE@J>>WpZU_X>)XCa$j_9Ut?@<Ze?=-UteTzUuSG@
zVqt7wWOQ$Gb6;U~cmQK>ZE$R5bY)~NI50Lb0AF8ZZ(nC@Z(?C=Uu1M|a&uo{b$DN9
zX>Ms>VRCX|d0%C2baHtBW^!R|WnW}<ZEbk~UteZ&VQpn!WOZ$Ad0%O6X>?y<a&lpL
zUuAA|a(Mt>Uq(_vO+{ZtPDEc{0AF86PE}t;NMA-$K}|(pNJLTqUq?(&LP1PlPew*l
zMO0r@K|)MLUjScUX>MtBUtw}`VR>I=Ze##oUukY>bYEd|a$$L2b97;HbO2vOSx!Ms
zNkaf%Uu<b&V_#!)bzf#_ZfO8tUuJM}X>N38Ut?%%KtM-KNkT(kGA=VNGyq>;XKin8
zUvqR}a&%u`0A+Y-bU;8yOi4mRUotK-E;Rr}Qc_=IY-M3`UuAM~Z*o9DPf$fpQ&UV|
zF<&uXFaTz6aAj^lKu1hTLPK9NE;24P0AF8hX<}nvb97;HbYE>@X>LG3M@&gVLtip3
zGA=a$MNUUaPDNj1baHH8V{K$WKu=IbPE%7%Uol@XUoZegQc_=MWprO<a&m8SUu<b^
zWk5hrP(@BtQ%qkmUol@W0AEQ|O<!bXa%E>}b97~LR82!{Z*FB&VPb4$0AEQ@UvqS1
zX>MP2b7f=zLP<|wZe@30W@&6?KtNAWMNU&wOkXiyF<&qMUrAI=Uvgz<X>)XCa#T%2
zY;SI5RAFLlWdL7aWMOn+UvqR}a&!P+Ut@S-UuJ1;VQgu7Wk5hjOi4mRUotK-E;RsO
zUsO#)UqwztUta)NH843}PC-pYUvF+@Y-w&~KtNAWMNU&wOkXiyF<&qMUteT%Z(nF(
zZe(m_07XtmNlryyY;R#?Ut)D>Y;<XEUuAA*X>Mh6KtNAWMNU&wOkXiyF<&qMb98ca
zZ)`w7M@&gVLtip3GA=a$Uter#Vq;%pb9G;7ZfSG?MN(2<WpZ+Fa$j?Fa%pa7KtNAW
zMNU&wOkXiyF<&qMXJvF{ZgxOGM@&gVLtip3GA=a$MN(2<aAjp{Uu<D>bYEq1a&K}#
zKu=IbPE%7%Uol@XUoZegQc_=VWo2t$WpZ+FazH>&P(@BtQ%qkmUol@W0AF8Xb8}yF
zbYXII0AF8obYWv_Ut?%%UuI!xY(PLqOi4mRUotK<07XtmNlryyX>MtBKtNAWMNU&w
zOkXiyF<&qMX)<JAST!&?Ut(!*KtNAWMNU&wOkXiyF<&qMST!&?UuR`>UvqV0YGq?|
zUv6P-Wk5hrP(@BtQ%qkmUol@W0A^!sZ*yfpKu1hTLPK9NE;24P07XtmNlryyVtHR_
zWI#YqP(@BtQ%qkmUol@W08m9uUvgz(WM5)wZ(mq7FgZX#Pf$fpQ&UV|F<&uXFaSkP
zM@ddaUt@G~Y+qw-WM6Z1a%pa7KtNAWMNU&wOkXiyF<&qMb97{7a&kaGM@&gVLtip3
zGA=a$LP<|wW^!d^KtNAWMNU&wOkXiyF<&qMW_NOFbY(z5M@&gVLtip3GA=a$Pf$fp
zQ&UV|X>MtBUt@B4aCC1#Ku=IbPE%7%Uol@XUoZe)Wn^J=VE}DmX>I@jE^~QpbYWru
zE^~BpbYWruE^}yebaHfIVgN2_ZggdGZ~!iDZ**lYXKr;aaB^>OWpZ?R04{ECbY(7Q
zZgnnVb!lv5Eoo!`E^cphWiCNNNiB3?X8<l|ZgnnbVRL8zE@XLbb9rq5E@XLbb98b5
zE@y6aE_P*db7^mG04`^4buM;ga&u{KZeMZ$E^=jTVJ>8OZU8QFWo%(CaBOq{E@^IQ
zbO0`JY;-PXZ*%}IaBOrgb7f-yE_7vhbO0`9X>Mr%E^=>VVRT^tE@fz6W^!R|WnXAy
zasV!6XkTV>VQpmqE@^IQbYEd|a$$J@E@o+NX<uP-a$$J@E@XLbVQpz+04`)<bYTE4
zVsmo<E@N+PZDnqB00000000000000000000000000000000000000000000000000
z0000000000000000000000000000000000R0000100002000000000O0{{R30000O
z0{{R30000S000000000000000000010000000000000000000Z000070000200000
z0000u0{{R30000u0{{R30000W000000000000000000080000000000000000000s
z000070000200000000130{{R3000130{{R30000a0000000000000000000400000
z00000000000000<0000700002000000001d0{{R30001d0{{R30000W0000000000
z0000000004000000000000000000120002?|Nn0S000000001>0{{R30001>0{{R3
z0000e000000000600000000080000000000000000001C0000B00002000000002U
z0{{R30002U0{{R30000O0{{R3000070000100008000000000O000000001K00003
z00002000000002s1^@s60002s1^@s60000Z0ssI20000000000000010000000000
z000000001S00030|Nn0S00000000042><{9000042><{90000&000000000600000
z000020000000002000000001f0002~|Nn0S000000000;2><{90000;2><{90001B
z000000000700002000080000000000000000001u0000400002000000001}2><{9
z0001}2><{90002k00000000060000000008000000000O000000001&000040000&
z000000001h3IG5A0001h3IG5A0001R0ssI2000060000O00008000000000O00000
z0001?000010000600000000005C8xG000005C8xG0000R00000000000000000004
z0000000000000000001-0000100006000000000W5C8xG0000W5C8xG000260RR91
z00000000000000G000000000G000000001|0000100006000000002c5dZ)H0002c
z5dZ)H0000G0000000000000000000G000000000G0000000026000010000600000
z0002s5dZ)H0002s5dZ)H0001>0RR9100000000000000G000000000G000000002F
z0000100006000000001h6951J0001h6951J000102LJ#700000000000000G00000
z00000000000002L0000100006000000002k8UO$Q0002k8UO$Q0000D0000000000
z00000000040000000000000000002R00001000020000000000AOHXW00000AOHXW
z0002>000000000000000000080000000000000000002Z0000100002000000002^
zAOHXW0002^AOHXW00017000000000000000000040000000000000000002n00001
z000020000000013ApigX00013ApigX0001}0RR910000000000000080000000000
z000000002x0000E00003000000002sJOBUy0002sEC2ui00008000000000000000
z000080000000008000000002-0000F00003000000002!JOBUy0002!EC2ui00008
z000000000000000000080000000008000000002}0000600003000000002+JOBUy
z0002+EC2ui000000ssI2000070000000008000000000G00000000210000100003
z000000002+J^%m!0002+E&u=k0000G0RR91000000000000008000000000800000
z000060RR92000030000000000KmY&$00000FaQ7m0000G00000000000000000008
z0000000000000000000C0RR9900003000000000WKmY&$0000GFaQ7m0000m00000
z00000000000000W0000000000000000000H0RR920000m0000000000000000000G
zFaQ7m0000h0000000000000000000100000000010000000001000020000000000
z00000000000000$FaQ7m0000m2><{90000T0000r00008000000000O0000000009
z00003000000000000000000000001RIRF3v0000)1poj500000000000000100000
z00000000000000H00003000000000000000000000002AJ^%m!0000Q0RR9100000
a00000000010000000000000000000YHG`f2

literal 0
KcmV+b0RR6000031

-- 
2.25.1

