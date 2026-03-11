Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D2D112588E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 20:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF19010E934;
	Wed, 11 Mar 2026 20:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WLeEtaog";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBCC110E3F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 20:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8/O75nRSn00CPgQ4aN54ftIH1wWf+z5VVbiZwIpfF0Ibu43MqeW7XecoEngY10llRern2YTZGRAI22yBPRyR1aRMDmdivkNDVARK9ebGPp7YifSy7evcQhPs650ZxyOjohavFzjd+9vrgxKnAUbO52lRtrAEToWzq9dMAfB9OdquBZzwa2L4M0jpG/27sUIn/VM+HmWypflZ5QQfXyWztyzJcOrdSFsd/xdDGP71g5xh/zhpP7lOnAv3xgi0r5doQ9+uKrIrRHtEVaodVyeOMsPSdeS7msAk5j9zSXYCyqwIsyB85gecMdKPwdcfIBZan7liTo0BaiE/ADECvqKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtUQ0OtY+gWCJGT34W+OCb9ejyaAynf1yAFTaYSR+R0=;
 b=gJ9P6vwz2zV77myuK1upUxhNvPFsjmt8kZ1d9mDsYqZjf24DdXCUtPKPvBJdnJEkVBRW9znUvuFQD3mVMiNZ/dGVE5hjnN1LaLCf3HSmNmLCo8v2cxv91CieNsGp6vcc2hYbSBjNllUdkfcM7NslJ+zj3tO6TkqcWL9r2LAl9qxV1jRs/b4rdtbe4dg3Oi/L1ne4Os9jBkJrWRdDjIaN4IzWn7Ps526esAwt4cjCnJzuPUorbzDRozZrTJr3drXUT7/eFBa/xmfWjmtzq4t5NMQJL9B4n/oiPEqVrs9Tz6ZVCW5p/kBTT48aMn/MrF9njvtZOMLrVd7Oz7NH5gmewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtUQ0OtY+gWCJGT34W+OCb9ejyaAynf1yAFTaYSR+R0=;
 b=WLeEtaog8wcNAOiRVSzXlTKIM0s7D3vDORq+twV1fLw5q/DKcm3SU2kwO0pJXyLqDh00tLurS7Ym/O/vM+0GQ6yOWgtcxDXvI8tWO0o7i1BGdxTDtKIwpV26VLtUgBx4eAe09MtZuHGJSB58b6SvFUuY1xBqGLQksYIa1X08noE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 20:26:17 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 20:26:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Freehill, Chris"
 <Chris.Freehill@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add profiling counters in fdinfo
Thread-Topic: [PATCH] drm/amdgpu: Add profiling counters in fdinfo
Thread-Index: AQHcrLA1IgLbrX+SdkKlDPX6JZEI8bWp0Pkw
Date: Wed, 11 Mar 2026 20:26:15 +0000
Message-ID: <BL1PR12MB51440BE06F56435765EADB14F747A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260305145548.1253522-1-David.Francis@amd.com>
In-Reply-To: <20260305145548.1253522-1-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-11T20:25:44.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB9103:EE_
x-ms-office365-filtering-correlation-id: 71846f8a-4dc7-495f-2a72-08de7fac720f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: PJdebUVNLRa2i4vSDAG43kNS52M0I1UsC0F2pU1ZAhIbRjyMAGwQHVG2m2k9L4cnZO9QJEQBR0mUC0cr9qWLYhkoHaqF0prz7uEjX56X1X9s9B3ZdXdCoUn5efJnw85G/Gbk6lLMpPGIzYAUoxGk5fRn5+D4YJuj2BensMWaDpQBTYXfA1qSYbfxwWLCmTDy5AioEnlz43BNV1xt7HbrSl/ep6NUp9Olz0mN7IbIwNMzAiiegzmwmE1F9Kbv0ZPyjoBDXzm9bwkIVdvIavgahpsHbgylh9GpNLiGrHZnR80lwUJa72+xUst/pHTJekObWQ00U0t64cFtVQDAI6T7FMjlt7OVWDwUKVdtsjNa/pJcSBQ2DVQCYipoX6IYGo6rpBrrl6SnC+AvejXT7j+2h2F24hPy1c4l+4LgkNan62luCYXaJIZCRjKAaNGq8yUNmgFHeHHeeEIWbjhfYnSjJg+rECYMUKu6qDAQi4j/EBkm8t7qi83UupwDoaP9im24er/3VMeDiogMyK3zLJfbaKlg9juQcC8jtHciylHbSo5EcR02C9H6qs5SIybDnFkkH+Spn+ou6Znp9vkvcdrXhVjEzRw2tbVDS9qSr8Trn1+t+/gszjcTKhDO8rhnJq9TII6mVxLxtZjObUcOzKSb/N8EhwLtPnP/renjqeTlwBeG/N+XkHaSnJTAd42zzvmMQJVXt6etZh6S8SUqCqOTRLJOzUq9zWzNyiAIvSKcVJ8w5DaPHgjSs1ZyIVPTNpT1/g4EyD2OZsGbBzc4y2hmgZQJqaaWymic42wfm4HQZg4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K4ui6SJVCdFNlz/pr5EhUlwp2t0afhFcdVi1M5D0rBb/LRnxmLEVLoAR79of?=
 =?us-ascii?Q?1DL1s3J9xm8If6WI3+zXY+iWAjui85bc9jPxF+ky9eifEiw3RoPgOJexhXWb?=
 =?us-ascii?Q?l5xHnsu4rR79m9Pp/sixqG5IpLpop1ugVmjQe90/0+l2jcj/hgBcEQE/3i3I?=
 =?us-ascii?Q?3bY4eLqyKAF0bF0HSwSqjWtEfikC2IKQUzT+G8xZf/SS4wqdr+QSqYWqeOB6?=
 =?us-ascii?Q?Xm1i5lpRb0VhzRyr4nYPuLKoZi4dXVlDfNZJ8j70uOxgF7rpW8qGvqnBaaO0?=
 =?us-ascii?Q?yP1O5kMiBFUUeVLXgk0DyBBB5ByPnwnBtmlXUl2dN6SX5Dfvvg+PHjm78Zt1?=
 =?us-ascii?Q?N4Gp+4ApWcU1lMOPitQFeDA6+ScKkY6QzBPJX6BWciBmTXRKX6EEdlrPJFgl?=
 =?us-ascii?Q?XCPED0UT/aKulfSvt6bv06THKZRHkfrhBw4CUIAV0W9xpVMd8QWXvyqPhivm?=
 =?us-ascii?Q?Pv48EfL/l4mBqnr9fvlgvSLrNqbf5UdZGDKAfwSiYUG9ywvDyjZpSEyNcmXO?=
 =?us-ascii?Q?I06E9cqnvUN/Px5if7NKxY8XhISJlyiBauDIPbHaKxsRxEXsrLSLZVTvWC8V?=
 =?us-ascii?Q?zrH84OHu72PyNifbCWR2rB9DDBtFGdvvxCx50TFvrVr0Ni2jC0KCB0kpqzU7?=
 =?us-ascii?Q?qwAX2FCBey+tDrNiarIZfVA20QlO8Q6UOWPPgf9/oWoK+qgduoPoqRf42cxY?=
 =?us-ascii?Q?In5TrKRWu+Gf2mP7lG2ahqyWRL9hBwe9Qa3x/tMgAQt1gBSGTtqC2PIZOUnJ?=
 =?us-ascii?Q?kcBbwnnHH/FvfBfYROCNfCPFXZtZVDq3fKZyXYKzCg7bBey3yaciB4WH1vxN?=
 =?us-ascii?Q?itxdGyguQxxwr2ha+2uo7bpb/q9hTrIdI6KjcYz8CkXhwIBq6Opa7COYGrdx?=
 =?us-ascii?Q?y/ggDf5iSqra7eqP+YIfh1iwgCWUOO1y8sCl40zJ8E8WYjgVom3QGn83FXm4?=
 =?us-ascii?Q?cRUf0DLoWW6wDkWinjneN4evoYwdvg1G4EGib8Atd9Ig1J6a9m/To3mGM7ng?=
 =?us-ascii?Q?VRjRJlIvCtRPx3ElnwHNOHRMrteHBUNXO+imG/Bbzy9RvSxkhr2LWyYui5s0?=
 =?us-ascii?Q?pV7TVB4ps3vL01A6jZisDdYR+TIjVwdMjmnSjV/3OrYYIaSPPfDFL0nMVQ0s?=
 =?us-ascii?Q?hF9GDxF4YLSn++uCFLxIZvhOFGBRR9TEX0xJO4xbp3k2hVpsZTu4UvDEW6cK?=
 =?us-ascii?Q?yP1rjTkiSG7gMkN0JCx09YXEO/k4v8mi8lolJI+i7L88V3m3vbsTYhTT8HlR?=
 =?us-ascii?Q?2qdumTFiKd0lTpRtisFufZByb4ZzLFq6AfJP3lgCe3+/fdcFI9n1CZl45jnW?=
 =?us-ascii?Q?xRzg/qbS7WBF025YFUGcXjU+CtHnuSZEtPTf4bT4V2u1oPvd7qkNnOvUTtKn?=
 =?us-ascii?Q?yI7rQIKYceD1sOAIV+kkjJ3GcMvPZMzmassh7bk8YEsSSb8olwLu41DJgxZK?=
 =?us-ascii?Q?UKnb6k9in0pTY6DSkI476rTR3Var++T8HZVr8ESOnCJrCD3MIdAOFRtF7aeI?=
 =?us-ascii?Q?Uv828fvPbyCwNxT4UASsPB5QpU7wCBoNm618cOnQdivwiKYlTTcgOpkihUC/?=
 =?us-ascii?Q?BfpAKYE3CUqnHMPxC7LxK93ZC0XJX3OYKU+8PIhCQgCuhud+Zl3Uc6BLPvff?=
 =?us-ascii?Q?Cwm6p33ln9WckieV3BpzVmYG3QyVeHjRfYdONp4fopl1e+dPfMF4kZzs9ldL?=
 =?us-ascii?Q?sAf4ueR2ue1Wx1JHqJ0omw6HYNlJNUp1SBO1/TC1P22dPMr3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71846f8a-4dc7-495f-2a72-08de7fac720f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 20:26:15.7275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Smls3mRlikSfSH1BDelUU9f2x+1XLIp0AyslxXChoBRioBPAgpI6WrTft9BuTnPtLe8qy1/DSeOvO035q24zfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
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

> -----Original Message-----
> From: Francis, David <David.Francis@amd.com>
> Sent: Thursday, March 5, 2026 9:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Freehill, Chris <Chris.Freehill@amd.com>;
> Francis, David <David.Francis@amd.com>
> Subject: [PATCH] drm/amdgpu: Add profiling counters in fdinfo
>
> Add five counters to the fdinfo for amdgpu device files.
>
> They are:
> amd-vmfault-counter: %llu
> amd-queue-eviction-counter: %llu
> amd-svm-migrate-counter: %llu
> amd-svm-page-fault-counter: %llu
> amd-svm-unmap-counter: %llu
>
> These counters begin at 0 when a device file is opened.
> They are for use by profiling applications.
>
> Signed-off-by: David Francis <David.Francis@amd.com>

These looks reasonable to me.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 15 ++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  5 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 31
> ++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 26 ++++++++++++++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c   |  6 +++++
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c       | 11 ++++++--
>  7 files changed, 90 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index b349bb3676d5..96d6063ecaa8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -61,6 +61,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct
> drm_file *file)
>       struct amdgpu_vm *vm =3D &fpriv->vm;
>
>       struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
> +     struct amdgpu_process_stats process_stats;
>       ktime_t usage[AMDGPU_HW_IP_NUM];
>       const char *pl_name[] =3D {
>               [TTM_PL_VRAM] =3D "vram",
> @@ -74,7 +75,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct
> drm_file *file)
>       };
>       unsigned int hw_ip, i;
>
> -     amdgpu_vm_get_memory(vm, stats);
> +     amdgpu_vm_get_memory(vm, stats, &process_stats);
>       amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
>
>       /*
> @@ -114,6 +115,18 @@ void amdgpu_show_fdinfo(struct drm_printer *p,
> struct drm_file *file)
>                  (stats[TTM_PL_TT].drm.shared +
>                   stats[TTM_PL_TT].drm.private) / 1024UL);
>
> +     /* Amdgpu specific counters: */
> +     drm_printf(p, "amd-vmfault-counter:\t%llu\n",
> +                process_stats.vmfault_counter);
> +     drm_printf(p, "amd-queue-eviction-counter:\t%llu\n",
> +                process_stats.queue_eviction_counter);
> +     drm_printf(p, "amd-svm-migrate-counter:\t%llu\n",
> +                process_stats.svm_migrate_counter);
> +     drm_printf(p, "amd-svm-page-fault-counter:\t%llu\n",
> +                process_stats.svm_page_fault_counter);
> +     drm_printf(p, "amd-svm-unmap-counter:\t%llu\n",
> +                process_stats.svm_unmap_counter);
> +
>       for (hw_ip =3D 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>               if (!usage[hw_ip])
>                       continue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 82bc6d657e5a..ad1042639dbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -476,6 +476,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device
> *adev,
>       struct amdgpu_iv_entry entry;
>       unsigned int client_id, src_id;
>       struct amdgpu_irq_src *src;
> +     struct amdgpu_vm *vm;
>       bool handled =3D false;
>       int r;
>
> @@ -513,6 +514,10 @@ void amdgpu_irq_dispatch(struct amdgpu_device
> *adev,
>                       client_id, src_id);
>
>       } else if ((src =3D adev->irq.client[client_id].sources[src_id])) {
> +             vm =3D amdgpu_vm_get_vm_from_pasid(adev, entry.pasid);
> +             if (vm)
> +                     amdgpu_vm_increment_process_counter(vm,
> AMDGPU_VM_VMFAULT_COUNTER);
> +
>               r =3D src->funcs->process(adev, src, &entry);
>               if (r < 0)
>                       dev_err(adev->dev, "error processing interrupt
> (%d)\n", diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 001fcfcbde0f..9ba6f166cb5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1300,6 +1300,9 @@ amdgpu_userq_evict_all(struct
> amdgpu_userq_mgr *uq_mgr)
>               queue =3D amdgpu_userq_get(uq_mgr, queue_id);
>               if (!queue)
>                       continue;
> +
> +             amdgpu_vm_increment_process_counter(queue-
> >fw_obj.obj->vm_bo->vm,
> +AMDGPU_VM_QUEUE_EVICTION_COUNTER);
> +
>               r =3D amdgpu_userq_preempt_helper(queue);
>               if (r)
>                       ret =3D r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 01fef0e4f408..d7d82f23377f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1241,10 +1241,12 @@ int amdgpu_vm_update_range(struct
> amdgpu_device *adev, struct amdgpu_vm *vm,  }
>
>  void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
> -                       struct amdgpu_mem_stats
> stats[__AMDGPU_PL_NUM])
> +                       struct amdgpu_mem_stats
> stats[__AMDGPU_PL_NUM],
> +                       struct amdgpu_process_stats *process_stats)
>  {
>       spin_lock(&vm->status_lock);
>       memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
> +     memcpy(process_stats, &vm->process_stats, sizeof(*process_stats));
>       spin_unlock(&vm->status_lock);
>  }
>
> @@ -2472,7 +2474,7 @@ static void amdgpu_vm_destroy_task_info(struct
> kref *kref)
>       kfree(ti);
>  }
>
> -static inline struct amdgpu_vm *
> +inline struct amdgpu_vm *
>  amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)  {
>       struct amdgpu_vm *vm;
> @@ -3234,3 +3236,28 @@ void amdgpu_sdma_set_vm_pte_scheds(struct
> amdgpu_device *adev,
>       adev->vm_manager.vm_pte_num_scheds =3D adev-
> >sdma.num_instances;
>       adev->vm_manager.vm_pte_funcs =3D vm_pte_funcs;  }
> +
> +void amdgpu_vm_increment_process_counter(struct amdgpu_vm *vm,
> enum
> +amdgpu_process_stat_type stat_type) {
> +     spin_lock(&vm->status_lock);
> +     switch (stat_type) {
> +     case AMDGPU_VM_VMFAULT_COUNTER:
> +             vm->process_stats.vmfault_counter++;
> +             break;
> +     case AMDGPU_VM_QUEUE_EVICTION_COUNTER:
> +             vm->process_stats.queue_eviction_counter++;
> +             break;
> +     case AMDGPU_VM_SVM_MIGRATE_COUNTER:
> +             vm->process_stats.svm_migrate_counter++;
> +             break;
> +     case AMDGPU_VM_SVM_PAGE_FAULT_COUNTER:
> +             vm->process_stats.svm_page_fault_counter++;
> +             break;
> +     case AMDGPU_VM_SVM_UNMAP_COUNTER:
> +             vm->process_stats.svm_unmap_counter++;
> +             break;
> +     default:
> +             pr_debug("unknown process stat type 0x%x\n", stat_type);
> +     }
> +     spin_unlock(&vm->status_lock);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index dc4b0ec672ec..4a63f0384c7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -334,6 +334,14 @@ struct amdgpu_mem_stats {
>       uint64_t evicted;
>  };
>
> +struct amdgpu_process_stats {
> +     uint64_t vmfault_counter;
> +     uint64_t queue_eviction_counter;
> +     uint64_t svm_migrate_counter;
> +     uint64_t svm_page_fault_counter;
> +     uint64_t svm_unmap_counter;
> +};
> +
>  struct amdgpu_vm {
>       /* tree of virtual addresses mapped */
>       struct rb_root_cached   va;
> @@ -348,8 +356,9 @@ struct amdgpu_vm {
>       /* Lock to protect vm_bo add/del/move on all lists of vm */
>       spinlock_t              status_lock;
>
> -     /* Memory statistics for this vm, protected by status_lock */
> +     /* Statistics for this vm, protected by stats_lock */
>       struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
> +     struct amdgpu_process_stats process_stats;
>
>       /*
>        * The following lists contain amdgpu_vm_bo_base objects for either
> @@ -586,6 +595,8 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm
> *vm);
>
>  void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
>
> +struct amdgpu_vm *amdgpu_vm_get_vm_from_pasid(struct
> amdgpu_device
> +*adev, u32 pasid);
> +
>  bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>                           u32 vmid, u32 node_id, uint64_t addr, uint64_t =
ts,
>                           bool write_fault);
> @@ -595,7 +606,8 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm
> *vm);  void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>                               struct amdgpu_vm *vm);
>  void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
> -                       struct amdgpu_mem_stats
> stats[__AMDGPU_PL_NUM]);
> +                       struct amdgpu_mem_stats
> stats[__AMDGPU_PL_NUM],
> +                       struct amdgpu_process_stats *process_stats);
>
>  int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm
> *vm,
>                      struct amdgpu_bo_vm *vmbo, bool immediate); @@ -
> 621,6 +633,16 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device
> *adev, struct amdgpu_vm *vm);
>
>  bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct
> amdgpu_bo *bo);
>
> +enum amdgpu_process_stat_type {
> +     AMDGPU_VM_VMFAULT_COUNTER,
> +     AMDGPU_VM_QUEUE_EVICTION_COUNTER,
> +     AMDGPU_VM_SVM_MIGRATE_COUNTER,
> +     AMDGPU_VM_SVM_PAGE_FAULT_COUNTER,
> +     AMDGPU_VM_SVM_UNMAP_COUNTER,
> +};
> +
> +void amdgpu_vm_increment_process_counter(struct amdgpu_vm *vm,
> enum
> +amdgpu_process_stat_type stat_type);
> +
>  /**
>   * amdgpu_vm_tlb_seq - return tlb flush sequence number
>   * @vm: the amdgpu_vm structure to query diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index b3d304aab686..c341b6842460 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -427,6 +427,9 @@ svm_migrate_vma_to_vram(struct kfd_node *node,
> struct svm_range *prange,
>                                     start >> PAGE_SHIFT, end >> PAGE_SHIF=
T,
>                                     0, node->id, prange->prefetch_loc,
>                                     prange->preferred_loc, trigger);
> +     pdd =3D svm_range_get_pdd_by_node(prange, node);
> +     if (pdd)
> +
>       amdgpu_vm_increment_process_counter(drm_priv_to_vm(pdd-
> >drm_priv),
> +AMDGPU_VM_SVM_MIGRATE_COUNTER);
>
>       r =3D migrate_vma_setup(&migrate);
>       if (r) {
> @@ -729,6 +732,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node,
> struct svm_range *prange,
>                                     start >> PAGE_SHIFT, end >> PAGE_SHIF=
T,
>                                     node->id, 0, prange->prefetch_loc,
>                                     prange->preferred_loc, trigger);
> +     pdd =3D svm_range_get_pdd_by_node(prange, node);
> +     if (pdd)
> +
>       amdgpu_vm_increment_process_counter(drm_priv_to_vm(pdd-
> >drm_priv),
> +AMDGPU_VM_SVM_MIGRATE_COUNTER);
>
>       r =3D migrate_vma_setup(&migrate);
>       if (r) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index fcddb54a439f..499882a76581 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1375,9 +1375,11 @@ svm_range_unmap_from_gpus(struct svm_range
> *prange, unsigned long start,
>       struct kfd_process_device *pdd;
>       struct dma_fence *fence =3D NULL;
>       struct kfd_process *p;
> +     struct amdgpu_vm *vm;
>       uint32_t gpuidx;
>       int r =3D 0;
>
> +
>       if (!prange->mapped_to_gpu) {
>               pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to
> GPU\n",
>                        prange, prange->start, prange->last); @@ -1398,13
> +1400,14 @@ svm_range_unmap_from_gpus(struct svm_range *prange,
> unsigned long start,
>                       pr_debug("failed to find device idx %d\n", gpuidx);
>                       return -EINVAL;
>               }
> +             vm =3D drm_priv_to_vm(pdd->drm_priv);
>
>               kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread-
> >pid,
>                                            start, last, trigger);
> +             amdgpu_vm_increment_process_counter(vm,
> AMDGPU_VM_SVM_UNMAP_COUNTER);
>
>               r =3D svm_range_unmap_from_gpu(pdd->dev->adev,
> -                                          drm_priv_to_vm(pdd->drm_priv),
> -                                          start, last, &fence);
> +                                          vm, start, last, &fence);
>               if (r)
>                       break;
>
> @@ -3039,6 +3042,7 @@ svm_range_restore_pages(struct amdgpu_device
> *adev, unsigned int pasid,
>       struct svm_range_list *svms;
>       struct svm_range *prange;
>       struct kfd_process *p;
> +     struct kfd_process_device *pdd;
>       ktime_t timestamp =3D ktime_get_boottime();
>       struct kfd_node *node;
>       int32_t best_loc;
> @@ -3193,6 +3197,9 @@ svm_range_restore_pages(struct amdgpu_device
> *adev, unsigned int pasid,
>
>       kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
>                                      write_fault, timestamp);
> +     pdd =3D svm_range_get_pdd_by_node(prange, node);
> +     if (pdd)
> +
>       amdgpu_vm_increment_process_counter(drm_priv_to_vm(pdd-
> >drm_priv),
> +AMDGPU_VM_SVM_MIGRATE_COUNTER);
>
>       /* Align migration range start and size to granularity size */
>       size =3D 1UL << prange->granularity;
> --
> 2.34.1

