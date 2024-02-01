Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB29C4828C
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 13:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A9F10EDCC;
	Thu,  1 Feb 2024 13:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G8h2MSqY";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE47D10EDCC
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 13:48:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WExZ4UT1NUHFvGS9Au8haWVkl0cXjI9occIYVt9OqX2jIrC5gWXJIKtBmmvB3WY/Qec7Ue6LBbxDh/yeRrXGRsnUJXjEkSmpFEDzlR70x3BWEE8O6+5OMt3SZJAB/cF7R9WNlF2AyXaifYmBZcwleHEy3h6EjAUUMLSF09k9KPYms2wgFwU7lcaO4rGUzOCCf//fH/W2dAbTJn/iCO1npL/kiohqWXcsS5FfRHsWN4SlQPkVdteEorsqZ1I1isNkCyw9GHlRBj8yqOiZu+fjHC9EgXIi2zwbluMqe+0D8ctqhzuSqVRBvjHyGHQQMXSsMYHG869tg5LVs8X6kTtsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd0Ta+QYrm+mtzIo0Xz0Xvr5aI1m1YDjdvcCkGPBPrU=;
 b=R/v/SuoM2c8T7t5kPEEOoOuQcCpdMXLuSHeXAQfDDKMTFFQLnWq+DsnQZcDyMCx+o45rsuAZwCFCqQbRKBFuZtrne6AJ6IxKgBrFkWAjwmXiZT9aHg96dzYz/+pd5+3JZbRjYUj+jayHnpgWWSF1AU9GE7z751mQmG8hVqyXmyO7jYhIybsrOwwdKVec0kCBg11DgfFM9KhxoF6V46GueT9aFtLvM574/FTCaZH4bOdnGymB/FjBGgHkc2eJCZuuPNYdkreOGZXCP+Cq06B7S8Tozp2iAGrTyImZrjRc+yHrc0ii53681xNYp1gKa9Xl9BZYvhQNdlLgnePd2/djbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hd0Ta+QYrm+mtzIo0Xz0Xvr5aI1m1YDjdvcCkGPBPrU=;
 b=G8h2MSqY9F74kkCjaL8JL4TvCs0KyA05yJFJOmxzAvtRnzMhi3ztllKPn8OtXstu5Vt3hxn5AjdjKeVP3YbuQOX4nHcRW3dCrutK3Cu0P42zT4xbpP92yLJ4Vd0xU3qwq0n083XkUfMaLeoXhsHXHRnf9zzhjP8wn6UXt+h/zIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 13:48:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7270.009; Thu, 1 Feb 2024
 13:48:52 +0000
Message-ID: <5c724b4e-9c40-451f-bef7-6bf8eab030b8@amd.com>
Date: Thu, 1 Feb 2024 14:48:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdgpu: sync page table freeing with tlb flush
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <20240131171434.256-1-shashank.sharma@amd.com>
 <20240131171434.256-3-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240131171434.256-3-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2386a2-9b9d-4906-3a3f-08dc232c861c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRs+AiA00Ud0bmnFOvQcm3AZEeXkHmKNiBUj2+gtMut1Au9jKrY88RYK1RM8ODqgPdfa/giiOaEweOcZsTLozHZmFx6WVZvNUfb0xJq6F8JXrUumCssH2ZvMMc46tmNa8QqzEzZNv85AhR/EtFk3eFf3eq2vVEWt3c/PskTSGvB9vJfehxmFcvI5bevF1mtLtRom2ZrqCwSkcCXPa+/bApfWmAplVM/zU5KaQX+BIjKKhwSlp4Per4jRWZppOijQT0XfMSiejs+j7Mg3B1oQ+KV/YJqyKJa3OBoHnF3/tGFa1X8ETrRZ8sjRoqdgVBezTJWolcoh5EDcNWG+u+4LziSM32MLD+tdD99pVZnQsGhNUr3EYa1m7luMBFlNbzfn8Qs6stF3QMvMaX4/7Ptg9rEuNhnfVufSgoiXvCV4g5LrXFEE7vACpg3nIGOXXPocaR9qaiv2aVm7RRXpmwsfyFjv22O7v4gRxeudx/s8LVbiH903saXhP+oQwL/wQUYVf+O1o16tnLqBj3A+6iAG1JBbicLgzbZsMuAgQ1tI3pmfUXmZJCc9xZzgSqeWAgJFXnlyLSjr8Q2Z3bWUYJO526AA559Kk3LErh3RSmaO+KNGyaa6w8QVbrZy3In3Beb3bXhZvpFONkjt6b6giDqNOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(83380400001)(66574015)(26005)(8936002)(38100700002)(2616005)(6512007)(8676002)(4326008)(478600001)(5660300002)(66556008)(6486002)(6506007)(66946007)(2906002)(6666004)(66476007)(54906003)(316002)(86362001)(36756003)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXhRWUQyNWtCR2lZcEhpNUJFSmFoUGkrVWN0S25haVdhZFdpQUlMaEsyTVN6?=
 =?utf-8?B?WmZ5K0JDSXFMM2IyN0NnLzRZb1h2TGozWWJUenRvMUJQTnBxc2hUVmFzTTBq?=
 =?utf-8?B?ZDBuQjltOUthaWFaY2JPQkl2MkZKeWpLdGJlQS95STNCMzNVSUZIMk95Qnk0?=
 =?utf-8?B?TklOd3BnQjlRM2t3TEJ5VVpnNmJDWm5EdThiWm04dHIvZmI4RUhOWXlLalhX?=
 =?utf-8?B?eVhYRXBZeGdkcHlic2JPRzRqZC9UVU9CWW8rcmtlbVgvcEZtOUwvYi82Nm5N?=
 =?utf-8?B?ckw2RUl5cDNaZ041dVp0alBPZmY0ZU9aZDFtVmMyODFid3c5QkJFeVUrK1NE?=
 =?utf-8?B?amtZc0hUclZHRzB6dlNqYnRIeElCdVBDbisvOXR5bThIYnhGdEMzTzFadzhP?=
 =?utf-8?B?UUs2YTd2QlNCMFdRYVhZa3djdWJNbGZOeHg2MlJvZUFmb1lYTHFpRFNGakdJ?=
 =?utf-8?B?MndOQjBVMm9SUVIzY2FWd2Y0cUl1SUpYS3hKT2U0NmowOTBZbXZkZGpmYzlm?=
 =?utf-8?B?WTRsSWJzK2JweFp0WmJBOXphMFFsUU1maWVZcHB5U283TThoZ1RjVTFMVHFx?=
 =?utf-8?B?NEtZV1F2eUs4NFBOQ21QRjlHdFpPS3ZlOSt3VG5GSXVIdHFXblJ0L040UGhC?=
 =?utf-8?B?Wms1M3BKSVJYQy92T0gwR1pZVEFrZnMrZjA4RGJxNzZLQlYybld5alhYQTh1?=
 =?utf-8?B?b2xJMld3YmRPazlMQVFLa29PckkrbHJnVlBZc3hEOXhnVnRKQ1hQRHZ2QXZV?=
 =?utf-8?B?T1MzaDJDNU10YkkxbEFoOVR5VkNFd3F5bzV0TldzaTBUMWpTeWNyWC96Y0tF?=
 =?utf-8?B?MkczNlZDQ2xHY0tPMHFxS0t5VDlMT2kwc2JzVms3WUhoYit5aXlaWmpRYXg4?=
 =?utf-8?B?ZmtDZTRydk5FQnlpY1FCOXFiZzZ3K1pIdjVBV0lTOXpWUVBuamtYdFh3dzRX?=
 =?utf-8?B?UGlIRHhBbXh6SW9qSXh5L05aZUVJdjZPL1BDKy9TbUlsMENjZW96WTFEOUlR?=
 =?utf-8?B?UElxRkVkbE4zR3hOWVl3WnZkWHQ0RmVjdFUwSEJrQXlieDNZV3VKNVVsMjJU?=
 =?utf-8?B?OGdYNGh5RHc3NEY1TkE0U1RHdHlmdHV6YzhNMk9CMkJoUVVacTdXRnBDcXFY?=
 =?utf-8?B?UFJHaHI3eDIyZzlOTGpKdVRoMHNOWFVWZjk0RFhodFd4UlhZdFdITkpKT0tV?=
 =?utf-8?B?d0lMajZYbUM5UEMxRkVyaFU0QjVJN1hSdS9ySjFoWTB4bGZnZkhsZEtCditi?=
 =?utf-8?B?MzZIQ2tRclE1am5POWVxSUNycjN5cFdDdkgvMlp1WGZTVk5McXgwbWoxeTZk?=
 =?utf-8?B?OEhldmJSQ3NNQjJFRzA2TVpEQXg2MWxiOHJDRk1oOVZWMnJMUmhwVmhHeWI2?=
 =?utf-8?B?RHp0WHBDcHpUNjFRc2pNbTFXdy85TCtsUjF0NThPQklWTTQybDNGSW16dktD?=
 =?utf-8?B?WnkrcExkcER3aHN5K05Lb0xGaHlxeW1ySW9SUnh1YTZUU2tYV200bVphU3JN?=
 =?utf-8?B?em5BUXhGaGRlRWtQeDQ5Zmx6aUZZdFNqVVdoTlRkY216TGxkMFViWDBQcWx6?=
 =?utf-8?B?S20xSjZVRkFwdVE2eVhqT2tscDJpNzBSbS84Tkk2Q0ZmS3V1aTNKYnFGYmlR?=
 =?utf-8?B?VXpsdGFiVFg0dXQyVlRIQUlUdERwbC9XL0FWbCswSVlXaWVLK2R6ajg4T3hp?=
 =?utf-8?B?Y2dpUW9aUytmN1dSUUlLWTZrSWZRbnZibVh2c0lpRGNITTBZeWdSTGdZQnVY?=
 =?utf-8?B?dUxlRHhtWloyUk1OSmJvbVFxZjBBRVoybGFqcEROSzZCd0pvOTlaOWtPQ0JH?=
 =?utf-8?B?VUE2OFlUSmlta0trcDRZRHJEU1dEemsvcXZnSjN3eFRQcFcvZW0xRGVXY1B0?=
 =?utf-8?B?eW9RN043VFFKK1J6dEhUcTUvckFpZ0hIKzByWU50d1RnZGtYK2F3NzRscDhB?=
 =?utf-8?B?eVBCeXRjeVVkaGxGVUhOcHVZNmZLRThBUDJlZUNHbnpaZkdkb1BKWVNVWUV5?=
 =?utf-8?B?U3lPdkZjaVY3THlUV1g1VWJPYTR1YS8wV0liY1pOT2YzUlZQNTM5NTVUYzhJ?=
 =?utf-8?B?MWh5cjBzdFJqSnNCTzBRSkZxYzJJYXg0VTV5Z1ZZc0sxY1IyNW5rYXQyRmdE?=
 =?utf-8?Q?9fYP1gnV7hPKAnjSSHl1SzCIj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2386a2-9b9d-4906-3a3f-08dc232c861c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 13:48:51.8902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbJnvURzPULAQh+8KUn473moyvZuf0kZzfX4QZ9Hib+9DPxbOFJmQ99iZflbiOKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
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



Am 31.01.24 um 18:14 schrieb Shashank Sharma:
> This patch:
> - Attaches the TLB flush fence to the PT objects being freed
> - Adds a new ptr in VM to save this last TLB flush fence
> - Adds a new lock in VM to prevent out-of-context update of saved
>    TLB flush fence
> - Adds a new ptr in tlb_flush structure to save vm
>
> The idea is to delay freeing of page table objects until we have the
> respective TLB entries flushed.
>
> V2: rebase
>
> Cc: Christian König <Christian.Koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 27 +++++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 13 +++++++--
>   4 files changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 67c690044b97..b0e81c249e3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2245,6 +2245,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->generation = 0;
>   
>   	mutex_init(&vm->eviction_lock);
> +	mutex_init(&vm->tlb_flush_lock);
>   	vm->evicting = false;
>   	vm->tlb_fence_context = dma_fence_context_alloc(1);
>   
> @@ -2360,7 +2361,9 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	}
>   
>   	dma_fence_put(vm->last_update);
> +	dma_fence_put(vm->tlb_fence_last);
>   	vm->last_update = dma_fence_get_stub();
> +	vm->tlb_fence_last = dma_fence_get_stub();
>   	vm->is_compute_context = true;
>   
>   	/* Free the shadow bo for compute VM */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 8e6fd25d07b7..b05bc586237f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -334,6 +334,10 @@ struct amdgpu_vm {
>   	uint64_t		*tlb_seq_cpu_addr;
>   	uint64_t		tlb_fence_context;
>   
> +	/* Ptr and lock to maintain tlb flush sync */
> +	struct mutex		tlb_flush_lock;
> +	struct dma_fence        *tlb_fence_last;
> +
>   	atomic64_t		kfd_last_flushed_seq;
>   
>   	/* How many times we had to re-generate the page tables */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 95dc0afdaffb..f1c4418c4d63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -631,6 +631,18 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +static inline
> +void amdgpu_vm_attach_tlb_fence(struct amdgpu_bo *bo, struct dma_fence *fence)
> +{
> +	if (!bo || !fence)
> +		return;
> +
> +	if (!dma_resv_reserve_fences(bo->tbo.base.resv, 1)) {
> +		dma_resv_add_fence(bo->tbo.base.resv, fence,
> +				   DMA_RESV_USAGE_BOOKKEEP);
> +	}
> +}
> +
>   /**
>    * amdgpu_vm_pt_free - free one PD/PT
>    *
> @@ -638,6 +650,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>    */
>   static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   {
> +	struct amdgpu_vm *vm;
>   	struct amdgpu_bo *shadow;
>   
>   	if (!entry->bo)
> @@ -646,9 +659,23 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	entry->bo->vm_bo = NULL;
>   	shadow = amdgpu_bo_shadowed(entry->bo);
>   	if (shadow) {
> +		vm = shadow->vm_bo->vm;
> +
> +		mutex_lock(&vm->tlb_flush_lock);
> +		if (vm->tlb_fence_last)
> +			amdgpu_vm_attach_tlb_fence(shadow, vm->tlb_fence_last);
> +		mutex_unlock(&vm->tlb_flush_lock);
> +
>   		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
>   		amdgpu_bo_unref(&shadow);
>   	}
> +
> +	vm = entry->vm;
> +	mutex_lock(&vm->tlb_flush_lock);
> +	if (vm->tlb_fence_last)
> +		amdgpu_vm_attach_tlb_fence(entry->bo, vm->tlb_fence_last);
> +	mutex_unlock(&vm->tlb_flush_lock);
> +

That approach doesn't make sense. Instead add the freed PT/PDs to a 
linked list in the parameters structure and only really free them after 
adding the fence to the root PD.


>   	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>   
>   	spin_lock(&entry->vm->status_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> index 569681badd7c..54ec81d30034 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -31,6 +31,7 @@
>   struct amdgpu_tlb_fence {
>   	struct dma_fence	base;
>   	struct amdgpu_device	*adev;
> +	struct amdgpu_vm	*vm;

Big NAK to that. The VM might not live long enough to see the end of the 
TLB flush.

Regards,
Christian.

>   	struct dma_fence	*dependency;
>   	struct work_struct	work;
>   	spinlock_t		lock;
> @@ -51,6 +52,7 @@ static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
>   static void amdgpu_tlb_fence_work(struct work_struct *work)
>   {
>   	struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
> +	struct amdgpu_vm *vm = f->vm;
>   	int r;
>   
>   	r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
> @@ -62,6 +64,10 @@ static void amdgpu_tlb_fence_work(struct work_struct *work)
>   
>   	dma_fence_signal(&f->base);
>   	dma_fence_put(&f->base);
> +
> +	mutex_lock(&vm->tlb_flush_lock);
> +	vm->tlb_fence_last = NULL;
> +	mutex_unlock(&vm->tlb_flush_lock);
>   }
>   
>   static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
> @@ -92,6 +98,7 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
>   	f->adev = adev;
>   	f->dependency = *fence;
>   	f->pasid = vm->pasid;
> +	f->vm = vm;
>   	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>   	spin_lock_init(&f->lock);
>   
> @@ -99,8 +106,10 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
>   		       vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
>   
>   	/* TODO: We probably need a separate wq here */
> -	dma_fence_get(&f->base);
> -	schedule_work(&f->work);
> +	mutex_lock(&vm->tlb_flush_lock);
> +	vm->tlb_fence_last = dma_fence_get(&f->base);
> +	mutex_unlock(&vm->tlb_flush_lock);
>   
> +	schedule_work(&f->work);
>   	*fence = &f->base;
>   }

