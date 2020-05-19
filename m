Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1197C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 09:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9955C20756
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 09:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u7fTHHhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9955C20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440D688344;
	Tue, 19 May 2020 09:14:38 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680057.outbound.protection.outlook.com [40.107.68.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2700988344
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 09:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvZRWHF5oTsQgZNnu2pfhThKMec6Q/0cUizs+iagUuJs3+82nwhjW32oBtHepXzftlBURQWDK8WTWt0jB1avOo7b+1ccBO/eV7Cen34Wn9In6QRFZQuaGbylNZKYBnNcVEK6tT8MNpIy8ajPlw5fCy3pT3HVN6ssIR81mSrZZWE9cNFKea8rvi1o2kLwB5MdtZYC2ZUauOIxQNpsbNoe7lfTzOra84E2QJGbCwhAIQ4/Mf51uwBLL2nkx0Tuaa+nJC/F68gTWE1bQkjAOpKugBvUV9RmtotBCtP2RClsCp1K2Qxpi+aAJNh6mV0Ulox1psGLhmLZf7ba/gDYT8VxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l828c275uya0QbUZ/1ZYgUwwl3ANKq8pAElz09tU4qs=;
 b=VyGuesIOy8Mec6wkLenUPGNvtY+oBHDxhVutnZDJZ1rFWdxU3tjuBDUToIY65mX3yKD8wlhEQd5ITaUfMSEJiIiFzE/MGJvCNFPlawiJjsG6VrVqcFtiLi4mbzhLojbRPRg833ng8QrBpHBL5ebKncjb2wVFhvABYNd1NwnC2S3jeA1pdDF7qlH8icW9yH8TtiYLs0ZQplgZ3T6No1FLYZ5MKeMI8jkdrCHWDEkx/qS0psR4ja7rPjKoMDBDCmkTUNyfJxKKfp9OgHSVJeGo62yOBT9efSmyF8lTVJxRQg+2M6yl/eOOsUfV6Qs8VxHeBEGoo+uur+AH3e6rrnlYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l828c275uya0QbUZ/1ZYgUwwl3ANKq8pAElz09tU4qs=;
 b=u7fTHHhGRuqVAWLyPyt5TkeoEsjdbZPjCVMxeYzjzZuBZaiZ+DDkQVo6Jc5YkRPeUtBgKY49rL6R2IBrYILHxJ4n5F5fE1HmmyxUHkJhBJ1jLYs1ErgqEaGKtq57O+dsX3W1qcpzBeG9BreEav5rP9OKeayOX0q9LO7VPWjyyOw=
Received: from DM6PR12MB4026.namprd12.prod.outlook.com (2603:10b6:5:1cc::33)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Tue, 19 May
 2020 09:14:35 +0000
Received: from DM6PR12MB4026.namprd12.prod.outlook.com
 ([fe80::a140:65c9:d28c:101a]) by DM6PR12MB4026.namprd12.prod.outlook.com
 ([fe80::a140:65c9:d28c:101a%7]) with mapi id 15.20.3000.022; Tue, 19 May 2020
 09:14:35 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition
Thread-Topic: [PATCH] drm/amdgpu: resolve ras recovery vs smi race condition
Thread-Index: AdYtvciAHbipIGpZT6qk0o/TamXupg==
Date: Tue, 19 May 2020 09:14:34 +0000
Message-ID: <DM6PR12MB4026718C8DD47807F9856F3FFBB90@DM6PR12MB4026.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-19T09:14:31Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6334e757-9313-4c47-aeb1-00001eb443f7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-19T09:14:31Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 483f6562-bf9a-45a7-8765-0000e644d04f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65eb8d78-30cc-4a54-f166-08d7fbd50c74
x-ms-traffictypediagnostic: DM6PR12MB4057:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB405728D19D7513588D8F4111FBB90@DM6PR12MB4057.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qe5KOErG1uNzx6+OAfZZ7o2+Ulf1i+Y/JEq3PanCQQ+WqCrDakcGIGyzmw5IpPscWaNp5hQG+yndoQDzNLqdWwnegwqcVvswO3lxJppBhepr/rMqvmxQRyWNvnDlJ8n39mhH+Bg1C4c0mFwsgyJ5mDxaUDLgeLPnPk22jVFU1Z2XTYmG0ssEfvOc0BM7oaitEnKDqXOMgYdnIhRFi6tZDVtDllXGN4pqeeWy8ygD2KiwingcVc7rbf0zJPTa5HwJ3ZbmfXDRx6lQkRVf/Bly7tsliM2xzd8/36N/dB5EEJMpK4rF93u2Pt4/2Mg3+wmA3X7ycsmqgj/e77Xv3LXrCRuxIJWn7MBvuBw9JkQVkr4McNsL0n1u7uwDn36a06jvISgssi6V6JLkTr2ol158yAdqz/kQKe/lDAwblVEDWt9Jns223bkCg0+M0oqIuYLN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4026.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(8676002)(64756008)(66446008)(66476007)(8936002)(66946007)(66616009)(86362001)(52536014)(66556008)(316002)(186003)(110136005)(26005)(478600001)(9686003)(2906002)(71200400001)(76116006)(558084003)(33656002)(55016002)(6636002)(6506007)(7696005)(5660300002)(99936003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: vvoyd856AhjQs5V52AzgHuVKIYe3xHtzJuLyoN9diRzIamMqdCvbSY2rLFr/NCJ32m9MDv/e3jz79BbZCsJmE9rxl8sxtf9MOgHGTA9a2GNmUxST7srQ+sEcbf9i5gqJlJo3fQJhZALkKSkSpUC9LVGnRUjfM36czsfyPv/jMZuNCw65vGapFWGWHLf6YhNGXOZ/EuJOURnMslIAhWtOoC+z7V7bBSXsG3nVUfmCaEYQ0s+QyTujqveOs9nPP4jEsLCtb8jCBpHZbr4Ggdw1DY/pOmUws9shgUZeF09rXKhUU7QE3VMUFpCJl4iKlgKR78scCE4aObq+5V9Fg1aG8wqzxedV1W3Zjt3hvD1Njgcyto+eZ61yqH2jrioNNB8FNzA8i4H69VKgPZTcZHGjo9C4KsJT9WytHQivWDBA2S7lStAs1W2NwsfD3bBs7235k+HWTJ3wSnhT+U3CnqkH5R/8adB2SAVxFrSBqICLvdBiehTuFm96pbpEkTVm73Yf
Content-Type: multipart/mixed;
 boundary="_004_DM6PR12MB4026718C8DD47807F9856F3FFBB90DM6PR12MB4026namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65eb8d78-30cc-4a54-f166-08d7fbd50c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 09:14:35.0521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWHW2KaYpJ8ctDQgA1OpIgfUWfdeZbmxeG0CHK7IhoyX/ystxcA5gnK/qR++07loHbuEMry1SLkpK1Xf2ODuiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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

--_004_DM6PR12MB4026718C8DD47807F9856F3FFBB90DM6PR12MB4026namp_
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4026718C8DD47807F9856F3FFBB90DM6PR12MB4026namp_"

--_000_DM6PR12MB4026718C8DD47807F9856F3FFBB90DM6PR12MB4026namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to block SMU access' via SMI during RAS recovery

--_000_DM6PR12MB4026718C8DD47807F9856F3FFBB90DM6PR12MB4026namp_
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
<p class=3D"msipheadera92e061b" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to block SMU access&#8217; via SMI =
during RAS recovery<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4026718C8DD47807F9856F3FFBB90DM6PR12MB4026namp_--

--_004_DM6PR12MB4026718C8DD47807F9856F3FFBB90DM6PR12MB4026namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-resolve-ras-recovery-vs-smi-race-conditio.patch"
Content-Description:  0001-drm-amdgpu-resolve-ras-recovery-vs-smi-race-conditio.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-resolve-ras-recovery-vs-smi-race-conditio.patch";
	size=3724; creation-date="Tue, 19 May 2020 09:12:52 GMT";
	modification-date="Tue, 19 May 2020 09:13:03 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5YzVlZTM0OWMzMThlNGQxYjE0MmY4YzFmZDRkNDAwM2VmMmI2YTc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMTkgTWF5IDIwMjAgMTc6MTE6NTQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiByZXNvbHZlIHJhcyByZWNvdmVyeSB2cyBzbWkgcmFjZSBjb25kaXRpb24KCmR1
cmluZyByYXMgcmVjb3ZlcnkgYmxvY2sgc211IGFjY2VzcyB2aWEgc21pCgpTaWduZWQtb2ZmLWJ5
OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSWEyODAw
NTU3MzdmM2FkZGE1MGU0YTRhMTU0MzVhZTAwZTNmMDcxNzMKLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcG0uYyAgICAgICB8IDE2ICsrKysrKysrKysrKysrKysKIGRyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyAgIHwgIDQgKysrKwogZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgfCAgMyArKysKIDMgZmlsZXMg
Y2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3BtLmMKaW5kZXggYjc1MzYyYmYwNzQyLi5mMGZiNTdkNzNhN2YgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wbS5jCkBAIC0zMSw2ICszMSw3IEBACiAjaW5jbHVkZSAiYW1kZ3B1
X2RwbS5oIgogI2luY2x1ZGUgImFtZGdwdV9kaXNwbGF5LmgiCiAjaW5jbHVkZSAiYW1kZ3B1X3Nt
dS5oIgorI2luY2x1ZGUgImFtZGdwdV9yYXMuaCIKICNpbmNsdWRlICJhdG9tLmgiCiAjaW5jbHVk
ZSA8bGludXgvcG93ZXJfc3VwcGx5Lmg+CiAjaW5jbHVkZSA8bGludXgvcGNpLmg+CkBAIC0xMDQs
NiArMTA1LDkgQEAgaW50IGFtZGdwdV9kcG1fcmVhZF9zZW5zb3Ioc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIGVudW0gYW1kX3BwX3NlbnNvcnMgc2Vuc28KIHsKIAlpbnQgcmV0ID0gMDsKIAor
CWlmIChhbWRncHVfcmFzX2ludHJfdHJpZ2dlcmVkKCkpCisJCXJldHVybiAwOworCiAJaWYgKCFk
YXRhIHx8ICFzaXplKQogCQlyZXR1cm4gLUVJTlZBTDsKIApAQCAtMzA2LDYgKzMxMCw5IEBAIHN0
YXRpYyBzc2l6ZV90IGFtZGdwdV9nZXRfcG93ZXJfZHBtX2ZvcmNlX3BlcmZvcm1hbmNlX2xldmVs
KHN0cnVjdCBkZXZpY2UgKmRldiwKIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpICYmICFhbWRn
cHVfc3Jpb3ZfaXNfcHBfb25lX3ZmKGFkZXYpKQogCQlyZXR1cm4gMDsKIAorCWlmIChhbWRncHVf
cmFzX2ludHJfdHJpZ2dlcmVkKCkpCisJCXJldHVybiBzbnByaW50ZihidWYsIFBBR0VfU0laRSwg
InVuYXZhaWxhYmxlXG4iKTsKKwogCXJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGRldi0+ZGV2
KTsKIAlpZiAocmV0IDwgMCkKIAkJcmV0dXJuIHJldDsKQEAgLTM0Myw2ICszNTAsOSBAQCBzdGF0
aWMgc3NpemVfdCBhbWRncHVfc2V0X3Bvd2VyX2RwbV9mb3JjZV9wZXJmb3JtYW5jZV9sZXZlbChz
dHJ1Y3QgZGV2aWNlICpkZXYsCiAJZW51bSBhbWRfZHBtX2ZvcmNlZF9sZXZlbCBjdXJyZW50X2xl
dmVsID0gMHhmZjsKIAlpbnQgcmV0ID0gMDsKIAorCWlmIChhbWRncHVfcmFzX2ludHJfdHJpZ2dl
cmVkKCkpCisJCXJldHVybiAwOworCiAJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiAhYW1k
Z3B1X3NyaW92X2lzX3BwX29uZV92ZihhZGV2KSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKQEAgLTE2
NzQsNiArMTY4NCw5IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9nZXRfZ3B1X2J1c3lfcGVyY2Vu
dChzdHJ1Y3QgZGV2aWNlICpkZXYsCiAJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiAhYW1k
Z3B1X3NyaW92X2lzX3BwX29uZV92ZihhZGV2KSkKIAkJcmV0dXJuIDA7CiAKKwlpZiAoYW1kZ3B1
X3Jhc19pbnRyX3RyaWdnZXJlZCgpKQorCQlyZXR1cm4gc25wcmludGYoYnVmLCBQQUdFX1NJWkUs
ICJ1bmF2YWlsYWJsZVxuIik7CisKIAlyID0gcG1fcnVudGltZV9nZXRfc3luYyhkZGV2LT5kZXYp
OwogCWlmIChyIDwgMCkKIAkJcmV0dXJuIHI7CkBAIC0xOTY3LDYgKzE5ODAsOSBAQCBzdGF0aWMg
c3NpemVfdCBhbWRncHVfaHdtb25fc2hvd190ZW1wKHN0cnVjdCBkZXZpY2UgKmRldiwKIAlpbnQg
Y2hhbm5lbCA9IHRvX3NlbnNvcl9kZXZfYXR0cihhdHRyKS0+aW5kZXg7CiAJaW50IHIsIHRlbXAg
PSAwLCBzaXplID0gc2l6ZW9mKHRlbXApOwogCisJaWYgKGFtZGdwdV9yYXNfaW50cl90cmlnZ2Vy
ZWQoKSkKKwkJcmV0dXJuIHNucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAidW5hdmFpbGFibGVcbiIp
OworCiAJaWYgKGNoYW5uZWwgPj0gUFBfVEVNUF9NQVgpCiAJCXJldHVybiAtRUlOVkFMOwogCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKaW5kZXggOGM2ODRhNmUw
MTU2Li4xNWQyOTVhODNkMmEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2FtZGdwdV9zbXUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRn
cHVfc211LmMKQEAgLTI1LDYgKzI1LDcgQEAKIAogI2luY2x1ZGUgImFtZGdwdS5oIgogI2luY2x1
ZGUgImFtZGdwdV9zbXUuaCIKKyNpbmNsdWRlICJhbWRncHVfcmFzLmgiCiAjaW5jbHVkZSAic211
X2ludGVybmFsLmgiCiAjaW5jbHVkZSAic211X3YxMV8wLmgiCiAjaW5jbHVkZSAic211X3YxMl8w
LmgiCkBAIC0yNDIxLDYgKzI0MjIsOSBAQCBpbnQgc211X3JlYWRfc2Vuc29yKHN0cnVjdCBzbXVf
Y29udGV4dCAqc211LAogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gc211LT5hZGV2Owog
CWludCByZXQgPSAwOwogCisJaWYgKGFtZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQoKSkKKwkJcmV0
dXJuIDA7CisKIAlpZiAoIWFkZXYtPnBtLmRwbV9lbmFibGVkKQogCQlyZXR1cm4gLUVJTlZBTDsK
IApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYwppbmRleCBj
YmY3MDEyMmRlOWIuLmZhMzAzYjFjOTIxYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvYXJjdHVydXNfcHB0LmMKQEAgLTYyMyw2ICs2MjMsOSBAQCBzdGF0aWMgaW50IGFyY3R1
cnVzX3ByaW50X2Nsa19sZXZlbHMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAJc3RydWN0IHNt
dV9kcG1fY29udGV4dCAqc211X2RwbSA9ICZzbXUtPnNtdV9kcG07CiAJc3RydWN0IGFyY3R1cnVz
X2RwbV90YWJsZSAqZHBtX3RhYmxlID0gTlVMTDsKIAorCWlmIChhbWRncHVfcmFzX2ludHJfdHJp
Z2dlcmVkKCkpCisJCXJldHVybiBzbnByaW50ZihidWYsIFBBR0VfU0laRSwgInVuYXZhaWxhYmxl
XG4iKTsKKwogCWRwbV90YWJsZSA9IHNtdV9kcG0tPmRwbV9jb250ZXh0OwogCiAJc3dpdGNoICh0
eXBlKSB7Ci0tIAoyLjE3LjEKCg==

--_004_DM6PR12MB4026718C8DD47807F9856F3FFBB90DM6PR12MB4026namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_DM6PR12MB4026718C8DD47807F9856F3FFBB90DM6PR12MB4026namp_--
