Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF924C7EE29
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 09:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 745F110E48D;
	Wed,  7 Jun 2023 09:26:30 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CAB10E48D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 09:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np17tqj9jTpDRjLuHVGgh96PXscJSnklqUUEn8Yn088NBGHmuVBjoQIkEzU3qM6SdsGJIDcbvkE3g3y9x3VAOBeAChZgmf0CTLctx3UVcdr1BT/hFn2gPE9+BGX8KO+dqcTYKaUV/QIZ6Nab8pvnyYRWc/AdX4uiRSb0mWBNOCcbeme94y4CDV7lhIcuEaou/GggR3cY9vm0ftBqQS5QNesYYwfTZ7E7vVNwmBJdfe+PNlhUX5ju2CLxNupFWf+wg7ZC5ccZTZnu9KfHFe5jUcm5vi9uKZBbmbCk3TFSVpNUVNembgw/gXl1gaJyMOc1Rk9DtiJ+8UnSOui+dRsdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wagkPLesYmTr6Vt68kl2PudP6RAJQzswEgzDQLLg0a0=;
 b=BXpDMxsB5oTyrlBkTKdu1lygcNnK/kEZyylqQXeR4pT1KfGzuLmnLAmSU1Iy6ZPkajk8nY3AcGs3SEk9ED5DIhTfBGEbGqeyJKtN2B+aA8mfgshe/ylOwaw+mArHAgTaJJCHO5IJCujsPAgQ4FVYF2V5uiAgqRTRIwCiu0mxX8WIRMSEp4cpbzvSPboKvOejywG2p0JXsotTKBERDhJbLHOdEAaB7QQCLPTUU5L3F7LobUWdj8hV+BThaW2y6gggTnCCOVxZgTaELGlh3mcZwbhefaSYGfYM3H3dQwEeS4AbP6qdDg7PLMmBDLH5g5kdOHwOJqKdufdKD2NLPAHMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wagkPLesYmTr6Vt68kl2PudP6RAJQzswEgzDQLLg0a0=;
 b=atCzW/QdUOhNcJMVFQ53dg2sSG20zzKjVC5F+Uxg6Al/QwsfSBsvUQfJVBoL/0SDhZUU8yHECGgCZCzD1H//+7KZR1HJYigQ/yrOXDLcZ9OgSCI0Nw3A0/ZBZtuOP64uLDBpo6tFXv/EB7n0AXsuBRKLHOQRtOWba9QjmxvLx0w=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 09:26:24 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::458d:c45b:487:9954]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::458d:c45b:487:9954%2]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 09:26:24 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: add cached GPU fault structure to vm
 struct
Thread-Topic: [PATCH 1/3] drm/amdgpu: add cached GPU fault structure to vm
 struct
Thread-Index: AQHZjylaV0efIYS5dkOyD1rvzD967q9/JCVA
Date: Wed, 7 Jun 2023 09:26:24 +0000
Message-ID: <DM5PR12MB2469516928B11430CF25C04CF153A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230525165219.544671-1-alexander.deucher@amd.com>
 <20230525165219.544671-2-alexander.deucher@amd.com>
In-Reply-To: <20230525165219.544671-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5483fa93-6b4c-4420-8edc-737be5619eb2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-07T09:22:41Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MN0PR12MB6053:EE_
x-ms-office365-filtering-correlation-id: 12d1c703-0a14-4d81-00ba-08db67394382
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5R/5MmYlI57RCkfmJ9g/gkwuW0fw1u55TH4+h8oFH29ITZJI6HG33zIJBiHdmJuhOUhfPM6xYQU6GIdx7e+4Gn9wotqyaQ/7M/mkxI+mOSCrTl3yJ3Pxte3loTXjRXkEI1lDZXqk+VYNt/FuM2iEdlvbLRPoQ/esc3zwGfA41cahjzZBdfh9DVL6RYtCeobuXJhmFEvcCdJ+fB0g8BA3zfDbKMnG2W0qdkMJaCk3MecotQjmqtJZnogZ1s11P6BWhYct9F52HHccag3A6tjctQaINXbLjfdwkqdcarw/Cth0WZjtzGPd1g8a6XAy22PmdmgRlQfl2uTychN/fse2zcCPfgJo4Q3iI++3aztMiu1GNFNKwMiHwQ5KsocDRWkFqNJDSo5RwpuiOrjui0P7wK2mtxK5lPkVlGYXjOxxuVDwALsnaFhyc1D2m8Mbi4i2vy+IWwkKLj33UY04kiFVtfoRhU08ahBqlQGWeCEWJva7u35jQNdZg5oa0yI2iqhvp/AbENCtTumROfOBXspLBDf2oipt3o0m1MW6d1+sp+gjJkiweT6RDVMVIPEWkCKNDXTaIHYjjRG1HF6ROZs79RNRkmFTDydDfH0ORGnPyQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199021)(55016003)(7696005)(64756008)(76116006)(66446008)(66556008)(66946007)(66476007)(110136005)(54906003)(122000001)(4326008)(2906002)(5660300002)(52536014)(86362001)(38070700005)(38100700002)(41300700001)(316002)(8936002)(8676002)(33656002)(71200400001)(478600001)(186003)(83380400001)(53546011)(9686003)(6506007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZuBDWai2vpbhOb1mrBNlADDFp15Fgp34ZhDtXqef6QH0wPGkq2uP0pt7ywE0?=
 =?us-ascii?Q?w6j50yPAzh2od4GhU+ni8pp0FTIEH0pEYG1D+Lta4xJ2gNyUk89iVgegv+RY?=
 =?us-ascii?Q?gSfLbTlbkRvi+D0o7/79cZIK/h13fbzabXEr94SBxzTaG7gm3D4XyXEgA4Tv?=
 =?us-ascii?Q?etDQJL2UyJjxaCadiive8zhHZSkIc3mRGJ6FvcIH5EeY4nTRjYDvEwC57fD0?=
 =?us-ascii?Q?+99krp2YqAitjxwZsOiKMyilFmz3e3Bk5IGzrtBUOVBeCdkK5haG6SCkppqq?=
 =?us-ascii?Q?Nxk7LxymArsCiabli7MvyEoBYWHT2RSQ6gr5HKyYAtQVK+O83qmeXPyRNzoC?=
 =?us-ascii?Q?gm/qnZxdzAMYDPQh+JngD6zR7o8feT4h5+3AR86++duLS7Eyi8DmeHKZ72R2?=
 =?us-ascii?Q?FBS/ekYmiXdCM7ZIV3nikUS3EfyRM+SnBHYLxhYVJoIr3W+nRMiUFebKtYhB?=
 =?us-ascii?Q?0AYr42095kInSuUbESM7iFomkaMG+eH2zRpCt9URakNGfmxxTnqfDQyvVkZ/?=
 =?us-ascii?Q?icpwuvZqt/pfvphx8xVYa9RGNvR4PZcKMGljDOLhOxlz+CbzIwYX+9yGvHD3?=
 =?us-ascii?Q?jcNM3GEUUxY7+jBhhh9xocTBrhTQQrTtRokJmdfdSCNyiJl9n+mfvSzrPy/c?=
 =?us-ascii?Q?UexRqC6HJ417A9tX9kDbHacjU5Lfjr7Ybqg8StrqQ8BqP4RQEynomAKjz81i?=
 =?us-ascii?Q?qDgjrVmFjZ3DYNmgLmek5gq2jZ9ydFcs79ZQ2yMaR8BxgJ6gvWeOx6aje2V+?=
 =?us-ascii?Q?H8D3GvZoBrodxaKbULYX3St0tIYCQAMBS2hoXQjXlKcTETVmUyL989SoMlws?=
 =?us-ascii?Q?qmYZkEd39Rz65GGE8CopEo95IEU+I6noHmK9Z25/XDh5rXJTOZOvAXSKyW5W?=
 =?us-ascii?Q?qC0vHEsYH1uZVn9fO0Ls4dgxnPtTa6xoJHTiiEQg0P+zstkK5DE1JAA283lB?=
 =?us-ascii?Q?HYtvF5xCZz98LQjF8Fj2AVqncdnPz4c8aK1l/cBgEetWBCO9zOQpc8QZ9lqy?=
 =?us-ascii?Q?RW4KIod9dBGSmmE4XurzvBpyoqrkR4XJ/aefJEG3M4p5BlhG7/ELnYoq3V3t?=
 =?us-ascii?Q?C+JXA+OQbwa/VwTEXbGjJxbbgUu9bUwzPZfq9mrkLGSjpOvBaRThCnMQT+dX?=
 =?us-ascii?Q?hxr8PWVoOgMjaqRvv7RoC2QLSJbWY2NH1RyKRlFZv+e9GKLlP+zAafaIXlBf?=
 =?us-ascii?Q?AzcjBtuniSn/+ICaMPCK6AgpmTt9+bPDOaDcP7tVNvQbKRqJe/+/Ds6oo5hF?=
 =?us-ascii?Q?St1vM2A+A4Iak7rbK+jonmTgE0SjTf1NjSK15xKudKle+5TSfZXxWf9DdQCw?=
 =?us-ascii?Q?XfLi189DYzBrF/iA/ILkBzOyQWWAqBWsPy9BbsWjrTEz8DLdPMQJYGeP5wpl?=
 =?us-ascii?Q?6LKqefBJq55Y71cIBvjVihBF7HxCUOcy6/t+GMNsrVJtEHDBCOkXMp7sn607?=
 =?us-ascii?Q?qWO+vhtw5y0KmzIC3M5j/mrLJQuhHWya4H6LEMABiAuCTq600ohpqDrMf5S2?=
 =?us-ascii?Q?+Kka0h/yc1kRSlcAXIc7nvLFT6C5lD3VhttSGYhCPb5B6pJ3NLJQlks80WsN?=
 =?us-ascii?Q?rt3vBT8oMb5ttx3+k9M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d1c703-0a14-4d81-00ba-08db67394382
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 09:26:24.5869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyCQ2bRsXEYxj9ARZNPt4HvahwdK6J6ke92FG5j2vc0ET+KSqB+avjoSsHMby2H3hVtW6bvvzjpmzcOfVQxDXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "samuel.pitoiset@gmail.com" <samuel.pitoiset@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

3 nitpick comments.

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, May 26, 2023 12:52 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> samuel.pitoiset@gmail.com
> Subject: [PATCH 1/3] drm/amdgpu: add cached GPU fault structure to vm
> struct
>
> When we get a GPU pge fault, cache the fault for later analysis.

A spelling typo, s/pge/page

> Cc: samuel.pitoiset@gmail.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 31
> ++++++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 18 +++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 22f9a65ca0fc..73e022f3daa4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2631,3 +2631,34 @@ void amdgpu_debugfs_vm_bo_info(struct
> amdgpu_vm *vm, struct seq_file *m)
>                  total_done_objs);
>  }
>  #endif
> +
> +/**
> + * amdgpu_vm_update_fault_cache - update cached fault into.
> + * @adev: amdgpu device pointer
> + * @pasid: PASID of the VM
> + * @addr: Address of the fault
> + * @status: fault status register

I guess this 'status' means the status from fault status register.

> + * @vmhub: which vmhub got the fault
> + *
> + * Cache the fault info for later use by userspace in debuggging.
A spelling typo, s/debuggging/debugging.

Regards,
Guchun
> + */
> +void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
> +                               unsigned int pasid,
> +                               uint64_t addr,
> +                               uint32_t status,
> +                               unsigned int vmhub)
> +{
> +     struct amdgpu_vm *vm;
> +     unsigned long flags;
> +
> +     xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +
> +     vm =3D xa_load(&adev->vm_manager.pasids, pasid);
> +     if (vm) {
> +             vm->fault_info.addr =3D addr;
> +             vm->fault_info.status =3D status;
> +             vm->fault_info.vmhub =3D vmhub;
> +     }
> +     xa_unlock_irqrestore(&adev->vm_manager.pasids, flags); }
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 14f9a2bf3acb..fb66a413110c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -244,6 +244,15 @@ struct amdgpu_vm_update_funcs {
>                     struct dma_fence **fence);
>  };
>
> +struct amdgpu_vm_fault_info {
> +     /* fault address */
> +     uint64_t        addr;
> +     /* fault status register */
> +     uint32_t        status;
> +     /* which vmhub? gfxhub, mmhub, etc. */
> +     unsigned int    vmhub;
> +};
> +
>  struct amdgpu_vm {
>       /* tree of virtual addresses mapped */
>       struct rb_root_cached   va;
> @@ -332,6 +341,9 @@ struct amdgpu_vm {
>
>       /* Memory partition number, -1 means any partition */
>       int8_t                  mem_id;
> +
> +     /* cached fault info */
> +     struct amdgpu_vm_fault_info fault_info;
>  };
>
>  struct amdgpu_vm_manager {
> @@ -540,4 +552,10 @@ static inline void
> amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
>       mutex_unlock(&vm->eviction_lock);
>  }
>
> +void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
> +                               unsigned int pasid,
> +                               uint64_t addr,
> +                               uint32_t status,
> +                               unsigned int vmhub);
> +
>  #endif
> --
> 2.40.1

