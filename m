Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DE4C00523
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 07:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27A822314
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 07:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FZvTSTMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27A822314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD9F36E191;
	Fri,  3 Jan 2020 07:30:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9CB66E191
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 07:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLtz2CGLU9sDlwS/tmMD62Z8uuu5HUZur/OPnBequKLYH60YTbS8p5jgysoj4BHGiElMvpUWk9gI+4gvZiny9r7erNTv31LEIIPamguJfCMGCVTutVdSTml/7AGyqCrrV/upZy3DpOh3wCrrEnChq/mQx4pjhoWDraErXyiis6wdc94JN1ytwG2+5GFx06ZJOF8CWE2Y3yUEkyOLwm/vV1km10Mdstq4V6Gb8zxBF2wwvH2d1TSbAAxolS65HaWkdcn49Y5ekMzyi404Q+4C3XP0Kv6EeLVwpyfPo4Y/Sz3DZd5Oih5cLYFl0og7PGUR9w85XXsoKHff8bUVEYE9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXEL3+cx9goZ96ABtGqzbJ9rZ7Fsb/B31qBKJpUHMgE=;
 b=PEFrPuwp2b7u60/+X7V+fnpAfiHgpjMdYkHALIWd9NYdAKO+dCGm3KfO1JZ1Nt4MJ5iDe7n0rDNaM6ifvCqvlZQMbC1I+dpSLL3har4Jji/SyeaRzGg/w3wWEWuQJGoCR5oFXaUVJFBfvbjeq1rqt9SSnmC9QIEmOJnKJRItN45qRaZmWEENXDuiLVjpP21ErJ+4sg6/2wlr/butZ23yq3g1pBAdkOaUMpTLn+AFa4lWShZ0D70YtiR5xPRvQrCdTrSd9uI2SRVBoXBEesbxOWBGFS9Erw4KrhbQju4NLWhTjomztE+b3Ak3xSFjYCFQKh2Dmc0Jbr5dVtVFgSiOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXEL3+cx9goZ96ABtGqzbJ9rZ7Fsb/B31qBKJpUHMgE=;
 b=FZvTSTMMwfvQ8Tpks61O2kmupAgADm2quY9FFkh5WyPK9s6OwJNBjrvQz6uu85r3OuAKMoxCu5kt5+U8uDv3XUz4vnkh04sqOzsmhDRI8gZeb5k3HQxBjqUufqQcdxFrVV8EByPYwt3YqVTgLRLeuRq8FlCwoOUWo1EuZqzuzcU=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3120.namprd12.prod.outlook.com (20.178.243.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Fri, 3 Jan 2020 07:30:40 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2581.013; Fri, 3 Jan 2020
 07:30:40 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: removed GFX RAS support check in UMC ECC callback
Thread-Topic: [PATCH] drm/amdgpu: removed GFX RAS support check in UMC ECC
 callback
Thread-Index: AdXCB57L5MXRq23tS0GyMooPNbGDMQ==
Date: Fri, 3 Jan 2020 07:30:38 +0000
Message-ID: <MN2PR12MB36633DCCAAE396B3195CE594FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-03T07:30:34Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4d05c90f-0d64-4ffe-afd2-00001b50f17f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-03T07:30:34Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 18168b6d-644f-4d6d-9c9a-00002a337be1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.235.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 143817e2-ee06-45f0-984f-08d7901ed579
x-ms-traffictypediagnostic: MN2PR12MB3120:|MN2PR12MB3120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3120D8154408181058A8FC42FB230@MN2PR12MB3120.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(26005)(316002)(66556008)(66616009)(66476007)(66946007)(64756008)(186003)(33656002)(110136005)(66446008)(9686003)(55016002)(2906002)(76116006)(6636002)(8676002)(81156014)(81166006)(8936002)(558084003)(71200400001)(52536014)(6506007)(478600001)(5660300002)(7696005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3120;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WheDLVx0j4ppkCLi98rbHtEp/fwpqahsZ61VhEOSEYV7acsWhKsTbpQrXIAAtwtWC4iyKx6o+dRtGuwbSV2JjDF/JoNw+pUSu3r/XUbbpj9NDqud91gnhCW0JR01gdp3Pu2CtDjTrxGAEoSwI1BjwtgS83hQg+OY8qpscC6WL5HE7kFal5hPK4h5uFJtqiqlTXpM013zVWAxS1GAFg3oBiPHq2XMsigbQcgVZJtTqhFKCn1LiY4IW2RaovjlukYs2pODWCXKSlK2kipRCtgxJ3BaTO5NZte2h3eFE0Qep6lJAzETNp79FtYHWSubjMWPwItZGSiB0ODZblGRrw8puEpQSTrYdvc6GYBeQHxT8WJB8Smia3bz4tedi/hZ3mk9YRRTcdlsFhRgRcYwAy1/3BfV/w1oEUkDYMhcnM5Id+2bBLuQLvWDekGiDeGf6oVh
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB36633DCCAAE396B3195CE594FB230MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143817e2-ee06-45f0-984f-08d7901ed579
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 07:30:39.8490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9oPQXCLoAZZfayS8lqXZkMXmnheY/5s5LkzwUV0tIxzIl+SuS+wLFpA9M8rapB/Jh484ftEdsosGF85h9OZmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3120
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

--_004_MN2PR12MB36633DCCAAE396B3195CE594FB230MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB36633DCCAAE396B3195CE594FB230MN2PR12MB3663namp_"

--_000_MN2PR12MB36633DCCAAE396B3195CE594FB230MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Enable path for GPU recovery in event of UMC uncorrectable error.

Thank you,
John Clements

--_000_MN2PR12MB36633DCCAAE396B3195CE594FB230MN2PR12MB3663namp_
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
<p class=3D"msipheader4d0fcdd7" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Enable path for GPU recovery in event of UMC uncorre=
ctable error.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB36633DCCAAE396B3195CE594FB230MN2PR12MB3663namp_--

--_004_MN2PR12MB36633DCCAAE396B3195CE594FB230MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-removed-GFX-RAS-support-check-in-UMC-ECC-.patch"
Content-Description:  0001-drm-amdgpu-removed-GFX-RAS-support-check-in-UMC-ECC-.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-removed-GFX-RAS-support-check-in-UMC-ECC-.patch";
	size=1607; creation-date="Fri, 03 Jan 2020 07:29:00 GMT";
	modification-date="Fri, 03 Jan 2020 07:29:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhYTIyYzE2MzQ2MDQ3MmQ0NjdkNGNlMzM3MmRhOWU3ZDc3YTdiMjkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgMyBKYW4gMjAyMCAxNTowNDoxMyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IHJlbW92ZWQgR0ZYIFJBUyBzdXBwb3J0IGNoZWNrIGluIFVNQyBFQ0MgY2FsbGJh
Y2sKCmVuYWJsZSBHUFUgcmVjb3ZlcnkgaW4gZXZlbnQgb2YgdW5jb3JyZWN0YWJsZSBVTUMgZXJy
b3IKCkNoYW5nZS1JZDogSTc0NmQ5YTI3NjE0YTU1ZGI0ZmRhYTRjMzcyMmZmZjA3ZWI5MGFjMzMK
U2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMuYyB8IDggKy0tLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdW1jLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdW1jLmMKaW5kZXggOGE2YzczM2QxNzBjLi5mNGQ0MDg1NTE0
N2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdW1jLmMKQEAgLTk1LDEzICs5
NSw2IEBAIGludCBhbWRncHVfdW1jX3Byb2Nlc3NfcmFzX2RhdGFfY2Ioc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCiB7CiAJc3RydWN0IHJhc19lcnJfZGF0YSAqZXJyX2RhdGEgPSAoc3RydWN0
IHJhc19lcnJfZGF0YSAqKXJhc19lcnJvcl9zdGF0dXM7CiAKLQkvKiBXaGVuIOKAnEZ1bGwgUkFT
4oCdIGlzIGVuYWJsZWQsIHRoZSBwZXItSVAgaW50ZXJydXB0IHNvdXJjZXMgc2hvdWxkCi0JICog
YmUgZGlzYWJsZWQgYW5kIHRoZSBkcml2ZXIgc2hvdWxkIG9ubHkgbG9vayBmb3IgdGhlIGFnZ3Jl
Z2F0ZWQKLQkgKiBpbnRlcnJ1cHQgdmlhIHN5bmMgZmxvb2QKLQkgKi8KLQlpZiAoYW1kZ3B1X3Jh
c19pc19zdXBwb3J0ZWQoYWRldiwgQU1ER1BVX1JBU19CTE9DS19fR0ZYKSkKLQkJcmV0dXJuIEFN
REdQVV9SQVNfU1VDQ0VTUzsKLQogCWtnZDJrZmRfc2V0X3NyYW1fZWNjX2ZsYWcoYWRldi0+a2Zk
LmRldik7CiAJaWYgKGFkZXYtPnVtYy5mdW5jcyAmJgogCSAgICBhZGV2LT51bWMuZnVuY3MtPnF1
ZXJ5X3Jhc19lcnJvcl9jb3VudCkKQEAgLTExMyw2ICsxMDYsNyBAQCBpbnQgYW1kZ3B1X3VtY19w
cm9jZXNzX3Jhc19kYXRhX2NiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQllcnJfZGF0
YS0+ZXJyX2FkZHIgPQogCQkJa2NhbGxvYyhhZGV2LT51bWMubWF4X3Jhc19lcnJfY250X3Blcl9x
dWVyeSwKIAkJCQlzaXplb2Yoc3RydWN0IGVlcHJvbV90YWJsZV9yZWNvcmQpLCBHRlBfS0VSTkVM
KTsKKwogCQkvKiBzdGlsbCBjYWxsIHF1ZXJ5X3Jhc19lcnJvcl9hZGRyZXNzIHRvIGNsZWFyIGVy
cm9yIHN0YXR1cwogCQkgKiBldmVuIE5PTUVNIGVycm9yIGlzIGVuY291bnRlcmVkCiAJCSAqLwot
LSAKMi4xNy4xCgo=

--_004_MN2PR12MB36633DCCAAE396B3195CE594FB230MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB36633DCCAAE396B3195CE594FB230MN2PR12MB3663namp_--
