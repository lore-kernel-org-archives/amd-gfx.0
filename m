Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8C9C352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B231C206D7
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VphPNy1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B231C206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 634AA6E037;
	Tue, 11 Feb 2020 14:35:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F736E037
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 14:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K84KgYdeWzqQ90MAbLfUCj2DBYvQmSqNUvneDoyg/kBPqq2qloXito+Adx2sW9DvuYRAiKW5DvbYvdZW0VJkBQnBx5nQxA+nmkevnQS5BWlnGbGlLBqjdizgf+PbSKdGr0fXDE+WcvQYlfKN+bWofz9UpKt2CM1+19t3sgEKy2vWjmvR1nLQnIQFlDQieD4DgpQkZvc2S13pO/GrYrQxS4okDxiHEm9353bFAfoSmCYQtSZ2lZXh4IIqzZVFUEw1xS4KI3TxodcEdrngb0o5Hergq5kcMKLHrCGtlq5f8SmhKObbqftli40ibThaSQoq6Z25Vq3MnEWitafJyyquWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54ZSVES4s/aPYbe+gU5ksWmkutEDNVUI5bMBrENGG4Q=;
 b=eYSqNNqo8jU2D03a0bU+fabsztW47u9kTkLPZ8v4/Xc5Gt9grbmUIgPB+JxUPyHWkopZk8bIhTAiGbJ1pRAigxlSp2ca02Tc00qeWs18zvqYckb6MQ1n7VdJ5+FNTwIixcRJf367Jmj2BC+ji296h3ZR2VIGO9YCKMhfSAOopMx7tyXhCRaPKvCzm/hNQbqIQQ8F9sdbvpGMLOfnLyaFc5rvhbsiQqpIj9iI4HYT4bNSLc4i6We8fCeqa/4Cxic0KZLthpIh5xUYD3A8774+k+dae9vsF6ZUq1oYfgTrRl3VL2Pe83fnVTAIvw8WSDLTkQue/5QYmCewgyHHSsykbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54ZSVES4s/aPYbe+gU5ksWmkutEDNVUI5bMBrENGG4Q=;
 b=VphPNy1hBFd8tnxssW7YddFnxfJC6dGdoF8+FBWzpbxmQrWP+JXUcQ+c/ikHd6Ha7CQeOi1jYTQXjRK2kO+yEVEQv8hwsiJtL/DcjEaksnsA23jHpsYhblrOCwoxtBfzGwWLDqIF9vvaI/JOgfomX0fdTARDNvT3SUMUJuokUrM=
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3312.namprd12.prod.outlook.com (20.179.80.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 11 Feb 2020 14:35:24 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 14:35:24 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgpu
 tests
Thread-Topic: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgpu
 tests
Thread-Index: AQHV4M2cyckBS3g50Ual3kzv6T+qkKgV3juAgAAvigCAAACDgA==
Date: Tue, 11 Feb 2020 14:35:24 +0000
Message-ID: <MN2PR12MB330985788CF1A81319DF67C3EC180@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1581420183-14223-1-git-send-email-ray.huang@amd.com>,
 <a54f6008-918a-dbf6-0000-f2f048cdaaff@gmail.com>
 <CH2PR12MB39128F0E67FFB7E60C16B1ADF7180@CH2PR12MB3912.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB39128F0E67FFB7E60C16B1ADF7180@CH2PR12MB3912.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-02-11T14:29:37.202Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-02-11T14:35:20Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 75a77215-ebba-4bfb-8cbc-000017faa689
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5bdbf6eb-cdab-4640-177d-08d7aeffa1af
x-ms-traffictypediagnostic: MN2PR12MB3312:|MN2PR12MB3312:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3312ECDB27BAAF87A34DC793EC180@MN2PR12MB3312.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(199004)(189003)(8936002)(478600001)(81166006)(81156014)(8676002)(76116006)(52536014)(55016002)(66446008)(66556008)(86362001)(66476007)(64756008)(66946007)(5660300002)(9686003)(2906002)(4326008)(33656002)(110136005)(54906003)(26005)(316002)(186003)(6506007)(53546011)(66574012)(71200400001)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3312;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NlldG7lMfouSTQuyDWvwhpQNn6Cv5z/MCOc4IzqL5lCQ60ln9xfhjiXrphL4f7Yj1VZmiYz6Qwm+Cfdygs0L5iw6WaFsXqh05kfDSuYy4hy3QZUM8j8qXQ+4iCUuD16xFvTiLdl/LcgbNst2/605AenR5f8H6MtaGl476UVaBqvxBXZTAWcPKuxx3N8epfbpXlLxuvUZTZL9RnIzTWNw2XgQ1C/IXFvFi716f9+Rt5NkTWAj9glIiit9noeqhdM7AgKmiUEsSVxgSWTaO8Jq92XtLJ82yenJVJ3MbFdo9r74zfgqRBqTrnQZNuQBDJY0UFc0Iwb19gvII146hUV6sMvoT1FvvlHsMgzu7v5YofHQZDtdWY33WYkBguJEsQ7cH5VtSucnIs3QbSz3IUYC8zs1mzKSy1plr64LQThLV3f7QlkQE7SW9SSywdtYLyoY
x-ms-exchange-antispam-messagedata: kPAw1ghVTQ8wCphSiYc1ogDOHnn5nuYNz4Z2gcn5otOknYzpFcDwvx0sVSzBKO5rHkcYJENS6QnOaE6buyg1gNgYmWv68Gn+nq/ynIzOu70AYEwdBHl9+meJWqxcrStEG1pL5xkRzJU6Grsy9UEvoA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdbf6eb-cdab-4640-177d-08d7aeffa1af
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 14:35:24.7585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VcIIbVtO81aW4hCvYyNKpYbDmPpd5XEl5vCbsEEHvyIDsv3zLxkHtzwqrb2jJmeyDJRONQZZuLgXykqEI7tYMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3312
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
Content-Type: multipart/mixed; boundary="===============0532679569=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0532679569==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB330985788CF1A81319DF67C3EC180MN2PR12MB3309namp_"

--_000_MN2PR12MB330985788CF1A81319DF67C3EC180MN2PR12MB3309namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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

--_000_MN2PR12MB330985788CF1A81319DF67C3EC180MN2PR12MB3309namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"MsoNormal">Hi Alex,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">MR =3D merge request?&nbsp; Should I create account =
to send merge request in the freedesktop gitlab?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Ray<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Tuesday, February 11, 2020 10:30 PM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; Huan=
g, Ray &lt;Ray.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Pelloux-prayer, Pierre-eric &lt;Pierre-eric.Pelloux-prayer@amd.c=
om&gt;; Olsak, Marek &lt;Marek.Olsak@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@=
amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian =
&lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 fo=
r amdgpu tests<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Also, l=
ibdrm changes should go through a gitlab MR now.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Christian K=F6nig &lt;</span><a href=3D"mailto:ckoe=
nig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a><span sty=
le=3D"color:black">&gt;<br>
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
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Looks good on first g=
lance, but Marek and/or Pierre can probably better
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
&gt;<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB330985788CF1A81319DF67C3EC180MN2PR12MB3309namp_--

--===============0532679569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0532679569==--
