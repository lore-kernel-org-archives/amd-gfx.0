Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A715C2BC11
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 15:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3111120716
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iAL18GJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3111120716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87EE6E1F2;
	Thu,  3 Sep 2020 15:07:34 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750055.outbound.protection.outlook.com [40.107.75.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA286E090
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 15:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap3ZKP2KHuSDWaW70dPz5taI5NAA8ylzqlLWfLITerPKiv9j4yapNiqOsTd+Lm1pRyBJkyOU85+v1z/41FbgVf3ZvUwitd3FdNHNqUtHi+oZC7chp82OrAPH1E400VRth33CSHCiYnrS6sQjxiiXQS6sEibP8EGlMBRlKM+K5ow3WTAAX1wQkeXSsm+cjL6IN+KmafKhtpffGq2rFJjxRK9XdAh7uGZ3D0i1FS01qO+08U/s6AxIdp8lSFCXpzy37MM+Q211Q4JxJ1JSVf/9IQduKomPitG+KSvEYeKauLhopLdWWR9LYPINw5F1fYJ+trosI0Jx/H1JdU7RWJ6SAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNPRzBREzU1StKyo7sbFXGUFOBSs4kWbBErYOBkaKF0=;
 b=T4bRUfn8E9QErHdMrhievaOOickM0KVz8Ciw87JYBVoZWdbh95JyedB8GIiJBIgLiboMgskA2DPVK6/F+4GwONQ+ZwNkBbpYlksz95/Mq1SJ8dlyS40nr6GICU3duzyz4JZO4Suq9WslGPhBZie22ogz32Qw284MUzo6mCoszYgm2OfGjdntw3AyHn72kqIGSGFotvx6twaJlmUWHSmkKXf817KPHbJiO0NW9pkqD+JtV89xMMbNLfRhlSDw3OE6DcpGl77NsvdodBaCut9heZxGPllRjQEe0PR4CgB4BO+cRTtk8cxjJ3/AGMGAsBGIS/F4ar0SU2qD0UGMgxT00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNPRzBREzU1StKyo7sbFXGUFOBSs4kWbBErYOBkaKF0=;
 b=iAL18GJKBFhRLaXa9edMPOGJSqxU8DH3turbisb7htjxEBHOEw5TpbDxgzfvBV3PYJgnS3kvVmrVsDnAOZ8SHgMwiqfcJGh3sSVJj3p9x3CU3viLRy7EmxsheMTbiSo7vEJHiAy/eeoQBIhIlJzZdgDyqy4pR9Eb2acw2EJla5I=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR12MB1872.namprd12.prod.outlook.com (2603:10b6:300:10d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 15:07:21 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::8468:a7f8:d931:ccac]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::8468:a7f8:d931:ccac%5]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 15:07:21 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu, Changfeng"
 <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for renoir
Thread-Topic: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for renoir
Thread-Index: AQHWgNBo6ujLvlPk3E6RQMNwPrFZw6lVZj+AgAGe+0w=
Date: Thu, 3 Sep 2020 15:07:21 +0000
Message-ID: <MW3PR12MB45545359545841728FC5BA67F92C0@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20200902022544.24308-1-changfeng.zhu@amd.com>,
 <MN2PR12MB448871ACBD2A7AC1FF9034A0F72F0@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448871ACBD2A7AC1FF9034A0F72F0@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-03T15:07:21.146Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [173.33.124.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a6e5775-ac2b-43de-2afb-08d8501b0ee9
x-ms-traffictypediagnostic: MWHPR12MB1872:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB18726C4E2979416BBE7A8B95F92C0@MWHPR12MB1872.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:459;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Y8lhXWbnrfDn3hPyrUibXTMau+QV2n4b/iOjIT/i1r1oO8EsO7YigcJJpEsStevmUeVd40Ras62TwtarksUszyU69amJCKAbVILU9puTXDbqdBJIryOe+HLVRfMRyl3+B8eO3FPC/7dZEuUvK2bQTV+dDKfpZWEELd6/QCWj00jB1LQrrPVe6nQx3cyGnvejDReFerW77di0buOuJkNqmlgzXRGe1wxdRf90whEiFvtzVR1+vya0jh3MwvNH40eBTvoBa1VReoRIXpfmBGye97clrrzTKNGhjj/LG0pplxzmoyvN7vqY4yHbdsEEcUXbZ9aEYWvJTR3RsCF54OgaTaIJepA7vIeI5d9+LiKzzA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(316002)(7696005)(966005)(66556008)(83380400001)(66946007)(66476007)(6636002)(186003)(64756008)(53546011)(66446008)(6506007)(45080400002)(19627405001)(26005)(52536014)(76116006)(86362001)(8676002)(166002)(2906002)(110136005)(55016002)(478600001)(8936002)(5660300002)(33656002)(71200400001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: zJIlqM+dgy1RhBFlT/AGczDKFZjrfJEhBAI56rcjcvs9R7J+DokrHRJJAOKSsxfztCJdSkrkgs2tsGriSUIkExwgfpA8ObY3OBBGK2cFxU2YnqUaWZnaGdvsCkl6HvCa+gYa2CHbPAPRdVAG+M6ORBR5zBRfgq3N5laBLNZQKd73A9FyJkbMO41r9kGDrTihx0tkdvVnxdsxJQT6oYAUxHub7jHBnUUQeaUN2/sA62QDJ1OVMyrX3jxP5afyTeCEr0GgKuTTtAAjHDktN69VVnWVrTZW5t8C+sAlkG63gjFbCtlH9100v12NvXm2H9d+8IvZlML6N1kq5O7YuhVLe9seOOk/pptAeZRLXQMiN09vjj6B1T/dRrd4CJvEHppjXmIZBLAlqxPWToDsMHojvJA8OIuii0GqHuLYYVhcUr9AMVySBqUPQn5FbxIr3jUtvD8ixYOy3z2B8RMABYM12iiExjT0/RX0h0uGScA5MyO4kzlZ3Pg8HzcCU83S+qpGmZzMiaAKpskxMEsJYKS7pfUYJ9+GdmMNyn/u1HSls0TAAizqaOQIBUZbMlKyav3s3WH9cAcBsnPHUM/sdPbBQg5htKfqaYwGvlgCORUYvKfNhn9aHbrDGmkBKKnAbQaAo0+RwNMoHXpVAn9Moh3egQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6e5775-ac2b-43de-2afb-08d8501b0ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 15:07:21.6629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xv37Ago7fXcG6wpRG4+uZapfsFGKK1xFYRSGHyhAs/riPkUldTZLhyld+HpFM7hT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1872
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
Content-Type: multipart/mixed; boundary="===============1397616326=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1397616326==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB45545359545841728FC5BA67F92C0MW3PR12MB4554namp_"

--_000_MW3PR12MB45545359545841728FC5BA67F92C0MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hi Alex,

psp_sw_fini() releases the ta firmware



Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>






________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: September 2, 2020 10:18 AM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>; Huang, Ray <Ray.Huang@amd.com>; Lakha, Bhaw=
anpreet <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for reno=
ir


[AMD Public Use]

We also need to release the firmware when the driver unloads or is that alr=
eady handled in some common path?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Changfen=
g.Zhu <changfeng.zhu@amd.com>
Sent: Tuesday, September 1, 2020 10:25 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Huang, R=
ay <Ray.Huang@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for renoir

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

It needs to load renoir_ta firmware because hdcp is enabled by default
for renoir now. This can avoid error:DTM TA is not initialized

Change-Id: Ib2f03a531013e4b432c2e9d4ec3dc021b4f8da7d
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 54 ++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v12_0.c
index 6c9614f77d33..75489313dbad 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -38,6 +38,8 @@
 #include "oss/osssys_4_0_sh_mask.h"

 MODULE_FIRMWARE("amdgpu/renoir_asd.bin");
+MODULE_FIRMWARE("amdgpu/renoir_ta.bin");
+
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS           0x3010024

@@ -45,7 +47,10 @@ static int psp_v12_0_init_microcode(struct psp_context *=
psp)
 {
         struct amdgpu_device *adev =3D psp->adev;
         const char *chip_name;
+       char fw_name[30];
         int err =3D 0;
+       const struct ta_firmware_header_v1_0 *ta_hdr;
+       DRM_DEBUG("\n");

         switch (adev->asic_type) {
         case CHIP_RENOIR:
@@ -56,6 +61,55 @@ static int psp_v12_0_init_microcode(struct psp_context *=
psp)
         }

         err =3D psp_init_asd_microcode(psp, chip_name);
+       if (err)
+               goto out;
+
+       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
+       err =3D request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
+       if (err) {
+               release_firmware(adev->psp.ta_fw);
+               adev->psp.ta_fw =3D NULL;
+               dev_info(adev->dev,
+                        "psp v12.0: Failed to load firmware \"%s\"\n",
+                        fw_name);
+       } else {
+               err =3D amdgpu_ucode_validate(adev->psp.ta_fw);
+               if (err)
+                       goto out2;
+
+               ta_hdr =3D (const struct ta_firmware_header_v1_0 *)
+                                adev->psp.ta_fw->data;
+               adev->psp.ta_hdcp_ucode_version =3D
+                       le32_to_cpu(ta_hdr->ta_hdcp_ucode_version);
+               adev->psp.ta_hdcp_ucode_size =3D
+                       le32_to_cpu(ta_hdr->ta_hdcp_size_bytes);
+               adev->psp.ta_hdcp_start_addr =3D
+                       (uint8_t *)ta_hdr +
+                       le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes=
);
+
+               adev->psp.ta_fw_version =3D le32_to_cpu(ta_hdr->header.ucod=
e_version);
+
+               adev->psp.ta_dtm_ucode_version =3D
+                       le32_to_cpu(ta_hdr->ta_dtm_ucode_version);
+               adev->psp.ta_dtm_ucode_size =3D
+                       le32_to_cpu(ta_hdr->ta_dtm_size_bytes);
+               adev->psp.ta_dtm_start_addr =3D
+                       (uint8_t *)adev->psp.ta_hdcp_start_addr +
+                       le32_to_cpu(ta_hdr->ta_dtm_offset_bytes);
+       }
+
+       return 0;
+
+out2:
+       release_firmware(adev->psp.ta_fw);
+       adev->psp.ta_fw =3D NULL;
+out:
+       if (err) {
+               dev_err(adev->dev,
+                       "psp v12.0: Failed to load firmware \"%s\"\n",
+                       fw_name);
+       }
+
         return err;
 }

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C324a6285d81146a0639b08d84ee78d14%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637346103730596780&amp;sdata=3DItQDVbjEzkmKeeEU%2B=
V01rQb4iGuWvHaqRAFlC4e6oqI%3D&amp;reserved=3D0

--_000_MW3PR12MB45545359545841728FC5BA67F92C0MW3PR12MB4554namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Alex,
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt">
psp_sw_fini() releases the ta firmware <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt">
<br>
</div>
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<br>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> September 2, 2020 10:18 AM<br>
<b>To:</b> Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Huang, Ray &lt;Ray.Huang=
@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 f=
or renoir</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#317100=
; margin:15pt">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
We also need to release the firmware when the driver unloads or is that alr=
eady handled in some common path?<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Changfeng.Zhu &lt;changfeng=
.zhu@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 1, 2020 10:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Huang, Ray &lt;Ray.Huang@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpre=
et.Lakha@amd.com&gt;<br>
<b>Cc:</b> Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for r=
enoir</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">From: changzhu &lt;Changfeng.Zhu@amd.com&gt;<br>
<br>
From: Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
<br>
It needs to load renoir_ta firmware because hdcp is enabled by default<br>
for renoir now. This can avoid error:DTM TA is not initialized<br>
<br>
Change-Id: Ib2f03a531013e4b432c2e9d4ec3dc021b4f8da7d<br>
Signed-off-by: Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 54 +++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 54 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v12_0.c<br>
index 6c9614f77d33..75489313dbad 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c<br>
@@ -38,6 +38,8 @@<br>
&nbsp;#include &quot;oss/osssys_4_0_sh_mask.h&quot;<br>
&nbsp;<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/renoir_asd.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/renoir_ta.bin&quot;);<br>
+<br>
&nbsp;/* address block */<br>
&nbsp;#define smnMP1_FIRMWARE_FLAGS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x3010024<br>
&nbsp;<br>
@@ -45,7 +47,10 @@ static int psp_v12_0_init_microcode(struct psp_context *=
psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D psp-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *chip_name;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char fw_name[30];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct ta_firmware_header_v1_0 =
*ta_hdr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
@@ -56,6 +61,55 @@ static int psp_v12_0_init_microcode(struct psp_context *=
psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D psp_init_asd_micro=
code(psp, chip_name);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &q=
uot;amdgpu/%s_ta.bin&quot;, chip_name);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D request_firmware(&amp;adev-&g=
t;psp.ta_fw, fw_name, adev-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; release_firmware(adev-&gt;psp.ta_fw);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_fw =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;psp =
v12.0: Failed to load firmware \&quot;%s\&quot;\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D amdgpu_ucode_validate(adev-&gt;psp.ta_fw);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (err)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out2;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ta_hdr =3D (const struct ta_firmware_header_v1_0 *)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_fw-&gt;data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_hdcp_ucode_version =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_hdcp_ucode_version);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_hdcp_ucode_size =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_hdcp_size_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_hdcp_start_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)ta_hd=
r +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;header.ucode_array_offset_bytes);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_fw_version =3D le32_to_cpu(ta_hdr-&gt;header.uco=
de_version);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_dtm_ucode_version =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_dtm_ucode_version);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_dtm_ucode_size =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_dtm_size_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_dtm_start_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)adev-=
&gt;psp.ta_hdcp_start_addr +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_dtm_offset_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+<br>
+out2:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;psp.ta_fw);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_fw =3D NULL;<br>
+out:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;psp v12.0:=
 Failed to load firmware \&quot;%s\&quot;\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C324a6285d81146a0639b08d84ee78d14%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637346103730596780&amp;amp;sdata=3D=
ItQDVbjEzkmKeeEU%2BV01rQb4iGuWvHaqRAFlC4e6oqI%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C324a6285d81146a0639b08d84ee78d14%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637346103730596780&amp;amp;sdata=3DItQDVbjEzkmKeeE=
U%2BV01rQb4iGuWvHaqRAFlC4e6oqI%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_MW3PR12MB45545359545841728FC5BA67F92C0MW3PR12MB4554namp_--

--===============1397616326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1397616326==--
