Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3DEC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 02:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 714AC10FE28;
	Tue, 28 May 2024 02:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DVbVigzE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E834E10FE27
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 02:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd0Pw+YXwoWjNgCNZh61sbY8vYvK20LR/LOZPg3GQ/Q8I36AMzD98XtrpdWW+21uwCSPiPZ6ClXRxhvyGZSw19KR+PyGuY0/WCRTjvyRQOMLw6vrijRom27bQ8nNf9Dt1rJfhpOOtkMW0PRnJP/aepMDW9cnuUfNDECMcn9hZJen2F34rhs9I54zKwSLwLe4eQZjb+uESMhXhaHxMOWSglk31+8KJDW7PFszpKSO68YSONMcudoBYchPorwQ9l4beldbuC9fQ61gHkGjS4h8TFZo8Rt8yEmi25FyIgyZbxA3CnbYoVyifjfednvwuuVtgRVTxloVUCs6PeQ4eq1+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgi3OvH2dsvbL2d9w5NsixPZ0IDmtMyXluG3PIW69uM=;
 b=QDvAJVGKylYleNeCcV1L6tZatKe+oy+CWUXFRTwX/7i/O61YCC55/QqQ/6KDRtz1b/iUtxMLuFW22N7aJE82TQmE7zAdJziB1NNhysezu4V8SageVdf/+86LwiSE3drLSTJezn7q8ACpGkIivrk/KJ8ZgnVshucXz3mX/7RZ/KTFzK92dJ0eR5Tne4w3/zpZXuNgf+QLkqBxH3E8jQLGShovBtbGrzfZ7yySFnEp79O5Mtz8cwjTvQ5PXRnayLKrwttD3G0ZJCqni5z9qNeYL92sq+RJa2nKxdBe1+835uNThuoP1ZTmXA0FzSSilzfJs6DdagThvH1ZWu8ANeAE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgi3OvH2dsvbL2d9w5NsixPZ0IDmtMyXluG3PIW69uM=;
 b=DVbVigzEk6CvMNoG0jtQ3O/JsTCa97HHjlffJLv6J7n9agfqDZz85tioUl330eQLTLjjBoQefeurtNOCxPE6KDIeXLDzW8C3dvvbVzEegGlD9yzoAo6/7t4rc/Khygx+dKF3Dch5tYeFSccxtohM0Th1F1PmmU19L4v8Dl4wYO4=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 02:41:20 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 02:41:20 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Estimate RAS reservation when report capacity
Thread-Topic: [PATCH] drm/amdgpu: Estimate RAS reservation when report capacity
Thread-Index: AQHasKXdr1KO5X4yUkGcq9Vto2T77rGr7yjQ
Date: Tue, 28 May 2024 02:41:20 +0000
Message-ID: <PH7PR12MB8796C4D9039EB457342B604AB0F12@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240528022051.27099-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240528022051.27099-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=41a2dad1-5f91-44ef-ba83-a6dc24bcf7d8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-28T02:39:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA1PR12MB6388:EE_
x-ms-office365-filtering-correlation-id: e024d1ad-5602-4b54-816a-08dc7ebfa828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?SBmVzLqosCvoNqsMPNKAGtIPsF9Q0sT0ETO63N9XDvy25ccWU55tq50Ky52S?=
 =?us-ascii?Q?EP8RdPyGmPRQQ3wYO2r0iIGq89S4NIio1ieW3IYRMuYBbG6HnzFTwT92zGYM?=
 =?us-ascii?Q?/Xbn0/9Q5GgOYtkKHEE0IawimMja20Qe9pA1L6x1Gy3DVayRLWUpw1O1y3ly?=
 =?us-ascii?Q?raWyVu/1W2L9XFDT3xlvaJR2ahnrVVuSausj6G4m1nU3HDNd39L2t677SHKu?=
 =?us-ascii?Q?DCMn7UG81wbNicIjhz0oWwsz7x/xJmbeelm7wbD6r8QGKrB0G8zmxWlF9uib?=
 =?us-ascii?Q?DqaGkJav4d5RQPQtWWCCGCxIjDljW4FQpFDksgQ+nA5zqWxAgzMhDWao27UF?=
 =?us-ascii?Q?+PMwQnZ+5rbsHwR4BXj8U66ww8537wbQpEzcFVxe4ipt+4inellmEDBxN+r3?=
 =?us-ascii?Q?z8cJ5pk+5wowmt5b/l/CpVIb18AGL8fdUOUmmR4Ffa9dbiiCaWZocRGF6gjO?=
 =?us-ascii?Q?AfEoihxn2DzL1AGYK6q4aUSQtBplY96vFiLLELRmvR/UwctAqHMXyH2XDX8G?=
 =?us-ascii?Q?aW9pCrjRIxgMBTQbQKLrttT7wKEZwgzQjjhG97kLj4ObkLxa98FEcqL5AR13?=
 =?us-ascii?Q?9O8EFkZY6wkOzpyFM/UhBdu7uDJV/kN+fj3HDw7Vh6Hr/IfX33P8HhISvPcq?=
 =?us-ascii?Q?ddk+c1due493HJOP94nj4W5N0dv2jFi+d340xfIAxrl8vZCkqHiAfcEOe7P7?=
 =?us-ascii?Q?4R02mth6H56WJVWZJ7D294HUn6ctVI/eSrDrjMkXy/EAJ+QKEXZGZJiF5E91?=
 =?us-ascii?Q?Km2ytWTCXoxoipyotvcB1UciYf8X8w8Ntiq0IBhQqVfei09fsIh7+Qv4M4Q4?=
 =?us-ascii?Q?T5FLOqbKVcXrh5PJSDowjKGDb0V5zJMmhKoCztEEXf7mRXqTpWlu58fXlA7B?=
 =?us-ascii?Q?tMLYn3K23CSrlsUdGEbjc9hpI4F9ZlIO20+/qyDNUij86AvK+dRk8jEdF27a?=
 =?us-ascii?Q?g+tty4CDHh3E4UDcMF+XBtARwCZfROHbtGbMDHkZ4Fr737rBMQpGo9CQVvUk?=
 =?us-ascii?Q?KKnivVSVY3bPYJhy1YYcoc6DhgMdoUYXwRB3QrgSPIRXonFNhYAol9woVys2?=
 =?us-ascii?Q?7KZg/HWfSnrWUYRYskzshmDWiosBPvy0VP/QqdO3tnM80pTghTqgT//GDa14?=
 =?us-ascii?Q?ViyHSMflz0CbzFf7JkuDb8DVINdx9h6Frf0DyXuRx1pYsWmJK5iwi35j+Wz3?=
 =?us-ascii?Q?PFvL1Mnn9wqw78bEJDucgYp/3rjexiEu1jfMJda/X875iapGrsBkOK5hG0qI?=
 =?us-ascii?Q?cwcWKob7uiHiNGuKZwZXbVulpxMJQl6geo3/SIA0JZvPH+I97G8sA6timE0d?=
 =?us-ascii?Q?QEF9FpOp/MQ96HjPfGUASeFNnoVCBZ58ygFc5IUOe2Rq9g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?768HjM3IT9lRY+1pBztKrP/se3fkebmoXtYyh1H99Ggu+GCS8FatHWkr2gGP?=
 =?us-ascii?Q?+guKZvYwsNLRMMOIDgEzohQIMph8mC5ikf018207ME4MSn1lP854nzrD0tRN?=
 =?us-ascii?Q?iGfkYHVuXQvtyqJQfZwKHMFpyxStkfp0sCsmmCyazTBOwNcUbvbm1KRAU6bi?=
 =?us-ascii?Q?PB5tNAMZYAzh0rHiZtYt34VmaasYOomKG5w7o6vLzPxcY88EYJHo+bIXOfNq?=
 =?us-ascii?Q?5NJUZAXL5tgBDYu2i8mcDq5y/aVlDJXWH0Kz1vjh60RjKejLXgLi93ZqHcri?=
 =?us-ascii?Q?GZemqTYsl7FNN415hCPjesdq7HdEJ7Cpnt6vWwd8wg0UNKFWf3Q1eog7uzBp?=
 =?us-ascii?Q?1xIKiMAgkst8ySIYcixwycBmar9Ze7V9iR2P25JCvWh1qW/aTcv/7V9eu8Mh?=
 =?us-ascii?Q?NqWmDb75OUpV5otRUP32/LDrn1hIy6tmcXVK0nXngGizyGmBs6rcfronghad?=
 =?us-ascii?Q?HnKTpfQE1uSADHxW9ix58mGFal4GZcO+B9dOFpuZKkFcyei/cVx+QN3Yja+m?=
 =?us-ascii?Q?qwofrisnfzyqbvsSEnx09SdjDp8hx17OWtERxqXz3G3OJIfE3wzypoZG9ipL?=
 =?us-ascii?Q?RrhBcGBdKe86onacH0EgJ91dmnvbiYD+/alSXXm2yUBHqdDSqihqLW9gKpCl?=
 =?us-ascii?Q?XkQ2jJwYxkMoaALxUKc2SGZMRLxiq0yPUOgNWolJL/4kjfNB2U0msKFU5/e0?=
 =?us-ascii?Q?MihmNrV5tmRnLv02MgyjjZQtolQcG+IhnJk/4MHJpCDlEsteSuS6Np7eoBpo?=
 =?us-ascii?Q?Jx5DYqK7DFIW9Hyz64Rw45HjkS3Z9FJ9egMDCgBPNPeHTpcHz1C4+r55IchV?=
 =?us-ascii?Q?fZyJYWM3o2sB4GEiEK8bEUFnNXK9G/JgZSXi57lawEC59kTV4YX0McreZTmm?=
 =?us-ascii?Q?UG+rNluIWQWwRpYifp1b+g+OTW3YHp4Rn3HJSaQUGY4pnHa6yJjXJB0JQeFQ?=
 =?us-ascii?Q?9JnoUFZLSEQvezKql1YdMofTEfsHeLyvYPuLWBisk3AbtzNWHN6XsrwhKgCs?=
 =?us-ascii?Q?IJvdwfaycue42yVfL2i/HhM54LcShSPZ7U3QzhYZYjlqqtEguJUnneWA4Z+Z?=
 =?us-ascii?Q?3Bp+XB70mgh/M/jvk3D75aNbTjuH8qI7sHw+DdxBgmge2XnSSM7Vnkjm/2Kf?=
 =?us-ascii?Q?WR4TbIDwmgV+yyU13tlsVYmZbs2ZzzEbfxsQZw+ANAv3pcmd4vghCa2xkheJ?=
 =?us-ascii?Q?vm070izI/Ay+njaBHB3sDuhJ6mYI9zz4riespkuPzZBBq1OskF1TiSBtlRdp?=
 =?us-ascii?Q?JnmhffXT9MHW0GCgp2iNXTTH7V6aquHIS3bnQK3/D/ZfHhm3U19SAgOZadqX?=
 =?us-ascii?Q?HwjPOp0WaNxTLyseHb32B5htgor5VkpX0ISyGXdILIwBvODXQroHJQCX2EbL?=
 =?us-ascii?Q?zHjDL4YCkJaLArhUvPzXTCHFmMaJ1qvaj9VIXkOaj+TS8tdVYwZlZNJW3PZF?=
 =?us-ascii?Q?QteWrm90gmScbCIY4oL1fBfpli65oKcwuJTh+4tVNhImxPAxhGavYNA1vcuf?=
 =?us-ascii?Q?0aCu4KBJRS1P89ttEK/uj23vJjG7S9UKENH0lKE29BqRkt27fGviIFrJVbOu?=
 =?us-ascii?Q?I++NwcsCFKfYNAWCtAs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e024d1ad-5602-4b54-816a-08dc7ebfa828
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 02:41:20.4716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5yRTl2zCRGjMrKiJ3cxsV4jcxZw2yIiDXRfDcGNAQoCb6jrL2RbQBkVMVHSUOouM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawkin=
g
> Zhang
> Sent: Tuesday, May 28, 2024 10:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Estimate RAS reservation when report capacit=
y
>
> Add estimate of how much vram we need to reserve for RAS when caculating =
the
> total available vram.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h        |  2 ++
>  3 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index e98927529f61..ad813772f8a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -173,6 +173,8 @@ int amdgpu_amdkfd_reserve_mem_limit(struct
> amdgpu_device *adev,  {
>       uint64_t reserved_for_pt =3D
>               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     uint64_t reserved_for_ras =3D (con ? con->reserved_pages_in_bytes :=
 0);
>       size_t system_mem_needed, ttm_mem_needed, vram_needed;
>       int ret =3D 0;
>       uint64_t vram_size =3D 0;
> @@ -221,7 +223,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct
> amdgpu_device *adev,
>           (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
>            kfd_mem_limit.max_ttm_mem_limit) ||
>           (adev && xcp_id >=3D 0 && adev->kfd.vram_used[xcp_id] +
> vram_needed >
> -          vram_size - reserved_for_pt - atomic64_read(&adev->vram_pin_si=
ze)
> +
> +          vram_size - reserved_for_pt - reserved_for_ras -
> +atomic64_read(&adev->vram_pin_size) +
>            atomic64_read(&adev->kfd.vram_pinned))) {
>               ret =3D -ENOMEM;
>               goto release;
> @@ -1694,6 +1696,8 @@ size_t amdgpu_amdkfd_get_available_memory(struct
> amdgpu_device *adev,  {
>       uint64_t reserved_for_pt =3D
>               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     uint64_t reserved_for_ras =3D (con ? con->reserved_pages_in_bytes :=
 0);
>       ssize_t available;
>       uint64_t vram_available, system_mem_available, ttm_mem_available;
>
> @@ -1702,7 +1706,8 @@ size_t amdgpu_amdkfd_get_available_memory(struct
> amdgpu_device *adev,
>               - adev->kfd.vram_used_aligned[xcp_id]
>               - atomic64_read(&adev->vram_pin_size)
>               + atomic64_read(&adev->kfd.vram_pinned)
> -             - reserved_for_pt;
> +             - reserved_for_pt
> +             - reserved_for_ras;
>
>       if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
>               system_mem_available =3D no_system_mem_limit ?
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ecce022c657b..a6334e0e62dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3317,6 +3317,22 @@ static void amdgpu_ras_event_mgr_init(struct
> amdgpu_device *adev)
>               amdgpu_put_xgmi_hive(hive);
>  }
>
> +static void amdgpu_ras_init_reserved_vram_size(struct amdgpu_device
> +*adev) {
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +
> +     if (!con || (adev->flags & AMD_IS_APU))
> +             return;
> +
> +     switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
> +     case IP_VERSION(13, 0, 6):

[Tao] can we apply the change for all ASICs which support RAS?

> +             con->reserved_pages_in_bytes =3D
> AMDGPU_RAS_RESERVED_VRAM_SIZE;
> +             break;
> +     default:
> +             break;
> +     }
> +}
> +
>  int amdgpu_ras_init(struct amdgpu_device *adev)  {
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev); @@ -3422,6
> +3438,8 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>       /* Get RAS schema for particular SOC */
>       con->schema =3D amdgpu_get_ras_schema(adev);
>
> +     amdgpu_ras_init_reserved_vram_size(adev);
> +
>       if (amdgpu_ras_fs_init(adev)) {
>               r =3D -EINVAL;
>               goto release_con;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 6a8c7b1609df..bee622c4268a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -64,6 +64,7 @@ struct amdgpu_iv_entry;  #define
> AMDGPU_RAS_FEATURES_SOCKETID_SHIFT 29  #define
> AMDGPU_RAS_FEATURES_SOCKETID_MASK 0xe0000000
>
> +#define AMDGPU_RAS_RESERVED_VRAM_SIZE        (16ULL << 20)

[Tao] it's better to add comment here to explain why the value is 16MB.

>  /* The high three bits indicates socketid */  #define
> AMDGPU_RAS_GET_FEATURES(val)  ((val) &
> ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)
>
> @@ -541,6 +542,7 @@ struct amdgpu_ras {
>       struct ras_event_manager __event_mgr;
>       struct ras_event_manager *event_mgr;
>
> +     uint64_t reserved_pages_in_bytes;
>  };
>
>  struct ras_fs_data {
> --
> 2.17.1

