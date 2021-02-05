Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B29C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2815964F95
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2815964F95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E396F500;
	Fri,  5 Feb 2021 22:03:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC3D76F500
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izXG/p3P64iAQagXqd/s5T0KrIsVbUfViJBwZPYtLyxA71+T0q0R5ebDk91ghuE/DUbndY0LnXtRc1tKBiTlrIFu66VyJXRq631/W7ij0CHK9OGZ1jQGzNIkyLRJ9D7YdRmo9dKJJIVKSCLyNUbw4r3JZ1poh7h4RQBwMVef5JUAbFvtkGf+vjsuCbpe8DFVTA0jTSbrQhoV2+vCS3K3Mvss0ImXtkxFTXJ56wZdRqxu8Ao/sdIMsbLAFii6u7c8KYUzuN2YYhjkrdLfrKrBPDEbWezgPBaCtv/bYj1acTlFbnlxpmdyXgVOLtlGvuJB14e35x5muUabeJbdHmXiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y16/VdbPM/Km4ng+FuCG2cpL0yCCOOoAAZwd7lWiVnM=;
 b=DWqUrv8luxpRFgPUAff7oM5vTNdraHEqxEOfcXwZkA4iACl3ILQL/IOVJfNY60uMLN+dxaN0FMt5oHQAeAZvpvr52xt4PxhW8JFChXtJjbm9dlQf8nMk2dyd53/wdNYeAAfs6jpeVrcsnyM+OcyIaqHSj/cLZmTavZM0pL53XioBk1O0W1WmEYCNNQKwMGFxo9NHWXBI7BHanRSQhZlv9yemDrOmyk/IlW3y6OzobRzTpjWKT17vYRzpFB3oT2twbU5fnYsYX7UFP4v+FWMRciBUznw7OiRZlpliAnTujuqxufE9t5KEocD0aQ61lnkqlregtvRyaB5k2dbcoJ9D5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y16/VdbPM/Km4ng+FuCG2cpL0yCCOOoAAZwd7lWiVnM=;
 b=DWIrIT/QnCAg9NLwx2BTESC5d8Q7X1hmydwr6fnxyaAOhghBGgwTfO8+mzA3XKdh2OtcSxdzg8fShtcNJms/O9l2XdYrYqE/OmfNArpaqlfcT7NpadxI5cmzFjRfnUdtW6Lp3T8HArqxIPeNxN64oXu2CgmURWvmonDF/439cHw=
Received: from MW4PR03CA0029.namprd03.prod.outlook.com (2603:10b6:303:8f::34)
 by DM5PR12MB1930.namprd12.prod.outlook.com (2603:10b6:3:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Fri, 5 Feb
 2021 22:03:13 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::ec) by MW4PR03CA0029.outlook.office365.com
 (2603:10b6:303:8f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend
 Transport; Fri, 5 Feb 2021 22:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 5 Feb 2021 22:03:10 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:08 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 16:03:08 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/11] drm/amd/display: revert support for DID2.0 dsc
 passthrough
Date: Fri, 5 Feb 2021 17:02:43 -0500
Message-ID: <20210205220250.1871069-5-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205220250.1871069-1-Anson.Jacob@amd.com>
References: <20210205220250.1871069-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 827b71c5-fa66-44e9-3d2e-08d8ca21d3ea
X-MS-TrafficTypeDiagnostic: DM5PR12MB1930:
X-Microsoft-Antispam-PRVS: <DM5PR12MB193009D19746C7BAEACD15EEEBB29@DM5PR12MB1930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtdfvXeUbpxkpxF4KJ8JL0vh+v+iR5km/EjtD9DLtTmw8s/X5P6sYCRx0yz6R2s2sxJa8BAuT/hHV5Wy0TcZeLE3SV9Fz0iGnx6+9AqCtQVhb1CSWW/5BEX07Ubp72iOXwCI0pTtfXEXvt3wZVuWtsyvAS3HOIprYn0GjM534/6HweYxCq3e73gDgIrmOQetA+Hd/0Crtil2IhIGK1ur95RfeuE8yuzxjf62p/Lq3Ot1tR/jjkfoPHBnSVhF0ZTrZc2VqEqvlHtSwlmiu5VxHeRaweIntCSHVdt4C4OC1qjSFi0n+V6gx6pocPx2Om1Jcuj4eeLbdhJlXiNaEIz4UO0Yzl+98pAQp1HCQug81RCN/75kxJALR23bpQYzo4XwZ/0oP5xMkemeQr+pMY1r0+bk/7uYKmUKDHhK8oaXbSM2emTtc8GpPpVv32N++NlAi6G5hyrYvKYT/64BWbHhdfLYuJZpgz+b9nkS3suOQNC8GSr3MWAAB3kglCJ74onTqrBG7+gN0ueQIJrzLpZUtbTBjQqxgm2onl1idnXfyEqv0HqXsZzDcrH1XFcToMZSVBuieqe47VK/9xsT0VeLPPmcM/vwYQUy5v/aK3Id9mUePBK6mlydoXzOczLKBY3SS/wu74g06XZRu01nMpRcyTLU+HLNULB9WmokRELvPqO/s4gWgQoxDsSZQojL7Keb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(478600001)(26005)(426003)(1076003)(8676002)(8936002)(70586007)(7696005)(47076005)(36756003)(186003)(316002)(5660300002)(36860700001)(70206006)(356005)(54906003)(336012)(4326008)(83380400001)(2906002)(2616005)(6666004)(81166007)(86362001)(6916009)(82310400003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:03:10.9311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 827b71c5-fa66-44e9-3d2e-08d8ca21d3ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1930
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <jun.lei@amd.com>

revert commit 6777c3863cdacdce84347483015db10dcdd61607
"drm/amd/display: implement support for DID2.0 dsc passthrough"

3x4K60 displays over MST with DSC enabled was not able to light up
due to this patch.

Signed-off-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dsc.h      |  7 ++---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h |  1 -
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c  | 29 ++++++++------------
 3 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index e99273bff46d..ec55b77727d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -51,7 +51,6 @@ struct dc_dsc_policy {
 	int min_slice_height; // Must not be less than 8
 	uint32_t max_target_bpp;
 	uint32_t min_target_bpp;
-	uint32_t preferred_bpp_x16;
 	bool enable_dsc_when_not_needed;
 };
 
@@ -63,8 +62,8 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
 bool dc_dsc_compute_bandwidth_range(
 		const struct display_stream_compressor *dsc,
 		uint32_t dsc_min_slice_height_override,
-		uint32_t min_bpp_x16,
-		uint32_t max_bpp_x16,
+		uint32_t min_bpp,
+		uint32_t max_bpp,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_bw_range *range);
@@ -79,7 +78,7 @@ bool dc_dsc_compute_config(
 		struct dc_dsc_config *dsc_cfg);
 
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
-		uint32_t max_target_bpp_limit_override_x16,
+		uint32_t max_target_bpp_limit_override,
 		struct dc_dsc_policy *policy);
 
 void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 09e8be5f7a1e..b41e6367b15e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -769,7 +769,6 @@ struct dc_crtc_timing {
 #endif
 
 	struct dc_crtc_timing_flags flags;
-	uint32_t dsc_fixed_bits_per_pixel_x16; /* DSC target bitrate in 1/16 of bpp (e.g. 128 -> 8bpp) */
 	struct dc_dsc_config dsc_cfg;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 82a805088204..c62d0eddc9c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -369,11 +369,6 @@ static bool decide_dsc_target_bpp_x16(
 		/* enough bandwidth without dsc */
 		*target_bpp_x16 = 0;
 		should_use_dsc = false;
-	} else if (policy->preferred_bpp_x16 > 0 &&
-			policy->preferred_bpp_x16 <= range.max_target_bpp_x16 &&
-			policy->preferred_bpp_x16 >= range.min_target_bpp_x16) {
-		*target_bpp_x16 = policy->preferred_bpp_x16;
-		should_use_dsc = true;
 	} else if (target_bandwidth_kbps >= range.max_kbps) {
 		/* use max target bpp allowed */
 		*target_bpp_x16 = range.max_target_bpp_x16;
@@ -550,7 +545,7 @@ static bool setup_dsc_config(
 		int target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		int min_slice_height_override,
-		int max_dsc_target_bpp_limit_override_x16,
+		int max_dsc_target_bpp_limit_override,
 		struct dc_dsc_config *dsc_cfg)
 {
 	struct dsc_enc_caps dsc_common_caps;
@@ -569,7 +564,7 @@ static bool setup_dsc_config(
 
 	memset(dsc_cfg, 0, sizeof(struct dc_dsc_config));
 
-	dc_dsc_get_policy_for_timing(timing, max_dsc_target_bpp_limit_override_x16, &policy);
+	dc_dsc_get_policy_for_timing(timing, max_dsc_target_bpp_limit_override, &policy);
 	pic_width = timing->h_addressable + timing->h_border_left + timing->h_border_right;
 	pic_height = timing->v_addressable + timing->v_border_top + timing->v_border_bottom;
 
@@ -870,8 +865,8 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc, const uint8_t *dpcd_dsc_basic_da
 bool dc_dsc_compute_bandwidth_range(
 		const struct display_stream_compressor *dsc,
 		uint32_t dsc_min_slice_height_override,
-		uint32_t min_bpp_x16,
-		uint32_t max_bpp_x16,
+		uint32_t min_bpp,
+		uint32_t max_bpp,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_bw_range *range)
@@ -888,10 +883,10 @@ bool dc_dsc_compute_bandwidth_range(
 
 	if (is_dsc_possible)
 		is_dsc_possible = setup_dsc_config(dsc_sink_caps, &dsc_enc_caps, 0, timing,
-				dsc_min_slice_height_override, max_bpp_x16, &config);
+				dsc_min_slice_height_override, max_bpp, &config);
 
 	if (is_dsc_possible)
-		get_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16, &dsc_common_caps, timing, range);
+		get_dsc_bandwidth_range(min_bpp, max_bpp, &dsc_common_caps, timing, range);
 
 	return is_dsc_possible;
 }
@@ -900,7 +895,7 @@ bool dc_dsc_compute_config(
 		const struct display_stream_compressor *dsc,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		uint32_t dsc_min_slice_height_override,
-		uint32_t max_target_bpp_limit_override_x16,
+		uint32_t max_target_bpp_limit_override,
 		uint32_t target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_config *dsc_cfg)
@@ -913,11 +908,11 @@ bool dc_dsc_compute_config(
 			&dsc_enc_caps,
 			target_bandwidth_kbps,
 			timing, dsc_min_slice_height_override,
-			max_target_bpp_limit_override_x16, dsc_cfg);
+			max_target_bpp_limit_override, dsc_cfg);
 	return is_dsc_possible;
 }
 
-void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t max_target_bpp_limit_override_x16, struct dc_dsc_policy *policy)
+void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t max_target_bpp_limit_override, struct dc_dsc_policy *policy)
 {
 	uint32_t bpc = 0;
 
@@ -972,15 +967,13 @@ void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t
 		return;
 	}
 
-	policy->preferred_bpp_x16 = timing->dsc_fixed_bits_per_pixel_x16;
-
 	/* internal upper limit, default 16 bpp */
 	if (policy->max_target_bpp > dsc_policy_max_target_bpp_limit)
 		policy->max_target_bpp = dsc_policy_max_target_bpp_limit;
 
 	/* apply override */
-	if (max_target_bpp_limit_override_x16 && policy->max_target_bpp > max_target_bpp_limit_override_x16 / 16)
-		policy->max_target_bpp = max_target_bpp_limit_override_x16 / 16;
+	if (max_target_bpp_limit_override && policy->max_target_bpp > max_target_bpp_limit_override)
+		policy->max_target_bpp = max_target_bpp_limit_override;
 
 	/* enable DSC when not needed, default false */
 	if (dsc_policy_enable_dsc_when_not_needed)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
