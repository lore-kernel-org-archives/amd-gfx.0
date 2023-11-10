Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8979C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 14:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE2E10E087;
	Fri, 10 Nov 2023 14:27:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518B910E087
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 14:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmrydnJQoMs177mxtSXOL3W3Wz3DT1pPPwiSGQtlZZlubY43JFdXYSwbESH6lYhK6SZ+HQIEMd2ySgbdiCIZzLuAJqIHso2ZGJiRU4YAU26k9s+nFjOQo4T8FCq8LYKCBbOA3eEUJqUoQx1GVAqzYiOtXU5Bf9PXsFxH3eJyZ3cZZR7A4WszAW7++ghgcN4iQijs4+t8wMYEXU6ZINi6+MU0xStg732UKcLsLI9sqeQijGfS/Cbou6haVBa64krr85Z+fisQpPOT4kADPFuFco4Ca/0iEWNl4QBIaiNZoWlNLwnBtvWBewws/TkBmWa6WoxA7SjYICyM+eR4cTarQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMdDJ9fbHSXsJ8qDzgJzIcNWSZywIkbdzpHiRBF47GU=;
 b=Ie7J3v3SR+07gTZ285YuYZ6+afFBtwjZiK6yB3KoWaL6TTJ/HsaevEtLk5HZ93wSSwVt7PLG2WM59PPnFRI5wBfrXiDHlSByUIUa7hazVKG/y7TnKRqvd+0MvSMOAY+FAal/EgzlnEBSO8EvWeXLhLy19C9+BvdsT8ngcQyti1g8r5i45UUd8FMlIbLDUfmSa9a2peL5sVjnkFtNSrwFoicV/1A3c7f9kXpvFEnTzwSiIXuAq91Pl9ekfyddjkneexMIB5g80BmoRP1etorAZ1/WZ3+8br1H8Y63GMrmpGQhXvHATrwg7liOPmGU1qkLX4CAfk6J6tQ/KDpAkeG7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMdDJ9fbHSXsJ8qDzgJzIcNWSZywIkbdzpHiRBF47GU=;
 b=rhum63TqDdsm0rLgMQi538yISfGlCKIGjNHJpw/d2wQmYhU766R3LhG03Dh7ie4qqm6hfItrNiGOVYxLKNA5b8jUU3hFdZXW5M1Hg2/yP9WyVUJ3M2So1N8uTJEGJFqVov74HYXVTTL+5LF3FD5IBGWd8kxL5LDPoV1F0XiwcG0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 14:27:29 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 14:27:29 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: exclude domain start when calucales offset
 for AGP aperture BOs
Thread-Topic: [PATCH] drm/amdgpu: exclude domain start when calucales offset
 for AGP aperture BOs
Thread-Index: AQHaE9TLrFjJ9KGg10mrXxsBtL81lbBzmKwAgAAAV/SAAABZtYAAAS6AgAABiR0=
Date: Fri, 10 Nov 2023 14:27:29 +0000
Message-ID: <BL1PR12MB51446545ED2B94B3F82BEC9BF7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231110125225.2512174-1-yifan1.zhang@amd.com>
 <82453041-8033-4d14-be82-ecfe7fce9f27@amd.com>
 <BL1PR12MB51448085CD4ECFAD5D00779DF7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BL1PR12MB51447D133B187D557131B8B7F7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <64d13d64-d745-47da-99c8-3f941fe52d72@amd.com>
In-Reply-To: <64d13d64-d745-47da-99c8-3f941fe52d72@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-10T14:27:28.953Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM6PR12MB4139:EE_
x-ms-office365-filtering-correlation-id: 7d98e59d-3af5-4773-9975-08dbe1f92b9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yMDYPAxrTkuIxGHxMCC3nlf3yExhysM/RFuMZa8XrnFTAJvcawh+AgCMOInJzKIOBzZuAM5QHbMhI+HIfALJG3EKkJFJ5xNXUmEELJ5/9th4DmyHQczqsaajnmWWL5eAJ3HDckCHiR+znHT2uuShWMHedC6bAdjjpqrnlGV1JcB/64ZeC1IbYoGsdgTu6CZ70qMNbHTRE8eAc1LXTZ4dVHSdpc5IQpnbzSn3aIoIIE+dF79eWc4LdErbPpztz2QJSCD+9EsGsNwUtkVP6Tk/30ozaQhaTVUz2ndxh/SxAvwVKF0Vxy2FhXUFcRCtYO+sB+tCIp+9iu6MJkC9WLmv/A0Q5cg5YZDLDagbAV3J6gypIGM0v//Lf9Ew5xfhQi5QcWQudERbLBzHo3g1aT+ATrlhfFMZwgn1JvPL5LxvzmB4dSrle47hs3p2CvMLSxmLYwIc9HbrgCTNZDxCeXuJkJlGuXv67eKsWR6/AnXVaOpSlyw+tutry9LjbAKZNK6FciwcGTE5Mxm4xkn3NbLihfeC6JxjYHhRvFkT7/5SB6rPhCrhRR9kuUQRqkVpKKlU6sdmof9+6uFoWOVMIImAliH/w3bfnmmjezOqQZLqj02Byi5tEVm6cXYrU5ndmrmc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(19627405001)(55016003)(478600001)(66946007)(316002)(38070700009)(122000001)(86362001)(33656002)(38100700002)(83380400001)(7696005)(9686003)(110136005)(6506007)(66556008)(91956017)(64756008)(26005)(52536014)(76116006)(41300700001)(66446008)(4326008)(71200400001)(53546011)(5660300002)(66476007)(8676002)(2906002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?En/ST4xTkViOmmu9k53Y03LxBh2p9fWju4QXS82qIspnX7gjLgeqaBAXzLvB?=
 =?us-ascii?Q?BdJE85vHjGNr284wcrhTYZSP/xI0KpFa56O8LN3qcwi7P61v5UqPMkdAyoMB?=
 =?us-ascii?Q?x2euZ3iP/BqByG6ThKDmETDbnPCBKQyQwjYq+0Biom5hAoaVU6orMl0q/t9q?=
 =?us-ascii?Q?zbMWDZ/RTmyZ4AaXuRCFdswjZw53B3gNqvf62wVYLf2I/ILWETQuFvYxv1+L?=
 =?us-ascii?Q?o5w+kkJAM7OceByR/CyJO030NfQ7zx1/iki3UgdFTiyyVeDAp5kU3RaDhLLv?=
 =?us-ascii?Q?Cw/dULNvbYYYAwobtdi308jIRm0zbQtLIMCuKiZ5mzfo9d3dmWTtZfIEOmMi?=
 =?us-ascii?Q?/4mvL+gBMYhDBjgzB3Lg9IWNL9kklbn99/joqasl8xtEhvPpuTQ8f0IHdtTB?=
 =?us-ascii?Q?McP4Eh3mhyXhK9F4NinWRBJ+VFDXn+GVnWa5ECv0eaB82NrsjSIVrW9pnM6r?=
 =?us-ascii?Q?QS0TS4oDPjiau7I7yezP8N3igJN4hf//PJHkiCjYoO7gDlZboAmZTnIzJ++k?=
 =?us-ascii?Q?0W2Bu31vufNGyQqnSGbljzur1M6WIcyeM2A1TWgHHgLdGNNZe3+J5s5eXmsQ?=
 =?us-ascii?Q?tPzv7BH3B32MCqC0yHHnyQAPtGAa5i4CfsBZG70uaL8DpdequuUaN8IVF5P1?=
 =?us-ascii?Q?1dFmBvB08EMbA/x950HA+rpu43CtLIAoKvBPFGKyPovL+T2TZbYQ/Vxrw73Y?=
 =?us-ascii?Q?TiGVBtqMMHJRrgKSqX80Mm+IXTTiNi07uFoq/nH2AZhrV2QwvS/WUPbh6zTz?=
 =?us-ascii?Q?iT1ztRLJR/9pXcLxGy2He5094/7nDy9kL6Qd8H7avokwZHdeoyoAGTnDep14?=
 =?us-ascii?Q?ksRjh0SryR9hPFAogtV9WBppdZcgXp7flEmaq0c2gieqbpxDWw0vTdVGZMel?=
 =?us-ascii?Q?bvrje0bmQK9ZMYubGfzwX3QBB4RkGwz2wTsP1MAr/ozHl8hnTmNYjNgkcSeM?=
 =?us-ascii?Q?Z7Ff5HMsfvkokdoXMJ5G1QytGMQuXn0c4RzNf3e7DcGeguSZP7S3k929BX0x?=
 =?us-ascii?Q?TH07aCBsQUsQPU5BG15IKsCf6PSrkXccRMdzeqS9xJS78+LA1AjzshbSmDAQ?=
 =?us-ascii?Q?PryJA6GCM54rwgqEh8YdxnJGmZidLOPRwWtF2FLo0N8pfTOU+L9wcw/7C4SM?=
 =?us-ascii?Q?0i/Ds1FWQhzS0JuPAF6CUNoIXDq01iaYywGED0tTmpfN3WoRA554YSD6U9rS?=
 =?us-ascii?Q?zj7K5cXQQgX9358ZG8vrNwA8mcGiasnMqlZZXKVvIQvTEFgnQpQ44uLfkmPm?=
 =?us-ascii?Q?UmVFHPLuG8rtHM0fV36a1vfN+kCvlOwxhc5Ed9NM2g0Mx/QPemGBh05SYg0X?=
 =?us-ascii?Q?MZhObhzX/1f6xKJpcsdCL6ChTo98lw649sWy7GyUtbar44Yt+5UB767xqY+q?=
 =?us-ascii?Q?LKsMBdaF4suEYfWNV1chUHj8HhRj5s2OF5jwxRcr4qujsJGapdyg1DkdqLoM?=
 =?us-ascii?Q?9A8y4O+kKUOalZ5MS6iIK0Zx4Y+sJxRLMvX5Oz81i+5122h6A0Ix0VvN9hjx?=
 =?us-ascii?Q?49z+d7cwdl2fVHYXoQll/qpMzRW6YZHfLULKSbKgA54DjqB7wWEWCEK1H2Tk?=
 =?us-ascii?Q?WasPiNdKICCwq7F7AE0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51446545ED2B94B3F82BEC9BF7AEABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d98e59d-3af5-4773-9975-08dbe1f92b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 14:27:29.7633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvA0pBoQyThtGWpslsX490oIbhKX/V4D+rw0S0F5chlPd5Tt9S3OWmZ8G6xHtWq6L2X0lL7wTpSf/7ZUI/57cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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

--_000_BL1PR12MB51446545ED2B94B3F82BEC9BF7AEABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

In that case, how do we know we can skip the gart setup in amdgpu_ttm_alloc=
_gart()?

Alex
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Friday, November 10, 2023 9:20 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: exclude domain start when calucales offset=
 for AGP aperture BOs

No, that's broken as well.

The problem is in amdgpu_ttm_alloc_gart():

        if (addr !=3D AMDGPU_BO_INVALID_OFFSET) {
                bo->resource->start =3D addr >> PAGE_SHIFT;
                return 0;
        }

bo->resource->start is relative to the GART address, so we can't assign the=
 AGP address here in the first place.

What we need to do is to drop this and call amdgpu_gmc_agp_addr() from amdg=
pu_bo_gpu_offset_no_check().

Regards,
Christian.

Am 10.11.23 um 15:17 schrieb Deucher, Alexander:

[Public]

I think the proper fix is probably to just drop the addition of agp_start i=
n amdgpu_gmc_agp_addr().

Alex
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deuch=
er@amd.com>
Sent: Friday, November 10, 2023 9:16 AM
To: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@am=
d.com>; Zhang, Yifan <Yifan1.Zhang@amd.com><mailto:Yifan1.Zhang@amd.com>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx=
@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com><mailto:Jesse.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: exclude domain start when calucales offset=
 for AGP aperture BOs

It happens in amdgpu_gmc_agp_addr() which is called from amdgpu_ttm_alloc_g=
art().

Alex
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@=
amd.com>
Sent: Friday, November 10, 2023 9:14 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com><mailto:Yifan1.Zhang@amd.com>; amd-g=
fx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lis=
ts.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher=
@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com><mailto:Jesse.Zhang@amd.c=
om>
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
> Reported-by: Jesse Zhang <Jesse.Zhang@amd.com><mailto:Jesse.Zhang@amd.com=
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com><mailto:yifan1.zhang@amd=
.com>
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



--_000_BL1PR12MB51446545ED2B94B3F82BEC9BF7AEABL1PR12MB5144namp_
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
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">In that case, how do=
 we know we can skip the gart setup in amdgpu_ttm_alloc_gart()?</span></div=
>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Friday, November 10, 2023 9:20 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@=
lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: exclude domain start when calucales=
 offset for AGP aperture BOs</font>
<div>&nbsp;</div>
</div>
<div>No, that's broken as well.<br>
<br>
The problem is in amdgpu_ttm_alloc_gart<span style=3D"font-family:Aptos,Apt=
os_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; color:rgb=
(0,0,0)">():<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (addr !=3D AMDGPU_BO_INVALID_=
OFFSET) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; bo-&gt;resource-&gt;start =3D addr &gt;&gt; PAGE_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
bo-&gt;resource-&gt;start is relative to the GART address, so we can't assi=
gn the AGP address here in the first place.<br>
<br>
What we need to do is to drop this and call&nbsp;</span><span style=3D"font=
-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans=
-serif; color:rgb(0,0,0)">amdgpu_gmc_agp_addr() from</span><span style=3D"f=
ont-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,s=
ans-serif; color:rgb(0,0,0)">
 amdgpu_bo_gpu_offset_no_check().<br>
<br>
Regards,<br>
Christian.<br>
</span><br>
<div class=3D"x_moz-cite-prefix">Am 10.11.23 um 15:17 schrieb Deucher, Alex=
ander:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#008000=
; margin:15pt; font-style:normal; font-weight:normal; text-decoration:none"=
>
[Public]<br>
</p>
<br>
<div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<span style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cal=
ibri,Helvetica,sans-serif; color:rgb(0,0,0)">I think the proper fix is prob=
ably to just drop the addition of agp_start in amdgpu_gmc_agp_addr().</span=
></div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<span style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cal=
ibri,Helvetica,sans-serif; color:rgb(0,0,0)"><br>
</span></div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<span style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cal=
ibri,Helvetica,sans-serif; color:rgb(0,0,0)">Alex</span></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher@amd.c=
om">&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Sent:</b> Friday, November 10, 2023 9:16 AM<br>
<b>To:</b> Koenig, Christian <a class=3D"x_moz-txt-link-rfc2396E" href=3D"m=
ailto:Christian.Koenig@amd.com">
&lt;Christian.Koenig@amd.com&gt;</a>; Zhang, Yifan <a class=3D"x_moz-txt-li=
nk-rfc2396E" href=3D"mailto:Yifan1.Zhang@amd.com">
&lt;Yifan1.Zhang@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated" h=
ref=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Zhang, Jesse(Jie) <a class=3D"x_moz-txt-link-rfc2396E" href=3D"m=
ailto:Jesse.Zhang@amd.com">
&lt;Jesse.Zhang@amd.com&gt;</a><br>
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
<div class=3D"x_x_elementToProof" style=3D"font-family:Aptos,Aptos_Embedded=
Font,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; colo=
r:rgb(0,0,0)">
It happens in amdgpu_gmc_agp_addr() which is called from amdgpu_ttm_alloc_g=
art().</div>
<div class=3D"x_x_elementToProof" style=3D"font-family:Aptos,Aptos_Embedded=
Font,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; colo=
r:rgb(0,0,0)">
<br>
</div>
<div class=3D"x_x_elementToProof" style=3D"font-family:Aptos,Aptos_Embedded=
Font,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; colo=
r:rgb(0,0,0)">
Alex</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif=
" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Christian.Koenig@amd.co=
m">&lt;Christian.Koenig@amd.com&gt;</a><br>
<b>Sent:</b> Friday, November 10, 2023 9:14 AM<br>
<b>To:</b> Zhang, Yifan <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto=
:Yifan1.Zhang@amd.com">
&lt;Yifan1.Zhang@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated" h=
ref=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Deucher, Alexander <a class=3D"x_moz-txt-link-rfc2396E" href=3D"=
mailto:Alexander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a>; Zhang, Jesse(Jie) <a class=3D"x_moz-=
txt-link-rfc2396E" href=3D"mailto:Jesse.Zhang@amd.com">
&lt;Jesse.Zhang@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: exclude domain start when calucales=
 offset for AGP aperture BOs</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText">Am 10.11.23 um 13:52 schrieb Yifan Zhang:<br>
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
&gt; Reported-by: Jesse Zhang <a class=3D"x_moz-txt-link-rfc2396E" href=3D"=
mailto:Jesse.Zhang@amd.com">
&lt;Jesse.Zhang@amd.com&gt;</a><br>
&gt; Signed-off-by: Yifan Zhang <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:yifan1.zhang@amd.com">
&lt;yifan1.zhang@amd.com&gt;</a><br>
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
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB51446545ED2B94B3F82BEC9BF7AEABL1PR12MB5144namp_--
