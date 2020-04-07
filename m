Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B39C2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFCD820719
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ca8QrkOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCD820719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C88289F85;
	Tue,  7 Apr 2020 08:51:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E681A89F85
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 08:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHrRMSnFtfVG6KOERW9lETyT15uCyHeZg/V1SmGIjfYYM41F4Ky4Or91+lv+AknnLTNtrbmg1j6i9fZ9qBnfMdQROtIQUmaVLnQivX37JxRAxFQTRtk2bYiByZK66+ES9GU5nZDaDrhtOxAlz6MMONBce+f0u6nPGO8QgUxF0j7Alk/LRXHHoLRdlS8nhPUpmJxsOVhBCFJzvg/mzVPSj6n16riDHYtFHWXb6rnq3SKaWGnJ2U1hBOWJNm1h2z06o33RCqs3TPQ3Z/bx8R/xnXFQKIQBaZRAB/5FevxxarC4BujjsD2Ny4iLqsQDmFTDOKr+JvP6DQbpaomqRT8Ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjbas9Co2IwvA5oEdh1mhuAfTdFqWNB+gcIFGdE+uAc=;
 b=D3vuzK54S/hlwmkA+UOWsrpM4IuuME+yUpPvnvdbIbpUBJUW1JLmu+kuBXeXmPhRJ+Y0NdAo3gXk1BRD1ZEEeE9ue6I7QFogpfTsINN67eYkANdIB76qwcX+RI8snCi3nQv1WR8mgdoNHHNj4RVuxHFUBjtiziVU6rKLGWkljJK6ZOq5rItVX8DenOK0I7d9YiiSzMcr6HnzEOajpSBN5+38XlxFG2XbsUcnCHutHBbvoy+Rm0Ds/jiQ+oygwImHRRZ6/pPN+m+dt9gdx3nUeK//JwXLKA7qQjaoRcrmEzomgIPBjIc0PNU1ZHJm4ROsveAoZxv9U+z5vtLBEPi59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjbas9Co2IwvA5oEdh1mhuAfTdFqWNB+gcIFGdE+uAc=;
 b=ca8QrkOlyyVvNSDaGJBmSB09jKf8f1O/lIVzBTgdU/bp3GAbniuNOKXbywKUWI14+qEIExhQmmo3ZM6tAkDlKpkgmYzozNwwXo/7J0q7vp9L4nEKDWetI0PMD4sorewEN3ttnS1udWHycvl1xN1AVB2Elf/jHllYicu45kjDD8k=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 08:51:31 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265%3]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 08:51:31 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update RAS related dmesg print
Thread-Topic: [PATCH] drm/amdgpu: update RAS related dmesg print
Thread-Index: AdYMuafLUHtddyJrR5mE/6mAO3dliA==
Date: Tue, 7 Apr 2020 08:51:30 +0000
Message-ID: <MN2PR12MB403219C47CEC909255949B54FBC30@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-07T08:51:28Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=72aa146f-2cf1-460b-a043-0000e76b65a9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-07T08:51:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 1f07dfbc-c982-482b-998d-00004c175093
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7cd040ce-fb32-41a6-7a29-08d7dad0de39
x-ms-traffictypediagnostic: MN2PR12MB3997:|MN2PR12MB3997:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39976099DFB0D1E6330B980AFBC30@MN2PR12MB3997.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:107;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(5660300002)(8936002)(81166006)(558084003)(110136005)(316002)(81156014)(52536014)(8676002)(6636002)(76116006)(66446008)(66946007)(6506007)(64756008)(86362001)(66556008)(66476007)(7696005)(66616009)(71200400001)(186003)(55016002)(478600001)(26005)(9686003)(99936003)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZr2V16pbpeq0zlUMnUO5KLnYqNZLR/rL+kMd6jgAuCh+Fq05Kik+eeDXNj/IEpbHJdk2FyEC6SlRLwSWEYdgRAbQf7PfeYF45waMDrL+qRIGSu/U3dCup5NkMkGhbxd1xTDWVfW2yL+zPXjVEN7dMwb2TkyyCL3LdJFS15qWumFpq46/uOLHKX9IxcKhd3iCdITBsX5RIKDboD6aIyaBPtRnk2BMwM4cmkttXynB9YTEemop6Pr/JEV7t8tpEzyJRtd6fOuwFwx1W0rsNlByyeTazO/fZF1X8irfix7Tl/y13m43Jrwk4x6V0t8tSdI3MNlH0PCZlII53sb1YsDeyVr+5nA4gXLJXjPyBfh6yJX82Xtq3/yVrIt+0UgmbWFrAVJBWavXbPT1VZVxbof1ZvHPiQjXdF5c0J7lYNx9Rcx/nQWiKodTIEQnDc6gw3/
x-ms-exchange-antispam-messagedata: MSBsvMAbA7E9ic+1hi3/y5Pp5k36I+oHrLlkNxSwVDXrtOITcV+Eq7l92fmJXcuPmog6NzhdOLWMQaBbxpwaPvYMOoNsz6lI4q5H6QRMFlVvYrtRP92mPcdqG3tPSfd719pLCGFAjJxNIeVWV81OpA==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB403219C47CEC909255949B54FBC30MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd040ce-fb32-41a6-7a29-08d7dad0de39
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 08:51:31.0397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHozMMpIOzYLA9nRlXIrY+e7CwSNwQvlgFVRyUB12QZpBBnqYa5nVFQ2VU16RwBKIMyyoOXWXGZVEZ8dllv1kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3997
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

--_004_MN2PR12MB403219C47CEC909255949B54FBC30MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB403219C47CEC909255949B54FBC30MN2PR12MB4032namp_"

--_000_MN2PR12MB403219C47CEC909255949B54FBC30MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to prefix RAS error related dmesg print with pci device in=
fo

--_000_MN2PR12MB403219C47CEC909255949B54FBC30MN2PR12MB4032namp_
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
<p class=3D"MsoNormal">Submitting patch to prefix RAS error related dmesg p=
rint with pci device info<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB403219C47CEC909255949B54FBC30MN2PR12MB4032namp_--

--_004_MN2PR12MB403219C47CEC909255949B54FBC30MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-update-RAS-related-dmesg-print.patch"
Content-Description: 0001-drm-amdgpu-update-RAS-related-dmesg-print.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-update-RAS-related-dmesg-print.patch"; size=3362;
	creation-date="Tue, 07 Apr 2020 08:51:00 GMT";
	modification-date="Tue, 07 Apr 2020 08:51:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwZjc3NmY5MzY0YjUwY2RjNjY0NTM2NzU3Nzk3MzI2ZWUyN2NmNjMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgNyBBcHIgMjAyMCAxNjo0OTo0MiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IHVwZGF0ZSBSQVMgcmVsYXRlZCBkbWVzZyBwcmludAoKcHJlZml4IFJBUyBlcnJv
ciByZWxhdGVkIGRtZXNnIHByaW50IHdpdGggcGNpIGRldmljZSBpbmZvCgpTaWduZWQtb2ZmLWJ5
OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSWZmOGI4
ZDY5N2FhM2ExODBmMTUwYzU2YjZiZTI1NjBlMDkwOTZiMzMKLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfNC5jICAgfCAgNiArKysrLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L21taHViX3Y5XzQuYyB8IDEzICsrKysrKysrLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzQuYwppbmRleCBjY2ViNDZmYWYyMTIuLmRjZTk0NWVmMjFhNSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzQuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjlfNC5jCkBAIC03MTAsMTQgKzcxMCwxNiBAQCBzdGF0aWMgaW50
IGdmeF92OV80X3F1ZXJ5X3V0Y19lZGNfc3RhdHVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAogCiAJCXNlY19jb3VudCA9IFJFR19HRVRfRklFTEQoZGF0YSwgVk1MMl9NRU1fRUNDX0NOVEws
IFNFQ19DT1VOVCk7CiAJCWlmIChzZWNfY291bnQpIHsKLQkJCURSTV9JTkZPKCJJbnN0YW5jZVsl
ZF06IFN1YkJsb2NrICVzLCBTRUMgJWRcbiIsIGksCisJCQlkZXZfaW5mbyhhZGV2LT5kZXYsCisJ
CQkJICJJbnN0YW5jZVslZF06IFN1YkJsb2NrICVzLCBTRUMgJWRcbiIsIGksCiAJCQkJIHZtbDJf
bWVtc1tpXSwgc2VjX2NvdW50KTsKIAkJCWVycl9kYXRhLT5jZV9jb3VudCArPSBzZWNfY291bnQ7
CiAJCX0KIAogCQlkZWRfY291bnQgPSBSRUdfR0VUX0ZJRUxEKGRhdGEsIFZNTDJfTUVNX0VDQ19D
TlRMLCBERURfQ09VTlQpOwogCQlpZiAoZGVkX2NvdW50KSB7Ci0JCQlEUk1fSU5GTygiSW5zdGFu
Y2VbJWRdOiBTdWJCbG9jayAlcywgREVEICVkXG4iLCBpLAorCQkJZGV2X2luZm8oYWRldi0+ZGV2
LAorCQkJCSAiSW5zdGFuY2VbJWRdOiBTdWJCbG9jayAlcywgREVEICVkXG4iLCBpLAogCQkJCSB2
bWwyX21lbXNbaV0sIGRlZF9jb3VudCk7CiAJCQllcnJfZGF0YS0+dWVfY291bnQgKz0gZGVkX2Nv
dW50OwogCQl9CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92
OV80LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMKaW5kZXggMGQ0
MTNmYWJkMDE1Li5jMGUzZWZjYjA5YmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L21taHViX3Y5XzQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1
Yl92OV80LmMKQEAgLTE1MzksOCArMTUzOSwxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNvYzE1
X3JlZ19lbnRyeSBtbWh1Yl92OV80X2VkY19jbnRfcmVnc1tdID0gewogCXsgU09DMTVfUkVHX0VO
VFJZKE1NSFVCLCAwLCBtbU1NRUE3X0VEQ19DTlQzKSwgMCwgMCwgMCB9LAogfTsKIAotc3RhdGlj
IGludCBtbWh1Yl92OV80X2dldF9yYXNfZXJyb3JfY291bnQoY29uc3Qgc3RydWN0IHNvYzE1X3Jl
Z19lbnRyeSAqcmVnLAotCXVpbnQzMl90IHZhbHVlLCB1aW50MzJfdCAqc2VjX2NvdW50LCB1aW50
MzJfdCAqZGVkX2NvdW50KQorc3RhdGljIGludCBtbWh1Yl92OV80X2dldF9yYXNfZXJyb3JfY291
bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCisJCQkJCSAgY29uc3Qgc3RydWN0IHNvYzE1
X3JlZ19lbnRyeSAqcmVnLAorCQkJCQkgIHVpbnQzMl90IHZhbHVlLAorCQkJCQkgIHVpbnQzMl90
ICpzZWNfY291bnQsCisJCQkJCSAgdWludDMyX3QgKmRlZF9jb3VudCkKIHsKIAl1aW50MzJfdCBp
OwogCXVpbnQzMl90IHNlY19jbnQsIGRlZF9jbnQ7CkBAIC0xNTUzLDcgKzE1NTYsNyBAQCBzdGF0
aWMgaW50IG1taHViX3Y5XzRfZ2V0X3Jhc19lcnJvcl9jb3VudChjb25zdCBzdHJ1Y3Qgc29jMTVf
cmVnX2VudHJ5ICpyZWcsCiAJCQkJbW1odWJfdjlfNF9yYXNfZmllbGRzW2ldLnNlY19jb3VudF9t
YXNrKSA+PgogCQkJCW1taHViX3Y5XzRfcmFzX2ZpZWxkc1tpXS5zZWNfY291bnRfc2hpZnQ7CiAJ
CWlmIChzZWNfY250KSB7Ci0JCQlEUk1fSU5GTygiTU1IVUIgU3ViQmxvY2sgJXMsIFNFQyAlZFxu
IiwKKwkJCWRldl9pbmZvKGFkZXYtPmRldiwgIk1NSFVCIFN1YkJsb2NrICVzLCBTRUMgJWRcbiIs
CiAJCQkJbW1odWJfdjlfNF9yYXNfZmllbGRzW2ldLm5hbWUsCiAJCQkJc2VjX2NudCk7CiAJCQkq
c2VjX2NvdW50ICs9IHNlY19jbnQ7CkBAIC0xNTYzLDcgKzE1NjYsNyBAQCBzdGF0aWMgaW50IG1t
aHViX3Y5XzRfZ2V0X3Jhc19lcnJvcl9jb3VudChjb25zdCBzdHJ1Y3Qgc29jMTVfcmVnX2VudHJ5
ICpyZWcsCiAJCQkJbW1odWJfdjlfNF9yYXNfZmllbGRzW2ldLmRlZF9jb3VudF9tYXNrKSA+Pgog
CQkJCW1taHViX3Y5XzRfcmFzX2ZpZWxkc1tpXS5kZWRfY291bnRfc2hpZnQ7CiAJCWlmIChkZWRf
Y250KSB7Ci0JCQlEUk1fSU5GTygiTU1IVUIgU3ViQmxvY2sgJXMsIERFRCAlZFxuIiwKKwkJCWRl
dl9pbmZvKGFkZXYtPmRldiwgIk1NSFVCIFN1YkJsb2NrICVzLCBERUQgJWRcbiIsCiAJCQkJbW1o
dWJfdjlfNF9yYXNfZmllbGRzW2ldLm5hbWUsCiAJCQkJZGVkX2NudCk7CiAJCQkqZGVkX2NvdW50
ICs9IGRlZF9jbnQ7CkBAIC0xNTg4LDcgKzE1OTEsNyBAQCBzdGF0aWMgdm9pZCBtbWh1Yl92OV80
X3F1ZXJ5X3Jhc19lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJcmVn
X3ZhbHVlID0KIAkJCVJSRUczMihTT0MxNV9SRUdfRU5UUllfT0ZGU0VUKG1taHViX3Y5XzRfZWRj
X2NudF9yZWdzW2ldKSk7CiAJCWlmIChyZWdfdmFsdWUpCi0JCQltbWh1Yl92OV80X2dldF9yYXNf
ZXJyb3JfY291bnQoJm1taHViX3Y5XzRfZWRjX2NudF9yZWdzW2ldLAorCQkJbW1odWJfdjlfNF9n
ZXRfcmFzX2Vycm9yX2NvdW50KGFkZXYsICZtbWh1Yl92OV80X2VkY19jbnRfcmVnc1tpXSwKIAkJ
CQlyZWdfdmFsdWUsICZzZWNfY291bnQsICZkZWRfY291bnQpOwogCX0KIAotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB403219C47CEC909255949B54FBC30MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB403219C47CEC909255949B54FBC30MN2PR12MB4032namp_--
