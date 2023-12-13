Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BABC4167D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 14:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3446A88130;
	Wed, 13 Dec 2023 14:30:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4F410E2AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 14:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEet2f6CSIwTzd/tNeFg1jZ5qAChXodz1JIi4vd8I858W1oc4WpqpDYvHomyG03khZ0mAv4v74JeaaLDKjqiG/KPO8K/kU41qZnO+XtWuwhlVZjMhY5tII2IaQpP3v0AQa8VUEn82ctgYf4lPfLHWMTotXEYU4vNip+h9bPZkvrtTS9XpZfBVz/SXx8vxO1ahnvP4M6pXm4KfUKGpP8uCKAvxm00C9bySUxmxTGBi/xZYC2k9BZa3/aTxohTFuFPiUgNdklT/HwI5DQVmtHsgnHpe4Swyaoydklwy81OkWLfkZ6k3NT9RqqF+9/zafijaFBh8JVZ4LR3acvp8QkrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr4cecpXUisrTVu+3DNFzqk3ohUs1kjUbBXdO6iLtJs=;
 b=fvE5R9MJ/wAQ2IRseV1LpqlY5stFYYoFPpwsuL2WYcs3FM1sDOaXYJQUyCN6ViZ93TI+SPfnw5BYuAqSY1GneTDbhcZfV5oQAx2NQUdp7+19QlStwBsGxqd6l9RcHrShaH7amIaSOC72cPpG3rgD1H+QURWtsv04HSspIUjG7K9/Pd5SIRKxgyjTsvVPQurh1RgISuY2fM54B1Ek3gcpHQfhFPOXn1wH3wyJfpqy4dkRYuKasrBP5QDd2Q3096hV41pLUdY2XpbyxEDYILZJVWxmWkZkckmCHudNOUneBDG1VM3S1ABHAVXtwwzM30w6Y+APGS3CPTTDY3KKS4KAkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr4cecpXUisrTVu+3DNFzqk3ohUs1kjUbBXdO6iLtJs=;
 b=elzL4v2T/V+Li8O2agbNp3LqdqZfDNlwAHKprZMttYKyY6IPWz9dnntsLzdw69Do2T85+6TlceydT/Pc5ZQNdIhjW8lkWNIO08S+RnhMlZcAjbVBlBC/mVnix3z3Dbz/Vfe9AzViN+0dvNNKsQ6zR3RquVnxLJ/Dl3Nu7gNtDvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.33; Wed, 13 Dec 2023 14:30:46 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 14:30:46 +0000
Message-ID: <88e15819-885e-45f6-8f31-1df647383195@amd.com>
Date: Wed, 13 Dec 2023 15:30:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Auto-validate DMABuf imports in
 compute VMs
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231206214413.2440998-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231206214413.2440998-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: b30be561-fb49-43d6-905c-08dbfbe8185c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ivaa8pKNQRpcTGYM0ZSG7Sq21wTTaUmnptdF7ITMnltP2jqJZ3xBwNyU+njB5TZsyjppROiKWF/804ZSVQo5RBCCrlJqGUNbZRUhuULZ6XKNHO8Uj1BtNJQ/G1PiGgd2XCw2nj3Syb5Ym7KMh6t6mNCPsLYOmimkT5Dx90O+Gsa4bpKoxP/Lrji5egquYTfbKRJROoRMc5QPgfLNveVHtchhfxyI2L0ixveeXXSRHJ7la2OIdYgpzwIRJZzjLD76wFQXZEffzKLkBnlWRfvGH7HfnSNBB2kcB3R7LSRBNf2CTy8jhd1RR8MSkGbe1ykKL333Ig9NeRPin/Y+H3Jkaeq+sBL8MRZiCffjOUjvE9bG+2e9oiaqRAZgC8eo9POfFgIwsZOYhxFkaQWoIS8842KrqiqASDkbEq0hJJ1LeB6lu9nH6Uy2o7mDzaI0z8GF9Yuxk3iohyjrS1eTCJOaqv+xfrd8/h8mgCVB10HXUF0R5ObsSdydqScWkvAZ/ioKiCbVIaydUNxFsMEow/LhiK1u5AWypE92TwqsHc61PMaPnIXgthEXgYMjzw99B9FvOBxsiAAJlXGzC8QNmHoSdCVD8d3RqAOv4jZYJ+8Z1URkT1L7o+LV5+7uJQQqInsWNWsXW83uEwkPP2a1jS5yGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(83380400001)(6506007)(2616005)(6512007)(38100700002)(5660300002)(4326008)(8936002)(8676002)(41300700001)(30864003)(15650500001)(2906002)(6486002)(478600001)(6666004)(316002)(66476007)(66556008)(66946007)(31696002)(36756003)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUpSSTFzNld3OHozaGNkL2NFalRWaTZTMFl6TWVvT2U4MXJYdXh4c3VQdmhy?=
 =?utf-8?B?OGNKaUxzMWdLQTgyZ3NBYlFCcjQ2ZVVyajZ4ZGZDWEtJSjIraEl5QkM3VElh?=
 =?utf-8?B?TStnaWwveXdvVE12RXNXT0JKMCtHa1ZLSCtKQitZSGhvRnhQN25RZHN6TFFM?=
 =?utf-8?B?Y1RKeFZNNGsvQ0FPNE5sWVBJUXl4dW1NbUV1RHpRQVd1UUptZ3pVS1pJVjNm?=
 =?utf-8?B?Q3E4eXNRckpweEJsZnRPeDRvQWptaFBmRm5wZkVXZ3ptYUE0MjBaZVdLUGhZ?=
 =?utf-8?B?NWNZTGtNREVJT1o5WEpjZlhUZ0ZPWk41cmxyN1EwQTM1TDNEK0Iwa0w4Vllr?=
 =?utf-8?B?YlIrOW1HOVBIR1R4RjArUVFVT2hOcUlCeEFSTXhMclhBQTlnUmdJT1o2YVc1?=
 =?utf-8?B?b0JsMUtLOVBtcXB3SzFvUDRwOXExaTR2djFFREcrNXZ0blJFM0VRUlJic0w4?=
 =?utf-8?B?aHNZTVR2dnRhVkwwRU95MHRPaG9HeUJjK0tVekgvTzZZN2lLNHhhZTRQQmc3?=
 =?utf-8?B?a2FFZC9PaXhNTUVFZFo3WkpTYWlJK01WSDBuNGtjRVdaZC9RcWZteVU0VUZt?=
 =?utf-8?B?bnd2MHBvQkxMcUdrOCtSL0hmM2VPaFRZR3ZOMjhWeUxqQXN4M29OWGN6eUdF?=
 =?utf-8?B?ZEVWS21WTXFES0NTckg5TUk4Z0R5ZjRRUzZFdEdVVmozaVJMM1FlaGZUZUFN?=
 =?utf-8?B?WWhYTDJiZXZzdzdvQmkrVm95VUp1UVhFMndteUZ4ZW1XamtGWjFUbmhYRS9L?=
 =?utf-8?B?eXIvczZwclgzNUJCMjI5OW12VjFuS3NxWCthdWlIRUNaMVR0KzBDdHc5bWJB?=
 =?utf-8?B?dlByem83RzZyN0UxN29zQkZBT2Z6bWN5dW9aRlpKTEc2aWR1aHhaVkdsMlQy?=
 =?utf-8?B?MkRvSFNYc08rNTBHa0RzUG5Ia2h2WVhUbXVHMWhTdnJHL2h6UlpFSkhWY2xt?=
 =?utf-8?B?MWViaDZrQUtrcW9NKy9kLzhNK1BhS1BUdFR5S0I3UFBmeFlnY0FnWHNBMlp4?=
 =?utf-8?B?Wk1pdlJPTXZVNGIreFJoeW9LNWYyNkpVZ05yblZxaXM5OCthR3FkOVJmTGcy?=
 =?utf-8?B?bDRqeHJDUWp1UlRFRGwvYUlsRVdZWk90d3J5SGFXaEh1WUtkQVk2dGZZdUFY?=
 =?utf-8?B?USt2RWNMb2NUYkpCbGJyTXA4VWRQcTc2bnJtOXA2T1dLbk1NeXgrNW1LcEZJ?=
 =?utf-8?B?c0pmYnBUYStiSGxnSDZpRVVFQkViYkxKbTNDaWNRS0d2ZnFncFJwbnlFZmx4?=
 =?utf-8?B?bmllRWx6elNlcHpweXhRWmxtZ1NZUXY2UjFFZVdPa256amViK2hlQkFzVlBt?=
 =?utf-8?B?Y0paRXBzUUhMdURWMUhxQXh0cEcvcTRjR3hEK0pFL0QyNUNtekNSYWtwQnFl?=
 =?utf-8?B?QnJzbjZOQ3Y1K2xnQnlxNGg0SGJoU3RKUWhXUUFaNnJicXh4enJ6WnFQYito?=
 =?utf-8?B?SUpKRDA1YW1lN2lZcS9hZDZsSUxiRHAvc0UyWW8wQVViRThYeXZZTG42Tm92?=
 =?utf-8?B?TXhLYU1xTGE5czJFREVZdzBuN1NETlh4Zkl4ZjBKNTJrSGpwSE53RTRRT0RW?=
 =?utf-8?B?a2hCWU1lK0lPMnB1S1Bsc3JIV1A1N29BWnpmcHVxdWdNQ0tmZXNTTUF4RHhj?=
 =?utf-8?B?cDIrK0Q2YmtuenAvUTViV1U5Qmx5VFFSZWlVcStJR21FMzRoRXJMSXo3NWs3?=
 =?utf-8?B?aFlXcmoreXJHRG42Q1RoRUhpUDFJdkZrdGdYcnF1dlZubG5jYXBnYlJCNnRq?=
 =?utf-8?B?U0FVVnRKYVhrSHRMKzh2RTlqL2RMbi85R1JGaTlCTmlEMW41UTlrdGNwUGxJ?=
 =?utf-8?B?SURQSlA1VStTREhTSG04dTJJSVZZZEI4VDRJUU53UHpHTG8xRXN4SExtVmNF?=
 =?utf-8?B?VVkxM0xYcUtuZ0VvWTNYS21MYWhUTk5ySjd6ZGF4TTBSeGFOaXRQZkE2WHMr?=
 =?utf-8?B?Y0dzSGozT1lRTTd6M0dNVjk5RFFSRUN6RFpDaVpzZlVvbUIwR2tPUG82OFMr?=
 =?utf-8?B?eUc3ajJrWU5jMENNRnJkamdDUDBrbnZLSlFhK1JTMk1yZWszK2wrYjIrbGJl?=
 =?utf-8?B?VTlKbGo0QldqbjBqckRrV3g2VWVYZ2hiM2Q2TFVDbk5salkvUC9hOU43eGNF?=
 =?utf-8?Q?nuDYL6UZU828l9e1Bp8gAuzdU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30be561-fb49-43d6-905c-08dbfbe8185c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 14:30:46.4757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +szt0yxRkAQda51Pn4YzhPVwgga1JHYfHs8PZxm0RrcAob1JJmjZhOwnCr4Tqthy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962
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
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.12.23 um 22:44 schrieb Felix Kuehling:
> DMABuf imports in compute VMs are not wrapped in a kgd_mem object on the
> process_info->kfd_bo_list. There is no explicit KFD API call to validate
> them or add eviction fences to them.
>
> This patch automatically validates and fences dymanic DMABuf imports when
> they are added to a compute VM. Revalidation after evictions is handled
> in the VM code.
>
> v2:
> * Renamed amdgpu_vm_validate_evicted_bos to amdgpu_vm_validate
> * Eliminated evicted_user state, use evicted state for VM BOs and user BOs
> * Fixed and simplified amdgpu_vm_fence_imports, depends on reserved BOs
> * Moved dma_resv_reserve_fences for amdgpu_vm_fence_imports into
>    amdgpu_vm_validate, outside the vm->status_lock
> * Added dummy version of amdgpu_amdkfd_bo_validate_and_fence for builds
>    without KFD
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  10 ++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  44 +++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  28 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 101 ++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  10 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  10 +-
>   8 files changed, 177 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f262b9d89541..584a0cea5572 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -191,6 +191,9 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
>   int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
>   int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
>   				unsigned long cur_seq, struct kgd_mem *mem);
> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
> +					uint32_t domain,
> +					struct dma_fence *fence);
>   #else
>   static inline
>   bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
> @@ -216,6 +219,13 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
>   {
>   	return 0;
>   }
> +static inline
> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
> +					uint32_t domain,
> +					struct dma_fence *fence)
> +{
> +	return 0;
> +}
>   #endif
>   /* Shared API */
>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 5f445d856769..fbabb1e63a67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -426,9 +426,9 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
>   	return ret;
>   }
>   
> -static int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
> -					       uint32_t domain,
> -					       struct dma_fence *fence)
> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
> +					uint32_t domain,
> +					struct dma_fence *fence)
>   {
>   	int ret = amdgpu_bo_reserve(bo, false);
>   
> @@ -464,13 +464,15 @@ static int amdgpu_amdkfd_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
>    * again. Page directories are only updated after updating page
>    * tables.
>    */
> -static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
> +static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm,
> +				 struct ww_acquire_ctx *ticket)
>   {
>   	struct amdgpu_bo *pd = vm->root.bo;
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
>   	int ret;
>   
> -	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate_vm_bo, NULL);
> +	ret = amdgpu_vm_validate(adev, vm, ticket,
> +				 amdgpu_amdkfd_validate_vm_bo, NULL);
>   	if (ret) {
>   		pr_err("failed to validate PT BOs\n");
>   		return ret;
> @@ -1310,14 +1312,15 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
>   	return ret;
>   }
>   
> -static int process_validate_vms(struct amdkfd_process_info *process_info)
> +static int process_validate_vms(struct amdkfd_process_info *process_info,
> +				struct ww_acquire_ctx *ticket)
>   {
>   	struct amdgpu_vm *peer_vm;
>   	int ret;
>   
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   			    vm_list_node) {
> -		ret = vm_validate_pt_pd_bos(peer_vm);
> +		ret = vm_validate_pt_pd_bos(peer_vm, ticket);
>   		if (ret)
>   			return ret;
>   	}
> @@ -1402,7 +1405,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   	ret = amdgpu_bo_reserve(vm->root.bo, true);
>   	if (ret)
>   		goto reserve_pd_fail;
> -	ret = vm_validate_pt_pd_bos(vm);
> +	ret = vm_validate_pt_pd_bos(vm, NULL);
>   	if (ret) {
>   		pr_err("validate_pt_pd_bos() failed\n");
>   		goto validate_pd_fail;
> @@ -2043,7 +2046,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	    bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
>   		is_invalid_userptr = true;
>   
> -	ret = vm_validate_pt_pd_bos(avm);
> +	ret = vm_validate_pt_pd_bos(avm, NULL);
>   	if (unlikely(ret))
>   		goto out_unreserve;
>   
> @@ -2122,7 +2125,7 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		goto unreserve_out;
>   	}
>   
> -	ret = vm_validate_pt_pd_bos(avm);
> +	ret = vm_validate_pt_pd_bos(avm, NULL);
>   	if (unlikely(ret))
>   		goto unreserve_out;
>   
> @@ -2620,7 +2623,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
>   		}
>   	}
>   
> -	ret = process_validate_vms(process_info);
> +	ret = process_validate_vms(process_info, NULL);
>   	if (ret)
>   		goto unreserve_out;
>   
> @@ -2880,11 +2883,6 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   
>   	amdgpu_sync_create(&sync_obj);
>   
> -	/* Validate PDs and PTs */
> -	ret = process_validate_vms(process_info);
> -	if (ret)
> -		goto validate_map_fail;
> -
>   	/* Validate BOs and map them to GPUVM (update VM page tables). */
>   	list_for_each_entry(mem, &process_info->kfd_bo_list,
>   			    validate_list) {
> @@ -2935,6 +2933,13 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   	if (failed_size)
>   		pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
>   
> +	/* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
> +	 * validations above would invalidate DMABuf imports again.
> +	 */
> +	ret = process_validate_vms(process_info, &exec.ticket);
> +	if (ret)
> +		goto validate_map_fail;
> +
>   	/* Update mappings not managed by KFD */
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   			vm_list_node) {
> @@ -3006,7 +3011,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   				   &process_info->eviction_fence->base,
>   				   DMA_RESV_USAGE_BOOKKEEP);
>   	}
> -	/* Attach eviction fence to PD / PT BOs */
> +	/* Attach eviction fence to PD / PT BOs and DMABuf imports */
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   			    vm_list_node) {
>   		struct amdgpu_bo *bo = peer_vm->root.bo;
> @@ -3014,6 +3019,11 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>   		dma_resv_add_fence(bo->tbo.base.resv,
>   				   &process_info->eviction_fence->base,
>   				   DMA_RESV_USAGE_BOOKKEEP);
> +
> +		ret = amdgpu_vm_fence_imports(peer_vm, &exec.ticket,
> +					      &process_info->eviction_fence->base);
> +		if (ret)
> +			break;
>   	}
>   
>   validate_map_fail:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index e50be6500030..dc7fac778417 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -952,10 +952,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	p->bytes_moved = 0;
>   	p->bytes_moved_vis = 0;
>   
> -	r = amdgpu_vm_validate_pt_bos(p->adev, &fpriv->vm,
> -				      amdgpu_cs_bo_validate, p);
> +	r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
> +			       amdgpu_cs_bo_validate, p);
>   	if (r) {
> -		DRM_ERROR("amdgpu_vm_validate_pt_bos() failed.\n");
> +		DRM_ERROR("amdgpu_vm_validate() failed.\n");
>   		goto out_free_user_pages;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index decbbe3d4f06..055ba2ea4c12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -377,6 +377,10 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
>   	struct amdgpu_vm_bo_base *bo_base;
>   	int r;
>   
> +	/* FIXME: This should be after the "if", but needs a fix to make sure
> +	 * DMABuf imports are initialized in the right VM list.
> +	 */
> +	amdgpu_vm_bo_invalidate(adev, bo, false);
>   	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
>   		return;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index b1ce22a9b186..68bab2879696 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -187,7 +187,33 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   	else
>   		++bo_va->ref_count;
>   	amdgpu_bo_unreserve(abo);
> -	return 0;
> +
> +	/* Validate and add eviction fence to DMABuf imports with dynamic
> +	 * attachment in compute VMs. Re-validation will be done by
> +	 * amdgpu_vm_validate and the fence will be updated by
> +	 * amdgpu_vm_fence_imports in amdgpu_amdkfd_gpuvm_restore_process_bos.
> +	 *
> +	 * Nested locking below for the case that a GEM object is opened in
> +	 * kfd_mem_export_dmabuf. Since the lock below is only taken for imports,
> +	 * but not for export, this is a different lock class that cannot lead to
> +	 * circular lock dependencies.
> +	 */
> +	if (!vm->is_compute_context || !vm->process_info)
> +		return 0;
> +	if (!obj->import_attach ||
> +	    !dma_buf_is_dynamic(obj->import_attach->dmabuf))
> +		return 0;
> +	mutex_lock_nested(&vm->process_info->lock, 1);
> +	if (!WARN_ON(!vm->process_info->eviction_fence)) {
> +		r = amdgpu_amdkfd_bo_validate_and_fence(abo, AMDGPU_GEM_DOMAIN_GTT,
> +							&vm->process_info->eviction_fence->base);
> +		if (r)
> +			dev_warn(adev->dev, "%d: validate_and_fence failed: %d\n",
> +				 vm->task_info.pid, r);
> +	}
> +	mutex_unlock(&vm->process_info->lock);
> +
> +	return r;
>   }
>   
>   static void amdgpu_gem_object_close(struct drm_gem_object *obj,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7da71b6a9dc6..ab2662ab4ab8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -426,24 +426,29 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   }
>   
>   /**
> - * amdgpu_vm_validate_pt_bos - validate the page table BOs
> + * amdgpu_vm_validate - validate evicted BOs tracked in the VM
>    *
>    * @adev: amdgpu device pointer
>    * @vm: vm providing the BOs
> + * @ticket: optional reservation ticket used to reserve the VM
>    * @validate: callback to do the validation
>    * @param: parameter for the validation callback
>    *
> - * Validate the page table BOs on command submission if neccessary.
> + * Validate the page table BOs and per-VM BOs on command submission if
> + * necessary. If a ticket is given, also try to validate evicted user queue
> + * BOs. They must already be reserved with the given ticket.
>    *
>    * Returns:
>    * Validation result.
>    */
> -int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			      int (*validate)(void *p, struct amdgpu_bo *bo),
> -			      void *param)
> +int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		       struct ww_acquire_ctx *ticket,
> +		       int (*validate)(void *p, struct amdgpu_bo *bo),
> +		       void *param)
>   {
>   	struct amdgpu_vm_bo_base *bo_base;
>   	struct amdgpu_bo *shadow;
> +	struct dma_resv *resv;
>   	struct amdgpu_bo *bo;
>   	int r;
>   
> @@ -464,8 +469,27 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		spin_unlock(&vm->status_lock);
>   
>   		bo = bo_base->bo;
> +		resv = bo->tbo.base.resv;
>   		shadow = amdgpu_bo_shadowed(bo);
>   
> +		if (resv != vm->root.bo->tbo.base.resv) {
> +			if (!ticket) {
> +				/* We need to move the BO out of the evicted
> +				 * list to avoid an infinite loop. It will be
> +				 * moved back to evicted in the next
> +				 * amdgpu_vm_handle_moved.
> +				 */
> +				amdgpu_vm_bo_invalidated(bo_base);
> +				spin_lock(&vm->status_lock);
> +				continue;
> +			}
> +			if (dma_resv_locking_ctx(resv) != ticket) {
> +				pr_warn_ratelimited("Evicted user BO is not reserved in pid %d\n",
> +						    vm->task_info.pid);

I'm not sure if that's the most defensive option. Might be better to 
handle this in the "if (!ticket..." case above.

> +				return -EINVAL;
> +			}
> +		}
> +
>   		r = validate(param, bo);
>   		if (r)
>   			return r;
> @@ -475,7 +499,13 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   				return r;
>   		}
>   
> -		if (bo->tbo.type != ttm_bo_type_kernel) {
> +		if (resv != vm->root.bo->tbo.base.resv) {
> +			/* Fence reservation for amdgpu_vm_fence_imports */
> +			r = dma_resv_reserve_fences(resv, 1);
> +			if (r)
> +				return r;

Fence slot reservation should bet done by the caller and not here.


> +			amdgpu_vm_bo_invalidated(bo_base);
> +		} if (bo->tbo.type != ttm_bo_type_kernel) {
>   			amdgpu_vm_bo_moved(bo_base);
>   		} else {
>   			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
> @@ -1425,11 +1455,21 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   		}
>   
>   		r = amdgpu_vm_bo_update(adev, bo_va, clear);
> -		if (r)
> -			return r;
>   
>   		if (unlock)
>   			dma_resv_unlock(resv);
> +		if (r)
> +			return r;
> +
> +		/* Remember evicted DMABuf imports in compute VMs for later
> +		 * validation
> +		 */
> +		if (vm->is_compute_context && bo_va->base.bo &&
> +		    bo_va->base.bo->tbo.base.import_attach &&
> +		    (!bo_va->base.bo->tbo.resource ||
> +		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
> +			amdgpu_vm_bo_evicted(&bo_va->base);
> +
>   		spin_lock(&vm->status_lock);
>   	}
>   	spin_unlock(&vm->status_lock);
> @@ -1437,6 +1477,51 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_vm_fence_imports - add fence to valid DMABuf imports
> + *
> + * @vm: requested vm
> + * @ticket: reservation ticket used to reserve the VM
> + * @fence: fence to add
> + *
> + * Add the specified fence to all dynamic DMABuf imports that are valid.
> + *
> + * Returns:
> + * 0 for success.
> + */
> +int amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
> +			    struct ww_acquire_ctx *ticket,
> +			    struct dma_fence *fence)
> +{
> +	struct amdgpu_bo_va *bo_va, *tmp;
> +	struct dma_resv *resv;
> +
> +	if (!vm->is_compute_context)
> +		return 0;
> +	if (!ticket)
> +		return -EINVAL;
> +
> +	spin_lock(&vm->status_lock);
> +	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {

Why using list_for_each_entry_safe() here?

Regards,
Christian.

> +		if (!bo_va->base.bo || !bo_va->base.bo->tbo.base.import_attach ||
> +		    !dma_buf_is_dynamic(bo_va->base.bo->tbo.base.import_attach->dmabuf))
> +			continue;
> +
> +		resv = bo_va->base.bo->tbo.base.resv;
> +		if (dma_resv_locking_ctx(resv) != ticket) {
> +			pr_warn_ratelimited("Imported BO is not reserved in pid %d\n",
> +					    vm->task_info.pid);
> +			continue;
> +		}
> +		dma_resv_add_fence(resv, fence,
> +				   DMA_RESV_USAGE_BOOKKEEP);
> +
> +	}
> +	spin_unlock(&vm->status_lock);
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_vm_flush_compute_tlb - Flush TLB on compute VM
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index b6cd565562ad..eff301976eee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -434,9 +434,10 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>   		      unsigned int num_fences);
>   bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>   uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> -int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			      int (*callback)(void *p, struct amdgpu_bo *bo),
> -			      void *param);
> +int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		       struct ww_acquire_ctx *ticket,
> +		       int (*callback)(void *p, struct amdgpu_bo *bo),
> +		       void *param);
>   int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate);
> @@ -446,6 +447,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   			   struct amdgpu_vm *vm,
>   			   struct ww_acquire_ctx *ticket);
> +int amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
> +			    struct ww_acquire_ctx *ticket,
> +			    struct dma_fence *fence);
>   int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm,
>   				uint32_t flush_type,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2834fb351818..9f29bbdb9050 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1509,9 +1509,9 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
>   			goto unreserve_out;
>   		}
>   
> -		r = amdgpu_vm_validate_pt_bos(pdd->dev->adev,
> -					      drm_priv_to_vm(pdd->drm_priv),
> -					      svm_range_bo_validate, NULL);
> +		r = amdgpu_vm_validate(pdd->dev->adev,
> +				       drm_priv_to_vm(pdd->drm_priv), NULL,
> +				       svm_range_bo_validate, NULL);
>   		if (r) {
>   			pr_debug("failed %d validate pt bos\n", r);
>   			goto unreserve_out;
> @@ -1630,7 +1630,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		goto free_ctx;
>   	}
>   
> -	svm_range_reserve_bos(ctx, intr);
> +	r = svm_range_reserve_bos(ctx, intr);
> +	if (r)
> +		goto free_ctx;
>   
>   	p = container_of(prange->svms, struct kfd_process, svms);
>   	owner = kfd_svm_page_owner(p, find_first_bit(ctx->bitmap,

