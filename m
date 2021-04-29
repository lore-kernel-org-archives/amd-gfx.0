Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5351C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DC06145B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DC06145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7C96ED87;
	Thu, 29 Apr 2021 07:54:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 068866ED7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh/ejy8sWiXIj0kEknDWXnCgODlkWStWoarVrJgFfD2+6JNbTRIj+t8lyWtpOZqgv1sA1TkIfEQots0qmuTKpf1DU5lQAqx5p9AyCW/FcCSNNMfR+9OXxCQx1r55yuONOQgES2ghXUMyTbeH8AG/I+NM6ozTfvqt66atU3EgcVQ4/aT/PVK/EJgi9YdKBtzSIeVoiADfpvAlawG7gR+6QJejyR+xb1J0VqK2KP/dNbyXJkBOcXJ0tkRBDaAuBJT56PNPkwXSPBJWbJAAVj/VWfw1uj9eIEydyxM1tD5daAShJRTXwp6kee3OfmVf2WwT9LXnBj3Rp67BCuP5zuiEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep4FMCQLkmGFHgA5qtS3Jz2r/rKDFP/oDLGzNGQCRCk=;
 b=buohOQd35XRruSwZ1AmoQULbQcsGCGLnLLdE/gws4VEEYmII0TUL7qCALxic+ZIxhxKWskAIno39gD6rNMwmQaTarIsPm2mtnlyora7qaSHIPdy5umPWTGg5SU1zCUe1EvgIji/r9wtfHUGi3FQKonIH1z2pEgzN2Zh90A3whtCgoy8MjlGm1s/tnl6WTos90MkTqoo8jx3CBhkrKXfPfbh/atZp2N6Cg9ZiEhZ2wbtUlUnxtid+1yZRIGJSIOJYnG+6QT9Ds4XY9YFNJAeLeEni7aBZFv7uJ8RDkbkBJ/wJdQUQEFjeEYa8MfYwWcuItq+qgrWqYgYKynl5RGLbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep4FMCQLkmGFHgA5qtS3Jz2r/rKDFP/oDLGzNGQCRCk=;
 b=2D0bCo24gjTa+bqXCLGsNTqaik5cnpMo7eb9M2Md/oUEFDCMJGcgiDWQqlSbMqz9lGdraRW5JYSBBCxU9PKYe2YwUa6zKOWa0kwf3NHjbCNMSdHL3MYDv+7obPgojxQlbde4J00UFjMADi/gtJkIQxtU/WCTFwsnRyOIYCFI8hQ=
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by MN2PR12MB3501.namprd12.prod.outlook.com (2603:10b6:208:c7::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 07:54:39 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::83) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:54:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:38 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:36 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: add dsc stream overhead for dp only
Date: Thu, 29 Apr 2021 15:52:01 +0800
Message-ID: <20210429075206.15974-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b73fb3f6-ed13-4327-e565-08d90ae40a76
X-MS-TrafficTypeDiagnostic: MN2PR12MB3501:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3501A775F2D38A7724855517FC5F9@MN2PR12MB3501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbbRZDpiKSMa9JuSnySBPM9DyyP/XReFh128Hb7POVK8iH8wCmfRHsD6Ub0pe1xfnoatwLtbG5d40z1RGvkw73470yCItD4j4bssyvLyinKPPDVyUI8yXyyCwNctBGsrugeUqCQqif59kTcc+MuvMJ0pdQUTLgN/hnyrWjRbS/uevW0cO/K9+sB8bRS+aic0pSGc/MQVtKmXpLemGK8VnMX9otwlvdwGm9FX68Lm1eVvuXEMM4aRE7rYqzOvL8BTk9PNgEePBtVxGePb39oPD6X2UQi0QqN+sq+xflCLSz8Fkefvi+M9FaZOlfP6wizuDz2p+g4Fmj1iRuc/rDOnkcqZUeBsOUzNhPzX2j1z2z5I6rOPHgHkOSfsiEhDng2StGyFjklSeAcNTReg8FGiGE6uov6MbBYzklvvzbzs7t6xC1W2ywMl5yvwbCIhnMCxRI++J5GW1OWNmodgvtBXMaXOEnOqehLJ5cpHy7wgtAgxd7pBFEntvWKYMvzCCw+BgSnxcwls4yFx0CAYVCmmt5qksoTYeVRS9PalkHkicE9ZUx5oT8BGhoW16rx8U0EyKqqn9PUyOw0s6PrEbpXYpQcL7XjQGwgXAdtw6jNGnQt9cDkT3YmbryJiTSodYgtqoGKpVpPS8urmUXFV9v9g+w6bZGilyrWe+g90rfpMYno4YU4ctVJP9uHveUFO/1zT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(82740400003)(4326008)(186003)(8676002)(70586007)(6916009)(1076003)(2906002)(82310400003)(356005)(316002)(47076005)(5660300002)(70206006)(7696005)(54906003)(478600001)(2616005)(336012)(36756003)(8936002)(36860700001)(81166007)(426003)(83380400001)(26005)(86362001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:39.3581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73fb3f6-ed13-4327-e565-08d90ae40a76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3501
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Based on hardware team recommendation this additional dsc overhead
is only required for DP DSC.

[how]
Add a check for is_dp and only apply the overhead if this flag is set.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 41 +++++++++++++------
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |  1 +
 6 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c6b4daf00be5..3fb0cebd6938 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3490,7 +3490,8 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 	if (timing->flags.DSC)
 		return dc_dsc_stream_bandwidth_in_kbps(timing,
 				timing->dsc_cfg.bits_per_pixel,
-				timing->dsc_cfg.num_slices_h);
+				timing->dsc_cfg.num_slices_h,
+				timing->dsc_cfg.is_dp);
 #endif
 
 	switch (timing->display_color_depth) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index afddb8b7d3e4..16cc76ce3739 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -79,7 +79,7 @@ bool dc_dsc_compute_config(
 		struct dc_dsc_config *dsc_cfg);
 
 uint32_t dc_dsc_stream_bandwidth_in_kbps(const struct dc_crtc_timing *timing,
-		uint32_t bpp_x16, uint32_t num_slices_h);
+		uint32_t bpp_x16, uint32_t num_slices_h, bool is_dp);
 
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		uint32_t max_target_bpp_limit_override_x16,
@@ -89,4 +89,6 @@ void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit);
 
 void dc_dsc_policy_set_enable_dsc_when_not_needed(bool enable);
 
+void dc_dsc_policy_set_disable_dsc_stream_overhead(bool disable);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index bcec019efa6f..04957a9efab2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -739,6 +739,7 @@ struct dc_dsc_config {
 	uint32_t version_minor; /* DSC minor version. Full version is formed as 1.version_minor. */
 	bool ycbcr422_simple; /* Tell DSC engine to convert YCbCr 4:2:2 to 'YCbCr 4:2:2 simple'. */
 	int32_t rc_buffer_size; /* DSC RC buffer block size in bytes */
+	bool is_dp; /* indicate if DSC is applied based on DP's capability */
 };
 struct dc_crtc_timing {
 	uint32_t h_total;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 205d8241c4fc..535da8db70b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -909,6 +909,7 @@ struct dsc_dec_dpcd_caps {
 	uint32_t branch_overall_throughput_0_mps; /* In MPs */
 	uint32_t branch_overall_throughput_1_mps; /* In MPs */
 	uint32_t branch_max_line_width;
+	bool is_dp;
 };
 
 struct dc_golden_table {
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index bfe3ad58070a..f403d8e84a8c 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -37,6 +37,8 @@ static uint32_t dsc_policy_max_target_bpp_limit = 16;
 /* default DSC policy enables DSC only when needed */
 static bool dsc_policy_enable_dsc_when_not_needed;
 
+static bool dsc_policy_disable_dsc_stream_overhead;
+
 static bool dsc_buff_block_size_from_dpcd(int dpcd_buff_block_size, int *buff_block_size)
 {
 
@@ -250,6 +252,7 @@ static bool intersect_dsc_caps(
 	if (pixel_encoding == PIXEL_ENCODING_YCBCR422 || pixel_encoding == PIXEL_ENCODING_YCBCR420)
 		dsc_common_caps->bpp_increment_div = min(dsc_common_caps->bpp_increment_div, (uint32_t)8);
 
+	dsc_common_caps->is_dp = dsc_sink_caps->is_dp;
 	return true;
 }
 
@@ -260,11 +263,15 @@ static inline uint32_t dsc_div_by_10_round_up(uint32_t value)
 
 static struct fixed31_32 compute_dsc_max_bandwidth_overhead(
 		const struct dc_crtc_timing *timing,
-		const int num_slices_h)
+		const int num_slices_h,
+		const bool is_dp)
 {
 	struct fixed31_32 max_dsc_overhead;
 	struct fixed31_32 refresh_rate;
 
+	if (dsc_policy_disable_dsc_stream_overhead || !is_dp)
+		return dc_fixpt_from_int(0);
+
 	/* use target bpp that can take entire target bandwidth */
 	refresh_rate = dc_fixpt_from_int(timing->pix_clk_100hz);
 	refresh_rate = dc_fixpt_div_int(refresh_rate, timing->h_total);
@@ -272,7 +279,7 @@ static struct fixed31_32 compute_dsc_max_bandwidth_overhead(
 	refresh_rate = dc_fixpt_mul_int(refresh_rate, 100);
 
 	max_dsc_overhead = dc_fixpt_from_int(num_slices_h);
-	max_dsc_overhead = dc_fixpt_mul_int(max_dsc_overhead, timing->v_addressable);
+	max_dsc_overhead = dc_fixpt_mul_int(max_dsc_overhead, timing->v_total);
 	max_dsc_overhead = dc_fixpt_mul_int(max_dsc_overhead, 256);
 	max_dsc_overhead = dc_fixpt_div_int(max_dsc_overhead, 1000);
 	max_dsc_overhead = dc_fixpt_mul(max_dsc_overhead, refresh_rate);
@@ -284,14 +291,15 @@ static uint32_t compute_bpp_x16_from_target_bandwidth(
 		const uint32_t bandwidth_in_kbps,
 		const struct dc_crtc_timing *timing,
 		const uint32_t num_slices_h,
-		const uint32_t bpp_increment_div)
+		const uint32_t bpp_increment_div,
+		const bool is_dp)
 {
 	struct fixed31_32 overhead_in_kbps;
 	struct fixed31_32 effective_bandwidth_in_kbps;
 	struct fixed31_32 bpp_x16;
 
 	overhead_in_kbps = compute_dsc_max_bandwidth_overhead(
-				timing, num_slices_h);
+				timing, num_slices_h, is_dp);
 	effective_bandwidth_in_kbps = dc_fixpt_from_int(bandwidth_in_kbps);
 	effective_bandwidth_in_kbps = dc_fixpt_sub(effective_bandwidth_in_kbps,
 			overhead_in_kbps);
@@ -319,19 +327,20 @@ static void get_dsc_bandwidth_range(
 
 	/* max dsc target bpp */
 	range->max_kbps = dc_dsc_stream_bandwidth_in_kbps(timing,
-			max_bpp_x16, num_slices_h);
+			max_bpp_x16, num_slices_h, dsc_caps->is_dp);
 	range->max_target_bpp_x16 = max_bpp_x16;
 	if (range->max_kbps > range->stream_kbps) {
 		/* max dsc target bpp is capped to native bandwidth */
 		range->max_kbps = range->stream_kbps;
 		range->max_target_bpp_x16 = compute_bpp_x16_from_target_bandwidth(
 				range->max_kbps, timing, num_slices_h,
-				dsc_caps->bpp_increment_div);
+				dsc_caps->bpp_increment_div,
+				dsc_caps->is_dp);
 	}
 
 	/* min dsc target bpp */
 	range->min_kbps = dc_dsc_stream_bandwidth_in_kbps(timing,
-			min_bpp_x16, num_slices_h);
+			min_bpp_x16, num_slices_h, dsc_caps->is_dp);
 	range->min_target_bpp_x16 = min_bpp_x16;
 	if (range->min_kbps > range->max_kbps) {
 		/* min dsc target bpp is capped to max dsc bandwidth*/
@@ -378,10 +387,9 @@ static bool decide_dsc_target_bpp_x16(
 	} else if (target_bandwidth_kbps >= range.min_kbps) {
 		/* use target bpp that can take entire target bandwidth */
 		*target_bpp_x16 = compute_bpp_x16_from_target_bandwidth(
-				range.max_kbps, timing, num_slices_h,
-				dsc_common_caps->bpp_increment_div);
-		if (*target_bpp_x16 < range.min_kbps)
-			*target_bpp_x16 = range.min_kbps;
+				target_bandwidth_kbps, timing, num_slices_h,
+				dsc_common_caps->bpp_increment_div,
+				dsc_common_caps->is_dp);
 		should_use_dsc = true;
 	} else {
 		/* not enough bandwidth to fulfill minimum requirement */
@@ -751,6 +759,7 @@ static bool setup_dsc_config(
 		dsc_cfg->block_pred_enable = dsc_common_caps.is_block_pred_supported;
 		dsc_cfg->linebuf_depth = dsc_common_caps.lb_bit_depth;
 		dsc_cfg->version_minor = (dsc_common_caps.dsc_version & 0xf0) >> 4;
+		dsc_cfg->is_dp = dsc_sink_caps->is_dp;
 	}
 
 done:
@@ -861,6 +870,7 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc, const uint8_t *dpcd_dsc_basic_da
 	dsc_sink_caps->branch_max_line_width = dpcd_dsc_branch_decoder_caps[DP_DSC_BRANCH_MAX_LINE_WIDTH - DP_DSC_BRANCH_OVERALL_THROUGHPUT_0] * 320;
 	ASSERT(dsc_sink_caps->branch_max_line_width == 0 || dsc_sink_caps->branch_max_line_width >= 5120);
 
+	dsc_sink_caps->is_dp = true;
 	return true;
 }
 
@@ -921,14 +931,14 @@ bool dc_dsc_compute_config(
 }
 
 uint32_t dc_dsc_stream_bandwidth_in_kbps(const struct dc_crtc_timing *timing,
-		uint32_t bpp_x16, uint32_t num_slices_h)
+		uint32_t bpp_x16, uint32_t num_slices_h, bool is_dp)
 {
 	struct fixed31_32 overhead_in_kbps;
 	struct fixed31_32 bpp;
 	struct fixed31_32 actual_bandwidth_in_kbps;
 
 	overhead_in_kbps = compute_dsc_max_bandwidth_overhead(
-			timing, num_slices_h);
+			timing, num_slices_h, is_dp);
 	bpp = dc_fixpt_from_fraction(bpp_x16, 16);
 	actual_bandwidth_in_kbps = dc_fixpt_from_fraction(timing->pix_clk_100hz, 10);
 	actual_bandwidth_in_kbps = dc_fixpt_mul(actual_bandwidth_in_kbps, bpp);
@@ -1017,3 +1027,8 @@ void dc_dsc_policy_set_enable_dsc_when_not_needed(bool enable)
 {
 	dsc_policy_enable_dsc_when_not_needed = enable;
 }
+
+void dc_dsc_policy_set_disable_dsc_stream_overhead(bool disable)
+{
+	dsc_policy_disable_dsc_stream_overhead = disable;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
index f520e13aee4c..f94135c6e3c2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
@@ -88,6 +88,7 @@ struct dsc_enc_caps {
 	int32_t max_total_throughput_mps; /* Maximum total throughput with all the slices combined */
 	int32_t max_slice_width;
 	uint32_t bpp_increment_div; /* bpp increment divisor, e.g. if 16, it's 1/16th of a bit */
+	bool is_dp;
 };
 
 struct dsc_funcs {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
