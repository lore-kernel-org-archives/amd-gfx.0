Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62FFC25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 07:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1721310E1B5;
	Wed,  5 Jun 2024 07:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uv5oeaZS";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02AB10E6DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 07:05:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIcYoz4n50UWEKlyHkUE9maaGSP0sbZu5Z7AfuDhsK4wISEVXTON8hL6Rxn9iCJ125EH9M4ZaYK5wv9/kiSshzsOyhLl3a700he7PXB2NcgulA+Uxb5HGsu3Lqe5WaaLuUZU3eVCbA8Snr6/HuF9TppgCexSNiH4yQFQ2KeDhD97BfQNvMVoR7DgqaE6EZnLeaJ/kbXOYzmbcIbbw8wnf9RGhXN5pidrAC3D4b8v91wkq1JSxAxeADrmIOONWUMEvFnRQLZN0EpWabE+oZywXgeip++SA5HfVYw92gwVC963iAOuBcG7EyaI7/KdXG6DizbAdIK+m1QE6YegmhAB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVsnbhCpcfcHW0ZOJD0Fq/tgffbEYARsVvKs7Oo/PRA=;
 b=lEc668IxTq2jQc3QiNLvrJxNwkZPfSo8PW78zPBXp+VLjydxXjm+w9zV2NboRD25Z/srnV4JQC/iUmGnrS31hTHMJiuG7mo2iWuRIODukdRyoEHz6lRRTw4nMnd8UKX2VAe/qq3ajSqJM3VuJR0WbWsfkF40PsSUzdg5iT2siQprHEZE/tuYaOTLVKAuUE5au6LzcBqOCdsDcweBUdGUrn1zQqu87JgrO35qcSHGioR+He7nmGhW+YGU7cZEmufrI235JikIQEqA9f1yTo9DzONDRgpgB44Oso4d503AszkwFdwCU+bc2BREVmj9KXYHUxDdU+rdIpPpVbYIfourcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVsnbhCpcfcHW0ZOJD0Fq/tgffbEYARsVvKs7Oo/PRA=;
 b=Uv5oeaZSU6haR5Cu5OEW44Ps3GKSxxV1ikmOAFX6u4y6SFvR0jF/11Ew1csvm5h4Y3bjYl4g4aUKb6dxNxJs+mQ6T0Zu5biz7SUSPRF1e2e+HUdKzeAAIrSRMXVpwLnnj58tS032PW1TNgnKigHn5CaJCm+AOPPqSzuX9LVjYWk=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.38; Wed, 5 Jun
 2024 07:05:39 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:05:39 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 01/12] drm/amd/pm: remove dead code in
 si_convert_power_level_to_smc
Thread-Topic: [PATCH 01/12] drm/amd/pm: remove dead code in
 si_convert_power_level_to_smc
Thread-Index: AQHatZJ+AnYTqcy23kaZwKK1VcEAobG4wS5w
Date: Wed, 5 Jun 2024 07:05:39 +0000
Message-ID: <CH3PR12MB807434B56638BA1E91ACEF31F6F92@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240603084603.2569757-1-jesse.zhang@amd.com>
In-Reply-To: <20240603084603.2569757-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=cf519064-a233-42f6-a0bb-c1249b7885e2;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-05T07:01:33Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB7104:EE_
x-ms-office365-filtering-correlation-id: 6855a66b-3277-48ad-8273-08dc852de827
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?YeQsADZidKBQp4vf+UwX6kSx4qrLTFfaBU09ds+cz9P02E0ZQNao+/nntPjl?=
 =?us-ascii?Q?HZCiyhiHHEJn30PK5C95XmGLpHQWWH+zjE4dUeN05Q03uYkzrX4XmwunpkHI?=
 =?us-ascii?Q?DSwDgN+ax955+il198nwmJeahyLyh/OMemVgVLI1qJjhd/AJtwuexf4Jx2nV?=
 =?us-ascii?Q?0hLtom2EzBbES4VSs2+sMcDVu1rgZBiNXtN2n5avY3fmdNU++Va7umWqoB3V?=
 =?us-ascii?Q?AIHI6wmatui8aLOU+8VLEHCrwhvi56D8pcvn4BKFNEdJ0esdUyb7+oeoRoKM?=
 =?us-ascii?Q?Guq1rF773h4WNewTdkkPt/NaC4OTtA74r3Zv2531tyvEcuMDsSrCvVAUQjVe?=
 =?us-ascii?Q?iDtE6I5W1sX3bzJqCupygyJFGWj42vVC43VExEhtTPJTuEkMNUkbe4vVoAh0?=
 =?us-ascii?Q?qymuIV7mwasu4qb+5msGE6sNUrvzH3XhsfgcAGLObUcy30QTmIsHptX5iZxv?=
 =?us-ascii?Q?KiQRSAVZlAke4qT9GK5HRxeuNCtSdDWT9vY4BwzCZQuRpravzojNcVvYM7Ho?=
 =?us-ascii?Q?x+5bvn5FD4Nu8B3qe1+1mgun6V/lbANwJXANuPepMMAC1E0mUGNqPd/fViF1?=
 =?us-ascii?Q?4cQXGyxLdCT2HDE9F+uEiHEft49KMIA3cZTyLmntbtALfMlTL8ShUCLPoQnn?=
 =?us-ascii?Q?u07039WR4j1xIfnTgNlZ/WPRJ249OTEvM4Fisycfe5PV7/EdDHpNlttiZmuV?=
 =?us-ascii?Q?a+nDhwSiX9sWcMS4/ixRFUdu9KsqtkdlcpyzBle1YNMNTIcYg2LYrGDrYtO4?=
 =?us-ascii?Q?yQ7kv93xuOdKTvBTFzuUVCa9mnB4cyeHpfFTRsYV19JnYGy/sH2SqwqpEo03?=
 =?us-ascii?Q?wnmuK7ZAizG6f3ABYZc9E05S7L3sd4Ub9RXu4MvzbuITG7vQDqPFVtoO7ols?=
 =?us-ascii?Q?gozNkNfJiIUIjUKaXKeGlLQ8B0wyvKSmugM6wqo7iUsNXZ+KIMqgcnCD3fNT?=
 =?us-ascii?Q?yMqxWb1/kHK2XSu0OThtKvmal1i5uG9pdwA5H/Iax3qUHUmXjK/sUEXMpUJ3?=
 =?us-ascii?Q?CeWVelvuaDWps5Bq7elPg5E/IDJI12vid9sXeb44BVjtRQ0aPgIRpOlu53jn?=
 =?us-ascii?Q?a/p3/SajJULRw/ol5esbEQFVgB0ZmefR2MAPpYFuPIhm0MuUBVRWNkjEphgw?=
 =?us-ascii?Q?YE6kd6aCmRjNRg/U87rQ6St6DXAZbLOFM+SDVk75+OoLgqHeDSX/zIhYJh2Z?=
 =?us-ascii?Q?x0mmHB3uZFI9ig58m9DBmSinazl2LI5oWKi32KVNluxViGzNZaJeK0BpEehP?=
 =?us-ascii?Q?/A6nI0W8tDtbTFaPhBM8kZGOGkZK6O+g/6gsWpvykBX37CgvVACoVDQwWEFS?=
 =?us-ascii?Q?g8r4VT0yXY+d/OusTF9vVHHYay3/gESdgd3hPspp7ZVt7+fSFI6GPnjZQOb7?=
 =?us-ascii?Q?b/vhjGw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qRcUquqcPXKbJGojGnXE1qEc01sPbFgLRhKq/LileLi7FeJNj06pWoJVUgoW?=
 =?us-ascii?Q?Kv1k4YNRhlRpWZmw5uUfAmu2wnaQMOi9j7i3Eyucd7VfFMH+hHapnzsvihj6?=
 =?us-ascii?Q?H0Xwo24Pft6NFVtrK4+js9FQXtDkZhOoazQQ6IAYr9xETARz77x6w1gQaOuC?=
 =?us-ascii?Q?UMiv7h3OFdDdTiwmQQC7LnYXx6FpV2swLZT2fj6bmHPjMU/zmLeDZaQER6Nm?=
 =?us-ascii?Q?T3cKXxAQld8Ls28LdClNEBTLshpJeu8+Ypibe25ZqWXxwI6C82IFRd3V7dSq?=
 =?us-ascii?Q?8aoHaxQOHI80MKz80NbZ4F8PbXAmCYv9XLywdk1P31zdy4NF4dIK67VqLVuF?=
 =?us-ascii?Q?YRQnFxbo/84myVrWWP/OTM3/EBCpfjqMXYTwQNbHi3Ty7TnQZlHGJzzEENSo?=
 =?us-ascii?Q?XGsCG27p82V1PvO67FXZR66/ZLbTZt5wwYZt7D1ov9pk/C0tICO68zacjrtZ?=
 =?us-ascii?Q?nTc/nH+sBPs7Rt/HLjBAk936NEYkbfGMcSZ3d/BTWrkky7PKj8kS5pNs91+M?=
 =?us-ascii?Q?k07TvCYgtMLas7NjOK4HlP90G9SsYqq0ZOimPL/Nmxt0un1xKr83o7lqK/i5?=
 =?us-ascii?Q?z4TP3PigqKi0wxq8iMqgAHuBW0mussnRC3aiQ15r5myd7YuwxvkfQTNPIIIi?=
 =?us-ascii?Q?TFTKV6F3xb0sf83AF9dnzo9L5ZweQ+7FjP4JfqrOLsORt77MAnh6E8m/5GUt?=
 =?us-ascii?Q?6dXfop2Tgc1RGFs6VvYyoEljvgkieYPMhoKKdtXFEUzUt/7wMhMFOzGSijjk?=
 =?us-ascii?Q?F4ac/VwNiifW9ttiXNY44/tFTKddGS0ex0amsAoWd65XQ5NKChF1my0WaKx0?=
 =?us-ascii?Q?08zs6u757SX6BDBVtlMtRKJPllOCW71D76TUYig65Z584wudS4yMk13ZqBCQ?=
 =?us-ascii?Q?wFYXKUDzvvLPqB1sltVQIOaGOjvgV3QQVCT5vvguiBMne0jlkgOGmQPk8OxU?=
 =?us-ascii?Q?Ekct5fZ5FKjXGoGjO3tnJAZWT/K7K6az4drib30yoUxW/v60Kvips9L0DXxG?=
 =?us-ascii?Q?PgcYmzT5+BAsGMLe9S5JgMmr/rOgNCfMIXX3Q7QOLjRQF8EtLqUEdqVqMeiy?=
 =?us-ascii?Q?MiPxXUeelH5Aa02H4Xb+rgGcYnD/8uuLK4VW0lsOoHH8npUlDE/3txzR4rWY?=
 =?us-ascii?Q?tAuRveXHe/M0VTJ2+O2QWWNePSBHbeoTv3q0onm241Yyagnzl5Q8A7l/uOSV?=
 =?us-ascii?Q?YRRysoheXmVPE6VfUKEWUwLBNPYwP+uYuuaNOpdbJdA1leOYEKbUMtBeOhm/?=
 =?us-ascii?Q?IKYpydq/X1IxpBgmFvUjnBQP8TbUqSH69qj77X+a6OTVa9fQ8skBSwgKRiiL?=
 =?us-ascii?Q?nh7Jb8gPg3xEs9sIjTmM1LSOkZbqHaE/u2puHa/Z3/M8o92mlWK22vt5oZsT?=
 =?us-ascii?Q?4GtlqfPwkZjGZOph0rh2SKDT2yCh4FtmFXKmcsjgYRA9iQtpsVF5fmm8wP/L?=
 =?us-ascii?Q?OCXAowYlcVeee2bxPEywwo3UBIJEV4QjEWvzAZFRMz93VdqK/AsSpY+mbpHS?=
 =?us-ascii?Q?Z0s+NsN9v4OPAFpFMuQ13x6CxpxCb6bn56VhAPZ1beCf6+tX+IoX0wco02gl?=
 =?us-ascii?Q?W9PXQKsw/kHQMun2eAY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6855a66b-3277-48ad-8273-08dc852de827
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 07:05:39.4237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkCudIric2wDAPL6I2goedLKlFJTLZvZcrQwrGK7Z4wG01NsmyLH/ipyh+E47dViBGpEd9st5vhehKlot1BoOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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

Hi Jesse,

> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Monday, June 3, 2024 4:46 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 01/12] drm/amd/pm: remove dead code in
> si_convert_power_level_to_smc
>
> Since gmc_pg is false, setting mcFlags with SISLANDS_SMC_MC_PG_EN
> cannot be reach.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index 68ac01a8bc3a..a18f75a6d480 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -5487,9 +5487,6 @@ static int si_convert_power_level_to_smc(struct
> amdgpu_device *adev,
>           (RREG32(DPG_PIPE_STUTTER_CONTROL) & STUTTER_ENABLE) &&
>           (adev->pm.dpm.new_active_crtc_count <=3D 2)) {
>               level->mcFlags |=3D SISLANDS_SMC_MC_STUTTER_EN;
> -
> -             if (gmc_pg)
> -                     level->mcFlags |=3D SISLANDS_SMC_MC_PG_EN;

If remove this, the pmc_pg should never be used, maybe remove the definitio=
n of "bool gmc_pg =3D false" as well?

Tim Huang

>       }
>
>       if (adev->gmc.vram_type =3D=3D AMDGPU_VRAM_TYPE_GDDR5) {
> --
> 2.25.1

