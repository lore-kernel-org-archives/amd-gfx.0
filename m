Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D05C00523
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 07:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818C121734
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 07:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZG19wgjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818C121734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46FD66E191;
	Fri,  3 Jan 2020 07:44:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE1A6E191
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 07:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXasCZD/hxWIdpznGstzyWqepphkqnZH2TzmtqM6Iqf/nzeNuXsdWU1Wqd2JlY2x700LxNkVjVJ5OlZxwfZmKCRCp4iZzqUq1/RsLcjGuxdnIoljRDI+Mp9gu+UW+NYZro8e6M5vIQxYI/uNE5NLPugcVQvmbGTaNJug/VjuTVupFGy6hptaR80vsTY383xEGSIM4Tlee3IhbXhD2CciQcjIzmo1YVzNDnI49vT4/hv/2VSYF6LHCYu1McjDeS+Xtx4MsIT1UNiazxZFe9gxctsZn5gE8UU8JvKXf74Pxl3UC1d8LwPATWrQ0/zS0pGJYBakEr9mMjRiciLAXzaJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bMuiWTnlKRAZTnCqDggXMwqNOtaI1Y6soaHwV35Ig8=;
 b=exs1WnYLM5yUTKMhdjNSDBsxqJsbmDq75PqqTO4D/ccoiU8jbvkZepLZLBawnxNQk1PxhoIA5eMp6rHlLpgLrwIQpQgoyturFyEzZGvMmxHbjkZYuU7fVqd95IjdaA+ZsTcICY8v5iFEc2GNRPoat3/2vmqL6f83YgUJuQtU4LkYIXKkWdWAfpzKAqaFA6wiPfVEDp0iqhftlArFynbdLloOR0OqLX8TVdVTl1EYg/99n7Mhb+8VAfuua8UxTDd2WEUfSjkfAHKT76cjY97Jl7oUP5udzo0vofD4MuUSlndAC1BnQAaQKOEfc48WAmZfohapqqMSGKq/ZnfJBKWaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bMuiWTnlKRAZTnCqDggXMwqNOtaI1Y6soaHwV35Ig8=;
 b=ZG19wgjhGn1FPy4H4H2FrMzrV7eeefvZjC/iQsFcQwUPOJ7a6QJJhhifW5Aie+z9vPkHGf0GqpDA8WHvvm8CFiLZmh3t4fB+0O1MB6ZH47FjKkHBkY/GDkj0CAdeSwMZZ3EbEWTN7MU2YU2Ey1h8zwExlytAUIox3r/oXrwzJNo=
Received: from SN6PR12MB2813.namprd12.prod.outlook.com (52.135.100.27) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.104.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Fri, 3 Jan 2020 07:44:30 +0000
Received: from SN6PR12MB2813.namprd12.prod.outlook.com
 ([fe80::b04f:f4d9:a0c9:adc2]) by SN6PR12MB2813.namprd12.prod.outlook.com
 ([fe80::b04f:f4d9:a0c9:adc2%7]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 07:44:29 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: added function to wait for PSP BL availability
Thread-Topic: [PATCH] drm/amdgpu: added function to wait for PSP BL
 availability
Thread-Index: AdXCB2B4i8QiXMejQxS+NxSqo7TfwgAAgVmA
Date: Fri, 3 Jan 2020 07:44:29 +0000
Message-ID: <SN6PR12MB281373E1EB9C577F0649C81FF1230@SN6PR12MB2813.namprd12.prod.outlook.com>
References: <MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-03T07:29:18Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1e5af268-6c04-40c9-b21c-0000763fc5e8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-03T07:44:27Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2bf010ea-0fb2-47ba-b5c6-00000c2839da
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2dbef061-128c-47cc-fb26-08d79020c41b
x-ms-traffictypediagnostic: SN6PR12MB2814:|SN6PR12MB2814:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2814AEECBF4043EC0ED8E7FAF1230@SN6PR12MB2814.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(189003)(199004)(53546011)(55016002)(5660300002)(52536014)(66556008)(7696005)(316002)(64756008)(66446008)(110136005)(186003)(76116006)(66946007)(26005)(66476007)(6506007)(9686003)(71200400001)(8676002)(81156014)(8936002)(81166006)(478600001)(86362001)(4744005)(2906002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2814;
 H:SN6PR12MB2813.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BfCcU4KcIoh6vNn5EyUyDE+TjQ2PkPFR2Zc5Az+pjPhvoGuBk0s85/QmJYf+JWNq0ebSL9IE+eha9XBEsoRfPkEQB7lfz5Y35O7gB/fT+wM9BlKO03mjrH64RME1F1SIND4lQWXnD/KydfJCpC7rXYTHer2L0xKjn9JkBuq4ivUJdn36LnEBaXDk8O8oAscO3bsIwhMzD9of3qaOt5sjZDHtpngD5ZjWJeDvMNUovqK3S+FCsticu6d1YM4vG+/8SKWnQ30llPEUvsR/ReNYdAnBhO9P1cpc+4w8HOABYYvVoZN5gz072Q/lud3TnD81NHg5U4v6JQ5pHoKDGx78AFm6fxrMI+/pVVKaubCPcKuNDBULRQQLpFqDQAtkCmyEGr5F1FTJERvCQBunQtLO1+bSHdSBCbPtb9cUAr7/kMNs+GlCJ1Ltj42gF46SkzBH
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbef061-128c-47cc-fb26-08d79020c41b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 07:44:29.8106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oh3B7VgHJeGX50z58s1W2lYB+idQFH5t084B8qf3doE4xlInyDZI2nPdagJYv9Hto3SGfUa9nV1XXX9EwS9rDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
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
Content-Type: multipart/mixed; boundary="===============1435559708=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1435559708==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB281373E1EB9C577F0649C81FF1230SN6PR12MB2813namp_"

--_000_SN6PR12MB281373E1EB9C577F0649C81FF1230SN6PR12MB2813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

-             /* there might be handshake issue with hardware which needs d=
elay */
-             mdelay(20);

To be safety, I don't think we should remove this delay. And this actually =
do nothing with the code refine in this patch.

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Clements=
, John
Sent: Friday, January 3, 2020 3:29 PM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: added function to wait for PSP BL availability


[AMD Official Use Only - Internal Distribution Only]

Added dedicated function to wait for PSP BL availability.

Increased driver wait time for PSP BL availability.

Thank you,
John Clements

--_000_SN6PR12MB281373E1EB9C577F0649C81FF1230SN6PR12MB2813namp_
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
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Clements, John<br>
<b>Sent:</b> Friday, January 3, 2020 3:29 PM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
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

--_000_SN6PR12MB281373E1EB9C577F0649C81FF1230SN6PR12MB2813namp_--

--===============1435559708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1435559708==--
