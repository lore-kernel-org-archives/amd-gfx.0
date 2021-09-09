Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD3DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD1E60F11
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AD1E60F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027016E47A;
	Thu,  9 Sep 2021 07:58:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F4B6E47A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 07:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN7pj5VXOy9y5C7PgNcrJ8yzRveubvxA5Xcou5NzXHXVwItCabJU9l9W7by86U6wmkxn3XCpjiqzUyGKlDLsnN0wTXn/mxyAJVd+AMFunDEMwkGCrPjNi0u4XFqE94+2wtuKGKB7wCC0F0aX9ceyiul/lZDv190fThYtNVVzqvsEBpSK+/O6erDX/mraFysZJJKqlWdK+sXXcVbmTZLhhNuOe2T/gXfAzYHhADVlMP6jOnCIXETXzB62DzTAiWTI6N1llWByIQvwgZHq+4XkjFnzPURCoxkaCOowegke7sFg+bGxIKHJy4uNp7FFMZencL2JKyV88nkVCHUckLPzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=xemSZmsWv5uX68MVrxfiHHr3jIjJv0Wz2UPYHmMx8KQ=;
 b=A//x2vB+jxtfanhn+npSI+0iBGmhIrEMeUCy4muaFn7g2BcjZJvXGyPR5+x2h3c9MJpr45+8nmExrdaqY925H9KPwo1sO8Pig6GtKsNj5kQaPrOihMvIRXTKG55TV8QPRVWvQTt6MUf9z2svMV4K0YdTBb3rD0SUoZLxlUEDJ5v3WAbSezGmxwH82d+58pEmTuGrmDEQrqO3YW8ewWDmhdDAs2Vr4/CUlZ2tJjda9MW/23smN5if8ksvv+eok4D8h/TuysJsZeVRuhF6VqCej2D47HlL1UdkHzV2o5YciNSLX7EkkIynRNkjDIp+X8CX2vfNqqPP5SAo42ThNtkZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xemSZmsWv5uX68MVrxfiHHr3jIjJv0Wz2UPYHmMx8KQ=;
 b=4sXuHi/Izf67trDsvU3TdXeax7cF3TdHXGsrkKTQ3fsE08wbaJfD7fUWnt2YfW0CIV4zwM8mixd6eJpn2yQikSswaQKtUp81/Y9XKDh84FmotqNXG/vJtAbW6zmslSyvDW+2xjvHB7RjkPQcT2JbrjFBu0FYct87HKZ+4cNhcso=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 07:58:54 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4500.014; Thu, 9 Sep 2021
 07:58:53 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: Subject: [PATCH 1/1] drm/amdgpu: Update RAS trigger error block
 support
Thread-Topic: Subject: [PATCH 1/1] drm/amdgpu: Update RAS trigger error block
 support
Thread-Index: AdelUHE4vkYZdNDaSlayBUdjMUdcqQ==
Date: Thu, 9 Sep 2021 07:58:53 +0000
Message-ID: <BN9PR12MB52269FFD7928A6A2F697653EFBD59@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-09T07:58:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a030baba-8cf1-40f4-b423-4482685f9af6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4ad6961-bf1e-459a-b87e-08d97367ab18
x-ms-traffictypediagnostic: BN9PR12MB5081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5081658408E64711B52144B7FBD59@BN9PR12MB5081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nmnGtzcc5CWG69jl/J6+mE/DA2ZYY8ecWwhcdzndZt+4l70QeKv7XIl1CXckpKPz/k3GV9PfIZ/F48n6v0OrpoJVxz5x3cLsDyBA2Iuf3P6r32mT07AZfE86RGYjhAGDAz1JcQE54YiawJNg2YCZ5KjQQ8amSFLiCR7bACiWKam099heJO7vyh0JKaaPovqaUo7yg6JWH+6qeLVfbcp0AdW6VYhV22P6c0mWwLBmUg6b7l9nUbfwxuxsjvlJhM1w3fGdGhqcdsBwkj/Wm1/SCHBbhRJSpzZ1U2Wvie35QvBpjaDrYdc70z63w7ySoA+wJJ3LWH7a6zWieYgbdRj0z8Ok+KnXgBulagjNuQlwSpjKd8z6TZlzc8RDyC757B8c7qsheZYMRKLYYoiRTIth3QPhJl3ZA02wxbxiNaqjUwA3Kh9ZLqvoQWKEwaE90qGNoLZvmFPYp+qr78L79QiVuMq+a3nnRx45OplbUn9EtMsWm5qJ25Y6o7wkZFppCC/vXQnRzLZk48bxdUWbo7irJq3z16yiuAqG4sktopNaoj/GEMr2kchZvHaJjjTL8jU7QeZc9UW+kIxqVo8TavyAtTToRx3mMGnYkcq/aO8UOSqg6pRqwVJUL1G+KVHYB83pGVKGVzc2+RN90KRHp1gamvl0Dtu6FZX0/ivF12AgnrX5SDMJEgG7Ykmc7PPnyMnBMEAnwVnkdWG6seQcMBsDYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(6636002)(122000001)(86362001)(66476007)(66946007)(64756008)(66446008)(33656002)(8936002)(99936003)(38100700002)(83380400001)(6506007)(38070700005)(7696005)(110136005)(2906002)(316002)(71200400001)(26005)(186003)(52536014)(5660300002)(558084003)(8676002)(9686003)(76116006)(66556008)(66616009)(55016002)(478600001)(15650500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gOAg2yA7e0JPKBqwJX0Cwp8ZXPClGr785nykkGTs/QZ3kCOWnUqz17EwNAng?=
 =?us-ascii?Q?+Ngh5vRrz0lIlTDiVdMH+fl9tYU0nHJuimSZnYF6+v6eZvMYP4KFidMgB2fO?=
 =?us-ascii?Q?BVTB5ZFC9CP0bPzSrr2qvPbL31WjIkYr3rbBiKi0Re/tjtJiTmzzrc7BCCBB?=
 =?us-ascii?Q?VYZFRf5ZSKhmsIpCdyXfnGvcULVATtkGI62vNtuaiLazpH/y5SCcwAm6SymF?=
 =?us-ascii?Q?fkydMkOG6HmB8GaKrZKJnCiWa+Ar8WqunEZ9GCSRRDLNYmFvMQXv6LM9REaz?=
 =?us-ascii?Q?PgqxSieKD5tS1oW4Di74ExphyTtW5U3gx6ccZUtg0psPidIUCIZcDdubKXSb?=
 =?us-ascii?Q?4YlT74Ucef9xbZk3V/TDGfw0jRpEEE0W7xUjvt189xLv2vD1nYhHw7RNtwld?=
 =?us-ascii?Q?q70uKW6wqI7okOmyJY6RtC+MoAi2/0HZs9Fh6Bz/DYM1wwj87z8jJzmifEyO?=
 =?us-ascii?Q?hTB3hGp14gjdqEXwmLR6N/new6iP4iA0b1a8pgxiW6Hdza+XOCaZLgjV122l?=
 =?us-ascii?Q?WupR8qxl2TUVjX/ozaVGXrQsVUTPXkcjhqEU52RVu5m1HaozioLJfGL1S9hn?=
 =?us-ascii?Q?hsAi6mFG2GKoNv4C/e3uzGKweyit43iUnIVWTP5loAiDXNlKhnlrQEMUJN09?=
 =?us-ascii?Q?qf08SQQPJHnaJqii6uQF5MzUlNBML3ZhCfNFqMJ2KlWewiZcP74hqybH3Dos?=
 =?us-ascii?Q?Kl1uMbyK0tCdC9NjDDaelaik0IQJxCX2y5ATKhk115W5uHLh77YOVsYkPSER?=
 =?us-ascii?Q?vqwf2BvCS+8KntVE5iXVc7QVrKhEkxWHTAgI2t5XVJhBtg4D36Q36Vx+4L+o?=
 =?us-ascii?Q?ypwBBOxloIV9OLvQwVJxFRqNSIhVPvM+YctnbSnbNpDpY5NRbA+8w8dE+LEg?=
 =?us-ascii?Q?5HNFzbM4WM3ZKXwWvsxqmyzuLx5RXKwPx0NTNMug4JT7/394qSgyL6oPzmrC?=
 =?us-ascii?Q?8NLFZjUly3PCx6+tkAxUXc6MCmDC7fZCxGKmBZ13gPXG+wbzh/Zi3woD5So3?=
 =?us-ascii?Q?XwyBRcnjSKojebM0v6Mv+IXMbcHr9qfBelMkU+uTHTSH9kzm3pzFJ1TSzsX6?=
 =?us-ascii?Q?Iql65HjlwuEy9KQLHca+adexULFGxqNCqzO/F6JbxnQd0WK7aajFlkIHXa6R?=
 =?us-ascii?Q?j5wV3t/vCjPFaZQ/ziQBJ5oshxxbgreF6ToOykcpRSlxatHsNz8cdswyCCIB?=
 =?us-ascii?Q?wHSwaBrUmeMaMWaVyHISjQ9QlJE9W/mxbaa2AT84iWgZBhJXbWPrA90PzU51?=
 =?us-ascii?Q?sPtU7MUPkMYshzCnnRH6Zvn35Nu55rEFxm0LnpXaXqw4hFn/AXkV+mDy2OO0?=
 =?us-ascii?Q?/I9edEK8WzgI38S6fVRX4E0h?=
Content-Type: multipart/mixed;
 boundary="_004_BN9PR12MB52269FFD7928A6A2F697653EFBD59BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ad6961-bf1e-459a-b87e-08d97367ab18
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 07:58:53.8199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r35v6ChVmHmiJGCwvSygkQdt8QDh+cwMzAzFcWQhsIpdEFJLnVCmS7/YxOihWonVgHKtPwvsks5+dRJV3T32dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081
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

--_004_BN9PR12MB52269FFD7928A6A2F697653EFBD59BN9PR12MB5226namp_
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB52269FFD7928A6A2F697653EFBD59BN9PR12MB5226namp_"

--_000_BN9PR12MB52269FFD7928A6A2F697653EFBD59BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Submitting patch to update RAS trigger error to support additional blocks

--_000_BN9PR12MB52269FFD7928A6A2F697653EFBD59BN9PR12MB5226namp_
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheadera4477989" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to update RAS trigger error to supp=
ort additional blocks<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB52269FFD7928A6A2F697653EFBD59BN9PR12MB5226namp_--

--_004_BN9PR12MB52269FFD7928A6A2F697653EFBD59BN9PR12MB5226namp_
Content-Type: application/octet-stream;
	name="0002-drm-amdgpu-Update-RAS-trigger-error-block-support.patch"
Content-Description:  0002-drm-amdgpu-Update-RAS-trigger-error-block-support.patch
Content-Disposition: attachment;
	filename="0002-drm-amdgpu-Update-RAS-trigger-error-block-support.patch";
	size=1080; creation-date="Thu, 09 Sep 2021 07:58:00 GMT";
	modification-date="Thu, 09 Sep 2021 07:58:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjM2NmMzY0NTRjY2FjYTI0MTYzYzU3OWE5M2E0MGFiMjVkN2YzYzhjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgOSBTZXAgMjAyMSAxNTo1MTo0MSArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8x
XSBkcm0vYW1kZ3B1OiBVcGRhdGUgUkFTIHRyaWdnZXIgZXJyb3IgYmxvY2sgc3VwcG9ydAoKQWRk
ZWQgdHJpZ2dlciBlcnJvciBzdXBwb3J0IGZvciBNUDAvTVAxL01QSU8gYmxvY2tzCgpTaWduZWQt
b2ZmLWJ5OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDog
SWMyZjk5ZTg0NjMzNDM4ZDcwZmQ2YTc5OWE5YTUxMGI2Njk4MWIwYTIKLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwppbmRl
eCA3NzE0MDgyMWRjMTEuLmI1MzMyZGI0ZDI4NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXMuYwpAQCAtMTAyOCw2ICsxMDI4LDkgQEAgaW50IGFtZGdwdV9yYXNfZXJyb3Jf
aW5qZWN0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCWNhc2UgQU1ER1BVX1JBU19CTE9D
S19fU0RNQToKIAljYXNlIEFNREdQVV9SQVNfQkxPQ0tfX01NSFVCOgogCWNhc2UgQU1ER1BVX1JB
U19CTE9DS19fUENJRV9CSUY6CisJY2FzZSBBTURHUFVfUkFTX0JMT0NLX19NUDA6CisJY2FzZSBB
TURHUFVfUkFTX0JMT0NLX19NUDE6CisJY2FzZSBBTURHUFVfUkFTX0JMT0NLX19NUElPOgogCQly
ZXQgPSBwc3BfcmFzX3RyaWdnZXJfZXJyb3IoJmFkZXYtPnBzcCwgJmJsb2NrX2luZm8pOwogCQli
cmVhazsKIAljYXNlIEFNREdQVV9SQVNfQkxPQ0tfX1hHTUlfV0FGTDoKLS0gCjIuMTcuMQoK

--_004_BN9PR12MB52269FFD7928A6A2F697653EFBD59BN9PR12MB5226namp_--
