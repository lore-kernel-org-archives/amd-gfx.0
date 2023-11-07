Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DB0C4167D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 20:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C2D10E69C;
	Tue,  7 Nov 2023 20:24:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B245910E6B6
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 20:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7nFB5WBd6QMqrc/2VAE+X2hn5wQ3SCVkx6XIePCt60MmWzhP+IuCreCPLlhYOIziGaqReZ8HFDSs8jAtZLIN6psBQ1lwNJzuSgiO9nS/gJalRo3MByT07OAfNApIVffkSZQwk9g+oi7eBR6auTgUNNcYbQ4uXkYnJrIrcrNGW6q+mHI1zO9p4n6c1QnKgez4Nrh+85uGuzJdBKz4H1tVq2hkSG67UVrl0jZ7DVhipRhGD4gObqoEfVzVCbFF5AnhKTU5tBU0uzCKKo2wqfemBUTIFoLcF6dafpVIZtWX4hPtw+10Tl2Eemf3ENg8Iq59Mm2n/eR76aSmwlKdFypsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnrwRBVAW/lJZQbUuAIZN8KFRMpts6A5moFo0l8SCOY=;
 b=Wp1rgaMFB5huQrDELX/Vu8jcDAHMhak2faq2afL+H+xYUA/bRGIVfBwdkVWI3r910jtyCO1tGrrv86CsqgZYXKvpQXhGTDy5af+mx1I2/xWQfZwGFrX4CxR567OcTkwRm0f9U1AWW3VjWd5Is8HdvNkRawMkJMoxE8De8VUpMWb4s1/P7zTPZ+GsDGW2o2u8DWIk5b321WAXc1EoBnlsglXBGaythWLnWYdw9JuuR7Qgc9l1j8FsNYwV/XoIfTnLHgcwenclPTrFk3MIi3+aaU+OyJ5Cs88396zTx6vZ+7HmT7+XkgsPXCE55qMo1bvHZhLlCY6ot6yKHXJui4/yHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnrwRBVAW/lJZQbUuAIZN8KFRMpts6A5moFo0l8SCOY=;
 b=ZMUZd74aF9gCtJBSTHiNLuMnXwyVkzkDz2GmsnAlgaa5ppoE6AZ3TIk2euQLQIRs+Fd5z0CJXKDvvrEptN/BpwQd/1iredYbNrIti7SpXnsXQTRKKg5tZMa2sp9VcFW2Xk7Z3rYAp5lBJ7Kr3ESR3svaNbbZY3k+oWiJ2ZppUqg=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 20:24:46 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::19fe:6718:e3a5:e855]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::19fe:6718:e3a5:e855%3]) with mapi id 15.20.6954.019; Tue, 7 Nov 2023
 20:24:46 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/6] drm/amdgpu: Auto-validate DMABuf imports in compute
 VMs
Thread-Topic: [PATCH 3/6] drm/amdgpu: Auto-validate DMABuf imports in compute
 VMs
Thread-Index: AQHaEZuwwuQ0BRigtUarz0G/P2pm7rBvS2Yg
Date: Tue, 7 Nov 2023 20:24:46 +0000
Message-ID: <BL3PR12MB64257857E15E26A7C05474E3EEA9A@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-3-Felix.Kuehling@amd.com>
In-Reply-To: <20231107165814.3628510-3-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ceae354c-9e34-4647-a84d-6baf9468e39f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-07T20:16:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|BN9PR12MB5228:EE_
x-ms-office365-filtering-correlation-id: 30e19e1d-692c-4d24-8e17-08dbdfcf95d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sY64KyT/C2UtrvTd/vNO5RTR6OEuhJSVADAyHt2EvA45I/b6y1mwm10eSIVicPW2d7mP4+450tOGwiFyNFqzr80Nt1gmkqF/MR+EUAAxubyMWK4VUHazFgSX4mbKFpODrG65j1z50u3s+jJhp0Dnpqi/zxyAl6X2LJ1Z9oYAdxgN69g/HXo9ynYSGApU0uaCUC2Y0RVvM2JksQfm/st866zZ4E9S8SzOb0dCfBVHjM0Miczm6MEpbp76wX+1adPL58AiuJCmDxEnV/DTJL2f+7JkPfpuHwM2UbMUXc5g5G3hKYxyfPZzNRllzknrBVvR1w2jxk2Se8OnYHQCaK0R73c0sL9/HboVu9RJ3j2Lo4tZJVuzawzRxIqT/hM7qHWhmihUTM7CCMLc7Qu6QmGqq8VIQSytaw1kDAHkDOOExv2xgkggLnNW1NaEHHAJNOvI4a+9f233ou/yP+Q15dGTkQ1qUoF24AvwvjAaunmn2w8hJLZPNyQnBXAeVbZtghJfWl2DO5EGf9ZOHHzJLPB2hyf+fXvvjwAlN5oLuWv78vYNbFITaDpr4UDFq9wVcdXwaacSHCmnP3Z37F96RU6IexKj2Z5hH9IrLyXAyvto4BPNZE1CFk8IQRejHmLHXjfO9/aimLcpdPPfOVxyAXpHghOSKz4wOrQvTiY+Zv0nAXg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(1800799009)(451199024)(86362001)(55016003)(30864003)(9686003)(2906002)(26005)(33656002)(76116006)(66476007)(66556008)(66446008)(64756008)(54906003)(66946007)(316002)(110136005)(4326008)(7696005)(8936002)(8676002)(52536014)(53546011)(6506007)(478600001)(38070700009)(38100700002)(83380400001)(71200400001)(5660300002)(122000001)(41300700001)(15650500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xi/Ks0hmLL9THgOr5W/cDMT2has27HXIql7rMlScewdT/JD3dxeQtIDwjqWf?=
 =?us-ascii?Q?hReC2C+noHgYDQ/7PuvMyrX0JQLcNT3KrJ0AtvnNJDicoySn4PVVnAV3sfw4?=
 =?us-ascii?Q?vBvUtjtVHXXj9NltHNe9EfhQqhaKhcs0PUtnTzfvc/PgpfCQv07BclEMX/dr?=
 =?us-ascii?Q?fw/a/IYTBVRuZXpGadEgtBCQkN5ML+Hz3JFFndoaGOzbGsG7Vk4FzJMnvQOX?=
 =?us-ascii?Q?YlaCA7F0Hu0iXXEKNieO+u1Bqfqj4602Z1Wt0G/AOKM2dTQc6kKTySwdDsO/?=
 =?us-ascii?Q?BSk8fLjb+T3z+ldIVw3HLL6UPl/T7GrDPYpELJXgoxqVTHFLYbmNi/fGe6SX?=
 =?us-ascii?Q?GLXoIhb0qQhMwrXxo55JnXw6ilA4m6NF7CCXBzv3yQD32gEvX09s1/49wFO1?=
 =?us-ascii?Q?efBajgEZX7kcbKdIi2hsSGnC29ZYwLQpMLHpjSi/cKOgD++cfjjM0K2X2RhE?=
 =?us-ascii?Q?t4HuCGKljlJIy6+ohkzc7u5RjuYygX8ioDskUUpe32c95yR+7WNkiEaP1uh2?=
 =?us-ascii?Q?qUVvgm9EEekS0Ly/eNweku2hulBlyp5VDDM5Wcke2dKqltPMczMDIk9CzJew?=
 =?us-ascii?Q?We2UIk0aMpJxzvvTidWqh1TJ1jXOClhMrnLWZZW0dcmm4MQ9ghhNj8/aagui?=
 =?us-ascii?Q?pTS6ISdTh9lYDhFcoHf8laBmKfyZOWKcaBrrlqzU2GAzXa0+MyQKIgOr74ra?=
 =?us-ascii?Q?1OR6LU1BChYBpGsP5mD9Ue2qK/BEUvuUl7lb3oP4CZI7WnPVezvlWXJ4Brt4?=
 =?us-ascii?Q?TqNcrBGYo9arMuVsSmqxy0h8/f1lrS30OERu7Cj9EFv5TNl4dqsukL0swMnF?=
 =?us-ascii?Q?sF1sKHfKqL4alF9682TN6v0DSp1o3r3iZaIVRH2hhjmQ0Sts7X+d3FUhHkeU?=
 =?us-ascii?Q?4eHgcOn/dJbNxOq5bhiNObomLPoov32oUbvCZS1eInMXkk3PMKosR+42yLF0?=
 =?us-ascii?Q?v3rPRxGey0Dse71sAgnlMbeUBY+hWlpR9gR9gZx98eQJ5TOaM25RDQTmNUFp?=
 =?us-ascii?Q?ySK0xiI46nwxf1fDXKA9Oa4mfa1ZoMykA9uflqFGVMZtI2X+VEzL9LHvrT4G?=
 =?us-ascii?Q?8f3cIe0jKsLDq9HNS2EKDrHziQPSYXa8swJraKXL+HEmPF6kDyQohmq0+U3G?=
 =?us-ascii?Q?LtkT2I1bhoycT/PjDm4o2ICK/5QoauqtdoCLK6djIlLA0a1wpA+Y8gbSUEg6?=
 =?us-ascii?Q?oWKhXMYKxcfF656rMrbFwaJXO/Vsoh9vDJq0PLKdz3889AnOrKxRTZjNWTXX?=
 =?us-ascii?Q?4WE/FxjbEqo3t0Eona+/FVk8oFAHeYyDSCTkce9jJ0yr8WmlfjAFxwa/amug?=
 =?us-ascii?Q?mFI4SAwYFOgh1yFkdsGms2pB4LBd3kmoiNEckv1LuAWWGlWJZExFARRt/x32?=
 =?us-ascii?Q?rYZauq3dlt+chNhw5lnYfvSxL2D0LYX9ABrB3+6wq5LfN3PlOzoqzmmW4ds3?=
 =?us-ascii?Q?R4ijr2p7+4pwtXxqhu7ljoXL7lSj3PUf71moPlQNSeybyf4gjhzfYS2U67CN?=
 =?us-ascii?Q?5eGag2VPzvy0iwYL++FWD/iNpvwXZsRTA6Sg3NKatUENzlhvaf+q0l/Oy7CA?=
 =?us-ascii?Q?sDcKGWu1SD9DTFRIrtw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e19e1d-692c-4d24-8e17-08dbdfcf95d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 20:24:46.7408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDM8UCkXJXkXD0tEhKfTlepzGMOwh7jDji7N2xte2iz7nRsUbB9NWbfqW4ERpnQnspNPIxHaouKaU7CzTA67wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228
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
Cc: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "Errabolu,
 Ramesh" <Ramesh.Errabolu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
> Kuehling
> Sent: Tuesday, November 7, 2023 11:58 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com>; Errabolu, Ramesh
> <Ramesh.Errabolu@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: [PATCH 3/6] drm/amdgpu: Auto-validate DMABuf imports in
> compute VMs
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> DMABuf imports in compute VMs are not wrapped in a kgd_mem object on
> the process_info->kfd_bo_list. There is no explicit KFD API call to valid=
ate them
> or add eviction fences to them.
>
> This patch automatically validates and fences dymanic DMABuf imports when
> they are added to a compute VM. Revalidation after evictions is handled i=
n the
> VM code.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   3 +
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  15 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  26 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 117
> +++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   6 +-
>  7 files changed, 164 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index fcf8a98ad15e..68d534a89942 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -178,6 +178,9 @@ int
> amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
> struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
>                                 struct mm_struct *mm,
>                                 struct svm_range_bo *svm_bo);
> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
> +                                       uint32_t domain,
> +                                       struct dma_fence *fence);
>  #if defined(CONFIG_DEBUG_FS)
>  int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);  #endif =
diff --
> git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 2e302956a279..0c1cb6048259 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -423,9 +423,9 @@ static int amdgpu_amdkfd_bo_validate(struct
> amdgpu_bo *bo, uint32_t domain,
>         return ret;
>  }
>
> -static int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
> -                                              uint32_t domain,
> -                                              struct dma_fence *fence)
> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
> +                                       uint32_t domain,
> +                                       struct dma_fence *fence)
>  {
>         int ret =3D amdgpu_bo_reserve(bo, false);
>
> @@ -2948,7 +2948,7 @@ int
> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
> **ef)
>                 struct amdgpu_device *adev =3D amdgpu_ttm_adev(
>                         peer_vm->root.bo->tbo.bdev);
>
> -               ret =3D amdgpu_vm_handle_moved(adev, peer_vm, &ctx.ticket=
);
> +               ret =3D amdgpu_vm_handle_moved(adev, peer_vm, &ctx.ticket=
,
> + true);
>                 if (ret) {
>                         pr_debug("Memory eviction: handle moved failed. T=
ry again\n");
>                         goto validate_map_fail; @@ -3001,7 +3001,7 @@ int
> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
> **ef)
>                                    &process_info->eviction_fence->base,
>                                    DMA_RESV_USAGE_BOOKKEEP);
>         }
> -       /* Attach eviction fence to PD / PT BOs */
> +       /* Attach eviction fence to PD / PT BOs and DMABuf imports */
>         list_for_each_entry(peer_vm, &process_info->vm_list_head,
>                             vm_list_node) {
>                 struct amdgpu_bo *bo =3D peer_vm->root.bo; @@ -3009,6 +30=
09,11
> @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct
> dma_fence **ef)
>                 dma_resv_add_fence(bo->tbo.base.resv,
>                                    &process_info->eviction_fence->base,
>                                    DMA_RESV_USAGE_BOOKKEEP);
> +
> +               ret =3D amdgpu_vm_fence_imports(peer_vm, &ctx.ticket,
> +                                             &process_info->eviction_fen=
ce->base);
> +               if (ret)
> +                       break;
>         }
>
>  validate_map_fail:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index aafedb344c1b..20f4be8cd635 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1165,7 +1165,7 @@ static int amdgpu_cs_vm_handling(struct
> amdgpu_cs_parser *p)
>                         return r;
>         }
>
> -       r =3D amdgpu_vm_handle_moved(adev, vm, &p->ticket);
> +       r =3D amdgpu_vm_handle_moved(adev, vm, &p->ticket, false);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index e7e87a3b2601..234244704f27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -373,6 +373,10 @@ amdgpu_dma_buf_move_notify(struct
> dma_buf_attachment *attach)
>         struct amdgpu_vm_bo_base *bo_base;
>         int r;
>
> +       /* FIXME: This should be after the "if", but needs a fix to make =
sure
> +        * DMABuf imports are initialized in the right VM list.
> +        */
> +       amdgpu_vm_bo_invalidate(adev, bo, false);
>         if (!bo->tbo.resource || bo->tbo.resource->mem_type =3D=3D
> TTM_PL_SYSTEM)
>                 return;
>
> @@ -409,7 +413,7 @@ amdgpu_dma_buf_move_notify(struct
> dma_buf_attachment *attach)
>                 if (!r)
>                         r =3D amdgpu_vm_clear_freed(adev, vm, NULL);
>                 if (!r)
> -                       r =3D amdgpu_vm_handle_moved(adev, vm, ticket);
> +                       r =3D amdgpu_vm_handle_moved(adev, vm, ticket,
> + false);
>
>                 if (r && r !=3D -EBUSY)
>                         DRM_ERROR("Failed to invalidate VM page tables (%=
d))\n", diff --
> git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 849fffbb367d..755cc3c559f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -186,6 +186,32 @@ static int amdgpu_gem_object_open(struct
> drm_gem_object *obj,
>         else
>                 ++bo_va->ref_count;
>         amdgpu_bo_unreserve(abo);
> +
> +       /* Validate and add eviction fence to DMABuf imports with dymanic

dymanic -> dynamic

> +        * attachment in compute VMs. Re-validation will be done by
> +        * amdgpu_vm_handle_moved and the fence will be updated by
> +        * amdgpu_vm_fence_imports in
> amdgpu_amdkfd_gpuvm_restore_process_bos.
> +        *
> +        * Nested locking below for the case that a GEM object is opened =
in
> +        * kfd_mem_export_dmabuf. Since the lock below is only taken for
> imports,
> +        * but not for export, this is a different lock class that cannot=
 lead to
> +        * circular lock dependencies.
> +        */
> +       if (!vm->is_compute_context || !vm->process_info)
> +               return 0;
> +       if (!obj->import_attach ||
> +           !dma_buf_is_dynamic(obj->import_attach->dmabuf))
> +               return 0;
> +       mutex_lock_nested(&vm->process_info->lock, 1);
> +       if (!WARN_ON(!vm->process_info->eviction_fence)) {
> +               r =3D amdgpu_amdkfd_bo_validate_and_fence(abo,
> AMDGPU_GEM_DOMAIN_GTT,
> +                                                       &vm->process_info=
->eviction_fence->base);
> +               if (r)
> +                       dev_warn(adev->dev, "%d: validate_and_fence faile=
d: %d\n",
> +                                vm->task_info.pid, r);
> +       }
> +       mutex_unlock(&vm->process_info->lock);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0d685577243c..b2c7449ab561 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1307,6 +1307,7 @@ int amdgpu_vm_clear_freed(struct
> amdgpu_device *adev,
>   * @adev: amdgpu_device pointer
>   * @vm: requested vm
>   * @ticket: optional reservation ticket used to reserve the VM
> + * @valitate: whether to auto-validate invalid DMABuf imports

valitate -> validate

>   *
>   * Make sure all BOs which are moved are updated in the PTs.
>   *
> @@ -1317,7 +1318,8 @@ int amdgpu_vm_clear_freed(struct
> amdgpu_device *adev,
>   */
>  int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>                            struct amdgpu_vm *vm,
> -                          struct ww_acquire_ctx *ticket)
> +                          struct ww_acquire_ctx *ticket,
> +                          bool validate)
>  {
>         struct amdgpu_bo_va *bo_va;
>         struct dma_resv *resv;
> @@ -1337,6 +1339,12 @@ int amdgpu_vm_handle_moved(struct
> amdgpu_device *adev,
>                 spin_lock(&vm->status_lock);
>         }
>
> +       /* If we're validating user BOs, splice all evicted user BOs into
> +        * the list of invalid BOs for revalidation
> +        */
> +       if (validate)
> +               list_splice_init(&vm->evicted_user, &vm->invalidated);
> +
>         while (!list_empty(&vm->invalidated)) {
>                 bo_va =3D list_first_entry(&vm->invalidated, struct amdgp=
u_bo_va,
>                                          base.vm_status); @@ -1357,17 +13=
65,120 @@ int
> amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>                         unlock =3D false;
>                 }
>
> +               /* Automatically validate DMABuf imports in compute VMs, =
if we
> +                * have a reservation, or remember them for later validat=
ion.
> +                */
> +               if (vm->is_compute_context && bo_va->base.bo &&
> +                   bo_va->base.bo->tbo.base.import_attach &&
> +                   (!bo_va->base.bo->tbo.resource ||
> +                    bo_va->base.bo->tbo.resource->mem_type =3D=3D TTM_PL=
_SYSTEM))
> {
> +                       struct ttm_operation_ctx ctx =3D { true, false };
> +                       struct amdgpu_bo *bo =3D bo_va->base.bo;
> +
> +                       if (!validate) {
> +                               r =3D amdgpu_vm_bo_update(adev, bo_va, cl=
ear);
> +                               if (!r)
> +                                       amdgpu_vm_bo_evicted_user(&bo_va-=
>base);
> +                               goto unlock;
> +                       }
> +
> +                       if (clear) {
> +                               pr_warn_ratelimited("Invalid DMABuf impor=
t is busy in pid
> %d\n", vm->task_info.pid);
> +                               r =3D -EBUSY;
> +                               goto unlock;
> +                       }
> +
> +                       amdgpu_bo_placement_from_domain(bo,
> +                                                       bo->preferred_dom=
ains);
> +                       r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &=
ctx);
> +                       if (r)
> +                               goto unlock;
> +                       r =3D amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_=
KFD,
> +                                               true);
> +                       if (r)
> +                               goto unlock;
> +               }
> +
>                 r =3D amdgpu_vm_bo_update(adev, bo_va, clear);
> +unlock:
> +               if (unlock)
> +                       dma_resv_unlock(resv);
>                 if (r)
>                         return r;
> +               spin_lock(&vm->status_lock);
> +       }
> +       spin_unlock(&vm->status_lock);
> +
> +       return 0;
> +}
> +
> +/**
> + * amdgpu_vm_fence_imports - add fence to valid DMABuf imports
> + *
> + * @vm: requested vm
> + * @ticket: optional reservation ticket used to reserve the VM
> + * @fence: fence to add
> + *
> + * Add the specified fence to all dymanic DMABuf imports that are valid.
> + *
> + * Returns:
> + * 0 for success.
> + */
> +int amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
> +                           struct ww_acquire_ctx *ticket,
> +                           struct dma_fence *fence) {
> +       struct amdgpu_bo_va *bo_va, *tmp;
> +       struct dma_resv *resv;
> +       LIST_HEAD(imports);
> +       bool unlock;
> +       int ret =3D 0;
> +
> +       if (!vm->is_compute_context)
> +               return 0;
> +
> +       /* Move all the DMABuf imports to a private list so I can reserve
> +        * them while not holding te status_lock.
> +        */
> +       spin_lock(&vm->status_lock);
> +       list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> +               if (bo_va->base.bo && bo_va->base.bo->tbo.base.import_att=
ach &&
> +                   dma_buf_is_dynamic(bo_va->base.bo->tbo.base.import_at=
tach-
> >dmabuf))
> +                       list_move(&bo_va->base.vm_status, &imports);
> +       }
> +       spin_unlock(&vm->status_lock);
> +
> +       list_for_each_entry(bo_va, &imports, base.vm_status) {
> +               resv =3D bo_va->base.bo->tbo.base.resv;
> +
> +               /* Try to reserve the BO */
> +               if (dma_resv_trylock(resv)) {
> +                       unlock =3D true;
> +               /* The caller is already holding the reservation lock */
> +               } else if (ticket && dma_resv_locking_ctx(resv) =3D=3D ti=
cket) {
> +                       unlock =3D false;
> +               } else {
> +                       WARN_ONCE(1, "Failed to reserve DMABuf import");
> +                       ret =3D -EBUSY;
> +                       break;
> +               }
> +
> +               ret =3D dma_resv_reserve_fences(resv, 1);
> +               if (!ret)
> +                       dma_resv_add_fence(resv, fence,
> +                                          DMA_RESV_USAGE_BOOKKEEP);
>
>                 if (unlock)
>                         dma_resv_unlock(resv);
> -               spin_lock(&vm->status_lock);
> +               if (ret)
> +                       break;
>         }
> +
> +       spin_lock(&vm->status_lock);
> +       list_splice(&imports, &vm->idle);
>         spin_unlock(&vm->status_lock);
>
> -       return 0;
> +       return ret;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 939d0c2219c0..2db04b8fef97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -443,7 +443,11 @@ int amdgpu_vm_clear_freed(struct amdgpu_device
> *adev,
>                           struct dma_fence **fence);  int
> amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>                            struct amdgpu_vm *vm,
> -                          struct ww_acquire_ctx *ticket);
> +                          struct ww_acquire_ctx *ticket,
> +                          bool validate); int
> +amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
> +                           struct ww_acquire_ctx *ticket,
> +                           struct dma_fence *fence);
>  int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>                                 struct amdgpu_vm *vm,
>                                 uint32_t flush_type,
> --
> 2.34.1

