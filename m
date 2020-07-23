Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015A0C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF7B20768
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pg0+nkst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF7B20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F55A6E864;
	Thu, 23 Jul 2020 08:30:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987A56E866
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 08:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGmWlskM7P0dkueYbgjk/vraoMJmGERMML9GwVToo4HrreGpFaU7qb5wY24WCQDezTJNq42pmw4IY5yV2/qemhiUM1BeMjQB7YhvF8XF0SflAukirluyASu7NppbyxWKFjMegx8mE9NWm56RJS1b7pXNzlW4IllDitaZbR6ePPuDLwL615B1D4qQdkwGqE/Lc2OqaMXP3SItbnQHN0YXQIiSmNTXuEAQHaftpnFyI+hGffcs2iCdMsRfTs+QkCAR7hT2tlp3e2KMq3JrUPnGBPbNjfn1VNkmX+B8Uw2kwMdWA4RiD+BLthI4E/4k+ZGTIWGjy+xmvlozv/O3dU3Z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJj9SwJ1NZp963PmeTHoOyKBJ5s/CNtXxUqkf0sN2AM=;
 b=WdD+sOMWoGqyN6+dpyclBnbIYiSvPffuRtBTydEBmoNoF4TXdSCAamg78hvcuGwalzRgFQs24Xadkraus50bxxdV80MVaub/pYmSr9TFGPMj8UvnXgqA9NmVam5l+8G8wA4cwqiIymadh1ECIfbS5RXEZsZMXMy3qSobEDY97pB4uxypvaUtK6kEyWECJOXlfkAYzrYpha4QT8r/3QVMzk4SOpwit2DIARmVynsLe8a6Sk79lmETZ+hbjPcxPBF3aRuRzDhWP/qaU1RNjG4QUDHbrFqL5uIauHQcvKgMWJIOgvGfm0R/05+k5z5o2SdG0qkY9d/JsOybhuxOTn6lNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJj9SwJ1NZp963PmeTHoOyKBJ5s/CNtXxUqkf0sN2AM=;
 b=pg0+nkstI+oBaitKTnkLnTKyRE1r14eZ38YILL1+BN3L3zyVrM4F1IJWTatF/pQOHaoLPN0JynWLenifk0j2nVxwu0AMsNgebOZFtRCIhlxNPpCdFqbEEPPA/khJLQNAf3q1bWLNCZVlZjRNzrxpD693RuMRb0FlVg5+UJkKiz8=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by BL0PR12MB2371.namprd12.prod.outlook.com (2603:10b6:207:3e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 23 Jul
 2020 08:30:15 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235%7]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 08:30:15 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: move umc specific macros to header
Thread-Topic: [PATCH] drm/amdgpu: move umc specific macros to header
Thread-Index: AdZgy1PjQhVeadPiSFCvsvxsTf9JPA==
Date: Thu, 23 Jul 2020 08:30:15 +0000
Message-ID: <MN2PR12MB40329A1571EB417279DB98D4FB760@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-23T08:30:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=17bae4e3-f9c9-4258-8cc4-0000519394f4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-23T08:30:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: dddb597a-1722-4048-a9fa-0000701af2e8
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-23T08:30:12Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: adf2be3e-f716-438d-ab20-0000a67da446
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d7a6504-e2be-426e-25f3-08d82ee2a010
x-ms-traffictypediagnostic: BL0PR12MB2371:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB237107854C1855D001CE3F4FFB760@BL0PR12MB2371.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0U6i1gDJSGTRz1aa9Dm2/kHcMDbweMeBDx7QhBcylQ1/U80jMoeI1tOAhtFykDFLwRChM3fYBQuLX4H2sKZSuFqXQmuKfM305xEeNqr1YQMgUHbde4snC/lL1CU1IbvQjIX9Oxm8sq4z7uRMR1hFW3HEzT8m6iO2bm6bAf0opRBXMkahCCxTb0Tt90zFsLkg9jPwwS9xuNckZEXpvZHgLX3IQntxkrhyNsZaJXyVFJ/EJ93XlDKsZ1XpPsaHnTWca4L8lvoN1scaDjYZxITMtTuwyR8EK7vR49iNgoEBo5Fj19DOhy/710RUFS2K+1f
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(26005)(6636002)(2906002)(478600001)(66556008)(66946007)(64756008)(66616009)(99936003)(86362001)(66446008)(52536014)(8936002)(5660300002)(66476007)(76116006)(6506007)(55016002)(558084003)(9686003)(186003)(7696005)(316002)(71200400001)(8676002)(33656002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qmInGbkjba3a6AwTa/07WzncrxpowCQWYNCiwqx/OGeHe36+G4Dq30dATjxnlXXCCCVB1R5C02nh7nsSyZjhH3Z6uRXGBFtcp6rM+TUhoW/WkYmw5lgtt2ZvTo2exYotIq4ocvcOiyQoISG3liDq55k9X08MlLxAYPMhyVWzEAXs8EQgaOPHBBRkb6GM8htzxA/eSkfXqXOWhywfN493OSVuuiv4oU9l5Fu7a6tRgyjsR+Usp+KhRMK/Ef6qU9ymjgMiuNWgvdIPM2IvXkdqNDjJYhnHyx4KohrihFwcuCq+gohPCKlSfhzLFnVEYReCXSCBPQhw0vhdFh0JULSqYZ6NjSIFJCw+fECVBD9cddzvj05/L40fmNl8GR51A6M826qvd+6Vw1Ol6/j2R3/7mUf0tAWmIJk/CcRf6F5k4ZIyh9UwU60tkbqX071hDWxXsyl9bhjbvda0xByzeQwDnkY2Hslmxs7pKIVMoNzQavR1NJXXXH9ZNYMj/V6cWlAg
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB40329A1571EB417279DB98D4FB760MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7a6504-e2be-426e-25f3-08d82ee2a010
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 08:30:15.4895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0SdWFKZOU3BwvMVCqHKyJcAxVBMrOiid6+jvMT4pnErZ77aJg8VzUgSof9G1jos5VceDFooY4ZqmlgFA1ZI/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2371
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

--_004_MN2PR12MB40329A1571EB417279DB98D4FB760MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB40329A1571EB417279DB98D4FB760MN2PR12MB4032namp_"

--_000_MN2PR12MB40329A1571EB417279DB98D4FB760MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Submitting patch to move umc channel/instance loop macros to header file to=
 be used as common macros for all umc versions

Thank you,
John Clements

--_000_MN2PR12MB40329A1571EB417279DB98D4FB760MN2PR12MB4032namp_
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
<p class=3D"MsoNormal">Submitting patch to move umc channel/instance loop m=
acros to header file to be used as common macros for all umc versions<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB40329A1571EB417279DB98D4FB760MN2PR12MB4032namp_--

--_004_MN2PR12MB40329A1571EB417279DB98D4FB760MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-move-umc-specific-macros-to-header.patch"
Content-Description: 0001-drm-amdgpu-move-umc-specific-macros-to-header.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-move-umc-specific-macros-to-header.patch";
	size=2772; creation-date="Thu, 23 Jul 2020 08:29:00 GMT";
	modification-date="Thu, 23 Jul 2020 08:29:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5OTNiMmQ4OTI1ZDA5Yzg2ZGQ1NmIzNTk1ODUxOWU3MzBmYjU1N2ZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgMjMgSnVsIDIwMjAgMTY6Mjg6MTEgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJtL2FtZGdwdTogbW92ZSB1bWMgc3BlY2lmaWMgbWFjcm9zIHRvIGhlYWRlcgoKY2VydGFp
biB1bWMgbWFjcm9zIGFyZSBjb21tb24gYWNyb3NzIHVtYyB2ZXJzaW9ucwoKU2lnbmVkLW9mZi1i
eTogSm9obiBDbGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpDaGFuZ2UtSWQ6IEkyODZl
YWU1NTEyYjNhMTJiYTY0Y2ZjMjIwMjdiMmZjYzNjNDIzMDMzCi0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3VtYy5oIHwgMTQgKysrKysrKysrKysrKysKIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMgICB8IDE0IC0tLS0tLS0tLS0tLS0tCiAyIGZpbGVz
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMuaAppbmRleCBhNjE1YTFlYjc1MGIuLjE4MzgxNDQ5MzY1
OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VtYy5oCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMuaApAQCAtMjEsNiArMjEs
MjAgQEAKICNpZm5kZWYgX19BTURHUFVfVU1DX0hfXwogI2RlZmluZSBfX0FNREdQVV9VTUNfSF9f
CiAKKy8qCisgKiAoYWRkciAvIDI1NikgKiA4MTkyLCB0aGUgaGlnaGVyIDI2IGJpdHMgaW4gRXJy
b3JBZGRyCisgKiBpcyB0aGUgaW5kZXggb2YgOEtCIGJsb2NrCisgKi8KKyNkZWZpbmUgQUREUl9P
Rl84S0JfQkxPQ0soYWRkcikJCQkoKChhZGRyKSAmIH4weGZmVUxMKSA8PCA1KQorLyogY2hhbm5l
bCBpbmRleCBpcyB0aGUgaW5kZXggb2YgMjU2QiBibG9jayAqLworI2RlZmluZSBBRERSX09GXzI1
NkJfQkxPQ0soY2hhbm5lbF9pbmRleCkJKChjaGFubmVsX2luZGV4KSA8PCA4KQorLyogb2Zmc2V0
IGluIDI1NkIgYmxvY2sgKi8KKyNkZWZpbmUgT0ZGU0VUX0lOXzI1NkJfQkxPQ0soYWRkcikJCSgo
YWRkcikgJiAweGZmVUxMKQorCisjZGVmaW5lIExPT1BfVU1DX0lOU1QodW1jX2luc3QpIGZvciAo
KHVtY19pbnN0KSA9IDA7ICh1bWNfaW5zdCkgPCBhZGV2LT51bWMudW1jX2luc3RfbnVtOyAodW1j
X2luc3QpKyspCisjZGVmaW5lIExPT1BfVU1DX0NIX0lOU1QoY2hfaW5zdCkgZm9yICgoY2hfaW5z
dCkgPSAwOyAoY2hfaW5zdCkgPCBhZGV2LT51bWMuY2hhbm5lbF9pbnN0X251bTsgKGNoX2luc3Qp
KyspCisjZGVmaW5lIExPT1BfVU1DX0lOU1RfQU5EX0NIKHVtY19pbnN0LCBjaF9pbnN0KSBMT09Q
X1VNQ19JTlNUKCh1bWNfaW5zdCkpIExPT1BfVU1DX0NIX0lOU1QoKGNoX2luc3QpKQorCiBzdHJ1
Y3QgYW1kZ3B1X3VtY19mdW5jcyB7CiAJdm9pZCAoKmVycl9jbnRfaW5pdCkoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpOwogCWludCAoKnJhc19sYXRlX2luaXQpKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192
Nl8xLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5jCmluZGV4IDQxOGNm
MDk3YzkxOC4uNTI4ODYxN2NhNTUyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS91bWNfdjZfMS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8x
LmMKQEAgLTMyLDIwICszMiw2IEBACiAKICNkZWZpbmUgVU1DXzZfSU5TVF9ESVNUCQkJMHg0MDAw
MAogCi0vKgotICogKGFkZHIgLyAyNTYpICogODE5MiwgdGhlIGhpZ2hlciAyNiBiaXRzIGluIEVy
cm9yQWRkcgotICogaXMgdGhlIGluZGV4IG9mIDhLQiBibG9jawotICovCi0jZGVmaW5lIEFERFJf
T0ZfOEtCX0JMT0NLKGFkZHIpCQkJKCgoYWRkcikgJiB+MHhmZlVMTCkgPDwgNSkKLS8qIGNoYW5u
ZWwgaW5kZXggaXMgdGhlIGluZGV4IG9mIDI1NkIgYmxvY2sgKi8KLSNkZWZpbmUgQUREUl9PRl8y
NTZCX0JMT0NLKGNoYW5uZWxfaW5kZXgpCSgoY2hhbm5lbF9pbmRleCkgPDwgOCkKLS8qIG9mZnNl
dCBpbiAyNTZCIGJsb2NrICovCi0jZGVmaW5lIE9GRlNFVF9JTl8yNTZCX0JMT0NLKGFkZHIpCQko
KGFkZHIpICYgMHhmZlVMTCkKLQotI2RlZmluZSBMT09QX1VNQ19JTlNUKHVtY19pbnN0KSBmb3Ig
KCh1bWNfaW5zdCkgPSAwOyAodW1jX2luc3QpIDwgYWRldi0+dW1jLnVtY19pbnN0X251bTsgKHVt
Y19pbnN0KSsrKQotI2RlZmluZSBMT09QX1VNQ19DSF9JTlNUKGNoX2luc3QpIGZvciAoKGNoX2lu
c3QpID0gMDsgKGNoX2luc3QpIDwgYWRldi0+dW1jLmNoYW5uZWxfaW5zdF9udW07IChjaF9pbnN0
KSsrKQotI2RlZmluZSBMT09QX1VNQ19JTlNUX0FORF9DSCh1bWNfaW5zdCwgY2hfaW5zdCkgTE9P
UF9VTUNfSU5TVCgodW1jX2luc3QpKSBMT09QX1VNQ19DSF9JTlNUKChjaF9pbnN0KSkKLQogY29u
c3QgdWludDMyX3QKIAl1bWNfdjZfMV9jaGFubmVsX2lkeF90YmxbVU1DX1Y2XzFfVU1DX0lOU1RB
TkNFX05VTV1bVU1DX1Y2XzFfQ0hBTk5FTF9JTlNUQU5DRV9OVU1dID0gewogCQl7MiwgMTgsIDEx
LCAyN30sCXs0LCAyMCwgMTMsIDI5fSwKLS0gCjIuMTcuMQoK

--_004_MN2PR12MB40329A1571EB417279DB98D4FB760MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB40329A1571EB417279DB98D4FB760MN2PR12MB4032namp_--
