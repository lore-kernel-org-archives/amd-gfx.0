Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C46C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 09:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2D12145D
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 09:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gs+lozJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2D12145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73B76ED95;
	Wed,  9 Sep 2020 09:24:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC5B6ED95
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 09:24:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyzIZsrfUsSIe/uYIGT82dzxXU53KjOeG8ZP/M/Wgqb6X9rt6jKRcfSBKgrJS+SdTUpYXJVrnJnCnvYvJfG/Q5yub0qKkyOqdmpYBen1xacXh4XLjU4woWKCPS4sO1Qi6TlE6pg0IzCrTD8mB21PBhxTyhdq3FJGA3bHmzB2sLFWNwRdxfChqutF9GWtPj/lLipUrB4PveotyIyk3wqJ8/E9lAc26UiDLoTXqK1fUvGJK+gv/lBepc+y6lAdbYZlErHrCyzLqiAWuwXvwzCVc4W96ubBfzgz8XXuxtFlOPAYJzYGKD7eDr4z06Yhf+gEbcHpq9IymbhzNCeUTeFFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuMzapxYSV/y2tALNQhgRja/h6BfOq/SeVLEyTn4AMo=;
 b=fArFrt/fkGxqvAiO5mPmtZxLfDABNkoRAir0aB8mLndUtmtvgNfx1qS8+n+dgTQJ8CLDMx2qPW2IdVeGZ2ZcoFjNaH39rrZX7AMe9M2SKkoE81pLvQD4bQy77gz5zkXxoqWHa+5+6tlFdT9QvTXwXfAbysIZjHj2VAQRnclboWTUPflZrYlm4XEephhu2tdM5CvRtBgKozZ4q+PEkU5L3608SFSU4zVep9c+4K0uQ5ngMjjdLbRbHaYkIsWAX3HyBkHOsTuAAc0Wkz9le3AXbFbjuVmox+PvSmIsGQLuGpdW9wRevRGBR65gMSfA1qIcYzzCJDqHBNiWRlCcvL+R9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuMzapxYSV/y2tALNQhgRja/h6BfOq/SeVLEyTn4AMo=;
 b=gs+lozJgUmH3J2usvCpCDxGjtqCJVLDJvTqKsAAqmJobCTaMdr5UD4AozuQIaNJYVSMCkvX879e13i6unarIEtfjJzYUtjJiXvaMx9tmq4x1RidyPZDLlZic+CP6zosWWNgJsiftBKdxe9FXyc/KAAd6N+74W6837n73MF9W184=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 09:24:12 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::2886:b3eb:a9b0:5d29]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::2886:b3eb:a9b0:5d29%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 09:24:12 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update RAS init handling
Thread-Topic: [PATCH] drm/amdgpu: Update RAS init handling
Thread-Index: AdaGiu0LetZWdMcuTBOCRWM5fSEKUg==
Date: Wed, 9 Sep 2020 09:24:12 +0000
Message-ID: <MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-09T09:24:02Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=42195f31-199f-4453-b735-0000ad980e2d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-09T09:24:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 559fee7d-16e4-4835-8eac-0000bf5edd03
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76de2319-8eb2-4c96-3206-08d854a21d83
x-ms-traffictypediagnostic: MN2PR12MB4504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45044447772109B11E89A4F9FB260@MN2PR12MB4504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CggyijEsS2SRjRGvSnwrxWG+d3Iw7Lc9/rFtHAUsYY6zY3kwtfuwBlWwv2I7mlL2hx8sgjoTzRtoWW/aU39z2TM9YFDuirSthHRkWcO9pRHKRUYnyaCMzgYVm4A7BTi+BqQPvbh6zCN0Cw4E1yBI0Kj1NDbc7k5vw+kC74gNitOefQBx+ulTG0GOdJP2xvzhUP2FvVE0E8/3lddiDUqSQpVjjOIcxYVhptyDeFNT2ciikuceMU+p5xHAhz8qK6fqCclkqz6dnU0Psa4jzFLz9GBrghm2foxHA/c7yVWM2DJcKwSs5Jh4xGi+1wXh6SVv7f31/XhLHkLbuS7jiWOjJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(8676002)(5660300002)(66616009)(66476007)(64756008)(66446008)(66946007)(66556008)(2906002)(8936002)(76116006)(86362001)(186003)(6636002)(52536014)(478600001)(110136005)(316002)(6506007)(26005)(71200400001)(55016002)(9686003)(7696005)(33656002)(99936003)(558084003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gAE4jI1iHc2K/1/GhBYC2eFPpKiTvhi5t47m7QsCchdtW3n7vuh3mdDzzauOqoG9sFhPKay0aA2sKa226j2kSg59iZmuZJ9F/KDz9Un56Vvrnh7/O8JzjoJ9AUB9XuE1rwM89W5RS9saeH+thQUhv9HIfnDTNw2cp0K9VBSWdhbP0LWq8lm58JtZc3Y838BoBtF3IUkJG9T1hR9+QFjTyjeW6493ZFlzeCvSyj7FGYz1wIBJ71jkqOR5dZVIItMW/65DPdVNvHr9oHxGEscUibbNx4FgDroZFZKKq0XOKwuhYT+TzqNWKnfWrOZqeIwOYhsANyb7K0J8rV2VeGfyrYJ4LdoUSga1cs6Afo1rPnTD6TiUGPSbrgsV1wVfTbOV4JkBXuE0auMLlC9odE+4vxTA2RhmFmPNYUQ5Sh1vojkgzgjrKwtlBp2pUzLLzmo3Kh5EEYjNedP14ILUakzbN83MqXCjkjshoJUNWpWk39PKCxMKTVlAZ7RkdoqMM2X6J23AUFVpHkBx15JM0HBCZsPvUw5IyiO0EMZ6WWAS/wJjg0y1DtPB4RkYWKrTRWMIztXoyIcmOe78SL3vI+4GwBvOUh2I9W/vz+s+tScKkzkK9dGGc2Dc4d4NQ0f/DumLS9bwoAGEoAL5WSKXDELlAw==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76de2319-8eb2-4c96-3206-08d854a21d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 09:24:12.8588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8c7gifKjJ7r3KHfQVtPE7RE4/OOSXZFsSw4BOd5dRrhLJDrouFRfCF7xhHWQvPoSeozG7hzUFfQ1acuAHywbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
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

--_004_MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260MN2PR12MB4032namp_"

--_000_MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



--_000_MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260MN2PR12MB4032namp_
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
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260MN2PR12MB4032namp_--

--_004_MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Update-RAS-init-handling.patch"
Content-Description: 0001-drm-amdgpu-Update-RAS-init-handling.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Update-RAS-init-handling.patch"; size=1946;
	creation-date="Wed, 09 Sep 2020 09:23:00 GMT";
	modification-date="Wed, 09 Sep 2020 09:23:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiZjlmODExNTg2MzllYjhkZjcyZTNjOGU4OWM4NmU2ZjRjNDk5MzU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgOSBTZXAgMjAyMCAxNzoxOTo1MyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IFVwZGF0ZSBSQVMgaW5pdCBoYW5kbGluZwoKVXBvbiBSQVMgaW5pdCBmYWlsdXJl
OgpPdXRwdXQgUkFTIGluaXQgc3RhdHVzIGluIGxvZwpEbyBub3QgYXR0ZW1wdCBmdXJ0aGVyIFJB
UyBGVyBmdW5jdGlvbnMKClNpZ25lZC1vZmYtYnk6IEpvaG4gQ2xlbWVudHMgPGpvaG4uY2xlbWVu
dHNAYW1kLmNvbT4KQ2hhbmdlLUlkOiBJZTU5Yzc2NGY1ZWVjMzg3ZDA0YmQ2NzZhZDRlMDUzYmIz
OWYzMDY2NwotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDkg
KysrKysrKystCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCAzICsr
KwogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCmluZGV4IGQ2YzM4ZTI0ZjEzMC4uYzc2
NWQxNGVmYjU4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC05
MjksNiArOTI5LDcgQEAgc3RhdGljIGludCBwc3BfcmFzX2xvYWQoc3RydWN0IHBzcF9jb250ZXh0
ICpwc3ApCiB7CiAJaW50IHJldDsKIAlzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kOworCXN0
cnVjdCB0YV9yYXNfc2hhcmVkX21lbW9yeSAqcmFzX2NtZDsKIAogCS8qCiAJICogVE9ETzogYnlw
YXNzIHRoZSBsb2FkaW5nIGluIHNyaW92IGZvciBub3cKQEAgLTk1Miw5ICs5NTMsMTUgQEAgc3Rh
dGljIGludCBwc3BfcmFzX2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJcmV0ID0gcHNw
X2NtZF9zdWJtaXRfYnVmKHBzcCwgTlVMTCwgY21kLAogCQkJcHNwLT5mZW5jZV9idWZfbWNfYWRk
cik7CiAKKwlyYXNfY21kID0gKHN0cnVjdCB0YV9yYXNfc2hhcmVkX21lbW9yeSopcHNwLT5yYXMu
cmFzX3NoYXJlZF9idWY7CisKIAlpZiAoIXJldCkgewotCQlwc3AtPnJhcy5yYXNfaW5pdGlhbGl6
ZWQgPSB0cnVlOwogCQlwc3AtPnJhcy5zZXNzaW9uX2lkID0gY21kLT5yZXNwLnNlc3Npb25faWQ7
CisKKwkJaWYgKCFyYXNfY21kLT5yYXNfc3RhdHVzKQorCQkJcHNwLT5yYXMucmFzX2luaXRpYWxp
emVkID0gdHJ1ZTsKKyAgICAgICAgZWxzZQorCQkJZGV2X3dhcm4ocHNwLT5hZGV2LT5kZXYsICJS
QVMgSW5pdCBTdGF0dXM6IDB4JVhcbiIsIHJhc19jbWQtPnJhc19zdGF0dXMpOwogCX0KIAogCWtm
cmVlKGNtZCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKaW5kZXggZTVl
YTE0Nzc0YzBjLi5jNjU5YjEwNWI2NmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yYXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmMKQEAgLTYwNCw2ICs2MDQsOSBAQCBpbnQgYW1kZ3B1X3Jhc19mZWF0dXJlX2VuYWJs
ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAl1bmlvbiB0YV9yYXNfY21kX2lucHV0ICpp
bmZvOwogCWludCByZXQ7CiAKKwlpZiAoIWFkZXYtPnBzcC5yYXMucmFzX2luaXRpYWxpemVkKQor
CQlyZXR1cm4gLUVJTlZBTDsKKwogCWlmICghY29uKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotLSAK
Mi4xNy4xCgo=

--_004_MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB4032CB22E8EBE0E9FA3FE7EDFB260MN2PR12MB4032namp_--
