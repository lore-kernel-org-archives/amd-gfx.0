Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E56C2D0DC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 10:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E75921734
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 10:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="woH+DZSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E75921734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F14A89FEC;
	Thu,  2 Jan 2020 10:31:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE40089FEC
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 10:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSmKaDz0lxrSx2npA2JkYJDxqX8UvM+M9Pww2ZbNpHMGMH6cgLsdiwDG15ndmSiB8+AgHK+wrMsPMkBv1ppFipw0WX4vQderH5cnjucximGhf6Tnt4falL5vKSjB65wsilGOyencVVOmuVd1Cw5Wq+EedHQ8GrMXMKFGBwIoK5TjCFQKFhhj0EJzjXicyybVdhEhVrls6gtTmWI7bV6TIwOM15RmQQEZ0ODvzKSkTf+JVOxIGtpvWjcdwRDdDoF0M0diX9T/ckc27U3oTMz5nwa+kjnKkxTT3rCM+JFXJHdusK4oDCDxlIr8sm48sT+6TvkuCnh4khvkBQmfci6niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3ot8bEceOMk04iUugAMtqQYwuFnxTWH06jIPydnkX0=;
 b=M6shkjaYv043vsYWCTYU9tX8NFaicJkTY1qpBSXtRY2pUdGeRP3VYoZqkvgcNWbPh2MImtFa8Pn5whP0x6McJOEtN73ikGpZhz5KHYM2P/On07MCCUaxRmVVNEHOhXVwXPdR5wzHA9+FuXniaQfDRXtoXnVzLv2xScIE2waFd+wy+LGsKtAad/+x2w25c4MP4lwAOwhY9HbxXMiQGSqxIg7SpL4uI3Kkn2DUwXfEt0rU6iNTQs6jUpRFh3Tlg1F41Nk0wvxBixrdQC5bhnJHIG2ZLYMsuUNbyFiPHrvetlJXwy1QaR7GB7C8dtyrH84k5FNeQ1CCAKQ8wGztg9vB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3ot8bEceOMk04iUugAMtqQYwuFnxTWH06jIPydnkX0=;
 b=woH+DZSKLgbowst2Oje4ZXYBXDlCdt/TJOh81z2qx6yzkkQ9OFMwawCQr7v+41juissiiFMhb7CMopDIuPMw6rGFSzK3RBT3Ngk09A1QY9REIx/3aWgtvozem3rmPj/tDLmoMio81qtV7rvqMrU/ZSLQKW7KJHD5DJKLd4b9jas=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB2928.namprd12.prod.outlook.com (20.179.83.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 2 Jan 2020 10:31:08 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2581.013; Thu, 2 Jan 2020
 10:31:08 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query
Thread-Topic: [PATCH] drm/amdgpu: resolved bug in UMC 6 error counter query
Thread-Index: AdXBV3Yg76uTyzhkQhyxmQ2h5s6tpQ==
Date: Thu, 2 Jan 2020 10:31:08 +0000
Message-ID: <MN2PR12MB3663CB891846CB098EED1354FB200@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-02T10:31:02Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=13d65165-6b96-40ed-aba4-0000484588ee;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-02T10:31:02Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a4bd5b85-1ab3-471d-a9d2-0000bade896f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.235.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ae24259-cd92-4ec6-bd5b-08d78f6ee148
x-ms-traffictypediagnostic: MN2PR12MB2928:|MN2PR12MB2928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB292886D78AD2BC4DE5845E48FB200@MN2PR12MB2928.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(33656002)(55016002)(86362001)(9686003)(26005)(6506007)(186003)(7696005)(558084003)(478600001)(8936002)(316002)(2906002)(8676002)(110136005)(81156014)(81166006)(52536014)(5660300002)(6636002)(66616009)(66476007)(66556008)(64756008)(66446008)(66946007)(71200400001)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2928;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmK3Kr5sZ68R3rm3Gb03/iKCQDIBOBG/0MQh2MzvF66kEYD+mSiNc719OyQtr7EI0Q6jnCCusE+jxAPTc5ijJQs+/ekimpxiniSjQmoERX656ocEkvtDqvkuLhwi9oA+CevEbCvO7+v28b9JFemI3fnV1dyDZHV0JavX14LwjF4GKNLt/iqNnIfapP8yEWaShGfyWgA6zzitK3W4kBFg2xDwvXxodad1100be69Ixh5At/Z+JHjq3EQDbfs7+SdySfqxe2lswFE+dj0ahu50YDP/CjPxNv1xu97u0oae4hzp2IOj+B7TaBtOqDo3xCyEWJCNS6N0VfTfqWZQ8OwaAcT+HuhsNHPoRa9erJE8aIPQ/Kmqnpy8CggY2XuJ8KbReRUV3Fwqe4kEeOWZEKKgqRfSyoF19wR4smakx3iR6WSPdyuNHRNl1oBVG0v9wcq/
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB3663CB891846CB098EED1354FB200MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae24259-cd92-4ec6-bd5b-08d78f6ee148
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 10:31:08.1871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQdWtUkNZUr8N10kA44fmTI2cunr2oG7/rs66rm/FjP3gGtfsoQjlGUhuC4fTqlkjfisQgzvFjA6zkVw05MJ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2928
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

--_004_MN2PR12MB3663CB891846CB098EED1354FB200MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663CB891846CB098EED1354FB200MN2PR12MB3663namp_"

--_000_MN2PR12MB3663CB891846CB098EED1354FB200MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Added patch to resolve following issue where error counter detection was no=
t iterating over all UMC instances/channels.
Removed support for accessing UMC error counters via MMIO.

Thank you,
John Clements

--_000_MN2PR12MB3663CB891846CB098EED1354FB200MN2PR12MB3663namp_
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
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
	{mso-list-id:506478527;
	mso-list-type:hybrid;
	mso-list-template-ids:1555212952 170301710 67698691 67698693 67698689 6769=
8691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:DengXian;}
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
<p class=3D"msipheader4d0fcdd7" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Added patch to resolve following issue where error c=
ounter detection was not iterating over all UMC instances/channels.<o:p></o=
:p></p>
<p class=3D"MsoNormal">Removed support for accessing UMC error counters via=
 MMIO.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3663CB891846CB098EED1354FB200MN2PR12MB3663namp_--

--_004_MN2PR12MB3663CB891846CB098EED1354FB200MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-resolve-bug-in-UMC-6-error-counter-query.patch"
Content-Description:  0001-drm-amdgpu-resolve-bug-in-UMC-6-error-counter-query.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-resolve-bug-in-UMC-6-error-counter-query.patch";
	size=9039; creation-date="Thu, 02 Jan 2020 10:29:00 GMT";
	modification-date="Thu, 02 Jan 2020 10:29:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3ZTNhYzA0NzE0MmEwZTM3MWYzNGIwOGMzOWFhNjFmNzlmODBmZWFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgMiBKYW4gMjAyMCAxODoyNzoxMCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IHJlc29sdmVkIGJ1ZyBpbiBVTUMgNiBlcnJvciBjb3VudGVyIHF1ZXJ5CgppdGVy
YXRlIG92ZXIgYWxsIGVycm9yIGNvdW50ZXIgcmVnaXN0ZXJzIGluIFNNTiBzcGFjZQoKcmVtb3Zl
ZCBzdXBwb3J0IGVycm9yIGNvdW50ZXIgYWNjZXNzIHZpYSBNTUlPCgpDaGFuZ2UtSWQ6IEliYzBh
ODI1ZDRkMjczNDBiZDE3ZGUxOWYwMzU4MjMzZjQ1Y2NiMjRjClNpZ25lZC1vZmYtYnk6IEpvaG4g
Q2xlbWVudHMgPGpvaG4uY2xlbWVudHNAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdW1jLmggfCAgMzUgLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdW1jX3Y2XzEuYyAgIHwgMTI3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLQogMiBmaWxl
cyBjaGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspLCA5MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdW1jLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdW1jLmgKaW5kZXggMzI4MzAzMmE3OGU1Li5hNjE1YTFlYjc1
MGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMuaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdW1jLmgKQEAgLTIxLDM4ICsy
MSw2IEBACiAjaWZuZGVmIF9fQU1ER1BVX1VNQ19IX18KICNkZWZpbmUgX19BTURHUFVfVU1DX0hf
XwogCi0vKiBpbXBsZW1lbnQgNjQgYml0cyBSRUcgb3BlcmF0aW9ucyB2aWEgMzIgYml0cyBpbnRl
cmZhY2UgKi8KLSNkZWZpbmUgUlJFRzY0X1VNQyhyZWcpCShSUkVHMzIocmVnKSB8IFwKLQkJCQko
KHVpbnQ2NF90KVJSRUczMigocmVnKSArIDEpIDw8IDMyKSkKLSNkZWZpbmUgV1JFRzY0X1VNQyhy
ZWcsIHYpCVwKLQlkbyB7CVwKLQkJV1JFRzMyKChyZWcpLCBsb3dlcl8zMl9iaXRzKHYpKTsJXAot
CQlXUkVHMzIoKHJlZykgKyAxLCB1cHBlcl8zMl9iaXRzKHYpKTsJXAotCX0gd2hpbGUgKDApCi0K
LS8qCi0gKiB2b2lkICgqZnVuYykoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBy
YXNfZXJyX2RhdGEgKmVycl9kYXRhLAotICoJCQkJdWludDMyX3QgdW1jX3JlZ19vZmZzZXQsIHVp
bnQzMl90IGNoYW5uZWxfaW5kZXgpCi0gKi8KLSNkZWZpbmUgYW1kZ3B1X3VtY19mb3JfZWFjaF9j
aGFubmVsKGZ1bmMpCVwKLQlzdHJ1Y3QgcmFzX2Vycl9kYXRhICplcnJfZGF0YSA9IChzdHJ1Y3Qg
cmFzX2Vycl9kYXRhICopcmFzX2Vycm9yX3N0YXR1czsJXAotCXVpbnQzMl90IHVtY19pbnN0LCBj
aGFubmVsX2luc3QsIHVtY19yZWdfb2Zmc2V0LCBjaGFubmVsX2luZGV4OwlcCi0JZm9yICh1bWNf
aW5zdCA9IDA7IHVtY19pbnN0IDwgYWRldi0+dW1jLnVtY19pbnN0X251bTsgdW1jX2luc3QrKykg
ewlcCi0JCS8qIGVuYWJsZSB0aGUgaW5kZXggbW9kZSB0byBxdWVyeSBlcm9yIGNvdW50IHBlciBj
aGFubmVsICovCVwKLQkJYWRldi0+dW1jLmZ1bmNzLT5lbmFibGVfdW1jX2luZGV4X21vZGUoYWRl
diwgdW1jX2luc3QpOwlcCi0JCWZvciAoY2hhbm5lbF9pbnN0ID0gMDsJXAotCQkJY2hhbm5lbF9p
bnN0IDwgYWRldi0+dW1jLmNoYW5uZWxfaW5zdF9udW07CVwKLQkJCWNoYW5uZWxfaW5zdCsrKSB7
CVwKLQkJCS8qIGNhbGMgdGhlIHJlZ2lzdGVyIG9mZnNldCBhY2NvcmRpbmcgdG8gY2hhbm5lbCBp
bnN0YW5jZSAqLwlcCi0JCQl1bWNfcmVnX29mZnNldCA9IGFkZXYtPnVtYy5jaGFubmVsX29mZnMg
KiBjaGFubmVsX2luc3Q7CVwKLQkJCS8qIGdldCBjaGFubmVsIGluZGV4IG9mIGludGVybGVhdmVk
IG1lbW9yeSAqLwlcCi0JCQljaGFubmVsX2luZGV4ID0gYWRldi0+dW1jLmNoYW5uZWxfaWR4X3Ri
bFsJXAotCQkJCXVtY19pbnN0ICogYWRldi0+dW1jLmNoYW5uZWxfaW5zdF9udW0gKyBjaGFubmVs
X2luc3RdOwlcCi0JCQkoZnVuYykoYWRldiwgZXJyX2RhdGEsIHVtY19yZWdfb2Zmc2V0LCBjaGFu
bmVsX2luZGV4KTsJXAotCQl9CVwKLQl9CVwKLQlhZGV2LT51bWMuZnVuY3MtPmRpc2FibGVfdW1j
X2luZGV4X21vZGUoYWRldik7Ci0KIHN0cnVjdCBhbWRncHVfdW1jX2Z1bmNzIHsKIAl2b2lkICgq
ZXJyX2NudF9pbml0KShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiAJaW50ICgqcmFzX2xh
dGVfaW5pdCkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwpAQCAtNjAsOSArMjgsNiBAQCBz
dHJ1Y3QgYW1kZ3B1X3VtY19mdW5jcyB7CiAJCQkJCXZvaWQgKnJhc19lcnJvcl9zdGF0dXMpOwog
CXZvaWQgKCpxdWVyeV9yYXNfZXJyb3JfYWRkcmVzcykoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCiAJCQkJCXZvaWQgKnJhc19lcnJvcl9zdGF0dXMpOwotCXZvaWQgKCplbmFibGVfdW1jX2lu
ZGV4X21vZGUpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAotCQkJCQl1aW50MzJfdCB1bWNf
aW5zdGFuY2UpOwotCXZvaWQgKCpkaXNhYmxlX3VtY19pbmRleF9tb2RlKShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldik7CiAJdm9pZCAoKmluaXRfcmVnaXN0ZXJzKShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldik7CiB9OwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS91bWNfdjZfMS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEuYwppbmRl
eCAyMzE3ODM5OTY2N2MuLjc0MGI3NmNlZTMxYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdW1jX3Y2XzEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91
bWNfdjZfMS5jCkBAIC0zMiw2ICszMiwxMCBAQAogCiAjZGVmaW5lIHNtbk1DQV9VTUMwX01DVU1D
X0FERFJUMAkweDUwZjEwCiAKKyNkZWZpbmUgVU1DXzZfSU5TVF9ESVNUCQkJMHg0MDAwMAorCisj
ZGVmaW5lIFVNQ19SRUdfT0ZGU0VUKGFkZXYsIGNoX2luc3QsIHVtY19pbnN0KSAoKGFkZXYpLT51
bWMuY2hhbm5lbF9vZmZzICogKGNoX2luc3QpICsgVU1DXzZfSU5TVF9ESVNUKih1bWNfaW5zdCkp
CisKIC8qCiAgKiAoYWRkciAvIDI1NikgKiA4MTkyLCB0aGUgaGlnaGVyIDI2IGJpdHMgaW4gRXJy
b3JBZGRyCiAgKiBpcyB0aGUgaW5kZXggb2YgOEtCIGJsb2NrCkBAIC01MCw0MSArNTQsMTEgQEAg
Y29uc3QgdWludDMyX3QKIAkJezksIDI1LCAwLCAxNn0sCQl7MTUsIDMxLCA2LCAyMn0KIH07CiAK
LXN0YXRpYyB2b2lkIHVtY192Nl8xX2VuYWJsZV91bWNfaW5kZXhfbW9kZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKLQkJCQkJICAgdWludDMyX3QgdW1jX2luc3RhbmNlKQotewotCXVpbnQz
Ml90IHJzbXVfdW1jX2luZGV4OwotCi0JcnNtdV91bWNfaW5kZXggPSBSUkVHMzJfU09DMTUoUlNN
VSwgMCwKLQkJCW1tUlNNVV9VTUNfSU5ERVhfUkVHSVNURVJfTkJJRl9WRzIwX0dQVSk7Ci0JcnNt
dV91bWNfaW5kZXggPSBSRUdfU0VUX0ZJRUxEKHJzbXVfdW1jX2luZGV4LAotCQkJUlNNVV9VTUNf
SU5ERVhfUkVHSVNURVJfTkJJRl9WRzIwX0dQVSwKLQkJCVJTTVVfVU1DX0lOREVYX01PREVfRU4s
IDEpOwotCXJzbXVfdW1jX2luZGV4ID0gUkVHX1NFVF9GSUVMRChyc211X3VtY19pbmRleCwKLQkJ
CVJTTVVfVU1DX0lOREVYX1JFR0lTVEVSX05CSUZfVkcyMF9HUFUsCi0JCQlSU01VX1VNQ19JTkRF
WF9JTlNUQU5DRSwgdW1jX2luc3RhbmNlKTsKLQlyc211X3VtY19pbmRleCA9IFJFR19TRVRfRklF
TEQocnNtdV91bWNfaW5kZXgsCi0JCQlSU01VX1VNQ19JTkRFWF9SRUdJU1RFUl9OQklGX1ZHMjBf
R1BVLAotCQkJUlNNVV9VTUNfSU5ERVhfV1JFTiwgMSA8PCB1bWNfaW5zdGFuY2UpOwotCVdSRUcz
Ml9TT0MxNShSU01VLCAwLCBtbVJTTVVfVU1DX0lOREVYX1JFR0lTVEVSX05CSUZfVkcyMF9HUFUs
Ci0JCQkJcnNtdV91bWNfaW5kZXgpOwotfQotCi1zdGF0aWMgdm9pZCB1bWNfdjZfMV9kaXNhYmxl
X3VtY19pbmRleF9tb2RlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQordWludDMyX3QgZ2V0
X3VtY19yZWdfb2Zmc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAorCQkJICAgIHVpbnQz
Ml90IHVtY19pbnN0LAorCQkJICAgIHVpbnQzMl90IGNoX2luc3QpCiB7Ci0JV1JFRzMyX0ZJRUxE
MTUoUlNNVSwgMCwgUlNNVV9VTUNfSU5ERVhfUkVHSVNURVJfTkJJRl9WRzIwX0dQVSwKLQkJCVJT
TVVfVU1DX0lOREVYX01PREVfRU4sIDApOwotfQotCi1zdGF0aWMgdWludDMyX3QgdW1jX3Y2XzFf
Z2V0X3VtY19pbnN0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQotewotCXVpbnQzMl90IHJz
bXVfdW1jX2luZGV4OwotCi0JcnNtdV91bWNfaW5kZXggPSBSUkVHMzJfU09DMTUoUlNNVSwgMCwK
LQkJCQltbVJTTVVfVU1DX0lOREVYX1JFR0lTVEVSX05CSUZfVkcyMF9HUFUpOwotCXJldHVybiBS
RUdfR0VUX0ZJRUxEKHJzbXVfdW1jX2luZGV4LAotCQkJCVJTTVVfVU1DX0lOREVYX1JFR0lTVEVS
X05CSUZfVkcyMF9HUFUsCi0JCQkJUlNNVV9VTUNfSU5ERVhfSU5TVEFOQ0UpOworCXJldHVybiBh
ZGV2LT51bWMuY2hhbm5lbF9vZmZzICogY2hfaW5zdCArIFVNQ182X0lOU1RfRElTVCp1bWNfaW5z
dDsKIH0KIAogc3RhdGljIHZvaWQgdW1jX3Y2XzFfcXVlcnlfY29ycmVjdGFibGVfZXJyb3JfY291
bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCkBAIC0xNzQsMjUgKzE0OCwzOCBAQCBzdGF0
aWMgdm9pZCB1bWNfdjZfMV9xdWVycnlfdW5jb3JyZWN0YWJsZV9lcnJvcl9jb3VudChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldgogCQkqZXJyb3JfY291bnQgKz0gMTsKIH0KIAotc3RhdGljIHZv
aWQgdW1jX3Y2XzFfcXVlcnlfZXJyb3JfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
Ci0JCQkJCSAgIHN0cnVjdCByYXNfZXJyX2RhdGEgKmVycl9kYXRhLCB1aW50MzJfdCB1bWNfcmVn
X29mZnNldCwKLQkJCQkJICAgdWludDMyX3QgY2hhbm5lbF9pbmRleCkKLXsKLQl1bWNfdjZfMV9x
dWVyeV9jb3JyZWN0YWJsZV9lcnJvcl9jb3VudChhZGV2LCB1bWNfcmVnX29mZnNldCwKLQkJCQkJ
CSAgICYoZXJyX2RhdGEtPmNlX2NvdW50KSk7Ci0JdW1jX3Y2XzFfcXVlcnJ5X3VuY29ycmVjdGFi
bGVfZXJyb3JfY291bnQoYWRldiwgdW1jX3JlZ19vZmZzZXQsCi0JCQkJCQkgICYoZXJyX2RhdGEt
PnVlX2NvdW50KSk7Ci19Ci0KIHN0YXRpYyB2b2lkIHVtY192Nl8xX3F1ZXJ5X3Jhc19lcnJvcl9j
b3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQkJICAgdm9pZCAqcmFzX2Vycm9y
X3N0YXR1cykKIHsKLQlhbWRncHVfdW1jX2Zvcl9lYWNoX2NoYW5uZWwodW1jX3Y2XzFfcXVlcnlf
ZXJyb3JfY291bnQpOworCXN0cnVjdCByYXNfZXJyX2RhdGEqIGVycl9kYXRhID0gKHN0cnVjdCBy
YXNfZXJyX2RhdGEqKXJhc19lcnJvcl9zdGF0dXM7CisKKwl1aW50MzJfdCB1bWNfaW5zdCAgICAg
ICAgPSAwOworCXVpbnQzMl90IGNoX2luc3QgICAgICAgICA9IDA7CisJdWludDMyX3QgdW1jX3Jl
Z19vZmZzZXQgID0gMDsKKworCWZvciAodW1jX2luc3QgPSAwOyB1bWNfaW5zdCA8IGFkZXYtPnVt
Yy51bWNfaW5zdF9udW07IHVtY19pbnN0KyspCisJeworCQlmb3IgKGNoX2luc3QgPSAwOyBjaF9p
bnN0IDwgYWRldi0+dW1jLmNoYW5uZWxfaW5zdF9udW07IGNoX2luc3QrKykKKwkJeworCQkJdW1j
X3JlZ19vZmZzZXQgPSBnZXRfdW1jX3JlZ19vZmZzZXQoYWRldiwKKwkJCQkJCQkgICAgdW1jX2lu
c3QsCisJCQkJCQkJICAgIGNoX2luc3QpOworCisJCQl1bWNfdjZfMV9xdWVyeV9jb3JyZWN0YWJs
ZV9lcnJvcl9jb3VudChhZGV2LAorCQkJCQkJCSAgICAgICB1bWNfcmVnX29mZnNldCwKKwkJCQkJ
CQkgICAgICAgJihlcnJfZGF0YS0+Y2VfY291bnQpKTsKKwkJCXVtY192Nl8xX3F1ZXJyeV91bmNv
cnJlY3RhYmxlX2Vycm9yX2NvdW50KGFkZXYsCisJCQkJCQkJCSAgdW1jX3JlZ19vZmZzZXQsCisJ
CQkJCQkJCSAgJihlcnJfZGF0YS0+dWVfY291bnQpKTsKKwkJfQorCX0KIH0KIAogc3RhdGljIHZv
aWQgdW1jX3Y2XzFfcXVlcnlfZXJyb3JfYWRkcmVzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKIAkJCQkJIHN0cnVjdCByYXNfZXJyX2RhdGEgKmVycl9kYXRhLAotCQkJCQkgdWludDMyX3Qg
dW1jX3JlZ19vZmZzZXQsIHVpbnQzMl90IGNoYW5uZWxfaW5kZXgpCisJCQkJCSB1aW50MzJfdCB1
bWNfcmVnX29mZnNldCwKKwkJCQkJIHVpbnQzMl90IGNoYW5uZWxfaW5kZXgsCisJCQkJCSB1aW50
MzJfdCB1bWNfaW5zdCkKIHsKIAl1aW50MzJfdCBsc2IsIG1jX3VtY19zdGF0dXNfYWRkcjsKIAl1
aW50NjRfdCBtY191bWNfc3RhdHVzLCBlcnJfYWRkciwgcmV0aXJlZF9wYWdlOwpAQCAtMjQ0LDcg
KzIzMSw3IEBAIHN0YXRpYyB2b2lkIHVtY192Nl8xX3F1ZXJ5X2Vycm9yX2FkZHJlc3Moc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQllcnJfcmVjLT5lcnJfdHlwZSA9IEFNREdQVV9SQVNf
RUVQUk9NX0VSUl9OT05fUkVDT1ZFUkFCTEU7CiAJCQllcnJfcmVjLT5jdSA9IDA7CiAJCQllcnJf
cmVjLT5tZW1fY2hhbm5lbCA9IGNoYW5uZWxfaW5kZXg7Ci0JCQllcnJfcmVjLT5tY3VtY19pZCA9
IHVtY192Nl8xX2dldF91bWNfaW5zdChhZGV2KTsKKwkJCWVycl9yZWMtPm1jdW1jX2lkID0gdW1j
X2luc3Q7CiAKIAkJCWVycl9kYXRhLT5lcnJfYWRkcl9jbnQrKzsKIAkJfQpAQCAtMjU3LDEyICsy
NDQsMzIgQEAgc3RhdGljIHZvaWQgdW1jX3Y2XzFfcXVlcnlfZXJyb3JfYWRkcmVzcyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKIHN0YXRpYyB2b2lkIHVtY192Nl8xX3F1ZXJ5X3Jhc19lcnJv
cl9hZGRyZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJCQkgICAgIHZvaWQgKnJh
c19lcnJvcl9zdGF0dXMpCiB7Ci0JYW1kZ3B1X3VtY19mb3JfZWFjaF9jaGFubmVsKHVtY192Nl8x
X3F1ZXJ5X2Vycm9yX2FkZHJlc3MpOworCXN0cnVjdCByYXNfZXJyX2RhdGEqIGVycl9kYXRhID0g
KHN0cnVjdCByYXNfZXJyX2RhdGEqKXJhc19lcnJvcl9zdGF0dXM7CisKKwl1aW50MzJfdCB1bWNf
aW5zdCAgICAgICAgPSAwOworCXVpbnQzMl90IGNoX2luc3QgICAgICAgICA9IDA7CisJdWludDMy
X3QgdW1jX3JlZ19vZmZzZXQgID0gMDsKKworCWZvciAodW1jX2luc3QgPSAwOyB1bWNfaW5zdCA8
IGFkZXYtPnVtYy51bWNfaW5zdF9udW07IHVtY19pbnN0KyspCisJeworCQlmb3IgKGNoX2luc3Qg
PSAwOyBjaF9pbnN0IDwgYWRldi0+dW1jLmNoYW5uZWxfaW5zdF9udW07IGNoX2luc3QrKykKKwkJ
eworCQkJdW1jX3JlZ19vZmZzZXQgPSBnZXRfdW1jX3JlZ19vZmZzZXQoYWRldiwKKwkJCQkJCQkg
ICAgdW1jX2luc3QsCisJCQkJCQkJICAgIGNoX2luc3QpOworCisJCQl1bWNfdjZfMV9xdWVyeV9l
cnJvcl9hZGRyZXNzKGFkZXYsCisJCQkJCQkgICAgIGVycl9kYXRhLAorCQkJCQkJICAgICB1bWNf
cmVnX29mZnNldCwKKwkJCQkJCSAgICAgY2hfaW5zdCwKKwkJCQkJCSAgICAgdW1jX2luc3QpOwor
CQl9CisJfQorCiB9CiAKIHN0YXRpYyB2b2lkIHVtY192Nl8xX2Vycl9jbnRfaW5pdF9wZXJfY2hh
bm5lbChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKLQkJCQkJIHN0cnVjdCByYXNfZXJyX2Rh
dGEgKmVycl9kYXRhLAotCQkJCQkgdWludDMyX3QgdW1jX3JlZ19vZmZzZXQsIHVpbnQzMl90IGNo
YW5uZWxfaW5kZXgpCisJCQkJCSAgICAgIHVpbnQzMl90IHVtY19yZWdfb2Zmc2V0KQogewogCXVp
bnQzMl90IGVjY19lcnJfY250X3NlbCwgZWNjX2Vycl9jbnRfc2VsX2FkZHI7CiAJdWludDMyX3Qg
ZWNjX2Vycl9jbnRfYWRkcjsKQEAgLTMwMSw5ICszMDgsMjEgQEAgc3RhdGljIHZvaWQgdW1jX3Y2
XzFfZXJyX2NudF9pbml0X3Blcl9jaGFubmVsKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAog
CiBzdGF0aWMgdm9pZCB1bWNfdjZfMV9lcnJfY250X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCiB7Ci0Jdm9pZCAqcmFzX2Vycm9yX3N0YXR1cyA9IE5VTEw7Ci0KLQlhbWRncHVfdW1j
X2Zvcl9lYWNoX2NoYW5uZWwodW1jX3Y2XzFfZXJyX2NudF9pbml0X3Blcl9jaGFubmVsKTsKKwl1
aW50MzJfdCB1bWNfaW5zdCAgICAgICAgPSAwOworCXVpbnQzMl90IGNoX2luc3QgICAgICAgICA9
IDA7CisJdWludDMyX3QgdW1jX3JlZ19vZmZzZXQgID0gMDsKKworCWZvciAodW1jX2luc3QgPSAw
OyB1bWNfaW5zdCA8IGFkZXYtPnVtYy51bWNfaW5zdF9udW07IHVtY19pbnN0KyspCisJeworCQlm
b3IgKGNoX2luc3QgPSAwOyBjaF9pbnN0IDwgYWRldi0+dW1jLmNoYW5uZWxfaW5zdF9udW07IGNo
X2luc3QrKykKKwkJeworCQkJdW1jX3JlZ19vZmZzZXQgPSBnZXRfdW1jX3JlZ19vZmZzZXQoYWRl
diwKKwkJCQkJCQkgICAgdW1jX2luc3QsCisJCQkJCQkJICAgIGNoX2luc3QpOworCisJCQl1bWNf
djZfMV9lcnJfY250X2luaXRfcGVyX2NoYW5uZWwoYWRldiwgdW1jX3JlZ19vZmZzZXQpOworCQl9
CisJfQogfQogCiBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3VtY19mdW5jcyB1bWNfdjZfMV9mdW5jcyA9
IHsKQEAgLTMxMSw2ICszMzAsNCBAQCBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3VtY19mdW5jcyB1bWNf
djZfMV9mdW5jcyA9IHsKIAkucmFzX2xhdGVfaW5pdCA9IGFtZGdwdV91bWNfcmFzX2xhdGVfaW5p
dCwKIAkucXVlcnlfcmFzX2Vycm9yX2NvdW50ID0gdW1jX3Y2XzFfcXVlcnlfcmFzX2Vycm9yX2Nv
dW50LAogCS5xdWVyeV9yYXNfZXJyb3JfYWRkcmVzcyA9IHVtY192Nl8xX3F1ZXJ5X3Jhc19lcnJv
cl9hZGRyZXNzLAotCS5lbmFibGVfdW1jX2luZGV4X21vZGUgPSB1bWNfdjZfMV9lbmFibGVfdW1j
X2luZGV4X21vZGUsCi0JLmRpc2FibGVfdW1jX2luZGV4X21vZGUgPSB1bWNfdjZfMV9kaXNhYmxl
X3VtY19pbmRleF9tb2RlLAogfTsKLS0gCjIuMTcuMQoK

--_004_MN2PR12MB3663CB891846CB098EED1354FB200MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB3663CB891846CB098EED1354FB200MN2PR12MB3663namp_--
