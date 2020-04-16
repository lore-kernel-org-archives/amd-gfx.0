Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D560C2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104F321841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="taBEd+gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104F321841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9E36E1EE;
	Thu, 16 Apr 2020 23:41:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7D76E1EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ng1TeVbW1g3plh6STHI8B30m+LPGfzIwpGlNN+9aKOLGY8Wdh86qmpYW68EKVjPN725h/88XQUixPPtOFAuK/eNlIXX4HwyD2kRHu21uy3PRld2Nh4oT0fdAKKaJCj9eGztabfrirrx91EoPkHPlI/ZpiwTaqcu17gWXNGgF7PhDmEf7dSZGLPLN1m0qNiyfYPfgvDwaDbMIW3luGivN7le8Wh3TSnPOQvhBfUiJZqyYJKBPhcMyq3oS932H7WY1+kHUEMPGDWAG+Y4BMoQz+EMxLcMxcvG3nh2nLFlszquZWb0obsdIFNo9NaRertRTDUG8bOVdeBr7IdGdlO3b/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/XRod90PL6/z+riCQibdZFUnUFf980WmdsnEJz1GxQ=;
 b=kdW7AYDKn8ib5KsGeks4XKrr7rBZEpGmx/yerJ+ngP3FrIi3GnkBCKdygVIQCA6o/bVWUvp8UysMq6yYuC1nkq21aYpc1awJPXjCdISmeXEGEtbCdx0fVQfKNI18Awfe0r2WqnP1sud4Twm2lSbaP0YOgJMOHzqkaHNrPnrUu1H3iMJF59jU09k5RQFscwUBYaZjJ9jQ7PVi/yMEQ2eNnHYwA8XLm0pPIafuxJ7RXC55LCu9or6lmqjvOA18WLvIhZONX5sGXE32Gk+pmHNKZOP3Ha28AzuLbmGchmwTPT5/JQysIYQrdDQFroks6SI3QWFT9YV6IseQ4lr+gbLb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/XRod90PL6/z+riCQibdZFUnUFf980WmdsnEJz1GxQ=;
 b=taBEd+gvzNWOMSaonMzsuyhVWqU7ZgaYpiL2W1gNDpfxJAMLpoo8j4w4XujGBSs7Mn1fQCUmSVIP/l5JY7sDL1S13SC1l7w2xa2v8GiIyozzw/W96VeUIxgdBzFp0Zu4jWtQAAQ2/W+6xYyWyuIhGjehTVK7puJLD5QQ8gvej64=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:27 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:27 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/35] drm/amd/display: Cast int to float before division
Date: Thu, 16 Apr 2020 19:40:22 -0400
Message-Id: <20200416234044.2082886-14-Rodrigo.Siqueira@amd.com>
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
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:25 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef4b1b5d-aaa4-4141-275e-08d7e25fae5f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459F2C4075672ECA57F1D9698D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
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
X-Microsoft-Antispam-Message-Info: eSWAstnVZp8hpwSmPj+0rPUNPs5sts0pV+T2Wy3wbt6mN+c21NakrE058RyAQgzot0nJ3NbYxQWaLXSu8PV9gS3lo4/yJAfuiWg9AIz+X2xcaYI7oZ/NKktOmUGyKdMpmVnOBngnWidKI6aAVNeAxm5Rv5C+SuHhXExlJQwPDzdUNbmP2GAbWxnnspJw4ILVLEx3nVdnI7NrqS/t0gBWTi6hMBsNXeXqB7TrVZsQ8r0bpr8g6W49/3k++23Xo/Ee1+m99ESiawUWbH3FKRkKwM0WHreHH80rrqJ5YSLoVh2VrtdqnL19abfaCscQTHRXn0UzCk97wpSySuC9AP910wQmWsLWUDAho9GM8uWGH+Iw4v74mcPpWiqWOz92wnoGsAr5+dmuDYVgkJIkJn7Mmdiz3fXCUmGUJdrFqC7syx2IktLAT/5n23BC4R9sTSa2
X-MS-Exchange-AntiSpam-MessageData: Qr4S+PzP62HZ5YLSHht2C/uijt2NOXSH28Dts20KPZjyWf/LoW50WpYV8uzsp3RFjIPX36ZaIzo/gDFRMTaAIdxY6zWkfza42WtzzFeyNlLI6HD9dsadx6PjSxKWuGrS9p6sy7AUzp0mMGWdMQPE0NxS04B+URgdgeeuXpFOHUA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4b1b5d-aaa4-4141-275e-08d7e25fae5f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:27.4235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1Ty96xaUVULtQVhbELfad4LZHB9f/rtFLIhICcBXd2DG9COm/1ps+t3SRk5lqCOCypFLAf5vHN7iNc4QxZsow==
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
Cc: Sung Lee <sung.lee@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[Why]:
Some inputs to dml_ceil have it dividied by int which causes a
truncation. This loss of precision means the ceil function becomes
redundant and does not round up.

[How]:
Cast parameter to float before division.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index e6617c958bb8..5bc80b6084da 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -5944,7 +5944,7 @@ static void CalculateMetaAndPTETimes(
 						* PixelPTEReqHeightY[k];
 			}
 			dpte_groups_per_row_luma_ub = dml_ceil(
-					dpte_row_width_luma_ub[k] / dpte_group_width_luma,
+					(float) dpte_row_width_luma_ub[k] / dpte_group_width_luma,
 					1);
 			time_per_pte_group_nom_luma[k] = DST_Y_PER_PTE_ROW_NOM_L[k] * HTotal[k]
 					/ PixelClock[k] / dpte_groups_per_row_luma_ub;
@@ -5968,7 +5968,7 @@ static void CalculateMetaAndPTETimes(
 							* PixelPTEReqHeightC[k];
 				}
 				dpte_groups_per_row_chroma_ub = dml_ceil(
-						dpte_row_width_chroma_ub[k]
+						(float) dpte_row_width_chroma_ub[k]
 								/ dpte_group_width_chroma,
 						1);
 				time_per_pte_group_nom_chroma[k] = DST_Y_PER_PTE_ROW_NOM_C[k]
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
