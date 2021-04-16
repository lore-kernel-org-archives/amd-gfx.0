Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7599C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2AF610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2AF610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C05E6EB90;
	Fri, 16 Apr 2021 14:34:50 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700044.outbound.protection.outlook.com [40.107.70.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7B56EB90
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KteGK0uyITRabwwCIug+bmDe/asjWm86aqMzLGTO2APB93/MjXC8otQi7LeCrxVp0bz2pvGwS71Z2KxngjcO/hFgcImvIV8ifhqKC16OWMAe5bz9Z2nzvuM5jA1MnWiQdPuy+Djp+mKKj0aRGVWLJYtRFtX2Iir32LYbaAjLc+U8Fws0uAEHaZbco5YSxKVfovGTo4OomSHBQ8eh9i5Vo3FFzR16GDdXLlYIFbcPQjRB9TyMnznEbV6oX4Gad/qW5yyy/yCP56Ho/U4ldV7w1aFb+AT2Ntv/pcqKCvgtZpYe2zI6UvoMuu4amKQy8HGwc2wI3+DuHJkwcKN07k3jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Jr5x/2f/cUm5LhWfHkSTmESvCl417GXICd3/Ueex3M=;
 b=SLRrgI4VuBiLPkWJF7etpFXGQEFHpm5kMFUS+swDIPV+pJ03c8h9uSE/szl3R4oU1xEkdxh7oS1JC17sbSWW917W25tgabaPUCWlap4DwyGlVH7mxDW41LkEdEGpjVUrXuPoGo/Qj1Cij+qDCe1o2WPpC6GiaeuJmAMTOs2I7DUXLfFK2JzWdb4BngBl0cFMzhwAs4jvnWZGILr5GkGeumTlbFyjA9jaW5hnWwshme7DJoL5HEldLzU2b0I2bC7TwYmwkP1TXACBQmZwoObFzidBpLrpDjjHyIpx+nzXVel/DwKUC1hnnpqCN6ubgkTyRu5GkD3fW8bqTYYWCWKHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Jr5x/2f/cUm5LhWfHkSTmESvCl417GXICd3/Ueex3M=;
 b=mo9ANNAKyUGdWmiC0cCHw1hcuaFoLpPG5kDBaewbVrIZDeSQVJiYndnxyS7AHqpANE7rIvPKE5NHApiw6pQUCVWK6b5tJ2u51OyPNEBr8UDlbi1VWbAIgJBSe0xdzItgPimUK6WHnV8fNm5TYDZNCdcXLryQJ2yKlFfCM36qPWk=
Received: from BN0PR04CA0121.namprd04.prod.outlook.com (2603:10b6:408:ed::6)
 by CH2PR12MB3750.namprd12.prod.outlook.com (2603:10b6:610:14::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 14:34:47 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::15) by BN0PR04CA0121.outlook.office365.com
 (2603:10b6:408:ed::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:46 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:45 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/19] drm/amd/display: Report Proper Quantization Range in
 AVI Infoframe
Date: Fri, 16 Apr 2021 10:34:14 -0400
Message-ID: <20210416143417.611019-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c3e48fa-ceef-4742-5958-08d900e4c8ae
X-MS-TrafficTypeDiagnostic: CH2PR12MB3750:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3750EC6ED48B5E3B9FC8FBB28B4C9@CH2PR12MB3750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1HCyBYVejWrdHhjohQNLz1ynw21nHk3GCE/vKa90mdjAQnva4J6V9zbdEvhgZblo0r7FCeoYHCfjiXfSCDLW0gV9EGYlL3Trt17CMqF1pEBc3JKyfQRHfE1UHc0ph4Ly0um4QXj6Op/7JS6XASc2/PMNa8nbxUspHCszPQEZ5Rf/wNcauLxA1O9FcsaKdnvtj1M+gOR4swVLWz1Q3T0RKVLrTiW4NYTZqXwNhgc/tmuxG503cl12QugEYbkmaX1fDikvYtYpgumkl7rfYLkb2+8AMouyN6hpkOAmVTjLBMSthRdSx6rtH5tGMHO5JUByYtDsZjnpX/S3gtC8itkJ8aAybY2lABmCgh9X8sFnyvooo/UM0fp+Fvc4xJy1RuwOmRi6riWEhRh/zSxXy8DYjSC27gk5F0harkVMOvF+G4h4akc6Qmp8F6rCmmyGYeUphSXqRhNV4tFvi7/WJHMZRzaj6fHIarGv4ggFxv5jn1poWYxr2yXteTVp4Is8c30rNJK0UWZ85KdUsWAPvdgUHVBnuECqUe25pn/JdM5nCoLvF6F48+doXyHxia82xeHPDZhNwZ+3JQcSCMRY4ZMvBsZ+Ec09iQwsHbL09F8hSkhSxBZ70t+E8kLsLE9pyMbX4itDNhF+fdYzJC1ZzjYbYNdwB1VB3NcYqx8mhboGdNTdgHb72NQOyszD2+7V+NT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(426003)(36756003)(36860700001)(336012)(8676002)(5660300002)(81166007)(4326008)(8936002)(2906002)(70586007)(86362001)(7696005)(70206006)(47076005)(83380400001)(2616005)(356005)(316002)(26005)(54906003)(6916009)(186003)(1076003)(82310400003)(82740400003)(478600001)(44832011)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:46.8608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3e48fa-ceef-4742-5958-08d900e4c8ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3750
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
Cc: Dillon Varone <dillon.varone@amd.com>, Chris Park <Chris.Park@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[Why?]
When a monitor does not set both QS and QY bits, DC does not
set Q0, Q1, QY0 and QY1 bits in AVI infoframe. Setting RGB bits
should be separate from setting YCC bits.

[How?]
Separate logic for setting RGB and YCC quantization range bits
in the AVI infoframe.

Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ac7a75887f95..8cb937c046aa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2506,26 +2506,31 @@ static void set_avi_info_frame(
 		hdmi_info.bits.ITC = itc_value;
 	}
 
+	if (stream->qs_bit == 1) {
+		if (color_space == COLOR_SPACE_SRGB ||
+			color_space == COLOR_SPACE_2020_RGB_FULLRANGE)
+			hdmi_info.bits.Q0_Q1   = RGB_QUANTIZATION_FULL_RANGE;
+		else if (color_space == COLOR_SPACE_SRGB_LIMITED ||
+					color_space == COLOR_SPACE_2020_RGB_LIMITEDRANGE)
+			hdmi_info.bits.Q0_Q1   = RGB_QUANTIZATION_LIMITED_RANGE;
+		else
+			hdmi_info.bits.Q0_Q1   = RGB_QUANTIZATION_DEFAULT_RANGE;
+	} else
+		hdmi_info.bits.Q0_Q1   = RGB_QUANTIZATION_DEFAULT_RANGE;
+
 	/* TODO : We should handle YCC quantization */
 	/* but we do not have matrix calculation */
-	if (stream->qs_bit == 1 &&
-			stream->qy_bit == 1) {
+	if (stream->qy_bit == 1) {
 		if (color_space == COLOR_SPACE_SRGB ||
-			color_space == COLOR_SPACE_2020_RGB_FULLRANGE) {
-			hdmi_info.bits.Q0_Q1   = RGB_QUANTIZATION_FULL_RANGE;
+			color_space == COLOR_SPACE_2020_RGB_FULLRANGE)
 			hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
-		} else if (color_space == COLOR_SPACE_SRGB_LIMITED ||
-					color_space == COLOR_SPACE_2020_RGB_LIMITEDRANGE) {
-			hdmi_info.bits.Q0_Q1   = RGB_QUANTIZATION_LIMITED_RANGE;
+		else if (color_space == COLOR_SPACE_SRGB_LIMITED ||
+					color_space == COLOR_SPACE_2020_RGB_LIMITEDRANGE)
 			hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
-		} else {
-			hdmi_info.bits.Q0_Q1   = RGB_QUANTIZATION_DEFAULT_RANGE;
+		else
 			hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
-		}
-	} else {
-		hdmi_info.bits.Q0_Q1   = RGB_QUANTIZATION_DEFAULT_RANGE;
-		hdmi_info.bits.YQ0_YQ1   = YYC_QUANTIZATION_LIMITED_RANGE;
-	}
+	} else
+		hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
 
 	///VIC
 	format = stream->timing.timing_3d_format;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
