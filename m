Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A582C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37116140B
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37116140B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B577A6F5E7;
	Fri,  4 Jun 2021 09:12:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9322B6F5E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 09:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCH7xNZ87dpK7GrIFKWSkcOtEgl+kwf33WqteD5v/LCmkfqxvsP2xQb23JkHlHZ/GcYq6irvjVd0XsU7VwehBZQ1rwMWertzerKAs6DSLWauQVj0DXZsdbWnOLtQJ4HawXZwQE4zYSRTU48Aijkoa3gWiOF3wH5OYi7avWtWPMejZPGqauG485MUU/G/RajNCGEbwQz7ShQ/bAHAmbXKsHwGeNe7LiOErIHLbj8MoxJv5L8fraAXFB7gn5uR9CyWZHkffOLaPeFlzp6p1d51MP+gqcXyHagk8LGfldwODPxX3zqZn9YvHtn9C5g23a499UiFNnRCQmPyYd7DzJV4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0mZttnWMjcNv2Zsm6Ry0xcg6jMG01GaO02UyGUVXDM=;
 b=lnYmoy8fpdrnl75zXAsSks3k0U4GAJ7OAXDBox3VJ7I4iWjkgSCVVPa5EdOZ1umplzcFNiv0NCSgQeYRnMPRcUcfAouhFQHVkb1kHA1O4UXQQE47YlrVPwf18ylndHse4MjsnFjO3J0vEjSXfwkblVe3Bt0ClylDyDNkQmNCIUOtuc7fslVal3ruA3HR8A5ChuJbnihyfxnExPOvTOLxjjzy11SV7ADI49lxW8+osr3KJ+FItJDtThTrS3KsTn7Y4gPi+95vIIdaUZEtTb9TuFsfocWjkaz3a+/BZhZPS8h5H5ds+kmF0s32udrYCFwgbXdZJ2lpSZMKRM+jwhI7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0mZttnWMjcNv2Zsm6Ry0xcg6jMG01GaO02UyGUVXDM=;
 b=xVoU3CLguXjjWDNQlMgvHxlhTPVA75aPhI82muFQ0t9H3DSlfg+ZzdQjb9/XRYp5bzklxGP6EOlkXEUBJljNt2A/ZQFew3KDRodCctKGUeLZlJB72mYlBzTAml94BeLGkPRmidvPT9rYykAKlRJ0t/cxb+hav3We4TKkiqn7Pk4=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5233.namprd12.prod.outlook.com (2603:10b6:610:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 09:12:22 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 09:12:22 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm: Add VF check to BACO support check
Thread-Topic: [PATCH 2/3] drm/amd/pm: Add VF check to BACO support check
Thread-Index: AddZIWxZnfF9XMoQQJexp6HUSzoM1A==
Date: Fri, 4 Jun 2021 09:12:22 +0000
Message-ID: <CH0PR12MB5348A625B36D6C97C336C2EB973B9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-04T09:12:18Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d6372fba-71af-4b84-9176-6c1397f7fb09;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2401:4900:2352:158d:ec71:65c6:5505:11d2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccd94fbb-cda9-4a33-e0a1-08d92738dcad
x-ms-traffictypediagnostic: CH0PR12MB5233:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB52333FC5E7A16426C6FD196A973B9@CH0PR12MB5233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wRYkbRY0J95wOq9ArzNU85N+44r6/qzkjo2ZuqCkaPd007LaSpwLGlmZQYD33HVL2lPSSSVrvp3+CLIl9IL4NbtRrXKETC6GrNah/sAlADJneIxv5XFpsrXW/6PzOeqxhZN3hKiBq/sGJN7GYPwLS2IP7aqR0JSwRxbFLLKXwezB+MM8d6gRmafpA4mhzSwGOK6zpcV9Zq3hUDEVqeYM42vDVhBZXjGbVg/tNEpZ10utE5UIcBXOBJZT4094x/gV1yMK5+cwhoP2qvjfXngB3sMUOySjOhONmwFpdAGi5jUIdJ4e/E4Z5VKYJPoTdXLrKFh2n9FfzmGxVvhY/gCel9TNZG6yKf3RHM0GRBN37Jb+fbxT7DI98bCl9jkgWLL14R5Ppx8swjAO1P+bRzlguvNJpKVXX/wU9Gx5h+3BM6B+EOsCh/opxAt/Ecg7B6KALHvlEeB2JSTRP1Lg002VeFDEmz/MPxvwwBTvI1dISES3CVLwmgYV+6OwD1APMPcG8y+64WGY+v1hXVzsdIUZLPAmQXzGXkinfdDvl+7j+eKKc0LSBAZv8hWwbgTvgfgiuvkujzwcEGGR2bfWfx7Q70HqiSJhhCBVZ3IOtpq5yzc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(6916009)(2906002)(76116006)(9686003)(55016002)(8936002)(8676002)(83380400001)(186003)(54906003)(316002)(71200400001)(6506007)(86362001)(33656002)(478600001)(7696005)(4326008)(5660300002)(38100700002)(66946007)(52536014)(4744005)(64756008)(66556008)(66446008)(122000001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TuSZwE/jLvF/4GHFK8PclqPbYqJOaTo/+qP81PfA6fG1+qu5WE4eOOetSUlu?=
 =?us-ascii?Q?4vuyIsFRLyV1WBLrctNzQhJOHjZTHclJOYbncAbsU16wb0xhbW612hedyG1I?=
 =?us-ascii?Q?gmSrCsRSBGTDoZQDgzcIRUBVO0DGpyoVvVz9hrT3n6b6bj/zmw1XcDHN07tH?=
 =?us-ascii?Q?ML1D42GxG57r4REQ/NiXCYBIFxdctBmOBAjCs+7H1sdc3ObhCRWnn2LpM2Cy?=
 =?us-ascii?Q?RFBCAi3rVyTkutibozOo2NGIxeimwtJ64UJ3+FvQfe3j4YSr1GHniwTPmTPb?=
 =?us-ascii?Q?NRH+2sIECs1AzSC0QijuCXHOa6D0L4L/PumssqG/93wf3oK46N3hzjw7NSXU?=
 =?us-ascii?Q?gxuMeyTo59k/u0qtAtGWZRlKqBmqyy3XuiNcHzoYl3HRdJkeVhfFpCtWvCWJ?=
 =?us-ascii?Q?cBF+XC4X+oVvedxUCje+fWzwq/rZrbOddGE/R1askBrlI2/88P4qNNJI9xSR?=
 =?us-ascii?Q?Fm0gnwZZtjdOKMi+hMb5EJbJSm07vI8garM9GP6A/Xuj0zh0MEcsoJByewIC?=
 =?us-ascii?Q?zzQipw2vMijzDUvyHLOYv+4CyVmfgOFWqF+cpGl6krCP+kLpEFpZRKFgugGu?=
 =?us-ascii?Q?x6Tz5AUA/VyyNTrfoFToO6JpGAAlEHgiEfaliKBcNu9/p3AbgfIqYZOvXL8/?=
 =?us-ascii?Q?PYJ+wYafdmTQrOC1/iAMmEUjcOKLbaJo/vtTFkVIiiKjr65aCckG1IV7KYbh?=
 =?us-ascii?Q?59PTY14X1Wijs6cdcehhk1zeVRcOKtDQ0ibaJRiz9mFdKMnszyMGlUddks4f?=
 =?us-ascii?Q?glUsOFI1M502IXMeR9gQCq/iqhBC0ZODVu39h8UNVVQh3I97jqv3Qd8YGSWc?=
 =?us-ascii?Q?ACD6MQGgxRjN3/rRvf++acPcyvevYHX9OJSpOU8xblHVT9Em/TnEV+Mpblru?=
 =?us-ascii?Q?XTGUkQiliVTE1aBWzADfp2GbVp4XvfQHV4QFVp+x/zcLgmSYdAifsxazU9Uz?=
 =?us-ascii?Q?Jgs2FsyINsVwGMFRKU4TQnOoxgbkGcoHqCnjk4EOp5rOYsDL9ek3PU7Imk0+?=
 =?us-ascii?Q?vLj2e1u1sVC30DzFP0OOhzVxHI3YncjX1SWI+3DiQho5yt348oe1u2E3uoVU?=
 =?us-ascii?Q?nDSTY4YBb5D1svCBEL0b1V5hvM9wAr/GAeZY3Ayl275sWbUqBpLLCnlr2Fts?=
 =?us-ascii?Q?h5j0yDCpyc/WNzqp+1RNZAmcqCXlarw6H9kyzfyj6rzt3oIkOXRjWDe23TTC?=
 =?us-ascii?Q?witutZws2nTEjOUotOb5ae4BCVONWN5mpV94KhvDCHkyzb2NuxwENwmYhnfo?=
 =?us-ascii?Q?pF0Hw05ya6M9GJhZdq64iN4ddpMVVJp4yTE2HSydwiBsgaH64Vebq/1zSpQ9?=
 =?us-ascii?Q?jFFQF4wFk6FXiZEYlmGkDRe5S3zCT51K0QeDIHT2j2SsritLcvPJv4U8nYKb?=
 =?us-ascii?Q?9L3gq1ZFv7ZAYRQ4I7JEPm70hrQp?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd94fbb-cda9-4a33-e0a1-08d92738dcad
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 09:12:22.2256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uMdQ9MSLw4uZIPzzvQmFHjtt+ej5DwIQljKT/onWY7OyFOEUW3P/Ad4oDt5Zh5fj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5233
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1215695428=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1215695428==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB5348A625B36D6C97C336C2EB973B9CH0PR12MB5348namp_"

--_000_CH0PR12MB5348A625B36D6C97C336C2EB973B9CH0PR12MB5348namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

For smuv11, check for VF also during BACO check.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 362696208fd8..e1e1c268f661 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1483,7 +1483,7 @@ bool smu_v11_0_baco_is_support(struct smu_context *sm=
u)
{
               struct smu_baco_context *smu_baco =3D &smu->smu_baco;
-              if (!smu_baco->platform_support)
+             if (amdgpu_sriov_vf(smu->adev) || !smu_baco->platform_support=
)
                               return false;
                /* Arcturus does not support this bit mask */
--
2.17.1


--_000_CH0PR12MB5348A625B36D6C97C336C2EB973B9CH0PR12MB5348namp_
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
<p class=3D"msipheaderc10f11a2" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#008000">[Public]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">For smuv11, check for VF also during BACO check.<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;=
<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +=
-<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 1 insertion(+), 1 deletion(-)<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_=
v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 362696208fd8..e1e1c268f661 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1483,7 +1483,7 @@ bool smu_v11_0_baco_is_support=
(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco =3D &amp=
;smu-&gt;smu_baco;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_baco-&gt;platform_support)<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(smu-&gt;adev) || !smu_baco-&gt;pl=
atform_support)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Arcturus does not support this bi=
t mask */<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_CH0PR12MB5348A625B36D6C97C336C2EB973B9CH0PR12MB5348namp_--

--===============1215695428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1215695428==--
