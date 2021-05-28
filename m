Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C42C47089
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 02:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB2061131
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 02:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB2061131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9F86F55D;
	Fri, 28 May 2021 02:57:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9526E03E
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 02:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msemMRw33GxtO45p4Kcwh+qA33pqGAipZghCTBsLRTprsFXgUz0Il86wDX4UEPbVJnWXFGmzsCgyK9gTwOhMfbq48ouU/uY9LQBYja1tL8mK9XmjrJ2+pHKXjBZolpQj6FnBlg7eyy9OG6Wj7YYlNCPURkIEbZuxBtyC+i37HCSF7xtZHX2Y8x5EMxDRtPauzNjz7fmn2nTUsVsM6sg06htCmNXB6hMlkef8WyKUcRKCPLWnmgbzg9ZsJm5sNBgakaLDAS2KrH5/0f8OJ26VhAzWDCyiRQVX5n3NPOYYHZtdfu19zU9qoQIT0CMRX4Px+jsvFk6S1h654gJdUhJYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dttj4BW/WFVOAcA+aUp8UcFIhT2fBZrYJaxjSVM5EtA=;
 b=jatT8X05pPdKdeEz5ymqksuFsCfM41ko2k6ypTCKkCvWU0yd8nOgvXNqWZz2nZyRLxnE9BVpC3GU33E+5SdUzaQ7lo6LiTIyGTqLWuLhrmsjgz3U4L+Rbafm5avUY9jngwmpIOd5RwjoQcqFhe4w9op1e/cVEDhATnuAv6lLhDH6hCIv19y+SUOJLZDA5OHuOKYzGO4viMGsVIxuvoEnFEiREFvEQBnSqCvLdKT/cUfF9PGgSRZn5SgagYk1mi2JaP9Lf5PpAyVYEufDZFOnjf31/GZ4lxuSCnbXlBqSohpf4FjnxkcL65utBUHo+BxoXEGN1YS0l6TuLsROLO1Y9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dttj4BW/WFVOAcA+aUp8UcFIhT2fBZrYJaxjSVM5EtA=;
 b=eJks1l44SkFBJxA8x4vx8MZF+UbP6+AVA0QSsrQRJGpqf2bDv11bpqAUeZj9+d5azTH+oNbXdKWKgn0zAN3hWfsn88CvJupPHWD6XIg/6+IkKYZMATZHnfYpbRagr98t7O0Jt9+HqoonvA2L9vl2lUJI2QKc4WbYFXAZZIsLwGg=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (10.141.166.27) by
 DM5PR1201MB2538.namprd12.prod.outlook.com (10.172.85.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21; Fri, 28 May 2021 02:57:43 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::b184:5f9:757:4848]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::b184:5f9:757:4848%7]) with mapi id 15.20.4173.021; Fri, 28 May 2021
 02:57:43 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] tests/amdgpu: Add VCN test support for Biege Goby
Thread-Topic: [PATCH] tests/amdgpu: Add VCN test support for Biege Goby
Thread-Index: AQHXUxKlCjyMMh1e0EWQdK7EF7frLqr4NEVI
Date: Fri, 28 May 2021 02:57:43 +0000
Message-ID: <DM6PR12MB46509FA352D90D4AED912523B0229@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210527160857.63335-1-veerabadhran.gopalakrishnan@amd.com>
In-Reply-To: <20210527160857.63335-1-veerabadhran.gopalakrishnan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-28T02:57:56.079Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8f87604-4da7-4dec-98ac-08d921845d82
x-ms-traffictypediagnostic: DM5PR1201MB2538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2538ADFF7F97EB0C4AEC2BF3B0229@DM5PR1201MB2538.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4VVOVMP7hGlp2FgELvEZ2w2Qnhi5Y8nGTVNK8ewjS3b84DIEuc2ChYHHdxvWcEgR+Egx1OpVbUl964/eHJDM2vHsGoklC34CyO0tmTtAyVy4ldOSBzpBMeJRhBZQ0geqX+IbeI0KIiHJyZr18CHNjYYDG7q0/Vp/2JSiklLHmHpMuKw5hcaPubs+ywX5YX/2S2d8rrPY645FxtFZ3OwoC7GEzfzEAna/ly0JVkbV95TLAK+TaY/RSNkPMJ4Ffm64KxAbfeWbZ9IqEVPd+BLE537sbLQ0hPF+HQm+rxZqOHZi4plx8/EyfxrC28jk+iexXmhzKIkVoBuiZskZZJcmF2gP5uKgl1T9nsT0vIlW0cleMMTZta7g40StQLnpEsArrOpUGYgiQ8ePisBOrnyMqJI+YCtuddm/+HRywDiYrNowcfIQ+a0nWoO+KkJ3vTxnRTljzY0AeiKxbV1s6KXuIEI1p5Y0zs5Hq6EloZMgq1RhOHjGq5U2l/hnQ7Y0SS19ThUxFaUsnJe4JgooDrq2B2RKFBaZ3KLr++kG32B23pMAwmZQmmo8UxQn0brjl3rS13ZAi5XptSQ0HYOCShYzmMsPOFsNu7pukcdCeg2R6g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(366004)(52536014)(26005)(53546011)(6506007)(2906002)(33656002)(110136005)(316002)(7696005)(19627405001)(9686003)(5660300002)(4326008)(38100700002)(71200400001)(8676002)(122000001)(8936002)(76116006)(83380400001)(91956017)(478600001)(66556008)(66476007)(55016002)(66446008)(64756008)(66946007)(86362001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?56DDHD5+L407wH4A98Y29zzcGPadrIDo5dPbnlFhC8D0Axtu1bJYYkEOHM4n?=
 =?us-ascii?Q?KE7R/+TzfoA1elvZfMni2oKEelFUNywAcFeUM5QUYi8PnOppyMe6TQRoI3xA?=
 =?us-ascii?Q?GxHa+hUY0vAH0G1VK3oINPFnSXv7bijptmlmV6m3E5ED2PggmiOX+ucZhR9I?=
 =?us-ascii?Q?E6K3D+UdB+Lkyst2cAJadh9vgWhhAnpCI9MFraFFdSlBhK2s5eot/eOipdxp?=
 =?us-ascii?Q?dptA+zdMmKWDfwJ50cSx36Ff/VYT3bxiNvNy339FBArAvu9lUix+dfAGtyHS?=
 =?us-ascii?Q?ZTwLrY2aqAHXk7AbE3y4Z8hkP5O7N/JjwM/EHm9xZ+ZIUp5oN27bk/KL6iGR?=
 =?us-ascii?Q?pVVWbjF1e4gaK0FV5oKwDSxM5UxETDlK9tw/ZMCmBTF7MEELNytWSiIYl+ew?=
 =?us-ascii?Q?Ml6nPH5T8KrfWCI4Z3rDycPjS4RjemwGuAAI6S1Dzw0yrcmUQ8fGpbultYXy?=
 =?us-ascii?Q?oU4M3UniOWoNxOWyzxHAdwYfZM7ay6YO38mhBNi6pFo+fWswtk5Klusk1ihF?=
 =?us-ascii?Q?Kpv7sPMTfvTArhrTUlDMALR9umqvGmmgRP2qDNxeeQa4Vi9o24FemB/fzfen?=
 =?us-ascii?Q?PSWpVK/AYlObxyAo+oGaZsGVXat6axxc1YB9dV+DzebbzVJCRGL7qsno1Zl9?=
 =?us-ascii?Q?Mp/++9Gv8Oo1EwEmqo+nybfy/GpKxlzg6OtCpXkm7cWIu0rPrZDQr5kOS5g9?=
 =?us-ascii?Q?W/CLvtkiXMe8Nxkidb+GL/xg+q2OY1tDWVjTNz8JsdeAiDV5hEefPGgNJvhi?=
 =?us-ascii?Q?lholBDur7tRUW2cbQRgneQ39s9jnMe8nLmrvQALsGtHDqJloyAgSmSCsf4Xh?=
 =?us-ascii?Q?mRXsDTFJ9OtZUO7Kq4KmELjafBqvv3/RWlzytjbCNvmBwln9upsjIlfKAQHi?=
 =?us-ascii?Q?F3NiLDywhHbVem/b9sOyYz0e4TpG8n/B6k3ScSSNytiICzP+WWdMLOUN850J?=
 =?us-ascii?Q?YzWFkrxKoJbcwqZDh+czEVW7BtPyx2FjMwjDr7YlTq2xFlgnZRq23qfggnAn?=
 =?us-ascii?Q?QSyj+M6dSbB9o8f7XU5vQLkxVd0D0OXIxQJNqt3cLtqkJxemmYL1GRzJlvr1?=
 =?us-ascii?Q?buisXKINtSTb0K1Sp27cKbWxYGQ0JIB37C+bJ7cHTFbNztz9PKfk/TPYEb6x?=
 =?us-ascii?Q?VsXTSGmLC+osNaHXRwOGzUjXYjDp8Ar2jajcDYIrGax8tPWP7TnkBx4ONe9j?=
 =?us-ascii?Q?6vhvz5ugEBjhDM+/5EiFGXMuQmvd8dh+1/8N9OzZDdByHqre2mptH0WnVRHG?=
 =?us-ascii?Q?nZfwOkl+WglPnKpLeNpvfe4yia5wdYbcwrC0GJluJJkGVOup80MQXwPXl6cT?=
 =?us-ascii?Q?8tc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f87604-4da7-4dec-98ac-08d921845d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 02:57:43.6546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lN0KK0NlIRLcSdR/EJqmm/xtUSzGjVcRvfClrxBfQlfMEaCU6xF4Q7+JYPqpBznz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2538
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
Cc: "Liu, Leo" <Leo.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============0102037659=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0102037659==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB46509FA352D90D4AED912523B0229DM6PR12MB4650namp_"

--_000_DM6PR12MB46509FA352D90D4AED912523B0229DM6PR12MB4650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com<mailto:tao.zhou1@amd.com>>
________________________________
From: Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd=
.com>
Sent: Friday, May 28, 2021 12:08 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Leo <Leo.Liu@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Gopalakrish=
nan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH] tests/amdgpu: Add VCN test support for Biege Goby

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Added Beige Goby chip id in vcn test.

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd=
.com>
---
 tests/amdgpu/vcn_tests.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/amdgpu/vcn_tests.c b/tests/amdgpu/vcn_tests.c
index 628b4910..15d573d3 100644
--- a/tests/amdgpu/vcn_tests.c
+++ b/tests/amdgpu/vcn_tests.c
@@ -142,7 +142,8 @@ CU_BOOL suite_vcn_tests_enable(void)
         } else if (family_id =3D=3D AMDGPU_FAMILY_NV) {
                 if (chip_id =3D=3D (chip_rev + 0x28) ||
                     chip_id =3D=3D (chip_rev + 0x32) ||
-                   chip_id =3D=3D (chip_rev + 0x3c)) {
+                   chip_id =3D=3D (chip_rev + 0x3c) ||
+                   chip_id =3D=3D (chip_rev + 0x46)) {
                         reg.data0 =3D 0x10;
                         reg.data1 =3D 0x11;
                         reg.cmd =3D 0xf;
--
2.25.1


--_000_DM6PR12MB46509FA352D90D4AED912523B0229DM6PR12MB4650namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"margin:0px;font-family:Calibri, sans-serif;background-color:=
white">Reviewed-by: Tao Zhou &lt;</span><a href=3D"mailto:tao.zhou1@amd.com=
" target=3D"_blank" rel=3D"noopener noreferrer" data-auth=3D"NotApplicable"=
 style=3D"margin:0px;font-family:Calibri, sans-serif;background-color:white=
">tao.zhou1@amd.com</a><span style=3D"margin:0px;font-family:Calibri, sans-=
serif;background-color:white">&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Gopalakrishnan, Veera=
badhran (Veera) &lt;Veerabadhran.Gopalakrishnan@amd.com&gt;<br>
<b>Sent:</b> Friday, May 28, 2021 12:08 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Leo &lt;Leo.Liu@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.c=
om&gt;; Gopalakrishnan, Veerabadhran (Veera) &lt;Veerabadhran.Gopalakrishna=
n@amd.com&gt;<br>
<b>Subject:</b> [PATCH] tests/amdgpu: Add VCN test support for Biege Goby</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Veerabadhran Gopalakrishnan &lt;veerabadhran=
.gopalakrishnan@amd.com&gt;<br>
<br>
Added Beige Goby chip id in vcn test.<br>
<br>
Signed-off-by: Veerabadhran Gopalakrishnan &lt;veerabadhran.gopalakrishnan@=
amd.com&gt;<br>
---<br>
&nbsp;tests/amdgpu/vcn_tests.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/tests/amdgpu/vcn_tests.c b/tests/amdgpu/vcn_tests.c<br>
index 628b4910..15d573d3 100644<br>
--- a/tests/amdgpu/vcn_tests.c<br>
+++ b/tests/amdgpu/vcn_tests.c<br>
@@ -142,7 +142,8 @@ CU_BOOL suite_vcn_tests_enable(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (family_id =3D=
=3D AMDGPU_FAMILY_NV) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (chip_id =3D=3D (chip_rev + 0x28) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip_id =3D=3D (chip_rev + 0x=
32) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip_id =3D=3D (chip_rev + 0x3c)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip_id =3D=3D (chip_rev + 0x3c) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip_id =3D=3D (chip_rev + 0x46)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg.d=
ata0 =3D 0x10;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg.d=
ata1 =3D 0x11;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg.c=
md =3D 0xf;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB46509FA352D90D4AED912523B0229DM6PR12MB4650namp_--

--===============0102037659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0102037659==--
