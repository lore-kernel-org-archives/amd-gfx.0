Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D511C25B5C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 02:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BA610E63F;
	Tue,  7 May 2024 02:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kmwYepW1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17ACC10E63F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 02:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdDwXPQKahkUmR394Hcachv++MptcT4FFhye8lHxR07x4G0Pf6dTeNC81N22aF1a+IKLNLNw3ol3hUForstinyz/uSf9eN6zjyvBACEL8kJvfcnbP/3ghDiw8togPvxhWTFFrm2CU3QQcG4ZQ5T7f/KvADyYaWKxrztS+cqXYE/BVMeqFdvIQL+i7WkCR+1kEmEgHiAh1t3UpEva1nNovHpdpDxDGhLJlzfCy+gX495H9CWarKKH9azYgKNRWC928PPZ3oxNeTgeoy3egUS9W8DVNA5YV+n3F51iqfz+4t+HEjpnadlon4c932hVi5EOmG1f8XEFF+jl/09yolw11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb/VQT+zNSQDOwRipWy9AATJ6qJUZ0rKj3Ft0rlWx30=;
 b=RYIDQDe9MPWZJXN7ul2ParZcBVGbD0Cjf+6W9Tz+7+tpArCy4IxOjvmSUbIhk4cnaa6sLwIcX/kAkm6HpxSXln9UnhjVJhG7wWRzhuW0lub/JYcANSGXVTuzaiXgx0iNRiq38VKv9+4GE0R763+U+z7cLUdlCNvksGPHAOyOV8C0HbTM1uinCYtczCuJJ/xM81MBZ3EDOP6pc/UP/7yqFSs8ub4J1ewAA4cbIG/S0Zz41Igi8j+r8asVQZZrA7xmXcnRPFrzQr+nd5eGN+CTaWe7Bi3rSaX7CG16TRec+AvHcu57IwdNJS7ckGe7sDB4xBI5mm7q53wkevtD6k7RzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb/VQT+zNSQDOwRipWy9AATJ6qJUZ0rKj3Ft0rlWx30=;
 b=kmwYepW1AFo3oo/MjxVzQJgk1JGzeSn1ecL5sMOD8FNnmp5GgQRy/eROY7D4mTPTdl1NnWyPVaU6xJBZ9CQOuFRtwGXJhwKCIJUeA/1GiUQ7HM2HjfhwLw6F2yANM6p4BcluhHYS88nttzxL84An9oPcizVk3iytXVIugic5tKY=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 02:32:33 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 02:32:33 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix the uninitialized scalar variable warning
Thread-Topic: [PATCH] drm/amd/pm: fix the uninitialized scalar variable warning
Thread-Index: AQHams4GNxDRvU2YpUmVcTmZy1KwWrGJxW4AgAFOdKA=
Date: Tue, 7 May 2024 02:32:33 +0000
Message-ID: <CH3PR12MB8074C23AFF4D40A6E0FC34D5F6E42@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240430071411.2107891-1-jesse.zhang@amd.com>
 <DM4PR12MB5152552FB7146E739B57EBA7E31C2@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152552FB7146E739B57EBA7E31C2@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c10bbdca-c93f-4f05-8f1f-f98e80003857;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-06T06:18:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|CYYPR12MB8989:EE_
x-ms-office365-filtering-correlation-id: 23e8d29b-775f-450f-604a-08dc6e3df333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?pHLfRFCxVtRaipkTpvcFKXewTc88HfUR9bNvCNPhBGZfN+y4eMKgMjE/p+oP?=
 =?us-ascii?Q?84YETLCTQ73DUYEQhPCk7GD1rULaybh7LNV8kMG6MGZ0WxrQindldeCojtt4?=
 =?us-ascii?Q?4/AMOqjueGB0mgFDWm+Bs38EAYQlXCVI8q8X9U1a5I8xNcSsfH89NHyokaO6?=
 =?us-ascii?Q?A+5SfoQn7wj4p1zdRbCgTBEasfrskCvE1QAvNQ4iLk1aisMp0JdVIoDVFTZX?=
 =?us-ascii?Q?nyhL0FWtNpiHOYTzn78hHeDxemCrHGZtIQBbTwOci08FJH3IZG1InLS/6XXX?=
 =?us-ascii?Q?Vp1zuRnxvVZSobFYyHEP00APprSdlDZaXyoni5P51ZMPeHzztPiWSyqS4gl2?=
 =?us-ascii?Q?9P9ZVy3gSBt7u9VWdC0pG9ps0TwtZ5OMP6Gys5tgmPHSqOvWoyHUbTE+tDCS?=
 =?us-ascii?Q?Boqvd9i022FC5UwyX0FIHddg4hTe3FNcUSqSE+9NS3WbgZGVseLZNDiSz9vZ?=
 =?us-ascii?Q?uHgxhsln8vUEQI7VOcjtuBjz39iLb7duuDizuTeofo+EdbP/NnOsvF8iTf4w?=
 =?us-ascii?Q?DR8U/JrvVn3vEgEWGUP/bObxcIOr+2fh80nxXaBOgYH9ckeu6FefvRxwOTI/?=
 =?us-ascii?Q?s61ful8VxVQKCRg9NPphnANGf/tt4M1atSiadCgJq99wJE1HOEeQCVIXRYBF?=
 =?us-ascii?Q?QEfzEzHIq05rnS62AzS+925q8zSn/cnwr+/b0SXA5zKo+BwLFyHtQbgDwgu3?=
 =?us-ascii?Q?eAZnxyLh6xhm9QT1wPm9IKvFbYfsEMzAQFBTvIsgIB5H8auRp957RhKrZyty?=
 =?us-ascii?Q?mQY0fMyn1HuCU3loT1kjKR7qsQXFBIEA/b5urxJA+tUVkZrvYTNW1G0QzOK8?=
 =?us-ascii?Q?mF6Bp5OCYHt7BOOrl1LfljPf9T2nxd2ceTfR3xK2HLTI6KbAZoZCSQa1cjYL?=
 =?us-ascii?Q?wEFW1J/WuQZdsyISXXeYKojDZWch975H0VYIzcOWWzoA5E50s6XA0qCOxm/N?=
 =?us-ascii?Q?rEkel62sxYORVePFXt4zFI0hS0Io80OhFqB4Aq2naOzDA07lMSgO+dTfBUOE?=
 =?us-ascii?Q?CVvQFaETTRRfwLAJxFJ/8wHtZELxf4RHPPaB1Qwy+567wDYtbEJbmnFWutuO?=
 =?us-ascii?Q?KaMQEupoSFPfuF+mp7p8obMnn19tVmewBkQBI5Yg4Q6AiokEaTXlms1rVSfN?=
 =?us-ascii?Q?zsLB6Dmo9lbRTO1eKm3dHUfcJbwbdEM0hEx7jf+o4cszL6yFX0+udgw3AOXa?=
 =?us-ascii?Q?+5VD0v8fRlDCjD6I5t40Fnqz7a/BEdC9Cbwzt/9QurOIxoyKFLFUSUOwpoL8?=
 =?us-ascii?Q?jy2v0y48VDsK1ArPZSJiO47RKFw97S5YQFfjqUPGtKSzN3UgsxmYvaGDQswH?=
 =?us-ascii?Q?pRkuGOQEZ6d4Kr4RzpL876NMUH3Bc62va1vZmTEWMAVWBA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L5OSqqApICVqVep0tPAR08tx6L3clmsu8ByHZaHqQw8n2bQIYdpSGOxVKaN5?=
 =?us-ascii?Q?MnDc5+7TtVnrKDAJU9I1yRi2MsoAcrbrfD4k5GtuESP1G15+eu+KHC56t6Od?=
 =?us-ascii?Q?MVJB8Rfk9ZCRTsvxzJ5iDqYgOgjT8smO3doO84734bi1sOYdMsPGHPiRXYKB?=
 =?us-ascii?Q?n+wt3ls4Qm8mrYiLsjQ5hdRCbBs/mBxxHuqQ5UZsXBwGWHO8Vd45XmoYX+xD?=
 =?us-ascii?Q?98ZTjuX5etNQgiszDbfbkI2w0Y1GjNQdANDmN6ZYwp48gbVsJRNd2nwoEKhk?=
 =?us-ascii?Q?6sxuPIo5uQijvgFfuiAXalSijLuKRkP+SaJc55MXaS74Iz0gqmlFiK0VbSG2?=
 =?us-ascii?Q?iCCeGlVFtE26SRYvvno2AalkYW4ITsgE4gNsU3FrJrnX4OAGfoYGK1xfqBsD?=
 =?us-ascii?Q?HhRI7aukeptGlSMU3VZ03MbGa9cGAJYUh6MjKnZ/wbEVvdaQ+IpbnT0vsxY3?=
 =?us-ascii?Q?lqNUiKjaNwwGfxafWxjrHd619PZAChhAikrKiPxOuAwdU2NTPOileiAidw14?=
 =?us-ascii?Q?mfJovj17j2laH4HtY5YkFIRzXpPHCiYpT+fxZyFB6uyv/eqlLO5yJ4o4p/iD?=
 =?us-ascii?Q?MUgG3jT1EXr2iqkf9tMdnfA4paJFHJ/HrObXZUhvBGMieG2FxRLL/MlnafEi?=
 =?us-ascii?Q?c9YCulAiI+Od5Ce0R4NAazTDoRZ6YhLDIfKlMcppOJ/4Ohi0bcPXMbqrFd3l?=
 =?us-ascii?Q?leuTvqBX/8E1vHo72S59rM2zLzYFtCezd9sichzji0KdRV6DW3V5MLjHYJPP?=
 =?us-ascii?Q?EUnEHPgFDVPvTq2NVRlpr6U612imfoSKb7WEH5cYngUFNWGYep6EqCA465+5?=
 =?us-ascii?Q?kODYi5W1KyKrhnH0IOgchD7FeG/kV6fpaOxeXSWRnS0j1iadXB/xblCSh4hf?=
 =?us-ascii?Q?BTuJuu3+xfVdbyMHg+/11tLv5pWcDtLXjM5yHOYoJ23PvPFjjtPrSGKnzdhj?=
 =?us-ascii?Q?VIuJj/q5vNAB/RuVSIPCOMJk2Hl4sNpw7OUWTwSnjGKWCPzp/3vTSs7wK3E2?=
 =?us-ascii?Q?M35Xad+m+cx8lw00hAyZHG74pmhFWGEQtyWlainzCS6BK9O5pip0fNmvMelS?=
 =?us-ascii?Q?bFcjOe8NTdY7Sk55Qhy5keYUSeLjOQ3Rb5Axj1rn1hVYsWcJ9X8js8xVCi1l?=
 =?us-ascii?Q?zblrWBPnpb9eHPT5WkYnBCUkmivld7PPI+gXb7SzZpKEynGEOz3vsq3gJGY0?=
 =?us-ascii?Q?OPOv3bhvPtxpB3FPtSJAboKCcFzpc2Cy7/588AzdRavmmxqq84cRwUiXaE/I?=
 =?us-ascii?Q?61ef1pQAniiHh+n0yKzf7QFZzmql3I3HKcu99fGo5qgMSfL8CBwtmSZamBiX?=
 =?us-ascii?Q?wGQkm/0LoboIIeJ8VS3U5Z5PcXfYliRxZwyixLMl84RPaFBCjSZUyLaFAgaM?=
 =?us-ascii?Q?cxI0VZ+EO+/iwq8vXtgpVEIsgFHFC9H8VhnIvNP+dlyC9gAAi6NTTM4oFtEE?=
 =?us-ascii?Q?8yeBs3RHRv425jEH+rmJzBQglEtiGx1gFtAE48t7mASmAQ/JrvbF6nw3xpzf?=
 =?us-ascii?Q?koefRIOUQPqVVPGw4SqYlYX1nIGSflk6JkJ8LC29B2fmau8MejICc2JSpFi6?=
 =?us-ascii?Q?WdskInQP2d1yOuOc9Gc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e8d29b-775f-450f-604a-08dc6e3df333
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 02:32:33.1892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZe3VubZ2l9NlOZg1o9k+uO0OJavpr79wxvJxw19e90X/voSEXxzpTtTyYx/dkDPQVqQXpKjRUuUrZav2tQdyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

[AMD Official Use Only - General]

Hi Jesse,

> -----Original Message-----
> From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Sent: Monday, May 6, 2024 2:21 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.or=
g
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: fix the uninitialized scalar variable wa=
rning
>
> [AMD Official Use Only - General]
>
> Ping ...
>
> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Tuesday, April 30, 2024 3:14 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amd/pm: fix the uninitialized scalar variable warnin=
g
>
> Fix warning for using uninitialized values sclk_mask, mclk_mask and soc_m=
ask.
> v2:Set default variable to UMD PSTATE(Tim Huang)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 32 ++++++++++++++++---
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 8908bbb3ff1f..36a49cfc22e4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -835,10 +835,20 @@ static int renoir_force_clk_levels(struct smu_conte=
xt
> *smu,
>                 ret =3D renoir_get_dpm_clk_limited(smu, clk_type, soft_ma=
x_level,
> &max_freq);
>                 if (ret)
>                         return ret;
> -               ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetSoftMaxSocclkByFreq, max_freq, NULL);
> +                /* =3D  0: min_freq
> +                 * =3D  1: UMD_PSTATE_CLK
> +                 * >=3D 2: max_freq
> +                 */
> +               ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetSoftMaxSocclkByFreq,
> +                                                       soft_max_level =
=3D=3D 0 ? min_freq :
> +                                                       soft_max_level =
=3D=3D 1 ?
> RENOIR_UMD_PSTATE_SOCCLK : max_freq,
> +                                                       NULL);
>                 if (ret)
>                         return ret;
> -               ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetHardMinSocclkByFreq, min_freq, NULL);
> +               ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetHardMinSocclkByFreq,
> +                                                       soft_min_level =
=3D=3D 0 ? min_freq :
> +                                                       soft_min_level =
=3D=3D 1 ?
> RENOIR_UMD_PSTATE_SOCCLK : max_freq,
> +                                                       NULL);
>                 if (ret)
>                         return ret;
>                 break;
> @@ -850,10 +860,21 @@ static int renoir_force_clk_levels(struct smu_conte=
xt
> *smu,
>                 ret =3D renoir_get_dpm_clk_limited(smu, clk_type, soft_ma=
x_level,
> &max_freq);
>                 if (ret)
>                         return ret;
> -               ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetSoftMaxFclkByFreq, max_freq, NULL);
> +               /* mclk levels are in reverse order
> +                * =3D  0: max_freq
> +                * =3D  1: UMD_PSTATE_CLK
> +                * >=3D 2: min_freq
> +                */
> +               ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetSoftMaxFclkByFreq,
> +                                                       soft_max_level >=
=3D 2 ? min_freq :
> +                                                       soft_max_level =
=3D=3D 1 ?
> RENOIR_UMD_PSTATE_FCLK : max_freq,
> +                                                       NULL);
>                 if (ret)
>                         return ret;
> -               ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetHardMinFclkByFreq, min_freq, NULL);
> +               ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetHardMinFclkByFreq,
> +                                                       soft_min_level >=
=3D 2  ? min_freq :
> +                                                       soft_min_level =
=3D=3D 1 ?
> RENOIR_UMD_PSTATE_SOCCLK : max_freq,
> +                                                       NULL);

It's not the fault of your patch. The original implementation may not set t=
he correct min frequency for MCLK when set to the performance level PROFILE=
_MIN_MCLK,
For the case, we should make the  min_freq =3D max_freq =3D clk_table->FClo=
cks[NUM_FCLK_DPM_LEVELS-1].Freq.

Tim

>                 if (ret)
>                         return ret;
>                 break;
> @@ -932,7 +953,8 @@ static int renoir_set_performance_level(struct
> smu_context *smu,
>                                         enum amd_dpm_forced_level level) =
 {
>         int ret =3D 0;
> -       uint32_t sclk_mask, mclk_mask, soc_mask;
> +       /* default mask is UMD PSTATE CLK */
> +       uint32_t sclk_mask =3D 1, mclk_mask =3D 1, soc_mask =3D 1;
>
>         switch (level) {
>         case AMD_DPM_FORCED_LEVEL_HIGH:
> --
> 2.25.1
>

