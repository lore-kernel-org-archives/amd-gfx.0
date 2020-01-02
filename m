Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F26C2D0DD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 06:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3287B2053B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 06:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1NgitTyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3287B2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E40A289C16;
	Thu,  2 Jan 2020 06:21:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B4589C16
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 06:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EN5URdjARazdPeqqh65TStUIuFXAr4cvuqxj4CFhZg+BqsSXVxuI4FITG2yHX/Ai8hg7bs8RxMtnMn23LE3+xTqi/bay7Jsa13GNDPtbt7hL/3nGyXGv7t5pNt6NtpLKu6LIKJqqCMxvdVSh7PRokWSS/6ABTGdJp8yvU93BJFszeDGgwJsVqMiAQo3kZijDs3xbUurzvU4ajxpB2bg8zlOjFgCPFztSf5rNkrOyp4hOxsFm/4Yln9HYHxlL86RDutnefgVFfLQrGEJ5UK/dGcH2K4DnLW/Pd3AYRqgYfoa4wGEgabrHQBBLBzVbJpgvZ/uICCC+sg7G52kWTTVtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPVp1n4iSRqzUBLVBElizwMF7ipBn1gSoFw6advYP/o=;
 b=ROIUqpjwgjdGPcDJ70jLWeef7Jvy4XEE11iD5JBVDNLGEGBg1XHMx/79z3GX23AXA2FY750Mpe6PzZK+FMrdYS0UaE6T4dvMOFjZqFlaCy/oybpPsryjGHAYUYRsT6t1tw8PR403JS61gDVLtIjDFDQOrj9u8alxmZr5dTLdLIocZbRaE3/DAXNgIb5TPd23WzAwp3BqByONezPfnQq955UK7Vx7QSOJwBvohcxJScweeTVrmGI2XaywIVxZtsYCIGkbWXcEJxZCLoFRH13mFHs/To4Y8k4KQDgcthmJNRJqZ2eK7YOYBYEue2FGyQmkd58ASUzarFrzvnkhBXhhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPVp1n4iSRqzUBLVBElizwMF7ipBn1gSoFw6advYP/o=;
 b=1NgitTytPSXBX0H+hgIlf0gDCHOw0Bf/5OiboAMPOyaI0a9ldgcnACBdW4FriUBVVQBcmJ61jt8lLBhnj49wps2Elb/SE3UwbgOW3SC8fpBe1cNINzPwmndINC6Fyl+kMXBg/LYEu3/C8C1ARazvYhDu3EKspvoA+VtqcTmf+BU=
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) by
 MN2PR12MB3278.namprd12.prod.outlook.com (20.179.81.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Thu, 2 Jan 2020 06:21:06 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::58ae:be91:c063:b2a1]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::58ae:be91:c063:b2a1%6]) with mapi id 15.20.2581.007; Thu, 2 Jan 2020
 06:21:06 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: add smu11_driver_if_arcturus.h new OOB
 members
Thread-Topic: [PATCH] drm/amd/powerplay: add smu11_driver_if_arcturus.h new
 OOB members
Thread-Index: AQHVwQ+grT6rzblv/k27eA3mIrg326fW504w
Date: Thu, 2 Jan 2020 06:21:05 +0000
Message-ID: <MN2PR12MB3598DC9A7329E4122A6607578E200@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20200102015424.10737-1-evan.quan@amd.com>
In-Reply-To: <20200102015424.10737-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-02T06:20:59Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=10a39829-cb54-48ce-a10b-0000e3669179;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-02T06:20:59Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a73194a1-6b01-414b-8f55-00004cc8d8d1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kenneth.Feng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a034b01-1fe8-4639-29fa-08d78f4bf339
x-ms-traffictypediagnostic: MN2PR12MB3278:|MN2PR12MB3278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3278FB51C2C8E42AD215EDBA8E200@MN2PR12MB3278.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(13464003)(199004)(189003)(2906002)(8936002)(81156014)(81166006)(45080400002)(478600001)(4326008)(186003)(26005)(6506007)(7696005)(53546011)(8676002)(76116006)(9686003)(5660300002)(66946007)(66446008)(64756008)(66556008)(66476007)(71200400001)(55016002)(33656002)(110136005)(316002)(86362001)(52536014)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3278;
 H:MN2PR12MB3598.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3j9ABfWVqOtMvsLjCfNarnTlhbFQQ+VBV3QA6XDxbhtfBIqEk9RxOC4b/ryjyijMenyEjrKUX6r9az++D08/kimYvpBl1JTdiO5RL5Uv6K5GNLXmC8WWmHALus4H7L0Y5hAZH+nWnkshXcBV2WogSvkJB91HwxtoNMsIX07cH0BKZyS4t2XagFRcLDUeQLkaP44jKPkFPqxk6WCh2llllZhDcAcXD1CLzJi2VbjCcX52HEyRvQpoENcnGPACZDBFALlPIdPOTN02nBJL7fwTQpIXMET1T9UU2jud94rVw24D+ngUrkxmrlsxsFLTXQu/Ej5T3fpN99u8R2HR6/Oc1DP9EIAAAp2PJrevkRLm/KCmMY4D1dcBosx55VbaOM7ve+paZ10G2KQsGLxw9hvrIHV7eENNwHtuFq4U0WfeMX7+PYBEM3IBBzcDGUjHkJbE1qm3D7R3WexKtqq4Xy2Tr51L40s9reCZftdcgLKv/JML66McHp5iOyAFxHbjOmCzO2vwNP8a+bz24iXuEaWoQA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a034b01-1fe8-4639-29fa-08d78f4bf339
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 06:21:05.8655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExYXpDiKf8Oceoqlz7amWyto635mxecGCXaUKxGXsHlUm9f3w3dKjomr0xj7Gq2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3278
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Thursday, January 2, 2020 9:54 AM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: add smu11_driver_if_arcturus.h new OOB members

[CAUTION: External Email]

This is to fit the latest SMC firmware and it's backward compatible.

Change-Id: Ic561f83fa5d9d15a226b9f134da7e7ae90d9c6f9
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h  | 8 +++++++-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h             | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
index 910226ec512e..ce5b5011c122 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
@@ -622,8 +622,14 @@ typedef struct {
   uint16_t     PccThresholdHigh;
   uint32_t     PaddingAPCC[6];  //FIXME pending SPEC

+  // OOB Settings
+  uint16_t BasePerformanceCardPower;
+  uint16_t MaxPerformanceCardPower;
+  uint16_t BasePerformanceFrequencyCap;   //In Mhz
+  uint16_t MaxPerformanceFrequencyCap;    //In Mhz
+
   // SECTION: Reserved
-  uint32_t     Reserved[11];
+  uint32_t     Reserved[9];

   // SECTION: BOARD PARAMETERS

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 662989296174..d5314d12628a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -27,7 +27,7 @@

 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF  #define SMU11_DRIVER_IF_VERSION_VG20 0x13 -#define SMU11_DRIVER_IF_VERSION_ARCT 0x10
+#define SMU11_DRIVER_IF_VERSION_ARCT 0x12
 #define SMU11_DRIVER_IF_VERSION_NV10 0x33  #define SMU11_DRIVER_IF_VERSION_NV14 0x34

--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CKenneth.Feng%40amd.com%7C7d489b7b34004b0e5c2408d78f26c14c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637135268931019458&amp;sdata=Bu5G2HSoqxnkf1aFY93X6%2Bod0OaZ0JxlYBeOU2udOwI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
