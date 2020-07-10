Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C987C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 03:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED73A2072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 03:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FwrLVPvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED73A2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5FF6E0D0;
	Fri, 10 Jul 2020 03:10:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6491D6E0D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 03:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ7dgtyzJ7L34K3Wu0q6EyODHAckuRIFb2UWAt4imzKPzCpIWiJDHhFYUgCCWLoj2lO6pzKUl8aWK4E+fLsfmAJLUpQLzKKGJg2B16vuFSfjWXI/C4Itx8LYWMcnXVFz/GlKU4zGIPdVfn+dfsR+L6iu9qU5jsNB97S4Q72POwW1MCn3U4E57sW46nZoUW30CMjG8+tanxrBtVnp7h26CiHYUWcDFvdg+qc6sVrEpuKw0f788H+XDI0ckSwuVLgwJZjiJ7um8jWPjnmNTkID08m4ff75++FjK/5zojY76rDcyugr51v68rrZ8h6/Fqcg5VkdmjMG/EBhriMqdoUpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjzfxgVDQ4aCSvQHZPRiJhNCozJhcebPn7hjM0YaYTg=;
 b=kSF7jrAXZ5ML/6YrMdIWszUc81amqbPV/c1T2fXoMye19cz6hLMsIj36IYVPnKF1HyiJ8REU42w8WrfpeNoC/AoUQcgMm4Ttj/xyMnAomBJUbtf/2GooCv8O8SzrXK8rW3aFAz6uVN0ASd/bOeIxznHBqMU4mY8A7C7ehz4y+IeaUOVo4gdqGm7LCQa9Qh5bOA2XQIcVle8IS6repVXYbUw4mHFaYJs1Muoij2qj5eWbFOKLlXAGWAnM6A7ymwpLFkEkq6Ac/RmsFVNXvzpAII+vtMUbGgjTLMp68ndJbVF5DBg4PTzdCWbl+jGlX56zJhG2Y71NG/dbpPR+hK3ROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjzfxgVDQ4aCSvQHZPRiJhNCozJhcebPn7hjM0YaYTg=;
 b=FwrLVPvPeDlO7wx2M37mv01ysYe7jQvVWY2tSSqOGYdOPz9k80zyruJT+6X0SMKFvxR5OU6VDeGyTpHozPSmEkR0xsxrme2iXyQVR/Rfvb99mw5FMeNjYPrdefQ/7ZgK3j5vL7jDIU/HzzWbHVCfbLrXlGQZHskXq/7twbJt4DE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 03:10:05 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3174.023; Fri, 10 Jul
 2020 03:10:05 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: update driver if file for sienna_cichlid
Date: Fri, 10 Jul 2020 11:09:33 +0800
Message-Id: <20200710030933.3159919-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:202:2e::19) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR06CA0007.apcprd06.prod.outlook.com (2603:1096:202:2e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 03:10:03 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7258863-f215-4b89-cc9b-08d8247ebe69
X-MS-TrafficTypeDiagnostic: MWHPR12MB1248:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1248000509562C5B46C589C1EF650@MWHPR12MB1248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0eP8amrIsECWcFBOwAIyPxV2/54OegZ/Cs9aTx3ufOuvyFXpaRyWMyeg9wXAYBqWTIC5JSiX7A93AprYrXbyId/Enzhw79uGYOtUJ08arwcV09dEPBpZ59QL6CeTjAXc0pUzoA0nROl9U+N/QmQS0T4S6BNy9HQz1gg0NUS5J4CGVkFX5/vF5HYg6+eXYILLE2FG9sTcZPyyepBWQpvUsTuIX/poOXvpgOFAvUpE/WpIfsz5mZzorlaRSzRc3B4FyeuuKqti/jqlThYL5j6En6lGrSOY6W8TQ40PnnE2HsS7cno2y3BOXT1XTCGlMsbuLElXcH0B7HRbLLWNdV9OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(6916009)(6486002)(66946007)(1076003)(66556008)(6666004)(4326008)(66476007)(86362001)(83380400001)(5660300002)(478600001)(52116002)(36756003)(8676002)(7696005)(8936002)(16526019)(186003)(26005)(54906003)(316002)(2906002)(956004)(44832011)(2616005)(15650500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dsW+12uLTWMEm9lzVXUUdwLNS0u+cpqLcuIretuyw2wTKF4DDIMTfMK784/RsPQoMPF080+7SBZ2o0//J0OJ9RezHllEjCvAZMOapHnybBCGDCYqx7/FwWMnpeDXugYg0q521zWefcmRuJJd+ILOKjc4+ZNyugbxoybU5byp4SE00uTRtdwD7Tv6Mw1NqWlm4PIzhe/MgO4hVoa65ImZp/Yf9XXYuIev0pgj3+RHpWp/vNuxwBwlL9PLRyvw0i6Aw6kdvJw4NWcyZ/6E3Qe8yJN1A9mdV90F+BNIflKKFhwuwsnm+/L5OyWkDVQ53xG5UdZb/zPDZm5F77lRPKrtNm7P6sU90qOppHpKrkuGaXSyL2Nh2MbOcVWiwL305Tffx0f//uyuAeAjlA29zvvxtXsy0XcrtHlgEDzjiUEHkyEfJhgy+kW0FioUUDx+qKRL4467T1iZbRc2dbm6axj+rgMla+jJMZmwmmc8+XLDYUSQfG1dIeMg49PjCP/1TZ8B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7258863-f215-4b89-cc9b-08d8247ebe69
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 03:10:05.4627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pU2oRO0JYvfIEEr3KFzveqzysbTh7fOn35oONz321sO/vi8qIisMq1Uk6+9375+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1248
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

Update sienna_cichlid driver if header and related files.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: If303e7fca32ebf922ee5d918855bbaca8dc61d38
---
 .../inc/smu11_driver_if_sienna_cichlid.h        | 17 +++++++++++++----
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h   |  2 +-
 .../gpu/drm/amd/powerplay/sienna_cichlid_ppt.c  |  1 -
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
index 302c2bcf9404..b2232e24d82f 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,9 +27,9 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if 
 // any structure is changed in this file
-#define SMU11_DRIVER_IF_VERSION 0x32
+#define SMU11_DRIVER_IF_VERSION 0x33
 
-#define PPTABLE_Sienna_Cichlid_SMU_VERSION 4
+#define PPTABLE_Sienna_Cichlid_SMU_VERSION 5
 
 #define NUM_GFXCLK_DPM_LEVELS  16
 #define NUM_SMNCLK_DPM_LEVELS  2
@@ -128,7 +128,7 @@
 #define FEATURE_2_STEP_PSTATE_BIT       46
 #define FEATURE_SMNCLK_DPM_BIT          47
 #define FEATURE_SPARE_48_BIT            48
-#define FEATURE_SPARE_49_BIT            49
+#define FEATURE_GFX_EDC_BIT             49
 #define FEATURE_SPARE_50_BIT            50
 #define FEATURE_SPARE_51_BIT            51
 #define FEATURE_SPARE_52_BIT            52
@@ -564,6 +564,12 @@ typedef enum {
   TDC_THROTTLER_COUNT
 } TDC_THROTTLER_e;
 
+typedef enum {
+  CUSTOMER_VARIANT_ROW,
+  CUSTOMER_VARIANT_FALCON,
+  CUSTOMER_VARIANT_COUNT,
+} CUSTOMER_VARIANT_e;
+	 
 // Used for 2-step UCLK DPM change workaround
 typedef struct {
   uint16_t Fmin;
@@ -786,7 +792,10 @@ typedef struct {
   QuadraticInt_t    ReservedEquation3; 
 
   // SECTION: Sku Reserved
-  uint32_t         SkuReserved[15];
+  uint8_t          CustomerVariant;
+  uint8_t          Spare[3];
+  uint32_t         SkuReserved[14];
+
 
   // MAJOR SECTION: BOARD PARAMETERS
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index d07bf4fe6e4a..b2f65438ad8d 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x32
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x33
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index dc5ca9121db5..3efa41444ddf 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -2317,7 +2317,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 	dev_info(smu->adev->dev, "SkuReserved[11] = 0x%x\n", pptable->SkuReserved[11]);
 	dev_info(smu->adev->dev, "SkuReserved[12] = 0x%x\n", pptable->SkuReserved[12]);
 	dev_info(smu->adev->dev, "SkuReserved[13] = 0x%x\n", pptable->SkuReserved[13]);
-	dev_info(smu->adev->dev, "SkuReserved[14] = 0x%x\n", pptable->SkuReserved[14]);
 
 	dev_info(smu->adev->dev, "GamingClk[0] = 0x%x\n", pptable->GamingClk[0]);
 	dev_info(smu->adev->dev, "GamingClk[1] = 0x%x\n", pptable->GamingClk[1]);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
