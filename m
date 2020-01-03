Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89560C00523
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 07:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFB922314
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 07:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ktTRN3b8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFB922314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A2C6E191;
	Fri,  3 Jan 2020 07:27:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 784E36E191
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 07:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQPRKGMvhI4CQkUol8rOPECE/4AulGV3sumKipRQucFFE0TuX/+rn9C3JbBl1RdecnEq9FSMjJsv+AlH3/tpoNlKrVXO6a5FVPbgtvJBRnWpdVe1FrNVB4cBVYe94m+Ou+VmV3CHzR9eade7OAQm3Y+wvojBHkhK6sciY9iIh9iXaRDDtFiq4SEVT+XZaFoP+WT3LhqS4qtBHx6iMhv/COkIyZjE2Sbio5VjXLX7KWA1jQqVIqtu7B3ABy/mafqgZLdevDylxzughlck2bmjmso31m0QCD7l6K3rMGZplne7IzV6dn0+qS9fqLCcqW2N3d8SEZsbMRcUKUrftQx1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z03H+mEMq3EEET5fbJ4z0UbIRcPyMTZ9rtpLozaudb8=;
 b=Mg+oIsxapcYGYel9Ux5E0+uV8TOMX2fG1ubUELSi+IU+ozISjl06FbNIHFpl81ksT4p2rtINLuVgsbNPkEpzzBIF7BtclHxRhR5wS0ZYrU3mwVs30OWwtrN50CVWS8lJg3FmwxsVFk8/TgzaQnqMzdv97+xH3vKaoViwEet9XzAD31d8hl1o4B647l/mbhhsWwdv7zUURrNYWlPUrQQkQVieTbMTbfdEO3VZ4RIXl2JSbZP0AvmvhfIU7Yqxp+CIRNlEQiHWEDDzssftW1hY0GWYIyeIKUoWpRmdlPXNoOXXvPnMtk6zq+DjyoRxmJtcpfLYROVWg4oBP99fk+QxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z03H+mEMq3EEET5fbJ4z0UbIRcPyMTZ9rtpLozaudb8=;
 b=ktTRN3b8d0J03QeUcL/FQQtmeG9BAL8pVELKc9uLmvbEFbGzpabSATxRHcykjFJmtHI2G/Ogrbmz+ebXriINavE/uGuAzzK9Oc3uZnGlXYqPya+uFAVAjKrZzApeJ0mgzPzKHWgUg53piieHUia962VgR7d9Rnl419c/mYecR+c=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3120.namprd12.prod.outlook.com (20.178.243.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Fri, 3 Jan 2020 07:27:26 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2581.013; Fri, 3 Jan 2020
 07:27:26 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable PSP XGMI TA unload sequence
Thread-Topic: [PATCH] drm/amdgpu: disable PSP XGMI TA unload sequence
Thread-Index: AdXCBycCnqYzmDP9Sa2NlG+MiiRrXg==
Date: Fri, 3 Jan 2020 07:27:26 +0000
Message-ID: <MN2PR12MB3663449518FC5A3FCE936BF7FB230@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-03T07:27:21Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8412ab38-c44b-416c-9ec5-00003517c9f1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-03T07:27:21Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 451ad92b-6458-4ea7-b0a0-0000bb11652b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [114.88.235.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 285e83a1-e06f-43da-cdcb-08d7901e6237
x-ms-traffictypediagnostic: MN2PR12MB3120:|MN2PR12MB3120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB31200BA823E27805B331816FFB230@MN2PR12MB3120.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
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
x-microsoft-antispam-message-info: GAKywZ51pFa2NrRrayjgEQ4hO1fZRnvSWQcjctHb3hj9NbEymP7vLBwq2vHdSiMv7DHlLjsWhXF4Y5sMX6RUG/GDQhlHd0iQya4E1rZNEBBhje1jtngzpKRyXxscD52sEkUttUlCyXg2stkZ87r5TVy9gTe+n/zRLgPI0Dk2unZ/sc+e39CdC1+DjbW0M6DutfsVb4UxNZ88GTZsn82CQx9zmt08cq1ctOPy/7p6WlPRV1usyQE4eDE3BPBQyufd87WSSn7q25LJ/JjjYlEgYgjwLMVRDSn7dKPlZ7bGOiketP/LbQULA9hjBqczsISyEOpYDivvXcH800MLR/uL17G03kx2ab6qtbQ7c8wulZPOdAri81l90heNT6z45wiKrCgJEfCk43DeMIoDZLxDLvc4eD0u2ZM9dbckZEr68tsXGV/0h29fI1KZ+ba/Efm5
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB3663449518FC5A3FCE936BF7FB230MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285e83a1-e06f-43da-cdcb-08d7901e6237
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 07:27:26.5708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMfWayR4p+GOPzGZ+kIUKfPVzoNnXZ8imQZwaeivTsl8OY43qtZpUwpvOoPkVKnxNzhziR5DDSmiEOTKRqNkTQ==
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

--_004_MN2PR12MB3663449518FC5A3FCE936BF7FB230MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3663449518FC5A3FCE936BF7FB230MN2PR12MB3663namp_"

--_000_MN2PR12MB3663449518FC5A3FCE936BF7FB230MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Disabled PSP XGMI TA unload sequence as it currently causes GPU recovery to=
 fail.

Thank you,
John Clements

--_000_MN2PR12MB3663449518FC5A3FCE936BF7FB230MN2PR12MB3663namp_
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
<p class=3D"MsoNormal">Disabled PSP XGMI TA unload sequence as it currently=
 causes GPU recovery to fail.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3663449518FC5A3FCE936BF7FB230MN2PR12MB3663namp_--

--_004_MN2PR12MB3663449518FC5A3FCE936BF7FB230MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-disable-PSP-XGMI-TA-unload-sequence.patch"
Content-Description: 0001-drm-amdgpu-disable-PSP-XGMI-TA-unload-sequence.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-disable-PSP-XGMI-TA-unload-sequence.patch";
	size=1553; creation-date="Fri, 03 Jan 2020 07:26:00 GMT";
	modification-date="Fri, 03 Jan 2020 07:26:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhYWYyMWFkMGFiZWZmZGRhN2NlODljOTdiODEzNjM3ZmIzOTZjYzQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgMyBKYW4gMjAyMCAxNTowMzozMCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IGRpc2FibGUgUFNQIFhHTUkgVEEgdW5sb2FkIHNlcXVlbmNlCgpjdXJyZW50IHNl
cXVlbmNlIGNhdXNlcyBhIERGIHN5bmMgZmxvb2QKCkNoYW5nZS1JZDogSTRjMzU1YmE5ZTc2NTBk
ZTBlMWY5YjQyMGQ5Nzc0ZTE0NDZiYTFmNzgKU2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8
am9obi5jbGVtZW50c0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wc3AuYyB8IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKaW5kZXgg
MjgxZDg5NjQwMzQ0Li45MzE2OGFlZGNlNjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHNwLmMKQEAgLTUyNSw2ICs1MjUsNyBAQCBzdGF0aWMgaW50IHBzcF94Z21pX2xvYWQo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJcmV0dXJuIHJldDsKIH0KIAorI2lmZGVmIFBTUF9Y
R01JX1RBX1RFUk1JTkFURV9TVVBQT1JUCiBzdGF0aWMgaW50IHBzcF94Z21pX3VubG9hZChzdHJ1
Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0OwpAQCAtNTQ3LDYgKzU0OCw3IEBAIHN0
YXRpYyBpbnQgcHNwX3hnbWlfdW5sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCiAJcmV0
dXJuIHJldDsKIH0KKyNlbmRpZgogCiBpbnQgcHNwX3hnbWlfaW52b2tlKHN0cnVjdCBwc3BfY29u
dGV4dCAqcHNwLCB1aW50MzJfdCB0YV9jbWRfaWQpCiB7CkBAIC01NTUsNiArNTU3LDcgQEAgaW50
IHBzcF94Z21pX2ludm9rZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwgdWludDMyX3QgdGFfY21k
X2lkKQogCiBzdGF0aWMgaW50IHBzcF94Z21pX3Rlcm1pbmF0ZShzdHJ1Y3QgcHNwX2NvbnRleHQg
KnBzcCkKIHsKKyNpZmRlZiBQU1BfWEdNSV9UQV9URVJNSU5BVEVfU1VQUE9SVAogCWludCByZXQ7
CiAKIAlpZiAoIXBzcC0+eGdtaV9jb250ZXh0LmluaXRpYWxpemVkKQpAQCAtNTcwLDcgKzU3Myw3
IEBAIHN0YXRpYyBpbnQgcHNwX3hnbWlfdGVybWluYXRlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNw
KQogCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmcHNwLT54Z21pX2NvbnRleHQueGdtaV9zaGFyZWRf
Ym8sCiAJCQkmcHNwLT54Z21pX2NvbnRleHQueGdtaV9zaGFyZWRfbWNfYWRkciwKIAkJCSZwc3At
PnhnbWlfY29udGV4dC54Z21pX3NoYXJlZF9idWYpOwotCisjZW5kaWYKIAlyZXR1cm4gMDsKIH0K
IAotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB3663449518FC5A3FCE936BF7FB230MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB3663449518FC5A3FCE936BF7FB230MN2PR12MB3663namp_--
