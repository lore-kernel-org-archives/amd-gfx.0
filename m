Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E433AC3B187
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B938D206DB
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HggBqdzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B938D206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331146E4D0;
	Tue, 11 Feb 2020 14:57:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B351F6E4D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 14:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxXVMbO9KTRcU/RF7m0H9xRvTKmzJSxyltht+viD8kgs7KqsLtv9EtJqEZPnLzSmd2MdSGrusXFG4ueg5kyBX6EIi/Xr/1xSc0FWL3YA124cdIDq4iU6WAihlA8zstpJsTXS7I0FRWrRcUq1+I/IMeIfw0ucTv8ciGg/nW3tMdnhVwVgEsbpOvpl0s2oJuUjHpGArBZeZNA9gp67SD/Y7r0lFUWChT/LvelY/w2ntv7tmGor3CxpV+bkS99IgdZGRIFr3MZ2scYh15u6kd3dHOC5C3fhhbcy7sckE8CAU+1KbcKqNQ9uxiujggyBMGFFCCxp9HZBusxvqGTx4gUxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93HykOjxFClJuH1i2jbaN7TeC/yI5uK4SULbqQrl6Is=;
 b=P3xXgXPtQTuz1lNft0y9jH7KXN4KbXBFw3Bzkr3uVTyczMpz9MQAfhtgr6ecrIjq9teFnPmJb+IiIme9L+4KpE6STTXBc1xJUAtNmTEBMdJI/J6vMr0Q6aERGzkN01BdeAropCydjVLCZ1wXcP9rv2z3DvmRbK04oNj79Hp7Zt6OJNxUgXQbcnFQbx8cUOaetR20nXlyry13m13PdqlnOyzC9u/V8arGPhOHMnvPsBCysuV84U+aycNZxY01GB+UKQn9aFvU37JM4F+RMMTjGOgV9kJpy3ZBkRN9kzw1MRneCtd0sqmhwUmVNi3nD2JUD43Qx3W1V4YzjxLl4Cs1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93HykOjxFClJuH1i2jbaN7TeC/yI5uK4SULbqQrl6Is=;
 b=HggBqdzTGIf+OmO0ni44tQIcvMpLuc7q0Je8OENJPjIuwSd82TkgnhKUFrwfeZnbmDX5xsJ+37LXHi3JrQhxWFqQ5m4FfCaXyZnECBqiw3A0tjyXZX2c+Gs3sWb9WG8613UZXM8HTX0dPShQNEHNQ1cghQ/wDALw9h1T5kB2H1k=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (52.132.246.86) by
 CH2PR12MB4135.namprd12.prod.outlook.com (20.180.17.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 14:57:03 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 14:57:03 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgpu
 tests
Thread-Topic: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgpu
 tests
Thread-Index: AQHV4M2dMDJ+Dd/Zb0Oh6MhZzzoHHKgV3juAgAAvYbqAAAHGAIAABeJ7
Date: Tue, 11 Feb 2020 14:57:03 +0000
Message-ID: <CH2PR12MB3912CCDC4F15E6B7B1E92543F7180@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <1581420183-14223-1-git-send-email-ray.huang@amd.com>,
 <a54f6008-918a-dbf6-0000-f2f048cdaaff@gmail.com>
 <CH2PR12MB39128F0E67FFB7E60C16B1ADF7180@CH2PR12MB3912.namprd12.prod.outlook.com>,
 <MN2PR12MB330985788CF1A81319DF67C3EC180@MN2PR12MB3309.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB330985788CF1A81319DF67C3EC180@MN2PR12MB3309.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-11T14:57:03.289Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3623f0b-b5d6-4780-c9e1-08d7af02a7fc
x-ms-traffictypediagnostic: CH2PR12MB4135:|CH2PR12MB4135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4135887ACB994DAAC85EAC48F7180@CH2PR12MB4135.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(189003)(199004)(5660300002)(66574012)(52536014)(53546011)(19627405001)(6506007)(86362001)(110136005)(19627235002)(26005)(54906003)(71200400001)(55016002)(478600001)(9686003)(186003)(8936002)(316002)(33656002)(8676002)(4326008)(7696005)(81156014)(66946007)(66476007)(64756008)(66446008)(66556008)(2906002)(76116006)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4135;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s1yEOYZdcBI5qiD8N1QSF18PynBu+R2+rSyFT1OYp7FwvRHN0frS/iTc+OhBNciqd6Qp9UB0GhHDRMT1zDX97kS577GySSHLP3fuZQNB+Zu8GCilAh070+co403lBf0AZ0gvmi1Tb1jdEQOg5Ex9sM3jX5r8RCHXECoJ/xxhev7cL4ZO08Xwt6ne2Q5XpXO6H+5LceQxHFuX9Qd2sZ9u2+DHny+8pxyL6+QnQWuRxz3cvvcR1ECQDXTM8johBzTxfJ8nmBmDdLvK87OmVS/49PsR/n4aBO+K/hek6sbmKPR4yK8laX0OQqAnR7hh8P7IN7wu5ZOCQPblNHrvPsna56K25b1/TgcQutzrC+f/GW0Uy1TwouG8jhz6QXhv266F+/FT92ObalR0ZHTLB5iCh+733bSAMDhblN87XWb5msmazDGp4/Urz6Teaet3MZva
x-ms-exchange-antispam-messagedata: lOZFypf0lFkvWq9KVCIZ9vvHEbuiACsVPLLrhLloHevLcJ2UIgGiA1oHkQpk9sHJJzoJyMK8dzBvACnI1dYivFfbgSUZsEvEpB+Re2DrQhTRd23hRpk7kZMlwXJC7sBr8gEN5aZKvjVGm4UQwvIaIw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3623f0b-b5d6-4780-c9e1-08d7af02a7fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 14:57:03.7832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quNidYMlhHRF205nqQCIknOgCLOhicgIwIsKTDbwMjZQmWNB7Pcuw9HcMSZ46aK/4tMhIKTwrYqrYgP908jMVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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
Cc: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0723043108=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0723043108==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3912CCDC4F15E6B7B1E92543F7180CH2PR12MB3912namp_"

--_000_CH2PR12MB3912CCDC4F15E6B7B1E92543F7180CH2PR12MB3912namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, correct.

Alex
________________________________
From: Huang, Ray <Ray.Huang@amd.com>
Sent: Tuesday, February 11, 2020 9:35 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Christian K=F6nig <ckoe=
nig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists=
.freedesktop.org>
Cc: Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Olsak=
, Marek <Marek.Olsak@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Tuikov, Lube=
n <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: RE: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgp=
u tests


[AMD Public Use]



Hi Alex,



MR =3D merge request?  Should I create account to send merge request in the=
 freedesktop gitlab?



Thanks,

Ray



From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, February 11, 2020 10:30 PM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Huang, Ray <Ray.H=
uang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Olsak=
, Marek <Marek.Olsak@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Tuikov, Lube=
n <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: Re: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgp=
u tests



[AMD Public Use]



Also, libdrm changes should go through a gitlab MR now.



Alex



________________________________

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.le=
ichtzumerken@gmail.com>>
Sent: Tuesday, February 11, 2020 6:39 AM
To: Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freed=
esktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com<mailto:=
Pierre-eric.Pelloux-prayer@amd.com>>; Olsak, Marek <Marek.Olsak@amd.com<mai=
lto:Marek.Olsak@amd.com>>; Liu, Aaron <Aaron.Liu@amd.com<mailto:Aaron.Liu@a=
md.com>>; Tuikov, Luben <Luben.Tuikov@amd.com<mailto:Luben.Tuikov@amd.com>>=
; Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@am=
d.com>>; Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koeni=
g@amd.com>>
Subject: Re: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgp=
u tests



Looks good on first glance, but Marek and/or Pierre can probably better
judge than me.

Christian.

Am 11.02.20 um 12:22 schrieb Huang Rui:
> So far, the amdgpu_cs_submit_raw2 is used for MesaGL, however the amdgpu =
tests
> still use the legacy interface. So we would like to make amdgpu tests ver=
ify the
> amdgpu_cs_submit_raw2 API.
>
> Thanks,
> Ray
>
> Huang Rui (4):
>    amdgpu: use alloca for dependencies and sem_dependencies
>    amdgpu: use amdgpu_cs_submit_raw2 in amdgpu_cs_submit
>    amdgpu: remove the un-used chunk_array
>    amdgpu: clean up the cs structure variable
>
>   amdgpu/amdgpu_cs.c | 36 +++++++++++++-----------------------
>   1 file changed, 13 insertions(+), 23 deletions(-)
>

--_000_CH2PR12MB3912CCDC4F15E6B7B1E92543F7180CH2PR12MB3912namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yes, correct.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Ray &lt;Ray.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, February 11, 2020 9:35 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Christian =
K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; amd-gfx@lists.freedesktop=
.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Pelloux-prayer, Pierre-eric &lt;Pierre-eric.Pelloux-prayer@amd.c=
om&gt;; Olsak, Marek &lt;Marek.Olsak@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@=
amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian =
&lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 fo=
r amdgpu tests</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
span.x_EmailStyle18
	{font-family:"Calibri",sans-serif;
	color:windowtext}
p.x_msipheader87abd423, li.x_msipheader87abd423, div.x_msipheader87abd423
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheader87abd423" style=3D"margin:0in; margin-bottom:.0001p=
t"><span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-seri=
f; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Hi Alex,</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">MR =3D merge request?&nbsp; Should I create accoun=
t to send merge request in the freedesktop gitlab?</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Thanks,</p>
<p class=3D"x_MsoNormal">Ray</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuc=
her@amd.com&gt;
<br>
<b>Sent:</b> Tuesday, February 11, 2020 10:30 PM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; Huan=
g, Ray &lt;Ray.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Pelloux-prayer, Pierre-eric &lt;Pierre-eric.Pelloux-prayer@amd.c=
om&gt;; Olsak, Marek &lt;Marek.Olsak@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@=
amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian =
&lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 fo=
r amdgpu tests</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Also=
, libdrm changes should go through a gitlab MR now.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">Alex=
</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Christian K=F6nig &lt;</span><a href=3D"mailto:ck=
oenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a><span s=
tyle=3D"color:black">&gt;<br>
<b>Sent:</b> Tuesday, February 11, 2020 6:39 AM<br>
<b>To:</b> Huang, Ray &lt;</span><a href=3D"mailto:Ray.Huang@amd.com">Ray.H=
uang@amd.com</a><span style=3D"color:black">&gt;;
</span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freed=
esktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D"mailto:amd=
-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><span style=3D=
"color:black">&gt;<br>
<b>Cc:</b> Pelloux-prayer, Pierre-eric &lt;</span><a href=3D"mailto:Pierre-=
eric.Pelloux-prayer@amd.com">Pierre-eric.Pelloux-prayer@amd.com</a><span st=
yle=3D"color:black">&gt;; Olsak, Marek &lt;</span><a href=3D"mailto:Marek.O=
lsak@amd.com">Marek.Olsak@amd.com</a><span style=3D"color:black">&gt;;
 Liu, Aaron &lt;</span><a href=3D"mailto:Aaron.Liu@amd.com">Aaron.Liu@amd.c=
om</a><span style=3D"color:black">&gt;; Tuikov, Luben &lt;</span><a href=3D=
"mailto:Luben.Tuikov@amd.com">Luben.Tuikov@amd.com</a><span style=3D"color:=
black">&gt;; Deucher, Alexander &lt;</span><a href=3D"mailto:Alexander.Deuc=
her@amd.com">Alexander.Deucher@amd.com</a><span style=3D"color:black">&gt;;
 Koenig, Christian &lt;</span><a href=3D"mailto:Christian.Koenig@amd.com">C=
hristian.Koenig@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Subject:</b> Re: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 fo=
r amdgpu tests</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt">Looks good on first=
 glance, but Marek and/or Pierre can probably better
<br>
judge than me.<br>
<br>
Christian.<br>
<br>
Am 11.02.20 um 12:22 schrieb Huang Rui:<br>
&gt; So far, the amdgpu_cs_submit_raw2 is used for MesaGL, however the amdg=
pu tests<br>
&gt; still use the legacy interface. So we would like to make amdgpu tests =
verify the<br>
&gt; amdgpu_cs_submit_raw2 API.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Ray<br>
&gt;<br>
&gt; Huang Rui (4):<br>
&gt;&nbsp;&nbsp;&nbsp; amdgpu: use alloca for dependencies and sem_dependen=
cies<br>
&gt;&nbsp;&nbsp;&nbsp; amdgpu: use amdgpu_cs_submit_raw2 in amdgpu_cs_submi=
t<br>
&gt;&nbsp;&nbsp;&nbsp; amdgpu: remove the un-used chunk_array<br>
&gt;&nbsp;&nbsp;&nbsp; amdgpu: clean up the cs structure variable<br>
&gt;<br>
&gt;&nbsp;&nbsp; amdgpu/amdgpu_cs.c | 36 &#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;-----------------------<br>
&gt;&nbsp;&nbsp; 1 file changed, 13 insertions(&#43;), 23 deletions(-)<br>
&gt;</p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH2PR12MB3912CCDC4F15E6B7B1E92543F7180CH2PR12MB3912namp_--

--===============0723043108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0723043108==--
