Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5EAC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F9912065C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LQXD/As5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9912065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5309A6EB61;
	Fri, 10 Jul 2020 04:12:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16EA46EB61
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dae1t6E1G0bqVzZUda/OSaBkspM/kBCu6HLsoDZXHcfIfSdh0AuZKSOZL6foKCtZDsqpPYvWt5Mm4hdEestFW8stm0k7jQsZIBdB6SdZHVbfpdHatoCgojBl6lKj1Lh+DcYEU3ja3qiglEkBatBTBY/VvkbFmy2d4c2jrqVp4MBhl1WzuMH2wgATqWivhrt8JZC2GAboDeReppLCq0CpUksUpikYnKMJeQZEMlrXAvN9S5/7zBXz0ihYFryMtln65nBWPdugpbjiIhLpnO1vZyIy1VTS6BVReJbQYiSOdxOpnQkZW3AuFMwcysJkbxZ/sowdmpw6IcMwE/X4uTzjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tb8qsjmlzjoIAW/TQj0ucPRB36kU/WM5mFG3Y7b2Gw=;
 b=YZXmTZaw4xXsMKu8bv/ooSa7hIInYc5YNfUS+coof7smzG6HIyw4TU5zLBBWQ88jlRvv1nYrZvQebots/BtPOjOj9Q+wEx1TE2quUSFJk0PwUExcCo81SNllVMD+tJNQKby6NfPtTC2WkMtnVJ2puXZ5hh+2toU4LqhumaDmqIjMnahSI2qUNRI7LmW3JRAaRvKJFjMF3vDgkFXdLRZ6+lE3d3ptwvCQ70gN4OLO0jw4P+hPI7+XWvrIALwUAFDZTBau9Eq8ODYXaOGKjwq8L2LS4t7aDoOf7YY0w8KgRjyE671RsHs3EYxiqFTCSmlWrM+Baxqls34vPXrcyClBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tb8qsjmlzjoIAW/TQj0ucPRB36kU/WM5mFG3Y7b2Gw=;
 b=LQXD/As5mGrcFtko0KxY+5Y9tlEMKILfwIc5cPkW3sHjMAiEC/FXQw47sBse2TTlj3Za92S1dMjcZGk6zSEiL1fzxpnA0U3hNxq9M8x/So5NhAaS9XQAV/89zfxeUrZ3Bo475PhuzRrAtq3FaPLPIaT9Lrx0I9YcKB5u6tXWQ0g=
Received: from MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 by MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Fri, 10 Jul
 2020 04:12:21 +0000
Received: from MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045]) by MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045%9]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 04:12:21 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: update driver if file for
 sienna_cichlid
Thread-Topic: [PATCH] drm/amd/powerplay: update driver if file for
 sienna_cichlid
Thread-Index: AQHWVmeev5xoVwlJ3UqjmroWMeC5PakAM0YA
Date: Fri, 10 Jul 2020 04:12:21 +0000
Message-ID: <MN2PR12MB41755B36754457C0188547A08E650@MN2PR12MB4175.namprd12.prod.outlook.com>
References: <20200710030933.3159919-1-likun.gao@amd.com>
In-Reply-To: <20200710030933.3159919-1-likun.gao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-10T04:11:02Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5aa03dfe-6609-427c-9a75-0000f06a44ef;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-10T04:11:02Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7ff7109a-f818-43b1-8c12-0000c5a17899
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0c431c6-2ee4-4838-cf1b-08d82487717b
x-ms-traffictypediagnostic: MN2PR12MB3872:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB387233C1848B9DA03790B2768E650@MN2PR12MB3872.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 046060344D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZurLU/SI7gRPgb1OY0JMIB1qYyvF3Vv2EDKfoQNOMUYjwp4R1wqE9QmTv8unHn2U6SUCoWX09/EZT4AQjNgGSP5FSgLcsDu6mM8Wx1jPE6561okeN6biLK2vuKjPOfcpVE4MNWjyiyZI4DvvlhDS6//FKJ5J/35efFC+qWCFl4dPYktcom9ePHDF9lVEPieTVBFVFs8q1qHL1NxYXekXa16Sg9hB1qEUDhDG98QnjWZ4G07dbstYJR3ZNGA2zGdG4f+mujjRct1r0vEZj7QymGt1bxgjguCNbWKFBl9vVQrD6jXsffUtPMWM0cn+yOe6b2D1iZ/+301ZvdsQjcqlg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4175.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(83380400001)(6506007)(110136005)(53546011)(26005)(186003)(316002)(71200400001)(2906002)(76116006)(4326008)(66946007)(66446008)(86362001)(15650500001)(52536014)(5660300002)(478600001)(33656002)(9686003)(7696005)(8676002)(8936002)(66556008)(64756008)(66476007)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yOLb8l48u0LRFia5uvh8gptVpXImmZx0XrAq0oOQzoD0XF0rXbmAYABvoybRn4J3lbrE7aXL3myO90Jz+wxefblXPKuKg9kAQLvrQVz+itj2SoLme+I5hBU0WtB9WhhjSdyEl4shELrSzmro/Rma7GOiyCF6KboYVZ9cTzgQkEbeRFCg7SkokOk1QzICcur0/yUhDk75mEk3tdxEntsJHyV6AXKEf1RvF7dxaDfioM3S7P/wriKB05W7z9xGuHXgr+M8P/+C6BANEJNWuXn/0MAHct/XGDlkW+OZnOkg8+wTYVYBz1UNJjmQgP1WtA6ORU7sNXRX7j9VuePYqHZUsZOQppYQjRcvDWFHpJDku6415UA4bwv5EL8LVIooG6lsWHia1kvyXSikHpxcqmBuXzX+x1xN2N6RjNfn7Qv1WvxbhmRp5ppYX/garXc08G/EHhRfxkPZO96tgJIYmL3HiWwzXRM+pKVJoyXXQgDI5sR/66a4o9KRhL5kQF44QADD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4175.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c431c6-2ee4-4838-cf1b-08d82487717b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 04:12:21.5591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c0npUnRjBCdjRmvElPkbl2jpttyzz/rKhaJW0Qu7AUZDHa9YohaGOOvITLUXoczu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3872
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
Sent: Friday, July 10, 2020 11:10 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/powerplay: update driver if file for sienna_cichlid

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
 // SMU TEAM: Always increment the interface version if  // any structure is changed in this file -#define SMU11_DRIVER_IF_VERSION 0x32
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
 // Used for 2-step UCLK DPM change workaround  typedef struct {
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
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36  #define SMU11_DRIVER_IF_VERSION_NV12 0x33  #define SMU11_DRIVER_IF_VERSION_NV14 0x36 -#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x32
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
