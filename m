Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1783C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 19:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9446710E974;
	Tue, 14 Feb 2023 19:27:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0F510E974
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 19:27:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV3tQA4W1tFMPUvTjL/Pxvn1YyERSXFHJnzOtjQBkGtAbaRgOEO56oFG3ikdjVSApgpMqPpLGfJBJ0cI3aXPifW9QsE6oYiLTV5YvTHpl1RxUc2AwSvz7hlXzZzeZ3Gz0qM/KWk7MxXGLH4aLI3J31QXPHdIAw51lP8n3+iY6h1pI8uoyxnRYEd7eJgG1HwHMk//NkZiaSOeOsSDycu/oI7hR9YwYlOX+wgsOwKZw1QGeZhPLvIf+YliUjTTHVeoVsh/sQdfgwghey1SnIAGByTSxtmPEl1pf96qFks/pgdpDn3dSAk5t2Gf5vdJD0KhwCGvu6VWHGJQHE5qABQv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtJNRX/dCbAK3SHUy6GZ1AKcCwyZtPKhh/OaDvpMB+I=;
 b=YkwsH/1XP4eVZgM/j/q7m7SC1pgnPBw7VikGqMVfH6Ccio2neiVi40giYizyeB+A9tq8AChiGf0HXhOWquZyLIQZIn3XMT6q+xYdj5O6DUXUL7tm9cNzFQohYlxzLuTuzrjn8fP5aR2vYiSpADL8s/31E1zqbQ6upK2jmWlLbZKlEUPJD0v//q6BfY28Yg/2RS7UwMmjGvEaCja9rC16KOqvQfSHfgb4BkLMjdQMreHDSFfADVKsmkqAErk01qTCRe6n0V1lpUr3ka8rLrjSUvF4vSJBtKXBnop9n+T0a79BMqOBzPOjAV7qxXX4vnC+SAwyXCHfbCdO+94IkYrImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtJNRX/dCbAK3SHUy6GZ1AKcCwyZtPKhh/OaDvpMB+I=;
 b=Jujsf8dr97IBGG1nefb3EPge4+JP/fzSxAefLPHaq462TXQD0nri9/PRB/RxksxUAu0uo46DG7Q1+u42km0nvrb9D6rErbswO6foppbODsRfdEW+69jy6IGR1d24jtYcqxt5TnPrnt2ZJ3KuDo724lp16dVBRVJBwrYlnw7swZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH0PR12MB5060.namprd12.prod.outlook.com (2603:10b6:610:e3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 19:26:59 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 19:26:59 +0000
Message-ID: <626ab9bd-9cd2-809b-1691-10ff31b4f52f@amd.com>
Date: Tue, 14 Feb 2023 20:26:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 7/8] drm/amdgpu: create doorbell kernel object
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-8-shashank.sharma@amd.com>
 <4d5dee60-537d-745d-9bc9-1246f50427fe@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <4d5dee60-537d-745d-9bc9-1246f50427fe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::22) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH0PR12MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e15eb1-ddcb-4090-523a-08db0ec17105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNvhadm8xrJBOz2E1+lbrIsZUtBRRpmgjtXrraRtrPUECnz6D9UpzhG/bX1MAEXefGm0andwBRy2dvvEBVM5vgRJBCQeeJWuVOpun/RQZ4O4yCU+Y2Mxo9HX0f0hKEugHZquXXkTRqZkFxt/eAQHL0xBDXMLShEuv+SODv+y0NVbS+U/4RMH3TXLEuZ4Xgp/zsCi/QHqzpYToO/Z04bWD2d1Cnb7GDbK17RVhn+k9A5X0gLENEBpXeos0QJ8RnqsbSFmkWm8o+AT58mFiJZ4wepuV7IhJm/EBIaVhxOaDF68tl2IaAKgSn3lTUeshI4w2BIVOYWqvkrJzeev9mcILyTl6j/XOOvo7E9EbzsSXjYVou/81K0NvG5CE4mIfSedFISUeA7KVi+lnq4ntHRmvuTrOCT310uU3eDdF1ssw+rCbEH5/28Rz4widZ+o8lyNo1JTgPzr6Ss8sM2/X4QwqaUCtdm/xSARALTVc8nmsRnW0FI1Vy4TEQ6acnul6iWCRfCH4r/+2BD6Qv20zSuooxwfzh+mlXPhAypAoR90AwCl17bqYOp0cMmFt1yT47UukV3wP66sQHcXdbJRJ384Tjj+MGCJPkf/gbLPZw3nmj4o+Ht1FQsl9TXqzmAceE5I++YX8C85JdiHmNp2C+kOOtcx1z5TOgiJ3fQUlTdLVGkrVIt+SuHjiygkh4WQ76I79a2/C05+1ondEICJoKH4NoNzeqduFV1YhoQsX2OjViw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199018)(36756003)(31696002)(86362001)(186003)(26005)(66574015)(83380400001)(316002)(6512007)(478600001)(2616005)(6666004)(31686004)(6486002)(6506007)(53546011)(44832011)(2906002)(8676002)(41300700001)(66476007)(66946007)(66556008)(5660300002)(4326008)(38100700002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhYMnNYSjJYL0tLbmxQYS85OVpwQklGRXlGS0FrZlpjRlVIN2RmS2dvQmNS?=
 =?utf-8?B?b2tvZHJkYzRJbVRCK1NGVGFUQ0NVRFAyVmM0OENTTkpNUmVOdFNKTWhCM0Va?=
 =?utf-8?B?cXNoY2VmUngyUFNic2llSWFNYnRwZVBPT0FMUE94M2hpNU5CS3JTdzFaOEVG?=
 =?utf-8?B?czl5bXZ4NmplZ0hWdkhpSXR0aWNjZ2xnN1ljQ1F0TDl3QndkdVdvdkhrMUJI?=
 =?utf-8?B?akxuZW1Gd1JtQzRvT1drRzRtNFN3WHZCd24waHY4d2doU3hlcUE0ZGM5MjBR?=
 =?utf-8?B?d2ZQbDUzdkpwbzJMaDVBZmt5ZVoya1RQZEJDbW95OXNHT0lBR2orRjRyUm5s?=
 =?utf-8?B?QUlhMUhMMzJpRGdtVVpLNmtMbVF0UThUanRjOUd0Ym9PUFNGb3F4R3pkYlV3?=
 =?utf-8?B?NVhIb1g0WU9hd0xjM3BjQXJtQmhvcmtRSFc1ZFRtTzBLRWVEZUIxUjlRc3J1?=
 =?utf-8?B?Unl4VnZEMWNUS2RkZEdVanBDOXJrRUFuZm5Ka1AzcHRJZXRtY1c3Z1ZqS2hD?=
 =?utf-8?B?MWxIaFpjNjBmMktudXR2YTd1OWh5ODFEamhRRThSSDg1MVV2M1pvWklrM1Qy?=
 =?utf-8?B?R2RRUTI5NDlUUGRNcGFNREtsVldraUErMTNWdXFZQVB3MU12Q0FRYkZEdzFL?=
 =?utf-8?B?dVI0bTZjTDVjczhTQXllVDlEUDdyODIzSTVsUEZlczJ3ZGJFRlUvRmgyY3dh?=
 =?utf-8?B?dmlmVFdjbUtlVFR1VTNVZlYrY3U4TnpzUkNVV1JkeVBFTjNyYnp6T3h1MHJN?=
 =?utf-8?B?K2ZaZG9OM3lMSjZKdTluMTZjaFh0RE1qVThaaTlDZ3RJUmRJZ0I3VFV3WUlx?=
 =?utf-8?B?cVdtbmZRSkpTaWJZQjM1SmlyY3Mxc3JNenR1TjFvQW5VMXpvd3NuNmpxRTc4?=
 =?utf-8?B?RjQzNG5RWW94Wndrd1JtUzQ0ZE9uQjVPZWtFb3JJVnd0SGdROWFySWFGbXlZ?=
 =?utf-8?B?WUdlb3RJVXVFOTg3R1ViSE91Z1p5TXN0ZXpQWWpWNmtiMUJiYXYvTk55OHpw?=
 =?utf-8?B?REdlKzJLM204TnhEaVBjSnhWZnBaQktmUzV5ZjhyUTRVMjByNitId05ZM2Ez?=
 =?utf-8?B?WVp1UXlVb1ViUnJCempTdjEwY3ZsN0U3bCtsWFJReVRrQXJqbkNRNVd0ekhu?=
 =?utf-8?B?Tkswcm5EaWdwb2ZPMXNwVzZMNm5UQ1BIQ1g3YWhYNEp6RTg2NE1GaG1jUjNs?=
 =?utf-8?B?VWthQUQrV1JQNTdIdnM3UFFKdFhCcGJMTit0WDBGdFlWNkpQZjRSUURKVUky?=
 =?utf-8?B?L1U3V3llQWhib1hiMFlXeitLM05QOHREQ3JiTGhwSUx0UC90QUt3WWlxTnFa?=
 =?utf-8?B?SUtwT0N3TXppR2xMdWo4U20zWWZ0Ymd5NDJmaGR6VUJkR3NJKzJrbjVaYTdC?=
 =?utf-8?B?V09TVHNQV0FBVXYzdzZuKzJQVWNad1VGdHUxNFVwdm4vVDBGYlR5LzBhUk9a?=
 =?utf-8?B?Qml3V3ZmUklweS8vVUxxYTU5aysxUktqazdpVFVTUXhTMU9sN1dhQzFseW9j?=
 =?utf-8?B?U1NIaDQwRHVSb2FTZ0xjeEYwRGlrUzMzQ1R0RG8wNk8vWENwdDdwZjZqRWlj?=
 =?utf-8?B?TG13bjlkY0hvS3Ixa3p6dHE0dEJwbFE1VGVmTUhPSkhRRjVBYjdlOE9NZkZS?=
 =?utf-8?B?SktEN0xLWlY5Q0o0TjdUOGVlS3BqU0h2aGxhZi84MWhyZkRLRXFDSEZPTmJv?=
 =?utf-8?B?QlYwOFNwakFvdlk0a2dCQmxBQ3Z3Slk1QzluSVkzUGpncXkydDZYVy9RR1E2?=
 =?utf-8?B?WC9zSEJtV09VQlVudU1WTzFoRW11Nnk0MFIybml3VlByYnc1NUQzR01nWHhr?=
 =?utf-8?B?akEvV2Y1RDBLTWJycEJMYkNtTEdHdUtVNnNET010RUpsMklkS0NndGFzWDJW?=
 =?utf-8?B?d1ZEcFVjaUhYTlE0U1NGM0JDbzBYT3hKaU5rUjVMMDl4V0JSdlUxcm4zbWho?=
 =?utf-8?B?K0kwdnBuN3A4OUpla05kNWMrYThuQ2dIWnloVmF0TG1FaWdhYzVuNUtFQUFz?=
 =?utf-8?B?RG9oYjJRSmhiZkxvMzh0a2JzQ0I3NGJuaFZuODd0clgyNmVyelF3cjFKQ0JD?=
 =?utf-8?B?aE5yT0xyQzdDMmZuNEkzUmlIbnYwZVZGRGRRaGFLU3JhRWZ1a0F3a29RVkgv?=
 =?utf-8?Q?4SkKAlGGIv3tZ9qxMqZJWjjfv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e15eb1-ddcb-4090-523a-08db0ec17105
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 19:26:59.3207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iut7+i9OhEnsGe7RyeZMv5x+y+7ujXh5M0ftONOW1YYW667fxlDEGBo+ItGAnzwnYVfU0Z9YZNzRHL6HPoIxpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5060
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 14/02/2023 19:35, Christian König wrote:
> Am 14.02.23 um 17:15 schrieb Shashank Sharma:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch does the following:
>> - Initializes TTM range management for domain DOORBELL.
>> - Introduces a kernel bo for doorbell management in form of 
>> mman.doorbell_kernel_bo.
>>    This bo holds the kernel doorbell space now.
>> - Removes ioremapping of doorbell-kernel memory, as its not required 
>> now.
>>
>> V2:
>> - Addressed review comments from Christian:
>>      - do not use kernel_create_at(0), use kernel_create() instead.
>>      - do not use ttm_resource_manager, use range_manager instead.
>>      - do not ioremap doorbell, TTM will do that.
>> - Split one big patch into 2
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 22 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  7 +++++++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index e9dc24191fc8..086e83c17c0f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1879,12 +1879,32 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>           return r;
>>       }
>>   +    r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, 
>> adev->doorbell.doorbell_aper_size);
>> +    if (r) {
>> +        DRM_ERROR("Failed initializing oa heap.\n");
>> +        return r;
>> +    }
>> +
>>       if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
>>                   AMDGPU_GEM_DOMAIN_GTT,
>>                   &adev->mman.sdma_access_bo, NULL,
>>                   &adev->mman.sdma_access_ptr))
>>           DRM_WARN("Debug VRAM access will use slowpath MM access\n");
>>   +    /* Create a doorbell BO for kernel usages */
>> +    r = amdgpu_bo_create_kernel(adev,
>> +                    adev->mman.doorbell_kernel_bo_size,
>> +                    PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_DOORBELL,
>> +                    &adev->mman.doorbell_kernel_bo,
>> +                    &adev->mman.doorbell_gpu_addr,
>> +                    (void **)&adev->mman.doorbell_cpu_addr);
>> +
>> +    if (r) {
>> +        DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
>> +        return r;
>> +    }
>> +
>
> I would even move this before the SDMA VRAM buffer since the later is 
> only nice to have while the doorbell is mandatory to have.
Agree,
>
>>       return 0;
>>   }
>>   @@ -1908,6 +1928,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>                         NULL, NULL);
>>       amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>>                       &adev->mman.sdma_access_ptr);
>> + amdgpu_bo_free_kernel(&adev->mman.doorbell_kernel_bo,
>> +                  NULL, (void **)&adev->mman.doorbell_cpu_addr);
>>       amdgpu_ttm_fw_reserve_vram_fini(adev);
>>       amdgpu_ttm_drv_reserve_vram_fini(adev);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 9cf5d8419965..50748ff1dd3c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -97,6 +97,13 @@ struct amdgpu_mman {
>>       /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>>       struct amdgpu_bo    *sdma_access_bo;
>>       void            *sdma_access_ptr;
>> +
>> +    /* doorbells reserved for the kernel driver */
>> +    u32            num_kernel_doorbells;    /* Number of doorbells 
>> actually reserved for kernel */
>> +    uint64_t        doorbell_kernel_bo_size;
>
> That looks like duplicated information. We should only keep either the 
> number of kernel doorbells or the kernel doorbell bo size around, not 
> both.
Yeah, agree. I can remove one of these two.
>
> And BTW please no comment after structure members.
>
Noted,

- Shashank

> Christian.
>
>> +    uint64_t        doorbell_gpu_addr;
>> +    struct amdgpu_bo    *doorbell_kernel_bo;
>> +    u32            *doorbell_cpu_addr;
>>   };
>>     struct amdgpu_copy_mem {
>
