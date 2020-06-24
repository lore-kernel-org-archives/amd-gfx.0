Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA62C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 06:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC9F207DD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 06:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tuv41PpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC9F207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5926E7E2;
	Wed, 24 Jun 2020 06:36:03 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680058.outbound.protection.outlook.com [40.107.68.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB0A6E7E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 06:36:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpiKt8RzLV1oTU4DzA0lBDpxJyQAVIV494GDlAZ6nK9X8s5A8rFBP+3iYeUnsP5KDhmXDQ4V4LCnWH9KfLqEnzunekijlcSTenek2ukqXkedzfEAyM3VjR2IKfBexiydzqTbEFWvaY1E9bDK9hha0ccmKnMD/wEMxOKN4tZgfSdeiuYI/T+tmcxgkAvK0sjp0oGBEtGoLZWePrv74o39BqO38vPgigEdLmmW7Uu3VFbcNoX+wrwmLna/3tu9cokcYGevLp2cijSAZ+WjKGsCbuetjrQ4LaDhj7RcYOYwUAWe6xuvh+aLfuw87SY2MonddmVwFW6BQbv5+KetV0Y+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmdKBq90fb4Z3/NesayxXo1Ed4GqPUAaLe3CpfrY6Ng=;
 b=OrOlEpsj5GXW1B0z3ML5TACO+Np99uH6OujQFjERJACVg+Wy5FM+sjFU6P++VWuZV4WS5OhQAjiy33fGg4YZ0mDSR/2GFR8yk874N/0HcsdupGPnq0VtgA2YSwMkC6jVwhOaZOalXxSDTYA9n4altFqStaf5yg8AcLRTq3N24Es94vnJ7h+9TYRufjXDUD/ewPsq2SqrIuFyBNyXmGUlCDGT+ZU8BiSa5hImAbp8vq0a0FQVmheCY89YBJwSU+eo9+hG8b4spbEPu8Xkg8dOGmwoT0x3egW2B0YRCIHUlfN23/LuGmTNUQdbRrkrOEdaRfJWOWgiPYecFzjghfDygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmdKBq90fb4Z3/NesayxXo1Ed4GqPUAaLe3CpfrY6Ng=;
 b=tuv41PpYcf+Nujc3TE31RO7vc9snft7ArNJlfYPB4PyvBp6Nd9BjkCsiYJzphNpR28vuu8dC+h/D+bP9x4aveV7CUYgnf8PwyOIQIZ6BX6xNcDQ1bAOBJMxb8EUSA3bDjdQwf5jKCQuJsgpl/ND1sxEzfNIAAng/6xQdzL8qHYM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 06:36:00 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3109.027; Wed, 24 Jun
 2020 06:36:00 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: update driver if file for
 sienna_cichlid
Date: Wed, 24 Jun 2020 14:35:34 +0800
Message-Id: <20200624063534.1953945-2-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624063534.1953945-1-likun.gao@amd.com>
References: <20200624063534.1953945-1-likun.gao@amd.com>
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK0PR03CA0106.apcprd03.prod.outlook.com (2603:1096:203:b0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 06:35:58 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8689468-0c25-446e-fec8-08d81808dbbb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1599E2DADB6911ACC8320BDDEF950@MWHPR12MB1599.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9g1ovXH2YZZeKdtMpvReR0VvBuftHr9443rBXZyghz0FZ02amgKrydqL5G6xbCFTtxYfV4R+ZnwbqBXcctPRBSo5vML2o/aAFH63bQA2MetIlBQq+RM8uQMlPNLJ18dyAIrKTesfn3nMx0lblJcYQhSgXvE80bmXB+2rXcgTnlqzYZGOCDy06EFGElu33D+B3wtunU1ipPF5C++z7Q7T2+7Q9dA9XNWBxH+4uRsFCIhNBmswik59eSHplHP02+8zR9g0XCfVW+THblSKfOiY53ShfEkCgmdo+XUHKGjn6HW8eb7hh0YwAe2J2/OB5csf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(316002)(6666004)(54906003)(86362001)(36756003)(52116002)(2906002)(44832011)(2616005)(956004)(4326008)(7696005)(15650500001)(1076003)(186003)(16526019)(478600001)(26005)(5660300002)(6916009)(66556008)(6486002)(8676002)(83380400001)(66476007)(66946007)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: al8gF31M5JMNtw+BfmW3JHCyskJLAI/LjdjoHzdpuEcdThz+sL3VU3xshXWPpdOeuBpZj3pUIXvKXQoasiSYVnl6IFcGR8W2zLlebNqRi99cp+Azt9m7cQQ2XVa19iF7XJNnk9txGAJ1OdNWec695eepHTWtiBsF0lV3X1H33sEnt2X/pb4vtKVlzojxZWhjOsxwvfN0KddaPhLP+UQbh837/Zl3bu1az/9F6eY6TU58wCKgvJ1YrHgINJirPFhIHYDvM+9KuJFLFbEa668clQtxXp3d0dC44oh/w7AJpv1v8cuHekdi8ZnGME6todCUzi8+btOC73TwG1TwcddKX9rcZrn37Ha9eMah4Mq4GHtD15igzUTXLTEJzsYqdqaneQMIEw0LHqBJmZB1CflKPx4LastpnJncdlek6nbYQ9fIsO1Lmg/5dTNcfsESUndoiXwTnU5D9MBSuSqC4voYCVEfjVhj9MjR8/SgNwXKMRYdY7ijbRYfgkN3RR6sM7Wa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8689468-0c25-446e-fec8-08d81808dbbb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 06:36:00.1079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZEYL/1GiE5ibtrlxlkdgld+hFLZc7L2rHyULkvzPAsqWeKsKYUk4Qt8qi2U94gt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1599
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

Update sienna_cichlid driver if header file to match pptable changes.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Idcc081797f54509ea57503cce1dc915f718f189e
---
 .../powerplay/inc/smu11_driver_if_sienna_cichlid.h   | 12 ++++++++----
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h        |  2 +-
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c   |  7 +------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
index 5322f6da3071..302c2bcf9404 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if 
 // any structure is changed in this file
-#define SMU11_DRIVER_IF_VERSION 0x31
+#define SMU11_DRIVER_IF_VERSION 0x32
 
 #define PPTABLE_Sienna_Cichlid_SMU_VERSION 4
 
@@ -865,8 +865,7 @@ typedef struct {
   uint16_t     DfllGfxclkSpreadFreq;      // kHz
   
   // UCLK Spread Spectrum
-  uint8_t      UclkSpreadEnabled;   // on or off
-  uint8_t      UclkSpreadPercent;   // Q4.4
+  uint16_t     UclkSpreadPadding;
   uint16_t     UclkSpreadFreq;      // kHz
 
   // FCLK Spread Spectrum
@@ -896,8 +895,11 @@ typedef struct {
   uint8_t      VddqOffEnabled;
   uint8_t      PaddingUmcFlags[2];
 
+  // UCLK Spread Spectrum
+  uint8_t      UclkSpreadPercent[16];   
+
   // SECTION: Board Reserved
-  uint32_t     BoardReserved[15];
+  uint32_t     BoardReserved[11];
 
   // SECTION: Structure Padding
 
@@ -936,10 +938,12 @@ typedef struct {
   int16_t                OverDrivePct;         // %
   uint16_t               FanMaximumRpm;
   uint16_t               FanMinimumPwm;
+  uint16_t               FanAcousticLimitRpm;
   uint16_t               FanTargetTemperature; // Degree Celcius 
   uint8_t                FanLinearPwmPoints[NUM_OD_FAN_MAX_POINTS];
   uint8_t                FanLinearTempPoints[NUM_OD_FAN_MAX_POINTS];
   uint16_t               MaxOpTemp;            // Degree Celcius
+  uint16_t               Padding_16[1];
   uint8_t                FanZeroRpmEnable;
   uint8_t                FanZeroRpmStopTemp;
   uint8_t                FanMode;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 4fb911d8b49c..d07bf4fe6e4a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x31
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x32
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 693ad8963d0a..459a3c62e47b 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -2401,8 +2401,7 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 	dev_info(smu->adev->dev, "DfllGfxclkSpreadPercent = 0x%x\n", pptable->DfllGfxclkSpreadPercent);
 	dev_info(smu->adev->dev, "DfllGfxclkSpreadFreq = 0x%x\n",    pptable->DfllGfxclkSpreadFreq);
 
-	dev_info(smu->adev->dev, "UclkSpreadEnabled = 0x%x\n", pptable->UclkSpreadEnabled);
-	dev_info(smu->adev->dev, "UclkSpreadPercent = 0x%x\n", pptable->UclkSpreadPercent);
+	dev_info(smu->adev->dev, "UclkSpreadPadding = 0x%x\n", pptable->UclkSpreadPadding);
 	dev_info(smu->adev->dev, "UclkSpreadFreq = 0x%x\n", pptable->UclkSpreadFreq);
 
 	dev_info(smu->adev->dev, "FclkSpreadEnabled = 0x%x\n", pptable->FclkSpreadEnabled);
@@ -2447,10 +2446,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 	dev_info(smu->adev->dev, "BoardReserved[8] = 0x%x\n", pptable->BoardReserved[8]);
 	dev_info(smu->adev->dev, "BoardReserved[9] = 0x%x\n", pptable->BoardReserved[9]);
 	dev_info(smu->adev->dev, "BoardReserved[10] = 0x%x\n", pptable->BoardReserved[10]);
-	dev_info(smu->adev->dev, "BoardReserved[11] = 0x%x\n", pptable->BoardReserved[11]);
-	dev_info(smu->adev->dev, "BoardReserved[12] = 0x%x\n", pptable->BoardReserved[12]);
-	dev_info(smu->adev->dev, "BoardReserved[13] = 0x%x\n", pptable->BoardReserved[13]);
-	dev_info(smu->adev->dev, "BoardReserved[14] = 0x%x\n", pptable->BoardReserved[14]);
 
 	dev_info(smu->adev->dev, "MmHubPadding[0] = 0x%x\n", pptable->MmHubPadding[0]);
 	dev_info(smu->adev->dev, "MmHubPadding[1] = 0x%x\n", pptable->MmHubPadding[1]);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
