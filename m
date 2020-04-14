Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B37C2BBFD
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 07:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412F8208E0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 07:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O0P8FB0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412F8208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0860F6E459;
	Tue, 14 Apr 2020 07:06:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1EA6E459
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 07:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGh2/yczcHyM9qwpCHJUDq0UA59zAaMyVub2FMGXIBlDJUWdspIJClJ5Z9qgmDt1z93O7gOhSbjOvJSdB3rIMtmk9Lh9ERGdKs90TSF80+1Sl6HmzYzqZcQWp0v100B+zNEgsaHKPj8ZGqGNEN+Sp/6H8CEvQ4qMhNjL6TtRBaDKko4aKsd2qONAG/qzh9cTRCKkWpOdOedpli3QDLsrp7Kj9moZwyjBUPUXntZJohuMA7ISTEBjdysrcjlMjHzJ1sHVB6km9K8AFelEE3pIm8Fjb5V9SRchtrtsI5deMtqFQF5Mdv8YRn/n+793yCF0xPU/DzMGj5cOPAK0FtOWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf+TVg+EaQa9RoxwwNX5Qay41K4guEikmXcKpbKFSV4=;
 b=ZM4EmeV6yuQedr71vZH2HEOFI5LMw+eJXm7BxVhGNZnMpIm+J99LRIYlJ0U7wRlgK6LkJ4Z3d9iPqLrkEPH6+Ew2SngEXfWoOQ2xiOt9ZYrLIf6A243d7yQrPRdWiof4hnLJEM6IIQO64F/BsJeXY1kG6gJzz4YInUbnW7em3WAS5ZM/HyyOQsc6Q/nF1Ps9GEWlB2jwUkOMh8lHYqK+tPjtAgXYP1eZ57wEsyR9mKE3TMKs47NkpQBR1IooWJp5FWtJIC2UjohaVzolFzvSnq2QOEoca3Z49Rk/0ut5PBcnd8gDrkYTWVCuXnsBa1m4pTJhdZLaXX1xTBM8RYbefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf+TVg+EaQa9RoxwwNX5Qay41K4guEikmXcKpbKFSV4=;
 b=O0P8FB0z75ufcim4ZK7Sqgzbfwks+yRA5/Lcf6pJeP4QD237PLVOolOjTxdh1LMqVDol0Kv7gdb2Zou0ubjfIQMB/l+UDMXNxJN7UwF/rrpYUH3LBel/8bLclADEqCU4hEafCM4j8ipxz0WXZNT5eplnhS1G3VsKpUmmqJTyoXM=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB3519.namprd12.prod.outlook.com (2603:10b6:208:107::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16; Tue, 14 Apr
 2020 07:06:14 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265%3]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 07:06:14 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] series to refactor psp np fw loading
Thread-Topic: [PATCH] series to refactor psp np fw loading
Thread-Index: AdYSKyW3wSp/rB5lSkSFu9kz/7eu5A==
Date: Tue, 14 Apr 2020 07:06:14 +0000
Message-ID: <MN2PR12MB4032D3C0EC3E363471268799FBDA0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T07:06:10Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2bca3f23-3bab-4646-920e-0000b1718afc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-14T07:06:10Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a548f9cd-f3d7-4d0c-8125-0000362b2b96
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed99a8e5-dbbf-40f9-f495-08d7e04251d7
x-ms-traffictypediagnostic: MN2PR12MB3519:|MN2PR12MB3519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3519FD53B31D236B16394F8DFBDA0@MN2PR12MB3519.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(66446008)(2906002)(186003)(86362001)(52536014)(55016002)(6506007)(66556008)(316002)(99936003)(9686003)(558084003)(66946007)(66476007)(110136005)(7696005)(76116006)(66576008)(26005)(64756008)(6636002)(71200400001)(478600001)(8936002)(33656002)(81156014)(5660300002)(8676002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Rq3zYkrRzHFr+NRnH8gqH0vVP50s46MqkuU802yS3Dzuce6ICK2pGsqsB6gUBTS8+ZrtHObSh3fYmipi3K+coOOgdKcoUGed9BYO/ot0h+sKGvpiybootx3tZrE51fft65KZbzOHmD5D9GJFpLIxAhdkNslIapKBYutY0+So04aYaK946elmvAOF66UreZuCVLQdjb5wkDj2tPrYRh2PekMqxNgtcUYMuUcX/mPvmGQ7Mq/g60eY01lshHbDpcRuhJtZIdQIm3ol12L/PnC3bnrEKO7SFcibXtjPGC0Fsy/rNdzHqRl7CVqbo9qsu+ddyvD7/HoqRwro0esFWL++kkHMANYjDRwKpPY70qZo139czayLCSkYPOn5/bxOkub/kezwDXfXgeibN6qhxdjL9NkgrgXeoKlWfITtK1Y1fd1awXxurYBuoriOK3tA5rn
x-ms-exchange-antispam-messagedata: jSumkahD3/T+FaXj7l5cQ2na0xpZwU6ek/ikuJj8T3W+2Oh9zPnV+tXlaMYdt81a96hEWLRLp8zeppplWPMMu1yocqFZZ21JTgAtJ2e/ttssJhmvnEm9cisv4rzJvdzZtgJWzQnhp0OHeQf9fgLrjA==
Content-Type: multipart/mixed;
 boundary="_005_MN2PR12MB4032D3C0EC3E363471268799FBDA0MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed99a8e5-dbbf-40f9-f495-08d7e04251d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 07:06:14.0615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utMS28q4APxsorJKg/GJ2NEFg8jspIvie3QUJUiTWjSgIf6bQ7+KH/PuqMoR87M2UMHO4wtBROGniVLsN4iUsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3519
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

--_005_MN2PR12MB4032D3C0EC3E363471268799FBDA0MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032D3C0EC3E363471268799FBDA0MN2PR12MB4032namp_"

--_000_MN2PR12MB4032D3C0EC3E363471268799FBDA0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch series to refactor psp np fw loading sequence and set MP1 =
state to unload in preparation for SMU FW loading during a GPU reset

Thank you,
John Clements

--_000_MN2PR12MB4032D3C0EC3E363471268799FBDA0MN2PR12MB4032namp_
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
<p class=3D"MsoNormal">Submitting patch series to refactor psp np fw loadin=
g sequence and set MP1 state to unload in preparation for SMU FW loading du=
ring a GPU reset<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032D3C0EC3E363471268799FBDA0MN2PR12MB4032namp_--

--_005_MN2PR12MB4032D3C0EC3E363471268799FBDA0MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-update-psp-fw-loading-sequence.patch"
Content-Description: 0001-drm-amdgpu-update-psp-fw-loading-sequence.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-update-psp-fw-loading-sequence.patch"; size=6191;
	creation-date="Tue, 14 Apr 2020 07:04:00 GMT";
	modification-date="Tue, 14 Apr 2020 07:04:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmY2I4ZWY2YWMyNzg5ZjNhNTY2ZGE0N2VmMzk5MzgxMTI3MWJiMmE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMTQgQXByIDIwMjAgMTQ6MzI6MDEgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gZHJtL2FtZGdwdTogdXBkYXRlIHBzcCBmdyBsb2FkaW5nIHNlcXVlbmNlCgpBZGRlZCBkZWRp
Y2F0ZWQgZnVuY3Rpb24gdG8gY2hlY2sgaWYgcGFydGljdWxhcgpmdyBzaG91bGQgYmUgc2tpcHBl
ZCBmcm9tIGxvYWRpbmcuCgpBZGRlZCBkZWRpY2F0ZWQgZnVuY3Rpb24gZm9yIFNNVSBGVyBsb2Fk
aW5nIHZpYSBQU1AKClNpZ25lZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVudHNA
YW1kLmNvbT4KQ2hhbmdlLUlkOiBJMzBiNWVmMmU1N2Q0OGM3MTA3ZDk2YzJjM2U3ZjhjYjY2N2Vl
YzBlNQotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDEyNiAr
KysrKysrKysrKysrKystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCsp
LCA0OSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMK
aW5kZXggODgxNzQwYzBmZWZjLi44ZDFjOTFiM2Q1NGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMKQEAgLTQyLDYgKzQyLDggQEAgc3RhdGljIHZvaWQgcHNwX3NldF9m
dW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiBzdGF0aWMgaW50IHBzcF9zeXNmc19p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKIHN0YXRpYyB2b2lkIHBzcF9zeXNmc19m
aW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKIAorc3RhdGljIGludCBwc3BfbG9hZF9z
bXVfZncoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApOworCiAvKgogICogRHVlIHRvIERGIENzdGF0
ZSBtYW5hZ2VtZW50IGNlbnRyYWxpemVkIHRvIFBNRlcsIHRoZSBmaXJtd2FyZQogICogbG9hZGlu
ZyBzZXF1ZW5jZSB3aWxsIGJlIHVwZGF0ZWQgYXMgYmVsb3c6CkBAIC0xMTc1LDE2ICsxMTc3LDIw
IEBAIHN0YXRpYyBpbnQgcHNwX2h3X3N0YXJ0KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCX0K
IAogCS8qCi0JICogRm9yIHRob3NlIEFTSUNzIHdpdGggREYgQ3N0YXRlIG1hbmFnZW1lbnQgY2Vu
dHJhbGl6ZWQKKwkgKiBGb3IgQVNJQ3Mgd2l0aCBERiBDc3RhdGUgbWFuYWdlbWVudCBjZW50cmFs
aXplZAogCSAqIHRvIFBNRlcsIFRNUiBzZXR1cCBzaG91bGQgYmUgcGVyZm9ybWVkIGFmdGVyIFBN
RlcKIAkgKiBsb2FkZWQgYW5kIGJlZm9yZSBvdGhlciBub24tcHNwIGZpcm13YXJlIGxvYWRlZC4K
IAkgKi8KLQlpZiAoIXBzcC0+cG1md19jZW50cmFsaXplZF9jc3RhdGVfbWFuYWdlbWVudCkgewot
CQlyZXQgPSBwc3BfdG1yX2xvYWQocHNwKTsKLQkJaWYgKHJldCkgewotCQkJRFJNX0VSUk9SKCJQ
U1AgbG9hZCB0bXIgZmFpbGVkIVxuIik7CisJaWYgKHBzcC0+cG1md19jZW50cmFsaXplZF9jc3Rh
dGVfbWFuYWdlbWVudCkgeworCQlyZXQgPSBwc3BfbG9hZF9zbXVfZncocHNwKTsKKwkJaWYgKHJl
dCkKIAkJCXJldHVybiByZXQ7Ci0JCX0KKwl9CisKKwlyZXQgPSBwc3BfdG1yX2xvYWQocHNwKTsK
KwlpZiAocmV0KSB7CisJCURSTV9FUlJPUigiUFNQIGxvYWQgdG1yIGZhaWxlZCFcbiIpOworCQly
ZXR1cm4gcmV0OwogCX0KIAogCXJldHVybiAwOwpAQCAtMTM2MSw3ICsxMzY3LDcgQEAgc3RhdGlj
IGludCBwc3BfcHJlcF9sb2FkX2lwX2Z3X2NtZF9idWYoc3RydWN0IGFtZGdwdV9maXJtd2FyZV9p
bmZvICp1Y29kZSwKIH0KIAogc3RhdGljIGludCBwc3BfZXhlY3V0ZV9ucF9md19sb2FkKHN0cnVj
dCBwc3BfY29udGV4dCAqcHNwLAotCQkJICAgICAgIHN0cnVjdCBhbWRncHVfZmlybXdhcmVfaW5m
byAqdWNvZGUpCisJCQkgICAgICAgICAgc3RydWN0IGFtZGdwdV9maXJtd2FyZV9pbmZvICp1Y29k
ZSkKIHsKIAlpbnQgcmV0ID0gMDsKIApAQCAtMTM3NSw2NCArMTM4MSw4NiBAQCBzdGF0aWMgaW50
IHBzcF9leGVjdXRlX25wX2Z3X2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsCiAJcmV0dXJu
IHJldDsKIH0KIAorc3RhdGljIGludCBwc3BfbG9hZF9zbXVfZncoc3RydWN0IHBzcF9jb250ZXh0
ICpwc3ApCit7CisJaW50IHJldDsKKwlzdHJ1Y3QgYW1kZ3B1X2Zpcm13YXJlX2luZm8gKnVjb2Rl
ID0KKwkJCSZwc3AtPmFkZXYtPmZpcm13YXJlLnVjb2RlW0FNREdQVV9VQ09ERV9JRF9TTUNdOwor
CisJaWYgKCF1Y29kZS0+ZncgfHwgYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikpCisJCXJldHVy
biAwOworCisJcmV0ID0gcHNwX2V4ZWN1dGVfbnBfZndfbG9hZChwc3AsIHVjb2RlKTsKKworCWlm
IChyZXQpCisJCURSTV9FUlJPUigiUFNQIGxvYWQgc211IGZhaWxlZCFcbiIpOworCisJcmV0dXJu
IHJldDsKK30KKworc3RhdGljIGJvb2wgZndfbG9hZF9za2lwX2NoZWNrKHN0cnVjdCBwc3BfY29u
dGV4dCAqcHNwLAorCQkJICAgICAgIHN0cnVjdCBhbWRncHVfZmlybXdhcmVfaW5mbyAqdWNvZGUp
Cit7CisJaWYgKCF1Y29kZS0+ZncpCisJCXJldHVybiB0cnVlOworCisJaWYgKHVjb2RlLT51Y29k
ZV9pZCA9PSBBTURHUFVfVUNPREVfSURfU01DICYmCisJICAgIChwc3Bfc211X3JlbG9hZF9xdWly
ayhwc3ApIHx8CisJICAgICBwc3AtPmF1dG9sb2FkX3N1cHBvcnRlZCB8fAorCSAgICAgcHNwLT5w
bWZ3X2NlbnRyYWxpemVkX2NzdGF0ZV9tYW5hZ2VtZW50KSkKKwkJcmV0dXJuIHRydWU7CisKKwlp
ZiAoYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikgJiYKKwkgICAodWNvZGUtPnVjb2RlX2lkID09
IEFNREdQVV9VQ09ERV9JRF9TRE1BMAorCSAgICB8fCB1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BV
X1VDT0RFX0lEX1NETUExCisJICAgIHx8IHVjb2RlLT51Y29kZV9pZCA9PSBBTURHUFVfVUNPREVf
SURfU0RNQTIKKwkgICAgfHwgdWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1B
MworCSAgICB8fCB1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX1NETUE0CisJICAg
IHx8IHVjb2RlLT51Y29kZV9pZCA9PSBBTURHUFVfVUNPREVfSURfU0RNQTUKKwkgICAgfHwgdWNv
ZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1BNgorCSAgICB8fCB1Y29kZS0+dWNv
ZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX1NETUE3CisJICAgIHx8IHVjb2RlLT51Y29kZV9pZCA9
PSBBTURHUFVfVUNPREVfSURfUkxDX0cKKwkgICAgfHwgdWNvZGUtPnVjb2RlX2lkID09IEFNREdQ
VV9VQ09ERV9JRF9STENfUkVTVE9SRV9MSVNUX0NOVEwKKwkgICAgfHwgdWNvZGUtPnVjb2RlX2lk
ID09IEFNREdQVV9VQ09ERV9JRF9STENfUkVTVE9SRV9MSVNUX0dQTV9NRU0KKwkgICAgfHwgdWNv
ZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9STENfUkVTVE9SRV9MSVNUX1NSTV9NRU0K
KwkgICAgfHwgdWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TTUMpKQorCQkvKnNr
aXAgdWNvZGUgbG9hZGluZyBpbiBTUklPViBWRiAqLworCQlyZXR1cm4gdHJ1ZTsKKworCWlmIChw
c3AtPmF1dG9sb2FkX3N1cHBvcnRlZCAmJgorCSAgICAodWNvZGUtPnVjb2RlX2lkID09IEFNREdQ
VV9VQ09ERV9JRF9DUF9NRUMxX0pUIHx8CisJICAgICB1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BV
X1VDT0RFX0lEX0NQX01FQzJfSlQpKQorCQkvKiBza2lwIG1lYyBKVCB3aGVuIGF1dG9sb2FkIGlz
IGVuYWJsZWQgKi8KKwkJcmV0dXJuIHRydWU7CisKKwlyZXR1cm4gZmFsc2U7Cit9CisKIHN0YXRp
YyBpbnQgcHNwX25wX2Z3X2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiB7CiAJaW50IGks
IHJldDsKIAlzdHJ1Y3QgYW1kZ3B1X2Zpcm13YXJlX2luZm8gKnVjb2RlOwogCXN0cnVjdCBhbWRn
cHVfZGV2aWNlKiBhZGV2ID0gcHNwLT5hZGV2OwogCi0JaWYgKHBzcC0+YXV0b2xvYWRfc3VwcG9y
dGVkIHx8Ci0JICAgIHBzcC0+cG1md19jZW50cmFsaXplZF9jc3RhdGVfbWFuYWdlbWVudCkgewot
CQl1Y29kZSA9ICZhZGV2LT5maXJtd2FyZS51Y29kZVtBTURHUFVfVUNPREVfSURfU01DXTsKLQkJ
aWYgKCF1Y29kZS0+ZncgfHwgYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQotCQkJZ290byBvdXQ7Ci0K
LQkJcmV0ID0gcHNwX2V4ZWN1dGVfbnBfZndfbG9hZChwc3AsIHVjb2RlKTsKKwlpZiAocHNwLT5h
dXRvbG9hZF9zdXBwb3J0ZWQgJiYKKwkgICAgIXBzcC0+cG1md19jZW50cmFsaXplZF9jc3RhdGVf
bWFuYWdlbWVudCkgeworCQlyZXQgPSBwc3BfbG9hZF9zbXVfZncocHNwKTsKIAkJaWYgKHJldCkK
IAkJCXJldHVybiByZXQ7CiAJfQogCi0JaWYgKHBzcC0+cG1md19jZW50cmFsaXplZF9jc3RhdGVf
bWFuYWdlbWVudCkgewotCQlyZXQgPSBwc3BfdG1yX2xvYWQocHNwKTsKLQkJaWYgKHJldCkgewot
CQkJRFJNX0VSUk9SKCJQU1AgbG9hZCB0bXIgZmFpbGVkIVxuIik7Ci0JCQlyZXR1cm4gcmV0Owot
CQl9Ci0JfQotCi1vdXQ6CiAJZm9yIChpID0gMDsgaSA8IGFkZXYtPmZpcm13YXJlLm1heF91Y29k
ZXM7IGkrKykgewogCQl1Y29kZSA9ICZhZGV2LT5maXJtd2FyZS51Y29kZVtpXTsKLQkJaWYgKCF1
Y29kZS0+ZncpCi0JCQljb250aW51ZTsKIAogCQlpZiAodWNvZGUtPnVjb2RlX2lkID09IEFNREdQ
VV9VQ09ERV9JRF9TTUMgJiYKLQkJICAgIChwc3Bfc211X3JlbG9hZF9xdWlyayhwc3ApIHx8Ci0J
CSAgICAgcHNwLT5hdXRvbG9hZF9zdXBwb3J0ZWQgfHwKLQkJICAgICBwc3AtPnBtZndfY2VudHJh
bGl6ZWRfY3N0YXRlX21hbmFnZW1lbnQpKQotCQkJY29udGludWU7Ci0KLQkJaWYgKGFtZGdwdV9z
cmlvdl92ZihhZGV2KSAmJgotCQkgICAodWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9J
RF9TRE1BMAotCQkgICAgfHwgdWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1B
MQotCQkgICAgfHwgdWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1BMgotCQkg
ICAgfHwgdWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1BMwotCQkgICAgfHwg
dWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1BNAotCQkgICAgfHwgdWNvZGUt
PnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1BNQotCQkgICAgfHwgdWNvZGUtPnVjb2Rl
X2lkID09IEFNREdQVV9VQ09ERV9JRF9TRE1BNgotCQkgICAgfHwgdWNvZGUtPnVjb2RlX2lkID09
IEFNREdQVV9VQ09ERV9JRF9TRE1BNwotICAgICAgICAgICAgICAgICAgICB8fCB1Y29kZS0+dWNv
ZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX1JMQ19HCi0JICAgICAgICAgICAgfHwgdWNvZGUtPnVj
b2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9STENfUkVTVE9SRV9MSVNUX0NOVEwKLQkgICAgICAg
ICAgICB8fCB1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX1JMQ19SRVNUT1JFX0xJ
U1RfR1BNX01FTQotCSAgICAgICAgICAgIHx8IHVjb2RlLT51Y29kZV9pZCA9PSBBTURHUFVfVUNP
REVfSURfUkxDX1JFU1RPUkVfTElTVF9TUk1fTUVNCi0JICAgICAgICAgICAgfHwgdWNvZGUtPnVj
b2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9TTUMpKQotCQkJLypza2lwIHVjb2RlIGxvYWRpbmcg
aW4gU1JJT1YgVkYgKi8KKwkJICAgICFmd19sb2FkX3NraXBfY2hlY2socHNwLCB1Y29kZSkpIHsK
KwkJCXJldCA9IHBzcF9sb2FkX3NtdV9mdyhwc3ApOworCQkJaWYgKHJldCkKKwkJCQlyZXR1cm4g
cmV0OwogCQkJY29udGludWU7CisJCX0KIAotCQlpZiAocHNwLT5hdXRvbG9hZF9zdXBwb3J0ZWQg
JiYKLQkJICAgICh1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX0NQX01FQzFfSlQg
fHwKLQkJICAgICB1Y29kZS0+dWNvZGVfaWQgPT0gQU1ER1BVX1VDT0RFX0lEX0NQX01FQzJfSlQp
KQotCQkJLyogc2tpcCBtZWMgSlQgd2hlbiBhdXRvbG9hZCBpcyBlbmFibGVkICovCisJCWlmIChm
d19sb2FkX3NraXBfY2hlY2socHNwLCB1Y29kZSkpCiAJCQljb250aW51ZTsKIAogCQlwc3BfcHJp
bnRfZndfaGRyKHBzcCwgdWNvZGUpOwotLSAKMi4xNy4xCgo=

--_005_MN2PR12MB4032D3C0EC3E363471268799FBDA0MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0002-drm-amdgpu-set-mp1-state-before-reload.patch"
Content-Description: 0002-drm-amdgpu-set-mp1-state-before-reload.patch
Content-Disposition: attachment;
	filename="0002-drm-amdgpu-set-mp1-state-before-reload.patch"; size=2085;
	creation-date="Tue, 14 Apr 2020 07:04:00 GMT";
	modification-date="Tue, 14 Apr 2020 07:04:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzMzcyYjk5MDJhZDllZTUyMDEwY2Y3N2ZlMjYxODY3ZjIwYmMzZTQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMTQgQXByIDIwMjAgMTU6MDA6MzggKzA4MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gZHJtL2FtZGdwdTogc2V0IG1wMSBzdGF0ZSBiZWZvcmUgcmVsb2FkCgpTZXQgTVAxIHN0YXRl
IHRvIHByZXBhcmUgZm9yIHVubG9hZCBiZWZvcmUgcmVsb2FkaW5nIFNNVSBGVwoKU2lnbmVkLW9m
Zi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IElh
ZTFlZmVmYmE3OWIwYjY0MmQ5NGFmNTRmMWJhODgxZGE3ZTBjMTU1Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jICAgfCAxMSArKysrKysrKysrLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMgfCAgNiAtLS0tLS0KIDIgZmlsZXMgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMKaW5kZXggOGQxYzkxYjNkNTRhLi44MDIwZjE4ZDU2OWQgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKQEAgLTEzODQsMTIgKzEzODQs
MjEgQEAgc3RhdGljIGludCBwc3BfZXhlY3V0ZV9ucF9md19sb2FkKHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwLAogc3RhdGljIGludCBwc3BfbG9hZF9zbXVfZncoc3RydWN0IHBzcF9jb250ZXh0ICpw
c3ApCiB7CiAJaW50IHJldDsKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSogYWRldiA9IHBzcC0+YWRl
djsKIAlzdHJ1Y3QgYW1kZ3B1X2Zpcm13YXJlX2luZm8gKnVjb2RlID0KLQkJCSZwc3AtPmFkZXYt
PmZpcm13YXJlLnVjb2RlW0FNREdQVV9VQ09ERV9JRF9TTUNdOworCQkJJmFkZXYtPmZpcm13YXJl
LnVjb2RlW0FNREdQVV9VQ09ERV9JRF9TTUNdOwogCiAJaWYgKCF1Y29kZS0+ZncgfHwgYW1kZ3B1
X3NyaW92X3ZmKHBzcC0+YWRldikpCiAJCXJldHVybiAwOwogCisKKwlpZiAoYWRldi0+aW5fZ3B1
X3Jlc2V0KSB7CisJCXJldCA9IGFtZGdwdV9kcG1fc2V0X21wMV9zdGF0ZShhZGV2LCBQUF9NUDFf
U1RBVEVfVU5MT0FEKTsKKwkJaWYgKHJldCkgeworCQkJRFJNX1dBUk4oIkZhaWxlZCB0byBzZXQg
TVAxIHN0YXRlIHByZXBhcmUgZm9yIHJlbG9hZFxuIik7CisJCX0KKwl9CisKIAlyZXQgPSBwc3Bf
ZXhlY3V0ZV9ucF9md19sb2FkKHBzcCwgdWNvZGUpOwogCiAJaWYgKHJldCkKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKaW5kZXggNjU1YmE0ZmIwNWRjLi41NDFjOTMy
YTYwMDUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFf
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCkBAIC0x
NzE4LDEyICsxNzE4LDYgQEAgaW50IHNtdV92MTFfMF9iYWNvX3NldF9zdGF0ZShzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwgZW51bSBzbXVfYmFjb19zdGF0ZSBzdGF0ZSkKIAkJaWYgKHJldCkKIAkJ
CWdvdG8gb3V0OwogCi0JCWlmIChyYXMgJiYgcmFzLT5zdXBwb3J0ZWQpIHsKLQkJCXJldCA9IHNt
dV9zZW5kX3NtY19tc2coc211LCBTTVVfTVNHX1ByZXBhcmVNcDFGb3JVbmxvYWQsIE5VTEwpOwot
CQkJaWYgKHJldCkKLQkJCQlnb3RvIG91dDsKLQkJfQotCiAJCS8qIGNsZWFyIHZiaW9zIHNjcmF0
Y2ggNiBhbmQgNyBmb3IgY29taW5nIGFzaWMgcmVpbml0ICovCiAJCVdSRUczMihhZGV2LT5iaW9z
X3NjcmF0Y2hfcmVnX29mZnNldCArIDYsIDApOwogCQlXUkVHMzIoYWRldi0+Ymlvc19zY3JhdGNo
X3JlZ19vZmZzZXQgKyA3LCAwKTsKLS0gCjIuMTcuMQoK

--_005_MN2PR12MB4032D3C0EC3E363471268799FBDA0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_005_MN2PR12MB4032D3C0EC3E363471268799FBDA0MN2PR12MB4032namp_--
