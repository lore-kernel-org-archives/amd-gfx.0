Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18A5C010CF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 12:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8B3217F4
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 12:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8B3217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD0976EA38;
	Tue,  5 Nov 2019 12:43:47 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790045.outbound.protection.outlook.com [40.107.79.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C078975F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 20:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbrK/g+7gpOyD2RQVkwMDZHSr0n+sXtaq6T3JvTDBDGb7qssYGumyOqFMWFw05FYL52n6kvj17R51cyPzVoMtNh801QyuEFwQ1cF1wKzFWVPlhFwcAPyRtoIkl7Rck0r967b9x6o5nxHZ7lTLrnppwJY3oLgEtGo8+OjP4k5fqcwdMNxUNq8irO+sQjUdj/qdTOTv3e+N3sqRyGjzYnWXIePMq+5FSpE1zn1jHuCOmBtSJg+zTvNRQDRwmYNiTmq4kAVG4Y2wiDvrlrASLVhZasKNSWQZjEb6001oIeGp/mJGBEFxKyvqyh+BpXE4TW8s8lXcxZGYGQl0f7OTsM8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0Uk2SwNOyu6ZxtKcLuiJZoF3a1vDmMnOL14CVEfxfs=;
 b=l+LjzyCr9iGWpvj6VvvTb74Lr0dcNaaoTYspjqqsjRy1sIaKYqRrLok22sph5fnTmjCJVxRnmVbFiZ4n6RuIWNb1J+6qOSsbioE1fMTDE4yMtLH1s2s748554Me90htVzgTppqvANBp9C20n5u5csgDOt4759qRTvmuOUV6MbwOroWf2GI6xgg3xBTlmphnhh3z64d1EqUpEeNXmEt8/JpI4GebifCWmzX8Q8ti5fq8WwCi7bHVWXaCielKW5fqA08RyATxUWJ8SbJWguGUjN0hczPkl8faHOOECzSN2mZRlY3AIFMdW5Q7N4DUOIuUTbXbqy7Jpm18sPLmGZqsFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3209.namprd12.prod.outlook.com (20.179.105.33) by
 DM6PR12MB2764.namprd12.prod.outlook.com (20.176.116.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 4 Nov 2019 20:47:22 +0000
Received: from DM6PR12MB3209.namprd12.prod.outlook.com
 ([fe80::55f2:726e:999c:7e09]) by DM6PR12MB3209.namprd12.prod.outlook.com
 ([fe80::55f2:726e:999c:7e09%5]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 20:47:22 +0000
From: "Olsak, Marek" <Marek.Olsak@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "Cui, Flora"
 <Flora.Cui@amd.com>, brahma_sw_dev <brahma_sw_dev@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: enable dispatch/draw tests for renoir
Thread-Topic: enable dispatch/draw tests for renoir
Thread-Index: AdWSw7GK0JE71IjRTyi8wkFIW/O8egAC/XGgAANzMJAAHOPEuw==
Date: Mon, 4 Nov 2019 20:47:22 +0000
Message-ID:
 <DM6PR12MB32092334B0641855B23E119BF97F0@DM6PR12MB3209.namprd12.prod.outlook.com>
References: <MN2PR12MB2896FFB89D75369FBFADF7B8FD7F0@MN2PR12MB2896.namprd12.prod.outlook.com>
 <MN2PR12MB331266B0D149CE141977414DFA7F0@MN2PR12MB3312.namprd12.prod.outlook.com>,
 <MN2PR12MB289663A2B6D972B2FBADB261FD7F0@MN2PR12MB2896.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB289663A2B6D972B2FBADB261FD7F0@MN2PR12MB2896.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ba9e3c7-f1eb-4715-9d43-08d761683153
x-ms-traffictypediagnostic: DM6PR12MB2764:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2764503E85E0E594A02CF521F97F0@DM6PR12MB2764.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(199004)(189003)(7736002)(54906003)(11346002)(64756008)(446003)(7696005)(476003)(81156014)(110136005)(14454004)(66066001)(8936002)(9686003)(55016002)(26005)(76116006)(236005)(54896002)(91956017)(105004)(6246003)(256004)(6436002)(53546011)(6506007)(33656002)(5660300002)(19627405001)(66446008)(3846002)(102836004)(6116002)(186003)(2906002)(316002)(81166006)(71190400001)(86362001)(25786009)(76176011)(99286004)(52536014)(66946007)(66476007)(229853002)(4326008)(478600001)(19627235002)(2501003)(486006)(74316002)(71200400001)(8676002)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2764;
 H:DM6PR12MB3209.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBTuURZUejIsMvnatbrh9SnyJI1In6fM/1BC8aFm64MHxDFQis1IslEHAUDHjb1HtbJYzk8u6ZIIm6dErfLODh1LnQBYiMqYGzsqzz9JxPof16uoQCsq/+++9lkDomMIBMEumc3ZUKVopDYX4UkhZNajxAML3TP7OeVOZT2jInMGNwGqTmWcbJFdUsvvPvPIcKdFMaCXwNO+RK6Z7BceATgGRRRBVZi2NIKpdTSp8GUbOnC80HSkiYHMmb4RkLj7wlrIgfNPO+yq/VvJt+Juy966YI6LsHhWFMNvUHfd962z4gMvC3gMZCFO5W7R82wDU9G1tQQqpcJCc7KByPC9AHkIHAZ5NiE3duggouqLgmSGUaBUO8pLo5aEd+IuFhnqIiS0Y/ZQJSOs3BoEez1qiwYAgEPci52fl4L0umjLjZQPbfVRXtKbL2acrd1isojs
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba9e3c7-f1eb-4715-9d43-08d761683153
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 20:47:22.6661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V5Ts0oMmu+3ErgMTstyuqV4mDEIJPivERthGaFGcirbNB7Pv/iGtnUhAoAFdsTJA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2764
X-Mailman-Approved-At: Tue, 05 Nov 2019 12:43:46 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0Uk2SwNOyu6ZxtKcLuiJZoF3a1vDmMnOL14CVEfxfs=;
 b=Vt+QfVviRWwjfRMwvV6BZGZpZPkKCx79kVAOkD/tnUdKYoM1UFQxIq62ki5I8DHgUEAJEkVMagTvtnHxndErdKyYS9iPE7M0HZqNjYpVd+PsWjqc30A2EzM8SEqp4NEl0J9pL4bI6BdyoJIFeiEgwr0HHCQKOq5kBr/EWCQZNWo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Marek.Olsak@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Shimmer" <Xinmei.Huang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0977274414=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191104204722.Mebm0NKT_-b9-EhNy8Zmf4SDzDKY1AOeINlItqsDAQY@z>

--===============0977274414==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB32092334B0641855B23E119BF97F0DM6PR12MB3209namp_"

--_000_DM6PR12MB32092334B0641855B23E119BF97F0DM6PR12MB3209namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=9A=E1k <marek.olsak@amd.com>

Marek
________________________________
From: Zhu, Changfeng <Changfeng.Zhu@amd.com>
Sent: November 4, 2019 02:07
To: Cui, Flora <Flora.Cui@amd.com>; brahma_sw_dev <brahma_sw_dev@amd.com>; =
amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Aaron <Aaron.Liu@a=
md.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Huang, Ray <Ray.Huang@amd.=
com>; Huang, Shimmer <Xinmei.Huang@amd.com>; Deucher, Alexander <Alexander.=
Deucher@amd.com>; Olsak, Marek <Marek.Olsak@amd.com>
Subject: RE: enable dispatch/draw tests for renoir


Thanks for review, Flora.



Hi Alex & Marek,



Here is a libdrm patch for Renoir dispatch/draw tests.



Could you please help review it? It needs to be upstream.



BR,

Changfeng.



From: Cui, Flora <Flora.Cui@amd.com>
Sent: Monday, November 4, 2019 1:21 PM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com>; brahma_sw_dev <brahma_sw_dev@am=
d.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Aaron <Aaron.Liu@a=
md.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Huang, Ray <Ray.Huang@amd.=
com>; Huang, Shimmer <Xinmei.Huang@amd.com>
Subject: RE: enable dispatch/draw tests for renoir



Good catch. rb



From: Zhu, Changfeng <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>
Sent: Monday, November 4, 2019 11:59 AM
To: brahma_sw_dev <brahma_sw_dev@amd.com<mailto:brahma_sw_dev@amd.com>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Liu, Aaron <Aaron.Liu@amd.com<mailto:Aaron.Liu@amd.com>>; Cui, F=
lora <Flora.Cui@amd.com<mailto:Flora.Cui@amd.com>>; Zhang, Hawking <Hawking=
.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Huang, Ray <Ray.Huang@amd.co=
m<mailto:Ray.Huang@amd.com>>; Huang, Shimmer <Xinmei.Huang@amd.com<mailto:X=
inmei.Huang@amd.com>>
Subject: enable dispatch/draw tests for renoir



Hi Ray & Flora,



It can run dispatch/draw tests on new Renoir chips. So we can take back dis=
patch/draw tests for Renoir.



Could you please help review this patch?



From 793b7fd4dd1580f29e27bd2a90da787535abee14 Mon Sep 17 00:00:00 2001

From: changzhu <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com>>

Date: Mon, 4 Nov 2019 11:48:19 +0800

Subject: [PATCH libdrm] tests/amdgpu: enable dispatch/draw tests for Renoir



It can run dispatch/draw tests on new renoir chips. So it needs to

enable dispatch/draw tests for Renoir again.



Change-Id: I3a72a4bbfe0fc663ee0e3e58d8e9c304f513e568

Signed-off-by: changzhu <Changfeng.Zhu@amd.com<mailto:Changfeng.Zhu@amd.com=
>>

---

tests/amdgpu/basic_tests.c | 16 +---------------

1 file changed, 1 insertion(+), 15 deletions(-)



diff --git a/tests/amdgpu/basic_tests.c b/tests/amdgpu/basic_tests.c

index e75b9d0d..a57dcbb4 100644

--- a/tests/amdgpu/basic_tests.c

+++ b/tests/amdgpu/basic_tests.c

@@ -592,20 +592,6 @@ int suite_basic_tests_init(void)



              family_id =3D gpu_info.family_id;



-             if (gpu_info.asic_id =3D=3D 0x1636) {

-                           if (amdgpu_set_test_active("Basic Tests",

-                                                                          =
"Dispatch Test",

-                                                                          =
CU_FALSE))

-                                          fprintf(stderr, "test deactivati=
on failed - %s\n",

-                                                        CU_get_error_msg()=
);

-

-                           if (amdgpu_set_test_active("Basic Tests",

-                                                                          =
"Draw Test",

-                                                                          =
CU_FALSE))

-                                          fprintf(stderr, "test deactivati=
on failed - %s\n",

-                                                        CU_get_error_msg()=
);

-             }

-

             return CUE_SUCCESS;

}



@@ -2992,7 +2978,7 @@ void amdgpu_memset_draw(amdgpu_device_handle device_h=
andle,

             resources[1] =3D bo_shader_ps;

             resources[2] =3D bo_shader_vs;

             resources[3] =3D bo_cmd;

-             r =3D amdgpu_bo_list_create(device_handle, 3, resources, NULL=
, &bo_list);

+            r =3D amdgpu_bo_list_create(device_handle, 4, resources, NULL,=
 &bo_list);

             CU_ASSERT_EQUAL(r, 0);



              ib_info.ib_mc_address =3D mc_address_cmd;

--

2.17.1





BR,

Changfeng.

--_000_DM6PR12MB32092334B0641855B23E119BF97F0DM6PR12MB3209namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Marek Ol=9A=E1k &lt;marek.olsak@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Marek<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhu, Changfeng &lt;Ch=
angfeng.Zhu@amd.com&gt;<br>
<b>Sent:</b> November 4, 2019 02:07<br>
<b>To:</b> Cui, Flora &lt;Flora.Cui@amd.com&gt;; brahma_sw_dev &lt;brahma_s=
w_dev@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesk=
top.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liu, Aaron=
 &lt;Aaron.Liu@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; H=
uang, Ray &lt;Ray.Huang@amd.com&gt;; Huang, Shimmer &lt;Xinmei.Huang@amd.co=
m&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Olsak,
 Marek &lt;Marek.Olsak@amd.com&gt;<br>
<b>Subject:</b> RE: enable dispatch/draw tests for renoir</font>
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
p.x_MsoDate, li.x_MsoDate, div.x_MsoDate
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
a:visited, span.x_MsoHyperlinkFollowed
	{color:#954F72;
	text-decoration:underline}
p.x_msonormal0, li.x_msonormal0, div.x_msonormal0
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_DateChar
	{}
span.x_EmailStyle20
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.x_EmailStyle21
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.x_EmailStyle22
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.x_EmailStyle23
	{font-family:"Calibri",sans-serif;
	color:windowtext}
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
<p class=3D"x_MsoNormal">Thanks for review, Flora.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Hi Alex &amp; Marek,</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Here is a libdrm patch for Renoir dispatch/draw te=
sts.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Could you please help review it? It needs to be up=
stream.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">BR,</p>
<p class=3D"x_MsoNormal">Changfeng.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Cui, Flora &lt;Flora.Cui@amd.com&gt; =
<br>
<b>Sent:</b> Monday, November 4, 2019 1:21 PM<br>
<b>To:</b> Zhu, Changfeng &lt;Changfeng.Zhu@amd.com&gt;; brahma_sw_dev &lt;=
brahma_sw_dev@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Liu, Aaron=
 &lt;Aaron.Liu@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; H=
uang, Ray &lt;Ray.Huang@amd.com&gt;; Huang, Shimmer &lt;Xinmei.Huang@amd.co=
m&gt;<br>
<b>Subject:</b> RE: enable dispatch/draw tests for renoir</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Good catch. rb</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Zhu, Changfeng &lt;<a href=3D"mailto:=
Changfeng.Zhu@amd.com">Changfeng.Zhu@amd.com</a>&gt;
<br>
<b>Sent:</b> Monday, November 4, 2019 11:59 AM<br>
<b>To:</b> brahma_sw_dev &lt;<a href=3D"mailto:brahma_sw_dev@amd.com">brahm=
a_sw_dev@amd.com</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Liu, Aaron &lt;<a href=3D"mailto:Aar=
on.Liu@amd.com">Aaron.Liu@amd.com</a>&gt;; Cui, Flora &lt;<a href=3D"mailto=
:Flora.Cui@amd.com">Flora.Cui@amd.com</a>&gt;; Zhang, Hawking
 &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;=
; Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@amd.com</a>=
&gt;; Huang, Shimmer &lt;<a href=3D"mailto:Xinmei.Huang@amd.com">Xinmei.Hua=
ng@amd.com</a>&gt;<br>
<b>Subject:</b> enable dispatch/draw tests for renoir</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Hi Ray &amp; Flora,</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">It can run dispatch/draw tests on new Renoir chips=
. So we can take back dispatch/draw tests for Renoir.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Could you please help review this patch?</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">From 793b7fd4dd1580f29e27bd2a90da787535abee14 Mon =
Sep 17 00:00:00 2001</p>
<p class=3D"x_MsoNormal">From: changzhu &lt;<a href=3D"mailto:Changfeng.Zhu=
@amd.com">Changfeng.Zhu@amd.com</a>&gt;</p>
<p class=3D"x_MsoNormal">Date: Mon, 4 Nov 2019 11:48:19 &#43;0800</p>
<p class=3D"x_MsoNormal">Subject: [PATCH libdrm] tests/amdgpu: enable dispa=
tch/draw tests for Renoir</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">It can run dispatch/draw tests on new renoir chips=
. So it needs to</p>
<p class=3D"x_MsoNormal">enable dispatch/draw tests for Renoir again.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Change-Id: I3a72a4bbfe0fc663ee0e3e58d8e9c304f513e5=
68</p>
<p class=3D"x_MsoNormal">Signed-off-by: changzhu &lt;<a href=3D"mailto:Chan=
gfeng.Zhu@amd.com">Changfeng.Zhu@amd.com</a>&gt;</p>
<p class=3D"x_MsoNormal">---</p>
<p class=3D"x_MsoNormal">tests/amdgpu/basic_tests.c | 16 &#43;-------------=
--</p>
<p class=3D"x_MsoNormal">1 file changed, 1 insertion(&#43;), 15 deletions(-=
)</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">diff --git a/tests/amdgpu/basic_tests.c b/tests/am=
dgpu/basic_tests.c</p>
<p class=3D"x_MsoNormal">index e75b9d0d..a57dcbb4 100644</p>
<p class=3D"x_MsoNormal">--- a/tests/amdgpu/basic_tests.c</p>
<p class=3D"x_MsoNormal">&#43;&#43;&#43; b/tests/amdgpu/basic_tests.c</p>
<p class=3D"x_MsoNormal">@@ -592,20 &#43;592,6 @@ int suite_basic_tests_ini=
t(void)</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; family_id =3D gpu_info.family_id;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (gpu_info.asic_id =3D=3D 0x1636) {</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_set_test_active(&quot;Basic Tes=
ts&quot;,</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp; &quot;Dispatch Test&quot;,</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp; CU_FALSE))</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;test =
deactivation failed - %s\n&quot;,</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_get_error_msg()=
);</p>
<p class=3D"x_MsoNormal">-</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_set_test_active(&quot;Basic Tes=
ts&quot;,</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp; &quot;Draw Test&quot;,</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp; CU_FALSE))</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;test =
deactivation failed - %s\n&quot;,</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_get_error_msg()=
);</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal">-</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; return CUE_SUCCESS;</p>
<p class=3D"x_MsoNormal">}</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">@@ -2992,7 &#43;2978,7 @@ void amdgpu_memset_draw(=
amdgpu_device_handle device_handle,</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; resources[1] =3D bo_shader_ps;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; resources[2] =3D bo_shader_vs;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; resources[3] =3D bo_cmd;</p>
<p class=3D"x_MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_list_create(device_handle, 3, resou=
rces, NULL, &amp;bo_list);</p>
<p class=3D"x_MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_list_create(device_handle, 4, resourc=
es, NULL, &amp;bo_list);</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_info.ib_mc_address =3D mc_address_cmd;</p>
<p class=3D"x_MsoNormal">-- </p>
<p class=3D"x_MsoNormal">2.17.1</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">BR,</p>
<p class=3D"x_MsoNormal">Changfeng.</p>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB32092334B0641855B23E119BF97F0DM6PR12MB3209namp_--

--===============0977274414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0977274414==--
