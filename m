Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED15C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 09:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3CD120729
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 09:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BGJr7V2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CD120729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808016E55E;
	Tue, 21 Jul 2020 09:54:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0F16E55C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOd93CoapYI6J58EcIe/3mCzoQsVJx2XFn0S7785f/4XA+mm+769TF0gAm67DLQ2bJKgkz+2lm730R467enGdYLdXCK+mYna8Quvhs7m+I72bA935DDNIJEM8/YkQ099GtWBL36zXedQEOyY7zttAsLlCvE+p991QZPgYnQ5QEaYC8lmg9QtzpTY5mTN+giaxzml60WDwX0GLwckmwARKvfjSsTpsmpJn8yv2jnue4a952+D07uZeyqHnXL8ThT2Ry2LyC0IQm9bNlJHb91fPFoeq/HSBoncw4U8lNEH56UDAwxgxw66mPaicvIR6jhNV/0mSLKIyGK+KG4okzg48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yz9VgSCqD+5bLGmjDx8a4W01kaSp2McyLiR8Z88Iek=;
 b=cZutDZMql8OSeewQAQtGrCGM/qc5IhhegWw14dgWWdikRAbprlAJ30ttKGhO+ly+5V5sIH/wYz6OuCdY+RUZjte2DYhC06hbwC1D1RTxDlCUc9cGT/POHopeFei0lx+S9l4UWp12mjFZM6J9+5vyJLJl9tCjH9YO/psKFKmgyBWNNVw+UkBPmLde+nAHt5wDQzT1Tuwq7RKKpYW6y0t4QBGpR1tWsdIbBgDiLGHF4XnaNYUGa26kpHv2uE0g3QJ42bb76woR2MiKd8qUKHe3DaixKYtTqlvCklnd4TjEUR6E9iXg8zQuuo27Visj2bOtgLcGZnBbp7y5vslxtq7TSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yz9VgSCqD+5bLGmjDx8a4W01kaSp2McyLiR8Z88Iek=;
 b=BGJr7V2Y9xga5EKhy3p84NNm23rFpgs0ujlR54SKqY2+17IG3Gu5Ri4ILHs4I6ev+o24BAOXie5DlZmolXOaCH8gnQWXR9BdClnr9o0xL0r9ygxQ8ww0OTQBvwlQrWTDqCKkFNcxfRcRMUYpFtSq+XQZF29SjQzQoMl+bsvzpX0=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Tue, 21 Jul
 2020 09:54:19 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235%7]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 09:54:19 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: expand sienna chichlid reg access support
Thread-Topic: [PATCH] drm/amdgpu: expand sienna chichlid reg access support
Thread-Index: AdZfRMbeLVrLWZiUScy7xMGsaeMiBQ==
Date: Tue, 21 Jul 2020 09:54:18 +0000
Message-ID: <MN2PR12MB403248E1E8B8387413126F4AFB780@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-21T09:54:14Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=896ab18a-c36a-45e2-b47a-0000373cc5b9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-21T09:54:05Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2b050faa-b8f0-4723-8759-0000203092d2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-21T09:54:15Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 8f467c62-a6e1-4ff5-b987-0000a8ca3dbf
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 310cf1a0-184e-48ab-2cbc-08d82d5c0975
x-ms-traffictypediagnostic: MN2PR12MB4423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4423BAF74FBDABEB1B054405FB780@MN2PR12MB4423.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s6GW9AlwlHPciuUnk59XMuZEquAQiHSCrA28/dXILIPrE2dWwAvQHacfBNcfyGtjacB9nhUzNPocGRHlBa7kompBhS35V6hb8pz8blce1nQYjm4SmQjeqlZAcFj4E9Pg8FjlQKS7+i/KLyqlU/0iQRMdkKFepdNSANsRB+A+RjYSEL/PdsDABBBP2T/Qr2F4alcJxEQ55eoDCeztMwB/+goWdWtgsPyC1Kp5pmdLOxRPZ7daHFlhnmDKrhi5N0v4/qA6/dO779pVNkFe5BxW5lbiksgUfocDiQEHFzhI9EmgKeeV4GhI9hiz0kAldK6J44OHBHLercryUp5oT+5LEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(2906002)(6636002)(186003)(71200400001)(6506007)(8676002)(110136005)(55016002)(5660300002)(26005)(86362001)(76116006)(9686003)(33656002)(99936003)(8936002)(52536014)(64756008)(66616009)(478600001)(558084003)(316002)(7696005)(66946007)(66556008)(66476007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Gn+nAl72hSbzFWuYefA49nIK86XzORfbTj0eUMMfiT6wzcZZOAYIIObbI03bhQZoeM7VZsYHHboAAzX3jpVIIhUKF+D47iY5dAAt+oUB5IpY1IYtfY4lNtVLAou3JM2DV323IjtAAVVeGXILEaztXdQlPopHS3VHC7sgzhwEAea7/fS12KQe8LDgf+JDYNms/d3+HTksZ7kIJAp6j1CARwEhN3vFT/C+KuvHiULlmB2N1dKgyuXG/L84H7rm37igkPc7jyrgNvMseaS1l28wM2/0MFA+mVjbGSZX2EP/bPsIi9dEOaWPICsCYJ5pkGc2EzDJyuw3VW/UrItC2M94eLU3dooc5cGy+VjlOB+y1oEY7Yelywpzu78NpJay6+SPrybkFiWFG6BLHqIejm8opkalEXZ4sOd+1RZJ6qCU+haKhYprSasvCGowFmUhdawbyzl7Rh2CAgQMyHP6vcnUSMSBPpABlI5v8BpK5Isq56AMCI2HvfgXQt9EZhfsWoTI
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB403248E1E8B8387413126F4AFB780MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310cf1a0-184e-48ab-2cbc-08d82d5c0975
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 09:54:18.9111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKcGRysK1Gmk7wDwHTauuImyvuBe/U4Ze9i+aqWF4NcEVcW3KgD6Xl1CddZkFo6i5ICWz7bFgSRGfyasuJwTpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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

--_004_MN2PR12MB403248E1E8B8387413126F4AFB780MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB403248E1E8B8387413126F4AFB780MN2PR12MB4032namp_"

--_000_MN2PR12MB403248E1E8B8387413126F4AFB780MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Added support for dedicated 64bit read/write reg support for sienna chichli=
d

--_000_MN2PR12MB403248E1E8B8387413126F4AFB780MN2PR12MB4032namp_
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
<p class=3D"MsoNormal">Added support for dedicated 64bit read/write reg sup=
port for sienna chichlid<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB403248E1E8B8387413126F4AFB780MN2PR12MB4032namp_--

--_004_MN2PR12MB403248E1E8B8387413126F4AFB780MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-expand-sienna-chichlid-reg-access-support.patch"
Content-Description:  0001-drm-amdgpu-expand-sienna-chichlid-reg-access-support.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-expand-sienna-chichlid-reg-access-support.patch";
	size=2445; creation-date="Tue, 21 Jul 2020 09:53:00 GMT";
	modification-date="Tue, 21 Jul 2020 09:53:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmYzU5MjFmOTQwYjkxMGIyY2U2MTE4MDU0MGFkNWQ2NWE1ZThhODE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMjEgSnVsIDIwMjAgMTc6NTE6MjIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBleHBhbmQgc2llbm5hIGNoaWNobGlkIHJlZyBhY2Nlc3Mgc3VwcG9ydAoKQWRk
ZWQgZGVkaWNhdGVkIDY0Yml0IHJlZyByZWFkL3dyaXRlIHN1cHBvcnQKClNpZ25lZC1vZmYtYnk6
IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVudHNAYW1kLmNvbT4KQ2hhbmdlLUlkOiBJZWQ2ODc4
YzJjZWQ3NjA5MmE3ZmQ1YTUzMWY2YzFkNTA4ZTY1NGE3NgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L252LmMgfCA0NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMKaW5k
ZXggZWE2OWFlNzY3NzNlLi43NGQwMmQyNzBkMzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L252LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYwpA
QCAtOTcsNiArOTcsNDkgQEAgc3RhdGljIHZvaWQgbnZfcGNpZV93cmVnKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCB1MzIgcmVnLCB1MzIgdikKIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZh
ZGV2LT5wY2llX2lkeF9sb2NrLCBmbGFncyk7CiB9CiAKK3N0YXRpYyB1NjQgbnZfcGNpZV9ycmVn
NjQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiByZWcpCit7CisJdW5zaWduZWQgbG9u
ZyBmbGFncywgYWRkcmVzcywgZGF0YTsKKwl1NjQgcjsKKwlhZGRyZXNzID0gYWRldi0+bmJpby5m
dW5jcy0+Z2V0X3BjaWVfaW5kZXhfb2Zmc2V0KGFkZXYpOworCWRhdGEgPSBhZGV2LT5uYmlvLmZ1
bmNzLT5nZXRfcGNpZV9kYXRhX29mZnNldChhZGV2KTsKKworCXNwaW5fbG9ja19pcnFzYXZlKCZh
ZGV2LT5wY2llX2lkeF9sb2NrLCBmbGFncyk7CisJLyogcmVhZCBsb3cgMzIgYml0ICovCisJV1JF
RzMyKGFkZHJlc3MsIHJlZyk7CisJKHZvaWQpUlJFRzMyKGFkZHJlc3MpOworCXIgPSBSUkVHMzIo
ZGF0YSk7CisKKwkvKiByZWFkIGhpZ2ggMzIgYml0Ki8KKwlXUkVHMzIoYWRkcmVzcywgcmVnICsg
NCk7CisJKHZvaWQpUlJFRzMyKGFkZHJlc3MpOworCXIgfD0gKCh1NjQpUlJFRzMyKGRhdGEpIDw8
IDMyKTsKKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhZGV2LT5wY2llX2lkeF9sb2NrLCBmbGFn
cyk7CisJcmV0dXJuIHI7Cit9CisKK3N0YXRpYyB2b2lkIG52X3BjaWVfd3JlZzY0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCB1MzIgcmVnLCB1NjQgdikKK3sKKwl1bnNpZ25lZCBsb25nIGZs
YWdzLCBhZGRyZXNzLCBkYXRhOworCisJYWRkcmVzcyA9IGFkZXYtPm5iaW8uZnVuY3MtPmdldF9w
Y2llX2luZGV4X29mZnNldChhZGV2KTsKKwlkYXRhID0gYWRldi0+bmJpby5mdW5jcy0+Z2V0X3Bj
aWVfZGF0YV9vZmZzZXQoYWRldik7CisKKwlzcGluX2xvY2tfaXJxc2F2ZSgmYWRldi0+cGNpZV9p
ZHhfbG9jaywgZmxhZ3MpOworCS8qIHdyaXRlIGxvdyAzMiBiaXQgKi8KKwlXUkVHMzIoYWRkcmVz
cywgcmVnKTsKKwkodm9pZClSUkVHMzIoYWRkcmVzcyk7CisJV1JFRzMyKGRhdGEsICh1MzIpKHYg
JiAweGZmZmZmZmZmVUxMKSk7CisJKHZvaWQpUlJFRzMyKGRhdGEpOworCisJLyogd3JpdGUgaGln
aCAzMiBiaXQgKi8KKwlXUkVHMzIoYWRkcmVzcywgcmVnICsgNCk7CisJKHZvaWQpUlJFRzMyKGFk
ZHJlc3MpOworCVdSRUczMihkYXRhLCAodTMyKSh2ID4+IDMyKSk7CisJKHZvaWQpUlJFRzMyKGRh
dGEpOworCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmFkZXYtPnBjaWVfaWR4X2xvY2ssIGZsYWdz
KTsKK30KKwogc3RhdGljIHUzMiBudl9kaWR0X3JyZWcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHUzMiByZWcpCiB7CiAJdW5zaWduZWQgbG9uZyBmbGFncywgYWRkcmVzcywgZGF0YTsKQEAg
LTY3Myw2ICs3MTYsOCBAQCBzdGF0aWMgaW50IG52X2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhh
bmRsZSkKIAlhZGV2LT5zbWNfd3JlZyA9IE5VTEw7CiAJYWRldi0+cGNpZV9ycmVnID0gJm52X3Bj
aWVfcnJlZzsKIAlhZGV2LT5wY2llX3dyZWcgPSAmbnZfcGNpZV93cmVnOworCWFkZXYtPnBjaWVf
cnJlZzY0ID0gJm52X3BjaWVfcnJlZzY0OworCWFkZXYtPnBjaWVfd3JlZzY0ID0gJm52X3BjaWVf
d3JlZzY0OwogCiAJLyogVE9ETzogd2lsbCBhZGQgdGhlbSBkdXJpbmcgVkNOIHYyIGltcGxlbWVu
dGF0aW9uICovCiAJYWRldi0+dXZkX2N0eF9ycmVnID0gTlVMTDsKLS0gCjIuMTcuMQoK

--_004_MN2PR12MB403248E1E8B8387413126F4AFB780MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB403248E1E8B8387413126F4AFB780MN2PR12MB4032namp_--
