Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2E3C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 03:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365A82076A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 03:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KCd/sVy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365A82076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C89C56E379;
	Fri, 17 Jul 2020 03:03:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22146E379
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 03:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLX+P5es/juKVu829zhBUolBd8jP0ezxknTQQ9HvKczFoO59iuKm3EcvIxkxqiiPJke+3FKmB/A1H3HO7tO/QEEwfzjv8arBnKygvXmvAMMbYbN4Er3LASSugro9ImfuNJ13elG0McDsYOHPPBcxRGEcMWehFTFXLaymhKxhsYPh1BcO3uu0m9vPSWnq1LXSNmhqdisYtV6uvwFMcB3bKneMB0mPDlLCZ5uRRi7EwkyhfCqVzgaCBor2TUnjETfO360SL9D5f1hH5eOhrrR0tS2ncfujKP/0+TqakBG85W1YitLD6QhP2mQ/AH4mnfCfMBrAzz3zDlMY48jelmrWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmqdNIobJ4qk1wb0eKz+XyVZVBC3crlpT663uaoGcbE=;
 b=KlAbfxlhByUERkO0nJf6VasPvZpJNnVxDoYrHE8S9xNtf0qeh4J1WR5XY0ccxC2/wSao7CnYq0K86QIFqy3T8MISsJmg5/Gk0ciCHN39NdJyF6kT3yy5A7sX2DmiMtpgGSRRivPeO2ykMJkoVMyKWT8l/rE7RryCA36h38EHxMy7l/8sGAoXjKJSEl2FNdHiK8c9qMijjL9RqrN0UuR0jqc6oT8xq4iGgW6D7BUoudFWa3hgFVS7xKyUP4gqt1Z6/uJzEdIdAPuApj4UpCGRf4qajsxuszbP7Z4YtFo91/j8iUiGII4mrJZv8PGJzGt/Zvfg/oNH3Fq55p/AcIRYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmqdNIobJ4qk1wb0eKz+XyVZVBC3crlpT663uaoGcbE=;
 b=KCd/sVy7hVC32W/wbU9boAhcoCJKLJkDylc7QGRBJtV6eLpIhsQZaGK37E9Ky4qwD2ruahm73mkmvNF4q+WmTJhicxCRinFB1BgM6oV//V0og9Sd/MCJaeJxXcaldugd6Oj25o0te4UGJaQS+XNNePwfRTK7ZUB2LbuwTNCKtHs=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 17 Jul
 2020 03:03:51 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235%7]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 03:03:51 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: load asd for sienna cichlid
Thread-Topic: [PATCH] drm/amdgpu: load asd for sienna cichlid
Thread-Index: AdZb5s7W/orfS031TdOLk1oze16WOQ==
Date: Fri, 17 Jul 2020 03:03:50 +0000
Message-ID: <MN2PR12MB4032A940BE0A5268028FFFFFFB7C0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-17T03:03:45Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0406ebc4-0dba-4c39-999d-0000cc23c581;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-17T03:03:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 868a4d67-dd44-48ae-9b6d-00002eb80cfd
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-17T03:03:46Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 9f2f6319-2704-4132-b869-0000f10dae31
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1642125c-2360-41e9-89b5-08d829fe0847
x-ms-traffictypediagnostic: MN2PR12MB4423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4423E363074D08989E1B6D2DFB7C0@MN2PR12MB4423.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rxpEDsbx2UKpYwBYO5KEKFifp8ZIYlgVB/CpWc+Nqrv6sODkBPOPNlP6h8GYqAk6ISHkV53YP6BkTLsVaCvOpgPtRD9oT39IHTqZ+0x9Y0Vp1tVOMC8qYRaq1tmzeHi/HkOF6zydYeVXEnCVgJy2KT8RIrULhcv9uVnuT6BkqZzcsTf6XXDMQigsBflhDZGk5l8rnR5zg3HgRcmBoTLl3cG0bVkCJz1CAIdzzEHIk4forUbHuP+aaZ1wwk8b/Mo1P1adkkvbDktOjo+AxzsvVBK4E9DtefJwKPxyA7n7PiZh6lpTl12HDdFwGlp4On8uIQUXS8XS0tCVGZUWYBF8Ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(316002)(55016002)(66946007)(99936003)(558084003)(8936002)(66556008)(76116006)(66616009)(5660300002)(66476007)(86362001)(52536014)(2906002)(110136005)(66446008)(478600001)(64756008)(6636002)(33656002)(7696005)(8676002)(71200400001)(6506007)(26005)(9686003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Dap6uSFvedIKEB9hQU/2+iGt6aOOpXmzYulSjUYIEJH2vsQinNk8HFh8gEeV/ev6XHO/y2PYqWEm1vj8jf+NNm2gQGGytZI/Bt6/4GZqb+BWJ0/J3hK7ZMSMXM5oNGlqJ07WlbAFTt85/0+powagfzwkbdMi9Ji9Nu8jP7rQ6uo8ApUZnQMXP9gASNOk3QEH+e78GfishroOFQOTgE2LNpP1Bdp7Yi2ttU48Qq4/uD+gOrch/p4xmZkLcK/tHqnoV3Dew/GaypRAahSRDgQ+PJUNeCj2ffylmVkLf+qcNBcE2aEQ+4WSR96VTUn4RXRECyxoBLBFQFfr1txBoR5NlhEHN77AZXQ2cbxJWo9lUD7WkF5JrUpSTS48W1rPxwuSh4RNIas73MMEfZBnbheC+HvaSdIT2Tep7wYrBGSS//M78JMBm+Z23uncf+dNIhcv2y1GDFpeZ5o9WnCrSwoDSqOVtg2PrWDkArCZjy2m8r7wYyRot3jhmV6mRfG1fm72
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB4032A940BE0A5268028FFFFFFB7C0MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1642125c-2360-41e9-89b5-08d829fe0847
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 03:03:50.8963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mN7DsdYWLAerssg2F5lZ0zRffxbAQck2QI2PKBIQR4EvKiUX7dZ8uWczqPwS31+afoK1RG1+OPG7zRL3sqMrmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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

--_004_MN2PR12MB4032A940BE0A5268028FFFFFFB7C0MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032A940BE0A5268028FFFFFFB7C0MN2PR12MB4032namp_"

--_000_MN2PR12MB4032A940BE0A5268028FFFFFFB7C0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Submitting patch to enable ASD loading for Sienna Cichlid

--_000_MN2PR12MB4032A940BE0A5268028FFFFFFB7C0MN2PR12MB4032namp_
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
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to enable ASD loading for Sienna Ci=
chlid<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032A940BE0A5268028FFFFFFB7C0MN2PR12MB4032namp_--

--_004_MN2PR12MB4032A940BE0A5268028FFFFFFB7C0MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-load-asd-for-sienna-cichlid.patch"
Content-Description: 0001-drm-amdgpu-load-asd-for-sienna-cichlid.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-load-asd-for-sienna-cichlid.patch"; size=974;
	creation-date="Fri, 17 Jul 2020 03:02:00 GMT";
	modification-date="Fri, 17 Jul 2020 03:02:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzMmM4ZDYwMThmYTQ4YTM2YjY4YmM2ZWJlYTA5MDgxOTM5NWFkM2VmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgMTcgSnVsIDIwMjAgMTA6NTY6NTMgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBsb2FkIGFzZCBmb3Igc2llbm5hIGNpY2hsaWQKCmRvIG5vdCBhYm9ydCBwc3Ag
YXNkIGxvYWQgc2VxdWVuY2UgZm9yIHNpZW5uYSBjaWNobGlkCgpTaWduZWQtb2ZmLWJ5OiBKb2hu
IENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSWM2OTQ1NDM5NTI2
MjQ5YjQ0ZTZjMDJmOWZjNTE5YTI5Njg2MmRkOTcKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCmluZGV4IGFhODBjZjc5OWU0Mi4u
ODAzNDExMWFjZDlhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBA
IC01MDAsNyArNTAwLDYgQEAgc3RhdGljIGludCBwc3BfYXNkX2xvYWQoc3RydWN0IHBzcF9jb250
ZXh0ICpwc3ApCiAJICogVE9ETzogYWRkIHZlcnNpb24gY2hlY2sgdG8gbWFrZSBpdCBjb21tb24K
IAkgKi8KIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikgfHwKLQkgICAgKHBzcC0+YWRl
di0+YXNpY190eXBlID09IENISVBfU0lFTk5BX0NJQ0hMSUQpIHx8CiAJICAgIChwc3AtPmFkZXYt
PmFzaWNfdHlwZSA9PSBDSElQX05BVllfRkxPVU5ERVIpKQogCQlyZXR1cm4gMDsKIAotLSAKMi4x
Ny4xCgo=

--_004_MN2PR12MB4032A940BE0A5268028FFFFFFB7C0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB4032A940BE0A5268028FFFFFFB7C0MN2PR12MB4032namp_--
