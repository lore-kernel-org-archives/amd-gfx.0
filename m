Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4989C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 08:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DCB20678
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 08:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VbJHID/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DCB20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF22D89D6C;
	Wed, 11 Nov 2020 08:55:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 191EF89D6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 08:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOioPqLARy41Q8fvpzEIQ2cFs9YRuaoPEf6C5WR9rmISCh4rhWXOo7EYu9apj4XgyVn08YP3WQhdL5UbM+pRM/EYSClF6ORw0yDLiFaVOdE5VRdcrLuyy70t0S4W0aPY/wWiB7PleH1zn7WGGbQzbBSSB9FzRhmjP9wkKI79o3PGhCpqYjFHjCcNB5Ivxh/JbbYw5AAww4TChf1blipUOPAnWjbwQ3RTF7MewI/5agIkmTTapErqmPCd5agvSGNclToIVcoJKG0xGN8eXGbfeP7sywdaoRUxl2KtI9nbGNzSkFOfoeM2LE5ARmAS2Kl61vTP0cIl4yh2ybXy7k8IWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFVWuSmsglfFc2YtwjbmTcPoyIRk+N4RNKRvr8huJrU=;
 b=dT8GKjAoTEInC2el/WT/1vwdSO8AD+ZgNmyHp3NcXONsU6VUURaBcV7JQorx2U8ii2QsI8Aj4LrP7+jBzVZaGF+i32/Kas3bceYozE3bzJuSqhXrt25+LASGq/RPGN40cTIyxPSQXM3XR1cYVOb0mBxe7wZgi7HPGuaMM0uc4nYcPVoZFWheOu09Hdnqq4b4ec/F1YD2BM5BYGLjy8EOuNcbeJygD4mEi2danDBVduLuB6z53CJVe6zQoqEVoKXx+IeYeqV6Bl2EWTza6HTDG37OnIXmPtPvbTSyCfI8HOyzdq2FipX3zo5aRCrnqM2zb1RZhtYazdNl4T7eo1wE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFVWuSmsglfFc2YtwjbmTcPoyIRk+N4RNKRvr8huJrU=;
 b=VbJHID/j3g45jQzCSDGrPuzRgSOumOmiDySODmlRrl7kPPIbctYmb+yPnzRWa09BkSF9nAA3yIxXTsFaxFlvqDPD+L1EH1bNwCx7Z8mGN7pqm4s9irYpJbj2X1C9Hmtn0og0q4AIirpAtYm9LBA53dpNqO3prwVk1Ow+D+269YE=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 11 Nov 2020 08:55:32 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%8]) with mapi id 15.20.3541.022; Wed, 11 Nov 2020
 08:55:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add UMC to ip discovery map
Thread-Topic: [PATCH] drm/amdgpu: add UMC to ip discovery map
Thread-Index: Ada4CAgug+1uArCgTMS+gFznKiJcWgAAEI4g
Date: Wed, 11 Nov 2020 08:55:32 +0000
Message-ID: <DM6PR12MB407507F6CEE0AFEADEA2A691FCE80@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB403229B5319EAC6A7B8594F0FBE80@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB403229B5319EAC6A7B8594F0FBE80@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-11T08:55:28Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=36ac2afb-001c-4b49-8b16-000070f68e0c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-11T08:55:17Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 25a2fe1a-3424-4340-806a-0000df9d44ee
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-11T08:55:29Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 2eac1425-b689-4693-887c-0000debb4baf
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b40710c-5b91-4fd4-98a3-08d8861f8be5
x-ms-traffictypediagnostic: DM6PR12MB4484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44841037935F1F565C971FBEFCE80@DM6PR12MB4484.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QBSUhOOUypcjbVJR2w0rS5oBYhJMXlGn8GwesEXJ9rOh7OUO03KEVLSVtDUIAUN7ZUaMm+4CD1QahKdsAtRIDYYNq4Vy7dIRShUE5b1VlH3hWIeRZ69dkqlOsSLVqvTh2QFX4Mmf4JVnrv3tgdD4guL37egDT9vaMHFuamAYk979X/YzIzL1F6ClyJo6RKykx7ZXG8HVwzXxjcJdxvsGTBTexabafCXFrsMwkWB0C7nhcatBh/kL8ZqDsFghTuvx+FAvIEQvKH7VepY6zcwCGjLsZ66aYu2yg8pXfYqIyDkl45GSYh+AciZieDzRq82B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(71200400001)(9686003)(478600001)(64756008)(66446008)(66946007)(66476007)(66556008)(8936002)(8676002)(86362001)(55016002)(6506007)(26005)(53546011)(7696005)(5660300002)(316002)(52536014)(2906002)(76116006)(33656002)(4744005)(186003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JyTRpwVRKppGZxHzaNKh8E5XX9S2ntDcUfY1i5C6L/cVAAeSItHgFEsRW4p6d8BXq541kT2dUUJJG7AxfljBBj4rOorFd1QFoyEKO25zCHGgwg7x6yd4FSAXkaOjdDQSN5f3GYEvp8EnOkqXZiZouWUB1pkHWwg262iGUxo4YEYK3NzgHCFgqovQYKbmpBWjLFuV7MsJqfueAe9rrlrk3/XBaFX2gAo5tnIwJEj3SndDSLMnTdWm9GY+TBIvRHtSuw2umakhhNbgSNAdPrwTYAiOSBzBGya+o6REwXzbmsJPHQwT5sJayrWZMZi+v7jnGQidgnokW1DeRu0yofGenT9pwXc3szOqFmv6KUf0gBa/7sNyUeKNxzGUBlO5CuZQTV3NxwBfnf9UwhUxAn+w7LPqzsaW1KheZ/KB9S9LWfRX957UyPJ+1mDTiWsMV01znpvxZ3i5SCf/kzkt3Hqv67rpb2FBZu8RPy9BhnEzcP18+a2sYb5c1Qbp/sIq59m6uuMzFit4CgzDc30PiPwLE+QIn8XLeX3endFJTuAPmjRRhwmkL4CJeAb4TxuOplgrkj8qSGQ2V3hMHHJ/KKqW9eKqMjtB1io8tYIMOqoheZOmY23phrpa4ekCzEkfWOJUqh9zzU10XxsWnkJif0WEG3apbVMgJD7dWJADoX96sCzOJgaXGhmCtUF1Qrd6jXeJhxfOrjsFH/EQ95dCga2e9vFu8NggX3rC084leg9/r7GabhpWNlfKemoAQTr0ZE5z1lCpzR2DehEdCWl5YgRa7yogI1ElWIY+Vc3XaQAXxialNS7atntN6MkQoRHkpu7NWpWNAicjZBFjTkm9LnJbkAE+uckXKkaRPQVo6/9ZZ0DKuu+3ihyCNOQPpivZ03e3IAEDF9IbudnvBOGEzpO/wQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b40710c-5b91-4fd4-98a3-08d8861f8be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 08:55:32.1446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5es2qDk/E7mvI6SshUCyDy+ubC8cOP+E0k89gFSe6hfvfMXF8R+yw+iBnyWJ9NXHiiFdvPOXeBqbDpzkHU1Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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
Content-Type: multipart/mixed; boundary="===============0214232043=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0214232043==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB407507F6CEE0AFEADEA2A691FCE80DM6PR12MB4075namp_"

--_000_DM6PR12MB407507F6CEE0AFEADEA2A691FCE80DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Clements, John <John.Clements@amd.com>
Sent: Wednesday, November 11, 2020 16:54
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add UMC to ip discovery map


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to add UMC into IP discovery mapping.

Thank you,
John Clements

--_000_DM6PR12MB407507F6CEE0AFEADEA2A691FCE80DM6PR12MB4075namp_
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
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
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
<b>Sent:</b> Wednesday, November 11, 2020 16:54<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add UMC to ip discovery map<o:p></o:p><=
/p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to add UMC into IP discovery mappin=
g.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB407507F6CEE0AFEADEA2A691FCE80DM6PR12MB4075namp_--

--===============0214232043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0214232043==--
