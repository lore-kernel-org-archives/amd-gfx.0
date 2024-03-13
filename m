Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD57C54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 14:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC7F810E90D;
	Wed, 13 Mar 2024 14:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MV9C4/QI";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB19610E70F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 14:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=algJm07ClQ/+YdhyAFPtZwMzzt9Vg9gYGmGLUb1hcdC18jKXjgruKBN8VJkDAka99Jh/xfHiDXu29d14IFeoYyoRFLIJunEB2qobv/JfSb3Yc4F0EYFMdhrvtwxf3LL4Sh2OYqf6nR2yW1b+W9dAnSzH7yKGQ/f+0iyUuxKueNi2cAfPO/3s89sOHHavA588xrZrctGQ9r66PqQXGW9aD7vcGaucgVusR0SipLm2okhtgOt3Ubk4Uzky/RBP+VcNF8pNb+qsHyK3WQacyI9QIBzt2wzOdpwRRl3oF0xbEJpZ7Y1J3MIozydRVGEjhzgNTC4cJZK8MWrCmgL92i18Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gfkay5qdJ2B/5FlO4XxIersmAtHYi8zxp0x07qK//LU=;
 b=SSchebn++5zpP9OPAsNi3ey+tMpHCqpMjgTHojD+Y5WbbKGyCwYVZH/EflsheYrxDtdZbd+izl5lUdUHpwO43GsF/GXYnXscabrm5Y7KcQKNOAV8QG2Lk8RoqVCvlH3w5e5Kxpor09RWYMJHKfY4Pqoxd4AxFnjXxnP0GifyZ7EQ9KwoqT2ABIM/SfqFiqj7kSuBaJxCfr719HvM888m4sP3b/uEwSvmz/NHvPvSJt7PX9AhLnl4Yz2c9OBeZUH2BYMDT9WAoCoM4XXGNIrSdrJuzFjLgouFLS16NhIx/n+X1iIm8td1K5bA6AaxIJVezdFWoLwsH8hO+y1rcnA96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gfkay5qdJ2B/5FlO4XxIersmAtHYi8zxp0x07qK//LU=;
 b=MV9C4/QImTXw8B1Xy3xOx3X2v3eJxNj1/7a6l7Nha4zmV2LRFl9IoBw+E/6ULXEVkQyWX220BhBX3hRAaogvbwKA43bPU5ya8Dsd+JcpXPOxA4n0R9VRMU5ilsQuSi8yohou+LGgzYaAUpcLigJf8S3CbgXMP1FSt5s2ZwxvxYY=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Wed, 13 Mar
 2024 14:40:49 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::797:7997:cff1:9be]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::797:7997:cff1:9be%4]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 14:40:49 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Wu, Hersen"
 <hersenxs.wu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Park, Chris"
 <Chris.Park@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "Liu, Charlene" <Charlene.Liu@amd.com>
Subject: Re: [PATCH 33/43] drm/amd/display: Prevent crash on bring-up
Thread-Topic: [PATCH 33/43] drm/amd/display: Prevent crash on bring-up
Thread-Index: AQHadF8V9a8VQVK5lUGhhndrC5dnSrE1wAxA
Date: Wed, 13 Mar 2024 14:40:49 +0000
Message-ID: <CH0PR12MB52848FF5C29D2FF732D21E338B2A2@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
 <20240312092036.3283319-34-Wayne.Lin@amd.com>
In-Reply-To: <20240312092036.3283319-34-Wayne.Lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-13T14:40:33.034Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|IA1PR12MB6332:EE_
x-ms-office365-filtering-correlation-id: 54b9260e-a02a-4afe-52dd-08dc436b93b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a9Gsepfd5eqiVQJahXNcaHXf0j2djaFwiYqJ1/CXSsJZEWIP0xrMT4r7VhaEvZKG9e3HsbovG71aH+ZIHw1UghBLOsmDN/f1fM0Y77W0s4dte8NR7wHD5Dd3Hml44FHZ2Pw6gHqd2XfLh3Lih3s7JdPoBoDLUkw4kauAr5FudfD6dwsO0zRel/eyrayfZR5Dwvdqm7xdgcBOXQkp/tjXt28A4brHoFbzXC355cb5z/c8S1T3Sn1bCv5Zd/yqtNi9S28KG1nZn2nOFtDFEqCQV7Rbi9VkLoacNhSyEp37p5TrjBQTXHJZFcxFgFGW19BI1TWwTyHYttbO9cPHH0cwZyHHZuJ9VWXIaz2Sv6rZQxuE9+h1Z7XKCogFHH+PjuCM7x8qX4PipMrUJIa5KpIhrVBlc9vLKfG9Rdho20sYO2z1QB5KPbWRaikZ5twH+STm5vFQHhgL30eoZmvvIkisSJeWMD0im34FXMFYJK6fG3d24QUHPCEy1+MkOfwnffk6htgMTGFlz9o38jDWt+Gk/UXOC4dFHYz7+ker58p972ty+NIVBkZQMq9f/osUARBV0iTHGGN/zRZOdQHfhFPXez8+lCkYUGc5Den4mMI71J4IqVVlI44pQsXPXuRcGKifvnPwLehpWUTZ090OB8W9ZG5wTKRsHvEtDmpY/Djg76fK5eWpgweqdSbTQ+YF8PIEGn+M0tteIWc6eznMtgmljgZv8DwihIvrnRo1sxL6jAE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cvOumaRUC6nMJVPgaXd0GZjt7ObVUnmJoY3gAci4pe01SpvlF16Qip9b3wOa?=
 =?us-ascii?Q?3zMLZRfX6cJsVSyFT+JKTSskMP2I5nZNBSH6cBwmqz7eMo12RCj4sxgEVA1m?=
 =?us-ascii?Q?bTJvYJ6NrzMkxtOOW6nXjoJe9AS7BJn881tyDjHlSphWh808/6XpyhvE5zql?=
 =?us-ascii?Q?DG5EOoPNjt9xRXS2543bSs3nL1ge14OREOsq6XHziogoKxOc/fWCHlT3Uoav?=
 =?us-ascii?Q?G7N6e2We7YJcnzChy88mKNGUH3nI4bUdmWAdm3wz2S4DBCsAvboWbIquwSgt?=
 =?us-ascii?Q?ZqwLgl7P5iC3iQUIXevnowvZ2cZNnvbIzou3uV03ll9QgpoGNWPgJdGzNLXg?=
 =?us-ascii?Q?+ZUeb1XWRfktKYvsIlP1ZBmMpWPjMFVBoSBYM8yNqVPuS/q+lrGHxNaSCvtp?=
 =?us-ascii?Q?b+qJGHJcPWvwjJcmiFcCc5aJRpOuLe1kT0/eejgKVKmdVmcbi9QBVlRGGEg3?=
 =?us-ascii?Q?V9jDzDSrh9yug0SYAtVquzWnaKrTJkMG/XI60gzM9+tBT+UjQZjIOmpfq+lV?=
 =?us-ascii?Q?P7uQzy8fmyMAaCiRZQOVwF+hzfPEEqdEvbxDHBQ0gBBHSLHhIeDRmfaPG1mc?=
 =?us-ascii?Q?3FlblDBmQu3AkE3E8tHvDIhrz972rOgELwZSm0/O/xyWeQ89dtEkGmvUtpD4?=
 =?us-ascii?Q?8agxiPkxjz6tikHsjVRHdyz5LXmqWXcLRdAnVNKBgGW9GCdIBKWBEU5G8faK?=
 =?us-ascii?Q?3ytj791hqxF+fsn2wwjqb/SfM42K8oz6s1QigGi00xZh+6L71fNGpIVBerjC?=
 =?us-ascii?Q?ZmhlYzZT5cdb/eDc046/zNu0NE1cKwXMyIF8WBh78tEjw4Myko2yZ83reBFy?=
 =?us-ascii?Q?CVEBZmGHXHr8ZId/qmjUQxZQl7P0LJWdm09e8i3wjemgC86nPq+iY8FpU+dd?=
 =?us-ascii?Q?plO9WjsgKb4ZU8eeDDHnd00pkQg+BqTqNTJ5pYUcWzR5G8x+jEE/WobXGlBZ?=
 =?us-ascii?Q?oyag98ysiqWtoyFci3XURU+/U5Gy1ZckTcSoDQ/8NHLrUjfHU2geIsP95MFj?=
 =?us-ascii?Q?Nwm+8QRKz9BvN8jnevy7URkPQ+VOoSA9PLiY9xTatY5osCvQ12PL5WWZoVGj?=
 =?us-ascii?Q?5KN2lSw055rvM1VadRF2U00lRVK5kq9iQQr2X/6Za86yfA1YaVA8k7yJr77D?=
 =?us-ascii?Q?hFeN6NGQLgIF83fhHypEjFRNcCl7KQCQbDiXmszJdO/4OfMz2j99uR/QiFII?=
 =?us-ascii?Q?HCcjQdMTjAsKElFiKYMam77brXMlo/L1pY/8aVqv5UZyaSBSdnM+MFPugvbj?=
 =?us-ascii?Q?v++2HQOJqGvr0nr8uGeKNHfY9k7L6+RC1zw+3HwDcZclIOXE3gK5b6EIuqeq?=
 =?us-ascii?Q?JR4qLwJtprY3leFkHM++kLthcykr0kDag2KkAW3Xs1Uy5AShTvu1SgS3Oci8?=
 =?us-ascii?Q?X1laBw/ELrVM0VWy8mJi+kzDmAboxSOpFm28FRkv72AaYYlGL+mdH4IUFkg+?=
 =?us-ascii?Q?DlY5yg6NkCYWy0a2dez2mczPpyDc1hjwl7bBWKh/Zr8F7VlEgsR+02kcfvwL?=
 =?us-ascii?Q?hr1o+kKxQbslBEtc4jRmGASJWVsuTpADzdRUJ82wwOIaByq92E+g/BHBsJJG?=
 =?us-ascii?Q?jew9jC5VkeEdjHtb6HI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB52848FF5C29D2FF732D21E338B2A2CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b9260e-a02a-4afe-52dd-08dc436b93b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 14:40:49.8120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7pSzrHIEYmbWrI7caQFL9ktUgfejrtSig/a+l8vEZLK2H/57j3Scx6g1mywlO4gWhqFN9bomU5nfxGrB+t+fzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
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

--_000_CH0PR12MB52848FF5C29D2FF732D21E338B2A2CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Might want to avoid bringup in the commit description

--

Regards,
Jay
________________________________
From: Wayne Lin <Wayne.Lin@amd.com>
Sent: Tuesday, March 12, 2024 5:20 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Park, Chris <Chris.Park@amd.com>; Limonciello=
, Mario <Mario.Limonciello@amd.com>; Deucher, Alexander <Alexander.Deucher@=
amd.com>; stable@vger.kernel.org <stable@vger.kernel.org>; Liu, Charlene <C=
harlene.Liu@amd.com>
Subject: [PATCH 33/43] drm/amd/display: Prevent crash on bring-up

From: Chris Park <chris.park@amd.com>

[Why]
Disabling stream encoder invokes a function that no longer exists
in bring-up.

[How]
Check if the function declaration is NULL in disable stream encoder.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 9d5df4c0da59..0ba1feaf96c0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1185,7 +1185,8 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
                 if (dccg) {
                         dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst=
);
                         dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->ins=
t, dp_hpo_inst);
-                       dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+                       if (dccg && dccg->funcs->set_dtbclk_dto)
+                               dccg->funcs->set_dtbclk_dto(dccg, &dto_para=
ms);
                 }
         } else if (dccg && dccg->funcs->disable_symclk_se) {
                 dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_en=
c_inst,
--
2.37.3


--_000_CH0PR12MB52848FF5C29D2FF732D21E338B2A2CH0PR12MB5284namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Might want to avoid bringup in the commit description</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" style=3D"color: inherit; background-color: inherit;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wayne Lin &lt;Wayne.L=
in@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 12, 2024 5:20 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.c=
om&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Li, Roman &lt;R=
oman.Li@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; Gutierrez,
 Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Chung, ChiaHsuan (Tom) &lt;Chia=
Hsuan.Chung@amd.com&gt;; Wu, Hersen &lt;hersenxs.wu@amd.com&gt;; Zuo, Jerry=
 &lt;Jerry.Zuo@amd.com&gt;; Park, Chris &lt;Chris.Park@amd.com&gt;; Limonci=
ello, Mario &lt;Mario.Limonciello@amd.com&gt;; Deucher, Alexander &lt;Alexa=
nder.Deucher@amd.com&gt;;
 stable@vger.kernel.org &lt;stable@vger.kernel.org&gt;; Liu, Charlene &lt;C=
harlene.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH 33/43] drm/amd/display: Prevent crash on bring-up</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Chris Park &lt;chris.park@amd.com&gt;<br>
<br>
[Why]<br>
Disabling stream encoder invokes a function that no longer exists<br>
in bring-up.<br>
<br>
[How]<br>
Check if the function declaration is NULL in disable stream encoder.<br>
<br>
Cc: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Cc: stable@vger.kernel.org<br>
Reviewed-by: Charlene Liu &lt;charlene.liu@amd.com&gt;<br>
Acked-by: Wayne Lin &lt;wayne.lin@amd.com&gt;<br>
Signed-off-by: Chris Park &lt;chris.park@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c<br>
index 9d5df4c0da59..0ba1feaf96c0 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c<br>
@@ -1185,7 +1185,8 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (dccg) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dccg-=
&gt;funcs-&gt;disable_symclk32_se(dccg, dp_hpo_inst);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dccg-=
&gt;funcs-&gt;set_dpstreamclk(dccg, REFCLK, tg-&gt;inst, dp_hpo_inst);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dccg-&gt;funcs-&=
gt;set_dtbclk_dto(dccg, &amp;dto_params);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dccg &amp;&a=
mp; dccg-&gt;funcs-&gt;set_dtbclk_dto)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dccg-&gt;funcs-&gt;set_dtbclk_dto(dccg, &am=
p;dto_params);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (dccg &amp;&amp;=
 dccg-&gt;funcs-&gt;disable_symclk_se) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dccg-&gt;funcs-&gt;disable_symclk_se(dccg, stream_enc=
-&gt;stream_enc_inst,<br>
-- <br>
2.37.3<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB52848FF5C29D2FF732D21E338B2A2CH0PR12MB5284namp_--
