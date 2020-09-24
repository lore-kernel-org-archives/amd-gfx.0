Return-Path: <SRS0=YZDW=DB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBFFC4363D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 10:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6D52053B
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 10:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eKFNf+pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6D52053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967026E1D6;
	Thu, 24 Sep 2020 10:37:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226906E1D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 10:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjfetCYqMwLKQtl5+bTpeY1mhBrtfOjPQBdfA1BzLMOUX8NueL1DKdtYS7lwrNGP5Ey8JshpXjNyR5oEK+sIrNY+0uKxYpDqdHRJiB/U+F2ZIWE6ao7TEJvdsYuyPzKi6MSwuWW4xWDW9RzGNSbbEoRvzQLWOdNxB+qJwoes5oQ6Estk0V881sBNJNp+ADnnvvAdTvt5PN1nR6hS4bJ3GU46J567VTRwMsSO2PH9nOMcRQmNQX5uuCWAOO+Z1R8ZGaA0AqShloLQbId9ui3/0FeFputHGRDr8YJGRIkWeHEeqvU8dOSmqRk+YOS8F+qINMCHijcVcmHuo1y/moznmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbj3O3SVVjYnxnphtODX1EXyWSuQnDoC2EYGDEyMD1E=;
 b=I0agVHnUg9/8j5NvTmLRNF2oXZM/fJan55u9GmYNOlkdprxN/MmGv4Fmw7Zi9e4SoeihxcJn8EouOmBbXCqO4FJAByJnYuTe/hy+HU3XLopWCcVUs5qHnRLR9prSAY4NoIzLemjU9huAzCjuDFkA8j9fqHh4s4dlgV0T9Ky3Gv6upCb8+GJA6jLmG4IcPB9JebCXTH/UJSVOO20t8c3WuVHfmGkMsqcNbkE0IGomH8e+X+lLbONUwBGG9X1jfOHnVEZ3xDCNE8oOH4kg7xnG2wQPv7ip3Qoyi0fjeCt7Lp6yjsSa2Dre54ri3iZVDaQjAmUJJOMbDrezXksERhppJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbj3O3SVVjYnxnphtODX1EXyWSuQnDoC2EYGDEyMD1E=;
 b=eKFNf+pfCwvS919Y8BIBKoh2tIKBV4obZbHH6+XNN8Xewe8uEnram01Ou9YCETIll9ORg2I7JVizXWvR1WpSZj74cWWTboARhqe2M35uAsRwCBVijJ3RvI8bvotMIR9MYWaKxnUuyTfZw0ikm8LUAhvCluWpKm3At+sIF2FMb2E=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4800.namprd12.prod.outlook.com (2603:10b6:208:3c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 10:37:17 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::2886:b3eb:a9b0:5d29]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::2886:b3eb:a9b0:5d29%7]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 10:37:17 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: disable sienna chichlid UMC RAS
Thread-Topic: [PATCH] drm/amdgpu: disable sienna chichlid UMC RAS
Thread-Index: AdaSXo9zLAYJjZoMS5uJ71KjY8zvew==
Date: Thu, 24 Sep 2020 10:37:16 +0000
Message-ID: <MN2PR12MB4032E752E8201ABE9F7B48BCFB390@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-24T10:37:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=21d67acb-ddc5-4b16-a7af-000081c4ed1b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-24T10:37:06Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 197f1e34-583d-4d93-909b-00008ee4ab40
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83e5593a-106d-4876-333e-08d86075cf08
x-ms-traffictypediagnostic: MN2PR12MB4800:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB48003A2D5362B2018937416AFB390@MN2PR12MB4800.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3b66qtONyyXhVnL+5mjo2mcSVDq+/Hu7sEZIlvH55SubdIGnrlRELcgX3GWyB016zZocVtNoeos5ZqTxoGAJCv71Sd5ZYypEK7ffomppDi6+piO3mmBuSbWZomlRkvvFRmRbtIREdJnad+sLd3/VaVYWSajjpdV9DcY6N7DZR5zyf1kjuzydpy1g9DHJHcO0eQnYqx/gs1OGXJs10QzsRWJePloYmOw28SCTR6MAGSjFfe6W4hyLhsYKtPIgoL5izZq1OGsdmiCVOgPIjSJaetZqRQzgjrqzbmWZIt5YoDo1zZo7wC0rVHArly60zWxy8qa5WCWpa00DFfHJYl2IoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(558084003)(71200400001)(99936003)(66556008)(6636002)(66476007)(6506007)(5660300002)(8936002)(52536014)(7696005)(9686003)(76116006)(2906002)(8676002)(66616009)(55016002)(66946007)(33656002)(478600001)(26005)(186003)(64756008)(316002)(86362001)(66446008)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: QOwPuJFzyzmts0wHCQ8ogZnVtkkn/BN5SYAwSlqDgPvD2MD7+GIC4wqiVvRQpoY7V+vIX7uCGPHthA/An5prQsXZKOGVjrGQL48LMXty9UD1bzhHVvD1O3czz6EMFT4YXvFUwaLxnvsCib7AlW5XBhuTYU8UMITT64zaw/0JawWJoxa8mVw78A31HvMZHrYXXBc7rM034sw9H1EmDvDmB6DgSTyfmBnUHZ7uWc0nG2G8dSWYT5TIt/c9PSETQz4ajepFB0zM7P150f9FBJRavNn+2mXMtXQkkOivd7EDCLWY3yJosjMEkzS9STsQGKQ55SyPtKghwMc7qPiem9449JNZTcz2BrSHH4ui7CdAn0kK0ps8MJcxs9DMVhfvnhcgyvs0MAzyXCa7VyJjYyZi5LyJstW3GfRSNTLLE45h1qu7TccpZyFehz3Jh4wnCbQ8TiXMuQOOQW9JLYbAuoGVtgld7FyR1gFFPK1Wk2NLRUIAhZx4sVTDWWMCuRugyU+hYktX8fbme4I1MCCGsc7C5sqQkvkrOuZscVjz0XSTp4v/fPK/pnJVIiH4xqtMvNuMA2rhVxf+rBhTYyKQ7MxteYzqO3TAfiAEht8G4RQJ9J8JLnA9ArvPDUTA+NGKQMt5+dHLj09MNfKmk/jQ0AgAzQ==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB4032E752E8201ABE9F7B48BCFB390MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e5593a-106d-4876-333e-08d86075cf08
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 10:37:17.2777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLqfpXmAkHcJU4lm+vrt9285DZOFx8gSGpbNavd28K5qGswzLrvHUNW2gxRJNYCQ8JjxLae5cYjwcb+zkP8ZNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4800
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

--_004_MN2PR12MB4032E752E8201ABE9F7B48BCFB390MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032E752E8201ABE9F7B48BCFB390MN2PR12MB4032namp_"

--_000_MN2PR12MB4032E752E8201ABE9F7B48BCFB390MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to dsiable UMC RAS for sienna chichlid

--_000_MN2PR12MB4032E752E8201ABE9F7B48BCFB390MN2PR12MB4032namp_
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
<p class=3D"MsoNormal">Submitting patch to dsiable UMC RAS for sienna chich=
lid<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032E752E8201ABE9F7B48BCFB390MN2PR12MB4032namp_--

--_004_MN2PR12MB4032E752E8201ABE9F7B48BCFB390MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-disable-sienna-chichlid-UMC-RAS.patch"
Content-Description: 0001-drm-amdgpu-disable-sienna-chichlid-UMC-RAS.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-disable-sienna-chichlid-UMC-RAS.patch"; size=1205;
	creation-date="Thu, 24 Sep 2020 10:36:00 GMT";
	modification-date="Thu, 24 Sep 2020 10:36:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3NGMwYTU2ODVhOTY5MzhkODhiZWI0MTU1YmU0OWRiYmRiNmE4YjhmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgMjQgU2VwIDIwMjAgMTg6MzQ6MzIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBkaXNhYmxlIHNpZW5uYSBjaGljaGxpZCBVTUMgUkFTCgpkaXNhYmxlIFVNQyBS
QVMgaW4gbGlldSBvZiBzdGFiaWxpdHkgaXNzdWVzIG9uIGNlcnRhaW4gc2t1CgpDaGFuZ2UtSWQ6
IEk0NDc5ZDNkY2NhODUzOTBiZTY0ODIxMTU4YWNhNWZjNWEzZTdhMjA3Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXMuYwppbmRleCA0MDYxNGFjOWExMTEuLjdmNzlkMjVmYmNjYyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwpAQCAtMjAwOCw4ICsyMDA4LDcgQEAgc3Rh
dGljIGludCBhbWRncHVfcmFzX2NoZWNrX2FzaWNfdHlwZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIHsKIAlpZiAoYWRldi0+YXNpY190eXBlICE9IENISVBfVkVHQTEwICYmCiAJCWFkZXYt
PmFzaWNfdHlwZSAhPSBDSElQX1ZFR0EyMCAmJgotCQlhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9B
UkNUVVJVUyAmJgotCQlhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9TSUVOTkFfQ0lDSExJRCkKKwkJ
YWRldi0+YXNpY190eXBlICE9IENISVBfQVJDVFVSVVMpCiAJCXJldHVybiAxOwogCWVsc2UKIAkJ
cmV0dXJuIDA7CkBAIC0yMDUzLDYgKzIwNTIsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfcmFzX2No
ZWNrX3N1cHBvcnRlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAogCSpzdXBwb3J0ZWQg
PSBhbWRncHVfcmFzX2VuYWJsZSA9PSAwID8KIAkJCTAgOiAqaHdfc3VwcG9ydGVkICYgYW1kZ3B1
X3Jhc19tYXNrOworCiAJYWRldi0+cmFzX2ZlYXR1cmVzID0gKnN1cHBvcnRlZDsKIH0KIAotLSAK
Mi4xNy4xCgo=

--_004_MN2PR12MB4032E752E8201ABE9F7B48BCFB390MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB4032E752E8201ABE9F7B48BCFB390MN2PR12MB4032namp_--
