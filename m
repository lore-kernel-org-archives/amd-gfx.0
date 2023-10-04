Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E87E936E6
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35DED10E3B9;
	Wed,  4 Oct 2023 21:34:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C24510E3B9
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:34:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mms8sAg7pTZesLt47o6CBEtcbtWMqhS3wr+laZsN6y9a1Kmyftw+4yHt8T7Whv/wzukUFtg2o3SkR47kHulpNLziBoPRiucgnhGUJaEZdRA8PXZrfQKXF1yJxcAEB1bLJq/hBo42d3PPSYi4kx3yCZKDUtWJ763X+xv4eGLZELPvMRnbW7POOMExxKuPAn6wsfwOHjVZTJYbH+cDc0WSQzzellcVcToDSVLs1VjNBKGmETQXGOps2HbIXY/5coOx7EKHXadUZx406HPsFcXI19HYi9n2DEVu1fz5NtE/HaWoWefYj6BbhUz6Fvnn9l7ZkaqR6xRlZasiVXIqS2BIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tssh9tUMaRWi5bV29u1VCWM81LHhcF+TGaWtxG3Ag5s=;
 b=YGxQR8zoR4cI7TZIZGjM2wAgyg4gjtLOTPFryVWKk/QYSJS7Qe80wfWuVskfIbCFjXltAfe1z82l49bYeMyNIZhLfttmWTBuVqqgJsKcB08qv8kXF6kftbhHuDWypD/6kZMx/2wPmwq5yAa+bddwPXvMjgIQFTUecZA8DXy3MazdpX4Ws75eBAk61LKrVlOvMreQF5GDovznkAZ8P1yQdbl7TSxCn2Br/l0uAkazRkEgrVxrOIVulVFIzCHEIFMiIBozCtfU6oeIUh2lW8yAt1oAnHbsM9k+7RqxPmF2PL77j5qNC6l2TznROb6d//SFpYx4RxPexe1zkZSIxI4d1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tssh9tUMaRWi5bV29u1VCWM81LHhcF+TGaWtxG3Ag5s=;
 b=DtASAKm+EYVNR0tzTxJgFOKoho4ph7oKsyHzEwnO9wTjZN3P6fN1dyBb45JD6k48mNa1NLCeNwjrpqX7lHNyLFr3Pggmgxs7xaGZKrjuGWn8a403HI9tiVcxqB8LtLOmgZ5TD5yD/b17ENjlyqGl4coIu3Xxrws0Xr0LpcgNJko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Wed, 4 Oct
 2023 21:34:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 21:34:42 +0000
Message-ID: <816ed7f8-9a22-4b17-ae0e-27701ea51557@amd.com>
Date: Wed, 4 Oct 2023 17:34:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] drm/amdgpu: map wptr BO into GART
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-8-shashank.sharma@amd.com>
 <022fbf02-b9f6-1286-bd25-dd150384047e@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <022fbf02-b9f6-1286-bd25-dd150384047e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 207c0e90-2ba6-4451-bb77-08dbc521b8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEx7/RtLof+JWTT5wx61zex+lCpFV/WM/S+NCeJEm+IDJZEsf2NCnZfkA0PthwwwV4vV9nn9z2mq6o0oZZXLxOKMr6kml3tsof0S1dWZ/4z71jTYXYZCQSxiRiZG8a6/3aWf4yFPpBnZ+zTq3KDWseKkpzEq/byQ2bvlS2tFpCRXSi/bQhEMu4817MMimrO6ThVSajwdmfmgQlqkMXEqm4a8RHNTzBdSAFrKGJp1YYq/QN5KESUrbX3tEVsZLrBKyhAx/ympMd9+p+GcxmQ5hQg7y+x4wNvSF0lQMrWhjXuh37exfmbRj9/BhWAq82vMbyEni9YQeqxx1XFYc6V7+YO596Yj65ETJLzUjAcRkkoCAY4ZD2AgGX2jfFBsVpQZy+Kopf9+TYgraAKX4dAh2qBWSbmm2uMFRF93g96NUIaNhgnoWqOkZBc8I63K4cN4UmMmdPXq6H1G6OdCkWgtiHmxyp8RLza+CnuFV6RlFWSfrEoG33SOXvBndvL/ouHwA4i/jRFl8xpZkAkOi5fwQAaMh3rwV6nlJqd4mqdnPu/M7qOkOTYP52f31/ghPwAmOrK8cGL+T/qEpxPqUaEA65ZXxVGRPB/u3sZHXfsBIQC8U/bBjeDVXdik9RLPx7MHVDKga8jNmhW7LCU5z/EBGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(44832011)(5660300002)(8676002)(31686004)(2906002)(4326008)(8936002)(41300700001)(316002)(66946007)(66476007)(66556008)(110136005)(66574015)(26005)(36916002)(36756003)(6506007)(53546011)(2616005)(6512007)(83380400001)(86362001)(31696002)(38100700002)(478600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nmp0YUFHVnE0Y3pESGREK015c1hUL2RoZ0dVeXA0KzJiVGlFQ2IzSUFJTlk4?=
 =?utf-8?B?UXNGM2Z4T3hQbFFHQXF3dkRna0lvbWdKclZtaGVmMUgzdDZhd0k2K1BzV1Ur?=
 =?utf-8?B?dys4YlVuamdhTVhra0NYOFkxcEVieTVFTy9QN1JRM0RKczdVU295R3IwRTlr?=
 =?utf-8?B?WEFJSFMvMDJldGsxZWZZSzFKNXhuQzIwSHFNNnBHTFdrbFdmZ2lybjBhNzFJ?=
 =?utf-8?B?emhUYXVDWXRGdEhLcWd2Zjg5TkNVOEhuT2wxUUlZQXB6WlJkQ3dxMmdnQW84?=
 =?utf-8?B?WkVkMDhQbzgyTmVYQXBpdnBuaDZqckc4R0pFZ0RueFFOaW1FYTJkM21BZFdD?=
 =?utf-8?B?aHBYN1Y0SmxZYk4vZnEvTXpRL2tha1g1dG9SMnh6ZUY0N1RpbkVQbjFRdVFh?=
 =?utf-8?B?RWROL1hOSWg2TWIvMWdGWjcydmF5dnpxTDVjWWYzcTVxWHlwaWpaYm9jRGEx?=
 =?utf-8?B?bS9BRTV0b2Y3NnA0dGh4dUhhNFZRaFBiYXltTllwTWx1VVBOejdQNVB5WVpi?=
 =?utf-8?B?azZ6a2JrTzR3Y2RBMUwrcTlVU0hzV25IWEdzTDc2ci9sZFU5S1VXbjgvK1Bl?=
 =?utf-8?B?OW5BbXZIZ0R0aHhHWlhTODNzRWh5bWZwSXZJeEMxY1VleXNMMEdxMWthM0lJ?=
 =?utf-8?B?RWx4YzF2blJjbmo0MGs0eFJvYTBUdGRjVS9ydHh1endidlNTN0tmMDlMVWtV?=
 =?utf-8?B?Z2R2MXo5elQxMWY0U1oxMTNUdEdwdnBhMVovUTVNNGVlVHA3bXhudXZ2YldV?=
 =?utf-8?B?dTdrK2Y2N3ViUS9EZUhBd21MOTU3M3R0RjFRd1dveU5VK0FTemJyVElwclF4?=
 =?utf-8?B?UWs1Z2FwSlhOb0RDSG0rZXNFbGtDQUVoYmdNREZTbllWRk5vME9CZ2dSc3E3?=
 =?utf-8?B?MTdIMDBpb0VpZVAwNGtZbnZzRXhLdUZ4Z0ZKbFR4TFd6YWZlbzBaam53UEpv?=
 =?utf-8?B?cXlFcXNwMDNTQ0xUVThUZVNvc0lqZjQyczZBRVVvSmQ1OVIwdkhoZWZncklw?=
 =?utf-8?B?dW5VMElJRlUycEhBOXA4YzNydE9UQTJVOEhIZTNycEMybml3ZW5MaERHa3lk?=
 =?utf-8?B?ZjRRdjE0MzBtcFpKUERnaFRaaVd0N2Q1VHlSY0htRGM2S0NMc1BIRDRQVC93?=
 =?utf-8?B?SW5KeENQL3h5Mm5Yblh5VU9GTmRvN0VDUk1ud0IzWU4yeWg1OERuRDI3MFBG?=
 =?utf-8?B?UzhTbXROTk1zd285bEVRNzYxd0hRUHNXaFVCdFUrMnlWTVFUWGt2TUdiQ0ZG?=
 =?utf-8?B?Yk5LbWVROGIrSGNURXBvYlB2NmhmMVVNSGZOK0ZVQ0xVSHpzVXZGRmU5Mldt?=
 =?utf-8?B?M3FERUtuOTcrNjlvZFdSQUpmbFkwWFpZc2RBa1QvalMrV2ZVNU1oYkFtVUdE?=
 =?utf-8?B?K2NsUXBGNVFOeDVLOG1GNlBYSDZ0WXVFUTdVRnJLU1hkY1FIOHNiTVBDVVFG?=
 =?utf-8?B?N1greCt0Qy9YTzUyS2JPL3NEOVcvVUl0NTVGaDNnREdiaEtJZDNyc0pxL0ND?=
 =?utf-8?B?NlUwYVZtYU5heXJaejlRUmIxcjl3U2haL1VRMFlWYVAxR21kMnBwOGhaVnRx?=
 =?utf-8?B?VlZCTTRJU3kzN2VkbzJzeFYxNEpOR1NlSlBhTldISnp4Y1k3QUpvM1ExVU5S?=
 =?utf-8?B?aGNrTzZEN2puemhoMEcvUVNjNWhqYjl0NXhwY3dqVzVHaU1VZGhuWVdNdGxi?=
 =?utf-8?B?UWFLdzd5ZGJ6cE9DVTZRaVA0UFkzWktzMzBSMzNuWEhZUGpmWm9ocnpsVEwx?=
 =?utf-8?B?U0lnZExLMEJJNnB5aXY2WHA0SzQzTjlHN3lQaXkyWjQ0ZjdOYUJMcHU5ME92?=
 =?utf-8?B?OHFsNWo0Tk9IRUYvSDUyVFJOeGs0MzA0ODVxU2RBV0xpR3pienhaZkNiZUtS?=
 =?utf-8?B?L3d5eS9lWEdzUksvUGFON3I3eU1oNFVLWE1tbHZYeHJQUFQzMWxuV1dITzVr?=
 =?utf-8?B?R1haRisybGVqSXFHeGlKQTc0ZWM1czNPZFI1M0w5WjZVS1Zad3hxTjg4cEcx?=
 =?utf-8?B?bFBUK3E5M20rTThsZE1Fd1dhaWtYaGFTQS9Ma25QQkJaVW5tS2FoaHBkdThG?=
 =?utf-8?B?ZkNFOEFFUmc3UU1OdE1VTFU4ZjBjeWNmb1Q5eHpQeFhCK2hBbUJQQ09JLzRa?=
 =?utf-8?Q?rW5lWn5PoIbIIHNfvzhCxlD5+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207c0e90-2ba6-4451-bb77-08dbc521b8c1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:34:42.8790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwWEkp6keXZNdPOpX3y82jURC8yKAQ6sVnf13mWh2RK1v7uHqKjJPuk1s8FXT6W346q3z0ObtmXfp/H4TP+itg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-09-18 06:32, Christian König wrote:
> Am 08.09.23 um 18:04 schrieb Shashank Sharma:
>> To support oversubscription, MES FW expects WPTR BOs to
>> be mapped into GART, before they are submitted to usermode
>> queues. This patch adds a function for the same.
>>
>> V4: fix the wptr value before mapping lookup (Bas, Christian).
>> V5: Addressed review comments from Christian:
>>      - Either pin object or allocate from GART, but not both.
>>      - All the handling must be done with the VM locks held.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 81 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>>   2 files changed, 82 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index e266674e0d44..c0eb622dfc37 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -6427,6 +6427,79 @@ const struct amdgpu_ip_block_version 
>> gfx_v11_0_ip_block =
>>       .funcs = &gfx_v11_0_ip_funcs,
>>   };
>>   +static int
>> +gfx_v11_0_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct 
>> amdgpu_bo *bo)
>> +{
>> +    int ret;
>> +
>> +    ret = amdgpu_bo_reserve(bo, true);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
>> +        goto err_reserve_bo_failed;
>> +    }
>> +
>> +    ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>> +        goto err_map_bo_gart_failed;
>> +    }
>> +
>> +    amdgpu_bo_unreserve(bo);
>
> The GART mapping can become invalid as soon as you unlock the BOs.
>
> You need to attach an eviction fence for this to work correctly.

Don't you need an eviction fence on the WPTR BO regardless of the GTT 
mapping?

Regards,
   Felix


>
>> +    bo = amdgpu_bo_ref(bo);
>> +
>> +    return 0;
>> +
>> +err_map_bo_gart_failed:
>> +    amdgpu_bo_unreserve(bo);
>> +err_reserve_bo_failed:
>> +    return ret;
>> +}
>> +
>> +static int
>> +gfx_v11_0_create_wptr_mapping(struct amdgpu_device *adev,
>> +                  struct amdgpu_usermode_queue *queue,
>> +                  uint64_t wptr)
>> +{
>> +    struct amdgpu_bo_va_mapping *wptr_mapping;
>> +    struct amdgpu_vm *wptr_vm;
>> +    struct amdgpu_bo *wptr_bo = NULL;
>> +    int ret;
>> +
>> +    mutex_lock(&queue->vm->eviction_lock);
>
> Never ever touch the eviction lock outside of the VM code! That lock 
> is completely unrelated to what you do here.
>
>> +    wptr_vm = queue->vm;
>> +    ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>> +    if (ret)
>> +        goto unlock;
>> +
>> +    wptr &= AMDGPU_GMC_HOLE_MASK;
>> +    wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> 
>> PAGE_SHIFT);
>> +    amdgpu_bo_unreserve(wptr_vm->root.bo);
>> +    if (!wptr_mapping) {
>> +        DRM_ERROR("Failed to lookup wptr bo\n");
>> +        ret = -EINVAL;
>> +        goto unlock;
>> +    }
>> +
>> +    wptr_bo = wptr_mapping->bo_va->base.bo;
>> +    if (wptr_bo->tbo.base.size > PAGE_SIZE) {
>> +        DRM_ERROR("Requested GART mapping for wptr bo larger than 
>> one page\n");
>> +        ret = -EINVAL;
>> +        goto unlock;
>> +    }
>
> We probably also want to enforce that this BO is a per VM BO.
>
>> +
>> +    ret = gfx_v11_0_map_gtt_bo_to_gart(adev, wptr_bo);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to map wptr bo to GART\n");
>> +        goto unlock;
>> +    }
>> +
>> +    queue->wptr_mc_addr = wptr_bo->tbo.resource->start << PAGE_SHIFT;
>
> This needs to be amdgpu_bo_gpu_offset() instead.
>
> Regards,
> Christian.
>
>> +
>> +unlock:
>> +    mutex_unlock(&queue->vm->eviction_lock);
>> +    return ret;
>> +}
>> +
>>   static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>>                     struct amdgpu_usermode_queue *queue)
>>   {
>> @@ -6475,6 +6548,7 @@ static int gfx_v11_0_userq_map(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>       queue_input.queue_size = userq_props->queue_size >> 2;
>>       queue_input.doorbell_offset = userq_props->doorbell_index;
>>       queue_input.page_table_base_addr = 
>> amdgpu_gmc_pd_addr(queue->vm->root.bo);
>> +    queue_input.wptr_mc_addr = queue->wptr_mc_addr;
>>         amdgpu_mes_lock(&adev->mes);
>>       r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>> @@ -6601,6 +6675,13 @@ static int gfx_v11_0_userq_mqd_create(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>           goto free_mqd;
>>       }
>>   +    /* FW expects WPTR BOs to be mapped into GART */
>> +    r = gfx_v11_0_create_wptr_mapping(adev, queue, 
>> userq_props.wptr_gpu_addr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create WPTR mapping\n");
>> +        goto free_ctx;
>> +    }
>> +
>>       /* Map userqueue into FW using MES */
>>       r = gfx_v11_0_userq_map(uq_mgr, queue, &userq_props);
>>       if (r) {
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 34e20daa06c8..ae155de62560 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -39,6 +39,7 @@ struct amdgpu_usermode_queue {
>>       int            queue_type;
>>       uint64_t        doorbell_handle;
>>       uint64_t        doorbell_index;
>> +    uint64_t        wptr_mc_addr;
>>       uint64_t        flags;
>>       struct amdgpu_mqd_prop    *userq_prop;
>>       struct amdgpu_userq_mgr *userq_mgr;
>
