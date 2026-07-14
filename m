Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CFCC44501
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 15:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 485F910E355;
	Tue, 14 Jul 2026 15:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lEKXJI0a";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89DB610E355
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 15:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAEsvZSbKALGu7iWLQCKRMpxLnB+wNvJqKOz2uP6Z2JQAYMvTnINAkqSE4K+Lh8T02OtyE2TOY9VGLd727pkPW1rHDVFVe+TQmGpQPQffcnFPjT96DSfFlb7GHUnBtvIFf9TEaPK6PuWRcSuS0E1k5UtG6qXAPCmRjKHbGFACGbD5KEmoMobuTXxs5j8JQUzvrkUoY8jcMkbkDAhLktMA4gVVREArffZsewoDxRYuOCZdc4tj4NMhiWQeB7N3C5yfzYKxysAlDmfHdbLS8sX6Djes5ipMHitMSCeVjYp1EeiIRaFeWqtgeZxOYWbkqgJo1CA2QWEn9gt9rUq8erH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jJIbt4sDcJR02NVYa5jcUTiHdBPVuEW7s3Km6O+sjk=;
 b=aftFOQS417pU79QyLxHseEokimgk+Xt5L76DZY8V3eEKpI21rJk8SdjfK11N74v6z1SX1RtihJ4bMaC/gYCTW9bIbBM1NKSO/f+tzoyhUFjaMaJwHQ9M/Hm1hd8qlg7B/53SDk/Nc+hFLj4X/bt7OErepalsieuS5JMX6MtD3lZH1QJ8vWzEmKLp6wlZ2vpVNIaos3BiUKszhtjU79fynMkFZZrq3QN2E5jFGoN6JehSwV8ZaRDSTjyqYnN0pPsYrD7iT8xRumuvMJjDYVyNQB10MDM7uBD59+2z9Mvgt0SonveSxLCDMGJq/0pmDwiHu2MBW6ItH6QNw6QTl0TasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jJIbt4sDcJR02NVYa5jcUTiHdBPVuEW7s3Km6O+sjk=;
 b=lEKXJI0aBRcj/Uqtn7EulZUMJ2nI11Pf5wDKMEWUEc8hMEqQvjJlCpcviV3GpmC8xHvw61xX/HA6EYR1k5OoLOvq9mMeCkvHKwWu1svr4GUNe2o0lU6O/Wr/fptyRyyO0Tik0DABSTevNb1ElS0LY63FeOoFJg6DGD3Wyd5+4lk=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 15:11:28 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 15:11:28 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: properly account for resets with user queues
Thread-Topic: [PATCH] drm/amdgpu: properly account for resets with user queues
Thread-Index: AQHdE56kvNhj4EVC10GtjFRhPNRZ5rZtGSjg
Date: Tue, 14 Jul 2026 15:11:28 +0000
Message-ID: <IA0PR12MB820835A0622B2BDB9DE560B890F92@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260714143939.680824-1-alexander.deucher@amd.com>
In-Reply-To: <20260714143939.680824-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T14:51:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|SA1PR12MB8986:EE_
x-ms-office365-filtering-correlation-id: 06ebef66-9820-4aa8-c7c6-08dee1ba2dcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|18002099003|22082099003|6133799003|56012099006|11063799006;
x-microsoft-antispam-message-info: 2W06W36YLL4UvqEyKOjiB37l+k/jxP9jBHFSycqWbv3GdOwa6AaXYWaCv+Cz20mKutl8Xxy6MhS2X7IVy6dknqtQ5XtQHZxiYa9HKGx754U4CSagUEQ1kC15CTJrfulzNg4W0XiTECjKljeunKt5CU7aVxVqLenMt2Uq5gHkZ1hbt/MtK7fweOQEV1uboZAiwGsTHFZdeL4p95JAWwgRlOytnKF5moCxMc4rCR5B6tEMonSWoYwJFrNh1bcXa+7u0UvrCuLhvsS8XVImHyBzF72klMmCtRkdfIZBNLLHx54Rug3r14yC0FyWocKfBQcK66V6R5irR7mIrwsh3JkzCfc/iFRKeC6WLOXcrUt8Exn2GwqfZjDT+oLI8uO+XVf/qMWmi3I2GPZFYP0+mkuiGTQmStcUZRNF16OlqZxbnBf8ywn15QH8hiCUBJJ1Onr5UvT/B3FAb0rcBVvPxYoR2T/llHUW4+UG/rLvsDwb05ICqRTvli2w/Vc6C0bKE/95yDPu4PUeceC/54BYqctSxBuH/3l6NHQtdk73uWYsh6eqFHK+rQFeeCuqSvJlG2fNArg/oYwjxd4PufTrodSzLxv9btEmAxmA8gFM1wMnSntxOiteQ0HFqCGFa2M8cnmD7EcfaXhC/ImelXKs6vxOqKe8FO3e8Z4Wms6gG9jGhic7V30jkxIW53fCHlJqDQ/z4J6GBOY6t4WN4nFg2tH9xoD5HpEY7pKalMX6M44sOU4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TsrhfAibbTIUyslzHphgSLVUK5kZFxNc8OJH5n3NbVLC1EjjzIFWnyls94KN?=
 =?us-ascii?Q?ZoivZXFzFmpZAERbFnKMwWMUZ9N5akOoVLkm+6CmflSZqvWhatA3sgC0mHa/?=
 =?us-ascii?Q?6LsjsNeqCp2I0QKxChZ62VFV3oZCRf13nvn0eklyWkBnJsNk0b4714xGsAem?=
 =?us-ascii?Q?x2Rs+UNCn9AD5tVeYd5DFlegHapqicBGw9Evgm58iXhQUMzMB+hQr6eG5pHc?=
 =?us-ascii?Q?tLIU8sPADrADXO5mjUVM9H9J+tZT0KqkP6IWmQewZh8zgVJqE8plCDHM8Low?=
 =?us-ascii?Q?K/xltYb/NqwLmwdrRhjBhxJVD39FU7kdJP+Aq7UBkFffxp0WldMMsGiID1Zw?=
 =?us-ascii?Q?zYnQU1CeDJwIcP/6HZHLkaHKcyhVIKBzP/un/AeMrXVAY47exoQX+DCi1C+7?=
 =?us-ascii?Q?LrfiVP0ENCzKURshIQfFY+fy8/ynFoN59luby+Orjh8S7UOyRX/voho8Kvuq?=
 =?us-ascii?Q?BhD1Dv3d91a6AkQPFTLwbvPiXvsg4moB+xzH0MxiGjTZRTaoKS7Mytbabt11?=
 =?us-ascii?Q?uGE3EdOmzi8xzpT2D4J/4CJ5u4wpMN2JpM3lLC2Kr+KUFoiEq0RNXChbnyCl?=
 =?us-ascii?Q?tcJUWZzFn80AGGF+eWl7If0SoxQ9GSeIUo3trULzZmcjXZ52D/8Dd6433tqa?=
 =?us-ascii?Q?9egN214fj1xjRQx1Yj8YXLol3p6r4l8xOK6J0KdJdeVBLjPhRyC6PXnpK/8M?=
 =?us-ascii?Q?aaZpNuL1wrPXUzpw3SjNelrmZM5D7VNK6aYh7weiL0yaIER+n4/5S6+0ZSHB?=
 =?us-ascii?Q?5T/rX5sd1Wxecmd2HuqmqvPsWzrhV/t7O1ZFRlr/fK77bYYrnzmGSgby9WV7?=
 =?us-ascii?Q?3nS5pAQpeCwdm/YhSO71vQgbO92rMk3X/eKjQpx/tX5TMl6xyFMmdQHwsAb1?=
 =?us-ascii?Q?3Fra1RqkjyumLcFRFyzhn+gFdF/cBt4KjO2vceRfF25RD5vai0mJb38nZqzC?=
 =?us-ascii?Q?YW64HspTz+KLYVW/IDJrLQSXl1BGj62sbXwgBH/qIbDwe9/YXTsM06MKwqgZ?=
 =?us-ascii?Q?Dge+HwziFaBfzpF5aSH/ri2xFAX0GemnZ7nwWK1Pa18IYWxyvCc+DMMR9xJN?=
 =?us-ascii?Q?rssQyEXYn0tCPU7v4WQB3eZ2DZH5ioAJmPfAS7CMr7RLwDHh7mCF5P63Ltrm?=
 =?us-ascii?Q?/7rYxaoKq/dBEsS87V8eZPA7IyJHVKdDgxxXMBXGGBb+J2hHVZ5qIzKNfgKb?=
 =?us-ascii?Q?BIbYi7Rw/frPIOAmaqF/61SvTSfwZy+Pg1jjfFbeOCmh/yWwmtanXebI3kaF?=
 =?us-ascii?Q?IJwzkDFCu5aUl8XcV3Q4kM0ctWvuyIEKrU5/NDGrxvFBqxbPGL1XDlDdlecu?=
 =?us-ascii?Q?5Xh2OXR21f4tgu29zi9cA4FI1WyukxpnDLFx1wsQWMQfvL6z66h50wroe9ui?=
 =?us-ascii?Q?Bh1Qp2En31t05UA7mCxbrrYWud1nnbRqEstzzb0oGbQZunYw+udfWyJJiynI?=
 =?us-ascii?Q?dkuBxAqcAoBUfyhjckGpkzBCpc1jY9C4S580i0r0GctHg6dn6Ozx5B+goCsx?=
 =?us-ascii?Q?mF6MuePjz6KMFNiiAF4bU+rj53odnWwUVLHwqabGI4lF2zKflhqEzpKQ+X22?=
 =?us-ascii?Q?tFv+Zfz64C3n5ayVRw88Q4MvV4yHhpRPL+NDnRiIhlbnKjNSKRcmkUHNaSTR?=
 =?us-ascii?Q?HMjbcvIt+oSP+iG5Ez3tu5B83OzFbA/SbdXRO7/2fPaUx1DJdGCU/PsfFUEw?=
 =?us-ascii?Q?NOK7pOgutigfkN54uOqDLJjCXtYU1kQjrDLRR7Fn7Yx80mw1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ebef66-9820-4aa8-c7c6-08dee1ba2dcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 15:11:28.1398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ld9I+3blxHejaSYKnlsCT6ColemyUGkAzRcqtT3MYqNQpoySaUNPVQCtLOTcH6bwOAOZKjUVt4wVRVdb6EAmIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986
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

Hi Alex,

> -----Original Message-----
> From: Alex Deucher <alexander.deucher@amd.com>
> Sent: Tuesday, July 14, 2026 8:10 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>
> Subject: [PATCH] drm/amdgpu: properly account for resets with user queues
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
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Prike Liang <Prike.Liang@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Lazar, Lijo <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 17 ++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c      |  2 --
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c   | 14 ++++++++++++++
>  3 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6aa75da27f912..0a0ebcdc271f8 100644
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

`amdgpu_vm_get_task_info_pasid()` returns a referenced
`amdgpu_task_info`, and the existing `amdgpu_job_timedout()` path pairs
it with `amdgpu_vm_put_task_info(ti)` on the exit path.

Since `info` points into `ti`, should we keep the reference until after
`drm_dev_wedged_event()` and then add the matching
`amdgpu_vm_put_task_info(ti)` on the common exit path here?


>       if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
>
> AMDGPU_RESET_TYPE_PER_QUEUE)) {
>               int r;
> @@ -146,8 +156,13 @@ static void amdgpu_userq_hang_detect_work(struct
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
> index 0419fe869d4b0..0ae2d951bd21e 100644
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
>       struct mes_remove_queue_input queue_input; @@ -476,6 +479,17 @@
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

Same here: the task-info reference appears to need a matching
`amdgpu_vm_put_task_info(ti)` after the last use of `info`.

> +
> +     atomic_inc(&adev->gpu_reset_counter);
> +     drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE,
> +info);

The existing KFD reset event is conditioned on num_hung, while amdgpu_gfx_r=
eset_mes_compute() can also handle the known bad queue through queue_input =
when num_hung =3D=3D 0.

Could you pls clarify what condition should determine whether the reset cou=
nter and wedged event are emitted in this path? Should successful removal o=
f the known bad queue also count as the recovery event?

Thanks,
Srini
