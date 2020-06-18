Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C79C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 08:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CE4204EA
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 08:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZGQ6H+NF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CE4204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BDCD6EB0E;
	Thu, 18 Jun 2020 08:32:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770042.outbound.protection.outlook.com [40.107.77.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F0996EB0E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 08:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QD+9CUIz6WTeRBwWV9riQQtKadaS4/w6nRWPwaBFMj2DSaKTtuhTZ0dAxJHFy4Gt/Bz9ZJWxXlTZ2/VNUu/sJSCnwwS3YkhIovG0xdKnf39FQz6EZyACV/J6R0ya/vCniWBo/CtnFBerikdz/jumhtM+I/M4q12/DDu9fdNfS752p3C/czw8s8NSC1h2Wwu0vVN20cvxOA2Vi+hw7PN7+Gytd8MzGA/2NGY1rFYanpQ67LAerR2NZv+NYc8tJkQwn/QK+oZKT1BYpgiwlwC5yziBikkIeIYrZJ8bHIpMYKZxmMdKcJEU1+uqxnvyvsRcb0HbYuvkNAhPF0MgvxWxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pU2EfZBoeBlvGzZjZ4ZoEyhyLDU8GfvbVqMRbi4IXI=;
 b=TVrVAIhYt9+Fi/PNck2/zKAR5sFnjp4k/3Uwe1uCccfVp5bmJ9M4lGX0qnKfz450gjSaoOliBTsR8VMaFFFB/fu+Rrn078HSM46VEP0J0cf1m0CzlpMX/PBKd2uGvEsDqva8OBnUCXbrw9Cnf+70DlASuBYqkyvbq8IV7cfR1ndsPc91ghwpN7PNmz0QrwVDYb9lCFoKX8gbQy7A2r5prf4K0USH0UN7IiouoSwmcmdUeZqluC6+qsBsV6wkNEUbiZYSU8D1Jgra7LyPuqZP95rgleqRqW5E0BjvWarFK1rckiUidxmiWP6T+RRQdbrIloKhD9YLYaSw1Whu3zSuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pU2EfZBoeBlvGzZjZ4ZoEyhyLDU8GfvbVqMRbi4IXI=;
 b=ZGQ6H+NFeNKZXmr5TuygME0RKJS6FXVajp4wIYoX1WhdbvqM7dzM8tgy0TC782oCFNQF+pWzQEyyLeBnEV22suNfjOjPSAU8pSz9ZNf1wYi0ZAjQY90IJqbttPhab8TCr9gwvLrcxtzxzJ6mwfEsqYf+nEYRuPkrgRxpZIcxcHI=
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3685.namprd12.prod.outlook.com (2603:10b6:610:2d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 08:31:56 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 08:31:56 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Thread-Topic: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Thread-Index: AQHWRUWMsrD0hnyo5UetOo3mKoC9V6jeCWoAgAAAzGA=
Date: Thu, 18 Jun 2020 08:31:55 +0000
Message-ID: <CH2PR12MB4101B7B650649CADE1501E6A8C9B0@CH2PR12MB4101.namprd12.prod.outlook.com>
References: <20200618075307.3721-1-Wenhui.Sheng@amd.com>,
 <20200618075307.3721-2-Wenhui.Sheng@amd.com>
 <MN2PR12MB3022D32C41B32F413AEFF151A29B0@MN2PR12MB3022.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3022D32C41B32F413AEFF151A29B0@MN2PR12MB3022.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-18T08:25:09.544Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-18T08:31:44Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7e347923-95a7-438d-adb1-0000fc3ff440
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 321c232d-d18f-4de0-7a8a-08d813620f79
x-ms-traffictypediagnostic: CH2PR12MB3685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB36857372C2B4610553B875058C9B0@CH2PR12MB3685.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VPR34myVof6KYkmdJXNNUgtNS/4bvPgSu/414OL9sPQZX/Q4ZYFPOaQRtmEGPmx7YVHjEe23jaODrwIZ1/PWSQ56q8zqehWDtI2pU9oK9a6dGQu6bW6DP+gzWBUejqQcX2wqd/bhYGzuP+351qgoWmAO+j9Swd0AuPGQhhtFkXnb9Qva3YfhEqGAg9q9fbz8tHw1wtRDj/J4rkGXwWPsE17kRU+xQPoFzGxAR95uyF5AU1QY1IAcPFDJBzOkTZIbfPhM+3ANaVlr7unIUq6QSxL0vR2VXPBQap7SEHKhc/zeVLNibQFrTEulx7yTZNFkQD2ix7vaxZSv2HSF0A6G4F8ul75aNU9/o3bZR7hj8T4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(66476007)(66946007)(5660300002)(45080400002)(64756008)(66446008)(66556008)(86362001)(8676002)(76116006)(7696005)(2906002)(55016002)(9686003)(33656002)(186003)(6506007)(53546011)(71200400001)(26005)(83380400001)(966005)(166002)(478600001)(316002)(110136005)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: rgLXpi/HIaEkj+9gyhWtWlwjTT93T3vh5MLl8LNdGvBi1HVUBlAF2cM59jjJ3b69qcQ+Mvxd93t3zXxZUV3xFSDZJWZhQZlv3XUS5ZZNaTyg7q3Cp5/DnXxqqqDHpIrEdc4QhIHuIBdbg7X4g3R0ZqLi2Dhdhysv/VPmrQUxiQ95fhVroSwL7XAzR1Ti4WfTcc8foA2pBSmj0dkBxnBaNmrQroTnQHZqlDGb1qSdM9ImvvLJFi4fLJkjYxbRR+p2dZ+GQUMfiolPtHxtyFF2jrptq4BFCt3J7/7eUpdDHBmrEnPrHHkHEm/IoH2keyvSsqJMU0HAJGuMV1wNJjQU/b5/9fkNLGxKC8p5LnPS/NFby3dOXgkAPdfpA4jDc7cYwF4xm779mWVsRbYirGll2HOM4hzGLMRArjSK5zrfZr9Whbltf6CUxe3HsL58kVMoDWijMR46RyEVZRFrRx3naq7e9jGgo50zcR6/FFgjYsbDEgDPTUdAMEb0kNvL3c+W
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321c232d-d18f-4de0-7a8a-08d813620f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 08:31:55.8564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQL1VOE0T9Ye9xJ0uzTZ+MxJEwsJNSC+g0WLzMmx5efCG+DdBzwGu6JQZ6uW+RP0eeSgsMR0rJs6dFCdTzGzAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3685
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
Content-Type: multipart/mixed; boundary="===============0322095082=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0322095082==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB4101B7B650649CADE1501E6A8C9B0CH2PR12MB4101namp_"

--_000_CH2PR12MB4101B7B650649CADE1501E6A8C9B0CH2PR12MB4101namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

Although we know that release_firmware has null check, but the code is not =
maintained by ourselves, so I think it's much more safe to add null  check =
before invoke release_firmware.


Brs
Wenhui
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Thursday, June 18, 2020 4:25 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0


[AMD Official Use Only - Internal Distribution Only]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Wenhui Sheng <Wenhui.Sheng@amd.com<ma=
ilto:Wenhui.Sheng@amd.com>>
Sent: Thursday, June 18, 2020 3:53 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Sheng, Wenhui <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.com>>
Subject: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0

sdma v5_0 fw isn't released when module exit

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com<mailto:Wenhui.Sheng@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 58d2a80af450..6751ad69ed90 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1299,8 +1299,12 @@ static int sdma_v5_0_sw_fini(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         int i;

-       for (i =3D 0; i < adev->sdma.num_instances; i++)
+       for (i =3D 0; i < adev->sdma.num_instances; i++) {
+               if (adev->sdma.instance[i].fw !=3D NULL)
+                       release_firmware(adev->sdma.instance[i].fw);
[kevin]:
the kernel api "release_firmware()" will check argument (is NULL pointer).
i think the patch don't need to double check it.
+
                 amdgpu_ring_fini(&adev->sdma.instance[i].ring);
+       }

         return 0;
 }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CKevin1.W=
ang%40amd.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637280636699912801&amp;sdata=3DHrKVAmRO0HKFZBRG6oWq3thNl=
GBd0T9bMramDU1ijys%3D&amp;reserved=3D0

--_000_CH2PR12MB4101B7B650649CADE1501E6A8C9B0CH2PR12MB4101namp_
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
	color:blue;
	text-decoration:underline;}
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Although we know that release_firmware has null chec=
k, but the code is not maintained by ourselves, so I think it&#8217;s much =
more safe to add null &nbsp;check before invoke release_firmware.<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Brs<o:p></o:p></p>
<p class=3D"MsoNormal">Wenhui<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.c=
om&gt; <br>
<b>Sent:</b> Thursday, June 18, 2020 4:25 PM<br>
<b>To:</b> Sheng, Wenhui &lt;Wenhui.Sheng@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0<o:=
p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
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
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Wenhui Sheng &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wenhui.Sheng@amd=
.com</a>&gt;<br>
<b>Sent:</b> Thursday, June 18, 2020 3:53 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Sheng, Wenhui &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wenhui=
.Sheng@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0</span>=
 <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">sdma v5_0 fw isn't released when module exit<br>
<br>
Signed-off-by: Wenhui Sheng &lt;<a href=3D"mailto:Wenhui.Sheng@amd.com">Wen=
hui.Sheng@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 6 &#43;&#43;&#43;&#43;&#43;-=
<br>
&nbsp;1 file changed, 5 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c<br>
index 58d2a80af450..6751ad69ed90 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
@@ -1299,8 &#43;1299,12 @@ static int sdma_v5_0_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.nu=
m_instances; i&#43;&#43;)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdm=
a.num_instances; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;sdma.instance[i].fw !=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_firm=
ware(adev-&gt;sdma.instance[i].fw);<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">[kevin]=
:</span><o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">the ker=
nel api &quot;release_firmware()&quot; will check argument (is NULL pointer=
).<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">i think=
 the patch don't need to double check it.<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal">&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(&amp;adev-&gt;sdma.instance[i].ring)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CKevin1.Wang%40amd.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637280636699912801&amp;amp;sdata=3DHrKVAm=
RO0HKFZBRG6oWq3thNlGBd0T9bMramDU1ijys%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CKevin1.Wang%40am=
d.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637280636699912801&amp;amp;sdata=3DHrKVAmRO0HKFZBRG6oWq3thNlGBd0=
T9bMramDU1ijys%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH2PR12MB4101B7B650649CADE1501E6A8C9B0CH2PR12MB4101namp_--

--===============0322095082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0322095082==--
