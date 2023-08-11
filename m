Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CC3C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 07:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D94810E670;
	Fri, 11 Aug 2023 07:06:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A418610E668
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 07:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bttgj0lcCFq1pa7l7EZHDFTUZUeCkuVWJhxgLUaqVRPbIHvrNdvGLdNLV5Lk1W6zliI+r+HKumAqxsoX3tovFykOY5XPrpsoRBcJ16vsHg8hfZDWFaW7WSm6/Hp/4EpzUiAusqMPUJu+BNJRHQg5AgUs7dx3B1K99zF1J4GviQqa5ORee/Eigj/w8su9cyxJHOB9Z2nAi2z3QGFG7LKK4tDuPiurw/6yAOuTIYM26cZWTbMJ7P9QQy0rUHDdVurqjURKP9zd5N0QLWbxlEJLXIcaroPa0bP0erSqdX37FI++L55AkMG35dQ0DL0sAOc+dR3iAVqbJldJHmx8dwA/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNm7XWi09CqY85rY2kFD8FMhB033ECfW1i/cyeEYmzc=;
 b=Y+k+G8CFyx7mrlla2TgWqhTs9g7hYqg0Y73PuCNn8oXMH4HC7LChlpcON4yo98e03QbPLaQYFup/4nnDnvyUCJ7nnAgqC65FN415vT1m77oVz9wn5q1dUpOWOcqScyqaJMcdCMOrZSs02lJN5ahEQjpu8nNFrQxsSCwZxfX6b/4EDKhiZTnnHt7SlYmc+xj3INJKFdB9s9OHNZv/wkQrGQr2d2//LdYS0IwAH4BLv6TkyDJxge1wN8VH5GCaHuyHGO+sXWY5Gpdbuzyd5Y/IMgiwy4oIH7h704Qbt60CjSWHWnqPQIf85nPmS0KFc4mT2z5hroZwR+6zuBIQ/DfxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNm7XWi09CqY85rY2kFD8FMhB033ECfW1i/cyeEYmzc=;
 b=ypBQu7R118KnbGANjUN9J5TIdfCVAgtscUUPVqiOiWo6DbZc9169VpEsH2ebqzCnnEmIIK9pyOVTvJc9noLAsUmocBhe32pEW72xaHivbygO8gVOCpE9EGDgG710jBg9H2UtaXiG5KvYvpn75VJSVBaAiSSQoqZQ29AlntTO/Ok=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 07:06:09 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 07:06:08 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add memory vendor information
Thread-Topic: [PATCH] drm/amdgpu: Add memory vendor information
Thread-Index: AQHZzAoIeo+rqIr0CEWcuA65QX0a1q/kh0Jw
Date: Fri, 11 Aug 2023 07:06:08 +0000
Message-ID: <DM5PR12MB2469D6AB6C6D65195AD71C23F110A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230811041157.652427-1-lijo.lazar@amd.com>
In-Reply-To: <20230811041157.652427-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=890807d9-ccf1-4bde-9c14-b02a36f7f9dc;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-11T04:52:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS7PR12MB5741:EE_
x-ms-office365-filtering-correlation-id: ed96224c-03f0-42dc-5953-08db9a396ff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f+9PZR5UvdBCtCuj0A8DaEZaZ8OHaQKMXBrEE9PIkR8xICcjGDvbywYJjzZwyxYNF9LnDF6KJt1TEyhOEnk+1+VD7tuRupf78LXOfWbOO1EsVGadIbfCH1MBgSO6J+TSLFBcPjqnBklrLu+ESDpl6ePOcMk9ZkKb7jjZvLaZF1QjgTMx5rEA+LViI/DJWW1CydED17ZsnCmH28cKkQgsw7xhRtDsNPhMNVTRYoRZqxwYFx0uwgzCtvSo8zN2NlP/bDHOa5HpNzsaBZEmt41CIUlwfxFBgoEuWJWBt6l1moDvifwQk5qSd21xDKVv2HodejoSKx3v1++xCRIAQzz1BiolQau0oL851VWZo+gLV4HVpP8HdXzhlZkybbhHvAJyoImGtKejYr27SIZAgU9l7pO7ihKmOhgP0HlRSqiF/N6Tym9vwPOTJzSCjpr48eZekFRikbQMtKRpVbV7Quxoxs8cU6HML9Tprvb4Kn0BB5WS02TKLsdS41ZRTrziDPueS9IDOFunalNtljkmEIz70XRXVXW4qy1HukcVRK4sUQTP8AjNm8JXEylBl+WR0NyyElQRHTn/F+9wTEzATIWWvVFAw3hGTPcFJo/H0tDDKlX+lnJZGDfkTVteodacPbQ1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(39860400002)(376002)(346002)(366004)(1800799006)(451199021)(186006)(83380400001)(71200400001)(2906002)(55016003)(122000001)(478600001)(41300700001)(9686003)(53546011)(76116006)(26005)(6506007)(316002)(64756008)(66476007)(66446008)(66946007)(66556008)(33656002)(4326008)(38100700002)(38070700005)(110136005)(54906003)(7696005)(86362001)(52536014)(8936002)(5660300002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?35KHNCwxu2DIAPtDetSmLt8Y+fBohUNMMpN9ADkObuxIrO+OzCAkYTnXKoG8?=
 =?us-ascii?Q?NooxPgZsa2X4Y8YziTBxnLXSO74w2EC0tboMr9vd8gXr7tzvoOBZMECb9k+G?=
 =?us-ascii?Q?pyvo8uHTkqI8+G5a+eq3Jg4yB5lisj9pbrqEhyPSOUNAd8W924In+aih0U9j?=
 =?us-ascii?Q?XUb98gNRmLh5/OY1mojDi8MIg1Rw8l7177Bl+H7CJpgxLpQRcXAcegM0Ormq?=
 =?us-ascii?Q?TRQZt5I106952xlWFaK5zuuCG6cXSycZOcWzfupjnFhlwBg0/SWDDh3bWH4+?=
 =?us-ascii?Q?XlSV16Z5WZBBPxSQNMm2I5J30OEXWVF0Mbr8g7t9TZQ+Uzg1onFD5w5UkQy0?=
 =?us-ascii?Q?HckntKZzkdFakV6y2meSc08jagxHUPkQSYIxAPdLBWlsSQU9v5NgNpXiKnRK?=
 =?us-ascii?Q?Mr5vSeaep8YpEgWtLEnU6wuWvjmGYTxpgcPOqxCOIErcy9Kwl/HXJGYhVOoZ?=
 =?us-ascii?Q?O+wvbgcJjMX0/Ag0IHyRfGa2zescySAwJFigOmyufmgy9nSuT8ETOj2tFKnW?=
 =?us-ascii?Q?GFJQAhVbHi1wBKsvt5Z+oCn4kh6bLOxRej0kAy0CPJuqzZlABOpvvZAyfVCB?=
 =?us-ascii?Q?Sc3LyzqMBqIzpMC9atxF/2LN136bY7+G54KFr+YCtuk/WXXJ97HWHFzHPhil?=
 =?us-ascii?Q?jZB2vv3As5OPMZ3EG1D4Lqd0bwu8sSnT9lR/307oYH70+hmrQCJMNZ3bFpKv?=
 =?us-ascii?Q?hSBQoa1LzCOc9B7IwtW+lQyY234EfYdHypmE0icLAGIORuVB9Vc39mDzG2q1?=
 =?us-ascii?Q?xwaM6A3owqevHFCV8BFH1wjIXA+FxTNqHFIWR3YKBDUJ/9DvOOLDv+cHz2bM?=
 =?us-ascii?Q?sULhLlxpgmqINWTbLA5qES/CmuplTICccCIHNHLxWWw0l/mloISmo1ofiTjG?=
 =?us-ascii?Q?UEpGJHwck9HH3QbZA9Z06yAZ7rGD8BVzHbHmfDfdTO/4r23sqn5859Rz8Qrq?=
 =?us-ascii?Q?eW7Sh/1kss8/eXQBjK0SyoZF2If6VvNsIiE8z7vkdlyeD+22lgbkoluoSrTi?=
 =?us-ascii?Q?MuNwp8+56WcVTfifnXzX1hlm3j+qkK53G/GQwXWzLBkHjLEoUI76F9JmgcGf?=
 =?us-ascii?Q?r8s0XwKQxDzhBNlH60G4jvlLG9G/RN4+7Szdov3j2UstfAd884MhijXHjNKG?=
 =?us-ascii?Q?dTMi053FHpesv7tlJIQi6gHgdaerKOYbsrWTtPdt31hRsofPrrPrFz783c39?=
 =?us-ascii?Q?yOzIIBFd2mhMNsS6QJmZx2W0z/P4pinOcoa/ymJt8tNoZQ38Hqu4qLBN4p91?=
 =?us-ascii?Q?stcXKcqSDAx+jFdLHTNG1NuXV66hX+R4D0xO9FAHR7CRiC7H8IjoXehR/gh5?=
 =?us-ascii?Q?fJBX1C801IxQ56UJZQdUlz7a3jFPzITS67TwFMwszNLmZQLCULLs9ekgMAfl?=
 =?us-ascii?Q?fYomI0XHmJ4dN9okibkAHgx0Iegx/k8N4kr1+E5OfSVsNglMjtfV7caAyuSW?=
 =?us-ascii?Q?CmhVxHzLp5M/KL+2CfHcbJla+2rQP5aAM97McNuIgUZrH4ZEEh2hUaUxevyr?=
 =?us-ascii?Q?nzgvF8Y2pP21DsobNQtGKtTHKyOBmtfW2GK3svDKk9eTeJPDvLJHR89xbqm8?=
 =?us-ascii?Q?mCK+wP8clKp4QqMIPfY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed96224c-03f0-42dc-5953-08db9a396ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 07:06:08.4805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ggP7oBPdDHxZJb3y6V7PQUmHua6JB5WPi1dolF4NsBuLqDkOgeKLqHZGkibGuuK6LMfserXhP4GjZbgzFojIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo
> Lazar
> Sent: Friday, August 11, 2023 12:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Add memory vendor information
>
> For ASICs with GC v9.4.3, determine the vendor information from scratch
> register.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 26 ++++++++++++++++++-------
> -
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 880460cd3239..f9a5a2c0573e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1998,6 +1998,19 @@ static int gmc_v9_0_init_mem_ranges(struct
> amdgpu_device *adev)
>       return 0;
>  }
>
> +static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev) {
> +     static const u32 regBIF_BIOS_SCRATCH_4 =3D 0x50;

Any reason to use a static variable here?

Regards,
Guchun

> +     u32 vram_info;
> +
> +     if (!amdgpu_sriov_vf(adev)) {
> +             vram_info =3D RREG32(regBIF_BIOS_SCRATCH_4);
> +             adev->gmc.vram_vendor =3D vram_info & 0xF;
> +     }
> +     adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;
> +     adev->gmc.vram_width =3D 128 * 64;
> +}
> +
>  static int gmc_v9_0_sw_init(void *handle)  {
>       int r, vram_width =3D 0, vram_type =3D 0, vram_vendor =3D 0,
> dma_addr_bits; @@ -2010,15 +2023,12 @@ static int
> gmc_v9_0_sw_init(void *handle)
>
>       spin_lock_init(&adev->gmc.invalidate_lock);
>
> -     if (!(adev->bios) || adev->gmc.is_app_apu) {
> +     if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3)) {
> +             gmc_v9_4_3_init_vram_info(adev);
> +     } else if (!adev->bios) {
>               if (adev->flags & AMD_IS_APU) {
> -                     if (adev->gmc.is_app_apu) {
> -                             adev->gmc.vram_type =3D
> AMDGPU_VRAM_TYPE_HBM;
> -                             adev->gmc.vram_width =3D 128 * 64;
> -                     } else {
> -                             adev->gmc.vram_type =3D
> AMDGPU_VRAM_TYPE_DDR4;
> -                             adev->gmc.vram_width =3D 64 * 64;
> -                     }
> +                     adev->gmc.vram_type =3D
> AMDGPU_VRAM_TYPE_DDR4;
> +                     adev->gmc.vram_width =3D 64 * 64;
>               } else {
>                       adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;
>                       adev->gmc.vram_width =3D 128 * 64;
> --
> 2.25.1

