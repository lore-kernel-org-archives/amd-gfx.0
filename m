Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2160C54FCE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 08:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81D020736
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 08:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G0haKxfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81D020736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D7A189D73;
	Mon, 23 Mar 2020 08:51:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C537989D73
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 08:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iT92QArUOwaZHPJi2tXTw31qTUZueUIc3hp/VNc8CMv0OGzQSLnYkOEC1eDRm62aEBmhyHE6dCzCvE8IX1KL7BdK7DuYLgyW7mqFNxNJbfxzYcReqQXRQK591/swVcWzR2gSxxhJiBfWCwB1NHAb7+nuOeVQKH8p9SBKlbihpD9v/69snZsdhvtjXiNzNn6kJe69g7vf2IHwuPJRGsyerdlNz4uQ4HSpPgVZXYdUYvIHGdT4sf2r4d85HeErxhRqfIcz7WOCBCvwQeFCJQPNTIQrw54jxwLS+LlRhCTx42awMSMvlg0e6mWhLZb3S9Uv9+PVsTVi88Z7auiorSSi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmrRVAqSjg8R8SxLXih/izPT45Dq1sFqu2OqKBHbAOE=;
 b=ZAUY2DeHA/rxtx55vLBo7fjskyrIUzkHIQsPcKSzFYQvlW+NL0jJvKvZ+Ea8qeTVVpgEzbM14PpXpz+/oEbEaJVSFKp+qOEKl96poj33Pun1v7kqhqBpo1/+mRTws9k7DG9d87aTybh+8xu1GiO/fVWTkPZH95EVT7oakKl71RUNs8qYyyxLR0C4jktfQ4htmDO5BJiN2Yspd2KcBOVoBjpmuZGjQ/h3C1tmw2sE8ZgDsMSrXNEB+nqxHMs7XNzzPZ3LW/rb17ruo0uSSxpjOcA0o0PxH5olJ30rOXXFMzcOtjv2VihWLy48LmAIOjx+PMNtMrdAf1Einh2+6p3/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmrRVAqSjg8R8SxLXih/izPT45Dq1sFqu2OqKBHbAOE=;
 b=G0haKxfgyn0ARV0RWAMklLpHDrGFEZSSDA1AdfHuw1/GrjsomJuhDo50kkVCPJh+ec/NTsYvbQWsomdOk2Lxvxy7wqZhZkU4wdZuS0rRp1NTPiOhi/nQMDkxG7Bo7/SfvHn30rfTikMgaRSQsh1IU7PEvbgR8IuHns3uyLKa/J8=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by MN2PR12MB2878.namprd12.prod.outlook.com (2603:10b6:208:aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 08:51:02 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 08:51:02 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: disabled fru eeprom access
Thread-Topic: [PATCH] drm/amdgpu: disabled fru eeprom access
Thread-Index: AdYA7+Od+6Br3Ot4S8WWmmxrN7LNSA==
Date: Mon, 23 Mar 2020 08:51:02 +0000
Message-ID: <MN2PR12MB366390D7A12182D389B9B108FBF00@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-23T08:50:57Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4ca58119-9909-4d62-a70b-00008fcd5070;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-23T08:50:57Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: bec33a02-b3a0-48c0-b34d-000036b6c8b0
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da5961b4-da3d-4bae-3e38-08d7cf0750bf
x-ms-traffictypediagnostic: MN2PR12MB2878:|MN2PR12MB2878:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB287804FF93C9CE56E593B9D4FBF00@MN2PR12MB2878.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(9686003)(76116006)(71200400001)(66446008)(64756008)(66556008)(66476007)(66616009)(66946007)(52536014)(5660300002)(8936002)(81166006)(478600001)(81156014)(8676002)(86362001)(6506007)(2906002)(186003)(7696005)(6636002)(33656002)(316002)(55016002)(26005)(558084003)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2878;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A8gQeAk0nFXhcmX+5z8a7K0qKud2jfesmzeLxIPKTX0iZiXkQx6jaNgMvWn88xLUP6HjyjvgLAnxobleFzloNiTmUefI65Gmiy4uQgdWpL3ydDiObH6VvToY8s6G0cPRUDwe7d1ig2G2JtOEDdrcSDuXJDZQFtEvEd0yJ2gNvwIyfgq6WUSWQ9AaZxA0PpSu/j7/vRHBe44rt/VPP3qPfZpYVVD3udliYJrVLDaHN70VyoOWTVablmTPOLpC8kSh+uHMRLidjwFVe4Mjw1zBl6wINa5g/euenWyxoHiglDXdxJz7bg0TFu7hXSIfhAz9yBpNyAvLwqHdd61V6xF0iJwyDjG7KlRi7vb39bHeH8JAAnv5W7KR+bXohY9Xy/LvYizGcVjCJn+JFLM/HxhuEmA+H+7N9UVdHXyvkkuCbGuhYQYaGkVNFSG3IDrykw/f
x-ms-exchange-antispam-messagedata: 0qJldbV7KXJxgU4ReDWzxcfl+htpjSXqF7ipWBA01kCDkkvajpnFafHKiThjMzurLQX2yfzJi1x6/SEXWNSXLCT5ViBmEvyBBQ9ociGn0Gl7k1eebbwLBQFsxC8UbOjj9VnLonogKbUHqyfSvFmyew==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB366390D7A12182D389B9B108FBF00MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5961b4-da3d-4bae-3e38-08d7cf0750bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 08:51:02.0357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejnT7wPKkI7C2mzdjCo/SvSz7Pff+ZYVMFy10tTyeo/CtUNL1lfLrw1RL4WJfCrtlVVeqkTjeUVCUbgIaH+r+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2878
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

--_004_MN2PR12MB366390D7A12182D389B9B108FBF00MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB366390D7A12182D389B9B108FBF00MN2PR12MB3663namp_"

--_000_MN2PR12MB366390D7A12182D389B9B108FBF00MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to:

  *   Disable FRU EEPROM access by default
  *   Add shell function to be used for supported device detection

Thank you,
John Clements

--_000_MN2PR12MB366390D7A12182D389B9B108FBF00MN2PR12MB3663namp_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
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
/* List Definitions */
@list l0
	{mso-list-id:1376734269;
	mso-list-type:hybrid;
	mso-list-template-ids:-1905985772 67698689 67698691 67698693 67698689 6769=
8691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
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
<p class=3D"MsoNormal">Submitting patch to:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Disable FRU EEPROM access by default<o:p></o:p></li><li class=3D"MsoL=
istParagraph" style=3D"margin-left:0in;mso-list:l0 level1 lfo1">Add shell f=
unction to be used for supported device detection<o:p></o:p></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB366390D7A12182D389B9B108FBF00MN2PR12MB3663namp_--

--_004_MN2PR12MB366390D7A12182D389B9B108FBF00MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-disabled-FRU-EEPROM-access.patch"
Content-Description: 0001-drm-amdgpu-disabled-FRU-EEPROM-access.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-disabled-FRU-EEPROM-access.patch"; size=1730;
	creation-date="Mon, 23 Mar 2020 08:46:00 GMT";
	modification-date="Mon, 23 Mar 2020 08:46:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5YWRiMWM2NThjOGJhM2E5YWUyMDk5MzYyZjBjMWJiMzhjODU3MzY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IE1vbiwgMjMgTWFyIDIwMjAgMTY6MzI6NDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBkaXNhYmxlZCBGUlUgRUVQUk9NIGFjY2VzcwoKYWRkZWQgYXNpYyBzdXBwb3J0
IGNoZWNraW5nIGZ1bmN0aW9uIHRvIGJlIGZpbGxlZCBpbiBieSBzdXBwb3J0ZWQgYXNpYyB0eXBl
cwoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpD
aGFuZ2UtSWQ6IEllNTg1YzdiMmI0ZDBmYmZlOWE3NjQzMDBhYTAxMDk3NjVlMjhkNGRmCi0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uYyB8IDE0ICsrKysr
KysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jCmluZGV4IDk5MGRlZTZlMjJk
NS4uNDI0NGIxYTIzNDEwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZnJ1X2VlcHJvbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9mcnVfZWVwcm9tLmMKQEAgLTI5LDYgKzI5LDEzIEBACiAjZGVmaW5lIEkyQ19QUk9EVUNUX0lO
Rk9fQUREUl9TSVpFCTB4MgogI2RlZmluZSBJMkNfUFJPRFVDVF9JTkZPX09GRlNFVAkJMHhDMAog
Citib29sIGlzX2ZydV9lZXByb21fc3VwcG9ydGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQoreworCS8qIFRPRE86IFJlc29sdmUgc3VwcG9ydGVkIEFTSUMgdHlwZSAqLworCisJcmV0dXJu
IGZhbHNlOworfQorCiBpbnQgYW1kZ3B1X2ZydV9yZWFkX2VlcHJvbShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgdWludDMyX3QgYWRkcnB0ciwKIAkJCSAgIHVuc2lnbmVkIGNoYXIgKmJ1ZmYp
CiB7CkBAIC0zOCw2ICs0NSwxMCBAQCBpbnQgYW1kZ3B1X2ZydV9yZWFkX2VlcHJvbShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3QgYWRkcnB0ciwKIAkJCS5mbGFncyAgPSBJMkNf
TV9SRCwKIAkJCS5idWYgICAgPSBidWZmLAogCX07CisKKwlpZiAoIWlzX2ZydV9lZXByb21fc3Vw
cG9ydGVkKGFkZXYpKQorCQlyZXR1cm4gMDsKKwogCWJ1ZmZbMF0gPSAwOwogCWJ1ZmZbMV0gPSBh
ZGRycHRyOwogCW1zZy5sZW4gPSBJMkNfUFJPRFVDVF9JTkZPX0FERFJfU0laRSArIDE7CkBAIC03
MSw2ICs4Miw5IEBAIGludCBhbWRncHVfZnJ1X2dldF9wcm9kdWN0X2luZm8oc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiAJdW5zaWduZWQgY2hhciBidWZmWzMyXTsKIAlpbnQgYWRkcnB0ciA9
IDAsIHNpemUgPSAwOwogCisJaWYgKCFpc19mcnVfZWVwcm9tX3N1cHBvcnRlZChhZGV2KSkKKwkJ
cmV0dXJuIDA7CisKIAkvKiBJZiBhbGdvIGV4aXN0cywgaXQgbWVhbnMgdGhhdCB0aGUgaTJjX2Fk
YXB0ZXIncyBpbml0aWFsaXplZCAqLwogCWlmICghYWRldi0+cG0uc211X2kyYy5hbGdvKSB7CiAJ
CURSTV9XQVJOKCJDYW5ub3QgYWNjZXNzIEZSVSwgRUVQUk9NIGFjY2Vzc29yIG5vdCBpbml0aWFs
aXplZCIpOwotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB366390D7A12182D389B9B108FBF00MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB366390D7A12182D389B9B108FBF00MN2PR12MB3663namp_--
