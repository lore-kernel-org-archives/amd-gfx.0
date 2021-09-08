Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFF6C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53CC60E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E53CC60E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709CB6E1BB;
	Wed,  8 Sep 2021 14:54:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6769E6E19C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AykArtYab4DYjCsuguBhEUZ56562F8Ecuf86aONg3Un4hDifA8CflPjfxpLVL89+cepbpq3Nzrmez4aE9DsWimrSNNgnUu//ETYXpsv3vlEx3hhTb2AXp4N+kT2sHrqiJfApGgxAkBo0egqgGGcJiBAP29PplxYwp0uM+5ShDYSXRCJbMKgXRejO7FBeBos5MMOkZIV0iwLlAbI7FrHUFPLktnEcIF3OweKtH/sAkIB0Oc7X4ajCjvmplBgPd1BQIDAr6CfTScfQiAk9qaLVxzrK92rJOjmNro97SvjJi53CFI5kBWhlLGqO6reRdcnIR+ukA0WLYlE+VJaulN51dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=FRnAEuog8su2YquGOf8CoKt/H3jmpOPvpbvQoT7ykKs=;
 b=HqtaJxLMUzCf+Y6NP1AOA1vgi4lExvFgzeLIOBaE379CZ8sKP9K1aguaxmxus+NNsAYSqkkP12oNCsfGAS8qCliB+zL8t8gsNZXJrHwRbupK9/CbMccwCob1EajFp9Dd1LIhjAaC6gDuj4DZYEl83G2S7Ll7/XH35u8d/rls8jKSBhwa4twj8VfPWKz2BIxFq0JWCFXY/ElK/rWq9kavwZxepYq19B8PnZbLd7NQcskP1Fyt0QW/Yyon970MnVd3+nzl3RkA9plzp9TsKyD93C/Pf72KCpLIZcl81HwhAYo+EWpa351Iq8RcO5usbgCJ52/uAzqpRqZ8o9ByWi0pIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRnAEuog8su2YquGOf8CoKt/H3jmpOPvpbvQoT7ykKs=;
 b=AJNRSEzVPFuVAOfxDUaLMki9HfyG0oiWJxZBU8YLMFuPZiewY71i2ZH9D//ruvfh8kSUI7qTgrQaT+P+/wG1Y/V7FVUn9Qk+f+uPsK/v4j/OZcycoB8dy7lWwywU+cC0KzjqBdgem6pHRkXyIo7iMjtf2vmJf9fMdMzKplRVv90=
Received: from DM6PR02CA0051.namprd02.prod.outlook.com (2603:10b6:5:177::28)
 by DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 14:54:38 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::81) by DM6PR02CA0051.outlook.office365.com
 (2603:10b6:5:177::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:37 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:35 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, George Shen <george.shen@amd.com>
Subject: [PATCH 03/33] drm/amd/display: move bpp range decision in decide dsc
 bw range function
Date: Wed, 8 Sep 2021 10:53:54 -0400
Message-ID: <20210908145424.3311-4-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b6753e5-741f-4b85-f1aa-08d972d8947a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5213:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5213FE7EC6F89FC9F6A039B0E4D49@DM4PR12MB5213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xbYjf61U3blTMvZvLpm2ZKxJnvpSFvJ2ZicVcFDXUbD2Z94jzFjAQdTj9w66NA8UhBhWPUDuMxfXILLXFESP2BsKZxe51HBGyAeVWl7fhbW5VrqkGd1LMGWcXXFVXHObizfhPIk0yg9o1D8Iqo2mAynMLKe/opJ0gDr8jYirNzIpga55SUU/K1T6YaTXO0QU4CT7+AvMOD1O/uSWmoStZ8jLoLu71lz1HU4jzlkEwFw/gIrpxMv11pMfrS56MpGKgEGAcS8q/l2yi4qNfT6X9Kfb+KjMpmNNpCcn5C5MHsf9GqfzAq+ejX/8MFZvVz1gq2K74upe9N2qliJJKjUKHJZRPykhdkGQmEJIR4Wnyg6ojaEZNzoRtG/AO2jHQP3X9ljg/+ZitDnSM5XraQS/z9NHeWW1KY5PApKkrypl9AZomU/mbADpjaojeHjy7Sx14WpI9rlLlR1UCGfBfsUgpE2CgtzmvnooczWVXbp6Z62OiEA0w9nMqqkRvLQjUL5TyuyE/1BoN9XWyTu/V/dma1pAwbUDOcBmltfWGB2Z1wtZFcBb43m6gmp+H8wbjOSaIqoi+Ob61Ma+cb2zcMcy7eyBn3VZkYgch1Zv8qRdqRGh0Xg+gKSLTKVY080tC8yGOc5VL9AlCPg+z+tmgzNxAk1/ABEmRNtIw+jNCeFW29WZsqd6pTiyjoYGdcStwDjhWAeexLgsyRkI2gEngCz6sDkPHo7upB6/q2+cdCel5Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(44832011)(316002)(16526019)(2906002)(54906003)(508600001)(82310400003)(8936002)(2616005)(4326008)(86362001)(36860700001)(426003)(47076005)(6666004)(70206006)(1076003)(5660300002)(70586007)(356005)(336012)(26005)(6916009)(186003)(8676002)(83380400001)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:37.8174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6753e5-741f-4b85-f1aa-08d972d8947a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Before get dsc bw range is used to compute DSC bw range
based on the given fixed bpp min/max input.
The new change will merge any specs, signal, timing specific
bpp range decision into this function. So the function needs to make
a decision with all aspects considered.

Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dsc.h     |   6 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 126 ++++++++++----------
 2 files changed, 69 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index c8cc6a448c36..684713b2cff7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -51,7 +51,6 @@ struct dc_dsc_policy {
 	int min_slice_height; // Must not be less than 8
 	uint32_t max_target_bpp;
 	uint32_t min_target_bpp;
-	uint32_t preferred_bpp_x16;
 	bool enable_dsc_when_not_needed;
 };
 
@@ -86,6 +85,11 @@ uint32_t dc_dsc_stream_bandwidth_overhead_in_kbps(
 		const int num_slices_h,
 		const bool is_dp);
 
+/* TODO - Hardware/specs limitation should be owned by dc dsc and returned to DM,
+ * and DM can choose to OVERRIDE the limitation on CASE BY CASE basis.
+ * Hardware/specs limitation should not be writable by DM.
+ * It should be decoupled from DM specific policy and named differently.
+ */
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		uint32_t max_target_bpp_limit_override_x16,
 		struct dc_dsc_policy *policy);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 1e30a742ae01..0321b4446e05 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -40,8 +40,15 @@ static bool dsc_policy_enable_dsc_when_not_needed;
 
 static bool dsc_policy_disable_dsc_stream_overhead;
 
+#ifndef MAX
+#define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
+#endif
+#ifndef MIN
+#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
+
 /* Forward Declerations */
-static void get_dsc_bandwidth_range(
+static bool decide_dsc_bandwidth_range(
 		const uint32_t min_bpp_x16,
 		const uint32_t max_bpp_x16,
 		const uint32_t num_slices_h,
@@ -356,7 +363,7 @@ bool dc_dsc_compute_bandwidth_range(
 				dsc_min_slice_height_override, max_bpp_x16, &config);
 
 	if (is_dsc_possible)
-		get_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16,
+		is_dsc_possible = decide_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16,
 				config.num_slices_h, &dsc_common_caps, timing, range);
 
 	return is_dsc_possible;
@@ -481,10 +488,12 @@ static uint32_t compute_bpp_x16_from_target_bandwidth(
 	return dc_fixpt_floor(bpp_x16);
 }
 
-/* Get DSC bandwidth range based on [min_bpp, max_bpp] target bitrate range, and timing's pixel clock
- * and uncompressed bandwidth.
+/* Decide DSC bandwidth range based on signal, timing, specs specific and input min and max
+ * requirements.
+ * The range output includes decided min/max target bpp, the respective bandwidth requirements
+ * and native timing bandwidth requirement when DSC is not used.
  */
-static void get_dsc_bandwidth_range(
+static bool decide_dsc_bandwidth_range(
 		const uint32_t min_bpp_x16,
 		const uint32_t max_bpp_x16,
 		const uint32_t num_slices_h,
@@ -492,39 +501,45 @@ static void get_dsc_bandwidth_range(
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_bw_range *range)
 {
-	/* native stream bandwidth */
-	range->stream_kbps = dc_bandwidth_in_kbps_from_timing(timing);
-
-	/* max dsc target bpp */
-	range->max_kbps = dc_dsc_stream_bandwidth_in_kbps(timing,
-			max_bpp_x16, num_slices_h, dsc_caps->is_dp);
-	range->max_target_bpp_x16 = max_bpp_x16;
-	if (range->max_kbps > range->stream_kbps) {
-		/* max dsc target bpp is capped to native bandwidth */
-		range->max_kbps = range->stream_kbps;
-		range->max_target_bpp_x16 = compute_bpp_x16_from_target_bandwidth(
-				range->max_kbps, timing, num_slices_h,
-				dsc_caps->bpp_increment_div,
-				dsc_caps->is_dp);
+	uint32_t preferred_bpp_x16 = timing->dsc_fixed_bits_per_pixel_x16;
+
+	memset(range, 0, sizeof(*range));
+
+	/* apply signal, timing, specs and explicitly specified DSC range requirements */
+	if (preferred_bpp_x16) {
+		if (preferred_bpp_x16 <= max_bpp_x16 &&
+				preferred_bpp_x16 >= min_bpp_x16) {
+			range->max_target_bpp_x16 = preferred_bpp_x16;
+			range->min_target_bpp_x16 = preferred_bpp_x16;
+		}
+	}
+	else {
+		range->max_target_bpp_x16 = max_bpp_x16;
+		range->min_target_bpp_x16 = min_bpp_x16;
 	}
 
-	/* min dsc target bpp */
-	range->min_kbps = dc_dsc_stream_bandwidth_in_kbps(timing,
-			min_bpp_x16, num_slices_h, dsc_caps->is_dp);
-	range->min_target_bpp_x16 = min_bpp_x16;
-	if (range->min_kbps > range->max_kbps) {
-		/* min dsc target bpp is capped to max dsc bandwidth*/
-		range->min_kbps = range->max_kbps;
-		range->min_target_bpp_x16 = range->max_target_bpp_x16;
+	/* populate output structure */
+	if (range->max_target_bpp_x16 >= range->min_target_bpp_x16 && range->min_target_bpp_x16 > 0) {
+		/* native stream bandwidth */
+		range->stream_kbps = dc_bandwidth_in_kbps_from_timing(timing);
+
+		/* max dsc target bpp */
+		range->max_kbps = dc_dsc_stream_bandwidth_in_kbps(timing,
+				range->max_target_bpp_x16, num_slices_h, dsc_caps->is_dp);
+
+		/* min dsc target bpp */
+		range->min_kbps = dc_dsc_stream_bandwidth_in_kbps(timing,
+				range->min_target_bpp_x16, num_slices_h, dsc_caps->is_dp);
 	}
+
+	return range->max_kbps >= range->min_kbps && range->min_kbps > 0;
 }
 
 /* Decides if DSC should be used and calculates target bpp if it should, applying DSC policy.
  *
  * Returns:
- *     - 'true' if DSC was required by policy and was successfully applied
- *     - 'false' if DSC was not necessary (e.g. if uncompressed stream fits 'target_bandwidth_kbps'),
- *        or if it couldn't be applied based on DSC policy.
+ *     - 'true' if target bpp is decided
+ *     - 'false' if target bpp cannot be decided (e.g. cannot fit even with min DSC bpp),
  */
 static bool decide_dsc_target_bpp_x16(
 		const struct dc_dsc_policy *policy,
@@ -534,40 +549,29 @@ static bool decide_dsc_target_bpp_x16(
 		const int num_slices_h,
 		int *target_bpp_x16)
 {
-	bool should_use_dsc = false;
 	struct dc_dsc_bw_range range;
 
-	memset(&range, 0, sizeof(range));
-
-	get_dsc_bandwidth_range(policy->min_target_bpp * 16, policy->max_target_bpp * 16,
-			num_slices_h, dsc_common_caps, timing, &range);
-	if (!policy->enable_dsc_when_not_needed && target_bandwidth_kbps >= range.stream_kbps) {
-		/* enough bandwidth without dsc */
-		*target_bpp_x16 = 0;
-		should_use_dsc = false;
-	} else if (policy->preferred_bpp_x16 > 0 &&
-			policy->preferred_bpp_x16 <= range.max_target_bpp_x16 &&
-			policy->preferred_bpp_x16 >= range.min_target_bpp_x16) {
-		*target_bpp_x16 = policy->preferred_bpp_x16;
-		should_use_dsc = true;
-	} else if (target_bandwidth_kbps >= range.max_kbps) {
-		/* use max target bpp allowed */
-		*target_bpp_x16 = range.max_target_bpp_x16;
-		should_use_dsc = true;
-	} else if (target_bandwidth_kbps >= range.min_kbps) {
-		/* use target bpp that can take entire target bandwidth */
-		*target_bpp_x16 = compute_bpp_x16_from_target_bandwidth(
-				target_bandwidth_kbps, timing, num_slices_h,
-				dsc_common_caps->bpp_increment_div,
-				dsc_common_caps->is_dp);
-		should_use_dsc = true;
-	} else {
-		/* not enough bandwidth to fulfill minimum requirement */
-		*target_bpp_x16 = 0;
-		should_use_dsc = false;
+	*target_bpp_x16 = 0;
+
+	if (decide_dsc_bandwidth_range(policy->min_target_bpp * 16, policy->max_target_bpp * 16,
+			num_slices_h, dsc_common_caps, timing, &range)) {
+		if (target_bandwidth_kbps >= range.stream_kbps) {
+			if (policy->enable_dsc_when_not_needed)
+				/* enable max bpp even dsc is not needed */
+				*target_bpp_x16 = range.max_target_bpp_x16;
+		} else if (target_bandwidth_kbps >= range.max_kbps) {
+			/* use max target bpp allowed */
+			*target_bpp_x16 = range.max_target_bpp_x16;
+		} else if (target_bandwidth_kbps >= range.min_kbps) {
+			/* use target bpp that can take entire target bandwidth */
+			*target_bpp_x16 = compute_bpp_x16_from_target_bandwidth(
+					target_bandwidth_kbps, timing, num_slices_h,
+					dsc_common_caps->bpp_increment_div,
+					dsc_common_caps->is_dp);
+		}
 	}
 
-	return should_use_dsc;
+	return *target_bpp_x16 != 0;
 }
 
 #define MIN_AVAILABLE_SLICES_SIZE  4
@@ -1059,8 +1063,6 @@ void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		return;
 	}
 
-	policy->preferred_bpp_x16 = timing->dsc_fixed_bits_per_pixel_x16;
-
 	/* internal upper limit, default 16 bpp */
 	if (policy->max_target_bpp > dsc_policy_max_target_bpp_limit)
 		policy->max_target_bpp = dsc_policy_max_target_bpp_limit;
-- 
2.25.1

