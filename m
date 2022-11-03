Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EF8C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 06:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A1410E5AD;
	Thu,  3 Nov 2022 06:59:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9AF10E5AD
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 06:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ana04kXFoRf9NYFoxGV8UGvjMMfsGA//wyj9p1xljQJJftb5Q8DjymryGYSXyfCYoB5uzdWGyy1jSuIwTH2crUrswrOr2vvhsOSCFcGola6K/O4P3/UVmA+1BfdvQWQlgELHPo5jzP3L5XAJPeyHlP0yCs2P5wjP77xO30PZAmGr813UEC3ykwcQjLeRIm1CCwX1f1NnwuwQ5emxywxo/Rji3eevJGzj6cSQEKLEB39nueO9vIEFDROQJC4fcKNX95y4YUQCghaOcdjvaghLUACVw8uvnl8hyheWLSn6WsUQY0KDKImls90FH50WT0XukMS6eoGci1jlGnG8u9MidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSEKolscqR899FX4/k/Y3TXKVy/3y4twQFn4dHO9mLo=;
 b=Y3eSp66l1xf26a9+V/e8wHEBvvPV8n5thQQFbyktSgCk8EQ9ELP01CcVGCl9FX3+n4g7zbhu8dHmujWIFVekrL2C9vEhBUIHEiJGjiASeUwG3K/5tvNIUgElVgmxtEmozY/JaP826Sd1YaWzll33v2t13MAZL0lwOKXv2aruBOPYiy4b1/PfIXsq7PVGPI9zRtsb5CesA2S0PJhk8Rb3K2ULB5E0KABNLHW/3oqd1hyg7HKok1eGPr9YJRT6l1tWj4Ud8RyEauK1pHgf4C5DdbIR3lgQqS8Ta0k5miJ8m0rXQKpeSkjN31Gcv381o2WS342MbLL4Pv9nuyzpV1iFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSEKolscqR899FX4/k/Y3TXKVy/3y4twQFn4dHO9mLo=;
 b=VocEofq2snT9oJ+jk8a6KVrQOpGr/hU7XWpkhnSsHa3Wp+fjyXnO7aZQEq1vrShgoZZLAcNCzbb0Hqc4Ct8VSSBvQGfkdRHfyhn5BrwRshK1oqATyOxxb61n3V36BvedkIX57Lc0LybwsgTT7vp8zJ+j3OG1eIaYjm0CZW8d5Us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 06:58:58 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 06:58:57 +0000
Message-ID: <c041cb08-b1e1-c730-e54f-15903106e942@amd.com>
Date: Thu, 3 Nov 2022 07:58:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/1] drm/amdgpu: Drop eviction lock when allocating PT BO
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221102211036.27784-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221102211036.27784-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0054.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::31) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fafed88-d6eb-4d8b-027a-08dabd68e0ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5SAbXuIgi7IorcqZu9+7TmmabgDSX2KF337Ax2g58Qgrc/i96CEEq755V8mRAtXy1dAiUGsbWqiksEVTLyeiKIopZEmkHtFC8BubIMneuE/0Vp0tMQR8vFfVoBY4vd5Duh1nRT0Zht/OFOotAOBSp3C4gJGpN23wvqXNjBmtO6z/YutuZVxcGMHsZT1B2WDZV1S/fxyJyDhVgn3OKfS9u5NIeJl4d07wKMxR8LeYLE/gymikZSRGDspiMGGIILqRMW+xLGR4IRPvdD8MCpWLGNgKcWZhMMVHclj0ACt3c1tfu6pGeNyZAtqVVGtR0jhwWaclpVLHdyA4DmbYKykWzuZhpZma4LmNxP9dSbt7UjdCvvLk7/s3y5mI/FD8HTNMZQkVzZMQLdveF7wweE1CC9PWEXBUSntAzS9hOlJOeQT46T9tDR+UnmWxYbci1KfNe1BoSnE3RmNAWekTd7yxxyTm6efk5FSd1UsfxlM7IwYJdpIszCvuAYlmmM/zgjMuTPyaxiFIkpWTPWgOUUjGe/77ZIPtijYotMebYyfBdS8ZZvdmzQ/BAPt31guks/xMt/j51zILGFAIpy2eOgfNq61DFRpL9G1LUNm63Lrqg/f7wKKzjNoJ4Trak1T9cNUVC+RPpyUHMX56VG/NGxkEapJ4niUmn5f+/uiAEOTarAiHxdxQ09bWwFpLeLqVh/IkDZA3btF7k5cBvShgCg48cOTdcivpDWaGGQMymGarzPQhYVUVZiA5nt8e9Hoiz6xjmJBHx4vyNAfqbjJalNCKcghqkjIP76VcoZo/KUQRT+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(2906002)(38100700002)(66556008)(5660300002)(8936002)(4326008)(66574015)(6666004)(66946007)(66476007)(8676002)(316002)(6486002)(41300700001)(31696002)(83380400001)(31686004)(86362001)(26005)(2616005)(6506007)(186003)(6512007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGZUa3FNQUtqN2xvQWtJZ3FudDJVRFZQcTlNZ2ZFOXlIK0VZUnNDd01vSEpF?=
 =?utf-8?B?czVoWDNTdktnVHNtOXNxTE1Bemp4b3NHRkFEc2xidzM2OXc2Tjg5QlY1RmFv?=
 =?utf-8?B?Sit4VXgvZUVFWDhVUnVWcGtLM21VZHJaSGtZRDZ4UjJNN2sveTAwQzN6a29G?=
 =?utf-8?B?QStCNjY2MG1YbnpvK2VtYWRRTzBFUWtMejI3VDJwOUk2WEMrdEJlNk9oek42?=
 =?utf-8?B?bkNsQXVmS2xaSmszbVhBVUlGSitaTEVhSUJhWnpSay8xRUFaNURlZk9jQS9N?=
 =?utf-8?B?U3lTVHdmYVB3blpINEJtcE9STnpWNFBzTUpUaUZyT3YrVEtML3RDV2pkNmhT?=
 =?utf-8?B?Z29oWWdqcHdNc2lxOUxEOXd5VE42TGdKVGhKOU9ESVNBNHVaeEQwWVpFSGVv?=
 =?utf-8?B?TDNPMEp6RXVTZVg2MERoaU8zQzNVYTgrdEQveXlWRzFVeVR4bDhJenV5U002?=
 =?utf-8?B?a2ltMkZrOW13RTJHOUgvNDlMTlZHcGpCREY2dkZldDA5WGtZejE0K2xTSTZs?=
 =?utf-8?B?YVg3YnZFeFVBelBSaHJ4OWVvbWhPdVEwWDJESzB4VDBEYXE4Y3kvRm5aejkz?=
 =?utf-8?B?OVB0VmQzMFlReGRRUWNwSStnbnExcFZFSGRTUFpwN3N2T3Uvdm9ncWhtNVRY?=
 =?utf-8?B?WDJXMVFLaHlsanVqeGgwUjBQNFBPQWJwVWV5dXN6RlNURCtKaU0zbCtFazM0?=
 =?utf-8?B?S0FBWVE3OUxrTDl2M0RLcU5VS0czMXJzbmcwYlN2UDJ1WExRcWc0WnQ4UzUw?=
 =?utf-8?B?R3JBYlZLajkxd2g0VjgvWEZXM0piS1BUalNPcmk5VjVwN0NoVEFXVG40Zy8y?=
 =?utf-8?B?NFFLMUJ2OTFGS2ozWm1ubTc4UktTYUlncXk2cGg3TVNHd2dTQzEvSURBTGZU?=
 =?utf-8?B?alViRVVmS0hPWXpIQkZvc2xKWjByamRxYzZ1cngzWTFnTmtqaVV6aU4zZUkx?=
 =?utf-8?B?Z3VXUGx3QnQ0NzZKTXhhNEF3c2xjRTFkVWtkbWljNGlmcGk3ckF1SFJjcmxL?=
 =?utf-8?B?THhUZzhyWE95WlYzdFJKMkFnTms1NDVLUVBLN1lqL3RiUnRyUjg2TFlvMk1P?=
 =?utf-8?B?aEQzQ1FLVkk2ZXN2Z1VTWUw5SGNMa3RzT09ZNFkxZFAzbDFDOG9MM1JMYy9M?=
 =?utf-8?B?RFR4VWoyWGIrUC9JaVNGMkRpam5tYjZDNzg1dGJyVjh4K21jRE5zQ2ZSUzZJ?=
 =?utf-8?B?bkE5czVnMXR1U1REZ3dLUGoxM2FmWkJSa0NiNzJadHRnblhiSjh6Zzk2RjJI?=
 =?utf-8?B?TUNNTkxoNEFhOE1SNnB1UVg3V0lPYURRS0lrSWpxaWpvYmE1VzBnWFRiRi96?=
 =?utf-8?B?M1NjdVZLZUhNV0R2T0lZOUY0MW5LTlhXYk9FUlV3bjBXbkhLdlUvWFhmK3lU?=
 =?utf-8?B?cmxPOGdrQVBvWm9uVlQ2VGFBWUk0VWFsbExkdTkyWEdjNnZ2d0toMk9abUgz?=
 =?utf-8?B?c1gzYnk4L0VDcE5jVnM1Vmp5cHFNNEsrUGZPMHpaSUhUa1Z1Q1J5NU9Oa05q?=
 =?utf-8?B?eHdRdUQ1TFhTd29BdVJJdmhONDVXb3pnK3FEL2d6U2J6K2liVzlkd0xQQ1da?=
 =?utf-8?B?ZEF6cUpISS9UMmw2VVliUXgwZExzN3k4TFhqOTNEY3JSbHZnaU9IQXRSa3B4?=
 =?utf-8?B?d3IrcUNMaGp2MGlFdy9BRENoVmpsZkRZdWhCdkRkVERaUEdTa3E2ekVaM045?=
 =?utf-8?B?dVJuemphMHdONm1MdlU0dlZVdnNSTjdCTC9EcU5VSDlnNTJXQmtjYjZwZmVq?=
 =?utf-8?B?cGZCZlZ5c21RMFZmWEtUUFVvWnVLNkUrb2RqcENwSFdIbm5iZUVmTldSaEpz?=
 =?utf-8?B?cDA3cExCK2UrMmNDMDNBaWlUcVl0RFRLUUhEcWhGY0h4c2NTUnhnaTFFbGxI?=
 =?utf-8?B?VnhnVmN6Q0JqUGNLdDVFQWoxbERHU29hU216Yy9jVFByVFlHbldlTkR1bnpi?=
 =?utf-8?B?SUNDdkQxNnYxMFJ5anRBZDdSNEVYd1Rab2ZQM1BBeEo0MEFhRmdMWGd6Tlo1?=
 =?utf-8?B?VnZ0RjJ4cCthcC9TV3ArcUhwSzR5ZjMzTWEwMGpEOVFWWEpIdHhQWWx1VGNP?=
 =?utf-8?B?Q2E5aWNpdGVlM3gvSDZGY1N6L1J6VXRIdlc2N1FDUk90ekRwOFhtVWUvalN5?=
 =?utf-8?Q?5MJw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fafed88-d6eb-4d8b-027a-08dabd68e0ee
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 06:58:57.7414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRBvQNJRPjRPR6BviyBS2IZbkebQUyVtXWhqgWJBlMikL1TSmKeO6IXApR+/g4ow
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 02.11.22 um 22:10 schrieb Philip Yang:
> Re-take the eviction lock immediately again after the allocation is
> completed, to fix circular locking warning with drm_buddy allocator.
>
> Move amdgpu_vm_eviction_lock/unlock/trylock to amdgpu_vm.h as they are
> called from multiple files.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 26 -----------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 26 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 ++
>   3 files changed, 28 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2291aa14d888..003aa9e47085 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -143,32 +143,6 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	return 0;
>   }
>   
> -/*
> - * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
> - * happens while holding this lock anywhere to prevent deadlocks when
> - * an MMU notifier runs in reclaim-FS context.
> - */
> -static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
> -{
> -	mutex_lock(&vm->eviction_lock);
> -	vm->saved_flags = memalloc_noreclaim_save();
> -}
> -
> -static inline int amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
> -{
> -	if (mutex_trylock(&vm->eviction_lock)) {
> -		vm->saved_flags = memalloc_noreclaim_save();
> -		return 1;
> -	}
> -	return 0;
> -}
> -
> -static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
> -{
> -	memalloc_noreclaim_restore(vm->saved_flags);
> -	mutex_unlock(&vm->eviction_lock);
> -}
> -
>   /**
>    * amdgpu_vm_bo_evicted - vm_bo is evicted
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 83acb7bd80fe..02240dc2f425 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -495,4 +495,30 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>   	return atomic64_read(&vm->tlb_seq);
>   }
>   
> +/*
> + * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
> + * happens while holding this lock anywhere to prevent deadlocks when
> + * an MMU notifier runs in reclaim-FS context.
> + */
> +static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
> +{
> +	mutex_lock(&vm->eviction_lock);
> +	vm->saved_flags = memalloc_noreclaim_save();
> +}
> +
> +static inline int amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
> +{
> +	if (mutex_trylock(&vm->eviction_lock)) {
> +		vm->saved_flags = memalloc_noreclaim_save();
> +		return 1;
> +	}
> +	return 0;

While at it please make the return value bool and return true/false here.

Apart from that the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Thanks,
Christian.

> +}
> +
> +static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
> +{
> +	memalloc_noreclaim_restore(vm->saved_flags);
> +	mutex_unlock(&vm->eviction_lock);
> +}
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 358b91243e37..b5f3bba851db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -597,7 +597,9 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>   	if (entry->bo)
>   		return 0;
>   
> +	amdgpu_vm_eviction_unlock(vm);
>   	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
> +	amdgpu_vm_eviction_lock(vm);
>   	if (r)
>   		return r;
>   

