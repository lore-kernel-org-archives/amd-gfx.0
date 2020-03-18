Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536C6C10DCE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 14:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103DA2076C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 14:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vPyQGuZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103DA2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C262E6E906;
	Wed, 18 Mar 2020 14:11:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B6936E8E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 14:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj+Htk0gphRuHiO7OUbi4c8f9SvN9RVpEcEBLhzmBaHbHzkKZx406Evoxc2tekLcnEpQt7mq6542AoocrINbSWfqJjzk5d55zaitjVYLi0pSicILYeUMIFQO7jPiAsRPncJJuN9T0sz/N9GAfxSpMjlNel7ssXtGGLy3OZI++7o31QJwCz/fq9ruhiiASZ6f1co/lupG4Np4Zclit+5JKlwLQOrMTnS0fjSsrrnXwxAe8QuC8MSfjJZuRhri2RSJFLPa2VVUmEHoDf61Z19NxnTWFJ0gdCFWCml6LDIgZ4ZaIvEyBxeiP3gpurWJnShkWujryWFloivDA4hSyFCPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDosxaOv7PuCTuCSnmRGgo62yeRlj5+rkXLiGB4nSuY=;
 b=SVZJ1iHY6H8omx4PXRH0FZm7cVmLEFt//0fKS2iek0lkIC9HkMBeUmuS12lDurA6NH34ZZfJxMwaUF2HbGbFlVSaywhcqaDl9TiS8VK4OKqIrVUpk5IzdgOPfUAgTUd13Km7WBMAJVM03LjMvPB20iCSYYK6nl9s5oPGtRptElRRHfipSnxAcYiIEoVM1u5/Z49y2+eA/QM4y1/DyDHhJ2vTrWjgkT2mMNa7n0dkEtPD6Ll4stCWg8lmP4FF8bVhxw6O9opG/4Qui3L0i5HxhoA4+WHl7bQ1r3Sww535xYGK8UuEKUwlCr8nMr7oxEpN5P+gQcuPXFpsHQ5g/Fk+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDosxaOv7PuCTuCSnmRGgo62yeRlj5+rkXLiGB4nSuY=;
 b=vPyQGuZNUccNggg2XVD9PKKaBRPyCReUcJj//dM19iFDcz5C9RdVSf58Mmn9cmafe2ZOHg15klMp6BVScVwo5HM6Dv/BI2tuLGhHwlvE8nJdPM4wRmvTEe6ULsJUXaBon6U3L+stybM6vgtl36xcfCY6VzsuWQ43mIWoC4YTe0s=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by MN2PR12MB3327.namprd12.prod.outlook.com (2603:10b6:208:cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 18 Mar
 2020 14:11:55 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 14:11:55 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH ] amd/powerplay: arcturus baco reset disable all features
Thread-Topic: [PATCH ] amd/powerplay: arcturus baco reset disable all features
Thread-Index: AdX9LuOx8zN4SVpcTCq1frau/F96SQ==
Date: Wed, 18 Mar 2020 14:11:55 +0000
Message-ID: <MN2PR12MB3663E140D2D046113B5FC4CAFBF70@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-18T14:11:49Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b1a04472-b7ce-4645-abb6-000039021196;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-18T14:11:49Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8d0d51b7-8a4f-4b41-87f1-0000b41832af
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.224.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35056d77-dd78-424a-770c-08d7cb465060
x-ms-traffictypediagnostic: MN2PR12MB3327:|MN2PR12MB3327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3327A3C69B6F87C046010457FBF70@MN2PR12MB3327.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:568;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(81156014)(9686003)(81166006)(6636002)(8676002)(558084003)(6506007)(2906002)(110136005)(71200400001)(55016002)(316002)(7696005)(86362001)(186003)(66446008)(64756008)(66556008)(66476007)(66616009)(478600001)(66946007)(76116006)(5660300002)(26005)(52536014)(8936002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3327;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pzEvjQjsXJMljd7M9lTmY+x7+BDOmwCkLVcUQ09196NtMkCwflKVFR91v46Ip3Moi3kYcK2fltL5L4DPrRZSNaeDtbqQ2qQraC/Ht3e2423g/xLDbE3RZnfX1KiDaZcj3et1RnOv2ZnTUUchqfgTASSBLpNrf/fvKE6ffnZwR5yGXIlhiGAQ/JaE9IXIQQ76JKw20wjNHIVlOCC7IbuQwhtFAH0zRTen7ecgv/a7qVjXZf2t1YqdJMEu4iaU8G4jNM8WRpNEmOzRynad3UOLHDhPCD2iXoBHku7jdnvwJLQ/2zmdGHiDZ6WUS+Bl4B6fgR/44DXKI2SUR45hvpAVEzilMlti77ZiqgorJyNgLTmTXMBmHGFvQ6PV7B271uB/H7PN/FaXw0zA6tL/u4Mlvxa+ls/Qprlu1S6GCY34kUmRLzVUiyIaF9vLPtIg8Ctq
x-ms-exchange-antispam-messagedata: 5+8IEPqYu3/O4hwpqqW30oNlA27Ic3Zgyo2qOVjucVktZvW0FIqrjkm49vkdqOWSfmvMVm6BwM9dW8O5/2CtCzbSXNQvB5bxlAHuVI5M9/AWPbvYQbucwr4y3oH8tOaOE0G3uE/XlKkzf2jIIWjdAg==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB3663E140D2D046113B5FC4CAFBF70MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35056d77-dd78-424a-770c-08d7cb465060
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 14:11:55.1403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: briEtxYJ0hDXPlJUsnsD02lfVoCX+Gy/TEBzzhauArTWx8BR8WryHeLM2ACrS8zwrqqcIwGj8VhtLfdDrt/q5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3327
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

--_004_MN2PR12MB3663E140D2D046113B5FC4CAFBF70MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663E140D2D046113B5FC4CAFBF70MN2PR12MB3663namp_"

--_000_MN2PR12MB3663E140D2D046113B5FC4CAFBF70MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch for review to issue smu cmd disable all features upon baco=
 entry sequence in arcturus.

This helps resolve issue with I2C controller not being disengaged properly =
on GPU reset affecting RAS eeprom stability on re-entry

--_000_MN2PR12MB3663E140D2D046113B5FC4CAFBF70MN2PR12MB3663namp_
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
<p class=3D"MsoNormal">Submitting patch for review to issue smu cmd disable=
 all features upon baco entry sequence in arcturus.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This helps resolve issue with I2C controller not bei=
ng disengaged properly on GPU reset affecting RAS eeprom stability on re-en=
try<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3663E140D2D046113B5FC4CAFBF70MN2PR12MB3663namp_--

--_004_MN2PR12MB3663E140D2D046113B5FC4CAFBF70MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-amd-powerplay-arcturus-baco-reset-disable-all-featur.patch"
Content-Description:  0001-amd-powerplay-arcturus-baco-reset-disable-all-featur.patch
Content-Disposition: attachment;
	filename="0001-amd-powerplay-arcturus-baco-reset-disable-all-featur.patch";
	size=1791; creation-date="Wed, 18 Mar 2020 14:09:00 GMT";
	modification-date="Wed, 18 Mar 2020 14:09:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkZTc3MjVhODYyMzgxMzJhNDczOGRjMTU3ZDBiOWY5MjI5MzJmZjE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgMTggTWFyIDIwMjAgMjI6MDc6MjIgKzA4MDAKU3ViamVjdDogW1BBVENIIF0g
YW1kL3Bvd2VycGxheTogYXJjdHVydXMgYmFjbyByZXNldCBkaXNhYmxlIGFsbCBmZWF0dXJlcwoK
aXNzdWUgc211IGNtZCB0byBkaXNhYmxlIGFsbCBmZWF0dXJlcyB1cG9uIGJhY28gZW50cnkgZm9y
IGFyY3R1cnVzCnRvIG1pdGlnYXRlIHBvdGVudGlhbCBkaXJ0eSBJMkMgY29udHJvbGxlciBvbiBi
b290CgpTaWduZWQtb2ZmLWJ5OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkNoYW5nZS1JZDogSWM0ODEzYmU2YzU2MTQyNDM0ODFkMTRkMzc4ZjljZmM2ZGEzNWE1MmIKLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgfCAyMSArKysrKysr
KysrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdw
dV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwppbmRl
eCAwMjczYzYzYmFmOGUuLmY2ZDRiMGVmNDZhZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2FtZGdwdV9zbXUuYwpAQCAtMTQ3MCwyMSArMTQ3MCwyNiBAQCBzdGF0aWMgaW50IHNt
dV9kaXNhYmxlX2RwbShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIAl9CiAKIAkvKgotCSAqIEZv
ciBiYWNvIG9uIEFyY3R1cnVzLCB0aGlzIG9wZXJhdGlvbgotCSAqIChkaXNhYmxlIGFsbCBzbXUg
ZmVhdHVyZSkgd2lsbCBiZSBoYW5kbGVkIGJ5IFNNVSBGVy4KKwkgKiBEaXNhYmxlIGFsbCBlbmFi
bGVkIFNNVSBmZWF0dXJlcy4KKwkgKiBUaGlzIHNob3VsZCBiZSBoYW5kbGVkIGluIFNNVSBGVywg
YXMgYSBiYWNrdXAKKwkgKiBkcml2ZXIgY2FuIGlzc3VlIGNhbGwgdG8gU01VIEZXIHVudGlsIHNl
cXVlbmNlCisJICogaW4gU01VIEZXIGlzIG9wZXJhdGlvbmFsLgogCSAqLwotCWlmIChhZGV2LT5h
c2ljX3R5cGUgPT0gQ0hJUF9BUkNUVVJVUykgewotCQlpZiAodXNlX2JhY28gJiYgKHNtdV92ZXJz
aW9uID4gMHgzNjBlMDApKQotCQkJcmV0dXJuIDA7Ci0JfQotCi0JLyogRGlzYWJsZSBhbGwgZW5h
YmxlZCBTTVUgZmVhdHVyZXMgKi8KIAlyZXQgPSBzbXVfc3lzdGVtX2ZlYXR1cmVzX2NvbnRyb2wo
c211LCBmYWxzZSk7CiAJaWYgKHJldCkgewogCQlwcl9lcnIoIkZhaWxlZCB0byBkaXNhYmxlIHNt
dSBmZWF0dXJlcy5cbiIpOwogCQlyZXR1cm4gcmV0OwogCX0KIAorCS8qCisJICogQXJjdHVydXMg
ZG9lcyBub3QgaGF2ZSBCQUNPIGJpdCBpbiBkaXNhYmxlIGZlYXR1cmUgbWFzay4KKwkgKiBFbmFi
bGVtZW50IG9mIEJBQ08gYml0IG9uIEFyY3R1cnVzIHNob3VsZCBiZSBza2lwcGVkLgorCSAqLwor
CWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9BUkNUVVJVUykgeworCQlpZiAodXNlX2JhY28g
JiYgKHNtdV92ZXJzaW9uID4gMHgzNjBlMDApKQorCQkJcmV0dXJuIDA7CisJfQorCiAJLyogRm9y
IGJhY28sIG5lZWQgdG8gbGVhdmUgQkFDTyBmZWF0dXJlIGVuYWJsZWQgKi8KIAlpZiAodXNlX2Jh
Y28pIHsKIAkJLyoKLS0gCjIuMTcuMQoK

--_004_MN2PR12MB3663E140D2D046113B5FC4CAFBF70MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB3663E140D2D046113B5FC4CAFBF70MN2PR12MB3663namp_--
