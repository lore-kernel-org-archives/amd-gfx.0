Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36623C1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 06:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB6A2051A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 06:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k2I9TIuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB6A2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DF4089E7C;
	Wed, 25 Mar 2020 06:50:26 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750055.outbound.protection.outlook.com [40.107.75.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC91389E7C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 06:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sto2T46swzPYrLCgVB/Z4ABMBl0ACKY7i2o0bxtGoov77IP1anddfXM9mhXjq/HeiZ6gBgKlKSx60eB9dXDPQt0Fm0VMBn02yQ6uTmF2qyAkKB69dnNOBwo1Eyecy+mmTJKvZ0bJHEhQDfhoIIi/NYSvgGsiQDS4IOjC5gN0BoZ+yRC8AtRAJNVn8nn5mJMHKMLruIx6y6P0vdkmylHaZ3/MCAn7wxiO5IZOMY4VT4MGNHFZsHDBsqjcITCu+ukuG0TM8ppJSXRHyCRYqV6Htz2FRUWpdYNmqr7PIfp2w7f0H2sALBrZHBDic6kbpEE7raZcqSXhgh+MAFmoOBS68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyIs1l3dfBqfhLmKkGnErYY4Aus0UdRZlVKaFEOgYlU=;
 b=eGu2rkERxQGjR2HXK5oecEj0S+TlpOTyouWe/+lwE97cW6WDy95CmkykdiMhHC8tuaiI837RHyAjB1roQUNonOw4Uy1qMGWDhcWc8AzOz/0ErUvcUC5HrYjBtHuVCgj2XTZmIh40xL8YJ0z8yZDvL+y2Zb6gkBTr2cSL8CcwuFLz7f+uxt4tVEepc3FITm4ZmqAh7yBUI/4nP2r2NqrywZ11JXe6Zuuu0LpEHjsflw9wAIofuAFp3vlGELTJOBxENHx83NIWCiZVNox7e6xVlN7IJbSyxcl9IDVaFsfVZOPUgemWRGUu2Ifu9xQmF+3rym8j88jJfEzRwrOaAG8sAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyIs1l3dfBqfhLmKkGnErYY4Aus0UdRZlVKaFEOgYlU=;
 b=k2I9TIuwYCsgEsFb6aJu0x4l3ySxztg/WjE31CzL4HB176DETCd76DJ/r0skXPBuVJ68pwP++F3SYwRPYq/Kf6X9O57/1HAlsjM25Kiuf5w0JR7XxGgfj/EaouXUvE6YURKOC3A087nho07szRSH0i0py4+AZSuh+s49gxew9SE=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by MN2PR12MB3392.namprd12.prod.outlook.com (2603:10b6:208:cb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 06:50:24 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 06:50:24 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: added xgmi ras error reset sequence
Thread-Topic: [PATCH] drm/amdgpu: added xgmi ras error reset sequence
Thread-Index: AdYCcZGVr5OtLNxCSJCJvH1jNKE/ug==
Date: Wed, 25 Mar 2020 06:50:23 +0000
Message-ID: <MN2PR12MB3663ABDAD735500B548C76F5FBCE0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-25T06:50:20Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=468a059a-eee5-4623-a6fd-0000bdd9150b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-25T06:50:21Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 73a58788-4b71-47a7-a5a5-0000defacc5c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c5f2cdf-c1e7-4b62-6cee-08d7d088cb45
x-ms-traffictypediagnostic: MN2PR12MB3392:|MN2PR12MB3392:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3392D7CFEC618E3855E17BC4FBCE0@MN2PR12MB3392.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
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
x-microsoft-antispam-message-info: 0F3OYidZ4U1/t+4kerrMjg4YGb8DI7zmJLfRQPzNWiaYPsLplY6/oJMF+T36xQVHwe34QF0mMDt8MtuiAYaD8dVCe9gR39F2VJeIYPTJL/UIVrV6xpwLYCCaXlqCRxQ7w5xqBPOQbqz4eBlwCPqjoJWbctCtEwoaTDm0XYxempcxoiITOdBt+nZ0a7dgprG85sxD+Xo1OYRVxuSornr5QzZruG2mvveA+/MKrF4gfdHxlVaC5buAmSyCB9UZLQO8CK/2lsPSAT/7okTbgZ0Y/tkGjg57K3+39abwUF7EpGo/0YLKYv1Gu+b6O3EMVkTL7gSSxlkT0wFpjcMLyEf4dFEcaz3BCHbVmXkuixEle+XMwj1fsv9tdXFxyUhln3hf2lQNVJybuNa9GUyWI10HaXRvIzDhM3tqy962kAs0WHGj8+F5XDqpWZi448Mqg3TE
x-ms-exchange-antispam-messagedata: M4xTgb9x1vCo/los8y7y8eUIXddTHX4bPhXSc/lPlVJKL9PHcsP+5+P1ew3leQOuaMsmGnsSPMVh1QXem3R72GMoD1KB23KwivIFhx0WrwHJCQZQFhghPpHX8Tx7PzYMCqBW4EX3+eaIv4I6LPVleA==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB3663ABDAD735500B548C76F5FBCE0MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5f2cdf-c1e7-4b62-6cee-08d7d088cb45
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 06:50:24.0149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bezxBoMg1jKl0F1pGh3emmKWrXTvIqDdclVSfKzvbpByoz53cjkthSyaCDZzn0Dm3XomYrBQPrr+D68ysopcdA==
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

--_004_MN2PR12MB3663ABDAD735500B548C76F5FBCE0MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663ABDAD735500B548C76F5FBCE0MN2PR12MB3663namp_"

--_000_MN2PR12MB3663ABDAD735500B548C76F5FBCE0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to clear xgmi ras error counters inbetween ras error query

--_000_MN2PR12MB3663ABDAD735500B548C76F5FBCE0MN2PR12MB3663namp_
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
<p class=3D"MsoNormal">Submitting patch to clear xgmi ras error counters in=
between ras error query<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3663ABDAD735500B548C76F5FBCE0MN2PR12MB3663namp_--

--_004_MN2PR12MB3663ABDAD735500B548C76F5FBCE0MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-added-xgmi-ras-error-reset-sequence.patch"
Content-Description: 0001-drm-amdgpu-added-xgmi-ras-error-reset-sequence.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-added-xgmi-ras-error-reset-sequence.patch";
	size=2854; creation-date="Wed, 25 Mar 2020 06:49:00 GMT";
	modification-date="Wed, 25 Mar 2020 06:49:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiZTIzZTgzNGQ4NGNjYTZkZjM5NmFjN2ExODY2NmQxNzNiMjk5MWU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgMjUgTWFyIDIwMjAgMTQ6NDQ6NTIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBhZGRlZCB4Z21pIHJhcyBlcnJvciByZXNldCBzZXF1ZW5jZQoKYWRkZWQgbWVj
aGFuaXNtIHRvIGNsZWFyIHhnbWkgcmFzIHN0YXR1cyBpbmJldHdlZW4gZXJyb3IgcXVlcmllcwoK
U2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpDaGFu
Z2UtSWQ6IEkxNjI3MmFkY2E1MzNmMjc0MTY5ZWZjZmIwOTA0ZDA5NGRhNDNlOTVmCi0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYyB8IDI5ICsrKysrKysrKysrKysr
KysrKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuaCB8ICAx
ICsKIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfeGdtaS5jCmluZGV4IDk1YjMzMjcxNjhhYy4uOGYxZjg0MzVlOTQ4IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMKQEAgLTYwNCw2ICs2MDQs
OCBAQCBpbnQgYW1kZ3B1X3hnbWlfcmFzX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIAkgICAgYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID09IDApCiAJCXJl
dHVybiAwOwogCisJYW1kZ3B1X3hnbWlfcmVzZXRfcmFzX2Vycm9yX2NvdW50KGFkZXYpOworCiAJ
aWYgKCFhZGV2LT5nbWMueGdtaS5yYXNfaWYpIHsKIAkJYWRldi0+Z21jLnhnbWkucmFzX2lmID0g
a21hbGxvYyhzaXplb2Yoc3RydWN0IHJhc19jb21tb25faWYpLCBHRlBfS0VSTkVMKTsKIAkJaWYg
KCFhZGV2LT5nbWMueGdtaS5yYXNfaWYpCkBAIC02NjgsNiArNjcwLDMxIEBAIHVpbnQ2NF90IGFt
ZGdwdV94Z21pX2dldF9yZWxhdGl2ZV9waHlfYWRkcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKIAlyZXR1cm4gYWRkciArIGRyYW1fYmFzZV9hZGRyOwogfQogCitzdGF0aWMgdm9pZCBwY3Nf
Y2xlYXJfc3RhdHVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCBwY3Nfc3Rh
dHVzX3JlZykKK3sKKwlXUkVHMzJfUENJRShwY3Nfc3RhdHVzX3JlZywgMHhGRkZGRkZGRik7CisJ
V1JFRzMyX1BDSUUocGNzX3N0YXR1c19yZWcsIDApOworfQorCit2b2lkIGFtZGdwdV94Z21pX3Jl
c2V0X3Jhc19lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKK3sKKwl1aW50
MzJfdCBpOworCisJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKKwljYXNlIENISVBfQVJDVFVS
VVM6CisJCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHhnbWlfcGNzX2Vycl9zdGF0dXNfcmVn
X2FyY3QpOyBpKyspCisJCQlwY3NfY2xlYXJfc3RhdHVzKGFkZXYsCisJCQkJCSB4Z21pX3Bjc19l
cnJfc3RhdHVzX3JlZ19hcmN0W2ldKTsKKwkJYnJlYWs7CisJY2FzZSBDSElQX1ZFR0EyMDoKKwlk
ZWZhdWx0OgorCQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh4Z21pX3Bjc19lcnJfc3RhdHVz
X3JlZ192ZzIwKTsgaSsrKQorCQkJcGNzX2NsZWFyX3N0YXR1cyhhZGV2LAorCQkJCQkgeGdtaV9w
Y3NfZXJyX3N0YXR1c19yZWdfdmcyMFtpXSk7CisJCWJyZWFrOworCX0KK30KKwogc3RhdGljIGlu
dCBhbWRncHVfeGdtaV9xdWVyeV9wY3NfZXJyb3Jfc3RhdHVzKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAogCQkJCQkgICAgICB1aW50MzJfdCB2YWx1ZSwKIAkJCQkJICAgICAgdWludDMyX3Qg
KnVlX2NvdW50LApAQCAtNzU4LDYgKzc4NSw4IEBAIGludCBhbWRncHVfeGdtaV9xdWVyeV9yYXNf
ZXJyb3JfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCWJyZWFrOwogCX0KIAor
CWFtZGdwdV94Z21pX3Jlc2V0X3Jhc19lcnJvcl9jb3VudChhZGV2KTsKKwogCWVycl9kYXRhLT51
ZV9jb3VudCArPSB1ZV9jbnQ7CiAJZXJyX2RhdGEtPmNlX2NvdW50ICs9IGNlX2NudDsKIApkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmgKaW5kZXggNGE5MjA2N2ZlNTk1Li5k
NWE2MzkwNGVjMzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV94Z21pLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuaApA
QCAtNTYsNiArNTYsNyBAQCB1aW50NjRfdCBhbWRncHVfeGdtaV9nZXRfcmVsYXRpdmVfcGh5X2Fk
ZHIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJCSAgIHVpbnQ2NF90IGFkZHIpOwog
aW50IGFtZGdwdV94Z21pX3F1ZXJ5X3Jhc19lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKIAkJCQkgICAgICB2b2lkICpyYXNfZXJyb3Jfc3RhdHVzKTsKK3ZvaWQgYW1kZ3B1
X3hnbWlfcmVzZXRfcmFzX2Vycm9yX2NvdW50KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsK
IAogc3RhdGljIGlubGluZSBib29sIGFtZGdwdV94Z21pX3NhbWVfaGl2ZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKIAkJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmJvX2FkZXYpCi0tIAoyLjE3
LjEKCg==

--_004_MN2PR12MB3663ABDAD735500B548C76F5FBCE0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB3663ABDAD735500B548C76F5FBCE0MN2PR12MB3663namp_--
