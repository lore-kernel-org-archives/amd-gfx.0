Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D1C10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 08:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA50208E4
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 08:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fvBSo2SN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA50208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3934B6E408;
	Tue, 10 Mar 2020 08:41:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF14D6E408
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 08:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc64g51BRtzkZhLo7qnTwMHBhX4nOLKDb5fCUpyRT3DtKm2sd6x30dxFfgwjH1Zogec1saIUNzqDBrEH0UO5/auAVzCDKuLhAsP5In+G1OdB2iiG4RNHhxxR1BRuMVFvr/P+3R40G7nyMlMDdkeEWF3zJqp2DzkruIJanSiGYodZo3EQHnJZDXYmGMLYpTIUqY8faNOorXsLsnF7vrqpF8+aI7NLm1ezt0I7Lku9FpSeoBkXuFqyR1ZZm2dfVHJs6+ucCqva9cO+ruzJ0qUZpeH2zyYctLETTS1btYILZHEcW4+GifAByvawO2WsMcAoNOp4f5YSbt80Tfmp+Kavvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0DMcnuf8i5Ud7USJI1OBRfCSPN6N0SUc9AoB+sVOGQ=;
 b=mmdnyTTwtlW+axNbdDInaWxrWDQP0A2hYDTlqL4JidczoWqwWSyysoQ8G49W1pwMiq9yibux/CXrvM6FJJCILkQfVWyCYe9eJKR6L/pMQAyrvAoThqmgFHgIKPAY/qiEGIlYLl7u7Q+NmkgXEfuBVW5LYnrh8vmgMXq8bh6/CE5gBqR+yoLdUFB+6z5QE5zjPYKIjRlcsDKOVid2MGAO83lMAfrrxB62LeM8/Oh3dK39ArUuxdZXu7KlU2aVs2ZgP2Zh1sKq6jiQo6gc/ugwg6jkxrohwfLZCgAZUm61rWH7e2vlRWfYtJuflKDcoH8ysZav3ASkrAc0Bl3ZfpOSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0DMcnuf8i5Ud7USJI1OBRfCSPN6N0SUc9AoB+sVOGQ=;
 b=fvBSo2SNGCo63jP2jPf38xgmNq0DBxOPRjhR9BuXUAS0ctK8k415JokX5o024RkOVRSJg3BAkJ7Stc0/dTKGwAqg291c1v71pDx2LK9bzFBy3SiiXQlZkQjtbf+xJIyVmj2uTV8awT9Hwz4JK9OfONNg/0BkEAj95PyV2l/UoOk=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by MN2PR12MB3391.namprd12.prod.outlook.com (2603:10b6:208:c3::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Tue, 10 Mar
 2020 08:41:47 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7%7]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 08:41:47 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: resolve failed error inject msg
Thread-Topic: [PATCH] drm/amdgpu: resolve failed error inject msg
Thread-Index: AdX2t3DemT+t8diMQKysDPFlyWTrvA==
Date: Tue, 10 Mar 2020 08:41:47 +0000
Message-ID: <MN2PR12MB3663BFD340186E29FCDEC728FBFF0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-10T08:41:41Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=45fcbebf-95c0-46b9-b672-00001401a6ee;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-10T08:41:41Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4293f1f3-2586-44bf-abf8-00008df4f604
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.224.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91c4f13b-2031-4aef-c4d0-08d7c4cedec6
x-ms-traffictypediagnostic: MN2PR12MB3391:|MN2PR12MB3391:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB339152677E5B610D1968F243FBFF0@MN2PR12MB3391.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39850400004)(366004)(396003)(199004)(189003)(55016002)(9686003)(6636002)(71200400001)(52536014)(86362001)(66946007)(2906002)(186003)(81156014)(478600001)(81166006)(7696005)(8936002)(76116006)(26005)(316002)(5660300002)(558084003)(6506007)(66616009)(66476007)(8676002)(66556008)(64756008)(66446008)(110136005)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3391;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qakJ08UyUuOioXTSnKjnHHPljRrppS0XDn+uEaxscZ+59+9Cpox3heYQ+qVduRzh4Swp/Ap1Zm4M7rt0FKjJgzGCCB6B4eFeSTgRaocFGEpJ4qq5dc/jvrpKiLyGtZi6eGMuxjxaBrwlUYwcFDw5eta3Cjd4se8vqC32u++/dRyXlN+IfHD6r44HrtK8KpayP5lGRbDWqJZeept84aPjM3iGJ8qpvWNfz0rroniiplRjnswN5lQn1rkrqxtIhLi7GpZoFRk8XMZ3HrCBXA963HQ1cRTZVICoB9i7FVNTJKHQcZPMhKQm/ngH+kCma2MniR7T77DU2YOa5yF2vA2HrtCiXIQVkZ0pI/s/U69B4JYZ2jgRykkg5MfqHF1NRIo2UTKjfZvmirf8AYIVA4dwxliwMQyj87m6kD0NL5US/u309Yx6OuYTlKLfxXLfuF8N
x-ms-exchange-antispam-messagedata: NuJgujY+W2GhM6w4nJA6j+5yMFPXcmyVqoD8kaI25R65WGSXv9879rK0eK7RwGeE3Bv8FP57PiPNbOzxnUaVjAS0G83qkg2IGDmxe9PEQ0CI9klJXkHJrL0y/omt2rYsVFYZHYe99cG8yUawx4PNPw==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB3663BFD340186E29FCDEC728FBFF0MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c4f13b-2031-4aef-c4d0-08d7c4cedec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 08:41:47.4341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b14CAydm68bxsX9lqQ7X7exXaWh/Wmzs9jCH4Z10ZZFEdUX3M7NEIxQR0ZikSN+tlIp+vMth8n4mCum3+Rkc+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3391
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

--_004_MN2PR12MB3663BFD340186E29FCDEC728FBFF0MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663BFD340186E29FCDEC728FBFF0MN2PR12MB3663namp_"

--_000_MN2PR12MB3663BFD340186E29FCDEC728FBFF0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to resolve issue where during a successful error inject in=
voke the associated at_event interrupt causes a false negative and outputs =
an error in the kernel message.

Thank you,
John Clements

--_000_MN2PR12MB3663BFD340186E29FCDEC728FBFF0MN2PR12MB3663namp_
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
<p class=3D"msipheadera92e061b" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to resolve issue where during a suc=
cessful error inject invoke the associated at_event interrupt causes a fals=
e negative and outputs an error in the kernel message.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3663BFD340186E29FCDEC728FBFF0MN2PR12MB3663namp_--

--_004_MN2PR12MB3663BFD340186E29FCDEC728FBFF0MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-resolve-failed-error-inject-msg.patch"
Content-Description: 0001-drm-amdgpu-resolve-failed-error-inject-msg.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-resolve-failed-error-inject-msg.patch"; size=2467;
	creation-date="Tue, 10 Mar 2020 08:39:00 GMT";
	modification-date="Tue, 10 Mar 2020 08:39:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxNWVmYTIyMTE1MmFlNmNhNTE0ZTVkNTFlNzRiMTQ1OWMzNTJhOGMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMTAgTWFyIDIwMjAgMTY6MzY6NTcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiByZXNvbHZlIGZhaWxlZCBlcnJvciBpbmplY3QgbXNnCgppbnZva2luZyBhbiBl
cnJvciBpbmplY3Rpb24gc3VjY2VzZnVsbHkgd2lsbCBjYXVzZSBhbiBhdF9ldmVudCBpbnR0ZXJ1
cHQgdGhhdAp3aWxsIG9jY3VyIGJlZm9yZSB0aGUgaW52b2tlIHNlcXVlbmNlIGNhbiBjb21wbGV0
ZSBjYXVzaW5nIGFuIGludmFsaWQgZXJyb3IKCkNoYW5nZS1JZDogSWY2YjE0YjBlYzc2YTY1ODVm
YTdmMDg0YTE2ZTUwZjllMjQwMDMyOWEKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9o
bi5jbGVtZW50c0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9wc3AuYyB8IDYgKysrKy0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAu
YyAgfCA2ICsrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCBhMTZj
ODEwMWUyNTAuLjY0MjZkYmVjYmE5NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BzcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9wc3AuYwpAQCAtMTUwLDYgKzE1MCw3IEBAIHBzcF9jbWRfc3VibWl0X2J1ZihzdHJ1Y3QgcHNw
X2NvbnRleHQgKnBzcCwKIAlpbnQgcmV0OwogCWludCBpbmRleDsKIAlpbnQgdGltZW91dCA9IDIw
MDA7CisJYm9vbCByYXNfaW50ciA9IGZhbHNlOwogCiAJbXV0ZXhfbG9jaygmcHNwLT5tdXRleCk7
CiAKQEAgLTE3NCw3ICsxNzUsOCBAQCBwc3BfY21kX3N1Ym1pdF9idWYoc3RydWN0IHBzcF9jb250
ZXh0ICpwc3AsCiAJCSAqIGJlY2F1c2UgZ3B1IHJlc2V0IHRocmVhZCB0cmlnZ2VyZWQgYW5kIGxv
Y2sgcmVzb3VyY2Ugc2hvdWxkCiAJCSAqIGJlIHJlbGVhc2VkIGZvciBwc3AgcmVzdW1lIHNlcXVl
bmNlLgogCQkgKi8KLQkJaWYgKGFtZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQoKSkKKwkJcmFzX2lu
dHIgPSBhbWRncHVfcmFzX2ludHJfdHJpZ2dlcmVkKCk7CisJCWlmIChyYXNfaW50cikKIAkJCWJy
ZWFrOwogCQltc2xlZXAoMSk7CiAJCWFtZGdwdV9hc2ljX2ludmFsaWRhdGVfaGRwKHBzcC0+YWRl
diwgTlVMTCk7CkBAIC0xODcsNyArMTg5LDcgQEAgcHNwX2NtZF9zdWJtaXRfYnVmKHN0cnVjdCBw
c3BfY29udGV4dCAqcHNwLAogCSAqIGR1cmluZyBwc3AgaW5pdGlhbGl6YXRpb24gdG8gYXZvaWQg
YnJlYWtpbmcgaHdfaW5pdCBhbmQgaXQgZG9lc24ndAogCSAqIHJldHVybiAtRUlOVkFMLgogCSAq
LwotCWlmIChwc3AtPmNtZF9idWZfbWVtLT5yZXNwLnN0YXR1cyB8fCAhdGltZW91dCkgeworCWlm
ICgocHNwLT5jbWRfYnVmX21lbS0+cmVzcC5zdGF0dXMgfHwgIXRpbWVvdXQpICYmICFyYXNfaW50
cikgewogCQlpZiAodWNvZGUpCiAJCQlEUk1fV0FSTigiZmFpbGVkIHRvIGxvYWQgdWNvZGUgaWQg
KCVkKSAiLAogCQkJCSAgdWNvZGUtPnVjb2RlX2lkKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
cHNwX3YxMV8wLmMKaW5kZXggMDgyOTE4OGMxYTVjLi43Y2MxMmM2YWVmNzcgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jCkBAIC0yNiw2ICsyNiw3IEBACiAKICNpbmNsdWRl
ICJhbWRncHUuaCIKICNpbmNsdWRlICJhbWRncHVfcHNwLmgiCisjaW5jbHVkZSAiYW1kZ3B1X3Jh
cy5oIgogI2luY2x1ZGUgImFtZGdwdV91Y29kZS5oIgogI2luY2x1ZGUgInNvYzE1X2NvbW1vbi5o
IgogI2luY2x1ZGUgInBzcF92MTFfMC5oIgpAQCAtODY0LDYgKzg2NSwxMSBAQCBzdGF0aWMgaW50
IHBzcF92MTFfMF9yYXNfdHJpZ2dlcl9lcnJvcihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKIAlp
ZiAocmV0KQogCQlyZXR1cm4gLUVJTlZBTDsKIAorCS8qIElmIGVycl9ldmVudF9hdGh1YiBvY2N1
cnMgZXJyb3IgaW5qZWN0IHdhcyBzdWNjZXNzZnVsLCBob3dldmVyCisJICAgcmV0dXJuIHN0YXR1
cyBmcm9tIFRBIGlzIG5vIGxvbmcgcmVsaWFibGUgKi8KKwlpZiAoYW1kZ3B1X3Jhc19pbnRyX3Ry
aWdnZXJlZCgpKQorCQlyZXR1cm4gMDsKKwogCXJldHVybiByYXNfY21kLT5yYXNfc3RhdHVzOwog
fQogCi0tIAoyLjE3LjEKCg==

--_004_MN2PR12MB3663BFD340186E29FCDEC728FBFF0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB3663BFD340186E29FCDEC728FBFF0MN2PR12MB3663namp_--
