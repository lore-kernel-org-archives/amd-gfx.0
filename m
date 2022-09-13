Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BFDECAAD8
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 20:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD22710E490;
	Tue, 13 Sep 2022 20:53:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC5510E490
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 20:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvPz40N07UDChwgtd4GhjJSBbwzwiKw8kCtcgW2z+T+9EuMFzuPt/Bjh0GRoh1ul16ZDh+JxCHJr2hpzXgnRwoLgJHBt1e3idw7r6En6OyyOl/s3Be2XiyvA9WwcrzI9+1Ek1Y9Zd4yefpfrchr1s/TOiaa+n77yUIsY/ROEVGBe/BqAt4xsKGzbVgo8TYos4dZf9KmD73uKdrKvFRIVerENMolv0WPlewL9brfxP7+4DVC8iEFQJBzu78Pco5GasfpGRC0hlD3g5apLDzMFYkJifoRiNI7zQJ2Ivl/ItASIRIYqbtEKJc1GHwKsXGLZQsMGbx7ny/2XGsevmqW0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haZ87jqV+qOZ8my81bV/KF/Y4ry/i9yexw5i9bba+Ic=;
 b=n/FMDAGQT8zxbLyW/d6g/3alO0zCUGo0JPV3+VnETHIqhrjlUd90gCUXnaWxMoN7oRJm63exaE8Yoxx/V7oCs82V+ZFWeSDBqeS2/Q/DSXzsQD9bLBnO+r1vQcTpOzxCgeVaGGNiVVTz7gkRqmcmi8p9YWxFeUiBLHxgk8Ks2Y5am2I+wnelzFGmxkmG+JYaSR250/feks51deLXOSmd7b4+JGHURJuTL055aGc12lE7VqST8aBFN6F98WMGn/JLFNv3nRVXqaznJ2PjbCY5W74gt8eCfHuDfhBkbVZDplmCEMrAtMmZqPDwdYt5Yd0PL1MdZ+tE8kec9YoK28KBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haZ87jqV+qOZ8my81bV/KF/Y4ry/i9yexw5i9bba+Ic=;
 b=h9tZcz54TP0ovjd6TzjB4jwYUst52S73efL2Nbk/Y2m/PXa7ec2RNpgU21IiaW4g5C78aANOr4uO9uQb6LbJoRUEK/2onLlbOnjGy1/YFpG0Ozm1ogOWiU+GdHltfZDxSd7nsmD7XxgbV+uOcCGJzib0dyxH5FAKuowoAvs4DJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 20:52:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 20:52:51 +0000
Message-ID: <448c338e-1b05-9de2-2dbd-6550b5c60f55@amd.com>
Date: Tue, 13 Sep 2022 16:52:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/7] drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20220912123640.20058-1-christian.koenig@amd.com>
 <20220912123640.20058-6-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220912123640.20058-6-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN9PR12MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: b78a6384-d90f-4393-86fb-08da95c9ec46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSX78D04XmbTphP6g/tOqDUYzQqZLA1nU1bMem4z39h0YkUN8psH8u1eR0qwtJJ76+j4i/F7v7HvBZkFYu51s5cy0jXqpbHiyTNzPafDn2EaEGNtHS0UHf954lQ2+ZW5NMeL6NnepycyBUMG43eo+YY8G3eRl/19NUZBk4hagm34cRz/PXAxvIFXDFaLRU7PkS39y/gy1pG/tHJXK4C7M+pVrCyKF5amZrqbTSY816W3zKTn0p5i6yW1WtylEqpf2TYG0RmFXWtqvzlMZb+Xvu3P57jrQsSZ2gH0euSty5IujZ/A6YXJP1a3eqA1yBMj/29SUv/ajixCyaH462puQLn7gGFZmNSrHW36C7gDH8BCaBoWWAdZNLwmt5A/Z/drwbqVK635+sAiuHwZAagzfdjvfSZS6JVrhfZft7MuX9v+UmHShutVI4SnPDwFJrH4qGADUs5VfqSzmzpYyRDESnbaiOyetSrHNz9eCwDkw/mO+BGt3fR51Q8GujDWQuGHPa4+haOzfohVzKRTqNH4vEm28oJpvNAl534e5I20xU1q7Ic2N9zkX1CBTbuUGXxhc/WUKcrAVbpwVn4OkWAGWFEnYMfZUGCIK1UIKLu9EaN+SULcNzDNavpnWod/mciwuuKmOnifIN6cE2Y1C5gOo5Zls5JjVWrTLhCUV8K9dmIRWY0mzk6TcQWi0G4GthCpg3gh6MTXatIPxEjg/7UHnNRgrPADhcxHSAz4PNS9XKYHBeL/eddZ4F60MSKnR2TFGdo/5YzyxJ6ks7qWcuGmOBHqtyUiKbFvw+4G2wVKGAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(66574015)(6486002)(478600001)(66556008)(4326008)(186003)(2906002)(8936002)(66946007)(2616005)(36756003)(44832011)(6512007)(31686004)(26005)(38100700002)(83380400001)(8676002)(31696002)(5660300002)(86362001)(316002)(41300700001)(6506007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGNQRnNVSlFwTlY1NVFwb3R6NUtrQlhZZXovOG5yWWN3cUNpeW1zK1p6NHRF?=
 =?utf-8?B?L0ZDdzlKaWJ3L3dDSW1HYmlnYkd1TlZBa29FSDhBMDJ0cTNYL0tGdi8zNDNo?=
 =?utf-8?B?Rk5pMm5MMFBzblA5eVZPRThqY09tOTZ5RzN6Nkt6MlAwUURnZmhvcm9vdTlF?=
 =?utf-8?B?aEh1SHVjS0hQTDQ2MjF6YUJlT2IreitPL0VMQUVZelZRb3J6dGJHTEppdEVD?=
 =?utf-8?B?eFlZTjIzNFFxQnNscHJXd01NcUZjZHptd0pCV0JYdnZudkowWE10OWVhUVk2?=
 =?utf-8?B?WU1yd0txZVJtaENFdmFabHdJQTA5QWFjTnZYcFZMMjZ3UzQvODZHV2VvRzFi?=
 =?utf-8?B?RzlXL2lqV2t2VHRQNkxLd3oxaXlQYmRYU1hmVWk2aytmSUpmbFZlc3BkaFMy?=
 =?utf-8?B?dDBkZXJPYkI3emZ4ZktqeDJoMVZDajk2S1lPUkVaRVI2L0cxT0pvTUUzUEl1?=
 =?utf-8?B?SHJtSEhjZ3RiTDN4dXBJa0I2NG1MVDNTSkJaaDl1ckpDTWhRWUNseUJscVM0?=
 =?utf-8?B?NDU4Z3J2K2NYS2FLdlNaTFhDNE51Mk5La2J6cnZKQnF6Vjg0TXhBRWFrbnpH?=
 =?utf-8?B?eHVENGVIYW83MzVPZUZ1YU1ENTZRS1hMWkdKQ2tNbjNkN1NiVlczTUJBbmNR?=
 =?utf-8?B?dVptdTdNcDdtMFg0Wk9Jb1pBdm00VzAyNVhXY3Z1UHh4TVBtV2JRYzZTTytj?=
 =?utf-8?B?SDA0dnQ3YzZwWFd5d2tweEdka3JpYkN5ditUck13M2UwdjlrNVplQmhXd3M2?=
 =?utf-8?B?K0l1UmdFNWdIalpjSWFKRGVXWnJ2YVQ3NTR4MFY3WU9RWXBtanE1SlUvT1gv?=
 =?utf-8?B?bnRzQkZFNm1heTB1WlZhOFZCQVN4cGJzUUVOKysvcDVOL0FuSHVOczRBNmdR?=
 =?utf-8?B?T2VXQzkwRElZZVZUUGZCNWdnRUU1K1p0dDNwSVkvZFI1aFpnb3hEVnZ4bk5w?=
 =?utf-8?B?bHEvRVZCbmY3YjdjeWJBVy9IbWlCRFN5Z0lyUGY4OGV6YUh0RG1XalBGWFdw?=
 =?utf-8?B?NTlZWldYUURjQ25iUk9PQndWd1JVQ0dzdDdueGJGQ05RZE1pNXJ1Q2JpcmZI?=
 =?utf-8?B?M1lQaDVlcU1CenRWaVNzUU5jSmdtM0JvcHJJeU9FMUo0Zzl6Yk90dzJ0V00x?=
 =?utf-8?B?MGNBd2p1N3lDVklnaGNWZ1Vwb3dKcUltTU5Wc09VWVhqOXBiYXZiaTlXK2hN?=
 =?utf-8?B?TFBjTDloYXR4eE1oK1dndGFNcWRqczFSL0FiTVhOalJxK2FXR3M1Y0VCeGZK?=
 =?utf-8?B?WThQYjNXdDlMN2N5UmxMUlJSZ1loTWxJSW1mSEQ1SVQ1MWU2OXZZdE9VbzJr?=
 =?utf-8?B?Rnoyd3ZNTTRHYkRORW5sNi9qclNWNGVZQ1dJdzVlRXF4OVgwRnpUZUNlRHJB?=
 =?utf-8?B?bnAvWlpFMUxiSk5CV1hVSUZEV3pxOXFyUHFUMUpTRThJNGREbEZYdENoL25G?=
 =?utf-8?B?aUVoaWZRdU9ySEJWZWlzbkRUbnp6SVROZUJSSmdJQmx3OEtRMXErQWtvdTVw?=
 =?utf-8?B?cUEvd3lnd2gxYWQvQVZTcVhUYU9mQ1FCMUx4KzZNeVY0Znc5bmdaNmwvcGNV?=
 =?utf-8?B?UFg3aFBMMGFVWDhJVVRGRGNyMHhQdVVtZ1lsRk4rVHJQai9ma2twQXZ5bllP?=
 =?utf-8?B?aWQxd2lRYnFSMXdERGhHaUhkUFppVFAyMjgwWWVJTWxISXc1Q3c0MVY5TVlj?=
 =?utf-8?B?MC95MHNoaFpvTUszMWNzcW9GMGp4Tzl6Z2VRQW12OERTMS83VlphY2hwQlVs?=
 =?utf-8?B?eHFLdHpqRjhwWTRVMjJDUW1VZ1JQNUo0NU1MbFlxZldIcytxYjV3Wk5uRmp3?=
 =?utf-8?B?V2tqUzh1T25TazV3Z0tyUUVrdlhRWHZpeXdiZU5SWXAwT1pKL2N1OU93WFNH?=
 =?utf-8?B?SHZqRTJ0MDUrNG1wVWZJZ2p5b0kzbUM1UEJzLzdsYWQvK29qTlVtaWhHNVdO?=
 =?utf-8?B?WlFEYUVHNENHdStOd2R0SzY2Yzh1K3RKUm5LQ2xhaEllWVk4Yk5uTnZWMSsr?=
 =?utf-8?B?NXY3WSt5ZFp4eVBpRUtPMEw2dW5CV3BpOEhXNTE3ZzQ4Q29vYXBZMWNWeCty?=
 =?utf-8?B?clUzcDdtRXdmdVRlWWdwQkN6SmhMRWdlVEpJUHduNW9rU1JTdjRHazNvR1k4?=
 =?utf-8?Q?hU9sXVsMEQmWOEemep3Px7wgb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78a6384-d90f-4393-86fb-08da95c9ec46
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 20:52:51.3075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Id0YwD8Hpnjj5ukdQmagEaYsr+YfkJa5DKLGUNqXLwBozp4kvf4Fbae2SfuMcWyzBkTlWTTg0+D3j0wh4rn+Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-09-12 um 08:36 schrieb Christian König:
> Use DMA_RESV_USAGE_BOOKKEEP for VM page table updates and KFD preemption fence.
>
> v2: actually update all usages for KFD
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 26 ++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |  3 ++-
>   2 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index f4c49537d837..978d3970b5cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -298,7 +298,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
>   	 */
>   	replacement = dma_fence_get_stub();
>   	dma_resv_replace_fences(bo->tbo.base.resv, ef->base.context,
> -				replacement, DMA_RESV_USAGE_READ);
> +				replacement, DMA_RESV_USAGE_BOOKKEEP);
>   	dma_fence_put(replacement);
>   	return 0;
>   }
> @@ -1391,8 +1391,9 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   	ret = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
>   	if (ret)
>   		goto reserve_shared_fail;
> -	amdgpu_bo_fence(vm->root.bo,
> -			&vm->process_info->eviction_fence->base, true);
> +	dma_resv_add_fence(vm->root.bo->tbo.base.resv,
> +			   &vm->process_info->eviction_fence->base,
> +			   DMA_RESV_USAGE_BOOKKEEP);
>   	amdgpu_bo_unreserve(vm->root.bo);
>   
>   	/* Update process info */
> @@ -1989,9 +1990,9 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	}
>   
>   	if (!amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) && !bo->tbo.pin_count)
> -		amdgpu_bo_fence(bo,
> -				&avm->process_info->eviction_fence->base,
> -				true);
> +		dma_resv_add_fence(bo->tbo.base.resv,
> +				   &avm->process_info->eviction_fence->base,
> +				   DMA_RESV_USAGE_BOOKKEEP);

This removes the implicit dma_resv_reserve_fences that amdgpu_bo_fence 
used to do. Do we need to add back an explicit dma_resv_reserve_fences 
somewhere here?


>   	ret = unreserve_bo_and_vms(&ctx, false, false);
>   
>   	goto out;
> @@ -2760,15 +2761,18 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   		if (mem->bo->tbo.pin_count)
>   			continue;
>   
> -		amdgpu_bo_fence(mem->bo,
> -			&process_info->eviction_fence->base, true);
> +		dma_resv_add_fence(mem->bo->tbo.base.resv,
> +				   &process_info->eviction_fence->base,
> +				   DMA_RESV_USAGE_BOOKKEEP);

Same as above.


>   	}
>   	/* Attach eviction fence to PD / PT BOs */
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   			    vm_list_node) {
>   		struct amdgpu_bo *bo = peer_vm->root.bo;
>   
> -		amdgpu_bo_fence(bo, &process_info->eviction_fence->base, true);
> +		dma_resv_add_fence(bo->tbo.base.resv,
> +				   &process_info->eviction_fence->base,
> +				   DMA_RESV_USAGE_BOOKKEEP);

Same as above.


>   	}
>   
>   validate_map_fail:
> @@ -2822,7 +2826,9 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>   	ret = dma_resv_reserve_fences(gws_bo->tbo.base.resv, 1);
>   	if (ret)
>   		goto reserve_shared_fail;
> -	amdgpu_bo_fence(gws_bo, &process_info->eviction_fence->base, true);
> +	dma_resv_add_fence(gws_bo->tbo.base.resv,
> +			   &process_info->eviction_fence->base,
> +			   DMA_RESV_USAGE_BOOKKEEP);
>   	amdgpu_bo_unreserve(gws_bo);
>   	mutex_unlock(&(*mem)->process_info->lock);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 1fd3cbca20a2..03ec099d64e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -112,7 +112,8 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>   		swap(p->vm->last_unlocked, tmp);
>   		dma_fence_put(tmp);
>   	} else {
> -		amdgpu_bo_fence(p->vm->root.bo, f, true);
> +		dma_resv_add_fence(p->vm->root.bo->tbo.base.resv, f,
> +				   DMA_RESV_USAGE_BOOKKEEP);

Same as above.

Regards,
   Felix


>   	}
>   
>   	if (fence && !p->immediate)
