Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F9FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 02:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E0D20829
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 02:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DbPIDT5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E0D20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7728C89C3B;
	Wed, 20 May 2020 02:27:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE1B89C3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 02:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q41Vu5ondKk9CW/eq/sVQUQCOn4XULdb9CSbTW6q09zNRcC6mZ5P0XkyFQxJqfjybRdsEq0EvKAiGPMdQbNtOZnaOMggmWk8rXjy0rOQOgxbEpMlQizq9yx9jyj3/9G7d3GTTEKtAzbm1tXHEszRrblMXC1SnrSs4nZWxRaJElPhd2TmdWGpz0+nV+0+bWAeL20h3+lnq4mFZIRwm4fNi5oghhjyQfoaTfVl/XHbxxRleO38hcvhlrerlkpGIRpR+xjjcLdVVGs0lFxm5T/XApsiUQ3OZRCt0PhR23W03mOX3R2LZ1P9DebHDLEB1VqijLLJkM95uBG6KB+Vfioz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpLkjiTvOdpCKPWNzeU0ywpUZ76AUxcTcaXE0J0qzm0=;
 b=bIMDkbO5b8ihcdUSqW014f3Mrluw4GIlNe0VgeYBpPw8UMKiizbIr24V0fIq0UQWqJeSlmrgpGUEa/6V4pZ++e0yZJgeuBJlZwjf0gTx0mcnS2btY7v5v4wiwTw4hzVOFtRYPsdkfuPijyCz5N8hfB7VRnRgqPF9n6BsEWUGBHXEg38ItFCVdVS15MSJwoo3YixdO+06KVnItGVcghQG4lk96SiCLDznUONg63RGIuYhPbkH2XH1s3oJ59ZjUKwiYgC3GkLRukAhatJqNXT4nnQoocDHDpjvXAm+LmRNtbMA9GBQsqBKcq85rVeAbng50tKi8kvsFmKf8ggMfMQp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpLkjiTvOdpCKPWNzeU0ywpUZ76AUxcTcaXE0J0qzm0=;
 b=DbPIDT5zyduNY6UVaKjFPTZYNBcLzgw3JUvGOqELxp9kFdAI+y+9OF7zYnBNwyAqcBR4qJ2flG4usKQZlktDSlJ8xYz28dWLU0NF6Thz8Eml5n3qtAIOIEtA9HDihk7wjt8JtrGJ//Ry9+xdXSyRKvOKdoboGuqHKzTPs2Rc2zs=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4028.namprd12.prod.outlook.com (2603:10b6:5:1ce::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25; Wed, 20 May 2020 02:27:54 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 02:27:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition
Thread-Topic: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition
Thread-Index: AdYtvciAHbipIGpZT6qk0o/TamXupgACE0ygACH3ObAAABEjsA==
Date: Wed, 20 May 2020 02:27:53 +0000
Message-ID: <DM6PR12MB4075CE1FD8A8F8A2B19FF0EDFCB60@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <DM6PR12MB4026718C8DD47807F9856F3FFBB90@DM6PR12MB4026.namprd12.prod.outlook.com>
 <DM6PR12MB4075736EFBC2A476F7EE3F78FCB90@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM6PR12MB40267E4394FB2F93F23C7094FBB60@DM6PR12MB4026.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40267E4394FB2F93F23C7094FBB60@DM6PR12MB4026.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-19T09:14:31Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6334e757-9313-4c47-aeb1-00001eb443f7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-20T02:27:51Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8ed94278-8fe5-4f1c-9ca9-000049ac0bd8
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 453dccb2-e80a-4a55-15a5-08d7fc656698
x-ms-traffictypediagnostic: DM6PR12MB4028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4028378CAAE5D7E03D8F7C2CFCB60@DM6PR12MB4028.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UCVGNqtlR2xXGnoNYXJudw9oel7I3X+lCRYnLekrdfb/gFHalYcOoeo7+/uEYqy7C49nj9mJd9ETrWw6J+F+WoiD52NmbPaFKW0Z4XQJvr/9+FLRTRaaqb8Wf7gPpXOOOxslTBQ6VTAOvQwPwqrlLlawMKNowi6E8OiEI9b+8iP8CNud24N2IQOSZMkD4MNLBslDejjdCpxlzVRb5A7V0lVPLPuwKbiqbnCKb2hYfX42UVLjrggIKn82F87l0lxqUomi36SH10j08VXwF9QV2QogI0DJ2gVqEvra5E6b2+v6rxsvKgn/6hTOwYEiiKS5PorESTDf4Y2qeNeeAwUhrDlIEQiwn7WvLZuBnAvKdaq5TzJAO4qJ724RDcvQyMnf4KpJWDdHgkRLdmlIvUHT8MPPeZUwII2I+0J34x6Qtz14l13B2ZHUZDAlkk8+TC5P
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39850400004)(366004)(346002)(376002)(396003)(52536014)(66476007)(66556008)(8676002)(66946007)(66446008)(2906002)(55016002)(9686003)(33656002)(478600001)(64756008)(71200400001)(76116006)(86362001)(26005)(186003)(6506007)(53546011)(316002)(8936002)(5660300002)(7696005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gnaR5Dv+8MQmQz4Im4lTvbW9fhidDPvviasU87gKmihQ0RWFmdT900Yx9HSdAA1UIKF3cpH8ZqXPfQktSU8h8CU95NckSFOCfTP5jpsC0dFxvCHV07CzKpF/Uuai5Gr0QjoUT71buuQKzvAfreOjU5wuKpqpEgAVNERStmrBSsSoBLHt9Gpp6DVfQ1W/w2r9fv4PL9cJCfb1wqh7nBNjJuGJo0oSkdqAxzDwSrVszYOw6+j+Dt0YB/ZRIPSFE8Mr5gsyurRbN4r/oa6iII1XYPgWf9oP1o9Ys/1EWuFDjxif6mBmK5XyeC9CT65k4p632sBXEU3/YrafQjA6P/h0xTCWd3UnCanhHy+T8mCIdmYbK2EaklchL21eblUzG+pSuKHoyxCjo1Lod17ElMnVxEIk91yAKBmjGnRcyDLFa78lTq8Bx6ewVLknVSaRSnu1Z5db+AP/iyShdBbAzFGTgu52aSEVjsbHSZ8xfiqzLcdUEhGMKMFFpgP91Nigk0UQ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453dccb2-e80a-4a55-15a5-08d7fc656698
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 02:27:53.8099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hlZ5f8Dk5PrIThW+K2nse28LhxoP5e96bnEaNSuR7/5simUXt/KCkT5Dc24hQor952nhel27fvR7BAJ7jqK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4028
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
Content-Type: multipart/mixed; boundary="===============1380726541=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1380726541==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4075CE1FD8A8F8A2B19FF0EDFCB60DM6PR12MB4075namp_"

--_000_DM6PR12MB4075CE1FD8A8F8A2B19FF0EDFCB60DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Wednesday, May 20, 2020 10:26
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition


[AMD Official Use Only - Internal Distribution Only]

Thank you Hawking,

I have updated/tested the patch based of your recommendation.

From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Tuesday, May 19, 2020 6:27 PM
To: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition


[AMD Official Use Only - Internal Distribution Only]

Please only apply the check to arcturus - we don't need to check ras fatal =
error event on all the NV series.

Regards,
Hawking
From: Clements, John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Sent: Tuesday, May 19, 2020 17:15
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Zh=
ang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to block SMU access' via SMI during RAS recovery

--_000_DM6PR12MB4075CE1FD8A8F8A2B19FF0EDFCB60DM6PR12MB4075namp_
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
<b>Sent:</b> Wednesday, May 20, 2020 10:26<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: resolve ras recovery vs smi race co=
ndition<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you Hawking,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have updated/tested the patch based of your recomm=
endation.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Hawking &lt;<a href=3D"mailto:Ha=
wking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, May 19, 2020 6:27 PM<br>
<b>To:</b> Clements, John &lt;<a href=3D"mailto:John.Clements@amd.com">John=
.Clements@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: resolve ras recovery vs smi race co=
ndition<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please only apply the check to arcturus &#8211; we d=
on&#8217;t need to check ras fatal error event on all the NV series.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John &lt;<a href=3D"mailto:Jo=
hn.Clements@amd.com">John.Clements@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, May 19, 2020 17:15<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a>; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.=
com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: resolve ras recovery vs smi race condit=
ion<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to block SMU access&#8217; via SMI =
during RAS recovery<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4075CE1FD8A8F8A2B19FF0EDFCB60DM6PR12MB4075namp_--

--===============1380726541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1380726541==--
