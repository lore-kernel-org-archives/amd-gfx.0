Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358B6C10DCE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 16:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FFF20752
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 16:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wCabkJq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FFF20752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BE36E924;
	Wed, 18 Mar 2020 16:43:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 672656E922
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 16:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxLnbBhL2Iyurld9z2LwhAtEL7m4+uVHC/WamE6KdvAtYG/DtlbIMAgyLeX+0JksM5Z8d/93qtBb/0YJy6kcdVWxIX1bwQi29Fb0yatX88VwHiCO4TsB5VDuh9fq1dNII7XmLG0iBUL/zys12w4vtFetJJxoT2/5+oaXhZHERNh0LTDq/M54U1gHRXSDDy1cfh5zc9FA9m9n55f+bQfToTEfbDMVxc89crbXXCxgCzNDjO5sDa3z9RtfGOxREPmqDRz30iAVRPf8jVeqD+/ndGjVBpSBd0UVd2kB8Paml/chyasx77E/rZytVRS4AnW7eWOdTSMHg5I7ZxGPtdkXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3ouyqRJM88u0KWpMQa+6LNbC5T8+vn1uH27YL4bpUk=;
 b=iCYnbY2qfohMgbG6BvvSyx2NBfJsoVOPqVudJvSmzT3w2ZETOfMlp/Mcfr3R1+0fNgT0oMehlUxddk7r1iR8UhO0IbK4yoPZgHo7n/gJWF/kRmoj/3a9vmKC70V1/e3nFeAwrO3VF5itx5gdB1dTxxTMg7yi72wVyZVh/WfX+HmhexFGoZ2Z4RyKw9f8EJ3Xh60uqupkX4L+Px26I3xldEAVlmXpMXIpkNeGbgIDoO8gR6K/x5l79xqyXuo7HVBfd9Koq+C62puZl+AsPH4OPS2uLF8aypX8iwhsZj203zcZd/SAtcIg526f6scLKK5psCAi4JrTdCupmFzx3zY3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3ouyqRJM88u0KWpMQa+6LNbC5T8+vn1uH27YL4bpUk=;
 b=wCabkJq+J+yu3+E9LE+rTLzNxu6jlpIRh6X6f5caFKSwr78ZT/TDGf4qTac52ilBgS+PZT+oPdGI1IS9qp6xOaSxTkngynCohrHZ8kKlbTXh9LEj5iGpg7jDi21pMOwBxxcaFLb5h1ljE+X3qpbHjDugZ2/0x0vSKRGtov6PNmE=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by MN2PR12MB3632.namprd12.prod.outlook.com (2603:10b6:208:c1::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 16:43:26 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 16:43:26 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: protect RAS sysfs during GPU reset
Thread-Topic: [PATCH] drm/amdgpu: protect RAS sysfs during GPU reset
Thread-Index: AdX9RCQVSI9ZMbqdSK2p2WF8PrfNng==
Date: Wed, 18 Mar 2020 16:43:26 +0000
Message-ID: <MN2PR12MB366319CB1D5C555E104DCA90FBF70@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-18T16:43:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=008f71a3-e69b-4a8e-99e5-000051632fbb;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-18T16:43:16Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 5c059e8a-a610-463f-9163-00005da3fd95
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.224.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd7f5f4a-a87f-464f-b90a-08d7cb5b7b54
x-ms-traffictypediagnostic: MN2PR12MB3632:|MN2PR12MB3632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36324335828CF7EB977F45C9FBF70@MN2PR12MB3632.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:200;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(9686003)(558084003)(71200400001)(55016002)(76116006)(26005)(66946007)(66556008)(66616009)(64756008)(186003)(66446008)(5660300002)(66476007)(52536014)(110136005)(316002)(81166006)(8936002)(8676002)(81156014)(478600001)(6636002)(33656002)(6506007)(86362001)(7696005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3632;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /DbFptE1wNPm267eIwxlrpHAzWYH5ZG6YxasFED2/bL3wb7xVc40qlyVQVXqHA1AaOF1JdPnzA7LRqEls2wOHY5Uk+vqlemgKZff+r+4yPekhz43OlgkPGeiQUOgoB30db+guFAW2xdGTA23UbI8Gx3Ue9KwaFIeOJ/U6byqVgduuevi3coZ74n2ccVkS9y8XxZSZTmYkOeMucah2QY0B/0yxUyUsTB4VZCbr2bTeCaxV74z6F4tUAEMBk/jlk++XZLtnaOaYUoTCPfqMAbnlG+aQWxPK8UGNcNyO9enYSd7DLLHqw57t4G7iHz1QSHgbNBgyetWN37cxhM+fsBN7N9ETvy/hVBtlhzv+dFNAXuxVywwVRtq/g9Dilxi7z/c2kxxT4BaHv0hjlNfWue/uUThzx+YwRctALXxSHFtGetZlmisSP+1IxD2qYWrnbc3
x-ms-exchange-antispam-messagedata: 2j/eONfkOe7g6YPTeaEPHF8oLDxruRTM/H0HmXfYlMNT5tuyZmVDHUF77zNj7P/b16rctd9gaFan4Po1+AloAV1arcT6dx3KlRYUwexeh/y1ebvhpXQRl5FrJ+aZiDisMmP08OJYYA1ibhU1WjAcYg==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB366319CB1D5C555E104DCA90FBF70MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7f5f4a-a87f-464f-b90a-08d7cb5b7b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 16:43:26.5988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8c54ExxkGOcJvVg2CcQOKbgEhSanH7Co97D+FXDXa5jHN9LA+LoMG/5tlkAPLFk8DXilMTWa3WiJfKhVfGes1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3632
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

--_004_MN2PR12MB366319CB1D5C555E104DCA90FBF70MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB366319CB1D5C555E104DCA90FBF70MN2PR12MB3663namp_"

--_000_MN2PR12MB366319CB1D5C555E104DCA90FBF70MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Submitting patch for review to protect RAS sysfs access' during a RAS event=
 and to clear the MMHub EDC registers early on in a BACO reset

--_000_MN2PR12MB366319CB1D5C555E104DCA90FBF70MN2PR12MB3663namp_
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
	margin-bottom:.0001pt;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch for review to protect RAS sysfs acc=
ess&#8217; during a RAS event and to clear the MMHub EDC registers early on=
 in a BACO reset<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB366319CB1D5C555E104DCA90FBF70MN2PR12MB3663namp_--

--_004_MN2PR12MB366319CB1D5C555E104DCA90FBF70MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-protect-RAS-sysfs-during-GPU-reset.patch"
Content-Description: 0001-drm-amdgpu-protect-RAS-sysfs-during-GPU-reset.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-protect-RAS-sysfs-during-GPU-reset.patch";
	size=2656; creation-date="Wed, 18 Mar 2020 16:42:00 GMT";
	modification-date="Wed, 18 Mar 2020 16:42:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5NDVmNTRlMjhmZjAyMzA5NzExMzNlYTRmZTY1NjEyNjE4YmY5ZjA1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgMTkgTWFyIDIwMjAgMDA6Mzk6MjkgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBwcm90ZWN0IFJBUyBzeXNmcyBkdXJpbmcgR1BVIHJlc2V0CgpSQVMgc3lzZnMg
c2hvdWxkIGJlIHByb3RlY3RlZCB1bnRpbCBSQVMgaXMgcmUtaW5pdGlhbGl6ZWQKcG9zdCBHUFUg
cmVzZXQKCk1NSHViIEVEQyBiZWNvbWVzIGRpcnR5IGFmdGVyIEJBQ08gcmVzZXQKRURDIHJlZ2lz
dGVycyBzaG91bGQgYmUgY2xlYXJlZCBlYXJseSBvbiBpbiByZXNldCBwaGFzZQoKU2lnbmVkLW9m
Zi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IEkx
Y2QwNGIxNmJjOGQwNTI5MzdkOTNkNDdlNzAzNGRiNzQzNzQ2YzBkCi0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMTIgKysrKysrKysrKystCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgICAgfCAgOSArKysrKysrKysKIDIgZmls
ZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCA3Mjk1NjVmNzljZmUuLjM3ODA0
MzQ1MDk1ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpA
QCAtMjc0NCw2ICsyNzQ0LDkgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RldmljZV94Z21pX3Jlc2V0
X2Z1bmMoc3RydWN0IHdvcmtfc3RydWN0ICpfX3dvcmspCiAKIAkJaWYgKGFkZXYtPmFzaWNfcmVz
ZXRfcmVzKQogCQkJZ290byBmYWlsOworCisJCWlmIChhZGV2LT5tbWh1Yi5mdW5jcyAmJiBhZGV2
LT5tbWh1Yi5mdW5jcy0+cmVzZXRfcmFzX2Vycm9yX2NvdW50KQorCQkJYWRldi0+bW1odWIuZnVu
Y3MtPnJlc2V0X3Jhc19lcnJvcl9jb3VudChhZGV2KTsKIAl9IGVsc2UgewogCiAJCXRhc2tfYmFy
cmllcl9mdWxsKCZoaXZlLT50Yik7CkBAIC0zOTEyLDggKzM5MTUsMTUgQEAgc3RhdGljIGludCBh
bWRncHVfZG9fYXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5mbyAqaGl2ZSwKIAkJfQog
CX0KIAotCWlmICghciAmJiBhbWRncHVfcmFzX2ludHJfdHJpZ2dlcmVkKCkpCisJaWYgKCFyICYm
IGFtZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQoKSkgeworCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHRt
cF9hZGV2LCBkZXZpY2VfbGlzdF9oYW5kbGUsIGdtYy54Z21pLmhlYWQpIHsKKwkJCWlmICh0bXBf
YWRldi0+bW1odWIuZnVuY3MgJiYKKwkJCSAgICB0bXBfYWRldi0+bW1odWIuZnVuY3MtPnJlc2V0
X3Jhc19lcnJvcl9jb3VudCkKKwkJCQl0bXBfYWRldi0+bW1odWIuZnVuY3MtPnJlc2V0X3Jhc19l
cnJvcl9jb3VudCh0bXBfYWRldik7CisJCX0KKwogCQlhbWRncHVfcmFzX2ludHJfY2xlYXJlZCgp
OworCX0KIAogCWxpc3RfZm9yX2VhY2hfZW50cnkodG1wX2FkZXYsIGRldmljZV9saXN0X2hhbmRs
ZSwgZ21jLnhnbWkuaGVhZCkgewogCQlpZiAobmVlZF9mdWxsX3Jlc2V0KSB7CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKaW5kZXggNDMwNTVhMDFmMzVlLi4zYzMyYTk0ZDI0
MjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKQEAgLTI4MSw2ICsy
ODEsMTEgQEAgc3RhdGljIHNzaXplX3QgYW1kZ3B1X3Jhc19kZWJ1Z2ZzX2N0cmxfd3JpdGUoc3Ry
dWN0IGZpbGUgKmYsIGNvbnN0IGNoYXIgX191c2VyICoKIAlzdHJ1Y3QgcmFzX2RlYnVnX2lmIGRh
dGE7CiAJaW50IHJldCA9IDA7CiAKKwlpZiAoYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKSB7
CisJCURSTV9XQVJOKCJSQVMgV0FSTjogZXJyb3IgaW5qZWN0aW9uIGN1cnJlbnRseSBpbmFjY2Vz
c2libGVcbiIpOworCQlyZXR1cm4gc2l6ZTsKKwl9CisKIAlyZXQgPSBhbWRncHVfcmFzX2RlYnVn
ZnNfY3RybF9wYXJzZV9kYXRhKGYsIGJ1Ziwgc2l6ZSwgcG9zLCAmZGF0YSk7CiAJaWYgKHJldCkK
IAkJcmV0dXJuIC1FSU5WQUw7CkBAIC0zOTQsNiArMzk5LDEwIEBAIHN0YXRpYyBzc2l6ZV90IGFt
ZGdwdV9yYXNfc3lzZnNfcmVhZChzdHJ1Y3QgZGV2aWNlICpkZXYsCiAJCS5oZWFkID0gb2JqLT5o
ZWFkLAogCX07CiAKKwlpZiAoYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKQorCQlyZXR1cm4g
c25wcmludGYoYnVmLCBQQUdFX1NJWkUsCisJCQkJIlF1ZXJ5IGN1cnJlbnRseSBpbmFjY2Vzc2li
bGVcbiIpOworCiAJaWYgKGFtZGdwdV9yYXNfZXJyb3JfcXVlcnkob2JqLT5hZGV2LCAmaW5mbykp
CiAJCXJldHVybiAtRUlOVkFMOwogCi0tIAoyLjE3LjEKCg==

--_004_MN2PR12MB366319CB1D5C555E104DCA90FBF70MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB366319CB1D5C555E104DCA90FBF70MN2PR12MB3663namp_--
