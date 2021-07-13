Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E3EC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 09:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08CF61158
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 09:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08CF61158
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF7E6E060;
	Tue, 13 Jul 2021 09:39:12 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D656E060
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 09:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT/rfXMR78GmGiD1suDMxwznpL7i+xj/tOuLt9ipuUDeScfC9jbLsxfBW0iNpbNXtdgfoI/e+f8C0V/AjChXtsFKyLNzXbNlIoSHFNPXCpUnH9BNE8xsiclnwtHrgzD6MfsH67rqIvJRWUL/ESfxVqARqsEwk/yO14JlbunPhsnuRUjIvc+WoZq+JOZkMAVLxlHUcf59kI1a9tFCR0RK+LvPf4Wd1nAKl2x0QQ+NIYRInMyN1uUkvwZ2JT9yMwQkh593vA//wg9FgldE34SzfG6qdt6Q2jK4xKCzBBr5xsF1RypLD54uJ4H8lSJlPom4VGlNkEoGewYbXwpxg/KvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNDTorWIjtb10ANst4niRC+WC0b5DROqipEzVXkj+68=;
 b=TLe6YFju4iWfpKGKfFnfubXZObGcLaCWn3O2rQo6HUv9aHEFw1cLpdaFTjl7mvvn3Tx/ibcxa5FzOuC6jJp49kCMxYrCYjpzhJfZWDGJ+FE/l/pLOZUb1zow+TGIF26JscCEsFC1Qh0f+qMXPiUDQY3lkM4BVbeR689+Qbl5T8OAbAR/N+LMSwnMhROYAF2ttl20OHlEPM+ABKz4BWfVj7uOM5G8k8VRo3sLi98srOD5YWshD82eMB1fa+Yjr+e99/3rUp1DFuYDdq6UuN3Yj8y77XZyn+V4H7tqxLDqTh4Hkdpwf7ps29qeW+5BuM3AofwdxsiaPxLZSXsLeZ47Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNDTorWIjtb10ANst4niRC+WC0b5DROqipEzVXkj+68=;
 b=CrhC6Xqn77dTPv/JoO0wWCJIRX1rIlyUam0jR6CoSysc8qJu7EHd4Emq2cBw5UEovGoVvM9J4vw6aNzNZ7JNdmFGaDND2hQjDw0HCwQpXLa6qIBscbhdJPBH1MKseBVQoorG3BH9p6dDZYo3wAGakT/oHRgvgugSfIOyz02AOCk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Tue, 13 Jul
 2021 09:39:09 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5dd:148c:8b35:b31b%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 09:39:09 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset
Thread-Topic: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset
Thread-Index: Add3ynqQDrdXffQvTkm667otpc5Z8wAAFN8Q
Date: Tue, 13 Jul 2021 09:39:09 +0000
Message-ID: <BN9PR12MB5257A6F5F01459E9DB43B0DDFC149@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <BN9PR12MB5226592BA32F2E749A39B9D5FB149@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5226592BA32F2E749A39B9D5FB149@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-13T09:39:07Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=08f4fded-8b17-460a-abfd-361a8dc47a38;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59c53f05-9fe6-45bb-79a8-08d945e210e8
x-ms-traffictypediagnostic: BN9PR12MB5114:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5114A02432E0F54F47ECAAA3FC149@BN9PR12MB5114.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6bLCI8W+S860CKNLdcA8FYSqHN2EXFYDM5kQxL0jThN6slrmKqX9qfZMW7+n8GW/kKanirK5uXH3ta7vAo8b+H1mJ5wNlJsyllAbjIrZBifYEh8Hx7Kj2EHRG5FfGNSJk6UH0VRr+XauHJ/1ty3UIvV4yAbvQSc3YGKMucmn3CNJj63bxMOaop3aLhFx4BwUChKGpAQy67E1VoDVWi3ZKG17uaNgvL75q+EiSnGA7IgKaHGuMUc6RZUzBTyfcO4L0jTgqSyf3U6d1OpuqMV7y6jc1v++uYM9mkzfYxe5U2NFeQzcWnqy3gpYXQTKPRAXK5rU1tDjO6v4XX4MsDVdOoRT8KyjShVZ9M+o5SyvBiU1z8lDZGp5E56DAgwt+lXHJ5c9sb01SshYlat+DJ9bsVJx4joTfjXMKcB5P4Orp2SSQbC4JjxSBWhaxiuK1Bu3L8Ux5Zy8YkGClQAQdKr1T3lwP3/vFCgpw6wdxgHlOQJupNcwDzrcgqdwjFVSAu2z5IUhYt9Q5wYV+rMWlTLUYlYR9VrJK0B73mFGokJx8e4TSey2V3Ie84WW+4ocYiB39errugLBgP1NWTmG+Rzvb2w0u2hZHPLLnezuE8C6lVFuSwmXfL8CPIgNliL8wgU6yEqNVAmm10C2qCyq4f+ppw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(7696005)(52536014)(8676002)(186003)(66946007)(478600001)(8936002)(6506007)(4744005)(33656002)(53546011)(9686003)(122000001)(316002)(38100700002)(76116006)(26005)(110136005)(55016002)(71200400001)(86362001)(5660300002)(64756008)(66446008)(66476007)(2906002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fypr7XX0nNg5wPZvN7G2dQe3/kZZlPne8GRfqWsBNKcK/v7xsTt8X5Hg9rFc?=
 =?us-ascii?Q?RMZJyHHW8F6JzYFTGpo6N3xq7kK+yegzJXFuo4kn63jtjS4cHXem9yC+YPLQ?=
 =?us-ascii?Q?bKuRr3TD0Sz7uXFAXtglkEo56JQLhlrvHPRv8muh4Eaqn4pqs3Mqy1U5O/Wy?=
 =?us-ascii?Q?gR4zGZI/SFOqXvtKSwiBfInWW0xl5d7s0acMRrihxWWMPjBS1+PISM1p5ZPD?=
 =?us-ascii?Q?I2EKvZK5fuC71vLp/YZKRWImuZkyO5PyfkWsh/lICIf/GBrYhCrcp42R8Icq?=
 =?us-ascii?Q?h+LUbayRTM8gZquqxafUhyvYCnPRDzF5YBoK03iumEWSVgynrnqPB+J8UCUH?=
 =?us-ascii?Q?uGArdyaaOtvzfUv+soxJJlVzZeqZyq2QG7jTyj+AMZpk3g2hyuWxH0wlOQtU?=
 =?us-ascii?Q?VPSUnhJEAQDm1P608U9X/mBtof+PH8hSZ/7fDkCeKNpVLGbHDfh1LE1aYCaZ?=
 =?us-ascii?Q?Lt8ul5vQIAjtj5tNva5G0ZHWo8NhgABV7q9N4+UVG5h49jnp2ad3OPmZgk4g?=
 =?us-ascii?Q?fO80+m0NttYiesTycVKShDgqc71h1VaWE7Uq2Do9qCXFkmskksJCMgf19I5a?=
 =?us-ascii?Q?wSIUBHjRaWbZ0OfnSMb/S+kq0+EdVmSt02IYzFjdD0ski3kUbcicKxwNCa7M?=
 =?us-ascii?Q?ivzHxR08cMi6FOwDmJEjDqw5kX6QOIWMxH+NeuzZxSRtCEu1R8aiCf7M+jl2?=
 =?us-ascii?Q?aKx5euaFTlk6XFdIFnHoaVQ6VMlh1sOFj3Np2g+ft0YIlHRm/BtQHajFH2eV?=
 =?us-ascii?Q?aI1g1TDCZnDyzsWkYsof+PSK325sU+ij1mgFpbGMtpzRrVCZTdeCbhAdsAPi?=
 =?us-ascii?Q?/FLiojHKZlOPaLkRBnPg9U9r6H6SgLISq47loRibDBxVWkw/N6/8mVh2oAz2?=
 =?us-ascii?Q?EjJOpBsVhxW0Cu9Ml4iu82llU/OrQbuIE6Q92TP1wM3ojrboR5BlhMf7s0lc?=
 =?us-ascii?Q?ZEeXX3JvvNfH6/xMLjjjq14UcgEgurSrmfai3Ht5kF2Q15eWeD1JQ8a787O4?=
 =?us-ascii?Q?6lsXORsuJLVZAMZSKrRkK+DPySfU1fcBW5OmGRxywovDd6LW/PKAWcbKtEJU?=
 =?us-ascii?Q?o6oXXr+CjpL9Azr7i+wtuba0bcyu8Dtp5TTG2BelJfDI+SKkk6FNKuGIqEoY?=
 =?us-ascii?Q?IJKWktcdtl0s/bXuRwAGtyWvMtrwdMCZ9zGkkkLNEhq9cLcmrb/tyqMnI4n/?=
 =?us-ascii?Q?XV4xpqY5ai83+ERF9VydxFUPVzef7pl+gHntm7QGTGT6msrTLa/yw8Pgt8G1?=
 =?us-ascii?Q?mNJLcS+kS0Be5iW1AkFMK7lSZKZ/kE2+rXQbTnFvjDpDw/e4KzNH1e2qej4B?=
 =?us-ascii?Q?zcGM75hYQW2Yi3yjzpcfljrJ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c53f05-9fe6-45bb-79a8-08d945e210e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 09:39:09.6818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5dQmR1ubFNjJk125824U703nBFa1vER/Cpl2kJozOVogcn2juOdx6omU/6fNk2Lymv+aAAQfCb6bu18PiTvaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
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
Content-Type: multipart/mixed; boundary="===============0081358353=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0081358353==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB5257A6F5F01459E9DB43B0DDFC149BN9PR12MB5257namp_"

--_000_BN9PR12MB5257A6F5F01459E9DB43B0DDFC149BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Let's submit the quick fix first and then work out better naming styles to =
fix confusing

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Tuesday, July 13, 2021 17:37
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset


[AMD Official Use Only]

Submitting patch to resolve bug in UMC 6.7 error offset calculation

Thank you,
John Clements

--_000_BN9PR12MB5257A6F5F01459E9DB43B0DDFC149BN9PR12MB5257namp_
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
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
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
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Let&#8217;s submit the quick fix first and then work=
 out better naming styles to fix confusing<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The patch is<o:p></o:p></p>
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
<b>Sent:</b> Tuesday, July 13, 2021 17:37<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to resolve bug in UMC 6.7 error off=
set calculation<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB5257A6F5F01459E9DB43B0DDFC149BN9PR12MB5257namp_--

--===============0081358353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0081358353==--
