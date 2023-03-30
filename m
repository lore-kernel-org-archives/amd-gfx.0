Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA57C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 11:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA0D10E270;
	Thu, 30 Mar 2023 11:46:32 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A754610E270
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE5juhT318m0U3zCIFvUWJQXw8htm1vPGSmCTSVpvCZ678UNOG1igSPA2f2yiO+8G9i9Pwxbid3XS579hoYMGLmMej15rPO0O+ZsBZtiU38h7hpTvVwCrWgDVnz+GR0oTTW5fgnjiFxYFAz6C5MWTTJGjG+PtZrYSgsrizG8HBZDgR0yBJXswXRQiqLI0XAog3b7Ary5YKQEmEGBjCF5kGlXqnwr12WI4spmTu5jFcf21dAQB8jK7v2M896YS9LQF7rAqjfari91hcDNMVUFeNmIGTQM0mNxjr4jsyy+7//7NRuOGgN+/hfqXzR9wR6lfPeBA3AJ0idwYZyt3meo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ileh2l6+RbHGZ51ooRVQ4cJ+88qsnnF3qIhHDkJtbus=;
 b=hHKOOeVDAbfzI25dOr2EclwHIvMx9wXRMogdEmPdAF/Lrhh5N8v7KXMHRzOtFsbn+Of8hosr5uCy18CMSXALry3/GKMy+/fUM5Agop+7+GuBHJInAPCB5ciTgB0ZmBwSN1QCsJRVhe7smlc9SchLqGU86+1ps7wM0BvCVc0wW+hHIZ3x/kfD9h9xxF5CQPe3cQu9gsrK1PmoI7iozgqzXcY2FwOBKneCxSseJchCuXOlKk/HS7cYWkycGCs3xW8Omxdk+zSxP2Ch0cggZJgP0Jscgw/7nilGGE0ON1AypzN8eM5uU0QFSkCrr6cwIxJ91d9r2RupQeEDzkftyY1BEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ileh2l6+RbHGZ51ooRVQ4cJ+88qsnnF3qIhHDkJtbus=;
 b=y6OIW0Mrbw+WLI79anvRO+G55iotVLRJor8QNWjRdwlZ/M9pvxE7H0qOlg34BtrOKO1/82k06kUfjS7mNtjQ7z4l0jtwsDuJCjdEjt+9rDP/CcVoFH920G7fd+32W0HlLFH6r9tmHfHJpUlJdEwr6brRG87vqVtOExgSS6Ssavw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 11:46:26 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 11:46:25 +0000
Message-ID: <6cb52e35-7df7-d6f1-00ec-8c4ef6e44f2a@amd.com>
Date: Thu, 30 Mar 2023 13:46:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
 <220faa77-f51d-0551-e390-437e2accbced@gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <220faa77-f51d-0551-e390-437e2accbced@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::19) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a45cfe2-3ced-4fd9-31ec-08db31146441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBnRF7c7/1usCU6hIFWSzwbTdt63dueNQ5S8x70U9WwIeUSWTHD4VfJNsyaglyuoTgim+asy27XX5us1UmCmsmNVTgNwyztqkdxo6y99RI788w4ipHGHlZtTIfj9GEe3I+HqkdcoX5Q8nqwUgkISIVUhygOkSOwKSp/btridNwmcW0i9Sl+SCBUlro7jEjCRaZrhTN6mjobV86nv/sgIUkBp2mMYB6pP/nEhE7LuoLT7sXk3CK2X60Faxxe37wXk6nE5DtWDrnOk6nEAEyZPW1P71MZxh5VJ5OhHwzgmb+dL7VPCGd8D4wmGDeDo7GBnn5+EnVVkdF3tSs6sAtt4Q/d1J9kLoImVH0Bapn7FZIi9oLzcJi21BJJqbUWO+avT0wadGML6a5YTcC39ox31/9N/9fhhMb+f4kXrayrk+TuPgg+zjRV1EP09AFbraSM2UZtr/kVSFqpJB86/d+1mP9GX1uewclB/W7vMOS/YHzqcZlzfvmnsO5Ddtmd47IZ72JzP0e3f0cT3F4uH/nGU7fbssGCLv3EQTBjdxQ14hXfW7LXJmfctcHP5f5izlWtZkqiTYF2BLTtA+16gjxv1V0Dr6AS8cd94DFi5wNzskM2fPhy4DtlylM2NzlUAWwj3cHtifxm3/vjtE/URFTuJqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(316002)(478600001)(54906003)(36756003)(31696002)(86362001)(8936002)(5660300002)(66556008)(4326008)(38100700002)(44832011)(66476007)(8676002)(2906002)(66946007)(41300700001)(6506007)(186003)(6666004)(53546011)(26005)(6512007)(31686004)(66574015)(2616005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmpHMTdMZnV2d3AvNyt3OUswNHZXWVZnQXpIQzg2VWhBUGI3K1A3dDdKckVT?=
 =?utf-8?B?aGRMdDFGdnBYc01QMEIrQXFYc094Sk9sTHpXOVBVa0lFQy91d1htb0hDOUZL?=
 =?utf-8?B?ckVBUUEzWXBIald6b2JoZ1NLVDYrZTE2RldLQjl2OFZOdnVLZjdMaUF1eUJZ?=
 =?utf-8?B?TytuUXdOaUJzVmtoSHd5RFQzR291b0NYc21sQTFpdjc2MjBlNDdmeDVxNkFP?=
 =?utf-8?B?a1VLbWZlOG5xbCtxRUVtTXN2TDVwOTVJNVkwUmxjNjdNbGVESDBiQTNZV3JT?=
 =?utf-8?B?ZXFyR0MvUnI0MGxUTFY0NFplNzZ1L3pSRlh1N2pSakZ1eUNiNGtoTno4bjFU?=
 =?utf-8?B?Y2RzdGs0VEtxQW1KdGdjZ3pSQXByQzlkSUlJK3J3VXd6YXk3ZG9Nb2ExYmhM?=
 =?utf-8?B?UUFqMWdWYnQ5U0FZbHgvNTJRS09lSVF1M1d1RUhEYnlEdTB5bzBGUHJqTWVC?=
 =?utf-8?B?NllEK1hnMHZxR0dDcnRLSmJ6Tis1bmVia3BGTncxSXZ4amN0Q1pDY1lFNm1t?=
 =?utf-8?B?VmJTaVArS2Y3bzZUUXNpYjNhYVl5QWpaWnhIODZvbW9weUlhVDBRNGZiampp?=
 =?utf-8?B?UFI2WER4UGVGaG9vRHhtbHlGc0tHWk9RMGRWWC9UYnFONDRuZFdhcTZkQUFO?=
 =?utf-8?B?TUJuK2RVczdCK3lhbUJEQ1VlN3kvb2lpa3JTVWhjUW1VT0k2UlMrMCtRQ2d6?=
 =?utf-8?B?ajQ2WUJMM2pPek9TSmNrb0VhMmhhTTRWKzRBL2JvVUlKY3NueTBqV2dVdGpu?=
 =?utf-8?B?dUJaL2RTRVBqWlVTUjEwQ0VJR1o3NGZTaXZLKzVxUElJSzBpTzk1N3FUa1pI?=
 =?utf-8?B?TjRsemJ2bk42d3RBaW14ZHdBUERjdzhnYzgvbkxDQktOUEhoMEN1czhMVGRz?=
 =?utf-8?B?aWozZ0ljdzViV2IzUjZWWWthdnovQ1hxTkVKSGVJVWNoWHg1cFlPTk5hVGJn?=
 =?utf-8?B?Vy84azlJREZYdFFHSy90YlBKbmNpZjNzdGRWQkhJZmxhSVlWTlpsdyswQ3pi?=
 =?utf-8?B?TFVzTnc2UGtmeHMxL053bHh2V3daUEE5blhBYmpYZitVU0hlM2Fyc2Jjc0xy?=
 =?utf-8?B?ZGw0M0k2Z2pGaExtZmlEc2dPMmNiU0t4djRNQ3UzakZqZUdURHBWOTdzWVNV?=
 =?utf-8?B?R2JQdWQ4Sytaa2VpdWtpVlJQcUNZenBHNjFETURMT0hOSFFNNjBFc2p3RzFZ?=
 =?utf-8?B?VFBZVUgxV0lXZHhWQUtDNGxOY2RtUndFTmNpUDNNeU5VRnZDWjRsRXZjeU5T?=
 =?utf-8?B?Wm1xeVdZNEwzVzZ2QzZzdGxjUEc2a1BwN2w1eWlHNWlyeWI3enh0dmhiZ1Ji?=
 =?utf-8?B?ek1ObkZ6RU1OaFJTRVA0STVkd29SazVwZkViU3ZKR25lQWd2V0Mxa1paK0lC?=
 =?utf-8?B?dkNZUFpJYXM0ek5oSjZVQ2I0MUluN3NDNmNRclp2aTh1WWJQSFFQN0pjYWFR?=
 =?utf-8?B?aGtKakYzanNFQVg4R2NuUm5rWmFYeS9BMWdnekhUbFFpS0REVmUzdkRkcTUz?=
 =?utf-8?B?RVo5ZlFYeEZKTzlnZjEyd05rOS9OT3JmR0Vqa21iYlNqN0ZjVkoyVkNFSXg5?=
 =?utf-8?B?TmxXeHJubDdKcjBTNTRaSlFnUzVONk9vSklBTWw4SUlHbTVjcGg1dWNHY0Jp?=
 =?utf-8?B?KzRrMHVkYzMrVjNMa0ExMzFUTlQxWHZlcTFEVXIvcWRua0RUNE9qbGRHcDJ2?=
 =?utf-8?B?K1VqZ3pINjdCdVJObFdGa2VmTFZvYlFwTERrNDBoUmNmSmRtVy9qSitLMXUr?=
 =?utf-8?B?N3JxUHMzaVF6RW50OVk2bEZHMkJIZllYaUFnRURNQnF3V2JtUzZyV2dGczZH?=
 =?utf-8?B?bDlGQ2hSYU10REF3ZllsRjZwcEFWdVFLcHRqbmVjWWRORjV3RXFiR2l2QzZO?=
 =?utf-8?B?UWlGR0JoZ2RHK2V2dGpzZXV2OEJWOXR6NVZBRGc0eTNXZUZOT2dGK3RQakgz?=
 =?utf-8?B?Q2lERzJjWU1weFNTNHF1T0dsNHVkTjQ3U0dxcTl2UXQ0WDUwMHNtRjdUeVRO?=
 =?utf-8?B?d1ZYUmt0TlUwemRlSkdkWnRpUnk2U1ZzRnFxRzQxR3owOEsvWVpLTGQ4aU5z?=
 =?utf-8?B?Uy92YnRoWGlyKzZhL2RmWjA1NkJiV2xua3J0TnVOeUFvUC9sd3l4UXJ6OTFx?=
 =?utf-8?Q?ZCUZDP8/2kZRUmKwD8RWU//IU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a45cfe2-3ced-4fd9-31ec-08db31146441
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:46:25.7347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNUYRbYqpn95Te2KBS57s8Ndk2axF/F5Iyc5s8MDIlfVghhPMScuwiBQ+eVFipXW2RDmZbaLy67l9/1VjjXI8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 13:29, Christian König wrote:
> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch adds helper functions to create and free doorbell
>> pages for kernel objects.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
>>   2 files changed, 90 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index f9c3b77bf65d..6581b78fe438 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -27,6 +27,24 @@
>>   /*
>>    * GPU doorbell structures, functions & helpers
>>    */
>> +
>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>> +struct amdgpu_doorbell_obj {
>> +    struct amdgpu_bo *bo;
>> +    uint64_t gpu_addr;
>
> Do we need to map the doorbells into the GART for something?
>
> On the other hand we probably don't have the check to not do it in 
> amdgpu_bo_create_reserved yet.
We don't actually. I can remove this variable.
>
>> +    uint32_t *cpu_addr;
>> +    uint32_t size;
>> +
>> +    /* First index in this object */
>> +    uint32_t start;
>> +
>> +    /* Last index in this object */
>> +    uint32_t end;
>> +
>> +    /* bitmap for dynamic doorbell allocation from this object */
>> +    unsigned long *doorbell_bitmap;
>> +};
>> +
>
> Do we really need a separate structure for all this? As far as I can 
> see this is just part of the doorbell handling.
>
It makes it really convenient to have all of this in the same place, 
please check the patches where the doorbell

objects are used and stored, that might paint a better picture.

- Shashank

>>   struct amdgpu_doorbell {
>>       /* doorbell mmio */
>>       resource_size_t        base;
>> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct 
>> amdgpu_device *adev);
>>    */
>>   void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>>   +/**
>> + * amdgpu_doorbell_free_page - Free a doorbell page
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: previously allocated doobell page details
>> + *
>> + */
>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>> +                struct amdgpu_doorbell_obj *db_obj);
>> +
>> +/**
>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: doobell page structure to fill details with
>> + *
>> + * returns 0 on success, else error number
>> + */
>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>> +                struct amdgpu_doorbell_obj *db_obj);
>> +
>>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> index 1aea92363fd3..8be15b82b545 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device 
>> *adev, u32 index, u64 v)
>>       }
>>   }
>>   +/**
>> + * amdgpu_doorbell_free_page - Free a doorbell page
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: previously allocated doobell page details
>> + *
>> + */
>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>> +                    struct amdgpu_doorbell_obj *db_obj)
>> +{
>> +    amdgpu_bo_free_kernel(&db_obj->bo,
>> +                  &db_obj->gpu_addr,
>> +                  (void **)&db_obj->cpu_addr);
>> +
>> +}
>> +
>> +/**
>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: doobell page structure to fill details with
>> + *
>> + * returns 0 on success, else error number
>> + */
>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>> +                struct amdgpu_doorbell_obj *db_obj)
>> +{
>> +    int r;
>> +
>> +    db_obj->size = ALIGN(db_obj->size, PAGE_SIZE);
>> +
>> +    r = amdgpu_bo_create_kernel(adev,
>> +                    db_obj->size,
>> +                    PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_DOORBELL,
>> +                    &db_obj->bo,
>> +                    &db_obj->gpu_addr,
>> +                    (void **)&db_obj->cpu_addr);
>> +
>> +    if (r) {
>> +        DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
>> +        return r;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * GPU doorbell aperture helpers function.
>>    */
>
