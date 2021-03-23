Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52672C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 11:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1077B619BF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 11:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1077B619BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B158E8997E;
	Tue, 23 Mar 2021 11:13:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B8B8997E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 11:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dt2nbkjg8/XWG8zS7n5fChWxhMYevd7eIS6NtG2VBFpgryAJof8/gFpXSm2KNBMIZF6ln27t2DOvs0MTODjbtMDtUOmz2mf4fUaqUIKrgTm8HkSXhhUivk4RrnZqlH22+/SlVgGuBVVXmwVt4tgPP/j781343AK9NiHBAMhdSqKMAPEgiZYJ6Q4Xoqdt2Z4SClmjCHA4GlmaF+o5rnt9WtbFHRuHn9ki/s/niY9F5d1wf/dfbNdDBK6lJ8i4PmlStzaSMemAsa+sC6322OfY+4r6tNzja8qoKncNgUbHeIu+YjbJ7/rgwloRyYaNBaQeH+nvx1Uh88S3PRmPad1Q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5P8/BSQtnws+PluATTZW+Dyc5l/2mBKnW6h96Un/m0Q=;
 b=oauJga9HEqB5vdrNYQJZx53yEgJE/hRRHbPT348HsNaI7itzzB/dbm6y+NS5Z0vc05vjCJPu3K2w2OlWb0+sIcefs84HimwQYz1Hb8Y+J4rtAR+ecMGH85qaTjKqEIhbW4UZ0/CI0kGN9OUJj9BItwem8XmIwm6nF8WWIACOoCn2YiYkOYfhU8Bndv+5XxKpniARZKIpXi/L6rQuFOcjZbliuP/TX1zPEMT2OggEjPpEvQUt8dJtfPne1SXMO3+zxtK6RQM4NAHmPihJ0GVFYiJdXtAf7WYNboisk6qX0EKe4pjWzgbAYNQNYsZYGR5qzzRNy917dBRQPqiI3gVlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5P8/BSQtnws+PluATTZW+Dyc5l/2mBKnW6h96Un/m0Q=;
 b=AmTDwz9fv9P3F4D/c2H0b8IDQicmSz2YOy1lY9ujQwljSecRkC3xJ6oEOBJoZzbGrHisz3uNMn8lliHN3g9r7aJBlsuD7RXyR/N1azBGbC1EDU6N20qXgZGYSsuH5U/Wr/ebaoc87kDaR7P2bU8cMriJ49ExgQjPWOtsSDbLYxU=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2828.namprd12.prod.outlook.com (2603:10b6:5:77::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.25; Tue, 23 Mar 2021 11:13:06 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686%5]) with mapi id 15.20.3977.024; Tue, 23 Mar 2021
 11:13:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable recovery on aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Enable recovery on aldebaran
Thread-Index: Adcf0tMtHRCksOs4SDq9sPGZEcAd+QAAqGPw
Date: Tue, 23 Mar 2021 11:13:05 +0000
Message-ID: <DM6PR12MB407555555C2C9F287EE5C98FFC649@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <MN2PR12MB45497585979A4EB92A20FD4297649@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB45497585979A4EB92A20FD4297649@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-23T11:13:04Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d686db32-2b86-4e3b-a60b-f6e9c99b3abf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94bbe3f7-3cbd-4a7a-b23f-08d8edeca21b
x-ms-traffictypediagnostic: DM6PR12MB2828:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2828578C7E9130FB28050D19FC649@DM6PR12MB2828.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:404;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WXLOwuJiVn4qhvsdme4HnmP2MxSM5mJUgG+o07lkdyHnzahxjBPk/Rp36a9HLO6rGTFL1l75CmFv03bokkhchJcWMMT3eEJRWybValYexBV3HeOk4NwZU2Yw4qPIjGvHjTPz6W/OJrdaV9fz9DMgQ/yn2p8djem38OyAYdUVOf5ahOJQU5WuK9mgugl0Qea/BLppek78Z78NyHnNjdZj+ISCmNJh+Kcv7/QOql7GJOOtLe835CbaaSTBQJicNhlWaKPC0YcZATdXCWMi5ydNHBD94xb2qc5VplKNH4LcxPv9hDx/GKFr/t+UTdGsyP3HIX9J1lzR32G45bN456O59uaXWwJLSH7QgiwYhBrK3rHbBafECfiEzNGt/Ktlu+7ihuK8kwyCOmGVCXkkaLliUoMmY/++eEK6bGEoeaIxDvC5bgWPU4YsBxsKY8MCLgcEEnfnTZQEzfyDnLxpQFUN0m/dfdNz1KHP31Wey2+rC6xTknGRv9NCAkAqlpR5AbfhDzgX3SKNfBMy18Qux2N7TBFi0xU5Yg87L274mVK72/96y+nWkaCDDeh2SUtzQEwV+8Epq1s+IpA7haF7NaMQ7rNHxN0AR8FhM7NqWHnzj/x9n/HeXwCi+v2alz4QxYVj48urfcdyiBs2h1m0uXYuLA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(66446008)(66476007)(83380400001)(86362001)(8936002)(7696005)(4326008)(26005)(53546011)(71200400001)(66946007)(66556008)(64756008)(5660300002)(186003)(6506007)(76116006)(52536014)(33656002)(2906002)(9686003)(55016002)(316002)(110136005)(8676002)(4744005)(478600001)(38100700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ukPxvHv2BKJ5jr5a808QqEdju1Az4LwOPP5xuG7pV1HgpQ8Bkm0NuZ57uJiy?=
 =?us-ascii?Q?0s60ffFdUnqcpxa594Hxm0s55e3D/hDybuUL0UuOGrFrAtfyIOvbwZTDFldD?=
 =?us-ascii?Q?zgKJyW/ZLzr5xH5l43bUY/3Ex9tHwv5CFIOsw0FuZfJtUT4XCOmQpR4kKdpv?=
 =?us-ascii?Q?2GYq9HPNs3ne7Eamylt0BDX7sNvu6ABISmtglr0qZlEPn0kRv96m/futpKbY?=
 =?us-ascii?Q?SV59gc0eSPrkIzscHeG//U3MvZjDgAd3bz/v8xS75Fpj1ZnajxduGCSKAyjS?=
 =?us-ascii?Q?lNJmdl5J8mO83ofE3xVW2Wjf3dgitjqpL7NMnKCWJnrDT61ahtr2kmsv7atb?=
 =?us-ascii?Q?Bxb5m1nfyzE5m+2lkVMdtc1Bzc2Xj8H8Ze6lkUAII24f2+S5lhWVjmSgxAoP?=
 =?us-ascii?Q?7wXJGfIJuMS9SrbsSUyTvmWniVxLd2oSBVPvftkD1e9ukVtV1FHZl+cznAJY?=
 =?us-ascii?Q?v2iYKv5xnFvRPyNGR0TKcJMK7c5WZUTtxPTDHvNfBBsmfsg8NOouigbHfGSR?=
 =?us-ascii?Q?/mCjO/QHO4vMdLqMxxdX8/so2+GIw8TfaofNnDFyCq/C3dWi53Ai8HGubytT?=
 =?us-ascii?Q?imGDVcFVVod9BPGMTvNFa7iXZ67mKMSl7dLf1vaoaMPO2ssk3R0kBfe4a6ae?=
 =?us-ascii?Q?slMdqMePlftW8yqOQ9Rr66qctVd2cakAaXZkt+M4EtsBezcdb/dAuVMcY89X?=
 =?us-ascii?Q?YuNNOy5oRgwS+b1ka2fTdM82RLvWpKewBgl8lGxFV8mwsIH+8SdjSlS/uOG5?=
 =?us-ascii?Q?5cMcVoX1LxSpmfEbEG5c689ONnvs0xjth2lIB9Oo386rNI8Z8U2WJgjE5SVu?=
 =?us-ascii?Q?Q3Y/R7PSuNoh8nY3wax3HwkW+xWARyub2vNrm1lO9PRZxmUOlpQmy7pw8dux?=
 =?us-ascii?Q?HJRg8sQCy/vMkY8rtTn3oQ7BR9++pjh0wJ9OOiivZ2XP2RkPt3NRtooHL94Z?=
 =?us-ascii?Q?w1bPAjuulGFFMbS7jTCIsv6N5dP2OSTIDQdM5x06KzgFFEsXE+9Rpu+J3PDi?=
 =?us-ascii?Q?8gGX9dqEUnxZ+l1A8OfSjBT6vGx3aU+UsEN7EaWZ654FWVpyKf2WxU64fb+t?=
 =?us-ascii?Q?plhvJhlJDb3NtTGhuFVpbtcUi5ZnkzNPTDAtAFLMaiJBSdk1jjddDbhK33cF?=
 =?us-ascii?Q?F0vidd99f1GBuTasHF5B1ZpKKT47hX8QT/WbQU1dTLCcI1KuYL5w6GCrlhDf?=
 =?us-ascii?Q?AQkfYsWbw9oGj6BkJW/TwDXmL4vND/zv8d67UeZyZCpTf6rw+u/MzT8bleeq?=
 =?us-ascii?Q?cDW0zK2nM6tjPGD18v1hHsoHjDHnSynWnXrtoCQfKH0vaXB3bfCAYbSNDLhB?=
 =?us-ascii?Q?HvwbGMViNeBuqkotrKNdePiA?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bbe3f7-3cbd-4a7a-b23f-08d8edeca21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 11:13:05.9170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWq5P4zaeZOAkAfEVf3pqJL/kjxwIFFLQzlWsnhnbWRtjl4ZpleF4FXM+wpsxnJ0JTfb20R3vr26mM+pcx39zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2828
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Content-Type: multipart/mixed; boundary="===============0542454902=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0542454902==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB407555555C2C9F287EE5C98FFC649DM6PR12MB4075namp_"

--_000_DM6PR12MB407555555C2C9F287EE5C98FFC649DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, March 23, 2021 18:55
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: Enable recovery on aldebaran


[AMD Public Use]

Add aldebaran to devices which support recovery

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b1b83d282090..324b9e6b2965 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4192,6 +4192,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_d=
evice *adev)
                               case CHIP_NAVY_FLOUNDER:
                               case CHIP_DIMGREY_CAVEFISH:
                               case CHIP_VANGOGH:
+                             case CHIP_ALDEBARAN:
                                               break;
                               default:
                                               goto disabled;
--
2.17.1


--_000_DM6PR12MB407555555C2C9F287EE5C98FFC649DM6PR12MB4075namp_
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
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
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Tuesday, March 23, 2021 18:55<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Enable recovery on aldebaran<o:p></o:p>=
</p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Add aldebaran to devices which support recovery<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +<o:p=
></o:p></p>
<p class=3D"MsoNormal">1 file changed, 1 insertion(+)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_devic=
e.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoNormal">index b1b83d282090..324b9e6b2965 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -4192,6 +4192,7 @@ bool amdgpu_device_should_reco=
ver_gpu(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUND=
ER:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAV=
EFISH:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
goto disabled;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB407555555C2C9F287EE5C98FFC649DM6PR12MB4075namp_--

--===============0542454902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0542454902==--
