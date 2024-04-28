Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744A6C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 06:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A250310F52C;
	Sun, 28 Apr 2024 06:25:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bSB7Z9th";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20AED10F52C
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 06:25:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZSLeBbAFLhpw2T4JHZWPPCGn70Ukw41aP8kiLLh0kwSpqvXbgel3EB377Yq1NKMw8WMsf2rtX8PwxiPxEGI00WsWvWIg+B62ACEwunoVCyWPz9ESKlur6iXMxu5aNjftPRP+iaXYOk432ogEumr8yK2hwNkcTozXN2EyTX5ZLeX+jtWRJ9WmcdDp+DwfW/SRsx8EpFZBb8yswypYsD6WpVwG2BB9INMOm7vr9uBrxp8k/Cny3B2osvecod2mK/dfvJz1elUi+bL1rdqXEjYyu3ya0DSlv7rPdvZhvOsk2x7qZd9RY+hToXOBs2QI7Lq3YlZ6Qsi22+rdo/MogzB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NixZcZwF8qYms3HhHW1KBL2Wwjerbtxj7oqwfP94GhA=;
 b=Bx2hotqAXGIjGxOMjSSPKmz6O2DpnKwiY/uEMv1RgFvFo5EKQD/QlcNxKxZxWTt9JfkglG2S/OWIMoaOQWqoCEebMjmZPetuXHLidZUFHn/QP638/yAIUwvwPwbOYlL1GK0v2VuYmSy4WYoZeKjc5RjLFfFI0o+PFK9PLsswVL9uv5zeGB8iogkf9fZKlWSyS4QW0dgeEodaaQTRfq+2CpWdciCwvLOAA8kwF2Z9i5vfL6SpODM08Jl0L35DYRC8GwSRJh3KbOZmVhNvxhoNEmg0UIsLG9730xu6382wFR7ddc0rheTYSf2CDxh9jezps7rKiYVhBVoKJMAQoRiaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NixZcZwF8qYms3HhHW1KBL2Wwjerbtxj7oqwfP94GhA=;
 b=bSB7Z9thlKk1IKGvDFoj6JbAozqiqIEmrmbZHJZ6Z6h3/x8c1RvutnRvCouTLz6por7E309qwK7jtPODOXwfJkMeGMMFETLcU+4riGsS2SXEnikAwBwq38JH08DK944TCBil+tg6bLkaM8gVGeXSpWPYSp20l3xgcQoagnLqYhE=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 06:25:42 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.030; Sun, 28 Apr 2024
 06:25:42 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: fix the uninitialized scalar variable
 waring
Thread-Topic: [PATCH 1/2] drm/amd/pm: fix the uninitialized scalar variable
 waring
Thread-Index: AQHal79zXqdVPQmiHEqUUEOUVERxkLF9Oirw
Date: Sun, 28 Apr 2024 06:25:42 +0000
Message-ID: <CH3PR12MB8074477FD8AB6BBE02DF11C6F6142@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240426095218.1075237-1-jesse.zhang@amd.com>
In-Reply-To: <20240426095218.1075237-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=23b8235d-07d9-4592-88bf-c419196bf55d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T06:25:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|IA0PR12MB8973:EE_
x-ms-office365-filtering-correlation-id: f602cb94-3b0a-4431-0120-08dc674c07d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?gZJdtZ4GtN5Tcsr+RzUx/4FCrupnOWbVrY/B/2IgTtDdVbSVrbk/Ncdhz4i/?=
 =?us-ascii?Q?pzNvHggxsNJXXUfUqemnfapmFMR+hyqnrOsWe7I8irOovxNktslTAip3VVjj?=
 =?us-ascii?Q?1pwNRGVWFYFJUsHL6KrSMMhTemw8JDQFbI6QOxb7qdzXemWR0ZWzoimwGcpz?=
 =?us-ascii?Q?rDObk6dj/mqoFNR5JMVqafvX562EJtoeHFfe9LwhKgcRZvmwo1qmoEGcdO4k?=
 =?us-ascii?Q?jr1WaO0HonhZk376GZ6/MBm7HSkdUXShZwJO08bl7LygeMh9Qp/d13pg5yhn?=
 =?us-ascii?Q?klaZfzu0P3bZDjj4haSnf4Q+Q4qFcJqrIMO5KrCI+17ACb+px7MfJo1Qqab4?=
 =?us-ascii?Q?uWvFQHBR8UxWjzIV66IgfbAG862aXToOUhNxt6szpoD/jTsWxlLnwkBCdl80?=
 =?us-ascii?Q?03QAZkSCd8XGwwrfpQaf5arYZaAsO7t8DF7h617S8c7GmtyAkNqHXAUkFTvY?=
 =?us-ascii?Q?67HBLrHKFiFelvICdZ+MMgi4HWzy7oFww3qvVcp2ZPIzgXb3UwiTOPr5k+Fw?=
 =?us-ascii?Q?UllE1tVi450WDLdOcWUjcSEzI4WvIgN9AY3/fwNsFMShmRI7tsJkaumrMiho?=
 =?us-ascii?Q?gcNRWo/I5ZanO7bnUVIvcnKB82SBdLtB65o8iaWSi2nXlqIzzbwKQHkmPSiY?=
 =?us-ascii?Q?Dea8/vcHVNRixc4LH/ElnXjUaDeQdUAmh1hC44vtD3E15ibL/56YWlW1cWjR?=
 =?us-ascii?Q?sDp4elONk0fFiTjUnmITGDODypzjg9zq0WU5df8glWT2YTe+DrxP2o7tx3NZ?=
 =?us-ascii?Q?IHkS9Hg4QTUv1Vzkts62dvUtocxTq7nwrQTZCC/jHGjPq12fpqKO2JlNTN6m?=
 =?us-ascii?Q?MZEaINWh/6R89fbWgJx+B/DLD7byfP6aia7Lt+kcFRW0rBKaEPVl7AmLEBEn?=
 =?us-ascii?Q?dUfJeLdW8oTXnXsy1x7r1JgpD8FpxOUg+WpHoXj8PU2iUVMGJx+L9+SchO+x?=
 =?us-ascii?Q?t99wRIcqcNZw2IzpOvKE+m+oGizyO9ZSj4vlbuJDx3xfY2LZkcwHjeV/iROa?=
 =?us-ascii?Q?wrPBgSGSDXqlupJEuu8h//n/O64HeV6zSVwLCtiCyQ4k9J8bDE8C/7InDufj?=
 =?us-ascii?Q?fEAeB4xTZMGO2NUWSNYY+PDTIRDE3LLUeV9v7oQ+Ifxa/t+idh0wTyd5RHaF?=
 =?us-ascii?Q?1/iF6o7+5h8Ou2O6xpwRMXWCuEOKwi/xHhQCc3uj1v5ffBlHrwMy7192b53s?=
 =?us-ascii?Q?7ZdkR+3WW7b7I3MLoQhDnOmYFkgks+d+vowyNK6y5NDcvqjgGUEDbBrxmz/1?=
 =?us-ascii?Q?Igm2bTh83EWGU4IYqZSCwps9eKQo5uxCCbwC8Tyw+y6OqBBsRkotGtd1r3OJ?=
 =?us-ascii?Q?CZAlSjHPqcf1jDUdO67Qm2auttN14n91dvTStQXw3As04Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GdFFvdCoIr2qldwG8vfJbGGLw9WMQt1APFrwPCc4H4ye7YyTJHEJY4IJZb8H?=
 =?us-ascii?Q?jq0BUUlF7CLF+OFsVTZqYyQrGmnMEklOVxxmJZDSrUPth3ecmT7Xc3aZqFsw?=
 =?us-ascii?Q?Xt6Te8U9Up8hjkdnScTEvBX/GG1+hjddXA3uUe3Uw+vMVzfhl6DcE06rT0Q9?=
 =?us-ascii?Q?1uIlN54Lx1/WhtAkilfs/RoYi7QTGOH+etsnAWZmLEtey9AFxc33ReR3GDc2?=
 =?us-ascii?Q?57Cl6WPYmCiQWwivdt/hAVAheYts4N4FQt6i0PAvTOWCPmW/jL7uSd3VKuLZ?=
 =?us-ascii?Q?G18UErCYoWVJiWhwgy/pbWNja+cHA9FezHO0oc1hqKVjkOoMwlVxAqkKfCke?=
 =?us-ascii?Q?rIlY2hyVrmlI3PE4Q/dAPC3cPA79JjwW7tU4+qXO2WYq/ivdPc/Bd1SN56rH?=
 =?us-ascii?Q?gFtQ93guCyvd1eu9RIml1xX/lBMOzApglQQQEVlqVnZVJmuTrlZqydy993c4?=
 =?us-ascii?Q?3bbvIpP1NNul2HiCvU6KfkVF9UotlIqdQ+bU5qPCPAD0oY7kSLr7xlxDir9a?=
 =?us-ascii?Q?+FS8mmQxJBsqNjGdFWGPpJO/OX3SiVUw+IaK7EMtqwub2HicUi6H3Q7B2i2L?=
 =?us-ascii?Q?UuCzDPMOrOZ/E5nNdnmBS/b/JWid2g3llk16TT5l/L3VKDzbbJttHCMDwz9y?=
 =?us-ascii?Q?UYQ0aZnEh12bAdEQBZcbzNz8MhVP5CpwLNHE/WCGT9MwQ28ejstX5Bt58Y0c?=
 =?us-ascii?Q?DVCXD8VK2a1n+jvcD/nuFLczcdwbH6m85qetIcepe5g8fsjsSDzS/bEbr1NM?=
 =?us-ascii?Q?n6qd2agrU3aPL5pi5V1+ptGOFX1sZoBFShCBdRGdUTP6DiOoLyfP0WasP6oL?=
 =?us-ascii?Q?1fHdspFKlLfvFNzrUy2N2LNtOiA9XYNhsIUnHuqKOyPKvFF+fdrCxX6ulLhr?=
 =?us-ascii?Q?WpEU0rU1ekif81EIPiBzwvuR7cNFCIRqqqXEurgBYgvTwIFyPTIptSazuuZG?=
 =?us-ascii?Q?v8cgROzsy7BFbhFIafrjkHFYLpAKbbg6oZp372TdX+zOLHCuu30AeT0Ds8/7?=
 =?us-ascii?Q?n90y0qEhDVbuCmwp3wbEVtoRN+Kzwh+A0f/sBM4W2hhqrPG5XJWMJyLMWnBX?=
 =?us-ascii?Q?E5ByVnF3CpJ9BxhXUduxH1XMjN72Y3lBI24xn/ZMydt0uwInFUtJZrEQDbRB?=
 =?us-ascii?Q?rbmFPdQ0DUdGIVlbtph6L06qesrjHWG0Y6jU1L5SmR39L5w46N6Cm5YdGXeu?=
 =?us-ascii?Q?GlPS6BvRH9kGA7wVBN1uyQ2mB/GY08HMuzWPXR64RCUD3J7QxYNcUxK09dKg?=
 =?us-ascii?Q?AjmJeJletkUSo5zGSofouNt5R/g99q9hDFrEI+CzXDXW9ilywOXrI7S6rOnU?=
 =?us-ascii?Q?y/n5ZU3pZP5+DTS457pUe/E/QVywkbFpHtrOQHMTk07CcOvJx5ogaela1Gs7?=
 =?us-ascii?Q?hjcPLa41S6BxrSlBS2FQ8Bl+cZDAROrwuoH96IC10eUdalNUHAznVj1zaqDe?=
 =?us-ascii?Q?+iSydy4VoSG8lSUTqqacsxIuowSL7CEUaD4qsfNyil9WBcwLU1GElzSUq1Mf?=
 =?us-ascii?Q?pYQ4lABQZ1zT/eaJqPloeYMctLhe9wyNMBdye62ToPMLsmz5tUQP9h+IMLzC?=
 =?us-ascii?Q?Fqc9e76Sj3zOwhsl/sA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f602cb94-3b0a-4431-0120-08dc674c07d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 06:25:42.5891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O7nJ4NxUvyXbqWMeAo44wOiFsZhVGBwv52Woh+EhBgomDvlUboTEyljTvBVgfDuAj/ux4hlyLCFBMzUheQHORw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, April 26, 2024 5:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 1/2] drm/amd/pm: fix the uninitialized scalar variable wa=
ring
>
> Initialize variable size before calling
> hwmgr->hwmgr_func->iread_sensor, such as smu7_read_sensor.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 5fb21a0508cd..ec2b6d0674ed 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -102,6 +102,7 @@ static void pp_swctf_delayed_work_handler(struct
> work_struct *work)
>       uint32_t gpu_temperature, size;
>       int ret;
>
> +     size =3D sizeof(gpu_temperature);
>       /*
>        * If the hotspot/edge temperature is confirmed as below SW CTF
> setting point
>        * after the delay enforced, nothing will be done.
> --
> 2.25.1

