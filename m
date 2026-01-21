Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14D3C44500
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 08:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC8210E72C;
	Wed, 21 Jan 2026 08:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yDR9EBqx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 139A610E71D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 08:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuVoS4hCjL/LjuDHGGQ0Kn1XpGljGNePOtZefRGNDaVzeo42fxXQf1gqsOY8zgPto21XMYKgqZJ4znuf8X1W/BcprNnTunMHFhPH5824lGE46kxOEYF8DL/96tpT/M1leYbQfSaw3qAUN3jHJso0ecNPVrOXDwIQZ/ESS8sLDCCGj3gXdnOD4lhxsI2U8ngx5yrki7CHpqqr1UUAIImocHFrpcPCmGAgBZ3v+BeulryaeSUzeFbzDGHIdxl58O259ovWixwPnTe4sPpTQ0W0AmxzuTXNBTlg2Bkj3B4thn2g+ETj8siJqzuI7t1e9jFZddHgVo0BhC2TLvdNnou/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbIayRabejiduH32+x5fa93gzoJUAGo/gm/oFsm65Fk=;
 b=HptbyPPuaWwJyY0IIuxCX5S0cm5J5t/xKF0D/iEfnTa+mI3mRSzIgVmxPlEO2RN9cBiT4NfJWj3eiD2Ev6YpvQ9nnz3w3Vh1LvqXOZIvixzLhABcZn1Xn5DaLP72jDKhh6dXJ72jbN/UKWr6rpJGGGX2WVOSLEhKbm5xJJtQT8nuxbCmjnGRv4Ky4rGdzZtqKWI56tLYV1XVzA32JGTkfGrVWWVStSGnxDCt+3EzA3lDIO42LqXMqSYQaT4CZpbsguokGXlOiHssaU1sUAc8/W2wW/dveRT1L01D0hZit6Z3ZOBtTn0gt7b3tTjKbmjcBZeVW/ud4Cuh2oS0ybNC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbIayRabejiduH32+x5fa93gzoJUAGo/gm/oFsm65Fk=;
 b=yDR9EBqxuMwLSWppwNwItRZTVi7v3roKNAR5oSPtFihhbng/iU7r/mmehdT3qXvbdb+ZqSClxK6ZA8CJjz6kdGQHE1LD3u0PHhhu/otdHkL1kM6hhyRStGSqKII9AFPhaGmAWy6DsslDiVJZ2WqEFlg5kMaZCPjPGZtDVV955mI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 08:37:50 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 08:37:50 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 02/10] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
Thread-Topic: [PATCH 02/10] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
Thread-Index: AQHcioI8vB/GHY8CVUeqK7SsnOAtBLVcTWig
Date: Wed, 21 Jan 2026 08:37:49 +0000
Message-ID: <DM4PR12MB51521803FE5F8276966A1346E396A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260121030057.1683102-1-alexander.deucher@amd.com>
 <20260121030057.1683102-3-alexander.deucher@amd.com>
In-Reply-To: <20260121030057.1683102-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-21T08:37:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV3PR12MB9094:EE_
x-ms-office365-filtering-correlation-id: abf61a1d-b0b8-458d-13d3-08de58c85c71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tm+eUIkJTQdUHLoWxJUZA3EsTaSgoWcQfTOlk80DfPAl3055Dqcn6F225aTo?=
 =?us-ascii?Q?lohJTyDbeo9q0/7k0iNZO8DRSUPiNkyyJSBaNzKwYeWK0gh9vCZDrfTT2Wwb?=
 =?us-ascii?Q?/R5IZTiXF9kdsK+G1ram3noyKX3OKZcR04wHrB0CUpNFtZwKUw7v/HAwnUrb?=
 =?us-ascii?Q?HRVxwGVQQIKNWs+Zx10FM0kFitjFij9pbOAySdsjrd/OqSVUFUct2DMr/XyK?=
 =?us-ascii?Q?LvrVBw/hymHAwm7BkMkBSxumTK4SIMQQy6V3YbHj7ddjLSXmOGONDjeXIb1M?=
 =?us-ascii?Q?633XAaDy0CkGo23kevLVU7OFp4sFK55q6Sy59nwxAJhMfJB38Ctb+doemslX?=
 =?us-ascii?Q?1a11kAF9xxjykfVIv/w+tNqqmQEzbT7gBr5BEOHtX3aSGeIWYL5EYnnEMHp3?=
 =?us-ascii?Q?AltzlAESgnw2IyPpjTNqyCcnBggG+duOQcPr3ncwLS+uIZW43sakFAfoGtJg?=
 =?us-ascii?Q?NwKeSiFBz82b/mnUDx9hMZlIyP+pMF4eIvYvAttuIMy4b1kFg+BFh2tO00aa?=
 =?us-ascii?Q?ME2ld1wgZMhgCxvLdimElHl9j4URA1K9i4sdzfv4y15+yQ3ZN9paISg7iGD/?=
 =?us-ascii?Q?yQ+S1EpLQB1M7IR/k/QpOVgRCA7UETVY5aH6hYgdJDBRBiECwr8YdXgpcOmB?=
 =?us-ascii?Q?34LndWy1SL8uNEVk0YNJm7fVeWhB6db8KGZmFmDOp9+J2kPZZh3015DIp/Wg?=
 =?us-ascii?Q?GnWSvMMoCHDvCTycF0NVrN+xcx893GOq2lvn9sGABnDZ07TxX78R2yPDgKzy?=
 =?us-ascii?Q?v9fgj2yy4YlKxqE+k2MWoJKRs7DawL8KStO3jqmiHOZR3lnKGRebNPtUm/oe?=
 =?us-ascii?Q?oUuzRL0TQvNPFSimJvU5pO/EWcHZO3Owyzlij+OjVEmmNcCU19LHsnABuOpT?=
 =?us-ascii?Q?3EG/QalC+7AL0FHMgkbzrT3C7zfYUFEboXin4mvykCgJwrPG0Glbi9oQn8jf?=
 =?us-ascii?Q?lVRVM/Qw8hpZhJqVvvtN5fugxSWiybObQNiguIoo0UUSgFoPT1Ts/ehNzTSx?=
 =?us-ascii?Q?5B1uXVHUw8TorxSTUbZnFCGAiKHdsYzDLZSh8DMNy99EWqJ94d99iwq6b228?=
 =?us-ascii?Q?/uSgCBN4b43vvXBJNnvfV1cHWhTUGJawj5CLxzveBf6ORJX5WYUL83cDrMLP?=
 =?us-ascii?Q?qP+DDzwgp26eOkUtedtbSP1wI8j2O3eb0Ih+Rp9IJ795blz2fn6adMgk3V/J?=
 =?us-ascii?Q?+6ldIT5BbseB2HNsBm6ELj91Exw2UR9MrF6Q/WqYgd8Y/2M//ONhiHkNQvnT?=
 =?us-ascii?Q?rRNU5ZuI9YMxcPzKcYGdVYk4c1mDOY+K6a7PIaGHBad522m2Zni1DwB9NfON?=
 =?us-ascii?Q?76SbbElI2z0zNYVQVBZgWKhobDwdghly0QyjqB+Tn9XhIQPWFEfCBXvHfDrO?=
 =?us-ascii?Q?5wVmp+h6Hb9CuYx2mdiwhyTazJg9XUxT2kPQE5lVKhoHJ/bJZ3Yy3jy5k7h4?=
 =?us-ascii?Q?AwVbSjj4hq/Xy8WD7sJGRQyeCGcLPYx4sWD2A6a5mc6TcGJ7ELYTOG6JyR9Z?=
 =?us-ascii?Q?mp35M5B+nKkdtg6BDwUDr8t6v/uW47YfHbnCRDZ4U7t+FGg66sxaiZl1wykJ?=
 =?us-ascii?Q?9Y7IRzW1kZk5ha2D12aj0+gqVK44Yn52o922aH/YYghixf1KykIwkesEx/rj?=
 =?us-ascii?Q?jLD6LPOm4WNMhxAU7h2et6A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GH5AR4RmF2z4XkJS4cmijPTdejQ8UchSBzXSArd46QfO/4yZKtt7lqGX/0rI?=
 =?us-ascii?Q?u4VtNeGQ+nhi/CRNTWE10j/hnj8j60c9udiy3kRh4pRe1huAjJhh/6vewAOP?=
 =?us-ascii?Q?umZzXzzlj/nRQNKOoH7PW7XA9n9ojEx3+6FK+io+1tHwaUTJ2RgP6OB76ag/?=
 =?us-ascii?Q?H1XU8mGX4eMBG3+XBmNHmrja3kecTUhyF4evYdkmes92M0/iu0Xsa+7FTjKc?=
 =?us-ascii?Q?68+KjmUmNRJMCdNLcCKTU4bGNKcbUpHVOi34g037wy4e4uAbnvoT8My6oAwa?=
 =?us-ascii?Q?jx5ZSxkBTxJK4NrXWPQYDechL/2yonxk1i0LqvfG6KufgYt08/r1d9cVgDxj?=
 =?us-ascii?Q?z1wUYdhbNHF4lItMKeyEhhgSMg0LsOZsGc2SwIs1FXmOTUhvZBv8zuqlDce6?=
 =?us-ascii?Q?r5I3JWkkGyFM/5a8MpGw8ITuaH0Q1vx9gUOSE9Uucjasoju5AmpjU9yfS9/u?=
 =?us-ascii?Q?GkqV0SKkkyWjxw1vW3ZJ5RiVX9bUeCJHvh2PXKR7ZP4qwbBkJXN57dwm7NH6?=
 =?us-ascii?Q?/QMeo1XVGw47j8b9dPj/URjMWUc8ju6lw4JVoVJXVwSDjjVQZUpeGNiBQgzN?=
 =?us-ascii?Q?5DoytN+IYJOJD8vwUsKCJwLFohfDTLIfEgWsvglBc9UdiKQ+s4WDP4rrEByX?=
 =?us-ascii?Q?qQvSSr1w36Jqyc8g78lcZpVORPCB0E7V3k8issqAUEI16dSqsC3OpK/qPNvp?=
 =?us-ascii?Q?5hlFx7vSsCegs5mcgwmndVSt6sNQjgMG4o6kj7R+S7f9WmcvK8blLZs7OunG?=
 =?us-ascii?Q?ihe3y6urJMdnXyKvM/GuvgWv3hnvEUQ+jx1VhLCUpQWsptY/TJNF3Q204iXt?=
 =?us-ascii?Q?1fsoGFYyFDE81MuIFmGR40e8DdmLGhBxjL9h62xO+yZXYcFMaXy/FnIbBS+p?=
 =?us-ascii?Q?9B1aI/skStP0VBuyEySUUxqg+Sv35oXiQkiI9lJ1C0T0czrGbrq69wXLtvCV?=
 =?us-ascii?Q?7H73qq8y2Uu1xnt/KjY88HzNv69BITbLF9KFV/P9mzX6J/weU4P1domWJl09?=
 =?us-ascii?Q?qhJOeHD37AEh2YiTg4Wg8Eto52bwY9hMj+cQ9t4sQ54ZNxGKEaKxjmTV1fdv?=
 =?us-ascii?Q?iLRa1eN4BZa8Q2EZXBUadurxYrPMC5brXifRCvGm5eo6Cc1PCITWAVw/P2YB?=
 =?us-ascii?Q?npaaq4E3Rvsmj5nv9p09tayGkkUFpiqiI+kojr5ORiZuL+Ovg4QDtaJlrHu8?=
 =?us-ascii?Q?HJM1aQx2KaJS3j49QN/mGSiEHu6F2B2VARvCrkn9qXPCdX/4JhFRvy6S9RiY?=
 =?us-ascii?Q?CZ4GsMQ3edEZ66Hw/gi1o8CbSjkObz02zq7K4cApw5kqP3hRrRHYku2o2ZES?=
 =?us-ascii?Q?l/rE5PJnWlLB7mHanFiZSS274pbD68OvmwSZ3ES7Q2BTo1Q3hVtXQYrVS5iI?=
 =?us-ascii?Q?DQ9agUePJzsCfw7I3wXvgxeo71hMTr2hE/jCUplq+yBTti3HLxIn3jKsSL6f?=
 =?us-ascii?Q?JC7DXxBJAdTvAn1nYEXxbF7NFjcRK0EgkIOHVHY7+a4ndy/02FIgk3nO7jXj?=
 =?us-ascii?Q?RIcV5HcMFKcJZJUxH+7hB01FQV67jgDLEZzQLXFT8XUIUb0oiaHiYgaA8GXk?=
 =?us-ascii?Q?L7J9f6YS4a/mw5KnA6wyGIAJyYBilhCdgNa1Y8rW1V9dCUcuxSD6wZs4NSJg?=
 =?us-ascii?Q?bieYSu+KESNYOAt+gOhbYmor+TStq+UmkSZ+B67a/JILloshNT8qAvCgUByf?=
 =?us-ascii?Q?DRZE9zywN4olMdwVt/AVEZp0Dqbo53RjZV+5zUiDX0IWrM9L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf61a1d-b0b8-458d-13d3-08de58c85c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 08:37:50.0456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TbNTe690bp65d4xn4mz2LIeFw6j8DgHanlEKRsfDM27mQlu/+w49j30Bg8sbqNNWMprm5KPNDpWwjcgDV4VZCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094
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

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, January 21, 2026 11:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 02/10] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
>
> If we need to allocate a job during GPU reset, use GFP_ATOMIC rather than
> GFP_KERNEL.
>
> v2: use pool type it determine alloc flags.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 13 ++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c     |  5 +++--
>  7 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 877d0df50376a..89df26dd5ada7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -672,7 +672,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device
> *adev,
>               goto err;
>       }
>
> -     ret =3D amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, &job, 0);
> +     ret =3D amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, &job, 0, false)=
;
>       if (ret)
>               goto err;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index d591dce0f3b3c..4d53d9cb8490d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -282,7 +282,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p=
,
>       for (i =3D 0; i < p->gang_size; ++i) {
>               ret =3D amdgpu_job_alloc(p->adev, vm, p->entities[i], vm,
>                                      num_ibs[i], &p->jobs[i],
> -                                    p->filp->client_id);
> +                                    p->filp->client_id, false);
>               if (ret)
>                       goto free_all_kdata;
>               switch (p->adev->enforce_isolation[fpriv->xcp_id]) { diff -=
-git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 72ec455fa932c..d90966daf52fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -69,7 +69,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct
> amdgpu_vm *vm,
>
>       if (size) {
>               r =3D amdgpu_sa_bo_new(&adev->ib_pools[pool_type],
> -                                  &ib->sa_bo, size);
> +                                  &ib->sa_bo, size, pool_type =3D=3D
> AMDGPU_IB_POOL_DIRECT);
>               if (r) {
>                       dev_err(adev->dev, "failed to get a new IB (%d)\n",=
 r);
>                       return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index ec8d74db62758..8660e3d1c3088 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -190,7 +190,7 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job)  int amdgpu_job_alloc(st=
ruct
> amdgpu_device *adev, struct amdgpu_vm *vm,
>                    struct drm_sched_entity *entity, void *owner,
>                    unsigned int num_ibs, struct amdgpu_job **job,
> -                  u64 drm_client_id)
> +                  u64 drm_client_id, bool need_atomic)
>  {
>       struct amdgpu_fence *af;
>       int r;
> @@ -198,18 +198,21 @@ int amdgpu_job_alloc(struct amdgpu_device *adev,
> struct amdgpu_vm *vm,
>       if (num_ibs =3D=3D 0)
>               return -EINVAL;
>
> -     *job =3D kzalloc(struct_size(*job, ibs, num_ibs), GFP_KERNEL);
> +     *job =3D kzalloc(struct_size(*job, ibs, num_ibs),
> +                    need_atomic ? GFP_ATOMIC : GFP_KERNEL);
>       if (!*job)
>               return -ENOMEM;
>
> -     af =3D kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +     af =3D kzalloc(sizeof(struct amdgpu_fence),
> +                  need_atomic ? GFP_ATOMIC : GFP_KERNEL);
>       if (!af) {
>               r =3D -ENOMEM;
>               goto err_job;
>       }
>       (*job)->hw_fence =3D af;
>
> -     af =3D kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +     af =3D kzalloc(sizeof(struct amdgpu_fence),
> +                  need_atomic ? GFP_ATOMIC : GFP_KERNEL);
>       if (!af) {
>               r =3D -ENOMEM;
>               goto err_fence;
> @@ -248,7 +251,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device
> *adev,
>       int r;
>
>       r =3D amdgpu_job_alloc(adev, NULL, entity, owner, 1, job,
> -                          k_job_id);
> +                          k_job_id, pool_type =3D=3D AMDGPU_IB_POOL_DIRE=
CT);
>       if (r)
>               return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 56a88e14a0448..9de2cae966fea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -113,7 +113,7 @@ static inline struct amdgpu_ring *amdgpu_job_ring(str=
uct
> amdgpu_job *job)  int amdgpu_job_alloc(struct amdgpu_device *adev, struct
> amdgpu_vm *vm,
>                    struct drm_sched_entity *entity, void *owner,
>                    unsigned int num_ibs, struct amdgpu_job **job,
> -                  u64 drm_client_id);
> +                  u64 drm_client_id, bool need_atomic);
>  int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
>                            struct drm_sched_entity *entity, void *owner,
>                            size_t size, enum amdgpu_ib_pool_type pool_typ=
e, diff --
> git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 912c9afaf9e11..8abff5fdae81d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -341,7 +341,7 @@ int amdgpu_sa_bo_manager_start(struct amdgpu_device
> *adev,
>                                     struct amdgpu_sa_manager *sa_manager)=
;  int
> amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
>                    struct drm_suballoc **sa_bo,
> -                  unsigned int size);
> +                  unsigned int size, bool need_atomic);
>  void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
>                      struct dma_fence *fence);
>  #if defined(CONFIG_DEBUG_FS)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> index 39070b2a4c04f..1d44b95de7e55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> @@ -78,10 +78,11 @@ void amdgpu_sa_bo_manager_fini(struct amdgpu_device
> *adev,
>
>  int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
>                    struct drm_suballoc **sa_bo,
> -                  unsigned int size)
> +                  unsigned int size, bool need_atomic)
>  {
>       struct drm_suballoc *sa =3D drm_suballoc_new(&sa_manager->base, siz=
e,
> -                                                GFP_KERNEL, false, 0);
> +                                                need_atomic ? GFP_ATOMIC=
 :
> GFP_KERNEL,
> +                                                false, 0);
>
>       if (IS_ERR(sa)) {
>               *sa_bo =3D NULL;
> --
> 2.52.0

