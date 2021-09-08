Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615CFC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DDF360724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DDF360724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E506E1E0;
	Wed,  8 Sep 2021 14:55:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE226E1E0
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbshIJ+WT4RV14mzD3Xfaps9w4UMuSnolrSaakmSBqJ+ZaCi0N2xDaTjYs7zjAWA88QAaa43UL+Uy0Bj/dNQRUjBiuxEmM8HfLYdrlrrk6A55T1tKu731tIv55noEBOhwQbAKtUMCgFN566bdlieI8H6kEoKZ+iD1JOqT2bToO+6Zrs6N+o3mcvUMYb7m3CwkC3R6+rnBPQy4Jfr140nPdi7XDJFHzg9TOObSaW7zeV5XBaFgrMslJf8SHUjQxpdPnen3Xqg09IQOr25BpcBl5zNfz+2yysTOwVG4OrI04f//IF3/g7MPyZWLhbVPFLvm6U0Tx/X39pse0+7yY9+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/zzL4qr5mtf/VCfgcYyo1KrhxT9bQW/CJpjQxnHtm7U=;
 b=CWJYOS1ywAOFPLYn4OhZBImLD0RUyT6Fms1/JEouHTZfkHqR1a8L8JhP3btWyVoHz39Pd+mfFiPGv2BgRvQVL/zpx+ACrOOmRzHt4EJzhonB895O7K/o2Srk5IRjYd0iy1syhFcYUckoNvsQ5OjfP3UCdsxvaZOkx92yP6NWRc/WCrAjXDftyKuQlyCIRqSk+B4SNIEnJI2W3ykK0Wi/No7pkYqhXw7hdn5JZdxBECtHGPylL8oL4aZzatf0hcV5P2Ka1mV/rssbl3Vmf2L03RwiUZD7dzUoBHJCyVDBKC4a/j+ugTKaak+jwf83sQ3DhO0i9wtUEszHz+VlCmdMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zzL4qr5mtf/VCfgcYyo1KrhxT9bQW/CJpjQxnHtm7U=;
 b=Nj3A9R/i8GKzREN0ifz9JrEv2pJ2jWYyRJAjjm6q5jZArr/Wf+L8cOliZMhsPnt1pIbPQiloLNwivZnbHUzXDk4CiQ1Kl5cFVBeqYi4rXMJTBlUMGUc6GzXu9TBEYLMwqIqjR67+qkWLHSt/PDWmuG2rBYCLQ320kBzEuQNY+vk=
Received: from DM6PR13CA0046.namprd13.prod.outlook.com (2603:10b6:5:134::23)
 by BN6PR12MB1892.namprd12.prod.outlook.com (2603:10b6:404:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 14:54:58 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::2a) by DM6PR13CA0046.outlook.office365.com
 (2603:10b6:5:134::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:57 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:56 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Jaehyun Chung
 <jaehyun.chung@amd.com>, Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Subject: [PATCH 18/33] drm/amd/display: Add regamma/degamma coefficients and
 set sRGB when TF is BT709
Date: Wed, 8 Sep 2021 10:54:09 -0400
Message-ID: <20210908145424.3311-19-mikita.lipski@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4e7eab4a-8246-4e01-6236-08d972d8a082
X-MS-TrafficTypeDiagnostic: BN6PR12MB1892:
X-Microsoft-Antispam-PRVS: <BN6PR12MB189210470353A5B8650190A4E4D49@BN6PR12MB1892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6Jwvrh0QKbRJMAtlaO/CLUJUMPENAw5T4BVC5GyCswHvTnIt5CUAHZBeXyg8WOFYGPodocnYvLsF0LxgBIc33vYhVDdddiZ8z7MTXFERp2h858jNFw8wDjRYgVbOdapTjEGCK/749cDW6Osg6JlYOg0JnkDEI+CwPF/Sv0RMyahjzRBsyPaNgtmzYunwdMTf2xLrzpiahuiY87Tcf1nHUr//V8FSslR9o+hvb9Y0sQFm76CUsg+CloRZRwYKFAZSvKQ4ipj/U/whUCepSKmUMmQlueMlk73/g1S1evg8jF+UUA5Y0ZttqDSGaU6Rn72jOLmAUwm89W7zYpAkUzL+87UKvfjoIjVnnDR88T0suWQ8Pg6awVipQIMd3J4ARCiVlNwHGwB8JsEa2Xg4lOhAtqlQbtTPTci1zYzIKB6aRW9gd4aL0MdX6KZVF6nNFcl63PrhEfafTrfNxWkbh0V2ZmMM5eFkt/wK4TnTTFePpS9RSNiB7NesvFtbeStiOMMwgIrnm87ePHpF/HPCQOchqvyf+jHZMnZ8hi9OLNagst3W3OkDH847Yg4F1PhY4GZmXG/Jy6H8Dnf8Zb2Nnhs7VJ6VcYl745BD4oA2YDkKveCFCI+jDvaHsgnfyC7jPl7fMoj5uR5vWFVaTXk+G0q/lRXTnC3z9BMSemwumbmZJKbt6TaVGNV4TkVYj1BVF9+AlQp/Z5aXS9RiD4fc6qCsEMlaGSlG1PnuxoogtJWF5Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(82310400003)(356005)(8676002)(6666004)(26005)(8936002)(2616005)(47076005)(44832011)(336012)(186003)(16526019)(426003)(1076003)(54906003)(81166007)(70206006)(70586007)(83380400001)(86362001)(508600001)(4326008)(2906002)(6916009)(36860700001)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:57.9988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7eab4a-8246-4e01-6236-08d972d8a082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1892
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

