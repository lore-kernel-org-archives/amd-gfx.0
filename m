Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC9AC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 04:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCB3206D4
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 04:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TUUbhNMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCB3206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27C76E15F;
	Tue, 28 Jul 2020 04:27:43 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E336E15F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 04:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzBNvbCzeazZVqfbux7B2dZ+YRHSoT+YOGBFF11YDj/nw3MTc6wOfVUWCKmCcL4gDiZgaFUmmzC4Ny/bp7Lch8iBqyduSFX2FHnK1dhgszKid9RCahHM/3+TH7N1uPMdLdJiRsplE7HCsv09N3Jy6z28O/vAgogdYnf0SKKHOsNdJM2evc3MufftIQY0d+PvgdgAC8yl8rvE6a4CYB+XjAvn8opmTCZvonWPpB+MWwrD9zb9mfS/xDBh+VLdulSHta2/WXGl++7qDR7HbNTEPo2xapRTofBEjdkpjqqIgTNN7qKtqWW9EpFBDhjMXSnvIIzX5peCmes0sLYlMs8zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFm4i2NAU3v3dCo/Kj3Io1mriZejlxLVouNV6uyHby4=;
 b=cmPjoBSFJDqaTDg+7GClayt6X267bE79Ux7RT4QvN7KkHRCcSOb6GQx00iybY/6l1x6BQy9MyvBgggzo+6mZBkqknENdG8rBf6YOhcC8RaNOx49l2fTWzh1Oy/0rYI7Xes+2MNpTLlw6ej2zgfvHESr7pYHX7w5an/vX8Sf2S+wc6NxK+2Qbdh+pLyE6K6YrpGxYzC447raD7Xpk0ulQxAT4hscpNUv/cPAmDGLNglqWUXg6QZqpvxaY3x6hW9WLKeaZoGoHUP6pwlP7TrlOrtFa0MKctK4VbSsacUVxvJfqkUU7yKE5UL0WIGZ2ooPZ0+EngO7/wGmdUbfq6bU/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFm4i2NAU3v3dCo/Kj3Io1mriZejlxLVouNV6uyHby4=;
 b=TUUbhNMmlP0rhXHEsXWf129SToQrq5ZJ5b2yeMI4WXjvgZ6ndVCWPrplx5Ju/SaZvl0A27t/i9zHMDrCIdOAXugmsoLo7rFrZRQS2mmTRogicwug9/KB5dshRmiCM4VtPx//J4V4BZyoAqCBEBy2uAVQqEF7LyvQ+JkaDgj1zg8=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1621.namprd12.prod.outlook.com (2603:10b6:910:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 04:27:40 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 04:27:40 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10
Thread-Topic: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10
Thread-Index: AdZj8ChRB8kbyPg9T927y1qmSWUoxwAAomPAACXuepAAAz02EA==
Date: Tue, 28 Jul 2020 04:27:40 +0000
Message-ID: <CY4PR12MB12870D7638966135D91085A8F1730@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <DM6PR12MB40262ED0408E4FD14160D1A1FB720@DM6PR12MB4026.namprd12.prod.outlook.com>
 <CY4PR12MB12877CAFF60DAB4B6DE3492CF1720@CY4PR12MB1287.namprd12.prod.outlook.com>
 <BY5PR12MB40196338BA23F96BAE77652AFB730@BY5PR12MB4019.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB40196338BA23F96BAE77652AFB730@BY5PR12MB4019.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-27T08:32:21Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=af532301-b71d-4340-96dd-0000519c31b9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-28T04:27:38Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 2494f518-ddba-4364-89fb-0000005f85c0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46087f44-ce42-4ff0-2ad7-08d832ae90a2
x-ms-traffictypediagnostic: CY4PR12MB1621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1621D5957D3561E49FE26647F1730@CY4PR12MB1621.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AkyQ6AFbnmceU54A0/8Po657iYCiUmn5/Y4k0+HsVfjug06YdbUYO38v/AZ9/KLi9UdqXx4ZXoRjyOMPBlQ1UdOYrMOGqJHHeJ4lrqPtyhM+yiQrAOIUReV2XtlS/mtJAnJryG4xv9Sc2oSgJRKKYsroqDlEm564TaeC89QejKRwo516GN1Ngy4wvdQs8IsnYIb9X+uq+HanolMgX0SAjkGJJWD0Hi3ozmVbRJLrxdDWEnlO1b3glpGY+1OmvDPY2bhvTheZpYhDQMvUBP2xd7uYqMQD5v0GkOV+gEFpjGwHNdLTjU6ohrRcU5+O7mMP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(6636002)(52536014)(83380400001)(86362001)(71200400001)(186003)(26005)(478600001)(7696005)(33656002)(8936002)(76116006)(9686003)(8676002)(66476007)(55016002)(64756008)(2906002)(66556008)(53546011)(5660300002)(6506007)(110136005)(316002)(66946007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gNB4tysnVEuBHPyBq5l9RKGs02uTnFnWDYQ+rP5pluJPCe1D/ECCKZcwtX/dxRyCvbPCdrYfS+blYMNTovra6S9xKasCoI5sq19XWYgcXiGPEOCr0sEQEKZgt/fT+JK76J26b80LRc+1bVCnJpsVPAha24dBqroN6GdkuzoYtW3dRYoWmqFiXdMdMdzGENqbJ7jjNOJ0nMfpThYMWTN/QoHGLJZSGUpxBxX5jzQt2lMhkt6yjU/4Q/RdkHd9py2tscB+/+dB6erMU+asdl/PEhG8YqPTXXysGUsay2C/1+Q++o5+cfDLipf4JSZU7oBCRBxjucp0js0YN8Ft7hPGabiMAamxo5JIWbFOsZJ+DK0GAcAwjOswRXXWkekkP30xGZClmxraq0cE2fCq+YrDGLc+pT7YTH5H0yTbdhNrCkOKvw8Z2qeZ5TSZ5Apbx0nDi7/fmU1tF09vkw8GplR7g3hQfezfW8fadA2wvU/s/8nXr1uo3o4hWFXa8hxsSOBE
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46087f44-ce42-4ff0-2ad7-08d832ae90a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 04:27:40.2811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Shn1ZWkQnYQ+qHytYfGeDt3UU+oQk+jryQRVEIV2NXGgTO1kCjFkgFgAjM7Xb6yA9SyyuvSN/POcVCUeNikgkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1621
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
Content-Type: multipart/mixed; boundary="===============2043592851=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2043592851==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB12870D7638966135D91085A8F1730CY4PR12MB1287namp_"

--_000_CY4PR12MB12870D7638966135D91085A8F1730CY4PR12MB1287namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, July 28, 2020 10:56 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx list <amd-gfx@lists.freedes=
ktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10


[AMD Public Use]

Thank you for the feedback @Chen, Guchun<mailto:Guchun.Chen@amd.com>,

I've attached an updated patch with the corrected typo and also an addition=
al change to add the new UMC source to the makefile

Thank you,
John Clements

From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Monday, July 27, 2020 4:50 PM
To: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>; a=
md-gfx list <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop=
.org>>; Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>=
>
Subject: RE: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10


[AMD Public Use]

One typo in commit subject.

add support for umc 8.7 initialzation and RAS interrupt

s/initialzation /initialization

With this fixed, the patch is:
Reviewed-by: Guchun Chen guchun.chen@amd.com<mailto:guchun.chen@amd.com>

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Clements, John
Sent: Monday, July 27, 2020 4:32 PM
To: amd-gfx list <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freede=
sktop.org>>; Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd=
.com>>
Subject: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10


[AMD Public Use]

Submitting patch to enable UMC 8.7 GECC functions in GMC v10

--_000_CY4PR12MB12870D7638966135D91085A8F1730CY4PR12MB1287namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Tuesday, July 28, 2020 10:56 AM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx list &lt;amd-g=
fx@lists.freedesktop.org&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<=
br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you for the feedback <a id=3D"OWAAM9AC35672AFB=
14F88AEB8946109A01695" href=3D"mailto:Guchun.Chen@amd.com">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Chen, Guchun</span></a>,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;ve attached an updated patch with the correc=
ted typo and also an additional change to add the new UMC source to the mak=
efile<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Chen, Guchun &lt;<a href=3D"mailto:Guch=
un.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;
<br>
<b>Sent:</b> Monday, July 27, 2020 4:50 PM<br>
<b>To:</b> Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John=
.Clements@amd.com</a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists=
.freedesktop.org">amd-gfx@lists.freedesktop.org</a>&gt;; Zhang, Hawking &lt=
;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">One typo in commit subject.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">add support for umc 8.7 initialzation and RAS interr=
upt<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">s/initialzation /initialization<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">With this fixed, the patch is:<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Guchun Chen <a href=3D"mailto:guchun.ch=
en@amd.com">
guchun.chen@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Monday, July 27, 2020 4:32 PM<br>
<b>To:</b> amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org=
">amd-gfx@lists.freedesktop.org</a>&gt;; Zhang, Hawking &lt;<a href=3D"mail=
to:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: enable umc 8.7 functions in gmc v10<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to enable UMC 8.7 GECC functions in=
 GMC v10<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY4PR12MB12870D7638966135D91085A8F1730CY4PR12MB1287namp_--

--===============2043592851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2043592851==--
