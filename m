Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4115FC38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 15:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BF82073A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 15:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DQCxLFwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BF82073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F4E6E109;
	Thu,  7 May 2020 15:23:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC24A6E109
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 15:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnpTaLinz9i5qHWfw0xpbHx2+fJLXuMowM3m46OpXcbk+hQse9V9z4CfgKltKBywQsaHl+hj+u3wQ0Xl+cZom211ZVpRu7ow9kj0uHMbQJJvfl8auDVVY4hl8QeBiP4iMq63RxNTdGZiCj2gr1GaE2ZgDK2zK2NTInNpsG2MECz3hOza7zbSa+egklHeJcW/g1jFsZClaaMf9JZbpYxLo+eTnV7URxd+lIFA6v3Kn7ZDtrkKapyFSRiJL2T9WKV0+x+KW1Lbr060SDEHrxlqu5zR/ooxMuo1bHtsbkJfrr4mK/DOHz4Fw1NWvMozuqHlZZz1+TMhMOQFs9svV0xgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC+mk+E9lJiDBi+/DsaN+ZYEaXJJU9kGJUen850tfqY=;
 b=KFqLgs2XL8+TALJXJvTWjO97Z4GUgIYzM4xKRnz0JYtBV7ocK81Ra38/Thd8oEA3VpyBWID0z5fi2fg4GAOSxHutut6deE/yjhF4ClVrf5bZh94kO9FZOg2vUa2WDmgY4Kq6hGQCh5yjxoKrRVi5RNhNz7KoZU28jbsR4ADnqqfoCbqij9Q1r8O3Q2h9avs0oUktHmpr/7t+LOGh8ftadcnLUrtJoitJckyw/8IcLnBqqBJNd6oDM6ryUmSvRs2TuQM6HOLipsNOppmzhWD+mCvr2vnmcR1VfuYBjmZWmjRB2UVixNYbCCUv+/v8iIucY70XaEon+BzWZ0JBXUrJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC+mk+E9lJiDBi+/DsaN+ZYEaXJJU9kGJUen850tfqY=;
 b=DQCxLFwBgEsc1yzcGKVGP/zrQiM0aUBGvGeYjJO/sN78rB0m8Tl2yPQ62A9IFgxVSE7tMy/NFzZHUMyXcbNBXfbr1Xh2ItT/M9b5VkyWeL9wWAxh6hRxcPMzFLzAj4E58XL7l/73aL0qwbldQdP9DtpRvBw3yUzrPlR/1KV8tEQ=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3642.namprd12.prod.outlook.com (2603:10b6:5:11f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 7 May
 2020 15:23:41 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 15:23:41 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Don't report unique_id for Arcturus
Thread-Topic: [PATCH] drm/amdgpu: Don't report unique_id for Arcturus
Thread-Index: AQHWJHb7eHT4PtofS0yrZTecvWsDcKicujWAgAADNlA=
Date: Thu, 7 May 2020 15:23:41 +0000
Message-ID: <DM6PR12MB3721BF6128D65FE5BA0EB0EF85A50@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200507135359.18138-1-kent.russell@amd.com>
 <MW3PR12MB4491A6D219680EF962771399F7A50@MW3PR12MB4491.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB4491A6D219680EF962771399F7A50@MW3PR12MB4491.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-07T15:09:56.899Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-07T15:23:39Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: fa8711e6-501b-4217-94bb-00000e9ed6ec
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1ca0:aecb:89d3:2a74:6d44:185a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e3f5b77-c1a1-425b-2cf0-08d7f29a9f8f
x-ms-traffictypediagnostic: DM6PR12MB3642:|DM6PR12MB3642:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36422707B456AAE7F557BFCF85A50@DM6PR12MB3642.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mp3K6j+DVFy+wdVB3iabQ/9n2Kd3GX1MzDB5l/CrdWwT+le6bnMWfY7RyUSsP6zLMTMV/zInqx+lV6YqJFTgNCmbimfieYDUpMH0GtsPXtameY1rs2wk04DRKOHLdEHFxASTfIUPBJDKYoeL5isVJWuF1FnhXNAeUMgd8XpQfAnfqYaPoiFGnxzYZPDMobbh3oZcCT4yGRRB6qF5Yk1ZJnxx8kpbDCe1SFTkjJ8uK0rTDouW4RzZwFs2CXS5PE42cWhvyghKho7AhhYsSsWpuh7bwkiiLBSAx1uia+80DHrM92MfDQCvlTuOxsizmRl3Y1kb5NP/xo/OCxkDLveS5JUe0GQo3zS2sInAkWLMY+KtTM3+TkiTlGumxbxNORwbmHxkbknkJRZ9nCcJrDX9X+AcSAL6ag7nkKDjKmm4jp0BKZBV1eBcBdCc2zlMH32jKg8gEfEGk1RbP/sVjkFyeDfB2zQqTEqBcz7n3U2YsmZBf3RYS8ZOUSMRigtGQm0mGdIt5C1iovmmUO3qT4qzKy/0eUAFD7A0nZXv6tqZG8uh0rOU0vMgxDtsUN3C/9vf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(33430700001)(6506007)(71200400001)(316002)(966005)(7696005)(9686003)(83310400001)(55016002)(83280400001)(83300400001)(5660300002)(33440700001)(83290400001)(83320400001)(166002)(110136005)(45080400002)(33656002)(66446008)(64756008)(66476007)(66556008)(2906002)(53546011)(8936002)(86362001)(8676002)(66946007)(76116006)(52536014)(186003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cQtfJpgMIh4ja+sqm5p/+4tHcaNNFAI5/faH0XJXQ4xUrtJF29a07i6VnQEO3YZhRFuISskpViaEnN1CxMyXqTp5HE47CGTREThEBuyQNz4Um1J0GVZatA31tR1HaPCrOwKZxLcvt2K0JTYh+zGZUdatzSQ1gcTwyrvAkNYbckawP4eH6GR6zgBh+uWvLYSk+UHgzRDES5D98yqnuKDL3gvKvVWjKvPhjNlDam7FCaztkToyyQAk5YHh1NknTrTyuhV51HCLq5dd0b9CgY4kuRoQshr43bTxi0RCJV47naInalE0yWv/R0INVe4eBqmTooiK70ZhCU4XfrOoWA4HeBxWjODtonTrpVlXybmzvMTJY0mKuGYcK0DpOHIi/7AxIz7PRN9WjMiJpcqr2xqAk3SHj3LZ7x/bHbazHeE1vWsc6c8b7LG57/GFkpD3Q4QvTIkLgsYn/MaFiuruByq3vg23NXvqjtvYwR1IPK5w68fBBNOmJ6OzYLnDDwe3YOh82h4GjlFaocCKCFxM5Se5NxOlT2r/04DpzpeRZsoEUHoecTiCAoaz+yL4/6FjZGdCS2aMxmSlln4cZMzIXDpKnEYnETHS5aOqab5+SiBMtU41BIVvSLgIjxEXQl6pbEZijPBG5wZ2rvONcgf18TU6K7vypkSby2iRQKRAUJifTO0ynB0aJLzED+YoqAJ+Az2HQq9TE0TT02a+h9hNC95YcmqkW343kiNYgu+uUbyY5hjUF5ZLJ/KQQA8a4n1a9kSBXeMQAppy2aBAmJ74NAvvZ7dvjXLJmC01bXUZjEK/gnLhwzIgJCSZikaOVZoBZb/95tZjlONCOqGquhJrAdHcBECayrzQftBDfnLe5fxY14arop6vPe9HYXX/R56QSKt1
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3f5b77-c1a1-425b-2cf0-08d7f29a9f8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 15:23:41.1001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQy3sWkRPr0auZq5MSfeWBm6uhTAZN6WoHC0ZtjhyoqFEVTX4geP3dKJ+5wraCmzlN/S7qKNSgh0vaGdc9yERQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3642
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
Content-Type: multipart/mixed; boundary="===============1643336429=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1643336429==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3721BF6128D65FE5BA0EB0EF85A50DM6PR12MB3721namp_"

--_000_DM6PR12MB3721BF6128D65FE5BA0EB0EF85A50DM6PR12MB3721namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]


[AMD Public Use]

Indeed. I was trying to keep it all in there anyways to make less churn, bu=
t I can remove it altogether, including the definitions that aren't support=
ed. I was informed that it wasn't supported nor working correctly, so I'll =
revert both patches (definitions and adding support) for clarity. Thanks!

Kent

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, May 7, 2020 11:10 AM
To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Don't report unique_id for Arcturus


[AMD Public Use]

Shouldn't all of this code be moved later anyway to make sure the SMU is up=
 and running already?

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Kent Russell <kent.russell@amd.com<ma=
ilto:kent.russell@amd.com>>
Sent: Thursday, May 7, 2020 9:53 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>
Subject: [PATCH] drm/amdgpu: Don't report unique_id for Arcturus

This isn't supported in the SMU yet, so just break early. This can be
reverted once the SMU supports the feature

Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@amd.c=
om>>
Change-Id: I09945613aa7400afdf3f9d5dc0ffb636ee2896f7
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index f55f9b371bf2..cb90825aacf1 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -317,6 +317,11 @@ static int arcturus_tables_init(struct smu_context *sm=
u, struct smu_table *table
         smu_table->metrics_time =3D 0;

         if (smu->adev->asic_type =3D=3D CHIP_ARCTURUS) {
+               /* TODO: SMU doesn't currently support this. Return
+                * early and remove this once SMU supports it
+                */
+               return 0;
+
                 /* Get the SN to turn into a Unique ID */
                 smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32,
                                  &top32);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C2081bb617dd14d81e7a108d7f28e1f8f%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637244564588764106&amp;sdata=3DGevSmW%2Fgzq862kdiJ=
wcbGbCMHfboIGx77zfA%2FOuwhW8%3D&amp;reserved=3D0

--_000_DM6PR12MB3721BF6128D65FE5BA0EB0EF85A50DM6PR12MB3721namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#317100;}
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Indeed. I was trying to keep it all in there anyways=
 to make less churn, but I can remove it altogether, including the definiti=
ons that aren&#8217;t supported. I was informed that it wasn&#8217;t suppor=
ted nor working correctly, so I&#8217;ll revert both
 patches (definitions and adding support) for clarity. Thanks!<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Kent<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Thursday, May 7, 2020 11:10 AM<br>
<b>To:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Don't report unique_id for Arcturus=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Shouldn=
't all of this code be moved later anyway to make sure the SMU is up and ru=
nning already?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Kent Russell &lt;<a href=3D"mailto:kent.russell@amd.com">kent.russell@amd=
.com</a>&gt;<br>
<b>Sent:</b> Thursday, May 7, 2020 9:53 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.R=
ussell@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Don't report unique_id for Arcturus</sp=
an> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">This isn't supported in the SMU yet, so just break e=
arly. This can be<br>
reverted once the SMU supports the feature<br>
<br>
Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@amd.com">ken=
t.russell@amd.com</a>&gt;<br>
Change-Id: I09945613aa7400afdf3f9d5dc0ffb636ee2896f7<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 5 &#43;&#43;&#43;&#43;=
&#43;<br>
&nbsp;1 file changed, 5 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index f55f9b371bf2..cb90825aacf1 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -317,6 &#43;317,11 @@ static int arcturus_tables_init(struct smu_context=
 *smu, struct smu_table *table<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_time=
 =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;asic_=
type =3D=3D CHIP_ARCTURUS) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* TODO: SMU doesn't currently support this. Return<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * early and remove this once SMU supports it<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Get the SN to turn into a Unique ID */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;top32);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C2081bb617dd14d81e7a108d7f28e1f8f%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637244564588764106&amp;amp;sdata=3D=
GevSmW%2Fgzq862kdiJwcbGbCMHfboIGx77zfA%2FOuwhW8%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C2081bb617dd14d81e7a108d7f28e1f8f%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637244564588764106&amp;amp;sdata=3DGevSmW%2Fgzq8=
62kdiJwcbGbCMHfboIGx77zfA%2FOuwhW8%3D&amp;amp;reserved=3D0</a><o:p></o:p></=
p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB3721BF6128D65FE5BA0EB0EF85A50DM6PR12MB3721namp_--

--===============1643336429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1643336429==--
