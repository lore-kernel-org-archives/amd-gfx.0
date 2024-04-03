Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C59CD128A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 10:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB2C1129B2;
	Wed,  3 Apr 2024 10:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gw1X+Z68";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2122.outbound.protection.outlook.com [40.107.220.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95BB112604
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 10:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diiLJM677H1z+Yk9dd8fbDPuiVC+jM9wXl4TcoyYpMrMxN/qdC857ZA5biDG/HiYNzp0Tm2R/GDmEi6QFofVyT1AWrXsf5uaoNx3AdAhKgO//BPfi4RCuUFZbVTSUTXgrwoRfS6TDSnceRgVer3NY45h4gG17O3S8uLJHpo7x+CnZDxRQ1pbJ5l8OVL86+dnM5l2U418pOMhjegvbLffYXY5sX90tJQNpHAoHu722WJn6IA1eUrxwxk/cTdFcyrI/17G+X90X3WSeKM06zJhepHpVcrK7JH4annAcr/75hwj7TPeGrZB2WSpW6MHG1d4akVGs/rIQON8fMdfVC4fgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCrl2ZJzowWMBlS/C37WetNHd97nsIshENzBLsnda34=;
 b=NZJWqHQMxzeXRQh5fAwBToEAvdJDMpm1NySVdNc9oIqWXLXuEx1o0ljMuF84DDtNDu8u4Qq+MlmXNobarPkb30m5PCJ1Nl8triYKlC/2DFkW1WNyQ/wVaQu8gbg5qvUZMvKzA1Gmy3R7T2TGieUPA3oyfWMDvch6eb3eLoNzT0ouDIbI4pFpD/e1I5oWYZ1JtHi7gUoWpiaHnwQuAjgqtvNUINruZW8UZj09ENY6vez2DbfQsLQGgoszbZXYdMMk7OuTVxW84KqJNLkLD5FGcwB9SpVIFnQMErnz1hsP+OVitGBPhr33nrvewunx96FvRmC+GR6jdAjFqRAA9RNYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCrl2ZJzowWMBlS/C37WetNHd97nsIshENzBLsnda34=;
 b=gw1X+Z682M2YVit49uiKkAxKlpzF1OEiHT+LIR08g8jGcgN+Zb6J2EGvBBSxm4qa2BYJ+pu1K3DoCCfbsWMpCcrffoqfNxwecXGJ2gEgzUbxJ4er5iD8xCK6ZXp8RkRVuvdWDlut0ee10Pug9kj62WeDU8DLtz26t0qnEjjPwr0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 10:35:36 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 10:35:36 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value
Thread-Topic: [PATCH] drm/amdgpu: Fix incorrect return value
Thread-Index: AQHahZWTSQEgzb5ie0e8rQ6E+eL0DrFWNozA
Date: Wed, 3 Apr 2024 10:35:36 +0000
Message-ID: <PH7PR12MB8796050C3FF06BCA9485BE06B03D2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240403070649.685497-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240403070649.685497-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a19a3b2d-bb1b-4ac9-b35e-0c78ab4d6bfe;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-03T08:28:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SN7PR12MB6957:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aIdhOoJeK0MZaaeFZZq1FAJD3Su2Y6m92iJlM86iwWABccdGV/OluuD1BeQBwr8Mo1RufEhXe/C5rCulCVhaUm7wx2x4NCDF7gg6c8imVmjeZ+Gi0qxmX9Zp696kcsDF0n+jS1PI7U17/BssVhqCuQkBZn2apuiqMBFbcQNMOgvc4ZCQdLCUYkSZxh+C4TCpwPJpJPMEysB9gX1dpznSwBirAS59k87Mbum2h0s887C2CZH9I0xq07W83UUpNViHNm7HzLq4EmZpP9fJmuoje9zQvSu2bb+kr+Zqlf7HiOx2iFrP3H3ch0xGNGWtrYEudcPx3ZXlKi4et4GAVM80kK16aqaV/2LhPLeyGlpfUaW3txYuTLfheT6/GJCgeiXLopvDJZ351G9uiqMtTaxah1mwfeDulUUOQKWpHuC6QQ5lcPnhpOh6km+kvyR3koswWg6BG4C0DYEOfuuy8bMIp+OF68JGYDhtuYHsUGXy+N9YeH0swZ4QplwuKoCyYSPcHy55a/9gcFXD6wiybMBSq3B64UpXlbjXZk5QfsSOODkplwb6DoWrf1HsZ9kTch6jLfrskv2hCasxcOgRG+N8hvpVP3tjxxawdxoDJW3GAFxdO0WYPx2UobJLYWCgykC01sYTFsNgWfeVohZ7AhGkakrYRpwYA8xgaOrfy+nJN8k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pW9Qjjxxd75bKWTVtBlAqsz0dN4tMPbcibYun3EZfb6LNy7ktuxZSUT+HArN?=
 =?us-ascii?Q?KkatiJXnt2sRWLQzqFgOrkmDIktvbjJKeeEnbfrcUWaTCPjb+6IiE55FUS9w?=
 =?us-ascii?Q?ZXxVinF9xXT5OeRp5JMj0Dsujb3HFopyzIcWvYDb3S+Z05SnURh8aikKRoZj?=
 =?us-ascii?Q?g6CUpsABwvN/KxqMB3haInenDoNDQDf7VQwVX09arhvmHk9sAyrQIZmOybr5?=
 =?us-ascii?Q?O0DUCUklSQ8qYEEZDIoGJSbqd9om+a1mB73RBznUlM91tMmMWonnA5AVignX?=
 =?us-ascii?Q?3fuaylb4X/Rj2Tp5tQ/cnHzTF8HXX/BF6ihTOP06jY4f36Fls/k/sp6rxL+E?=
 =?us-ascii?Q?C3o7PKW4Zi2JccU8ZwEcSLqjUALq/X+xMv1ufmiSjz+tVLgUizXBxF7HbNKi?=
 =?us-ascii?Q?al0ZYoDhGzktnDmZUrBm3g/4gPscsbyp9pdNtbToAQ7joXhGdtdyZZD9ze9E?=
 =?us-ascii?Q?m8SWMWkBtxY5iVrFqLMHM76IhC6/VvWJSMiLX3X3m9NsbrSjhsUAKDtMO7k/?=
 =?us-ascii?Q?A/1ppHVcn5BIjvEB2XYEezargbsAf6OG/XMuFvqLB3eLOz8VjtEUq0zaKUag?=
 =?us-ascii?Q?PTO2xBcelRv/cu+4tp1enV9S0rB/CFRKpLMw7TnVvxySmNIvSSOHsg7AeC2R?=
 =?us-ascii?Q?vQ07LuLAmK9l7VL6DyShCp2fpzG9UbDfmqlaL7AHq7Eb2pjmjZERu0VGs/ZV?=
 =?us-ascii?Q?risWwcoQATOcvCScPzTtRblC2PyX79nukLldnwSbcGq1JIx0uD4iIezRNweJ?=
 =?us-ascii?Q?jZNvWlFdNsWq3kEBS+kynjb/NZiWyI7/T6nT0sYB2gE+EUfQuHLJS4jdkqCh?=
 =?us-ascii?Q?UowE0lzakRGpXLJ6JgBkJLvVThVk71V6pmM9s3fG0Jw8ps+gPvriWAYe4F7e?=
 =?us-ascii?Q?ZpdetNon8RWKn3kirw1wYIKjyK505Hqe7RQtaGjSaW46dJBwEpAf6QqvSE8d?=
 =?us-ascii?Q?bQWBEcWA8pM3fgTfIs48/nbNIGVroxLEGmAonWs5Ns4+vkrvleLPQstYQx1j?=
 =?us-ascii?Q?sNZuHEY5ZxrvsaQoRJ5+vdOVGVwAiECdmOw1saahoxDXhcmC7sk4l4emSmqV?=
 =?us-ascii?Q?gpMBVk84z1C+XJu8XOAZukTZdW6qFDCu4urXJ2jqPgOG3dqVtQ/Y4nLsAYiA?=
 =?us-ascii?Q?3LDANApZnJppgP299gkvsEM10p/gmSjkflhP2CEp716+/27aEg+1Xxyh6Zii?=
 =?us-ascii?Q?jOlZEIbIalX3nYymWzcT8SBaztXJgR3rEdd7e2T36RNCwI5sNVULr2Fg3p61?=
 =?us-ascii?Q?uiZcXM/3mZEhvfXYNqPj27xe0KMpAMTJIbbjdTcjzGCeOBX2RZDMkwj+uzF4?=
 =?us-ascii?Q?3QFnpDiFEKUleOqCP4vgrw35MdAton3M8JnvGcw2jv+Fzan9GOuDVdsv68TS?=
 =?us-ascii?Q?zzV//7dDnvGZAtzApYDu3lcMPPwa+FPaVmUnhGa2pwx9gWPTITwEn6m2ua6w?=
 =?us-ascii?Q?IrMQJ0Isfs5YLxb/o/I2lSiI4HahFatiT6FPaJkSuFZeo6cm0/JOgCgUQ9K9?=
 =?us-ascii?Q?cFSCR2ly9JWODrcMfFaR7JgXjX6MWFrju255UH/F0ExgeyhkeROaaRyD1VXv?=
 =?us-ascii?Q?e+EqIzQdKOLTnuBdrbw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69cff6d-d61a-4323-685e-08dc53c9cc47
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 10:35:36.0305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoLjCc/OyywChocgSST9uE+D0OKD80ueSv+wBA+fh35Yss7LX9dkcfKRTCEJdSZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
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

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, April 3, 2024 3:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix incorrect return value
>
> [Why]
>   After calling amdgpu_vram_mgr_reserve_range multiple times with the sam=
e
> address, calling amdgpu_vram_mgr_query_page_status will always return -
> EBUSY.

[Tao] could you explain why we call amdgpu_vram_mgr_reserve_range multiple =
times with the same
 address? IIRC, we skip duplicate address before reserve memory.

>   From the second call to amdgpu_vram_mgr_reserve_range, the same address
> will be added to the reservations_pending list again and is never moved t=
o the
> reserved_pages list because the address had been reserved.
>
> [How]
>   First add the address status check before calling
> amdgpu_vram_mgr_do_reserve, if the address is already reserved, do nothin=
g; If
> the address is already in the reservations_pending list, directly reserve=
 memory;
> only add new nodes for the addresses that are not in the reserved_pages l=
ist and
> reservations_pending list.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 28 +++++++++++++-------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 1e36c428d254..0bf3f4092900 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -317,7 +317,6 @@ static void amdgpu_vram_mgr_do_reserve(struct
> ttm_resource_manager *man)
>
>               dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n"=
,
>                       rsv->start, rsv->size);
> -
>               vis_usage =3D amdgpu_vram_mgr_vis_size(adev, block);
>               atomic64_add(vis_usage, &mgr->vis_usage);
>               spin_lock(&man->bdev->lru_lock);
> @@ -340,19 +339,30 @@ int amdgpu_vram_mgr_reserve_range(struct
> amdgpu_vram_mgr *mgr,
>                                 uint64_t start, uint64_t size)
>  {
>       struct amdgpu_vram_reservation *rsv;
> +     int ret =3D 0;
>
> -     rsv =3D kzalloc(sizeof(*rsv), GFP_KERNEL);
> -     if (!rsv)
> -             return -ENOMEM;
> +     ret =3D amdgpu_vram_mgr_query_page_status(mgr, start);
> +     if (!ret)
> +             return 0;
> +
> +     if (ret =3D=3D -ENOENT) {
> +             rsv =3D kzalloc(sizeof(*rsv), GFP_KERNEL);
> +             if (!rsv)
> +                     return -ENOMEM;
>
> -     INIT_LIST_HEAD(&rsv->allocated);
> -     INIT_LIST_HEAD(&rsv->blocks);
> +             INIT_LIST_HEAD(&rsv->allocated);
> +             INIT_LIST_HEAD(&rsv->blocks);
>
> -     rsv->start =3D start;
> -     rsv->size =3D size;
> +             rsv->start =3D start;
> +             rsv->size =3D size;
> +
> +             mutex_lock(&mgr->lock);
> +             list_add_tail(&rsv->blocks, &mgr->reservations_pending);
> +             mutex_unlock(&mgr->lock);
> +
> +     }
>
>       mutex_lock(&mgr->lock);
> -     list_add_tail(&rsv->blocks, &mgr->reservations_pending);
>       amdgpu_vram_mgr_do_reserve(&mgr->manager);
>       mutex_unlock(&mgr->lock);
>
> --
> 2.34.1

