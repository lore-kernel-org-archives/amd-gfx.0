Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6CFC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 14:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F75F64FB3
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 14:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F75F64FB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA0BA6E145;
	Fri, 12 Mar 2021 14:52:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B33F16E145
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 14:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Igb9z/3JFSCT38gKc/y5fOjAeWJg/BZfucXl4XpwSnMX+8VQkXRyY69Uq6NgyJsLphMpZDrCBc8kiQbIi6j9F1vJg27Cf4x+1bqipWsfaaa7+ukZL6rjbTkzKNo2HcEEMSj8JiuVep5rmmQZdhEJBbUqn4TouNyQVCp1HPvELopD6oQU/K/18lt9xPDk9K5jD2uvXFsbK1rnpKBYGYGhDFZJY1HeZCoWu1yFJax9fIjGFfXS/C3kul4ziZg5omGehOrueG2A3xgjpOS/eCzYths2YcppjCRjAWsEby6JyNEBvISpACdBj2NBJwLOUB/v9GX9zbpHRkzjExS/ChpUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNpuiUXTgYegKVXxAO010LqzVOyp+Ci1UKEFmYFVLU8=;
 b=cQ6Oc4nRgobCmCZGD64f3pBLE5fgW+/fVqSmPqJcphREkT6DTwi4JL9M11F6DOZ4/3xkuALeye3/4/QGoc8cMd5Aj+zZajaumlDmsesQLurDDmopx3Hy0ZaE3FHoi9HabesANygNnY4phWb9hAWntHUhSvnqoNUTr4EKwyy1zjoK37JrxkhCVMW/Bc+Le1sFtZAhj5672yFM/yrGfRsPO0605MIc3pOH2sEtrfbGQiMI5n8NjBg/Dy/11SZmhBBf2ns+76c5uF8bgKevCm05RgIXOf1dEwiiFxKdhEuDngnPiHxapJA6mYyYCB6xZZfsCM5eW/VBd8OnXPtYiAMrfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNpuiUXTgYegKVXxAO010LqzVOyp+Ci1UKEFmYFVLU8=;
 b=okCMbPDCKPM8PTxiHTKXdtv0DnJNiWazcU/n62BikgxokWCok8OnXIVX3Vjx/6vwnRcQoP0RmZQ6BudDdQGq6Qt9zONShJRhr38TNntnjI122PRStKEWIpiWUlKf95Hxu8XyLbQ+UW6O1w56EKWxTe6AUN4xhRyhJ6+etTsGtbo=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 14:52:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 14:52:24 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Enable VCN/JPEG CG on aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Enable VCN/JPEG CG on aldebaran
Thread-Index: AdcXHPOjp+bq3zcFQmKE9RkN+7Ov7QAMlUw9
Date: Fri, 12 Mar 2021 14:52:23 +0000
Message-ID: <MN2PR12MB4488A98CD322E9AF7A1A1E6DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <MN2PR12MB4549EDCC892E2BA0C1F1F95D976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4549EDCC892E2BA0C1F1F95D976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-12T14:52:23.414Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1846e267-c083-4be6-76df-08d8e5667252
x-ms-traffictypediagnostic: MN2PR12MB4240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42401C97721D512B42C236F3F76F9@MN2PR12MB4240.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sIXY4zKu+lp7axXU226YRaiRyLZ7B8AXK7BBafCciQzKcPXU2DMhEeGnUcgh6mMm8kIPFAQmNlOGT5t7mHWiBpANrtsgtnAqcVvstfX6Fal88vrOFdleR/Sk79pL6EE7IDnZjNxFx0K7HSUL72bgNKJA3Xx5MDBrtKpllc1ZBRMCBnhYqprPSDnaj/0eMdfAHT35aQpbqvmkqJMTI6m/TKMm3YE7mI1EM4k2zlrUW3IlsYF3peplQUhg0dupjwsyDko/dvoCzvnmy9n4i2jcLq8Ks0VRR60QxPWjol7PUEA/PRcEf4mNZatQDVDpTZGzfJcblQiZkgd+7Lo8H270yk21RyPFK3KA5i89kcAYcWQLjpMbnX2YTLmX8u1BHkPc0GS4THmrFDDja7GY54AZbCQfuJv9vNJy8I3xN2d9lESRENYVuE1Y1rvGJCl4CJom0POtG0p2qpRJj2DEgGTnPDyTkzBq6eLjEG2ISPKhCNWcDwESSQ94SXZkKxIAH+7IyL2Eag46ToR3Dkmu5em+AAejZrG6JTpakktqcT6JEd7u3VUxwk06BKOITOqXuCVf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39850400004)(66476007)(55016002)(66556008)(64756008)(4326008)(76116006)(7696005)(53546011)(9686003)(52536014)(83380400001)(5660300002)(66446008)(66946007)(478600001)(86362001)(6506007)(19627235002)(71200400001)(8676002)(110136005)(26005)(33656002)(2906002)(19627405001)(54906003)(316002)(186003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?//MxLTKfVI2Jkj13L/uAdyew3sL7iriHk37wzFBsNiaXvQcRprJ4uDflwVab?=
 =?us-ascii?Q?T7uHqq+/Es2j4LXPsZh0hA3BdLUuANvsLz3cogs5dEYYnLZQywNR83hakSY2?=
 =?us-ascii?Q?hXjnHFLnLuH2TVkuoUy7FlGSP5jljkSMwY2ssN8gndbpSM+ZBeUit/k2HIHA?=
 =?us-ascii?Q?Ut3bV0u3f3aTYjShAqff6InFSoNvMCkZ4d0/BfJODd3WOueb5jqTrJrVO8gz?=
 =?us-ascii?Q?ffGaKQgUkUHCc7en3vIQfoi+gD0UoTGLsZtfrkhyEDOvtlFjcVqqgeEfW4CR?=
 =?us-ascii?Q?ed9N/4riFNXSOEke2AmwkesLDgZ1uDB3v+wnbYQYhrLKrNTFgBhPcvkcxCHh?=
 =?us-ascii?Q?nnDvQuY/JlWVqHDW9wEgVgX8GzAsSOzdwHuQECndNlnFtypLLFBdCpXCsDD6?=
 =?us-ascii?Q?mwGPhLysTzmIcjKIgCTxy5zqyMn1xVB61noATBWVCL1XCW/gpNZTyJCNxvHf?=
 =?us-ascii?Q?rvwIPSp4SFu07fLXezPky3d/0fEjLMX/PlOaiwWKtgxxXfZLqBLXJEnnbGKV?=
 =?us-ascii?Q?/qOHNupe4+66zQJulntCrLoI6tulMsKaWOQBNDbkMBT7Cdbbh1pQagfT5716?=
 =?us-ascii?Q?AUrD8Ukev7UF28sBvsk2Q041CC7AKL5rweJbokb+wKcBIXmOkBzaRujdVrRg?=
 =?us-ascii?Q?tu8jpWqEkuCHmTOfEnXuREhabe8tzPCntqgOzh6CjXUersLp6gTip4Ox49Bq?=
 =?us-ascii?Q?UgHTDVjrfumyS9saKBMIaRWt7FcgO0UGGn3uF0/tJ9MrGj+fBf5BXVQJdi+S?=
 =?us-ascii?Q?Gg8fO4KNG28i0NxwH9wduvLH8Pjgeq80FswaENIfuH5+EAcw838HCcXrsjSn?=
 =?us-ascii?Q?WMPVDYLiEwhWvYeHVLEhtNzPw9r2J/kRaHjJs4Y6h1O7XW5NXo+rnSCCAu7k?=
 =?us-ascii?Q?viApe2odvgSOPMWmGB+6S7n+YDuvhAJsoFQguoANJPAyKRreT5n/Areq7jqu?=
 =?us-ascii?Q?AkPQu3dhUzo+VVibv4HBaIhCeMrZoMTuP6zPrhGV8xE8u36M3Rkyp9RpAyva?=
 =?us-ascii?Q?uGxmhiEyY5ihGTxLWU+w6xuqxcznCpIAxKMN/rGIzsMVz8fqAMwDdeAjGFmY?=
 =?us-ascii?Q?Mp0SWtmYim8QmSoaFd8qjWR7KE2mBO41rvfGLzuimawtgm065JngoZF7QK1m?=
 =?us-ascii?Q?RiU6rfUnTqiqO08mIdwQdv7og5Xq6+O4ToKSSwaoZs7nXqtUwdnnDNyPvBhe?=
 =?us-ascii?Q?0E9WrMpeGVYhowGDkiketM8QVk+M+VPuo8yXKy1b2YC9dDUVGCtlblHGRH6R?=
 =?us-ascii?Q?+P46jNq12aX4bOMAymtMoxpzQ75MsZOafeDZjWV/xv4LqivuL5cGz8bUXkQ3?=
 =?us-ascii?Q?wC+fvBvUIx+g27tDZ3XkTtEw?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1846e267-c083-4be6-76df-08d8e5667252
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 14:52:23.9172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBn5qiHXomIEdbbyJg2VrH3EWTmDGNUH44GqbdNJ6IjktKl2fpfC7Ms+DbniLTKDuRWhTEQbdECtGKWzAn72tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1287761548=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1287761548==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488A98CD322E9AF7A1A1E6DF76F9MN2PR12MB4488namp_"

--_000_MN2PR12MB4488A98CD322E9AF7A1A1E6DF76F9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lazar, L=
ijo <Lijo.Lazar@amd.com>
Sent: Friday, March 12, 2021 3:52 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Enable VCN/JPEG CG on aldebaran


[AMD Public Use]


Enable clockgating for VCN and JPEG blocks on aldebaran



Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>

Reviewed-by: Hawking Zhang Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.c=
om>

---

drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++--

1 file changed, 2 insertions(+), 2 deletions(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c

index 3808402cd964..a08000a3bdb9 100644

--- a/drivers/gpu/drm/amd/amdgpu/soc15.c

+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c

@@ -1495,8 +1495,8 @@ static int soc15_common_early_init(void *handle)

                        AMD_CG_SUPPORT_HDP_LS |

                        AMD_CG_SUPPORT_SDMA_MGCG |

                        AMD_CG_SUPPORT_SDMA_LS |

-                       AMD_CG_SUPPORT_IH_CG;

-                       /*AMD_CG_SUPPORT_VCN_MGCG |AMD_CG_SUPPORT_JPEG_MGCG=
;*/

+                       AMD_CG_SUPPORT_IH_CG |

+                       AMD_CG_SUPPORT_VCN_MGCG | AMD_CG_SUPPORT_JPEG_MGCG;

                adev->pg_flags =3D AMD_PG_SUPPORT_VCN_DPG;

                adev->external_rev_id =3D adev->rev_id + 0x3c;

                break;

--

2.17.1

--_000_MN2PR12MB4488A98CD322E9AF7A1A1E6DF76F9MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lazar, Lijo &lt;Lijo.Lazar@am=
d.com&gt;<br>
<b>Sent:</b> Friday, March 12, 2021 3:52 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Zhang, Hawking &lt;Hawking=
.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Enable VCN/JPEG CG on aldebaran</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
span.x_EmailStyle17
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-family:"Calibri",sans-serif}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:b=
reak-word">
<p class=3D"x_msipheader251902e5" align=3D"Left" style=3D"margin:0"><span s=
tyle=3D"font-size:10.0pt; font-family:Arial; color:#317100">[AMD Public Use=
]</span></p>
<br>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">Enable clockgating for VCN and JPEG blocks on alde=
baran</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.l=
azar@amd.com">
lijo.lazar@amd.com</a></p>
<p class=3D"x_MsoNormal">Reviewed-by: Hawking Zhang <a href=3D"mailto:Hawki=
ng.Zhang@amd.com">
Hawking.Zhang@amd.com</a></p>
<p class=3D"x_MsoNormal">---</p>
<p class=3D"x_MsoNormal">drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++--</p>
<p class=3D"x_MsoNormal">1 file changed, 2 insertions(+), 2 deletions(-)</p=
>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/=
drivers/gpu/drm/amd/amdgpu/soc15.c</p>
<p class=3D"x_MsoNormal">index 3808402cd964..a08000a3bdb9 100644</p>
<p class=3D"x_MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/soc15.c</p>
<p class=3D"x_MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c</p>
<p class=3D"x_MsoNormal">@@ -1495,8 +1495,8 @@ static int soc15_common_earl=
y_init(void *handle)</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; AMD_CG_SUPPORT_HDP_LS |</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; AMD_CG_SUPPORT_SDMA_MGCG |</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; AMD_CG_SUPPORT_SDMA_LS |</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; AMD_CG_SUPPORT_IH_CG;</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; /*AMD_CG_SUPPORT_VCN_MGCG |AMD_CG_SUPPORT_JPEG_MGCG;*/</p>
<p class=3D"x_MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; AMD_CG_SUPPORT_IH_CG |</p>
<p class=3D"x_MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; AMD_CG_SUPPORT_VCN_MGCG | AMD_CG_SUPPORT_JPEG_MGCG;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags =3D AMD_PG_SUPPO=
RT_VCN_DPG;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-=
&gt;rev_id + 0x3c;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</p>
<p class=3D"x_MsoNormal">--</p>
<p class=3D"x_MsoNormal">2.17.1</p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB4488A98CD322E9AF7A1A1E6DF76F9MN2PR12MB4488namp_--

--===============1287761548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1287761548==--
