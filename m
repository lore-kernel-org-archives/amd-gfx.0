Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158BCC7619A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 04:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F4510E47C;
	Tue, 11 Apr 2023 04:04:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9286C10E47C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 04:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALRV7vL/EIQOaLAjdaR/OK5bjF3zAzAiRwrlVSlCy+O34hFgRA6k9hXSl9ZFaRDjMdYDRGHcIq98csM/7AwkYWsphI1CCmWCURXxn0gUBI7xXQttH7QHZ7oPqG705cQRlefvw1umWc4ACKwYBhCKhwBCgf8bywhOv39GHu28bUdnZW7BF1RwsCfGQ5Uea4Cj45s9pEx6dIahcrdSRu5QEWrzZUDHTZ7cQqqs+PTi0oZ91MCpLjsZzbGUW1kr3tlnfQRxTgBJoPEA54Zhz2ljjil2nmSssG1gVIcfIHNMqSbQq5j/ZIWWAY0+0Eh1KWyvJosBXPyUBX1sbW11fVaNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psufl3neM9rPiCCXQJfSLmcttUu6ZfkxRvYZH7HAYMo=;
 b=ash/+P4v9lEhtOUbmx6UkQYFImkqryIOZ7bqdr6sTuzgtGTVE8+0GbxHdegkA7MoBf9N1XjhE859Q5eBcH6YYfb00jCprvmyXU2Iz6TvkQyTT2KQgH4lXnw4+BhsOxGL37IzhOC67EbtPJCylBWmBEPX/NhCxm9CjQpSMtwT8EiLOPyAcoQwH8it1sD/AAeJbmFBEcLkpv2AdxAdhZHmh7S7ICtltZOBahXDxJo+QnxiNM08Xh5ZkeHIticd1GstECMHS/FHSUpymQRVlAXc0egC1VM052QTgqJ7N6ONrfufNgRZLqmfyNlRVIz0UFWo12CDxzNEGPa7tUhAfc1PGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psufl3neM9rPiCCXQJfSLmcttUu6ZfkxRvYZH7HAYMo=;
 b=bxou7EBN1nDBUeHfktjkEARZKsufTso1Dl4dGg66A/PCbW4b2I7jKz4napiqmG3VFSA4fCijLsCsocgzJgdOdCVwNwmHnofk3K+DFZiEWXeKHQjDATU0sqQwZVTnkDL1uD29d4gNLPo05NWN2RMQHM00D3kl1EsAP51M42h2yVI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 04:04:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%5]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 04:04:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH Review 2/2] drm/amdgpu: correct ras enabled flag
Thread-Topic: [PATCH Review 2/2] drm/amdgpu: correct ras enabled flag
Thread-Index: AQHZa6JfeG1YysbNfUuG+0B74XbgNq8lcoWa
Date: Tue, 11 Apr 2023 04:04:43 +0000
Message-ID: <BN9PR12MB5257B09673A51355D78F7BA1FC9A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230410114822.750-1-Stanley.Yang@amd.com>
 <20230410114822.750-2-Stanley.Yang@amd.com>
In-Reply-To: <20230410114822.750-2-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6267d8c0-b2bc-4e5b-be0d-4fadf928b38c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Privileged;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T04:04:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB6603:EE_
x-ms-office365-filtering-correlation-id: eb6e2a92-7b90-4fda-3725-08db3a41e169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPpk52wwPQs5awPMXiNc1r1QLAGXfnK6tk2DzPQzOGXFh8xjvX7YHMlHhHFfS6bb24ccllZ4Unt8bTpBuuG3iU4LLs2VXYekBDjvyw7soNDYAtpT5NDcAUJKfZuS71Vh8D+UBNqJkD7aj3FsctbiwRus9QAya3JjXPUJO9ChYrWnbgBzaH980deZfyI3j613jcgDv9Xs3x7sCNTrL7H/0+x/tudEb+yK604HGyMfUdpLxkBu+44JGX7zq8rnMdEISfNKHNupSq+7eMuiXAQ1RUKzj+aSg+tAAwPmHr25kXfSnvnjsAcUMe+su0A6m4JVIdjX+z2N66ygumb1/4jBK4Mepst4beyyY2DqTZnPQ5cTHBcZKqvssFmkmbmz0yhoZkaOR/QwBMGLJaSv9AWliAZVkXxCH+04Mzwb6EXookA4IBVZogi7tshXLD/iy/JxpYOL4M15QX/9wVcJ/WU6EmzVJSwwTY1l6bG/acXw4REsGT9BL2kzKnYKYytf3xl5z6GiwUS4rjm8VEfjcE+3IbjTcrYrnXzCnpoZwq3nS0hXGguGG0rgQm0wWNj9RVraYBwR3G4Zb2Ol8D2u74HwmrYxDn82O/uVFs8EyliC9VYTXVUAmTv3iS0lBu2usClW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(71200400001)(7696005)(478600001)(316002)(110136005)(53546011)(9686003)(26005)(6506007)(186003)(6636002)(2906002)(5660300002)(4326008)(66946007)(76116006)(66446008)(41300700001)(8676002)(66476007)(64756008)(52536014)(8936002)(66556008)(38100700002)(38070700005)(122000001)(55016003)(86362001)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y1aLk8R4TNPu9Gg7UTHGVDBcDkSuSrtDWQiyYGGS8idll/ZHK6ACgt5H8N1q?=
 =?us-ascii?Q?tCetS5CrARuATHPgZpHshkZalADrkrXBV2s0ngNWjDdyjHIPNTFbTfO8DXcp?=
 =?us-ascii?Q?+WtTe8ql5w3c1BWXwztg2nzOw8grVY0WbHbyS4B/xI3cvTMabnjbOt5R3ZID?=
 =?us-ascii?Q?2UiFIRQRakGQUfdLwp22fU5mtwQrSbpb7Wz+OFg+KHRl6MAAXLO3VuJtfWOk?=
 =?us-ascii?Q?WPhcKVKhor0xIrWe/0SZIda69M3bcn0EiLlH4j+qTUJo6E72zY8X6XIUxV/F?=
 =?us-ascii?Q?vWU0mIt3P8CFSOzkXgM2WNPP/kMvGeAbDwcmzrkEwUzgPnPzrmE3Q+dxZZ5V?=
 =?us-ascii?Q?yDcptzO5EPfXhSUtTYSJm5CJUruNHRSPjq93SStwg5o8IBk/RzNVptrvES3O?=
 =?us-ascii?Q?QNHP5ZEU+m/lhpgOOGjIKxhj/WrfWp4dxCC/GMJbN/EhZ7f1NZV8hV1ymJtL?=
 =?us-ascii?Q?pgEob2dERLXSX5tOs3KyF8hmP56vu7gaHITAW5wOikCnDO7qnAZoXzZHwUt8?=
 =?us-ascii?Q?xwdFswFfT00kdHzI+wuNuFxsnBFFpIbuCZp7mTt7ani4OgCaFclPubNMQhSg?=
 =?us-ascii?Q?c4ErZJOhwtuClBUzzdO0SjIAAMo+DztuWtU0fP4gjsv/f8IRSwNFcHzp6hCv?=
 =?us-ascii?Q?JLZjzog46JK6feVSruYyjPwlN8mHsLs/zVAG1a6lWaG9H5w1ZaI96GuRA4fB?=
 =?us-ascii?Q?D2gZXlNciroRqLZqG6Y2nJj1RPN2Ifv18LwiDS4tWK7vZy9exuNVa9ubwulq?=
 =?us-ascii?Q?xsU6tAquoBwV8mxxJwokM+Y/rGkVr/9vejCwmC+t/N/mW/Dc/dKhElK+JKfv?=
 =?us-ascii?Q?c2N4VrDUEg6JS7JtZVYIheljfTCkoRz1/+52T+uCWG5NWiL/qu3PfXojDE3D?=
 =?us-ascii?Q?KVU7nMUJ/2XDvP+wqXLBBVIJei5OevBQcM6K5j/+ph6KZbeaipXXBiWfh3I/?=
 =?us-ascii?Q?UChUW0+iil1bkqMVEAG2ZSlNoXn7gYkSoKiSNbw5QnCYGzOi1xO3zY9YNnhA?=
 =?us-ascii?Q?/vD1a0zx2+7JJ1KFheIEDPN1EKNtKOjOHRG6DbUlbWqlTRbg67MJ2y9YQwuU?=
 =?us-ascii?Q?mpPcBQ8OkV+6Y2MzyURQtJQs3tJP6JAJfmmyjOdQz6PMcfPC0p5jcz0Nucom?=
 =?us-ascii?Q?TRNq5hZVDgnez5E/vdRrwyHR0iptNKoFjb+t5FfF7p1iV/LSiq9S/gSTx0Wi?=
 =?us-ascii?Q?52qcL57kmuOPmXI7Ii+KnxEROpFKH8UUKWMET8CQ6N3BiLoCQY7lOfDK+vLE?=
 =?us-ascii?Q?c+x0y4fENzoLImDEXBM9lvIEALhsEfljWwHyCCd2D38/iEzhtMXg+G6QYwSc?=
 =?us-ascii?Q?qdvRMrh3upgP+Ik42+aOR9Spy2GTPf7TT/IP0NT8SyyLdJdbpfIt7zm2KIcD?=
 =?us-ascii?Q?2Yy01f52F3e/lw8yxW6flyEDnJy4fxWmCqVEbBftl371nQtsEiUAnq7LWDBb?=
 =?us-ascii?Q?rsShcq+G/0wc6W6eVWrtCA/5GKcf1bvqPAMNjay1+HGhfyI06KVEAwjtnQ8M?=
 =?us-ascii?Q?QwDYw76WgyuP3ln7GbYuFrSr8M8p1DzzhL+ae6vJol3YAGlEjeSUH/rgfUbT?=
 =?us-ascii?Q?Un3+vWX6tcLaGityn6M=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257B09673A51355D78F7BA1FC9A9BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6e2a92-7b90-4fda-3725-08db3a41e169
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 04:04:43.2017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/1xonGtOn1xEgdQ71j+4heq98ClOpdkwtECQ3GUOTD3b/awr1w2j2k7PCe6nqk5VrD4tSSeStbFF8Tqs7qL3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5257B09673A51355D78F7BA1FC9A9BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Just check gmc.xmgi.num_physical_nodes =3D=3D 0 should be good enough for t=
he case that we only have single ALDEBRAN/ARCURUS available in system.

In such case, there is no need to expose xgmi_wafl ras node.

Regards,
Hawking

From: Stanley.Yang <Stanley.Yang@amd.com>
Date: Monday, April 10, 2023 at 19:48
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>, Zhang, H=
awking <Hawking.Zhang@amd.com>, Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 2/2] drm/amdgpu: correct ras enabled flag
XGMI RAS should be according to the gmc xmgi supported flag
and xgmi physical nodes number.

Change-Id: Idf3600b30584b10b528e7237d103d84d5097b7e0
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 4069bce9479f..d26a93272bf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2430,6 +2430,14 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)
                         else
                                 adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RA=
S_BLOCK__VCN |
                                                         1 << AMDGPU_RAS_BL=
OCK__JPEG);
+
+                       /*
+                        * XGMI RAS is determined by xgmi supported flags
+                        * and xgmi num physical nodes
+                        */
+                       if (!adev->gmc.xgmi.supported ||
+                           adev->gmc.xmgi.num_physical_nodes =3D=3D 0)
+                               adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RAS=
_BLOCK__XGMI_WAFL);
                 } else {
                         dev_info(adev->dev, "SRAM ECC is not presented.\n"=
);
                 }
--
2.17.1

--_000_BN9PR12MB5257B09673A51355D78F7BA1FC9A9BN9PR12MB5257namp_
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
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Just check </span><=
span style=3D"font-size:11.0pt">gmc.xmgi.num_physical_nodes =3D=3D 0</span>=
<span style=3D"font-size:11.0pt"> should be good enough for the case that w=
e only have single ALDEBRAN/ARCURUS available
 in system.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">In such case, there=
 is no need to expose xgmi_wafl ras node.</span><span style=3D"font-size:11=
.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hawking<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Stanley.Yang &lt;St=
anley.Yang@amd.com&gt;<br>
<b>Date: </b>Monday, April 10, 2023 at 19:48<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;, Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;, Zhou1, Tao &lt;Tao.Zhou1=
@amd.com&gt;<br>
<b>Cc: </b>Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject: </b>[PATCH Review 2/2] drm/amdgpu: correct ras enabled flag<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">XGMI RAS should be according to the gmc xmgi supported flag<br>
and xgmi physical nodes number.<br>
<br>
Change-Id: Idf3600b30584b10b528e7237d103d84d5097b7e0<br>
Signed-off-by: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++<br>
&nbsp;1 file changed, 8 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 4069bce9479f..d26a93272bf2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -2430,6 +2430,14 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled &amp;=3D=
 ~(1 &lt;&lt; AMDGPU_RAS_BLOCK__VCN |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt; AMDGPU_RAS_BLOCK__JPEG);<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * XGMI RAS=
 is determined by xgmi supported flags<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and xgmi=
 num physical nodes<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gm=
c.xgmi.supported ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;gmc.xmgi.num_physical_nodes =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled &amp;=3D ~(1 &lt;&l=
t; AMDGPU_RAS_BLOCK__XGMI_WAFL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_i=
nfo(adev-&gt;dev, &quot;SRAM ECC is not presented.\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5257B09673A51355D78F7BA1FC9A9BN9PR12MB5257namp_--
