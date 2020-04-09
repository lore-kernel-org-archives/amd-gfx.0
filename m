Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D24C2D0EA
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 07:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D612075E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 07:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YH+ajP1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D612075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B2AD6EB76;
	Thu,  9 Apr 2020 07:36:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5FF76EB76
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 07:36:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIw4W1cL0Z87pb1un5SFdhwsQcLYkIIdwywxPQhghTjlMPxwFqjSMJ9AJpgQcLxaJ4QU+hV/KDnJy5m9YxZN8wyZM7C5hvYXFEZen0/+P2W1vlbQsLV2pFjOpV02jrv+a21w8HQqkaC6MMR1F+lWA5tmv2tW2DLK7/zp9gSke++kqcSfdIKUpkNrCKp1Gcq2lsl0JzIr1rji7UQUYPS6tEFFfQaQi5DsyRVJPOmbTANsNx2tJl3OqjzX6bahHY59cnIprzUTN3+8o3KIPANtl+goMHQiHWBRvM8B0Kz3UwL95LC5R1N1b0N97YWkonNW2B8bMDjAw6e6IrelmKFncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2weKtyr73j/qAYiDlo4XQj+FbOBwM7aEAxTdAfrQoMw=;
 b=cMprWiI0RXif2VvPlk7i1B1bEaNeqmERzh32UJ9Y6tRX5jaHgLaB2Xk9eJsmxoLgoWgp9qgEBC7bvcXQttoTR2YxiHVenfhdgT0Vr2PQalO3ODYef8q/V9g09VqmhdQi7onb1qbaZy9Tq+uc0Lt/gO9N/IEm3SYYNUaEyKi0cexW6d/e2AGpUXONHWm5osL7oxNSlq8V6oX6ZOhg+zZZX6dwlx0IrtXUInvx77CbkswbP49JZH/jYjhF6lG7xya/baz4u0XaGy6YAJPEHfMpbOPxJVreYyFgtncJFqjMx4JuB4ypfuTGsZ0CNqddK07N9s4tdrMrzLH3IEt1KVj2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2weKtyr73j/qAYiDlo4XQj+FbOBwM7aEAxTdAfrQoMw=;
 b=YH+ajP1QBhZiYZUHnt0L5kCNPZbfgx+wTDXWV5RwxxYn5fjU6jTwsx1T+6dhQzB+I+kWme7MZEdiwG09V9jGglIomotykaIJ4U03PlraVWfVgH5xcGQewzNSOqtg5mUTOLMmDyLJgAtXN3qBGCHrP6tvg1OfJ8TlC2xnSwk5pkU=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 9 Apr
 2020 07:35:59 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::51c:c7d9:bfb6:1265%3]) with mapi id 15.20.2878.023; Thu, 9 Apr 2020
 07:35:59 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: increased atom cmd timeout
Thread-Topic: [PATCH] drm/amdgpu: increased atom cmd timeout
Thread-Index: AdYOQUS7RlEBuEB3RsWb6izfGut1iwAAC3IA
Date: Thu, 9 Apr 2020 07:35:59 +0000
Message-ID: <MN2PR12MB40321A470DEC718A2B8571A9FBC10@MN2PR12MB4032.namprd12.prod.outlook.com>
References: <MN2PR12MB403254AA3427896F5E99F3DBFBC10@MN2PR12MB4032.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB403254AA3427896F5E99F3DBFBC10@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-09T07:34:43Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=22851874-540e-4d28-9204-0000dd2bf020;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-09T07:35:56Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: dc1adb4a-164d-438f-9bc8-0000a544849c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01698924-a4a1-482e-09a4-08d7dc58a5df
x-ms-traffictypediagnostic: MN2PR12MB4454:|MN2PR12MB4454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4454C0403D1965E864CFBAFEFBC10@MN2PR12MB4454.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(8676002)(2906002)(110136005)(7696005)(81156014)(316002)(2940100002)(86362001)(8936002)(76116006)(4744005)(64756008)(26005)(6506007)(66946007)(53546011)(186003)(66446008)(71200400001)(66476007)(478600001)(55016002)(9686003)(81166007)(66556008)(99936003)(52536014)(66616009)(6636002)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TlNMMDSY02sVIhNPK5SBg7SPeMy2qspgHqBixDiV0il+jOOZuBBosrRCHIV42eI2le4reODtKEQRcPnFzxM9zt1wNt5zp16gMndRZClo5ibm+p2ozHOuWlIDTDbtJPoeORhE4Ck72Mfynm7oP/8BhdnQGZM7tkF9B0+ccvWAtQL7YiTSwziPDguqTZncL1Q8XdrDrSdAavKHFpFYqhMeBhlmO0dph0oxI/JeprhqYeokMklpryQBhmHSbgLFKg5pNxCui2BW7UqRoaUNzoD35ZvvyZ3j5Oz6HJNXxV2+pFCXfjIweRhFTaVZ9fHQLUyiHAIOVPG9MAQlZYPUyinnVixF+9tHFqiu3g0txwdyAuDxVf6tkl5p2DdFftIamSK+V6oaRJRGbk1wYfBT2L6s/A3KuLoLiRp75WANOJuhAkcwnoyPIhD+LkqAEM1eODLW
x-ms-exchange-antispam-messagedata: /678vDtZ9V9XCxCM9wWuUhabAoSOqasVwb09BqKnqj3ROHyv73i16eLa7WABaTlTUJFxSR8O2peKTUUPLDLm5UuwA7ShTBynTJbbuX1kiM8q92aVgG9wFJkG+KLJA208RnRIvH06uxsvsBq+KM4IRg==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB40321A470DEC718A2B8571A9FBC10MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01698924-a4a1-482e-09a4-08d7dc58a5df
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 07:35:59.2116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tou4Hvk7EoObH07zxV7wNrDWR2VbvYgaBDXgTxca2o2cJFksK2CLzgLN7c+r6d7pl7WsyBKz4PC9iNcTgLKTVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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

--_004_MN2PR12MB40321A470DEC718A2B8571A9FBC10MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB40321A470DEC718A2B8571A9FBC10MN2PR12MB4032namp_"

--_000_MN2PR12MB40321A470DEC718A2B8571A9FBC10MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

+attachment

From: Clements, John
Sent: Thursday, April 9, 2020 3:35 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: increased atom cmd timeout


[AMD Official Use Only - Internal Distribution Only]

Submitting patch to increase atom cmd timeout from 10s to 20s

Thank you,
John Clements

--_000_MN2PR12MB40321A470DEC718A2B8571A9FBC10MN2PR12MB4032namp_
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
p.msipheadera92e061b, li.msipheadera92e061b, div.msipheadera92e061b
	{mso-style-name:msipheadera92e061b;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<div class=3D"WordSection1">
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#43;attachment<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Clements, John <br>
<b>Sent:</b> Thursday, April 9, 2020 3:35 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: increased atom cmd timeout<o:p></o:p></=
p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera92e061b" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Submitting patch to increase atom cmd timeout from 1=
0s to 20s<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB40321A470DEC718A2B8571A9FBC10MN2PR12MB4032namp_--

--_004_MN2PR12MB40321A470DEC718A2B8571A9FBC10MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-increased-atom-cmd-timeout.patch"
Content-Description: 0001-drm-amdgpu-increased-atom-cmd-timeout.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-increased-atom-cmd-timeout.patch"; size=1378;
	creation-date="Thu, 09 Apr 2020 07:35:00 GMT";
	modification-date="Thu, 09 Apr 2020 07:35:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1Y2EyOGYzZjUzNmYwM2Y1OTNkNzBlOGQzN2JkNmNjNjhmOTQ3Mzk3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgOSBBcHIgMjAyMCAxNTozMjo0MSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IGluY3JlYXNlZCBhdG9tIGNtZCB0aW1lb3V0CgphZGRlZCBtYWNybyB0byBkZWZp
bmUgdGltZW91dAoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0Bh
bWQuY29tPgpDaGFuZ2UtSWQ6IElhYWE3M2FlZTU3MjU1MzEwNTAzOGMxY2JiMDYyM2NmYTQ0Yzg4
NDhmCi0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbS5jIHwgNyArKysrKy0tCiAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2F0b20uYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2F0b20uYwppbmRleCBjYWU0MjZjN2MwODYuLjRjZmM3ODY2OTljNyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2F0b20uYwpAQCAtNTQsNiArNTQsOCBAQAogI2RlZmluZSBQTExfSU5E
RVgJMgogI2RlZmluZSBQTExfREFUQQkzCiAKKyNkZWZpbmUgQVRPTV9DTURfVElNRU9VVF9TRUMJ
MjAKKwogdHlwZWRlZiBzdHJ1Y3QgewogCXN0cnVjdCBhdG9tX2NvbnRleHQgKmN0eDsKIAl1aW50
MzJfdCAqcHMsICp3czsKQEAgLTc0NCw4ICs3NDYsOSBAQCBzdGF0aWMgdm9pZCBhdG9tX29wX2p1
bXAoYXRvbV9leGVjX2NvbnRleHQgKmN0eCwgaW50ICpwdHIsIGludCBhcmcpCiAJCQljamlmZmll
cyA9IGppZmZpZXM7CiAJCQlpZiAodGltZV9hZnRlcihjamlmZmllcywgY3R4LT5sYXN0X2p1bXBf
amlmZmllcykpIHsKIAkJCQljamlmZmllcyAtPSBjdHgtPmxhc3RfanVtcF9qaWZmaWVzOwotCQkJ
CWlmICgoamlmZmllc190b19tc2VjcyhjamlmZmllcykgPiAxMDAwMCkpIHsKLQkJCQkJRFJNX0VS
Uk9SKCJhdG9tYmlvcyBzdHVjayBpbiBsb29wIGZvciBtb3JlIHRoYW4gMTBzZWNzIGFib3J0aW5n
XG4iKTsKKwkJCQlpZiAoKGppZmZpZXNfdG9fbXNlY3MoY2ppZmZpZXMpID4gQVRPTV9DTURfVElN
RU9VVF9TRUMqMTAwMCkpIHsKKwkJCQkJRFJNX0VSUk9SKCJhdG9tYmlvcyBzdHVjayBpbiBsb29w
IGZvciBtb3JlIHRoYW4gJWRzZWNzIGFib3J0aW5nXG4iLAorCQkJCQkJICBBVE9NX0NNRF9USU1F
T1VUX1NFQyk7CiAJCQkJCWN0eC0+YWJvcnQgPSB0cnVlOwogCQkJCX0KIAkJCX0gZWxzZSB7Ci0t
IAoyLjE3LjEKCg==

--_004_MN2PR12MB40321A470DEC718A2B8571A9FBC10MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB40321A470DEC718A2B8571A9FBC10MN2PR12MB4032namp_--
