Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B1EC021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 16:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9B210E644;
	Tue,  4 Mar 2025 16:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oN0jLyqO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2347110E644
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 16:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeXFOP7y49M14QEXufO0//OAbEJQMrQVNC62wG8IoGoxQs/pIJ4ApLFNaS1A1IQK5eBbSQdSQBetba3+UR23Wp7k683ACkPynE4mAWLsxWnvmTD7BneDZcGZxUcWH+7jCOhotxpnwx1Ulp10W9ta7Ml/Cp7URDR+8Cd8z4HeSp1zoP1zHoQbmkEC+9/l3A2m68UdlExMP3g2ks/hhsPNVkBZLXdcts6z+jAMSYTiIv1JN/KqXxLzmp1NzzgC8OxcDdml/PbxM3J2FKqJzllP8MSG2seP3i4hp6ObO2N/q486m+jfiJ2V4zebm7NQc89CM3+p7eeiVLP8WiOQXMQ9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBPVBexjMvaLMU55tjJ/P//w0SN8elyHSU6WV05zQok=;
 b=Y/pdFARkdZ/cyo15SVztZeG9L4gWEX8VV696Tafn371rqmJxkw1NHsgFdRsMxIA1ENAZMLI7FOJjN1Al2jJGf2isp3cFGg7rSb32XnLaLcczjjmS/Qta/6nqIqBIZ/hNOcCzRD30CM7eCHoJbj/4GZqDWkMYKN4LIcgl/NA4tvBzh4ow5NS0KT2BjL+jfE7XM7CsjmO/WBai+wAS5RcSCyMVr9H8onDyOuS0vH+DxDg3L2trk/2H3kSFI1zLJa0h4Z8ol9PiM5UwW5QaFE9ZTavqfJ5yLO2oMxgXoV09UkBhG6QdXQEcZ7UM3iymoHCugZxv/TA47w85TuQgKWIFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBPVBexjMvaLMU55tjJ/P//w0SN8elyHSU6WV05zQok=;
 b=oN0jLyqOA/5sm934XaADws6pZAHVNOUUnf7DXwXuXWzo/EnneO4jpnMcei2MCQ0aGZhn2QofQzHgMLut55sIsMEaeYvIYaOxxY5tDQR2yby8eLMqaxA2GzAMinJzFYcKJdcGW7+cey4ElV/CKYk3hlt1BlVjyUdG3RpXEHecsoM=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:05:56 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:05:56 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Yi, Tony" <Tony.Yi@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
Thread-Index: AQHbiSozldRsgnAsikSMR5ARvAsQ47NjK8fg
Date: Tue, 4 Mar 2025 16:05:56 +0000
Message-ID: <BL1PR12MB5317B2401DB21C5C562F4257F1C82@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20250227151217.2620348-1-Tony.Yi@amd.com>
 <20250227151217.2620348-2-Tony.Yi@amd.com>
In-Reply-To: <20250227151217.2620348-2-Tony.Yi@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5d268933-03cb-4f68-86a9-05beba3918ae;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-04T16:04:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|SA3PR12MB7923:EE_
x-ms-office365-filtering-correlation-id: cf7e9055-8f7a-42e6-e1bc-08dd5b367298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sQSnpinD0A+XhPtJt4/rDVmTK7SB5J38dNw5+WuhZHc2fQ0tzzRy+iMqqZhX?=
 =?us-ascii?Q?np2FcE73GZBYB4+faHnGMyxZARPfhzuzjtUzWAjyw+Sw843a+NNXGlLNXADM?=
 =?us-ascii?Q?Bg2tbS8TRs/IFYw1SzFKaPZvLgp0nlONa74mOg68oiAlNblpbIDrtkGgQjSi?=
 =?us-ascii?Q?8T+4cCI+DD6o7oUfffVFGpv9B6bwcWoHW+1zfAlUd/XqOyGY9gqBGOmGsrbe?=
 =?us-ascii?Q?iOoLpQHFW9JH10l6S8R7drJk+yIucO2XMh3aEtSBNxa6PhNQqejKoygVCrCc?=
 =?us-ascii?Q?XXCEoC4v+TyDu1PrwC93eZnU1SVWDKS9pGjD2N3cwSFeqTT4GzPq3v0gQ6vn?=
 =?us-ascii?Q?1DokI9/ZkHP1+82laV+V/T2S4epWvZtWzs6O037hcpXypS0qU3SProiBX2mg?=
 =?us-ascii?Q?mxBKtxJXspuCUXvJW54o792aa0AHk++VbhZoNFdc4YUXCmOHPMq3SyVkKIwh?=
 =?us-ascii?Q?kiLwXHatidc8ATxtNNMfPSnC6jZ5UxLpZNaL45ZWTvbOVbHpHkegGC0PGpqS?=
 =?us-ascii?Q?/+hq03t1dKwTtqqtLlO5iwuGEzVitvsozk/ENG6LrvUtOBE5jiXOL/+hcqmZ?=
 =?us-ascii?Q?w4dUj0F9kG6/tyRRTEAFOp90wkkXEK5ezAWoamX+Ofm2L29pNAcxs03VnVlH?=
 =?us-ascii?Q?pd7DmOpQONsf54yQSpUoxGfc+ylo4T3mOTQrsG310g1ISCqBN1NMpDDIOiLx?=
 =?us-ascii?Q?Iyz5PxCfvuZkj28sBJPzZ2+x+w7XE0a6Ns3/Z+QggT88yjB5aEHfYlGS4Ofc?=
 =?us-ascii?Q?CD2QAni86E7GV8xswvD968YeZSJqIw57CrOlCjZ71m6v9WtwrEUnQ3QC18Ki?=
 =?us-ascii?Q?Aj1fJsPeFW0sOf/GjYZiubNf5Qzmbz5EosmEGhMEUgjwfHLkA/4WGtBWTyzj?=
 =?us-ascii?Q?rHBK4+U+gTZs1sIslB2sMjTK+Ag3D6knKp0JF46NHGD/wdXUSbqd4hqbfjXs?=
 =?us-ascii?Q?fgaGOXr1SEG1ARoeTe0yhNIRsdiT4FIpzbDJBrNbJReeX6ltaUxquXTIPUOV?=
 =?us-ascii?Q?e6CzkWQzQH3HK61bLJ5NftS8Ree3oz6gGanPkvwjrBP2THj9NxE/uw4DMIEG?=
 =?us-ascii?Q?3l+op6onrtLDy5EmzrjqPRq6BMjrRG/W/y9d5XrBpSImK59jsU2p0YMKJoqU?=
 =?us-ascii?Q?WqqIRb3EB6jS4DN3XLNkDU3DzQuU6qbSwCk8badr+averZS95Us9s/MDJ78R?=
 =?us-ascii?Q?KYLMHHbWffLyQyKE8yyPlDZePrcf01ixjuUC9l7oheqFOXiGPKLdYi0UvNe4?=
 =?us-ascii?Q?EBLUvz1i7bSQzX09yxXX0eGwbni6tmhR4PdKQOzwCrkCUHhYJCmTX6R33FlA?=
 =?us-ascii?Q?WYgPAuYvnf5iTpx+gW1JtNzF27r4uYfjRZyaS3/GhK/iv2+3kZy9wH7RAhcZ?=
 =?us-ascii?Q?xUdv7Wbe1ImnakMwZUQJTfAyfzRuBaz1t2OqKpnW3OYxxh4PIzNAhMMKOV6M?=
 =?us-ascii?Q?SJJRat7+ZlrAF2+b+z7N9URcJwaTSyin?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ozUQMvxpQywd/oKMtjlsl1MQFLcWsp+Qxq9db2s4OwzwFPmA8lDzXEfVadbr?=
 =?us-ascii?Q?Cg2T7sF5FktIzBlCRcv2VQSbTKHeGi58xZPYvDr67PjEevfw++JKbaveLPPc?=
 =?us-ascii?Q?YgzovReusymD8EPlzzMV5h8ujvvI5ar7zebfKlnBuSiQ20jQs+PR5rq8HPVv?=
 =?us-ascii?Q?Eqs0XLfo8Q7UKQWEDLqYGJluQYJa9ykfsFfGSHKYXhsIA0KsEzQwr3fiN02W?=
 =?us-ascii?Q?dQ30h7CZNbDv7DhWxk1Rzx6BGYkZ1pdd8SPrJ7ZA1V+p/NhwlCODO/UtvYb6?=
 =?us-ascii?Q?N7VyGsfzfL2/Z+VAAR5RFF97KOglEblWZ9i5NNSP6WfeMvdavu0yBlWaXlqJ?=
 =?us-ascii?Q?SBFmBPUsToLgV+BOhPoh4gnJgqOM5fUYfimi1RmvpOupebfX6cubsG7CH8Ju?=
 =?us-ascii?Q?yJLSPUATs7SnqboqFDw0URfHP8Cm6QCrmbcCCf0ssQxvKkhf6wk5HJ8CFLDO?=
 =?us-ascii?Q?WzZ/XfBy98xAwKpX6Ad8848zw9JO2HA3cbuWKjOTyvecx/FCJyO2QUm0xDM2?=
 =?us-ascii?Q?vIVPWvq3bxCS9dxBGJCxwCuBhWVYvHOASm0dbsybgqaSZ5jopjShrQ42JdSm?=
 =?us-ascii?Q?a8jReML+IDVP2wNqv7ytg6qmnG+ZepTP8O1HQW8KikCbrcOyFOXi+i/pXx23?=
 =?us-ascii?Q?1Pf6Fx2/u6HuwmAgngh3AmdTrEstWAjrCxs7qFTuO0KfG22KbBnl0twleCVA?=
 =?us-ascii?Q?PYOrtSLx3Low83ybmp5p+ZEOvLc2aRHNgWxScal97unQuBVmBvHVij0wYJ8g?=
 =?us-ascii?Q?DrleVan60t3SoHxkbDg3QOAsjmT7VyGE+7vty68hWRoYq2gjILOZEJIKHsxh?=
 =?us-ascii?Q?DYHXeS6qgYi5yzHnFqX/XHydnO/6p8MsTr0zuQ0vG+aCHiE2flKg68OKSeyG?=
 =?us-ascii?Q?w5jw1tEvG0Qv6jFQKmJaqKtsHEsuOSyLfyvVdKdc70n9SfLFprDxf/0ZAbn0?=
 =?us-ascii?Q?XpuEsyS8zgHwzGZEC8WMauep1yNVY4SFeEWy8aIog/BT/V8gDnJgt438ED+4?=
 =?us-ascii?Q?/7Z/OlMRpEPFE3wfL0Nk/9YdSHsn/GYzupOTcXTNn3R0ohVW2ycqnjtbkrBC?=
 =?us-ascii?Q?TzvqB14hIxr9QRskJpJ4VsgdLQzkrLbh8+fDCYaDabJypYy2xAPltsXfKsO0?=
 =?us-ascii?Q?+vBAd/dj7y5w1vRCy4PjIEcei+PKb6z3mRuKncqNUo7dke+S9BRGbFlaFWNk?=
 =?us-ascii?Q?dmX4oeWQ/9+6qYVUFKekL7T9Q7sboC8OX3ssTYVApzZXV0TGOrTNop13aUem?=
 =?us-ascii?Q?+T5Gf5mikVimMro7mDS5zyKiEbT1ywHq9ujHurzZOR7kZULHTvEHl3kb70XX?=
 =?us-ascii?Q?BWySxip6RnWs9QXgexMb60QqezUD828BGfLSitUOhY8QuwITlAztSzbPPDPP?=
 =?us-ascii?Q?cnF9hUzKrTbBDmPVP9fV2x6Ea5n34I5IOXQZRUOqBSa//81oWnGkH+ZWyL3Q?=
 =?us-ascii?Q?b1YkLd60JDJIv3OqAg4ee7f/e1Pw2sX4gk9GvyYNcZ3Zy9Xf7HBgmQbI0oYx?=
 =?us-ascii?Q?0gVQwJ/fe0q4Bwc5uSQXHukwq7Hl3a5w4nip0RPIOgNjkr//Ed75F/anIBJT?=
 =?us-ascii?Q?iDBOLBp+eCWs3jpmw/k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7e9055-8f7a-42e6-e1bc-08dd5b367298
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 16:05:56.4845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g53fIZqe3aM49S10KEhRI2Jn86YbJFCzWd/F41b3ZqDZ7TC/PzEPdMG4yekbQAU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
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

[AMD Official Use Only - AMD Internal Distribution Only]

The series is:

Reviewed-by: Zhigang Luo <Zhigang.Luo@amd.com>

> -----Original Message-----
> From: Yi, Tony <Tony.Yi@amd.com>
> Sent: Thursday, February 27, 2025 10:12 AM
> To: Yi, Tony <Tony.Yi@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.c=
om>;
> amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Lu=
o,
> Zhigang <Zhigang.Luo@amd.com>
> Cc: Yi, Tony <Tony.Yi@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Add support for CPERs on virtualization
>
> Add support for CPERs on VFs.
>
> VFs do not receive PMFW messages directly; as such, they need to query th=
em
> from the host. To avoid hitting host event guard, CPER queries need to be=
 rate
> limited. CPER queries share the same RAS telemetry buffer as error count =
query, so
> a mutex protecting the shared buffer was added as well.
>
> For readability, the amdgpu_detect_virtualization was refactored into mul=
tiple
> individual functions.
>
> Signed-off-by: Tony Yi <Tony.Yi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  31 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 138 ++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  18 ++-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  14 +++
>  5 files changed, 195 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5e1d8f0039d0..198d29faa754 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3099,7 +3099,8 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce
> *adev)
>
>       amdgpu_fru_get_product_info(adev);
>
> -     r =3D amdgpu_cper_init(adev);
> +     if (!amdgpu_sriov_vf(adev) || amdgpu_sriov_ras_cper_en(adev))
> +             r =3D amdgpu_cper_init(adev);
>
>  init_failed:
>
> @@ -4335,10 +4336,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>        * for throttling interrupt) =3D 60 seconds.
>        */
>       ratelimit_state_init(&adev->throttling_logging_rs, (60 - 1) * HZ, 1=
);
> -     ratelimit_state_init(&adev->virt.ras_telemetry_rs, 5 * HZ, 1);
>
>       ratelimit_set_flags(&adev->throttling_logging_rs,
> RATELIMIT_MSG_ON_RELEASE);
> -     ratelimit_set_flags(&adev->virt.ras_telemetry_rs,
> RATELIMIT_MSG_ON_RELEASE);
>
>       /* Registers mapping */
>       /* TODO: block userspace mapping of io register */ @@ -4370,7 +4369=
,7
> @@ int amdgpu_device_init(struct amdgpu_device *adev,
>               return -ENOMEM;
>
>       /* detect hw virtualization here */
> -     amdgpu_detect_virtualization(adev);
> +     amdgpu_virt_init(adev);
>
>       amdgpu_device_get_pcie_info(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 81a7d4faac9c..d55c8b7fdb59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -578,12 +578,32 @@ static ssize_t amdgpu_debugfs_ring_read(struct file=
 *f,
> char __user *buf,
>       return result;
>  }
>
> +static ssize_t amdgpu_debugfs_virt_ring_read(struct file *f, char __user=
 *buf,
> +     size_t size, loff_t *pos)
> +{
> +     struct amdgpu_ring *ring =3D file_inode(f)->i_private;
> +
> +     if (*pos & 3 || size & 3)
> +             return -EINVAL;
> +
> +     if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_CPER)
> +             amdgpu_virt_req_ras_cper_dump(ring->adev, false);
> +
> +     return amdgpu_debugfs_ring_read(f, buf, size, pos); }
> +
>  static const struct file_operations amdgpu_debugfs_ring_fops =3D {
>       .owner =3D THIS_MODULE,
>       .read =3D amdgpu_debugfs_ring_read,
>       .llseek =3D default_llseek
>  };
>
> +static const struct file_operations amdgpu_debugfs_virt_ring_fops =3D {
> +     .owner =3D THIS_MODULE,
> +     .read =3D amdgpu_debugfs_virt_ring_read,
> +     .llseek =3D default_llseek
> +};
> +
>  static ssize_t amdgpu_debugfs_mqd_read(struct file *f, char __user *buf,
>                                      size_t size, loff_t *pos)
>  {
> @@ -671,9 +691,14 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device
> *adev,
>       char name[32];
>
>       sprintf(name, "amdgpu_ring_%s", ring->name);
> -     debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
> -                              &amdgpu_debugfs_ring_fops,
> -                              ring->ring_size + 12);
> +     if (amdgpu_sriov_vf(adev))
> +             debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
> +                                      &amdgpu_debugfs_virt_ring_fops,
> +                                      ring->ring_size + 12);
> +     else
> +             debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
> +                                      &amdgpu_debugfs_ring_fops,
> +                                      ring->ring_size + 12);
>
>       if (ring->mqd_obj) {
>               sprintf(name, "amdgpu_mqd_%s", ring->name); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index e6f0152e5b08..3832513ec7bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -739,7 +739,7 @@ void amdgpu_virt_exchange_data(struct amdgpu_device
> *adev)
>       }
>  }
>
> -void amdgpu_detect_virtualization(struct amdgpu_device *adev)
> +static u32 amdgpu_virt_init_detect_asic(struct amdgpu_device *adev)
>  {
>       uint32_t reg;
>
> @@ -775,8 +775,17 @@ void amdgpu_detect_virtualization(struct amdgpu_devi=
ce
> *adev)
>                       adev->virt.caps |=3D AMDGPU_PASSTHROUGH_MODE;
>       }
>
> +     return reg;
> +}
> +
> +static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32
> +reg) {
> +     bool is_sriov =3D false;
> +
>       /* we have the ability to check now */
>       if (amdgpu_sriov_vf(adev)) {
> +             is_sriov =3D true;
> +
>               switch (adev->asic_type) {
>               case CHIP_TONGA:
>               case CHIP_FIJI:
> @@ -805,10 +814,39 @@ void amdgpu_detect_virtualization(struct amdgpu_dev=
ice
> *adev)
>                       amdgpu_virt_request_init_data(adev);
>                       break;
>               default: /* other chip doesn't support SRIOV */
> +                     is_sriov =3D false;
>                       DRM_ERROR("Unknown asic type: %d!\n", adev-
> >asic_type);
>                       break;
>               }
>       }
> +
> +     return is_sriov;
> +}
> +
> +static void amdgpu_virt_init_ras(struct amdgpu_device *adev) {
> +     ratelimit_state_init(&adev->virt.ras.ras_error_cnt_rs, 5 * HZ, 1);
> +     ratelimit_state_init(&adev->virt.ras.ras_cper_dump_rs, 5 * HZ, 1);
> +
> +     ratelimit_set_flags(&adev->virt.ras.ras_error_cnt_rs,
> +                         RATELIMIT_MSG_ON_RELEASE);
> +     ratelimit_set_flags(&adev->virt.ras.ras_cper_dump_rs,
> +                         RATELIMIT_MSG_ON_RELEASE);
> +
> +     mutex_init(&adev->virt.ras.ras_telemetry_mutex);
> +
> +     adev->virt.ras.cper_rptr =3D 0;
> +}
> +
> +void amdgpu_virt_init(struct amdgpu_device *adev) {
> +     bool is_sriov =3D false;
> +     uint32_t reg =3D amdgpu_virt_init_detect_asic(adev);
> +
> +     is_sriov =3D amdgpu_virt_init_req_data(adev, reg);
> +
> +     if (is_sriov)
> +             amdgpu_virt_init_ras(adev);
>  }
>
>  static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *ade=
v)
> @@ -1288,10 +1326,12 @@ static int
> amdgpu_virt_req_ras_err_count_internal(struct amdgpu_device *adev, bo
>        * will ignore incoming guest messages. Ratelimit the guest message=
s to
>        * prevent guest self DOS.
>        */
> -     if (__ratelimit(&adev->virt.ras_telemetry_rs) || force_update) {
> +     if (__ratelimit(&virt->ras.ras_error_cnt_rs) || force_update) {
> +             mutex_lock(&virt->ras.ras_telemetry_mutex);
>               if (!virt->ops->req_ras_err_count(adev))
>                       amdgpu_virt_cache_host_error_counts(adev,
> -                             adev->virt.fw_reserve.ras_telemetry);
> +                             virt->fw_reserve.ras_telemetry);
> +             mutex_unlock(&virt->ras.ras_telemetry_mutex);
>       }
>
>       return 0;
> @@ -1322,6 +1362,98 @@ int amdgpu_virt_req_ras_err_count(struct
> amdgpu_device *adev, enum amdgpu_ras_bl
>       return 0;
>  }
>
> +static int
> +amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
> +                             struct amdsriov_ras_telemetry *host_telemet=
ry,
> +                             u32 *more)
> +{
> +     struct amd_sriov_ras_cper_dump *cper_dump =3D NULL;
> +     struct cper_hdr *entry =3D NULL;
> +     struct amdgpu_ring *ring =3D &adev->cper.ring_buf;
> +     uint32_t checksum, used_size, i, j;
> +     int ret =3D 0;
> +
> +     checksum =3D host_telemetry->header.checksum;
> +     used_size =3D host_telemetry->header.used_size;
> +
> +     if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +             return 0;
> +
> +     cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size,
> GFP_KERNEL);
> +     if (!cper_dump)
> +             return -ENOMEM;
> +
> +     if (checksum !=3D amd_sriov_msg_checksum(cper_dump, used_size, 0, 0=
))
> +             goto out;
> +
> +     *more =3D cper_dump->more;
> +
> +     if (cper_dump->wptr < adev->virt.ras.cper_rptr) {
> +             dev_warn(
> +                     adev->dev,
> +                     "guest specified rptr that was too high! guest rptr=
: 0x%llx, host
> rptr: 0x%llx\n",
> +                     adev->virt.ras.cper_rptr, cper_dump->wptr);
> +
> +             adev->virt.ras.cper_rptr =3D cper_dump->wptr;
> +             goto out;
> +     }
> +
> +     entry =3D (struct cper_hdr *)&cper_dump->buf[0];
> +
> +     for (i =3D 0; i < cper_dump->count; i++) {
> +             amdgpu_cper_ring_write(ring, entry, entry->record_length);
> +             entry =3D (struct cper_hdr *)((char *)entry +
> +                                         entry->record_length);
> +     }
> +
> +     if (cper_dump->overflow_count)
> +             dev_warn(adev->dev,
> +                      "host reported CPER overflow of 0x%llx entries!\n"=
,
> +                      cper_dump->overflow_count);
> +
> +     adev->virt.ras.cper_rptr =3D cper_dump->wptr;
> +out:
> +     kfree(cper_dump);
> +
> +     return ret;
> +}
> +
> +static int amdgpu_virt_req_ras_cper_dump_internal(struct amdgpu_device
> +*adev) {
> +     struct amdgpu_virt *virt =3D &adev->virt;
> +     int ret =3D 0;
> +     uint32_t more =3D 0;
> +
> +     if (!amdgpu_sriov_ras_cper_en(adev))
> +             return -EOPNOTSUPP;
> +
> +     do {
> +             if (!virt->ops->req_ras_cper_dump(adev, virt->ras.cper_rptr=
))
> +                     ret =3D amdgpu_virt_write_cpers_to_ring(
> +                             adev, virt->fw_reserve.ras_telemetry, &more=
);
> +             else
> +                     ret =3D 0;
> +     } while (more);
> +
> +     return ret;
> +}
> +
> +int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool
> +force_update) {
> +     struct amdgpu_virt *virt =3D &adev->virt;
> +     int ret =3D 0;
> +
> +     if ((__ratelimit(&virt->ras.ras_cper_dump_rs) || force_update) &&
> +         down_read_trylock(&adev->reset_domain->sem)) {
> +             mutex_lock(&virt->ras.ras_telemetry_mutex);
> +             ret =3D amdgpu_virt_req_ras_cper_dump_internal(adev);
> +             mutex_unlock(&virt->ras.ras_telemetry_mutex);
> +             up_read(&adev->reset_domain->sem);
> +     }
> +
> +     return ret;
> +}
> +
>  int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev)  {
>       unsigned long ue_count, ce_count;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 0f3ccae5c1ab..9f65487e60f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -96,6 +96,7 @@ struct amdgpu_virt_ops {
>                                       enum amdgpu_ras_block block);
>       bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
>       int (*req_ras_err_count)(struct amdgpu_device *adev);
> +     int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 vf_rptr);
>  };
>
>  /*
> @@ -140,6 +141,7 @@ enum AMDGIM_FEATURE_FLAG {
>       AMDGIM_FEATURE_MES_INFO_ENABLE =3D (1 << 8),
>       AMDGIM_FEATURE_RAS_CAPS =3D (1 << 9),
>       AMDGIM_FEATURE_RAS_TELEMETRY =3D (1 << 10),
> +     AMDGIM_FEATURE_RAS_CPER =3D (1 << 11),
>  };
>
>  enum AMDGIM_REG_ACCESS_FLAG {
> @@ -242,6 +244,13 @@ struct amdgpu_virt_ras_err_handler_data {
>       int last_reserved;
>  };
>
> +struct amdgpu_virt_ras {
> +     struct ratelimit_state ras_error_cnt_rs;
> +     struct ratelimit_state ras_cper_dump_rs;
> +     struct mutex ras_telemetry_mutex;
> +     uint64_t cper_rptr;
> +};
> +
>  /* GPU virtualization */
>  struct amdgpu_virt {
>       uint32_t                        caps;
> @@ -284,8 +293,7 @@ struct amdgpu_virt {
>
>       union amd_sriov_ras_caps ras_en_caps;
>       union amd_sriov_ras_caps ras_telemetry_en_caps;
> -
> -     struct ratelimit_state ras_telemetry_rs;
> +     struct amdgpu_virt_ras ras;
>       struct amd_sriov_ras_telemetry_error_count count_cache;  };
>
> @@ -340,6 +348,9 @@ struct amdgpu_video_codec_info;  #define
> amdgpu_sriov_ras_telemetry_block_en(adev, sriov_blk) \
>  (amdgpu_sriov_ras_telemetry_en((adev)) && (adev)->virt.ras_telemetry_en_=
caps.all
> & BIT(sriov_blk))
>
> +#define amdgpu_sriov_ras_cper_en(adev) \ ((adev)->virt.gim_feature &
> +AMDGIM_FEATURE_RAS_CPER)
> +
>  static inline bool is_virtual_machine(void)  {  #if defined(CONFIG_X86) =
@@ -378,7
> +389,7 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_dev=
ice
> *adev);  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);=
  void
> amdgpu_virt_exchange_data(struct amdgpu_device *adev);  void
> amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev); -void
> amdgpu_detect_virtualization(struct amdgpu_device *adev);
> +void amdgpu_virt_init(struct amdgpu_device *adev);
>
>  bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);  int
> amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev); @@ -406,6
> +417,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 off=
set,
> u32 v, u32 f  bool amdgpu_virt_get_ras_capability(struct amdgpu_device *a=
dev);  int
> amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum
> amdgpu_ras_block block,
>                                 struct ras_err_data *err_data);
> +int amdgpu_virt_req_ras_cper_dump(struct amdgpu_device *adev, bool
> +force_update);
>  int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);  b=
ool
> amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
>                                       enum amdgpu_ras_block block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 4dcb72d1bdda..5aadf24cb202 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -184,6 +184,9 @@ static int
> xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
>       case IDH_REQ_RAS_ERROR_COUNT:
>               event =3D IDH_RAS_ERROR_COUNT_READY;
>               break;
> +     case IDH_REQ_RAS_CPER_DUMP:
> +             event =3D IDH_RAS_CPER_DUMP_READY;
> +             break;
>       default:
>               break;
>       }
> @@ -467,6 +470,16 @@ static int xgpu_nv_req_ras_err_count(struct
> amdgpu_device *adev)
>       return xgpu_nv_send_access_requests(adev,
> IDH_REQ_RAS_ERROR_COUNT);  }
>
> +static int xgpu_nv_req_ras_cper_dump(struct amdgpu_device *adev, u64
> +vf_rptr) {
> +     uint32_t vf_rptr_hi, vf_rptr_lo;
> +
> +     vf_rptr_hi =3D (uint32_t)(vf_rptr >> 32);
> +     vf_rptr_lo =3D (uint32_t)(vf_rptr & 0xFFFFFFFF);
> +     return xgpu_nv_send_access_requests_with_param(
> +             adev, IDH_REQ_RAS_CPER_DUMP, vf_rptr_hi, vf_rptr_lo, 0); }
> +
>  const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
>       .req_full_gpu   =3D xgpu_nv_request_full_gpu_access,
>       .rel_full_gpu   =3D xgpu_nv_release_full_gpu_access,
> @@ -478,4 +491,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
>       .ras_poison_handler =3D xgpu_nv_ras_poison_handler,
>       .rcvd_ras_intr =3D xgpu_nv_rcvd_ras_intr,
>       .req_ras_err_count =3D xgpu_nv_req_ras_err_count,
> +     .req_ras_cper_dump =3D xgpu_nv_req_ras_cper_dump,
>  };
> --
> 2.34.1

