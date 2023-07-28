Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46957C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 08:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F2E910E67A;
	Fri, 28 Jul 2023 08:00:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F6E10E67A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 08:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFNSmNghdtTSs0qWSTQ141517ENd+3+amsod5X313bMUwwoLo4uY5o4DM+droxmsC8IQ9KayQNM1m0myYdVvWdmqDHQsCbILUg1wiWtQ2ByjnJ1udIVaylvyX4Fn7LyvwqDNWv4WQ+BbIPpjU0Vm/KB0uyhKSbJMIiybsq9/frvV2oKjNRsu2/N0Bu02RxeueWnltwDpcN+TDM6IPyQaDSjIM5Sp/78Gjg+VGfji0B/MGgrLzUj6PrujfSCmDRheWulzeARL+tF7qq0cxC51+6LwyHU8ksI0+zbSJR3qBOxeIboWMJFbhBxsdfwMVUNVRtsy3bVS7m+Rxgl+kVVnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5HiFqCpxATaXA2LZw0OYxAqK7LUUdqIvQ1owlqm4HU=;
 b=Ga4jFB6cEGstOShZwX3MtXr+tCCNiJEf9VwYWUWPVTPQOY8NA7iwOFB6kWvOx5MsBSYk0DjjuSX+8vdJZ41taZt+pZwKX863k1/8l9Jj6HsKVxAfpXhWKhrxrO3vzm4r1DIJHWRmAInVv1KDGNCDl6D2d+HhtHOKpAworeheyhmYW6KlFDMrWysRq+c7DArX1YfJWzm6Sv2r4HZmC4WjyxMFUTPI/QtpuvUMWBraHSrpL0uybRbFzzvjr2IM4Wmr+H1gFdOB8Z/SL00P4S8g7lRrKnlNkoyrIqVxx7nYeUoKGQhU0fSUYMHu8864K94CbhvJl0X1zuoNGYn1HN4pVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5HiFqCpxATaXA2LZw0OYxAqK7LUUdqIvQ1owlqm4HU=;
 b=DiQpLtjxxzhkVGBytcAADPIh0fjUa2H0KxHrLaoy5ysY5+VAluhCCvAbYAHAaqvTUqvwfG0GN9+cmLbxWjcnZRo8Dwxtp/GVLj0EkvP0mfg4PoJGhqMjXBBRqO768MszIhEIQPI1yzbU0Ok7YdcTl1+AHQd68GBvmndBPNvldjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 08:00:53 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:00:53 +0000
Message-ID: <c4f01c81-f173-ea9e-e9d4-3b9844c5817c@amd.com>
Date: Fri, 28 Jul 2023 10:00:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/amdgpu: refine amdgpu_bo_create_kernel_at()
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230728060405.939785-1-Lang.Yu@amd.com>
 <b824e5ec-e383-b656-b1ef-543f31628092@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <b824e5ec-e383-b656-b1ef-543f31628092@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c38c75-d8b7-4e7b-e18b-08db8f40c42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+tUQmSOl+FwMIzzLpdooFyCuv/Kb2Z6rPHmYUKK0LAW/ioxUP8iYeFy6TlDdQqITXTaTBRTOlREZfHz5T17vzrX0P9NAjw4wiQTZZu8KyP29XsIGs6kbjsaFcOXQHS/u4ATHETXcnGSZ8uENY+Qf7yYtUA3T5mPjtzVUp0XTU1VmsbK5sjnTpX46wmxHMu5xhQc0svTDLm5/te90x70dcTkQy5v86pHT7tSjoyAlGiK6vyjJswIecRRyygIwE42wY5WVt/7genT79W+Tb/sujpXBu9JohnFJ9fx4+2yYGSHLboOerGPdC6h1cUnCNSaapOCTU4sT6Bhi+YA7NLlQRwRm+8v/HhQQmqVmAjMZ6f1CXmSWWF29XS/Zb9+2Kwg29fUmzvgJxvsg+NEBxxVJ/8/xdyVtX3Ulak1O3zY2F7vidX9m0eXPzY+WpgnKlfBBZYVRGUGDvqOpEf9yj/QA+s0oG9a6LXovlg3NgLah0g/bumr8SltugdumhTlrqUmBVxBHYFLBu6/K5zdgIlC2ST/o57gOaL5eJ9MNAXyS/gnsD+4AG3p9RsiU24SqZZVfp5jfFoB8U43nQ94ySauYDRVHfBqpfNwxdXYcrVw7Q8a38+JZKiNNeP3T9eQx8idRuw4HeJ5Q6PsWWmZgZ+bLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(5660300002)(478600001)(110136005)(31696002)(66946007)(38100700002)(316002)(6506007)(66556008)(66476007)(53546011)(186003)(6486002)(6512007)(8936002)(8676002)(2906002)(41300700001)(2616005)(36756003)(86362001)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnF0d0RITjJ0L3dQRE1qSUtub1ZqeHhJOE1XMnAxMXdyVmRnUm1tSEJEbk9p?=
 =?utf-8?B?dzlVOG0yZEZ6ZjdJT29oTFdST21BYmtSZHhibmh6cWNjMWJuZnRvWUsrWndM?=
 =?utf-8?B?OGJZdGtDRGd5eVhCdzlQRHRnV284NDZkV1BoQUI4T2V5UTdoT0lFRXJhUllG?=
 =?utf-8?B?eW5nWDY4a1RXRWZQRWxkYTNlWndwbENwNlBFd1FTdWF6Y1Zpd2Y1ODFGTEVN?=
 =?utf-8?B?a25DY3ZjVXkrSm8wRThJS3ZTeUlLMisvbGVqa2Rrc1BuWnhCRVUwMGt0SWFW?=
 =?utf-8?B?Z3lVbmhPdE5KT3FPcjIramlNRUdJWUN5UFdXRmVOamd2ZktHcUhyN1ZZM3dC?=
 =?utf-8?B?WlQyS3lnYjJ4bEJsWU5aZFVFRk1ROWhMdVBNSmpmMnl6WlY2cWQ4Zko4c2dz?=
 =?utf-8?B?aFZPeWpMN3lBNHJUclMwcDJURG5DSklqTE1KWkxJYVhCdDU4ZVk5MnZXSmdP?=
 =?utf-8?B?TlB0Q2ZDcGdvM2h6bGdWbDBuc01ORjc2ZEM4UlgzUEIxQTlhQ0I2YzVVRDIv?=
 =?utf-8?B?K2xKa1JCRVArUmNoa2VSTEI5Rk5LM3hpZ3kxaEg2TlI2K09TVGp1WWhFTmR2?=
 =?utf-8?B?aHpQSHRYNDhZV1VvVHZESW9lK3NQZzl4N090Q2g0MmUxWU1mTVRieWl5UkZI?=
 =?utf-8?B?OUd5Z2trWWxucE5WdGM1bkNhS0FkOEtGNlZhZVlrUC9VRXB3RU9pM3pSS1dp?=
 =?utf-8?B?WjZZUnozVEh1Yzgyb0MzZGJuUEVBUW9pUmJ6aVozRkpnYkVGUVhSUHBnK21I?=
 =?utf-8?B?QldQRTVXWmRxUFRaOU1BcGYxNG82akZjUkV4RVRxYkdCTzdrZUJoQTNDTG5U?=
 =?utf-8?B?SUgzOHcyVzhpS20yNXNLTjlWTWJtemxFM3UrT1o5UE9TV0FtNjIrTTJlNHpr?=
 =?utf-8?B?ejU1UFJpUXIvU1o3YTVzYWNwWXR3Q0kyVHJYUWNnUWJ1eWRxc3ViaUFxNkhW?=
 =?utf-8?B?WnpmNjgvVzNNcXZyZzNVbnEwSGlDWFM2SWg5Z2JGRVdubHZyRldickhuUGJT?=
 =?utf-8?B?RDkraXVYZ0Yzazk1L3pPcU5lSitZZFBiMW1vcXg5QTRnRVdhcmFFc3VlQ3hW?=
 =?utf-8?B?NENta0cvTlQ1RzEwdlJZczJCV2owZHpjZWNtdDJ4MXNIS1pCZnRzWVNGV3JW?=
 =?utf-8?B?U0VNYzNmS2pvR0ZRL2ZadmdFYjBxRE9YaS9RMjRaZmNsTlNwR0xVNzZjVUFV?=
 =?utf-8?B?UlA2VGp3aVN6RytCc2ZRTWErQnBzTnV3aE9udzJlMFR1N1RzckM2dDdNQjFG?=
 =?utf-8?B?Z2hiekdHME11cndzeTJuY2RRVDVpUThPUVI3V3JWeFZwYUV6TEowK25wdjNm?=
 =?utf-8?B?Tm0rNGNLRUdCOWRGc203aGNWV253Uy9kWE84VWl6YnpQamtBSmxEbHl5VjR5?=
 =?utf-8?B?S1ZieVoxSzZQYnBJQkFMQzJTZ2NTTHV4NnlHRUVuWGVNTFBEQ3BiVDhOUnM0?=
 =?utf-8?B?a3F3amZ1Q29lUkYvdFI5aWdSZGxsbGNyOTFzUjdDVkNSRW1oRkJvakJSTHlH?=
 =?utf-8?B?b2srYVE0NkJyeEVuOURoTXhtcGRqZ2dxcmVhV000MUc5QlIvdWo2bUx3OWZS?=
 =?utf-8?B?OFpoWHZXb2ZZRlRMc2Z2OWVKMlRTbi9hS0g4aHlLeTlMQXoxUVpySjg3U2g5?=
 =?utf-8?B?cEhPV2Q0WFFKb1Z0VDE4MlQzUyt4T3hMT0tpaGNESnZQOGpHVEM2TjZIVDFS?=
 =?utf-8?B?YTJndnNHZk5zUzg4MXkrZmJKRG8rYlg5a3d0L05zVzJlQVBJUURwbHVrL1N2?=
 =?utf-8?B?ZzNZZyttMmdJcnVDQ0llNjNvUXJrNlIwQkF2c3NIWHpiYlpkQTNZbVRKd0Er?=
 =?utf-8?B?disrNTBYbTlMUW9XK1lWOC8xYlNNVWZhVkFXYkV5bm90MFJQeVhvR09CbWYy?=
 =?utf-8?B?b3ZkeXJBNnpLSHVmaDVydG45OFpBM1UrUjlScXovY2RIck00SzVTNUJ3SWRy?=
 =?utf-8?B?dWRQV1JRT3hzc1pXemtKTVdtY0cwWXFocUIrQitGdC91N2JySHlYN2kvd1My?=
 =?utf-8?B?R3NRd2dnbmd6d3c0bFl1ZHlnOUFWb0w1MTFHRzl4RkhSRkFsaWRkSmlZWTl5?=
 =?utf-8?B?UTdLQ0dTdjJHRlZtbUFyUldFSDZJekUrOUt3SWRVdHVpMHhjNU1TMTBZVEY2?=
 =?utf-8?B?Y3UwcnR0UFRNL2FISnkzWllOQ3hoM1NScDkzc1BUMm5HUjFNdzFnVmd2N2Vq?=
 =?utf-8?Q?OEbojXzLd0B8BwBhH1sDHiVP4Wow4rN/25IYdPoy6jDR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c38c75-d8b7-4e7b-e18b-08db8f40c42b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 08:00:53.7073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BicJYrTH+mq2YqDgaMwcD/IhzSA3Hz3tCvZoUxMC9QUmnDfZfboGd1PSkT9ipsrO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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

Am 28.07.23 um 09:00 schrieb Lazar, Lijo:
>
>
> On 7/28/2023 11:34 AM, Lang Yu wrote:
>> Use amdgpu_bo_create_reserved() to create a BO in VRAM
>> domain would fail if requested VRAM size is large(>128MB)
>> on APU which usually has a default 512MB VRAM.
>>
>> That's because VRAM is framgented after several allocations.
>>
>> The approach is using amdgpu_bo_create_reserved() to
>> create a BO in CPU domain first, it will always succeed.
>>
>> v2: Don't overwrite the contents at specific offset.
>>
>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 24 ++++++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 15 +++++++-------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
>>   4 files changed, 28 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index ff73cc11d47e..fa30e96f27d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -358,6 +358,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device 
>> *adev,
>>    * @offset: offset of the BO
>>    * @size: size of the BO
>>    * @bo_ptr:  used to initialize BOs in structures
>> + * @gpu_addr: GPU addr of the pinned BO
>>    * @cpu_addr: optional CPU address mapping
>>    *
>>    * Creates a kernel BO at a specific offset in VRAM.
>> @@ -367,7 +368,8 @@ int amdgpu_bo_create_kernel(struct amdgpu_device 
>> *adev,
>>    */
>>   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>>                      uint64_t offset, uint64_t size,
>> -                   struct amdgpu_bo **bo_ptr, void **cpu_addr)
>> +                   struct amdgpu_bo **bo_ptr,
>> +                   u64 *gpu_addr, void **cpu_addr)
>
> A generic question (not considering other details in this patch) - 
> this API is literally asking to create BO at a particular GPU VRAM 
> offset. The offset goes in as the input, so why does it need to return 
> a GPU offset?

Yeah, that's exactly why I said that the intention of the function was 
misunderstood.

This change here doesn't seem to make much sense.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>>   {
>>       struct ttm_operation_ctx ctx = { false, false };
>>       unsigned int i;
>> @@ -377,32 +379,42 @@ int amdgpu_bo_create_kernel_at(struct 
>> amdgpu_device *adev,
>>       size = ALIGN(size, PAGE_SIZE);
>>         r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
>> -                      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
>> -                      cpu_addr);
>> +                      AMDGPU_GEM_DOMAIN_CPU,
>> +                      bo_ptr, NULL, NULL);
>>       if (r)
>>           return r;
>>         if ((*bo_ptr) == NULL)
>>           return 0;
>>   +    (*bo_ptr)->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>> +    (*bo_ptr)->flags |= cpu_addr ? 
>> AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
>> +        : AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>> +
>>       /*
>>        * Remove the original mem node and create a new one at the 
>> request
>>        * position.
>>        */
>> -    if (cpu_addr)
>> -        amdgpu_bo_kunmap(*bo_ptr);
>> -
>>       ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
>>         for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
>>           (*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
>>           (*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
>> +        (*bo_ptr)->placements[i].mem_type = TTM_PL_VRAM;
>> +        (*bo_ptr)->placements[i].flags = TTM_PL_FLAG_CONTIGUOUS;
>> +
>> +        if (!((*bo_ptr)->flags & 
>> AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED))
>> +            (*bo_ptr)->placements[i].flags |= TTM_PL_FLAG_TOPDOWN;
>>       }
>> +
>>       r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
>>                    &(*bo_ptr)->tbo.resource, &ctx);
>>       if (r)
>>           goto error;
>>   +    if (gpu_addr)
>> +        *gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
>> +
>>       if (cpu_addr) {
>>           r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
>>           if (r)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index 5d3440d719e4..8f5b5664a1b6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -315,7 +315,8 @@ int amdgpu_bo_create_kernel(struct amdgpu_device 
>> *adev,
>>                   u64 *gpu_addr, void **cpu_addr);
>>   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>>                      uint64_t offset, uint64_t size,
>> -                   struct amdgpu_bo **bo_ptr, void **cpu_addr);
>> +                   struct amdgpu_bo **bo_ptr,
>> +                   u64 *gpu_addr, void **cpu_addr);
>>   int amdgpu_bo_create_user(struct amdgpu_device *adev,
>>                 struct amdgpu_bo_param *bp,
>>                 struct amdgpu_bo_user **ubo_ptr);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 7c6dd3de1867..a210c243dac0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1619,7 +1619,7 @@ static int 
>> amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>> adev->mman.fw_vram_usage_start_offset,
>>                         adev->mman.fw_vram_usage_size,
>> &adev->mman.fw_vram_usage_reserved_bo,
>> -                      &adev->mman.fw_vram_usage_va);
>> +                      NULL, &adev->mman.fw_vram_usage_va);
>>   }
>>     /**
>> @@ -1644,7 +1644,7 @@ static int 
>> amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>> adev->mman.drv_vram_usage_start_offset,
>>                         adev->mman.drv_vram_usage_size,
>> &adev->mman.drv_vram_usage_reserved_bo,
>> -                      &adev->mman.drv_vram_usage_va);
>> +                      NULL, &adev->mman.drv_vram_usage_va);
>>   }
>>     /*
>> @@ -1729,8 +1729,7 @@ static int amdgpu_ttm_reserve_tmr(struct 
>> amdgpu_device *adev)
>>           ret = amdgpu_bo_create_kernel_at(adev,
>>                            ctx->c2p_train_data_offset,
>>                            ctx->train_data_size,
>> -                         &ctx->c2p_bo,
>> -                         NULL);
>> +                         &ctx->c2p_bo, NULL, NULL);
>>           if (ret) {
>>               DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
>>               amdgpu_ttm_training_reserve_vram_fini(adev);
>> @@ -1742,7 +1741,7 @@ static int amdgpu_ttm_reserve_tmr(struct 
>> amdgpu_device *adev)
>>       if (!adev->gmc.is_app_apu) {
>>           ret = amdgpu_bo_create_kernel_at(
>>               adev, adev->gmc.real_vram_size - reserve_size,
>> -            reserve_size, &adev->mman.fw_reserved_memory, NULL);
>> +            reserve_size, &adev->mman.fw_reserved_memory, NULL, NULL);
>>           if (ret) {
>>               DRM_ERROR("alloc tmr failed(%d)!\n", ret);
>> amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
>> @@ -1885,14 +1884,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>           r = amdgpu_bo_create_kernel_at(adev, 0,
>>                              adev->mman.stolen_vga_size,
>> &adev->mman.stolen_vga_memory,
>> -                           NULL);
>> +                           NULL, NULL);
>>           if (r)
>>               return r;
>>             r = amdgpu_bo_create_kernel_at(adev, 
>> adev->mman.stolen_vga_size,
>>                              adev->mman.stolen_extended_size,
>> &adev->mman.stolen_extended_memory,
>> -                           NULL);
>> +                           NULL, NULL);
>>             if (r)
>>               return r;
>> @@ -1901,7 +1900,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>> adev->mman.stolen_reserved_offset,
>>                              adev->mman.stolen_reserved_size,
>> &adev->mman.stolen_reserved_memory,
>> -                           NULL);
>> +                           NULL, NULL);
>>           if (r)
>>               return r;
>>       } else {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> index 41aa853a07d2..b93b42b916ce 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> @@ -397,7 +397,7 @@ static void amdgpu_virt_ras_reserve_bps(struct 
>> amdgpu_device *adev)
>>            */
>>           if (amdgpu_bo_create_kernel_at(adev, bp << 
>> AMDGPU_GPU_PAGE_SHIFT,
>>                              AMDGPU_GPU_PAGE_SIZE,
>> -                           &bo, NULL))
>> +                           &bo, NULL, NULL))
>>               DRM_DEBUG("RAS WARN: reserve vram for retired page %llx 
>> fail\n", bp);
>>             data->bps_bo[i] = bo;

