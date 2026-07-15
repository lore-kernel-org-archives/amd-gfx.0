Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CDAC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 05:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D70CC10E12B;
	Wed, 15 Jul 2026 05:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tPpYJN2L";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BC410E12B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 05:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2NBvlK2h4bQc2Kc6veJRpucFIAZLLJHfuilq/m6/ezm2+zNnwKr389Ui51ZQe1+nRWareBxn4MZPAndwVjmjlXQ7fnYoiY9P+V39zN8ljhLQfc814x+GPwFEhIT3yXGIKC0PDJkmzG6RLQMKoSG/IOGMWJLzBqAEuMfq/8LaSzsp00uJailMUeZ7cFqePyitiF4Ol+KaBXYK75D0z/Hoe/UqHkBtkZbnP5JB0ehnOcA1WOngSnETaYCQoUSlq6H6CRkBgkhIPhsmgRyMmZ2ZUK/iL68mFN7QSB33S59+uEZM/4W7E7d69xl0bQ5hqmBd561v59MiDZW+nflPRn17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wO25rTMPEd9HeXLi9O9gYq5dp7NO3q4IkYXezKHaiw=;
 b=H9ulcFSA7qbC6SnHaXCrqOtG0iQGAhlrXvrE2pIqyGqXzgr0DxSw6Xgh0lV8n2wExlIf77eWQAufsJhlf8l0LF1NO41sEPXRXnIEKdQaApv+JzqOM5bogSFx3LXaqaHJTvDskDQltCMxivXeG/kjBMh4tUR2Sn/MKVjHOZTv7FgTwfxYGIR2F+xDT91NAmZZVs61GO/6/4fbBjcxDiifOtlbR/YEhUXGX8VM+cmxTiaLmzbXWLEyYSaWX/XSiSVb3y6bDIg/yUmr6vh5/aO9F/H61mB4Akm2EuZxfFLs58DVKp0CNV/JeAnJAFHvBdkC9zOsi3VU4U6VIL8u9sksrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wO25rTMPEd9HeXLi9O9gYq5dp7NO3q4IkYXezKHaiw=;
 b=tPpYJN2LKNg6PH+juApTxpAO4X++3/8ZsOP8YYFoMt83GWV1OZxZ6AGTgBUh8fGgSzXD8JZg0/yC2pRyS/hQdXYlGBKkSNOTIOZObBKwPljvbU0INXI9WWHtC4EWqEbfe/bdg9Hrr5YL206937opCTibyz2NO9PwJG+GdLPtm2A=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 05:50:22 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 05:50:21 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: properly account for resets with user
 queues
Thread-Topic: [PATCH V2] drm/amdgpu: properly account for resets with user
 queues
Thread-Index: AQHdE6k4htvn/e0t7EyD58w2HLLNXrZuECdg
Date: Wed, 15 Jul 2026 05:50:21 +0000
Message-ID: <IA0PR12MB8208CE1C35C3748D3BCBC5A790F82@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260714155516.684775-1-alexander.deucher@amd.com>
In-Reply-To: <20260714155516.684775-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T05:35:25.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|SJ2PR12MB9210:EE_
x-ms-office365-filtering-correlation-id: ed8fffe9-2ef9-4610-ae8d-08dee234f574
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: zcj4GL78zB86aF+4x2KZMCb/uwS/OEpUxBWnt4Ao1ig3NxqtPQKjlfLWd1Oam1CE5FQUMKreZLW+MqH6zse/KzeuScDuUx1VGqFBlVljEeIMhZ/QSUcVtdC7aSw0MR9ay0w/6SFXfCaYxpPdfPhTNM1RslWSgzbJHTUdDEM1ZPj90Y6Ka5VaZ/0byfsdjH9sY4dt9BrqjR51H1mDpPNQMa66AEcp0Bhth8HTR0TV61azIBP2TZypWK19DVhb9V1XIqaev6NaGd4IFgCR8O7HrsVUWqUpirJByGK/NH5yaLKaRoBrMRWTUHNj+UrbhEI0hF8iHplkItL4sQU7dVQP80wfH0a8zSwhYJl6qd8iu7U6TB0YrRSqHGfyeIJ+U5hXDbKzMuDMDgSSTZ2GDju7HbX7yU+YCHZHs/c+Aid7Mz8Hl2SmGnTWWXC5QVQ5Bxt4Y2oeYmljqm9zc6D4z53qpm96nYvujBVrzF9VZ2FaUUNbf8DL32RmZopQNJI2ttmZifuvcfiDRX+arHw3V9U0kIWvZgv4jHkIUESw6cSVWHmRyzIA4iBg8yjihVMCGJQkSQh+beUoFgk5q9Wu4bddl7UPCE5QgXw7vbh5/RBf0xFLVqw0AadCCStkwvQYspG76iBp2Kj5hZLnw5wzkccasxloPB9y+eIDDUSN1TYbqlr1/ZvjLcYVyWeE4a5YwdpjaOwCwjyIFLCZoZWUpwRsI3Qx+cvGCRVFdB1VIyBO93o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+GxjDEfOgE1ElrUY2YwyjQXJiKbWqR4xd0/29UsqR1HBCIPkeG5GMzenjgc5?=
 =?us-ascii?Q?kLAyRySthC0H0envEBf2SOz11KjqIqjBwXJ99YB+8e5IcQRyijOB0XiqyDiY?=
 =?us-ascii?Q?SwwSeJRg/LP9/geYfELTPLplRYaOvyHJ0yJd/SfNRPn732dnI03YGgtj4soN?=
 =?us-ascii?Q?PqM3dLHu0OnSdvfMbVpYWx5pfaEKZ1LO8o6njPoEoCQHg15LYBNqLsoKfXlM?=
 =?us-ascii?Q?1nJzHt2UkPIEfcMPTUZby1usWMDZqRWf9kvHOMI63JRTd+AB+k9dIlq2cCF9?=
 =?us-ascii?Q?DHtXZnpLNtKq/v9Z57G4Z7zGRvx/yHPgIyUjU1Hryio28qmxgJKjLf5+TMVX?=
 =?us-ascii?Q?pJEQsstN8l+0r8xsPmIh8iBDebVJqKeafZYJlS0pHGl/k9Eb+i6NNJkpnRvR?=
 =?us-ascii?Q?tJycAzU9z2ZdtXbV8rzLc2LADl4uAKMZYWHuM7ta5Q0tyne/BqnZHL3/pm11?=
 =?us-ascii?Q?wqm1nph7/CjNq4+4+9t1vm3yDziixqNpfbZ+HfpkQOuqNO4xepDe4QirIxha?=
 =?us-ascii?Q?3BkqFb/HGJ3MzbFp3AA98D6sxyDMTXOC+2yRQvaYEs/FazLZFeXQK0E6ZaAd?=
 =?us-ascii?Q?3mSzGS4oEAW5PgqwfExIIrhIEGKBXIt3J+HwuGHuNgvZ8xEoHJ+ZD5MhNwtn?=
 =?us-ascii?Q?ynnUQ9O0db52yrBK93tRsTOFLXWJjQEB30DgS43sVZVf04wunrRKE35iCtNs?=
 =?us-ascii?Q?QCdj/ZIWsuWM0M9AwoEBjrMjIBovp9e5JkzboIKiDQi1q6u/MmZ05vu506GO?=
 =?us-ascii?Q?KEMX7OKrnHzxKRcl/nb4kumM6KuEbGxZzTcnnHyqqDSdEplBZt8XjiHJI5pp?=
 =?us-ascii?Q?XGY8Q8E+b7Prmia8lDLip7fQeTS7eVKjgyLH/yCX3gnkc1ejkQyLHfPAQpMJ?=
 =?us-ascii?Q?BwBJoKTsOkCtTlBg2lFW/FtNJ/y+zPIy5uy+wtd4MIr3leabCjGbqq5TVaYc?=
 =?us-ascii?Q?qp6QL6m5rFbC7BjNb+dee4xAPGkN3ggZ6UZnBkpJLiKOY6PNZOh/n80/CH5z?=
 =?us-ascii?Q?ldDfRkM5ak3PanQj0GAhWU6J0j9pbcvQqXYw2xBQ19gC7eiBs+U+WkrkpmU7?=
 =?us-ascii?Q?L782ht6JIR/DMjY+mL/QygzaoM/liy0G3WIibYCpB9wKJIo8nKJBTc94sZVg?=
 =?us-ascii?Q?vQm2RbWopPpA1dV5TpTJWq+Hb8nVckhH8LQV1FfyiNLDNkL8EexAY5nLxDz5?=
 =?us-ascii?Q?LXfsqY1b7y9bAWOnbOJbL+DAY8jt9PC/EYMMjyDlkhV4c1IWBTGr371vthmW?=
 =?us-ascii?Q?6RerzkPp+ZLzPZWsmPCvqDthBH+oQfdHjPtZ7J+Kd56UtWmK0OJC3s27056Q?=
 =?us-ascii?Q?D96JqzK0SWkwXFPkPhZFWjp9RzKDhU1OVkdVbsG8R2l5exFGwYXWpy553Wqo?=
 =?us-ascii?Q?bD392AnEAdt+MgSHXhF7OUTmOxedoZ/PBHTfO2Cp5wPO3mswtjgBz5FgwQge?=
 =?us-ascii?Q?Y4UyVVuJgcaWjCCyKBkLZi7IB7mgUxF1nwHFYZccPiwmac4uv+GbndquF2HH?=
 =?us-ascii?Q?Znywrbyj4ApwtK73VlU9v7osv6imdWvdpbBS9LzzSoP5gKbTSm3rG2pHkZDY?=
 =?us-ascii?Q?FopgUkua4/A2UzyBTpz2qonMDVCck60Ro/tzhn3CRtOC56sjXqC8joxF4RNw?=
 =?us-ascii?Q?+FBwY8qzBoavej0Xp+EwqT9iQLLhwwVFSwj56uzIzEanpSLIgG0ABjmrkl7x?=
 =?us-ascii?Q?FjpLHd+XQY2jeVf+wHtGEPtHcYapL9HJwg70vn5iIaEn8OrN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8fffe9-2ef9-4610-ae8d-08dee234f574
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 05:50:21.7079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6zZyKTAG22Um51WzBc5ODS0pIwiymoIwLHuDrlNGX6A9gN/PmPoz3Kz1kBFNKshBi7nu41yGTPRqwcSplN3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, July 14, 2026 9:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>
> Subject: [PATCH V2] drm/amdgpu: properly account for resets with user que=
ues
>
> We need to increment the reset counter, force fence completion, and set t=
he
> wedged event when a user queue is reset, but only for the guilty queue.  =
We don't
> want additional events for collateral damage.
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
>       /* When MES doesn't detect any queue hang, no reset happens. Don't
> signal reset
>        * event.
>        */
> -     if (dqm->detect_hang_count)
> +     if (dqm->detect_hang_count) {
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

Thanks for addressing the review comments.

Looks good to me.

The reset accounting is now performed only for the guilty queue in the
top-level KGD/KFD reset paths. During a queue recovery, additional
collateral queues may also need to be reset as part of the same recovery
operation. Those collateral queues still have their fences
force-completed, but they no longer increment the device reset counter
or generate additional DRM wedged events. As a result, a single
recovery operation generates one device-level reset notification,
which aligns with the kernel queue reset handling.

The task-info reference handling is also now consistent with the
existing amdgpu_job_timedout() path. The reference obtained through
amdgpu_vm_get_task_info_pasid() is released with
amdgpu_vm_put_task_info() after its final use.

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

> 2.55.0

