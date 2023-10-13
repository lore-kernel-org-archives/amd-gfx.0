Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE3DCDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 17:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F13410E1D8;
	Fri, 13 Oct 2023 17:34:41 +0000 (UTC)
Received: from outbound.mail.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F0E910E004
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 17:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2DosH4OgVmf3SktviRou2hjxumR7qkIbO5i4oMm5awCguSks2nUQQnVkcXeC7NcFABK8Xv8V3TeSapoep9hssXZfXpjA6um0sYk3JImdGHxRdOJBeH229/LhfL4b2RzG+eqEveYP4srxhNWzo7IdiO9RbRRmuLVPpyy/Smc1GKYDtcEJBKa8FnQTphPNtYF+7kUpHKRtBcKKSKyYT+/fyqLIkqoGLZJmqFc47pc4JgAYzMkfaSVlraQkWTCuYrh8tFCH3a32YX+7zyshuJKNbZ/L+DvaqdgOJ0KrV0tvpfxUcspFJywvLNHACJgf38SnHpGoggfEUh0I1DBIYSwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAlgZAvDNQCdE0Wpg1kulf6aIewlGFOoQaoZxcgNHyM=;
 b=HEAV6O+7WvI+LgzAeXYQ+ooAee8I65LHoraQ2pyd9Ypsyf4qswYfI9N3K3rqjHDmPLnz/7aNsKVS9E674mtqSKZjrC16a/41QA4xGwJ/MGf/0vbsYfn0vYkLXzpr3da9M6VUKGjnzWSokl3uyB2krJu6GhqnS3K1zdrjSOczndiDeJoEUZ0nR/m2PGTV9HElTFbs01s8JgCILvbEY14xMyzI+82Dti46Dqbg8szQ9Z2/1fB+1GLY6IMpGCMjeTDvf4xeR4W7s4cLR3J+Yrr3eAWx5ez4yo09jPCWpeJKR/02uaKEyZ+4bW0bA+CGExXdyPGSmxSRIwQ7YrvgK6aYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAlgZAvDNQCdE0Wpg1kulf6aIewlGFOoQaoZxcgNHyM=;
 b=DsN1mAANA6J5OwaIdsh/KGR8Nz9uxDYRVV4MjkMLd5ugFH8RXo04v/wna6/UI6hffhuC4ixtG8XNMzxOV7GVnEEj0ZgJQkRYPProXXvtLtpFp34AjT4OKjlVSbIsxFxlhICGgXMdWkAUGofSf+Af9J4R1S3KLT6ahegYx1o5gE0=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 17:34:36 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::a0ff:9646:e28a:eaa]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::a0ff:9646:e28a:eaa%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 17:34:35 +0000
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yu, Lang"
 <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/umsch: add suspend and resume callback
Thread-Topic: [PATCH] drm/amdgpu/umsch: add suspend and resume callback
Thread-Index: AQHZ/Zpv/6Z9B5BizUm83xeOwkPu3LBHuJMAgABAFLA=
Date: Fri, 13 Oct 2023 17:34:35 +0000
Message-ID: <BYAPR12MB2693FC1354AF34227093E2F2FAD2A@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <20231013055859.37543-1-Lang.Yu@amd.com>
 <BL1PR12MB51449E62181F86610E23AAD1F7D2A@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51449E62181F86610E23AAD1F7D2A@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-13T13:33:45.624Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB2693:EE_|MW6PR12MB8759:EE_
x-ms-office365-filtering-correlation-id: 6207e657-cd92-41a8-cfcb-08dbcc12ab3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBDdmDISw9oq5ERQNv/TbhJ1kdVlR5NjTzuEYTIXPayxpcBc/wgeKb0/Cs4Hs2jhh60uxP1aNt0j/eTJk73JzidKcNBPpXUjIwBNR/szc0ztyaH+s513V0UP1puiLHRNL8KiUtoBkDo+jYjwdZEGB0M7/zjbakd4Cf+amAtT9FG4Mioc+505FUtzuJ7ZrSyj+CLFpEFpXK7TDbYuly0XFe9mJz46wg4qRG/z2KeRC0BNqzl6HiinwLB9HmggdJh7aJQKdT4D4eWjQ418XPPMNoa5mxDd+eVX4UdTwQglb0Xn4SnlhsGEqjQ761lx9pHxIzVQNmBmTcERoN/TFIXvP6OlwbPqUUJgU4ZedwdZ2DuM/2ETlnkwIUpumckKCbT6d3zH2q9m7mWMUv7tglu2tTKl6l9CYwl9h09/uvY7Zsp/yrw1tqayMgrRa01jQCsd9t8w8Ts+IDp8TfCUB/ZXMxShPx5FS+TQL+VaR2pvLqdno8DeLBfZ+3732Fy7jdvzljmxeFfnZkcH9tPwTmI5OzH68vrUibvbCFFJLOJ/frecjPaDm52bkW5pwefh3vYpe8NhM9bOzXW74OZEuyD2stRZ5tfRE5f0hkAQKs8TVaZVyLX6pQvupXQpx+dNCtJg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(55016003)(52536014)(8676002)(8936002)(41300700001)(71200400001)(5660300002)(83380400001)(2906002)(15650500001)(86362001)(38070700005)(33656002)(38100700002)(122000001)(26005)(316002)(478600001)(66946007)(66476007)(66556008)(76116006)(66446008)(64756008)(110136005)(7696005)(9686003)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r4AnIDyvJaq9kKMnXCavDR4WeczVwTYM9Z1wtyA0yzF2tdH8730656qr336d?=
 =?us-ascii?Q?FEN3+PPIsEXSkJA5/1Nh+1qwLYrjZ1RWlG9IZTYU0X+Q2JZBfUck6IBz1Ypa?=
 =?us-ascii?Q?ZltHbZUmYkqhhucG4d8fmVJlp1unaqEPtpBUH4L75Hau1kEIJ4pPQHgUJtKv?=
 =?us-ascii?Q?hN6/30FM+CFD2Ej+FwkEkqqvJpCvbXdcOqVHDndUKbv/iuZPXI9MJYSGrkNM?=
 =?us-ascii?Q?NMftm9YXHmyOj+0MAWwweKIv+n2FY4dBuLiSvYQI763nZvBPCoZjO+W0/fbY?=
 =?us-ascii?Q?nptRPSGHNdEqdf5PAcSSleQthMxmW4pBGFbb7q6UNDRIsos0TrCWqQoerqJJ?=
 =?us-ascii?Q?khkgrJcrY47iNuiQizKuulB2CDeDQE71ik5W1MVwEm7Gtj5+3+PL0XwHB53+?=
 =?us-ascii?Q?HA1DTdWUu7NuHg39cSn6P408WucfzvDhgfamAIUlKsS6P6FXGNeRooq9Xyap?=
 =?us-ascii?Q?CCnCIDtn2Ghm3QkRIt+DvF+7F57/o5vM4Ssh/pHwXe68g8pUO08jOHC1P9Q9?=
 =?us-ascii?Q?MSu8/xolAi88ymTnocoAPB09tM4EWfA1XrIA6Hiu8MfmbtLji5366UYwhuoG?=
 =?us-ascii?Q?jp0kt9ExcTItIIo4ApH4l2qLSqHUxvFnzDXuNpnqHuUMvqOHB6jn+hkq7fa/?=
 =?us-ascii?Q?3n4gDslkVXXiXDQ0+jRlWPwzG+HFn8r5cqSfLOpq+Bh/JnKgP7ORlsBfjW3J?=
 =?us-ascii?Q?HtDyI8jduwc2zyqt1YwQjo/PN5tuk9OFxch3VU+HXZ04zosChN6y19ySsnSv?=
 =?us-ascii?Q?Gj+bYg4wUEf/lDcHnCPR79LWicAyFRI3V8NWpRSFQr+PTg0i39nk9WTrBPPZ?=
 =?us-ascii?Q?LGXY0LWbEYG4G3QLYXSwd+9MZwQDOJZ8Efcg9ihZadTlqVN8DfgsAdrOQRr3?=
 =?us-ascii?Q?gFiBK0SyTvOXO9lR8Xt8+4IAWlKNSkaiqZv7n+2j7Lu5wuM9eA+SBvgTAkH0?=
 =?us-ascii?Q?kH3QtHWJdjnN53gG0UgLQyo0nOqwW0pwBuUhL4n+uC8DS0Ws8ioiRDeeCdYV?=
 =?us-ascii?Q?I794zPTprfv5WbtwYjIXWqWnWq/LP6y8RiNgstsOZBqWLPjIA6SbCb87eTe9?=
 =?us-ascii?Q?j3GqI8DMj+jBXEZrouOqqNuvurLvRcyjPj8cq8WqNGsI6wp/r8QshKt56FdG?=
 =?us-ascii?Q?n4dF5TWG/EW50ufxiCS4f/nnsbioga9oMVXd0wM64F7xHlU/b8Sd3KsTFNkM?=
 =?us-ascii?Q?PttDEoMLXl2xHwM5vNFDkY4DcA9aTI78c/odHCke8FAz8784aPeJRhAoOdin?=
 =?us-ascii?Q?YSFJVXQEkOK+Ac1q8EJYR/vf7DvG3/JTjvEa8IpLG5uc6HgPemYNAfIBfzWC?=
 =?us-ascii?Q?lAY5C94pMj0zY2FT8yYUBPHRLhX/mPjjOrsLmKWYCZNCgOhUTw7x690ImJhV?=
 =?us-ascii?Q?oVn3eaiwhMveS5usc6FQsnrZCCd8jjcMr/jxL8pCDDEHVy+rbO9hVjXCjRQk?=
 =?us-ascii?Q?jbAuOC4pXKdyS94GaCbyMzWnXwsCqLkj4644uGVh+gaoS2W7W4lC7LEkEMHW?=
 =?us-ascii?Q?tjzD6sronYNORpG7UVZ3IWUmR0XzBM233g34AASrL1jLF63NR4xKI+QA30+2?=
 =?us-ascii?Q?RW/oi+waXXohVhjPuZ4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB2693FC1354AF34227093E2F2FAD2ABYAPR12MB2693namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6207e657-cd92-41a8-cfcb-08dbcc12ab3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 17:34:35.6809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HQ5Qu6gH6p7JVoSKJHjlKrlWqnKNvrMzeA+38vVPGwHTqknvLtSLjjp9l4FZJw34gs2qsav56BcduZYclorjrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB2693FC1354AF34227093E2F2FAD2ABYAPR12MB2693namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Veerabadhran Gopalakrishnan Veerabadhran.Gopalakrishnan@amd.co=
m<mailto:Veerabadhran.Gopalakrishnan@amd.com>

-Veera

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, October 13, 2023 7:04 PM
To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.c=
om>
Subject: Re: [PATCH] drm/amdgpu/umsch: add suspend and resume callback


[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Lang Yu <Lang.Yu@amd.com<mailto:Lang.=
Yu@amd.com>>
Sent: Friday, October 13, 2023 1:58 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.c=
om<mailto:Veerabadhran.Gopalakrishnan@amd.com>>; Yu, Lang <Lang.Yu@amd.com<=
mailto:Lang.Yu@amd.com>>
Subject: [PATCH] drm/amdgpu/umsch: add suspend and resume callback

Add missing IP callbacks.

Signed-off-by: Lang Yu <Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c
index 4bd076e9e367..f5fdde5181f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -844,6 +844,20 @@ static int umsch_mm_hw_fini(void *handle)
         return 0;
 }

+static int umsch_mm_suspend(void *handle)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+
+       return umsch_mm_hw_fini(adev);
+}
+
+static int umsch_mm_resume(void *handle)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+
+       return umsch_mm_hw_init(adev);
+}
+
 static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs =3D {
         .name =3D "umsch_mm_v4_0",
         .early_init =3D umsch_mm_early_init,
@@ -852,6 +866,8 @@ static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs=
 =3D {
         .sw_fini =3D umsch_mm_sw_fini,
         .hw_init =3D umsch_mm_hw_init,
         .hw_fini =3D umsch_mm_hw_fini,
+       .suspend =3D umsch_mm_suspend,
+       .resume =3D umsch_mm_resume,
 };

 const struct amdgpu_ip_block_version umsch_mm_v4_0_ip_block =3D {
--
2.25.1

--_000_BYAPR12MB2693FC1354AF34227093E2F2FAD2ABYAPR12MB2693namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
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
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Reviewed-by: Veerabadhran Gopalakrishnan <a href=3D"=
mailto:Veerabadhran.Gopalakrishnan@amd.com">
Veerabadhran.Gopalakrishnan@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-Veera<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Friday, October 13, 2023 7:04 PM<br>
<b>To:</b> Yu, Lang &lt;Lang.Yu@amd.com&gt;; amd-gfx@lists.freedesktop.org<=
br>
<b>Cc:</b> Gopalakrishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakris=
hnan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/umsch: add suspend and resume callba=
ck<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">Acked-by: Alex Deucher &lt;<a href=3D"mai=
lto:alexander.deucher@amd.com">alexander.deucher@amd.com</a>&gt;<o:p></o:p>=
</span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Lang Yu &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.Yu@amd.com</a>&gt;<br=
>
<b>Sent:</b> Friday, October 13, 2023 1:58 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Gopalakrishnan, Veerabadhran (Veera) &lt;<a href=3D"mailto:Veera=
badhran.Gopalakrishnan@amd.com">Veerabadhran.Gopalakrishnan@amd.com</a>&gt;=
; Yu, Lang &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.Yu@amd.com</a>&gt;<b=
r>
<b>Subject:</b> [PATCH] drm/amdgpu/umsch: add suspend and resume callback</=
span> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Add missing IP callba=
cks.<br>
<br>
Signed-off-by: Lang Yu &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.Yu@amd.c=
om</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 16 ++++++++++++++++<br=
>
&nbsp;1 file changed, 16 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c<br>
index 4bd076e9e367..f5fdde5181f7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c<br>
@@ -844,6 +844,20 @@ static int umsch_mm_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int umsch_mm_suspend(void *handle)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)handle;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return umsch_mm_hw_fini(adev);<br>
+}<br>
+<br>
+static int umsch_mm_resume(void *handle)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)handle;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return umsch_mm_hw_init(adev);<br>
+}<br>
+<br>
&nbsp;static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;umsch_mm_v=
4_0&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .early_init =3D umsch_mm_e=
arly_init,<br>
@@ -852,6 +866,8 @@ static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs=
 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sw_fini =3D umsch_mm_sw_f=
ini,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hw_init =3D umsch_mm_hw_i=
nit,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hw_fini =3D umsch_mm_hw_f=
ini,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .suspend =3D umsch_mm_suspend,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D umsch_mm_resume,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;const struct amdgpu_ip_block_version umsch_mm_v4_0_ip_block =3D {<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB2693FC1354AF34227093E2F2FAD2ABYAPR12MB2693namp_--
