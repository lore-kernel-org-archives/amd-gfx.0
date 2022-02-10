Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07153C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 16:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE0C10E165;
	Thu, 10 Feb 2022 16:53:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB8E10E165
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 16:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRQiCE4l0kalb4vCdZxdEsBou2SveboALUHECZVr/1ZviHdSmb5zltXZQ7rkpC0m66SivnbVqdcUejDUBrgdS0FaGSo/vWBkTFrIztHKZ5ROQZTWYJXgLCnh3G9G26ID+JZm9suhvX7OuM3Q0q7MEsIWo4wzXAApJRdoQpl/UUKu8u3HLuWQ6rTrp3xjBiD992HiSppBZ20OF1lRd+kGWZBJu7aK2rcWHqL6ueHJ0eeHnqDwFxdeJ8BEE5YY4YrWmQ0xrhRXKEa0IQp9b9WwYDbGnat25EwyOUg8K57WrwDIG6EsMGeS3kf1wZLUqp7cqhF0sMTAt37sXv8mCElSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRexsBmpck3Ua06qInMnpYM7Qdjsr5KdyskkGayo2HU=;
 b=O/oWBZWBqw+CcPuHH5IY956dpHtOHJ2PfHWYUI9BB1UDftF/dKaUNKiBrX1kdMJ+dyobLFaliMwX5UDW5Q+mqDtt/FqyejIcHGBfCWorMuE5/YsN/pGFmwtDEK/AccMhmlmxc+G1uJgsBpbqB+l9nNAzOcp0eJzneISftQBzEzI0lGliMNra9nVkswpWBWfEhUVveIlBapSfTAG5TRv2PFFsz5riphNQo03xYRSLvjD27LeBoMQBAOc8t1HleB2/2Lfw3bsFd3xQuo4l07Hg0w+qyE+MdC5XyR9Q9A/bdtOuqC9vX4n7XUExy+otDXe34m3jy+qqlIOK6wdny6ZPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRexsBmpck3Ua06qInMnpYM7Qdjsr5KdyskkGayo2HU=;
 b=oVcdkoiGRTkrA4603djlx+AZTjBWewUgTOWngkljb0EEs7/KfOaNJTTLKuZPo0/TD/Q5zR38VRGNhE+dZNwWWi5VvghV+h5zP0WrkAzCuyRU4coXroDop6wBWa4PJf70icDwO6GaY2bVvu5NXtSGcw1q6PYdQUQ1Z8Se1aAYIdM=
Received: from BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:53:27 +0000
Received: from BY5PR12MB4052.namprd12.prod.outlook.com
 ([fe80::200f:69a4:fb20:633a]) by BY5PR12MB4052.namprd12.prod.outlook.com
 ([fe80::200f:69a4:fb20:633a%5]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:53:27 +0000
From: "Logush, Oliver" <Oliver.Logush@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Upstream This Patch
Thread-Topic: Upstream This Patch
Thread-Index: Adgenq9siplOpqS4TQefHTB4ewSizA==
Date: Thu, 10 Feb 2022 16:53:26 +0000
Message-ID: <BY5PR12MB4052A50F44F62CD791BE0C08F22F9@BY5PR12MB4052.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d35d78f1-0735-4d5a-8f28-8100eef79c81;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-10T16:51:28Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 811ce08a-61b5-4c1a-be6c-08d9ecb5dbca
x-ms-traffictypediagnostic: CO6PR12MB5396:EE_
x-microsoft-antispam-prvs: <CO6PR12MB5396BFF715623651A710DCB7F22F9@CO6PR12MB5396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lz/ZatuNgSyze1siutRCtObPvver5qz4+3La3k0Y79PRkE3fYC7ZSeNtNXduqr+N5V36jQw4SCq9Ysi2OjEm45wKAz3G4gilGzR9UHsEHtztvI6ykGz0zA7TS6KCHbCdkXLfRGXjTvflFDO814+rHPEeq1obeXesiHXEGkjWDAWocq1LmouHyv+h4/ZWm9u8YzF3uLIxlMs6tT4CWa2uUnqDncRHmEIJWUS01N+MOnV9YG07ahWxWsY83qSQFBpinecma6Y6wu3TyE1VvC6dfeW/zLT06uFxW3bN4szJt5RlxD+9BT9DPsm7lEfm/IC3A+tFXLLGwAL5/VFlY5E1BAqMVoDKvWT3IzopUYU8ThlrEzuH3ycIQPsz7w+/oJQJ3dA1+rEXHmCg/a+xv32nojyAKrRK4eKRPmXVdfWCl+1C1LMkqPx8RKB6p6iF3xBdf7RY9lSEPpGqFqxRI8Khlo78UK0eFfqHQnwJJbtiKfXACNyHn79Sb4dnC/izqjCT733JlDXSR5KB/OYs+X4xXv9nKu7bxys2ZCRrNMbj0SfRKfg35p+BqHvs8sn6qjW/J/ztGke92OXZQP48NDVt3dH2CP1Tfdm/IqBCveIUIYwPKiiIq5jedel6dIfyNmK3luWcemJdt+2+nkmmBnX4lS+1Fr2P8xCHVaoGmmwRVWHjZ/1xeGSfGrddUrA0Xt5S4L9pycAeCaOSACTJ/vkw7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7116003)(3480700007)(9686003)(5660300002)(66946007)(4326008)(122000001)(64756008)(66446008)(8676002)(33656002)(66556008)(76116006)(66476007)(38070700005)(508600001)(83380400001)(52536014)(38100700002)(316002)(54906003)(71200400001)(86362001)(6916009)(6506007)(7696005)(55016003)(2906002)(26005)(8936002)(53546011)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QDxCS8q8HfzvzfZ6MwGLcUi/h9K0RlaLBM9vkQXWw3gLP+I42T9UUxJ8cn4s?=
 =?us-ascii?Q?+5XlmlHF1KfNiBCgsu6P02Qqhi9l7hWc4zFXDCeFdeT8nSj8mGo9ZPhanAao?=
 =?us-ascii?Q?ZRL3s1McfKzVUdbwWUKDqHU1wUs1AgixWBu70q3eBSc8F/kW34uPWvUTl6IL?=
 =?us-ascii?Q?BFwY2/XDXzPmejWgafbtmmZVOJAbSfNBf/jL5bNtdSh9z/G9v6QDBxRVFYjx?=
 =?us-ascii?Q?nMxNxmKPwuE7wi9oRryC/FgUvfbmGUKRBaFG337Vwa9yJe0B9BwYF1b5bKCg?=
 =?us-ascii?Q?AQyzVU05B8Lgdi6x8/dY5e5jKu6BmHbFgpJuzZC+j553EbwL/nMRgi6PkJOc?=
 =?us-ascii?Q?okPh/LXvDRlquY9612lXhJEfjL6NLtGnTAksKZ63xXePKoITQG09zMxg9a2R?=
 =?us-ascii?Q?vlGucNuFEWmkBabHFCYAvMqPUIJGBLx8vNek+Y1Z+fRO/1BoVLvPij4gJYW6?=
 =?us-ascii?Q?1t1k0QErkdFHiXCideKLzQBqB5D/GbuHg/2E6LxK3kU+sj7xEtNeJyHjpRIT?=
 =?us-ascii?Q?iLgBUfxEUMecBz8i0NiRcLolpl00xPKmkU5OBLSlQxdYJljVG8HWOZsyGepj?=
 =?us-ascii?Q?wbensDDfAtJdFKFr19FSsl8HPSM/fc7DCDpVscRIu37foMMi2GpYUWWhCWA+?=
 =?us-ascii?Q?vd8RuAZ5ZSTaViUZsP7Eq+bOTosGpnlgHttKkVsn9a+44+arv+P45pH2BudU?=
 =?us-ascii?Q?Pw8hSV7zwLLilrAcOLKJ720JYsls6eOaizUV/dcQXDqg9h1kF8f74kZkjFqI?=
 =?us-ascii?Q?WhKzzvp9R7P5fEwWeN6ah51njAclHZ/mxuq0zKITCPq4pdNO2aSbrklHsnmF?=
 =?us-ascii?Q?nvAAhv6dbXmrsopI5Pdw7uOVpL19GuBUuFgaTObjOs2cHXWJZzs3Hhlds+/h?=
 =?us-ascii?Q?3B3su7pmCyu6a7nw2bvv5vhvERBFefdPEnkkSIe/d41Pj8VwdyUdkhtCIKgG?=
 =?us-ascii?Q?O7x6PzQfD6r0uyhJdXQfB/pdEqNSxOmJhe+wlIy1uq2zUVQwbz37UgwCJ/Cg?=
 =?us-ascii?Q?elGqrPhC0hgckI56N2AICmefo4rQWuzrJhsW75o/O9GBsojHTwpPU6ze8hHf?=
 =?us-ascii?Q?uOg47S8o9brOCSysvc4n020GEpj7nyk9d6DC+zasa2sSmZPmpCjVX5lZNMaO?=
 =?us-ascii?Q?4xnZjbC9HvNkHd93+oC6qfJ4GaAexJzwA62PVtWHzR0bvjGeBXnokh3FeVVO?=
 =?us-ascii?Q?Yz826+lrj0cWQ2pGVBy5afmcECzvyRen1zjxurGt0syIxfsJ9O+xQ3a8hAxz?=
 =?us-ascii?Q?cPSGE9XNc0OJEJ7O5wrBj9oxRnmdJW+O3VHTf2L5CG0L1YOdcQYwpno53y//?=
 =?us-ascii?Q?GwybthwFD7/kByXOm2vioEp9OPuccmMmDPacKK1Nz6o0Rtem/sG9t63FgnbN?=
 =?us-ascii?Q?aucOApiIJH7HrLROcQLT2hkyeRjr6zIHcyzySxmTvBCHw94pl8vqNzoSm0rM?=
 =?us-ascii?Q?JWTeXSEpSiwfFF9nKhYOaKp6mYJ9wX8Q2Au146SuwTdSbuAvytbouAVhBcUt?=
 =?us-ascii?Q?RNqkpE2AbDyZEdCRVBQkuCBkhyQFpH4qii7ydT8GJsHhks97IH9vMamawXxJ?=
 =?us-ascii?Q?AArREda5LaLrmZukomkCEyclTwqMCSeNLLlQuhQoH25LRHYYkokH6zs0uUYx?=
 =?us-ascii?Q?oMszb+h8KpCvAcyIWSM5Gjo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB4052A50F44F62CD791BE0C08F22F9BY5PR12MB4052namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811ce08a-61b5-4c1a-be6c-08d9ecb5dbca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 16:53:26.8480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jlo5e2lp46S2yDuK34+ma4p0sVmHOW8LBGH95bILygvkk5poBvMUDp99nCZhXCniNn6eC1/v0M6tdzXoe5hCFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
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
Cc: "Wang, Yu \(Charlie\)" <Yu.Wang4@amd.com>, "Liu,
 Charlene" <Charlene.Liu@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Liu, Zhan" <Zhan.Liu@amd.com>, "Cornij, Nikola" <Nikola.Cornij@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB4052A50F44F62CD791BE0C08F22F9BY5PR12MB4052namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

From 488cc792021a60300df3659de204ebef954ba2bb Mon Sep 17 00:00:00 2001
From: Oliver Logush ollogush@amd.com<mailto:ollogush@amd.com>
Date: Wed, 9 Feb 2022 14:25:13 -0500
Subject: [PATCH] drm/amd/display: extend dcn201 support

Signed-off-by: Oliver Logush ollogush@amd.com<mailto:ollogush@amd.com>
Reviewed By: Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>
           Charlene.Liu@amd.com<mailto:Charlene.Liu@amd.com>
---
drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
drivers/gpu/drm/amd/display/include/dal_asic_id.h | 1 +
2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_resource.c
index b36bae4b5bc9..71b393194c55 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -135,7 +135,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_=
id asic_id)

                case FAMILY_NV:
                               dc_version =3D DCN_VERSION_2_0;
-                              if (asic_id.chip_id =3D=3D DEVICE_ID_NV_13FE=
) {
+                             if (asic_id.chip_id =3D=3D DEVICE_ID_NV_13FE =
|| asic_id.chip_id =3D=3D DEVICE_ID_NV_143F) {
                                               dc_version =3D DCN_VERSION_2=
_01;
                                               break;
                               }
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gp=
u/drm/amd/display/include/dal_asic_id.h
index e4a2dfacab4c..e672be6327cb 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -212,6 +212,7 @@ enum {
#define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >=3D GREEN_SARDINE_A0=
) && (eChipRev < 0xFF))
#endif
#define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
+#define DEVICE_ID_NV_143F 0x143F
#define FAMILY_VGH 144
#define DEVICE_ID_VGH_163F 0x163F
#define VANGOGH_A0 0x01
--
2.25.1


--_000_BY5PR12MB4052A50F44F62CD791BE0C08F22F9BY5PR12MB4052namp_
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">From 488cc792021a60300df3659de204ebef954ba2bb Mon Se=
p 17 00:00:00 2001<o:p></o:p></p>
<p class=3D"MsoNormal">From: Oliver Logush <a href=3D"mailto:ollogush@amd.c=
om">ollogush@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">Date: Wed, 9 Feb 2022 14:25:13 -0500<o:p></o:p></p>
<p class=3D"MsoNormal">Subject: [PATCH] drm/amd/display: extend dcn201 supp=
ort<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Oliver Logush <a href=3D"mailto:ollog=
ush@amd.com">
ollogush@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed By: <a href=3D"mailto:Alexander.Deucher@amd=
.com">Alexander.Deucher@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"mailto:Charlene.Liu@amd.com"=
>
Charlene.Liu@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/display/dc/core/dc_resource.c | =
2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/display/include/dal_asic_id.h | =
1 +<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 2 insertions(+), 1 deletion(-)<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_=
resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<o:p></o:p></=
p>
<p class=3D"MsoNormal">index b36bae4b5bc9..71b393194c55 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/display/dc/core/dc_resourc=
e.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resourc=
e.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -135,7 +135,7 @@ enum dce_version resource_parse_=
asic_id(struct hw_asic_id asic_id)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case FAMILY_NV:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_version =3D DCN_VE=
RSION_2_0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (asic_id.chip_id =3D=3D=
 DEVICE_ID_NV_13FE) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (asic_id.chip_id =3D=3D DEVIC=
E_ID_NV_13FE || asic_id.chip_id =3D=3D DEVICE_ID_NV_143F) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dc_version =3D DCN_VERSION_2_01;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/display/include/dal=
_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h<o:p></o:p></=
p>
<p class=3D"MsoNormal">index e4a2dfacab4c..e672be6327cb 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/display/include/dal_asic_i=
d.h<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/display/include/dal_asic_i=
d.h<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -212,6 +212,7 @@ enum {<o:p></o:p></p>
<p class=3D"MsoNormal">#define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRe=
v &gt;=3D GREEN_SARDINE_A0) &amp;&amp; (eChipRev &lt; 0xFF))<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">#define DEVICE_ID_NV_13FE 0x13FE&nbsp; // CYAN_SKILL=
FISH<o:p></o:p></p>
<p class=3D"MsoNormal">+#define DEVICE_ID_NV_143F 0x143F<o:p></o:p></p>
<p class=3D"MsoNormal">#define FAMILY_VGH 144<o:p></o:p></p>
<p class=3D"MsoNormal">#define DEVICE_ID_VGH_163F 0x163F<o:p></o:p></p>
<p class=3D"MsoNormal">#define VANGOGH_A0 0x01<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.25.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB4052A50F44F62CD791BE0C08F22F9BY5PR12MB4052namp_--
