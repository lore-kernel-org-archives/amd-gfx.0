Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCB1C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 20:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF7C10E5AB;
	Thu,  1 Jun 2023 20:12:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 755D210E5AB
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 20:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb+w9SIODcAK8W/H7oE35YGTF2bwUCNIUJkdaqAmWdkWScH9stf/CYseh+sbMFqvOVL0/Wonl2KzL5VJA4LqMjdtItpHtiKGRIQ3Zifc/dgaxSYnQP3QzXY7jdwj6sYoTBCHneauvDwwfM+0QAHllBwWbFyv/7ZN8e0lClbIM9iqrzsNbzGziXKxrVaRnDeB5favtvU+rEmlW9Nh9gcg3NfhD9XN4EATU3ySmf2nGdMUf0A+C0IWhH/PkmUglWs6pTa1BbEik4TwMdjPmvG/tcq+IIHuqOG8ijHlaunUqPKXIS+XgU6QU19jIyKs2lw1yXNRhMpC2p9MDPI3QlNU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5eU+UIoPWYho2iF2a9Cs9fwjSknptahOAyV2P9TUHY=;
 b=LoxivlmyH/GlW4Qxn/MsMBT7ySAeVQT7yGaMKr9mIdFfefiPW89JJbcYvpkEIJYPOgEAm3GbS1xLanTUzH8Tya6dqf3vnP9/2eAnKx3SJ4eNwh4IwhTTKpwdTo89zQ55BvnMG7zMB09Nl4gwV5obzg2/Sif2ZsP9CPV278xvxQxdpj5yv1JSv2N0gt1tqnN4gHqrQq4l/0fcqSu4zKBU/AMDTnVbbWn0bR3gKDyqbYKlCbKxnad78GmCCbhhDzrzojwbHTbQODistmRkL45/K40wQQNaLd3glH02npBtq2NPeMPwhv2YozwhBioGZBRAlVp4twoEd/WAXwZfLStyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5eU+UIoPWYho2iF2a9Cs9fwjSknptahOAyV2P9TUHY=;
 b=dLlKhgSS84ENZvWTem8JpYTf01YfdWMI3YDxxo5+nqoGjP0JcORivIHXTf/zm9S4x4NDw9K203pncPnzKQvmNtE55yShMWN1ipQwZhbnyqPZyRBjXum+6WEHoa8ZyzfGgIzR+hV/zaISrrkohWkxnmWG3uZjv1fOrrXbZdz3Rcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Thu, 1 Jun
 2023 20:12:29 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da%5]) with mapi id 15.20.6455.024; Thu, 1 Jun 2023
 20:12:29 +0000
Message-ID: <909b40e4-eeb4-5f78-fe7b-0141098d802a@amd.com>
Date: Thu, 1 Jun 2023 16:12:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Implement page table BO fence
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230601193117.13143-1-Philip.Yang@amd.com>
 <20230601193117.13143-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230601193117.13143-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0334.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::9) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4d5292-f889-4986-5118-08db62dc8666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGHRJArp17LlyjEWJGmFXzfSSZE6970n6NXzgFvMVbUx+WUzNon+ZBSRqOR/us6Or6K0l3oK7jrEkp8S+4s1lWnCMyxIGPNqbwTHPCxK9C9MqgDBFATq+Aifxe2cZWkrwu/nbKVik/AiN84jLO5eeI6iL80Wykk6kuG2H5W7hYwlyQWwc2AkJxc/nNdhv6AQEvY9mfqm4xSV6QfVhn9Dk4Por2Qo9DPsTFNg93vEaRFdBYceIOXxozxNDQXPdHv6kj7GPawgz+Twatwq3BV2d+ARdcATL9aTCfpK+FgNXTJTJXim/l/1EsZrB77H5+dDVCB3q6SbRlh3WEmucD2yGtvD/bwmSxZXL0cTjhbOH9Ar6HjngCCRtxg9YiaJZwLuMGuzPlK7KkXVce0X0J5XAYRSAf/z4u8wHa/Hr5mwLtXAE/EhxwdnR20cq51mNaGEoLGg21R62QObAY346d3JweHmXArg/UWB3as/K03mNIZmI42GsWD26eyvnDtHDQsmSxIoe3nW+jzHD8I8dj0AeXzjXbLo38u1gheI8AwC+0vxAHD3VorSq0tUBPKhTlZubZEYMMoiKRaQ6rvM/aAr2FLoqU2yneSH5v4bUNsVJtbE1KT+7lqh5oN5z08IEEVVqfc6hP4hnc3WPL95ImLGQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(478600001)(36916002)(6486002)(6666004)(8676002)(8936002)(5660300002)(2616005)(2906002)(38100700002)(44832011)(83380400001)(31696002)(31686004)(86362001)(66946007)(66476007)(66556008)(186003)(36756003)(316002)(6506007)(41300700001)(26005)(6512007)(53546011)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkJnN256YitKRmptSUNVa1BKdjhoKzlRTkZkNWFJc3IzUFZiQ0ZYK1dIVy95?=
 =?utf-8?B?OXloT2NVL1dKMm1wNDJqTjBmNGFHVGF5N3lOckZBSXlFTGJISGN6b3JnT215?=
 =?utf-8?B?bGVaV0tmSkxoTlZBQng3Y2FLTXkvRWI4OE1iZVBYU2hzTkdMT1UzQmpycW5J?=
 =?utf-8?B?OHJ3cW1raUthT0tKVXR2Qys5Z1JvR0ZUb1FGZkNLTXBHQ04vU0hOUTN4Ulhw?=
 =?utf-8?B?S2N5VFJNR3NkUWpmV0M5VTBjMFMwL1VadjY5MmdWQkJrNWZWNmxJM1BJUDI1?=
 =?utf-8?B?NDVqd3lLZ1VGSFl3Y3JmV3d6M3E0UUJXWlNNRWJFKzFlcWc1dTA0dXFBcjZL?=
 =?utf-8?B?U21DTTVvR0FvWVRyMVRGVjlPd0YvbUk5djBEZnpNYitBOFdYQk5qUlRWZ2NQ?=
 =?utf-8?B?SSthSGk2V1lDUDNNOHpLRUZBc2tNYk9HMUhzc3RDQlU0RWhYZERuOWx2aGJ2?=
 =?utf-8?B?YzJOa1dGU3NtaWt2TjRod05OS3MrdzZhK2kwQW1FNWJoeFRuWEZsQ2k4dEZL?=
 =?utf-8?B?Y1JtOTZnaS9CTnZKalVZQnNzdHN1OUdKeEdqaENWT0ZHWHBic1cvd1lZWFly?=
 =?utf-8?B?TkxwZDd6dVE4bHdEcFdwcmprZkdOL2RWN3o4R0RYVnFOWjh4SFlmbmZWN01j?=
 =?utf-8?B?alRhdDVzMVI1VEVpUnk3cUlKZkdGdDRNVFp3RjRPeTV3dzVUVHRySkIwWHpX?=
 =?utf-8?B?Uzh1VlhVRlhGYVEvbG1oKzJYSThBWWJoMlRPenFXZHB5aE9LVVUrRFV4NC85?=
 =?utf-8?B?K0d5dS96WldJbm52WUprdEhzWkV6OXVqcHlFc1RBVWJUejdQSVNoU2g5bDha?=
 =?utf-8?B?dG5XeEcxc1RKOS83d0dHK2NQa0xjWEx2ZnpIdEFtM2FjUHRON2ZCZHQ2UFRm?=
 =?utf-8?B?Sm4yYUFUK3Q1bkowS2VFT2lLb2cvdnRlTnJ0aVlnRXFQTTJSWU5JTzRVQVcx?=
 =?utf-8?B?TDl1bkdlS3lObzRvTW5xTGxYNEFWajliTnhHMWF3RGNqelp1NVRxMTR4MytS?=
 =?utf-8?B?NlVXTVFhbXIrOThzQkxXQUo5U3AzUkJpczlCTFhQa3p1VDhPakZ5K29LU2ZF?=
 =?utf-8?B?N2RhUDR4K0hQZyt4c1BVYjdlV1NMRzFWeVQ3aTRnc1lqdi9QK2lia1ppdXhT?=
 =?utf-8?B?MlVVa0lUOUU5U09rN2hwZnN1dXIzZmNHbTJyanNTSmJLNTFKdkEyNTVmMnF2?=
 =?utf-8?B?ZGdma054L1RpQXhyTTYrM2RTK2FLbGxIWmNBZ1NMVUFoSTllWEZaN29VdmxI?=
 =?utf-8?B?Sk4ydVZBdDZkTUNoRkZZeTNOTS9BRDFWc3BYUkVtdDZWQjB6UzlidTF3RVpr?=
 =?utf-8?B?bkdOQ1p4WnJVMzNtRUVuMnNpWHBZUVFDODZTejF2SlhDeUZQdHk0STJ6OWtr?=
 =?utf-8?B?dkwwUzdhc09tVXQ2UytKS2RRd21UK0kwWnNNQmR0dG9YNExjeXlydVJvYnF2?=
 =?utf-8?B?Z0JNanNCcFZhQ3NpVG85blJ1SllXOWkxK0grdkwyWTJGeTNjMS9IaS9CMjBD?=
 =?utf-8?B?ZTRqYVovS2ljRCtCa2NKSlFkTyswWXJyZ1NDdTVjV0ZmcUw4UGRMUHk1YnRP?=
 =?utf-8?B?M0pwRi92YnJCZENhMjBxVUxzalkzcUJ1UnZmZFMzZFQ3cEE4bmRTS2JJZ1N5?=
 =?utf-8?B?VFQwRVVJSm1VcE5ZSFNpWkV0NDZKcmFhaWl1cGVLeGFCTGN5Q1ZMM3R1NERX?=
 =?utf-8?B?VTEzMkxYZEJOS0x2MWdLcXdhUC9FVkFVZFlPMFBpZkdsZURQL0gxT2ZzM3hZ?=
 =?utf-8?B?MmpJY010d2EwcHpYb2g5ZGZ0RE9BWEgzZ2djQ2FzVjFYaDVKZDlac2dManI2?=
 =?utf-8?B?Nm52QXpxdnpQSU9xcjI3SllaT3pqV3hBYjlMWjZEOG5VVkw0VHN1YnJCSEZ6?=
 =?utf-8?B?Q0Z3bmRCNXM1L1l2QWk1NG9WenJIVEd3eExmVVNFMU1JNG5RYmFCWmRERmdr?=
 =?utf-8?B?VnpJdFRqNE1NZlJQRmRWV1NCcXBxWURnQW9mSmJvUlAvdjJ2S2lhVXNCd3pv?=
 =?utf-8?B?ZTl3YkVKK3BqT25EeHIwR2dXNlZKM0NVc1A3MStZa0RPeWZaSEwwVVRLVlk4?=
 =?utf-8?B?aFFxVUkrdnRwVUEwQnhxWXZrcEtXMHh6ODNyQjgvTThCcW9zWWUvaTBYczRS?=
 =?utf-8?Q?kL9mCjcb29wXz1jhaPtNyQN8T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4d5292-f889-4986-5118-08db62dc8666
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 20:12:29.1652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Lf0ZJzR5cUifHfqhEWg2u/SmkolXjsibJguUYDm9WqJ29xixbNT7zOKQK6Jh2c3FykRSd/SC1oafKuvrFeh/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-06-01 15:31, Philip Yang wrote:
> Add pt_fence to amdgpu vm structure and implement helper functions. This
> fence will be shared by all page table BOs of the same amdgpu vm.
>
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 45 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  1 +
>   4 files changed, 52 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5af954abd5ba..09c116dfda31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1499,6 +1499,8 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
>   int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
>   			       enum amd_powergating_state state);
>   
> +struct dma_fence *amdgpu_pt_fence_create(void);
> +
>   static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_device *adev)
>   {
>   	return amdgpu_gpu_recovery != 0 &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index c694b41f6461..d9bfb0af3a09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -57,6 +57,16 @@ struct amdgpu_fence {
>   	ktime_t				start_timestamp;
>   };
>   
> +/*
> + * Page table BO fence
> + * Fence used to ensure page table BOs are freed after TLB is flushed, to avoid
> + * H/W access corrupted data if the freed BO page is reused.
> + */
> +struct amdgpu_pt_fence {
> +	struct dma_fence base;
> +	spinlock_t lock;
> +};
> +
>   static struct kmem_cache *amdgpu_fence_slab;
>   
>   int amdgpu_fence_slab_init(void)
> @@ -79,6 +89,7 @@ void amdgpu_fence_slab_fini(void)
>    */
>   static const struct dma_fence_ops amdgpu_fence_ops;
>   static const struct dma_fence_ops amdgpu_job_fence_ops;
> +static const struct dma_fence_ops amdgpu_pt_fence_ops;
>   static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>   {
>   	struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
> @@ -852,6 +863,40 @@ static const struct dma_fence_ops amdgpu_job_fence_ops = {
>   	.release = amdgpu_job_fence_release,
>   };
>   
> +static atomic_t pt_fence_seq = ATOMIC_INIT(0);
> +
> +struct dma_fence *amdgpu_pt_fence_create(void)
> +{
> +	struct amdgpu_pt_fence *fence;
> +
> +	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
> +	if (!fence)
> +		return NULL;
> +
> +	spin_lock_init(&fence->lock);
> +	dma_fence_init(&fence->base, &amdgpu_pt_fence_ops, &fence->lock,
> +		       dma_fence_context_alloc(1), atomic_inc_return(&pt_fence_seq));

Creating a new fence context per fence is probably wrong. I think we 
only need one PT fence context per GPU or per spatial partition, or 
maybe per VM.

Regards,
   Felix


> +
> +	dma_fence_get(&fence->base);
> +	return &fence->base;
> +}
> +
> +static const char *amdgpu_pt_fence_get_timeline_name(struct dma_fence *f)
> +{
> +	return "pt_fence_timeline";
> +}
> +
> +static void amdgpu_pt_fence_release(struct dma_fence *f)
> +{
> +	kfree_rcu(f, rcu);
> +}
> +
> +static const struct dma_fence_ops amdgpu_pt_fence_ops = {
> +	.get_driver_name = amdgpu_fence_get_driver_name,
> +	.get_timeline_name = amdgpu_pt_fence_get_timeline_name,
> +	.release = amdgpu_pt_fence_release,
> +};
> +
>   /*
>    * Fence debugfs
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 37b9d8a8dbec..0219398e625c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2147,6 +2147,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		vm->update_funcs = &amdgpu_vm_sdma_funcs;
>   
>   	vm->last_update = dma_fence_get_stub();
> +	vm->pt_fence = amdgpu_pt_fence_create();
>   	vm->last_unlocked = dma_fence_get_stub();
>   	vm->last_tlb_flush = dma_fence_get_stub();
>   	vm->generation = 0;
> @@ -2270,6 +2271,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	dma_fence_put(vm->last_update);
>   	vm->last_update = dma_fence_get_stub();
> +	dma_fence_put(vm->pt_fence);
> +	vm->pt_fence = amdgpu_pt_fence_create();
>   	vm->is_compute_context = true;
>   
>   	/* Free the shadow bo for compute VM */
> @@ -2358,6 +2361,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	}
>   
>   	dma_fence_put(vm->last_update);
> +	dma_fence_put(vm->pt_fence);
>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>   		amdgpu_vmid_free_reserved(adev, vm, i);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index d551fca1780e..9cc729358612 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -286,6 +286,7 @@ struct amdgpu_vm {
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
> +	struct dma_fence	*pt_fence;
>   
>   	/* Scheduler entities for page table updates */
>   	struct drm_sched_entity	immediate;
