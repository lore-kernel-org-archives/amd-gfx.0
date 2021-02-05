Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD08C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E454364F95
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E454364F95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A500F6F503;
	Fri,  5 Feb 2021 22:03:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2B36F501
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ0Hlx4j8mdWICmODL1YzpZLH5CfN+k6KQ7iz/XOfRJrOHi3MMd8Op6ZYyVkjQpeqLey6Da6B6VDdD1w02j9l7GR0dQ/sFqK/BnqwZSX8Q3lXa6+TybF3tiNLvD+w3RriNU61G4e9o7XelPtegk8qvEXxXngAMdpTkp/MmnZ1l5MMZvc2lGq3/YKqxGi0KBOVZ3TkAcJ59+YzwiB96BtZvP4VZpOdvOwzyi5Z4LWN1TUUAE0uLXY5aeTaNp6wrxQygfOXU1N6Bad8B3iGXzAEuYMsNWXUMKpp3wnP6QLh/Po2JnqzjCWXrbHIIMc60lREXDvBGucg5TMiglFYYdqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2171HpSri3oMK/twO++DcjGvRJc9wR8Z7wlaB3VwOJg=;
 b=TUHTBrTtkLrpKBItBimF44Oj3SlMvNyGqDIXAZh04+O9Afj5vJ65f1q2X5eLB564TUODFlWkc6tSPBQHxaYAACVtS6+mdpSw8doq/Pog3O5L1hataZZJYRmO0IlutZ7dW0TdeDKdboocT84nEyOiRc2igHqqL1bwuTSExjlbSukwnfSKIscl02OjIgbrpXHRIDBhZrbMy7W2q0LS0PfIXbUFhe7mtrhiztaobhkNnfB9o57IAcSRugzhKI5cv+wiVyQJDrHoRptwYuL5Q9plLzJvmqObbZGT//sOGs7ZfRgxR2Sksgxn7hWkLvgtbK5jCerTwxzEHFu/V8WCvoiBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2171HpSri3oMK/twO++DcjGvRJc9wR8Z7wlaB3VwOJg=;
 b=sps+zi6rm5Jf1q6SIzWCcxsmkYrkskaRBUWY5AshfqLh93RNAdAOQUezM1cbNKb8EXqSf5G+KUb8go6SOROxu4ROGyoH5D+Bp3ZXJ30ZhVBaLuFkTZNXG+sATtdiK9XpRxp5ARcNSP+sy/nud2gXW+4mzNRxeC1hbodH/GvzCBQ=
Received: from MW4PR03CA0008.namprd03.prod.outlook.com (2603:10b6:303:8f::13)
 by MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 5 Feb
 2021 22:03:10 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::87) by MW4PR03CA0008.outlook.office365.com
 (2603:10b6:303:8f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23 via Frontend
 Transport; Fri, 5 Feb 2021 22:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 5 Feb 2021 22:03:08 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:02 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 16:03:01 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amd/display: Add DIG_CLOCK_PATTERN in the
 transmitter control
Date: Fri, 5 Feb 2021 17:02:41 -0500
Message-ID: <20210205220250.1871069-3-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205220250.1871069-1-Anson.Jacob@amd.com>
References: <20210205220250.1871069-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d26ceb8-fae8-43ff-0370-08d8ca21d27b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3949:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39494742D10451AD31EA8F5CEBB29@MN2PR12MB3949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+bAmg1vZPwKNb+tx8MS//F8WT/SntZArKXfZILR+RYnX/9Zj0uzzGQF2hMZlchAV3o7wmcoTakSzf+rALL+l8RPf3dDILabRg67MpjZBQl4L91Rn7h3grAVpTBXE5Wr9u/WhuGWcDT4xX7UnB8EOwVZ3zFyRp+lULbzHYI0peIf8T8GrqT3rWpb9Yl91KhauKDuXEUlIOpyOEdRMohh6yeE8Z6jPCusom77AUhpJs3/NJ4AqP25KU872bK9z5iWr8eVozlyuKnYgt6OrBN0WomcZJ1CrHFH14Sbs/wthzJqWAz7KM7b2IqPZJna394Z/EYMgbrQpBeTtLkPkV4evcLBN66xzwvMf480jmz5C5Wsq5CM0t9DMawRJL4USFh5+IGNa7ZiWlICN6bUTdLy9rBqxZTFg0GxybeFcV04FpBJ+5lvXZBmF3LkgibtLw+SZCIB1tZfv7G+pY7J0vtWPyK2wXMUoetthSK/rGILvTeNGatjowfhO1K72bGnFnlOjA/AEQdBca3Nkbv+Ku2oMW2lggBeHeo2GIEgjTKnrcABniRyPhw4ZhDu1QwZeU0wFeTHSGAcGPKrEIXgsN7+yopy2rrW804RYFPQEuCJG1x8tOEy0tFR8RW4XXt7NkXVkZA3wt6ew4s2/WBeJVfE8b2u+Ry78Ni/AVTg400xX5xa1cIfTGWHH72N//vlUW6H
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(2616005)(316002)(54906003)(6916009)(5660300002)(356005)(2906002)(4326008)(36756003)(82310400003)(8676002)(8936002)(86362001)(26005)(81166007)(70586007)(478600001)(36860700001)(83380400001)(186003)(1076003)(426003)(6666004)(47076005)(7696005)(336012)(82740400003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:03:08.5254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d26ceb8-fae8-43ff-0370-08d8ca21d27b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Derek Lai <Derek.Lai@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Derek Lai <Derek.Lai@amd.com>

[Why and How]
VBIOS program DIG_CLK_PATTERN using engine ID instead of PHY ID.
Workaround by writing value for 0x1f (for HDMI) after calling vbios.

Signed-off-by: Derek Lai <Derek.Lai@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 15 +++++++++++++++
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h | 11 +++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.c |  2 +-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index 81db0179f7ea..59024653430c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -956,6 +956,21 @@ void dcn10_link_encoder_enable_tmds_output(
 	}
 }
 
+void dcn10_link_encoder_enable_tmds_output_with_clk_pattern_wa(
+	struct link_encoder *enc,
+	enum clock_source_id clock_source,
+	enum dc_color_depth color_depth,
+	enum signal_type signal,
+	uint32_t pixel_clock)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+	dcn10_link_encoder_enable_tmds_output(
+		enc, clock_source, color_depth, signal, pixel_clock);
+
+	REG_UPDATE(DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, 0x1F);
+}
+
 /* enables DP PHY output */
 void dcn10_link_encoder_enable_dp_output(
 	struct link_encoder *enc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
index d4caad670855..3e1a582e4b88 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.h
@@ -42,6 +42,7 @@
 #define LE_DCN_COMMON_REG_LIST(id) \
 	SRI(DIG_BE_CNTL, DIG, id), \
 	SRI(DIG_BE_EN_CNTL, DIG, id), \
+	SRI(DIG_CLOCK_PATTERN, DIG, id), \
 	SRI(TMDS_CTL_BITS, DIG, id), \
 	SRI(DP_CONFIG, DP, id), \
 	SRI(DP_DPHY_CNTL, DP, id), \
@@ -83,6 +84,7 @@ struct dcn10_link_enc_hpd_registers {
 struct dcn10_link_enc_registers {
 	uint32_t DIG_BE_CNTL;
 	uint32_t DIG_BE_EN_CNTL;
+	uint32_t DIG_CLOCK_PATTERN;
 	uint32_t DP_CONFIG;
 	uint32_t DP_DPHY_CNTL;
 	uint32_t DP_DPHY_INTERNAL_CTRL;
@@ -168,6 +170,7 @@ struct dcn10_link_enc_registers {
 	LE_SF(DIG0_DIG_BE_CNTL, DIG_HPD_SELECT, mask_sh),\
 	LE_SF(DIG0_DIG_BE_CNTL, DIG_MODE, mask_sh),\
 	LE_SF(DIG0_DIG_BE_CNTL, DIG_FE_SOURCE_SELECT, mask_sh),\
+	LE_SF(DIG0_DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, mask_sh),\
 	LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
 	LE_SF(DP0_DP_DPHY_CNTL, DPHY_BYPASS, mask_sh),\
 	LE_SF(DP0_DP_DPHY_CNTL, DPHY_ATEST_SEL_LANE0, mask_sh),\
@@ -218,6 +221,7 @@ struct dcn10_link_enc_registers {
 	type DIG_HPD_SELECT;\
 	type DIG_MODE;\
 	type DIG_FE_SOURCE_SELECT;\
+	type DIG_CLOCK_PATTERN;\
 	type DPHY_BYPASS;\
 	type DPHY_ATEST_SEL_LANE0;\
 	type DPHY_ATEST_SEL_LANE1;\
@@ -536,6 +540,13 @@ void dcn10_link_encoder_enable_tmds_output(
 	enum signal_type signal,
 	uint32_t pixel_clock);
 
+void dcn10_link_encoder_enable_tmds_output_with_clk_pattern_wa(
+	struct link_encoder *enc,
+	enum clock_source_id clock_source,
+	enum dc_color_depth color_depth,
+	enum signal_type signal,
+	uint32_t pixel_clock);
+
 /* enables DP PHY output */
 void dcn10_link_encoder_enable_dp_output(
 	struct link_encoder *enc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
index 15c2ff264ff6..fa013496e26b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
@@ -363,7 +363,7 @@ static const struct link_encoder_funcs dcn20_link_enc_funcs = {
 		dcn10_link_encoder_validate_output_with_stream,
 	.hw_init = enc2_hw_init,
 	.setup = dcn10_link_encoder_setup,
-	.enable_tmds_output = dcn10_link_encoder_enable_tmds_output,
+	.enable_tmds_output = dcn10_link_encoder_enable_tmds_output_with_clk_pattern_wa,
 	.enable_dp_output = dcn20_link_encoder_enable_dp_output,
 	.enable_dp_mst_output = dcn10_link_encoder_enable_dp_mst_output,
 	.disable_output = dcn10_link_encoder_disable_output,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
