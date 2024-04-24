Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FA0C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 13:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6545F10FEC6;
	Wed, 24 Apr 2024 13:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yKPSCcNY";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E5D010FEC6
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 13:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ad1m/NDnCKFMNZXinuC+I7Q0eLXgoO3UEoAHvARqtq4dq3IEus1bkaTQZvuQYb2tyfOWX1c+NV44Qcb97QGfT4qU4L69b7xS5TTvCeF7+zXTGStmVrAPo4/TNQ7MAy99ubMPjIJmo9bS6fVdmlf9nXoeGOOIvWQ3UYu+C/nWi+zn5pHPE6p6UhAYE8krJQGCUcK4RMSw4zOb6262vTe1usX4Pd3JfvXK+ZzRZdsvMHWXIGa9gXmMN/bA/7htV1ZU+tIsslNQ/3wFThHTHlQsFEB+w2xEuyc8tyHLoUaiuTmWIitRaHBSMCixcoZIzgR2KtCHMjQ8LG85CglZZ+EILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYGv5SEo3XkESCfFROnhyKRHd+VneMJYAR9PpeQQ4/Q=;
 b=OcMNWWyGacqnK2WCjocGZywcqfPfIqPbBNvV8ITedc76GC5nLmTFdF3gVGyuN2lofPBHGBP8gypU8pZY4wZO59Hf0TkclquQ53TST5y7uRa4izbw4ocnF3Sx/BXdy3h6r2rltallVmdP+RE0VklX6j7ex+mr2fZemugswCdRzC3whpNMntaXwiwBvsVnlWejIGYurY3QHsnENPxIGX3Vs8+oaqqU7+9t1tg1B1+Ss5CKq4rB/tM9uORbISeIaHFGDdiO9zx+yQMJYwYcfrJQa9VcRRf83WPHIxIvXY5IvRNVxL8ZXFQegBGvtDwFYuerGk47SNuvZC9Vw//WbNb0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYGv5SEo3XkESCfFROnhyKRHd+VneMJYAR9PpeQQ4/Q=;
 b=yKPSCcNYmfcbM28XQ3rTTjPSlQlbaLzqU/NZipqNlaETQez+GgKhovXqa6XQ7XeOmDX6cVsg0AyZOupyEzwMbK1TomnrjRwDUGMxiiID3yhYlN9zSTFaC25qW5s1BfERgywERkX3o2gNv+zOEeiduVz5EGIH+bYY4mq9OEaVmSM=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:48:19 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::6276:b423:ea92:cf32]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::6276:b423:ea92:cf32%3]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:48:18 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Wu, Hersen"
 <hersenxs.wu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Miess, Daniel"
 <Daniel.Miess@amd.com>, "Liu, Charlene" <Charlene.Liu@amd.com>
Subject: RE: [PATCH 28/46] drm/amd/display: Enable RCO for PHYSYMCLK in DCN35
Thread-Topic: [PATCH 28/46] drm/amd/display: Enable RCO for PHYSYMCLK in DCN35
Thread-Index: AQHaliTRlHuD8ZNSFE6bEo+F/m3CRbF3baBQ
Date: Wed, 24 Apr 2024 13:48:18 +0000
Message-ID: <CY8PR12MB81931C8B45AF5A0C8E5EE32289102@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
 <20240424084931.2656128-29-Wayne.Lin@amd.com>
In-Reply-To: <20240424084931.2656128-29-Wayne.Lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5edb1f27-89b8-4a24-8c47-9f095d65bd1b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-24T13:40:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|DS0PR12MB6414:EE_
x-ms-office365-filtering-correlation-id: e0428ff2-c2c0-490e-fa2a-08dc646532ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?J5aqgvv1XvkVKvROR1I7+sNV63lbqqXcxGFmWs6T2+AKwEPXCx4CgKIAcJ0e?=
 =?us-ascii?Q?8k6rNRh55XLU79sDkN2KH/6Qq5zuzZshzZ7xy6fZL+X4xpG1X/0LVxXEdgAf?=
 =?us-ascii?Q?sbihRdFQ6q2Yr4X4DLzo56zpdiriSQCXofaVO5mj4OWUHpZ68Yo3zUCJhHBD?=
 =?us-ascii?Q?aurUePQf+4hX01sZmCjghEKXyHCz9V88QZk18OR9l+o2IDAJ6og1Az6krtCH?=
 =?us-ascii?Q?4cYnXOANmNcjOckN2ItiFuF52zjq3fQp8/9Cu0zuzRz/AcKbR5Gq+EvtuT5C?=
 =?us-ascii?Q?HJ9AJbiu/l9FR2fr08vLX2+KCQ9Inln+lT1RYfsS4a8m6mHenI81O1TA3FdX?=
 =?us-ascii?Q?Ao6BLmmV3J35fvwhubHPVUn/K7ddPKt0nWX6rDS/N6fqcWukpfBbPQvLrulI?=
 =?us-ascii?Q?ZvruOFSnmO7rPA5R4nHjtnev0e0tfis58rs5Sd1vYgNPt69IwXbzA9CjuHuL?=
 =?us-ascii?Q?IYiunaIdaGtgsT9Z6TCVmvElpxpJq0qRrufE+aZk8recS1/PQAltlyN5Adie?=
 =?us-ascii?Q?5/mqk3v3hcZyQmT+mKd2Zm5SunKqIKEqZabnw2Q7XoLTEOHj7tJ1Xzpt9+OR?=
 =?us-ascii?Q?Z1rfDn3OjwzaoWGErLzlmfJfjzLWFHiQ8Du3f1cEU2kOnofk6GcCOV1j0Wr+?=
 =?us-ascii?Q?TO19W7yDi2IUHS2UG6WWTih7iIRar8YkwQ3VRbeGyXKLQ1pPACc+PXI+S0oy?=
 =?us-ascii?Q?456Hy/15305bc/uJAsHGBiw+2AziHdCqfgO7Awi0c4x7ed+MWMmdGlE4kgL7?=
 =?us-ascii?Q?iBY365rcbyyGwaiwcV7XuS0FT8Nd9ank/VX5ChG9SPKFbZG50YPTUmweooFN?=
 =?us-ascii?Q?XPeK2T05/ZXEN17iJIX4RrOOsyA0dFjaXq9mcFlRo8pIOg84DCbRHkB+gw1t?=
 =?us-ascii?Q?upwpW73e9PgpBRLvRIkwur1u362UcmzP8SOwQEyGAnZzzKPMfHURaacRNq52?=
 =?us-ascii?Q?l8Zcj4XOpVFo3W4b9L22nHwgV+JsE+JDlUSIW9Yv46kieSsFhh6h45gO2ZBn?=
 =?us-ascii?Q?ssg/jTCVbDieor2OXfFnIMSxYbVxoKkWVuiwbyKq+5eT9i1B18GnXa8Ts9as?=
 =?us-ascii?Q?4O9a6pVngkNAv3sJXWupumfH1nR26bENQPHXdYgeIuuqACfLif5s9RGCO3Zi?=
 =?us-ascii?Q?qDQc30iENJ30Y9OB7PSyQu2UqKNKImRsRGcqegfO6j0LGrnnhWnvfCyYihDs?=
 =?us-ascii?Q?BT99ihdsqHi9wvjaCGkZIBk4tlk5OhNkbSB2QsyvmE5rESpyfJs/+n8U75K4?=
 =?us-ascii?Q?KWiphM/+NKSgHmuHkVWw8GoKavSHr1jtN9ZVycB/kvd56FoVYWtWY8reAFeI?=
 =?us-ascii?Q?FD1xlFBCLom48Ewp1iGB1uKI5VdzQWCZyfB1izfa7zvY7g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7p05swfBCalO4AkGUtpvjUUwAPinFafNTJqkjsxYkXg4px4FPukKNOlkhBlO?=
 =?us-ascii?Q?qoH1fGTivZHt381dTQmByYFOWjK5D2Ulp06MK/eg597/2eIsKW9W/Byb2wNy?=
 =?us-ascii?Q?NcL0F930nFuyPKgnGY7SLaUzB4fUS1xZuW91t4EpkqsxQbnF4TyD2ZQRc6Op?=
 =?us-ascii?Q?8BuomfV8xZvcJ+xNQN8Da7ZP1nkBIGkXG+cR+FPK5XU28Tpc7+bFDnDYX5FT?=
 =?us-ascii?Q?nswHHY+a45SWbtEaGDxudp3AV3bHVDYdYxlZBWczBkXG3+gx5uotn4DIUzJd?=
 =?us-ascii?Q?8yH8jKxOV0sr3BLwF1T35idDVo14cY9OxI+KfEQLNjsXJXtEhXXRqqKUjhJE?=
 =?us-ascii?Q?JI9FGWFeIkrrdyRxZMk9QAs0urx1orqmN1w05+Mq9Q10pCSVUb/vBMIIEDel?=
 =?us-ascii?Q?HYzLbQF6eNt1k03ssZVhVNLEp+QVd0NZu5NeRgr69bZYXOTAboA4cdneMjuo?=
 =?us-ascii?Q?eFN8fadyTa95rAqwXJ8+O+qaaO1j9bcZFE/pYlghPLVqXemu5/BFHaUAH+m3?=
 =?us-ascii?Q?dsv6QP4IWqjOkf4JaMn2CuYsLGTnSVd0WQJ+P1qM0BiRmKx9Vn19pKtisppG?=
 =?us-ascii?Q?DyN3ms/ZCnNoypC086lGQEW3guRz0ULzUtweU3podD0IoMmIaV3tsSDOesBJ?=
 =?us-ascii?Q?HRWaB88oE3H5BMaCGRl+Vi/34Iqk3pdgSY8q0DzuYfEwQ0ZXqW9Z6/hRz488?=
 =?us-ascii?Q?alX2trq/+d2GUgN9aG2pw7mWlxRvD+NtSMcM1YlvtDg+TVY17YiTFB/0gIRF?=
 =?us-ascii?Q?YzLuqTudIImd8TM/Mqq6gbTYC1UyawwiOFSfbjPhFHQvtTc1CGMJstGVhhI3?=
 =?us-ascii?Q?x/TYuxj5NDqT3W1djPPcxzjVGsNe4IFBNPrzmrYS0GXeovaJuFuoSX4lYwPT?=
 =?us-ascii?Q?fcW9KI6Q396tmidV3114mMi7pexQS9wnRxCW4ik5hF0oERrnAY2IlOn0sGEC?=
 =?us-ascii?Q?ZBEr6uSvc8BEoChTv6LtsqZa5hPNAy6T23b3vQn7Y0yuSo0u5wtdIlLrErm/?=
 =?us-ascii?Q?rGMYMmv5RhEm+xSetpDOpE9dd1d+IsLnAyMbusxpkMAltxhmtYe5dtOD5E+5?=
 =?us-ascii?Q?0waNx5m7I6l6jxjqOiwQ5IliifkABoaBx6kO3ppuj8oEIqDu8GzGmfMZtHhX?=
 =?us-ascii?Q?XL+7zo9iCts+MydqTuETPk3KSwbM8BbQPDgix+ZfcupQX9FQClEKmfTdMjN6?=
 =?us-ascii?Q?/WKSKlhPifNfniUtc/Gwt/1DqmzKDW2L124iJS+Ypd3jCSm4khuvn1/vjMXk?=
 =?us-ascii?Q?rcyRLL5duiUtbMj6p6FTKIJp4siPts9fXLhJgHygeJZGA26l25Pk3f21E1P7?=
 =?us-ascii?Q?DMZSJkiar+yqLeH+zv2KbBjD/zFENVy2m44jufj1dpBYTfTjh1p48ym3SgNF?=
 =?us-ascii?Q?qthlEtYtmGsLEs67T4XQkkFrU1Ks3Om0SXQfO+mFt0twJGWDvKNHvWsnkip1?=
 =?us-ascii?Q?OgqQLvwnjNqr2WN9gsQVWFhHRSS8DjFaCiKA+sbCAMnnz/HUSdoDgZZmsdXh?=
 =?us-ascii?Q?EBSTzbTGtDL3E84lCyvjQ+2siWmJEtvIel20sOo67SU0eLnD93/pIQ+7/7c2?=
 =?us-ascii?Q?/25k/3k9gQ0owjMvcfQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0428ff2-c2c0-490e-fa2a-08dc646532ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:48:18.8140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFux6UVJJxbq+almFOfOo58VGAmtzvJ3MuD6LFnsgnjjADX++bRhhyfWyiZlbN9H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
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

[Public]

> -----Original Message-----
> From: Wayne Lin <Wayne.Lin@amd.com>
> Sent: Wednesday, April 24, 2024 4:49 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>;
> Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman
> <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Gutierrez,
> Agustin <Agustin.Gutierrez@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zuo,
> Jerry <Jerry.Zuo@amd.com>; Miess, Daniel <Daniel.Miess@amd.com>; Liu,
> Charlene <Charlene.Liu@amd.com>
> Subject: [PATCH 28/46] drm/amd/display: Enable RCO for PHYSYMCLK in
> DCN35
>
> From: Daniel Miess <daniel.miess@amd.com>
>
> [Why & How]
> Enable root clock optimization for PHYSYMCLK and only disable it when it'=
s
> actively being used
>
> Reviewed-by: Charlene Liu <charlene.liu@amd.com>
> Acked-by: Wayne Lin <wayne.lin@amd.com>
> Signed-off-by: Daniel Miess <daniel.miess@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 45 -------------------
>  .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 32 +++++++++++++
>  .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 +
>  .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
>  .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +
>  .../display/dc/hwss/hw_sequencer_private.h    |  4 ++
>  7 files changed, 41 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h
> b/drivers/gpu/drm/amd/display/dc/dc.h
> index 3048d5a0e87d..dd8940c2a4bf 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -724,6 +724,7 @@ enum pg_hw_pipe_resources {
>       PG_OPTC,
>       PG_DPSTREAM,
>       PG_HDMISTREAM,
> +     PG_PHYSYMCLK,
>       PG_HW_PIPE_RESOURCES_NUM_ELEMENT
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
> b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
> index 4b282b7e0996..795320a25fd2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
> @@ -461,32 +461,22 @@ static void
> dccg35_set_physymclk_root_clock_gating(
>       case 0:
>               REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
>                               PHYASYMCLK_ROOT_GATE_DISABLE, enable ?
> 1 : 0);
> -//           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//                           PHYA_REFCLK_ROOT_GATE_DISABLE, enable ?
> 1 : 0);
>               break;
>       case 1:
>               REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
>                               PHYBSYMCLK_ROOT_GATE_DISABLE, enable ?
> 1 : 0);
> -//           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//                           PHYB_REFCLK_ROOT_GATE_DISABLE, enable ?
> 1 : 0);
>               break;
>       case 2:
>               REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
>                               PHYCSYMCLK_ROOT_GATE_DISABLE, enable ?
> 1 : 0);
> -//           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//                           PHYC_REFCLK_ROOT_GATE_DISABLE, enable ?
> 1 : 0);
>               break;
>       case 3:
>               REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
>                               PHYDSYMCLK_ROOT_GATE_DISABLE, enable ?
> 1 : 0);
> -//           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//                           PHYD_REFCLK_ROOT_GATE_DISABLE, enable ?
> 1 : 0);
>               break;
>       case 4:
>               REG_UPDATE(DCCG_GATE_DISABLE_CNTL2,
>                               PHYESYMCLK_ROOT_GATE_DISABLE, enable ?
> 1 : 0);
> -//           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//                           PHYE_REFCLK_ROOT_GATE_DISABLE, enable ?
> 1 : 0);
>               break;
>       default:
>               BREAK_TO_DEBUGGER();
> @@ -509,16 +499,10 @@ static void dccg35_set_physymclk(
>                       REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
>                                       PHYASYMCLK_EN, 1,
>                                       PHYASYMCLK_SRC_SEL, clk_src);
> -//                   if (dccg->ctx->dc-
> >debug.root_clock_optimization.bits.physymclk)
> -//                           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//
>       PHYA_REFCLK_ROOT_GATE_DISABLE, 0);
>               } else {
>                       REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
>                                       PHYASYMCLK_EN, 0,
>                                       PHYASYMCLK_SRC_SEL, 0);
> -//                   if (dccg->ctx->dc-
> >debug.root_clock_optimization.bits.physymclk)
> -//                           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//
>       PHYA_REFCLK_ROOT_GATE_DISABLE, 1);
>               }
>               break;
>       case 1:
> @@ -526,16 +510,10 @@ static void dccg35_set_physymclk(
>                       REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
>                                       PHYBSYMCLK_EN, 1,
>                                       PHYBSYMCLK_SRC_SEL, clk_src);
> -//                   if (dccg->ctx->dc-
> >debug.root_clock_optimization.bits.physymclk)
> -//                           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//
>       PHYB_REFCLK_ROOT_GATE_DISABLE, 0);
>               } else {
>                       REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
>                                       PHYBSYMCLK_EN, 0,
>                                       PHYBSYMCLK_SRC_SEL, 0);
> -//                   if (dccg->ctx->dc-
> >debug.root_clock_optimization.bits.physymclk)
> -//                           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//
>       PHYB_REFCLK_ROOT_GATE_DISABLE, 1);
>               }
>               break;
>       case 2:
> @@ -543,16 +521,10 @@ static void dccg35_set_physymclk(
>                       REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
>                                       PHYCSYMCLK_EN, 1,
>                                       PHYCSYMCLK_SRC_SEL, clk_src);
> -//                   if (dccg->ctx->dc-
> >debug.root_clock_optimization.bits.physymclk)
> -//                           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//
>       PHYC_REFCLK_ROOT_GATE_DISABLE, 0);
>               } else {
>                       REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
>                                       PHYCSYMCLK_EN, 0,
>                                       PHYCSYMCLK_SRC_SEL, 0);
> -//                   if (dccg->ctx->dc-
> >debug.root_clock_optimization.bits.physymclk)
> -//                           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//
>       PHYC_REFCLK_ROOT_GATE_DISABLE, 1);
>               }
>               break;
>       case 3:
> @@ -560,16 +532,10 @@ static void dccg35_set_physymclk(
>                       REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
>                                       PHYDSYMCLK_EN, 1,
>                                       PHYDSYMCLK_SRC_SEL, clk_src);
> -//                   if (dccg->ctx->dc-
> >debug.root_clock_optimization.bits.physymclk)
> -//                           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//
>       PHYD_REFCLK_ROOT_GATE_DISABLE, 0);
>               } else {
>                       REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
>                                       PHYDSYMCLK_EN, 0,
>                                       PHYDSYMCLK_SRC_SEL, 0);
> -//                   if (dccg->ctx->dc-
> >debug.root_clock_optimization.bits.physymclk)
> -//                           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//
>       PHYD_REFCLK_ROOT_GATE_DISABLE, 1);
>               }
>               break;
>       case 4:
> @@ -577,16 +543,10 @@ static void dccg35_set_physymclk(
>                       REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
>                                       PHYESYMCLK_EN, 1,
>                                       PHYESYMCLK_SRC_SEL, clk_src);
> -//                   if (dccg->ctx->dc-
> >debug.root_clock_optimization.bits.physymclk)
> -//                           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//
>       PHYE_REFCLK_ROOT_GATE_DISABLE, 0);
>               } else {
>                       REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
>                                       PHYESYMCLK_EN, 0,
>                                       PHYESYMCLK_SRC_SEL, 0);
> -//                   if (dccg->ctx->dc-
> >debug.root_clock_optimization.bits.physymclk)
> -//                           REG_UPDATE(DCCG_GATE_DISABLE_CNTL4,
> -//
>       PHYE_REFCLK_ROOT_GATE_DISABLE, 1);
>               }
>               break;
>       default:
> @@ -724,11 +684,6 @@ void dccg35_init(struct dccg *dccg)
>                       dccg35_set_dpstreamclk_root_clock_gating(dccg,
> otg_inst, false);
>               }
>
> -     if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
> -             for (otg_inst =3D 0; otg_inst < 5; otg_inst++)
> -                     dccg35_set_physymclk_root_clock_gating(dccg,
> otg_inst,
> -                                     false);
> -
>       if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp)
>               for (otg_inst =3D 0; otg_inst < 4; otg_inst++)
>                       dccg35_set_dppclk_root_clock_gating(dccg, otg_inst,
> 0); diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> index b94a85380d73..dea7e63a49d9 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> @@ -506,6 +506,17 @@ void dcn35_dpstream_root_clock_control(struct
> dce_hwseq *hws, unsigned int dp_hp
>       }
>  }
>
> +void dcn35_physymclk_root_clock_control(struct dce_hwseq *hws,
> unsigned
> +int phy_inst, bool clock_on) {
> +     if (!hws->ctx->dc->debug.root_clock_optimization.bits.physymclk)
> +             return;
> +
> +     if (hws->ctx->dc->res_pool->dccg->funcs-
> >set_physymclk_root_clock_gating) {
> +             hws->ctx->dc->res_pool->dccg->funcs-
> >set_physymclk_root_clock_gating(
> +                     hws->ctx->dc->res_pool->dccg, phy_inst, clock_on);
> +     }
> +}
> +
>  void dcn35_dsc_pg_control(
>               struct dce_hwseq *hws,
>               unsigned int dsc_inst,
> @@ -1020,6 +1031,13 @@ void dcn35_calc_blocks_to_gate(struct dc *dc,
> struct dc_state *context,
>               if (pipe_ctx->stream_res.hpo_dp_stream_enc)
>                       update_state-
> >pg_pipe_res_update[PG_DPSTREAM][pipe_ctx-
> >stream_res.hpo_dp_stream_enc->inst] =3D false;
>       }
> +
> +     for (i =3D 0; i < dc->link_count; i++) {
> +             update_state->pg_pipe_res_update[PG_PHYSYMCLK][i] =3D
> true;

Please fix the index:
update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_in=
st] =3D true;

With that fixed, the patch is:
Reviewed-by: Roman Li <roman.li@amd.com>


> +             if (dc->links[i]->type !=3D dc_connection_none)
> +                     update_state-
> >pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_inst] =3D
> false;
> +     }
> +
>       /*domain24 controls all the otg, mpc, opp, as long as one otg is st=
ill
> up, avoid enabling OTG PG*/
>       for (i =3D 0; i < dc->res_pool->timing_generator_count; i++) {
>               struct timing_generator *tg =3D dc->res_pool-
> >timing_generators[i];
> @@ -1117,6 +1135,10 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc,
> struct dc_state *context,
>               }
>       }
>
> +     for (i =3D 0; i < dc->link_count; i++)
> +             if (dc->links[i]->type !=3D dc_connection_none)
> +
> +update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]-
> >link_enc_h
> +w_inst] =3D true;
> +
>       for (i =3D 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++) {
>               if (context->res_ctx.is_hpo_dp_stream_enc_acquired[i] &&
>                               dc->res_pool->hpo_dp_stream_enc[i]) { @@ -
> 1267,6 +1289,11 @@ void dcn35_root_clock_control(struct dc *dc,
>                                       dc->hwseq-
> >funcs.dpstream_root_clock_control(dc->hwseq, i, power_on);
>               }
>
> +             for (i =3D 0; i < dc->res_pool->dig_link_enc_count; i++)
> +                     if (update_state-
> >pg_pipe_res_update[PG_PHYSYMCLK][i])
> +                             if (dc->hwseq-
> >funcs.physymclk_root_clock_control)
> +                                     dc->hwseq-
> >funcs.physymclk_root_clock_control(dc->hwseq, i,
> +power_on);
> +
>       }
>       for (i =3D 0; i < dc->res_pool->res_cap->num_dsc; i++) {
>               if (update_state->pg_pipe_res_update[PG_DSC][i]) { @@ -
> 1292,6 +1319,11 @@ void dcn35_root_clock_control(struct dc *dc,
>                                       dc->hwseq-
> >funcs.dpstream_root_clock_control(dc->hwseq, i, power_on);
>               }
>
> +             for (i =3D 0; i < dc->res_pool->dig_link_enc_count; i++)
> +                     if (update_state-
> >pg_pipe_res_update[PG_PHYSYMCLK][i])
> +                             if (dc->hwseq-
> >funcs.physymclk_root_clock_control)
> +                                     dc->hwseq-
> >funcs.physymclk_root_clock_control(dc->hwseq, i,
> +power_on);
> +
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
> index a731c8880d60..bc05beba5f2c 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
> @@ -39,6 +39,8 @@ void dcn35_dpp_root_clock_control(struct dce_hwseq
> *hws, unsigned int dpp_inst,
>
>  void dcn35_dpstream_root_clock_control(struct dce_hwseq *hws, unsigned
> int dp_hpo_inst, bool clock_on);
>
> +void dcn35_physymclk_root_clock_control(struct dce_hwseq *hws,
> unsigned
> +int phy_inst, bool clock_on);
> +
>  void dcn35_enable_power_gating_plane(struct dce_hwseq *hws, bool
> enable);
>
>  void dcn35_set_dmu_fgcg(struct dce_hwseq *hws, bool enable); diff --git
> a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> index 0e87f3503265..7f2cbfac9099 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> @@ -149,6 +149,7 @@ static const struct hwseq_private_funcs
> dcn35_private_funcs =3D {
>       .enable_power_gating_plane =3D dcn35_enable_power_gating_plane,
>       .dpp_root_clock_control =3D dcn35_dpp_root_clock_control,
>       .dpstream_root_clock_control =3D dcn35_dpstream_root_clock_control,
> +     .physymclk_root_clock_control =3D
> dcn35_physymclk_root_clock_control,
>       .program_all_writeback_pipes_in_tree =3D
> dcn30_program_all_writeback_pipes_in_tree,
>       .update_odm =3D dcn35_update_odm,
>       .set_hdr_multiplier =3D dcn10_set_hdr_multiplier, diff --git
> a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
> index ff772665d1ae..91484b71b7da 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
> @@ -148,6 +148,7 @@ static const struct hwseq_private_funcs
> dcn351_private_funcs =3D {
>       .enable_power_gating_plane =3D dcn35_enable_power_gating_plane,
>       .dpp_root_clock_control =3D dcn35_dpp_root_clock_control,
>       .dpstream_root_clock_control =3D dcn35_dpstream_root_clock_control,
> +     .physymclk_root_clock_control =3D
> dcn35_physymclk_root_clock_control,
>       .program_all_writeback_pipes_in_tree =3D
> dcn30_program_all_writeback_pipes_in_tree,
>       .update_odm =3D dcn35_update_odm,
>       .set_hdr_multiplier =3D dcn10_set_hdr_multiplier, diff --git
> a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
> b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
> index 939832372baf..7553d6816d36 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
> @@ -124,6 +124,10 @@ struct hwseq_private_funcs {
>                       struct dce_hwseq *hws,
>                       unsigned int dpp_inst,
>                       bool clock_on);
> +     void (*physymclk_root_clock_control)(
> +                     struct dce_hwseq *hws,
> +                     unsigned int phy_inst,
> +                     bool clock_on);
>       void (*dpp_pg_control)(struct dce_hwseq *hws,
>                       unsigned int dpp_inst,
>                       bool power_on);
> --
> 2.37.3

