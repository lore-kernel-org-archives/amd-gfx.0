Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FC5C4743E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 03:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C03C6108D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 03:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C03C6108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5DEB6E03A;
	Mon,  7 Jun 2021 03:24:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8961E6E03A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 03:24:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9eEN6LEtknyaE1Hb0I+Su46Yk2xOgrCdQfjOk1Ugy1RqjQwO2+DbtblvIS5qKNCFHtDV5FrAvaXA6y7kDV2BXBJV1xXEQa0d2AqqdumXmXEieZQ60G7Mm5VtA4vYxaGB3y4SE/QqF71IfvuxV0kl8FuPw1uRsEU8a4HA4/rlUSgSTKYEeDq3Tqbly9jZUVp1j0NKOor6o97ugXXq3k/yvtdmXnIFwij7IA7oHndcoCa0KxWDyXENjFAxOzor1JqS/QHGqd8PnsNG49jiHnkkKGifaoF0y+wW1MHYzOKSWKxGtG/bVSzOK/CrROtS/EPYklguyvkRDY7ucV3tf+e9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEIXKS2gLit1o2Bp4h34/tSFKh2LXHXWkWwc+3g1epU=;
 b=ZrRmwl4YWwHrpGcwpYv1CGMV0zZiH+U+M5jsVX23NUjdldGXS2KaiSVvSw9ZQ0N7ktBKqyNVwX7K/KHBP/035NeQ8stwK26YQjRyC/5/XA154BTekgPryaqUW9xC7VTL+Lb5+jjKgORmqN6RdByaO7QEts0r7/SYm2C/EG7/pF3V4ESmkSdEB1KjCufMGPyh0WYZ72ab1GOm20eJYeMqkK6vWluVkOCPvM4DOfbN34GqBMoGV0XEC1dbeK3l+87QQyBZsvvsU/Ved5GYArsSLdLxjfy6zoXsXqRxKIBGbEy3XjsI7dnr43/akVTSYKPmK/uMrc4rQ9RNCI+YvL+Xgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEIXKS2gLit1o2Bp4h34/tSFKh2LXHXWkWwc+3g1epU=;
 b=dPQdnO7kPqJnO5xpUcTwy5Iwes/ShROChDTjbZ1oYTjIiYUMCG2gntomPe8SD5X6/A497LuqxPxQt0YSqlxFLxdjKHzrXoqhT270AjnyW0lCOK6ShLtN/TGlHlNbnL6odsb1ZlV93J1XHt+DtWmKqHHStFZLiuvbezI9Tp3oR0A=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR12MB1168.namprd12.prod.outlook.com (2603:10b6:300:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 03:24:17 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4195.029; Mon, 7 Jun 2021
 03:24:17 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Topic: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Index: AddbStf9BnLmUUpcSRKXKLQG8fAUEgAAWcIg
Date: Mon, 7 Jun 2021 03:24:17 +0000
Message-ID: <MW2PR12MB4684DC8F0A9FE5BE2189E4D7FD389@MW2PR12MB4684.namprd12.prod.outlook.com>
References: <BN9PR12MB5226F943C24139A71502430FFB389@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5226F943C24139A71502430FFB389@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-06-07T03:12:37Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=df1aa59b-160f-48b4-9bcf-cc154c83c10d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcb835bb-1b8e-405d-a8c8-08d92963bb8a
x-ms-traffictypediagnostic: MWHPR12MB1168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB116867C5BE30023DE3E40A7CFD389@MWHPR12MB1168.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cj1y4T6LoO5MlY0q9Ph5b9hAS/rD4eZFFGVmQLIHrtSX1iua0RBHqTI97Rx2X6UcEFE/Po/XQOt4K0NIho/Lopp9lk8rCsSEkfoSB3k6YeB9c4+WJqHroGreLL/S+Vu5EtbLB5ohH+ePMQFPEr6wzUBkQHRV6H7lqXVhkVENkwjh5q9XAXBjBvz+xo+ihFKneHD8mz4xFwAoq2+zU/a7cvS9UOU1LI/kA8ZImyxnAtNmx7DKF4D6MPpfgG1lsY7Nk4mqsjDaCnQJpC1xb36y6158DTm0aSlvlAmz76XHs0rPo2ChOm7rd2edRShXcgruCkewBrPVPTqb+eA/Nh5iqbKPTN+SPr7+FWlaGYDxxbGG/nyelBiP7v8hiWuc6Fg99s5uvfXSqot/1J5c81dsdYckDyrwBkUSLEPzho5YPP5Hkgjlni7x23OZWkiFSUB1JICC46oJtPDzllH+8Y05EbOvLyOyjVEPKt/ghDJelCK8VzasfE9tJXS/p3sCPWn4F1IaA8mmm89AM4N83ypDfmFuEbQDdKDcRclEmZpnY0rK+WSkdNsvz7hc6jmEi1I2tcVBvdb5ZDvUF7pkfB1XYUe732W+qqyJDhMoA7k0nlA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(8676002)(15650500001)(110136005)(53546011)(316002)(8936002)(9326002)(6506007)(2906002)(4744005)(26005)(186003)(478600001)(66446008)(66476007)(64756008)(76116006)(66946007)(71200400001)(86362001)(38100700002)(9686003)(122000001)(55016002)(52536014)(5660300002)(83380400001)(33656002)(7696005)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rSe0ibp1+lWuBlcgbf0jbetVLgZG5Xz4ngguCZSyc8sjf4dBVRNIjyDs07HH?=
 =?us-ascii?Q?cUbjDnUb/N3DC34o3lF2Z1HZorxlX2l4e9J++lu5vqv2GmcxuAKx8BDvc+XF?=
 =?us-ascii?Q?nIopeptYuVjPoDENDAQSWNGhvZn2XCREwh7RY8eFmq7yzCxVeOCgRMHYL1xS?=
 =?us-ascii?Q?12pe08j907zOpQ8En7pGvXDPiBMO2oDOmdziE71gi+trJ3m9cXHKVfGHjzFW?=
 =?us-ascii?Q?mRG7xUjPgGgHfdt3PGrdRo+AeWKWQOUz4m2oDXr4cvI2x6oX4ZKUX935T6ms?=
 =?us-ascii?Q?Gwwe12DtkVGfjo+aDjdYmD0oo7d7/NzwfXNc4KC9K7oUWgEOeGhon32cPYdP?=
 =?us-ascii?Q?izodwDDpee9tHkfrkH0RNQFCCDPRxhQNobA02r/I5pDropKQJLK+r9Lk6qUa?=
 =?us-ascii?Q?j6Ns40WDohK3fayD60Cko+PQCCWHWHq8Nlu+AP6USgHXtLlNBHjczTuf+3h8?=
 =?us-ascii?Q?IA0jk7+abtOdS49R/hE5xln8VNSjNEncdUpjyt8WhwTzRpfgEPYaJfq5Gt9u?=
 =?us-ascii?Q?Z/BGXojIyF4s2g4VVqwC8kFMR5TyiEF3x1rExNDO18MW9CdhfZsCs+ibBUBD?=
 =?us-ascii?Q?zjXQINVvrL5OXy9WkUN6QCgb79urxPS/qY9lwsqesMrp1drCWQY5AYmcyGwq?=
 =?us-ascii?Q?EtMBkapSGkUFvoJw984vOUH5U0A4osPK88tyjAqrNxWr6iXhlLmD9kGwbD+P?=
 =?us-ascii?Q?9lmphJg6BBrfO+KBYYsb/RV6JFcO3MTzJhUuAizf2Qm9JbYmkaUJ+hFB66vd?=
 =?us-ascii?Q?6na4qI4KK1XmN9fwzd7dIY09nhjjW4Bj9ttvCZzAxZAb4fEJuEwreMmKPWd8?=
 =?us-ascii?Q?KDp4/jaakhf7o3ECIH9y5jZRL6xS4+7CuJ1jYt4IorInM3LlLFWqtD5jqxwY?=
 =?us-ascii?Q?4Nkt2IWVYhrUL3iyrRVGMQxM3H3GpwpCpsPlFZhktk8zTlLJnH9ifa4BUeQl?=
 =?us-ascii?Q?WOBvEM+siX9Pk1Lh0MSkSSUsRkbHBqHDrSYWBRYXmYu7Q61ZO/OOymxETkWj?=
 =?us-ascii?Q?sDleupa2wNSpxlur0hFOiim4qpMpT3Z0Bv3KZZ1aZvRT/meDoNhYrWA6+3ed?=
 =?us-ascii?Q?uhi25blVpAfJNCSM6GhrqQO0A3iyb7PawE117fGz2OlidiDR9x9KsoeGdp7e?=
 =?us-ascii?Q?glzvCcC+0t3sx6YZUic6jm45XTdq2MSH9pic8N+09jyqjUGh60Bi3KX0JRyZ?=
 =?us-ascii?Q?zqIbpR6j4BwUSCot6OfOp+vXfd3kKX3GvR1HLs3oYrognOir0ngHPBfH2xsW?=
 =?us-ascii?Q?uB9qjaVbYwMkd+IZdOXZGLDDH+wC3FF8ZPRqZPbaYAv1eC5S3rN3nvtTnS1M?=
 =?us-ascii?Q?WxqFBVG6eUCNr6LrrD5eHn3S?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb835bb-1b8e-405d-a8c8-08d92963bb8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 03:24:17.3394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3s9F1KwRXrpe5g35+A3c05w7u8Yrd1KRT6+ZvMZxCR3n8w6mrfAdnfYNzmd539YyqvN4+edSALKKW2IjhHjcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1168
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
Content-Type: multipart/mixed; boundary="===============1492183854=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1492183854==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW2PR12MB4684DC8F0A9FE5BE2189E4D7FD389MW2PR12MB4684namp_"

--_000_MW2PR12MB4684DC8F0A9FE5BE2189E4D7FD389MW2PR12MB4684namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi John,

I think it's better to replace
if (adev->flags & AMD_IS_APU)
with
if (adev->asic_type >=3D CHIP_VANGOGH)

As you say, rembrandt should support this feature.

BR,
Changfeng.

From: Clements, John <John.Clements@amd.com>
Sent: Monday, June 7, 2021 11:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: Update psp fw attestation support list


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to disable PSP FW attestation support on APU

Thank you,
John Clements

--_000_MW2PR12MB4684DC8F0A9FE5BE2189E4D7FD389MW2PR12MB4684namp_
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi John,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I think it&#8217;s better to replace<o:p></o:p></p>
<p class=3D"MsoNormal">if (adev-&gt;flags &amp; AMD_IS_APU)<o:p></o:p></p>
<p class=3D"MsoNormal">with<o:p></o:p></p>
<p class=3D"MsoNormal">if (adev-&gt;asic_type &gt;=3D CHIP_VANGOGH)<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As you say, rembrandt should support this feature.<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">Changfeng.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;John.Clements@amd.co=
m&gt; <br>
<b>Sent:</b> Monday, June 7, 2021 11:13 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update psp fw attestation support list<=
o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to disable PSP FW attestation suppo=
rt on APU<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MW2PR12MB4684DC8F0A9FE5BE2189E4D7FD389MW2PR12MB4684namp_--

--===============1492183854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1492183854==--
