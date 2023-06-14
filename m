Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096C0EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 15:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5156810E0A3;
	Wed, 14 Jun 2023 15:42:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ADE610E0A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 15:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0zc+DF8/iC2QfS68mj6olXTahHaWzlOnzhowt6Udf6oSB+1MIlEPENE/DblZ8+PRGmtWGWQQKHiBBWkL3Aa7+XGQdrwBjI94yZWmahwBhUG1igWMDOnlLhFn0z7Bo1NNlJNHhnsfgMoJpSUk8U9Huj9mtlOYJxfKLa6cgOdfPcGD4ZMRYe9miO9vd1aVZwE+GsIWg4icOf8MDXzBiEXiDVFtDhk1l1qnpmp3xaAXR7PKrFYvP817n8GXD7DnNGywF//Q3jx5xHPd/ezOE527HeCa24D6GaaTh2DW04T3jfRxtPQwwkc3vZg1zadkbohe0AnSKrQf3588DaCJw1NaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoeUg4riKHPmAVeWJz6BbAuJY+JzTvazbC/O+o7fGqM=;
 b=aq8ok4t+4IIqpvxlLi3Of6bfi6gJbHLw4wVFGXxMAUwA4hWjFRpPoKa87NDdu1M0WGfBN4el0h9bjveN4qZnRd4V39RVuOLnffybWDCSI4nPBmCtxp4EBy/AAmg6ZY3LAdTPRq8TL3Wx1rvwynXUa16JQ/2mDiQZAuaqVfO6EW/mdE/x0EN7tlbOJHP5JNwWofaErnou8H0EloIlIjC4T8b9J6eD3C6n7s5WGvNsyujo8ZUxBHlJxlPejDT06anLUVDpVghV0KPcXm1PwpLZi6piymMqmM6/IL89KRSiOymfP8TSeYmJC34MiSp56qye5L0M+5e7lscOPTsTh3UeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoeUg4riKHPmAVeWJz6BbAuJY+JzTvazbC/O+o7fGqM=;
 b=Ep81phfsBJGGZRZQfuSYssjFKnLDVWm3gUdiuuydwlTZPBtAO/KbBzStkUBhIUu5HfmrpafPmU6iLX/F5hMIeCKZqx0T6pm3EhiP0APLd2YuvBg7zrg7H3SaE7kzS5+hTZ8XVUnC/X451/6rAay9m7gaQtQE+W4T2KRBUdWpTIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 15:42:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 15:42:02 +0000
Message-ID: <a17ccb9e-7798-fc33-ff0e-53e96511a92a@amd.com>
Date: Wed, 14 Jun 2023 11:42:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] drm/amdgpu: Implement new dummy vram manager
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230509220144.474723-1-alexander.deucher@amd.com>
 <20230509220144.474723-2-alexander.deucher@amd.com>
 <851ebfd9-bad6-8a11-5f73-44b183d2cb36@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <851ebfd9-bad6-8a11-5f73-44b183d2cb36@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd1ea78-6cd1-4c41-1d39-08db6cede5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAvopiUPWdm+SXaqynAoIhGTYXF6mOH2WlONaU1uz4+1E0abOEp3crzOkvI1vk6g+RKZS5d34WiNAwNcMYqtvoMHFfSNLlAupHCz/J3qbKLT5MTQw1rpIm/VjBvI6iUmvifyZlsGUuberlGmcvT60axcx/76ZU14T5Hfavnxq5QNZvHLkGjgeD6XTdK8CcWviDaWXtG+p23g6v1GPybJGJ5RwUUvvGkqpW1mALbd4qGXBYMwHHyfZBEY/4Hso7HbYF805VAs+0ED1XJAzUrfa8B61IIf1KcFLgLsYxvTKTf4d3NJXVanBlyEkau7rLfVQUNrXQaFzvz64SDcmGFYFtVbPPnu2tj2+SkznRS0e4MC1QVkS6zGa4byXQb87Kv/7agsBN9d/q1o+fpOesGXIAbtam0bkC/Bg33iIka5HeM+LlDt3nhXB8JXjGOv7Gmw+Ndjf9w5b6AI0BGgdFZi0V2H1/g2gXo5vvbDiSNEmNhWcAz3qXFF/Q/7X6UMV6b2dDKwof/DM9QS2v3fkyU+n98Qlol2fAI14oaXKZh+vtz58zVKz5R97t2vBTr307Hq01T3H+zJz+s1u7e90vTs5PQVdp3gI2/wZcGEr0MWVentn7ls/CGOkQCXEtwHS9iOpjfJmVfCXTa8C67R3qfW6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(36756003)(86362001)(31696002)(66556008)(66476007)(478600001)(4326008)(110136005)(66946007)(316002)(6486002)(8676002)(5660300002)(8936002)(44832011)(38100700002)(2906002)(41300700001)(2616005)(186003)(26005)(83380400001)(6512007)(6506007)(66574015)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnQ1ejdEU00yQkNKRzF1VXJOTjFRSmJtSyt4ZmkxcFJxUW5UbVZWM0F4UVY4?=
 =?utf-8?B?L0ZJb3VHZjlTNUVrcnFQdFVaT3ZDTWZUSjdwbCtrbFF5NEx5SFc2NEZpb2hZ?=
 =?utf-8?B?WG10c21UeFdiZTdKMzhQL1hpNHFxNGZGakdva1Z5ZDdqd3U3ZFBIQWVqUHlG?=
 =?utf-8?B?RGxHVzZKQ0V2K0JnbmhHK2F5NGtLcDE0Rm1OMW9iVUlLNVJSTFNCbnFJd3hi?=
 =?utf-8?B?cG9Jby93K1piNzFPYmRqWDM1RU0wdkYzMzM3Q1pXVHZzc3pFaUhuRWtadmg3?=
 =?utf-8?B?cGpRKzFqcGoxbVY2ZHZELzhSNDdZTGFrbU9SdmMzeHk5c0twRTlHZkhBdjBR?=
 =?utf-8?B?Q1p5S3pwOGMxaEV3MFhHTXhQTkFzeE8yMGVidGNvWG1ZSVlQR0RxaWZyYlMw?=
 =?utf-8?B?d0lqOXJWM1hXZC9ueVBsc0hMYlVLWnIrWFNSWUJRdW9rUmFnbG5EOXUzMjFj?=
 =?utf-8?B?V0NhSnpqcGViMDFDVXBuZytUbmpRdEVFN2RXME5hWmdMTy9ZZDlHSTUvb0hE?=
 =?utf-8?B?L3pRanc0NjU2aEpHRHJ4dy9HVFJsU1FFR3ovT2dxTnZKL1lZUjJSQ2dBMHJT?=
 =?utf-8?B?RlU2bWFVYmNoaU13Mi9BUVN3dVJ0Uzd2Rm8xV1FISWJZYVk4VDg5bTV4Wlla?=
 =?utf-8?B?ZFNZUDNJT2RtWmkyb093WlE1VTJucGxhQnR2UkRMMnVEckFBVWUyZ01IRTBu?=
 =?utf-8?B?YTh3SlZscXlsUjloRVhud2M0akZiYmJ2VnFvZXJnZXZNdklmYkpDVmJ3WW4v?=
 =?utf-8?B?eUhFS2lSbHQzT3hNNWxiK3pHV2x6bjlnazVvRWprcGlseU5sMEpXcmlVL2Yv?=
 =?utf-8?B?VUwwVjFHaGFZbm5YTEMxc1RvQmROaXpmRHVnUTcwOVdxYlpRTlkyZUVkVTJK?=
 =?utf-8?B?MDZqNXlxWTZIL1V0d3JhMVo2L2tuVDhsbm5jTWVnMndhYk9kSGpVUCtyM2dO?=
 =?utf-8?B?MEdKQzZyYWY1RlhKaW1vME9VSVcxc2Q1UTV6cDhOK092YWZBNWdNcUxuVTFD?=
 =?utf-8?B?VytnV1pmMUNPVHpQV2pvckZ0L1NVendjbEFNa2R5OTIrUUJmSTFHS0dCLzV0?=
 =?utf-8?B?cjZjZHpncHlLeWtQZk5pSmJwcTdpZnhpZllvMXFPU1R1QWZ1QUErVjRyenkz?=
 =?utf-8?B?dHIrcGcvY2IyVUdmMDRUUWhvZUZja3NMYVdac2djNitLT083Z3FvemE5Z0hN?=
 =?utf-8?B?TFhGY0hHNU1LYlBsVUlYSUJkVHhvakNQNGxKODh1NEoyT3RLTFRZaG1HSDdi?=
 =?utf-8?B?Nkt6QmIvTnpTMDVxRXo3UktwYWk5WXYrR29NaERhR2xBM1hSNHdOTjJLT2tu?=
 =?utf-8?B?S3RLdHpBU1VSUW5EUmhBYnQrTHFTb044VjBicEJWN2ljOXBnUU9WdEJNK1pV?=
 =?utf-8?B?SUoyTFNKdUtacFJPU0o5ZitQc0JiWjZTb3JqNVloSzg4UEhkY0ZoYmN1cXZI?=
 =?utf-8?B?UXlhQ0orNWRTK3BUR21oT1QrV3BtYkNOYVVJblhoYm5PalFYbEpxM3NOZjlM?=
 =?utf-8?B?S2xjK09hSkhlcTNmTnVTWHZEZGtINWRQR21XTTA3UzNaQ0taVFl4Z3lHQlcw?=
 =?utf-8?B?emJsY1JOQkxDeUdFRzZPZFkyN08ydCtkUGQ4YzJCSGQ1QjJVa3hMN3FiNkUx?=
 =?utf-8?B?SHZvNXUzQlJDa294aDRXcml0MXdIendETW5EQ05jZXZEUHRRMURiV2VqMWRr?=
 =?utf-8?B?L2d5VzZlTFYyTnhpeVAxdG9qdEFuOGNBajMwNlplb05IdzRuR0pMdWtIUEFj?=
 =?utf-8?B?VEpZSmZYbTN6RUUwQnlEN01wU1BYc0FrUVhuMWtmSG1PdWZud0FHd3hmKyt0?=
 =?utf-8?B?WnVvSm50c2YxWVJSaTd4QnFCV3FhWFBFSXB5OGZ3QjVucGUydG9SbGVZZWo4?=
 =?utf-8?B?d3BJNEJRWVhEMmVvRFRsRzkzUlV2K2hkUVFoYTBNTTN4U3VUUnRNMkQra1Y2?=
 =?utf-8?B?V0huaGMzb2xPUG5pV2NqeTRGZVpOdUpGWHgyaW1ydDJ6WDlsSU1HQmxXVStk?=
 =?utf-8?B?Z3QrcDBCQzFSa1FTRGlLY2szbk9xU3J6dEwyK3VyTlpZczhkL2ZRWlUrQkxo?=
 =?utf-8?B?eXRwRkRSWnZwOFdhelYrakcza0luaFZxSWVLckk5bVZaUmlvMXIyUkE3cnNy?=
 =?utf-8?Q?NLwb3unDo9oVtnpBZepc5nhx4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd1ea78-6cd1-4c41-1d39-08db6cede5d0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 15:42:02.3204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjNRO37v1rQlJOjI/dNjU45OfjSngwolhN7TRY9ubrmpCskBeXfDN9EYFt1a6aEfO33Rp+zTt/hys6S/1HwX0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010
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
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-06-14 um 06:38 schrieb Christian König:
> Am 10.05.23 um 00:01 schrieb Alex Deucher:
>> From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>
>> This adds dummy vram manager to support ASICs that do not have a
>> dedicated or carvedout vram domain.
>
> Well that doesn't seem to make much sense. Why we should have that?

TTM always expects a resource manager for VRAM. There are no NULL 
pointer checks in TTM for not having a resource manager for VRAM. The 
existing amdgpu_vram_mgr gets confused if there is no VRAM. It seemed 
cleaner to add a dummy manager than to scatter conditions for a 
memory-less GPU corner case through the regular VRAM manager.

Regards,
   Felix


>
> Christian.
>
>>
>> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 67 ++++++++++++++++++--
>>   1 file changed, 60 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 43d6a9d6a538..89d35d194f2c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -370,6 +370,45 @@ int amdgpu_vram_mgr_query_page_status(struct 
>> amdgpu_vram_mgr *mgr,
>>       return ret;
>>   }
>>   +static void amdgpu_dummy_vram_mgr_debug(struct 
>> ttm_resource_manager *man,
>> +                  struct drm_printer *printer)
>> +{
>> +    DRM_DEBUG_DRIVER("Dummy vram mgr debug\n");
>> +}
>> +
>> +static bool amdgpu_dummy_vram_mgr_compatible(struct 
>> ttm_resource_manager *man,
>> +                       struct ttm_resource *res,
>> +                       const struct ttm_place *place,
>> +                       size_t size)
>> +{
>> +    DRM_DEBUG_DRIVER("Dummy vram mgr compatible\n");
>> +    return false;
>> +}
>> +
>> +static bool amdgpu_dummy_vram_mgr_intersects(struct 
>> ttm_resource_manager *man,
>> +                       struct ttm_resource *res,
>> +                       const struct ttm_place *place,
>> +                       size_t size)
>> +{
>> +    DRM_DEBUG_DRIVER("Dummy vram mgr intersects\n");
>> +    return true;
>> +}
>> +
>> +static void amdgpu_dummy_vram_mgr_del(struct ttm_resource_manager *man,
>> +                struct ttm_resource *res)
>> +{
>> +    DRM_DEBUG_DRIVER("Dummy vram mgr deleted\n");
>> +}
>> +
>> +static int amdgpu_dummy_vram_mgr_new(struct ttm_resource_manager *man,
>> +                   struct ttm_buffer_object *tbo,
>> +                   const struct ttm_place *place,
>> +                   struct ttm_resource **res)
>> +{
>> +    DRM_DEBUG_DRIVER("Dummy vram mgr new\n");
>> +    return -ENOSPC;
>> +}
>> +
>>   /**
>>    * amdgpu_vram_mgr_new - allocate new ranges
>>    *
>> @@ -817,6 +856,14 @@ static void amdgpu_vram_mgr_debug(struct 
>> ttm_resource_manager *man,
>>       mutex_unlock(&mgr->lock);
>>   }
>>   +static const struct ttm_resource_manager_func 
>> amdgpu_dummy_vram_mgr_func = {
>> +    .alloc    = amdgpu_dummy_vram_mgr_new,
>> +    .free    = amdgpu_dummy_vram_mgr_del,
>> +    .intersects = amdgpu_dummy_vram_mgr_intersects,
>> +    .compatible = amdgpu_dummy_vram_mgr_compatible,
>> +    .debug    = amdgpu_dummy_vram_mgr_debug
>> +};
>> +
>>   static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
>>       .alloc    = amdgpu_vram_mgr_new,
>>       .free    = amdgpu_vram_mgr_del,
>> @@ -841,17 +888,22 @@ int amdgpu_vram_mgr_init(struct amdgpu_device 
>> *adev)
>>       ttm_resource_manager_init(man, &adev->mman.bdev,
>>                     adev->gmc.real_vram_size);
>>   -    man->func = &amdgpu_vram_mgr_func;
>> -
>> -    err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
>> -    if (err)
>> -        return err;
>> -
>>       mutex_init(&mgr->lock);
>>       INIT_LIST_HEAD(&mgr->reservations_pending);
>>       INIT_LIST_HEAD(&mgr->reserved_pages);
>>       mgr->default_page_size = PAGE_SIZE;
>>   +    if (!adev->gmc.is_app_apu) {
>> +        man->func = &amdgpu_vram_mgr_func;
>> +
>> +        err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
>> +        if (err)
>> +            return err;
>> +    } else {
>> +        man->func = &amdgpu_dummy_vram_mgr_func;
>> +        DRM_INFO("Setup dummy vram mgr\n");
>> +    }
>> +
>>       ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, 
>> &mgr->manager);
>>       ttm_resource_manager_set_used(man, true);
>>       return 0;
>> @@ -886,7 +938,8 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device 
>> *adev)
>>           drm_buddy_free_list(&mgr->mm, &rsv->allocated);
>>           kfree(rsv);
>>       }
>> -    drm_buddy_fini(&mgr->mm);
>> +    if (!adev->gmc.is_app_apu)
>> +        drm_buddy_fini(&mgr->mm);
>>       mutex_unlock(&mgr->lock);
>>         ttm_resource_manager_cleanup(man);
>
