Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A449CC00523
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 07:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A56522314
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 07:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rDb9NmM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A56522314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 197656E191;
	Fri,  3 Jan 2020 07:29:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A2F6E191
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 07:29:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBiCwxcugzznUKfB1h9gN6jCCsiCIVtIhNpVCbAH6u8YEEjoEOWgndoDAV5OopqGmO3t641Oeihx8xLRycEqXypcCHjfDWMDWYsw8km2ZpvOnDyWV1AuQgZAcYz+WJkiz/37b66TckPNYshR9XXEIv0Nubx/Tqrrc909A89SkiWRGUCcfU5qKHUv/fAFsWzZJDqBDzy97509lAEy4evPVHgj6YOTg7W/HKiQOTAlW65O6QZfE2tq2mj/zM5Ke5QkAhCr1WtvKbn6Jo/iFLvYP8lniKBki+pOalp91NlNFS8ifOjDxTFMDOrg6J50RbV9Lt1qH7IlTrKRZ60Qepgiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHj85xzrrt7R+xEWTt9cIwY6YCr6+dM2PfEP4Lu2IS0=;
 b=eGw11+oXZj249h9jKEZhZ8Q8FDFGXOl4/IwCkk4fEf90gTmoL+WTuQwWGSX6h5b/DyI9AhFT3O15LzYReUd6vy1qpQyj+CSA1fEIrragRkg34em7zh6GgaheSJ1x9xb4lDOiGbd6guIw6DIFqSicT9jlw7pN8R3NL38M6QYWie/Q3qKVfDq/rA9c33Y9zLa4CASeiImqxSG6Slh8PLZu2Iy2qzBXaKpgOn+DVPM4i8z+3VIDsPWWM5Ard8QkHPxWaeSHE5CZzy8TzZdJLEyjy17130En29ACRTiY2yDKLx7+TU/MGbYVSsyQQk4EAzCNIlNvB+JDf+MfKP8axqYQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHj85xzrrt7R+xEWTt9cIwY6YCr6+dM2PfEP4Lu2IS0=;
 b=rDb9NmM+YWWbK6BS8mi9Jwuak68RHpKRn9F8ZcUbijb5sjbyQU6KnvLUNsKaYZtm30ASP82oPdm1/rKQo8Yjdkjn65NmQPDYwOhi9ZPyogLiZAfyB8QlcaNJIaDvEiCcyxMtpQLLpJDF1wQQjC5ePBdG6gYHxQ0yWGOXRvvUoPw=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3120.namprd12.prod.outlook.com (20.178.243.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Fri, 3 Jan 2020 07:29:23 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2581.013; Fri, 3 Jan 2020
 07:29:23 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: added function to wait for PSP BL availability
Thread-Topic: [PATCH] drm/amdgpu: added function to wait for PSP BL
 availability
Thread-Index: AdXCB2B4i8QiXMejQxS+NxSqo7Tfwg==
Date: Fri, 3 Jan 2020 07:29:23 +0000
Message-ID: <MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-03T07:29:18Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1e5af268-6c04-40c9-b21c-0000763fc5e8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-03T07:29:18Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0c49e5fc-cce5-429f-85d2-000099e8e1c6
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.235.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 596c2643-6083-45c7-983c-08d7901ea7e0
x-ms-traffictypediagnostic: MN2PR12MB3120:|MN2PR12MB3120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3120E480A8312CFCF794A06BFB230@MN2PR12MB3120.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(26005)(316002)(66556008)(66616009)(66476007)(66946007)(64756008)(186003)(33656002)(110136005)(66446008)(9686003)(55016002)(2906002)(76116006)(8676002)(81156014)(81166006)(8936002)(558084003)(71200400001)(52536014)(6506007)(478600001)(5660300002)(7696005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3120;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +09GXQ22Ic/3uqOvK5qkDJNQpLyunocjC1pVXCsh8DYdLHwR0U2eQW/2llZiZaA5ab5HFoNj4jtAg/PQNsDYDK1fjmhZGs8brQPqyW7zvnN+hA/9mgkcLvbCGLHnhR0+6XftkdLkJ8p1wIRoonDKUifs4U//KmOv69gpdT3QUhpC0iwfKdoxjr1a7eZhlfq+l84ef7jJdjEk4+Os8RoASuwCxz+8Iivd7OYbcJaT6JRoopRzrTxknkqREWHwRKIxfrqqhlL7vZp/kSMz3VvkaJ89SX+RXO3YLHlLWE5je5WXaZSuGveYbtREusBVUAKCxAK0+g272OAa2GMLhhlf01cpnrt7F+vR4TWzkk0NtyeDFwwR3BOHcYpC1H+L6ilp8BXBhZa6odtrddIzOXto6PgDDwh7T7a1WbtVbNn3pR3/5oD+9JTxtu73KgaaRQXA
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596c2643-6083-45c7-983c-08d7901ea7e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 07:29:23.4268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJEdxzqG+xdglu0arNr1SwDCfvbWE12gKtvDZBprrsR4R2ZgU0TEdKQmU2aiqzjhejgXlru9nc3W7A2coWy2nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3120
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

--_004_MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230MN2PR12MB3663namp_"

--_000_MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Added dedicated function to wait for PSP BL availability.

Increased driver wait time for PSP BL availability.

Thank you,
John Clements

--_000_MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230MN2PR12MB3663namp_
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
<p class=3D"MsoNormal">Added dedicated function to wait for PSP BL availabi=
lity.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Increased driver wait time for PSP BL availability.<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230MN2PR12MB3663namp_--

--_004_MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-added-function-to-wait-for-PSP-BL-availab.patch"
Content-Description:  0001-drm-amdgpu-added-function-to-wait-for-PSP-BL-availab.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-added-function-to-wait-for-PSP-BL-availab.patch";
	size=3488; creation-date="Fri, 03 Jan 2020 07:28:00 GMT";
	modification-date="Fri, 03 Jan 2020 07:28:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxZmRjZmMwYzliNTMxYWFiYjBlMDRjZWUwODdlNDhjMWQxMDI4YTU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgMyBKYW4gMjAyMCAxNTowMzo1NSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IGFkZGVkIGZ1bmN0aW9uIHRvIHdhaXQgZm9yIFBTUCBCTCBhdmFpbGFiaWxpdHkK
CnJlZHVjZWQgZHVwbGljYXRlIGNvZGUKCmluY3JlYXNlZCB3YWl0IHRpbWUgZm9yIFBTUCBCTCBy
ZWFkaW5lc3MKCkNoYW5nZS1JZDogSTI1MGIyNzFmYzU1MGZmMTgyNGFhYzRjZmYzYTY0YmY3NGVh
YmRkNjQKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jIHwgNTIgKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAy
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9w
c3BfdjExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jCmluZGV4
IGM2NmNhOGNjMmViZC4uMmQyZDljNjVhNGRjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9wc3BfdjExXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9w
c3BfdjExXzAuYwpAQCAtMjMzLDYgKzIzMywzMCBAQCBzdGF0aWMgaW50IHBzcF92MTFfMF9pbml0
X21pY3JvY29kZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAlyZXR1cm4gZXJyOwogfQogCitp
bnQgcHNwX3YxMV8wX3dhaXRfZm9yX2Jvb3Rsb2FkZXIoc3RydWN0IHBzcF9jb250ZXh0ICpwc3Ap
Cit7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBwc3AtPmFkZXY7CisKKwlpbnQgcmV0
OworCWludCByZXRyeV9sb29wOworCisJZm9yIChyZXRyeV9sb29wID0gMDsgcmV0cnlfbG9vcCA8
IDEwOyByZXRyeV9sb29wKyspCisJeworCQkvKiBXYWl0IGZvciBib290bG9hZGVyIHRvIHNpZ25p
ZnkgdGhhdCBpcworCQkgICAgcmVhZHkgaGF2aW5nIGJpdCAzMSBvZiBDMlBNU0dfMzUgc2V0IHRv
IDEgKi8KKwkJcmV0ID0gcHNwX3dhaXRfZm9yKHBzcCwKKwkJCQkgICBTT0MxNV9SRUdfT0ZGU0VU
KE1QMCwgMCwgbW1NUDBfU01OX0MyUE1TR18zNSksCisJCQkJICAgMHg4MDAwMDAwMCwKKwkJCQkg
ICAweDgwMDAwMDAwLAorCQkJCSAgIGZhbHNlKTsKKworCQlpZiAocmV0ID09IDApCisJCQlyZXR1
cm4gMDsKKwl9CisKKwlyZXR1cm4gcmV0OworfQorCiBzdGF0aWMgYm9vbCBwc3BfdjExXzBfaXNf
c29zX2FsaXZlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogewogCXN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gcHNwLT5hZGV2OwpAQCAtMjU4LDkgKzI4Miw3IEBAIHN0YXRpYyBpbnQgcHNw
X3YxMV8wX2Jvb3Rsb2FkZXJfbG9hZF9rZGIoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJCXJl
dHVybiAwOwogCX0KIAotCS8qIFdhaXQgZm9yIGJvb3Rsb2FkZXIgdG8gc2lnbmlmeSB0aGF0IGlz
IHJlYWR5IGhhdmluZyBiaXQgMzEgb2YgQzJQTVNHXzM1IHNldCB0byAxICovCi0JcmV0ID0gcHNw
X3dhaXRfZm9yKHBzcCwgU09DMTVfUkVHX09GRlNFVChNUDAsIDAsIG1tTVAwX1NNTl9DMlBNU0df
MzUpLAotCQkJICAgMHg4MDAwMDAwMCwgMHg4MDAwMDAwMCwgZmFsc2UpOworCXJldCA9IHBzcF92
MTFfMF93YWl0X2Zvcl9ib290bG9hZGVyKHBzcCk7CiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsK
IApAQCAtMjc2LDkgKzI5OCw3IEBAIHN0YXRpYyBpbnQgcHNwX3YxMV8wX2Jvb3Rsb2FkZXJfbG9h
ZF9rZGIoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJV1JFRzMyX1NPQzE1KE1QMCwgMCwgbW1N
UDBfU01OX0MyUE1TR18zNSwKIAkgICAgICAgcHNwX2dmeGRydl9jb21tYW5kX3JlZyk7CiAKLQkv
KiBXYWl0IGZvciBib290bG9hZGVyIHRvIHNpZ25pZnkgdGhhdCBpcyByZWFkeSBoYXZpbmcgIGJp
dCAzMSBvZiBDMlBNU0dfMzUgc2V0IHRvIDEqLwotCXJldCA9IHBzcF93YWl0X2Zvcihwc3AsIFNP
QzE1X1JFR19PRkZTRVQoTVAwLCAwLCBtbU1QMF9TTU5fQzJQTVNHXzM1KSwKLQkJCSAgIDB4ODAw
MDAwMDAsIDB4ODAwMDAwMDAsIGZhbHNlKTsKKwlyZXQgPSBwc3BfdjExXzBfd2FpdF9mb3JfYm9v
dGxvYWRlcihwc3ApOwogCiAJcmV0dXJuIHJldDsKIH0KQEAgLTI5OCw5ICszMTgsNyBAQCBzdGF0
aWMgaW50IHBzcF92MTFfMF9ib290bG9hZGVyX2xvYWRfc3lzZHJ2KHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwKQogCQlyZXR1cm4gMDsKIAl9CiAKLQkvKiBXYWl0IGZvciBib290bG9hZGVyIHRvIHNp
Z25pZnkgdGhhdCBpcyByZWFkeSBoYXZpbmcgYml0IDMxIG9mIEMyUE1TR18zNSBzZXQgdG8gMSAq
LwotCXJldCA9IHBzcF93YWl0X2Zvcihwc3AsIFNPQzE1X1JFR19PRkZTRVQoTVAwLCAwLCBtbU1Q
MF9TTU5fQzJQTVNHXzM1KSwKLQkJCSAgIDB4ODAwMDAwMDAsIDB4ODAwMDAwMDAsIGZhbHNlKTsK
KwlyZXQgPSBwc3BfdjExXzBfd2FpdF9mb3JfYm9vdGxvYWRlcihwc3ApOwogCWlmIChyZXQpCiAJ
CXJldHVybiByZXQ7CiAKQEAgLTMxNiwxMSArMzM0LDcgQEAgc3RhdGljIGludCBwc3BfdjExXzBf
Ym9vdGxvYWRlcl9sb2FkX3N5c2RydihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIAlXUkVHMzJf
U09DMTUoTVAwLCAwLCBtbU1QMF9TTU5fQzJQTVNHXzM1LAogCSAgICAgICBwc3BfZ2Z4ZHJ2X2Nv
bW1hbmRfcmVnKTsKIAotCS8qIHRoZXJlIG1pZ2h0IGJlIGhhbmRzaGFrZSBpc3N1ZSB3aXRoIGhh
cmR3YXJlIHdoaWNoIG5lZWRzIGRlbGF5ICovCi0JbWRlbGF5KDIwKTsKLQotCXJldCA9IHBzcF93
YWl0X2Zvcihwc3AsIFNPQzE1X1JFR19PRkZTRVQoTVAwLCAwLCBtbU1QMF9TTU5fQzJQTVNHXzM1
KSwKLQkJCSAgIDB4ODAwMDAwMDAsIDB4ODAwMDAwMDAsIGZhbHNlKTsKKwlyZXQgPSBwc3BfdjEx
XzBfd2FpdF9mb3JfYm9vdGxvYWRlcihwc3ApOwogCiAJcmV0dXJuIHJldDsKIH0KQEAgLTMzNyw5
ICszNTEsNyBAQCBzdGF0aWMgaW50IHBzcF92MTFfMF9ib290bG9hZGVyX2xvYWRfc29zKHN0cnVj
dCBwc3BfY29udGV4dCAqcHNwKQogCWlmIChwc3BfdjExXzBfaXNfc29zX2FsaXZlKHBzcCkpCiAJ
CXJldHVybiAwOwogCi0JLyogV2FpdCBmb3IgYm9vdGxvYWRlciB0byBzaWduaWZ5IHRoYXQgaXMg
cmVhZHkgaGF2aW5nIGJpdCAzMSBvZiBDMlBNU0dfMzUgc2V0IHRvIDEgKi8KLQlyZXQgPSBwc3Bf
d2FpdF9mb3IocHNwLCBTT0MxNV9SRUdfT0ZGU0VUKE1QMCwgMCwgbW1NUDBfU01OX0MyUE1TR18z
NSksCi0JCQkgICAweDgwMDAwMDAwLCAweDgwMDAwMDAwLCBmYWxzZSk7CisJcmV0ID0gcHNwX3Yx
MV8wX3dhaXRfZm9yX2Jvb3Rsb2FkZXIocHNwKTsKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0Owot
LSAKMi4xNy4xCgo=

--_004_MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB3663D94776EF0BDDD1AAFCD4FB230MN2PR12MB3663namp_--
