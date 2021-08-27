Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE64C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2013960EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2013960EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EEE6E9C1;
	Fri, 27 Aug 2021 20:44:09 +0000 (UTC)
X-Greylist: delayed 864 seconds by postgrey-1.36 at gabe;
 Fri, 27 Aug 2021 20:44:07 UTC
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (unknown
 [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2F56E9C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcJLAEWX1Ic5RDfW0QK18Uku2T8PWMm8xt8ajJ36hryS8kIo/ZrXwYxTZ3l8z7/NqsasIIAb80HeKsb1hPN+mgjEIgwJEI+wTSGAAAfKAFQWSaeVlTryPl+x2DrZEKMeR/9q9pP/pcchoWL13sExpX2BnRXC3hZOzXILQGKaouTPMsJKRvtgr1G8hnGFpydYJcyGdd/5fPmKQINbgdcphbEvl8++J25vAcVlTk66F9YVziOqIjNMoripVuff28bspJV5YvzZF210oMLhpUyYodhOJKYAtcYlKojjITl6wZ3rwxaOHMW7gydZVtXM6lsa4jvZF7oFrvT+MGQ5VXqBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zzL4qr5mtf/VCfgcYyo1KrhxT9bQW/CJpjQxnHtm7U=;
 b=U4aQZ1KN8Aq1e4obQoYI7INJS0DbjHU8m+QnZCqeS7nbzWasCwXZmRxMve0t5sNGDzG5+1/2tnYxhIWigWF4Er1w2mYxu0nOFsygaONja6k8kLRcZThzBydjEKsCluK48JUhu6+XKPk/Obbq5MXqDertDNiDEMgkOLwsExrEgKWVKEwbTIdWl01esT+ZgDXwV4z/50p9UM6lE/+My4+I8puOWUeQp74ezTFtGyvTTE8QmTga2FwXuHM8cFVv3rPblQFTMS5NYkNU+xkaRCdWBq/UsHFCh6W+SKxm4vA6uX6HdSOuHLlO58vPbCJIkrJvOp6X1FnvPvgiqIgnBuezrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zzL4qr5mtf/VCfgcYyo1KrhxT9bQW/CJpjQxnHtm7U=;
 b=1YW3mtbWjiCKZDqhnMdQZfcfBlPWoyTyYaTovswtNC4miBSpr4XLz7Zng7hi+7yeVWVlkCceUai8YkBnZvsVd7+7w3Na2IAku5er0txaQZOxX17jpazTk04nPOXUVlDNSFHlQ5pLHn0M0aTMS7Wos3a0XIrionYIok6FgSO7XYs=
Received: from MWHPR15CA0051.namprd15.prod.outlook.com (2603:10b6:301:4c::13)
 by DM6PR12MB2875.namprd12.prod.outlook.com (2603:10b6:5:15c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Fri, 27 Aug
 2021 20:29:45 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::a8) by MWHPR15CA0051.outlook.office365.com
 (2603:10b6:301:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:45 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:44 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Jaehyun Chung <jaehyun.chung@amd.com>, Krunoslav Kovac
 <Krunoslav.Kovac@amd.com>
Subject: [PATCH 19/19] drm/amd/display: Add regamma/degamma coefficients and
 set sRGB when TF is BT709
Date: Fri, 27 Aug 2021 16:29:10 -0400
Message-ID: <20210827202910.20864-20-mikita.lipski@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84fe6349-806e-4cbb-71e9-08d9699968b8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2875:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2875B4B63AC21E96A7B609CEE4C89@DM6PR12MB2875.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcKO/FSd1IeUFk1RMp893xZMjsZhKboeGW8caUw7s2S9yMFrhXvcSyXUJhA7asPn2IxuUHU2f6324mHCh4yXGoholbM53s5oe0yFULtfwL8WNRLgsCBK9hfZISb/m/GHk0b5d8hDJCUbzc/06n7mJDrtO26B7zO+1wxYWtYzm6av4fpSaUTtm+E008TLFuejXWwxUHAuYxJgqRw5jgLwxvXK1fG2p4UuP8GaTnsgFTauepnU25NvPS0NRI5quZvuJWj/8RhTC/yLJUif6z3YOJL6oVpEtRtF33QB/cxlD/0EL4UnGrXoKS0vpqlHmHzV0n879lu3ZdeXkbooBLmJPeu9pNYhms+R0MFdtK7RbIs7cFOves7WZYvvJD99anYeqaaa2AeUZlbBHURE90AeYNswcDuLwM73Xfzvr3YtanIhgurZGq869B7Ld5uLLnQ2E0Z1d3GzUKa3g0mWeAeRYOl9daQbxqLXzyhjqWQFcX4bZaUk+HUvv+08sLqkkuW+9+xZpb0prJjB8izY39j9hyTrzQvVeRIS/RD9vyEUzaNEGpZF26Xr0vwa5+Q+n47IQLRZZUKOqsxrR04qwtte6HswFQBfDmBEPby5gb33neGNQlSzoPQVyhoU5lWSH0dHP+Ugki+e44xX+/C71dce9kyb0EMrP58C9tJQ+WgMT6GBw9313ZI6fUdm8i3SUFYBGhoaZ2ZgPitFv0546e5efcjmhTag43vijWeRtcx4a4I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(46966006)(44832011)(2616005)(47076005)(83380400001)(70206006)(8936002)(426003)(478600001)(70586007)(6666004)(4326008)(26005)(86362001)(82740400003)(36756003)(36860700001)(1076003)(82310400003)(54906003)(336012)(16526019)(186003)(2906002)(8676002)(316002)(6916009)(356005)(81166007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:45.5887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fe6349-806e-4cbb-71e9-08d9699968b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2875
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

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
In YUV case, need to set the input TF to sRGB instead of BT709,
even though the input TF type is distributed. SRGB was not
being used because pixel format was not being set in the
surface update sequence.
Also, we were using the same coefficients for degamma and
regamma formula, causing the cutoff point of the linear
section of the curve to be incorrect.

[How]
Set pixel format in the surface update sequence. Add separate
coefficient arrays for regamma and degamma.

Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
---
 .../amd/display/modules/color/color_gamma.c   | 60 ++++++++++++-------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index ef742d95ef05..275f11f8bea3 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -54,12 +54,18 @@ static struct hw_x_point coordinates_x[MAX_HW_POINTS + 2];
  * just multiply with 2^gamma which can be computed once, and save the result so we
  * recursively compute all the values.
  */
-										/*sRGB	 709 2.2 2.4 P3*/
-static const int32_t gamma_numerator01[] = { 31308,	180000,	0,	0,	0};
-static const int32_t gamma_numerator02[] = { 12920,	4500,	0,	0,	0};
-static const int32_t gamma_numerator03[] = { 55,	99,		0,	0,	0};
-static const int32_t gamma_numerator04[] = { 55,	99,		0,	0,	0};
-static const int32_t gamma_numerator05[] = { 2400,	2200,	2200, 2400, 2600};
+											 /*sRGB     709     2.2 2.4 P3*/
+static const int32_t regamma_numerator01[] = { 31308,   180000, 0,  0,  0};
+static const int32_t regamma_numerator02[] = { 12920,   4500,   0,  0,  0};
+static const int32_t regamma_numerator03[] = { 55,      99,     0,  0,  0};
+static const int32_t regamma_numerator04[] = { 55,      99,     0,  0,  0};
+static const int32_t regamma_numerator05[] = { 2400,    2200,   2200, 2400, 2600};
+
+static const int32_t degamma_numerator01[] = { 40450,   810000, 0,  0,  0};
+static const int32_t degamma_numerator02[] = { 12920,   4500,   0,  0,  0};
+static const int32_t degamma_numerator03[] = { 55,      99,     0,  0,  0};
+static const int32_t degamma_numerator04[] = { 55,      99,     0,  0,  0};
+static const int32_t degamma_numerator05[] = { 2400,    2200,   2200, 2400, 2600};
 
 /* one-time setup of X points */
 void setup_x_points_distribution(void)
@@ -288,7 +294,8 @@ struct dividers {
 };
 
 
-static bool build_coefficients(struct gamma_coefficients *coefficients, enum dc_transfer_func_predefined type)
+static bool build_coefficients(struct gamma_coefficients *coefficients,
+		enum dc_transfer_func_predefined type, bool isRegamma)
 {
 
 	uint32_t i = 0;
@@ -311,16 +318,29 @@ static bool build_coefficients(struct gamma_coefficients *coefficients, enum dc_
 	}
 
 	do {
-		coefficients->a0[i] = dc_fixpt_from_fraction(
-			gamma_numerator01[index], 10000000);
-		coefficients->a1[i] = dc_fixpt_from_fraction(
-			gamma_numerator02[index], 1000);
-		coefficients->a2[i] = dc_fixpt_from_fraction(
-			gamma_numerator03[index], 1000);
-		coefficients->a3[i] = dc_fixpt_from_fraction(
-			gamma_numerator04[index], 1000);
-		coefficients->user_gamma[i] = dc_fixpt_from_fraction(
-			gamma_numerator05[index], 1000);
+		if (isRegamma) {
+			coefficients->a0[i] = dc_fixpt_from_fraction(
+				regamma_numerator01[index], 10000000);
+			coefficients->a1[i] = dc_fixpt_from_fraction(
+				regamma_numerator02[index], 1000);
+			coefficients->a2[i] = dc_fixpt_from_fraction(
+				regamma_numerator03[index], 1000);
+			coefficients->a3[i] = dc_fixpt_from_fraction(
+				regamma_numerator04[index], 1000);
+			coefficients->user_gamma[i] = dc_fixpt_from_fraction(
+				regamma_numerator05[index], 1000);
+		} else {
+			coefficients->a0[i] = dc_fixpt_from_fraction(
+				degamma_numerator01[index], 10000000);
+			coefficients->a1[i] = dc_fixpt_from_fraction(
+				degamma_numerator02[index], 1000);
+			coefficients->a2[i] = dc_fixpt_from_fraction(
+				degamma_numerator03[index], 1000);
+			coefficients->a3[i] = dc_fixpt_from_fraction(
+				degamma_numerator04[index], 1000);
+			coefficients->user_gamma[i] = dc_fixpt_from_fraction(
+				degamma_numerator05[index], 1000);
+		}
 
 		++i;
 	} while (i != ARRAY_SIZE(coefficients->a0));
@@ -833,7 +853,7 @@ static bool build_regamma(struct pwl_float_data_ex *rgb_regamma,
 	if (!coeff)
 		goto release;
 
-	if (!build_coefficients(coeff, type))
+	if (!build_coefficients(coeff, type, true))
 		goto release;
 
 	memset(cal_buffer->buffer, 0, NUM_PTS_IN_REGION * sizeof(struct fixed31_32));
@@ -1082,7 +1102,7 @@ static bool build_degamma(struct pwl_float_data_ex *curve,
 	uint32_t begin_index, end_index;
 	bool ret = false;
 
-	if (!build_coefficients(&coeff, type))
+	if (!build_coefficients(&coeff, type, false))
 		goto release;
 
 	i = 0;
@@ -1685,7 +1705,7 @@ static void apply_degamma_for_user_regamma(struct pwl_float_data_ex *rgb_regamma
 	struct pwl_float_data_ex *rgb = rgb_regamma;
 	const struct hw_x_point *coord_x = coordinates_x;
 
-	build_coefficients(&coeff, TRANSFER_FUNCTION_SRGB);
+	build_coefficients(&coeff, TRANSFER_FUNCTION_SRGB, true);
 
 	i = 0;
 	while (i != hw_points_num + 1) {
-- 
2.25.1

