Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9872BC433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 16:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F365206A5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 16:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l3o2sJjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F365206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC666E1FB;
	Thu,  3 Sep 2020 16:57:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEAB86E1FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 16:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRXnM6JrkG05848pMG7FXt/nNw2vwsKYWZjeX6lDuCQf6xZii6y4tLqNPbW2RARfytN5Uc275pS2tGiC2EkPtSESGX85BLydYSgqrk368NKpg4EUMkpb+SqOUz1GvR+jal8XKl7BCtiErtZwXVu6Po7FI9ifx3Zz2/2/T32u++pfUS3iUGAAUoXLzvyQr48ugyS37OcSaH52Q77vxIf0Xe/OElTMGPJkrTA8OX1zPUJtvKKN9tUzHYBRWoclDoXh8Zn/PKovDGnWi5ic8wJh0Hr+rk/SoXgmenKFLknCT5J9hgNXx2Nm7ADof71iYJf0wDRI4tjzko53E3njdOy0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtMrz22UzvAFUReANVSs6RnvxmqkPJOye3Vfp4FI4Yc=;
 b=Zfq9ng2RJ4+XQSAVOMsSb40grr0a1gvTtTrXU0PrOaEfoy6lQZO2+j12+FrSpKKA5GsraLjaEiVjTtBGTulobMs/hpG9pxa3y57zCrB+3FoKa9mc8RY2vT8A+oSujxF2NCdIMda91H6ZjsWVA5aAEQIwM54/vXvzE3QjYbau1AJtsXboWzIsRTLrrtKeQ5mcUv2D++/rAfEv8Bwzrk0kB00qy6zU7vTQe/9Y9aFKkFcbtL9FT+a/VISRGtK9PGWFieIlN0kljxhCXHhS6NHUGD0najVY5FVabYg+Rl2jjV+RzDCBAIrdrXrRFbHCt6NlPsMEINRwt0yK8XyTR3jLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtMrz22UzvAFUReANVSs6RnvxmqkPJOye3Vfp4FI4Yc=;
 b=l3o2sJjIqJePGrBXA9Z751NLuQkl/YUG3VAht2r6h+vBmcl2fu3708ALqC1HWbLI8jRmVFQ4kbi0LvuJSTJbmAV86RWiCjzn9OzVPLBhH3M1MSuKWR7ASQXiaZm9wzHk7NZVyGItvc6Cxezc5a1MqNdpGxAZGev9fheyb3tZ6dA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Thu, 3 Sep
 2020 16:56:57 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 16:56:57 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for renoir
Thread-Topic: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for renoir
Thread-Index: AQHWgNBtkITnrRFTPEeQPF6zmRNNO6lVZbYTgAGggYCAAAN6AIAAGw9D
Date: Thu, 3 Sep 2020 16:56:57 +0000
Message-ID: <MN2PR12MB4488E9611CDEDA527306B05BF72C0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200902022544.24308-1-changfeng.zhu@amd.com>,
 <MN2PR12MB448871ACBD2A7AC1FF9034A0F72F0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MW3PR12MB45545359545841728FC5BA67F92C0@MW3PR12MB4554.namprd12.prod.outlook.com>,
 <DM6PR12MB2938F5B8F83A4223AB53331AFD2C0@DM6PR12MB2938.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2938F5B8F83A4223AB53331AFD2C0@DM6PR12MB2938.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [172.58.230.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cdc6a94-9868-40d2-0673-08d8502a5e3b
x-ms-traffictypediagnostic: MN2PR12MB4584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4584E6A15AF12B0484C87A26F72C0@MN2PR12MB4584.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AusskMvI7KPwMTtKnpDWUBzFpuH14qjRg93/PI/iJ0OPFYvxGCDSQFnmH9KrVfP7n1ou0B1Yf5B4bBllHW6kpeCy3t1h2jpTBTGHZxuyBKwz/c6tNyFLF89frTak+hraP8OmopmiajYp1MGSVd+07o9B6cDYTCmhORS5eGEqmm2ogl5B2hyyFrKzojjSqfdL9k6Z4Eg9Xtg/int4Yxz+IrirQNl13tBbJwBC4HzOaJTON0MbgxPb+fLo8r7pSR+R9yJbR8i/axAGcWDwbF1sABZewd0xC02ILlbrigfLqvzG2puklC13NplrGjuccm53PZCLFBkP6B6hzBWye8SZChcRdzJ1OxJelNPGedywKHE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(33656002)(66556008)(66476007)(478600001)(66946007)(64756008)(66446008)(76116006)(71200400001)(6636002)(166002)(19627235002)(83380400001)(5660300002)(8676002)(55016002)(45080400002)(26005)(186003)(8936002)(9686003)(52536014)(19627405001)(966005)(2906002)(316002)(110136005)(6506007)(53546011)(86362001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: mtXInTMof+cmrw8FWG5VnsOkb4bugx4UR1/JdzESOgMaxVOFlF4iXIG+7StjegYooOJbJe3W/YOgQDQ1Ir1yliYO7kZp6EZRV5J55ddGMGQ/LcI0myi/Z88tD9ji7tcyyaFM7tIHIKmzwU2nRqwmauZhozy9M9q9vCj+CIchVqk2pdaI0jDnUMh7bPoLxmga74Me+WZW1MhEC6DD+1prsNNnbEU1K6FDsaF5hDucqdHGQwRhA8WFJH0NOPbq6/BrC8JUkhpDYLTfAdRNPY46tBk8epM4FYa3cv4ovEKHQvjxzMDPBY3oRQvIari//5rjRJLPWiSj2Z3eekbVhat3I7fAPPbR9keXCTYo/JJgJweetsNMqfzC5ueY+qK2dAt520+Z+2AR6IHAlrbCgo1Zt+LSDVbpLKvknp8bJAVIL76wKgedxH+rZsUjmkxcSBKh5XEjSITUmcDID8us67exHVhdORQV4MG6pqWqjSyT0lZccWq9omA0G0INZ7kQmq3+W3J9YrwnObuiE5yPpneQ2y1jzDfgsv0OiCrJIy1YFK/p+9sdk1oL2WzXXQPBJ83ybF8KwBlyb6fzVarmg5P8ZdlB2lthB4ch4h/m9i+iEyYJEi/X1UjfTwmO0U4Cligow9TjEJwNxLWh0yjTbGoRfA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdc6a94-9868-40d2-0673-08d8502a5e3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 16:56:57.0380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1FhvbDv/OOzxqwvgHMQIhTMqwt06ycEaATsoUc2zVob30UXWBFDijdeZgCy8eVfBTV1bpiSuz0KRveMzaz+kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584
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
Content-Type: multipart/mixed; boundary="===============0065466352=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0065466352==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488E9611CDEDA527306B05BF72C0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488E9611CDEDA527306B05BF72C0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Sent: Thursday, September 3, 2020 11:19 AM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Deucher, Alexander <Ale=
xander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freed=
esktop.org>; Huang, Ray <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for reno=
ir


[AMD Public Use]


[AMD Public Use]





Thanks, Lakha.



BR,

Changfeng.



From: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Sent: Thursday, September 3, 2020 11:07 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Changfeng <Changfe=
ng.Zhu@amd.com>; amd-gfx@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.c=
om>
Subject: Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for reno=
ir



[AMD Public Use]



Hi Alex,



psp_sw_fini() releases the ta firmware







Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com<mailto:Bhawanpree=
t.Lakha@amd.com>>













________________________________

From: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>
Sent: September 2, 2020 10:18 AM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Huang, Ray <=
Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Lakha, Bhawanpreet <Bhawanpre=
et.Lakha@amd.com<mailto:Bhawanpreet.Lakha@amd.com>>
Subject: Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for reno=
ir



[AMD Public Use]



We also need to release the firmware when the driver unloads or is that alr=
eady handled in some common path?



Alex



________________________________

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Changfeng.Zhu <changfeng.zhu@amd.com<=
mailto:changfeng.zhu@amd.com>>
Sent: Tuesday, September 1, 2020 10:25 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Huang, =
Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Lakha, Bhawanpreet <Bhaw=
anpreet.Lakha@amd.com<mailto:Bhawanpreet.Lakha@amd.com>>
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>
Subject: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for renoir



From: changzhu <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>

From: Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>

It needs to load renoir_ta firmware because hdcp is enabled by default
for renoir now. This can avoid error:DTM TA is not initialized

Change-Id: Ib2f03a531013e4b432c2e9d4ec3dc021b4f8da7d
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.co=
m>>
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
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C324a6285d81146a0639b08d84ee78d14%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637346103730596780&amp;sdata=3DItQDVbjEzkmKeeEU%2B=
V01rQb4iGuWvHaqRAFlC4e6oqI%3D&amp;reserved=3D0

--_000_MN2PR12MB4488E9611CDEDA527306B05BF72C0MN2PR12MB4488namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhu, Changfeng &lt;Ch=
angfeng.Zhu@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 3, 2020 11:19 AM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Deucher, A=
lexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@lists.freedesktop.org &=
lt;amd-gfx@lists.freedesktop.org&gt;; Huang, Ray &lt;Ray.Huang@amd.com&gt;<=
br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 f=
or renoir</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
p.x_msipheader87abd423, li.x_msipheader87abd423, div.x_msipheader87abd423
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle20
	{font-family:"Arial",sans-serif;
	color:#317100}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#317100=
; margin:15pt">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_msipheader87abd423" style=3D"margin:0in"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:#317100">[AMD =
Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Thanks, Lakha.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">BR,</p>
<p class=3D"x_MsoNormal">Changfeng.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.La=
kha@amd.com&gt;
<br>
<b>Sent:</b> Thursday, September 3, 2020 11:07 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhu, Chang=
feng &lt;Changfeng.Zhu@amd.com&gt;; amd-gfx@lists.freedesktop.org; Huang, R=
ay &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 f=
or renoir</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Hi A=
lex, </span>
</p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">psp_=
sw_fini() releases the ta firmware
</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Revi=
ewed-by: Bhawanpreet Lakha &lt;<a href=3D"mailto:Bhawanpreet.Lakha@amd.com"=
>Bhawanpreet.Lakha@amd.com</a>&gt;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Deucher, Alexander &lt;<a href=3D"mailto:Alexande=
r.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Sent:</b> September 2, 2020 10:18 AM<br>
<b>To:</b> Zhu, Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Chan=
gfeng.Zhu@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com=
">Ray.Huang@amd.com</a>&gt;; Lakha, Bhawanpreet &lt;<a href=3D"mailto:Bhawa=
npreet.Lakha@amd.com">Bhawanpreet.Lakha@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 f=
or renoir</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">We a=
lso need to release the firmware when the driver unloads or is that already=
 handled in some common path?</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Alex=
</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lis=
ts.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf=
 of Changfeng.Zhu &lt;<a href=3D"mailto:changfeng.zhu@amd.com">changfeng.zh=
u@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, September 1, 2020 10:25 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray.Hu=
ang@amd.com">Ray.Huang@amd.com</a>&gt;; Lakha, Bhawanpreet
 &lt;<a href=3D"mailto:Bhawanpreet.Lakha@amd.com">Bhawanpreet.Lakha@amd.com=
</a>&gt;<br>
<b>Cc:</b> Zhu, Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Chan=
gfeng.Zhu@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for r=
enoir</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">From: changzhu &lt;<a href=3D"mailto:Changfeng.Zhu=
@amd.com">Changfeng.Zhu@amd.com</a>&gt;<br>
<br>
From: Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Changfeng.Zhu@=
amd.com</a>&gt;<br>
<br>
It needs to load renoir_ta firmware because hdcp is enabled by default<br>
for renoir now. This can avoid error:DTM TA is not initialized<br>
<br>
Change-Id: Ib2f03a531013e4b432c2e9d4ec3dc021b4f8da7d<br>
Signed-off-by: Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Chang=
feng.Zhu@amd.com</a>&gt;<br>
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
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C324a6285d81146a0639b08d84ee78d14%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637346103730596780&amp;amp;sdata=3D=
ItQDVbjEzkmKeeEU%2BV01rQb4iGuWvHaqRAFlC4e6oqI%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C324a6285d81146a0639b08d84ee78d14%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637346103730596780&amp;amp;sdata=3DItQDVbjEzkmKeeE=
U%2BV01rQb4iGuWvHaqRAFlC4e6oqI%3D&amp;amp;reserved=3D0</a></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB4488E9611CDEDA527306B05BF72C0MN2PR12MB4488namp_--

--===============0065466352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0065466352==--
