Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C39FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 14:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005EF10E061;
	Fri, 10 Nov 2023 14:17:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12B7A10E062
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 14:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwhMbRKThvZqIETNaJhd6Hhbrjad0iZshqSIwuCcDMncqWxMWo2TUTjy9Mtte1/wLrtJYoYCr/ypI7l672p6gKB7J14R/Fz4y1kj1W9BbNyKFG3f1/lsGOKa32Y8Iiz7SD+Eu8ahnqVU17JEU9V7XuBt9UtbewMi7z5V3VrWhNZgKdxhNVesjCp5688nLd7UoqXaeZLiG3CldgwVtyweAEgLsjGhBb+jnFgeyCu3VtG18Ct682WZjqxnsTxStTZ3u7ILZVlRC00bxbpKqCzomnNmk3bNkBBvva2hbvDrfdj60CBzsrhTw4kEjn9EnUJZNe9BRPUzSBAOtzNE7ZIeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMhXt8qqfQgXpgIBLC12x34EoYAICeb1rdvWuCZMeXM=;
 b=eSnMZQ9IcLgFwIUen1dKCmJCA4/ij99l1TfMO+GdqXBjB1eiT1SwcoM2dr7aeH8kLJRNE1wniq7tMmuMd11c8W/ri1x63ZpJuHKPj17g+9V22oDLZoHm0Ne8bGkOw2Q/xCEwEKCgj/8zk4R8bzZp/GtYDyHahlaOn2pVT1s5hV7oETU62dnGWNkautdFCudTYxXbqaCYrplV33j5/dUFxoGk+c5Y6emEG8wJ5viBoy9MRF0VIzF4SDhmbP/bfTOuoKUxp60FjNb2Y4TBT0Hd9C+6+o1y8TMXSmyPySpSMt1p82hqZe/+/X0pI1dqbmyDl6y+8KLGntA5AQol5LKatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMhXt8qqfQgXpgIBLC12x34EoYAICeb1rdvWuCZMeXM=;
 b=EAjapTArpVRkuf6ioTZxLc6++IeFc4GQa27hgVWRiicBKaXCWMOXeR4dbBvP6pNbRcTDV1OmjjKYd178bd2u4u2XJliMnNz3BXcAjN/ELioIJKnMF78aIr9WQA5SZQln1EdtQhp4Cu7GecHfORYUx1KemjoFQspDJFmIekGjpb4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 14:17:10 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 14:17:10 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: exclude domain start when calucales offset
 for AGP aperture BOs
Thread-Topic: [PATCH] drm/amdgpu: exclude domain start when calucales offset
 for AGP aperture BOs
Thread-Index: AQHaE9TLrFjJ9KGg10mrXxsBtL81lbBzmKwAgAAAV/SAAABZtQ==
Date: Fri, 10 Nov 2023 14:17:10 +0000
Message-ID: <BL1PR12MB51447D133B187D557131B8B7F7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231110125225.2512174-1-yifan1.zhang@amd.com>
 <82453041-8033-4d14-be82-ecfe7fce9f27@amd.com>
 <BL1PR12MB51448085CD4ECFAD5D00779DF7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51448085CD4ECFAD5D00779DF7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-10T14:17:09.392Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB6185:EE_
x-ms-office365-filtering-correlation-id: 21faf6d3-76af-485e-acae-08dbe1f7ba4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzfyuoT8GwJ+uONH+OOJJR149pWKIsU5DZHfBclQH56xFNrJpHz+n1F4bl0Bifzbu0gfeBjTk3lmxrCaE+VFWwqxqcEnDDXJ4dTm8OQXivMbcNX6TWNlkhzVSXDKzrYN6VTyunDOX4hJ4Lk+2s/chqpW9nV0KSEzTsDwjrJDDoDOeMPa3x/WAbaLagxWMChqUC6H5bUDhgnXwpO7825kszQ/gv71UqxhsuOoEiTQd26eYJs703ANTGml7sXsSw3re6SHUAhH0WRyuuUP2h8yaZjhsUjtA+KmUssaqgKO545TXccZLv47gx3GGbaCixnTGGhxAeijXy4fF1I+OYoloypZdzt6Bav1ombI7ilHaPUjAcy5mpifh9VnkCJ/fyPvhXDHELIl3p1AiIxac8C6FqfZ3Y+13zHEhOhCXiNKijqHLKKFo5S2nkvAW0Ui4J3v5KtaLR0J7ZuNuR4LE9rYqrffHgMG7T1N/lx4J6hb9RIUa7b4onsG80FqDzLGEixe/vMGewWUriJt7gCBiL3FMYccufYqqHxFY9BhTVXVDfvGTl6X4ObDaBEtInZcim9XDqi76aoITCrYD6yQ+L02ACkz5FoiBcFPuEUjR5/xfZenT+vdXsO/mPgqBQ9idtjQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(19627405001)(7696005)(478600001)(53546011)(9686003)(71200400001)(6506007)(2940100002)(86362001)(33656002)(38100700002)(122000001)(66446008)(64756008)(5660300002)(66556008)(38070700009)(316002)(83380400001)(26005)(41300700001)(2906002)(66476007)(76116006)(110136005)(66946007)(8936002)(52536014)(4326008)(8676002)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OJPoBs5glifqVOCu2x12YAbX40oelPrBSREuXn/xV7lmsFdNxoxZZ8BoSZUQ?=
 =?us-ascii?Q?rlZX6tWOcHBk0cM2e+PEvX4MEQmap2YZ+l2d/YqZZzfv0ohzKgIe8pByQed2?=
 =?us-ascii?Q?zFDuk5/0bjeepCz/RnZs4uqyS5dv6P6zHWBlu5dW/D3cflC9zhxQe/ZHSaBa?=
 =?us-ascii?Q?bNJUetjudWeQ/RJAvzCtmap045JuRYZ53E5TjXcxi/G18zY6zWzqW0NHPnoP?=
 =?us-ascii?Q?HRgJAF0RGdbCmpoxU9oDiMONuLLEhI+L7AiqEwGGO348Ht3pVE1WcfP+/TTq?=
 =?us-ascii?Q?xjhKRUSiGUsLqWxv19tvjIAU0rpNtMH2MCRbxWR1LrwuADICBj8DGuNwxiD7?=
 =?us-ascii?Q?HnrxdQsdcoLYQgHQJ5UjtdWDD53HSsEgZwqaHrKOMibUzrRpP1+H1ZojOViV?=
 =?us-ascii?Q?3VD77v2AYWnx7/5SpT6GSyXHndEPkpmcODOgoFoKzjYVo0hP4PSktS1bChUV?=
 =?us-ascii?Q?BHzQTyYqHxnZ2m4LdHBtj1Q3BtLAJV0939ZOBgfoUdD1HZWHzC6Uije2gjQY?=
 =?us-ascii?Q?GodwN+63VYwlhzqguL8lP6b7XTIbyHcUuC2p0G6NSfNSliGcvap395av6700?=
 =?us-ascii?Q?Kc0GG6zrHK2y57dpEkO2NcKvWWMIhYIIYDr3qrEf3FYPcV8zG+WWfWAtmIK6?=
 =?us-ascii?Q?BoHQ/atWHnP1ECmhuCHfLT1ORzYLN32kgIuYmF5n8rA9oHndmt92sROzU8h9?=
 =?us-ascii?Q?q5F2ab6/n5CS0Yeg4SzljV3cpza3VqLpGWzPpQ4YetXKPe6qouYn3H1IOyVs?=
 =?us-ascii?Q?D4T8VLoBVkjILHcnJ0sLwrX9Fmvy0V9mIUeWekxB4uJXxlzZ+xREYcIIZPEL?=
 =?us-ascii?Q?PJXBnIyQYS19YgYtSE9+t9v8GdJDxAPKDG/cFirh+HFi01xq6Uf2AWZ7mvzX?=
 =?us-ascii?Q?XfVzIHayNAdwak1pOxM54DtnX1p48tqfEBCcKWtUipsBVmRfpQO6cVZxUHcO?=
 =?us-ascii?Q?bc89mFi64Z7eJVit+Ujs0k2CuU2rPhgR7GHsKXPegpTlAALjYdSOctaksits?=
 =?us-ascii?Q?baQ9wrE1BuEiUB3pl1qhkHhlPrt8AVl389tmn3zn6gPi+d2kfyJiBbAJa8v1?=
 =?us-ascii?Q?7rISU8shQlFOhD6Ww/XwlthAm+G2QhsrlzDyljVsJfXUirIkkvZb0KTD5gGo?=
 =?us-ascii?Q?6uU2DNuxZQp1o36L/5pY4e8gGWkYGsIcKZToFYK5/Ig+ZZOEx5fuWosfzpdv?=
 =?us-ascii?Q?kDyGLGr1PQh7SDdm5bqauiKZk9M0aPEVs/vhrIvZmEjCbbXP3teu/Yh17lu4?=
 =?us-ascii?Q?TmzznUN5GiL6TRk5pazKsAkgm7reLLq4xZskF9T4A4qSo9K8GfUBc+pi1vIi?=
 =?us-ascii?Q?U/3MqCV22g7ecHWGkoBN1tFH8p/K4I3rZzeCSfHSUwWKtFgnMO/Du+2pBJnM?=
 =?us-ascii?Q?BI8ulNJ1MeUCRk16zE8nR3ll5KIuzUBe5hi6J80c1/wgz92dB2wEeIqUuDzq?=
 =?us-ascii?Q?P5GDuN4kHsrx+edF/ChE+ZaTy4B9b9sVW2NwaV7hRyZV+/fkTVVlMOxXNAkw?=
 =?us-ascii?Q?1p70dcfsKhBbPD08fZndr13Eq3tlvr42rO/av6hkvRYEo00DhFhciwyxYWm1?=
 =?us-ascii?Q?Y2TGjZxNUaCdB3PdM6o=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51447D133B187D557131B8B7F7AEABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21faf6d3-76af-485e-acae-08dbe1f7ba4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 14:17:10.1612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBAERZFRO5Rt4qHqxa1y8YQd2gDOiU5XkBtLqoafJp6G3aB2LA8NLhbPdbhFDJBq10+1OSSgIMfqPtn9gWANCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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
Cc: "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51447D133B187D557131B8B7F7AEABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

I think the proper fix is probably to just drop the addition of agp_start i=
n amdgpu_gmc_agp_addr().

Alex
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, November 10, 2023 9:16 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhan=
g@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: exclude domain start when calucales offset=
 for AGP aperture BOs

It happens in amdgpu_gmc_agp_addr() which is called from amdgpu_ttm_alloc_g=
art().

Alex
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Friday, November 10, 2023 9:14 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <amd=
-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jess=
e.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: exclude domain start when calucales offset=
 for AGP aperture BOs

Am 10.11.23 um 13:52 schrieb Yifan Zhang:
> For BOs in AGP aperture, tbo.resource->start includes AGP aperture start.


Well big NAK to that. tbo.resource->start should never ever include the
AGP aperture start in the first place.

How did that happen?

Regards,
Christian.

> Don't add it again in amdgpu_bo_gpu_offset. This issue was mitigated due =
to
> GART aperture start was 0 until this patch ("a013c94d5aca drm/amdgpu/gmc1=
1:
> set gart placement GC11") changes GART start to a non-zero value.
>
> Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 ++++++++--
>   3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 5f71414190e9..00e940eb69ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -169,6 +169,13 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *ade=
v, void *cpu_pt_addr,
>        return 0;
>   }
>
> +bool bo_in_agp_aperture(struct amdgpu_bo *bo)
> +{
> +     struct ttm_buffer_object *tbo =3D &(bo->tbo);
> +     struct amdgpu_device *adev =3D amdgpu_ttm_adev(tbo->bdev);
> +
> +     return (tbo->resource->start << PAGE_SHIFT) > adev->gmc.agp_start;
> +}
>   /**
>    * amdgpu_gmc_agp_addr - return the address in the AGP address space
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index e699d1ca8deb..448dc08e83de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -393,6 +393,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev=
, void *cpu_pt_addr,
>                                uint64_t flags);
>   uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo);
>   uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo);
> +bool bo_in_agp_aperture(struct amdgpu_bo *bo);
>   void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgp=
u_gmc *mc);
>   void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu=
_gmc *mc,
>                              u64 base);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index cef920a93924..91a011d63ab4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -39,6 +39,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_gmc.h"
>
>   /**
>    * DOC: amdgpu_object
> @@ -1529,8 +1530,13 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo=
 *bo)
>        struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>        uint64_t offset;
>
> -     offset =3D (bo->tbo.resource->start << PAGE_SHIFT) +
> -              amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
> +     /* tbo.resource->start includes agp_start for AGP BOs */
> +     if (bo_in_agp_aperture(bo)) {
> +             offset =3D (bo->tbo.resource->start << PAGE_SHIFT);
> +     } else {
> +             offset =3D (bo->tbo.resource->start << PAGE_SHIFT) +
> +                      amdgpu_ttm_domain_start(adev, bo->tbo.resource->me=
m_type);
> +     }
>
>        return amdgpu_gmc_sign_extend(offset);
>   }


--_000_BL1PR12MB51447D133B187D557131B8B7F7AEABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">I think the proper f=
ix is probably to just drop the addition of agp_start in amdgpu_gmc_agp_add=
r().</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Alex</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Friday, November 10, 2023 9:16 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Zhang, Yifan=
 &lt;Yifan1.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@li=
sts.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: exclude domain start when calucales=
 offset for AGP aperture BOs</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
It happens in amdgpu_gmc_agp_addr() which is called from amdgpu_ttm_alloc_g=
art().</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Alex</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian &=
lt;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Friday, November 10, 2023 9:14 AM<br>
<b>To:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; amd-gfx@lists.freedes=
ktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Jes=
se(Jie) &lt;Jesse.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: exclude domain start when calucales=
 offset for AGP aperture BOs</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Am 10.11.23 um 13:52 schrieb Yifan Zhang:<br>
&gt; For BOs in AGP aperture, tbo.resource-&gt;start includes AGP aperture =
start.<br>
<br>
<br>
Well big NAK to that. tbo.resource-&gt;start should never ever include the =
<br>
AGP aperture start in the first place.<br>
<br>
How did that happen?<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; Don't add it again in amdgpu_bo_gpu_offset. This issue was mitigated d=
ue to<br>
&gt; GART aperture start was 0 until this patch (&quot;a013c94d5aca drm/amd=
gpu/gmc11:<br>
&gt; set gart placement GC11&quot;) changes GART start to a non-zero value.=
<br>
&gt;<br>
&gt; Reported-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
&gt; Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp; =
|&nbsp; 7 +++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp;&nbsp;&nbsp; =
|&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 ++++++++--=
<br>
&gt;&nbsp;&nbsp; 3 files changed, 16 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c<br>
&gt; index 5f71414190e9..00e940eb69ab 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; @@ -169,6 +169,13 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *=
adev, void *cpu_pt_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +bool bo_in_agp_aperture(struct amdgpu_bo *bo)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_buffer_object *tbo =3D &amp;(bo-&=
gt;tbo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D amdgpu_ttm_ad=
ev(tbo-&gt;bdev);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return (tbo-&gt;resource-&gt;start &lt;&lt; =
PAGE_SHIFT) &gt; adev-&gt;gmc.agp_start;<br>
&gt; +}<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_gmc_agp_addr - return the address in the AG=
P address space<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.h<br>
&gt; index e699d1ca8deb..448dc08e83de 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; @@ -393,6 +393,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *a=
dev, void *cpu_pt_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags);<br>
&gt;&nbsp;&nbsp; uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo);<br>
&gt;&nbsp;&nbsp; uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo)=
;<br>
&gt; +bool bo_in_agp_aperture(struct amdgpu_bo *bo);<br>
&gt;&nbsp;&nbsp; void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev,=
 struct amdgpu_gmc *mc);<br>
&gt;&nbsp;&nbsp; void amdgpu_gmc_vram_location(struct amdgpu_device *adev, =
struct amdgpu_gmc *mc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 base);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index cef920a93924..91a011d63ab4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -39,6 +39,7 @@<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_trace.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt; +#include &quot;amdgpu_gmc.h&quot;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * DOC: amdgpu_object<br>
&gt; @@ -1529,8 +1530,13 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu=
_bo *bo)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; offset =3D (bo-&gt;tbo.resource-&gt;start &l=
t;&lt; PAGE_SHIFT) +<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; amdgpu_ttm_domain_start(adev, bo-&gt;tbo.resource-&gt;mem_type);<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* tbo.resource-&gt;start includes agp_start=
 for AGP BOs */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (bo_in_agp_aperture(bo)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; offset =3D (bo-&gt;tbo.resource-&gt;start &lt;&lt; PAGE_SHIFT);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; offset =3D (bo-&gt;tbo.resource-&gt;start &lt;&lt; PAGE_SHIFT) +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_domain=
_start(adev, bo-&gt;tbo.resource-&gt;mem_type);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_gmc_sign_exten=
d(offset);<br>
&gt;&nbsp;&nbsp; }<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB51447D133B187D557131B8B7F7AEABL1PR12MB5144namp_--
