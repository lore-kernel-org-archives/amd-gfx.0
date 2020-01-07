Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEEBC33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 07:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9938F2075A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 07:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qEhli2+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9938F2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DDA46E7E2;
	Tue,  7 Jan 2020 07:28:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644BC6E7E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 07:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEVyfVSgm4qgNWCINhUQdtPlHtIySc5qYb9dDY3RnDUzeLxcJQTkY27Bg63rbCRVofY1tS8VxU0ljHqqfnHiQ97E3DvPwIrh8HneIv0TkfXJK4sUHptQbl7o5sWcpnfu0M/vvzg3uABbHwv2bPXP2dUVxzNOmCAfWtN2rA/jiEASysYyQekhn9dIeLNXhlFFelRHXFxAHf5wgpJHPbBR0W5ZF+KKCaTks/ArSYzo8MPl8OuMmx1ou82P17ffWZp5lpX1YME4bm7avbnc0aDAxDqJaKFkonsU01buSXO7cV+t1Lh4dKzTtl9TaO1BJxvGwCQB+YZLolKApOfzzcY/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTPAjkF2aILGcqqa6OhsGyWLo1AU0gPjhnKvHyGDt8Q=;
 b=HTXlsR8Hp705FhLoyBu61OZiwPzMQjG1qZF7btbuVdsUUIhjyitfhsmGyIWhEcf1V8hghs1Tcq8JZwU6dPIQ9IpZPRyE9cX0XmEhKNaSx2ACbRDPrfzWNp4iC6PDD/zrvV8sog/bykK4zRB8ABpMrtMkoMXds5UnSX6TLk8ST1HbBZeaWtPasJqiINbHFHXeQnB6dqoRAefStZszDnFb2fJL3yP62z7ipoUa9hqOMKZg2aaSGu5UviAWage82V2X8iQzsNmBLkbMwUTtp092hoylD3vs1BIIpid6Q+aXldBK5Cjsbs0zCht5lgQwQXu33qrR+IDY4ZqLCirBG1zb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTPAjkF2aILGcqqa6OhsGyWLo1AU0gPjhnKvHyGDt8Q=;
 b=qEhli2+9lN/wMkC8QTfWIvQkVzJxxuVaDPDSMupRCsKTkuhnGRnG8COBvxSbbKDrYH0pNLlrK/E4+d89DTOjnm8LvZ1y7gYGIy/5pdBAU0ZNdLSFolX29bvazEKUuixJriER37gz3PNLQa00z3CVs1hmCzvOMjDWHPSwzNh4j58=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3759.namprd12.prod.outlook.com (10.255.236.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Tue, 7 Jan 2020 07:28:02 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 07:28:02 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 dl.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com>
Subject: [PATCH] drm/amdgpu: updated UMC error address record with correct
 channel index
Thread-Topic: [PATCH] drm/amdgpu: updated UMC error address record with
 correct channel index
Thread-Index: AdXFK7YtNH2ongd8QiOefN8IMtm+Sg==
Date: Tue, 7 Jan 2020 07:28:02 +0000
Message-ID: <MN2PR12MB36634DB3BB902D08EE331367FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-07T07:27:57Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f5751062-7ee1-477f-8d5a-0000a73256ef;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-07T07:27:57Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8fde45d9-0298-4e34-b05d-0000b751ad38
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaf1b261-b845-484f-3822-08d793432123
x-ms-traffictypediagnostic: MN2PR12MB3759:|MN2PR12MB3759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB375990F230CC40876CC945B6FB3F0@MN2PR12MB3759.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(558084003)(26005)(66946007)(66476007)(66616009)(66556008)(316002)(6636002)(66446008)(64756008)(2906002)(186003)(7696005)(110136005)(6506007)(8676002)(33656002)(52536014)(81156014)(8936002)(71200400001)(81166006)(55016002)(9686003)(86362001)(76116006)(5660300002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3759;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C7eNC+Lnq1h3OeFIgmMrv+l0IgKoXR+aTDzjBmx27jp19tOsNBec70gZdYoILnT7/rbiB9ARYw4EUpOx4bWhlevnPnnjdNTW816M5MmdarKwCbU7WpD5Mz2Bb4kEFlzr+1ANf+2rkgTnlLyfEJqwxJn8XxZLdf/yPR+knGEN1RtMEhC6Y2FslZUbo0XRJ6KHxqkqtGEmAnialnA/5wjp4fI1pNozYWf6t0ME9Mi1wyvt5sTsJw8ftHn1bPzrXud6UwlyZpB0g/8Evattdfo6jTfKgN84fVHIqP7En0dumwGdxpuF8Yyfxwv1H+0rdVxWoD3qT0OXR2mRiGOD0mjw8NeqdijYRfVZzNggPM1fgxK/52vN3YCvlyk4+g4uep87J5pCDALbZwKjKCSpaPhCyKHbe7Q03zj3NFtdkuePr+mG36/SwXTmTw9ylY20mlNZ
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB36634DB3BB902D08EE331367FB3F0MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf1b261-b845-484f-3822-08d793432123
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 07:28:02.2143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KOwvCcqI0jyGdjw5YU2xG+snSWIiGkvlBtVLFx+at/aXhMQZEXZoWJbq1eSoTjaSb03xgg2Anka5WU4xriSPeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
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

--_004_MN2PR12MB36634DB3BB902D08EE331367FB3F0MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB36634DB3BB902D08EE331367FB3F0MN2PR12MB3663namp_"

--_000_MN2PR12MB36634DB3BB902D08EE331367FB3F0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Resolved issue with inputting an incorrect UMC channel index into the UMC e=
rror address record.

Defined macros for repetitive for loops

Thank you,
John Clements

--_000_MN2PR12MB36634DB3BB902D08EE331367FB3F0MN2PR12MB3663namp_
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
<p class=3D"MsoNormal">Resolved issue with inputting an incorrect UMC chann=
el index into the UMC error address record.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Defined macros for repetitive for loops<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB36634DB3BB902D08EE331367FB3F0MN2PR12MB3663namp_--

--_004_MN2PR12MB36634DB3BB902D08EE331367FB3F0MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-updated-UMC-error-address-record-with-cor.patch"
Content-Description:  0001-drm-amdgpu-updated-UMC-error-address-record-with-cor.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-updated-UMC-error-address-record-with-cor.patch";
	size=3122; creation-date="Tue, 07 Jan 2020 07:25:00 GMT";
	modification-date="Tue, 07 Jan 2020 07:25:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlMWMwNTc4N2U2NjMyYzBkNDM5MTEyMWI5NGUxNGI5YTdkYmVlMzY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgNyBKYW4gMjAyMCAxNToyMzozMyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IHVwZGF0ZWQgVU1DIGVycm9yIGFkZHJlc3MgcmVjb3JkIHdpdGggY29ycmVjdAog
Y2hhbm5lbCBpbmRleAoKZGVmaW5lZCBtYWNyb3MgZm9yIHJlcGV0aXRpdmUgZm9yIGxvb3BzCgpD
aGFuZ2UtSWQ6IEljY2E5MDk0MjRjOTVmNmM0NTc5NDFlNDVkZGU1NDcwMGIxNGQ4YzU5ClNpZ25l
ZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVudHNAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5jIHwgMTggKysrKysrKysrKystLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEuYwppbmRleCBmZTE4YWUzM2RhNjEuLmRmN2MzNTVj
MTU5NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5jCkBAIC00NCw2ICs0NCw5
IEBACiAvKiBvZmZzZXQgaW4gMjU2QiBibG9jayAqLwogI2RlZmluZSBPRkZTRVRfSU5fMjU2Ql9C
TE9DSyhhZGRyKQkJKChhZGRyKSAmIDB4ZmZVTEwpCiAKKyNkZWZpbmUgTE9PUF9VTUNfSU5TVCh1
bWNfaW5zdCkgZm9yICgodW1jX2luc3QpID0gMDsgKHVtY19pbnN0KSA8IGFkZXYtPnVtYy51bWNf
aW5zdF9udW07ICh1bWNfaW5zdCkrKykKKyNkZWZpbmUgTE9PUF9VTUNfQ0hfSU5TVChjaF9pbnN0
KSBmb3IgKChjaF9pbnN0KSA9IDA7IChjaF9pbnN0KSA8IGFkZXYtPnVtYy5jaGFubmVsX2luc3Rf
bnVtOyAoY2hfaW5zdCkrKykKKwogY29uc3QgdWludDMyX3QKIAl1bWNfdjZfMV9jaGFubmVsX2lk
eF90YmxbVU1DX1Y2XzFfVU1DX0lOU1RBTkNFX05VTV1bVU1DX1Y2XzFfQ0hBTk5FTF9JTlNUQU5D
RV9OVU1dID0gewogCQl7MiwgMTgsIDExLCAyN30sCXs0LCAyMCwgMTMsIDI5fSwKQEAgLTE2MSw4
ICsxNjQsOCBAQCBzdGF0aWMgdm9pZCB1bWNfdjZfMV9xdWVyeV9yYXNfZXJyb3JfY291bnQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJdWludDMyX3QgY2hfaW5zdCAgICAgICAgID0gMDsK
IAl1aW50MzJfdCB1bWNfcmVnX29mZnNldCAgPSAwOwogCi0JZm9yICh1bWNfaW5zdCA9IDA7IHVt
Y19pbnN0IDwgYWRldi0+dW1jLnVtY19pbnN0X251bTsgdW1jX2luc3QrKykgewotCQlmb3IgKGNo
X2luc3QgPSAwOyBjaF9pbnN0IDwgYWRldi0+dW1jLmNoYW5uZWxfaW5zdF9udW07IGNoX2luc3Qr
KykgeworCUxPT1BfVU1DX0lOU1QodW1jX2luc3QpIHsKKwkJTE9PUF9VTUNfQ0hfSU5TVChjaF9p
bnN0KSB7CiAJCQl1bWNfcmVnX29mZnNldCA9IGdldF91bWNfNl9yZWdfb2Zmc2V0KGFkZXYsCiAJ
CQkJCQkJICAgICAgdW1jX2luc3QsCiAJCQkJCQkJICAgICAgY2hfaW5zdCk7CkBAIC0xODAsMTIg
KzE4MywxMyBAQCBzdGF0aWMgdm9pZCB1bWNfdjZfMV9xdWVyeV9yYXNfZXJyb3JfY291bnQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiBzdGF0aWMgdm9pZCB1bWNfdjZfMV9xdWVyeV9lcnJv
cl9hZGRyZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJCQkgc3RydWN0IHJhc19l
cnJfZGF0YSAqZXJyX2RhdGEsCiAJCQkJCSB1aW50MzJfdCB1bWNfcmVnX29mZnNldCwKLQkJCQkJ
IHVpbnQzMl90IGNoYW5uZWxfaW5kZXgsCisJCQkJCSB1aW50MzJfdCBjaF9pbnN0LAogCQkJCQkg
dWludDMyX3QgdW1jX2luc3QpCiB7CiAJdWludDMyX3QgbHNiLCBtY191bWNfc3RhdHVzX2FkZHI7
CiAJdWludDY0X3QgbWNfdW1jX3N0YXR1cywgZXJyX2FkZHIsIHJldGlyZWRfcGFnZTsKIAlzdHJ1
Y3QgZWVwcm9tX3RhYmxlX3JlY29yZCAqZXJyX3JlYzsKKwl1aW50MzJfdCBjaGFubmVsX2luZGV4
ID0gdW1jX3Y2XzFfY2hhbm5lbF9pZHhfdGJsW3VtY19pbnN0XVtjaF9pbnN0XTsKIAogCWlmIChh
ZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9BUkNUVVJVUykgewogCQkvKiBVTUMgNl8xXzIgcmVnaXN0
ZXJzICovCkBAIC0yNTIsOCArMjU2LDggQEAgc3RhdGljIHZvaWQgdW1jX3Y2XzFfcXVlcnlfcmFz
X2Vycm9yX2FkZHJlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJdWludDMyX3QgY2hf
aW5zdCAgICAgICAgID0gMDsKIAl1aW50MzJfdCB1bWNfcmVnX29mZnNldCAgPSAwOwogCi0JZm9y
ICh1bWNfaW5zdCA9IDA7IHVtY19pbnN0IDwgYWRldi0+dW1jLnVtY19pbnN0X251bTsgdW1jX2lu
c3QrKykgewotCQlmb3IgKGNoX2luc3QgPSAwOyBjaF9pbnN0IDwgYWRldi0+dW1jLmNoYW5uZWxf
aW5zdF9udW07IGNoX2luc3QrKykgeworCUxPT1BfVU1DX0lOU1QodW1jX2luc3QpIHsKKwkJTE9P
UF9VTUNfQ0hfSU5TVChjaF9pbnN0KSB7CiAJCQl1bWNfcmVnX29mZnNldCA9IGdldF91bWNfNl9y
ZWdfb2Zmc2V0KGFkZXYsCiAJCQkJCQkJICAgICAgdW1jX2luc3QsCiAJCQkJCQkJICAgICAgY2hf
aW5zdCk7CkBAIC0zMTQsOCArMzE4LDggQEAgc3RhdGljIHZvaWQgdW1jX3Y2XzFfZXJyX2NudF9p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAJdW1jX3Y2XzFfZGlzYWJsZV91bWNf
aW5kZXhfbW9kZShhZGV2KTsKIAotCWZvciAodW1jX2luc3QgPSAwOyB1bWNfaW5zdCA8IGFkZXYt
PnVtYy51bWNfaW5zdF9udW07IHVtY19pbnN0KyspIHsKLQkJZm9yIChjaF9pbnN0ID0gMDsgY2hf
aW5zdCA8IGFkZXYtPnVtYy5jaGFubmVsX2luc3RfbnVtOyBjaF9pbnN0KyspIHsKKwlMT09QX1VN
Q19JTlNUKHVtY19pbnN0KSB7CisJCUxPT1BfVU1DX0NIX0lOU1QoY2hfaW5zdCkgewogCQkJdW1j
X3JlZ19vZmZzZXQgPSBnZXRfdW1jXzZfcmVnX29mZnNldChhZGV2LAogCQkJCQkJCSAgICAgIHVt
Y19pbnN0LAogCQkJCQkJCSAgICAgIGNoX2luc3QpOwotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB36634DB3BB902D08EE331367FB3F0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB36634DB3BB902D08EE331367FB3F0MN2PR12MB3663namp_--
