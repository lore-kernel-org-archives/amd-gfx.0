Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2028C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A3960FE7
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 87A3960FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C3D6E9BB;
	Fri, 27 Aug 2021 20:29:36 +0000 (UTC)
X-Greylist: delayed 7198 seconds by postgrey-1.36 at gabe;
 Fri, 27 Aug 2021 20:29:35 UTC
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (unknown
 [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A866E9BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRCCnkyybWXAZnGSSOHJ08l5TKCdtVTo9Vfcd4TiiuTMursksjoCoZVWUk6yrA8DQG8dgKcEOwafdomDOLszNA7NjCUvQvXy/m4eXZCt8EjIDXoqVa5/yFRb0m7TYIZneslFCaw+ih+LmqvPJdWB45EIFMoB510pnnhl2LcD9+5B5lcbjvtrB4KsvYLGYqy16jiQb1qwIW+T584Nwo9pvb+W4rulGqhlXADtuX86COVGUHis0cf2yCPnD4YhONwPYJrIB6ZBPgSQUHpdf0pg48O5RWD+srFK0/RupfeE3EGi7STAwbLCzsxpT+pOlVCsJifOVREBfefqbGgFBuZmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQHIrCMA53xSeqh5ldf/a0Pq5/0hCqZq3qRTA9jBu6E=;
 b=MQL1fwpUWCzlOyJ2E3sJMh/nfgHORiJtZOODxjkIysGX3WL4ettzykeLSQa5gSwaewphLIPaKqdux6UgJHTh0P+pKwXP69bkN0dsBwwj+2+yL5A8eYRhIwwOPntLEoFi/DqB26T6x9TwqGjNpdm+95TxKtjv8yaatyMCXdvJuOSKZDuQ4mXPqKaUg3H/pE/ip2a9a9L4DeZsjoXfX6X0I4GExI61MOPUZTy6tiUK+7NNWov8wzWqkir1dZTUDxnGyCHlREK669/Ic2yj7tUIh4rt+oLsdWD5h8VmvGEQd1/YoEBnvHhD+IXIXQZvV9qxiqQtvnBFE251sBArQ+bCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQHIrCMA53xSeqh5ldf/a0Pq5/0hCqZq3qRTA9jBu6E=;
 b=yey+8kP/rJi0rXPJphTUkSX1uFAX6MauvYR77zB8RbcjukcQuthcv6MVrJ7e3ZPaksClnl9hbd58Xs+aK9figSnzBPafC6WRS1GtoLi0tmsJ+ykaRhlmPJwCdcWo1xY/8BkgolN4SktFXtAQiwUyLQIsXBkQh/FbZ+p6Iv3pli0=
Received: from MW4PR03CA0147.namprd03.prod.outlook.com (2603:10b6:303:8c::32)
 by BY5PR12MB4801.namprd12.prod.outlook.com (2603:10b6:a03:1b1::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 20:29:32 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::74) by MW4PR03CA0147.outlook.office365.com
 (2603:10b6:303:8c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:31 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:29 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, George Shen
 <George.Shen@amd.com>
Subject: [PATCH 07/19] drm/amd/display: move bpp range decision in decide dsc
 bw range function
Date: Fri, 27 Aug 2021 16:28:58 -0400
Message-ID: <20210827202910.20864-8-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dc715f3-c962-49d1-60f4-08d969996093
X-MS-TrafficTypeDiagnostic: BY5PR12MB4801:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4801D4FF5AF12139E76516FBE4C89@BY5PR12MB4801.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9Wq8E+m1NMZ1vDF0FHAPmE7CG0e8dV1xhk+gGgP6kEhA1W1uvQl8PpUwtq2aSZxVYuOm27p1zfaQzkRdPZ7BgjM1nzc1S0XPcD9+HOP+KomkInTcUlXUnFh8OxcjFXSD451+b65P+M4y+Y/jSEkGeX1WXKu8KI2Eth6p3IgpwwLcq4M9sAHIYXZd6jrBazwC2wg6PX7lZYKWvpBf0wg2lEUnsYARF2BP8uRT+APp5wgMFjhI9cNbFgJVQsvT+aGHlM4P+eCDt5oP6ld/tG+Df+UcETKb58Xlad1paUmRtBqO4h5bVtaRyRiOsd792wlb+5soL+NU+g+K9Vvu6POX5eYAYpz62nY7Gk/Wtlcref97xqZRQGvjFpamyEUPeTVRG5tizXbi4T9Cgzs4f7S5lOdHLcegaKTMl7SG4BKnektkrGA1HLJhAT5RHRlHcGGY45RA69BRoW3vQ+J8FuFFhV0rS/WOMl5V/n11ZZHn6Oa4r8GVC4ELO8zmyytmhBktaKKzomggpxHpFnNyPlWyyCKdJ4IBt1vKsAJIGKPKhJyUvMSSA5+bsRVo9QBntCK/6iUXKvElRHsHrGfOYkRm3Lw7LzTp60llVUoht5IZC7XUDzxMfhmQwwfyNRd/5F4Xgp69FgHbBLdZUsCiZ5v1T5X1M6AbCR+EI7u9jBrwK3TamD+PGr9OjVQJbrtXcw3VCUT5eQ8qV0L423gLQGU2uaHg9rAiWifbTPmZWwLMMU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(83380400001)(426003)(1076003)(16526019)(86362001)(186003)(2906002)(5660300002)(70206006)(70586007)(54906003)(81166007)(6666004)(36860700001)(336012)(2616005)(478600001)(44832011)(8936002)(82740400003)(36756003)(356005)(26005)(82310400003)(4326008)(47076005)(8676002)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:31.9240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc715f3-c962-49d1-60f4-08d969996093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4801
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

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dsc.h     |   6 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 132 +++++++++++---------
 2 files changed, 76 insertions(+), 62 deletions(-)

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
index 8c04f9f42a3b..b510080990d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -39,6 +39,21 @@ static bool dsc_policy_enable_dsc_when_not_needed;
 
 static bool dsc_policy_disable_dsc_stream_overhead;
 
+#ifndef MAX
+#define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
+#endif
+#ifndef MIN
+#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
+
+static bool decide_dsc_bandwidth_range(
+		const uint32_t min_bpp_x16,
+		const uint32_t max_bpp_x16,
+		const uint32_t num_slices_h,
+		const struct dsc_enc_caps *dsc_caps,
+		const struct dc_crtc_timing *timing,
+		struct dc_dsc_bw_range *range);
+
 static bool dsc_buff_block_size_from_dpcd(int dpcd_buff_block_size, int *buff_block_size)
 {
 
@@ -285,10 +300,12 @@ static uint32_t compute_bpp_x16_from_target_bandwidth(
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
@@ -296,39 +313,45 @@ static void get_dsc_bandwidth_range(
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
 	}
+	else {
+		range->max_target_bpp_x16 = max_bpp_x16;
+		range->min_target_bpp_x16 = min_bpp_x16;
+	}
+
+	/* populate output structure */
+	if (range->max_target_bpp_x16 >= range->min_target_bpp_x16 && range->min_target_bpp_x16 > 0) {
+		/* native stream bandwidth */
+		range->stream_kbps = dc_bandwidth_in_kbps_from_timing(timing);
+
+		/* max dsc target bpp */
+		range->max_kbps = dc_dsc_stream_bandwidth_in_kbps(timing,
+				range->max_target_bpp_x16, num_slices_h, dsc_caps->is_dp);
 
-	/* min dsc target bpp */
-	range->min_kbps = dc_dsc_stream_bandwidth_in_kbps(timing,
-			min_bpp_x16, num_slices_h, dsc_caps->is_dp);
-	range->min_target_bpp_x16 = min_bpp_x16;
-	if (range->min_kbps > range->max_kbps) {
-		/* min dsc target bpp is capped to max dsc bandwidth*/
-		range->min_kbps = range->max_kbps;
-		range->min_target_bpp_x16 = range->max_target_bpp_x16;
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
@@ -338,40 +361,29 @@ static bool decide_dsc_target_bpp_x16(
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
@@ -877,7 +889,7 @@ bool dc_dsc_compute_bandwidth_range(
 				dsc_min_slice_height_override, max_bpp_x16, &config);
 
 	if (is_dsc_possible)
-		get_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16,
+		is_dsc_possible = decide_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16,
 				config.num_slices_h, &dsc_common_caps, timing, range);
 
 	return is_dsc_possible;
@@ -1001,8 +1013,6 @@ void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t
 		return;
 	}
 
-	policy->preferred_bpp_x16 = timing->dsc_fixed_bits_per_pixel_x16;
-
 	/* internal upper limit, default 16 bpp */
 	if (policy->max_target_bpp > dsc_policy_max_target_bpp_limit)
 		policy->max_target_bpp = dsc_policy_max_target_bpp_limit;
-- 
2.25.1

