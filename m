Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A249C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 03:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4D221548
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 03:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hh9LQezi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4D221548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6346E5D5;
	Tue, 22 Sep 2020 03:17:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFDD06E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 03:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvMp+hwDD32fBeABZBXwlKgEiSARztzWbef47lRILN8hxWtApa5mEYDfYtenozqg6fttU/QmipTMK33Wq6R8WhCrSa/iaAvABmAcZbzmSHTZlCr7bB40ICEe+zA0x9rLRsFyEvB/gDCZalLoP3zmtOoJybh6U4rQLdrybkoqHpFFz4QgPnHfaHjKGO0n3J15Z4AB+UdLD7dIy6Vd5N5NZblufNL7w0/zNNIgwLZJI0KjVt0hseDZ/CCIULAN85fFEx8xHGAeqlZvhZoBfLqI35R6Sp7z1YREsYILfUS20Guw15zcSP1DGDaJyyKlJ0BxantBDZsFH0HY8+HW0tYCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzg6FjDwjLxVXMJJXEHVn30EWScikbI4DYiWxaPQ+gE=;
 b=XJ4WdzncBTCT8fHKt9riEYuf6FBp7C979AVwT3wdfTHhWsk4XT7ghJJV9u5vHlDHTb42qLNYJNOO2drrMNLBbGmUSirPahdKMQLdZrsQgHnFqDXiLKpqpArB6zeABSsHs2Efi77r6CZ6VZUjvb0cX5GbGJfGnBbKiQ9sqsEkfVCMYfKuDumisKD+w8qOqBirWrVkLl1S1DdzUqsVX+XpR2jCeMADSmwD1h3bI/q0MByeha1SaEPMV5bPB5Yvj5HFSYkFe2HArTIgTvXOe40IrGByGqAwSsjfuCbgvoU4TG5HzZKtB4L74NpK9xhlNLAJ2h7XoHbNjZTBHMiHGTmYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzg6FjDwjLxVXMJJXEHVn30EWScikbI4DYiWxaPQ+gE=;
 b=hh9LQeziINFsCM9nL52nGGI8IhfnAw1eGGOpeetHdh++fKtbLN65C1PqAqF31268IKS4gjPkije4KNOaYB95yyUTFCbABjAc7WvU1HlIgCQt9aPshClbK7KNIXpXaRrlTiVQONdZxnS/VhEyBOXEuiQvdG/FRh/4Ec9c0EHU/Jw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.24; Tue, 22 Sep
 2020 03:17:17 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::4956:743a:1fbe:e0d1]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::4956:743a:1fbe:e0d1%11]) with mapi id 15.20.3391.024; Tue, 22 Sep
 2020 03:17:17 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Date: Tue, 22 Sep 2020 11:16:53 +0800
Message-Id: <20200922031653.1332062-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:202::12) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR0302CA0002.apcprd03.prod.outlook.com (2603:1096:202::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.7 via Frontend Transport; Tue, 22 Sep 2020 03:17:16 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 995180e6-a1da-49a1-4ab7-08d85ea6027c
X-MS-TrafficTypeDiagnostic: MW3PR12MB4428:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB442802653E6EE477055FB643EF3B0@MW3PR12MB4428.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIYHPUaUFEL73z/RbtwOgGzmcpu+87RWNObdIpNijmsrsoZQJngVlJUwzRD7+5vVY/HHmh3WqyholleMOma9hxRKnrOO31wzk2s0zV72EoDNUBQoZGrTsdtDHszkQLfjJngzKGiyBHdYzWrfwADFhxVeN0GrkuuQs2RZW6i32Y5tx/lGGehhhk596rjkTh1c1IC4vt9mBZ25CKrjwlQAlcIGqaB424mVIkTAmHbzPejetZlYuBXgpKyIr9gYda3De1zwxsrOtRq97sCQre51n4RoyyXIkNN+CVWOGH0Fl1nPXoom06364Y/a7tMtayKJJY4wnIxNSY4jPslZ5zSabvtIVDi5XIQl3x+3/jR8H+lTc4u9Ez/oHW2jPyglWQUx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(26005)(186003)(8676002)(52116002)(7696005)(6666004)(4326008)(86362001)(16526019)(6486002)(83380400001)(15650500001)(2906002)(316002)(8936002)(54906003)(478600001)(36756003)(5660300002)(2616005)(956004)(1076003)(44832011)(66556008)(66476007)(6916009)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1FcHa6Yh8+p4/0/VvaXw19RcaVYd6g4Iya80bIKb71DEsD05tvSuZiqxOMNFwGE/GOZGcBtGaJcQgkY96dLpHCgxl42iJADjxG8rB/B8tfKdBKXiDgXnq0fB/MDFHn0r2J/ItwLkS54uuudKuQWh5phAUSP8aVOpLUWadgIe0ZRI3On2Ta5Xbnw8jhash7Abte6DIML2pv3TYjluIeUCPl8Yc6Zee/CgiDsJCCuhIA6dpXvfTxMB29E6Ww5foQMLRs7xuKJq1DzNiuK1GsNychqekLd1WLKGy31aErSfOa7qofS/GunuayY2830m6tzYUCRxGgbjiseUUWnhoFHFMo1p/69RZlQ16Sx/G25hK041zOhhblOHPBtnYflrh1iAI66mr34SWviO5p6HXzJ3VK+UA2EJsZsrXCVXd8qL+nVvnvqVDlNjd+J2jzdSvcQdFdUB8Bnwebsm/2tdk1Au0pEyCPMs5sWJK9xKwgjEexLY5995v+j4NZZvteNBsaNmCo0xUuoZ9FPPvE7NpcsKjgr2wALiJCsdstba7GM1zUa+qSvNZ4N5uMgd1bJ/FuXK2+ruazhwnlbMPtkK/h9oQC3aczXMd4G/whSXcH/OxSIQE/rpS0Wz6e3pOTqlzoR+PCxN2oH0QFbzkO9qEJFVkw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995180e6-a1da-49a1-4ab7-08d85ea6027c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 03:17:17.4986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdzGSKIN4rqcs9hYq/VykQzIhPGrbiXc1xqHFJfFA/yHUzFzoiNMP1e3NDlf+dch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
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
Cc: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update driver if file for sienna cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I295edda90d156c4cea742e62fab696afb6cd1366
---
 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h | 4 ++--
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index 11a6cf96fe0c..1275246769d9 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if 
 // any structure is changed in this file
-#define SMU11_DRIVER_IF_VERSION 0x37
+#define SMU11_DRIVER_IF_VERSION 0x39
 
 #define PPTABLE_Sienna_Cichlid_SMU_VERSION 6
 
@@ -962,7 +962,7 @@ typedef struct {
   uint8_t                FanLinearPwmPoints[NUM_OD_FAN_MAX_POINTS];
   uint8_t                FanLinearTempPoints[NUM_OD_FAN_MAX_POINTS];
   uint16_t               MaxOpTemp;            // Degree Celcius
-  uint16_t               Padding_16[1];
+  int16_t                VddGfxOffset;         // in mV
   uint8_t                FanZeroRpmEnable;
   uint8_t                FanZeroRpmStopTemp;
   uint8_t                FanMode;
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 7ae83df83edb..03198d214bba 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x37
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x39
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
 
 /* MP Apertures */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
