Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE74C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85BD61104
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B85BD61104
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C57D16E1F9;
	Wed,  8 Sep 2021 14:55:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1806E1D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNF459rWs+/CB5E8IVI6UeTFjKKkqCNOZek+352eA2MfR294fwe5L184UwS6V459a1z54DgMDWIh5pRCQoeE+zMdARsSIt3iY5SD2mUo9hYQAZxQvdRfLdX0UjjeHbMNH6oEREXzDHDRjJwjExFxPhJGrcli7GJQQTs2+U6+vYhXPkP9DWClP1TjgvlyAOoz/sfl6p/kFgdpng3V9zVC5wpxe63UIab/ESTlbL1/gcy7PN5vbDcl0XYvlGUU11dZ9coI4fgAQRatqoLzKu8UMpy2VCYzPlg51ZbHGafNVt9erIwSPTa7FvF9wIA2ruEwlcmgifycOzslDZlUTd9RvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=A9LYfyA3CU6SEV6BHkfKtVX9gQJcvvVawdZL0NGWswk=;
 b=TLrEiRdA84NP/1rMFgOrFq/RpHrrbDqlLqXMZOKuZh0Ezj7QGXHXrl3rs6j3zlNk/e/zT7IaQSzDzRIqTLlKTwRvCzuu8I4iVUeiZgD91uBnFEZDIUsCniBH7l5LIr6mWYJYjjX0HdQrWd1ibB/yZjBjkumpnIgaSjXGRhnRNpHEvKo2nofR8nAa4quhAeRk9TYZGpaVJX+mrQfDTJQU++UVw9Vj23HtlTomAr0FebvN+WRicuyEJnz0rWC9qc6IKY1UDZxRv29I9srsf9/lFx8JEPpJa4YTlMsIXK3GoiceNrIXMXoDP8MaLqX1wWa4esxM7KWn18rRWMOzMdSzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9LYfyA3CU6SEV6BHkfKtVX9gQJcvvVawdZL0NGWswk=;
 b=30z9avXXpI7ugaH6YcoD2p5+Dlk+GBDSeUvBS2KdmboR6e6J5Izkc5KbOgvCjOri9XMDzlaAAEJ/NlZMZ/8uiIFbuFsaa6oUEh0G6IxKWLoHKHt1Qi3T39kb8TuAOWyVFk2wjLVtAFXkAz3PVelqKOU0/mwgN4H6KZFP2vOFPaA=
Received: from BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::7)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Wed, 8 Sep
 2021 14:55:12 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::91) by BN9P220CA0002.outlook.office365.com
 (2603:10b6:408:13e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22 via Frontend
 Transport; Wed, 8 Sep 2021 14:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:55:12 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:55:10 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Jaehyun Chung
 <jaehyun.chung@amd.com>, Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Subject: [PATCH 30/33] drm/amd/display: Revert adding degamma coefficients
Date: Wed, 8 Sep 2021 10:54:21 -0400
Message-ID: <20210908145424.3311-31-mikita.lipski@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e487c7b0-b563-42ff-78ce-08d972d8a8db
X-MS-TrafficTypeDiagnostic: MN2PR12MB4095:
X-Microsoft-Antispam-PRVS: <MN2PR12MB409535D9F93EA75BB9EA872DE4D49@MN2PR12MB4095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mi30jor+H54whqqFbf5DtTmuXbcll1sRvU15M67nsv2QCOnR1cLEFbcbJzavESyviJ6R/faih7hq2ntEQ8IlVCYrE03mW7OuED3uGZKvz4n28Sq3V+zEUeJ9/SpQnsTpXlAk2atxzDXeaMmvOMXfuAFs66ehoNgFjSfbxwW9MOgyi4hglXHqHFvZgOb6QPUHYtHG16X+HkNJ4/HNTg3cxEu2AIQ6lhET+BZVmgGD4UhErBGpBQIRr/tjNF9jRn7fmMQd25l5wJPuRSSwNIibdAVFa5lqy8y8QpNLioUnHxXAQwQ/T8D4N7itFZBXlGinNjfxCfN18bewD5MG+qr/CdIyh2Xkg03a1HgZiEqBfAxmxdnPTES3ztFXBuytsUhnmv+IFPEQeeQbowfBv2QAdlQADDTETzPKSo4n8Svs54CQVkKA0By8LaXePFWuZTm8j15MzSVwHW9YcybTUBV/s9k3DSJI8yM5K/uzFrgLLD1nEYChnTaSsR5X1M1w03F91l1z9dHQZNvMhl7PiX6Lx9MlpixNZ/8X4BwGz0PLxkAbbOM1RsTlTO0C6FdI2jban9fiK2ynrKNEQ7of6tqNPdJS/CRu4zqsUNW7vUMbE0Y5AivIgmUZ23QrYXYSkhBkwrptS7x9EPmvQKy2V2PA1yMlQvLyA4J0P9hnmHKlZu2zP6esT+4fRdo18DDCHqTpT0BYwpYqDqxuWGR4t/VjTXtWCXo1J2hPjjsrGaVQyNw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(186003)(5660300002)(478600001)(44832011)(8676002)(82740400003)(54906003)(356005)(82310400003)(26005)(6916009)(316002)(81166007)(2906002)(6666004)(36860700001)(8936002)(426003)(70206006)(2616005)(47076005)(70586007)(1076003)(16526019)(336012)(86362001)(83380400001)(36756003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:55:12.0654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e487c7b0-b563-42ff-78ce-08d972d8a8db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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
Degamma coefficients are calculated in our degamma formula using
the regamma coefficients. We do not need to add separate degamma
coefficients.

[How]
Remove the change to add separate degamma coefficients.

Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
---
 .../amd/display/modules/color/color_gamma.c   | 64 ++++++++-----------
 1 file changed, 25 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 2465c88e2879..64a38f08f497 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -54,18 +54,17 @@ static struct hw_x_point coordinates_x[MAX_HW_POINTS + 2];
  * just multiply with 2^gamma which can be computed once, and save the result so we
  * recursively compute all the values.
  */
-											 /*sRGB     709     2.2 2.4 P3*/
-static const int32_t regamma_numerator01[] = { 31308,   180000, 0,  0,  0};
-static const int32_t regamma_numerator02[] = { 12920,   4500,   0,  0,  0};
-static const int32_t regamma_numerator03[] = { 55,      99,     0,  0,  0};
-static const int32_t regamma_numerator04[] = { 55,      99,     0,  0,  0};
-static const int32_t regamma_numerator05[] = { 2400,    2200,   2200, 2400, 2600};
-
-static const int32_t degamma_numerator01[] = { 404500,  180000, 0,  0,  0};
-static const int32_t degamma_numerator02[] = { 12920,   4500,   0,  0,  0};
-static const int32_t degamma_numerator03[] = { 55,      99,     0,  0,  0};
-static const int32_t degamma_numerator04[] = { 55,      99,     0,  0,  0};
-static const int32_t degamma_numerator05[] = { 2400,    2200,   2200, 2400, 2600};
+
+/*
+ * Regamma coefficients are used for both regamma and degamma. Degamma
+ * coefficients are calculated in our formula using the regamma coefficients.
+ */
+									 /*sRGB     709     2.2 2.4 P3*/
+static const int32_t numerator01[] = { 31308,   180000, 0,  0,  0};
+static const int32_t numerator02[] = { 12920,   4500,   0,  0,  0};
+static const int32_t numerator03[] = { 55,      99,     0,  0,  0};
+static const int32_t numerator04[] = { 55,      99,     0,  0,  0};
+static const int32_t numerator05[] = { 2400,    2200,   2200, 2400, 2600};
 
 /* one-time setup of X points */
 void setup_x_points_distribution(void)
@@ -295,7 +294,7 @@ struct dividers {
 
 
 static bool build_coefficients(struct gamma_coefficients *coefficients,
-		enum dc_transfer_func_predefined type, bool isRegamma)
+		enum dc_transfer_func_predefined type)
 {
 
 	uint32_t i = 0;
@@ -318,29 +317,16 @@ static bool build_coefficients(struct gamma_coefficients *coefficients,
 	}
 
 	do {
-		if (isRegamma) {
-			coefficients->a0[i] = dc_fixpt_from_fraction(
-				regamma_numerator01[index], 10000000);
-			coefficients->a1[i] = dc_fixpt_from_fraction(
-				regamma_numerator02[index], 1000);
-			coefficients->a2[i] = dc_fixpt_from_fraction(
-				regamma_numerator03[index], 1000);
-			coefficients->a3[i] = dc_fixpt_from_fraction(
-				regamma_numerator04[index], 1000);
-			coefficients->user_gamma[i] = dc_fixpt_from_fraction(
-				regamma_numerator05[index], 1000);
-		} else {
-			coefficients->a0[i] = dc_fixpt_from_fraction(
-				degamma_numerator01[index], 10000000);
-			coefficients->a1[i] = dc_fixpt_from_fraction(
-				degamma_numerator02[index], 1000);
-			coefficients->a2[i] = dc_fixpt_from_fraction(
-				degamma_numerator03[index], 1000);
-			coefficients->a3[i] = dc_fixpt_from_fraction(
-				degamma_numerator04[index], 1000);
-			coefficients->user_gamma[i] = dc_fixpt_from_fraction(
-				degamma_numerator05[index], 1000);
-		}
+		coefficients->a0[i] = dc_fixpt_from_fraction(
+			numerator01[index], 10000000);
+		coefficients->a1[i] = dc_fixpt_from_fraction(
+			numerator02[index], 1000);
+		coefficients->a2[i] = dc_fixpt_from_fraction(
+			numerator03[index], 1000);
+		coefficients->a3[i] = dc_fixpt_from_fraction(
+			numerator04[index], 1000);
+		coefficients->user_gamma[i] = dc_fixpt_from_fraction(
+			numerator05[index], 1000);
 
 		++i;
 	} while (i != ARRAY_SIZE(coefficients->a0));
@@ -853,7 +839,7 @@ static bool build_regamma(struct pwl_float_data_ex *rgb_regamma,
 	if (!coeff)
 		goto release;
 
-	if (!build_coefficients(coeff, type, true))
+	if (!build_coefficients(coeff, type))
 		goto release;
 
 	memset(cal_buffer->buffer, 0, NUM_PTS_IN_REGION * sizeof(struct fixed31_32));
@@ -1102,7 +1088,7 @@ static bool build_degamma(struct pwl_float_data_ex *curve,
 	uint32_t begin_index, end_index;
 	bool ret = false;
 
-	if (!build_coefficients(&coeff, type, false))
+	if (!build_coefficients(&coeff, type))
 		goto release;
 
 	i = 0;
@@ -1705,7 +1691,7 @@ static void apply_degamma_for_user_regamma(struct pwl_float_data_ex *rgb_regamma
 	struct pwl_float_data_ex *rgb = rgb_regamma;
 	const struct hw_x_point *coord_x = coordinates_x;
 
-	build_coefficients(&coeff, TRANSFER_FUNCTION_SRGB, true);
+	build_coefficients(&coeff, true);
 
 	i = 0;
 	while (i != hw_points_num + 1) {
-- 
2.25.1

