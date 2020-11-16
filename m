Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF96C55ABD
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 08:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FD32222E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 08:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NyRRCBVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FD32222E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED5B89C69;
	Mon, 16 Nov 2020 08:04:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741B289B68
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 08:04:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgDHrZk94lNcHPbI5ZSNaGgJHQxJyUcUc07k+vsinhFl9qStuyp3VrXoQ+2RO9jnm4BBSKI3qrhhW5JFyeAcilSQFWesclByKkXrn/GCA7n1KqTF8Pls/pSDdDrqa0+gWgIP4kTgA7TPim8uwqkyinWJeXKIgbEv5Y3KjFSRGsBy1a/h0gC/N+VCOrQG3kXQg3Hmj747VCQGo7h8GhVX5P+zXhRqZo8t4GKRRhWiv0xMKv9xoQuS3/6i5Qq/ooeKMD5VRL5cDd5sfRqy7rIMFN4A3lhp8juF7mhjgf4uWWzomOu97tXdiL4nspuvcCAW/FkarJ47GVjPUmTkxNG3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcwQ79iY0uE0kmHOUUkFF8WpJHp7vItECrAldOikcfk=;
 b=hyJgK20Vv5+JbScSxfBVFbus5CBxkyVkMIDyK54LNKdR6lnBLsC8PG2YhVGgPbzc+MgveOeRH9XQ5tvsmUQuSvsds3CR/zSh/IiCx3IbLVv2K3Y4piP3GT63QacEp/pmOOxr28Rv+v6/8IgyoIEvFwiBCKBkyaov7znSgoawRh1dNs6d4gkzRyf2QfdN5Uf24R7OP9Jvbvhr73gw2QSOaJOy/52dc2rT3VGz2YA3nmdCKi9WTHdYnq6dV29b40boRGFzZK9nj4IQW7vz6VyVotwt5Cb9Ra+hf2MneMNDw1w0jO0PdX6Yb9bYGZGwFpgCLpX/D16EOGqc/N9HR12v7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcwQ79iY0uE0kmHOUUkFF8WpJHp7vItECrAldOikcfk=;
 b=NyRRCBVhdtlvzaCxCrsDpnWAhPCRNM16vGZ0+2sEQS6nCl7/FcdCOsu/1uxOhJLq8p7UgShEZyN7I/9fSDhYW4/J/vKSxwuRU+7OaRRdiSbeLs6fwsyE823sXWUOMFWB6mSXZVSE07jS8bM566LQOAgwEtmQuTn+txdQEeBdDVc=
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) by
 DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28; Mon, 16 Nov 2020 08:04:51 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf%6]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 08:04:51 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Thread-Topic: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Thread-Index: AQHWu+r8bhkCPYwKYEqdoPcNHc+5WanKZmvQ
Date: Mon, 16 Nov 2020 08:04:51 +0000
Message-ID: <DM5PR12MB1657D283FCB966B72DB7C4778EE30@DM5PR12MB1657.namprd12.prod.outlook.com>
References: <20201116073436.410900-1-likun.gao@amd.com>
In-Reply-To: <20201116073436.410900-1-likun.gao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-16T08:04:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=476d3c1f-c6ae-44a9-8b1a-00000674f4b8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-16T08:04:45Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 70a5daf9-3250-4dfb-8c37-00000cceb184
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 323399ba-1199-4df2-2ab1-08d88a064ba5
x-ms-traffictypediagnostic: DM5PR12MB2486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2486F5C094850191130FE7D48EE30@DM5PR12MB2486.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1t5M2UptS8GGa/W4J+eY7UyJiz4tSAxoS4IhYC57IQ4izCNMBvnbvwkfIRb/a942oXbbYM7BJtnaIRQuISrZrSzYRexbfEByzMms+5Ni0a4HGAloVYbNB3UdwsBnNpX1PoiUydWiqz+m/DBfBHTuMaefCVOqAehDb2ngrMOCw1Us4LkBTkV7uJw9meWIEqKz2kl/oOlREqKVxXl8MQfS34jYhcarcMmDPm+Nm9U5QVx+rAgS+xBrDpQHYYYP7o/+b3UanG0oG6ZEqdgvNc9eIV3bQEwc8sW60ziFtfJ0kSBIFGefHcjpHglzGvciv5PUPvRzpcVkchd6EixZeL5Ctg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(55016002)(4326008)(110136005)(71200400001)(316002)(9686003)(15650500001)(478600001)(2906002)(83380400001)(33656002)(186003)(8936002)(64756008)(8676002)(7696005)(26005)(6506007)(53546011)(5660300002)(52536014)(86362001)(66476007)(66946007)(66556008)(66446008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: soU95AnPwQlhnI9hd8Ilo1cdzYEsMmpR4XIqi5+UCpwskYUoFwD5Tw8NyzZc3zgRd2bMU+uTini9prVPove52znJHH7lUnLvsCRrwMaf1KJ8uHolaUqn1J3vAGVeQbS7v9lP9OXhRLSSDFxNDB8K1ilwD07cspOYtb4gT7D4fiGXNKuy9+/sxiRM9DVwLc/HIqljOAzK2Lg6WN+BCnJTyj14GttGi6rDW5X+ff+U7JEUz7vxKGJ7M/TJj9MFOwEcoeL5PQ/5bHjmB235HxcW+DsEvgavFuH2r4tYqtuqU0AGCMei/K8EM4RlEOtfMlqkGEshTU3eWgNOsKsEsDybsOSthFDvqHL5fSpWYgL/CfdGeLvOk4TE+zCy99ykjzDC1uUXcrCdHmoxvknEAGsXo0/GzOPpQGX4r4LqEgFY0SSNf1IfmirkrVkxHSq1saKhQYLc1t9XYdfzocd+4ZV53gEYolnNwuuZKD48BcAJQCpb9nhuwn9iYJby9v0a/xyTh8VnDuUKB4BPDlp6p3runW+a+Wl/h7bhsvf4S7lAge9f1OcWn4vgv62cHwgHlPZDA0hHH+Fd6O1lrPjkDBP2cGQ08BaTmN8pCy6QOvS3A6mUrNjXT7FfDhtiaFKf4Xq/JQfU261gqJarNLbkcLZ1vm7U7fTWC1hHEjF3daFrdiiQRuQAxfkO/gYCt7AIY/5WgMV/ZJxNLJTHzrBDkM9lt8Bjl5OTCEMZfRfQ1yEkbLQJMlvyPZgBd2I1EWpbhgxhuYq693u8xxc3qA5t7NlfxFTw/b/b8gsK4n/OGDADBLwTPwy0LLLxqHbyX5a2Bb1ucuzRtXQf/UBukGDDkjXrW9BnaoUQ/n31f3USsvziTIriaz6sj0SXkSg3ovl1qElAhB3rH0KSllcfoF2aAtEXAw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323399ba-1199-4df2-2ab1-08d88a064ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 08:04:51.3019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slRYlxp+X17eY0a2qhNh6rjVVrzcGItYzI0WHhBHy4ss5gJWyW5muQhuVWhYx1jA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


Best Regards
Kenneth

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Monday, November 16, 2020 3:35 PM
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
