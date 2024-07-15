Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535C1C3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 19:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E326D10E4ED;
	Mon, 15 Jul 2024 19:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oInecW2x";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A034710E4ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 19:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkKKR41mffexSW0jjETmixZ5h1kK1Ab5hvpk5oDYCu6FwLlucfWnmZ2zXXRxksezTqBOJbbR4f3ddc++NE1enGqqIyGnY6CtulZIXp8PTXXQX/43lcMmOgecRZ6VNR24XacYmD6c+qXFNhWbsFjdn/gK42mSuwRibyzMsAn9I/T3cWevmFtf9AJTLMqW9AXKK0CRst0l4glUfNij2O0a7ICnLcspx1ImKxmUBPvaQJbk0Tqaap2/Y2m2XhJACFRjNrWplbt/vjuT1SlH1OwnZ/SWMnM48ltcqlPDQ6p8wdmDAmMEOWAqh1RIORz+J3ZZgtnZsTaq9YVc5KkLYxUDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwztAQSf4cmpX9eDxDiuXS3IswMcgfN17KLruY8uHdo=;
 b=Ivb/S+BWwwIfC7qiDzebpyonpK57fwOK3r08OkIJAVpQhvMRmEkNCu6nM5zMarsuFitdvH1L2ARIbT/DjAXQkudiKpBjxTIQ/HESnM2xjkehh4N2O5WiYd4fttdoOMZi2PlaOnP2Le/pRqZHyWcbNOqI/9BS3OVvYadaz5LTMQf1qzn/WPCiRLcabDoAW6bXHOA51+9Joj5E0DsfNi8Df3AXIIr8Rt3Df23VI7K8EFqAiiolMf28j0YH5du1+c4n5Ks9xhoEriZEJcTcoZp9gMoO0EMpAjjOdWod2gB1Ub3AH+QMrtk1kPK1oqjYyceP4PjmYMLwaJ7z5PZK77YIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwztAQSf4cmpX9eDxDiuXS3IswMcgfN17KLruY8uHdo=;
 b=oInecW2xApcbeHxZ4FXkeZfddiQj20hQVUdMaNFk3KvCVukt/gLvz1EImsxwYxzQIeTJOJFRObE/AZG9s5gN2FwpChScS5Vyt3IdN3Qz1sseoc5PERNgJiFbkCVcsmhlbATSuQyuGPdMMcvVGHykqCCdoVr8jVUZJc+fiuqiLKs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 19:15:09 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 19:15:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "alexdeucher@gmail.com" <alexdeucher@gmail.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix doc entry for bb_from_dmub
Thread-Topic: [PATCH] drm/amd/display: fix doc entry for bb_from_dmub
Thread-Index: AQHa1ur2hAM3qT42+U+yO3GA0J1avrH4KKug
Date: Mon, 15 Jul 2024 19:15:08 +0000
Message-ID: <BL1PR12MB514462D1771FBB74C95463EAF7A12@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240715191221.3463907-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240715191221.3463907-1-aurabindo.pillai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-15T19:15:08.541Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB9313:EE_
x-ms-office365-filtering-correlation-id: bda0228f-98df-4e1e-b429-08dca5027162
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SJeELi8g0aDHkHTj2C9qe7mcvf441g5e5jwTcHger8rxp+sXMBwUSKh0OlfF?=
 =?us-ascii?Q?1qMREabtI0iNWgDWD9Xo2oorOeC5vCi//UbEKA9olKkHE4cmwGaj9XA4HTKk?=
 =?us-ascii?Q?ueM5eQuEVsm0XpZrCRzYDdHurgv5V4BnxmaWjw3LIAJ5ov/Dm74z4qEEnIdB?=
 =?us-ascii?Q?L8MidQZGHq1XYdUqhHXUZ28IePP5K4eYCgT1X5ubJTrNWa0EE9I4VtJHPI++?=
 =?us-ascii?Q?8iIz6DpPv72A3m21a71LgMyn0nwDI6y1TSniCYNC1foWpxAUQsdp0/AcNHUD?=
 =?us-ascii?Q?yj/q87IC6WyFPE0O6xg0Z72sqAWp3uX8etAl6A9cBpjJ8LEAc6rc0idCDPu5?=
 =?us-ascii?Q?A25MSUVsuhLFPdUQursL4sHfYKC9ZBVkgP62fZc+wYqnv5O5q7GRnQks2bid?=
 =?us-ascii?Q?Fw90ZOZ9geD4BBg/Q5YXocGHeKoKBxtVVZOJ/GTTK6ZQqAxNTavtgVeNNw/e?=
 =?us-ascii?Q?elIk6+tczMD1XF6fVqaZoFr3ek43+2M2rAdqINrvwGwq0bjItGvKkgyq/uHN?=
 =?us-ascii?Q?+rGqfqvXtFa3vzPATkTuxGMvU9JvgbH42LqOX6o3suxvA5JTCdIe6Dn2Vl+P?=
 =?us-ascii?Q?/FHUviutjmqg989F5e2XuPqt2OgFezco0PF7ZZXcHMgtJVyWI8Kjnt4SkA7D?=
 =?us-ascii?Q?7zTz+M+DM6Q/gn1uU5W48kr/yCM20FzHvJDEkmWreglidRAc4174MDtC+BA2?=
 =?us-ascii?Q?gR0P5RFm4e11KNY3h1qZp1tVZ0e+44gIh/dkMFff5KfQHPLIY4YJ09u3NgQK?=
 =?us-ascii?Q?FAu92AHwZ9RTZkqwX4LUv7owiSwFa3XiBsRBsKb8rhBgx4+/Hg0AJ//3EkVK?=
 =?us-ascii?Q?3a/avBxZMWq+0Ryqet9ie+nbFzv+ohZ3szbyX8pB1atPFRBJXTjnhK9Bxa9b?=
 =?us-ascii?Q?EsohpU8LD8twRHeg1A80T802ufaq9swj510nLO1FH58NkKulEGFcFPjmJgAM?=
 =?us-ascii?Q?P0V2Ky7a6X1hxWfJUbg6sC0OQz4qk+X1Fo3ImOerKBPxHD9McGJPZEjSYpMF?=
 =?us-ascii?Q?QP311j5mqXs9E23gIeZkzMLOrQ2LRARaIxDbYQFLXNnK1B95PO/khctwF3E8?=
 =?us-ascii?Q?1XqKsqNmf9N8DsWQu+WXW1GRSbKS+K5VOgeAff3KzCNyyKEz60zRX+2uFgSd?=
 =?us-ascii?Q?c6Wh566lGz5ASdttS+8k538EvgApMmrKiMweeEdKC34+b3JJ539WKV058l4r?=
 =?us-ascii?Q?7lH8D5HJMZ9LkgJnT6ZrbtoGrm8rl1JuBVl4yethzYdO7/z/t0+3ntXcH+j4?=
 =?us-ascii?Q?BZxaniQuVbEzobT3gLlu9z9RU4QYFFCW5bXnbUuYSSkJX7IJsH7/axC/0Scn?=
 =?us-ascii?Q?D85co5IH8jtOgT6+Y760KGiEB8/I6sNyBhLq4fvRSlyudA6XrptlhtcTpbeg?=
 =?us-ascii?Q?5IlZ6KaewEVPvA9uLmrZmVM4PWVK3sgw5e6td7R2+EhXUwM3Mg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r4BNQeG/je0F9NPL5lUOKVdu+t34vvxKkWcwHVoqIlca/BTIWS9hKY3IA4lR?=
 =?us-ascii?Q?IoMC2+6EyA4yI30oTTxglQzswLQjQLjgAVs6ThlPBUngjKtMozGXfcaHEvf3?=
 =?us-ascii?Q?UilshUdTNezu294NZOoyM31IODZSlaQUN6KNNEdb9lxe8AnFcSz06mg2KnnN?=
 =?us-ascii?Q?8At8+6mWM+33m3ZWUhTMr7Cr5/Zi2RAujfB0gaFIwW7NXVUHfhveKNEV4ZD4?=
 =?us-ascii?Q?LzgDNIA44d8JX6gLy3tJOcO2qBjnJAnfiJa+C0RxrNhpA7mSn95I5YZv+95m?=
 =?us-ascii?Q?fW9e5sfZQRJjOYHVwkJLxdr67eCnPXkiu04BvIs15axVX3JUmOz2za72zen9?=
 =?us-ascii?Q?JaMWBoz00YRsgfN8F6q1HI0AcTIzM0TMM4EN7CY3r0UysdoVyvGf9jRiDhn2?=
 =?us-ascii?Q?HAdyA5eCaoHWi8mB3vQIvVQBBgmf67CZXA7OVbV1SvY8TaY4Lnd4gRD2OkRa?=
 =?us-ascii?Q?XL/XnI74ZsUP941i4DS7caTrBCyIsYVHe45ywB0PZFR0YLZfAPrKsexEtjE7?=
 =?us-ascii?Q?ALV1t71xjhAZx7mb1bLk2YBf1zRkyWICGM8uvaUB0oxhobE4Lewzos77vVlo?=
 =?us-ascii?Q?FM98XvyibR6mQMfNsRPijAZWZKzk6AbutVUqRIA7beYebfIamfnV8NhP2i7B?=
 =?us-ascii?Q?pPDEXEbRtt+plwjtHLiohFaKnb8PY4o6iUYYh99+utiAR9S8+esnOId/SETT?=
 =?us-ascii?Q?O6yfT5fuD0tnRGrpH0r9GXEq02aqEBU8PN1Qlvlr8Zl9fIYIlMx3885clM+H?=
 =?us-ascii?Q?H+9x3EfFKd6V1LNKczVqr8u8ouHUEYVkQ37aStr1HgU/q3GlI8OOWJXZp1bS?=
 =?us-ascii?Q?1+0FR7przA0rG7wc2x806CVhGhS2bkGgxmusbOv8vbdouYdeKFct+ed/uhlr?=
 =?us-ascii?Q?UOrG3A1Ite6SI1tnaJOmMQLsADhSUyp+EEWLuGUFoDdr6gnSRJ6ggqxDHpvU?=
 =?us-ascii?Q?4CcONQFZaM+jCYkWlituSeM0tgjoD9AN602eQbem5IFtXNj76zAyvrJkG5IK?=
 =?us-ascii?Q?c50gtX3uWGMEdH545SinN7Li6pry518WylbAQvKg0XClsOnp1xgCD2CHhKsF?=
 =?us-ascii?Q?Jw714ovOS3sJXIbM/HVwY0hUBlP+e0NMIiCji2zTlQCtLkYcvXNN3Pq3bD2j?=
 =?us-ascii?Q?/nDfwXDlR02zBTuoWTmo6EbbzTbnVZs+NkQjP9gyTjuMsCqtJqcqGyM9SLvK?=
 =?us-ascii?Q?HSr1HSatpGZy+p7Snf0MyyoVKOTwxnHhnO70/WXPMuWOgWc3zC3wrifADe/X?=
 =?us-ascii?Q?Gwb8vrpeAtoLPAsFHQsAJKxAfXBhwD6Fv5NGQbe/6W1yTXniPGsSwkeZPXV5?=
 =?us-ascii?Q?INEY1nY5PPVRT0yLTEGBioTnmWdyISqG9AY0M5VvmRdocnoOwVt4WkjMF6sq?=
 =?us-ascii?Q?rnsIoEYzaThgk0nguv5txx5k6iSCp8kqC0OkMCnpM+obb9QU+jxridD0oIeB?=
 =?us-ascii?Q?z1fapr8Kf5WMjZ/GtDEdFI7BqKdQqwbfZ2qvFo8at3VayJo1zSrnA5twM+Pn?=
 =?us-ascii?Q?6KD9oFoXoS996Fw3CubOxHqJ0cUnrVAmpQXCWlpq2h9Le/p77pXv03xd67Hy?=
 =?us-ascii?Q?zXBLizGtm0mEgV7+sFE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514462D1771FBB74C95463EAF7A12BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda0228f-98df-4e1e-b429-08dca5027162
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 19:15:08.9968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: do6azVAmQ9Gdl3V9UQpeeq3aA46QLFrRednisNZWFtSZpVTxDZIeXXaCqb66VopTQvSYsUGrXiwjfS6PPkS9fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313
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

--_000_BL1PR12MB514462D1771FBB74C95463EAF7A12BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Aurabind=
o Pillai <aurabindo.pillai@amd.com>
Sent: Monday, July 15, 2024 3:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: alexdeucher@gmail.com <alexdeucher@gmail.com>; Siqueira, Rodrigo <Rodri=
go.Siqueira@amd.com>; Hung, Alex <Alex.Hung@amd.com>; Pillai, Aurabindo <Au=
rabindo.Pillai@amd.com>
Subject: [PATCH] drm/amd/display: fix doc entry for bb_from_dmub

Fixes the warning:

Function parameter or struct member 'bb_from_dmub' not described in 'amdgpu=
_display_manager'

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 5fd1b6b44577..369159c29bbe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -587,7 +587,9 @@ struct amdgpu_display_manager {
          */
         struct mutex dpia_aux_lock;

-       /*
+       /**
+        * @bb_from_dmub:
+        *
          * Bounding box data read from dmub during early initialization fo=
r DCN4+
          */
         struct dml2_soc_bb *bb_from_dmub;
--
2.45.2


--_000_BL1PR12MB514462D1771FBB74C95463EAF7A12BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Aurabindo Pillai &lt;aurabind=
o.pillai@amd.com&gt;<br>
<b>Sent:</b> Monday, July 15, 2024 3:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> alexdeucher@gmail.com &lt;alexdeucher@gmail.com&gt;; Siqueira, R=
odrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Hung, Alex &lt;Alex.Hung@amd.com&g=
t;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: fix doc entry for bb_from_dmub</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes the warning:<br>
<br>
Function parameter or struct member 'bb_from_dmub' not described in 'amdgpu=
_display_manager'<br>
<br>
Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 4 +++-<br>
&nbsp;1 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
index 5fd1b6b44577..369159c29bbe 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h<br>
@@ -587,7 +587,9 @@ struct amdgpu_display_manager {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex dpia_aux_lock=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @bb_from_dmub:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Bounding box data =
read from dmub during early initialization for DCN4+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dml2_soc_bb *bb_fro=
m_dmub;<br>
-- <br>
2.45.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514462D1771FBB74C95463EAF7A12BL1PR12MB5144namp_--
