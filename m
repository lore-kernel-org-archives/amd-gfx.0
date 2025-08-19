Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC73CA0EE6
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 20:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE6B710E669;
	Tue, 19 Aug 2025 20:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="be7taq1X";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 812DA10E21B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8HKR4YZHUy3AiqNucMTZ6mwIOLQ8kluQ+DbVsgUrFRogzNjkwUOCqFhy+vRKbO50FcYoxYSTmOIA6IopaqWCuUY78u0q5Mj5PwDcD0yfvXNeQzjDPFGqkicLwfVrXOyfKS0v104axE7ejKzu6ZQ7ycYNVkbuWO4cH5hfUOn/DByqFmeNfb7jJBLj++dgz0Y2K45rGMpUkGYwWtsKnOfjJUHwXI0gv0LZ5ywxjdd1hS2WNFQE2WRVNQKu6JGsd+wfmkScFGLDb/CsWBrNcBvxBoUB1z2//fl25GcZyJiTeMiBRlJhuJw0kD2zpAaGSN8ijrzDYKaFGX6aaqk51TSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAJUpOa4du3w0vTJdg4O++2vdZOVUmHJv4jOVH20dZ0=;
 b=IZIYNzpDSOgpx1zCenc0YPOS/KlAjwWY1QDwvhouFp+t2Oh/e3ajW10yxmQIZ2+j1DoEH4SjprWsght4HxZnQMITEKlvZmbPkWAkVLHSG7jtkvC63m+j3iZb8bIlDlaYg7T/WvVyfwrdiMODv56XZDbnSxV0pjXm7HsPiAkqkvtCdKqYG8n4TTCaKF8NGlAc0ZJw51Cltr2u3iZEISKwbFSsCrDU1Wyq1H0CnypZaxJghpdHb6TfeZGF8PCB0vjo4AXYJD4yN87VYFEsaqSyyufaELikafnNLUfPsA/mEMhtDakfqBPAnikQTuQhqLiTK0Bh6x4waVXO4XMULgzjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAJUpOa4du3w0vTJdg4O++2vdZOVUmHJv4jOVH20dZ0=;
 b=be7taq1XsVva0obPUPd7nMKR/aUD4e+SMj8GD3pxSc1mfg/sVi4FHtZ9sXWVjVFzs2B8IAiwUm98quJOfTiakuGZM2yOB8BAURZnA+2vYYUfoIGqDkOW3oVDRknahrmSz/EWJGsYZn/+Qmp4vVFgoytxleVEcrJzyhZOnandbqA=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 20:30:46 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 20:30:46 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Rosca, David" <David.Rosca@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Rosca, David" <David.Rosca@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/vcn: Allow limiting ctx to instance 0 for
 AV1 at any time
Thread-Topic: [PATCH 2/2] drm/amdgpu/vcn: Allow limiting ctx to instance 0 for
 AV1 at any time
Thread-Index: AQHcECSKqkbEmFgHEk2aONIaByjlT7Rqb7UA
Date: Tue, 19 Aug 2025 20:30:46 +0000
Message-ID: <DM8PR12MB53991DEB5145ADD8C683A324E530A@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250818094253.10105-2-david.rosca@amd.com>
 <20250818094253.10105-3-david.rosca@amd.com>
In-Reply-To: <20250818094253.10105-3-david.rosca@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-19T20:29:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|CY5PR12MB6527:EE_
x-ms-office365-filtering-correlation-id: a5bb4bb2-2073-4066-9923-08dddf5f471d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|42112799006|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vNWje/1CjXMmKXSELLGXy+lWuWjbJKvgodHJie1s1GJ5yHYy2XUtS4Be5reD?=
 =?us-ascii?Q?3xPO/LwipEaIoSuYXMw345kFMpTS7AT88XuxBMjSrbedHsYY6jLDqcOHKXFx?=
 =?us-ascii?Q?6Xz7ZEcEShJJeCtfIpf5GdNpvKUp0TSoCb9mSf+LCrXXl/EQthNN5mRn88it?=
 =?us-ascii?Q?fKJuxV91Noaq9a4eP3TdWW45kmDEvbdREkNDzmusNQpuUowBrwUiH5S3HKGD?=
 =?us-ascii?Q?nGxGSYZACHT6U3ZrX6jLFn8bfjkr2TDI/O5ULJikBobCaV6ZigjFDpcuKwE/?=
 =?us-ascii?Q?fFF3Jc+dPrPEOTN4PdEio8tTi+uQDH6YWYJMJmP+CDuks6/NXDkJyi/9eszf?=
 =?us-ascii?Q?ItKWjoUdSAzXGLT6BfQmYdCj1d9GZfKiRGitcAfq2gIpooNzFgwvjDwJMWac?=
 =?us-ascii?Q?Y1lBJwSpy4rzkzkLvoeNlYN7E5jjKoMF+dMV9skJceRPUKFm6Lj3dIxWKWt8?=
 =?us-ascii?Q?D5RoGnItTNhPNSYYna2e727HFohlMoLdfkmGSwoO+SDXqgOGsPbHLqjNP8lb?=
 =?us-ascii?Q?iAGyxfPGy9ZNYXlTTGMoHz4D9+tSSz2ZTdGtD1VTP5J38IFKKUoG4fZPDrQG?=
 =?us-ascii?Q?0HJGe2yOdsPpQPhNRKJYITVr0kh3vrY1wU9XBbLpY4SK1eWRxHs+bQsLHtfP?=
 =?us-ascii?Q?59Z+RCo8SteKZQwMd0cYbyiI1pOznQWEDgcU4yUMuUaAFqwksOQ9l/6Q6Kn/?=
 =?us-ascii?Q?3QLPfB8F9vwyT4vq77liDPOK49wz8zQcTYx1DyRhyleimQyDSYfvivoioSl9?=
 =?us-ascii?Q?yTCcxV06m/rjDM70Co7FQHUfvbwKi+avvcR8/sbeu5w1vnFcN4KN1NVKdDvM?=
 =?us-ascii?Q?QIXrznGa36/s7Zr8267uHyJc0CH6J0ok9CTbDJM/8/dLw0n3e4BcAx4t3T/O?=
 =?us-ascii?Q?D03KNpLrSRsOfqZy4rWoZ3lk/qgVmHrm4/Hh/dxUld+WySLXy/m9f8b7Xk0B?=
 =?us-ascii?Q?0zMLO5VUkbCsFViFMJm7TH5GXGNWgO4zpqiDWmSmqAtC31Req9vf/rHXOogY?=
 =?us-ascii?Q?r0VLkG2mggOjwZiYbOG5NeXDIlnkdLSAZ88Ux+aV7ccCZmNVUHg1ueZdrwdd?=
 =?us-ascii?Q?wTRizBkLBrK0hpws1B1CN8WNpV5MaAPPHn8qAUvlMAjYCFvdg6WQs2mG0cWt?=
 =?us-ascii?Q?spCize7UN5PUfTvWELOBzw6RxBKEGzkO3xTyU2YdjGYZdAMYMawr0/O7SWo/?=
 =?us-ascii?Q?c+3eHUpWUgH3z4phApRL8HpreodE4EHNEc08Re9b1IejBpfGeZaY1KDW6lYB?=
 =?us-ascii?Q?Pr0mtugMNDzxmev7ZLBQfoc3TDoP6DHdfDqopyu+9MiQ5hXSUNX+hAGGZiob?=
 =?us-ascii?Q?3ZRL0j/weNik1a10LZu2Sjj7T5mtCEoowEFi+F28GkezYv9LJscUSjg+Gnp1?=
 =?us-ascii?Q?i+nlgt80AXK7upMEyjREAz3RHM9BuTXY6lT9KhYQ9Gtb9rg0lkKptlA7EmUS?=
 =?us-ascii?Q?+3mEPPCHsMFxixuA/V9rbDCd37ZG3WwoycsD6tM1t1Frec3MIbFd6A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(1800799024)(376014)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gavVO/azT+zYExkAX3BPWI/f+UhS+e8T1x4hI1R9rM+Qy9ejzxuqYaztwer/?=
 =?us-ascii?Q?peL2SXYPeE0IyMekiI4OK42vzLebJM6y4mwBQrfKSZA4qLzRO5ZH93NyU9KG?=
 =?us-ascii?Q?Kq9vAWHdiJ5G2vot5bjfsXnWmb25zcOp9Ret/z/SPdFQdkGzfxOQoglkY3+S?=
 =?us-ascii?Q?e7tsW5+xG2dIEdzdc7FR8o2ZhV7Ywjs6I0F3DBdOFyg4T+lxq5fEWWg76MO+?=
 =?us-ascii?Q?4R2EWqx0iETVKjaJ7pSLuoo93iRkBWL8/7SdqoKifSvzn+EwP9Jj+BVnValH?=
 =?us-ascii?Q?whmzMxuC2REqMiu652XhHGtmMbsJfFl8dVS8uUcCvuICyS3Pf51vIEUhlP/R?=
 =?us-ascii?Q?/9kjrj9SJssMBc3ri1VUjVMf59fPfu+iaS9/HsaI49qsSSSXRkNPg/sHLKwi?=
 =?us-ascii?Q?fvCu9C2eoCfrWjuF8NlvG5DKkqRbLPRZKYSj29b5A/sNGY/ptVANNYzh236O?=
 =?us-ascii?Q?JRlxw/qqEh7FKIiEnh/F+/dm12xHNNjn+ssdCTcf9crOu5ZJNlEinBpTs3TR?=
 =?us-ascii?Q?xewRwLqWlIf1jmyjhl1JHDFnb8dHZUoR+bckHv5Ef8siico3HWvm2OhtdpQr?=
 =?us-ascii?Q?I9RGyvDYXxUumIBeCR2Qy+dZKPZX/aRNieeTtEUi1JniXwECCtwxtjtmK4x7?=
 =?us-ascii?Q?xZ1I6iRYO8wGXX7K8R6NOBPXy67ky3+GuV0cuzgIOvbg3yo1LyoYIbMFpQh7?=
 =?us-ascii?Q?cGhv9akf8q7OjR0AYJs3XrsorjGRzTZyaNpYAxh6xDzIaFxMUp0HvM9XB5yd?=
 =?us-ascii?Q?+cliHCMSD1zUrQk7alKT0BZuf6ZtKIXuGoDV7TLvrFq1+8M6WcZlcH0iFM83?=
 =?us-ascii?Q?gKroZHX/1P2CWiYj+2EZCDWQi7yMg6A59266dODh7AAgVoRuhkgx3JfFN6Ot?=
 =?us-ascii?Q?OhYqhdsNmezV0XLdwnmPTIx/4VW0GAPTNMtyhKio44eInKYvRgc2KJwEqzxg?=
 =?us-ascii?Q?E8uq6ZVM1Ug6JxSeHxW2S08CVOLdLH+qx3YnPkm6Pea7nPU7bi0xXxq92fXt?=
 =?us-ascii?Q?mjQgDaX9acZ5uSNVtrLr6mvv0AIrm7qEqHN68yBwoVDzcQHuyI6hRAOKoYpc?=
 =?us-ascii?Q?KSgzsxX3RIEKpAbgU938VSUSrNEMC8Wzv8svz96L5XfXoHV8RWSQGVpcOIyX?=
 =?us-ascii?Q?nPz3u5GDkgtA9AJjKw4VcFu+ik6RmgC9M335XgnuZxJrb29pZP3T445Mp7G/?=
 =?us-ascii?Q?uEGrcgQi1CexSXU2fOjp+gvzTT6KmDDhyilVw61E46cWkAv8+LZIN7u2gEEU?=
 =?us-ascii?Q?2ampoli2yxlhcD9OdIm5mD5CozAOwDmYWpirykthSouDGNk/KJrEgEE7rbp9?=
 =?us-ascii?Q?y9VGU0C+V4tRw8P9tMNtoYJYiskXUfOP9zNnPwox+A5ZeVfW/mbTDCfTF+qA?=
 =?us-ascii?Q?/fERDYuEcjeMIzHvr111ZDR6e1eVSmf6rN0F+DkaXjY8Azxop+8g/97yuzpx?=
 =?us-ascii?Q?pE9GDyIga77a7loUsXodPSPgAuXS02WczaQ06d3QXameXgKxa+v92oj6FB53?=
 =?us-ascii?Q?TWbmcbkHFpkDJaOd6RinF8G0WlGjlnLwq7zbFdQTFplA0rTXItE6D00mVZNO?=
 =?us-ascii?Q?XEbUS/KoyuF3JP//4/U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bb4bb2-2073-4066-9923-08dddf5f471d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 20:30:46.3984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Jaxy9jFt1KkuWc2zeHZO9NMgLm1lmZ1hpatqjzHYAGByLSiq5Yj3JSasBy+019R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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

The series is:
Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Rosca
> Sent: August 18, 2025 5:43 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Rosca, David <David.Rosca@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu/vcn: Allow limiting ctx to instance 0 for=
 AV1
> at any time
>
> There is no reason to require this to happen on first submitted IB only.
> We need to wait for the queue to be idle, but it can be done at any time
> (including when there are multiple video sessions active).
>
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 12 ++++++++----
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 12 ++++++++----
>  2 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 95173156f956..f3085137ba08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1886,15 +1886,19 @@ static int vcn_v3_0_limit_sched(struct
> amdgpu_cs_parser *p,
>                               struct amdgpu_job *job)
>  {
>       struct drm_gpu_scheduler **scheds;
> -
> -     /* The create msg must be in the first IB submitted */
> -     if (atomic_read(&job->base.entity->fence_seq))
> -             return -EINVAL;
> +     struct dma_fence *fence;
>
>       /* if VCN0 is harvested, we can't support AV1 */
>       if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
>               return -EINVAL;
>
> +     /* wait for all jobs to finish before switching to instance 0 */
> +     fence =3D amdgpu_ctx_get_fence(p->ctx, job->base.entity, ~0ull);
> +     if (fence) {
> +             dma_fence_wait(fence, false);
> +             dma_fence_put(fence);
> +     }
> +
>       scheds =3D p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
>               [AMDGPU_RING_PRIO_DEFAULT].sched;
>       drm_sched_entity_modify_sched(job->base.entity, scheds, 1); diff --
> git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 23b98f011879..235fc9e01dd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1805,15 +1805,19 @@ static int vcn_v4_0_limit_sched(struct
> amdgpu_cs_parser *p,
>                               struct amdgpu_job *job)
>  {
>       struct drm_gpu_scheduler **scheds;
> -
> -     /* The create msg must be in the first IB submitted */
> -     if (atomic_read(&job->base.entity->fence_seq))
> -             return -EINVAL;
> +     struct dma_fence *fence;
>
>       /* if VCN0 is harvested, we can't support AV1 */
>       if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
>               return -EINVAL;
>
> +     /* wait for all jobs to finish before switching to instance 0 */
> +     fence =3D amdgpu_ctx_get_fence(p->ctx, job->base.entity, ~0ull);
> +     if (fence) {
> +             dma_fence_wait(fence, false);
> +             dma_fence_put(fence);
> +     }
> +
>       scheds =3D p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
>               [AMDGPU_RING_PRIO_0].sched;
>       drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
> --
> 2.43.0

