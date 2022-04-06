Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00F1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 08:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F7B10F292;
	Wed,  6 Apr 2022 08:13:11 +0000 (UTC)
Received: from apac01-obe.outbound.protection.outlook.com
 (mail-eastasiaazon11020021.outbound.protection.outlook.com [52.101.128.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD60C10E2D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 02:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLqR2Hpdv8EvHu6ENN6FgHDDMVTgA/5xQV7tZ37t1D0Dj7QYuGghRcDyRXr6HsF9qWoy13PQ59lmjgq4KHWAzkK76xvbzO30bTmuFllMGM56CszgaMwquV6KUAAhweqQRO82I2joEa2q+tHfgK4rAtkzjxDUUS5AmP2WL3n6vkuTR8dIWdiFuIygpkW580+7i6YJozK2yLdaOpAyIGum72CNBtanye8jYwJAsxRBMrMPsEk2es/GeCgbSzhiTOOlI3HctsjUEouaQRF7A5bl1Rs0fR7hTBbGqAwnbf3l057EERxCOUPz2XDUOGGZODN434j7pg1yqJstmnxrk+T00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FeWOVKVaDaK7Jgrz3alDGfVcsorewbfYWz0ftb2jb0=;
 b=gM3iK3QRawgrmuUzDkM+hbfGz1FAf9svkBIL83pjtVixj5D0MmFYe5u97AmQgQlI7KFoehSPt/X9a93UOaQwwG3cxKOjx2Au6fT60wNzm2/pL4EWbtoSoUVSvJmeZygZ1DAcvhAs0wnytSiiVi4xM/EkmjX+diij0De5z/wkmH4k1Eb3wFKzrfR4Lr79NovWHQHno/8qRGZjvI/rYx6Js86e5jksvvTgj+KNYVopiW1o4YZD4ILF5B9WZOQ2Dz949vRAx/znVqNIWcBL7Il7i+nC+0g4ObZ78Xajl4kHK0dN89SknonAOvISKsvqoz9YIuDkjXLSRh2D0c6EqiE0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FeWOVKVaDaK7Jgrz3alDGfVcsorewbfYWz0ftb2jb0=;
 b=dAEdHLWwjbF2nMFQgMTc4IAeupISmb9R4VsyIoJCFn3Hh0HSmm+gwF0FktB9y5X98muXaqXL2+ikOrob1SEM1afbzliSF/RCRvZsQQ/MRf+4aLgPOCqovA7f2bCwGSW2XLoubb6zyTjbbE94wJ09wT71D/wVkHwOBWyUWN99MKI=
Received: from PSAP153MB0517.APCP153.PROD.OUTLOOK.COM (2603:1096:301:67::8) by
 PU1P153MB0123.APCP153.PROD.OUTLOOK.COM (2603:1096:803:18::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.7; Wed, 6 Apr 2022 02:45:05 +0000
Received: from PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
 ([fe80::c88f:d71a:2b3d:1c32]) by PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
 ([fe80::c88f:d71a:2b3d:1c32%8]) with mapi id 15.20.5164.007; Wed, 6 Apr 2022
 02:45:05 +0000
From: Shuotao Xu <shuotaoxu@microsoft.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Code Review Request for AMDGPU Hotplug Support
Thread-Topic: Code Review Request for AMDGPU Hotplug Support
Thread-Index: AQHYSV+lQh0DehaAkU6mUF/D9OJf/g==
Date: Wed, 6 Apr 2022 02:45:05 +0000
Message-ID: <PSAP153MB051776C60FFB06BB3278EEB4B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-06T02:40:15.0314855Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe567598-72c3-49a2-f35c-08da17777502
x-ms-traffictypediagnostic: PU1P153MB0123:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PU1P153MB0123CC7CCB7DCE905A0D7F77B7E79@PU1P153MB0123.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AoZtGrHr5xgVS3TQ6jqm9kGn33TAMPHlCARBu3LHdKE13m2xv6ZYCM6Lz2QXSvhot+jZDkHylb8I5SB6MJW3mK14UoHOQrhCBHOZBcRNcMKvIWmv9/jNQdDjhDpDNQle6tEE8DoN5J40DchPkuMI//Un8Lb1ffmIC62xB+dwJ2IfNt1oCMLQl7RurG2JyDib6tjY/CfhuyhvjplOOOoaQkRhCnP/4b6CA73wAO5iaAMepMX9XVR9PvvBnCVy9R0HqEenelDO2I28NQgM+uoDThayMdNvxi2e0HcXf3OtZj1K1DMNCU9dUaLWHR3na+mcquNFpQ1IhopF7OLEX7g/o9MmdBylO7Gru80q8f42vENGn9UV4TMuwluTb1y2xgTJmFHo7UrZrLO75TEztA01thEffiQv/j3wDXxeB/kBz+9sxUf++ZLF0HAH/QYvOSkVfdDCyEsVl2KE4J+4qdIJbmXvDwkYpfVmoOUiZaZVei4KajZsDBQKotB95GmIS8NDY8l/3D1YyMk298mkPKFaktuNUH5ddKQPuJ5HtpRnoTWSTYlpgbY6J9BKX93z7t1Tn9KqkNf8Va558hsErEcwh55ghjsJ/QJtaP1MPk9+xpf7QqPP9I3Qx9JZAz55J7itC6Kzl3MYEZllNb6+TYgebNDesH0arh3ez9GRo/StqDoFqQD8mVDZbwrw41/LygjNgRB88dN2uGEy5wbleOuN6+q+DwIGE1c8cplWJdb65UJoQyRDD5vobu3D6nR4LZrTadZP4xGioMzzCoQL2oKc1MrK7lvirjuNDb5q2gW7COypvvwhUiApyqPlZMZe0bO4NtpCzOk7AgP/iWTKMOyBaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAP153MB0517.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(83380400001)(9686003)(86362001)(71200400001)(2906002)(10290500003)(7696005)(33656002)(6506007)(508600001)(8936002)(52536014)(5660300002)(82950400001)(166002)(82960400001)(8990500004)(4744005)(316002)(76116006)(91956017)(38070700005)(6916009)(54906003)(38100700002)(66946007)(122000001)(4326008)(55016003)(64756008)(66556008)(66476007)(66446008)(8676002)(107886003)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Btc9ukVgOfxpLHTmE+e3LzUCTeagvnNWt6L2LB2h8NWhxIKlAjxPzQILZY?=
 =?iso-8859-1?Q?z8L0bARoiUbyh6VU45B6QgrdRtuWYh0t0/M931L9Z+8zyBS5DpIHQM2CQ6?=
 =?iso-8859-1?Q?DlnwaS2NFA1GrUNV/5qFb2Ozd+xWfcakqH8adD8KkgpZN/T8bsz4PgatU0?=
 =?iso-8859-1?Q?EsHTgwmXagw631YsmfKQeyeghkXvGjMCnocwOAOwXrdGpeibdsmnGD78t6?=
 =?iso-8859-1?Q?xTk5W9HNI3r5f+ygmIMZHZcz6cj9pNKVkMkiT7N909JcAhg2/m+CuYZ0Nh?=
 =?iso-8859-1?Q?UVXFJuaLAqGl1sbvYNIRQD26rl0IqkQODQyAO4PcAqnJH79bQt2+hhSYS1?=
 =?iso-8859-1?Q?5+a1ZFEqACfdIhXaCe3y0SzHxe9XzkbCp8v1b6Zx5CMpQb4JT+1VW5x7uv?=
 =?iso-8859-1?Q?RisHGMtJ564ZVNsyZyp55gY9ytx0Vh9Ix+CwxYsFVUyYse9ui9vGbRIy7i?=
 =?iso-8859-1?Q?lDaXfwcmeeci5weidrxSfw+uqTgGfaef64gxheRRlYLfAKw0jP4F+clb0l?=
 =?iso-8859-1?Q?jU17oXQF+L8WUd22/EK0G53bQboN8DjJI8OjQfB3WXuQTpDtsew6E9yEQN?=
 =?iso-8859-1?Q?/Kb/l6v0iFUPnTLjpDqw7Z3ZOnnanEtLcOHe2pEk4zSrBC4HUg07QIMiMS?=
 =?iso-8859-1?Q?3gkjIVg4ex1JmBqnVEkU3kT1aoQB2N4ioqJGyeH/S6we9Bo/BKZ9EPmnW3?=
 =?iso-8859-1?Q?plFOKRj6YgbgTUZzdo2G6DaIKKmSubmxwJV3Oq5qNq6DukAybdpEbGvT2N?=
 =?iso-8859-1?Q?GAi07R0E4Vjrpsmq/MDBiFWxTsCq1NhtrnFUaKeeidoFZ/mdFNkJG5cj3X?=
 =?iso-8859-1?Q?FvurTSZ7oz+F7PrepNwzR22DS73j2ssLYXgoTIdM5XK1hlkRoxCvbgikmM?=
 =?iso-8859-1?Q?W9S/lswWHl5pGS5pLve/PdAToSekUCz60NzzwdzuJaPtj9JWqk7cJM5nGp?=
 =?iso-8859-1?Q?jOxLhXgo1bdd0kQ4qtfSfGxjGMD/+0ctxjsaQ99iMYe0fcM0rguVoDCi7X?=
 =?iso-8859-1?Q?ljejSFUkbC4wvJUGaqP7q+JwYTgI3dPsAQgTcuN22Xzfs8LfmLu1588Cae?=
 =?iso-8859-1?Q?aPTkTWmoxSIT40NKQ4M/6j5bnsAQfeUruE1lklbXWKOcC78b0nmkUl2fa0?=
 =?iso-8859-1?Q?x1DI5uk8bH6LPOhHaFIiDW936VRcPrIATVYrVNhPUMbWQPMVh3AUzDhS1e?=
 =?iso-8859-1?Q?3M6tkedjWrHIaP7uMrHIRqe1aCfxvqMVCA7RUjIJ0FJlUUKyAHb3nvZWkg?=
 =?iso-8859-1?Q?ff7cQKcqyluBIkUrJ3qifVmoVyt7YiGihwqNy4vQss7Tobb5BTPfrrmpk5?=
 =?iso-8859-1?Q?Nl/gFk+tZIJXkgV/7yg99M2PKoJb99hZXFn8nu++AA9Coh5zjg0xtvhOTa?=
 =?iso-8859-1?Q?gmyp5UITkddgdv8kO727Gn0nuaN4s6sdsdtGfiId/W5O/K5ZZMwWpGgHyW?=
 =?iso-8859-1?Q?XjPQ/xTk9ZRJDxzqqQxj+HRKc896R0vQJSxLlJ1mk/ckrpXN388bjy4xHR?=
 =?iso-8859-1?Q?tSOHA96nfUhcrso+qEK59OKz6LTvzmRB7S6qyNBlItTTpsZbsNW1UHI3X6?=
 =?iso-8859-1?Q?YN41Eqf6dBwxMDB+qkbMrKsHG+dEvsmlbJHVuFihAz5euZuNOzAe6UMQ/6?=
 =?iso-8859-1?Q?mGv8BhImBaBdA9z1aCusiMfrl2xbHfD8Bl4/Jxwlp2nr4kUVvd/L+r6rez?=
 =?iso-8859-1?Q?EDeqrazZuejVQjWA9o6jGtxqBcgynzaEOlOJjes8m09D7/QE56+hGgn5o0?=
 =?iso-8859-1?Q?YFvv58hux1eukrVIfDEpzOZ3cnk8ZDrEdwqNtzvgtX0u89iY3RjW2xcD5Z?=
 =?iso-8859-1?Q?IOKRYQlR6w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PSAP153MB051776C60FFB06BB3278EEB4B7E79PSAP153MB0517APCP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fe567598-72c3-49a2-f35c-08da17777502
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 02:45:05.3665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRZ6c4ypxrSRZwAdYykd76xnYYb3OKuDWkQ8V6Pzk2XnGtU5CrZwUyeGZTKutG2EKJc/fhH5pExfKUm8RJ5fwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0123
X-Mailman-Approved-At: Wed, 06 Apr 2022 08:13:08 +0000
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
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu <Lei.Qu@microsoft.com>,
 Peng Cheng <pengc@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PSAP153MB051776C60FFB06BB3278EEB4B7E79PSAP153MB0517APCP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear AMD Colleagues,

We are from Microsoft Research, and are working on GPU disaggregation techn=
ology.

We have created a new pull request Add PCIe hotplug support for amdgpu by x=
ushuotao =B7 Pull Request #131 =B7 RadeonOpenCompute/ROCK-Kernel-Driver (gi=
thub.com)<https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&data=3D=
04%7C01%7Cshuotaoxu%40microsoft.com%7Cc86224bc365f44bec6b408da172ecac1%7C72=
f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637847787066456985%7CUnknown%7CTWF=
pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C3000&sdata=3DPA8l7Cj82dphBHbo82zqTEQUM4kGM7yg5UeQuduhDg0%3D&reserved=3D0=
> in ROCK-Kernel-Driver, which will enable PCIe hot-plug support for amdgpu=
.

We believe the support of hot-plug of GPU devices can open doors for many a=
dvanced applications in data center in the next few years, and we would lik=
e to have some reviewers on this PR so we can continue further technical di=
scussions around this feature.

Would you please help review this PR?

Thank you very much!

Best regards,
Shuotao Xu

--_000_PSAP153MB051776C60FFB06BB3278EEB4B7E79PSAP153MB0517APCP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
span.apple-converted-space
	{mso-style-name:apple-converted-space;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:black">Dear AMD Colleagues,<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">We are from Microsoft Re=
search, and are working on GPU disaggregation technology.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">We have created a new pu=
ll request<span class=3D"apple-converted-space">&nbsp;</span></span><a href=
=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
hub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;data=3D04=
%7C01%7Cshuotaoxu%40microsoft.com%7Cc86224bc365f44bec6b408da172ecac1%7C72f9=
88bf86f141af91ab2d7cd011db47%7C1%7C0%7C637847787066456985%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C3000&amp;sdata=3DPA8l7Cj82dphBHbo82zqTEQUM4kGM7yg5UeQuduhDg0%3D&amp;reserv=
ed=3D0" title=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&=
amp;data=3D04%7C01%7Cshuotaoxu%40microsoft.com%7Cc86224bc365f44bec6b408da17=
2ecac1%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637">Add
 PCIe hotplug support for amdgpu by xushuotao =B7 Pull Request #131 =B7 Rad=
eonOpenCompute/ROCK-Kernel-Driver (github.com)</a><span class=3D"apple-conv=
erted-space"><span style=3D"color:black">&nbsp;</span></span><span style=3D=
"color:black">in ROCK-Kernel-Driver, which will
 enable PCIe hot-plug support for amdgpu. <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">We believe the support o=
f hot-plug of GPU devices can open doors for many advanced applications in =
data center in the next few years, and we would like to have some reviewers=
 on this PR so we can continue further
 technical discussions around this feature. <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">Would you please help re=
view this PR?
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">Thank you very much!</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards,</p>
<p class=3D"MsoNormal">Shuotao Xu</p>
</div>
</body>
</html>

--_000_PSAP153MB051776C60FFB06BB3278EEB4B7E79PSAP153MB0517APCP_--
