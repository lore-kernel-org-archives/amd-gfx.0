Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6440FC4743F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 03:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CFF6108D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 03:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CFF6108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBE26E0C8;
	Mon,  7 Jun 2021 03:25:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A026E0BA
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 03:25:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2zkn2jtjJA6o4uuYs4AwhpuIlJh91E5fu/yxeY0QgsQ7vfu5pk9ii31E/+eewTWJz+jnPXdTbKqixacRSacxYZCZPPzv6SqdyZzIsfXovu5dxojSulIWj6+yT2L6nKa4hRtUjNdO2eX+b7SFBYyYm6U7HmMrkmonGouWj2PJPKTdnQOWLGaav/dALn0wBByFQvFjUWvIvv2CDGrMILZG8hHwgXErqZQPJqYN+q7pPqn0xI/0opMh9+kSgqUIOmcT682fViNKAGLswoui72aqjeSu9wsGrkCfondn3Uy5tDLf1PtEgofmILMmX4JezgjFmh5B2DkmNh6fk8aVW+M6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bvV1TkiqOc9ZyOZsFzbafGI0P1IcX1sQWrJPcKY9cs=;
 b=brSLsbyAiteOgGGS4AK+fFQSnbm8wAlo5neyigpIUFWBwfxalAQcNEsNOdeIxOBlM4QnvEJ7JH7luIzHGVQGbu0YeqmHTxRCDIc7bvCPPsvRZJ2P4FD3L1bzXqhhSxlxMsGRAQ317094p/Khs4WyOc0OJZmTxNSHbrb+KsySicagD+YTCRJixlEPOP09gbzGe5ER8HExnPowbXRtRB84CeF2+9Br5Mk8Ps7OB7HU47ymFcuJDvfMqxMoM7my92oRghQU27SC0xXyB/gL5yhWYGGLRuQDKHdDLl9weQI9Rc666CN9uumMFVuz2yxUhboo1eEL5Yx26xkSmoy1yydiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bvV1TkiqOc9ZyOZsFzbafGI0P1IcX1sQWrJPcKY9cs=;
 b=iJWXq6RbpQ8DtEJTbrfmPOxw5RXtyz0X6v+IszXsjircqn9XgSMb5NisSNtlMBMIQOui7NknoeSIcJijdCkWTGrIM7kYEq2xz3NplNDU1uNquLWYLFbu+RHD1XTDvCKIYpEIhKza+iu7Q7i6QVBDNNjxWC6Tc4g2402QbfEr+Sk=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR12MB1168.namprd12.prod.outlook.com (2603:10b6:300:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 03:25:44 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4195.029; Mon, 7 Jun 2021
 03:25:44 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Topic: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Index: AddbStf9BnLmUUpcSRKXKLQG8fAUEgAAWcIgAAAcfKA=
Date: Mon, 7 Jun 2021 03:25:44 +0000
Message-ID: <MW2PR12MB468428878BE49B77326B09E8FD389@MW2PR12MB4684.namprd12.prod.outlook.com>
References: <BN9PR12MB5226F943C24139A71502430FFB389@BN9PR12MB5226.namprd12.prod.outlook.com>
 <MW2PR12MB4684DC8F0A9FE5BE2189E4D7FD389@MW2PR12MB4684.namprd12.prod.outlook.com>
In-Reply-To: <MW2PR12MB4684DC8F0A9FE5BE2189E4D7FD389@MW2PR12MB4684.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 354fcfc0-5834-4ed0-b580-08d92963efa1
x-ms-traffictypediagnostic: MWHPR12MB1168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB11687AC3CCCA8BC74BBC3654FD389@MWHPR12MB1168.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WcOxmk17Hct7Z8+rsYEld7IjZmLHwduVbHtniVZF+PMsAPSn6TuEAwyGPjeGAuG8H6/nxXN2c5Sq2B+QT7HwBeZZAAG+///8ZrKbR/FSfZNl0iXrJ/97Tp5/WMjD9i0dLhAOG5bYR0Bz73IRaTNUTgqiZR9APknIKHo1Ghz3DVtAiTWp+RZCw/nd8pQVUdnEZ/QmYJssf1obGe6h6QDhumqQOXi6vLBf6aLQOYNYV1ET34o55N37nr740COlDMbcfKJRgrV8kEsoBuiuchzhkW6nQ0RmoMeIJNBqIyxYeHV5ymPN8EVTB6nip5ojfmwFo0oC97M3MxD5RJhz8LsMLmYWGoezCv6fdt9bU/3tFlITc/REjSBsjAhLnqewSbhiTRRGL3PGfuBk8R3aI2fDQmNFN5e+1UuRZwzXtjto+O4gSjr/zA+fuV2nJhvioLZIWkUG0maUPyVvfBkLv5epRYW6mCKHPvNheX7ohc5SFfR/wJI0K2auV+If5TtE1Bgp5sty4B9xKI62qmJgZo38fEuqEM0KwE6qi2BYMJhuxLiQpr5hF+tcdKsyTLkZUpUkV8uwT8T5o7NveziFldAk5sZTJ2+gcD9XeiAdrHIeEQM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(8676002)(15650500001)(110136005)(53546011)(316002)(8936002)(6506007)(2940100002)(2906002)(4744005)(26005)(186003)(478600001)(66446008)(66476007)(64756008)(76116006)(66946007)(71200400001)(86362001)(38100700002)(9686003)(122000001)(55016002)(52536014)(5660300002)(83380400001)(33656002)(7696005)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+TTj9G64z77YpGo273GuvRFIUlNVjjbz3kqzD7sg8JH1+H1J9lhsTE8Mv2cV?=
 =?us-ascii?Q?YAJCklhumNZl91kyZsB3alMcqRnruZxi1rFd2bV0Zn/LBrrCEGc1kUcee6BU?=
 =?us-ascii?Q?R0rDmrxhzuib6P+/yk2X5ZeHwUGFhnIbU+zx/ScE6OCnn5gMBjdOpC+YD4YW?=
 =?us-ascii?Q?aB/M/BYV7HwGVfzoav9XKHB1Qp1If3GLrJVbXXNjy+RlpZaoeRho4FzG+GYB?=
 =?us-ascii?Q?UbDPyME1vqxlGw115Ie43707VyK0KDeJeCJ0tuowyEkKcsxI2JWlWeKmyJa6?=
 =?us-ascii?Q?qAq5Fs+MmB+bZLfuhffV2GFAnw2D7OnSjBoDvPyL7dM1tluJJci2qVmifnm1?=
 =?us-ascii?Q?43ldEAfO6AcPjTggX8h8fDaWpluI/Lm49aDDgu5YLVd8b7KsWg4Sy/4qZC3S?=
 =?us-ascii?Q?b78v+Xw2odWf/WmchmNJUtOnzDgGeau3RIOxCtS1ohtHr9HlmXzZv2c38/f6?=
 =?us-ascii?Q?qTxQDMAdJq5wmu6DtT3Z0nkCTd2mITKkRuSAeGAVQFGx1wDqcvqCL1F1If1F?=
 =?us-ascii?Q?Q5Lvk9Bp1vM5H9ScVRUokTWy55R/zHUS5Z8goZ/qUrtpGlLtF0JPt3csYgRW?=
 =?us-ascii?Q?edF5NOMUEA0KC9caF8uWZqTyRgrNolfjQuvxbrZ9G3LMx24HNPlBCfD5C6F+?=
 =?us-ascii?Q?YuYYpCfBmBT6DeMMPa374GLkBxCM9Cjss6Siw1tV1/of6R6uiYfQ52OhPruk?=
 =?us-ascii?Q?hcHnOw8s9e/YWmByZDbN0Ii/oXzdkRuT80Vj2Izh2+ASFnr0oAfI5A3z7UHV?=
 =?us-ascii?Q?DPFws8VZ1eyWT9gOUa+H5/fu9dPrGSULqw5CQQsLvFXPDKaWzt6xb0kwZTdr?=
 =?us-ascii?Q?Sa8qSTBBffVvCmaywCJa0A3QC9neWPa9lNCteh+Siu5PimU17nTBm1vYRN07?=
 =?us-ascii?Q?OIGsmxJtvkQIgzCeYPWxoR8z8yd/SuyYrv3q0rQc45mcdppkknkoBfOv7Vg5?=
 =?us-ascii?Q?6xNq/r1MCdN5i8LfWBHaToOF+zz0zrH6Ped3w70TAaHr6T1dSugLmAe2nIPB?=
 =?us-ascii?Q?sS9iH11QiGJZ2YyKSsZxC1SZjzSdT7YhpRIdTV8gfix3e9//FLYZfa64dqBE?=
 =?us-ascii?Q?r+LUrN4nvTtQ3XKmQeU+WbARhR0aHOtPFWCuMG02wu/uNPq6UVdU0P0nDS5j?=
 =?us-ascii?Q?esJnbjxiVNF6HR3pIPqW9zSsR5wH9fNfexPFdmm6tNqbcxvAIqTKd0XNYZja?=
 =?us-ascii?Q?dVj/kEVaUyjHKDxCgAg2lTZSbkhv7JC6rNWjq02GkZfBBg7fW52StU+bT7RG?=
 =?us-ascii?Q?31bz3gw9U2y4aSqxTyfLCnawvfRNK7gA3sTy4cs46WmCgeYImHApjMpYZT7H?=
 =?us-ascii?Q?H6UXjCZ0hxJRl+6xLbpgdY98?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354fcfc0-5834-4ed0-b580-08d92963efa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 03:25:44.6760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLsmWVqwEYiEciH403iJvVTgtqpUEUPohgKZW+tTqiEiwTdv9u6sm/VI7mPuzb/Jtf33UpZNqMnRKof3QwK0PQ==
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
Content-Type: multipart/mixed; boundary="===============0862474224=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0862474224==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW2PR12MB468428878BE49B77326B09E8FD389MW2PR12MB4684namp_"

--_000_MW2PR12MB468428878BE49B77326B09E8FD389MW2PR12MB4684namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

if (adev->asic_type =3D=3D CHIP_VANGOGH)

BR,
Changfeng.


From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhu, Cha=
ngfeng
Sent: Monday, June 7, 2021 11:24 AM
To: Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: Update psp fw attestation support list

Hi John,

I think it's better to replace
if (adev->flags & AMD_IS_APU)
with
if (adev->asic_type >=3D CHIP_VANGOGH)

As you say, rembrandt should support this feature.

BR,
Changfeng.

From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Monday, June 7, 2021 11:13 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhu, Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>
Subject: [PATCH] drm/amdgpu: Update psp fw attestation support list


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to disable PSP FW attestation support on APU

Thank you,
John Clements

--_000_MW2PR12MB468428878BE49B77326B09E8FD389MW2PR12MB4684namp_
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
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
<p class=3D"MsoNormal">if (adev-&gt;asic_type =3D=3D CHIP_VANGOGH)<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">Changfeng.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Zhu, Changfeng<br>
<b>Sent:</b> Monday, June 7, 2021 11:24 AM<br>
<b>To:</b> Clements, John &lt;John.Clements@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Update psp fw attestation support l=
ist<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Monday, June 7, 2021 11:13 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Zhu, Changfeng &lt;<a href=3D"mailto:Changfeng.Zhu@amd.com">Chan=
gfeng.Zhu@amd.com</a>&gt;<br>
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

--_000_MW2PR12MB468428878BE49B77326B09E8FD389MW2PR12MB4684namp_--

--===============0862474224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0862474224==--
