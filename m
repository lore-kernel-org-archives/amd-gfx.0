Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F46C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9B12073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LINsEhvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9B12073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17CAC6E195;
	Thu,  5 Mar 2020 09:39:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DB86E195
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 09:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJ7u78mF9xRKYkACDff9Gt/pjPlmWeYrBAbg1k+sbYKXwPWrdg2xZ4UT2MzxJtwg+M9ykbLyTmcLYjXgV0whNZOvEOBgzUlcE+7h2Ovu2PU7AB8IW3JVC8Qd9lDzQ0FT3dv24Ggkw09scBDLmik5m0UEGEqWtzt3RDKznqoJqPGbKY8PbjSGrgL8LPLBz29kagaFmX0TWGwazSpClTh6lVzJYN0WlptCYhcTXbUP13f7oKAVE+bgDvxQGDSy3+lFzm36I4aqAaaVlJnXLvxhdJydtIadLShUEhkKpPDjysQchG7wi8S1ylvrC/FCm1jKGeb0/gp4TNFp2Dv4BUsA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFMGS5Yxq0rP9nu8mzDk+goHpnkYQd9zlG6NYLYZLns=;
 b=ASF5ScjiXvgyYlD49nN9pDdYff0sCHSwVbhcO8e7Fjrd2pdWJpPuXYygSyiRS4LeSrdG5jCBcSq64ZP3Vd+DrCuUB2j5RB4zwJZ9XckwaOrNBprdndGLvp+xN6GSE1cnTSHpwKxZcF1reU6uRqKh8Axdq0x64q8J9uj41npAE++ywjT4v9hynXxzPxY89PHhdqPEqSTlqVODp3ulbHv3z7s4KyhqD03em4hf9fyZIcqQMMKPkeC6OyILD/Lw+pa8j56CVddMaBo5nTjHsEx8bAuFXeAu54hOFV5uy7xRKmeIh5lHW5SYjNwiF5Pbj4oieoWvH1qmXBVf4E7xKUw4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFMGS5Yxq0rP9nu8mzDk+goHpnkYQd9zlG6NYLYZLns=;
 b=LINsEhvXLiMGqh/BkutSMy0Qq0DRMkGsITwy5NfUpqGnu08FprF0Jp608jX7TJKW8f1KmIbqURmRRiP496IiamCl4wN9t6c4H5mokvXIUE8vQ/v9T5f3q/OndC+7jD4V8yON1p79n22upJACNWYBtvPAWo774gO1H4BXTKFcZWc=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 09:39:50 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7%7]) with mapi id 15.20.2793.013; Thu, 5 Mar 2020
 09:39:50 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: update page retirement sequence
Thread-Topic: [PATCH] drm/amdgpu: update page retirement sequence
Thread-Index: AdXy0f9EIn2WkBwySKekkStORNst4Q==
Date: Thu, 5 Mar 2020 09:39:49 +0000
Message-ID: <MN2PR12MB366376914E9DE0A1D1D39440FBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-05T09:39:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ddcdfbbc-89af-4d2f-8549-0000f5c83eff;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-05T09:39:47Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ddad4200-24ab-4b6d-83b2-0000f3b72a44
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.224.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4157789-391b-4625-7e7b-08d7c0e92666
x-ms-traffictypediagnostic: MN2PR12MB3309:|MN2PR12MB3309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB33097F5DD2532990C112AF20FBE20@MN2PR12MB3309.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:281;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(2906002)(81156014)(55016002)(6636002)(26005)(478600001)(81166006)(9686003)(558084003)(8676002)(8936002)(110136005)(66446008)(7696005)(76116006)(52536014)(71200400001)(66556008)(64756008)(316002)(66946007)(33656002)(66616009)(66476007)(5660300002)(86362001)(186003)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3309;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TIXEz8sREzgeG6u18z3fxdwc+rH9K0SCFJgbZjKfVDn80GIXSBIL7pmvYwj87Fne9lsIVvok30Ctxd7x550tLbWHP8X7y1qRevvX2t+Sd+EVNSLEkOxrHcS4gEZUMA+j0IcKBi2OC+BoK4LxcCiIZcKuOA4K2vtpKDT9L62reTLtkb1mKAjchkeDeCpK/USen7SygDVOm+oIX71oHGWzPpyx8d9FOg4/pLqOzxSZHgU8IWFKwbUx+Su4nwdp9vhB4R6NHgiVXbL4KZVDAXT7mYoEHsZgBRzEo/WxW+mg2ihsgFbmny96jLDMce2g7ylSZJgFY4KZPw9ezAy0Vqe0g57N6v40N0abwInVPQRJHPICCgY9CD/EoTE3cjhlAmnsmQuIw3zmc9vZbvlb2eSZxLNC2ahZqUluGYVl37ecqL1BRfUa1lyoCLgin5v8onsG
x-ms-exchange-antispam-messagedata: qYJz08fg4vE1jqTGinSKdyUDs3fs9QynwzdYqwVeugvGoChb3GTmbUoyHBBqLmqsjuabA2quE/camVUH+zjqUbehbHsThJ3GSUz8snmOyHSPdvbYvNFj/7pZyqX84F2/02Hp7lUHOtLkL2JJbDxL+g==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB366376914E9DE0A1D1D39440FBE20MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4157789-391b-4625-7e7b-08d7c0e92666
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 09:39:49.8679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Yc3MokypuiRJOrsFOJqV+fNLOxawJIKLaaYoOByoBJHKUFpz3rEufg7e8OZd6gKBOaPvB5urAjDtXPs7c/m9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3309
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

--_004_MN2PR12MB366376914E9DE0A1D1D39440FBE20MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB366376914E9DE0A1D1D39440FBE20MN2PR12MB3663namp_"

--_000_MN2PR12MB366376914E9DE0A1D1D39440FBE20MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

check UMC status and exit prior to making and erroneus register access

--_000_MN2PR12MB366376914E9DE0A1D1D39440FBE20MN2PR12MB3663namp_
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
<p class=3D"MsoNormal">check UMC status and exit prior to making and errone=
us register access<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB366376914E9DE0A1D1D39440FBE20MN2PR12MB3663namp_--

--_004_MN2PR12MB366376914E9DE0A1D1D39440FBE20MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-update-page-retirement-sequence.patch"
Content-Description: 0001-drm-amdgpu-update-page-retirement-sequence.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-update-page-retirement-sequence.patch"; size=1530;
	creation-date="Thu, 05 Mar 2020 09:39:00 GMT";
	modification-date="Thu, 05 Mar 2020 09:39:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2Nzc2NDc0ZjQ5ZGJkMTQ0ZTI0OTFlNTE0YWVkMDQ1OGViNDNhMTcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgNSBNYXIgMjAyMCAxNzozNDo1OCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IHVwZGF0ZSBwYWdlIHJldGlyZW1lbnQgc2VxdWVuY2UKCmNoZWNrIFVNQyBzdGF0
dXMgYW5kIGV4aXQgcHJpb3IgdG8gbWFraW5nIGFuZCBlcnJvbmV1cyByZWdpc3RlciBhY2Nlc3MK
ClNpZ25lZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVudHNAYW1kLmNvbT4KQ2hh
bmdlLUlkOiBJNGI4ZmU2ZTM3NzQzYzFiZGJhZDQ0MDVlMzMxMjBiNjM5OTQ5MTE4NQotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMgfCA3ICsrKysrLS0KIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3VtY192Nl8xLmMKaW5kZXggNzkzYmY3MGU2NGIxLi5mNjM0ZWEwYmM0ZTggMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEuYwpAQCAtMjI4LDcgKzIyOCwxMSBAQCBzdGF0
aWMgdm9pZCB1bWNfdjZfMV9xdWVyeV9lcnJvcl9hZGRyZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAogCQkJU09DMTVfUkVHX09GRlNFVChVTUMsIDAsIG1tTUNBX1VNQ19VTUMwX01DVU1D
X0FERFJUMCk7CiAJfQogCi0JLyogc2tpcCBlcnJvciBhZGRyZXNzIHByb2Nlc3MgaWYgLUVOT01F
TSAqLworCW1jX3VtY19zdGF0dXMgPSBSUkVHNjRfUENJRSgobWNfdW1jX3N0YXR1c19hZGRyICsg
dW1jX3JlZ19vZmZzZXQpICogNCk7CisKKwlpZiAobWNfdW1jX3N0YXR1cyA9PSAwKQorCQlyZXR1
cm47CisKIAlpZiAoIWVycl9kYXRhLT5lcnJfYWRkcikgewogCQkvKiBjbGVhciB1bWMgc3RhdHVz
ICovCiAJCVdSRUc2NF9QQ0lFKChtY191bWNfc3RhdHVzX2FkZHIgKyB1bWNfcmVnX29mZnNldCkg
KiA0LCAweDBVTEwpOwpAQCAtMjM2LDcgKzI0MCw2IEBAIHN0YXRpYyB2b2lkIHVtY192Nl8xX3F1
ZXJ5X2Vycm9yX2FkZHJlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJfQogCiAJZXJy
X3JlYyA9ICZlcnJfZGF0YS0+ZXJyX2FkZHJbZXJyX2RhdGEtPmVycl9hZGRyX2NudF07Ci0JbWNf
dW1jX3N0YXR1cyA9IFJSRUc2NF9QQ0lFKChtY191bWNfc3RhdHVzX2FkZHIgKyB1bWNfcmVnX29m
ZnNldCkgKiA0KTsKIAogCS8qIGNhbGN1bGF0ZSBlcnJvciBhZGRyZXNzIGlmIHVlL2NlIGVycm9y
IGlzIGRldGVjdGVkICovCiAJaWYgKFJFR19HRVRfRklFTEQobWNfdW1jX3N0YXR1cywgTUNBX1VN
Q19VTUMwX01DVU1DX1NUQVRVU1QwLCBWYWwpID09IDEgJiYKLS0gCjIuMTcuMQoK

--_004_MN2PR12MB366376914E9DE0A1D1D39440FBE20MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB366376914E9DE0A1D1D39440FBE20MN2PR12MB3663namp_--
