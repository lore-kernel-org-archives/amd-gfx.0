Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4202BC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 07:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DE661165
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 07:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8DE661165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6697689B55;
	Tue, 24 Aug 2021 07:21:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8AC189B55
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 07:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHOxtyVX02/lySG6fszkdqiFhEDf+Zpq5RNWLcr6Ew8P+vl+d4LUSpfoOBaCSASy9DdLHF+O3G3hJHdY27PwlhMb1ClZOsKRzXfmiyg90WU6cjktfCYA1+YC8aBXDjmC6hZQ44EaC32wK39I3ntBFvxSTZ0RxjkCGEHaUBKEUMSdA5Gwqd87FFVjtZFILB12CDbwNkdJOl2Zv7jRpYThjI7cAfBybYG4u8PyMPtchU7pCe8mnth6h18bQo/4lxBxQxTMySH5JRJQUY6kFFoqbX7/yE+M28CUKDyzNSXeh6RNWP/TyqRbNRJtuWxyW+34sIcac4s82jOM1dODyoiRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppzN/a8q2p1AH+Jg7akgkM3HtSQtHuJ0NZ5+XOFliGM=;
 b=PHpJx7Ys7rMR8I5HhUzlCNvsNd1/bwQv3/vIR7Ifrgfw6nYpu1BrN0+5WoJAL+/9J2F7J0HdQR8Wc3iCWq499TTzVATzRHBpf2osVzesGz1U4p4yWN7HegdKO8aSiXTnaXuMLmY3rwMvAPWL/cwZqLKrEk73lU88MANRqA8g018IaKRvqsQxSci+in80EHq6g8fNwDhAklLCuo6lbFGNNen0usolwvgjSZs+2MqDaHhTU4gPa4ItznZHE2YMdBj3342QVyux7JnHON+nap0b0U6yr4qKKryDNoz+CjPSkCl8qzIpn6f4Dx//sUikdKO/4l66F/1R4SG1ij3f4xu9lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppzN/a8q2p1AH+Jg7akgkM3HtSQtHuJ0NZ5+XOFliGM=;
 b=JeKK2K+GiB51gmhvrGbIPJZn1S8H4sp+c6RFTJLvsG7Bfv2G2FaxuMLTRbD2Z4n25DUXqdKlSvcGyGgIOFFXItEw5grInmqbcI0NzoUEQ6OTGAJycsyw7cpyzuXgaS9TQ66+827tL3nfz9Dc+YmQdxFKxHJstRdB/aPSkY5hp9g=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5162.namprd12.prod.outlook.com (2603:10b6:408:11b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 06:48:47 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4457.017; Tue, 24 Aug 2021
 06:48:47 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Update RAS XGMI Error Query
Thread-Topic: [PATCH] drm/amdgpu: Update RAS XGMI Error Query
Thread-Index: AdeYs/43husXL4AwTJO1w1IFT7vrzw==
Date: Tue, 24 Aug 2021 06:48:46 +0000
Message-ID: <BN9PR12MB52265B8C755DC13618C5E3CEFBC59@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-24T06:48:44Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=470a8421-3bbc-44c1-8e08-5b231db3c1b4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c978de7e-0016-4b3b-bdcb-08d966cb3916
x-ms-traffictypediagnostic: BN9PR12MB5162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5162631BBA4DEC8ABB997E10FBC59@BN9PR12MB5162.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BEVhv8VzFgfiXtnnJJbiWXa30MfPP6cIBM+gEy0LYZZj6fa65/y0CH9lZwz0poLls3Y/009S/ImvapB62GJ272orBI1NTAHFDXNL6YjWbdfLcKOYEuZFUSn2pdXbFxSmmKzdRg/tEgRWKHIZ48f4KS96//nK6VT2KvLg1ytGk2nFOJ1EzSdezeJW0Nw/cSbzNM+uNu1Ck4M9pYDIYs5Qe0XxWSDwWK2MpWuqwvQvmxu5cOvPLsdNb0qa3+pgKEm+GRd8MJZBsfkOmafteg73w1fJM0ASlmFLVJKiJYXXfG22UF25MOXjrQ/Yg20bVhyyCWA6KNdJMP4sQvjSj3+AERp6XkTkx4UkjhJiQuW6buTmv3WJ0qHaGUQEC9YX/iMB76BjpZ48loTvTrquwou/r0baJz+5iHC8F3/JZ8HHIY1NxJgpp1FfTArvPjxgNzvIFRrcVmntbxviP9zSk+FnpEy8uOfnm/Kf7PuUbrP/DObFkxQcM8+VVyBIT9y51Mx/UwOfGRELECMYpkrttNX+nYSHZGBnuc9JWSvHKXKErOV0YvLJo8RroA4Iw9k1g6sb3ljTSS2OxEUH563fqt70Rg1chzme4XGrkOEz1foyAqY9hh2XSZDRRyImRVBluje7mLIo/UGbOqGERORjj2uWRPnXYYBhwo6FecZXNfh+IvQBCuwh2JNjEcKPmV+fYLwVOV5PqyQUBHTsstZIGcolIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(186003)(110136005)(6506007)(478600001)(52536014)(8936002)(7696005)(122000001)(5660300002)(55016002)(33656002)(9686003)(26005)(8676002)(99936003)(38100700002)(2906002)(66446008)(558084003)(71200400001)(76116006)(86362001)(38070700005)(66616009)(66476007)(66556008)(64756008)(66946007)(316002)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iZ7qrdXXP1y9SZz3lKUBx41vVhN4yj0NSHXfok87qvHd8UT+gSypA4oiBsMk?=
 =?us-ascii?Q?vgoQaU902+T4OHq32ZvAKnh2seyBO7LuCBlfOTswRm+tUaquNTGrp+emTFkM?=
 =?us-ascii?Q?EcMSsUUJMqXnSJ55GzQ9ppI7I6RbSLpbI1wMsV0bTiqkk/MqUw4wCF/JJTG3?=
 =?us-ascii?Q?5Zz4y1Qxwin8l3tQ1v7DRkCvTr/LysxMmRmtN5f4SCvCxWrN13efmwLrR+E7?=
 =?us-ascii?Q?Btgnur3Ngf/MS6CsJOASKNOXj2b/k0qYT5rJfRBzqfkCn0Glki9NNgwb5JYW?=
 =?us-ascii?Q?f+m0/Tc4e9LqmbDUJzoK7WYLYp1+Mgj1qm2+UxS967OYuwkNuL8U27ECy5gl?=
 =?us-ascii?Q?MYD+OgT9lq1h78IAFMe+WoCjhHx0RYWsHlldTkGvW7KJS+i53aENJ0LbtWxX?=
 =?us-ascii?Q?P9HP56rNBUrxZyyuOk7Qc5UDGpREGXF1xW7eSsq03RTGndUx0kt6T+UM6IvW?=
 =?us-ascii?Q?PBGjo1I1S6a0xzXcZacRRV+dcvDoXnuEDyR/GjhKOhafPUKZF+opSIA/fzkb?=
 =?us-ascii?Q?77PPMc5QuETk5j5ST2PvAkprkhSuMu+yFdeKH0e8hQPkE7fX3f0L3z2H+fS7?=
 =?us-ascii?Q?ehhO9vnQXtIPndQzPv9Kx0caGEGUtPAyvuQ7QdtuO5pLE5KR/Wb5Y4qOLRmo?=
 =?us-ascii?Q?CjvXNpUZsQwkdq7qbcz7YUOcB4IhSvQS49Cd2W9X/k9Na0fW6e+kHwArvwkv?=
 =?us-ascii?Q?2yS2aWSqXqGRF/y91K9guEr8Z9T2mT2VdCzUNar37GTjW6tT0LJRc9zP22vr?=
 =?us-ascii?Q?Z+OU+tdaK7TE1NtI7RJ9rd+wvf3410wpkmW67TSOfEyV6WBF6LwxmeHmnMDW?=
 =?us-ascii?Q?6HnLrBMW33DASoK8ums6m4THFrWfmftzuwXetdyCkIiLL1ezOuydCLdaEqIN?=
 =?us-ascii?Q?PxxitNPsTmCWofopIXuiujYcRr1mRzhMEs5FZDCdTQPv0WqYblt2ucjG4zuu?=
 =?us-ascii?Q?prDLL96YTo0zCWv/RUJA8WYOjWghnbWKIRMGl3KJnwRTBqJBtXxG7bXtt4dc?=
 =?us-ascii?Q?FX8woqs7YZzS64LKGcrkqfp3F+1ICBimZzPEEA7HYOprRo/TK8Q91fXCKG/H?=
 =?us-ascii?Q?afZe1V4SXuXKt1gD60+CEvSSAAGr1c9A7oqKmht2V/mz2f1A5vdQq8T8RfP5?=
 =?us-ascii?Q?fcN4SUok9AfYmogTi+Ap/yDyxj9u70/oQfSeAzMlcwt6otGhocDya2byuz8N?=
 =?us-ascii?Q?Rq5VXbEwUY7que2Wx8pEoF1wgpoY84hw12j9Fm18IGxBqzVNySbwElFM1IST?=
 =?us-ascii?Q?6bx3Ltpzwy8wYOrpqnRClXMpf0BmrSC0rZjKBTCkfrQLfCFp86OfIY/aafuj?=
 =?us-ascii?Q?iwSBhYW0qHMqpSoYEoULZ2QW?=
Content-Type: multipart/mixed;
 boundary="_004_BN9PR12MB52265B8C755DC13618C5E3CEFBC59BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c978de7e-0016-4b3b-bdcb-08d966cb3916
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 06:48:46.9790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kx+CtpyQ0pSpQhkj1IdIfye/Lv93Di1UWn5j/awG2GuoHAiuU62xiYoc+JKjqblnFOsB+5bvn7I4caClLc1Kpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5162
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

--_004_BN9PR12MB52265B8C755DC13618C5E3CEFBC59BN9PR12MB5226namp_
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB52265B8C755DC13618C5E3CEFBC59BN9PR12MB5226namp_"

--_000_BN9PR12MB52265B8C755DC13618C5E3CEFBC59BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Submitting patch to resolve RAS XGMI error query issue

Thank you,
John Clements

--_000_BN9PR12MB52265B8C755DC13618C5E3CEFBC59BN9PR12MB5226namp_
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
<p class=3D"MsoNormal">Submitting patch to resolve RAS XGMI error query iss=
ue<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB52265B8C755DC13618C5E3CEFBC59BN9PR12MB5226namp_--

--_004_BN9PR12MB52265B8C755DC13618C5E3CEFBC59BN9PR12MB5226namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Update-RAS-XGMI-Error-Query.patch"
Content-Description: 0001-drm-amdgpu-Update-RAS-XGMI-Error-Query.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Update-RAS-XGMI-Error-Query.patch"; size=1234;
	creation-date="Tue, 24 Aug 2021 06:47:00 GMT";
	modification-date="Tue, 24 Aug 2021 06:47:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiYjk0ZjQ2OGU4OTY5NjIyMzVlNWExYmE4ODI3NmYwNGQzZjVlNDY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFR1ZSwgMjQgQXVnIDIwMjEgMTQ6NDU6NDYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBVcGRhdGUgUkFTIFhHTUkgRXJyb3IgUXVlcnkKClJlc29sdmUgYnVnIHF1ZXJ5
aW5nIGVycm9yIG9uIHVuc3VwcG9ydGVkIEFTSUMKClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+CkNoYW5nZS1JZDogSTE0MDhiMTZkYTQ5OTc4YjJjMTA1
MzA0MmE2NjMwYTRiZjU3YjIzM2QKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfeGdtaS5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
eGdtaS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYwppbmRleCBk
ZGE0ZjBjNWM0ZTcuLjlhOTkyOGQxN2UwYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3hnbWkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfeGdtaS5jCkBAIC04NDgsNyArODQ4LDYgQEAgc3RhdGljIGludCBhbWRncHVfeGdtaV9x
dWVyeV9yYXNfZXJyb3JfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCX0KIAkJ
YnJlYWs7CiAJY2FzZSBDSElQX1ZFR0EyMDoKLQlkZWZhdWx0OgogCQkvKiBjaGVjayB4Z21pIHBj
cyBlcnJvciAqLwogCQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh4Z21pX3Bjc19lcnJfc3Rh
dHVzX3JlZ192ZzIwKTsgaSsrKSB7CiAJCQlkYXRhID0gUlJFRzMyX1BDSUUoeGdtaV9wY3NfZXJy
X3N0YXR1c19yZWdfdmcyMFtpXSk7CkBAIC04NjQsNiArODYzLDggQEAgc3RhdGljIGludCBhbWRn
cHVfeGdtaV9xdWVyeV9yYXNfZXJyb3JfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
CiAJCQkJCQlkYXRhLCAmdWVfY250LCAmY2VfY250LCBmYWxzZSk7CiAJCX0KIAkJYnJlYWs7CisJ
ZGVmYXVsdDoKKwkJYnJlYWs7CiAJfQogCiAJYWRldi0+Z21jLnhnbWkucmFzX2Z1bmNzLT5yZXNl
dF9yYXNfZXJyb3JfY291bnQoYWRldik7Ci0tIAoyLjE3LjEKCg==

--_004_BN9PR12MB52265B8C755DC13618C5E3CEFBC59BN9PR12MB5226namp_--
