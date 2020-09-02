Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E706C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 14:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB08A20773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 14:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4R3p+UbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB08A20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C586E916;
	Wed,  2 Sep 2020 14:18:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD8E6E916
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 14:18:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkD01HtUAgn7RqsB+RuodtKp10Ca3YyBORTZCn/krDHuuu9Dfd49XnM94p0g+YFAOOoS2L4qrtjJwK3TeHjETubXScAL4euaLWj8bpNfD+MotkvVQmxOUTkunpdJSqWZ04MIGgqyjBbV7XL34qn4cuSXpxQzUC8HpOGWdKbwCy/WULt+bZJ9QLo9J5ICB6nFb7N+V6PGsFb6Im5ZRDV5WcP0rfIUUp8y3+2ch+ni7XjYxzvNgOZuPmd5RIbdiE/1EygHkvvOL9QOTYK/X6iGJcj15fMl8EOHsmZk46k/eJqnj7XCZ2JYOpIo6mMK1BaohZuTsSo7kvfdPwe0mBSGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5UQUQFceLPj0Vmv396SV3r0+1CZblKh3emEjYrSdKg=;
 b=EOEHbClM/m14u3AfqTmA0AGZ7ZC0V9xTmS6UP+IIy9q4kTZtVa3LEDIjrH7+ZGcWgo5IOopSk8juf9Mr4PeYYPFOMfM+YlH1blrHMIEYqpMogymwbkvIClB3ju+yq7hnTP6+PyNT7UoW9Lea6zHJ8gCn2cgSLVvjSS2MqBlDFDD7mhVsmPFlGpPtLmqc98ewlVPztAmzMy3jQSibtNjslnTxy+VUQz4KpkLMMwMyMpTy6NQM7opDVPFlun+IMSN7G6ABXWLJKKDPW2k+rpbSkY36dIG1UHRUWeOArrRo7rmmeSR3HMTWNI5ApI7xCTJSSIOwYmzhy2hpFPLkQlcB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5UQUQFceLPj0Vmv396SV3r0+1CZblKh3emEjYrSdKg=;
 b=4R3p+UbN4GlzwR7+J5UwCOEjljdkHa5v0SN3p1BXE8iX8jkfilXq+wYDgNBsd+DcKxkb04wSGNgYLC4LVFIUJbj6E03eNwJucmxRmEFg9Cgqm1vAqF/JN8jISfLTLpQ4mR3qh9YcoTzEP+o+95bQ2kKAr53g6/zToN9JLqJites=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 14:18:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 14:18:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for renoir
Thread-Topic: [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for renoir
Thread-Index: AQHWgNBtkITnrRFTPEeQPF6zmRNNO6lVZbYT
Date: Wed, 2 Sep 2020 14:18:33 +0000
Message-ID: <MN2PR12MB448871ACBD2A7AC1FF9034A0F72F0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200902022544.24308-1-changfeng.zhu@amd.com>
In-Reply-To: <20200902022544.24308-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-02T14:18:32.843Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd8dd656-b5bb-494d-d3a6-08d84f4b132e
x-ms-traffictypediagnostic: MN2PR12MB4472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB44727D1AC25338B83F0B145EF72F0@MN2PR12MB4472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xLLBeKLT88W3Z0yP3qHPec9vWatqeBJoKtfOkLG42lAcmmeU+uzvNl/NNbZ/xDzVoRJrZrPoFDC0AyCdxI94wbclgBMD7EqEVrzMqBddjNqlFlebuMFErYfOMAt0jRVZ9VtyQC1kmaGCz77GU5JL8GgUmbJb1C4LqjV0BMoYc5yr0xL7kj9QjdlbXckQ86v8g8n6tp6qUwTYLgXSqmF/SVm9Y7SfAh+sKQe0HAyFLIO/RM90oGJ3nnLtMhdhjFzaOnuLiJAK0mKUGt1NfjYtPtQSGRSEWLsbjiCrQJv1bCPJXa4aZ5ioCHyOALS4ZG+PIBTYfp4kC8CQghbe00iDoNNxL8pWcq+jMvDHVHz56dU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(66946007)(186003)(110136005)(76116006)(55016002)(45080400002)(6506007)(66446008)(66556008)(7696005)(316002)(86362001)(66476007)(64756008)(6636002)(9686003)(26005)(53546011)(478600001)(83380400001)(966005)(52536014)(8676002)(8936002)(2906002)(71200400001)(33656002)(19627405001)(166002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1WwFsE5UXe1yDklsoj+pR80F/92fJTRx2Q3gN6Sw2f4Y3GNDN+v0FTE9S7sKAlkXw+tveMtME9d7pXb5V+D5yYpLJDc0h1NSr06mQt3anDuuns2Q6vF9ylfdmyOJtGLQZchHbKLyoTQ+vIg6fXG3+8FehWViFa7fYo8b2sNtkoSncNU63cmpV/tCzxJ4FYNt8JPS33hrR+82HkaVSauiywb5FB8Z7N9Phe3dT8btWAj96K/PAR5g4rpmol3vsjayf82MK0oDDfnx3exhtAMtbEOQ3eE0JT8qU/h4Nfd5qS7YTq0/mgCctptK2ifGM2P1ji/JrgoDD51MV38UljYx+k5PgVNmy1gb0mUYGjVeu0bdjGZPq7Al+t3DzDempbWDT2wLUcjPTUQvzpZfFJAhUnEqj2s8i5Mes9zE7CN34ayu9o5l6aJaorBrraxE1/P30Ylv5mlwJBcOK66hIYDepHo2bF+pH+QaG5sJm1C6WpnEUdPR5VXYIVwTR+a75uB3poRMWlVOK29xX++JM0Mmjx2+QrYFdivmWGKJDRZ+WFlNp87H/fDAURVVtFQrxWjUZAxPO0Qz1Zi5tjRaHp+cCJFH07Uu2Mgp7MZl5pCSohyKrtAT2vuae0OwfMhKeKNafz53NjH4X7ZPLZQwKrSOFw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8dd656-b5bb-494d-d3a6-08d84f4b132e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 14:18:33.4687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gz93ddVUa1aqLBvLCh5l2L1RpJ2XrG1bu5ifE6T7EDGM4w8dqaa2Vs1Fln5hbwz1tnv+ZX32OtW00X0O2bbsiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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
Content-Type: multipart/mixed; boundary="===============0223906969=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0223906969==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448871ACBD2A7AC1FF9034A0F72F0MN2PR12MB4488namp_"

--_000_MN2PR12MB448871ACBD2A7AC1FF9034A0F72F0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_MN2PR12MB448871ACBD2A7AC1FF9034A0F72F0MN2PR12MB4488namp_
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
We also need to release the firmware when the driver unloads or is that alr=
eady handled in some common path?<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Changfeng.Zhu &lt;changfeng.z=
hu@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 1, 2020 10:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Huang, Ray &lt;Ray.Huang@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpre=
et.Lakha@amd.com&gt;<br>
<b>Cc:</b> Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add ta firmware load in psp_v12_0 for r=
enoir</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: changzhu &lt;Changfeng.Zhu@amd.com&gt;<br>
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
</body>
</html>

--_000_MN2PR12MB448871ACBD2A7AC1FF9034A0F72F0MN2PR12MB4488namp_--

--===============0223906969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0223906969==--
