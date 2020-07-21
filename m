Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F175C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F017D20729
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r+Q15F5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F017D20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C2FC6E55E;
	Tue, 21 Jul 2020 10:02:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E25C6E55E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 10:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuOsWpQ6mEatWu2O9WQWPMxR7MzZSS1bJ32aDZTFYzYqXXCn7Jm35T1IFnG40gG9uPR2Sef9v4QEAqUgDeJVkpV7s1ukO7dwnYY87QYhyf0C7sQVnUI9G9mz3e0fJtrlgrbYp7StysnRqqYSfYjNLf5k1njahoTXO3tXHx1wdGrZ66pv3ftUIJiG2BpiCy/dDKFyGOU6HEDPUvEKsWlB1s8681DOypH4FsZtLOf3OKDb5d+NSDagUO05K0QLI6PdsdwdSr++4Um30fhPCBECBCcpWxt1lSwGDqQpkq1QnxxYGdH0qOoLDQ7WwCnSWnMPEV2+M8/8z+W+br8QHPiEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHVsM/QqAWdqoDPLQy5/aZhcOy6rGoChNQ5vbuK33oI=;
 b=FYiHIhtfGXhv8wditqppvZxm/p+8Eqs2jJ/VvLpgNhUEr/kHume8LWa+qRnJKzuYCawV9t/zSetZiPTdYoOjcEqNUTuRaHm3NGjZ5KRMxuWJQoGoWxuxYv5cSHMroJJG05ddxA4ZG/WUW+2zXWTGVRZHgeB5FMG2//jAj9/tqYCJjTgKjFvzOqlkp2vIB3IdaN4n/bcFuM+BS9Km2xIG/fhX6/x84ON/KoBQdH0vg4c22lm7FuPrsmyUkToei+WcynsraezdQsTSFTuWR0nD3hbkIXuJBtFZh3qzxEwjvtw2YU8ngMUPYlTsRe0GEG7y/jOvstiOWVDXTAE7GIEuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHVsM/QqAWdqoDPLQy5/aZhcOy6rGoChNQ5vbuK33oI=;
 b=r+Q15F5zA/BkweQRrW9JiFJvaqCqAfJO1SIbe4s+0G/Js1PwP8H0epw40ZUq1ay3A+0j0WpEe/r60VopoXb828u8Pj/X43N77CTT9sRiuYI6ZIk22BZPaQZ8ib4t7WhTCbaAdxTUBVYugMfdy/PHfgOPMCi6jhTxdAyIATA13ps=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Tue, 21 Jul
 2020 10:02:02 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235%7]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 10:02:02 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add RAS EEPROM support for sienna chichlid
Thread-Topic: [PATCH] drm/amdgpu: add RAS EEPROM support for sienna chichlid
Thread-Index: AdZfReQyfeCz96ROS/qexdQQqwQahw==
Date: Tue, 21 Jul 2020 10:02:02 +0000
Message-ID: <MN2PR12MB4032998A82134DFD3D09739EFB780@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-21T10:01:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0ead8133-92be-4bec-a672-0000b76dc115;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-21T10:01:52Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: da07fd15-7761-4cdd-a77c-00009237913d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-21T10:02:00Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c5da0d4e-206e-4af2-aa8a-0000505833f9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a685f999-8ee2-46a7-e161-08d82d5d1da5
x-ms-traffictypediagnostic: MN2PR12MB4269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB426973F5AD9B3EFD2A91BA44FB780@MN2PR12MB4269.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6TNnsnVaBFZXx1shlLiUFBflkuObjFyB1P7vOE9RSK3SEENWMBIOZUyAemlI0h32WSgsDFHyscEwJEHK8SyP1pxBvnoBL+67MO0ghIC4DbzMmUciL7ADro+6Pn9vx+cVstob701f4/Mr2LRvaSBpvULzw0qMw/yEgdnA8YNOmjH8AONk+PV6jR+OUovWDvTEwHDw5XBhLYyGDJF3dVzjPeuPsikkD9vvFrOxs4+9jt/H3IPsn/NbeghrYmdElWkN9fNMK78QzP2QWQnJAm3Q0Q1B6E+/gyUbScDYjje3ma/S2i8A7TuV2VQFosyhjRU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(5660300002)(110136005)(86362001)(55016002)(52536014)(6636002)(316002)(76116006)(2906002)(66476007)(6506007)(66556008)(8676002)(66616009)(64756008)(66446008)(33656002)(558084003)(99936003)(71200400001)(26005)(7696005)(66946007)(186003)(9686003)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: mGf47TWQEybw0uMKN1t4yh/opqAnmPq8OZPQQY5fmZEbpuS/4rg5EO8jlPm8KyBtKQOM1n2zFYCNjGHWDbs/EAtbmCs9c3SPl2kgvWjgjm9TwIZl9HMQ5CaLGn9KwLO1G44GjBJTbZQ+LzkTBgAR+7ok1fJ5heNhHWjAmmor+qtawbZtMvR9kXZgp7PACthc97fZyNcrPs/mlW2lc+NWU0jQNXS0/BGjv3WVmIklk4oGIafiRd4VyN1GSaJUiZx/gro6PkvbTosd+wv6uI11sJ12oQjbtEKt0Q3y3lmQGf4sN2I2f59AGe3dfHlrXkPjys2dkGtMw8v6iLEHYP73hb1IM3t8VAQI7dYA4BdgqGBNXkCbU0x5RMZ/etHkjvB0MK2gOhHGX28jLwntNNitHhdFuP1IrVlhEZAekJdErFDklMA2GA7NbZ+nhk201n5UWzS1VcFw/4wX70hH4xRfGLhzuJeLxam0dUNEG3Z2B7WxQnvu0BjQDTaNQMJCFezK
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB4032998A82134DFD3D09739EFB780MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a685f999-8ee2-46a7-e161-08d82d5d1da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 10:02:02.2875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /D3irBmDEcBESAciRigghOgi5QZL9pLSQzjvbUF36aXCxM9PCBwdMjpsgHRCqxUbl+Mdr9nHz08FlG2QfCwImA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

--_004_MN2PR12MB4032998A82134DFD3D09739EFB780MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032998A82134DFD3D09739EFB780MN2PR12MB4032namp_"

--_000_MN2PR12MB4032998A82134DFD3D09739EFB780MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Submitting patch to enable RAS EEPROM support for sienna chichlid

--_000_MN2PR12MB4032998A82134DFD3D09739EFB780MN2PR12MB4032namp_
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
<p class=3D"MsoNormal">Submitting patch to enable RAS EEPROM support for si=
enna chichlid<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032998A82134DFD3D09739EFB780MN2PR12MB4032namp_--

--_004_MN2PR12MB4032998A82134DFD3D09739EFB780MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-add-RAS-EEPROM-support-for-sienna-chichli.patch"
Content-Description:  0001-drm-amdgpu-add-RAS-EEPROM-support-for-sienna-chichli.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-add-RAS-EEPROM-support-for-sienna-chichli.patch";
	size=1826; creation-date="Tue, 21 Jul 2020 10:01:00 GMT";
	modification-date="Tue, 21 Jul 2020 10:01:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzODc4ZTdhMWMyNWFjYmQ1OGZjOGU1NWFkYWI3ZWRiZTVhNWRjOGM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMjEgSnVsIDIwMjAgMTg6MDA6MTcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBhZGQgUkFTIEVFUFJPTSBzdXBwb3J0IGZvciBzaWVubmEgY2hpY2hsaWQKClJB
UyBFRVBST00gaW5pdC9hY2Nlc3Mgc3VwcG9ydAoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50
cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IEkyZTVmZmM3NTllMzJiZTAxMTE0
N2RhYjc1MzVmNWJiMDhkZTI3OTFjCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhc19lZXByb20uYyB8IDkgKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXNfZWVwcm9tLmMKaW5kZXggYzAwOTYwOTdiYmNmLi5iZmNjY2QzZjgyY2IgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYwpAQCAtMzAs
NiArMzAsNyBAQAogI2RlZmluZSBFRVBST01fSTJDX1RBUkdFVF9BRERSX1ZFR0EyMCAgICAJMHhB
MAogI2RlZmluZSBFRVBST01fSTJDX1RBUkdFVF9BRERSX0FSQ1RVUlVTICAJMHhBOAogI2RlZmlu
ZSBFRVBST01fSTJDX1RBUkdFVF9BRERSX0FSQ1RVUlVTX0QzNDIgIAkweEEwCisjZGVmaW5lIEVF
UFJPTV9JMkNfVEFSR0VUX0FERFJfU0lFTk5BX0NJQ0hMSUQgICAweEEwCiAKIC8qCiAgKiBUaGUg
MiBtYWNyb3MgYmVsbG93IHJlcHJlc2VudCB0aGUgYWN0dWFsIHNpemUgaW4gYnl0ZXMgdGhhdApA
QCAtODgsNiArODksMTAgQEAgc3RhdGljIGJvb2wgX19nZXRfZWVwcm9tX2kyY19hZGRyKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogCWNhc2UgQ0hJUF9BUkNUVVJVUzoKIAkJcmV0dXJuIF9f
Z2V0X2VlcHJvbV9pMmNfYWRkcl9hcmN0KGFkZXYsIGkyY19hZGRyKTsKIAorCWNhc2UgQ0hJUF9T
SUVOTkFfQ0lDSExJRDoKKwkJKmkyY19hZGRyID0gRUVQUk9NX0kyQ19UQVJHRVRfQUREUl9TSUVO
TkFfQ0lDSExJRDsKKwkJYnJlYWs7CisKIAlkZWZhdWx0OgogCQlyZXR1cm4gZmFsc2U7CiAJfQpA
QCAtMzg2LDcgKzM5MSw5IEBAIGludCBhbWRncHVfcmFzX2VlcHJvbV9wcm9jZXNzX3JlY29kcyhz
dHJ1Y3QgYW1kZ3B1X3Jhc19lZXByb21fY29udHJvbCAqY29udHJvbCwKIAlzdHJ1Y3QgZWVwcm9t
X3RhYmxlX3JlY29yZCAqcmVjb3JkOwogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gdG9f
YW1kZ3B1X2RldmljZShjb250cm9sKTsKIAotCWlmIChhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9W
RUdBMjAgJiYgYWRldi0+YXNpY190eXBlICE9IENISVBfQVJDVFVSVVMpCisJaWYgKGFkZXYtPmFz
aWNfdHlwZSAhPSBDSElQX1ZFR0EyMCAgICAgICAgICAgJiYKKwkgICAgYWRldi0+YXNpY190eXBl
ICE9IENISVBfQVJDVFVSVVMgICAgICAgICAmJgorCSAgICBhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJ
UF9TSUVOTkFfQ0lDSExJRCkKIAkJcmV0dXJuIDA7CiAKIAlidWZmcyA9IGtjYWxsb2MobnVtLCBF
RVBST01fQUREUkVTU19TSVpFICsgRUVQUk9NX1RBQkxFX1JFQ09SRF9TSVpFLAotLSAKMi4xNy4x
Cgo=

--_004_MN2PR12MB4032998A82134DFD3D09739EFB780MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB4032998A82134DFD3D09739EFB780MN2PR12MB4032namp_--
