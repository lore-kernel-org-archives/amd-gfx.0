Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09275C636D4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 13:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F8410E223;
	Wed, 15 Feb 2023 13:36:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD40710E223
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 13:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l87ItCBCD8gRmhMJ540EduqJbjbt4HXQMuYm9E6Tm/qB2KOwFE+FxWkWUVd+NIRLPf2DwmDAUkLrLdUoQaktzBN8vgHzVx2tjQKRCUrsx7M6XKQzWUw2PHtyPBf/hnpO28XYlx1ohamk3SbDPyvR+6kb9hSwSIEFeLvJ1tVW3TaLJbjwu66rjDiHoqnVUG4ItLHDKw19d8m/haVWhkKmcbIFfwfbcOhLEmjPWN7bn8TYrQVC2mIYKB5tvWk3AtUFGl3aNvJL33QRUwX0mLFScPbAUWl4sYqhPTsZwD+H2Z7IDOkNbm0Pigx4BROa9kNA4c8udTabDpfijv1YO1FY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9V3CUpRR8shrBw8bj7yGbN+3Gy+Ppgm+gVwuC1SXbM=;
 b=mUUwY7+rWvqS6llrdt7zU+5naYT9cHNtNS61m7fPbr+SYJ3Sm59mxPqMmD6z8BjwrlkErkMXotzb3GlrUKWwiMhi2WOZCi/FzpWUXaBYsaurpsiPxiY2dZ/yxACjm8u6P18TGn3/DAE6CTSx5+SkB1BsXIpo/g16zNzdV62q1wawSpc6wiho/tvmxVjU+vr1ba+BOeuXAyiT2TCgKKWcMgm5cF7+SMuBLbFDLYD578EqFDEQ32Ez4vjNUfp2XNgAlaZ/23Ryhh2x1El9njZJNowUtRX7MabS6tQRonrDq/WuCDjL2qULXkovLGWjlPos9C12ignK11xxhbbR4YsC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9V3CUpRR8shrBw8bj7yGbN+3Gy+Ppgm+gVwuC1SXbM=;
 b=TMd1Qv4w5z2FK7F3y0qcy7pnOy3Zp7Pi1IZEvwlCOCfqBLiTqv0VEqbmb2ervgcimq2wcaQ6utUVOC+R+s2XT95KeS2F7r3a/XHXhhzy+3aKBY1mr3Gu5XVQxVFKyHGdtfRd1rJvQQ2tBCnGxmyHvtIJuGBG4CvzfJNSvxPVYBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 13:36:13 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 13:36:13 +0000
Message-ID: <a2445303-9238-f221-178c-025ceb2ad2f5@amd.com>
Date: Wed, 15 Feb 2023 14:36:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/8] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-6-shashank.sharma@amd.com>
 <7cfbd8c6-7865-2fe3-ac93-d3b264f2b4ab@amd.com>
 <447afcd9-719a-bf86-64ee-af8e8a7c67dd@amd.com>
 <b2aad851-7a5a-c5ad-c4fb-315f7a5ef244@amd.com>
 <f6afd62e-21b5-42db-28f3-262980e86e17@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <f6afd62e-21b5-42db-28f3-262980e86e17@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: ed79c0c3-4fbb-4062-1778-08db0f599b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsx+LFs8/SJJZownhQti8CjJDlMlSx2dcGILpNssPrTBjRQ7SwieqTYIoGUKCmlyoZbkLZFyFZ10mKLC6fhWDqITf/uA3aibl9ziC46n5t0501p5EVV3R1w0//AdWT97wfa40auGr72xO9dT1jU7UA65ptuCTmTdyCiiTGvOP50vIMV4m2hza+ZFCKlA9i+9bPVC8hygfZb9JkSBhp/OkAlt5k8R7cZCkcUuicI/ttcyTCgCfBL1lrzB8cn3BSHlIM0utA5zOBBLN3GzEO+nz4ETMZu5OKvW6S6C3Z4xBHa/g5A1W3+P0CGHR7PuKkxUw5TT9fth/7VxhUhx568N+8hMqsoQaj+z5rAUUWZdrQ80E/E0aqBBqJm1QXz+NM/HFqP2mX5yAbUmALhJmheioD32k0z8m7OgBXDIAR093CkY+7QDixuFAHhC+Otvf50Aa+YquJmk422YtOV9y4mOx5xmaoRYaxpF7HynYKKbFQbiPK2uq9OZxy3pQbaTxa5Y2+7cPfFHwCyBhdXEh35/Eu2y5dKPhG0OAdXUjY7xNJv6NaiVLnocGfr4SyMgao+TKQccERZukKg4zEb/G0m0/6ZvEcp46Elr3EozYKQyL4I26/4PvOORWxCG5AsIdXlUbQ9KzW1YKwKgz4RPoTd2JlRJWnwgLORQ3yVNOIoUJkmVjuUAsbHool7+y71/FB9XnwUDB1Bym1aW7FRjAOKdOjiTwtQDgQU1xInli1jbCXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(53546011)(6506007)(6666004)(478600001)(186003)(6486002)(66476007)(66946007)(31686004)(8676002)(66556008)(4326008)(316002)(66574015)(41300700001)(83380400001)(8936002)(5660300002)(6512007)(2906002)(31696002)(38100700002)(86362001)(2616005)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC9rL2FoRThyWWM5c1htaXNWZWFsZkx0cHUvSm1XekNmOENmNmJoZTBiYThw?=
 =?utf-8?B?QjNqSVB1MGxmYzFRN0NzQXAxczNzaWtoZlNwWVNQU0xMMktmMmNiczRTYkFB?=
 =?utf-8?B?YXFna0ZFRk1xV1MwRlo4WlZQNEVGWTh1KzVZV1NwdGVlMnJnbGhpOEVGTVJo?=
 =?utf-8?B?SS8rL29zdk5oZ0hrOHJESTkrZXVONlJxRUpNYkdjNEFJbE5CUWhPaEczYnNj?=
 =?utf-8?B?Z2Z5U0cydEJINUMxODNpNlcwRTlpbXFKWGFjMkNZSWNFTy9TSUI5b3orM3dn?=
 =?utf-8?B?eHlaT0p1dGdaN2ZsMVZJMHNCYkJDanFwRmpRTVJBR0FIZFZTZDIvRVJvR1h4?=
 =?utf-8?B?K2tzL0tGSkhCUWtxM29RMUY3Y0UvWFlNZCs2eVkydEFlU3VEdE9nVHB1QjdE?=
 =?utf-8?B?cW5vVFdPQkFFOUpyUTJBSFpETWFQcVI0d2xNRE84VHVvUHc5dnBsazVTcTNi?=
 =?utf-8?B?YjZBaVUySlVCOXNCZVl3VmdYNDJpejhHSW92cGhOYUdyVTV1a0paT2FOSnhH?=
 =?utf-8?B?L3lxSkNleUFSbkdvUDROODRHTEoyT2w3eUVwT2NNNlZ4bllOcXRvdTVKK2Mv?=
 =?utf-8?B?b0E1SWFHcHgrVmVWOWdkMUJKMG9QeitMMnFkanZ5eVA0T3VONWExYWJpS0x4?=
 =?utf-8?B?eUxSTUNiMFhaTDdub3htUFdWcU5lMEp2Yjh1WVFoQmFhVHY4TnlUNnczUjFy?=
 =?utf-8?B?eFR4SERhdkNHTnBZbUVVdVVzenBwMmkyKzduN0xBZ2JHTFZYUlJmLzhzVkxF?=
 =?utf-8?B?Q1VZMkJDNm5yS0pCYVpvU09oYlBlaG1FMHh4blB0Vnp5REFtQSt1SkVFUlZl?=
 =?utf-8?B?dDJiV0hGT0RtZFA2LzN3dzFEbHRaQ201R3RhUUhNUDN5OWJjNGFVYVNTaVlo?=
 =?utf-8?B?QmJZTGxTUzNWREFMQTNTZUErdmFFWGQxdVk0V2dVa2hHUnNONGpPUVdwM3Jr?=
 =?utf-8?B?MGdIeUl4amtCWkJEaWFVSi9XUHM2dkhCTFpsK3pIUFBVRWpzc0g3UGdPQmdu?=
 =?utf-8?B?ZGFVM0NDelJ4ZmJUOFVud2g5MjR5VHhEQytiNjdDazd3d3dKUzJMeEd1TUIx?=
 =?utf-8?B?SWhpd0NFRDhkNVhCQ2RHQjBDZWZIcHQxaG1zRGY0dFBuTWFmdCtYOWxSYU1x?=
 =?utf-8?B?YTdObEdQRmg0em41d0F6dGVJcDU1aUhYNzlPdFBOUFZ0WG90M2N0QmN0cGsv?=
 =?utf-8?B?Rml3TXA4SllxWVZ2UlFkUWJ1UWhrQVVqaUF2anRTR0hJYXVaaXgxQ01ENGFU?=
 =?utf-8?B?b3U2bThaNzBONTh0LzRaZUFubERySTB6eklTb3FjT2lIY3FYL2xLTm1ONklU?=
 =?utf-8?B?QTFWVlNOTXJOWnJ2c25BVWNzS2Q2TTMwcFdRQjVrRGdyRTZOeE1CdGxESWxO?=
 =?utf-8?B?eEU4VUhYRXNqQTZIbTRCSVBoblRzcTRpbnltczZlVVByUDdLT0d2MmowQzdy?=
 =?utf-8?B?M2FDTHBhQkdQNTg2bzZRM0xyUEE2Z213MjIyYnVvN0J1NzNkQkwwZ3lzUHhh?=
 =?utf-8?B?TEFsUWRETlE4cys0SkZFczM1Y1NXRklJK0NmV2JTTnJiL0RuRXk2aFhPcEdV?=
 =?utf-8?B?UzQrMGhwVlg2VVlEOHFqbWRpa1hMN2QxWTZyRUVIdnROdjdjTFp5WWdyeGU5?=
 =?utf-8?B?NU1US3o4eWt3OWNBbDNCRWUyTHhMRDg5SFBVZnRzRkFFVkNaSmhzUEpzblNx?=
 =?utf-8?B?QWZMMXo3ZDM3UkxiRHUxd09JZ2ZuZTBpSTVpSThiTkdDOHcrWmtRRGhreHpT?=
 =?utf-8?B?V3hZMGt4WU1jY1FZTVVjOThGMjNHbjVVWTVZZXBzVTIxL2Ywb1RYRnR1VnRE?=
 =?utf-8?B?ZjN1cGFNZ0xlcEZoVHJmSXhXNXpGcWJ1WDJrTFV2L29GbHh6eTZKY0FjQ1BF?=
 =?utf-8?B?cVNaMFd2YzgrcWhSYmk0ZEZrRkkzck8xMFZiK0tENk94MThZN1pDRkxBTkYy?=
 =?utf-8?B?Vnlwa0ZaODRVVE1idXpRejZsQXN2WGM4R2Q3SnZ1dnE3Ni9WV1k0ZGwrTVBO?=
 =?utf-8?B?MVY5WmhtVkszU2lWbmVrdlU0VlArajUzdU9pWVFBUnpSVTU0KzdHazNTcVFB?=
 =?utf-8?B?SDlsZ090dUFPQ1pwVmwyZ2w5WlYyZHM0clFBREJBNk03VEtBZVFMNm1LeVpv?=
 =?utf-8?B?eElldUVTTFZ5RThtTk90eERmK3Y5aG9uazZ3UDViVTQ3NzF2MFNJNkRjekcw?=
 =?utf-8?Q?96X/yG+kEA4Quiaz7yxNkFQV2AFL2OngoYC+Qhg4sLEd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed79c0c3-4fbb-4062-1778-08db0f599b29
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 13:36:13.4599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxvvwxsQUFJeaoVyJkPZWh6dpCJDSPrqTJsaSBPUXtU8/OUjb1a3KpM327MDrPcK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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
Cc: alexander.deucher@amd.com, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.02.23 um 14:32 schrieb Shashank Sharma:
>
> On 15/02/2023 07:17, Christian König wrote:
>> Am 14.02.23 um 20:24 schrieb Shashank Sharma:
>>>
>>> On 14/02/2023 19:31, Christian König wrote:
>>>> Am 14.02.23 um 17:15 schrieb Shashank Sharma:
>>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>>
>>>>> This patch adds changes:
>>>>> - to accommodate the new GEM domain DOORBELL
>>>>> - to accommodate the new TTM PL DOORBELL
>>>>>
>>>>> to manage doorbell allocations as GEM Objects.
>>>>>
>>>>> V2: Addressed reviwe comments from Christian
>>>>>      - drop the doorbell changes for pinning/unpinning
>>>>>      - drop the doorbell changes for dma-buf map
>>>>>      - drop the doorbell changes for sgt
>>>>>      - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>>>>>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 ++++++++++-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 11 ++++++++++-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  1 +
>>>>>   3 files changed, 21 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> index b48c9fd60c43..ff9979fecfd2 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct 
>>>>> amdgpu_bo *abo, u32 domain)
>>>>>           c++;
>>>>>       }
>>>>>   +    if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
>>>>> +        places[c].fpfn = 0;
>>>>> +        places[c].lpfn = 0;
>>>>> +        places[c].mem_type = AMDGPU_PL_DOORBELL;
>>>>> +        places[c].flags = 0;
>>>>> +        c++;
>>>>> +    }
>>>>> +
>>>>
>>>> Mhm, do we need to increase AMDGPU_BO_MAX_PLACEMENTS?
>>>>
>>>> I think the answer is *no* since mixing DOORBELL with CPU, GTT or 
>>>> VRAM placement doesn't make sense, but do we enforce that somewhere?
>>> I am not sure why do we need that ?
>>
>> Userspace could otherwise specify DOORBEEL|CPU|GTT|VRAM as placement 
>> which would overrun the array and be illegal.
>
> Now when I understand this, how can we enforce this ? A size check 
> that blocks places to go over a certain value, which is fixed for 
> boorbell ?

In amdgpu_bo_create() we should have a check that if GDS, GWS, OA and 
DOORBELL are specified they are specified all alone. In other words 
those domains can't be mixed with anything else.

Christian.

>
>>
>>>>
>>>>>       if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>>>>           places[c].fpfn = 0;
>>>>>           places[c].lpfn = 0;
>>>>> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct 
>>>>> amdgpu_device *adev,
>>>>>           goto fail;
>>>>>       }
>>>>>   -    /* TODO add more domains checks, such as 
>>>>> AMDGPU_GEM_DOMAIN_CPU */
>>>>> +    /* TODO add more domains checks, such as 
>>>>> AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
>>>>
>>>> Should we enforce that user space can only allocate 1 page doorbells?
>>>>
>>> Should we add a per-PID basis check ?
>>
>> No, just a check that the allocation size of the doorbell BOs is just 
>> 1 page.
>
> Noted
>
> - Shashank
>
>>
>> Christian.
>>
>>>
>>> - Shashank
>>>
>>>>>       return true;
>>>>>     fail:
>>>>> @@ -1014,6 +1022,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>>>       } else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>>>>           atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>>>       }
>>>>> +
>>>>
>>>> Unrelated change.
>>>
>>> Noted
>>>
>>> - Shashank
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>   }
>>>>>     static const char *amdgpu_vram_names[] = {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> index 0e8f580769ab..e9dc24191fc8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct 
>>>>> ttm_buffer_object *bo,
>>>>>       case AMDGPU_PL_GDS:
>>>>>       case AMDGPU_PL_GWS:
>>>>>       case AMDGPU_PL_OA:
>>>>> +    case AMDGPU_PL_DOORBELL:
>>>>>           placement->num_placement = 0;
>>>>>           placement->num_busy_placement = 0;
>>>>>           return;
>>>>> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct 
>>>>> ttm_buffer_object *bo, bool evict,
>>>>>       if (old_mem->mem_type == AMDGPU_PL_GDS ||
>>>>>           old_mem->mem_type == AMDGPU_PL_GWS ||
>>>>>           old_mem->mem_type == AMDGPU_PL_OA ||
>>>>> +        old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>>           new_mem->mem_type == AMDGPU_PL_GDS ||
>>>>>           new_mem->mem_type == AMDGPU_PL_GWS ||
>>>>> -        new_mem->mem_type == AMDGPU_PL_OA) {
>>>>> +        new_mem->mem_type == AMDGPU_PL_OA ||
>>>>> +        new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>>>           /* Nothing to save here */
>>>>>           ttm_bo_move_null(bo, new_mem);
>>>>>           goto out;
>>>>> @@ -586,6 +589,11 @@ static int amdgpu_ttm_io_mem_reserve(struct 
>>>>> ttm_device *bdev,
>>>>>           mem->bus.offset += adev->gmc.vram_aper_base;
>>>>>           mem->bus.is_iomem = true;
>>>>>           break;
>>>>> +    case AMDGPU_PL_DOORBELL:
>>>>> +        mem->bus.offset = mem->start << PAGE_SHIFT;
>>>>> +        mem->bus.offset += adev->doorbell.doorbell_aper_base;
>>>>> +        mem->bus.is_iomem = true;
>>>>> +        break;
>>>>>       default:
>>>>>           return -EINVAL;
>>>>>       }
>>>>> @@ -1267,6 +1275,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct 
>>>>> ttm_tt *ttm, struct ttm_resource *mem)
>>>>>           flags |= AMDGPU_PTE_VALID;
>>>>>         if (mem && (mem->mem_type == TTM_PL_TT ||
>>>>> +            mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>>               mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>>>           flags |= AMDGPU_PTE_SYSTEM;
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> index 967b265dbfa1..9cf5d8419965 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> @@ -33,6 +33,7 @@
>>>>>   #define AMDGPU_PL_GWS        (TTM_PL_PRIV + 1)
>>>>>   #define AMDGPU_PL_OA        (TTM_PL_PRIV + 2)
>>>>>   #define AMDGPU_PL_PREEMPT    (TTM_PL_PRIV + 3)
>>>>> +#define AMDGPU_PL_DOORBELL    (TTM_PL_PRIV + 4)
>>>>>     #define AMDGPU_GTT_MAX_TRANSFER_SIZE    512
>>>>>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS    2
>>>>
>>

