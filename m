Return-Path: <SRS0=SXnv=2V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A53BC2D0C3
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2019 02:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A07520730
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2019 02:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0tgblyzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A07520730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1066E0C1;
	Tue, 31 Dec 2019 02:29:37 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690071.outbound.protection.outlook.com [40.107.69.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D8846E0C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Dec 2019 02:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYm6IycWkso5SmKRdWTtcdPIqZ9MsZxd1MeupqEFnMK1IychgQNHaXWYkd7LOgZgcsW2mQt8qZnF+g9fzaKReny0v1AWIYMvn2BnIyoseJA9ymBi4UvG5Lf9Hocvy2fN3T/eD0GUbgk3h7j8xYawmA6mwsQ5v8J5r9MTjgRdkEPGiz1aDh7kZHW5hoRSSM+MSbc5udyLQaE85mLCJf7C+f0THCoCmwZhDWb5BJI4MvuoXFxOu+0Cr6RurWxYxS7zVtwJJyKgqSniVCE6ucIt6g/b13xNbncQ4d0m/pD6oXa8RTgTbYItnbHmoawi+4TE9wA9BkAaaUkZ4Azk4vH6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJb9rwic0fEQ4sg6vq0zpJ8FsVpwPe6C8z9/O2o0MUs=;
 b=cz7pTjVsKkJRxMTiFTiGQc5Fs+xkF1mQ5H4g1gZEeHGYIkZodqLuYCaUEm28DXsBVuSwz8xXE5NHJLJ5oxdgKsmGHczkqXIr8M3dF6nAJF1jlij77XHrXKBEIxtInFLEk5FbCK9pHEAfpCZOY2ht33kz91iaVDfaJANJdDQNNtP3iaBgh0oPViu6ud3F4XauaVqyh+zYAo0vHbrWw2P5Sbg7z/cijVJoLggVoM7q/a3SR8dqhVKnE3ryLTMrMhmNqOk2Bh2X9ZfPd/R5/pJE0X8C7uZWhH1oZZdIPLXzsczwHvzbuGATVmFfXw52XtxIihlh8SDAhn2ZkxT0t8tgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJb9rwic0fEQ4sg6vq0zpJ8FsVpwPe6C8z9/O2o0MUs=;
 b=0tgblyzC3YXifOi7evAbq2zBGuYO8Y6wcgxCT62wtdRTK4Ifocti2tx5n52eQ6nDx4vfIUvX/cRjgCExMYKnbKXE/v2hDHUAaNUOSTUniapcRlVsLdJ4J4gmD4/t6BZUypp0KdqiCCF0SiOdkulOTc8MjHnN2IvEPG2GQ4V9vZQ=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3709.namprd12.prod.outlook.com (10.255.237.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Tue, 31 Dec 2019 02:29:31 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2581.007; Tue, 31 Dec 2019
 02:29:31 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update UMC 6.1 RAS error counter register access
 path
Thread-Topic: [PATCH] drm/amdgpu: update UMC 6.1 RAS error counter register
 access path
Thread-Index: AdW/gem7rSUM8jyCQXKCbRy8Im44xQ==
Date: Tue, 31 Dec 2019 02:29:31 +0000
Message-ID: <MN2PR12MB3663C8CD54259C55C8DA4EC2FB260@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-31T02:29:27Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=84b90405-2e92-4ab6-87b9-00001b54c423;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-31T02:29:27Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a3cdc767-1abc-4289-9775-0000f5da86c3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6bbad19-0351-49df-4616-08d78d9944af
x-ms-traffictypediagnostic: MN2PR12MB3709:|MN2PR12MB3709:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3709BAF5A988243075D65626FB260@MN2PR12MB3709.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(33656002)(86362001)(2906002)(5660300002)(52536014)(9686003)(186003)(55016002)(26005)(76116006)(66476007)(66616009)(66946007)(478600001)(7696005)(8936002)(81156014)(66446008)(81166006)(71200400001)(8676002)(66556008)(64756008)(558084003)(6506007)(6636002)(110136005)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3709;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xaNOuWjsf2xl+qtIX9ciHQDuqNzLIcAUuoOEO30ugUdozJjGCqpfdgNelqk4h0+0qTjHz2enXYMbXnYnF9XU/dZMFLCh70+cOm1RCkNHZs0Gent/1/brTSur/b7dslUr7K1RW215o06/48E8eCwEPyvhT6qN4QphqlXm/X9OHg/Rmru78fxPDeCQt21xz12ROEL0CrlI6QNxgT0qPINMl83E4+MKjuSAJDQF9LX9VQxtz5+GiIy1K6Ku6QMKONqiTzON4/dtQgpfzbk2g9CJ2QBELXfjxHIefA4IQQib1JC1Fo+9DPegDNp38j1+Ez8vLmtEDyL5t0UIe3KoV1rxVQ5Kh77MPGPGcEeiErM8/QojidfE+kAxuWN9TKsxu0PPMtpzjQXZN+CUtynBu12rg8+VL3mdGNxbNvU9xCjtKAmwPzR/NwSKXDieEmhxkYZA
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB3663C8CD54259C55C8DA4EC2FB260MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bbad19-0351-49df-4616-08d78d9944af
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 02:29:31.6895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuanlqIcUuTgY5mgrW84//P8SV8NaNJV/wOHS89tM6f1wI8/WJGuR4ytMQCUAXEj4mNQmAvRReNidBMfh8PtoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3709
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

--_004_MN2PR12MB3663C8CD54259C55C8DA4EC2FB260MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663C8CD54259C55C8DA4EC2FB260MN2PR12MB3663namp_"

--_000_MN2PR12MB3663C8CD54259C55C8DA4EC2FB260MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


Submitting patch to access UMC Status register on Arcturus/Vega20 via SMN



Thank you,

John Clements

--_000_MN2PR12MB3663C8CD54259C55C8DA4EC2FB260MN2PR12MB3663namp_
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
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"xmsonormal">Submitting patch to access UMC Status register on A=
rcturus/Vega20 via SMN<o:p></o:p></p>
<p class=3D"xmsonormal"><o:p>&nbsp;</o:p></p>
<p class=3D"xmsonormal">Thank you,<o:p></o:p></p>
<p class=3D"xmsonormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3663C8CD54259C55C8DA4EC2FB260MN2PR12MB3663namp_--

--_004_MN2PR12MB3663C8CD54259C55C8DA4EC2FB260MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-update-UMC-6.1-RAS-error-counter-register.patch"
Content-Description:  0001-drm-amdgpu-update-UMC-6.1-RAS-error-counter-register.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-update-UMC-6.1-RAS-error-counter-register.patch";
	size=2801; creation-date="Tue, 31 Dec 2019 02:27:00 GMT";
	modification-date="Tue, 31 Dec 2019 02:27:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5ZGM2OWEyNTIzMTRkNzAwYzI0NTlkMWM2NTlkYTc5N2NhOGNhM2M1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IE1vbiwgMzAgRGVjIDIwMTkgMTQ6NTg6NTcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiB1cGRhdGUgVU1DIDYuMSBSQVMgZXJyb3IgY291bnRlciByZWdpc3RlciBhY2Nl
c3MgcGF0aAoKdXNlIHByb3BlciBtZXRob2QgZm9yIFNNTiByZWdpc3RlciBhY2Nlc3MKCkNoYW5n
ZS1JZDogSWVmOGU3ZDZjZjQ1NWFkMWVlNTk0MTA0YWQ0NWM0NTJlZmI3OTY2MDIKU2lnbmVkLW9m
Zi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMgfCAxMCArKysrKy0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS91bWNfdjZfMS5jCmluZGV4IDUwOTM5NjVkYmMyNC4uMjMxNzgzOTk2NjdjIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMKQEAgLTEzOSw3ICsxMzksNyBAQCBzdGF0aWMg
dm9pZCB1bWNfdjZfMV9xdWVyeV9jb3JyZWN0YWJsZV9lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKIAogCS8qIGNoZWNrIGZvciBTUkFNIGNvcnJlY3RhYmxlIGVycm9yCiAJ
ICBNQ1VNQ19TVEFUVVMgaXMgYSA2NCBiaXQgcmVnaXN0ZXIgKi8KLQltY191bWNfc3RhdHVzID0g
UlJFRzY0X1VNQyhtY191bWNfc3RhdHVzX2FkZHIgKyB1bWNfcmVnX29mZnNldCk7CisJbWNfdW1j
X3N0YXR1cyA9IFJSRUc2NF9QQ0lFKChtY191bWNfc3RhdHVzX2FkZHIgKyB1bWNfcmVnX29mZnNl
dCkgKiA0KTsKIAlpZiAoUkVHX0dFVF9GSUVMRChtY191bWNfc3RhdHVzLCBNQ0FfVU1DX1VNQzBf
TUNVTUNfU1RBVFVTVDAsIEVycm9yQ29kZUV4dCkgPT0gNiAmJgogCSAgICBSRUdfR0VUX0ZJRUxE
KG1jX3VtY19zdGF0dXMsIE1DQV9VTUNfVU1DMF9NQ1VNQ19TVEFUVVNUMCwgVmFsKSA9PSAxICYm
CiAJICAgIFJFR19HRVRfRklFTEQobWNfdW1jX3N0YXR1cywgTUNBX1VNQ19VTUMwX01DVU1DX1NU
QVRVU1QwLCBDRUNDKSA9PSAxKQpAQCAtMTY0LDcgKzE2NCw3IEBAIHN0YXRpYyB2b2lkIHVtY192
Nl8xX3F1ZXJyeV91bmNvcnJlY3RhYmxlX2Vycm9yX2NvdW50KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2CiAJfQogCiAJLyogY2hlY2sgdGhlIE1DVU1DX1NUQVRVUyAqLwotCW1jX3VtY19zdGF0
dXMgPSBSUkVHNjRfVU1DKG1jX3VtY19zdGF0dXNfYWRkciArIHVtY19yZWdfb2Zmc2V0KTsKKwlt
Y191bWNfc3RhdHVzID0gUlJFRzY0X1BDSUUoKG1jX3VtY19zdGF0dXNfYWRkciArIHVtY19yZWdf
b2Zmc2V0KSAqIDQpOwogCWlmICgoUkVHX0dFVF9GSUVMRChtY191bWNfc3RhdHVzLCBNQ0FfVU1D
X1VNQzBfTUNVTUNfU1RBVFVTVDAsIFZhbCkgPT0gMSkgJiYKIAkgICAgKFJFR19HRVRfRklFTEQo
bWNfdW1jX3N0YXR1cywgTUNBX1VNQ19VTUMwX01DVU1DX1NUQVRVU1QwLCBEZWZlcnJlZCkgPT0g
MSB8fAogCSAgICBSRUdfR0VUX0ZJRUxEKG1jX3VtY19zdGF0dXMsIE1DQV9VTUNfVU1DMF9NQ1VN
Q19TVEFUVVNUMCwgVUVDQykgPT0gMSB8fApAQCAtMjExLDEyICsyMTEsMTIgQEAgc3RhdGljIHZv
aWQgdW1jX3Y2XzFfcXVlcnlfZXJyb3JfYWRkcmVzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKIAkvKiBza2lwIGVycm9yIGFkZHJlc3MgcHJvY2VzcyBpZiAtRU5PTUVNICovCiAJaWYgKCFl
cnJfZGF0YS0+ZXJyX2FkZHIpIHsKIAkJLyogY2xlYXIgdW1jIHN0YXR1cyAqLwotCQlXUkVHNjRf
VU1DKG1jX3VtY19zdGF0dXNfYWRkciArIHVtY19yZWdfb2Zmc2V0LCAweDBVTEwpOworCQlXUkVH
NjRfUENJRSgobWNfdW1jX3N0YXR1c19hZGRyICsgdW1jX3JlZ19vZmZzZXQpICogNCwgMHgwVUxM
KTsKIAkJcmV0dXJuOwogCX0KIAogCWVycl9yZWMgPSAmZXJyX2RhdGEtPmVycl9hZGRyW2Vycl9k
YXRhLT5lcnJfYWRkcl9jbnRdOwotCW1jX3VtY19zdGF0dXMgPSBSUkVHNjRfVU1DKG1jX3VtY19z
dGF0dXNfYWRkciArIHVtY19yZWdfb2Zmc2V0KTsKKwltY191bWNfc3RhdHVzID0gUlJFRzY0X1BD
SUUoKG1jX3VtY19zdGF0dXNfYWRkciArIHVtY19yZWdfb2Zmc2V0KSAqIDQpOwogCiAJLyogY2Fs
Y3VsYXRlIGVycm9yIGFkZHJlc3MgaWYgdWUvY2UgZXJyb3IgaXMgZGV0ZWN0ZWQgKi8KIAlpZiAo
UkVHX0dFVF9GSUVMRChtY191bWNfc3RhdHVzLCBNQ0FfVU1DX1VNQzBfTUNVTUNfU1RBVFVTVDAs
IFZhbCkgPT0gMSAmJgpAQCAtMjUxLDcgKzI1MSw3IEBAIHN0YXRpYyB2b2lkIHVtY192Nl8xX3F1
ZXJ5X2Vycm9yX2FkZHJlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJfQogCiAJLyog
Y2xlYXIgdW1jIHN0YXR1cyAqLwotCVdSRUc2NF9VTUMobWNfdW1jX3N0YXR1c19hZGRyICsgdW1j
X3JlZ19vZmZzZXQsIDB4MFVMTCk7CisJV1JFRzY0X1BDSUUoKG1jX3VtY19zdGF0dXNfYWRkciAr
IHVtY19yZWdfb2Zmc2V0KSAqIDQsIDB4MFVMTCk7CiB9CiAKIHN0YXRpYyB2b2lkIHVtY192Nl8x
X3F1ZXJ5X3Jhc19lcnJvcl9hZGRyZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAotLSAK
Mi4xNy4xCgo=

--_004_MN2PR12MB3663C8CD54259C55C8DA4EC2FB260MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB3663C8CD54259C55C8DA4EC2FB260MN2PR12MB3663namp_--
