Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FE1C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5C42073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 09:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ADShw8cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5C42073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A9F06E195;
	Thu,  5 Mar 2020 09:39:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54AAB6E195
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 09:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQ6RKXYYlg8odyUZiWfZoVrL1iof2D5zmKKa9WgiS1gFUZ2ysT0tRrbs/OG67O1pBDTJZbpdojj3AFxcA5MgS+I+OV/fOgjcuPuxgn1iFY8+xIFcv6TPDZIr60Bzsu2RehFrZiOaXuj5tw5YFNDAivFxzqj1c8rppEgOxyBjiF/EhUI30CC6Ns5YAvXvOftfBRwS0JOkcws7HME9sB63HD9YQOuoJqnD5jF1WK2q9HlyFDJwy2lh5FznOsYTdPhLXhgDHbOt05o8FXizr7bFhYVtpdVoyo63MUjckLhaaG51QM4bFB618MAaQqIbWwuCvwnkHJbw0mXhYEuiKzmSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxfiHnM4xsJwrZ+6D8YfduMu7JIyqgDRNQ1C1GrShiw=;
 b=S76nBE2EpS3FiyNs8hYmN3IzgDEusUjQwWEwFovRK2XeiDfveuxZ5Wl1t6P1OnhDNxMHHBCbIahUJbr4wUe4FaNoTv8D8EcOpCSi9HSPOJWZVUCgjstu6E71wmILyaoEp/0pa6xhMz6sdwXUJdvs1KcBF0U08RiplPWwrnGyrXmnabBQkaWVzhxunm7X63bBKsRJa6fkFXKsqnn2k/s+pdjBkhbR+ZJUUw1nUFKBlAOx5AsA9eY5hfMh298Tn55s//jRWoJH51D9sUOD9+BXXlVF6Z8O0dxcih2bLH/bxEWifms9RmqIU4CLkxowdy53/8Y84TFjzezY6844Irebfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxfiHnM4xsJwrZ+6D8YfduMu7JIyqgDRNQ1C1GrShiw=;
 b=ADShw8cqzt3136wNwiDHSD7dUZE9rp/9PMD6l6F0Z5kAksCR0nvlS6L8Ft+Ipu1WrbnNVifojKu+Lh2by9oL1axeoeYYi6Et2BlrRgygc8om++gciNfMISJ9rlefvIPmwXPjAcxz6SJhERrc2T9FpF307xS+rQ23b4APh7LlYDQ=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 09:38:58 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7%7]) with mapi id 15.20.2793.013; Thu, 5 Mar 2020
 09:38:58 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: increase atombios cmd timeout
Thread-Topic: [PATCH] drm/amdgpu: increase atombios cmd timeout
Thread-Index: AdXy0dBSZnPbjEp8RUSqBndfIsh2+A==
Date: Thu, 5 Mar 2020 09:38:58 +0000
Message-ID: <MN2PR12MB3663B49E183438B1B5070EA4FBE20@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-05T09:38:55Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=58e119e6-772a-4273-8acf-00008a1b2e6d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-05T09:38:55Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5fb2c903-9155-4fc3-8863-0000732d9ec6
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.224.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da389af1-0ed1-4042-93ac-08d7c0e907ea
x-ms-traffictypediagnostic: MN2PR12MB3309:|MN2PR12MB3309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB33095ED3170D59F363794321FBE20@MN2PR12MB3309.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
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
x-microsoft-antispam-message-info: 1WG2Ga6XgoiR/kTXxzb5S7N3e4DK5SOILNHTZWmgpozSKjwjPFn7ao0t6ej/M+S7pdQrPeiM4EhzHlooft9eIG9+DOgwhHFSfMlmVAx1BxP3D4qer1MdocQoyVPo8jxiJlGxB91VgvcMKSktDDrZwLAtc4S8AsLkFYdxqdswWqHXWPTZ5pV6o50Df2ZCRzpfD3P1ievq1T1J/f093vO1m/s4aIyEUFbG8POOgk/Y3AIXJehzq04bWHK2UrtMdS72Pn18syC1Us/KAeE1HKxZ2gCj5/IVbem+35I7CMCuS0UyvtEwsnGpz6/WTqK1thAzEgSOwqs84RoYywnJNLvzC6tBytY3pc1hskYGV+hP17yrWQX7ogyjf/RQDEVE9nO9YaSfOckxDbMN907getnv8VwREOtq3xEWr65oziBMv4Q2mdaMpj1PBsJ6r6BUwNWz
x-ms-exchange-antispam-messagedata: zFItxG1+/vLZUYq/z5OfjlodIx3gdmtRxwn75sCidSk0u4rr5OfCC6pr/0M/dkPSKlFiwt8ronmg6xvmNEpd1NvL+Yy6a6Rr8V3lxjdILzflgGjHoddssGzHwiJiA/aaEXf6giDPupq99pCEaOd3XQ==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB3663B49E183438B1B5070EA4FBE20MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da389af1-0ed1-4042-93ac-08d7c0e907ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 09:38:58.6972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0C63xyyJGT11MYpsXLvRMjEe6TJQCa5YQlzaaQiEhw2u3hj83p3i6PIRS6DaOQnpjqix6GBVg8kkyvfEZyfgg==
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

--_004_MN2PR12MB3663B49E183438B1B5070EA4FBE20MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663B49E183438B1B5070EA4FBE20MN2PR12MB3663namp_"

--_000_MN2PR12MB3663B49E183438B1B5070EA4FBE20MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

mitigates race condition on BACO reset between GPU bootcode and driver relo=
ad

--_000_MN2PR12MB3663B49E183438B1B5070EA4FBE20MN2PR12MB3663namp_
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
<p class=3D"MsoNormal">mitigates race condition on BACO reset between GPU b=
ootcode and driver reload<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3663B49E183438B1B5070EA4FBE20MN2PR12MB3663namp_--

--_004_MN2PR12MB3663B49E183438B1B5070EA4FBE20MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-increase-atombios-cmd-timeout.patch"
Content-Description: 0001-drm-amdgpu-increase-atombios-cmd-timeout.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-increase-atombios-cmd-timeout.patch"; size=1210;
	creation-date="Thu, 05 Mar 2020 09:38:00 GMT";
	modification-date="Thu, 05 Mar 2020 09:38:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzOGE4NjY0OWVlM2E0NGNmZTA3ZDlmYmQyZGZjMTJhOGE5NmNkNWVmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgNSBNYXIgMjAyMCAxNzozMTo1MCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IGluY3JlYXNlIGF0b21iaW9zIGNtZCB0aW1lb3V0CgptaXRpZ2F0ZXMgcmFjZSBj
b25kaXRpb24gb24gQkFDTyByZXNldCBiZXR3ZWVuIEdQVSBib290Y29kZSBhbmQgZHJpdmVyIHJl
bG9hZAoKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29t
PgpDaGFuZ2UtSWQ6IEllOWFmYjhjZTRkZTAwNDE4NmUyNjRlMTBjNGU3MTc2NWQ5MjhjZjIyCi0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbS5jIHwgNCArKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2F0b20uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2F0b20uYwppbmRleCBkZDMwZjRlNjFhOGMuLmNhZTQyNmM3YzA4NiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2F0b20uYwpAQCAtNzQ0LDggKzc0NCw4IEBAIHN0YXRpYyB2b2lkIGF0b21fb3BfanVt
cChhdG9tX2V4ZWNfY29udGV4dCAqY3R4LCBpbnQgKnB0ciwgaW50IGFyZykKIAkJCWNqaWZmaWVz
ID0gamlmZmllczsKIAkJCWlmICh0aW1lX2FmdGVyKGNqaWZmaWVzLCBjdHgtPmxhc3RfanVtcF9q
aWZmaWVzKSkgewogCQkJCWNqaWZmaWVzIC09IGN0eC0+bGFzdF9qdW1wX2ppZmZpZXM7Ci0JCQkJ
aWYgKChqaWZmaWVzX3RvX21zZWNzKGNqaWZmaWVzKSA+IDUwMDApKSB7Ci0JCQkJCURSTV9FUlJP
UigiYXRvbWJpb3Mgc3R1Y2sgaW4gbG9vcCBmb3IgbW9yZSB0aGFuIDVzZWNzIGFib3J0aW5nXG4i
KTsKKwkJCQlpZiAoKGppZmZpZXNfdG9fbXNlY3MoY2ppZmZpZXMpID4gMTAwMDApKSB7CisJCQkJ
CURSTV9FUlJPUigiYXRvbWJpb3Mgc3R1Y2sgaW4gbG9vcCBmb3IgbW9yZSB0aGFuIDEwc2VjcyBh
Ym9ydGluZ1xuIik7CiAJCQkJCWN0eC0+YWJvcnQgPSB0cnVlOwogCQkJCX0KIAkJCX0gZWxzZSB7
Ci0tIAoyLjE3LjEKCg==

--_004_MN2PR12MB3663B49E183438B1B5070EA4FBE20MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB3663B49E183438B1B5070EA4FBE20MN2PR12MB3663namp_--
