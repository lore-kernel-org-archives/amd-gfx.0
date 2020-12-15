Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A35C4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 15:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9B422571
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 15:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9B422571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3192289D1D;
	Tue, 15 Dec 2020 15:45:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F5489D1D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 15:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIHy3fmsFRUUV75GFVkNEXXn0zPLiZR+LgH2wdBjBOeUuta7EBrFBnGUHt+BoGs/w2ZQwuzIGDr+OfxtLWTMkzx0WN1riFnaIniRnjgQxgbq1FM6GN8q8znCliDUp224WXQX7IMtU7pGUjLETSsNaFU/nz4D7mdOATW5XmIFQPxL3RRl+f2280ynFx1mv7H1gw1pSSi46Lh5ohoRWlYy3ujHUlk5J+P6hNgxRdRqtEyi1TPD+DIsFvHMYBIKY8OXqB6Pv1PnJaVnTw6PVa6AUpoOivjmrsHCsaBq+qen83G2Zg8KXXw6vlbpVFw8C/AeW9f9qEtb4zDWMk170GNOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXIninq8gGQxjq9LfwAze12Vyw9d1u0NZsnD3lQd0oo=;
 b=hzPmNmjxNqqpw9/A3PVHVnHE91CtfQuyNoSzwbnrRcCUt9gHJqLcrdu1TabwwlHS+PkGjWv2II2CdYfOQCaiMYTo+frcHmANdlk0yhbhHywBuutsvIU1jzoOqkm5XYhomtdy+RJJBz2+Ewq7owsEfULNIUFduiv+LIFP4Zl1dM2gxhBY0rXFENiHS6hlmwwKZWB609fvioySvZA9nIITB7SXgOrS90dgPk9Zp7E7nDZL5dPsjDMsTlJ0vpoyAcWAkyeVKgZ2wV1QtlbvGHU0gsEJ75j48XZnkHq01MYU/ZbVu5tcKmv5x+E9aj4N51yfKd3g0Hrjaserjc/oQrHigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXIninq8gGQxjq9LfwAze12Vyw9d1u0NZsnD3lQd0oo=;
 b=iLJASVlvlEzL3AViqMljetNo/7FJt9QfIqRQRrp5h8Gnb6k64Nh/NeeZG7fQ+1VQWr322XkCre3QAbzZtMhcaDeQAoug5Kl5m7OlUcMpjmZqv5jAWPcoTLoUr5AywKgWPKxSbyhIq/DNBS8ejxE+PhWvukg3dk9k7FJ0iK7lnSI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Tue, 15 Dec
 2020 15:45:42 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 15:45:42 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Add get_dig_frontend implementation for DCEx
Date: Tue, 15 Dec 2020 10:45:05 -0500
Message-Id: <20201215154505.1321860-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [2607:fea8:56e0:6d60::bef5]
X-ClientProxiedBy: CH0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:610:b1::6) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::bef5) by
 CH0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:610:b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.15 via Frontend Transport; Tue, 15 Dec 2020 15:45:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d283ef4f-286f-402a-6075-08d8a1107af4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB41817F4FEBEA251E5181A4EA98C60@CH2PR12MB4181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:109;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmwXVAPkI/+IoGXqeOi9mwWWf3qR5H5bXx/GVG9htojC6W0bWCbIUM0fMQd+MQtXtPWESOLSLc0RyH1dFZiCt6TMNBsb/cuangFINYXQbyx7sMcpKrlyVIlvM8x/v+Kyfd9CmoaB+IlcpM6Ns3GJJoxGMFBkm9T5Yb3oh8juxO0qqXJ2Xjh+cMifWtRa8wxc16pOw58WEFX15pSWbUovM4g98p6JmiNz5UjS+EI0IoOgeL92W3FD8trB1aH/baxm6VIIW8qNr/Rglgt1Q5xHxj8y1WT0WXDvzfGpicFsZqh0LsxiCpkBdt/B8kajw1fKu2xZoHmj6kKD8hSIOIS6qtiF94osk62L6Kpf1ocQAsLh7DeYvMVDFj3uNVGXQCZS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(4326008)(2616005)(186003)(34490700003)(66476007)(36756003)(6666004)(66556008)(8676002)(16526019)(6486002)(6506007)(66946007)(508600001)(5660300002)(6512007)(1076003)(86362001)(52116002)(83380400001)(6916009)(8936002)(54906003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Uu+LQU0Io4tYIJc+Kc57TNiO2o5OS+mDx/uXSOpZKlnElPxHmEiJJizS8i1Q?=
 =?us-ascii?Q?2EwszjxNBTUNHdATHUfki1/gPVY4WEBIRmTm1Qj6kqQ3CiWENYZ40/vpOH03?=
 =?us-ascii?Q?NX0spzLKClnJx9V6fWD+9jYqSaqi7/3bo5WytqwMUBIhm/I2eTMbg3oT27Bs?=
 =?us-ascii?Q?25XNFAGNn3OgnjCTPEWmtxSm/qIMfGy+Uw6yxcBi7hhHl+D45dRbz3x9/QHA?=
 =?us-ascii?Q?8O/4FWGCTl8EFWlFZj8iuWrJKPV2jM1ErrIX8LK39fEFxjXQGI5Bip9NTKi0?=
 =?us-ascii?Q?pW82yBPRkRktBzM+nGluOEY143FCyvxGuaeazQhn0bJc+g3Qq7Te8JMED9qe?=
 =?us-ascii?Q?4E6lJyN0WLpKjgpn70PCToouyCwEQtrLflDlQZ4xCrS6a25l29IE4pq9aS/S?=
 =?us-ascii?Q?o/5lLfq0ltO3Ye3MKcQAW6GaaVE/4B8Ugy7CjpYAJ7hwb9HoJGusFdwBcN44?=
 =?us-ascii?Q?CY78yYJA2hdxugyL58UR1dlv3p1k2EMCh43JHWH8gWD7lYi+Cl+CNOFVaMHy?=
 =?us-ascii?Q?KsPDcdu34tyoNsE65G5+lWfHFZJkws46aRd8mrAA6XVg3DRj5nZkzUAZBHeE?=
 =?us-ascii?Q?N48ezrNHwbFeLJxmfnrtpNOv5c+rqPkaBqtYtPZDKP9iuhuzv6j9ch4SxW+w?=
 =?us-ascii?Q?RGIPcItPql8Hg+9/2FFj+Us4FbPQO7EY9Arx+5uBDOa1xnhxba1mTT61Xyn7?=
 =?us-ascii?Q?zGPQ/KO472BJJwYHZuwl7lEOZ9X3nQwpvVwgf2p4oJR7FLQWpiSF5A/N1IyA?=
 =?us-ascii?Q?5FXtGmYnZIgqcCnV21rsVaeuQXLdmNgrKj27a/yu53DgKvuaQc3ceTaN8VZZ?=
 =?us-ascii?Q?i0CoJfFO0YeEYhhmei5/Cwo39QnDJT/EP2PeyiY5dJ+98BdRGCMH3tAdlRPs?=
 =?us-ascii?Q?HYLkkG2HjjbSodMRXiMD3x2hJ2dQDoHpqQmr2DinMG0oziq3Pipq8qdtNwZF?=
 =?us-ascii?Q?7UuP0lsB5IM5oqpvwVPCVCAbKAIJ6ctY5OylgF9D54hq8dN7eyNw7YjFNDGr?=
 =?us-ascii?Q?sD2yEX35RnGeBVAMlgQC6evCRg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 15:45:42.6430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: d283ef4f-286f-402a-6075-08d8a1107af4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsXyC/k37whGPQagf7i2P9D4nKV0+wh6YOIYaY7JY3qEohHd2NC5kmJq4qgT79YCqeF6Wy83d6ZI9b8XilbtcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Chiawen Huang <chiawen.huang@amd.com>,
 Borislav Petkov <bp@alien8.de>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some old ASICs might not implement/require get_dig_frontend helper; in
this scenario, we can have a NULL pointer exception when we try to call
it inside vbios disable operation. For example, this situation might
happen when using Polaris12 with an eDP panel. This commit avoids this
situation by adding a specific get_dig_frontend implementation for DCEx.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Chiawen Huang <chiawen.huang@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 43 ++++++++++++++++++-
 .../drm/amd/display/dc/dce/dce_link_encoder.h |  2 +
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 4592ccdfa9b0..f355cd1e9090 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -120,6 +120,7 @@ static const struct link_encoder_funcs dce110_lnk_enc_funcs = {
 	.is_dig_enabled = dce110_is_dig_enabled,
 	.destroy = dce110_link_encoder_destroy,
 	.get_max_link_cap = dce110_link_encoder_get_max_link_cap,
+	.get_dig_frontend = dce110_get_dig_frontend,
 };
 
 static enum bp_result link_transmitter_control(
@@ -235,6 +236,45 @@ static void set_link_training_complete(
 
 }
 
+unsigned int dce110_get_dig_frontend(struct link_encoder *enc)
+{
+	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
+	u32 value;
+	enum engine_id result;
+
+	REG_GET(DIG_BE_CNTL, DIG_FE_SOURCE_SELECT, &value);
+
+	switch (value) {
+	case DCE110_DIG_FE_SOURCE_SELECT_DIGA:
+		result = ENGINE_ID_DIGA;
+		break;
+	case DCE110_DIG_FE_SOURCE_SELECT_DIGB:
+		result = ENGINE_ID_DIGB;
+		break;
+	case DCE110_DIG_FE_SOURCE_SELECT_DIGC:
+		result = ENGINE_ID_DIGC;
+		break;
+	case DCE110_DIG_FE_SOURCE_SELECT_DIGD:
+		result = ENGINE_ID_DIGD;
+		break;
+	case DCE110_DIG_FE_SOURCE_SELECT_DIGE:
+		result = ENGINE_ID_DIGE;
+		break;
+	case DCE110_DIG_FE_SOURCE_SELECT_DIGF:
+		result = ENGINE_ID_DIGF;
+		break;
+	case DCE110_DIG_FE_SOURCE_SELECT_DIGG:
+		result = ENGINE_ID_DIGG;
+		break;
+	default:
+		// invalid source select DIG
+		ASSERT(false);
+		result = ENGINE_ID_UNKNOWN;
+	}
+
+	return result;
+}
+
 void dce110_link_encoder_set_dp_phy_pattern_training_pattern(
 	struct link_encoder *enc,
 	uint32_t index)
@@ -1665,7 +1705,8 @@ static const struct link_encoder_funcs dce60_lnk_enc_funcs = {
 	.disable_hpd = dce110_link_encoder_disable_hpd,
 	.is_dig_enabled = dce110_is_dig_enabled,
 	.destroy = dce110_link_encoder_destroy,
-	.get_max_link_cap = dce110_link_encoder_get_max_link_cap
+	.get_max_link_cap = dce110_link_encoder_get_max_link_cap,
+	.get_dig_frontend = dce110_get_dig_frontend
 };
 
 void dce60_link_encoder_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
index cb714a48b171..fc6ade824c23 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
@@ -295,6 +295,8 @@ void dce110_link_encoder_connect_dig_be_to_fe(
 	enum engine_id engine,
 	bool connect);
 
+unsigned int dce110_get_dig_frontend(struct link_encoder *enc);
+
 void dce110_link_encoder_set_dp_phy_pattern_training_pattern(
 	struct link_encoder *enc,
 	uint32_t index);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
