Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A5DC35DF5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 09:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9475A21744
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 09:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h9SWgHYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9475A21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A906E1E8;
	Tue, 25 Feb 2020 09:58:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F20F6E1E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 09:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VghALH6WUeohjVfsOR/LD/BUFSbm0RHFmpE9Akp44hixpiRa1SMX3OkF1miolj0krTsjjojcv+TAubpGK4M3qsW9JYxouHIBwY4eqJtB/9C8M6EvZlw0bnpLYpma+blPfCRV2kuoKiaN3LE+lnKwXILIaW0bkN5uDjemSdDpVf/n3VgEfU9mB6cRm0sXq8UHscuX55ZLJReNwf2lXK6x0K31y0DIOheOx0//Xi7jTYmX0ryj5XZJkhgpSUUNbDHtbx9Od6hEIdgL3OxDpGS/yw2JiYNr69T/X0LmuUPO3W3Uy5mHuV4WBKoU3YhnEEnKP3iGEJCraF2Rknzb5KP0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUiXfGb0znZc/Wn7Nfal4XVTXaRN8kZenjC+JTA2dBg=;
 b=d0fXXbgqOkdiZ5tDkQYcpFds/cMrh+ngzImw/r89M/qO7nqr+wWkCtnVJAfA5W6GJg0mTsWJgdGUnCR8kcCx1RxymjMtIuunXcxDt2qIucCh3Wd7Vl17uRf4pHMJ8CwPAvVVuOHqNk7UoFYKN1+LlC5GeW1MggguKJ7uAv6mHIl1uwNNxRAfwl0tFH1YQ/+P7dJ2i8ZcWZIwSpNOM/qbVqEqEUzv7/Pm63N/9cBityRBy30jvcDk6wMtwxzlqmkxi4vPqPQ21SpNQ0U0nQ5FBoDtcSXWWAfwqCiavvvCIg3rbuYrXznp+ngu8h4t0r3NRb/AfQj6aVNHtHC/h5IOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUiXfGb0znZc/Wn7Nfal4XVTXaRN8kZenjC+JTA2dBg=;
 b=h9SWgHYql1Hm/aPflaj2VJFnEZp0L8ruT8ycx3e5phyFJ7CsGMu2W4izYtxX6TfOjHFsO0OuqCinGYww3AZtCnoisPonh98be6BobWn5xXfEVIQEEfZjoGGG09/JB1B6fWiVdfEORarg6UXnhSl1n7fooxHYhNA2XEyJ7vFgKUQ=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by MN2PR12MB3134.namprd12.prod.outlook.com (2603:10b6:208:c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Tue, 25 Feb
 2020 09:58:24 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 09:58:24 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add Arcturus D342 page retire support
Thread-Topic: [PATCH] drm/amdgpu: Add Arcturus D342 page retire support
Thread-Index: AdXrwfXc71Ex/YysSc+kD4OiPsAZuQ==
Date: Tue, 25 Feb 2020 09:58:23 +0000
Message-ID: <MN2PR12MB36636BDD1DC83862F3F975D6FBED0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [240e:e0:b961:5500:6dd7:4395:8bca:3b26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fff958f-f29d-4a70-2b28-08d7b9d940b3
x-ms-traffictypediagnostic: MN2PR12MB3134:|MN2PR12MB3134:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB313420171A1824258AE50341FBED0@MN2PR12MB3134.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(199004)(189003)(2906002)(7696005)(52536014)(5660300002)(316002)(71200400001)(55016002)(110136005)(9686003)(6636002)(186003)(558084003)(33656002)(81156014)(478600001)(66446008)(64756008)(81166006)(66556008)(66616009)(8936002)(86362001)(66476007)(66946007)(76116006)(8676002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3134;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lD0tX5FkVdYe4/MNjBQJVlwgS61ve74CrRQijgU14jZ2E5j3lCbYPUrLXn7QPOeoOSQYPoRFpYTMWFfaZAzKZSq+m2pM2e7sTpscpH1jD8AGcThqpoRu3M8Hf1Oai8O8zBMIAPjaJk8vl8DA2Qk2RI/l6+OsoQ9JKGZLfqF0VZOr/T5fPw+u7QG4xKc+fcSv1TrcFrMDyMr3gi00K8S5Fb02Zze51kZedelzXBFi00RJ0SRkSH0PuG6Td9tQp6+8LjjwVnEndZDhk+oU8n3jTArzeL7rpMlL709iBDR/vsGKGbhpb8+2jMoa8P3JcbJT5YiRqrFf0x11/VwiVRdyUn5ib7VXpoze85kasq8PcMQCR1HMQKKOM5IoQ6B9RXa845+iKFp9dbKwrW5Hwi9ARFMCl1Zai4mN5BUvTftpGey2cRIt0SrStq33ak2Brd00
x-ms-exchange-antispam-messagedata: UwkopzzJmxVIimaOh4+LMC2hfv7dz+bDsvPk7n/t1k02EzW0kMikAHCZIWMCA3rDogykJ6RsYrD3hW+SPFpmrYFuryYVXSSfQM0P1lzgdQ1b5IakzS1ZWORdstD28rLvketr6xaoMDq/N7JHbMAyqcHSepCdVRy6i8MfXXIrK9Md4Gmgd4u9HuPFUxRUJ/IcZpi5AGad9tA/G8Rs/+kX6Q==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB36636BDD1DC83862F3F975D6FBED0MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fff958f-f29d-4a70-2b28-08d7b9d940b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 09:58:23.9420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83mDlaLH3B9HFhqxMJxJZu+oKJoTubqUSf+SAWwo337rimA/OFBNb5pu3WVgdeH+qP5i4QfYHqmvK13MEVcXqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3134
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

--_004_MN2PR12MB36636BDD1DC83862F3F975D6FBED0MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB36636BDD1DC83862F3F975D6FBED0MN2PR12MB3663namp_"

--_000_MN2PR12MB36636BDD1DC83862F3F975D6FBED0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Add support for detecting Arcturus SKU to resolve the correct bad page reti=
rement EEPROM I2C address.

Thank you,
John Clements

--_000_MN2PR12MB36636BDD1DC83862F3F975D6FBED0MN2PR12MB3663namp_
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
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
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
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Add support for detecting Arcturus SKU to resolve th=
e correct bad page retirement EEPROM I2C address.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB36636BDD1DC83862F3F975D6FBED0MN2PR12MB3663namp_--

--_004_MN2PR12MB36636BDD1DC83862F3F975D6FBED0MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Add-Arcturus-D342-page-retire-support.patch"
Content-Description:  0001-drm-amdgpu-Add-Arcturus-D342-page-retire-support.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Add-Arcturus-D342-page-retire-support.patch";
	size=3095; creation-date="Tue, 25 Feb 2020 09:57:03 GMT";
	modification-date="Tue, 25 Feb 2020 09:57:03 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1Yjc3Y2VmMzFlMGE1YmFiM2VjZGIwZjI4MmE1ODE0MWNhMDFkZTg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMjUgRmViIDIwMjAgMTc6NTQ6NTEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBBZGQgQXJjdHVydXMgRDM0MiBwYWdlIHJldGlyZSBzdXBwb3J0CgpDaGVjayBB
cmN0dXJ1cyBTS1UgdHlwZSB0byBzZWxlY3QgSTJDIGFkZHJlc3Mgb2YgcGFnZSByZXRpcmVtZW50
IEVFUFJPTQoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQu
Y29tPgpDaGFuZ2UtSWQ6IElhY2U0NzdhM2I2YTEzOTQwMzQxMjE0ZDVkMDk0YzUwMGVmOWJkNGY1
Ci0tLQogLi4uL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jICAgIHwgNTcg
KysrKysrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhc19lZXByb20uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNf
ZWVwcm9tLmMKaW5kZXggMmE4ZTA0ODk1NTk1Li5jMzBjZTU5YjQ4NTcgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYwpAQCAtMjYsOSArMjYsMTEg
QEAKICNpbmNsdWRlICJhbWRncHVfcmFzLmgiCiAjaW5jbHVkZSA8bGludXgvYml0cy5oPgogI2lu
Y2x1ZGUgInNtdV92MTFfMF9pMmMuaCIKKyNpbmNsdWRlICJhdG9tLmgiCiAKLSNkZWZpbmUgRUVQ
Uk9NX0kyQ19UQVJHRVRfQUREUl9BUkNUVVJVUyAgMHhBOAotI2RlZmluZSBFRVBST01fSTJDX1RB
UkdFVF9BRERSX1ZFR0EyMCAgICAweEEwCisjZGVmaW5lIEVFUFJPTV9JMkNfVEFSR0VUX0FERFJf
VkVHQTIwICAgIAkweEEwCisjZGVmaW5lIEVFUFJPTV9JMkNfVEFSR0VUX0FERFJfQVJDVFVSVVMg
IAkweEE4CisjZGVmaW5lIEVFUFJPTV9JMkNfVEFSR0VUX0FERFJfQVJDVFVSVVNfRDM0MiAgCTB4
QTAKIAogLyoKICAqIFRoZSAyIG1hY3JvcyBiZWxsb3cgcmVwcmVzZW50IHRoZSBhY3R1YWwgc2l6
ZSBpbiBieXRlcyB0aGF0CkBAIC01NSw2ICs1Nyw1MCBAQAogCiAjZGVmaW5lIHRvX2FtZGdwdV9k
ZXZpY2UoeCkgKGNvbnRhaW5lcl9vZih4LCBzdHJ1Y3QgYW1kZ3B1X3JhcywgZWVwcm9tX2NvbnRy
b2wpKS0+YWRldgogCitzdGF0aWMgYm9vbCBfX2dldF9lZXByb21faTJjX2FkZHJfYXJjdChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKKwkJCQkgICAgICAgdWludDE2X3QgKmkyY19hZGRyKQor
eworCXN0cnVjdCBhdG9tX2NvbnRleHQgKmF0b21fY3R4ID0gYWRldi0+bW9kZV9pbmZvLmF0b21f
Y29udGV4dDsKKworCWlmICghaTJjX2FkZHIgfHwgIWF0b21fY3R4KQorCQlyZXR1cm4gZmFsc2U7
CisKKwlpZiAoc3RybnN0cihhdG9tX2N0eC0+dmJpb3NfdmVyc2lvbiwKKwkgICAgICAgICAgICAi
RDM0MiIsCisJCSAgICBzaXplb2YoYXRvbV9jdHgtPnZiaW9zX3ZlcnNpb24pKSkKKwl7CisJCSpp
MmNfYWRkciA9IEVFUFJPTV9JMkNfVEFSR0VUX0FERFJfQVJDVFVSVVNfRDM0MjsKKwl9CisJZWxz
ZQorCXsKKwkJKmkyY19hZGRyID0gRUVQUk9NX0kyQ19UQVJHRVRfQUREUl9BUkNUVVJVUzsKKwl9
CisKKwlyZXR1cm4gdHJ1ZTsKK30KKworc3RhdGljIGJvb2wgX19nZXRfZWVwcm9tX2kyY19hZGRy
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAorCQkJCSAgdWludDE2X3QgKmkyY19hZGRyKQor
eworCWlmICghaTJjX2FkZHIpCisJCXJldHVybiBmYWxzZTsKKworCXN3aXRjaCAoYWRldi0+YXNp
Y190eXBlKSB7CisJY2FzZSBDSElQX1ZFR0EyMDoKKwkJKmkyY19hZGRyID0gRUVQUk9NX0kyQ19U
QVJHRVRfQUREUl9WRUdBMjA7CisJCWJyZWFrOworCisJY2FzZSBDSElQX0FSQ1RVUlVTOgorCQly
ZXR1cm4gX19nZXRfZWVwcm9tX2kyY19hZGRyX2FyY3QoYWRldiwgaTJjX2FkZHIpOworCQlicmVh
azsKKworCWRlZmF1bHQ6CisJCXJldHVybiBmYWxzZTsKKwl9CisKKwlyZXR1cm4gdHJ1ZTsKK30K
Kwogc3RhdGljIHZvaWQgX19lbmNvZGVfdGFibGVfaGVhZGVyX3RvX2J1ZmYoc3RydWN0IGFtZGdw
dV9yYXNfZWVwcm9tX3RhYmxlX2hlYWRlciAqaGRyLAogCQkJCQkgIHVuc2lnbmVkIGNoYXIgKmJ1
ZmYpCiB7CkBAIC0xMDMsOCArMTQ5LDYgQEAgc3RhdGljIGludCBfX3VwZGF0ZV90YWJsZV9oZWFk
ZXIoc3RydWN0IGFtZGdwdV9yYXNfZWVwcm9tX2NvbnRyb2wgKmNvbnRyb2wsCiAJcmV0dXJuIHJl
dDsKIH0KIAotCi0KIHN0YXRpYyB1aW50MzJfdCAgX19jYWxjX2hkcl9ieXRlX3N1bShzdHJ1Y3Qg
YW1kZ3B1X3Jhc19lZXByb21fY29udHJvbCAqY29udHJvbCkKIHsKIAlpbnQgaTsKQEAgLTIxMiwx
NiArMjU2LDE3IEBAIGludCBhbWRncHVfcmFzX2VlcHJvbV9pbml0KHN0cnVjdCBhbWRncHVfcmFz
X2VlcHJvbV9jb250cm9sICpjb250cm9sKQogCQkJLmJ1Zgk9IGJ1ZmYsCiAJfTsKIAorCWlmICgh
X19nZXRfZWVwcm9tX2kyY19hZGRyKGFkZXYsICZjb250cm9sLT5pMmNfYWRkcmVzcykpCisJCXJl
dHVybiAtRUlOVkFMOworCiAJbXV0ZXhfaW5pdCgmY29udHJvbC0+dGJsX211dGV4KTsKIAogCXN3
aXRjaCAoYWRldi0+YXNpY190eXBlKSB7CiAJY2FzZSBDSElQX1ZFR0EyMDoKLQkJY29udHJvbC0+
aTJjX2FkZHJlc3MgPSBFRVBST01fSTJDX1RBUkdFVF9BRERSX1ZFR0EyMDsKIAkJcmV0ID0gc211
X3YxMV8wX2kyY19lZXByb21fY29udHJvbF9pbml0KCZjb250cm9sLT5lZXByb21fYWNjZXNzb3Ip
OwogCQlicmVhazsKIAogCWNhc2UgQ0hJUF9BUkNUVVJVUzoKLQkJY29udHJvbC0+aTJjX2FkZHJl
c3MgPSBFRVBST01fSTJDX1RBUkdFVF9BRERSX0FSQ1RVUlVTOwogCQlyZXQgPSBzbXVfaTJjX2Vl
cHJvbV9pbml0KCZhZGV2LT5zbXUsICZjb250cm9sLT5lZXByb21fYWNjZXNzb3IpOwogCQlicmVh
azsKIAotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB36636BDD1DC83862F3F975D6FBED0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB36636BDD1DC83862F3F975D6FBED0MN2PR12MB3663namp_--
