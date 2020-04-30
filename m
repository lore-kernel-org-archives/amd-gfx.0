Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5DAC83001
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 08:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEBC20838
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 08:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TejxIHUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEBC20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B376EB78;
	Thu, 30 Apr 2020 08:30:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879836EB78
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 08:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9IvFxTzLBGb4PZsbtwOS0H6U2kirrdkPWqEKJ3k0Vz1EiXk+TygGyk08lvf9e48nXaBOhLI6qfBsm5X/7yZDMimOWlxbOMmRMD1zXQrh8HqlG0fcr4fun7YfL8yYp6ig8WXwe9WWOZoytae7Eq6zk9QPkftvwiW4hjrEkYf7zZU14Jiudmvav7jIuy1XtKvKarhkxA3tdq2tNNumo2hGbkRwuHppqeuxcQnntcJO/z4K8lMXqcc4Lk091VNm3luHFbHgrp0oos4MTrEtSKUCl3rfGPmi+tr3mDhYK8GuXzAUkySddKIuZu9/BWboUSD6Vys3UAhfpbflEhTIFe2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNX+4BZuOls+2UdTaB4s8drf/55DGOQ8UON9iRsYllk=;
 b=KXgQAY63+IbM5qFcvtIsIb/Wt0Eqx5vrMpvbf/uvwRHBXpWGKeEnYV58lk5goPfUxEDKT8dyQPFlwJucvoanjwGFsso3DtwWV+EevsvBuHV20Sr/XTPhj4gAd9T6MHHTJOIhn+0QSEVELy+spgDYISSP0CqDOzpo2WxWmKolxMYuZyINhSd2wo9a31jjSr37R8fwzH7xtS/ft/tbLO6zbKsWBnKIHaq2ZJzbszb/SPiOr4n+pQgaPe11taJx+UyiYkQ8dlOMMUMX9EkGBa3gvifrKEtdjS8PRiBJfr0yUAkLEnAAJLibNwCCt0UmpTiuc8hRPTqUnw0M6IcOtHFJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNX+4BZuOls+2UdTaB4s8drf/55DGOQ8UON9iRsYllk=;
 b=TejxIHUn3piHUdKcOuU8vR8h3K5ZmOOpkkfHAxqXQxB06eUP7WhHS6ITw37wxPs43Y3qRBDHruN/PnZHRqw6j6CUD4xpFWfUlGTsHT8lx8RFtuXO1zcG5Hh0xnxursZIHXaNhJsOMyZDQbpAKpyN8TmhiqIe+/8L/UsvQHQX5NM=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 08:30:46 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8%7]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 08:30:46 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update RAS error handling
Thread-Topic: [PATCH] drm/amdgpu: update RAS error handling
Thread-Index: AdYeyYG/vYosBN4rRxSNyF4zsEbtmQ==
Date: Thu, 30 Apr 2020 08:30:46 +0000
Message-ID: <MN2PR12MB4032936B55EAF00E60424ED1FBAA0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-30T08:30:42Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ea86b260-2a5b-4fa4-a62e-0000db3ff5f0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-30T08:30:42Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f7123738-88ca-4393-ac9b-0000e8747d53
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a66636d-53b5-4ca0-f33b-08d7ece0c7b8
x-ms-traffictypediagnostic: MN2PR12MB4584:|MN2PR12MB4584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45846923A2FE3944955BB806FBAA0@MN2PR12MB4584.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0nj+wzPdqHG1KOGVyKjjQErTMDknmup2iwsNg1mKiqpfgR1lto8LXR0tUlyZNiShmHS+DeO3nQiGthu1JIUPlBK8h6aeaG8wZwqfrRxpmIcReHNpE4ZM5bD24pYXHtiStyrWfMrdeKH4hzHgc0iuCfjC/AXlzVpSdiZGUFP27Y46L2pIHUrGi4MtP5L2PYVBVCisGOOsrz7dErVgJ75zIpaY7djai0wVnSAHLLRUqLNAmZEbBRqPN4uBSYs1CeBSVeSBItAFg4s7j2mx7YNN1lt8BCKZAba3M1KdnU3FDbKTjlDoBXIEvuRCQB+GLzW0x6pbeYcdqQanYIEsKSu0v4oHEosMF7C7moMUoKgIRpJH0x5yYnyEaC+3uZZKVwHR4wGWwGZlJ678sJRWRnwY1LdB/Yqm0wawvguMIiTRLwomVJkmqD+MdI22tc9aA7KN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(316002)(558084003)(9686003)(6506007)(55016002)(7696005)(26005)(8936002)(5660300002)(99936003)(33656002)(2906002)(71200400001)(186003)(86362001)(66476007)(66616009)(110136005)(66556008)(64756008)(66446008)(8676002)(66946007)(52536014)(76116006)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RFYyI2zA+i1QObApLfSLGppZjlydvN198RkbYsgcDixj32kP6ryMrvwGAWGhISKWwCulfIuhrEKB8wU/2p2TmqyTQSLCNi/omtmTjdynUkCAoASKL9cJf+XX43OV69owcGuxj04OQoAmU5jrDbFaL4L1VWJ274YxMlE0//WasJlBlnvHFTu8NQV/B+Tm0TdApFSnRiW5dmKJJ4DRDCdMdgll03nOC3MJdwP5FwezBH94am0J4a+Nx/AcA+WJJlHLXJYzbM/QqUlJPRxry1J8FcC9ELnUT1WhjHnRcOp/Zo0ZWDyk0sxOfij9CV5Ak7iwwwcr3sGmP4WdoI9B6qNb/++PYWW7gBBchK1gKINX8a+HduQ9tcww25+GEdc+N6e00NbirzjIOR4JZHANCkB7owl0gArDyRob8iccaZomtXtWzV6X1Osyr6zE9v1RKw60jUk1WXsGZleuqJSTDGZ4gACeZBfZbPoPYWRA2Ny/iE8sfPsFA3VXyy0VBuQAL8docDrubD6r9h2MHalb5h6D/f5op3ztvfT+Hw4ftJvGxcm5cJY1L+lJjIUpClCzVa3D9BvDUbrazFihwRWTLNETy2R5poFUrM/0Cd7EmGtPVxwrXHU03ATVOHAgoEmPYqsPkprrY8ekmq5DPVLLY7yb5+x3aC5CPQKP7yTr5bDk6KSq/utObKJ9DCJZLoHZKzW8MnnPz/CM6ZClA/RP7tdDRS0mUuqnDWY9VtRfvbkdavMz59xRV/NXBmCXRA5u2OhootcHmIcTOhNv3m+fz8QuKXZafuAzAJH8SfL7af8gg7I=
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB4032936B55EAF00E60424ED1FBAA0MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a66636d-53b5-4ca0-f33b-08d7ece0c7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 08:30:46.2211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTce6+S/O9PFkE/+wW1sqF2rB2FdpB8FQ+4lRo8KE+jgXP0jyFFM1ywddmtf3Op8hIWeP+BGWy16X0d1rz5g8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584
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

--_004_MN2PR12MB4032936B55EAF00E60424ED1FBAA0MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032936B55EAF00E60424ED1FBAA0MN2PR12MB4032namp_"

--_000_MN2PR12MB4032936B55EAF00E60424ED1FBAA0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch for review to parse return status from TA to determine err=
or severity

Thank you,
John Clements

--_000_MN2PR12MB4032936B55EAF00E60424ED1FBAA0MN2PR12MB4032namp_
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
<p class=3D"MsoNormal">Submitting patch for review to parse return status f=
rom TA to determine error severity<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032936B55EAF00E60424ED1FBAA0MN2PR12MB4032namp_--

--_004_MN2PR12MB4032936B55EAF00E60424ED1FBAA0MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-update-RAS-error-handling.patch"
Content-Description: 0001-drm-amdgpu-update-RAS-error-handling.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-update-RAS-error-handling.patch"; size=2468;
	creation-date="Thu, 30 Apr 2020 08:29:00 GMT";
	modification-date="Thu, 30 Apr 2020 08:29:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0OWZjMGI5ZWExOWUwYTQ0ZDE4NzJmMGZjNjU4Y2MzOWQ1MWVmNmJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgMzAgQXByIDIwMjAgMTY6MjU6NTAgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiB1cGRhdGUgUkFTIGVycm9yIGhhbmRsaW5nCgpQYXJzZSByZXR1cm4gc3RhdHVz
IGZyb20gVEEgdG8gZGV0ZXJtaW5lIGVycm9yIHNldmVyaXR5CgpTaWduZWQtb2ZmLWJ5OiBKb2hu
IENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSWQzZmE1YzE4MDMw
NTgxYzhjN2I3OTM0OWYzM2E2ODQ1YjViYjBkZTUKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmFzLmMgfCA0MCArKysrKysrKysrKysrKysrKysrLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKaW5kZXggOGIxNGFlZTM3MGM4Li41Mzg4OTVjZmQ4NjIg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKQEAgLTUwMiw2ICs1MDIs
MjkgQEAgc3RydWN0IHJhc19tYW5hZ2VyICphbWRncHVfcmFzX2ZpbmRfb2JqKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAogfQogLyogb2JqIGVuZCAqLwogCit2b2lkIGFtZGdwdV9yYXNfcGFy
c2Vfc3RhdHVzX2NvZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UqIGFkZXYsCisJCQkJICBjb25zdCBj
aGFyKiAJCWludm9rZV90eXBlLAorCQkJCSAgY29uc3QgY2hhciogCQlibG9ja19uYW1lLAorCQkJ
CSAgZW51bSB0YV9yYXNfc3RhdHVzIAlyZXQpCit7CisJc3dpdGNoIChyZXQpIHsKKwljYXNlIFRB
X1JBU19TVEFUVVNfX1NVQ0NFU1M6CisJCXJldHVybjsKKwljYXNlIFRBX1JBU19TVEFUVVNfX0VS
Uk9SX1JBU19OT1RfQVZBSUxBQkxFOgorCQlkZXZfd2FybihhZGV2LT5kZXYsCisJCQkiUkFTIFdB
Uk46ICVzICVzIGN1cnJlbnRseSB1bmF2YWlsYWJsZVxuIiwKKwkJCWludm9rZV90eXBlLAorCQkJ
YmxvY2tfbmFtZSk7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCWRldl9lcnIoYWRldi0+ZGV2LAor
CQkJIlJBUyBFUlJPUjogJXMgJXMgZXJyb3IgZmFpbGVkIHJldCAweCVYXG4iLAorCQkJaW52b2tl
X3R5cGUsCisJCQlibG9ja19uYW1lLAorCQkJcmV0KTsKKwl9Cit9CisKIC8qIGZlYXR1cmUgY3Rs
IGJlZ2luICovCiBzdGF0aWMgaW50IGFtZGdwdV9yYXNfaXNfZmVhdHVyZV9hbGxvd2VkKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogCQlzdHJ1Y3QgcmFzX2NvbW1vbl9pZiAqaGVhZCkKQEAg
LTU5MiwxMSArNjE1LDEwIEBAIGludCBhbWRncHVfcmFzX2ZlYXR1cmVfZW5hYmxlKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAogCWlmICghYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKSB7
CiAJCXJldCA9IHBzcF9yYXNfZW5hYmxlX2ZlYXR1cmVzKCZhZGV2LT5wc3AsICZpbmZvLCBlbmFi
bGUpOwogCQlpZiAocmV0KSB7Ci0JCQlkZXZfZXJyKGFkZXYtPmRldiwgIlJBUyBFUlJPUjogJXMg
JXMgZmVhdHVyZSAiCi0JCQkJCSJmYWlsZWQgcmV0ICVkXG4iLAotCQkJCQllbmFibGUgPyAiZW5h
YmxlIjoiZGlzYWJsZSIsCi0JCQkJCXJhc19ibG9ja19zdHIoaGVhZC0+YmxvY2spLAotCQkJCQly
ZXQpOworCQkJYW1kZ3B1X3Jhc19wYXJzZV9zdGF0dXNfY29kZShhZGV2LAorCQkJCQkJICAgICBl
bmFibGUgPyAiZW5hYmxlIjoiZGlzYWJsZSIsCisJCQkJCQkgICAgIHJhc19ibG9ja19zdHIoaGVh
ZC0+YmxvY2spLAorCQkJCQkJICAgIChlbnVtIHRhX3Jhc19zdGF0dXMpcmV0KTsKIAkJCWlmIChy
ZXQgPT0gVEFfUkFTX1NUQVRVU19fUkVTRVRfTkVFREVEKQogCQkJCXJldHVybiAtRUFHQUlOOwog
CQkJcmV0dXJuIC1FSU5WQUw7CkBAIC04MjEsMTAgKzg0MywxMCBAQCBpbnQgYW1kZ3B1X3Jhc19l
cnJvcl9pbmplY3Qoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCXJldCA9IC1FSU5WQUw7
CiAJfQogCi0JaWYgKHJldCkKLQkJZGV2X2VycihhZGV2LT5kZXYsICJSQVMgRVJST1I6IGluamVj
dCAlcyBlcnJvciBmYWlsZWQgcmV0ICVkXG4iLAotCQkJCXJhc19ibG9ja19zdHIoaW5mby0+aGVh
ZC5ibG9jayksCi0JCQkJcmV0KTsKKwlhbWRncHVfcmFzX3BhcnNlX3N0YXR1c19jb2RlKGFkZXYs
CisJCQkJICAgICAiaW5qZWN0IiwKKwkJCQkgICAgIHJhc19ibG9ja19zdHIoaW5mby0+aGVhZC5i
bG9jayksCisJCQkJICAgICAoZW51bSB0YV9yYXNfc3RhdHVzKXJldCk7CiAKIAlyZXR1cm4gcmV0
OwogfQotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB4032936B55EAF00E60424ED1FBAA0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB4032936B55EAF00E60424ED1FBAA0MN2PR12MB4032namp_--
