Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F1CC1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 06:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475342051A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 06:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yQYk5dwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475342051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1347D89AEA;
	Wed, 25 Mar 2020 06:51:12 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750051.outbound.protection.outlook.com [40.107.75.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F6B08999A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 06:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuBGRuo0oDZzM7Spj5nHjM42hAlOl4XqeY692pGv4UTNizuqvQlSy3sRnjIFoaNT6b5iTYMZrU1DkG0flOxU1xzwBEYXqqTYRA3xNxAnufHpCDXx2I4e67xxEJlbEkpr/uY+BvdqEQowVM8Q0e6i2540yZpv6oqBWqlymFM9uDVgQ0Wwa+y81TLRx6AtFPJfLJ4OzLrf1EOW/CT2kyty1EVvuTbobqOFyuLaILFt9+yjszHROj9OP/KxJT3ss549X9Qvhjsc64PGcsY5+huOc6U8vGQvDZCQ9XEuGWLnMs7tTeyboTh3/khv/zQ+xJaTEr+eG95/4fvKAMydYn8sSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHlCXMjpD0mYUTS9DD5Rk/bTwEDtOA4/OqOBkOet4JA=;
 b=BN1y4APOVY7bnckHroU2UC2HoZqVR0IOiZZirtgHcd/XCdXW/kDQd4j3jeewU+wMiGyLd/sqHJTm50w0JjX+A48/2EqUPH8BUMtyn1DirPtqKy8NFfO0AD1tGD8icaZGg5Hvt4Ny6m3QGxXA5rxMCk0Rqs2QYayfz3DKEnkUsElf9uu9FftZIWGuTv2hglrieJBt60v3sYRHWtTouHjpxu7qg+MXlfNkTETMnbTKwB2B6bjh1VLLm3Qzk9UfY8AbEayUV2QQcOipQFvSKsVNc+tZ4/TrDsta4GqXhTqsocMxI2PJo9dHfKEqmu16IsV0//kUOxz8RuMuN0f2OPAcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHlCXMjpD0mYUTS9DD5Rk/bTwEDtOA4/OqOBkOet4JA=;
 b=yQYk5dwhGA1TiFDfRxGNACJegkz2Whk/Dl8YR/YWBTC0PgI15l3H1e2e5/lt1rnvEBOEM6C6J1b6ynwReC3b73JpLYSPQAY38R0T2hF1JSlho2hx+XmeAoSm6gqtsqEOgr2RbR3nh07Xxb05o8MbPjViDLwmkvhDwq2zwwKSRs4=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by MN2PR12MB3392.namprd12.prod.outlook.com (2603:10b6:208:cb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 06:51:10 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 06:51:09 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: disable ras query and injection during gpu reset
Thread-Topic: [PATCH] drm/amdgpu: disable ras query and injection during gpu
 reset
Thread-Index: AdYCca+yLm66Szs8TCqzfYFWysHyiQ==
Date: Wed, 25 Mar 2020 06:51:09 +0000
Message-ID: <MN2PR12MB366349FEEF93758FA0BB32F6FBCE0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-25T06:51:07Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f1142338-ed98-4387-bbaf-0000a88a82b9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-25T06:51:07Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ae711e48-e9db-4c19-a284-000072eeacd4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20813e2f-633a-4fb9-90e2-08d7d088e6a5
x-ms-traffictypediagnostic: MN2PR12MB3392:|MN2PR12MB3392:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB33924CF3500F4FC06806420BFBCE0@MN2PR12MB3392.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(316002)(186003)(33656002)(71200400001)(64756008)(66476007)(86362001)(110136005)(66556008)(66946007)(66446008)(76116006)(26005)(6506007)(66616009)(478600001)(8676002)(55016002)(5660300002)(81156014)(6636002)(7696005)(2906002)(558084003)(52536014)(9686003)(81166006)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3392;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 99wcaMpyF7g2/YKVL9zpkBXhXSFh2HkurQVNC6qFzigzHT39F5NxmwKVVyqNdtGHR2F6s99PXHuKP+qQL/4l5/RhkKA8dBtatdvb0Trc6KZEIxkWwJ+7wcC/shTbFIUSiV8LAFVkMlWUHzZkHCUftwJ0SZSWHfavdaT2qC2CIzKKw8mFXzzaARsqmA12dQrkwexO2uYdFxXMNvkLEJGXjvNz1npaduN3malePbkOl/CzZmarVQxB7+eji6lZlmVVGATFrGwssRNBj9u/EaPvPgwblW5q5gRzU6Oh7+1Ast5tsgBTiwN+mEYWpc2hC9W0VPLXk2TFUoyvbFUSVdcCuXgeY8YtPOvYo6hGt4s93OLthx5PimdvNFVT0wUBLsV0StHX5omlrbOOFG7q7dFDqp338lA2FfusxgY+FqNf2jCi23lhRSJaySOBacdv5A9K
x-ms-exchange-antispam-messagedata: qpxZmVm7rF/GLk6GLoxaK3c+IfYIaUCwkuvR7OQO1iCCMxQ2LgtUJmi/CiZvhTiPT/vZVFHULk7vr5cuwXSa17WKOxgbxMTTvt7Ovx5pVMCJvJj2XTeWsRwi0y18Y/y1lQfIgwnA5z3Aqr85hQtb/Q==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB366349FEEF93758FA0BB32F6FBCE0MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20813e2f-633a-4fb9-90e2-08d7d088e6a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 06:51:09.9304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +M03dP3+YminEdW6+7bfdTtq+uzemi22wYWPNbWmLjWmgfn9ys725sI73e3lmM7QPDKHiKeIFC1w1ONXa/GfPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3392
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

--_004_MN2PR12MB366349FEEF93758FA0BB32F6FBCE0MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB366349FEEF93758FA0BB32F6FBCE0MN2PR12MB3663namp_"

--_000_MN2PR12MB366349FEEF93758FA0BB32F6FBCE0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to disable ras debugfs features during the entire GPU rese=
t cycle

--_000_MN2PR12MB366349FEEF93758FA0BB32F6FBCE0MN2PR12MB3663namp_
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
<p class=3D"MsoNormal">Submitting patch to disable ras debugfs features dur=
ing the entire GPU reset cycle<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB366349FEEF93758FA0BB32F6FBCE0MN2PR12MB3663namp_--

--_004_MN2PR12MB366349FEEF93758FA0BB32F6FBCE0MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-disable-ras-query-during-gpu-reset.patch"
Content-Description: 0001-drm-amdgpu-disable-ras-query-during-gpu-reset.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-disable-ras-query-during-gpu-reset.patch";
	size=4254; creation-date="Wed, 25 Mar 2020 06:50:00 GMT";
	modification-date="Wed, 25 Mar 2020 06:50:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyZjlkNWFlM2ZhMGI0MDkwMDlmZDAyOTU2ZDE1MTc0MWVkNTI0NTdhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgMjUgTWFyIDIwMjAgMTQ6NDM6NDQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBkaXNhYmxlIHJhcyBxdWVyeSBhbmQgaW5qZWN0aW9uIGR1cmluZyBncHUgcmVz
ZXQKCmFkZGVkIGZsYWcgdG8gcmFzIGNvbnRleHQgdG8gaW5kaWNhdGUgaWYgcmFzIHF1ZXJ5IGZ1
bmN0aW9uYWxpdHkgaXMgcmVhZHkKClNpZ25lZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4u
Y2xlbWVudHNAYW1kLmNvbT4KQ2hhbmdlLUlkOiBJNjc1NmQ1YjM4ZDMzOWY4ZGJlYmMyYzA3ZWJj
NTMwYzA0ZTExYTliZAotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyB8ICAzICsrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jICAg
IHwgMjQgKysrKysrKysrKysrKysrKysrKy0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5oICAgIHwgIDQgKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYwppbmRleCBlNTVkYmNkMThiOTUuLjEyNzY4NmM4ZTJiYyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtNDE2Nyw2ICs0MTY3LDggQEAgaW50
IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJ
bmVlZF9mdWxsX3Jlc2V0ID0gam9iX3NpZ25hbGVkID0gZmFsc2U7CiAJSU5JVF9MSVNUX0hFQUQo
JmRldmljZV9saXN0KTsKIAorCWFtZGdwdV9yYXNfc2V0X2Vycm9yX3F1ZXJ5X3JlYWR5KGFkZXYs
IGZhbHNlKTsKKwogCWRldl9pbmZvKGFkZXYtPmRldiwgIkdQVSAlcyBiZWdpbiFcbiIsCiAJCShp
bl9yYXNfaW50ciAmJiAhdXNlX2JhY28pID8gImpvYnMgc3RvcCI6InJlc2V0Iik7CiAKQEAgLTQy
MjMsNiArNDIyNSw3IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAogCS8qIGJsb2NrIGFsbCBzY2hlZHVsZXJzIGFuZCByZXNldCBnaXZl
biBqb2IncyByaW5nICovCiAJbGlzdF9mb3JfZWFjaF9lbnRyeSh0bXBfYWRldiwgZGV2aWNlX2xp
c3RfaGFuZGxlLCBnbWMueGdtaS5oZWFkKSB7CiAJCWlmICh0bXBfYWRldiAhPSBhZGV2KSB7CisJ
CQlhbWRncHVfcmFzX3NldF9lcnJvcl9xdWVyeV9yZWFkeSh0bXBfYWRldiwgZmFsc2UpOwogCQkJ
YW1kZ3B1X2RldmljZV9sb2NrX2FkZXYodG1wX2FkZXYsIGZhbHNlKTsKIAkJCWlmICghYW1kZ3B1
X3NyaW92X3ZmKHRtcF9hZGV2KSkKIAkJCSAgICAgICAgICAgICAgICBhbWRncHVfYW1ka2ZkX3By
ZV9yZXNldCh0bXBfYWRldik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMK
aW5kZXggM2MzMmE5NGQyNDI0Li45ZTllMGY3NzQ3YjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmFzLmMKQEAgLTgwLDYgKzgwLDIwIEBAIGF0b21pY190IGFtZGdwdV9yYXNf
aW5faW50ciA9IEFUT01JQ19JTklUKDApOwogc3RhdGljIGJvb2wgYW1kZ3B1X3Jhc19jaGVja19i
YWRfcGFnZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCQl1aW50NjRfdCBhZGRyKTsK
IAordm9pZCBhbWRncHVfcmFzX3NldF9lcnJvcl9xdWVyeV9yZWFkeShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgYm9vbCByZWFkeSkKK3sKKwlpZiAoYWRldikKKwkJYW1kZ3B1X3Jhc19nZXRf
Y29udGV4dChhZGV2KS0+ZXJyb3JfcXVlcnlfcmVhZHkgPSByZWFkeTsKK30KKworYm9vbCBhbWRn
cHVfcmFzX2dldF9lcnJvcl9xdWVyeV9yZWFkeShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
K3sKKwlpZiAoYWRldikKKwkJcmV0dXJuIGFtZGdwdV9yYXNfZ2V0X2NvbnRleHQoYWRldiktPmVy
cm9yX3F1ZXJ5X3JlYWR5OworCisJcmV0dXJuIGZhbHNlOworfQorCiBzdGF0aWMgc3NpemVfdCBh
bWRncHVfcmFzX2RlYnVnZnNfcmVhZChzdHJ1Y3QgZmlsZSAqZiwgY2hhciBfX3VzZXIgKmJ1ZiwK
IAkJCQkJc2l6ZV90IHNpemUsIGxvZmZfdCAqcG9zKQogewpAQCAtMjgxLDcgKzI5NSw3IEBAIHN0
YXRpYyBzc2l6ZV90IGFtZGdwdV9yYXNfZGVidWdmc19jdHJsX3dyaXRlKHN0cnVjdCBmaWxlICpm
LCBjb25zdCBjaGFyIF9fdXNlciAqCiAJc3RydWN0IHJhc19kZWJ1Z19pZiBkYXRhOwogCWludCBy
ZXQgPSAwOwogCi0JaWYgKGFtZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQoKSkgeworCWlmICghYW1k
Z3B1X3Jhc19nZXRfZXJyb3JfcXVlcnlfcmVhZHkoYWRldikpIHsKIAkJRFJNX1dBUk4oIlJBUyBX
QVJOOiBlcnJvciBpbmplY3Rpb24gY3VycmVudGx5IGluYWNjZXNzaWJsZVxuIik7CiAJCXJldHVy
biBzaXplOwogCX0KQEAgLTM5OSw3ICs0MTMsNyBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfcmFz
X3N5c2ZzX3JlYWQoc3RydWN0IGRldmljZSAqZGV2LAogCQkuaGVhZCA9IG9iai0+aGVhZCwKIAl9
OwogCi0JaWYgKGFtZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQoKSkKKwlpZiAoIWFtZGdwdV9yYXNf
Z2V0X2Vycm9yX3F1ZXJ5X3JlYWR5KG9iai0+YWRldikpCiAJCXJldHVybiBzbnByaW50ZihidWYs
IFBBR0VfU0laRSwKIAkJCQkiUXVlcnkgY3VycmVudGx5IGluYWNjZXNzaWJsZVxuIik7CiAKQEAg
LTE4ODYsOCArMTkwMCwxMCBAQCBpbnQgYW1kZ3B1X3Jhc19sYXRlX2luaXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCiAJfQogCiAJLyogaW4gcmVzdW1lIHBoYXNlLCBubyBuZWVkIHRvIGNy
ZWF0ZSByYXMgZnMgbm9kZSAqLwotCWlmIChhZGV2LT5pbl9zdXNwZW5kIHx8IGFkZXYtPmluX2dw
dV9yZXNldCkKKwlpZiAoYWRldi0+aW5fc3VzcGVuZCB8fCBhZGV2LT5pbl9ncHVfcmVzZXQpIHsK
KwkJYW1kZ3B1X3Jhc19zZXRfZXJyb3JfcXVlcnlfcmVhZHkoYWRldiwgdHJ1ZSk7CiAJCXJldHVy
biAwOworCX0KIAogCWlmIChpaF9pbmZvLT5jYikgewogCQlyID0gYW1kZ3B1X3Jhc19pbnRlcnJ1
cHRfYWRkX2hhbmRsZXIoYWRldiwgaWhfaW5mbyk7CkBAIC0xODk5LDYgKzE5MTUsOCBAQCBpbnQg
YW1kZ3B1X3Jhc19sYXRlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJaWYgKHIp
CiAJCWdvdG8gc3lzZnM7CiAKKwlhbWRncHVfcmFzX3NldF9lcnJvcl9xdWVyeV9yZWFkeShhZGV2
LCB0cnVlKTsKKwogCXJldHVybiAwOwogY2xlYW51cDoKIAlhbWRncHVfcmFzX3N5c2ZzX3JlbW92
ZShhZGV2LCByYXNfYmxvY2spOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5o
CmluZGV4IDU1YzNlY2ViMzkwZC4uZTdkZjVkODQyOWY4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhcy5oCkBAIC0zMzQsNiArMzM0LDggQEAgc3RydWN0IGFtZGdwdV9yYXMg
ewogCXVpbnQzMl90IGZsYWdzOwogCWJvb2wgcmVib290OwogCXN0cnVjdCBhbWRncHVfcmFzX2Vl
cHJvbV9jb250cm9sIGVlcHJvbV9jb250cm9sOworCisJYm9vbCBlcnJvcl9xdWVyeV9yZWFkeTsK
IH07CiAKIHN0cnVjdCByYXNfZnNfZGF0YSB7CkBAIC02MjksNCArNjMxLDYgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGFtZGdwdV9yYXNfaW50cl9jbGVhcmVkKHZvaWQpCiAKIHZvaWQgYW1kZ3B1X3Jh
c19nbG9iYWxfcmFzX2lzcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiAKK3ZvaWQgYW1k
Z3B1X3Jhc19zZXRfZXJyb3JfcXVlcnlfcmVhZHkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IGJvb2wgcmVhZHkpOworCiAjZW5kaWYKLS0gCjIuMTcuMQoK

--_004_MN2PR12MB366349FEEF93758FA0BB32F6FBCE0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB366349FEEF93758FA0BB32F6FBCE0MN2PR12MB3663namp_--
