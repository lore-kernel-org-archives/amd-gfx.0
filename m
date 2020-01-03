Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B52BC00523
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02CF21734
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S/KlYkXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02CF21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DDAD6E19B;
	Fri,  3 Jan 2020 09:00:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290B66E19B
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 09:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GET3tyvBD4wZShIe8jFFyJMJGtliyGvLuEzJ5WgtVb2B/d3LQEyIEl7zGcYQmuhS1KWiEpw26oXamoLOs7uz9ZWogF3BvQfb2pmLcV/JJarCiOAkHY98pRbjztjYy2deYFyDM6Eyr61lEdaMhoKL/0sflnTFpnzYMUIm/hD8VGuOHiXg8CfGuMCyI8ffGl/No6hGwcJ6ac80xolLeNh0SJQrpctF82ctGg6JJv/zub46hKmFWC5BxcTwJRW0uunO0aUBGRgThMmSSsCGS8tRbRJyf9eShCV9Cw/GDYKnwd1zLOkUIRFqJ7bfXjXHRKb5FYH0/vNPwaaZqIad8GPJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbVa7A6JccFPfwRPE3Q0L8Iakm+84z/6f2hT00gcgMw=;
 b=niawczGzo8WOvBkvCmWhl9YkQu0ADoiOi1e0zLA8sM+nqZKaABQsNuBS+WQomsKmlkThBDzYXH8j4/uC0Rc6BFkwQwqv8K7oAMOYS5iwH9mw6UFBmFPD9hM+zKKTWhq5oQ1jw/UDLbXKVEVXxQnHmGKr+lJavRtQd61JZuBntN8nyLvrQcBWtM2IjLTTCEEs3MbhJ4dU9ybni9C+yvAm6hMihAKQR0o3tmMzVtadVdUTtaSExGAxkoQwasysrRRSw7aARTGyDB8o/ieRGuY2tOtyuq3R/hiGXZflpNdqNoivDC8o7hOR3Tg4+yIswzNU4Oa/rK32qEpmvu1XMJuH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbVa7A6JccFPfwRPE3Q0L8Iakm+84z/6f2hT00gcgMw=;
 b=S/KlYkXaPwVFhcwG6iINJ7Xn6XX7cf21gKH6kyiiJOG5cPf2DUeoO/h8mLpSCVzAzHb9ZwbaRhm7CTDmb1ca35pSOV9DmvKPaoX3LQ7NVKiiNdyb7W1OGVoe4Hyzy2X4P5p9OqclX1qSyNWNBJ2iq02UR+EVqJLD5NXYP5KPtdw=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3856.namprd12.prod.outlook.com (10.255.237.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 09:00:17 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2581.013; Fri, 3 Jan 2020
 09:00:17 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: added function to wait for PSP BL availability
Thread-Topic: [PATCH] drm/amdgpu: added function to wait for PSP BL
 availability
Thread-Index: AdXCB2B4i8QiXMejQxS+NxSqo7TfwgAAgVmAAAEErAAAALFhsAAA+WSQ
Date: Fri, 3 Jan 2020 09:00:16 +0000
Message-ID: <MN2PR12MB366394FF55FCBE27B55C9FABFB230@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
 <SN6PR12MB281373E1EB9C577F0649C81FF1230@SN6PR12MB2813.namprd12.prod.outlook.com>
 <MN2PR12MB36632C11B62C60C12B5342F9FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
 <SN6PR12MB28135947A65B1EE1598FCF58F1230@SN6PR12MB2813.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB28135947A65B1EE1598FCF58F1230@SN6PR12MB2813.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-03T08:33:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=11583e56-7d15-4c56-85f8-0000f128571a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-03T09:00:12Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c2b2379a-ecc6-4de5-a1c4-000010c4dc26
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.235.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cc85661-c3cb-44ae-937a-08d7902b5a73
x-ms-traffictypediagnostic: MN2PR12MB3856:|MN2PR12MB3856:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3856ADF274BA4DB957B1155BFB230@MN2PR12MB3856.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(189003)(199004)(2906002)(478600001)(6506007)(26005)(186003)(8936002)(53546011)(7696005)(81156014)(81166006)(8676002)(9686003)(76116006)(5660300002)(66946007)(66556008)(66476007)(66446008)(64756008)(71200400001)(55016002)(33656002)(316002)(52536014)(86362001)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3856;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oo0xXeixlBQDCMlr8A18bKOPqLxw6cIE70JQ0WaYn7uwvztynN5q9LMFYCcgskNVTrvCuNxNOS1tIBGAF3BZVbwz7dSL0NELqfTPxv91PJ3/3uo+0TDUe6DTnejPetEqeVL8MkAF7XOabga1/HQDvaXILZ04wvdtZ19o6CbizbmOknpK20Yw6J9psPikfqJyckK53H5u7hv60tJikbnintH/XB9/vQE0/g8vVwG8+2kHN4uYh07r9/fbnW61pavxcgrqk5f6nDan/RYHsVsHHDJkEFnEsdldjaU5c/ijkRb5BfKlkiNjDq+qG2FtxG/gdnvbb95+zYOStFuQfbZjDvK/w9716jDchtokA18UmP0Cop+Kouj4lJnUaSjv4jH4jyC8XPWhNofbNc3TSzCvjpRVlIxZdWtv17wdS+bv6MuHctG8jZfn2pfWuvkBE14A
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc85661-c3cb-44ae-937a-08d7902b5a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 09:00:17.0082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXfHn8E+GJCkNBp0Wvt73+CHR9FnBJDailtGlXWVPgM6tBg8zKhgMIJg3C1ICpdV0u7T1iqGvIDtioqBUP+UDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3856
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
Content-Type: multipart/mixed; boundary="===============1387895311=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1387895311==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB366394FF55FCBE27B55C9FABFB230MN2PR12MB3663namp_"

--_000_MN2PR12MB366394FF55FCBE27B55C9FABFB230MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Good catch, I'll update my habit with this

From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, January 3, 2020 4:33 PM
To: Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@a=
md.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: added function to wait for PSP BL availabi=
lity


[AMD Public Use]

Thanks John.

+            for (retry_loop =3D 0; retry_loop < 10; retry_loop++)
+            {
The same coding style problem that "{" should not start at one new line. Wi=
th this fixed, the patch is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com<mailto:guchun.chen@amd.com>>

Regards,
Guchun

From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Friday, January 3, 2020 4:13 PM
To: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Zhang, =
Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; amd-gfx@list=
s.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: added function to wait for PSP BL availabi=
lity


[AMD Official Use Only - Internal Distribution Only]

Hello GuChun,

I have updated the patch with your suggestion, and added back in the delay.

I can potentially investigate its removal in another patch

Thank you,
John Clements

From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Friday, January 3, 2020 3:44 PM
To: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>; Z=
hang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; amd-gf=
x@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: added function to wait for PSP BL availabi=
lity


[AMD Official Use Only - Internal Distribution Only]

-             /* there might be handshake issue with hardware which needs d=
elay */
-             mdelay(20);

To be safety, I don't think we should remove this delay. And this actually =
do nothing with the code refine in this patch.

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Clements, John
Sent: Friday, January 3, 2020 3:29 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: added function to wait for PSP BL availability


[AMD Official Use Only - Internal Distribution Only]

Added dedicated function to wait for PSP BL availability.

Increased driver wait time for PSP BL availability.

Thank you,
John Clements

--_000_MN2PR12MB366394FF55FCBE27B55C9FABFB230MN2PR12MB3663namp_
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
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
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
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle23
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle24
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
<p class=3D"MsoNormal">Good catch, I&#8217;ll update my habit with this<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt=
; <br>
<b>Sent:</b> Friday, January 3, 2020 4:33 PM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; Zhang, Hawking &lt=
;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: added function to wait for PSP BL a=
vailability<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks John.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (retry_loop =3D 0; retry_loop &lt; 10; retry_loop&#=
43;&#43;)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">The same coding style problem that &#8220;{&#8221; s=
hould not start at one new line. With this fixed, the patch is:<o:p></o:p><=
/p>
<p class=3D"MsoNormal">Reviewed-by: Guchun Chen &lt;<a href=3D"mailto:guchu=
n.chen@amd.com">guchun.chen@amd.com</a>&gt;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Friday, January 3, 2020 4:13 PM<br>
<b>To:</b> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.C=
hen@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd=
.com">Hawking.Zhang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: added function to wait for PSP BL a=
vailability<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello GuChun,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have updated the patch with your suggestion, and a=
dded back in the delay.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I can potentially investigate its removal in another=
 patch<o:p></o:p></p>
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
<b>Sent:</b> Friday, January 3, 2020 3:44 PM<br>
<b>To:</b> Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John=
.Clements@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zha=
ng@amd.com">Hawking.Zhang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: added function to wait for PSP BL a=
vailability<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* there might be handshake issue with hardware which=
 needs delay */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mdelay(20);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">To be safety, I don&#8217;t think we should remove t=
his delay. And this actually do nothing with the code refine in this patch.=
<o:p></o:p></p>
<div>
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
<b>Sent:</b> Friday, January 3, 2020 3:29 PM<br>
<b>To:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> [PATCH] drm/amdgpu: added function to wait for PSP BL avail=
ability<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Added dedicated function to wait for PSP BL availabi=
lity.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Increased driver wait time for PSP BL availability.<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB366394FF55FCBE27B55C9FABFB230MN2PR12MB3663namp_--

--===============1387895311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1387895311==--
