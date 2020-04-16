Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE51C2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D30321841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yv7gdFhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D30321841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146126E312;
	Thu, 16 Apr 2020 23:41:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B026E222
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeqYLIruvMt6ZvTju1GvxsUuy0XmySImG3DxwkwHFOzjZsg8l+zQQH8YkCJtGZkmNdsd46x3zK6Srg+H+fxEipQv+/B761Yxz3EPcDr3oFxeowlQxiLchjH4gbnwRwGG9FDUJ/goJbYqFco3rLsg5bR7lX3fwmb+yyjEJM1kvroHYgqmEwRp+YNl5UjzXJgupBjkbYEZODdwjxCrDUxxyVUVZmJZbfuuNdoAkiG0TPAbONXkQG8mEK6czUQzB3Soi7LNSiHKt1aQvhg9Zphw7ytDuxD6+63SflCyjH/XE5hbChvKPd4ns5NFR9Xc7aKB0zso1Id+gR5PuO2sz/JcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4QluWWivq8cCEH2XwbYFtXgie3Vtln2U4gKx6RLwOo=;
 b=BTzbbPWoNLMQJaZnRov6yxrq6XFe/yfgiKnUWfPgS3EKvl6CUH3bxnpeaodqQHNA85vYG+oJE+5UflLT7eIG8dYmxKy+4sNHgHGyzxidCK9fBbd1lpiclhRvYgvb9eWuJ4o3UQboG1I5oLReQeabmcQ6QZIQCLkyJ9B8PraWJ17be3gKwFbr/TibRgtHL01JZeuOUmzFIX0t4mspN/6D1ynsr+8dq3aKlg/3bVTSqDsQtfVnPxAWsF1R3mxZ6+AINpuFL6avQQjgsbL+omE+z/8wZf64Yxg8pL0SjNgMATzSCem/8v45QrlkQALUoPil1gXqSm2DauSdfkZqFD/8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4QluWWivq8cCEH2XwbYFtXgie3Vtln2U4gKx6RLwOo=;
 b=yv7gdFhck77x28YbmiDD45BHrGvLizRabk6XzKZfuQvMbHtiTeIlKsOI87HOkPOV3n4trHW1AEkuN+RmsCoyINhVXJ3OeveJbw9ujk2/RCoNc4cx1iHWIzv2gyBJAIKC/D0+Bk7VMamGjOfsNoikgMzlWpzcCNfSFforZcl+ePM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:33 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:33 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/35] drm/amd/display: Use the correct input TF for video
 formats
Date: Thu, 16 Apr 2020 19:40:26 -0400
Message-Id: <20200416234044.2082886-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:31 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d436dd64-cc35-4bf1-f81e-08d7e25fb1ca
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24594B7E746C49B3609DD32E98D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6pjfC7wewr9zVb19j9MQgqHf6aB01ooa+asLu1/mkH4/NkaXUNfS1Et9MZjzNcpyo7V7VPLAluMxSDCFunqOVB63IqcAzj3IH3ryXpqxlygp+rNUAK14nQl3X5kqssfh8YmSdG7ug/awjTPU9US8oRJ4Fb5XKPgB2DlL3aNLg8Ljb5Xt1t9ZZFXDYhQ22Bsmf0VkhZacUFCPoR2DePdy/ObNYeJpb7KScNu+HRb8gSVablrm9R+HsAirXyRQRbLLA51TCq/Xw9TgWYVzNKJjXaU8VuS3kBf3yskjp8Fwh0reecQeWC25yfsIh3YkmaF/MtDUCjewc2WYD6wmCJc9nMywepsQxTRirG5wIUPskcPm6gX5+sa3TteK2QPSOjQj+2Lv4kWgMu2AaaQhF7Hz+dLiyPo6IrDMBEy4YvRql4Re1RRJwWyLysjrYM8Jgno
X-MS-Exchange-AntiSpam-MessageData: oIF2Xn4S0k1bfGTJbS8mRJH5kUzbT2Gli5afSnFNqogXVTIBL4r+0tPPp1ZKmIhYl37QXNLyoEBTwwILgdmEpiRNjLKFX/eRD06emahy3XjYEqEOvlm2xFf3TyS492HbbP7B92Z5r/Zqe1QWm0+sy4y3tqk85TD4bvSOakwLdcM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d436dd64-cc35-4bf1-f81e-08d7e25fb1ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:33.1332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RNlAfYfR7cWPqNW+KJj6s3HNfzFCq1ty2MuYgeoHWssxiAFh820q3z8Fi9EHVxHYb9qSgVLiZ6leOWC2Ke1Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Zhan Liu <Zhan.Liu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Color blending for NV12 formats is incorrect because we're using the
predefined SRGB degamma.

[How]
Calculate the correct input transfer function for degamma from the color
module depending on what the actual surface format is.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 6b58761e4b04..d0554082f0dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -420,9 +420,21 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 {
 	const struct drm_color_lut *degamma_lut;
 	struct dc_plane_state *dc_plane_state = plane->dc_state;
+	enum dc_transfer_func_predefined tf = TRANSFER_FUNCTION_SRGB;
 	uint32_t degamma_size;
 	int r;
 
+	/* Get the correct base transfer function for implicit degamma. */
+	switch (dc_plane_state->format) {
+	case SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr:
+	case SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb:
+		/* DC doesn't have a transfer function for BT601 specifically. */
+		tf = TRANSFER_FUNCTION_BT709;
+		break;
+	default:
+		break;
+	}
+
 	if (crtc->cm_has_degamma) {
 		degamma_lut = __extract_blob_lut(crtc->base.degamma_lut,
 						 &degamma_size);
@@ -456,8 +468,7 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 		 * map these to the atomic one instead.
 		 */
 		if (crtc->cm_is_degamma_srgb)
-			dc_plane_state->in_transfer_func->tf =
-				TRANSFER_FUNCTION_SRGB;
+			dc_plane_state->in_transfer_func->tf = tf;
 		else
 			dc_plane_state->in_transfer_func->tf =
 				TRANSFER_FUNCTION_LINEAR;
@@ -472,7 +483,12 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 		 * in linear space. Assume that the input is sRGB.
 		 */
 		dc_plane_state->in_transfer_func->type = TF_TYPE_PREDEFINED;
-		dc_plane_state->in_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
+		dc_plane_state->in_transfer_func->tf = tf;
+
+		if (tf != TRANSFER_FUNCTION_SRGB &&
+		    !mod_color_calculate_degamma_params(
+			    dc_plane_state->in_transfer_func, NULL, false))
+			return -ENOMEM;
 	} else {
 		/* ...Otherwise we can just bypass the DGM block. */
 		dc_plane_state->in_transfer_func->type = TF_TYPE_BYPASS;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
