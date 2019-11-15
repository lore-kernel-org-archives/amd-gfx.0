Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7033C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A8320709
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A8320709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F4E6E416;
	Fri, 15 Nov 2019 03:34:48 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690075.outbound.protection.outlook.com [40.107.69.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC1C96E416
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 03:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8mcC21yBBA3kWGzkMKeqxT0J2guDOfcBvljfjsR0o1LzXBfEIzfB9jWKDQlHtBqA3mZv4/8fVC7NK3biSYcErVLikgLUysx4T/JLu/7msMXm9lAHHBCGLGvNCmmhDYzDojKErvkapKzckoO0/lqNqPdLMDLJa422tLmnlF7VHXbEJqKdL8BCRlmgjJDiXBOJmednLv+6sBT3WVoeFsA9exwMWauPdVegtIfsVsHaV0ivjwl39IxvdojQcRS/qZ6p3uxL1vUvFUqsRVxDEd1tC3ucRj9ZNZJgizgaYVCGjVXXDRtKlxroDwO+1R70k0qsFTbzbjYvhH6q1c7PkSqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNXb7o7PydSOkUcsB4C6XU0nFp+eq5rZ0U/NI6+kZ/g=;
 b=fm8Ok7ebdvk/HfYVCR2CI1RlKACroBP+W3GFpTlJ8tgLx9N2QgP6Vs0f+h5flnFBUwK1xNRuWbI/gsuI3FlsddX2fXvRbCLmXUtc3iNj+Fw6fhrhLo3RnlkMlATnvUqfOsuxAmWs/kTW0XbcRlTKyE1kFL+aWDlUCErOcTQjH6bXk9EUroqE56CO1IvmTqWZtryARr5UBtmIQCKDZ7XtAJ6AN8py8MdPii7ThmG5Kt+VuXn150naLuMYv4IM/VakTDvfjDmnaSpMq4Zqnni3ExNd3GvKNIuB1bB8TyW0g9tKXV9U7Zu4hHX00XvYfxQC/UsEqAVxVWf4IDhoVVX5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 03:34:41 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:34:41 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/12] Initial TMZ support for libdrm and amdgpu_test
Thread-Topic: [PATCH 00/12] Initial TMZ support for libdrm and amdgpu_test
Thread-Index: AdWbZS9zkaIiZoX6RfWp4sYeL+Wmdw==
Date: Fri, 15 Nov 2019 03:34:41 +0000
Message-ID:
 <MN2PR12MB3838F61E68479F97A65B7E6EF0700@MN2PR12MB3838.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08cfc066-d4bb-427d-fa5c-08d7697cbff9
x-ms-traffictypediagnostic: MN2PR12MB3663:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB366361B837527D00F497D289F0700@MN2PR12MB3663.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(6306002)(9686003)(54896002)(55016002)(74316002)(5640700003)(7696005)(7736002)(26005)(486006)(4326008)(25786009)(102836004)(6506007)(6436002)(5660300002)(52536014)(478600001)(66446008)(66556008)(64756008)(76116006)(186003)(33656002)(86362001)(3846002)(6116002)(14454004)(790700001)(2501003)(66946007)(8936002)(66476007)(476003)(81156014)(81166006)(8676002)(2906002)(6916009)(66066001)(14444005)(256004)(316002)(54906003)(2351001)(71200400001)(71190400001)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:3; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qIajbCS4oHhwxQPusiJLnrIGZZ1Gc/WqMCDebhOQKjnn1J0F7YUduu+ZpjbH11PCmPLSv6/ADCQWa6UouZeRMdIxo7iPtCxZyLes01F9CQFsXEYcGnabke0wuMbiCdqCoKakc+Cwnt9jltrUX+8KwE+XM/hVj3ghc3gOyMIKbtcyGGEnPxu8v8PSRg7DJm0G8zE3bDyuqizWuCDGUrsFvqk8mlO7NJcmVh2d23Wt3RG/pSIAjwlWbRKkM484iB0qKp1FzmUPGvL78M2h+uuYKmjPIv20tv05ILTg+y2mxp1wExuel996crbiCcPDqAdEx4S9P0hvC47xI2MWOmYMiDv/t4OG6Nf6Bgm0LepWQNeOho2eHSL+dw+mk93tLPMnp3KlndZ5izhykLlElg1duVzA+nT/8zhJWPMd2wkeODIvKIPK1wEYGBL+YRyvNTWl
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cfc066-d4bb-427d-fa5c-08d7697cbff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 03:34:41.2297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzfZpLvY+vFoq6v71U2zcjzBVGVqoJ5T+k7xJuaUCAwyYGkvxz9cgkT6rxkfsVgT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNXb7o7PydSOkUcsB4C6XU0nFp+eq5rZ0U/NI6+kZ/g=;
 b=P6wfrpSE6htC5KO3R1iUrjKXVY2neKLfvB00CHHurTqejfnPmxu3dTBhbjaLphuiFo8mZWFA1GHoHCHYLvn/EOxZRXFZalMCRVOQmYxZjDPOcvVen7H5pZsYkXjCR7i+wh3TZsjIefMnyR0SW7J+lKmvudtMdw/Uyb+lILF6A/4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: "Olsak, Marek" <Marek.Olsak@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0698823465=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115033441.JSiIpT-D5xIyKx9w2M3w2Q11AZmJE9ECbOA3UPTZNXM@z>

--===============0698823465==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3838F61E68479F97A65B7E6EF0700MN2PR12MB3838namp_"

--_000_MN2PR12MB3838F61E68479F97A65B7E6EF0700MN2PR12MB3838namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

These series of patches are to initial TMZ support for libdrm and amdgpu_te=
st. They are based on amd-staging-hybrid-master20190125 branch. So far, gfx=
/sdma TMZ tests are passed on Raven.

Please review them.



Thanks,

Aaron

Aaron Liu (6):
  amdgpu: using IB flags for TMZ or non-TMZ
  tests/amdgpu: expand secure param for exec_cs_helper
  tests/amdgpu: add atomic_mem cp_packet to verify the secure buffer
  tests/amdgpu: add test to submit a gfx command with secure context
  tests/amdgpu: add atomic dma command to verify the secure buffer
  tests/amdgpu: add test to submit a sdma command with secure context

Huang Rui (6):
  amdgpu: add UAPI for creating encrypted buffers
  tests/amdgpu: add security test suite (v2)
  tests/amdgpu: add secure buffer allocation test for system memory
  tests/amdgpu: add secure buffer allocation test for invisible VRAM
  tests/amdgpu: expand write linear helper for security (v3)
  tests/amdgpu: add device handle as input param for exec_cs_helper and
    write_linear_helper (v4)

amdgpu/amdgpu.h               |   4 +-
amdgpu/amdgpu_cs.c            |   4 ++
include/drm/amdgpu_drm.h      |   5 ++
tests/amdgpu/amdgpu_test.c    |   7 ++
tests/amdgpu/amdgpu_test.h    |  27 +++++++
tests/amdgpu/basic_tests.c    | 161 ++++++++++++++++++++++++++++++++++++---=
---
tests/amdgpu/meson.build      |   2 +-
tests/amdgpu/security_tests.c | 134 +++++++++++++++++++++++++++++++++++
8 files changed, 322 insertions(+), 22 deletions(-)
create mode 100644 tests/amdgpu/security_tests.c

BR,
Aaron Liu


--_000_MN2PR12MB3838F61E68479F97A65B7E6EF0700MN2PR12MB3838namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">
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
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"MsoPlainText">These series of patches are to initial TMZ suppor=
t for libdrm and amdgpu_test. They are based on amd-staging-hybrid-master20=
190125 branch. So far, gfx/sdma TMZ tests are passed on Raven.<o:p></o:p></=
p>
<p class=3D"MsoPlainText">Please review them.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks,<o:p></o:p></p>
<p class=3D"MsoPlainText">Aaron<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Aaron Liu (6):<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; amdgpu: using IB flags for TMZ or non-TMZ<o:p=
></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: expand secure param for exec_cs=
_helper<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add atomic_mem cp_packet to ver=
ify the secure buffer<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add test to submit a gfx comman=
d with secure context<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add atomic dma command to verif=
y the secure buffer<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add test to submit a sdma comma=
nd with secure context<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Huang Rui (6):<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; amdgpu: add UAPI for creating encrypted buffe=
rs<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add security test suite (v2)<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add secure buffer allocation te=
st for system memory<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add secure buffer allocation te=
st for invisible VRAM<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: expand write linear helper for =
security (v3)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add device handle as input para=
m for exec_cs_helper and<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; write_linear_helper (v4)<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 &#43;-<o:p>=
</o:p></p>
<p class=3D"MsoNormal">amdgpu/amdgpu_cs.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 &#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">include/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp;&nbsp; 5 &#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">tests/amdgpu/amdgpu_test.c&nbsp;&nbsp;&nbsp; |&nbsp;=
&nbsp; 7 &#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">tests/amdgpu/amdgpu_test.h&nbsp;&nbsp;&nbsp; |&nbsp;=
 27 &#43;&#43;&#43;&#43;&#43;&#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">tests/amdgpu/basic_tests.c&nbsp;&nbsp;&nbsp; | 161 &=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;------<o:p></o:p></p>
<p class=3D"MsoNormal">tests/amdgpu/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp;&nbsp; 2 &#43;-<o:p></o:p></p>
<p class=3D"MsoNormal">tests/amdgpu/security_tests.c | 134 &#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">8 files changed, 322 insertions(&#43;), 22 deletions=
(-)<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 tests/amdgpu/security_tests.c<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">Aaron Liu<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3838F61E68479F97A65B7E6EF0700MN2PR12MB3838namp_--

--===============0698823465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0698823465==--
