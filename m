Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A661C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 07:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F4910E46D;
	Thu, 21 Jul 2022 07:21:11 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE6310EFF0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 07:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfCApAxG+e5E8OyYy0h7LClPNHA7wyqiwdG5Gq//Ez2+dpdqUT5JkpZHAnWOBOdGaURMqJ316CqK/pYoYibPUR+ozkdX1wy88Z3O5XrG9QP1Rwq2S6/ilHkC8uEDTLnEfn6891zkxIoOysmReC1id0OF9qXsnf6fkSE+Zl3zNaNYnqFpP1EOgKYZRGX4e90cKuHKR51ske3emAV65DMKPrS7y6+hxML97T/Eq6101g9usS2e5t1mMMIFD/LqqG1IM3Gqi2+Bd5lIdi8MlFE0erPFLAyEPqyQtnMy0Hf7Jh/szKS+2LNfgtldL8cpNrwCZeC+DMQwMioLTVwRHPmXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvfCSMdygobqrcEJvS+M53aIoQ3Jo4NuvVcPNwvXMW0=;
 b=Ls8Ja2ggNZNx4Q1J7M2swcvThpsE8Zcg2TYuXeQot6WQJjMxHYo6R/DO8mo/sVRgARUQX0ZEWhpztQP10YORmBuS1pmK91ASuT6HzPVwgTbrrAg2kygeF3ocT1FHcIdQZaVUk30ZfBvx76hLO7OG5dpdeH2As3HrM0bfmTYrOIrJWZPcpVgmkT1QsmLYfGTtvd1OV2nQzRUWqOg5be+AhoA0f5cr7cNZvH3uUUe9LWiEJSHuLXP/J3FS/LAlli6wpL/H4MgvkkVcXKkvDBd6apGquanXy9C7Qg0X/wkbbu3jXOpdYEn16AruQLqpBQ6r/wDX8ASHjwii/X/qtVkdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvfCSMdygobqrcEJvS+M53aIoQ3Jo4NuvVcPNwvXMW0=;
 b=X80jtolJz5GUPBCy9MVVDZ7mktH87gZxQzFcW3c2h/oOp31D/aBPifq1WJHh1l3dezo2VC/aUpbBV8pGl6X2AaoUhx+tYlQACuamGPSpBSVXXqBjwLyMhe91ERPOoLez3w4LGqk8rbu2HsjOeOfOru5+bNVW+uEzGR6ZCWgKdi4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.17; Thu, 21 Jul 2022 07:21:05 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::edf8:621:a15d:4447]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::edf8:621:a15d:4447%7]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 07:21:05 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Guo, Shikai" <Shikai.Guo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/admdgpu: Add get_gfx_off_status interface
Thread-Topic: [PATCH] drm/admdgpu: Add get_gfx_off_status interface
Thread-Index: AQHYnMn9s2DuEOCwoU6DPRy/RYs3ca2IaZcg
Date: Thu, 21 Jul 2022 07:21:05 +0000
Message-ID: <DS7PR12MB6005B54A86F7617DC603CEDEFB919@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20220721061942.2517331-1-shikai.guo@amd.com>
In-Reply-To: <20220721061942.2517331-1-shikai.guo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=60578fd5-b54f-4daa-bebb-2ef94c92a7b4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-21T07:15:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33906be7-3e20-4a29-7e03-08da6ae99302
x-ms-traffictypediagnostic: DM6PR12MB4300:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZLe4jo+JsBF7dvlfdfkpiQV/l93Nwnd/qQ6vv42mwnyMdCfgYTc8cUEB8hY5ZH2YavFsmDAieloxx9gqCbgcf8yZuqTxaK1EF96Cq4vWGqIk43UL791cS95B3TlmN8DbTGZ9aMJLpOMzHBzhleJkWB/wpd1Yx+KuoxTzLCRWc+WHtLEYGARhFKEChpyWrXtuubfFcvjrhAOMXhgBmhbS9BXjxro53+ciSGxJtgRhrfDczw4pQJd2hFbzp6t/dOwv/kfosnqJThl9L7dUNxfPdRQL/uxPWYuN4+ezOV4wXh+KhijNdPflbpiJrJQ19wCn2AMsjTAHtJG6PPQAYoeQcQyRsHk5VjrA8etbItjSUamzs5pf8J14zNSScqJLRioDU1DGJ9wwgPDxgwvO+UiyveXRx3QZGT1DQcmllGfBb/8b/IwDydw4Jm4uSex0mr4WIu4OP2iX+FU0QlGVTXeSk6HO9MAzdlZ6GUxVeGRV+Pt1UVtrJXX+JCQBAFQPp5tMf5P/PHzqRLGcwHzGlOtDy1vYsYwro5QlDscu3IuUgmlmFW75hog9XoShIz+NwFAfCCo8KaG7KNbckt1b8FVh/AjfEl9iBy7v2e65TwUoGd5ZaiR/yd7Md4/5EMguUyvN/JLCADgqKHdjz4hUgAUJtvLFYrpx430xx8AH6fr0zwCObMEVOJJq+jeVKYhWodzXX8sj63Zr0jVrJUe3JRAnO7d0OC2s1eNRSXCCnpx4/joTeKTedvDRR+w8kNLtoYsEl3Cu2WVpMu5bxi6C7ZlAVXqqqwb2cbgXwRYthm1B/N7YM7zBggiFjVCYrLpYLPX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(66556008)(64756008)(4326008)(8936002)(86362001)(8676002)(52536014)(66446008)(66476007)(5660300002)(33656002)(316002)(38070700005)(76116006)(38100700002)(7696005)(66946007)(53546011)(54906003)(55016003)(9686003)(26005)(6506007)(41300700001)(186003)(110136005)(2906002)(478600001)(122000001)(71200400001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j69iGKuYQ5pjJZDRDow+OShA77R5bieR5v/kja1ymqALLm1kXP1BRlgVBjJt?=
 =?us-ascii?Q?9Qn3aLGMB80ZdJdtU88REqlYSNUfBtdAsU2xcV/41nDYuFmrXUSdxO/rnydj?=
 =?us-ascii?Q?B+Rl6LJVNKNMAXDTHhSMILkGUfPpD8RrakEbz0eFyFGUB3OJygiDlSEMmxfp?=
 =?us-ascii?Q?GxEyScKlVu3JP6ITTzAtzC+C5S6HeYONWDagdssikjWHm07Yt87+Z7X8ukHU?=
 =?us-ascii?Q?/iBA8/CsLjVXxMMPnHZp3Bd4nZdLoyay613eQw9YxAsbmB3BFIG4XW5TtgSA?=
 =?us-ascii?Q?mE6RNkSyQkziUdWAkjyb51zLKtHmrB6JTB6ocMdSyohEXx3J3z+5qluFy7bE?=
 =?us-ascii?Q?rF+1uixnc+bh/mF0TPKERnSuSOKgf5DB/OEEdixVc4cU/Q9+JWzYiSdQuoaD?=
 =?us-ascii?Q?1Rh3FvZh/HKLQedn5E6tXMy26q+jzKWhjvaQY5SQ6iBt+X28SgYM8r0oXGvo?=
 =?us-ascii?Q?J5+RnB3rHj5F7lHkaFBtW2ZiCd/xSNglW0ymay8mF7CAJEDg8TzF0E9snFO5?=
 =?us-ascii?Q?ytO0MsCGD+QO7kgzNUkpOqPHFIkUZLIg4VxDp8ZRJSKn2Zx/WXtV0ciQWT8v?=
 =?us-ascii?Q?iwcIj2ajfHEjutMDN4F2SmbscxQtfjjud1Ng4GFURydkvc44mrQ0WNYA4Ubi?=
 =?us-ascii?Q?XI3vd6wVGr0/gd01iALHIe7zxLIZlLMddjmCzaaS6WqU4ZlzKYlScGsGXkLt?=
 =?us-ascii?Q?exybalhL2YrcQxQ5GwAEEddxNujcrivqbxk6tnv4HrWb6Mj1QBjqbAJ2wHRN?=
 =?us-ascii?Q?VpXFU3ZgVLqZ8JWEAlnQVZKWaq9AQiCZwIL58qWU9c7m5HZoXPUodvWBC5dA?=
 =?us-ascii?Q?1csnQd6LScy0Se5E+unKPMh5igIZF6L5QfyPC11AgQZzQOzEc6+ewalVOX27?=
 =?us-ascii?Q?egkMARcQz2xfEdRZzaykPZoYZkSmqfyy9j2TZuMgfrMjW/gPhjQ/TlFJlrby?=
 =?us-ascii?Q?He0NoYW8QB0e9rHhf3kqNEP2K8peL2Hf+epts7Q4AVImNxGPPRKpGxlIdl1S?=
 =?us-ascii?Q?jziK6mGc75x7dwKi/dm/fISe0uCzxS0M02mFOEAh2iL5Hx/dc2yk+7+6t94l?=
 =?us-ascii?Q?pmTVwJPYMjnH45+ooFnULAa5/XGUikgR3sP+dPfrTZbmOzbcDbwwDMAj5AxZ?=
 =?us-ascii?Q?sAbsFQU4YAM1rhqpuiLIepwgINbwqYFGO7H7ll8/8wayeQSBUOa+nR1HwdSs?=
 =?us-ascii?Q?nWgorCrb9E9VqNMfw+ZWogFcq7q4sw6RRB4PspzdvoVDH/8sfkYr5PILtQX8?=
 =?us-ascii?Q?fuDhK0lPRhfwKoBolh3L95+b0xFzvc7a9z99B+VJj6DtVzIH0BGsjyYDr2Wq?=
 =?us-ascii?Q?DXyu+tGJTBa3E5cqdDURg1II3iE2yK81MZ8gBx7Q5vKSyhG/SUlkvPNuWk3o?=
 =?us-ascii?Q?g+v5sEtLI6UcDMjkX0zDnOZBBGCsQ06yX0Auvvc1th7q05fT7FXLxZnqDXMm?=
 =?us-ascii?Q?9rtxDAJaIdG+ptepoXtLB3yH3ggVrTW7qeVTNaqyhMLw7DrV3bQGF80odlZY?=
 =?us-ascii?Q?Y4EUF2Qo5NZVi3l+EN1UM2MIZfiz1hnqLluayFGHra9wqGIyXiru275h3NXW?=
 =?us-ascii?Q?AXZZupBYnYUyv/gAAj4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33906be7-3e20-4a29-7e03-08da6ae99302
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 07:21:05.2216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jctz9evHrzhczsMSu6ZAlK7V2wtnjck+1oi6gCWe3FPAPrBvJGtTNw6iFUQsN9pc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

It looks like the amdgpu_device pointer declaration is useless, please clea=
n it up.
Meanwhile need correct the patch subject prefix to drm/amd/pm: instead of d=
rm/admdgpu.

With the above fixed the patch is Reviewed-by: Prike Liang <Prike.Liang@amd=
.com>

> -----Original Message-----
> From: Guo, Shikai <Shikai.Guo@amd.com>
> Sent: Thursday, July 21, 2022 2:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Guo,
> Shikai <Shikai.Guo@amd.com>; Guo, Shikai <Shikai.Guo@amd.com>
> Subject: [PATCH] drm/admdgpu: Add get_gfx_off_status interface
>
> From: Shikai Guo <Shikai.Guo@amd.com>
>
> add get_gfx_off_status interface to yellow_carp_ppt_funcs structure.
>
> Signed-off-by: Shikai Guo <shikai.guo@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 30
> +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index 70cbc46341a3..cac48121d72b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -31,6 +31,7 @@
>  #include "smu_v13_0_1_ppsmc.h"
>  #include "smu_v13_0_1_pmfw.h"
>  #include "smu_cmn.h"
> +#include "asic_reg/smuio/smuio_13_0_2_offset.h"
>
>  /*
>   * DO NOT use these for err/warn/info/debug messages.
> @@ -42,6 +43,9 @@
>  #undef pr_info
>  #undef pr_debug
>
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK
>       0x00000006L
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT
>               0x1
> +
>  #define FEATURE_MASK(feature) (1ULL << feature)  #define
> SMC_DPM_FEATURE ( \
>       FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \ @@ -587,6 +591,31
> @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
>       return sizeof(struct gpu_metrics_v2_1);  }
>
> +/**
> + * yellow_carp_get_gfxoff_status - get gfxoff status
> + *
> + * @smu: amdgpu_device pointer
> + *
> + * This function will be used to get gfxoff status
> + *
> + * Returns 0=3DGFXOFF(default).
> + * Returns 1=3DTransition out of GFX State.
> + * Returns 2=3DNot in GFXOFF.
> + * Returns 3=3DTransition into GFXOFF.
> + */
> +static uint32_t yellow_carp_get_gfxoff_status(struct smu_context *smu)
> +{
> +     uint32_t reg;
> +     uint32_t gfxOff_Status =3D 0;
> +     struct amdgpu_device *adev =3D smu->adev;
> +
> +     reg =3D RREG32_SOC15(SMUIO, 0, regSMUIO_GFX_MISC_CNTL);
> +     gfxOff_Status =3D (reg &
> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK)
> +             >> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT;
> +
> +     return gfxOff_Status;
> +}
> +
>  static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)  =
{
>       struct smu_table_context *smu_table =3D &smu->smu_table; @@ -
> 1186,6 +1215,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs
> =3D {
>       .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
>       .set_driver_table_location =3D smu_v13_0_set_driver_table_location,
>       .gfx_off_control =3D smu_v13_0_gfx_off_control,
> +     .get_gfx_off_status =3D yellow_carp_get_gfxoff_status,
>       .post_init =3D yellow_carp_post_smu_init,
>       .mode2_reset =3D yellow_carp_mode2_reset,
>       .get_dpm_ultimate_freq =3D yellow_carp_get_dpm_ultimate_freq,
> --
> 2.25.1

