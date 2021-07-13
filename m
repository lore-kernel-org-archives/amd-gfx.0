Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E705C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 09:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A2561158
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 09:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A2561158
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64FB89E3B;
	Tue, 13 Jul 2021 09:36:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE2DF89E3B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 09:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfUJq86kwQkPCD0OB/C7Od0cnSuFOPaO4Fzt5dw+xM6hoMoCcgOBdOORqnv/C72frOmfN9mlgwJoZ7d/oAsOu/5GHDIxWyLDgaKDHOPyYt6QIq6kK8NVO/SXUia87j9vsxxsU+jiQwbh/z0UyLLfAQzYqTFHUo5pu0/sulIEIHtBbQV+UKxlG7r2yZXB5BAVYHYcH3LPIzltDhf5f7B7ZJs47oVWePsWBMAImxwFbSS9Dw8Nq0oPwHiq5wZa6vpa1JAbQyBKJSFDzp/d9ZUCUykfWzSJzEBfWbxtXWm8zwDTwrSIWTMyThoLH+OaB8x+UEUY4Rbw0Vlq4q39GYKPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvHdu28sDGpNXOm8HyANFcs/d8lmVspeMKoMaZB8VYs=;
 b=Xq9kAYOBp5cI3WNYq2IIMZ7okj2+dyMbD4YLDfUgqQRCT7jW77AY+e6Jx5+aReaGUHy/imMc0i8/Tbj56usnlWF8I0QMxqPluLezLY/K1/aRO1oN0vGMfRQmEixelMXE5Bt2h5seJMc0QPP5Z9khdDEg20RwtVwSDre5nol55L8o8pllVPt94HQxQJrQHJSh2e6gXNzGsk8/oS8QGUshFegi+O9LO/a6fYvfDf/Nho8gblds/OsSPibQIUPgeDizDPQbXar2DBUbSg9Upc5x7vPMPfpJcYGQqT9QPR8asu6t8yjPbT/nCkG716L1yNP24vBBkqV0WS+6q9kGOI2rHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvHdu28sDGpNXOm8HyANFcs/d8lmVspeMKoMaZB8VYs=;
 b=Cck9h6FMs9TrvUIiDr/ce4UzUWu9+tpJJIODUNnxp7evesAsagWmoy26tDGiF5teOwe0gHjVIMLZTy/kLja59RVw09uMkOFxKJkgdqY81aq3gRLZqM48+fF8EfAnfkPgZwoVuUE7r/mPFUbaxJFHY90bKul11JjMM0jyF0kiPI4=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 09:36:36 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::d863:def1:2b7e:fc89%9]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 09:36:36 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset
Thread-Topic: [PATCH] drm/amdgpu: Resolve bug in UMC 6.7 UMC error offset
Thread-Index: Add3ynqQDrdXffQvTkm667otpc5Z8w==
Date: Tue, 13 Jul 2021 09:36:36 +0000
Message-ID: <BN9PR12MB5226592BA32F2E749A39B9D5FB149@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-13T09:36:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=08f4fded-8b17-460a-abfd-361a8dc47a38;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a335f87-b1be-477b-c201-08d945e1b55a
x-ms-traffictypediagnostic: BN9PR12MB5193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5193FC3A0502518BABE1E998FB149@BN9PR12MB5193.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bg3Gnzj+J5cqcUoRtOuZUncKFCLFXlKEjnKA18M6LOtLAULe59jhNzfRJj71U6sJzHSpe/OZnys3J7cPiT5L/RDaNBCzsX7tZZWm+/mQIYXnw22AXtnaj4Df+Xtzo/UeDGIpbaPK69a6nHGKW2NDGT1SYQAKjrLmvcvtu1xnCCwyxMoqpybQIZiCrn44KJYEnY5N/Ty+EwPfO1xbNDSv23FQjP05tDplgZTqV5wDC/36f54gbmyh+7Z+kyXc7adadPr/EfXY/zoWLnabypTM4pPh/bNKaTBLrFSWKTpUsO1Yl5j8vkoZXinupTGKv7R6S2mawXv5TfOryg+oAQ58BVEYZx+5m14HyeRe4DDf7YR7Yj30oRh0yg/gJLnXsr7I6cwiR8ebcaWtsWXqZjStVhvsMgg8Hus1Bif+7JwU0a4q8T5CfP+rNpXHNJNwo1rbJqyFWPjxfjvSTQhA0+Uv/NhllkxWQepRuzzWZ5QV0n/+zpVA0Wf2lBBlKVx9hvAjvkOYN9XOFHm8iB0qD5kgWoghPLAcq8zhP6erS87CGGEYPjLKWzLXicM7o5NPXZvc4JAkiGRc8403pjI6G4CfE8v2zq+oWCtNl+WjN/uyjEy5gHAMAbjAVdFvVCl/7kM4aGEwS+HUQdKBaqY5T7rzlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(99936003)(38100700002)(86362001)(558084003)(316002)(7696005)(55016002)(122000001)(9686003)(4326008)(26005)(6506007)(478600001)(186003)(33656002)(6916009)(52536014)(71200400001)(5660300002)(2906002)(8676002)(8936002)(66446008)(76116006)(64756008)(66476007)(66556008)(66946007)(66616009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LonlVOSwlYffqq2jqZLeiA1/oJPYxIYeKtyqJZRf/UFFW7aya9ww1xyNVu+v?=
 =?us-ascii?Q?0ThJG+0PJ5PGNXL2iNEQJpo7s/85wGBZbGD/YlOy8mZ0qfhu+YUuywWeE0p/?=
 =?us-ascii?Q?2GxxkMw8loDkZeDF6eSQj3or6c6SgooFHENFQ/BjxjUgcVlSqel5vzVEwJZ1?=
 =?us-ascii?Q?bKpELapOGtqhLPsGmoeT6wkJEg4Wr3HPG1OUn7ZXjgzz0O/y6J4Xk3AaNNNp?=
 =?us-ascii?Q?Exlp6Pi7k62o0dEGBMVF/T8C5tlnQ5KFFfaRM/YBWLiESZsmbcFtszVFU4Jb?=
 =?us-ascii?Q?4TF8SiHvmjfehc9qUYOGvcEQGnXWSkr/z7CqNQlc4q7GpnahTGwFf0D9uVMc?=
 =?us-ascii?Q?3+htpQNH+hPGAThNaAohv8qBA6mnlgvLC7sHmskaqD9da9wOlLDe2B7U3GD7?=
 =?us-ascii?Q?cdLL1n+8o2Ex7g8Pi6vsTXrup+vUzhqz1W7UOHSmwfo0EYgs+bCzeEfS38vx?=
 =?us-ascii?Q?/y6eGiRWxkZ9M7DfS54I7uQiHcYjwJqgmy6h2bHTX8bvpFpGAjBlescwccgU?=
 =?us-ascii?Q?Z4eS8Kd6jA2SoxSYkEP8dxrtkKndNih7Wznw7WT7FY7tW3na7h+Qq/lCBu8W?=
 =?us-ascii?Q?H/P1NZq3cG/DJ+y6EysjKYTDVWU/UbqMnWdqy7xaLYlRthCmIRmmkoicSOJW?=
 =?us-ascii?Q?u0eO3KNex64BE0bqgdj0FueT6PcmSASSeT6R039eh9R7zqm43POqnAgLV8ao?=
 =?us-ascii?Q?Q1452/fj4GAi/n/Hpjmv50Bygagdp++nuYiY43B5BLTYD6HiQP83JPUxj0pH?=
 =?us-ascii?Q?cy9veKim15vsVuKeS0bknZ5DGHSWQdBpZpwoEbfcNou3aBQX1ooHEYSgiMDi?=
 =?us-ascii?Q?dI1yslMFEhbuB4Ffg1a9/arFTtbgWbcm2UCxLV9yRsA8x/bw151Szqq0I8Ih?=
 =?us-ascii?Q?oqBnHM+RE4C2aH8geyQHpQolo8ubyrcxqUUk7JVOf73O7Lcf4hCRBec7c/yd?=
 =?us-ascii?Q?tZit47ci5CBwEXjWOuHdmQlTr7C4RzMFWYhCn9+2UVFKqOflHK5R/wGKo2Mf?=
 =?us-ascii?Q?SeKlnjqaprVAQzImJIobwnVBRCNSZCDPmQdnM7PfH26Gap3d5yUgmmLUmx+r?=
 =?us-ascii?Q?Swa4yO9Yz600BbGUnrK1zHAd0nuyFvRFy5is6SX5cZnypnSQE7yf3wX5C+Wf?=
 =?us-ascii?Q?mOdjSb8HCfEKcHBM5pyyzi7UjMKor8X4h0IVeJIRjj5Iou4EUodVwT89NspG?=
 =?us-ascii?Q?3HzSoAm59fla3azmAlmmfTIWZJaVCkxAPmDfpmR50bpywYK/uzpSxB3c8RjX?=
 =?us-ascii?Q?/OzKWUmIQk0QSp5QiAce6t3wfkWkJnyJti+j6e1SHRZNqnnkuPvTKho0wygu?=
 =?us-ascii?Q?nT+t4vWArhDGkRI589ILNU59?=
Content-Type: multipart/mixed;
 boundary="_004_BN9PR12MB5226592BA32F2E749A39B9D5FB149BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a335f87-b1be-477b-c201-08d945e1b55a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 09:36:36.0853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wPXX3wxwFwLSj92UOnoflQdKtkfbgzQRjkrRMka3ZJXjnL9jFSIvvGbBfjBJVnqEPvTjAmmmF6xwXe4PX+cWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_BN9PR12MB5226592BA32F2E749A39B9D5FB149BN9PR12MB5226namp_
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB5226592BA32F2E749A39B9D5FB149BN9PR12MB5226namp_"

--_000_BN9PR12MB5226592BA32F2E749A39B9D5FB149BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Submitting patch to resolve bug in UMC 6.7 error offset calculation

Thank you,
John Clements

--_000_BN9PR12MB5226592BA32F2E749A39B9D5FB149BN9PR12MB5226namp_
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheadera4477989" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to resolve bug in UMC 6.7 error off=
set calculation<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB5226592BA32F2E749A39B9D5FB149BN9PR12MB5226namp_--

--_004_BN9PR12MB5226592BA32F2E749A39B9D5FB149BN9PR12MB5226namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Resolve-bug-in-UMC-6.7-UMC-error-offset-c.patch"
Content-Description:  0001-drm-amdgpu-Resolve-bug-in-UMC-6.7-UMC-error-offset-c.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Resolve-bug-in-UMC-6.7-UMC-error-offset-c.patch";
	size=1235; creation-date="Tue, 13 Jul 2021 09:35:00 GMT";
	modification-date="Tue, 13 Jul 2021 09:35:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkNWZjNzhlZTcwYTU0ZWFhNDhkYTMxMWJkOTMyMGM3ZWQ5NjRmYzM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMTMgSnVsIDIwMjEgMTc6MzM6NTMgKzA4MDAKU3ViamVjdDogW1BBVENIIDEv
MV0gZHJtL2FtZGdwdTogUmVzb2x2ZSBidWcgaW4gVU1DIDYuNyBVTUMgZXJyb3Igb2Zmc2V0CiBj
YWxjdWxhdGlvbgoKVXNlIGNvcnJlY3QgY2hhbm5lbCBhbmQgaW5zdGFuY2UgdmFsdWVzCgpDaGFu
Z2UtSWQ6IElkZGIxMWQxYmE2MmY3NzUxNjk4ZmJjNDQ0MGZlMTczMDYzNDNmYmU0Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDQgKystLQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3Y5XzAuYwppbmRleCA2MDBlYWYxOTcxZDIuLmUzMTU4MjA0OTY1ZiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCkBAIC0xMTcxLDggKzExNzEsOCBAQCBzdGF0aWMg
dm9pZCBnbWNfdjlfMF9zZXRfdW1jX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQog
CQlicmVhazsKIAljYXNlIENISVBfQUxERUJBUkFOOgogCQlhZGV2LT51bWMubWF4X3Jhc19lcnJf
Y250X3Blcl9xdWVyeSA9IFVNQ19WNl83X1RPVEFMX0NIQU5ORUxfTlVNOwotCQlhZGV2LT51bWMu
Y2hhbm5lbF9pbnN0X251bSA9IFVNQ19WNl83X0NIQU5ORUxfSU5TVEFOQ0VfTlVNOwotCQlhZGV2
LT51bWMudW1jX2luc3RfbnVtID0gVU1DX1Y2XzdfVU1DX0lOU1RBTkNFX05VTTsKKwkJYWRldi0+
dW1jLmNoYW5uZWxfaW5zdF9udW0gPSBVTUNfVjZfN19VTUNfSU5TVEFOQ0VfTlVNOworCQlhZGV2
LT51bWMudW1jX2luc3RfbnVtID0gVU1DX1Y2XzdfQ0hBTk5FTF9JTlNUQU5DRV9OVU07CiAJCWFk
ZXYtPnVtYy5jaGFubmVsX29mZnMgPSBVTUNfVjZfN19QRVJfQ0hBTk5FTF9PRkZTRVQ7CiAJCWlm
ICghYWRldi0+Z21jLnhnbWkuY29ubmVjdGVkX3RvX2NwdSkKIAkJCWFkZXYtPnVtYy5yYXNfZnVu
Y3MgPSAmdW1jX3Y2XzdfcmFzX2Z1bmNzOwotLSAKMi4xNy4xCgo=

--_004_BN9PR12MB5226592BA32F2E749A39B9D5FB149BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_BN9PR12MB5226592BA32F2E749A39B9D5FB149BN9PR12MB5226namp_--
