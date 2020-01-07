Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70325C33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 03:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2307E2064C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 03:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bwUUUogK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2307E2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF866E7D7;
	Tue,  7 Jan 2020 03:53:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE05A6E7D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 03:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJKgfa/5kxZiog4iGY1bxzOoGFOxGBe2lxEyxjTVHJLJcAAMJ92cJ3o3JRjDBMfacGMR7Gi81mPmhbzjRltapJ7QWlq1ar4vND8W4arGhd4639oknBXfqn2SjqsvwPIwfBTP9tbQXdTqVy6BIhP+zufScDPpbgatxLOxxyUrwuXklpz1m/XfnZKCkNQJpPfntIqBsstn3iLrhTBsWyb3v1OLXc0/NnuJ9Phk5LYjD85TYRFnRq/HGnwufPnoqOxc0m7AMD/FgFEBkc2++8t0I0P8xk60ulcRh01OZ4+CBQP2f/CpU6a5FJXNuX66DwnJcwTZuPierYGegV9WTW8prA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hfpInfzVJcQhhaQd0G08zGb0p0/4weYjsg0f0IQ798=;
 b=M5y/nQM3FgHTEBJiGYNFWeM+llnTKNIZIuK4EIVBvRVY5TbzBe/Zt6VSDFxhRkiAramSOgsXLRIBZzcIV5NSmUSZOeEKfy812HnKh5Az5bUkqcKdz1XeyyQPRqbBOSzFHLsdIZlilZsIXcQpTakVP7UEr7mqclAjohSX4BS4NFNIk5Zqiika3mQd0d1829PjeWHjfmReP2tBB9u+a8jyKfKplrn7gWay7TdOhbBsxGwHwMAtIsTytRNS+nZleHvU2o+wVtpcn8VziiHchZOkTOr0uMTidxz25khbmx7MMQzAJnAP3Q18Pcvctit8U7dtHnUgkXmD8IJRn3yWSE46OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hfpInfzVJcQhhaQd0G08zGb0p0/4weYjsg0f0IQ798=;
 b=bwUUUogKW04i6J9yn8hPHoN1dKVaxWQHiC4Y/qe47H2IsViqJ/Lt0wh4pj3zMg1AULLusqiFm6B+nqQHCSfm8Te7tsl2k//HDUxEwD5xEgZnymCM45ysp2IDRRIVDcQgAB5op/bykbM+IZ/TRO9sdwhVImYGAIGn4CFxTHG1HeM=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3598.namprd12.prod.outlook.com (20.178.244.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Tue, 7 Jan 2020 03:53:51 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 03:53:51 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 dl.srdc_lnx_ras <dl.srdc_lnx_ras@amd.com>
Subject: [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query
Thread-Topic: [PATCH] drm/amdgpu: resolved bug in UMC RAS CE query
Thread-Index: AdXFDfX6UjCjdKdbSWODjaMeQHS5aA==
Date: Tue, 7 Jan 2020 03:53:51 +0000
Message-ID: <MN2PR12MB36636EC5042C85407DB96379FB3F0@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-07T03:53:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=22664f26-4177-45a5-a8d6-0000728869ae;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-07T03:53:46Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a1a736e6-b121-455c-abd6-0000bab1d9e0
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78821e6c-5347-4f7a-5c2b-08d793253597
x-ms-traffictypediagnostic: MN2PR12MB3598:|MN2PR12MB3598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB35986B480B44615B296F44E2FB3F0@MN2PR12MB3598.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(110136005)(66946007)(7696005)(66446008)(64756008)(66556008)(66476007)(66616009)(33656002)(76116006)(558084003)(316002)(55016002)(9686003)(8936002)(81166006)(8676002)(81156014)(6636002)(71200400001)(478600001)(86362001)(26005)(2906002)(52536014)(5660300002)(6506007)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3598;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QHTwA7Yq06DsSxz5lhBDJ3mIo6UeAxGDPPbarphb2OoFAMRQokax8dBEzJJkQrkweEEW4mKQiFBOLK32TTbQe3Kptue01X+LUBPI+c+kI14Xu4hR0QBpqf71pV0DcPzzmC+GKv4bYZW7ULC1abtbl3KdvbgLlT5S3g/PIhtXTJEGC/Lgc68vENNiDbPVhU1kh8f4j0yNSTSys4dOunFQBCbFhsW3w9GLtFeWHfIdXdx0Ydp3tm7YudT9+49yllhYhSHpKEmT6mnLCrul5dXG5VzUzMaKUAsbXFlRbwFzb3wKEviCU8hG1JAqpYZDJcrz28LmlRUJzO4aJOWsxEm6QMApQMATwYTUVGVhg1PdW/omzx4mvxxQbYe6G3LLWGyBWbchGORMwnjSgeQYC71n14VgVDmGs+IYIz0FNbUzgnpCz0GM0uo2RRXFQvfXtotM
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB36636EC5042C85407DB96379FB3F0MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78821e6c-5347-4f7a-5c2b-08d793253597
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 03:53:51.7350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RWR0GYonwGjyEm+TfDkDipQzwmgNKsyZqTpJxiv8QSTsc1kdm/VNETDB/aeaT21v4Wjz5fpHFWfLcz+S5E1OGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3598
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

--_004_MN2PR12MB36636EC5042C85407DB96379FB3F0MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB36636EC5042C85407DB96379FB3F0MN2PR12MB3663namp_"

--_000_MN2PR12MB36636EC5042C85407DB96379FB3F0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to access CE registers via SMN and disable UMC indexing mo=
de.

Thank you,
John Clements

--_000_MN2PR12MB36636EC5042C85407DB96379FB3F0MN2PR12MB3663namp_
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
<p class=3D"MsoNormal">Submitting patch to access CE registers via SMN and =
disable UMC indexing mode.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB36636EC5042C85407DB96379FB3F0MN2PR12MB3663namp_--

--_004_MN2PR12MB36636EC5042C85407DB96379FB3F0MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-resolved-bug-in-UMC-RAS-CE-query.patch"
Content-Description: 0001-drm-amdgpu-resolved-bug-in-UMC-RAS-CE-query.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-resolved-bug-in-UMC-RAS-CE-query.patch"; size=4700;
	creation-date="Tue, 07 Jan 2020 03:52:00 GMT";
	modification-date="Tue, 07 Jan 2020 03:52:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3Y2ZjMTkzYWJlNWQwYWQxNzM2OWQ1M2FiNjc1NThlNDYwMDBjM2FlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgNyBKYW4gMjAyMCAxMTo1MDo0MCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IHJlc29sdmVkIGJ1ZyBpbiBVTUMgUkFTIENFIHF1ZXJ5Cgpzd2l0Y2ggQ0UgY291
bnRlciByZWdpc3RlciBhY2Nlc3MnIHRvIHVzZSBTTU4KCmRpc2FibGUgVU1DIGluZGV4aW5nIG1v
ZGUKCkNoYW5nZS1JZDogSWFiOTVjMGU0ZGEyZWEyYmIwNGRjODhmZmZiYTM5ZmUxZjI0ZDJhMTAK
U2lnbmVkLW9mZi1ieTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMgfCAzMiArKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZf
MS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEuYwppbmRleCAyNWU5ZThi
N2Q1ZmIuLmZlMThhZTMzZGE2MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdW1jX3Y2XzEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5j
CkBAIC01Miw2ICs1MiwxMiBAQCBjb25zdCB1aW50MzJfdAogCQl7OSwgMjUsIDAsIDE2fSwJCXsx
NSwgMzEsIDYsIDIyfQogfTsKIAorc3RhdGljIHZvaWQgdW1jX3Y2XzFfZGlzYWJsZV91bWNfaW5k
ZXhfbW9kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKK3sKKwlXUkVHMzJfRklFTEQxNShS
U01VLCAwLCBSU01VX1VNQ19JTkRFWF9SRUdJU1RFUl9OQklGX1ZHMjBfR1BVLAorCQkJUlNNVV9V
TUNfSU5ERVhfTU9ERV9FTiwgMCk7Cit9CisKIHN0YXRpYyBpbmxpbmUgdWludDMyX3QgZ2V0X3Vt
Y182X3JlZ19vZmZzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJCSAgICB1aW50
MzJfdCB1bWNfaW5zdCwKIAkJCQkJICAgIHVpbnQzMl90IGNoX2luc3QpCkBAIC04NywyNyArOTMs
MjcgQEAgc3RhdGljIHZvaWQgdW1jX3Y2XzFfcXVlcnlfY29ycmVjdGFibGVfZXJyb3JfY291bnQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJfQogCiAJLyogc2VsZWN0IHRoZSBsb3dlciBj
aGlwIGFuZCBjaGVjayB0aGUgZXJyb3IgY291bnQgKi8KLQllY2NfZXJyX2NudF9zZWwgPSBSUkVH
MzIoZWNjX2Vycl9jbnRfc2VsX2FkZHIgKyB1bWNfcmVnX29mZnNldCk7CisJZWNjX2Vycl9jbnRf
c2VsID0gUlJFRzMyX1BDSUUoKGVjY19lcnJfY250X3NlbF9hZGRyICsgdW1jX3JlZ19vZmZzZXQp
ICogNCk7CiAJZWNjX2Vycl9jbnRfc2VsID0gUkVHX1NFVF9GSUVMRChlY2NfZXJyX2NudF9zZWws
IFVNQ0NIMF8wX0VjY0VyckNudFNlbCwKIAkJCQkJRWNjRXJyQ250Q3NTZWwsIDApOwotCVdSRUcz
MihlY2NfZXJyX2NudF9zZWxfYWRkciArIHVtY19yZWdfb2Zmc2V0LCBlY2NfZXJyX2NudF9zZWwp
OwotCWVjY19lcnJfY250ID0gUlJFRzMyKGVjY19lcnJfY250X2FkZHIgKyB1bWNfcmVnX29mZnNl
dCk7CisJV1JFRzMyX1BDSUUoKGVjY19lcnJfY250X3NlbF9hZGRyICsgdW1jX3JlZ19vZmZzZXQp
ICogNCwgZWNjX2Vycl9jbnRfc2VsKTsKKwllY2NfZXJyX2NudCA9IFJSRUczMl9QQ0lFKChlY2Nf
ZXJyX2NudF9hZGRyICsgdW1jX3JlZ19vZmZzZXQpICogNCk7CiAJKmVycm9yX2NvdW50ICs9CiAJ
CShSRUdfR0VUX0ZJRUxEKGVjY19lcnJfY250LCBVTUNDSDBfMF9FY2NFcnJDbnQsIEVjY0VyckNu
dCkgLQogCQkgVU1DX1Y2XzFfQ0VfQ05UX0lOSVQpOwogCS8qIGNsZWFyIHRoZSBsb3dlciBjaGlw
IGVyciBjb3VudCAqLwotCVdSRUczMihlY2NfZXJyX2NudF9hZGRyICsgdW1jX3JlZ19vZmZzZXQs
IFVNQ19WNl8xX0NFX0NOVF9JTklUKTsKKwlXUkVHMzJfUENJRSgoZWNjX2Vycl9jbnRfYWRkciAr
IHVtY19yZWdfb2Zmc2V0KSAqIDQsIFVNQ19WNl8xX0NFX0NOVF9JTklUKTsKIAogCS8qIHNlbGVj
dCB0aGUgaGlnaGVyIGNoaXAgYW5kIGNoZWNrIHRoZSBlcnIgY291bnRlciAqLwogCWVjY19lcnJf
Y250X3NlbCA9IFJFR19TRVRfRklFTEQoZWNjX2Vycl9jbnRfc2VsLCBVTUNDSDBfMF9FY2NFcnJD
bnRTZWwsCiAJCQkJCUVjY0VyckNudENzU2VsLCAxKTsKLQlXUkVHMzIoZWNjX2Vycl9jbnRfc2Vs
X2FkZHIgKyB1bWNfcmVnX29mZnNldCwgZWNjX2Vycl9jbnRfc2VsKTsKLQllY2NfZXJyX2NudCA9
IFJSRUczMihlY2NfZXJyX2NudF9hZGRyICsgdW1jX3JlZ19vZmZzZXQpOworCVdSRUczMl9QQ0lF
KChlY2NfZXJyX2NudF9zZWxfYWRkciArIHVtY19yZWdfb2Zmc2V0KSAqIDQsIGVjY19lcnJfY250
X3NlbCk7CisJZWNjX2Vycl9jbnQgPSBSUkVHMzJfUENJRSgoZWNjX2Vycl9jbnRfYWRkciArIHVt
Y19yZWdfb2Zmc2V0KSAqIDQpOwogCSplcnJvcl9jb3VudCArPQogCQkoUkVHX0dFVF9GSUVMRChl
Y2NfZXJyX2NudCwgVU1DQ0gwXzBfRWNjRXJyQ250LCBFY2NFcnJDbnQpIC0KIAkJIFVNQ19WNl8x
X0NFX0NOVF9JTklUKTsKIAkvKiBjbGVhciB0aGUgaGlnaGVyIGNoaXAgZXJyIGNvdW50ICovCi0J
V1JFRzMyKGVjY19lcnJfY250X2FkZHIgKyB1bWNfcmVnX29mZnNldCwgVU1DX1Y2XzFfQ0VfQ05U
X0lOSVQpOworCVdSRUczMl9QQ0lFKChlY2NfZXJyX2NudF9hZGRyICsgdW1jX3JlZ19vZmZzZXQp
ICogNCwgVU1DX1Y2XzFfQ0VfQ05UX0lOSVQpOwogCiAJLyogY2hlY2sgZm9yIFNSQU0gY29ycmVj
dGFibGUgZXJyb3IKIAkgIE1DVU1DX1NUQVRVUyBpcyBhIDY0IGJpdCByZWdpc3RlciAqLwpAQCAt
MjgzLDIxICsyODksMjEgQEAgc3RhdGljIHZvaWQgdW1jX3Y2XzFfZXJyX2NudF9pbml0X3Blcl9j
aGFubmVsKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCX0KIAogCS8qIHNlbGVjdCB0aGUg
bG93ZXIgY2hpcCBhbmQgY2hlY2sgdGhlIGVycm9yIGNvdW50ICovCi0JZWNjX2Vycl9jbnRfc2Vs
ID0gUlJFRzMyKGVjY19lcnJfY250X3NlbF9hZGRyICsgdW1jX3JlZ19vZmZzZXQpOworCWVjY19l
cnJfY250X3NlbCA9IFJSRUczMl9QQ0lFKChlY2NfZXJyX2NudF9zZWxfYWRkciArIHVtY19yZWdf
b2Zmc2V0KSAqIDQpOwogCWVjY19lcnJfY250X3NlbCA9IFJFR19TRVRfRklFTEQoZWNjX2Vycl9j
bnRfc2VsLCBVTUNDSDBfMF9FY2NFcnJDbnRTZWwsCiAJCQkJCUVjY0VyckNudENzU2VsLCAwKTsK
IAkvKiBzZXQgY2UgZXJyb3IgaW50ZXJydXB0IHR5cGUgdG8gQVBJQyBiYXNlZCBpbnRlcnJ1cHQg
Ki8KIAllY2NfZXJyX2NudF9zZWwgPSBSRUdfU0VUX0ZJRUxEKGVjY19lcnJfY250X3NlbCwgVU1D
Q0gwXzBfRWNjRXJyQ250U2VsLAogCQkJCQlFY2NFcnJJbnQsIDB4MSk7Ci0JV1JFRzMyKGVjY19l
cnJfY250X3NlbF9hZGRyICsgdW1jX3JlZ19vZmZzZXQsIGVjY19lcnJfY250X3NlbCk7CisJV1JF
RzMyX1BDSUUoKGVjY19lcnJfY250X3NlbF9hZGRyICsgdW1jX3JlZ19vZmZzZXQpICogNCwgZWNj
X2Vycl9jbnRfc2VsKTsKIAkvKiBzZXQgZXJyb3IgY291bnQgdG8gaW5pdGlhbCB2YWx1ZSAqLwot
CVdSRUczMihlY2NfZXJyX2NudF9hZGRyICsgdW1jX3JlZ19vZmZzZXQsIFVNQ19WNl8xX0NFX0NO
VF9JTklUKTsKKwlXUkVHMzJfUENJRSgoZWNjX2Vycl9jbnRfYWRkciArIHVtY19yZWdfb2Zmc2V0
KSAqIDQsIFVNQ19WNl8xX0NFX0NOVF9JTklUKTsKIAogCS8qIHNlbGVjdCB0aGUgaGlnaGVyIGNo
aXAgYW5kIGNoZWNrIHRoZSBlcnIgY291bnRlciAqLwogCWVjY19lcnJfY250X3NlbCA9IFJFR19T
RVRfRklFTEQoZWNjX2Vycl9jbnRfc2VsLCBVTUNDSDBfMF9FY2NFcnJDbnRTZWwsCiAJCQkJCUVj
Y0VyckNudENzU2VsLCAxKTsKLQlXUkVHMzIoZWNjX2Vycl9jbnRfc2VsX2FkZHIgKyB1bWNfcmVn
X29mZnNldCwgZWNjX2Vycl9jbnRfc2VsKTsKLQlXUkVHMzIoZWNjX2Vycl9jbnRfYWRkciArIHVt
Y19yZWdfb2Zmc2V0LCBVTUNfVjZfMV9DRV9DTlRfSU5JVCk7CisJV1JFRzMyX1BDSUUoKGVjY19l
cnJfY250X3NlbF9hZGRyICsgdW1jX3JlZ19vZmZzZXQpICogNCwgZWNjX2Vycl9jbnRfc2VsKTsK
KwlXUkVHMzJfUENJRSgoZWNjX2Vycl9jbnRfYWRkciArIHVtY19yZWdfb2Zmc2V0KSAqIDQsIFVN
Q19WNl8xX0NFX0NOVF9JTklUKTsKIH0KIAogc3RhdGljIHZvaWQgdW1jX3Y2XzFfZXJyX2NudF9p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQpAQCAtMzA2LDYgKzMxMiw4IEBAIHN0YXRp
YyB2b2lkIHVtY192Nl8xX2Vycl9jbnRfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
IAl1aW50MzJfdCBjaF9pbnN0ICAgICAgICAgPSAwOwogCXVpbnQzMl90IHVtY19yZWdfb2Zmc2V0
ICA9IDA7CiAKKwl1bWNfdjZfMV9kaXNhYmxlX3VtY19pbmRleF9tb2RlKGFkZXYpOworCiAJZm9y
ICh1bWNfaW5zdCA9IDA7IHVtY19pbnN0IDwgYWRldi0+dW1jLnVtY19pbnN0X251bTsgdW1jX2lu
c3QrKykgewogCQlmb3IgKGNoX2luc3QgPSAwOyBjaF9pbnN0IDwgYWRldi0+dW1jLmNoYW5uZWxf
aW5zdF9udW07IGNoX2luc3QrKykgewogCQkJdW1jX3JlZ19vZmZzZXQgPSBnZXRfdW1jXzZfcmVn
X29mZnNldChhZGV2LAotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB36636EC5042C85407DB96379FB3F0MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB36636EC5042C85407DB96379FB3F0MN2PR12MB3663namp_--
