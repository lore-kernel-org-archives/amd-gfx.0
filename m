Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BE1C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749F664E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749F664E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258A16EC2A;
	Fri, 29 Jan 2021 21:28:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03F06EC2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFWkEFdaIhODPGSJJrdt1Ynp+MCK9R5jEnhLnwfvBawXyS0Y45EM84rx35/2qNixL4ay5fPS9z+5RO26ejYS5i7elLL9jjh31fXtn/jDRVUYSttnwK4Wt5UnCj/FMRIOeAcqnawlt+Sao3+XCyhn8fUvTRy5wCv0Pxr7iCkvpMtRS2iDNfsvpID+nTOzEhGgBbrLN7BcCIlzwiJdCbGFVZTCc4WJ621H3dG+I17XWLT70duAy/x7ox0v1sX6QzknxXwMWb+QOiqRL1m1TLaZymL9JmmuPErfTQldVJbrGKfVVvR9NJxU0Ts49nrNdzNXR+ItJSKqgb25QffF5WK6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XcwPDweayUGKV11ofnSMyHKJWcbkt8xzD7fKCocZmw=;
 b=U8ES2Dkd3pAin6QELqGDVEIRuLTD7ehSyebjbwWU3NRu50PseR76aMxBuKkyHjXq+LKsOOuIAlJITldghQqK02liosYTzmVvVUKo+1BjJHek2jyQhRkfsstdVZgLHAa7E91NlCEI2rEvI/KUfvaXo3ToQ1rV1i9a6Mx0g5UZYzdlBoa9aCUjNfnFruHEt0dD8VxIsUN+Y/fUNyKOZKZDqo2/7c502tKi8EaPhCq6DjujyWd6r1EYcD5acYsydA9oQcn6NoGPBtQsSZ7h+1/JLbPHrplPpx6xS/TE7rHugj3Z5DhysTbPoW5bqXp4vfAKbCU5wsL8ECyGr7NB1JfYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XcwPDweayUGKV11ofnSMyHKJWcbkt8xzD7fKCocZmw=;
 b=dGcD8EfPMoQWuD363bAU7Hl6tKjhjTAD55Kw7yl8UJ5bn6GpmPbEQ5LcJle8Y9JBrDzk5iiD75kxMV4xipiH3S/pP8AkkEyImmsBuSz7gDC+oFygUM5q/42ysU+xftbZSWs237nfv51T/+wOqV73bQ9REciHhTgevUBd+B5sudE=
Received: from BN9PR03CA0476.namprd03.prod.outlook.com (2603:10b6:408:139::31)
 by DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 29 Jan
 2021 21:28:27 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::99) by BN9PR03CA0476.outlook.office365.com
 (2603:10b6:408:139::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:25 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:18 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:17 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/27] drm/amd/display: implement support for DID2.0 dsc
 passthrough
Date: Fri, 29 Jan 2021 16:27:40 -0500
Message-ID: <20210129212752.38865-16-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cadac0a3-648f-444e-0622-08d8c49cd01d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38497E614F5BC9F452BD4969EBB99@DM6PR12MB3849.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqeqAbysaJCyVBO6aWQuPyj0/pUtCyeSzf3uzeyieM9vCbYUyI6bpikn+yYKvm5+Oo9aLdHf8zPq8Tqdhlk+Xe+BmMCCsxBmBVWeZ7EPrjt1VCOxq1u0wjfaEF2RJX2JFFgpzUQewF1e07jqP/VSnfH2emU+PaH9zBL0czLzymK192Xozsbsac88Tmnxx9kyZAlXbJflXevBMzvY+5nd0D5max/V2QlgpZfkIkjQEYKA9JSbRD8ypfwyKlQZ5dKYA7fhAzFl5uZwKNjFnf/gFn7GUP/Axdo7PQ8jiH+6kbGtCULui6xSgekDj8+CkjRMRw997BWBSfafuhBJHiPA+8kT8HnPTGnnWfh01zIkOtXTxpBvbWoye227kTsNjZBdyLWARZ/qjCfp+mRJoRaI1XrwFLlVocDjNTSnTbyGtFh+5S4GtZ/Y8Wrotj7RwC7cMbymbVdQHp3HgnuraeBt147XHfTklRWA5pVY57LYvS6jpQ9f7trX+NeeJsE6MrhHO3l4RXmchtmkzcuw3XIU8rDaxz3+Rtz32aBCiTAL3qw9WgdDyp2uDaf2iikDL+LE85NE0lgWM5/ly7X8CFC3H70zrD/A6m9/QLEtlNWQamE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(82740400003)(6916009)(2906002)(478600001)(336012)(70586007)(5660300002)(426003)(36756003)(356005)(70206006)(83380400001)(6666004)(1076003)(81166007)(86362001)(26005)(8936002)(4326008)(47076005)(82310400003)(316002)(2616005)(8676002)(186003)(54906003)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:25.7980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cadac0a3-648f-444e-0622-08d8c49cd01d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3849
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Wenjing
 Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <jun.lei@amd.com>

[Why]
Some panels contain active converters (e.g. DP to MIPI) which only support
restricted DSC configurations.  DID2.0 adds support for such displays to
explicitly define per timing BPP restrictions on DSC.  Ignoring these
restrictions leads to blackscreen.

[How]
Add parsing in DID2.0 parser to get this bpp info.
Add support in DSC module to constraint target bpp based
on this info.

Signed-off-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dsc.h      |  7 +++--
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h |  1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c  | 29 ++++++++++++--------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index ec55b77727d5..e99273bff46d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -51,6 +51,7 @@ struct dc_dsc_policy {
 	int min_slice_height; // Must not be less than 8
 	uint32_t max_target_bpp;
 	uint32_t min_target_bpp;
+	uint32_t preferred_bpp_x16;
 	bool enable_dsc_when_not_needed;
 };
 
@@ -62,8 +63,8 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
 bool dc_dsc_compute_bandwidth_range(
 		const struct display_stream_compressor *dsc,
 		uint32_t dsc_min_slice_height_override,
-		uint32_t min_bpp,
-		uint32_t max_bpp,
+		uint32_t min_bpp_x16,
+		uint32_t max_bpp_x16,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_bw_range *range);
@@ -78,7 +79,7 @@ bool dc_dsc_compute_config(
 		struct dc_dsc_config *dsc_cfg);
 
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
-		uint32_t max_target_bpp_limit_override,
+		uint32_t max_target_bpp_limit_override_x16,
 		struct dc_dsc_policy *policy);
 
 void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index b41e6367b15e..09e8be5f7a1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -769,6 +769,7 @@ struct dc_crtc_timing {
 #endif
 
 	struct dc_crtc_timing_flags flags;
+	uint32_t dsc_fixed_bits_per_pixel_x16; /* DSC target bitrate in 1/16 of bpp (e.g. 128 -> 8bpp) */
 	struct dc_dsc_config dsc_cfg;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index c62d0eddc9c6..82a805088204 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -369,6 +369,11 @@ static bool decide_dsc_target_bpp_x16(
 		/* enough bandwidth without dsc */
 		*target_bpp_x16 = 0;
 		should_use_dsc = false;
+	} else if (policy->preferred_bpp_x16 > 0 &&
+			policy->preferred_bpp_x16 <= range.max_target_bpp_x16 &&
+			policy->preferred_bpp_x16 >= range.min_target_bpp_x16) {
+		*target_bpp_x16 = policy->preferred_bpp_x16;
+		should_use_dsc = true;
 	} else if (target_bandwidth_kbps >= range.max_kbps) {
 		/* use max target bpp allowed */
 		*target_bpp_x16 = range.max_target_bpp_x16;
@@ -545,7 +550,7 @@ static bool setup_dsc_config(
 		int target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		int min_slice_height_override,
-		int max_dsc_target_bpp_limit_override,
+		int max_dsc_target_bpp_limit_override_x16,
 		struct dc_dsc_config *dsc_cfg)
 {
 	struct dsc_enc_caps dsc_common_caps;
@@ -564,7 +569,7 @@ static bool setup_dsc_config(
 
 	memset(dsc_cfg, 0, sizeof(struct dc_dsc_config));
 
-	dc_dsc_get_policy_for_timing(timing, max_dsc_target_bpp_limit_override, &policy);
+	dc_dsc_get_policy_for_timing(timing, max_dsc_target_bpp_limit_override_x16, &policy);
 	pic_width = timing->h_addressable + timing->h_border_left + timing->h_border_right;
 	pic_height = timing->v_addressable + timing->v_border_top + timing->v_border_bottom;
 
@@ -865,8 +870,8 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc, const uint8_t *dpcd_dsc_basic_da
 bool dc_dsc_compute_bandwidth_range(
 		const struct display_stream_compressor *dsc,
 		uint32_t dsc_min_slice_height_override,
-		uint32_t min_bpp,
-		uint32_t max_bpp,
+		uint32_t min_bpp_x16,
+		uint32_t max_bpp_x16,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_bw_range *range)
@@ -883,10 +888,10 @@ bool dc_dsc_compute_bandwidth_range(
 
 	if (is_dsc_possible)
 		is_dsc_possible = setup_dsc_config(dsc_sink_caps, &dsc_enc_caps, 0, timing,
-				dsc_min_slice_height_override, max_bpp, &config);
+				dsc_min_slice_height_override, max_bpp_x16, &config);
 
 	if (is_dsc_possible)
-		get_dsc_bandwidth_range(min_bpp, max_bpp, &dsc_common_caps, timing, range);
+		get_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16, &dsc_common_caps, timing, range);
 
 	return is_dsc_possible;
 }
@@ -895,7 +900,7 @@ bool dc_dsc_compute_config(
 		const struct display_stream_compressor *dsc,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		uint32_t dsc_min_slice_height_override,
-		uint32_t max_target_bpp_limit_override,
+		uint32_t max_target_bpp_limit_override_x16,
 		uint32_t target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_config *dsc_cfg)
@@ -908,11 +913,11 @@ bool dc_dsc_compute_config(
 			&dsc_enc_caps,
 			target_bandwidth_kbps,
 			timing, dsc_min_slice_height_override,
-			max_target_bpp_limit_override, dsc_cfg);
+			max_target_bpp_limit_override_x16, dsc_cfg);
 	return is_dsc_possible;
 }
 
-void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t max_target_bpp_limit_override, struct dc_dsc_policy *policy)
+void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t max_target_bpp_limit_override_x16, struct dc_dsc_policy *policy)
 {
 	uint32_t bpc = 0;
 
@@ -967,13 +972,15 @@ void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t
 		return;
 	}
 
+	policy->preferred_bpp_x16 = timing->dsc_fixed_bits_per_pixel_x16;
+
 	/* internal upper limit, default 16 bpp */
 	if (policy->max_target_bpp > dsc_policy_max_target_bpp_limit)
 		policy->max_target_bpp = dsc_policy_max_target_bpp_limit;
 
 	/* apply override */
-	if (max_target_bpp_limit_override && policy->max_target_bpp > max_target_bpp_limit_override)
-		policy->max_target_bpp = max_target_bpp_limit_override;
+	if (max_target_bpp_limit_override_x16 && policy->max_target_bpp > max_target_bpp_limit_override_x16 / 16)
+		policy->max_target_bpp = max_target_bpp_limit_override_x16 / 16;
 
 	/* enable DSC when not needed, default false */
 	if (dsc_policy_enable_dsc_when_not_needed)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
