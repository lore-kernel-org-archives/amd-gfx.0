Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850ABC44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 09:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F3310E14B;
	Wed, 15 Jul 2026 09:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vH7ZFyMK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366E810E14B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 09:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD2/M2asXbnPz170qvXnp1944mFlMvfMqmFzDSPeMDBKAMuBvfTsnAuClbQEncowCtPtc8etdBGS8x+kNSN9F6aP6Nho98qaJZ8mB9RP8Gjd8v0cy0DwHeGesh9HflKUAAlA//uEsr+9VIHav0ygjq/dubSow0Uc1phZoRsRfilr7ATdVI4DIQ4+LEE+pUjeewhjJuinWcpwga8ElbrW2qp5IlCVjYQcuVisgkeM+F2+UcafusWjLDH7OUi9Yv9ftmVZue9YqNLVvPTTyJjeCGViKEGY5MbcEsDRJ+BZ/LTgdzt5zLYPCL27+UncWKmZK/KIq/odaIefxegg7jgtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Y/LVsYagaT4QWvgmkzf9qNsDmETBtMb6iiNDoIB6/U=;
 b=Zn0zAuioDwulMtc2zdgNFuapl4poQ7pVig5yAIjWZGiftel02HhxA7E5sAqFGDg2qVDQh7CiTR74Yt3e5V4Xu/XgulhxCik42W02gVol1Sam6HP8sqX/HNrc+kz1RQHRO1CRr1Igu3KtkkPgtewQwB3RYUWYZhJ6e7ASWBqm6pwAdWJTvGTHMs9Oz23YOeeu8Yf0mY0PKGAw1cw3k399C9xHTT7O+uBRa/uGGdGonzRgrZhKLCOx0sV2nE80o6FbBOxsa1Ik0bzvgjApZZYzog0KwbP7nRO0Hk4UxLYVmfe5MBi/ORDaqmXbynXkYP6kbqN7j+LkdthZ4A0U3WVhSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y/LVsYagaT4QWvgmkzf9qNsDmETBtMb6iiNDoIB6/U=;
 b=vH7ZFyMKRmCp2x44qXwd65csb39cYOfi3+0mMHmWSUgBLJp1ezNlmKsKXl1sMytVxs8daYQNTxIuIOSTi0sFygs4Pxa616J05UN1HhM46vFUgjvl4lVX+nnKuPoJlEpOd9LzxR7OcbDIJ8lJqcuzM3yf5ImnQ7XH6Y/dLCNnOww=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Wed, 15 Jul
 2026 09:12:36 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 09:12:36 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: properly account for resets with user
 queues
Thread-Topic: [PATCH V2] drm/amdgpu: properly account for resets with user
 queues
Thread-Index: AQHdE6k7j2yunl5WRU6wl5B7T8ph+rZuSo1Q
Date: Wed, 15 Jul 2026 09:12:36 +0000
Message-ID: <DS7PR12MB6005FECC803E37B018425DB5FBF82@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260714155516.684775-1-alexander.deucher@amd.com>
In-Reply-To: <20260714155516.684775-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T09:04:26.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH8PR12MB7207:EE_
x-ms-office365-filtering-correlation-id: 125e9a72-f14e-45fe-ef3d-08dee2513637
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: suWlTyh73Jd73CgM7GvIbvq37VbnJFM2fXEltFhTVB9JC/InMYG+2NgUK7qI4vfIdyYDw9LPXO6H3D6695kKq2XfT0LOX/p/P3gOVUlC5DBgEfXnKmNJpbnmgMgt8EF4kERzQDmbAZR6C62Zl9ZVvrSNHUbT7BBirVMxxIloDsxtZUoBrgqUJxKmfsDmfQSlzv194d0aV2wRj9ZwLCf9nBvJUDEkgg7ZHWjtAfmdPBMP8U5LglbxHJA7wG2ghbyvpL1ITcpfxKDkiMr/jZQJvmpQxAA0kLlYDTrw530YXmcUkXk/jkSiiR3NAxBnXTWFzexuwpRbU42EAfJNcdklDoLu0rKpl4F+nQH/+geindXcvasJa6zjO7ue+FxMclTz8egPz9/z8Ag/4p5xS3r/D0FI6ZLI34REVe4PlKM+vitoHkGvUgvVWk7jtPI2ej8iQ8Mgkhvgk1uZgryZNMMXY7gPUy38e/l1KaIucBWoxBbwd7QNLi3KvdxZgvfKEuwQXt1vgneP/wxgmAerpqEdRAipx1jDv7YG4+NJCPQf5h0DOz3/0g1zZm2JA3RUVW2nwu/Juzd09bpKKfxEDus2pWS/GclFuirjDC9frhQyALyfT/a5dA5r9/tvqkFPlSwckk2N9375LSntvortVdVCBM5ZNOiIp8ifxAbzLcW0+OqB10NbVwBNZ4v+dNgb7Rilw4BuZqc7zCYf1TnQ73plxcCJ8k3Gvaw7P3o5Yh390Oc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ADvMhAGHH295iyisk87/AGm+92O4XnCxiOUpTcNg89WFHtTohelleW0ewBM4?=
 =?us-ascii?Q?PkYlEyB6s6GSlYCdJBBeyTLiUmy62PE6O1Hinv6DmfEf+K1d8pL3ohrGomXF?=
 =?us-ascii?Q?QdYL78PZJwazl4IWnLkf1DcOyvsRz3RuEIg8LEOXYapv1YwM5iAIzMi1p5r5?=
 =?us-ascii?Q?msSLF7zOpwHncnMHMKYQOt9kaUPffi98IOOuu7hQmyCLjGIYtkF1GC51B+JN?=
 =?us-ascii?Q?x++8IJfcOoDfw1P0P3chtbeyBUiWOVxLz1JO+n3GEeCWpu/1SE3oxkrkTplt?=
 =?us-ascii?Q?/S/BuYlKqDEGT5daCxSobE5cgM1zDq3RAjcHD1g/AEaGPNkcAb6zMS5KVeuU?=
 =?us-ascii?Q?rifdI1Er/D4bA9OSZVBHuAvO9vmfuHFSFLBJnk8td31+PYnyutoox5OtDp8R?=
 =?us-ascii?Q?+XqKAM/EdS/DKUQqAzLm/LteOpuLrhRMnXmJn9EJFqeRu37KU+kcwHSsdwHe?=
 =?us-ascii?Q?MSMzybERCGw0a3RlOQyAm1YY6HwKVQL9cvlu4K+BeTVJ7eH1ghyMk4bOntEg?=
 =?us-ascii?Q?M7gm2kIogACGZOF54V2oTFs8LR2/MCulerjU5hNmtTl6QbWB6bgCZNSNmXj0?=
 =?us-ascii?Q?5d6i9wftMTcIUuyZ0Fqx708yZpFlMNXMfjjOsOMoqi03gXIk5Pp/LcZyD6Ln?=
 =?us-ascii?Q?swM9b7xLn8r0CVGuQhT9PQUz8iGcYTEPUjm7TlnClP17LYfbcNwudazDe7Og?=
 =?us-ascii?Q?rAfY2OzwDwVM3d8K3danHREQX1/ltmI9qO5l22EClzfEiWZGMXJ5HZXZ/Glv?=
 =?us-ascii?Q?GG37dtjVl5WEtEl1jCynVoB/iK/zEkHAN4FMzilqFk9tjyjvAm841J5oDzGz?=
 =?us-ascii?Q?nLwOJmwZ2uibzF95UWaC+KkqIuXjtXo4vFKMw90sJBdv2qJEtnzTSdTntvW2?=
 =?us-ascii?Q?So25XYK0NOyC06RchPoVFqq81oEIDTuEGJRcjvaFgTodPoCtsrzJ8lZwK7Jx?=
 =?us-ascii?Q?qJFJpKba7RLPfcxJqBypEfQx0IBLzNo/locjezLVXtdqrlfzJzRJzue+4KDm?=
 =?us-ascii?Q?VLAEmB5Dl3GyZyxru2Fsb1/9iZ8cc3QaAwxtmoBqoSPy2INCgXa+Zww2WUyj?=
 =?us-ascii?Q?jbkBU5dIXswJDDCZiBZVyo20ddrl1ubroMXjgFSmGXfWWkmQfS3Cq0W1WtJg?=
 =?us-ascii?Q?DO8jjz8Pq/2qdxy485WVSDLe/KvlFM/UFXL/exz9SZI7/Ma0nmY/5ewU2xJW?=
 =?us-ascii?Q?aMNAS4qnLxc0fIcUoX5TOGnKt8TYzFgvOmB3X4OR4Fdx0Xxvti9Ro0ALhBF0?=
 =?us-ascii?Q?+p8+JQVhquIx95kE/QbH6oFu0hwLAsZIFbIgQ/oPnyBEfGG8zGe5mbTWpSGd?=
 =?us-ascii?Q?8nf91h5HRup7L0iCuRX35F4r17kOnVMAtC4Mr0t+4loh6OB2vNLBnxbk4AHp?=
 =?us-ascii?Q?3aKnPuahuuCj55kTKb0GiTQBwuiRoaZBeQ1nR2eAAOFRteuMh0JaBDVOI4Hq?=
 =?us-ascii?Q?tObSL6KWZLDhe+sZNReouBD90Ti5fm2dv751UNL/E50jf5/awBwzW+XBfSbz?=
 =?us-ascii?Q?uDhN1crLAgajYS3JxXXGYIQDUDALXf9hR1xC1JmmhJwty0yzSQoH1GL2pjJT?=
 =?us-ascii?Q?TreMtuGhHIFxoPa9rWkVLWZxfY2KMtyc6J0HiKEbTPcNkDvSQAQ7l1R3jAjK?=
 =?us-ascii?Q?EdKTtpR2iFpsgqJqx0E0qpowS6wrHNJJLAYjaXGTPKiZ7mMeTZzU3UXUnNQw?=
 =?us-ascii?Q?JFuWLm4U3nNKSqs9TXOtxFDgm6os9fXJROh8gqw79GJ5Duoj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125e9a72-f14e-45fe-ef3d-08dee2513637
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 09:12:36.2569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgBEq8W1HdUyFEThZ0WSjUTfXMKrfTLlyvlDIYeTSGBcjIPqIkF1JGEXvpjvQPw5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207
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

AMD General

Regards,
      Prike

> -----Original Message-----
> From: Alex Deucher <alexander.deucher@amd.com>
> Sent: Tuesday, July 14, 2026 11:55 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>
> Subject: [PATCH V2] drm/amdgpu: properly account for resets with user que=
ues
>
> We need to increment the reset counter, force fence completion, and set t=
he wedged
> event when a user queue is reset, but only for the guilty queue.  We don'=
t want
> additional events for collateral damage.
>
> Only increment the reset counter and set the wedged event in the top leve=
l userq
> reset callers (both KGD and KFD).
> This aligns with how this is managed for kernel queue resets.
>
> v2: fix task info refcount handling, align with
>     kfd error reporting.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Prike Liang <Prike.Liang@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Lazar, Lijo <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c      | 18 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c     |  2 --
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c  | 17 ++++++++++++++++-
>  3 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6aa75da27f912..58754fc41bb6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -123,6 +123,8 @@ static void amdgpu_userq_hang_detect_work(struct
> work_struct *work)
>       struct amdgpu_device *adev =3D uq_mgr->adev;
>       const struct amdgpu_userq_funcs *userq_funcs =3D
>               adev->userq_funcs[queue->queue_type];
> +     struct drm_wedge_task_info *info =3D NULL;
> +     struct amdgpu_task_info *ti =3D NULL;
>       bool gpu_reset =3D false;
>
>       if (unlikely(adev->debug_disable_gpu_ring_reset)) { @@ -137,6 +139,=
14
> @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>       if (!amdgpu_gpu_recovery)
>               return;
>
> +     if (queue->vm && queue->vm->pasid) {
> +             ti =3D amdgpu_vm_get_task_info_pasid(adev, queue->vm->pasid=
);
> +             if (ti) {
> +                     amdgpu_vm_print_task_info(adev, ti);
> +                     info =3D &ti->task;
> +             }
> +     }
> +
>       if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
>
> AMDGPU_RESET_TYPE_PER_QUEUE)) {
>               int r;
> @@ -146,11 +156,17 @@ static void amdgpu_userq_hang_detect_work(struct
> work_struct *work)
>                                                        queue, NULL, NULL)=
;
>               else
>                       r =3D userq_funcs->reset(queue);
> -             if (r)
> +             if (r) {
>                       gpu_reset =3D true;
> +             } else {
> +                     atomic_inc(&adev->gpu_reset_counter);
> +                     amdgpu_userq_fence_driver_force_completion(queue);
> +                     drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE, info);
> +             }
>       } else {
>               gpu_reset =3D true;
>       }
> +     amdgpu_vm_put_task_info(ti);
>
>       /*
>        * Don't schedule the work here! Scheduling or queue work from one =
reset
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index d3d79bbaf9eb7..a1371a9f961d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -234,9 +234,7 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
>                               r =3D mes_userq_unmap(uq);
>                               if (r)
>                                       return r;
> -                             atomic_inc(&adev->gpu_reset_counter);
>                               amdgpu_userq_fence_driver_force_completion(=
uq);
> -                             drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE, NULL);
>                               break;
>                       }
>               }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0419fe869d4b0..58ccbf955f287 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -448,6 +448,9 @@ int kfd_reset_queue_mes(struct device_queue_manager
> *dqm, int queue_type,  static int reset_queues_mes(struct device_queue_ma=
nager
> *dqm, struct queue *q)  {
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->ad=
ev;
> +     struct drm_wedge_task_info *info =3D NULL;
> +     struct amdgpu_task_info *ti =3D NULL;
> +     struct kfd_process_device *pdd;
>       unsigned int num_hung =3D 0;
>       int r =3D 0;
>       struct mes_remove_queue_input queue_input; @@ -476,13 +479,25 @@
> static int reset_queues_mes(struct device_queue_manager *dqm, struct queu=
e *q)
>       r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL,
> &num_hung, &queue_input);
>       if (r)
>               goto fail;
> +     pdd =3D kfd_get_process_device_data(q->device, q->process);
> +     if (pdd) {
> +             ti =3D amdgpu_vm_get_task_info_pasid(adev, pdd->pasid);
> +             if (ti) {
> +                     amdgpu_vm_print_task_info(adev, ti);
> +                     info =3D &ti->task;
> +             }
> +     }
>
>       dqm->detect_hang_count =3D num_hung;
>       /* When MES doesn't detect any queue hang, no reset happens. Don't =
signal
> reset
>        * event.
>        */
> -     if (dqm->detect_hang_count)
> +     if (dqm->detect_hang_count) {

We may also need to check the has_reset_queue flag before notifying the wed=
ged event,
since the KFD reset event is only raised when has_reset_queue is set. With =
it or not, the patch is

 Reviewed-by: Prike Liang <Prike.Liang@amd.com>




>               kfd_signal_reset_event(dqm->dev);
> +             atomic_inc(&adev->gpu_reset_counter);
> +             drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE, info);
> +     }
> +     amdgpu_vm_put_task_info(ti);
>
>  fail:
>       dqm->detect_hang_count =3D 0;
> --
> 2.55.0

