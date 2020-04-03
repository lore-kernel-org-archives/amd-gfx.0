Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3920C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 15:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C610220675
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 15:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hbHt3fj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C610220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E086EC19;
	Fri,  3 Apr 2020 15:54:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2746EC19
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 15:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxArbGWcAm4AQhCUjNRiTjN3QV18t/3Wp4kZF7gTvVC1JXq0RrktKEsvNbKJf4FTUKaSpPZ7hxdh+Bw6sfa92bXwvLDo/DwigSU/AJzZJXsa4d5n/SG1tMb0YdEMLg5YvWWQGFrImDx20EdKtoUX59+OSTU/Y9qFdu7M4k5U1e7OhDqHgpK9XGGmVV7ArlfUXNxQ6383wHgy5KZ/P3yv47E6XH2YTNzlHtbnD9Y/+FyHAFRQ6jrwdma19Hce/jT6K38VW9sMhu6A0Nu1MFGFRf668+aO0uFZ0NjATgMGwrlYDXOQ+6lMeZPQrZlqO2k9XLB1cEHnH69jEC+qau8wAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkJXLG93lSXCGtWjB7zLV63E4S6nfWxJ1UnaVC7rWnQ=;
 b=PzVPXaVlnstKgIye9fi9hmWtM1x8Z7a9p/SIk6LKrrtHm4/ml7YCRn/MLAEecPBxTR6o5TuA4yUudywSiwLEBfdFdKHtvbrq8acy3whA+IUDAt8y0NYXtdie8IOirkkAMvrH9PbVo6/y20ghD4I9EXz2/XqpdktEDwjRAc247PElIicFI3KzT35NJjYGLLUOBSKo3NPq2UDTC+XX7szD25gtGOAq9VYeM3twamHSECajv3K52afLedpIKgupzQLW5vkgtGi6fiehpvSDv1YKNv3aLEAcWI2B6le6JrFc45pUh4/QxG+aS0K+1HHYk5SRebxenwHIm5CB6ibOuYoSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkJXLG93lSXCGtWjB7zLV63E4S6nfWxJ1UnaVC7rWnQ=;
 b=hbHt3fj3QPKccAdN1BjyIFRR5rtlCz15tEdKQHHYPXwii14es32jgWVYhzpspDGl3VBvFaufggTHmX1+mlosQW1kHojqag/KbV/Lz9KTa8QTHnYGM7a7PqrtFLSXNhKo8t30RhhatP6riruOm9pR3ayC3sK3ZG+dkOywXesW6qg=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4012.namprd12.prod.outlook.com (2603:10b6:5:1cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 3 Apr
 2020 15:54:25 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 15:54:25 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Re-enable FRU check for most models
Thread-Topic: [PATCH] drm/amdgpu: Re-enable FRU check for most models
Thread-Index: AQHWCcZDt75VyHuvJECd/K2Caxc1oKhnjD6AgAAAXZA=
Date: Fri, 3 Apr 2020 15:54:24 +0000
Message-ID: <DM6PR12MB3721E12E61B09D425BEC195E85C70@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200403144329.30127-1-kent.russell@amd.com>
 <MN2PR12MB448829E6575102EB81E95690F7C70@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448829E6575102EB81E95690F7C70@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-03T15:52:36.539Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-04-03T15:54:23Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c372df65-c213-4d18-aee6-000079ccbb73
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
x-originating-ip: [2607:fea8:1c80:c44:d77:7581:235:8c68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d6419b8-b312-4632-0f02-08d7d7e74895
x-ms-traffictypediagnostic: DM6PR12MB4012:|DM6PR12MB4012:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4012FBEAEDDD3D8DAEEDE9BC85C70@DM6PR12MB4012.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(81156014)(55016002)(110136005)(45080400002)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(316002)(478600001)(2906002)(966005)(33656002)(8936002)(86362001)(7696005)(52536014)(8676002)(81166006)(5660300002)(53546011)(6506007)(9686003)(71200400001)(186003)(170073001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FoCghFL5M6hLw0UmdKj5BNyUjSSJ4212Z/PjtvP5oYQ75ddyeBc+bogPm2wzu94yxZ2+6tTfjqyjYHeJ8Y66JVPQB3R40JUuthKEwMSMds1wnYsQKhshFcTjpzYZspaCuBhew6oB0DFHdgYhehP2nV5Dg80xNPVbYQXOy9WtduS+vgo0bU9JKlSKv3wrigWGQO2E7FKGGpcoNfbF5dkHqFKOGySXSPQOo6iwfeU+bibQrDyqM9TccNxKTgykctvs8Rr2bQeGemCoJwwKfp9e1OagOCKlIkJl1haXXW67uVtwjcdkbJAoOO12SQgTSCExqkpcK74tAoQ81Zg78BPHGomyeh25H0DhpqYuRUiFKGYK2h4vjvF2GX3geD1FHTcuUQFEv8bjI8X5cOgE4Vs88xL5PXym+rgLwtdT52bbyxb0AvB/tNWk1tgxMFwVu88bVxD9odE6t+oKMgW7weWFXSmQZawZC3oGPRQvNDhCuDU6D/GD3Lh1VYziSwS3sn2+HXSR3QqlaJ7m1fWOntAjdw==
x-ms-exchange-antispam-messagedata: KSe4wY78xeEvCDRGf3IhRCbkzLvz85/QR5oYqgpgkDFVoHmaISIhy2vgjNt/y4eokoWgDQ2XusVBuoLf3ljGNfNQw5UQWyifBjHI9P3GvQs20oXdEeKmLemwXYowZ9df4mDIuKoDMM2ahVrfmoRptLMM0qL0y37drT/1Evhu6vVd9R7fgqlqdf56mlqfXiZX1krbj9c2TOn7lRoWcK+OSg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6419b8-b312-4632-0f02-08d7d7e74895
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 15:54:24.9700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUN70Ehs2NZTqFnawAphWS/2OcY7zfdLJe0fSOoq9+UzmihxKyj2xeEUdjkTlPgGCyBNHo//V9BnM1YzQ0qvbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4012
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
Content-Type: multipart/mixed; boundary="===============0209400822=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0209400822==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3721E12E61B09D425BEC195E85C70DM6PR12MB3721namp_"

--_000_DM6PR12MB3721E12E61B09D425BEC195E85C70DM6PR12MB3721namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

There's always the possibility. I'll add it for sanity and sensibility.

Kent

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, April 3, 2020 11:53 AM
To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models


[AMD Public Use]

Does this need to be protected by a asic_type check as well or is just the =
vbios version enough?  Will we have other asics with D360 in the vbios vers=
ion?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Kent Russell <kent.russell@amd.com<ma=
ilto:kent.russell@amd.com>>
Sent: Friday, April 3, 2020 10:43 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>
Subject: [PATCH] drm/amdgpu: Re-enable FRU check for most models

There are 2 SKUs that do not have the FRU on there, and trying to read
that will cause a hang. For now, check for the gaming SKU until a proper
fix can be implemented. This re-enables serial number reporting for
server cards

Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index bfe4259f9508..281bdfd4630a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -31,9 +31,20 @@

 bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
-       /* TODO: Resolve supported ASIC type */
+       struct atom_context *atom_ctx =3D adev->mode_info.atom_context;

-       return false;
+       if (!atom_ctx)
+               return false;
+
+       /* TODO: Gaming SKUs don't have the FRU EEPROM.
+        * Use this to address hangs on modprobe on gaming SKUs
+        * until a proper solution can be implemented
+        */
+       if (strnstr(atom_ctx->vbios_version, "D360",
+                       sizeof(atom_ctx->vbios_version)))
+               return false;
+
+       return true;
 }

 int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C97d3aa4c34464592264508d7d7dd69a0%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637215218317453581&amp;sdata=3DABysYVGVyaYWc2Huebw=
GNdPbOkvC%2Fmmduk4EMROoDfw%3D&amp;reserved=3D0

--_000_DM6PR12MB3721E12E61B09D425BEC195E85C70DM6PR12MB3721namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#317100;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">There&#8217;s always the possibility. I&#8217;ll add=
 it for sanity and sensibility.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Kent<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Friday, April 3, 2020 11:53 AM<br>
<b>To:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Does th=
is need to be protected by a asic_type check as well or is just the vbios v=
ersion enough?&nbsp; Will we have other asics with D360 in the vbios versio=
n?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Kent Russell &lt;<a href=3D"mailto:kent.russell@amd.com">kent.russell@amd=
.com</a>&gt;<br>
<b>Sent:</b> Friday, April 3, 2020 10:43 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.R=
ussell@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Re-enable FRU check for most models</sp=
an> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">There are 2 SKUs that do not have the FRU on there, =
and trying to read<br>
that will cause a hang. For now, check for the gaming SKU until a proper<br=
>
fix can be implemented. This re-enables serial number reporting for<br>
server cards<br>
<br>
Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@amd.com">ken=
t.russell@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 15 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 13 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
index bfe4259f9508..281bdfd4630a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c<br>
@@ -31,9 &#43;31,20 @@<br>
&nbsp;<br>
&nbsp;bool is_fru_eeprom_supported(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: Resolve supported ASIC type =
*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context *atom_ctx =3D=
 adev-&gt;mode_info.atom_context;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!atom_ctx)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: Gaming SKUs don't have t=
he FRU EEPROM.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Use this to address hangs=
 on modprobe on gaming SKUs<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * until a proper solution c=
an be implemented<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strnstr(atom_ctx-&gt;vbios_ve=
rsion, &quot;D360&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(atom_=
ctx-&gt;vbios_version)))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrp=
tr,<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C97d3aa4c34464592264508d7d7dd69a0%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637215218317453581&amp;amp;sdata=3D=
ABysYVGVyaYWc2HuebwGNdPbOkvC%2Fmmduk4EMROoDfw%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C97d3aa4c34464592264508d7d7dd69a0%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637215218317453581&amp;amp;sdata=3DABysYVGVyaYWc2H=
uebwGNdPbOkvC%2Fmmduk4EMROoDfw%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB3721E12E61B09D425BEC195E85C70DM6PR12MB3721namp_--

--===============0209400822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0209400822==--
