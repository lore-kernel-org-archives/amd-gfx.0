Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5446BC55ABD
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 08:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC95208C7
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 08:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RckIdFT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC95208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7490789D8A;
	Mon, 16 Nov 2020 08:39:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E5089D8A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 08:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHZ0zExT9/8PMkcIVP4rG5AldMOYXjNwRzTGN63vWZGbZYCTgs6gDEUOWoN5VhR33x9O5zm4Z/NWWvNzcFeDCxh7Luba+D6+r7rxZvFoY5wH2asbY9OB3rcprrZ0VxX1hV8R+M8swGoiVqiaRlUagNw4KI2ir0rCeE4tf9GRiZ30hRqGK8O1VgrWJo0137+HbwaVLhyTMHF2AFB6cDMMstcrKLWiy/n1UJJdMhPN74J9eFPTpaDxVdwtSZQRMxSbapWN1NpkZv8iuNS5YNKnrfV8v4EIPOEbXJd7GvdsE8jgjtkTmALLHs9Chg872W7d9Y3KIbrYPGNZb7798BYvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGmBNggXeJu5uIiwrKQwjE/4nEbkQl1UBEzG4ZGAujU=;
 b=etUnUwvraolGclsB1v1XhPSOM+Tmj7s0LV0N11X/3+eTotZimfExdU9UcRrkGKVLGsYdPXoIRr1n6+cbh7bbzzC41UBlAe1ZpcXL2GB6Bae7zWhNgB7mHrFUNqiJY8ndOhhvK10Us+ajZuiW7t/zIpGv3pfEPOC+sPtlV8zfjIHEW2QB+mfGrE++sobaaf/PJaS1UgCVtXoipzAs0aplcxeUK359ldPkBqoUHMRY8hvbiPRHK9+eQSGbvfHB+ZmcxOQUZ7akoLbmP0v5GpbgCE7RCYpK/K+iCo/hefY6o/0mCOsfIvo6JaHopDwUuUxgsQpRmeCXkDamiBt5Ml12oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGmBNggXeJu5uIiwrKQwjE/4nEbkQl1UBEzG4ZGAujU=;
 b=RckIdFT76rDTYrMM2ZlnSkstpIFKUN7k0sxmlwqjPOCMPMRDShITcpbwjX9Cbcrkvec1oIDaKmZ7IgE4ZZ7n78rvZDIjVD0c5cAPZTuJrbNd5RjuxdwTv5GYnLv4Iq3XAeTrODFLreZQjiqyxnWPvFruS2K49o5+Q2XYW/Kwbos=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28; Mon, 16 Nov 2020 08:39:07 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%8]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 08:39:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Thread-Topic: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Thread-Index: AQHWu+r7v457TjT5XkmGmDH5IIic7KnKb/Sw
Date: Mon, 16 Nov 2020 08:39:07 +0000
Message-ID: <DM6PR12MB4075EC4C74F346DB88D3FEF9FCE30@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201116073436.410900-1-likun.gao@amd.com>
In-Reply-To: <20201116073436.410900-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-16T08:39:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ccd3491f-8828-49b6-b486-000024e04a4f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-16T08:39:00Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 011ff28b-1af9-4ee1-8cb5-000076458e00
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-16T08:39:05Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d9224bff-0ba6-4269-9e56-0000d15082f0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7da9a387-6b37-4465-934a-08d88a0b14d4
x-ms-traffictypediagnostic: DM6PR12MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49594DE75DECC0704FF81EE7FCE30@DM6PR12MB4959.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NAzEjeByFYZG7QhWTH0l0rl+umLyvC2pwyTxtlx1A7vZEnZS4xQMSj8Q+oTp8l4kmASgcKIGSLRsThphS/66I6T/kCEv0O86dzms80aaFL9fN/SukJenHpgtC0gx7Q5jWWLYRvuhJcFGv3LQLRKD5Z3Jj59Gu+GcVWZtoTOmF9SG5Ao/b/SXO6m0FZQrZ1OL2tBXKJ7ska/G5I8TfecZkcgOHyj3ZqIJB2jhkzfYvVIHJ8/x/m5PiS0JYeWXcXLqlBaQHti8xJmZW+lKkZOXH19U+fsu671UWNud5P9DtDzGEo7R2Z9cUM7bBrnkPmo4mUIaoMmtE1JhNjTTk79JlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(52536014)(5660300002)(71200400001)(26005)(186003)(86362001)(4326008)(76116006)(66946007)(64756008)(7696005)(6506007)(66446008)(66476007)(2906002)(33656002)(53546011)(66556008)(15650500001)(55016002)(9686003)(316002)(110136005)(8676002)(478600001)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cgz3r3hJhW4pQu+qyUrPkkA9WA25RZeKaX3BvMWOcbe1ehn/2KfVHwvK5DUV8789zjmiMkNaDMVN22ZtARa7dC7tyZfRjBTpMD1d1HSNB9N5faVSdZGpMAGz4T9h+H6NxabnfJcV25/6J05s1C2LkVAbPz4cn/IZuEuQtPTsimdJN7EFvtcD4ZrUyzfq8ct6ra4xzow2/eI18hOwXy/NpZ04bjeZYbOMVusUMny2zqEIm+VXu9ojeI90eNWtixeSOafM2wA0k5jsTMoot3RXU5ahyaCHNTe2vu+c2+zS8zuuByaShqHzUO8Az5NMsTUKa4Ung81rj4z8HWQpWS15ih9l7lFCPcbYmHQgjjcNYKmyf3STza1WcQfTmF/qBS2PaforKwcje3vLweCo+Y09ia51CvS9afW2xsGlpMEs8mZorcVxfZ0EJKjAp0ju9VPdzCz7vdloM3cdHuhTrlVCkUvt9X7b0oFJz2q67ZMk2eC9NHwgmDzRAnV2fJcs8wGMcsIgvq92GXQkqmW8Euhc3tZQbxYeBvKce5gArrlj3cMSN+3vr8K1Hn82Jayi3cRsctaV8mPclQMJCEHtAC3eqa8YqlDDt9gPrfNI9Wqnw4qwuYzVGbUUDPnbKAMO5eD3j4d9CHXxj2kEp/6tKM5YfFPw6L/C/Mx9tqUsaHjXCs3WEQ2AMR8yko72nDHl9AGYJG7vNuL+m7ijT5Qyavm5uXdonvu2vRr7q8yJk35crSq8ohX8naT0H0XoPPdRVHGwK0UFJCm5m8Ww9s9AUMhkPdM8q4eDA1riPak/plYum1zszNc8H1MoetKg9FTv3fcNOccx1aHzm15htcmLG+eJENlbcaYlsXv0OhKn0whULc97tfE4oIvlhhp0+le6tOsYYA92Fz0y4YPdMBz1gxTj9g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da9a387-6b37-4465-934a-08d88a0b14d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 08:39:07.0349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ixu3YpTObMLpBv1smwqKMFcH2EEuwsKE2oKUuMs2iGiCa1Ed62Lczf2aDByXSfPRbTyC2pitY5yXXdbgbb8Pgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Monday, November 16, 2020 15:35
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/pm: update driver if file for sienna cichlid

From: Likun Gao <Likun.Gao@amd.com>

Update driver if file for sienna cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ibcffb2a668202f941b1e8e7a22924976c910cf35
---
 .../pm/inc/smu11_driver_if_sienna_cichlid.h   | 16 +++++++++-----
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 22 -------------------
 3 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index e418a46603c8..fa95147b5a63 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,9 +27,9 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if  // any structure is changed in this file -#define SMU11_DRIVER_IF_VERSION 0x3A
+#define SMU11_DRIVER_IF_VERSION 0x3B
 
-#define PPTABLE_Sienna_Cichlid_SMU_VERSION 6
+#define PPTABLE_Sienna_Cichlid_SMU_VERSION 7
 
 #define NUM_GFXCLK_DPM_LEVELS  16
 #define NUM_SMNCLK_DPM_LEVELS  2
@@ -437,6 +437,7 @@ typedef enum {
   PIECEWISE_LINEAR_FUSED_MODEL = 0,
   PIECEWISE_LINEAR_PP_MODEL,
   QUADRATIC_PP_MODEL,
+  PERPART_PIECEWISE_LINEAR_PP_MODEL,
 } DfllDroopModelSelect_e;
 
 typedef struct {
@@ -612,7 +613,9 @@ typedef struct {
   uint16_t       SmnclkDpmFreq        [NUM_SMNCLK_DPM_LEVELS];       // in MHz
   uint16_t       SmnclkDpmVoltage     [NUM_SMNCLK_DPM_LEVELS];       // mV(Q2)
 
-  uint32_t     PaddingAPCC[4];
+  uint32_t       PaddingAPCC;
+  uint16_t       PerPartDroopVsetGfxDfll[NUM_PIECE_WISE_LINEAR_DROOP_MODEL_VF_POINTS];  //In mV(Q2)
+  uint16_t       PaddingPerPartDroop;
 
   // SECTION: Throttler settings
   uint32_t ThrottlerControlMask;   // See Throtter masks defines
@@ -667,7 +670,9 @@ typedef struct {
   uint16_t       FreqTablePhyclk   [NUM_PHYCLK_DPM_LEVELS  ];     // In MHz
   uint16_t       FreqTableDtbclk   [NUM_DTBCLK_DPM_LEVELS  ];     // In MHz
   uint16_t       FreqTableFclk     [NUM_FCLK_DPM_LEVELS    ];     // In MHz
-  uint32_t       Paddingclks[16];
+  uint32_t       Paddingclks;
+
+  DroopInt_t     PerPartDroopModelGfxDfll[NUM_PIECE_WISE_LINEAR_DROOP_MODEL_VF_POINTS]; //GHz ->Vstore in IEEE float format
 
   uint32_t       DcModeMaxFreq     [PPCLK_COUNT            ];     // In MHz
   
@@ -1221,7 +1226,8 @@ typedef struct {
 #define WORKLOAD_PPLIB_VR_BIT             4 
 #define WORKLOAD_PPLIB_COMPUTE_BIT        5 
 #define WORKLOAD_PPLIB_CUSTOM_BIT         6 
-#define WORKLOAD_PPLIB_COUNT              7 
+#define WORKLOAD_PPLIB_W3D_BIT            7 
+#define WORKLOAD_PPLIB_COUNT              8 
 
 
 // These defines are used with the following messages:
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 41bc919dc9f4..eff396c7a281 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
-#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3A
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3B
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02
 #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xD
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 0600befc6e4c..21c5ea3a4a63 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1805,11 +1805,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 		dev_info(smu->adev->dev, "SmnclkDpmFreq[%d] = 0x%x\n", i, pptable->SmnclkDpmFreq[i]);
 		dev_info(smu->adev->dev, "SmnclkDpmVoltage[%d] = 0x%x\n", i, pptable->SmnclkDpmVoltage[i]);
 	}
-	dev_info(smu->adev->dev, "PaddingAPCC[0] = 0x%x\n", pptable->PaddingAPCC[0]);
-	dev_info(smu->adev->dev, "PaddingAPCC[1] = 0x%x\n", pptable->PaddingAPCC[1]);
-	dev_info(smu->adev->dev, "PaddingAPCC[2] = 0x%x\n", pptable->PaddingAPCC[2]);
-	dev_info(smu->adev->dev, "PaddingAPCC[3] = 0x%x\n", pptable->PaddingAPCC[3]);
-
 	dev_info(smu->adev->dev, "ThrottlerControlMask = 0x%x\n", pptable->ThrottlerControlMask);
 
 	dev_info(smu->adev->dev, "FwDStateMask = 0x%x\n", pptable->FwDStateMask);
@@ -2036,23 +2031,6 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 	for (i = 0; i < NUM_FCLK_DPM_LEVELS; i++)
 		dev_info(smu->adev->dev, "  .[%02d] = 0x%x\n", i, pptable->FreqTableFclk[i]);
 
-	dev_info(smu->adev->dev, "Paddingclks[0] = 0x%x\n",  pptable->Paddingclks[0]);
-	dev_info(smu->adev->dev, "Paddingclks[1] = 0x%x\n",  pptable->Paddingclks[1]);
-	dev_info(smu->adev->dev, "Paddingclks[2] = 0x%x\n",  pptable->Paddingclks[2]);
-	dev_info(smu->adev->dev, "Paddingclks[3] = 0x%x\n",  pptable->Paddingclks[3]);
-	dev_info(smu->adev->dev, "Paddingclks[4] = 0x%x\n",  pptable->Paddingclks[4]);
-	dev_info(smu->adev->dev, "Paddingclks[5] = 0x%x\n",  pptable->Paddingclks[5]);
-	dev_info(smu->adev->dev, "Paddingclks[6] = 0x%x\n",  pptable->Paddingclks[6]);
-	dev_info(smu->adev->dev, "Paddingclks[7] = 0x%x\n",  pptable->Paddingclks[7]);
-	dev_info(smu->adev->dev, "Paddingclks[8] = 0x%x\n",  pptable->Paddingclks[8]);
-	dev_info(smu->adev->dev, "Paddingclks[9] = 0x%x\n",  pptable->Paddingclks[9]);
-	dev_info(smu->adev->dev, "Paddingclks[10] = 0x%x\n", pptable->Paddingclks[10]);
-	dev_info(smu->adev->dev, "Paddingclks[11] = 0x%x\n", pptable->Paddingclks[11]);
-	dev_info(smu->adev->dev, "Paddingclks[12] = 0x%x\n", pptable->Paddingclks[12]);
-	dev_info(smu->adev->dev, "Paddingclks[13] = 0x%x\n", pptable->Paddingclks[13]);
-	dev_info(smu->adev->dev, "Paddingclks[14] = 0x%x\n", pptable->Paddingclks[14]);
-	dev_info(smu->adev->dev, "Paddingclks[15] = 0x%x\n", pptable->Paddingclks[15]);
-
 	dev_info(smu->adev->dev, "DcModeMaxFreq\n");
 	dev_info(smu->adev->dev, "  .PPCLK_GFXCLK = 0x%x\n", pptable->DcModeMaxFreq[PPCLK_GFXCLK]);
 	dev_info(smu->adev->dev, "  .PPCLK_SOCCLK = 0x%x\n", pptable->DcModeMaxFreq[PPCLK_SOCCLK]);
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
