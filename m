Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8931C636D4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 13:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4727710E147;
	Wed, 15 Feb 2023 13:46:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7343810E147
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 13:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0kE60aA+H5zOFsF4h9dg7KMZVZHWG2PbPI3tsCnNVIYdfzxlTEZxykHhVrliCjS9vdS2xAloTUwULpwPHOIAeVi4c4LIgJi1Q9MQLIZqQMSndYutenKkExEu6IKWSgLrL0gD+5wujWgGETErd0HjcvutdLIYAaYUBrtxpnX3N58Z5HYnl0Gf/+anavIXnbL1pL2xYa+KwU39gWpoOtinj/Gzv8bpJN6zPxMiEiecnW3+Cs2Itl9oJsSH/1rOap7yQRm92CYmyfWcqLCd7xPUIK4DK9uBM++5b3mddas/yT4zMzcOCKF2C0WJ4tSzXsTMtPEtKX1Skz3V9+JE3LNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkbArhaOLvYxwTAXENvTPPVewNRFGtKGGhknnTgf4YA=;
 b=niE0hkPc+qsW3J7g9EW2l3af4m3zG7Rnj8FmQ+fPU7nKo2OO6bbGYhvy8IGcCXk25F8iEC+bxpfyob178OADBZs4TRzkY7i5FYOkN/eI9QnzEd/pkEVd0CANZpXtX1jp1W9bM78zGAIP0+bjfnc/ChNJ2qWIeEy5QdIgb+JHWhZeKbvdLckkX8xreYPE/iX9UB1J2G49FDRoGNUddGn3vNGgDvuWHQ4ujfTS7lxMbDqaDDnqbm7ykUZ4mxnaZpeoeS5awf5uUiWp2Bp0bKQaXeht9q2TeBCQ+sisHJ106T0VEfGDTxkJG2oMxxVC97ZUdCuIlS+oNY943TYlTHRnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkbArhaOLvYxwTAXENvTPPVewNRFGtKGGhknnTgf4YA=;
 b=qZI9STmqNfmh+p/TVgK2YptD8UYTVnJ1HDBsMdLHqT/CCRZxa1XLsZWCha3oO1TxJMk3gsAjvVFgJdFOmncrlPmqns7zMUuiEi5NNS0+ak/r9nnJNZicF9ys4x1mKqSCEOaUk42vnSDoAhJUmavDdeOETMm2jVg8s2j9SCCZ1F4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 13:46:02 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 13:46:02 +0000
Message-ID: <0dc4e7d6-86cd-43ae-5fe0-a8d6bbfadbc3@amd.com>
Date: Wed, 15 Feb 2023 14:45:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/8] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-6-shashank.sharma@amd.com>
 <7cfbd8c6-7865-2fe3-ac93-d3b264f2b4ab@amd.com>
 <447afcd9-719a-bf86-64ee-af8e8a7c67dd@amd.com>
 <b2aad851-7a5a-c5ad-c4fb-315f7a5ef244@amd.com>
 <f6afd62e-21b5-42db-28f3-262980e86e17@amd.com>
 <a2445303-9238-f221-178c-025ceb2ad2f5@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <a2445303-9238-f221-178c-025ceb2ad2f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 94df50a5-5b65-41bf-c561-08db0f5af9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZKAINXjF8KarHTHRxawIfd1DDQsVpUDbv9/McpQbDXv5gpSzTv6DP35/vYOS8nAxKfEiC+FtzuzeR2yqPflgvlvnmAaFsJmVL07j2AzVk9CyxSQX1mCTNNrvXoogFZQAXZJrvkJgQwPsiJky2ZiVoNvgpHoUh8sq49ptsl6BIOyWcHINj73cj2lcQq2R1pDiTFINeKaeUXO4e6EkHNEdu4cCRHWIZuJLWMUrSIMbN3PfPVVIE5cfUxY2Z++r+rNFugB12GU+mSZeRd6ZkGy+SGoayKVM/sxoLRt28K1CXeQ8W5S2b75AAirPohFgsfMoowcm830zCqEJ9DQ0xxWUzrGBeXAUJyV3RkkJYfc0w0ab/IRCv0VTbdr6cXcRfRJYIDPjGY/HhCejxP1u/FFxbOLqK+ED2cTzTRBhSsUEWzV4sU5tqSszhzY6UbfA1WvU5C8tY/Nm6pUpQ1jm7D+SKJWHvem+AnPa6nbubLtGmB3b9TyxLd9Ey8cYKVi5cDrvHgD6Fj/OMXEhc+XXObISzH6xyNEUpv1hi+ehmmKLFnoj977Q3ReWJmKQWgHkyeviS/ZuA3XVBrsJp1opZzmGDzEpoIftWclkl9KrD3ZG77cUZH6mzBNUJtLj8mrYGqWkHMhdLolgNLShlyyQVxs2jDdrMjkwVeNihkUO7HZI48EhEBNlPHjXIUm/u+E/5nijBqzgkcOZ2o+ZGny3d+eDoATsJh/D3jw/yJXvIIeLdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199018)(36756003)(8936002)(44832011)(8676002)(4326008)(66476007)(66946007)(31696002)(38100700002)(478600001)(6486002)(5660300002)(41300700001)(186003)(26005)(316002)(6506007)(6666004)(6512007)(53546011)(66556008)(83380400001)(31686004)(2906002)(86362001)(66574015)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVo5UDNFNjQrUzd3WWdOYkw2dTQrbzBjVkNHMnFnYllCeDl3TTR6SmpzbW92?=
 =?utf-8?B?VmI4enJQUnBsWHlBS3FmSDRvdXN4YnZGODB6a0FETEZENmg3bEh5SzBnZGUw?=
 =?utf-8?B?RU5MeHQzbExwWkFaUm80MmZyU1V3bGtGdEppaXcyTUZBUDZrMWNmVjZMbUQ0?=
 =?utf-8?B?U0E5cENGZEVXMEEvbGwyc1IyQWxNSGZHS1cyUE9GQWJuR0l6Vng0bDFCRUdh?=
 =?utf-8?B?bCt3OVdRa1JuUHRValMwS3JjRDBCZXBQREN4dnROeUhwb0ppN3I0dFdOdUtS?=
 =?utf-8?B?Y3VXaURWU1luU2ZGenVML2FJa3Z5VkJBR3JISjZZUWlkMWVMUW9NM0V0TUdY?=
 =?utf-8?B?MXo0UGFzWGFHSXBhYjMxbUwxbEZwbDIxOVJpVWlmaXM0bVc0REx3b1lOWkVG?=
 =?utf-8?B?TUt1QkM2ZlpucjhTZGNrUklyS1BzM3c0ZktHanhLYUszTTkyZ2JoR2dqNlVi?=
 =?utf-8?B?TGVHaWN5WkI2bTg5VWRYT2JHMERrZXM3NWpRVlFVUCtpWlg5Z0puSDllK2Qw?=
 =?utf-8?B?ZFN4SFNCZ2R4WWJUcTYvaUM1ZXk4R1UwQXFnSHZDVW00eDB5bnc4eHQxUkJw?=
 =?utf-8?B?dGFURFE1akxhLzI3NUxCa2ROdnZVaFFyVFJ6Q3dyTWFUb3NONStINVAwUzNG?=
 =?utf-8?B?YXpjMEVjcTI0MG1uWjhuOUNOY2sxMnk4bEZXcnZDKzBlU1pYaUdicTVLRXln?=
 =?utf-8?B?K0ttZ3VBcUhybHFodlhpYlpSOWRFMVo3bndyMjJ6c1V3K0JSaDBYNTgxRHhw?=
 =?utf-8?B?UVNqSG51TnRDVGxKdjRYSjJwbGtPSFR0bXBHamp1VUxJN3NvVWYzdkZEYkRF?=
 =?utf-8?B?NWptM1NlUUN1SDBGQ2l4L055YitRdzNNVTVPenlIdjhUY2pIeVZyWDRxWVVa?=
 =?utf-8?B?UllwbU5JdEJ3TkRXY2VwbjEyS0NJeEtRSmV1WDlDR2NscGlnWkJsaDdaSCti?=
 =?utf-8?B?cnk4NENVRXV0bDRkN3Fpc2M1T3RzYkpVdXVwYngwbmpOcTd0RXp4ZERnN3RH?=
 =?utf-8?B?Uko0NUhIQkZBcFJSRnVDWEtKYm5CTi81ZEpmV3QyTDlRYUtQT3ZLUlA4T0tK?=
 =?utf-8?B?MnlOTThNcytzbk11K3kzR0NacWY0VVl6c0xvWkt0bFhvWU5pTXNCUndYeG0x?=
 =?utf-8?B?cWNWYVIxOGVCOVBKcHlaeE9YbHd6dUE4bEtuNytyVEtZZUw2N05yY1ZKYkov?=
 =?utf-8?B?ZzEzSytsNUxuZVFLeEppNUlGOG5BdHM0Z1hRT1RwdDlqVW1wN0JSUFVnUXYy?=
 =?utf-8?B?U295dWRVeFk1a250d0V1WVdFQUFLLzZxMXNZRmIyVExxeCs0Z1lkKy9HYm9U?=
 =?utf-8?B?UmpoWHBBcWgzR2xDaTZTK1pjclRFMDB2K2lEMitQVldTVnRIN0NIc0hSc2Ew?=
 =?utf-8?B?dTZwaUhINXNBVURDRS92YWF3N2xWZ2lvTUJHTWNvbi81aEtPSy9KWGJFZm1Q?=
 =?utf-8?B?anNJcXI5VjJZVGJYY1FoK0pYb3BGV0VvemJUeUpsTG9xbHByWWJxQkVjemJj?=
 =?utf-8?B?YnFJK01kcGFmTTlMTzd0UWNWUG1vMCt2ekpyUWFsNXE4ZXFzSTRyTTJVUFNG?=
 =?utf-8?B?d2hPYkFETnpmdk5qMktRTUlyRnVIYUl4YjFIWVBrbHdoR1lFaE5kR3c2VGwr?=
 =?utf-8?B?dGRsUkxZUUNsQks4NHA4dkJKUVVoY2ZLb3FzUG1sQ0VXdzd1Uks5MTNISHBD?=
 =?utf-8?B?eDdWckpKSmRKWWxKWUZlM1FFbHhKbWlqVG15NE1ZbklvcndzQlFBSVU0MnlL?=
 =?utf-8?B?eDA5OWhTL3lHbkRXejY2aU1nZjFOTFRVakVWdWs2TXF5akw5T0NZakV4U2Zt?=
 =?utf-8?B?UHlKdlp4NS96QkxmY2dsb0p2cnc5S2xJUGVRT0xVa05sa2pUY1RXVm5hSDZj?=
 =?utf-8?B?ditTT0Z0Z1dDand3dGtiLzFSZ2UyY1FhVzE4U3ZkUXNaeE0yV2J5L3laN2JB?=
 =?utf-8?B?S3ZpL3VPV2JVSkJPZHRrQVlOUzRkWnFLanNLZStldEwzajE3SFIxMFVLSE0x?=
 =?utf-8?B?aTZFOWtwbzVyekRHSzBUbUxOL3RvSGp1Y0kzZy9CM2l4aHY5cHBkZVk5SUdP?=
 =?utf-8?B?YzBQR2VrWmVCNGQwcEg3YUx0azExaDExNk9rcHJjL21FRUUzUUdicWRlRG1t?=
 =?utf-8?Q?zHG3vyHfkQqQg8NsSn5Fjl84p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94df50a5-5b65-41bf-c561-08db0f5af9da
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 13:46:01.9342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95mFwWuFLmlhBB24+Ao8wmL92ofxNHoKK1CFrlHBagyIAONOBGqgdqq7UD6Glnfv9psB7Nkbt0hScfgQDdzQ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
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


On 15/02/2023 14:36, Christian König wrote:
> Am 15.02.23 um 14:32 schrieb Shashank Sharma:
>>
>> On 15/02/2023 07:17, Christian König wrote:
>>> Am 14.02.23 um 20:24 schrieb Shashank Sharma:
>>>>
>>>> On 14/02/2023 19:31, Christian König wrote:
>>>>> Am 14.02.23 um 17:15 schrieb Shashank Sharma:
>>>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>>>
>>>>>> This patch adds changes:
>>>>>> - to accommodate the new GEM domain DOORBELL
>>>>>> - to accommodate the new TTM PL DOORBELL
>>>>>>
>>>>>> to manage doorbell allocations as GEM Objects.
>>>>>>
>>>>>> V2: Addressed reviwe comments from Christian
>>>>>>      - drop the doorbell changes for pinning/unpinning
>>>>>>      - drop the doorbell changes for dma-buf map
>>>>>>      - drop the doorbell changes for sgt
>>>>>>      - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>>>>>>
>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 ++++++++++-
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 11 ++++++++++-
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  1 +
>>>>>>   3 files changed, 21 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> index b48c9fd60c43..ff9979fecfd2 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct 
>>>>>> amdgpu_bo *abo, u32 domain)
>>>>>>           c++;
>>>>>>       }
>>>>>>   +    if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
>>>>>> +        places[c].fpfn = 0;
>>>>>> +        places[c].lpfn = 0;
>>>>>> +        places[c].mem_type = AMDGPU_PL_DOORBELL;
>>>>>> +        places[c].flags = 0;
>>>>>> +        c++;
>>>>>> +    }
>>>>>> +
>>>>>
>>>>> Mhm, do we need to increase AMDGPU_BO_MAX_PLACEMENTS?
>>>>>
>>>>> I think the answer is *no* since mixing DOORBELL with CPU, GTT or 
>>>>> VRAM placement doesn't make sense, but do we enforce that somewhere?
>>>> I am not sure why do we need that ?
>>>
>>> Userspace could otherwise specify DOORBEEL|CPU|GTT|VRAM as placement 
>>> which would overrun the array and be illegal.
>>
>> Now when I understand this, how can we enforce this ? A size check 
>> that blocks places to go over a certain value, which is fixed for 
>> boorbell ?
>
> In amdgpu_bo_create() we should have a check that if GDS, GWS, OA and 
> DOORBELL are specified they are specified all alone. In other words 
> those domains can't be mixed with anything else.
>
> Christian.
>
Got it, let me check this out.

- Shashank

>>
>>>
>>>>>
>>>>>>       if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>>>>>           places[c].fpfn = 0;
>>>>>>           places[c].lpfn = 0;
>>>>>> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct 
>>>>>> amdgpu_device *adev,
>>>>>>           goto fail;
>>>>>>       }
>>>>>>   -    /* TODO add more domains checks, such as 
>>>>>> AMDGPU_GEM_DOMAIN_CPU */
>>>>>> +    /* TODO add more domains checks, such as 
>>>>>> AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
>>>>>
>>>>> Should we enforce that user space can only allocate 1 page doorbells?
>>>>>
>>>> Should we add a per-PID basis check ?
>>>
>>> No, just a check that the allocation size of the doorbell BOs is 
>>> just 1 page.
>>
>> Noted
>>
>> - Shashank
>>
>>>
>>> Christian.
>>>
>>>>
>>>> - Shashank
>>>>
>>>>>>       return true;
>>>>>>     fail:
>>>>>> @@ -1014,6 +1022,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>>>>       } else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>>>>>           atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>>>>       }
>>>>>> +
>>>>>
>>>>> Unrelated change.
>>>>
>>>> Noted
>>>>
>>>> - Shashank
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>   }
>>>>>>     static const char *amdgpu_vram_names[] = {
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> index 0e8f580769ab..e9dc24191fc8 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct 
>>>>>> ttm_buffer_object *bo,
>>>>>>       case AMDGPU_PL_GDS:
>>>>>>       case AMDGPU_PL_GWS:
>>>>>>       case AMDGPU_PL_OA:
>>>>>> +    case AMDGPU_PL_DOORBELL:
>>>>>>           placement->num_placement = 0;
>>>>>>           placement->num_busy_placement = 0;
>>>>>>           return;
>>>>>> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct 
>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>       if (old_mem->mem_type == AMDGPU_PL_GDS ||
>>>>>>           old_mem->mem_type == AMDGPU_PL_GWS ||
>>>>>>           old_mem->mem_type == AMDGPU_PL_OA ||
>>>>>> +        old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>>>           new_mem->mem_type == AMDGPU_PL_GDS ||
>>>>>>           new_mem->mem_type == AMDGPU_PL_GWS ||
>>>>>> -        new_mem->mem_type == AMDGPU_PL_OA) {
>>>>>> +        new_mem->mem_type == AMDGPU_PL_OA ||
>>>>>> +        new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>>>>           /* Nothing to save here */
>>>>>>           ttm_bo_move_null(bo, new_mem);
>>>>>>           goto out;
>>>>>> @@ -586,6 +589,11 @@ static int amdgpu_ttm_io_mem_reserve(struct 
>>>>>> ttm_device *bdev,
>>>>>>           mem->bus.offset += adev->gmc.vram_aper_base;
>>>>>>           mem->bus.is_iomem = true;
>>>>>>           break;
>>>>>> +    case AMDGPU_PL_DOORBELL:
>>>>>> +        mem->bus.offset = mem->start << PAGE_SHIFT;
>>>>>> +        mem->bus.offset += adev->doorbell.doorbell_aper_base;
>>>>>> +        mem->bus.is_iomem = true;
>>>>>> +        break;
>>>>>>       default:
>>>>>>           return -EINVAL;
>>>>>>       }
>>>>>> @@ -1267,6 +1275,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct 
>>>>>> ttm_tt *ttm, struct ttm_resource *mem)
>>>>>>           flags |= AMDGPU_PTE_VALID;
>>>>>>         if (mem && (mem->mem_type == TTM_PL_TT ||
>>>>>> +            mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>>>               mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>>>>           flags |= AMDGPU_PTE_SYSTEM;
>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>> index 967b265dbfa1..9cf5d8419965 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>> @@ -33,6 +33,7 @@
>>>>>>   #define AMDGPU_PL_GWS        (TTM_PL_PRIV + 1)
>>>>>>   #define AMDGPU_PL_OA        (TTM_PL_PRIV + 2)
>>>>>>   #define AMDGPU_PL_PREEMPT    (TTM_PL_PRIV + 3)
>>>>>> +#define AMDGPU_PL_DOORBELL    (TTM_PL_PRIV + 4)
>>>>>>     #define AMDGPU_GTT_MAX_TRANSFER_SIZE    512
>>>>>>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS    2
>>>>>
>>>
>
