Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A7CC8300A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 09:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B912082E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 09:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JQtF+ZZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B912082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8416E160;
	Thu, 30 Apr 2020 09:12:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6626E160
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 09:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6wEiArYMNjC4tBvWH6gLeo+hGnQvd4jT/4RrcZO4WRsD3/psbwKP3u/qbqixQJKOHsTKU8DZtx1xWQLkQpefaiq45D7wqCR+9NdL6d0eCRsR/Lhy5wlSh+37Y6H6wrzHjeI9MlogaBg4HKZYnrO1g5ICory+E0PWFlii1ozYFkyBlPbpdC7juc/U6x+43ohyi2SHRyC2VCfL2UQbmYW63oEekHbVCjBvrJT79FVP/KlhDH5undg/9BqoLcwNoBDuAp/n3EXQerlL14IZTyPmKPjbqGYVExIwFVtUlD1OwN902FJLj5HRxlPj2Ka3Re2qwl3ZpKB+kVDWKtLYz8WCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkoxH2wLLgebZFtJxZye+um6AV2xj1jn5TCGJv7qecE=;
 b=hd+6POesxHb7J3t+UU6RkM208gwBoiWQtOCc/G9fS+bGMSHnUlC/MgM6JbkQ/N3JYVIIf7hRJrBlQfpQAJ3KhOT9rA70Z3AoD6rm21SbinTYVkL+SE+p8HmMy/ZN2OKPJNyyuyB1VjUA54/ALyWgHxF2oDkSvsL37AUu0kRzx9bMs/+CIhGiesgyW8O16OAHmPs5kjLBRw9x6l56JQh9fpHAh/72VmTo22TBLyURQxYhULmJPYYXl8TeadxX7dinPgFaqQMv+44IvrXc8eBNrF1K1EI0N6ugRp46+QILjf1ZkoHQYW1yT4Tmh0uajenjXhP7kRLTRdBFZ7qqU9A7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkoxH2wLLgebZFtJxZye+um6AV2xj1jn5TCGJv7qecE=;
 b=JQtF+ZZl8IubK0ch5knH4TXWv+jfeB60pJKIbiwVt6ORae6EwftQ49KPZH06qRZ4n44GMbAx6Tlnc791FyKA0OKF1z4kp/VrfesxHJo31uL4c0D4qBckQvPYQWfnc/eZ0VBFTWmkd4a9z/L+LpSQn6UJiV42UXsjeY3tVA4N0gY=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3436.namprd12.prod.outlook.com (2603:10b6:5:11b::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Thu, 30 Apr 2020 09:12:17 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 09:12:17 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update RAS error handling
Thread-Topic: [PATCH] drm/amdgpu: update RAS error handling
Thread-Index: AdYeyYG/vYosBN4rRxSNyF4zsEbtmQABeNvg
Date: Thu, 30 Apr 2020 09:12:17 +0000
Message-ID: <DM6PR12MB4075D9BDC635EF3E60B5AAD2FCAA0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB4032936B55EAF00E60424ED1FBAA0@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4032936B55EAF00E60424ED1FBAA0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-30T08:30:42Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ea86b260-2a5b-4fa4-a62e-0000db3ff5f0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-30T09:12:14Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 598b816d-9ca9-4eae-875a-00004df4bf75
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: efb31028-39b1-42f1-cfba-08d7ece69471
x-ms-traffictypediagnostic: DM6PR12MB3436:|DM6PR12MB3436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB343627AAC7C7D6549F55C574FCAA0@DM6PR12MB3436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jThWE79PS+5UDp+6xlAMeOfx49aW+WFfMj2yKUsrkQgeiNMIF1fiXt9g0f3YmIvA8UXHs3sTWWri/O7vN9TZRThZT8NaRyjcmovHdv/FpO9u5UkMISmh8czcrxvd6j594Ub1dzFfubnT0+qhB6vmoU7Wz6lyNWQGpy9WdjcZMqjfFJT3Q2aMfKM0zT1uY7NtdjVMXzf3w6+hsHC2VeK60nCUVrDfqaHyA8aQeS0INSk3NniJ+ieQIewvYf5s8mvLM9vkaHd0nXR9IGewmOZZMI7q5XpeL51YqJ7UdALAB/Ln8Qr+s6exWE0UlcdxI3VjJ5/8by/mYiUONLLgCaNE/a7KFHF8eLAf7z8pXG1q3gMA0AUAAYiE5OKCtX0TB/sbWdr+DWtl1NgYeTmbd3g48dE0txMD/AM4/gw6w3KAKvx3sGHD6HdXbsXVUs3XERrp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(66476007)(186003)(76116006)(5660300002)(8936002)(316002)(26005)(71200400001)(53546011)(52536014)(6506007)(4744005)(8676002)(9686003)(66556008)(55016002)(15650500001)(7696005)(33656002)(66946007)(110136005)(2906002)(64756008)(66446008)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: IWtcrHVsI80juHCj5cTXQY/3cKqAy8POlwkZxJ6U+DHCKmvDwWf2R5SVav+GvcxehQzBwkFtzQMWHgevah+QlL/2UpbDzDc7MiUDukoX9+Y1MGSiICH0AuTUu7POM9QPJrEcw16fqrbZMinCSkUQfRrsGb29rK9Q3fODucXcjDGW9EDmq8ZzNRZAwujoSoMaK7zPdJdX/KvDhyz4T1JQxQ49z2Iw1nVpY9JdPyhNnkH36nkghYLLHM7xl7DM78cgqH5Ex9wXupTOvXHtLYecaQmUwc7KjWPQC9wpeV1nZOs8JyugqiUKhwFbs8hE7rHSjGvqr29JlAnKfvLvHhrZdAu/9f1lEjm/Z8m4q5BWngTi2rPhDET2k8Y15CVrqePrsuDT8tzUMRron4V9BtRzViP5G5kuPA+qsnAJN1O6DlQhFP2uG1OxGUwQ/FhEU0ibfTFBS+IYGdFsbz1n2qfNR6tuTAbB+0VCejX593OLXnZ+nuldOhY1WK8m7BkQaj04XX/PnTLUwae310qJIHb/PuMcoWQiT9hMEhQhgtFGF5gYxCBQ3TPsFfuQRcy9x98tqjGfUTRx/Vt76AEvXHQ3DzlSYqmc9iCdYjegNpFRYYd+a2Uj8q5lIDM0sU8DfppqMg6uVc8P8QkYqQWXNv+hFLG6jawCnV1792zJb1EyYLKm/sJnspI9sOZVLEj7P2KFh3xPbc0pFjLZXQCHt5mPqVfGVK65S3/+LAduVpGd8z8JnNDX0SrefUSNkSl7+wvA27zQGQowjLAyf6pPa1WrSFdZwTbmQsjZ/Lh32kEnamM=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb31028-39b1-42f1-cfba-08d7ece69471
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 09:12:17.1841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b0iO4DhbwMNX5JKqDqlKmbLlpK1JIHEwmGQB1o14iQlr7bAefCp0U5Quq4VFRl52vGo1Pj80gZf8qsV/thNrrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3436
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
Content-Type: multipart/mixed; boundary="===============0795415493=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0795415493==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075D9BDC635EF3E60B5AAD2FCAA0DM6PR12MB4075namp_"

--_000_DM6PR12MB4075D9BDC635EF3E60B5AAD2FCAA0DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Thursday, April 30, 2020 16:31
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update RAS error handling


[AMD Official Use Only - Internal Distribution Only]

Submitting patch for review to parse return status from TA to determine err=
or severity

Thank you,
John Clements

--_000_DM6PR12MB4075D9BDC635EF3E60B5AAD2FCAA0DM6PR12MB4075namp_
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
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
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
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Thursday, April 30, 2020 16:31<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update RAS error handling<o:p></o:p></p=
>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch for review to parse return status f=
rom TA to determine error severity<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075D9BDC635EF3E60B5AAD2FCAA0DM6PR12MB4075namp_--

--===============0795415493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0795415493==--
