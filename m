Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7C8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 12:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8A510E278;
	Wed,  6 Apr 2022 12:52:37 +0000 (UTC)
Received: from apac01-obe.outbound.protection.outlook.com
 (mail-eastasiaazon11020015.outbound.protection.outlook.com [52.101.128.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5786C10F15F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 08:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg0ioGMtLN150Ggl83W2CZ//tT4UXGiEVKp2mMJXgp94ESfxib6auRNDZjCur8zaYPNKpST6fP4SBzXE+lZpR+vwK7PZv8r1jUTWV6XV/S9QRUdyTJ+ImP5RZ7T2TNKWpsXbdyoBRK7HEMKCitleKyV+7HdRkwTPGLr1nKciKBqMxp4oK5t/bEOwelXF4SvEZq6J7Vww55cCCisLTfxsDMSlqknMvDP5YpQWan1rx0ogW8NT9Ep1FAg/XPCG5nTVKFGyA2DIZlJIIO1u+zwlArETIEGfur+xh+v5JEfM5OjDvLYDgIFF2r9Qr3dX8tEx/Qc6d0wdr0FOY/cGn0IE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLGXEBzqG7O5Xp1TBxZ4XvpPKxSYUy/Cwk7eL+mpEDk=;
 b=kYYFLJ8l9X/+u0JvVmOwwhl/KhM8nmpvyQ9t0ClAU/Ta0+jMs6n2Zrx95znWKMyLJLDYlySumbG6sQDRrVH6DiveZ+dSoVQYE7GFO2T8EjqbjhOKrHpJccR1LPMdgF55tHt34ehsyH7uPSIMjkB8EIA0vguJnsZt7sq0DnGvl3Q7Hen5QcSvme4K5bwF5bhdagnAZ0UmU1zXlTOSiR1D6yMqCKJdndibfyJRQRhmW6PfQXrRew9gLEpp+yjh/unWMHpjsKkQL9JFAO1gapXoLej/Y0XZB8M7OE6Z6iXQIljybRDvBECpPO5esMzQguI/9zhJ7I4VNlB+74RuSGX9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLGXEBzqG7O5Xp1TBxZ4XvpPKxSYUy/Cwk7eL+mpEDk=;
 b=Lb4ic6dKb9PaqcI9yhr2O+kHCGEXbaHzA3ZDHbAq2jCT3PS1X42gEMdB4l8siKIIhYYQbXmIpCpSzunIQWTNwWmtNGA1wyZTuFe03G0LW1jnV8lKU5rM93t3z09JYf30JlngAgFx/GqLd7Xg54LDGUzBSZlLBT8/eaDHsFXKcL0=
Received: from PSAP153MB0517.APCP153.PROD.OUTLOOK.COM (2603:1096:301:67::8) by
 PSAP153MB0437.APCP153.PROD.OUTLOOK.COM (2603:1096:301:3a::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.8; Wed, 6 Apr 2022 08:11:14 +0000
Received: from PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
 ([fe80::c88f:d71a:2b3d:1c32]) by PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
 ([fe80::c88f:d71a:2b3d:1c32%8]) with mapi id 15.20.5164.007; Wed, 6 Apr 2022
 08:11:14 +0000
From: Shuotao Xu <shuotaoxu@microsoft.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>
Subject: Code Review Request for AMDGPU Hotplug Support
Thread-Topic: Code Review Request for AMDGPU Hotplug Support
Thread-Index: AQHYSYzi7MrTun1PdEaDO7XBhU9fNA==
Date: Wed, 6 Apr 2022 08:11:14 +0000
Message-ID: <PSAP153MB0517DDCF472C5A63A3F505C6B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-06T08:04:05.9973101Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53dd8813-e160-41c0-26b9-08da17a5051e
x-ms-traffictypediagnostic: PSAP153MB0437:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PSAP153MB043754C7FC1A45C4FEF99C82B7E79@PSAP153MB0437.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BV1FBX4I1dsUGjXI7SfHdm2tOlr01OumNyNuPz/C1riH1GMK/+ztnuu5fIU6smWnKXIkwvM0TFeimNTfxM0yKaD15rOasOmehc8hrFp560+hwCXOGFdGS/dtvtA+hFeAlUvR2agqTIqZZO7o66FJ7W3yHGcINfdlwwGSmGU9DaNiuTsPSb8GRg4LW4718AdSt0Qjrv65+sUDKA+rgwEyfAViXqK63Q4psnh7CAIhjeyawWYuzdcE+7bwKgaBYp/GlYaIBOCkqeOAlLfUnKSzAaZtXTrxWg/qD+kdCRIfodATxOFZErpBYZ03SkqJXzXmWPdwVGAYQWVdTMzTxmMQRSpWfMm7FcS+EdmozaAfYaJ0bauxFHWvDmHcsNmJomsxDhS7+123qfpk5UWsYmwTiFujXD2BsDhpULX5G6CRcIdmlgQmMmDGCCh/o8HqI3bDtQ+nZX3ZFBMHmEuPbnsCa965/b14wH2uRaD17DUpzZ0+pPBiTMYBIX7JvOc94vsYOuWDG2xcvmFnuTxmKzcuZNlrvF2hS+TLzG8fB57U6ZCX5ocEbsGthCPc8XZ4fDnbR2KNyWm2T3/3VRPKJjhFD8T1EivnV6+sq+fbySTCs3JGYiyW/3qs3evpQatVVkETujsCtTOC1Gh49pojw2tZBnwwcCCnfyd+MsojYCHILQk8zUuNRQJbpUmkQNBH285LxpufSnFBgJ+GnkYbVY4OSyw9/yXH70VEHI/IgLUdgWdjQMrUjiTOqWIV1TOhEmVDwQ4dswueCfwwkUQSHHZD8FfTcI6yWxS8KyzYHJ2B26F+npvrEznF3ipCpz5ihlYLpRSBdhr5j/qLtGtciBxM8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAP153MB0517.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(5660300002)(8936002)(4326008)(4744005)(52536014)(55016003)(2906002)(8990500004)(8676002)(83380400001)(38100700002)(38070700005)(33656002)(86362001)(82950400001)(122000001)(82960400001)(166002)(71200400001)(966005)(66446008)(508600001)(10290500003)(91956017)(64756008)(66476007)(66556008)(99936003)(76116006)(54906003)(110136005)(316002)(186003)(107886003)(6506007)(7696005)(66946007)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gDaIWdezoPt/MA5CEXLey+AtPrudK6Apr3IuxU+Yl8AGEI/pmW01lDLrTG?=
 =?iso-8859-1?Q?efZnO23bDaG2HsZLHE4MpBQJEez+I/nRaixMKFXM8byjY4JCLYYJUWj3zv?=
 =?iso-8859-1?Q?HmLVz7SUWqD4jUcE/6Aq4VMO2gsfy/SUUPhPHOj/j5JRF4BlKQJyrpvhlU?=
 =?iso-8859-1?Q?kQTO5JiX+d0MLbX2mdDJSRwK+T8BmNEP/l8GR0TLasTon5QfZ/FuEKCO8t?=
 =?iso-8859-1?Q?Xx8sud2LkbFOFXhbG9wXCR32TI21ZrSEpberup88Q2jURNPO35/XiRZGqr?=
 =?iso-8859-1?Q?louHStJce9Cze60LI6OD/V7nHJahYhaxN90Itwlsjt0rl0xsqWcaIir4+l?=
 =?iso-8859-1?Q?9QZC2c/TtldFeQA84PEkfrQf3+Lim2gnki5fBhoPNJMvFGtmnt7I/xie9O?=
 =?iso-8859-1?Q?Cgob/rrvRnOTi7wbuIlOFZ5YGzm2tkm102k3OykGcO4R+9r15RZ+MsFSbg?=
 =?iso-8859-1?Q?/Qt6r2gpgAUcvMtE8++QCxopG7CQCLbPHXjku8MfzFQA4UpYBpa9L1OdZU?=
 =?iso-8859-1?Q?m+8ns5mWZbWZd67XQBuzj8HwrtpAUYFITYUbkTkvGt2xuBaFAQE9tmD50i?=
 =?iso-8859-1?Q?liHMUU/x4Fmv7n4qlHWuMxTus3ZKo9zGrTW0cJBIAP21H31JwMooHBv1ex?=
 =?iso-8859-1?Q?LoKxx95cCzAS/MIxUhQ4bFpG3dth+no70io46/fHR085CBGCQyQLcbbDko?=
 =?iso-8859-1?Q?wIahpXrxi9/Ltqc5vEBcQnxRzSFL7yLxSs5wqSxIY8iPjs4HC13vF1U4j5?=
 =?iso-8859-1?Q?4T9I6VSRE4fjn6Zg0GT/+cNZaKQchhpdBOM2O6xTrC5b/Qjqe5JuIs/4eZ?=
 =?iso-8859-1?Q?T3H8ac4aTXGB8xRFpv07cgI9PBAOScg0S+6qtMm7fPKy+q3AGHJdYmvY3b?=
 =?iso-8859-1?Q?8qBFCPVfT2a8+ZwN2fs9mP8JGuuh2iNUg9zeVjRHsaYRgOTM7rz6ZR2yYv?=
 =?iso-8859-1?Q?coQ7Ej5IU96zQ7QF03WjhXGpB1S6z2L79K1TCaGHO0P0tNAO4/+U92kk6H?=
 =?iso-8859-1?Q?23ioIrUunjDBOMYsBX4aYVfQU7b1D7OXL09I7UM5y1iR7wdBD2N05yBNLD?=
 =?iso-8859-1?Q?uYLTNG+fSr0vNd1Tclg/+pnGvQCzkzSNmniMzi+kDMmJKjFplNJUHMxwMf?=
 =?iso-8859-1?Q?Cp7nUkLsvyR3FyVhrFXljyihE4TEc1dclTqGcUQIgwDgEtNMWVkN9QB88w?=
 =?iso-8859-1?Q?gkvQ/CKqOqLDIuTRq1CkbSfnFsy9KxGdkWwVHeoP7d+8Me6Y8aMGd7p3yb?=
 =?iso-8859-1?Q?r3fCK1vsHlYsHitZRPyUvAC45ZvbMA3U/hE38n8PTxGLWv/OIhPVUVWNsD?=
 =?iso-8859-1?Q?cxJVAX2EEVYfQskeWZEY22eq2Lk4YFGieyFDAtGvNhzoo4YQHCc1sbqGRb?=
 =?iso-8859-1?Q?jRVKKGv5RUeUrp+ETKoohnhu9UXdYJgzKimEnelGT0Acnf7fe9uDX0zRzm?=
 =?iso-8859-1?Q?EDuymYXujHxgdQyrnA53G629yf3PwBI0ROhezak4e+YtkgvPB3NfqbrlmP?=
 =?iso-8859-1?Q?0j9Lm3EYw14GFcpwLEeXLInLlWzzIZCWE43AaZGBTDZKkWx4iHnaTJTcnX?=
 =?iso-8859-1?Q?pcPXIwbAQuh6lVFZ2w6DijNe9TRKtiixzhjdIXfrO/axswxB2ArhRHdOU0?=
 =?iso-8859-1?Q?OctRKHwg4NJKJohB2OA/0te75BLoJfBEf6693/nx1E1/3mp2QlRwFCPo+g?=
 =?iso-8859-1?Q?F1zzbtH3Dz18Pkse9J+Lh0lwvsOw5Y6q/JM/aSVnRf9ImfO/Wvl0LMyj3U?=
 =?iso-8859-1?Q?M5idUnlVx9I3qQ+rahe4KMTYnA9ygzwY9wtsO+NSeStojODDZdLFPcJJlZ?=
 =?iso-8859-1?Q?woT+3OtAGQ=3D=3D?=
Content-Type: multipart/mixed;
 boundary="_004_PSAP153MB0517DDCF472C5A63A3F505C6B7E79PSAP153MB0517APCP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dd8813-e160-41c0-26b9-08da17a5051e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 08:11:14.6002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zi1xKjnwqz3hQ93AupO3xiTHN8FqHG1uCT6htPkTTvuxHKSd404iEQDpBogq95KBZU4DRAnNkaydne0wMkQnzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAP153MB0437
X-Mailman-Approved-At: Wed, 06 Apr 2022 12:52:36 +0000
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

--_004_PSAP153MB0517DDCF472C5A63A3F505C6B7E79PSAP153MB0517APCP_
Content-Type: multipart/alternative;
	boundary="_000_PSAP153MB0517DDCF472C5A63A3F505C6B7E79PSAP153MB0517APCP_"

--_000_PSAP153MB0517DDCF472C5A63A3F505C6B7E79PSAP153MB0517APCP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear AMD Colleagues,

We are from Microsoft Research and are working on GPU disaggregation techno=
logy.

We have created a patch against https://gitlab.freedesktop.org/agd5f/linux.=
git against drm-staging-drm-next, which will enable PCIe hot-plug support f=
or amdgpu

We have also created a pull request Add PCIe hotplug support for amdgpu by =
xushuotao =B7 Pull Request #131 =B7 RadeonOpenCompute/ROCK-Kernel-Driver (g=
ithub.com)<https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&data=
=3D04%7C01%7Cshuotaoxu%40microsoft.com%7Cc86224bc365f44bec6b408da172ecac1%7=
C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637847787066456985%7CUnknown%7C=
TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C3000&sdata=3DPA8l7Cj82dphBHbo82zqTEQUM4kGM7yg5UeQuduhDg0%3D&reserved=
=3D0> in ROCK-Kernel-Driver, against rocm-5.0.x.

We believe the support of hot-plug of GPU devices can open doors for many a=
dvanced applications in data center in the next few years, and we would lik=
e to have some reviewers on this PR so we can continue further technical di=
scussions around this feature.

Would you please help review this patch?

Thank you very much!

Best regards,
Shuotao Xu


--_000_PSAP153MB0517DDCF472C5A63A3F505C6B7E79PSAP153MB0517APCP_
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
<p class=3D"MsoNormal" style=3D"caret-color: rgb(0, 0, 0);font-variant-caps=
: normal;orphans: auto;text-align:start;widows: auto;-webkit-text-size-adju=
st: auto;-webkit-text-stroke-width: 0px;word-spacing:0px">
<span style=3D"color:black">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"caret-color: rgb(0, 0, 0);font-variant-caps=
: normal;orphans: auto;text-align:start;widows: auto;-webkit-text-size-adju=
st: auto;-webkit-text-stroke-width: 0px;word-spacing:0px">
<span style=3D"color:black">We are from Microsoft Research and are working =
on GPU disaggregation technology.<span class=3D"apple-converted-space">&nbs=
p;</span><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"caret-color: rgb(0, 0, 0);font-variant-caps=
: normal;orphans: auto;text-align:start;widows: auto;-webkit-text-size-adju=
st: auto;-webkit-text-stroke-width: 0px;word-spacing:0px">
<span class=3D"apple-converted-space"><span style=3D"color:black"><o:p>&nbs=
p;</o:p></span></span></p>
<p class=3D"MsoNormal"><span class=3D"apple-converted-space"><span style=3D=
"color:black">We have created a patch against
<a href=3D"https://gitlab.freedesktop.org/agd5f/linux.git">https://gitlab.f=
reedesktop.org/agd5f/linux.git</a> against drm-staging-drm-next, which will=
 enable PCIe hot-plug support for amdgpu</span></span><span style=3D"color:=
black"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"caret-color: rgb(0, 0, 0);font-variant-caps=
: normal;orphans: auto;text-align:start;widows: auto;-webkit-text-size-adju=
st: auto;-webkit-text-stroke-width: 0px;word-spacing:0px">
<span style=3D"color:black">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">We have also created a p=
ull request<span class=3D"apple-converted-space">&nbsp;</span><a href=3D"ht=
tps://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.co=
m%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;data=3D04%7C01%=
7Cshuotaoxu%40microsoft.com%7Cc86224bc365f44bec6b408da172ecac1%7C72f988bf86=
f141af91ab2d7cd011db47%7C1%7C0%7C637847787066456985%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&=
amp;sdata=3DPA8l7Cj82dphBHbo82zqTEQUM4kGM7yg5UeQuduhDg0%3D&amp;reserved=3D0=
" title=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;da=
ta=3D04%7C01%7Cshuotaoxu%40microsoft.com%7Cc86224bc365f44bec6b408da172ecac1=
%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637">Add
 PCIe hotplug support for amdgpu by xushuotao =B7 Pull Request #131 =B7 Rad=
eonOpenCompute/ROCK-Kernel-Driver (github.com)</a><span class=3D"apple-conv=
erted-space">&nbsp;</span>in ROCK-Kernel-Driver, against rocm-5.0.x.<span c=
lass=3D"apple-converted-space"><o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"caret-color: rgb(0, 0, 0);font-variant-caps=
: normal;orphans: auto;text-align:start;widows: auto;-webkit-text-size-adju=
st: auto;-webkit-text-stroke-width: 0px;word-spacing:0px">
<span style=3D"color:black">We believe the support of hot-plug of GPU devic=
es can open doors for many advanced applications in data center in the next=
 few years, and we would like to have some reviewers on this PR so we can c=
ontinue further technical discussions
 around this feature.<span class=3D"apple-converted-space">&nbsp;</span><o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"caret-color: rgb(0, 0, 0);font-variant-caps=
: normal;orphans: auto;text-align:start;widows: auto;-webkit-text-size-adju=
st: auto;-webkit-text-stroke-width: 0px;word-spacing:0px">
<span style=3D"color:black">Would you please help review this patch?<span c=
lass=3D"apple-converted-space">&nbsp;</span><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"caret-color: rgb(0, 0, 0);font-variant-caps=
: normal;orphans: auto;text-align:start;widows: auto;-webkit-text-size-adju=
st: auto;-webkit-text-stroke-width: 0px;word-spacing:0px">
<span style=3D"color:black">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"caret-color: rgb(0, 0, 0);font-variant-caps=
: normal;orphans: auto;text-align:start;widows: auto;-webkit-text-size-adju=
st: auto;-webkit-text-stroke-width: 0px;word-spacing:0px">
<span style=3D"color:black">Thank you very much!<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"caret-color: rgb(0, 0, 0);font-variant-caps=
: normal;orphans: auto;text-align:start;widows: auto;-webkit-text-size-adju=
st: auto;-webkit-text-stroke-width: 0px;word-spacing:0px">
<span style=3D"color:black">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"caret-color: rgb(0, 0, 0);font-variant-caps=
: normal;orphans: auto;text-align:start;widows: auto;-webkit-text-size-adju=
st: auto;-webkit-text-stroke-width: 0px;word-spacing:0px">
<span style=3D"color:black">Best regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"caret-color: rgb(0, 0, 0);font-variant-caps=
: normal;orphans: auto;text-align:start;widows: auto;-webkit-text-size-adju=
st: auto;-webkit-text-stroke-width: 0px;word-spacing:0px">
<span style=3D"color:black">Shuotao Xu<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_PSAP153MB0517DDCF472C5A63A3F505C6B7E79PSAP153MB0517APCP_--

--_004_PSAP153MB0517DDCF472C5A63A3F505C6B7E79PSAP153MB0517APCP_
Content-Type: application/octet-stream;
	name="0001-drm-amdkfd-Add-PCIe-Hotplug-Support-for-AMDGPU.patch"
Content-Description: 0001-drm-amdkfd-Add-PCIe-Hotplug-Support-for-AMDGPU.patch
Content-Disposition: attachment;
	filename="0001-drm-amdkfd-Add-PCIe-Hotplug-Support-for-AMDGPU.patch";
	size=4008; creation-date="Wed, 06 Apr 2022 08:09:52 GMT";
	modification-date="Wed, 06 Apr 2022 08:09:52 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhNGU1M2JkYTZmNjViNzJiMWY2YTM0NGMxOTY3NzU3NGQ3ODQyY2QzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHVvdGFvIFh1IDxzaHVvdGFveHVAbWljcm9zb2Z0LmNvbT4K
RGF0ZTogV2VkLCA2IEFwciAyMDIyIDEyOjQyOjEwICswOTAwClN1YmplY3Q6IFtQQVRDSF0gZHJt
L2FtZGtmZDogQWRkIFBDSWUgSG90cGx1ZyBTdXBwb3J0IGZvciBBTURHUFUgMS4gRHVyaW5nCiBQ
Q0llIHByb2JpbmcsIGRlY3JlbWVudCBLRkQgbG9jayB3aGljaCB3YXMgaW5jcmVtZW50ZWQgd2hl
biAgICB0aGUgUENJZQogZGV2aWNlIHdhcyByZW1vdmVkOyBvdGhlcndpc2Uga2ZkX29wZW4gaXMg
Z29pbmcgdG8gZmFpbC4gMi4gUmVtb3ZlIHAycCBsaW5rcwogaW4gc3lzZnMgd2hlbiBkZXZpY2Ug
aXMgaG90cGx1Z2dlZCBvdXQuCgpTaWduZWQtb2ZmLWJ5OiBTaHVvdGFvIFh1IDxzaHVvdGFveHVA
bWljcm9zb2Z0LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNl
LmMgICB8ICA0ICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8
IDUwICsrKysrKysrKysrKysrKysrKysrKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDUxIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rldmlj
ZS5jCmluZGV4IDYyYWE2YzlkNTEyMy4uYzk2MzhiYzI5OWRkIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2RldmljZS5jCkBAIC01NzUsNiArNTc1LDEwIEBAIGJvb2wga2dkMmtmZF9k
ZXZpY2VfaW5pdChzdHJ1Y3Qga2ZkX2RldiAqa2ZkLAogCWlmIChrZmRfcmVzdW1lKGtmZCkpCiAJ
CWdvdG8ga2ZkX3Jlc3VtZV9lcnJvcjsKIAorCS8qIHJlbGVhc2Uga2ZkIGxvY2sgYi9vIHBjaWUg
aG90cGx1ZyBvdXQgICovCisJaWYgKGtmZF9pc19sb2NrZWQoKSkKKwkJYXRvbWljX2RlYygma2Zk
X2xvY2tlZCk7CisKIAlpZiAoa2ZkX3RvcG9sb2d5X2FkZF9kZXZpY2Uoa2ZkKSkgewogCQlkZXZf
ZXJyKGtmZF9kZXZpY2UsICJFcnJvciBhZGRpbmcgZGV2aWNlIHRvIHRvcG9sb2d5XG4iKTsKIAkJ
Z290byBrZmRfdG9wb2xvZ3lfYWRkX2RldmljZV9lcnJvcjsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3RvcG9sb2d5LmMKaW5kZXggM2JkY2FlMjM5YmMwLi5jZmEzYjE2ZjY5MzkgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jCkBAIC0xMzIsNiArMTMy
LDIxIEBAIHN0cnVjdCBrZmRfZGV2ICprZmRfZGV2aWNlX2J5X2FkZXYoY29uc3Qgc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiAJcmV0dXJuIGRldmljZTsKIH0KIAorLyogQ2FsbGVkIHdpdGgg
d3JpdGUgdG9wb2xvZ3lfbG9jayBhY3F1aXJlZCAqLworc3RhdGljIHZvaWQga2ZkX3JlbGVhc2Vf
bGlua19wcm9wKHN0cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpkZXYsIHVpbnQzMl90IG5vZGVf
aWQpCit7CisJc3RydWN0IGtmZF9pb2xpbmtfcHJvcGVydGllcyAqaW9saW5rLCAqdG1wOworCisJ
bGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGlvbGluaywgdG1wLCAmZGV2LT5pb19saW5rX3Byb3Bz
LCBsaXN0KSB7CisJCWlmIChpb2xpbmstPm5vZGVfdG8gPT0gbm9kZV9pZCkgeworCQkJcHJfZGVi
dWcoIiVzLCBpb19saW5rIGZyb21fbm9kZSA9ICVkLCB0b19ub2RlID0gJWQiLCBfX2Z1bmNfXywg
aW9saW5rLT5ub2RlX2Zyb20sIGlvbGluay0+bm9kZV90byk7CisJCQlsaXN0X2RlbCgmaW9saW5r
LT5saXN0KTsKKwkJCWtmcmVlKGlvbGluayk7CisJCQlkZXYtPm5vZGVfcHJvcHMuaW9fbGlua3Nf
Y291bnQtLTsKKwkJfQorCX0KK30KKwogLyogQ2FsbGVkIHdpdGggd3JpdGUgdG9wb2xvZ3lfbG9j
ayBhY3F1aXJlZCAqLwogc3RhdGljIHZvaWQga2ZkX3JlbGVhc2VfdG9wb2xvZ3lfZGV2aWNlKHN0
cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpkZXYpCiB7CkBAIC01NTYsNiArNTcxLDIxIEBAIHN0
YXRpYyB2b2lkIGtmZF9yZW1vdmVfc3lzZnNfZmlsZShzdHJ1Y3Qga29iamVjdCAqa29iaiwgc3Ry
dWN0IGF0dHJpYnV0ZSAqYXR0cikKIAlrb2JqZWN0X3B1dChrb2JqKTsKIH0KIAorc3RhdGljIHZv
aWQga2ZkX3JlbW92ZV9zeXNmc19saW5rX3RvKHN0cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpk
ZXYsIHVpbnQzMl90IG5vZGVfaWQpCit7CisJc3RydWN0IGtmZF9pb2xpbmtfcHJvcGVydGllcyAq
aW9saW5rOworCisJaWYgKGRldi0+a29ial9pb2xpbmspIHsKKwkJbGlzdF9mb3JfZWFjaF9lbnRy
eShpb2xpbmssICZkZXYtPmlvX2xpbmtfcHJvcHMsIGxpc3QpCisJCQlpZiAoaW9saW5rLT5rb2Jq
ICYmIGlvbGluay0+bm9kZV90byA9PSBub2RlX2lkKSB7CisJCQkJcHJfZGVidWcoIiVzLCBpb19s
aW5rIGZyb21fbm9kZSA9ICVkLCB0b19ub2RlID0gJWQiLCBfX2Z1bmNfXywgaW9saW5rLT5ub2Rl
X2Zyb20sIGlvbGluay0+bm9kZV90byk7CisJCQkJa2ZkX3JlbW92ZV9zeXNmc19maWxlKGlvbGlu
ay0+a29iaiwKKwkJCQkJCQkJCSAgJmlvbGluay0+YXR0cik7CisJCQkJaW9saW5rLT5rb2JqID0g
TlVMTDsKKwkJCX0KKwl9Cit9CisKIHN0YXRpYyB2b2lkIGtmZF9yZW1vdmVfc3lzZnNfbm9kZV9l
bnRyeShzdHJ1Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqZGV2KQogewogCXN0cnVjdCBrZmRfaW9s
aW5rX3Byb3BlcnRpZXMgKmlvbGluazsKQEAgLTE0OTAsMjAgKzE1MjAsMzQgQEAgaW50IGtmZF90
b3BvbG9neV9yZW1vdmVfZGV2aWNlKHN0cnVjdCBrZmRfZGV2ICpncHUpCiAJc3RydWN0IGtmZF90
b3BvbG9neV9kZXZpY2UgKmRldiwgKnRtcDsKIAl1aW50MzJfdCBncHVfaWQ7CiAJaW50IHJlcyA9
IC1FTk9ERVY7CisJdWludDMyX3Qgbm9kZV9pZCA9IDA7CisJYm9vbCBmb3VuZCA9IGZhbHNlOwog
CiAJZG93bl93cml0ZSgmdG9wb2xvZ3lfbG9jayk7CiAKLQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3Nh
ZmUoZGV2LCB0bXAsICZ0b3BvbG9neV9kZXZpY2VfbGlzdCwgbGlzdCkKKwlsaXN0X2Zvcl9lYWNo
X2VudHJ5X3NhZmUoZGV2LCB0bXAsICZ0b3BvbG9neV9kZXZpY2VfbGlzdCwgbGlzdCkgewogCQlp
ZiAoZGV2LT5ncHUgPT0gZ3B1KSB7CiAJCQlncHVfaWQgPSBkZXYtPmdwdV9pZDsKIAkJCWtmZF9y
ZW1vdmVfc3lzZnNfbm9kZV9lbnRyeShkZXYpOwogCQkJa2ZkX3JlbGVhc2VfdG9wb2xvZ3lfZGV2
aWNlKGRldik7CiAJCQlzeXNfcHJvcHMubnVtX2RldmljZXMtLTsKIAkJCXJlcyA9IDA7Ci0JCQlp
ZiAoa2ZkX3RvcG9sb2d5X3VwZGF0ZV9zeXNmcygpIDwgMCkKLQkJCQlrZmRfdG9wb2xvZ3lfcmVs
ZWFzZV9zeXNmcygpOworCQkJcHJfZGVidWcoImtmZF90b3BvbG9neTogcmVtb3ZpbmcgZ3B1IG5v
ZGUsIG5vZGUgaWQgPSAlZCIsIG5vZGVfaWQpOworCQkJZm91bmQgPSB0cnVlOwogCQkJYnJlYWs7
CiAJCX0KKwkJbm9kZV9pZCsrOworCX0KKworCWlmIChmb3VuZCkgeworCQlsaXN0X2Zvcl9lYWNo
X2VudHJ5KGRldiwgJnRvcG9sb2d5X2RldmljZV9saXN0LCBsaXN0KSB7CisJCQlrZmRfcmVtb3Zl
X3N5c2ZzX2xpbmtfdG8oZGV2LCBub2RlX2lkKTsKKwkJCWtmZF9yZWxlYXNlX2xpbmtfcHJvcChk
ZXYsIG5vZGVfaWQpOworCQl9CisJCWF0b21pY19kZWMoJnRvcG9sb2d5X2NyYXRfcHJveGltaXR5
X2RvbWFpbik7CisJCWlmIChrZmRfdG9wb2xvZ3lfdXBkYXRlX3N5c2ZzKCkgPCAwKQorCQkJa2Zk
X3RvcG9sb2d5X3JlbGVhc2Vfc3lzZnMoKTsKKwl9CiAKIAl1cF93cml0ZSgmdG9wb2xvZ3lfbG9j
ayk7CiAKLS0gCjIuMTcuMQoK

--_004_PSAP153MB0517DDCF472C5A63A3F505C6B7E79PSAP153MB0517APCP_--
